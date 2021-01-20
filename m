Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFE02FD935
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 20:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbhATTLZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 14:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392409AbhATTHZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 14:07:25 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F0DC061575
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 11:06:45 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y19so49008123iov.2
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 11:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A6Xa37BH0glHn8+YzvUD4393K+5hHHSElK49mWZCpyo=;
        b=Q5FLCoAYCmoPiDMCSdMbSG97lr79MHXsmGcRBuzx1hqytp2dZ/jbM9sxCNVV3ox3DZ
         8qcMazFXObKIdLT+DM2LWh12KP7TPv8T3uVSd9Bvf/kwnDjRJhakez9jMJHULaVppZHa
         2qR/OMnlPc7WpG0xpoqJKKXwsl14tLt6aRwY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A6Xa37BH0glHn8+YzvUD4393K+5hHHSElK49mWZCpyo=;
        b=JBXwveydzpUNtNWm0jTo2EvxkGfNaw2rPl/Ny15S5ptGjdy7ZZzpV5Al/GKLwyvTNm
         HbOHS939xf5UeBGXdJ18yZhm93bekbNj8TG2oSlNP1Rvd7hhwM5wbCSyD408Cl49i50R
         pkSsGGbuHnAXVWxdRqWllVDCvrFmY4KKKlTM46+9tzu5zsbTwvlua17liSMuslXZEGdx
         nEJ6Q1E4QWiCGZETHNnUSx08ZevO9YJrmMBxlWxOVCqGbN/7D6x0W4KfIQMtrnO+qzd7
         yIBRfyGMYJN6g/lBk9b6b/hwx29Q1ejY99IanjzDZgEp6MvH8zgBrIUgTyep4iAGalBg
         5sEA==
X-Gm-Message-State: AOAM531Qk+gW7mmtnDhaCbtsFj48LBsaAORA86QW2QtbIwlJdZldG5XG
        yfOTWLnUk47R+7pTgQuX0U4bu6L4L6L8e82KFF6kgQ==
X-Google-Smtp-Source: ABdhPJyGOq0Ym0TEjuZ3QRq0uJVZhrlu6GjIhI4/NWJ6SchK3ctWPhLzQexT4bCSwOe+aS//a+ZMCkQJ1xZkzjK6/8Y=
X-Received: by 2002:a02:95e3:: with SMTP id b90mr9022761jai.32.1611169604569;
 Wed, 20 Jan 2021 11:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20210119155953.803818-1-revest@chromium.org> <20210119155953.803818-4-revest@chromium.org>
 <CACYkzJ6fNvYCO4cnU2XispQkF-_3yToDGgB=aRRd9m+qy0gpWA@mail.gmail.com> <CAADnVQJqVEvwF3GJyuiazxUUknBUaZ_k7gtt-m18hbBdoVeTGg@mail.gmail.com>
In-Reply-To: <CAADnVQJqVEvwF3GJyuiazxUUknBUaZ_k7gtt-m18hbBdoVeTGg@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 20 Jan 2021 20:06:33 +0100
Message-ID: <CABRcYmJ1jOgV2Ug6sKxbq4ZnaGFLvGLwCPmhrAYdaRh6oY-o=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add a selftest for the
 tracing bpf_get_socket_cookie
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 20, 2021 at 8:04 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 20, 2021 at 9:08 AM KP Singh <kpsingh@kernel.org> wrote:
> >
> > On Tue, Jan 19, 2021 at 5:00 PM Florent Revest <revest@chromium.org> wrote:
> > >
> > > This builds up on the existing socket cookie test which checks whether
> > > the bpf_get_socket_cookie helpers provide the same value in
> > > cgroup/connect6 and sockops programs for a socket created by the
> > > userspace part of the test.
> > >
> > > Adding a tracing program to the existing objects requires a different
> > > attachment strategy and different headers.
> > >
> > > Signed-off-by: Florent Revest <revest@chromium.org>
> >
> > Acked-by: KP Singh <kpsingh@kernel.org>
> >
> > (one minor note, doesn't really need fixing as a part of this though)
> >
> > > ---
> > >  .../selftests/bpf/prog_tests/socket_cookie.c  | 24 +++++++----
> > >  .../selftests/bpf/progs/socket_cookie_prog.c  | 41 ++++++++++++++++---
> > >  2 files changed, 52 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> > > index 53d0c44e7907..e5c5e2ea1deb 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> > > @@ -15,8 +15,8 @@ struct socket_cookie {
> > >
> > >  void test_socket_cookie(void)
> > >  {
> > > +       struct bpf_link *set_link, *update_sockops_link, *update_tracing_link;
> > >         socklen_t addr_len = sizeof(struct sockaddr_in6);
> > > -       struct bpf_link *set_link, *update_link;
> > >         int server_fd, client_fd, cgroup_fd;
> > >         struct socket_cookie_prog *skel;
> > >         __u32 cookie_expected_value;
> > > @@ -39,15 +39,21 @@ void test_socket_cookie(void)
> > >                   PTR_ERR(set_link)))
> > >                 goto close_cgroup_fd;
> > >
> > > -       update_link = bpf_program__attach_cgroup(skel->progs.update_cookie,
> > > -                                                cgroup_fd);
> > > -       if (CHECK(IS_ERR(update_link), "update-link-cg-attach", "err %ld\n",
> > > -                 PTR_ERR(update_link)))
> > > +       update_sockops_link = bpf_program__attach_cgroup(
> > > +               skel->progs.update_cookie_sockops, cgroup_fd);
> > > +       if (CHECK(IS_ERR(update_sockops_link), "update-sockops-link-cg-attach",
> > > +                 "err %ld\n", PTR_ERR(update_sockops_link)))
> > >                 goto free_set_link;
> > >
> > > +       update_tracing_link = bpf_program__attach(
> > > +               skel->progs.update_cookie_tracing);
> > > +       if (CHECK(IS_ERR(update_tracing_link), "update-tracing-link-attach",
> > > +                 "err %ld\n", PTR_ERR(update_tracing_link)))
> > > +               goto free_update_sockops_link;
> > > +
> > >         server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
> > >         if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
> > > -               goto free_update_link;
> > > +               goto free_update_tracing_link;
> > >
> > >         client_fd = connect_to_fd(server_fd, 0);
> > >         if (CHECK(client_fd < 0, "connect_to_fd", "errno %d\n", errno))
> > > @@ -71,8 +77,10 @@ void test_socket_cookie(void)
> > >         close(client_fd);
> > >  close_server_fd:
> > >         close(server_fd);
> > > -free_update_link:
> > > -       bpf_link__destroy(update_link);
> > > +free_update_tracing_link:
> > > +       bpf_link__destroy(update_tracing_link);
> >
> > I don't think this need to block submission unless there are other
> > issues but the
> > bpf_link__destroy can just be called in a single cleanup label because
> > it handles null or
> > erroneous inputs:
> >
> > int bpf_link__destroy(struct bpf_link *link)
> > {
> >     int err = 0;
> >
> >     if (IS_ERR_OR_NULL(link))
> >          return 0;
> > [...]
>
> +1 to KP's point.
>
> Also Florent, how did you test it?
> This test fails in CI and in my manual run:
> ./test_progs -t cook
> libbpf: load bpf program failed: Permission denied
> libbpf: -- BEGIN DUMP LOG ---
> libbpf:
> ; int update_cookie_sockops(struct bpf_sock_ops *ctx)
> 0: (bf) r6 = r1
> ; if (ctx->family != AF_INET6)
> 1: (61) r1 = *(u32 *)(r6 +20)
> ; if (ctx->family != AF_INET6)
> 2: (56) if w1 != 0xa goto pc+21
>  R1_w=inv10 R6_w=ctx(id=0,off=0,imm=0) R10=fp0
> ; if (ctx->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
> 3: (61) r1 = *(u32 *)(r6 +0)
> ; if (ctx->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
> 4: (56) if w1 != 0x3 goto pc+19
>  R1_w=inv3 R6_w=ctx(id=0,off=0,imm=0) R10=fp0
> ; if (!ctx->sk)
> 5: (79) r1 = *(u64 *)(r6 +184)
> ; if (!ctx->sk)
> 6: (15) if r1 == 0x0 goto pc+17
>  R1_w=sock(id=0,ref_obj_id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
> ; p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
> 7: (79) r2 = *(u64 *)(r6 +184)
> ; p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
> 8: (18) r1 = 0xffff888106e41400
> 10: (b7) r3 = 0
> 11: (b7) r4 = 0
> 12: (85) call bpf_sk_storage_get#107
> R2 type=sock_or_null expected=sock_common, sock, tcp_sock, xdp_sock, ptr_
> processed 12 insns (limit 1000000) max_states_per_insn 0 total_states
> 0 peak_states 0 mark_read 0
>
> libbpf: -- END LOG --
> libbpf: failed to load program 'update_cookie_sockops'
> libbpf: failed to load object 'socket_cookie_prog'
> libbpf: failed to load BPF skeleton 'socket_cookie_prog': -4007
> test_socket_cookie:FAIL:socket_cookie_prog__open_and_load skeleton
> open_and_load failed
> #95 socket_cookie:FAIL
> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

Oh :| I must have missed something in the rebase, I will fix this and
address KP's comment then. Thanks for the review and sorry for the
waste of time :)
