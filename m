Return-Path: <bpf+bounces-21518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CE684E77E
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151A01C21415
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41D08528E;
	Thu,  8 Feb 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfyDDHqz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897683CB4
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416094; cv=none; b=QA4tfvzSY6mesbvKw8qEKzszt7rubPnKFWIUjlNj8IagYQE92BDc1s9vuO47fMmTn80zOAQzteji4pfi+loIiXd371evBQ6msljz0Dv7HwYnlugrjcXCnm1XaoL4sRhkqadRyPpmiLCMCmDzZZ4xML6cqpEcS/kcsF61fYP3iB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416094; c=relaxed/simple;
	bh=koQPRzNQv+a2lmnxGDcJycWSUlZTuiVc+O+iTzp7Zrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndCoZpFtXJibhUdwm4i4R5JUk8m0KS75MCCD9BKxDy/rjNe6iGpSdCsZW8DF1jE9yPr07z5KpXjVpd8MJJyZPNcqc6iUi3adFhBXaTQJuOCy2astoyaeIgkGx9UJ15oUmvcaCaXz7kYoJuKJhNIBMF6ftsQxqGyn5RK7pzgKseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfyDDHqz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b519e438so27291a12.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 10:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707416092; x=1708020892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0sl79zOO5CGpFJ7tL5mm1ThR0aaYkO7LzBjcZ3883c=;
        b=ZfyDDHqzlHcYGUZj6nx+oznoyit2fJj21dK337i7qRzhGIUXdk8SI6Tcmcg1bXI+l0
         8shnJ8cNYtyo+eD6dKpwfow5Fl8lvgrvRNekWMPQQS9ifd/PBFSc2rK5g1oPE1zbgRCT
         5So4CG0hQ0Wo+EjvLEICDNVo2kflQKmBiyx5mC4XOTIrU6eK1e/o5j38TF5BZvtORxXW
         +9uuBcfaKKsBpSNqVxpRVmoRoQt3t7i72aoOk4ZyKUgpAuWJg48eSL2v16TlBSiiRh/Y
         YL7f/HTdYOxRmsuNZloFV20Mho2AGcgA/Ir0KbWrczKN5zySpzrGLzxDbxaBYSA386D6
         AhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707416092; x=1708020892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0sl79zOO5CGpFJ7tL5mm1ThR0aaYkO7LzBjcZ3883c=;
        b=g47eJCaO+jJszrGf/z/J6NLAnOvF9ucgoy5O9EZL2+ytNcYicKPAVoj4RQWMsNnIMc
         EJ/eZxdX6uvbME19JnSxj5w34nhLXoPmSBb2O8LvPX2dP0t+9BI3FypdB7SVWgh+6MUl
         F5zrqIrbY3wYfzu97/8cof+LTmL5fTyRqdcJpjNq7xU7yOfgvRHf88eEKY7hJTakNluy
         Ig1uzk0OQufaZQPIyCOl6ZXhRI6u/YNFaogoIR8UO4STp6xoQDisqg5D45n1QTWsYT+o
         XF1vNf8gU90hckG0R2vC9OOZeYe+G0fLJo1luGYz2S4E1t7L2mCHWkqR7/NwjYZQOVix
         e/6A==
X-Gm-Message-State: AOJu0Yxxb8+y07hKdMd9mD7dLhkLHDl4DbLcKi+Rdx5SA+vbTI1wWqHs
	ccXj3nqeYTx25xq2m2ck2dvjT5LDlrYOJ7yoH9AlKXzuka3bEAUdVnx2+6GeiuDsX3U9EK4+nD8
	vhwQUPFPuUCYdLEAVKvQYhZr4PnA=
X-Google-Smtp-Source: AGHT+IEhnuRwcKP301sdNI0p01YbcHZp4ZbGXYrUTNPd3Xb9pV5Z1ubBIso+MDfgQAv7apNqva0X8qYw3AxC1d0YgYw=
X-Received: by 2002:a17:90a:e508:b0:296:cca0:ee34 with SMTP id
 t8-20020a17090ae50800b00296cca0ee34mr30332pjy.31.1707416092085; Thu, 08 Feb
 2024 10:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208063015.3893418-1-yonghong.song@linux.dev>
In-Reply-To: <20240208063015.3893418-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Feb 2024 10:14:40 -0800
Message-ID: <CAEf4BzbV6oEn80DyNwHqz6SH=zE1M5fXSako4x_O-N8O7PV+1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix test verif_scale_strobemeta_subprogs
 failure due to llvm19
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:30=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
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
>   - test_global_funcs/global_func1, adjusted to interpreter only since ve=
rification will
>     succeed in jit mode. A new test will be added for jit mode later.
>   - async_stack_depth/{pseudo_call_check, async_call_root_check}, adjuste=
d based on
>     new stack size calculation.
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
> +
>         RUN_TESTS(test_global_func2);
>         RUN_TESTS(test_global_func3);
>         RUN_TESTS(test_global_func4);
> diff --git a/tools/testing/selftests/bpf/progs/async_stack_depth.c b/tool=
s/testing/selftests/bpf/progs/async_stack_depth.c
> index 3517c0e01206..a03f313b7482 100644
> --- a/tools/testing/selftests/bpf/progs/async_stack_depth.c
> +++ b/tools/testing/selftests/bpf/progs/async_stack_depth.c
> @@ -30,7 +30,7 @@ static int bad_timer_cb(void *map, int *key, struct bpf=
_timer *timer)
>  }
>
>  SEC("tc")
> -__failure __msg("combined stack size of 2 calls is 576. Too large")
> +__failure __msg("combined stack size of 2 calls is 544. Too large")

maybe it's better to adjust existing test to fail in both JIT and !JIT
modes, just not expect exact size in message. I.e., truncate the
message to just "combined stack size of 2 calls is") and be done with
it?

>  int pseudo_call_check(struct __sk_buff *ctx)
>  {
>         struct hmap_elem *elem;
> @@ -45,7 +45,7 @@ int pseudo_call_check(struct __sk_buff *ctx)
>  }
>
>  SEC("tc")
> -__failure __msg("combined stack size of 2 calls is 608. Too large")
> +__failure __msg("combined stack size of 2 calls is 576. Too large")
>  int async_call_root_check(struct __sk_buff *ctx)
>  {
>         struct hmap_elem *elem;
> --
> 2.39.3
>

