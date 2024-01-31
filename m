Return-Path: <bpf+bounces-20842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09D584453F
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6046E1F249DE
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438D112F5A1;
	Wed, 31 Jan 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuKpwUpG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF9712F58B;
	Wed, 31 Jan 2024 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719986; cv=none; b=gisDFqdlll80jUVYA3Vvc/w+BNkwyMgi4P31iCYINn7udbNHw51ywFMLwgZG7AaaYVYDvOIgYDwZEcwOtKH6TlKaYuAlYh1JKFHG38DO9BI6vtvZQINJhcWywD3G2Wd5d+m3JY6BsfPYRUBiJXtjB+IJPz9HO3Ymva/ItkHoRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719986; c=relaxed/simple;
	bh=zy8loWPlJ2ue1zAlO45Uz6DlMoGbTgu9KTb2TSAx9Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF6cn84P/QV3dxqcSZo/PiVd306DCd8VHrlx3HEyRUXmkxrhOcIGkgEzN1zKls2e5wrMeAUjIzZUDuJ1Uux1k7CfkyNphjFVSqs8rjcfNvoENrZ/vQDgmNcDsoG/r041Yl0YFxduaKvNTVLZ5pyp5sTq9/mVTKY1Oi9w6N6i890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuKpwUpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED486C433C7;
	Wed, 31 Jan 2024 16:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706719986;
	bh=zy8loWPlJ2ue1zAlO45Uz6DlMoGbTgu9KTb2TSAx9Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuKpwUpGGfnUqH+2fMz5oQqgPYtX3W74FoLl2ZbQGgeOPWmKc9hM3Z+7XWpKqU953
	 WGLdeII21u1OcZMGbIUUOe/MH0JK87A4waxOJjcitWIjjB+vb/x/Nio1OoVNZEpu1J
	 zZ2Eac2xjV1toXWsOvl5777MshK/9fK9q40TUyJFolPu3GwsIT+bOpEz2WN5NAtClz
	 L/BZye/SSIA2i68ZUahanCs14gxwxViXk1X/BOScv2xpJVLazsVIpX18YkJ9n+LLzC
	 R/2xeZB9IEipsLsJUAe65ZC0JIvJOCTOj4wRIn7UMG5y/3E8owHLKH+xoLOwNA4yOm
	 xheeuNt3FXQIQ==
Date: Wed, 31 Jan 2024 17:52:58 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/7] dma: compile-out DMA sync op calls when not
 used
Message-ID: <20240131165258.GA401365@kernel.org>
References: <20240126135456.704351-1-aleksander.lobakin@intel.com>
 <20240126135456.704351-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240126135456.704351-2-aleksander.lobakin@intel.com>

On Fri, Jan 26, 2024 at 02:54:50PM +0100, Alexander Lobakin wrote:
> Some platforms do have DMA, but DMA there is always direct and coherent.
> Currently, even on such platforms DMA sync operations are compiled and
> called.
> Add a new hidden Kconfig symbol, DMA_NEED_SYNC, and set it only when
> either sync operations are needed or there is DMA ops or swiotlb
> enabled. Set dma_need_sync() and dma_skip_sync() (stub for now)
> depending on this symbol state and don't call sync ops when
> dma_skip_sync() is true.
> The change allows for future optimizations of DMA sync calls depending
> on compile-time or runtime conditions.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Hi Alexander,

This seems to cause x86_64 allmodconfig builds to fail:

 ../drivers/media/platform/ti/omap3isp/ispstat.c:82:35: error: ‘dma_sync_single_range_for_device’ undeclared (first use in this function); did you mean ‘dma_sync_sgtable_for_device’?
    82 |                                   dma_sync_single_range_for_device);
       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       |                                   dma_sync_sgtable_for_device
 ../drivers/media/platform/ti/omap3isp/ispstat.c:82:35: note: each undeclared identifier is reported only once for each function it appears in
 ../drivers/media/platform/ti/omap3isp/ispstat.c: In function ‘isp_stat_buf_sync_magic_for_cpu’:
 ../drivers/media/platform/ti/omap3isp/ispstat.c:94:35: error: ‘dma_sync_single_range_for_cpu’ undeclared (first use in this function); did you mean ‘dma_sync_sgtable_for_cpu’?
    94 |                                   dma_sync_single_range_for_cpu);
       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       |                                   dma_sync_sgtable_for_cpu

