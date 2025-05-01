Return-Path: <bpf+bounces-57131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0D5AA6043
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 16:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2DC3B8D18
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A211FDA6D;
	Thu,  1 May 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6vwC7LJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB881D619D;
	Thu,  1 May 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111240; cv=none; b=Hy8nblRvzYpK+B2k2UwqKKZyt0ecPiH9S+ZzK7fd2IFQM29kl13jRztngLtdlmNXZp3YfLcH2WvO+Xa8bQZWMqAWnFk6jgtZfjBgsKC/iB/BzDKPakuEH53TgYbzZpECRtgFpvxqS/XgD6852TH4cvD2NNTDTeCpuBQXk0HCp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111240; c=relaxed/simple;
	bh=xXdZzehmKpZnbsgOKXp7I1LKRUhGMB11Fu7G/0fw8sM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRI7B/3EEgEhvuraBPxjLEArzilsy6lVH2Fb6vuTGfEud2uGmCvbrOi0CE5mcYlj2DBqyTixZTmZPPXHfHjZ00zKXo7l4c/uO8kzqfLJw7MabphtyxEOmNZsXoRnJI60yZxPIuEwIBCokECScu5X5gUuMAJRbqOqrr4osy96u44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6vwC7LJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B347CC4CEE3;
	Thu,  1 May 2025 14:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746111239;
	bh=xXdZzehmKpZnbsgOKXp7I1LKRUhGMB11Fu7G/0fw8sM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l6vwC7LJ/nVPMGGyFou6rLrkgDYrlUMFVtJy+41fHkxY+TBVNKs8bP5CzLPcCrofQ
	 aSMfrxinRbO9SBF3NsyEyBWxPEMIp34femxxDtb43yYLSIa1fIK8U+AtdNAV6LXYSu
	 HZlm9FWtOA8nXVd0i/nivLRH9hpDNky2RYh1JBl0gNqtTrYLINk92Z9TFpacI/Ah06
	 5at7Z1ZvxaQbdETxwlK7IR7OIvq1Pvr/mdXrQkZut+Zj1yleBO60VU6p4hL7KY4lru
	 rrqxxJiOmmHkmmkLnqCwmsdot5TWQWxbtD28lRwGGQZSpu15FWkzk01GGwStneRnr/
	 HgaYaQuCvBvAA==
Date: Thu, 1 May 2025 07:53:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <dan.carpenter@linaro.org>, <john.fastabend@gmail.com>,
 <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net 2/4] net: ti: icssg-prueth: Report BQL before
 sending XDP packets
Message-ID: <20250501075357.37f2dc4f@kernel.org>
In-Reply-To: <20250428120459.244525-3-m-malladi@ti.com>
References: <20250428120459.244525-1-m-malladi@ti.com>
	<20250428120459.244525-3-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 17:34:57 +0530 Meghana Malladi wrote:
> When sending out any kind of traffic, it is essential that the driver
> keeps reporting BQL of the number of bytes that have been sent so that
> BQL can track the amount of data in the queue and prevents it from
> overflowing. If BQL is not reported, the driver may continue sending
> packets even when the queue is full, leading to packet loss, congestion
> and decreased network performance. Currently this is missing in
> emac_xmit_xdp_frame() and this patch fixes it.

The ordering of patches in the series is a bit off.
The order should be something like:

  net: ti: icssg-prueth: Set XDP feature flags for ndev
  net: ti: icssg-prueth: Fix kernel panic during concurrent Tx queue ...
  net: ti: icssg-prueth: Fix race condition for traffic from different ...
  net: ti: icssg-prueth: Report BQL before sending XDP packets

This patch is not correct without the extra locking in place.

