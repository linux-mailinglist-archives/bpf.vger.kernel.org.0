Return-Path: <bpf+bounces-41124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C390992DA3
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387B3283BD5
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F641D4326;
	Mon,  7 Oct 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t+K/tUZJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9bQhSUg2"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DB1BB6B8;
	Mon,  7 Oct 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308753; cv=none; b=mIT/IsZ1xSSts4SenamniT11200+r01uvUY3WT1OKf+3DwQhbdHr3ZQ3saVPBWyD3QMu7fp/Ajp5gtvboqipXbs5lXtmJiS/71hNCrJ/7/2KwLrGxfzRxmrwKQeUwoNrgj/hdYTpOQ5BzaQ5IGkRFfuSehyHBS/DD8wPzGT3DQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308753; c=relaxed/simple;
	bh=wERiVxDUZzBWTWcO9Wp4atKUEPuSU7CRcKe02h9SHvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m7LN19Rs3kuyWB4mdguwNqo1A8KvPZts2OikL9K6CRQhHHOLInIfj3EaVVVbOlMIiIsQy9PGvra6z3+P+aylEFM9w8WARS+PehT9pTXfH8JfX1Lp4YjLWWT2V++W2cmhPClndDQxWpH83aUH2IgR6Cd9TjvMd+PhLeKg4+vwsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t+K/tUZJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9bQhSUg2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728308749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tL/WCdqf35W3E1+SHwr/+dUAPvIjPLqy1+JN+gDaXpo=;
	b=t+K/tUZJ9QZTqoW+TzgMABeFLuqd97zYSMmUdWzkrYOJWhIiJA8c+Nw3uSi0+MwfduyfO7
	NB6uZkCV5fUKDJJNxeGlSLt27JgnhA2eFS55PrZlhwOG5RLzsfCWeIpe8sSbSvHgylXNUv
	wkgD0GNyM4Qku9FD5MvRTRL2jEpzXbvWXi3J1nXjUl6XxkZq+QdXO3+bUPio1fVmVXtW++
	XGbf17bD+TPbZkoizq3UO9ktaBOpZgJm93YRfUMrbSOPbWWz/1opcH9XdqoFeeEILrOUay
	yYEcECKfKyJNT6m0/ilC8l7mTGsGLsUvb6FIxVsjWri6ulWXy1RJrqlQd6/KBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728308749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tL/WCdqf35W3E1+SHwr/+dUAPvIjPLqy1+JN+gDaXpo=;
	b=9bQhSUg2ndOryhGWpJNePdCumOJoYyz9PoCbXwc7sLdkJluNpOdAfnRWep6yuioPJ0CL3Q
	dt+2Jw8dhBmE0jDw==
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Benjamin Steinke
 <benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v7 4/5] igb: Add AF_XDP zero-copy Rx support
In-Reply-To: <ZwPdOxJrk04D9FKn@boxer>
References: <20241007-b4-igb_zero_copy-v7-0-23556668adc6@linutronix.de>
 <20241007-b4-igb_zero_copy-v7-4-23556668adc6@linutronix.de>
 <ZwPdOxJrk04D9FKn@boxer>
Date: Mon, 07 Oct 2024 15:45:47 +0200
Message-ID: <87jzek3u2c.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On Mon Oct 07 2024, Maciej Fijalkowski wrote:
> On Mon, Oct 07, 2024 at 02:31:26PM +0200, Kurt Kanzenbach wrote:
>> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>>=20
>> Add support for AF_XDP zero-copy receive path.
>>=20
>> When AF_XDP zero-copy is enabled, the rx buffers are allocated from the
>> xsk buff pool using igb_alloc_rx_buffers_zc().
>>=20
>> Use xsk_pool_get_rx_frame_size() to set SRRCTL rx buf size when zero-copy
>> is enabled.
>>=20
>> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>> [Kurt: Port to v6.10 and provide napi_id for xdp_rxq_info_reg(),
>>        RCT, remove NETDEV_XDP_ACT_XSK_ZEROCOPY, update NTC handling,
>>        move stats update and xdp finalize to common functions,
>>        READ_ONCE() xsk_pool, likelyfy for XDP_REDIRECT case]
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>
> Hi Kurt,
>
> Sorry but still have comments :< see below.

No worries :)

>
>> ---
>>  drivers/net/ethernet/intel/igb/igb.h      |   8 +
>>  drivers/net/ethernet/intel/igb/igb_main.c | 132 +++++++++----
>>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 296 +++++++++++++++++++++++=
++++++-
>>  3 files changed, 398 insertions(+), 38 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet=
/intel/igb/igb.h
>> index c30d6f9708f8..ea3977b313fc 100644
>> --- a/drivers/net/ethernet/intel/igb/igb.h
>> +++ b/drivers/net/ethernet/intel/igb/igb.h
>> @@ -88,6 +88,7 @@ struct igb_adapter;
>>  #define IGB_XDP_CONSUMED	BIT(0)
>>  #define IGB_XDP_TX		BIT(1)
>>  #define IGB_XDP_REDIR		BIT(2)
>> +#define IGB_XDP_EXIT		BIT(3)
>>=20=20
>>  struct vf_data_storage {
>>  	unsigned char vf_mac_addresses[ETH_ALEN];
>> @@ -740,6 +741,9 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring);
>>  void igb_clean_rx_ring(struct igb_ring *rx_ring);
>>  void igb_configure_tx_ring(struct igb_adapter *, struct igb_ring *);
>>  void igb_configure_rx_ring(struct igb_adapter *, struct igb_ring *);
>> +void igb_finalize_xdp(struct igb_adapter *adapter, unsigned int status);
>> +void igb_update_rx_stats(struct igb_q_vector *q_vector, unsigned int pa=
ckets,
>> +			 unsigned int bytes);
>>  void igb_setup_tctl(struct igb_adapter *);
>>  void igb_setup_rctl(struct igb_adapter *);
>>  void igb_setup_srrctl(struct igb_adapter *, struct igb_ring *);
>> @@ -850,6 +854,10 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapt=
er *adapter,
>>  int igb_xsk_pool_setup(struct igb_adapter *adapter,
>>  		       struct xsk_buff_pool *pool,
>>  		       u16 qid);
>> +bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count);
>> +void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
>> +int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
>> +			struct xsk_buff_pool *xsk_pool, const int budget);
>>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
>>=20=20
>>  #endif /* _IGB_H_ */
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/eth=
ernet/intel/igb/igb_main.c
>> index bdba5c5861be..449ee794b3c9 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -472,12 +472,17 @@ static void igb_dump(struct igb_adapter *adapter)
>>=20=20
>>  		for (i =3D 0; i < rx_ring->count; i++) {
>>  			const char *next_desc;
>> -			struct igb_rx_buffer *buffer_info;
>> -			buffer_info =3D &rx_ring->rx_buffer_info[i];
>> +			dma_addr_t dma =3D (dma_addr_t)0;
>> +			struct igb_rx_buffer *buffer_info =3D NULL;
>>  			rx_desc =3D IGB_RX_DESC(rx_ring, i);
>>  			u0 =3D (struct my_u0 *)rx_desc;
>>  			staterr =3D le32_to_cpu(rx_desc->wb.upper.status_error);
>>=20=20
>> +			if (!rx_ring->xsk_pool) {
>> +				buffer_info =3D &rx_ring->rx_buffer_info[i];
>> +				dma =3D buffer_info->dma;
>> +			}
>> +
>>  			if (i =3D=3D rx_ring->next_to_use)
>>  				next_desc =3D " NTU";
>>  			else if (i =3D=3D rx_ring->next_to_clean)
>> @@ -497,11 +502,11 @@ static void igb_dump(struct igb_adapter *adapter)
>>  					"R  ", i,
>>  					le64_to_cpu(u0->a),
>>  					le64_to_cpu(u0->b),
>> -					(u64)buffer_info->dma,
>> +					(u64)dma,
>>  					next_desc);
>>=20=20
>>  				if (netif_msg_pktdata(adapter) &&
>> -				    buffer_info->dma && buffer_info->page) {
>> +				    buffer_info && dma && buffer_info->page) {
>>  					print_hex_dump(KERN_INFO, "",
>>  					  DUMP_PREFIX_ADDRESS,
>>  					  16, 1,
>> @@ -1983,7 +1988,10 @@ static void igb_configure(struct igb_adapter *ada=
pter)
>>  	 */
>>  	for (i =3D 0; i < adapter->num_rx_queues; i++) {
>>  		struct igb_ring *ring =3D adapter->rx_ring[i];
>> -		igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
>> +		if (ring->xsk_pool)
>> +			igb_alloc_rx_buffers_zc(ring, igb_desc_unused(ring));
>> +		else
>> +			igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
>>  	}
>>  }
>>=20=20
>> @@ -4405,7 +4413,8 @@ int igb_setup_rx_resources(struct igb_ring *rx_rin=
g)
>>  	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
>>  		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
>>  	res =3D xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
>> -			       rx_ring->queue_index, 0);
>> +			       rx_ring->queue_index,
>> +			       rx_ring->q_vector->napi.napi_id);
>>  	if (res < 0) {
>>  		dev_err(dev, "Failed to register xdp_rxq index %u\n",
>>  			rx_ring->queue_index);
>> @@ -4701,12 +4710,17 @@ void igb_setup_srrctl(struct igb_adapter *adapte=
r, struct igb_ring *ring)
>>  	struct e1000_hw *hw =3D &adapter->hw;
>>  	int reg_idx =3D ring->reg_idx;
>>  	u32 srrctl =3D 0;
>> +	u32 buf_size;
>>=20=20
>> -	srrctl =3D IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
>> -	if (ring_uses_large_buffer(ring))
>> -		srrctl |=3D IGB_RXBUFFER_3072 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
>> +	if (ring->xsk_pool)
>> +		buf_size =3D xsk_pool_get_rx_frame_size(ring->xsk_pool);
>> +	else if (ring_uses_large_buffer(ring))
>> +		buf_size =3D IGB_RXBUFFER_3072;
>>  	else
>> -		srrctl |=3D IGB_RXBUFFER_2048 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
>> +		buf_size =3D IGB_RXBUFFER_2048;
>> +
>> +	srrctl =3D IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
>> +	srrctl |=3D buf_size >> E1000_SRRCTL_BSIZEPKT_SHIFT;
>>  	srrctl |=3D E1000_SRRCTL_DESCTYPE_ADV_ONEBUF;
>>  	if (hw->mac.type >=3D e1000_82580)
>>  		srrctl |=3D E1000_SRRCTL_TIMESTAMP;
>> @@ -4738,9 +4752,17 @@ void igb_configure_rx_ring(struct igb_adapter *ad=
apter,
>>  	u32 rxdctl =3D 0;
>>=20=20
>>  	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
>> -	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
>> -					   MEM_TYPE_PAGE_SHARED, NULL));
>>  	WRITE_ONCE(ring->xsk_pool, igb_xsk_pool(adapter, ring));
>> +	if (ring->xsk_pool) {
>> +		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
>> +						   MEM_TYPE_XSK_BUFF_POOL,
>> +						   NULL));
>> +		xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
>> +	} else {
>> +		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
>> +						   MEM_TYPE_PAGE_SHARED,
>> +						   NULL));
>> +	}
>>=20=20
>>  	/* disable the queue */
>>  	wr32(E1000_RXDCTL(reg_idx), 0);
>> @@ -4767,9 +4789,12 @@ void igb_configure_rx_ring(struct igb_adapter *ad=
apter,
>>  	rxdctl |=3D IGB_RX_HTHRESH << 8;
>>  	rxdctl |=3D IGB_RX_WTHRESH << 16;
>>=20=20
>> -	/* initialize rx_buffer_info */
>> -	memset(ring->rx_buffer_info, 0,
>> -	       sizeof(struct igb_rx_buffer) * ring->count);
>> +	if (ring->xsk_pool)
>> +		memset(ring->rx_buffer_info_zc, 0,
>> +		       sizeof(*ring->rx_buffer_info_zc) * ring->count);
>> +	else
>> +		memset(ring->rx_buffer_info, 0,
>> +		       sizeof(*ring->rx_buffer_info) * ring->count);
>>=20=20
>>  	/* initialize Rx descriptor 0 */
>>  	rx_desc =3D IGB_RX_DESC(ring, 0);
>> @@ -4957,8 +4982,13 @@ void igb_free_rx_resources(struct igb_ring *rx_ri=
ng)
>>=20=20
>>  	rx_ring->xdp_prog =3D NULL;
>>  	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
>> -	vfree(rx_ring->rx_buffer_info);
>> -	rx_ring->rx_buffer_info =3D NULL;
>> +	if (rx_ring->xsk_pool) {
>> +		vfree(rx_ring->rx_buffer_info_zc);
>> +		rx_ring->rx_buffer_info_zc =3D NULL;
>> +	} else {
>> +		vfree(rx_ring->rx_buffer_info);
>> +		rx_ring->rx_buffer_info =3D NULL;
>> +	}
>>=20=20
>>  	/* if not set, then don't free */
>>  	if (!rx_ring->desc)
>> @@ -4996,6 +5026,11 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
>>  	dev_kfree_skb(rx_ring->skb);
>>  	rx_ring->skb =3D NULL;
>>=20=20
>> +	if (rx_ring->xsk_pool) {
>> +		igb_clean_rx_ring_zc(rx_ring);
>> +		goto skip_for_xsk;
>> +	}
>> +
>>  	/* Free all the Rx ring sk_buffs */
>>  	while (i !=3D rx_ring->next_to_alloc) {
>>  		struct igb_rx_buffer *buffer_info =3D &rx_ring->rx_buffer_info[i];
>> @@ -5023,6 +5058,7 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
>>  			i =3D 0;
>>  	}
>>=20=20
>> +skip_for_xsk:
>>  	rx_ring->next_to_alloc =3D 0;
>>  	rx_ring->next_to_clean =3D 0;
>>  	rx_ring->next_to_use =3D 0;
>> @@ -8177,6 +8213,7 @@ static int igb_poll(struct napi_struct *napi, int =
budget)
>>  	struct igb_q_vector *q_vector =3D container_of(napi,
>>  						     struct igb_q_vector,
>>  						     napi);
>> +	struct xsk_buff_pool *xsk_pool;
>>  	bool clean_complete =3D true;
>>  	int work_done =3D 0;
>>=20=20
>> @@ -8188,7 +8225,12 @@ static int igb_poll(struct napi_struct *napi, int=
 budget)
>>  		clean_complete =3D igb_clean_tx_irq(q_vector, budget);
>>=20=20
>>  	if (q_vector->rx.ring) {
>> -		int cleaned =3D igb_clean_rx_irq(q_vector, budget);
>> +		int cleaned;
>> +
>> +		xsk_pool =3D READ_ONCE(q_vector->rx.ring->xsk_pool);
>> +		cleaned =3D xsk_pool ?
>> +			igb_clean_rx_irq_zc(q_vector, xsk_pool, budget) :
>> +			igb_clean_rx_irq(q_vector, budget);
>>=20=20
>>  		work_done +=3D cleaned;
>>  		if (cleaned >=3D budget)
>> @@ -8852,6 +8894,38 @@ static void igb_put_rx_buffer(struct igb_ring *rx=
_ring,
>>  	rx_buffer->page =3D NULL;
>>  }
>>=20=20
>> +void igb_finalize_xdp(struct igb_adapter *adapter, unsigned int status)
>> +{
>> +	int cpu =3D smp_processor_id();
>> +	struct netdev_queue *nq;
>> +
>> +	if (status & IGB_XDP_REDIR)
>> +		xdp_do_flush();
>> +
>> +	if (status & IGB_XDP_TX) {
>> +		struct igb_ring *tx_ring =3D igb_xdp_tx_queue_mapping(adapter);
>> +
>> +		nq =3D txring_txq(tx_ring);
>> +		__netif_tx_lock(nq, cpu);
>> +		igb_xdp_ring_update_tail(tx_ring);
>> +		__netif_tx_unlock(nq);
>> +	}
>> +}
>> +
>> +void igb_update_rx_stats(struct igb_q_vector *q_vector, unsigned int pa=
ckets,
>> +			 unsigned int bytes)
>> +{
>> +	struct igb_ring *ring =3D q_vector->rx.ring;
>> +
>> +	u64_stats_update_begin(&ring->rx_syncp);
>> +	ring->rx_stats.packets +=3D packets;
>> +	ring->rx_stats.bytes +=3D bytes;
>> +	u64_stats_update_end(&ring->rx_syncp);
>> +
>> +	q_vector->rx.total_packets +=3D packets;
>> +	q_vector->rx.total_bytes +=3D bytes;
>> +}
>> +
>>  static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int bu=
dget)
>>  {
>>  	unsigned int total_bytes =3D 0, total_packets =3D 0;
>> @@ -8859,9 +8933,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q=
_vector, const int budget)
>>  	struct igb_ring *rx_ring =3D q_vector->rx.ring;
>>  	u16 cleaned_count =3D igb_desc_unused(rx_ring);
>>  	struct sk_buff *skb =3D rx_ring->skb;
>> -	int cpu =3D smp_processor_id();
>>  	unsigned int xdp_xmit =3D 0;
>> -	struct netdev_queue *nq;
>>  	struct xdp_buff xdp;
>>  	u32 frame_sz =3D 0;
>>  	int rx_buf_pgcnt;
>> @@ -8983,24 +9055,10 @@ static int igb_clean_rx_irq(struct igb_q_vector =
*q_vector, const int budget)
>>  	/* place incomplete frames back on ring for completion */
>>  	rx_ring->skb =3D skb;
>>=20=20
>> -	if (xdp_xmit & IGB_XDP_REDIR)
>> -		xdp_do_flush();
>> -
>> -	if (xdp_xmit & IGB_XDP_TX) {
>> -		struct igb_ring *tx_ring =3D igb_xdp_tx_queue_mapping(adapter);
>> -
>> -		nq =3D txring_txq(tx_ring);
>> -		__netif_tx_lock(nq, cpu);
>> -		igb_xdp_ring_update_tail(tx_ring);
>> -		__netif_tx_unlock(nq);
>> -	}
>> +	if (xdp_xmit)
>> +		igb_finalize_xdp(adapter, xdp_xmit);
>
> Nit: given you would be sending next revision, IMHO this is a candidate
> for a separate patch. Not a big deal but would reduce the noise in this
> one.

Yes, makes sense.

>
>>=20=20
>> -	u64_stats_update_begin(&rx_ring->rx_syncp);
>> -	rx_ring->rx_stats.packets +=3D total_packets;
>> -	rx_ring->rx_stats.bytes +=3D total_bytes;
>> -	u64_stats_update_end(&rx_ring->rx_syncp);
>> -	q_vector->rx.total_packets +=3D total_packets;
>> -	q_vector->rx.total_bytes +=3D total_bytes;
>> +	igb_update_rx_stats(q_vector, total_packets, total_bytes);
>
> This also.
>
>>=20=20
>>  	if (cleaned_count)
>>  		igb_alloc_rx_buffers(rx_ring, cleaned_count);
>> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethe=
rnet/intel/igb/igb_xsk.c
>> index 7b632be3e7e3..9fd094a799fa 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
>> @@ -70,7 +70,10 @@ static void igb_txrx_ring_enable(struct igb_adapter *=
adapter, u16 qid)
>>  	 * at least 1 descriptor unused to make sure
>>  	 * next_to_use !=3D next_to_clean
>>  	 */
>> -	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
>> +	if (rx_ring->xsk_pool)
>> +		igb_alloc_rx_buffers_zc(rx_ring, igb_desc_unused(rx_ring));
>> +	else
>> +		igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
>>=20=20
>>  	/* Rx/Tx share the same napi context. */
>>  	napi_enable(&rx_ring->q_vector->napi);
>> @@ -169,6 +172,297 @@ int igb_xsk_pool_setup(struct igb_adapter *adapter,
>>  		igb_xsk_pool_disable(adapter, qid);
>>  }
>>=20=20
>> +static u16 igb_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buf=
f **xdp,
>> +			     union e1000_adv_rx_desc *rx_desc, u16 count)
>> +{
>> +	dma_addr_t dma;
>> +	u16 buffs;
>> +	int i;
>> +
>> +	/* nothing to do */
>> +	if (!count)
>> +		return 0;
>> +
>> +	buffs =3D xsk_buff_alloc_batch(pool, xdp, count);
>> +	for (i =3D 0; i < buffs; i++) {
>> +		dma =3D xsk_buff_xdp_get_dma(*xdp);
>> +		rx_desc->read.pkt_addr =3D cpu_to_le64(dma);
>> +		rx_desc->wb.upper.length =3D 0;
>> +
>> +		rx_desc++;
>> +		xdp++;
>> +	}
>> +
>> +	return buffs;
>> +}
>> +
>> +bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count)
>> +{
>> +	u32 nb_buffs_extra =3D 0, nb_buffs =3D 0;
>> +	union e1000_adv_rx_desc *rx_desc;
>> +	u16 ntu =3D rx_ring->next_to_use;
>> +	u16 total_count =3D count;
>> +	struct xdp_buff **xdp;
>> +
>> +	rx_desc =3D IGB_RX_DESC(rx_ring, ntu);
>> +	xdp =3D &rx_ring->rx_buffer_info_zc[ntu];
>> +
>> +	if (ntu + count >=3D rx_ring->count) {
>> +		nb_buffs_extra =3D igb_fill_rx_descs(rx_ring->xsk_pool, xdp,
>> +						   rx_desc,
>> +						   rx_ring->count - ntu);
>
> Ehh wanted to ack this finally, but I believe that here you need to work
> on the pool pointer that was READ_ONCE() in igb_poll() in hot path and
> in igb_configure() pass rx_ring->xsk_pool as an argument.

Good catch, thanks!

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmcD5gsTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgvsHD/9gnH5WGPTjMENEQrLvvOfKrsC/ZFpj
uT25pCtHMwXhD8+1a9zVpnjSE53//SHO2YhdsbSGN4LZjsfuH+4VvIgK5d2xBJhp
QuIx16hBv7khOQENlGECY7GCtgnwwVYJ+0/wuH+a7+maR4dShqvjeVsOMcMLFTq4
zY/LCGJinoE/8YiPdjHZeXdPWCgPF367jTDUd+GPRP4BPBlGbdW2z0mB1jd87WnQ
/UfpckFsLBge7WZl26L7jxojEE8fiROUfv2WZolljJdq/yFkfQjHTJZE7nFPoc7G
BMAV9JzZx6Na4+lvGWjIgYKV8dcT2Jl8WkAPPpywy92jjynNFdyR667bjyTRjfuR
ax94iIC9mXSUQUT/HNtMXAxFMTb8qasGj0PEMkbujD/7qvybbVYejA8zS3VRmZhV
eeNuE6VfqSIj1rxmEe3cOXTd3+BbKfFlkWYlXNSy+XbfgD8EZltNEHw8wGTohxNG
gLZXVnNscWpENyzp+syThnc5Kwwq4BJvWeFddwp9i+Koy7mLhNa9MkmmViA9FX0t
IHi9gCicQUj5zE1tX9EoUaenxJfra8as3PBE23LYChxsALsmeW50drQfhqWgrISz
O93yA59BJ3GL8EMBLfhjQnuU0rA2ihqR6HX83gRaGDrKXruEaNolB0tCxmaOVEBV
FQ1hQSd/IOtsIQ==
=smS5
-----END PGP SIGNATURE-----
--=-=-=--

