Return-Path: <bpf+bounces-28658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0127B8BCAFD
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 11:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36040B23072
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 09:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF101428FE;
	Mon,  6 May 2024 09:43:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344251422D9;
	Mon,  6 May 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988594; cv=none; b=c8KR2uKnqKFV/WfVDBDA74fH6OrVVogl5R8zhlQ6suaA94U4SkHxZVP33WVjWLGS2r7OsfbPvEzYjUKqsgbFGxFSt6U8po3wjPJl3OkBYRoHnPyrGKv/CBsIAbtXfTW+7sV9BNA83mht6YTuw+NARVDu4ldH32Kp2EyCtyHxKwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988594; c=relaxed/simple;
	bh=Dc1he8KliFyn72dwt6jjIPHSck1MkRS37mCpPXbzJYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sieAFyj4x82DBBhfMHKZUGIBWPV2WyZl083XiDySq/KwDfT/NiPZT8yQe+bgSM/9gArBp47ob6HW2xOvra73E+klfd8q2WQk+K816/l0DTM2GVIOnGbna9yOHS5q/DwsazMPfvhwI4g+zHrzen8alnrSC1eVNJf+nfy6VnERPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3CE0B227A87; Mon,  6 May 2024 11:43:08 +0200 (CEST)
Date: Mon, 6 May 2024 11:43:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 6/7] page_pool: check for DMA sync shortcut
 earlier
Message-ID: <20240506094308.GA19025@lst.de>
References: <20240423135832.2271696-1-aleksander.lobakin@intel.com> <20240423135832.2271696-7-aleksander.lobakin@intel.com> <81df4e0f-07f3-40f6-8d71-ffad791ab611@intel.com> <20240426050229.GA4548@lst.de> <20240502055855.GA28572@lst.de> <e92d281c-366c-4bd9-849a-ead484a61545@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e92d281c-366c-4bd9-849a-ead484a61545@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 06, 2024 at 11:38:17AM +0200, Alexander Lobakin wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Thu, 2 May 2024 07:58:55 +0200
> 
> > Hi Alexander,
> > 
> > do you have time to resend the series?  I'd love to merge it for
> > 6.10 if I can get the updated version ASAP.
> 
> Hi!
> 
> Sorry, I was on a small vacation.
> Do I still have a chance to get this into 6.10?

If I can get it merged by tomorrow, yes.

