# Design System: EasyRoute Home
**Project ID:** 14856533701645627154

## 1. Visual Theme & Atmosphere
The design system for EasyRoute represents a **"Modern Corporate Travel Assistant."** It is clean, functional, and approachable. The aesthetic is airy and spacious, avoiding dense information blocks in favor of clear, distinct interactive areas. The vibe is utilitarian yet polished, utilizing soft gradients and rounded geometry to soften the inherently rigid nature of travel logistics.

## 2. Color Palette & Roles
*   **Vibrant Blue (`#0f6df0`):** The `primary` color. Used for key interactive elements, the main gradient, active navigation states, and highlighting the primary brand identity.
*   **Airy Gray-Blue (`#f5f7f8`):** The `background-light` color. Provides a clean, slightly cool canvas for the application in light mode, ensuring content cards pop.
*   **Deep Space Navy (`#101822`):** The `background-dark` color. A rich, dark background for dark mode that maintains a professional feel over pure black.
*   **Soft White (`#ffffff`):** Used for foreground cards and the chat input container, creating separation from the canvas.
*   **Slate 900 (`#0f172a`):** Primary text color in light mode for high legibility.
*   **Slate 500 (`#64748b`):** Secondary text color for subtitles and less critical information.
*   **Subtle Border Gray (`#e2e8f0`):** Used for defining edges of cards and inputs without heavy contrast.

## 3. Typography Rules
*   **Font Family:** **Inter**, a clean, geometric sans-serif that ensures high legibility on mobile devices.
*   **Display/Headlines:** Used in bold (`font-bold`, `font-semibold`) with tight letter spacing (`tracking-tight`). The main hero greeting ("Hello, Alex") is very large (`text-5xl`).
*   **Body Text:** Standard weights with standard line heights, ensuring readability.
*   **Labels/Microcopy:** Found in the bottom navigation and the AI disclaimer (`text-[10px]`, `text-xs`), used to provide necessary context without drawing excessive attention.

## 4. Component Stylings
*   **Action Tiles (Cards):** Shape is `rounded-2xl` (generously rounded corners), with a white background and a subtle `shadow-sm`. They feature a soft border that transitions to `primary` on interaction.
*   **Icon Containers:** Inner icons inside cards use `rounded-xl` with a heavily tinted primary background (`bg-primary/10`), providing a soft, pillowy resting place for the iconography.
*   **AI Input Field:** Acts as a floating central focal point. It uses `rounded-2xl`, sits on a `shadow-xl` (heavy, diffused shadow), and includes a subtle, expanding gradient glow (`blur opacity-20`).
*   **Buttons (Circular):** Quick actions (history, settings) use `rounded-full` (perfectly circular) with subtle hover state background shifts. The main send button is `rounded-xl` and uses solid `primary`.

## 5. Layout Principles
*   **Vertical Flow:** The layout is a straightforward vertical column (`flex-col`) with generous padding (`p-4`, `py-12`) to allow elements to breathe.
*   **Sticky Elements:** Both the top header and bottom navigation bar are sticky with a `backdrop-blur-md` and `backdrop-blur-lg` frosted glass effect, ensuring they are always accessible while maintaining context of the scrollable content beneath.
*   **Grid Systems:** Quick action tiles utilize a responsive grid (`grid-cols-1 sm:grid-cols-3`), spacing items evenly with a standard `gap-4`.
