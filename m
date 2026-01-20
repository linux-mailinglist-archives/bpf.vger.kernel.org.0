Return-Path: <bpf+bounces-79556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F495D3BF62
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3DDA383392
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 06:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA631D367;
	Tue, 20 Jan 2026 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QOdI1KIk"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D4036C5B6;
	Tue, 20 Jan 2026 06:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891205; cv=fail; b=dwFK2UgXVdqPFnDynaGF0KmJlCzUvRwwoeFG+Ja3SaK0dgG42lnyn+IqHjLbsoYZQwGuWuwAM8xOdIY7iS1VNNrR9dFafQS3cjtBbiCUYQAR5ugz/AiSZ1Js67otzXkR+0OpxIiras3JiR3LgVZSU9juRY6iMCcJrMNPSqJmpxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891205; c=relaxed/simple;
	bh=ilC+ovBnaMo0G3mmyY6R6FPViyJYbMUa0TYmdUzPlPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GfLKznuGjRB9n+RnOTSLR6NUaP+Bq5WKpjBdpdMOE9ckwgL7euD/3uEUvx+6mbSazmK3LG/tXJyKwwAovJ8lJbXRccxnikn41WATZN/mVTsrNhPxiEf4qK+gxO/F7y3Y7yaxXyuwKkO6RQ/IcABRRdXGaTU99CTPZ9cpZxLhMRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QOdI1KIk; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvCreLr3iQJTXzpg4R2g0nU45PzD1+bVGMvGPPsjod31mWnBLqjL1xIqySjo8k2Z/8uhsCeopcT4r6YcITY7vv8JnIvIXBiidWVkdKy5ACt/siERZLeX6Sht1vdu8pdg515MJBisOle1WlH/kmMWdbYqr8e3UoN4ksiUlLqdNZE5DzX0wRYUPtn68/aFR5c7AxKy5oPq3K67fNxylP8JANYpOuJqmnRakKIG2GPe/N5SShwYs/923kpwoUE6xhX1umy4U/ZbMqhUJkJgcZWNeOJk3k2NqCu6wPYnXjsVEx6nKvgDjzgsxZs5sD/SPIMqiRZjbfANOdMzeJZ8pGoKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyDlZlq3PAGN4znyX40PQIlRDtSmg9bK9fqQmqqtEyc=;
 b=XyEcTUImu2gC81baI/hT5W3qR/TtU2VHUnwYHeA4ZSlQy4DXrxS6RFuIZ7E/4+b7xwVTrKEbSGH6BwNffLPzQo8WS49gpnTnS2rmrdl4g9IuLUpRZhF+NMYCUA1PUjZCk43D8sl8bGGb9RXQaqNA/yN24uKGlf6teDBolZ8SxQUA3rHJ1l+ocC4nXYLAnsJ5zx3/EAAkk8fQ39Wo3j9F2dylu4/X2wm/ENTqBX7PHh97hfsLB0sIgwzUCSCySaZy9fydPdq4qZDGNS2B9tkdHfWjheh6VGo51wB2nDP9u6xhhHN2pFUNvDjpj29Kv7fsae3cScUoHnEacxPVRyi01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyDlZlq3PAGN4znyX40PQIlRDtSmg9bK9fqQmqqtEyc=;
 b=QOdI1KIkfsixB7vGFNbDzAwQgWc4Htcmhn5SlwUajo9Mtadp4zGyMTOmxMoDy0avrIO9XT3GPi2dUTN2ykIxrgyZsS2f4ZAAeAE6dF6LTxRa+TcaS1w7B1byGCEDx8wUmWDQ6aE99llXFhxOcdYC/sTgd/F38KwcgEPGln5pqvPSyW7xr0JOiOvRMSznKZ+z41AojU05M97z6ubqoh0FjcGL3V+a03cAaYWJvwimJmBr4Ke+cvHOpvHOCZ1CGr+NRE8ensxfdwkFVj8JBLWJJTxahuvorB4Jm0yTaEv0homaSWKo5AgNUqeXCUrT0p7zzdkxBLNM0NSdB1r6VSw62w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10719.eurprd04.prod.outlook.com (2603:10a6:10:580::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 06:39:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 20 Jan 2026
 06:39:56 +0000
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
Subject: RE: [PATCH v2 net-next 11/14] net: fec: move xdp_rxq_info* APIs out
 of fec_enet_create_page_pool()
Thread-Topic: [PATCH v2 net-next 11/14] net: fec: move xdp_rxq_info* APIs out
 of fec_enet_create_page_pool()
Thread-Index: AQHchruZHig4uKtl7kWIN9k9boa+HbVU3NuAgAXCtoA=
Date: Tue, 20 Jan 2026 06:39:56 +0000
Message-ID:
 <PAXPR04MB8510D091184E33C4CD91A2D48889A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
 <20260116074027.1603841-12-wei.fang@nxp.com>
 <aWpMW+jgIJpqH8NE@lizhi-Precision-Tower-5810>
In-Reply-To: <aWpMW+jgIJpqH8NE@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU4PR04MB10719:EE_
x-ms-office365-filtering-correlation-id: 21ef00a1-0d59-4cde-0d1d-08de57eeb9da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CvtFf36Xba9rIrnGAzi/AYCg4lhRZ91VVSEJvIMBgYix28NtkI0rYe1+glto?=
 =?us-ascii?Q?NHr3x9xKRz2Frxecjmb1VRQpnXz3ckMiv8uL38H3z+CSkwIxggtqr/0Ts3zc?=
 =?us-ascii?Q?wK5fA3DmtyArKjFmmh1JYGhq+G8W2YHwIzYEDIYJZ4wMnxDUDidFaeSBqUFG?=
 =?us-ascii?Q?2K/CSbAtFgqBOU/54ESAyxjQfUVU4yYrHmtwC9ru4TgoKigJds5L2X9wpvzV?=
 =?us-ascii?Q?u8UJ9ZJFp4GhDwWGqG/ymUlmiOVQstxmAlNjmhOEv565u8WO6zlrnpJuzKve?=
 =?us-ascii?Q?PkpIPxR2WCiaehHIyYyhZV1kWTskc0KuIDIwQm+Fh+OxNf9HJTINzMTMKcDS?=
 =?us-ascii?Q?MmnxDT/hTr86SlyRW63MaLztl1W4E9sXLsweRSNxlpTT/rNBzdEPJkeBRHtm?=
 =?us-ascii?Q?aPiVkdUxgVjdM0CqNnxQo5pP7tq9OryexpRm9MDJbWoWFVbrVS4pluiWqOzb?=
 =?us-ascii?Q?cMCyx1xDpQoDK3KC72Jns0aYCkzv5Zpc7OjrPXGTws6/Mm7dJhZvF987cMk7?=
 =?us-ascii?Q?9/63gaOqlMyUWJjFsPR5OF+TH4LV9DV9iMpCAz+DzDVGqYxe0cCma0mGTBOB?=
 =?us-ascii?Q?2qWHkbJvHy9HMo7V0XWnHp5InYnyVG1zw/yuGPQ58iReRkpghtFIi32QxpzT?=
 =?us-ascii?Q?WtooU8hDv+9nhXq5MolqETArRUgFe0ewnInmOEco8uExyjdz+vgpDWae9452?=
 =?us-ascii?Q?QUNCpMp/hS6CfbPXf88a4oKVzAUAg5fkA4GWqp6DmBcIaANBP1SKbs0z/p55?=
 =?us-ascii?Q?GUsguHmUdn80Gt+wDkvcv7DDhdzO/fEFIlnhpEBz8GUuOfb5MXalgNjNVG1h?=
 =?us-ascii?Q?ewo30e55IbwC7VFgKDwoxr+8dB8K4nWPltME9N2XD5u8PB5bhF1cBEocyK32?=
 =?us-ascii?Q?yXNiecEB9i8Qwvm7/RgfxgCIVuSvObFeHpPEe2U+4dnru5h4ic9X5Q+oDJDT?=
 =?us-ascii?Q?blX+8nhTsUGTNqiqOlUzi8xUqiQNWM8HFy+pQsqqY4kvWYYAtY7OUPfu07J1?=
 =?us-ascii?Q?kqepVNqPQy//jVGBD1AstEVuorR+nPNC8zsZf8zgsxRJ26dlgpnG8ssGKZWx?=
 =?us-ascii?Q?njwRpnq5TDA31iyfKb87tOOBf3i3PEyDYfpwKM1m2Vt1YM8LFOqah+3APBZp?=
 =?us-ascii?Q?Wa/hZTok4ehhYSzzDkkBFtBUQyP9Kftc0NKbPXW75dU/u6p58x1BWrcXVr9Q?=
 =?us-ascii?Q?5zMc/fmEHOZx8Imp74KZiQ10RAVBhosE7/PLRsB12n2vWELSighM46q/nt+3?=
 =?us-ascii?Q?S4n9koNARWZKFsD7aQv9ScFochwifQzoLTQ0T4Yn4s1U9LfoyFT4yPd1SynB?=
 =?us-ascii?Q?zYc6G38ihhc8dQag3gZam5D1XKx19h5TlRv5+KeqHd5Em4UMld0HJBtylz9G?=
 =?us-ascii?Q?hmYRvYsldQa0LmCPAzgeri1YGeR1UBbpCK2NEO+uRn7ICMx8Wvshhus+eulr?=
 =?us-ascii?Q?55bvuxC6llGRE18rmBafaub7cd7PCUj7wqZbn3gR/FsJWQURVB5lgr/jRSZL?=
 =?us-ascii?Q?1LoP3G+kinRTRwpicKlmif092CjhgwCSzcOnk9WVS/V+9bCUH7k21srh6jQb?=
 =?us-ascii?Q?SzzIG0FRGY5VZ4zPQ1tjFq6d9M/YIK5lGSORva7vf2MtaprUdWdLqNF7FC8U?=
 =?us-ascii?Q?a0es2hTCgIv29MPXVP5fcLY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gYPP+n5myPEHHZADiNhmCKuE7SNEipBKa776THpzIhGbXeykDnK6ZraXae7G?=
 =?us-ascii?Q?OxQ1wADjEKnm73CQaolvX9S/bHQDHqGh4LO9iROZaLrM3W5KTMQRe+7T0ZiM?=
 =?us-ascii?Q?kgr66bWC2mAJbcskuTdATQjX/aA6kIAlu1RdGCO8LqiJlOZ7d8d1PsPXkF9Q?=
 =?us-ascii?Q?XCZ7HzvSZ/XIr/6uPGIonE9Xlc1V0aeJAmrmbi7jLIFJgML5qGaOGd4cVL6/?=
 =?us-ascii?Q?kQC0r5P+ARtWGyaX63qu7bIphTYXuFWe2Qff6CrIsTznz8M9UOs/Zh1AJ50l?=
 =?us-ascii?Q?i0T8K0tleVSto5YP4M5lA6YhHtbLjgoGqI31+6UfBspDKc42UumOZD0OQaAX?=
 =?us-ascii?Q?VuueCcoXTz+RmQUB3v1MZfBVvoyZhzPVSr112CjTkgaL3cUfvTe+OIMFitPG?=
 =?us-ascii?Q?zTLDbyw8Hvaz8iV5hFtRWYr9ovozNjjhuOU/7NutnjUr3bIiK6MwPjDzO+eb?=
 =?us-ascii?Q?gyLdWqvzMUVxjeqUDI3UEzNoQCFXM2M/b6bVD4eLHpD8xeWN/JKdIdjOVthf?=
 =?us-ascii?Q?sMnMQaHNdowapzIXPlG5ELeCxaj8+2IXAsR8ycVLxORFjkpAaaecOEFlWa66?=
 =?us-ascii?Q?yKNNMklGqC3eIGGdFNhpA6thadWIMwcFOeDNXdI+7vze+/PewLyzWSxQ4nZO?=
 =?us-ascii?Q?Wv61N6ZFOcxS+77L90U+BS8i2/oLSyPkTlL0yS2rkbVNDeNo90PbiCLd7etI?=
 =?us-ascii?Q?Kz9TLnJHBbm3Uu4rhtFw6xLFDd9rzY95NG2I2VfK8ksywwwU2GqtzqRHonUZ?=
 =?us-ascii?Q?qxswLBckV+lLKUzQ0nFWJTpLNscdc80TA3gdfMrw9KmIUcIS6/zWrg/yU7iF?=
 =?us-ascii?Q?QTMQKn8z+Rbjt6Yc/GL16k1e2ceDmTJh5Ore3RALvAje21RM2Bagi5vD/CAI?=
 =?us-ascii?Q?9IAd5sfP4CbTvTSJtIAZ18HQqE8Sn+Oaw4HoHoPjWNjSiNOoLZc4VredWusB?=
 =?us-ascii?Q?qSeip2MnqGMCkDJfaB4WUAbuZTD1pD7b3px2QdYTK6NQx2BLYV2D0AcB51+q?=
 =?us-ascii?Q?hGXfeln8T8HWN/oVxe7hpLhgJVSR7idsLrb3lLkY4r25tAoK98oC3aNbPs5g?=
 =?us-ascii?Q?hiy7fkfQ0tcpImJMRpRBFrjpDNks7NggAwQD9j3jXqYoF48pFaaeUdiSxNX6?=
 =?us-ascii?Q?U8i2EXxcRdEYgPLLH74p/c3skxSatx7zN8S8yPV34NT4AhhBSxhLoyKPhPiY?=
 =?us-ascii?Q?dIRq5tqB3tOmoU871/UatR14T/1TQpcQDe6KS673BkxyYmLsJOMTXx/CEU7m?=
 =?us-ascii?Q?BIZIqilHxpzAlyQMakOu2uhpAlQ5mS4XCK0IhP63c9LO88UnPSy0WAya3y2D?=
 =?us-ascii?Q?NxMWgSLbMEtUlrIOiIfz86kx725f6iIG40sCnyuajv1eFEZrVUK1fx3O+YLv?=
 =?us-ascii?Q?TGOoODi5LOAhMYg1vbcBF+aNcWRiyXN/Ww9G1s4g8tpyDqOponKtZ+87lwrj?=
 =?us-ascii?Q?1jQTpSp7YUuPv/5kAs4nQLQ7F/S8/NH048ASLKa88ziRMm/3obJC3Y3D5Afd?=
 =?us-ascii?Q?xvu0GnjJGnIYT/3Scd2se872baNbVAz5F1huqmsfLb44VwaBBVSDXPOrEzz2?=
 =?us-ascii?Q?U08tENPa+0B+tXe1WaUlxszdv5t4321GPFS0nDtfG+uvA/6rIZ89O1HzD9+P?=
 =?us-ascii?Q?abnI9rCWsS7LFlNU0gr7QdUJR+QKPbsDqvxwaR97loIHfIHlnilkpoeVcmeJ?=
 =?us-ascii?Q?FR2hFPPTfTpXNOwjOLZii2sTq+9qBo6RLvWGpB+WdpDc6fBP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ef00a1-0d59-4cde-0d1d-08de57eeb9da
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 06:39:56.4856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RFqHl6+nGJCPqCfs6VU9M5pLUNC7kU1Vx/h2stEwYY+mHU0C1nYSr6YEjTa+kYFXC0T1e4dMJQiNsGa3w47BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10719

> On Fri, Jan 16, 2026 at 03:40:24PM +0800, Wei Fang wrote:
> > Extract fec_xdp_rxq_info_reg() from fec_enet_create_page_pool() and mov=
e
> > it out of fec_enet_create_page_pool(), so that it can be reused in the
> > subsequent patches to support XDP zero copy mode.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++++-------
> >  1 file changed, 40 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> > index c1786ccf0443..a418f0153d43 100644
> > --- a/drivers/net/ethernet/freescale/fec_main.c
> > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > @@ -489,23 +489,7 @@ fec_enet_create_page_pool(struct
> fec_enet_private *fep,
> >  		return err;
> >  	}
> >
> > -	err =3D xdp_rxq_info_reg(&rxq->xdp_rxq, fep->netdev, rxq->id, 0);
> > -	if (err < 0)
> > -		goto err_free_pp;
> > -
> > -	err =3D xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq,
> MEM_TYPE_PAGE_POOL,
> > -					 rxq->page_pool);
> > -	if (err)
> > -		goto err_unregister_rxq;
> > -
> >  	return 0;
> > -
> > -err_unregister_rxq:
> > -	xdp_rxq_info_unreg(&rxq->xdp_rxq);
> > -err_free_pp:
> > -	page_pool_destroy(rxq->page_pool);
> > -	rxq->page_pool =3D NULL;
> > -	return err;
>=20
> Noramlly this patch should put helper fec_xdp_rxq_info_reg() before
> fec_enet_create_page_pool(). then call fec_xdp_rxq_info_reg() here.

The main purpose of this patch is to move the xdp-related logic out of
fec_enet_create_page_pool(), so there is no need to use two patches
to solve such a trivial matter.

>=20
> >  }
> >
> >  static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
> > @@ -3419,6 +3403,38 @@ static const struct ethtool_ops
> fec_enet_ethtool_ops =3D {
> >  	.self_test		=3D net_selftest,
> >  };
> >
> > +static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
> > +				struct fec_enet_priv_rx_q *rxq)
> > +{
> > +	struct net_device *ndev =3D fep->netdev;
> > +	int err;
> > +
> > +	err =3D xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq->id, 0);
> > +	if (err) {
> > +		netdev_err(ndev, "Failed to register xdp rxq info\n");
> > +		return err;
> > +	}
> > +
> > +	err =3D xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq,
> MEM_TYPE_PAGE_POOL,
> > +					 rxq->page_pool);
> > +	if (err) {
> > +		netdev_err(ndev, "Failed to register XDP mem model\n");
> > +		xdp_rxq_info_unreg(&rxq->xdp_rxq);
> > +
> > +		return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
> > +{
> > +	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq)) {
> > +		xdp_rxq_info_unreg_mem_model(&rxq->xdp_rxq);
> > +		xdp_rxq_info_unreg(&rxq->xdp_rxq);
> > +	}
> > +}
> > +
> >  static void fec_enet_free_buffers(struct net_device *ndev)
> >  {
> >  	struct fec_enet_private *fep =3D netdev_priv(ndev);
> > @@ -3430,6 +3446,9 @@ static void fec_enet_free_buffers(struct net_devi=
ce
> *ndev)
> >
> >  	for (q =3D 0; q < fep->num_rx_queues; q++) {
> >  		rxq =3D fep->rx_queue[q];
> > +
> > +		fec_xdp_rxq_info_unreg(rxq);
> > +
> >  		for (i =3D 0; i < rxq->bd.ring_size; i++)
> >  			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
> >  						false);
> > @@ -3437,8 +3456,6 @@ static void fec_enet_free_buffers(struct net_devi=
ce
> *ndev)
> >  		for (i =3D 0; i < XDP_STATS_TOTAL; i++)
> >  			rxq->stats[i] =3D 0;
> >
> > -		if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
> > -			xdp_rxq_info_unreg(&rxq->xdp_rxq);
>=20
> why put fec_xdp_rxq_info_unreg() here to do exactly replacement.
>=20

It's fine to put it in the original position, the only reason is that I wan=
t
the order to be reversed from that in fec_enet_alloc_rxq_buffers().

> Frank
> >  		page_pool_destroy(rxq->page_pool);
> >  		rxq->page_pool =3D NULL;
> >  	}
> > @@ -3593,6 +3610,11 @@ fec_enet_alloc_rxq_buffers(struct net_device
> *ndev, unsigned int queue)
> >  	/* Set the last buffer to wrap. */
> >  	bdp =3D fec_enet_get_prevdesc(bdp, &rxq->bd);
> >  	bdp->cbd_sc |=3D cpu_to_fec16(BD_ENET_RX_WRAP);
> > +
> > +	err =3D fec_xdp_rxq_info_reg(fep, rxq);
> > +	if (err)
> > +		goto err_alloc;
> > +
> >  	return 0;
> >
> >   err_alloc:
> > --
> > 2.34.1
> >

