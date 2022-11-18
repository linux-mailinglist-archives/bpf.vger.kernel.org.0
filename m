Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D6B62FF96
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 22:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiKRVrE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 16:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiKRVrB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 16:47:01 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C609FA8163
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 13:46:59 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id c129so6818694oia.0
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 13:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8SwupCC3PnJevqOfbcgELwBkhH/r0fIRZTWdXdXVm8=;
        b=JoS4FQ3jGIbrUWEiixI+pP/r8BqqyWqF3njCsjlrZGI8kDN2EZjoUz/7J5Mn9sYp2+
         sjM8pDV9oQ1dwrGSiLHdmbvXWVsYJJw8lv41nwf4uNTMBFTbx6kgbbqz3DIUYkZQbN1b
         2IPNv7n/8TLBom4VhAwJv0DcAeOp/KELU2IMiz9odN2YgsCPM7qiBZaS9F1x3zGk6hp3
         XkM+jxZmOXa7PKV73AUS2ZHCO9/IwD3IOgBRBCKvV8ImSzrvBwCwp1Z7XyYG6A09xWby
         OTfZrI6NDYWRfW5P8LrwlyOajkOTGwM9ppKRYAtYNzDVtU5ajVQsk0DAmIooRwOl61sv
         dn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8SwupCC3PnJevqOfbcgELwBkhH/r0fIRZTWdXdXVm8=;
        b=hhnXcw/WlDAzUwQIDmdwjewjMZ8YWWBgI13vpMIP9PWCp08Zk6bJzuzKEz1k0JAC+k
         kLyzn2c6A9sqRJK9nVpsCBdvHbsKB40wW9suFnzMdYCDmZ8UcAOMeQ/pyACwUn53XICp
         3jH9t50rbq48wPjR2UDCmz5AdNHQe3nfxsTxT/XZNXVvN/5NSw/uyon/6M801eij3vAF
         ChyS9fPrg/tj594PGmQxvhifUffWKSbFzL1aFBoJ8Vh2Fcu6ntq9aDYIKiW4uEcoc0Q3
         /IJj6QeQUcpVNEQMcHxg6TOhFipeoBX3iGI6Gcy1y/TRxGE5wxq+ZyesdShms1uErf2y
         j04Q==
X-Gm-Message-State: ANoB5pm61N0BzEjTbaa7ZeGS/1vufxZv3kttMooN1yr3eUyvImcNqrcY
        P13WFUX9SvUDLiNH482QFoe/hWLnxLkFEWWex8SOaw==
X-Google-Smtp-Source: AA0mqf6cv9dRAqebAhbfTEwCDiEZ4myphsALErZIJDcguXct6tC+6AHPYPCuvs5ID42pEGBlG/jMfh++srMz5k/Wz+o=
X-Received: by 2002:a05:6808:f09:b0:354:8922:4a1a with SMTP id
 m9-20020a0568080f0900b0035489224a1amr4378524oiw.181.1668808018993; Fri, 18
 Nov 2022 13:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20221118183409.give.387-kees@kernel.org>
In-Reply-To: <20221118183409.give.387-kees@kernel.org>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 18 Nov 2022 13:46:48 -0800
Message-ID: <CAKH8qBskaeP6BqkNKjZQ0Bvj+48t+yLxYbXcLxCyyEOXQCuJyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf/verifier: Use kmalloc_size_roundup() to
 match ksize() usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 10:34 AM Kees Cook <keescook@chromium.org> wrote:
>
> Most allocation sites in the kernel want an explicitly sized allocation
> (and not "more"), and that dynamic runtime analysis tools (e.g. KASAN,
> UBSAN_BOUNDS, FORTIFY_SOURCE, etc) are looking for precise bounds checking
> (i.e. not something that is rounded up). A tiny handful of allocations
> were doing an implicit alloc/realloc loop that actually depended on
> ksize(), and didn't actually always call realloc. This has created a
> long series of bugs and problems over many years related to the runtime
> bounds checking, so these callers are finally being adjusted to _not_
> depend on the ksize() side-effect, by doing one of several things:
>
> - tracking the allocation size precisely and just never calling ksize()
>   at all[1].
>
> - always calling realloc and not using ksize() at all. (This solution
>   ends up actually be a subset of the next solution.)
>
> - using kmalloc_size_roundup() to explicitly round up the desired
>   allocation size immediately[2].
>
> The bpf/verifier case is this another of this latter case, and is the
> last outstanding case to be fixed in the kernel.
>
> Because some of the dynamic bounds checking depends on the size being an
> _argument_ to an allocator function (i.e. see the __alloc_size attribute),
> the ksize() users are rare, and it could waste local variables, it
> was been deemed better to explicitly separate the rounding up from the
> allocation itself[3].
>
> Round up allocations with kmalloc_size_roundup() so that the verifier's
> use of ksize() is always accurate.
>
> [1] e.g.:
>     https://git.kernel.org/linus/712f210a457d
>     https://git.kernel.org/linus/72c08d9f4c72
>
> [2] e.g.:
>     https://git.kernel.org/netdev/net-next/c/12d6c1d3a2ad
>     https://git.kernel.org/netdev/net-next/c/ab3f7828c979
>     https://git.kernel.org/netdev/net-next/c/d6dd508080a3
>
> [3] https://lore.kernel.org/lkml/0ea1fc165a6c6117f982f4f135093e69cb884930.camel@redhat.com/
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3:
> - memory leak already taken into -next (daniel)
> - improve commit log (daniel)
> - drop optimization patch for now (sdf)
> v2: https://lore.kernel.org/lkml/20221029024444.gonna.633-kees@kernel.org/
> v1: https://lore.kernel.org/lkml/20221018090550.never.834-kees@kernel.org/
> ---
>  kernel/bpf/verifier.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index beed7e03addc..c596c7c75d25 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1010,9 +1010,9 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
>         if (unlikely(check_mul_overflow(n, size, &bytes)))
>                 return NULL;
>
> -       if (ksize(dst) < bytes) {
> +       if (ksize(dst) < ksize(src)) {
>                 kfree(dst);
> -               dst = kmalloc_track_caller(bytes, flags);
> +               dst = kmalloc_track_caller(kmalloc_size_roundup(bytes), flags);
>                 if (!dst)
>                         return NULL;
>         }
> @@ -1029,12 +1029,14 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
>   */
>  static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
>  {
> +       size_t alloc_size;
>         void *new_arr;
>
>         if (!new_n || old_n == new_n)
>                 goto out;
>
> -       new_arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
> +       alloc_size = kmalloc_size_roundup(size_mul(new_n, size));
> +       new_arr = krealloc(arr, alloc_size, GFP_KERNEL);
>         if (!new_arr) {
>                 kfree(arr);
>                 return NULL;
> @@ -2506,9 +2508,11 @@ static int push_jmp_history(struct bpf_verifier_env *env,
>  {
>         u32 cnt = cur->jmp_history_cnt;
>         struct bpf_idx_pair *p;
> +       size_t alloc_size;
>
>         cnt++;
> -       p = krealloc(cur->jmp_history, cnt * sizeof(*p), GFP_USER);
> +       alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
> +       p = krealloc(cur->jmp_history, alloc_size, GFP_USER);
>         if (!p)
>                 return -ENOMEM;
>         p[cnt - 1].idx = env->insn_idx;
> --
> 2.34.1
>
