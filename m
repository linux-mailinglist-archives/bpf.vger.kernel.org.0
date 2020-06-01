Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB391EA1AE
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 12:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgFAKRI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 06:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFAKRH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 06:17:07 -0400
X-Greylist: delayed 326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 Jun 2020 03:17:07 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBDFC061A0E;
        Mon,  1 Jun 2020 03:17:07 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id A50DCE811D6;
        Mon,  1 Jun 2020 12:11:38 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id E1C2F160AC6; Mon,  1 Jun 2020 12:11:37 +0200 (CEST)
Date:   Mon, 1 Jun 2020 12:11:37 +0200
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
Message-ID: <20200601101137.GA121847@gardel-login>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook>
 <202005291043.A63D910A8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005291043.A63D910A8@keescook>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fr, 29.05.20 12:27, Kees Cook (keescook@chromium.org) wrote:

> # grep ^Seccomp_filters /proc/$(pidof systemd-resolved)/status
> Seccomp_filters:        32
>
> # grep SystemCall /lib/systemd/system/systemd-resolved.service
> SystemCallArchitectures=native
> SystemCallErrorNumber=EPERM
> SystemCallFilter=@system-service
>
> I'd like to better understand what they're doing, but haven't had time
> to dig in. (The systemd devel mailing list requires subscription, so
> I've directly CCed some systemd folks that have touched seccomp there
> recently. Hi! The starts of this thread is here[4].)

Hmm, so on x86-64 we try to install our seccomp filters three times:
for the x86-64 syscall ABI, for the i386 syscall ABI and for the x32
syscall ABI. Not all of the filters we apply work on all ABIs though,
because syscalls are available on some but not others, or cannot
sensibly be matched on some (because of socketcall, ipc and such
multiplexed syscalls).

When we fist added support for seccomp filters to systemd we compiled
everything into a single filter, and let libseccomp apply it to
different archs. But that didn't work out, since libseccomp doesn't
tell use when it manages to apply a filter and when not, i.e. to which
arch it worked and to which arch it didn't. And since we have some
whitelist and some blacklist filters the internal fallback logic of
libsecccomp doesn't work for us either, since you never know what you
end up with. So we ended up breaking the different settings up into
individual filters, and apply them individually and separately for
each arch, so that we know exactly what we managed to install and what
not, and what we can then know will properly filter and can check in
our test suite.

Keeping the filters separate made things a lot easier and simpler to
debug, and our log output and testing became much less of a black
box. We know exactly what worked and what didn't, and our test
validate each filter.

For systemd-resolved we apply a bunch more filters than just those
that are result of SystemCallFilter= and SystemCallArchitectures=
(SystemCallFilter= itself synthesizes one filter per syscall ABI).

1. RestrictSUIDSGID= generates a seccomp filter to generated suid/sgid
   binaries, i.e. filters chmod() and related calls and their
   arguments

2. LockPersonality= blocks personality() for most arguments

3. MemoryDenyWriteExecute= blocks mmap() and similar calls if the
   selected map has X and W set at the same time

4. RestrictRealtime= blocks sched_setscheulder() for most parameters

5. RestrictAddressFamilies= blocks socket() and related calls for
   various address families

6. ProtectKernelLogs= blocks the syslog() syscall for most parameters

7. ProtectKernelTunables= blocks the old _sysctl() syscall among some
   other things

8. RestrictNamespaces= blocks various unshare() and clone() bits

So yeah, if one turns on many of these options in services (and we
generally turn on everything we can for the services we ship) and then
multiply that by the archs you end up with quite a bunch.

If we wanted to optimize that in userspace, then libseccomp would have
to be improved quite substantially to let us know exactly what works
and what doesn't, and to have sane fallback both when building
whitelists and blacklists.

An easy improvement is probably if libseccomp would now start refusing
to install x32 seccomp filters altogether now that x32 is entirely
dead? Or are the entrypoints for x32 syscalls still available in the
kernel? How could userspace figure out if they are available? If
libseccomp doesn't want to add code for that, we probably could have
that in systemd itself too...

Lennart

--
Lennart Poettering, Berlin
