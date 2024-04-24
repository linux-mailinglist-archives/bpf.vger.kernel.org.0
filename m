Return-Path: <bpf+bounces-27764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B618B16DB
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 01:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD54CB22D19
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460EC16F0C6;
	Wed, 24 Apr 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UasZyKd1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA34E15747E;
	Wed, 24 Apr 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000229; cv=none; b=IEO2N2QJta+B4kJA2CoENUPfDlE/M5bS7WFBeDrdc35T99YdrUbl1Et4Y4RuAAPUojnTHogSBqprdH4pQL/gUidRMG6AxnCdvPQ7MHKpRMME/KH7CQbvHWbqW7skvDzM1HlQHRxY82N/sMP+YKL5aSwH/zkYrTV4FG0IHoOijKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000229; c=relaxed/simple;
	bh=ffyBvOgJE3UJUCSua9drXtFkkbSwZ/MOjvhjANfdY/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WwxJFeX0IuhgeHulyCKIL9ePOpXLa9omXJv/SaymdMOZ9qbMeRwBV8hEd9f+k8YB5lTx8dXXLitLjn/dMygq0MEYOYstTSD3RWyKy96xQMXPzTVIkBgdGRpfkEsm1suSUyuWTC9lIt4Kd/1z83Qlr/vogoxRhXoXFF3GgtHpjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UasZyKd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2621CC113CE;
	Wed, 24 Apr 2024 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714000229;
	bh=ffyBvOgJE3UJUCSua9drXtFkkbSwZ/MOjvhjANfdY/o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UasZyKd1cP37J2MhcUBgJWS9HCwg/1r9NrwyRlqMioptMDAtwu8Vsr9mezzcVNasy
	 o6Cd/M6b8B6Bo7GYGIOtOH8fMtLcFEooGRPImC6xPdEN983RXanPrnjjU6IHv1uSQQ
	 YJNx8JYJDo328KrQnoMaARsvgkYpy6cwCK7AZgyfgHRslMRD2UUKU3bWoRTMDCkONh
	 jeHuD1cYLXBID0igIn+73KrWAcLo3Sugh3b5zwyO3RAAnoYtC4dZ/y0WI2wJca7eWB
	 bj7j1CDKq64oNtN+TC2KeQyfB91DpNsH70XuJOLMfdYihKNwMj95oC9fyN2uvGTK7Q
	 jHqxJqtt0dAcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14E4EC595C5;
	Wed, 24 Apr 2024 23:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v10 0/4] BPF crypto API framework
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171400022908.11196.7603680492975512633.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 23:10:29 +0000
References: <20240422225024.2847039-1-vadfed@meta.com>
In-Reply-To: <20240422225024.2847039-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, kuba@kernel.org, martin.lau@linux.dev,
 andrii@kernel.org, ast@kernel.org, mykolal@fb.com,
 herbert@gondor.apana.org.au, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 22 Apr 2024 15:50:20 -0700 you wrote:
> This series introduces crypto kfuncs to make BPF programs able to
> utilize kernel crypto subsystem. Crypto operations made pluggable to
> avoid extensive growth of kernel when it's not needed. Only skcipher is
> added within this series, but it can be easily extended to other types
> of operations. No hardware offload supported as it needs sleepable
> context which is not available for TX or XDP programs. At the same time
> crypto context initialization kfunc can only run in sleepable context,
> that's why it should be run separately and store the result in the map.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v10,1/4] bpf: make common crypto API for TC/XDP programs
    https://git.kernel.org/bpf/bpf-next/c/3e1c6f35409f
  - [bpf-next,v10,2/4] bpf: crypto: add skcipher to bpf crypto
    https://git.kernel.org/bpf/bpf-next/c/fda4f71282b2
  - [bpf-next,v10,3/4] selftests: bpf: crypto skcipher algo selftests
    https://git.kernel.org/bpf/bpf-next/c/91541ab192fc
  - [bpf-next,v10,4/4] selftests: bpf: crypto: add benchmark for crypto functions
    https://git.kernel.org/bpf/bpf-next/c/8000e627dc98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



