Return-Path: <bpf+bounces-67957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA0B50A80
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 03:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AC24E5DCC
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 01:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10527223DCF;
	Wed, 10 Sep 2025 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWSGX68D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860338F7D;
	Wed, 10 Sep 2025 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469028; cv=none; b=hZAOIcZXkvOYY2MQ4chZ/1IxCtWKZrmPllA+GwtRYhY/tuagpFfXHXzvqM+I0WuRXmwL3XQ9AtXiZ7zmf/hkYZhmXsQVS4DCtiJ+w29J1muOGcPbhL3xtnHxPtU1fSFwFjF1Ex8nnGw/wWy5tzQSF1KddFzta2xxHUvJmOm5agM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469028; c=relaxed/simple;
	bh=1OgbSTWSCN2ga8e8O3v/pIB/AGosGyLQfutcQrc8liI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kl9uYKY34x/0JoX1HX6f+oBi2I9paddzVEY/u6Lfcn9eJAo9wPll8zcO3u6rznEYQ4UIPXh14kxvCqc9rZApmQNKA/b96UdZzWNjMByUpFOwllhZS0OSVMdq7YsET133gtTp2I3Hd1qv4hXunUKPzb8nYonlU7/8AT0gbG/tzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWSGX68D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCDBC4CEF4;
	Wed, 10 Sep 2025 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757469027;
	bh=1OgbSTWSCN2ga8e8O3v/pIB/AGosGyLQfutcQrc8liI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UWSGX68DIL5b9aTHrltBgGnaULh+BSQ/5hEoy9Qui6U3Zqr3WG6AlMqVx4CWCPjPf
	 gPHdsYjqY9Tz4RMO3Xi/z7VYXVoNS9+ID9T2P83LjJ4m579bFnBVxNt6BE9KZ2Shrk
	 6wSzbtHmGFwuPwh3pFQ724fG2K0UniIU0WHVJ1tUuAbi+GzV/M+s/mo1URZMyXfgiD
	 Mk05icltz6Yc6bfDpxhXPOSfPy4281eLGcp0KcRkvjWeUd430krYF+jOdMIBVE/efE
	 Mgt4vYbKpxuHhDjXOt7tqhDt9FOxYFrlqe8yfTZsP9iEX8ddXG12PEuQSJyP3W4cBC
	 cMbdK5EBL/i4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CF2383BF69;
	Wed, 10 Sep 2025 01:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13][pull request] idpf: add XDP support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175746902998.871782.5828497176944109197.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 01:50:29 +0000
References: <20250908195748.1707057-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250908195748.1707057-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 aleksander.lobakin@intel.com, michal.kubiak@intel.com,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 przemyslaw.kitszel@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, sdf@fomichev.me,
 nxne.cnse.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  8 Sep 2025 12:57:30 -0700 you wrote:
> Alexander Lobakin says:
> 
> Add XDP support (w/o XSk for now) to the idpf driver using the libeth_xdp
> sublib. All possible verdicts, .ndo_xdp_xmit(), multi-buffer etc. are here.
> In general, nothing outstanding comparing to ice, except performance --
> let's say, up to 2x for .ndo_xdp_xmit() on certain platforms and
> scenarios.
> idpf doesn't support VLAN Rx offload, so only the hash hint is
> available for now.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] xdp, libeth: make the xdp_init_buff() micro-optimization generic
    https://git.kernel.org/netdev/net-next/c/17d370a70bae
  - [net-next,02/13] idpf: fix Rx descriptor ready check barrier in splitq
    https://git.kernel.org/netdev/net-next/c/c20edbacc029
  - [net-next,03/13] idpf: use a saner limit for default number of queues to allocate
    https://git.kernel.org/netdev/net-next/c/ea18bcca43f4
  - [net-next,04/13] idpf: link NAPIs to queues
    https://git.kernel.org/netdev/net-next/c/bd74a86bc75d
  - [net-next,05/13] idpf: add 4-byte completion descriptor definition
    https://git.kernel.org/netdev/net-next/c/cfe5efec9177
  - [net-next,06/13] idpf: remove SW marker handling from NAPI
    https://git.kernel.org/netdev/net-next/c/9d39447051a0
  - [net-next,07/13] idpf: add support for nointerrupt queues
    https://git.kernel.org/netdev/net-next/c/a0c60b07904c
  - [net-next,08/13] idpf: prepare structures to support XDP
    https://git.kernel.org/netdev/net-next/c/ac8a861f632e
  - [net-next,09/13] idpf: implement XDP_SETUP_PROG in ndo_bpf for splitq
    https://git.kernel.org/netdev/net-next/c/705457e7211f
  - [net-next,10/13] idpf: use generic functions to build xdp_buff and skb
    https://git.kernel.org/netdev/net-next/c/a4d755d1040a
  - [net-next,11/13] idpf: add support for XDP on Rx
    https://git.kernel.org/netdev/net-next/c/cba102cd7190
  - [net-next,12/13] idpf: add support for .ndo_xdp_xmit()
    https://git.kernel.org/netdev/net-next/c/aaa3ac6480ba
  - [net-next,13/13] idpf: add XDP RSS hash hint
    https://git.kernel.org/netdev/net-next/c/88ca0c738c41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



