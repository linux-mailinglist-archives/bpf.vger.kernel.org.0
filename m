Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F0B313EF1
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 20:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbhBHT2y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 14:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbhBHT2p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 14:28:45 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A41C061786;
        Mon,  8 Feb 2021 11:27:54 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id u8so16159269ior.13;
        Mon, 08 Feb 2021 11:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=80BOdecHNLu1xNb0lwmGU+TDCNoDEQApITw30vcAeAs=;
        b=DWBkqCMy7Ba5vSvg33V4KGnnmhB77clq/0O8YYzO7bdYF76ZBz3sMW862jIip4DMMu
         YoxIKs5LnCwN4d5PmAE4zj3Imwi/Fi44spBiTb0iPHpQ8BkSYKnCwmHCStPQcmAgmTEu
         kgN3E+VEP5VAcRQ9xhwVVoDRCMljnk4Ff4iGZITBa5CPbSrjgHjIOOA8zAT4v1TWvfEq
         iOdLUiihqQg/oUev5pseGN7wF4/u9j1RLlBD9S+C/3RdmrmDPcjtJqxVWcKvcnsi+UPD
         Z5vndw1VaNpJbx8LyrjkV6KRVcntsLRX7vycr6osISXtMC6JVnJwEjUIrkLpsXX77H+3
         MapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=80BOdecHNLu1xNb0lwmGU+TDCNoDEQApITw30vcAeAs=;
        b=rsFoPcuAYC07PZcepM1AJlfbXHLd2cIpIUKI622IGYQXg93pZShz2vNjfLH1eZG9Dt
         VlMKs+8GKIHs2tYmWz0LbQo5UKWqfo3PqlqvQZFRrg4S7YvfEucKnyH45/0oQ+Gen/kN
         /HU4NViAk3LdB0PV8A5wIbtye7PhpBsfDNax6zvU0WC1Nb5oveTNLnZSFgIO6YPQ4QLm
         KFU3JTg1VzkLRXjjWNRStn4yG5CEzTeEy/21pZGsVVuea2PunoThUUP9aPfbkvf46UGd
         Hbcbj/NQSkOVOoxK64nV4qOpuxdmyeP/gPzPXJMuHNELHiCVGY5inGhXhQ2yuUb6qwzh
         VYHw==
X-Gm-Message-State: AOAM530TFSk1RZQBRbA25s9htVP3sNH1ue1OVOdqPp7cCmwfN7qvciFv
        8wRwh8XVSLY/jhmOzL3fWTAlNmMwlAKBzFAjCjs=
X-Google-Smtp-Source: ABdhPJzxLeEDRWOJ88B1XzDYIXQqoxtkXjuYm4kyLClahFPrH2jUC+fIvnhLzgW8pvDd6/4d5UkG2IUFoEbKqVpwzyo=
X-Received: by 2002:a6b:f112:: with SMTP id e18mr16253699iog.57.1612812474086;
 Mon, 08 Feb 2021 11:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20210207071726.3969978-1-yhs@fb.com> <CAKwvOdm81yoFXg65XPc=PTOC+P7J9TJuFc3ag9TvFkjGW0iGVg@mail.gmail.com>
In-Reply-To: <CAKwvOdm81yoFXg65XPc=PTOC+P7J9TJuFc3ag9TvFkjGW0iGVg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Feb 2021 20:27:42 +0100
Message-ID: <CA+icZUX2ZD0zrn7XObm9C-+_AVXU4s-v3pyMvfYkMCS8vcs6Sg@mail.gmail.com>
Subject: Re: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base type
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wielaard <mark@klomp.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 8:23 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Sat, Feb 6, 2021 at 11:17 PM Yonghong Song <yhs@fb.com> wrote:
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
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Yonghong Song <yhs@fb.com>
>
> Thanks for the patch!
>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>

Cool, thanks for testing Nick.

- Sedat -

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
>
>
> --
> Thanks,
> ~Nick Desaulniers
