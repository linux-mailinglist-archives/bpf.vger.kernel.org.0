Return-Path: <bpf+bounces-65161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2575B1CF54
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 01:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1351816C00E
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 23:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED9926B0B3;
	Wed,  6 Aug 2025 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggQoHQLV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8153223301;
	Wed,  6 Aug 2025 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522397; cv=none; b=fRjAJy/9JUYWH7941FoK6DIv02XSEbB3s8t8giCuCTl1vgBrEsQDjbmDTV9MLjNRDZfOEp2yaKUqIWb/J2a75K26QtHYyyqdA2ybNNQboBGypbYPTRSiFZJCAKq09BGT9hv3UsfFeC2ZG2Cuc/lIDI4lm03kwcyUAA4CN6gmfqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522397; c=relaxed/simple;
	bh=iVDwBBtRqvwE1jbW801y24V6/5gV/eTvg/6Zo55SnS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fn1/U9WW9G7U7fV1rahBsVIr7NdmQpbB7xjAFLhXaceGPqlIU3haHeJ8gVckqiHcPioTKC2saOQdXmvRO6XVhsXR86Hyimf5msMItI7X/IIzgX8YKwkRUiieVmG6q1S7XXmrTHcOYROB1i/m93rQCupr9iJijpnB35BGk8n7MS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggQoHQLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43286C4CEE7;
	Wed,  6 Aug 2025 23:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754522397;
	bh=iVDwBBtRqvwE1jbW801y24V6/5gV/eTvg/6Zo55SnS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ggQoHQLVVASjJZBVv4DZOdk/P06K2bJwCrUufQtHIPT4qRrN4tPSl//Z7ZkNe9wDE
	 KgH+D4jN6QfT0V/U4xGDZAFi1VdcQO3VJROKpEeW6sfBLeFPj54KqdHS6WEzgZSjgl
	 TzGb+Z2vHmPPxUc4/eeeTj36+lPEtn7GP3nhyaVMGwPwuS0LBhPgX5de7rBUWVJjlP
	 /qU3waR0PSC14s3qa3wrGTXaA71/jS0c6p9E1WfXk8iovPh9t5T2IqhteoLdGdxzSd
	 PAAJHnCp+WZEugDoH5lUSBztrdQqxcTFX6Ec3XM8ZZi2/V+Lvovl5hI18GV3h2/zKb
	 3WHwjLigCq02g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B85383BF63;
	Wed,  6 Aug 2025 23:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] Allow struct_ops to create map id to
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175452241100.2973132.16950481472519463981.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 23:20:11 +0000
References: <20250806162540.681679-1-ameryhung@gmail.com>
In-Reply-To: <20250806162540.681679-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  6 Aug 2025 09:25:37 -0700 you wrote:
> v1 -> v2
>     Add bpf_struct_ops_id() instead of using bpf_struct_ops_get()
> 
> Hi,
> 
> This patchset allows struct_ops implementors to get map id from kdata in
> reg(), unreg() and update() so that they create an id to struct_ops
> instance mapping. This in turn allows struct_ops kfuncs to refer to the
> calling instance without passing a pointer to the struct_ops. The selftest
> provides an end-to-end example.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: Allow struct_ops to get map id by kdata
    https://git.kernel.org/bpf/bpf-next/c/d87a513d0937
  - [bpf-next,v2,2/3] selftests/bpf: Add multi_st_ops that supports multiple instances
    https://git.kernel.org/bpf/bpf-next/c/eeb52b6279cf
  - [bpf-next,v2,3/3] selftests/bpf: Test multi_st_ops and calling kfuncs from different programs
    https://git.kernel.org/bpf/bpf-next/c/ba7000f1c360

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



