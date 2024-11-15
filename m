Return-Path: <bpf+bounces-44999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC519CFAE6
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 00:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A5028338F
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 23:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A8C1ADFFE;
	Fri, 15 Nov 2024 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYpI/0Rt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9C1AC450;
	Fri, 15 Nov 2024 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712224; cv=none; b=QKWdjNAj+tywV1ZI2eFIsnY2z1BSNSy1/aVSJjTScv0/Mr8YSOlzifYECFN5yDgpgExeJvAm44dp8CRHAkUe3C3zU4iwSFjDeX99tIQDef3bHMvZGfW4gXsl7Xhg/niOvNixPaG2FwYrRwM+EdUKI4Iy5slbxsZAPu3dv+PIsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712224; c=relaxed/simple;
	bh=QmIecdMt+ZGH6sd9maWWcrzJeuE97zNAh+HmFAJKY8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kLyyf2BBAg/07jiovlwskTRFQ9jsixz1dRJjy8mNLdnLu6CkE3SbhbK3uh9U1OMFwZLNELoyA1oEWf+tqs8ZrGU/txCIrv0c+sqGNB+7TrVteJ7MzM0ZRFAmX0hTmSzZ8iUX/vggBAOSUgfy7kY6Ls8fe+A0xfjT/qT6cGxGVBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYpI/0Rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E967BC4CECF;
	Fri, 15 Nov 2024 23:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731712224;
	bh=QmIecdMt+ZGH6sd9maWWcrzJeuE97zNAh+HmFAJKY8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BYpI/0RtYFPaikG6DZG8j7bYe7NAxPNDpn7Dsb7KyJuVzt9Pf8NmMgfQPls5737gH
	 /szJmejTC0cCXZYACBxAo25mIjzlCprDpy42YRU9fM3gY+KUa8IBVWP0m+Idy83JM0
	 B6NI5rNPtdM8gesMttsN1apM3kt93EtnYS567S9bXhSUhJXee0YxZphdlyrnX6kXEr
	 jrM5rXmxGV5XlF4XZOGBMxOLAJ1tAMNf+E3yEUkAeKYxrSd7Q1ZmKdX8tMQ/yayAfQ
	 2d/Ow6pEu5UmREp1IIWDdlW1achPs7RMtQmT8edpbwXSZsfPnt+4srzMUTmT/ntXSr
	 lcM3jIyYx4nZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACF13809A80;
	Fri, 15 Nov 2024 23:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] xsk: Free skb when TX metadata options are invalid
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173171223475.2762542.13729903505753277301.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 23:10:34 +0000
References: <edb9b00fb19e680dff5a3350cd7581c5927975a8.1731581697.git.fmaurer@redhat.com>
In-Reply-To: <edb9b00fb19e680dff5a3350cd7581c5927975a8.1731581697.git.fmaurer@redhat.com>
To: Felix Maurer <fmaurer@redhat.com>
Cc: bpf@vger.kernel.org, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, yoong.siang.song@intel.com, sdf@fomichev.me,
 netdev@vger.kernel.org, mschmidt@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 12:30:05 +0100 you wrote:
> When a new skb is allocated for transmitting an xsk descriptor, i.e., for
> every non-multibuf descriptor or the first frag of a multibuf descriptor,
> but the descriptor is later found to have invalid options set for the TX
> metadata, the new skb is never freed. This can leak skbs until the send
> buffer is full which makes sending more packets impossible.
> 
> Fix this by freeing the skb in the error path if we are currently dealing
> with the first frag, i.e., an skb allocated in this iteration of
> xsk_build_skb.
> 
> [...]

Here is the summary with links:
  - [bpf] xsk: Free skb when TX metadata options are invalid
    https://git.kernel.org/netdev/net/c/0c0d0f42ffa6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



