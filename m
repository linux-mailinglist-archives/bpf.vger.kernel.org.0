Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F1B34F83A
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 07:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhCaFR5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 01:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhCaFRm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 01:17:42 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2EFC061574
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 22:17:42 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id w8so19899055ybt.3
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 22:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xelc11Uk2IAiqnBRCAFq2uTzl15mBEHXDgI9wYRVX4M=;
        b=nnNA0fkz0+hr1R11EgK5iM7+e0p+k8r2wstpw3togc8wcBm+0+dcKMNRa4TvjgNMIO
         1yAnXa3caX8IkpzS4+lf5LmxxvWEGRDE38nrF4qJe4ire4Oev4pgHNwICKcivYdxbx0c
         pTvVv5H2uJlMf9w2mHtTHpchoTPMYG4oPe1Nnv6Ui6jPWOEgcctD53cbGZ+yL0dOlq0s
         wwlI/76TUYAzOKoV9TOCNMFMB6YMK+uXtNzfDXPjVz1KBNKHRAHxqukaiu1Eg0ukSmUs
         JbYPxn7jkqQJOrPYMwWlAike1qkuQHP+w3wAdNB9gSiFDGk/GunCb0CoQXD0xSq6BWfH
         vVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xelc11Uk2IAiqnBRCAFq2uTzl15mBEHXDgI9wYRVX4M=;
        b=ZunfH/2Fq5fZVL9taUEzE+Gk+9zBYSuL7e9nS+LpdXULWgh/9sO4Y+xc2IiLBjGQ/z
         l5AfNPXhMGw29+zt56nyucJUWgfEsi3QtqZMcuM3g3XqJUhThC3HqWXfHY+8lyXSfkyK
         hmytUFiaFox4P9aVsFvY4GZrxpVwRGg2+Rc2xxcXUlZjweAdnVXODzFzMk404B2hUIjo
         VPLWusNGwxsHnXnjHuQ2hfaNuF0pdoOIxF5BaoRv2zTeqyLk4/bxoqM4tOWVmAz8rObD
         /pA7I4XxGTs5r7ZH/GoYo/OqeqAePpliQWFiQdEVHDo2yH6KR9jPdtdg/nukhJI630c9
         /Ldg==
X-Gm-Message-State: AOAM530eXp/cRxN/qy0tKm6uZdqxRjdvxWtN/EetZJcTk2Ku76u8A5K1
        Llu+Wc3IEA1nlz1bZ8F0mM+gLQb066tJ5/xPtvI=
X-Google-Smtp-Source: ABdhPJyixFMbbH1kZkmvayd+yOmM6JhUso6/wIeRwWcgyNjKoYdWOnbOVF2a01S1RPIENSTen3URQgOiR5WGzfjljS0=
X-Received: by 2002:a25:9942:: with SMTP id n2mr2271987ybo.230.1617167861126;
 Tue, 30 Mar 2021 22:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210323014752.3198283-1-kpsingh@kernel.org> <CAEf4BzY=VR4MbYiG4fPwNPVB3hKw4MckRv2sftk160H6TapMaQ@mail.gmail.com>
 <CACYkzJ4p-vMg_3Nom-NB781J3ELsZi=N1FK5RA=3=FZQaZaknA@mail.gmail.com>
In-Reply-To: <CACYkzJ4p-vMg_3Nom-NB781J3ELsZi=N1FK5RA=3=FZQaZaknA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 30 Mar 2021 22:17:30 -0700
Message-ID: <CAEf4BzaVMMYAYqKc3rt02tfS=wXbcxc-jnSKYhcfhB1qHHxjNw@mail.gmail.com>
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

On Mon, Mar 29, 2021 at 6:46 AM KP Singh <kpsingh@kernel.org> wrote:
>
> On Fri, Mar 26, 2021 at 5:48 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Mar 22, 2021 at 6:47 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > The newly introduced -s command line option starts an interactive shell.
> > > If a command is specified, the shell is started after the command
> > > finishes executing. It's useful to have a shell especially when
> > > debugging failing tests or developing new tests.
> > >
> > > Since the user may terminate the VM forcefully, an extra "sync" is added
> > > after the execution of the command to persist any logs from the command
> > > into the log file.
> > >
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> >
> > I run:
> >
> > ./vmtest.sh -s
> >
> > And I get test_progs executed, not bash. What do I do wrong?...
>
> It does not seem to happen for me [classic, works on my machine :P]
>
> tools/testing/selftests/bpf$ ./vmtest.sh -s
> [...]
> + /etc/rcS.d/S50-startup
> bash: cannot set terminal process group (84): Inappropriate ioctl for device
> bash: no job control in this shell
> [root@(none) /]#
>
> To help debug this:
>
> Can you check the contents of /etc/rcS.d/S50-startup on the image,
> here's what mine looks like:
>
> [root@(none) /]# cat /etc/rcS.d/S50-startup
> #!/bin/bash
> bash

Couldn't do it, because it would only run test_progs, no matter which
command I specified (that didn't happen before, strange). E.g.,
running `./vmtest.sh -- cat /etc/rcS.d/S50-startup` gives this:

starting pid 83, tty '': '/etc/init.d/rcS'
[    1.070838] random: fast init done
+ for path in /etc/rcS.d/S*
+ '[' -x /etc/rcS.d/S10-mount ']'
+ /etc/rcS.d/S10-mount
+ /bin/mount proc /proc -t proc
+ /bin/mount devtmpfs /dev -t devtmpfs
mount: mounting devtmpfs on /dev failed: Resource busy
+ true
+ /bin/mount sysfs /sys -t sysfs
+ /bin/mount bpffs /sys/fs/bpf -t bpf
+ /bin/mount debugfs /sys/kernel/debug -t debugfs
+ echo 'Listing currently mounted file systems'
Listing currently mounted file systems
+ /bin/mount
/dev/root on / type ext4 (rw,relatime)
devtmpfs on /dev type devtmpfs
(rw,relatime,size=1004288k,nr_inodes=251072,mode=755)
proc on /proc type proc (rw,relatime)
sysfs on /sys type sysfs (rw,relatime)
none on /sys/fs/bpf type bpf (rw,relatime)
debugfs on /sys/kernel/debug type debugfs (rw,relatime)
+ for path in /etc/rcS.d/S*
+ '[' -x /etc/rcS.d/S40-network ']'
+ /etc/rcS.d/S40-network
+ ip link set lo up
+ for path in /etc/rcS.d/S*
+ '[' -x /etc/rcS.d/S50-startup ']'
+ /etc/rcS.d/S50-startup
./test_progs

And there was a bunch of messages like this before kernel started:

error: Macro %global is a built-in (%define)
error: Macro %global is a built-in (%define)
warning: file /etc/rpm/macros.perl: 2 invalid macro definitions

Don't know if related.

>
> 2. Also, can you delete the cache in the home directory
> (~/.bpf_selftests by default) and try again?
>

But this solved the issue. So must be something in cached data.

> >
> > >  tools/testing/selftests/bpf/vmtest.sh | 39 +++++++++++++++++++--------
> > >  1 file changed, 28 insertions(+), 11 deletions(-)
> > >
> >
> > [...]
