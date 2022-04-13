Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7EE4FED68
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 05:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiDMDRS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 23:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiDMDRP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 23:17:15 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CCB1A040
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 20:14:54 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id 125so489653iov.10
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 20:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxHx12F8gBdUhebd9k4vF4vKRdBSgZDzcyody6rYruc=;
        b=qvKilS/yBEOCPTSfZU8SPBKXOzxurCcVD5lEUUPiyuKff/Xai6SXSzbTUtFZOT6VVy
         g2pYaUQOyj57Tr7JojrWYjFVBRtY8oD4dzwIkjCni29xwja+J6djl8ibMM+Dkf4IvyQ2
         j5FGtdXQzWGxVMc34U65lTc1U+2piFCwY8OGWulin1xEzs5TcsP4AjYgVwTdrfSnzAbd
         SDsnM7F4sLYDmPjaOZk1ZtCxVk/M7/idcA/Yrnp92CNaiZq0lucMX7PrpRT1Rl+Lhfa0
         zeVcl2CDbl2vy/w+4sSH4Iy3zdUwF0E9L3lNGc4ol2ikxjLzcx67APN2h3fW5MO4jsg9
         ZHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxHx12F8gBdUhebd9k4vF4vKRdBSgZDzcyody6rYruc=;
        b=7MzsUx6aKmLIFi2o1HT0e5l7U3q59XKhjpCTa/vI26ReJ4InWP9PQX2f/QcV1lTBGw
         /ommGePhrIn4EL3oalvnLN/UyW5/DyUBS+YM6DYDBmIgiX9+lLFl/8HFR0g8gVfxaslD
         0uFtQUYg/M/yejRPAALXeIU4imMAUlnEQaKBxerhLfO9FnTNeOkpHa+ptIEk/eT56qSK
         AC6pyDrhbs4c3/X/9km+FQyt2lqKWn0DDeKW7WUoZ79KUu8FyihiHWKZYdPdVilfPVHf
         sTp9QhI0T5OSNb2pt9VYWhXOsofJ17bdYCDId0ByLVlCxOMi51skg13H43kMOJ1n2zwF
         sotA==
X-Gm-Message-State: AOAM532YQwaLuOuzyAjY4RQBW0ZynwxUshWVGqiL3h4w2nTEV0LaRyQZ
        KilgctvefXEVqvRtBpT2Spl2ObAtVGQhaU28X30=
X-Google-Smtp-Source: ABdhPJyhDt9ygGm7IGkxptATEKYbOUg4m2U4UNbl76vOw0WiDW6n9an9JHTNHU8j/JGjhn6uQ+8LUyV/0UpP98HQhp8=
X-Received: by 2002:a05:6602:1683:b0:64f:ba36:d3cf with SMTP id
 s3-20020a056602168300b0064fba36d3cfmr709323iow.144.1649819693901; Tue, 12 Apr
 2022 20:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220412165555.4146407-1-kuifeng@fb.com> <20220412165555.4146407-5-kuifeng@fb.com>
In-Reply-To: <20220412165555.4146407-5-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Apr 2022 20:14:42 -0700
Message-ID: <CAEf4BzajTdMF6Cqt9TivHrT_EKNNtEMD+ygeCNw9p1keUc6B6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] lib/bpf: Assign cookies to links in libbpf.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 12, 2022 at 9:56 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Add a cookie field to the attributes of bpf_link_create().
> Add bpf_program__attach_trace_opts() to attach a cookie to a link.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

Please stick to "libbpf: " prefix for patch subject, we don't use "lib/bpf: "

>  tools/lib/bpf/bpf.c      |  7 +++++++
>  tools/lib/bpf/bpf.h      |  3 +++
>  tools/lib/bpf/libbpf.c   | 33 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 12 ++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  5 files changed, 56 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index cf27251adb92..c2454979c3c4 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -863,6 +863,13 @@ int bpf_link_create(int prog_fd, int target_fd,
>                 if (!OPTS_ZEROED(opts, kprobe_multi))
>                         return libbpf_err(-EINVAL);
>                 break;
> +       case BPF_TRACE_FENTRY:
> +       case BPF_TRACE_FEXIT:
> +       case BPF_MODIFY_RETURN:
> +               attr.link_create.tracing.bpf_cookie = OPTS_GET(opts, tracing.bpf_cookie, 0);
> +               if (!OPTS_ZEROED(opts, tracing))
> +                       return libbpf_err(-EINVAL);
> +               break;
>         default:
>                 if (!OPTS_ZEROED(opts, flags))
>                         return libbpf_err(-EINVAL);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index f4b4afb6d4ba..4cdbabcccefc 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -410,6 +410,9 @@ struct bpf_link_create_opts {
>         __u32 iter_info_len;
>         __u32 target_btf_id;
>         union {
> +               struct {
> +                       __u64 bpf_cookie;
> +               } tracing;
>                 struct {
>                         __u64 bpf_cookie;
>                 } perf_event;
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index bf4f7ac54ebf..8586e1efd780 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11262,6 +11262,39 @@ struct bpf_link *bpf_program__attach_trace(const struct bpf_program *prog)
>         return bpf_program__attach_btf_id(prog);
>  }
>
> +struct bpf_link *bpf_program__attach_trace_opts(const struct bpf_program *prog,
> +                                               const struct bpf_trace_opts *opts)
> +{
> +       char errmsg[STRERR_BUFSIZE];
> +       struct bpf_link *link;
> +       int prog_fd, pfd;
> +

unnecessary empty line, LIBBPF_OPTS is a variable declaration, so keep
it together with other variables

> +       LIBBPF_OPTS(bpf_link_create_opts, link_opts);
> +
> +       prog_fd = bpf_program__fd(prog);
> +       if (prog_fd < 0) {
> +               pr_warn("prog '%s': can't attach before loaded\n", prog->name);
> +               return libbpf_err_ptr(-EINVAL);
> +       }
> +
> +       link = calloc(1, sizeof(*link));
> +       if (!link)
> +               return libbpf_err_ptr(-ENOMEM);
> +       link->detach = &bpf_link__detach_fd;
> +
> +       link_opts.tracing.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> +       pfd = bpf_link_create(prog_fd, 0, prog->expected_attach_type, &link_opts);

so this won't work on old kernels that don't support creating
fentry/fexit links through LINK_CREATE. Let's for now check if
bpf_cookie is zero, then redirect to bpf_program__attach_trace().
Ideally we should perform feature detection of ability to use
LINK_CREATE to attach fentry and have a unified single
bpf_program__attach_btf_id() implementation that will handle all that
internally

> +       if (pfd < 0) {
> +               pfd = -errno;
> +               free(link);
> +               pr_warn("prog '%s': failed to attach: %s\n",
> +                       prog->name, libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
> +               return libbpf_err_ptr(pfd);
> +       }
> +       link->fd = pfd;
> +       return (struct bpf_link *)link;
> +}
> +
>  struct bpf_link *bpf_program__attach_lsm(const struct bpf_program *prog)
>  {
>         return bpf_program__attach_btf_id(prog);
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 63d66f1adf1a..e0dd3f9a5aca 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -563,8 +563,20 @@ bpf_program__attach_tracepoint_opts(const struct bpf_program *prog,
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_raw_tracepoint(const struct bpf_program *prog,
>                                    const char *tp_name);
> +
> +struct bpf_trace_opts {
> +       /* size of this struct, for forward/backward compatibility */
> +       size_t sz;
> +       /* custom user-provided value fetchable through bpf_get_attach_cookie() */
> +       __u64 bpf_cookie;
> +};
> +#define bpf_trace_opts__last_field bpf_cookie
> +
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_trace(const struct bpf_program *prog);
> +LIBBPF_API struct bpf_link *
> +bpf_program__attach_trace_opts(const struct bpf_program *prog, const struct bpf_trace_opts *opts);
> +
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_lsm(const struct bpf_program *prog);
>  LIBBPF_API struct bpf_link *
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 82f6d62176dd..9235da802e31 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -424,6 +424,7 @@ LIBBPF_0.6.0 {
>  LIBBPF_0.7.0 {
>         global:
>                 bpf_btf_load;
> +               bpf_program__attach_trace_opts;

this should go into LIBBPF_0.8.0

>                 bpf_program__expected_attach_type;
>                 bpf_program__log_buf;
>                 bpf_program__log_level;
> --
> 2.30.2
>
