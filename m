Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341E8573EAD
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 23:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiGMVRU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 17:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbiGMVRS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 17:17:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC933432
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 14:17:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id e16so68039pfm.11
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 14:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cxiF97lcLesedUnT8XHc/rh32glqy1fpJciYvCo46M0=;
        b=JVAGINNqviqO213XBny/jtOZoVvfXYLbDJKO1T1ZSteiSkDG6w4bXWnRCNqgVku3Vp
         0ADjl49ALD2ORWTyB9vKn3NPg5FtHrOICCM3ggwDGSVCJ2iO4pzh7N6dUHOk0E+OLaxW
         lHMO4pdQhqep2WX/65ABzKBpREgcJfmA0H0CdjI3aaM9wEihGelyeWjwLQxdvWOqzSl9
         mAiTaTpgunuoKZ5iKTkhFU+1ODptYTrnD/lGNmkO89yyI+u4TwkRW2oSXTVfjts6/9Bw
         tZ2cipjrn4UHIwiPA9A9eYF/IFGDd0lLWwjHjI3ulhIjmuVdZdxgQG6/v5UcaFyri2x1
         gDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cxiF97lcLesedUnT8XHc/rh32glqy1fpJciYvCo46M0=;
        b=tQ13e3oMmQEwfpvt5C2xMR6d+IWdk8WhuDBxVAZ+bA2BlYRUSlcr3zD9l1GLNzNZLA
         Uhu0Kc/bGil79ucPmL967r/IN8MwmxMb6gxUxKjb+DkOewtnEQhQPYSjSDy28bNDQfDE
         KAxOo+DAx6Po3+bfmCdPsoAQwxQKKFlQNJTw+LW1nYMjoDfDC31ioI/7yQ/ue/7MV3tx
         IBw8kWkKfoaJRSv7e75/8O05gLzEok7jouiqtWN9UFOE1n9Hsyqnwd2mIX7i+Gjo1T9h
         PB7gaGZ6tsvvf8lMKfx1/CAEcZ5ehRNkdaM2aTpAvtu7a0Ydjj8AMKjAz5hs61a93UOi
         wuKQ==
X-Gm-Message-State: AJIora/FPtQt55UGdsHC1iWGWQ1NrlooF9pB3CsTT+O9z1NZuFM87kII
        zL9CWpuXXhdkwT6tQfhxU4e4s6KLdmqgsHR4TvNnUw==
X-Google-Smtp-Source: AGRyM1usD4ASq97vb6SWHKdwgt8vDcRlIDd9LMYcc1H8cvM/+NiCVu89u8OX59rXvMdx1Ny+iqkdfkpmDHfmFo/U5J4=
X-Received: by 2002:a65:4c0b:0:b0:415:d3a4:44d1 with SMTP id
 u11-20020a654c0b000000b00415d3a444d1mr4552456pgq.191.1657747033437; Wed, 13
 Jul 2022 14:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220713015304.3375777-1-andrii@kernel.org> <20220713015304.3375777-6-andrii@kernel.org>
 <Ys7y5vCoSgiMW/p8@google.com> <CAEf4BzZsEcz+NroDFh+sEu_4wrgsJYPMjhuZS8FBuzkXC77jcg@mail.gmail.com>
 <CAKH8qBvu1OEKkyt2joBO+DQDf0d=y-C8exa=Z3rbfQN2vymoGw@mail.gmail.com> <CAEf4BzaGBv8O7r8Vmx5xADSn+nM9rZj80PjAKAWqHCot=42a1A@mail.gmail.com>
In-Reply-To: <CAEf4BzaGBv8O7r8Vmx5xADSn+nM9rZj80PjAKAWqHCot=42a1A@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 13 Jul 2022 14:17:02 -0700
Message-ID: <CAKH8qBu=34J9nqeX+tZxq7rM_D5+FLpPnmkehYUpx1CtC0-Jcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: use BPF_KSYSCALL and
 SEC("ksyscall") in selftests
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 1:30 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jul 13, 2022 at 11:57 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Wed, Jul 13, 2022 at 10:57 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Jul 13, 2022 at 9:29 AM <sdf@google.com> wrote:
> > > >
> > > > On 07/12, Andrii Nakryiko wrote:
> > > > > Convert few selftest that used plain SEC("kprobe") with arch-specific
> > > > > syscall wrapper prefix to ksyscall/kretsyscall and corresponding
> > > > > BPF_KSYSCALL macro. test_probe_user.c is especially benefiting from this
> > > > > simplification.
> > > >
> > > > That looks super nice! I'm assuming the goal is probably
> > >
> > > Thanks!
> > >
> > > > to get rid of that SYS_PREFIX everywhere eventually? And have a simple
> > > > test that exercises fentry/etc parsing?
> > >
> > > All the other uses of SYS_PREFIX in selftests right now are
> > > fentry/fexit. If the consensus is that this sort of higher-level
> > > wrapper around fentry/fexit specifically for syscalls is useful, it's
> > > not a lot of work to add something like SEC("fsyscall") and
> > > SEC("fretsyscall") with the same approach.
> > >
> > > One possible argument against this (and I need to double check my
> > > assumptions first), is that with SYSCALL_WRAPPER used (which is true
> > > for "major" platforms like x86_64), fentry doesn't provide much
> > > benefit because __<arch>_sys_<syscall>() function will have only one
> > > typed argument - struct pt_regs, and so we'll have to use
> > > BPF_CORE_READ() to fetch actual arguments, at which point BPF verifier
> > > will lose track of type information. So it's just a slightly more
> > > performant (in terms of invocation overhead) kprobe at that point, but
> > > with no added benefit of BTF types for input arguments.
> > >
> > > But curious to hear what others think about this.
> >
> > What would be nice (but not sure if possible, I haven't looked
> > closely), if these same ksyscall sections would pick the best
> > underlying implementation: if fentry is available -> attach to fentry,
> > if not -> fallback to kprobe (and do all this __<prefix>_sys vs __sys
> > dance behind the scenes). Any reasons the users should care if it's
> > really a kprobe or an fentry?
>
> It's technically possible to choose kprobe vs fentry, but I'm not
> comfortable with that level of autonomy for libbpf. There might be
> subtle differences between kprobes and fentry (and I did run into some
> limitations with fentry due to extra BTF information that verifier
> enforces, while I need to only get raw integer value of some pointer;
> had to work around that in retsnoop, for example), so I generally
> follow the philosophy that user needs to be explicit about what they
> want, and libbpf shouldn't try to guess (which differs from BCC's
> approach in a number of areas and I'm pretty pleased how that turns
> out for libbpf and its users in general).
>
> So if we do this shim for fentry/fexit, I think it should be explicit
> SEC("fsyscall/fretsyscall") or something along those lines.

In this case yeah, if there are user-visible differences, doing a
separate fsyscall is better.
(removing SYS_PREFIX seems like a good goal)
