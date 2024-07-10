Return-Path: <bpf+bounces-34341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE2F92C808
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 03:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3FCB21760
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 01:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F326263D5;
	Wed, 10 Jul 2024 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/lmfDpX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A91B86D6;
	Wed, 10 Jul 2024 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720575926; cv=none; b=DmuvO7DLbuWSBCsCkFG7O1qa5MBpgf9xrJD9O5jma6D4QN3yYfriL4EAQCo2e2XrI751DnYEjq6HYl+dytJz+xhChhaO4fWoEF5w1BOJPbhRCoJdHQ97dhlxGCgJQEjrwZOgbV40PVyz1lwkz2mIPCdz8NuWIoxMv4GSHwVjGw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720575926; c=relaxed/simple;
	bh=ZPlr3tCE2c7+ucBwae/XJGvZM0g7Aea7uQUypbNs2sg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dz3D29Zjgs52suDfkvEAZADvfdaK1olXeXLsx7ydLU8m+sZtZHBTvS3Jg5iVCYaWSE7WPCbvy4ORpq/8cZVxJGBaMmbRfERQaMfk4W+dBwmIEgNAiqQtXyx0KEhDnDX7mZC8lYIDZpEPQD3AsyWc/JtDK/Frc4So7JYZ4SxIamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/lmfDpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E23C3277B;
	Wed, 10 Jul 2024 01:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720575926;
	bh=ZPlr3tCE2c7+ucBwae/XJGvZM0g7Aea7uQUypbNs2sg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R/lmfDpXwhgSRmzoakvaZLk+iODJsns/6NoCdeeSuPrjTNgtJs+9UzWgIExunXcPT
	 A+Ef0rMfI8JFKSQfOopISPwJanieRxG2oWdo9ILDDQ8jXSWrCnljEd605j0N3tENul
	 EnPYO2UM05dblXevT/tIBIDYRuBa+IqrIR+eNYE5rZtc8geKD0/CT5QiIlrRGRaiWC
	 F+7Xih58dO2tMjH7UL2+zgshkCWCkXYaq5M66UNNbFkIepS5BO6rMrtiofKlrDzsS3
	 QfpOYpgZvgmTg6M2BkyOtVQHncjsZf0LCO2LHEJDe5K4rdfHF03ph9zDQbwyLioZ4Y
	 DS+llvmFuQapQ==
Date: Tue, 9 Jul 2024 18:45:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 magnus.karlsson@intel.com, aleksander.lobakin@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, Shannon Nelson <shannon.nelson@amd.com>, Chandan Kumar
 Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net 6/8] ice: improve updating ice_{t,
 r}x_ring::xsk_pool
Message-ID: <20240709184524.232b9f57@kernel.org>
In-Reply-To: <20240708221416.625850-7-anthony.l.nguyen@intel.com>
References: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
	<20240708221416.625850-7-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jul 2024 15:14:12 -0700 Tony Nguyen wrote:
> @@ -1556,7 +1556,7 @@ int ice_napi_poll(struct napi_struct *napi, int budget)
>  		 * comparison in the irq context instead of many inside the
>  		 * ice_clean_rx_irq function and makes the codebase cleaner.
>  		 */
> -		cleaned = rx_ring->xsk_pool ?
> +		cleaned = READ_ONCE(rx_ring->xsk_pool) ?
>  			  ice_clean_rx_irq_zc(rx_ring, budget_per_ring) :
>  			  ice_clean_rx_irq(rx_ring, budget_per_ring);
>  		work_done += cleaned;


> @@ -832,8 +839,8 @@ ice_add_xsk_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *first,
>   */
>  int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
>  {
> +	struct xsk_buff_pool *xsk_pool = READ_ONCE(rx_ring->xsk_pool);
>  	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
> -	struct xsk_buff_pool *xsk_pool = rx_ring->xsk_pool;
>  	u32 ntc = rx_ring->next_to_clean;
>  	u32 ntu = rx_ring->next_to_use;
>  	struct xdp_buff *first = NULL;

This looks suspicious, you need to at least explain why it's correct.
READ_ONCE() means one access per critical section, usually.
You access it at least twice in a single NAPI pool.

