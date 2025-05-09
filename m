Return-Path: <bpf+bounces-57917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDEBAB1D45
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 616557AF222
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 19:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900EA25D1FE;
	Fri,  9 May 2025 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpamvVxO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AD24061F
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746818924; cv=none; b=p4BI5i1RZLmwsyl+8qmAkb7QlMVZtz3/1ucbJ9mqldBgPsdtPwp5qtrbT9b45SCwOeQonEPhLnLcaiKXXAsPUDDdqdDk9gxDafPsXfXOBAGsGDUE4t1X2ph81+PTt/imYt5H/AG/NaYT4lEL0GFXdVsGoKLZIOB+7cZ3l6+XuSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746818924; c=relaxed/simple;
	bh=jv5wl0bqoNIbsTdcNGwQ1U9dLQCnieUS2IPZoEXmnbU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6by+GR1DEGrx9ag+JXUlsryLGbN5KZX/9Ne6R6dRJHEqkat43Z7VUt5AdS3AJ2NTFzn/NwI68flk9/+AipcoYErKOizNWudfnisxAbARjpet2U2CL3zCru3U6iSzdaUqv5AgwmZcrKCQ+ZxiJR9Kz/vErPnTDJTV2g4xbs32NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpamvVxO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30a8c9906e5so3202767a91.1
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746818922; x=1747423722; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=57CgntzLAx+GelZm2us4TxGqwZ3997NQuG5gamqDxg8=;
        b=UpamvVxO9dt38d3aFztkMjZq2zoEvMAxLuTfvCW4GOja07Oc30dANB8HD+QZjhwFiI
         64xVSQIfcngTU+QA482ErdIsGqrFzCEX7yKjx1OQyizWFF1OQhuIYnys4tq8vUlF7HvX
         KcJzUtck4LSC1CUHVBfp+2z5/z6oYDywyNNzAPl3WZw6at+4Zpi8YwpcYCxhiggfcaFs
         vGiHZpVlT/ja+VudkzzNtagrsNjQfv46P5Vgb3uy5ml6aao6NW+anTABM5a2AYwE0Bt5
         G4S8Tzk5lfUOgn8CJcks7MIsVNtGEru5INn7tyKlhmUq3FzNBSrfcHr/r5oLXSpnFSZ4
         dAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746818922; x=1747423722;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57CgntzLAx+GelZm2us4TxGqwZ3997NQuG5gamqDxg8=;
        b=ZnWMcF8bBnPjb0+6g1gEMjavBgM14FB/wFTyTYmMaZLkp7zbrU9gbRfCSoL5lK4VKh
         v7uJwaiy+gpgXA0YRe/R3HC26AWFbbeT2fCpSumDlr1LI7eQ+h5429WLJQFYsoV59JhS
         aSS70ch+q+cJQB7iHvHB4Eg4PRVp14I/DDvhOuIkutvzIYuz6Aq0jbFX7FwOCPlX90y3
         egQAN0i298oSmIrCGSxkF39cSGYxYbX9YLDcMDLy01RR2gsmfU85aQc6oNYs51wLVBZO
         m0ZbBmUUVA5S9WPZNbC7cgorwviXn7Wmr/iovoUHVsB83g0harbNwwA0YHeWvvJlFdlS
         kieQ==
X-Forwarded-Encrypted: i=1; AJvYcCULuDId6KbhOJ5bcx+qH6gQ/lPY38NuHEYdPM8r/mlLJSYXvkqheiqAewCOnshjEuICzH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+kRtLJ9SuR5WqyBx2qJwVwiAywKw1NWvVbk+hXmYWesuMNMwx
	SPUzPP1QbnvKzYHdBCVF3wo12Nc+sArRLQr18NCcmaFtBehohH6L
X-Gm-Gg: ASbGncv3CSeW/4y1cPylZOvfVyIrETCIhF039O26qjNXktO+mr1AgSqaxvLbzQp+yHI
	snijHCJeYL3L6+gSF4YwLeKOMYEubYrT21zYG8Jjnu50bNDZ8bNmdS+IfippPWP90Ubbwekc8n9
	yNpw67mSRYCZPd7oZtasZ60sF2nZpCgLyzs7ng8eUT90tZNr4mmlrDjY0GzI9VprXLeSfCYPn+x
	IToO+BL/zTkEUjzJSKRwvFhK63DgjbKvgDObR8LJjFg0fHDRc6M5h873bTuwT6LQG+4hZkOpFgG
	/GcK+A9lEseSAYJdHpTOK/ejIw/I1+unq4cLw5nuKa+hczg=
X-Google-Smtp-Source: AGHT+IEBxlSa9cr2RhnB+3A4dcrSO5rs4zymsNKCwFxZcZNWEnGoBZ9208QB+ZgkUVLa/RQ5CEMeJw==
X-Received: by 2002:a17:90b:2688:b0:301:1bce:c258 with SMTP id 98e67ed59e1d1-30c3d64711emr6415421a91.22.1746818921758;
        Fri, 09 May 2025 12:28:41 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39e760casm2209364a91.45.2025.05.09.12.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 12:28:41 -0700 (PDT)
Message-ID: <a071c33a195642de5530f897880e44bc1416a86b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 08/11] bpf: Report arena faults to BPF stderr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Emil Tsalapatis	 <emil@etsalapatis.com>,
 Barret Rhoden <brho@google.com>, Matt Bobrowski	
 <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Date: Fri, 09 May 2025 12:28:39 -0700
In-Reply-To: <20250507171720.1958296-9-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-9-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
> Begin reporting arena page faults and the faulting address to BPF
> program's stderr, for now limited to x86, but arm64 support should
> be easy to add.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

I think this needs a corresponding test case that would check
backtrace structure and address in the message.

>  arch/x86/net/bpf_jit_comp.c | 21 ++++++++++++++++++---
>  include/linux/bpf.h         |  1 +
>  kernel/bpf/arena.c          | 14 ++++++++++++++
>  3 files changed, 33 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 17693ee6bb1a..dbb0feeec701 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1384,15 +1384,27 @@ static int emit_atomic_ld_st_index(u8 **pprog, u3=
2 atomic_op, u32 size,
>  }
> =20
>  #define DONT_CLEAR 1
> +#define ARENA_FAULT (1 << 8)
> =20
>  bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_reg=
s *regs)
>  {
> -	u32 reg =3D x->fixup >> 8;
> +	u32 arena_reg =3D (x->fixup >> 8) & 0xff;
> +	bool is_arena =3D !!arena_reg;
> +	u32 reg =3D x->fixup >> 16;
> +	unsigned long addr;
> +
> +	/* Read here, if src_reg is dst_reg for load, we'll write 0 to it. */
> +	if (is_arena)
> +		addr =3D *(unsigned long *)((void *)regs + arena_reg);

Is it necessary to also take offset into account when calculating address?

> =20
>  	/* jump over faulting load and clear dest register */
>  	if (reg !=3D DONT_CLEAR)
>  		*(unsigned long *)((void *)regs + reg) =3D 0;
>  	regs->ip +=3D x->fixup & 0xff;
> +
> +	if (is_arena)
> +		bpf_prog_report_arena_violation(reg =3D=3D DONT_CLEAR, addr);
> +
>  	return true;
>  }
> =20
> @@ -2043,7 +2055,10 @@ st:			if (is_imm8(insn->off))
>  				ex->data =3D EX_TYPE_BPF;
> =20
>  				ex->fixup =3D (prog - start_of_ldx) |
> -					((BPF_CLASS(insn->code) =3D=3D BPF_LDX ? reg2pt_regs[dst_reg] : DON=
T_CLEAR) << 8);
> +					((BPF_CLASS(insn->code) =3D=3D BPF_LDX ? reg2pt_regs[dst_reg] : DON=
T_CLEAR) << 16)
> +					| ((BPF_CLASS(insn->code) =3D=3D BPF_LDX ? reg2pt_regs[src_reg] : r=
eg2pt_regs[dst_reg])<< 8);
> +				/* Ensure src_reg offset fits in 1 byte. */
> +				BUILD_BUG_ON(sizeof(struct pt_regs) > U8_MAX);

The ex->fixup field structure should be better documented, at the
moment docstring does not say anything about registers being encoded
within it. Also, maybe add a comment why `prog - start_of_ldx` is
guaranteed to be small.

>  			}
>  			break;
> =20

[...]


