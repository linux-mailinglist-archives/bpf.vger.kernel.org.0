Return-Path: <bpf+bounces-50950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDF6A2E90D
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 11:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C0D3A6240
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89F01E1C22;
	Mon, 10 Feb 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpevRi7+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150E1DE8A6;
	Mon, 10 Feb 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182705; cv=none; b=p4zikGdXanZUwXXI5wp9qzVk6hxVM48ytOb4yeP6FeecHwMKDxGtf/fLku0wqrXEMgVmHwtdR+hw5L4fFvR1Q7t2KJXZ0ZV0beAChGDamcMZs9jObCvZywOj+fwokhXpVlUCkIBqyZ1+IhW2Jd1B7FhPp6TDCPm7Uqa/hnEltV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182705; c=relaxed/simple;
	bh=G4Ao1AS7x1gxC+qfXgw6zg9b3k3cUZLk9tkKvro3lOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwEEaA+NfTMmE9NRUmXWBZZdxb4HnpboA/LuTtTC2KGV3D3//rDBSWWK0xnEv2eWVmLGyFkyT/CPN+zsEtPOl6tLxg5akw3AziANe498r7p/g3VnNjMYhJllNSqF1lnP4rO1vQqBdj1co/gjUrhV3uPiFlECZTOZmnICLrjTJcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpevRi7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D42DC4CEEF;
	Mon, 10 Feb 2025 10:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739182704;
	bh=G4Ao1AS7x1gxC+qfXgw6zg9b3k3cUZLk9tkKvro3lOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gpevRi7+sd5JkIn6v8XPmLemxtBNYOmDZEXSi4jLr80GRvCO95fAQpKIC7+b7uAEq
	 47MWJMhDW7v3cpsUCrIo2polMUTotTJtaP0y3eACX39hddOkIm8NhQfwSBqetki7Hm
	 YAoazGazcFphIQeqQwJrGvCFhI395FElQ8Y2Nfp1aZBFyFrRer+/dCs7KPGQSSD/7C
	 m0Mfmp1adjkfC4Rx/Pl1s9D3lLVH2yxjYo1sZQ8wNlP+2X3RGL5chMOgusuIYA3I7J
	 CGZtUhyD7l+XIacR0Cko5lhzuqHZB0ZmaaSIF255s7UiWzD141ByGzu/quqnIv0Tbt
	 +VL846pSUrRSg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1thQru-00000006Cjo-2HRu;
	Mon, 10 Feb 2025 11:18:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 26/27] scripts/get_abi.py: add support for undefined ABIs
Date: Mon, 10 Feb 2025 11:18:15 +0100
Message-ID: <1529c255845d117696d5af57d8dc05554663afdf.1739182025.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739182025.git.mchehab+huawei@kernel.org>
References: <cover.1739182025.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The undefined logic is complex and has lots of magic on it.

Implement it, using the same algorithm we have at get_abi.pl. Yet,
some tweaks to optimize performance and to make the code simpler
were added here:
- at the perl version, the tree graph had loops, so we had to
  use BFS to traverse it. On this version, the graph is a tree,
  so, it simplifies the what group for sysfs aliases;
- the logic which splits regular expressions into subgroups
  was re-written to make it faster;
- it may optionally use multiple processes to search for symbol
  matches;
- it has some additional debug levels.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.py                |  68 ++++++
 scripts/lib/abi/abi_regex.py      | 234 ++++++++++++++++++
 scripts/lib/abi/helpers.py        |  16 +-
 scripts/lib/abi/system_symbols.py | 378 ++++++++++++++++++++++++++++++
 4 files changed, 693 insertions(+), 3 deletions(-)
 create mode 100644 scripts/lib/abi/abi_regex.py
 create mode 100644 scripts/lib/abi/system_symbols.py

diff --git a/scripts/get_abi.py b/scripts/get_abi.py
index 19f78d6aa407..7ce4748a46d2 100755
--- a/scripts/get_abi.py
+++ b/scripts/get_abi.py
@@ -20,7 +20,9 @@ SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
 from abi_parser import AbiParser                # pylint: disable=C0413
+from abi_regex import AbiRegex                  # pylint: disable=C0413
 from helpers import ABI_DIR, DEBUG_HELP         # pylint: disable=C0413
+from system_symbols import SystemSymbols        # pylint: disable=C0413
 
 # Command line classes
 
@@ -111,6 +113,71 @@ class AbiSearch:
         parser.parse_abi()
         parser.search_symbols(args.expression)
 
+UNDEFINED_DESC="""
+Check undefined ABIs on local machine.
+
+Read sysfs devnodes and check if the devnodes there are defined inside
+ABI documentation.
+
+The search logic tries to minimize the number of regular expressions to
+search per each symbol.
+
+By default, it runs on a single CPU, as Python support for CPU threads
+is still experimental, and multi-process runs on Python is very slow.
+
+On experimental tests, if the number of ABI symbols to search per devnode
+is contained on a limit of ~150 regular expressions, using a single CPU
+is a lot faster than using multiple processes. However, if the number of
+regular expressions to check is at the order of ~30000, using multiple
+CPUs speeds up the check.
+"""
+
+class AbiUndefined:
+    """
+    Initialize an argparse subparser for logic to check undefined ABI at
+    the current machine's sysfs
+    """
+
+    def __init__(self, subparsers):
+        """Initialize argparse subparsers"""
+
+        parser = subparsers.add_parser("undefined",
+                                       formatter_class=argparse.RawTextHelpFormatter,
+                                       description=UNDEFINED_DESC)
+
+        parser.add_argument("-S", "--sysfs-dir", default="/sys",
+                            help="directory where sysfs is mounted")
+        parser.add_argument("-s", "--search-string",
+                            help="search string regular expression to limit symbol search")
+        parser.add_argument("-H", "--show-hints", action="store_true",
+                            help="Hints about definitions for missing ABI symbols.")
+        parser.add_argument("-j", "--jobs", "--max-workers", type=int, default=1,
+                            help="If bigger than one, enables multiprocessing.")
+        parser.add_argument("-c", "--max-chunk-size", type=int, default=50,
+                            help="Maximum number of chunk size")
+        parser.add_argument("-f", "--found", action="store_true",
+                            help="Also show found items. "
+                                 "Helpful to debug the parser."),
+        parser.add_argument("-d", "--dry-run", action="store_true",
+                            help="Don't actually search for undefined. "
+                                 "Helpful to debug the parser."),
+
+        parser.set_defaults(func=self.run)
+
+    def run(self, args):
+        """Run subparser"""
+
+        abi = AbiRegex(args.dir, debug=args.debug,
+                       search_string=args.search_string)
+
+        abi_symbols = SystemSymbols(abi=abi, hints=args.show_hints,
+                                    sysfs=args.sysfs_dir)
+
+        abi_symbols.check_undefined_symbols(dry_run=args.dry_run,
+                                            found=args.found,
+                                            max_workers=args.jobs,
+                                            chunk_size=args.max_chunk_size)
+
 
 def main():
     """Main program"""
@@ -125,6 +192,7 @@ def main():
     AbiRest(subparsers)
     AbiValidate(subparsers)
     AbiSearch(subparsers)
+    AbiUndefined(subparsers)
 
     args = parser.parse_args()
 
diff --git a/scripts/lib/abi/abi_regex.py b/scripts/lib/abi/abi_regex.py
new file mode 100644
index 000000000000..8a57846cbc69
--- /dev/null
+++ b/scripts/lib/abi/abi_regex.py
@@ -0,0 +1,234 @@
+#!/usr/bin/env python3
+# xxpylint: disable=R0903
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Convert ABI what into regular expressions
+"""
+
+import re
+import sys
+
+from pprint import pformat
+
+from abi_parser import AbiParser
+from helpers import AbiDebug
+
+class AbiRegex(AbiParser):
+    """Extends AbiParser to search ABI nodes with regular expressions"""
+
+    # Escape only ASCII visible characters
+    escape_symbols = r"([\x21-\x29\x2b-\x2d\x3a-\x40\x5c\x60\x7b-\x7e])"
+    leave_others = "others"
+
+    # Tuples with regular expressions to be compiled and replacement data
+    re_whats = [
+        # Drop escape characters that might exist
+        (re.compile("\\\\"), ""),
+
+        # Temporarily escape dot characters
+        (re.compile(r"\."),  "\xf6"),
+
+        # Temporarily change [0-9]+ type of patterns
+        (re.compile(r"\[0\-9\]\+"),  "\xff"),
+
+        # Temporarily change [\d+-\d+] type of patterns
+        (re.compile(r"\[0\-\d+\]"),  "\xff"),
+        (re.compile(r"\[0:\d+\]"),  "\xff"),
+        (re.compile(r"\[(\d+)\]"),  "\xf4\\\\d+\xf5"),
+
+        # Temporarily change [0-9] type of patterns
+        (re.compile(r"\[(\d)\-(\d)\]"),  "\xf4\1-\2\xf5"),
+
+        # Handle multiple option patterns
+        (re.compile(r"[\{\<\[]([\w_]+)(?:[,|]+([\w_]+)){1,}[\}\>\]]"), r"(\1|\2)"),
+
+        # Handle wildcards
+        (re.compile(r"([^\/])\*"), "\\1\\\\w\xf7"),
+        (re.compile(r"/\*/"), "/.*/"),
+        (re.compile(r"/\xf6\xf6\xf6"), "/.*"),
+        (re.compile(r"\<[^\>]+\>"), "\\\\w\xf7"),
+        (re.compile(r"\{[^\}]+\}"), "\\\\w\xf7"),
+        (re.compile(r"\[[^\]]+\]"), "\\\\w\xf7"),
+
+        (re.compile(r"XX+"), "\\\\w\xf7"),
+        (re.compile(r"([^A-Z])[XYZ]([^A-Z])"), "\\1\\\\w\xf7\\2"),
+        (re.compile(r"([^A-Z])[XYZ]$"), "\\1\\\\w\xf7"),
+        (re.compile(r"_[AB]_"), "_\\\\w\xf7_"),
+
+        # Recover [0-9] type of patterns
+        (re.compile(r"\xf4"), "["),
+        (re.compile(r"\xf5"),  "]"),
+
+        # Remove duplicated spaces
+        (re.compile(r"\s+"), r" "),
+
+        # Special case: drop comparison as in:
+        # What: foo = <something>
+        # (this happens on a few IIO definitions)
+        (re.compile(r"\s*\=.*$"), ""),
+
+        # Escape all other symbols
+        (re.compile(escape_symbols), r"\\\1"),
+        (re.compile(r"\\\\"), r"\\"),
+        (re.compile(r"\\([\[\]\(\)\|])"), r"\1"),
+        (re.compile(r"(\d+)\\(-\d+)"), r"\1\2"),
+
+        (re.compile(r"\xff"), r"\\d+"),
+
+        # Special case: IIO ABI which a parenthesis.
+        (re.compile(r"sqrt(.*)"), r"sqrt(.*)"),
+
+        # Simplify regexes with multiple .*
+        (re.compile(r"(?:\.\*){2,}"),  ""),
+
+        # Recover dot characters
+        (re.compile(r"\xf6"), "\\."),
+        # Recover plus characters
+        (re.compile(r"\xf7"), "+"),
+    ]
+    re_has_num = re.compile(r"\\d")
+
+    # Symbol name after escape_chars that are considered a devnode basename
+    re_symbol_name =  re.compile(r"(\w|\\[\.\-\:])+$")
+
+    # List of popular group names to be skipped to minimize regex group size
+    # Use AbiDebug.SUBGROUP_SIZE to detect those
+    skip_names = set(["devices", "hwmon"])
+
+    def regex_append(self, what, new):
+        """
+        Get a search group for a subset of regular expressions.
+
+        As ABI may have thousands of symbols, using a for to search all
+        regular expressions is at least O(n^2). When there are wildcards,
+        the complexity increases substantially, eventually becoming exponential.
+
+        To avoid spending too much time on them, use a logic to split
+        them into groups. The smaller the group, the better, as it would
+        mean that searches will be confined to a small number of regular
+        expressions.
+
+        The conversion to a regex subset is tricky, as we need something
+        that can be easily obtained from the sysfs symbol and from the
+        regular expression. So, we need to discard nodes that have
+        wildcards.
+
+        If it can't obtain a subgroup, place the regular expression inside
+        a special group (self.leave_others).
+        """
+
+        search_group = None
+
+        for search_group in reversed(new.split("/")):
+            if not search_group or search_group in self.skip_names:
+                continue
+            if self.re_symbol_name.match(search_group):
+                break
+
+        if not search_group:
+            search_group = self.leave_others
+
+        if self.debug & AbiDebug.SUBGROUP_MAP:
+            self.log.debug("%s: mapped as %s", what, search_group)
+
+        try:
+            if search_group not in self.regex_group:
+                self.regex_group[search_group] = []
+
+            self.regex_group[search_group].append(re.compile(new))
+            if self.search_string:
+                if what.find(self.search_string) >= 0:
+                    print(f"What: {what}")
+        except re.PatternError:
+            self.log.warning("Ignoring '%s' as it produced an invalid regex:\n"
+                             "           '%s'", what, new)
+
+    def get_regexes(self, what):
+        """
+        Given an ABI devnode, return a list of all regular expressions that
+        may match it, based on the sub-groups created by regex_append()
+        """
+
+        re_list = []
+
+        patches = what.split("/")
+        patches.reverse()
+        patches.append(self.leave_others)
+
+        for search_group in patches:
+            if search_group in self.regex_group:
+                re_list += self.regex_group[search_group]
+
+        return re_list
+
+    def __init__(self, *args, **kwargs):
+        """
+        Override init method to get verbose argument
+        """
+
+        self.regex_group = None
+        self.search_string = None
+        self.re_string = None
+
+        if "search_string" in kwargs:
+            self.search_string = kwargs.get("search_string")
+            del kwargs["search_string"]
+
+            if self.search_string:
+
+                try:
+                    self.re_string = re.compile(self.search_string)
+                except re.PatternError as e:
+                    msg = f"{self.search_string} is not a valid regular expression"
+                    raise ValueError(msg) from e
+
+        super().__init__(*args, **kwargs)
+
+    def parse_abi(self, *args, **kwargs):
+
+        super().parse_abi(*args, **kwargs)
+
+        self.regex_group = {}
+
+        print("Converting ABI What fields into regexes...", file=sys.stderr)
+
+        for t in sorted(self.data.items(), key=lambda x: x[0]):
+            v = t[1]
+            if v.get("type") == "File":
+                continue
+
+            v["regex"] = []
+
+            for what in v.get("what", []):
+                if not what.startswith("/sys"):
+                    continue
+
+                new = what
+                for r, s in self.re_whats:
+                    try:
+                        new = r.sub(s, new)
+                    except re.PatternError as e:
+                        # Help debugging troubles with new regexes
+                        raise re.PatternError(f"{e}\nwhile re.sub('{r.pattern}', {s}, str)") from e
+
+                v["regex"].append(new)
+
+                if self.debug & AbiDebug.REGEX:
+                    self.log.debug("%-90s <== %s", new, what)
+
+                # Store regex into a subgroup to speedup searches
+                self.regex_append(what, new)
+
+        if self.debug & AbiDebug.SUBGROUP_DICT:
+            self.log.debug("%s", pformat(self.regex_group))
+
+        if self.debug & AbiDebug.SUBGROUP_SIZE:
+            biggestd_keys = sorted(self.regex_group.keys(),
+                                   key= lambda k: len(self.regex_group[k]),
+                                   reverse=True)
+
+            print("Top regex subgroups:", file=sys.stderr)
+            for k in biggestd_keys[:10]:
+                print(f"{k} has {len(self.regex_group[k])} elements", file=sys.stderr)
diff --git a/scripts/lib/abi/helpers.py b/scripts/lib/abi/helpers.py
index 84a253ed5058..639b23e4ca33 100644
--- a/scripts/lib/abi/helpers.py
+++ b/scripts/lib/abi/helpers.py
@@ -16,13 +16,23 @@ class AbiDebug:
     WHAT_PARSING = 1
     WHAT_OPEN = 2
     DUMP_ABI_STRUCTS = 4
+    UNDEFINED = 8
+    REGEX = 16
+    SUBGROUP_MAP = 32
+    SUBGROUP_DICT = 64
+    SUBGROUP_SIZE = 128
+    GRAPH = 256
 
 
 DEBUG_HELP = """
-Print debug information according with the level(s),
-which is given by the following bitmask:
-
 1  - enable debug parsing logic
 2  - enable debug messages on file open
 4  - enable debug for ABI parse data
+8  - enable extra debug information to identify troubles
+     with ABI symbols found at the local machine that
+     weren't found on ABI documentation (used only for
+     undefined subcommand)
+16 - enable debug for what to regex conversion
+32 - enable debug for symbol regex subgroups
+64 - enable debug for sysfs graph tree variable
 """
diff --git a/scripts/lib/abi/system_symbols.py b/scripts/lib/abi/system_symbols.py
new file mode 100644
index 000000000000..f15c94a6e33c
--- /dev/null
+++ b/scripts/lib/abi/system_symbols.py
@@ -0,0 +1,378 @@
+#!/usr/bin/env python3
+# pylint: disable=R0902,R0912,R0914,R0915,R1702
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Parse ABI documentation and produce results from it.
+"""
+
+import os
+import re
+import sys
+
+from concurrent import futures
+from datetime import datetime
+from random import shuffle
+
+from helpers import AbiDebug
+
+class SystemSymbols:
+    """Stores arguments for the class and initialize class vars"""
+
+    def graph_add_file(self, path, link=None):
+        """
+        add a file path to the sysfs graph stored at self.root
+        """
+
+        if path in self.files:
+            return
+
+        name = ""
+        ref = self.root
+        for edge in path.split("/"):
+            name += edge + "/"
+            if edge not in ref:
+                ref[edge] = {"__name": [name.rstrip("/")]}
+
+            ref = ref[edge]
+
+        if link and link not in ref["__name"]:
+            ref["__name"].append(link.rstrip("/"))
+
+        self.files.add(path)
+
+    def print_graph(self, root_prefix="", root=None, level=0):
+        """Prints a reference tree graph using UTF-8 characters"""
+
+        if not root:
+            root = self.root
+            level = 0
+
+        # Prevent endless traverse
+        if level > 5:
+            return
+
+        if level > 0:
+            prefix = "├──"
+            last_prefix = "└──"
+        else:
+            prefix = ""
+            last_prefix = ""
+
+        items = list(root.items())
+
+        names = root.get("__name", [])
+        for k, edge in items:
+            if k == "__name":
+                continue
+
+            if not k:
+                k = "/"
+
+            if len(names) > 1:
+                k += " links: " + ",".join(names[1:])
+
+            if edge == items[-1][1]:
+                print(root_prefix + last_prefix + k)
+                p = root_prefix
+                if level > 0:
+                    p += "   "
+                self.print_graph(p, edge, level + 1)
+            else:
+                print(root_prefix + prefix + k)
+                p = root_prefix + "│   "
+                self.print_graph(p, edge, level + 1)
+
+    def _walk(self, root):
+        """
+        Walk through sysfs to get all devnodes that aren't ignored.
+
+        By default, uses /sys as sysfs mounting point. If another
+        directory is used, it replaces them to /sys at the patches.
+        """
+
+        with os.scandir(root) as obj:
+            for entry in obj:
+                path = os.path.join(root, entry.name)
+                if self.sysfs:
+                    p = path.replace(self.sysfs, "/sys", count=1)
+                else:
+                    p = path
+
+                if self.re_ignore.search(p):
+                    return
+
+                # Handle link first to avoid directory recursion
+                if entry.is_symlink():
+                    real = os.path.realpath(path)
+                    if not self.sysfs:
+                        self.aliases[path] = real
+                    else:
+                        real = real.replace(self.sysfs, "/sys", count=1)
+
+                    # Add absfile location to graph if it doesn't exist
+                    if not self.re_ignore.search(real):
+                        # Add link to the graph
+                        self.graph_add_file(real, p)
+
+                elif entry.is_file():
+                    self.graph_add_file(p)
+
+                elif entry.is_dir():
+                    self._walk(path)
+
+    def __init__(self, abi, sysfs="/sys", hints=False):
+        """
+        Initialize internal variables and get a list of all files inside
+        sysfs that can currently be parsed.
+
+        Please notice that there are several entries on sysfs that aren't
+        documented as ABI. Ignore those.
+
+        The real paths will be stored under self.files. Aliases will be
+        stored in separate, as self.aliases.
+        """
+
+        self.abi = abi
+        self.log = abi.log
+
+        if sysfs != "/sys":
+            self.sysfs = sysfs.rstrip("/")
+        else:
+            self.sysfs = None
+
+        self.hints = hints
+
+        self.root = {}
+        self.aliases = {}
+        self.files = set()
+
+        dont_walk = [
+            # Those require root access and aren't documented at ABI
+            f"^{sysfs}/kernel/debug",
+            f"^{sysfs}/kernel/tracing",
+            f"^{sysfs}/fs/pstore",
+            f"^{sysfs}/fs/bpf",
+            f"^{sysfs}/fs/fuse",
+
+            # This is not documented at ABI
+            f"^{sysfs}/module",
+
+            f"^{sysfs}/fs/cgroup",  # this is big and has zero docs under ABI
+            f"^{sysfs}/firmware",   # documented elsewhere: ACPI, DT bindings
+            "sections|notes",       # aren't actually part of ABI
+
+            # kernel-parameters.txt - not easy to parse
+            "parameters",
+        ]
+
+        self.re_ignore = re.compile("|".join(dont_walk))
+
+        print(f"Reading {sysfs} directory contents...", file=sys.stderr)
+        self._walk(sysfs)
+
+    def check_file(self, refs, found):
+        """Check missing ABI symbols for a given sysfs file"""
+
+        res_list = []
+
+        try:
+            for names in refs:
+                fname = names[0]
+
+                res = {
+                    "found": False,
+                    "fname": fname,
+                    "msg": "",
+                }
+                res_list.append(res)
+
+                re_what = self.abi.get_regexes(fname)
+                if not re_what:
+                    self.abi.log.warning(f"missing rules for {fname}")
+                    continue
+
+                for name in names:
+                    for r in re_what:
+                        if self.abi.debug & AbiDebug.UNDEFINED:
+                            self.log.debug("check if %s matches '%s'", name, r.pattern)
+                        if r.match(name):
+                            res["found"] = True
+                            if found:
+                                res["msg"] += f"  {fname}: regex:\n\t"
+                            continue
+
+                if self.hints and not res["found"]:
+                    res["msg"] += f"  {fname} not found. Tested regexes:\n"
+                    for r in re_what:
+                        res["msg"] += "    " + r.pattern + "\n"
+
+        except KeyboardInterrupt:
+            pass
+
+        return res_list
+
+    def _ref_interactor(self, root):
+        """Recursive function to interact over the sysfs tree"""
+
+        for k, v in root.items():
+            if isinstance(v, dict):
+                yield from self._ref_interactor(v)
+
+            if root == self.root or k == "__name":
+                continue
+
+            if self.abi.re_string:
+                fname = v["__name"][0]
+                if self.abi.re_string.search(fname):
+                    yield v
+            else:
+                yield v
+
+
+    def get_fileref(self, all_refs, chunk_size):
+        """Interactor to group refs into chunks"""
+
+        n = 0
+        refs = []
+
+        for ref in all_refs:
+            refs.append(ref)
+
+            n += 1
+            if n >= chunk_size:
+                yield refs
+                n = 0
+                refs = []
+
+        yield refs
+
+    def check_undefined_symbols(self, max_workers=None, chunk_size=50,
+                                found=None, dry_run=None):
+        """Seach ABI for sysfs symbols missing documentation"""
+
+        self.abi.parse_abi()
+
+        if self.abi.debug & AbiDebug.GRAPH:
+            self.print_graph()
+
+        all_refs = []
+        for ref in self._ref_interactor(self.root):
+            all_refs.append(ref["__name"])
+
+        if dry_run:
+            print("Would check", file=sys.stderr)
+            for ref in all_refs:
+                print(", ".join(ref))
+
+            return
+
+        print("Starting to search symbols (it may take several minutes):",
+              file=sys.stderr)
+        start = datetime.now()
+        old_elapsed = None
+
+        # Python doesn't support multithreading due to limitations on its
+        # global lock (GIL). While Python 3.13 finally made GIL optional,
+        # there are still issues related to it. Also, we want to have
+        # backward compatibility with older versions of Python.
+        #
+        # So, use instead multiprocess. However, Python is very slow passing
+        # data from/to multiple processes. Also, it may consume lots of memory
+        # if the data to be shared is not small.  So, we need to group workload
+        # in chunks that are big enough to generate performance gains while
+        # not being so big that would cause out-of-memory.
+
+        num_refs = len(all_refs)
+        print(f"Number of references to parse: {num_refs}", file=sys.stderr)
+
+        if not max_workers:
+            max_workers = os.cpu_count()
+        elif max_workers > os.cpu_count():
+            max_workers = os.cpu_count()
+
+        max_workers = max(max_workers, 1)
+
+        max_chunk_size = int((num_refs + max_workers - 1) / max_workers)
+        chunk_size = min(chunk_size, max_chunk_size)
+        chunk_size = max(1, chunk_size)
+
+        if max_workers > 1:
+            executor = futures.ProcessPoolExecutor
+
+            # Place references in a random order. This may help improving
+            # performance, by mixing complex/simple expressions when creating
+            # chunks
+            shuffle(all_refs)
+        else:
+            # Python has a high overhead with processes. When there's just
+            # one worker, it is faster to not create a new process.
+            # Yet, User still deserves to have a progress print. So, use
+            # python's "thread", which is actually a single process, using
+            # an internal schedule to switch between tasks. No performance
+            # gains for non-IO tasks, but still it can be quickly interrupted
+            # from time to time to display progress.
+            executor = futures.ThreadPoolExecutor
+
+        not_found = []
+        f_list = []
+        with executor(max_workers=max_workers) as exe:
+            for refs in self.get_fileref(all_refs, chunk_size):
+                if refs:
+                    try:
+                        f_list.append(exe.submit(self.check_file, refs, found))
+
+                    except KeyboardInterrupt:
+                        return
+
+            total = len(f_list)
+
+            if not total:
+                if self.abi.re_string:
+                    print(f"No ABI symbol matches {self.abi.search_string}")
+                else:
+                    self.abi.log.warning("No ABI symbols found")
+                return
+
+            print(f"{len(f_list):6d} jobs queued on {max_workers} workers",
+                  file=sys.stderr)
+
+            while f_list:
+                try:
+                    t = futures.wait(f_list, timeout=1,
+                                     return_when=futures.FIRST_COMPLETED)
+
+                    done = t[0]
+
+                    for fut in done:
+                        res_list = fut.result()
+
+                        for res in res_list:
+                            if not res["found"]:
+                                not_found.append(res["fname"])
+                            if res["msg"]:
+                                print(res["msg"])
+
+                        f_list.remove(fut)
+                except KeyboardInterrupt:
+                    return
+
+                except RuntimeError as e:
+                    self.abi.log.warning(f"Future: {e}")
+                    break
+
+                if sys.stderr.isatty():
+                    elapsed = str(datetime.now() - start).split(".", maxsplit=1)[0]
+                    if len(f_list) < total:
+                        elapsed += f" ({total - len(f_list)}/{total} jobs completed).  "
+                    if elapsed != old_elapsed:
+                        print(elapsed + "\r", end="", flush=True,
+                              file=sys.stderr)
+                        old_elapsed = elapsed
+
+        elapsed = str(datetime.now() - start).split(".", maxsplit=1)[0]
+        print(elapsed, file=sys.stderr)
+
+        for f in sorted(not_found):
+            print(f"{f} not found.")
-- 
2.48.1


