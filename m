Return-Path: <bpf+bounces-52290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E10A411CF
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 22:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFCA17372A
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 21:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE8E23A99A;
	Sun, 23 Feb 2025 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umNE1yQ7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B36C18C039
	for <bpf@vger.kernel.org>; Sun, 23 Feb 2025 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740344999; cv=none; b=AwHqD3EFO4DIEuSV0+6jiL4IgwCwHy4pi+gnIQaxUD1Q1+7C2j8cyvEJYoTZzc/Zpn+FnHKxV0DJBxyoAWF0sCYFlQsGIMToGxXZmwRUw98gx3h1wv/O59iOAOQtvhtT9Ekb0NYnXpDOrzKUUTiLXXs+KQ9FLHgBFAC3bbHFxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740344999; c=relaxed/simple;
	bh=K2aECDu1+cHkbJE5hvi2aTNrrPz0HTYYQTKifUkT5PI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wj+k4oFJ4Lpj+dcprLa4dZ6kuwy7ZNAyFEi9EsWBjDtdOKbhRQb2csGEp7uCYJ7V3kaotCudWT/Q3/6pzsV7135EhnwS6E3EhEGwKM09GkCindBEOMsTrLvHDn8ymkUmIItrz/GmU+2AJoEMm5ENa5XQVhXiHeRCAzutUV/Ao8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umNE1yQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC44C4CEDD;
	Sun, 23 Feb 2025 21:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740344999;
	bh=K2aECDu1+cHkbJE5hvi2aTNrrPz0HTYYQTKifUkT5PI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=umNE1yQ73Wujw95WrhQR12ywb9THProx4kS8tjgzEZE1h0tQNO6IBG9kJf6Vttu8g
	 h0sT5l0lEz+TLFy7z5Np8FCFOh0qoi0n/lo44ny346NWsGw1QuEiI12Mj17Rggm7Tm
	 DsSPDQL70yuJgl3PiecdC7TEpVWCbfRuevKyf4mHsINPJ1htDdUAUCbu3IpP2cKdqB
	 5FvAIG+I4WVKxAMRbtn0IRypE3ZaS+mxmwGL+Rtw7nhPqqHIkO99O3yP7rDV/brUPP
	 2qWx6I/Cc6Wc72UWdlXLB3H/VJbDupuCPPM0zTMd/QDAyCMNawS3j1B0ni6w1MDq4I
	 pH4OZh+clgcyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EAE380AAF9;
	Sun, 23 Feb 2025 21:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: arm64: Silent "UBSAN: negation-overflow"
 warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174034503027.2621534.7543015920062890065.git-patchwork-notify@kernel.org>
Date: Sun, 23 Feb 2025 21:10:30 +0000
References: <20250218080240.2431257-1-song@kernel.org>
In-Reply-To: <20250218080240.2431257-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
 puranjay@kernel.org, xukuohai@huaweicloud.com, kernel-team@meta.com,
 leitao@debian.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 18 Feb 2025 00:02:40 -0800 you wrote:
> With UBSAN, test_bpf.ko triggers warnings like:
> 
> UBSAN: negation-overflow in arch/arm64/net/bpf_jit_comp.c:1333:28
> negation of -2147483648 cannot be represented in type 's32' (aka 'int'):
> 
> Silent these warnings by casting imm to u32 first.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: arm64: Silent "UBSAN: negation-overflow" warning
    https://git.kernel.org/bpf/bpf-next/c/239860828f86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



