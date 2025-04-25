Return-Path: <bpf+bounces-56674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB51FA9BF86
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 09:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0A49A5588
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 07:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0804C230277;
	Fri, 25 Apr 2025 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="dZgdZEa6"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F172E22F392;
	Fri, 25 Apr 2025 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565154; cv=fail; b=EWiNYYTeJFAVRDloPQz8882t+jUPhWlXsh+CviZy8r0YOLJYS0lttK3bMztOZzrs/zDBZpHY7/jRT30YIaoBezwi1S4IkuqZ11PskMUCTs9sVqcipdBOx/3dPyNtE5FzRCQGTiV9IrKX525H+C3nvwBID5u/oDOgF4DbIno0VTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565154; c=relaxed/simple;
	bh=WT8tfDezeTbiDAl4feNVIwxVP42BAYneGcUHdxQdTTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P2pmeiVFXz3J7UQ0PgyY2oyzoTdPilOT6cCf+mtqRIS0oU3qGw8pELo/fCRotFDy6aOhxAeWAtucMESy/H5enl55i+5y4kAuGB9AnYI1spQO4wdPJFXStDn1wVv8li3rM4b0LS3yxOk3reITrpwajzJNyNY7c8SDXin1An8bRCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=dZgdZEa6; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9dDYPf/S7BZGHpGpjniedlUGVLDL89MMypSlOR+N6jLOCkatOHxSC+/yiI5oH/H8DHT+G3hLipXKRaHlsYOPnqkaHQZqIwUdLAurYC6JTic6SwKbatgaeVel57ZEY2Aa1BVyJ1jgH9ej3EpZSDQDmuhqHteYUEdz5YNuvwHvW5JgzU0LKQ0mBecYnMZTd8QiYoeqvsL1P2o/if8AF/57Nrw/T0g40RpNk6s4GqDynJY2D7iy15nm68DkXlgNB8xF1jwgothK9cjWQOlBE5ap13TZuM0xMvrkXYK8Mvq+nJYsgBE4Azc3JGZQKvZsiQ2DupMoqqOaU0veD3mOg8J4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WT8tfDezeTbiDAl4feNVIwxVP42BAYneGcUHdxQdTTY=;
 b=t9doiPZf+UWDXZEjkpysn830YxHDtLCjtNU05lCWaIc1wFMX+spjuvkyrEnLjK+UXuXWY1dwPi3vsKp6RLYaJRGgfuEqC06n975Eajist0EqJm/08FTQOGbJ88vWuKfvw8/g47W2cB2At8esjLaib7ukmlGBYg8iDdOU4cYL7oMov1L+dEi5XKUCt7ZGByPSvuR3zw5AzUMDcznReC3PHTgxxz9YGDXdnIOB/JOAsu81iUoGtwOaVdf4/nBqkLkrSe1jrWwDlhu0w8OiYqkEJPr2cQFrFAiav1xmYMJ2GeWv7JYMQH9BNjGDiUM1BoSNrCJY6UDAbe8xt0DMrK7fxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT8tfDezeTbiDAl4feNVIwxVP42BAYneGcUHdxQdTTY=;
 b=dZgdZEa6t1Y1eBoSdRKM5GuDYwONPbwzJ4uVQB0axSc3i34I2WsFKGmJ0VpQcg7BYW7pE7un1pmy68H8fFYjfud8Gc92Ekv8YdKxywi1JnZ1q+RBLwKdpXm3mRI8ir4E41VrIRkzetwLet0fMd+FOySv1vs4A7oBwH8Kw1SJN2fhkSQArS/iONZq5q+hw9iL8K1g1b6YEQ3m4PMO7uGUB4WqKD3WSTSrkAGp6kh2kyfJv7rEUZVAbhQU06YuvvChWXppf2FBX3YA4T9yC3TyyRJwvsUSvJQd55mmsgP63ir0G8W2xYBSxy93XMKJSx4iVgPWzfQynbtvdSexGLDg3A==
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by DM4PR03MB7015.namprd03.prod.outlook.com (2603:10b6:8:42::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.27; Fri, 25 Apr 2025 07:12:28 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 07:12:28 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Furong Xu
	<0x1207@gmail.com>, "Gerlach, Matthew" <matthew.gerlach@altera.com>, "Ang,
 Tien Sung" <tien.sung.ang@altera.com>, "Tham, Mun Yew"
	<mun.yew.tham@altera.com>, "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Subject: RE: [PATCH net-next v4 1/2] net: stmmac: Refactor VLAN implementation
Thread-Topic: [PATCH net-next v4 1/2] net: stmmac: Refactor VLAN
 implementation
Thread-Index: AQHbstqfHgt1ZgfId0y44506iJ/Lf7OyvDwAgAAH3oCAATguEA==
Date: Fri, 25 Apr 2025 07:12:28 +0000
Message-ID:
 <BN8PR03MB50738164E226BA57863F869BB4842@BN8PR03MB5073.namprd03.prod.outlook.com>
References: <20250421162930.10237-1-boon.khai.ng@altera.com>
 <20250421162930.10237-2-boon.khai.ng@altera.com>
 <43ef6713-9ae1-468c-bc43-2c7e463e04f4@redhat.com>
 <aAovTY6Q-4S__0Mh@shell.armlinux.org.uk>
In-Reply-To: <aAovTY6Q-4S__0Mh@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5073:EE_|DM4PR03MB7015:EE_
x-ms-office365-filtering-correlation-id: df92f5b8-d0ff-4272-39e7-08dd83c8898b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1dvp8QhWsQNjMpeQuF+xw6IifCMR1RZncewSB9U6DFra1jtALjLbBWtXmv0+?=
 =?us-ascii?Q?Yzf3BcBPKrJpgPfPINU2aRUaayMhx614Z8zWO+Oc1HvBYpDPfAGIlzZDD3Nw?=
 =?us-ascii?Q?Y+aFRx0jOM/9XTV7x1VGYk7b19ThIsnz7QY/5YjR2Us8vfG1pkqWJVovnyLe?=
 =?us-ascii?Q?DuvuHJo43r4JUZiAA2iTJ418sEp0jo/OtHYU4UDXpWo+ObSNe5TXu3JX77ef?=
 =?us-ascii?Q?rCQP7m9gf6Wys9x38jjVqKCYTEV+ImpwtlP/YU9svcbfGjxPVpO/Mv/0Ph4N?=
 =?us-ascii?Q?LL4+saMyJmUOxGdKuvw4erILDrAwdeovQgk6JbybMXpioL81cGatjhXRLILH?=
 =?us-ascii?Q?nyjTzW8aBm3ijhE+mtgY9ZLpnxuXmnppBDY8pKhPQn1BsdyWJyDZkGDLV6gk?=
 =?us-ascii?Q?wwcvP2FYjbBIHGsUp6G6LhK/Cb+9TGPp7slW4b+WlPD8SwgWnIvXcfmb8+J0?=
 =?us-ascii?Q?QJkKmQa43OvfbQ4eC+gR32wtYVDwYPXAHYYx8S1OzY3uTFS2/eSvwkmuQhe+?=
 =?us-ascii?Q?tkarlqPzZLE87qGK9UUtTtai56vnjS2odtKuApARypUnIeufh4U7PvbLzot+?=
 =?us-ascii?Q?mUR7NlNU3T/xw0EZfzDKrnNl8KvX9Ha6runZTCA8kbUbH+xqkZIG7zlG+O4H?=
 =?us-ascii?Q?KjiPt7d3htg+yvis3c59Wno/ULjI0Lu0H+7GAQyGCPBDIkQ9cXAgZPIG6oG/?=
 =?us-ascii?Q?St4RthwEtVxujK7JbptNO9sQno+QZbpKcjvco7cmPnZ6SIXau6KNkVBHkf+V?=
 =?us-ascii?Q?0WDZ7OQb9FSHkZOQQl39Os41vHWddBuhGtT/Rdhw/bMgQnw4kOdydxErk1Yd?=
 =?us-ascii?Q?rmmBWMNqHUWJIigscVvMB/c2518Meh1wexpjGHWtoIh117gpVg3/FDMz+2Nj?=
 =?us-ascii?Q?51XcL3V+lG7aPVMYH8p8022/NpHwHp32/t1y8cqK4xXln+/cIxT8itTg1m+k?=
 =?us-ascii?Q?m1xwThLQDu/7ix99qC+TGCg0fpiDNweN1W1Gr5mYmPXfxxBHfEDEOGn5J91J?=
 =?us-ascii?Q?Wmv4h94aAcO/mblBDZ3m5EQT9VVk5POehFU666Wn3k6KWS86HvHoLPG4MugG?=
 =?us-ascii?Q?/hge3kAv1COXuNrWCovTRkyqJnSEoU0aQuvqBDtRAllXF/iR2FRQMtB6E9Y9?=
 =?us-ascii?Q?K18kSRP7ptPLKoYASs9UZvYZjYr7BQkE3Y/K3g/eJdlqIDmWBRy4rCT2FjD5?=
 =?us-ascii?Q?dAwGE+A+UW0FBoxG6r6MpC24QVZwamcL+q5kP4r+DpcTS2FAx1KJYMaLIgKd?=
 =?us-ascii?Q?qIWDZJid5Am8OwkWFAVdLRc3zaDueEgAXNcyyEAJdhNqqquuiq24MKJkZeVp?=
 =?us-ascii?Q?bsEtotxzagl7KQX7TbmHrk1U04CedjD5CnNcoLTmhEbi61/LRwCpATP19yIY?=
 =?us-ascii?Q?qE2GDjgeoUMDbilfdZx3pILqhHeKGK2toTxPLK00zqVMP6Awllp6I3efwd/R?=
 =?us-ascii?Q?qbf7er0qt2LP5HPZPhQ+2vSwy35gWBsYVNPGmrir5VQsfr2q/jWzcA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?feF7L0SPa1PBXmW+Rkgu9TZkgtGXXBRFP8r5KqYGD4WoJGgPinw4ifmgAnKJ?=
 =?us-ascii?Q?3ap300C48mzSC9Q+KRrOMOfQFPjQQPzPfVusRpnWOAbmUOX8KK/jIkjHtBr9?=
 =?us-ascii?Q?1gjEtTHd10qH+hkVZD4+JpHFwxBCwh+nxt21O98ePa5AFMPvvXvUxZAtUh2A?=
 =?us-ascii?Q?n2Pu8I9CHa77+T3eQ+rA4R3pC/mnc/8H/oCSHiGEr9FVix7cERmq3lQQzICV?=
 =?us-ascii?Q?5t7R32m0LCOCWxVJ5y/x5Ox4irfAzTTIRfGJxtc4z3DHpXjsdjUgPssKyD58?=
 =?us-ascii?Q?/M113CyZYcMxqAEqG9x715ITTgKG2pKlUztry3DnrqvzRAZRZVnbXUlQCJ22?=
 =?us-ascii?Q?OC+Z/1V5GngvwrcF8tghp/h2/vNIAEoDX2U76kclqyD8V6bJHBaWrvJvz3O1?=
 =?us-ascii?Q?GX56FW7LUPv+iup03xtVbrqlSh+GHC7vKrTd6oQIOhE7D1VWMDdkZdjAEIzG?=
 =?us-ascii?Q?c70uRCjO9gOV5b4Uj7DKvaqxB1CWeLQVK1dwHr42l98jD/7uLTeOIFy9Xgjq?=
 =?us-ascii?Q?J14o0GVwUgvBCFV+iUZR8cK8HoQnl6pRpC00zYYYCUcQWTBLNMHEeXRPAXyL?=
 =?us-ascii?Q?Xf2oubnoPsMWKdiCSfqA/X+zwqsayt/Hs37WlgW6XuGyqh/W2vN4rh7uRHdr?=
 =?us-ascii?Q?V1lKn2rfQ5wYI840CfW5PaTo4OoOScMMMK5xbt5ObtLyBhNAwtdpROfHrWN7?=
 =?us-ascii?Q?sffhGS56SeRpzKBQMb7we0N5kTeRjKuY/jkidoQGXy/561ZEirZjDZbuA9BS?=
 =?us-ascii?Q?lPlPy8DMx9Rpa38FmX2HAWfg2nX1oFwfRcgddDoIB2139Pawh/mNVhGIloVs?=
 =?us-ascii?Q?VCnOIbp8dsQLYKEUcnPPWuspHvXe1p6RSh5UTKw5Uu/Gw8b+QUcdl2PeB9Z9?=
 =?us-ascii?Q?449XHaU60eoUPQKoPMzOnTiOfU9HZz8T/6+a7iFMgCngzqTCkWLYV5jC6IdX?=
 =?us-ascii?Q?Lr5mAtPqFlKk4G4vr87gzp+W9zORKzkStWqhYs8ycjm8kvzZMhEufMjuL7PX?=
 =?us-ascii?Q?9qoeW99GrPlGqenA7Te1va55Fm5MtmaYwQA7KDAt3Uc0vxc/OQHzSZWtGkfQ?=
 =?us-ascii?Q?lcFqrTh1Ha9O7OXwzY9EKPrho73hK/TX/kSC331doZOuobyYB3nxlMh7zn8E?=
 =?us-ascii?Q?F7a+HzdDV9gOmMbvEF4LZruzWJ46fYPDL/NqKAwdEkyMR7o4PHeg6a0FUaK8?=
 =?us-ascii?Q?5IP3Q7B8Pwf/fK5OWdzZ6xTpoi12HdcPtbEt3uLLHnBO9mzNj5kXYELM1P80?=
 =?us-ascii?Q?+hOQc3Bg8u7xMXJB8RyqHSnoDvhvaFEKRWAtMeUrwM6PP0cyqxaNQCH9uMdT?=
 =?us-ascii?Q?xRtba0Q0/RfhdxjQcsWPQhFImR7JVpnxSovwLlR4r7/1CBZV19wr8ZKDx80R?=
 =?us-ascii?Q?IkEt/XsKBxsV633oNpHdYErOOp1uSt8zcm5xVVkmy23+9AmfPSv+xzGyrOYF?=
 =?us-ascii?Q?RwL/E/z0oYGO3Z7KngGdrnO9OoEo1Fc+LDZgL35p4dmtUSz81dQolJZOj1jw?=
 =?us-ascii?Q?qAU6MILA/E6VzZ3xIWGx+OnQFJC82i3MUjKHcnXYJnK5c0z3QodPYU63PeIL?=
 =?us-ascii?Q?9Q9Lt7Mut2gOewYXgdLIAqOeH8DRiRlaPaY9j+Blt9nORgaTM4tDIfXCU1qt?=
 =?us-ascii?Q?+rq1iowkWLjjcvLdzTIwmy7Ea1oI3DkyumnRmdyOSQHb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df92f5b8-d0ff-4272-39e7-08dd83c8898b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 07:12:28.0167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7JYO6CDETFGEvpbDCU/GUuspC29GNZxqQL4HWGq+oYHFkrnvIzGV2GntFuRxo+fHFuCI645c/png22gdJXQLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB7015

> > ... like the above on (which looks unnecessary?!?)
>=20
> Also looks like a backward step, because we ask people to use the helper
> macros where possible.
>=20

Hi Rusell,

These changes were not intended. It was my mistake to rely=20
too much on Git to identify conflicts. I will cross-check the=20
latest changes and update them in v5. I will cross-check the=20
latest changes and submit them again in v5.

Regards,
Boon Khai

