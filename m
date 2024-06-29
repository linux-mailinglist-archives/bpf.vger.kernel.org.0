Return-Path: <bpf+bounces-33437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A6D91CF69
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 00:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D52D1F219F7
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 22:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B51422BC;
	Sat, 29 Jun 2024 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXLLB3tk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36142594;
	Sat, 29 Jun 2024 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719698821; cv=none; b=ibtqEBKtFhLUoRQ0UdhX6PC385mE/9vNvA5eGx+itVkb5u/6eddwtevD+pVNA7DLOUlXeorjDYKMbaDflC+oRPXGMOdCFiIySsq7fs/WrJTEBZqpBkI3UBAZgtxkv3yaUSMawFRjrjStCJjwlYVy3sjvYq4A6N+PkZaRsT/+NzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719698821; c=relaxed/simple;
	bh=d8XuSqNqnWm8lshIOymmyyD9Ah0CO/GERjDB9uau96g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHvEgX+wWVjnwKz62jKikzbsVFn+Plcnc9k8tCreQo054ZR8Z9OCZ9DW17hN8X9NJaYo1xWoZ+TXF85HTtfMRY+y4WrWOSuJhRA1XTLYx12XyDQaf7jbiCSmQedJQFbtb5EfTkQbIoGrdEHWtuqLhdaGAq9FKwBE03c4rsbZ5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXLLB3tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16DEC2BBFC;
	Sat, 29 Jun 2024 22:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719698820;
	bh=d8XuSqNqnWm8lshIOymmyyD9Ah0CO/GERjDB9uau96g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXLLB3tknn6sT3w/hXLEcpUqmSUH+xDszG94rlrmAAwPD3lRXMibBg8mZdbZkB3CR
	 e5HEusfeo3SEsiX1WumoaFF22GC10fiPQAaWbUlYoA2bTayBZtryyyEcqpnET2/KnH
	 tpm9SlXtSLt2B6nUp2JFzlDUoGnN3eyhIC7BErlAUBKgic6ZTdpS34DDJ5pDt0jzvk
	 Us21VAA85RcpLP54R8opqdeZoQek7JrQb0nNP499Hxip0DXY+K8s4P7hMf8hxGXY46
	 nUhcPDnwqkdBfs3BhduE35eSRcL/NcUMTQqckoC06PD8DTesMJQ9pWzQrkdI6g+LiF
	 oF0vtC+SKj6Kw==
Date: Sun, 30 Jun 2024 00:06:56 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com,
	lorenzo.bianconi@redhat.com, toke@redhat.com, fw@strlen.de,
	hawk@kernel.org, horms@kernel.org, donhunte@redhat.com,
	memxor@gmail.com
Subject: Re: [PATCH v5 bpf-next 1/3] netfilter: nf_tables: add flowtable map
 for xdp offload
Message-ID: <ZoCFgFj7JFMSwlRQ@lore-desk>
References: <cover.1718379122.git.lorenzo@kernel.org>
 <d32ace9a34be6196313a9c24e0c52df979c507c3.1718379122.git.lorenzo@kernel.org>
 <793fd9a3-0562-1edd-e2b4-f88fa81d876d@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o7qmw+b/eCCYC93A"
Content-Disposition: inline
In-Reply-To: <793fd9a3-0562-1edd-e2b4-f88fa81d876d@iogearbox.net>


--o7qmw+b/eCCYC93A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 6/14/24 5:40 PM, Lorenzo Bianconi wrote:
> [...]
> > diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_f=
low_table_offload.c
> > index a010b25076ca0..d9b019c98694b 100644
> > --- a/net/netfilter/nf_flow_table_offload.c
> > +++ b/net/netfilter/nf_flow_table_offload.c
> > @@ -1192,7 +1192,7 @@ int nf_flow_table_offload_setup(struct nf_flowtab=
le *flowtable,
> >   	int err;
> >   	if (!nf_flowtable_hw_offload(flowtable))
> > -		return 0;
> > +		return nf_flow_offload_xdp_setup(flowtable, dev, cmd);
> >   	if (dev->netdev_ops->ndo_setup_tc)
> >   		err =3D nf_flow_table_offload_cmd(&bo, flowtable, dev, cmd,
> > @@ -1200,8 +1200,10 @@ int nf_flow_table_offload_setup(struct nf_flowta=
ble *flowtable,
> >   	else
> >   		err =3D nf_flow_table_indr_offload_cmd(&bo, flowtable, dev, cmd,
> >   						     &extack);
> > -	if (err < 0)
> > +	if (err < 0) {
> > +		nf_flow_offload_xdp_cancel(flowtable, dev, cmd);
> >   		return err;
> > +	}
> >   	return nf_flow_table_block_setup(flowtable, &bo, cmd);
> >   }
> > diff --git a/net/netfilter/nf_flow_table_xdp.c b/net/netfilter/nf_flow_=
table_xdp.c
> > new file mode 100644
> > index 0000000000000..b9bdf27ba9bd3
> > --- /dev/null
> > +++ b/net/netfilter/nf_flow_table_xdp.c
> > @@ -0,0 +1,163 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/netfilter.h>
> > +#include <linux/rhashtable.h>
> > +#include <linux/netdevice.h>
> > +#include <net/flow_offload.h>
> > +#include <net/netfilter/nf_flow_table.h>
> > +
> > +struct flow_offload_xdp_ft {
> > +	struct list_head head;
> > +	struct nf_flowtable *ft;
> > +	struct rcu_head rcuhead;
> > +};
> > +
> > +struct flow_offload_xdp {
> > +	struct hlist_node hnode;
> > +	unsigned long net_device_addr;
> > +	struct list_head head;
> > +};
> > +
> > +#define NF_XDP_HT_BITS	4
> > +static DEFINE_HASHTABLE(nf_xdp_hashtable, NF_XDP_HT_BITS);
> > +static DEFINE_MUTEX(nf_xdp_hashtable_lock);
> > +
> > +/* caller must hold rcu read lock */
> > +struct nf_flowtable *nf_flowtable_by_dev(const struct net_device *dev)
> > +{
> > +	unsigned long key =3D (unsigned long)dev;
> > +	struct flow_offload_xdp *iter;
> > +
> > +	hash_for_each_possible_rcu(nf_xdp_hashtable, iter, hnode, key) {
> > +		if (key =3D=3D iter->net_device_addr) {
> > +			struct flow_offload_xdp_ft *ft_elem;
> > +
> > +			/* The user is supposed to insert a given net_device
> > +			 * just into a single nf_flowtable so we always return
> > +			 * the first element here.
> > +			 */
> > +			ft_elem =3D list_first_or_null_rcu(&iter->head,
> > +							 struct flow_offload_xdp_ft,
> > +							 head);
> > +			return ft_elem ? ft_elem->ft : NULL;
> > +		}
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static int nf_flowtable_by_dev_insert(struct nf_flowtable *ft,
> > +				      const struct net_device *dev)
> > +{
> > +	struct flow_offload_xdp *iter, *elem =3D NULL;
> > +	unsigned long key =3D (unsigned long)dev;
> > +	struct flow_offload_xdp_ft *ft_elem;
> > +
> > +	ft_elem =3D kzalloc(sizeof(*ft_elem), GFP_KERNEL_ACCOUNT);
> > +	if (!ft_elem)
> > +		return -ENOMEM;
> > +
> > +	ft_elem->ft =3D ft;
> > +
> > +	mutex_lock(&nf_xdp_hashtable_lock);
> > +
> > +	hash_for_each_possible(nf_xdp_hashtable, iter, hnode, key) {
> > +		if (key =3D=3D iter->net_device_addr) {
> > +			elem =3D iter;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!elem) {
> > +		elem =3D kzalloc(sizeof(*elem), GFP_KERNEL_ACCOUNT);
> > +		if (!elem)
> > +			goto err_unlock;
> > +
> > +		elem->net_device_addr =3D key;
>=20
> Looks good, as I understand (but just to double check) if a device goes a=
way then
> upper layers in the nf flowtable code will trigger the nf_flowtable_by_de=
v_remove()
> based on the device pointer to clean this up again from nf_xdp_hashtable.

yep, correct. Core nft infrastructure runs nf_flow_offload_xdp_setup() with=
 cmd set
to FLOW_BLOCK_UNBIND (so we run nf_flowtable_by_dev_remove()) when the net_=
device
is removed.

Regards,
Lorenzo

>=20
> > +		INIT_LIST_HEAD(&elem->head);
> > +		hash_add_rcu(nf_xdp_hashtable, &elem->hnode, key);
> > +	}
> > +	list_add_tail_rcu(&ft_elem->head, &elem->head);
> > +
> > +	mutex_unlock(&nf_xdp_hashtable_lock);
> > +
> > +	return 0;
> > +
> > +err_unlock:
> > +	mutex_unlock(&nf_xdp_hashtable_lock);
> > +	kfree(ft_elem);
> > +
> > +	return -ENOMEM;
> > +}

--o7qmw+b/eCCYC93A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZoCFgAAKCRA6cBh0uS2t
rOdJAP9D35Cr1YENybwyAZer5zsl1/ySUuPMvAb1G+yZ2wjafQD9Ep3bV8uQ/mb2
QA6Bc0YNlpY7uKpN9NOWn68nyfuBOQU=
=DwkG
-----END PGP SIGNATURE-----

--o7qmw+b/eCCYC93A--

