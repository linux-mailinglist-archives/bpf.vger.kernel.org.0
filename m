Return-Path: <bpf+bounces-21457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C684D6F0
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE5B1F24397
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 00:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A48E846B;
	Thu,  8 Feb 2024 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Krkts/A7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E68D502
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351036; cv=none; b=meipX/4HpBA7HR6HNDcuMLXOFn2zuVmqkPQ3ZxexyTFCD2vxLBYJLDMWzoK6K0cKVmWD3iq+0ktZomdYzNRY8ZS46hp7Poq7hghxWAj+PvIp9Wb+3egRykZ9xI8QAELy/XBEiURwleeK+liE8cLZIavwderWHqUtv0OFgWXemFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351036; c=relaxed/simple;
	bh=k9wgThYQJP/p/LXfhMkyLkX+DC+DcWkVD1fnIRGYMxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDFW5wNoKZRp9iwXuDY4MrpqLl4uKhM/V9Nhjcsny3rj9PwPiwa7Yo9smnpSnlh4NlypAygNVbnWmNTs2tGVylDrKp77yaDR85/x1g0WBEHR9ZuhEj+O3OdU4IRrjcZUS+WJHH9xVI8VV2ZCox65ZeBTv6GM6ZjlqRv1hMDjdzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Krkts/A7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e06725a08dso869248b3a.3
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 16:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707351034; x=1707955834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSxhu0NNvkMzlM9x4xh0XGzXv7b++GwmxfYGqYBvnos=;
        b=Krkts/A7b8v4dAs5BdVWJVQx1urI4iQbrpRrjrby6JN+psxy1bIeC0V1wWwzUHwlPD
         PRLggnEK1Y3Z/pYJPqwVLrYOYXrIoqcqn/mf8XAD21Eoq5i4SKHi3Ktp33z+p3/m5khS
         OJD6Y2oJ0XQHPftwEmal8WAuD2FlGKKoI6MpUn4jUrASVwhPcFdc2NqM02Bu+cZ33OQ/
         PUqVGcjUEjnsoioKjxPC3TTh4cZFji62VhhjIhucSvYtyXhYIHBTqgb73P5wG9hRQxT+
         YhsVdWXkbmUSGm+6xiXemNBtqJE8u9nEbp+HNMv0XPC5/w69FL0U2BeL7qsi3e70UtFo
         FTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707351034; x=1707955834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSxhu0NNvkMzlM9x4xh0XGzXv7b++GwmxfYGqYBvnos=;
        b=Uv9BY7g0vF2ywZ/64pl1SwwckOiBTfOMDvA5xlhEfdJxLi9Hrb0KyNalcskxjp/kdi
         4l6iqxxjH36/uXBTT8AjAIsX2QOEymgt5LkvphiYu9B/1rleV/0pZhYaAa5JpymeQDWH
         xI7ynDMUnlwExWEr5M7pMDukdTwQ/8iO64CStYvO6rK6Z8GfihcXFCgG5NfzF5olzX7o
         wgh2mhdVZHeFN0bpnNAOx21sxrBLOVxEWVrL+Mn8Gu81PKfaxGiik1NvLDnjQR7u7Zsv
         xTZuEAHRyYXtFAyvrQESUIYqMYmVmKuttKW/izF+TrUsVX/a5VIFE4rfAkBmbN42qaQE
         seBg==
X-Gm-Message-State: AOJu0YxsP/Mk9/wDDKzHbaGTcgfkysPbGiRk4aJTsPgOS/6YA2b4iRQq
	izcPpDQvkvAwfn5wxOyBKS5DDqsMtahdR3J6Yg1esq7b7KangR1+HVIMQ+oOclvbWZU/copsmqG
	KGhmfI04amaJ43uaXiuUJxko2f8I=
X-Google-Smtp-Source: AGHT+IH3c3vNiwKK4fe3edoyj7HfVsAaU5+iUt0ZOddMQ42msqjbvuNdKqhBdF+iieS3U1Skf4IXDPRpwL1Zv2HfWYU=
X-Received: by 2002:aa7:864f:0:b0:6e0:3c60:11c8 with SMTP id
 a15-20020aa7864f000000b006e03c6011c8mr4127905pfo.2.1707351034283; Wed, 07 Feb
 2024 16:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206063010.1352503-1-yonghong.song@linux.dev>
In-Reply-To: <20240206063010.1352503-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Feb 2024 16:10:22 -0800
Message-ID: <CAEf4Bzbg7Yzt7JdVWSPKnC6O3nhtOB6MqyfW5LOxqA+g6PStDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky test verif_scale_strobemeta_subprogs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 10:30=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
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
>   [1] https://lore.kernel.org/bpf/32bde0f0-1881-46c9-931a-673be566c61d@li=
nux.dev/
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Seems like a few selftests have to be adjusted, current BPF CI is unhappy (=
[0])

  [0] https://github.com/kernel-patches/bpf/actions/runs/7795686155/job/212=
59132248

pw-bot: cr

>  kernel/bpf/verifier.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ddaf09db1175..10e33d49ca21 100644
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
> @@ -5855,10 +5866,8 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx)
>                         depth);
>                 return -EACCES;
>         }
> -       /* round up to 32-bytes, since this is granularity
> -        * of interpreter stack size
> -        */
> -       depth +=3D round_up(max_t(u32, subprog[idx].stack_depth, 1), 32);
> +
> +       depth +=3D round_up_stack_depth(env, subprog[idx].stack_depth);
>         if (depth > MAX_BPF_STACK) {
>                 verbose(env, "combined stack size of %d calls is %d. Too =
large\n",
>                         frame + 1, depth);
> @@ -5952,7 +5961,7 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx)
>          */
>         if (frame =3D=3D 0)
>                 return 0;
> -       depth -=3D round_up(max_t(u32, subprog[idx].stack_depth, 1), 32);
> +       depth -=3D round_up_stack_depth(env, subprog[idx].stack_depth);
>         frame--;
>         i =3D ret_insn[frame];
>         idx =3D ret_prog[frame];
> --
> 2.34.1
>

