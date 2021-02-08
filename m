Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E78831411F
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 22:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhBHVAP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 16:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhBHU7O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 15:59:14 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032F6C061788
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 12:58:34 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id k4so15972487ybp.6
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 12:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Li8kfNGbkbac1nRqizFCEUxqYF7c+nIJj3A6cCoJH0E=;
        b=f0z82HvMsH/c7l3nLRtKM/SyuNSnwZ/x25vPHyXMTvpvJMxperC9hTUyYVetCPiJlM
         1DQ2RYEcblqk4h5k8uQ/9B6Y7ZWfqg/8Byd5TS+pktjI5MMtDP/n+9A+3uVuMJswq9pu
         Hh+04AmSBtidY8gv3bHHb1aoPp/BW1to4yWDCp8hw13vSe5ZH1jQx5dZm7FO/GO1Sxaj
         xC3Tmn99yzummR8PDOJRymMScal4JEfqGcQyA9XAXIViK6GU5/lHnyapDLixOf4e/s5e
         ZuVSZDc+RJYNH+DpuQkwph28PkKe5XrPy74ceNqD+rRIDwPNGsiZxEt19Rsy1h6KxuSm
         eTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Li8kfNGbkbac1nRqizFCEUxqYF7c+nIJj3A6cCoJH0E=;
        b=j5Mql0bOYuZF/axqUhF4Mdu1JLhWZiBCInLp1XCD4rGvqvqfOkZB36RdqTmk8rrwkR
         mP1bnHCsFHSX4Jm01P0BTHVa84zJNVHSGpeazzN26qmlRAAA9q0ZMmJag0GCaGjggENl
         HuL63X/0Yt7Tw6eDTwGVkHbUzRyL/3EGIZYqvPfnG3C3qqaI1p1UUE/hsu+7KM7SbOoa
         JjC/j7AzgnMwkAgumBpcCUGe8Aw2K+Bu7G9MNK/x8muNqH6jbx5llUQrykqn54QeS8OI
         pecLX0tW8Jx7oRWG8zBve1gWaXNnBQRr/IY2dLVU32SFkFz0LcfFNnatn0RrwBM6ibUx
         XEoQ==
X-Gm-Message-State: AOAM531yTRuMffIlLFs4nry2cTqaKhayykvTvP0KtBKQWQHwVRyggxPN
        1eBs/VAIUmCQ8aPog5VBawOuzrxWuSvb+m4s/i4=
X-Google-Smtp-Source: ABdhPJybzBWEyQE8l/bKA6dlg3FV5Y12kmiTz/dygvvnKgLhTQdk4bCFq40PZpNz8z2Ucg+LTQ5ilaOIWqkjpXjKOgM=
X-Received: by 2002:a25:4b86:: with SMTP id y128mr27890932yba.403.1612817913333;
 Mon, 08 Feb 2021 12:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com> <20210206170344.78399-6-alexei.starovoitov@gmail.com>
In-Reply-To: <20210206170344.78399-6-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 12:58:22 -0800
Message-ID: <CAEf4BzY7RPbVs20p+VyCOC4FZvZYpGpRAXuzmkfPFSOO2BKRbg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/7] bpf: Count the number of times recursion
 was prevented
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 6, 2021 at 9:06 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add per-program counter for number of times recursion prevention mechanism
> was triggered and expose it via show_fdinfo and bpf_prog_info.
> Teach bpftool to print it.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/filter.h         |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           | 14 ++++++++++----
>  kernel/bpf/trampoline.c        | 18 ++++++++++++++++--
>  tools/bpf/bpftool/prog.c       |  5 +++++
>  tools/include/uapi/linux/bpf.h |  1 +
>  6 files changed, 34 insertions(+), 6 deletions(-)
>

[...]

>  static void print_prog_json(struct bpf_prog_info *info, int fd)
> @@ -446,6 +448,9 @@ static void print_prog_header_plain(struct bpf_prog_info *info)
>         if (info->run_time_ns)
>                 printf(" run_time_ns %lld run_cnt %lld",
>                        info->run_time_ns, info->run_cnt);
> +       if (info->recursion_misses)
> +               printf(" recursion_misses %lld",
> +                      info->recursion_misses);

no need for wrapping the line

>         printf("\n");
>  }
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index c001766adcbc..c547ad1ffe43 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -4501,6 +4501,7 @@ struct bpf_prog_info {
>         __aligned_u64 prog_tags;
>         __u64 run_time_ns;
>         __u64 run_cnt;
> +       __u64 recursion_misses;
>  } __attribute__((aligned(8)));
>
>  struct bpf_map_info {
> --
> 2.24.1
>
