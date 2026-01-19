Return-Path: <bpf+bounces-79458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 289EED3ABAA
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 15:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5182A300D817
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB0F37F0FE;
	Mon, 19 Jan 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJsbq1oF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C737C0FF;
	Mon, 19 Jan 2026 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832528; cv=none; b=pAzwLi5VJNwS9/njPbz5GHCcECsGxvfqPXccn1T/eD8q2PNcGuq9UMjCYy9z5cAEtD6DLFzNsULeyJWgr6++lvYtd9bcF0BtpImILAw6zQTw6quCKu04Ka3U8WPvoP9yOmMwO4H580+fRT4C7ipyIT4dHPzNBGtDNfkNL4PkiuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832528; c=relaxed/simple;
	bh=rnm11vEkZoatATxXUNC0xqLYYvPzCEp14XXqJDZ9plI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kRMlDHXX/kyUKFH4eR8JO0OMJdkua/IHv496cNRp3D46Y8ve+I3ibh/DrxdZcFn541N7uHNfI2NEVZrEDpLCszgASA8eqSTPOLP/zcRj8M2xPlEXo8XYz51K9/ix3/tuxx01LI9Hu9PvSA5uMHNzf1PB7UtGYsAtJQujQpz2bXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJsbq1oF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35778C19424;
	Mon, 19 Jan 2026 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832527;
	bh=rnm11vEkZoatATxXUNC0xqLYYvPzCEp14XXqJDZ9plI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WJsbq1oFHSmts2BMFJ5gKikImABZsy0wAlg5cR1qHjcKVJqrMRSxSWAmBGOgj+alk
	 8I52v6RplnLA8KMy33CNuv85csSt8TDvUqkqJQgR4cgu6ydzS8jatIuPRHlPqPKQyl
	 uIg5S1GWZv7aEwHuJJAqmW4byz4EEDA+qUx5KQztPYsGm1Pqu+kmgQ0uAvdI/087Kb
	 Dol11OW4XP+d4oR4em8NZhrK7epqwna5jQ1+oVG4eM8lfyRWGBTgWzgLGpBvqdS9Ri
	 4d3HDp4XArbX/M5EtsgJX+18gFl8U+CmpJUj6cjFdm5eOktDQM5JPEbV8nDAdAgdYa
	 15aBvyeLa3lZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C2933A55FAF;
	Mon, 19 Jan 2026 14:18:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] veth: fix data race in veth_get_ethtool_stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883231703.1426077.2738408462855147102.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:18:37 +0000
References: <20260114122450.227982-1-mmyangfl@gmail.com>
In-Reply-To: <20260114122450.227982-1-mmyangfl@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jan 2026 20:24:45 +0800 you wrote:
> In veth_get_ethtool_stats(), some statistics protected by
> u64_stats_sync, are read and accumulated in ignorance of possible
> u64_stats_fetch_retry() events. These statistics, peer_tq_xdp_xmit and
> peer_tq_xdp_xmit_err, are already accumulated by veth_xdp_xmit(). Fix
> this by reading them into a temporary buffer first.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] veth: fix data race in veth_get_ethtool_stats
    https://git.kernel.org/netdev/net/c/b47adaab8b3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



