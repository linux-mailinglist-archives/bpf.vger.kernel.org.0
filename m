Return-Path: <bpf+bounces-33484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE1F91DD69
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 13:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2151F21648
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043EE13AD04;
	Mon,  1 Jul 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOOQe542"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A377BB06;
	Mon,  1 Jul 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831844; cv=none; b=C1oKYFIXCHC2MBo4AtKXuByIWcDvYhF8jrPvPBpIcaeicKQW9Vk24bMpZW3aLtChgeb1pjhzWlf5+yib8uBXHP+ApFi3vGzgI/RBMTyiMjgVuA6ZpI79QVZY+7t8174DjYLagG9zqrVsWoEoRAy8wj+uT5e09/i6mlBoxxF9vZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831844; c=relaxed/simple;
	bh=+xmtqoTC9pRu9tBCd/MZgIgv0a3lnG32B+0rTFHnTDA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ddzgjRTg+EV778J6JYI9fKns+yYcxaWuYbYDVrbLWpDZxyMotvHa8M17CRal0Q7av6+zAC21Y86GntCLts0Mb35ZKEWUhZjpjjkINYxCq6jTklcmnQTy+pFw/B7vFHnQ4j85lZ/rizqw+NkRWxFkuWdPFV1+kWNckzkHmy87xvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOOQe542; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24c9f892aeaso1359035fac.2;
        Mon, 01 Jul 2024 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719831842; x=1720436642; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXzeEVHZAYNwP9LyDiGI74pJ3kMgBavuirX+asSxPgg=;
        b=XOOQe542zrSAN45yseBkACoY2GOzIrunJfgOq9cUlteuprrsfJghsP2J9JWCTuk9Lq
         gnGIx61ZfdqL/SoHKBAiploxuI90ZCxL3To6FRHCnwXwS0U3XxgbX5CKSK9pqP5g7WHG
         xw6bD3kKjTItl0BaTK9FbZKKUQrNxz9tRkzFLzvg2+VVUuIPUgD8Btu2cwEboIMCWY5x
         xFqDKMKVo+VZiO0LQ7IE5e43hz6YbUVqCs5Tfanifh3PW5+ZhH5BkYDjIiy70kd0oMZB
         i/9OvMuVuFpOAG8JQWCe61/oQTGl3ds/teWJztQ46wVlP45HhVrVnzzjFG5s7fjvsWIa
         N/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719831842; x=1720436642;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YXzeEVHZAYNwP9LyDiGI74pJ3kMgBavuirX+asSxPgg=;
        b=a6laURTd0drt8dBrxM10tFuQV+iTJiUXJz2xkRKLzto5xx9jfCW1hkjLnquMFEZl+s
         MGKyYphVCT9/aLWCKlRWYEEDwDObTpqQkVaW/0RFLgmtRKiI69ndXWMt0w4uuUZnBUgx
         r5dx3Q3i/n5vDMUAV7LAXEXJy86nI+DFdq6CCUydWcMoqZiraSeol6L8CHbPqIClgbrd
         N5e5ohRbDzSag5RCrZ5e+CPZ2dkaVP+B73MjWCakHphvaA4l1R3ObBZG6zNu86DQv+GU
         kfPs8G19ti3iPOXDsX4DnJEipkWl69Wxz/1qlrelUESf8MAUCieUL9ciVwH7xQ+4upzS
         BEEA==
X-Forwarded-Encrypted: i=1; AJvYcCWqdagzDV7GqlsZ+wzRhurZxddcrcAxyjTnSMuY6NPfH5fxhSvndBI+Jz5QDbzAnzFMtgE3ShQ8EjDVROs8xRcguZA90pbVzsoS7lfSgnYEZSNrMydERJt4ZUR4CYliEOW5dNjUDtHn
X-Gm-Message-State: AOJu0Yw4lVhKkP8aeFlE9LpQ9SkJr3Fd3cgmltDPy+XsilMYGOHy0XZf
	LFTrG87zm5H+GPy0blkhbSbZbVuymQ7gPLb1SLB/c+VHx01cs6ElbJA7Dw==
X-Google-Smtp-Source: AGHT+IGMlV0x2miXA7z/rApts7dhyaI7OUHVJdLxouoZVTa6LuzzBUiiewgzDm8W7JY1cJ2YJcu8rA==
X-Received: by 2002:a05:6870:d889:b0:25d:5a7c:c8ec with SMTP id 586e51a60fabf-25db33f8b67mr5830768fac.13.1719831841923;
        Mon, 01 Jul 2024 04:04:01 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ae395sm6396945b3a.144.2024.07.01.04.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 04:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 21:03:52 +1000
Message-Id: <D2E5I4W6C23X.3A42AJCY8ODUJ@gmail.com>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>, "Masahiro Yamada"
 <masahiroy@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>
Subject: Re: [RFC PATCH v3 11/11] powerpc64/bpf: Add support for bpf
 trampolines
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Naveen N Rao" <naveen@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1718908016.git.naveen@kernel.org>
 <a88b5b57d7e9b6db96323a6d6b236d567ebd6443.1718908016.git.naveen@kernel.org>
In-Reply-To: <a88b5b57d7e9b6db96323a6d6b236d567ebd6443.1718908016.git.naveen@kernel.org>

On Fri Jun 21, 2024 at 5:09 AM AEST, Naveen N Rao wrote:
> Add support for bpf_arch_text_poke() and arch_prepare_bpf_trampoline()
> for 64-bit powerpc.

What do BPF trampolines give you?

> BPF prog JIT is extended to mimic 64-bit powerpc approach for ftrace
> having a single nop at function entry, followed by the function
> profiling sequence out-of-line and a separate long branch stub for calls
> to trampolines that are out of range. A dummy_tramp is provided to
> simplify synchronization similar to arm64.

Synrhonization - between BPF and ftrace interfaces?

> BPF Trampolines adhere to the existing ftrace ABI utilizing a
> two-instruction profiling sequence, as well as the newer ABI utilizing a
> three-instruction profiling sequence enabling return with a 'blr'. The
> trampoline code itself closely follows x86 implementation.
>
> While the code is generic, BPF trampolines are only enabled on 64-bit
> powerpc. 32-bit powerpc will need testing and some updates.
>
> Signed-off-by: Naveen N Rao <naveen@kernel.org>

Just a quick glance for now, and I don't know BPF code much.

> ---
>  arch/powerpc/include/asm/ppc-opcode.h |  14 +
>  arch/powerpc/net/bpf_jit.h            |  11 +
>  arch/powerpc/net/bpf_jit_comp.c       | 702 +++++++++++++++++++++++++-
>  arch/powerpc/net/bpf_jit_comp32.c     |   7 +-
>  arch/powerpc/net/bpf_jit_comp64.c     |   7 +-
>  5 files changed, 738 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include=
/asm/ppc-opcode.h
> index 076ae60b4a55..9eaa2c5d9b73 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -585,12 +585,26 @@
>  #define PPC_RAW_MTSPR(spr, d)		(0x7c0003a6 | ___PPC_RS(d) | __PPC_SPR(sp=
r))
>  #define PPC_RAW_EIEIO()			(0x7c0006ac)
> =20
> +/* bcl 20,31,$+4 */
> +#define PPC_RAW_BCL()			(0x429f0005)

This is the special bcl form that gives the current address.
Maybe call it PPC_RAW_BCL4()

> =20
> +void dummy_tramp(void);
> +
> +asm (
> +"	.pushsection .text, \"ax\", @progbits	;"
> +"	.global dummy_tramp			;"
> +"	.type dummy_tramp, @function		;"
> +"dummy_tramp:					;"
> +#ifdef CONFIG_FTRACE_PFE_OUT_OF_LINE
> +"	blr					;"
> +#else
> +"	mflr	11				;"

Can you just drop this instruction? The caller will always
have it in r11?

> +"	mtctr	11				;"
> +"	mtlr	0				;"
> +"	bctr					;"
> +#endif
> +"	.size dummy_tramp, .-dummy_tramp	;"
> +"	.popsection				;"
> +);
> +
> +void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
> +{
> +	int ool_stub_idx, long_branch_stub_idx;
> +
> +	/*
> +	 * Out-of-line stub:
> +	 *	mflr	r0
> +	 *	[b|bl]	tramp
> +	 *	mtlr	r0 // only with CONFIG_FTRACE_PFE_OUT_OF_LINE
> +	 *	b	bpf_func + 4
> +	 */
> +	ool_stub_idx =3D ctx->idx;
> +	EMIT(PPC_RAW_MFLR(_R0));
> +	EMIT(PPC_RAW_NOP());
> +	if (IS_ENABLED(CONFIG_FTRACE_PFE_OUT_OF_LINE))
> +		EMIT(PPC_RAW_MTLR(_R0));
> +	WARN_ON_ONCE(!is_offset_in_branch_range(4 - (long)ctx->idx * 4)); /* TO=
DO */
> +	EMIT(PPC_RAW_BRANCH(4 - (long)ctx->idx * 4));
> +
> +	/*
> +	 * Long branch stub:
> +	 *	.long	<dummy_tramp_addr>
> +	 *	mflr	r11
> +	 *	bcl	20,31,$+4
> +	 *	mflr	r12
> +	 *	ld	r12, -8-SZL(r12)
> +	 *	mtctr	r12
> +	 *	mtlr	r11 // needed to retain ftrace ABI
> +	 *	bctr
> +	 */

You could avoid clobbering LR on >=3D POWER9 with addpcis instruction. Or
use a pcrel load with pcrel even. I guess that's something to do later.

Thanks,
Nick

