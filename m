Return-Path: <bpf+bounces-18828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51182259B
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D487A1F23439
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0881798D;
	Tue,  2 Jan 2024 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMO3lLlf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403F1774F;
	Tue,  2 Jan 2024 23:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C402C433C9;
	Tue,  2 Jan 2024 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704238823;
	bh=7mnfzrHhj2ns0twHot2KWCYqMjgo03GH4mcdMdIIXR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YMO3lLlfcP7m2HCvxUGcnKXCM/8ekwORvmqEdpIx5x0GCgr+m1MO4GZYbGV6QhDmm
	 eSoPdMIONfWFRs3pK83ByIsjm1KUF4S3PT3YCGfKcFxfxa/ULKWjDvpM7AxaAtvcYl
	 bDC6X/HM+wlxQOmbqhM+DvqCSaUx41/FG/vXaQnY6jWUnOSbI5LEcsN21SIG+bK9XL
	 HQW4ZFNLap6i09NRoTecf3NzIeCfcvnah67Ak3o+lYo8nEENML2ucL2xjxFbEUgL6a
	 YICK4B+RFBVxdXzZHIj+tQey/x1KH6J3/WHT23LZ59BzexSGdaReDWgDOCt4qHLUuM
	 bSLF4CKnKbUEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 817C9C395C5;
	Tue,  2 Jan 2024 23:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] xsk: make struct xsk_cb_desc available outside
 CONFIG_XDP_SOCKETS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170423882352.25379.12558128000178883881.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 23:40:23 +0000
References: <20231219110205.1289506-1-vladimir.oltean@nxp.com>
In-Reply-To: <20231219110205.1289506-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, anthony.l.nguyen@intel.com, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, larysa.zaremba@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Dec 2023 13:02:05 +0200 you wrote:
> The ice driver fails to build when CONFIG_XDP_SOCKETS is disabled.
> 
> drivers/net/ethernet/intel/ice/ice_base.c:533:21: error:
> variable has incomplete type 'struct xsk_cb_desc'
>         struct xsk_cb_desc desc = {};
>                            ^
> include/net/xsk_buff_pool.h:15:8: note:
> forward declaration of 'struct xsk_cb_desc'
> struct xsk_cb_desc;
>        ^
> 
> [...]

Here is the summary with links:
  - [net-next] xsk: make struct xsk_cb_desc available outside CONFIG_XDP_SOCKETS
    https://git.kernel.org/netdev/net-next/c/8dc4c4100065

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



