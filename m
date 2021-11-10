Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9968B44BAD1
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 05:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhKJEZt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 23:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhKJEZs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 23:25:48 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0877DC061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 20:23:02 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id g17so3017530ybe.13
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 20:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbnhDVOUA9hprof4CGtr/Hi/r78XQKLAxpzGMOQfSw0=;
        b=GIB3vDao1cm+xKPP1GEzSC7cKsU94dwWFjPWXhOUupNOPp8FohjU5nJlEm8iAYelJs
         aNMWIQcNbepwLNBkQVx6fK8AI3BIfmdrZfdJym3+v3mkMHIhjLHLYzSdD13xYvg/v9gf
         03QHYLu6Q6eML1PqMgiJbGQ60H7hKmqZvNfWxhNMMhSHB5J5/sy9hd31VC6SkIYfdl1F
         2+Jj1blAp5bd7fKj3hB+SB0FonGwdvDSeKKuRLxXS8X8Q+6DtgBrTDd4ctSCK2rHcPHY
         DSeTlzj38mAE5pCZIrN1DNLKIWYVootI9phY2itzUYnXTDvyC8hvXkoVuNSYseYbf7Mj
         6mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbnhDVOUA9hprof4CGtr/Hi/r78XQKLAxpzGMOQfSw0=;
        b=z47OaQk2DYhNpPvDgoTK2F9Z6U/2NC7l3pyAv5ikMnmLIbJJ+gbvVlljM+C5/IsDuj
         bjo0tzK4gjmD3NhBxQhUZUftor2DzqYMLMzLpH0rjONmvD4HXC18T1hW0FGT8N+3cnoM
         b1wPmZXOv4xpZklkZj3i5xSik6R/cIWo9JE2Nk7K1KNGImDUOS5vbw69Y+FgK9kwxUYz
         ntI0i7d8ZXi7tvho+2l/jH8sAdmzPx+Jq3DzoRlWbIU2L0qVJUHKqc4vFi72hcOxBqiO
         uldAdA30NHhnsVOOZufnBMPrGq8CHhKH8sU+TQta5TWHuI37fIphmAkUQYQ8C+4Tba77
         3hTQ==
X-Gm-Message-State: AOAM533nLnXnpIC4REWsSE+QrhoIGfIE4W3J9FqmDZaJXZP6ZJipkJ/c
        l6ezORcKrE4w0gRypwcS142EjF2kwXv/KPFKTVY=
X-Google-Smtp-Source: ABdhPJxM9LCQjyyURRuA2zJXsfWQ44xNd2F7N1dIUj47OO+Osj/hX/qYnyRE8qDrWoE5VFFd5arwjasVYUTpp7Kg4C4=
X-Received: by 2002:a05:6902:1023:: with SMTP id x3mr14421827ybt.267.1636518181184;
 Tue, 09 Nov 2021 20:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20211109021624.1140446-1-haoluo@google.com> <20211109021624.1140446-5-haoluo@google.com>
In-Reply-To: <20211109021624.1140446-5-haoluo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Nov 2021 20:22:50 -0800
Message-ID: <CAEf4Bzarzr6-DnR1cgwzw2OYEfW9-M93FwT6NMtzQc6JTVgUtg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 4/9] bpf: Remove ARG_CONST_SIZE_OR_ZERO
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 8, 2021 at 6:16 PM Hao Luo <haoluo@google.com> wrote:
>
> Remove ARG_CONST_SIZE_OR_ZERO and use flag to mark that the
> argument may be zero.
>
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  include/linux/bpf.h      |  2 -
>  kernel/bpf/helpers.c     | 20 +++++++--
>  kernel/bpf/ringbuf.c     |  5 ++-
>  kernel/bpf/stackmap.c    | 15 +++++--
>  kernel/bpf/verifier.c    |  8 ++--
>  kernel/trace/bpf_trace.c | 90 ++++++++++++++++++++++++++++++++--------
>  net/core/filter.c        | 35 ++++++++++++----
>  7 files changed, 135 insertions(+), 40 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index dd92418814b5..27f81989f992 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -323,8 +323,6 @@ struct bpf_arg_type {
>                                          */
>
>                 ARG_CONST_SIZE,         /* number of bytes accessed from memory */
> -               ARG_CONST_SIZE_OR_ZERO, /* number of bytes accessed from memory or 0 */
> -
>                 ARG_PTR_TO_CTX,         /* pointer to context */
>                 ARG_PTR_TO_CTX_OR_NULL, /* pointer to context or NULL */
>                 ARG_ANYTHING,           /* any (initialized) argument is ok */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cd792777afb2..082a8620f666 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -631,7 +631,10 @@ const struct bpf_func_proto bpf_event_output_data_proto =  {
>         .arg2           = { .type = ARG_CONST_MAP_PTR },
>         .arg3           = { .type = ARG_ANYTHING },
>         .arg4           = { .type = ARG_PTR_TO_MEM },
> -       .arg5           = { .type = ARG_CONST_SIZE_OR_ZERO },
> +       .arg5           = {
> +               .type = ARG_CONST_SIZE,
> +               .flag = ARG_FLAG_MAYBE_NULL,

wait, OR_NULL and OR_ZERO isn't exactly the same thing... why are we
conflating them?

> +       },
>  };
>
>  BPF_CALL_3(bpf_copy_from_user, void *, dst, u32, size,

[...]
