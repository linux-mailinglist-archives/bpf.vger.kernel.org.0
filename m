Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452291EBBF5
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 14:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgFBMoj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 08:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMoj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 08:44:39 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAE7C061A0E;
        Tue,  2 Jun 2020 05:44:34 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id A4773E8154A;
        Tue,  2 Jun 2020 14:44:31 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 4D379160AC6; Tue,  2 Jun 2020 14:44:31 +0200 (CEST)
Date:   Tue, 2 Jun 2020 14:44:31 +0200
From:   Lennart Poettering <lennart@poettering.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: new seccomp mode aims to improve performance
Message-ID: <20200602124431.GA123838@gardel-login>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook>
 <202005291043.A63D910A8@keescook>
 <20200601101137.GA121847@gardel-login>
 <202006011116.3F7109A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006011116.3F7109A@keescook>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mo, 01.06.20 11:21, Kees Cook (keescook@chromium.org) wrote:

> > > # grep SystemCall /lib/systemd/system/systemd-resolved.service
> > > SystemCallArchitectures=native
> > > SystemCallErrorNumber=EPERM
> > > SystemCallFilter=@system-service
> > >
> > > I'd like to better understand what they're doing, but haven't had time
> > > to dig in. (The systemd devel mailing list requires subscription, so
> > > I've directly CCed some systemd folks that have touched seccomp there
> > > recently. Hi! The starts of this thread is here[4].)
> >
> > Hmm, so on x86-64 we try to install our seccomp filters three times:
> > for the x86-64 syscall ABI, for the i386 syscall ABI and for the x32
> > syscall ABI. Not all of the filters we apply work on all ABIs though,
> > because syscalls are available on some but not others, or cannot
> > sensibly be matched on some (because of socketcall, ipc and such
> > multiplexed syscalls).
> >
> > [...]
>
> Thanks for the details on this! That helps me understand what's
> happening much better. :)
>
> > An easy improvement is probably if libseccomp would now start refusing
> > to install x32 seccomp filters altogether now that x32 is entirely
> > dead? Or are the entrypoints for x32 syscalls still available in the
> > kernel? How could userspace figure out if they are available? If
> > libseccomp doesn't want to add code for that, we probably could have
> > that in systemd itself too...
>
> Would it make sense to provide a systemd setting for services to declare
> "no compat" or "no x32" (I'm not sure what to call this mode more
> generically, "no 32-bit allocation ABI"?) Then you can just install
> a single merged filter for all the native syscalls that starts with
> "if not native, reject"?

We have that actually, it's this line you pasted above:

        SystemCallArchitectures=native

It means: block all syscall ABIs but the native one for all processes
of this service.

We currently use that setting only to synthesize an explicit seccomp
filter masking the other ABIs wholesale. We do not use it to suppress
generation of other, unrelated seccomp filters for that
arch. i.e. which means you might end up with one filter blocking x32
wholesale, but then another unrelated option might install a filter
blocking some specific syscall with some specific arguments, but still
gets installed for x86-64 *and* i386 *and* x32. I guess we could
relatively easily tweak that and suppress the latter. If we did, then
on all services that set SystemCallArchitectures=native on x86-64 the
number of installed seccomp filters should become a third.

> (Or better yet: make the default for filtering be "native only", and
> let services opt into other ABIs?)

That sounds like it would make people quite unhappy no? given that on
a systemd system anything that runs in userspace is ultimately part of
a service managed by systemd, if we'd default to "no native ABIs" this
would translate to "yeah, we entirely disable the i386 ABI for the
entire system unless you reconfigure it and/or opt-out your old i386
services".

Hence, on x86-64, I figure just masking i386 entirely is a bit too
drastic a compat breakage for us, no? Masking x32 otoh sounds like a
safe default to do without breaking too much compat given that x32 is
on its way out.

Lennart

--
Lennart Poettering, Berlin
