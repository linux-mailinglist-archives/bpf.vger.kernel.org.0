Return-Path: <bpf+bounces-75216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDBCC7710B
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 03:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C72B9353024
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 02:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B32DA771;
	Fri, 21 Nov 2025 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGDXDuAT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1F36D4E1;
	Fri, 21 Nov 2025 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763693442; cv=none; b=rhj/0/2N0JR5JYspe3WNCl4oiKu4kqGVBVyEEVjTTprfvhwubxOHkUmfSV6vgeyVw67CTU8sixedZ3dk3Fa+6j63Hk/EE9L3Ipb8pG8Dj/1sp2iZL6GQVGQf0OKkWz8N+BamKSqN2UflCnsvvS992h3I1Zr8I9UT/yrN5ROrMXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763693442; c=relaxed/simple;
	bh=DJh/dq/qC5eekl0ywcj3ulTiHKyT2JlTQJWnwKJi6M8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IUibH5ur3SrX6b2OH6WnLkm4O6fvBVjbDTJRDYjUEO+qJfPPZABcc/E9VhXEtehKejwqc00vclsrjijR9vPGYKpOYSZbKlMGouoY875uN2m0fbC0Iuus9W9Mo2MiRmRjU32HiXd7gzDFPA04+vVxW0lBu9AoY3v9unFik+S3l80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGDXDuAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C83C4CEF1;
	Fri, 21 Nov 2025 02:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763693441;
	bh=DJh/dq/qC5eekl0ywcj3ulTiHKyT2JlTQJWnwKJi6M8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DGDXDuATJKhDHZtuiz38KC9bw14/U97V3Nm6Qxw2XsMKXUUsOiS4ndXxqLYdtBs+i
	 USSRI1tUK2h7ZRtqHhSpljYShKnS+hGyUUYeeMc5M63ACKakDpxQBs0mbc8VsIf869
	 TF+L0ujnFZnzv6Ixmv5kYsmHfHofNWIIiWZF8nrmuTvHvWrWd9/uYsuUUQbpPNkW0o
	 amYf4JocGfI/XiCx9xowSEwhyvCrarvUR2vYq46t/VxIOFzoALWsYeXu0wZQPrKM5e
	 QMFgBLqZ1RR807rET1sp0l4myLT3U2CEZWv59fElGAGFm2Tf0QTj6a0MQcjIpAGG0N
	 FsoA74QTY79Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE363A41003;
	Fri, 21 Nov 2025 02:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V1] veth: reduce XDP no_direct return section to fix
 race
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369340676.1872917.10033820911607185315.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 02:50:06 +0000
References: <176356963888.337072.4805242001928705046.stgit@firesoul>
In-Reply-To: <176356963888.337072.4805242001928705046.stgit@firesoul>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bigeasy@linutronix.de, bpf@vger.kernel.org,
 eric.dumazet@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, makita.toshiaki@lab.ntt.co.jp, toshiaki.makita1@gmail.com,
 kernel-team@cloudflare.com, mfleming@cloudflare.com,
 maciej.fijalkowski@intel.com, dtatulea@nvidia.com, edumazet@google.com,
 sdf@fomichev.me, andrew+netdev@lunn.ch, john.fastabend@gmail.com,
 ast@kernel.org, daniel@iogearbox.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 17:28:36 +0100 you wrote:
> As explain in commit fa349e396e48 ("veth: Fix race with AF_XDP exposing
> old or uninitialized descriptors") for veth there is a chance after
> napi_complete_done() that another CPU can manage start another NAPI
> instance running veth_pool(). For NAPI this is correctly handled as the
> napi_schedule_prep() check will prevent multiple instances from getting
> scheduled, but for the remaining code in veth_pool() this can run
> concurrent with the newly started NAPI instance.
> 
> [...]

Here is the summary with links:
  - [net,V1] veth: reduce XDP no_direct return section to fix race
    https://git.kernel.org/netdev/net/c/a14602fcae17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



