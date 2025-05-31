Return-Path: <bpf+bounces-59402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8582DAC9950
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 07:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3381BA411B
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 05:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DCC28A1EA;
	Sat, 31 May 2025 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTZutv4T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57225475E;
	Sat, 31 May 2025 05:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748668212; cv=none; b=Dgt0QWNQZCfmgLcP7VMOECdsYpOq+e/xUDA4+GKF7QkR+CfH0vViFTltDRJPNvXEoZaGYpa5Rn4EVJ9NjxLjm7bfIR0IbygJ7s2I/IP5gaovnb6MHoH2uNpdX7+t2VKRIxFeQaxDxsZ35mYsApq+Dt9g1g0VHZnxU50uAq3sjqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748668212; c=relaxed/simple;
	bh=PJgVm3ToSC/rDZaBkrfA/rpfuG5OxUdSrBHWlFxA0EA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ho8uHpNp8wbPvBSs6BkSQuIbpjunOpnrx+wib4em12YGSWVcCPadRMxv/UCoSNedC08B50DxBmPdggW+lOSP4FpaQGCyR1qS4djwbeHShb6CDp21l12NIt76u4hC4as4mVWvjUQJMUBszgRWYTwwMSwop42wA88HQr4BnJ7H/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTZutv4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC2BC4CEEE;
	Sat, 31 May 2025 05:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748668212;
	bh=PJgVm3ToSC/rDZaBkrfA/rpfuG5OxUdSrBHWlFxA0EA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eTZutv4Ttw9DRkgC3h8N+v7tedHyw59Vp2Cpw9aNFnctwCkrvzbzzRyppoPr1BNfC
	 IM9UOBiXoSs9qhvGbmYcdCVOJAKOsOShqeRNtiV18dR23FH+jYybFaXBCX9rZrO6O2
	 2oAd5cckiGRlUerk7n3FTwd6/nU4+n5/baYHuvdg/gv11A0wFXJLHS23KAH+PL4/A1
	 D3FHL9+V1KCVCNcCKQbihA1FFCf+ALKyrCyb7XbhBCxORuCWQKyIWw+TrvMQpzuCOx
	 P05JTRDjWZUmKdfvyaWt12Mz7ag4GlKUqTGYvMo0FBmmJAYzn0K1yV1EHYqFjeoMWG
	 OEWviN5f8JT7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFBB39F1DF3;
	Sat, 31 May 2025 05:10:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: Fix inet_proto_csum_replace_by_diff for
 IPv6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174866824551.44670.1820707650191720178.git-patchwork-notify@kernel.org>
Date: Sat, 31 May 2025 05:10:45 +0000
References: <cover.1748509484.git.paul.chaignon@gmail.com>
In-Reply-To: <cover.1748509484.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 tom@herbertland.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 May 2025 12:27:40 +0200 you wrote:
> This patchset fixes a bug that causes skb->csum to hold an incorrect
> value when calling inet_proto_csum_replace_by_diff for an IPv6 packet
> in CHECKSUM_COMPLETE state. This bug affects BPF helper
> bpf_l4_csum_replace and IPv6 ILA in adj-transport mode.
> 
> In those cases, inet_proto_csum_replace_by_diff updates the L4 checksum
> field after an IPv6 address change. These two changes cancel each other
> in terms of checksum, so skb->csum shouldn't be updated.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: Fix checksum update for ILA adj-transport
    https://git.kernel.org/netdev/net/c/6043b794c766
  - [net,v3,2/2] bpf: Fix L4 csum update on IPv6 in CHECKSUM_COMPLETE
    https://git.kernel.org/netdev/net/c/ead7f9b8de65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



