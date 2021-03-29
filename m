Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD6234D19E
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 15:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhC2Nqg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 09:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhC2NqH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 09:46:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 660996193A
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 13:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617025566;
        bh=vgbpSyRZKcSNlt4BWVkRpL2w7f2hGJ9c/QfXFoH4rTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dBpIXS/YvUvhD75fJnxK7I4psQMw4aAHfWStxMRN6YJ0rh42njgwT9NBwimAN8tuI
         IcxwsPBaiSlFUoV+cylXZ5awIeFfpBW8M1W73mqt+sDbaQqoQqhD4gszbl1lQwstAa
         Ycfn7Un38ghajv2qYn/kSXrC0GOBiBfzbxDTIAXEchdUgMb4QIw7T8uHr3I3jEwSzz
         mUh8NsSVakQ+EdsttXklAR3PaF9PQFDAzQdB5KLVb7L7+8s5W9Vdb/vIoIOkwMj/6a
         A1GstQHk+ZJmC0V0/IpNlOok6t7c1P/W/WjHlNnTAFVQpW7psX+AZ6gVKV/G7eZN+s
         XUSEftstP3bvg==
Received: by mail-lj1-f170.google.com with SMTP id s17so15999544ljc.5
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 06:46:06 -0700 (PDT)
X-Gm-Message-State: AOAM531wkrFGYPZTsIqZAVXV3ZSEJWl6hqeH4c6DlUHA+Vi7Xh8n+UI2
        42DE6iVpL6kfdLi+Ux2bLkk47AYfhMmazikEO3Uu8w==
X-Google-Smtp-Source: ABdhPJxcryoMBhm0ow+Gd/J8kcNKB0NlFizfPiRGF21vZeNn4kvM7RF8K9PlPanPxvYnpcyjlVHlFokxcHpRjIRJsCA=
X-Received: by 2002:a2e:9cce:: with SMTP id g14mr17674490ljj.136.1617025564707;
 Mon, 29 Mar 2021 06:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210323014752.3198283-1-kpsingh@kernel.org> <CAEf4BzY=VR4MbYiG4fPwNPVB3hKw4MckRv2sftk160H6TapMaQ@mail.gmail.com>
In-Reply-To: <CAEf4BzY=VR4MbYiG4fPwNPVB3hKw4MckRv2sftk160H6TapMaQ@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 29 Mar 2021 15:45:54 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4p-vMg_3Nom-NB781J3ELsZi=N1FK5RA=3=FZQaZaknA@mail.gmail.com>
Message-ID: <CACYkzJ4p-vMg_3Nom-NB781J3ELsZi=N1FK5RA=3=FZQaZaknA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Add an option for a debug
 shell in vmtest.sh
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 26, 2021 at 5:48 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 22, 2021 at 6:47 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > The newly introduced -s command line option starts an interactive shell.
> > If a command is specified, the shell is started after the command
> > finishes executing. It's useful to have a shell especially when
> > debugging failing tests or developing new tests.
> >
> > Since the user may terminate the VM forcefully, an extra "sync" is added
> > after the execution of the command to persist any logs from the command
> > into the log file.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
>
> I run:
>
> ./vmtest.sh -s
>
> And I get test_progs executed, not bash. What do I do wrong?...

It does not seem to happen for me [classic, works on my machine :P]

tools/testing/selftests/bpf$ ./vmtest.sh -s
[...]
+ /etc/rcS.d/S50-startup
bash: cannot set terminal process group (84): Inappropriate ioctl for device
bash: no job control in this shell
[root@(none) /]#

To help debug this:

Can you check the contents of /etc/rcS.d/S50-startup on the image,
here's what mine looks like:

[root@(none) /]# cat /etc/rcS.d/S50-startup
#!/bin/bash
bash

2. Also, can you delete the cache in the home directory
(~/.bpf_selftests by default) and try again?

>
> >  tools/testing/selftests/bpf/vmtest.sh | 39 +++++++++++++++++++--------
> >  1 file changed, 28 insertions(+), 11 deletions(-)
> >
>
> [...]
