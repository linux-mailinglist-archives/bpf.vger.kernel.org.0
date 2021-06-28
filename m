Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08773B67B9
	for <lists+bpf@lfdr.de>; Mon, 28 Jun 2021 19:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhF1Rg7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Jun 2021 13:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhF1Rg7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Jun 2021 13:36:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE79C061574
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 10:34:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s15so27037986edt.13
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kEAJ6KsZJw1puT1jMPblXJZXTzXVzkngKqIZOq+rtkM=;
        b=R2CfX4X/4lYBnNyh/Zcdl5j+zoHNMtSFzyIRfcUbUgwuTncuSNBrS83CW6/zZel0eu
         UtTBv6YMztwpKEHCua9CGKsnSIMotMpZa+5q2XNjVZQPOfCZtZkSC6Dkh8dOcoojdq1z
         6A/PhhgMlYr/3eO0KxVyyIinPjU4N3HygXRj2wRaLnLJtD8ID4cxEVtmJQSUjrBe8Xm+
         1gX2KfYTPxAyi7TNxFPyz4g/Y75XTc+tknr9s3wMvMILSIe1+KOBv9pzwM8PVxKZhcB2
         dEI8ZJeapZXZC3TUJQ+P9UOn/cyip+dPIkHr6pnNWpPTirfODFBJyRBq5o+X3uO7jK0I
         5eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kEAJ6KsZJw1puT1jMPblXJZXTzXVzkngKqIZOq+rtkM=;
        b=oalXetpxa2hp5QUdEJZETONpJpSqgqMj0/FhEAcZO7sTRqGVYzJGO6aghRYou94T9I
         0JY+wUG6mtcUyszrtxhCVadBRxjaSp6S1gHg+hcTLkeNLUIhBpvHIxaND/o3fD7bCxpU
         TyKsKxTeFuOQFMIrq2ms+55C72qZOQPGvSoVT5DpKO44VK9zs+22yomZBgytwhN0jFnl
         5KWv9Qwj2Fq9h5U8XoXpMn8MIm45/EadnqoU5JeZP5nk8n/dl/Ut4go7NgMcMO9mx0zH
         qJ2zkKPtAEKX6eBMeS8YPxlcBzzjm4t10wRhuBUG4E69oudXCR4c4xCp0u3oZqXo6eTf
         KvZA==
X-Gm-Message-State: AOAM530wdZrUPU+9tVwnU/hheZJVrEgx/yQ3v3rpYeSj1e8uhoqPcb22
        EoKeyaNIJWC+DcScgO+Xv/t5MdHpPG30WuX3mhFv
X-Google-Smtp-Source: ABdhPJxYtdKNQmB50YsT/24qNwNE0W1Szb9yVtsfwRafME7wghQsUuuXBwob8Mt1UUG1rUZDwD+ylWNG+5DmxZjDlKQ=
X-Received: by 2002:aa7:d592:: with SMTP id r18mr44230edq.269.1624901672066;
 Mon, 28 Jun 2021 10:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <0b926f59-464d-4b67-8f32-329cf9695cf7@t-8ch.de>
 <CAHC9VhSTb75NEPZRm+Tkngv=SW8ntmSpVCrXMHHHWc2qYNZqCA@mail.gmail.com> <696bf938-c9d2-4b18-9f53-b6ff27035a97@t-8ch.de>
In-Reply-To: <696bf938-c9d2-4b18-9f53-b6ff27035a97@t-8ch.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Jun 2021 13:34:20 -0400
Message-ID: <CAHC9VhSrki+=724CSQbDdiiMnM8oXTmFP-XFnOmq28c03x1RQQ@mail.gmail.com>
Subject: Re: AUDIT_ARCH_ and __NR_syscall constants for seccomp filters
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 28, 2021 at 1:13 PM Thomas Wei=C3=9Fschuh <linux@weissschuh.net=
> wrote:
>
> Hi Paul,
>
> thanks for your response!

Hi :)

> On Mo, 2021-06-28T12:59-0400, Paul Moore wrote:
> > On Mon, Jun 28, 2021 at 9:25 AM Thomas Wei=C3=9Fschuh <linux@weissschuh=
.net> wrote:
> > >
> > > Hi everyone,
> > >
> > > there does not seem to be a way to access the AUDIT_ARCH_ constant th=
at matches
> > > the currently visible syscall numbers (__NR_...) from the kernel uapi=
 headers.
> >
> > Looking at Linus' current tree I see the AUDIT_ARCH_* defines in
> > include/uapi/linux/audit.h; looking on my system right now I see the
> > defines in /usr/include/linux/audit.h.  What kernel repository and
> > distribution are you using?
>
> I am using ArchLinux and also have all these defines.
>
> > > Questions:
> > >
> > > Is it really necessary to validate the arch value when syscall number=
s are
> > > already target-specific?
> > > (If not, should this be added to the docs?)
> >
> > Checking the arch/ABI value is important so that you can ensure that
> > you are using the syscall number in the proper context.  For example,
> > look at the access(2) syscall: it is undefined on some ABIs and can
> > take either a value of 20, 21, or 33 depending on the arch/ABI.
> > Unfortunately this is rather common.
>
> But when if I am not hardcoding the syscall numbers but use the
> __NR_access kernel define then I should always get the correct number for=
 the
> ABI I am compiling for (or an error if the syscall does not exist), no?

Remember that seccomp filters are inherited across forks, so if your
application loads an ABI specific filter and then fork()/exec()'s an
application with a different ABI you could be in trouble.  We saw this
some years ago when people started running containers with ABIs other
than the native system; if the container orchestrator didn't load a
filter that knew about these non-native ABIs Bad Things happened.

I'm sure you are already aware of libseccomp, but if not you may want
to consider it for your application.  Not only does it provide a safe
and easy way to handle multiple ABIs in a single filter, it handles
other seccomp problem areas like build/runtime system differences in
the syscall tables/defines as well as the oddball nature of
direct-call and multiplexed socket related syscalls, i.e. socketcall()
vs socket(), etc.

> > Checking the arch/ABI value is also handy if you want to quickly
> > disallow certain ABIs on a system that supports multiple ABI, e.g.
> > disabling 32-bit x86 on a 64-bit x86_64 system.
> >
> > > Would it make sense to expose the audit arch matching the syscall num=
bers in
> > > the uapi headers?
> >
> > Yes, which is why the existing headers do so ;)  If you don't see the
> > header files I mentioned above, it may be worth checking your kernel
> > source repository and your distribution's installed kernel header
> > files.
>
> I do see constants for all the possible ABIs but not one constant that al=
ways
> represents the one I am currently compiling for.
> The same way the syscall number defines always give me the syscall number=
 for
> the currently targeted ABI.

I'm sorry, but I don't quite understand what you are looking for in
the header files ... ?  It might help if you could provide a concrete
example of what you would like to see in the header files?

--=20
paul moore
www.paul-moore.com
