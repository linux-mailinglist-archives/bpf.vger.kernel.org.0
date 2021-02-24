Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA8532398B
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 10:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhBXJd6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 04:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhBXJd0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 04:33:26 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F4BC061786
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 01:32:40 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id p16so1342829ioj.4
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 01:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCgixK4zZh5zfdxG9uRDG+RFeumtRNShc9DZBrLkh9U=;
        b=mpkfFilzOgPOOrG8VMnAVzxZ5qAk/MBoE5V/C5kX67+TRAx/+P3LD1HpToH9q5DiyF
         SKXJ1PfKQb6/aJj+hYSfR8Cv1VI2O7h5zAtxcIzAwB35cmQuaFiuwYZX+pklmGbF4ZFc
         CHKwsqUIco8X+ESiQL2vK5vANuYWP9wZATOancN2mstRtpQHmDjTatLjU/qnxGVgvF4+
         xLfpTLovxmc6UGAIzOuAsIoNjRxze1oA9NZJV8loWmdVA0QBMNKLBNL55VZdBJAHLged
         1ZE8IG9njizs4q3ZIICIDSHIkQ92CdKA+qMz55zFLtJp+IkSua1q+5kbCIkW/oH2URWX
         o2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCgixK4zZh5zfdxG9uRDG+RFeumtRNShc9DZBrLkh9U=;
        b=BVNC6brNgTkLicQb1hryHdFiNV4Seamighc0q4gDXhex5Wys46dZdE3POBC2BSL85G
         xYK5/t7rqyCksxKnkLo0WClzm44kEvenEbKpElQilYoq6isY3b8082FbaJfRYfwzaBlx
         PybdKp4qYhpv8Zib0xbHvyeIgdLLQNi16C6MjTvnzdhQ3LNvj6DRnj33WcmggbznNrkS
         7+Bah2HPcLfPS8E06LahjPb6cERdPLsVZkp19Xz7f7lGqaJ6LQwwcdZ7g4SKAsv9oTwH
         ks4okgnHRh0f8cgfmoqBZnf98ssuFGU5ZF68N0CBtwSoCR0E1LPKmIQJjZwTLj2bTkW+
         kNDA==
X-Gm-Message-State: AOAM5333bEkdXr94LWF9AFqBP/mHlqi2u/Wzj7FXl4LTmBJ8rUtapOmj
        9po0xDuiqsed7J5eGj798mTc7qsg2gAyIIaritHhCg==
X-Google-Smtp-Source: ABdhPJxDTcKrpeZbfkiuURc+c5dodaRKFkURTl9WhCUVb5oIKgibmMWj5FfZjralt5vzRIDQR6vT7gltsLg3OwxyhEg=
X-Received: by 2002:a05:6602:3341:: with SMTP id c1mr23718519ioz.172.1614159159758;
 Wed, 24 Feb 2021 01:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20210223150845.1857620-1-jackmanb@google.com> <20210224054757.3b3zfzng2pvqhbf5@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210224054757.3b3zfzng2pvqhbf5@kafai-mbp.dhcp.thefacebook.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Wed, 24 Feb 2021 10:32:28 +0100
Message-ID: <CA+i-1C0NyLrMDiFnD9Jdrs_ww-a7kX7XaEaT1YiyrC5w0LJdXA@mail.gmail.com>
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

On Wed, 24 Feb 2021 at 06:48, Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Feb 23, 2021 at 03:08:45PM +0000, Brendan Jackman wrote:
> [ ... ]
>
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 0ae015ad1e05..dcf18612841b 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2342,6 +2342,10 @@ bool __weak bpf_helper_changes_pkt_data(void *func)
> >  /* Return TRUE if the JIT backend wants verifier to enable sub-register usage
> >   * analysis code and wants explicit zero extension inserted by verifier.
> >   * Otherwise, return FALSE.
> > + *
> > + * The verifier inserts an explicit zero extension after BPF_CMPXCHGs even if
> > + * you don't override this. JITs that don't want these extra insns can detect
> > + * them using insn_is_zext.
> >   */
> >  bool __weak bpf_jit_needs_zext(void)
> >  {
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 3d34ba492d46..ec1cbd565140 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11061,8 +11061,16 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
> >                        */
> >                       if (WARN_ON(!(insn.imm & BPF_FETCH)))
> >                               return -EINVAL;
> > -                     load_reg = insn.imm == BPF_CMPXCHG ? BPF_REG_0
> > -                                                        : insn.src_reg;
> > +                     /* There should already be a zero-extension inserted after BPF_CMPXCHG. */
> > +                     if (insn.imm == BPF_CMPXCHG) {
> > +                             struct bpf_insn *next = &insns[adj_idx + 1];
> > +
> > +                             if (WARN_ON(!insn_is_zext(next) || next->dst_reg != insn.src_reg))
> > +                                     return -EINVAL;
> > +                             continue;
> This is to avoid zext_patch again for the JITs with
> bpf_jit_needs_zext() == true.
>
> IIUC, at this point, aux[adj_idx].zext_dst == true which
> means that the check_atomic() has already marked the
> reg0->subreg_def properly.

That's right... sorry I'm not sure if you're implying something here
or just checking understanding?

> > +                     }
> > +
> > +                     load_reg = insn.src_reg;
> >               } else {
> >                       load_reg = insn.dst_reg;
> >               }
> > @@ -11666,6 +11674,27 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
> >                       continue;
> >               }
> >
> > +             /* BPF_CMPXCHG always loads a value into R0, therefore always
> > +              * zero-extends. However some archs' equivalent instruction only
> > +              * does this load when the comparison is successful. So here we
> > +              * add a BPF_ZEXT_REG after every 32-bit CMPXCHG, so that such
> > +              * archs' JITs don't need to deal with the issue. Archs that
> > +              * don't face this issue may use insn_is_zext to detect and skip
> > +              * the added instruction.
> > +              */
> > +             if (insn->code == (BPF_STX | BPF_W | BPF_ATOMIC) && insn->imm == BPF_CMPXCHG) {
> > +                     struct bpf_insn zext_patch[2] = { *insn, BPF_ZEXT_REG(BPF_REG_0) };
> Then should this zext_patch only be done for "!bpf_jit_needs_zext()"
> such that the above change in opt_subreg_zext_lo32_rnd_hi32()
> becomes unnecessary?

Yep that would work but I IMO it would be a more fragile expression of
the logic: instead of directly checking whether something was done
we'd be looking at a proxy for another part of the system's behaviour.
I don't think it would win us anything in terms of clarity either?

Thanks for taking a look!
