Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3927594BF5
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2019 19:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfHSRpR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Aug 2019 13:45:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41301 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfHSRpR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Aug 2019 13:45:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id i4so2817587qtj.8;
        Mon, 19 Aug 2019 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5C10SdTw9UsRHE8mSdMz/uk/aS8BfPDdbX4rmEYHzaw=;
        b=ruGTsG/TOkpqLtT4WJgHDJ3Li4k/0DKSh1BviEgQ+FsLLotDrvs270uzLeikm/Ukg9
         5sGCjXhebL7oYW0ZcFdP859ObgBvX6TvdljAkRmfi58IpdxTtfdiXE7NxFzmcmiqIF7Z
         wcX9aWUW6/PSxjPwf9YU1FS/jKGYB+G6RZSrQerdzNXe45tb8GHkSVSse4VXK8n4PH5K
         fqnqtrxUC7KOOkrarpC/YVVukR/w0tewaStiH9HPyBuae2zknD8tcA1mRcC9v2voe8Bs
         bJl3hYg/4GmgL6hiJP1jHkXQEBEvNOky7qXmyk739IMiV4Y124Tq+qCbuBBQhyY7kxAY
         cypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5C10SdTw9UsRHE8mSdMz/uk/aS8BfPDdbX4rmEYHzaw=;
        b=s5IrA1Ynv9znvMEC0x8SZVR7YwSW7uOpOGBjC/C8nu5bNhQuRtLujgEu7CoB3+YdkI
         LI8xAck6vnuHDZZrw5rxYkge0yg17VXWEJYd/jJsPJi9ihbwqqUlEDhw+F53ZdmTdSdx
         cfXTNfyZWv6i5M7ne0OH1747rDyJGft401Jqzk3SBbPI2SpDJRs20dRJpBx+0CigKJPv
         czl1ql4EqzLwJFSkPQtQa2LfQIzEcvOkLlChd9+whfxmk33ZMH0ZoBFsfc5CIS4LHAhj
         GjlkCEFz6ihN4i2avD/b9xZ0s6U3EQM5k9L+z1LyJAmZuw9mdBZPtbTBNmg3hp4zEQVT
         Vk+Q==
X-Gm-Message-State: APjAAAUEWbkcTOfY3pOnpetzH5t1NffLdfCmyfDKTLfGLhQe96pU7v8a
        vmiwL3J3G9A/I2oAw77t+uWtV4wcde1GbYzBep0=
X-Google-Smtp-Source: APXvYqwr+fVhJ35Czwd9Xb4pyCZvoPQ3OvIzy3HfnL8UCcUYIw9PumcFsf5+UeWyKZypIa4kmZo4EYeoClXHJkGXS4g=
X-Received: by 2002:ad4:56a2:: with SMTP id bd2mr3096857qvb.162.1566236716058;
 Mon, 19 Aug 2019 10:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190816223149.5714-1-dxu@dxuuu.xyz> <20190816223149.5714-3-dxu@dxuuu.xyz>
In-Reply-To: <20190816223149.5714-3-dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 19 Aug 2019 10:45:05 -0700
Message-ID: <CAEf4BzYbckCr2mxgsAn0z-fi-jxjvL5RGF4vdCLdfWgOzQfb-A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/4] libbpf: Add helpers to extract perf fd
 from bpf_link
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        alexander.shishkin@linux.intel.com, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 16, 2019 at 3:32 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> It is sometimes necessary to perform ioctl's on the underlying perf fd.
> There is not currently a way to extract the fd given a bpf_link, so add a
> a pair of casting and getting helpers.
>
> The casting and getting helpers are nice because they let us define
> broad categories of links that makes it clear to users what they can
> expect to extract from what type of link.
>
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

This looks great, thanks a lot!

I think you might have a conflict with dadb81d0afe7 ("libbpf: make
libbpf.map source of truth for libbpf version") in libbpf.map, so you
might need to pull, rebase and re-post rebased version. But in any
case:

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/libbpf.c   | 21 +++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 13 +++++++++++++
>  tools/lib/bpf/libbpf.map |  4 ++++
>  3 files changed, 38 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2233f919dd88..41588e13be2b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4876,6 +4876,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
>
>  struct bpf_link {
>         int (*destroy)(struct bpf_link *link);
> +       enum bpf_link_type type;
>  };
>
>  int bpf_link__destroy(struct bpf_link *link)
> @@ -4909,6 +4910,24 @@ static int bpf_link__destroy_perf_event(struct bpf_link *link)
>         return err;
>  }
>
> +const struct bpf_link_fd *bpf_link__as_fd(const struct bpf_link *link)
> +{
> +       if (link->type != LIBBPF_LINK_FD)
> +               return NULL;
> +
> +       return (struct bpf_link_fd *)link;
> +}
> +
> +enum bpf_link_type bpf_link__type(const struct bpf_link *link)
> +{
> +       return link->type;
> +}
> +
> +int bpf_link_fd__fd(const struct bpf_link_fd *link)
> +{
> +       return link->fd;
> +}
> +
>  struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
>                                                 int pfd)
>  {
> @@ -4932,6 +4951,7 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
>         if (!link)
>                 return ERR_PTR(-ENOMEM);
>         link->link.destroy = &bpf_link__destroy_perf_event;
> +       link->link.type = LIBBPF_LINK_FD;
>         link->fd = pfd;
>
>         if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
> @@ -5225,6 +5245,7 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
>         link = malloc(sizeof(*link));
>         if (!link)
>                 return ERR_PTR(-ENOMEM);
> +       link->link.type = LIBBPF_LINK_FD;
>         link->link.destroy = &bpf_link__destroy_fd;
>
>         pfd = bpf_raw_tracepoint_open(tp_name, prog_fd);
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index e8f70977d137..2ddef5315ff9 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -166,7 +166,20 @@ LIBBPF_API int bpf_program__pin(struct bpf_program *prog, const char *path);
>  LIBBPF_API int bpf_program__unpin(struct bpf_program *prog, const char *path);
>  LIBBPF_API void bpf_program__unload(struct bpf_program *prog);
>
> +enum bpf_link_type {
> +       LIBBPF_LINK_FD,
> +};
> +
>  struct bpf_link;
> +struct bpf_link_fd;
> +
> +/* casting APIs */
> +LIBBPF_API const struct bpf_link_fd *
> +bpf_link__as_fd(const struct bpf_link *link);
> +
> +/* getters APIs */
> +LIBBPF_API enum bpf_link_type bpf_link__type(const struct bpf_link *link);
> +LIBBPF_API int bpf_link_fd__fd(const struct bpf_link_fd *link);
>
>  LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
>
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 4e72df8e98ba..ee9945177100 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -186,4 +186,8 @@ LIBBPF_0.0.4 {
>  } LIBBPF_0.0.3;
>
>  LIBBPF_0.0.5 {
> +       global:
> +               bpf_link__type;
> +               bpf_link__as_fd;
> +               bpf_link_fd__fd;
>  } LIBBPF_0.0.4;
> --
> 2.20.1
>
