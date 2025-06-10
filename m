Return-Path: <bpf+bounces-60237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A02AD4403
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 22:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7088C7ABA01
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 20:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B846266B59;
	Tue, 10 Jun 2025 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx7c4Q70"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD144685;
	Tue, 10 Jun 2025 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587872; cv=none; b=WZx6oKesp8klDcTV34AcsjVQCWea3rdzSAsGGrj+uK/MLJgMMs+taXTN9CcFk9FpPOotZpsRZTvPV7cpxHL8nmbjDPWjtNthTb1ArDS56gWeHv2N8LPxGmhrVKYKRhDtmgGUNYaxlVCwnYMtFILuRl1JjiLCH2OOA7GLpJ9XTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587872; c=relaxed/simple;
	bh=lqS9H5+bZRu73v+RaI1FVxS30dUDinfTEKGWKKl2qec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJFdwuMOy6LPZCuowOL8BPT9lSCxnnHS/iyPnWXm3SH4515VTLqJRiSgulUwFxAC7VDE0Y75fHUXepmp5vLXxnq/T+l0Jw9vY7I1UwAJkZbC6rNnIRZiowE6dtDW2Da36oYJ9wRcBXMSbp2YZmJ0BlJyJ06RKpMnLyWTi9boarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx7c4Q70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70215C4CEED;
	Tue, 10 Jun 2025 20:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749587872;
	bh=lqS9H5+bZRu73v+RaI1FVxS30dUDinfTEKGWKKl2qec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nx7c4Q70Nygv3x0k02CwqcdeYFxM6/hCVRrUFZJ2u58bCnj2OX2V9KoWx/XdY/gVd
	 /rrk4iMjGG2qO8rCsUtOFdiJa7KvnvLz+LMGMw/vvDhXwKZY+b2ERGIdcqdB1Jt1YI
	 rd8vbj0I2WICZicYGk4vfYxy2QW/7QrkfcYcUV6u0SSqBrtGnBpLy+7nOd3j4riffK
	 mzXqyXFyr1y7wHLpvN0LDhKLyaX7W9KFB5O9l/thEmfWQIZf4A13dx5Pg8dD+BTNGR
	 XP/Jen/MqUIRr7FdLznr4RXMFIHb096WTKmJMTmwvIHXiSlhCmz0OAqrB7VOC2l/JR
	 dl64y7pQUQJtg==
Date: Tue, 10 Jun 2025 13:37:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
Message-ID: <20250610133750.7c43e634@kernel.org>
In-Reply-To: <e2de0cd8-6ee2-4dab-9d41-cfe5e85d796d@gmail.com>
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
	<dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
	<f6d7610b-abfe-415d-adf8-08ce791e4e72@gmail.com>
	<20250605074810.2b3b2637@kernel.org>
	<f073b150-b2e9-43db-aa61-87eee4755a2f@gmail.com>
	<20250609095824.414cffa1@kernel.org>
	<e2de0cd8-6ee2-4dab-9d41-cfe5e85d796d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 22:18:32 +0700 Bui Quang Minh wrote:
> >> Furthermore, we are in the zerocopy so we cannot linearize by
> >> allocating a large enough buffer to cover the whole frame then copy the
> >> frame data to it. That's not zerocopy anymore. Also, XDP socket zerocopy
> >> receive has assumption that the packet it receives must from the umem
> >> pool. AFAIK, the generic XDP path is for copy mode only.  
> > Generic XDP == do_xdp_generic(), here I think you mean the normal XDP
> > patch in the virtio driver? If so then no, XDP is very much not
> > expected to copy each frame before processing.  
> 
> Yes, I mean generic XDP = do_xdp_generic(). I mean that we can linearize 
> the frame if needed (like in netif_skb_check_for_xdp()) in copy mode for 
> XDP socket but not in zerocopy mode.

Okay, I meant the copies in the driver - virtio calls
xdp_linearize_page() in a few places, for normal XDP.

> > This is only slightly related to you patch but while we talk about
> > multi-buf - in the netdev CI the test which sends ping while XDP
> > multi-buf program is attached is really flaky :(
> > https://netdev.bots.linux.dev/contest.html?executor=vmksft-drv-hw&test=ping-py.ping-test-xdp-native-mb&ld-cases=1  
> 
> metal-drv-hw means the NETIF is the real NIC, right?

The "metal" in the name refers to the AWS instance type that hosts 
the runner. The test runs in a VM over virtio, more details:
https://github.com/linux-netdev/nipa/wiki/Running-driver-tests-on-virtio

