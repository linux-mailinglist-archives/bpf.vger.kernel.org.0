Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DEF508EEC
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 19:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbiDTR66 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 13:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiDTR65 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 13:58:57 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6B043AD1
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:56:10 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n134so2684363iod.5
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1P8pCcGZkjv8z33dNwx/IRkriefq+CN2IVgWn8/warw=;
        b=CNa5wFV8DVA29f2gtEOqGnHhPijfYsfvp9pd2MOLL+Si08OzKPqCXvHaUb8T9Elc4x
         fGRAkYjjIU5Ebv44VeLd7cdlkaUawZ3WwXvRWJt/U0cQsxdDDgD5kuKqVbe7iRBQrUlr
         XL84gBRPitnquuaMDwsBuLE0JRcH8/OfOM4VYIiKviuK3YMXTGe4C9B1RFqmA4OL+HV4
         bJr8L/MXOwHDRI0QDxRE7uEGd93T359GCJ7PHjT8nUACoGumTyWQDO23KV/fXlCcuLIn
         y7w3N1XlbHgnup45X6Kyo5OYEmeKpCHZeD7Jys0BbM1eckgPssOmsGgc4jFrfBgubZ55
         66GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1P8pCcGZkjv8z33dNwx/IRkriefq+CN2IVgWn8/warw=;
        b=YHUaik4Ruk0Udf2a/N80FnMaWEOiZ+8l6pBvN+Ymbv8oVWCA6HXJjLAQbkfuTYGIaN
         jqt62w0Inyxi4X6LLVMd+nTUWTSNwu5XbHc45hbEI/7IjbSNBnWeLInPijeJGNSd4Csz
         MsUhVZt9ejye6NwJvq89Bkjg8aj7K6fs//iHvR1moTewPM40tvQ7YhscduJ0WHFk8ZSd
         PsgNptVGx26+bN2ptA+vLv0aZDKK2Yw3GRKZuza/ldXjgSBCWJsgqU4wI1iHO/uns9RI
         /AdtIqxI+44J87gCAvUhmjSvqYSl+qt+PozwUlzQgADBIlItpdfRSFaw6Y/T0guUqWu3
         VeMA==
X-Gm-Message-State: AOAM532Gu/o9madux/mKy3hkyd+8Ox70fJ5IHHJehhzhPDbHB1WpnmUU
        Vj7Czaz3dIYcxx7Skj22SNZFlz69UB7J9L64g5pL8WrJBT0=
X-Google-Smtp-Source: ABdhPJxTa4nqQnwaOKyR9N+L0WJJm40avISpEgME94rZpL8hp/ulGLhOuWzRbHd1VSffXAVeC5Hjh5rzjf0Sw4LDBC4=
X-Received: by 2002:a5d:9f4e:0:b0:652:2323:2eb8 with SMTP id
 u14-20020a5d9f4e000000b0065223232eb8mr9437571iot.79.1650477369675; Wed, 20
 Apr 2022 10:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220416042940.656344-1-kuifeng@fb.com> <20220416042940.656344-6-kuifeng@fb.com>
In-Reply-To: <20220416042940.656344-6-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Apr 2022 10:55:58 -0700
Message-ID: <CAEf4BzbCZSVjTC2_VRj6WO4FZ0Gu8HAs6Ume2ZW+7piU9XCy1A@mail.gmail.com>
Subject: Re: [PATCH dwarves v6 5/6] libbpf: Assign cookies to links in libbpf.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, Apr 15, 2022 at 9:30 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Add a cookie field to the attributes of bpf_link_create().
> Add bpf_program__attach_trace_opts() to attach a cookie to a link.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  tools/lib/bpf/bpf.c      |  7 +++++++
>  tools/lib/bpf/bpf.h      |  3 +++
>  tools/lib/bpf/libbpf.c   | 38 ++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 12 ++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  5 files changed, 61 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index cf27251adb92..1a96fd9b1da9 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -863,6 +863,13 @@ int bpf_link_create(int prog_fd, int target_fd,
>                 if (!OPTS_ZEROED(opts, kprobe_multi))
>                         return libbpf_err(-EINVAL);
>                 break;
> +       case BPF_TRACE_FENTRY:
> +       case BPF_TRACE_FEXIT:
> +       case BPF_MODIFY_RETURN:

also EXT and LSM programs should go through this

> +               attr.link_create.tracing.cookie = OPTS_GET(opts, tracing.cookie, 0);
> +               if (!OPTS_ZEROED(opts, tracing))
> +                       return libbpf_err(-EINVAL);
> +               break;
>         default:
>                 if (!OPTS_ZEROED(opts, flags))
>                         return libbpf_err(-EINVAL);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index f4b4afb6d4ba..2f9099c945bc 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -410,6 +410,9 @@ struct bpf_link_create_opts {
>         __u32 iter_info_len;
>         __u32 target_btf_id;
>         union {
> +               struct {
> +                       __u64 cookie;
> +               } tracing;

nit: append at the end of the union?

>                 struct {
>                         __u64 bpf_cookie;
>                 } perf_event;
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index bf4f7ac54ebf..7e18fe94bfe5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11262,6 +11262,44 @@ struct bpf_link *bpf_program__attach_trace(const struct bpf_program *prog)
>         return bpf_program__attach_btf_id(prog);
>  }
>
> +struct bpf_link *bpf_program__attach_trace_opts(const struct bpf_program *prog,
> +                                               const struct bpf_trace_opts *opts)
> +{
> +       char errmsg[STRERR_BUFSIZE];
> +       struct bpf_link *link;
> +       int prog_fd, pfd;
> +       LIBBPF_OPTS(bpf_link_create_opts, link_opts);
> +
> +       /* Fallback for cookie is 0.  Old kernels don't create
> +        * fentry/fexit links through LINK_CREATE.
> +        */
> +       if (OPTS_GET(opts, cookie, 0))
> +               return bpf_program__attach_trace(prog);

With my (planned) changes this special casing won't be necessary
anymore as using bpf_link_create() will call into
bpf_raw_tracepoint_open() on older kernels if cookie is zero
(transparently).

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
> +       link_opts.tracing.cookie = OPTS_GET(opts, cookie, 0);
> +       pfd = bpf_link_create(prog_fd, 0, prog->expected_attach_type, &link_opts);
> +       if (pfd < 0) {
> +               pfd = -errno;
> +               free(link);
> +               pr_warn("prog '%s': failed to attach: %s\n",
> +                       prog->name, libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
> +               return libbpf_err_ptr(pfd);
> +       }
> +       link->fd = pfd;
> +       return (struct bpf_link *)link;

just return link? why casting?

> +}
> +
>  struct bpf_link *bpf_program__attach_lsm(const struct bpf_program *prog)
>  {
>         return bpf_program__attach_btf_id(prog);
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 63d66f1adf1a..213de69bc173 100644
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
> +       __u64 cookie;
> +};
> +#define bpf_trace_opts__last_field cookie
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
> index 82f6d62176dd..245a0e8677c9 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -444,6 +444,7 @@ LIBBPF_0.8.0 {
>         global:
>                 bpf_object__destroy_subskeleton;
>                 bpf_object__open_subskeleton;
> +               bpf_program__attach_trace_opts;
>                 bpf_program__attach_usdt;
>                 libbpf_register_prog_handler;
>                 libbpf_unregister_prog_handler;
> --
> 2.30.2
>
