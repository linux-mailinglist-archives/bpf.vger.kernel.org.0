Return-Path: <bpf+bounces-57459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A60AAB896
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7E33A14A5
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212BD189915;
	Tue,  6 May 2025 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cb6E7D9m"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A7F194C86
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489995; cv=none; b=IaeAJ0IXV3zlxaZhZivgAEWoFouOBDKqgbR1JddBz7uLtqai9D1vHoWvh0qxwRWml5JnxFbLghw8r1I7lP9VU02Sennfn97kkE/GnE8zACQCjFi7FiuCIVA1YPZSzmNKEXyCwYJ9HxwvdKkr3ChrVOnUS/dCyjF6FLo6oz+kwp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489995; c=relaxed/simple;
	bh=xt5e7Uolq4/0rno4uMeCLWuOTGvZ/YHk0CbidvjPGJA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=keH6oezEy+le2AMBHekf6kxvdHrHe+i+Rj8PeOrHLNhTSUOi8p5LMn4rdJ6lk6/IJDW16PSHEMOBcZX2Ekb8jqwNl1AcmWnCabOhIi6e25ZaBZnT9BcOxyI7R4jU4kt7x447SNvPLGunUPKl/CHWYtPyelXGIZOOPFhh5GdWEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cb6E7D9m; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545MuIEw016793
	for <bpf@vger.kernel.org>; Mon, 5 May 2025 17:06:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:reply-to:subject:to; s=s2048-2021-q4; bh=jfDpQxIUx
	Sp2SgO5tWHP/X4yty8lAbJwtbuCgl9yqyE=; b=cb6E7D9m2TlTKVLTpbBApRDj7
	AJGa/k2GLF3qeqJeKKcUZX+phzOF64eCFMXH9gGx87hEBvjcSrcKYE+ByKaeY7QY
	BfjuofRzP/8OQsiwF1VAr+jnlSSmTIQOHe0UwP+Lbn+haJu/144pzctIuksQ92HV
	YJw9WYCvCfHka5pVC7+n1J+6gS+urHoxQLODe2RSL6HMgojuDuOwJoZuBMyQ+3Fl
	ne0+9Y1ZwpcXSEoiq/O5rGZKe1LbMiLZ/W6lN98BRyboUOkAcGr/qi+pqiA5/WFA
	Q5Hg0xv1mTS8ab3QcYFLP5FBf2xxWKy8JfWiCj/on+4tLluG2Tvb9Dluz00MQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46f6518jqd-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 05 May 2025 17:06:31 -0700 (PDT)
Received: from twshared11388.16.prn3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 6 May 2025 00:06:30 +0000
Received: by devvm14721.vll0.facebook.com (Postfix, from userid 669379)
	id 7A67F25AD59C; Mon,  5 May 2025 17:06:21 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>
CC: <bpf@vger.kernel.org>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next] scripts/bpf_doc.py: implement json output for helpers
Date: Mon, 5 May 2025 17:06:05 -0700
Message-ID: <20250506000605.497296-1-isolodrai@meta.com>
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
X-Proofpoint-ORIG-GUID: flTp13NKNqG69ZCbIT1r2ZS7Wbv5d44S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDIyNyBTYWx0ZWRfX+zl8ZfrYm7CO hHkGn4nG8Spb1gkm0PjM1FGdF+Cqb1c/VhmMrVeINONqXp3yLXt6gA8+yZRg8TJDK7xJzjIS8Td A3JoEuCdoALbpURJxljNctyUaMrC4cy3xXWHL67wtRiZhv4GDhgs2kQ9xl/u8gVpPJtNEqLX9SD
 pBz9dkQtGyOJg90kwKOBKehwRlVQKjznuRumi5KxmvUtt2610wuVH61fs1aPSbvWHsD2jK47PWD Eft9qnm2ZvcoHPsyyLCKiqZ+DSEYoUKUWdA3ltkeIVyt8f2JY5P4jTDlFLptbSVB7xgwfR207zQ UdfvhIP9+olZxuCo+1eoUn8QKgN0HCwHkbt3t5umSNtWprfJCyPLyc0wtHz3R31JKr8O/l2dbU/
 gPmQopO/syv6yWIkoMtKLhULwlzUMbc1SbB91wvCSbj6xf7k+pvMN/miqGkwpO/t+JlEWwiN
X-Proofpoint-GUID: flTp13NKNqG69ZCbIT1r2ZS7Wbv5d44S
X-Authority-Analysis: v=2.4 cv=b76y4sGx c=1 sm=1 tr=0 ts=68195287 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=dt9VzEwgFbYA:10 a=VabnemYjAAAA:8 a=_gQSRz2LmcjoAKVUBkgA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_10,2025-05-05_01,2025-02-21_01

bpf_doc.py parses bpf.h header to collect information about various
functions (such as BPF helpers) and dump them in one of the supported
forms: rst docs and a C header.

It's useful for external tools to be able to consume information about
BPF helpers - list of helpers and their args - in an easy-to-parse
format such as JSON. Given that bpf_doc.py already does the work of
searching and collecting the helpers, implement trivial JSON printer
and add --json option for helpers target.

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 scripts/bpf_doc.py | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index e74a01a85070..15d83ff5d2bd 100755
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
@@ -675,7 +676,7 @@ COMMANDS
         self.print_elem(command)
=20
=20
-class PrinterHelpers(Printer):
+class PrinterHelpersHeader(Printer):
     """
     A printer for dumping collected information about helpers as C heade=
r to
     be included from BPF program.
@@ -896,6 +897,27 @@ class PrinterHelpers(Printer):
         print(') =3D (void *) %d;' % helper.enum_val)
         print('')
=20
+
+class PrinterHelpersJSON(Printer):
+    """
+    A printer for dumping collected information about helpers as a JSON =
file.
+    @parser: A HeaderParser with Helper objects to print to standard out=
put
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
+        protos =3D [helper.proto_break_down() for helper in self.element=
s]
+        out_dict =3D {"helpers": protos}
+        print(json.dumps(out_dict, indent=3D4))
+
 ########################################################################=
#######
=20
 # If script is launched from scripts/ from kernel tree and can access
@@ -917,6 +939,8 @@ rst2man utility.
 """)
 argParser.add_argument('--header', action=3D'store_true',
                        help=3D'generate C header file')
+argParser.add_argument("--json", action=3D"store_true",
+                       help=3D"generate a JSON with information about he=
lpers")
 if (os.path.isfile(bpfh)):
     argParser.add_argument('--filename', help=3D'path to include/uapi/li=
nux/bpf.h',
                            default=3Dbpfh)
@@ -930,11 +954,19 @@ args =3D argParser.parse_args()
 headerParser =3D HeaderParser(args.filename)
 headerParser.run()
=20
-# Print formatted output to standard output.
+if args.header and args.json:
+    print("bpf_doc.py: Use --header or --json, not both")
+    exit(1)
+if args.target !=3D "helpers" and (args.header or args.json):
+    print("bpf_doc.py: Only helpers header/json generation is supported"=
)
+    exit(1)
+
 if args.header:
-    if args.target !=3D 'helpers':
-        raise NotImplementedError('Only helpers header generation is sup=
ported')
-    printer =3D PrinterHelpers(headerParser)
+    printer =3D PrinterHelpersHeader(headerParser)
+elif args.json:
+    printer =3D PrinterHelpersJSON(headerParser)
 else:
     printer =3D printers[args.target](headerParser)
+
+# Print formatted output to standard output.
 printer.print_all()
--=20
2.47.1


