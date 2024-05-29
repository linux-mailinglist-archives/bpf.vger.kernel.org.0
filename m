Return-Path: <bpf+bounces-30812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC3F8D29EE
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 03:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0F21F27875
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 01:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E77F15ADB7;
	Wed, 29 May 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi4HT5Cb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F6C15ADAA
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945905; cv=none; b=KHbx8Lw9vxndWpo/plq70SXVkx3PLfpK9M7pv32KHJ+NGvFausnDP1RMMWVlD0oxqfZliwl0u7n3vXVudENqReB2tNmkJars1dIs2rNTduIDiGNKQG8/Vh1f0PGE19pfk3hX/G8bDNSvdIt8I+qa//S9QpqMT06PVtuB1VXmODc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945905; c=relaxed/simple;
	bh=ERK7oQENHn10oxQDSLcRRPZKJt6B4Pqm6TksXn65WPI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qhm31Whfz26wkPQT1AjUaublYohcQCPcS9lPHUOU2+ZGBDu5tKpAjvFhjizrgtKvybsDvPzK/oRiCqKqvBwEkaTSpSwDd9QxNGPhkf5ip8X06zvFDnNHv1LUWBOcwk/2PgxGA3ApDkSifeAooLgV0poNOkM7HCbOySypH44mywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi4HT5Cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29BEFC4AF09;
	Wed, 29 May 2024 01:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716945905;
	bh=ERK7oQENHn10oxQDSLcRRPZKJt6B4Pqm6TksXn65WPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pi4HT5CbTM3Gy4NuGIy7cArknjRsZYDKyVZZ9ect1Hi3jdkYogDdXChZFfwDEEGvt
	 xRz/W22sMjMQq82+udLXuQgd3w5dxOqcTd5lwv8215S/jnsvV+kQfnsik+KCWUTWNu
	 bETTgV+UnGwvSQIrou9Q+R9/80SxYCNzKbf3JAG6KeVu4kjyMAbF6YuGy5UxIt82k3
	 y13qF0R9SgLH8Lu97x8dAT7xCpIIuEBLepI68BIHb3FdbCR1qcLzPzF5x5/LgybTSm
	 VYp/h16ClobT5LxL40M4yz+cGmAWRk77cI6E0nr1tXv2wS5jg6QaVHVlraF7jfFj6q
	 lP4mSszei1TWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FD85C4361B;
	Wed, 29 May 2024 01:25:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: configure log verbosity with env variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171694590512.19217.9345846325768462816.git-patchwork-notify@kernel.org>
Date: Wed, 29 May 2024 01:25:05 +0000
References: <20240524131840.114289-1-yatsenko@meta.com>
In-Reply-To: <20240524131840.114289-1-yatsenko@meta.com>
To: None <"Mykyta Yatsenkomykyta.yatsenko5"@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 24 May 2024 14:18:40 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Configure logging verbosity by setting LIBBPF_LOG_LEVEL environment
> variable, which is applied only to default logger. Once user set their
> custom logging callback, it is up to them to handle filtering.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: configure log verbosity with env variable
    https://git.kernel.org/bpf/bpf-next/c/eb4e7726279a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



