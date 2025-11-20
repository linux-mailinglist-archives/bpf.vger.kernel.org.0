Return-Path: <bpf+bounces-75170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DEAC74906
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 15:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC084353B27
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711E422A4F6;
	Thu, 20 Nov 2025 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY9YcLo9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2173B2BA;
	Thu, 20 Nov 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649051; cv=none; b=nNXDVivVsXi88h90MOmQFKNGeAUQLFhBG71cADi4byCuF/k3NZS4eiDl8yJrC8e5zJd276BWBUdrTbSkbOPbZdCed0XUqDDJ7EiIyNCjP9wzhJaaPUv7lMopsnvi1HpjPSAcBASnPeb0iyXm4UKXAcgphE/8SoIBxhY7AY25NGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649051; c=relaxed/simple;
	bh=G0UVsRqQ7j8J9S16cmfX+j6Xm8Cx7ey9TFc+hgOvBdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UPrUiiB+uDDAL+KKYT4j0tTQ0O8H289ou2Yt2BqfOQlZsTIPFG1zO2AqVtnsGIyGmYChFniSOJuyx+3f2/LjP6gylJAbfqvpWJE6iQo/88UFpCkOMTCqtameJ5ytoI4U9T10UvOvlrLYyjSo4Oldk/NRXXEoNmUsPJprCLToCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY9YcLo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D225C4CEF1;
	Thu, 20 Nov 2025 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763649050;
	bh=G0UVsRqQ7j8J9S16cmfX+j6Xm8Cx7ey9TFc+hgOvBdc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BY9YcLo9PfgLCtt2rd0kgNyiwsySVweY8KcCyA6BZwyH6QSGzWolRG59qQBleVOdV
	 2YPw73f5oaRWHYMp8PsWt758sIPRvImjds+2QvxjNT3pk8FpD2uAENbsyJmyTcmAko
	 K4Wc5H8igZzgX7q8zgD+GXWCcXiKU69+OnaDj0cUCcVtMqR6Ln8u+cpMdxpjs1DkLs
	 Vz0b8JopsN8zGBq7Ln7dQ2vhkJy4GWNtl0fKvy+i5uXY5FB8T7eu3rMobUPWuwSwx0
	 kSia1/X5hInvUYSppwsSJLpqago3Xi67ZiQLZarj/c/x/AGqDoRprp63jB4vlrxvEJ
	 7Rim3ehM+vlsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1739FEB77;
	Thu, 20 Nov 2025 14:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/6] Add AF_XDP zero copy support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176364901575.1647241.5550367394642830810.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 14:30:15 +0000
References: <20251118135542.380574-1-m-malladi@ti.com>
In-Reply-To: <20251118135542.380574-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: horms@kernel.org, namcao@linutronix.de, vadim.fedorenko@linux.dev,
 jacob.e.keller@intel.com, christian.koenig@amd.com, sumit.semwal@linaro.org,
 sdf@fomichev.me, john.fastabend@gmail.com, hawk@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org, danishanwar@ti.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 18 Nov 2025 19:25:36 +0530 you wrote:
> This series adds AF_XDP zero coppy support to icssg driver.
> 
> Tests were performed on AM64x-EVM with xdpsock application [1].
> 
> A clear improvement is seen Transmit (txonly) and receive (rxdrop)
> for 64 byte packets. 1500 byte test seems to be limited by line
> rate (1G link) so no improvement seen there in packet rate
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/6] net: ti: icssg-prueth: Add functions to create and destroy Rx/Tx queues
    https://git.kernel.org/netdev/net-next/c/41dde7f1d013
  - [net-next,v6,2/6] net: ti: icssg-prueth: Add XSK pool helpers
    https://git.kernel.org/netdev/net-next/c/7dfd7597911f
  - [net-next,v6,3/6] net: ti: icssg-prueth: Add AF_XDP zero copy for TX
    https://git.kernel.org/netdev/net-next/c/8756ef2eb078
  - [net-next,v6,4/6] net: ti: icssg-prueth: Make emac_run_xdp function independent of page
    https://git.kernel.org/netdev/net-next/c/121133163c9f
  - [net-next,v6,5/6] net: ti: icssg-prueth: Add AF_XDP zero copy for RX
    https://git.kernel.org/netdev/net-next/c/7a64bb388df3
  - [net-next,v6,6/6] net: ti: icssg-prueth: Enable zero copy in XDP features
    https://git.kernel.org/netdev/net-next/c/c6a1ec1870e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



