Return-Path: <bpf+bounces-61132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3B7AE0FA9
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 00:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542D117364A
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 22:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F265228B7EC;
	Thu, 19 Jun 2025 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoOaF+hY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8A1FBE8B;
	Thu, 19 Jun 2025 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750372797; cv=none; b=RyrvSfAPIQwJXgwUF4zqopR/hRVJgsZX/Ye5hnnKFbT6wYdiJEJ+sY/EiwyuE76RYGrK2VaASWEHsoI3ljcDx5EJ985HWTDM55HAxdledG/spnpSbCv+l5VPXjt4YnWlZIDd3+DyKoxLFAw+ui9QyjJv1NWSMdE2Ko2RWJjWMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750372797; c=relaxed/simple;
	bh=75c4S8adQQnHNd/zO6XocENI2O2MLyqODhXEw4RIaNA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=spMDm+eo8Zwasr3lA5HLU5eiefjQ2MKE3qqwDGL/D7eoj/ZhJq1omQYtDFNxeKe2HyemsLVnF7jYP0uBR3kzd3GjiX3UqwiM5dXSJ8f1TggzeMk/Q7tjxWn7Hbk1X6JVLdAHBKjVBEXncL33USeBDUCKAr+o4pW/TsIsIih5Mpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoOaF+hY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CE7C4CEEA;
	Thu, 19 Jun 2025 22:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750372796;
	bh=75c4S8adQQnHNd/zO6XocENI2O2MLyqODhXEw4RIaNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eoOaF+hY9mZ2EZr0AtsIAyH8YftKqZWjg+wLJxL+tzO3rpIisDECrg52MQk8Nn0JV
	 z1G/oYAvbvtzAma/CQl6DgKH0IBSWI3WH6EUQ4KZfFEsHwWPeivJda2pPJXi6SV4eP
	 gNT9HVmIwyhhJXOzwotPY3KTHV/7iXKkbros4fNnXLBx3vHdX2+5H4B+gl2Rv9EPIv
	 +021fxeoFCKZIZtkov4aR+/LDNrtEW08l7e8isaurzST6tSkaxhNenMHNjIxyxcZ9H
	 b10D5VqsD6bofY+AvKGu4J8vXXBMuA4ESYLhauFfRDsEwEn8H+nQmnqaGRVRwjB36b
	 1VKJ5Ch/gdjaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C5938111DD;
	Thu, 19 Jun 2025 22:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/11] net: fec: general + VLAN cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037282500.1008441.15490348725238364188.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 22:40:25 +0000
References: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
In-Reply-To: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch,
 aleksander.lobakin@intel.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, bpf@vger.kernel.org,
 Frank.Li@nxp.com, andrew@lunn.ch

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 14:00:00 +0200 you wrote:
> This series first cleans up the fec driver a bit (typos, obsolete
> comments, add missing header files, rename struct, replace magic
> number by defines).
> 
> The last 5 patches clean up the fec_enet_rx_queue() function,
> including VLAN handling.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/11] net: fec: fix typos found by codespell
    https://git.kernel.org/netdev/net-next/c/a822bdb23b3b
  - [net-next,v4,02/11] net: fec: struct fec_enet_private: remove obsolete comment
    https://git.kernel.org/netdev/net-next/c/3e03dad543fd
  - [net-next,v4,03/11] net: fec: switch from asm/cacheflush.h to linux/cacheflush.h
    https://git.kernel.org/netdev/net-next/c/99d171ae9595
  - [net-next,v4,04/11] net: fec: sort the includes by alphabetic order
    https://git.kernel.org/netdev/net-next/c/658e25f770de
  - [net-next,v4,05/11] net: fec: rename struct fec_devinfo fec_imx6x_info -> fec_imx6sx_info
    https://git.kernel.org/netdev/net-next/c/4e8594a88656
  - [net-next,v4,06/11] net: fec: fec_restart(): introduce a define for FEC_ECR_SPEED
    https://git.kernel.org/netdev/net-next/c/a4addc337745
  - [net-next,v4,07/11] net: fec: fec_enet_rx_queue(): use same signature as fec_enet_tx_queue()
    https://git.kernel.org/netdev/net-next/c/e222c08f9669
  - [net-next,v4,08/11] net: fec: fec_enet_rx_queue(): replace manual VLAN header calculation with skb_vlan_eth_hdr()
    https://git.kernel.org/netdev/net-next/c/e4a3659a986e
  - [net-next,v4,09/11] net: fec: fec_enet_rx_queue(): reduce scope of data
    https://git.kernel.org/netdev/net-next/c/33b9f31893bd
  - [net-next,v4,10/11] net: fec: fec_enet_rx_queue(): move_call to _vlan_hwaccel_put_tag()
    https://git.kernel.org/netdev/net-next/c/4dffaf379104
  - [net-next,v4,11/11] net: fec: fec_enet_rx_queue(): factor out VLAN handling into separate function fec_enet_rx_vlan()
    https://git.kernel.org/netdev/net-next/c/0593f8df66e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



