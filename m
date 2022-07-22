Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B857E620
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiGVR6k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiGVR6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:58:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB1C85FAF
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:58:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w7so5139676ply.12
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AuKD7y/rXaAroCkDZ0udhQpHRESGG3CPv4qWM1HMdBI=;
        b=DIFYoLnIylEpQmGfMjGZ7qr7Npk8helFn1Xtfs+m7pc2F62Pmd8+RhhWtVC2Oi1leq
         SqpIUVeX/m8an1I6nd8DLTXhdvB6AGRTBMezTXfVcTdThAU3+5MGVeBgD0MoZ4C9+H3Q
         9p1vQZCNdDYNfVBEJmedBrLQ6BmP9v3BJJ/MkrCyv3fZegK35xkTLen7Tp3vobpcnJL6
         51srSeARQN+AYz76i+ZvLuoZf1TF161NHuhgYLuG208kZfGeyFu4+uhcY2Q27hPhYm7e
         BO9Xqlu98dsK+jFMjwvYEEEZ2Yc5pTlATj65bkMqPRIIzoydENsJ105WyK0Joipg9aH/
         YA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AuKD7y/rXaAroCkDZ0udhQpHRESGG3CPv4qWM1HMdBI=;
        b=6QjI/NJeZ/Orx7jRZij17pJqAbCOdTi5MLBVtWprHTkhJZUCxpIZLhpkQSNxJKEvaG
         U/tgfNWjBFdntzDvz1vlCIYJA9Rx1i8w2Bsh0V4F2mtTEQ7BIEj0u/H2nVKe2z86zE1J
         ndII+z/uX0bkqPxuewsWNRR2QW+iP4jG4oA5nFrmGZZ2R1iBWB0Kb4oLDUV4j91/EG2c
         fbWQoRD2na8DLbwVxdQtGa1mrsO3Gm0ADGFEKWwqqwYtV+uwynGhcrdJMnNvW3iIOBKn
         4hXE6Phg0KrzQaOYP1/3UL8o1HytxLauDmwmFXFYdcwj85AoMjeWRt6D5QeyFXV3bP93
         g2LQ==
X-Gm-Message-State: AJIora+GDVHyYwQU+6qlMSIoQfaIUe0T8/cfjv5lrbawQU8n1VZTltQx
        gdryxdrWv9uQF+9auYubA03UIBo9GRUcZHIxkPqQNg==
X-Google-Smtp-Source: AGRyM1t0ESclAhXBPSI/3lXbthg2P5d0oZMfTpS8M/ow50DxaEpt8Mg6NJdoPEXy7c0xKgBPhgTnuRlh/CU6Teep7ug=
X-Received: by 2002:a17:90b:4b01:b0:1f0:1aa7:928 with SMTP id
 lx1-20020a17090b4b0100b001f01aa70928mr789324pjb.195.1658512717338; Fri, 22
 Jul 2022 10:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171836.2852247-1-roberto.sassu@huawei.com> <20220722171836.2852247-8-roberto.sassu@huawei.com>
In-Reply-To: <20220722171836.2852247-8-roberto.sassu@huawei.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 22 Jul 2022 10:58:26 -0700
Message-ID: <CAKH8qBuU4TORtzu-SQg-2y8iAgFe31fLBX2joby2eWJdoXGd2A@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 07/15] libbpf: Introduce bpf_obj_get_opts()
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        jevburton.kernel@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 10:20 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> Introduce bpf_obj_get_opts(), to let the caller pass the needed permissions
> for the operation. Keep the existing bpf_obj_get() to request read-write
> permissions.
>
> bpf_obj_get() allows the caller to get a file descriptor from a pinned
> object with the provided pathname. Specifying permissions has only effect
> on maps (for links, the permission must be always read-write).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  tools/lib/bpf/bpf.c      | 12 +++++++++++-
>  tools/lib/bpf/bpf.h      |  2 ++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 5f2785a4c358..0df088890864 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -577,18 +577,28 @@ int bpf_obj_pin(int fd, const char *pathname)
>         return libbpf_err_errno(ret);
>  }
>
> -int bpf_obj_get(const char *pathname)
> +int bpf_obj_get_opts(const char *pathname,
> +                    const struct bpf_get_fd_opts *opts)

I'm still not sure whether it's a good idea to mix get_fd with
obj_get/pin operations? [1] seems more clear.
It just so happens that (differently named) flags in BPF_OBJ_GET and
BPF_XXX_GET_FD_BY_ID align, but maybe we shouldn't depend on it?

Also, it seems only bpf_map_get_fd_by_id currently accepts flags? So
this sharing makes even more sense?

[1] https://lore.kernel.org/bpf/20220719194028.4180569-1-jevburton.kernel@gmail.com/





>  {
>         union bpf_attr attr;
>         int fd;
>
> +       if (!OPTS_VALID(opts, bpf_get_fd_opts))
> +               return libbpf_err(-EINVAL);
> +
>         memset(&attr, 0, sizeof(attr));
>         attr.pathname = ptr_to_u64((void *)pathname);
> +       attr.file_flags = OPTS_GET(opts, flags, 0);
>
>         fd = sys_bpf_fd(BPF_OBJ_GET, &attr, sizeof(attr));
>         return libbpf_err_errno(fd);
>  }
>
> +int bpf_obj_get(const char *pathname)
> +{
> +       return bpf_obj_get_opts(pathname, NULL);
> +}
> +
>  int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
>                     unsigned int flags)
>  {
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index b75fd9d37bad..e0c5018cc131 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -279,6 +279,8 @@ struct bpf_get_fd_opts {
>  };
>  #define bpf_get_fd_opts__last_field flags
>
> +LIBBPF_API int bpf_obj_get_opts(const char *pathname,
> +                               const struct bpf_get_fd_opts *opts);
>  LIBBPF_API int bpf_obj_get(const char *pathname);
>
>  struct bpf_prog_attach_opts {
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index dba97d2ef8a9..55516b19e22f 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -368,4 +368,5 @@ LIBBPF_1.0.0 {
>                 bpf_map_get_fd_by_id_opts;
>                 bpf_btf_get_fd_by_id_opts;
>                 bpf_link_get_fd_by_id_opts;
> +               bpf_obj_get_opts;
>  };
> --
> 2.25.1
>
