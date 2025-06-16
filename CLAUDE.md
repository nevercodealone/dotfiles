# Global Claude User Configuration

## Git Commit Preferences
- No co-author attribution in commits
- No Claude Code generation messages in commits
- Keep commit messages clean and professional
- Follow conventional commit format when appropriate
- Use descriptive commit messages that explain the "why" not just the "what"

## Code Style Preferences  
- Use semantic HTML markup
- Follow project-specific indentation (check existing files)
- Maintain existing code formatting patterns
- Always verify changes before committing

## Development Workflow
- Check for lint/build commands in package.json or README before finalizing
- Preserve existing file structure and naming conventions
- Run tests if available before committing
- Use meaningful variable and function names
- Avoid code duplication - always search for existing methods in classes and utils, check what you can use or where to add new methods for new functions

## Cypress Testing Preferences
- Always use Page Object pattern for test organization
- Use clean, semantic selector names (data-cy, data-test, or data-testid attributes)
- Keep selectors in page objects, not in test files
- Prefer data attributes over CSS classes or IDs for test selectors