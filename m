Return-Path: <bpf+bounces-29620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD0F8C39BB
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 02:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED5A1C20C61
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73580A927;
	Mon, 13 May 2024 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ens7D1TX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F126C2C9D
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715561427; cv=none; b=p33XFfqRS5fnsiExLs4gHoF9VM0BHwxV0cKn18A0HRAKYD/40Q8/VAiUPzasABd7pZm+Mh70xcgthtKgN6e8d8jw2Y6vV0HX9ZzPbaywrjc13u4sxP3wGCARlPqGnvnxM/Tnfw4Bo1sL9AnmucyAaoD1auc0fTyhTeiLwvsCw8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715561427; c=relaxed/simple;
	bh=fWbM6NpbMc5nssnr9ak0rmglq2bkOY/lOVBYrbjq2zk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YzBrwEvHx7BDbpEkB0uUKmjJmrGxGagoPJyIH5F7Clb6Q6nxv30Q4vmK0/QVaBZ7hga087ydslzM44AePG3GmedNANi09Vna5p0ARwjO4xGg5kIOKWgiSQkJjCFsJU/DL+i+oLK/CamTtj2ELI1HAS6iD7hnIGKM6x6EZHbllm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ens7D1TX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7321AC32782;
	Mon, 13 May 2024 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715561426;
	bh=fWbM6NpbMc5nssnr9ak0rmglq2bkOY/lOVBYrbjq2zk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ens7D1TXfwpLupvyh0jX9hKOB5mpcHuPFE5rS9L9CEDm3PxHzHEjXYiLibsS86bex
	 sjkdcRhUEukjtwx3J3NAWbW/eodElyFNk3qUdFSVoxrrD51/OSawhtZSPFTq6gAxzJ
	 QswXT21Qs0tp7b8YI91rVjANSOWaXnVAcUJ0NpSq314W3wTxzWUrzPXZkZhc/9Qdp8
	 5d8typySj60DhfrqFNgTqVLprteG1GA0PP67uVnmhOCnUYSLAVTb/FUZjeHhed2D3j
	 QaxngZpkE5SZ8s1BPESf7/LpFTUtfSxYD0pliPn1J9nzcFPoByij1mNHy3QOXMwwot
	 0jmiJdnmY2mZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 624A7C4339F;
	Mon, 13 May 2024 00:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next V2] bpf: make list_for_each_entry portable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171556142639.11565.1548701733164740115.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 00:50:26 +0000
References: <20240511212243.23477-1-jose.marchesi@oracle.com>
In-Reply-To: <20240511212243.23477-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com,
 alexei.starovoitov@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 11 May 2024 23:22:43 +0200 you wrote:
> [Changes from V1:
> - The __compat_break has been abandoned in favor of
>   a more readable can_loop macro that can be used anywhere, including
>   loop conditions.]
> 
> The macro list_for_each_entry is defined in bpf_arena_list.h as
> follows:
> 
> [...]

Here is the summary with links:
  - [bpf-next,V2] bpf: make list_for_each_entry portable
    https://git.kernel.org/bpf/bpf-next/c/ba39486d2c43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



