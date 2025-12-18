Return-Path: <bpf+bounces-76999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3DCCCCF42
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 18:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BC773071FA4
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E830535C195;
	Thu, 18 Dec 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYv3biLE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7535BDDB;
	Thu, 18 Dec 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073200; cv=none; b=RxtB+cWbRJw6O0T4BwHvL5tJBbRUaBU8jpdy4PiBjNhWqH7O1nhzl8r3I6lg2m8DbiF0ENK7bu9QdQkxCQKr195x0mO/Nm8SFnUvl9a/oRgM5Xyer6nUu/Vjk0m+7bS9/qGMsp74Dts7cUO+k2Aifjou/pwIVr3pMHNjGwqTg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073200; c=relaxed/simple;
	bh=yIBgvM01ywlBtmD55iH+va2/e0kARfjxgcSNTCgU488=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gmNO9wxLL6JYDZJcArit2whNfSxWj8hrN8CIUzdPRc/pvOMgciifi8k9mya0AA5uW/nImrzC9hopaEYo1ZQjUmQRySuEWRX0I32NERr1rX6FJTssDSsU/lUdj1nLk7EwsiyZQyMpzutsHrP+5l6lOrN+HBhdpwY0axRcBDsM3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYv3biLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FA8C4CEFB;
	Thu, 18 Dec 2025 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766073199;
	bh=yIBgvM01ywlBtmD55iH+va2/e0kARfjxgcSNTCgU488=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EYv3biLERvLXjae3T/RGXoKlbdhHyLhFTJOJjY/W4Wg/6g2G/5ghrx/2PlCExqJIz
	 LRzaDlXNP49ZJzFEJS9QA80hZ3C2sZ3V+I/RGxKEY624xZ7Kg1VFB3ama/wyrQWB5W
	 H6tnT0LXYGYI3kKc8kQH7cguRWLdutpYAg8yJaJJI7s0cbWT8JE7wV9fcjFfqZ4dTc
	 N5F5Cf9I1I2XG2yY4Tt6FBCDdloAhrQnYneHKKiCOEeMnNnoSI1xhAQM+P84hkXI0u
	 XnrTdQqFdDYOvBqO3V7Gqh4WaFo0Mkm4YDVfUY1QTnBVvIbZ5ivw+lrr+KNY4dy+i0
	 A0hRkVCR1LWUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 796DD380A96A;
	Thu, 18 Dec 2025 15:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: enetc: do not transmit redirected XDP frames
 when
 the link is down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176607300930.3021115.4017370445523597811.git-patchwork-notify@kernel.org>
Date: Thu, 18 Dec 2025 15:50:09 +0000
References: <20251211020919.121113-1-wei.fang@nxp.com>
In-Reply-To: <20251211020919.121113-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, frank.li@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 11 Dec 2025 10:09:19 +0800 you wrote:
> In the current implementation, the enetc_xdp_xmit() always transmits
> redirected XDP frames even if the link is down, but the frames cannot
> be transmitted from TX BD rings when the link is down, so the frames
> are still kept in the TX BD rings. If the XDP program is uninstalled,
> users will see the following warning logs.
> 
> fsl_enetc 0000:00:00.0 eno0: timeout for tx ring #6 clear
> 
> [...]

Here is the summary with links:
  - [v3,net] net: enetc: do not transmit redirected XDP frames when the link is down
    https://git.kernel.org/netdev/net/c/2939203ffee8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



