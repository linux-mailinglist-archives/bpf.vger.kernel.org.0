Return-Path: <bpf+bounces-32239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAC9909B84
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 06:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7951C20E2B
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 04:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5102816C864;
	Sun, 16 Jun 2024 04:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ID40HFLD"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2020.outbound.protection.outlook.com [40.92.42.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D879F5;
	Sun, 16 Jun 2024 04:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718510657; cv=fail; b=ORkm5DiRCXleSzu2eiL0Vm6PQczRgRLqI6PG9groOwbAYk/VtkcFdK644OVneAEzU929vPPbKWmcqaIuVWZY7DYx5cBmJ7gqBZAdSxb9QROevfoRmAYhp2qFWa+u8ebl/dL/dN/WLIPr4VnnqH1LmaUxfii+CqDMHppkxfoticM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718510657; c=relaxed/simple;
	bh=1kYAyGyhE78fcZmPD+Kz9eLayz4PDeVBK/SnCI8y3Hc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kemqm9m8a2eHZb0qsOn6NaAIievhp28wodauSRJG8bWhVmizYkIZFvQAZJ4MRhPfx2qYJGUd873ymif7kBnK0MpyuvQqj7kyw7yZHAEcFQDywbYBfgpVLC2u66B7vG7oY1ol8a/VMMebgMcSvPdVO50ZWXWVVfVE2k6RVXeKyt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ID40HFLD; arc=fail smtp.client-ip=40.92.42.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYQ7WNuC7sty+ry8vf/9tHFZ+S7bZnV/uEMLL+ffLcMkSMsl2yZ0O0G1rcqhHWM6fF27r8hTRq3tbMc7tbSkC1MFNZfZkr/0gDJVbwx9Zvz62ScQw5OrQsPtm02YoShpxlcoOXylno9GHe8LmmqTPl6PxsFZEgnKepvHGEOVq//f8wkrw00XRk4C6DefHic2HGmlKbYBQ0Vfkn0BMavPJspQIB0a+utgIyIKTE+quLkA9U1CgGCBzayNZkDNZjHe9LoPUX9uQ/26GccoSkQiPYHSm+oF1UFttY0cLCX4NuxtRT+R06KfVzvO1BWydM8dO6MbTeVOwLMotD3eMCbQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QTJcO7C3IZqaC2+tv2AxzomAHdBWJ4FndYsp6qFoow=;
 b=OQjpemjYuWh05MHXt3Vkggx6sLT1pVLqCSAjhDsv8WkKapN0SnSfY5vTOg//Wz7/BvAGeCBdT9gTpRf79ySS5D82V9Pgoq7Y1BbYAkhcC+VTLtsAz+y+uTvl/J01M+4NH0K9T/JQQnCAPabK3nODC2lFRMEPTxvRmiRY3Twc+z/FsMGi69BGwMA5YWjf0XToWUu0wOyUBkx82y91fFQbAslLkuMiD01U/hWAQJ08LVaUp43RSmGlp8V8Y4hs59S7BPfMWxPru5Wq/vacmTikzTVLlBb4LlwC1x+OQY7Kt6jQKp4eg1gdpMCIOGCy8tLfyhfNMin3Gi8zrkIvnSjNwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QTJcO7C3IZqaC2+tv2AxzomAHdBWJ4FndYsp6qFoow=;
 b=ID40HFLDzLg6lkwj4RIUGPzqra526G3RfYicsg4rffyjZFEWv6di4RzjDnAzt72RGtWrb/z7kmQ6BfpDvXRDbjF/qAO1a0fTtBnQzip3nfS3AwB9xpzYZ9QnfaiqEGyfPj8l3i0dkWc3/4N92HDyJ3aKNtf+BBYbct56vYbcg0jaDmdFpHHy4DV635BtkOzBWUEnzhTirt76aq2XK3z0CsBdwtZWGoghYgPTwUBdjtlH1zkzK9WDXjMchcuCcSsykqSay6Ycf0FMcyxyYLERHSBIPEqKptKi+jfrE5UuSGpHOmAz4qdrg++15qYof75aAm20OZSzVfpqAFYYjmFmvg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA1PR02MB9467.namprd02.prod.outlook.com (2603:10b6:208:3f1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Sun, 16 Jun
 2024 04:04:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7677.024; Sun, 16 Jun 2024
 04:04:12 +0000
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
Subject: RE: [PATCH v2, net-next] net: mana: Add support for page sizes other
 than 4KB on ARM64
Thread-Topic: [PATCH v2, net-next] net: mana: Add support for page sizes other
 than 4KB on ARM64
Thread-Index: AQHavonct0KkXZKruEK7jBH9r8Q1LrHI2wYw
Date: Sun, 16 Jun 2024 04:04:11 +0000
Message-ID:
 <SN6PR02MB41573C486E03FA07162F7CA7D4CC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1718390136-25954-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1718390136-25954-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [YoMlZ46ybdW9OuecHx77U2yIrQrhne2y]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA1PR02MB9467:EE_
x-ms-office365-filtering-correlation-id: a8b4d111-0b77-4329-0c9f-08dc8db9613b
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199025|440099025|3412199022|102099029;
x-microsoft-antispam-message-info:
 jBw0Buhn+vJndfdQSaiBT5sORxsO0q7qTIvbahJWDCgM6OiWwX6cZ99o78D3N0evesUXPA5TVndViqOfBlQe2z4QGJl1lyEtUocT0buGyOYhKZ4xn9aL8AZdH61Q+pNJvVthWRNWnl3ba24NsvXuJnUVQJhneiha4Q/Q8wr+DFKDaNSBTGFJR4vlpeUbM3rVxp2Zctpj8RRJfOecuEWuVYDHGrwPXSD1ftqhb6Y1cBsNrlulxmBHzd6swC7ritgR6lwcDYRBC7XeipASN/tVKi8bIWAj6J/gB6rQjBhzd1PlfLcYEKLGhBLKegaWxhJ+ploSqA9ABchf7XK3g63IP/gLEuEIdsVdZyYEKJDSLLPES9HCXXfsN5pP9or9tZ6N9F6ywyputh0P3g9uCOxeEn92rsRkBfhBlquym+XmyHa1s7XDZYBqivTlkzU0iH0H4yCYF1h7qNITVKC5ilLH/i9pkqm3sF8VUUnBaT/YjBNs4+TRsYYd4wKKjCprFPErjEWUkepXbC0RgZulq3+DCSdCAhkYtcD3WUBwC4IuTwgv7oT+TW1GBdBsCM2OPPUF
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1V3zUlpltJUbfVaDLJWNf/6yPO6/5wYuHSx8lvNf4MAEpscIQrzHb0II0YNY?=
 =?us-ascii?Q?4Q+YEFW80N4+wT3W/NyK15uPrjE2Q1BxlWISudeGqEao1POFlDNQnh9y0gE3?=
 =?us-ascii?Q?d2zZL9HG69SV8LQwwVrj6VHrKIh3XO3Y+OvKzHiuk0UWZANoi1R20MR+D0tE?=
 =?us-ascii?Q?KOP7E9agZaapEIEISPOz4ZhX0aypnWf7O8dAqOQ3mGCKnfZaix8EW8+qk29d?=
 =?us-ascii?Q?+SWV4lGt68ppHYQcnX6nTMvowLQJUfhPPEex7Qk8/1evNtPaacICau/7pNM+?=
 =?us-ascii?Q?D0JJDtXZACOpBV66UWLuo27qzwPPzsJybtxqT6uQU2nZlwzGyeGnkyJhLG+P?=
 =?us-ascii?Q?NgWb1hSaM3UGvVssUTZtiPnHOTpZcUTgfNLwViIix/g9nJiRnrE991iEyYfD?=
 =?us-ascii?Q?COSQvzQ9JZ5yLrxSGFrHOnTcSjNzap7dOiKjSS7ipjtPmyNa/s82it7lzEyz?=
 =?us-ascii?Q?NZeQB6LtVRNtr1WNcRxyznTmt0P2pCdorZ2zE9VpxcIzROjRnX2z3U6rjOXE?=
 =?us-ascii?Q?7JoKSMxuhIZ/1jqX9COPHIx6zR7NILKnCRy/VdXpmzCteY5EPFNIPJm8TFyl?=
 =?us-ascii?Q?/1KON3uXJs1Q4YJWV5lj/2SQQ8fc3BsG3Jo6VZ+ilTkXRIS4U1pKlic2ntyZ?=
 =?us-ascii?Q?HxnZQohHu4gpWEUa2MxquyI4v5l8J8e19repsaWu5OxNsaNA0F6UoUAK/+4J?=
 =?us-ascii?Q?qyoim4/Q6aS39Kd0O6FeMubwq52uRstnG542LUGNNFA3EcOJXfwJMaG+HxBG?=
 =?us-ascii?Q?q0dyHEM9GMhs7gWaV9AJrFUyrvC2c4301v/7eQe/HPhm9Q7iZPupakeonlY9?=
 =?us-ascii?Q?tmyHk9KGrv/pbVuFDtSfF0TeEXMJTMzV2RuvtoUuSkcbyzFF6Sv7D4ZYORvZ?=
 =?us-ascii?Q?9LvzxLkFHi7r1wiqONyKetUe78wD88s9rHAa3AzhNObd5caCsH8lpWIF7C8K?=
 =?us-ascii?Q?oCeeAke4qLc8ZrB9qrWhoaZzpIKFefLdHa62eCGcKyJA0V5yqBjAFaasLjkw?=
 =?us-ascii?Q?qNaclvPlSF9cFlQSTXuGFwWTl/VUrLrNtHfmF2VdybUzQp1C+e61Y1qDiJrq?=
 =?us-ascii?Q?bRjczdcPqLIcZ60uT77XF7br/+oKRz+dmZYRL7pbKhQIZZsEFJdRoHVkHEyh?=
 =?us-ascii?Q?8QfOOnHTvWRQKLIjU6P7iSDdRsMHq/l5gOUUDpsLrbJwGqC5RrejOUL9Aq6V?=
 =?us-ascii?Q?BFSzjOPKIIEbQ07Hd54BFx0MmQszSCkV1RX8Rul0P61l7ZdCZigX+nY91e0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b4d111-0b77-4329-0c9f-08dc8db9613b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2024 04:04:11.9009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9467

From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang Sent=
: Friday, June 14, 2024 11:36 AM
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
> ---
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
> index 1332db9a08eb..aa215e2e9606 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -182,7 +182,7 @@ int mana_gd_alloc_memory(struct gdma_context *gc, uns=
igned int length,
>  	dma_addr_t dma_handle;
>  	void *buf;
>=20
> -	if (length < PAGE_SIZE || !is_power_of_2(length))
> +	if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
>  		return -EINVAL;

Since mana_gd_alloc_memory() is a somewhat generic function that wraps
dma_alloc_coherent(), checking the length against MANA_MIN_QSIZE is
unexpected.  In looking at the call graph, I see that mana_gd_alloc_memory(=
)
is used in creating queues, but all the callers already ensure that the min=
imum
size requirement is met.  For robustness, having a check here seems OK, but
I would have expected checking against MANA_PAGE_SIZE, since that's the
DMA-related concept.

>=20
>  	gmi->dev =3D gc->dev;
> @@ -717,7 +717,7 @@ EXPORT_SYMBOL_NS(mana_gd_destroy_dma_region, NET_MANA=
);
>  static int mana_gd_create_dma_region(struct gdma_dev *gd,
>  				     struct gdma_mem_info *gmi)
>  {
> -	unsigned int num_page =3D gmi->length / PAGE_SIZE;
> +	unsigned int num_page =3D gmi->length / MANA_PAGE_SIZE;
>  	struct gdma_create_dma_region_req *req =3D NULL;
>  	struct gdma_create_dma_region_resp resp =3D {};
>  	struct gdma_context *gc =3D gd->gdma_context;
> @@ -727,10 +727,10 @@ static int mana_gd_create_dma_region(struct gdma_de=
v *gd,
>  	int err;
>  	int i;
>=20
> -	if (length < PAGE_SIZE || !is_power_of_2(length))
> +	if (length < MANA_MIN_QSIZE || !is_power_of_2(length))

Same here.  Checking against MANA_MIN_QSIZE is unexpected in a function dev=
oted
to DMA functionality.  Callers higher in the call graph already ensure that=
 the
MANA_MIN_QSIZE requirement is met.  Again, for robustness, checking against
MANA_PAGE_SIZE would be OK.

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
text *hwc, u16 q_depth,
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
> @@ -429,7 +429,7 @@ static int mana_hwc_alloc_dma_buf(struct hw_channel_c=
ontext *hwc, u16 q_depth,
>=20
>  	dma_buf->num_reqs =3D q_depth;
>=20
> -	buf_size =3D PAGE_ALIGN(q_depth * max_msg_size);
> +	buf_size =3D MANA_PAGE_ALIGN(q_depth * max_msg_size);
>=20
>  	gmi =3D &dma_buf->mem_info;
>  	err =3D mana_gd_alloc_memory(gc, buf_size, gmi);
> @@ -497,8 +497,8 @@ static int mana_hwc_create_wq(struct hw_channel_conte=
xt *hwc,
>  	else
>  		queue_size =3D roundup_pow_of_two(GDMA_MAX_SQE_SIZE * q_depth);
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
xt *apc,
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
> @@ -2204,8 +2204,8 @@ static struct mana_rxq *mana_create_rxq(struct mana=
_port_context *apc,
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
> @@ -155,8 +156,8 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool r=
eset_vf, u64 eq_addr,
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
> @@ -183,7 +184,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool r=
eset_vf, u64 eq_addr,
>=20
>  	/* EQ addr: low 48 bits of frame address */
>  	shmem =3D (u64 *)ptr;
> -	frame_addr =3D PHYS_PFN(eq_addr);
> +	frame_addr =3D MANA_PFN(eq_addr);
>  	*shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
>  	all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
>  		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> @@ -191,7 +192,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool r=
eset_vf, u64 eq_addr,
>=20
>  	/* CQ addr: low 48 bits of frame address */
>  	shmem =3D (u64 *)ptr;
> -	frame_addr =3D PHYS_PFN(cq_addr);
> +	frame_addr =3D MANA_PFN(cq_addr);
>  	*shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
>  	all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
>  		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> @@ -199,7 +200,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool r=
eset_vf, u64 eq_addr,
>=20
>  	/* RQ addr: low 48 bits of frame address */
>  	shmem =3D (u64 *)ptr;
> -	frame_addr =3D PHYS_PFN(rq_addr);
> +	frame_addr =3D MANA_PFN(rq_addr);
>  	*shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
>  	all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
>  		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> @@ -207,7 +208,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool r=
eset_vf, u64 eq_addr,
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

The rest of the changes here look good to me.

Michael


