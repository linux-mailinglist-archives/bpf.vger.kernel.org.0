Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35355313FB1
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 20:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhBHT4s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 14:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236407AbhBHTz4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 14:55:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 621B964E6C;
        Mon,  8 Feb 2021 19:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612814104;
        bh=vi6ZfT7emO1tSAW2LLLmJ9w/td9wx3wGyxvxpKaAURs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwtMkTwvMCrHQVKeted33a4afJn4VOjGb/JWqdgymVfyl8mLvBiNmJfjWed60Fxq9
         197AUy/BVgiWWOvDN71ZHAJZLIfjX8gdaXydfMC70+kLHbMyzRpQizSECmqU7L5pdi
         oZRq+KNcQ+UW+4/LPktipbJc1umlg/6PY4hbAUjJxHlleVggHGR2EwPiY9OpjGGzMs
         phmtQSCS4RHiOCd51RJspb7GZYwt7D1f5RY4gDygmjx7am87QYOZEK+Lb76kwekvIq
         L9uciCd3CL2rdpc9of652oAFP1Ds0ldTXPosG01WTpLUeI5OVjDqxlFkuCxg3rCmUE
         0WMS/DO0sOI+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ADACF40513; Mon,  8 Feb 2021 16:55:01 -0300 (-03)
Date:   Mon, 8 Feb 2021 16:55:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, andriin@fb.com, mark@klomp.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base
 type
Message-ID: <20210208195501.GS920417@kernel.org>
References: <20210207071726.3969978-1-yhs@fb.com>
 <CA+icZUVwz+OroPfsqtOxAstWGeRxf=KYMUY5LCDPzyPLJFmZmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVwz+OroPfsqtOxAstWGeRxf=KYMUY5LCDPzyPLJFmZmg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Feb 07, 2021 at 11:32:00AM +0100, Sedat Dilek escreveu:
> On Sun, Feb 7, 2021 at 8:17 AM Yonghong Song <yhs@fb.com> wrote:
> >
> > clang with dwarf5 may generate non-regular int base type,
> > i.e., not a signed/unsigned char/short/int/longlong/__int128.
> > Such base types are often used to describe
> > how an actual parameter or variable is generated. For example,
> >
> > 0x000015cf:   DW_TAG_base_type
> >                 DW_AT_name      ("DW_ATE_unsigned_1")
> >                 DW_AT_encoding  (DW_ATE_unsigned)
> >                 DW_AT_byte_size (0x00)
> >
> > 0x00010ed9:         DW_TAG_formal_parameter
> >                       DW_AT_location    (DW_OP_lit0,
> >                                          DW_OP_not,
> >                                          DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1",
> >                                          DW_OP_convert (0x000015d4) "DW_ATE_unsigned_8",
> >                                          DW_OP_stack_value)
> >                       DW_AT_abstract_origin     (0x00013984 "branch")
> >
> > What it does is with a literal "0", did a "not" operation, and the converted to
> > one-bit unsigned int and then 8-bit unsigned int.
> >
> > Another example,
> >
> > 0x000e97e4:   DW_TAG_base_type
> >                 DW_AT_name      ("DW_ATE_unsigned_24")
> >                 DW_AT_encoding  (DW_ATE_unsigned)
> >                 DW_AT_byte_size (0x03)
> >
> > 0x000f88f8:     DW_TAG_variable
> >                   DW_AT_location        (indexed (0x3c) loclist = 0x00008fb0:
> >                      [0xffffffff82808812, 0xffffffff82808817):
> >                          DW_OP_breg0 RAX+0,
> >                          DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> >                          DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
> >                          DW_OP_stack_value,
> >                          DW_OP_piece 0x1,
> >                          DW_OP_breg0 RAX+0,
> >                          DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> >                          DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> >                          DW_OP_lit8,
> >                          DW_OP_shr,
> >                          DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> >                          DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
> >                          DW_OP_stack_value,
> >                          DW_OP_piece 0x3
> >                      ......
> >
> > At one point, a right shift by 8 happens and the result is converted to
> > 32-bit unsigned int and then to 24-bit unsigned int.
> >
> > BTF does not need any of these DW_OP_* information and such non-regular int
> > types will cause libbpf to emit errors.
> > Let us sanitize them to generate BTF acceptable to libbpf and kernel.
> >
> > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> 
> Thanks for v2.
> 
> For both v1 and v2:
> 
>    Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>    Reported-by: Sedat Dilek <sedat.dilek@gmail.com>

Thanks, applied.

- Arnaldo
 
> My development and testing environment:
> 
> 1. Debian/testing AMD64
> 2. Linux v5.11-rc6+ with custom mostly Clang fixes
> 3. Debug-Info: BTF + DWARF-v5 enabled
> 4. Compiler and tools (incl. Clang's Integrated ASsembler IAS):
> LLVM/Clang v12.0.0-rc1 (make LLVM=1 LLVM_IAS=1)
> 
> Build and boot on bare metal.
> 
> - Sedat -
> 
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  libbtf.c | 39 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/libbtf.c b/libbtf.c
> > index 9f76283..5843200 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -373,6 +373,7 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
> >         struct btf *btf = btfe->btf;
> >         const struct btf_type *t;
> >         uint8_t encoding = 0;
> > +       uint16_t byte_sz;
> >         int32_t id;
> >
> >         if (bt->is_signed) {
> > @@ -384,7 +385,43 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
> >                 return -1;
> >         }
> >
> > -       id = btf__add_int(btf, name, BITS_ROUNDUP_BYTES(bt->bit_size), encoding);
> > +       /* dwarf5 may emit DW_ATE_[un]signed_{num} base types where
> > +        * {num} is not power of 2 and may exceed 128. Such attributes
> > +        * are mostly used to record operation for an actual parameter
> > +        * or variable.
> > +        * For example,
> > +        *     DW_AT_location        (indexed (0x3c) loclist = 0x00008fb0:
> > +        *         [0xffffffff82808812, 0xffffffff82808817):
> > +        *             DW_OP_breg0 RAX+0,
> > +        *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> > +        *             DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
> > +        *             DW_OP_stack_value,
> > +        *             DW_OP_piece 0x1,
> > +        *             DW_OP_breg0 RAX+0,
> > +        *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> > +        *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> > +        *             DW_OP_lit8,
> > +        *             DW_OP_shr,
> > +        *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> > +        *             DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
> > +        *             DW_OP_stack_value, DW_OP_piece 0x3
> > +        *     DW_AT_name    ("ebx")
> > +        *     DW_AT_decl_file       ("/linux/arch/x86/events/intel/core.c")
> > +        *
> > +        * In the above example, at some point, one unsigned_32 value
> > +        * is right shifted by 8 and the result is converted to unsigned_32
> > +        * and then unsigned_24.
> > +        *
> > +        * BTF does not need such DW_OP_* information so let us sanitize
> > +        * these non-regular int types to avoid libbpf/kernel complaints.
> > +        */
> > +       byte_sz = BITS_ROUNDUP_BYTES(bt->bit_size);
> > +       if (!byte_sz || (byte_sz & (byte_sz - 1))) {
> > +               name = "__SANITIZED_FAKE_INT__";
> > +               byte_sz = 4;
> > +       }
> > +
> > +       id = btf__add_int(btf, name, byte_sz, encoding);
> >         if (id < 0) {
> >                 btf_elf__log_err(btfe, BTF_KIND_INT, name, true, "Error emitting BTF type");
> >         } else {
> > --
> > 2.24.1
> >

-- 

- Arnaldo
