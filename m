Return-Path: <bpf+bounces-20150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7F5839D77
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 01:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9841C2256A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7F012E6C;
	Wed, 24 Jan 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiTKuD18"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E0D17F3
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706054426; cv=none; b=Ov6P/RT2PBf1Mz+mZquDXHUEKUAFI/XkH4RXSIemfP66MsgR4fZ4u+WOIxS2E/5G5kshB68X3XOWTm2VAIC6CGaX3gsS5e9Q7K2y6UpUzttCaL7cic+UNCTt3u835jCEjFqU75lIgT7v7609oU6jZrV57HiWn4Z2Gf1nSyKnAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706054426; c=relaxed/simple;
	bh=8vQpTv05zpU71v7d+ArnOyu3X44IV3DMMC5EW+ToBpk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KdbMZvVsaaxIvyG6KkHD3ivjc5Y5KP3nqE2+lWNSMaXMzEpXrcjBOHX1YSn+dlwIwH3BepQSdn5WL+2d2pRy155CAnwwCHlTxJxi9P6aLtwZqp9uNxa+UpolCiZsQc6bQQp3Pp1Ex6nEKfUGli2WPEOaET8voKt8ZnSGkkOA4uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiTKuD18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D421C43394;
	Wed, 24 Jan 2024 00:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706054426;
	bh=8vQpTv05zpU71v7d+ArnOyu3X44IV3DMMC5EW+ToBpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CiTKuD18rObwGGxbiynzUIRngmqfC4slrab5mdtLim5xnUhzwa2qO5C6g79hqgbz1
	 VQh9A77s8UmL817RXvP6RIEQs3RNF2vam41QvdDDLyabw44kJwIdD9H+IFa3WnfWtp
	 7+W/23rwV2Y15VH2b/pnrjvoKRKDxo6dWekDPYje5veqpD67EM3Wx9t4Yz0ohrw72J
	 vBTZQp8uj18S2yjARPnjcDGxtt8H9k0Wgec5ZPQH146x/q+6z3SdV0k7qNaU7D1kuS
	 qKavKs9VchQpA9uNnHROXT6f5q8CCwFmn5Gl0NYvHFvZM6E85LhFIH3zQxQv4b+2Dz
	 vXnJYYPHY8l9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A3BDDFF768;
	Wed, 24 Jan 2024 00:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix constraint in test_tcpbpf_kern.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170605442603.2408.3348981951229978079.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 00:00:26 +0000
References: <20240123205624.14746-1-jose.marchesi@oracle.com>
In-Reply-To: <20240123205624.14746-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, yhs@meta.com, eddyz87@gmail.com,
 david.faust@oracle.com, cupertino.miranda@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Jan 2024 21:56:24 +0100 you wrote:
> GCC emits a warning:
> 
>   progs/test_tcpbpf_kern.c:60:9: error: ‘op’ is used uninitialized [-Werror=uninitialized]
> 
> when an uninialized op is used iwth a "+r" constraint.  The + modifier
> means a read-write operand, but that operand in the selftest is just
> written to.
> 
> [...]

Here is the summary with links:
  - bpf: fix constraint in test_tcpbpf_kern.c
    https://git.kernel.org/bpf/bpf-next/c/756e34da5380

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



