# Tokenized Marketing Influencer Campaign Management

A comprehensive blockchain-based system for managing influencer marketing campaigns using Clarity smart contracts on the Stacks blockchain.

## Overview

This system provides a decentralized platform for marketing departments and social media influencers to collaborate on campaigns with automated verification, performance tracking, and payment processing.

## Smart Contracts

### 1. Marketing Department Verification (`marketing-department-verification.clar`)
- Verifies and manages marketing departments
- Stores department information and contact details
- Provides verification status checking

**Key Functions:**
- `verify-department`: Verify a marketing department
- `is-department-verified`: Check verification status
- `get-department-info`: Retrieve department information

### 2. Influencer Verification (`influencer-verification.clar`)
- Manages influencer verification and profiles
- Tracks follower counts and platform information
- Categorizes influencers by content type

**Key Functions:**
- `verify-influencer`: Verify an influencer with profile data
- `is-influencer-verified`: Check influencer verification status
- `update-follower-count`: Update influencer metrics

### 3. Campaign Coordination (`campaign-coordination.clar`)
- Creates and manages marketing campaigns
- Handles influencer participation
- Tracks campaign lifecycle

**Key Functions:**
- `create-campaign`: Create a new marketing campaign
- `join-campaign`: Allow influencers to join campaigns
- `end-campaign`: Close completed campaigns

### 4. Performance Tracking (`performance-tracking.clar`)
- Monitors campaign performance metrics
- Sets and tracks performance milestones
- Calculates performance scores

**Key Functions:**
- `set-performance-targets`: Define campaign goals
- `update-performance`: Record campaign metrics
- `calculate-performance-score`: Compute performance ratings

### 5. Payment Automation (`payment-automation.clar`)
- Automates payment processing
- Handles base payments and performance bonuses
- Manages fund deposits and withdrawals

**Key Functions:**
- `set-payment-schedule`: Define payment terms
- `process-payment`: Execute automated payments
- `deposit-funds`: Add funds to contract

## Getting Started

### Prerequisites
- Stacks blockchain development environment
- Clarity CLI tools
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd tokenized-marketing-contracts
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Usage Example

1. **Verify a Marketing Department:**
   \`\`\`clarity
   (contract-call? .marketing-department-verification verify-department
   'SP1234... "Acme Marketing" "contact@acme.com")
   \`\`\`

2. **Verify an Influencer:**
   \`\`\`clarity
   (contract-call? .influencer-verification verify-influencer
   'SP5678... "@influencer" "Instagram" u50000 "Fashion")
   \`\`\`

3. **Create a Campaign:**
   \`\`\`clarity
   (contract-call? .campaign-coordination create-campaign
   'SP1234... "Summer Fashion Campaign" "Promote summer collection" u10000 u1000)
   \`\`\`

4. **Track Performance:**
   \`\`\`clarity
   (contract-call? .performance-tracking update-performance
   u1 'SP5678... u25000 u1500 u75 u850)
   \`\`\`

5. **Process Payment:**
   \`\`\`clarity
   (contract-call? .payment-automation process-payment u1 'SP5678... true)
   \`\`\`

## Architecture

The system follows a modular architecture with separate contracts for different concerns:

- **Verification Layer**: Ensures only verified parties participate
- **Campaign Management**: Handles campaign lifecycle
- **Performance Tracking**: Monitors and evaluates results
- **Payment Processing**: Automates compensation

## Security Features

- Owner-only administrative functions
- Input validation and error handling
- Secure fund management
- Milestone-based payments

## Testing

The project includes comprehensive tests using Vitest:

\`\`\`bash
npm run test
\`\`\`

Tests cover:
- Contract deployment and initialization
- Verification processes
- Campaign creation and management
- Performance tracking
- Payment automation

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions or support, please open an issue in the repository or contact the development team.
