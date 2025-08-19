Return-Path: <bpf+bounces-66023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B8BB2C9F0
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 18:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7B5164773
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D29527FB01;
	Tue, 19 Aug 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChfL6moV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4A2EB87C;
	Tue, 19 Aug 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621905; cv=none; b=Xl6iTh0mjz2+JhmhhJlt+sNTd2O8i1ThrieRZqoSW0SqQW3SZ4IcLuOgtMTGt230sgYRUWM23HrjJXhC7gUUfCJkai1y6MwDKgVlvq5EfaFtqwt2YSNK3dZOVG9NTGSVgPnn8vT6iBfOiFOeVnvE75BfLDaBlbIvtH78zy55mrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621905; c=relaxed/simple;
	bh=MGk7Z3gUQ11nfLslZDfTaWLuhSDABjAjmiYBP4r9+Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/40i7S8nKHb/hc9JRBXsbJVOz4OIfbKOnouwM5cq4rhzPIzbs0RLvNGcJXYt37whg8/cH+iMrU+XAvZk3ESVn8aK/E04/TxIf7o+ct15M5gvcqsX2g0ukAYJ0WjYZ3WIg3RDAPuvl3mdPiMwzBUnI/tLUn1vYnV5cF/uqYtE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChfL6moV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEC4C4CEF1;
	Tue, 19 Aug 2025 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755621904;
	bh=MGk7Z3gUQ11nfLslZDfTaWLuhSDABjAjmiYBP4r9+Pg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ChfL6moVngWiTJ4Hf0ClbIczUIFKjROD3Lg3UTlTWVgmWae1nERjIifJqu/fvL8V9
	 8YzEInbG9N8CsR/G9OEi2Y+eIHUz6jAK+9zWr0DBLc2FgFWCOQRf0VosG8tOzG+Ah0
	 o9blvLZpZ0DG+Du1SXxQWEcrByehbnLbvCfNRNOl+kodgRdxKoV4aNnS63I1tYY1hw
	 /ezBfmVPtNGLylbfJqOzSGHtbGCbNxpRUJljlEe3DW0yML27fygAZJX0iLDjyfyLGN
	 PSL9OHqKSg40L/pNNKQow81B+SY1+tC47RsIFJ0+e41uu7AcmNVTTEkriObn1spgGa
	 gys7peQrrLo/A==
Message-ID: <6e2cbea1-8c70-4bfa-9ce4-1d07b545a705@kernel.org>
Date: Tue, 19 Aug 2025 18:44:56 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/6] ice: fix Rx page leak on multi-buffer frames
To: Jacob Keller <jacob.e.keller@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, ast@kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
Cc: maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 andrew+netdev@lunn.ch, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, bpf@vger.kernel.org, horms@kernel.org,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 jaroslav.pulchart@gooddata.com, jdamato@fastly.com,
 christoph.petrausch@deepl.com, Rinitha S <sx.rinitha@intel.com>,
 Priya Singh <priyax.singh@intel.com>, Eelco Chaudron <echaudro@redhat.com>,
 edumazet@google.com
References: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
 <20250815204205.1407768-4-anthony.l.nguyen@intel.com>
 <3887332b-a892-42f6-9fde-782638ebc5f6@kernel.org>
 <dd8703a5-7597-493c-a5c7-73eac7ed67d5@intel.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <dd8703a5-7597-493c-a5c7-73eac7ed67d5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/08/2025 02.38, Jacob Keller wrote:
> 
> 
> On 8/18/2025 4:05 AM, Jesper Dangaard Brouer wrote:
>> On 15/08/2025 22.41, Tony Nguyen wrote:
>>> This has the advantage that we also no longer need to track or cache the
>>> number of fragments in the rx_ring, which saves a few bytes in the ring.
>>>
>>
>> Have anyone tested the performance impact for XDP_DROP ?
>> (with standard non-multi-buffer frames)
>>
>> Below code change will always touch cache-lines in shared_info area.
>> Before it was guarded with a xdp_buff_has_frags() check.
>>
> 
> I did some basic testing with XDP_DROP previously using the xdp-bench
> tool, and do not recall notice an issue. I don't recall the actual
> numbers now though, so I did some quick tests again.
> 
> without patch...
> 
> Client:
> $ iperf3 -u -c 192.168.93.1 -t86400 -l1200 -P20 -b5G
> ...
> [SUM]  10.00-10.33  sec   626 MBytes  16.0 Gbits/sec  546909
> 
> $ iperf3 -s -B 192.168.93.1%ens260f0
> [SUM]   0.00-10.00  sec  17.7 GBytes  15.2 Gbits/sec  0.011 ms
> 9712/15888183 (0.061%)  receiver
> 
> $ xdp-bench drop ens260f0
> Summary                 1,778,935 rx/s                  0 err/s
> Summary                 2,041,087 rx/s                  0 err/s
> Summary                 2,005,052 rx/s                  0 err/s
> Summary                 1,918,967 rx/s                  0 err/s
> 
> with patch...
> 
> Client:
> $ iperf3 -u -c 192.168.93.1 -t86400 -l1200 -P20 -b5G
> ...
> [SUM]  78.00-78.90  sec  2.01 GBytes  19.1 Gbits/sec  1801284
> 
> Server:
> $ iperf3 -s -B 192.168.93.1%ens260f0
> [SUM]  77.00-78.00  sec  2.14 GBytes  18.4 Gbits/sec  0.012 ms
> 9373/1921186 (0.49%)
> 
> xdp-bench:
> $ xdp-bench drop ens260f0
> Dropping packets on ens260f0 (ifindex 8; driver ice)
> Summary                 1,910,918 rx/s                  0 err/s
> Summary                 1,866,562 rx/s                  0 err/s
> Summary                 1,901,233 rx/s                  0 err/s
> Summary                 1,859,854 rx/s                  0 err/s
> Summary                 1,593,493 rx/s                  0 err/s
> Summary                 1,891,426 rx/s                  0 err/s
> Summary                 1,880,673 rx/s                  0 err/s
> Summary                 1,866,043 rx/s                  0 err/s
> Summary                 1,872,845 rx/s                  0 err/s
> 
> 
> I ran a few times and it seemed to waffle a bit around 15Gbit/sec to
> 20Gbit/sec, with throughput varying regardless of which patch applied. I
> actually tended to see slightly higher numbers with this fix applied,
> but it was not consistent and hard to measure.
> 

Above testing is not a valid XDP_DROP test.

The packet generator need to be much much faster, as XDP_DROP is for
DDoS protection use-cases (one of Cloudflare's main products).

I recommend using the script for pktgen in kernel tree:
  samples/pktgen/pktgen_sample03_burst_single_flow.sh

Example:
  ./pktgen_sample03_burst_single_flow.sh -vi mlx5p2 -d 198.18.100.1 -m 
b4:96:91:ad:0b:09 -t $(nproc)


> without the patch:

On my testlab with CPU: AMD EPYC 9684X (SRSO=IBPB) running:
  - sudo ./xdp-bench drop ice4  # (defaults to no-touch)

XDP_DROP (with no-touch)
  Without patch :  54,052,300 rx/s = 18.50 nanosec/packet
  With the patch:  33,420,619 rx/s = 29.92 nanosec/packet
  Diff: 11.42 nanosec

Using perf stat I can see an increase in cache-misses.

The difference is less, if we read-packet data, running:
  - sudo ./xdp-bench drop ice4 --packet-operation read-data

XDP_DROP (with read-data)
  Without patch :  27,200,683 rx/s = 36.76 nanosec/packet
  With the patch:  24,348,751 rx/s = 41.07 nanosec/packet
  Diff: 4.31 nanosec

On this CPU we don't have DDIO/DCA, so we take a big hit reading the
packet data in XDP.  This will be needed by our DDoS bpf_prog.
The nanosec diff isn't the same, so it seem this change can hide a
little behind the cache-miss in the XDP bpf_prog.


> Without xdp-bench running the XDP program, top showed a CPU usage of
> 740% and an ~86 idle score.
> 

We don't want a scaling test for this. For this XDP_DROP/DDoS test we
want to target a single CPU. This is easiest done by generating a single
flow (hint pktgen script is called _single_flow). We want to see a
single CPU running ksoftirqd 100% of the time.

> With xdp-bench running, the iperf cpu drops off the top listing and the
> CPU idle score goes up to 99.9
> 

With the single flow generator DoS "attacking" a single CPU, we want to
see a single CPU running ksoftirqd 100% of the time, for XDP_DROP case.

> 
> with the patch:
> 
> The iperf3 CPU use seems to go up, but so does the throughput. It is
> hard to get an isolated measure. I don't have an immediate setup for
> fine tuned performance testing available to do anything more rigorous.
> 
> Personally, I think its overall in the noise, as I saw the same peak
> performance and CPU usages with and without the patch.
> 
> I also tried testing TCP and also didn't see a significant difference
> with or without the patch. Though, testing xdp-bench with TCP is not
> that useful since the client stops transmitting once the packets are
> dropped instead of handled.
> 
> $ iperf3 -c 192.168.93.1 -t86400 -l8000 -P5
> 
> Without patch:
> [SUM]  24.00-25.00  sec  7.80 GBytes  67.0 Gbits/sec
> 
> With patch:
> [SUM]  28.00-29.00  sec  7.85 GBytes  67.4 Gbits/sec
> 
> Again, it ranges from 60 to 68 Gbit/sec in both cases, though I think
> the peak is slightly higher with the fix applied, sometimes I saw it
> spike up to 70Gbit/sec but it mostly hovers around 67 Gbit/sec.
> 
> I'm sure theres a lot of factors impacting the performance here, but I
> think there's not much evidence that its significantly different.
>>> Cc: Christoph Petrausch <christoph.petrausch@deepl.com>
>>> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
>>> Closes: https://lore.kernel.org/netdev/CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com/
>>> Fixes: 743bbd93cf29 ("ice: put Rx buffers after being done with current frame")
>>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>>> Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
>>> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>>> Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>>> Tested-by: Priya Singh <priyax.singh@intel.com>
>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>> ---
>>>    drivers/net/ethernet/intel/ice/ice_txrx.c | 81 +++++++++--------------
>>>    drivers/net/ethernet/intel/ice/ice_txrx.h |  1 -
>>>    2 files changed, 33 insertions(+), 49 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
>>> index 29e0088ab6b2..93907ab2eac7 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
>>> @@ -894,10 +894,6 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>>>    	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->page,
>>>    				   rx_buf->page_offset, size);
>>>    	sinfo->xdp_frags_size += size;
>>> -	/* remember frag count before XDP prog execution; bpf_xdp_adjust_tail()
>>> -	 * can pop off frags but driver has to handle it on its own
>>> -	 */
>>> -	rx_ring->nr_frags = sinfo->nr_frags;
>>>    
>>>    	if (page_is_pfmemalloc(rx_buf->page))
>>>    		xdp_buff_set_frag_pfmemalloc(xdp);
>>> @@ -968,20 +964,20 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
>>>    /**
>>>     * ice_get_pgcnts - grab page_count() for gathered fragments
>>>     * @rx_ring: Rx descriptor ring to store the page counts on
>>> + * @ntc: the next to clean element (not included in this frame!)
>>>     *
>>>     * This function is intended to be called right before running XDP
>>>     * program so that the page recycling mechanism will be able to take
>>>     * a correct decision regarding underlying pages; this is done in such
>>>     * way as XDP program can change the refcount of page
>>>     */
>>> -static void ice_get_pgcnts(struct ice_rx_ring *rx_ring)
>>> +static void ice_get_pgcnts(struct ice_rx_ring *rx_ring, unsigned int ntc)
>>>    {
>>> -	u32 nr_frags = rx_ring->nr_frags + 1;
>>>    	u32 idx = rx_ring->first_desc;
>>>    	struct ice_rx_buf *rx_buf;
>>>    	u32 cnt = rx_ring->count;
>>>    
>>> -	for (int i = 0; i < nr_frags; i++) {
>>> +	while (idx != ntc) {
>>>    		rx_buf = &rx_ring->rx_buf[idx];
>>>    		rx_buf->pgcnt = page_count(rx_buf->page);
>>>    
>>> @@ -1154,62 +1150,48 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf)
>>>    }
>>>    
>>>    /**
>>> - * ice_put_rx_mbuf - ice_put_rx_buf() caller, for all frame frags
>>> + * ice_put_rx_mbuf - ice_put_rx_buf() caller, for all buffers in frame
>>>     * @rx_ring: Rx ring with all the auxiliary data
>>>     * @xdp: XDP buffer carrying linear + frags part
>>> - * @xdp_xmit: XDP_TX/XDP_REDIRECT verdict storage
>>> - * @ntc: a current next_to_clean value to be stored at rx_ring
>>> + * @ntc: the next to clean element (not included in this frame!)
>>>     * @verdict: return code from XDP program execution
>>>     *
>>> - * Walk through gathered fragments and satisfy internal page
>>> - * recycle mechanism; we take here an action related to verdict
>>> - * returned by XDP program;
>>> + * Called after XDP program is completed, or on error with verdict set to
>>> + * ICE_XDP_CONSUMED.
>>> + *
>>> + * Walk through buffers from first_desc to the end of the frame, releasing
>>> + * buffers and satisfying internal page recycle mechanism. The action depends
>>> + * on verdict from XDP program.
>>>     */
>>>    static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>>> -			    u32 *xdp_xmit, u32 ntc, u32 verdict)
>>> +			    u32 ntc, u32 verdict)
>>>    {
>>> -	u32 nr_frags = rx_ring->nr_frags + 1;
>>> +	u32 nr_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
>>
>> Here we unconditionally access the skb_shared_info area.
>>
>>>    	u32 idx = rx_ring->first_desc;
>>>    	u32 cnt = rx_ring->count;
>>> -	u32 post_xdp_frags = 1;
>>>    	struct ice_rx_buf *buf;
>>> -	int i;
>>> -
>>> -	if (unlikely(xdp_buff_has_frags(xdp)))
>>
>> Previously we only touch shared_info area if this is a multi-buff frame.
>>
> 
> I'm not certain, but reading the helpers it might be correct to do
> something like this:
> 
> if (unlikely(xdp_buff_has_frags(xdp)))
>    nr_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
> else
>    nr_frags = 1

Yes, that looks like a correct pattern.

> either in the driver code or by adding a new xdp helper function.
> 
> I'm not sure its worth it though. We have pending work from our
> development team to refactor ice to use page pool and switch to libeth
> XDP helpers which eliminates all of this driver-specific logic.

Please do proper testing of XDP_DROP case when doing this change.

> I don't personally think its worth holding up this series and this
> important memory leak fix for a minor potential code change that I can't
> measure an obvious improvement on.

IMHO you included an optimization (that wasn't a gain) in a fix patch.
I think you can fix the memory leak without the "optimization" part.

pw-bot: cr

--Jesper


