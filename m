Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA000485EDB
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 03:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbiAFChx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 21:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344887AbiAFChw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 21:37:52 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB08CC061201
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 18:37:51 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id o1so854950ilo.6
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 18:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAVM0VZszj+UURGWv9ATzaiUdv3MqwGCiPD3WyG69/c=;
        b=eSjRt4lh2200fIn4YCggRXOzKKcW/WQMJASGLgZuqdHcwXvItmpk5c/zy5nUHk8nL1
         VRy6pM6PWlH0IDI2zoRTxsdDQ0PPgAv8989Ri/GPzagYA6g2LwC37dz9xXDZPOOXYYvR
         1haH0o+kdQTkHuZoIGz0uxRD7+33MZPnL8VSQyDkCa8I/DXFU2uiJixj7GYGVHokwBAT
         72j11pvSDpou9XwhD5yhTUEE3j6QEGtHvQVStdJVqD8Q7lBVr4DCcfeOjleh+i+GDsGx
         LxjHLVWQyQDucsQLSKJ9BTeNzNrS/wyKUC7FrI76gLFoIrcO3CH4F3iQMhjZE+29HS8q
         aILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAVM0VZszj+UURGWv9ATzaiUdv3MqwGCiPD3WyG69/c=;
        b=yWZ24Zg6EX5HVCulVF7Jz1YXi7o5rv39jlNsKSFqui2hvU78qW2mAspwjHc3JZHR+O
         cKi5rbPUfzhAOstKNWVExmc92B5ord4jaj9MLCZk2Dx1mSPpIknXY1x0gl9t9QcoSdzP
         QPTQuh7pfsjFRkFIMMnekNvq1FP0r7jqMkfqhndMzLJm51h8hqWiWxCg/tW1L3NIFTix
         aGsT+GlmmRWEzSCOzQGMQhG1R7Q0TYEPTKREUZVyFj6d57wp33rgp7ACl6ibHzC5qTxk
         jOBm0G4MPByVBgONmCtx+OkyYcwIqzcOvDG9dq3yY1iN4vQp9v5IPeaCyY9+24Fl1ot0
         n4gA==
X-Gm-Message-State: AOAM532RJXZkikGjVi9s/Q074P2BERcAmJdhdGKGHe6tUwi7/Xsba3I+
        fGBlhHjfTMITfu99zJBNGKMg5Z52dTrb3HC9TQcIozPm
X-Google-Smtp-Source: ABdhPJyTNBlhwWWLxrhvlCx578mUJQmxA9DcBhOjnB9Zl1ByJ3i/WFnVbRRLLiv3r5yFdIj0eD7PyRx3AQfhQQvJIj4=
X-Received: by 2002:a05:6e02:1c01:: with SMTP id l1mr27652441ilh.239.1641436670899;
 Wed, 05 Jan 2022 18:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20211225203717.35718-1-grantseltzer@gmail.com>
In-Reply-To: <20211225203717.35718-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jan 2022 18:37:40 -0800
Message-ID: <CAEf4BzbZn7s3nHrXd=ruLSmiQ-VSU46R62hCTaprEe60bKF_oA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Add documentation for bpf_map batch operations
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 25, 2021 at 12:37 PM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds documentation for:
>
> - bpf_map_delete_batch()
> - bpf_map_lookup_batch()
> - bpf_map_lookup_and_delete_batch()
> - bpf_map_update_batch()
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>  tools/lib/bpf/bpf.c |   4 +-
>  tools/lib/bpf/bpf.h | 112 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 112 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9b64eed2b003..25f3d6f85fe5 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -691,7 +691,7 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
>         return libbpf_err_errno(ret);
>  }
>
> -int bpf_map_delete_batch(int fd, void *keys, __u32 *count,
> +int bpf_map_delete_batch(int fd, const void *keys, __u32 *count,
>                          const struct bpf_map_batch_opts *opts)
>  {
>         return bpf_map_batch_common(BPF_MAP_DELETE_BATCH, fd, NULL,
> @@ -715,7 +715,7 @@ int bpf_map_lookup_and_delete_batch(int fd, void *in_batch, void *out_batch,
>                                     count, opts);
>  }
>
> -int bpf_map_update_batch(int fd, void *keys, void *values, __u32 *count,
> +int bpf_map_update_batch(int fd, const void *keys, const void *values, __u32 *count,
>                          const struct bpf_map_batch_opts *opts)
>  {
>         return bpf_map_batch_common(BPF_MAP_UPDATE_BATCH, fd, NULL, NULL,
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 00619f64a040..01011747f127 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -254,20 +254,128 @@ struct bpf_map_batch_opts {
>  };
>  #define bpf_map_batch_opts__last_field flags
>
> -LIBBPF_API int bpf_map_delete_batch(int fd, void *keys,
> +
> +/**
> + * @brief **bpf_map_delete_batch()** allows for batch deletion of multiple
> + * elements in a BPF map.
> + *
> + * @param fd BPF map file descriptor
> + * @param keys pointer to an array of *count* keys
> + * @param count number of elements in the map to sequentially delete

it's important to mention that count is updated after
bpf_map_delete_batch() returns with the actual number of elements that
were deleted. Please double-check the other APIs as well whether there
are important points to mention. These batch APIs are one of the
trickiest ones in bpf() syscall, let's do a thorough job documenting
them so that users don't have to read kernel code each time they want
to use it

But other than that, great job! I've CC'ed Yonghong to take another
look, as he should know the semantics of batch APIs much better.
Yonghong, please take a look when you can. Thanks!


> + * @param opts options for configuring the way the batch deletion works
> + * @return 0, on success; negative error code, otherwise (errno is also set to
> + * the error code)
> + */
> +LIBBPF_API int bpf_map_delete_batch(int fd, const void *keys,
>                                     __u32 *count,
>                                     const struct bpf_map_batch_opts *opts);

[...]
