Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7710C573DD3
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 22:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiGMUak (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 16:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGMUaj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 16:30:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBC12B254
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 13:30:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x91so15604949ede.1
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 13:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dn/BrfVNFEHvx8Xqi8U1rvwOpkxegwHfZLREu4Ek3F0=;
        b=VyGnqegdQyfCwrXO/WyJl3TLi5jvDEqGQIDSGKc31Zr93x50J22qjXqtjuYki8Rjcq
         9kgWU68yhMxSK4wopqqRmu0b1OOv1R2hJZZlvzbNlzDY9jR56S9mq5GS9m/BvWdUDGnk
         obl9TRbN4eEV2smz8udfBdSJJWSc12z2JWo3VNRse+/0MRcMcYheaArnexQTeTsrzBo1
         BOO9dUMARv8iLINtnH4ndoYSe4bNo89vgJ21YGsDmnd4bSJIv5I33mBl0H0emEtUD8fS
         SEF9p7foQj8bokbj0IQNKB3fR1l40N6vHjK+S8QcSActZhRI3+YqVm3DsSk3gBK4Kowb
         RzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dn/BrfVNFEHvx8Xqi8U1rvwOpkxegwHfZLREu4Ek3F0=;
        b=CFDdnpzwj51Wzc/8UA6cdxLDBgkc2Wik3yvyulRePw+y++Gqgx2Qp0PX+R5d30MgwK
         4wQQfzWpm+BBn60EDeYKtnnIZDWRsgKzspi5cxE6/5ds4pCDWQZj6fS3HB46iGwNoSzd
         D+edqE6Te6lqadLrW9kskg2sMyYRr3fZMBmze7KfHADYaxRR1ZCG1m9VN6/1Av6umWik
         lfptEJR6C4H1R8PhzNmBK6JvfQY7IYj7ubTdg7KDto6Eo5oNygP3/syCrtndRCssbXdW
         tSWPqdGHIoD8o/tL8akq+BGgfeiQMJlOTzeXr5QdfGp/CjwrmyZsD7k7fBJ8iEOfUEBu
         0cAg==
X-Gm-Message-State: AJIora/FgSCW9l6/P8daL/iaAY5XlDd7Wokx/ck0+JM40foXnWYnviMS
        xgRkIYKX8WPOS8xbxT4DegNKHJJ6F1hF5zhvaRk=
X-Google-Smtp-Source: AGRyM1tMlILUenSti6hS3OE7+MT0c2BZb5MxbZ1kQmkHAIkn4RS7iqOo+4cHAPZT67LgumZUnxH414V5GBZWAmA2kD8=
X-Received: by 2002:a05:6402:1c01:b0:43a:f714:bcbe with SMTP id
 ck1-20020a0564021c0100b0043af714bcbemr7631099edb.14.1657744236574; Wed, 13
 Jul 2022 13:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220713015304.3375777-1-andrii@kernel.org> <20220713015304.3375777-6-andrii@kernel.org>
 <Ys7y5vCoSgiMW/p8@google.com> <CAEf4BzZsEcz+NroDFh+sEu_4wrgsJYPMjhuZS8FBuzkXC77jcg@mail.gmail.com>
 <CAKH8qBvu1OEKkyt2joBO+DQDf0d=y-C8exa=Z3rbfQN2vymoGw@mail.gmail.com>
In-Reply-To: <CAKH8qBvu1OEKkyt2joBO+DQDf0d=y-C8exa=Z3rbfQN2vymoGw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 13:30:25 -0700
Message-ID: <CAEf4BzaGBv8O7r8Vmx5xADSn+nM9rZj80PjAKAWqHCot=42a1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: use BPF_KSYSCALL and
 SEC("ksyscall") in selftests
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Wed, Jul 13, 2022 at 11:57 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Wed, Jul 13, 2022 at 10:57 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jul 13, 2022 at 9:29 AM <sdf@google.com> wrote:
> > >
> > > On 07/12, Andrii Nakryiko wrote:
> > > > Convert few selftest that used plain SEC("kprobe") with arch-specific
> > > > syscall wrapper prefix to ksyscall/kretsyscall and corresponding
> > > > BPF_KSYSCALL macro. test_probe_user.c is especially benefiting from this
> > > > simplification.
> > >
> > > That looks super nice! I'm assuming the goal is probably
> >
> > Thanks!
> >
> > > to get rid of that SYS_PREFIX everywhere eventually? And have a simple
> > > test that exercises fentry/etc parsing?
> >
> > All the other uses of SYS_PREFIX in selftests right now are
> > fentry/fexit. If the consensus is that this sort of higher-level
> > wrapper around fentry/fexit specifically for syscalls is useful, it's
> > not a lot of work to add something like SEC("fsyscall") and
> > SEC("fretsyscall") with the same approach.
> >
> > One possible argument against this (and I need to double check my
> > assumptions first), is that with SYSCALL_WRAPPER used (which is true
> > for "major" platforms like x86_64), fentry doesn't provide much
> > benefit because __<arch>_sys_<syscall>() function will have only one
> > typed argument - struct pt_regs, and so we'll have to use
> > BPF_CORE_READ() to fetch actual arguments, at which point BPF verifier
> > will lose track of type information. So it's just a slightly more
> > performant (in terms of invocation overhead) kprobe at that point, but
> > with no added benefit of BTF types for input arguments.
> >
> > But curious to hear what others think about this.
>
> What would be nice (but not sure if possible, I haven't looked
> closely), if these same ksyscall sections would pick the best
> underlying implementation: if fentry is available -> attach to fentry,
> if not -> fallback to kprobe (and do all this __<prefix>_sys vs __sys
> dance behind the scenes). Any reasons the users should care if it's
> really a kprobe or an fentry?

It's technically possible to choose kprobe vs fentry, but I'm not
comfortable with that level of autonomy for libbpf. There might be
subtle differences between kprobes and fentry (and I did run into some
limitations with fentry due to extra BTF information that verifier
enforces, while I need to only get raw integer value of some pointer;
had to work around that in retsnoop, for example), so I generally
follow the philosophy that user needs to be explicit about what they
want, and libbpf shouldn't try to guess (which differs from BCC's
approach in a number of areas and I'm pretty pleased how that turns
out for libbpf and its users in general).

So if we do this shim for fentry/fexit, I think it should be explicit
SEC("fsyscall/fretsyscall") or something along those lines.

>
>
>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >   .../selftests/bpf/progs/bpf_syscall_macro.c   |  6 ++---
> > > >   .../selftests/bpf/progs/test_attach_probe.c   | 15 +++++------
> > > >   .../selftests/bpf/progs/test_probe_user.c     | 27 +++++--------------
> > > >   3 files changed, 16 insertions(+), 32 deletions(-)
> > >
> >
> > [...]
