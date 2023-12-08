Return-Path: <bpf+bounces-17174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB5980A1AF
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 12:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE72F1C208E4
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C411125B6;
	Fri,  8 Dec 2023 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEzPH/rC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F36FD6;
	Fri,  8 Dec 2023 11:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58A15C433CA;
	Fri,  8 Dec 2023 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702033225;
	bh=1L3W0Olv+R+kHzOLiJnr1tgIjD7V5hrXUJRJcLy2Pb8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VEzPH/rCT0ANk+4UUjvCU1rO1UprgeFQBr0nGUZP1RWomNYrfR8kgoFGuq04gfnqW
	 0ydoitXLAhaANSZQQhMEpVgvAj0n9PFVJ27TXSw6o0bxn980ZNTbu8PdD8ZguRFSXh
	 O47aTfET1burDw4ZGz9Fu9f32nVVNGoY7vyFXl7YChbkCPFlSeOXmUW2wQEE29xXbw
	 NyAMkTsXQVCRNum1prPdPUDNkEZu6tSU7YY50aS7XfiTa3goiime8PYZ40zhjUUmTf
	 6qVTycbXIuTvn8oghp4WgPu6nz1XSp4ElOvhqdpP0Xep7yVbPjeIHGY7Bb49tmMaUo
	 tyqWXix93P1VA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30F8DDD4F1E;
	Fri,  8 Dec 2023 11:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] ethtool: Add ethtool_puts()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170203322519.25632.13162024419836426102.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 11:00:25 +0000
References: <20231206-ethtool_puts_impl-v5-0-5a2528e17bf8@google.com>
In-Reply-To: <20231206-ethtool_puts_impl-v5-0-5a2528e17bf8@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shayagr@amazon.com, akiyano@amazon.com,
 darinzon@amazon.com, ndagan@amazon.com, saeedb@amazon.com, rmody@marvell.com,
 skalluru@marvell.com, GR-Linux-NIC-Dev@marvell.com, dmichail@fungible.com,
 yisen.zhuang@huawei.com, salil.mehta@huawei.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, louis.peens@corigine.com, shannon.nelson@amd.com,
 brett.creeley@amd.com, drivers@pensando.io, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 doshir@vmware.com, pv-drivers@vmware.com, apw@canonical.com, joe@perches.com,
 dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, hauke@hauke-m.de,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 arinc.unal@arinc9.com, daniel@makrotopia.org, Landen.Chao@mediatek.com,
 dqfext@gmail.com, sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linus.walleij@linaro.org,
 alsi@bang-olufsen.dk, wei.fang@nxp.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, linux-imx@nxp.com, lars.povlsen@microchip.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, ndesaulniers@google.com, nathan@kernel.org,
 keescook@chromium.org, intel-wired-lan@lists.osuosl.org,
 oss-drivers@corigine.com, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 06 Dec 2023 23:16:09 +0000 you wrote:
> Hi,
> 
> This series aims to implement ethtool_puts() and send out a wave 1 of
> conversions from ethtool_sprintf(). There's also a checkpatch patch
> included to check for the cases listed below.
> 
> This was sparked from recent discussion here [1]
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] ethtool: Implement ethtool_puts()
    https://git.kernel.org/netdev/net-next/c/2a48c635fd9a
  - [net-next,v5,2/3] checkpatch: add ethtool_sprintf rules
    https://git.kernel.org/netdev/net-next/c/9b5f621cea6e
  - [net-next,v5,3/3] net: Convert some ethtool_sprintf() to ethtool_puts()
    https://git.kernel.org/netdev/net-next/c/e403cffff1a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



