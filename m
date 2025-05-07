Return-Path: <bpf+bounces-57697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89DBAAE908
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 20:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94ED69848E3
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B350528DF41;
	Wed,  7 May 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XZZpl9Ih"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58697153BD9
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642510; cv=none; b=M7o5sR79J+Yz5SxwW4WxM0hPcl22R66TpOiNI8S9NGmge/ZMgZHPlxMbmHOFlJTZzo4xe5/26p142CW4SIdb566+0l63zP50gkLFWpUzbjHqWTMqcou/6woc/j3R7HKxHgFJmWTZubZJzky58b1ckwFI1vB4fI8aN6ljLkom01M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642510; c=relaxed/simple;
	bh=ay05SH27R9JpyzwhArYpQHmR7kdQQbPFMOj10oNJcOU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZkpPTEIlNnGcNhhUyrQAfn1jq6ZWX7aEjp3A5C0UJPs75vbO20GJ1RrJvFr5IfqdSy+MD886DS/EReM20Po60rSRMOdVZo2G51XomP3ZNRJv4LjOzprbpb6UJiHeRiz6fm5veG12q/fbIDuKvfFTOMTm/MUG4ZNyho+Gd3Ti+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XZZpl9Ih; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547IPAQx000443
	for <bpf@vger.kernel.org>; Wed, 7 May 2025 11:28:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:reply-to:subject:to; s=s2048-2021-q4; bh=7Kd/X836R
	t+WG27gxn04OvVfNvyrcqaqCEtXXFnIecs=; b=XZZpl9Ihr07WzLxXCdcJcyXAg
	SeoyOGh/awOP8sO3G14VyDe7zXNC6qSvkDHIiGvefGQr7VqDFcz3b9ZnhFbA7xsS
	KD24VuU34hYIGcKrLRtuiuAzhJdkKkRQ17f5T8v/eO1IKlMXQOeeUFCtlmvNl0ch
	tfG4JdkpMSyPYjiQnXuTi6V//DczCvqumFjisj2GblYvjwNlbsl81kEofe3WafNR
	p/OBvjSYm2JjShytCD5huKOXS2qy5Cr100uzr+Sq9YJbzU/Mg2T+h0cQo6OmS8Rr
	7MdxiZptO9Khfj6J8ajQtkKaPJpIFwv2bfnVUsZ6O2cJJPtZUFJfzi3//Pteg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46g26ycpw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 07 May 2025 11:28:27 -0700 (PDT)
Received: from twshared0377.32.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 7 May 2025 18:28:26 +0000
Received: by devvm14721.vll0.facebook.com (Postfix, from userid 669379)
	id 108672758DA2; Wed,  7 May 2025 11:28:19 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <qmo@kernel.org>, <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <dylan.reimerink@isovalent.com>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next v2] scripts/bpf_doc.py: implement json output format
Date: Wed, 7 May 2025 11:28:02 -0700
Message-ID: <20250507182802.3833349-1-isolodrai@meta.com>
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
X-Authority-Analysis: v=2.4 cv=eaI9f6EH c=1 sm=1 tr=0 ts=681ba64b cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=TUK-sHZvkfHu8wW5X5UA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: bSb31qgqFina9AaepWb8SgKIuA5DaNnb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE2NyBTYWx0ZWRfX5QNpgKMlw7r7 Q5NL0WQX43MCWq9gn3ZbA1B31lAFg9gpXCyw+QzzfBreyS7bjsPDHzpnujGYBP0+eLdyWdVNl1j ntgEkTe+opOkrrxoTjltdbjHZ6khum58r000zyRMLaZnYCvBuMO2dSF6X6AvamZfPTpwuAGuSHl
 pDncyO5DictbrnEwMMFo7CvfKrzVINEZD4PntkcGwlE3tiU2Z6w8n+eP4+08dENHA5QAvhcMdUB ijo0p3tgDhiGyq1+K2A2PgtCyThU9dTF2X/SnyigZtsXgQ5Ea85m0d1r/DlvQ6BKBN0YI1hWG1k dGUPXosq1lcQSo2KOLoEnurjYJXvFFHpov5buht5QwCeW0f+vyZT+t+9fR8Njym6/tZIVrpcXQQ
 BGIEqIjyCdPoCYz9Mhn8ly9j3EapgGAYnefOFZANxrHCgrUNqyhAGIR2DKF2n5sRxaNqydap
X-Proofpoint-GUID: bSb31qgqFina9AaepWb8SgKIuA5DaNnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01

bpf_doc.py parses bpf.h header to collect information about various
API elements (such as BPF helpers) and then dump them in one of the
supported formats: rst docs and a C header.

It's useful for external tools to be able to consume this information
in an easy-to-parse format such as JSON. Implement JSON printers and
add --json command line argument.

v1: https://lore.kernel.org/bpf/20250506000605.497296-1-isolodrai@meta.co=
m/

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 scripts/bpf_doc.py | 112 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 98 insertions(+), 14 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index e74a01a85070..d669a0e16bf2 100755
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
@@ -910,6 +961,19 @@ printers =3D {
         'syscall': PrinterSyscallRST,
 }
=20
+# target -> output format -> printer
+printers =3D {
+    'helpers': {
+        'rst': PrinterHelpersRST,
+        'json': PrinterHelpersJSON,
+        'header': PrinterHelpersHeader,
+    },
+    'syscall': {
+        'rst': PrinterSyscallRST,
+        'json': PrinterSyscallJSON
+    },
+}
+
 argParser =3D argparse.ArgumentParser(description=3D"""
 Parse eBPF header file and generate documentation for the eBPF API.
 The RST-formatted output produced can be turned into a manual page with =
the
@@ -917,6 +981,8 @@ rst2man utility.
 """)
 argParser.add_argument('--header', action=3D'store_true',
                        help=3D'generate C header file')
+argParser.add_argument('--json', action=3D'store_true',
+                       help=3D'generate a JSON')
 if (os.path.isfile(bpfh)):
     argParser.add_argument('--filename', help=3D'path to include/uapi/li=
nux/bpf.h',
                            default=3Dbpfh)
@@ -924,17 +990,35 @@ else:
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


