Return-Path: <bpf+bounces-79357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B61F4D38BAE
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 03:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53471304539C
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 02:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FCD2DECBF;
	Sat, 17 Jan 2026 02:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XDHfyA/B"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013067.outbound.protection.outlook.com [52.101.72.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11FF1F0991;
	Sat, 17 Jan 2026 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768617153; cv=fail; b=negHeavy1EbiHi48F16hZ1Bc3QoYRIpu8r3+6royA6tlgaL9r/E8dbYkSEtCDyKASFWVr43vGCcLSlM9/C5xRjmh1vyRo5kt5ukdNOeN2TY6iiqf+8kfCfXT/gqw64ocmHTKgCyAfTI1hHIFFMHloFcHLA4UNZdxV+31m4TjcZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768617153; c=relaxed/simple;
	bh=VRCcPQ+jcK8Pp9DzWoTpcFHdbw7iRUPBUOn9m2QKXLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X97ineI2MxPOiKHiCacxEoLA9wYtXBf7Lqbz+BfFFO1BAyNlNRdeojSUdCFzixIzTaehA/1J1Sq3r/ev+8vxQmgbUswWdblMey+YTxY697cdrXq3GBTrE/uMFV12ct8pmNzfqLvq/y07T7Ik+DZ2PZ1F5CsP01UZDDa8ffZjNNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XDHfyA/B; arc=fail smtp.client-ip=52.101.72.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiHgW3fr3LN/ewn0gzyjRrvz4CrLfJI9aDVjBI8QMUZNMQP0a2d/PJZmIhzso/j/e4A70Bmhvoi+lJCfEYOWEUHlUidCPuq9M9J1N831Pp8GS0113OfEf4D6CDJSr7NgKun3Opwwo6hB0PacRrf8kHg5XOnpR1LzxoeCO86bIamY+9BRDv9wOjUpfkmeN70f4IIHq3PNBC2BKrOA0+JITfm7OFJJNhH8lseflIu2Urrw5xCMtW30SdKQDyqRtyVcEUMdRKoh2OcnABz/f8i6YLYaYl58vRFBBr+0K0Cuf2waV/v9SLl03ddOvYDmx2DvjLP2PvoUNGX1vu8jMFH5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20KuMdVZVsqZ8oVI9q4Ohzq545Vg2yRgomw5hJm7mQs=;
 b=kui/2JNFSa8r0AEEbE/nqGKi2QCXuyfEBWokQt6+n3dM1hU0fFgQxnOGNg4TwqclHniwLh58whZbSaylSqZfUNHoi9Iwai3RezIVjJ6U6WhZpFJEaOIMRNqzcqFDzIVePNCBHaV8+qlrFQf27rxOAjK6lAAClYEOdJc0hsVaAo4nLcXvOZXBWoY/5cmD4IUspUz9kne+j0QnF7DhiMKmJ52i0w1zedsQL6xErpeRllrBJnzTZXMfFImWsjkM/I/r295iglLfiSK+lrcOdD9+6wd7+KDncaOgECXLTF19W8A3oyIr6G6PKI+KQU316N/Mvsfcmi+/DRbOcZzulZaTcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20KuMdVZVsqZ8oVI9q4Ohzq545Vg2yRgomw5hJm7mQs=;
 b=XDHfyA/BwEu6yB+OPEtqYfLofjgG5bWVxh7BNowkzXZrFvwPKXZQSyfKxUBQA9xzdak87LrncxwH5Fjolv1FtnOvqlil+nw4vV6tlAB2ygsAw4KJFRRnuI6Fy2FV8S8Pj8lxBmm130vy5qDrgnxZKvx5FEOo3C2En321wGN49MZS9imui3yo2SmvcWH1dztd//oHtTH/mB4HBZqRw8GparANU33kc27vLMVczzHFAA7wMm3PS5M38IIFgm1ey74OzSV6tvwaNRRfH3NJOHm+nZ9mR5M8lr/8dCwF5jBJwsZeehsxpjagiWDwJHHpXgG9TE0ql9f5eqFun+Znvg2/bA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Sat, 17 Jan
 2026 02:32:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Sat, 17 Jan 2026
 02:32:27 +0000
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
Subject: RE: [PATCH v2 net-next 06/14] net: fec: add fec_enet_rx_queue_xdp()
 for XDP path
Thread-Topic: [PATCH v2 net-next 06/14] net: fec: add fec_enet_rx_queue_xdp()
 for XDP path
Thread-Index: AQHchruLIZN3+WrV9EGzdEdzeL9cBLVU2NyAgADJziA=
Date: Sat, 17 Jan 2026 02:32:27 +0000
Message-ID:
 <PAXPR04MB85104C04A6B18F1DBB137ED6888AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
 <20260116074027.1603841-7-wei.fang@nxp.com>
 <aWpJAfYTvO4D/COp@lizhi-Precision-Tower-5810>
In-Reply-To: <aWpJAfYTvO4D/COp@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAWPR04MB10055:EE_
x-ms-office365-filtering-correlation-id: 23df8369-0ded-48a0-3df0-08de5570a82c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9BgdMmMqZbL0b51PHy5s0CQcOu3xhDJvyO7E3n8AUwzP6RkK4EA0fY+FtZvg?=
 =?us-ascii?Q?yJ/aK5f5ZIKwGVOi7MpsUmfdwqIFKlyo4zDbHqoE2njLqGCYA5wySwnNhzkE?=
 =?us-ascii?Q?VIIgSGZ3h/enO9tIFANVs6wuNm5SNr8JG2BSv8i1k3y2GTnCPQWmbYymKq89?=
 =?us-ascii?Q?/XOS7Wx1nzM3T0mqtxOD2t2mYd9dmHUafBOnHlObABzu2Ip1dTh0zXhG0CIN?=
 =?us-ascii?Q?Ptpdq/269K3vGkvjYuGk7kNIEKjlQT8l3GHMsNN6rrYXeClWHd3ZY96qTpRp?=
 =?us-ascii?Q?QFtPR5rAYW2hKvACSuTrBXIlhq2iE4Y2e0aL9r3AutgHABfLDxdIkhIysCpz?=
 =?us-ascii?Q?Vv+vBIEWoH8Di8KLbLqxb6Vw+2CaLGZxXvtHSNtk5Lf8LBDLJY4Hn10MUUpU?=
 =?us-ascii?Q?e38xTzbK7DzanifsN72rhmkP66nAUklWOAdLRxl67YzA6Dvnw3G4/bxRLyb8?=
 =?us-ascii?Q?aaMeW5ZB7cQy2yMyIKd+Pz1XIXGyFlbxz9pjPFIOBrNo3bi4HUlebQQ7Txao?=
 =?us-ascii?Q?2CLjKe5xgNco08O7uknCGFg4x1baUgFjLBlSmiupVQ0CJRcNHVf1TWDYz1kN?=
 =?us-ascii?Q?OcZdSvN4Su7sm1tw6Vf50NGWS4E2q4TWbALWJcrmUVG2fjMmoLRDEjd89maL?=
 =?us-ascii?Q?EQVv/dgEKxQyEK2wLcT52f/IKC+kZfZeEzsfoF+ktTLjmwTTYoJLcJexyMtX?=
 =?us-ascii?Q?/F2xNk+CKS0f8pdySxyikuT/3qHzmUh5/gBCb7/nQF0HhRCB9yg2S1xn4J99?=
 =?us-ascii?Q?Vu0pafo4Y7ulP8OwBJOzouEq92vJWzRcpzEMVYGY6vLnSP3hNHXGbe5WWnEC?=
 =?us-ascii?Q?bo5kM202MbEVdwHMSNrq3Z/voj5/nOILKcgNJm6WWamv7O5DucT86TS2biNw?=
 =?us-ascii?Q?iGi48gsfXlkdRDPYExPWhhr+wcoXhEkNnGQ4eaNP0FaAMIDbiQAyIGCcBQ8M?=
 =?us-ascii?Q?89AKv3Iwnee6HjRbdR0KytyTz1vKVdbG/aH8YONze3Hz1WDixATSbL+uNfK0?=
 =?us-ascii?Q?J+5L8MgvNvElc2iJhumGLhBrN+s0tamjaxTAqAmhJn7nZS5wbFao1QYBqD1I?=
 =?us-ascii?Q?sbzrm6fe9BuuXyrzW4sRFMRb35ACcHJA7DL9aMWTVyNeVn0GmmR4fDRpGI1o?=
 =?us-ascii?Q?8rbnZMsf+M0xVKN9pTd3XA0BDqgH2pZVKwW+jvK46lLkT2Zrr+Skv+iVHoWw?=
 =?us-ascii?Q?JN+B8MDUoaKxemhi/GrpvrvxEaIeW/mdg+EmbjUg9GSt74giW081PfhEKkFI?=
 =?us-ascii?Q?6FQUw6TAyzqxQ1bB+0OvyTKE96deEPCjs+yYk3NBFmHKs4X4sP8sekDJEZrI?=
 =?us-ascii?Q?/g1j3fW+m5fqdKTcqGEj7oMLvbmoGlYqnjKNyd9dJYjon9xs+PFE7JUwM5A+?=
 =?us-ascii?Q?0TUz/bXoWljK+ZnxE+nXlMKK+/35gMZnn3LRvOiR/6/iBRUDj4t/6RjNSfe9?=
 =?us-ascii?Q?Rnd7iRayfqUaPjIKNrF1Zctmx2dgO5lnl88morvjG4p1kBidhGM9ql/waeDB?=
 =?us-ascii?Q?KPexE4slV+uD5E8eYmCcqJu+DZfFbdum1rTovp3R2/Lmwi12OhuEurRkcqmb?=
 =?us-ascii?Q?akAKj7rrOVxTLh5kDDTU7TD7LizkTcNyM1chromZK+bW8COnk2Z0oKErZEGb?=
 =?us-ascii?Q?1969APZj3+SfzKTTUM691Ec=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?emVVs99v+OIpl72G3XsW4XvVVx+5Z0P7bVeWvmz4zcq7c4PzVX+093QZFHXJ?=
 =?us-ascii?Q?6F/NvepoM1NmR46lV1Xx2AWdFRe2YtdcWizMY/+BMsago+VjdFlZx1QO8V+x?=
 =?us-ascii?Q?miqTKUEYYT790hU3yCHj7ELrvBrdLARPf0CqckaAxLT9T7JsnhwRVko5rc3H?=
 =?us-ascii?Q?HIJqTBRUxFhhLdyUyehuvhDOaBYyqSE0Eg1AEy6YWrPFBFxO+YemZRl1prus?=
 =?us-ascii?Q?aYn3QLAIqHCFU2MiZBFQgTH97w0nz/zqT+jRDMasdFY3m4P4M/vFz0sb4ubC?=
 =?us-ascii?Q?e/dB3EPeEORQ9pcGzxYjJ04d4nT3UKAMcbJwh0SUJICiBWP68oS/K5gfceIG?=
 =?us-ascii?Q?9c+sjRbW6s5d5s1ByLymBTQpJp1MynhwMkf/krBDGkAsafB02e0IAE+7xTc2?=
 =?us-ascii?Q?QgbQ2BYJ0uThJ6yN/wmWJLVrJpUv/U9fzyXpf0e+jq8HdoSMhJrXFoDraIXH?=
 =?us-ascii?Q?2SlEWN6QFnmN+vmc8M6osydLO44SUjvm+JBbpnmHnFvg5sFf8F91e+fpJzj4?=
 =?us-ascii?Q?xazcUUIN3VbszczG667KLgu4aKkvQQLlQCw9NkC2MGJTdTxWhbcEqVvnVU9P?=
 =?us-ascii?Q?Ov7a1/A9vTE0wJqIdGGylqFJcYjcK003tDbqaZlvbDA2GWbEo3vcvR8HqtZl?=
 =?us-ascii?Q?H3if/fCaXiYGt6KGWvCgzdsJ9Du1PN/0WURv16wCVMBKar1yERdFA3QzLXjm?=
 =?us-ascii?Q?c3EhxgyCXq2q6uGeVDwoU0PKOtLAMldHkuqN6cQ7NM8YXwaBvYCXpDY47lCI?=
 =?us-ascii?Q?f0mwxCPDCIPuVfpy6/Pm4dzhX738mpfxrF6CTaKgl0LCOUkdsh5w4G5MVcYD?=
 =?us-ascii?Q?ZjFu23CDSrEhlZEgXSVhr59LFF/LnLyck6+DE+O0lkyoqfSzIIjTXM/9H+tE?=
 =?us-ascii?Q?9yZ+cs+tsiGHXymnHirlX2LfZem7B+yNPWVgL1+MEMOC04SN5b8kE6n4hAtP?=
 =?us-ascii?Q?6NNGDoEXabY+NvBw9kVBVXo1HV6/NBYTuisiEWLnTkccaHG1MgVIiv6lx8aA?=
 =?us-ascii?Q?jrmfnWhMpX7k0qvCXAGIhOmvhdG3e2U8I4xgEvBz9iU54lXTSkvJT9njPlON?=
 =?us-ascii?Q?1SWJDnNa0DzeY2Ok8RzzNYryCRuozqFFMH4tqK1lG/E2don+Nj4f4zwxSODs?=
 =?us-ascii?Q?sq1R1Ot9e1HaoqQmRQuHdUy8mQ1dQ0E0bHOf9jaanab/BrPzir0MyK6+t5rU?=
 =?us-ascii?Q?qWFlGWVzJU0dtcqq15L00nnQos1u5piGyMBWN8F+uiGxQZr6Ux6cOA6in6nt?=
 =?us-ascii?Q?gIshQKfSTdmuypS1ayUtllURD1ExAM3TL35R4R3vHKratOCeB9beyOJviSmt?=
 =?us-ascii?Q?Sh3prW85eYy2f2IGi2yEVVrWM/zPwRRti1PIgm41jJm4YkWXJg/+i9LhrGSw?=
 =?us-ascii?Q?l0jJ8Ii4mM+3lUiVlKCTnViM90d630X6A7lEGR8DorgVX17hl4DUEyHbAAcY?=
 =?us-ascii?Q?5Tb3sEYOgzAcdNo2vnTzLFzph188jYotOwX35sFXHO749UwTbdomQxg4Ayti?=
 =?us-ascii?Q?ZBZ+PYi4pzZ3MXgJvyjqYndTzKghqfp/tP+SPPjDMJ15bGWV1dvseTv8MT6r?=
 =?us-ascii?Q?H2rrs/twaWk3mM2N30foYVtsl3H0rrrQ27Ftm62VqMh8xFaZhGVj7Bn809AD?=
 =?us-ascii?Q?XcusyJpqu++GgQRy3PYgO2c21HyMnmZLw7UjkVnBcavFTN0l4pI3dumbFQtg?=
 =?us-ascii?Q?BvF2AyHHa8TmUTBPr8iO8DDfcPaAXpL2DqG76qHaOPwgMB1K?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23df8369-0ded-48a0-3df0-08de5570a82c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2026 02:32:27.9020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvf3Sp4h6FKpP5edmsWSsmgbNIMPQiO0f1tQ/qIWMK3F2yC6LzV1R+TX+ZbYQRguj+htImLR6Ag13CwUMQHJpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055

> > +static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int que=
ue,
> > +				 int budget, struct bpf_prog *prog)
> > +{
> > +	u32 data_start =3D FEC_ENET_XDP_HEADROOM + fep->rx_shift;
> > +	struct fec_enet_priv_rx_q *rxq =3D fep->rx_queue[queue];
> > +	struct net_device *ndev =3D fep->netdev;
> > +	struct bufdesc *bdp =3D rxq->bd.cur;
> > +	u32 sub_len =3D 4 + fep->rx_shift;
> > +	int cpu =3D smp_processor_id();
> > +	int pkt_received =3D 0;
> > +	struct sk_buff *skb;
> > +	u16 status, pkt_len;
> > +	struct xdp_buff xdp;
> > +	int tx_qid =3D queue;
> > +	struct page *page;
> > +	u32 xdp_res =3D 0;
> > +	dma_addr_t dma;
> > +	int index, err;
> > +	u32 act, sync;
> > +
> > +#if defined(CONFIG_COLDFIRE)
> && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
> > +	/*
> > +	 * Hacky flush of all caches instead of using the DMA API for the TSO
> > +	 * headers.
> > +	 */
> > +	flush_cache_all();
> > +#endif
> > +
> > +	if (unlikely(queue >=3D fep->num_tx_queues))
> > +		tx_qid =3D fec_enet_xdp_get_tx_queue(fep, cpu);
> > +
> > +	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
> > +
> > +	while (!((status =3D fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) =
{
> > +		if (pkt_received >=3D budget)
> > +			break;
> > +		pkt_received++;
> > +
> > +		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
> > +
> > +		/* Check for errors. */
> > +		status ^=3D BD_ENET_RX_LAST;
> > +		if (unlikely(fec_rx_error_check(ndev, status)))
> > +			goto rx_processing_done;
> > +
> > +		/* Process the incoming frame. */
> > +		ndev->stats.rx_packets++;
> > +		pkt_len =3D fec16_to_cpu(bdp->cbd_datlen);
> > +		ndev->stats.rx_bytes +=3D pkt_len - fep->rx_shift;
> > +
> > +		index =3D fec_enet_get_bd_index(bdp, &rxq->bd);
> > +		page =3D rxq->rx_buf[index];
> > +		dma =3D fec32_to_cpu(bdp->cbd_bufaddr);
> > +
> > +		if (fec_enet_update_cbd(rxq, bdp, index)) {
> > +			ndev->stats.rx_dropped++;
> > +			goto rx_processing_done;
> > +		}
> > +
> > +		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
> > +					DMA_FROM_DEVICE);
> > +		prefetch(page_address(page));
> > +
> > +		xdp_buff_clear_frags_flag(&xdp);
> > +		/* subtract 16bit shift and FCS */
> > +		pkt_len -=3D sub_len;
> > +		xdp_prepare_buff(&xdp, page_address(page), data_start,
> > +				 pkt_len, false);
> > +
> > +		act =3D bpf_prog_run_xdp(prog, &xdp);
> > +		/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync
> > +		 * for_device cover max len CPU touch.
> > +		 */
> > +		sync =3D xdp.data_end - xdp.data;
> > +		sync =3D max(sync, pkt_len);
> > +
> > +		switch (act) {
> > +		case XDP_PASS:
> > +			rxq->stats[RX_XDP_PASS]++;
> > +			/* The packet length includes FCS, but we don't want to
> > +			 * include that when passing upstream as it messes up
> > +			 * bridging applications.
> > +			 */
> > +			skb =3D fec_build_skb(fep, rxq, bdp, page, pkt_len);
> > +			if (!skb) {
> > +				fec_xdp_drop(rxq, &xdp, sync);
> > +				trace_xdp_exception(ndev, prog, XDP_PASS);
> > +			} else {
> > +				napi_gro_receive(&fep->napi, skb);
> > +			}
> > +			break;
> > +		case XDP_REDIRECT:
> > +			rxq->stats[RX_XDP_REDIRECT]++;
> > +			err =3D xdp_do_redirect(ndev, &xdp, prog);
> > +			if (unlikely(err)) {
> > +				fec_xdp_drop(rxq, &xdp, sync);
> > +				trace_xdp_exception(ndev, prog, XDP_REDIRECT);
> > +			} else {
> > +				xdp_res |=3D FEC_ENET_XDP_REDIR;
> > +			}
> > +			break;
> > +		case XDP_TX:
> > +			rxq->stats[RX_XDP_TX]++;
> > +			err =3D fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync, tx_qid);
> > +			if (unlikely(err)) {
> > +				rxq->stats[RX_XDP_TX_ERRORS]++;
> > +				fec_xdp_drop(rxq, &xdp, sync);
> > +				trace_xdp_exception(ndev, prog, XDP_TX);
> > +			}
> > +			break;
> > +		default:
> > +			bpf_warn_invalid_xdp_action(ndev, prog, act);
> > +			fallthrough;
> > +		case XDP_ABORTED:
> > +			/* handle aborts by dropping packet */
> > +			fallthrough;
> > +		case XDP_DROP:
> > +			rxq->stats[RX_XDP_DROP]++;
> > +			fec_xdp_drop(rxq, &xdp, sync);
> > +			break;
> > +		}
> > +
> > +rx_processing_done:
> > +		/* Clear the status flags for this buffer */
> > +		status &=3D ~BD_ENET_RX_STATS;
> > +		/* Mark the buffer empty */
> > +		status |=3D BD_ENET_RX_EMPTY;
> > +
> > +		if (fep->bufdesc_ex) {
> > +			struct bufdesc_ex *ebdp =3D (struct bufdesc_ex *)bdp;
> > +
> > +			ebdp->cbd_esc =3D cpu_to_fec32(BD_ENET_RX_INT);
> > +			ebdp->cbd_prot =3D 0;
> > +			ebdp->cbd_bdu =3D 0;
> > +		}
> > +
> > +		/* Make sure the updates to rest of the descriptor are
> > +		 * performed before transferring ownership.
> > +		 */
> > +		dma_wmb();
> > +		bdp->cbd_sc =3D cpu_to_fec16(status);
> > +
> > +		/* Update BD pointer to next entry */
> > +		bdp =3D fec_enet_get_nextdesc(bdp, &rxq->bd);
> > +
> > +		/* Doing this here will keep the FEC running while we process
> > +		 * incoming frames. On a heavily loaded network, we should be
> > +		 * able to keep up at the expense of system resources.
> > +		 */
> > +		writel(0, rxq->bd.reg_desc_active);
> > +	}
> > +
> > +	rxq->bd.cur =3D bdp;
> > +
> > +	if (xdp_res & FEC_ENET_XDP_REDIR)
> >  		xdp_do_flush();
> >
> >  	return pkt_received;
> > @@ -1970,11 +2061,17 @@ static int fec_enet_rx_queue(struct
> fec_enet_private *fep,
> >  static int fec_enet_rx(struct net_device *ndev, int budget)
> >  {
> >  	struct fec_enet_private *fep =3D netdev_priv(ndev);
> > +	struct bpf_prog *prog =3D READ_ONCE(fep->xdp_prog);
> >  	int i, done =3D 0;
> >
> >  	/* Make sure that AVB queues are processed first. */
> > -	for (i =3D fep->num_rx_queues - 1; i >=3D 0; i--)
> > -		done +=3D fec_enet_rx_queue(fep, i, budget - done);
> > +	for (i =3D fep->num_rx_queues - 1; i >=3D 0; i--) {
> > +		if (prog)
> > +			done +=3D fec_enet_rx_queue_xdp(fep, i, budget - done,
> > +						      prog);
>=20
> Patch still is hard to review. It may be simpe if
> 1. create new patch cp fec_enet_rx_queue() to fec_enet_rx_queue_xdp().
> 2. the change may small if base on 1.
>=20

fec_enet_rx_queue_xdp() is basically the same as fec_enet_rx_queue(),
the biggest difference is probably the removal of the fec_enet_run_xdp()
function and the relocation of its code to fec_enet_rx_queue_xdp().

The current patch set already has 14 patches, which is close to the
15-patch limit. I would like to leave the last new patch for the comment
below, because it does indeed differ somewhat from the previous logic.

> > +		else
> > +			done +=3D fec_enet_rx_queue(fep, i, budget - done);
> > +	}
> >
> >  	return done;
> >  }
> > @@ -3854,15 +3951,6 @@ static int fec_enet_bpf(struct net_device *dev,
> struct netdev_bpf *bpf)
> >  	}
> >  }
> >
> > -static int
> > -fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
> > -{
> > -	if (unlikely(index < 0))
> > -		return 0;
> > -
> > -	return (index % fep->num_tx_queues);
> > -}
> > -
> >  static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
> >  				   struct fec_enet_priv_tx_q *txq,
> >  				   void *frame, u32 dma_sync_len,
> > @@ -3956,15 +4044,11 @@ static int fec_enet_txq_xmit_frame(struct
> fec_enet_private *fep,
> >
> >  static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
> >  				int cpu, struct xdp_buff *xdp,
> > -				u32 dma_sync_len)
> > +				u32 dma_sync_len, int queue)
>=20
> you can split it new patch, just add queue id at fec_enet_xdp_tx_xmit().
>=20

Yes, this is a new change to the previous logic, I will add a new patch.


