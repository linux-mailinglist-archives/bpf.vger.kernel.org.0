Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4B0314151
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 22:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhBHVJS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 16:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhBHVIq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 16:08:46 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6705AC061786;
        Mon,  8 Feb 2021 13:08:06 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id l8so3646575ybe.12;
        Mon, 08 Feb 2021 13:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noSJUXjDQ6F/LUyp3QypM6n3XmzY+x6kHer818FrlQ8=;
        b=sYb6Zayj/cuY2lFU5wmrf7wbrUjVH2ehFGSwewP4oPg6yzdFRJCtqJn7OFAUHjrBIv
         85yPx7tPzdfYKxis+XcfTGLzH1WvidO27FjlthOU1cPEMEN5LhVHwSRrFljSK9jyUE4g
         q+plVyIcDMF7oQk+5IBQTMHXQLWUbMqCIjxs2+gONqd32QedkvfoAgBkJDHYENsQqHYk
         jc8vVb07o/rhDdm+TBL0zQ9nQaaigqzzWc94P0mwesUW1dbYckF/P0k/bVRt+rNvvtov
         OcTc7+eEjxro/qEYQ3CFHRUT+2auc1oGkt0lBCZvIJxhRNw3LkUgibvI89RmpeDxtvRy
         +QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noSJUXjDQ6F/LUyp3QypM6n3XmzY+x6kHer818FrlQ8=;
        b=dje+bHVUJBQ4w+DuFtN7jH/ijJi7znPz+hleTKubpleMRgSMAZCpGzAAM4ad7HAiTB
         dESj0X5EkIPS3Bi9EEjzvNNh18xor5rkAA4bnM9T8OX25MUJS22KiEXfMjqDtBbKAeFz
         Krx7WLkVlryKlZru8SimpUBrnclFgRe4gnU4b3bhGYewt8aP+LjLxzVgye+1PIYzO6os
         SxyOym6i/fNZfahyiMUSk/Iz8bxnhKD2FeOcydDk1PviE9eygubZBVVq13RcEdVn6k/B
         r8OGf9Mwb8OeWdkDAovFR9l6uCerJSPYIGStIrhvN7ijSfeHMHI0bEtpBp5u3qp0807z
         aHPw==
X-Gm-Message-State: AOAM532YBPArBypKjPSg/FwXyrYhBDW2kvvgzthSB5LjOpm6xS1aWiDM
        GMw/r6TBcSE5omvel7avETYXVmt8ymK0yJFd5tU=
X-Google-Smtp-Source: ABdhPJzel9E4YgERoCN73vcdoU8LSt5i/cTZouD6LyI8w7fcov0cH3taG08oIjtzbqU5yCGa10iu7x0ZAsqeeeiTVwY=
X-Received: by 2002:a25:3805:: with SMTP id f5mr11263481yba.27.1612818485747;
 Mon, 08 Feb 2021 13:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20210207071726.3969978-1-yhs@fb.com> <CA+icZUVwz+OroPfsqtOxAstWGeRxf=KYMUY5LCDPzyPLJFmZmg@mail.gmail.com>
 <20210208195501.GS920417@kernel.org> <CA+icZUWTzrNXfB1FypgrbSneraY+-9LdqJBNdhWSgGCR-2+Ddg@mail.gmail.com>
In-Reply-To: <CA+icZUWTzrNXfB1FypgrbSneraY+-9LdqJBNdhWSgGCR-2+Ddg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 13:07:54 -0800
Message-ID: <CAEf4Bzb=xx0TZOtOJqYVHGGpHTEbL7X_Ap0oCPVpWutEKLfq3g@mail.gmail.com>
Subject: Re: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base type
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Mark Wielaard <mark@klomp.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 12:46 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, Feb 8, 2021 at 8:55 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Sun, Feb 07, 2021 at 11:32:00AM +0100, Sedat Dilek escreveu:
> > > On Sun, Feb 7, 2021 at 8:17 AM Yonghong Song <yhs@fb.com> wrote:
> > > >
> > > > clang with dwarf5 may generate non-regular int base type,
> > > > i.e., not a signed/unsigned char/short/int/longlong/__int128.
> > > > Such base types are often used to describe
> > > > how an actual parameter or variable is generated. For example,
> > > >
> > > > 0x000015cf:   DW_TAG_base_type
> > > >                 DW_AT_name      ("DW_ATE_unsigned_1")
> > > >                 DW_AT_encoding  (DW_ATE_unsigned)
> > > >                 DW_AT_byte_size (0x00)
> > > >
> > > > 0x00010ed9:         DW_TAG_formal_parameter
> > > >                       DW_AT_location    (DW_OP_lit0,
> > > >                                          DW_OP_not,
> > > >                                          DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1",
> > > >                                          DW_OP_convert (0x000015d4) "DW_ATE_unsigned_8",
> > > >                                          DW_OP_stack_value)
> > > >                       DW_AT_abstract_origin     (0x00013984 "branch")
> > > >
> > > > What it does is with a literal "0", did a "not" operation, and the converted to
> > > > one-bit unsigned int and then 8-bit unsigned int.
> > > >
> > > > Another example,
> > > >
> > > > 0x000e97e4:   DW_TAG_base_type
> > > >                 DW_AT_name      ("DW_ATE_unsigned_24")
> > > >                 DW_AT_encoding  (DW_ATE_unsigned)
> > > >                 DW_AT_byte_size (0x03)
> > > >
> > > > 0x000f88f8:     DW_TAG_variable
> > > >                   DW_AT_location        (indexed (0x3c) loclist = 0x00008fb0:
> > > >                      [0xffffffff82808812, 0xffffffff82808817):
> > > >                          DW_OP_breg0 RAX+0,
> > > >                          DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> > > >                          DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
> > > >                          DW_OP_stack_value,
> > > >                          DW_OP_piece 0x1,
> > > >                          DW_OP_breg0 RAX+0,
> > > >                          DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> > > >                          DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> > > >                          DW_OP_lit8,
> > > >                          DW_OP_shr,
> > > >                          DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> > > >                          DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
> > > >                          DW_OP_stack_value,
> > > >                          DW_OP_piece 0x3
> > > >                      ......
> > > >
> > > > At one point, a right shift by 8 happens and the result is converted to
> > > > 32-bit unsigned int and then to 24-bit unsigned int.
> > > >
> > > > BTF does not need any of these DW_OP_* information and such non-regular int
> > > > types will cause libbpf to emit errors.
> > > > Let us sanitize them to generate BTF acceptable to libbpf and kernel.
> > > >
> > > > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > >
> > > Thanks for v2.
> > >
> > > For both v1 and v2:
> > >
> > >    Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > >    Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> >
> > Thanks, applied.
> >
>
> Great.
> I cannot see it yet in [1] or [2].
>
> More important to me is is this worth a pahole v1.20.1 release?
> This patch is required to successfully build with BTF and DWARF-5 and Clang-12.
>
> I have Nathan's "bpf: Hoise pahole version checks into Kconfig" patch
> in my custom patchset (together with Nick's DWARF-v5 patchset) which
> makes it easier to do (depends on PAHOLE_VERSION >= 1201) via Kconfig

I don't think the math works out with 1201 vs 121 (in the future), so
I'd rather prefer 1.21, if necessary.

> for example.
>
> - Sedat -
>
> [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
> [2] https://github.com/acmel/dwarves/
>
> > - Arnaldo
> >
> > > My development and testing environment:
> > >
> > > 1. Debian/testing AMD64
> > > 2. Linux v5.11-rc6+ with custom mostly Clang fixes
> > > 3. Debug-Info: BTF + DWARF-v5 enabled
> > > 4. Compiler and tools (incl. Clang's Integrated ASsembler IAS):
> > > LLVM/Clang v12.0.0-rc1 (make LLVM=1 LLVM_IAS=1)
> > >
> > > Build and boot on bare metal.
> > >
> > > - Sedat -
> > >
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Yonghong Song <yhs@fb.com>
> > > > ---
> > > >  libbtf.c | 39 ++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 38 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/libbtf.c b/libbtf.c
> > > > index 9f76283..5843200 100644
> > > > --- a/libbtf.c
> > > > +++ b/libbtf.c
> > > > @@ -373,6 +373,7 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
> > > >         struct btf *btf = btfe->btf;
> > > >         const struct btf_type *t;
> > > >         uint8_t encoding = 0;
> > > > +       uint16_t byte_sz;
> > > >         int32_t id;
> > > >
> > > >         if (bt->is_signed) {
> > > > @@ -384,7 +385,43 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
> > > >                 return -1;
> > > >         }
> > > >
> > > > -       id = btf__add_int(btf, name, BITS_ROUNDUP_BYTES(bt->bit_size), encoding);
> > > > +       /* dwarf5 may emit DW_ATE_[un]signed_{num} base types where
> > > > +        * {num} is not power of 2 and may exceed 128. Such attributes
> > > > +        * are mostly used to record operation for an actual parameter
> > > > +        * or variable.
> > > > +        * For example,
> > > > +        *     DW_AT_location        (indexed (0x3c) loclist = 0x00008fb0:
> > > > +        *         [0xffffffff82808812, 0xffffffff82808817):
> > > > +        *             DW_OP_breg0 RAX+0,
> > > > +        *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> > > > +        *             DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
> > > > +        *             DW_OP_stack_value,
> > > > +        *             DW_OP_piece 0x1,
> > > > +        *             DW_OP_breg0 RAX+0,
> > > > +        *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> > > > +        *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> > > > +        *             DW_OP_lit8,
> > > > +        *             DW_OP_shr,
> > > > +        *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> > > > +        *             DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
> > > > +        *             DW_OP_stack_value, DW_OP_piece 0x3
> > > > +        *     DW_AT_name    ("ebx")
> > > > +        *     DW_AT_decl_file       ("/linux/arch/x86/events/intel/core.c")
> > > > +        *
> > > > +        * In the above example, at some point, one unsigned_32 value
> > > > +        * is right shifted by 8 and the result is converted to unsigned_32
> > > > +        * and then unsigned_24.
> > > > +        *
> > > > +        * BTF does not need such DW_OP_* information so let us sanitize
> > > > +        * these non-regular int types to avoid libbpf/kernel complaints.
> > > > +        */
> > > > +       byte_sz = BITS_ROUNDUP_BYTES(bt->bit_size);
> > > > +       if (!byte_sz || (byte_sz & (byte_sz - 1))) {
> > > > +               name = "__SANITIZED_FAKE_INT__";
> > > > +               byte_sz = 4;
> > > > +       }
> > > > +
> > > > +       id = btf__add_int(btf, name, byte_sz, encoding);
> > > >         if (id < 0) {
> > > >                 btf_elf__log_err(btfe, BTF_KIND_INT, name, true, "Error emitting BTF type");
> > > >         } else {
> > > > --
> > > > 2.24.1
> > > >
> >
> > --
> >
> > - Arnaldo
