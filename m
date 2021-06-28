Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B797F3B6805
	for <lists+bpf@lfdr.de>; Mon, 28 Jun 2021 19:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhF1SBY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Jun 2021 14:01:24 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:45957 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231950AbhF1SBX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Jun 2021 14:01:23 -0400
Date:   Mon, 28 Jun 2021 19:58:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1624903137;
        bh=BFGv1JjZdr4nYKTHETTbYBJZgFqp6e0QFp9TpnN5/00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OrPb/865GPblsYe46/tJ78jk2S8h48PT5/YuUgSS8EWIZzVc1qj+gCWD7uufmzXQi
         wvMnVGnBKCmQ0DKv5/XNmopvOnKWHEJ3eJQHbmU4vAa7YCMp7r57wGkGz2TD49crFY
         y8mIesA7nl7d5H9HezSCk1DAej7slyDM3MFszr20=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org
Subject: Re: AUDIT_ARCH_ and __NR_syscall constants for seccomp filters
Message-ID: <efb74f33-6876-48ec-bb9c-87b2247bdedb@t-8ch.de>
References: <0b926f59-464d-4b67-8f32-329cf9695cf7@t-8ch.de>
 <CAHC9VhSTb75NEPZRm+Tkngv=SW8ntmSpVCrXMHHHWc2qYNZqCA@mail.gmail.com>
 <696bf938-c9d2-4b18-9f53-b6ff27035a97@t-8ch.de>
 <CAHC9VhSrki+=724CSQbDdiiMnM8oXTmFP-XFnOmq28c03x1RQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSrki+=724CSQbDdiiMnM8oXTmFP-XFnOmq28c03x1RQQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi again!

On Mo, 2021-06-28T13:34-0400, Paul Moore wrote:
> On Mon, Jun 28, 2021 at 1:13 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > On Mo, 2021-06-28T12:59-0400, Paul Moore wrote:
> > > On Mon, Jun 28, 2021 at 9:25 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > > >
> > > > Hi everyone,
> > > >
> > > > there does not seem to be a way to access the AUDIT_ARCH_ constant that matches
> > > > the currently visible syscall numbers (__NR_...) from the kernel uapi headers.
> > >
> > > Looking at Linus' current tree I see the AUDIT_ARCH_* defines in
> > > include/uapi/linux/audit.h; looking on my system right now I see the
> > > defines in /usr/include/linux/audit.h.  What kernel repository and
> > > distribution are you using?
> >
> > I am using ArchLinux and also have all these defines.
> >
> > > > Questions:
> > > >
> > > > Is it really necessary to validate the arch value when syscall numbers are
> > > > already target-specific?
> > > > (If not, should this be added to the docs?)
> > >
> > > Checking the arch/ABI value is important so that you can ensure that
> > > you are using the syscall number in the proper context.  For example,
> > > look at the access(2) syscall: it is undefined on some ABIs and can
> > > take either a value of 20, 21, or 33 depending on the arch/ABI.
> > > Unfortunately this is rather common.
> >
> > But when if I am not hardcoding the syscall numbers but use the
> > __NR_access kernel define then I should always get the correct number for the
> > ABI I am compiling for (or an error if the syscall does not exist), no?
> 
> Remember that seccomp filters are inherited across forks, so if your
> application loads an ABI specific filter and then fork()/exec()'s an
> application with a different ABI you could be in trouble.  We saw this
> some years ago when people started running containers with ABIs other
> than the native system; if the container orchestrator didn't load a
> filter that knew about these non-native ABIs Bad Things happened.

My application will not be able to spawn any new processes.
It is limited to write() and exit().
Also this is a low-level system application so it should always be compiled for
the native ABI.
So this should not be an issue.

> I'm sure you are already aware of libseccomp, but if not you may want
> to consider it for your application.  Not only does it provide a safe
> and easy way to handle multiple ABIs in a single filter, it handles
> other seccomp problem areas like build/runtime system differences in
> the syscall tables/defines as well as the oddball nature of
> direct-call and multiplexed socket related syscalls, i.e. socketcall()
> vs socket(), etc.

For a larger application this would be indeed my choice.
But for a small application like mine I don't think it is worth it.
libseccomp for example does provide a way to get the native audit arch:
`uint32_t seccomp_arch_native(void);`. It is implemented by ifdef-ing on
various compiler defines to detect the ABI compiled for.

I'd like the kernel to provide this out-of-the box, so I don't have to have the
same ifdefs in my application(s) and keep them up to date.

I found that the kernel internally already has a definition for my usecase:
SECCOMP_ARCH_NATIVE.
It is just not exported to userspace.

> > > Checking the arch/ABI value is also handy if you want to quickly
> > > disallow certain ABIs on a system that supports multiple ABI, e.g.
> > > disabling 32-bit x86 on a 64-bit x86_64 system.
> > >
> > > > Would it make sense to expose the audit arch matching the syscall numbers in
> > > > the uapi headers?
> > >
> > > Yes, which is why the existing headers do so ;)  If you don't see the
> > > header files I mentioned above, it may be worth checking your kernel
> > > source repository and your distribution's installed kernel header
> > > files.
> >
> > I do see constants for all the possible ABIs but not one constant that always
> > represents the one I am currently compiling for.
> > The same way the syscall number defines always give me the syscall number for
> > the currently targeted ABI.
> 
> I'm sorry, but I don't quite understand what you are looking for in
> the header files ... ?  It might help if you could provide a concrete
> example of what you would like to see in the header files?

I want to do something like the follwing inside my program to assemble a
seccomp filter that will be loaded before the error-prone parts of the
application will begin.

1: BPF_STMT(BPF_LD | BPF_W | BPF_ABS, syscall_arch),
2: BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SECCOMP_ARCH_NATIVE, 0, $KILL)
3: BPF_STMT(BPF_LD | BPF_W | BPF_ABS, syscall_nr),
4: BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_write, $ALLOW, $KILL),

In line 4 I can already have the kernel headers provide me the correct syscall
number for the ABI my application is compiled for.

For line 2 however I need to define AUDIT_ARCH_CURRENT on my own instead of
having a kernel header provide the correct value.

Thomas
