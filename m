Return-Path: <bpf+bounces-7690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB21777B11E
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 08:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4D11C2099A
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 06:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436179FA;
	Mon, 14 Aug 2023 06:07:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA3749C
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 06:07:41 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0278810DD;
	Sun, 13 Aug 2023 23:07:39 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E5wFdf008569;
	Mon, 14 Aug 2023 06:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bhQlIJCeGJ0Xx5sPsapHi8I1Ha49xDxR5Spc/HI58fU=;
 b=gzlW1Oyj/p4UOCGOy+w/uNrsqY4Fkv+mZ9ZCQKySYABR45dfzl///XQElqVCb3YqeANH
 eS0pfrgVGRetlFzP18JFqftx2vYDM69gB3rWPYgnBwKMTrysmBp+w4SVAczZxIKTyRcQ
 yLbkBIHXaClMT2JuUf+sy/HMqZ1Gqdi2DeIQYf4JCP/k5k0/oEgZmfZpgjnLrYWaYOZK
 TSgZmeZCabyiVe23FrwfRsjJKp+KsKw+bJIBZBchenpUJQVv9MFRTN4wfvLgRaWvZqEo
 H0FCYBnkxrFbhyivPZ+uod/j7MVMFcxVcwNDzOYN5W4FC8IJKFU4L4oUlXPPoA11RNIp cA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfekc04fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:24 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E3kAxk002427;
	Mon, 14 Aug 2023 06:07:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendmsp4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37E67L8V61276524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Aug 2023 06:07:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 590852004B;
	Mon, 14 Aug 2023 06:07:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EFE920040;
	Mon, 14 Aug 2023 06:07:20 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Aug 2023 06:07:20 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A13B1603B6;
	Mon, 14 Aug 2023 16:07:17 +1000 (AEST)
From: Benjamin Gray <bgray@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com, jan.kiszka@siemens.com,
        kbingham@kernel.org, mykolal@fb.com,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH 0/8] Fix Python string escapes
Date: Mon, 14 Aug 2023 16:06:56 +1000
Message-ID: <20230814060704.79655-1-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cvAMhQ-a4Igo_ddui7AYxHwp24O61BbK
X-Proofpoint-ORIG-GUID: cvAMhQ-a4Igo_ddui7AYxHwp24O61BbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140055
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
This is upgraded to a SyntaxWarning in Python 3.12 (3.12.0rc1), and is
intended to eventually be a syntax error.

This series aims to fix these now to get ahead of it before it's an error.

Most of the patches are generated using the below Python script. It
uses the builtin ast module to parse a Python file, locate all strings,
find the corresponding source code, and check for bad escape sequences.

If it finds things to fix then it applies the fixes and reparses the
file into a fixed AST. It finally compares the original and fixed ASTs
to ensure no semantic difference has been introduced (dumping is done to
remove node location information, which is expected to be different).

There are some limitations of the ast module, in particular it throws
away a lot of information about the string source. f-strings especially
interact poorly here (the slices between formats are presented as
separate strings, but the node range of each is the entire f-string),
so are skipped. f-strings are handled manually in the final patch.

A lot of the fixes are for regex patterns, which could be changed to use
r-strings instead. But that is less easy to automate, so I avoided doing
so in this series. AST verification should still be possible though,
because being a plain or r-string is stripped away in the AST.

---
#!/usr/bin/env python3

"""
Fix all bad escape characters in strings
"""

import ast
from pathlib import Path

def get_offset(source: str, row: int, col: int) -> int:
    """
    Turn a row + column pair into a byte offset
    """
    offset = 0

    cur_row = 1  # 1-indexed rows
    cur_col = 0  # 0-indexed columns

    for c in source:
        if cur_row == row and cur_col == col:
            return offset

        offset += 1

        if c == "\n":
            cur_row += 1
            cur_col = 0
        else:
            cur_col += 1

    raise Exception("Failed to get offset")


parse_failures: list[Path] = []
fix_failures = 0
bad_escapes = 0
fstrings: set[Path] = set()

for pyfile in Path(".").glob("**/*.py"):
    content = pyfile.read_text("utf-8")

    try:
        syntax = ast.parse(content, filename=pyfile)
    except:
        print(f"{pyfile}: ERROR Failed to parse, is it Python3?")
        parse_failures.append(pyfile)
        continue

    fixes: list[tuple[int, int, str]] = []

    for node in ast.walk(syntax):
        if not isinstance(node, ast.Constant):
            continue

        if not isinstance(node.value, str):
            continue

        if node.value.count("\\") == 0:
            continue

        assert(isinstance(node.end_lineno, int))
        assert(isinstance(node.end_col_offset, int))

        start = get_offset(content, node.lineno, node.col_offset)
        end = get_offset(content, node.end_lineno, node.end_col_offset)
        raw = content[start:end]

        # backslashes in r-strings are already literal
        if raw.startswith("r"):
            continue

        # f-strings are difficult to handle correctly
        if raw.startswith("f"):
            fstrings.add(pyfile)
            continue

        fixed = ""  # The fixed representation of the string
        escaped = False  # If the current character is escaped by a previous backslash
        allowed = '\n\\\'"abfnrtv01234567xNuU'  # characters allowed after a backslash

        for c in raw:
            if escaped:
                if c not in allowed:
                        fixed += '\\'

                fixed += c
                escaped = False
                continue

            fixed += c

            if c == '\\':
                escaped = True

        if fixed != raw:
            print(f"{pyfile}:{node.lineno}:{node.col_offset}: FOUND {raw}")
            fixes.append((start, end, fixed))

    if len(fixes) == 0:
        continue

    bad_escapes += len(fixes)

    # Apply fixes in reverse order to keep offsets valid
    for start, end, fix in reversed(sorted(fixes, key=lambda k: k[0])):
        print(f"{pyfile}:[{start}-{end}]: APPLY {fix}")
        content = content[:start] + fix + content[end:]

    fixed_syntax = ast.parse(content, filename=f"{pyfile}+fixed")

    if ast.dump(syntax) != ast.dump(fixed_syntax):
        print(f"{pyfile}: ERROR Fixed syntax tree yields different AST")
        fix_failures += 1
        continue

    pyfile.write_text(content)


print(f"---------------------------------")
print(f"Parse failures:               {len(parse_failures)}")
for f in sorted(parse_failures):
    print(f"  - {f}")

print(f"Bad escapes fixed:            {bad_escapes}")
print(f"Fixes that broke the AST:     {fix_failures}")
print(f"Files with skipped f-strings: {len(fstrings)}")
for f in sorted(fstrings):
    print(f"  - {f}")

---

Benjamin Gray (8):
  ia64: fix Python string escapes
  Documentation/sphinx: fix Python string escapes
  drivers/comedi: fix Python string escapes
  scripts: fix Python string escapes
  tools/perf: fix Python string escapes
  tools/power: fix Python string escapes
  selftests/bpf: fix Python string escapes
  selftests/bpf: fix Python string escapes in f-strings

 Documentation/sphinx/cdomain.py               |  2 +-
 Documentation/sphinx/kernel_abi.py            |  2 +-
 Documentation/sphinx/kernel_feat.py           |  2 +-
 Documentation/sphinx/kerneldoc.py             |  2 +-
 Documentation/sphinx/maintainers_include.py   |  8 +--
 arch/ia64/scripts/unwcheck.py                 |  2 +-
 .../ni_routing/tools/convert_csv_to_c.py      |  2 +-
 scripts/bpf_doc.py                            | 56 +++++++++----------
 scripts/clang-tools/gen_compile_commands.py   |  2 +-
 scripts/gdb/linux/symbols.py                  |  2 +-
 tools/perf/pmu-events/jevents.py              |  2 +-
 .../scripts/python/arm-cs-trace-disasm.py     |  4 +-
 tools/perf/scripts/python/compaction-times.py |  2 +-
 .../scripts/python/exported-sql-viewer.py     |  4 +-
 tools/power/pm-graph/bootgraph.py             | 12 ++--
 .../selftests/bpf/test_bpftool_synctypes.py   | 26 ++++-----
 tools/testing/selftests/bpf/test_offload.py   |  2 +-
 17 files changed, 66 insertions(+), 66 deletions(-)

--
2.41.0

