Return-Path: <bpf+bounces-77861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EA6CF51BA
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 18:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CD9E313BF12
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF96345CB5;
	Mon,  5 Jan 2026 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsI7RfVr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1C3451B3
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635118; cv=none; b=ap9bH/ZDoywYDz1SCNtQr3bePg8i19abckOoc+2xliP3ZWPAJOUpqrOtHrpCM4iw7isRw2HS1RwhO81bERu0ByWHDKKVgAidMrbhMOhiksBdego3bRSf789KlG+EsQPVXf4aAZm11ym7Wmsc290UOtfT+JrGdHzv1lD/VOG9y7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635118; c=relaxed/simple;
	bh=7sNkA7xhl9kxwedUqpqBxYuPDFQnkNhl3zCI3WdX2Zc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RXvhr8RYzHXAs+K6nBT3P8OZWNZ6Lh5sgmZK1VhTe+kARbmjRqbRwZsIx+FDQN6B+Is5VL0BnLs/Qi51fxuXPlh2OjlcBqTSwL5iJA70Ihocvv3HEjWvDtb+3iPr+q2Y/Bp5p5B34FjJW6ct2dv/6g3pMEG9ZtTd9LDHr3rZyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsI7RfVr; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bde0f62464cso99856a12.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767635116; x=1768239916; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lTVNrbVTa+G+TWLvc9H4X9UDBXSMZSGYoyeRsLzfSLk=;
        b=fsI7RfVrfr8+mLptNtWXETK+pESWt4BDLc1xHOz6yvw+cv+wEPdYqA8ccWngxGxLqK
         blMrCJrR1MkwPcwRSn2Vvr6oz8TwOtO7g1YAKOksovHmDnxbc26gWXLh+aHUAn1FdO5C
         29JKwgX0CndDfhD1fl3BZIA2MpNBJYna1AIB0BlLUoOPWKso0D9t9IV49LP8+NHaG7sl
         jOM1xgw99RseTjlXLroQssJSpe23OoNhejHydOT03XcCD7J9xAHvGv6oTqWJ3t0/vcb/
         Yr2XrgA25fHalzH9wf10d8NCu+n3pEqXeoClBukBGSdxKTUV2CXHGh42lbGjvgZVmzL0
         TnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767635116; x=1768239916;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTVNrbVTa+G+TWLvc9H4X9UDBXSMZSGYoyeRsLzfSLk=;
        b=L72/4ZSKRHgf1K2SIYScENrgNzdLHZIyzaCp+5FOjjyVbdRFrm9AOufYyYFZDc/eX9
         2Zoi3tiNtO49UkMpmupQG+lKDsnxfm5w/Z1xNyjBvc38PfKHZYC6gi1kV58lPlt8bcKy
         CtWdw8YW7dQCENfAjjxfcSxqHpgcrHWXoLh9BuKByer04mqEz+ixFkFo9kOj2hcEL2hD
         lKaltUH8U+KeHFmaD0oCzBg4qg4sEOu9cItIr5ni9B4ZCtGnULTaw1djONlmm4Qx7We1
         dv4c7+pBtp1Jr4hq0X3LJVV3aHJqulIbk8Z/abQsZ8OjPWEq3SGPZ5oVoBfzVPm76Gxj
         +8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWU3cc4EkCcYkXYnZFvyWJWxHK2yuZ9s7BlE0oZmwKcpWMrciXdGcWmlEi2L6qfGLHfiNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4J4LOazd01OMGyXHPyARuuz3/onpFFJoFQq+oJokljPdpBis
	5zknszCl51TTQwG+e/4mlgjdCRWfy81y3PxmpEe1+r3i5eYCzc7asTZr
X-Gm-Gg: AY/fxX6tc0lVdlRpOzVcQpe4jMVd1tVY60lO0fndLHo/HhooG6Ui4hdl2q3R4EXmcRy
	Rz7GMwtOjXJ03FYPmPULyNc3gXqYVFtCf6dQGLRpZRcx/GYDvGRrGFjwYuzrv4I7E8e723vaCxq
	gU4DguWQ7Y+bhsPP4Zi/4z/svvFmF0U2oYhoR6zPMHlCVwr8dUqhaRLdB1hHCmmFFqFN3IJRa4X
	G8UKQZUy/sRVqeqKHOtsPEBFw6b8TUBf+i1vbv6NL7cJio10szJiGD9wRTf9uqBBa0/CZjITCyi
	HBNvHwhhNFvT5DY4PPy5cpd+4u1N0V/msZbWi3bs0qta8wy8FKIKUbY9jrmEBD6cy72fYYtCU/0
	5YQtvKg5mbmS+HPRjqgx2g8jXL6V2lixcocPy3U56dJ8qNafyMC8a7Z52qabyTVdsqz0XeZMAQe
	VWk+Tqz2Vp3Y8/V25v57ts75Ya15ag3IGUBIJp
X-Google-Smtp-Source: AGHT+IHwqflAWpHbFYx4gUYYKc+Iao7re9ab7WD0vrEsaxmDed0XXnADhREOOc9mSQN3CehRMwjA6A==
X-Received: by 2002:a05:693c:2c92:b0:2ac:1b11:bf98 with SMTP id 5a478bee46e88-2b16f906cc0mr82752eec.28.1767635116108;
        Mon, 05 Jan 2026 09:45:16 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:175e:3ec9:5deb:d470? ([2620:10d:c090:500::2:d7b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b16f16faffsm459465eec.1.2026.01.05.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 09:45:15 -0800 (PST)
Message-ID: <08ab237ad7da8d1f6494cb434d9a5a46a599462c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
From: Eduard Zingerman <eddyz87@gmail.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, 	dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Jan 2026 09:45:13 -0800
In-Reply-To: <20260104131635.27621-2-dongml2@chinatelecom.cn>
References: <20260104131635.27621-1-dongml2@chinatelecom.cn>
	 <20260104131635.27621-2-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-01-04 at 21:16 +0800, Menglong Dong wrote:
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> to obtain better performance. The instruction we use here is:
>=20
>   65 48 8B 04 25 [offset] // mov rax, gs:[offset]
>=20
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - check the variable type in emit_ldx_percpu_r0 with __verify_pcpu_ptr
> - remove the usage of const_current_task
> ---
>  arch/x86/net/bpf_jit_comp.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e3b1c4b1d550..f5ff7c77aad7 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1300,6 +1300,25 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 =
dst_reg, int off, int imm)
>  	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
>  }
> =20
> +static void __emit_ldx_percpu_r0(u8 **pprog, __force unsigned long ptr)
> +{
> +	u8 *prog =3D *pprog;
> +
> +	/* mov rax, gs:[ptr] */
> +	EMIT2(0x65, 0x48);
> +	EMIT2(0x8B, 0x04);
> +	EMIT1(0x25);
> +	EMIT((u32)ptr, 4);
> +
> +	*pprog =3D prog;
> +}
> +
> +#define emit_ldx_percpu_r0(prog, variable)					\
> +	do {									\
> +		__verify_pcpu_ptr(&(variable));					\
> +		__emit_ldx_percpu_r0(&prog, (__force unsigned long)&(variable));\
> +	} while (0)
> +
>  static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
>  			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
>  {
> @@ -2441,6 +2460,12 @@ st:			if (is_imm8(insn->off))
>  		case BPF_JMP | BPF_CALL: {
>  			u8 *ip =3D image + addrs[i - 1];
> =20
> +			if (insn->src_reg =3D=3D 0 && (insn->imm =3D=3D BPF_FUNC_get_current_=
task ||
> +						   insn->imm =3D=3D BPF_FUNC_get_current_task_btf)) {

I think this should be guarded by IS_ENABLED(CONFIG_SMP).
The current.h:get_current() used
arch/x86/include/asm/percpu.h:this_cpu_read_stable() that is unrolled
to __raw_cpu_read_stable(), which uses __force_percpu_arg(), which uses
__force_percpu_prefix, which is defined differently depending on CONFIG_SMP=
.

> +				emit_ldx_percpu_r0(prog, current_task);
> +				break;
> +			}
> +
>  			func =3D (u8 *) __bpf_call_base + imm32;
>  			if (src_reg =3D=3D BPF_PSEUDO_CALL && tail_call_reachable) {
>  				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
> @@ -4082,3 +4107,14 @@ bool bpf_jit_supports_timed_may_goto(void)
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

