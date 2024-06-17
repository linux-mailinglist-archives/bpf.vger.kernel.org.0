Return-Path: <bpf+bounces-32344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F61890BC20
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190A21F220B4
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECF319938C;
	Mon, 17 Jun 2024 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AmHsT91R"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2047.outbound.protection.outlook.com [40.92.19.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C119925A;
	Mon, 17 Jun 2024 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655864; cv=fail; b=UnZvXyyAXT1rHr2UCpND2OM7SEk7RN4+hD2DqDHTxPX9GiEc098TKLHEH8KiAQzPClOq2Zc6BDWUOCuQHVb8LDCiZq7TYdL36p/nPiclMUl5RBVJWMlzpdbFOhPL20eYyC2ixy/uL5yJkS6KwzBaHKPdnJAofctP+tOPWX1GEMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655864; c=relaxed/simple;
	bh=sdpnvebAT6glGq1f6m4BkB6WI7s0zujoR+KxCT623ZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=btHYXJnQYZYcdddmVRnXb4F+JtB4zJZmv22DJRGPwbJBbfFkOgxnkILgy+ODSEPRZoSBCJNuswAmFRYIDrAcDa6ZzY7w9GKjJXd9FvFfL7jFzWEXsj+wCLfDGgmjEShyNN5jvpJApCnuTc2LsEfqGKGaJxfrLZG4eFHoTBPiZRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AmHsT91R; arc=fail smtp.client-ip=40.92.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZDVniDEZ9c4ISl0bBDsHmDcObpK57S2syCthSgmyTiYBOyAYfvzjvmJtoUO33NM7n1+rwdFhqow2AaqfQr6TpqoVorflYEj/O14tDdqiwRs5N2G8vsuovbHPNpTOA1DS0NLcKf7kpsgu0l4WBQHa0gzjS7OhfSUwb1nZC5WW4E1W5J45hePwpqmSeSV+HnVp6AaMdTVL3BeAXQKUhy/bYGzeP27LnJilxECXAKSeaJGqX9xP1jL6QIZJe960/16YPq/7uSyPhxuf7l8sKD7tABm8ukETU/EAnRcKfjXfXknOSiINOAxpdY99ARpKt4DQXNWNkEAx48yL9p5G8Lt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4luBEEHYt+GA6kkOVde4TWM3/z2HmtQNwNz1iJ62Kk=;
 b=IANBSIGR03Nbx7k5+krZwqQwL93VqLoTICIHv2IE50chFOosTL75tNBNg25xUd1K8+NYE6ri1Ja6D3613fc17j9SfrLrN6gjuYudLo1KCEwfuEtaOwTGS1k0stHY1g/Ej7QChh7QtlUBkF2vCGfnBosnIuiUyzXrcFZ+r3sbrHnIGV0NlDU1lcmXVOACGPue1VQuibY8omuI72KV2OwloMhEUdORr5po3rq/UUy2+RN7HkIsYbwk8aXKLftAEShqkKWY2D4P6FJJ1G6hDf/HtRkM/pAgeMzvZc2Bx8tqvRMiNi0MJY3Ts78H4vAeNxUf3vReVcZOtSA5i81/0mB62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4luBEEHYt+GA6kkOVde4TWM3/z2HmtQNwNz1iJ62Kk=;
 b=AmHsT91RBlhhGNiPiDo38zAG0wGN6AyUr76fzEwmuWfnUhQrnM9LtPhA9qZbVxdU5ZDLYP+1wXzhPIJ+mhGIWBO5YE544Ap6PMd6Bj+tWgcf/KsSNjTKtUS7NtTjp0rJ5OmMYlqs5+GassrqQnxl5udJJoCPqHy15dgkLrPyq9A3DuATFWeP8mD9Bn5iksbWGCYt+eyFkGz/4v9D/N/Rkg1TCSWPcenZeIo6LDneGKKGvalZm7h1DJVgUjxa3g+S9bs3WVkFO1IMe+Er6UVAUa6KJDJuA/ZsGanz5sPEAGFCssN7O7Hrl91Y/+Mcxeu6vQw8Z+5GoyEx53AdXiia1w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB9990.namprd02.prod.outlook.com (2603:10b6:510:2f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:24:18 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7677.024; Mon, 17 Jun 2024
 20:24:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "decui@microsoft.com" <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"paulros@microsoft.com" <paulros@microsoft.com>, "olaf@aepfle.de"
	<olaf@aepfle.de>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>, "longli@microsoft.com"
	<longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org"
	<hawk@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3,net-next] net: mana: Add support for page sizes other
 than 4KB on ARM64
Thread-Topic: [PATCH v3,net-next] net: mana: Add support for page sizes other
 than 4KB on ARM64
Thread-Index: AQHawPPhLtZFBJCaIUmoJ4Dr9Zd+wrHMZmWA
Date: Mon, 17 Jun 2024 20:24:11 +0000
Message-ID:
 <SN6PR02MB415783B87750A2D577CEDF09D4CD2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1718655446-6576-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1718655446-6576-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [2KC5erPzCMpR0/oA1rvSfscInD+n456h]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB9990:EE_
x-ms-office365-filtering-correlation-id: d1ca9d51-2670-4fbe-d6e2-08dc8f0b72f6
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199025|3412199022|440099025|102099029;
x-microsoft-antispam-message-info:
 0iXysIA4er+YQVnFAwoJmYKUghGqiivBeruBjdWHyU5i1umJVqZxxEEkGubWnhmVLWwL19XWosGPn+AxRZwU6+3jCKoh6PWAgGFBQV1TNchiwmDbPPeGGZ3750hqhHm+YXiZYOsDKsKpyZiiRUlUpYhbW5ZuvhU8Z/7w5dnDjvmRXIpdSC7jF1p/pn5Jgt1eeFpCX9XGV7s4r5tnQyRDKodOJzdEmO7cfijKkPDOeWq4PjJzNJ3ApCnMfyaBnvsP7eAb0lm0YQsJRJBYvfNx7cp/NjpFJAk/UVhvNKw7Sz99H+Vz8nIZ++HTjCpP9dxIsM4EYVVgxHMgX+jwfs4Oca5jkV7Ha/NpmcPv3MZs6bEGp8qkTRMiQI/lwgfkcNaIkN/hRyIy9OVJEGnUjYJUYo3h1gJMK22fQu8lqG6xSgj1rXZOOxelB3OGXYI57XvRra/EIzSrFGFpp1A4GExh4e00yW7DOfs2SXZxq3v615+sQ9Mta4fksRasx9hDHpnwbIjjvznAaud/Mxs8MBYErFRcbWkUC8lB90FuSQK7w4dXGa0TFrCuIWTwaD6fs2D8
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Kb2eoPKWW0rU7WcuDbFNWPIQV5WdfgVvGfQ4oH8i+rh/KOcZpCItSKm32Ofh?=
 =?us-ascii?Q?o22aWWIHJq+PXLhzA/jOcQ+6HmPg00QwliLfZ7QlAT6efHPcrzUj81dK5o0R?=
 =?us-ascii?Q?00lfsvgp2aWF1XwNeXdc6B1e3lcqLOBHVwAvaF7Tv+PPlBpxANrwxXB7Qxe4?=
 =?us-ascii?Q?6NX7jBWGM+pjJcS84iRKAiL6MwyKzCxOAA08UEW2YyJS4XiDJ57fRmKnAhdf?=
 =?us-ascii?Q?xvmHecWWOFP9Rn7tMXQ0QRHhq9fAqWQ1A78LQ4tVzTRzzJAZaM+AUPM357A1?=
 =?us-ascii?Q?N7l+B8J8ri06MP7LbQM2g+/8hy17ylaOB167xzDWo6+mvsNuEnAx1Br+9tRi?=
 =?us-ascii?Q?8vO/OchvuRer6vkHXh68vfNmI5LBX5pMvAUbwhJlN8j/d+4s9OvDJv3P1YH2?=
 =?us-ascii?Q?qtPxBnAehwZOtvFYKGYahD6x2MpxwU0OGBPB93pmAvprgq2a1JdadEvgT3LJ?=
 =?us-ascii?Q?CWKDQXqvv3vRYfySFUOrkCW4zNLKNyCN8v+oSO9fd9fdQqq8SnO6F3omLYy7?=
 =?us-ascii?Q?RKmfjmJriFSOh7DOH5/TZ9joi7ewpNrYSt6AEftuF8CmuDNcgzf/Cubsk6Zy?=
 =?us-ascii?Q?sSEENxoKe5moj3OfU8wb2GoRFBHzHvf1Vtxk7+mjErIN8HC5zg3plRSZAtxk?=
 =?us-ascii?Q?2TE7Sn2LAtSOQF1/swI9JphxI4PG2wwP/lqNan6WFbLdBSaQIAf+Olq7/go7?=
 =?us-ascii?Q?+8YslikP3g+/TepfkP1FKpcsCl1KxVHWIWuRmdI5yJbi1sQ5twvTwnz3MpFv?=
 =?us-ascii?Q?pVdQjWZwLPfA175zTOdK6OyEndf+A9TsOVEMyJ35G2SpwKiUQLx2dJdz/OZb?=
 =?us-ascii?Q?n19LLnTN+leOAqEOk5AUc91oUZThM7iYFHNT2+SaaFnrZw+rMupdxoHkaRP3?=
 =?us-ascii?Q?RRDmy11D59Lig9BN2dbUHNDl48U7O7Let4ZuMbwaU4fPyVA9iEakpjWhZKU3?=
 =?us-ascii?Q?rq4J7F9q0GskpQTxZXoqHkHmlF28Aa9Y2Rq8ZvM95sxLM6kdupRZNDiMbJiB?=
 =?us-ascii?Q?B2ZXYoMsB0eU4IY/m5I3lQnt08SlWh3TUwt/djCfinlR787mm4Xh4OdJpSRB?=
 =?us-ascii?Q?Ea+SL+UWnnbxYjpyR/paQ9UzbWMoS0QKoZ7LO2njf4lyAq1/b1RzQwzLSK3J?=
 =?us-ascii?Q?GGPKB6IiC0Lvpbv0tMCPFIVslTpW0+02xRzpzI76rSfZv9E+YN/7r45PJhhA?=
 =?us-ascii?Q?+3I6niVzL2BAlIOramShSwue5thb7OX7RvwJ7mlwpMtwBBKS8OLDEjG7RlM?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ca9d51-2670-4fbe-d6e2-08dc8f0b72f6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 20:24:11.5840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9990

From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang Sent=
: Monday, June 17, 2024 1:17 PM
>=20
> As defined by the MANA Hardware spec, the queue size for DMA is 4KB
> minimal, and power of 2. And, the HWC queue size has to be exactly
> 4KB.
>=20
> To support page sizes other than 4KB on ARM64, define the minimal
> queue size as a macro separately from the PAGE_SIZE, which we always
> assumed it to be 4KB before supporting ARM64.
>=20
> Also, add MANA specific macros and update code related to size
> alignment, DMA region calculations, etc.
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
> v3: Updated two lenth checks as suggested by Michael.
>=20
> v2: Updated alignments, naming as suggested by Michael and Paul.
>=20
> ---
>  drivers/net/ethernet/microsoft/Kconfig            |  2 +-
>  drivers/net/ethernet/microsoft/mana/gdma_main.c   | 10 +++++-----
>  drivers/net/ethernet/microsoft/mana/hw_channel.c  | 14 +++++++-------
>  drivers/net/ethernet/microsoft/mana/mana_en.c     |  8 ++++----
>  drivers/net/ethernet/microsoft/mana/shm_channel.c | 13 +++++++------
>  include/net/mana/gdma.h                           | 10 +++++++++-
>  include/net/mana/mana.h                           |  3 ++-
>  7 files changed, 35 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/Kconfig
> b/drivers/net/ethernet/microsoft/Kconfig
> index 286f0d5697a1..901fbffbf718 100644
> --- a/drivers/net/ethernet/microsoft/Kconfig
> +++ b/drivers/net/ethernet/microsoft/Kconfig
> @@ -18,7 +18,7 @@ if NET_VENDOR_MICROSOFT
>  config MICROSOFT_MANA
>  	tristate "Microsoft Azure Network Adapter (MANA) support"
>  	depends on PCI_MSI
> -	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN && ARM64_4K_PAGES)
> +	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN)
>  	depends on PCI_HYPERV
>  	select AUXILIARY_BUS
>  	select PAGE_POOL
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 1332db9a08eb..e1d70d21e207 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -182,7 +182,7 @@ int mana_gd_alloc_memory(struct gdma_context *gc,
> unsigned int length,
>  	dma_addr_t dma_handle;
>  	void *buf;
>=20
> -	if (length < PAGE_SIZE || !is_power_of_2(length))
> +	if (length < MANA_PAGE_SIZE || !is_power_of_2(length))
>  		return -EINVAL;
>=20
>  	gmi->dev =3D gc->dev;
> @@ -717,7 +717,7 @@ EXPORT_SYMBOL_NS(mana_gd_destroy_dma_region,
> NET_MANA);
>  static int mana_gd_create_dma_region(struct gdma_dev *gd,
>  				     struct gdma_mem_info *gmi)
>  {
> -	unsigned int num_page =3D gmi->length / PAGE_SIZE;
> +	unsigned int num_page =3D gmi->length / MANA_PAGE_SIZE;
>  	struct gdma_create_dma_region_req *req =3D NULL;
>  	struct gdma_create_dma_region_resp resp =3D {};
>  	struct gdma_context *gc =3D gd->gdma_context;
> @@ -727,10 +727,10 @@ static int mana_gd_create_dma_region(struct gdma_de=
v
> *gd,
>  	int err;
>  	int i;
>=20
> -	if (length < PAGE_SIZE || !is_power_of_2(length))
> +	if (length < MANA_PAGE_SIZE || !is_power_of_2(length))
>  		return -EINVAL;
>=20
> -	if (offset_in_page(gmi->virt_addr) !=3D 0)
> +	if (!MANA_PAGE_ALIGNED(gmi->virt_addr))
>  		return -EINVAL;
>=20
>  	hwc =3D gc->hwc.driver_data;
> @@ -751,7 +751,7 @@ static int mana_gd_create_dma_region(struct gdma_dev =
*gd,
>  	req->page_addr_list_len =3D num_page;
>=20
>  	for (i =3D 0; i < num_page; i++)
> -		req->page_addr_list[i] =3D gmi->dma_handle +  i * PAGE_SIZE;
> +		req->page_addr_list[i] =3D gmi->dma_handle +  i * MANA_PAGE_SIZE;
>=20
>  	err =3D mana_gd_send_request(gc, req_msg_size, req, sizeof(resp), &resp=
);
>  	if (err)
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index bbc4f9e16c98..cafded2f9382 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -362,12 +362,12 @@ static int mana_hwc_create_cq(struct hw_channel_con=
text
> *hwc, u16 q_depth,
>  	int err;
>=20
>  	eq_size =3D roundup_pow_of_two(GDMA_EQE_SIZE * q_depth);
> -	if (eq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
> -		eq_size =3D MINIMUM_SUPPORTED_PAGE_SIZE;
> +	if (eq_size < MANA_MIN_QSIZE)
> +		eq_size =3D MANA_MIN_QSIZE;
>=20
>  	cq_size =3D roundup_pow_of_two(GDMA_CQE_SIZE * q_depth);
> -	if (cq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
> -		cq_size =3D MINIMUM_SUPPORTED_PAGE_SIZE;
> +	if (cq_size < MANA_MIN_QSIZE)
> +		cq_size =3D MANA_MIN_QSIZE;
>=20
>  	hwc_cq =3D kzalloc(sizeof(*hwc_cq), GFP_KERNEL);
>  	if (!hwc_cq)
> @@ -429,7 +429,7 @@ static int mana_hwc_alloc_dma_buf(struct
> hw_channel_context *hwc, u16 q_depth,
>=20
>  	dma_buf->num_reqs =3D q_depth;
>=20
> -	buf_size =3D PAGE_ALIGN(q_depth * max_msg_size);
> +	buf_size =3D MANA_PAGE_ALIGN(q_depth * max_msg_size);
>=20
>  	gmi =3D &dma_buf->mem_info;
>  	err =3D mana_gd_alloc_memory(gc, buf_size, gmi);
> @@ -497,8 +497,8 @@ static int mana_hwc_create_wq(struct hw_channel_conte=
xt
> *hwc,
>  	else
>  		queue_size =3D roundup_pow_of_two(GDMA_MAX_SQE_SIZE *
> q_depth);
>=20
> -	if (queue_size < MINIMUM_SUPPORTED_PAGE_SIZE)
> -		queue_size =3D MINIMUM_SUPPORTED_PAGE_SIZE;
> +	if (queue_size < MANA_MIN_QSIZE)
> +		queue_size =3D MANA_MIN_QSIZE;
>=20
>  	hwc_wq =3D kzalloc(sizeof(*hwc_wq), GFP_KERNEL);
>  	if (!hwc_wq)
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index b89ad4afd66e..1381de866b2e 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1904,10 +1904,10 @@ static int mana_create_txq(struct mana_port_conte=
xt
> *apc,
>  	 *  to prevent overflow.
>  	 */
>  	txq_size =3D MAX_SEND_BUFFERS_PER_QUEUE * 32;
> -	BUILD_BUG_ON(!PAGE_ALIGNED(txq_size));
> +	BUILD_BUG_ON(!MANA_PAGE_ALIGNED(txq_size));
>=20
>  	cq_size =3D MAX_SEND_BUFFERS_PER_QUEUE * COMP_ENTRY_SIZE;
> -	cq_size =3D PAGE_ALIGN(cq_size);
> +	cq_size =3D MANA_PAGE_ALIGN(cq_size);
>=20
>  	gc =3D gd->gdma_context;
>=20
> @@ -2204,8 +2204,8 @@ static struct mana_rxq *mana_create_rxq(struct
> mana_port_context *apc,
>  	if (err)
>  		goto out;
>=20
> -	rq_size =3D PAGE_ALIGN(rq_size);
> -	cq_size =3D PAGE_ALIGN(cq_size);
> +	rq_size =3D MANA_PAGE_ALIGN(rq_size);
> +	cq_size =3D MANA_PAGE_ALIGN(cq_size);
>=20
>  	/* Create RQ */
>  	memset(&spec, 0, sizeof(spec));
> diff --git a/drivers/net/ethernet/microsoft/mana/shm_channel.c
> b/drivers/net/ethernet/microsoft/mana/shm_channel.c
> index 5553af9c8085..0f1679ebad96 100644
> --- a/drivers/net/ethernet/microsoft/mana/shm_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/shm_channel.c
> @@ -6,6 +6,7 @@
>  #include <linux/io.h>
>  #include <linux/mm.h>
>=20
> +#include <net/mana/gdma.h>
>  #include <net/mana/shm_channel.h>
>=20
>  #define PAGE_FRAME_L48_WIDTH_BYTES 6
> @@ -155,8 +156,8 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool
> reset_vf, u64 eq_addr,
>  		return err;
>  	}
>=20
> -	if (!PAGE_ALIGNED(eq_addr) || !PAGE_ALIGNED(cq_addr) ||
> -	    !PAGE_ALIGNED(rq_addr) || !PAGE_ALIGNED(sq_addr))
> +	if (!MANA_PAGE_ALIGNED(eq_addr) || !MANA_PAGE_ALIGNED(cq_addr) ||
> +	    !MANA_PAGE_ALIGNED(rq_addr) || !MANA_PAGE_ALIGNED(sq_addr))
>  		return -EINVAL;
>=20
>  	if ((eq_msix_index & VECTOR_MASK) !=3D eq_msix_index)
> @@ -183,7 +184,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool
> reset_vf, u64 eq_addr,
>=20
>  	/* EQ addr: low 48 bits of frame address */
>  	shmem =3D (u64 *)ptr;
> -	frame_addr =3D PHYS_PFN(eq_addr);
> +	frame_addr =3D MANA_PFN(eq_addr);
>  	*shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
>  	all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
>  		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> @@ -191,7 +192,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool
> reset_vf, u64 eq_addr,
>=20
>  	/* CQ addr: low 48 bits of frame address */
>  	shmem =3D (u64 *)ptr;
> -	frame_addr =3D PHYS_PFN(cq_addr);
> +	frame_addr =3D MANA_PFN(cq_addr);
>  	*shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
>  	all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
>  		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> @@ -199,7 +200,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool
> reset_vf, u64 eq_addr,
>=20
>  	/* RQ addr: low 48 bits of frame address */
>  	shmem =3D (u64 *)ptr;
> -	frame_addr =3D PHYS_PFN(rq_addr);
> +	frame_addr =3D MANA_PFN(rq_addr);
>  	*shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
>  	all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
>  		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> @@ -207,7 +208,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool
> reset_vf, u64 eq_addr,
>=20
>  	/* SQ addr: low 48 bits of frame address */
>  	shmem =3D (u64 *)ptr;
> -	frame_addr =3D PHYS_PFN(sq_addr);
> +	frame_addr =3D MANA_PFN(sq_addr);
>  	*shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
>  	all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
>  		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index c547756c4284..83963d9e804d 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -224,7 +224,15 @@ struct gdma_dev {
>  	struct auxiliary_device *adev;
>  };
>=20
> -#define MINIMUM_SUPPORTED_PAGE_SIZE PAGE_SIZE
> +/* MANA_PAGE_SIZE is the DMA unit */
> +#define MANA_PAGE_SHIFT 12
> +#define MANA_PAGE_SIZE BIT(MANA_PAGE_SHIFT)
> +#define MANA_PAGE_ALIGN(x) ALIGN((x), MANA_PAGE_SIZE)
> +#define MANA_PAGE_ALIGNED(addr) IS_ALIGNED((unsigned long)(addr),
> MANA_PAGE_SIZE)
> +#define MANA_PFN(a) ((a) >> MANA_PAGE_SHIFT)
> +
> +/* Required by HW */
> +#define MANA_MIN_QSIZE MANA_PAGE_SIZE
>=20
>  #define GDMA_CQE_SIZE 64
>  #define GDMA_EQE_SIZE 16
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 59823901b74f..e39b8676fe54 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -42,7 +42,8 @@ enum TRI_STATE {
>=20
>  #define MAX_SEND_BUFFERS_PER_QUEUE 256
>=20
> -#define EQ_SIZE (8 * PAGE_SIZE)
> +#define EQ_SIZE (8 * MANA_PAGE_SIZE)
> +
>  #define LOG2_EQ_THROTTLE 3
>=20
>  #define MAX_PORTS_IN_MANA_DEV 256
> --
> 2.34.1
>=20


