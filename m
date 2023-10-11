Return-Path: <bpf+bounces-11927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044AA7C5829
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838B8282277
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562E208C9;
	Wed, 11 Oct 2023 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bcp/JOIA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84519BDF;
	Wed, 11 Oct 2023 15:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8486DC433C7;
	Wed, 11 Oct 2023 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697038579;
	bh=lTq1DkG7l+QHbQBfr/sAWfclw9fYk69n6jbHGMTIKvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bcp/JOIA9l1V1uVU1FUbmq0Pqf6ndX+uIezQSz1L/ygwBQ1JSnAur/Abq56GCrHgR
	 wm6Yku1xyZegc67Mp5b1n8rlqPDRplqtPaHXyGo5hj0mGDVr0mpv0VEU7tjiVOyDpy
	 4iG2/mZTyp9YRmpCiFzGLklBIEqA5locMQH4RRgiBZwLnKLk0qa8LgZyqa2mpNpFSf
	 xTz2/scGbNti2vmRU2Iju+xBGxQTklEfCaV/yAXr/b522Fn8AkRrbxUflhsRy1Syfc
	 QOxJtrpbObzH7w37wQNqdz1ct4rbsZ+uxorFZGqMQs9f764duHDqMTwFhSXr4qcs+Q
	 E9jhx8hXs9Qtw==
Date: Wed, 11 Oct 2023 08:36:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v10 0/6] introduce page_pool_alloc() related
 API
Message-ID: <20231011083617.61bba987@kernel.org>
In-Reply-To: <20230922091138.18014-1-linyunsheng@huawei.com>
References: <20230922091138.18014-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Sep 2023 17:11:32 +0800 Yunsheng Lin wrote:
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

Could you rebase & repost? Patches no longer apply :(


