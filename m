Return-Path: <bpf+bounces-13091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FB77D4570
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 04:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D1B2817BA
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8447A7486;
	Tue, 24 Oct 2023 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy3/JmEH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55779C2;
	Tue, 24 Oct 2023 02:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8A9C433C7;
	Tue, 24 Oct 2023 02:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698114276;
	bh=b07IW6onHHyGfMZgKFIvnNFhOtkZkOOgJ9t2POWbmRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oy3/JmEHd9Z4kheIA9EKM6UApScmCdcCisvBFeijpylMGB9icb/ybF52szjNEsFNK
	 BsDsG6dV6iarpwc9ZpoPPBdwWYgB41lj5TEae4bLE8kbQEcHkip9FzEN+b4KLUPeNi
	 i/7kjU2HPzxUEnOtIVHsNSjxXqYT2aqUe0rZg7IWJjhpVtiGthUOTgkYhdBN5UcnZv
	 CYMNlJRywkXhSd7ef0W1v2d8kqo/XIiSKIOQfYCIuiU88NDnmL9ZDP0q6HfH/XS1NA
	 h+J821kmQdxrA/lY5pS3jvkT49rmvS8t0X1TMWLmV2TK+lFExT0LGsNX76dS73YFZv
	 5h2gbbKLSqDZA==
Date: Mon, 23 Oct 2023 19:24:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next v12 0/5] introduce page_pool_alloc() related
 API
Message-ID: <20231023192434.40f5ee98@kernel.org>
In-Reply-To: <20231020095952.11055-1-linyunsheng@huawei.com>
References: <20231020095952.11055-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 17:59:47 +0800 Yunsheng Lin wrote:
> In [1] & [2] & [3], there are usecases for veth and virtio_net
> to use frag support in page pool to reduce memory usage, and it
> may request different frag size depending on the head/tail
> room space for xdp_frame/shinfo and mtu/packet size. When the
> requested frag size is large enough that a single page can not
> be split into more than one frag, using frag support only have
> performance penalty because of the extra frag count handling
> for frag support.
> 
> So this patchset provides a page pool API for the driver to
> allocate memory with least memory utilization and performance
> penalty when it doesn't know the size of memory it need
> beforehand.

I don't mean to cut off the discussion, if any is still to happen.
But AFAIU we have a general agreement that this is a good direction,
we're at v12 already, and it's getting late in the release cycle.
To give this series a chance of making v6.7 I will apply it now.
If there are any unresolved concerns in a couple of days we can drop it.

