Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FBE4273BD
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbhJHW3b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243647AbhJHW3b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:29:31 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470A1C061755
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:27:35 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id s4so24141598ybs.8
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rck8/FEuhZTWSFfXM5diXJpeeR+/DrL1slg/hOjAZpA=;
        b=qu5ov9FWq0PmIscnnJDPLp+sQnTpordh9jdCk78Rb0H/ONEEJV3Uh67hj4rd9NR9RN
         A4ZuNK2dvSanWSMfP6yueqeE4EY2tYBsaagJHZ14K7Ij7hVcpD9k3ch25fY6XQXR8uRx
         P5a8gcSSh5h/Lhs/+uj1LkjhCTAfcjALtCkJsQZahYLm8/4KdwNHd9LmVU+fx8HwdQsT
         p3xLL++tFT0JWFi+BsAH8kdkLnjXrgG/1m+FMrq6neWq8V+CLrYPOx8cFhCrHK/W9ZeA
         UrwkV8O0rhXwAPjoRSvVTYuXweMuynPgVtCN1rOkaQJY1N7kLLIFjcfYrMy7dZ+UcxI9
         DGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rck8/FEuhZTWSFfXM5diXJpeeR+/DrL1slg/hOjAZpA=;
        b=De71AcWKQqdkUUW7aRbqvODGcyXypCqKcAHvpgaVBvZSAntowsyprB/b2p1ETtJihe
         VhBmr8vRclr8l6FDyfnC75I8iRTv5zX1RHYXNo3R1L1UiP/E0z7MMIPKZpIrJMisCcbr
         Q96Wq6lVLONWnnspBa+00acxeVxdAE2MHL6WiN7XQxHN43XO9KBwKXGREoJm4+ELG8J9
         h/BGZIV9BHE26iKcdUa85Xm3k+SA34GLDdcT67Mym8YYiNNzlcM/U1MERjCpEBuDU0Jn
         Dgt65ZazOiGvJmqOi1CDlYLfEmFDzztekY5FipH44fMhq6IXZnCXMYIU/PHQccSSopke
         An3g==
X-Gm-Message-State: AOAM532cUJNKaryXcTgoAzAMTF33e2uuFGhVT6ypGTBWaKIEDpyJxX5P
        qQNUFDAR+0kg4KxeQamSPCR997jeoWQVdvyoaijxoOYIlKc=
X-Google-Smtp-Source: ABdhPJz92WkowLo3DpuF7b7XO0D5g54NT+tPm3BV1CjStl4yMCkDJNaI8VrQTV/db46FspU2N3kgXnsRnO6RBdBLCiM=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr6517146ybj.504.1633732054512;
 Fri, 08 Oct 2021 15:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-14-fallentree@fb.com>
In-Reply-To: <20211006185619.364369-14-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 15:27:23 -0700
Message-ID: <CAEf4BzZ4vUndS=sLN6qVo4P3MXW+QE2R2Xm-BPYsXWsaFNft6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 13/14] selftests/bpf: increase loop count for perf_branches
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This make this test more likely to succeed.
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---

100 million iterations seems a bit excessive. Why one million loops
doesn't cause a single perf event? Can we make it more robust in some
other way that is not as slow? I've dropped it for now while we
discuss.


>  tools/testing/selftests/bpf/prog_tests/perf_branches.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> index 6b2e3dced619..d7e88b2c5f36 100644
> --- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> @@ -16,7 +16,7 @@ static void check_good_sample(struct test_perf_branches *skel)
>         int duration = 0;
>
>         if (CHECK(!skel->bss->valid, "output not valid",
> -                "no valid sample from prog"))
> +                "no valid sample from prog\n"))
>                 return;
>
>         /*
> @@ -46,7 +46,7 @@ static void check_bad_sample(struct test_perf_branches *skel)
>         int duration = 0;
>
>         if (CHECK(!skel->bss->valid, "output not valid",
> -                "no valid sample from prog"))
> +                "no valid sample from prog\n"))
>                 return;
>
>         CHECK((required_size != -EINVAL && required_size != -ENOENT),
> @@ -84,7 +84,7 @@ static void test_perf_branches_common(int perf_fd,
>         if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
>                 goto out_destroy;
>         /* spin the loop for a while (random high number) */
> -       for (i = 0; i < 1000000; ++i)
> +       for (i = 0; i < 100000000; ++i)
>                 ++j;
>
>         test_perf_branches__detach(skel);
> --
> 2.30.2
>
