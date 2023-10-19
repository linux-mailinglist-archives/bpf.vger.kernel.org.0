Return-Path: <bpf+bounces-12701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A156B7CFD07
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 16:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF324B211FB
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 14:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE3B1DFDA;
	Thu, 19 Oct 2023 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlroUv46"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80662FE04
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 14:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD1E2C433C8;
	Thu, 19 Oct 2023 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697726424;
	bh=wZMEDDiAJJm7uSvNAHu2ZodrXmhZsLsW4c0xpTojxKc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AlroUv469+XL+E4tD2s4yTPU+FcX/YLSYFng0YMpumbOipAxBRCZ2qo7wiUYSr+v5
	 o0krLYoyt9r1Cs+0SGeExizbP3Sy7Qwe4p8tpxl7DU6G/I39NmWh1A4p+hq0RIX2CU
	 iZhftflioDc6pmi4XkeZCxc406Tp7HUyeHPziGgFV7L/PTyD9MEvpOpm11EfeHmDQ4
	 ic/4fq1BkAK5G3m78vIwR7W6G5M3VtuMMZay476/8F8BuUV6iSR55gTiBugS4hg/Gf
	 vVX3WadgyGga9+a+O5mnESymfXcvZ7KiwpeAOb7cPOnoG0tx3aG2Ll6bJSCQjPufLs
	 lKCR5027YVNQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BCF7C595CE;
	Thu, 19 Oct 2023 14:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpftool: Fix some json formatting for struct_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169772642455.3357.9344470246076270075.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 14:40:24 +0000
References: <20231018230133.1593152-1-chantr4@gmail.com>
In-Reply-To: <20231018230133.1593152-1-chantr4@gmail.com>
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, quentin@isovalent.com, andrii@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 18 Oct 2023 16:01:31 -0700 you wrote:
> When dumping struct_ops with bpftool, the json produced was invalid.
> 1) pointer values where not printed with surrounding quotes, causing an
> invalid json integer to be emitted
> 2) when bpftool struct_ops dump id <id>, the 2 dictionaries were not
> wrapped in a array, here also causing an invalid json payload to be
> emitted.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpftool: fix printing of pointer value
    https://git.kernel.org/bpf/bpf-next/c/90704b4be0b0
  - [bpf-next,2/2] bpftool: wrap struct_ops dump in an array
    https://git.kernel.org/bpf/bpf-next/c/6bd5e167af2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



