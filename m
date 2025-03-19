Return-Path: <bpf+bounces-54415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC77A69BB8
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 23:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420769830B1
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D68221F1B;
	Wed, 19 Mar 2025 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXbwnG6p"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE0221D9F;
	Wed, 19 Mar 2025 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421597; cv=none; b=rlKC6njns6CCuqIWu+eb/x2Mmg6Po6CQhab/p5QY+MPCt8KBpS15kJoPesX47MMrZt/flV+owKXmpLyyq7+CcoE+X0nOJmC6eAL5qj9ulkY5JfuK1/KhqW5ZxWox5lUXf9Rud1MQFtjWWtkLp1OnGso7JgndCHFOnYtxmRdiwI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421597; c=relaxed/simple;
	bh=Kh+LiaNhD5S4fdAxEqLEVOhdzZQHMP+KOw5UY2eEKX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IFSd/rTcjG07E5imFZ52p9vl3OnP87E2ymjTmWe0GAoGpeNeWSu5ABbrANDZuUdCTmPn6/FOXa9wzPDI6qULqz/NPZTuN+XIzk1VKlhxJoVEgVeC26Q5LhmGwFWSVN9uyDR4zSIJ6pI+ZpWNFI7nCjYKMpMgYoLpmcb8HiUGkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXbwnG6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B9AC4CEE4;
	Wed, 19 Mar 2025 21:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742421597;
	bh=Kh+LiaNhD5S4fdAxEqLEVOhdzZQHMP+KOw5UY2eEKX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HXbwnG6pPAnZve0XiygPaKa5GK/7LAlI5d/83iPOG9s9Z5jG9xOi3WL/QDoOeHQ6A
	 ZBRWbA+YNyUS6qFZoC+CNVIBr+8XRf/doRqklNV7+xBh372vCavvKwUFynyph+ecqw
	 T795MXFoapt1uO/P6XqR9Znftyc0IdsK3IEQbFCB1rM/BusGElMeM79069ohhMvbyO
	 U8x9UYIStk6KwzMs+0OaAIlNhMEO0d5a0ACvHR1dNlEjsssBt2nMQY+vZxGyY0yg3v
	 OctvQG+5Mmc8HWVfb3yLdGx0Bnmri47Gbgaivonx/ojggboCIi30cq8A3ESa/xQt/N
	 Xxw/ysUDLvSJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD843806654;
	Wed, 19 Mar 2025 22:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xsk: fix an integer overflow in
 xp_create_and_assign_umem()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174242163283.1209542.11030914618226049895.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 22:00:32 +0000
References: <20250313085007.3116044-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20250313085007.3116044-1-Ilia.Gavrilov@infotecs.ru>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Mar 2025 08:50:08 +0000 you wrote:
> Since the i and pool->chunk_size variables are of type 'u32',
> their product can wrap around and then be cast to 'u64'.
> This can lead to two different XDP buffers pointing to the same
> memory area.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> [...]

Here is the summary with links:
  - [net] xsk: fix an integer overflow in xp_create_and_assign_umem()
    https://git.kernel.org/netdev/net/c/559847f56769

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



