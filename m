Return-Path: <bpf+bounces-60071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D39AD2489
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 18:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E001890FA6
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419D21CA03;
	Mon,  9 Jun 2025 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olFgYI+X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279D921ABD5;
	Mon,  9 Jun 2025 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488306; cv=none; b=VV3y7rXEKccpqLMJJyoukmghXpvY/1qI+GxfA/GcgyWxad7MMxxPYmHujSXV4LgFu2h2UxlOZrPtRgsgWNdKWQOy201Jo4256nS2pW803bMcPtjMf0lk5fsR2YErUqEnyFDvVAiTBm6JH5B/YDWuUUhvYL35bMyrSgC5CP98u+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488306; c=relaxed/simple;
	bh=7/+fV92PI7N/anDBZpoLsl+SgkUsOs/cO+aD/zBKOxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlqrH/xdrK8hrG9AJKrrl3smKXr52TNYnPIMquQQi8SORKXl7CmLgZXUvfKRGuG+/3x6CmiBTuJpfD1Rbz1Gzg8NpwfvIVoUbRF1+Adujad65w4RmRNwXgUnYflLy6no29J53xIxxc+80K/jGCiHzsLRtCTFroTuv/wVlp/+gZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olFgYI+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34523C4CEEF;
	Mon,  9 Jun 2025 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749488305;
	bh=7/+fV92PI7N/anDBZpoLsl+SgkUsOs/cO+aD/zBKOxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=olFgYI+Xa7Iccb/yQOL5irrKAL5EBQwtXKpB0/zVT+oIWHVwVTJFP1ZzS3p/xuWgc
	 fMn/NEPGDYyrPLKJwj8kM/JZiJuo6o54VGkkytyvsMYzPSnTG7mE26GwHPRJYmHnuf
	 H3llsd5tecQJUoLJNwnS1vzPJCO1pxZmlrV2RRlmD7tDzpXW7vlAxN0TGigQKemRWt
	 izEsmZ4ZRc2DjafRVcO8s7zcEpf9w1XofUU5g2yXZQngsOYu/j+UHhfPHzQqEd9fra
	 CkalzekrVkDXZx4bRy7QNymi14ZnJ2DgnjOSUxiYqfn64VdEpT2wyIpUNAbDE454fs
	 oWLCCnKo33bVQ==
Date: Mon, 9 Jun 2025 09:58:24 -0700
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
Message-ID: <20250609095824.414cffa1@kernel.org>
In-Reply-To: <f073b150-b2e9-43db-aa61-87eee4755a2f@gmail.com>
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
	<dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
	<f6d7610b-abfe-415d-adf8-08ce791e4e72@gmail.com>
	<20250605074810.2b3b2637@kernel.org>
	<f073b150-b2e9-43db-aa61-87eee4755a2f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Jun 2025 22:48:53 +0700 Bui Quang Minh wrote:
> >> But currently, if a multi-buffer packet arrives, it will not go through
> >> XDP program so it doesn't increase the stats but still goes to network
> >> stack. So I think it's not a correct behavior.  
> > Sounds fair, but at a glance the normal XDP path seems to be trying to
> > linearize the frame. Can we not try to flatten the frame here?
> > If it's simply to long for the chunk size that's a frame length error,
> > right?  
> 
> Here we are in the zerocopy path, so the buffers for the frame to fill 
> in are allocated from XDP socket's umem. And if the frame spans across 
> multiple buffers then the total frame size is larger than the chunk 
> size.

Is that always the case? Can the multi-buf not be due to header-data
split of the incoming frame? (I'm not familiar with the virtio spec)

> Furthermore, we are in the zerocopy so we cannot linearize by 
> allocating a large enough buffer to cover the whole frame then copy the 
> frame data to it. That's not zerocopy anymore. Also, XDP socket zerocopy 
> receive has assumption that the packet it receives must from the umem 
> pool. AFAIK, the generic XDP path is for copy mode only.

Generic XDP == do_xdp_generic(), here I think you mean the normal XDP
patch in the virtio driver? If so then no, XDP is very much not
expected to copy each frame before processing.

This is only slightly related to you patch but while we talk about
multi-buf - in the netdev CI the test which sends ping while XDP
multi-buf program is attached is really flaky :(
https://netdev.bots.linux.dev/contest.html?executor=vmksft-drv-hw&test=ping-py.ping-test-xdp-native-mb&ld-cases=1

