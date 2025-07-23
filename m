Return-Path: <bpf+bounces-64202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD93B0FA34
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 20:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EAC96481D
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AC822D9F3;
	Wed, 23 Jul 2025 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SqOc9gRz"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EE0224B07;
	Wed, 23 Jul 2025 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294951; cv=none; b=HhMmaXVDJzo2RePPV5SH1vQv8/Vc4kFgwL2TCzlyY2oHUDSwmc2IgXrdxVOXc3V0xqGQFAbdwLOWonfpGasYFXKOdxv08UXsJvKMM8jVcB3BKIh1jextZ8V20mTb8BwW+Fsi/zGwckX3nh8ercpgT83hmxn4oVZAXD37Jwg/HUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294951; c=relaxed/simple;
	bh=rxt64hmEfXGDpk+90Gt/zaDz2ey8jjpQyAtFOj/qsD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS5hXj5yxZZ2XLJrv0ZjfyGZj4AwaxpXccL9aBOQVM3OBghiYghZSNb/IGeF1+3UdwATHq8tzHLD7uKfQzqvYTV6b3fEmU2maXojHc4HftBMm9UZumH18MgH37AJY6QDTAaPKZpvA4YKcLsS7C7MJi1vTlDjq3hgCFtpfVa2r04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SqOc9gRz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 528AF202186F; Wed, 23 Jul 2025 11:22:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 528AF202186F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753294944;
	bh=97R2aoDUcHgnNx84Rvmur00qbaItR6hrznKaMPHKy9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqOc9gRz4MLyhDiCdEu+cqoXt1Dbn/5Mglo1Yvj12hpgclQBcSwtgcNjJk6dAGqUz
	 Ml2J+2araiRX7EiA1lYQnVb2Ut5nU1LgFw/Bcl2xxh27KnRWos2KcZw5cf6GEB+gih
	 l5Gf6uG6QOgcKq7KD9DwcjH57h619rrWv3jpEc5I=
Date: Wed, 23 Jul 2025 11:22:24 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: kuba@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org,
	michal.kubiak@intel.com, ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
	rosenp@gmail.com, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] net: mana: Use page pool fragments for RX buffers
 instead of full pages to improve memory efficiency and throughput.
Message-ID: <20250723182224.GA25631@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250721101417.GA18873@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <1d18f7dc-eca5-4daa-98fb-5c8d20ef6ac4@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d18f7dc-eca5-4daa-98fb-5c8d20ef6ac4@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Jacob,

Thanks for the review, I tested this patch previously
for 4kb page size systems. The throughput improvement is around
10 to 15%. Also sligthly better memory utilization as for
typical 1500 MTU size we are able to fit 2 Rx buffer in
a single 4kb page as compared to 1 per page previously.

Thanks
Dipayaan Roy 

On Mon, Jul 21, 2025 at 04:51:10PM -0700, Jacob Keller wrote:
> 
> 
> On 7/21/2025 3:14 AM, Dipayaan Roy wrote:
> > This patch enhances RX buffer handling in the mana driver by allocating
> > pages from a page pool and slicing them into MTU-sized fragments, rather
> > than dedicating a full page per packet. This approach is especially
> > beneficial on systems with 64KB page sizes.
> > 
> > Key improvements:
> > 
> > - Proper integration of page pool for RX buffer allocations.
> > - MTU-sized buffer slicing to improve memory utilization.
> > - Reduce overall per Rx queue memory footprint.
> > - Automatic fallback to full-page buffers when:
> >    * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
> >    * The XDP path is active, to avoid complexities with fragment reuse.
> > - Removal of redundant pre-allocated RX buffers used in scenarios like MTU
> >   changes, ensuring consistency in RX buffer allocation.
> > 
> > Testing on VMs with 64KB pages shows around 200% throughput improvement.
> > Memory efficiency is significantly improved due to reduced wastage in page
> > allocations. Example: We are now able to fit 35 Rx buffers in a single 64KB
> > page for MTU size of 1500, instead of 1 Rx buffer per page previously.
> > 
> Nice to see such improvements while also reducing the overall driver
> code footprint!
> 
> Do you happen to have numbers on some of the smaller page sizes? I'm not
> sure how common 64KB is, but it seems like this would still be quite
> beneficial even if you had 4K or 8K pages when operating at 1500 MTU.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>




