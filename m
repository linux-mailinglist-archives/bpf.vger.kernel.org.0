Return-Path: <bpf+bounces-9321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F351E7937C7
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA91281278
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678071370;
	Wed,  6 Sep 2023 09:10:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D1A110D;
	Wed,  6 Sep 2023 09:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F589C433CC;
	Wed,  6 Sep 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693991422;
	bh=Pg5P5w70D/0sYqWVupcpHLssw2eK1+o374nOt3wVL34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CIpjAbeu4rwEpyl37ZzRTXPakps6nehrMOebuDQpFW3xL1ltHAsjbNz04xAy05dRO
	 2T0c/FhcdpQHVN5Gk+rpinbIoQPiZBFme73alBfNOvhXpj35zshICqRAulo7djAEzt
	 bk0XlO6NODt4YnVcK09yND+/WedkHV1hhJ6VOouUj3dmf7GSQB9UZQjJLJZipdpf3d
	 UuSkESigOOUewBCiZ6Nd4CpfVHwzoGgLyW428T2MZFS7AwEyYVYMQs6oZi9lwGMQQ7
	 HyQ9o/2UmuSywi22ZfMm89XPLyiHCNEaY55QnHvutEeQfEW1m1XeIazhs7417Z3ePH
	 5/7aEWARm3E9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 654C9E22B00;
	Wed,  6 Sep 2023 09:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/3] bpf: Fixes for bpf_sk_storage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169399142241.26603.13283011863319569534.git-patchwork-notify@kernel.org>
Date: Wed, 06 Sep 2023 09:10:22 +0000
References: <20230901231129.578493-1-martin.lau@linux.dev>
In-Reply-To: <20230901231129.578493-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  1 Sep 2023 16:11:26 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> This set has two fixes for bpf_sk_storage. Please see the individual
> patch for details.
> 
> Martin KaFai Lau (3):
>   bpf: bpf_sk_storage: Fix invalid wait context lockdep report
>   bpf: bpf_sk_storage: Fix the missing uncharge in sk_omem_alloc
>   selftests/bpf: Check bpf_sk_storage has uncharged sk_omem_alloc
> 
> [...]

Here is the summary with links:
  - [bpf,1/3] bpf: bpf_sk_storage: Fix invalid wait context lockdep report
    https://git.kernel.org/bpf/bpf/c/a96a44aba556
  - [bpf,2/3] bpf: bpf_sk_storage: Fix the missing uncharge in sk_omem_alloc
    https://git.kernel.org/bpf/bpf/c/55d49f750b1c
  - [bpf,3/3] selftests/bpf: Check bpf_sk_storage has uncharged sk_omem_alloc
    https://git.kernel.org/bpf/bpf/c/a96d1cfb2da0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



