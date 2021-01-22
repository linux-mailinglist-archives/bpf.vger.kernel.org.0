Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F79300777
	for <lists+bpf@lfdr.de>; Fri, 22 Jan 2021 16:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbhAVPgV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jan 2021 10:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbhAVPfd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jan 2021 10:35:33 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B24C0613D6
        for <bpf@vger.kernel.org>; Fri, 22 Jan 2021 07:34:52 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x21so11784127iog.10
        for <bpf@vger.kernel.org>; Fri, 22 Jan 2021 07:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CH89oABAyKgBOGkKlkkNpqPl4Z1JdSywlf4azBbyiuE=;
        b=fl9bq7qm/QInr5k1dz2+w5oP4G2EPwX+IKXksi7hSG8IswQp20sX/GSgorS7tk8buk
         cwuQxpSNkpGBvYqRgPrPrEY6DSQQlKMt/DVQIzOM+TFYNeJNrMDHDMAzr5LQkZVkX7mM
         Qp/zHhrzb0V8lh9gn5xtGsqFapXTlf+KybDPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CH89oABAyKgBOGkKlkkNpqPl4Z1JdSywlf4azBbyiuE=;
        b=WDVVj0uH2VFvWzIjYcXMXOm4H0s8KJ4RniLRKnqtpPfp3d6r2nBcW4l31PcB+R0QgE
         9o6oBSMnYGeM0mJ8iaGbsODsfMPvZBrAPscou4XI/ijEkpQAC7Jqewh+HkMSS7fiHVmw
         BRix1/JavQcN5qfBtnviuB7f35U8zv7Rjvi0OV8kZ2jeC0p5Bt6ZEYys4Lq7f/tF2vod
         3r5x/Om16TdbdBAM88kpG01rja+cCjQZioQyN/S2BftSTcGIHsqBAXxLPMwVkMA7HKeX
         7DyMK8kWk25ZRhPQ0BXLKEOrTR/P9Bwu8ZLodFK+2FwvhTM7/gHlgDFnIOBp4iDToXqX
         CiEA==
X-Gm-Message-State: AOAM532nc4Wj2G9pLcfndh9veQ37snb2SqtiAz/aKXwRXwnct4fiyjbq
        /6Umpgvbszx6L/yIjQ3cdZh9Na1nkI7g2NHr92M9pA==
X-Google-Smtp-Source: ABdhPJzCjZF1blad+Bc2MFhE+YOoiHQOaQ81zRJfIowwIkKdTS/+fJOk3YB/VhxBDdxLMFi7LFFYNm2pS7rf9We2eM8=
X-Received: by 2002:a6b:cc07:: with SMTP id c7mr3918493iog.122.1611329692196;
 Fri, 22 Jan 2021 07:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20210119155953.803818-1-revest@chromium.org> <20210119155953.803818-4-revest@chromium.org>
 <CACYkzJ6fNvYCO4cnU2XispQkF-_3yToDGgB=aRRd9m+qy0gpWA@mail.gmail.com>
 <CAADnVQJqVEvwF3GJyuiazxUUknBUaZ_k7gtt-m18hbBdoVeTGg@mail.gmail.com> <CABRcYmJ1jOgV2Ug6sKxbq4ZnaGFLvGLwCPmhrAYdaRh6oY-o=g@mail.gmail.com>
In-Reply-To: <CABRcYmJ1jOgV2Ug6sKxbq4ZnaGFLvGLwCPmhrAYdaRh6oY-o=g@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 22 Jan 2021 16:34:41 +0100
Message-ID: <CABRcYm+cWobt9yd-2k8nx+19wCZVniLszTcQRphq1soxQG0jdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add a selftest for the
 tracing bpf_get_socket_cookie
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 20, 2021 at 8:06 PM Florent Revest <revest@chromium.org> wrote:
>
> On Wed, Jan 20, 2021 at 8:04 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jan 20, 2021 at 9:08 AM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > On Tue, Jan 19, 2021 at 5:00 PM Florent Revest <revest@chromium.org> wrote:
> > > >
> > > > This builds up on the existing socket cookie test which checks whether
> > > > the bpf_get_socket_cookie helpers provide the same value in
> > > > cgroup/connect6 and sockops programs for a socket created by the
> > > > userspace part of the test.
> > > >
> > > > Adding a tracing program to the existing objects requires a different
> > > > attachment strategy and different headers.
> > > >
> > > > Signed-off-by: Florent Revest <revest@chromium.org>
> > >
> > > Acked-by: KP Singh <kpsingh@kernel.org>
> > >
> > > (one minor note, doesn't really need fixing as a part of this though)
> > >
> > > > ---
> > > >  .../selftests/bpf/prog_tests/socket_cookie.c  | 24 +++++++----
> > > >  .../selftests/bpf/progs/socket_cookie_prog.c  | 41 ++++++++++++++++---
> > > >  2 files changed, 52 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> > > > index 53d0c44e7907..e5c5e2ea1deb 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> > > > @@ -15,8 +15,8 @@ struct socket_cookie {
> > > >
> > > >  void test_socket_cookie(void)
> > > >  {
> > > > +       struct bpf_link *set_link, *update_sockops_link, *update_tracing_link;
> > > >         socklen_t addr_len = sizeof(struct sockaddr_in6);
> > > > -       struct bpf_link *set_link, *update_link;
> > > >         int server_fd, client_fd, cgroup_fd;
> > > >         struct socket_cookie_prog *skel;
> > > >         __u32 cookie_expected_value;
> > > > @@ -39,15 +39,21 @@ void test_socket_cookie(void)
> > > >                   PTR_ERR(set_link)))
> > > >                 goto close_cgroup_fd;
> > > >
> > > > -       update_link = bpf_program__attach_cgroup(skel->progs.update_cookie,
> > > > -                                                cgroup_fd);
> > > > -       if (CHECK(IS_ERR(update_link), "update-link-cg-attach", "err %ld\n",
> > > > -                 PTR_ERR(update_link)))
> > > > +       update_sockops_link = bpf_program__attach_cgroup(
> > > > +               skel->progs.update_cookie_sockops, cgroup_fd);
> > > > +       if (CHECK(IS_ERR(update_sockops_link), "update-sockops-link-cg-attach",
> > > > +                 "err %ld\n", PTR_ERR(update_sockops_link)))
> > > >                 goto free_set_link;
> > > >
> > > > +       update_tracing_link = bpf_program__attach(
> > > > +               skel->progs.update_cookie_tracing);
> > > > +       if (CHECK(IS_ERR(update_tracing_link), "update-tracing-link-attach",
> > > > +                 "err %ld\n", PTR_ERR(update_tracing_link)))
> > > > +               goto free_update_sockops_link;
> > > > +
> > > >         server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
> > > >         if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
> > > > -               goto free_update_link;
> > > > +               goto free_update_tracing_link;
> > > >
> > > >         client_fd = connect_to_fd(server_fd, 0);
> > > >         if (CHECK(client_fd < 0, "connect_to_fd", "errno %d\n", errno))
> > > > @@ -71,8 +77,10 @@ void test_socket_cookie(void)
> > > >         close(client_fd);
> > > >  close_server_fd:
> > > >         close(server_fd);
> > > > -free_update_link:
> > > > -       bpf_link__destroy(update_link);
> > > > +free_update_tracing_link:
> > > > +       bpf_link__destroy(update_tracing_link);
> > >
> > > I don't think this need to block submission unless there are other
> > > issues but the
> > > bpf_link__destroy can just be called in a single cleanup label because
> > > it handles null or
> > > erroneous inputs:
> > >
> > > int bpf_link__destroy(struct bpf_link *link)
> > > {
> > >     int err = 0;
> > >
> > >     if (IS_ERR_OR_NULL(link))
> > >          return 0;
> > > [...]
> >
> > +1 to KP's point.
> >
> > Also Florent, how did you test it?
> > This test fails in CI and in my manual run:
> > ./test_progs -t cook
> > libbpf: load bpf program failed: Permission denied
> > libbpf: -- BEGIN DUMP LOG ---
> > libbpf:
> > ; int update_cookie_sockops(struct bpf_sock_ops *ctx)
> > 0: (bf) r6 = r1
> > ; if (ctx->family != AF_INET6)
> > 1: (61) r1 = *(u32 *)(r6 +20)
> > ; if (ctx->family != AF_INET6)
> > 2: (56) if w1 != 0xa goto pc+21
> >  R1_w=inv10 R6_w=ctx(id=0,off=0,imm=0) R10=fp0
> > ; if (ctx->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
> > 3: (61) r1 = *(u32 *)(r6 +0)
> > ; if (ctx->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
> > 4: (56) if w1 != 0x3 goto pc+19
> >  R1_w=inv3 R6_w=ctx(id=0,off=0,imm=0) R10=fp0
> > ; if (!ctx->sk)
> > 5: (79) r1 = *(u64 *)(r6 +184)
> > ; if (!ctx->sk)
> > 6: (15) if r1 == 0x0 goto pc+17
> >  R1_w=sock(id=0,ref_obj_id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
> > ; p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
> > 7: (79) r2 = *(u64 *)(r6 +184)
> > ; p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
> > 8: (18) r1 = 0xffff888106e41400
> > 10: (b7) r3 = 0
> > 11: (b7) r4 = 0
> > 12: (85) call bpf_sk_storage_get#107
> > R2 type=sock_or_null expected=sock_common, sock, tcp_sock, xdp_sock, ptr_
> > processed 12 insns (limit 1000000) max_states_per_insn 0 total_states
> > 0 peak_states 0 mark_read 0
> >
> > libbpf: -- END LOG --
> > libbpf: failed to load program 'update_cookie_sockops'
> > libbpf: failed to load object 'socket_cookie_prog'
> > libbpf: failed to load BPF skeleton 'socket_cookie_prog': -4007
> > test_socket_cookie:FAIL:socket_cookie_prog__open_and_load skeleton
> > open_and_load failed
> > #95 socket_cookie:FAIL
> > Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>
> Oh :| I must have missed something in the rebase, I will fix this and
> address KP's comment then. Thanks for the review and sorry for the
> waste of time :)

So this is actually an interesting one I think. :) The failure was
triggered by the combination of an LLVM update and this change:

-#include <linux/bpf.h>
+#include "vmlinux.h"

With an older LLVM, this used to work.
With a recent LLVM, the change of header causes those 3 lines to get
compiled differently:

if (!ctx->sk)
    return 1;
p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);

When including linux/bpf.h
; if (!ctx->sk)
       5: 79 62 b8 00 00 00 00 00 r2 = *(u64 *)(r6 + 184)
       6: 15 02 10 00 00 00 00 00 if r2 == 0 goto +16 <LBB1_6>
; p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
       7: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
       9: b7 03 00 00 00 00 00 00 r3 = 0
      10: b7 04 00 00 00 00 00 00 r4 = 0
      11: 85 00 00 00 6b 00 00 00 call 107
      12: bf 07 00 00 00 00 00 00 r7 = r0

When including vmlinux.h
; if (!ctx->sk)
       5: 79 61 b8 00 00 00 00 00 r1 = *(u64 *)(r6 + 184)
       6: 15 01 11 00 00 00 00 00 if r1 == 0 goto +17 <LBB1_6>
; p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
       7: 79 62 b8 00 00 00 00 00 r2 = *(u64 *)(r6 + 184)
       8: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
      10: b7 03 00 00 00 00 00 00 r3 = 0
      11: b7 04 00 00 00 00 00 00 r4 = 0
      12: 85 00 00 00 6b 00 00 00 call 107
      13: bf 07 00 00 00 00 00 00 r7 = r0

Note that ctx->sk gets fetched once in the first case (l5), and twice
in the second case (l5 and l7).
I'm assuming that struct bpf_sock_ops gets defined with different
attributes in vmlinux.h and causes LLVM to assume that ctx->sk could
have changed between the time of check and the time of use so it
yields two fetches and the verifier can't track that r2 is non null.

If I save ctx->sk in a temporary variable first:

struct bpf_sock *sk = ctx->sk;
if (!sk)
    return 1;
p = bpf_sk_storage_get(&socket_cookies, sk, 0, 0);

this loads correctly. However, Brendan pointed out that this is also a
weak guarantee and that LLVM could still decide to compile this into
two fetches, Brendan suggested that we save sk out of an access to a
volatile pointer to ctx, what do you think ?
