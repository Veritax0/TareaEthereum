// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SistemaVotacion {
    address public admin;
    uint public tiempoDespliegue;
    uint public constant diasVotacion = 3 days;

    struct Propuesta {
        string nombre;
        uint votos;
    }

    mapping(address => bool) public listaVotantes;
    mapping(address => bool) public haVotado;
    mapping(string => Propuesta) public propuestas;


    
    constructor() {
        admin = msg.sender;
        tiempoDespliegue = block.timestamp;
    }

    modifier soloAdmin() {
        require(msg.sender == admin, "Solo el Admin del contrato puede realizar esta accion");
        _;
    }

    modifier soloEnListaVotantes() {
        require(listaVotantes[msg.sender], "Direccion no esta en la lista blanca");
        _;
    }

    modifier durantePeriodoVotacion() {
        require(block.timestamp <= tiempoDespliegue + diasVotacion, "El periodo de votacion ha terminado");
        _;
    }

    function agregarAListaBlanca(address[] memory direcciones) public soloAdmin {
        for (uint i = 0; i < direcciones.length; i++) {
            listaVotantes[direcciones[i]] = true;
        }
    }

    function eliminarDeListaBlanca(address direccion) public soloAdmin {
        listaVotantes[direccion] = false;
    }

    function agregarPropuesta(string memory nombre) public soloAdmin {
        bytes memory lowercaseName = bytes(nombre);
        for (uint i = 0; i < lowercaseName.length; i++) {
            lowercaseName[i] = _toLower(lowercaseName[i]);
        }
        string memory nombreLowercase = string(lowercaseName);
        
        require(bytes(propuestas[nombreLowercase].nombre).length == 0, "La propuesta ya existe");
        propuestas[nombreLowercase] = Propuesta(nombreLowercase, 0);
    }


    function obtenerVotosPropuesta(string memory nombrePropuesta) public view returns (uint) {
        bytes memory lowercaseProp = bytes(nombrePropuesta);
        for (uint i = 0; i < lowercaseProp.length; i++) {
            lowercaseProp[i] = _toLower(lowercaseProp[i]);
        }
        string memory propuesta = string(lowercaseProp);
        return propuestas[propuesta].votos;
    }

    function votar(string memory nombrePropuesta) public soloEnListaVotantes durantePeriodoVotacion {
        require(!haVotado[msg.sender], "La direccion ya ha votado");
        
        bytes memory lowercaseName = bytes(nombrePropuesta);
        for (uint i = 0; i < lowercaseName.length; i++) {
            lowercaseName[i] = _toLower(lowercaseName[i]);
        }
        
        require(bytes(propuestas[string(lowercaseName)].nombre).length > 0, "La propuesta no fue encontrada");
        propuestas[string(lowercaseName)].votos++;
        haVotado[msg.sender] = true;
    }

    function _toLower(bytes1 _b1) private pure returns (bytes1) {
        if (_b1 >= bytes1(uint8(65)) && _b1 <= bytes1(uint8(90))) {
            return bytes1(uint8(_b1) + 32);
        }
        return _b1;
    }


}
