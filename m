Return-Path: <bpf+bounces-21917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74925854023
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D8D1C28464
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DBC63106;
	Tue, 13 Feb 2024 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F68IIoA7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502062A02
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867032; cv=none; b=eetWyxa3Ccz3zv3ifqClsGpPeWl2NZsX8ZOPQDYZeeQW9g1ZUgruYo0ymwuD1Nli3/L/m94tyJ7RDG+THRwq51EF807s88SZzrGxz9XCG2+8+YGfPwD5NOrDQ+iUA+JCxAFy4/fHp1OuVBuCHEXfA+vk2gkw6w78ygJb4IfWaUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867032; c=relaxed/simple;
	bh=Hpjw/6GCGYLR9EuzzDULYPTfKr8Zl20kOtdLfDpg39c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p8LKydOp1OBEbL5dDrlnFYvAz9EsmGKtbAYjYTmS06lgODvdTC0dI9HGaqMhJN8vNZehmy1ppINmJ9bSm4cc0EOjp4zt9T8GUjmyksHDLINhqkQo0/bFyOYRCZZq9XynJHbx04PwE66PUD5u8SCoZdNiwWYfDrRQU8EZfVUl3S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F68IIoA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 606B3C43390;
	Tue, 13 Feb 2024 23:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707867030;
	bh=Hpjw/6GCGYLR9EuzzDULYPTfKr8Zl20kOtdLfDpg39c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F68IIoA72xJjpcUxeVrgguNldbN7O9M6FT5fg9fwId+yh0Fw+PJVP6+e//OeX/aLh
	 snfVHDSrCjOtHyccS/JaT/t/2I+vPSkr8eb6CSQlk9xPl1G+eTUjebwJOxWuuL/zh6
	 dO0D/+j9VSCRLsxWq53yfeV04oU2KGqI6e0jjFLSKxwio2+l5OLL34uQEAUqCEqoWv
	 8ZRu2tTs2W34Dj6EfWhfMaVTnmywXYIMSJHOlYjZWdCvpT38AV301gPcPyoJBfc88R
	 Die93zpSYUy4AlO22EP1Chi+T2+iSShZGEr9KV6ohwKv6k2k6dzSl9hstz0LZ6EIQk
	 WEmy4VOhotANA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4467DD84BCE;
	Tue, 13 Feb 2024 23:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v8 0/4] Support PTR_MAYBE_NULL for struct_ops
 arguments.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170786703026.16188.1984037138010289409.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 23:30:30 +0000
References: <20240209023750.1153905-1-thinker.li@gmail.com>
In-Reply-To: <20240209023750.1153905-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 davemarchevsky@meta.com, dvernet@meta.com, sinquersw@gmail.com,
 kuifeng@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  8 Feb 2024 18:37:46 -0800 you wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Allow passing null pointers to the operators provided by a struct_ops
> object. This is an RFC to collect feedbacks/opinions.
> 
> The function pointers that are passed to struct_ops operators (the function
> pointers) are always considered reliable until now. They cannot be
> null. However, in certain scenarios, it should be possible to pass null
> pointers to these operators. For instance, sched_ext may pass a null
> pointer in the struct task type to an operator that is provided by its
> struct_ops objects.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/4] bpf: add btf pointer to struct bpf_ctx_arg_aux.
    https://git.kernel.org/bpf/bpf-next/c/77c0208e199c
  - [bpf-next,v8,2/4] bpf: Move __kfunc_param_match_suffix() to btf.c.
    https://git.kernel.org/bpf/bpf-next/c/6115a0aeef01
  - [bpf-next,v8,3/4] bpf: Create argument information for nullable arguments.
    https://git.kernel.org/bpf/bpf-next/c/1611603537a4
  - [bpf-next,v8,4/4] selftests/bpf: Test PTR_MAYBE_NULL arguments of struct_ops operators.
    https://git.kernel.org/bpf/bpf-next/c/00f239eccf46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



