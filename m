Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD14747C98F
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 00:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhLUXOC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 18:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbhLUXOB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 18:14:01 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2B9C061574
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 15:14:01 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id g5so412336ilj.12
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 15:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDReDO65LvqD8KnnP1UUEAp44Rjoqio9ESBwWNqPMvg=;
        b=Ktm+0EwePBmcMsa+DFp4ZnIiRBqRUGz3mrKXsSzcWlI1Q3BGwMvUO3f/XMX2spAb/u
         7toziFCEnsX+xBvcnPsRWhO7w28gge4ZN7ma/nW9yy+QfUth52EQ/b8BWSpia5gIsA+p
         imzuk2SGw8lvUyedBvlcboQ0zmBnC0QqD5ro6qAk6jWYpdQtE4N6f1NBc4orvUj25O7z
         UqvFR15y0vIQ9dU93ZQjDr7ljhgbFT90QtGrz9e3XAAQ/YL4tV0JcofCNSR78OJbxn4e
         67Pj6B+9hD9YoIIAxJowcRLBcmLwOTAwdwukW49ppNKrD4d/dRMC5SVNGlQHCkH3FMh/
         Qvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDReDO65LvqD8KnnP1UUEAp44Rjoqio9ESBwWNqPMvg=;
        b=HuSeNyP/EfHxopqeJA5NBepFRRr++FtbQxXp2zjgs2UUu5kM2S73IdMEz2w+9brgmH
         dM7Homts7Rb6bHuyaT81AVWxOunbPSLOGdvllL5Hfkw7/8M1kwkJCNBRensHqNAUKB9o
         JAYYOslkcZa14QV0bUvYKEI8JZAW0jgmZEjwacFiqV8DG7yTEHqv+iMqSAHYxay0X2kh
         v0xwfptAkHyGIsjlHtB9x3M/1i6g6TMH9WoxxYgV04sW8Mkzn+3+WBFjFiPCFjnw59ie
         lfZ1nP9TnZ7MeSwUVwVG/VPJO+15ZR4X2Uqig15OLAEdC0yoC7Vt6yroJgmsg/NwBFuq
         FtKw==
X-Gm-Message-State: AOAM532zKAsp1jtjBHOA6JsJIWKpRNnWNy3BhugMwJ4Yg+aCo+CcFXt3
        2dHQjC7bvnvZ8MrJZ5crEFpLhqnlSY+HTslSwh/QgZgPPxg=
X-Google-Smtp-Source: ABdhPJwqZIFi9MsA/3BIwSkhDxrF4dDxXFegmgl8gykFoS5y6JmaAXSJ+EhtOo0pBIVLXdJM1ICktuxyQfi2yK1tBUk=
X-Received: by 2002:a05:6e02:1a21:: with SMTP id g1mr213295ile.71.1640128440615;
 Tue, 21 Dec 2021 15:14:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639619851.git.zhuyifei@google.com> <4f20b77cb46812dbc2bdcd7e3fa87c7573bde55e.1639619851.git.zhuyifei@google.com>
In-Reply-To: <4f20b77cb46812dbc2bdcd7e3fa87c7573bde55e.1639619851.git.zhuyifei@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Dec 2021 15:13:49 -0800
Message-ID: <CAEf4BzY6kDaHLjKXR76C9m-ks00d1AskvAk1qn35=BpZAKrJwg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/5] selftests/bpf: Update sockopt_sk test to
 the use bpf_set_retval
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 15, 2021 at 6:04 PM YiFei Zhu <zhuyifei@google.com> wrote:
>
> The tests would break without this patch, because at one point it calls

Please fix selftests in the same patch where kernel change breaks it
to ensure a proper "bisectability" of the code.

>   getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen)
> This getsockopt receives the kernel-set -EINVAL. Prior to this patch
> series, the eBPF getsockopt hook's -EPERM would override kernel's
> -EINVAL, however, after this patch series, return 0's automatic
> -EPERM will not; the eBPF prog has to explicitly bpf_set_retval(-EPERM)
> if that is wanted.
>
> I also removed the explicit mentions of EPERM in the comments in the
> prog.
>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Reviewed-by: Stanislav Fomichev <sdf@google.com>
> ---
>  .../selftests/bpf/prog_tests/sockopt_sk.c     |  2 +-
>  .../testing/selftests/bpf/progs/sockopt_sk.c  | 32 +++++++++----------
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> index 4b937e5dbaca..164aa5020bf1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> @@ -177,7 +177,7 @@ static int getsetsockopt(void)
>         optlen = sizeof(buf.zc);
>         errno = 0;
>         err = getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen);
> -       if (errno != EPERM) {
> +       if (errno != EINVAL) {
>                 log_err("Unexpected getsockopt(TCP_ZEROCOPY_RECEIVE) err=%d errno=%d",
>                         err, errno);
>                 goto err;
> diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> index 79c8139b63b8..d0298dccedcd 100644
> --- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> @@ -73,17 +73,17 @@ int _getsockopt(struct bpf_sockopt *ctx)
>                  */
>
>                 if (optval + sizeof(struct tcp_zerocopy_receive) > optval_end)
> -                       return 0; /* EPERM, bounds check */
> +                       return 0; /* bounds check */
>
>                 if (((struct tcp_zerocopy_receive *)optval)->address != 0)
> -                       return 0; /* EPERM, unexpected data */
> +                       return 0; /* unexpected data */
>
>                 return 1;
>         }
>
>         if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
>                 if (optval + 1 > optval_end)
> -                       return 0; /* EPERM, bounds check */
> +                       return 0; /* bounds check */
>
>                 ctx->retval = 0; /* Reset system call return value to zero */
>
> @@ -96,24 +96,24 @@ int _getsockopt(struct bpf_sockopt *ctx)
>                  * bytes of data.
>                  */
>                 if (optval_end - optval != page_size)
> -                       return 0; /* EPERM, unexpected data size */
> +                       return 0; /* unexpected data size */
>
>                 return 1;
>         }
>
>         if (ctx->level != SOL_CUSTOM)
> -               return 0; /* EPERM, deny everything except custom level */
> +               return 0; /* deny everything except custom level */
>
>         if (optval + 1 > optval_end)
> -               return 0; /* EPERM, bounds check */
> +               return 0; /* bounds check */
>
>         storage = bpf_sk_storage_get(&socket_storage_map, ctx->sk, 0,
>                                      BPF_SK_STORAGE_GET_F_CREATE);
>         if (!storage)
> -               return 0; /* EPERM, couldn't get sk storage */
> +               return 0; /* couldn't get sk storage */
>
>         if (!ctx->retval)
> -               return 0; /* EPERM, kernel should not have handled
> +               return 0; /* kernel should not have handled
>                            * SOL_CUSTOM, something is wrong!
>                            */
>         ctx->retval = 0; /* Reset system call return value to zero */
> @@ -152,7 +152,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
>                 /* Overwrite SO_SNDBUF value */
>
>                 if (optval + sizeof(__u32) > optval_end)
> -                       return 0; /* EPERM, bounds check */
> +                       return 0; /* bounds check */
>
>                 *(__u32 *)optval = 0x55AA;
>                 ctx->optlen = 4;
> @@ -164,7 +164,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
>                 /* Always use cubic */
>
>                 if (optval + 5 > optval_end)
> -                       return 0; /* EPERM, bounds check */
> +                       return 0; /* bounds check */
>
>                 memcpy(optval, "cubic", 5);
>                 ctx->optlen = 5;
> @@ -175,10 +175,10 @@ int _setsockopt(struct bpf_sockopt *ctx)
>         if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
>                 /* Original optlen is larger than PAGE_SIZE. */
>                 if (ctx->optlen != page_size * 2)
> -                       return 0; /* EPERM, unexpected data size */
> +                       return 0; /* unexpected data size */
>
>                 if (optval + 1 > optval_end)
> -                       return 0; /* EPERM, bounds check */
> +                       return 0; /* bounds check */
>
>                 /* Make sure we can trim the buffer. */
>                 optval[0] = 0;
> @@ -189,21 +189,21 @@ int _setsockopt(struct bpf_sockopt *ctx)
>                  * bytes of data.
>                  */
>                 if (optval_end - optval != page_size)
> -                       return 0; /* EPERM, unexpected data size */
> +                       return 0; /* unexpected data size */
>
>                 return 1;
>         }
>
>         if (ctx->level != SOL_CUSTOM)
> -               return 0; /* EPERM, deny everything except custom level */
> +               return 0; /* deny everything except custom level */
>
>         if (optval + 1 > optval_end)
> -               return 0; /* EPERM, bounds check */
> +               return 0; /* bounds check */
>
>         storage = bpf_sk_storage_get(&socket_storage_map, ctx->sk, 0,
>                                      BPF_SK_STORAGE_GET_F_CREATE);
>         if (!storage)
> -               return 0; /* EPERM, couldn't get sk storage */
> +               return 0; /* couldn't get sk storage */
>
>         storage->val = optval[0];
>         ctx->optlen = -1; /* BPF has consumed this option, don't call kernel
> --
> 2.34.1.173.g76aa8bc2d0-goog
>
