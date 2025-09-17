Return-Path: <bpf+bounces-68686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECC1B81577
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 20:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E6B1C242C2
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0D93002BC;
	Wed, 17 Sep 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DypwSF69"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301B3301033
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133809; cv=none; b=PySvzRbCLCT9eO4L2mpDAQH3SMw2iCiyc/nZzK8kTVz4F8a33SjxeYDV6QV/JT/9YMrnor9EP069JuYAMV4LGsoQ4zeQeo978jK/PPoff3ss0JhxMPBpmzMR5DMZPCGAoyKm2itsVUpuYO2syt5pRdhfFf3IV5qhANp6BMaZRM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133809; c=relaxed/simple;
	bh=jmg4QbCPwIIbqd/MEaT1EsCdjqnajFV45I2tuZbcD/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ODFavDRLahRXKfYjuezCjO4atAVct417m1wwjPwcyCgwfuQ4A4tvZ0UyjpmW+IlnVaqVYc21FnnOfjoXNWIW2dWSXJ4utMR97H8nwii0o4x2Th9Twj/W/I/toZ4/hxJKTkc4aZguQLrRyaVE70DToIoP5T7LUlLgoOzOh6qiK5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DypwSF69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DF0C4CEE7;
	Wed, 17 Sep 2025 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758133809;
	bh=jmg4QbCPwIIbqd/MEaT1EsCdjqnajFV45I2tuZbcD/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DypwSF69psxEsV8k3rLRVaxUtu2j34nqqIpKN8yyYz6pQcg5b6NwwTU7DRZlKadln
	 KVv9v/YWW0a1fH/ONokIVMvC4RdGzwyfjqr13VR0rVrynMyMw074+KA/vTHl2iye41
	 9qxZZ1KZJI0c1tTigFebGHCwEagalcEdSWabxQsFdWoJSSyQBHe0awnQ5JkqL+H9Ht
	 O6u88YDN00olbZiK2JvCprVTPufZPOvVMIYzQYVD9OtW9AKEOJlRx+u61GRhaRPPUp
	 /jIHivBUrbswCd3KB8G+SrOHsLkEBRMf+VwyARzuUQV//cV4+SaPvrEQ+qHJcdWyrR
	 7T891akNnFPGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CFBA639D0C20;
	Wed, 17 Sep 2025 18:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 arm64: Call bpf_jit_binary_pack_finalize() in bpf_jit_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175813380950.2100449.12883903406643284223.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 18:30:09 +0000
References: <20250916232653.101004-1-hengqi.chen@gmail.com>
In-Reply-To: <20250916232653.101004-1-hengqi.chen@gmail.com>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, puranjay@kernel.org, xukuohai@huaweicloud.com,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 16 Sep 2025 23:26:53 +0000 you wrote:
> The current implementation seems incorrect and does NOT match the
> comment above, use bpf_jit_binary_pack_finalize() instead.
> 
> Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management")
> Acked-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, arm64: Call bpf_jit_binary_pack_finalize() in bpf_jit_free()
    https://git.kernel.org/bpf/bpf-next/c/6ff4a0fa3e1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



