Return-Path: <bpf+bounces-37164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2B995176C
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 11:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611041C214D6
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD63143C5F;
	Wed, 14 Aug 2024 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WaEU8Xtf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4LYLFcpB"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9251016;
	Wed, 14 Aug 2024 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626755; cv=none; b=NfjSA/3X4w5BQNZh3yniGZ6KmPL8pvwEUHuR+R3+gLx5ErnQzZ4JrjreUBvdYKND2UX9DMwib8BNpiMx7wK6TN4FJM4p0Aqcb6I8hZ/+Q/+Fd4nTB5pn831wwBRX0cOmsPf8chaaGB3oAimiRsV8AWofxaAoRXTgSf4hJ1hsb7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626755; c=relaxed/simple;
	bh=vUDzFHyeLTwRTSAHAzsXGSNcaLJoDOOgxk2LxkpoFXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U4EZ6gPbCqBAzFScchoXTmiGFf/c+McIAzH/8Uhe4qZikqK8boQZ+V3o2FcL3JQEe0AaoWG7bP2e6sBjflzDFn4/QCQhxPtC0yt7RZHq0nbbEuIrG8o7udWLFtYeWpFAeB2YSheFgrzlodexgqC2JMSDcu9xRmi2Iu9HTjgOYp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WaEU8Xtf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4LYLFcpB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723626752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=772casCPZxLKonJvdo774FKG4e7auqm+TrxX53zerPg=;
	b=WaEU8XtfW8Y0r/93yEMP3WmzPFesN+fNFMdwFqIN4LohO6dr+IN2HMzp7xSDXZxQGBnKXi
	wuMr0Zs7RGatDFF7O8dfHFzxL14dHgFU1LPkQX7Y+kElY87C3PZDnXWwB0pJY29ygThFr6
	h6+Y0in3fm8gnZ0I3r1iUZ2ElfvhpOI29uaYgAi3d0Xc8oD8esyCVtXmODJpzHvW9gsXTK
	wtWY3JeLSZ6ehtWLxF459l0Pw/dA6OKlyL4yydrufjBQiV1jlmy501X49aty0OE3NCXnv/
	XWFwOGFXIvj4oWVWtG6JR0VoB5m3DcLEK6Xe9nCQlfWmXk3YKn5aYK+t6t6cMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723626752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=772casCPZxLKonJvdo774FKG4e7auqm+TrxX53zerPg=;
	b=4LYLFcpBGCG6C/JLS2mZnyHYdfKAIstHcrmWCcbIVOKDYyfLO+uEj++YnMqgrbLf0KIefv
	en5r94w4Q2Qv6PBA==
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
 sriram.yagnaraman@ericsson.com, richardcochran@gmail.com,
 benjamin.steinke@woks-audio.com, bigeasy@linutronix.de, Chandan Kumar
 Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net-next 4/4] igb: add AF_XDP zero-copy Tx support
In-Reply-To: <Zrxw+FI7rbYHXN2d@boxer>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-5-anthony.l.nguyen@intel.com>
 <Zrd0vnsU2l0OTsvj@boxer> <874j7nzejz.fsf@kurt.kurt.home>
 <Zrxw+FI7rbYHXN2d@boxer>
Date: Wed, 14 Aug 2024 11:12:30 +0200
Message-ID: <871q2rzcw1.fsf@kurt.kurt.home>
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

On Wed Aug 14 2024, Maciej Fijalkowski wrote:
> On Wed, Aug 14, 2024 at 10:36:32AM +0200, Kurt Kanzenbach wrote:
>> On Sat Aug 10 2024, Maciej Fijalkowski wrote:
>> >> +	nb_pkts =3D xsk_tx_peek_release_desc_batch(pool, budget);
>> >> +	if (!nb_pkts)
>> >> +		return true;
>> >> +
>> >> +	while (nb_pkts-- > 0) {
>> >> +		dma =3D xsk_buff_raw_get_dma(pool, descs[i].addr);
>> >> +		xsk_buff_raw_dma_sync_for_device(pool, dma, descs[i].len);
>> >> +
>> >> +		tx_buffer_info =3D &tx_ring->tx_buffer_info[tx_ring->next_to_use];
>> >> +		tx_buffer_info->bytecount =3D descs[i].len;
>> >> +		tx_buffer_info->type =3D IGB_TYPE_XSK;
>> >> +		tx_buffer_info->xdpf =3D NULL;
>> >> +		tx_buffer_info->gso_segs =3D 1;
>> >> +		tx_buffer_info->time_stamp =3D jiffies;
>> >> +
>> >> +		tx_desc =3D IGB_TX_DESC(tx_ring, tx_ring->next_to_use);
>> >> +		tx_desc->read.buffer_addr =3D cpu_to_le64(dma);
>> >> +
>> >> +		/* put descriptor type bits */
>> >> +		cmd_type =3D E1000_ADVTXD_DTYP_DATA | E1000_ADVTXD_DCMD_DEXT |
>> >> +			   E1000_ADVTXD_DCMD_IFCS;
>> >> +		olinfo_status =3D descs[i].len << E1000_ADVTXD_PAYLEN_SHIFT;
>> >> +
>> >> +		cmd_type |=3D descs[i].len | IGB_TXD_DCMD;
>> >
>> > This is also sub-optimal as you are setting RS bit on each Tx descript=
or,
>> > which will in turn raise a lot of irqs. See how ice sets RS bit only on
>> > last desc from a batch and then, on cleaning side, how it finds a
>> > descriptor that is supposed to have DD bit written by HW.
>>=20
>> I see your point. That requires changes to the cleaning side. However,
>> igb_clean_tx_irq() is shared between normal and zero-copy path.
>
> Ok if that's too much of a hassle then let's leave it as-is. I can address
> that in some nearby future.

How would you do that, by adding a dedicated igb_clean_tx_irq_zc()
function? Or is there a more simple way?

BTW: This needs to be addressed in igc too.

>
>>=20
>> The amount of irqs can be also controlled by irq coalescing or even
>> using busy polling. So I'd rather keep this implementation as simple as
>> it is now.
>
> That has nothing to do with what I was describing.

Ok, maybe I misunderstood your suggestion. It seemed to me that adding
the RS bit to the last frame of the burst will reduce the amount of
raised irqs.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAma8dP4THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzggrdD/9BfXH6fGp+potTmQvrCvFzPhUjDPOg
dqEWToijLBnOVf3e7gLP0kkL1DxFYlPivYaaHhbOH199X2PKJbYINbs3ZfuJaf4M
U8qRW+4xAuT65XMXC+nA2W93EDnPnUKJei85eCQGHL9+RA4hQm/A9I6CwQDAqMBo
wWdJOwWdFhtgHLKY7NXOOX+20MiZkThnR3NcLNuA+o4RBmUOd0CKxPrT5HASUa33
EpLI5r5QTZgZNJcNfWAqdQL8ZT2swW8KtEFXsQfZPjqrpR7lCtx61AeZBnAmbm8z
b1zVwSn6cVZUMRI/uGhUTgczYT+1m+v4Nve6DntzjpcRgiRyMPkIiSgFZu9dTKhf
ZrV5wD43Q1e1EeTNfZgqfFgAJiLPi9cjC5a7we2NhzbJiNeEw0uIMBxBAsO5KPq6
JOM5XYkQzRer4+4GbCqOOeQMw/3LGQw8tgRTT6bGDnPM5wFZ1UVVeJqy5abU4T8N
R9BnFqNY+aAGIBpXIJ6cKd7k/NFiFA6ZZMvaKv/taS/FFqcIJudhsCQ+0NTGvpWV
LSe8CfcgkcHhWj5wFXX9o52tv1DdMHOeQZv6gFexa5ssT99PTrn0cwQTwPdQlQPw
Y9KvSF1b+GRkTTKj7fBK7QWjrp7Se0Vzl7QR+AXIB+tn17EK0XoWRGrtS4IsSmVM
R5S5Gjf+0fyWUg==
=jUNR
-----END PGP SIGNATURE-----
--=-=-=--

