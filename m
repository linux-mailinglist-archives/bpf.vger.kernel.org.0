Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3786A2CB1F8
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 02:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgLBBCC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 20:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgLBBCC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 20:02:02 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4F0C0613CF;
        Tue,  1 Dec 2020 17:01:21 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id o71so100569ybc.2;
        Tue, 01 Dec 2020 17:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Odv4zRt1KHT39evbyQRVAXDLOsIsZ8X++QuLSoooG/Y=;
        b=uUEL4mPshv29R4UIPc6B9LFcY39jrOba/FrFIgIrq6nOI0GWjXGxRROwNpCzw2az7F
         IvPSHar90O1yiOO2hd3DYIepYygVjcI4E5PSgvDOX+obQ31tmEK3zgiRi2Zmo8+IP1SJ
         YsWeyOIqgIeQthJ1edKTbrvstEFoDpDlqmg0feXd4/qRchksnvGDr/H1lh9j7USetAaq
         2PEBOQLRVVVsLrNzohbw5vyxt6TBQFHaDq6x88sIz5VKTXmptq9Qd0aB9ZsI6rDkRqIp
         GOaCkOGA5U5oesghz5Ai8EJJ2kjUTu7ZqFXfzw+8aqRKzpYNL1p6foj8JTP85+zoBsbG
         eenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Odv4zRt1KHT39evbyQRVAXDLOsIsZ8X++QuLSoooG/Y=;
        b=D8FHH+h6SdQHAeLFy0ys/fCNe4k49Lw4Dr1AXPaPD59XmsdlEzwa+619pheKTR5QJ+
         BMNemcpzT2h9N75KwpWrZERTjcvU4dHdMaGgNObl6Eyk8HCN15NclNTFhqbO6WRvFLHm
         ZxkCot+H/v1v988ma0XHiR+40reicwMZ5NV2GUH47bPpTU9kLkTi3DfggkDHU7TPjTl0
         /AuPe+z9UXTyhvKivy2yqBOjC/ePrJZSH8Xc20SZhzhpu16z3fxswlQt8U2LSdtg+K/e
         7knuWrXZzXWELlxV4l+dFH2UhgOIwj5oTygOEtJZnGj9McwHSR4yMSl+9x+vTMExGB7k
         3c2w==
X-Gm-Message-State: AOAM531MZsPQ5EYIu0gpgNQ98sLwPe9gbJmyG18rCls4sjlfdZjVtyHX
        d4i/xOrm5y9Y09ASYimm7wcYcIx4YF0JHc42FR8=
X-Google-Smtp-Source: ABdhPJzWAkFmvDydQdFttT11ARr/BMHPaffy5oVh/yeV78OMjXE6vyJ0VF2Fcvh5fDYAwtWD51Mh353s7bRgoWkox0c=
X-Received: by 2002:a25:585:: with SMTP id 127mr88820ybf.425.1606870881067;
 Tue, 01 Dec 2020 17:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20201126170212.1749137-1-revest@google.com> <20201126170212.1749137-2-revest@google.com>
In-Reply-To: <20201126170212.1749137-2-revest@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Dec 2020 17:01:10 -0800
Message-ID: <CAEf4Bzb+u4S7toVi64=LKBAhe1K6-+G3S1MYE+mq_TnpDoCg8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Add a selftest for the tracing bpf_get_socket_cookie
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 26, 2020 at 9:02 AM Florent Revest <revest@chromium.org> wrote:
>
> This builds up on the existing socket cookie test which checks whether
> the bpf_get_socket_cookie helpers provide the same value in
> cgroup/connect6 and sockops programs for a socket created by the
> userspace part of the test.
>
> Adding a tracing program to the existing objects requires a different
> attachment strategy and different headers.
>
> Signed-off-by: Florent Revest <revest@google.com>
> ---
>  .../selftests/bpf/progs/socket_cookie_prog.c  | 41 ++++++++++++++++---
>  .../selftests/bpf/test_socket_cookie.c        | 18 +++++---
>  2 files changed, 49 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
> index 0cb5656a22b0..a11026aeaaf1 100644
> --- a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
> +++ b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
> @@ -1,11 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2018 Facebook
>
> -#include <linux/bpf.h>
> -#include <sys/socket.h>
> +#include "vmlinux.h"
>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_endian.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#define AF_INET6 10
>
>  struct socket_cookie {
>         __u64 cookie_key;
> @@ -19,6 +21,14 @@ struct {
>         __type(value, struct socket_cookie);
>  } socket_cookies SEC(".maps");
>
> +/*
> + * These three programs get executed in a row on connect() syscalls. The
> + * userspace side of the test creates a client socket, issues a connect() on it
> + * and then checks that the local storage associated with this socket has:
> + * cookie_value == local_port << 8 | 0xFF
> + * The different parts of this cookie_value are appended by those hooks if they
> + * all agree on the output of bpf_get_socket_cookie().
> + */
>  SEC("cgroup/connect6")
>  int set_cookie(struct bpf_sock_addr *ctx)
>  {
> @@ -32,14 +42,14 @@ int set_cookie(struct bpf_sock_addr *ctx)
>         if (!p)
>                 return 1;
>
> -       p->cookie_value = 0xFF;
> +       p->cookie_value = 0xF;
>         p->cookie_key = bpf_get_socket_cookie(ctx);
>
>         return 1;
>  }
>
>  SEC("sockops")
> -int update_cookie(struct bpf_sock_ops *ctx)
> +int update_cookie_sockops(struct bpf_sock_ops *ctx)
>  {
>         struct bpf_sock *sk;
>         struct socket_cookie *p;
> @@ -60,11 +70,32 @@ int update_cookie(struct bpf_sock_ops *ctx)
>         if (p->cookie_key != bpf_get_socket_cookie(ctx))
>                 return 1;
>
> -       p->cookie_value = (ctx->local_port << 8) | p->cookie_value;
> +       p->cookie_value |= (ctx->local_port << 8);
>
>         return 1;
>  }
>
> +SEC("fexit/inet_stream_connect")
> +int BPF_PROG(update_cookie_tracing, struct socket *sock,
> +            struct sockaddr *uaddr, int addr_len, int flags)
> +{
> +       struct socket_cookie *p;
> +
> +       if (uaddr->sa_family != AF_INET6)
> +               return 0;
> +
> +       p = bpf_sk_storage_get(&socket_cookies, sock->sk, 0, 0);
> +       if (!p)
> +               return 0;
> +
> +       if (p->cookie_key != bpf_get_socket_cookie(sock->sk))
> +               return 0;
> +
> +       p->cookie_value |= 0xF0;
> +
> +       return 0;
> +}
> +
>  int _version SEC("version") = 1;

please remove this, while you are at it

>
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/test_socket_cookie.c b/tools/testing/selftests/bpf/test_socket_cookie.c
> index ca7ca87e91aa..0d955c65a4f8 100644
> --- a/tools/testing/selftests/bpf/test_socket_cookie.c
> +++ b/tools/testing/selftests/bpf/test_socket_cookie.c
> @@ -133,6 +133,7 @@ static int run_test(int cgfd)
>         struct bpf_prog_load_attr attr;
>         struct bpf_program *prog;
>         struct bpf_object *pobj;
> +       struct bpf_link *link;
>         const char *prog_name;
>         int server_fd = -1;
>         int client_fd = -1;
> @@ -153,11 +154,18 @@ static int run_test(int cgfd)
>         bpf_object__for_each_program(prog, pobj) {
>                 prog_name = bpf_program__section_name(prog);
>
> -               if (libbpf_attach_type_by_name(prog_name, &attach_type))
> -                       goto err;
> -
> -               err = bpf_prog_attach(bpf_program__fd(prog), cgfd, attach_type,
> -                                     BPF_F_ALLOW_OVERRIDE);
> +               if (bpf_program__is_tracing(prog)) {
> +                       link = bpf_program__attach(prog);
> +                       err = !link;

link is a pointer, so use libbpf_get_error()

> +                       continue;
> +               } else {

else branch is not really necessary, just adds indentation unnecessarily

> +                       if (libbpf_attach_type_by_name(prog_name, &attach_type))
> +                               goto err;
> +
> +                       err = bpf_prog_attach(bpf_program__fd(prog), cgfd,
> +                                             attach_type,
> +                                             BPF_F_ALLOW_OVERRIDE);
> +               }
>                 if (err) {
>                         log_err("Failed to attach prog %s", prog_name);
>                         goto out;
> --
> 2.29.2.454.gaff20da3a2-goog
>
