Return-Path: <bpf+bounces-51093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1CDA30138
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 03:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4C83A5F98
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 02:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F961420DD;
	Tue, 11 Feb 2025 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSvOVYiY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E5214A629;
	Tue, 11 Feb 2025 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739239206; cv=none; b=fZN1tUI0NO+/YNJtp9Y49CKJatsaG4igGKQBv4hC2NBtUAS4tDXZ3DX9WlH5us3SrdLP3XqNTPpDx7MUCH6+hfBk58zNO7W4vt3aHGDVQRtAnKrtZ8DJLA3ymnqOZx1CMgW8IGWTuwgv7f4UkLLYve10ll1yO4sw9Od9op/f2j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739239206; c=relaxed/simple;
	bh=kFUJr5TD/M4NAgCQXUCTrLJ56MU+Zqi0WBhtlptFbD0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DezfutNKqOpbXQ0HqTn86i8lELNNqnzQxNRj1hQ4+SbOf4Y+0M3NwtrHAE6lkda+Z/Pfm45jNipePYROUexVWJ8EIjHld9wxvvRcV7zU2UH3GIujkcnHFzjgEkOxKii5zw8pB8hkGLimZ0nifboZ1IAI9V9FVXX3mhLm0bgrwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSvOVYiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC28C4CED1;
	Tue, 11 Feb 2025 02:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739239205;
	bh=kFUJr5TD/M4NAgCQXUCTrLJ56MU+Zqi0WBhtlptFbD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tSvOVYiYXQm8Hn9Y3tri5ZIKFUwf2TDB0mOBv/ajJiE9nRPTsd4sESh6IZ90NGJzT
	 2wehiDd0FjHr33vOKT/gax7foWX5K7NkS1LVHcCCUMwGxXGaVxJhYVd+1VGyZ9J56v
	 cpVlkvaVHME6kenmQ++ljPajjTd6gsdiAX6plLvdMK1gznI/oQmKaK2zMeLOFcF+Yh
	 FbPRft7BTKC8pVJ+B2dJUkn5Kqg2zoyko9oPZnbgXjuYRN3HT6pIHbueRk/2Cq+PU1
	 FAAAl4maHBO4JBAGmn6ljIBh370UZKd9X2YXYrfdDfXIw8DqWl51CYo0NNU0VIt4Wp
	 5QwVMOWHBmkhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71193380AA7A;
	Tue, 11 Feb 2025 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] xsk: the lost bits from Chapter III
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173923923427.3912925.6550641983549468638.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 02:00:34 +0000
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
In-Reply-To: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, jose.marchesi@oracle.com,
 toke@redhat.com, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 przemyslaw.kitszel@intel.com, jbaron@akamai.com, casey@schaufler-ca.com,
 nathan@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Feb 2025 19:26:25 +0100 you wrote:
> Before introducing libeth_xdp, we need to add a couple more generic
> helpers. Notably:
> 
> * 01: add generic loop unrolling hint helpers;
> * 04: add helper to get both xdp_desc's DMA address and metadata
>   pointer in one go, saving several cycles and hotpath object
>   code size in drivers (especially when unrolling).
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] unroll: add generic loop unroll helpers
    https://git.kernel.org/netdev/net-next/c/c6594d642717
  - [net-next,2/4] i40e: use generic unrolled_count() macro
    (no matching commit)
  - [net-next,3/4] ice: use generic unrolled_count() macro
    (no matching commit)
  - [net-next,4/4] xsk: add helper to get &xdp_desc's DMA and meta pointer in one go
    https://git.kernel.org/netdev/net-next/c/23d9324a27a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



