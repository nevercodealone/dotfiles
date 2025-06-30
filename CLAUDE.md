# Global Claude User Configuration

## Git Commit Preferences
- No co-author attribution in commits
- No Claude Code generation messages in commits
- Keep commit messages clean and professional
- Use less commits but to understand the logical part of the steps 
- Follow conventional commit format when appropriate
- Use descriptive commit messages that explain the "why" not just the "what"

## Git Commit Guidelines
- NEVER add co-author hints to git commits
- NEVER add "Generated with Claude Code" footer
- Keep commit messages professional and focused on the changes made


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

## Testing Strategy (Unit/Integration Tests)
- **Avoid test duplication**: Create comprehensive mock tests that cover ALL functionality and edge cases
- **Mock tests first**: Write extensive mock tests (15-30+ cases) covering every scenario, edge case, and error condition
- **Single real test**: Add only ONE real/integration test to verify end-to-end connectivity and basic functionality
- **Real test timeout**: Keep real test timeouts realistic (10-15 seconds max, not 60 seconds)
- **Mock test benefits**: Fast execution (~50ms), no external dependencies, reliable for CI/CD
- **Real test purpose**: Validates database/API connectivity, confirms integration works with live data
- **Coverage approach**: Mock tests = 95% coverage, Real test = 5% smoke test

### Example Test Structure
```
/tests/api/mock/feature.test.ts   # 20+ comprehensive test cases
/tests/api/real/feature.test.ts   # 1 integration test
```

## Cypress Testing Preferences
- Always use Page Object pattern for test organization
- Use clean, semantic selector names (data-cy, data-test, or data-testid attributes)
- Keep selectors in page objects, not in test files
- Prefer data attributes over CSS classes or IDs for test selectors
- Prefer fuzzy selectors with contains() for text-based elements

## Tailwind CSS & Flowbite Preferences
- Use ~/development/flowbite/flowbite-pro-templates as preferred source for Tailwind CSS and Flowbite best practice examples
- Reference existing components and patterns from Flowbite Pro Templates when implementing UI elements
- Follow Flowbite component structure and naming conventions
