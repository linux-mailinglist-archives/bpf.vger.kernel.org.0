Return-Path: <bpf+bounces-78861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD6FD1DC2C
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 10:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE3C130321F4
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A8338736B;
	Wed, 14 Jan 2026 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A5D7e1eS"
X-Original-To: bpf@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A93803C0;
	Wed, 14 Jan 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384659; cv=fail; b=uYWavrxfu3S8lJ9b+WUH8FOPe4SEI1liixnesNtci5KyepHN+d82Homr0pU5vZ0mD8KnNIWO1xv6a/YUkTt3IfWL+zd4xLIVPOo5kWGCOJOfiPqdy2YBEtftpGcK5c1qw+BCztTngnr1UNitM6b5rt1WVzDI0yGmWwdSBmWhyBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384659; c=relaxed/simple;
	bh=6qe0qXuOl9RsgSqVHKch7biY5RL71Eze2B788wGJ65E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lKU/oyAZIhD/9KRbDO+zGEFJk60FPHo/cQCmvcK5mFpkQ9mxjGVESHHI0w1InJ8D5htAiNieeaWRUPrM+XK3qVRdTtu89ZJVF2TVQXWvvG3B8NFdLODh/eF8lbRTg14bKsW134g1OaA88ZONnKJD54vGYOv3EAihnnOVhHLjxvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A5D7e1eS; arc=fail smtp.client-ip=40.107.159.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZOPFrLk07+MPmvx/J2TSj9pIHBkr3eTpKolnrxoaq1T2UCFfknYXzZcAY8u+K3OfiNg9xqMhtHSCU+hSC9mvRgELJg9aDOzLMdWv/cqnxgeIJGDfzV42+PHmnWmDTBmIdK03kOS+eIcPEJ9F/dySfF1aY5poHnw06DVlinD9XxXZr2ApASjNz+of31fk+ZR4uHJ227ApPZZzNIWu2u70EFf819n8GvTCEjeRdU1GArULXFbG3q37ZV529IpdTzZ/OyMs/a9puYjx1MyYibEWyxfJPsYtH9JM/MdE9qXFcE4Gb2DmPknqrQpPoq26uHRsKtrGLwFXYxqToa28GIHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qe0qXuOl9RsgSqVHKch7biY5RL71Eze2B788wGJ65E=;
 b=yQe5VmxkkuJk1r7FECghwGvt65WlSYFNyT0n0X4KqJ3wfm8PFhBFu/e01KFQsgaAWHl2m5QS9dfNnvQ3yjwV2FAiX4rpJGMUlxt0rk7/88fIRVomKbxHnb0oDGJ1YsHTaxmZOAAMubM/+CX8ayYOx4kr+mzj/oyw8qYsd2JZQMu+49CpppoRaJiji6GBw2QtTQkYWOvufDWSKbHjomoRtbrDyX6PP9+pxJbMbGoNd6UjXcqlmzSrkyjlKpxL3lZfi6Kr2xIIs0G/fZG9WOryc+K0H8rv7PkWlxys4xJfKMrYxF09nHnrpaUgauVbJEz1SMI/qkC+TdgdBgICqobyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qe0qXuOl9RsgSqVHKch7biY5RL71Eze2B788wGJ65E=;
 b=A5D7e1eSMrQcjAErOE5+6JrbSJD4q3rPL6oao8jGbZ6BDJLJWJAKerVQ+7AgxzDx94YRIfZZdawVcl/hAjJhaztg33mA/nytBZGBnZVwg9dISSp3CW0w+CVGtn9D5n/eZjHWgWnhbsu5tfKDDT1Twbd1Ol+QzL5W/9tUcdNb62I0Qwsbfomu8J51j17tOV1G57gHkV5ahfPn7l3q/NCxhOI3clBHMaHXX4IyvbiDrgUNYQNekt86pI73GujAGOxR+Q/WwSXD4aK6ivvn78vmywLpAvs5mz1n+uTV6kFQn9STqrdKe54sATzFFrNXlqzoJI/icWqE4IpXsTz5ZnPbDQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8383.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 09:57:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 14 Jan 2026
 09:57:34 +0000
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
Subject: RE: [PATCH net-next 06/11] net: fec: transmit XDP frames in bulk
Thread-Topic: [PATCH net-next 06/11] net: fec: transmit XDP frames in bulk
Thread-Index: AQHchDz627iSwMOpb0yRsS69dhRjTbVQR58AgAEhOdA=
Date: Wed, 14 Jan 2026 09:57:34 +0000
Message-ID:
 <PAXPR04MB8510FED850459727118CAEA0888FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
 <20260113032939.3705137-7-wei.fang@nxp.com>
 <aWZv/mAixEnFoMK+@lizhi-Precision-Tower-5810>
In-Reply-To: <aWZv/mAixEnFoMK+@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8383:EE_
x-ms-office365-filtering-correlation-id: b2032e16-d32d-4bb7-e28c-08de5353577b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CC8+LMBWVCbTqINj4Xqns1YSnQKdLyb+GSKezWFTbVnMdBmKcKc6sPpdeXJP?=
 =?us-ascii?Q?TN8Elkpcc8Dkm2ebxTUuIM9ChgOU6aW9CKuXpsb9pq72+mzaCJNcDDoZz9tQ?=
 =?us-ascii?Q?k4G/+PoJmej/HFy0kGtHzCinG+sswNtnhXuaajsPE4OSQSg/FyiXwK5/Nu3g?=
 =?us-ascii?Q?pLEIF/urzd+iY7iGSD5u/O5TKb8bDLxbx9/U3ZQfkTCiJjay3yARKtjs3tfH?=
 =?us-ascii?Q?+XrWDQ3Stq5mDYQwDRBL230ADSL7vX/83wEc4PA3XXWkoYb+DFTUMsKV5kWn?=
 =?us-ascii?Q?BX7t7zuANyz7VL3qZtRsbGCrcDTvdClTtYqHUIQX0cN269ULS4sD4f+sx+Ls?=
 =?us-ascii?Q?jbzi356+X/TEI0x5NcVeomuLkGvUkU07FnanKKMPVt5qYF/fTVGoyv5eE4oS?=
 =?us-ascii?Q?iOycwckbbCNO6fU2Nkut53hOUqFL4Hh6U2jsr28xK3Fivrfggzyv2p+XpRz2?=
 =?us-ascii?Q?9lJUZRSrm5/JptlnXFtTR+31JsHQjO34aAEfPwUMIDtwq46On4/5qKDgEW2w?=
 =?us-ascii?Q?5EFvfsRKTTJaLc/3h3b82fZNni+1/dq5Xv5LdGLk3KxPx7EdOqf5fF9RNife?=
 =?us-ascii?Q?iW+Qmv4wY6CU0D85aX49Dp9Xx92oywekjReRVHGg5IjTlge+9QuIjItFaE1t?=
 =?us-ascii?Q?ZwHm28OSq4wTHn5OMo373rkR7WIROndCOCihZeQjbXbY5lAuq+D2TVMqpbkG?=
 =?us-ascii?Q?wOMg16ZYDtq6kZCzBrfX9Gb5r61Bk8MDlEthRntxIeIGqsKZleGML6jXI10s?=
 =?us-ascii?Q?e0+2xDeKJnOxDVoEWVbG0IcsYzEo6+g9p/gv3aKmhaMPs+8KEJj3fuGGtfad?=
 =?us-ascii?Q?1yLwkEL/5uWvkw+mAAQGehIJ8FOCMo5p/02BFkFMCOSUYLCZuQehh5HKHoD7?=
 =?us-ascii?Q?B0DS/82XWpCwIWbvVjpa7mmbV6MbEBrebb49m52EWT7IW/OM/qPqSxCoXRw8?=
 =?us-ascii?Q?tbV2oq5/XCdECLGy5IJ6i1e9IRzAd7G49i50MF7Ssr1FxMsN7yELCAeGaxW6?=
 =?us-ascii?Q?+VPY0RoUaNG/sS+hyMsmjKm6MCy3tfQwDSuT974ISLlSkbx4fYSSswCkR53U?=
 =?us-ascii?Q?9EnHYDw45dvqm7jm+7SbG2QueZJ7kLU5nCZ6fnbWH/AbJwJoEWHN8dtQ+k7+?=
 =?us-ascii?Q?UAtm+bcak39hme6RH5/IWfWuuIqvfAqKjBb+V33EA411p39GL2fCLeunvcA3?=
 =?us-ascii?Q?jO3wr+e+dCfvJbrluXeBf+hawpkl26sCC43GhBpuFmO7c9TrRSkA1kJ5Jy+6?=
 =?us-ascii?Q?lX1WJeNyKbSDB5rGQ4m+5fXI15+c2nZFnHMVqrP1yP4fKLMNbX6J2+HBlcDa?=
 =?us-ascii?Q?fs4Gkuwt1LWO38sJb4AKrlCR9Ps37bsGFFD78PB4QXPYzxLZ/JPBiThny2bX?=
 =?us-ascii?Q?FLORHjbHCUCwwJYTRYCs7+eZ9JwOXxDgyEo+5NbBqFtYkse5j4KlxN6/y9Ra?=
 =?us-ascii?Q?KQ5XofjusjQanVEDGmvBxVrDYRidecXeSt6LXZzwaQYMgxKJMXLO+OWSxVbK?=
 =?us-ascii?Q?y2qwBP+7PCvTS+WMYphFMI+wwqGWM1Zsf74P?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bJe5mEWbpXV0LfH2v8GqrjJy/IIKoRxpiai5n3rEmN9tMp+3sdSf/mglLdep?=
 =?us-ascii?Q?bqUF6A6hi4PLxDgmmpZfJkTWaXfxwJva3hJ/FdwpqtZ5pH0P9CEpe38f/+YV?=
 =?us-ascii?Q?p9NS3iZNESuvUZ61fE+iySAiTlGSRuKb184WE65eemxWUWtt2tpJUsoV4HtM?=
 =?us-ascii?Q?Jcyr20+fN1yv3fEkBFHErHO1gc74fuY6MTk+azQjbO+8yOaZ0Ig4mxBj2NDz?=
 =?us-ascii?Q?IZ1A0f7IwcPqAhg1cijZM0uaY5C7K9n9USezNJG6Ifhzlxgnp5CEefIKCGVA?=
 =?us-ascii?Q?uKBM8wDq5xHeHC0+vlse2Hbac66oniiozhDqk3Z2XsN65+vPpHWu0NsfuNEM?=
 =?us-ascii?Q?l1Eoo6bdCa20fsPY5ZeYjW+z6lbVT6BXxFw7sSJUEP5nSgVLcWme+nLrxHU2?=
 =?us-ascii?Q?Iu8INRFU1SX2xoRSSp45X2leNFdcj/NDRIaRRlKa3EvUOmC2/JMJy/JjVe40?=
 =?us-ascii?Q?2tXhl9oKOLUvbfeyGg4ejDtZlgjnPnEcN6Q2vBmmUUt993/i+VuvwTeO+1UL?=
 =?us-ascii?Q?B10QjJKEJOPMn7BaVO8KUKQQ5sya6JgPe4tJsXYHjJDzrePBnILYJVh7K1l6?=
 =?us-ascii?Q?lAOGeUjFlFp2kjHaQSPMoBdTbpocCY/oBvCHhNkA2JLc+Ri2qFPcXG04k6en?=
 =?us-ascii?Q?mCthzCSB7uXLXQ19yoN3cFIYfUcKCgEeCdBJQmoCAzAM5lkkoxSQdFBbApk1?=
 =?us-ascii?Q?z5dj+02AVJMKRPQ3D+4plT9FchwgwBIdwsepEt8Fb4OCLx8Q1jcTh48ovVUr?=
 =?us-ascii?Q?yMKiMkYc5KsUSuM1b+4Pg9I3DMJ0kXQs+j25xPzN5Ly3q1O9lgNgoiKg2Nbd?=
 =?us-ascii?Q?Y2+0otmizEuXneBGxZ2pCgVSZDjntJkCaUSXnBLEwEJni6i2I1Zuf4xMd2Qc?=
 =?us-ascii?Q?sYIsW6+CSHIftjDQpPaIHIaiNzyFUiFPSTHvSM7DyGlLeEmy5omDb77k2ZS7?=
 =?us-ascii?Q?G+XPd0Xo9ze64E0L3ZmZn54lcis410zGi46ER9gghViY9hgqlPL5K/aaf+Ff?=
 =?us-ascii?Q?Ae5TfPXVSWBOCkZLlPkjlCn3TamVWjyM4zO8bYuxuPQuQhwKWEkGquZpfmyJ?=
 =?us-ascii?Q?tWZvvONIdnen3+y6CfJoBfYI7eLZuxggJHXk0oitYQrstrI2SEgjE72dDagt?=
 =?us-ascii?Q?68K9Caj/CMedaxVDZJa0HIq+sK2FkCvL8a+SJ7RU2CtPsRJAAUO1A4ltPtxy?=
 =?us-ascii?Q?spxKNbhv/yyzPKjqIjb+vrxgLIzNz6l3Gjv6QLNB/R6/7Idl3AYK2n2x/0eW?=
 =?us-ascii?Q?pc8p0eUuH6R1miO4oRpvEriF+3rmwLhm8H577GALCu+AAtF7f+8nc4rcMqdg?=
 =?us-ascii?Q?yJut69HjxZaFLbW3NgWSAmobUZT9l+/Eod0Yzb2len+cMyqn7swRG3FOoiYJ?=
 =?us-ascii?Q?LVESPUpn35khFwC0uP8TrTVRHqioNxHyq/8n16sq4TuDSeSk6GY3NLjAZLAw?=
 =?us-ascii?Q?Ee3K+yqcgFVftc79l/Am9xwxWlFg1/l4rJcGI5P8h5oZCy6MGCmtVGCdrSSL?=
 =?us-ascii?Q?UJUZXoR6+erYFe5fc14TrymZOfdpIKnp9LoPSUxw5K1gylyUKPHWe792jtzq?=
 =?us-ascii?Q?iKcfeE5tpUCQOU9nOvb4CD+ZfkF6lNQEgGaFQAzTxwUfK4sT9sSD6eDewHer?=
 =?us-ascii?Q?IuC2D6+0AD4HGqjVHdEZti2mUJ0e4kTb8yBaTysQTxsywXvSeOFrEg9WnO4Y?=
 =?us-ascii?Q?P/HUTVWiy9Nk18DNjvolQ7mRX/16br2MigN4NQ8G+iuVli+N?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2032e16-d32d-4bb7-e28c-08de5353577b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 09:57:34.8304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LcIv1Cx/N/xTbuRVoiHC39e+4sIS1uzd/w0LFOGm6iFcfDqS1BZJ6VS9fTNX3bz3s23Nf8yIvRqLxIxnV52gJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8383

> On Tue, Jan 13, 2026 at 11:29:34AM +0800, Wei Fang wrote:
> > Currently, the driver writes the ENET_TDAR register for every XDP frame
> > to trigger transmit start. Frequent MMIO writes consume more CPU cycles
> > and may reduce XDP TX performance, so transmit XDP frames in bulk.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
>=20
> Did you test light loading case? Any unexpected latency happen? sometime
> missing trigger is hard to find when heavy loading.
>=20

I don't think a missing trigger event will occur. The driver doesn't wait u=
ntil
the number of packets reaches a certain threshold before triggering the
transmission. The driver receives some packets in each batch, the number
is not fixed, but there is a threshold. After putting these packets on the =
TX
BD ring, transmission is triggered. Therefore, each batch will definitely t=
rigger
transmission.


