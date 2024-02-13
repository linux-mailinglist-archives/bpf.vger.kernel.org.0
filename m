Return-Path: <bpf+bounces-21877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E947853ACE
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11ACD1F2231E
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2525605D0;
	Tue, 13 Feb 2024 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKejL25s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05FD57883
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852083; cv=none; b=L9im0XE4aJUpj3+J1rqeBdyOSLM+x3Je/9q2lHIYhYwclLxQOzEp2NKsy8enP/+1AXQkINg3xNN3g0QIwyUhoKKmdBwbwDKMJplxuJhKedQI2vksyNySdbOiKb9oUPKafFEmEzcHma74/YhoV2TWabOoxGdbsVtsX5o6ThrXwZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852083; c=relaxed/simple;
	bh=5YocGEpS6SRL+JgmdutbRvvDeBGg0FokNWsNOzVHxkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqGIS/XjTwSuwiFuJPEesniJU4C0t3bgGTc335sjObE6XfLBz4Kq9qJ/ZBplqTb2uPMIW5lCBO5cDw9mPa3fcGWtz6ELiy88Yanh7xYG3dw15J8a9Z7SS9b6mrJxzRw35q0vPXsvfpPXeiI6MXyory+So9sprLZijU7+xQjjrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKejL25s; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-290fb65531eso930496a91.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 11:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707852080; x=1708456880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE6/ca+PGmfF5GaqtxZaSvhN+dnCSVu3MKqxUjVq6AU=;
        b=PKejL25s75go0i6JSa1mldiu+C79QjZN4CBT63zrNVVd6FQtbM2fGtMNkjARrIuIYP
         GouskIapb7vy05P9EGQde1e4XfB8p74/+gfZYiARUA7DP/66NuORw4V3deeNzevnPt+6
         EhawtB7rxgDrzPIzpKiEiA+rT/kAUEeK2Qm5QTTKf3d/+vZn6n9RSQHNkTb8McKPiBaa
         o3GdN5OvYlBFMnyIQsTnkOEkOZ+cRYQfc7ixv2Gu1roT2pVfvs2NdjrDaKx/fvOhEafk
         skzy7R2k4GUVDWFFjjSXNliWy0GJiYGAkEpYyq/MrAtMKtb/f3Vequ2Lw+5fPIROwo05
         MMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707852080; x=1708456880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LE6/ca+PGmfF5GaqtxZaSvhN+dnCSVu3MKqxUjVq6AU=;
        b=gGO2F5s6XrHjB/Hb7Gz2eEeHBTxEa57HriQ4Axoe+JousJMrsI8vJZJl8yPGuS484y
         fzfemfephlMjuNZ+xlmpGt+S/gxlqc/xrFW52UlomE908y98fMjq8SWFlRFR9a0x12f9
         nGgcjkQy/ya+KnXiv3pRcB5Px6ONqWu3vUd68fjoXa5hUPEIcgf3WK5AyWI7laNITbLU
         GlFpVXVkMYYec4DD/eAEC5ulsz/6gGZW+84GcoLI2xgvQKzD6GeYH1dw9UF1MSbq3TFu
         VnOosXaQTLR1E+iU1MjRIKiUwtRSCEALX6mN4ABLW5EQJLIvtRJhwBDvIUq3/4QkXO+Q
         jZ1A==
X-Gm-Message-State: AOJu0Yx81JTnFioBABdFiL+RJchL2qNQy44agdo0yXEPlaIdQjb6I1bl
	nV9RGnBsZb6ofz25vmg9o/uFuNdy/rHI8riBsO35+alGpvYibAA+vn7uADFaKLcOb0SHX4SW3KA
	XI/nn0Dk1HFGXHMkf27XRdxZ/Rec=
X-Google-Smtp-Source: AGHT+IG60evpPIsIHUSa/K083MEaXyjfnSrTrznADhP8YRi0deNxffi6CMiTCd5I3POLVcbF8bbr5XzPrK2BebY5Ke0=
X-Received: by 2002:a17:90a:17a2:b0:295:cfb4:9d4c with SMTP id
 q31-20020a17090a17a200b00295cfb49d4cmr394072pja.33.1707852080118; Tue, 13 Feb
 2024 11:21:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208215422.110920-1-yonghong.song@linux.dev>
In-Reply-To: <20240208215422.110920-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 11:21:08 -0800
Message-ID: <CAEf4Bza9Z8v5ATLv0jctbP1rmQ0QOcWr6JHh4903cBW77GF0nQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix test verif_scale_strobemeta_subprogs
 failure due to llvm19
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 1:54=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> With latest llvm19, I hit the following selftest failures with
>
>   $ ./test_progs -j
>   libbpf: prog 'on_event': BPF program load failed: Permission denied
>   libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
>   combined stack size of 4 calls is 544. Too large
>   verification time 1344153 usec
>   stack depth 24+440+0+32
>   processed 51008 insns (limit 1000000) max_states_per_insn 19 total_stat=
es 1467 peak_states 303 mark_read 146
>   -- END PROG LOAD LOG --
>   libbpf: prog 'on_event': failed to load: -13
>   libbpf: failed to load object 'strobemeta_subprogs.bpf.o'
>   scale_test:FAIL:expect_success unexpected error: -13 (errno 13)
>   #498     verif_scale_strobemeta_subprogs:FAIL
>
> The verifier complains too big of the combined stack size (544 bytes) whi=
ch
> exceeds the maximum stack limit 512. This is a regression from llvm19 ([1=
]).
>
> In the above error log, the original stack depth is 24+440+0+32.
> To satisfy interpreter's need, in verifier the stack depth is adjusted to
> 32+448+32+32=3D544 which exceeds 512, hence the error. The same adjusted
> stack size is also used for jit case.
>
> But the jitted codes could use smaller stack size.
>
>   $ egrep -r stack_depth | grep round_up
>   arm64/net/bpf_jit_comp.c:       ctx->stack_size =3D round_up(prog->aux-=
>stack_depth, 16);
>   loongarch/net/bpf_jit.c:        bpf_stack_adjust =3D round_up(ctx->prog=
->aux->stack_depth, 16);
>   powerpc/net/bpf_jit_comp.c:     cgctx.stack_size =3D round_up(fp->aux->=
stack_depth, 16);
>   riscv/net/bpf_jit_comp32.c:             round_up(ctx->prog->aux->stack_=
depth, STACK_ALIGN);
>   riscv/net/bpf_jit_comp64.c:     bpf_stack_adjust =3D round_up(ctx->prog=
->aux->stack_depth, 16);
>   s390/net/bpf_jit_comp.c:        u32 stack_depth =3D round_up(fp->aux->s=
tack_depth, 8);
>   sparc/net/bpf_jit_comp_64.c:            stack_needed +=3D round_up(stac=
k_depth, 16);
>   x86/net/bpf_jit_comp.c:         EMIT3_off32(0x48, 0x81, 0xEC, round_up(=
stack_depth, 8));
>   x86/net/bpf_jit_comp.c: int tcc_off =3D -4 - round_up(stack_depth, 8);
>   x86/net/bpf_jit_comp.c:                     round_up(stack_depth, 8));
>   x86/net/bpf_jit_comp.c: int tcc_off =3D -4 - round_up(stack_depth, 8);
>   x86/net/bpf_jit_comp.c:         EMIT3_off32(0x48, 0x81, 0xC4, round_up(=
stack_depth, 8));
>
> In the above, STACK_ALIGN in riscv/net/bpf_jit_comp32.c is defined as 16.
> So stack is aligned in either 8 or 16, x86/s390 having 8-byte stack align=
ment and
> the rest having 16-byte alignment.
>
> This patch calculates total stack depth based on 16-byte alignment if jit=
 is requested.
> For the above failing case, the new stack size will be 32+448+0+32=3D512 =
and no verification
> failure. llvm19 regression will be discussed separately in llvm upstream.
>
> The verifier change caused three test failures as these tests compared me=
ssages
> with stack size. More specifically,
>   - test_global_funcs/global_func1: adjusted to interpreter only since ve=
rification will
>     succeed in jit mode. A new test will be added for jit mode later.
>   - async_stack_depth/{pseudo_call_check, async_call_root_check}: since j=
it and interpreter
>     will calculate different stack sizes, the failure msg is adjusted to =
omit those
>     specific stack size numbers.
>
>   [1] https://lore.kernel.org/bpf/32bde0f0-1881-46c9-931a-673be566c61d@li=
nux.dev/
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c                          | 18 +++++++++++++-----
>  .../bpf/prog_tests/test_global_funcs.c         |  5 ++++-
>  .../selftests/bpf/progs/async_stack_depth.c    |  4 ++--
>  3 files changed, 19 insertions(+), 8 deletions(-)
>
> Changelogs:
>   v2 -> v3:
>     - fix async_stack_depth test failure if jit is turned off
>   v1 -> v2:
>     - fix some selftest failures
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ddaf09db1175..6441a540904b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5812,6 +5812,17 @@ static int check_ptr_alignment(struct bpf_verifier=
_env *env,
>                                            strict);
>  }
>
> +static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_=
depth)
> +{
> +       if (env->prog->jit_requested)
> +               return round_up(stack_depth, 16);
> +
> +       /* round up to 32-bytes, since this is granularity
> +        * of interpreter stack size
> +        */
> +       return round_up(max_t(u32, stack_depth, 1), 32);
> +}
> +
>  /* starting from main bpf function walk all instructions of the function
>   * and recursively walk all callees that given function can call.
>   * Ignore jump and exit insns.
> @@ -5855,10 +5866,7 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx)
>                         depth);
>                 return -EACCES;
>         }
> -       /* round up to 32-bytes, since this is granularity
> -        * of interpreter stack size
> -        */
> -       depth +=3D round_up(max_t(u32, subprog[idx].stack_depth, 1), 32);
> +       depth +=3D round_up_stack_depth(env, subprog[idx].stack_depth);
>         if (depth > MAX_BPF_STACK) {
>                 verbose(env, "combined stack size of %d calls is %d. Too =
large\n",
>                         frame + 1, depth);
> @@ -5952,7 +5960,7 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx)
>          */
>         if (frame =3D=3D 0)
>                 return 0;
> -       depth -=3D round_up(max_t(u32, subprog[idx].stack_depth, 1), 32);
> +       depth -=3D round_up_stack_depth(env, subprog[idx].stack_depth);
>         frame--;
>         i =3D ret_insn[frame];
>         idx =3D ret_prog[frame];
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b=
/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> index e905cbaf6b3d..a3a41680b38e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> @@ -138,7 +138,10 @@ static void subtest_ctx_arg_rewrite(void)
>
>  void test_test_global_funcs(void)
>  {
> -       RUN_TESTS(test_global_func1);
> +       if (!env.jit_enabled) {
> +               RUN_TESTS(test_global_func1);
> +       }

Can we increase the amount of used stack size to make it fail
regardless of JIT? That's what I was asking on v1, actually. We have
those arbitrarily sized buf[256] and buf[300], what prevents us from
making them a few bytes bigger to not be affected by 16 vs 32 byte
rounding?


> +
>         RUN_TESTS(test_global_func2);
>         RUN_TESTS(test_global_func3);
>         RUN_TESTS(test_global_func4);
> diff --git a/tools/testing/selftests/bpf/progs/async_stack_depth.c b/tool=
s/testing/selftests/bpf/progs/async_stack_depth.c
> index 3517c0e01206..36734683acbd 100644
> --- a/tools/testing/selftests/bpf/progs/async_stack_depth.c
> +++ b/tools/testing/selftests/bpf/progs/async_stack_depth.c
> @@ -30,7 +30,7 @@ static int bad_timer_cb(void *map, int *key, struct bpf=
_timer *timer)
>  }
>
>  SEC("tc")
> -__failure __msg("combined stack size of 2 calls is 576. Too large")
> +__failure __msg("combined stack size of 2 calls is")
>  int pseudo_call_check(struct __sk_buff *ctx)
>  {
>         struct hmap_elem *elem;
> @@ -45,7 +45,7 @@ int pseudo_call_check(struct __sk_buff *ctx)
>  }
>
>  SEC("tc")
> -__failure __msg("combined stack size of 2 calls is 608. Too large")
> +__failure __msg("combined stack size of 2 calls is")
>  int async_call_root_check(struct __sk_buff *ctx)
>  {
>         struct hmap_elem *elem;
> --
> 2.39.3
>

