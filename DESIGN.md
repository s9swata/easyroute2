# Design System: Home Screen (Trip Stats)
**Project ID:** 14856533701645627154

## 1. Visual Theme & Atmosphere
The "Trip Stats" screen exudes a crisp, data-driven, and utilitarian atmosphere. It is designed for clarity and rapid information digestion, blending a light, airy background with dense, high-contrast information blocks. The aesthetic is professional yet approachable, relying on a clean card-based layout with distinct visual hierarchy to guide the user's eye from high-level summaries (the calendar and bar chart) down to granular details (individual bookings).

## 2. Color Palette & Roles
* **Primary Utility Blue** (#0f6df0): Used for primary accents, active states, active chart bars, and the "Export" button. It commands attention and indicates interactivity and progress.
* **Base Surface Light** (#ffffff): Used for interactive cards, sticky headers, and distinct content sections.
* **Background Light Canvas** (#f5f7f8): Serves as the primary viewport background, providing subtle contrast against the white content cards to delineate sections.
* **Deep Ink Slate** (#0f172a / text-slate-900): The primary color for high-emphasis text, headers, and major data points (e.g., "128" total trips).
* **Muted Ash Gray** (#64748b / text-slate-500): Used for secondary text, labels, calendar inactive dates, and subtle borders.
* **Alert Crimson** (#f87171 / bg-red-400): A crucial semantic color used exclusively to represent "No-shows" in the chart and alerts.
* **Soft Chart Gray** (#cbd5e1 / bg-slate-300): Used to represent "Scheduled" items in the bar chart, providing a neutral baseline against the vibrant active colors.
* **Success Green Tint** (#dcfce7 / bg-green-100): Used as a background for "Confirmed" status pills to offer positive reinforcement.
* **Warning Yellow Tint** (#fef08a / bg-yellow-100): Used as a background for "Pending" status pills to indicate pending action.

## 3. Typography Rules
* **Font Family:** Inter (Sans-Serif). Chosen for its high legibility and precise geometric proportions, perfect for data dashboards.
* **Headlines & Display:** Uses bold weights (700) with tight tracking to anchor sections (e.g., `text-3xl font-bold` for large stats, `text-xl font-bold tracking-tight` for section headers).
* **Body & Labels:** Uses regular to medium weights (400-500). Standard body text is `text-sm`, while dense data labels and calendar days use `font-bold text-xs`.
* **Micro-copy (Pills & Tags):** Uppercase with generous letter-spacing (`text-[10px] font-bold uppercase`) to ensure small labels are highly readable and distinct from standard paragraph text.

## 4. Component Stylings
* **Top App Bar:** Flat, sticky, utilizing a bottom border (`border-slate-200`) rather than a shadow, maintaining a flush, modern look.
* **Buttons:** 
  * "Export" button uses a prominent tinted background (`bg-primary/10`) with primary colored text, featuring softly rounded edges (`rounded-lg` / `0.5rem`).
* **Cards/Containers (Adhoc Bookings):** 
  * Appear distinctly lifted using a subtle shadow (`shadow-sm`), a fine border (`border-slate-100`), and generously rounded corners (`rounded-xl` / `0.75rem`).
  * Inner avatars use perfectly circular geometry (`rounded-full` / `9999px`) to contrast with the rectangular cards.
* **Data Visualizations (Bar Chart):** 
  * Bars are stacked vertically inside a fixed height container (`h-48`). Each segment utilizes absolute widths and percentage heights, topped with rounded upper corners (`rounded-t`), making the data physically relatable and approachable.
* **Status Pills:** Pill-shaped (`rounded-full`) with highly specific semantic coloring (tinted backgrounds with bold, darker text of the same hue family) for instant cognitive recognition.

## 5. Layout Principles
* **Alignment & Whitespace:** Relies heavily on flexbox (`flex-col`, `gap-4`, `gap-2`) for consistent vertical rhythm. Content is padded generously (`p-4` to `p-6`) to create distinct, breathable islands of information.
* **Sectioning:** The "No-Line" rule is heavily modified here; the design actively uses subtle 1px borders (`border-b border-slate-200`) and slight background color shifts (White to Light Canvas) to separate the Calendar, the Chart, and the List Views rigidly. This compartmentalization is standard for dense analytical dashboards.
* **Constraints:** Built initially for mobile proportions (Device Type: MOBILE, Width: 780), utilizing a single-column stacked flow that relies on vertical scrolling while keeping critical navigation and context (App Bar) sticky.

# Design System: Trips Screen (Upcoming Trips - Allocated)
**Screen ID:** 421b140cdcef4aee85f3b2d5e275b907

## 1. Visual Theme & Atmosphere
The Trips Screen offers a task-centric, action-oriented view. It clearly separates immediate, urgent context (The "Active Trip" card with map tracking) from future context (The "Other Trips" list). The heavy reliance on cards with shadows and distinct boundaries ensures that complex trip data is compartmentalized.

## 2. Component Stylings
* **Top Navigation Tabs:** Underlined indicator (`border-b-[3px] border-primary`) for the active tab ("Ongoing"). Inactive tabs use transparent borders and `slate-500` text.
* **Active Trip Card:** The hero component of the screen. 
  * Features an embedded, 150px-high map graphic with an overlaid "Live Tracking" pill (`bg-white shadow-lg` containing a pulsing primary dot).
  * Employs partitioned sections using `border-y border-slate-100` to separate high-level vehicle info from driver/ETA details.
  * OTP display uses a high-contrast inverted block (`bg-primary/10 text-primary uppercase font-black tracking-widest`).
* **Twin Action Buttons:** A `grid grid-cols-2 gap-3` setup. 
  * Primary Action ("Track on Map"): Filled `bg-primary text-white`.
  * Secondary Action ("I've Reached"): Outlined `border-2 border-primary text-primary bg-white`.
* **Other Trips Cards:** Simple row-based cards featuring a leading large icon (`size-12 rounded-lg bg-slate-100`). Secondary text provides relative time context ("Today • 6:30 PM"). Includes colored status dots (Blue = Allocated, Gray = Awaiting). Inactive future trips use slight opacity (`opacity-75`).
