# Formal Verification of a Key-Transformation Protocol

This repository contains formal models for verifying security properties of a key-transformation protocol based on OPAQUE. We use ProVerif, a symbolic model checker, to analyze various security properties including key secrecy, authentication, and forward secrecy.

## Project Overview

In this project, we model a key-transformation protocol where a secret key K is transformed into K' (via a function F) before transmission. We formally verify that this transformation does not leak the original key K to an attacker, even under various threat models.

The project builds progressively more complex models:
1. Basic key transformation
2. Addition of authentication mechanisms
3. Session key derivation
4. Forward secrecy testing
5. Full OPAQUE protocol implementation with OPRF (Oblivious Pseudorandom Function)

## Repository Structure

### ProVerif Models

- **key_transformation_simple.pv**: Basic model verifying key secrecy
- **key_transformation_auth.pv**: Model with authentication properties
- **key_transformation.pv**: Model with additional cryptographic operations
- **key_transformation_complete.pv**: Comprehensive model with authentication and session key derivation
- **key_transformation_improved.pv**: Enhanced model with nonces and secure channels
- **key_transformation_forward_secrecy.pv**: Model testing forward secrecy properties
- **opaque_simple.pv**: Simplified OPAQUE protocol model
- **opaque_forward_secrecy.pv**: OPAQUE model testing forward secrecy
- **opaque_authenticated.pv**: Complete OPAQUE model with 3DH key exchange

### Results Files

For each model, there is a corresponding `*_results.txt` file containing the verification output from ProVerif:
- **key_transformation_simple_results.txt**
- **key_transformation_auth_results.txt**
- And so on...

### Utility Scripts

- **run_verification.sh**: Batch script to run ProVerif on all .pv files and save results
- **convert_pv_to_txt.sh**: Script to convert ProVerif models to readable text files with line numbers

### Documentation

- **verification_summary.txt**: Summary of verification results for all models
- **conversion_log.txt**: Log of model file conversions

## Security Properties Verified

Our models verify the following security properties:

1. **Key Secrecy**: The original key K remains secret even when K' is transmitted
2. **Authentication**: Verification that messages come from legitimate participants
3. **Session Key Security**: Derived session keys remain secure for encrypted communications
4. **Forward Secrecy**: Testing whether compromising long-term keys can reveal past communications

## How to Run

### Prerequisites

- ProVerif (tested with version 2.02)
- Bash shell environment

### Running Verification

To run verification on all ProVerif models:

```bash
./run_verification.sh
```

This will:
1. Process all .pv files in the current directory
2. Run ProVerif to verify each model
3. Save results to corresponding *_results.txt files
4. Generate a verification_summary.txt with an overview of results

### Converting Models to Readable Format

To convert ProVerif models to readable text files with line numbers:

```bash
./convert_pv_to_txt.sh
```

This generates *_code.txt files containing the models with line numbers and summary information.

## Verification Results

Our verification shows:
- Basic models successfully verify key secrecy
- Authentication models correctly verify message authenticity
- Forward secrecy fails as expected when long-term keys are compromised
- The full OPAQUE model with proper authentication successfully preserves all security properties

## Authors

- Cohen Powell (cthomasp@unc.edu)
- Rital Patel (rspatell@unc.edu)

## Acknowledgments

This project was developed for COMP 637 (590/790-132) - Spring 2025

## References

- S. Jarecki, H. Krawczyk, and J. Xu, "OPAQUE: An Asymmetric PAKE Protocol Secure Against Pre-Computation Attacks," Proc. EUROCRYPT 2018, LNCS, vol. 10822, pp. 456-486, 2018.
