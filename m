Return-Path: <bpf+bounces-57706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E5FAAED15
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 22:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9A23A3953
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 20:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3321E28ECFA;
	Wed,  7 May 2025 20:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CQ5EIYbO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAED1C5F30
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746649855; cv=none; b=s6QR+rR8TpQZmZ9O2O55uOzPLLE0yp8gueV7I6Nhk7C+ElRfXHCeFeq3TlFkqkSr4T4KxOA1o7UKTq7Uba/YxiGQ5MmDiEUCByAk19+ur9AU/bFGivUkKqkU19x+Ptjo0nl5buiEeQL+qhQG6FteiY/rz0J0GzeIVeKziPBqSAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746649855; c=relaxed/simple;
	bh=7eUw5rR3jdlWSG/Pgf++NZ4FGzkXj5G5wDAvQFCBNOI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NKMKCuYV3S4wi8LvDYTwyFAaDSbGKOXLDO20bUC8gQR/eI54Ssjl9VEJaH2swegWdtBSnqjTELvGShoDzBW3BcMWOvkIBkh+oKxPlAq7/zi6uTKeslUNoKnRc14roeO/R2/ULDNV29sY49EJTMKT95oIBKWKRba01MSQgfVQj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CQ5EIYbO; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547Icnwg017851
	for <bpf@vger.kernel.org>; Wed, 7 May 2025 13:30:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:reply-to:subject:to; s=s2048-2021-q4; bh=h0acZh6wQ
	R2nPnj662s3FdMPr5oaIon1raoCJNHY6v8=; b=CQ5EIYbOLBzCPYS0jcRh1y7Cl
	3yv7xuGm9QEDXlkeWLB0BaUwUjNCY3tzN+tdhC65BqkrBNcCuMxTqqp8InRHlbew
	N2IR/gJiO90giPHfaiqZj9b4v96wRRLfw6o8DQUQVrfpweYsOSx1CXPwVXyAPjs+
	Kh/pJ01pk9feVCi95NvGDkXYWe8P6tqXouDZ9Xy82nJihsBYAsdYpgvrQid7tz1l
	ETIe+tqzlwGWu6sabAIyU+bFuf7Goh0SDoLdcbeR/yYm9/H2YPqb+JmZaoF1eekV
	QmtJWHCPX57Ts7cFhVw0HCteIMlMLFYdRSmUloDGN+VfOIih3JOAZBj4mzeqQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46gcyjrutd-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 07 May 2025 13:30:52 -0700 (PDT)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 7 May 2025 20:30:50 +0000
Received: by devvm14721.vll0.facebook.com (Postfix, from userid 669379)
	id BCCA52769D04; Wed,  7 May 2025 13:30:37 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <qmo@kernel.org>, <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <dylan.reimerink@isovalent.com>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next v3] scripts/bpf_doc.py: implement json output format
Date: Wed, 7 May 2025 13:30:34 -0700
Message-ID: <20250507203034.270428-1-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
Reply-To: <ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: RVnu_DMS7JCxna_9OFo0d-hO8HwK3tPN
X-Proofpoint-ORIG-GUID: RVnu_DMS7JCxna_9OFo0d-hO8HwK3tPN
X-Authority-Analysis: v=2.4 cv=aeNhnQot c=1 sm=1 tr=0 ts=681bc2fc cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=Qv2XIF7oxN-wfwnp6YsA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE4NyBTYWx0ZWRfXxFODRhyGed0c mHo1KiSzTZm6zCkosXDaJKXonkbNLHgd3OUUk6Ev0JX3Odvpmh5snCyU3xGK85rjlS/kxC6o21E bfbQEdes9lkp0x+s10IO0R4q7/90b/jLMcp3ZJ6s0QN43yFj5C1s1TlS1vAbK3OwTD5QpyYdRvR
 UHVJ6moRFTpdsQgW5wP2H5e0dxd98Eg2zW9d4ZRD7RopHVbVRTOvGG/4pu4keGoZPL0m1VKocWb WesVoRGSFJisDKudGuBLDYPmdRqoECkTzGn4lhDhaXIgtjk+v1q4lPA26qRUKY3i8h5bbesmAcv NZ7W2rtDz/VY1QO37qmikkNk43Y3qn2v6rBw1fJaSrOd2Lj+kSeYdq39em/R18gfu+PB9T/EUNx
 ajaTGTtHu+Osg+kuRztcfYfXPn8F8/onpDQbytDayseEvf25B77DUPjywu9NOL+rZxL0utKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-07_01,2025-02-21_01

bpf_doc.py parses bpf.h header to collect information about various
API elements (such as BPF helpers) and then dump them in one of the
supported formats: rst docs and a C header.

It's useful for external tools to be able to consume this information
in an easy-to-parse format such as JSON. Implement JSON printers and
add --json command line argument.

v2->v3: nit cleanup
v1->v2: add json printer for syscall target

v2: https://lore.kernel.org/bpf/20250507182802.3833349-1-isolodrai@meta.c=
om/
v1: https://lore.kernel.org/bpf/20250506000605.497296-1-isolodrai@meta.co=
m/

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 scripts/bpf_doc.py | 111 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 95 insertions(+), 16 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index e74a01a85070..b157fab016a3 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -8,6 +8,7 @@
 from __future__ import print_function
=20
 import argparse
+import json
 import re
 import sys, os
 import subprocess
@@ -43,6 +44,14 @@ class APIElement(object):
         self.ret =3D ret
         self.attrs =3D attrs
=20
+    def to_dict(self):
+        return {
+            'proto': self.proto,
+            'desc': self.desc,
+            'ret': self.ret,
+            'attrs': self.attrs
+        }
+
=20
 class Helper(APIElement):
     """
@@ -81,6 +90,11 @@ class Helper(APIElement):
=20
         return res
=20
+    def to_dict(self):
+        d =3D super().to_dict()
+        d.update(self.proto_break_down())
+        return d
+
=20
 ATTRS =3D {
     '__bpf_fastcall': 'bpf_fastcall'
@@ -675,7 +689,7 @@ COMMANDS
         self.print_elem(command)
=20
=20
-class PrinterHelpers(Printer):
+class PrinterHelpersHeader(Printer):
     """
     A printer for dumping collected information about helpers as C heade=
r to
     be included from BPF program.
@@ -896,6 +910,43 @@ class PrinterHelpers(Printer):
         print(') =3D (void *) %d;' % helper.enum_val)
         print('')
=20
+
+class PrinterHelpersJSON(Printer):
+    """
+    A printer for dumping collected information about helpers as a JSON =
file.
+    @parser: A HeaderParser with Helper objects
+    """
+
+    def __init__(self, parser):
+        self.elements =3D parser.helpers
+        self.elem_number_check(
+            parser.desc_unique_helpers,
+            parser.define_unique_helpers,
+            "helper",
+            "___BPF_FUNC_MAPPER",
+        )
+
+    def print_all(self):
+        helper_dicts =3D [helper.to_dict() for helper in self.elements]
+        out_dict =3D {'helpers': helper_dicts}
+        print(json.dumps(out_dict, indent=3D4))
+
+
+class PrinterSyscallJSON(Printer):
+    """
+    A printer for dumping collected syscall information as a JSON file.
+    @parser: A HeaderParser with APIElement objects
+    """
+
+    def __init__(self, parser):
+        self.elements =3D parser.commands
+        self.elem_number_check(parser.desc_syscalls, parser.enum_syscall=
s, 'syscall', 'bpf_cmd')
+
+    def print_all(self):
+        syscall_dicts =3D [syscall.to_dict() for syscall in self.element=
s]
+        out_dict =3D {'syscall': syscall_dicts}
+        print(json.dumps(out_dict, indent=3D4))
+
 ########################################################################=
#######
=20
 # If script is launched from scripts/ from kernel tree and can access
@@ -905,9 +956,17 @@ script =3D os.path.abspath(sys.argv[0])
 linuxRoot =3D os.path.dirname(os.path.dirname(script))
 bpfh =3D os.path.join(linuxRoot, 'include/uapi/linux/bpf.h')
=20
+# target -> output format -> printer
 printers =3D {
-        'helpers': PrinterHelpersRST,
-        'syscall': PrinterSyscallRST,
+    'helpers': {
+        'rst': PrinterHelpersRST,
+        'json': PrinterHelpersJSON,
+        'header': PrinterHelpersHeader,
+    },
+    'syscall': {
+        'rst': PrinterSyscallRST,
+        'json': PrinterSyscallJSON
+    },
 }
=20
 argParser =3D argparse.ArgumentParser(description=3D"""
@@ -917,6 +976,8 @@ rst2man utility.
 """)
 argParser.add_argument('--header', action=3D'store_true',
                        help=3D'generate C header file')
+argParser.add_argument('--json', action=3D'store_true',
+                       help=3D'generate a JSON')
 if (os.path.isfile(bpfh)):
     argParser.add_argument('--filename', help=3D'path to include/uapi/li=
nux/bpf.h',
                            default=3Dbpfh)
@@ -924,17 +985,35 @@ else:
     argParser.add_argument('--filename', help=3D'path to include/uapi/li=
nux/bpf.h')
 argParser.add_argument('target', nargs=3D'?', default=3D'helpers',
                        choices=3Dprinters.keys(), help=3D'eBPF API targe=
t')
-args =3D argParser.parse_args()
=20
-# Parse file.
-headerParser =3D HeaderParser(args.filename)
-headerParser.run()
-
-# Print formatted output to standard output.
-if args.header:
-    if args.target !=3D 'helpers':
-        raise NotImplementedError('Only helpers header generation is sup=
ported')
-    printer =3D PrinterHelpers(headerParser)
-else:
-    printer =3D printers[args.target](headerParser)
-printer.print_all()
+def error_die(message: str):
+    argParser.print_usage(file=3Dsys.stderr)
+    print('Error: {}'.format(message), file=3Dsys.stderr)
+    exit(1)
+
+def parse_and_dump():
+    args =3D argParser.parse_args()
+
+    # Parse file.
+    headerParser =3D HeaderParser(args.filename)
+    headerParser.run()
+
+    if args.header and args.json:
+        error_die('Use either --header or --json, not both')
+
+    output_format =3D 'rst'
+    if args.header:
+        output_format =3D 'header'
+    elif args.json:
+        output_format =3D 'json'
+
+    try:
+        printer =3D printers[args.target][output_format](headerParser)
+        # Print formatted output to standard output.
+        printer.print_all()
+    except KeyError:
+        error_die('Unsupported target/format combination: "{}", "{}"'
+                    .format(args.target, output_format))
+
+if __name__ =3D=3D "__main__":
+    parse_and_dump()
--=20
2.47.1


