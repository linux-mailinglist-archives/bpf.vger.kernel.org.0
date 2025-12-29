Return-Path: <bpf+bounces-77487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9DDCE817B
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 20:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D39A9301397A
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 19:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2101925A2DD;
	Mon, 29 Dec 2025 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYThaZjB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB21F9F70
	for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767038288; cv=none; b=spoC4Ce8urZH2W9V66ASexFx19nWKq2+wAUC7eFt/qkGhw+KnTZrzci4vxFaIhOYHGl0ABny80IfytHAJc6YsGhvsQZjeoq1+kRt+NeMRKAvGN7nDVBmk10f+UB++ZKhHQLaNisPCJjM/gbIoFdVaNN1AArlekUWkegE1Zycxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767038288; c=relaxed/simple;
	bh=ILOnzjB6omPzsTjFaR5p7kIAmLgY60kDToG8kB6uAvw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyu8BT3GmwtFBnXyinUCgWcf82rKZ+34SiS+1ye6e1ZpeD93LKeAD/42/kwg5ZZAeItoVkvo5cGCSYC/KZvC7vqrXRTL/Qt9jrDzwlS2EXis7QnnUiM4y1uTZYzUszhXvbiFdrm06mrJhn/qcqDO1NH6cYh7UKR7Nb0GzSj8PWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYThaZjB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7f651586be1so4471193b3a.1
        for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 11:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767038286; x=1767643086; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xko4XQ8K4/4/p+5qf10V0z8LE3R9sFv1la/WwKpKg8w=;
        b=ZYThaZjBxgHPLg/ru2oZZkkkGV9I+IQ40v7BeSRjUsjFg8NWfReiJwLQlrKmnUqHLA
         rvkVXYMB6uxFjEseJU4LblqV3xz3tL12y51GumsjIc6cyS6zleoKH96pr/Tu3MCKuh6z
         1dkPwxdpY+D6+VQ7nF03YfwSISSL9p0H/3y7TtvjKIMmnjgr5ZS7B38Ulg/fPpmOCF/C
         mzs007TEjxUXjZWR40SZsreLbn7Jhf2pb0ZW/kFXs1QmTYbCo3paFgYLhanP+ceAWCdo
         Ud7A7P4dtNPgw8WyCtxZZmpBMyv54oRfhGuAZ+FKsKVJkhdrbHIGLMTgVMUxRxwk+/qG
         7PcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767038286; x=1767643086;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xko4XQ8K4/4/p+5qf10V0z8LE3R9sFv1la/WwKpKg8w=;
        b=I0dU+FcqpURLIyFeBiWLxCyph8GGuoaUhD7lvZp9Y/0kBWno+EkSYwJRjbFx+/mDfK
         EobXsIfSdln+GJKPnXT9d+vXlFbpR7QcRMTzbZLz1i25hJUXXKKH4g4vXMbhloR/D610
         jr63QZvJ3zTV5++cJwFCLz85IVmTBuvN1mjK318bQqjR3bVzufOiGGgQrqI4qwKNycog
         FYLJYegbaKlfJhV3+3yN1zNrBccMcuHP2H8wOxDb2dRIBXd/mNyeD4uazjuxabLCWxL5
         prlmYNC4vukAM8djq02FlNAJDRL8pjPO+9xIKsLbs33y2BijwLITzFgJsJxM+P9C/zLt
         Uasw==
X-Forwarded-Encrypted: i=1; AJvYcCVO1m+st64UGflkhRqp2FX3o6pHEsgkbRfUl8Z2CZvBmoVV5CMOqc6Ac48C9S6j/R3QHqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmWyNWJm9slfy1MJJVeKox0SSqU93Y0cWSuMzPIPiI3pCxJsYD
	cx/HKubN1vc6pUHqUZZA+MM8QemTa0bdfk08tMd6lzeTyhZWUaaMfkst
X-Gm-Gg: AY/fxX6mMZ2ugpUeSArgyRl8nJROPDzV68XiqaOjYioipWbpfQ2+iIjPITTDtpW4WJ9
	rMLNR+b2WGys1ghGExrIb8tJt9STQydpcSfiSrcLo+aRk38xXxNqoZPsP0QWBG7qXnZ18gJHkmX
	P9qPJ6eAhTpXhFAqcOdmnPsoimVL56AiYhxSU0n70Yzn08zF0MX7AuEFZgAZ9GZr5qYiV7ATMcC
	ufu5NZGQQ02vNVtAv0cxmyh1bhcBBkffHmVennmWEBboUCDeEseGjaUGJO1lbhz6RC3AFvlnp7u
	nDnpcmMaUkKSHQYUL2V+pLFlAwDPdqKapimpExOCPrCCV9i8Cl81GSaWHEhA2wto4Pn7Of3vqtn
	z7+UDUc8tweqoTd1zRBQgfZoNC1CTIrlz8aM9iU/8RwZCl24TpoNPWtnKfgR1jcZFVwwMXV+5DU
	4RednIsvS/vafdn7BETas7k2b/jg1Y31FEjtV5Ev4VTR3Cfhs=
X-Google-Smtp-Source: AGHT+IFClYfhXcvzYGUEAeGNRFFMkUwqOYUjfX2LyOlUE6PEoi9FZ13hia7PJghTWywP+YG21UqZAQ==
X-Received: by 2002:a05:6a20:7f81:b0:366:14b0:4b1c with SMTP id adf61e73a8af0-3769ff1c33fmr28383151637.39.1767038286311;
        Mon, 29 Dec 2025 11:58:06 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ac6b:d5ad:83fe:6cca? ([2620:10d:c090:500::2:1bc9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm30215140b3a.32.2025.12.29.11.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 11:58:06 -0800 (PST)
Message-ID: <0f0bd124a42723acf87b427cc69356a0e4b1e339.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf, x86: inline bpf_get_current_task() for
 x86_64
From: Eduard Zingerman <eddyz87@gmail.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, 	dave.hansen@linux.intel.com,
 jiang.biao@linux.dev, x86@kernel.org, hpa@zytor.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Dec 2025 11:58:03 -0800
In-Reply-To: <20251225104459.204104-1-dongml2@chinatelecom.cn>
References: <20251225104459.204104-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-25 at 18:44 +0800, Menglong Dong wrote:
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> to obtain better performance. The instruction we use here is:
>=20
>   65 48 8B 04 25 [offset] // mov rax, gs:[offset]
>=20
> Not sure if there is any side effect here.
>=20
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---

The change makes sense to me.
Could you please address the compilation error reported by kernel test robo=
t?
Could you please also add a tests case using __jited annotation like
in verifier_ldsx.c?

>  arch/x86/net/bpf_jit_comp.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index b69dc7194e2c..7f38481816f0 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1300,6 +1300,19 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 =
dst_reg, int off, int imm)
>  	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
>  }
> =20
> +static void emit_ldx_percpu_r0(u8 **pprog, const void __percpu *ptr)
> +{
> +	u8 *prog =3D *pprog;
> +
> +	/* mov rax, gs:[offset] */
> +	EMIT2(0x65, 0x48);
> +	EMIT2(0x8B, 0x04);
> +	EMIT1(0x25);
> +	EMIT((u32)(unsigned long)ptr, 4);
> +
> +	*pprog =3D prog;
> +}
> +
>  static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
>  			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
>  {
> @@ -2435,6 +2448,15 @@ st:			if (is_imm8(insn->off))
>  		case BPF_JMP | BPF_CALL: {
>  			u8 *ip =3D image + addrs[i - 1];
> =20
> +			if (insn->src_reg =3D=3D 0 && (insn->imm =3D=3D BPF_FUNC_get_current_=
task ||
> +						   insn->imm =3D=3D BPF_FUNC_get_current_task_btf)) {
> +				if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
> +					emit_ldx_percpu_r0(&prog, &const_current_task);
> +				else
> +					emit_ldx_percpu_r0(&prog, &current_task);

Nit: arch/x86/include/asm/current.h says that current_task and const_curren=
t_task are aliases.
     In that case, why would we need two branches here?

> +				break;
> +			}
> +
>  			func =3D (u8 *) __bpf_call_base + imm32;
>  			if (src_reg =3D=3D BPF_PSEUDO_CALL && tail_call_reachable) {
>  				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
> @@ -4067,3 +4089,14 @@ bool bpf_jit_supports_timed_may_goto(void)
>  {
>  	return true;
>  }
> +
> +bool bpf_jit_inlines_helper_call(s32 imm)
> +{
> +	switch (imm) {
> +	case BPF_FUNC_get_current_task:
> +	case BPF_FUNC_get_current_task_btf:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

