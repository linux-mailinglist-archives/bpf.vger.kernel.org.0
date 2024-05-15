Return-Path: <bpf+bounces-29786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F818C6B1B
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 18:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2751B1F2438F
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1655F5FEF2;
	Wed, 15 May 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgFANMW5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8E481A6
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792292; cv=none; b=a38QQnrUDqHIQLpCHGoq1OkX3NCYQ85sp2ukTz2LLCHBfOFhK3SarR2YTgtlivN5PSX6DKP3fUf9BbHXvHXYsVU4WrKtqqlnwJ5hlcIFm6quN58lj8vymapiXT1qR12EBfIEjmWntqHHnYmyPQhFjyUjGhku/ZeSu45ZhOsznBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792292; c=relaxed/simple;
	bh=8cFcFgctI49ZS/FCPnqKkYk0pfVCMPykUiHa4+xRIyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UqgASOvFjojOZQc+oEtbi9GgHkw4BWVd5d8aAzjXWBd8//BWoTueciXWP0GBv6nMJYd53WOnD6FjiGqcVG0dNdasl2lC1JtLDjWCNlVh3/ebQjSmZvgJIAd4WoyEVWKGjnjV/xo0z9FpUJU6QtTHT88WQzDUb0kMZBao1lN327A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgFANMW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C113C32789;
	Wed, 15 May 2024 16:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715792292;
	bh=8cFcFgctI49ZS/FCPnqKkYk0pfVCMPykUiHa4+xRIyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CgFANMW5UMm98WxO3gVVhpBsid04vKBLB3dWTXuIf/AOa2gZAvXImLOQAHj4e2fNv
	 5ppolBlPWAmg7bXyKEsYyuTWzQvOOW1+GrUpSM8+QYBm7MQ0cxke1ZbUl3I9JAmDbt
	 OLdnaTs7IFJN9EyWUx7R4IfzPUNoQbvhbxxHfmPU4C+G5QgM53dbLlThGIYYCNhQ56
	 Xr0Fold6gEXRI1oZFe70SGlj5+P0XKRsfDtkTxSUY2Pdl/lHmwR8++Lnm+q8wuMj1E
	 lYmig9XEedNiW8fjnUjPK96pmvhmvKCuinkqDCWvC9rR6PguFWtstv6hUyxuLBbndu
	 S3OkeFbWQ3ZAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D9B9C43336;
	Wed, 15 May 2024 16:58:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] MAINTAINERS: Update ARM64 BPF JIT maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171579229211.15564.12451312946756347488.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 16:58:12 +0000
References: <20240514183914.27737-1-puranjay@kernel.org>
In-Reply-To: <20240514183914.27737-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, bpf@vger.kernel.org, zlim.lnx@gmail.com,
 puranjay12@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 14 May 2024 18:39:14 +0000 you wrote:
> Zi Shen Lim is not actively doing kernel development and has decided to
> tranfer the responsibility of maintaining the JIT to me.
> 
> Add myself as the maintainer for BPF JIT for ARM64 and remove Zi Shen
> Lim.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Zi Shen Lim <zlim.lnx@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf] MAINTAINERS: Update ARM64 BPF JIT maintainer
    https://git.kernel.org/bpf/bpf/c/325423cafc12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



