Return-Path: <bpf+bounces-61023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A62ADFB1C
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 04:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652AB17FBD4
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 02:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654D8225777;
	Thu, 19 Jun 2025 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6CdYxqw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8E76034;
	Thu, 19 Jun 2025 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750299072; cv=none; b=qK0oC/0/hEs/CZWtiNmyPVqMQmHzoeJuA2cXxwF9cS+bKI6xHGusQjQOmlL4DfISe/6COT5rvMXKWTS75SQBodvSbSwvPARi4Rz/W1GFLyYzpw7bdug1ZDtja7rv4FWY9nO50ZETYbHkIhFbs4/0uOEatNefowyeVYvLKkHJfdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750299072; c=relaxed/simple;
	bh=MH8crp1DhW23/OKmNtZBXsV7bwbGco8MJctbSo83AO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOo/aOQUf+CBlRxoSxbzx1qR7mCX7woRNAKjxFu1bMMnVxXp75eyjGollbJFohkQdz0etH0Ps3kcNhPjpO+JtRZzs5LKv12i90APHNa09DA2tx0Dy6cF9A1PtOhv78XyHlphuSmKPTuZCynS25BDBez5wrJ5uEw0ThQElPwaaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6CdYxqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1BDC4CEE7;
	Thu, 19 Jun 2025 02:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750299072;
	bh=MH8crp1DhW23/OKmNtZBXsV7bwbGco8MJctbSo83AO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W6CdYxqwN/NBljKsxlJlQh1OdGAEzo0+mfdv4gr+uFBkTq3Ih3rbplQhPvMVI6Ijq
	 6W2sTe3RzvcnrXZGvBGR/QMmFeNp9tKQs1D3wFECVPF9oH53M8s1qaXk5DGvW4mmln
	 lImovZffVl5q900PmwgF0tidZSOpykcCQt/jins4zwLxBPFuvsXd1w6DFv5DcS3W54
	 PyMcTHXj/MKeuH8X+RO0u98h7UxdhnAXaYZUqzpEzQmD0zL47uKVKE2bmADoTglVPI
	 omisZagomvBwO8IWBoG7h+UoeOZOMRELh7hCRMddk/bGYqJQkzMZ/Hu6QpV4cAOFiy
	 GLcI/UtzZARqg==
Date: Wed, 18 Jun 2025 19:11:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 1/2] virtio-net: xsk: rx: fix the frame's length
 check
Message-ID: <20250618191111.29e6136e@kernel.org>
In-Reply-To: <20250615151333.10644-2-minhquangbui99@gmail.com>
References: <20250615151333.10644-1-minhquangbui99@gmail.com>
	<20250615151333.10644-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Jun 2025 22:13:32 +0700 Bui Quang Minh wrote:
> +/**
> + * buf_to_xdp() - convert the @buf context to xdp_buff
> + * @vi: virtnet_info struct
> + * @rq: the receive queue struct
> + * @buf: the xdp_buff pointer that is passed to virtqueue_add_inbuf_premapped in
> + *       virtnet_add_recvbuf_xsk
> + * @len: the length of received data without virtio header's length
> + * @first_buf: this buffer is the first one or not
> + */
>  static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> -				   struct receive_queue *rq, void *buf, u32 len)
> +				   struct receive_queue *rq, void *buf,
> +				   u32 len, bool first_buf)

I think Michael mention he's AFK so while we wait could you fix this
kdoc? I'm not sure whether the kdoc is really necessary here, but if
you want to keep it you have to document the return value:

Warning: drivers/net/virtio_net.c:1141 No description found for return value of 'buf_to_xdp'
-- 
pw-bot: cr

