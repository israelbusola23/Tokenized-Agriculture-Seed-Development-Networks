# Tokenized Agriculture Seed Development Networks

A comprehensive blockchain-based system for managing seed development, testing, evaluation, and licensing using Clarity smart contracts on the Stacks blockchain.

## Overview

This project implements a decentralized network for agriculture seed development that provides transparency, traceability, and trust in the seed development process. The system consists of five interconnected smart contracts that manage the entire lifecycle of seed development from company verification to commercial licensing.

## System Architecture

### Smart Contracts

1. **Seed Company Verification** (`seed-company-verification.clar`)
    - Manages registration and verification of seed development companies
    - Provides trust layer for the network
    - Only verified companies can participate in advanced features

2. **Variety Tracking** (`variety-tracking.clar`)
    - Tracks seed variety development and lineage
    - Manages development stages (research → development → testing → commercial)
    - Maintains genetic lineage and trait information

3. **Field Testing** (`field-testing.clar`)
    - Manages field testing processes and results
    - Tracks testing locations, conditions, and outcomes
    - Stores performance data from real-world testing

4. **Performance Evaluation** (`performance-evaluation.clar`)
    - Evaluates seed performance across multiple metrics
    - Aggregates performance data for decision making
    - Provides scoring system for variety comparison

5. **Licensing Management** (`licensing-management.clar`)
    - Manages licensing agreements between parties
    - Tracks royalty payments and licensing terms
    - Supports different license types (exclusive, non-exclusive, research)

## Features

### Core Functionality

- **Company Verification**: Secure registration and verification process for seed companies
- **Variety Lineage**: Complete tracking of genetic lineage and development history
- **Field Testing**: Comprehensive testing management with location and condition tracking
- **Performance Metrics**: Multi-dimensional evaluation system for seed varieties
- **Licensing System**: Flexible licensing with automated royalty tracking

### Key Benefits

- **Transparency**: All development stages are recorded on-chain
- **Traceability**: Complete lineage tracking from parent varieties to commercial seeds
- **Trust**: Verified companies and authenticated testing results
- **Efficiency**: Automated licensing and royalty management
- **Compliance**: Immutable records for regulatory compliance

## Getting Started

### Prerequisites

- Stacks blockchain development environment
- Clarity CLI tools
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd seed-development-network
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

Deploy contracts to Stacks blockchain:

\`\`\`bash
# Deploy in order due to dependencies
clarinet deploy seed-company-verification
clarinet deploy variety-tracking
clarinet deploy field-testing
clarinet deploy performance-evaluation
clarinet deploy licensing-management
\`\`\`

## Usage Examples

### Register a Seed Company

\`\`\`clarity
(contract-call? .seed-company-verification register-company "AgroTech Seeds Inc.")
\`\`\`

### Register a New Variety

\`\`\`clarity
(contract-call? .variety-tracking register-variety
"SuperCorn-X1"
u1
none
"High yield, drought resistant, pest resistant")
\`\`\`

### Start Field Testing

\`\`\`clarity
(contract-call? .field-testing start-field-test
u1
"Iowa Test Farm A"
"Standard soil, moderate rainfall")
\`\`\`

### Submit Performance Evaluation

\`\`\`clarity
(contract-call? .performance-evaluation submit-evaluation
u1 u88 u85 u90 u87 u92
"Excellent variety with high commercial potential")
\`\`\`

### Create License Agreement

\`\`\`clarity
(contract-call? .licensing-management create-license
u1
'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG
"non-exclusive"
u5
"North America"
u1000)
\`\`\`

## Testing

The project includes comprehensive test suites for all contracts:

- **Unit Tests**: Individual contract function testing
- **Integration Tests**: Cross-contract interaction testing
- **Edge Cases**: Error handling and boundary condition testing

Run tests with:
\`\`\`bash
npm test
\`\`\`

## Contract Interactions

### Data Flow

1. **Company Registration**: Companies register and get verified
2. **Variety Development**: Verified companies register new varieties
3. **Field Testing**: Varieties undergo field testing with recorded results
4. **Performance Evaluation**: Multiple evaluators assess variety performance
5. **Licensing**: Successful varieties are licensed for commercial use

### Security Features

- **Access Control**: Function-level authorization checks
- **Data Validation**: Input validation and range checking
- **State Management**: Consistent state updates across contracts
- **Error Handling**: Comprehensive error codes and messages

## API Reference

### Read-Only Functions

- `get-company(company-id)`: Retrieve company information
- `get-variety(variety-id)`: Get variety details and development stage
- `get-field-test(test-id)`: Retrieve field test information
- `get-evaluation(evaluation-id)`: Get performance evaluation
- `get-license(license-id)`: Retrieve license agreement details

### Public Functions

- `register-company(name)`: Register new seed company
- `verify-company(company-id)`: Verify company (owner only)
- `register-variety(...)`: Register new seed variety
- `start-field-test(...)`: Begin field testing
- `submit-evaluation(...)`: Submit performance evaluation
- `create-license(...)`: Create licensing agreement

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions and support:
- Create an issue in the repository
- Contact the development team
- Check the documentation wiki

## Roadmap

### Phase 1 (Current)
- ✅ Core contract development
- ✅ Basic testing framework
- ✅ Documentation

### Phase 2 (Planned)
- [ ] Web interface development
- [ ] Advanced analytics
- [ ] Mobile application

### Phase 3 (Future)
- [ ] IoT integration for automated testing
- [ ] AI-powered performance prediction
- [ ] Cross-chain compatibility

## Acknowledgments

- Stacks blockchain community
- Agriculture industry partners
- Open source contributors
