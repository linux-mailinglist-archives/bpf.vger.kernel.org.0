Return-Path: <bpf+bounces-41125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37BF992DAF
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 15:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5EB1F22CA6
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F631D4358;
	Mon,  7 Oct 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fcXenWxY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uycR1gYD"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA901D2B1B;
	Mon,  7 Oct 2024 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308886; cv=none; b=sKvIGgv7VLUtxU/LP8H8uu6e6yEz+ePhLED9bujTrW9wxuS2YZcj9g6/Sr9Qicdc2syFJk1apvF+jZTO1ejYpqCIKlLD7vWssUDxJpVIqGgXqXCagM8l4wDHZPAfiQZQQ2mEkQ+eEaEHak/NJBnagpyK4uKFh+HG5oV3Z134Vqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308886; c=relaxed/simple;
	bh=xo5Qc8fWt2E4M176sLxxEYhptKrDLxzLQqtDN34v9b0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f1pMFWR/e7O5/w3LHOrSfOvS42frZ1U/Kcd6jVn0z5Uc3IuHwbG1S003A5mzOX+OxEAabPR0VosjUlifawsHJgVTXhQPK2NSBCG80zd6e8McdRsnuU3ULTQ+XNoPdlSz+ymtIuI1uMMoRiaAW5ngWkYkiw8RLc5VMrU1liD8b5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fcXenWxY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uycR1gYD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728308883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/CMEPpVEE6fy3UEb+JX8XqWy4ReKkQZ2Nee5KJh8d/0=;
	b=fcXenWxYppf4B3MgjuL064fGlAUEFe1lUp1CKZVXRONISZCaqx34CPlgsA9H3QSGAbYqEK
	cjNvhGMGB7TLtyzmvfQAGl7ci9uo6to4sfuK6miJHymST2UKXaUxiqlisyyufbDIejlAkX
	qxw9Z1hIxAelAYaLwwf32j2XFt/fhzwP1tnXr7O1pZU2ymcbgl/DlXFIWgc9VEAYmlTxsu
	Ph5ZXfjoLr0tv2kxhaZ58obNzONOPNYrxXqvcw0U65tm0yq3l+WqNNXgy64njzlXE5aTp/
	b5evre4s09feOeHeZCa5ju6yUw/NpHhylZAjHn3n3+6Wsawkk4tXTuIlKyFLNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728308883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/CMEPpVEE6fy3UEb+JX8XqWy4ReKkQZ2Nee5KJh8d/0=;
	b=uycR1gYDgxQPnbwBcdIYakrl/MLcbeIXwkYNCh6hLRKdncJULrn57s71HsL7JlVFPJK8g4
	BVBnxR7dPoRnulAw==
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
Subject: Re: [PATCH iwl-next v7 5/5] igb: Add AF_XDP zero-copy Tx support
In-Reply-To: <ZwPfARyIRE+MvqyK@boxer>
References: <20241007-b4-igb_zero_copy-v7-0-23556668adc6@linutronix.de>
 <20241007-b4-igb_zero_copy-v7-5-23556668adc6@linutronix.de>
 <ZwPfARyIRE+MvqyK@boxer>
Date: Mon, 07 Oct 2024 15:48:01 +0200
Message-ID: <87h69o3tym.fsf@kurt.kurt.home>
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

On Mon Oct 07 2024, Maciej Fijalkowski wrote:
>> +bool igb_xmit_zc(struct igb_ring *tx_ring)
>> +{
>> +	unsigned int budget = igb_desc_unused(tx_ring);
>> +	struct xsk_buff_pool *pool = tx_ring->xsk_pool;
>> +	u32 cmd_type, olinfo_status, nb_pkts, i = 0;
>> +	struct xdp_desc *descs = pool->tx_descs;
>> +	union e1000_adv_tx_desc *tx_desc = NULL;
>> +	struct igb_tx_buffer *tx_buffer_info;
>> +	unsigned int total_bytes = 0;
>> +	dma_addr_t dma;
>> +
>> +	if (!netif_carrier_ok(tx_ring->netdev))
>> +		return true;
>> +
>> +	if (test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags))
>> +		return true;
>> +
>> +	nb_pkts = xsk_tx_peek_release_desc_batch(pool, budget);
>> +	if (!nb_pkts)
>> +		return true;
>> +
>> +	while (nb_pkts-- > 0) {
>> +		dma = xsk_buff_raw_get_dma(pool, descs[i].addr);
>> +		xsk_buff_raw_dma_sync_for_device(pool, dma, descs[i].len);
>> +
>> +		tx_buffer_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
>> +		tx_buffer_info->bytecount = descs[i].len;
>> +		tx_buffer_info->type = IGB_TYPE_XSK;
>> +		tx_buffer_info->xdpf = NULL;
>> +		tx_buffer_info->gso_segs = 1;
>> +		tx_buffer_info->time_stamp = jiffies;
>> +
>> +		tx_desc = IGB_TX_DESC(tx_ring, tx_ring->next_to_use);
>> +		tx_desc->read.buffer_addr = cpu_to_le64(dma);
>> +
>> +		/* put descriptor type bits */
>> +		cmd_type = E1000_ADVTXD_DTYP_DATA | E1000_ADVTXD_DCMD_DEXT |
>> +			   E1000_ADVTXD_DCMD_IFCS;
>> +		olinfo_status = descs[i].len << E1000_ADVTXD_PAYLEN_SHIFT;
>> +
>> +		cmd_type |= descs[i].len | IGB_TXD_DCMD;
>
> I forgot if we spoke about this but you still set RS bit for each produced
> desc. Probably we agreed that since cleaning side is shared with 'slow'
> path it would be too much of an effort to address that?

Yes, and i believe we agreed that this needs to be addressed later, also
for igc.

>
> Could you add a FIXME/TODO here so that we won't lose this from our
> radars?

Sure.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmcD5pETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgsWdD/9yy16yaYLB4R5GpXSpQa/47OdSmlNU
38nE4hLd6bLrnhVvu5XEoglQyPn0jciYPw69b45JXi5y/Fe/Whegtw+jYC8/StB1
j3RPnd47yX5vvmwn6+413ybpiE+fk1yBKmhjhMj8VLjGb6ejFC7J6L65q0k4CvbZ
jx1XfF+0b58+ZTyjSLAi3KJhjkMFfsmdosVm6Rqqqeui5ZICTXTrjKWizj/8rDR0
nv4DLRFgPdhYpD+xbjtDT5D7eBnkXI3kwznQHdVreimI2Niv5TOqc9vHa8RIbqHw
rdFK3ihLAmcKm4vApDXdHnkAl3SQMdWQX5JNE+X4DL4Cd1DP2iMpsXYn9RNgtdw+
2Ogmn9joZiVrtXAzt0aijkXzQFO8S7fo36EjJ8Wkx9mMHcUjHth1WJn3i/tB/1+5
Y/m0HxSvGGreoQ1ApECJJkToYcaWZwmyd66C7u2mg0jQSEipqtTavFNWyaBIq7OR
REIlkZTfoRaa7mrcJXMEbNprJGFZwQ3VlXUii7ps02Yce35+QAZF5cB44IPue77O
5uWWIWKX2QGMyXdx2NTSWngo0iidI+VQfxBNKut5zIcBBEBxZDOjumJevWedPsrV
3SlQOW3uoopIdRbu18Cw3TZQoSR2/Nxn6zfWO3R+pyplWRH3gDWcrVW7Dewic+2v
PYzAZE+2VlG36w==
=b4js
-----END PGP SIGNATURE-----
--=-=-=--

