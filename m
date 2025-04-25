Return-Path: <bpf+bounces-56675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBA9A9BF93
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 09:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22B04C1901
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBAA22FE10;
	Fri, 25 Apr 2025 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="PUwuB+25"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE32522F751;
	Fri, 25 Apr 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565306; cv=fail; b=AZ54AycNjO6SIg+hjjl+meoQADqtdRlUP6mkCiZLL3ilCdP3tgoue3A7gehHlhonk8R2XppnIYm2lpzYP8pKIj0EZmOgqqrXcBcFq/e63UN+yad8R6EXSXQpAtZD9JWiNeGmzqZXn63Ak/iOdj+tqnqpmS9GYvgIkzki+UxQ1zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565306; c=relaxed/simple;
	bh=XO8n2aW2ZjomMUbojXhQFHOHg6JtajSzIJmFvSP5ijo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C7fs8Ciys9vM6dzQJVBdV2WVxXzZPsPSN3iYkIpEd5Je2yzcFXwgFrExhkGC0KcKzx1+C3uRlsfPIvvFNITJH+Eh64tgN+e4CccXm/R5cCW6A5NTcZQPU3xZuktBZWyORae4wI2ttI6GsyFyHvaNXwJ0fzGYgXCzguwTwv7w1e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=PUwuB+25; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wv8v5MyNuDuap30ERhwf2RoWQSY6uQAY9MG9VLVmXFDVNQfZIRnYcS9DI3TADRNTJMpzK2a11QTThsMHlCBHXytUI5BnbBdIYPJ21TLPCt0PTL0gb3H3ARPJkckNJWlhjDWaW8JvxL0d8uidR//D8Z5oBdtnjVqTjAZD6+BHguFJPv6LzzIr3QJ6HPrmPSlt24nZgMKnD0+usE7nfic3pU6ltrrIAvgn7uKPmzcIvM3pUQLgCN0/Cch+pJPwd67jeaWRY4OjYwBft3newJ5UiWeZaQ0EJO4FCAU2NHNfmWRKDRWbEasCu5Q2hkQc59hfttC7sNQze6qx1z7BIxpPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrfZIWqt6ftOQa6WnVOyy2UOMUwOQg3RMP2xmxd+fSc=;
 b=lU1HISZbuftL/XjKeiZlOHqCNEh3+40zXF/H7T/Ytc+6Q8jcAkzm7qKRthYJ5ifsa2Y+hwlXw7piPHkT3mIWkvaqSEv0TjrhmL27OCdX3iNzjOfyXj3Y9oxGJDhAcyydLgL9vzm7ztJ76vjT8VLw0i+8PIIx2qJYtUg4yD4V83aOt9md/LS8dVsA/BrrxSmtzkuJXqO6IT9AwDJCjgmWWnj415DSh+a2UxTzoOv3vRwyFucCEUqlYZ+gcfRfgyWhz3eOzqyJbRLWJDgTdZpglfQkE6KPJLf2fOCny2dSG16XJoJv3MUdQEifz/o0imOflST4cewZza5Z7XBfY+1eRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrfZIWqt6ftOQa6WnVOyy2UOMUwOQg3RMP2xmxd+fSc=;
 b=PUwuB+25fApNjKpqUcSXysSPBtyZwxAr6hjONZTA7mASeWHknXS79SuqJVIr/wJxDOJNMYXqD/+LH8luiWftd7pLjXSRYwdEAXaPVP0oBaqjcp05gD/RrQmz+sAg0ZldHcejpBHnrPhOrzSlgh8LEGuXrlApbEznozp39c29bJYaERveumaIa8EptsZWCKBhxt6KsFX9lY6812vbxRaoT1DLVRlME1sEI+A3eCXKh8qOQrz793YDpi/fMmdIyGciyOdTVrROQfa3AUGSWuJD7T4BqNl9rqBzTlUtno/OyFRv/x9hQpHFJuR8iG25Pr8ZNSPyZLk/amm/ValktB9yNQ==
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by DM4PR03MB7015.namprd03.prod.outlook.com (2603:10b6:8:42::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.27; Fri, 25 Apr 2025 07:15:02 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 07:15:02 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Furong Xu
	<0x1207@gmail.com>, "Gerlach, Matthew" <matthew.gerlach@altera.com>, "Ang,
 Tien Sung" <tien.sung.ang@altera.com>, "Tham, Mun Yew"
	<mun.yew.tham@altera.com>, "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Subject: RE: [PATCH net-next v4 2/2] net: stmmac: dwxgmac2: Add support for
 HW-accelerated VLAN stripping
Thread-Topic: [PATCH net-next v4 2/2] net: stmmac: dwxgmac2: Add support for
 HW-accelerated VLAN stripping
Thread-Index: AQHbstql1M+19hkYQkerBvuZ57i4x7Oyv/KAgAE9OqA=
Date: Fri, 25 Apr 2025 07:15:02 +0000
Message-ID:
 <BN8PR03MB507342F36BAC5C304B0A12C9B4842@BN8PR03MB5073.namprd03.prod.outlook.com>
References: <20250421162930.10237-1-boon.khai.ng@altera.com>
 <20250421162930.10237-3-boon.khai.ng@altera.com>
 <20250424121721.GF3042781@horms.kernel.org>
In-Reply-To: <20250424121721.GF3042781@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5073:EE_|DM4PR03MB7015:EE_
x-ms-office365-filtering-correlation-id: e74f4ab3-be2e-4f95-2dfc-08dd83c8e594
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ODc91Oo+1ChFfN7yQsZ3dfMZLBeQ1Fq2FK3YNhm0dlW/ZlB2zuFIQ9S+VJ0F?=
 =?us-ascii?Q?8DUshvVjx6F1yts1FZhKgFbsuJarLjciGomV3IwmeXHMVohEa+IdVcOgx90i?=
 =?us-ascii?Q?AKTr294U52ZDm4uiiNw11jD72mdPklNeLwT/Q9y6Z3QnYgAHOu0+2XCdM+k3?=
 =?us-ascii?Q?/LT4gcqKdMp1Qs1YsWzewHfStfQ/kTIsP9KwmsjOLzXj5KkI+nZSlRCd4vOG?=
 =?us-ascii?Q?sO7/s9omKCGreLjOiGBPtCI+78z1+ZKxC+THYrdLyxF2S+X2QU8NkzE1P6Fe?=
 =?us-ascii?Q?UnlyAI8f1RA7wvcoxHxiU0sUijW9dVdQuaq3yoTx0tZIiKFuEBbVWrRPllVQ?=
 =?us-ascii?Q?N4Q1zwNSCAF1vB4mS4VBTdKuZel9cSo6JaKpyica+MtTfembZLgaXCRAwKd+?=
 =?us-ascii?Q?hqljQmEwOvkYsEWnQ90YrNuZQwuVXPl2Svw/oU1IQiKgbgNehnoO+pATNxWT?=
 =?us-ascii?Q?hQvRzqdiboQN2uXlScKzak0GXqfzF/Td1N72TZ2Ql31vzXBAteGCpLhBUH5l?=
 =?us-ascii?Q?yc32e9agHTX+3eGa35LDhCRlMIgmZ2KhQR3UxT4uRBOaOrXRoup+YHBS9HsZ?=
 =?us-ascii?Q?6UNPFE/lpTfhWI2YC5g17bR8R3HkYRoXNrkuNTg7We9+aAFeNwcu37uogrVO?=
 =?us-ascii?Q?WUTmlOBcvfF+ZJiXI8qfuCM/Ee+BmaBOEfYpTLc1FkJdawAzdi6K1C/MnJSM?=
 =?us-ascii?Q?Y2WdlRy3PGym+DcZtLj+F9zNW9KIZgnwsfDV8+p6Cqww6GdpkluPP2oyFTNy?=
 =?us-ascii?Q?Zz2wTNX43UEFni41zv2KiFfJw/ZLWRjIXG1HPTjhIsRGCB341uFgKZjdh/TQ?=
 =?us-ascii?Q?I7o+Yj7gX8nIj1Iw7B3iMJ5r/Lmo07jHnYE8Kscsn19jyUlw1Sy66eKScvuw?=
 =?us-ascii?Q?CuuPc180RnC5MnGtLyOPRBjA7vTyoltFNTdoUoB4iIltbxvdEqUCimwwvPnc?=
 =?us-ascii?Q?2X6VAxNMVV7oTGZs+NylUWl5w5qFHDjhTGPVwoiDRSBm/BunWU7iX3SYlrz6?=
 =?us-ascii?Q?vaIqwa0e8TcQBjVJIUEKEiAQLPTVXyaJJ5WBOFAE0Vn2txClclvkHnIpjzef?=
 =?us-ascii?Q?U7bYdEBGVF06I3zSSLjreGw/wCnJT3gUutNg0VIjyanN5NlJDHiaMaeiv0WD?=
 =?us-ascii?Q?k6ZHtYd2ICPjUnNJfPkKD0JvZz+zLdT+M7kL49+/zVabIK5w4lzvb2ZI70kX?=
 =?us-ascii?Q?H5Qd17N2E1EOlQAk/kjVoUC75q4pD3AmJMBZSYPoaHd3EIBJhKdZEV5NZr48?=
 =?us-ascii?Q?u7o16FBf1AigK9Rq4/bJlx67xKmoPshkh8QJ1onD1ilSXWFB9KYG+mLWiKMi?=
 =?us-ascii?Q?skoiE/P0Oz8Gxp52ecc+EAPUJTAS6kcl+yQ3/MxbRpp87AMWOem61N2OckCN?=
 =?us-ascii?Q?I1aRHb+wuIjw4A6RyOkuOCWVV+7U3F9LlRPQhOR44y2giJ9GtTluBAzn18Zr?=
 =?us-ascii?Q?tLMeHUVKfah/vr8tqeaLppuSxOR6myppc5TLzSeEBsMC4pGsDMjRZg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g8ONedgHT4Z5k8C7+1Ya7bLsPjeFF87J3vQ+WS0h8QIRE7jjtpxmnX+Eyxg7?=
 =?us-ascii?Q?Cd1/mheNcDpXYPUMTYG6Ww0o9Nj3hjbeNr9lLOkOZ188bffs4t76Yt0BKw+W?=
 =?us-ascii?Q?VKRxIR9L1MvBk7qVlF4PZJH8YhFSZ7W6g5AYJI8M+SYHVEKAH8BTcy4ADzqC?=
 =?us-ascii?Q?Jk3xAsAXJy80c2kgmM73uy3YNuDJaZK/itBbpP7qpTRGtfwkBbFn4iTydltQ?=
 =?us-ascii?Q?POvX0AvqeYtlnjJq4VyZGlEHmO2C5f3Yi4RmE4EZMIRV576uy28eEazymWPu?=
 =?us-ascii?Q?9za92GYHJ0pJyxMDxKNsgCh3SOxKswRyc2mdJ1a1oIRafvweIN06IcD81v06?=
 =?us-ascii?Q?ED7tB2sHsjBhOOUkCOIdD6daNOGJQKf6NyuOjzGt+wmgrMuoimGcFQRSSFJe?=
 =?us-ascii?Q?VF+0lA7HKZinqvDtxzdgZ8kxJQMlm5f2Ku5+cfqKLW6dMf6x70FEif4Q4lVq?=
 =?us-ascii?Q?co19iYaPR7w3NqODdevl1RgytlsMCtdS6PFvaw+dUUHI9rfH1N4A/6wbMyQl?=
 =?us-ascii?Q?a/Gs01XnVzDh0qsKxtq3oOaJeNvIF6X91ujk9k5pXsL+EV21s8dEI2wHdcwP?=
 =?us-ascii?Q?NF9lIpfENlsvE16Xb33Nf7Lf1tXmt4EYflhetcUU54A05ydSlkMAFeo2ZD8M?=
 =?us-ascii?Q?HWn1GGSZmIOJmn0/VitQGcIG044hye8zFm3+I7Fvs0rHy333ZyaCwmjIijWe?=
 =?us-ascii?Q?aKBAzug8U3hqt+hbnImRZP98Pw7LX4/q6p7Q+Q0mNwpmF+NxjyBOFh6MPa8t?=
 =?us-ascii?Q?pzYRQPNu5WUZQUb1UcAfas+DJsDTx+/D9shjGWiHRx6z2glIsu5CbFXuk/uN?=
 =?us-ascii?Q?u00Z7ohCyz44TnZh7yqOouRCI58IccMEzWE8ZxWhiXY1+ICAOgvVIK31gcCm?=
 =?us-ascii?Q?Dkrxdp54oW6Cp8QezLrGuV4qt8AqusQEU/EL2R89K3r0jF5uF/dbtpOOxyeb?=
 =?us-ascii?Q?hP2y00GpRMy4jBhSMqwg8KbJxOFXim13FGma03LzdBdXUFvs6MOgKFHhZFck?=
 =?us-ascii?Q?h8zn1pFaarF3dAXzswW0ZHVISJ4hfwOdH9BXfbBDly9OxP3w+kuTcmz1Vi6A?=
 =?us-ascii?Q?C5gDv+oK1tmgVieT+gV/aNm6+Q60lZ931xB898dOao2E08PoS+wmlawtPH3j?=
 =?us-ascii?Q?w/4ya2nxgSzFMBYzr5HO2+Bbfc5jmZBSioKpPrsfdisiddAYX6c8e0NwdMQV?=
 =?us-ascii?Q?UWhAvtdL2eB8wHz4GHaNYhx0Chv+FGj5pnf8uvZvMbH1vtZaX67KJzA7vwIa?=
 =?us-ascii?Q?C3V4KiInCzr/dNqkoM4CmJCkD3FXOWonZ6PA09Ki3+2ay4zFyBEBA4gj+O1F?=
 =?us-ascii?Q?g6er0tWlyIwGMEIvlF5T2AI6aovHwBj9LvK63dLr9ZfntNiyHxxelYOec2em?=
 =?us-ascii?Q?putkH+2fs61dZzMkCXOFqCmGICrmHixtsGKQ22+APb9qBEn5HRr8Zg/dbArG?=
 =?us-ascii?Q?NhtXOnHK/izqNzKNGo/pZc+vxrXhP6tUKmRqueRIUqGPxmtaAuj29GMMXnBI?=
 =?us-ascii?Q?0dLxDEm+pwgJwbl/j3GwoynNwmH0cSZ+PNXMPyZAgPBHdvgAH3ZzTzINBS9+?=
 =?us-ascii?Q?Ihejvc0rbn/+EzRNH35s5XCc8X5yxADV8PEko8WycwG2uQ37VrLh9JUkt1RH?=
 =?us-ascii?Q?1t2LbjBItabCrtkrIsFo9MUrtyeA+Hu32a/op6VqdTA2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74f4ab3-be2e-4f95-2dfc-08dd83c8e594
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 07:15:02.4354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGYcFeov6NvESb58taDraX13Vm+/VPMmUK15ohGfUtFdHX5ZbfgNU8rfQfHJpb0Zo3tDX9JYvp29mOeoJlk29Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB7015


> > @@ -69,6 +70,21 @@ static int dwxgmac2_get_tx_ls(struct dma_desc *p)
> >       return (le32_to_cpu(p->des3) & XGMAC_RDES3_LD) > 0;  }
> >
> > +static u16 dwxgmac2_wrback_get_rx_vlan_tci(struct dma_desc *p) {
> > +     return (le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG_MASK);
>=20
> nit: The outer parentheses are not needed on the line above.
>=20
>         return le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG_MASK;
>=20
>=20

Hi Simon, thanks for the comment, will update in v5.

Regards,
Boon Khai

