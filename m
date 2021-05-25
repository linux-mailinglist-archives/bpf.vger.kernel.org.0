Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF24C3908F8
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 20:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhEYSbZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 14:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhEYSbZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 14:31:25 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4717FC061574
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 11:29:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 6so23420382pgk.5
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 11:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/2LVRQebRLn2XlD8JvYGpgsC2DgIrktnhNjW0rCGqpE=;
        b=bGVHOEscfVc6bMjCr5OWyvrxFWPB6YyhObye910UfP1WdQ3iptBI7UubKaO4Ni5liV
         QFytQCUkjEOMFjxqXz5LEFwzSi4u662mAfbx2Q/iHiBlXdrV3Do8avWmprhCEhoSaYpZ
         wdJUfFA2CPnwiPkcbaP9vKEW4N5RcI0apqPMgvFCAABTMo0JYnpGqP36q/BGhOctJdU9
         gGLRSJTnowsJsRn3FG6YJj9dsWCWs1yrMp4c6vvsE36eD1h7kaFIUIo3wmZiE8wvPgdH
         qt6d6Pb2E8Z4XhZf7i7Pp1Y2bXOG8HiANbwQoO17+dHKHQ3mHPlx9bN5jOeij0gd8FQA
         oNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/2LVRQebRLn2XlD8JvYGpgsC2DgIrktnhNjW0rCGqpE=;
        b=g6xugnrU2OkdmE106NhYRLDiyll5KfcJYIVY5rD+F7HT9pZwLgIawhE6C/9tlxUi3t
         rSZTeFQ5NvKDwn9FvOz5SwZ2dQ2WLHhOHt16gU3T71HzT0Twi/8OujFbMOVGrCU75I2m
         vnvXxuLxqFscjIG5DpMVWORDOMsBcMLmCuh2OqGj+BwUP1kUAJA8uvQSQJ6Ogz651ESa
         TjzR6Oo0sam+xx/XF1C5DpExmRTMmSxlhYmXONL//vujnCTE0VQb9o9PxY8SSqhfHFgQ
         l4MDVY89QbEW2LR4wbOFHIgC9HkX90wrKrNgn/mFkwwZFcE4svHAAfydAWkqbA/8UyPh
         SkEg==
X-Gm-Message-State: AOAM531Hl8uCpkhO+8spBDLmmdb+aPKdhju9ttsE9T52EhY+ZWeJF2Ps
        FE4Q2m4nWZmG4CXTe+foAU95sA==
X-Google-Smtp-Source: ABdhPJzC8V+Rm6BsYwM4DF6/AMJO12AmXMUFUBJiYqzGOMSNoYzf4LjmJD3cidlrQXZtdMgZ6jH8Yg==
X-Received: by 2002:a05:6a00:14d0:b029:2cf:ee47:dfd9 with SMTP id w16-20020a056a0014d0b02902cfee47dfd9mr32058312pfu.31.1621967393436;
        Tue, 25 May 2021 11:29:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:46a9:fe46:5f4d:e804])
        by smtp.gmail.com with ESMTPSA id u23sm13617750pfn.106.2021.05.25.11.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 11:29:53 -0700 (PDT)
Date:   Tue, 25 May 2021 11:29:48 -0700
From:   Fangrui Song <maskray@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: add llvm_reloc.rst to explain llvm
 bpf relocations
Message-ID: <20210525182948.4wk3kd7vrvgdr2lu@google.com>
References: <20210525033314.3008878-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210525033314.3008878-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I have a review queue with a huge pile of LLVM patches and have only
skimmed through this.

First, if the size benefit of REL over RELA isn't deem that necessary,
I will highly recommend RELA for simplicity and robustness.
REL is error-prone.

On 2021-05-24, Yonghong Song wrote:
>LLVM upstream commit https://reviews.llvm.org/D102712
>made some changes to bpf relocations to make them
>llvm linker lld friendly. The scope of
>existing relocations R_BPF_64_{64,32} is narrowed
>and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
>are introduced.
>
>Let us add some documentation about llvm bpf
>relocations so people can understand how to resolve
>them properly in their respective tools.
>
>Cc: John Fastabend <john.fastabend@gmail.com>
>Cc: Lorenz Bauer <lmb@cloudflare.com>
>Signed-off-by: Yonghong Song <yhs@fb.com>
>---
> Documentation/bpf/index.rst            |   1 +
> Documentation/bpf/llvm_reloc.rst       | 240 +++++++++++++++++++++++++
> tools/testing/selftests/bpf/README.rst |  19 ++
> 3 files changed, 260 insertions(+)
> create mode 100644 Documentation/bpf/llvm_reloc.rst
>
>Changelogs:
>  v1 -> v2:
>    - add an example to illustrate how relocations related to base
>      section and symbol table and what is "Implicit Addend"
>    - clarify why we use 32bit read/write for R_BPF_64_64 (ld_imm64)
>      relocations.
>
>diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
>index a702f67dd45f..93e8cf12a6d4 100644
>--- a/Documentation/bpf/index.rst
>+++ b/Documentation/bpf/index.rst
>@@ -84,6 +84,7 @@ Other
>    :maxdepth: 1
>
>    ringbuf
>+   llvm_reloc
>
> .. Links:
> .. _networking-filter: ../networking/filter.rst
>diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
>new file mode 100644
>index 000000000000..5ade0244958f
>--- /dev/null
>+++ b/Documentation/bpf/llvm_reloc.rst
>@@ -0,0 +1,240 @@
>+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>+
>+====================
>+BPF LLVM Relocations
>+====================
>+
>+This document describes LLVM BPF backend relocation types.
>+
>+Relocation Record
>+=================
>+
>+LLVM BPF backend records each relocation with the following 16-byte
>+ELF structure::
>+
>+  typedef struct
>+  {
>+    Elf64_Addr    r_offset;  // Offset from the beginning of section.
>+    Elf64_Xword   r_info;    // Relocation type and symbol index.
>+  } Elf64_Rel;
>+
>+For example, for the following code::
>+
>+  int g1 __attribute__((section("sec")));
>+  int g2 __attribute__((section("sec")));
>+  static volatile int l1 __attribute__((section("sec")));
>+  static volatile int l2 __attribute__((section("sec")));
>+  int test() {
>+    return g1 + g2 + l1 + l2;
>+  }
>+
>+Compiled with ``clang -target bpf -O2 -c test.c``, the following is
>+the code with ``llvm-objdump -dr test.o``::
>+
>+       0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>+                0000000000000000:  R_BPF_64_64  g1
>+       2:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>+       3:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0 ll
>+                0000000000000018:  R_BPF_64_64  g2
>+       5:       61 20 00 00 00 00 00 00 r0 = *(u32 *)(r2 + 0)
>+       6:       0f 10 00 00 00 00 00 00 r0 += r1
>+       7:       18 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00 r1 = 8 ll
>+                0000000000000038:  R_BPF_64_64  sec
>+       9:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>+      10:       0f 10 00 00 00 00 00 00 r0 += r1
>+      11:       18 01 00 00 0c 00 00 00 00 00 00 00 00 00 00 00 r1 = 12 ll
>+                0000000000000058:  R_BPF_64_64  sec
>+      13:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>+      14:       0f 10 00 00 00 00 00 00 r0 += r1
>+      15:       95 00 00 00 00 00 00 00 exit
>+
>+There are four relations in the above for four ``LD_imm64`` instructions.
>+The following ``llvm-readelf -r test.o`` shows the binary values of the four
>+relocations::
>+
>+  Relocation section '.rel.text' at offset 0x190 contains 4 entries:
>+      Offset             Info             Type               Symbol's Value  Symbol's Name
>+  0000000000000000  0000000600000001 R_BPF_64_64            0000000000000000 g1
>+  0000000000000018  0000000700000001 R_BPF_64_64            0000000000000004 g2
>+  0000000000000038  0000000400000001 R_BPF_64_64            0000000000000000 sec
>+  0000000000000058  0000000400000001 R_BPF_64_64            0000000000000000 sec
>+
>+Each relocation is represented by ``Offset`` (8 bytes) and ``Info`` (8 bytes).
>+For example, the first relocation corresponds to the first instruction
>+(Offset 0x0) and the corresponding ``Info`` indicates the relocation type
>+of ``R_BPF_64_64`` (type 1) and the entry in the symbol table (entry 6).
>+The following is the symbol table with ``llvm-readelf -s test.o``::
>+
>+  Symbol table '.symtab' contains 8 entries:
>+     Num:    Value          Size Type    Bind   Vis       Ndx Name
>+       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND
>+       1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS test.c
>+       2: 0000000000000008     4 OBJECT  LOCAL  DEFAULT     4 l1
>+       3: 000000000000000c     4 OBJECT  LOCAL  DEFAULT     4 l2
>+       4: 0000000000000000     0 SECTION LOCAL  DEFAULT     4 sec
>+       5: 0000000000000000   128 FUNC    GLOBAL DEFAULT     2 test
>+       6: 0000000000000000     4 OBJECT  GLOBAL DEFAULT     4 g1
>+       7: 0000000000000004     4 OBJECT  GLOBAL DEFAULT     4 g2
>+
>+The 6th entry is global variable ``g1`` with value 0.
>+
>+Similarly, the second relocation is at ``.text`` offset ``0x18``, instruction 3,
>+for global variable ``g2`` which has a symbol value 4, the offset
>+from the start of ``.data`` section.
>+
>+The third and fourth relocations refers to static variables ``l1``
>+and ``l2``. From ``.rel.text`` section above, it is not clear
>+which symbols they really refers to as they both refers to
>+symbol table entry 4, symbol ``sec``, which has ``SECTION`` type

STT_SECTION. `SECTION` is just an abbreviated form used by some binary
tools.

>+and represents a section. So for static variable or function,
>+the section offset is written to the original insn
>+buffer, which is called ``IA`` (implicit addend). Looking at
>+above insn ``7`` and ``11``, they have section offset ``8`` and ``12``.
>+From symbol table, we can find that they correspond to entries ``2``
>+and ``3`` for ``l1`` and ``l2``.

The other REL based psABIs all use `A` for addend.

>+In general, the ``IA`` is 0 for global variables and functions,
>+and is the section offset or some computation result based on
>+section offset for static variables/functions. The non-section-offset
>+case refers to function calls. See below for more details.
>+
>+Different Relocation Types
>+==========================
>+
>+Six relocation types are supported. The following is an overview and
>+``S`` represents the value of the symbol in the symbol table::
>+
>+  Enum  ELF Reloc Type     Description      BitSize  Offset        Calculation
>+  0     R_BPF_NONE         None
>+  1     R_BPF_64_64        ld_imm64 insn    32       r_offset + 4  S + IA
>+  2     R_BPF_64_ABS64     normal data      64       r_offset      S + IA
>+  3     R_BPF_64_ABS32     normal data      32       r_offset      S + IA
>+  4     R_BPF_64_NODYLD32  .BTF[.ext] data  32       r_offset      S + IA
>+  10    R_BPF_64_32        call insn        32       r_offset + 4  (S + IA) / 8 - 1

Shifting the offset by 4 looks weird. R_386_32 applies at r_offset.
The call instruction  R_BPF_64_32 is strange. Such special calculation
should not be named R_BPF_64_32.

>+For example, ``R_BPF_64_64`` relocation type is used for ``ld_imm64`` instruction.
>+The actual to-be-relocated data (0 or section offset)
>+is stored at ``r_offset + 4`` and the read/write
>+data bitsize is 32 (4 bytes). The relocation can be resolved with
>+the symbol value plus implicit addend. Note that the ``BitSize`` is 32 which
>+means the section offset must be less than or equal to ``UINT32_MAX`` and this
>+is enforced by LLVM BPF backend.
>+
>+In another case, ``R_BPF_64_ABS64`` relocation type is used for normal 64-bit data.
>+The actual to-be-relocated data is stored at ``r_offset`` and the read/write data
>+bitsize is 64 (8 bytes). The relocation can be resolved with
>+the symbol value plus implicit addend.
>+
>+Both ``R_BPF_64_ABS32`` and ``R_BPF_64_NODYLD32`` types are for 32-bit data.
>+But ``R_BPF_64_NODYLD32`` specifically refers to relocations in ``.BTF`` and
>+``.BTF.ext`` sections. For cases like bcc where llvm ``ExecutionEngine RuntimeDyld``
>+is involved, ``R_BPF_64_NODYLD32`` types of relocations should not be resolved
>+to actual function/variable address. Otherwise, ``.BTF`` and ``.BTF.ext``
>+become unusable by bcc and kernel.

Why cannot R_BPF_64_ABS32 cover the use cases of R_BPF_64_NODYLD32?
I haven't seen any relocation type which hard coding knowledge on data
sections.

>+Type ``R_BPF_64_32`` is used for call instruction. The call target section
>+offset is stored at ``r_offset + 4`` (32bit) and calculated as
>+``(S + IA) / 8 - 1``.

In other ABIs, names like 32/ABS32/ABS64 refer to absolute relocation types
without such complex operation.

>+Examples
>+========
>+
>+Types ``R_BPF_64_64`` and ``R_BPF_64_32`` are used to resolve ``ld_imm64``
>+and ``call`` instructions. For example::
>+
>+  __attribute__((noinline)) __attribute__((section("sec1")))
>+  int gfunc(int a, int b) {
>+    return a * b;
>+  }
>+  static __attribute__((noinline)) __attribute__((section("sec1")))
>+  int lfunc(int a, int b) {
>+    return a + b;
>+  }
>+  int global __attribute__((section("sec2")));
>+  int test(int a, int b) {
>+    return gfunc(a, b) +  lfunc(a, b) + global;
>+  }
>+
>+Compiled with ``clang -target bpf -O2 -c test.c``, we will have
>+following code with `llvm-objdump -dr test.o``::
>+
>+  Disassembly of section .text:
>+
>+  0000000000000000 <test>:
>+         0:       bf 26 00 00 00 00 00 00 r6 = r2
>+         1:       bf 17 00 00 00 00 00 00 r7 = r1
>+         2:       85 10 00 00 ff ff ff ff call -1
>+                  0000000000000010:  R_BPF_64_32  gfunc
>+         3:       bf 08 00 00 00 00 00 00 r8 = r0
>+         4:       bf 71 00 00 00 00 00 00 r1 = r7
>+         5:       bf 62 00 00 00 00 00 00 r2 = r6
>+         6:       85 10 00 00 02 00 00 00 call 2
>+                  0000000000000030:  R_BPF_64_32  sec1
>+         7:       0f 80 00 00 00 00 00 00 r0 += r8
>+         8:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>+                  0000000000000040:  R_BPF_64_64  global
>+        10:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>+        11:       0f 10 00 00 00 00 00 00 r0 += r1
>+        12:       95 00 00 00 00 00 00 00 exit
>+
>+  Disassembly of section sec1:
>+
>+  0000000000000000 <gfunc>:
>+         0:       bf 20 00 00 00 00 00 00 r0 = r2
>+         1:       2f 10 00 00 00 00 00 00 r0 *= r1
>+         2:       95 00 00 00 00 00 00 00 exit
>+
>+  0000000000000018 <lfunc>:
>+         3:       bf 20 00 00 00 00 00 00 r0 = r2
>+         4:       0f 10 00 00 00 00 00 00 r0 += r1
>+         5:       95 00 00 00 00 00 00 00 exit
>+
>+The first relocation corresponds to ``gfunc(a, b)`` where ``gfunc`` has a value of 0,
>+so the ``call`` instruction offset is ``(0 + 0)/8 - 1 = -1``.
>+The second relocation corresponds to ``lfunc(a, b)`` where ``lfunc`` has a section
>+offset ``0x18``, so the ``call`` instruction offset is ``(0 + 0x18)/8 - 1 = 2``.
>+The third relocation corresponds to ld_imm64 of ``global``, which has a section
>+offset ``0``.
>+
>+The following is an example to show how R_BPF_64_ABS64 could be generated::
>+
>+  int global() { return 0; }
>+  struct t { void *g; } gbl = { global };
>+
>+Compiled with ``clang -target bpf -O2 -g -c test.c``, we will see a
>+relocation below in ``.data`` section with command
>+``llvm-readelf -r test.o``::
>+
>+  Relocation section '.rel.data' at offset 0x458 contains 1 entries:
>+      Offset             Info             Type               Symbol's Value  Symbol's Name
>+  0000000000000000  0000000700000002 R_BPF_64_ABS64         0000000000000000 global
>+
>+The relocation says the first 8-byte of ``.data`` section should be
>+filled with address of ``global`` variable.
>+
>+With ``llvm-readelf`` output, we can see that dwarf sections have a bunch of
>+``R_BPF_64_ABS32`` and ``R_BPF_64_ABS64`` relocations::
>+
>+  Relocation section '.rel.debug_info' at offset 0x468 contains 13 entries:
>+      Offset             Info             Type               Symbol's Value  Symbol's Name
>+  0000000000000006  0000000300000003 R_BPF_64_ABS32         0000000000000000 .debug_abbrev
>+  000000000000000c  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
>+  0000000000000012  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
>+  0000000000000016  0000000600000003 R_BPF_64_ABS32         0000000000000000 .debug_line
>+  000000000000001a  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
>+  000000000000001e  0000000200000002 R_BPF_64_ABS64         0000000000000000 .text
>+  000000000000002b  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
>+  0000000000000037  0000000800000002 R_BPF_64_ABS64         0000000000000000 gbl
>+  0000000000000040  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
>+  ......
>+
>+The .BTF/.BTF.ext sections has R_BPF_64_NODYLD32 relocations::
>+
>+  Relocation section '.rel.BTF' at offset 0x538 contains 1 entries:
>+      Offset             Info             Type               Symbol's Value  Symbol's Name
>+  0000000000000084  0000000800000004 R_BPF_64_NODYLD32      0000000000000000 gbl
>+
>+  Relocation section '.rel.BTF.ext' at offset 0x548 contains 2 entries:
>+      Offset             Info             Type               Symbol's Value  Symbol's Name
>+  000000000000002c  0000000200000004 R_BPF_64_NODYLD32      0000000000000000 .text
>+  0000000000000040  0000000200000004 R_BPF_64_NODYLD32      0000000000000000 .text
>diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
>index 3353778c30f8..8deec1ca9150 100644
>--- a/tools/testing/selftests/bpf/README.rst
>+++ b/tools/testing/selftests/bpf/README.rst
>@@ -202,3 +202,22 @@ generate valid BTF information for weak variables. Please make sure you use
> Clang that contains the fix.
>
> __ https://reviews.llvm.org/D100362
>+
>+Clang relocation changes
>+========================
>+
>+Clang 13 patch `clang reloc patch`_  made some changes on relocations such
>+that existing relocation types are broken into more types and
>+each new type corresponds to only one way to resolve relocation.
>+See `kernel llvm reloc`_ for more explanation and some examples.
>+Using clang 13 to compile old libbpf which has static linker support,
>+there will be a compilation failure::
>+
>+  libbpf: ELF relo #0 in section #6 has unexpected type 2 in .../bpf_tcp_nogpl.o
>+
>+Here, ``type 2`` refers to new relocation type ``R_BPF_64_ABS64``.
>+To fix this issue, user newer libbpf.
>+
>+.. Links
>+.. _clang reloc patch: https://reviews.llvm.org/D102712
>+.. _kernel llvm reloc: /Documentation/bpf/llvm_reloc.rst
>-- 
>2.30.2
>
