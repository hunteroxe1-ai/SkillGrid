// AUTOMATIC SUBSCRIPTION CHECKER LOGIC FOR SKILLGRID

/**
 * Formula lowerengera masiku otsala kudzera ku End Date
 * @param {string} endDateString - Tsiku lomwe akaunti ya munthu imatha
 * @returns {number} Masiku omwe otsala enieni
 */
function calculateDaysLeft(endDateString) {
    const today = new Date(); // Tsiku la lero lamakono
    const endDate = new Date(endDateString); // Tsiku lakutha kwa malipiro
    
    // Kuwerengera kusiyana kwa nthawi mu ma-millisecond
    const timeDifference = endDate.getTime() - today.getTime();
    
    // Kusandutsa ma-millisecond kukhala masiku (1000ms * 3600s * 24 hours)
    const daysLeft = Math.ceil(timeDifference / (1000 * 3600 * 24));
    
    return daysLeft;
}

// CHITSANZO CHOTI UONE MOMWE WEBUSAYITI IZIDZACHITIRE IKAYENDA YOKHA:
// Tinene kuti munthu walipira ndipo tsiku lake lakutha liri m'musi mwamwambamu
const userSubscriptionEndDate = "2026-06-01"; // (Chitsanzo cha End Date mu Database)

const daysRemaining = calculateDaysLeft(userSubscriptionEndDate);

console.log(`[SkillGrid Engine] Checking system... Days remaining: ${daysRemaining}`);

// AUTOMATIC NOTIFICATION ENGINE (THE 5-DAY WARNING GUARDRAIL)
if (daysRemaining === 5) {
    console.log("👉 NOTIFICATION: Trigger Pop-up Alert on User Dashboard!");
    console.log("Message: 'Your access to this lab expires in 5 days. Kindly renew for K1,999 to keep learning.'");
    // Pa frontend, webusayiti izatsegula pop-up yochenjeza munthuyu mwa dongosolo ili
} 
else if (daysRemaining <= 0) {
    console.log("🔒 BLOCK ACCESS: Access expired. Lock the category gateway.");
    console.log("Action: Update subscription status to 'expired' inside MySQL.");
    // Kodi imatseka tsamba la kosi yomwe yatha ija mpaka aponyesenso malipiro ena a PayChangu
} 
else {
    console.log("✅ ACCESS GRANTED: User subscription is fully active.");
}
