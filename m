Return-Path: <bpf+bounces-41180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB670993D89
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 05:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1081F24EA8
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0770E26AF3;
	Tue,  8 Oct 2024 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kczz6eEm"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076221DFD1;
	Tue,  8 Oct 2024 03:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358255; cv=fail; b=aI5pz+p4bwmoGiMjfUf21vDLSoMbQDNaJkr/2Kq8CydLGR05KCytX1Qq75x9NyJNZBSZ034a1WUP8manhq2nLaeHvB64dXsAWlVvpunb8+AZj/49nC7n5w1odrX7Fx0lDFZDC4hEoe2uzIfFwSnVpBQ6Xi7pCt4bd9EirM81mAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358255; c=relaxed/simple;
	bh=BdNv5jqlgcc3yrt0qv8ogpRV2nNlmQ0vXLTKbITTTGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ylu+8J4wh7srZxOWpsIf4OdlIrz7J5wLL5zlVM8bOBTao+Pxz6u3/BFjuYen3Y/ZlEjt+5am2IWpGFeDmQmI4q10ITnExHXgx7B3haMfCwzf8/k0+/WsYJsIF7kIxhZEY40xxITcYK6hvZiqWDB667e7w9RaQjq0jgF4ja2SDP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kczz6eEm; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2Dx2UQL/8KVZJ4j52t0z9Zai3f11ZHj/9ikus4moqZNM1oweAxine3/bbFtYSG9zA84M4NDdRFMwqhOTy2p2HDVlo9nl/kQPSkWviNtkRrwSpP7x1GCMJrNGWN4LuE3/419xZVKN5Z9Rt4tbtTQboch82tSKWUhnMk+fv7JUjBCNvIjxsJb0Ka1SzpSfhde6lIge3Bw01XpixGZ42EJ6uMHhV3pirOJAjrfDlV86RRSxBa6KezMBHbC8YAajgiabTdWkoRmrjdTCVrzjss5MwNvSBgDYUupzyzTBkoDuXhAz0iOcWuJYIjX48Ejun1sh8oKZY62cg9ZsAQD+kIP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1dImxxdMO512UAOqoVUDBQ07Wx4rZC5UnkLrRCIXb0=;
 b=bfMqxB/q8ZbOZ8Ldct8tZ98SL4rSTy6HcBQoIRtSwH7LGQUQzYE6wA7e82qajd/k902yBFR4mzeW6HJZ+J7F70tPeMWfZPokRU4MKN7dz3p2BgWbG+aD70uC2+ugFf/mkru6wKyyKFMQ2CNEqugtmDFdpZVBtj+k59LFjZewGHP8XCZ7aa5JylS4sdBc+lIgPFiE+LukK7iqsiVV11y9YPP58jUrhZqZyoXdNVMPJSpcgC2HlljlJGeBmoyB5ea/Jxn6DKD4h4gt4kcxIOlHibEhMKAdj+HiFE0hgTcVE0lakLoEkFP9ImqcP2nTcDb6riW63AT7QOCYz6lHeh4Rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1dImxxdMO512UAOqoVUDBQ07Wx4rZC5UnkLrRCIXb0=;
 b=Kczz6eEmGwAfl+6mRJD5cL/2JogA4NkXZXkPo2SKTsFVQ0wf7e+QWCmedZszZFx3W+Kug4Luy/XiRvLZBGlrMTRsXTof5Wy/gI7w0Epb5q495E0+iXBnxbesf18S0kBAWjPoPVXCCAsuTJotkL6lIjnkk21CNOtOLr7+DwEJLiltTOg6fCev9QBP+Ok1JsKt5DO9kMHgJQ6kWyr3bHW+pH5M6iM5gWSCd6KBO7uBtPRkm0N4d9PbLzmjv6V3Ffb49sSFI9srSyvz58YGDSYlSX8QOleZ8nGTtwAxLXQ6wBH/4Z5+lOzRx57wxtBE2kOSGfJBvvwDnWQGQfFfDnmS6w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8341.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 03:30:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 03:30:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "rkannoth@marvell.com"
	<rkannoth@marvell.com>, "maciej.fijalkowski@intel.com"
	<maciej.fijalkowski@intel.com>, "sbhatta@marvell.com" <sbhatta@marvell.com>
Subject: RE: [PATCH v2 net 3/3] net: enetc: disable IRQ after Rx and Tx BD
 rings are disabled
Thread-Topic: [PATCH v2 net 3/3] net: enetc: disable IRQ after Rx and Tx BD
 rings are disabled
Thread-Index: AQHbEhvKg7CI8w3+3UGT+l2bnqYKr7Jw5MKAgAEBQGCAClYY4A==
Date: Tue, 8 Oct 2024 03:30:49 +0000
Message-ID:
 <PAXPR04MB85101B7AC1C1F46E8DD59958887E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240929024506.1527828-1-wei.fang@nxp.com>
 <20240929024506.1527828-4-wei.fang@nxp.com>
 <20240930220249.dio23fh7mqw4pojn@skbuf>
 <PAXPR04MB85102EFDDEBED7C602ACBD4888772@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB85102EFDDEBED7C602ACBD4888772@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8341:EE_
x-ms-office365-filtering-correlation-id: cafb1e22-23c4-4bed-c50c-08dce7499b09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xeaRQ8LLvXcu6wZsUAM4V7oVTGzGuywpx5tDYPoe16ZdZ6Mw0Biy1qtq2Bo3?=
 =?us-ascii?Q?qv2bHyuBBMnNyaxYDXvaGq1L9I2IDzsDQ/n0nI//R9005Qo/VQeWF6b2Hp3K?=
 =?us-ascii?Q?HOildIl4AJKueHzYR0mBjdvZBu5oO7cWmyuubgh8H7b3fhsJRuESnR+Dqooo?=
 =?us-ascii?Q?sHworrRKvEtXbFlaSn4dF0m6khXmNVxoXCk92nvg3fNYxgC4Zzz6TdOze+ad?=
 =?us-ascii?Q?Je6CLnKavCPWlMS3ht4fv5aUwUbBhgXZfKCj224MHfiBlPFoznmLGpMY4KGG?=
 =?us-ascii?Q?8fCfIEbfkIF3NDH7d4dkffzPTjKw2b+91rxH56JTDV1I040qHZekXI1S3BIB?=
 =?us-ascii?Q?+Czps7B1F4jUuGNsJOD9UPNF22vZ7clmxWm8SGGRb+tBtEh00PP0lm4yryF0?=
 =?us-ascii?Q?pf5jQMoJVnfgIgez3NXIRsPVVbIa5z9iMdxTqHecOQzeSg7VSoPbSncC8AU4?=
 =?us-ascii?Q?a47M2Nd3brVdVEfPOd2qEEa/209dQ3LeofnllBNVQ1qRXwT2nQw8gq0ooVDE?=
 =?us-ascii?Q?SYMoCKKVRkX05GGScC8WDFItFDdQkfH5QWfRY2ILzwXclMiuPloy8FnQyXvP?=
 =?us-ascii?Q?aC6W9MlXedu/iTXdWIQIkVKmNxq4/FDezN5vGC5F51sz91i3qh8cfz/ioD1k?=
 =?us-ascii?Q?hQfYlVFlBnQMK9tJl4zMH2Jlc7qUyuK399SCUyQiEv72GuDFjfd5GwoEDaNX?=
 =?us-ascii?Q?wnccXGJKBBohutwvX7KyVHrDtDdKUPOwn3CSNEbnOb1RotgvbfquFyeeduSZ?=
 =?us-ascii?Q?3KizYBgCax5/Vr/f1nCENC2pBF+62Qr0xvZWn24vC2/qQ1akWwZ4xrXTQjzT?=
 =?us-ascii?Q?KCBZjYaWvOdyQvMJfuENcd9WQh/94jvXFw4bZXsTqfxvLwWywwpt4nnK+edC?=
 =?us-ascii?Q?FCuLqJ/J7jEX5Sfrf/6iXqWbH3f3cDxMZaIpLncsFpCJExL61C8WONLbOqTS?=
 =?us-ascii?Q?JcB953t6XIcUWUvd0ogFzis29BnueZlURjSRGmB2HpO+5IEZd2AX2vpRBOg5?=
 =?us-ascii?Q?HZDGkP3OvWbQNnJijBkn1IsQcE8LXdka5yoQyoRhBKppBybn7M/rTQ3Fw5SD?=
 =?us-ascii?Q?uXnqzOVlg1MoRPrPuFcwSUaVePbR9N3ztAml0wQre0UPYALS5IFkLHM0/htS?=
 =?us-ascii?Q?/Yvlr3N8TYkmgYCZ5cla7XSk4EYJ3UrcpR09XhVi/AyTOIzcseKpTRmvoZpL?=
 =?us-ascii?Q?LramJuQII1Iw0q3Enj6p+EU/tTowXimHVv39PPRaIiXkk4b5OQOxtEkhKvgW?=
 =?us-ascii?Q?EYSzqzkVQzOYTnrVG/MZOxcXYgRw/Mi1ncMnqjag1RN0K/UFeUIqfgFVsISl?=
 =?us-ascii?Q?MS30IYf1574ydm2TTxOZgf2zlzcx3dmviipAuW6EinipqQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7DX475u3oLEJtK0nDcQMgt8UUSgx0E3C9Ws9fTHqaoenGcy+8NR3XRO05bzs?=
 =?us-ascii?Q?M+nfEC4I6zj9jG146AvR4xxiLrgllQAE03n3DWL31hyGDrwpzPrR2xhF93S0?=
 =?us-ascii?Q?EVoAFs2P0RaX6idBC3v7KH9vuGJdqRNQ0dXeDA+7MD0yRsJoIz90HLG6u5ur?=
 =?us-ascii?Q?Eh/gSrzaUYapHc1AgxIDBW5Wvk2ZD17ckinP8GXdUcQBu+AroNSd4Gozm2KV?=
 =?us-ascii?Q?z6pwgGX43fbmjtAEXoJ3ENd6MGy429p7Mo7DBf/bftwBC/ozOErpalysDLey?=
 =?us-ascii?Q?fDE6wZ2vnR1xxAmhW3Qec1tFaK6WisHHGXsaO/Kx0aLOjIWJgYduA0oto+7y?=
 =?us-ascii?Q?1OJRhWAAwCbGqGWGcafyGJ8SVv+G7jwk1TQCIBLk5wM1HQhBnzzPQRaQoE0W?=
 =?us-ascii?Q?EvrLW5rViUf8nLbD/gy4OUqkwJ8/PwDgUMFY7QX4vmrdyvnJQhIRi50r/gOW?=
 =?us-ascii?Q?7IJTxdcXzUG5ylN24io3pkkU+76P8PQ1p/yDKxP2HldbQg7pi8HeM4zgY19L?=
 =?us-ascii?Q?1NUoqftHJ14RRRMloXyIqD86tW/TG/XZwdsbbawAYZ5BqWyl0PvoHCv3mgz4?=
 =?us-ascii?Q?49ygYYFo2DN9ayvwtylTjYHduAqPM42NYn69Q/ofmoITNhNz/HLSoCJ041TG?=
 =?us-ascii?Q?L378d0IPWWVjidwag0x5ZEMdnPg8bHG+KfafKeCXs22mfXBPhDs5iOkSP7Kz?=
 =?us-ascii?Q?5wbkKq16znOte+mEuuvksFIngiJCiOXuMKEPvd3CiEJyZMTMaRM7G6WpI/D+?=
 =?us-ascii?Q?IFuQK8GVVstvm5mVuiOV0AU5fLdNXiP7E4CeWuTuRNEwC9HS0Xb9WbVWQ9oE?=
 =?us-ascii?Q?BEixUAJOtVFPjNVZug4FYowMy/ljL4qOmeyNKzs1ZEzgXHqmklYdsMlVgl2w?=
 =?us-ascii?Q?BYyrhdOIDxsdYBnZkE5Yh4LP9asyReb8OryfV8p0U8itiKHOoUSMpmf4sTg0?=
 =?us-ascii?Q?QxZ0/WKlodcpP231eZ8yrmDBOp228pMOPceWNkbt4xn5OVJnkzes9Hlxk4Wh?=
 =?us-ascii?Q?ZRzAoFNQS5et7u9j2meUX0my6/PZi+NTUrWvKkv+TzBhNwm6C96FomKR3i05?=
 =?us-ascii?Q?ZzHc3HMrq4JXa5mRur16TU1lP1VGznlXhjf5QpWLWSdjFiOc+qkLpHO1V0MT?=
 =?us-ascii?Q?5WL7oiFa4TA6olP8jKILGmenjfwzkzJ4DpT2iLEd8WDv29mL/WKO1oBTQPjV?=
 =?us-ascii?Q?ereNpcJdTzJ7U2LpDP54PrzOuB7mGpkRKfSeZquP0t3thGUVBHX+YtY1stzO?=
 =?us-ascii?Q?OK16ms/F5DNPAlzTCxyWSGiXyRNaQwvDs5IN+bII+am3cGmCAq7KoVCeS53A?=
 =?us-ascii?Q?VtV/creh2HYBlQ7iirCSKfE4z27CW5XchSHPn6BI29eaHiAo2FvxQR4DYBUF?=
 =?us-ascii?Q?CiZ62vM85NwAJC6dLo62T583A0spciwv6QUAxEUoX3EpjRNWVsWXRxKAVz2C?=
 =?us-ascii?Q?M1KOyXsjOeglIQWGuyHVWhYV8JiqQdnZZDSdjyCD40nMzhwOihA6wJBlCFi8?=
 =?us-ascii?Q?x6SCTVJj1fwrdjWql82t0+OfXcPO39+JQ3B5cjBVL4mX9itVMZz3BPqImpyr?=
 =?us-ascii?Q?771Y3VpLeDbKH4VRyC0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cafb1e22-23c4-4bed-c50c-08dce7499b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 03:30:49.9214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Enm+wg64oAGGm2Pipjh2B91ca59nv/c6jX7lKCtoAJ+dCqGr8DqmshlqzSh0AIAQ1oOHs+PRPZZST/HQw/qZhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8341



Best Regards,
Wei Fang
Hi Vladimir,

> >
> > On Sun, Sep 29, 2024 at 10:45:06AM +0800, Wei Fang wrote:
> > > When running "xdp-bench tx eno0" to test the XDP_TX feature of ENETC
> > > on LS1028A, it was found that if the command was re-run multiple time=
s,
> > > Rx could not receive the frames, and the result of xdo-bench showed
> > > that the rx rate was 0.
> > >
> > > root@ls1028ardb:~# ./xdp-bench tx eno0
> > > Hairpinning (XDP_TX) packets on eno0 (ifindex 3; driver fsl_enetc)
> > > Summary                      2046 rx/s                  0
> > err,drop/s
> > > Summary                         0 rx/s                  0
> > err,drop/s
> > > Summary                         0 rx/s                  0
> > err,drop/s
> > > Summary                         0 rx/s                  0
> > err,drop/s
> > >
> > > By observing the Rx PIR and CIR registers, we found that CIR is alway=
s
> > > equal to 0x7FF and PIR is always 0x7FE, which means that the Rx ring
> > > is full and can no longer accommodate other Rx frames. Therefore, we
> > > can conclude that the problem is caused by the Rx BD ring not being
> > > cleaned up.
> > >
> > > Further analysis of the code revealed that the Rx BD ring will only
> > > be cleaned if the "cleaned_cnt > xdp_tx_in_flight" condition is met.
> > > Therefore, some debug logs were added to the driver and the current
> > > values of cleaned_cnt and xdp_tx_in_flight were printed when the Rx
> > > BD ring was full. The logs are as follows.
> > >
> > > [  178.762419] [XDP TX] >> cleaned_cnt:1728, xdp_tx_in_flight:2140
> > > [  178.771387] [XDP TX] >> cleaned_cnt:1941, xdp_tx_in_flight:2110
> > > [  178.776058] [XDP TX] >> cleaned_cnt:1792, xdp_tx_in_flight:2110
> > >
> > > From the results, we can see that the max value of xdp_tx_in_flight
> > > has reached 2140. However, the size of the Rx BD ring is only 2048.
> > > This is incredible, so we checked the code again and found that
> > > xdp_tx_in_flight did not drop to 0 when the bpf program was uninstall=
ed
> > > and it was not reset when the bfp program was installed again. The
> > > root cause is that the IRQ is disabled too early in enetc_stop(),
> > > resulting in enetc_recycle_xdp_tx_buff() not being called, therefore,
> > > xdp_tx_in_flight is not cleared.
> > >
> > > Fixes: ff58fda09096 ("net: enetc: prioritize ability to go down over =
packet
> > processing")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > ---
> > > v2 changes:
> > > 1. Modify the titile and rephrase the commit meesage.
> > > 2. Use the new solution as described in the title
> > > ---
> >
> > I gave this another test under a bit different set of circumstances thi=
s time,
> > and I'm confident that there are still problems, which I haven't identi=
fied
> > though (yet).
> >
> > With 64 byte frames at 2.5 Gbps, I see this going on:
> >
> > $ xdp-bench tx eno0 &
> > $ while :; do taskset $((1 << 0)) hwstamp_ctl -i eno0 -r 1 && sleep 1 &=
&
> taskset
> > $((1 << 0)) hwstamp_ctl -i eno0 -r 0 && sleep 1; done
> > current settings:
> > tx_type 0
> > rx_filter 0
> > new settings:
> > tx_type 0
> > rx_filter 1
> > Summary                 1,556,952 rx/s                  0
> err,drop/s
> > Summary                         0 rx/s                  0
> err,drop/s
> > Summary                         0 rx/s                  0
> err,drop/s
> > current settings:
> > tx_type 0
> > rx_filter 1
> > Summary                         0 rx/s                  0
> err,drop/s
> > [  883.780346] fsl_enetc 0000:00:00.0 eno0: timeout for tx ring #6 clea=
r (its
> > RX ring has 2072 XDP_TX frames in flight)
> > new settings:
> > tx_type 0
> > rx_filter 0
> > Summary                     1,027 rx/s                  0
> err,drop/s
> > current settings:
> > tx_type 0
> > rx_filter 0
> > Summary                         0 rx/s                  0
> err,drop/s
> >
> > which looks like the symptoms that the patch tries to solve.
> >
> > My previous testing was with 390 byte frames, and this did not happen.
> >
> > Please do not merge this.
>=20
> Oh, it looks like there are still some issues we don't know about. I did
> test using 64 bytes but not at that high of a rate. Also I didn't turn on
> timestamp. Anyway, I will try to reproduce the issue when I'm back to
> office next Tuesday. It would be nice if you can help find the root cause
> before next Tuesday, thanks!

I think the reason is that Rx BDRs are disabled when enetc_stop() is called=
,
but there are still many unprocessed frames on Rx BDR. These frames will
be processed by XDP program and put into Tx BDR. So enetc_wait_txbdr()
will timeout and cause xdp_tx_in_flight will not be cleared.

So based on this patch, we should add a separate patch, similar to the patc=
h
2 ("net: enetc: fix the issues of XDP_REDIRECT feature "), which prevents t=
he
XDP_TX frames from being put into Tx BDRs when the ENETC_TX_DOWN flag
is set. The new patch is shown below. After adding this new patch, I follow=
ed
your test steps and tested for more than 30 minutes, and the issue cannot b=
e
reproduced anymore (without this patch, this problem would be reproduced
within seconds).

--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1606,6 +1606,12 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr =
*rx_ring,
                        break;
                case XDP_TX:
                        tx_ring =3D priv->xdp_tx_ring[rx_ring->index];
+                       if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags))=
) {
+                               enetc_xdp_drop(rx_ring, orig_i, i);
+                               tx_ring->stats.xdp_tx_drops++;
+                               break;
+                       }
+
                        xdp_tx_bd_cnt =3D enetc_rx_swbd_to_xdp_tx_swbd(xdp_=
tx_arr,
                                                                     rx_rin=
g,
                                                                     orig_i=
, i);

