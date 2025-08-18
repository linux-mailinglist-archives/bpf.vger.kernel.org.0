Return-Path: <bpf+bounces-65873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F9AB29FFA
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 13:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39E520457E
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14F13112B2;
	Mon, 18 Aug 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMT53HGD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B6261B78;
	Mon, 18 Aug 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515141; cv=none; b=JHWZbznqUASRNuqdpzinmN/dFdr0RX08aRd7bXsFcHJ0VZkCAO0ZQhoEXd68g+vHnrGHAwptPpb4dO3yn9X7SGgLZEengMIla/fKod0UkhQRbbpYjil6AjV7kAIrCj37hD/epdm3ery98ra5SObBpPJW3pWf7jCIwuMfVEuhZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515141; c=relaxed/simple;
	bh=r+jVouVxLZsvI407XYs75psAzx+Ma1V++sLeEsna7sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+IK4WEEJd1OC3RhK+BEq36hrK1VTpXmyo7bXaoTGn1GyjZBJTTr8rHLb/CQxLogPnk+AcXvPM8xt8G473yDVr/nKAxlmz+TaSx3Lx0Y6zLUp4xSuSIKZ25xrJ1P7sfjOIw3XlYRB6sLzNv/34YJC8MDHK2HAbrmllt03Buq3yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMT53HGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C12C4CEF1;
	Mon, 18 Aug 2025 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755515141;
	bh=r+jVouVxLZsvI407XYs75psAzx+Ma1V++sLeEsna7sc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WMT53HGDMhxWKxLMlzCujgKqlYnvlQkRzBe4pxIZI3DB6Bv3RvGChx7dqRfr9tf0j
	 zJbthIt1mb2Z0xZcfjTbe+psISD5QDdx5xMgnbvLKIvYyX9AsEKLIaN/DXMHwtlmRm
	 Dsikh09UpcU9dxxlZM9H3MVPYrA7/Pmdym+uiNldGcbK+mLyH3/YJB8Rjd6Yl8G6MG
	 n8MAFl792bNKe+AhqhD6jwRHJ/ZvsJX/yEHMb8wYSzvRSsU04PtVz9Nrkhu7Aq+rzR
	 6ltSNS/TQNxer4Gvs0ZslFzYAWyQYjqhzKnTImKWEls3mjzoOqmePWwduKyHHN9LmN
	 c3dkpDBNDqJ9Q==
Message-ID: <3887332b-a892-42f6-9fde-782638ebc5f6@kernel.org>
Date: Mon, 18 Aug 2025 13:05:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/6] ice: fix Rx page leak on multi-buffer frames
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org,
 horms@kernel.org, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, jaroslav.pulchart@gooddata.com,
 jdamato@fastly.com, christoph.petrausch@deepl.com,
 Rinitha S <sx.rinitha@intel.com>, Priya Singh <priyax.singh@intel.com>,
 Eelco Chaudron <echaudro@redhat.com>
References: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
 <20250815204205.1407768-4-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250815204205.1407768-4-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/08/2025 22.41, Tony Nguyen wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_put_rx_mbuf() function handles calling ice_put_rx_buf() for each
> buffer in the current frame. This function was introduced as part of
> handling multi-buffer XDP support in the ice driver.
> 
> It works by iterating over the buffers from first_desc up to 1 plus the
> total number of fragments in the frame, cached from before the XDP program
> was executed.
> 
> If the hardware posts a descriptor with a size of 0, the logic used in
> ice_put_rx_mbuf() breaks. Such descriptors get skipped and don't get added
> as fragments in ice_add_xdp_frag. Since the buffer isn't counted as a
> fragment, we do not iterate over it in ice_put_rx_mbuf(), and thus we don't
> call ice_put_rx_buf().
> 
> Because we don't call ice_put_rx_buf(), we don't attempt to re-use the
> page or free it. This leaves a stale page in the ring, as we don't
> increment next_to_alloc.
> 
> The ice_reuse_rx_page() assumes that the next_to_alloc has been incremented
> properly, and that it always points to a buffer with a NULL page. Since
> this function doesn't check, it will happily recycle a page over the top
> of the next_to_alloc buffer, losing track of the old page.
> 
> Note that this leak only occurs for multi-buffer frames. The
> ice_put_rx_mbuf() function always handles at least one buffer, so a
> single-buffer frame will always get handled correctly. It is not clear
> precisely why the hardware hands us descriptors with a size of 0 sometimes,
> but it happens somewhat regularly with "jumbo frames" used by 9K MTU.
> 
> To fix ice_put_rx_mbuf(), we need to make sure to call ice_put_rx_buf() on
> all buffers between first_desc and next_to_clean. Borrow the logic of a
> similar function in i40e used for this same purpose. Use the same logic
> also in ice_get_pgcnts().
> 
> Instead of iterating over just the number of fragments, use a loop which
> iterates until the current index reaches to the next_to_clean element just
> past the current frame. Check the current number of fragments (post XDP
> program). For all buffers up 1 more than the number of fragments, we'll
> update the pagecnt_bias. For any buffers past this, pagecnt_bias is left
> as-is. This ensures that fragments released by the XDP program, as well as
> any buffers with zero-size won't have their pagecnt_bias updated
> incorrectly. Unlike i40e, the ice_put_rx_mbuf() function does call
> ice_put_rx_buf() on the last buffer of the frame indicating end of packet.
> 
> The xdp_xmit value only needs to be updated if an XDP program is run, and
> only once per packet. Drop the xdp_xmit pointer argument from
> ice_put_rx_mbuf(). Instead, set xdp_xmit in the ice_clean_rx_irq() function
> directly. This avoids needing to pass the argument and avoids an extra
> bit-wise OR for each buffer in the frame.
> 
> Move the increment of the ntc local variable to ensure its updated *before*
> all calls to ice_get_pgcnts() or ice_put_rx_mbuf(), as the loop logic
> requires the index of the element just after the current frame.
> 
> This has the advantage that we also no longer need to track or cache the
> number of fragments in the rx_ring, which saves a few bytes in the ring.
> 

Have anyone tested the performance impact for XDP_DROP ?
(with standard non-multi-buffer frames)

Below code change will always touch cache-lines in shared_info area.
Before it was guarded with a xdp_buff_has_frags() check.

> Cc: Christoph Petrausch <christoph.petrausch@deepl.com>
> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> Closes: https://lore.kernel.org/netdev/CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com/
> Fixes: 743bbd93cf29 ("ice: put Rx buffers after being done with current frame")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Tested-by: Priya Singh <priyax.singh@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_txrx.c | 81 +++++++++--------------
>   drivers/net/ethernet/intel/ice/ice_txrx.h |  1 -
>   2 files changed, 33 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 29e0088ab6b2..93907ab2eac7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -894,10 +894,6 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>   	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->page,
>   				   rx_buf->page_offset, size);
>   	sinfo->xdp_frags_size += size;
> -	/* remember frag count before XDP prog execution; bpf_xdp_adjust_tail()
> -	 * can pop off frags but driver has to handle it on its own
> -	 */
> -	rx_ring->nr_frags = sinfo->nr_frags;
>   
>   	if (page_is_pfmemalloc(rx_buf->page))
>   		xdp_buff_set_frag_pfmemalloc(xdp);
> @@ -968,20 +964,20 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
>   /**
>    * ice_get_pgcnts - grab page_count() for gathered fragments
>    * @rx_ring: Rx descriptor ring to store the page counts on
> + * @ntc: the next to clean element (not included in this frame!)
>    *
>    * This function is intended to be called right before running XDP
>    * program so that the page recycling mechanism will be able to take
>    * a correct decision regarding underlying pages; this is done in such
>    * way as XDP program can change the refcount of page
>    */
> -static void ice_get_pgcnts(struct ice_rx_ring *rx_ring)
> +static void ice_get_pgcnts(struct ice_rx_ring *rx_ring, unsigned int ntc)
>   {
> -	u32 nr_frags = rx_ring->nr_frags + 1;
>   	u32 idx = rx_ring->first_desc;
>   	struct ice_rx_buf *rx_buf;
>   	u32 cnt = rx_ring->count;
>   
> -	for (int i = 0; i < nr_frags; i++) {
> +	while (idx != ntc) {
>   		rx_buf = &rx_ring->rx_buf[idx];
>   		rx_buf->pgcnt = page_count(rx_buf->page);
>   
> @@ -1154,62 +1150,48 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf)
>   }
>   
>   /**
> - * ice_put_rx_mbuf - ice_put_rx_buf() caller, for all frame frags
> + * ice_put_rx_mbuf - ice_put_rx_buf() caller, for all buffers in frame
>    * @rx_ring: Rx ring with all the auxiliary data
>    * @xdp: XDP buffer carrying linear + frags part
> - * @xdp_xmit: XDP_TX/XDP_REDIRECT verdict storage
> - * @ntc: a current next_to_clean value to be stored at rx_ring
> + * @ntc: the next to clean element (not included in this frame!)
>    * @verdict: return code from XDP program execution
>    *
> - * Walk through gathered fragments and satisfy internal page
> - * recycle mechanism; we take here an action related to verdict
> - * returned by XDP program;
> + * Called after XDP program is completed, or on error with verdict set to
> + * ICE_XDP_CONSUMED.
> + *
> + * Walk through buffers from first_desc to the end of the frame, releasing
> + * buffers and satisfying internal page recycle mechanism. The action depends
> + * on verdict from XDP program.
>    */
>   static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> -			    u32 *xdp_xmit, u32 ntc, u32 verdict)
> +			    u32 ntc, u32 verdict)
>   {
> -	u32 nr_frags = rx_ring->nr_frags + 1;
> +	u32 nr_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;

Here we unconditionally access the skb_shared_info area.

>   	u32 idx = rx_ring->first_desc;
>   	u32 cnt = rx_ring->count;
> -	u32 post_xdp_frags = 1;
>   	struct ice_rx_buf *buf;
> -	int i;
> -
> -	if (unlikely(xdp_buff_has_frags(xdp)))

Previously we only touch shared_info area if this is a multi-buff frame.

> -		post_xdp_frags += xdp_get_shared_info_from_buff(xdp)->nr_frags;
> +	int i = 0;
>   
> -	for (i = 0; i < post_xdp_frags; i++) {
> +	while (idx != ntc) {
>   		buf = &rx_ring->rx_buf[idx];
> +		if (++idx == cnt)
> +			idx = 0;
>   
> -		if (verdict & (ICE_XDP_TX | ICE_XDP_REDIR)) {
> +		/* An XDP program could release fragments from the end of the
> +		 * buffer. For these, we need to keep the pagecnt_bias as-is.
> +		 * To do this, only adjust pagecnt_bias for fragments up to
> +		 * the total remaining after the XDP program has run.
> +		 */
> +		if (verdict != ICE_XDP_CONSUMED)
>   			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
> -			*xdp_xmit |= verdict;
> -		} else if (verdict & ICE_XDP_CONSUMED) {
> +		else if (i++ <= nr_frags)
>   			buf->pagecnt_bias++;
> -		} else if (verdict == ICE_XDP_PASS) {
> -			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
> -		}
>   
>   		ice_put_rx_buf(rx_ring, buf);
> -
> -		if (++idx == cnt)
> -			idx = 0;
> -	}
> -	/* handle buffers that represented frags released by XDP prog;
> -	 * for these we keep pagecnt_bias as-is; refcount from struct page
> -	 * has been decremented within XDP prog and we do not have to increase
> -	 * the biased refcnt
> -	 */
> -	for (; i < nr_frags; i++) {
> -		buf = &rx_ring->rx_buf[idx];
> -		ice_put_rx_buf(rx_ring, buf);
> -		if (++idx == cnt)
> -			idx = 0;
>   	}
>   
>   	xdp->data = NULL;
>   	rx_ring->first_desc = ntc;
> -	rx_ring->nr_frags = 0;
>   }
>   
>   /**
> @@ -1317,6 +1299,10 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>   		/* retrieve a buffer from the ring */
>   		rx_buf = ice_get_rx_buf(rx_ring, size, ntc);
>   
> +		/* Increment ntc before calls to ice_put_rx_mbuf() */
> +		if (++ntc == cnt)
> +			ntc = 0;
> +
>   		if (!xdp->data) {
>   			void *hard_start;
>   
> @@ -1325,24 +1311,23 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>   			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
>   			xdp_buff_clear_frags_flag(xdp);
>   		} else if (ice_add_xdp_frag(rx_ring, xdp, rx_buf, size)) {
> -			ice_put_rx_mbuf(rx_ring, xdp, NULL, ntc, ICE_XDP_CONSUMED);
> +			ice_put_rx_mbuf(rx_ring, xdp, ntc, ICE_XDP_CONSUMED);
>   			break;
>   		}
> -		if (++ntc == cnt)
> -			ntc = 0;
>   
>   		/* skip if it is NOP desc */
>   		if (ice_is_non_eop(rx_ring, rx_desc))
>   			continue;
>   
> -		ice_get_pgcnts(rx_ring);
> +		ice_get_pgcnts(rx_ring, ntc);
>   		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
>   		if (xdp_verdict == ICE_XDP_PASS)
>   			goto construct_skb;
>   		total_rx_bytes += xdp_get_buff_len(xdp);
>   		total_rx_pkts++;
>   
> -		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
> +		ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);
> +		xdp_xmit |= xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR);
>   
>   		continue;
>   construct_skb:
> @@ -1355,7 +1340,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>   			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
>   			xdp_verdict = ICE_XDP_CONSUMED;
>   		}
> -		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
> +		ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);
>   
>   		if (!skb)
>   			break;
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index fef750c5f288..2fd8e78178a2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -358,7 +358,6 @@ struct ice_rx_ring {
>   	struct ice_tx_ring *xdp_ring;
>   	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
>   	struct xsk_buff_pool *xsk_pool;
> -	u32 nr_frags;
>   	u16 max_frame;
>   	u16 rx_buf_len;
>   	dma_addr_t dma;			/* physical address of ring */


