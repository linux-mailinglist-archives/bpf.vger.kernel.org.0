Return-Path: <bpf+bounces-46701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2579A9EE4CD
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 12:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4D91886B93
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBC62116FF;
	Thu, 12 Dec 2024 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4aGFML4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9E1EC4D2;
	Thu, 12 Dec 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001815; cv=none; b=qpWX8kb3TIe1kHzcwp5uK32D3HpKdn+rdYTKKKRwbH/UibKUaKmO9iOiHYNcHDHC8uSHEmM6k2PcTlAaWfvkHqibiQdTQYR4Kzc3G5PuU712i2Y3Mzvz0I8E9zK6ZMg3Z10hPtxYwhB0JheaZNptVmhlrwC/U670fRWpTr9vQNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001815; c=relaxed/simple;
	bh=gtxdskiu8gNiQX/5ltt2anzVwBhDWQNH8ZQ52LohiyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C7HFL8nm+CKoBywapoPtFBh7RBFBW0PrdckJlPZA8+U6MFZQDaNDwGonAYWyIsj8ScJsOdUse/GptrnAxAuRRD6iSaA2s+tqC8qyiLn0x2L+IoEG4AXcM3ri68BRB/B/BondBPzu86C09sN6BaDyzaYg5Ocz576dRFbaoSfiayA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4aGFML4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D3FC4CED1;
	Thu, 12 Dec 2024 11:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734001814;
	bh=gtxdskiu8gNiQX/5ltt2anzVwBhDWQNH8ZQ52LohiyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A4aGFML4IpGJ2KUcUVfLc9v2eikhxntUBD+NN/eqp+N4ZZnf4mdHJKqMOQOrIjnMZ
	 Jhdp2jxh61YAkZZWDZSfHNjTkhukMYU2tlF1tr5wtDiDB/EU+u1JGVf1xFmPrzMQJ7
	 U1eMD0NxTKaAJHRiQ+OFwquw3u1tQcd1HEr/LmkQOkib0O2kBrjvOJABpipjYzVVC7
	 kcEbzLCHKKpIyS9wX8kYgmSqxXxR4tsMYPOf/afhlStkETCPVItGSjTkrsufKpZ3Us
	 ewYtAuFRyMV9Do6l7lvNgtab8b3zAen0pSMwY9PMrJ4keoIC6UFPDEWoNdmkN4VBQi
	 nDV3tIuAN/HNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE45380A959;
	Thu, 12 Dec 2024 11:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/5] net, team, bonding: Add netdev_base_features helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173400183061.2260843.17997043882754533969.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 11:10:30 +0000
References: <20241210141245.327886-1-daniel@iogearbox.net>
In-Reply-To: <20241210141245.327886-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, mkubecek@suse.cz,
 razor@blackwall.org, idosch@idosch.org, jiri@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 10 Dec 2024 15:12:41 +0100 you wrote:
> Both bonding and team driver have logic to derive the base feature
> flags before iterating over their slave devices to refine the set
> via netdev_increment_features().
> 
> Add a small helper netdev_base_features() so this can be reused
> instead of having it open-coded multiple times.
> 
> [...]

Here is the summary with links:
  - [net,1/5] net, team, bonding: Add netdev_base_features helper
    https://git.kernel.org/netdev/net/c/d2516c3a5370
  - [net,2/5] bonding: Fix initial {vlan,mpls}_feature set in bond_compute_features
    https://git.kernel.org/netdev/net/c/d064ea7fe2a2
  - [net,3/5] bonding: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
    https://git.kernel.org/netdev/net/c/77b11c8bf3a2
  - [net,4/5] team: Fix initial vlan_feature set in __team_compute_features
    https://git.kernel.org/netdev/net/c/396699ac2cb1
  - [net,5/5] team: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
    https://git.kernel.org/netdev/net/c/98712844589e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



