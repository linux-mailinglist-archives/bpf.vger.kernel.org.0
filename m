Return-Path: <bpf+bounces-31902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9530C904926
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 04:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7F21F24539
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 02:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BEBF4FA;
	Wed, 12 Jun 2024 02:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="C8NAj7QF"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2047.outbound.protection.outlook.com [40.92.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC60B663;
	Wed, 12 Jun 2024 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718160130; cv=fail; b=GOhWkT8+AmBNaOlLX1+AkOGbgXHMrzzlIsnhCkqXWQv1VMkutDJziJ0WQl79qbiOzEApigT1nT6sV6opzgD1gSCkFMpLvmuqioP47MQUnYZKFd1eWpf7wzqFDQx9lGm6JWj6uZBujLJs+rRY9iiibKj5KGVy2n0hdTWeN2GeZxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718160130; c=relaxed/simple;
	bh=hIyM3zQu5esR6g/MhKmTkTeSR7shtjj+yytprlzD6zw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oKFaTSBxFQURXUYJXD2IbTpLhyU4pVQM6pmzii7qtx6i7hgPnjml9iD1GvT422nBCTEpsqNoMyJ0VKPILU1Y8CJ0GNrCqFz4g0vw9HSNVH9hlun2dxmS21N1kI99euJyJoo+9rGo9HUIZi0Gri/loJLHcdn1VfhNfs9ZJN96Apg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=C8NAj7QF; arc=fail smtp.client-ip=40.92.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFeyr91B3NjLAYML3ad0m3cN9ify7itOGR26TnKV4JJI5PgMOVg3j2+lZVcOnHgh1t9EphFMt+JiuqkQBkKWIOVHetHKoIvXGfrtF5sO+3ynaPHo646oM80J3R/BQnjS0IuB7NTqkwMdGy2JFXGR+FJDU8wGGfRheHTYyNo2LHP6kOSEPQyltujEf4D9LTcQKddLxJKCLb9bjyoT2E/OXiyvehSt4fCQi9A4n8HiGWSlyKiISfPh5twCyJJT5OQd7lMkGxnrdatzCvXq6c4XCWvVSOuLGdk2GkJLcHV/DJcjEugpt7wUlag1C49Unq6jHm2dvT+WEvjqTFH3eBXMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvP83TA+VmOuyLpJUQs2V2PpTNbmT0mMILqzi0eWOMc=;
 b=jPbbMOnsCHA8iTuNE3EMjVFn/gbeywMWalXWd1+7Oiy03yfft17AV13rN0P6snDmKlc9LFhHv7DotIEbmPBijuuSSeJMQTRLL29TiXcuEe4qPmbdQimUb4D4KVsazkIEnIRqqQCDW7zZ68mHVC4k+37+5GUpZKPrIolzvEfE/7SQ2Y1Vbb+XDTGLH1/DU4TbZkAwtGLGs/JGvHQqWymkU1PsIUKE+90KkDzaK2ikYKYTlrFPfsNRBoDUuhPdM5Xry0/z41ROfu4GKIIT+HndO847TM8L5nyyIVcUQmhrBMmwMp6apNsEz+B5ABOkXvtsj+q7Spr/ovHFeksvCINKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvP83TA+VmOuyLpJUQs2V2PpTNbmT0mMILqzi0eWOMc=;
 b=C8NAj7QFIDxwYieNgvwgkTP6QnyBB2rv1pPS6vyzsl+/5cgMIZAYvpNUo9p2eef0tr/CVVjg8l7PaNoTG6UuLOuNMNusBlo83uJ/2s5owMduL8gDdVhuyLipByC39UOoJqOq2DtCNuL2Z69toSrCorKKNZwo7tshRi5rrXIso2TicCNL3vvtdUi+G6exxAI8J+EmIo3jP/TeH2whNeIJznxtUztxDDERywe1l4UCaOrKzPtaYaHTn3OuN0f5B6iPzTURJjgk9m+B81jlz8kpudH0QqIQKlj2KaRLeeCTmoiOQClm2yY7DsNsYb4TSmqGiYKxSKtqaMZLpwe94Sc0gw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6485.namprd02.prod.outlook.com (2603:10b6:a03:1d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 02:42:03 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 02:42:03 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>,
	"olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: mana: Add support for variable page sizes
 of ARM64
Thread-Topic: [PATCH net-next] net: mana: Add support for variable page sizes
 of ARM64
Thread-Index: AQHau3yTy3MTSCK18E+o6KIehToY2rHCttmAgAAb84CAAAP6gIAAj8ZA
Date: Wed, 12 Jun 2024 02:42:03 +0000
Message-ID:
 <SN6PR02MB415781A68B43463F34A884E2D4C02@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1718054553-6588-1-git-send-email-haiyangz@microsoft.com>
 <SN6PR02MB41572E928DCF6B7FDF89899DD4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
 <DM6PR21MB14818F4519381967A9FEE8B8CAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
 <DM6PR21MB1481E3F4E4E26765CCF6114DCAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
In-Reply-To:
 <DM6PR21MB1481E3F4E4E26765CCF6114DCAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3fb4882b-67e9-4568-8c78-027b60b1813e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-11T16:45:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-tmn: [PTGGn2h3fcdNigf1HCQuH4RyMY2zP6CT]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6485:EE_
x-ms-office365-filtering-correlation-id: 6545f9e1-ccb9-459e-f7bf-08dc8a893de9
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199020|3412199017|102099026|440099020;
x-microsoft-antispam-message-info:
 E2sLHUm5KjPb4In7QKGwTQSY1skc8yUQywP80J2/UobUlXD3SHtgIiCah9670niXpmhB/T8gaNF30+oyRZabD5M3iBH2FiWCdKTE+0U7/+mjs4z6BZrMcK/eSMb0CJncu2PjrxhW13qeWLMsyIyU1RjRWsp3TvaSmVoLbu7i7UWubJZlXncnut9k8cEz8kt+f6qXRZDUebodvbvSmlE7atzFNZ1XUrX4+SOS/EATRPFFfgiNiFynCJsFLADcdE4LUW9aOk+UuMIhS1mpKYko6J2/wlF6xkwv0VGNxnK1f1qhwehFE96skkPSHyQvbp4f+ZcnALV3k9OARJQXjJNNuJyEvx/dv4l1dJYqgJmTh7weW635TW1sU7cLz5RrXD5wE90vRKYQhcKYF6g8BPxmAZnity8VRRZYX5kcBBjDDo7d6V4/AdG3lEiZapPRN/BqdiEZmq39cIhMG/9vTBfuEfyttruCwoejoiU3M1pbzG5Ae4fwRkLrWMXFjZLyAkO9ncwF2Rlfmif4506Qj8eDKlA48ZdZr8XNLQB+ql3z2yjDB+IDTZX0ECBsx3C3KG2d
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9aYYqp2pL4UfBLpLKuVV78aAp/mQxesNgnzZS/+vVjbuYyKzupR49uyVto?=
 =?iso-8859-1?Q?v7E2BUOFypmUx9xe0ol+c8PffT/BYTY7DeRbjKnVoSYUnT/0K8qFwTjC/g?=
 =?iso-8859-1?Q?lQTB9dfhbaghXcnmRYIoPa8QPaFzJatRxBxD5hBbUv1ZyRVEXixcYQtETk?=
 =?iso-8859-1?Q?8OsPSMvgpo5vjnzM2klrOM5Z1l0yqz5PUp89uflfXh/vBpczcEyuMZLzpC?=
 =?iso-8859-1?Q?RZRn62tFOZebF9Rq3Qx80rqSPu8ulbckB5BUO0MkFdFL1Ea4ILDhymnn/n?=
 =?iso-8859-1?Q?Bh3jfbTHQFlUDLUXI8l3FRgveB6V8opQkVVFJGGFDA2n+Gf4J3Xt5sRZNZ?=
 =?iso-8859-1?Q?OH+zFvy35Yur0r2jhTlWMa+tX3AoLNLJyRlc/sNoCCoUgq8BTcwmIAbERR?=
 =?iso-8859-1?Q?w/y/xzYYmr8pQYSS9/DPN8hHvVKxSpoM+zNDWgwiDEsfLtfJ7JYPXxMs/z?=
 =?iso-8859-1?Q?KEmfKyHsESdShD1T9S3qlG6Vk36a+6j8oEC8xmbTIK/ssRwd4AaN6l4Hoe?=
 =?iso-8859-1?Q?Fwl9Sj2Bd0JeWTaN2Tci7Lkguvyp+dOGl+HoqhQY1XAvATVfOyhhIv8CBu?=
 =?iso-8859-1?Q?tT9XpXEbcumAJ6GT8hY1sgvIcgzr5W+rjvVreNkZ0FAjFGD9QiZm9jugsq?=
 =?iso-8859-1?Q?3vEUJUehJEyiaNObqR4G++ueOoq4bIMTZ07cURX1jKZh3bCOeGLfkbxVIG?=
 =?iso-8859-1?Q?CXoifCAMvCB7i3bfvS7sPzxVGpe9lcYXrkEZ4+zElZ5SKFEDgivR6i1K0n?=
 =?iso-8859-1?Q?IFMEHwoGGw8NroXGnw3gSA8ZMyHfwabap7rpKMTPeDH4wKHpJcMbaGWfew?=
 =?iso-8859-1?Q?CM433UQ3RnwVCdFtEyGjrjFXxNVD+y6Lp//hXwmJ/FnzVez+QTpnx7k0XB?=
 =?iso-8859-1?Q?IDy3We5/+TQWoQrW5xY/pfIIBEz+s68qrU1rJuV3Gad4SAC6my4+nqVccO?=
 =?iso-8859-1?Q?ZNUAnyFhnVWetjJlqkcgTFUZCUJEstyQGO8BtjhIPZrRRzityT+2KljvRT?=
 =?iso-8859-1?Q?G5KQR2u67cPOJeI0hahQd8nOkCaCbSTZgvRaDQmF+RUETpFeZd3danc1gJ?=
 =?iso-8859-1?Q?DUp3rl1U60A7bIADt0Tv+GFNXsJvYINyZHsgl8fxy33sqa6ciT1UqqZgoD?=
 =?iso-8859-1?Q?nGD0/VqQ/9zquBzUQXXIAVGIlBAULchsvwFKOp1Dw9gSXEGMTL9HvzpcWh?=
 =?iso-8859-1?Q?ffkIliJZH8OtbNtyIGjyVmSd7lDKcuq5ud8F9R2HWur/RbE6zAy+kmc2Vk?=
 =?iso-8859-1?Q?usV6vi4Yh2Wfs9/VQKbuh38n/yGNPDyQT1Q3KcuSI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6545f9e1-ccb9-459e-f7bf-08dc8a893de9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 02:42:03.3245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6485

From: Haiyang Zhang <haiyangz@microsoft.com> Sent: Tuesday, June 11, 2024 1=
0:44 AM
>=20
> > -----Original Message-----
> > From: Michael Kelley <mailto:mhklinux@outlook.com>
> > Sent: Tuesday, June 11, 2024 12:35 PM
> > To: Haiyang Zhang <mailto:haiyangz@microsoft.com>; mailto:linux-hyperv@=
vger.kernel.org;
> > mailto:netdev@vger.kernel.org
> > Cc: Dexuan Cui <mailto:decui@microsoft.com>; mailto:stephen@networkplum=
ber.org; KY
> > Srinivasan <mailto:kys@microsoft.com>; Paul Rosswurm <mailto:paulros@mi=
crosoft.com>;
> > mailto:olaf@aepfle.de; vkuznets <mailto:vkuznets@redhat.com>; mailto:da=
vem@davemloft.net;
> > mailto:wei.liu@kernel.org; mailto:edumazet@google.com; mailto:kuba@kern=
el.org;
> > mailto:pabeni@redhat.com; mailto:leon@kernel.org; Long Li <mailto:longl=
i@microsoft.com>;
> > mailto:ssengar@linux.microsoft.com; mailto:linux-rdma@vger.kernel.org;
> > mailto:daniel@iogearbox.net; mailto:john.fastabend@gmail.com; mailto:bp=
f@vger.kernel.org;
> > mailto:ast@kernel.org; mailto:hawk@kernel.org; mailto:tglx@linutronix.d=
e;
> > mailto:shradhagupta@linux.microsoft.com; mailto:linux-kernel@vger.kerne=
l.org
> > Subject: RE: [PATCH net-next] net: mana: Add support for variable page
> > sizes of ARM64
> >
> > From: LKML haiyangz <mailto:lkmlhyz@microsoft.com> On Behalf Of Haiyang=
 Zhang
> > Sent: Monday, June 10, 2024 2:23 PM
> > >
> > > As defined by the MANA Hardware spec, the queue size for DMA is 4KB
> > > minimal, and power of 2.
> >
> > You say the hardware requires 4K "minimal". But the definitions in this
> > patch hardcode to 4K, as if that's the only choice. Is the hardcoding t=
o
> > 4K a design decision made to simplify the MANA driver?
>=20
> The HWC q size has to be exactly 4k, which is by HW design.
> Other "regular" queues can be 2^n >=3D 4k.
>=20
> >
> > > To support variable page sizes (4KB, 16KB, 64KB) of ARM64, define
> >
> > A minor nit, but "variable" page size doesn't seem like quite the right
> > description -- both here and in the Subject line.=A0 On ARM64, the page=
 size
> > is a choice among a few fixed options.=A0 Perhaps call it support for "=
page sizes
> > other than 4K"?
>=20
> "page sizes other than 4K" sounds good.
>=20
> >
> > > the minimal queue size as a macro separate from the PAGE_SIZE, which
> > > we always assumed it to be 4KB before supporting ARM64.
> > > Also, update the relevant code related to size alignment, DMA region
> > > calculations, etc.
> > >
> > > Signed-off-by: Haiyang Zhang <mailto:haiyangz@microsoft.com>
> > > ---
> > >=A0 drivers/net/ethernet/microsoft/Kconfig=A0=A0=A0=A0=A0=A0=A0 |=A0 2=
 +-
> > >=A0 .../net/ethernet/microsoft/mana/gdma_main.c=A0=A0 |=A0 8 +++----
> > >=A0 .../net/ethernet/microsoft/mana/hw_channel.c=A0 | 22 +++++++++----=
------
> > >=A0 drivers/net/ethernet/microsoft/mana/mana_en.c |=A0 8 +++----
> > >=A0 .../net/ethernet/microsoft/mana/shm_channel.c |=A0 9 ++++----
> > >=A0 include/net/mana/gdma.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 7 +++++-
> > >=A0 include/net/mana/mana.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 3 ++-
> > >=A0 7 files changed, 33 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/microsoft/Kconfig
> > > b/drivers/net/ethernet/microsoft/Kconfig
> > > index 286f0d5697a1..901fbffbf718 100644
> > > --- a/drivers/net/ethernet/microsoft/Kconfig
> > > +++ b/drivers/net/ethernet/microsoft/Kconfig
> > > @@ -18,7 +18,7 @@ if NET_VENDOR_MICROSOFT
> > >=A0 config MICROSOFT_MANA
> > >=A0 tristate "Microsoft Azure Network Adapter (MANA) support"
> > >=A0 depends on PCI_MSI
> > > - depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN && ARM64_4K_PAGES)
> > > + depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN)
> > >=A0 depends on PCI_HYPERV
> > >=A0 select AUXILIARY_BUS
> > >=A0 select PAGE_POOL
> > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > index 1332db9a08eb..c9df942d0d02 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > @@ -182,7 +182,7 @@ int mana_gd_alloc_memory(struct gdma_context *gc,
> > > unsigned int length,
> > >=A0 dma_addr_t dma_handle;
> > >=A0 void *buf;
> > >
> > > - if (length < PAGE_SIZE || !is_power_of_2(length))
> > > + if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
> > >=A0 =A0=A0=A0=A0=A0=A0 return -EINVAL;
> > >
> > >=A0 gmi->dev =3D gc->dev;
> > > @@ -717,7 +717,7 @@ EXPORT_SYMBOL_NS(mana_gd_destroy_dma_region, NET_=
MANA);
> > >=A0 static int mana_gd_create_dma_region(struct gdma_dev *gd,
> > >=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=
=A0=A0struct gdma_mem_info *gmi)
> > >=A0 {
> > > - unsigned int num_page =3D gmi->length / PAGE_SIZE;
> > > + unsigned int num_page =3D gmi->length / MANA_MIN_QSIZE;
> >
> > This calculation seems a bit weird when using MANA_MIN_QSIZE. The
> > number of pages, and the construction of the page_addr_list array
> > a few lines later, seem unrelated to the concept of a minimum queue
> > size. Is the right concept really a "mapping chunk", and num_page
> > would conceptually be "num_chunks", or something like that?=A0 Then
> > a queue must be at least one chunk in size, but that's derived from the
> > chunk size, and is not the core concept.
>=20
> I think calling it "num_chunks" is fine.
> May I use "num_chunks" in next version?
>=20

I think first is the decision on what to use for MANA_MIN_QSIZE. I'm
admittedly not familiar with mana and gdma, but the function
mana_gd_create_dma_region() seems fairly typical in defining a
logical region that spans multiple 4K chunks that may or may not
be physically contiguous.  So you set up an array of physical
addresses that identify the physical memory location of each chunk.
It seems very similar to a Hyper-V GPADL. I typically *do* see such
chunks called "pages", but a "mapping chunk" or "mapping unit"
is probably OK too.  So mana_gd_create_dma_region() would use
MANA_CHUNK_SIZE instead of MANA_MIN_QSIZE.  Then you could
also define MANA_MIN_QSIZE to be MANA_CHUNK_SIZE, for use
specifically when checking the size of a queue.

Then if you are using MANA_CHUNK_SIZE, the local variable
would be "num_chunks".  The use of "page_count", "page_addr_list",
and "offset_in_page" field names in struct
gdma_create_dma_region_req should then be changed as well.

Looking further at the function mana_gd_create_dma_region(),
there's also the use of offset_in_page(), which is based on the
guest PAGE_SIZE.  Wouldn't this be problematic if PAGE_SIZE
is 64K?

But perhaps Paul would weigh in further on his thoughts.

> >
> > Another approach might be to just call it "MANA_PAGE_SIZE", like
> > has been done with HV_HYP_PAGE_SIZE.=A0 HV_HYP_PAGE_SIZE exists to
> > handle exactly the same issue of the guest PAGE_SIZE potentially
> > being different from the fixed 4K size that must be used in host-guest
> > communication on Hyper-V.=A0 Same thing here with MANA.
>=20
> I actually called it "MANA_PAGE_SIZE" in my previous internal patch.
> But Paul from Hostnet team opposed using that name, because
> 4kB is the min q size. MANA doesn't have "page" at HW level.
>=20
>=20
> > >=A0 struct gdma_create_dma_region_req *req =3D NULL;
> > >=A0 struct gdma_create_dma_region_resp resp =3D {};
> > >=A0 struct gdma_context *gc =3D gd->gdma_context;
> > > @@ -727,7 +727,7 @@ static int mana_gd_create_dma_region(struct gdma_=
dev *gd,
> > >=A0 int err;
> > >=A0 int i;
> > >
> > > - if (length < PAGE_SIZE || !is_power_of_2(length))
> > > + if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
> > >=A0 =A0=A0=A0=A0=A0=A0 return -EINVAL;
> > >
> > >=A0 if (offset_in_page(gmi->virt_addr) !=3D 0)
> > > @@ -751,7 +751,7 @@ static int mana_gd_create_dma_region(struct gdma_=
dev *gd,
> > >=A0 req->page_addr_list_len =3D num_page;
> > >
> > >=A0 for (i =3D 0; i < num_page; i++)
> > > -=A0=A0=A0=A0=A0=A0 req->page_addr_list[i] =3D gmi->dma_handle +=A0 i=
 * PAGE_SIZE;
> > > +=A0=A0=A0=A0=A0=A0 req->page_addr_list[i] =3D gmi->dma_handle +=A0 i=
 * MANA_MIN_QSIZE;
> > >
> > >=A0 err =3D mana_gd_send_request(gc, req_msg_size, req, sizeof(resp), =
&resp);
> > >=A0 if (err)
> > > diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > > b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > > index bbc4f9e16c98..038dc31e09cd 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > > @@ -362,12 +362,12 @@ static int mana_hwc_create_cq(struct hw_channel=
_context
> > > *hwc, u16 q_depth,
> > >=A0 int err;
> > >
> > >=A0 eq_size =3D roundup_pow_of_two(GDMA_EQE_SIZE * q_depth);
> > > - if (eq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
> > > -=A0=A0=A0=A0=A0=A0 eq_size =3D MINIMUM_SUPPORTED_PAGE_SIZE;
> > > + if (eq_size < MANA_MIN_QSIZE)
> > > +=A0=A0=A0=A0=A0=A0 eq_size =3D MANA_MIN_QSIZE;
> > >
> > >=A0 cq_size =3D roundup_pow_of_two(GDMA_CQE_SIZE * q_depth);
> > > - if (cq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
> > > -=A0=A0=A0=A0=A0=A0 cq_size =3D MINIMUM_SUPPORTED_PAGE_SIZE;
> > > + if (cq_size < MANA_MIN_QSIZE)
> > > +=A0=A0=A0=A0=A0=A0 cq_size =3D MANA_MIN_QSIZE;
> > >
> > >=A0 hwc_cq =3D kzalloc(sizeof(*hwc_cq), GFP_KERNEL);
> > >=A0 if (!hwc_cq)
> > > @@ -429,7 +429,7 @@ static int mana_hwc_alloc_dma_buf(struct hw_chann=
el_context *hwc, u16 q_depth,
> > >
> > >=A0 dma_buf->num_reqs =3D q_depth;
> > >
> > > - buf_size =3D PAGE_ALIGN(q_depth * max_msg_size);
> > > + buf_size =3D MANA_MIN_QALIGN(q_depth * max_msg_size);
> > >
> > >=A0 gmi =3D &dma_buf->mem_info;
> > >=A0 err =3D mana_gd_alloc_memory(gc, buf_size, gmi);
> > > @@ -497,8 +497,8 @@ static int mana_hwc_create_wq(struct hw_channel_c=
ontext
> > > *hwc,
> > >=A0 else
> > >=A0 =A0=A0=A0=A0=A0=A0 queue_size =3D roundup_pow_of_two(GDMA_MAX_SQE_=
SIZE * q_depth);
> > >
> > > - if (queue_size < MINIMUM_SUPPORTED_PAGE_SIZE)
> > > -=A0=A0=A0=A0=A0=A0 queue_size =3D MINIMUM_SUPPORTED_PAGE_SIZE;
> > > + if (queue_size < MANA_MIN_QSIZE)
> > > +=A0=A0=A0=A0=A0=A0 queue_size =3D MANA_MIN_QSIZE;
> > >
> > >=A0 hwc_wq =3D kzalloc(sizeof(*hwc_wq), GFP_KERNEL);
> > >=A0 if (!hwc_wq)
> > > @@ -628,10 +628,10 @@ static int mana_hwc_establish_channel(struct
> > > gdma_context *gc, u16 *q_depth,
> > >=A0 init_completion(&hwc->hwc_init_eqe_comp);
> > >
> > >=A0 err =3D mana_smc_setup_hwc(&gc->shm_channel, false,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 eq->mem_info.=
dma_handle,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cq->mem_info.=
dma_handle,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rq->mem_info.=
dma_handle,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sq->mem_info.=
dma_handle,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virt_to_phys(=
eq->mem_info.virt_addr),
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virt_to_phys(=
cq->mem_info.virt_addr),
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virt_to_phys(=
rq->mem_info.virt_addr),
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virt_to_phys(=
sq->mem_info.virt_addr),
> >
> > This change seems unrelated to handling guest PAGE_SIZE values
> > other than 4K.=A0 Does it belong in a separate patch?=A0 Or maybe it ju=
st
> > needs an explanation in the commit message of this patch?
>=20
> I know dma_handle is usually just the phys adr. But this is not always
> True if IOMMU is used...
> I have no problem to put it to a separate patch if desired.

Yes, that would seem like a separate patch.  It's not related to handling
page size other than 4K.

>=20
> >
> > >=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0eq->eq.m=
six_index);
> > >=A0 if (err)
> > >=A0 =A0=A0=A0=A0=A0=A0 return err;
> > > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > index d087cf954f75..6a891dbce686 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > @@ -1889,10 +1889,10 @@ static int mana_create_txq(struct mana_port_c=
ontext
> > > *apc,
> > >=A0 =A0*=A0 to prevent overflow.
> > >=A0 =A0*/
> > >=A0 txq_size =3D MAX_SEND_BUFFERS_PER_QUEUE * 32;
> > > - BUILD_BUG_ON(!PAGE_ALIGNED(txq_size));
> > > + BUILD_BUG_ON(!MANA_MIN_QALIGNED(txq_size));
> > >
> > >=A0 cq_size =3D MAX_SEND_BUFFERS_PER_QUEUE * COMP_ENTRY_SIZE;
> > > - cq_size =3D PAGE_ALIGN(cq_size);
> > > + cq_size =3D MANA_MIN_QALIGN(cq_size);
> > >
> > >=A0 gc =3D gd->gdma_context;
> > >
> > > @@ -2189,8 +2189,8 @@ static struct mana_rxq *mana_create_rxq(struct =
mana_port_context *apc,
> > >=A0 if (err)
> > >=A0 =A0=A0=A0=A0=A0=A0 goto out;
> > >
> > > - rq_size =3D PAGE_ALIGN(rq_size);
> > > - cq_size =3D PAGE_ALIGN(cq_size);
> > > + rq_size =3D MANA_MIN_QALIGN(rq_size);
> > > + cq_size =3D MANA_MIN_QALIGN(cq_size);
> > >
> > >=A0 /* Create RQ */
> > >=A0 memset(&spec, 0, sizeof(spec));
> > > diff --git a/drivers/net/ethernet/microsoft/mana/shm_channel.c
> > > b/drivers/net/ethernet/microsoft/mana/shm_channel.c
> > > index 5553af9c8085..9a54a163d8d1 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/shm_channel.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/shm_channel.c
> > > @@ -6,6 +6,7 @@
> > >=A0 #include <linux/io.h>
> > >=A0 #include <linux/mm.h>
> > >
> > > +#include <net/mana/gdma.h>
> > >=A0 #include <net/mana/shm_channel.h>
> > >
> > >=A0 #define PAGE_FRAME_L48_WIDTH_BYTES 6
> > > @@ -183,7 +184,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bo=
ol reset_vf, u64 eq_addr,
> > >
> > >=A0 /* EQ addr: low 48 bits of frame address */
> > >=A0 shmem =3D (u64 *)ptr;
> > > - frame_addr =3D PHYS_PFN(eq_addr);
> > > + frame_addr =3D MANA_PFN(eq_addr);
> > >=A0 *shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
> > >=A0 all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
> > >=A0 =A0=A0=A0=A0=A0=A0 (frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> >
> > In mana_smc_setup_hwc() a few lines above this change, code using
> > PAGE_ALIGNED() is unchanged.=A0 Is it correct that the eq/cq/rq/sq
> > addresses
> > must be aligned to 64K if PAGE_SIZE is 64K?
>=20
> Since we still using PHYS_PFN on them, if not aligned to PAGE_SIZE,
> the lower bits may be lost. (You said the same below.)
>=20
> >
> > Related, I wonder about how MANA_PFN() is defined. If PAGE_SIZE is 64K,
> > MANA_PFN() will first right-shift 16, then left shift 4. The net is
> > right-shift 12,
> > corresponding to the 4K chunks that MANA expects. But that approach
> > guarantees
> > that the rightmost 4 bits of the MANA PFN will always be zero. That's
> > consistent
> > with requiring the addresses to be PAGE_ALIGNED() to 64K, but I'm uncle=
ar
> > whether
> > that is really the requirement. You might compare with the definition o=
f
> > HVPFN_DOWN(), which has a similar goal for Linux guests communicating
> > with
> > Hyper-V.
>=20
> @Paul Rosswurm You said MANA HW has "no page concept". So the "frame_addr=
"
> In the mana_smc_setup_hwc() is NOT related to physical page number, corre=
ct?
> Can we just use phys_adr >> 12 like below?
>=20
> #define MANA_MIN_QSHIFT 12
> #define MANA_PFN(a) ((a) >> MANA_MIN_QSHIFT)
>=20
> =A0=A0=A0=A0=A0 /* EQ addr: low 48 bits of frame address */
> =A0=A0=A0=A0 shmem =3D (u64 *)ptr;
> -=A0=A0=A0=A0 frame_addr =3D PHYS_PFN(eq_addr);
> +=A0=A0=A0=A0 frame_addr =3D MANA_PFN(eq_addr);
>=20
> >
> > > @@ -191,7 +192,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bo=
ol
> > > reset_vf, u64 eq_addr,
> > >
> > >=A0 /* CQ addr: low 48 bits of frame address */
> > >=A0 shmem =3D (u64 *)ptr;
> > > - frame_addr =3D PHYS_PFN(cq_addr);
> > > + frame_addr =3D MANA_PFN(cq_addr);
> > >=A0 *shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
> > >=A0 all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
> > >=A0 =A0=A0=A0=A0=A0=A0 (frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> > > @@ -199,7 +200,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bo=
ol
> > > reset_vf, u64 eq_addr,
> > >
> > >=A0 /* RQ addr: low 48 bits of frame address */
> > >=A0 shmem =3D (u64 *)ptr;
> > > - frame_addr =3D PHYS_PFN(rq_addr);
> > > + frame_addr =3D MANA_PFN(rq_addr);
> > >=A0 *shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
> > >=A0 all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
> > >=A0 =A0=A0=A0=A0=A0=A0 (frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> > > @@ -207,7 +208,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bo=
ol
> > > reset_vf, u64 eq_addr,
> > >
> > >=A0 /* SQ addr: low 48 bits of frame address */
> > >=A0 shmem =3D (u64 *)ptr;
> > > - frame_addr =3D PHYS_PFN(sq_addr);
> > > + frame_addr =3D MANA_PFN(sq_addr);
> > >=A0 *shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
> > >=A0 all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
> > >=A0 =A0=A0=A0=A0=A0=A0 (frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> > > diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> > > index 27684135bb4d..b392559c33e9 100644
> > > --- a/include/net/mana/gdma.h
> > > +++ b/include/net/mana/gdma.h
> > > @@ -224,7 +224,12 @@ struct gdma_dev {
> > >=A0 struct auxiliary_device *adev;
> > >=A0 };
> > >
> > > -#define MINIMUM_SUPPORTED_PAGE_SIZE PAGE_SIZE
> > > +/* These are defined by HW */
> > > +#define MANA_MIN_QSHIFT 12
> > > +#define MANA_MIN_QSIZE (1 << MANA_MIN_QSHIFT)
> > > +#define MANA_MIN_QALIGN(x) ALIGN((x), MANA_MIN_QSIZE)
> > > +#define MANA_MIN_QALIGNED(addr) IS_ALIGNED((unsigned long)(addr),
> > MANA_MIN_QSIZE)
> > > +#define MANA_PFN(a) (PHYS_PFN(a) << (PAGE_SHIFT - MANA_MIN_QSHIFT))
> >
> > See comments above about how this is defined.
>=20
> Replied above.
> Thank you for all the detailed comments!
>=20
> - Haiyang


