Return-Path: <bpf+bounces-68595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E67B7EB6B
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1E61C00686
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 01:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73119E83C;
	Wed, 17 Sep 2025 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYhsz6p8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48B4A06
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071135; cv=none; b=WmHD+kkps7YGhbGz7opdBMC5KSkWHzSkHApqTrhcfW04i4iGHrzaSO7We5pPGwkONNP4bCCwkyOwJpSCW8eWrGOqblk9vVaWX58XZn10VfTZrN+j9xVj4KjRDGCN8nE7XvUS3iw3wEacyG5Qzl1cIyi2DQ4i0H9A6SMU2TuQbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071135; c=relaxed/simple;
	bh=MqP4ckopkJ6MWzGo7kzMrtCKmlLxBBjSCjp+mfxwMb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kXUrH0Mjmh4oeItyEe8y/CgkljFLnIG98L3nG6gJoFb+sc/UyqTvhvGNoNyB83EqZNUXsIYa2CAPi50zKESXRGAVY3Tmt4712PaDeqaacjB+yMUWltHVSZeDc5MX8UkosAVrb3bdGEKzyEiZjQHY+khdzmKY7kTohJphasesVLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYhsz6p8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32e715cbad3so2758817a91.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 18:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071132; x=1758675932; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6NWKcJKt4nkbESP93y6F2NmRYBK3o4ETJTr6n60+Dks=;
        b=DYhsz6p8F/iGCljtjgXGcfYmghxgnmK4y8E6BP61W/0bqEw+QYp8VeYvcHeJRiDBtN
         MzY3agk+zXNPzNRihGa/qEeeZqQG7ZDICT8qqybifETYWk8YVYzsIkVYop9sJ0jSbgeC
         YBTDnalrCUV744zJy/pXT/ftMEi3pinauaRqiRkO4+SHZ9QDwDck40aluiQDJaO0XgIX
         jsTq+1XSYvxGPWW3dTIsXV4EN5SiG59gIaxtCbfbBw+YpocYj7m5wwXxfyNwGoyDo5iw
         y2xk7Peu3gW0ScdYp09ljHXt8bKyFwZOeRip48ygNuqdw+/bVKAk8hdWsuWtYHLs8h3a
         G6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071132; x=1758675932;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6NWKcJKt4nkbESP93y6F2NmRYBK3o4ETJTr6n60+Dks=;
        b=eMsE8W+qmhQcX+5zaUEeePyo8McnLipTD5V0sjalQhJ3TgAX8NNIquKjc+UksHpT8O
         lrnuYK1PRjnobvGaxWvsKcBZ5dCgzPpn7ewSce0UjIhwiXQRy4Sxd+hh+2GoLq+Pb03E
         RQ1XankhlVie4kbqmUHZACBv5XYrZWDF6V2+7LWj2aoFkNAUtLRV+4T9/XZked63BY41
         l5A95oDCgI5Vc2vw2IWLtWNhswlXHJfTl0qD5MEF69LsUqcTyCNF5yNo4Y9FQcsHIJKf
         SfdE7+HHxt9dgWDP65ZH4ggd7QQKlzmRsblducggnWMLqu7nY30ULwXZwf5j4i3Y0p4g
         yy7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTWv1Vr95J0205TpwRqz+h7kWLcKh//a8GN2TD2Z0Idk9NgEYRs8pGd+IMNVPpqVxSv2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGB0gvSezkIiUyW2F7XPhCoC7oJOvpZqMzAWjUldKcxLnibeu+
	3CUnNaAVG0teUmbXDIHr/WNAVC1KfH8wjgnuE/d/OAfRLvP9jTdBdvd9
X-Gm-Gg: ASbGncslq+DIMcgooVxe8ATyDFki3OGvo/FR/D7jgtnvrN0Xk8dtyzFJYRgMewVAXDW
	hBnAiQtRy0jmMZVJ8RTwSS7IFONew885u+uJ6D+uoZKxCfKUsilN37ovqPEtvf+t5fhYq4sq45l
	sT21zOJc+1OGA8TstMwjRYKrL7OMx42yIFYDpIyjoiZqFCfPfz/aAbcJnqCQKdY7/ImuZFtXkv5
	tdTydXvSEquA1itxoFgi4jaET/deOMVKIPD7KGXETJpqKEc340RwTo5OiLkZ6CflMfn4WjSajSr
	RvicCWno5qLxIx0sEhMLqno9CLUPCuYwGapJccYGSj+1sr2vToMn/NPI/H3YboKqRe64EbtQDUX
	McsY+e3whAaIX9x/vJmBGB7xCHX3+PmCcMpwao4OxhsfP7g==
X-Google-Smtp-Source: AGHT+IE4jwrARMOdD22uOmrSwxMfnxLReUHx8N2BWdiccJqDzbkrE7qkf+n7BwkXCTmdmh3K16GCxQ==
X-Received: by 2002:a17:90b:2243:b0:32e:27a3:44b4 with SMTP id 98e67ed59e1d1-32ee3f76c02mr405726a91.26.1758071131553;
        Tue, 16 Sep 2025 18:05:31 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a1:9747:e67f:953a? ([2620:10d:c090:500::4:432])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26a592dsm781758a91.10.2025.09.16.18.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:05:31 -0700 (PDT)
Message-ID: <ba84c72f4732b0fe180b2ba40cc66577c78c177b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf, x86: Add support for signed arena
 loads
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kkd@meta.com, 	kernel-team@meta.com, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 16 Sep 2025 18:05:29 -0700
In-Reply-To: <20250915162848.54282-2-puranjay@kernel.org>
References: <20250915162848.54282-1-puranjay@kernel.org>
	 <20250915162848.54282-2-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 16:28 +0000, Puranjay Mohan wrote:

[...]

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index 008273a53e04..f2b85a10add2 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -3064,6 +3064,11 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, =
bool in_arena)
>  		if (!bpf_atomic_is_load_store(insn) &&
>  		    !cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
>  			return false;
> +		break;
> +	case BPF_LDX | BPF_MEMSX | BPF_B:
> +	case BPF_LDX | BPF_MEMSX | BPF_H:
> +	case BPF_LDX | BPF_MEMSX | BPF_W:
> +		return false;
>  	}
>  	return true;
>  }

Is the same hunk necessary in riscv/net/bpf_jit_comp64.c?

[...]

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8d34a9400a5e..a6550da34268 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1152,11 +1152,38 @@ static void emit_ldx_index(u8 **pprog, u32 size, =
u32 dst_reg, u32 src_reg, u32 i
>  	*pprog =3D prog;
>  }
> =20
> +static void emit_ldsx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_r=
eg, u32 index_reg, int off)
> +{
> +	u8 *prog =3D *pprog;
> +
> +	switch (size) {
> +	case BPF_B:
> +		/* movsx rax, byte ptr [rax + r12 + off] */
> +		EMIT3(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x0F, 0xBE);
> +		break;
> +	case BPF_H:
> +		/* movsx rax, word ptr [rax + r12 + off] */
> +		EMIT3(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x0F, 0xBF);
> +		break;
> +	case BPF_W:
> +		/* movsx rax, dword ptr [rax + r12 + off] */
> +		EMIT2(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x63);
> +		break;
> +	}
> +	emit_insn_suffix_SIB(&prog, src_reg, dst_reg, index_reg, off);
> +	*pprog =3D prog;
> +}
> +

Encoding looks correct.

[...]

> @@ -2109,13 +2136,19 @@ st:			if (is_imm8(insn->off))
>  		case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
>  		case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
>  		case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
> +		case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
> +		case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
> +		case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
>  		case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
>  		case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
>  		case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
>  		case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
>  			start_of_ldx =3D prog;
>  			if (BPF_CLASS(insn->code) =3D=3D BPF_LDX)
> -				emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->of=
f);
> +				if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32SX)
> +					emit_ldsx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->=
off);
> +				else
> +					emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->o=
ff);
>  			else
>  				emit_stx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->of=
f);

Heh, apparently this is correct C code. Dangling else is associated
with the closest 'if' statement. Didn't know that.


[...]

