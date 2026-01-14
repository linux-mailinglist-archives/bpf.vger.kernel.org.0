Return-Path: <bpf+bounces-78831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AACD1C444
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C18D5301396D
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EF029C347;
	Wed, 14 Jan 2026 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIvLJtc1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CCA296BB7
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361615; cv=none; b=hO8VnnILpepJmj3MSazeNME4Zn3CkNhid5xtDKs7HidvIcHJYxb8DPpfLmWua8LbpLx7fxk5COkIJxE6lFLJQUHOe6bOMVESR/A7fb/8P6jEdQ0ox4vL8elYE7zmOhLJVLlY8pF8gU5iRJvzn0oLYQj3bY+9roT8wKk0ns27lWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361615; c=relaxed/simple;
	bh=T4NBtFIdP/fLg6TaBmyozxSZkwNBM+xXu5POzC9e80k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ESnMVWzy6K0X7jNAncFgqxN9OQLmDruk5IF7FbmXrxBJe1CQ29FeFZqkpGlny/Xy8SFJelFwMGDDdWvqH4EBd1MwOxQ3mCleof/rV8mBXRVcyfJ7hBVqpxta+84yB8DUbUHlI5DKL768b0b1jSAwUK221XtPGWKFuZ+vbSpwgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIvLJtc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF04C4CEF7;
	Wed, 14 Jan 2026 03:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768361615;
	bh=T4NBtFIdP/fLg6TaBmyozxSZkwNBM+xXu5POzC9e80k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AIvLJtc1z/teuLf/kvmEpz627AcgN6vdWwKpCqyv8fDP20LiJwYF8sqQgXOqBWJ9U
	 rzAhwEAkPd2AxaNIQQtzFQJry/jc5kjauPpfauWVwZtFbIASb9Z2WN7Kz5r9vUUO+G
	 BBLL9JkeemlGnxPSWLWkyLZc83FWgVacqD4Xfl2T9OybTs4rABJgzgzwSMDmOSdvIL
	 8fwM7eHyHwwdds8opyZfNN5pCZgvrcnYParUr2o3Lpsrzj1DPOPeZgn5Pkm0dLz8Ck
	 fjhIF9pcoC3Nj5NUpof9MRlLKB3+1xP5gPpg7Pytx9/tOhJo978FZKfjr9oHk30ERL
	 AwUUNG7VbCpVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7890D3808200;
	Wed, 14 Jan 2026 03:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/3] bpf: return PTR_TO_BTF_ID | PTR_TRUSTED from
 BPF
 kfuncs by default
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176836140815.2572275.11630296761858309141.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 03:30:08 +0000
References: <20260113083949.2502978-1-mattbobrowski@google.com>
In-Reply-To: <20260113083949.2502978-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 13 Jan 2026 08:39:47 +0000 you wrote:
> Teach the BPF verifier to treat pointers to struct types returned from
> BPF kfuncs as implicitly trusted (PTR_TO_BTF_ID | PTR_TRUSTED) by
> default. Returning untrusted pointers to struct types from BPF kfuncs
> should be considered an exception only, and certainly not the norm.
> 
> Update existing selftests to reflect the change in register type
> printing (e.g. `ptr_` becoming `trusted_ptr_` in verifier error
> messages).
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: return PTR_TO_BTF_ID | PTR_TRUSTED from BPF kfuncs by default
    https://git.kernel.org/bpf/bpf-next/c/f8ade2342e22
  - [bpf-next,2/3] bpf: drop KF_ACQUIRE flag on BPF kfunc bpf_get_root_mem_cgroup()
    https://git.kernel.org/bpf/bpf-next/c/e463b6de9da1
  - [bpf-next,3/3] selftests/bpf: assert BPF kfunc default trusted pointer semantics
    https://git.kernel.org/bpf/bpf-next/c/bbdbed193bcf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



