Return-Path: <bpf+bounces-16391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889D8800E75
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 16:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452DC281B77
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9E84A9AC;
	Fri,  1 Dec 2023 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i31RPWwF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89D4A990
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 15:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72346C433CA;
	Fri,  1 Dec 2023 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701444024;
	bh=9871UGOQDIzUABE1uASS2Q/ob0O8/UrIdeqJ7ZtwUbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i31RPWwFDYyw5s9vCDdFfdHhjpbVkHz0eMRsF3xr719ppZQittCG2sSFTgRRajB0l
	 aIloSRH6JdWmCFunwuI3UiAsjzn9/sd+0+kHfpqqTurwKOFYHA/RSuFglTOqbksMNJ
	 ESZAKhzHumq8vLT7s4rt0UFbqE8JK7uCwM0+HQudXASVn9nEsYAK1/ju4V/MmemsfA
	 i05aTCh5DmP6JMyLsmXq5kURay2XdQno2zB5fT5bApZdKoYXVnT0ApQzpi9B7N2lZU
	 R1xS4hmVAcSsix7wolkSfqfw+JoWSV+mG5+ovKzgP1UFOf248SUjpZTgEZ5FD9zEhk
	 nQPjPUi5k428A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 594CBDFAA94;
	Fri,  1 Dec 2023 15:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: fix erroneous bitmask operation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170144402436.18241.3376690555012122181.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 15:20:24 +0000
References: <20231130120353.3084-1-jeroen.vaningenschenau@novoserve.com>
In-Reply-To: <20231130120353.3084-1-jeroen.vaningenschenau@novoserve.com>
To: Jeroen van Ingen Schenau <jeroen.vaningenschenau@novoserve.com>
Cc: bpf@vger.kernel.org, maximmi@nvidia.com, tariqt@nvidia.com,
 ast@kernel.org, daniel@iogearbox.net, minh.lehoang@novoserve.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 30 Nov 2023 13:03:53 +0100 you wrote:
> xdp_synproxy_kern.c is a BPF program that generates SYN cookies on
> allowed TCP ports and sends SYNACKs to clients, accelerating synproxy
> iptables module.
> 
> Fix the bitmask operation when checking the status of an existing
> conntrack entry within tcp_lookup() function. Do not AND with the bit
> position number, but with the bitmask value to check whether the entry
> found has the IPS_CONFIRMED flag set.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: fix erroneous bitmask operation
    https://git.kernel.org/bpf/bpf-next/c/b6a3451e0847

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



