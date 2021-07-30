Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D4C3DBEF5
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 21:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhG3T1F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 15:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhG3T1D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 15:27:03 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FC4C06175F
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 12:26:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p145so3088945ybg.6
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOFajr7G7ynQh91Bpunjpsg8w2czzvlaeyCJusca3W0=;
        b=pfdxtkXPvmQ9cWfWyvJQYH9yhNvPKWDYK5Urg4j3NmkXH51GZKDnQ4BZCAwXflyZX7
         l5W6VIEzYxFtiKE7ujZsyLv9fLg0jm8b7JyeTVg97l6xiGsXgUUKdR0mv0NaLPfPV/UP
         5iJu0llvcSScNNaLc4TjSECQ1XIGv3ygE8ln+aTia9uVs65h9kr9G3y0Hk2pK+1XdRTz
         EgreqzMs0VYc9oYdKOnOk8dXZcIU6s5LhKTQDXy1LZP7y7d0D+NhFfgLyKKKR9uoh7WA
         0hsqLcJy8wC+j8CJw5zpejZB2lBCpn9uPKPZvMwlVu/E2wIMhmfpAZHVqm5KeTSCuUzh
         dNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOFajr7G7ynQh91Bpunjpsg8w2czzvlaeyCJusca3W0=;
        b=rCuwcjDI/g+E0KagUdziymvXtdv9qmK0zAhIXuq4mxPSBM+l76DATD8SvnqJN1tP7G
         +S4daw81PrdY8tJ6CTuN8vthg/gTEz4bqB7K16rZonRLFKUXbQ1NNp8wIxG2Vdpc9Dju
         vLM4t3FseNgx3r+M2xouNbzmqDCWUa6mM4MaQYfBEJIdl3tFL9Com2yjhse2jpAeUiXH
         GVKAX5oEjDxOIab+K+BkeV9LbTMAwSgyeyPPz7fVG6codr5Tu/N7byDsR+ZCk8G0VFWr
         H3L9wjGAitITkgs47vAUcdiFoBTxa05QM/HqMkNva6mH1/yT8ea+wPnZwpiJv/QTCLCm
         BnBQ==
X-Gm-Message-State: AOAM531ABJfUFTgFy6TPzWMRssjHnEajuK3euhnRn/desNrJ9O2yAJJk
        S89n8C7AJr5I4Bir4wWa0aijX1EaipJS27IZc5U=
X-Google-Smtp-Source: ABdhPJyQCWwAej1+GfHAn5Ni8txSTjxX0wU/mI97IgXOQ4XVFeekaqeu89dt8uaBB5mUemU0j56ZDvpJyObG48x+LU8=
X-Received: by 2002:a25:6148:: with SMTP id v69mr5098446ybb.510.1627673218049;
 Fri, 30 Jul 2021 12:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210730114012.494408-1-hengqi.chen@gmail.com>
In-Reply-To: <20210730114012.494408-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Jul 2021 12:26:46 -0700
Message-ID: <CAEf4BzbtPFEbme_KZQA+n-gCgC+xp-v+270BBCi+89smi6pzkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: add btf__load_vmlinux_btf/btf__load_module_btf
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 30, 2021 at 4:40 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add two new APIs: btf__load_vmlinux_btf and btf__load_module_btf.
> btf__load_vmlinux_btf is just an alias to the existing API named
> libbpf_find_kernel_btf, rename to be more precisely and consistent
> with existing BTF APIs. btf__load_module_btf can be used to load
> module BTF, add it for completeness. These two APIs are useful for
> implementing tracing tools and introspection tools. This is part
> of the effort towards libbpf 1.0. [1]
>
> [1] https://github.com/libbpf/libbpf/issues/280

I changed this to

[0] Closes: https://github.com/libbpf/libbpf/issues/280

which will close an associated Github issue when we sync sources to
Github next time. Let's see how this works in practice.

>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---

Thanks, applied to bpf-next. But please follow up with a selftest that
would utilize this new module BTF API. It's good to have all APIs
exercised regularly. Look at test_progs.

>  tools/lib/bpf/btf.c      | 15 ++++++++++++++-
>  tools/lib/bpf/btf.h      |  6 ++++--
>  tools/lib/bpf/libbpf.c   |  4 ++--
>  tools/lib/bpf/libbpf.map |  2 ++
>  4 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index cafa4f6bd9b1..56e84583e283 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4036,7 +4036,7 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
>                  */
>                 if (d->hypot_adjust_canon)
>                         continue;
> -
> +
>                 if (t_kind == BTF_KIND_FWD && c_kind != BTF_KIND_FWD)
>                         d->map[t_id] = c_id;
>
> @@ -4410,6 +4410,11 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
>   * data out of it to use for target BTF.
>   */
>  struct btf *libbpf_find_kernel_btf(void)

I switched this to __attribute__((alias("btf__load_vmlinux_btf"))); to
match what Quentin did recently. Also moved comment above to be next
to btf__load_vmlinux_btf.

> +{
> +       return btf__load_vmlinux_btf();
> +}
> +
> +struct btf *btf__load_vmlinux_btf(void)
>  {
>         struct {
>                 const char *path_fmt;

[...]

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 5aca3686ca5e..a2f471950213 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -380,4 +380,6 @@ LIBBPF_0.5.0 {
>                 btf__load_into_kernel;
>                 btf_dump__dump_type_data;
>                 libbpf_set_strict_mode;
> +               btf__load_vmlinux_btf;
> +               btf__load_module_btf;

This list needs to be alphabetically sorted. I'll fix it up while
applying, but please remember it for the future.

>  } LIBBPF_0.4.0;
> --
> 2.25.1
>
