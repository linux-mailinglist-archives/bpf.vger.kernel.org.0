Return-Path: <bpf+bounces-28072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C66D08B5706
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 13:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E48A9B21481
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 11:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CCC481BE;
	Mon, 29 Apr 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DQm5U1v+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NM0zqLdA"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177C4652D;
	Mon, 29 Apr 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391180; cv=fail; b=KOJIFzb8rQW32nCKt71O40zTbURpjdjjVmTrvlSmMUimt2kxku346HlS6Hpe4f/tI1p4RxqhNAnYDF4k02faU9Dgsy77qaNgpk7YDZZYcGYBp7VdXP0Ebsf/waY5L3ZN0wz1o5N6880aMwwlkKn3bkqQC2U54WRUUnhiKtbIoaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391180; c=relaxed/simple;
	bh=84IbrIsiclwOXFzvDj/GFMNiCkKaVbWtgC54o6Y9zYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G8P9kBEcHN0boFUXPjoIveZNeic8gZ0vkZSEjMj+2ASUfezI+jqaTNxPLk4si5T2LuHXGY4LpeWVDb3TouIixKHZPiFm3iENR3jvSZUptgmb8bJJh0Sg5iWGKWZyov/YzbXrqcrVZw5hjPjuPQVCq4RU+zf7iymb0zBH/p9Cm1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DQm5U1v+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=NM0zqLdA; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0ef36682061e11ef8065b7b53f7091ad-20240429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=84IbrIsiclwOXFzvDj/GFMNiCkKaVbWtgC54o6Y9zYU=;
	b=DQm5U1v+KiMotoTXwaNY9uypj9cQzODMDtxQd2Masvq9rCvlnagQr3PH2fOKB4OztkYDRUuNvjTk948o5MD1dKyMAhIQOYU7DBCKtUpob0P5q/8atAApPUyjYQWSHfFHsqNrYh/f/iXe6dvluLatkthmaeTa85CoWVdRTn/3boY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:98e63a5b-d44a-45fb-bc9b-592186a5f73e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:97482592-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0ef36682061e11ef8065b7b53f7091ad-20240429
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 824448916; Mon, 29 Apr 2024 19:46:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 Apr 2024 19:46:02 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 29 Apr 2024 19:46:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcXqY9276vQvkzfNLyBmoYN8EFgykvqhRLSaVQIC1mLy4DK7fEt71Gezp+X2JrA5usbwWD4ujkOc2nTk6rM5keyFVY1gQkeLGRgkj7bZSHo9tjQ+8Ng7MaL0OiREam0fUDcRbym+KlpWmOE38ybI+7q2ihc16YtN9PdYAMYjIVsY7QD3G1eDILGCtrvlavmQFoAe1nvc1vyItwNi9vuNFkxuJNica7ZbwRs5ZdaXnujnY0+bjlrYb1HeydrBvZ0lc7abpG8z8HUuYmvHBVHxqIP8vDhtYyqTXGLEQvAXyW6DzkqlebtwzxH2J29gfWAuS+MRpDTePyd9tjNqiVurnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84IbrIsiclwOXFzvDj/GFMNiCkKaVbWtgC54o6Y9zYU=;
 b=aWQ2R7DdK3zFsOXSMkHZ1OihEjY0j0bSZPZGX/Y9kCUBh86mnSO7HdWUw5D1mwUvXhzMKMv08/nWr+5Tzr8WqP1QfnHej70+iSmT6Y9hX6VtGb+M5NcEeyIRXN559XKtoh/F/FHsu1PNCdE3031F7VS4MwlhgMdMqIRCfApNCZ2Psd89jeeGyXJAjtfZAFAhRioWganJELrXgCuakwfzmSMqGq4odCZooiAkpZ3OfN+yfsF+VFo08aQFE/SFgLO7pe+WrJ40TGTmwZCg/JfD55IOlyKbNj3UQvzIYWDee5MU9Phg/CG8Z3g1eRZpNFvXcIrEjtaJIYmLu0AOQlpJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84IbrIsiclwOXFzvDj/GFMNiCkKaVbWtgC54o6Y9zYU=;
 b=NM0zqLdAAjh3ARgCLTFBDGsJlbn+NGHXUMYdMxuzKgDGeQpOxkSk5bsiscCpOL+5FMyS2kJ9l+lvzQmsc8/oICkDSW2hyVYC/mrPTrq24AlL66nV5eZ1u6tsz46342oJXlqAd3ValgjOIKgIBQuu3FcP/qKv7XkzZrAtYygzgyA=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by OS8PR03MB8984.apcprd03.prod.outlook.com (2603:1096:604:2b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21; Mon, 29 Apr
 2024 11:45:59 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7%6]) with mapi id 15.20.7544.019; Mon, 29 Apr 2024
 11:45:58 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "daniel@iogearbox.net" <daniel@iogearbox.net>, "maze@google.com"
	<maze@google.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "kuba@kernel.org" <kuba@kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "yan@cloudflare.com"
	<yan@cloudflare.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Thread-Topic: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Thread-Index: AQHaj0XOIxnbbRpuOEqwUbC2K0Us3rFpz0sAgABZ6oCAAArbAIAA8PYAgAAJ3wCAAAGxgIAAWJUAgACHpICAANEgAIAAdp6AgAAXCgCAAdtPAIAAXxYAgAA10YCAAANdgIAGGNsAgAA/VACAASp9AIAAIwMAgADr+gCAAKCBAIABSysAgAC8pYCAARHSgIABM2mAgAG7XACAABloAA==
Date: Mon, 29 Apr 2024 11:45:58 +0000
Message-ID: <bd9d5fef2fa6154e162e963f5d669ff618b95229.camel@mediatek.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
	 <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
	 <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com>
	 <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
	 <CANP3RGfxeKDUmGwSsZrAs88Fmzk50XxN+-MtaJZTp641aOhotA@mail.gmail.com>
	 <6622acdd22168_122c5b2945@willemb.c.googlers.com.notmuch>
	 <9f097bcafc5bacead23c769df4c3f63a80dcbad5.camel@mediatek.com>
	 <6627ff5432c3a_1759e929467@willemb.c.googlers.com.notmuch>
	 <274c7e9837e5bbe468d19aba7718cc1cf0f9a6eb.camel@mediatek.com>
	 <66291716bcaed_1a760729446@willemb.c.googlers.com.notmuch>
	 <c28a5c635f38a47f1be266c4328e5fbba44ff084.camel@mediatek.com>
	 <662a63aeee385_1de39b294fd@willemb.c.googlers.com.notmuch>
	 <752468b66d2f5766ea16381a0c5d7b82ab77c5c4.camel@mediatek.com>
	 <ae0ba22a-049a-49c1-d791-d0e953625904@iogearbox.net>
	 <662cfd6db06df_28b9852949a@willemb.c.googlers.com.notmuch>
	 <afa6e302244a87c2a834fcc31d48b377e19a34a2.camel@mediatek.com>
	 <5cc1c662-1cec-101c-8184-c32c210eeadc@iogearbox.net>
In-Reply-To: <5cc1c662-1cec-101c-8184-c32c210eeadc@iogearbox.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|OS8PR03MB8984:EE_
x-ms-office365-filtering-correlation-id: ca31521f-6dda-484e-33b1-08dc6841f009
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?M2FWVG1lUVFGalZaZFJaRnlSYWhRQUZ4YXU4cVB3TExRblVHankwakhMRjJQ?=
 =?utf-8?B?NDdnc2dmTW9JZkJPb3QraFY1VjFZd3ptK3pHVG82TTNNNHpWbG1NZWhEbjZa?=
 =?utf-8?B?VEk5VEp4bWF5akRieFFYa3MxOG41SHpaSFJuRDdlUVo1Y01EaC8xVFhBOWJO?=
 =?utf-8?B?YitKOGdvcFVFTXVYZXFxRDFzK1JTbzRRWnBBZVVNWEkzZW5zeGdiODFsdzRi?=
 =?utf-8?B?bFFUNnl3MGFpY2wyVlpsWGR6Z0NXaEZvUVhZY3B4SkROWUh1L1p2SHhqMFhM?=
 =?utf-8?B?MzlTRE5BOWQrK3lSN1J5K3M0MHFVTEh1VkFTTlVOTjZMVjRPNWV2ZVZzY1dE?=
 =?utf-8?B?UzFuMWRnUE9jYWMreGJFVGxUeEZlWm9sMVEwRGhGdk4vRElJczA4R3I4Qkc2?=
 =?utf-8?B?VmNXR2xnKzRtbWxvbC8xQUthRm5EcGxYSSswdnNaTHFlQ3FYY2RaaW9uZEQw?=
 =?utf-8?B?Sjlybng0cUhrQWJpWVZqSFh5UXVRZlR5QmVBb3g5VnpZOXFiMXZMcFFQN2pm?=
 =?utf-8?B?YzNlREQyT2g2K3dxQmo1dlVzOEZkbksyeW15ZlZIMjd2VVFXQldtSTVXWko2?=
 =?utf-8?B?UHZIeG1oK0pUdG4ranA3MGZuUHBvSXgrWUU3SEgxdFNDYytkTWV1YnluWHRB?=
 =?utf-8?B?SjNYVEFuZS9qTGRtR2xDTHlNYlhFamphNzg1VmN3V1Uva2ZWRy9PQ3VIUjM0?=
 =?utf-8?B?Mk1LTVdVa1p5NVFJNUF2TWI1am1DelBpVDV2THBEeVg3bDYvYjBRQjgydkM3?=
 =?utf-8?B?aDhzK2dWQlE5cHpRcGx2UXA4SVRyc01aSUx2dXpkRGU4TjF1Kzd0bTZZdk9y?=
 =?utf-8?B?WnVKN29WWENRS3dxYW4rMTgzMER0RUd6TThJRzcxOXVidUVzWnp4Mms0ZWpl?=
 =?utf-8?B?dGxieFNwQlZoMEFQd0JVcnpzYkhNZDFXNFBlTHkrcW9QcDZJcVFGbWhWTWFr?=
 =?utf-8?B?NVhCWHM1VkZxM0RtdEdxWk0xaDdvRXcyV1pLYWlPd1o3aHNZZGRBQnlPaEpU?=
 =?utf-8?B?eWsxWHJJbjFaOWhwaEkycWYzcFZFS0ZEdy82NTVCWW8zMHdxWlVkZitwQTRo?=
 =?utf-8?B?R2d0MEtWUU93R3NiVGJScW5wdHgzOC9DUks5Rjg4SWJsLysvZWsxUUt4NHdl?=
 =?utf-8?B?TFpuVWZ6QzhQZVkwbHZtOGpxU2pYRFYwUEFML3BhZGNrS2g3N2F2em9SbVBS?=
 =?utf-8?B?S1A4MTBmU015RGpuOWhsbjFyaUJhclVaSHA1bXl1SDc2L0Q5R3ZqOURBZ0Zt?=
 =?utf-8?B?QzVML3pwRzdYbGpWV1ZRYVNaaTFyckhhVUpxREdRSjlJRUF6N0NLZS9nKzlK?=
 =?utf-8?B?c21KMTc2dmFpR2Nmc2d0R1ZUbTNPM3YvKzZWcjhlZXBYZnpFRFpteks2ZDBK?=
 =?utf-8?B?NnJadUxyb1RwaHBHajVSbkUxSlZ2MmpTOG1KWHNQNnVlVEMrcXhHemEzRGpx?=
 =?utf-8?B?YUx1ZFNUeGw4QmVtQXVKS1hUVUZXYjRrOGQyV3BXTkNvaytYZk5vbkpFK0pn?=
 =?utf-8?B?MXFnOTJ0ZVBjMnBOVXdOOHFqdStXc0NyNWJiQ2NMeHJha0c2QTk3TXpsZnJN?=
 =?utf-8?B?eHVBZU93bDc3T0FMcWY1bWpjNGo4NzNkMkFpOUhVTTVrMVVJZGFCZ0haVTZH?=
 =?utf-8?B?K0EyeFJqSkE1UnYveExIa1NZd2F1MUlCNTdlODNuV3hoSk93eWNxNlhhVlA0?=
 =?utf-8?B?UHZ6M1JoOW9SdFRyaDFmVWc1QTRrRlNJbUczRE1pK3NhR3N1Zk5hVjJNUzdI?=
 =?utf-8?B?VERQaVVkbXlBWVBtSFJkbnRKZDlMSk5uNVoveFIyQWR3czl0TElFZitkazl0?=
 =?utf-8?B?Q2JmWGVkZDgya2lLUGpkZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGxQOUsvbTN6Q2U0c1U4bVp5cExtZVNwSW1HNmcyR0FzRzBCRXFCbFl4ZEdS?=
 =?utf-8?B?YklTdGdxMENzNlYxTFRXejB1bHhaSGh1YWd5ZjhHbmJCZWJNVDFwSTV6OURV?=
 =?utf-8?B?ejEzMWJIUmFxUnBDL0JsK0MrK3dLSWpxTXNnRnZ4VmFaS3I4b1dPd3BpZjRz?=
 =?utf-8?B?YUZCbCtRd1pxOWFTRmhncVZTeFRoQ00xWXZrVzRRTnY2akJhNmJqb3ZONnJR?=
 =?utf-8?B?VGZpdENUUURIR3dBdVZkVWtIazUyNENpdyszUm9jbTBJNVBiYWw4MkkvWUlJ?=
 =?utf-8?B?MDg2RWE1cEFkUEgyVG5qbG04dkNyNGd5L2V5SnQxbzZLTDc2WjdPYTV4Q1Z2?=
 =?utf-8?B?ckNGY0JxcUU1bWZ3T0tLOFhaeDNXalN3QjBFMGNuQWlEVktPTXg1ODd1bjcw?=
 =?utf-8?B?SUhUZEkxN243ZTdzS2lTU0tjNHBjcHdpOE5xUWVHeFEyQXlSVnFhVGloWnl2?=
 =?utf-8?B?aWgzUVh1Z2xWeUM3MjlHNUd6WFNBWmQvN2h0K2M3S0UxYm45WXdUM2Zwemxx?=
 =?utf-8?B?MEQ2SS82YzR5aGpTaFhkT0oxd3pOVThxaTc5OHpCbXZSZWhES051bERoY0pv?=
 =?utf-8?B?KzVxS1VGUjFIMDROOTE5NHJsUmt5am9iV3ZyajFFRllFc29YWGdBZDNORkxQ?=
 =?utf-8?B?eUVDejFGMDFyenZCYVFJelVmU25IU2NZY3J0N1IvNUJDUlduWkwzVlllQnZD?=
 =?utf-8?B?RzQ1bVY0ZDR1d3BVaDBmVkVBY2pzUjJ3b045UG1vT29CZ0hxZk9BK0dCeFI2?=
 =?utf-8?B?VlhXOFc1a2NJU3U3Uk92VVliOUViRzRiWkgzNkpIUWtqejhCc1hmU0dZREQv?=
 =?utf-8?B?MjFYWWUyd2NhQkdDWXFpOWM5ZFRGTnRETHZYNHJxcG4xU1ZVL0FoQ2tPeDgr?=
 =?utf-8?B?cE1jSTYxNE9FN3RjRm5BdWg5S1k0cEJwNkRJOG5KWnBPMEROS3dCSHk1QlRX?=
 =?utf-8?B?V1ZrOVJZT1cwZW4rajFQRW9FZi9KNkh4UWdPQkZ1NTBEUUVFK3pTeHJRS2pK?=
 =?utf-8?B?RGE2bkE5NVBEZUNTd213dGF0K21sQlowdTViM0N6U215OGJYN05rS1FZU3JP?=
 =?utf-8?B?V2hmSVV6ZzJpUEc1UmZzN1JmZGhLVFdLanhwZ2YxcWdnVjRDQ1BUcVRYSzFt?=
 =?utf-8?B?NkhyU2Q2TG1uL3FrakdYT3dpMkY2Y3FxbHlyWmkrUlRwUDN4YmdLTlNadlVI?=
 =?utf-8?B?VjdZYUdiZS9tdk9qTmNpNE1XM1NOZlhlOGF1Y3R6ZndQZk9Mcm1jbXVZYVZC?=
 =?utf-8?B?WDMrUWNMVWRzRlp0V2Z6MjdLME55TkIrdU8ydTZ6ZFplSC85NURjNlZRZTZR?=
 =?utf-8?B?U1dTMTRaNlFsWmN2alBBTGdRTzF0cGxCRXNuM0MySDlyTjJJbDl6MmZMM1lX?=
 =?utf-8?B?YkowREplVDE0cTVQdEhsZzY1ZTZjaDRZb2NCSmJjQXJiSmRyanI0SHcxSUNM?=
 =?utf-8?B?K3h4Mk9oWFd4T2N3dEpTNyswOHdMTHFKK3MvMDlzdThJWFVHT2ttV1haOHBv?=
 =?utf-8?B?TEVsMFlqb0tPY2NwSDZqL0dram8rQjhITTc0WkpkQ2FXdVJzNmdCRzZvNTYr?=
 =?utf-8?B?WVExWERCaDU1SnZ0cFBhd1IvbWowZTNVZklNY005c09Ubkp3QzV0UFg1bnBk?=
 =?utf-8?B?VU5vWlpiN2dBUVZqWGJxdm1OK0R6WXhKbGMycm9mOS9IVmNVQU5IM1B0cTIy?=
 =?utf-8?B?Ykd2NG5aWStsRHljeVRHU3g3bnFiS0JiYTU0cHpoaFp1RER4TXFVWklaL1Qv?=
 =?utf-8?B?NWdGNThHVzVJaHdCUWJjQ1R2emR5WC9NTFpoN0RhMnFKQkE3VlVHVDJNdXFk?=
 =?utf-8?B?SHVqb2owMzlVMTlqTHlNeXpkYkRWTTU5WW12WjArNS96aVhUdE94Ym5EMDB0?=
 =?utf-8?B?YmVxbW1EUTlxWjYwU1pxTUFORnpqc2NFbXFkTThsclFWMzBSaEdhalRLSFJy?=
 =?utf-8?B?Q3kzR0lTZWF3UzMvZURFa2dpV1N4aDNralhSV3owRC9OUk1vSGpxS1dGZVIv?=
 =?utf-8?B?bk5GUmgyVEJocHg5V2dvMlBWWWJpeUNScWtyeExNZlFmZVhsZ0xVVlE0WlJk?=
 =?utf-8?B?S25OTXV4UUpjcjIrbndWeHRMN2hKN3pKTkxtTUdzbjV6NHlmTDdiUGt6U1BB?=
 =?utf-8?B?V00vMWsvVS9WcVlUU0kwUGk2NnRoQXpEeENZZEdUQkUyNE1tendnN0loR1Rp?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAC31BFB62D2B6458C49F4F4FAAA6F5A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca31521f-6dda-484e-33b1-08dc6841f009
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 11:45:58.8676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Be6ZOSh2hrZSFlkfXJPw2oinGv+RepGvKgCcBPVLktWiUbom28Vc+QkzJc2mo+JC2dTJKgS/+IJAXE4LpFDVTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR03MB8984

T24gTW9uLCAyMDI0LTA0LTI5IGF0IDEyOjE1ICswMjAwLCBEYW5pZWwgQm9ya21hbm4gd3JvdGU6
DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiAgT24gNC8yOC8yNCA5OjQ4IEFNLCBMZW5hIFdhbmcgKOeOi+WonCkg
d3JvdGU6DQo+ID4gT24gU2F0LCAyMDI0LTA0LTI3IGF0IDA5OjI4IC0wNDAwLCBXaWxsZW0gZGUg
QnJ1aWpuIHdyb3RlOg0KPiA+PiAgIA0KPiA+PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0KPiA+PiB5b3UgaGF2
ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+PiAgIA0KPiA+PiBEYW5p
ZWwgQm9ya21hbm4gd3JvdGU6DQo+ID4+PiBPbiA0LzI2LzI0IDExOjUyIEFNLCBMZW5hIFdhbmcg
KOeOi+WonCkgd3JvdGU6DQo+ID4+PiBbLi4uXQ0KPiA+Pj4+Pj4gICBGcm9tIDMwMWRhNWM5ZDY1
NjUyYmFjNjA5MWQ0Y2Q2NGI3NTFiMzMzOGY4YmIgTW9uIFNlcCAxNw0KPiA+PiAwMDowMDowMA0K
PiA+Pj4+PiAyMDAxDQo+ID4+Pj4+PiBGcm9tOiBTaGltaW5nIENoZW5nIDxzaGltaW5nLmNoZW5n
QG1lZGlhdGVrLmNvbT4NCj4gPj4+Pj4+IERhdGU6IFdlZCwgMjQgQXByIDIwMjQgMTM6NDI6MzUg
KzA4MDANCj4gPj4+Pj4+IFN1YmplY3Q6IFtQQVRDSCBuZXRdIG5ldDogcHJldmVudCBCUEYgcHVs
bGluZyBTS0JfR1NPX0ZSQUdMSVNUDQo+ID4+IHNrYg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEEgU0tC
X0dTT19GUkFHTElTVCBza2IgY2FuJ3QgYmUgcHVsbGVkIGRhdGENCj4gPj4+Pj4+IGZyb20gaXRz
IGZyYWdsaXN0IGFzIGl0IG1heSByZXN1bHQgYW4gaW52YWxpZA0KPiA+Pj4+Pj4gc2VnbWVudGF0
aW9uIG9yIGtlcm5lbCBleGNlcHRpb24uDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gRm9yIHN1Y2ggc3Ry
dWN0dXJlZCBza2Igd2UgbGltaXQgdGhlIEJQRiBwdWxsaW5nDQo+ID4+Pj4+PiBkYXRhIGxlbmd0
aCBzbWFsbGVyIHRoYW4gc2tiX2hlYWRsZW4oKSBhbmQgcmV0dXJuDQo+ID4+Pj4+PiBlcnJvciBp
ZiBleGNlZWRpbmcuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gRml4ZXM6IDNhMTI5NmEzOGQwYyAoIm5l
dDogU3VwcG9ydCBHUk8vR1NPIGZyYWdsaXN0DQo+IGNoYWluaW5nLiIpDQo+ID4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBTaGltaW5nIENoZW5nIDxzaGltaW5nLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4g
Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IExlbmEgV2FuZyA8bGVuYS53YW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4gICAgbmV0L2NvcmUvZmlsdGVyLmMgfCA1ICsrKysrDQo+
ID4+Pj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4+Pj4+Pg0KPiA+
Pj4+Pj4gZGlmZiAtLWdpdCBhL25ldC9jb3JlL2ZpbHRlci5jIGIvbmV0L2NvcmUvZmlsdGVyLmMN
Cj4gPj4+Pj4+IGluZGV4IDhhZGY5NTc2NWNkZC4uOGVkNGQ1ZDg3MTY3IDEwMDY0NA0KPiA+Pj4+
Pj4gLS0tIGEvbmV0L2NvcmUvZmlsdGVyLmMNCj4gPj4+Pj4+ICsrKyBiL25ldC9jb3JlL2ZpbHRl
ci5jDQo+ID4+Pj4+PiBAQCAtMTY2Miw2ICsxNjYyLDExIEBAIHN0YXRpYyBERUZJTkVfUEVSX0NQ
VShzdHJ1Y3QNCj4gPj4gYnBmX3NjcmF0Y2hwYWQsDQo+ID4+Pj4+PiBicGZfc3ApOw0KPiA+Pj4+
Pj4gICAgc3RhdGljIGlubGluZSBpbnQgX19icGZfdHJ5X21ha2Vfd3JpdGFibGUoc3RydWN0IHNr
X2J1ZmYNCj4gPj4gKnNrYiwNCj4gPj4+Pj4+ICAgICAgdW5zaWduZWQgaW50IHdyaXRlX2xlbikN
Cj4gPj4+Pj4+ICAgIHsNCj4gPj4+Pj4+ICtpZiAoc2tiX2lzX2dzbyhza2IpICYmDQo+ID4+Pj4+
PiArICAgIChza2Jfc2hpbmZvKHNrYiktPmdzb190eXBlICYgU0tCX0dTT19GUkFHTElTVCkgJiYN
Cj4gPj4+Pj4+ICsgICAgIHdyaXRlX2xlbiA+IHNrYl9oZWFkbGVuKHNrYikpIHsNCj4gPj4+Pj4+
ICtyZXR1cm4gLUVOT01FTTsNCj4gPj4+Pj4+ICt9DQo+ID4+Pj4+PiAgICByZXR1cm4gc2tiX2Vu
c3VyZV93cml0YWJsZShza2IsIHdyaXRlX2xlbik7DQo+ID4+Pg0KPiA+Pj4gRHVtYiBxdWVzdGlv
biwgYnV0IHNob3VsZCB0aGlzIGd1YXJkIGJlIG1vcmUgZ2VuZXJpY2FsbHkgcGFydCBvZg0KPiA+
PiBza2JfZW5zdXJlX3dyaXRhYmxlKCkNCj4gPj4+IGludGVybmFscywgcHJlc3VtYWJseSB0aGF0
IHdvdWxkIGJlIGluc2lkZQ0KPiBwc2tiX21heV9wdWxsX3JlYXNvbigpLA0KPiA+PiBvciBvbmx5
IGlmIHdlIGV2ZXINCj4gPj4+IHNlZSBtb3JlIGNvZGUgaW5zdGFuY2VzIHNpbWlsYXIgdG8gdGhp
cz8NCj4gPj4NCj4gPj4gR29vZCBwb2ludC4gTW9zdCBjYWxsZXJzIG9mIHNrYl9lbnN1cmVfd3Jp
dGFibGUgY29ycmVjdGx5IHB1bGwNCj4gb25seQ0KPiA+PiBoZWFkZXJzLCBzbyB3b3VsZG4ndCBj
YXVzZSB0aGlzIHByb2JsZW0uIEJ1dCBpdCBhbHNvIGFkZHMgY292ZXJhZ2UNCj4gdG8NCj4gPj4g
dGhpbmdzIGxpa2UgdGMgcGVkaXQuDQo+ID4gDQo+ID4gVXBkYXRlZDoNCj4gPiANCj4gPiAgRnJv
bSAzYmUzMGI4Y2Y2ZTYyOWYyNjE1ZWY0ZWFmZTNiMmExYzBkNjhjNTMwIE1vbiBTZXAgMTcgMDA6
MDA6MDANCj4gMjAwMQ0KPiA+IEZyb206IFNoaW1pbmcgQ2hlbmcgPHNoaW1pbmcuY2hlbmdAbWVk
aWF0ZWsuY29tPg0KPiA+IERhdGU6IFN1biwgMjggQXByIDIwMjQgMTU6MDM6MTIgKzA4MDANCj4g
PiBTdWJqZWN0OiBbUEFUQ0ggbmV0XSBuZXQ6IHByZXZlbnQgcHVsbGluZyBTS0JfR1NPX0ZSQUdM
SVNUIHNrYg0KPiA+IA0KPiA+IEJQRiBvciBUQyBjYWxsZXJzIG1heSBwdWxsIGluIGEgbGVuZ3Ro
IGxvbmdlciB0aGFuIHNrYl9oZWFkbGVuKCkNCj4gPiBmb3IgYSBTS0JfR1NPX0ZSQUdMSVNUIHNr
Yi4gVGhlIGRhdGEgaW4gZnJhZ2xpc3Qgd2lsbCBiZSBwdWxsZWQNCj4gPiBpbnRvIHRoZSBsaW5l
YXIgc3BhY2UuIEhvd2V2ZXIgaXQgZGVzdHJveXMgdGhlIHNrYidzIHN0cnVjdHVyZQ0KPiA+IGFu
ZCBtYXkgcmVzdWx0IGluIGFuIGludmFsaWQgc2VnbWVudGF0aW9uIG9yIGtlcm5lbCBleGNlcHRp
b24uDQo+ID4gDQo+ID4gU28gd2Ugc2hvdWxkIGFkZCBwcm90ZWN0aW9uIHRvIHN0b3AgdGhlIG9w
ZXJhdGlvbiBhbmQgcmV0dXJuDQo+ID4gZXJyb3IgdG8gcmVtaW5kIGNhbGxlcnMuDQo+ID4gDQo+
ID4gRml4ZXM6IDNhMTI5NmEzOGQwYyAoIm5ldDogU3VwcG9ydCBHUk8vR1NPIGZyYWdsaXN0IGNo
YWluaW5nLiIpDQo+ID4gU2lnbmVkLW9mZi1ieTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVu
Z0BtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGVuYSBXYW5nIDxsZW5hLndhbmdA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaW5jbHVkZS9saW51eC9za2J1ZmYuaCB8IDYg
KysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2tidWZmLmggYi9pbmNsdWRlL2xpbnV4L3NrYnVm
Zi5oDQo+ID4gaW5kZXggOWQyNGFlYzA2NGU4Li4zZWVmNjViM2RiMjQgMTAwNjQ0DQo+ID4gLS0t
IGEvaW5jbHVkZS9saW51eC9za2J1ZmYuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvc2tidWZm
LmgNCj4gPiBAQCAtMjc0MCw2ICsyNzQwLDEyIEBAIHBza2JfbWF5X3B1bGxfcmVhc29uKHN0cnVj
dCBza19idWZmICpza2IsDQo+ID4gdW5zaWduZWQgaW50IGxlbikNCj4gPiAgIGlmICh1bmxpa2Vs
eShsZW4gPiBza2ItPmxlbikpDQo+ID4gICByZXR1cm4gU0tCX0RST1BfUkVBU09OX1BLVF9UT09f
U01BTEw7DQo+ID4gICANCj4gPiAraWYgKHNrYl9pc19nc28oc2tiKSAmJg0KPiA+ICsgICAgKHNr
Yl9zaGluZm8oc2tiKS0+Z3NvX3R5cGUgJiBTS0JfR1NPX0ZSQUdMSVNUKSAmJg0KPiA+ICsgICAg
IHdyaXRlX2xlbiA+IHNrYl9oZWFkbGVuKHNrYikpIHsNCj4gPiArcmV0dXJuIFNLQl9EUk9QX1JF
QVNPTl9OT01FTTsNCj4gPiArfQ0KPiANCj4gVGhlICd3cml0ZV9sZW4gPiBza2JfaGVhZGxlbihz
a2IpJyB0ZXN0IGlzIHJlZHVuZGFudCwgbm8gPw0KPiANCj4gSXQgaXMgY292ZXJlZCBieSB0aGUg
ZWFybGllciB0ZXN0IDoNCj4gDQo+ICAgICAgICAgIGlmIChsaWtlbHkobGVuIDw9IHNrYl9oZWFk
bGVuKHNrYikpKQ0KPiAgICAgICAgICAgICAgICAgIHJldHVybiBTS0JfTk9UX0RST1BQRURfWUVU
Ow0KPiANCkRhbmllbCwgaXQgaXMgbm90IHJlZHVuZGFudC4gVGhlIGJwZiBwdWxscyBhIGxlbiBi
ZXR3ZWVuDQpza2JfaGVhZGxlbihza2IpIGFuZCBza2ItPmxlbiB0aGF0IHJlc3VsdHMgaW4gZXJy
b3IuIEhlcmUgaXQgd2lsbCBzdG9wDQp0aGlzIG9wZXJhdGlvbi4gRm9yIG90aGVyIHNrYnMobm90
IFNLQl9HU09fRlJBR0xJU1QpIGl0IGNvdWxkIGJlIGENCm5vcm1hbCBiZWhhdmlvdXIgYW5kIHdp
bGwgY29udGludWUgdG8gZG8gbmV4dCBwdWxsaW5nLg0KDQo+IEFsc28sIHdhcyB0aGlzIHBhdGNo
IGV2ZW4gY29tcGlsZSB0ZXN0ZWQgc2luY2UgdGhlcmUgaXMgbm8gd3JpdGVfbGVuDQo+IHZhciA/
DQo+IA0KVGhlIGNoZWNrIGlzIG1vdmVkIGludG8gc2tiX2Vuc3VyZV93cml0YWJsZSBhcyBhZHZp
Y2UgYW5kIGEgbmV3IG1haWwNCmxvb3AgaXMgY3JlYXRlZCB0byBzdGFydCB1cHN0cmVhbToNCg0K
RnJvbSAzNjMwN2NiODcwNjY1M2E2M2EzODlmYWFkYmIxMzI0Y2RhNWMwNDQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRg0Kcm9tOiBTaGltaW5nIENoZW5nIDxzaGltaW5nLmNoZW5nQG1lZGlh
dGVrLmNvbT4NCkRhdGU6IFN1biwgMjggQXByIDIwMjQNCjIxOjUwOjExICswODAwDQpTdWJqZWN0
OiBbUEFUQ0ggbmV0XSBuZXQ6IHByZXZlbnQgcHVsbGluZw0KU0tCX0dTT19GUkFHTElTVCBza2IN
Cg0KQlBGIG9yIFRDIGNhbGxlcnMgbWF5IHB1bGwgaW4gYSBsZW5ndGggbG9uZ2VyIHRoYW4gc2ti
X2hlYWRsZW4oKQ0KZm9yIGEgU0tCX0dTT19GUkFHTElTVCBza2IuIFRoZSBkYXRhIGluIGZyYWds
aXN0IHdpbGwgYmUgcHVsbGVkDQppbnRvIHRoZSBsaW5lYXIgc3BhY2UuIEhvd2V2ZXIgaXQgZGVz
dHJveXMgdGhlIHNrYidzIHN0cnVjdHVyZQ0KYW5kIG1heSByZXN1bHQgaW4gYW4gaW52YWxpZCBz
ZWdtZW50YXRpb24gb3Iga2VybmVsIGV4Y2VwdGlvbi4NCg0KU28gd2Ugc2hvdWxkIGFkZCBwcm90
ZWN0aW9uIHRvIHN0b3AgdGhlIG9wZXJhdGlvbiBhbmQgcmV0dXJuDQplcnJvciB0byByZW1pbmQg
Y2FsbGVycy4NCg0KRml4ZXM6IDNhMTI5NmEzOGQwYyAoIm5ldDogU3VwcG9ydCBHUk8vR1NPIGZy
YWdsaXN0IGNoYWluaW5nLiIpDQpTaWduZWQtb2ZmLWJ5OiBTaGltaW5nIENoZW5nIDxzaGltaW5n
LmNoZW5nQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IExlbmEgV2FuZyA8bGVuYS53YW5n
QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIG5ldC9jb3JlL3NrYnVmZi5jIHwgNiArKysrKysNCiAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9uZXQvY29yZS9za2J1
ZmYuYyBiL25ldC9jb3JlL3NrYnVmZi5jDQppbmRleCBmNjhmMjY3OWIwODYuLjJkMzVlMDA5ZTgx
NCAxMDA2NDQNCi0tLSBhL25ldC9jb3JlL3NrYnVmZi5jDQorKysgYi9uZXQvY29yZS9za2J1ZmYu
Yw0KQEAgLTYxMDAsNiArNjEwMCwxMiBAQCBFWFBPUlRfU1lNQk9MKHNrYl92bGFuX3VudGFnKTsN
CiANCiBpbnQgc2tiX2Vuc3VyZV93cml0YWJsZShzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCB1bnNpZ25l
ZCBpbnQgd3JpdGVfbGVuKQ0KIHsNCisJaWYgKHNrYl9pc19nc28oc2tiKSAmJg0KKwkgICAgKHNr
Yl9zaGluZm8oc2tiKS0+Z3NvX3R5cGUgJiBTS0JfR1NPX0ZSQUdMSVNUKSAmJg0KKwkgICAgIHdy
aXRlX2xlbiA+IHNrYl9oZWFkbGVuKHNrYikpIHsNCisJCXJldHVybiAtRU5PTUVNOw0KKwl9DQor
DQogCWlmICghcHNrYl9tYXlfcHVsbChza2IsIHdyaXRlX2xlbikpDQogCQlyZXR1cm4gLUVOT01F
TTsNCiANCi0tIA0KMi4xOC4wDQoNCj4gPiAgIGlmICh1bmxpa2VseSghX19wc2tiX3B1bGxfdGFp
bChza2IsIGxlbiAtIHNrYl9oZWFkbGVuKHNrYikpKSkNCj4gPiAgIHJldHVybiBTS0JfRFJPUF9S
RUFTT05fTk9NRU07DQo+ID4gICANCj4gPiANCj4gDQo=

