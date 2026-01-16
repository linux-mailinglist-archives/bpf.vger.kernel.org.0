Return-Path: <bpf+bounces-79271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA025D32CE7
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B70D530B4B7A
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AFA394478;
	Fri, 16 Jan 2026 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBvpwBLn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5CD395D90
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574462; cv=none; b=qXoV+mbeZXS1/NqQ7T9uHyG7heavpYFcU/n41eb6eaa1vWnKJX0znZvx7qOZsUJX7dl3aSa2Zm2gSIQPhYtUNwcEz//QtI/ST0dOUIZ6USY37+C9Bgr7DSKka5yOVcMCjEUkQ8FNXL1t9HvwbIQCHV9Gf+X6wH71WFqqMSDU53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574462; c=relaxed/simple;
	bh=ImQ8fcoydHR+VJ419XmAS8MiIoVFOpyvdDpTFu9aI1A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZkuyZwx3FijIThfnEoLp264F7H9aG7zd7MAMUe7NM5iPRLWP+WckfrZhz5nQJjGeES5SfGJ+fhg1bb3KjHYjc/rlxACg4IMhQazZMiGE2w1dELXt6JQQlmjAUgFc7mOSLJWlsfhh24SW89AITxyTM8EWMJNzEOoX/1fVL4o+Q48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBvpwBLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F10C16AAE;
	Fri, 16 Jan 2026 14:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574461;
	bh=ImQ8fcoydHR+VJ419XmAS8MiIoVFOpyvdDpTFu9aI1A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IBvpwBLncqM6+uzJ422gz4FB06Sg/o3Taax5x0Vylxh+3tecqXzHHyskCfpS7qAZ7
	 bc848T2Pm08Qcq8/3YCnfhyLUTHfmJG6qwNDlZqm+lLsgh4aLOagtjukXtMr0A/zA6
	 nmdh08yTBPTpJKdZdvH+irXPAyFl/xfVQVoyz8QNk5CegZba+NFKcY6JeaM5T6yn4p
	 OFO04HKRBvtHxKc/6CkzH4Ag31C+qpDzWXy2W6AgM7ZVdfntmJo9ACGdIicY7/rHgO
	 MDUj+MtHx6MqnoeVlKxDnogUmu9EloR76ppcZUKYTgrJtRDLdsB7evgVYTpuBoL9rR
	 0U63XE7O83BNg==
Content-Type: multipart/mixed; boundary="===============1913563934924817466=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3185f73b3530930e0f857a4ca6eea5ff74f29ac6be40911e7df0a29d3c9b761d@mail.kernel.org>
In-Reply-To: <20260116142455.3526150-2-ishiyama@hpc.is.uec.ac.jp>
References: <20260116142455.3526150-2-ishiyama@hpc.is.uec.ac.jp>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_strncasecmp kfunc
From: bot+bpf-ci@kernel.org
To: ishiyama@hpc.is.uec.ac.jp,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,mykyta.yatsenko5@gmail.com,ishiyama@hpc.is.uec.ac.jp,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 16 Jan 2026 14:41:01 +0000 (UTC)

--===============1913563934924817466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9eaa4185e0a7..bdd76209cfcf 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3406,18 +3406,23 @@ __bpf_kfunc void __bpf_trap(void)
>   * __get_kernel_nofault instead of plain dereference to make them safe.
>   */
>
> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
>  {
>  	char c1, c2;
> -	int i;
> +	int i, max_sz;
>
>  	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
>  	    !copy_from_kernel_nofault_allowed(s2, 1)) {
>  		return -ERANGE;
>  	}
>
> +	if (len == 0)
> +		return 0;
> +
> +	max_sz = min_t(int, len, XATTR_SIZE_MAX);
                      ^^^

Can this cause incorrect behavior when len > INT_MAX? The len parameter
is size_t but min_t(int, ...) casts it to int before comparison. If a
BPF program passes a large value like 0x80000001, casting to int gives
-2147483647, which min_t() then selects as the minimum. This results in
max_sz being negative and the loop below never executing.

Other similar kfuncs like bpf_strnchr() and bpf_strnlen() use a different
pattern that avoids this issue:

    for (i = 0; i < count && i < XATTR_SIZE_MAX; i++)

Should this function use the same pattern for consistency and correctness?

> +
>  	guard(pagefault)();
> -	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +	for (i = 0; i < max_sz; i++) {
>  		__get_kernel_nofault(&c1, s1, char, err_out);

[ ... ]

> @@ -3431,6 +3436,8 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>  		s1++;
>  		s2++;
>  	}
> +	if (len < XATTR_SIZE_MAX)
> +		return 0;
>  	return -E2BIG;

When max_sz is negative due to the truncation issue above, the loop
does not execute at all, and execution falls through to this point.
With len > INT_MAX, the condition (len < XATTR_SIZE_MAX) is false, so
the function returns -E2BIG without performing any string comparison.
Is this the intended behavior?

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21070043212

--===============1913563934924817466==--

