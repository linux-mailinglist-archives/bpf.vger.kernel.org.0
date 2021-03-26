Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE134A0CB
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 06:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCZFMy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 01:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCZFMd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 01:12:33 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D21C0613AA
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 22:12:33 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i144so4697824ybg.1
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 22:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lI/4zGLHwbZ54+or7NjaEET4kRfB9sWT2kfBC8GTreY=;
        b=ueO0k2AGfSh00ADeQyq/ybhBICmyJLCmpDbPSBjrcZ64h4tmuSQfF2Q2gKbtagsmQC
         //t3A+0lTnjCXfkfVhv6vK2zwse8WAu900j4SV7V7GqpKK3WB9ZVQ1UiV3IJWtmAw74k
         c0NP/kMl1cbXisJgHnu0dhUN2/AgwzD6y5xYRmXWKSQAVCPouOwosFZtcwKxhM9jFDx5
         lQDbH6OeLhKfzlFAdYdqcdHQisjrf+Y7Ctokhc/P+k7bCxudzUIVd6flTDkVopsvzwng
         fOGa/cnoCwc2hjxMvps3wRC2frqiM7EsjdoIDIia1keeeWrhnvwaHygPYfo5om8Jnx4m
         RtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lI/4zGLHwbZ54+or7NjaEET4kRfB9sWT2kfBC8GTreY=;
        b=BeibyLACZIrSLP1cT6TxHKL0aAW7/Ka2alzDB4n3eDv9gFbY9QVLn1xHgT74i8NzSY
         lEOmhjgc03V+QRy4V4XzYkj9hJ92lgBTx9dI2ixwXeKj5J3mHTGhfqlMsyqCIX310ami
         QEKFjHh5l4MZRpJr+bsoeqAI+1YTJOFogmZX7xmFhP7JiIzxS/2A1Tow690kOm/XkE3n
         VkH3aTCvEvVyeDTe1CUt7Bl/waXpjZE6TP6Dqr4/7vPZjwKSGGrV2Jm5bAj91ZQ5Hn1+
         c7K+rTshFMj8Y+6g9yJyEizPfi/segsNvmQWV8ujZlDeTDamH8myElYvoQJYIM0rTUtB
         nxtw==
X-Gm-Message-State: AOAM531WkS8p+pnbLLzD0FoKBY0DEkANi6yzf4ZITVho5USrZImAIJnu
        K9kfy8514PN4K+WHxO9UiTKmSwRBi8wzkGCCZBU=
X-Google-Smtp-Source: ABdhPJw0X4sCt4Xgn/GOnoPMSryrNqHJcBVz86ujhJyavJBHAmWua7VRqEhoxzbL10HoMwBOs+rM7GFMZNFBnjGvUgo=
X-Received: by 2002:a25:9942:: with SMTP id n2mr16664373ybo.230.1616735552570;
 Thu, 25 Mar 2021 22:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <xunyim6b5k1b.fsf@redhat.com> <CAEf4BzaAokQ0vgsQ4zA-yB80t2ZFcc3gWUo+p4nw=KWHmK_nsQ@mail.gmail.com>
 <CANoWswkYXaFzuxCDF02=yDp2Fdk6RYb9OdiVNiwp97v-XLV0rQ@mail.gmail.com>
In-Reply-To: <CANoWswkYXaFzuxCDF02=yDp2Fdk6RYb9OdiVNiwp97v-XLV0rQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Mar 2021 22:12:21 -0700
Message-ID: <CAEf4BzY2YFKV+GTUS7QQKSJy2-6ZD88MbeQngUB8TOAzZEubdg@mail.gmail.com>
Subject: Re: bpf selftests and page size
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 24, 2021 at 6:28 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Andrii!
>
> On Tue, Mar 2, 2021 at 7:08 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Mar 1, 2021 at 1:02 AM Yauheni Kaliuta
> > <yauheni.kaliuta@redhat.com> wrote:
> > >
> > > Hi!
> > >
> > > Bunch of bpf selftests actually depends of page size and has it
> > > hardcoded to 4K. That causes failures if page shift is configured
> > > to values other than 12. It looks as a known issue since for the
> > > userspace parts sysconf(_SC_PAGE_SIZE) is used, but what would be
> > > the correct way to export it to bpf programs?
> > >
> >
> > Given PAGE_SIZE and PAGE_SHIFT are just #defines, the only way seems
> > to be to pass it from the user-space as a read-only variable.
> >
>
> I could not find a good example to attach to cgroup. Here is the
> draft, could you point me to right direction?

Yes. See prog_tests/cgroup_link.c, but I showed an example below.

>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> index d5b44b135c00..7932236a021e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
>  #include "cgroup_helpers.h"
> -
>  #include <linux/tcp.h>
> +#include "sockopt_sk.skel.h"
>
>  #ifndef SOL_TCP
>  #define SOL_TCP IPPROTO_TCP
> @@ -191,60 +191,33 @@ static int getsetsockopt(void)
>      return -1;
>  }
>
> -static int prog_attach(struct bpf_object *obj, int cgroup_fd, const
> char *title)
> -{
> -    enum bpf_attach_type attach_type;
> -    enum bpf_prog_type prog_type;
> -    struct bpf_program *prog;
> -    int err;
> -
> -    err = libbpf_prog_type_by_name(title, &prog_type, &attach_type);
> -    if (err) {
> -        log_err("Failed to deduct types for %s BPF program", title);
> -        return -1;
> -    }
> -
> -    prog = bpf_object__find_program_by_title(obj, title);
> -    if (!prog) {
> -        log_err("Failed to find %s BPF program", title);
> -        return -1;
> -    }
> -
> -    err = bpf_prog_attach(bpf_program__fd(prog), cgroup_fd,
> -                  attach_type, 0);
> -    if (err) {
> -        log_err("Failed to attach %s BPF program", title);
> -        return -1;
> -    }
> -
> -    return 0;
> -}
> -
>  static void run_test(int cgroup_fd)
>  {
> -    struct bpf_prog_load_attr attr = {
> -        .file = "./sockopt_sk.o",
> -    };
> -    struct bpf_object *obj;
> -    int ignored;
> +    struct sockopt_sk *skel;
> +    int prog_fd;
> +    int duration = 0;
>      int err;
>
> -    err = bpf_prog_load_xattr(&attr, &obj, &ignored);
> -    if (CHECK_FAIL(err))
> -        return;
> +    skel = sockopt_sk__open_and_load();
> +    if (CHECK(!skel, "skel_load", "sockopt_sk skeleton failed\n"))
> +        goto cleanup;
> +
> +    skel->bss->page_size = getpagesize();
>
> -    err = prog_attach(obj, cgroup_fd, "cgroup/getsockopt");
> -    if (CHECK_FAIL(err))
> -        goto close_bpf_object;
> +    prog_fd = bpf_program__fd(skel->progs._getsockopt);
> +    err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_GETSOCKOPT, 0);
> +    if (CHECK(err, "attach", "getsockopt attach failed: %d\n", err))
> +        goto cleanup;
>
> -    err = prog_attach(obj, cgroup_fd, "cgroup/setsockopt");
> -    if (CHECK_FAIL(err))
> -        goto close_bpf_object;
> +    prog_fd = bpf_program__fd(skel->progs._setsockopt);
> +    err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SETSOCKOPT, 0);

skel->links._setsockopt =
bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);

same above for getsockopt

> +    if (CHECK(err, "attach", "setsockopt attach failed: %d\n", err))

nit: if (!ASSERT_OK(err, "setsockopt_attach"))

> +        goto cleanup;
>
>      CHECK_FAIL(getsetsockopt());
>
> -close_bpf_object:
> -    bpf_object__close(obj);
> +cleanup:
> +    sockopt_sk__destroy(skel);
>  }
>
>  void test_sockopt_sk(void)
> diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c
> b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> index d3597f81e6e9..f8b051589681 100644
> --- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> @@ -8,9 +8,7 @@
>  char _license[] SEC("license") = "GPL";
>  __u32 _version SEC("version") = 1;

while you are at it, please remove _version, it's useless now

>
> -#ifndef PAGE_SIZE
> -#define PAGE_SIZE 4096
> -#endif
> +int page_size; /* userspace should set it */
>
>  #ifndef SOL_TCP
>  #define SOL_TCP IPPROTO_TCP
> @@ -41,7 +39,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
>           * let next BPF program in the cgroup chain or kernel
>           * handle it.
>           */
> -        ctx->optlen = 0; /* bypass optval>PAGE_SIZE */
> +        ctx->optlen = 0; /* bypass optval>page_size */

you don't need to update all those comments, conceptually it's all
PAGE_SIZE. It's just distracting from the actual change in the patch.

>          return 1;
>      }
>
> @@ -86,11 +84,11 @@ int _getsockopt(struct bpf_sockopt *ctx)
>          optval[0] = 0x55;
>          ctx->optlen = 1;
>
> -        /* Userspace buffer is PAGE_SIZE * 2, but BPF
> -         * program can only see the first PAGE_SIZE
> +        /* Userspace buffer is page_size * 2, but BPF
> +         * program can only see the first page_size
>           * bytes of data.
>           */
> -        if (optval_end - optval != PAGE_SIZE)
> +        if (optval_end - optval != page_size)
>              return 0; /* EPERM, unexpected data size */
>
>          return 1;
> @@ -131,7 +129,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
>           * let next BPF program in the cgroup chain or kernel
>           * handle it.
>           */
> -        ctx->optlen = 0; /* bypass optval>PAGE_SIZE */
> +        ctx->optlen = 0; /* bypass optval>page_size */
>          return 1;
>      }
>
> @@ -160,8 +158,8 @@ int _setsockopt(struct bpf_sockopt *ctx)
>      }
>
>      if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
> -        /* Original optlen is larger than PAGE_SIZE. */
> -        if (ctx->optlen != PAGE_SIZE * 2)
> +        /* Original optlen is larger than page_size. */
> +        if (ctx->optlen != page_size * 2)
>              return 0; /* EPERM, unexpected data size */
>
>          if (optval + 1 > optval_end)
> @@ -171,11 +169,11 @@ int _setsockopt(struct bpf_sockopt *ctx)
>          optval[0] = 0;
>          ctx->optlen = 1;
>
> -        /* Usepace buffer is PAGE_SIZE * 2, but BPF
> -         * program can only see the first PAGE_SIZE
> +        /* Usepace buffer is page_size * 2, but BPF
> +         * program can only see the first page_size
>           * bytes of data.
>           */
> -        if (optval_end - optval != PAGE_SIZE)
> +        if (optval_end - optval != page_size)
>              return 0; /* EPERM, unexpected data size */
>
>          return 1;
>
>
> --
> WBR, Yauheni
>
