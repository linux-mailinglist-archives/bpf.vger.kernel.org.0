Return-Path: <bpf+bounces-76359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C86ECAF85B
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 10:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB671301C3F6
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 09:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361472FD672;
	Tue,  9 Dec 2025 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nZXZBkCh"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B02FC887;
	Tue,  9 Dec 2025 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274376; cv=fail; b=ZcVdkVyxF4VXwBRs4mxqTL0GLcd/MUjIoME2cd4yYpdC6s/1qf1u+0DdSToHXh/3V4r2Loda0c45e6BNDOhZxYBcSm+iqxJ/CxWyYKgKI17nXcko1V+VIrsdhyRKMSnhFCIKunubMP/Ar3iGBHOA4omA1JrqE3j8PhKWxeJfBIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274376; c=relaxed/simple;
	bh=jH0DqTQbXZ1u9IeUbJ5omxwTWmJ8bZ1JdN2aPc1iGnY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BW/IlJRjd8B9SSRINUgdx4svpZHacM7Y2zKwLzybWkyicTPRZsVvm5LwsZmXKEZHCKvM+JlvqeRoDXNVCCilt6HJFsSz1RzcwmAdZCZvVCJc09PtL0GheN5HmX4ei5OmSBkjZUOd4ZLxzP8etMxkEUHkNDi988snuDZGIAFGEDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nZXZBkCh; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwX3KZNv3qIICS7AS/dnW76y/+He6aHHw3afIE8SbyGpxrDMW99hKUzInfVCB/03B4eIVImoGJATv4U/J/EskNRsLDLImrjhHfRHykgxBDcyDUpbuxaHPJnMSbv2THpJM+rmHts7ty1AqORXvyPFJt6z6gNG9m66KFqXVN6NvWSnrWXxsDldLYMbwlV5C3VxDNJGhfX1+hhzMs1+h19z7zHBC/rO3MiJNSoat9uBabjScrPAUnFzDFM8P7VIT4LcQJh92WBzNFMy22+Bkcsv2M1TGGOY7LyL/J+5tvX17pXBnKJtVhef5xdLAU1ZOYyRM80SJaowQWd7g+2fs/dsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIaHpYPVJbEOXvpXJ6r6qIiEjTopnJRmO7xB7DjAtNA=;
 b=XCARyTW2NbI4SvRGel8ptArOeqn9FLUEZHvr5qJCsowTRhTxuCggCpHTyzgAJrvnMb8q3Rf9drqYQ7W6/7sitzcn6I3GvA+AVja0P9OLCcYzly8J8hcl8/YW8/pJL5n469EHQBc2R62D+M0sDh3ldmWmwa36IMqP9u739Xxxxy3sdHBxBQfjjvrKDxkZ/W8z4k2u+XOgNBGitxF00Hk+62WRP3TggtJcbC9e2iqxTWEzsfxl4y1G94FkxsxHtXXDDpyrS9ZlbuKlpULh6XEXKYu482pF3GRaoZqchd+X9U3Xc7GKCwxivGbAxVga2BLrcivyJHT7xz6p/P7SmCS+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIaHpYPVJbEOXvpXJ6r6qIiEjTopnJRmO7xB7DjAtNA=;
 b=nZXZBkCh/EC4Ys35Yp1DpNaGJ7Mfe/edN5EL0H4Fma6KaiJw51UCOGvOnULUvfEtnYM6kyfi9zu/pFVcs4XuvBG8/uBoYIIseZKvJk2mPedgPSOoXD+mQxPLVT1si+gmPAj/xyOkTsAOgzNSf+K87hfLdnavLfgsAYOrIurD1TBQ2Ldp2Htr2qWP4IO4fPVyJ3/MX+AQOC5o9eplYBn8W5HfwRJ0AIgBnT7By2biP37FqvF/whKlvFVmiXsdVAJEljtD36jcoEUenrZCQbo9qqT4DkHyRYhH+0aun8pGDMUz3ZOK2yECODKVfY6zpD9L7vEHMdgH+SYXJLfF34Ofzw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9992.eurprd04.prod.outlook.com (2603:10a6:10:4c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 09:59:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 09:59:29 +0000
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
Thread-Index: AQHcZdVIqiLJYvST9kiEq+ceAUspCLUZAeslgAAB3OCAABB/gIAAA5ug
Date: Tue, 9 Dec 2025 09:59:29 +0000
Message-ID:
 <PAXPR04MB8510D2189E11281AD3E8D18588A3A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251205105307.2756994-1-wei.fang@nxp.com>
 <20251205105307.2756994-1-wei.fang@nxp.com>
 <20251209083531.2yk2lv2rahouytv2@skbuf>
 <PAXPR04MB85103577C97139DE324AAC3788A3A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20251209094119.5rv4af4te6w237li@skbuf>
In-Reply-To: <20251209094119.5rv4af4te6w237li@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB9992:EE_
x-ms-office365-filtering-correlation-id: befb9d71-6333-481c-faab-08de3709a4ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5Yh5VIydet/KgUhwxVyi5rmvQJ1iY7wpMNeyKd662loi6M+wwXoLtkiGEkB4?=
 =?us-ascii?Q?335prkt6jWkUCUl9/LNsGehTn906IEgQXGfIOhCduN5GwMt0rpm25qmAeas4?=
 =?us-ascii?Q?Hq1ML3fLDlzfNA7awOfAgnMNc3IGO3NkTd5qiGnZ3Kq3Zydatn0hD0fyFfCK?=
 =?us-ascii?Q?W5VkgugVwLKGz34HYh2VX3PPWFoeaTu3Px2uh2W8vvojNbNBPuiig05UeIZ0?=
 =?us-ascii?Q?8H+oMyj14Qy9DDvowhVBvWM6vgRkLzW4WSzOrk0kGzfnentjD7r5weNnLOm2?=
 =?us-ascii?Q?7d91fgjDh3pPivqqskoqHFpqeJmdob2VZ3IgtN2LRSpeZWmb4w6yMdO9TIpr?=
 =?us-ascii?Q?Pg+6M2Lk3pldv/P4I7xcSr31C6VV5ktxZlQX1Ohwsw7RivvxhbPHz24DSrX2?=
 =?us-ascii?Q?St06DPRFMzwwTgv9TU9VkVI+hA4pgDpCX2k2beva3UxSdr7I1BLvlqo+qsfS?=
 =?us-ascii?Q?tbUfemnyqa2i+wDqM1Noudken2EflHt8rE5oBpzo4AvVfRyr3lAiosLl5NcS?=
 =?us-ascii?Q?doUuM8RnYBdh6xghM3I1gK798EFWiuuEiZBxiTOZaShjtQRBxq43mT+0vIWW?=
 =?us-ascii?Q?MGsmz/BjMgvMSa2cEwF4kC7mGw2y2dXEJcOIcYyQjmA9i6rWrVlHDyMXhtGr?=
 =?us-ascii?Q?kiRFQkjsztTRWyF/ZtrgH3UYksezXZeNSXxAvc4xSTAFEHXMrSBCIkZE7q/F?=
 =?us-ascii?Q?4Hf6Fqb+2wb8HX/3YODnOfYsRyek3+XV7nPonDAML5jNS7t08A8FCJ4ifi6N?=
 =?us-ascii?Q?BFId9rGCrQ2GcbwqCCpnQSK1VDoqY2ShVhcOsBklpUrNsO42EIy/3CdmGQRV?=
 =?us-ascii?Q?R0LmOPmDOf7euV8OPeprZht6J41h79mlxIvI+b9rtvgSpOLXpTy56hZJJhif?=
 =?us-ascii?Q?ft30AThkBLWJLaaFi6XcXIR6XEB+Z8rlTXBeFCJOZHIABLFtmfEEXhtu2Q4L?=
 =?us-ascii?Q?u+/MoEScH+AUhaOaWKYKq7q1ZksZ7CQrWt7dqYr2n2kn+xYD1uBc/3uUoFpH?=
 =?us-ascii?Q?NXWtn5Sq5SjuUXMLhoS57Kbsn+kAFtYAKbd/eSmszbqJUXmcIjxFvcN+T0hu?=
 =?us-ascii?Q?15KVrgmn12V7T1AotBaHcaP4/k7HiMGnIH58ZCGKPaXYkFQZIRYGpyf0CmF8?=
 =?us-ascii?Q?khNbAjVUeQCCHQWgkN03VxP/zKgl/VGnWxmwSVpmxBKidgIHsQ26aorQq8ho?=
 =?us-ascii?Q?W5ZGOwcQmpQWYUrB8tPErWKoBmFlglVFiHliDEG2nh1w1j1h4tESqBGpjLCQ?=
 =?us-ascii?Q?Mr6Q8WjjqgvnsV9/fW6WfYDkDei1e+fIrKg6jWrgtpXo6hy6WDQXB5DBe+HD?=
 =?us-ascii?Q?e0ELwcVqCmBxUSaCs9XnZM76Jt2KtyAMs2b9vqRJ0FgLm6XVp5TbikaPLg3/?=
 =?us-ascii?Q?dfChkc6x8/TVohhpziXnfjFobDB85aRFmxbvLzA7pgF3X9exNTGN8S9gEfpm?=
 =?us-ascii?Q?zpF1vrxif0uUCf1ec14WCoL2KMYIfoHxeMr7Kc2aGu8I0gcDK+FJnhe6FdOI?=
 =?us-ascii?Q?6yXlALo0SysuzSYQN7lAVhjRaxt1KZxgEcS+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hT3QGoCfPZ1ffmfoHddRix18VBn1i7ugpQVc5RE3OS1oPy56rS0FzjlNc5M1?=
 =?us-ascii?Q?UE3KahVYlQdiGBx3PFuG++daWsiQDPWYgXJtY1XIhDnHTeGu2gjIx9ZLn38R?=
 =?us-ascii?Q?jgelQ3xXacztwK32mHa6492Ibc14IhgNGrPYvgfR2FMLd9Y7HCUBnNE4UsuG?=
 =?us-ascii?Q?SnSFodcTh4tJpF5YC4XjYk2j2wSq2ZUdSuaxtNMiqMWrjLZJn5ndZzovWVMb?=
 =?us-ascii?Q?+mtcBREmJHYTIEV1PpE1Srw1ifa6nn61+WUNffqhNzP3zDErx6pWzOZM7WuK?=
 =?us-ascii?Q?jQ5mmBzGh6urCVRObyROHbihAF4M+8GTNAPctc9olMGLX7vDQaXgE7JqfQcE?=
 =?us-ascii?Q?fPuqzsgfH2w7jv3bx4GmK5pRk9Ik1lsrHlIUzAdzelVVYQ9vrw/pedX48lRp?=
 =?us-ascii?Q?wom00ekBaNn+ZsCkW2L93qfcE/TLj4GlopD7TC1J2QK+0cDUqWjjGcN/6n8M?=
 =?us-ascii?Q?Azbzg8FejTcKTUdXo+0vmPhSjNHLpbhZYfJ8oI1q+1D0Ev+lsIKe84w6rjHP?=
 =?us-ascii?Q?Rp/v9azVG7kEF+HbE0/GSf0SxYemFSeri5TO0+2o7M7T1cH4Wxkm8D2xfyHi?=
 =?us-ascii?Q?B4Ia7g32M1ufOOhDk8aPjT4awTnjPZB7aChVg8QPnfFAn2pO4aHf9z1TfF8B?=
 =?us-ascii?Q?8Ut87TsAirGgvVt/1s/wz6pSOnKiuO+0cEgbR8aQuCemgMwiIBB3UwPJ/oCM?=
 =?us-ascii?Q?i4WZA4aDoW+erAlDSOzk0+zIIW4UFSD9yei8ITQP0khZK041X/gHAsnEP8Ah?=
 =?us-ascii?Q?LlLUngDDGJa285+BspysHgV/QNGw3SyC4uqc9amHgwh7PLBMPs/t2ap/q81T?=
 =?us-ascii?Q?Eb43K8YmXX7FciW1v8YWpmnQPetBHxrfvYU/dS47OVkiBkXAUFKrMRMdPK9j?=
 =?us-ascii?Q?fdoPeijiJKqCz0TinXeKAX14EASKeA9ZYLf6c1/oKnkWXrAK39BRLDyvdHZ2?=
 =?us-ascii?Q?NU2n6c2pgIs5v0GA9OxV0J46aTjZYvBLqBaTkx2TWMBl1wd8u08zZQnMyqTk?=
 =?us-ascii?Q?FLsT9zFBJSQUh1UAhxlGvRV0g2hUo27ZRFcUzuWdjnQ2er9kkJuoOOM5z1EI?=
 =?us-ascii?Q?3XhEZ46K1GY40jBJCAU9BczspacQ6TsavpCmlAAb2Wim6l1VJAZBL72krp/1?=
 =?us-ascii?Q?q6nKC8b7hv9KBSsSNlu8YxYWexTRZy3J5EGIuuF/TH9LAzrpsFf2bF/hsHCQ?=
 =?us-ascii?Q?d4jjRtUsR1M3zBGyxVb0HAiZcw64cRj/d2qiFgv19VroqmDebMo4CznX+jm1?=
 =?us-ascii?Q?H1v/4GdgNo8N7MMZluOWHY2pNZ0JI3ZINdwRWWsDIS+qsgFbpbS+3L/HakOb?=
 =?us-ascii?Q?Yoi1OPh8bGwsXqlv6VZWprZ/oUdIXWVJZbbdHYLwVwmZQp58Jeb/HfYR2zM7?=
 =?us-ascii?Q?zVKAVR9N+zyn1z9wfzN7MtJB2ofFJSXdGtPaDQWQGX3k+Jm8TkBYIcdNEIng?=
 =?us-ascii?Q?6F8SR/ImKJhOXQ2xDUhgyYRS+7CpoiyRulYb/HKEWQ/AneU2++H5+li8kegz?=
 =?us-ascii?Q?Dq5+8mMI/YKCqBoY1HOtbHPwBMx2qTyaoQyJj2gWHKV8NKK+LDmv/LEUxpQk?=
 =?us-ascii?Q?dy3EdKns9IYewlH1TrI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: befb9d71-6333-481c-faab-08de3709a4ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 09:59:29.4019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBF5IasD2slAstQwp8jpj0+f5wEag3V7xbRT+5bhfQGvJVnmELPf+RmbSx/79zPPyK9qzCg7jFlqOuDijYuJEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9992

> On Tue, Dec 09, 2025 at 11:08:08AM +0200, Wei Fang wrote:
> > > On Fri, Dec 05, 2025 at 06:53:07PM +0800, Wei Fang wrote:
> > > > In the current implementation, the enetc_xdp_xmit() always transmit=
s
> > > > redirected XDP frames even if the link is down, but the frames cann=
ot
> > > > be transmitted from TX BD rings when the link is down, so the frame=
s
> > > > are still kept in the TX BD rings. If the XDP program is uninstalle=
d,
> > > > users will see the following warning logs.
> > > >
> > > > fsl_enetc 0000:00:00.0 eno0: timeout for tx ring #6 clear
> > > >
> > > > More worse, the TX BD ring cannot work properly anymore, because th=
e
> > > > HW PIR and CIR are not the same after the re-initialization of the =
TX
> > > > BD ring.
> > >
> > > I understand and I don't disagree that the TX BD ring doesn't work
> > > anymore if we disable it while it has pending frames (the TB0MR[EN]
> > > documentation says that this is unsafe too), but:
> > > - I don't understand why the hardware PIR and CIR are not the same af=
ter
> > >   the TX ring reinitialization
> > > - I don't understand how the effect and the claimed cause are connect=
ed
> > >
> > > Could you please give more details what you mean here?
> >
> > Currently, the hardware PIR and CIR are not initialized by the software
> > when the TX BD is re-initialized. The driver just reads HW PIR and CIR =
and
> > then initializes the SW PIR and CIR. See enetc_setup_txbdr():
> >
> > /* clearing PI/CI registers for Tx not supported, adjust sw indexes */
> > tx_ring->next_to_use =3D enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
> > tx_ring->next_to_clean =3D enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
> >
> > If there are unsent frames on the TX BD ring, the HW PIR and CIR are
> > not equal when the TX BD ring is disabled. So if the TX BD ring is
> > re-initialized at that time, the unsent frames will be freed and HW
> > PIR and CIR are still not equal after the re-initialization. At this po=
int,
> > the BDs between CIR and PIR are invalid, which will cause a hardware
> > malfunction.
>=20
> Ah, ok, I genuinely didn't understand what you meant by "they are not
> the same after reinitialization". I thought you're saying that
> enetc_reconfigure() runs, and the next_to_use and next_to_clean values
> are not what they were before... which they are, according to the code
> you pointed out. You meant "they are not the same" in the sense that
> they are not equal to one another... I think this really isn't clear.
>=20
> >
> > Another reason is that there is internal context in the ring prefetch
> > logic that will retain the state from the first incarnation of the ring
> > and continue prefetching from the stale location when we re-initialize
> > the ring. The internal context is only reset by an FLR. That is to say,
> > for LS1028A ENETC, software cannot set the HW CIR and PIR when
> > initializing the TX BD ring.
> >
> > The best solution is to either not initialize the TX BD ring or use FLR
> > to initialize it when this situation (the TX BD ring still has unsent
> > frames) occurs. Either approach involves complex modifications,
> > especially the FLR method. I don't have enough time to fix this issue
> > for the LS1028A. At least for now, this patch is what I can do, and it
> > doesn't conflict with subsequent solutions.
>=20
> I'm wondering if this situation can be completely avoided in the first pl=
ace.
> For i.MX9, I did see a "graceful stop" section in the NETC reference
> manual, making use of POR[TXDIS]. Would this help? For LS1028A, I'm still

No, it does not help, but ENETC v4 supports setting HW PIR and CIR by
software, the latest NETC BG has updated this info after I checked with
NETC IP team. So I have planned to add a fix patch for i.MX9 after this
patch is applied.

> searching, but there's nothing conclusive... I'll experiment with putting
> the MAC in loopback via COMMAND_CONFIG[XGLP] and then drop the received
> frames somehow.
>=20
> I think I agree we should try to avoid sending packets during link down
> even if we later have to recover from those packets we couldn't avoid
> sending. It is just to try and not make the problem worse, and to make
> the recovery procedure deal with a bounded amount of packets rather than
> a continuous flow.
>=20
> Could you please resend with an improved commit message where you
> integrate the clarifications made here?

Yes, I will improve the commit message


