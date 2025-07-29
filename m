Return-Path: <bpf+bounces-64673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3409B15444
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 22:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69843547DDC
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCC824EAB2;
	Tue, 29 Jul 2025 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R9nI+5pX"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5151BA45;
	Tue, 29 Jul 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753820409; cv=none; b=UiiFpWxKgQPXSBYQYmS7gXU2f6jaZgE+CoCLdH0jtLC6v9uNtjhBmyG+2McYnTjWgFSB2XNr8Dqbac4SamYr8GnR6ZGqrRRhcRKhuvsFWHDgclMKjmosyyWQ2pKjL6npRmgjxfTQwC0mEmoXLCD72vT+i+ibZlBC3l3CkaNrEHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753820409; c=relaxed/simple;
	bh=i34WAOmr0MeNBYWbKgL5cMKGVgXLfn48ebkA3wzKrGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXlDnVD4C1BFh1b6gkloir7tgD2WRIlnlk6rW+J++8WobqnZmP1RzGHY6kr8jF2d6wcgBOaKAOr+i1epJyFwf9wW+m2t0olW4eRhBisv7kamp+WqkseyYkEDnqBJTsut44oORgNsbq08OqQT0Wq11PwQT0Zkhl2iOG5xvdKNE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R9nI+5pX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 7A78B2021870; Tue, 29 Jul 2025 13:20:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A78B2021870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753820407;
	bh=jOghFZgytM5CIWOHdfDqQ31jcZSpWI0aTv7+X6gwQko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9nI+5pXYNXyXCQBRwMO/GnJYyPH9n6WByzFkTTthMeMPXRRZnOg3V7UnH4XRwc7V
	 /iPpnfKJMSODz+2hHnfbcq1djpK/nDhKnaxLv/LK+2thTuuDft8qR1XuCGrp5GtOEO
	 xtJfpkYvuGXsossnX5i74qb2fow1053hBk8XEGcY=
Date: Tue, 29 Jul 2025 13:20:07 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: horms@kernel.org, kuba@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, longli@microsoft.com, kotaranov@microsoft.com,
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	sdf@fomichev.me, lorenzo@kernel.org, michal.kubiak@intel.com,
	ernis@linux.microsoft.com, shradhagupta@linux.microsoft.com,
	shirazsaleem@microsoft.com, rosenp@gmail.com,
	netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@linux.microsoft.com,
	dipayanroy@microsoft.com, Chris Arges <carges@cloudflare.com>,
	kernel-team <kernel-team@cloudflare.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH v2] net: mana: Use page pool fragments for RX buffers
 instead of full pages to improve memory efficiency.
Message-ID: <20250729202007.GA6615@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250723190706.GA5291@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <73add9b2-2155-4c4f-92bb-8166138b226b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73add9b2-2155-4c4f-92bb-8166138b226b@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jul 29, 2025 at 12:15:23PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 23/07/2025 21.07, Dipayaan Roy wrote:
> >This patch enhances RX buffer handling in the mana driver by allocating
> >pages from a page pool and slicing them into MTU-sized fragments, rather
> >than dedicating a full page per packet. This approach is especially
> >beneficial on systems with large page sizes like 64KB.
> >
> >Key improvements:
> >
> >- Proper integration of page pool for RX buffer allocations.
> >- MTU-sized buffer slicing to improve memory utilization.
> >- Reduce overall per Rx queue memory footprint.
> >- Automatic fallback to full-page buffers when:
> >    * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
> >    * The XDP path is active, to avoid complexities with fragment reuse.
> >- Removal of redundant pre-allocated RX buffers used in scenarios like MTU
> >   changes, ensuring consistency in RX buffer allocation.
> >
> >Testing on VMs with 64KB pages shows around 200% throughput improvement.
> >Memory efficiency is significantly improved due to reduced wastage in page
> >allocations. Example: We are now able to fit 35 rx buffers in a single 64kb
> >page for MTU size of 1500, instead of 1 rx buffer per page previously.
> >
> >Tested:
> >
> >- iperf3, iperf2, and nttcp benchmarks.
> >- Jumbo frames with MTU 9000.
> >- Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
> >   testing the XDP path in driver.
> >- Page leak detection (kmemleak).
> >- Driver load/unload, reboot, and stress scenarios.
> 
> Chris (Cc) discovered a crash/bug[1] with page pool fragments used
> from the mlx5 driver.
> He put together a BPF program that reproduces the issue here:
> - [2] https://github.com/arges/xdp-redirector
> 
> Can I ask you to test that your driver against this reproducer?
> 
> 
> [1] https://lore.kernel.org/all/aIEuZy6fUj_4wtQ6@861G6M3/
> 
> --Jesper
>

Hi Jesper,

I was unable to reproduce this issue on mana driver.


Regards
Dipayaan Roy

