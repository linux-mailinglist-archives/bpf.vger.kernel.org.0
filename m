Return-Path: <bpf+bounces-17271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66380B067
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62111C20CFB
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 23:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A8E5AB97;
	Fri,  8 Dec 2023 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbAak7uq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB15733C
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 23:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2E9DC433CA;
	Fri,  8 Dec 2023 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702077024;
	bh=kctFP2sXwX8/CnlcZa5rtZETo3pqb6WK9ZpNtlDnn28=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XbAak7uqhKr2FKtyi5dNhVs7OVpRadm/z5BBQoZouIzyRgIDLrcclHH+rxFuHpYY5
	 qupD0vPYntVh9BvySwKkPNB6PZ4zMxTC6E9RAIy/TqEYH1jZAxsc9x8i18rVfafo4Y
	 wQXdoPewNVlCMTnsFMn2b905avp6JJCBCI7SKxYoLBcvebiOzsqAdIpuPfOooCzogG
	 4V85v9brCL9QG1EMWU/WW5k7G3V6D7rcZMHCX0CW6m9ddN8h9BrZNqHxVXsPYN9sEL
	 7QZ4ZVUulSIHe+rqcgVQbsqJzhCS6jH+7tcVVNVwJlNtbwYEXqYN+e9FBtBCSWNzbr
	 ZouSmZO2JV4Fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA588C04E32;
	Fri,  8 Dec 2023 23:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5 0/3] bpf: fix accesses to uninit stack slots
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170207702469.20219.7388621141536966920.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 23:10:24 +0000
References: <20231208032519.260451-1-andreimatei1@gmail.com>
In-Reply-To: <20231208032519.260451-1-andreimatei1@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com, andrii.nakryiko@gmail.com,
 eddyz87@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  7 Dec 2023 22:25:16 -0500 you wrote:
> Fix two related issues issues around verifying stack accesses:
> 1. accesses to uninitialized stack memory was allowed inconsistently
> 2. the maximum stack depth needed for a program was not always
> maintained correctly
> 
> The two issues are fixed together in one commit because the code for one
> affects the other.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] bpf: add some comments to stack representation
    https://git.kernel.org/bpf/bpf-next/c/92e1567ee3e3
  - [bpf-next,v5,2/3] bpf: fix accesses to uninit stack slots
    https://git.kernel.org/bpf/bpf-next/c/6b4a64bafd10
  - [bpf-next,v5,3/3] bpf: minor cleanup around stack bounds
    https://git.kernel.org/bpf/bpf-next/c/2929bfac006d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



