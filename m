Return-Path: <bpf+bounces-31853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BD590416D
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 18:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE9128244F
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2B540861;
	Tue, 11 Jun 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LJX1wZ8y"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2061.outbound.protection.outlook.com [40.92.42.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA003BB48;
	Tue, 11 Jun 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123681; cv=fail; b=cip9NNt4I0nAbnitEdk8AIFuVhFNe663TqZcAKut21slk0wmkvGjzE6fP/ZHtYbYaR8XZC0npRcGAz/jH5wpsNQ9Vl3LSrNJg6fzmXaWqs35A0kiu+SYWekEX6PWaMtrmsvE9yxNw8O6TTf8PF+BR2XqsZkcLfERyMNsUBcwqDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123681; c=relaxed/simple;
	bh=oTijaUWPUUzSWW7Z7r76Qle+UPBwtKCgq2lMfXbf+Mg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kw7XkxWWpS/PwxepBz9ROy4AU6IXFkgM19qeOlHiUn2SK47F6GD3dnP1OQdVE05QkKHOcqgZx268gz9a5uisaWRtm8R7+QEeXbULb2Yon6dn/rBorY9uXXCzpkQcwoAaTskiRcAlzbf/D0/M4WFz87tsbCfcsEYMTpT+G6t1STA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LJX1wZ8y; arc=fail smtp.client-ip=40.92.42.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UB/Aza6gmFzfHWcUA9k/TBdoRitaXf6CEKG0R6uWdCD0ZVPdyRey6nFGu2DVmS9AUrvWtIIdwTLyupuO9/23iaM8kRkRxaXWv4wS464CccRpAl3J6pwP5Yx9B3RWkVZ5MFFTiGdv6t7BJ9Pw139+++ktmGAH1Gq79DqCzml6UuuFwKuLizha6EETTwxIiWGcn4sWqadDJeBhEmf7BMdXqfR7tkmNg0xqI3FN/6pzVvYoZ3OBOXW5el8L+D/gaVfgrwmK3QCVCWvYfFBq3NgnrbWuQs+tOhpixtuRCnZ6j4MLPcJqhPf+LXisq34f0q4tVzv/dyLxZeoh8CA4vhpomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dks2S6E6q5Dm2hc/3za7KlRL9MBMkm+5vgQ4mIgbHmM=;
 b=bDmZtgcLlqfQoAKYUIBJGhpsRrcYcnrgaXkDnNvl2hjM9MsRCJcrARCGKBbR4ERkX0rx3yvGdZhNMxI5VStwEw1Ut2dCPTh40qOM5vcfoLWooRjJiUY+8+FhqjuJV1lEL7djExF5LO8OIbEiRiLDomhAZLcblZeiYGOqdIJ0TuSJn0ByRScUGPT9ao/djNa0kyDbJ6Zag6XMEpxx2sqLpanqstSxTKsGhrDzWmAMt+bNkzRWgtbAYCk/fU2JBN4DxFhXHPwqczCbAMKUu0XTFKkYLpFiFf8tEb9GeZQhYqI+UlMFzitKbAdHOU+OVpquHz89r//EuXbheoyTc0iIgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dks2S6E6q5Dm2hc/3za7KlRL9MBMkm+5vgQ4mIgbHmM=;
 b=LJX1wZ8ybRZSIMYV+ahzzlsd0cnUSEvBSKm4Ca/WAeCuEJyEzQpFBvwf5+G7sz1/a5eqVxhTKa/vfY7xyK5k/LjwBabaiIvbJ9+DFXxgx4Gi1A+jTTHtxJtJ0UFfmVi7dgpTnWnWEnfhJwqpPMpPkC77MyCNytbG2+gihOd20w1zcAEkJ+iUgl5jSQi8mP7ryuTpShoNc9ITB3clmLwLC8G4GYRe2pm/50E/THfFAMjAWTtfa70frJ4N9OlPYeFs8OeGmRlnS7QT2ffd8iIZ7OwJuIPAXCnhFKBO9JKsM2GcXYU6MMZV3+fhnUtAWWSvtsP6IBaxND2W802RKQ34bw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8546.namprd02.prod.outlook.com (2603:10b6:a03:3fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:34:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 16:34:36 +0000
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
Subject: RE: [PATCH net-next] net: mana: Add support for variable page sizes
 of ARM64
Thread-Topic: [PATCH net-next] net: mana: Add support for variable page sizes
 of ARM64
Thread-Index: AQHau3yTy3MTSCK18E+o6KIehToY2rHCttmA
Date: Tue, 11 Jun 2024 16:34:36 +0000
Message-ID:
 <SN6PR02MB41572E928DCF6B7FDF89899DD4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1718054553-6588-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1718054553-6588-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [hN8y+YiMDfkuSiy19G5HwS39pmPE03PV]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8546:EE_
x-ms-office365-filtering-correlation-id: 42af33a5-c6b3-481a-30d6-08dc8a3461c9
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199020|3412199017|102099026|440099020;
x-microsoft-antispam-message-info:
 Ivmy2TBW0tLl+qVscpnSPiq/oJsoOBODE7EpwtZdokPaD670TZmD8wB6rZSQYnUYnyqR/lYRbiM4vkuGLEheeZxQj8jhZyMxoSUVWhWwtV3wo9cM5+Mb2O1ta0R6dySVqhulmETy+4PydEjDDxY59GEZOcSPfxIb6TBwt80w80uQGKNFmzpdPmIK0/yPBUKn+nVSIyoR203RD+gdCKP3Q0gYb7yK3gVf3lGSg32JEwmJUIovb2+wLmSQjhnEH0DE0HHdIpAIlQLTTegLyfMG8q3kAvwtmgW9av74EUpVOBUo1g+wV0y00EfqBxQ9j8Jpjk8/h1S6g0e2s/3PSSe/nNzgXJbQq7+G0A/9hHuQ08TWdETaTpElqF1KcPzfw3udRa+bgYyzGOn+T1D9htd+mbQ1p2yJEyJ5Ef5OcY9M2Kjegv0+WqvoznAcyuzJrUfEJvIsn661QcOn3F4V5JZWHDv71zR4dCMQnPy1K6iHv35pZcNKVZg9aKe05VviuX5+K3Qq81AL8B934ofI90iBtJwFJZmL0hLUp0+uufPwMc1nuAxVLunBgvLdh8+CdVn9
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fK9QHKezLl9OugGb9+A/IpIq8m0MEslqKuf81CI+7X2hVKCnow3ltDHuYVTq?=
 =?us-ascii?Q?wyCdXDe4yJTV9ovEkz6OXnXS2ZBb0WjIfMFi/Xv98LQgujpnz/1PHrgDH3kf?=
 =?us-ascii?Q?LqCb5oX1GsN3AaRdpTiKlxSHOjbGhGnOGCpBOxV4rPTuGrXWUB+0edTzqdfw?=
 =?us-ascii?Q?lLfrYa0pLu4x7+sk9wEzIF6nUj4pcdG7U5biKW6ZV0zCIspXHddWDQ63f2Ox?=
 =?us-ascii?Q?wls6F0ibidtFXOoKQwhNLPYNmjkV/Ptcx6SQQUTpHyJf/hfbpuZf9t4FQlYR?=
 =?us-ascii?Q?n/Mfpr558XtkG9kZpX1erOuLDGOLUbTiYnj6MuF7XEgavXK3S4U/8C7sTNl4?=
 =?us-ascii?Q?udSbcCizaOinzXaikOxN6ry6Buf6C2GeAl57w77V22HA4BWgx2JBZheYhEvx?=
 =?us-ascii?Q?wpWvscJQPmpmHAh0cTOAmsAATtM+NoZZCRwVnpXSZWOXpI7dX5IWbyIlNRaN?=
 =?us-ascii?Q?xOxm+P7pP8cy/Zac9Jn9dXE3zXLavhAXrTfl27kM969wm1ZBiWlT843Th+2k?=
 =?us-ascii?Q?pqXWOsqnRMhmuXTVHjqMST5/xy8fMajTx1STVMA4ddnmCjnjOrryduAt6W5f?=
 =?us-ascii?Q?KA3S/v/H631K4gga2Kbu0ObO/EcNCVDG/pqCvq/9DpHgJIYx/mQ74DmTKkY5?=
 =?us-ascii?Q?rCkVsRIwGx6lmAlDgfBp5SCXOLo40xzaOzVp8yyER1bvng3D818WIm2ttrgm?=
 =?us-ascii?Q?G+DMgVMipnkDy7fkbcRJ+M2DrpwTfhTFgtKzedlvigz/ESROagB1jDK9BWsP?=
 =?us-ascii?Q?EaXEzGMZKnscAzLjl/cg15ERLBosQ1BtxEoKOEt012Pg/TCNhI5OYfbnvb7P?=
 =?us-ascii?Q?mHKP3r79owuvn9pPVFXSFB90EKGW2blwPu/G1ekzCVBGoFoR+dYstUOBNPlH?=
 =?us-ascii?Q?Sn93VhMXJlZI9oO2OToG4ZFYuRmrzrgYXK3UMaCKJ5vWI5xIDkwaoA9EPxe3?=
 =?us-ascii?Q?86nbzqMGML7//OoAhtgNhWr130x+igNL5tOBtGZDDNBsc033vv0wV5aPngnj?=
 =?us-ascii?Q?rKnKp3jaasyY2+M7j4AlqvZ5mO5QjWOEpo81yEWxHymzPJaXUFbgu7vHKf+W?=
 =?us-ascii?Q?OmDBGXWb8CxmFE2vbpAQ0eC1CRJdcfCleZ/y6Rp1VM1vMnZzzpOOuqWieCtT?=
 =?us-ascii?Q?6UufLZMPjmjFGbqp9yLCrrXy4FPh2nGYwk6dzijEigeBZiDeNFWHp97ZziMz?=
 =?us-ascii?Q?vlu8ckE6/NVl6xWtcykQBcvpueaFaOMUP4R+0nXCJ8KdEOc97ANGTeeyOaM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 42af33a5-c6b3-481a-30d6-08dc8a3461c9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 16:34:36.2822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8546

From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang Sent=
: Monday, June 10, 2024 2:23 PM
>=20
> As defined by the MANA Hardware spec, the queue size for DMA is 4KB
> minimal, and power of 2.

You say the hardware requires 4K "minimal". But the definitions in this
patch hardcode to 4K, as if that's the only choice. Is the hardcoding to
4K a design decision made to simplify the MANA driver?

> To support variable page sizes (4KB, 16KB, 64KB) of ARM64, define

A minor nit, but "variable" page size doesn't seem like quite the right
description -- both here and in the Subject line.  On ARM64, the page size
is a choice among a few fixed options.  Perhaps call it support for "page s=
izes
other than 4K"?

> the minimal queue size as a macro separate from the PAGE_SIZE, which
> we always assumed it to be 4KB before supporting ARM64.
> Also, update the relevant code related to size alignment, DMA region
> calculations, etc.
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/Kconfig        |  2 +-
>  .../net/ethernet/microsoft/mana/gdma_main.c   |  8 +++----
>  .../net/ethernet/microsoft/mana/hw_channel.c  | 22 +++++++++----------
>  drivers/net/ethernet/microsoft/mana/mana_en.c |  8 +++----
>  .../net/ethernet/microsoft/mana/shm_channel.c |  9 ++++----
>  include/net/mana/gdma.h                       |  7 +++++-
>  include/net/mana/mana.h                       |  3 ++-
>  7 files changed, 33 insertions(+), 26 deletions(-)
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
> index 1332db9a08eb..c9df942d0d02 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -182,7 +182,7 @@ int mana_gd_alloc_memory(struct gdma_context *gc,
> unsigned int length,
>  	dma_addr_t dma_handle;
>  	void *buf;
>=20
> -	if (length < PAGE_SIZE || !is_power_of_2(length))
> +	if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
>  		return -EINVAL;
>=20
>  	gmi->dev =3D gc->dev;
> @@ -717,7 +717,7 @@ EXPORT_SYMBOL_NS(mana_gd_destroy_dma_region,
> NET_MANA);
>  static int mana_gd_create_dma_region(struct gdma_dev *gd,
>  				     struct gdma_mem_info *gmi)
>  {
> -	unsigned int num_page =3D gmi->length / PAGE_SIZE;
> +	unsigned int num_page =3D gmi->length / MANA_MIN_QSIZE;

This calculation seems a bit weird when using MANA_MIN_QSIZE. The
number of pages, and the construction of the page_addr_list array
a few lines later, seem unrelated to the concept of a minimum queue
size. Is the right concept really a "mapping chunk", and num_page
would conceptually be "num_chunks", or something like that?  Then
a queue must be at least one chunk in size, but that's derived from the
chunk size, and is not the core concept.

Another approach might be to just call it "MANA_PAGE_SIZE", like
has been done with HV_HYP_PAGE_SIZE.  HV_HYP_PAGE_SIZE exists to
handle exactly the same issue of the guest PAGE_SIZE potentially
being different from the fixed 4K size that must be used in host-guest
communication on Hyper-V.  Same thing here with MANA.

>  	struct gdma_create_dma_region_req *req =3D NULL;
>  	struct gdma_create_dma_region_resp resp =3D {};
>  	struct gdma_context *gc =3D gd->gdma_context;
> @@ -727,7 +727,7 @@ static int mana_gd_create_dma_region(struct gdma_dev =
*gd,
>  	int err;
>  	int i;
>=20
> -	if (length < PAGE_SIZE || !is_power_of_2(length))
> +	if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
>  		return -EINVAL;
>=20
>  	if (offset_in_page(gmi->virt_addr) !=3D 0)
> @@ -751,7 +751,7 @@ static int mana_gd_create_dma_region(struct gdma_dev =
*gd,
>  	req->page_addr_list_len =3D num_page;
>=20
>  	for (i =3D 0; i < num_page; i++)
> -		req->page_addr_list[i] =3D gmi->dma_handle +  i * PAGE_SIZE;
> +		req->page_addr_list[i] =3D gmi->dma_handle +  i * MANA_MIN_QSIZE;
>=20
>  	err =3D mana_gd_send_request(gc, req_msg_size, req, sizeof(resp), &resp=
);
>  	if (err)
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index bbc4f9e16c98..038dc31e09cd 100644
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
> +	buf_size =3D MANA_MIN_QALIGN(q_depth * max_msg_size);
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
> @@ -628,10 +628,10 @@ static int mana_hwc_establish_channel(struct
> gdma_context *gc, u16 *q_depth,
>  	init_completion(&hwc->hwc_init_eqe_comp);
>=20
>  	err =3D mana_smc_setup_hwc(&gc->shm_channel, false,
> -				 eq->mem_info.dma_handle,
> -				 cq->mem_info.dma_handle,
> -				 rq->mem_info.dma_handle,
> -				 sq->mem_info.dma_handle,
> +				 virt_to_phys(eq->mem_info.virt_addr),
> +				 virt_to_phys(cq->mem_info.virt_addr),
> +				 virt_to_phys(rq->mem_info.virt_addr),
> +				 virt_to_phys(sq->mem_info.virt_addr),

This change seems unrelated to handling guest PAGE_SIZE values
other than 4K.  Does it belong in a separate patch?  Or maybe it just
needs an explanation in the commit message of this patch?

>  				 eq->eq.msix_index);
>  	if (err)
>  		return err;
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d087cf954f75..6a891dbce686 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1889,10 +1889,10 @@ static int mana_create_txq(struct mana_port_conte=
xt
> *apc,
>  	 *  to prevent overflow.
>  	 */
>  	txq_size =3D MAX_SEND_BUFFERS_PER_QUEUE * 32;
> -	BUILD_BUG_ON(!PAGE_ALIGNED(txq_size));
> +	BUILD_BUG_ON(!MANA_MIN_QALIGNED(txq_size));
>=20
>  	cq_size =3D MAX_SEND_BUFFERS_PER_QUEUE * COMP_ENTRY_SIZE;
> -	cq_size =3D PAGE_ALIGN(cq_size);
> +	cq_size =3D MANA_MIN_QALIGN(cq_size);
>=20
>  	gc =3D gd->gdma_context;
>=20
> @@ -2189,8 +2189,8 @@ static struct mana_rxq *mana_create_rxq(struct
> mana_port_context *apc,
>  	if (err)
>  		goto out;
>=20
> -	rq_size =3D PAGE_ALIGN(rq_size);
> -	cq_size =3D PAGE_ALIGN(cq_size);
> +	rq_size =3D MANA_MIN_QALIGN(rq_size);
> +	cq_size =3D MANA_MIN_QALIGN(cq_size);
>=20
>  	/* Create RQ */
>  	memset(&spec, 0, sizeof(spec));
> diff --git a/drivers/net/ethernet/microsoft/mana/shm_channel.c
> b/drivers/net/ethernet/microsoft/mana/shm_channel.c
> index 5553af9c8085..9a54a163d8d1 100644
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

In mana_smc_setup_hwc() a few lines above this change, code using
PAGE_ALIGNED() is unchanged.  Is it correct that the eq/cq/rq/sq addresses
must be aligned to 64K if PAGE_SIZE is 64K?

Related, I wonder about how MANA_PFN() is defined. If PAGE_SIZE is 64K,
MANA_PFN() will first right-shift 16, then left shift 4. The net is right-s=
hift 12,
corresponding to the 4K chunks that MANA expects. But that approach guarant=
ees
that the rightmost 4 bits of the MANA PFN will always be zero. That's consi=
stent
with requiring the addresses to be PAGE_ALIGNED() to 64K, but I'm unclear w=
hether
that is really the requirement. You might compare with the definition of
HVPFN_DOWN(), which has a similar goal for Linux guests communicating with
Hyper-V.

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
> index 27684135bb4d..b392559c33e9 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -224,7 +224,12 @@ struct gdma_dev {
>  	struct auxiliary_device *adev;
>  };
>=20
> -#define MINIMUM_SUPPORTED_PAGE_SIZE PAGE_SIZE
> +/* These are defined by HW */
> +#define MANA_MIN_QSHIFT 12
> +#define MANA_MIN_QSIZE (1 << MANA_MIN_QSHIFT)
> +#define MANA_MIN_QALIGN(x) ALIGN((x), MANA_MIN_QSIZE)
> +#define MANA_MIN_QALIGNED(addr) IS_ALIGNED((unsigned long)(addr), MANA_M=
IN_QSIZE)
> +#define MANA_PFN(a) (PHYS_PFN(a) << (PAGE_SHIFT - MANA_MIN_QSHIFT))

See comments above about how this is defined.

Michael

>=20
>  #define GDMA_CQE_SIZE 64
>  #define GDMA_EQE_SIZE 16
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 561f6719fb4e..43e8fc574354 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -42,7 +42,8 @@ enum TRI_STATE {
>=20
>  #define MAX_SEND_BUFFERS_PER_QUEUE 256
>=20
> -#define EQ_SIZE (8 * PAGE_SIZE)
> +#define EQ_SIZE (8 * MANA_MIN_QSIZE)
> +
>  #define LOG2_EQ_THROTTLE 3
>=20
>  #define MAX_PORTS_IN_MANA_DEV 256
> --
> 2.34.1
>=20


