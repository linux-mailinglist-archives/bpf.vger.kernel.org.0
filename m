Return-Path: <bpf+bounces-39877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AABA978C6B
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 03:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC71B23486
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DBF8F54;
	Sat, 14 Sep 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QACtlx14"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633398C13;
	Sat, 14 Sep 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726276827; cv=none; b=kA8wHaeBghESXzvTZ6l9f/FItiPL0nHE+1zvuTz3HfwoDHD5j4ayUEK3PXy7lQAnOrAsDX95AQ8C3b3UNFtcJgvDjWS070+HuG6sSRkjnmDDZKMhlWkf/TvthV4stam7UWVn+YTGo9wKoLlWpuA+K/6H/TuxRxvsrYuLwdEQJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726276827; c=relaxed/simple;
	bh=0DUDd2+iEeZvfBc/eTL/P/TtYdpMQo1TRlR6qDt/VXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WvF6vanlBXxJi9oPrTdtlKEhWVtzLS+bXxrSx2x9EpL5dG9bie+x1BHTqzslwy7HQIUA/AIEsDewzSnnNpo1QqyHp76GKrbkDRbcxM4Hpl4TBoS9vNEr1ReZCsLpGDG1v4p5R8uXge6gXYCngfDWlaAWcSWxCbLN3/xSHKcvdt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QACtlx14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47DDC4CEC0;
	Sat, 14 Sep 2024 01:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726276827;
	bh=0DUDd2+iEeZvfBc/eTL/P/TtYdpMQo1TRlR6qDt/VXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QACtlx14aymf4x/QGnPO8fdjYvmX6jyoqh/mAT9VJ8X6dn+ZkgkBux/VEnXanfdFu
	 tF/LI9xuZ8q3OHFzMn0efcoEmN8zqtLtyY9iMJ41+IGKCRn7XDEtESvHJNXj2MzDVL
	 6chkg9CvlrhoisKqK8/yrQ9BoE5kUeSQlN0bRm6GgSqIc7sAQj3PC/2dirUB/3jbBl
	 OrexZYl3wHvTD769yryOgXMD/fvDkm0PbVasD7doOsU5OXlRUjjGLP4MxoC229Blbv
	 /vQIVbo4e7H2oegOmW0nEkrFIzawT4NE/rvTjeY2ZDqldkTU4HsaRjTeZowdYpWYIS
	 vYVGLCXPCdTTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CFA3806655;
	Sat, 14 Sep 2024 01:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] xsk: fix batch alloc API on non-coherent systems
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172627682827.2420123.2078617931092326195.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 01:20:28 +0000
References: <20240911191019.296480-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20240911191019.296480-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 bjorn@kernel.org, ddewinter@synamedia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 21:10:19 +0200 you wrote:
> In cases when synchronizing DMA operations is necessary,
> xsk_buff_alloc_batch() returns a single buffer instead of the requested
> count. This puts the pressure on drivers that use batch API as they have
> to check for this corner case on their side and take care of allocations
> by themselves, which feels counter productive. Let us improve the core
> by looping over xp_alloc() @max times when slow path needs to be taken.
> 
> [...]

Here is the summary with links:
  - [bpf] xsk: fix batch alloc API on non-coherent systems
    https://git.kernel.org/netdev/net/c/4144a1059b47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



