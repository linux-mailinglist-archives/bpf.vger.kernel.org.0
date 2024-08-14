Return-Path: <bpf+bounces-37159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D679516B2
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 10:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123591F24386
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B564E13DDC6;
	Wed, 14 Aug 2024 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1BzCgrJ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LxFeso71"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065513C9A3;
	Wed, 14 Aug 2024 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723624597; cv=none; b=W9/XCK4GBagpH+w92nRSCNVQ9Boovbh1thA4xJa6wraP+pIHhBhUjxVFiWFyIe/uEDFDJaYr2Xbu0deZEOBnGFxjXsBMeM10yyl7Lo7lRpH01VgxKKl54901ZQfLA9hlS+fDIgqE9MA4RoBOGsrFrMgT4JTWsLVb/REUxVnDOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723624597; c=relaxed/simple;
	bh=VXCGZWQuWfTRAw65U8n6iAZqDA9V0VPlTJr2IadTOjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A1B94Y+tqdmWLsp/rjvLnvFRZp3wh85C7R8PZTwoBaGg0ZaHxIWnibpwolTHRqQAdKCRnXTelv7geKz2GtScbyjXxSDeXI8KM7TlCS81KpTfHnlL/WVhucbVf2N1RZ502DUKyIU9nMgH9dETCv8cxKY1g55hSa+Kr1tFrzmGsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1BzCgrJ5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LxFeso71; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723624594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQEiZAOw6fZAmQXa97WENJ1ydcrexOcWOenvv7CDZ5Q=;
	b=1BzCgrJ5kxkjecdhp/u/ZjQUJAVTeKEcSbiSL/Ck+bB8f7+T3823SbIz/2nxsW4V2otlrN
	Gg9RYsrTanmBWL1prKCRm+KRQqMKRaaFnniqkhcJVpiDsuQ3uqugLwI07G1gblYiDMG6Fx
	x22yUMBqxFbpgF5sbQPlgxlrmjHYfJT2QPewgdeGu5pTPZSjI9QYNsz8FPwARfjaebi4GM
	jZ5VaqGzolGLZEOnkCT6P8HCpfEXjhepbwsFqpH3FDP0Lg7ng+jkcgOIZyo2jnfxIghZ/0
	qUoQBc0cRvoZliU1NZ7OQQfbTbqdWFsweTgdZctS4OJgxkarmtUD7EIbYW38Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723624594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQEiZAOw6fZAmQXa97WENJ1ydcrexOcWOenvv7CDZ5Q=;
	b=LxFeso71GT04QSO6yzVnAdZXnvuip1VUgwzP+Ire7M1nwX53AQBEF0EKraW2hO4xjCgoeH
	x0jxTK7nbpOwfvAw==
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>, magnus.karlsson@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, sriram.yagnaraman@ericsson.com,
 richardcochran@gmail.com, benjamin.steinke@woks-audio.com,
 bigeasy@linutronix.de, Chandan Kumar
 Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net-next 4/4] igb: add AF_XDP zero-copy Tx support
In-Reply-To: <Zrd0vnsU2l0OTsvj@boxer>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-5-anthony.l.nguyen@intel.com>
 <Zrd0vnsU2l0OTsvj@boxer>
Date: Wed, 14 Aug 2024 10:36:32 +0200
Message-ID: <874j7nzejz.fsf@kurt.kurt.home>
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

On Sat Aug 10 2024, Maciej Fijalkowski wrote:
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
> This is also sub-optimal as you are setting RS bit on each Tx descriptor,
> which will in turn raise a lot of irqs. See how ice sets RS bit only on
> last desc from a batch and then, on cleaning side, how it finds a
> descriptor that is supposed to have DD bit written by HW.

I see your point. That requires changes to the cleaning side. However,
igb_clean_tx_irq() is shared between normal and zero-copy path.

The amount of irqs can be also controlled by irq coalescing or even
using busy polling. So I'd rather keep this implementation as simple as
it is now.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAma8bJATHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgsu1EACyPuTMVe5/qToYKpAfN5aDe86gXOX/
I7LvnY/eE6aiBSmqg1JnzK6WG+xygrQlM+6opnO1SfffjgPgiR2yCGBPH8l2XlUM
O6O9a2vwQ/Ov+YMFuvWkzulpRaQaW6l+ZoWcTJlIKu/Wah2y0f2r6u/L3EIm5HGm
Wsi4VYQMQv9wiffqOhus6VrbTY0Bq5IxwZa7fXt1zit0WqDMLX3VEdWHSErZ28uP
EsbvCoYDdOOnRaIgbcUM5t8QC4kzbi7LUEz8pMs9gOnc+wlkajkouBgMD1QjSHpo
DD9o8RTPGnii858HCFlCqgHmxS4gox7lkdkyyqOfsFMQuTkokhwqagEVAPUB/lSz
ix7BHR3yAvn9Fe24fstnjpvI44aSMoOk2r1fJ/M/KxhjrUO3Mlt7rgFI1k+h42BH
LSflRzC8tDekqtIkYUA6wW0CBS1Q238PFrWs1aktm03n/u6bHRke9KGrYHPE0LNo
027qze1Xbj55LIFWKUhUmLE1rxfxkZh2H9zGtTU11ub0cHweVUbiGa02s4IK+UJh
HHiASyLWMODoLVNv+Ubg5IQ/F+bMJlYEgV2X+0qs0LpGQd3j5NNq9S3sJuZMlZh0
GguH6LCvIVVkwJNRCR2eh8jb0P9GrrZmgIjHCE1OYx6K5L5OcDtwbYEWYgpg39fP
AktCRhSt+KmgHw==
=EK8e
-----END PGP SIGNATURE-----
--=-=-=--

