Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C833B70DB
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 12:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhF2Kn1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 06:43:27 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:44609 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233111AbhF2KnZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 06:43:25 -0400
Date:   Tue, 29 Jun 2021 12:40:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1624963257;
        bh=xAiXp/C06ag7DbcOfG/lfgCJixhQy0QwXW4k57bDNDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rWltZpvKlQXIQKIoBTYCd3fOzZ0U+WFEP81IdMSzhlGKCH/jsilJuGn19H1YxY8Q4
         HPt3cOzbmUUu0ehSQJBmqeCGu5deAmVHEJu+Y7rvkdccijaHGmgL6HW3T2zIQ8rh2r
         8AK/FP6ufXImwp/8s+dEaILVKypc2247kIQp4RxU=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org
Subject: Re: AUDIT_ARCH_ and __NR_syscall constants for seccomp filters
Message-ID: <60ba7e11-36af-4b24-9132-c5214f32bdad@t-8ch.de>
References: <0b926f59-464d-4b67-8f32-329cf9695cf7@t-8ch.de>
 <CAHC9VhSTb75NEPZRm+Tkngv=SW8ntmSpVCrXMHHHWc2qYNZqCA@mail.gmail.com>
 <696bf938-c9d2-4b18-9f53-b6ff27035a97@t-8ch.de>
 <CAHC9VhSrki+=724CSQbDdiiMnM8oXTmFP-XFnOmq28c03x1RQQ@mail.gmail.com>
 <efb74f33-6876-48ec-bb9c-87b2247bdedb@t-8ch.de>
 <CAHC9VhTKOZepgVwpc=rh65-ziMTvSvgtCjP6S9+SQ=YDqg-vsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTKOZepgVwpc=rh65-ziMTvSvgtCjP6S9+SQ=YDqg-vsA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mo, 2021-06-28T18:43-0400, Paul Moore wrote:
> On Mon, Jun 28, 2021 at 1:58 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > Hi again!
> 
> !!! :)

Indeed, hi!

> > On Mo, 2021-06-28T13:34-0400, Paul Moore wrote:
> > > On Mon, Jun 28, 2021 at 1:13 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > > > On Mo, 2021-06-28T12:59-0400, Paul Moore wrote:
> > > > > On Mon, Jun 28, 2021 at 9:25 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> 
> ...
> 
> > > Remember that seccomp filters are inherited across forks, so if your
> > > application loads an ABI specific filter and then fork()/exec()'s an
> > > application with a different ABI you could be in trouble.  We saw this
> > > some years ago when people started running containers with ABIs other
> > > than the native system; if the container orchestrator didn't load a
> > > filter that knew about these non-native ABIs Bad Things happened.
> >
> > My application will not be able to spawn any new processes.
> > It is limited to write() and exit().
> > Also this is a low-level system application so it should always be compiled for
> > the native ABI.
> > So this should not be an issue.
> >
> > > I'm sure you are already aware of libseccomp, but if not you may want
> > > to consider it for your application.  Not only does it provide a safe
> > > and easy way to handle multiple ABIs in a single filter, it handles
> > > other seccomp problem areas like build/runtime system differences in
> > > the syscall tables/defines as well as the oddball nature of
> > > direct-call and multiplexed socket related syscalls, i.e. socketcall()
> > > vs socket(), etc.
> >
> > For a larger application this would be indeed my choice.
> > But for a small application like mine I don't think it is worth it.
> > libseccomp for example does provide a way to get the native audit arch:
> > `uint32_t seccomp_arch_native(void);`. It is implemented by ifdef-ing on
> > various compiler defines to detect the ABI compiled for.
> >
> > I'd like the kernel to provide this out-of-the box, so I don't have to have the
> > same ifdefs in my application(s) and keep them up to date.
> >
> > I found that the kernel internally already has a definition for my usecase:
> > SECCOMP_ARCH_NATIVE.
> > It is just not exported to userspace.
> 
> I'm not sure that keeping the ifdefs up to date is going to be that
> hard, and honestly that is the right place to do it IMHO.  The kernel
> can support any number of ABIs, but in the narrow use case you are
> describing in this thread you only care about the ABI of your own
> application; it doesn't sound like you really care about the kernel's
> ABI, but rather your application's ABI.

Ok, fair enough.

My goal was to keep the amount of support code in my application small.
Out of 250 lines of code
100 are actual business logic,
50 are the current seccomp code
and the ifdefs would be another 50 (looking at those in libseccomp).

Having a #define provided by the kernel headers, which already cares about
my application ABI when providing the syscall numbers, would have sidestepped
all clutter and maintenance issues neatly.

I'll add my own logic then.

To get back to my other question:

Is there any chance a single given process can have multiple different ABIs
active at the same time?
Without using special syscalls to switch between them.

Because if that is not possible I can skip the checks for the arch completely
because the filter is constructed at compile time for the specific ABI
targetted and all funky syscalls are forbidden anyways.

> > > I'm sorry, but I don't quite understand what you are looking for in
> > > the header files ... ?  It might help if you could provide a concrete
> > > example of what you would like to see in the header files?
> >
> > I want to do something like the follwing inside my program to assemble a
> > seccomp filter that will be loaded before the error-prone parts of the
> > application will begin.
> >
> > 1: BPF_STMT(BPF_LD | BPF_W | BPF_ABS, syscall_arch),
> > 2: BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SECCOMP_ARCH_NATIVE, 0, $KILL)
> > 3: BPF_STMT(BPF_LD | BPF_W | BPF_ABS, syscall_nr),
> > 4: BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_write, $ALLOW, $KILL),
> >
> > In line 4 I can already have the kernel headers provide me the correct syscall
> > number for the ABI my application is compiled for.
> >
> > For line 2 however I need to define AUDIT_ARCH_CURRENT on my own instead of
> > having a kernel header provide the correct value.

PS: I know that this seems to be a lot of discussion for fairly little gain in
this specific case, but I'd like to use seccomp filters in the future more and
am trying to find the most unobtrusive way to add them to applications for each
given usecase.
(For any larger applications that will certainly include libseccomp, but that
feels overkill for very specific, zero-runtime-dependency utilities)

Thanks again!
Thomas
