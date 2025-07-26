Return-Path: <bpf+bounces-64428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC4B1284B
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 02:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F761897830
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 00:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D43198E8C;
	Sat, 26 Jul 2025 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzEmDJK6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F354594A;
	Sat, 26 Jul 2025 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491261; cv=none; b=LJLo7P9vZvTwOuE23yBHKvq0qUrwe5S523F6tavGGc06kkUcZXh30ZYMACAoTKQckcDBH8muowsfrHwGenyRvxCZym0cASjYkHGGWGqO08PjaFJjB3Y/Te5CTHzbWgrtLsDitRO6KWONfgcI59xboakeytPws1/iN3dGutI/B+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491261; c=relaxed/simple;
	bh=k0MssS8OjXl9ucL/HTEj+OpepdtZIe0Zy0Afm8de7wk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6CHWHZpcr6eHWuh8REU9298l+cEthVbEynDDD52QJrpAnVbTCfVOcJEp7JFtc1WNF1PG8K7qdaWPfGvgPmJ5m6SwdSMsgg4IDxGgwKKvcLiN8USWIOc2iO/qiSRq/bsHYhydUvjGD6cU++MAfkS2beBDEqmd4PWaGjKX7HyU64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzEmDJK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C546C4CEE7;
	Sat, 26 Jul 2025 00:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753491260;
	bh=k0MssS8OjXl9ucL/HTEj+OpepdtZIe0Zy0Afm8de7wk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GzEmDJK6ofskipgzHfVF/dPaOi0eQYeX0uIkUHOt8kti/bZVb+00PvPe70ltX5MPT
	 XuuwQQugPwBGnsaeB36XTc1AzSwSHUsKoN8pZmrudlul8Unuayrig13F+2HPcY90eX
	 ZRX7b506o71XzT96SI6kosUjTRi6qXrUU3x02jXHs6c8Zxbc3esonvccUfbYslNa8U
	 mpopQoBZ7Q/6FpQ0ifw0IKYo13FOr81N+X7/WNKKecmzlx/1gzo1rD16sQYyRWMYZj
	 jDuA5xR61U7MdVFfwceR+BSfd+pU907c+fiJ+2czQIsydBL9RcOGdnAxiaBmQs+/DB
	 r1PpfOgPDV5yw==
Date: Fri, 25 Jul 2025 17:54:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: horms@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, lorenzo@kernel.org, michal.kubiak@intel.com,
 ernis@linux.microsoft.com, shradhagupta@linux.microsoft.com,
 shirazsaleem@microsoft.com, rosenp@gmail.com, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 ssengar@linux.microsoft.com, dipayanroy@microsoft.com
Subject: Re: [PATCH v2] net: mana: Use page pool fragments for RX buffers
 instead of full pages to improve memory efficiency.
Message-ID: <20250725175418.553b5b6e@kernel.org>
In-Reply-To: <20250723190706.GA5291@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250723190706.GA5291@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 12:07:06 -0700 Dipayaan Roy wrote:
> This patch enhances RX buffer handling in the mana driver by allocating
> pages from a page pool and slicing them into MTU-sized fragments, rather
> than dedicating a full page per packet. This approach is especially
> beneficial on systems with large page sizes like 64KB.
> 
> Key improvements:
> 
> - Proper integration of page pool for RX buffer allocations.
> - MTU-sized buffer slicing to improve memory utilization.
> - Reduce overall per Rx queue memory footprint.
> - Automatic fallback to full-page buffers when:
>    * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
>    * The XDP path is active, to avoid complexities with fragment reuse.
> - Removal of redundant pre-allocated RX buffers used in scenarios like MTU
>   changes, ensuring consistency in RX buffer allocation.
> 
> Testing on VMs with 64KB pages shows around 200% throughput improvement.
> Memory efficiency is significantly improved due to reduced wastage in page
> allocations. Example: We are now able to fit 35 rx buffers in a single 64kb
> page for MTU size of 1500, instead of 1 rx buffer per page previously.

The diff is pretty large and messy, please try to extract some
refactoring patches that make the final transition easier to review.

> - iperf3, iperf2, and nttcp benchmarks.
> - Jumbo frames with MTU 9000.
> - Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
>   testing the XDP path in driver.
> - Page leak detection (kmemleak).

kmemleak doesn't detect page leaks AFAIU, just slab objects

> - Driver load/unload, reboot, and stress scenarios.
> 
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

> -	if (apc->port_is_up)
> +	if (apc->port_is_up) {
> +		/* Re-create rxq's after xdp prog was loaded or unloaded.
> +		 * Ex: re create rxq's to switch from full pages to smaller
> +		 * size page fragments when xdp prog is unloaded and vice-versa.
> +		 */
> +
> +		err = mana_detach(ndev, false);
> +		if (err) {
> +			netdev_err(ndev, "mana_detach failed at xdp set: %d\n", err);
> +			goto out;
> +		}
> +
> +		err = mana_attach(ndev);
> +		if (err) {
> +			netdev_err(ndev, "mana_attach failed at xdp set: %d\n", err);
> +			goto out;
> +		}

If the system is low on memory you will make it unreachable.
It's a very poor design.

> -/* Release pre-allocated RX buffers */
> -void mana_pre_dealloc_rxbufs(struct mana_port_context *mpc)
> -{
> -	struct device *dev;
> -	int i;
> -

Looks like you're deleting the infrastructure the driver had for
pre-allocating memory. Not even mentioning it in the commit message.
This ability needs to be maintain. Please test with memory allocation
injections and make sure the driver survives failed reconfig requests.
The reconfiguration should be cleanly rejected if mem alloc fails,
and the driver should continue to work with old settings in place.
-- 
pw-bot: cr

