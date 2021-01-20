Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F762FD68F
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 18:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391804AbhATRKA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 12:10:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391043AbhATRIq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 12:08:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF2962242A
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 17:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611162486;
        bh=6Am6P3ap6VUQy1vl3nzntFQfX3lYi9qaI7SwEtBxFD0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cnTIneAyfJ09wKIolqvaVE6JK5UQ6gwHqz+zHqnLjp72E+ayq6lBBwx47xgMkTUDw
         JWryQDkWP+DKhjBZtLjbijXb3Cz+5oFdWM0A3a15tb8dq59MG+vS7tHMJUyWSG36g9
         ucK3DLa+nUyk9bUJM+yC9vgsty8yhZkmlqj6moVkfIG/m9umX0ufRHSyxGjxf1kPZL
         X70okYsrxamrQING36d9co5KRW7iLClpLtlXtU0xnFYRdV1T/Squrj4m4arvL71l2U
         qpEk0rLDAgIRJWgpMEoMes2BCAuhhVORHRz8z0Qjx/yPaqztaKy/gUKal6dfXurMh3
         h8o5YT4Ce+bBw==
Received: by mail-ej1-f54.google.com with SMTP id gx5so15295656ejb.7
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 09:08:05 -0800 (PST)
X-Gm-Message-State: AOAM530Pa6Vj9ChQ5y/UaVELkiuXj8h5TU8Fx3jyqNDQ3LnF8ij2pN+F
        hMNGetSi1c3mX28TyeAPATW7iLq3H/v9+hlnpLfyPA==
X-Google-Smtp-Source: ABdhPJyLYTTjQmBgXSRzAlaWqoG5zvh2eUjL0fMqRA6Fi0YUQxXH1mQi21xAk/KgG5faNdlS2r9wRurffjvaiPpTs1k=
X-Received: by 2002:a17:906:4302:: with SMTP id j2mr6747215ejm.217.1611162484245;
 Wed, 20 Jan 2021 09:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20210119155953.803818-1-revest@chromium.org> <20210119155953.803818-4-revest@chromium.org>
In-Reply-To: <20210119155953.803818-4-revest@chromium.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 20 Jan 2021 18:07:52 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6fNvYCO4cnU2XispQkF-_3yToDGgB=aRRd9m+qy0gpWA@mail.gmail.com>
Message-ID: <CACYkzJ6fNvYCO4cnU2XispQkF-_3yToDGgB=aRRd9m+qy0gpWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add a selftest for the
 tracing bpf_get_socket_cookie
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 19, 2021 at 5:00 PM Florent Revest <revest@chromium.org> wrote:
>
> This builds up on the existing socket cookie test which checks whether
> the bpf_get_socket_cookie helpers provide the same value in
> cgroup/connect6 and sockops programs for a socket created by the
> userspace part of the test.
>
> Adding a tracing program to the existing objects requires a different
> attachment strategy and different headers.
>
> Signed-off-by: Florent Revest <revest@chromium.org>

Acked-by: KP Singh <kpsingh@kernel.org>

(one minor note, doesn't really need fixing as a part of this though)

> ---
>  .../selftests/bpf/prog_tests/socket_cookie.c  | 24 +++++++----
>  .../selftests/bpf/progs/socket_cookie_prog.c  | 41 ++++++++++++++++---
>  2 files changed, 52 insertions(+), 13 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> index 53d0c44e7907..e5c5e2ea1deb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> @@ -15,8 +15,8 @@ struct socket_cookie {
>
>  void test_socket_cookie(void)
>  {
> +       struct bpf_link *set_link, *update_sockops_link, *update_tracing_link;
>         socklen_t addr_len = sizeof(struct sockaddr_in6);
> -       struct bpf_link *set_link, *update_link;
>         int server_fd, client_fd, cgroup_fd;
>         struct socket_cookie_prog *skel;
>         __u32 cookie_expected_value;
> @@ -39,15 +39,21 @@ void test_socket_cookie(void)
>                   PTR_ERR(set_link)))
>                 goto close_cgroup_fd;
>
> -       update_link = bpf_program__attach_cgroup(skel->progs.update_cookie,
> -                                                cgroup_fd);
> -       if (CHECK(IS_ERR(update_link), "update-link-cg-attach", "err %ld\n",
> -                 PTR_ERR(update_link)))
> +       update_sockops_link = bpf_program__attach_cgroup(
> +               skel->progs.update_cookie_sockops, cgroup_fd);
> +       if (CHECK(IS_ERR(update_sockops_link), "update-sockops-link-cg-attach",
> +                 "err %ld\n", PTR_ERR(update_sockops_link)))
>                 goto free_set_link;
>
> +       update_tracing_link = bpf_program__attach(
> +               skel->progs.update_cookie_tracing);
> +       if (CHECK(IS_ERR(update_tracing_link), "update-tracing-link-attach",
> +                 "err %ld\n", PTR_ERR(update_tracing_link)))
> +               goto free_update_sockops_link;
> +
>         server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
>         if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
> -               goto free_update_link;
> +               goto free_update_tracing_link;
>
>         client_fd = connect_to_fd(server_fd, 0);
>         if (CHECK(client_fd < 0, "connect_to_fd", "errno %d\n", errno))
> @@ -71,8 +77,10 @@ void test_socket_cookie(void)
>         close(client_fd);
>  close_server_fd:
>         close(server_fd);
> -free_update_link:
> -       bpf_link__destroy(update_link);
> +free_update_tracing_link:
> +       bpf_link__destroy(update_tracing_link);

I don't think this need to block submission unless there are other
issues but the
bpf_link__destroy can just be called in a single cleanup label because
it handles null or
erroneous inputs:

int bpf_link__destroy(struct bpf_link *link)
{
    int err = 0;

    if (IS_ERR_OR_NULL(link))
         return 0;
[...]
