Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B9958552B
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 20:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiG2Swx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 14:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbiG2Swu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 14:52:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F993342F
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 11:52:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id tk8so10045388ejc.7
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mZ2b2EwO68gzeF0dud6kpAgJmvEVQsvJXL301aTZC+s=;
        b=O5c6AM7zKgiAkk9PD+TOfU8lpoCDPtW089gVv8t6NzM2UlKURvNv7snKLIhC+EZ87f
         /+gSG2t6A9Ygi0mDm+En/1+E+GAVdt6U1AsqwmqD4zuK9YF6LTBhNdm/97Iamip5w6F9
         aNEiLBfllLUJu3lvE1EOxmz9/QfiC2EYDKnXNvByLxIM5+qk37R6HMTM1X/YaMwNniVN
         L1RwzNnuH+MUsD7/U2gJ4oLcH6zqq1cnEfc5R9uZwZ9F55RON9qKB4s+4UTZJzj/jPd5
         692J/wVcnd/FMsDg1RXyqcA5+b71t/56IG1KEyCyHdLCfAP3bAnrFoVS5N+JDGDxXRKV
         7fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mZ2b2EwO68gzeF0dud6kpAgJmvEVQsvJXL301aTZC+s=;
        b=ewRffqkNF+H3dVjX94hM4YAkZL2DV2wNq5MVYaPJ0HgUfT+y+KFxd0/HbeIhXMj/5I
         3OxRsjjJ6MPv9mVw8lj+km24s+MzbmB0ZF9poDevU2Nx9qmhvkeA0NFIw+i+bmi36C7U
         SkQwt4AsfPb+JyqBhB6OHp70XX26IjFXTG/uEaz1OhLRzYCdTMrVygQHRWQqaeK9PKQw
         WpzQibEwti62FeGNhI6CHH7v+4e8bsJH15DwlUdUlMSwWw0LpVzG14wsBbrxbKlQ2r2k
         tO/O2bhIKN+vWfKATf6cYvocQJP8HhqHeC7G7ebpqY+J7s/f7aQSAFDXwiUZ6J2LUs2D
         7Ijw==
X-Gm-Message-State: AJIora9G+aHPNUlzShzwelQfNOkgjh2z712G680i4wdmjoxUr7Ue3t48
        vHRbH4zcV9nfd/n942f7XWx2v1a5KJ4QAHgcuGo=
X-Google-Smtp-Source: AGRyM1vprt5gB0gwpgHkcmSMoZ4BlXmowPKr1COndNGWf8lbYm9xMODrEqE00R7bjUJxxRtQnzhzKACZaQ8tN/NPgRo=
X-Received: by 2002:a17:907:2ccc:b0:72b:6907:fce6 with SMTP id
 hg12-20020a1709072ccc00b0072b6907fce6mr3932286ejc.115.1659120766954; Fri, 29
 Jul 2022 11:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171836.2852247-1-roberto.sassu@huawei.com> <20220722171836.2852247-5-roberto.sassu@huawei.com>
In-Reply-To: <20220722171836.2852247-5-roberto.sassu@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 29 Jul 2022 11:52:35 -0700
Message-ID: <CAEf4BzY3fpn1BzhMzJTMi+7+77kyJdsg0QRHQdXX7kx5gUXF9w@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 04/15] libbpf: Introduce bpf_map_get_fd_by_id_opts()
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        bpf <bpf@vger.kernel.org>
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

On Fri, Jul 22, 2022 at 10:19 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> Introduce bpf_map_get_fd_by_id_opts(), to let the caller pass a
> bpf_get_fd_opts structure with flags set to the permissions necessary to
> perform the operations on the obtained file descriptor.
>
> Don't check FEAT_GET_FD_BY_ID_OPEN_FLAGS, as current kernels already take
> open_flags as last bpf_attr field for this request.
>
> Keep the existing bpf_map_get_fd_by_id(), and call
> bpf_map_get_fd_by_id_opts() with NULL as opts argument, to request
> read-write permissions.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  tools/lib/bpf/bpf.c      | 12 +++++++++++-
>  tools/lib/bpf/bpf.h      |  2 ++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9014a61bca83..4b574ad046f3 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -957,18 +957,28 @@ int bpf_prog_get_fd_by_id(__u32 id)
>         return bpf_prog_get_fd_by_id_opts(id, NULL);
>  }
>
> -int bpf_map_get_fd_by_id(__u32 id)
> +int bpf_map_get_fd_by_id_opts(__u32 id,
> +                             const struct bpf_get_fd_opts *opts)
>  {
>         union bpf_attr attr;
>         int fd;
>
> +       if (!OPTS_VALID(opts, bpf_get_fd_opts))
> +               return libbpf_err(-EINVAL);
> +
>         memset(&attr, 0, sizeof(attr));
>         attr.map_id = id;
> +       attr.open_flags = OPTS_GET(opts, flags, 0);
>
>         fd = sys_bpf_fd(BPF_MAP_GET_FD_BY_ID, &attr, sizeof(attr));
>         return libbpf_err_errno(fd);
>  }
>
> +int bpf_map_get_fd_by_id(__u32 id)
> +{
> +       return bpf_map_get_fd_by_id_opts(id, NULL);
> +}
> +
>  int bpf_btf_get_fd_by_id(__u32 id)
>  {
>         union bpf_attr attr;
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index bc241343a0f9..d4b84d3f7e16 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -366,6 +366,8 @@ LIBBPF_API int bpf_link_get_next_id(__u32 start_id, __u32 *next_id);
>  LIBBPF_API int bpf_prog_get_fd_by_id_opts(__u32 id,
>                                           const struct bpf_get_fd_opts *opts);
>  LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
> +LIBBPF_API int bpf_map_get_fd_by_id_opts(__u32 id,
> +                                        const struct bpf_get_fd_opts *opts);
>  LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
>  LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
>  LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index ab818612a585..83dc18b5e5cf 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -365,4 +365,5 @@ LIBBPF_1.0.0 {
>                 libbpf_bpf_prog_type_str;
>                 perf_buffer__buffer;
>                 bpf_prog_get_fd_by_id_opts;
> +               bpf_map_get_fd_by_id_opts;

keep in mind that this list is alphabetically sorted

>  };
> --
> 2.25.1
>
