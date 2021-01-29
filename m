Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F281B308343
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 02:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhA2Bcb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 20:32:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhA2Bc3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 20:32:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 597D164E03
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 01:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611883908;
        bh=7nJ1EsIqbPATpmmcv9ZyZUVEHWOdColjg3IgW0ayZH4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZYUcH0qaXz1qxbEMztESpvm2K/SMhJNYJCbCA3uYSW5qLvt7BuypYvuW8QuMgGi/j
         QBaLET8RRIP7z+rG4gwcQKyfTxCzXN0N2bIqdzgoYFrWS0IlLrsdPzsl64AMQsy9da
         mZhX0/mCPjPYzH8qox/21k8VUlhynG9QMzhay17MbjJn7F+FBQ/YQJ+fK3QPamUht9
         NmfWkQzXjsb3SlXsxB1/cEB82ULPmUj3dY5kORnSP+VgNA3+rE9XZBXNijv41ZbIzW
         rYn1y0tMKDbQD4vIRAEsQRr9JuW2FSSZ2ASQk6D309pJ+QRC5H1OwjVssfwd7dQqek
         6ZUsgIvJwYpOA==
Received: by mail-ej1-f45.google.com with SMTP id a10so10626695ejg.10
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 17:31:48 -0800 (PST)
X-Gm-Message-State: AOAM530xdGN3rvdYP0zfXBTKZYwda6h+M3C3ApifBAduJksuwlx+poiA
        e4n51RDNbglAa7XF8HxKukSwkLpIdn3j8s7GczbVoA==
X-Google-Smtp-Source: ABdhPJxlSzV+8r8cOGbibJoGcJnw9CB/HY6D3m4iA7cTkhtObdJ0NTCbrTHH5nmseIg4CT6DvYcGe1NAyWWJGgaPAbk=
X-Received: by 2002:a17:906:5608:: with SMTP id f8mr2267045ejq.101.1611883906809;
 Thu, 28 Jan 2021 17:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20210126001219.845816-1-yhs@fb.com> <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com> <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
 <CALCETrVXdbXUMA_CJj1knMNxsHR2ao67apwk_BTTMPaQGxusag@mail.gmail.com>
 <20210129002642.iqlbssmp267zv7f2@ast-mbp.dhcp.thefacebook.com>
 <CALCETrUQuf6FX9EmuZur7vRwbeZBmoKeSYb9Rvx2ETp76SukOg@mail.gmail.com>
 <20210129004131.wzwnvdwjlio4traw@ast-mbp.dhcp.thefacebook.com>
 <CALCETrXdmdG2o20VY16vBMJ0p5nSuKOv7sTQtboKFDfuQr1nZA@mail.gmail.com> <20210129010441.4gaa4vzruenfb7zf@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210129010441.4gaa4vzruenfb7zf@ast-mbp.dhcp.thefacebook.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 28 Jan 2021 17:31:35 -0800
X-Gmail-Original-Message-ID: <CALCETrXeaEp5Q5UadA2_frxNFiUDyFx643N6SQf3Gy6G+ZtcNA@mail.gmail.com>
Message-ID: <CALCETrXeaEp5Q5UadA2_frxNFiUDyFx643N6SQf3Gy6G+ZtcNA@mail.gmail.com>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions properly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 5:04 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 28, 2021 at 04:45:41PM -0800, Andy Lutomirski wrote:
> > On Thu, Jan 28, 2021 at 4:41 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jan 28, 2021 at 04:29:51PM -0800, Andy Lutomirski wrote:
> > > > BPF generated a NULL pointer dereference (where NULL is a user
> > > > pointer) and expected it to recover cleanly. What exactly am I
> > > > supposed to debug?  IMO the only thing wrong with the x86 code is that
> > > > it doesn't complain more loudly.  I will fix that, too.
> > >
> > > are you saying that NULL is a _user_ pointer?!
> > > It's NULL. All zeros.
> > > probe_read_kernel(NULL) was returning EFAULT on it and should continue doing so.
> >
> > probe_read_kernel() does not exist.  get_kernel_nofault() returns -ERANGE.
>
> That was an old name. bpf_probe_read_kernel() is using copy_from_kernel_nofault() now.
>
> > And yes, NULL is a user pointer.  I can write you a little Linux
> > program that maps some real valid data at user address 0.  As I noted
>
> are you sure? I thought mmap of addr zero was disallowed long ago.

Quite sure.

#define _GNU_SOURCE

#include <stdio.h>
#include <sys/mman.h>
#include <err.h>

int main()
{
    int *ptr = mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_ANONYMOUS |
MAP_PRIVATE | MAP_FIXED, -1, 0);
    if (ptr == MAP_FAILED)
        err(1, "mmap");

    *ptr = 1;
    printf("I just wrote %d to %p\n", *ptr, ptr);
    return 0;
}

Whether this works or not depends on a complicated combination of
sysctl settings, process capabilities, and whether SELinux feels like
adding its own restrictions.  But it does work on current kernels.

>
> > when I first analyzed this bug, because NULL is a user address, bpf is
> > incorrectly triggering the *user* fault handling code, and that code
> > is objecting.
> >
> > I propose the following fix to the x86 code.  I'll send it as a real
> > patch tomorrow.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fixes&id=f61282777772f375bba7130ae39ccbd7e83878b2
>
> You realize that you propose to panic kernels for all existing tracing users, right?
>
> Do you have a specific security concern with treating fault on NULL special?

The security concern is probably not that severe because of the
aforementioned restrictions, but I haven't analyzed it very carefully.
But I do have a *functionality* concern.  As the original email that
prompted this whole discussion noted, the current x86 fault code does
not do what you want it to do if SMAP is off.  The fact that it mostly
works with SMAP on is luck.  With SMAP off, we will behave erratically
at best.

What exactly could the fault code even do to fix this up?  Something like:

if (addr == 0 && SMAP off && error_code says it's kernel mode && we
don't have permission to map NULL) {
  special care for bpf;
}

This seems arbitrary and fragile.  And it's not obviously
implementable safely without taking locks, which we really ought not
to be doing from inside arbitrary bpf programs.  Keep in mind that, if
SMAP is unavailable, the fault code literally does not know whether
the page fault originated form a valid uaccess region.

There's also always the possibility that you simultaneously run bpf
and something like Wine or DOSEMU2 that actually maps the zero page,
in which case the effect of the bpf code is going to be quite erratic
and will depend on which mm is loaded.

--Andy
