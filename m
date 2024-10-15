Return-Path: <bpf+bounces-42080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D874299F3D4
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 19:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51ED8B21EEE
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 17:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBE1F9EDB;
	Tue, 15 Oct 2024 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oDhb3LDa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wJt5OPPc"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F841494DF;
	Tue, 15 Oct 2024 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012592; cv=none; b=nEsywH7mxPxnIzpUlJg+5BDsVa0rc13j7ANehzANOk+aWqaghgOC8frQlEOtil8pYY+qOQ5z0W3ueLrvdt9oPjVarEviSwx4IU2JbCjtOffhGylATBapYXBRCFg9poD5DdF9BPPNlTd5UduvC/qUp4mTMktQL7BIe5kMRW83Jik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012592; c=relaxed/simple;
	bh=eFhj3cgwwwxIeKbxqOEArLXuB46kzKuMbqmwa/E+7CI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q1Vos8Nx8+f1eF+HpsZWy0gkClqMYjKxoSpzXfEiMNKAgjMvv/fwRsYwFQu4XpBLuvbNX5UGnVS74LtpKLyJPkhiSqkTD1snZV5tPJdWsN1VQ40J0T4l09CVMY/MmPO+Pkm6UfKP/lGD0FGpvRMFxnT56i7bTHhMmYB0ru+Sb4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oDhb3LDa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wJt5OPPc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729012587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7OBgULFgo0E6fdM/oAmCKutFjhQegDdfbfj5nGDAZKc=;
	b=oDhb3LDa5vj/VAspFGdQ9EIDhBPWMrVXoS0dDV0ILbpz+dMY2pSLn1lEulQIzID5YQkFbU
	zXnuLxCKmRjTLt+xpzcb5q8Hh+QDJVN6sER0GOaJCaauA3hy01SdRExGhrNpv4vUK8BgFP
	zvs/E6LXfidQRnfg47zH8VN+4VIYLAakgYvgMxC2XOcaIR5QZ+F6UgUlbDH8SFIWaE0JSM
	/9iWAYtpm9S4mQxBQYU4a7BtvxOPy108+bYJvJcNxDquiXo2i0UOZx3sxPoaE0YqY/i8bK
	MQrsR1dzczCIYczN20/2lbhgJCL9XD873Jd6oU1N2G5CTpw8kmUZWJKuUmovbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729012587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7OBgULFgo0E6fdM/oAmCKutFjhQegDdfbfj5nGDAZKc=;
	b=wJt5OPPc3ngYGsJEDFjmD4HCCWhw7aTMnR4hzTSwwv+SnPIVTQE/ZuvQh4Aaw/NuPzPB70
	nCzSMg6RHDJztCAg==
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Benjamin Steinke
 <benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v8 6/6] igb: Add AF_XDP zero-copy Tx support
In-Reply-To: <Zw5uBZa7+Iy5qD1t@boxer>
References: <20241011-b4-igb_zero_copy-v8-0-83862f726a9e@linutronix.de>
 <20241011-b4-igb_zero_copy-v8-6-83862f726a9e@linutronix.de>
 <Zw5uBZa7+Iy5qD1t@boxer>
Date: Tue, 15 Oct 2024 19:16:25 +0200
Message-ID: <875xptnv6e.fsf@kurt.kurt.home>
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

On Tue Oct 15 2024, Maciej Fijalkowski wrote:
> On Fri, Oct 11, 2024 at 11:01:04AM +0200, Kurt Kanzenbach wrote:
>> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>>=20
>> Add support for AF_XDP zero-copy transmit path.
>>=20
>> A new TX buffer type IGB_TYPE_XSK is introduced to indicate that the Tx
>> frame was allocated from the xsk buff pool, so igb_clean_tx_ring() and
>> igb_clean_tx_irq() can clean the buffers correctly based on type.
>>=20
>> igb_xmit_zc() performs the actual packet transmit when AF_XDP zero-copy =
is
>> enabled. We share the TX ring between slow path, XDP and AF_XDP
>> zero-copy, so we use the netdev queue lock to ensure mutual exclusion.
>>=20
>> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>> [Kurt: Set olinfo_status in igb_xmit_zc() so that frames are transmitted,
>>        Use READ_ONCE() for xsk_pool and check Tx disabled and carrier in
>>        igb_xmit_zc(), Add FIXME for RS bit]
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> ---
>>  drivers/net/ethernet/intel/igb/igb.h      |  2 +
>>  drivers/net/ethernet/intel/igb/igb_main.c | 61 ++++++++++++++++++++++++=
-----
>>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 64 ++++++++++++++++++++++++=
+++++++
>>  3 files changed, 117 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet=
/intel/igb/igb.h
>> index e4a85867aa18..f6ac74327bb3 100644
>> --- a/drivers/net/ethernet/intel/igb/igb.h
>> +++ b/drivers/net/ethernet/intel/igb/igb.h
>> @@ -258,6 +258,7 @@ enum igb_tx_flags {
>>  enum igb_tx_buf_type {
>>  	IGB_TYPE_SKB =3D 0,
>>  	IGB_TYPE_XDP,
>> +	IGB_TYPE_XSK
>>  };
>>=20=20
>>  /* wrapper around a pointer to a socket buffer,
>> @@ -859,6 +860,7 @@ bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_rin=
g,
>>  void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
>>  int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
>>  			struct xsk_buff_pool *xsk_pool, const int budget);
>> +bool igb_xmit_zc(struct igb_ring *tx_ring);
>>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
>>=20=20
>>  #endif /* _IGB_H_ */
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/eth=
ernet/intel/igb/igb_main.c
>> index 711b60cab594..5f396c02e3b9 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -2979,6 +2979,9 @@ static int igb_xdp_xmit(struct net_device *dev, in=
t n,
>>  	if (unlikely(!tx_ring))
>>  		return -ENXIO;
>>=20=20
>> +	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
>> +		return -ENXIO;
>> +
>>  	nq =3D txring_txq(tx_ring);
>>  	__netif_tx_lock(nq, cpu);
>>=20=20
>> @@ -3326,7 +3329,8 @@ static int igb_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
>>  	netdev->priv_flags |=3D IFF_SUPP_NOFCS;
>>=20=20
>>  	netdev->priv_flags |=3D IFF_UNICAST_FLT;
>> -	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIREC=
T;
>> +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIREC=
T |
>> +			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
>>=20=20
>>  	/* MTU range: 68 - 9216 */
>>  	netdev->min_mtu =3D ETH_MIN_MTU;
>> @@ -4900,15 +4904,20 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
>>  {
>>  	u16 i =3D tx_ring->next_to_clean;
>>  	struct igb_tx_buffer *tx_buffer =3D &tx_ring->tx_buffer_info[i];
>> +	u32 xsk_frames =3D 0;
>>=20=20
>>  	while (i !=3D tx_ring->next_to_use) {
>>  		union e1000_adv_tx_desc *eop_desc, *tx_desc;
>>=20=20
>>  		/* Free all the Tx ring sk_buffs or xdp frames */
>> -		if (tx_buffer->type =3D=3D IGB_TYPE_SKB)
>> +		if (tx_buffer->type =3D=3D IGB_TYPE_SKB) {
>>  			dev_kfree_skb_any(tx_buffer->skb);
>> -		else
>> +		} else if (tx_buffer->type =3D=3D IGB_TYPE_XDP) {
>>  			xdp_return_frame(tx_buffer->xdpf);
>> +		} else if (tx_buffer->type =3D=3D IGB_TYPE_XSK) {
>> +			xsk_frames++;
>> +			goto skip_for_xsk;
>> +		}
>>=20=20
>>  		/* unmap skb header data */
>>  		dma_unmap_single(tx_ring->dev,
>> @@ -4939,6 +4948,7 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
>>  					       DMA_TO_DEVICE);
>>  		}
>>=20=20
>> +skip_for_xsk:
>>  		tx_buffer->next_to_watch =3D NULL;
>>=20=20
>>  		/* move us one more past the eop_desc for start of next pkt */
>> @@ -4953,6 +4963,9 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
>>  	/* reset BQL for queue */
>>  	netdev_tx_reset_queue(txring_txq(tx_ring));
>>=20=20
>> +	if (tx_ring->xsk_pool && xsk_frames)
>> +		xsk_tx_completed(tx_ring->xsk_pool, xsk_frames);
>> +
>>  	/* reset next_to_use and next_to_clean */
>>  	tx_ring->next_to_use =3D 0;
>>  	tx_ring->next_to_clean =3D 0;
>> @@ -6486,6 +6499,9 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *sk=
b,
>>  		return NETDEV_TX_BUSY;
>>  	}
>>=20=20
>> +	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
>> +		return NETDEV_TX_BUSY;
>> +
>>  	/* record the location of the first descriptor for this packet */
>>  	first =3D &tx_ring->tx_buffer_info[tx_ring->next_to_use];
>>  	first->type =3D IGB_TYPE_SKB;
>> @@ -8260,13 +8276,18 @@ static int igb_poll(struct napi_struct *napi, in=
t budget)
>>   **/
>>  static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_bu=
dget)
>>  {
>> -	struct igb_adapter *adapter =3D q_vector->adapter;
>> -	struct igb_ring *tx_ring =3D q_vector->tx.ring;
>> -	struct igb_tx_buffer *tx_buffer;
>> -	union e1000_adv_tx_desc *tx_desc;
>>  	unsigned int total_bytes =3D 0, total_packets =3D 0;
>> +	struct igb_adapter *adapter =3D q_vector->adapter;
>>  	unsigned int budget =3D q_vector->tx.work_limit;
>> +	struct igb_ring *tx_ring =3D q_vector->tx.ring;
>>  	unsigned int i =3D tx_ring->next_to_clean;
>> +	union e1000_adv_tx_desc *tx_desc;
>> +	struct igb_tx_buffer *tx_buffer;
>> +	struct xsk_buff_pool *xsk_pool;
>> +	int cpu =3D smp_processor_id();
>> +	bool xsk_xmit_done =3D true;
>> +	struct netdev_queue *nq;
>> +	u32 xsk_frames =3D 0;
>>=20=20
>>  	if (test_bit(__IGB_DOWN, &adapter->state))
>>  		return true;
>> @@ -8297,10 +8318,14 @@ static bool igb_clean_tx_irq(struct igb_q_vector=
 *q_vector, int napi_budget)
>>  		total_packets +=3D tx_buffer->gso_segs;
>>=20=20
>>  		/* free the skb */
>> -		if (tx_buffer->type =3D=3D IGB_TYPE_SKB)
>> +		if (tx_buffer->type =3D=3D IGB_TYPE_SKB) {
>>  			napi_consume_skb(tx_buffer->skb, napi_budget);
>> -		else
>> +		} else if (tx_buffer->type =3D=3D IGB_TYPE_XDP) {
>>  			xdp_return_frame(tx_buffer->xdpf);
>> +		} else if (tx_buffer->type =3D=3D IGB_TYPE_XSK) {
>> +			xsk_frames++;
>> +			goto skip_for_xsk;
>> +		}
>>=20=20
>>  		/* unmap skb header data */
>>  		dma_unmap_single(tx_ring->dev,
>> @@ -8332,6 +8357,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *=
q_vector, int napi_budget)
>>  			}
>>  		}
>>=20=20
>> +skip_for_xsk:
>>  		/* move us one more past the eop_desc for start of next pkt */
>>  		tx_buffer++;
>>  		tx_desc++;
>> @@ -8360,6 +8386,21 @@ static bool igb_clean_tx_irq(struct igb_q_vector =
*q_vector, int napi_budget)
>>  	q_vector->tx.total_bytes +=3D total_bytes;
>>  	q_vector->tx.total_packets +=3D total_packets;
>>=20=20
>> +	xsk_pool =3D READ_ONCE(tx_ring->xsk_pool);
>> +	if (xsk_pool) {
>> +		if (xsk_frames)
>> +			xsk_tx_completed(xsk_pool, xsk_frames);
>> +		if (xsk_uses_need_wakeup(xsk_pool))
>> +			xsk_set_tx_need_wakeup(xsk_pool);
>> +
>> +		nq =3D txring_txq(tx_ring);
>> +		__netif_tx_lock(nq, cpu);
>> +		/* Avoid transmit queue timeout since we share it with the slow path =
*/
>> +		txq_trans_cond_update(nq);
>> +		xsk_xmit_done =3D igb_xmit_zc(tx_ring);
>> +		__netif_tx_unlock(nq);
>> +	}
>> +
>>  	if (test_bit(IGB_RING_FLAG_TX_DETECT_HANG, &tx_ring->flags)) {
>>  		struct e1000_hw *hw =3D &adapter->hw;
>>=20=20
>> @@ -8422,7 +8463,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *=
q_vector, int napi_budget)
>>  		}
>>  	}
>>=20=20
>> -	return !!budget;
>> +	return !!budget && xsk_xmit_done;
>>  }
>>=20=20
>>  /**
>> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethe=
rnet/intel/igb/igb_xsk.c
>> index 22d234db0fab..d962c5e22b71 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
>> @@ -465,6 +465,70 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vect=
or,
>>  	return failure ? budget : (int)total_packets;
>>  }
>>=20=20
>> +bool igb_xmit_zc(struct igb_ring *tx_ring)
>> +{
>> +	unsigned int budget =3D igb_desc_unused(tx_ring);
>> +	struct xsk_buff_pool *pool =3D tx_ring->xsk_pool;
>
> Ughh that's another read of pool ptr, you should have passed it by arg to
> igb_xmit_zc()...

Ups, missed that somehow. Thanks!

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmcOo2kTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgtKMD/42b3RGlHmSKn2PyoIO2tgv9q+JmRdi
/R5QR9SNRnwZFIRVfB1Bez+d3kLcJCNX4GM1oG/wyPxkViLQAjFbNtXgZ32w/z98
o05iEW1vBbw2bZIuDiYF3yH0nZuyNF4PaS15QYkDz7jOpD1MQFI6F+fcP0dOmwSQ
yFHibxWp106Xgo9xuJwsBXr+rOsc3BjUwLfDDCiu6KhBtll25nNdrxp0B6aBYzkH
ja0G0s5l1dEQMC8kDxmVvizPh8H0WkTMdY8/IUXLFmoIY8CmkVE4z+u+9SGcq5gz
AtmZQlwW5EB9U6A0bX1JlVUSLQYB/Krnfd9WLnkcTquE7Uss2jrmADoMkOqlp20y
KxaImdFP551IM3/xyKJRTfC8Kfn1haiqhUG0ggbRN5MYnfNLCTSgUCpMvAp7fVQG
fK5ayhtUMATdkvX5hFih4pSh0+uqG2uWeSlIMz+ldv0M3IdK/wBbEseYZOEBzv7K
35Ysj4XiKND8FWWAo7G6d+8rrwJ5q4rZvWzy3+X7/CLtnBe35sL7wLTUhyOWwvzm
1G/KWJm01zCR85jCpNQMKlof++TR2llOTH8QF1h/ufsaJXeVsZRLq4BHzQGso1gQ
YFX9lsFJJ3vVgEnFQ9lZGJDDheYNqLMEWHX4qWL7WuPvU9ZRvpYp7Ll48+L9i/pG
NFq3Qw2Br15WwA==
=drIZ
-----END PGP SIGNATURE-----
--=-=-=--

