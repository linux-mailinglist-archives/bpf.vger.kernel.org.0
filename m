Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D16838D67F
	for <lists+bpf@lfdr.de>; Sat, 22 May 2021 18:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhEVQk5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 May 2021 12:40:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25184 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231272AbhEVQk4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 22 May 2021 12:40:56 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14MGZbrp030492
        for <bpf@vger.kernel.org>; Sat, 22 May 2021 09:39:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=fIp/31OHExpGJaFEso0lgukRWD1u86+9UiKtGO81Bgg=;
 b=V5LEpDJREjOGI7a3WoWvvI4adoO5jXbuyD8/bm6NNDozsu0uvajLR0S2a1qcA0+Sl3JD
 E0aQ7DTr+lMejqRTs3T3Cdkto+Wo7PioIEUNJBD5y1ZFUdBS6LAudtoz9dyfH3OpMasp
 zjWKmRNF5nfMP1dPymY09Sooa1PhQwPzM64= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38pyfx14c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 22 May 2021 09:39:31 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 09:39:30 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 956842E94481; Sat, 22 May 2021 09:39:25 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next] docs/bpf: add llvm_reloc.rst to explain llvm bpf relocations
Date:   Sat, 22 May 2021 09:39:25 -0700
Message-ID: <20210522163925.3757287-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -bhTFq7r9fkCk4w3UgXUdy0aoREZYr6B
X-Proofpoint-ORIG-GUID: -bhTFq7r9fkCk4w3UgXUdy0aoREZYr6B
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-22_08:2021-05-20,2021-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105220121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLVM upstream commit https://reviews.llvm.org/D102712
made some changes to bpf relocations to make them
llvm linker lld friendly. The scope of
existing relocations R_BPF_64_{64,32} is narrowed
and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
are introduced.

Let us add some documentation about llvm bpf
relocations so people can understand how to resolve
them properly in their respective tools.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/index.rst      |   1 +
 Documentation/bpf/llvm_reloc.rst | 168 +++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 Documentation/bpf/llvm_reloc.rst

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index a702f67dd45f..93e8cf12a6d4 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -84,6 +84,7 @@ Other
    :maxdepth: 1
=20
    ringbuf
+   llvm_reloc
=20
 .. Links:
 .. _networking-filter: ../networking/filter.rst
diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_relo=
c.rst
new file mode 100644
index 000000000000..bc62bce591b1
--- /dev/null
+++ b/Documentation/bpf/llvm_reloc.rst
@@ -0,0 +1,168 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+BPF LLVM Relocations
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This document describes LLVM BPF backend relocation types.
+
+Relocation Record
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+LLVM BPF backend records each relocation with the following 16-byte
+ELF structure::
+
+  typedef struct
+  {
+    Elf64_Addr    r_offset;  // Offset from the beginning of section.
+    Elf64_Xword   r_info;    // Relocation type and symbol index.
+  } Elf64_Rel;
+
+For static function/variable references, the symbol often refers to
+the section itself which has a value of 0. To identify actual static
+function/variable, its section offset or some computation result
+based on section offset is written to the original insn/data buffer,
+which is called ``IA`` (implicit addend) below.  For global
+function/variables, the symbol refers to actual global and the implicit
+addend is 0.
+
+Different Relocation Types
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+Six relocation types are supported. The following is an overview and
+``S`` represents the value of the symbol in the symbol table::
+
+  Enum  ELF Reloc Type     Description      BitSize  Offset        Calcula=
tion
+  0     R_BPF_NONE         None
+  1     R_BPF_64_64        ld_imm64 insn    32       r_offset + 4  S + IA
+  2     R_BPF_64_ABS64     normal data      64       r_offset      S + IA
+  3     R_BPF_64_ABS32     normal data      32       r_offset      S + IA
+  4     R_BPF_64_NODYLD32  .BTF[.ext] data  32       r_offset      S + IA
+  10    R_BPF_64_32        call insn        32       r_offset + 4  (S + IA=
) / 8 - 1
+
+For example, ``R_BPF_64_64`` relocation type is used for ``ld_imm64`` inst=
ruction.
+The actual to-be-relocated data is stored at ``r_offset + 4`` and the read=
/write
+data bitsize is 32 (4 bytes). The relocation can be resolved with
+the symbol value plus implicit addend.
+
+In another case, ``R_BPF_64_ABS64`` relocation type is used for normal 64-=
bit data.
+The actual to-be-relocated data is stored at ``r_offset`` and the read/wri=
te data
+bitsize is 64 (8 bytes). The relocation can be resolved with
+the symbol value plus implicit addend.
+
+Both ``R_BPF_64_ABS32`` and ``R_BPF_64_NODYLD32`` types are for 32-bit dat=
a.
+But ``R_BPF_64_NODYLD32`` specifically refers to relocations in ``.BTF`` a=
nd
+``.BTF.ext`` sections. For cases like bcc where llvm ``ExecutionEngine Run=
timeDyld``
+is involved, ``R_BPF_64_NODYLD32`` types of relocations should not be reso=
lved
+to actual function/variable address. Otherwise, ``.BTF`` and ``.BTF.ext``
+become unusable by bcc and kernel.
+
+Type ``R_BPF_64_32`` is used for call instruction. The call target section
+offset is stored at ``r_offset + 4`` (32bit) and calculated as
+``(S + IA) / 8 - 1``.
+
+Examples
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+Types ``R_BPF_64_64`` and ``R_BPF_64_32`` are used to resolve ``ld_imm64``
+and ``call`` instructions. For example::
+
+  __attribute__((noinline)) __attribute__((section("sec1")))
+  int gfunc(int a, int b) {
+    return a * b;
+  }
+  static __attribute__((noinline)) __attribute__((section("sec1")))
+  int lfunc(int a, int b) {
+    return a + b;
+  }
+  int global __attribute__((section("sec2")));
+  int test(int a, int b) {
+    return gfunc(a, b) +  lfunc(a, b) + global;
+  }
+
+Compiled with ``clang -target bpf -O2 -c test.c``, we will have
+following code with `llvm-objdump -d test.o``::
+
+  Disassembly of section .text:
+
+  0000000000000000 <test>:
+         0:       bf 26 00 00 00 00 00 00 r6 =3D r2
+         1:       bf 17 00 00 00 00 00 00 r7 =3D r1
+         2:       85 10 00 00 ff ff ff ff call -1
+         3:       bf 08 00 00 00 00 00 00 r8 =3D r0
+         4:       bf 71 00 00 00 00 00 00 r1 =3D r7
+         5:       bf 62 00 00 00 00 00 00 r2 =3D r6
+         6:       85 10 00 00 02 00 00 00 call 2
+         7:       0f 80 00 00 00 00 00 00 r0 +=3D r8
+         8:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0=
 ll
+        10:       61 11 00 00 00 00 00 00 r1 =3D *(u32 *)(r1 + 0)
+        11:       0f 10 00 00 00 00 00 00 r0 +=3D r1
+        12:       95 00 00 00 00 00 00 00 exit
+
+  Disassembly of section sec1:
+
+  0000000000000000 <gfunc>:
+         0:       bf 20 00 00 00 00 00 00 r0 =3D r2
+         1:       2f 10 00 00 00 00 00 00 r0 *=3D r1
+         2:       95 00 00 00 00 00 00 00 exit
+
+  0000000000000018 <lfunc>:
+         3:       bf 20 00 00 00 00 00 00 r0 =3D r2
+         4:       0f 10 00 00 00 00 00 00 r0 +=3D r1
+         5:       95 00 00 00 00 00 00 00 exit
+
+Three relocations are generated with ``llvm-readelf -r test.o``::
+
+  Relocation section '.rel.text' at offset 0x188 contains 3 entries:
+      Offset             Info             Type               Symbol's Valu=
e  Symbol's Name
+  0000000000000010  000000040000000a R_BPF_64_32            00000000000000=
00 gfunc
+  0000000000000030  000000020000000a R_BPF_64_32            00000000000000=
00 sec1
+  0000000000000040  0000000600000001 R_BPF_64_64            00000000000000=
00 global
+
+The first relocation corresponds to ``gfunc(a, b)`` where ``gfunc`` has a =
value of 0,
+so the ``call`` instruction offset is ``(0 + 0)/8 - 1 =3D -1``.
+The second relocation corresponds to ``lfunc(a, b)`` where ``lfunc`` has a=
 section
+offset ``0x18``, so the ``call`` instruction offset is ``(0 + 0x18)/8 - 1 =
=3D 2``.
+
+The following is an example to show how R_BPF_64_ABS64 could be generated::
+
+  int global() { return 0; }
+  struct t { void *g; } gbl =3D { global };
+
+Compiled with ``clang -target bpf -O2 -g -c test.c``, we will see a
+relocation below in ``.data`` section with command
+``llvm-readelf -r test.o``::
+
+  Relocation section '.rel.data' at offset 0x458 contains 1 entries:
+      Offset             Info             Type               Symbol's Valu=
e  Symbol's Name
+  0000000000000000  0000000700000002 R_BPF_64_ABS64         00000000000000=
00 global
+
+The relocation says the first 8-byte of ``.data`` section should be
+filled with address of ``global`` variable.
+
+With ``llvm-readelf`` output, we can see that dwarf sections have a bunch =
of
+``R_BPF_64_ABS32`` and ``R_BPF_64_ABS64`` relocations::
+
+  Relocation section '.rel.debug_info' at offset 0x468 contains 13 entries:
+      Offset             Info             Type               Symbol's Valu=
e  Symbol's Name
+  0000000000000006  0000000300000003 R_BPF_64_ABS32         00000000000000=
00 .debug_abbrev
+  000000000000000c  0000000400000003 R_BPF_64_ABS32         00000000000000=
00 .debug_str
+  0000000000000012  0000000400000003 R_BPF_64_ABS32         00000000000000=
00 .debug_str
+  0000000000000016  0000000600000003 R_BPF_64_ABS32         00000000000000=
00 .debug_line
+  000000000000001a  0000000400000003 R_BPF_64_ABS32         00000000000000=
00 .debug_str
+  000000000000001e  0000000200000002 R_BPF_64_ABS64         00000000000000=
00 .text
+  000000000000002b  0000000400000003 R_BPF_64_ABS32         00000000000000=
00 .debug_str
+  0000000000000037  0000000800000002 R_BPF_64_ABS64         00000000000000=
00 gbl
+  0000000000000040  0000000400000003 R_BPF_64_ABS32         00000000000000=
00 .debug_str
+  ......
+
+The .BTF/.BTF.ext sections has R_BPF_64_NODYLD32 relocations::
+
+  Relocation section '.rel.BTF' at offset 0x538 contains 1 entries:
+      Offset             Info             Type               Symbol's Valu=
e  Symbol's Name
+  0000000000000084  0000000800000004 R_BPF_64_NODYLD32      00000000000000=
00 gbl
+
+  Relocation section '.rel.BTF.ext' at offset 0x548 contains 2 entries:
+      Offset             Info             Type               Symbol's Valu=
e  Symbol's Name
+  000000000000002c  0000000200000004 R_BPF_64_NODYLD32      00000000000000=
00 .text
+  0000000000000040  0000000200000004 R_BPF_64_NODYLD32      00000000000000=
00 .text
--=20
2.30.2

