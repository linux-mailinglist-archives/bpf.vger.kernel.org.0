Return-Path: <bpf+bounces-45007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D23599CFC6A
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 04:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9160C28742B
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 03:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8232A18C933;
	Sat, 16 Nov 2024 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTg7Ye7X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E981A28F4;
	Sat, 16 Nov 2024 03:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731726024; cv=none; b=HUyXBnXGyTdXAdQP00LlUR/EwM3n2qCBGUYHDo5k7+EoQUxriLR1TZovYxuBsrisB4VI9b+uo0HqmEN96ZTPDaQ1fdjUQCdrwpSK3g2A8qDQPAxEeZ1CZ1xYSR9stKbAlV31dCzbcjnkYk7s2lxBaEL4VmRq6eePybIChyPa2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731726024; c=relaxed/simple;
	bh=tz0m8+RKXLWlVPvtju5AQulzjFo2nyhiUBLpbU10i0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aOwItNdrhuKOLjpsqP3kw7WvqRbCkpfUx7phYFzYgEYfbse71c8khcnY/9dbKbJWeGyjiK3YFv+KLB9DrV5g1ntcqKt0ptSsedAZw2JMNcV8fMwG9I1bhWRzPfgMZrhz179CJaTd9VaVMEE/MhzKXK4E+ZL+Tgmt2D11MewAd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTg7Ye7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63480C4CECF;
	Sat, 16 Nov 2024 03:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731726023;
	bh=tz0m8+RKXLWlVPvtju5AQulzjFo2nyhiUBLpbU10i0A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mTg7Ye7Xyii++4hI9BOIMOgfE2OBHWYQOqG9hJ1DD/7H0UBUUYi+0i0QasdYX/9AB
	 SMq9f/jeCqaXEu0tfkVt4AxRA9WlMHt3e778G9VWe/TGZitihoZbEq5sC1EcFuatXP
	 De8r/YTn/2HO/s8J0vnNUEfB0cANwhMFmGox0Cfld1FLigeMEEU0Q5LTp8eTNgjifo
	 kwjeyk8J/81jUoTr6eTT4fD1ApJCLvBInVJu7FtXY4u+E6N400tYyXqMmaa0MhOqBI
	 R7Fvxwb10ZBkJzSAHPAH08fhIdZG/gt0+zG+CFm4Ayfr+U4Ni6Dcc85XBpKU23QgZ+
	 ccJXEiS4h4/fQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA03809A80;
	Sat, 16 Nov 2024 03:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/13] virtio-net: support AF_XDP zero copy (tx)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173172603424.2805728.3396843307366937196.git-patchwork-notify@kernel.org>
Date: Sat, 16 Nov 2024 03:00:34 +0000
References: <20241112012928.102478-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241112012928.102478-1-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 virtualization@lists.linux.dev, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Nov 2024 09:29:15 +0800 you wrote:
> v4:
>     1. rebase net-next
>     2. update the kdoc for the new APIs
> 
> v3:
>     1. use sg_dma_address/length api to set the premapped sg
>     2. remove 'premapped' parameter from the new APIs
>     3. tweak the comment of commit #2,#3
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/13] virtio_ring: introduce vring_need_unmap_buffer
    https://git.kernel.org/netdev/net-next/c/9f19c084057a
  - [net-next,v4,02/13] virtio_ring: split: record extras for indirect buffers
    https://git.kernel.org/netdev/net-next/c/bc2b4c3401c6
  - [net-next,v4,03/13] virtio_ring: packed: record extras for indirect buffers
    https://git.kernel.org/netdev/net-next/c/aaa789843a93
  - [net-next,v4,04/13] virtio_ring: perform premapped operations based on per-buffer
    https://git.kernel.org/netdev/net-next/c/c7e1b422afac
  - [net-next,v4,05/13] virtio_ring: introduce add api for premapped
    https://git.kernel.org/netdev/net-next/c/3ef66af31fea
  - [net-next,v4,06/13] virtio-net: rq submits premapped per-buffer
    https://git.kernel.org/netdev/net-next/c/31f3cd4e5756
  - [net-next,v4,07/13] virtio_ring: remove API virtqueue_set_dma_premapped
    https://git.kernel.org/netdev/net-next/c/880ebcbe0663
  - [net-next,v4,08/13] virtio_net: refactor the xmit type
    https://git.kernel.org/netdev/net-next/c/7db956707f5f
  - [net-next,v4,09/13] virtio_net: xsk: bind/unbind xsk for tx
    https://git.kernel.org/netdev/net-next/c/21a4e3ce6dc7
  - [net-next,v4,10/13] virtio_net: xsk: prevent disable tx napi
    https://git.kernel.org/netdev/net-next/c/1df5116a41a8
  - [net-next,v4,11/13] virtio_net: xsk: tx: support xmit xsk buffer
    https://git.kernel.org/netdev/net-next/c/89f86675cb03
  - [net-next,v4,12/13] virtio_net: update tx timeout record
    https://git.kernel.org/netdev/net-next/c/e2c5c57f1af8
  - [net-next,v4,13/13] virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
    https://git.kernel.org/netdev/net-next/c/37e0ca657a3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



