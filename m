Return-Path: <bpf+bounces-26769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0F58A4ECE
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 14:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1A91F23C54
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F036BB4B;
	Mon, 15 Apr 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIkhGTKU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4F5679F3;
	Mon, 15 Apr 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183628; cv=none; b=SK6/ySBJbtqpDWfyomjdi+8jmAnI9O6Bq5D+nmV4H6bQCVYngroZW4/lBGlum0tmW6/R5kxf/GRU2Ds/ywfYQpTvVOCBEdURzqhdokGno08rUp+83+lE5BqeCSjrx785auQTfRk06k3QHUmryvng1KOQeWW50ZAwuNYaIc02kB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183628; c=relaxed/simple;
	bh=NBLdQ6XHX+11K1mLdHEWYrHqv/ezuPgqZrayiybzpQs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JjPIqH04P4j9ypR9vgaZ15vrLhC3u/1nYY2k67k8N4ZdL/qsSxd9KXlXcx/xaC2BIunKBkOyhcPdF5D4y4YqAcch2Eh+t7bwaVQ/lDIS91XP+7FDlSjuG7o7kZYi4nu1no/VveZcg9B1VOWTxh9L1fv3OUuRLqgs2wRuRFT2F2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIkhGTKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9473C2BD10;
	Mon, 15 Apr 2024 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713183628;
	bh=NBLdQ6XHX+11K1mLdHEWYrHqv/ezuPgqZrayiybzpQs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hIkhGTKUtioBSKnvXCwWJ171ZA9euy19Gg4PTb6Qd9ML6JlPtDCKW1A0VjrHZ2Zhu
	 Ds2PEui9OPeIFSkjCMDknnW+LPiowhJHWW3jFo8m0kAG2ei1IuLJT0kYYAMr8KcjXp
	 v4iCAqx9R9YW91vXPk2bYydjFL9EEWWiYi+tbEKjUgXCSUDjBHe5MwLrWERarW0AfI
	 lVsne17u1ThxkpsKXCl2kdcucdEpiX3cMy4rcqwf/A9u7fv/vqiDuppYSvhVY3Guuc
	 frmyBT7BTFywXdQQiYrkzUliTAv6Baw5LOKWJ41OdmrCupYLmii7V3+/vA/2ac18QZ
	 2riyRSvUuUvpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2442C43140;
	Mon, 15 Apr 2024 12:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/3] Add minimal XDP support to TI AM65 CPSW
 Ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171318362785.9918.8890821177952945239.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 12:20:27 +0000
References: <20240223-am65-cpsw-xdp-basic-v9-0-2c194217e325@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v9-0-2c194217e325@baylibre.com>
To: Julien Panis <jpanis@baylibre.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, horms@kernel.org,
 andrew@lunn.ch, rkannoth@marvell.com, naveenm@marvell.com,
 jacob.e.keller@intel.com, danishanwar@ti.com, yuehaibing@huawei.com,
 rogerq@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Apr 2024 17:38:31 +0200 you wrote:
> This patch adds XDP support to TI AM65 CPSW Ethernet driver.
> 
> The following features are implemented: NETDEV_XDP_ACT_BASIC,
> NETDEV_XDP_ACT_REDIRECT, and NETDEV_XDP_ACT_NDO_XMIT.
> 
> Zero-copy and non-linear XDP buffer supports are NOT implemented.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/3] net: ethernet: ti: Add accessors for struct k3_cppi_desc_pool members
    https://git.kernel.org/netdev/net-next/c/cd8ff81f747f
  - [net-next,v9,2/3] net: ethernet: ti: Add desc_infos member to struct k3_cppi_desc_pool
    https://git.kernel.org/netdev/net-next/c/84d767a3c0b5
  - [net-next,v9,3/3] net: ethernet: ti: am65-cpsw: Add minimal XDP support
    https://git.kernel.org/netdev/net-next/c/8acacc40f733

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



