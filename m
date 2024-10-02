Return-Path: <bpf+bounces-40764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE61098DF66
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 17:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC073281177
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F771D0DD4;
	Wed,  2 Oct 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIuTKVKD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92B223CE;
	Wed,  2 Oct 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883479; cv=none; b=LUS2n+NqoPL87xQS5FJzLUF4xP3vhVsrOAG7vYgXGLaNRVEBgXSIDR33AfLCf7Kz70kjQHiPcnhUtG9lLra2BZ0YI4+jdUg5lAEpGeh2cOVYh8lbdvm/60/Z5uzPLSAxAIcj3Go9YpSw8BudPDg5t1h3Vpu1yM6ZpBP4UjqJVmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883479; c=relaxed/simple;
	bh=IprzesFBf7WPXNKAOPbaWN3oQbXQZ3108T/4pNo4vtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljpWDPtYOzpPt9V+6vI9ygsN9g1zt6PwWJ0/rXsW2bH0h0RPpGbZkToggbPYVHmIjG1aBTLJw17GW7eqXc9Vbs3YPW+IuiO2eITTyOHbeg3+0qugQLhxIc9hfSO5NEP8ack03mY1SNYtpIQ6wGzlwLmM2vlEWQllbs6GwJJtvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIuTKVKD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37cdac05af9so4428808f8f.0;
        Wed, 02 Oct 2024 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727883476; x=1728488276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCM8UjGj83zHWHJ94nTYciXKA5dmpPWIMOSrWwwQTeI=;
        b=mIuTKVKDuFM8V63vXUdOdRMktmoJwQdWH5LolEpIuLx78ptCy9gRLdHwpmXsLaTC7E
         tazbmxqkjWl6LtXq85DrxO3Vt/LZLI4eFC577rr1ZeZb3EnQ9GqBWM6GfCLOuwz4VnNa
         jqyApOodVytukRXoWBG5n6G8CqqNKpzYkWLep8UhDml5OP8SmHQttWPmRylwsvhWsDBa
         lt5t5we/hbXxxGvGG/IBR3u0f0bp1Jnnt/cuDQ7af7jHh6SSW+FMUDPJ6r3rYIuiRino
         7yfeKTXAAkyyT8lf30R1/Sms2AymTnrghkQAlWssB7Nrp8sjV0AKV86fGfuoYNYhMxIr
         bNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727883476; x=1728488276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCM8UjGj83zHWHJ94nTYciXKA5dmpPWIMOSrWwwQTeI=;
        b=cPa6cPJ51iKph7t4jeg52hP364GsyboaAfIqLd50HghSMgYrp7yQbPTCYFxihSggf1
         YqPDYUWwzl5u1waGRlmvDtukfFcW9XmEcvcZdu9iUZ8H6BKjqrByvl2OqB1qt9LtNSlb
         Y7XNblAUu72DrQz9z0VgB5qPIhdflX/PIBZLTOOz+myzGcA/9Awh/5qy/ZCxJlgYlBsn
         35ECn/mhZ0lDVmj+QctOfeFRenHLYrgW6CeaIG98UfLC+nAeZ1yl0qAYkCC1aItTEfcl
         qcJDTkWXTpUaNodS7QroaTABOFo43gyBI10Ps7pygEU1JiQDkuRRTNAxhyY/DJ4dal7h
         UjFw==
X-Forwarded-Encrypted: i=1; AJvYcCV/6me5XMl5F0UEO62ICBHTJUbfbSXoAFZSIhHZxv6LHvNHouRIy6NX0It3pd/vkzd5tQI=@vger.kernel.org, AJvYcCVcM4+NAoWhD+5kQp0Fe6eFXqmNhw+pIrHqUya+gItx+2nx4XeIl3ydD/0SZ4OJZm59moQc1pTOy+5fQA==@vger.kernel.org, AJvYcCXxuJkWq34tvP2JYHWEmM4bhYzb8ZZAtbay8+e7d+wtvCbEHPFRh+jWoHtn3edIaGwJE6TSNdyNWsB/CeIO@vger.kernel.org
X-Gm-Message-State: AOJu0Yye0sRtvLNtYQzhtjCAbDyI8mN5IqY+FCUjVCBFFIrtn1IP/81K
	V78n+AFcgZCMK9d6jHAsX5iqEy6/+kexLe+Ty6AgaDq5YgSzIL4y5s+Zpyom09F37vyDncFuupN
	Lqpk6comcxgz4GFROJj3/7GyHGtQ=
X-Google-Smtp-Source: AGHT+IF0Ope7mjRvxG8TbOWB5NycwdDY1aFLkj25cYNLybCPxyx4JGShNkIRgTYt3H5xSoPbQjP8jYF5rGw8SppA6A8=
X-Received: by 2002:a5d:5149:0:b0:37c:cd8a:50dd with SMTP id
 ffacd0b85a97d-37cfb8cb7c4mr3016428f8f.13.1727883475956; Wed, 02 Oct 2024
 08:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002152320.388623-1-chen.dylane@gmail.com>
In-Reply-To: <20241002152320.388623-1-chen.dylane@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Oct 2024 08:37:44 -0700
Message-ID: <CAADnVQL_eiqFPp5CvhnOYbrbyxXpwGBbhOqwh2JC-EioHbxMag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2 v2] bpf: Add BPF_CALL_FUNC to simplify code
To: Tao Chen <chen.dylane@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 8:23=E2=80=AFAM Tao Chen <chen.dylane@gmail.com> wro=
te:
>
> No logic changed, like macro BPF_CALL_IMM, add BPF_CALL_FUNC
> to simplify code.
>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  arch/sparc/net/bpf_jit_comp_64.c | 2 +-
>  arch/x86/net/bpf_jit_comp.c      | 2 +-
>  arch/x86/net/bpf_jit_comp32.c    | 5 ++---
>  include/linux/filter.h           | 2 ++
>  kernel/bpf/core.c                | 2 +-
>  5 files changed, 7 insertions(+), 6 deletions(-)
>
> Change list:
> - v2 -> v1:
>     - fix compile error reported by kernel test robot
>
> diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_co=
mp_64.c
> index 73bf0aea8baf..076b1f216360 100644
> --- a/arch/sparc/net/bpf_jit_comp_64.c
> +++ b/arch/sparc/net/bpf_jit_comp_64.c
> @@ -1213,7 +1213,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx)
>         /* function call */
>         case BPF_JMP | BPF_CALL:
>         {
> -               u8 *func =3D ((u8 *)__bpf_call_base) + imm;
> +               u8 *func =3D BPF_CALL_FUNC(imm);
>
>                 ctx->saw_call =3D true;
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa5..052e5cc65fc0 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2126,7 +2126,7 @@ st:                       if (is_imm8(insn->off))
>                 case BPF_JMP | BPF_CALL: {
>                         u8 *ip =3D image + addrs[i - 1];
>
> -                       func =3D (u8 *) __bpf_call_base + imm32;
> +                       func =3D BPF_CALL_FUNC(imm32);
>                         if (tail_call_reachable) {
>                                 LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->sta=
ck_depth);
>                                 ip +=3D 7;
> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.=
c
> index de0f9e5f9f73..f7277639bd2c 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -1627,8 +1627,7 @@ static int emit_kfunc_call(const struct bpf_prog *b=
pf_prog, u8 *end_addr,
>         /* mov dword ptr [ebp+off],eax */
>         if (fm->ret_size)
>                 end_addr -=3D 3;
> -
> -       jmp_offset =3D (u8 *)__bpf_call_base + insn->imm - end_addr;
> +       jmp_offset =3D BPF_CALL_FUNC(insn->imm) - end_addr;
>         if (!is_simm32(jmp_offset)) {
>                 pr_err("unsupported BPF kernel function jmp_offset:%lld\n=
",
>                        jmp_offset);
> @@ -2103,7 +2102,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image,
>                                 break;
>                         }
>
> -                       func =3D (u8 *) __bpf_call_base + imm32;
> +                       func =3D BPF_CALL_FUNC(imm32);
>                         jmp_offset =3D func - (image + addrs[i]);
>
>                         if (!imm32 || !is_simm32(jmp_offset)) {
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 99b6fc83825b..9924b581aa71 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -461,6 +461,8 @@ static inline bool insn_is_cast_user(const struct bpf=
_insn *insn)
>
>  #define BPF_CALL_IMM(x)        ((void *)(x) - (void *)__bpf_call_base)
>
> +#define BPF_CALL_FUNC(x)       ((x) + (u8 *)__bpf_call_base)
> +

I don't like to hide code behind macros.
The code is cleaner as-is.

pw-bot: cr

