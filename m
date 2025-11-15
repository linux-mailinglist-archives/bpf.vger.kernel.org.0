Return-Path: <bpf+bounces-74639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DF3C5FF2B
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 04:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E280935776E
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CA6223DFB;
	Sat, 15 Nov 2025 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDld472y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E01C8606
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763175717; cv=none; b=i/YtBsLALpCVG49+qSlPE5j14aZDekH5zxc1kHMhGPD7YSq1/1b2tXY72mEpQZGZxorhkytfwLXWDqVDZKpES3i7nFzql5rsMsQu82YfdxpE/3b77r2vBje5ypLE3zec9gKoC+hhoNS52XrNUcoR92VmsFINjIa1NMf4A/70m7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763175717; c=relaxed/simple;
	bh=mxj34tfueo46uoG7j0wOiDAqCFHipEvYjp9+LLPGsD4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=L+U2vzgvdqvCtC1GtcawcJNRiOsO87eM0y8eG7tS/+C2DhiwfRGiHTubuP8hZDv8W2HkVp5HIxxcaLRkBUXqtFw+vWVz3axEyAw9/cXIkcwsIgEI6NbSjfqu0T1e00RFy5OWHFeQYV7fV/ErvR56aHmVoGKOM85Xt9zuwIHZrSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDld472y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75FFC4CEFB;
	Sat, 15 Nov 2025 03:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763175716;
	bh=mxj34tfueo46uoG7j0wOiDAqCFHipEvYjp9+LLPGsD4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IDld472ycn8e5MVfBUhl6rGPOLsK82IZ9jeNZyOsvqP5Lo/Qd2aO0sQ1KMcQd+8uF
	 qonJ4LmxNXl5TbgvJ0xgcsy3cPU2VWK3CZauWWlZIdNvsxHtzSoooib6T+dMAL3AGM
	 KmSJboYg3y3lWuYWNxR7LVmU9IkcL7Uoj+zeGqz6h2Jjg9V4SeCUFR3+hU+IbQgaKQ
	 CDUfyIgqlQvnCrCXWtTnB74ziSyLpgPp/6LiH1HuAL3ESwd2F98a06zeAi9iLWfXmc
	 uo5/4wpT+dyz0Q4lfLtSm+rSlzjAtVOLJFTmRGdcSCLFTyGP9U743Cu557Aul3zlme
	 An+lN0ZfKPPhA==
Content-Type: multipart/mixed; boundary="===============0190065948036025046=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4f10e55e592146a40bf7ad0814f4efe685b9f4d58ffd6ccbdb1fc9f5c93b90b0@mail.kernel.org>
In-Reply-To: <20251115022611.64898-3-alexei.starovoitov@gmail.com>
References: <20251115022611.64898-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for s>>=31 and s>>=63
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,sunhao.th@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Nov 2025 03:01:56 +0000 (UTC)

--===============0190065948036025046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
> index 8613ea160..0b572c067 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
> @@ -670,4 +670,47 @@ __naked void ldx_w_zero_extend_check(void)
>  	: __clobber_all);
>  }
>
> +SEC("socket")
> +__description("s>>=31")
> +__success __success_unpriv __retval(0)
> +__naked void arsh_31(void)
> +{
> +	/* Below is what LLVM generates in cilium's bpf_wiregard.o */
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	w2 = w0;					\
> +	w2 s>>= 31;					\
> +	w2 &= -134; /* w2 becomes 0 or -134 */		\
> +	if w2 s> -1 goto +2;				\
> +	if w2 != -136 goto +1;				\
                   ^^^^

Should this be -134 instead of -136?  The comment on the previous line
states that w2 becomes either 0 or -134 after the AND operation, so w2
can never equal -136.  This means the condition is always true and the
division by zero at "w0 /= 0" is never reachable.

In arsh_31(), after the arithmetic right shift by 31 bits, w2 will be
either 0 (if the sign bit was 0) or -1 (if the sign bit was 1). Then
"w2 &= -134" produces either 0 or -134, never -136.

> +	w0 /= 0;					\
> +	w0 = 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("s>>=63")
> +__success __success_unpriv __retval(0)
> +__naked void arsh_63(void)
> +{
> +	/* Copy of arsh_31 with s/w/r/ */
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r2 = r0;					\
> +	r2 <<= 32;					\
> +	r2 s>>= 63;					\
> +	r2 &= -134;					\
> +	if r2 s> -1 goto +2;				\
> +	if r2 != -136 goto +1;				\
                   ^^^^

Same issue here - should this be -134?  After the shift and AND
operations, r2 can only be 0 or -134, making the -136 check always true
and the "r0 /= 0" unreachable.

In arsh_63(), after left-shifting by 32 bits and then arithmetic
right-shifting by 63 bits, r2 becomes either 0 or -1. Then "r2 &= -134"
produces either 0 or -134, never -136.

> +	r0 /= 0;					\
> +	r0 = 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") = "GPL";


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19383126218

--===============0190065948036025046==--

