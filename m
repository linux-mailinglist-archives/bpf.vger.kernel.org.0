Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1413635076A
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 21:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhCaTeS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 15:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbhCaTds (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 15:33:48 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8504BC061574
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 12:33:48 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i144so22390438ybg.1
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2V/u7CIXFhq6jKT7K2Jpc2Fda5EpohTEbl4jStlZ7w=;
        b=PUEpDMo+oRtu2dAPLfYTtCQBPk/2RndD6/tTemaVnNVZ/DYOfwzNGgAn979TT6iw9K
         VCGoZ7w0LjrpiEjuAqTCcZ9wj6S4AG5FSEBe7ZosdFxhM1ZQdkbR4rk2iq6mrRMwfpMB
         gLfpC07V6eA7ctOzKxWg25+HHZQPlMvbf/55dQgDjsiHsd+y0fwcUAxeNBODa+68mCOe
         3M+SXlzOD7kb7yC9H1B52jmUEDcvNCgXzZ1QeI2OZGZhDFWSVZJ6aCPNj2pBvHWT316A
         T2DQtcYF7IAgt4HAPZ58ux7KS8jOj09wxteLZ0FSDeDMcgiSgv9Ynpb8VSHfW9t4hFJL
         uW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2V/u7CIXFhq6jKT7K2Jpc2Fda5EpohTEbl4jStlZ7w=;
        b=At/ZZbbURAA23C/auZbc8uKtxdtyHkxQL3BW35VzEssSoVAG7yVy4nGA3xF8s85stG
         +Dxw7nWNRKoUIA9CqYo9Ssdvwbqrc3gXBwF3hV07rYbJ8oB1nN6NY9O5iwAnx7TK4dkk
         K+lehWz5Kef6QaHgzGNASHEtbA5VTPQm515xx3i0ElCSUPLu9rmspe3JNGl3tuNTIJYU
         yV6k60zkJ1Hz58uFmm27J/WUyhtb3HYpQysKUvmgHBy88CyrQjHUtqdeu/s82JPYCT7U
         GXEcpfxgCkQF/dZAfvL2bpOn5ZQH/3YurzKFR7hVqtlIuW+x38BFGiMwhh2WviU37XHe
         zYJQ==
X-Gm-Message-State: AOAM5306PHvNxwafSiTgd/1OYGDxWnDZ3KdvrpAfaQsci+tCH51L6VlE
        +LVwXuq7zqfjnFZ/eWWKq1B2WgHHAg2NZ2hg2tw=
X-Google-Smtp-Source: ABdhPJxPbiH/W7vEaRQS10KCP37vEgtqkbKPPhxhCHzz33E3RQkESBNzJ5Bp75xJUUSu0uUkt2KLHEQXFp+ID8L2uwI=
X-Received: by 2002:a25:6d83:: with SMTP id i125mr6676312ybc.27.1617219227761;
 Wed, 31 Mar 2021 12:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210323014752.3198283-1-kpsingh@kernel.org> <CAEf4BzY=VR4MbYiG4fPwNPVB3hKw4MckRv2sftk160H6TapMaQ@mail.gmail.com>
 <CACYkzJ4p-vMg_3Nom-NB781J3ELsZi=N1FK5RA=3=FZQaZaknA@mail.gmail.com> <CAEf4BzaVMMYAYqKc3rt02tfS=wXbcxc-jnSKYhcfhB1qHHxjNw@mail.gmail.com>
In-Reply-To: <CAEf4BzaVMMYAYqKc3rt02tfS=wXbcxc-jnSKYhcfhB1qHHxjNw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 31 Mar 2021 12:33:36 -0700
Message-ID: <CAEf4BzYAGK1uu4YT=-nxz1hVZSsLNOsGtj+cVn2rOhpK4PZSsg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Add an option for a debug
 shell in vmtest.sh
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 30, 2021 at 10:17 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 29, 2021 at 6:46 AM KP Singh <kpsingh@kernel.org> wrote:
> >
> > On Fri, Mar 26, 2021 at 5:48 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Mar 22, 2021 at 6:47 PM KP Singh <kpsingh@kernel.org> wrote:
> > > >
> > > > The newly introduced -s command line option starts an interactive shell.
> > > > If a command is specified, the shell is started after the command
> > > > finishes executing. It's useful to have a shell especially when
> > > > debugging failing tests or developing new tests.
> > > >
> > > > Since the user may terminate the VM forcefully, an extra "sync" is added
> > > > after the execution of the command to persist any logs from the command
> > > > into the log file.
> > > >
> > > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > > ---
> > >
> > > I run:
> > >
> > > ./vmtest.sh -s
> > >
> > > And I get test_progs executed, not bash. What do I do wrong?...
> >
> > It does not seem to happen for me [classic, works on my machine :P]
> >
> > tools/testing/selftests/bpf$ ./vmtest.sh -s
> > [...]
> > + /etc/rcS.d/S50-startup
> > bash: cannot set terminal process group (84): Inappropriate ioctl for device
> > bash: no job control in this shell
> > [root@(none) /]#
> >
> > To help debug this:
> >
> > Can you check the contents of /etc/rcS.d/S50-startup on the image,
> > here's what mine looks like:
> >
> > [root@(none) /]# cat /etc/rcS.d/S50-startup
> > #!/bin/bash
> > bash
>
> Couldn't do it, because it would only run test_progs, no matter which
> command I specified (that didn't happen before, strange). E.g.,
> running `./vmtest.sh -- cat /etc/rcS.d/S50-startup` gives this:
>
> starting pid 83, tty '': '/etc/init.d/rcS'
> [    1.070838] random: fast init done
> + for path in /etc/rcS.d/S*
> + '[' -x /etc/rcS.d/S10-mount ']'
> + /etc/rcS.d/S10-mount
> + /bin/mount proc /proc -t proc
> + /bin/mount devtmpfs /dev -t devtmpfs
> mount: mounting devtmpfs on /dev failed: Resource busy
> + true
> + /bin/mount sysfs /sys -t sysfs
> + /bin/mount bpffs /sys/fs/bpf -t bpf
> + /bin/mount debugfs /sys/kernel/debug -t debugfs
> + echo 'Listing currently mounted file systems'
> Listing currently mounted file systems
> + /bin/mount
> /dev/root on / type ext4 (rw,relatime)
> devtmpfs on /dev type devtmpfs
> (rw,relatime,size=1004288k,nr_inodes=251072,mode=755)
> proc on /proc type proc (rw,relatime)
> sysfs on /sys type sysfs (rw,relatime)
> none on /sys/fs/bpf type bpf (rw,relatime)
> debugfs on /sys/kernel/debug type debugfs (rw,relatime)
> + for path in /etc/rcS.d/S*
> + '[' -x /etc/rcS.d/S40-network ']'
> + /etc/rcS.d/S40-network
> + ip link set lo up
> + for path in /etc/rcS.d/S*
> + '[' -x /etc/rcS.d/S50-startup ']'
> + /etc/rcS.d/S50-startup
> ./test_progs
>
> And there was a bunch of messages like this before kernel started:
>
> error: Macro %global is a built-in (%define)
> error: Macro %global is a built-in (%define)
> warning: file /etc/rpm/macros.perl: 2 invalid macro definitions
>
> Don't know if related.
>
> >
> > 2. Also, can you delete the cache in the home directory
> > (~/.bpf_selftests by default) and try again?
> >
>
> But this solved the issue. So must be something in cached data.
>

I've applied it to bpf-next, thanks!

> > >
> > > >  tools/testing/selftests/bpf/vmtest.sh | 39 +++++++++++++++++++--------
> > > >  1 file changed, 28 insertions(+), 11 deletions(-)
> > > >
> > >
> > > [...]
