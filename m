Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92B9409D23
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 21:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbhIMTd4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 15:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbhIMTdp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Sep 2021 15:33:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF409C061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 12:32:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w6so6540364pll.3
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zL4zqjWIj9mhPAiQe4v76KOD2s7l6T9rD3Ta2ItiX4Q=;
        b=cA7PUcvu7ZutOT7ZYIkjv9hW/ejFOHfQgz4yxJZR9lJzQWexSL1fmscVIeq7RNxVYm
         EtpoR6edagfYlegJnNUw4XDw6hggelh/nbQm1hnU209RRI7fz7vGcL763aF13thV9uex
         SbLjxGAf4lHim6vjSfkt+DIeI+s5GnkwLrUCPZaJN+p0v805g2BmJmEJLK0sv5kfjDyh
         GIElptmjh65ojHuOTMZnTcvCm+nYy88O0wX3Ue66MbsQJQfzmy5nWWDTc7KhJMPfjfKz
         hOh2op2OrTlqyPuAL/oRgFmbuo7mf9b8LFbuV2+9BhHSudiqe+80pJ2obDa1jUxBoKTn
         RCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zL4zqjWIj9mhPAiQe4v76KOD2s7l6T9rD3Ta2ItiX4Q=;
        b=mxzWs6nJ8XAtancWkkJl0p+xis6KSCN0w0/lpFL46q6EISpYI9jsR/ethtLtbLOI43
         U/plF5euFieDePOUb6+2v3ByriNh2QCjL/EWe7L1qG3wWnPbNtoygu5k8kXcDMIDSnul
         Y5wUjwA9wDVVtDGrwOObXQbPG0fGd3JUqcfSL5xCk6f+S2OXvaTomkfVo4xz8Ua+uWRp
         ja8m9JPwkcY0BF4SMgxn8IaUKRSyIyoPhpCBO5VlExuFFvXCaFCL3X9Nl0ORWVE+Gipo
         aMJUCiou+U9d5EumJI3T+gOY9MS2JE0TJ88l0U7FPJM0WZA+5fczN0hhWLEl5rNgJKjX
         sUyw==
X-Gm-Message-State: AOAM530a2beQY56deJ9HF8h27JQENy47sLqY6Jz/HV6vaeLZx3imj216
        /C2KUznmeBWl99ojS6bG+OnPh1kC4m9iF7I7euo=
X-Google-Smtp-Source: ABdhPJzR2TdvlyZ8qkW80SK4fV/T43hGLvn9qIU/dMPXaFj38EY9hSo2Ohlv2UaISw1WQfyYD7ZDTa3l4baiEgtyj8c=
X-Received: by 2002:a17:902:710e:b0:139:3bd:59b9 with SMTP id
 a14-20020a170902710e00b0013903bd59b9mr11729045pll.3.1631561549292; Mon, 13
 Sep 2021 12:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210908213226.1871016-1-andrii@kernel.org> <af17df18-73ae-ad25-0803-3dc37a4cc02c@iogearbox.net>
 <CAEf4BzZcfy9f2E2ADvaV5PDXRMxsupePGPdu12ZRjE2wh3Hn1w@mail.gmail.com>
 <CAEf4BzZqc7txCoiV-F0_+oMB9GMv4BTapnef5V1XZk8CC=LpHA@mail.gmail.com>
 <4287e56e-a91a-1f39-5dae-14ecabe537db@iogearbox.net> <CAEf4BzaNSG1w_CuYVoK7WSntKsr4mzTr99K6jPVeSm_-2cbwZw@mail.gmail.com>
 <CAJygYd0GpmGL43PjvtCkTpmF-+VS81h6K9nF5SQoTMQ1WP0vUQ@mail.gmail.com> <CAEf4BzYF7r6BvgB6tiVfDYKk3Yf92=E=CcX7CVkj4ANFU4T6cw@mail.gmail.com>
In-Reply-To: <CAEf4BzYF7r6BvgB6tiVfDYKk3Yf92=E=CcX7CVkj4ANFU4T6cw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 13 Sep 2021 12:32:18 -0700
Message-ID: <CAADnVQKq5-ku4J3-nVf3bDLbxHwfHEPDZSCrcG+SXbP3VmPP1A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] libbpf: add LIBBPF_DEPRECATED_SINCE macro for
 scheduling API deprecations
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "sunyucong@gmail.com" <sunyucong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 11:13 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 13, 2021 at 7:29 AM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
> >
> > I ran into the same issue
> >
> >   DESCEND objtool
> >   DESCEND bpf/resolve_btfids
> >   CALL    scripts/atomic/check-atomics.sh
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> >   CC      kernel/rseq.o
> >   CC [U]  kernel/bpf/preload/iterators/iterators.o
> > In file included from ./tools/lib/bpf/libbpf.h:20,
> >                  from kernel/bpf/preload/iterators/iterators.c:10:
> > ./tools/lib/bpf/libbpf_common.h:13:10: fatal error: libbpf_version.h:
> > No such file or directory
> >    13 | #include "libbpf_version.h"
> >       |          ^~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make[3]: *** [scripts/Makefile.userprogs:43:
> > kernel/bpf/preload/iterators/iterators.o] Error 1
> > make[2]: *** [scripts/Makefile.build:540: kernel/bpf/preload] Error 2
> > make[1]: *** [scripts/Makefile.build:540: kernel/bpf] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:1872: kernel] Error 2
> > make: *** Waiting for unfinished jobs....
> >
> >
> > And I tried `make clean` in tools/lib/bpf , which didn't solve the
>
> make clean in tools/lib/bpf won't help, you'd need to clean kernel/bpf/preload
>
> > issue, had to do a full clean.  To me it seems we should add
> > "libbpf_version.h" along with LIBBPF_A  in kernel/bpf/preload/Makefile
>
> LIBBPF_A should force generation of libbpf_version.h, so there is no
> need to add libbpf_version.h explicitly. I wonder if maybe adding
> FORCE would help, like this:
>
> $(LIBBPF_A): FORCE
>    ...
>
> If you can still repro this, can you please try that? You might need
> to also have
>
> .PHONY: FORCE
> FORCE:
>
> in that file for this to work. It should force calling into libbpf's
> Makefile, even if Kbuild believes LIBBPF_A is up to date.

I've hit this issue as well and could easily repro.
The (LIBBPF_A): FORCE fixed it for me and I pushed this one liner to bpf-next.
The later hunk wasn't necessary.
