Return-Path: <bpf+bounces-56570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 601BAA99E82
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 03:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04DC7B06B0
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 01:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AEB1DACB8;
	Thu, 24 Apr 2025 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7aulUTm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981D20322;
	Thu, 24 Apr 2025 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745459411; cv=none; b=aGYVv5BB8H05OjL4PQMTZ8nVyeJriAyJU1ZyfewzbCfhM8+MaU/O+qd8QAUglyvCN2S85Tz598fRVoqc6AxqDwqZom9QyOI/W+kMZR3XFjZTrWb4FF2Wk/qEeYNNOeMfTWr/ew93Fh8IHgn9i4YSLqprQSqm1+vs/d5tOKRMPeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745459411; c=relaxed/simple;
	bh=r8x30VuoJOYhodsigVM6Ux1MiJ1evECurEW8hJ8Qqu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XjLZ+F2hgwW8zuUQdTVCUSUko1RT2HCLNnj0EDBvUSJPVnVu+hUJDDp3mGs2hvlN4bu6IJES/97vpGz0/zRHetaj6BwDNBgdcKR9nzC+et6EHPS933Hwy6WtsXRCMe1FNDyAgqIWb+7bLg+A4IGG6yP6tYz41+vvNtXaKqEyj6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7aulUTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B52C4CEE2;
	Thu, 24 Apr 2025 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745459410;
	bh=r8x30VuoJOYhodsigVM6Ux1MiJ1evECurEW8hJ8Qqu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B7aulUTmFiI7vI3fViJXFOPtN1evrtUsUOFHDvwYzrrB4kKepsqL6rIy15Q8WholK
	 4PMQsVL8Wy7qNWcwBHi/rcvt/vkU1D4cLCB895U4mtI4npXZKATUrIpg6hYMIlHP+t
	 JOFnqa3QFtUTHuVjJAxSbPwhlu3CjH4FIohYlUgJ19m+9kNq3zYJllAZm5RSUEu6Co
	 59LyORrmh6u2hkcXbbA5yetS4qfGQwMJpz8sDlKZKBYbpY9B5GA7mWCxYwS5lBqPO1
	 IBdcoLg8FshAqvlkC4Wa8lYLXVtF4d7tlfS9KrMlOEfzXLqTQKjQ4yPST4OWRMj1kA
	 aOng2+lPepk2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D53380CED9;
	Thu, 24 Apr 2025 01:50:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14][pull request] igc: Add support for Frame
 Preemption
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174545944873.2829412.16224274758028926959.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 01:50:48 +0000
References: <20250418163822.3519810-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250418163822.3519810-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 faizal.abdul.rahim@linux.intel.com, vinicius.gomes@intel.com,
 vitaly.lifshits@intel.com, dima.ruinskiy@intel.com,
 przemyslaw.kitszel@intel.com, chwee.lin.choong@intel.com,
 yong.liang.choong@linux.intel.com, vladimir.oltean@nxp.com, horms@kernel.org,
 linux@armlinux.org.uk, xiaolei.wang@windriver.com,
 hayashi.kunihiko@socionext.com, ast@kernel.org, jesper.nilsson@axis.com,
 mcoquelin.stm32@gmail.com, rmk+kernel@armlinux.org.uk,
 fancer.lancer@gmail.com, kory.maincent@bootlin.com,
 linux-stm32@st-md-mailman.stormreply.com, hkelam@marvell.com,
 alexandre.torgue@foss.st.com, daniel@iogearbox.net,
 linux-arm-kernel@lists.infradead.org, hawk@kernel.org,
 quic_jsuraj@quicinc.com, gal@nvidia.com, john.fastabend@gmail.com,
 0x1207@gmail.com, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 18 Apr 2025 09:38:06 -0700 you wrote:
> Faizal Rahim says:
> 
> Introduce support for the FPE feature in the IGC driver.
> 
> The patches aligns with the upstream FPE API:
> https://patchwork.kernel.org/project/netdevbpf/cover/20230220122343.1156614-1-vladimir.oltean@nxp.com/
> https://patchwork.kernel.org/project/netdevbpf/cover/20230119122705.73054-1-vladimir.oltean@nxp.com/
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] net: stmmac: move frag_size handling out of spin_lock
    https://git.kernel.org/netdev/net-next/c/b375984f0df0
  - [net-next,02/14] net: ethtool: mm: extract stmmac verification logic into common library
    https://git.kernel.org/netdev/net-next/c/9ff2aa4206ef
  - [net-next,03/14] net: ethtool: mm: reset verification status when link is down
    https://git.kernel.org/netdev/net-next/c/dda666343cc8
  - [net-next,04/14] igc: rename xdp_get_tx_ring() for non-xdp usage
    https://git.kernel.org/netdev/net-next/c/19d629079c0e
  - [net-next,05/14] igc: rename I225_RXPBSIZE_DEFAULT and I225_TXPBSIZE_DEFAULT
    https://git.kernel.org/netdev/net-next/c/67287d67bebd
  - [net-next,06/14] igc: use FIELD_PREP and GENMASK for existing TX packet buffer size
    https://git.kernel.org/netdev/net-next/c/425d8d9cb092
  - [net-next,07/14] igc: optimize TX packet buffer utilization for TSN mode
    https://git.kernel.org/netdev/net-next/c/0d58cdc902da
  - [net-next,08/14] igc: use FIELD_PREP and GENMASK for existing RX packet buffer size
    https://git.kernel.org/netdev/net-next/c/9cd87aafc7a8
  - [net-next,09/14] igc: set the RX packet buffer size for TSN mode
    https://git.kernel.org/netdev/net-next/c/7663370e32b3
  - [net-next,10/14] igc: add support for frame preemption verification
    https://git.kernel.org/netdev/net-next/c/5422570c0010
  - [net-next,11/14] igc: add support to set tx-min-frag-size
    https://git.kernel.org/netdev/net-next/c/55ececab9885
  - [net-next,12/14] igc: block setting preemptible traffic class in taprio
    https://git.kernel.org/netdev/net-next/c/e9074d7f3768
  - [net-next,13/14] igc: add support to get MAC Merge data via ethtool
    https://git.kernel.org/netdev/net-next/c/10e2ffe10e43
  - [net-next,14/14] igc: add support to get frame preemption statistics via ethtool
    https://git.kernel.org/netdev/net-next/c/f05ce73cc3b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



