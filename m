Return-Path: <bpf+bounces-20319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9854983C08F
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 12:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E06298435
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 11:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D056450A9A;
	Thu, 25 Jan 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDcEa5HG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583603D97F;
	Thu, 25 Jan 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181027; cv=none; b=LAEENoODNJqAp5ma8bzyaRfkUWPDwB5iQ4UKhHVLVusUTYxWnAIIuEgH7ENCI08JAmg/Dwd1mNmoCI7a+AXLWWCL2mOQGkmoFzf0XVAfwVXxkV3S5Mi7WsfoMjE6bmIiKwf4Cix++XFvNxb6Jm+0LrYgYFDN6b4TPZQy32atOGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181027; c=relaxed/simple;
	bh=FU1l9ZzyEdEuQNKjbo0qAjBu5YIHHAdY5D5LVXqoKs4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LjxVtvZI1T9lrPGmbgWCZAB775Z0teopMtIdR8GEE56D2Jd2aTI+cSkVUpssNt65Q5sgMauB7/0IOQYJXyu6fPe+01z32BAHyKOS0zherrrVrW0ig0vNAnXQoddfQ4xhE2qpI00qHF45DPW8k9N2SLvN7bec7FBvsbUKMfm12Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDcEa5HG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6AE0C433F1;
	Thu, 25 Jan 2024 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706181026;
	bh=FU1l9ZzyEdEuQNKjbo0qAjBu5YIHHAdY5D5LVXqoKs4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tDcEa5HG2Y+6Tu5SsfEdSu+vhB6Fy2yi7KhFScZqx8OIaZbv/VDJTiL8QWNrbtvut
	 ntkRDQqjkiiz9NT/4EZiK2BixcekKi76RFTCSTk0kMwIwQxpVkBfT1nXfeuPkzy9GB
	 kw2aZndjGYOXY7a5rYFwrYVLjO+7pc5RwZm5OhbqHcp9tlWa2G38pSh660TclsxgpP
	 GSx0v874aLB5Jsm3mzrNZ48cwQ7dadC2ROm0rzThkw9mNULmtRgdOiark8h5fgGif9
	 BDQByxLHEyyV94kIRpcTVG/C3SFu/rl0ffzfJZdj3U9y0Af9L4AR7GP7Rjf36EoJBE
	 AzX+1F3k4dIog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC809D8C962;
	Thu, 25 Jan 2024 11:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] tsnep: XDP fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170618102670.13412.407737441943094051.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 11:10:26 +0000
References: <20240123200918.61219-1-gerhard@engleder-embedded.com>
In-Reply-To: <20240123200918.61219-1-gerhard@engleder-embedded.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 23 Jan 2024 21:09:16 +0100 you wrote:
> Found two driver specific problems during XDP and XSK testing.
> 
> Gerhard Engleder (2):
>   tsnep: Remove FCS for XDP data path
>   tsnep: Fix XDP_RING_NEED_WAKEUP for empty fill ring
> 
>  drivers/net/ethernet/engleder/tsnep_main.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net,1/2] tsnep: Remove FCS for XDP data path
    https://git.kernel.org/netdev/net/c/50bad6f797d4
  - [net,2/2] tsnep: Fix XDP_RING_NEED_WAKEUP for empty fill ring
    https://git.kernel.org/netdev/net/c/9a91c05f4bd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



