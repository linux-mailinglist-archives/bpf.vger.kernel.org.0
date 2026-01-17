Return-Path: <bpf+bounces-79356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5910D38B85
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 03:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D09F13038CE9
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 02:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992EC311C15;
	Sat, 17 Jan 2026 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mswtfyik"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8A074BE1;
	Sat, 17 Jan 2026 02:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768616185; cv=fail; b=vCPWAVg+ZMdmf1UdeXn3CvINAs5uoeygCqoLheeZI/0yjgK/Twws8MXgbQtVijzlI+OnAxmV6H3cbeQCJs9KjPZbq93vAwd4O5GSjAZotCIJsCvEq0Iz7lHy8n2qEXNtXk3Stxd5srBN5sxyo6EOAjzRhGvW3aQ3oiIS5qYmpRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768616185; c=relaxed/simple;
	bh=HX27BWShgMwX+dQH3vD/HsI9i5wsGirvq9Nqm2wjb/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NiK3ISrgx8PijqQy0LfEipz2ZoLWmrQhXOcRG/FkysSs/CW52LYLc2VKqcBSDlg/88D09+AX5rYrek2qMVyoUy/n8KK3L2qJYADDRykURHsFG4MDEZR5JOxVhQuyFoFBA65gdC8E/koPD4xSDemwJ20viQjgbBj0WfaFQWuzuuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mswtfyik; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZtl/ckYThGnXYHx6nsqeOZDtBifR675ZPlcCjmnwpU3GwZnvcLXh0QemvSmaIPDMzjlSIjuDIL6wIETebk8Z9R37h/3dm7oytEDPkiT58I/ZR9Jp7MhyZPhTdHWiVMSwRgH7pbZ/tUeW5+Gk9nY3TSB+MBf8ElIONNCbmuhxNlgakeSjuGkXtF4QC+YrppifrfV5SLX1aUjq/Czs5aOtMrIVq0xI7KpZiaofoY0SnoAruBChRxtZMd/AjlWaXRkdxV2PIW2wM406MehtPc8qxhUvWfWoZLGFxMHj4zVyWY4UPb1BYqUiDlCPxZvJzDdEkj530g/5mfvAtEKajaXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EjVPaJGIeux5qV+sXPxKOnfJFqjPouS9PiiFwuf+kY=;
 b=tYYW1AEAkKpH54yrqWN8J5OeHdq4v2kLjhkThuR0Tqwohof2F+dCbl4jdpa0UUpu1s7jMjATZpuGLIoNOdXeyJYI7wfO4YqBKdQ0nE/l9fQUf8fC5c9bXCSkFGKo7kasbOq32PqCGyiw1Aw6kZwjwxezK9sIbLXboWOF5NuqdGkuk6c9PzHH0e0BfAz3yLGVnj7WmVlLOmQ325dWVT1A5vUnjl+nq2jkU/pXnb/98f550ZdXhasITFNcWXz6KCliOSdaA3TUB7fyscByiTsY2VLLKpRn4wnxXK6+2H2RmVSpjuEcIKppMG656w26e79LxJrPIZtxN1oOUXgT5slq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EjVPaJGIeux5qV+sXPxKOnfJFqjPouS9PiiFwuf+kY=;
 b=MswtfyikAysKH/yrlkBT6+yZClaa5/PA5t74jeduhcOEQANqBwm3JYT5KUmbIrVHCb/IyQGlkt0+JUAYGvj0YT0yaYykaKyfyoa8YDPnzx/pirGBsiePSphRefBq6MpCBV0hpPO4NDQsmocrOcl3bFFfRzitYAc5CoiGMvgwDgCX/kmGcc7kANUvUABQYh6OJ/iIvco4treQiaNjOUa+SUzwrQI+4rdIrh8bho4RgsxQiNja59iYVxY92M56R4NXoHII9dJGkNzCnB4orATnCvERqLLOvdf5ZtAXTlNBWC9vMHLDwWi1CPmxmA8vsnkBGSN5i8GvYxLBnx3xnpXMGA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10508.eurprd04.prod.outlook.com (2603:10a6:102:41c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Sat, 17 Jan
 2026 02:16:18 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Sat, 17 Jan 2026
 02:16:18 +0000
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
Thread-Index: AQHchrucPRBnp7Vpd0ShBHdoinT+BbVU3icAgADBkTA=
Date: Sat, 17 Jan 2026 02:16:18 +0000
Message-ID:
 <PAXPR04MB8510A564C6DE0459BC7E2A46888AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA2PR04MB10508:EE_
x-ms-office365-filtering-correlation-id: 73c73a71-951f-493b-e9c0-08de556e662b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PwgfXKwKHv7bE/jV8J4bxpWIPupYQNkE6S3F+bJV8go2u0cQFgn8kzut+6Kd?=
 =?us-ascii?Q?QOXju3C7pyqHZR84724dGsqqztG8JB1+NFa3nUFhZ8JIVom1NlZ2gFvoMzLV?=
 =?us-ascii?Q?m+aKtxgytcE6iMeT/IzgwgFxj+PfebDUY+vac3q81SdRj8cXKVlXcOYxwwmz?=
 =?us-ascii?Q?u2ZlidB9Sy2etB2QsC9hIDkZY3zAP7E58vP4vqU5ILNxhUl1EKd+PWVlfdBk?=
 =?us-ascii?Q?tHlv+G4rh91d4488pm1ID7sRpASI81SzXl/OspgwRqRryYwVVGvVq8ThB6SU?=
 =?us-ascii?Q?LVTT7j7+zxkrx0Qo0ZR6dLnMqagpx0EOB9bhXqBYRQufIHWIZQYK20OQTc5S?=
 =?us-ascii?Q?9kbuLOqjHuA7A3OL30ykFD1LrrOC0ZibmBsjrTk0+1bhyAMKRXUZ/W2L+6Ju?=
 =?us-ascii?Q?MGp0aCZ7aKv8y+X4FGl4rFinBshRZdVZw9zVfcrd1EwlKo9z2gfu2Lj949ik?=
 =?us-ascii?Q?IYjXrwkJKRmAgFiPbO4O0ElclAt5Q11LMDM8Ql8GOzHBWX9w5BPaOGtShtXm?=
 =?us-ascii?Q?F6KTbAJL6A1UPybZBJ125GNVZ0cSmVaaKdq2KDXr9D+bBgkNJI80r6GJwb73?=
 =?us-ascii?Q?HbS3ECEhVrSajV8fbpmqDxh0OJ9nDzlIb+QDWGSwE5darESeK9cSbnpwUYbs?=
 =?us-ascii?Q?CVA9HMJOn94afLKSNpLt4xcjP/t+01uFE0nE6b3A9y9XiqEM6GoMMcOAMZ4W?=
 =?us-ascii?Q?aLh6zibxLOC5U60BTrVuCkqgCVXMnbwJVsfRPZuz2CZTC/P6GlFQrIvOkLFj?=
 =?us-ascii?Q?rB8RgYsDMz5NTdQ3O0NSwN3FTkTKTRDJ8VSZl9ojdjeYJUrRFIPHrKB2dE38?=
 =?us-ascii?Q?WG4DaYiEAywpc1pIvWx9DAUNueBJTx+sTfORs27LMQKHQcMrg4OQAvLTo6tZ?=
 =?us-ascii?Q?iOhao3JkD8/Xy3qr0dpuovYDdYduQMBbYdz/pvZy26A89CdLKjTMR4UeTfTY?=
 =?us-ascii?Q?+R+FFPue0ydKLRDxpXOP+aHhukYQCGFIDeIkAc1nk75S7n7nYlQYxUx7XmsC?=
 =?us-ascii?Q?V9zZ/LyVatU4wCZ7LJw2HMb/yeAzYumn9g/wqtwlUI/UnMMuojbPeEoEPSA3?=
 =?us-ascii?Q?WVgkfFPGsZjSX5QlnxfeGltiwfKRzaNaQFcewWpqpK6NC4/QqWHqegotZALl?=
 =?us-ascii?Q?DOKuCPEcqQH9e/5NyqJS3kmdn3P/Xr/DwmQjZCX5kjG3sIxBDNdsRC+onLOo?=
 =?us-ascii?Q?aDz6Ib9poCDBe7R3pFcCC+zc8SDpGvdpl9suotHmunHv0XKV81Dg3ex0but3?=
 =?us-ascii?Q?Mi+uweh18z4utkmMKiT4hYfNTNUq/Z1dVId2oTfJikf81eDjM3W4wz+ydAte?=
 =?us-ascii?Q?aCxz1z07twC/b2Fky7uxyfar+ON5aSqk3FRgVIWaMG4vSOAunLbHWEhdPJGG?=
 =?us-ascii?Q?01PlXmgo3zkQbPdLf1b197b1STj0mg8tCNno6++oCvGv+YZGtQKetBJFIExv?=
 =?us-ascii?Q?EYvUHbzbZa9oBskrhzrBc0FPUHpSjqd8EbAy3cRpVrfb2jAg2tSJ9Kg4GZg0?=
 =?us-ascii?Q?CsvVV8eOZN84ejc7VxPPMnWwiElOgw8Axp9Ke5yZoubyybxRl9/5aqGp0qLd?=
 =?us-ascii?Q?T3Z+25MFWrGK0VerWBPRLLmtDEkw0uSw7g5vVKHH54puBFN2r7yPZaaUkghW?=
 =?us-ascii?Q?owgmj/FEirR7aCVZXYJ+R28=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TX1dTGCCYffBNP9OWNEUfplxjD2c3zDcT1WjPVzu2rveW+5TK1scEPQs9XWt?=
 =?us-ascii?Q?aHMbcjET18+y0/a3jFq35BSmhXW2JnlSnBKrAwOwrMocmJi4HtHWA19RQdhf?=
 =?us-ascii?Q?loXKVtAe2LbAQyEiwsMdt0s7CBPlUK++IhxgRz9qeeTr8OrA7gg5n0OOVjp8?=
 =?us-ascii?Q?EVAIdjoYuTqi5SQ9RpOWF4mb18/rOcbozWJu5REFKJGDc2fhRwnR4T5kG+6S?=
 =?us-ascii?Q?J3QIGCNt5hpPfiE00ob1yxdvZ5smUEgrsrbdlMlK8g9zrN1gJzr+M8pFKgk4?=
 =?us-ascii?Q?G7zUyYGFI/UDzWqAa6wmTO144ZbL0EVokjTSEXAjnKdq9Pd9V7nFkazHHBvt?=
 =?us-ascii?Q?x9N9EHgQ45+D9tJeW5aJRYexfaqN9Rz2vTqMRejz/iWJF3N1Tk6WzRnkYK3S?=
 =?us-ascii?Q?q3H7QPwmF+h65d4i1qHAOmqjr+TnY7UTGYFMXvB2Wtzl1vWzz7P7bn0r/6Et?=
 =?us-ascii?Q?kmlH6xkCeKq2hiKtK+4XuUNd9WzKU+vHeLjRu+ovvQMd20Jd2W/1+k3T45Nd?=
 =?us-ascii?Q?rZsFBhSMGt/5lArl7uirSvMTG3CpwXZ1eb0PaHyJZnlwrvpNHw3GKi5FDD2Q?=
 =?us-ascii?Q?gAcDeqFTNtNPW9Y1WaGmEcTDgkVWmiQJNOH4uPGcnBZbjC0kp2SZfcp4MUMa?=
 =?us-ascii?Q?vEE9mFmqJ7qeduuqNCYrWsbE9Rl0w9+mugAbLOY/CkBP6IfLc7M3kiK8usXU?=
 =?us-ascii?Q?sTcxPhspEVzg0b1uowJ8eMQBDu4Z0wYvinmq4ACdEWQBDSriAI79gCEkFEYt?=
 =?us-ascii?Q?x0ChIqRt+9kxH+AzrJCDHvmxQdifIUTRyYJa2NAFWsSXPJouUkMk4M7l90ks?=
 =?us-ascii?Q?/cX/DsxPhfPXm8RPFKUo0Q2DmtZstKBISqfEVdMvc8mNjtq4lx4p5xd+HatQ?=
 =?us-ascii?Q?nMo+K88FkLXU9BGaZxRDN7yRK9tZZIMlrdDXRJmx+TagqLnls3yF5xapLPqT?=
 =?us-ascii?Q?PiyO4DOc0Em6qz0YkUs44kIo8Yn5Tjhox4uxj5OnAvACkyvgpmOdlielHSBX?=
 =?us-ascii?Q?pY00B/KgFIjdwb1ucl74Lw8qyX2sYc5gL7Xo4yT/vLQOG+n/z0Izt5cj7ZCw?=
 =?us-ascii?Q?m5gLPmsuDNXL+LBy+hRThQBcqQXoN0BQdFphE5VyathCWm9NXDWZECLtnOro?=
 =?us-ascii?Q?T8JuVbF1sqhATtJvxW51+ER6N7jEA6XofC1gxQo4jZ3Dabx89vQF+GBbibWT?=
 =?us-ascii?Q?PbWzoaz+Ppt7VEyr0TBQc0KD+MNfMLXiXZtS3DWznAlUDMqrHerR3c6xsS+I?=
 =?us-ascii?Q?ZzTl2XEIqpAafD0lwlJM1efzz6/mp2jNpGadyQBaHA0IPM4yyl9O5ZdTxb+w?=
 =?us-ascii?Q?cFpHGgSyapovuAihIgyfWLESFYvxQaPmXmNVIkPnFVXiUFCQecMpyGEtl0hd?=
 =?us-ascii?Q?TQgwlTZZdxCEzU5GofvlM2PL780uUqV56WFmBHiTyWCJotAzX9e7eNG4y/tc?=
 =?us-ascii?Q?4j7Q5mIMHB+x3kshq7oBVIGKNntjelJjqMv+tKM3LtsBNAdJgcN3HOu9TpoE?=
 =?us-ascii?Q?2edYvObIS12PN+ZMlQ9oT+kpydPopExeVMvSsdLilLYEDc2eF5zGBZo8qJGe?=
 =?us-ascii?Q?oyUCwNN+s6rrIF4U2eXKcwFYnjVv31v3PbIJg8BRRqhlpLKw505zVTN6JceK?=
 =?us-ascii?Q?TWhgxgyyB0f28GiDXjRMSweSXRu1cw1zZOsn027I/wWQ2cWhYhLC8DJ/E8K+?=
 =?us-ascii?Q?4362BZ2cdIDKBMApjN31fhbasolR9bqHcT6VftSr42pRYJCY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c73a71-951f-493b-e9c0-08de556e662b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2026 02:16:18.2029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zi5oUZhr49IVO3Uc5AIW2D4UH6LmueV91Idu3uxif+0RgvEPNnI3fbA21ZIuVHf8qkDsUFPlvEj2mlx1yZ+wSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10508

> On Fri, Jan 16, 2026 at 03:40:25PM +0800, Wei Fang wrote:
> > Currently, the buffers of RX queue are allocated from the page pool.
> > In the subsequent patches to support XDP zero copy, the RX buffers
> > will be allocated from the UMEM. Therefore, extract
> > fec_alloc_rxq_buffers_pp() from fec_enet_alloc_rxq_buffers() and we
> > will add another helper to allocate RX buffers from UMEM for the XDP ze=
ro
> copy mode.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/fec_main.c | 78
> > ++++++++++++++++-------
> >  1 file changed, 54 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > b/drivers/net/ethernet/freescale/fec_main.c
> > index a418f0153d43..68aa94dd9487 100644
> > --- a/drivers/net/ethernet/freescale/fec_main.c
> > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > @@ -3435,6 +3435,24 @@ static void fec_xdp_rxq_info_unreg(struct
> fec_enet_priv_rx_q *rxq)
> >  	}
> >  }
> >
> > +static void fec_free_rxq_buffers(struct fec_enet_priv_rx_q *rxq) {
> > +	int i;
> > +
> > +	for (i =3D 0; i < rxq->bd.ring_size; i++) {
> > +		struct page *page =3D rxq->rx_buf[i];
> > +
> > +		if (!page)
> > +			continue;
> > +
> > +		page_pool_put_full_page(rxq->page_pool, page, false);
> > +		rxq->rx_buf[i] =3D NULL;
> > +	}
> > +
> > +	page_pool_destroy(rxq->page_pool);
> > +	rxq->page_pool =3D NULL;
> > +}
> > +
> >  static void fec_enet_free_buffers(struct net_device *ndev)  {
> >  	struct fec_enet_private *fep =3D netdev_priv(ndev); @@ -3448,16
> > +3466,10 @@ static void fec_enet_free_buffers(struct net_device *ndev)
> >  		rxq =3D fep->rx_queue[q];
> >
> >  		fec_xdp_rxq_info_unreg(rxq);
> > -
> > -		for (i =3D 0; i < rxq->bd.ring_size; i++)
> > -			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
> > -						false);
> > +		fec_free_rxq_buffers(rxq);
> >
> >  		for (i =3D 0; i < XDP_STATS_TOTAL; i++)
> >  			rxq->stats[i] =3D 0;
> > -
> > -		page_pool_destroy(rxq->page_pool);
> > -		rxq->page_pool =3D NULL;
> >  	}
> >
> >  	for (q =3D 0; q < fep->num_tx_queues; q++) { @@ -3556,22 +3568,18 @@
> > static int fec_enet_alloc_queue(struct net_device *ndev)
> >  	return ret;
> >  }
> >
> > -static int
> > -fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int
> > queue)
> > +static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
> > +				    struct fec_enet_priv_rx_q *rxq)
> >  {
> > -	struct fec_enet_private *fep =3D netdev_priv(ndev);
> > -	struct fec_enet_priv_rx_q *rxq;
> > +	struct bufdesc *bdp =3D rxq->bd.base;
> >  	dma_addr_t phys_addr;
> > -	struct bufdesc	*bdp;
> >  	struct page *page;
> >  	int i, err;
> >
> > -	rxq =3D fep->rx_queue[queue];
> > -	bdp =3D rxq->bd.base;
> > -
> >  	err =3D fec_enet_create_page_pool(fep, rxq);
> >  	if (err < 0) {
> > -		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
> > +		netdev_err(fep->netdev, "%s failed queue %d (%d)\n",
> > +			   __func__, rxq->bd.qid, err);
> >  		return err;
> >  	}
> >
> > @@ -3590,8 +3598,10 @@ fec_enet_alloc_rxq_buffers(struct net_device
> > *ndev, unsigned int queue)
> >
> >  	for (i =3D 0; i < rxq->bd.ring_size; i++) {
> >  		page =3D page_pool_dev_alloc_pages(rxq->page_pool);
> > -		if (!page)
> > -			goto err_alloc;
> > +		if (!page) {
> > +			err =3D -ENOMEM;
> > +			goto free_rx_buffers;
>=20
> look like this part is bug fix, miss set err to -ENOMEM
>=20

This is not a bug fix, the previous logic returned "-ENOMEM" directly
at the err_alloc label, see below.

err_alloc:
	fec_enet_free_buffers(ndev);
	return -ENOMEM;


