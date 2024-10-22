Return-Path: <bpf+bounces-42841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2748A9AB9AB
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 00:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C6D1C23BE4
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2416D1CDFBF;
	Tue, 22 Oct 2024 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNVL6MTr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BF1C8FCF
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637425; cv=none; b=M9U9y1+ucaQwO7Z3rwqgli/x0acMEGrTUouWux/YlqzfYB/m8A/sW14hSzQT/SluFkYEyTCKCubVMaFkdcJLLuPlfuFF6/O8SH+4rcO0OX66FgWDgS/q9wvNlCf+ofTNtdvzWVkuLgHG9H4n1FfxMOaM4DhudZlj1qHTEwSehnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637425; c=relaxed/simple;
	bh=Ptf5eUVpCle4/T2Cp25AODQ7eKqyzJ9AXeWvuWWTsnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N+qhGMOcdAYe1GS7QS+wPlpJ/Zj1vS0Eo7ifdPfZnjUj+xrZEGCa0CZvDD5Fm4gv8nvilJNz045z5JsF12wfbuyL0munGMhAfxX4CeU39SfZuRlm2psE/3nzpfGSPmwNV9tx1qoNZXsB6i1TSzecOULl8c+ZJn1zfnHrsRQvU2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNVL6MTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7A9C4CEC3;
	Tue, 22 Oct 2024 22:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729637425;
	bh=Ptf5eUVpCle4/T2Cp25AODQ7eKqyzJ9AXeWvuWWTsnA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DNVL6MTrgRWHodj5+/huezP3kWR9L9DXzs9YjnLZvgnY1OpsQxAQv1makJln4yxIm
	 RmfhVNG9iPAnr1XY4hqonNXZbxQ0KtcX3HL7IY4g067vezkFCwrT+zXnVpwZe9o0G5
	 6LApG7Ocz3HyCNFlBYSU708TSNIlNb2j9P+7CRDSdAEktYRtuALoR4+wX1YVPDVsAS
	 xz6gOcE5Ft57D3huy+4vAdnqCNQPbtBzHlwk9C1MwHfMIWwCZJe4adhYZRnnLvCyfV
	 3eLe/n05YOXC8UQrY3AVsZIGtIj3U0lNpmJpZb+ace1Wa87fsS0mf8Z/GQvU/55ezR
	 EXqfppkOWsalg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3DC3822D22;
	Tue, 22 Oct 2024 22:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/5] bpf: Add MEM_WRITE attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172963743177.1101685.1294930119594864937.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 22:50:31 +0000
References: <20241021152809.33343-1-daniel@iogearbox.net>
In-Reply-To: <20241021152809.33343-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, kongln9170@gmail.com, memxor@gmail.com,
 bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 21 Oct 2024 17:28:05 +0200 you wrote:
> Add a MEM_WRITE attribute for BPF helper functions which can be used in
> bpf_func_proto to annotate an argument type in order to let the verifier
> know that the helper writes into the memory passed as an argument. In
> the past MEM_UNINIT has been (ab)used for this function, but the latter
> merely tells the verifier that the passed memory can be uninitialized.
> 
> There have been bugs with overloading the latter but aside from that
> there are also cases where the passed memory is read + written which
> currently cannot be expressed, see also 4b3786a6c539 ("bpf: Zero former
> ARG_PTR_TO_{LONG,INT} args in case of error").
> 
> [...]

Here is the summary with links:
  - [bpf,1/5] bpf: Add MEM_WRITE attribute
    https://git.kernel.org/bpf/bpf/c/6fad274f06f0
  - [bpf,2/5] bpf: Fix overloading of MEM_UNINIT's meaning
    https://git.kernel.org/bpf/bpf/c/8ea607330a39
  - [bpf,3/5] bpf: Remove MEM_UNINIT from skb/xdp MTU helpers
    https://git.kernel.org/bpf/bpf/c/14a3d3ef02ba
  - [bpf,4/5] selftests/bpf: Add test for writes to .rodata
    https://git.kernel.org/bpf/bpf/c/baa802d2aa5c
  - [bpf,5/5] selftests/bpf: Add test for passing in uninit mtu_len
    https://git.kernel.org/bpf/bpf/c/82bbe133312b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



