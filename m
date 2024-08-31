Return-Path: <bpf+bounces-38667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961BC9672BF
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3682835F2
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71FE5589A;
	Sat, 31 Aug 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6Y+WHKW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0D1F95A;
	Sat, 31 Aug 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725123032; cv=none; b=nnAda4FP+uGSPtSQCHsnI59yUhdO+RR4FD+3KMe/mFBFbGS2Oa7wfTPyNm9AGiktHgrqicJUEbHelz19l3c72COJ3utngf/7Xg3cHE9ns5LLUTM30nq0arpw5D8zXc4sT1JOkCwJ1SzUcNzSWPytqazRIU8HHDReILeyhahbGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725123032; c=relaxed/simple;
	bh=XyJLHVijAzXiQHfu/LNw06AadgdkocpqbU9UqYzFAbs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AbBaMuyeVJe5lCaC/p0Tedcc20iIPFLy+nB6Z+HkAXvusgPUAlvD8AeQvR8IaiYIXB+YTi/YhvD8IviTrcJPE6Hx0z+PZpmMrQuajcaYU+LJawpBGNXQKH3wOSrr4yOTpov9swh+jrNmpx+u7Kl2SEPeTwg+AVPQTwQWKkDEnwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6Y+WHKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A828CC4CEC0;
	Sat, 31 Aug 2024 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725123031;
	bh=XyJLHVijAzXiQHfu/LNw06AadgdkocpqbU9UqYzFAbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y6Y+WHKWE6mOG0UqIZrNs4nxBVjvbDhldOWj3CkhwkFx2svk/F8q4m9buTI/gJ79J
	 cze2eVTTax1MMc2i2nQk3Tj2uFtv/WhpfMS8QqQS9TAkOR7H3eIpGCJvv0Jiiv98oN
	 4/Cu+wmQtZwHcYvEG+ccmbPQTYrGmbpaF6uMy5H46s64gK/mmuGz2ibLqIjb4cU31e
	 Lu2BTCKR9MYjNOVQZ+dLezGgraqLWiUDaRCwcM8HOuDRWthlfTBQpKXaAouWiu4lfU
	 1n7h04IfwrAoa7RLhKmhKnWv7b51jx+gzpuEXLR8uyGkGXjrxiAdAbj03unuEzBMGi
	 WQhn8iPJmXsGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713373809A80;
	Sat, 31 Aug 2024 16:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/12] Unmask upper DSCP bits - part 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172512303227.2897375.10297069392571064584.git-patchwork-notify@kernel.org>
Date: Sat, 31 Aug 2024 16:50:32 +0000
References: <20240829065459.2273106-1-idosch@nvidia.com>
In-Reply-To: <20240829065459.2273106-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, gnault@redhat.com,
 dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, john.fastabend@gmail.com, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Aug 2024 09:54:47 +0300 you wrote:
> tl;dr - This patchset continues to unmask the upper DSCP bits in the
> IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> DSCP. No functional changes are expected. Part 1 was merged in commit
> ("Merge branch 'unmask-upper-dscp-bits-part-1'").
> 
> The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> lookup to match against the TOS selector in FIB rules and routes.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/12] ipv4: Unmask upper DSCP bits in RTM_GETROUTE output route lookup
    https://git.kernel.org/netdev/net-next/c/47afa284b96c
  - [net-next,v2,02/12] ipv4: Unmask upper DSCP bits in ip_route_output_key_hash()
    https://git.kernel.org/netdev/net-next/c/a63cef46adcb
  - [net-next,v2,03/12] ipv4: icmp: Unmask upper DSCP bits in icmp_route_lookup()
    https://git.kernel.org/netdev/net-next/c/4805646c42e5
  - [net-next,v2,04/12] ipv4: Unmask upper DSCP bits in ip_sock_rt_tos()
    https://git.kernel.org/netdev/net-next/c/ff95cb5e521b
  - [net-next,v2,05/12] ipv4: Unmask upper DSCP bits in get_rttos()
    https://git.kernel.org/netdev/net-next/c/356d054a4967
  - [net-next,v2,06/12] ipv4: Unmask upper DSCP bits when building flow key
    https://git.kernel.org/netdev/net-next/c/f6c89e95555a
  - [net-next,v2,07/12] xfrm: Unmask upper DSCP bits in xfrm_get_tos()
    https://git.kernel.org/netdev/net-next/c/b261b2c6c18b
  - [net-next,v2,08/12] ipv4: Unmask upper DSCP bits in ip_send_unicast_reply()
    https://git.kernel.org/netdev/net-next/c/13f6538de2b8
  - [net-next,v2,09/12] ipv6: sit: Unmask upper DSCP bits in ipip6_tunnel_xmit()
    https://git.kernel.org/netdev/net-next/c/6a59526628ad
  - [net-next,v2,10/12] ipvlan: Unmask upper DSCP bits in ipvlan_process_v4_outbound()
    https://git.kernel.org/netdev/net-next/c/939cd1abf080
  - [net-next,v2,11/12] vrf: Unmask upper DSCP bits in vrf_process_v4_outbound()
    https://git.kernel.org/netdev/net-next/c/c5d8ffe29cf2
  - [net-next,v2,12/12] bpf: Unmask upper DSCP bits in __bpf_redirect_neigh_v4()
    https://git.kernel.org/netdev/net-next/c/50033400fc3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



