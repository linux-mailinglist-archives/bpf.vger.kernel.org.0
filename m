Return-Path: <bpf+bounces-42004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF799E3D4
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 12:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB117B21B67
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 10:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BF61E3DF1;
	Tue, 15 Oct 2024 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B0/fQViY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XNFspYli"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DB71E378C;
	Tue, 15 Oct 2024 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988027; cv=none; b=ldc2MapLsdCwSAtzWS0AvR4QWvO4WQ2W2/2PB9gmIUyQlTutnKD29fAP+zUbc47NVBYw0BarEXSW3JVxNsqsuNgbHeNUVSWaUTbEPbpD+opVMmSKtLmnE7svlyg2i5tWv0jpVoD8L/v8XjWhza3QMtI5va0fYwJ2MsqnswX+1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988027; c=relaxed/simple;
	bh=QeoXDzoV9yjOqKK+9QC14lCPArOF1lBbk+V/VmEEVSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fU88wrjJr3DBBtz3ZfPudoT9AOq8zpTzCkGr6V+GLnzAY95G7P8waXuyt0LIbbJ3jqiB87Uw7laHMVzR3YnzdBKsahTO0aNfN5NjuIFDbzzMw9adrV2gYjxsuqZ00b2PGZlbWTStwCFfkFXsPhsbGOX+ZVJ+KAxO5gMS/jRfhxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B0/fQViY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XNFspYli; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728988023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpIqGV3FZABzIvwPIJ5wx08SyD5BMrHZo4Js9GlnC54=;
	b=B0/fQViYnGcwZkjQZs8vbCUqHVQOoQNorEgLOrCnMT3vYDGaR0Nn95bIYWFC1xtOzg+Rng
	wDIl46GY1RVTe6eAaTUVq5qsL9oB7kbUd2a2OgyGBonb2Ay6GaszVee+P+V176vZPYwmmS
	5ei7r6hiqvGM786Yp6uT3UF23VdR7s7uKctL0pMvp59t0O/MLl+2ltrBYl4OqFN+BgqEgq
	rO87KpZjg1HGHYOdJSL2WBgpk8+7gN1gXs8kOKTBC/uMvfcOClbZDNkYSgis6xWOjw3zyh
	xYWIcfCAU4QAonSwpCdUA9Faa3Sz3B/7DA8HxkkZwtuUpLFfjRexk+LBQqw07g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728988023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpIqGV3FZABzIvwPIJ5wx08SyD5BMrHZo4Js9GlnC54=;
	b=XNFspYlioZsgZddnrxGs0PI4T2EM6GhW1kvaym/ivzoAGUyjWZm91IPy6KSuszl8vAPU0I
	ciNVLtnKOz/v3TBQ==
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: vinicius.gomes@intel.com, Joe Damato <jdamato@fastly.com>, Tony Nguyen
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
In-Reply-To: <20241014213012.187976-3-jdamato@fastly.com>
References: <20241014213012.187976-1-jdamato@fastly.com>
 <20241014213012.187976-3-jdamato@fastly.com>
Date: Tue, 15 Oct 2024 12:27:01 +0200
Message-ID: <87h69d3bm2.fsf@kurt.kurt.home>
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

On Mon Oct 14 2024, Joe Damato wrote:
> Link queues to NAPI instances via netdev-genl API so that users can
> query this information with netlink. Handle a few cases in the driver:
>   1. Link/unlink the NAPIs when XDP is enabled/disabled
>   2. Handle IGC_FLAG_QUEUE_PAIRS enabled and disabled
>
> Example output when IGC_FLAG_QUEUE_PAIRS is enabled:
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json=3D'{"ifindex": 2}'
>
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
>
> Since IGC_FLAG_QUEUE_PAIRS is enabled, you'll note that the same NAPI ID
> is present for both rx and tx queues at the same index, for example
> index 0:
>
> {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
>
> To test IGC_FLAG_QUEUE_PAIRS disabled, a test system was booted using
> the grub command line option "maxcpus=3D2" to force
> igc_set_interrupt_capability to disable IGC_FLAG_QUEUE_PAIRS.
>
> Example output when IGC_FLAG_QUEUE_PAIRS is disabled:
>
> $ lscpu | grep "On-line CPU"
> On-line CPU(s) list:      0,2
>
> $ ethtool -l enp86s0  | tail -5
> Current hardware settings:
> RX:		n/a
> TX:		n/a
> Other:		1
> Combined:	2
>
> $ cat /proc/interrupts  | grep enp
>  144: [...] enp86s0
>  145: [...] enp86s0-rx-0
>  146: [...] enp86s0-rx-1
>  147: [...] enp86s0-tx-0
>  148: [...] enp86s0-tx-1
>
> 1 "other" IRQ, and 2 IRQs for each of RX and Tx, so we expect netlink to
> report 4 IRQs with unique NAPI IDs:
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump napi-get --json=3D'{"ifindex": 2}'
> [{'id': 8196, 'ifindex': 2, 'irq': 148},
>  {'id': 8195, 'ifindex': 2, 'irq': 147},
>  {'id': 8194, 'ifindex': 2, 'irq': 146},
>  {'id': 8193, 'ifindex': 2, 'irq': 145}]
>
> Now we examine which queues these NAPIs are associated with, expecting
> that since IGC_FLAG_QUEUE_PAIRS is disabled each RX and TX queue will
> have its own NAPI instance:
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  v2:
>    - Update commit message to include tests for IGC_FLAG_QUEUE_PAIRS
>      disabled
>    - Refactored code to move napi queue mapping and unmapping to helper
>      functions igc_set_queue_napi and igc_unset_queue_napi
>    - Adjust the code to handle IGC_FLAG_QUEUE_PAIRS disabled
>    - Call helpers to map/unmap queues to NAPIs in igc_up, __igc_open,
>      igc_xdp_enable_pool, and igc_xdp_disable_pool
>
>  drivers/net/ethernet/intel/igc/igc.h      |  3 ++
>  drivers/net/ethernet/intel/igc/igc_main.c | 58 +++++++++++++++++++++--
>  drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 +
>  3 files changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/=
intel/igc/igc.h
> index eac0f966e0e4..7b1c9ea60056 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -337,6 +337,9 @@ struct igc_adapter {
>  	struct igc_led_classdev *leds;
>  };
>=20=20
> +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> +			struct napi_struct *napi);
> +void igc_unset_queue_napi(struct igc_adapter *adapter, int q_idx);
>  void igc_up(struct igc_adapter *adapter);
>  void igc_down(struct igc_adapter *adapter);
>  int igc_open(struct net_device *netdev);
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethe=
rnet/intel/igc/igc_main.c
> index 7964bbedb16c..59c00acfa0ed 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -4948,6 +4948,47 @@ static int igc_sw_init(struct igc_adapter *adapter)
>  	return 0;
>  }
>=20=20
> +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> +			struct napi_struct *napi)
> +{
> +	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
> +		netif_queue_set_napi(adapter->netdev, q_idx,
> +				     NETDEV_QUEUE_TYPE_RX, napi);
> +		netif_queue_set_napi(adapter->netdev, q_idx,
> +				     NETDEV_QUEUE_TYPE_TX, napi);
> +	} else {
> +		if (q_idx < adapter->num_rx_queues) {
> +			netif_queue_set_napi(adapter->netdev, q_idx,
> +					     NETDEV_QUEUE_TYPE_RX, napi);
> +		} else {
> +			q_idx -=3D adapter->num_rx_queues;
> +			netif_queue_set_napi(adapter->netdev, q_idx,
> +					     NETDEV_QUEUE_TYPE_TX, napi);
> +		}
> +	}
> +}

In addition, to what Vinicius said. I think this can be done
simpler. Something like this?

void igc_set_queue_napi(struct igc_adapter *adapter, int vector,
			struct napi_struct *napi)
{
	struct igc_q_vector *q_vector =3D adapter->q_vector[vector];

	if (q_vector->rx.ring)
		netif_queue_set_napi(adapter->netdev, vector, NETDEV_QUEUE_TYPE_RX, napi);

	if (q_vector->tx.ring)
		netif_queue_set_napi(adapter->netdev, vector, NETDEV_QUEUE_TYPE_TX, napi);
}

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmcOQ3UTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzggP+EACbgGaNTWYbIcp1ENi3SQd4VQWHfX4P
NLZHtOiG+aBHjfLRpW+pHulbwJ4+fn/XOIoWc1HyoS3IjF95CKAiwK8SNPBivGb9
5zRmEqoz0yUZHJjdhZIboVwAZ9/1O92eE3gwtE++LW0oEoBcE4TqItDeZgQJ/jb8
zdmXp0pxQns7TEfFv5cDPTnnxZJgbbyDBHr9Le0jA27/hMwDzclgHqgpqyzoypdD
+B99POsjugofhiOVmzvWVYtTQ2Km/7Yt4pc45IAJG7M5sfqly8hfAmvutTuCeE0p
NGjW43qgpzCThQCWRL6QgiEqlDHndYAkLjrRxUNBEy2RwMvtZPJCFw54h3XrzfXB
/JXen5j1+gaFuFS/tF743VvLprsYPsKnKOa9sYU6ji7uKd6yKml8Rw8XUrWnPwjS
hpgzkewBeZVBYOJ/x+odtVMPBiFxhpoSmbhPnPNGs7P5SESJgPAtdkiQNqGzI81Z
mFgkNkRTkeyBiJ6NN43diLanEFeH5pGbFs8m7hrXBrAHxQP/c6A09KmCR5XS3Hra
dzG7EB+tvIrYfsQiEWwhZEC+j9m2MGT190NusYPX+Gv7d5RgL80vw7XGly5t91el
/SO30QNj8yItov0R//NqlZKx76hugTbW4NO+hJLqNCpU0woBG56v5N8y2VSuS4Fh
jQrQCDjVYZqMyg==
=yqMd
-----END PGP SIGNATURE-----
--=-=-=--

