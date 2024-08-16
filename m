Return-Path: <bpf+bounces-37361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF86A95464D
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 11:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EDB1F22B98
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 09:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D2C16F0E1;
	Fri, 16 Aug 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zxoZ0Clw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WcH/q3OK"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150E336C;
	Fri, 16 Aug 2024 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802195; cv=none; b=rlT3xfseE3DwRHC68ChjgUFuisqQRH1kRJvP0BLspkQBfzXYIxv0gbtQ8P9CjhgsNPPrGTrR0TUkT9rmvOERzaq/I26JerkpcJqjy5XsydCIrqmnOb9Kl4xlRDH0Ekxg19DLnunv0/c+d4rWpTG4UAriZbDbSaRQUfzlC/BMMoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802195; c=relaxed/simple;
	bh=jlH+C4Eli6MiwB2elRraHaVAE+LF4uXPyxrzxBdgyy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g3C4zVB9cMX9l02zR/atZQLigSL0fO14huO1ITNrChGOJwEBGozOqo08zChYZUdIZIq43KCHos2Ys0CyRrxL2OhZrA36vDH8T/WtN24fISK5+Nuy1VCkEVtSL0mTl2FSCLl7wfl0iaY/O7H7Ba0cbjnXjwTU1RHFJ/QjqWSKVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zxoZ0Clw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WcH/q3OK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723802192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jESmOZLP8UWnsshEocvlvp6ISx76GNAGMqVLR6BonUk=;
	b=zxoZ0ClwFcz2e0qMb2F+ALD90vEBdUixozBxCrn+8jl1o66ulK6HCR/Jx68mLUUW8JKxiX
	JW7WPfXzNeK33EQ2OZM4eyjMOSGT/GaTSYN0QBpNpw1tzPoKhK1Ez6MwFSF/ULk9FGj2sM
	2a0m0seUPBc7vxAIaioWaw0haFt7nXE5tWbh9m5FR1h1ACLYM4H2VEl91f4yyQ5ACcUjQ0
	Mr2k1izecsPLHuj/HGAMY9zmcUP0OYd+7EsDU4n6WJK1HuKYqEGJvP/v5dqrmaMcK5yqKE
	SI+JeSHRySSZh5RYKSQRx3gdRqGAHBh0xj2aFA7Pm3NZeZeBKJNrMcseJAqVFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723802192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jESmOZLP8UWnsshEocvlvp6ISx76GNAGMqVLR6BonUk=;
	b=WcH/q3OK+suGA9AIiolbtMLY7MZCHuZMu0xnvBs7Cvzqk9bRQBQ/BRxhripc7H1sDbba5O
	Wu6uPH1qesXZ4bAw==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Benjamin Steinke
 <benjamin.steinke@woks-audio.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v6 1/6] igb: Always call
 igb_xdp_ring_update_tail() under Tx lock
In-Reply-To: <20240816093838.ZpGD38t-@linutronix.de>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
 <20240711-b4-igb_zero_copy-v6-1-4bfb68773b18@linutronix.de>
 <20240816093838.ZpGD38t-@linutronix.de>
Date: Fri, 16 Aug 2024 11:56:30 +0200
Message-ID: <87wmkgu6y9.fsf@kurt.kurt.home>
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

On Fri Aug 16 2024, Sebastian Andrzej Siewior wrote:
> On 2024-08-16 11:24:00 [+0200], Kurt Kanzenbach wrote:
>> index 11be39f435f3..4d5e5691c9bd 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -2914,6 +2914,7 @@ static int igb_xdp(struct net_device *dev, struct =
netdev_bpf *xdp)
>>  	}
>>  }
>>=20=20
>> +/* This function assumes __netif_tx_lock is held by the caller. */
>>  static void igb_xdp_ring_update_tail(struct igb_ring *ring)
>>  {
>>  	/* Force memory writes to complete before letting h/w know there
> This
>   lockdep_assert_held(txring_txq(ring)->_xmit_lock);
> would be more powerful than the comment ;)

Probably yes :-).

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAma/Ik4THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgvy7EACdXa4mHcircC6NlXZt/nWX6xwMHDiA
9osVQPXuXOXab6fhrCOwI2QmaTcUHxKwK3yQZo+4CMopI4ne34357YpRYySXezrM
65+LmiCkX6AJm72mT3PByWURiF7c8cdRl8u/WQF0+qXjUb2tEZutrOYKP2QlDzLN
8N1NZPz8BDWSBnWR9PPRcO6oufuchIx6d1FKUshyH6EbQ/Xha9ixzt+UktTxpS1w
ruwgUECR1zMulpTSwwdLVss2d8FsJwBoG0z3wMTtNYffyZ8eXJ+N7rjte8IpFckP
ntjZSMR4iGT9rwvREegdPdMzovPYIIPIdvmPv+9iXwWTkgLRi9wsd8yHmYzR/0re
XooZSoTqYZFAKJ38myZmmnr0V1GNbCHjISWgUGLSA6ZBDvYnr7Ci9XwK03a5XoWy
BB8AXpRw8GDhqVws7lPV0Y/T9DcjL2ODUvF00sLaWTdrU1srjBf72r94VhpW8+CF
vXP/M7luxP/LY0sfM66Cw+iN/HEsCbiKsaRsHohFddSY2cKZxuvTYPyFQZdJmlfe
K1r7LeLAbV6WcIFC1ia33k8E6Va1n01w+KYCmWUKOfpOdE4JbUiBWIelNqWiDLfW
sAKNscYy+D+m/5/A/rAdE4gcw/1704tRHf9rXnUbLvxK64QY4j6U2+mRZ4XbD7zm
DvFijdRBa8Nl8A==
=w0GY
-----END PGP SIGNATURE-----
--=-=-=--

