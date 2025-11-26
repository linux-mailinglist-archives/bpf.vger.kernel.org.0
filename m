Return-Path: <bpf+bounces-75538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C31C8800B
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 05:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC9CE34D906
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 04:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457D30BBB7;
	Wed, 26 Nov 2025 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uul8nKHF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967A8F48;
	Wed, 26 Nov 2025 04:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764129644; cv=none; b=u26snCiKe5QjIFIjRXrD3WopDjtiYEDLFFavcDuV0WEcseYnDjTEg+8f0Y8RiYhGgB+wMRZgbgnUp75tgr323Wsd/7xVZgvLqCPJPgWqwPq4kuTgVNzyQpR2455rOduZQ+tw/fpz2GVvGVCIux7Cksh6HlqkBR0x4WLR/dwyHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764129644; c=relaxed/simple;
	bh=+VwrPYt8E4+oQyRN9Ap2xEOh0Zp5Qg4o7SMD7OuzBx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BOyc4ek7geeEopurXmSEZWcvxhLlar4Rj6zbK27SMwJL9X63HZKSg4rSNIj0AGGWuf7G5qKIvGyat5hAHjNTSHqWkVn31GkJhPoFjnmh1Rfxw7/4iy3NVIra/y/q7dizlbOMqG3WvWiLXP4LnoghpSbzimgHvl1c0qn9GDj4H+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uul8nKHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5193FC113D0;
	Wed, 26 Nov 2025 04:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764129644;
	bh=+VwrPYt8E4+oQyRN9Ap2xEOh0Zp5Qg4o7SMD7OuzBx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uul8nKHFmk9ORz6ECmNhnE1UeKOFql489VTQhP0naxYx0FE+x5ec2d19NxMjW9R7m
	 tUdLXz9D72haroALxM4XITQbPKnDT/aAyPHzrITZmradQUO/alsZXgVGnWLKUVIq3m
	 qQ2Q19PuXkcU1xyhnyoRdkelIwEqBTD0DpctXXT/vs097U5XWBzHP9+o15uaHJea8W
	 c0rQjOMo7crXsPujEuoYvjrQsdmI/UKXIh3HyX6skvtaicy17afSDG8dZI+90zanZL
	 c+ot5Pq0ajB3w31/kBsCSjNFYDvmAoFk5LRfPOGdON32Rubs0FnG9z20/S7ohNILAH
	 GSI+a92wmjIyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF78380AA73;
	Wed, 26 Nov 2025 04:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] xsk: avoid data corruption on cq descriptor number
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412960651.1513924.4064352345159631206.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 04:00:06 +0000
References: <20251124171409.3845-1-fmancera@suse.de>
In-Reply-To: <20251124171409.3845-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, csmate@nop.hu, kerneljasonxing@gmail.com,
 maciej.fijalkowski@intel.com, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sdf@fomichev.me, hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 john.fastabend@gmail.com, magnus.karlsson@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 18:14:09 +0100 you wrote:
> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), the descriptor number is stored in skb control block and
> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> pool's completion queue.
> 
> skb control block shouldn't be used for this purpose as after transmit
> xsk doesn't have control over it and other subsystems could use it. This
> leads to the following kernel panic due to a NULL pointer dereference.
> 
> [...]

Here is the summary with links:
  - [net,v6] xsk: avoid data corruption on cq descriptor number
    https://git.kernel.org/netdev/net/c/0ebc27a4c67d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



