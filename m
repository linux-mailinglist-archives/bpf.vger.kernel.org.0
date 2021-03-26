Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF734B2E7
	for <lists+bpf@lfdr.de>; Sat, 27 Mar 2021 00:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhCZXVp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 19:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhCZXVf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 19:21:35 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53048C0613AA;
        Fri, 26 Mar 2021 16:21:35 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i9so7479107ybp.4;
        Fri, 26 Mar 2021 16:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4yMKUmK+dMgxH1RSoOBSg/0jnfY/5V3KnbDp+LdmIsg=;
        b=lwbiFdGDqqSx42GRoK0LdNY9VMNAJl7lJOy2B7rEZs6RzuGWZDpc9y7hUx30MPNVS4
         2a00fy7Xy+ZRS8Ti6ZmMF2VU1gLUxTkL4K4ErmqqAOwgv5pv2BS45c+nhx/Js88Ejp1M
         du3OBNKxP1BHVzyNtXjZiRPiAKHgAfj8CTmWLklBuzUZGcvLFxVvplTGd0mDs/PwZb8+
         H5CIjiOSspnc1ampSvnbBm+CeQ78fzl8+hcAB+KhOO/cqatTXeBW7OasEphtKf6Fpzyp
         +9plu99hwHBxyzvYUvoAD3V8eSB8aUJq70ozGx7mnoeWhbk5W6XqmoclrFNdo88K2B1G
         w/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yMKUmK+dMgxH1RSoOBSg/0jnfY/5V3KnbDp+LdmIsg=;
        b=eJp6oS8CCAOog1rxwAss+KyTg1uH1ZwgAt5YHCu6XDMcMkQGj5JYrlU6IbVGy64DYb
         wqTv2DfzFNhbyuE9bFLjMOu0wxvi23/6778Ku8Wi4BIpxI96GBZiYmDmOBhus912VHq4
         iskpdnw5Tz5BvJAg7v1EVkuE/1BDDRZj70YlPbkgPg3ICmjTeHra0HQ5DZlNyB+BPdpO
         tTnMqWgOqeMJYm9M3B4TAnew/QX5ONvDJlXH5sGeqFrsvOkWSq3beNz+PiMg2FT4T4JF
         4nynxyjyHdVh4vKsw714IOBaTySYS3ucnAHFfWafujgBxwc6yf8/LVfdFDvJkLfXgb0w
         C7dw==
X-Gm-Message-State: AOAM5311j3NFhE1O26KKYFGBDrH1MUx8A9f1a9okik0CVbBIhpBtwwz2
        5ic13j5g4OVn0lMY0nOzw27KUqyuUuyhO4wikeg=
X-Google-Smtp-Source: ABdhPJymnqJ4T3nb5p5kpbwzZ59mjKcosFiFTt19NBGgvjOuPHBhUccHH/NN4qlIiDK+IXjK7xnrLpIW550LvBcwueE=
X-Received: by 2002:a25:7d07:: with SMTP id y7mr22537324ybc.425.1616800894314;
 Fri, 26 Mar 2021 16:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210325065316.3121287-1-yhs@fb.com> <20210325065332.3122473-1-yhs@fb.com>
In-Reply-To: <20210325065332.3122473-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Mar 2021 16:21:23 -0700
Message-ID: <CAEf4BzZ=jWb7KuR6yX+3A4zZUbrgHm=AdxcYVoQ358N5zLGFqw@mail.gmail.com>
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: add option to merge more dwarf
 cu's into one pahole cu
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 24, 2021 at 11:53 PM Yonghong Song <yhs@fb.com> wrote:
>
> This patch added an option "merge_cus", which will permit
> to merge all debug info cu's into one pahole cu.
> For vmlinux built with clang thin-lto or lto, there exist
> cross cu type references. For example, you could have
>   compile unit 1:
>      tag 10:  type A
>   compile unit 2:
>      ...
>        refer to type A (tag 10 in compile unit 1)
> I only checked a few but have seen type A may be a simple type
> like "unsigned char" or a complex type like an array of base types.
>
> There are two different ways to resolve this issue:
> (1). merge all compile units as one pahole cu so tags/types
>      can be resolved easily, or
> (2). try to do on-demand type traversal in other debuginfo cu's
>      when we do die_process().
> The method (2) is much more complicated so I picked method (1).
> An option "merge_cus" is added to permit such an operation.
>
> Merging cu's will create a single cu with lots of types, tags
> and functions. For example with clang thin-lto built vmlinux,
> I saw 9M entries in types table, 5.2M in tags table. The
> below are pahole wallclock time for different hashbits:
> command line: time pahole -J --merge_cus vmlinux
>       # of hashbits            wallclock time in seconds
>           15                       460
>           16                       255
>           17                       131
>           18                       97
>           19                       75
>           20                       69
>           21                       64
>           22                       62
>           23                       58
>           24                       64

What were the numbers for different hashbits without --merge_cus?

>
> Note that the number of hashbits 24 makes performance worse
> than 23. The reason could be that 23 hashbits can cover 8M
> buckets (close to 9M for the number of entries in types table).
> Higher number of hash bits allocates more memory and becomes
> less cache efficient compared to 23 hashbits.
>
> This patch picks # of hashbits 21 as the starting value
> and will try to allocate memory based on that, if memory
> allocation fails, we will go with less hashbits until
> we reach hashbits 15 which is the default for
> non merge-cu case.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  dwarf_loader.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  dwarves.h      |  2 ++
>  pahole.c       |  8 +++++
>  3 files changed, 100 insertions(+)
>

[...]
