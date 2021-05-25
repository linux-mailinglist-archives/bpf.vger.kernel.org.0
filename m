Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2315438F8DB
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 05:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhEYDeu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 23:34:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60598 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhEYDeu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 May 2021 23:34:50 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14P3PAOk005429
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 20:33:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=y43hJdduBis78NQ1k5bxo/46HTizr4N++i6bUezGby4=;
 b=AV6P5dOVBJ7k4PWGb4W/9Tb09Q79p0E5EWzNQt9ELHXiebrZzi2YjKgnob9qXm5F30yk
 61iLdf8zhIMX/W9d1NQcV5x3ZRKeJzm2hfR1R5U9vbpL9Jv8nwwczNCkHGlLdS+71t9Z
 VzKMWZb7QuPnUddbNZ8dN6zG8J9O4tQBzDo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38ret9m3en-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 20:33:19 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 20:33:18 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 536BE3022D23; Mon, 24 May 2021 20:33:14 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2] docs/bpf: add llvm_reloc.rst to explain llvm bpf relocations
Date:   Mon, 24 May 2021 20:33:14 -0700
Message-ID: <20210525033314.3008878-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8GJaYP-whnnhIwD_YbuSaOUvV-Js6-8-
X-Proofpoint-GUID: 8GJaYP-whnnhIwD_YbuSaOUvV-Js6-8-
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_02:2021-05-24,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250023
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
 Documentation/bpf/index.rst            |   1 +
 Documentation/bpf/llvm_reloc.rst       | 240 +++++++++++++++++++++++++
 tools/testing/selftests/bpf/README.rst |  19 ++
 3 files changed, 260 insertions(+)
 create mode 100644 Documentation/bpf/llvm_reloc.rst

Changelogs:
  v1 -> v2:
    - add an example to illustrate how relocations related to base
      section and symbol table and what is "Implicit Addend"
    - clarify why we use 32bit read/write for R_BPF_64_64 (ld_imm64)
      relocations.

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
index 000000000000..5ade0244958f
--- /dev/null
+++ b/Documentation/bpf/llvm_reloc.rst
@@ -0,0 +1,240 @@
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
+For example, for the following code::
+
+  int g1 __attribute__((section("sec")));
+  int g2 __attribute__((section("sec")));
+  static volatile int l1 __attribute__((section("sec")));
+  static volatile int l2 __attribute__((section("sec")));
+  int test() {
+    return g1 + g2 + l1 + l2;
+  }
+
+Compiled with ``clang -target bpf -O2 -c test.c``, the following is
+the code with ``llvm-objdump -dr test.o``::
+
+       0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0 ll
+                0000000000000000:  R_BPF_64_64  g1
+       2:       61 11 00 00 00 00 00 00 r1 =3D *(u32 *)(r1 + 0)
+       3:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 =3D 0 ll
+                0000000000000018:  R_BPF_64_64  g2
+       5:       61 20 00 00 00 00 00 00 r0 =3D *(u32 *)(r2 + 0)
+       6:       0f 10 00 00 00 00 00 00 r0 +=3D r1
+       7:       18 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 8 ll
+                0000000000000038:  R_BPF_64_64  sec
+       9:       61 11 00 00 00 00 00 00 r1 =3D *(u32 *)(r1 + 0)
+      10:       0f 10 00 00 00 00 00 00 r0 +=3D r1
+      11:       18 01 00 00 0c 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 12 =
ll
+                0000000000000058:  R_BPF_64_64  sec
+      13:       61 11 00 00 00 00 00 00 r1 =3D *(u32 *)(r1 + 0)
+      14:       0f 10 00 00 00 00 00 00 r0 +=3D r1
+      15:       95 00 00 00 00 00 00 00 exit
+
+There are four relations in the above for four ``LD_imm64`` instructions.
+The following ``llvm-readelf -r test.o`` shows the binary values of the fo=
ur
+relocations::
+
+  Relocation section '.rel.text' at offset 0x190 contains 4 entries:
+      Offset             Info             Type               Symbol's Valu=
e  Symbol's Name
+  0000000000000000  0000000600000001 R_BPF_64_64            00000000000000=
00 g1
+  0000000000000018  0000000700000001 R_BPF_64_64            00000000000000=
04 g2
+  0000000000000038  0000000400000001 R_BPF_64_64            00000000000000=
00 sec
+  0000000000000058  0000000400000001 R_BPF_64_64            00000000000000=
00 sec
+
+Each relocation is represented by ``Offset`` (8 bytes) and ``Info`` (8 byt=
es).
+For example, the first relocation corresponds to the first instruction
+(Offset 0x0) and the corresponding ``Info`` indicates the relocation type
+of ``R_BPF_64_64`` (type 1) and the entry in the symbol table (entry 6).
+The following is the symbol table with ``llvm-readelf -s test.o``::
+
+  Symbol table '.symtab' contains 8 entries:
+     Num:    Value          Size Type    Bind   Vis       Ndx Name
+       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND
+       1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS test.c
+       2: 0000000000000008     4 OBJECT  LOCAL  DEFAULT     4 l1
+       3: 000000000000000c     4 OBJECT  LOCAL  DEFAULT     4 l2
+       4: 0000000000000000     0 SECTION LOCAL  DEFAULT     4 sec
+       5: 0000000000000000   128 FUNC    GLOBAL DEFAULT     2 test
+       6: 0000000000000000     4 OBJECT  GLOBAL DEFAULT     4 g1
+       7: 0000000000000004     4 OBJECT  GLOBAL DEFAULT     4 g2
+
+The 6th entry is global variable ``g1`` with value 0.
+
+Similarly, the second relocation is at ``.text`` offset ``0x18``, instruct=
ion 3,
+for global variable ``g2`` which has a symbol value 4, the offset
+from the start of ``.data`` section.
+
+The third and fourth relocations refers to static variables ``l1``
+and ``l2``. From ``.rel.text`` section above, it is not clear
+which symbols they really refers to as they both refers to
+symbol table entry 4, symbol ``sec``, which has ``SECTION`` type
+and represents a section. So for static variable or function,
+the section offset is written to the original insn
+buffer, which is called ``IA`` (implicit addend). Looking at
+above insn ``7`` and ``11``, they have section offset ``8`` and ``12``.
+From symbol table, we can find that they correspond to entries ``2``
+and ``3`` for ``l1`` and ``l2``.
+
+In general, the ``IA`` is 0 for global variables and functions,
+and is the section offset or some computation result based on
+section offset for static variables/functions. The non-section-offset
+case refers to function calls. See below for more details.
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
+The actual to-be-relocated data (0 or section offset)
+is stored at ``r_offset + 4`` and the read/write
+data bitsize is 32 (4 bytes). The relocation can be resolved with
+the symbol value plus implicit addend. Note that the ``BitSize`` is 32 whi=
ch
+means the section offset must be less than or equal to ``UINT32_MAX`` and =
this
+is enforced by LLVM BPF backend.
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
+following code with `llvm-objdump -dr test.o``::
+
+  Disassembly of section .text:
+
+  0000000000000000 <test>:
+         0:       bf 26 00 00 00 00 00 00 r6 =3D r2
+         1:       bf 17 00 00 00 00 00 00 r7 =3D r1
+         2:       85 10 00 00 ff ff ff ff call -1
+                  0000000000000010:  R_BPF_64_32  gfunc
+         3:       bf 08 00 00 00 00 00 00 r8 =3D r0
+         4:       bf 71 00 00 00 00 00 00 r1 =3D r7
+         5:       bf 62 00 00 00 00 00 00 r2 =3D r6
+         6:       85 10 00 00 02 00 00 00 call 2
+                  0000000000000030:  R_BPF_64_32  sec1
+         7:       0f 80 00 00 00 00 00 00 r0 +=3D r8
+         8:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0=
 ll
+                  0000000000000040:  R_BPF_64_64  global
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
+The first relocation corresponds to ``gfunc(a, b)`` where ``gfunc`` has a =
value of 0,
+so the ``call`` instruction offset is ``(0 + 0)/8 - 1 =3D -1``.
+The second relocation corresponds to ``lfunc(a, b)`` where ``lfunc`` has a=
 section
+offset ``0x18``, so the ``call`` instruction offset is ``(0 + 0x18)/8 - 1 =
=3D 2``.
+The third relocation corresponds to ld_imm64 of ``global``, which has a se=
ction
+offset ``0``.
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
diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftes=
ts/bpf/README.rst
index 3353778c30f8..8deec1ca9150 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -202,3 +202,22 @@ generate valid BTF information for weak variables. Ple=
ase make sure you use
 Clang that contains the fix.
=20
 __ https://reviews.llvm.org/D100362
+
+Clang relocation changes
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Clang 13 patch `clang reloc patch`_  made some changes on relocations such
+that existing relocation types are broken into more types and
+each new type corresponds to only one way to resolve relocation.
+See `kernel llvm reloc`_ for more explanation and some examples.
+Using clang 13 to compile old libbpf which has static linker support,
+there will be a compilation failure::
+
+  libbpf: ELF relo #0 in section #6 has unexpected type 2 in .../bpf_tcp_n=
ogpl.o
+
+Here, ``type 2`` refers to new relocation type ``R_BPF_64_ABS64``.
+To fix this issue, user newer libbpf.
+
+.. Links
+.. _clang reloc patch: https://reviews.llvm.org/D102712
+.. _kernel llvm reloc: /Documentation/bpf/llvm_reloc.rst
--=20
2.30.2

