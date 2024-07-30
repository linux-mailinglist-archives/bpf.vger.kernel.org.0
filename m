Return-Path: <bpf+bounces-36055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80906940E72
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 11:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47071C222F6
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A99197A82;
	Tue, 30 Jul 2024 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uR0sgPqO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k4Js5UuQ"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9E195FE5;
	Tue, 30 Jul 2024 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333521; cv=none; b=iFWG4p8s+Oqug/dF6gBww+xJsoB34wOjCEKNbv/Znqr069SH/gpb/2oz23wpjDe0W44HYThC2YUrtQYhthMekRzdEkOtsEWcaqp4Y7rx+bLoecJeNiqIvEIXMneFsNDFxcYOxaxkt640+Z6ojqMJvUUd30AUO0Pzq3Qz86I/Fv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333521; c=relaxed/simple;
	bh=pBW1iXUgUWPqF8BiZCdFB4ILrvn3db6+hfo+Ctdyk48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q5Nd90TKyL4H2AHmvzD7CCga67+0tTzlmxXXCl9lLgTSap8D7+p4XDz6zLN3M7shEqgrSarU15EywuMVfbZyHwuDKG21byfPB6aCpk6ahWmUGsuE0y+G8Qnp6sIbMtiSf+MJEEz/wxdczR4OMf0bofi+DMfNSMsb7G9bPcedYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uR0sgPqO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k4Js5UuQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722333516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RGoEM2sBI9H+4jdzkqFA7zQ20wEq+y0hpMq3862q89o=;
	b=uR0sgPqO4CkZIXC3qLkB1+lOBK+9HOm16MLEx8B+FIaE4W5QuWyc44hBBJ++xHLjrdjDTm
	R5IuH5iW7j70XU2Q3HgFoNYtJ8nskjskL5fdMD3sGiZijIYqoZ8pS6o9b6XHYx+N/nKbRE
	V+Y6HThiQMlnVbmJzm65d0qxzVOQosw5QZ/I1q3eUXDCth2hW8r460bc1bfbNVcnOPGd/A
	iskkM3RRSKYFcGbZAjlqmg7oOCWVEad/ILxPfDdcVTBvNXbavf2Y1sMKcHo26hV8a+huNq
	9fMzm2JZAKYTsS3crhhOi1N5FBINQBSJGdPM0n/PzyEpyZ4cG9oEiEe3+hVKyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722333516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RGoEM2sBI9H+4jdzkqFA7zQ20wEq+y0hpMq3862q89o=;
	b=k4Js5UuQd4uIH5icrNshrFG5sJwDCLMzqjPnnBx9lE40D/UgblZ5kjap+oBRnQj9eCYa2i
	KXp+/I9hlX78TwBg==
To: Song Yoong Siang <yoong.siang.song@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Jonathan Corbet <corbet@lwn.net>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Shinas Rasheed
 <srasheed@marvell.com>, Kevin Tian <kevin.tian@intel.com>, Brett Creeley
 <brett.creeley@amd.com>, Blanco Alcaine Hector
 <hector.blanco.alcaine@intel.com>, Joshua Hay <joshua.a.hay@intel.com>,
 Sasha Neftin <sasha.neftin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH iwl-next,v1 2/3] igc: Add default Rx queue configuration
 via sysfs
In-Reply-To: <20240730012312.775893-1-yoong.siang.song@intel.com>
References: <20240730012312.775893-1-yoong.siang.song@intel.com>
Date: Tue, 30 Jul 2024 11:58:34 +0200
Message-ID: <87plqvjj5h.fsf@kurt.kurt.home>
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

On Tue Jul 30 2024, Song Yoong Siang wrote:
> From: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
>
> This commit introduces the support to configure default Rx queue during
> runtime. A new sysfs attribute "default_rx_queue" has been added, allowing
> users to check and modify the default Rx queue.
>
> 1. Command to check the currently configured default Rx queue:
>    cat /sys/devices/pci0000:00/.../default_rx_queue
>
> 2. Command to set the default Rx queue to a desired value, for example 3:
>    echo 3 > /sys/devices/pci0000:00/.../default_rx_queue
>
> Signed-off-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>

[...]

> index e5b893fc5b66..df96800f6e3b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_regs.h
> +++ b/drivers/net/ethernet/intel/igc/igc_regs.h
> @@ -63,6 +63,12 @@
>  /* RSS registers */
>  #define IGC_MRQC		0x05818 /* Multiple Receive Control - RW */
>=20=20
> +/* MRQC register bit definitions */

Nit: Now, the MRQC register definitions are scattered over two files:
igc_regs.h and igc.h. igc.h has

#define IGC_MRQC_ENABLE_RSS_MQ		0x00000002
#define IGC_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
#define IGC_MRQC_RSS_FIELD_IPV6_UDP	0x00800000

Maybe combine them into a single location?

> +#define IGC_MRQC_ENABLE_MQ		0x00000000
> +#define IGC_MRQC_ENABLE_MASK		GENMASK(2, 0)
> +#define IGC_MRQC_DEFAULT_QUEUE_MASK	GENMASK(5, 3)
> +#define IGC_MRQC_DEFAULT_QUEUE_SHIFT	3

Nit: FIELD_GET() and FIELD_PREP() can help to get rid of the manual
shifting. See below.=20

> +
>  /* Filtering Registers */
>  #define IGC_ETQF(_n)		(0x05CB0 + (4 * (_n))) /* EType Queue Fltr */
>  #define IGC_FHFT(_n)		(0x09000 + (256 * (_n))) /* Flexible Host Filter */
> diff --git a/drivers/net/ethernet/intel/igc/igc_sysfs.c b/drivers/net/eth=
ernet/intel/igc/igc_sysfs.c
> new file mode 100644
> index 000000000000..34d838e6a019
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/igc/igc_sysfs.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Intel Corporation */
> +
> +#include <linux/device.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include "igc.h"
> +#include "igc_regs.h"
> +#include "igc_sysfs.h"
> +
> +/**
> + * igc_is_default_queue_supported - Checks if default Rx queue can be co=
nfigured
> + * @mrqc: MRQC register content
> + *
> + * Checks if the current configuration of the device supports changing t=
he
> + * default Rx queue configuration.
> + *
> + * Return: true if the default Rx queue can be configured, false otherwi=
se.
> + */
> +static bool igc_is_default_queue_supported(u32 mrqc)
> +{
> +	u32 mrqe =3D mrqc & IGC_MRQC_ENABLE_MASK;
> +
> +	/* The default Rx queue setting is applied only if Multiple Receive
> +	 * Queues (MRQ) as defined by filters (2-tuple filters, L2 Ether-type
> +	 * filters, SYN filter and flex filters) is enabled.
> +	 */
> +	if (mrqe !=3D IGC_MRQC_ENABLE_MQ && mrqe !=3D IGC_MRQC_ENABLE_RSS_MQ)
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * igc_get_default_rx_queue - Returns the index of default Rx queue
> + * @adapter: address of board private structure
> + *
> + * Return: index of the default Rx queue.
> + */
> +static u32 igc_get_default_rx_queue(struct igc_adapter *adapter)
> +{
> +	struct igc_hw *hw =3D &adapter->hw;
> +	u32 mrqc =3D rd32(IGC_MRQC);
> +
> +	if (!igc_is_default_queue_supported(mrqc)) {
> +		netdev_warn(adapter->netdev,
> +			    "MRQ disabled: default RxQ is ignored.\n");
> +	}
> +
> +	return (mrqc & IGC_MRQC_DEFAULT_QUEUE_MASK) >>
> +		IGC_MRQC_DEFAULT_QUEUE_SHIFT;

Nit: return FIELD_GET(IGC_MRQC_DEFAULT_QUEUE_MASK, mrqc);

> +}
> +
> +/**
> + * igc_set_default_rx_queue - Sets the default Rx queue
> + * @adapter: address of board private structure
> + * @queue: index of the queue to be set as default Rx queue
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int igc_set_default_rx_queue(struct igc_adapter *adapter, u32 que=
ue)
> +{
> +	struct igc_hw *hw =3D &adapter->hw;
> +	u32 mrqc =3D rd32(IGC_MRQC);
> +
> +	if (!igc_is_default_queue_supported(mrqc)) {
> +		netdev_err(adapter->netdev,
> +			   "Default RxQ not supported. Please enable MRQ.\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (queue > adapter->rss_queues - 1) {
> +		netdev_err(adapter->netdev,
> +			   "Invalid default RxQ index %d. Valid range: 0-%u.\n",
> +			   queue, adapter->rss_queues - 1);
> +		return -EINVAL;
> +	}
> +
> +	/* Set the default Rx queue */
> +	mrqc =3D rd32(IGC_MRQC);
> +	mrqc &=3D ~IGC_MRQC_DEFAULT_QUEUE_MASK;
> +	mrqc |=3D queue << IGC_MRQC_DEFAULT_QUEUE_SHIFT;

Nit: mrqc |=3D FIELD_PREP(IGC_MRQC_DEFAULT_QUEUE_MASK, queue);

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmaouUoTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgtBQEACSIf0aYuaOphs8JPYmE2MJMfO+x270
iNE9MGJpBgiso4SlT3dNT05mFcKNDVQW/azmtJDRlgMSf3xBlbdexN2Gag/PK4Ah
lJATYGUABykY3ThNAAhMUV4YbzcAa0r0C34oorr3s+mIGh4k0xeRbAaAF12tTezN
asnXQ5tFLlCMfi3uKK7y+YW4SENhnDMbw4QEPzN8xqoU1gfVSVSZHdlE2E7aGx2r
GTIdo3gNiYwplUZo4zPQfC9v02XGzM73bYNs7mNBlktnxn9Tn5GH+TmNxFbDgroI
kQaw2ytg9X+b+9TSGkCCvCzFv2fH4DmRPMshOetPnrHhKm9VYTkGhbvdr4k9jZUi
EG72L1w+8YBy8UG+bo63bjhFRnIP+7N7YVYVZBrUBmBFtdHyWIE8vG2IppUWUw+r
8UChtvhhmRjmyTTbKE4YvdFOu2u4EF9a3ex0s/4sMN86pjegqZFm8qBlWbjIh+B1
O6iyzKkWHBtrUJZYHto8xM+1nwkz1+Ny5muGhqZh6AHKZItDsrbwwWJYeLd/ovmX
oiGRoQ5XSDBlZaV9PE6LmZnfE616UgbSuLfIfF4yQxrbCa4BGe9SaawBX4aiB/kG
qL+xJUKR98cjwmCKSYQvGOHyAno4HWv3tgCP8oz0LZyUs6/hxs461S/biL87c58R
yCkNyHwZ0+2zWg==
=vGQh
-----END PGP SIGNATURE-----
--=-=-=--

