Return-Path: <bpf+bounces-44031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44F9BCDB3
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601671C21A1C
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590AB1D63CF;
	Tue,  5 Nov 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfm4Uvna"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08CA1D5176;
	Tue,  5 Nov 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812984; cv=none; b=gAxeKERhg4qeq3ptOAtYUrjqzsVUHDitXghOvuXo0zcSkorDLNyZ32NQXP5BH9OI1qT56RertbJu6O9sq6vMh2bGOX/ZtvYvm1/2n3ZzzjA1ZZceRQznZFCk+njfFV8dF17wEomyCATa5GuATq6WXUcX4wp3FzynyWyvOyiXVyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812984; c=relaxed/simple;
	bh=D/RfmmDBqik8vNxq2ghNjGPRkE8pk1X2SEs98LNktn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpopm9xZeCLWeBua0HS1L9YjZLMTeM+vgI81SeLyz31MMb7urPWIqny/fAA14H4v6B1CY6jOPenb3TI9fhEwJ38bcDkWcXVocRCqQmwy4vfGBiQZjAqA14Jc90lXrTZB/mTJd7iDJX9BXQfmJpgXEybLOTq0nzfHdwnih7/bPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfm4Uvna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14146C4CECF;
	Tue,  5 Nov 2024 13:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730812984;
	bh=D/RfmmDBqik8vNxq2ghNjGPRkE8pk1X2SEs98LNktn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kfm4UvnaqN79Chb/medNFL9+T9qReWbcnDGYzNZv7lEgWsFkHtEVxYVM3sU2MI+oX
	 GuaKEmjs/dM29IeGx/vbsOvBWjWYtk3rHHqHF4DCHpNwH88Io8+Md/4tU1Q9uCrQLK
	 2lQwTx7Ilw1FVWN3ef1+BvnJmv1xiMLUxSwvCJq0XVCh9yrKQDaClQuRV2C0O+9/OO
	 VHILMDEyr10PtrZJG6R86Phz7NxWTWdmBsm/+4veQurdrzM6DaDSGeaMZwnNzQQDIA
	 BCCVvJX18rh4e70CYY5ugpPvxGbtADODkaJci9IGkrXwgoxD/z7ozU/5DIJyxmU8us
	 a5b3jBekJxa5A==
Date: Tue, 5 Nov 2024 13:21:58 +0000
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Md Danish Anwar <danishanwar@ti.com>,
	Govindarajan Sriramakrishnan <srk@ti.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: ethernet: ti: am65-cpsw: Fix multi queue
 Rx on J7
Message-ID: <20241105132158.GC4507@kernel.org>
References: <20241101-am65-cpsw-multi-rx-j7-fix-v3-0-338fdd6a55da@kernel.org>
 <20241101-am65-cpsw-multi-rx-j7-fix-v3-1-338fdd6a55da@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101-am65-cpsw-multi-rx-j7-fix-v3-1-338fdd6a55da@kernel.org>

On Fri, Nov 01, 2024 at 12:18:50PM +0200, Roger Quadros wrote:
> On J7 platforms, setting up multiple RX flows was failing
> as the RX free descriptor ring 0 is shared among all flows
> and we did not allocate enough elements in the RX free descriptor
> ring 0 to accommodate for all RX flows.
> 
> This issue is not present on AM62 as separate pair of
> rings are used for free and completion rings for each flow.
> 
> Fix this by allocating enough elements for RX free descriptor
> ring 0.
> 
> However, we can no longer rely on desc_idx (descriptor based
> offsets) to identify the pages in the respective flows as
> free descriptor ring includes elements for all flows.
> To solve this, introduce a new swdata data structure to store
> flow_id and page. This can be used to identify which flow (page_pool)
> and page the descriptor belonged to when popped out of the
> RX rings.
> 
> Fixes: da70d184a8c3 ("net: ethernet: ti: am65-cpsw: Introduce multi queue Rx")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

> @@ -764,8 +759,8 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>  
>  fail_rx:
>  	for (i = 0; i < common->rx_ch_num_flows; i++)
> -		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, &rx_chn->flows[i],
> -					  am65_cpsw_nuss_rx_cleanup, 0);
> +		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, rx_chn,
> +					  am65_cpsw_nuss_rx_cleanup, !!i);

Hi Roger,

I wonder if, as a follow-up, the skip_fdq (last) parameter of
k3_udma_glue_reset_rx_chn() can be dropped. It seems that all callers
follow the pattern above of passing i as the flow_num (2nd) argument,
and !!i as the skip_fdq argument. If so, k3_udma_glue_reset_rx_chn could
simply derive skip_fdq as !!flow_num.

