Return-Path: <bpf+bounces-19965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC03C8333E6
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 12:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA9A1F22362
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 11:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB27DDD7;
	Sat, 20 Jan 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osHl9MRt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A2D304;
	Sat, 20 Jan 2024 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705750548; cv=none; b=Nm0VmGHfhA+6PHybxbMmTBkqKRJiudynYtnQ4OZLCxHP+tRBbfFsLAetCzWE2vlwrhhgwDAWTcB5DATIZglEqAbwLHPiZzu7IgSOSwyfxrW4yA32luJt8dWyDrX6kEEY0at/blSxEi4PMWY3tCCMNOL96tnbMr1K4q520/Mw4Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705750548; c=relaxed/simple;
	bh=LNJG2a18OzwovkVmDgTSAY9tdBZP2+CP0aiTr6qY2MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deD0tq2s1xr/r16nvRKvNBurw4BmOOTHiLSHyawfDr5ouMGRF4Sdv6/TX1AJtWg+s7hgGWda3Kuj3I3SXznLAHs0UVZ/dGSh4AqFOjoxCvLQwqg0EzT8GcMnxKJ82NP6sZFornCKHbnFZtHDyk7wvHFOcE8kDCnobdyQ4mnV1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osHl9MRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86343C433F1;
	Sat, 20 Jan 2024 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705750547;
	bh=LNJG2a18OzwovkVmDgTSAY9tdBZP2+CP0aiTr6qY2MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=osHl9MRt88D9MkriixCOAxqrY1dSXvCQ35tgm2Kkqf0lQZ5rPZPNKNwnQJ1+kc8KG
	 OSS5lF6u7MVaUmuR7oVVSKF1KIVLXtRQmUCkSDSoIkaqGWyORHt6hPt4dZ+mGMyUxb
	 27vi6cVHGCn69FQCDslIJnCvreJauPYBKeBHULL/VMu5mZrcfIUM/EORrSU3wxFr5u
	 KTYx6nT31F48ylkcikPWXc9DmbDTG2TN+oOFREJIglkH1J5aKTLuXu7RjJFocDwsX1
	 +ye6RHt3VI4v8pUiJCTGzG57DMiiHp8yOL+8xTHjaNQWVhcRrXJtbarzrHpXTRorPC
	 3XMzVYWSsrLxw==
Date: Sat, 20 Jan 2024 11:35:41 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, bjorn@kernel.org, echaudro@redhat.com,
	lorenzo@kernel.org, martin.lau@linux.dev,
	tirthendu.sarkar@intel.com, john.fastabend@gmail.com
Subject: Re: [PATCH v4 bpf 05/11] i40e: handle multi-buffer packets that are
 shrunk by xdp prog
Message-ID: <20240120113541.GA110624@kernel.org>
References: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
 <20240119233037.537084-6-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119233037.537084-6-maciej.fijalkowski@intel.com>

On Sat, Jan 20, 2024 at 12:30:31AM +0100, Maciej Fijalkowski wrote:
> From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> 
> XDP programs can shrink packets by calling the bpf_xdp_adjust_tail()
> helper function. For multi-buffer packets this may lead to reduction of
> frag count stored in skb_shared_info area of the xdp_buff struct. This
> results in issues with the current handling of XDP_PASS and XDP_DROP
> cases.
> 
> For XDP_PASS, currently skb is being built using frag count of
> xdp_buffer before it was processed by XDP prog and thus will result in
> an inconsistent skb when frag count gets reduced by XDP prog. To fix
> this, get correct frag count while building the skb instead of using
> pre-obtained frag count.
> 
> For XDP_DROP, current page recycling logic will not reuse the page but
> instead will adjust the pagecnt_bias so that the page can be freed. This
> again results in inconsistent behavior as the page count has already
> been changed by the helper while freeing the frag(s) as part of
> shrinking the packet. To fix this, only adjust pagecnt_bias for buffers
> that are stillpart of the packet post-xdp prog run.
> 
> Fixes: e213ced19bef ("i40e: add support for XDP multi-buffer Rx")
> Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

...

> @@ -2129,20 +2130,20 @@ static void i40e_process_rx_buffs(struct i40e_ring *rx_ring, int xdp_res,
>   * i40e_construct_skb - Allocate skb and populate it
>   * @rx_ring: rx descriptor ring to transact packets on
>   * @xdp: xdp_buff pointing to the data
> - * @nr_frags: number of buffers for the packet
>   *
>   * This function allocates an skb.  It then populates it with the page
>   * data from the current receive descriptor, taking care to set up the
>   * skb correctly.
>   */
>  static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
> -					  struct xdp_buff *xdp,
> -					  u32 nr_frags)
> +					  struct xdp_buff *xdp)
>  {
>  	unsigned int size = xdp->data_end - xdp->data;
>  	struct i40e_rx_buffer *rx_buffer;
> +	struct skb_shared_info *sinfo;
>  	unsigned int headlen;
>  	struct sk_buff *skb;
> +	u32 nr_frags;
>  
>  	/* prefetch first cache line of first page */
>  	net_prefetch(xdp->data);
> @@ -2180,6 +2181,10 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
>  	memcpy(__skb_put(skb, headlen), xdp->data,
>  	       ALIGN(headlen, sizeof(long)));
>  
> +	if (unlikely(xdp_buff_has_frags(xdp))) {
> +		sinfo = xdp_get_shared_info_from_buff(xdp);
> +		nr_frags = sinfo->nr_frags;
> +	}
>  	rx_buffer = i40e_rx_bi(rx_ring, rx_ring->next_to_clean);
>  	/* update all of the pointers */
>  	size -= headlen;

Hi Maciej,

Above, nr_frags is initialised only if xdp_buff_has_frags(xdp) is true.
The code immediately following this hunk is:

	if (size) {
		if (unlikely(nr_frags >= MAX_SKB_FRAGS)) {
			...

Can it be the case that nr_frags is used uninitialised here?

Flagged by Smatch.

...

