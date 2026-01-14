Return-Path: <bpf+bounces-78818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37466D1C242
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A3F4301E5BD
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5D92FD68B;
	Wed, 14 Jan 2026 02:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B2m/KIxP"
X-Original-To: bpf@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099E230D14;
	Wed, 14 Jan 2026 02:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357980; cv=fail; b=fukQufCJpp5fnRlNd2kpI3CpOqVJlGSsg0PBfBZ9MeNQ1c6ghPZmMFOYqdsJuzIa7T5HG9sPqz0MtUfSkqyEbufJU34+MBqWihF4GqxNvLieOzA1UBxiUvvfVZEM9MsJ23DFweMk0Krf1zEPrNoSxR/gDwD3QkIQ3OI/EsL/5KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357980; c=relaxed/simple;
	bh=oiXuE8sVeRHiAKiWukNAObxPUcS4/tCJBThepXySih8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dclijxrmM96lWTcbI60brNafj8HI17EcFcioxgT35ohbpO9gxB5p50mrchnJdq0GUso/o+xPCgQm/wYGi5wYkAOiacWWXaVzgVflLH873GlGwHQKYc2yT+DdRkV5S7Ylpl7142N7jIIxoqADsQOkcmAC4DaaqQj8oy/NpeoL72o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B2m/KIxP; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqIORqrUbC2GT4pzg+gXBv5j/XMCzSsXn24/F8rND4u1XPQpYugYnyygvLzu3OYeA2I7z1pH5xuRXuo7GFAj6lnfOKOlsKUG9Ik2rg5ZrF/CJyYDQR/XL+ErJLSMqrnTpnbM8jMj9NUYYOa1QbOE6CWlYfDttDYHcgbJEQ+RHaE7MijeNCRnGPsz+30pRrvrQdTA/TGM51FibNvFU/JnwARwnoTt1wxp8edMfS0knpZeYe1qt0C2wbfKyjEpcC3b1NwEZKXqHjqEzPldRTCo60Zec9Ph8p058ghM6FcL5ZGVpGTQfxLBZI8roie7KWI3IHn7Ybe1X++ikyDNH9bL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7scgTVNimDAwjrOn62ExHP6ktocD+IgMQ/YXo4Hyjlc=;
 b=a5eoFFahnlS33oMjIdvup81hfOo5rwMnDOYuUnBzHq73iA3PUcCmyRhxPkpAtx9Xt0N4BorYJNVWH0n045ABvuvh0ehDEjgkqFKp3MvghhwDJp+I4wDB4Sdd0epIqvkoKN3L6kqgZFU1+xj0WYxpIZSvQGms+CGUbzzgv/hXOr9LEyl0lc0QqOeu1mAGvW+ylw9SYt0BdcfHxrMlDmpNLv95Vy+XUd8GKTetOLhZKchip9iwsxBTRW67j8+oNX5gxreLy3zuBKjVow8a9osBLhXIX3awc+LKpQXW6iQbw3IlLmakxAurDGV5AjnpQTWSklHllzHBLv4SuJ4BxobkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7scgTVNimDAwjrOn62ExHP6ktocD+IgMQ/YXo4Hyjlc=;
 b=B2m/KIxPsgH3JNu4GXshXB+gSTnfVLQAC8nHfKU0IHA1hgahqw1HjVd4Up1ljTMj38L4Oe6fIsT2L6Ga0ho9qiOGieVE1Jbjlv+oNdWVuR+e/k1+46vP78vFjA6x+SF5dioKaMDKLnWzltBlnAQkVOFQ/AWAHOue3ao5JgAYE5NW/96VLuu3d6BkNMc7EvoMIMba2sn8jHH2VY0QXi+YJrJMeEXfDQAjKa17Z6C6HI3bMxMRCeqh3WXo0+lyVfJivQbyJd1999aYsgKG7DTkeMUOCdVL5c/tqPqQx8P8eksTJ0vulT2X7+rzBjJfAYwEEakWYeOT+Aiax4P+9DG9kA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV2PR04MB11303.eurprd04.prod.outlook.com (2603:10a6:150:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 02:32:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 14 Jan 2026
 02:32:53 +0000
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
Subject: RE: [PATCH net-next 04/11] net: fec: add fec_build_skb() to build a
 skb
Thread-Topic: [PATCH net-next 04/11] net: fec: add fec_build_skb() to build a
 skb
Thread-Index: AQHchDz0aZ8tg/ezt0WjM8ykHJgVgLVQQp8AgACvCNA=
Date: Wed, 14 Jan 2026 02:32:53 +0000
Message-ID:
 <PAXPR04MB851096528C66F4406722DEE4888FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
 <20260113032939.3705137-5-wei.fang@nxp.com>
 <aWZrzOiL884q/7Gq@lizhi-Precision-Tower-5810>
In-Reply-To: <aWZrzOiL884q/7Gq@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV2PR04MB11303:EE_
x-ms-office365-filtering-correlation-id: 49eaede8-52b0-4402-b13e-08de53153855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZhQvI6noPuw15cu/VimjxSHiOe/yhK9fQQYje7BD1UpHYhbJLdr58N90NLAs?=
 =?us-ascii?Q?jjTWPIiuPcl9S2XJllPUcJilbRlEMIhUfna4oUfhejluZ90IVqwryGDSOkyg?=
 =?us-ascii?Q?Ar3CJxxyGHkc9ScqawS4Bq5x7y/DrcKcUPGWgsAJJ3j4OcWV/nA25qghiDWX?=
 =?us-ascii?Q?3M2GFduGCt2uLDKwmqAvQxUyor6lah/NaukepLr54o2Lf1E20jxUB8FLPif3?=
 =?us-ascii?Q?4YHe5wUdhNmsLRczRFT2/p6zI8pjDQjWWt6/iFpeC2eAJSyT++IM96A282+F?=
 =?us-ascii?Q?pxvKo0xywyxH1BqtXEsfoYz2VN5+plDpqvxJCdAlV7yyW6HpTI81fzUQKyQg?=
 =?us-ascii?Q?Cb713upBNmHGt1uAfhBPpFHZmLaAUztXTUJppVI1brgqoAmQpubzOBh8r7HS?=
 =?us-ascii?Q?jYIqlRQClD9a0ezIbSXpngHcWIpNWF75egxn1kMhoBWP6Adie2J6iLbDC99H?=
 =?us-ascii?Q?RbVlh7yZaT7WNKD9SyKDhVn+NOyEfswJ8Q6DrDtRqQFNDn2J/BWp4/swuJjR?=
 =?us-ascii?Q?tizzMD4QX+BDPdP2dzlU38jN8o6/WJsdgBjx3oDIPFY5NkGApcV9m4viGvYc?=
 =?us-ascii?Q?m8L6A6Q6JuXIyCRVoRGXRdPEm3eIrbZMAS7yd5bXf55l7bGWF+3B3Sg81eVf?=
 =?us-ascii?Q?iJGB0QOGW+hPD8Gfa5dXz/IX/WMpMLe5BOg1VlMdaIg55RohluVHBnCEpurA?=
 =?us-ascii?Q?/S33cASPHROyYh8KmV3HBrX228LimsmTajcn+x2N7tLxBMtM6PjLWn1h1kVg?=
 =?us-ascii?Q?kQwPwaG2LvxEGtP1LivpcaU7vaRkEZQDffQ0xLLI4Ln5WD2AnZ8Y1coLOr+u?=
 =?us-ascii?Q?/edu6pKiSCpfCdl9fY6r37aShfQf3DadgTLAUz1K8QrKBpGKX639sf7v2wgS?=
 =?us-ascii?Q?wU9d/otP1W7x34+C1UF4hJsggghXHSYr6zm7Y5cwc8pguOi7E1wpWuvS1vEI?=
 =?us-ascii?Q?y+38Jt3+xihilAIKVMAExfR7fiXXgwcbYaJeg25DHcbuiyHOJwDZp9TOQfUg?=
 =?us-ascii?Q?mtzqvSOeFQEHntmpVHwKhJrkCYpy+QprKe7MTzAYEeL1lLDIW6EqZi9oL7tF?=
 =?us-ascii?Q?NtgtGwqu/f8UKkociiO0MBAMZ+a7w8a5yqOkvvYKBgtPZ+kSGBaKWHXFL7Y2?=
 =?us-ascii?Q?UTD+kEeCHoVAwuntnmZgSl970nMYOExg9CHTVEs+08lIX/4m3jvEyBbeIUDx?=
 =?us-ascii?Q?fcUBxZtlocjm8EzpTPmi5hpiA8tkA51thGVuZLYkfzGqR5RkykJrBtWxsvxc?=
 =?us-ascii?Q?/Eyok+S9OxxWxfD7GkJ+VSc4vXa2bKwb0+Tj8u73uWU18QGwLRtbax06a9Bu?=
 =?us-ascii?Q?vHJKqMvPXYeHM62GhBFQLK45L2/kRbpckCBHH1Dy8avJLUeQOTP1PqsG7Dlr?=
 =?us-ascii?Q?hKTKvEzcbPOG7O1r62v6UjgBvfZWQ25RxqCAfurLPbULDXUWx7LoshMGcX4n?=
 =?us-ascii?Q?A67jN0kUMyd3zQC94DDqNbMGcZo87SLr1afMo8W0DtqIKDv2V7U+at0lXInS?=
 =?us-ascii?Q?KhYa1Y1XT0Ag/oFLyCNlcu3fwejMVbqXG+b1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R+Eh8K3UgkZxsBfJNAI5TDzXvbWMNHRoxexBsNspiMsav93RQze53+EdmV2u?=
 =?us-ascii?Q?u5r8G9UFJ33pZ2/ZLAALS0eiBQ1qn9qxnLwX2hON7rhGx1aV44jFG3oxXEuB?=
 =?us-ascii?Q?6gMjt0O3L5ZIObodrvVnQzwEiIINz1Qm5776pasIwF2btjFu/idcMq5SlzE7?=
 =?us-ascii?Q?OPwe9sDlrBs8vNKExbDrr+msy4miyLlNW+ppsnny6rD7H3+h4+45533iBFOx?=
 =?us-ascii?Q?nCxOrdz+8LuZNfcmmA6btKauKEHJC8FoEOHM3X/b0csXqvVBnsihicwH2H4c?=
 =?us-ascii?Q?1TECh7SThqhZDpD+JlrkPtbYAJg+cBBk9esKV+PkWwzpC7ZJczFfrArKYT9I?=
 =?us-ascii?Q?VWRnnELJYoPS/UOumvKnLbDjtxljDbvAZEhWmYozZ9om/fpUhDhhzVdAcqsl?=
 =?us-ascii?Q?TRqQytg5pAZSvwzsuYg9oxwvA4NyGOzsRz/wRkQwYRRBBFVhrOP/sn9EK/tK?=
 =?us-ascii?Q?9KbqPtLFMW+Fvm8mE+p/xbwp6Kc21YCfNf4AlILw6w24J1rME6+Dk6FAE9Ap?=
 =?us-ascii?Q?LHyBYiPCq3RiLk/V4t8EkQMAV141CE2Q+VQVxI8UszHYSBfwoZ9/tFXwdFT5?=
 =?us-ascii?Q?CGcTqUkW47EZtrV+cg8h/4SGUMt5+uC7E+O5oAkVRIwM8k52CjzCLY45AoeR?=
 =?us-ascii?Q?Y5b4EILYcFUFfkneaMobPI1sPqEBBvtIuq26mkI8IhQy+8cvnEyS2cgm1LBX?=
 =?us-ascii?Q?wrAxhaW/LhIT4Dk1Ul/4Vs1jF4WEsDsQfnceG5Xlct5P+vHZ6jLYPl7e7zIg?=
 =?us-ascii?Q?7HbBkqVsFmLGgPMVXxhTYagY5OvfzygUPJ84QcDERdc/BlXKp6piczeYYsPn?=
 =?us-ascii?Q?zrL2hVci9M8KxGrWiVfUAl/gF29LC0BFc9EArREcWTeHXTKIh6Pr1wqAGPcq?=
 =?us-ascii?Q?7iB4ni6Mh49SUiL/IxkhRxwVn7gEnUpSdAzmX4Vhs/DShhLdnvnfQHSKUizV?=
 =?us-ascii?Q?OXZKuaw1wiydIMYDCMsoouvq7464oNVqoYlEIQzIogksFHbbsoxXZ2jRAzn0?=
 =?us-ascii?Q?v54Nb6RPDJ1nF+olIqqaC1dFNPvlCOwV0h71moKassgJK9mXzB3RXXAQx2za?=
 =?us-ascii?Q?pPahAIrnRCyXPHh20QePBcS4xjNrBr74fSor7/sEuGU4F4szcKEL3PC8Wdsq?=
 =?us-ascii?Q?f/9/oLjwZBwiYDJ8Wd4d0MClPh16+QWwbYpL7S9whVshcR6xS0hFFcJgkjkM?=
 =?us-ascii?Q?5sdDtAsSxhSTLUS4ySK3s12eOdTHOBfhwYb9PpLgxIBpsDDK5yUe0k0p3h0f?=
 =?us-ascii?Q?fjdtQZgMN/rvr0hKGeMJc6+4N8odqlC74MfC1fIPDAi+G78jrS6tF8ld2yEA?=
 =?us-ascii?Q?mulLGU/QKWjlTaqH48cw6SajBGhfWgRlvGgMwSpG7TGnFTkgWJ4XWp34tR3/?=
 =?us-ascii?Q?e95M36JLLekix7Q68TH/Qdvi7oUtCoiLx6BbcDOmYv826Oqg1+7j8r9/6Gxc?=
 =?us-ascii?Q?VPa4LIdUOM/hG3NGcRzSJ+udQ5IfmiM3Dopw9ZEovdj/4g938tvh6ra7IUXw?=
 =?us-ascii?Q?G+bwJqWzva46C08kjewxG/Z35JNdCyNjGUr1Y5U5hxcZziDi/XmbK4QpFH2o?=
 =?us-ascii?Q?IUjgago3+8QAHFcY9bBe+jq/iqUCTHkKUNceS/rZXnEb8kgcazSKNxoJmMtY?=
 =?us-ascii?Q?EDCTesM3ZEP4Vg8HrJpux/dFdWfQL1VCadoPq8MahLifaUGvQYbydWow+di+?=
 =?us-ascii?Q?hi18RTntmgosEpm8jc6OBT/7H7gGBYAeD1/IODhVzEs5V9NN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49eaede8-52b0-4402-b13e-08de53153855
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 02:32:53.7170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNkUm826Xh+XaaVx4gk785s31qRlVhHt8DGNLLpZbn8/TYS20eiH/MxsaoCRnjl7Zdzj2etpxevECnUTk4i0Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11303

> > -1796,7 +1849,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16
> queue_id, int budget)
> >  	struct  sk_buff *skb;
> >  	ushort	pkt_len;
> >  	int	pkt_received =3D 0;
> > -	struct	bufdesc_ex *ebdp =3D NULL;
> >  	int	index =3D 0;
> >  	bool	need_swap =3D fep->quirks & FEC_QUIRK_SWAP_FRAME;
> >  	u32 data_start =3D FEC_ENET_XDP_HEADROOM + fep->rx_shift; @@
> -1866,24
> > +1918,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int
> budget)
> >  				goto rx_processing_done;
> >  		}
> >
> > -		/* The packet length includes FCS, but we don't want to
> > -		 * include that when passing upstream as it messes up
> > -		 * bridging applications.
> > -		 */
> > -		skb =3D build_skb(page_address(page),
> > -				PAGE_SIZE << fep->pagepool_order);
> > -		if (unlikely(!skb)) {
> > -			page_pool_recycle_direct(rxq->page_pool, page);
> > -			ndev->stats.rx_dropped++;
> > -
> > -			netdev_err_once(ndev, "build_skb failed!\n");
> > -			goto rx_processing_done;
> > -		}
> > -
> > -		skb_reserve(skb, data_start);
> > -		skb_put(skb, pkt_len - sub_len);
> > -		skb_mark_for_recycle(skb);
> > -
> >  		if (unlikely(need_swap)) {
> >  			u8 *data;
> >
> > @@ -1891,34 +1925,14 @@ fec_enet_rx_queue(struct net_device *ndev,
> u16 queue_id, int budget)
> >  			swap_buffer(data, pkt_len);
> >  		}
> >
>=20
> Missed swap_buffer() in helper funciton()?

No, fec_build_skb() is also used for the XDP copy mode, and we do not
support FEC_QUIRK_SWAP_FRAME in the XDP copy mode. So I keep the
swap_buffer() in fec_enet_rx_queue().


