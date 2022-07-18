Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F694578D18
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 23:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiGRVuk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 17:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiGRVui (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 17:50:38 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1998FDA
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 14:50:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c3so10937681pfb.13
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u27wz2PCMuVYYB7HICVQ28Lin1veQrrJpBv68Mte6sw=;
        b=pAHT/4wQsN1037mdKqH7SN5eIImP9H7JRUFzZk0usOzy7EyhEqSdAq3FdYP0CKGk9O
         PzZZI1eqUkRw98kEjDWtZ8PlnBGXc0uAMeOjt9RwhyFdXXPWHI6SrKjLlY8F1/UZAj73
         BIC3PJzt5KgRRffqUio2MipR4fON7lsjaV3Z+/J6x73skVJo76PnF3KRsm881BwVrVuC
         lgWUNIoq++vT+vpzMiIIGnq4zme7LRjKEYtPXh2n2BSI2DlSeSurJobLpmKmmvjGIP09
         opxEkY5g+9TucHWoKYqC2JwmiDlcvSbUHWtXtHTMMwdTIfd97DV2bXA3YzV4Num8Wc7h
         p0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u27wz2PCMuVYYB7HICVQ28Lin1veQrrJpBv68Mte6sw=;
        b=TzC5VDoMI+cz4Ymd+byNLRIVix+Q8BWQz1ICN8QKgSE8ECEcHzWFt27XvkHCyw0c6j
         PfOKi0DPWg1VfoYTYQG71TG9+LWaWeCwsnJO/RQoXbzYaVa8vnUOzyjbvGlMe8wGqbDX
         XOkaxwMrCITDbh/ghoI7/kNLacZqD+vP/gT8bZ6TsP/3lSsyEaFvow0ZlBUA6mibgwAj
         3JwouvNFtx7uurC3hz43F/iFz8JaFU/6MDo6LaUX6q7mVDKvndHTSNu0cDIzWeGUr5h8
         DawmhsE96GKjPCOEhvgI4fJIoCGf28cwegGlrPb+GXFJiGbwqfrqVDBDjQPzmUY16+iz
         qLSg==
X-Gm-Message-State: AJIora++ghQiRb+cfcyxREtPt16OEWih/x2+Zx8PkhoCEIUvctzk/bOm
        zLNeRkCovN4HuoI/DY2FBzj6i7emLK0XUWOdJO1+3g==
X-Google-Smtp-Source: AGRyM1tlTCM/JJii+zM5EszvzDhrl5iKnWO79jqEL8k8xRiUlrm/pBfOTtdspOniakM/eRek/7LlMk+VK50EyjYx/PY=
X-Received: by 2002:a63:85c6:0:b0:412:a94c:16d0 with SMTP id
 u189-20020a6385c6000000b00412a94c16d0mr26759268pgd.253.1658181037079; Mon, 18
 Jul 2022 14:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220718214633.3951533-1-jevburton.kernel@gmail.com>
In-Reply-To: <20220718214633.3951533-1-jevburton.kernel@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 18 Jul 2022 14:50:26 -0700
Message-ID: <CAKH8qBuAR2A4wyL7Xe_OY-pq_VaRRrP_e-P5py=rwf22mfr1VA@mail.gmail.com>
Subject: Re: [PATCH] [PATCH bpf-next] libbpf: Add bpf_obj_get_opts()
To:     Joe Burton <jevburton.kernel@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Burton <jevburton@google.com>
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

On Mon, Jul 18, 2022 at 2:46 PM Joe Burton <jevburton.kernel@gmail.com> wrote:
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
>  tools/lib/bpf/bpf.c | 10 ++++++++++
>  tools/lib/bpf/bpf.h |  9 +++++++++

Needs a libbpf.map change as well?

>  2 files changed, 19 insertions(+)
>
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
> --
> 2.37.0.170.g444d1eabd0-goog
>
