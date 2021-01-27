Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B2E30658B
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 22:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhA0U7R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 15:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbhA0U60 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 15:58:26 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F7CC0613D6;
        Wed, 27 Jan 2021 12:57:46 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id b11so3351216ybj.9;
        Wed, 27 Jan 2021 12:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3w2Eu9MVgLYVsxKcxrJ/h5B87c209eM+nktsBZXfTw=;
        b=WmlsbvC3mMBzCTCG5PzFw2cK7mUeeSD9g+oDlsB0n2XvwXqjbj8PKSie/GiI4sQ8ZM
         pf3VNP2apCU9eswaRMiAd+gIWjTF5LEl0yxrjMLiss3Dk2AguH7GGJxuaebId7OPUMuw
         Kl9uEuhIY7jvDn8/3P2qYvTDdCgZF1Or1Rp0i78wHLLEzY2z+D9BwES49nV5ewtia1lQ
         GKijvFZR/V4vlTkEpExxpvz4ZXNpMJlP6iknZkmMMDyZ0+Te9tEpkyBzqMjIcxuas+fl
         AY3m5nWXmKa99usabAnRHYUaB1G1hyMx25912w/nx9B6LM8o0EYuqT0vt1ydN2wCuDqp
         nscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3w2Eu9MVgLYVsxKcxrJ/h5B87c209eM+nktsBZXfTw=;
        b=r6A6dq64Z+7dwiMVTN+q8GLiTCNu7Vhp3LFCZJEQqo0YQjBhd+AceCFAzVJMmFozHw
         zDmZlyXt3ANhzqrmkjm0IETHg2eJv+LHe6ZYlXlyfwercM5Z4Tn+mImLzb/hQNx9Uwxr
         Ja0keI4Q/iwFzvajxP8GON6ADVF4EZ2Vvl8ND5B5hqVGgp6q/yb7AwkSJQb4MDOuzfJU
         Csgf6AxUfvU1UqwkOOJK15xMGxwV3Xn/OWCFLW2UuFdA2zv12vKLdObvK9+lxURqmWXD
         q4yAJ5JhD+zCYWdeI5cwVkKZ4FBB1Po2cXIQbx+9CxRrPq5iuMwao70oLXxOFPGkDcPQ
         XiKQ==
X-Gm-Message-State: AOAM531BedTJLhI97Jse8OJh3KFj27m4BGf8PLfiDYYdCPATSf0ydUdT
        uhfe3pC1BymJ+n0TZ4/3kcyaVsplblybkNa1+CWOjaihxVjMzA==
X-Google-Smtp-Source: ABdhPJy7sbV0M810Jy+R0iP5dmIiYb7E6TS4zAYyUIPV+ckUN7m8fhWQ9wRjo7ozwGsUIdTdlQ7tDvsg74tGFUfg4Xo=
X-Received: by 2002:a25:1287:: with SMTP id 129mr18215737ybs.27.1611781065815;
 Wed, 27 Jan 2021 12:57:45 -0800 (PST)
MIME-Version: 1.0
References: <20210126183559.1302406-1-revest@chromium.org> <20210126183559.1302406-4-revest@chromium.org>
In-Reply-To: <20210126183559.1302406-4-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Jan 2021 12:57:34 -0800
Message-ID: <CAEf4BzbnQ6XfUAuBDeuO9qSNojHGKgXJZG3NtBp4MaAXjscr2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 4/5] selftests/bpf: Use vmlinux.h in socket_cookie_prog.c
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 26, 2021 at 10:36 AM Florent Revest <revest@chromium.org> wrote:
>
> When migrating from the bpf.h's to the vmlinux.h's definition of struct
> bps_sock, an interesting LLVM behavior happened. LLVM started producing
> two fetches of ctx->sk in the sockops program this means that the
> verifier could not keep track of the NULL-check on ctx->sk. Therefore,
> we need to extract ctx->sk in a variable before checking and
> dereferencing it.
>
> Acked-by: KP Singh <kpsingh@kernel.org>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  .../testing/selftests/bpf/progs/socket_cookie_prog.c  | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
> index 81e84be6f86d..fbd5eaf39720 100644
> --- a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
> +++ b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
> @@ -1,12 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2018 Facebook
>
> -#include <linux/bpf.h>
> -#include <sys/socket.h>
> +#include "vmlinux.h"
>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_endian.h>
>
> +#define AF_INET6 10
> +
>  struct socket_cookie {
>         __u64 cookie_key;
>         __u32 cookie_value;
> @@ -41,7 +42,7 @@ int set_cookie(struct bpf_sock_addr *ctx)
>  SEC("sockops")
>  int update_cookie(struct bpf_sock_ops *ctx)
>  {
> -       struct bpf_sock *sk;
> +       struct bpf_sock *sk = ctx->sk;
>         struct socket_cookie *p;
>
>         if (ctx->family != AF_INET6)
> @@ -50,10 +51,10 @@ int update_cookie(struct bpf_sock_ops *ctx)
>         if (ctx->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
>                 return 1;
>
> -       if (!ctx->sk)
> +       if (!sk)
>                 return 1;
>
> -       p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
> +       p = bpf_sk_storage_get(&socket_cookies, sk, 0, 0);
>         if (!p)
>                 return 1;
>
> --
> 2.30.0.280.ga3ce27912f-goog
>
