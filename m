Return-Path: <bpf+bounces-31987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA316905F22
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 01:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42811282C82
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 23:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750321384AB;
	Wed, 12 Jun 2024 23:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCV9i/oB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C9137764;
	Wed, 12 Jun 2024 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234413; cv=none; b=XoZY1RUlA/bO9d9ULMlvcI8Q0sa6Rmk9bda5ho2K+4OuMIL3HaJ6+tXew7JfLAUeFlw7sqQ+PlNNabgycNEXgXRew0G40C+Yo1foUq8DUU9L6vybZzyGv4YDx4KhrJPUiDnGfY0bH2fT2wQbZLL7HQX4cxbLyNd0fYfOkxxoxlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234413; c=relaxed/simple;
	bh=UDrI0F5KV/9ovRICjoS5zPANsTImRtazeAvvDbooCVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYT9zQXXCJfZSATnHyXaKOnUYwngFNgx2GfE/uCzEgi/ARoioZv/SKZtZftacfdaWxuwWLOMJ532g/JbaffeQkCY6OFP/e6egcRp1CewawU5z7jPG7O+Nx37i+5lmj9Guf/eeoqxdAwCoXAx/lUmBVwdfr4EZtZtFHGDEnG8GGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCV9i/oB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECFBC116B1;
	Wed, 12 Jun 2024 23:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718234412;
	bh=UDrI0F5KV/9ovRICjoS5zPANsTImRtazeAvvDbooCVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JCV9i/oBcV0PgaQEk0I/j+pkGswr2wdwjvbbFTF0Iqdw+ljtm+2jx1/7Ej7CIiVUY
	 AvfkYyOeQqzHH0oPl9bswzfeCiJg8jkgiewkC7GnAz3VpyiT+Fnit0t/OOEbTlJUsH
	 dZrIWvAJjHJGZ+l8CEhhR5cSQnMAMuKWf+J3iJJcz1FBqO7vw4CdPSK1/dnjNnkJhc
	 cZ0v6XhAimZjfRwKHw7tT6NeWHumd2F2R+NAnu19nIgHS2qjKpqDla2H/AOM16Ynob
	 /PR/2Xx0qOQKn/LuDO05lctdGsuACwgYUeJA7yjhQODczN0mX6WNCElL0+2NgCWsgj
	 y+7Rwdaz+lLhA==
Date: Wed, 12 Jun 2024 16:20:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/15] virtio_ring: introduce dma map api
 for page
Message-ID: <20240612162011.7f1d03a0@kernel.org>
In-Reply-To: <20240611114147.31320-2-xuanzhuo@linux.alibaba.com>
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
	<20240611114147.31320-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 19:41:33 +0800 Xuan Zhuo wrote:
> +/**
> + * virtqueue_dma_map_page_attrs - map DMA for _vq
> + * @_vq: the struct virtqueue we're talking about.
> + * @page: the page to do dma
> + * @offset: the offset inside the page
> + * @size: the size of the page to do dma
> + * @dir: DMA direction
> + * @attrs: DMA Attrs
> + *
> + * The caller calls this to do dma mapping in advance. The DMA address can be
> + * passed to this _vq when it is in pre-mapped mode.
> + *
> + * return DMA address. Caller should check that by virtqueue_dma_mapping_error().

You gotta format the return value doc in a kdoc-sanctioned way.
please run ./scripts/kernel-doc -none -Wall to find such issues

> + */
> +dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
> +					size_t offset, size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs)

