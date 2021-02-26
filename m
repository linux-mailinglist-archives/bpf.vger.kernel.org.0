Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE5D32674C
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 20:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhBZTPZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 14:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZTPX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 14:15:23 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C1CC06174A
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 11:14:42 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id n195so9935678ybg.9
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 11:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xlGbCQdcPMBdKtmbjltdpbm5zxU0DNp1r546dvrOlOs=;
        b=sVnYi6ANvUlQlRAbVwxKUSauPxFNfRnoDPvo7C6+JzbFVZqhX+K75pUVH4o+Gp4fGA
         xIZnoC4k5p/rTIcwAiVRwSSZRBmgHv8lag0isWdmI48rppeapHeqT/d59oleiC5jQFqe
         dOc51GMUZXxKo7BiHJusCHlYqBwJtv0ZzBKhbKYZGaj+vav7Fm7vVmNpOmPX+FbLy82u
         qGf/fazYx6X5g7RVODuojpfEPK6kdIV0K1dfk8cBriHDa6YJLivGLNF0PtyLvUHhgd3A
         756pjVoX48bhPHHuBuZDqXXel2X2DUZqLpMtGxRsTTft4TiwCenTf9g0KcWAPbuim5FD
         Tziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlGbCQdcPMBdKtmbjltdpbm5zxU0DNp1r546dvrOlOs=;
        b=VE/NNcipss7jCB9I5yAOLUvaHBwUnL3RR2wYQbB43W9T8JUGMwsseTJOhmZ6BIRi3Q
         6eYpuXuWRlp/ZPwSbkGqcdcHcLCKIaiaIzCafKr7Brr+qMcbsPp1x2rAe7lgkYDAHEKV
         Xk69ceck3wEwsw2NVpxYTzu7r7TPVx2c/uYOn6Ft7jq6CAZi+3Lu3vAygBc8Q4+ndkOs
         O68q0icUgyXzwVZLwHdhazkm9PscH59uKxddtJC+IB67jpS0iqr52v9JTld2AKz/2g7k
         n5XOUb0m9OmcYuAv8+cFn+O9qXOZe3x/bLXG/FkWnZqtdiF7djuYxoOfwl6GA+JhAv6D
         b/mQ==
X-Gm-Message-State: AOAM531AVeOxLnIByknNuNsYRIzneR9p/OzSFvwYY7w3AWnBQh67guN1
        lJRZn2AIPgw8eE3Hr70lbxvKEg52uBPEKgIzYtU=
X-Google-Smtp-Source: ABdhPJw5jeBCgFmvGKBoEf5WBwcgnBfXnJCBVMU7LjtQI2HavaQ+TOxsbX0kh0DjbLuZdL5l0pK1oETsTzYBgoRDNfY=
X-Received: by 2002:a25:bd12:: with SMTP id f18mr6740885ybk.403.1614366882215;
 Fri, 26 Feb 2021 11:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20210226051305.3428235-1-yhs@fb.com> <20210226051309.3428543-1-yhs@fb.com>
In-Reply-To: <20210226051309.3428543-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Feb 2021 11:14:31 -0800
Message-ID: <CAEf4BzZMx_uE+jS2-g5por0Nmi8gysG8Pfk78RU-VqSzc-pkwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 04/12] bpf: change return value of verifier
 function add_subprog()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 9:17 PM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, verifier function add_subprog() returns 0 for success
> and negative value for failure. Change the return value
> to be the subprog number for success. This functionality will be
> used in the next patch to save a call to find_subprog().
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

great.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3fc5d1b28b6c..dd860ce1f591 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1530,7 +1530,7 @@ static int add_subprog(struct bpf_verifier_env *env, int off)
>         }
>         ret = find_subprog(env, off);
>         if (ret >= 0)
> -               return 0;
> +               return ret;
>         if (env->subprog_cnt >= BPF_MAX_SUBPROGS) {
>                 verbose(env, "too many subprograms\n");
>                 return -E2BIG;
> @@ -1538,7 +1538,7 @@ static int add_subprog(struct bpf_verifier_env *env, int off)
>         env->subprog_info[env->subprog_cnt++].start = off;
>         sort(env->subprog_info, env->subprog_cnt,
>              sizeof(env->subprog_info[0]), cmp_subprogs, NULL);
> -       return 0;
> +       return env->subprog_cnt - 1;
>  }
>
>  static int check_subprogs(struct bpf_verifier_env *env)
> --
> 2.24.1
>
