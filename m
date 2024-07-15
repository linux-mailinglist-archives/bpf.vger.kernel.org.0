Return-Path: <bpf+bounces-34791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2EF930D10
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 05:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253522813F4
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 03:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9091836E6;
	Mon, 15 Jul 2024 03:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcNJezyF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6201369B6;
	Mon, 15 Jul 2024 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721014835; cv=none; b=FQuWi573sIx+5v0/p3mIEXMEH7N1khrUbvewo7zUK3pvsbB2x48P4Iym8DuAPy9BtFdXKZZNaOi4H3XZW28FZ49fb1MsI+UgIQpEkOpiFWvFtZsq0rdSbWVuM3OfP+20Nk+jz/HmG0sYXUbOk+nA2+LKc9teoV/FKmmbDoCqWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721014835; c=relaxed/simple;
	bh=PDJuxP6Ik0GQFxu6cyp8erirAQhjhmcqoIGkf+qYnn0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kh83ITXxWGOC1h8OfylC5JqkkQLN3EqcQlS+cNp8O9OzoCYx3EYOnrFpUYtr9dd1YLvi4uglGFNVYwxwPhbXnxQ7ai9iGeBQwpkfJrEgc0vf/+AA12x7DJ4/prrPiMmOG71tdAoiL/gHiX6f4Mr3op9oxVpju0hnnI6yMrQrOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcNJezyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59E4EC4AF0B;
	Mon, 15 Jul 2024 03:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721014835;
	bh=PDJuxP6Ik0GQFxu6cyp8erirAQhjhmcqoIGkf+qYnn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dcNJezyFy7sGaRUDLtT8Pxr+3WTQr8OJZw6frEz/TqkFSpCzdT+o4turBjLVQqNPq
	 U8QOIgtq4nZ1jlJhtoeJMYi/AzBZpju5huSrnRFvBRDmGoOhpYwr6VwHsH5JHu6Qt6
	 +q9ITYniOQ+uWQU3CZTGRyj4kGt/9Hloul3Y7QiC3GYvI0obtHnKbn0nqj2vAJ3az4
	 TjmX5Es/YdvFSRCgmh6dX6m62oh3bSgudECiN3OI/8SJRGy1AI6KdsvNUvBN/b/XBH
	 DvohuT6KaY14Xo6UzRh1eJ9h7KKbP+uV+n2pK9HgXm5yk57PolVvkB0WsdHDF4SlXV
	 h7AAAzkgtCb2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43936C43614;
	Mon, 15 Jul 2024 03:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 00/10] virtio-net: support AF_XDP zero copy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172101483527.5253.18173513079187430530.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 03:40:35 +0000
References: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, virtualization@lists.linux.dev,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jul 2024 19:25:27 +0800 you wrote:
> v8:
>     1. virtnet_add_recvbuf_xsk() always return err, when encounters error
> 
> v7:
>     1. some small fixes
> 
> v6:
>     1. start from supporting the rx zerocopy
> 
> [...]

Here is the summary with links:
  - [net-next,v8,01/10] virtio_net: replace VIRTIO_XDP_HEADROOM by XDP_PACKET_HEADROOM
    https://git.kernel.org/netdev/net-next/c/41d4a174201e
  - [net-next,v8,02/10] virtio_net: separate virtnet_rx_resize()
    https://git.kernel.org/netdev/net-next/c/47879b7322fa
  - [net-next,v8,03/10] virtio_net: separate virtnet_tx_resize()
    https://git.kernel.org/netdev/net-next/c/391aa2aad022
  - [net-next,v8,04/10] virtio_net: separate receive_buf
    https://git.kernel.org/netdev/net-next/c/c86c120fde29
  - [net-next,v8,05/10] virtio_net: separate receive_mergeable
    https://git.kernel.org/netdev/net-next/c/5db481059d79
  - [net-next,v8,06/10] virtio_net: xsk: bind/unbind xsk for rx
    https://git.kernel.org/netdev/net-next/c/09d2b3182c8e
  - [net-next,v8,07/10] virtio_net: xsk: support wakeup
    https://git.kernel.org/netdev/net-next/c/19a5a7710ee1
  - [net-next,v8,08/10] virtio_net: xsk: rx: support fill with xsk buffer
    (no matching commit)
  - [net-next,v8,09/10] virtio_net: xsk: rx: support recv small mode
    https://git.kernel.org/netdev/net-next/c/a4e7ba702701
  - [net-next,v8,10/10] virtio_net: xsk: rx: support recv merge mode
    https://git.kernel.org/netdev/net-next/c/99c861b44eb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



