Return-Path: <bpf+bounces-52836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 543B1A48E6F
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 03:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0767A9354
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 02:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEA114375D;
	Fri, 28 Feb 2025 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otQ+Vh2O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793042F37;
	Fri, 28 Feb 2025 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708952; cv=none; b=quzdxxh7VF7l6Yyn5GqZ1hMQUZ8obAk+YusvrZr3GocGUZVtbG1bBT3QmcCvxvUVq1WmdikIgmaLAIggDnzvaPdkjiOFpkVUuNZwe5fRhIQkat5GVBOfKgn+tQjltpswbqBeeKFeGF8MHWrSxkgyjddaDoKhUIAn8jztQPuYVOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708952; c=relaxed/simple;
	bh=4vQwX6AqJ6dlNwK2Yq55c2nDqD8BOonS119QXzs28cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDeVCONyFl4HIyBIBaNkOHNW1ES9EcAPg6sHoRluizGALsRPCxJPKm8BpFih0lRQOadb4IgyWqUzXrVdzGGbeRSGEJ0RfZrDPDmjXlG1wTFT3btnvb5lA5UDuENw+vtgH7v8+kVLN6TIdzxoe6ZI0eBwl0bmAFhMRA7/fzwyUK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otQ+Vh2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99AAC4CEDD;
	Fri, 28 Feb 2025 02:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740708951;
	bh=4vQwX6AqJ6dlNwK2Yq55c2nDqD8BOonS119QXzs28cQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=otQ+Vh2O/0zvPXfsp8NIol+zuQGEnYbWZnLOYmcX93at3/Ocij07aq7TXGZwI6cX6
	 koYbjA8BBK2KrG6DLzyXGP4A1WyHJsjZMOxoVp0rBLJU/aw+vA/gnFxbW2Sj+rhi57
	 7qMiwdXAR4a1xL82eF0qy1p/ujxQKYQDSpqgW1fLjBz7PByIKoniNDIn9DuuOJd4GD
	 Vv2BWw+C7QqgVdT2Ts8TfnRKGFLvJCMlx5sPTrv2iIeI8AKsGkbargv3DG7sDBG4/E
	 8EELXiY7K2SrXh6bmc8pE/SOoiRqu3Rm2TpZIbhCcmT69XfPPZnVozvvFd8UOwGILV
	 /OPBetdR/mlhA==
Date: Thu, 27 Feb 2025 18:15:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <zhangkun09@huawei.com>,
 <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Gaurav Batra <gbatra@linux.ibm.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, IOMMU <iommu@lists.linux.dev>, MM
 <linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next v10 0/4] fix the DMA API misuse problem for
 page_pool
Message-ID: <20250227181550.07e429f5@kernel.org>
In-Reply-To: <20250226110340.2671366-1-linyunsheng@huawei.com>
References: <20250226110340.2671366-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 19:03:35 +0800 Yunsheng Lin wrote:
> This patchset fix the dma API misuse problem as below:
> Networking driver with page_pool support may hand over page
> still with dma mapping to network stack and try to reuse that
> page after network stack is done with it and passes it back
> to page_pool to avoid the penalty of dma mapping/unmapping.
> With all the caching in the network stack, some pages may be
> held in the network stack without returning to the page_pool
> soon enough, and with VF disable causing the driver unbound,
> the page_pool does not stop the driver from doing it's
> unbounding work, instead page_pool uses workqueue to check
> if there is some pages coming back from the network stack
> periodically, if there is any, it will do the dma unmmapping
> related cleanup work.

Does not build :( Always do an allmodconfig build when working 
on subsystem-wide interfaces..
-- 
pw-bot: cr

