Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3855F328547
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 17:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhCAQwO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Mar 2021 11:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbhCAQtf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Mar 2021 11:49:35 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10675C061756
        for <bpf@vger.kernel.org>; Mon,  1 Mar 2021 08:48:47 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id k2so13007608ioh.5
        for <bpf@vger.kernel.org>; Mon, 01 Mar 2021 08:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAt1FuweIRy1JX/GBU3WBPCdCBjOYvNKEhOvVI2Rrhg=;
        b=MhNf0pcntYA2BpnVgd4sl37Sjxxeek2fSDt87kVR5X0PJIQc5JqR+FroyYNHAOcIi6
         tHIhEZ4dnCi/jInzBTkXyVY9ITw81gxDo6Ha9aTkQ8EBhx7TujziwBYzEBU4qa7xb7HI
         vMdd4F5xJbyTpfhlAf6z0Ek6lMHBScrq541gXpS9AklKNzfR7Bad+RjCc0SF9RTr4nIT
         kggRJM9kBgKnEbU2J9AfoKAKGnenLZ/MhGf+fs6xwFUWyb/pRnmQlMSOAk3qJaBLk9+Q
         BX94hqcwyGxQAtR4CB1o8KDyMkc4s/8KngqWjBFUi1IJyrPrR3TeK3sRfKkUXp8hVVEC
         fW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAt1FuweIRy1JX/GBU3WBPCdCBjOYvNKEhOvVI2Rrhg=;
        b=Zb4/g7jc78MhWrs0tTmMgi/62KdOs9AFt68mfJ2QPlse48ltlnyNKU411GSZ1qjP43
         Lb8MUZN6ROJ/b99mg5gpZsgX69nsGZ487mVuE4OuTHdU+CpxGxE+BhTCuLxozcG+lp1w
         xoUVjSOMrHL+LestMu+ODT2sboHZwyphU/lbD1wDV3nz+QmLlH9dwalQ6mctVFwuCfsg
         QGNzPE7AEOt9qQ/7J5QeJSc/tEj8UoGcVr9BK4GOienFGCn5GZHpeXMKjVXqHuTRXNM2
         Ah+se1ftxK606Kt97YyKcT4E7g61+o7M7dKe6EOC2h4YwzeUmxdixFQ1HBdi8CNTg2+w
         8fQQ==
X-Gm-Message-State: AOAM532rpGL7obmAYbp79ds+v75nGxJ9jAxbONBNLQHrVT9/Gr88leYv
        b2Ua6Rp76juaaveTPMCA1Sh9pJXE3vF4DK64LzUhRDfGsCE=
X-Google-Smtp-Source: ABdhPJxSc1UbVYZiYMUZB0zumpFPHAtQmYwqyLIunxjnJZpL7WXu06Gl+rLPCkBBfwdfM5iyW7WwQksElYA6YHmi9ug=
X-Received: by 2002:a05:6638:218f:: with SMTP id s15mr7901676jaj.58.1614617326311;
 Mon, 01 Mar 2021 08:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20210223150845.1857620-1-jackmanb@google.com> <20210224054757.3b3zfzng2pvqhbf5@kafai-mbp.dhcp.thefacebook.com>
 <CA+i-1C0NyLrMDiFnD9Jdrs_ww-a7kX7XaEaT1YiyrC5w0LJdXA@mail.gmail.com> <20210224221440.4ncxz7vyo7weygm3@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210224221440.4ncxz7vyo7weygm3@kafai-mbp.dhcp.thefacebook.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Mon, 1 Mar 2021 17:48:35 +0100
Message-ID: <CA+i-1C3ytZz6FjcPmUg5s4L51pMQDxWcZNvM86w4RHZ_o2khwg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 24 Feb 2021 at 23:14, Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Feb 24, 2021 at 10:32:28AM +0100, Brendan Jackman wrote:
> > On Wed, 24 Feb 2021 at 06:48, Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Tue, Feb 23, 2021 at 03:08:45PM +0000, Brendan Jackman wrote:
> > > [ ... ]
> > >
> > > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > > index 0ae015ad1e05..dcf18612841b 100644
> > > > --- a/kernel/bpf/core.c
> > > > +++ b/kernel/bpf/core.c
> > > > @@ -2342,6 +2342,10 @@ bool __weak bpf_helper_changes_pkt_data(void *func)
> > > >  /* Return TRUE if the JIT backend wants verifier to enable sub-register usage
> > > >   * analysis code and wants explicit zero extension inserted by verifier.
> > > >   * Otherwise, return FALSE.
> > > > + *
> > > > + * The verifier inserts an explicit zero extension after BPF_CMPXCHGs even if
> > > > + * you don't override this. JITs that don't want these extra insns can detect
> > > > + * them using insn_is_zext.
> > > >   */
> > > >  bool __weak bpf_jit_needs_zext(void)
> > > >  {
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 3d34ba492d46..ec1cbd565140 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -11061,8 +11061,16 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
> > > >                        */
> > > >                       if (WARN_ON(!(insn.imm & BPF_FETCH)))
> > > >                               return -EINVAL;
> > > > -                     load_reg = insn.imm == BPF_CMPXCHG ? BPF_REG_0
> > > > -                                                        : insn.src_reg;
> > > > +                     /* There should already be a zero-extension inserted after BPF_CMPXCHG. */
> > > > +                     if (insn.imm == BPF_CMPXCHG) {
> > > > +                             struct bpf_insn *next = &insns[adj_idx + 1];
> > > > +
> > > > +                             if (WARN_ON(!insn_is_zext(next) || next->dst_reg != insn.src_reg))
> > > > +                                     return -EINVAL;
> > > > +                             continue;
> > > This is to avoid zext_patch again for the JITs with
> > > bpf_jit_needs_zext() == true.
> > >
> > > IIUC, at this point, aux[adj_idx].zext_dst == true which
> > > means that the check_atomic() has already marked the
> > > reg0->subreg_def properly.
> >
> > That's right... sorry I'm not sure if you're implying something here
> > or just checking understanding?
> >
> > > > +                     }
> > > > +
> > > > +                     load_reg = insn.src_reg;
> > > >               } else {
> > > >                       load_reg = insn.dst_reg;
> > > >               }
> > > > @@ -11666,6 +11674,27 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
> > > >                       continue;
> > > >               }
> > > >
> > > > +             /* BPF_CMPXCHG always loads a value into R0, therefore always
> > > > +              * zero-extends. However some archs' equivalent instruction only
> > > > +              * does this load when the comparison is successful. So here we
> > > > +              * add a BPF_ZEXT_REG after every 32-bit CMPXCHG, so that such
> > > > +              * archs' JITs don't need to deal with the issue. Archs that
> > > > +              * don't face this issue may use insn_is_zext to detect and skip
> > > > +              * the added instruction.
> > > > +              */
> > > > +             if (insn->code == (BPF_STX | BPF_W | BPF_ATOMIC) && insn->imm == BPF_CMPXCHG) {
> > > > +                     struct bpf_insn zext_patch[2] = { *insn, BPF_ZEXT_REG(BPF_REG_0) };
> > > Then should this zext_patch only be done for "!bpf_jit_needs_zext()"
> > > such that the above change in opt_subreg_zext_lo32_rnd_hi32()
> > > becomes unnecessary?
> >
> > Yep that would work but I IMO it would be a more fragile expression of
> > the logic: instead of directly checking whether something was done
> > we'd be looking at a proxy for another part of the system's behaviour.
> > I don't think it would win us anything in terms of clarity either?
> hmmm... I find it quite confusing to read.
>
> While the current opt_subreg_zext_lo32_rnd_hi32() has
> already been doing the actual zext patching work based
> on the zext_dst marking,
> this patch does zext patch for cmpxchg before opt_subreg_zext_lo32_rnd_hi32()
> even the zext_dst has already been marked.
>
> Then later in opt_subreg_zext_lo32_rnd_hi32(), code is
> added to avoid doing the zext patch again for the
> "!bpf_jit_needs_zext()" case.
>
> If there is other cases later, then changes have to be made
> in both places, one does zext patch and then another to
> avoid double patch for the "!bpf_jit_needs_zext()" case.
>
> Why not only patch it when there is no other places doing it?
>
> It may be better to do the zext patch for cmpxchg in
> opt_subreg_zext_lo32_rnd_hi32() also.  Then all zext patch
> is done in one place.  Something like:
>
> static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>                                         const union bpf_attr *attr)
> {
>
>         for (i = 0; i < len; i++) {
>                 /* ... */
>
>                 if (!bpf_jit_needs_zext() && !is_cmpxchg_insn(insn))
>                         continue;
>
>                 /* do zext patch */
>         }
> }
>
> Would that work?

Yep - this is so much simpler and clearer. Thanks! Sending another spin.
