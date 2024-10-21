Return-Path: <bpf+bounces-42574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1409A59D6
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 07:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00DF1F21B51
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 05:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DD619938D;
	Mon, 21 Oct 2024 05:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jbs5GuSg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/penghOD"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7912209B;
	Mon, 21 Oct 2024 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489335; cv=none; b=sanElxSxAep278Y+3i5KeFoUldVxEG5Y9wb6J458T1fsSx4r27pDRK8E+wtjIFuC7zPOSDryGUuJtXLiHuVFzzvZUyU3Wh4d2pZpPqfKn5v67ledxYNxm3AL6DZViL8vIfkQZz2AeB8ok6RX5FIJlHBZfRe4uatYc4L4oDw+klc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489335; c=relaxed/simple;
	bh=nqU2AdQPtpXBQBywDKE615SxVcwqLzweuXJzCTdK2Wc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H6TTNkPLOp6hAPAtckKT9hsTiQDgm/VQtBHd3irsLNODF4ynrcHDNhMWG+yjbpgjhNU9RHb9KwD8bv5qHMpfXQpjwWsdvG+Rer7FeqKe2p3loCXdjvilrXng2hFItIBcsOdlODLZE+1pErU85txff6+cjWhrrxDbgcmNc2CSbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jbs5GuSg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/penghOD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729489324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwN2APzuoMR+7fgmrER77l2eiOhN6doSytLMUFLsLt4=;
	b=Jbs5GuSgoz06Yo6+KGN33AGlwU6bVgUJfxbq4ZyoTWGHQHxTJPHtRbfcDi31UU7CBUFGX5
	AWhXWkF2ii5GnuIRehHb8djQEXETXZQEQez9hU3zVJIAi//Qi1nqqNjMoSWaD32/vDIly2
	sMm4YmzsMNUPvHUzUxgXxTNCwgC5EEDpW2oIefWHHcDa0HwLaH7VQlxRUcHGthr0p4EGIH
	DdDdpZkbwkFJ1OcNV6OLq8vdud/oiawaxlWvPSTImEudNlqZ6RmQYwqWHHJ8ZiMInKmUgr
	Wppd4iKQ0wrpyKcCKAgw4ORLQ+pzC6kYy4jVaBb71VP/xAyd7UGazAan14tCTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729489324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwN2APzuoMR+7fgmrER77l2eiOhN6doSytLMUFLsLt4=;
	b=/penghODChhNiRRbiTNwutaWjk3kpVXgV5wGXUvxA8y0WgJlfcblrQay4QSk/3pGM/X9il
	piF30ZLsitnXklAw==
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, vinicius.gomes@intel.com, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "moderated
 list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:XDP (eXpress Data Path)"
 <bpf@vger.kernel.org>
Subject: Re: [RFC net-next v2 2/2] igc: Link queues to NAPI instances
In-Reply-To: <ZxKVI_DvFWBvRMaf@LQ3V64L9R2>
References: <20241014213012.187976-1-jdamato@fastly.com>
 <20241014213012.187976-3-jdamato@fastly.com>
 <87h69d3bm2.fsf@kurt.kurt.home> <ZxKVI_DvFWBvRMaf@LQ3V64L9R2>
Date: Mon, 21 Oct 2024 07:42:02 +0200
Message-ID: <87o73e2es5.fsf@kurt.kurt.home>
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

On Fri Oct 18 2024, Joe Damato wrote:
> On Tue, Oct 15, 2024 at 12:27:01PM +0200, Kurt Kanzenbach wrote:
>> On Mon Oct 14 2024, Joe Damato wrote:
>
> [...]
>
>> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/e=
thernet/intel/igc/igc_main.c
>> > index 7964bbedb16c..59c00acfa0ed 100644
>> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> > @@ -4948,6 +4948,47 @@ static int igc_sw_init(struct igc_adapter *adap=
ter)
>> >  	return 0;
>> >  }
>> >=20=20
>> > +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
>> > +			struct napi_struct *napi)
>> > +{
>> > +	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
>> > +		netif_queue_set_napi(adapter->netdev, q_idx,
>> > +				     NETDEV_QUEUE_TYPE_RX, napi);
>> > +		netif_queue_set_napi(adapter->netdev, q_idx,
>> > +				     NETDEV_QUEUE_TYPE_TX, napi);
>> > +	} else {
>> > +		if (q_idx < adapter->num_rx_queues) {
>> > +			netif_queue_set_napi(adapter->netdev, q_idx,
>> > +					     NETDEV_QUEUE_TYPE_RX, napi);
>> > +		} else {
>> > +			q_idx -=3D adapter->num_rx_queues;
>> > +			netif_queue_set_napi(adapter->netdev, q_idx,
>> > +					     NETDEV_QUEUE_TYPE_TX, napi);
>> > +		}
>> > +	}
>> > +}
>>=20
>> In addition, to what Vinicius said. I think this can be done
>> simpler. Something like this?
>>=20
>> void igc_set_queue_napi(struct igc_adapter *adapter, int vector,
>> 			struct napi_struct *napi)
>> {
>> 	struct igc_q_vector *q_vector =3D adapter->q_vector[vector];
>>=20
>> 	if (q_vector->rx.ring)
>> 		netif_queue_set_napi(adapter->netdev, vector, NETDEV_QUEUE_TYPE_RX, na=
pi);
>>=20
>> 	if (q_vector->tx.ring)
>> 		netif_queue_set_napi(adapter->netdev, vector, NETDEV_QUEUE_TYPE_TX, na=
pi);
>> }
>
> I tried this suggestion but this does not result in correct output
> in the case where IGC_FLAG_QUEUE_PAIRS is disabled.
>
> The output from netlink:
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                              --dump queue-get --json=3D'{"ifindex": 2}'
>
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'}]
>
> Note the lack of a napi-id for the TX queues. This typically happens
> when the linking is not done correctly; netif_queue_set_napi should
> take a queue id as the second parameter.
>
> I believe the suggested code above should be modified to be as
> follows to use ring->queue_index:
>
>   if (q_vector->rx.ring)
>     netif_queue_set_napi(adapter->netdev,
>                          q_vector->rx.ring->queue_index,
>                          NETDEV_QUEUE_TYPE_RX, napi);
>=20=20=20
>   if (q_vector->tx.ring)
>     netif_queue_set_napi(adapter->netdev,
>                          q_vector->tx.ring->queue_index,
>                          NETDEV_QUEUE_TYPE_TX, napi);

LGTM. Thanks.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmcV6aoTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgkotD/0X5UYHEhJgqmCt6kB/HHS4YFUODWTi
XbRxhEARJl+qKt6TMqywibxifqVHp9hL08AWuXp5kBQWw9Sc2e6KfG6TfoIBtdM3
7nR6+Wk/CrMZhZVKbNjEQrfmcZAdl3Sk44DPaXhfqU0jCbgj0sj3zpoZU5q8UXT0
8E5kkrPY1a98ufweoCnYSmdvLmqUXXgHeBWyoFgOdxeN2jIY1azZrgQucmdYsgYt
g9Lprnp3euz/7UrAJhTgxjq7/klCKC0x2Sg0xmeKoNJ0aZC5zppsBZXJrWTlZElh
zgwiV0Vc3aEWCRIoOVudj1GjSEug6w/fJWBO6gP+5EZ1N6XfQG7MOzuW07G47ubm
8qX7JRjVyaNZAwX1wy69KZv/NVNUuPxJrdVMxPoV7HAZtZfQl5TA6aE3aBOvkO2q
gsSU0cR2fk4Ac2YLbKcZNwrxzg8gsnhPrdPJw0EWmCvaAIzxFnYW+lPdV0SDiHnc
e4kXClZjVramUW4cP3B9ZJ4krrXMNYQxnVfFSR55H+LwL0vKxqNNiRd3rNTpl4CL
HcfYg6wvKulCvJZ31QwpeovA4K5BdCDd1JH/PkHLVSdM1sUWtDE3pRRnFk+sUG+S
T8GqcYGHs4f6Ee2bYhHTFN5hOGRmcD+gM/9vdjAGqE4teIS/RhZDe7IoN0A/4gwP
2wWE6IMegLnsZQ==
=LURd
-----END PGP SIGNATURE-----
--=-=-=--

