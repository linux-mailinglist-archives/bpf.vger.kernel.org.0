Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B90539EE6B
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 07:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhFHFxZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 01:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhFHFxZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 01:53:25 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0288CC061574
        for <bpf@vger.kernel.org>; Mon,  7 Jun 2021 22:51:33 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id g38so28461271ybi.12
        for <bpf@vger.kernel.org>; Mon, 07 Jun 2021 22:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cEiANPDECM8pAz3H1MOgwALDTz6IvbrC6CM3p4nGz9o=;
        b=tWowXqYeAcSKVK0jACiwyvnQIF0YgjnJG7Fky1Xk68lGZgEe9k8Dsf1HJiBBL+zUv6
         Fgx7xf23yT6Kphuc8/hmGqx86ooQTPDovqk/mmyjTFvsctC6Jmy3dhuLXD71J2cpDrdP
         anSen4VhOMhAn4N7KIHxO17YsZkkHTW5D8F7YBfrrlcSlS4qeT1jDlNVUeHj6IiYlyZF
         TCyMw1vP+1sGUf0l3zzCNiXUrtBPQP+XBOnVZUw3VCxbWligUorUQfg0d87B6/ggrw0y
         2tVYpX7wren79UN5N+RizsvJU2BAVJxPFDVqQviMWoNEWARvSp98jYWaC6uHsrTsB3l4
         dGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cEiANPDECM8pAz3H1MOgwALDTz6IvbrC6CM3p4nGz9o=;
        b=nRJ0JXlxUSg8kr1R0bavRvXXF9mnHqT6MHW0+9hL+taP+omR5Z/YoS3DNKLTE21wla
         LBcJFErep0XsbYY7FUz83UhyVaiVbMMyOgXoxs3hRZQw94zjVggvY+a4wfG7antMYTQp
         BX0cenzLOER/9wkjdHfc5e96R2/nZeGsiYPxD40FJoEwPBpkjL6jCY9Pl2NP1QCBI9et
         aFzUUOFEg3JBshYMrbzfFjPxI+RhGMfS8+pRjTV2+UECZqANeWMXUK81HuBMdFy6b2Dz
         Zw0MxVWKIevNzyhEF60vYWyJZpVGXCNPrPgk0oeKp+9ac6QTxhCAvref/MidM7w27Vum
         LErA==
X-Gm-Message-State: AOAM532l2UydajyYu8cNLCm6w76yZTus6hxX0QfeUSnfHes4ewNGqBoH
        5dS9aFy7FTi5VyWrXzOq12dE3CfM6Lso9Um4csErhw==
X-Google-Smtp-Source: ABdhPJyzWA1fWgWLakndhqmFmHTo9N+E6z1NmT83WWOXKdzJLb1asZa4spShgABDSEviMA0HZF6L6wxfT3H2Xw/sB8I=
X-Received: by 2002:a25:e741:: with SMTP id e62mr30270780ybh.484.1623131491770;
 Mon, 07 Jun 2021 22:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210525033314.3008878-1-yhs@fb.com> <20210525182948.4wk3kd7vrvgdr2lu@google.com>
 <dd95b896-3b37-a398-68cd-549fb249f2e0@fb.com> <CAFP8O3JM3SrKXYA2SF-zRJZCiipHdcyF1usPOykm6Yqb6xs6dQ@mail.gmail.com>
 <4410f328-58ae-24e4-5e63-cfde6e891bf4@fb.com> <CAFP8O3J4_aaT+POmB6H6mihuP1-VQ4ww1nVrHxEvd70S5ODEUw@mail.gmail.com>
 <8abe01cb-da8f-514c-6b52-b92686a16662@fb.com>
In-Reply-To: <8abe01cb-da8f-514c-6b52-b92686a16662@fb.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 7 Jun 2021 22:51:20 -0700
Message-ID: <CAFP8O3JeGtDMATPsnjhRO3Ru+Lap2uJSG_jYzWcK4AWeBtXquw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: add llvm_reloc.rst to explain llvm
 bpf relocations
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 7, 2021 at 9:32 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 6/7/21 3:08 PM, F=C4=81ng-ru=C3=AC S=C3=B2ng wrote:
> > On Mon, Jun 7, 2021 at 2:06 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 6/5/21 2:03 PM, F=C4=81ng-ru=C3=AC S=C3=B2ng wrote:
> >>> On Tue, May 25, 2021 at 11:52 AM Yonghong Song <yhs@fb.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 5/25/21 11:29 AM, Fangrui Song wrote:
> >>>>> I have a review queue with a huge pile of LLVM patches and have onl=
y
> >>>>> skimmed through this.
> >>>>>
> >>>>> First, if the size benefit of REL over RELA isn't deem that necessa=
ry,
> >>>>> I will highly recommend RELA for simplicity and robustness.
> >>>>> REL is error-prone.
> >>>>
> >>>> The worry is backward compatibility. Because of BPF ELF format
> >>>> is so intervened with bpf eco system (loading, bpf map, etc.),
> >>>> a lot of tools in the wild already implemented to parse REL...
> >>>> It will be difficult to change...
> >>>
> >>> It seems that the design did not get enough initial scrutiny...
> >>> (On https://reviews.llvm.org/D101336   , a reviewer who has apparentl=
y
> >>> never contributed to lld/ELF clicked LGTM without actual reviewing th=
e
> >>> patch and that was why I have to click "Request Changes").
> >>>
> >>> I worry that keeping the current state as-is can cause much
> >>> maintenance burden in the LLVM MC layer, linker, and other binary
> >>> utilities.
> >>> Some things can be improved without breaking backward compatibility.
> >>>
> >>>>>
> >>>>> On 2021-05-24, Yonghong Song wrote:
> >>>>>> LLVM upstream commit
> >>>>>> https://reviews.llvm.org/D102712
> >>>>>> made some changes to bpf relocations to make them
> >>>>>> llvm linker lld friendly. The scope of
> >>>>>> existing relocations R_BPF_64_{64,32} is narrowed
> >>>>>> and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
> >>>>>> are introduced.
> >>>>>>
> >>>>>> Let us add some documentation about llvm bpf
> >>>>>> relocations so people can understand how to resolve
> >>>>>> them properly in their respective tools.
> >>>>>>
> >>>>>> Cc: John Fastabend <john.fastabend@gmail.com>
> >>>>>> Cc: Lorenz Bauer <lmb@cloudflare.com>
> >>>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
> >>>>>> ---
> >>>>>> Documentation/bpf/index.rst            |   1 +
> >>>>>> Documentation/bpf/llvm_reloc.rst       | 240 +++++++++++++++++++++=
++++
> >>>>>> tools/testing/selftests/bpf/README.rst |  19 ++
> >>>>>> 3 files changed, 260 insertions(+)
> >>>>>> create mode 100644 Documentation/bpf/llvm_reloc.rst
> >>>>>>
> >>>>>> Changelogs:
> >>>>>>    v1 -> v2:
> >>>>>>      - add an example to illustrate how relocations related to bas=
e
> >>>>>>        section and symbol table and what is "Implicit Addend"
> >>>>>>      - clarify why we use 32bit read/write for R_BPF_64_64 (ld_imm=
64)
> >>>>>>        relocations.
> >>>>>>
> >>>>>> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index=
.rst
> >>>>>> index a702f67dd45f..93e8cf12a6d4 100644
> >>>>>> --- a/Documentation/bpf/index.rst
> >>>>>> +++ b/Documentation/bpf/index.rst
> >>>>>> @@ -84,6 +84,7 @@ Other
> >>>>>>      :maxdepth: 1
> >>>>>>
> >>>>>>      ringbuf
> >>>>>> +   llvm_reloc
> >>>>>>
> >>>>>> .. Links:
> >>>>>> .. _networking-filter: ../networking/filter.rst
> >>>>>> diff --git a/Documentation/bpf/llvm_reloc.rst
> >>>>>> b/Documentation/bpf/llvm_reloc.rst
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..5ade0244958f
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/bpf/llvm_reloc.rst
> >>>>>> @@ -0,0 +1,240 @@
> >>>>>> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >>>>>> +
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> +BPF LLVM Relocations
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +This document describes LLVM BPF backend relocation types.
> >>>>>> +
> >>>>>> +Relocation Record
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +LLVM BPF backend records each relocation with the following 16-by=
te
> >>>>>> +ELF structure::
> >>>>>> +
> >>>>>> +  typedef struct
> >>>>>> +  {
> >>>>>> +    Elf64_Addr    r_offset;  // Offset from the beginning of sect=
ion.
> >>>>>> +    Elf64_Xword   r_info;    // Relocation type and symbol index.
> >>>>>> +  } Elf64_Rel;
> >>>>>> +
> >>>>>> +For example, for the following code::
> >>>>>> +
> >>>>>> +  int g1 __attribute__((section("sec")));
> >>>>>> +  int g2 __attribute__((section("sec")));
> >>>>>> +  static volatile int l1 __attribute__((section("sec")));
> >>>>>> +  static volatile int l2 __attribute__((section("sec")));
> >>>>>> +  int test() {
> >>>>>> +    return g1 + g2 + l1 + l2;
> >>>>>> +  }
> >>>>>> +
> >>>>>> +Compiled with ``clang -target bpf -O2 -c test.c``, the following =
is
> >>>>>> +the code with ``llvm-objdump -dr test.o``::
> >>>>>> +
> >>>>>> +       0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r=
1 =3D
> >>>>>> 0 ll
> >>>>>> +                0000000000000000:  R_BPF_64_64  g1
> >>>>>> +       2:       61 11 00 00 00 00 00 00 r1 =3D *(u32 *)(r1 + 0)
> >>>>>> +       3:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r=
2 =3D
> >>>>>> 0 ll
> >>>>>> +                0000000000000018:  R_BPF_64_64  g2
> >>>>>> +       5:       61 20 00 00 00 00 00 00 r0 =3D *(u32 *)(r2 + 0)
> >>>>>> +       6:       0f 10 00 00 00 00 00 00 r0 +=3D r1
> >>>>>> +       7:       18 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00 r=
1 =3D
> >>>>>> 8 ll
> >>>>>> +                0000000000000038:  R_BPF_64_64  sec
> >>>>>> +       9:       61 11 00 00 00 00 00 00 r1 =3D *(u32 *)(r1 + 0)
> >>>>>> +      10:       0f 10 00 00 00 00 00 00 r0 +=3D r1
> >>>>>> +      11:       18 01 00 00 0c 00 00 00 00 00 00 00 00 00 00 00 r=
1 =3D
> >>>>>> 12 ll
> >>>>>> +                0000000000000058:  R_BPF_64_64  sec
> >>>>>> +      13:       61 11 00 00 00 00 00 00 r1 =3D *(u32 *)(r1 + 0)
> >>>>>> +      14:       0f 10 00 00 00 00 00 00 r0 +=3D r1
> >>>>>> +      15:       95 00 00 00 00 00 00 00 exit
> >>>>>> +
> >>>>>> +There are four relations in the above for four ``LD_imm64``
> >>>>>> instructions.
> >>>>>> +The following ``llvm-readelf -r test.o`` shows the binary values =
of
> >>>>>> the four
> >>>>>> +relocations::
> >>>>>> +
> >>>>>> +  Relocation section '.rel.text' at offset 0x190 contains 4 entri=
es:
> >>>>>> +      Offset             Info             Type               Symb=
ol's
> >>>>>> Value  Symbol's Name
> >>>>>> +  0000000000000000  0000000600000001 R_BPF_64_64
> >>>>>> 0000000000000000 g1
> >>>>>> +  0000000000000018  0000000700000001 R_BPF_64_64
> >>>>>> 0000000000000004 g2
> >>>>>> +  0000000000000038  0000000400000001 R_BPF_64_64
> >>>>>> 0000000000000000 sec
> >>>>>> +  0000000000000058  0000000400000001 R_BPF_64_64
> >>>>>> 0000000000000000 sec
> >>>>>> +
> >>>>>> +Each relocation is represented by ``Offset`` (8 bytes) and ``Info=
``
> >>>>>> (8 bytes).
> >>>>>> +For example, the first relocation corresponds to the first instru=
ction
> >>>>>> +(Offset 0x0) and the corresponding ``Info`` indicates the relocat=
ion
> >>>>>> type
> >>>>>> +of ``R_BPF_64_64`` (type 1) and the entry in the symbol table (en=
try 6).
> >>>>>> +The following is the symbol table with ``llvm-readelf -s test.o``=
::
> >>>>>> +
> >>>>>> +  Symbol table '.symtab' contains 8 entries:
> >>>>>> +     Num:    Value          Size Type    Bind   Vis       Ndx Nam=
e
> >>>>>> +       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND
> >>>>>> +       1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS tes=
t.c
> >>>>>> +       2: 0000000000000008     4 OBJECT  LOCAL  DEFAULT     4 l1
> >>>>>> +       3: 000000000000000c     4 OBJECT  LOCAL  DEFAULT     4 l2
> >>>>>> +       4: 0000000000000000     0 SECTION LOCAL  DEFAULT     4 sec
> >>>>>> +       5: 0000000000000000   128 FUNC    GLOBAL DEFAULT     2 tes=
t
> >>>>>> +       6: 0000000000000000     4 OBJECT  GLOBAL DEFAULT     4 g1
> >>>>>> +       7: 0000000000000004     4 OBJECT  GLOBAL DEFAULT     4 g2
> >>>>>> +
> >>>>>> +The 6th entry is global variable ``g1`` with value 0.
> >>>>>> +
> >>>>>> +Similarly, the second relocation is at ``.text`` offset ``0x18``,
> >>>>>> instruction 3,
> >>>>>> +for global variable ``g2`` which has a symbol value 4, the offset
> >>>>>> +from the start of ``.data`` section.
> >>>>>> +
> >>>>>> +The third and fourth relocations refers to static variables ``l1`=
`
> >>>>>> +and ``l2``. From ``.rel.text`` section above, it is not clear
> >>>>>> +which symbols they really refers to as they both refers to
> >>>>>> +symbol table entry 4, symbol ``sec``, which has ``SECTION`` type
> >>>>>
> >>>>> STT_SECTION. `SECTION` is just an abbreviated form used by some bin=
ary
> >>>>> tools.
> >>>>
> >>>> This is just to match llvm-readelf output. I can add a reference
> >>>> to STT_SECTION for the right macro name.
> >>>>
> >>>>>
> >>>>>> +and represents a section. So for static variable or function,
> >>>>>> +the section offset is written to the original insn
> >>>>>> +buffer, which is called ``IA`` (implicit addend). Looking at
> >>>>>> +above insn ``7`` and ``11``, they have section offset ``8`` and `=
`12``.
> >>>>>> +From symbol table, we can find that they correspond to entries ``=
2``
> >>>>>> +and ``3`` for ``l1`` and ``l2``.
> >>>>>
> >>>>> The other REL based psABIs all use `A` for addend.
> >>>>
> >>>> I can use `A` as well. The reason I am using `IA` since it is not
> >>>> shown in the relocation record and lld used API 'getImplicitAddend()=
`
> >>>> get this value. But I can certainly use `A`.
> >>>
> >>> An ABI document should stick with standard terms.
> >>> The variable names used in an implementation are just informative
> >>> (plus I don't see any `IA` in lld's source code).
> >>>
> >>>>>
> >>>>>> +In general, the ``IA`` is 0 for global variables and functions,
> >>>>>> +and is the section offset or some computation result based on
> >>>>>> +section offset for static variables/functions. The non-section-of=
fset
> >>>>>> +case refers to function calls. See below for more details.
> >>>>>> +
> >>>>>> +Different Relocation Types
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +Six relocation types are supported. The following is an overview =
and
> >>>>>> +``S`` represents the value of the symbol in the symbol table::
> >>>>>> +
> >>>>>> +  Enum  ELF Reloc Type     Description      BitSize  Offset
> >>>>>> Calculation
> >>>>>> +  0     R_BPF_NONE         None
> >>>>>> +  1     R_BPF_64_64        ld_imm64 insn    32       r_offset + 4=
  S
> >>>>>> + IA
> >>>>>> +  2     R_BPF_64_ABS64     normal data      64       r_offset    =
  S
> >>>>>> + IA
> >>>>>> +  3     R_BPF_64_ABS32     normal data      32       r_offset    =
  S
> >>>>>> + IA
> >>>>>> +  4     R_BPF_64_NODYLD32  .BTF[.ext] data  32       r_offset    =
  S
> >>>>>> + IA
> >>>>>> +  10    R_BPF_64_32        call insn        32       r_offset + 4=
  (S
> >>>>>> + IA) / 8 - 1
> >>>>>
> >>>>> Shifting the offset by 4 looks weird. R_386_32 applies at r_offset.
> >>>>> The call instruction  R_BPF_64_32 is strange. Such special calculat=
ion
> >>>>> should not be named R_BPF_64_32.
> >>>>
> >>>> Again, we have a backward compatibility issue here. I would like to
> >>>> provide an alias for it in llvm relocation header file, but I don't
> >>>> know how to do it.
> >>>
> >>> It is very confusing that R_BPF_64_64 has a 32-bit value.
> >>
> >> If you like, we can make it as 64bit value.
> >> R_BPF_64_64 is for ld_imm64 insn which is a 16byte insn.
> >> The bytes 4-7 and 12-15 forms a 64bit value for the instruction.
> >> We can do
> >>        write32/read32 for bytes 4-7
> >>        write32/read32 for bytes 12-15
> >> for the relocation. Currently, we limit to bytes 4-7 since
> >> in BPF it is really unlikely we have section offset > 4G.
> >> But we could extend to full 64bit section offset.

I think I am fine with a relocation type applying to bytes 4-7,12-15
of some 16-byte entity.
It's just odd that R_BPF_64_64 exists (with completely different
semantics from R_X86_64_64/R_AARCH64_ABS64/etc)
while R_BPF_64_ABS64 also exists.

You can rename R_BPF_64_64 to something more meaningful, e.g. R_BPF_64_LDIM=
M64.
Then I am fine that such a relocation type applies inconsecutive bytes.

See below. Just change every occurrence of the old name in llvm-project.

> > Such semantics have precedents, e.g. R_AARCH64_ADD_ABS_LO12_NC.
> >
> > For BPF, the name can be ABS_LO32: absolute, the low 32-bit value,
> > with relocation overflow checking.
> > There will be an out-of-range relocation if the value is outside
> > [-2**31, 2**32).
> >
> > If the value is byte aligned, it will be more natural if you shift r_of=
fset
> > so that the linker just relocates some bytes starting at r_offset, inst=
ead of
> > r_offset+4 or r_offset+12.
> >
> > ABS_LO32_NC (no-checking) + ABS_HI32 (absolute, the high 32-bit value) =
can be
> > introduced in the fugure.
> >
> >>> Since its computation is the same as R_BPF_64_ABS32, can R_BPF_64_64
> >>> be deprecated in favor of R_BPF_64_ABS32?
> >>
> >> Its computation is the same but R_BPF_64_ABS32 starts from offset
> >> and R_BPF_64_64 starts from offset + 4.
> >>
> >> For R_BPF_64_64, the relocation offset is the *start* of the instructi=
on
> >> hence +4 is needed to actually read/write addend.
> >>
> >> To deprecate R_BPF_64_64 to be the same as R_BPF_64_ABS32, we will
> >> need to change relocation offset. This will break existing libbpf
> >> and cilium and likely many other tools, so I would prefer not
> >> to do this.
> >
> > You can add a new relocation type. Backward compatibility is good.
> > There can only be forward compatibility issues.
> >
> > I see some relocation types which are deemed fundamental on other archi=
tectures
> > are just being introduced. How could they work without these new reloca=
tion
> > types anyway?
> >
> >>>
> >>> There is nothing preventing a relocation type from being used as data
> >>> in some cases while code in other cases.
> >>> R_BPF_64_64 can be renamed to indicate that it is deprecated.
> >>> R_BPF_64_32 can be confused with R_BPF_64_ABS32. You may rename
> >>> R_BPF_64_32 to say, R_BPF_64_CALL32.
> >>>
> >>> For compatibility, only the values matter, not the names.
> >>> E.g. on x86, some unused GNU_PROPERTY values were renamed to
> >>> GNU_PROPERTY_X86_COMPAT_ISA_1_USED ("COMPAT" for compatibility) while
> >>> their values were kept.
> >>> Two aarch64 relocation types have been renamed.
> >>
> >> Renaming sounds a more attractive choice. But a lot of other tools
> >> have already used the name and it will be odd and not user friendly
> >> to display a different name from llvm.
> >>
> >> For example elfutils, we have
> >>     backends/bpf_symbol.c:    case R_BPF_64_64:
> >>     libelf/elf.h:#define R_BPF_64_64
> >>
> >> My /usr/include/elf.h (from glibc-headers-2.28-149.el8.x86_64) has:
> >>     /* BPF specific declarations.  */
> >>
> >>     #define R_BPF_NONE              0       /* No reloc */
> >>     #define R_BPF_64_64             1
> >>     #define R_BPF_64_32             10
> >>
> >> I agree the name is a little misleading, but renaming may cause
> >> some confusion in bpf ecosystem. So we prefer to stay as is, but
> >> with documentation to explain what each relocation intends to do.
> >
> > There are only 3 relocation types. R_BPF_NONE is good.
> > There is still time figuring out proper naming and fixing them today.
> > Otherwise I foresee that the naming problem will cause continuous confu=
sion to
> > other toolchain folks.
> >
> > Assuming R_BPF_64_ABS_LO32 convey the correct semantics, you can do
> >
> >      #define R_BPF_64_ABS_LO32       1
> >      #define R_BPF_64_64             1 /* deprecated alias */
> >
> > Similarly, for BPF_64_32:
> >
> >      #define R_BPF_64_CALL32         10
> >      #define R_BPF_64_32             10 /* deprecated alias */
>
> Do you mean in LLVM ELF relocations, we map both R_BPF_64_CALL32
> and R_BPF_64_32 to 10?

No. If renaming, in llvm-project, just replace every occurrence of
R_BPF_64_32 with the new name.
LLVM doesn't need to know there was an old macro named "R_BPF_64_32".
The output of llvm-readelf -r will change, but that should not matter
(users parsing the output should be aware it is unstable).

glibc elf.h can keep defining R_BPF_64_32, assuming some packages may
use the macro.

> --- a/llvm/include/llvm/BinaryFormat/ELFRelocs/BPF.def
> +++ b/llvm/include/llvm/BinaryFormat/ELFRelocs/BPF.def
> @@ -9,3 +9,4 @@ ELF_RELOC(R_BPF_64_ABS64,    2)
>   ELF_RELOC(R_BPF_64_ABS32,    3)
>   ELF_RELOC(R_BPF_64_NODYLD32, 4)
>   ELF_RELOC(R_BPF_64_32,      10)
> +ELF_RELOC(R_BPF_64_CALL32,  10)
>
> This actually won't work because now we have
> value 10 mapping to two names and some part of
> llvm won't happy.

[...]

> >
> >>>>>
> >>>>>> +For example, ``R_BPF_64_64`` relocation type is used for ``ld_imm=
64``
> >>>>>> instruction.
> >>>>>> +The actual to-be-relocated data (0 or section offset)
> >>>>>> +is stored at ``r_offset + 4`` and the read/write
> >>>>>> +data bitsize is 32 (4 bytes). The relocation can be resolved with
> >>>>>> +the symbol value plus implicit addend. Note that the ``BitSize`` =
is
> >>>>>> 32 which
> >>>>>> +means the section offset must be less than or equal to ``UINT32_M=
AX``
> >>>>>> and this
> >>>>>> +is enforced by LLVM BPF backend.
> >>>>>> +
> >>>>>> +In another case, ``R_BPF_64_ABS64`` relocation type is used for
> >>>>>> normal 64-bit data.
> >>>>>> +The actual to-be-relocated data is stored at ``r_offset`` and the
> >>>>>> read/write data
> >>>>>> +bitsize is 64 (8 bytes). The relocation can be resolved with
> >>>>>> +the symbol value plus implicit addend.
> >>>>>> +
> >>>>>> +Both ``R_BPF_64_ABS32`` and ``R_BPF_64_NODYLD32`` types are for
> >>>>>> 32-bit data.
> >>>>>> +But ``R_BPF_64_NODYLD32`` specifically refers to relocations in
> >>>>>> ``.BTF`` and
> >>>>>> +``.BTF.ext`` sections. For cases like bcc where llvm
> >>>>>> ``ExecutionEngine RuntimeDyld``
> >>>>>> +is involved, ``R_BPF_64_NODYLD32`` types of relocations should no=
t be
> >>>>>> resolved
> >>>>>> +to actual function/variable address. Otherwise, ``.BTF`` and
> >>>>>> ``.BTF.ext``
> >>>>>> +become unusable by bcc and kernel.
> >>>>>
> >>>>> Why cannot R_BPF_64_ABS32 cover the use cases of R_BPF_64_NODYLD32?
> >>>>> I haven't seen any relocation type which hard coding knowledge on d=
ata
> >>>>> sections.
> >>>>
> >>>> This is due to how .BTF relocation is done. Relocation is against
> >>>> loadable symbols but it does not want dynamic linker to resolve them=
.
> >>>> Instead it wants libbpf and kernel to resolve them in a different
> >>>> way.
> >>>
> >>> How is R_BPF_64_NODYLD32 different?
> >>> I don't see it is different on https://reviews.llvm.org/D101336   .
> >>> I cannot find R_BPF_64_NODYLD32 in the kernel code as well.
> >>
> >> As I mentioned in the above this is to deal with a case related to
> >> runtime dynamic linking relocation (DYLD), JIT style of compilation.
> >> kernel won't use this paradigm so you won't find it in the kenrel.
> >>
> >>>
> >>> There may be a misconception that different sections need different
> >>> relocation types,
> >>> even if the semantics are the same. Such understanding is incorrect.
> >>
> >> We know this and we don't have this perception such .BTF/.BTF.ext
> >> relocation types must be different due to it is a different relocation=
.
> >> It needs a different relocation because its relocation resolution
> >> is different from ABS32.
> >>
> >> I guess I didn't give enough details on why we need this new relocatio=
n
> >> kind and let me try again.
> >>
> >> First, the use case is for bcc/bpftrace style LLVM JIT (ExecutionEngin=
e)
> >> based compilation. The related bcc code is here:
> >>
> >> https://github.com/iovisor/bcc/blob/master/src/cc/bpf_module.cc#L453-L=
498
> >> Basically, we will invoke clang CompilerInvocation to generate IR and
> >> do a bpf target IR optimization and call
> >>      ExecutionEngine->finalizeObject()
> >> to generate code.
> >>
> >> In this particular setting, we set ExecutionEngine to process
> >> all sections (including dwarf and BTF sections). And among others,
> >> ExecutionEngine will try to *resolve* all relocations for dwarf and
> >> BTF sections.
> >>
> >> The core loop for relocation resolution,
> >>
> >> void RuntimeDyldImpl::resolveLocalRelocations() {
> >>     // Iterate over all outstanding relocations
> >>     for (auto it =3D Relocations.begin(), e =3D Relocations.end(); it =
!=3D e;
> >> ++it) {
> >>       // The Section here (Sections[i]) refers to the section in which=
 the
> >>       // symbol for the relocation is located.  The SectionID in the
> >> relocation
> >>       // entry provides the section to which the relocation will be ap=
plied.
> >>       unsigned Idx =3D it->first;
> >>       uint64_t Addr =3D getSectionLoadAddress(Idx);
> >>       LLVM_DEBUG(dbgs() << "Resolving relocations Section #" << Idx <<=
 "\t"
> >>                         << format("%p", (uintptr_t)Addr) << "\n");
> >>       resolveRelocationList(it->second, Addr);
> >>     }
> >>     Relocations.clear();
> >> }
> >>
> >> For example, for the following code,
> >> $ cat t.c
> >> int g;
> >> int test() { return g; }
> >> $ clang -target bpf -O2 -g -c t.c
> >> $ llvm-readelf -r t.o
> >> ...
> >>
> >> Relocation section '.rel.debug_info' at offset 0x3e0 contains 11
> >> entries:
> >>       Offset             Info             Type               Symbol's
> >> Value  Symbol's Name
> >> 0000000000000006  0000000300000003 R_BPF_64_ABS32
> >> 0000000000000000 .debug_abbrev
> >> 000000000000000c  0000000400000003 R_BPF_64_ABS32
> >> 0000000000000000 .debug_str
> >> 0000000000000012  0000000400000003 R_BPF_64_ABS32
> >> 0000000000000000 .debug_str
> >> 0000000000000016  0000000600000003 R_BPF_64_ABS32
> >> 0000000000000000 .debug_line
> >> 000000000000001a  0000000400000003 R_BPF_64_ABS32
> >> 0000000000000000 .debug_str
> >> 000000000000001e  0000000200000002 R_BPF_64_ABS64
> >> 0000000000000000 .text
> >> 000000000000002b  0000000400000003 R_BPF_64_ABS32
> >> 0000000000000000 .debug_str
> >> 0000000000000037  0000000800000002 R_BPF_64_ABS64         000000000000=
0000 g
> >> 0000000000000040  0000000400000003 R_BPF_64_ABS32
> >> 0000000000000000 .debug_str
> >> 0000000000000047  0000000200000002 R_BPF_64_ABS64
> >> 0000000000000000 .text
> >> 0000000000000055  0000000400000003 R_BPF_64_ABS32
> >> 0000000000000000 .debug_str
> >>
> >> Relocation section '.rel.BTF' at offset 0x490 contains 1 entries:
> >>       Offset             Info             Type               Symbol's
> >> Value  Symbol's Name
> >> 0000000000000060  0000000800000004 R_BPF_64_NODYLD32      000000000000=
0000 g
> >>
> >> Relocation section '.rel.BTF.ext' at offset 0x4a0 contains 3 entries:
> >>       Offset             Info             Type               Symbol's
> >> Value  Symbol's Name
> >> 000000000000002c  0000000200000004 R_BPF_64_NODYLD32
> >> 0000000000000000 .text
> >> 0000000000000040  0000000200000004 R_BPF_64_NODYLD32
> >> 0000000000000000 .text
> >> 0000000000000050  0000000200000004 R_BPF_64_NODYLD32
> >> 0000000000000000 .text
> >>
> >> During JIT relocation resolution, it is OKAY to resolve 'g' to
> >> be actual address and actually it is a good thing since tools
> >> like bcc actually go through dwarf interface to dump instructions
> >> interleaved with source codes.
> >>
> >> Note that dwarf won't be loaded into the kernel.
> >>
> >> But we don't want relocations in .BTF/.BTF.ext to be resolved with
> >> actually addresses. They will be processed by bpf libraries and the
> >> kernel. The reason not to have relocation resolution
> >> is not due to their names, but due
> >> to their functionality. If we intend to load dwarf to kernel, we
> >> will issue R_BPF_64_NODYLD32 to dwarf as well.
> >
> > Is the problem due to REL relocations not being idempotent?
>
> No, it is not. This purely depends on how the data will be used
> in what situations. BPF is kind of special here. For most JIT
> program, after JIT, the program will be executed on host.
> But for BPF programs and some other BPF related objects,
> after JIT, the program actually will need
> to do some other processing and executed in kernel.
>
> >
> >> One can argue we should have fine control in RuntimeDyld so
> >> that which section to have runtime relocation resolution
> >> and which section does not. I don't know whether
> >> ExecutionEngine/RuntimeDyld agree with that or not. But
> >> BPF backend perspective, R_BPF_64_ABS32 and R_BPF_64_NODYLD32
> >> are two different relocations, they may do something common
> >> in some places like lld, but they may do different things
> >> in other places like dyld.
> >
> > If RELA is used, will the tool be happy if you just unconditionally
> > apply relocations?
>
> No. RELA will not fix the issue because the issue is not due to
> REL or RELA.

OK.

> >
> > You are introducing new relocation types anyway, so migrating to RELA m=
ay
> > simplify a bunch of things. The issue is only about forward compatibili=
ty
> > for some tools.
>
> This R_BPF_64_NODYLD32 covers 32bit data relocation which we don't want
> dynamic linker to change. The section data in object code contains
> all the needed information for BPF programs to run and verify, so
> R_BPF_64_NODYLD32 is not really used by outside tools. This is evident
> because previously we actually have R_BPF_NONE, and we changed
> to R_BPF_64_NODYLD32 to make it lld friendly to adjust when merging
> multiple sections.
>
> >
> >> Is the above reasonable or you have some further suggestions
> >> on how to resolve this? I guess I do need to add some of above
> >> discussion in the documentation so it will be clear why we added
> >> this relocation.
> >
> > Yes, the DYLD part needs clarification.
>
> I explained above. DYLD is really a special use case for BPF
> and JITed BPF codes cannot run on the host, it needs to be processed
> by bpf loader and run on the kernel. So it puts some constraints on
> what dynamic linker should do for the JITed code and sections.

OK, I still don't understand it but I will trust you that
the relocation type (R_BPF_64_NODYLD32) is needed and ld.lld does need
to handle it,
even if its linker semantic is exactly the same as another relocation type.

> >>>
> >>>>>
> >>>>>> +Type ``R_BPF_64_32`` is used for call instruction. The call targe=
t
> >>>>>> section
> >>>>>> +offset is stored at ``r_offset + 4`` (32bit) and calculated as
> >>>>>> +``(S + IA) / 8 - 1``.
> >>>>>
> >>>>> In other ABIs, names like 32/ABS32/ABS64 refer to absolute relocati=
on types
> >>>>> without such complex operation.
> >>>>
> >>>> Again, this is a historical artifact to handle call instruction. I a=
m
> >>>> aware that this might be different from other architectures. But we =
have
> >>>> to keep backward compatibility...
> >>>>
> >>>>>
> >>>>>> +Examples
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +Types ``R_BPF_64_64`` and ``R_BPF_64_32`` are used to resolve
> >>>>>> ``ld_imm64``
> >>>>>> +and ``call`` instructions. For example::
> >>>>>> +
> >>>>>> +  __attribute__((noinline)) __attribute__((section("sec1")))
> >>>>>> +  int gfunc(int a, int b) {
> >>>>>> +    return a * b;
> >>>>>> +  }
> >>>>>> +  static __attribute__((noinline)) __attribute__((section("sec1")=
))
> >>>>>> +  int lfunc(int a, int b) {
> >>>>>> +    return a + b;
> >>>>>> +  }
> >>>>>> +  int global __attribute__((section("sec2")));
> >>>>>> +  int test(int a, int b) {
> >>>>>> +    return gfunc(a, b) +  lfunc(a, b) + global;
> >>>>>> +  }
> >>>>>> +
> >>>> [...]
