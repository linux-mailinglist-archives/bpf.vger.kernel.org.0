Return-Path: <bpf+bounces-39540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C749744F6
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 23:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580D6B2428A
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 21:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8CA1AB53A;
	Tue, 10 Sep 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJNU68T/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025651AAE3B;
	Tue, 10 Sep 2024 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004429; cv=none; b=rHdOZkI7qDbawxGsnVcN8rl3neTqjq8zut9zOakij1BDq6by8ZstqLxL5Y9M+0nSY5g6AzB6GQiBtGn66O/yoezNs9/PvP5zvak+HTvXk6Ffa8zCIZqDipQIhOa8h6Kn4aPFjm0Hu2Y+AoF+6Jd/LkyNJoOuCk2LPGNLPCRtWQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004429; c=relaxed/simple;
	bh=YHdWZytfycQFbDzmT1SDWbueBoCkZmZW3KhtrVF+LCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q5YqwbeR7937STGlwHhA156bQ+ktGALLvyd2a6c6NY3QLQW/D+M8+mShah0b0kmAMvYh9AZl/7eV97VOx0D3EFnBnaKVErihmZoS3uLTqsV3UA6xICwB5BNbfTcrYJZgOqKGN1S/1C9nyoDhdLSgDn5YVE1OWEP2oYp8F0xUWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJNU68T/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67270C4CECC;
	Tue, 10 Sep 2024 21:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726004428;
	bh=YHdWZytfycQFbDzmT1SDWbueBoCkZmZW3KhtrVF+LCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cJNU68T/HOPb6eJih68MeWKFBaCoA+pu5gGHVPMuv5bEY7LkuS4gHam9H5qnB8vTM
	 xmlMbcnCOck7zoe36WE61Bb987d6LEdq4wHbfb/D+rmAIO9LxCTdaaGiRewUhrQHVs
	 OCXM1XpmUzt+lk5ceSNZeVmMckyeRn1mnmGD+2KfyjmjbjGbXmQjuFGkvMgrNaAyrB
	 GALpisDj8BjYVhcLXgWVv3OdR5w4Cn+72hQiAyHudJb+6JvyZbvzDW9GxJuqiQnyRh
	 8vnye7C9WVFQbSkPxIzdu/n7QMGvlbYcagOnOrp3EnY8axTaJMd642wDNdR92qKxNd
	 URVE0M4/47QRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0023822FA4;
	Tue, 10 Sep 2024 21:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] MAINTAINERS: record lib/buildid.c as owned by BPF
 subsystem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172600442954.402663.7117052537185054787.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 21:40:29 +0000
References: <20240909190426.2229940-1-andrii@kernel.org>
In-Reply-To: <20240909190426.2229940-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, akpm@linux-foundation.org,
 linux-perf-users@vger.kernel.org, jolsa@kernel.org, song@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  9 Sep 2024 12:04:26 -0700 you wrote:
> Build ID fetching code originated from ([0]), and is still both owned
> and heavily relied upon by BPF subsystem.
> 
> Fix the original omission in [0] to record this fact in MAINTAINERS.
> 
>   [0] bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")
> 
> [...]

Here is the summary with links:
  - [bpf-next] MAINTAINERS: record lib/buildid.c as owned by BPF subsystem
    https://git.kernel.org/bpf/bpf-next/c/58ff04e2e223

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



