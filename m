Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1838F231
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhEXRY4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 13:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhEXRY4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 13:24:56 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3ECC061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 10:23:27 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o18so1457833ybc.8
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYL4yMkEhuYb305pUmtDEdKA2/cg+BBnV0Pf5XqJkxo=;
        b=REH/4bxpRQSqgQEzzbrnKkxr5UvBymk/wF5Dz2vsbRDkauEG+F5bYfL7zLTczs7LxB
         zxYT0+q5quv62pvml+FhjpOQ9EoRcCQmsmamijUuPuWAxfplcBCFk5vGooi5HkOjkdqm
         je2gJ4N8IuOWhOxRzivUzQtjGCisgC1muUkFst3DTFU2/jEJqmSln29ZtefYKHddN3Z0
         qiHAGelP1VDhQ9W9piqXdwA0j8p36KNzXW73OQaObOogPdQ+BPBIZLF2COYSOSG6O6ZJ
         VUnzwoyIPVqyrsjCx2yB1inW0AjDzdJgbOdn9YQ6iBjq0QqAzNQEDZTTZ6se+HVFSNP1
         skfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYL4yMkEhuYb305pUmtDEdKA2/cg+BBnV0Pf5XqJkxo=;
        b=ZjfMtQpcrzldfVZerplj1dWRSPUGOnHcO45vNCTwOkmkaisGyilP3iwRhaYt07f5vD
         jZT1d6jYFjcGE52R6Cl33NmMtjV7hFi2f7E6qWbY2EiPZnTWyT6jd1g7zsxsLLKnqeg7
         qClouFjbNBA45wcu+2IwgvJiVpyHYBNT9VfQj3se1hAfiyb96T+gjqK1eENBYZ9pD7tS
         el8nc+EHGU/7FYJTut0X/68zM/ZjOzaYLX9PylgXL1UIfZjA4wob62n1Xz2wD5D5ZnM1
         Q5ulZjZw5tsq5AiMLcBQk15hqiBjs9iycGVuA26b5T9oCWxIbkg3XeMkw4Pvk4ra0CqA
         5OFw==
X-Gm-Message-State: AOAM5332jrzmwDtFMy1GNJ789iaWa6vwQqw1mS1ir5e+sTaTvQFsVDes
        2CAjPnUYtKvGWBOAulEG6tggnZkjuF8zIBkZJq7lO58q
X-Google-Smtp-Source: ABdhPJz1YqJH80cKUkDSBuqmVzroLKbjWe23Q7cZ46MEJS+8XdDPq6aJGUuYoILuJ2zm7sVL0xdTUjU6xrB8suZq5Tc=
X-Received: by 2002:a5b:286:: with SMTP id x6mr38288595ybl.347.1621877006463;
 Mon, 24 May 2021 10:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210522163925.3757287-1-yhs@fb.com>
In-Reply-To: <20210522163925.3757287-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 May 2021 10:23:15 -0700
Message-ID: <CAEf4Bzb+gqH6aB72y+vCaHrq7HNNAROPV+2X0976CzCAmY8Jrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: add llvm_reloc.rst to explain llvm bpf relocations
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 22, 2021 at 9:39 AM Yonghong Song <yhs@fb.com> wrote:
>
> LLVM upstream commit https://reviews.llvm.org/D102712
> made some changes to bpf relocations to make them
> llvm linker lld friendly. The scope of
> existing relocations R_BPF_64_{64,32} is narrowed
> and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
> are introduced.
>
> Let us add some documentation about llvm bpf
> relocations so people can understand how to resolve
> them properly in their respective tools.
>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  Documentation/bpf/index.rst      |   1 +
>  Documentation/bpf/llvm_reloc.rst | 168 +++++++++++++++++++++++++++++++
>  2 files changed, 169 insertions(+)
>  create mode 100644 Documentation/bpf/llvm_reloc.rst
>
> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> index a702f67dd45f..93e8cf12a6d4 100644
> --- a/Documentation/bpf/index.rst
> +++ b/Documentation/bpf/index.rst
> @@ -84,6 +84,7 @@ Other
>     :maxdepth: 1
>
>     ringbuf
> +   llvm_reloc
>
>  .. Links:
>  .. _networking-filter: ../networking/filter.rst
> diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
> new file mode 100644
> index 000000000000..bc62bce591b1
> --- /dev/null
> +++ b/Documentation/bpf/llvm_reloc.rst
> @@ -0,0 +1,168 @@
> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +
> +====================
> +BPF LLVM Relocations
> +====================
> +
> +This document describes LLVM BPF backend relocation types.
> +
> +Relocation Record
> +=================
> +
> +LLVM BPF backend records each relocation with the following 16-byte
> +ELF structure::
> +
> +  typedef struct
> +  {
> +    Elf64_Addr    r_offset;  // Offset from the beginning of section.
> +    Elf64_Xword   r_info;    // Relocation type and symbol index.
> +  } Elf64_Rel;
> +
> +For static function/variable references, the symbol often refers to
> +the section itself which has a value of 0. To identify actual static
> +function/variable, its section offset or some computation result
> +based on section offset is written to the original insn/data buffer,
> +which is called ``IA`` (implicit addend) below.  For global
> +function/variables, the symbol refers to actual global and the implicit
> +addend is 0.
> +
> +Different Relocation Types
> +==========================
> +
> +Six relocation types are supported. The following is an overview and
> +``S`` represents the value of the symbol in the symbol table::
> +
> +  Enum  ELF Reloc Type     Description      BitSize  Offset        Calculation
> +  0     R_BPF_NONE         None
> +  1     R_BPF_64_64        ld_imm64 insn    32       r_offset + 4  S + IA

There are cases where we set all 64-bits of ld_imm64 (e.g., extern
ksym, global variables). Or those will be a different relocation now
(R_BPF_64_ABS64?). If not, I think BitSize 64 is more correct here.

Looking at LLVM diff I haven't found a test for global variables (at
least I didn't realize it was there), so double-checking here (and it
might be a good idea to have an explicit test for global variables?)

> +  2     R_BPF_64_ABS64     normal data      64       r_offset      S + IA
> +  3     R_BPF_64_ABS32     normal data      32       r_offset      S + IA
> +  4     R_BPF_64_NODYLD32  .BTF[.ext] data  32       r_offset      S + IA
> +  10    R_BPF_64_32        call insn        32       r_offset + 4  (S + IA) / 8 - 1
> +
> +For example, ``R_BPF_64_64`` relocation type is used for ``ld_imm64`` instruction.
> +The actual to-be-relocated data is stored at ``r_offset + 4`` and the read/write
> +data bitsize is 32 (4 bytes). The relocation can be resolved with
> +the symbol value plus implicit addend.
> +
> +In another case, ``R_BPF_64_ABS64`` relocation type is used for normal 64-bit data.
> +The actual to-be-relocated data is stored at ``r_offset`` and the read/write data
> +bitsize is 64 (8 bytes). The relocation can be resolved with
> +the symbol value plus implicit addend.
> +
> +Both ``R_BPF_64_ABS32`` and ``R_BPF_64_NODYLD32`` types are for 32-bit data.
> +But ``R_BPF_64_NODYLD32`` specifically refers to relocations in ``.BTF`` and
> +``.BTF.ext`` sections. For cases like bcc where llvm ``ExecutionEngine RuntimeDyld``
> +is involved, ``R_BPF_64_NODYLD32`` types of relocations should not be resolved
> +to actual function/variable address. Otherwise, ``.BTF`` and ``.BTF.ext``
> +become unusable by bcc and kernel.
> +
> +Type ``R_BPF_64_32`` is used for call instruction. The call target section
> +offset is stored at ``r_offset + 4`` (32bit) and calculated as
> +``(S + IA) / 8 - 1``.
> +
> +Examples
> +========
> +
> +Types ``R_BPF_64_64`` and ``R_BPF_64_32`` are used to resolve ``ld_imm64``
> +and ``call`` instructions. For example::
> +
> +  __attribute__((noinline)) __attribute__((section("sec1")))
> +  int gfunc(int a, int b) {
> +    return a * b;
> +  }
> +  static __attribute__((noinline)) __attribute__((section("sec1")))
> +  int lfunc(int a, int b) {
> +    return a + b;
> +  }
> +  int global __attribute__((section("sec2")));
> +  int test(int a, int b) {
> +    return gfunc(a, b) +  lfunc(a, b) + global;
> +  }
> +
> +Compiled with ``clang -target bpf -O2 -c test.c``, we will have
> +following code with `llvm-objdump -d test.o``::

I recently learned about `llvm-objdump -dr test.o`, which shows
relocations inline, it would be nice to use that output here.

> +
> +  Disassembly of section .text:
> +
> +  0000000000000000 <test>:
> +         0:       bf 26 00 00 00 00 00 00 r6 = r2
> +         1:       bf 17 00 00 00 00 00 00 r7 = r1
> +         2:       85 10 00 00 ff ff ff ff call -1
> +         3:       bf 08 00 00 00 00 00 00 r8 = r0
> +         4:       bf 71 00 00 00 00 00 00 r1 = r7
> +         5:       bf 62 00 00 00 00 00 00 r2 = r6
> +         6:       85 10 00 00 02 00 00 00 call 2
> +         7:       0f 80 00 00 00 00 00 00 r0 += r8
> +         8:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> +        10:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
> +        11:       0f 10 00 00 00 00 00 00 r0 += r1
> +        12:       95 00 00 00 00 00 00 00 exit
> +
> +  Disassembly of section sec1:
> +
> +  0000000000000000 <gfunc>:
> +         0:       bf 20 00 00 00 00 00 00 r0 = r2
> +         1:       2f 10 00 00 00 00 00 00 r0 *= r1
> +         2:       95 00 00 00 00 00 00 00 exit
> +
> +  0000000000000018 <lfunc>:
> +         3:       bf 20 00 00 00 00 00 00 r0 = r2
> +         4:       0f 10 00 00 00 00 00 00 r0 += r1
> +         5:       95 00 00 00 00 00 00 00 exit
> +
> +Three relocations are generated with ``llvm-readelf -r test.o``::
> +
> +  Relocation section '.rel.text' at offset 0x188 contains 3 entries:
> +      Offset             Info             Type               Symbol's Value  Symbol's Name
> +  0000000000000010  000000040000000a R_BPF_64_32            0000000000000000 gfunc
> +  0000000000000030  000000020000000a R_BPF_64_32            0000000000000000 sec1
> +  0000000000000040  0000000600000001 R_BPF_64_64            0000000000000000 global
> +
> +The first relocation corresponds to ``gfunc(a, b)`` where ``gfunc`` has a value of 0,
> +so the ``call`` instruction offset is ``(0 + 0)/8 - 1 = -1``.
> +The second relocation corresponds to ``lfunc(a, b)`` where ``lfunc`` has a section
> +offset ``0x18``, so the ``call`` instruction offset is ``(0 + 0x18)/8 - 1 = 2``.
> +
> +The following is an example to show how R_BPF_64_ABS64 could be generated::
> +
> +  int global() { return 0; }
> +  struct t { void *g; } gbl = { global };
> +
> +Compiled with ``clang -target bpf -O2 -g -c test.c``, we will see a
> +relocation below in ``.data`` section with command
> +``llvm-readelf -r test.o``::
> +
> +  Relocation section '.rel.data' at offset 0x458 contains 1 entries:
> +      Offset             Info             Type               Symbol's Value  Symbol's Name
> +  0000000000000000  0000000700000002 R_BPF_64_ABS64         0000000000000000 global
> +
> +The relocation says the first 8-byte of ``.data`` section should be
> +filled with address of ``global`` variable.
> +
> +With ``llvm-readelf`` output, we can see that dwarf sections have a bunch of
> +``R_BPF_64_ABS32`` and ``R_BPF_64_ABS64`` relocations::
> +
> +  Relocation section '.rel.debug_info' at offset 0x468 contains 13 entries:
> +      Offset             Info             Type               Symbol's Value  Symbol's Name
> +  0000000000000006  0000000300000003 R_BPF_64_ABS32         0000000000000000 .debug_abbrev
> +  000000000000000c  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
> +  0000000000000012  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
> +  0000000000000016  0000000600000003 R_BPF_64_ABS32         0000000000000000 .debug_line
> +  000000000000001a  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
> +  000000000000001e  0000000200000002 R_BPF_64_ABS64         0000000000000000 .text
> +  000000000000002b  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
> +  0000000000000037  0000000800000002 R_BPF_64_ABS64         0000000000000000 gbl
> +  0000000000000040  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
> +  ......
> +
> +The .BTF/.BTF.ext sections has R_BPF_64_NODYLD32 relocations::
> +
> +  Relocation section '.rel.BTF' at offset 0x538 contains 1 entries:
> +      Offset             Info             Type               Symbol's Value  Symbol's Name
> +  0000000000000084  0000000800000004 R_BPF_64_NODYLD32      0000000000000000 gbl
> +
> +  Relocation section '.rel.BTF.ext' at offset 0x548 contains 2 entries:
> +      Offset             Info             Type               Symbol's Value  Symbol's Name
> +  000000000000002c  0000000200000004 R_BPF_64_NODYLD32      0000000000000000 .text
> +  0000000000000040  0000000200000004 R_BPF_64_NODYLD32      0000000000000000 .text
> --
> 2.30.2
>
