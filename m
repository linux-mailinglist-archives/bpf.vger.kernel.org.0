Return-Path: <bpf+bounces-79565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EABD3C08C
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B2CB3A6E0B
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9238A3A35D6;
	Tue, 20 Jan 2026 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e620X8W6"
X-Original-To: bpf@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1B3A1E9E;
	Tue, 20 Jan 2026 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894220; cv=fail; b=P8Fr3OIMz4t4YXpCDgn5Mfb0yG9pjHLW8w1BWmGYL7n78oVfhJTovLMCHFCfW+igX67OWqS/q5peTCP0uhooZK1V06tUlZtbJxhbv7WUb1TYdVzR340QON9lze7xXyqyiTLIKrT5TWpWv+YPkamHavy9diahn0PkSyBqfTWBTAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894220; c=relaxed/simple;
	bh=+PKMQe4tA2G/qXkBKGr3+JetnxX20k10aEcBRJ3ItMo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cqZIoOSdlce0Huy3jCu6pe4xMYzSEIkdfNrOKWlKf7JnZ16mjLRcXTVvwSmZN5gUJlITB529mlwglzJPooLqSc6ksEEudw171MVldzGs4ORcZ172lVqTtZPCuvMl80DAPATuDAereW3j2bP/W6VSOqWh8nhTngZBdjxNA+gj03c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e620X8W6; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrphtZdrMlClB+Hu2HEMEed1EFYs8AY+iyUFgZSFSlKWtIeFIt1EcsiRNEa8FKl9DEvdklAppbsUHW7g3VP16yrT9bCE93Uo6R7tBKxgZ2m6h3eF6+7iHDqRTzonT/onIrEqQ3NaVkjFCOdLDTr162rQzLYl9iBPmlSCHpz5fTZCmwerDQoewRSi/gyCx3hOCtVBej7JiAOPqO51upUuWgut3ngwhzrFRayv5HGc+gXohl0HZin82OVKM3HTqrNaeMWis9XHx2mhKwKZy5jkIXu6SvBXauIWNnUhnNX5vTZrRfofadT+hsnG1H3+e3JdZpSbmtuNcUx86weuIeQoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxH4wdoDBXOlpEt5CU9Nhv36DOXvxD0ixrsEfoLyAzU=;
 b=AucotbrKGGm/9/q8EUQ/gqr4WKAeYICDT6OCcsh56tnfXGp5NSZDh/FsLITEOrPaZtJ41x1Zi2gQwNEaHKBawf0oOIynAY5BchokSzBcqgi4Dr5jrU4IDfoBvkWEIzXbcKRosyIGzuZirEZnIjmNaS1PDR4pdrgyWuTjKRzHxXieMAbbqMndRO5eVCOIPLvkk5dgDJeLhHQILCeA6BkayvIMhnYy001EEOw63JjQf5NLl80BQTWG7N1oNCHe67lEOAHzkRAu74ef82SGnoLpMQbw+H6HKMCkhXwFTvXOJHI2P6V9rAMMn+H+7Z0xjI2v72IsB/o4JwSQQvZh5mVmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxH4wdoDBXOlpEt5CU9Nhv36DOXvxD0ixrsEfoLyAzU=;
 b=e620X8W6QLkczkTfsKyWzcwsJt5dV0w/+7LLwA517A3XDWhFstWr1LSqWSJU3zk4VcJcjRViopFHJtHs9V9vj2vqFjHFzqnoqtx8OwWNnt+32VRZvxK/uj9wMNL/R0OR4Q+gZofjr9uMr4dCKDLFFvXfjBjZIAc2DeW7noIHqDuotvWunUDD4I3RoKS3jrgNxzSBSiT8d3DMSBE3bBzfG1I0R1ExQ8H6vqWoO7gq8LP51GGPgh6LCERGsQOHuk1CYsHvGB3xk3ZIvGWugN7E4L5kUBiERUditA0ADmIgSpDs+xcwGlH9EuuFq5ZCPxuTrR3KjDp/9KxgNTYrAKzKRw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by FRWPR04MB11223.eurprd04.prod.outlook.com (2603:10a6:d10:170::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 07:30:13 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 20 Jan 2026
 07:30:13 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 12/14] net: fec: add
 fec_alloc_rxq_buffers_pp() to allocate buffers from page pool
Thread-Topic: [PATCH v2 net-next 12/14] net: fec: add
 fec_alloc_rxq_buffers_pp() to allocate buffers from page pool
Thread-Index: AQHchrucPRBnp7Vpd0ShBHdoinT+BbVU3icAgAXP8zA=
Date: Tue, 20 Jan 2026 07:30:13 +0000
Message-ID:
 <PAXPR04MB85100C9767C30722D693BCFE8889A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
 <20260116074027.1603841-13-wei.fang@nxp.com>
 <aWpNcsoiQX7WESis@lizhi-Precision-Tower-5810>
In-Reply-To: <aWpNcsoiQX7WESis@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|FRWPR04MB11223:EE_
x-ms-office365-filtering-correlation-id: 86f7faf2-4ead-47d9-8fcb-08de57f5c002
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y9jUINEmfTNkIldTXkI02D5nmMFCfp4200LD4WTAQCguMeRx2Hdh1sfIzJ31?=
 =?us-ascii?Q?sNxjSyGavlkli+Vw7Lb7yQAOSRlv8VpEaI7sWM3QJF9AyeUi2Q59kyeXexOr?=
 =?us-ascii?Q?lq9hHHZ97TBk7cemOGWN7oh/+QUAgU4V6VAWnFe8AwTZdCC8uxF4VQiCZ3fv?=
 =?us-ascii?Q?ey8DhbuIoF7nzCZOFSV9rES03VryLl1p39lerL0i9eoSvjoVbOXPfaWVewaJ?=
 =?us-ascii?Q?GHEgGwueDews59jH2ZLFCtHV87ji/EGy+AT8/hMgkOZAB+Hk27ITF9xVSPTY?=
 =?us-ascii?Q?qj5DhWW9WO0uE+vXf7mn0pk0Bx29mdYm+52DUFh9Ec44pm5rTEBXPw4BSTRF?=
 =?us-ascii?Q?FV7mif3EOI3O/rRGSl1OPwQUszgM26vEUd2Z0jHz6xrje0915wB0sdAPmgem?=
 =?us-ascii?Q?y58yzf8oz/WZuNUMuyAjapphXlnCopScstf4EADcVdQXka9whW9ey3W2BdSb?=
 =?us-ascii?Q?qm2mHKP5On8cKwUZJN3cJuW360e40vjz6cOSUSsAa6qwlGEhbuPKyH7DartJ?=
 =?us-ascii?Q?SMZrZqvD+A4v3Kzg3gzTxPy3d4RaS+obTjuRbl/ahYfARdDsxyCmlSBuqMYg?=
 =?us-ascii?Q?A5KxDeLFuTjPK7tQaiWElEkJxBNn30irZ/UZnhJ/eBYGivS4W4VK5sijZaPV?=
 =?us-ascii?Q?R3NvlTfCQL8V4vEVfAL0Z01uytxWWyaZQWZd+xvJlON4Wm78X5LgfpxDwGUJ?=
 =?us-ascii?Q?MJ/hLKlV60bYf5Qx0szSa0LL2xa0SiwY9hcDsdbCNGXUu7BAFdsj38V/RvPD?=
 =?us-ascii?Q?fVdTiQJx1J16fbLhNnlGiTOaiDBbLet5aoftZcY5XIgvTJnLueZoYAOiXYRA?=
 =?us-ascii?Q?1BALOAyTXMP4fqLNtUwGnGlGTwFjdmP7MdvI/8ubHZu5smCuNMZDbf+Ziyft?=
 =?us-ascii?Q?JdEnkJAqM8CWbyoQC6XhiFKuo5Tu5eKIUVxQeZipa44htsncjATJ5UZIOvZr?=
 =?us-ascii?Q?JtA5X0pWJ/POMwXM4IQ7MwZcUGM2HqGe7Ai1AL8YT8ASGiAV68A6UX2jPr/e?=
 =?us-ascii?Q?UxidChV3i0hgSm60MP950alsB29gzUyBEHN89HIG9qS6TEQ7DnvCyRiJsyxe?=
 =?us-ascii?Q?u6uBO/0KWR3OnsKeoq/y6ZwxdreN1USyFBWYFAcqW4HGG/GR1CyT2wWJ9RTE?=
 =?us-ascii?Q?P7nLq0Y/I4cqUCPxAKNs41VCjAvEoTZnTJAHf+MWev8csO5k7MLIcfmBArCa?=
 =?us-ascii?Q?3OHyRsJaiGxeZAjFqkKFNBiQ28cgwUL1evLhRxoSVf9HVo6Br0AlRF+zfeb+?=
 =?us-ascii?Q?fMc00Bq6fSPkyFMzxw0OhAqbcM/k/gK/uG1otYyxYaTE1pcDn4fBBq/nhyij?=
 =?us-ascii?Q?ZUTWjO9pv5MCXb4CR0CXZeb9/61ruAQrKnqO9Hxju2G0Vaq3GqU9Gkd4Svyk?=
 =?us-ascii?Q?NHEqTCRDTQ5UhZ9PxwDQlSnHOfAfkxb9Z1whxqwegoQddcrcCfphPFBF+26Z?=
 =?us-ascii?Q?nDi4Ib+oJW260QAnhjXJniwkAcXVz/LaBvv3nLkB02iscwsX5CB2B8Spr1gU?=
 =?us-ascii?Q?o1WXxzQdUGwWE/aF7yql6ipxSKAxIcSLGVRU3/hrCO4PVvBWKyaazxZgLoS5?=
 =?us-ascii?Q?OtKDzTwn3ca7wr6+NEDMn9eYTMO5QozzjJIfWefoeSGk9OZayQyyfOVmEBsQ?=
 =?us-ascii?Q?Qzurcf4guPkdpMjNh9izfLY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RFtAWNvRH3ZYuPuuwsVsfCtTWvH2eRJf5fvZYaS5HeujVgo+aKC6r3iqzvsU?=
 =?us-ascii?Q?aV+Bn4LaMFTMYHrd71dMAXPg8AsrrlOE/vJ8TiLBFSq0qY7mZtbN4yNGn5Dg?=
 =?us-ascii?Q?4oybeReBwYKOweasIoLVIldfJ7+CVM+sQvCFMGUZu/BmYBhbGnhYzW+sLuuK?=
 =?us-ascii?Q?3rTgWXW/uHQwoAyztjMpfc/yeQyohdcviQ5lHGHnhhmMXx1ovhSJJgrKHvGT?=
 =?us-ascii?Q?l559xlKkTzXfHDQNhhHawOUBl7S1U6XAWLEevZGh1gS7NF5U0enaJ56F18YU?=
 =?us-ascii?Q?NtUOz8QyzjEnDdl9LHe4Vd+KFlOADS6xaffSmn/urWrdcs5T3UFg1sXCFiuW?=
 =?us-ascii?Q?ZZuFo0L9/y50NkiQGJDb4ThUTsDfRW+nib+Yeku8goWXBmJGXKzyVgHWOVA2?=
 =?us-ascii?Q?mYG24OrNXHwU33w/JZGRyMEVYfiOQ212wLpa0Tzy5OSBaoCGZU0BUDfJ9XzL?=
 =?us-ascii?Q?BCcxSH1XAs5afOpRG8dKuwdklxoVR8JqB0IQWAX0Jb5sDN1vSaX4E/PcQPsY?=
 =?us-ascii?Q?sjhOQ3fEY0rQ9hAcHYh9k/pQG5QP1yGUBwAsOeYXtcrEP4exa5+YaQkjJk2+?=
 =?us-ascii?Q?ZZF+cKrkAjrLNcSM0bQ2eIC03c7TKf7rTqBqD6oEln++cBrwpZz8ypv6UPbB?=
 =?us-ascii?Q?5N9MFVcRdDdrl9NZ2b3YWUE8T7N4/VRYVq3AWVAQ0Oape9aSDvITsTiLer9k?=
 =?us-ascii?Q?sOwHZuWMpxih5o37cPShaTbsE6kf3XRpf7RzrzLrmPv/U3DvHCmwXCKFHLUG?=
 =?us-ascii?Q?WMw1tVaVH4A41aZc4c7uqwWj85Z1Ju5LCKIKu04faUvzhWeL1r297p2uzVwZ?=
 =?us-ascii?Q?WNA/HEa5pvFgVISKpQhncfE+bQYeIrbW9mmZ8VNi19X9H/6vb/LF/6xwA3sD?=
 =?us-ascii?Q?7iy+gfaYT8f7FMxWTRpLJuQFR5lB/wMlgVCoWC/8oIYV1cdf2iZDkYd57xms?=
 =?us-ascii?Q?ax7W0R0/9+LyNJL64UgP6WuINM2JBAj2/1H9cQEOLA8tO/I649udcygxLS8l?=
 =?us-ascii?Q?GM3Ll2Hj2e9HwCkFABocuVCXuGeGFnPaRlzKai/mIybneSYrkf2bd2WZe6tQ?=
 =?us-ascii?Q?QK+vTFzlLfjuaEvo84+SLNr/MQCBFHFD8dQ0nfw/q3TebT5t0JCF6avoCS+6?=
 =?us-ascii?Q?vtgYDGgvsUBBJ4pugSlRxEMNHsUZVUNcsy+4HwH0ytsAfHdDKEAUi0SxXlmb?=
 =?us-ascii?Q?T9Wot3ck295n3H26lTgU2f69lzGzUvdH+96ieY1KxHUGbvYupyC6FKz/e3EP?=
 =?us-ascii?Q?LyTFiXlbez5oh5pP85NDtHUuYy+1mN7z2PTiolux5gqR75wlJEM8SH7rQHqJ?=
 =?us-ascii?Q?SlOUBqS0PWlMK0y3NVjvrly6/QuK4cFRMVQ2iVyQElI+mDWLbofT11gK1u23?=
 =?us-ascii?Q?EjKNUaaxhaqlpf2v7emkP5a1SLbd73JqTG1U623B147Nfv2xEqIFsy6Yhy4r?=
 =?us-ascii?Q?0FRFH9Ds+W1UmgKgHwmmXeZyN6CaOcvR3XOG4O+jVLqOXQv3g5TekwXDcmDx?=
 =?us-ascii?Q?4Q6vtlvKbt/0GlnTl0L2Zm4frfiORXnbhQTZ6sfJJ8bpnGNLGjWbMZul4se1?=
 =?us-ascii?Q?pvX97/pc/okCz7EOrYuQmKrnzpeLPiVv5Z1GTpokO3u0QfnALsYrRCpSzcyZ?=
 =?us-ascii?Q?Z33KSGqoy9v2toIXRgtPHUxO/obEVzkEREnpYsqFVLS1Z1A7+YM4FcdVSMXe?=
 =?us-ascii?Q?I45aa12sDdos1x0DYtL64N8XCj6DwJg4vioNkpeS4RoP6Off?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f7faf2-4ead-47d9-8fcb-08de57f5c002
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 07:30:13.2868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wL551EOyjfGtdNNcWD37IxOBUIc3+3AKIRqlgiXODnTWjfSmRZ7BTl1viIA6gUzJCK7EFsZTu4hOVqEXlsmz3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11223

> > fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int
> > queue)
> >
> >  		if (fep->bufdesc_ex) {
> >  			struct bufdesc_ex *ebdp =3D (struct bufdesc_ex *)bdp;
> > +
>=20
> uneccesary change

This might be a problem with how git displays it, the actual change is
in fec_alloc_rxq_buffers_pp(), as shown below. We need to add a
blank after the variable definition.

if (fep->bufdesc_ex) {
			struct bufdesc_ex *ebdp =3D (struct bufdesc_ex *)bdp;

			ebdp->cbd_esc =3D cpu_to_fec32(BD_ENET_RX_INT);
}

