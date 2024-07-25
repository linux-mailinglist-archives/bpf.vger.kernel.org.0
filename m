Return-Path: <bpf+bounces-35649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F3593C643
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3970EB229C8
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307DA19D8A4;
	Thu, 25 Jul 2024 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ2AHp8z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1619D062;
	Thu, 25 Jul 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721920750; cv=none; b=JR7qyl5iS8Vktc3FD/N8Zgf4f9Xw2pxozK8809bfxpwxfXeIqgfAyHaWjRWMGZU2MKyyUQsENnxvPyZxFPsBNWg5HN6m66heEmem+f35omlEYusN2nGTOof10RxFkJUtDRY/MtTepK1xxiomrVmWVsJpRHYjkzJ9pIEiTqcLVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721920750; c=relaxed/simple;
	bh=4qyGM2XW6YKxgY66miREvkGK4NkQkumhVGzT87LIZno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n7ffxM0dNxy53Iva5MztE57jIW+Ei1v2dB1WlQowYZy945nLtGMM0zFHxahpeDMTPE0QCetmHj0MAw0mrt6cpzW6KnQJ+bzPd8i3aj/rIBJfU9P20LoAiqKhu3DbvHX7MX958OWlj/8HvVXjdlshDJXNO/hDMvYeeel6MTN94v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ2AHp8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 420B1C4AF07;
	Thu, 25 Jul 2024 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721920750;
	bh=4qyGM2XW6YKxgY66miREvkGK4NkQkumhVGzT87LIZno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lZ2AHp8zNNZtsA78JbEQw7JFJG33Nkkw9xB8bFGDkZtj2QK8YcYXlehV5kZ9/XEQH
	 FoFSTvKL1zMHZhgzyaQdcAU+hHh+Zcc1lpslXHm2C4L839mBgGjp5292EmxCiaTsQ+
	 JzuF7WGhAJ0uzr3RGXavdLkDTzjcrzNXQJF8nVWKSdZ4m/iraIR8bh6MKV+2RD8WzZ
	 K8kAAAKHejKQ7z913mIB3ZgDdQtvjHmkAwc9ll8/rP63KoKEt8DSfrMbEK17YMQ1jA
	 sQKkKVeEdbcOHb9v29466b5hXg8l70ke6z0oyAciy6dsAWzNBE9zmUhOzm++QIX54K
	 ipCkQlH0n899w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32C06C4332D;
	Thu, 25 Jul 2024 15:19:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] tap/tun: harden by dropping short frame
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172192075020.10696.12286073908721729622.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 15:19:10 +0000
References: <20240724170452.16837-1-dongli.zhang@oracle.com>
In-Reply-To: <20240724170452.16837-1-dongli.zhang@oracle.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, si-wei.liu@oracle.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jul 2024 10:04:50 -0700 you wrote:
> This is to harden all of tap/tun to avoid any short frame smaller than the
> Ethernet header (ETH_HLEN).
> 
> While the xen-netback already rejects short frame smaller than ETH_HLEN ...
> 
>  914 static void xenvif_tx_build_gops(struct xenvif_queue *queue,
>  915                                      int budget,
>  916                                      unsigned *copy_ops,
>  917                                      unsigned *map_ops)
>  918 {
> ... ...
> 1007                 if (unlikely(txreq.size < ETH_HLEN)) {
> 1008                         netdev_dbg(queue->vif->dev,
> 1009                                    "Bad packet size: %d\n", txreq.size);
> 1010                         xenvif_tx_err(queue, &txreq, extra_count, idx);
> 1011                         break;
> 1012                 }
> 
> [...]

Here is the summary with links:
  - [net,1/2] tap: add missing verification for short frame
    https://git.kernel.org/netdev/net/c/ed7f2afdd0e0
  - [net,2/2] tun: add missing verification for short frame
    https://git.kernel.org/netdev/net/c/049584807f1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



