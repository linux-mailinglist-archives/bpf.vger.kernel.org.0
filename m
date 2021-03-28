Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D34734BB2B
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 07:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhC1FBN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 01:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhC1FAj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Mar 2021 01:00:39 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86157C061762
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 22:00:39 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i9so10233222ybp.4
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 22:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22QCKzkgkR/qnDV3Aknf2ohQDnwAkjhTjgnKKcFnrWU=;
        b=e8YbZ9mT9x33BADua9QuDFqp773QW+748CDETcZMvLH9A6OTgFDgdq2pGV81gyvms+
         eX9NNWeqyLHff1QjyB5HEM5cvY1C7t/yWgk7p39ghM4Qp4wsbJn8mjV7cfHKL4cwzTnZ
         pGZ/dr62ohUp1QiRq9HhzNEpSumNIkYglKogg0M+3sL3Oxl3pi4EEXlehhYpfUEVj88l
         mzZry0pIBUQlodgxoRHTzSFgfJVrdJktp0miFwHIK9XwUzTOW6Uok8ZdXRH8ji6PtBo/
         LuS9eFovZW5u+0alImpEuxGJ4FGR/SMMZWcgfGx9bQf06iw2bL9ihTmOeSbJ2Xt5nff+
         G1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22QCKzkgkR/qnDV3Aknf2ohQDnwAkjhTjgnKKcFnrWU=;
        b=bbkt//+BOF/zSBOYdPF8e7DMRn5LCZGiThaoG4ZnNpI+WSiRsEprO00TcPU+jKB98q
         FAEJ7d5NhXv6Bk/pj2FRkxF22FyFCravplFDCmPmHxmU6ZmX3BtgEwNeasIeK3Nbj8tR
         SQoHxgtmpp22cgJ0V1YLIS02DpWpu+VdOqh/3ed4mylVzMcxtj5jH4VRzlV7XicnmLSy
         R1zWLZihabiA40Fw6wQFP/hpQdtF88Chm4gclxxK9t4uxPgmDnBTVRrmE0Gey+qD5X09
         qeHbC8flaQtHQS/qcQoA85Vk21wjCpn1xM6rB7TXg8pc3RIZgRoIzfFa82c3HLxvD8O5
         texA==
X-Gm-Message-State: AOAM533Tg3uelbPO1VPd9BEbK9fqJs0eeZNkGFE1Hya3fv/YYe4DqXF8
        WPeD2naTuaktvyUYZCDSH3XOuctYkAFMVfhI4SQ=
X-Google-Smtp-Source: ABdhPJzYm/+Eb1j6kHYNyxaYzn7tHfTaa+zuHln7h4r1chrpQM9G8qjEm6V8oiNgxvoq9urS/jSUw3IGuTnIZdcm7CU=
X-Received: by 2002:a25:874c:: with SMTP id e12mr29130625ybn.403.1616907638896;
 Sat, 27 Mar 2021 22:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
 <20210326122438.211242-1-yauheni.kaliuta@redhat.com> <20210326122438.211242-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210326122438.211242-2-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 27 Mar 2021 22:00:28 -0700
Message-ID: <CAEf4BzafSuz9Mf63bxKLuEVvy_Wdk5-r7xot0LBf-vN1h+8RfQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] selftests/bpf: test_progs/sockopt_sk: pass page
 size from userspace
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 26, 2021 at 5:24 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Since there is no convenient way for bpf program to get PAGE_SIZE
> from inside of the kernel, pass the value from userspace.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

But I'd also shorten the subject to:

selftests/bpf: pass page size from userspace in sockopt_sk

It's just as clear and doesn't include unnecessary prog_tests/ path.


>  tools/testing/selftests/bpf/prog_tests/sockopt_sk.c |  2 ++
>  tools/testing/selftests/bpf/progs/sockopt_sk.c      | 10 ++++------
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> index 114c1a622ffa..6a7cb5f23db2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> @@ -201,6 +201,8 @@ static void run_test(int cgroup_fd)
>         if (CHECK(!skel, "skel_load", "sockopt_sk skeleton failed\n"))
>                 goto cleanup;
>
> +       skel->bss->page_size = getpagesize();
> +
>         skel->links._setsockopt =
>                 bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);
>         if (CHECK(IS_ERR(skel->links._setsockopt),
> diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> index d3597f81e6e9..55dfbe53c24e 100644
> --- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> @@ -8,9 +8,7 @@
>  char _license[] SEC("license") = "GPL";
>  __u32 _version SEC("version") = 1;
>
> -#ifndef PAGE_SIZE
> -#define PAGE_SIZE 4096
> -#endif
> +int page_size; /* userspace should set it */
>
>  #ifndef SOL_TCP
>  #define SOL_TCP IPPROTO_TCP
> @@ -90,7 +88,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
>                  * program can only see the first PAGE_SIZE
>                  * bytes of data.
>                  */
> -               if (optval_end - optval != PAGE_SIZE)
> +               if (optval_end - optval != page_size)
>                         return 0; /* EPERM, unexpected data size */
>
>                 return 1;
> @@ -161,7 +159,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
>
>         if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
>                 /* Original optlen is larger than PAGE_SIZE. */
> -               if (ctx->optlen != PAGE_SIZE * 2)
> +               if (ctx->optlen != page_size * 2)
>                         return 0; /* EPERM, unexpected data size */
>
>                 if (optval + 1 > optval_end)
> @@ -175,7 +173,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
>                  * program can only see the first PAGE_SIZE
>                  * bytes of data.
>                  */
> -               if (optval_end - optval != PAGE_SIZE)
> +               if (optval_end - optval != page_size)
>                         return 0; /* EPERM, unexpected data size */
>
>                 return 1;
> --
> 2.29.2
>
