Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86E473717
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 22:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243439AbhLMV4n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 16:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbhLMV4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 16:56:42 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC38EC061574
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 13:56:41 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id v138so41758723ybb.8
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 13:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGy0TN6+96/UVpKGGKNbatGClyJPa2XP9VQiUU8MrZQ=;
        b=EGVKcmJeIsqu97WiqyEsV6Y8sBjUdgzA+9Vi1clXvA1Z+BJoWYi9G2dAbzca87R0lp
         kbTe+cAx1MIzS3Pg4oBnIFqdIGD/f8rHg7IC5PTGl3EYmOO6+4lyHyEwOIZ/Jm6LMOxH
         MzsFoqBTuu2534eUZSDLqsJ1+6EY1NTKoz4l77zwn9ao95uhhXLu9uqAW8u2T7R2B5FJ
         jpLEIbzvoJqYUz+Z875WgwrK2oATVWaHtuW0GX1mbPFaYmT3bswiFlyJcHxIubEVsWyd
         Uy3lTd199qtVgcBTq6X685rZ+1EnkQbVQFdD7SWypYjQ/ve7lu2/vQvDrdOY+qtRGJVp
         t5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGy0TN6+96/UVpKGGKNbatGClyJPa2XP9VQiUU8MrZQ=;
        b=YdXCSl+7QfFIEpy7U0RwpOntiHurQjieYS0REvL6Aqgvh7IS5QGuqXTC7k4nGN5Vva
         JoPF1EKH+AhDUgCSFL6wDYzNbrttomGvanV6wsC9xOz9jqFO0fvyj5xqZOH4dp/2bw6t
         o9A2uFTAshMuinq0o+ZdeVwoaVOnIW+W0JeClWW1Rd1dJQYFuWRLM+PCMECwJnGz0aA9
         4dnkC/W/BbByRdDoAOk+2qiDzdJ8e6BaeNzupyseJfIwCJanYBzZ3/Sjcw4roitsdtQ+
         tW+l2uBFCE4gwiVCK5S4CD9xLgftqc6zKOvzwx2HruBqEZvt2nyHvC/asPP+ftTRO7n2
         nMuQ==
X-Gm-Message-State: AOAM531HzUKK+Mk0IWODjZcazDfrW3rmL8bBAABIlIpbSuysCBUfjoXU
        yCTDbCLndlqbMKrnO/PfVzybvK7eU29YYXGHnLo70JybY9M=
X-Google-Smtp-Source: ABdhPJyOV/0gHXNIwIsFdxJzgIV1gh3x1PZCjXj3JavyW5Aem4fUn6rpCfubzZkrehe/J4VRC0VjFCNkkgzY1Fciadw=
X-Received: by 2002:a25:e406:: with SMTP id b6mr1363689ybh.529.1639432600942;
 Mon, 13 Dec 2021 13:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20211209232222.541733-1-grantseltzer@gmail.com>
In-Reply-To: <20211209232222.541733-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Dec 2021 13:56:30 -0800
Message-ID: <CAEf4BzZQ-BgZi57LHOgrLRdsmLwPAPNp_RG6SEKnTcnP=d_ukQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add doc comments for bpf_program__(un)pin()
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 9, 2021 at 3:23 PM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds doc comments for the two bpf_program pinning functions,
> bpf_program__pin() and bpf_program__unpin()
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---

Applied to bpf-next with few minor tweaks. Thanks.

>  tools/lib/bpf/libbpf.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 4802c1e73..d6518f30a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -299,7 +299,31 @@ LIBBPF_DEPRECATED_SINCE(0, 7, "multi-instance bpf_program support is deprecated"
>  LIBBPF_API int bpf_program__unpin_instance(struct bpf_program *prog,
>                                            const char *path,
>                                            int instance);
> +
> +/**
> + * @brief **bpf_program__pin()** pins the BPF program to a file
> + * in the BPFFS specified by a path. This increments the programs
> + * reference count, allowing it to stay loaded after the process
> + * which loaded it has exited.
> + *
> + * @param prog BPF program to pin, must already be loaded
> + * @param path filepath in a BPF Filesystem
> + * @return int error code, 0 if no error (errno is also set to error)
> + */
>  LIBBPF_API int bpf_program__pin(struct bpf_program *prog, const char *path);
> +
> +/**
> + * @brief **bpf_program__unpin()** unpins the BPF program from a file
> + * in the BPFFS specified by a path. This decrements the programs
> + * reference count.
> + *
> + * The file pinning the BPF program can also be unlinked by a different
> + * process in which case this function will return an error
> + *
> + * @param prog BPF program to unpin
> + * @param path filepath to the pin in a BPF Filesystem
> + * @return int error code, 0 if no error (errno is also set to error)
> + */
>  LIBBPF_API int bpf_program__unpin(struct bpf_program *prog, const char *path);
>  LIBBPF_API void bpf_program__unload(struct bpf_program *prog);
>
> --
> 2.33.1
>
