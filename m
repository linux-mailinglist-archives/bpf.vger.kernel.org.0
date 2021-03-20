Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C523429AA
	for <lists+bpf@lfdr.de>; Sat, 20 Mar 2021 02:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCTBlM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 21:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCTBkz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 21:40:55 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5BCC061761
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 18:40:54 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id y5so3369386qkl.9
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 18:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j70/tM1l2gVFoj1Vlwmu23HMZ+Naj9/vNEgAl0EBlR8=;
        b=ig3LH0bVLzrhwGSQ9xftM57zVglOx3bWlooIL6mAuw8/UaGnuLa5BK9B4HWknUw4b+
         Jd6/y4aZQPqEHrNZViRXArXM0X89f7RLcgVRYNdhXphA379oORewECw8kffmUO0c2fsj
         /tBE5x2Ca3TiiutNiSH8X89fBEBstrus7ywIDFZHpMV40ikx3GhcdTPQS1sF5Zk2QuRh
         Nv9yEqlcZ67dU4HP3XhQyAP30ghLhH5hjJfFeY6+2hevBtRU1cbizXHwFPJVFYdeAQxL
         6ijPkGzITIYdDH1wXbSk/AD6UddbZ+RDV0Xoh52pGIZZdXZtzjdw4ElD0pbRSpinU3tt
         aQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j70/tM1l2gVFoj1Vlwmu23HMZ+Naj9/vNEgAl0EBlR8=;
        b=R7D5WA4e29x3hLnLQGkxtI2rtN2VqDPZHFdq/6jHfy/M7XJMOAhpaeY/QP8nHgVoP4
         VPRdkde9s7kK4PqRQNutdyBi5XwE2Pt1RjT748TW/+AUIWJU2lGh7PkpSZcfwC8mSaAS
         3vfX3TyLuAmUwwqKjeWLXqjDA8TcaIlFHGZKPt4XCat5vpHy7v33wNu9o4kx/MPPha9g
         6xMXTsfIjChQukmKczLYQE2sNr5lQ4WR8mLkRhnKZwy/a0B8mOdRwG4wHZIoj3VPwID7
         vlmWkX4SORSWSLxztJNtZIXn/yfwKFwZJYMkRzdKZ66ww4lXVamRRzD5zPHMW6StJw/6
         pJOQ==
X-Gm-Message-State: AOAM5333sQ456c5ZWM8VvdC4u++sCIxTSycxRbnwsZOmI1IIszmlhwY9
        ZReoKuv+zwXQEVoOR8ISf8/BttpXgxRfvqZh5SchPQ==
X-Google-Smtp-Source: ABdhPJwxfsoYOA1pKbYhaAnz7sx1ZvOUCjOA+qWYBrmIelPcsW/iwOYx+f3NqTh+NwBXaKQrZRGQ3ApUDgMiVGWfyq8=
X-Received: by 2002:a37:6108:: with SMTP id v8mr1408297qkb.448.1616204453261;
 Fri, 19 Mar 2021 18:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210320000001.915366-1-sdf@google.com> <CAADnVQLCdMWgB9tB4UiSFHp36vswfQO_R_1ifdPqyrD6UT6vqA@mail.gmail.com>
 <CAKH8qBvXwzOqJ_4ETF1LrBQKxhKWLWv28beFHHK+=Zd0hULGFQ@mail.gmail.com> <CAADnVQ+fg-HMM=TtsrZx1kJQpy7-fckcgkN00L-Gp5Aa-CzmQQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+fg-HMM=TtsrZx1kJQpy7-fckcgkN00L-Gp5Aa-CzmQQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 19 Mar 2021 18:40:42 -0700
Message-ID: <CAKH8qBsdJak0eO_zsuzAyNmSkVtR99ZAgGgP=j8mtAn9CvZ58g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: use NOP_ATOMIC5 instead of emit_nops(&prog, 5)
 for BPF_TRAMP_F_CALL_ORIG
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 19, 2021 at 5:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 19, 2021 at 5:25 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Fri, Mar 19, 2021 at 5:14 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Mar 19, 2021 at 5:00 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > >
> > > > __bpf_arch_text_poke does rewrite only for atomic nop5, emit_nops(xxx, 5)
> > > > emits non-atomic one which breaks fentry/fexit with k8 atomics:
> > > >
> > > > P6_NOP5 == P6_NOP5_ATOMIC (0f1f440000 == 0f1f440000)
> > > > K8_NOP5 != K8_NOP5_ATOMIC (6666906690 != 6666666690)
> > > >
> > > > Can be reproduced by doing "ideal_nops = k8_nops" in "arch_init_ideal_nops()
> > > > and running fexit_bpf2bpf selftest.
> > > >
> > > > Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > ---
> > > >  arch/x86/net/bpf_jit_comp.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > > index 72b5a57e9e31..b35fc8023884 100644
> > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > @@ -2012,7 +2012,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> > > >                 /* remember return value in a stack for bpf prog to access */
> > > >                 emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
> > > >                 im->ip_after_call = prog;
> > > > -               emit_nops(&prog, 5);
> > > > +               memcpy(prog, ideal_nops[NOP_ATOMIC5], X86_PATCH_SIZE);
> > > > +               prog += X86_PATCH_SIZE;
> > >
> > > I'm well aware, but ideal_nops are pretty much gone already.
> > > The changes are already in the -tip tree.
> > > So I decided to reduce the conflicts for the merge window.
> > >
> > > Do you actually see the breakage or it's purely theoretical?
> > We do see it, but it's on our tree that pulls from bpf.
> > And it obviously doesn't have that "x86: Remove dynamic NOP selection" yet.
> > Thanks for the pointer, I guess I can just wait for the real merge then.
>
> If it breaks the real users we have to land the fix, but let me ask how
> come that you run with k8 cpu? k8 does other nasty things.
> Do you run with all of amd errata?
It's not amd, it's intel:

cpu family      : 6
model           : 45
model name      : Intel(R) Xeon(R) CPU E5-2689 0 @ 2.60GHz

I think I'm hitting the following from the arch/x86/kernel/alternative.c:

/*
* Due to a decoder implementation quirk, some
* specific Intel CPUs actually perform better with
* the "k8_nops" than with the SDM-recommended NOPs.
*/
if (boot_cpu_data.x86 == 6 &&
   boot_cpu_data.x86_model >= 0x0f &&
   boot_cpu_data.x86_model != 0x1c &&
   boot_cpu_data.x86_model != 0x26 &&
   boot_cpu_data.x86_model != 0x27 &&
   boot_cpu_data.x86_model < 0x30) {
ideal_nops = k8_nops;
