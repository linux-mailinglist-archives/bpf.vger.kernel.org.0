Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A641EA3F2
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgFAMcy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 08:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgFAMcy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 08:32:54 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB277C03E97C
        for <bpf@vger.kernel.org>; Mon,  1 Jun 2020 05:32:53 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c35so7129631edf.5
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2020 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JFFNLOgWOQJBz5UEH8dQzylS+aEDurKASh3+4QoADFc=;
        b=uKMDzRs/VVcFPXAGbbC1jyYR59I0Q3Tiu1HVWgT7S2tDGVM4XQ/Osrd9aLhOOfbgA5
         dhF53adzeqsIwoPgGcay1VzT2ZlEQIs0OVW2HnkygkSwFBvg6yBpFPt90/ShBIiQ7By6
         SAr8r9nOKqM+UKqm7Jmpash/jNNptkhVBuCuA18zdgKWEACPJyXy9KdyopaGPzHahwZP
         9vREuBVhi6UVpDP4482kr+IGrQOuUJ5UaT3jBW+vZCBzyPdMUXoIiKkEX/1FddKGsy0C
         +rt1L5EcRusr5r7OhTBk8inNULxEeeYILryl3/vh4/OCV9RkZ2EUHo6CgjnH9FFH5RcD
         bLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JFFNLOgWOQJBz5UEH8dQzylS+aEDurKASh3+4QoADFc=;
        b=e0wjH6/AYn62GG3zYa988IG/FjYaL+VbgnmjRTHV4SHB/QP9x1bOjC3cjYFUvVgJbA
         FYSl9TxtoxixJjB75cOK87xaQQ8S9Y8kiDyJr8hiIh+kk0y1ZVUUDwymap0p180OCylk
         G6WCKNVk59vrTW28oVrYwCg5GUhcx2S2Xnq5+MXipNPYvtYz5jq5xL7TdXOiCpQqQajI
         bFqZIVPNR+oxIiO/qudA47biwYhOnmlcpaKKu5h6TNDS43Ju2MPWKoCITidSFPk6b270
         Yp/0efNPUVphLh5Q2s0wplUp3rabxLHeb+EpRpWrx2sIrSzJSuUh81ux8WrmHVEmFA5v
         gY0w==
X-Gm-Message-State: AOAM533JX/NVYvnX8C+32NBFR7k02RzcUH+duUbs/8KDG+G6l9dIB7H7
        iL8nPlCqVJXCL6hec4vF0NCi7H5U4Z/ui8IbnQywSHk=
X-Google-Smtp-Source: ABdhPJyLJpt/CJmrzTdpoQokHEmeJe8OMyfSEvgoVZ23Ver0nd4t0iS9JG2zgxeRKkAy56NOKiWjK7s01+qDGmD5irY=
X-Received: by 2002:aa7:da46:: with SMTP id w6mr20065833eds.31.1591014772302;
 Mon, 01 Jun 2020 05:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com> <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook> <202005291043.A63D910A8@keescook> <20200601101137.GA121847@gardel-login>
In-Reply-To: <20200601101137.GA121847@gardel-login>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Jun 2020 08:32:41 -0400
Message-ID: <CAHC9VhTK1306C2+ghMWHC0X6XVHiG+vBKPC5=7QLjxXwX4Eu9Q@mail.gmail.com>
Subject: Re: new seccomp mode aims to improve performance
To:     Lennart Poettering <lennart@poettering.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
        Tom Hromatka <tom.hromatka@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 1, 2020 at 6:17 AM Lennart Poettering
<lennart@poettering.net> wrote:
> On Fr, 29.05.20 12:27, Kees Cook (keescook@chromium.org) wrote:
> > # grep ^Seccomp_filters /proc/$(pidof systemd-resolved)/status
> > Seccomp_filters:        32
> >
> > # grep SystemCall /lib/systemd/system/systemd-resolved.service
> > SystemCallArchitectures=native
> > SystemCallErrorNumber=EPERM
> > SystemCallFilter=@system-service
> >
> > I'd like to better understand what they're doing, but haven't had time
> > to dig in. (The systemd devel mailing list requires subscription, so
> > I've directly CCed some systemd folks that have touched seccomp there
> > recently. Hi! The starts of this thread is here[4].)
>
> Hmm, so on x86-64 we try to install our seccomp filters three times:
> for the x86-64 syscall ABI, for the i386 syscall ABI and for the x32
> syscall ABI. Not all of the filters we apply work on all ABIs though,
> because syscalls are available on some but not others, or cannot
> sensibly be matched on some (because of socketcall, ipc and such
> multiplexed syscalls).
>
> When we fist added support for seccomp filters to systemd we compiled
> everything into a single filter, and let libseccomp apply it to
> different archs. But that didn't work out, since libseccomp doesn't
> tell use when it manages to apply a filter and when not, i.e. to which
> arch it worked and to which arch it didn't. And since we have some
> whitelist and some blacklist filters the internal fallback logic of
> libsecccomp doesn't work for us either, since you never know what you
> end up with. So we ended up breaking the different settings up into
> individual filters, and apply them individually and separately for
> each arch, so that we know exactly what we managed to install and what
> not, and what we can then know will properly filter and can check in
> our test suite.
>
> Keeping the filters separate made things a lot easier and simpler to
> debug, and our log output and testing became much less of a black
> box. We know exactly what worked and what didn't, and our test
> validate each filter.

In situations where the calling application creates multiple per-ABI
filters, the seccomp_merge(3) function can be used to merge the
filters into one.  There are some limitations (same byte ordering,
filter attributes, etc.) but in general it should work without problem
when merging x86_64, x32, and x86.

For what it is worth, libseccomp does handle things like the
multiplexed socket syscalls[*] across multiple ABIs, just not quite in
the way Lennart and systemd wanted.  It is also possible, although I
would be a bit surprised, that some of the systemd's concerns have
been resolved in modern libseccomp.  For better or worse, systemd was
one of the first adopters of libseccomp and they had to deal with more
than a few bumps as the library was developed.

[*] Handling the multiplexed syscalls is tricky, especially when one
combines multiple ABIs and the presence of both the multiplexed and
direct-wired syscalls on some kernel versions.  Recent libseccomp
versions do handle all these cases; creating multiplexed filters,
direct-wired filters, or both depending on the particular ABI.  The
problem comes when you try to wrap all of that up in a single library
API that works regardless of the ABI and kernel version across
different build and runtime environments.  This is why we don't
support the "exact" variants of the libseccomp API on filters which
contain multiple ABIs, we simply can't guarantee that we will always
be able to filter on the third argument socket() in a filter than
consists of the x86_64 and x86 ABIs.  The non-exact API variants
create the rules as best they can in this case, creating three rules
in the filter: a x86_64 rule which filters on the third argument of
socket(), a x86 rule which filters on the third argument of the
direct-wired socket(), and a x86 rule which filters on the multiplexed
socketcall(socket) syscall (impossible to filter on the syscall
argument here).

> For systemd-resolved we apply a bunch more filters than just those
> that are result of SystemCallFilter= and SystemCallArchitectures=
> (SystemCallFilter= itself synthesizes one filter per syscall ABI).

...

> So yeah, if one turns on many of these options in services (and we
> generally turn on everything we can for the services we ship) and then
> multiply that by the archs you end up with quite a bunch.

I'm not sure how systemd is architected with respect to seccomp
filtering, but once again it would seem like seccomp_merge() could be
useful here.

> If we wanted to optimize that in userspace, then libseccomp would have
> to be improved quite substantially to let us know exactly what works
> and what doesn't, and to have sane fallback both when building
> whitelists and blacklists.

It has been quite a while since we last talked about systemd's use of
libseccomp, but the upcoming v2.5.0 release (no date set yet, but
think weeks not months) finally takes a first step towards defining
proper return values on error for the API, no more "negative values on
error".  I'm sure there are other things, but I recall this as being
one of the bigger systemd wants.

As an aside, it is always going to be difficult to allow fine grained
control when you have a single libseccomp filter that includes
multiple ABIs; the different ABI oddities are just too great (see
comments above).  If you need exacting control of the filter, or ABI
specific handling, then the recommended way is to create those filters
independently and merge them together before loading them into the
kernel or applying any common rules.

> An easy improvement is probably if libseccomp would now start refusing
> to install x32 seccomp filters altogether now that x32 is entirely
> dead? Or are the entrypoints for x32 syscalls still available in the
> kernel? How could userspace figure out if they are available? If
> libseccomp doesn't want to add code for that, we probably could have
> that in systemd itself too...

You can eliminate x32 syscalls today using libseccomp though either
the "BADARCH" filter attribute or through a x32 specific filter that
defaults to KILL/ERRNO/etc. and has no rules (of course you could
merge this x32 filter with your x86_64 filter).

While I don't see us removing the ability to create x32 filters from
libseccomp any time soon (need to support older kernels), I can say
that I would be very happy to see x32 removed from systems.
Regardless of what one may think of the wisdom in creating this ABI, I
think we can agree the implementation was a bit of a hack.

-- 
paul moore
www.paul-moore.com
