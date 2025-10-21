Return-Path: <bpf+bounces-71481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43BCBF42B7
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 02:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E5C46644D
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E470B2192F5;
	Tue, 21 Oct 2025 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEtkjrjS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D41C695;
	Tue, 21 Oct 2025 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007392; cv=none; b=TKfjyzBVrbBGlw6v4faD1vCQMJupbUdyRzglbbW/e86UusCZsbi/1FzWm0ZZXgB4VVVPkD/ioNRfTlzxxaT7bSDUknbpJcpn/CX756+jc+Yw/LM2d5IJrkPOflSF4DlIkbpkLJsKBT/WC0rCjUS/4prGUUvNvyurbaZ7zNIBbcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007392; c=relaxed/simple;
	bh=4RCzmBSn1YK3dNU1eu6WlsS+oiC3sOWT4kMWZcs60Is=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khbWUDAsS/2Wm8baceCgQz8rpcxKbos8Vdmc6kXqJpBexh76UGWhgeU5Ieyovo7aT/dk69o+BaUTHgxNmZF5voxNEMWAWiGYtr6oxWgGRkBl4LE2wQobWffJ4iKOJIdu2MF2dT/7dXxZe/3OMjpE765zMnbfiykzzFx0LRuirrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEtkjrjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B00C4CEFB;
	Tue, 21 Oct 2025 00:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007390;
	bh=4RCzmBSn1YK3dNU1eu6WlsS+oiC3sOWT4kMWZcs60Is=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cEtkjrjSI92wIHZJsTGhCickdT6aybd2B/sEoCNPQBq/fTzMFYu6KnoutQup+d3Ro
	 lM5gStw8JWQUxulUM1ObqQoPovLRzmAZd6pDkxLZNOvipZeJs8WuC5drCdqW3pVzlM
	 h/BndLLXV6OHUq6iIpQRcM7bJYk9icyWPTB5HiUu6//tb+H7Qb/DdZ+aG3zjCUS/Ty
	 PRoWZxS854wCjMVNWDg3mNdhBMvr5w0gjQF3eaI2lbwC9unraJMT4P1SItRyPIjrWH
	 8Pxo7LIrp/88tlKL+LQ5d1imWkZr7hsHbzmQNAOzfATefCser5tkqQeUtnFxqAIwLz
	 OaSBPwcvab96Q==
Date: Mon, 20 Oct 2025 17:43:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <horms@kernel.org>, <namcao@linutronix.de>, <jacob.e.keller@intel.com>,
 <christian.koenig@amd.com>, <sumit.semwal@linaro.org>, <sdf@fomichev.me>,
 <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
 <ast@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
 <linux-media@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net-next v3 0/6] Add AF_XDP zero copy support
Message-ID: <20251020174308.59b87130@kernel.org>
In-Reply-To: <20251014105613.2808674-1-m-malladi@ti.com>
References: <20251014105613.2808674-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 16:26:06 +0530 Meghana Malladi wrote:
> This series adds AF_XDP zero coppy support to icssg driver.
> 
> Tests were performed on AM64x-EVM with xdpsock application [1].
> 
> A clear improvement is seen Transmit (txonly) and receive (rxdrop)
> for 64 byte packets. 1500 byte test seems to be limited by line
> rate (1G link) so no improvement seen there in packet rate
> 
> Having some issue with l2fwd as the benchmarking numbers show 0
> for 64 byte packets after forwading first batch packets and I am
> currently looking into it.

This series stopped applying, could you please respin?
-- 
pw-bot: cr

