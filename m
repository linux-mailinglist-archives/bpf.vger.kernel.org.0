Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728D050A80E
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382245AbiDUS15 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391517AbiDUS1q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 14:27:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EAF4C431;
        Thu, 21 Apr 2022 11:24:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n11-20020a17090a73cb00b001d1d3a7116bso6223860pjk.0;
        Thu, 21 Apr 2022 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCbcFDFbn2mhKynuYB02KhdbVXr72r1cIVRt2FI2Ets=;
        b=HqvvWWyYs5DFKktWicH2EF49fqzUee2aliWRQKcrrunRjNuGvLFTBvT7Y1V4ZxXT+G
         xV4tsLbFEw/uFKZ3cb2jWPYkl6CVhSz+bRhr5h2vVASWouwqqirPrCSpq706jU4Q+RUa
         3obsQQ9UXtPRvl+MZnj0mdegShcWv4zU7R9QaIUxdCXDEj7ZE1JTjO2vT8yqh3UcZHNJ
         Nfd0hgTnaCz7eUTysQaP4C3enbN0omZ6IOugtbZmPxNlNJLbMvYu5faNCdTeN8KNhO03
         72ry4qCftQTgxBWSJ2zeu8Y9gu51D5dUM431GOLzbmwnLA6Li8+IjxXwHOCptdLYg2yD
         jovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCbcFDFbn2mhKynuYB02KhdbVXr72r1cIVRt2FI2Ets=;
        b=4rbpWMePW+glMUM5e1qBznkI3ms24/04y3mEW+pjaL6nG0i+Mw8JEprthC4ue20f80
         7iP7/i+wdSBj798NVi15R28aBTKoNkpv9TCIMHpwY97KWp2KcdJADfyC7d4LAbDM14Ko
         fH7nPc+0AQaaIfaMLk6m7FsQpqGHrJcc4iYaD3qY75+DJmWjggQHcFPYGxJuv1CbM1te
         Enn2Xi0U4eE1cSzPlQePAzOZBWXsyP2gwhstRU58Iuczi2M3Vk6sjcUIZBC4bKzXkSJ8
         Hcgwswrz/E2mNFRo0y0zVwYyTQNw09UUvvXddPG08sSmOFjk4kmvBLDXm++9NmLBWr8z
         qW8A==
X-Gm-Message-State: AOAM531ecxlu0me/QkeD/UOfzgVbqkGSueHxKzD2Cwd6eP8ygsCISAvr
        ZOWAp+HnsQsoIuF5SzMf0ezopRSWs3FN879RVfI=
X-Google-Smtp-Source: ABdhPJwYBNWuVtwoUeeocV7PLCWhSWkNZkv2HQVwVmYSf5Sz3RNhIY+aKyczpvducm6w2n3P2pO4FfHViXzUIYvxX40=
X-Received: by 2002:a17:90a:8591:b0:1b9:da10:2127 with SMTP id
 m17-20020a17090a859100b001b9da102127mr11902949pjn.13.1650565482039; Thu, 21
 Apr 2022 11:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220421072212.608884-1-song@kernel.org> <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
In-Reply-To: <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 Apr 2022 11:24:31 -0700
Message-ID: <CAADnVQKyDwXUMCfmdabbVE0vSGxdpqmWAwHRBqbPLW=LdCnHBQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 10:09 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Apr 21, 2022 at 12:27 AM Song Liu <song@kernel.org> wrote:
> >
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -228,6 +228,28 @@ static void jit_fill_hole(void *area, unsigned int size)
> >         memset(area, 0xcc, size);
> >  }
> >
> > +#define INVALID_BUF_SIZE PAGE_SIZE
> > +static char invalid_insn_buf[INVALID_BUF_SIZE];
> > +
> > +static int __init bpf_init_invalid_insn_buf(void)
> > +{
> > +       jit_fill_hole(invalid_insn_buf, INVALID_BUF_SIZE);
> > +       return 0;
> > +}
> > +pure_initcall(bpf_init_invalid_insn_buf);
> > +
> > +void bpf_arch_invalidate_text(void *dst, size_t len)
> > +{
> > +       size_t i = 0;
> > +
> > +       while (i < len) {
> > +               size_t s = min_t(size_t, len - i, INVALID_BUF_SIZE);
> > +
> > +               bpf_arch_text_copy(dst + i, invalid_insn_buf, s);
> > +               i += s;
> > +       }
> > +}
>
> Why do we need this new infrastructure?
>
> Why bpf_arch_invalidate_text()?
>
> Why not jit_fill_hole() unconditionally?
>
> It seems a bit pointless to have page buffer for containing this data,
> when we already have a (trivial) function to fill an area with invalid
> instructions.
>
> On x86, it's literally just "memset(0xcc)" (ie all 'int3' instructions).
>
> And on most RISC architectures, it would be some variation of
> "memset32(TRAP_INSN)".
>
> And all bpf targets should already have that nicely as that
> jit_fill_hole() function, no?
>
> The pack-allocator bpf code already *does* that, and is already passed
> that function.
>
> But it's just that it does it too late. Instead of doing it when
> allocating a new pack, it does it in the sub-allocator.
>
> Afaik the code in bpf/core.c already has all the information it needs,
> and already has that jit_fill_hole() function pointer, but is applying
> it at the wrong point.
>
> So I think the fix should be to just pass in that 'bpf_fill_ill_insns'
> function pointer all the way to alloc_new_pack(), instead of using it
> in bpf_jit_binary_alloc().

jit_fill_hole is an overkill here.

Long ago when jit spraying attack was fixed there was
a concern that memset(0) essentially populates the code page
with valid 'add BYTE PTR [rax],al' instructions.
Jumping anywhere in the zero page with a valid address in rax will
eventually lead to execution of the first insn in jit-ed bpf prog.
So memset(0xcc) was added to make it a bit harder to guess
the start address.
jit spraying is only a concern for archs that can
jump in the middle of the instruction and cpus will interpret
the byte stream differently.
The existing bpf_prog_pack code still does memset(0xcc)
a random range of bytes before and after jit-ed bpf code.
So doing memset(0xcc) for the whole huge page is not necessary at all.
Just memset(0) of a huge page at init time and memset(0)
when prog is freed is enough.
Jumping into zero page of 'valid' insns the cpu
will eventually stumble on 0xcc before reaching the first insn.
Let's not complicate the logic by dragging jit_fill_hole
further into generic allocation.
