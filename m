Return-Path: <bpf+bounces-66538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C7B35E8D
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 13:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD0C561F95
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE00C2FDC38;
	Tue, 26 Aug 2025 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjoQFbie"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF612FAC1C;
	Tue, 26 Aug 2025 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208998; cv=none; b=OP/g1pcq7Qx6katDxAku0AmXa0SFn5eVoLOGSAsQv+0sjNAohOUQ8zhHCLU0J8PoEouZ6Cf6Nrl9GrUUGttvP1M+NOwR61C9db1XrfAuW31bLPNA/Xo37J4kPzln3IGjNrBYOaDOIwu1zcAxWRprWlvmBTXDzEoi3WMWnCOheM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208998; c=relaxed/simple;
	bh=iqEvPuEn5CseOfyZ7+nhPdnW7nVvE8bG8SADLndGH88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JbKRdTBYVOLzIswYLf/j7mwi3j18Hc4lqkXb0Xx1c1VNIryWrs5HxbJXjBOEh9H06cZ+My8ljKH2SX/cFF7rDU/JyND2VaznXmjW/fnZRYlQClm4jGvC8IIUnI7UwR5SOo4wwYV7PD+tMxCZJfLi/3NFepYVArB4D1t5bLMhHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjoQFbie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A8AC113CF;
	Tue, 26 Aug 2025 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756208997;
	bh=iqEvPuEn5CseOfyZ7+nhPdnW7nVvE8bG8SADLndGH88=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GjoQFbieHESVx+vtdeNxzHmnij+JXdfag11b1/l9GxdgyRxDYJdd+6j+3SNb90yTP
	 daUMkIqFXtH6EVLBUKBLtBlIDSX/a1bIl/tPnTmdCeYMMcyLQVOEZR2yWE/LFmCWqD
	 inuga2skpZS/Nr5MoqG3fPv3OJbBfX+dg0av+zlI/dd21E6Tc34SspY13IxcKTjksA
	 3Afh1Ci82T3+kypNahzdrWk5z0Hq/DHJT7qHGsmus8S9RX3d0vesnlKINoOQPVzvI1
	 F6OyHbV13mO80VdxqIF05vzli4hHFrzIEUuNwFgdHiH/oOPcqH/rNJ1FofSXv1UXMY
	 Nxkozs+1XbaHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD2D383BF70;
	Tue, 26 Aug 2025 11:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove entries from config.{arch}
 already present in config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175620900576.4140049.11191385719478969794.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 11:50:05 +0000
References: <20250826065057.11415-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250826065057.11415-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 26 Aug 2025 14:50:57 +0800 you wrote:
> `config.{arch}` had entries already present in `config`.
> 
> When generating the config used by vmtest, concatenate the `config` file
> with the `config.{arch}` one, making those entries duplicated, so remove
> those duplications.
> 
> Use the following command to get the differences:
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Remove entries from config.{arch} already present in config
    https://git.kernel.org/bpf/bpf-next/c/d0f27ff27c04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



