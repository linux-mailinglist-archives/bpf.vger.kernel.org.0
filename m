Return-Path: <bpf+bounces-64551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF8AB141DC
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 20:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924B2189B065
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A22275AE0;
	Mon, 28 Jul 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IioLaXOg"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FD525BF13;
	Mon, 28 Jul 2025 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726822; cv=none; b=fwa24Tk1kSjIu8FZJ2lplsi5ZMjUWvVNGCISLnIHkTa77XD74CCxxpTgHVUWPYhoDz2PWlZezFdieWZrx2O3VTyu6ietHqDrtKFGX3bbmKn8XKoeP0Jiv428iLKuRqsSkgI9yDYbox/hAIQtFseh1mhmj1lhUUnOuYHTiI/3Pq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726822; c=relaxed/simple;
	bh=U0zPsTddS/u0ULy1YOXhCJeXWeOGAWL36PyOiEEcoqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0CR7jhKCz2WUS3xYlV2JxmhZDECgSIfCtV3EfurvpvW8rwvFBbKVzb45IuU8NUeeIgOGOcOIKQ78ISaHgZYyWUxyNow8FkEYkyXl8WAp9qO7A5bz8x6pJgfg+Fgiy38bGWOVZZmB5AQD/dQe4MegdnqF8mF0q8V2/7VPYGi220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IioLaXOg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 4BD4F2068328; Mon, 28 Jul 2025 11:20:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BD4F2068328
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753726820;
	bh=aly2X9C9vKLqSl39GYAAJQCZKz+d4olZkLhJIKY7Yko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IioLaXOgbM1DihOhpviKbRChA1EBsIcrDKBM+RJk0ZGVRJwzJv5AZcDccKcJ/UECu
	 l3qBcAqzNwN5HKtqJroCTc/fLy6VUEJNmERM6oFcwFL9yJ9t2ieBlzy6YMzeGl8LXW
	 hEqoXXKFs1ZgGbCGSYr2r8al1nPFoC8nKdNokP1g=
Date: Mon, 28 Jul 2025 11:20:20 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, lorenzo@kernel.org, michal.kubiak@intel.com,
	ernis@linux.microsoft.com, shradhagupta@linux.microsoft.com,
	shirazsaleem@microsoft.com, rosenp@gmail.com,
	netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@linux.microsoft.com,
	dipayanroy@microsoft.com
Subject: Re: [PATCH v2] net: mana: Use page pool fragments for RX buffers
 instead of full pages to improve memory efficiency.
Message-ID: <20250728182020.GA29111@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250723190706.GA5291@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250725175418.553b5b6e@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725175418.553b5b6e@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jul 25, 2025 at 05:54:18PM -0700, Jakub Kicinski wrote:
> On Wed, 23 Jul 2025 12:07:06 -0700 Dipayaan Roy wrote:
> > This patch enhances RX buffer handling in the mana driver by allocating
> > pages from a page pool and slicing them into MTU-sized fragments, rather
> > than dedicating a full page per packet. This approach is especially
> > beneficial on systems with large page sizes like 64KB.
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
> > allocations. Example: We are now able to fit 35 rx buffers in a single 64kb
> > page for MTU size of 1500, instead of 1 rx buffer per page previously.
> 
> The diff is pretty large and messy, please try to extract some
> refactoring patches that make the final transition easier to review.
> 
> > - iperf3, iperf2, and nttcp benchmarks.
> > - Jumbo frames with MTU 9000.
> > - Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
> >   testing the XDP path in driver.
> > - Page leak detection (kmemleak).
> 
> kmemleak doesn't detect page leaks AFAIU, just slab objects
> 
> > - Driver load/unload, reboot, and stress scenarios.
> > 
> > Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> > 
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> > -	if (apc->port_is_up)
> > +	if (apc->port_is_up) {
> > +		/* Re-create rxq's after xdp prog was loaded or unloaded.
> > +		 * Ex: re create rxq's to switch from full pages to smaller
> > +		 * size page fragments when xdp prog is unloaded and vice-versa.
> > +		 */
> > +
> > +		err = mana_detach(ndev, false);
> > +		if (err) {
> > +			netdev_err(ndev, "mana_detach failed at xdp set: %d\n", err);
> > +			goto out;
> > +		}
> > +
> > +		err = mana_attach(ndev);
> > +		if (err) {
> > +			netdev_err(ndev, "mana_attach failed at xdp set: %d\n", err);
> > +			goto out;
> > +		}
> 
> If the system is low on memory you will make it unreachable.
> It's a very poor design.
> 
> > -/* Release pre-allocated RX buffers */
> > -void mana_pre_dealloc_rxbufs(struct mana_port_context *mpc)
> > -{
> > -	struct device *dev;
> > -	int i;
> > -
> 
> Looks like you're deleting the infrastructure the driver had for
> pre-allocating memory. Not even mentioning it in the commit message.
> This ability needs to be maintain. Please test with memory allocation
> injections and make sure the driver survives failed reconfig requests.
> The reconfiguration should be cleanly rejected if mem alloc fails,
> and the driver should continue to work with old settings in place.
> -- 
> pw-bot: cr

Hi Jakub,

Thanks for the review. I agree with your point on low memory during the
reconfig of mana driver. I am sending out a v3 that will not touch the
driver infrastructure for pre-allocating the pages for rx buffer to avoid
failure in  mana driver reconfig due to low memory scenarios. And make
sure all other mana driver reconfig path uses the pre-alloc rx buffers as
a safe guard for the low memory condition.

The v3 will be a single patch focusing only on the improvement in memory
utilization and throughput that it is trying to achieve.


Thanks
Dipayaan Roy

