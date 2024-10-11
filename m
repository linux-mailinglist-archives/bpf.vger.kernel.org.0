Return-Path: <bpf+bounces-41793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB9399AF0B
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 01:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5583B1F21C03
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 23:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2961E2009;
	Fri, 11 Oct 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MihMjduf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558A28EB;
	Fri, 11 Oct 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688234; cv=none; b=Orywh2U8Z3Q3CTZhzEooHEsx0wtwtMJ38zz8d1TwQPxRWOUnoJ6a06iChoELl8qPicxZVA5tP3a5744lOQVvEfHOBELcyuXato9Q48C6a9b+pY3/csNKrI07Cg9BV+pO8716zlu5LbO7lpduA4fM3mKxFZUHSNtwGFP0fKlMPNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688234; c=relaxed/simple;
	bh=4mCJwn6mmu4ddpF1rCB/3XCYwBvtuMi7DFbsMpFHEEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fCLTXwZmxbaVoB966O7dUbGVOVL7n/4Uu6ibrXN1kBybo4ffylyRM4fuwwFBNXvtQx6uOJeoILctEpeHokDrJHs5BLW2L/ozxHP34CwgIluPBaEC4toUEX/3Ula3HrQNJZQ14fpaDfqrxfLrjwrZ08x+U1YDG37zc+eFL9c5TU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MihMjduf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4B4C4CECF;
	Fri, 11 Oct 2024 23:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728688233;
	bh=4mCJwn6mmu4ddpF1rCB/3XCYwBvtuMi7DFbsMpFHEEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MihMjdufSziu3AeyBTVQDdBOHRif+6JcW1FqP7gPZLD0EH35L7YtDWBrUB5Vuasqw
	 j/aQnEBftvDVquZLGAFwontFPky6ND4flSZC5b/3dJaKaONIfDjlpKxY38BFZ9jxlk
	 qXDR0HSL7Rh/Z80WolRJIdOHgKfrpKAHomJUm2xcTYxLoRaGn5q+LlO2+BIzCHfYRL
	 rJkh8jxQ8wfz0N24ceILC7O7+E8lra99kYMqRpYyKoa5ygv78pD6b5bs1Lqzq8XpUY
	 6xROHy3k1yOBbmkxnH8GdmiDKov6uRjN+6W6xFPX9+D4f9vYSQuanHIEezGbsTGvLR
	 CiMQQ0X7KEzCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3443B38363CB;
	Fri, 11 Oct 2024 23:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net 0/4] net: enetc: fix some issues of XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868823798.3022673.12555196619496789739.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 23:10:37 +0000
References: <20241010092056.298128-1-wei.fang@nxp.com>
In-Reply-To: <20241010092056.298128-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org,
 imx@lists.linux.dev, rkannoth@marvell.com, maciej.fijalkowski@intel.com,
 sbhatta@marvell.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Oct 2024 17:20:52 +0800 you wrote:
> We found some bugs when testing the XDP function of enetc driver,
> and these bugs are easy to reproduce. This is not only causes XDP
> to not work, but also the network cannot be restored after exiting
> the XDP program. So the patch set is mainly to fix these bugs. For
> details, please see the commit message of each patch.
> 
> 
> [...]

Here is the summary with links:
  - [v4,net,1/4] net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
    https://git.kernel.org/netdev/net/c/412950d5746f
  - [v4,net,2/4] net: enetc: block concurrent XDP transmissions during ring reconfiguration
    https://git.kernel.org/netdev/net/c/c728a95ccf2a
  - [v4,net,3/4] net: enetc: disable Tx BD rings after they are empty
    https://git.kernel.org/netdev/net/c/0a93f2ca4be6
  - [v4,net,4/4] net: enetc: disable NAPI after all rings are disabled
    https://git.kernel.org/netdev/net/c/6b58fadd44aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



