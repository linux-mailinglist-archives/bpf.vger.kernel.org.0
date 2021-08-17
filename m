Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B233EE0C9
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 02:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhHQAVW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 20:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232929AbhHQAVW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 20:21:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05B0E60F46
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 00:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629159650;
        bh=momVpTEA8dhnkct1PAoI10ZcN0z7QOY0gSl5kM6+N58=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VqgS4NSVjTqdxr+iCzXbYh9DgYPLFUCBKv7PO65Zl52cbmBxFUm7NUAAzaGJ7Dd/5
         yRwkccDUs4OKY3fxphSQj/Wyh7TQdt0cAoaQ2lWoEYNXzvb2iwF1JWN2Cu/RJyuhqE
         EgChLyUepAmGlCNqVKjM0FPGAMBm1KBkRRUK/kgeOjozTKY9L8hTtZaBgfFo5XmuLW
         5qOoNhXrgcQmsyydR9uWkGEfftd1NpwMxYJtL3po5NsaLnG1GciPCaOtRolcqwV2pM
         Y6o9JK0PgbEnPI6iYvcUJ6zePRwe4yggYCjl48QMAp0wqbxxoH/dkQcWdsn5jJNm+T
         Akd2llzgVurSg==
Received: by mail-lf1-f53.google.com with SMTP id z2so37978264lft.1
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 17:20:49 -0700 (PDT)
X-Gm-Message-State: AOAM532SSLANdBQ/jJko3MKWZuwPsLx68MUuC8MW4Y8mtbeO5x4nguSa
        dDa/MF9uRXx8gCHHyN0SLZ2lNo7/WgajdEhphgc=
X-Google-Smtp-Source: ABdhPJwwxwcTeNvpke9GsuVG6IknQXqU3M1qsBBkUl0TbtbTP0XMgvLa+FaDfodTmDjzD5iaeipTz6HwCXXXeKndhQ4=
X-Received: by 2002:a05:6512:11e9:: with SMTP id p9mr325077lfs.372.1629159648293;
 Mon, 16 Aug 2021 17:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210816231716.3824813-1-prankgup@fb.com> <20210816231716.3824813-3-prankgup@fb.com>
In-Reply-To: <20210816231716.3824813-3-prankgup@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 16 Aug 2021 17:20:37 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4RDYVtnomkjgJs_1H_DSn2skcf7mmoxKkLE-bB38b+Kw@mail.gmail.com>
Message-ID: <CAPhsuW4RDYVtnomkjgJs_1H_DSn2skcf7mmoxKkLE-bB38b+Kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for {set|get} socket
 option from setsockopt BPF program
To:     Prankur gupta <prankgup@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, prankur.07@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 16, 2021 at 4:18 PM Prankur gupta <prankgup@fb.com> wrote:
>
> Adding selftests for new added functionality to call bpf_setsockopt and
> bpf_getsockopt from setsockopt BPF programs
>
> Signed-off-by: Prankur gupta <prankgup@fb.com>
> ---
>  tools/testing/selftests/bpf/bpf_tcp_helpers.h | 18 +++++
>  .../bpf/prog_tests/sockopt_qos_to_cc.c        | 70 +++++++++++++++++++
>  .../selftests/bpf/progs/sockopt_qos_to_cc.c   | 39 +++++++++++
>  3 files changed, 127 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/sockopt_qos_to_cc.c
>  create mode 100644 tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index 029589c008c9..c9f9bdad60c7 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -12,6 +12,10 @@
>  SEC("struct_ops/"#name) \
>  BPF_PROG(name, args)
>
> +#ifndef SOL_TCP
> +#define SOL_TCP 6
> +#endif
> +
>  #define tcp_jiffies32 ((__u32)bpf_jiffies64())
>
>  struct sock_common {
> @@ -203,6 +207,20 @@ static __always_inline bool tcp_is_cwnd_limited(const struct sock *sk)
>         return !!BPF_CORE_READ_BITFIELD(tp, is_cwnd_limited);
>  }
>
> +static __always_inline bool tcp_cc_eq(const char *a, const char *b)
> +{
> +       int i;
> +
> +       for (i = 0; i < TCP_CA_NAME_MAX; i++) {
> +               if (a[i] != b[i])
> +                       return false;
> +               if (!a[i])
> +                       break;
> +       }
> +
> +       return true;
> +}

IIUC, this is copied from bpf_iter_setsockopt.c. I think we should be
more careful with it
as this is a header. With current code,

   tcp_cc_eq("ABC", "ABCD") = true;
   tcp_cc_eq("ABCD", "ABC") = false;

Is this expected?


> +
>  extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
>  extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_qos_to_cc.c b/tools/testing/selftests/bpf/prog_tests/sockopt_qos_to_cc.c
> new file mode 100644
> index 000000000000..6b53b3cb8dad
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_qos_to_cc.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +#include <test_progs.h>
> +#include <netinet/tcp.h>
> +#include "sockopt_qos_to_cc.skel.h"
> +
> +static void run_setsockopt_test(int cg_fd, int sock_fd)
> +{
> +       socklen_t optlen;
> +       char cc[16]; /* TCP_CA_NAME_MAX */
> +       int buf;
> +       int err = -1;
nit: this err = -1 is not needed.

> +
> +       buf = 0x2D;

Please explain the test case in the commit log. Otherwise, it is not
easy to follow
the test case. For example, why we use 0x2d ('-'?) here?

> +       err = setsockopt(sock_fd, SOL_IPV6, IPV6_TCLASS, &buf, sizeof(buf));
> +       if (!ASSERT_OK(err, "setsockopt(sock_fd, IPV6_TCLASS)"))
> +               return;
> +
> +       /* Verify the setsockopt cc change */
> +       optlen = sizeof(cc);
> +       err = getsockopt(sock_fd, SOL_TCP, TCP_CONGESTION, cc, &optlen);
> +       if (!ASSERT_OK(err, "getsockopt(sock_fd, TCP_CONGESTION)"))
> +               return;
> +
> +       if (!ASSERT_STREQ(cc, "reno", "getsockopt(sock_fd, TCP_CONGESTION)"))
> +               return;
> +}
> +
> +void test_sockopt_qos_to_cc(void)
> +{
> +       struct sockopt_qos_to_cc *skel;
> +       char cc_cubic[16] = "cubic"; /* TCP_CA_NAME_MAX */
> +       int cg_fd = -1;
> +       int sock_fd = -1;
> +       int err;
> +
> +       cg_fd = test__join_cgroup("/sockopt_qos_to_cc");
> +       if (!ASSERT_GE(cg_fd, 0, "cg-join(sockopt_qos_to_cc)"))
> +               return;
> +
> +       skel = sockopt_qos_to_cc__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel"))
> +               goto done;
> +
> +       sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
> +       if (!ASSERT_GE(sock_fd, 0, "v6 socket open"))
> +               goto done;
> +
> +       err = setsockopt(sock_fd, SOL_TCP, TCP_CONGESTION, &cc_cubic,
> +                        sizeof(cc_cubic));
> +       if (!ASSERT_OK(err, "setsockopt(sock_fd, TCP_CONGESTION)"))
> +               goto done;
> +
> +       skel->links.sockopt_qos_to_cc =
> +               bpf_program__attach_cgroup(skel->progs.sockopt_qos_to_cc,
> +                                          cg_fd);
> +       if (!ASSERT_OK_PTR(skel->links.sockopt_qos_to_cc,
> +                          "prog_attach(sockopt_qos_to_cc)"))
> +               goto done;
> +
> +       run_setsockopt_test(cg_fd, sock_fd);
> +
> +done:
> +       if (sock_fd != -1)
> +               close(sock_fd);
> +       if (cg_fd != -1)
> +               close(cg_fd);
> +       /* destroy can take null and error pointer */
> +       sockopt_qos_to_cc__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c b/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
> new file mode 100644
> index 000000000000..1bce83b6e3a7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +#include <string.h>
> +#include <linux/tcp.h>
> +#include <netinet/in.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_tcp_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("cgroup/setsockopt")
> +int sockopt_qos_to_cc(struct bpf_sockopt *ctx)
> +{
> +       void *optval_end = ctx->optval_end;
> +       int *optval = ctx->optval;
> +       char buf[TCP_CA_NAME_MAX];
> +       char cc_reno[TCP_CA_NAME_MAX] = "reno";
> +       char cc_cubic[TCP_CA_NAME_MAX] = "cubic";
> +
> +       if (ctx->level != SOL_IPV6 || ctx->optname != IPV6_TCLASS)
> +               return 1;
> +
> +       if (optval + 1 > optval_end)
> +               return 0; /* EPERM, bounds check */
> +
> +       if (bpf_getsockopt(ctx->sk, SOL_TCP, TCP_CONGESTION, &buf, sizeof(buf)))
> +               return 0;
> +
> +       if (!tcp_cc_eq(buf, cc_cubic))
> +               return 0;
> +
> +       if (*optval == 0x2d) {
> +               if (bpf_setsockopt(ctx->sk, SOL_TCP, TCP_CONGESTION, &cc_reno,
> +                               sizeof(cc_reno)))
> +                       return 0;
> +       }
> +       return 1;
> +}
> --
> 2.30.2
>
