from pathlib import Path

root = Path("lib")

# Old -> new visual language.
# We deliberately preserve different shades where they represent
# different surfaces instead of flattening everything into one green.

palette = {
    # DARK APP BACKGROUNDS -> WARM SURFACES
    "FF031A22": "FFF7F5EE",
    "ff041525": "FFF7F5EE",
    "FF03142A": "FFF7F5EE",
    "FF020C18": "FFF7F5EE",
    "FF04172F": "FFF7F5EE",
    "FF04152F": "FFF7F5EE",
    "FF041F26": "FFF7F5EE",
    "FF041C2A": "FFF7F5EE",
    "FF04252D": "FFF7F5EE",
    "FF052A30": "FFF7F5EE",
    "FF061A27": "FFFCFBF7",
    "FF061B46": "FFFCFBF7",
    "FF062D46": "FFFCFBF7",
    "FF06314A": "FFFCFBF7",
    "FF082D4A": "FFFCFBF7",

    # DARK TEAL HERO / FEATURE SURFACES -> FIELD GREENS
    "FF0A4A43": "FF49664A",
    "FF0A3940": "FF5A7355",
    "FF082633": "FF687C60",
    "FF092B32": "FFE9E5D8",
    "FF172B32": "FFEDE8DC",

    # DEEP GREEN -> FOREST / EARTH
    "ff075238": "FF355C3A",
    "FF063B2D": "FF355C3A",
    "FF06452F": "FF355C3A",
    "FF075238": "FF355C3A",
    "FF07392C": "FF355C3A",
    "FF07372B": "FF355C3A",
    "FF0A5B37": "FF355C3A",
    "FF086653": "FF547A4F",
    "FF08705D": "FF547A4F",
    "FF17604C": "FF547A4F",
    "FF1C8C63": "FF667A50",

    # CYAN / TURQUOISE -> SAGE
    "FF2CA9C9": "FF78906B",
    "FF3CCFE0": "FF8FA184",
    "FF36C8DD": "FF8FA184",
    "FF36D49A": "FF78906B",
    "FF39D49C": "FF78906B",
    "FF39C793": "FF78906B",
    "FF45D9A4": "FF78906B",
    "FF43D19B": "FF78906B",
    "FF43D477": "FF78906B",
    "FF45D77E": "FF78906B",
    "FF57E0A8": "FF78906B",
    "FF56E2AF": "FF78906B",
    "FF5DE2B0": "FF78906B",
    "FF5DE2B0": "FF78906B",
    "FF6AE8BE": "FF78906B",
    "FF6DE5B7": "FF78906B",
    "FF6DE7B7": "FF78906B",
    "FF6BE6B6": "FF78906B",
    "FF70E8B9": "FF78906B",
    "FF72E9BF": "FF78906B",
    "FF72E6BA": "FF78906B",
    "FF73E8BC": "FF78906B",
    "FF75E8BC": "FF78906B",
    "FF78EAC0": "FF78906B",
    "FF79E8BE": "FF78906B",
    "FF7CEAC0": "FF78906B",
    "FF7DE6BE": "FF78906B",
    "FF7AE9C4": "FF78906B",
    "FF7CE8CC": "FF78906B",
    "FF7CFFE0": "FF78906B",
    "FF82EEC7": "FF78906B",
    "FF83F0C8": "FF78906B",
    "FF8CE8C6": "FF78906B",
    "FF8EF1CA": "FF78906B",
    "FF8BFFD2": "FF78906B",
    "FF9CFFE0": "FF8FA184",
    "FF9FF3D2": "FF8FA184",
    "FFA8F6D5": "FF8FA184",
    "FFB8FFE1": "FF8FA184",
    "FFB9FFE9": "FF8FA184",
    "FFBFF7DD": "FF8FA184",
    "FFC9FFF0": "FF8FA184",
    "FFE4FFF7": "FFE1E7D9",
    "FFE9FFF7": "FFE1E7D9",

    # BLUE ACCENTS -> OLIVE / SAGE
    "FF5EC8FF": "FF78906B",
    "FF8DC7FF": "FF667A50",
    "FF9ABEFF": "FF667A50",
    "FF0E4A74": "FF667A50",
    "FF1479A8": "FF667A50",
    "FF1A7FA8": "FF667A50",
    "FF0B3150": "FF667A50",

    # YELLOW / AMBER -> WHEAT
    "FFFFD77C": "FFCDBB91",
    "FFFFD77B": "FFCDBB91",
    "FFF0D77E": "FFCDBB91",
    "FFE7C96E": "FFCDBB91",
    "FFE6C66B": "FFCDBB91",

    # EXISTING EARTH / NATURE VALUES
    "FFCDBB91": "FFCDBB91",
    "FF795C43": "FF795C43",
    "FF667A50": "FF667A50",
    "FF78906B": "FF78906B",
    "FF547A4F": "FF547A4F",
    "FF355C3A": "FF355C3A",
    "FFF7F5EE": "FFF7F5EE",
    "FFFCFBF7": "FFFCFBF7",
    "FFECE9DD": "FFECE9DD",
    "FFECE9E0": "FFECE9E0",
    "FFE6DDC9": "FFE6DDC9",
    "FFE4E0D5": "FFE4E0D5",
    "FFE1E8DC": "FFE1E8DC",
    "FFDCE6D8": "FFDCE6D8",
    "FFE9DDCF": "FFE9DDCF",
    "FF292A25": "FF292A25",

    # RED STATUS COLOURS — keep them restrained
    "FFFFA7A7": "FFD99B91",
    "FFB85C52": "FFB85C52",
    "FFF5DAD6": "FFF0DDD8",
}


changed = 0

for path in root.rglob("*.dart"):
    text = path.read_text()

    original = text

    for old, new in palette.items():
        # Preserve both uppercase and lowercase x-prefix variants.
        text = text.replace("0x" + old, "0x" + new)
        text = text.replace("0X" + old, "0x" + new)

    if text != original:
        path.write_text(text)
        changed += 1
        print(f"Updated: {path}")

print()
print(f"Updated {changed} Dart files.")
