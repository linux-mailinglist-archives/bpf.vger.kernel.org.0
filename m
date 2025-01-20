Return-Path: <bpf+bounces-49308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22D1A174F1
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 00:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA54188A854
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 23:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64D1C07E7;
	Mon, 20 Jan 2025 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNkVk4ES"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5AC383;
	Mon, 20 Jan 2025 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737414607; cv=none; b=Fy5Dd9Bc+vLf099GRO7QvO55lVihnGatR+v13Fhgv2Y91rm3y9AmHcg+3L8XlwD6Sa+ZkNyA0vcBdeKEqzVAULJkm8Almg8FQgEPOjT2YRle7nf7JRHcRaOfKukcMjbXe78pgDruI7VPbGHlsHbjAtPihdoi7EBBhcLLgTrMzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737414607; c=relaxed/simple;
	bh=gabo7M0aUIqFL5qEJ9Y+em9+3QJIvyxrYFOMg5aMtPY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EL+PwHSBXn4jQBNKHW4wIyK4uOdebzhEfRxLp/gVh20ROPF6LmV+ibibc2dn62YTYSI4AOEVOCDAYhqcLJZhp1Yp5eyEke816vhlSLrDUr/a2wP98WSjoN7ydH81BdaxraZ0cSCgKvF12WhISl1RrU+kLmJTJ7qO/cH36Y0rQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNkVk4ES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4926C4CEDD;
	Mon, 20 Jan 2025 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737414606;
	bh=gabo7M0aUIqFL5qEJ9Y+em9+3QJIvyxrYFOMg5aMtPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KNkVk4ESP2nA6nPz7ZdE/osPani2eaCU4IhxZZu4Lq1wswLSrSEi2cN3SqKCmpYM6
	 eltBdUC9udblPtIb9w0P9AQbrOUYg/wpfCqQdcr4fD2OcdAqxUaHb4UIgzXdHqbdlP
	 P7a7vVaGxEsk49EZFmOERqQfi+/YaXSXhMuyFxUP9rzb8aZ7w3Old9tI1KQlwDZUqM
	 rFZhUiN3nwPqJ5q6+yJO8Q0jrVTjRaLCdpDNaugW+iUS5WHCzq2VL57FBz0UNA3shA
	 5EGyZY7JzKdzKEAVrjbfID+GFOPv1D5wlaTDihdBK0o2W508C5COdNJpRaQzVUjbBZ
	 r/lsLPZtBoSCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE1B380AA62;
	Mon, 20 Jan 2025 23:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: ethernet: ti: am65-cpsw: streamline
 RX/TX queue creation and cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173741463076.3679464.11933533313708043409.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 23:10:30 +0000
References: <20250117-am65-cpsw-streamline-v2-0-91a29c97e569@kernel.org>
In-Reply-To: <20250117-am65-cpsw-streamline-v2-0-91a29c97e569@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 s-vadapalli@ti.com, srk@ti.com, danishanwar@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jan 2025 16:06:32 +0200 you wrote:
> In this series we fix an issue with missing cleanups during
> error path of am65_cpsw_nuss_init_tx/rx_chns() when used anywhere
> other than at probe().
> 
> Then we streamline RX and TX queue creation and cleanup. The queues
> can now be created or destroyed by calling the appropriate
> functions am65_cpsw_create_rxqs/txqs() and am65_cpsw_destroy_rxq/txqs().
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: ethernet: ti: am65-cpsw: ensure proper channel cleanup in error path
    https://git.kernel.org/netdev/net-next/c/681eb2beb3ef
  - [net-next,v2,2/3] net: ethernet: ti: am65-cpsw: streamline RX queue creation and cleanup
    https://git.kernel.org/netdev/net-next/c/66c1ae68a1e9
  - [net-next,v2,3/3] net: ethernet: ti: am65-cpsw: streamline TX queue creation and cleanup
    https://git.kernel.org/netdev/net-next/c/3568d21686b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



