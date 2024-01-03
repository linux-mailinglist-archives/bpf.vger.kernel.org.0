Return-Path: <bpf+bounces-18863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C255C822EBD
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 14:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B771C21D81
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCF91A706;
	Wed,  3 Jan 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KlyOYiI5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A7919BBD;
	Wed,  3 Jan 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704289146; x=1735825146;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=gSt8LuLAaZkmAc9GglIREMAj35OPqBgtHQ1pKxCuGmo=;
  b=KlyOYiI5aLAbG1wMsL2VPnPSzUkzk497dLsgSdtdMVEvHOX9pHh6ozzJ
   m9zyJz+Nufkm2RjhDWCc+fXF1nhgQuYvfeHP+CRK/mY2BEz1VjZA1HcCQ
   n1tIwn/NGsq2b0vMxE9ehMZ0WGd7G9Ctz19M/q8umvrJgn+s3Hd9QlT7i
   BqDOTL1u0cS6hbT4MJFgsOgs9SGUVGdGWMqNbHnexTv6NfNYIOXmOyEh5
   +LCpR83F34QoOVRhP+8+laeWeT31Pm5I8JckbYXsZzinaRliYA5JQA2uX
   BB/gXt/WK6gahOX7jjhLtVJvqXQ7j832wBv5woR0WpncTyV1wssnBtvR9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="461317492"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="461317492"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 05:39:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="850441012"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="850441012"
Received: from cpeddyx-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.175.64])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 05:39:00 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>, "Brandeburg, Jesse"
 <jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, "Bezdeka,
 Florian" <florian.bezdeka@siemens.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "xdp-hints@xdp-project.net"
 <xdp-hints@xdp-project.net>
Subject: RE: [PATCH iwl-next,v1 1/1] igc: Add Tx hardware timestamp request
 for AF_XDP zero-copy packet
In-Reply-To: <PH0PR11MB5830B6742A03D2B1AC4A0A6ED860A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231215162158.951925-1-yoong.siang.song@intel.com>
 <87il4b6b7r.fsf@intel.com>
 <PH0PR11MB5830B6742A03D2B1AC4A0A6ED860A@PH0PR11MB5830.namprd11.prod.outlook.com>
Date: Wed, 03 Jan 2024 10:38:57 -0300
Message-ID: <87cyui5yfi.fsf@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Song, Yoong Siang" <yoong.siang.song@intel.com> writes:

> On Tuesday, January 2, 2024 10:51 PM, Gomes, Vinicius <vinicius.gomes@intel.com> wrote:
>>Song Yoong Siang <yoong.siang.song@intel.com> writes:
>>
>>> This patch adds support to per-packet Tx hardware timestamp request to
>>> AF_XDP zero-copy packet via XDP Tx metadata framework. Please note that
>>> user needs to enable Tx HW timestamp capability via igc_ioctl() with
>>> SIOCSHWTSTAMP cmd before sending xsk Tx timestamp request.
>>>
>>> Same as implementation in RX timestamp XDP hints kfunc metadata, Timer 0
>>> (adjustable clock) is used in xsk Tx hardware timestamp. i225/i226 have
>>> four sets of timestamping registers. A pointer named "xsk_pending_ts"
>>> is introduced to indicate the timestamping register is already occupied.
>>> Furthermore, the mentioned pointer also being used to hold the transmit
>>> completion until the tx hardware timestamp is ready. This is because for
>>> i225/i226, the timestamp notification comes some time after the transmit
>>> completion event. The driver will retrigger hardware irq to clean the
>>> packet after retrieve the tx hardware timestamp.
>>>
>>> Besides, a pointer named "xsk_meta" is added into igc_tx_timestamp_request
>>> structure as a hook to the metadata location of the transmit packet. When
>>> a Tx timestamp interrupt happens, the interrupt handler will copy the
>>> value of Tx timestamp into metadata via xsk_tx_metadata_complete().
>>>
>>> This patch is tested with tools/testing/selftests/bpf/xdp_hw_metadata
>>> on Intel ADL-S platform. Below are the test steps and results.
>>>
>>> Command on DUT:
>>> sudo ./xdp_hw_metadata <interface name>
>>> sudo hwstamp_ctl -i <interface name> -t 1 -r 1
>>> sudo ./testptp -d /dev/ptp0 -s
>>>
>>> Command on Link Partner:
>>> echo -n xdp | nc -u -q1 <destination IPv4 addr> 9091
>>>
>>> Result:
>>> xsk_ring_cons__peek: 1
>>> 0x555b112ae958: rx_desc[6]->addr=86110 addr=86110 comp_addr=86110 EoP
>>> rx_hash: 0xBFDEC36E with RSS type:0x1
>>> HW RX-time:   1677762429190040955 (sec:1677762429.1900) delta to User RX-time
>>sec:0.0001 (100.124 usec)
>>> XDP RX-time:   1677762429190123163 (sec:1677762429.1901) delta to User RX-time
>>sec:0.0000 (17.916 usec)
>>> 0x555b112ae958: ping-pong with csum=404e (want c59e) csum_start=34
>>csum_offset=6
>>> 0x555b112ae958: complete tx idx=6 addr=6010
>>> HW TX-complete-time:   1677762429190173323 (sec:1677762429.1902) delta to
>>User TX-complete-time sec:0.0100 (10035.884 usec)
>>> XDP RX-time:   1677762429190123163 (sec:1677762429.1901) delta to User TX-
>>complete-time sec:0.0101 (10086.044 usec)
>>> HW RX-time:   1677762429190040955 (sec:1677762429.1900) delta to HW TX-
>>complete-time sec:0.0001 (132.368 usec)
>>> 0x555b112ae958: complete rx idx=134 addr=86110
>>>
>>> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>>> ---
>>>  drivers/net/ethernet/intel/igc/igc.h      | 15 ++++
>>>  drivers/net/ethernet/intel/igc/igc_main.c | 88 ++++++++++++++++++++++-
>>>  drivers/net/ethernet/intel/igc/igc_ptp.c  | 42 ++++++++---
>>>  3 files changed, 134 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
>>> index ac7c861e83a0..c831dde01662 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc.h
>>> +++ b/drivers/net/ethernet/intel/igc/igc.h
>>> @@ -79,6 +79,9 @@ struct igc_tx_timestamp_request {
>>>  	u32 regl;              /* which TXSTMPL_{X} register should be used */
>>>  	u32 regh;              /* which TXSTMPH_{X} register should be used */
>>>  	u32 flags;             /* flags that should be added to the tx_buffer */
>>> +	u8 xsk_queue_index;    /* Tx queue which requesting timestamp */
>>> +	bool *xsk_pending_ts;  /* ref to tx ring for waiting timestamp event */
>>
>>I think that this indirection level to xsk_pending_ts in the tx_buffer is a
>>bit too hard to follow. What I am thinking is keeping a pointer to
>>tx_buffer here in igc_tx_timestamp_request, perhaps even in a union with
>>the skb, and use a similar logic, if that pointer is valid the timestamp
>>request is in use.
>>
>>Do you think it could work?
>>
>>(Perhaps we would need to also store the buffer type in the request, but
>>I don't think that would be too weird)
>>
>
> Hi Vinicius,
>
> Thanks for your comments. 
> Keep a pointer to tx_buffer will work. I will make the pointer a union
> with skb and use buffer_type to indicate whether skb or tx_buffer pointer should be use.
> Is this sound better? 
>

Yeah, that sounds better.

>>> +	struct xsk_tx_metadata_compl xsk_meta;	/* ref to xsk Tx metadata */
>>>  };
>>>
>>>  struct igc_inline_rx_tstamps {
>>> @@ -319,6 +322,9 @@ void igc_disable_tx_ring(struct igc_ring *ring);
>>>  void igc_enable_tx_ring(struct igc_ring *ring);
>>>  int igc_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags);
>>>
>>> +/* AF_XDP TX metadata operations */
>>> +extern const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops;
>>> +
>>>  /* igc_dump declarations */
>>>  void igc_rings_dump(struct igc_adapter *adapter);
>>>  void igc_regs_dump(struct igc_adapter *adapter);
>>> @@ -528,6 +534,7 @@ struct igc_tx_buffer {
>>>  	DEFINE_DMA_UNMAP_ADDR(dma);
>>>  	DEFINE_DMA_UNMAP_LEN(len);
>>>  	u32 tx_flags;
>>> +	bool xsk_pending_ts;
>>>  };
>>>
>>>  struct igc_rx_buffer {
>>> @@ -553,6 +560,14 @@ struct igc_xdp_buff {
>>>  	struct igc_inline_rx_tstamps *rx_ts; /* data indication bit
>>IGC_RXDADV_STAT_TSIP */
>>>  };
>>>
>>> +struct igc_metadata_request {
>>> +	struct xsk_tx_metadata *meta;
>>> +	struct igc_adapter *adapter;
>>
>>If you have access to the tx_ring, you have access to the adapter, no
>>need to have it here.
>
> Sure, I will remove it and use
> adapter = netdev_priv(tx_ring->netdev);
>
>>
>>> +	struct igc_ring *tx_ring;
>>> +	bool *xsk_pending_ts;
>>> +	u32 *cmd_type;
>>
>>I think this also would be clearer if here you had a pointer to the
>>tx_buffer instead of only 'xsk_pending_ts'.
>>
>
> No problem. I will try to use tx_buffer pointer.
>
>>I guess for cmd_type, no need for it to be a pointer, we can affort the
>>extra copy.
>>
>
> I use pointer because we need to bring out the value of cmd_type and put it into tx_desc:
> tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> In this case, do you think it is make sense to keep cmd_type pointer?
>

What I had in mind was having a simple 'u32 cmd_type' (not a pointer) in
'igc_metadata_request', and do something like:

    tx_desc->read.cmd_type_len = cpu_to_le32(meta_req.cmd_type);

>>> +};
>>> +
>>>  struct igc_q_vector {
>>>  	struct igc_adapter *adapter;    /* backlink */
>>>  	void __iomem *itr_register;
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>>b/drivers/net/ethernet/intel/igc/igc_main.c
>>> index 61db1d3bfa0b..311c85f2d82d 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>>> @@ -1553,7 +1553,7 @@ static bool igc_request_tx_tstamp(struct igc_adapter
>>*adapter, struct sk_buff *s
>>>  	for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>>>  		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
>>>
>>> -		if (tstamp->skb)
>>> +		if (tstamp->skb || tstamp->xsk_pending_ts)
>>>  			continue;
>>>
>>>  		tstamp->skb = skb_get(skb);
>>> @@ -2878,6 +2878,71 @@ static void igc_update_tx_stats(struct igc_q_vector
>>*q_vector,
>>>  	q_vector->tx.total_packets += packets;
>>>  }
>>>
>>> +static void igc_xsk_request_timestamp(void *_priv)
>>> +{
>>> +	struct igc_metadata_request *meta_req = _priv;
>>> +	struct igc_ring *tx_ring = meta_req->tx_ring;
>>> +	struct igc_tx_timestamp_request *tstamp;
>>> +	u32 *cmd_type = meta_req->cmd_type;
>>> +	u32 tx_flags = IGC_TX_FLAGS_TSTAMP;
>>> +	struct igc_adapter *adapter;
>>> +	unsigned long lock_flags;
>>> +	bool found = 0;
>>> +	int i;
>>> +
>>> +	if (test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags)) {
>>> +		adapter = meta_req->adapter;
>>> +
>>> +		spin_lock_irqsave(&adapter->ptp_tx_lock, lock_flags);
>>> +
>>> +		for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>>> +			tstamp = &adapter->tx_tstamp[i];
>>> +
>>> +			if (tstamp->skb || tstamp->xsk_pending_ts)
>>> +				continue;
>>> +
>>> +			found = 1;
>>
>>nitpick: found is a bool, 'true' would read better.
>>
>
> You are right. I will change it accordingly.
>
>>> +			break;
>>> +		}
>>> +
>>> +		if (!found) {
>>> +			adapter->tx_hwtstamp_skipped++;
>>
>>I think this is one those cases, that an early return or a goto would
>>make the code easier to understand.
>>
>
> Ok, I will unlock the tx_ptp_lock here and make an early return.
>
>>> +		} else {
>>> +			tstamp->start = jiffies;
>>> +			tstamp->xsk_queue_index = tx_ring->queue_index;
>>> +
>>> +			tstamp->xsk_pending_ts = meta_req->xsk_pending_ts;
>>> +			*tstamp->xsk_pending_ts = true;
>>> +
>>> +			xsk_tx_metadata_to_compl(meta_req->meta,
>>> +						 &tstamp->xsk_meta);
>>> +
>>> +			/* set timestamp bit based on the _TSTAMP(_X) bit. */
>>> +			tx_flags |= tstamp->flags;
>>> +			*cmd_type |= IGC_SET_FLAG(tx_flags,
>>IGC_TX_FLAGS_TSTAMP,
>>> +						  (IGC_ADVTXD_MAC_TSTAMP));
>>> +			*cmd_type |= IGC_SET_FLAG(tx_flags,
>>IGC_TX_FLAGS_TSTAMP_1,
>>> +						  (IGC_ADVTXD_TSTAMP_REG_1));
>>> +			*cmd_type |= IGC_SET_FLAG(tx_flags,
>>IGC_TX_FLAGS_TSTAMP_2,
>>> +						  (IGC_ADVTXD_TSTAMP_REG_2));
>>> +			*cmd_type |= IGC_SET_FLAG(tx_flags,
>>IGC_TX_FLAGS_TSTAMP_3,
>>> +						  (IGC_ADVTXD_TSTAMP_REG_3));
>>> +		}
>>> +
>>> +		spin_unlock_irqrestore(&adapter->ptp_tx_lock, lock_flags);
>>> +	}
>>> +}
>>> +
>>> +static u64 igc_xsk_fill_timestamp(void *_priv)
>>> +{
>>> +	return *(u64 *)_priv;
>>> +}
>>> +
>>> +const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops = {
>>> +	.tmo_request_timestamp		= igc_xsk_request_timestamp,
>>> +	.tmo_fill_timestamp		= igc_xsk_fill_timestamp,
>>> +};
>>> +
>>>  static void igc_xdp_xmit_zc(struct igc_ring *ring)
>>>  {
>>>  	struct xsk_buff_pool *pool = ring->xsk_pool;
>>> @@ -2899,6 +2964,8 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>>>  	budget = igc_desc_unused(ring);
>>>
>>>  	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
>>> +		struct igc_metadata_request meta_req;
>>> +		struct xsk_tx_metadata *meta = NULL;
>>>  		u32 cmd_type, olinfo_status;
>>>  		struct igc_tx_buffer *bi;
>>>  		dma_addr_t dma;
>>> @@ -2909,14 +2976,23 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>>>  		olinfo_status = xdp_desc.len << IGC_ADVTXD_PAYLEN_SHIFT;
>>>
>>>  		dma = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
>>> +		meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
>>>  		xsk_buff_raw_dma_sync_for_device(pool, dma, xdp_desc.len);
>>> +		bi = &ring->tx_buffer_info[ntu];
>>> +
>>> +		meta_req.adapter = netdev_priv(ring->netdev);
>>> +		meta_req.tx_ring = ring;
>>> +		meta_req.meta = meta;
>>> +		meta_req.cmd_type = &cmd_type;
>>> +		meta_req.xsk_pending_ts = &bi->xsk_pending_ts;
>>> +		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
>>> +					&meta_req);
>>>
>>>  		tx_desc = IGC_TX_DESC(ring, ntu);
>>>  		tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
>>>  		tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
>>>  		tx_desc->read.buffer_addr = cpu_to_le64(dma);
>>>
>>> -		bi = &ring->tx_buffer_info[ntu];
>>>  		bi->type = IGC_TX_BUFFER_TYPE_XSK;
>>>  		bi->protocol = 0;
>>>  		bi->bytecount = xdp_desc.len;
>>> @@ -2979,6 +3055,13 @@ static bool igc_clean_tx_irq(struct igc_q_vector
>>*q_vector, int napi_budget)
>>>  		if (!(eop_desc->wb.status & cpu_to_le32(IGC_TXD_STAT_DD)))
>>>  			break;
>>>
>>> +		/* Hold the completions while there's a pending tx hardware
>>> +		 * timestamp request from XDP Tx metadata.
>>> +		 */
>>> +		if (tx_buffer->type == IGC_TX_BUFFER_TYPE_XSK &&
>>> +		    tx_buffer->xsk_pending_ts)
>>> +			break;
>>> +
>>
>>One scenario that I am worried about the completion part is when tstamp
>>and non-tstamp packets are mixed in the same queue.
>>
>>For example, when the user sends a 1 tstamp packet followed by 1
>>non-tstamp packet. Some other ratios might be interesting to test as
>>well, 1:10 for example. I guess a simple bandwith test would be enough,
>>comparing "non-tstamp only" with mixed traffic.
>>
>>Perhaps are some bad recollections from the past, but I remember that
>>the hardware takes a bit of time when generating the timestamp
>>interrupts, and so those types of mixed traffic would have wasted
>>bandwidth.
>>
>
> Sure. I will try to perform some bandwidth test and share the result.
> I guess I will try to use iperf. 
> Any bandwidth test app that come into your mind?

I guess that for the mixed case, you could try something like use an
AF_XDP ZC enabled app and a tstamp-enabled one (that sends a tstamp
packet every, say 1ms) and see how large is the impact on the other app.

Or you could write a custom app with a configured ratio of tstamp to
non-tstamp packets.

The custom app would give more consistent feedback I think. The "two
apps" approach would be better for ballpark figures.

>
>>>  		/* clear next_to_watch to prevent false hangs */
>>>  		tx_buffer->next_to_watch = NULL;
>>>
>>> @@ -6819,6 +6902,7 @@ static int igc_probe(struct pci_dev *pdev,
>>>
>>>  	netdev->netdev_ops = &igc_netdev_ops;
>>>  	netdev->xdp_metadata_ops = &igc_xdp_metadata_ops;
>>> +	netdev->xsk_tx_metadata_ops = &igc_xsk_tx_metadata_ops;
>>>  	igc_ethtool_set_ops(netdev);
>>>  	netdev->watchdog_timeo = 5 * HZ;
>>>
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c
>>b/drivers/net/ethernet/intel/igc/igc_ptp.c
>>> index 885faaa7b9de..b722bca40309 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
>>> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
>>> @@ -11,6 +11,7 @@
>>>  #include <linux/ktime.h>
>>>  #include <linux/delay.h>
>>>  #include <linux/iopoll.h>
>>> +#include <net/xdp_sock.h>
>>>
>>>  #define INCVALUE_MASK		0x7fffffff
>>>  #define ISGN			0x80000000
>>> @@ -555,8 +556,15 @@ static void igc_ptp_clear_tx_tstamp(struct igc_adapter
>>*adapter)
>>>  	for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>>>  		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
>>>
>>> -		dev_kfree_skb_any(tstamp->skb);
>>> -		tstamp->skb = NULL;
>>> +		if (tstamp->skb) {
>>> +			dev_kfree_skb_any(tstamp->skb);
>>> +			tstamp->skb = NULL;
>>> +		} else if (tstamp->xsk_pending_ts) {
>>> +			*tstamp->xsk_pending_ts = false;
>>> +			tstamp->xsk_pending_ts = NULL;
>>> +			igc_xsk_wakeup(adapter->netdev, tstamp->xsk_queue_index,
>>> +				       0);
>>> +		}
>>>  	}
>>>
>>>  	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
>>> @@ -657,8 +665,15 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter
>>*adapter,
>>>  static void igc_ptp_tx_timeout(struct igc_adapter *adapter,
>>>  			       struct igc_tx_timestamp_request *tstamp)
>>>  {
>>> -	dev_kfree_skb_any(tstamp->skb);
>>> -	tstamp->skb = NULL;
>>> +	if (tstamp->skb) {
>>> +		dev_kfree_skb_any(tstamp->skb);
>>> +		tstamp->skb = NULL;
>>> +	} else if (tstamp->xsk_pending_ts) {
>>> +		*tstamp->xsk_pending_ts = false;
>>> +		tstamp->xsk_pending_ts = NULL;
>>> +		igc_xsk_wakeup(adapter->netdev, tstamp->xsk_queue_index, 0);
>>> +	}
>>> +
>>>  	adapter->tx_hwtstamp_timeouts++;
>>>
>>>  	netdev_warn(adapter->netdev, "Tx timestamp timeout\n");
>>> @@ -677,7 +692,7 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
>>>  	for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>>>  		tstamp = &adapter->tx_tstamp[i];
>>>
>>> -		if (!tstamp->skb)
>>> +		if (!tstamp->skb && !tstamp->xsk_pending_ts)
>>>  			continue;
>>>
>>>  		if (time_is_after_jiffies(tstamp->start + IGC_PTP_TX_TIMEOUT))
>>> @@ -705,7 +720,7 @@ static void igc_ptp_tx_reg_to_stamp(struct igc_adapter
>>*adapter,
>>>  	int adjust = 0;
>>>
>>>  	skb = tstamp->skb;
>>> -	if (!skb)
>>> +	if (!skb && !tstamp->xsk_pending_ts)
>>>  		return;
>>>
>>>  	if (igc_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval))
>>> @@ -729,10 +744,19 @@ static void igc_ptp_tx_reg_to_stamp(struct igc_adapter
>>*adapter,
>>>  	shhwtstamps.hwtstamp =
>>>  		ktime_add_ns(shhwtstamps.hwtstamp, adjust);
>>>
>>> -	tstamp->skb = NULL;
>>> +	if (skb) {
>>> +		tstamp->skb = NULL;
>>> +		skb_tstamp_tx(skb, &shhwtstamps);
>>> +		dev_kfree_skb_any(skb);
>>> +	} else {
>>> +		xsk_tx_metadata_complete(&tstamp->xsk_meta,
>>> +					 &igc_xsk_tx_metadata_ops,
>>> +					 &shhwtstamps.hwtstamp);
>>>
>>> -	skb_tstamp_tx(skb, &shhwtstamps);
>>> -	dev_kfree_skb_any(skb);
>>> +		*tstamp->xsk_pending_ts = false;
>>> +		tstamp->xsk_pending_ts = NULL;
>>> +		igc_xsk_wakeup(adapter->netdev, tstamp->xsk_queue_index, 0);
>>> +	}
>>>  }
>>>
>>>  /**
>>> --
>>> 2.34.1
>>>
>>
>>--
>>Vinicius
>
> Thanks & Regards
> Siang

-- 
Vinicius

