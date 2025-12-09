Return-Path: <bpf+bounces-76351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0ACCAF652
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 10:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A05503058323
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 09:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0C02BE05B;
	Tue,  9 Dec 2025 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dK9M8Oei"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7929DB6E;
	Tue,  9 Dec 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271296; cv=fail; b=jx/knEBALfw6i2X10n7kdj6cDz4tcwNbef7pWbOfZwCTkJl4O8Qx4WCJJSCqljNhmzOTnIyrSVdRv8Ua/oENtXQ+UngzmBXxtTKAELeEIRdTPD1w5Eq/iBpwJBuvbF9WnZysmqZsHkUAXVB+1WblAuOlhYWRRI5ob5T1rWYS01Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271296; c=relaxed/simple;
	bh=M4V50YvHXC8h9J8fWFode9r0shAnC42VxgxJ05DQJFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ggkc9+uW3RBTvKqFeVyYJYn0CDy1GNpN9MJetETpy4vLw1Nz+gz3fTcVZBE9W42i/8ZzCLuIRpFrf2W5eHfl2fotNaScUpQFtNqgqmvDTnumHpSJyYosS4FgKRGqyOT0N+wzvIl4JCYHA0sFC/VrYI++Aoo1GdFkbsoTj7d/xHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dK9M8Oei; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peA/ImlF+GjP1q41MTXSKJUM6eLbPdlW9VUY9c8m5hC3rUqpakyI94jbOpAMzaM9t0pQ9Eyf8aLUN0B/51EGusK1cM3Jtd6YRTDBJ6+Ad+86JhWv4/vbfqCgGBPY6zBgNn2T7xxojxq0dJQY0XVNoyIwTNg83lcwUzv5jHBUb0VElGVQEDzPYDiSeVGgkSZEps81iHnZSx+SCfVLlz8zeUavRl3CwNv1OSLTLi1MGNECuiT80XuAI03JSObMwc6Ta345JqEV4zr5D7gvsIjyygUVyp00BEibW7lgA1xEq1h2K0M2xklv4B0kzfU6YLHjzQsl201Sim6jDOdfz+3AdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zCaMX8B7ogAvI+Q7EJh6YzroVnxE+U/x+0GEpVFPSY=;
 b=xMb7KE15tP8w87nqVUGOVfxHKsf/YOJrMiBrQhlzPNSqwwKlSzzmCokhlgRaiQ6h8/jsATlwPknB52oKY/ihqYxDIWSU9AxwpIwAwpvh8La2uvbL+JCD16lmRtfoV5piHiL1b1iTNPdnrcnJPd5uT9F1pXO56zyiFlWDxs0T99kihEV1BkyaJPPCpFyLF0hCo5g68Y/K7EUq/XcvYfoMqlYxiretpjAYSj5H1ioyAAaBAy2M5OPE9OKQvqduSaoULIbFR3AAVD+I0/ZKmjbsF1CskudAO6HrOoUWFS7ZtMiaDOtqWx8Ft/gyKwamjJbOoh0wNrXaC0ihC5vzda+I4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zCaMX8B7ogAvI+Q7EJh6YzroVnxE+U/x+0GEpVFPSY=;
 b=dK9M8OeilFdoJeayoaQqbu0B9EyYaMoI9YbJtX9TsIxHFzkOkwbrgdYSonMKUOGX4+NhZzlVXhnEoWkX9FYTcrRjq4XWReTUjeQci81nrvPdiaw4GlmHSZOlmkx7CcZXObq4CQV8CMgm/KPX6IQQ6beU0i6XaNEvT9Sx1P/PvNGq4dIgx/iK+nLD2cu9EUbRGsy9oYli3DqTpwvIMig0sQBWEyI/US+Jrw71dB4ncHmenAZAgKcC/EVulK6vX/eo9WWfbo+1+YvJUzjx1lUhZEuuOVL6Alp3U4O+/UhUjgFF6Pm+xabsNyHxy2sT+XwEcWpsnzMRM+3GBxRo9ISEsw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AMBPR04MB11811.eurprd04.prod.outlook.com (2603:10a6:20b:6f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 09:08:09 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 09:08:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH net] net: enetc: do not transmit redirected XDP frames
 when the link is down
Thread-Topic: [PATCH net] net: enetc: do not transmit redirected XDP frames
 when the link is down
Thread-Index: AQHcZdVIqiLJYvST9kiEq+ceAUspCLUZAeslgAAB3OA=
Date: Tue, 9 Dec 2025 09:08:08 +0000
Message-ID:
 <PAXPR04MB85103577C97139DE324AAC3788A3A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251205105307.2756994-1-wei.fang@nxp.com>
 <20251205105307.2756994-1-wei.fang@nxp.com>
 <20251209083531.2yk2lv2rahouytv2@skbuf>
In-Reply-To: <20251209083531.2yk2lv2rahouytv2@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AMBPR04MB11811:EE_
x-ms-office365-filtering-correlation-id: feb43aa6-e435-4196-ca26-08de370278c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eyqq25+4wb6H8COTbwGbKxGLmSytIvRHZ+RwSBwShAcicyePAgyMQWNEkQVR?=
 =?us-ascii?Q?FdBLe0m8vekXQNS6wL1e2B6ULMz4/8W/B0Mqn6dBsLJLlRHrtlGU33F5MzOi?=
 =?us-ascii?Q?E8zcVu2B04m1FPdw9JF2SyIyVbqWiOZJqVMScSi4RBEueYL7O1D9sEtAQgKP?=
 =?us-ascii?Q?GcUCL0ghgqs8daWW5ZFERNZagYY+hKtiYQduQdYz82i1DQAGEDkaOWpA/knw?=
 =?us-ascii?Q?pt+9HPc1gpdWwOE9N/KquQc6GQZ9pviuMJEtqHRP7EQ2GkjEmjHRMmV2H+bL?=
 =?us-ascii?Q?rqcR8TZk6NQikrDolutHfrXd4WSSjAtx6u2oHbAd7dcXOFzcv+/Ho3qbRBnb?=
 =?us-ascii?Q?rsKo1IiVxF4ZmMsMGnVAf9GMU6gJf+cSK6/CnhOQ1AQ5sfVL9zAaW6p/QCqQ?=
 =?us-ascii?Q?CnABAS24ma5QxgSkM5GZSQY2nsbLabHYgE8fmGrn1MdNCEynN+vugYz+V/ib?=
 =?us-ascii?Q?TImXvp7pk9ACKDep2I6ZjFD9EKqfM84s8sjzXk2Lujz5ifCisq6xK1G7kIhk?=
 =?us-ascii?Q?r88+q2xYtpqoPaZswgCazMO5Xhs9bYcbcZeX0+gEhu6EPnooma91zkEdq5NJ?=
 =?us-ascii?Q?O/mwMlIre2Wsbzh9NEv7CicYYpVLPuWibvy+B4dIPC6793zsN7NrlDIwtiYs?=
 =?us-ascii?Q?uLtnFPfDYm8Zlze+NmycfRAWZc7ZJe8cp3WBRJ8E9Ow5g13aKNt5SJPPz4sF?=
 =?us-ascii?Q?NehHoKnMVV3WeGh8xP2osOSbkElnDrxdEiJpxCOD+wWu4unO30lSp7SuuINq?=
 =?us-ascii?Q?NP7Cgb3IAexqfNoBhuWC0XemgZ60UrhnnwX3Ygc1+jUuz4UV6KZBUc9rzsjk?=
 =?us-ascii?Q?YA/NBN5uI4xF9MU5aBnv2k6yD8EnTp0iV9uHBbboGAhx0mK9PttdQYnBccgl?=
 =?us-ascii?Q?fYv3VvKYymvbmidRegcEDjU9bQloOPVhmRmZubN7a7DT3AL5SC1Fb99Qkt2Y?=
 =?us-ascii?Q?BGft5q+B/AamGknwtis8rqHzD5FheUvLhqlGjazsmHpGojH2tuXCuDwLcx4z?=
 =?us-ascii?Q?4/V7oyVSlqTPxsuqxIlz/ARvdtiw5BEXPkN3h6p1SUa9FiSHtWaJtLzD42nt?=
 =?us-ascii?Q?lrsshW139LhHv8+AjjbX6PgNFOMripHxOE3w/kyTEi7fjCk8XJ84+wiaRcTs?=
 =?us-ascii?Q?6wRK+tpw1alzW37X4z//Ec3i4mo6YSEUlZnFcjAkXAsKlr0syTmbxyLkUUeH?=
 =?us-ascii?Q?46TEyz9p107fwMS5Ip7cRzXD3PBCMqgJg4QGMxgAbn+DLdJBvOtBK6q4C2Cj?=
 =?us-ascii?Q?k/u5pVo4iyp+geQnpCZxE8UeZkPQJcD6uxsRdqSKVxXA10AYEVjHvi8Ytfcu?=
 =?us-ascii?Q?yE3+bDPIoaWmvXOVqLJ7MLFyOoSsyGZStZcwd4WKfnMXUijsoHGA/znB3N07?=
 =?us-ascii?Q?qPYzsnuKS/iJ/8vDkZdq9R4yH7kJcgSd//I89NScr5K6kaFIeBoQ2Cg8CCqp?=
 =?us-ascii?Q?P8PqLkWH31bxqLkczgAcE6e7BvV0yXbdC4eNJQCh0Tj3mGF6QEKEHhaYiK9s?=
 =?us-ascii?Q?tQLM+dKhWMMu2AhJtPz7ND9aA+kD7eWO1kE2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K9D/uki6/p7frEBBR2vrtS216wQgZyRtZGHFrOkYLxrcE4C892Vm4O0/rlGd?=
 =?us-ascii?Q?+xiymGLyft60Ww1GxzTstaBbpVHmQ3c8DdFvgO3HVVBOzt7d6XwJqIMu8ZIb?=
 =?us-ascii?Q?GYZwPNt1N1lVXU1mxEAv42ZmmIYpsRp90m3zZ7daHZiDK6lo7CCnwLLnZ/4p?=
 =?us-ascii?Q?Atl+QrFG9/AJH4CL0j/M3J0i2KTVC6fbrbrWQlhOSdRA7bId+LDso9VwR2Pw?=
 =?us-ascii?Q?+V4jdDwjfp2+sBcVO/NJSzjPbv0vKBWpAnt37T/2AzU7orYB0QjmnRrKid5w?=
 =?us-ascii?Q?uUHWIuPrrq5xYWgu/IRla5H295fVx0kPgQUiz/Bl4tDSH5EL3zULzZ0xiohG?=
 =?us-ascii?Q?dgdayCY17Ljv1ufzz+7/gA8PZIDMxGMYHr+RrEEAxys3PfgLO5sM71RBCBm/?=
 =?us-ascii?Q?646eV9yv8KeqNXcuEjoXn0vM8VcG9YHFYUSiJ5Glqzjyy8mg1HSTrbxInWV4?=
 =?us-ascii?Q?6poaVby8DvVoHYO+7Y94fkPTwGTAQrFOwcI9Iq1xETSbRKM3qvONoocZQRkh?=
 =?us-ascii?Q?JTgpyIEpC/n61gQjw8WmmulgtdmlBSxzMg716ZzkHoD0t5GtzEfN748u7q1V?=
 =?us-ascii?Q?hfYpkZXl0ZJK2ES16JstaPlZ2uqBTWFedfzwdAqvy1jaEOytCQ5blcdSDSlq?=
 =?us-ascii?Q?6yErd7CnY2lQthFxKjxl1Ld7X/at438+rI4Xrhxy7SSzkzEYAhWiNkxm8UOy?=
 =?us-ascii?Q?J7sEgNRA4ayVqHx5nZ95pBGYwPR33pu3tIVbW+hov3apInG0hNkzTiPpwWle?=
 =?us-ascii?Q?OpDF2dqCMD8OPf43vfNBHuKEqmUEbvN4NC/3F6/dACN3THKLXCIGztf11VwM?=
 =?us-ascii?Q?rCfadfU76D62qbaRtFdP0lXZKJu2uT2fHRPiWZOx/asMw9vl6iW3wiKFpvzg?=
 =?us-ascii?Q?SR8HPKGc3GBx7V5lvGmK/Q2nSRpSFNHqz9R3dXITK7LKHoSEVwdZRqSfOMSV?=
 =?us-ascii?Q?eK3XPqrOxuvF1h0pDcVS7jgXU3TvbA6P3NrLXK2Y+7dmQ4uQXsljx2sShaGX?=
 =?us-ascii?Q?EUoEfhd0hQ7VqTtCiBqMivMMSaeTFAsLcfTyHsstwUH2mtToZPq0gtbOyr2W?=
 =?us-ascii?Q?PhIamGuhmwRvvIorQJhYTBEaJrpxR9mM9OOkG95UjkT0K6Ptx0q5POikhC6r?=
 =?us-ascii?Q?0n5F9rRZPWmOkcFC7I5rjUU2iep8i4jftwtEEB+OgulM40qCcfbMFqZQrN2C?=
 =?us-ascii?Q?isYg0062UdLbCPRQWpYuaLLb8YLIOSa5zpM+zX69ErvYU4WEhyFhnJYG3mIL?=
 =?us-ascii?Q?4mPl3x486j1cuHlQ/mCTfqGIjT9K6C4Juak9Kwi/Rn5Xnxmfuv6ek2cdGvNA?=
 =?us-ascii?Q?vIh8q0lRhdqQfwSI7+OvZ36kWoNupW21hpdrcnht9qXyLxqjo2UBFU+a+Nr7?=
 =?us-ascii?Q?Q4V0hDrJcClMVNkbMvQSWORjBHVAFabNLXB6nxR0mj1s+q6XF4mIr1jLIO2p?=
 =?us-ascii?Q?DL7wNXVma3j5Pctvwh0xm9jUvSEh4O2oS1tVx1dbyihQM0eC3XoRECGnQ/cL?=
 =?us-ascii?Q?ghwr5NLHgeGbgTKZXUTbLyeZwCKsn9XYP+oKTTm+6BNxyNZeiERfXVy79pGx?=
 =?us-ascii?Q?ngfbDS2zCr/fJTLhJ0g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: feb43aa6-e435-4196-ca26-08de370278c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 09:08:08.8447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZ132lSyNUWd3v4PX+c019SCZ70ia8BRe6RnoctdaY0nWHrlIoSW4QlABXWpgzKGWm85jn/9e51LotJii5bghA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11811

> On Fri, Dec 05, 2025 at 06:53:07PM +0800, Wei Fang wrote:
> > In the current implementation, the enetc_xdp_xmit() always transmits
> > redirected XDP frames even if the link is down, but the frames cannot
> > be transmitted from TX BD rings when the link is down, so the frames
> > are still kept in the TX BD rings. If the XDP program is uninstalled,
> > users will see the following warning logs.
> >
> > fsl_enetc 0000:00:00.0 eno0: timeout for tx ring #6 clear
> >
> > More worse, the TX BD ring cannot work properly anymore, because the
> > HW PIR and CIR are not the same after the re-initialization of the TX
> > BD ring.
>=20
> I understand and I don't disagree that the TX BD ring doesn't work
> anymore if we disable it while it has pending frames (the TB0MR[EN]
> documentation says that this is unsafe too), but:
> - I don't understand why the hardware PIR and CIR are not the same after
>   the TX ring reinitialization
> - I don't understand how the effect and the claimed cause are connected
>=20
> Could you please give more details what you mean here?

Currently, the hardware PIR and CIR are not initialized by the software
when the TX BD is re-initialized. The driver just reads HW PIR and CIR and
then initializes the SW PIR and CIR. See enetc_setup_txbdr():

/* clearing PI/CI registers for Tx not supported, adjust sw indexes */
tx_ring->next_to_use =3D enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
tx_ring->next_to_clean =3D enetc_txbdr_rd(hw, idx, ENETC_TBCIR);

If there are unsent frames on the TX BD ring, the HW PIR and CIR are
not equal when the TX BD ring is disabled. So if the TX BD ring is
re-initialized at that time, the unsent frames will be freed and HW
PIR and CIR are still not equal after the re-initialization. At this point,=
=20
the BDs between CIR and PIR are invalid, which will cause a hardware
malfunction.

Another reason is that there is internal context in the ring prefetch
logic that will retain the state from the first incarnation of the ring
and continue prefetching from the stale location when we re-initialize
the ring. The internal context is only reset by an FLR. That is to say,
for LS1028A ENETC, software cannot set the HW CIR and PIR when
initializing the TX BD ring.

The best solution is to either not initialize the TX BD ring or use FLR
to initialize it when this situation (the TX BD ring still has unsent
frames) occurs. Either approach involves complex modifications,
especially the FLR method. I don't have enough time to fix this issue
for the LS1028A. At least for now, this patch is what I can do, and it
doesn't conflict with subsequent solutions.


