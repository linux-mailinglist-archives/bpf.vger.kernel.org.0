Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D444627EE
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 00:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhK2XPz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 18:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbhK2XPq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 18:15:46 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16BDC0C20C5
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 14:52:58 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id v138so46796551ybb.8
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 14:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kYmBGF67/pAyT07WaCOIi5zWPZO4b50NU0R2MXiWPM=;
        b=SqI/jk5k0RhgmYXYCrluaeGSvkZotVNqmrP/sggo+hkRrX87IT8hiWmoWVhQsuy8M1
         ZX3O5dvN3AWMVklbcV7wn8hRE6aYZ5TcI1XkA5fT3kPBJiUndHZCE2Yr4iZbAHvnrqeC
         hyw/bUIKIM4uSfucOL0Kz3nC5+LX81mxphOpDmTonEAk0paq7CM/dudNbV6hjDuqx1ty
         u2MNtvl4YzLlYIdGrmABp789h2A292iLyV4gdWdKg65ZxqI0HVWSWHO+a+K064TnCDve
         QCFGut8GiWWgApvMkCX+7IWKs3kb1AcrkL1Dt3qyjUH6xv7KPm26k6xISob35gzPvmTb
         vagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kYmBGF67/pAyT07WaCOIi5zWPZO4b50NU0R2MXiWPM=;
        b=IYqxZQUz0Ss887jLhoYqWHkQyrgvfdXmEmkDaVQSEqYEjzN8WzWxkbNia4rCvTkE9a
         tf5NvXzss6vulEzw3MLBU13u4E+wxZmnURsyqB/brgc4SFy1rFVF6QH7PMSNa8hf2AuR
         ++xTaMuUGIFu6WmRYfFaCa1pN5G+z0JpXEfRPhxSmgdnp4HGGsMl88DZh4T1I+qR48gx
         zBl5lI+EKHhdqfzuI7G8KzvAj7pPUzBBaFuFcQrXA/3EEJFGSJSSspSx19rYt5s4e5Ul
         YTJigOVfjv0NJrVHvqb1mq6oxVRTOCzPk+Eg67Mav2PYTIjFLKLtY+u4wytsdZLUXx2Z
         aGMA==
X-Gm-Message-State: AOAM532JJmCP09VsXKbR1WrxG3v9LDGJ7aG4YGQ4ZbX1PmJ4Wx2ULXOA
        HzzGMKFiJBT+n65kjqNy72kMzRboNA0kvyQM2l8=
X-Google-Smtp-Source: ABdhPJxEjUh+qp2+Ge4pp6eV9UFd2TOi66fqm2DY0umlyJXpaExrU/7WjoBvi8lCzfM2fZMY+weSZ3tvUbHbHUrz/4Q=
X-Received: by 2002:a25:e617:: with SMTP id d23mr9433133ybh.555.1638226378139;
 Mon, 29 Nov 2021 14:52:58 -0800 (PST)
MIME-Version: 1.0
References: <20211129223725.2770730-1-joannekoong@fb.com> <20211129223725.2770730-3-joannekoong@fb.com>
In-Reply-To: <20211129223725.2770730-3-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 14:52:46 -0800
Message-ID: <CAEf4BzbCnkocXKARDKAYtxJjWrn1k03J0B5CEG0PL-w+yaZQqA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/4] selftests/bpf: Add bpf_loop test
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 2:39 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> Add test for bpf_loop testing a variety of cases:
> various nr_loops, null callback ctx, invalid flags, nested callbacks.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---

LGTM, one small nit below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/bpf_loop.c       | 138 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/bpf_loop.c  |  99 +++++++++++++
>  2 files changed, 237 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_loop.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_loop.c
>

> +       err = bpf_prog_test_run(bpf_program__fd(skel->progs.test_prog),
> +                               1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
> +                               &retval, &duration);
> +       if (!ASSERT_OK(err, "err") || !ASSERT_OK(retval, "retval"))
> +               return;

Still think that usleep(1) is better and cleaner... pkt_v4 has nothing
to do with what you are testing.

> +       ASSERT_EQ(skel->bss->nr_loops_returned, skel->bss->nr_loops,
> +                 "0 loops");
> +
> +       /* test 500 loops */
> +       skel->bss->nr_loops = 500;

[...]
