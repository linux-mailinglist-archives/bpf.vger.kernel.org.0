Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4822FD90C
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 20:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392528AbhATTE5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 14:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390158AbhATTEo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 14:04:44 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479A3C061757;
        Wed, 20 Jan 2021 11:04:04 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id q8so3982657lfm.10;
        Wed, 20 Jan 2021 11:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fm0Hune4dNh4DOhGPxu2dYoVCrCb/uIZAh+4vIDWr2I=;
        b=kVr0nUi6g0Bm5Cg8a06zoKCBxjsWFjviGBrGKpnbU/P+zXo0vucIbqa26agJ7qIWAG
         gB7VG8ZXr8MzYOPHzFIMSnYEtXR6e8/PTE3IYRcUwHpCmQ8qlr3/mBUoW6SvKMev3hnC
         R9AeVTXIhEFLFjwjh3Ldon+H3OTITvGBUZjnB3PmLsj6PNz1XzYYMoUrp93qN8tS3fzj
         dd8Q6+pEIjZEhXk4AoeZEVVgp1fmLbL5yb6HMGX4RHYmLEA5ouCe3e0utz7yf8URouxh
         NF1qQtzfLSHWCg9Rx3viBvLmnoBgXg76h3TcyQ6xvDiOFac+vkB3/uhrpByNb2LJQoBW
         JgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fm0Hune4dNh4DOhGPxu2dYoVCrCb/uIZAh+4vIDWr2I=;
        b=EAzy2HoRrDNlnGPGL/i8xsDwcNaF6xdMwTP8uDnsClOtUxSzd6OsCecq04REZfE7yE
         iVBLhcjj2IjFwjVlSg5ph0E9xeCtXj0KS8IcD0cBSfMl/Lia28ULyxgbFBMHHN68d0UL
         QRYKVteQYjbNOwDOjDeQXYFh7dc3rCfkFYJIVaz7Qq0QHI27e8wncMYKZ9h9J4J6ey22
         MRDzTfkuEvj+ugy0Z3bb4LsyV8bKo4+q3qssjpy3lZsF1ZFvZCbrGhCBFyZapYU32d2M
         Ld1UuEvdyPdoK5k5nqomdKeASxeNAbwsGIHWFvRCbFhvQs9UYe3IgBqq4/yuwAzdFc7+
         7oeg==
X-Gm-Message-State: AOAM533FFFvads0WmpDVUdgScHFmYAq4GD+OqPChKGlsHFe69qH9ss3Z
        5TCY4vNrmjuiVrhx7zGFO9reSKmQXQ+uVCRjf3c=
X-Google-Smtp-Source: ABdhPJwauJhTvStLKvK4f+JIHYvgdtTIGz+ocEjGBQlFWFov/l9TwvzW2/CEFoTWCyjsWKSr2bi5buNmKOhMa4aPjms=
X-Received: by 2002:ac2:5b1e:: with SMTP id v30mr5218306lfn.540.1611169442795;
 Wed, 20 Jan 2021 11:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20210119155953.803818-1-revest@chromium.org> <20210119155953.803818-4-revest@chromium.org>
 <CACYkzJ6fNvYCO4cnU2XispQkF-_3yToDGgB=aRRd9m+qy0gpWA@mail.gmail.com>
In-Reply-To: <CACYkzJ6fNvYCO4cnU2XispQkF-_3yToDGgB=aRRd9m+qy0gpWA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 20 Jan 2021 11:03:51 -0800
Message-ID: <CAADnVQJqVEvwF3GJyuiazxUUknBUaZ_k7gtt-m18hbBdoVeTGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add a selftest for the
 tracing bpf_get_socket_cookie
To:     KP Singh <kpsingh@kernel.org>
Cc:     Florent Revest <revest@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 20, 2021 at 9:08 AM KP Singh <kpsingh@kernel.org> wrote:
>
> On Tue, Jan 19, 2021 at 5:00 PM Florent Revest <revest@chromium.org> wrote:
> >
> > This builds up on the existing socket cookie test which checks whether
> > the bpf_get_socket_cookie helpers provide the same value in
> > cgroup/connect6 and sockops programs for a socket created by the
> > userspace part of the test.
> >
> > Adding a tracing program to the existing objects requires a different
> > attachment strategy and different headers.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
>
> Acked-by: KP Singh <kpsingh@kernel.org>
>
> (one minor note, doesn't really need fixing as a part of this though)
>
> > ---
> >  .../selftests/bpf/prog_tests/socket_cookie.c  | 24 +++++++----
> >  .../selftests/bpf/progs/socket_cookie_prog.c  | 41 ++++++++++++++++---
> >  2 files changed, 52 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> > index 53d0c44e7907..e5c5e2ea1deb 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> > @@ -15,8 +15,8 @@ struct socket_cookie {
> >
> >  void test_socket_cookie(void)
> >  {
> > +       struct bpf_link *set_link, *update_sockops_link, *update_tracing_link;
> >         socklen_t addr_len = sizeof(struct sockaddr_in6);
> > -       struct bpf_link *set_link, *update_link;
> >         int server_fd, client_fd, cgroup_fd;
> >         struct socket_cookie_prog *skel;
> >         __u32 cookie_expected_value;
> > @@ -39,15 +39,21 @@ void test_socket_cookie(void)
> >                   PTR_ERR(set_link)))
> >                 goto close_cgroup_fd;
> >
> > -       update_link = bpf_program__attach_cgroup(skel->progs.update_cookie,
> > -                                                cgroup_fd);
> > -       if (CHECK(IS_ERR(update_link), "update-link-cg-attach", "err %ld\n",
> > -                 PTR_ERR(update_link)))
> > +       update_sockops_link = bpf_program__attach_cgroup(
> > +               skel->progs.update_cookie_sockops, cgroup_fd);
> > +       if (CHECK(IS_ERR(update_sockops_link), "update-sockops-link-cg-attach",
> > +                 "err %ld\n", PTR_ERR(update_sockops_link)))
> >                 goto free_set_link;
> >
> > +       update_tracing_link = bpf_program__attach(
> > +               skel->progs.update_cookie_tracing);
> > +       if (CHECK(IS_ERR(update_tracing_link), "update-tracing-link-attach",
> > +                 "err %ld\n", PTR_ERR(update_tracing_link)))
> > +               goto free_update_sockops_link;
> > +
> >         server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
> >         if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
> > -               goto free_update_link;
> > +               goto free_update_tracing_link;
> >
> >         client_fd = connect_to_fd(server_fd, 0);
> >         if (CHECK(client_fd < 0, "connect_to_fd", "errno %d\n", errno))
> > @@ -71,8 +77,10 @@ void test_socket_cookie(void)
> >         close(client_fd);
> >  close_server_fd:
> >         close(server_fd);
> > -free_update_link:
> > -       bpf_link__destroy(update_link);
> > +free_update_tracing_link:
> > +       bpf_link__destroy(update_tracing_link);
>
> I don't think this need to block submission unless there are other
> issues but the
> bpf_link__destroy can just be called in a single cleanup label because
> it handles null or
> erroneous inputs:
>
> int bpf_link__destroy(struct bpf_link *link)
> {
>     int err = 0;
>
>     if (IS_ERR_OR_NULL(link))
>          return 0;
> [...]

+1 to KP's point.

Also Florent, how did you test it?
This test fails in CI and in my manual run:
./test_progs -t cook
libbpf: load bpf program failed: Permission denied
libbpf: -- BEGIN DUMP LOG ---
libbpf:
; int update_cookie_sockops(struct bpf_sock_ops *ctx)
0: (bf) r6 = r1
; if (ctx->family != AF_INET6)
1: (61) r1 = *(u32 *)(r6 +20)
; if (ctx->family != AF_INET6)
2: (56) if w1 != 0xa goto pc+21
 R1_w=inv10 R6_w=ctx(id=0,off=0,imm=0) R10=fp0
; if (ctx->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
3: (61) r1 = *(u32 *)(r6 +0)
; if (ctx->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
4: (56) if w1 != 0x3 goto pc+19
 R1_w=inv3 R6_w=ctx(id=0,off=0,imm=0) R10=fp0
; if (!ctx->sk)
5: (79) r1 = *(u64 *)(r6 +184)
; if (!ctx->sk)
6: (15) if r1 == 0x0 goto pc+17
 R1_w=sock(id=0,ref_obj_id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
; p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
7: (79) r2 = *(u64 *)(r6 +184)
; p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
8: (18) r1 = 0xffff888106e41400
10: (b7) r3 = 0
11: (b7) r4 = 0
12: (85) call bpf_sk_storage_get#107
R2 type=sock_or_null expected=sock_common, sock, tcp_sock, xdp_sock, ptr_
processed 12 insns (limit 1000000) max_states_per_insn 0 total_states
0 peak_states 0 mark_read 0

libbpf: -- END LOG --
libbpf: failed to load program 'update_cookie_sockops'
libbpf: failed to load object 'socket_cookie_prog'
libbpf: failed to load BPF skeleton 'socket_cookie_prog': -4007
test_socket_cookie:FAIL:socket_cookie_prog__open_and_load skeleton
open_and_load failed
#95 socket_cookie:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
