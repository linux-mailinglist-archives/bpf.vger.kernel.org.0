Return-Path: <bpf+bounces-41607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA44998F32
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CD528C028
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 18:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BAA19B3EE;
	Thu, 10 Oct 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVW3kRZe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BC1CEEB9;
	Thu, 10 Oct 2024 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583225; cv=none; b=tcRB3TzkOvppJL7vyjoOrKIiE5dOylt/GCUEdFHvc1avx/rwwhxYyEONONUfyqW3W1Zod2wvIStGwvaI+RVLb1OHq2j2ovLLQaskyMhpLoXKlb+nNJoyJf1UYh+S9AQfataeMUucmxWDqvJMGBVSgBBcFezdxvpyPIX5UqAAtQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583225; c=relaxed/simple;
	bh=OMrWVEwG56phLjB3lXvtiLtZ/60G1Bl4ql3231HDQLM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rdmMLgSWMTENdh9aN8USns9Jz0LzIXN1ytR7W6a2giAmicrdU1kyHrhmaoqba3jGSQXwOoxvDzk4aRc+lOoQp1naF6xDL7mVRYAHGWvu0OpdoclHxA6xsjKGshLwXB/nNA3dmiIGzeDMQKn4KGF7zPGNBCS3mpFLy4D0/pX3cV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVW3kRZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512EDC4CEC6;
	Thu, 10 Oct 2024 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728583225;
	bh=OMrWVEwG56phLjB3lXvtiLtZ/60G1Bl4ql3231HDQLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KVW3kRZeD1kePYkc78Nr3zoWKzbCrhXldWdSEI7SLXeRNGy/mu1x2nLMG/NCa9mCE
	 7bHMR6MGhR26JMCfuhgBd3r6xBrezlFZDrsC3JAwuDtttfh5jO32VuIjc4f9JxozwJ
	 y6ryZSIvsxHTMO6VldIHpHgskMXqRGaARSL98vYPsJbTuDSI7x1gIgsJpZZ7d5z42Y
	 iiMmwaw2ONq7YuEchFWmhoNyFNjmdHppl+th2zGO9qDz51H713QyhHuVy8qHD0Z9hi
	 PHiPSuTslM8NZ0f2h8z1vpftpaodFYlHsSsIf2Jx3WNQNdNcBkDb0tR9U3NSL0Xiyd
	 asYY+CVW7cGXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2E03803263;
	Thu, 10 Oct 2024 18:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/3] Fix caching of BTF for kfuncs in the verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172858322977.2114175.5921702022516465256.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 18:00:29 +0000
References: <20241010-fix-kfunc-btf-caching-for-modules-v2-0-745af6c1af98@redhat.com>
In-Reply-To: <20241010-fix-kfunc-btf-caching-for-modules-v2-0-745af6c1af98@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, simon.sundberg@kau.se,
 bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Oct 2024 15:27:06 +0200 you wrote:
> When playing around with defining kfuncs in some custom modules, we
> noticed that if a BPF program calls two functions with the same
> signature in two different modules, the function from the wrong module
> may sometimes end up being called. Whether this happens depends on the
> order of the calls in the BPF program, which turns out to be due to the
> use of sort() inside __find_kfunc_desc_btf() in the verifier code.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/3] bpf: fix kfunc btf caching for modules
    https://git.kernel.org/bpf/bpf/c/6cb86a0fdece
  - [bpf,v2,2/3] selftests/bpf: Provide a generic [un]load_module helper
    https://git.kernel.org/bpf/bpf/c/4192bb294f80
  - [bpf,v2,3/3] selftests/bpf: Add test for kfunc module order
    https://git.kernel.org/bpf/bpf/c/f91b256644ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



