Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0973B6762
	for <lists+bpf@lfdr.de>; Mon, 28 Jun 2021 19:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhF1RP4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Jun 2021 13:15:56 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:54743 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232084AbhF1RP4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Jun 2021 13:15:56 -0400
Date:   Mon, 28 Jun 2021 19:13:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1624900407;
        bh=g8Q9er+HLedVUAwmx+vgjIcik4+FkDXHMkwZooRvcUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6RvxDo1Q1vTJYDNKraxw5WQeSEZGISMnc/qXR6RPDoBMsV0HuVfi7QJWFpuJ6zZ+
         H5ZWcsuU/CvBTiibAkNz+ycZlXH2WinpUtBxJ4BZ9MsVVLJZgq8zy8vTHI/QV2Zhk/
         cb/upvyeJGeCMg/q7JZ8JLhHYrTgvcvNOfcJJCWM=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org
Subject: Re: AUDIT_ARCH_ and __NR_syscall constants for seccomp filters
Message-ID: <696bf938-c9d2-4b18-9f53-b6ff27035a97@t-8ch.de>
References: <0b926f59-464d-4b67-8f32-329cf9695cf7@t-8ch.de>
 <CAHC9VhSTb75NEPZRm+Tkngv=SW8ntmSpVCrXMHHHWc2qYNZqCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSTb75NEPZRm+Tkngv=SW8ntmSpVCrXMHHHWc2qYNZqCA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Paul,

thanks for your response!

On Mo, 2021-06-28T12:59-0400, Paul Moore wrote:
> On Mon, Jun 28, 2021 at 9:25 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > Hi everyone,
> >
> > there does not seem to be a way to access the AUDIT_ARCH_ constant that matches
> > the currently visible syscall numbers (__NR_...) from the kernel uapi headers.
> 
> Looking at Linus' current tree I see the AUDIT_ARCH_* defines in
> include/uapi/linux/audit.h; looking on my system right now I see the
> defines in /usr/include/linux/audit.h.  What kernel repository and
> distribution are you using?

I am using ArchLinux and also have all these defines.

> > Questions:
> >
> > Is it really necessary to validate the arch value when syscall numbers are
> > already target-specific?
> > (If not, should this be added to the docs?)
> 
> Checking the arch/ABI value is important so that you can ensure that
> you are using the syscall number in the proper context.  For example,
> look at the access(2) syscall: it is undefined on some ABIs and can
> take either a value of 20, 21, or 33 depending on the arch/ABI.
> Unfortunately this is rather common.

But when if I am not hardcoding the syscall numbers but use the
__NR_access kernel define then I should always get the correct number for the
ABI I am compiling for (or an error if the syscall does not exist), no?

> Checking the arch/ABI value is also handy if you want to quickly
> disallow certain ABIs on a system that supports multiple ABI, e.g.
> disabling 32-bit x86 on a 64-bit x86_64 system.
> 
> > Would it make sense to expose the audit arch matching the syscall numbers in
> > the uapi headers?
> 
> Yes, which is why the existing headers do so ;)  If you don't see the
> header files I mentioned above, it may be worth checking your kernel
> source repository and your distribution's installed kernel header
> files.

I do see constants for all the possible ABIs but not one constant that always
represents the one I am currently compiling for.
The same way the syscall number defines always give me the syscall number for
the currently targeted ABI.

Thomas
