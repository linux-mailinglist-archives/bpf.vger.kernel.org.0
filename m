Return-Path: <bpf+bounces-78862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9940D1DC5F
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 11:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01506302A795
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 10:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2F638A70E;
	Wed, 14 Jan 2026 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PKe1Ynvr"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD6D3876DF;
	Wed, 14 Jan 2026 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384897; cv=fail; b=H60lBP7hyLn6TW4moG4pBzVzkcCbCJKzBYbR0WJBezIu/LXvX2EXgBNOIZ3IbBdR6z34LEjlMF47P4RErwpdOGVU48kLx3ivwM+4EURvR/ZcqRgaFBL9PbTWHF5AKzLnVmfpixuzh92fYzWDLfCKhunjLZQ3HafjXklpCxwEXgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384897; c=relaxed/simple;
	bh=812MH6rkcd2endAN0P5KiM1kzvtGvEe6dTf62UxJl78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BfXcfpy0U874/Djb0hLXgfQPljP6FcMRkSM3UY8PCxkCyPoKnNPskHY24F+TsDxG35UYtwMDZMN30/12ZlcWAmNpzAxG9LY2/5vVpybtSYnjzfUkgt0k6hGYe48p4ML8IMaBAk0nGHOroj2dCq5Cgn3cKZyHYKhH4M40SrhUTfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PKe1Ynvr; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdFk9KvMfqNxdVaBAnlYj4pmeD/+GoKMksn5E9G0IoT2aC54qkyVU4lC2YAG4RJjAZgwkjORnciPDHU6421OSOjbxznV0rOzlTvpS6cyfRcvBvjCmumdXJlwYTz/1oL+4+jsLbgHRJddcwskc5RTxa9AKH2SZKDB6M14D1TdKTASFhmm9X+fu9YFD9GOrkyiGs8GdeluNo3v2A6WJUkkkg14XB/UtTSkhEqhBd3b3vaugP7EtkGXg8rqDcsfqqUfIlzZe9y4dviK/5vjpEtZpErOmT4uzo6oSWjwXvrXleOwdL/TaUXxPZEPbqpuhyGVBTaWEmNmp9+hGerxIDtjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SppurVDZyyPQZLL/EUJ0jnJ9+zyBDHdiSwNFOmAm/I=;
 b=w7H+Ne6p3bFJwRnwFlF/YyuZPP0OzQnFeK15deP4JCNeTeapa99+nRfM4LrCuwwhqIU2FsrcdnrGx410ybEBa+KhOUaw8STo5n8wTNmDJFX1lA1eEJ5WmiWhrUzVCTq8TIUr7xOnR9uNcrbkphNJvR5fHHT3GIwKuraeiMZZ37BdfanwPe+zGnyOFtn6xOcBewA7C1IfgTIp6hpoBbR0Or+zKkX4BzsPZFEnx5oFQ6NVWW4JsB03Z7PlFkZSaARbVuxvyE7qCmRD36lwHKx2gq79jFDDYrR587IvnBpDZpthFkflK0rZEmFLOmX+33p5WK0wR15LfxpVxWjWExqKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SppurVDZyyPQZLL/EUJ0jnJ9+zyBDHdiSwNFOmAm/I=;
 b=PKe1YnvrPHdPCI0XlQ/i7zsLnKJwAFceQe+SZ1yNTyxyfveVgwjQy7C5ikXcIrc8Iqc83FKKRjctPP2BDslnoUPo13v7vz6KC2FCg0IQFFhjnvHimTPS95VTt+UOpomF/yTXy8YCN7NSiFzYkwHYXGEbpLWSu3uvPTqHywccOJctyl188SqobYDh2U/fTKt2t9zT1qUyLWo5GLm5uUHdFhq70fXsH7MlrlnKpnfpJ81VJsDHKHDRZWDnFerdMvJ08ig2FCEu8+euhB+3/QHeZ7FuLkmecxeNV4877I5EzFpL+USE13fZhbIgMJc3sZUxmviqfcPoaLBaN0YGIfDABA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AMBPR04MB11764.eurprd04.prod.outlook.com (2603:10a6:20b:6f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 10:01:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 14 Jan 2026
 10:01:26 +0000
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
Subject: RE: [PATCH net-next 07/11] net: fec: use switch statement to check
 the type of tx_buf
Thread-Topic: [PATCH net-next 07/11] net: fec: use switch statement to check
 the type of tx_buf
Thread-Index: AQHchDz94JEEe8B96kSUW261P6sEvLVQSREAgAEnQ6A=
Date: Wed, 14 Jan 2026 10:01:26 +0000
Message-ID:
 <PAXPR04MB8510292C43DE527926154759888FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
 <20260113032939.3705137-8-wei.fang@nxp.com>
 <aWZxNFIh2trMm04T@lizhi-Precision-Tower-5810>
In-Reply-To: <aWZxNFIh2trMm04T@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AMBPR04MB11764:EE_
x-ms-office365-filtering-correlation-id: 40a28965-6881-41c9-eb4b-08de5353e15b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rCZGBiVt6uPfxVaMbs8jnYkQPVVE//Rzz6Ob0ZYg7AzFkp+jNsD+u7ugDOiq?=
 =?us-ascii?Q?sppIhSIGtGr7nhv2YHXTgggkiP2ZCgRKSQI5A8IPLjXLjBZzja67WrZTPtSm?=
 =?us-ascii?Q?3PLNBvcdbEYDbnCtg5uOhDwrJjrZ8PgcO73/w/YxaJUE425p6QZ+Q1kNyPEu?=
 =?us-ascii?Q?3XkOv72KSS2Eb1/ZkRTvv65r/H09ctNqnK6Nf3oeQtSAuUuzS/raM+w3a/Zg?=
 =?us-ascii?Q?v7nAHzPXH6792eUVo7+fVemRGpEPUuzBVtpAVxJpqrcIaaQpyIBewE3jY4fH?=
 =?us-ascii?Q?WAcC2k+xQ8i2tV10G5DPICPdk+XSoxtdpxz++VlaNi+sY9DyVkf/w5kvURPS?=
 =?us-ascii?Q?mV+2sSArPEscyTBseSUQnI2bnbsnNdi6W+HLwVSRIbwaOJ4DIolFZLN7igmH?=
 =?us-ascii?Q?l5eu8seQR3/Sscqex1vSxS9q0Wh1y0Nw0OP3l3/8uTXzNOwPkZQpBcg5Tjty?=
 =?us-ascii?Q?iDbLVL23EVOdUjgOqCHk8H89/smQ3xp4NGE1H99ndXPRriaer+wMAyePM57w?=
 =?us-ascii?Q?Z1+wbci0aTrpIN9QGARCrYHnXAYPkYNWfrF+/gwDRWFEwI3qQtYxaNTPwd82?=
 =?us-ascii?Q?DBsVGCPiL8z69/eE9+g2N3bxrKSiW8DhiGPKnvf37On1duB7zHQzChWptpR2?=
 =?us-ascii?Q?rWgiTQRcnT5XmoSilCiuwcdnDUD9QwxnMyDG4GWYdjOGTK5mlEWvDFK3+ywe?=
 =?us-ascii?Q?cGhKTcj1ufGvX0V6DfbtLgTyOeEabgrrIE/oCDMpaU+VLiumGQefRZ0efYAE?=
 =?us-ascii?Q?NzqasFwpbMOxfQBDqRIESB/Etb4e9enM1eReIe/WL5Oe95g4L9jZppzqLVGU?=
 =?us-ascii?Q?skiYjsLe3xeWCF/1FEGB0uB7gricBzAP+eaHaMWZ4Xb+TJDfRxk21Ot5g2KL?=
 =?us-ascii?Q?WAIUENf0Db9ifx+9UohbyEDhRcU6Jn1AEdLoOphlXip9hzFVEtUX8S7VVi5h?=
 =?us-ascii?Q?5XPw0SD2WKio7AV+hYoCo7wwU8XvhXdxDyXh7/uDrtmn1QNxf4mx5Uwva6cn?=
 =?us-ascii?Q?eUS93csJRE+4wPUgbOA+DiAhcRHbOfFE7FkTpoh2AYQGul/eNwXHZRoI8ExW?=
 =?us-ascii?Q?CVDzj61hk8CmyieQF899+Ej2Sgs5ndrgxOM3B3JJGXlpPu2uTsuc6nAdfDkF?=
 =?us-ascii?Q?Pc2iMEVQid5VSg34DgluiQ/4HVF69VsS4sQmM2Mu73JglSir711nMn9AhNpA?=
 =?us-ascii?Q?jxzcFV+D43zXFKvN5kI9DMx4bdVKTvVd9E7dfAx4bP4yUOAcLUWYMAbNYf1+?=
 =?us-ascii?Q?eQ3Dalil+vggW5sv1ppw+heoO7VoKwYtDvl3AiCUwmrfKYyoX6+I6xNrAEj9?=
 =?us-ascii?Q?BVTNH4gxDl0S1TYl03yxu0LGsHh1N1PiEB7WOOItbplveJJYKcGnLqLyW3OG?=
 =?us-ascii?Q?VtRkvgWJL5foWhX3h/m8LToVyQhU/nw20iRKoRHMKMn1ff4eo0DuAv0A05Fe?=
 =?us-ascii?Q?LqZKcuAb/yHHMZ7QhMZ/KHC0pNRUOOA55PV29pe1m202Qiy6jfjDsWWwgV3y?=
 =?us-ascii?Q?JkNLR/S1Hd/hRjO+KH2Vx8+ztLG8x2CzoXmW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+sZOjr1wRfqdkHbwgR3Y91wTrRWuN9zrx9P3nY0KzTmebyNonRdm0QRPRk/S?=
 =?us-ascii?Q?6xtKIKSD9sBc9CrJm7F2pnAhEVyIVKFDVoCDiLvMsu1n6p733RVDynmwE2tz?=
 =?us-ascii?Q?12H8+EU3LeGAgbYvP7M6GaXeSdxuh4nruL0wC/UpI9IDm7iHnnATzJwMxgbq?=
 =?us-ascii?Q?jX1sFMIKjzOvxonM9MfYQt2rPG824WiI8/zFGcxpMJKsyUQAgK0odGqWrlX3?=
 =?us-ascii?Q?jLMVnsIGvluAsIyOPIu6frWVhnRqVG1q5Rsvmyhfq1NBzN1Vv5M51z3XZWrr?=
 =?us-ascii?Q?j7yv1z7muA8oVfaYx2cyP1VaKcqwVe51Tnr1rSglQA0z0XiNLlZpnXNPnONH?=
 =?us-ascii?Q?jhYmVsFvB2f3ml1OwjwRPgNiKgWKspok8nMdAPssXCzGMQW5p/DcoyyB1Ibt?=
 =?us-ascii?Q?x/KlS1Fd96+xvBQcaB02GJq4W8XRvmDcddE3VKqMLFZt9uAkgK8NnhES68qD?=
 =?us-ascii?Q?YK2sq0N0gVTKAKN/mTD3mlbtwsf1O/g5GQ8Fv3dfB66PLt0BrCu/Jxlfo/4J?=
 =?us-ascii?Q?G3DCP6diQEVBQvMEipPkdDBmEjLRiG4AW4oFbFpY2owKe3SqiqQBC9Q5FL3N?=
 =?us-ascii?Q?V6rbdzAu7mtyxFEeKA0tUmqSDDd9u1GOUWWTkJoKoi82L+uelpQSa2ubPi2k?=
 =?us-ascii?Q?HkWimlqDfDMdB6FSlWg6iiHLYxGrtQafU2o1mzyQXtomlJDK4WdG3Ibv9HXr?=
 =?us-ascii?Q?4sEknTdxiLI2rLSOH11IzRPsGAPZBbuFGYQMBdJ3t+1FG1LlyLvHbI4NR4Vp?=
 =?us-ascii?Q?cQxj0i/rSorP+zWgfHyWPN1AgAvmaJF+1HFy/V5xVLkDeDLW8Yby3qyWDtbF?=
 =?us-ascii?Q?wVAudgtqTkO+v251p55VYgffGy5k9fCH8NWmzRLHBj8sLs2WieYZhlew9SGE?=
 =?us-ascii?Q?NKHxgBuCfbG/VN3/iX2fMFkNVhNq8CzcrMS/bMZKG7OlMuZPf8xgm6wQcmHP?=
 =?us-ascii?Q?MfYouoCEGnWlygHZCqfBqkm0Mni+KIyfG1a4izCUSrUnA88smHmvYk5zV068?=
 =?us-ascii?Q?kObG977c7Df7eRW71sqJUhplUKVY3Cw9kqjre5JOyF1Ujt/EjdZHOZeLRsaN?=
 =?us-ascii?Q?JrSxNkgqycL1TgyP1FCcO9uM+JAOvuIVMaYVq9+oFFTTeLa+4GV3ZxeWTLxa?=
 =?us-ascii?Q?iFEqW4oWcZJr7XuFlwABSaHkZ8qPrfkNYGclccFhDb4+ZRVqHKGJP+W8UJEY?=
 =?us-ascii?Q?piueoPiUsBZFmGVVGoZghpLBpeT7iDP80Q46+HIUcGOsa30C1j4+jTgYY+pU?=
 =?us-ascii?Q?8ecRsP4EbB0ypJ+HOv6kVh1u2jgL27rYz0bGfWbkVz2C4EbyCn6Pl9LbQHEK?=
 =?us-ascii?Q?d7Y7S0OPCWEoN3eHH7gXgtsN7WrWUk14cJ4X85VXOQShyl8IRleH+hWUSLYq?=
 =?us-ascii?Q?aHOWHCOvx6wxAdIaG+bieFgC/Rbq8lXcsznfl4dvibnYTK6fyaKqerYvJK44?=
 =?us-ascii?Q?UZO+YEk2Gl/mgsVrj0+KV9/0EEiqC7ZwQjWwS1AAHyf8a5zOn1Teyw7ktBGH?=
 =?us-ascii?Q?ygpGdFlOY9OupNS0vjp3jkzaWuKLIanUCP3JQkllCds/uuI9OIeT+rMBWwHW?=
 =?us-ascii?Q?PcD1f1k7hzdPJHJ8w+8aprO8iXb3wiETDoipJLR/3Yv4bdY/XgBJxR6wG6Co?=
 =?us-ascii?Q?eXDbrl4AYG5MSzIp+OeQLgtIu9ZTPCLBInc9LbGC7DVUsHAECyXTsyiLaUaS?=
 =?us-ascii?Q?FQQxzihwhfBFG6iOoyYKpeQleXZdaYGgaXqjNsvnfyABINyk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a28965-6881-41c9-eb4b-08de5353e15b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 10:01:26.1416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bp3L4AjEY+sgEDP093DL5k0d9WFV6nXIxc3XJEYcegTxeUDj85BzI/ZFj0gqNJ1kMBZY8AnALE/U/uAXvpb/vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11764

> On Tue, Jan 13, 2026 at 11:29:35AM +0800, Wei Fang wrote:
> > The tx_buf has three types: FEC_TXBUF_T_SKB, FEC_TXBUF_T_XDP_NDO and
> > FEC_TXBUF_T_XDP_TX. Currently, the driver uses 'if...else...'
> > statements to check the type and perform the corresponding processing.
> > This is very detrimental to future expansion. For example, if new
> > types are added to support XDP zero copy in the future, continuing to u=
se
> 'if...else...'
> > would be a very bad coding style. So the 'if...else...' statements in
> > the current driver are replaced with switch statements to support XDP
> > zero copy in the future.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/fec_main.c | 167
> > +++++++++++-----------
> >  1 file changed, 82 insertions(+), 85 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > b/drivers/net/ethernet/freescale/fec_main.c
> > index f3e93598a27c..3bd89d7f105b 100644
> > --- a/drivers/net/ethernet/freescale/fec_main.c
> > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > @@ -1023,33 +1023,33 @@ static void fec_enet_bd_init(struct net_device
> *dev)
> >  		txq->bd.cur =3D bdp;
> >
> >  		for (i =3D 0; i < txq->bd.ring_size; i++) {
> > +			dma_addr_t dma =3D fec32_to_cpu(bdp->cbd_bufaddr);
> > +			struct page *page;
> > +
> >  			/* Initialize the BD for every fragment in the page. */
> >  			bdp->cbd_sc =3D cpu_to_fec16(0);
> > -			if (txq->tx_buf[i].type =3D=3D FEC_TXBUF_T_SKB) {
> > -				if (bdp->cbd_bufaddr &&
> > -				    !IS_TSO_HEADER(txq,
> fec32_to_cpu(bdp->cbd_bufaddr)))
> > -					dma_unmap_single(&fep->pdev->dev,
> > -							 fec32_to_cpu(bdp->cbd_bufaddr),
> > -							 fec16_to_cpu(bdp->cbd_datlen),
> > -							 DMA_TO_DEVICE);
> > -				if (txq->tx_buf[i].buf_p)
> > -					dev_kfree_skb_any(txq->tx_buf[i].buf_p);
> > -			} else if (txq->tx_buf[i].type =3D=3D FEC_TXBUF_T_XDP_NDO) {
> > -				if (bdp->cbd_bufaddr)
> > -					dma_unmap_single(&fep->pdev->dev,
> > -							 fec32_to_cpu(bdp->cbd_bufaddr),
> > +			switch (txq->tx_buf[i].type) {
> > +			case FEC_TXBUF_T_SKB:
> > +				if (dma && !IS_TSO_HEADER(txq, dma))
> > +					dma_unmap_single(&fep->pdev->dev, dma,
> >  							 fec16_to_cpu(bdp->cbd_datlen),
> >  							 DMA_TO_DEVICE);
> >
> > -				if (txq->tx_buf[i].buf_p)
> > -					xdp_return_frame(txq->tx_buf[i].buf_p);
> > -			} else {
> > -				struct page *page =3D txq->tx_buf[i].buf_p;
> > -
> > -				if (page)
> > -					page_pool_put_page(pp_page_to_nmdesc(page)->pp,
> > -							   page, 0,
> > -							   false);
> > +				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
> > +				break;
> > +			case FEC_TXBUF_T_XDP_NDO:
> > +				dma_unmap_single(&fep->pdev->dev, dma,
> > +						 fec16_to_cpu(bdp->cbd_datlen),
> > +						 DMA_TO_DEVICE);
> > +				xdp_return_frame(txq->tx_buf[i].buf_p);
>=20
> look like logic is not exactly same as original one
>=20
> if (txq->tx_buf[i].type =3D=3D FEC_TXBUF_T_XDP_NDO) {
> 	if (bdp->cbd_bufaddr)
> 		...

Yes, I did some cleanup as well, because the case of NULL pointer is
always false.


