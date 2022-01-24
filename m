Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302B949A8AB
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 05:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345457AbiAYDK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 22:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3411960AbiAYAfP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 19:35:15 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780A8C0DED57
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 14:18:54 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id h7so3459811iof.3
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 14:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VpMGjm8B3WeQMaK4KBi8d6s9JCr8gZTs3NSZcb1bGSQ=;
        b=XI1pHUfc2pW4d8HUSJpdwe0ZSCnnSPQ8O+n1C42U4hfjvT8URX//WPVfnh2kJe8wmk
         1YThtR3VCxkEg94JYIep02cKn/PVStVVLkpBGB0dgVVpwXhywz3ZQCK45ZxZhL9LyXGR
         fGvqSG2ML3l7pmSJIfeo/IFARSDGxhh+xU6wT5CjBkq7latN9JfFcergZ1PLNismmISD
         4zEJgiv4zESLjbr2W0/dGhhJr5dYScLB9VUSwuQQOsCXJYUmJWbi6WR9a/4f5Yti9us2
         ZdU0pR3lUAfQkXIoIhuQ/bz8rpjlXcSEuNgAr2qpxw2hZMp98vKiSFTkGrUXTz3LiqJ/
         BEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpMGjm8B3WeQMaK4KBi8d6s9JCr8gZTs3NSZcb1bGSQ=;
        b=q8uQgnId46nryAD8VFW30OEt7ngxiR0fjglW2NUdwhKsv66J5EEdtOeKtqC/JAy3/V
         tP5Y4KenB/Hgx2ooxdXYi7KHiuKA+PKkL9wZu+crCJ2DeGZRn7Tba0BuZflyIGRzNm3u
         3otOaKwM+0KkVvU/dzKYnFwOxJWE5ricKsBK/cxQd6QEtndWZH2tEX7HvPu+viDGPW/V
         Km+d/qNigJdW6sHQeo2VzQ2T4H8gnpr128J0Z1orE1fplO8ti2ANjcL5dM+GBRI6zg3y
         vrCSF0k1qa5r5PuQzAbtMV6nA8oOQsAiyWjitY+wuaf47FddzRWZbp14KS0Vyc11LJXc
         XlOw==
X-Gm-Message-State: AOAM533NRyedx0LGqiqsa73DB5oM8a+2hdtrlWyYXZEq2SUqHAXHkkHe
        fnqQWBrQEZcNQnzprFIA0y9f4R4H4NhLn+Kad3I=
X-Google-Smtp-Source: ABdhPJyG2fqPBpjeOKqyG+4tYytdBCXyZZcqJqqu7Jvct7PgGL6+8lUYsMreYGwxZSOE5WkHDsIw6Z0vGN/jck4lEjg=
X-Received: by 2002:a5d:9f01:: with SMTP id q1mr9310438iot.144.1643062733876;
 Mon, 24 Jan 2022 14:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220124185403.468466-1-kennyyu@fb.com>
 <20220124185403.468466-3-kennyyu@fb.com>
In-Reply-To: <20220124185403.468466-3-kennyyu@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Jan 2022 14:18:42 -0800
Message-ID: <CAEf4BzbQQNH1=UGNLBhb8bXZzdE7uHviJ3k8vEKDg_72407aYg@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 2/4] bpf: Add bpf_copy_from_user_task() helper
To:     Kenny Yu <kennyyu@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Gabriele <phoenix1987@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 24, 2022 at 10:54 AM Kenny Yu <kennyyu@fb.com> wrote:
>
> This adds a helper for bpf programs to read the memory of other
> tasks.
>
> As an example use case at Meta, we are using a bpf task iterator program
> and this new helper to print C++ async stack traces for all threads of
> a given process.
>
> Signed-off-by: Kenny Yu <kennyyu@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       | 11 +++++++++++
>  kernel/bpf/helpers.c           | 34 ++++++++++++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c       |  2 ++
>  tools/include/uapi/linux/bpf.h | 11 +++++++++++
>  5 files changed, 59 insertions(+)
>

[...]

> +       ret = access_process_vm(tsk, (unsigned long)user_ptr, dst, size, 0);
> +       if (ret == size)
> +               return 0;
> +
> +       memset(dst, 0, size);
> +       /* Return -EFAULT for partial read */
> +       return (ret < 0) ? ret : -EFAULT;

nit: unnecessary ()

> +}
> +
> +const struct bpf_func_proto bpf_copy_from_user_task_proto = {
> +       .func           = bpf_copy_from_user_task,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_PTR_TO_UNINIT_MEM,
> +       .arg2_type      = ARG_CONST_SIZE_OR_ZERO,
> +       .arg3_type      = ARG_ANYTHING,
> +       .arg4_type      = ARG_PTR_TO_BTF_ID,
> +       .arg4_btf_id    = &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
> +       .arg5_type      = ARG_ANYTHING
> +};
> +

[...]
