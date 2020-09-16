Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE15E26CB6A
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 22:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgIPRZW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgIPRZT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 13:25:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AF6C061A31
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:25:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so7679690wrn.13
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLIuBcEfXFqBGnCMg96s4H8fMHjOET/yZlTCC4s2SjY=;
        b=iSKsbfCaH85JTyF93w9TDVj+qgI43v1QxUEyWe0EQUbDc2aQHYBMp7y1gRr8uJgVuM
         1cVf+stUl9US5B0yTdv8lUKTKT+fgWT5ER7KxMErMG5bzGAZRoKGiAAiQD7o1yhB+czu
         N8jMTmR0u6nEsuq1VQl1fAx9EM4X/d/DETGps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLIuBcEfXFqBGnCMg96s4H8fMHjOET/yZlTCC4s2SjY=;
        b=i783LB5AwIB9KKWIz3b8eFwl0jJsINhA/vQbopARfWwgsfu6s4pqk9m5mkQilj4Ag4
         MaqZ31+OYp7UoB0KIaEheaK/dWcqWA8OZP6h7N2WGWakKzWMsxuf2VQxwHhy4GX79mPh
         AdOf0e9SRUe9mBelEjLCIFanRLfl/zpkUN/st5TPctF6Rxl3JjjyoHuVnF4kvutSGZXl
         ybmdQhCCO0gn2qLSRa1qsYxkRQqpIhisGL4QgVCaWPoDRfIjNv4iga3WV8OrVC7dL9YC
         76IsOGBaJqiFPpIZgHe1yyQdDhuLGKRN4WXLarhiKSMx/zrRyAxix3vOiKNmxyYOGSy0
         xU6w==
X-Gm-Message-State: AOAM533iAXoI/SqjFxUQEFEmqyhjiG5Csr1H66PTOJMx0QkPAbdHU1em
        KTW/dhc/vz+7WNRdLEn9a+hgyIPQYhlLZXZoMxcqfQ==
X-Google-Smtp-Source: ABdhPJzFG0CKotHKNUMxQnzas0sxg7FAmpAAmBAxshrbYB7YiD0VwMPfDZp16xsSPod2p+vLLrtXqNwlDt36g8M7VhU=
X-Received: by 2002:adf:e711:: with SMTP id c17mr28472007wrm.359.1600277113217;
 Wed, 16 Sep 2020 10:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200916112416.2321204-1-jolsa@kernel.org>
In-Reply-To: <20200916112416.2321204-1-jolsa@kernel.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 16 Sep 2020 19:25:02 +0200
Message-ID: <CACYkzJ7Y8WhVE9-6jSCC1svVLeuFFzXQ0Q-A9sjHomGQGgtZCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix stat probe in d_path test
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 16, 2020 at 1:24 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Some kernels builds might inline vfs_getattr call within fstat
> syscall code path, so fentry/vfs_getattr trampoline is not called.
>
> Alexei suggested [1] we should use security_inode_getattr instead,
> because it's less likely to get inlined.
>
> Adding security_inode_getattr to the d_path allowed list and
> switching the stat trampoline to security_inode_getattr.
>
> Adding flags that indicate trampolines were called and failing
> the test if any of them got missed, so it's easier to identify
> the issue next time.
>
> [1] https://lore.kernel.org/bpf/CAADnVQJ0FchoPqNWm+dEppyij-MOvvEG_trEfyrHdabtcEuZGg@mail.gmail.com/
> Fixes: e4d1af4b16f8 ("selftests/bpf: Add test for d_path helper")
> Signed-off-by: Jiri Olsa <jolsa@redhat.com>

Acked-by: KP Singh <kpsingh@google.com>

> ---
>  kernel/trace/bpf_trace.c                        | 1 +
>  tools/testing/selftests/bpf/prog_tests/d_path.c | 6 ++++++
>  tools/testing/selftests/bpf/progs/test_d_path.c | 9 ++++++++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index b2a5380eb187..1001c053ebb3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1122,6 +1122,7 @@ BTF_ID(func, vfs_truncate)
>  BTF_ID(func, vfs_fallocate)
>  BTF_ID(func, dentry_open)
>  BTF_ID(func, vfs_getattr)
> +BTF_ID(func, security_inode_getattr)
>  BTF_ID(func, filp_close)
>  BTF_SET_END(btf_allowlist_d_path)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
> index fc12e0d445ff..f507f1a6fa3a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> @@ -120,6 +120,12 @@ void test_d_path(void)
>         if (err < 0)
>                 goto cleanup;
>
> +       if (CHECK(!bss->called_stat || !bss->called_close,
> +                 "check",
> +                 "failed to call trampolines called_stat %d, bss->called_close %d\n",
> +                  bss->called_stat, bss->called_close))

optional:

maybe it's better to add two separate checks with specific error messages?

"stat", "trampoline for security_inode_getattr was not called\n"
"close", "trampoline for filp_close was not called\n"

I think this would make the output more readable.

- KP

> +               goto cleanup;
> +
>         for (int i = 0; i < MAX_FILES; i++) {
>                 CHECK(strncmp(src.paths[i], bss->paths_stat[i], MAX_PATH_LEN),
>                       "check",

[...]

>         if (pid != my_pid)
>                 return 0;
>
> --
> 2.26.2
>
