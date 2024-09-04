Return-Path: <bpf+bounces-38872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2148996BBFA
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12A1282D76
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 12:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21131D86F3;
	Wed,  4 Sep 2024 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6RXMJiB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A71D5893
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452576; cv=none; b=hiIrPrOqwTiiKA1C3ttKsknkHxhmCXCmzec4ndH3EyTCRKvZaSTc1Pm1Modqd0jTo8mlTI/aUB6bUsqcMSpTUNK4RkoCjeMOh6cW73M9G5kzhVso/nDXnJQ5DbovC+pnEUnT2MMGks+H5fMWRWz+/4ytFQ601tWL9vXG5iRp9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452576; c=relaxed/simple;
	bh=TwNLRotfcIUKiZhz0lZ853t0S9qZH+pPEXAJ2ZfbHS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ie1dOkgLp+YeJtg2XYzSzDFvB0AodOhrObM6n3b9OMTjBMZGg3SgKN8uB3Tfbuo/ysYixvLPG0sHdYYIGtLyboqua3Mb7413FF1T815qvY99j3a8VOPIuV9gli7Tx+fIgQ4pGGI3mLA7/ExHGGqxdOj1zGhWRhqrAP0DBj3liNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6RXMJiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1803C4CEC2;
	Wed,  4 Sep 2024 12:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725452576;
	bh=TwNLRotfcIUKiZhz0lZ853t0S9qZH+pPEXAJ2ZfbHS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C6RXMJiBiP1N08G2sJ9V+Jgw60QOOaIPAobbKCQqrMXODccM11rpQuEgZKGxEfK0I
	 Z78JKgPh+h+KevZCguhWOo8YbRyGpXViLPlEGT1Wq1xkgfnStL7yJyMUImmc7XybQy
	 8H7AqmmkxKsZTbUhNVfX43HqSAImnTBtSzJS0jMYL7N8IIR5vMaeC8kFLNWiNmJevQ
	 D0EKM4kyVL0ykGOzOlIw+YUeok/OkMQZsMbU7d4SrI/MTI0Y9u3pVDHjLdVjHjbHOX
	 ByqJ034J3XtE4b0GAqMLC2mpRKXOA8JlKkrrVmFvYHBnFxbq9UmDOX/k35VNHWBntQ
	 KNZzBBTWiY94g==
From: Puranjay Mohan <puranjay@kernel.org>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf, arm64: Jit BPF_CALL to direct call
 when possible
In-Reply-To: <20240903094407.601107-1-xukuohai@huaweicloud.com>
References: <20240903094407.601107-1-xukuohai@huaweicloud.com>
Date: Wed, 04 Sep 2024 12:22:35 +0000
Message-ID: <mb61pmsknsj5g.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Xu Kuohai <xukuohai@huaweicloud.com> writes:

> From: Xu Kuohai <xukuohai@huawei.com>
>
> Currently, BPF_CALL is always jited to indirect call. When target is
> within the range of direct call, BPF_CALL can be jited to direct call.
>
> For example, the following BPF_CALL
>
>     call __htab_map_lookup_elem
>
> is always jited to indirect call:
>
>     mov     x10, #0xffffffffffff18f4
>     movk    x10, #0x821, lsl #16
>     movk    x10, #0x8000, lsl #32
>     blr     x10
>
> When the address of target __htab_map_lookup_elem is within the range of
> direct call, the BPF_CALL can be jited to:
>
>     bl      0xfffffffffd33bc98
>
> This patch does such jit optimization by emitting arm64 direct calls for
> BPF_CALL when possible, indirect calls otherwise.
>
> Without this patch, the jit works as follows.
>
> 1. First pass
>    A. Determine jited position and size for each bpf instruction.
>    B. Computed the jited image size.
>
> 2. Allocate jited image with size computed in step 1.
>
> 3. Second pass
>    A. Adjust jump offset for jump instructions
>    B. Write the final image.
>
> This works because, for a given bpf prog, regardless of where the jited
> image is allocated, the jited result for each instruction is fixed. The
> second pass differs from the first only in adjusting the jump offsets,
> like changing "jmp imm1" to "jmp imm2", while the position and size of
> the "jmp" instruction remain unchanged.
>
> Now considering whether to jit BPF_CALL to arm64 direct or indirect call
> instruction. The choice depends solely on the jump offset: direct call
> if the jump offset is within 128MB, indirect call otherwise.
>
> For a given BPF_CALL, the target address is known, so the jump offset is
> decided by the jited address of the BPF_CALL instruction. In other words,
> for a given bpf prog, the jited result for each BPF_CALL is determined
> by its jited address.
>
> The jited address for a BPF_CALL is the jited image address plus the
> total jited size of all preceding instructions. For a given bpf prog,
> there are clearly no BPF_CALL instructions before the first BPF_CALL
> instruction. Since the jited result for all other instructions other
> than BPF_CALL are fixed, the total jited size preceding the first
> BPF_CALL is also fixed. Therefore, once the jited image is allocated,
> the jited address for the first BPF_CALL is fixed.
>
> Now that the jited result for the first BPF_CALL is fixed, the jited
> results for all instructions preceding the second BPF_CALL are fixed.
> So the jited address and result for the second BPF_CALL are also fixed.
>
> Similarly, we can conclude that the jited addresses and results for all
> subsequent BPF_CALL instructions are fixed.
>
> This means that, for a given bpf prog, once the jited image is allocated,
> the jited address and result for all instructions, including all BPF_CALL
> instructions, are fixed.
>
> Based on the observation, with this patch, the jit works as follows.
>
> 1. First pass
>    Estimate the maximum jited image size. In this pass, all BPF_CALLs
>    are jited to arm64 indirect calls since the jump offsets are unknown
>    because the jited image is not allocated.
>
> 2. Allocate jited image with size estimated in step 1.
>
> 3. Second pass
>    A. Determine the jited result for each BPF_CALL.
>    B. Determine jited address and size for each bpf instruction.
>
> 4. Third pass
>    A. Adjust jump offset for jump instructions.
>    B. Write the final image.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Thanks for working on this. I have tried to reason about all the
possible edge cases that I could think of and this looks good to me:

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZthRDBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nWV9AQD65wMoz0sXCz/RLUW6KyJR8YIFcK6t
mv8UWc489G5qkwEAw9OU+N77tsRWeeOrAh74AKxljzEyYaTvbpqRokPNTgg=
=Virj
-----END PGP SIGNATURE-----
--=-=-=--

