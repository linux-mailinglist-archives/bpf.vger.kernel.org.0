Return-Path: <bpf+bounces-27051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CB58A84BF
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 15:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D3AB25149
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 13:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6B113F446;
	Wed, 17 Apr 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVksHFmF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8310813BAFB;
	Wed, 17 Apr 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360645; cv=none; b=azbF35Z+UW7UW7NHtPRL5lDE4KmQ6vTIduVtyohaZh+stRADJ9yoHrNPcu/gG2UbpSE+qisOjl0g/xLCLYNHLsCQNzryatlIuI9bLMQYVmnBlRZ4mRL1o/25cVPPvWd3CnpQMYAUlP+wHAfheb+QUve3DfNihhLpBnemsY8IHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360645; c=relaxed/simple;
	bh=Y/8Mle/7dBOg11kYehQBVxIpMEpuar0cntBmB9zsbjw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NS43ijxwnQeuaGOGlNSaJ9PHa+w0phz4Kz2GQp81m+zD/wamLbs5HOWtDCEzEKTEndUQ3SHsDNOynnefBQ5a5eCMyHB2x0YGIgv84w4I0sVUgb2V4VgesWDW8l4nqdE+XN0swa9XAoqRmi6RpR+jrAfcG7bUj938tzN4T+1hEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVksHFmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01FD8C32783;
	Wed, 17 Apr 2024 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713360645;
	bh=Y/8Mle/7dBOg11kYehQBVxIpMEpuar0cntBmB9zsbjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nVksHFmFnhW+dxNFh2rq0JJ6TbRIUTvXeQFWWr38XTy8kAd5w7KLxwzFxHBCvhboZ
	 9oucNBw8fGqgf27s1Ce3ulL+fIO6xXmhJ6D+V5SPnRc3sgdIU0eSX40p4N/0uwMFTf
	 XuLrLlUCFRcUqV7suFRKl0lID4YWIa9x6/t7iDOn6vJFMJ1dQf6OxGXcTq5XvT+pfB
	 eCZGaJR6I83rGJW2Cc8bG/Vh9tVJed+z2aUr0qtxpdHgTFO+xrnPiZhomhf+C9wOHF
	 N8IC2OmEIOl2pfPM+6+CbNBAZJJdE99FXz8vwABsTUaRR0MWsznBhRusIBFejl6GWv
	 E/LMgY4ljwtvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CF22C54BB1;
	Wed, 17 Apr 2024 13:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] libbpf: fixes for character arrays dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171336064453.13200.11475290179451492010.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 13:30:44 +0000
References: <20240413211258.134421-1-qde@naccy.de>
In-Reply-To: <20240413211258.134421-1-qde@naccy.de>
To: Quentin Deslandes <qde@naccy.de>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 13 Apr 2024 23:12:56 +0200 you wrote:
> Patch #1 fixes an issue where character arrays in dumps would
> have their last bracket misaligned if a '\0' was found in the
> array.
> 
> Patch #2 fixes an issue where only the first character array
> containing '\0' would be printed, the other ones would be
> dumped as empty.
> 
> [...]

Here is the summary with links:
  - [1/2] libbpf: fix misaligned array closing bracket
    https://git.kernel.org/bpf/bpf-next/c/9213e52970a5
  - [2/2] libbpf: fix dump of subsequent char arrays
    https://git.kernel.org/bpf/bpf-next/c/e739e01d8df8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



