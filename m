Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB614AB53C
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 07:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiBGGyN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 01:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244537AbiBGGXc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 01:23:32 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC301C043181
        for <bpf@vger.kernel.org>; Sun,  6 Feb 2022 22:23:31 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 9so15504911iou.2
        for <bpf@vger.kernel.org>; Sun, 06 Feb 2022 22:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sr8K4Yndcc366sZygvs0Bamstrw9OIOV3hd79ImvXG4=;
        b=eJ+nJm25uAmKtVkUSlR/q1XmxSxZ2v3wa7HyhnHBE7YlwCZjnrqwRSiEk5x5lxiQdm
         Dj8mEF40ZXo5zca0CDk88x+HDib7hN2guLFgueF6EcOqExMC5n0VLwWSGc3wkMQ0/doc
         MSCqcPgyI6PtWpc1AICkGScY/tyi1PTv1vMC7mRSl/x8mosl25bT+bHr0OnHMB6MxGRj
         k+Hy8Lpta01rCir1nFqoOTr+bjyLjoZURHG9Vm37cuLFVlZsaxZpawxjVRfTtPtoQcdq
         z6miFX+/i3zwDQvmwCDm7B6lBFt+88z9w0dboa2NskHqDD/l+MohyT8Ui3ACn6o7iszb
         vZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sr8K4Yndcc366sZygvs0Bamstrw9OIOV3hd79ImvXG4=;
        b=kAnzKALGElorRCC1CHMVI/molZ4KufpIp3QkKiKLrX0dhT9rxHUimMQG2ecznEpsK4
         pRj/mO/T0G0gIL/gnIhtHuGLvFgHQL+s79H1NYWPKmZma6SD+13D0SVTlJcyEAnJOZgs
         3AwekzJ/FJnnVxPGQeFomxZzW3UU+eDNII4oX3Gfr5iXrgl0idgzz5vQCPk3Pe4oq7s5
         M6Zhajwfwzdu44u57qt6/6rw084k/Bnsx4qplKib+OjByI255zNhF/p8ZNLAgdbKh/8c
         DIjhvarAR5qvexz1hBSVhofm5fL9HNIF89j2zxwm9YqKXFF3kXXZJTVPDms1d++sLNqE
         mWqw==
X-Gm-Message-State: AOAM531SyeX8JcfpT2vq3uOMkGWQMeOWC+zYUdzzFxyJN0LQGZ8SBVFm
        ajm3CtZlEkGS47nbNXQRbdTo6pM8Y7ez6rmqkKYbXVYyAf0=
X-Google-Smtp-Source: ABdhPJxpfz16MrchA3RjUrwOWPTdqTliH2F61c1r2DJHZMgmQm/5vK6g2EnXCDZxLzW7CBnKzfxaGpmFfmeU3g8CYd0=
X-Received: by 2002:a5e:8406:: with SMTP id h6mr5186036ioj.144.1644215010986;
 Sun, 06 Feb 2022 22:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20220206145350.2069779-1-iii@linux.ibm.com> <CAEf4Bzb1To5+uLdRiJEJUJo4PckVDEBEtENC14Cuf-mkxrnxgA@mail.gmail.com>
 <5e4b012be25cbbb44ecb935de745e17ed5c16f28.camel@linux.ibm.com>
In-Reply-To: <5e4b012be25cbbb44ecb935de745e17ed5c16f28.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 6 Feb 2022 22:23:19 -0800
Message-ID: <CAEf4BzZfn4-dbnRcsStu+EoKD12EoKCShcoAVH9Gj0mqieBAaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Fix bpf_perf_event_data ABI breakage
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 6, 2022 at 11:57 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Sun, 2022-02-06 at 11:31 -0800, Andrii Nakryiko wrote:
> > On Sun, Feb 6, 2022 at 6:54 AM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > libbpf CI noticed that my recent changes broke bpf_perf_event_data
> > > ABI
> > > on s390 [1]. Testing shows that they introduced a similar breakage
> > > on
> > > arm64. The problem is that we are not allowed to extend
> > > user_pt_regs,
> > > since it's used by bpf_perf_event_data.
> > >
> > > This series fixes these problems by removing the new members and
> > > introducing user_pt_regs_v2 instead.
> > >
> > > [1] https://github.com/libbpf/libbpf/runs/5079938810
> > >
> > > Ilya Leoshkevich (2):
> > >   s390/bpf: Introduce user_pt_regs_v2
> > >   arm64/bpf: Introduce struct user_pt_regs_v2
> >
> > Given it is bpf_perf_event_data and thus bpf_user_pt_regs_t
> > definitions that are set in stone now, wouldn't it be better to
> > instead just change
> >
> > typedef user_pt_regs bpf_user_pt_regs_t; (s390x)
> > typedef struct user_pt_regs bpf_user_pt_regs_t; (arm64)
> >
> > to just define that fixed layout instead of reusing user_ptr_regs?
> >
> > This whole v2 business looks really ugly.
>
> Wouldn't it break compilation of code like this?
>
>     bpf_perf_event_data data;
>     user_pt_regs *regs = &data.regs;

why would it break? user_pt_regs gained extra fields at the end, so
whoever works with the assumption of an old definition of user_pt_regs
*through pointer* should be totally fine. The problem with
bpf_perf_event_data is that user_pt_regs are embedded in the struct
directly, so adding anything to it changes bpf_perf_event_data layout.

I, of course, can't know if this breaks any other use case (including
ones you mentioned below), but using user_pt_regs_v2 will probably not
work with CO-RE, because older kernels won't have such type defined
(and thus relocations will fail).

I'm not sure the origins of the need for user_pt_regs (as opposed to
using pt_regs directly, like x86-64 does), but with CO-RE and
vmlinux.h it would be more reliable and straightforward to just stick
to kernel-internal struct pt_regs everywhere. And for non-CO-RE macros
maybe just using an offset within struct pt_regs (i.e.,
offsetofend(gprs)) would do it?

>
> Additionaly, after this I'm no longer sure I haven't missed any other
> places where user_pt_regs might be used. For example, arm64 seems to be
> using it not only for BPF, but also for ptrace?
>
> static int gpr_get(struct task_struct *target,
>                    const struct user_regset *regset,
>                    struct membuf to)
> {
>         struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
>         return membuf_write(&to, uregs, sizeof(*uregs));
> }
>
> and then in e.g. gdb:
>
> static void
> aarch64_fill_gregset (struct regcache *regcache, void *buf)
> {
>   struct user_pt_regs *regset = (struct user_pt_regs *) buf;
>   ...
>
> I'm also not a big fan of the _v2 solution, but it looked the safest
> to me. At least for s390, a viable alternative that Vasily proposed
> would be to go ahead with replacing args[1] with orig_gpr2 and then
> also backporting the patch, so that the new libbpf would still work on
> the old stable kernels. But this won't work for arm64.
