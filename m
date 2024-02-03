Return-Path: <bpf+bounces-21134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3A5848658
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 13:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5D7285B68
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 12:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3895D90B;
	Sat,  3 Feb 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2j66puC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9339856;
	Sat,  3 Feb 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706964626; cv=none; b=N595FbwkpVUsWwEpDmGfVsKn1IwH2icaDjKE5MFehOCq+AOcQKQdJCPicLZ0ZmrhU2xC6lsiHd8rLneqY1liRLBYhKSzlDYSGkd8dTG7uKgPyww/9pIOdr9nnTb/2m5hV4dbFzVA/larKgozs0AXSV8DppbKNB7VW9pYFJA2lAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706964626; c=relaxed/simple;
	bh=V8osyTHbakqrx/nF2ubNYtcubBg90PdpAbMa4oh+tZU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Katqv6EqNf7dxmGwbihotVH7OzuXafsoZ3JdS33AuBMPOK1doKpIsTMhJCG/LxWXoGcMdXQpvaC0qpkrT2EzUhLTICxThJPjPlCEes2k1+fFL00gmb+CNCf2P1d62s3nCgBcgZ2mQm5YwQMjmsoo+QxvDXHXi/swrBB+hmhK3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2j66puC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DD17C43390;
	Sat,  3 Feb 2024 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706964626;
	bh=V8osyTHbakqrx/nF2ubNYtcubBg90PdpAbMa4oh+tZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P2j66puCUHwBpd431+eT/xyUihHu9dCxRGXBlgryRS/VgCmvPQNBZOp82ZwgNrmWZ
	 ox46PbWBpiQ5PGC6SB9prC1RYqfFo9Jbo5yA40sr8e9T49quAHIIjexBCe7+Zu2WDR
	 tW9ZIdACvstLZc3HCXw6ZASAfYXT6/QR7X0R1+fG8kBQ3QnTVNrz8sE+DkxpXmdouP
	 e/WEWDGcoObO+By/ZK2sArUO2wwE7ASn1909KDcnqFB+sD6VJJ0Lu/mOeIhwD3vI17
	 s1U9e8imjs/PDI+rEtUKW0KOXt9GjKUNbc+ZTm59sbOiw3furFyEw8jGWDq9e3Cp4a
	 lfvFa5Ls2sJDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02E03C04E32;
	Sat,  3 Feb 2024 12:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tsnep: Fix mapping for zero copy XDP_TX action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170696462600.20224.14079985268876839637.git-patchwork-notify@kernel.org>
Date: Sat, 03 Feb 2024 12:50:26 +0000
References: <20240131201413.18805-1-gerhard@engleder-embedded.com>
In-Reply-To: <20240131201413.18805-1-gerhard@engleder-embedded.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 31 Jan 2024 21:14:13 +0100 you wrote:
> For XDP_TX action xdp_buff is converted to xdp_frame. The conversion is
> done by xdp_convert_buff_to_frame(). The memory type of the resulting
> xdp_frame depends on the memory type of the xdp_buff. For page pool
> based xdp_buff it produces xdp_frame with memory type
> MEM_TYPE_PAGE_POOL. For zero copy XSK pool based xdp_buff it produces
> xdp_frame with memory type MEM_TYPE_PAGE_ORDER0.
> 
> [...]

Here is the summary with links:
  - [net] tsnep: Fix mapping for zero copy XDP_TX action
    https://git.kernel.org/netdev/net/c/d7f5fb33cf77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



