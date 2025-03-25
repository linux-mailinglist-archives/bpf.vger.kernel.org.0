Return-Path: <bpf+bounces-54708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FF9A708D7
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 19:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF64168903
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 18:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178D264A87;
	Tue, 25 Mar 2025 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XqH+H2iF"
X-Original-To: bpf@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020100.outbound.protection.outlook.com [52.101.85.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0125D539;
	Tue, 25 Mar 2025 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926290; cv=fail; b=O434o1MdEW+8Fgz8jP8oO5XXQvNKh1FUb1cp1vnkuR5abD/yaP7YOZDBPJVGDudEsukspjrqynFsH9QAbkxdSdDQ0f3A968ehGi3NCFRiEk1/0eDaxrdP3qn6Wxnvj+P0QK9eyuNVf7w4IbiTGzaiGaNGDvZOG90u24l6FBIePE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926290; c=relaxed/simple;
	bh=ZYLDD8JvW6dDenBopBEXTYMaEbbHqTqpAp78qoW+rUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=clu+0fMddapd2yaCUDLsohgpMfyvJzR4VwcxduvicA1q4J1jydZ4bssgs8S80U91dGAyCyOswCnLvnQS9j6WLAg8ZXILC6Co3QkBj5gT8rutHrMLcsgbyX5Ch+ACukPM3fce0e0DAf9quGh0O3fV060V35N+5rlB4ZD4oTjvD8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XqH+H2iF; arc=fail smtp.client-ip=52.101.85.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIjkCFT+XPCtWEtvDSkjo2EnxQa33rAsgnPTqs6HO3drLLTC8R/ridqR9ZqjUD0psvtTTcxNDZ9kHCwd1UcQnWJmslXJErmgst5mZaRVjNy4SK4adUX+NxsJDgQ6dzgz2ny5x1QPgxQN0Rdfb67ZPYypYDZeU9jbvDx/8c2s11b+EgPRNGJCju/PAFBjDq59IkNv8sRPoCbwbyEe00TNdcqf4c0f2GZyS2F37EMLPOcQFYBIWUGCz690lgFwoGxmcQlNGIoC+o/XkvqDFb7miVeIFsD9hxfbCTP9I6wudpPzkbSdRG45kwFrAgpU9CsceVM1Kt6r7U/I350Niwt9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qK5aPNH4AfIz19/jX/VXrbBtzHPGbSlhxU0hx9gNRsk=;
 b=cWImcSs6F85MFRD+fGw49QmD0S5+JIGpF9vJvNvviOzM1roQaaO9nyU7pj9QdQhkYNXzoEo7fYOhdX9JUxv2N7UNKmYDViScJ41zWykZS/pqK8PFriZ38UIqRKE/qnxUtzgg5U2IjvOPYdKm8VVYWhLLNdU+0UKX2DG49N18A4ukG6pt/1MpiJz+GiLfEhReAmTbEcGthWJjNehL6fHJNQEu0C21Z+U/bpFb0gVH3uiLguzlTlNDITR2TpnU7MJxbodSUDJhYQZmsoDZzQKcY8+ZnRSfhgqVz3C/cCRbVfjpo4WEljnzb7GKhUgN82/MkLzAqzY9ehFAK4kAKVvDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK5aPNH4AfIz19/jX/VXrbBtzHPGbSlhxU0hx9gNRsk=;
 b=XqH+H2iFmRhwbm3JoCqQIjjfl3H9Wlil+39G6kiWvOLT9azCrdykDi5kZdxS7HNpLnmOrsCMvDgCBypHQDySxdsW/+AAy2TTai1udjrFDcbrE4dYuq0zAHHrnegIkq2iZDdGabbuls6kqga7g7d8ek6Dax+uCH57jHoRTGL0C+s=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by IA1PR21MB3643.namprd21.prod.outlook.com (2603:10b6:208:3e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.24; Tue, 25 Mar
 2025 18:11:24 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684%5]) with mapi id 15.20.8583.023; Tue, 25 Mar 2025
 18:11:24 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Long Li <longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "jesse.brandeburg@intel.com"
	<jesse.brandeburg@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net,v2] net: mana: Switch to page pool for jumbo frames
Thread-Topic: [PATCH net,v2] net: mana: Switch to page pool for jumbo frames
Thread-Index: AQHbnaOMcBB1WRGa4Eqq4qlBIQtyprOEFTcAgAAOuFA=
Date: Tue, 25 Mar 2025 18:11:24 +0000
Message-ID:
 <MN0PR21MB343793AB80403CBE9BE5EDFDCAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1742920357-27263-1-git-send-email-haiyangz@microsoft.com>
 <SA6PR21MB42317CBFF4D1437A3B39F98ECEA72@SA6PR21MB4231.namprd21.prod.outlook.com>
In-Reply-To:
 <SA6PR21MB42317CBFF4D1437A3B39F98ECEA72@SA6PR21MB4231.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e2d4f7ce-4753-4bcb-994f-e7b7d6feca24;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-25T17:05:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|IA1PR21MB3643:EE_
x-ms-office365-filtering-correlation-id: ada2b7ba-d76e-4ab7-2865-08dd6bc87430
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QI3okbqrjVwupih5IMOTs1rXi15rRl/e3G2GgZQKy21ybgLxa6VWC96Igx3U?=
 =?us-ascii?Q?oGZdgYmi9YF8rPTb7lzDvbQ5XBKGt4UNI91m10ipYi8jZtLMriDCnGwf1kU+?=
 =?us-ascii?Q?OIL0hkTIGIBr93ulBVwIpKGu3plaJ3j6SuQWI17omGY39jBSJ99etV72nt+5?=
 =?us-ascii?Q?HacEym+fUAxHXT0Wl36wuMv9da/yA8dGW34G5l85/PH80HS4ipnND66xBjvb?=
 =?us-ascii?Q?D6+mgEVjIFOG5/d8nw/yK46VJEduBFeE5AYsEpBRKToc5lF96DXbv1bqLe9y?=
 =?us-ascii?Q?8oaVulphl/SMsZM/6qVqr6M9CVn0lAAZxfKTWSbjN+zn4o6Oscmb5cy3rfD9?=
 =?us-ascii?Q?wcUheb4GriE8p9A7Kom4RStCZ1mA/R93CfK8gqOxHIXSMQHSyPc2xxCOdZBB?=
 =?us-ascii?Q?M+pC4bHS753Cg9ZAOWfIumQCD0lX2vJp66Q0RYn3CydZUGUTvKeYpAdO81rV?=
 =?us-ascii?Q?1N6nYWIdjlaYO0oxpTe66S9uqXNXXMEuaGg+cWMpXxv2EiY+XqPFKZ/MBJuA?=
 =?us-ascii?Q?xzeZ8UnVw9lD7VMHKNvrTkhOUyGEpyl1W3+NNPg/D6phLfIJQr06lnr0gxCG?=
 =?us-ascii?Q?MzNehj2AoZNWuno+vswVO/wF9obCB7+j6ok3LGgZfafSQ0imAixwjnRsLzZr?=
 =?us-ascii?Q?PZslY1kFIoPh2U+P6kmKgmOisQXrdc6V8qxBiQ8D3ftGSYAb9Q6eGFy8/TW+?=
 =?us-ascii?Q?kp7XydjRh2VPF6sNkQnvCz1OCqR80G7vZFtkFQYyq8mMoT0IdlrDbdB/vaV1?=
 =?us-ascii?Q?MZjQCznnIYeeNztNX3s81aY0OEDpwYeh4KvBkRPA+YokAOTTjyUvfevXrOvd?=
 =?us-ascii?Q?c3k621mJnT1uT06K6//rCrILscp4nJC1Zg6G1HIXRlQIhYhBkqlpiK+74EQ+?=
 =?us-ascii?Q?ayb29VJFCVr8Rp3opG+yLSObvio4s6k0MzXjTv2tx6n7GzEAeAL/x5Dw8jcU?=
 =?us-ascii?Q?h6/5rwY7vBizhgHMvhxaC3HG6/+btucS8w7ItI+tgVu9Q8BvP6KtAE6h2ERe?=
 =?us-ascii?Q?C/6x/t9JvGMsb3EJVSU9nRJjTm0VZZvsNGu/sGl7MOqjtz30GgjXf4A0xopj?=
 =?us-ascii?Q?02ErZwE0StN1icRlTgMs84960Q2Moqx3saX5z76L35eoKJTd/9IYOwVWT1OU?=
 =?us-ascii?Q?g+6yrplnfDpb21lESDpshB4ictRueVLkK1htLMw2vK3vOvUSUqxtb2RjMBxU?=
 =?us-ascii?Q?yFJBj08Rirc0JuWvF/spiHh5ld8pisKnY1Jslj8kmIYKIWQTnjp5q6Q7oSoS?=
 =?us-ascii?Q?K9ZYemos2zVrfg5jDo1+WzxcEutdzXz8osKKf7NXNvYScUXH11g+wSEG7OQz?=
 =?us-ascii?Q?gZ7WH7dAzyhtQxd3PxbsiBbP1Ou4y3GeWEjZPZHmSR83p1VP9ryv1SnvjcsE?=
 =?us-ascii?Q?zja126cAuQISniSXcQq6BnQHPijPn9gZc6skTiKCXh2wJQFF3Ru589s6fwlx?=
 =?us-ascii?Q?V1CbBEq42jv8jvL2DS3Njb5O07L79THvaMiVGPWMi3pmOjm5/fQQl+75pRfV?=
 =?us-ascii?Q?tKsnRi0BbbwNbMs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mrzR02F+o3b0Zfnx2BzyOqjewPXRrYrvM9MlBemxuOxnpTnSfcaGorK7lLCQ?=
 =?us-ascii?Q?+TSnPPrjXO4MW/mLMVkzl6Qbvj7gbrQCO3PPA5fa3GRXuBuQW5pyopIIWH52?=
 =?us-ascii?Q?enaB2Y5uhu0QHAwtfJSusEDG0Spk0PGIwtaqLfDfCOR1VJSC16SOAP80oS43?=
 =?us-ascii?Q?fI9DwUcvuWNa9RIfHFQVTxtp4t3t/SylAy3jJIAvu9jo/JrlsW58J0/SwHf1?=
 =?us-ascii?Q?VBG9Ziwk3BD45J6Z3D2k7g19xW9MyEJ7IcGCIk7uc/WeQHAlS23fDTieKg31?=
 =?us-ascii?Q?l3beUWsWjH4brWVWQd1zEVeeAvkV5bkODKD8JFbY7FV2rzlDzb9yci29ARiV?=
 =?us-ascii?Q?3gN55CYmQ0dwhJ8RqkHly/SfUJCyamwtBKYzpFeta2g9BWlQ4SKx+ALzHacV?=
 =?us-ascii?Q?ezFFdz91hgEbGwkOmeK/nX9Ji/e5QvZa1It+Mdo3R+OfSzOtLFE4vuRySqDv?=
 =?us-ascii?Q?acK/M29/x2V046mOQ+wGWjDmur8v0gb5FGtBvDhXfHTuEP9Qj0YT8CKAk4Gy?=
 =?us-ascii?Q?S0Rs7bBNXCohL0t9ls3GSu+gD44qmDbW+R/XyKPiq2t5m4ty6XYGEFw1vT8G?=
 =?us-ascii?Q?2PLstXdufwPmPFYwiFiwoyYf5N01Iq7pHMhJmvylc3W/202JDysZnjJC/r1L?=
 =?us-ascii?Q?M0fIMPmRCwLF2z5J1kFdHARgdCcQB6T4XCYcUSggn1h0UkXf0LStWfiNdqij?=
 =?us-ascii?Q?dh8fLWKApx+SCBiAE/e/en1YoIxGdRiZ3WBhIe1h2+bxzwPfWgsQShQbB4b6?=
 =?us-ascii?Q?H3G4CePyEIP6At15Cai+6jSKl2W7a+qQhSqUxpGAC7+4mZQ9WyggbvRAn7mU?=
 =?us-ascii?Q?SU67dDlJofLk8wgolQqBl7JixUcYPtlLVxJFJSGMVpToT836Af8xOi0PzC7F?=
 =?us-ascii?Q?iNgwwM81OLQCF298YMCbv8+XHVFaJ1h0vXQtPy5wYK4cPvXvw2ziExAWjGxQ?=
 =?us-ascii?Q?k7FnYaofPigN4gJK5R+D+O6vhXqEThGBuZnkUBZQZBTiSQanL5X8Yg74ah9H?=
 =?us-ascii?Q?X0XXdlNGx7BMIbvL85q1Lc8l1JtGfKRKCoQF1pAQjf6eAQF/XXmdaqVk0CJq?=
 =?us-ascii?Q?bfZVgkIXJrzPMKTCCPPtsLxh+M4b0qQOR3z9MRRU4NhHGSRJZUacr2f0Ko67?=
 =?us-ascii?Q?Xb2KXaJq/A7FADFZCumeyP5NUVJ1DzEOulT1dVDmpiqRIgqRRmIoj6XBI/ck?=
 =?us-ascii?Q?p6R8LY+xGSMs11Kk8TNw5Q5K1uBYS8ivJ45GII7jpnPyWQaAemNY8vu+d8Qq?=
 =?us-ascii?Q?vOQm3TMGwwpokQoQluS5q/kRzSDNoKEn7eWZzppP0vlRrpNAZFn6T++p3x58?=
 =?us-ascii?Q?jNbFDjk2rTssLHubG/TNEfTLYmUy0t21n9F4HpwgY2QQXqasEu5RZJAh+yd0?=
 =?us-ascii?Q?dy0Wk09lGNV9nuS/ubVKDd9pEVlD7GYKx6R1afqdlNhQOi2usLF1TG+cqUim?=
 =?us-ascii?Q?X0+9UMkR8sztgghRLfAg09s5TVyxKM6KWCdg6Au6Mf57Os7ZBHmUPI65k26j?=
 =?us-ascii?Q?tL+Px/OkTEe+FUf6kB6AQAjOQqWUIYn4IdBgy8nEfOCWw6kkrA0dPaByGOg1?=
 =?us-ascii?Q?qh40Ex4Dj1yM4rt1ufAtgnJ03VizWQ6pAmfQXYXV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada2b7ba-d76e-4ab7-2865-08dd6bc87430
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 18:11:24.2555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orFTtJPAYHq3EWgUv7sFAcgl+EqHXUGfbbskw5yERgBHh76Ks90ngxu9/ORvHV5dRiaIBfu42ciq6uFdwWlnfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3643



> -----Original Message-----
> From: Long Li <longli@microsoft.com>
> Sent: Tuesday, March 25, 2025 1:06 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org
> Cc: Dexuan Cui <decui@microsoft.com>; stephen@networkplumber.org; KY
> Srinivasan <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; leon@kernel.org; ssengar@linux.microsoft.com; linux-
> rdma@vger.kernel.org; daniel@iogearbox.net; john.fastabend@gmail.com;
> bpf@vger.kernel.org; ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; jesse.brandeburg@intel.com;
> andrew+netdev@lunn.ch; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Subject: RE: [PATCH net,v2] net: mana: Switch to page pool for jumbo
> frames
>=20
>=20
>=20
> > -----Original Message-----
> > From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang
> > Sent: Tuesday, March 25, 2025 9:33 AM
> > To: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui
> > <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
> > <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> > olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; davem@davemloft.net;
> > wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> > ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> > daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> > ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> > shradhagupta@linux.microsoft.com; jesse.brandeburg@intel.com;
> > andrew+netdev@lunn.ch; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> > Subject: [PATCH net,v2] net: mana: Switch to page pool for jumbo frames
> >
> > Frag allocators, such as netdev_alloc_frag(), were not designed to work
> for
> > fragsz > PAGE_SIZE.
> >
> > So, switch to page pool for jumbo frames instead of using page frag
> allocators.
> > This driver is using page pool for smaller MTUs already.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 80f6215b450e ("net: mana: Add support for jumbo frame")
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> > v2: updated the commit msg as suggested by Jakub Kicinski.
> >
> > ---
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 46 ++++---------------
> >  1 file changed, 9 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 9a8171f099b6..4d41f4cca3d8 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -661,30 +661,16 @@ int mana_pre_alloc_rxbufs(struct mana_port_contex=
t
> > *mpc, int new_mtu, int num_qu
> >  	mpc->rxbpre_total =3D 0;
> >
> >  	for (i =3D 0; i < num_rxb; i++) {
> > -		if (mpc->rxbpre_alloc_size > PAGE_SIZE) {
> > -			va =3D netdev_alloc_frag(mpc->rxbpre_alloc_size);
> > -			if (!va)
> > -				goto error;
> > -
> > -			page =3D virt_to_head_page(va);
> > -			/* Check if the frag falls back to single page */
> > -			if (compound_order(page) <
> > -			    get_order(mpc->rxbpre_alloc_size)) {
> > -				put_page(page);
> > -				goto error;
> > -			}
> > -		} else {
> > -			page =3D dev_alloc_page();
> > -			if (!page)
> > -				goto error;
> > +		page =3D dev_alloc_pages(get_order(mpc->rxbpre_alloc_size));
> > +		if (!page)
> > +			goto error;
> >
> > -			va =3D page_to_virt(page);
> > -		}
> > +		va =3D page_to_virt(page);
> >
> >  		da =3D dma_map_single(dev, va + mpc->rxbpre_headroom,
> >  				    mpc->rxbpre_datasize, DMA_FROM_DEVICE);
> >  		if (dma_mapping_error(dev, da)) {
> > -			put_page(virt_to_head_page(va));
> > +			put_page(page);
>=20
> Should we use __free_pages()?

Quote from doc: https://www.kernel.org/doc/html/next/core-api/mm-api.html
___free_pages():
"This function can free multi-page allocations that are not compound pages.=
"
"If you want to use the page's reference count to decide when to free the=20
allocation, you should allocate a compound page, and use put_page() instead=
=20
of __free_pages()."

And, since dev_alloc_pages returns compound page for high order page, we=20
use put_page() which works for both compound & single page.

Thanks,
- Haiyang


