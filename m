Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C72B423769
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 07:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhJFFLz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 01:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhJFFLz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 01:11:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CB0C6120F
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 05:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633497003;
        bh=cHxZTiH+Ds0D6phS8wpbZHVrL2lGK/kOdxdA4mfsR8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=th8Bfme5gfZLYVM1Un61eQKrTpBhUIv40lwY5VuN6SnwU9HN5fqh0N5FT+KrxD8EY
         fODxxN4cWJ+7e1DFUhmGpfTrCkS8BeSDX4GeeGtQL0QdArcgXp1CNoD2uRRJLJ/zcT
         2vpncXJr64LlzTNPy51YsWj1DlhxJ/T2BtrhLt06uznallJjc5YpR/tzSFklHI0LUb
         cDMBiVaQXZ6nzDPbksZJP+YaUrQp4w10LKYNa2XqERzUX+DmFJDjv2eF4wmx8pKDvO
         P5gYXH2ZfXptJBoghpTvpeM+WCSFgD9RpXHXrCuNx41jjbe7s/wtDIcuof2eE+SmlH
         oxcHalwtmu+cQ==
Received: by mail-lf1-f51.google.com with SMTP id m3so5258369lfu.2
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 22:10:03 -0700 (PDT)
X-Gm-Message-State: AOAM531J5U36vKqpkvIUKO2i0wywQcUZVzmvxDx5WtSMZ5kJMAYm4+Gj
        j9dmdGpUekCG35MpWSmGKdcx3jzZHJTTSC8nMp0=
X-Google-Smtp-Source: ABdhPJy4la35PkZaQbfKq5MJQGdSEIspaxasHs0l4qzWsoFGt0rqIRBKKPAcdqCXjFD2Uc624agSfFPbafk7eTJrlG8=
X-Received: by 2002:ac2:5582:: with SMTP id v2mr7566045lfg.143.1633497001765;
 Tue, 05 Oct 2021 22:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211006040623.401527-1-hengqi.chen@gmail.com> <20211006040623.401527-3-hengqi.chen@gmail.com>
In-Reply-To: <20211006040623.401527-3-hengqi.chen@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 5 Oct 2021 22:09:50 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7eK6KA62bcA+pTc8-r5yraN=5H1hocy+TOA3C30KWNDg@mail.gmail.com>
Message-ID: <CAPhsuW7eK6KA62bcA+pTc8-r5yraN=5H1hocy+TOA3C30KWNDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_skc_to_unix_sock()
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 5, 2021 at 9:08 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add a new test which triggers unix_listen kernel function
> to test bpf_skc_to_unix_sock helper.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  .../bpf/prog_tests/skc_to_unix_sock.c         | 54 +++++++++++++++++++
>  .../bpf/progs/test_skc_to_unix_sock.c         | 28 ++++++++++
>  2 files changed, 82 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c b/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
> new file mode 100644
> index 000000000000..5d8ed76a71dc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2021 Hengqi Chen */
> +
> +#include <test_progs.h>
> +#include <sys/un.h>
> +#include "test_skc_to_unix_sock.skel.h"
> +
> +static const char *sock_path = "/tmp/test.sock";
> +
> +void test_skc_to_unix_sock(void)
> +{
> +       struct test_skc_to_unix_sock *skel;
> +       struct sockaddr_un sockaddr;
> +       int err, len, sockfd = 0;
> +
> +       skel = test_skc_to_unix_sock__open();
> +       if (!ASSERT_OK_PTR(skel, "could not open BPF object"))
> +               return;
> +
> +       skel->rodata->my_pid = getpid();
> +
> +       err = test_skc_to_unix_sock__load(skel);
> +       if (!ASSERT_OK(err, "could not load BPF object"))
> +               goto cleanup;
> +
> +       err = test_skc_to_unix_sock__attach(skel);
> +       if (!ASSERT_OK(err, "could not attach BPF object"))
> +               goto cleanup;
> +
> +       // trigger unix_listen
> +       sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
> +       if (!ASSERT_GT(sockfd, 0, "socket failed"))
> +               goto cleanup;
> +
> +       sockaddr.sun_family = AF_UNIX;
> +       strcpy(sockaddr.sun_path, sock_path);
> +       len = sizeof(sockaddr);
> +       unlink(sock_path);
> +
> +       err = bind(sockfd, (struct sockaddr *)&sockaddr, len);
> +       if (!ASSERT_OK(err, "bind failed"))
> +               goto cleanup;
> +
> +       err = listen(sockfd, 1);
> +       if (!ASSERT_OK(err, "listen failed"))
> +               goto cleanup;
> +
> +       ASSERT_GT(skel->bss->ret, 0, "bpf_skc_to_unix_sock failed");
> +
> +cleanup:
> +       if (sockfd)
> +               close(sockfd);
> +       test_skc_to_unix_sock__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
> new file mode 100644
> index 000000000000..544d2ed56d7e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2021 Hengqi Chen */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +const volatile pid_t my_pid = 0;
> +__u64 ret = 0;
> +
> +SEC("fentry/unix_listen")
> +int BPF_PROG(unix_listen, struct socket *sock, int backlog)
> +{
> +       pid_t pid = bpf_get_current_pid_tgid() >> 32;
> +       struct unix_sock *unix_sk;
> +
> +       if (pid != my_pid)
> +               return 0;
> +
> +       unix_sk = (struct unix_sock *)bpf_skc_to_unix_sock(sock->sk);
> +       if (!unix_sk)
> +               return 0;
> +
> +       ret = (__u64)unix_sk;

Other than ret !=0, can we verify unix_sk we get is expected? May we can
verify unix_sock-> path matches /tmp/test.sock?

Thanks,
Song
