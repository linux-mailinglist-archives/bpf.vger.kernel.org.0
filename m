Return-Path: <bpf+bounces-55170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF22A79381
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 18:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767B83B0C96
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 16:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0879193402;
	Wed,  2 Apr 2025 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="aw7nrYss"
X-Original-To: bpf@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5813957E;
	Wed,  2 Apr 2025 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743613032; cv=pass; b=TkPR15HNc2/KIcQz9HkoXA7I/PUB8PVCYgDQ+lIvvtu28UESuAtTK/vXgy8TIEpptuqkbA06PGxfVxn5OQ/0Oov2X+3WPs1zmgwd0tGI6g4xfiZPRLhHmV/O2ocaa1yllHgNpcnoLJ5NnXDaClIPFIGwfHoL1tJWW/leuTRcn+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743613032; c=relaxed/simple;
	bh=LRXoD+4ibjTlc788eBC7ZXZcOBL4T/2hgXYKcWIvyxM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QgKYjcGH+ZHCHtgSjoMduMXaLHQHnAAkK/q/nVitMMxnk8qJID1H+tK8EJtfiaLO7jNCwoaCogp3P4oz5QTTQdoLXBWYQ4gIbDp9wKz+rrDnfbWyr04i0VrEsiGu87h7dLvQxvbve1XGfo225ce1pl/EWvXJS+4G0wJv918p82s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=aw7nrYss; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZSWHW6CmRz49Pxf;
	Wed,  2 Apr 2025 19:56:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1743613016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LIPp4RLl6pJSdKh+bwSIUD+9HN3F5P5UNyXOAKQ6xsQ=;
	b=aw7nrYss69EQ2UHNELm+pE4z1p/JtPZr3nrp+HEmHyJar46JNxqtG/dALqfa6gyq9dmB7z
	v29jFgAZxJm6HVjQp40rkFvo/g6p/EdKxVtgCSQSL/lK8HhMX87DUHnIzA2HjgewyEIo0g
	y0ewgU+z+jRbxLBNCH5+dmtn3gPYCl4/YZIVSHrwxmD9ETIOL1e32voDCspP6jBZycAXkD
	jmmWmCFna4Hev/WaXMI5nMzGW7Vc53SxNGpuMGJCOr/FFkNshw0nzGiDgH7dVqTe/7hS/m
	CWPQG5O3ijgse4XxdiC2Dyt+PUUdAyGGwTRpbN1+tQF/AqZeO9hJEilk/vONrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1743613016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LIPp4RLl6pJSdKh+bwSIUD+9HN3F5P5UNyXOAKQ6xsQ=;
	b=fgDTLb5T0tFqGWUR66reVHEf2f9xTo/71wZk8ewRuDHqbR41hrWTCkzZT/GMwaeYuM6Vk7
	DzmnvBl3AT6lfSOVm1XTyfPut6gkdudCUuKQEI+Vrhk1Ko1bXL3zIoyd7ts4ARB/OncYtm
	Yw/MdkgtG9q7jPSk0tRc1b5CdY0ilvZXhDmE2LHvfHi7oT1pOglmLo1pHlqYVH/fLQq3bW
	U8FiwPLk9Xf5ONbeFHePnbDlJa8hE3uhZ2KgJ/NQi55l6mymYffuI0sOXBJc+MVpGH+6H1
	ft83TyYP8gtX04pL5s+RgfaKGJGCSsh/sl5okfutY13bxuyobr+H8dnXEBLINg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1743613016; a=rsa-sha256;
	cv=none;
	b=oj5ts3byDH0fxrLoPrCAf65IOrjAZatzuY82dY3q+lqL27ABnKwIlqlflBrR7c/3DZEHEt
	jB4XhKN/p/Ui4InMPlBFSQ5oAbbWoq0QP9EVMa4Ei7t9sJcu29wSF5hamKY5gsiBb9c0JZ
	esS5bOhaS/w/DX5eltLcSsCYvul1Qsw136eerMNarChp4M9Kw2sMFChiYimRpFagMbpDm1
	aZ9+yH5jB9g2yj+4J3dNW+gOvxFlaSH79EZsEXPl0ZgrHXdfo+DFSrTK/UqCZDe1MM+MK6
	mDZppUV0eM/0+G2IqT21cVxdki8KUwIVaVI0BgGx0oBkEQDYj7ZfClH5p5/n4A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <db7f317539cbda89df7e87efaea9b22328af610a.camel@iki.fi>
Subject: Re: [PATCH 3/3] [RFC] Bluetooth: enable bpf TX timestamping
From: Pauli Virtanen <pav@iki.fi>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	kerneljasonxing@gmail.com
Date: Wed, 02 Apr 2025 19:56:52 +0300
In-Reply-To: <3546b79d-a09b-4971-abd7-ce18696a9536@linux.dev>
References: <cover.1743337403.git.pav@iki.fi>
	 <bbd7fa454ed03ebba9bfe79590fb78a75d4f07db.1743337403.git.pav@iki.fi>
	 <3546b79d-a09b-4971-abd7-ce18696a9536@linux.dev>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2025-04-01 kello 18:34 -0700, Martin KaFai Lau kirjoitti:
> On 3/30/25 5:23 AM, Pauli Virtanen wrote:
> > Emit timestamps also for BPF timestamping.
> >=20
> > ***
> >=20
> > The tskey management here is not quite right: see cover letter.
> > ---
> >   include/net/bluetooth/bluetooth.h |  1 +
> >   net/bluetooth/hci_conn.c          | 21 +++++++++++++++++++--
> >   2 files changed, 20 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index bbefde319f95..3b2e59cedd2d 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -383,6 +383,7 @@ struct bt_sock {
> >   	struct list_head accept_q;
> >   	struct sock *parent;
> >   	unsigned long flags;
> > +	atomic_t bpf_tskey;
> >   	void (*skb_msg_name)(struct sk_buff *, void *, int *);
> >   	void (*skb_put_cmsg)(struct sk_buff *, struct msghdr *, struct sock =
*);
> >   };
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 95972fd4c784..7430df1c5822 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -28,6 +28,7 @@
> >   #include <linux/export.h>
> >   #include <linux/debugfs.h>
> >   #include <linux/errqueue.h>
> > +#include <linux/bpf-cgroup.h>
> >  =20
> >   #include <net/bluetooth/bluetooth.h>
> >   #include <net/bluetooth/hci_core.h>
> > @@ -3072,6 +3073,7 @@ void hci_setup_tx_timestamp(struct sk_buff *skb, =
size_t key_offset,
> >   			    const struct sockcm_cookie *sockc)
> >   {
> >   	struct sock *sk =3D skb ? skb->sk : NULL;
> > +	bool have_tskey =3D false;
> >  =20
> >   	/* This shall be called on a single skb of those generated by user
> >   	 * sendmsg(), and only when the sendmsg() does not return error to
> > @@ -3096,6 +3098,20 @@ void hci_setup_tx_timestamp(struct sk_buff *skb,=
 size_t key_offset,
> >  =20
> >   			skb_shinfo(skb)->tskey =3D key - 1;
> >   		}
> > +		have_tskey =3D true;
> > +	}
> > +
> > +	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > +	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING)) {
> > +		struct bt_sock *bt_sk =3D container_of(sk, struct bt_sock, sk);
> > +		int key =3D atomic_inc_return(&bt_sk->bpf_tskey);
>=20
> I don't think it needs to add "atomic_t bpf_tskey". Allow the bpf to deci=
de what=20
> the skb_shinfo(skb)->tskey should be if it is not set by the userspace.

Ok. So if I understand correctly, the plan is that for UDP and
Bluetooth seqpacket sockets it works like this:

bpf_sock_ops_enable_tx_tstamp() does not set tskey.

Socket timestamping sets tskey the same way as previously.

So when both are in play, it shall work like:

* attach BPF timestamping
* setsockopt(SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_OPT_ID)
* sendmsg() CMSG SO_TIMESTAMPING =3D 0
=3D> tskey 0 (unset)
* sendmsg() CMSG SO_TIMESTAMPING =3D SOF_TIMESTAMPING_TX_SOFTWARE
=3D> tskey 0
* sendmsg() CMSG SO_TIMESTAMPING =3D SOF_TIMESTAMPING_TX_SOFTWARE
=3D> tskey 1
* sendmsg() CMSG SO_TIMESTAMPING =3D 0
=3D> tskey 0 (unset)
* sendmsg() CMSG SO_TIMESTAMPING =3D 0
=3D> tskey 0 (unset)
* sendmsg() CMSG SO_TIMESTAMPING =3D 0
=3D> tskey 0 (unset)
* sendmsg() CMSG SO_TIMESTAMPING =3D SOF_TIMESTAMPING_TX_SOFTWARE
=3D> tskey 2

and BPF program has to handle the (unset) cases itself.

>=20
> > +
> > +		if (!have_tskey)
> > +			skb_shinfo(skb)->tskey =3D key - 1;
> > +
> > +		bpf_skops_tx_timestamping(sk, skb,
> > +					  BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
> > +
> >   	}
> >   }
> >  =20
>=20
>=20

--=20
Pauli Virtanen

