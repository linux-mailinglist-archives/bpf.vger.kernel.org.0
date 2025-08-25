Return-Path: <bpf+bounces-66399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABB7B34567
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 17:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3144A3AC2BC
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B6029D05;
	Mon, 25 Aug 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AySsbsYA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945291A4F12
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135050; cv=none; b=Ivfk4iMsk3gE+FomQ9klxE2K/5PQlRAqSGTWd8qdWwQQagZK8hi6RCYhqRxZOeGlltZA6XhqvGAVxzXYLaZWUkglAsxRS/iUsY06eS8ltBnC45l5FLytm+2QiKNE4QILGJ6jCirtArv5AE73Hg98+zRUP1518dOFwbWBTnc3g4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135050; c=relaxed/simple;
	bh=mMOVfydwjuOTNxvVBf8/oh7qpgpuHk/9b1SfQt++/AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHegNzYbhBI4AWbhK7L0Jbt6bzolQ09F7lSRGsqfhjCeJ+zhp1UBiPhqYDeodtgN/HR1lgSbn8KYtvPylFK8YE9SzxQcK0ALXPylQDWHZkHgG3orFyDY7YuaN1sXcWLE73lJdB/HltjiyCzPkHeipl/9RnlqJjY9Oay6ByFYwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AySsbsYA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c985f13d45so641269f8f.1
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756135047; x=1756739847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQE3kEWFJH4aOtDhU1czHqkXqXB6noac/IQm25z+mVg=;
        b=AySsbsYAIvGagbfUOvRgFH8+J9y7E88xN7WTumHTJFZ5qfPUUtIunaZs8OnQqM9ym1
         dFIUFRSadyjkJ5qTijVJF37sGtixYu4k/nyk/KJQsNj78+L6KwCwqc+EGraw0EZhrubO
         ySF2DUUGz++7MxA4rH5T3usKvtwEmOO96B6htr4uwy1mVm5jg7a2M3TeuQWmoUj7biJT
         flSVynIG9xWkjkm2uHDW16ahSaPNM5TX+VO7HqX/xoT6AREBTyXyz59QccuMDz6uBTyj
         Tz8OtR3fGggIalU8QAIn52KqoWauZig5eW9/ssu/iXQytBRz5134rLmOVU/RaCheHkea
         +9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756135047; x=1756739847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQE3kEWFJH4aOtDhU1czHqkXqXB6noac/IQm25z+mVg=;
        b=NoMGzu6O5Dh1pe2gwMqdOFeiJgw7X1ayHlLhLVSwWUXCyRZn0IzYzx0xJh40TqG1X0
         g5UAmM/q0zu419dAHB4MhA1JgRyNju9oJQmsk5OhTfl7cQhNlRCmBFQrsL7rFOqXIiJe
         zXybLWgdW43iUwvcMr25I5gSXhvXE510zHRzVtDBb+vM8igWlKUYTE0wCYiS0pxl/Yys
         aSsJ24TBrlkY+AoBToJDwg0aouD1xZfNMM5sO85o2wfiFL+IRXAI852P+GHccZRoPUDu
         4E2ffSf+JYfCOaa3cmUmae4n5kbS607XvRH/jGz1sVLN8i/dcVzTS4tNMECBuL10wCtK
         myig==
X-Gm-Message-State: AOJu0Yz+4bCu5oilgUoew2uzJm305BxCfj1lEJLPCi1XEudCW3iRQ049
	Z6p/nvXBKIo4x4nJBc9yAfBdKEFuJgVoOVVh8mojqxfIv8Fd5KU7lyDrBfwb07sgg2sy6BkRd3F
	5avOQqP2LR5EasewUUWIcbWUG5nOloAo=
X-Gm-Gg: ASbGncssMMW6TOU/39TnftCu9Pq93pwFsyqW1OTEY5xdbFUU3LreelUkF6RTA3zegxD
	TU/u/wpsJ4CIR4KlJcuWx4Ubb2bf4eb5TtLe7Sm9v8NiQlZEM+9xHwbQpp65Rm9njFXcA5PytvJ
	cz2sXLCM0j7eYtowx+Tqy9p4tq2JkasbPAHbN3H2rRf61sKHVsldCJVWA1DvmausGkQNPQgVHqu
	4azajBCpYynuwOFoBI+oCqd3R/4lcu2W2At
X-Google-Smtp-Source: AGHT+IHVRTbMQ50iOv7DLH2HVdvb10IapZJst9tPsv0BOAWBCcAm3O2gZz978SLF/e+GHHW4UdJOJJgQo65BVSdT9HU=
X-Received: by 2002:a05:6000:4182:b0:3c4:edc0:28ae with SMTP id
 ffacd0b85a97d-3c4edc02d8amr11319017f8f.28.1756135046619; Mon, 25 Aug 2025
 08:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825131502.54269-1-leon.hwang@linux.dev> <20250825131502.54269-2-leon.hwang@linux.dev>
In-Reply-To: <20250825131502.54269-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Aug 2025 08:17:15 -0700
X-Gm-Features: Ac12FXyoTTgNA00P5pESbsjxzMVB5wq7Sm55NMCeNqcht1cIiXXFTarL3QUAuA8
Message-ID: <CAADnVQLdmjApwAbrGca2VLQ-SK-3EdQTyd0prEy0BQGrW4Fr6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Introduce bpf_in_interrupt kfunc
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 6:15=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Filtering pid_tgid is meaningless when the current task is preempted by
> an interrupt.
>
> To address this, introduce the bpf_in_interrupt kfunc, which allows BPF
> programs to determine whether they are executing in interrupt context.
>
> This enables programs to avoid applying pid_tgid filtering when running
> in such contexts.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/helpers.c  |  9 +++++++++
>  kernel/bpf/verifier.c | 11 +++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 401b4932cc49f..38991b7b4a9e9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3711,6 +3711,14 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, co=
nst char *s2__ign)
>         return bpf_strnstr(s1__ign, s2__ign, XATTR_SIZE_MAX);
>  }
>
> +/**
> + * bpf_in_interrupt - Check whether it's in interrupt context
> + */
> +__bpf_kfunc int bpf_in_interrupt(void)
> +{
> +       return in_interrupt();
> +}

It doesn't scale. Next thing people will ask for hard vs soft irq.

> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3751,6 +3759,7 @@ BTF_ID_FLAGS(func, bpf_throw)
>  #ifdef CONFIG_BPF_EVENTS
>  BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
>  #endif
> +BTF_ID_FLAGS(func, bpf_in_interrupt, KF_FASTCALL)
>  BTF_KFUNCS_END(generic_btf_ids)
>
>  static const struct btf_kfunc_id_set generic_kfunc_set =3D {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5c9dd16b2c56b..e30ecbfc29dad 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12259,6 +12259,7 @@ enum special_kfunc_type {
>         KF_bpf_res_spin_lock_irqsave,
>         KF_bpf_res_spin_unlock_irqrestore,
>         KF___bpf_trap,
> +       KF_bpf_in_interrupt,
>  };
>
>  BTF_ID_LIST(special_kfunc_list)
> @@ -12327,6 +12328,7 @@ BTF_ID(func, bpf_res_spin_unlock)
>  BTF_ID(func, bpf_res_spin_lock_irqsave)
>  BTF_ID(func, bpf_res_spin_unlock_irqrestore)
>  BTF_ID(func, __bpf_trap)
> +BTF_ID(func, bpf_in_interrupt)
>
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> @@ -21977,6 +21979,15 @@ static int fixup_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                    desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_=
cast]) {
>                 insn_buf[0] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>                 *cnt =3D 1;
> +       } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_in_inte=
rrupt]) {
> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> +               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned l=
ong)&__preempt_count);

I think bpf_per_cpu_ptr() should already be able to read that per cpu var.

> +               insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0=
);
> +               insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, =
0);
> +               insn_buf[3] =3D BPF_ALU32_IMM(BPF_AND, BPF_REG_0, NMI_MAS=
K | HARDIRQ_MASK |
> +                                           (IS_ENABLED(CONFIG_PREEMPT_RT=
) ? 0 : SOFTIRQ_MASK));

This is still wrong in PREEMPT_RT.

pw-bot: cr

