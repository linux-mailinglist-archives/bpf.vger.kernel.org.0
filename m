Return-Path: <bpf+bounces-77465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C290BCE5E00
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 04:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14C243004CBD
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 03:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32597274B44;
	Mon, 29 Dec 2025 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nC3TTDnT"
X-Original-To: bpf@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013056.outbound.protection.outlook.com [52.101.83.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC092264A9;
	Mon, 29 Dec 2025 03:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766979723; cv=fail; b=evsjtmCYktPJafva/LRyu1tWJUGAwyadT4CyqHgrECpouwCJv77rNIEIFsPe+aWLAoQi1F6tvyR76Gxno2EwV9NQzK+MvLrs2wcQUpy+RM06y0WfV29Y6hObXwwRNBfAtChXZyNrLsgQ6Vd5NUYyL//pBO/rp3UblGxA/Uo4038=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766979723; c=relaxed/simple;
	bh=rCRMN/6LQfu2j2w5FKf/QFHngZ7ha9Tk+U8RZCnmasg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XG0ds3X7u3SFlP/C7hJvJ8vTKZLaNVJ/f+ctEuGgoZ+tphrF9ewSj798raCKtyZkiBKDcUcxoz3K0Xk65kdAEesCsx8Sc6VM7lIZE7GDsytTcvMPk8jOZFYHEXootCJYetfdnK9FS2sk1rOaLRJoWK7rpOcMjIRhKwePyYorCUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nC3TTDnT; arc=fail smtp.client-ip=52.101.83.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iW32okuLxG2gTM/exR2PKTRVwo5M+6No/NEYwZL7C2Z1ZHdI507iuE5+jVR8v+aeICfQq3c1AviEexnaZPI2yMG3z6oWCnUbPXGO1MVlb50xvEVuACN6JOd68329KXVrJRwCY55Ngqj3rmhMUqJrAFvDk4A7FQx4Z7wPBPmWzPYL/SwTLyj1kLyRn9tTNlHKL2t8JzdhzzAXdrYZkdFkx1oiw1RRfC5CmNtTiIx+F3tClZr8cEoQItYUAozfvx557MMD6HrKocqbtfev+aVdZcz4Oi1eAsMrC1v+jAKaO0EhJy555EFKhL3qt1uoDP8Zewc0AdfrN5f6/vQGFpobpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05vngKVz4lfpFdy+8zts3aFlxXn+rugFVSknSHjzbrU=;
 b=YcblN40bG/rN1bONOkeXjqlTy3+VVrnMbBWiOLY6liFkFID5hlqx7IMQGg93SnSzBOzswA5osP7c9M0/dTljCHpb7SdHvNRU7njIoZL2ZACAAWRN3aSwv1ST4zveqhvME1GzeNB0CtOXNIsuJxGd3m5bcuGb7mQW1mo8m6Q6jBDJAxET9JqaH69DZNFnEvJMrgniFHhsmsXDfRYu5JyWa8s52jO8ISRPPmCSWjZse6JPEjojLrx3RH/kfge36mF986tQIE/NVG+/kV5t9OgNLAiR3EBENuslvR/mRqelNGvSJLqWGLXVtSdWuaPAXKcRd9uV96rUbrB+Ughim6P0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05vngKVz4lfpFdy+8zts3aFlxXn+rugFVSknSHjzbrU=;
 b=nC3TTDnTcNbNas0x32NrzTUPDTfV/qKCKcuNoQX8TfpIoxb2SnDdzsw3RsCltBYBkTD2XPzkftDOdNQcM672I4Uaf4IXLrxYI2l4nrGrr2ThNOVmjiEsVSI4xZ9j3RcQq+itYiAYU/dpjRSm/ZqHSU4R9ZBAefFR/rHtggFCjYbhjHcKjMsBvyiVps4bBz3JqaQeLBQ7hOBbOuEMW0vimnpsyDOxP15hROyyQY8kvB3BoQXx8znTvlcrFoUyCxWrJjEN9J1rcIvDAc2NCE83Dg48v3Bb3HfPvUvOlqhkU12LA3eNM5so7QtLPOGqNTOEt86qBZPxBats0y3SYh9fuA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB11456.eurprd04.prod.outlook.com (2603:10a6:102:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 03:41:58 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 03:41:58 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>, "alexandre.torgue@foss.st.com"
	<alexandre.torgue@foss.st.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "rmk+kernel@armlinux.org.uk"
	<rmk+kernel@armlinux.org.uk>, "0x1207@gmail.com" <0x1207@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, "boon.leong.ong@intel.com"
	<boon.leong.ong@intel.com>, "edumazet@google.com" <edumazet@google.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [PATCH net] net: stmmac: fix the crash issue for zero copy XDP_TX
 action
Thread-Topic: [PATCH net] net: stmmac: fix the crash issue for zero copy
 XDP_TX action
Thread-Index: AQHcZO1pj0nep9pNq02KfA412DHJhbU4H4qg
Date: Mon, 29 Dec 2025 03:41:58 +0000
Message-ID:
 <PAXPR04MB8510BCFE90FBBBDF2915B89388BFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251204071332.1907111-1-wei.fang@nxp.com>
In-Reply-To: <20251204071332.1907111-1-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB11456:EE_
x-ms-office365-filtering-correlation-id: 6615d8c4-c3e5-4f3b-4386-08de468c37f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pFNsSqlLD+cmOHh7s00GJ7isHb7Q5HNaZeWxbHa2TGoaEmQ6lso7tXgf1MlJ?=
 =?us-ascii?Q?BonS0/uB2bcOd0x5+SoHinLwbgCaRcLCKQE6tDleRPxi5JtP2FWLqbJigZUR?=
 =?us-ascii?Q?rPBPg5wnCqrrtVfzEHK6NpQ/tJ8Dj2T4FgcqyLr7zcW+/1TRfDf8khbKA1Ip?=
 =?us-ascii?Q?hKGtbJnOylnsfuIZgWiOWMC1D7WxKgitbU7n4yZciJyU8YtsfoyDVkUhu1jg?=
 =?us-ascii?Q?A0LNhNMwXJxn8jFX+KrLcZTSQd/GVY1ru70oqFyuOppTpnb6eDif9QUun0W/?=
 =?us-ascii?Q?hXBrHH7y5GWgwxCrE+C0iw7DsHjYyipblFPIn7Dw3Ujg8SvH3t3nq+agwQmc?=
 =?us-ascii?Q?di77LaRHo/ENNrkW8QpnxN23fqeXUt6dLReiIfdlL22CCdyYig6gyOVEU9WU?=
 =?us-ascii?Q?bKPlxaZDj35FtrxEk1sTqR1yNzZMuh7gn7onj6kudxXtHCGADTrAYeNiX793?=
 =?us-ascii?Q?aZwrPvFm4PZLx2NSNU/myvrBYa1mLrYpDaHcVCnbSmY06nHRDP+Yzp0ecy/6?=
 =?us-ascii?Q?/imux3Fuzc3PQHE4wZb7ClEZ9X9J/e33A/fULhoZItJh8CUn/yMZojft4V9n?=
 =?us-ascii?Q?CZOtNiOughzINpopLjyjPlU/AMrfESGoG3Tzt5/qFcdEx0NHuzzBO336leJ2?=
 =?us-ascii?Q?ubSHTVodt1/OvulxMS2orFHdvV63Ho1kbKslUlkP2AUqv3Omq73rXGz6s0cy?=
 =?us-ascii?Q?4pIN7xL73y4DNnDMp9xh+eJNA6SU7TWawcDCfcOZNoMABm2HppOj0ScOyFxv?=
 =?us-ascii?Q?XKTyIip/22HVvTaXSkM4YgSCSICRhgWK3tG/WC/j2yocQEPNvPMT5RdySf7M?=
 =?us-ascii?Q?GQHWRm1b5jlOTxYFdd0ScJPYKZR8MboP9BiEBLzU0yLZHpjsOP40+GLK2KYw?=
 =?us-ascii?Q?t2OsoV9qP3cdD2Z8cBsbyq5c83cYibFIUSj9llfN3Dshe1n9dgYEN/3O/5OI?=
 =?us-ascii?Q?H9WB7lzDf0HW6iMcDvoUZXhF8SQ3HTD+izv1vvoXS9hA71CdRjfjxE/Kv19o?=
 =?us-ascii?Q?fdwe3pNi+ZMkaqXoFXX58iRvD/QEQ76rtXSLiy4GIJ22H1ydiYB9PvZdsH96?=
 =?us-ascii?Q?GXerTx3L5W/WgCq9ETUSxCXAzmlMlmIXSPIF8e9wGoJd24BiYTIcKRcrqHKd?=
 =?us-ascii?Q?pHyBD09ZMhaR47ysFKtKwrNQVn25pFy0SgBTGoMAi+u/K4p5DXGOWdIUQxV2?=
 =?us-ascii?Q?Veiy2LWrWk9Pz0VxJ0vUToDFSRkC4WcaDSanToYZQIVelqq26towxcBrU27x?=
 =?us-ascii?Q?ilt1KgPC6Bg/jh8T0r+PpjG593BAcrE5nNRCWUDO0vKejlNZ7nBq5uB2bpfc?=
 =?us-ascii?Q?3fTWFiO+jVZZoRbUm7fxgEACi6wRljU0yMRO4uaif+M5GixO9dClFkGnA393?=
 =?us-ascii?Q?liixNgzoyzMNkQ7M1Mxv9Aj+GCRJMZTOuYweVZAPnEMuQkO7OpCFvrP5ZzoX?=
 =?us-ascii?Q?jsFP6IksYXQ6A6LikjoN8mqHISR0XWRwkHJIwG+Rptb35yHgtdGgUv9mrQX4?=
 =?us-ascii?Q?38lYbYT5pS+52gEV9R85/62EloXAwW7VUhV4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vgB4gyEYW0vcUk/2NZVpKLfvZoUvpNu+xzgsN7KfQ454CCYDKx82LLuyLMTD?=
 =?us-ascii?Q?lOZziODb0B1P+de/1zoPtk62hf6hHmwFJVfzSmvDF6TOqH8ha4NV2HvnWnnJ?=
 =?us-ascii?Q?samwg6jeA+YnpSXNdujpHs5NgTCYdmEF4QRblewumtLI7tVxMDnP6D7YrgcD?=
 =?us-ascii?Q?A47PrtcEuhFdURKIzQF/9niz/0e6yRp0NBkHYb74l/zT0zJ3K62MaepYzKnO?=
 =?us-ascii?Q?ez6KD17lgzA2x2klYJLLDvyCb7/ZeP/SiHfNd1a+9FEyTe8tzagaCNq0JVO2?=
 =?us-ascii?Q?2q3u5WBQw0+hMlgNG/nQITrEVlKfiOQft8N88Q52fpYYsE98h9MO+Ag/Xo2t?=
 =?us-ascii?Q?fqgFc4sjnq+yHts1GrqOPp+fPrXmkf0XPMHnJmhSHXIlCzk0IXnoZB0sRPmV?=
 =?us-ascii?Q?UVKA0PjJjhDuVkXfReXnBXRmWGvSJjEdwQCPhpkWR+hJA/4sQqbg9JzSRYEV?=
 =?us-ascii?Q?/MOvp27ZsJDwNeSSbOx0/Ig3J6ic6fif3hyE0ZvJ66psVJTskf+pJlSfwshn?=
 =?us-ascii?Q?mt6V9BPQj67+1t2vSQbtW22XCnaF5W48B5dYlDIKKbvLboyVR+pRZQyfmWb7?=
 =?us-ascii?Q?QM7qEFi8d8A+f6xLgZN8ma39VG8bsB6qCCbC+z+I+ekkbPWwdSwicLOhtkYD?=
 =?us-ascii?Q?S8mjDUPuMn4p7F7qcdCaSBO+UssRc5J5iBSO7Y9kMEvFRxZEeSTV+Xrpmf2W?=
 =?us-ascii?Q?7K7+UfkQbtZ86fEtR9v3wEyBkjXSlOp+tUWidsSEadWXOPWDv0BtHSTtB4d9?=
 =?us-ascii?Q?kADeCk3VLBi8CAht+5PNr78Vyi6/fdUBO4ycV4F11lssDbk+9PQg4q/N5mEP?=
 =?us-ascii?Q?Qjjpc08irlsKC9EZXCjiw3V8VLTmWWynwYWAc1kQJATLxKxDIt11XaU+U47t?=
 =?us-ascii?Q?gHoWMdAoHyNO3McdJUSjhGLQjhoM9MODi7cRoS00CmUlrEqrE9kILlxKmvmY?=
 =?us-ascii?Q?C78+cfyjcbNgZ8prigEbyWNpzQqtPSNeFNJDoMPt0vZjHGk/NTW9q9KQeth9?=
 =?us-ascii?Q?ZwvOwPCtxsnWaIUj9j44BHBxngJVEJZP+ZPVgZ81ykjIy8+Ldezj/awWupEw?=
 =?us-ascii?Q?W9SvvjPH09Pz1OJrAgTxADYvHZgDij0zlj6kHeJeWdaeg3SyxY3uSDoVrdq3?=
 =?us-ascii?Q?bSodvGoIB44tqOzh78xyTp5AqDr9KT5tXh86X4SuTsTMBuAgS7GRQAE3HzLe?=
 =?us-ascii?Q?+LAQSeAPMmMmybNspgpmiWBRB4m9gmAP/Z0NbvTr5w/0V2D1yLhRAsgHa8qF?=
 =?us-ascii?Q?eH+Toa9AbuynZPHcOxooGqLuqNMG4gHYjCtrvqE+6lQTNywFtceh0ggalOHy?=
 =?us-ascii?Q?Pw7GxKvHMYjugAm0QjX3WoSwvgKfAE35atTtC4qafe0zWZUoc4ZILNzaNn0I?=
 =?us-ascii?Q?YAURTqAOIdHIyXEPrN/dyQfAzDCAnVlhPm8MsdHtuso7swuZ5cf3badx9trg?=
 =?us-ascii?Q?3UVD0gerbIU+94jEmn8JG3kjtSe9F2F1eWIBa1gcKWc268v/zXZP/V8GpO4E?=
 =?us-ascii?Q?iSqYISd6EEESELOjPH0D/Q7j60JH5HG4uvfFL1ACns0bz8a0xI6vNyWuvQ8K?=
 =?us-ascii?Q?7c3GuaN1v8Rq1aTw52jNn5EXdz0H/yY6lhX+eTE0lspGGD22zLyCGiRfMDnn?=
 =?us-ascii?Q?nijr/NBxx6uZcqQs9MEUmPALOgyr22e9fFmuCQfe4Ogr5vwessTOCc6eA7T6?=
 =?us-ascii?Q?F0qAniyrxNka7Hy1Yt/Y9EqLWKphMRljI/2fs+i+lottZxU6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6615d8c4-c3e5-4f3b-4386-08de468c37f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 03:41:58.1537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93xiOiUYPZC3K+0Yh913gUnDASURaQBvU6FLFyFdWKzt4IgDSM2Ooy9+UMh3Tm3uwmI05G989R4138Zjp4TfvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11456

> There is a crash issue when running zero copy XDP_TX action, the crash
> log is shown below.
>=20
> [  216.122464] Unable to handle kernel paging request at virtual address
> fffeffff80000000
> [  216.187524] Internal error: Oops: 0000000096000144 [#1]  SMP
> [  216.301694] Call trace:
> [  216.304130]  dcache_clean_poc+0x20/0x38 (P)
> [  216.308308]  __dma_sync_single_for_device+0x1bc/0x1e0
> [  216.313351]  stmmac_xdp_xmit_xdpf+0x354/0x400
> [  216.317701]  __stmmac_xdp_run_prog+0x164/0x368
> [  216.322139]  stmmac_napi_poll_rxtx+0xba8/0xf00
> [  216.326576]  __napi_poll+0x40/0x218
> [  216.408054] Kernel panic - not syncing: Oops: Fatal exception in inter=
rupt
>=20
> For XDP_TX action, the xdp_buff is converted to xdp_frame by
> xdp_convert_buff_to_frame(). The memory type of the resulting xdp_frame
> depends on the memory type of the xdp_buff. For page pool based xdp_buff
> it produces xdp_frame with memory type MEM_TYPE_PAGE_POOL. For zero
> copy
> XSK pool based xdp_buff it produces xdp_frame with memory type
> MEM_TYPE_PAGE_ORDER0. However, stmmac_xdp_xmit_back() does not
> check the
> memory type and always uses the page pool type, this leads to invalid
> mappings and causes the crash. Therefore, check the xdp_buff memory type
> in stmmac_xdp_xmit_back() to fix this issue.
>=20
> Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c   | 17
> +++++++++++++++--

Hi,

Could this patch be applied?


