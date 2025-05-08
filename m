Return-Path: <bpf+bounces-57800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AB6AB04C4
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26EB1BA33C2
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 20:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FCA221DB7;
	Thu,  8 May 2025 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aOA6lMZG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD5828A1ED
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736827; cv=none; b=DU2q/8L4LpvUY4qeFhDEggoZr8U5wGnbjRybBV+OfOrXzeewNFknPZAIAefoEy84QOrqCqNUtlUb/jr7ot9LJ4QTf2MuoZTmcpKHhB8mfbCQ+TviQi5i8J5II2ZCvQLAPYd4q87y3HL0n5397c3WBXUF/AXBHbbXfybhrD0g/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736827; c=relaxed/simple;
	bh=e0iDt70Q3Ax0AAu5nBa4SSyFAMjne+0lNDOB3zT9lkQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FzR2iS4ejhcZ97mgd1En+D3sEzF2NFDjk3KnFE2aEuryQIOcHN2TXouZAKVOrhmLHvt4LAkK4njTuYcT/FTfXQRWEnyDPYtaAZq0SgQeH884lkc3uF/gKQakLIQT3hwHQSg+bFRRsHTurcvbZ3GQo1SpoMWqlemYHWR1RQkymr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aOA6lMZG; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 548I6nNc000986
	for <bpf@vger.kernel.org>; Thu, 8 May 2025 13:40:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:reply-to:subject:to; s=s2048-2021-q4; bh=+E1WXx+GU
	BCacCp2it3VtDXufcr3DRRf7DZWAN5cRhs=; b=aOA6lMZGQT66474ZY2FsunUKJ
	Zmc+y49G2LgUZ0n8eK5ZUVE6v0T0ohtxovKd4RaG2LiE8bMh1hU4+zL/4fEqFQEp
	QIn5cQilFie9ELmq11KsD6bRS9PzJou8gktq8rbBsTQAwFDYZAVuS3aZIyLK1THW
	DoHPNGLLetreQYYUDtncSCSYhkXYvbeUmyBgMJ+/FfmdQQZhTx2u4sZao6Kq4adE
	4dM5bYtaxiHaO7v3wnVx8u0Zpitwf0xN+oHGXjIRnUAyYo3Gkb+vu9/mZaj6LPmY
	lKouAdGlmkCFKMLb7nErAJkjw6nIJJQPiyYvRqtrq8ZyJJMX6qndntxQaiwuw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 46gtup4mq6-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 08 May 2025 13:40:23 -0700 (PDT)
Received: from twshared29376.33.frc3.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 8 May 2025 20:40:21 +0000
Received: by devvm14721.vll0.facebook.com (Postfix, from userid 669379)
	id 97C5E2831B60; Thu,  8 May 2025 13:37:17 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <qmo@kernel.org>, <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <dylan.reimerink@isovalent.com>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next v4] scripts/bpf_doc.py: implement json output format
Date: Thu, 8 May 2025 13:37:08 -0700
Message-ID: <20250508203708.2520847-1-isolodrai@meta.com>
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
X-Authority-Analysis: v=2.4 cv=a+cw9VSF c=1 sm=1 tr=0 ts=681d16b7 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=9SOExajgYcFn7ivU8_IA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 3D1PyWkWwp3AZLXjH15wFsuM9UVbcvFi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE4NiBTYWx0ZWRfXz0dSuscLqnrx Eqgv/LWzkBFrK+3YFzIqufyZ8d3ekB6anIaakqRqWSKhJy2gnaW9lPE9QjDdAON6ZGTQwKC57fF OZSmBfG3wuAaX5EKuPgkoPIP5PoJrX8DYyi7Uz1DVQPz8b1YIq4OdA4eArGPtisnPx+BdsOzt3m
 ifXAIindDAA8g6afBn2cCzkEwOwwsL2xpz8IV661/N85Jsm5hUnM6irAynViD6uYYDjznP06LCm DLV0UkrPOc6qaZSd2V13iSa9BmhBCBc4Lq/742gGegkrbtYzHP3P54Mx0XyN6BPwcehtMiDzIjK KRf2rwC2iT056Vq67tSvqU5c6Id3wiwvIJE2RrGAaG+a0yQzBsPQTRUKOWCwld4MtWdd96YRoY3
 +oOdA3JVt6i/ICukE4dEKOQF9IkbRwoBq79mgALM83v8+s+9Z+VdCQklJ3G0jISjHCc7ts0s
X-Proofpoint-GUID: 3D1PyWkWwp3AZLXjH15wFsuM9UVbcvFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_06,2025-05-08_04,2025-02-21_01

bpf_doc.py parses bpf.h header to collect information about various
API elements (such as BPF helpers) and then dump them in one of the
supported formats: rst docs and a C header.

It's useful for external tools to be able to consume this information
in an easy-to-parse format such as JSON. Implement JSON printers and
add --json command line argument.

v3->v4: refactor attrs to only be a helper's field
v2->v3: nit cleanup
v1->v2: add json printer for syscall target

v3: https://lore.kernel.org/bpf/20250507203034.270428-1-isolodrai@meta.co=
m/
v2: https://lore.kernel.org/bpf/20250507182802.3833349-1-isolodrai@meta.c=
om/
v1: https://lore.kernel.org/bpf/20250506000605.497296-1-isolodrai@meta.co=
m/

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 scripts/bpf_doc.py | 119 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 99 insertions(+), 20 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index e74a01a85070..c77dc40f7689 100755
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
@@ -37,11 +38,17 @@ class APIElement(object):
     @desc: textual description of the symbol
     @ret: (optional) description of any associated return value
     """
-    def __init__(self, proto=3D'', desc=3D'', ret=3D'', attrs=3D[]):
+    def __init__(self, proto=3D'', desc=3D'', ret=3D''):
         self.proto =3D proto
         self.desc =3D desc
         self.ret =3D ret
-        self.attrs =3D attrs
+
+    def to_dict(self):
+        return {
+            'proto': self.proto,
+            'desc': self.desc,
+            'ret': self.ret
+        }
=20
=20
 class Helper(APIElement):
@@ -51,8 +58,9 @@ class Helper(APIElement):
     @desc: textual description of the helper function
     @ret: description of the return value of the helper function
     """
-    def __init__(self, *args, **kwargs):
-        super().__init__(*args, **kwargs)
+    def __init__(self, proto=3D'', desc=3D'', ret=3D'', attrs=3D[]):
+        super().__init__(proto, desc, ret)
+        self.attrs =3D attrs
         self.enum_val =3D None
=20
     def proto_break_down(self):
@@ -81,6 +89,12 @@ class Helper(APIElement):
=20
         return res
=20
+    def to_dict(self):
+        d =3D super().to_dict()
+        d["attrs"] =3D self.attrs
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
-
-# Parse file.
-headerParser =3D HeaderParser(args.filename)
-headerParser.run()
=20
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


