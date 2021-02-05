Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218AB311952
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 04:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhBFDCF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 22:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhBFCzl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 21:55:41 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2855C061D7F;
        Fri,  5 Feb 2021 14:11:55 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id s61so8261098ybi.4;
        Fri, 05 Feb 2021 14:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wYH4ZTK5z/flvIckrO5N+ZdlqhzmsEspV7Keq9hUBA=;
        b=oWBXoCkzXi9LuyQb7q1zAAN1rA68maErUKhE9bEPkXayREl9MQX9apAsK0sg4QAc4R
         pE8duD7oDXgunoFA/Wainaol5ZambqQh7QRYL1J8fD8FtgpzZFOdE1o7lk51ZWmag/kI
         /31+5AfLYtrCkFvUqZUFE7hSxjBmuUOS7eNe+aGqHY6ee8aZHgHxPS5kAS6QPw68Zk+k
         P5voEum08DOx3byVb9607rlojaiOLgPixlFHw7jr1yVexZyR/R1C86jfZnFT5j0Xc7Fv
         wGbLcFhIasE9FuWdzv14fNzdTyVC0u2n+8nkiCZCN3eP3nhBioij9t/+0IAStRvtZJDb
         xYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wYH4ZTK5z/flvIckrO5N+ZdlqhzmsEspV7Keq9hUBA=;
        b=m7z9bn6lt6hMmMwj6mqRX4jptCvZdlKrr1Bz/dy9T3DXt9SiMLy9Jf5DU8KaJOvns5
         4ZlFVKn8gLdkqZMwjuILRITg+y0irv0hOn5XPenaJClijpxMH62FYr0HN7bVlawCc3ZS
         8Ky5/ZEpNp2vW7Fjjqx5uKdqukULhQ3lLgh8NziSZdd6ULMqAbGHLrTadl7+UXhe3Kcp
         aKvn2Qp62Myz0UITTRk9SDnM0xaQL973egde1Jq1CfDZy9MXqqCGprrvXk7JXZ2LTdor
         2Nl5qE0dmcBin2DDIsVOmvK33LdU8ZQ5QQkvcGfNTWbWiPB7GPC02+EDJYNnPcrJ/hJN
         LtGA==
X-Gm-Message-State: AOAM533q8Ri76ioWqhmTYsBZJvFeP4orlKbCHCT2tUgW2/UzOxPQ4ZjS
        isrhxB+XgKSSXHocGswyVPc+kHhWNaE6GZg8ysq337y/l7LYDA==
X-Google-Smtp-Source: ABdhPJyYCbGisxBoQhBELxd9IT/XMkHEEAZ56ZRFxuQ9ps6oooojPj6j5F5PwJjPEqTd6RkE4c0FpqD7mTcALl68VW0=
X-Received: by 2002:a5b:3c4:: with SMTP id t4mr8559145ybp.510.1612563115280;
 Fri, 05 Feb 2021 14:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CAEf4BzY-RbXXW-Ajcvq4fziOJ=tMtT7O76SUboHQyULNDkhthw@mail.gmail.com>
 <C359F19F-29BC-4F6D-961A-79BFA47F36A7@gmail.com> <CAEf4BzZf_1g13dA1t6rbi1TFttufyGNaU14pPxo9uK-FVArCbQ@mail.gmail.com>
 <BFDC3C1D-F87D-4F82-BDB0-444629C484CE@gmail.com> <20210205162523.GF920417@kernel.org>
In-Reply-To: <20210205162523.GF920417@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 5 Feb 2021 14:11:44 -0800
Message-ID: <CAEf4BzaXAxOnzkuiOpdMKjQyYHjAN6Td35hDGwbYc9i9aGuj0A@mail.gmail.com>
Subject: Re: ANNOUNCE: pahole v1.20 (gcc11 DWARF5's default, lots of ELF
 sections, BTF)
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 5, 2021 at 8:25 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, Feb 05, 2021 at 06:33:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> > On February 5, 2021 4:39:47 AM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >On Thu, Feb 4, 2021 at 8:34 PM Arnaldo Carvalho de Melo ><arnaldo.melo@gmail.com> wrote:
> > >> On February 4, 2021 9:01:51 PM GMT-03:00, Andrii Nakryiko
> > ><andrii.nakryiko@gmail.com> wrote:
> > >> >On Thu, Feb 4, 2021 at 2:09 PM Arnaldo Carvalho de
> > >Melo><acme@kernel.org> wrote:
> > >> >>         The v1.20 release of pahole and its friends is out, mostly
> > >> >> addressing problems related to gcc 11 defaulting to DWARF5 for -g,
> > >> >> available at the usual places:
>
> > >> >Great, thanks, Arnaldo! Do you plan to build RPMs soon as well?
>
> > >> It's in rawhide already, I'll do it for f33, f32 later,
>
> > >Do you have a link? I tried to find it, but only see 1.19 so far.
>
> > https://koji.fedoraproject.org/koji/buildinfo?buildID=1703678
>
> And now for Fedora 33, waiting for karma bumps at:
>
> https://bodhi.fedoraproject.org/updates/FEDORA-2021-804e7a572c
>
> fedpkg buidling for f32 now.
>
> - Arnaldo

Ok, imported dwarves-1.20. Had to fix two dates in changelog (in
spec), day of week didn't match the date, tooling complained about
that. Also had to undo cmake_build and cmake_install fanciness,
because apparently we don't have them or the support for it is not
great. But otherwise everything else looks to be ok.
