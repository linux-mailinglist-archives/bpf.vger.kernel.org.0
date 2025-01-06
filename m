Return-Path: <bpf+bounces-48033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679ACA03397
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 00:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77453A5355
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15961E25E8;
	Mon,  6 Jan 2025 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THtnK84Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F919049B;
	Mon,  6 Jan 2025 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736207517; cv=none; b=R+aasfcEigEtLc74E8DbLdP4rFwotnxupZQCE7cD8DIkRnRpTodMjuzw0n3/mtfYtJY+9hzPVjYVlIoxzFAz9t0CuDmVKx4xDbTLKQ0TzqdyIuQrN7cW8NJwqUaZ3ATP2v7l45ildymlzWdYRb5GPP6hH+uLB6847sh+Et2sphk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736207517; c=relaxed/simple;
	bh=Fu660IWX5S6t38fvF4BJ3mJpDywwH3eUN5CgaE2RF48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATMY/GxgtOjMWs9Q1L7mHw+FJLgAai7RoVhFACu4AQNW3E4y2t4tfN+iOEc+ibb78yiT37Q+HvRt9YOQ9/va50r2ezNBFvWnIAUnjCntMOl9hdeRABwgZKQ3HUFYsISEmYDHzQ0BU8ixeVwdFsCHx7aPYNfMxSN/w9R8ddeDq/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THtnK84Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA0C4CED2;
	Mon,  6 Jan 2025 23:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736207516;
	bh=Fu660IWX5S6t38fvF4BJ3mJpDywwH3eUN5CgaE2RF48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=THtnK84Q3Oz/4hr7raXMxtb5YnvUsRTP0Z19d7W1LrVc020uM7dHfZQfaxiTBglrb
	 0uuuv4Ij3lvMxNaYs2U4xkdM1Mx/sGjqu1JF+EzVap0/mx7qJl607iIVwFe7HlG/s7
	 X14tjNK13QKsu2ZiViNL1koaVJB20ifxb0W3EaYPXmPLvd3Yw+D43CTpT1bSdEobVq
	 enX3QqiM+fai2TD9PUP4jYCjrP+vp1tAnLo3Mv9k74nhRw+qMFF8RVBP1HKE/Gn7Dh
	 zUjVlCwE6j30/RjhJSLQ4oMUTU+dCUPoDR1ZtkaF7VWo4Bdbpz0SfAdBVCoaM5Jkwm
	 nSJEIl5AN0w9g==
Date: Mon, 6 Jan 2025 15:51:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <liuyonglong@huawei.com>,
 <fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, IOMMU <iommu@lists.linux.dev>, MM
 <linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next v6 0/8] fix two bugs related to page_pool
Message-ID: <20250106155154.7c349c67@kernel.org>
In-Reply-To: <20250106130116.457938-1-linyunsheng@huawei.com>
References: <20250106130116.457938-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jan 2025 21:01:08 +0800 Yunsheng Lin wrote:
> This patchset fix a possible time window problem for page_pool and
> the dma API misuse problem as mentioned in [1], and try to avoid the
> overhead of the fixing using some optimization.
> 
> From the below performance data, the overhead is not so obvious
> due to performance variations for time_bench_page_pool01_fast_path()
> and time_bench_page_pool02_ptr_ring, and there is about 20ns overhead
> for time_bench_page_pool03_slow() for fixing the bug.

This appears to make the selftest from the drivers/net target implode.

[   20.227775][  T218] BUG: KASAN: use-after-free in page_pool_item_uninit+0x100/0x130

Running the ping.py tests should be enough to repro.
-- 
pw-bot: cr

