Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB84958357D
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 01:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiG0XC6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 19:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiG0XC5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 19:02:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A82420F56;
        Wed, 27 Jul 2022 16:02:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id va17so336424ejb.0;
        Wed, 27 Jul 2022 16:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UccYnvkXJ9TbV8KUpT9J6zIdbsOHqZHbizSjT0errm8=;
        b=fd7BlUYoHTBhaInTSJ/QMQQCFgGZuJA3bxO4XT1o7hw/Zb1p6b/XHgCEJ4DZ3Kno1X
         E382YOICjJf1/0RwQ4bQaU70OocUHcC5FwpsYerBoH7nleD2rzfG6wJ8D2Q4rqyKz3ET
         ljnrYTVYtwDWIQcNVwhkUfbUq54sSUO7jxTz30dPjaMaU5VVw7Hbr1nMKY++NVBfke45
         r9QLkGeCt4/pmrCYN2XCHM+0g0oJYey3hLdnk0tkanaX/65DNA875/QTPXDUgHR9kNUe
         ALYabtNcw+7zx+w1NqHQuex4MgsNZGEoQ5OMldlnVWO8WLtuuCymj+z7nRVQmZzZ4iCL
         Wixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UccYnvkXJ9TbV8KUpT9J6zIdbsOHqZHbizSjT0errm8=;
        b=Iey1VLoo6jA1GKSXY2zD39ZgRGu0fkr+V11psdhAbyDceK/t7raIClGhRqCdc15fcM
         Tp8C1nFhRwdnexy+pLg0hU64PeAzRyGIbMcudiQiMz47/6r8sGoHatw2WD68juFcQcJA
         JthkL4Qk27/ZCbJFyJAz9ppAuvfeMX0wpv3BtAHBsspvaFNGlW0WCptvM+nT+XLHHRll
         CIxeM9R9e6r75wU//vlbZo+y+29KNN68tY5dMjaeNq1x9FAgM1sKX9AanNYFFh2c8uGU
         n5zskqBfKcG+BwGqibTIiYiTieesCeY1dJqJT6QRXRt7/Dy94HaSMNGERv6Hk6kAdtEy
         Os0g==
X-Gm-Message-State: AJIora+QznnEfd6I0XT1+8kkHLT08Ajy3V/VSA6KQBaAwxBQi/pVqC1g
        owGC+oUsMVxbPIsNBvLCqqqrHbXyEeVxYUIO+FY=
X-Google-Smtp-Source: AGRyM1vsQriy8kQ4jAl+BU2ma4HvbVp50hN3UCqA7Lgjqujgb5/tymV/C6dzwIl49zGE7mZtxeYPQ4KXw/bITOBNtfU=
X-Received: by 2002:a17:907:2808:b0:72b:4d49:b2e9 with SMTP id
 eb8-20020a170907280800b0072b4d49b2e9mr20015090ejc.176.1658962974933; Wed, 27
 Jul 2022 16:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
In-Reply-To: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Jul 2022 16:02:43 -0700
Message-ID: <CAEf4BzbWpQS6js5LfS80PkqwDwcLc+NgzfqqUTG-CkLP16shCg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Add bpf_obj_get_opts()
To:     Joe Burton <jevburton.kernel@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Joe Burton <jevburton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 12:40 PM Joe Burton <jevburton.kernel@gmail.com> wrote:
>
> From: Joe Burton <jevburton@google.com>
>
> Add an extensible variant of bpf_obj_get() capable of setting the
> `file_flags` parameter.
>
> This parameter is needed to enable unprivileged access to BPF maps.
> Without a method like this, users must manually make the syscall.
>
> Signed-off-by: Joe Burton <jevburton@google.com>
> ---
>  tools/lib/bpf/bpf.c      | 10 ++++++++++
>  tools/lib/bpf/bpf.h      |  9 +++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 20 insertions(+)
>

I agree that bpf_obj_get_opts should be separate from bpf_get_fd_opts.
Just because both currently have file_flags in them doesn't mean that
they should/will always stay in sync. So two separate opts for two
separate APIs makes sense to me.

So I'd accept this patch, but please see a few small things below and
send v3. Thanks!


> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 5eb0df90eb2b..5acb0e8bd13c 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -578,12 +578,22 @@ int bpf_obj_pin(int fd, const char *pathname)
>  }
>
>  int bpf_obj_get(const char *pathname)
> +{
> +       LIBBPF_OPTS(bpf_obj_get_opts, opts);

if you were doing it this way, here should be an empty line. But
really you can/should just pass NULL instead of opts in this case.

> +       return bpf_obj_get_opts(pathname, &opts);
> +}
> +
> +int bpf_obj_get_opts(const char *pathname, const struct bpf_obj_get_opts *opts)
>  {
>         union bpf_attr attr;
>         int fd;
>
> +       if (!OPTS_VALID(opts, bpf_obj_get_opts))
> +               return libbpf_err(-EINVAL);
> +
>         memset(&attr, 0, sizeof(attr));
>         attr.pathname = ptr_to_u64((void *)pathname);
> +       attr.file_flags = OPTS_GET(opts, file_flags, 0);
>
>         fd = sys_bpf_fd(BPF_OBJ_GET, &attr, sizeof(attr));
>         return libbpf_err_errno(fd);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 88a7cc4bd76f..f31b493b5f9a 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -270,8 +270,17 @@ LIBBPF_API int bpf_map_update_batch(int fd, const void *keys, const void *values
>                                     __u32 *count,
>                                     const struct bpf_map_batch_opts *opts);
>
> +struct bpf_obj_get_opts {
> +       size_t sz; /* size of this struct for forward/backward compatibility */
> +
> +       __u32 file_flags;

please add size_t :0; to avoid non-zero-initialized padding  (we do it
in a lot of other opts structs)


> +};
> +#define bpf_obj_get_opts__last_field file_flags
> +
>  LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
>  LIBBPF_API int bpf_obj_get(const char *pathname);
> +LIBBPF_API int bpf_obj_get_opts(const char *pathname,
> +                               const struct bpf_obj_get_opts *opts);
>
>  struct bpf_prog_attach_opts {
>         size_t sz; /* size of this struct for forward/backward compatibility */
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 0625adb9e888..119e6e1ea7f1 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -355,6 +355,7 @@ LIBBPF_0.8.0 {
>
>  LIBBPF_1.0.0 {
>         global:
> +               bpf_obj_get_opts;
>                 bpf_prog_query_opts;
>                 bpf_program__attach_ksyscall;
>                 btf__add_enum64;
> --
> 2.37.0.170.g444d1eabd0-goog
>
