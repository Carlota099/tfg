pragma solidity ^0.8.0;

contract DateConverter {
    
    function convertToTimestamp(uint256 year, uint256 month, uint256 day) public pure returns (uint256) {
        require(year >= 1970, "Year must be greater than or equal to 1970");
        require(month >= 1 && month <= 12, "Month must be between 1 and 12");
        require(day >= 1 && day <= 31, "Day must be between 1 and 31");

        uint256 secondsInDay = 86400; // 24 * 60 * 60
        uint256[] memory daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        
        // Verifica si el año es bisiesto
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
            daysInMonth[1] = 29; // Si es bisiesto, febrero tiene 29 días
        }
        
        // Verifica que el día ingresado sea válido para el mes dado
        require(day <= daysInMonth[month - 1], "Invalid day for the given month");

        // Calcula la marca de tiempo Unix
        uint256 timestamp = 0;
        for (uint256 i = 1970; i < year; i++) {
            if ((i % 4 == 0 && i % 100 != 0) || i % 400 == 0) {
                timestamp += 31622400; // Año bisiesto tiene 366 días (31622400 segundos)
            } else {
                timestamp += 31536000; // Año no bisiesto tiene 365 días (31536000 segundos)
            }
        }
        
        for (uint256 i = 1; i < month; i++) {
            timestamp += daysInMonth[i - 1] * secondsInDay;
        }

        timestamp += (day - 1) * secondsInDay;

        return timestamp;
    }
}
