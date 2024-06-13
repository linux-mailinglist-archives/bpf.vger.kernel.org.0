Return-Path: <bpf+bounces-32137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F75907EE6
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 00:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35021F22196
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 22:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A160814C591;
	Thu, 13 Jun 2024 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxrBzU0s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D872F50;
	Thu, 13 Jun 2024 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718318066; cv=none; b=lls0riBEyysap9c10oxd/RiHrpRVeWAtXv9UcZerA0GZZzFvshqnNSF5UjtyKGles74PflyzC7rvSNxYsTFiGb0AfkwIQ4PeTzgx2C/Xgla5JjRAgbHJgzEnln3oRMQ6z5eRv+EA0qUHEpwHX91PfPJkaISiCCuofS53kqMkZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718318066; c=relaxed/simple;
	bh=yiJUrgVj+SpxATBjCDzMP/3paLCh5iKprR35i/0jwOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyhQ0c18hENt40Dntc9REYyDHhFSOMnZcIWdH4+n9cDu0iBiScDq95QWfh/rvtSAps7UYAxS0xoUFALgo4M1JF2lYb3sbQWEb8n2c5kozYkwhDAiFct5JkFzGgahNXtviVAx1wtAbCmRaKfUNpxlJzc0P7V2ZI03/hTsdb0qqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxrBzU0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AF5C2BBFC;
	Thu, 13 Jun 2024 22:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718318065;
	bh=yiJUrgVj+SpxATBjCDzMP/3paLCh5iKprR35i/0jwOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxrBzU0spfecOYNiT/iefjF7j2bdhYVDKSRIEZLSEK5O100xulb7KgqcCWe6oFW5e
	 DCtDKz7dk9RD/oTDaun3G655CfKM5mdzTrphys74545ndwXfD7Nw30gzCOeQHOESk/
	 TG/D7t2o6oIE9wnEJp2AewTRt1SO/CwVnX3V6o7c1s026sza0UULal2OQ92csLq9yb
	 Q0ghEu9eZmlLGWddqPymCJQaoaCV0vkmq/xn8dH+9E92IE8p3Y1tP8UbWIXfmqNbkI
	 Xkc2f95+cNcR4aSSkmuc7xkqa5hsPJDA2Jnkuh401CtCWJRVLQ0YxMtAQHUgTQNqNj
	 BLwKYRwQnBfXQ==
Date: Fri, 14 Jun 2024 00:34:21 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: pablo@netfilter.org
Cc: bpf@vger.kernel.org, kadlec@netfilter.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com,
	lorenzo.bianconi@redhat.com, toke@redhat.com, fw@strlen.de,
	hawk@kernel.org, horms@kernel.org, donhunte@redhat.com,
	memxor@gmail.com
Subject: Re: [PATCH v4 bpf-next 1/3] netfilter: nf_tables: add flowtable map
 for xdp offload
Message-ID: <Zmtz7T99mHi99kI-@lore-desk>
References: <cover.1716987534.git.lorenzo@kernel.org>
 <1298eb8587c50a73da315516fbb1ea0305587dd5.1716987534.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9+fJafO8pbIi+c3K"
Content-Disposition: inline
In-Reply-To: <1298eb8587c50a73da315516fbb1ea0305587dd5.1716987534.git.lorenzo@kernel.org>


--9+fJafO8pbIi+c3K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Florian Westphal <fw@strlen.de>
>=20
> This adds a small internal mapping table so that a new bpf (xdp) kfunc
> can perform lookups in a flowtable.
>=20
> As-is, xdp program has access to the device pointer, but no way to do a
> lookup in a flowtable -- there is no way to obtain the needed struct
> without questionable stunts.
>=20
> This allows to obtain an nf_flowtable pointer given a net_device
> structure.
>=20
> In order to keep backward compatibility, the infrastructure allows the
> user to add a given device to multiple flowtables, but it will always
> return the first added mapping performing the lookup since it assumes
> the right configuration is 1:1 mapping between flowtables and net_devices.

Hi Pablo,

do you have any feedback about nft part? Thanks.

Regards,
Lorenzo

>=20
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/netfilter/nf_flow_table.h |   8 ++
>  net/netfilter/Makefile                |   2 +-
>  net/netfilter/nf_flow_table_offload.c |   6 +-
>  net/netfilter/nf_flow_table_xdp.c     | 163 ++++++++++++++++++++++++++
>  4 files changed, 176 insertions(+), 3 deletions(-)
>  create mode 100644 net/netfilter/nf_flow_table_xdp.c
>=20
> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilte=
r/nf_flow_table.h
> index 9abb7ee40d72f..688e02b287cc4 100644
> --- a/include/net/netfilter/nf_flow_table.h
> +++ b/include/net/netfilter/nf_flow_table.h
> @@ -305,6 +305,14 @@ struct flow_ports {
>  	__be16 source, dest;
>  };
> =20
> +struct nf_flowtable *nf_flowtable_by_dev(const struct net_device *dev);
> +int nf_flow_offload_xdp_setup(struct nf_flowtable *flowtable,
> +			      struct net_device *dev,
> +			      enum flow_block_command cmd);
> +void nf_flow_offload_xdp_cancel(struct nf_flowtable *flowtable,
> +				struct net_device *dev,
> +				enum flow_block_command cmd);
> +
>  unsigned int nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
>  				     const struct nf_hook_state *state);
>  unsigned int nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
> diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
> index 614815a3ed738..18046872a38aa 100644
> --- a/net/netfilter/Makefile
> +++ b/net/netfilter/Makefile
> @@ -142,7 +142,7 @@ obj-$(CONFIG_NFT_FWD_NETDEV)	+=3D nft_fwd_netdev.o
>  # flow table infrastructure
>  obj-$(CONFIG_NF_FLOW_TABLE)	+=3D nf_flow_table.o
>  nf_flow_table-objs		:=3D nf_flow_table_core.o nf_flow_table_ip.o \
> -				   nf_flow_table_offload.o
> +				   nf_flow_table_offload.o nf_flow_table_xdp.o
>  nf_flow_table-$(CONFIG_NF_FLOW_TABLE_PROCFS) +=3D nf_flow_table_procfs.o
> =20
>  obj-$(CONFIG_NF_FLOW_TABLE_INET) +=3D nf_flow_table_inet.o
> diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flo=
w_table_offload.c
> index a010b25076ca0..d9b019c98694b 100644
> --- a/net/netfilter/nf_flow_table_offload.c
> +++ b/net/netfilter/nf_flow_table_offload.c
> @@ -1192,7 +1192,7 @@ int nf_flow_table_offload_setup(struct nf_flowtable=
 *flowtable,
>  	int err;
> =20
>  	if (!nf_flowtable_hw_offload(flowtable))
> -		return 0;
> +		return nf_flow_offload_xdp_setup(flowtable, dev, cmd);
> =20
>  	if (dev->netdev_ops->ndo_setup_tc)
>  		err =3D nf_flow_table_offload_cmd(&bo, flowtable, dev, cmd,
> @@ -1200,8 +1200,10 @@ int nf_flow_table_offload_setup(struct nf_flowtabl=
e *flowtable,
>  	else
>  		err =3D nf_flow_table_indr_offload_cmd(&bo, flowtable, dev, cmd,
>  						     &extack);
> -	if (err < 0)
> +	if (err < 0) {
> +		nf_flow_offload_xdp_cancel(flowtable, dev, cmd);
>  		return err;
> +	}
> =20
>  	return nf_flow_table_block_setup(flowtable, &bo, cmd);
>  }
> diff --git a/net/netfilter/nf_flow_table_xdp.c b/net/netfilter/nf_flow_ta=
ble_xdp.c
> new file mode 100644
> index 0000000000000..b9bdf27ba9bd3
> --- /dev/null
> +++ b/net/netfilter/nf_flow_table_xdp.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/netfilter.h>
> +#include <linux/rhashtable.h>
> +#include <linux/netdevice.h>
> +#include <net/flow_offload.h>
> +#include <net/netfilter/nf_flow_table.h>
> +
> +struct flow_offload_xdp_ft {
> +	struct list_head head;
> +	struct nf_flowtable *ft;
> +	struct rcu_head rcuhead;
> +};
> +
> +struct flow_offload_xdp {
> +	struct hlist_node hnode;
> +	unsigned long net_device_addr;
> +	struct list_head head;
> +};
> +
> +#define NF_XDP_HT_BITS	4
> +static DEFINE_HASHTABLE(nf_xdp_hashtable, NF_XDP_HT_BITS);
> +static DEFINE_MUTEX(nf_xdp_hashtable_lock);
> +
> +/* caller must hold rcu read lock */
> +struct nf_flowtable *nf_flowtable_by_dev(const struct net_device *dev)
> +{
> +	unsigned long key =3D (unsigned long)dev;
> +	struct flow_offload_xdp *iter;
> +
> +	hash_for_each_possible_rcu(nf_xdp_hashtable, iter, hnode, key) {
> +		if (key =3D=3D iter->net_device_addr) {
> +			struct flow_offload_xdp_ft *ft_elem;
> +
> +			/* The user is supposed to insert a given net_device
> +			 * just into a single nf_flowtable so we always return
> +			 * the first element here.
> +			 */
> +			ft_elem =3D list_first_or_null_rcu(&iter->head,
> +							 struct flow_offload_xdp_ft,
> +							 head);
> +			return ft_elem ? ft_elem->ft : NULL;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int nf_flowtable_by_dev_insert(struct nf_flowtable *ft,
> +				      const struct net_device *dev)
> +{
> +	struct flow_offload_xdp *iter, *elem =3D NULL;
> +	unsigned long key =3D (unsigned long)dev;
> +	struct flow_offload_xdp_ft *ft_elem;
> +
> +	ft_elem =3D kzalloc(sizeof(*ft_elem), GFP_KERNEL_ACCOUNT);
> +	if (!ft_elem)
> +		return -ENOMEM;
> +
> +	ft_elem->ft =3D ft;
> +
> +	mutex_lock(&nf_xdp_hashtable_lock);
> +
> +	hash_for_each_possible(nf_xdp_hashtable, iter, hnode, key) {
> +		if (key =3D=3D iter->net_device_addr) {
> +			elem =3D iter;
> +			break;
> +		}
> +	}
> +
> +	if (!elem) {
> +		elem =3D kzalloc(sizeof(*elem), GFP_KERNEL_ACCOUNT);
> +		if (!elem)
> +			goto err_unlock;
> +
> +		elem->net_device_addr =3D key;
> +		INIT_LIST_HEAD(&elem->head);
> +		hash_add_rcu(nf_xdp_hashtable, &elem->hnode, key);
> +	}
> +	list_add_tail_rcu(&ft_elem->head, &elem->head);
> +
> +	mutex_unlock(&nf_xdp_hashtable_lock);
> +
> +	return 0;
> +
> +err_unlock:
> +	mutex_unlock(&nf_xdp_hashtable_lock);
> +	kfree(ft_elem);
> +
> +	return -ENOMEM;
> +}
> +
> +static void nf_flowtable_by_dev_remove(struct nf_flowtable *ft,
> +				       const struct net_device *dev)
> +{
> +	struct flow_offload_xdp *iter, *elem =3D NULL;
> +	unsigned long key =3D (unsigned long)dev;
> +
> +	mutex_lock(&nf_xdp_hashtable_lock);
> +
> +	hash_for_each_possible(nf_xdp_hashtable, iter, hnode, key) {
> +		if (key =3D=3D iter->net_device_addr) {
> +			elem =3D iter;
> +			break;
> +		}
> +	}
> +
> +	if (elem) {
> +		struct flow_offload_xdp_ft *ft_elem, *ft_next;
> +
> +		list_for_each_entry_safe(ft_elem, ft_next, &elem->head, head) {
> +			if (ft_elem->ft =3D=3D ft) {
> +				list_del_rcu(&ft_elem->head);
> +				kfree_rcu(ft_elem, rcuhead);
> +			}
> +		}
> +
> +		if (list_empty(&elem->head))
> +			hash_del_rcu(&elem->hnode);
> +		else
> +			elem =3D NULL;
> +	}
> +
> +	mutex_unlock(&nf_xdp_hashtable_lock);
> +
> +	if (elem) {
> +		synchronize_rcu();
> +		kfree(elem);
> +	}
> +}
> +
> +int nf_flow_offload_xdp_setup(struct nf_flowtable *flowtable,
> +			      struct net_device *dev,
> +			      enum flow_block_command cmd)
> +{
> +	switch (cmd) {
> +	case FLOW_BLOCK_BIND:
> +		return nf_flowtable_by_dev_insert(flowtable, dev);
> +	case FLOW_BLOCK_UNBIND:
> +		nf_flowtable_by_dev_remove(flowtable, dev);
> +		return 0;
> +	}
> +
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +void nf_flow_offload_xdp_cancel(struct nf_flowtable *flowtable,
> +				struct net_device *dev,
> +				enum flow_block_command cmd)
> +{
> +	switch (cmd) {
> +	case FLOW_BLOCK_BIND:
> +		nf_flowtable_by_dev_remove(flowtable, dev);
> +		return;
> +	case FLOW_BLOCK_UNBIND:
> +		/* We do not re-bind in case hw offload would report error
> +		 * on *unregister*.
> +		 */
> +		break;
> +	}
> +}
> --=20
> 2.45.1
>=20
>=20

--9+fJafO8pbIi+c3K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZmtz7QAKCRA6cBh0uS2t
rCBeAQDrvRY0AQ4JiKL9qGgt02w6BBQk6561fqfxmnuE83K0TgEAtW3TLzafvLHe
1mEDwHUdg3sCxJr3tg4yhhn+eKtv/gw=
=ESGG
-----END PGP SIGNATURE-----

--9+fJafO8pbIi+c3K--

