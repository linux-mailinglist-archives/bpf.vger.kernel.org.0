Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2749B3506A4
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhCaSo6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 14:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbhCaSof (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 14:44:35 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FB0C061574
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 11:44:34 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j198so22173040ybj.11
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXb+H1/Dhvp+wNJ1MOIaOzTK5Y+X23D6KRqbrsd/MNc=;
        b=AHnfL49W+VoddFvqbaYLd541UfKNLRIEPsSgY6dK9cmJ/H3naY4QjVtayKe0V0VGRg
         kDeyyBvyps7fq4YN3RLun8yTT188mRi5yiKfitHfF3p+SEGnAzmOoBqJe6mqYFurIx5F
         QDmG9obprUuGI046nIzhREnfLEgte6u6ZQ3plsMo1Rg8V1kXKd+tv28zWHvWKj7J3kgV
         q+VERfHQER1yBn9FIEMhFPHOcfR9djbJbF/rOCwSPsSUENDdf5psld/R6HJPS3SmMg2X
         eJra0mQ6uUs5fuMzu2i+l2dLwDp85R4d6EayK9E0joiFqn0VElYP7e6TKbBsXrq/4mcz
         +/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXb+H1/Dhvp+wNJ1MOIaOzTK5Y+X23D6KRqbrsd/MNc=;
        b=rrdmXNoSriGFAI+R/i3oDhhitYz1ZrZbIn2GNJCEDTEE0ZLQqZJ41txSvTI8DULBjJ
         xX1yfWsqAjxUdzbAvM7gcrEu1+RzDfOeRb33jY1AOpLAJFwN+TIeRXebyUthwkIlEv1C
         dD3mxR3Xsd1gjMgzPSOMCkNeqikcSR8RUdSkxPFtAnqDDhqVDpLiRI+0aVI+3Qhi7Kva
         +nB6vhhe/HH23n0qVqa/ZF5xapb1SEjepEmVc3qR8KOaFZS6Y+KJ2VwdgjvS8+nfJ6ok
         i7Ed0G1ifNtGHrZvb5vtRBVHVNAjmexsdfOMQM2CuXnIWm7k+lQHoqfK/s42dXiJKVPo
         Trxw==
X-Gm-Message-State: AOAM531ykhiK05xaqUYlNphXSfxYMJ2Es8Kx9cR0oCDcNiU27zXpuCjZ
        AcmMLExEKMsYbqlWgRnkz+eGAlZuYZSajhwyQGc=
X-Google-Smtp-Source: ABdhPJyVq+A7ZzfUhUIkoRJEr6s15QZqLRJlT6l8VlyRhhonnWJlKiKHVLB2UoyhAAYbFPIMAwewjqNdcL2myhPg+wQ=
X-Received: by 2002:a25:37c1:: with SMTP id e184mr6378660yba.260.1617216274214;
 Wed, 31 Mar 2021 11:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
 <20210331164504.320614-1-yauheni.kaliuta@redhat.com> <20210331164504.320614-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210331164504.320614-3-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 31 Mar 2021 11:44:23 -0700
Message-ID: <CAEf4BzZYhqzYgxdgGUZtPoU5Lkq4vVLSF7Vu=9QXKCBEp+rh-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/8] selftests/bpf: pass page size from
 userspace in sockopt_sk
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 31, 2021 at 9:45 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Since there is no convenient way for bpf program to get PAGE_SIZE
> from inside of the kernel, pass the value from userspace.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/sockopt_sk.c |  2 ++
>  tools/testing/selftests/bpf/progs/sockopt_sk.c      | 10 ++++------
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> index 7274b12abe17..4b937e5dbaca 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> @@ -200,6 +200,8 @@ static void run_test(int cgroup_fd)
>         if (!ASSERT_OK_PTR(skel, "skel_load"))
>                 goto cleanup;
>
> +       skel->bss->page_size = getpagesize();
> +
>         skel->links._setsockopt =
>                 bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);
>         if (!ASSERT_OK_PTR(skel->links._setsockopt, "setsockopt_link"))
> diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> index 978a68005966..d6d03f64e2e4 100644
> --- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> @@ -7,9 +7,7 @@
>
>  char _license[] SEC("license") = "GPL";
>
> -#ifndef PAGE_SIZE
> -#define PAGE_SIZE 4096
> -#endif
> +int page_size; /* userspace should set it */

please zero-initialize this, otherwise it will cause problems on some
versions of Clang

>
>  #ifndef SOL_TCP
>  #define SOL_TCP IPPROTO_TCP
> @@ -89,7 +87,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
>                  * program can only see the first PAGE_SIZE
>                  * bytes of data.
>                  */
> -               if (optval_end - optval != PAGE_SIZE)
> +               if (optval_end - optval != page_size)
>                         return 0; /* EPERM, unexpected data size */
>
>                 return 1;
> @@ -160,7 +158,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
>
>         if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
>                 /* Original optlen is larger than PAGE_SIZE. */
> -               if (ctx->optlen != PAGE_SIZE * 2)
> +               if (ctx->optlen != page_size * 2)
>                         return 0; /* EPERM, unexpected data size */
>
>                 if (optval + 1 > optval_end)
> @@ -174,7 +172,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
>                  * program can only see the first PAGE_SIZE
>                  * bytes of data.
>                  */
> -               if (optval_end - optval != PAGE_SIZE)
> +               if (optval_end - optval != page_size)
>                         return 0; /* EPERM, unexpected data size */
>
>                 return 1;
> --
> 2.31.1
>
