Return-Path: <bpf+bounces-29015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48198BF56C
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 07:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5920D1F24567
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 05:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC8017BDA;
	Wed,  8 May 2024 05:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="afORrE3T"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8CE17559;
	Wed,  8 May 2024 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715144746; cv=none; b=FvDztn8FQC1qHpkMobaKGFkgNHzpaSn2B4lpQDg2iTfmsKh+e56jQsAq4wzXibjs+W9cPglf/Jvmhi2eAVmdxIXjU+7yONMkslGcL11iLVktOM6vXdtq/hDNrlaNqO13q5fpFkShYpuQruq+cvm+dq3Eoo2qLdMpYAb4wnHdI34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715144746; c=relaxed/simple;
	bh=8tlkHKRM2YMJamihFiXet8yEil9oqOy2oa3BI13SVkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bpqkM9OlvE6mxn0yVsvTTDmy0lMzYgny10oThQF/swO6FwkmEoBeW5MCgUxUJMY1Fn27yL+dNUA94TF2NmpVo78TrPqvuIkFgOXhabl5fRPJNDLGVaAxcJGa65Zl+toLvhRPv9gVORqPPjwygblhoSsDCtaDeHk/iRnD0YIIb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=afORrE3T; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1715144741;
	bh=qDxi+XXbzr8mIuwlB1aliy4UlEscitEJu0tfYntXSqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=afORrE3T6fm9owzOay6Q4EjIov5tp69f4yV6zWLQdPsWDile3ZCCvtHhzO2PqLNhY
	 m+q7v/FoA8SLQDfn596Zo1eZM+hR6/YdWkcLKevLwwEApws3ePuCppayzHHPscXyJF
	 TvBQUdEABHJNrqArtC95+goi1c4tXk3VHRtSchfW2Fvwvkx7nbQaM69bjdX40GStHi
	 sswR2je3OJ6aclZFJUTBI6AB57hHjLBZkIb72MLcLpFHfZFymMKkfdhI1OB7cMBOgs
	 X2mfW+XeE/gaofip2NTMzaeOv5sbyT2gLUkqkWyl5VgYm4tFgR3AvFayfeeXD22ujL
	 DGyduQoKPLUuQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZ34h4KM9z4wc1;
	Wed,  8 May 2024 15:05:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: Re: [PATCH bpf] powerpc/bpf: enforce full ordering for ATOMIC
 operations with BPF_FETCH
In-Reply-To: <20240507175439.119467-1-puranjay@kernel.org>
References: <20240507175439.119467-1-puranjay@kernel.org>
Date: Wed, 08 May 2024 15:05:40 +1000
Message-ID: <87o79gopuj.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:
> The Linux Kernel Memory Model [1][2] requires RMW operations that have a
> return value to be fully ordered.
>
> BPF atomic operations with BPF_FETCH (including BPF_XCHG and
> BPF_CMPXCHG) return a value back so they need to be JITed to fully
> ordered operations. POWERPC currently emits relaxed operations for
> these.

Thanks for catching this.

> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index 2f39c50ca729..b635e5344e8a 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -853,6 +853,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>  			/* Get offset into TMP_REG */
>  			EMIT(PPC_RAW_LI(tmp_reg, off));
>  			tmp_idx = ctx->idx * 4;
> +			/*
> +			 * Enforce full ordering for operations with BPF_FETCH by emitting a 'sync'
> +			 * before and after the operation.
> +			 *
> +			 * This is a requirement in the Linux Kernel Memory Model.
> +			 * See __cmpxchg_u64() in asm/cmpxchg.h as an example.
> +			 */
> +			if (imm & BPF_FETCH)
> +				EMIT(PPC_RAW_SYNC());
>  			/* load value from memory into r0 */
>  			EMIT(PPC_RAW_LWARX(_R0, tmp_reg, dst_reg, 0));
>  
> @@ -905,6 +914,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>  
>  			/* For the BPF_FETCH variant, get old data into src_reg */
>  			if (imm & BPF_FETCH) {
> +				/* Emit 'sync' to enforce full ordering */
> +				EMIT(PPC_RAW_SYNC());
>  				EMIT(PPC_RAW_MR(ret_reg, ax_reg));
>  				if (!fp->aux->verifier_zext)
>  					EMIT(PPC_RAW_LI(ret_reg - 1, 0)); /* higher 32-bit */

On 32-bit there are non-SMP systems where those syncs will probably be expensive.

I think just adding an IS_ENABLED(CONFIG_SMP) around the syncs is
probably sufficient. Christophe?

cheers

