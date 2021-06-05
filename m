Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27C339CB1D
	for <lists+bpf@lfdr.de>; Sat,  5 Jun 2021 23:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFEVF4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Jun 2021 17:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEVF4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Jun 2021 17:05:56 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3548AC061766
        for <bpf@vger.kernel.org>; Sat,  5 Jun 2021 14:04:08 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g38so18926837ybi.12
        for <bpf@vger.kernel.org>; Sat, 05 Jun 2021 14:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RaJa+u/roqtfMP3WK1Fxgxq0e90jcjT54tSueChe+hQ=;
        b=PJb2xWsh2pNsZ2eX6a9wHXk4P8Dlsv/jwWR/PiCi8QYQ+88YzikDRL6d5vVI9akEV8
         9snW82wYIMzrQBV/PHHXRCHB0NUokKOoJxKzTX4YMFqSV1yV8KQ3qQkxOSvn3xDP7gxD
         YduJMhd0x5IJ1+Eq6qbaAsVGqS/anLQBP6XhDAH3X6gYiqImlE96D1dEVwUrM5vPRj9y
         6y8ZnHPC5Cjw9XFuAUg+mtgFfiwswg+K7R1ANL5+2amQUeLfffmZGSQpdbGgxFM1lCAr
         OgLZQX6ioCPAYJk/JYlVETYpbZX1aJAvIRu90XOoWeFzG9Gwn3p8IOjAgnafSKhWHYrO
         qdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaJa+u/roqtfMP3WK1Fxgxq0e90jcjT54tSueChe+hQ=;
        b=UuK6+iuf56uNJ6prhu/K5Otn+ldawnIckJ3ObgfHtmNBDtitPROro3/6xOVSQJmyTD
         NHDUCzGaY3MbKzWrXoM74St0q+7P5kPwKtguxg1DaNvqUq5DEPb6OjB+jdWkfhJag/B5
         VZFUm4uOumuMhB9DeWfipEPvGV2isJDH5O9CYhFarNNVq7itjexYPopNHXKkgAdNeu4B
         VsGLi7DL+WvoFYamlPLTWxUGhUjIk26Xd62loFaMyg0R/iFJg4X2/7Pyvue0NRNrU6+C
         wL8Gf+A18YQ6LDcj0LA/GHvmYWLegxThjvsOSZD/h9sfn3lzv0bXQvWdg1M7wu2cLlNW
         wXTQ==
X-Gm-Message-State: AOAM531l461sMWOQIw8UcvZ4m/Iqa0kWmH6lKtcC0m7q9g9LUtYY3MbO
        +GSgy5CujOt6JyBCu1xsJDtgbrY8Ngd10SqAzdKhgg==
X-Google-Smtp-Source: ABdhPJwLYub34ZkndsEuzIbvO5GHUz7pcfJ4f6w61TpO326GxLgoWoCn9HU95cNa+Ic660EQFWDkFVD4STGNe2mcNck=
X-Received: by 2002:a25:11c5:: with SMTP id 188mr13850442ybr.322.1622927045766;
 Sat, 05 Jun 2021 14:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210525033314.3008878-1-yhs@fb.com> <20210525182948.4wk3kd7vrvgdr2lu@google.com>
 <dd95b896-3b37-a398-68cd-549fb249f2e0@fb.com>
In-Reply-To: <dd95b896-3b37-a398-68cd-549fb249f2e0@fb.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Sat, 5 Jun 2021 14:03:54 -0700
Message-ID: <CAFP8O3JM3SrKXYA2SF-zRJZCiipHdcyF1usPOykm6Yqb6xs6dQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: add llvm_reloc.rst to explain llvm
 bpf relocations
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 25, 2021 at 11:52 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 5/25/21 11:29 AM, Fangrui Song wrote:
> > I have a review queue with a huge pile of LLVM patches and have only
> > skimmed through this.
> >
> > First, if the size benefit of REL over RELA isn't deem that necessary,
> > I will highly recommend RELA for simplicity and robustness.
> > REL is error-prone.
>
> The worry is backward compatibility. Because of BPF ELF format
> is so intervened with bpf eco system (loading, bpf map, etc.),
> a lot of tools in the wild already implemented to parse REL...
> It will be difficult to change...

It seems that the design did not get enough initial scrutiny...
(On https://reviews.llvm.org/D101336 , a reviewer who has apparently
never contributed to lld/ELF clicked LGTM without actual reviewing the
patch and that was why I have to click "Request Changes").

I worry that keeping the current state as-is can cause much
maintenance burden in the LLVM MC layer, linker, and other binary
utilities.
Some things can be improved without breaking backward compatibility.

> >
> > On 2021-05-24, Yonghong Song wrote:
> >> LLVM upstream commit
> >> https://reviews.llvm.org/D102712
> >> made some changes to bpf relocations to make them
> >> llvm linker lld friendly. The scope of
> >> existing relocations R_BPF_64_{64,32} is narrowed
> >> and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
> >> are introduced.
> >>
> >> Let us add some documentation about llvm bpf
> >> relocations so people can understand how to resolve
> >> them properly in their respective tools.
> >>
> >> Cc: John Fastabend <john.fastabend@gmail.com>
> >> Cc: Lorenz Bauer <lmb@cloudflare.com>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >> Documentation/bpf/index.rst            |   1 +
> >> Documentation/bpf/llvm_reloc.rst       | 240 +++++++++++++++++++++++++
> >> tools/testing/selftests/bpf/README.rst |  19 ++
> >> 3 files changed, 260 insertions(+)
> >> create mode 100644 Documentation/bpf/llvm_reloc.rst
> >>
> >> Changelogs:
> >>  v1 -> v2:
> >>    - add an example to illustrate how relocations related to base
> >>      section and symbol table and what is "Implicit Addend"
> >>    - clarify why we use 32bit read/write for R_BPF_64_64 (ld_imm64)
> >>      relocations.
> >>
> >> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> >> index a702f67dd45f..93e8cf12a6d4 100644
> >> --- a/Documentation/bpf/index.rst
> >> +++ b/Documentation/bpf/index.rst
> >> @@ -84,6 +84,7 @@ Other
> >>    :maxdepth: 1
> >>
> >>    ringbuf
> >> +   llvm_reloc
> >>
> >> .. Links:
> >> .. _networking-filter: ../networking/filter.rst
> >> diff --git a/Documentation/bpf/llvm_reloc.rst
> >> b/Documentation/bpf/llvm_reloc.rst
> >> new file mode 100644
> >> index 000000000000..5ade0244958f
> >> --- /dev/null
> >> +++ b/Documentation/bpf/llvm_reloc.rst
> >> @@ -0,0 +1,240 @@
> >> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >> +
> >> +====================
> >> +BPF LLVM Relocations
> >> +====================
> >> +
> >> +This document describes LLVM BPF backend relocation types.
> >> +
> >> +Relocation Record
> >> +=================
> >> +
> >> +LLVM BPF backend records each relocation with the following 16-byte
> >> +ELF structure::
> >> +
> >> +  typedef struct
> >> +  {
> >> +    Elf64_Addr    r_offset;  // Offset from the beginning of section.
> >> +    Elf64_Xword   r_info;    // Relocation type and symbol index.
> >> +  } Elf64_Rel;
> >> +
> >> +For example, for the following code::
> >> +
> >> +  int g1 __attribute__((section("sec")));
> >> +  int g2 __attribute__((section("sec")));
> >> +  static volatile int l1 __attribute__((section("sec")));
> >> +  static volatile int l2 __attribute__((section("sec")));
> >> +  int test() {
> >> +    return g1 + g2 + l1 + l2;
> >> +  }
> >> +
> >> +Compiled with ``clang -target bpf -O2 -c test.c``, the following is
> >> +the code with ``llvm-objdump -dr test.o``::
> >> +
> >> +       0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =
> >> 0 ll
> >> +                0000000000000000:  R_BPF_64_64  g1
> >> +       2:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
> >> +       3:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 =
> >> 0 ll
> >> +                0000000000000018:  R_BPF_64_64  g2
> >> +       5:       61 20 00 00 00 00 00 00 r0 = *(u32 *)(r2 + 0)
> >> +       6:       0f 10 00 00 00 00 00 00 r0 += r1
> >> +       7:       18 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00 r1 =
> >> 8 ll
> >> +                0000000000000038:  R_BPF_64_64  sec
> >> +       9:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
> >> +      10:       0f 10 00 00 00 00 00 00 r0 += r1
> >> +      11:       18 01 00 00 0c 00 00 00 00 00 00 00 00 00 00 00 r1 =
> >> 12 ll
> >> +                0000000000000058:  R_BPF_64_64  sec
> >> +      13:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
> >> +      14:       0f 10 00 00 00 00 00 00 r0 += r1
> >> +      15:       95 00 00 00 00 00 00 00 exit
> >> +
> >> +There are four relations in the above for four ``LD_imm64``
> >> instructions.
> >> +The following ``llvm-readelf -r test.o`` shows the binary values of
> >> the four
> >> +relocations::
> >> +
> >> +  Relocation section '.rel.text' at offset 0x190 contains 4 entries:
> >> +      Offset             Info             Type               Symbol's
> >> Value  Symbol's Name
> >> +  0000000000000000  0000000600000001 R_BPF_64_64
> >> 0000000000000000 g1
> >> +  0000000000000018  0000000700000001 R_BPF_64_64
> >> 0000000000000004 g2
> >> +  0000000000000038  0000000400000001 R_BPF_64_64
> >> 0000000000000000 sec
> >> +  0000000000000058  0000000400000001 R_BPF_64_64
> >> 0000000000000000 sec
> >> +
> >> +Each relocation is represented by ``Offset`` (8 bytes) and ``Info``
> >> (8 bytes).
> >> +For example, the first relocation corresponds to the first instruction
> >> +(Offset 0x0) and the corresponding ``Info`` indicates the relocation
> >> type
> >> +of ``R_BPF_64_64`` (type 1) and the entry in the symbol table (entry 6).
> >> +The following is the symbol table with ``llvm-readelf -s test.o``::
> >> +
> >> +  Symbol table '.symtab' contains 8 entries:
> >> +     Num:    Value          Size Type    Bind   Vis       Ndx Name
> >> +       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND
> >> +       1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS test.c
> >> +       2: 0000000000000008     4 OBJECT  LOCAL  DEFAULT     4 l1
> >> +       3: 000000000000000c     4 OBJECT  LOCAL  DEFAULT     4 l2
> >> +       4: 0000000000000000     0 SECTION LOCAL  DEFAULT     4 sec
> >> +       5: 0000000000000000   128 FUNC    GLOBAL DEFAULT     2 test
> >> +       6: 0000000000000000     4 OBJECT  GLOBAL DEFAULT     4 g1
> >> +       7: 0000000000000004     4 OBJECT  GLOBAL DEFAULT     4 g2
> >> +
> >> +The 6th entry is global variable ``g1`` with value 0.
> >> +
> >> +Similarly, the second relocation is at ``.text`` offset ``0x18``,
> >> instruction 3,
> >> +for global variable ``g2`` which has a symbol value 4, the offset
> >> +from the start of ``.data`` section.
> >> +
> >> +The third and fourth relocations refers to static variables ``l1``
> >> +and ``l2``. From ``.rel.text`` section above, it is not clear
> >> +which symbols they really refers to as they both refers to
> >> +symbol table entry 4, symbol ``sec``, which has ``SECTION`` type
> >
> > STT_SECTION. `SECTION` is just an abbreviated form used by some binary
> > tools.
>
> This is just to match llvm-readelf output. I can add a reference
> to STT_SECTION for the right macro name.
>
> >
> >> +and represents a section. So for static variable or function,
> >> +the section offset is written to the original insn
> >> +buffer, which is called ``IA`` (implicit addend). Looking at
> >> +above insn ``7`` and ``11``, they have section offset ``8`` and ``12``.
> >> +From symbol table, we can find that they correspond to entries ``2``
> >> +and ``3`` for ``l1`` and ``l2``.
> >
> > The other REL based psABIs all use `A` for addend.
>
> I can use `A` as well. The reason I am using `IA` since it is not
> shown in the relocation record and lld used API 'getImplicitAddend()`
> get this value. But I can certainly use `A`.

An ABI document should stick with standard terms.
The variable names used in an implementation are just informative
(plus I don't see any `IA` in lld's source code).

> >
> >> +In general, the ``IA`` is 0 for global variables and functions,
> >> +and is the section offset or some computation result based on
> >> +section offset for static variables/functions. The non-section-offset
> >> +case refers to function calls. See below for more details.
> >> +
> >> +Different Relocation Types
> >> +==========================
> >> +
> >> +Six relocation types are supported. The following is an overview and
> >> +``S`` represents the value of the symbol in the symbol table::
> >> +
> >> +  Enum  ELF Reloc Type     Description      BitSize  Offset
> >> Calculation
> >> +  0     R_BPF_NONE         None
> >> +  1     R_BPF_64_64        ld_imm64 insn    32       r_offset + 4  S
> >> + IA
> >> +  2     R_BPF_64_ABS64     normal data      64       r_offset      S
> >> + IA
> >> +  3     R_BPF_64_ABS32     normal data      32       r_offset      S
> >> + IA
> >> +  4     R_BPF_64_NODYLD32  .BTF[.ext] data  32       r_offset      S
> >> + IA
> >> +  10    R_BPF_64_32        call insn        32       r_offset + 4  (S
> >> + IA) / 8 - 1
> >
> > Shifting the offset by 4 looks weird. R_386_32 applies at r_offset.
> > The call instruction  R_BPF_64_32 is strange. Such special calculation
> > should not be named R_BPF_64_32.
>
> Again, we have a backward compatibility issue here. I would like to
> provide an alias for it in llvm relocation header file, but I don't
> know how to do it.

It is very confusing that R_BPF_64_64 has a 32-bit value.
Since its computation is the same as R_BPF_64_ABS32, can R_BPF_64_64
be deprecated in favor of R_BPF_64_ABS32?

There is nothing preventing a relocation type from being used as data
in some cases while code in other cases.
R_BPF_64_64 can be renamed to indicate that it is deprecated.
R_BPF_64_32 can be confused with R_BPF_64_ABS32. You may rename
R_BPF_64_32 to say, R_BPF_64_CALL32.

For compatibility, only the values matter, not the names.
E.g. on x86, some unused GNU_PROPERTY values were renamed to
GNU_PROPERTY_X86_COMPAT_ISA_1_USED ("COMPAT" for compatibility) while
their values were kept.
Two aarch64 relocation types have been renamed.

> >
> >> +For example, ``R_BPF_64_64`` relocation type is used for ``ld_imm64``
> >> instruction.
> >> +The actual to-be-relocated data (0 or section offset)
> >> +is stored at ``r_offset + 4`` and the read/write
> >> +data bitsize is 32 (4 bytes). The relocation can be resolved with
> >> +the symbol value plus implicit addend. Note that the ``BitSize`` is
> >> 32 which
> >> +means the section offset must be less than or equal to ``UINT32_MAX``
> >> and this
> >> +is enforced by LLVM BPF backend.
> >> +
> >> +In another case, ``R_BPF_64_ABS64`` relocation type is used for
> >> normal 64-bit data.
> >> +The actual to-be-relocated data is stored at ``r_offset`` and the
> >> read/write data
> >> +bitsize is 64 (8 bytes). The relocation can be resolved with
> >> +the symbol value plus implicit addend.
> >> +
> >> +Both ``R_BPF_64_ABS32`` and ``R_BPF_64_NODYLD32`` types are for
> >> 32-bit data.
> >> +But ``R_BPF_64_NODYLD32`` specifically refers to relocations in
> >> ``.BTF`` and
> >> +``.BTF.ext`` sections. For cases like bcc where llvm
> >> ``ExecutionEngine RuntimeDyld``
> >> +is involved, ``R_BPF_64_NODYLD32`` types of relocations should not be
> >> resolved
> >> +to actual function/variable address. Otherwise, ``.BTF`` and
> >> ``.BTF.ext``
> >> +become unusable by bcc and kernel.
> >
> > Why cannot R_BPF_64_ABS32 cover the use cases of R_BPF_64_NODYLD32?
> > I haven't seen any relocation type which hard coding knowledge on data
> > sections.
>
> This is due to how .BTF relocation is done. Relocation is against
> loadable symbols but it does not want dynamic linker to resolve them.
> Instead it wants libbpf and kernel to resolve them in a different
> way.

How is R_BPF_64_NODYLD32 different?
I don't see it is different on https://reviews.llvm.org/D101336 .
I cannot find R_BPF_64_NODYLD32 in the kernel code as well.

There may be a misconception that different sections need different
relocation types,
even if the semantics are the same. Such understanding is incorrect.

> >
> >> +Type ``R_BPF_64_32`` is used for call instruction. The call target
> >> section
> >> +offset is stored at ``r_offset + 4`` (32bit) and calculated as
> >> +``(S + IA) / 8 - 1``.
> >
> > In other ABIs, names like 32/ABS32/ABS64 refer to absolute relocation types
> > without such complex operation.
>
> Again, this is a historical artifact to handle call instruction. I am
> aware that this might be different from other architectures. But we have
> to keep backward compatibility...
>
> >
> >> +Examples
> >> +========
> >> +
> >> +Types ``R_BPF_64_64`` and ``R_BPF_64_32`` are used to resolve
> >> ``ld_imm64``
> >> +and ``call`` instructions. For example::
> >> +
> >> +  __attribute__((noinline)) __attribute__((section("sec1")))
> >> +  int gfunc(int a, int b) {
> >> +    return a * b;
> >> +  }
> >> +  static __attribute__((noinline)) __attribute__((section("sec1")))
> >> +  int lfunc(int a, int b) {
> >> +    return a + b;
> >> +  }
> >> +  int global __attribute__((section("sec2")));
> >> +  int test(int a, int b) {
> >> +    return gfunc(a, b) +  lfunc(a, b) + global;
> >> +  }
> >> +
> [...]
