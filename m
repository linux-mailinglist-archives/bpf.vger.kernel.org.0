Return-Path: <bpf+bounces-43687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7DE9B88B6
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 02:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318171F211E4
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 01:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CBA84A2F;
	Fri,  1 Nov 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo13IK6r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C9C3F9CC;
	Fri,  1 Nov 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425228; cv=none; b=SBKAaLvLGmkU+w7a1tU84rTtuVKM4GU7+C/TdmuuY6CNgPGYRz1bTB35+9XkyDjBl4KawDGIo4rUda9KA1vbz02EV6ksIYwDfU4XZzT6YbVojd+JDEbbINqnx+UJ1xxBRS6QxYoniR1muNu1VOIcJRjlxW/HwmgfxcEUMwwDOI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425228; c=relaxed/simple;
	bh=GRJEKlHR8b5LRnU1kiPmGCbmnJ+WuP/4OUML9P8ReSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mz5ZfEEkc7ROzVta6j6QDpd5poAbXZ5++s6VEX/GeNZZsWVC2G0psQqBQe8+Itim2XI/uXZqNpTvNSPADIBMxIVYIj+5ETc9mSoEfcDU68GQkJjVRzU+fDgDkp51AlzC1KT+h0GbJHr0U7/yspGHo+TCK6UvcDzrTa5VKk6R/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo13IK6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8436CC4CEC3;
	Fri,  1 Nov 2024 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730425225;
	bh=GRJEKlHR8b5LRnU1kiPmGCbmnJ+WuP/4OUML9P8ReSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oo13IK6r88xnNUO39oWyLkPf+uNIZKckf/WYWg06gzci3wkMnwAfc2N4hx4QvaXzi
	 fRDrwpjrAm/yXBgXBZYIRGoL3V5bhCqyYcs4z4sAZEpON5ASNYfzgta3yhhSeypvL9
	 +TKJ34gK907pDjTR9t+wA8fEueJzdaJSL8YAYcqQ80WP4HG2jik86bj48GnjgIde3E
	 NVWxn4hVl0xbpkIuGskXgsYKsJuFeBGyJccEUdN7bdi31diQtdgG+rJf3FJDyVorTs
	 cxeWLTrZ5GQkdRonTkAilng2rlKIbaKXXMXT4WigoO92Qa58Vw6GAuRTLBbffh3PZj
	 LW3uYa2WJujXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04F380AC02;
	Fri,  1 Nov 2024 01:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] net: freescale: use ethtool string helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042523324.2147711.14478562238628999014.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 01:40:33 +0000
References: <20241025203757.288367-1-rosenp@gmail.com>
In-Reply-To: <20241025203757.288367-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Oct 2024 13:37:57 -0700 you wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: fix wrong variable in for loop
>  .../ethernet/freescale/dpaa/dpaa_ethtool.c    | 40 ++++++-------------
>  .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  | 15 +++----
>  .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  |  9 ++---
>  .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  2 +-
>  .../freescale/dpaa2/dpaa2-switch-ethtool.c    |  9 ++---
>  .../ethernet/freescale/enetc/enetc_ethtool.c  | 35 +++++-----------
>  .../net/ethernet/freescale/gianfar_ethtool.c  |  8 ++--
>  .../net/ethernet/freescale/ucc_geth_ethtool.c | 21 +++++-----
>  8 files changed, 51 insertions(+), 88 deletions(-)

Here is the summary with links:
  - [PATCHv2,net-next] net: freescale: use ethtool string helpers
    https://git.kernel.org/netdev/net-next/c/f611cc38925b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



