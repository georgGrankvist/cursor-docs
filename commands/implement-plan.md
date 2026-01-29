---
description: Implement technical plans with verification and sub-agent support
---

# Implement Plan

You are tasked with implementing an approved technical plan. These plans contain phases with specific changes and success criteria.

## Getting Started

When given a plan path:

- Read the plan completely and check for any existing checkmarks (- [x])
- Read the original ticket and all files mentioned in the plan
- **Read files fully** - never use limit/offset parameters, you need complete context
- Think deeply about how the pieces fit together
- Create a todo list to track your progress
- Start implementing if you understand what needs to be done

If no plan path provided, ask for one.

## Implementation Philosophy

Plans are carefully designed, but reality can be messy. Your job is to:

- Follow the plan's intent while adapting to what you find
- Implement each phase fully before moving to the next
- Verify your work makes sense in the broader codebase context
- Update checkboxes in the plan as you complete sections

When things don't match the plan exactly, think about why and communicate clearly. The plan is your guide, but your judgment matters too.

If you encounter a mismatch:

- STOP and think deeply about why the plan can't be followed
- Present the issue clearly:

  ```
  Issue in Phase [N]:
  Expected: [what the plan says]
  Found: [actual situation]
  Why this matters: [explanation]

  How should I proceed?
  ```

## Using Sub-agents During Implementation

Use sub-agents **sparingly** during implementation - mainly for:

1. **Exploring unfamiliar territory** when you need context:

   ```
   Task(prompt="Use /codebase-analyzer to analyze how [similar feature] is implemented. I need to understand [specific aspect].")
   ```

2. **Finding similar patterns** to follow:

   ```
   Task(prompt="Use /codebase-pattern-finder to find examples of [pattern] that I can use as a reference.")
   ```

3. **Locating relevant files** when the plan references code you can't find:

   ```
   Task(prompt="Use /codebase-locator to find all files related to [component/feature].")
   ```

4. **Quality verification** after completing each phase (see Verification Approach section):
   ```
   Task(prompt="Use /verifier to independently verify Phase [N] completion...")
   ```

**When NOT to use sub-agents:**

- For straightforward implementation tasks
- When you already understand the code
- For simple file reads or edits

The main agent should do most of the implementation work directly. Sub-agents are for research assistance and quality verification only.

## Verification Approach

After implementing a phase:

1. **Initial verification**: Run the success criteria checks from the plan (tests, linting, type-checking, etc.)
2. **Fix any issues** found during initial verification before proceeding
3. **Independent quality check**: Use the `/verifier` sub-agent to independently validate the completed work:

   ```
   Task(prompt="Use /verifier to independently verify Phase [N] completion. Check that:
   - All claimed changes exist and are correct
   - Linting and type-checking pass
   - Build succeeds
   - The implementation matches the plan's success criteria

   Report any issues found. Do not make changes - only verify and report.")
   ```

4. **Address verifier findings**: If the verifier reports any issues:
   - Review the verifier's report carefully
   - Fix any legitimate issues identified
   - Re-run verification if needed
   - Only proceed when verifier confirms quality standards are met

5. **Update progress**: Once verification passes:
   - Update your progress in both the plan and your todos
   - Check off completed items in the plan file itself

6. **Pause for human verification**: After completing all automated verification for a phase, pause and inform the human that the phase is ready for manual testing. Use this format:

   ```
   Phase [N] Complete - Ready for Manual Verification

   Automated verification passed:
   - [List automated checks that passed]
   - Verifier validation: ✅ Passed

   Please perform the manual verification steps listed in the plan:
   - [List manual verification items from the plan]

   Let me know when manual testing is complete so I can proceed to Phase [N+1].
   ```

If instructed to execute multiple phases consecutively, skip the pause until the last phase. Otherwise, assume you are just doing one phase.

Do not check off items in the manual testing steps until confirmed by the user.

**Note**: The verifier is non-invasive - it only checks and reports. It does not make changes to your code. Use it as an independent quality gate before marking phases complete.

## If You Get Stuck

When something isn't working as expected:

1. **First**, make sure you've read and understood all the relevant code
2. **If you need more context**, spawn a research sub-agent:
   ```
   Task(prompt="Use /codebase-analyzer to analyze how [specific aspect] works in [relevant area]. I'm implementing [feature] and need to understand this.")
   ```
3. **Consider if the codebase has evolved** since the plan was written
4. **Present the mismatch clearly** and ask for guidance if needed

## Resuming Work

If the plan has existing checkmarks:

- Trust that completed work is done
- Pick up from the first unchecked item
- Verify previous work only if something seems off

Remember: You're implementing a solution, not just checking boxes. Keep the end goal in mind and maintain forward momentum.

## Sub-agent Best Practices

When you do need sub-agents during implementation:

1. **Invoke by name** using `/name` syntax (e.g., `/codebase-locator`, `/codebase-analyzer`)
2. **Be specific about what you need** - provide context about what you're implementing
3. **Don't over-rely on sub-agents** - most implementation should be done directly
4. **Synthesize sub-agent findings** and apply them to your implementation

Available sub-agents:

- **/codebase-locator** - Find WHERE files and components live
- **/codebase-analyzer** - Understand HOW specific code works
- **/codebase-pattern-finder** - Find similar implementations to follow
- **/verifier** - Independently validate completed work
