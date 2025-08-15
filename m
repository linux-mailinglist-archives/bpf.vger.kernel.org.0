Return-Path: <bpf+bounces-65709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D15B277E2
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589D21CC5BE3
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 04:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B417214236;
	Fri, 15 Aug 2025 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsvXZVaf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C0946A;
	Fri, 15 Aug 2025 04:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755233395; cv=none; b=nesk285GKt33BopHnsqlVYxQCvX0gSjtSGUCCzpQ4Q1E5aqihpo43eD3OBPhOf4WzSFnuxfZPjEyyxnA/fNNap9q9Ymj3QbQ170dy8VtYfxMF6jyqafmsPMhc+7MebS9VpJLaEVnORDUFbJ++JRg9ZncsnanEl2W70jTg5sDbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755233395; c=relaxed/simple;
	bh=C3q/y8MMaQ+0ZqOlJGv+UqBGHlP4qCoeDojB9hW3wg4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f4lCnguxRJRzVH3awDTdKnv77jC7zDpb7UtHNTw04jX3WFpDESNEujb+uxKPgSEQMoCjaj8jZ3iMgbGr4Gz04oRiW5Zc1y04jr/NqfCqv/l5vd8/An1CMvFRDmzuFRm+klct2XaGrNVUdXC6BQk6ziMe3B3Jev/btixcYXrORsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsvXZVaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BB6C4CEEB;
	Fri, 15 Aug 2025 04:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755233395;
	bh=C3q/y8MMaQ+0ZqOlJGv+UqBGHlP4qCoeDojB9hW3wg4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tsvXZVafto2wLwi1df8rYO8+Yxe5hu0rWL33WJMtBqEOYZRidqdeTNc04L2vaSBy9
	 B2xgXvk/CnozqkiKeHfbdmHVCb8rzSY1Gg7obhyZmCoU37UnH8QBUQhonRM90Ctx+b
	 aluvbx7dRwu9Z6Trz4EjjZZr2PCftOS88VojH74s5gpMt+pZZqyUh/zvLWWE38hdne
	 YwFHD5Ou6ulPLipRG95woj/cOIYufnn8VV/1qAdW9jk6Ad2xGx1rupESexIbmkBY1z
	 spJmOtgnStNCHiychMU2jGxctR2UWKnfWwj7SfyPFpS/jOdailVQWzOMO09ptClAjq
	 CzoMAzG5npBZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8C39D0C3B;
	Fri, 15 Aug 2025 04:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] cpumap: disable page_pool direct xdp_return need
 larger
 scope
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175523340651.927837.5280126542856100609.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 04:50:06 +0000
References: <175519587755.3008742.1088294435150406835.stgit@firesoul>
In-Reply-To: <175519587755.3008742.1088294435150406835.stgit@firesoul>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, kuba@kernel.org, dtatulea@nvidia.com, ast@kernel.org,
 borkmann@iogearbox.net, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 davem@davemloft.net, pabeni@redhat.com, tariqt@nvidia.com, memxor@gmail.com,
 john.fastabend@gmail.com, kernel-team@cloudflare.com, yan@cloudflare.com,
 jbrandeburg@cloudflare.com, carges@cloudflare.com, arzeznik@cloudflare.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 14 Aug 2025 20:24:37 +0200 you wrote:
> When running an XDP bpf_prog on the remote CPU in cpumap code
> then we must disable the direct return optimization that
> xdp_return can perform for mem_type page_pool.  This optimization
> assumes code is still executing under RX-NAPI of the original
> receiving CPU, which isn't true on this remote CPU.
> 
> The cpumap code already disabled this via helpers
> xdp_set_return_frame_no_direct() and xdp_clear_return_frame_no_direct(),
> but the scope didn't include xdp_do_flush().
> 
> [...]

Here is the summary with links:
  - [bpf] cpumap: disable page_pool direct xdp_return need larger scope
    https://git.kernel.org/bpf/bpf/c/7572a47ebcdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



