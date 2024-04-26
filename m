Return-Path: <bpf+bounces-27916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7C48B3485
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 11:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B631C20F08
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 09:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FDE13FD93;
	Fri, 26 Apr 2024 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="o8FsJkhq";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mX2wYIg3"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AFE13C9A7;
	Fri, 26 Apr 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125170; cv=fail; b=S/Ie1WrEHWqr06SZ9g9IZ/kjn4euTDN9NkLa7DBX4GLvLEReZ2V8nSakNPu6n553rsKjjl8J1trHGU9jaM/OwOdh+tKb+wiznOWC4B2i6qLp7QpFgm/mPvl+Nk1FC78egLMXjNw/zPHobDQtEsH8aBgTpX9pcYT3jpRyw2tASa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125170; c=relaxed/simple;
	bh=uWXt4eZAxOp6Z9hIk2+WJ5Rs/hHnnGo+zOvADQdGxBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CysHnZRJJe7B9vNhKEXut1+DPdTUT+90ToeUbew9Z6p/jybqsUimQ3AQQAy/EwtoQrnvjhh3GH2n4W7Kf7bmfUD4hZOru+gjpm/Og+svzjPQSXdBWcmL1xdiKiEhDeNTbJdw0OY0XLwxGF1QkagoFgfKQCk+9AabX2dsIByIq4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=o8FsJkhq; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mX2wYIg3; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b896cd1e03b211efb92737409a0e9459-20240426
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uWXt4eZAxOp6Z9hIk2+WJ5Rs/hHnnGo+zOvADQdGxBs=;
	b=o8FsJkhqliOblUcycyxX3bGF8hxH6Wi0sMKIfiNQ6Fug6iHZsZzyxU/pci+5tXhYTT89xP69sDiz3JQDCDdtZWi075UjTy1u2jTFntvwAS+Rzp58PZaXzRFyK9G3QxCsCr9BJp+60aCDN2RhPi0On0Z6FWLYpJ2+KrJCLY40bhE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:21b67463-da1b-47f6-818d-2b4167282f23,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:45ed62fb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b896cd1e03b211efb92737409a0e9459-20240426
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1299859023; Fri, 26 Apr 2024 17:52:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 Apr 2024 17:52:39 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 Apr 2024 17:52:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VN76OGvCDER1VqoJ53No5JXm/GyQtdsd94yZChO0SOJJ1PXhoHVbP1xFm9OkIpMnHtyaJoeTom8EUNhYz4r9wxDLyBcbsdNoAl17Adve/OzJEfvMM6Yoj5/Se9JQrEqe+3dqjKx9DfDNpgF+uR2jHT6Uo8DvSOJMulNsWaHiJySYx/y4Dzo/tNpjRgF848F0FA2Ny2P7/rKXCjGl8p1doiISt7JYzU0IKyvX7ovp89pc7bhdgjiBaoiTiNYQneWyKPcSQjQadMHpxBpuxgoo4jllj2B3eni0RmHipTQibezCufRTexCAmeRhGnVsKFQMoAgrw4sDDYuUYDQ94ZWajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWXt4eZAxOp6Z9hIk2+WJ5Rs/hHnnGo+zOvADQdGxBs=;
 b=UeJqZN7VCTxSAdnQs7ScUW4fxRP0q5HOobD1N27hBNfV5jiFg45flO9u/+32hNn2JIFFpEQcNsohm/dc+/m0lK4es+7fLFCg9wa5B66YmCsdIoDSZbE6RW/Vr8tMltoJ8tLWZ3/Rnt+oCVV/+ymURgABcyXwE3PcsBNBpdQiXOY8o0eg61DmJakiJa+un14ILiMI+fv3gvnBeLR+9n9XJcCvXTjLmLtJDtLTMhaeHIlV54YbrM3k9fqJWaQYoHMV/hYORSQAPhDQIL4Z3BG5bAotjSsTTlD0cdR4ztdp0ghCYwcN65+eGFitJf6U458ef5jmmW67L4NIddvRpFvIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWXt4eZAxOp6Z9hIk2+WJ5Rs/hHnnGo+zOvADQdGxBs=;
 b=mX2wYIg3oCQMe9Z7+L4/BCk/2+b9TYGzPSNrCPDaTMiNt3vQZT3Rq/h8ysF6BM8wzy1ltAQRgXw82xEXOQs5WhC2AreQj25AB6YyGH2OAhre6LKWImTq/y7YOZes35VmmT7dWpteWSEjMxH9z8u6dYvkckwJGZKdJv+1MSN9U/k=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by JH0PR03MB8186.apcprd03.prod.outlook.com (2603:1096:990:49::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.11; Fri, 26 Apr
 2024 09:52:37 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 09:52:37 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "maze@google.com" <maze@google.com>, "willemdebruijn.kernel@gmail.com"
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
Thread-Index: AQHaj0XOIxnbbRpuOEqwUbC2K0Us3rFpz0sAgABZ6oCAAArbAIAA8PYAgAAJ3wCAAAGxgIAAWJUAgACHpICAANEgAIAAdp6AgAAXCgCAAdtPAIAAXxYAgAA10YCAAANdgIAGGNsAgAA/VACAASp9AIAAIwMAgADr+gCAAKCBAIABSysA
Date: Fri, 26 Apr 2024 09:52:37 +0000
Message-ID: <752468b66d2f5766ea16381a0c5d7b82ab77c5c4.camel@mediatek.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
	 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
	 <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
	 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
	 <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch>
	 <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
	 <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
	 <661f066060ab4_7a39f2945d@willemb.c.googlers.com.notmuch>
	 <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
	 <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch>
	 <11395231f8be21718f89981ffe3703da3f829742.camel@mediatek.com>
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
In-Reply-To: <662a63aeee385_1de39b294fd@willemb.c.googlers.com.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|JH0PR03MB8186:EE_
x-ms-office365-filtering-correlation-id: c321aa79-40dc-4246-3cad-08dc65d69a9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dUhaUFpkNXhJOUozVUZuZXZ4ZWcvQ0d0d05FLzFjZFR6T25JVlFidmRvbkli?=
 =?utf-8?B?dlN2VkRPT3RtUFZCbmRpdGpiWEthMnM0RUlFWUh2VWY4Mmdqbnh2dCtqQUx6?=
 =?utf-8?B?WUlhK2dHY0o3cGVpakUxSzNDUm16c0dVSkUxOEJSdzdIK01zQWcreXBjNkRO?=
 =?utf-8?B?MUtDSUZPTloyZVNGQUMxazFVYlhqSFpBN0kwcm1wZXhWek5HekYxNnl1bjF2?=
 =?utf-8?B?eHBuWWYxUWV2a0FHN0FKVks4aGlsTys0ZHozTTFjVEdtT1RZR292NlpPOHp0?=
 =?utf-8?B?b00zOTVoeDJ1L2p6NmpKbXRhcklOV0lIK0NpUGloUW5kN1ZYQ21wanREVWpJ?=
 =?utf-8?B?bmE0enNMSDA0SXk0REVTOWdoa2tXUDE4WmlVL0NkMk1TY1pWQjdXWHpMeU1M?=
 =?utf-8?B?SUQ4Q1hpU1Nvc0pFcUNyY29Dd3FsSG1XZGtDYnFGSzJVcDRHYjdxN3MvdDBN?=
 =?utf-8?B?RHAxN3ZxMVZjOW9CeFJFdUh6RXlWbjdJVGRsSlNzL2N4YXo1VExwM2xhWkp0?=
 =?utf-8?B?VXVKZVdnYVdLWm16RWJtcnEvT3FjK0VzMG9wK3FQT1hwMi9TU3djNGlKcktU?=
 =?utf-8?B?TVBKVFk2RUJuSDY4THV4bmk1dVBLMEM4OFhha1dYM0JWVVRWYXVKWE91ZWR2?=
 =?utf-8?B?VlphYUV4NDdESEtucmpOZFB2aE5BNjFkeHZKN3l0aHJ6TVFxNmlaV0VUVUM5?=
 =?utf-8?B?U1hDcXhkRHB3NE1scEk1cWpVNFM4eklLME9MUkpBcTFQODZ0MGFVejRKblQx?=
 =?utf-8?B?ZnMvS3BuVDV4bStUM0VDMVg0M2dLdzJzM3ZvdFJxaGdjQkY1cFd6SW0vc1BP?=
 =?utf-8?B?d0VkNHl1c3hSZ2RKZU9yWWgrMGZLOXVEUlFJYTkwTU5pTXFrUXJqbXNJMzVE?=
 =?utf-8?B?ZENVTm9UbHJTZy8xbjNYRnhqYTZ1ZVl1Y3BtNkRqWUJKSjdlREtuYUhOSklS?=
 =?utf-8?B?TGVjcjEwUE9mc2huMHlsV3c5d2NiVUQ0b0prNm9vcE1VcTBsUDlCb1hjck95?=
 =?utf-8?B?cDRWalhXbmdIVkxXMzdvcHhEM3BCTHF2UkkyY21XVUIwS0FLd1Y0alJVTUFv?=
 =?utf-8?B?Wks3RHBYVUV1WUFRekZIM3hhTW9PbjYrUGE0NDZRQVJIeGE2TzIyb2JJcGRl?=
 =?utf-8?B?S2hUanhiWThhTTk4MzhpREZBdFFoKzQxcytTSHozSER0d0l2YlZrKzRuZG5C?=
 =?utf-8?B?VkFzRlZoWDQvM2N3bkZ5dFVGUmQxYUYyNlN2NFBnQkl2T2pXalhwSXBOOWh6?=
 =?utf-8?B?SkN0UjFSU2dlMzAzVExWSkR5VUxqaG9ra280dFc0YTZ6L3ZpMFR4eDZhSXor?=
 =?utf-8?B?bW9STlBJT1F3MFRtWW1aUW9NS1pJVzlobG5URmdlejBwVHFOeGp1NW5FZllG?=
 =?utf-8?B?RmNrYVFrNk9iUUJHS3pmYlg0T3FaT1NUYzVpMXFRcUxHRlQwVm1JeEo5U21w?=
 =?utf-8?B?dUdYMFBMM1g1S0xUVlJiSnYvUnIrREkwajEzeE1CYUpObDRYYU1BZ0JzVkpj?=
 =?utf-8?B?YmNXc1UxZHYwdDd3VDVGUVVVZm1qTHl0dnBjZVFHbkNGZkhNaCt3MFRsbnNx?=
 =?utf-8?B?a1JSMGtkeE1DbG5nZUhpZCtXTU9iYVBXOWcvQTdGWHhtQ2dwcGh5TE1YMkdZ?=
 =?utf-8?B?SGI4NndhUHowVHp0Rk9wSUdlclMrUDJ6Q3FwUk83UDVnSWRqMDRNci9NSmVo?=
 =?utf-8?B?a1dXQW4wUnRhOUQ1c1hNWm5EOGR2Y0l1cG0vYTZSTmFvVFJtQWVEK21RRlhx?=
 =?utf-8?B?U2JMSWx0SGNxSGM4OGt3cS9WZWNydnNQUEN5WDJNaW94dXhQOWNGMVdvSXpz?=
 =?utf-8?B?endBM3drdjF1ZklMMlJRZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVpjeUJuTUlad3R6endqRzQvb2duNFRvc3VZQnRrUXpXeGRhN1h2bU4wNVhS?=
 =?utf-8?B?Y1l2NEI3c2N5WFcxd2pFNldwMHlHajJmd1pTZmMvZDJZMVRSVTVuZ1lFR1Rm?=
 =?utf-8?B?SFg3Z3lHUVRHV0FWenExTTg5dVBvRlBaS00rRGoydVdBL1ExME9tS2tCaTNM?=
 =?utf-8?B?SlBiOXZidzhNcW9RVVVKOW1ERVpEZ0x0T1I0Y1BRdnNhRFg2Y041V2xoQ2hz?=
 =?utf-8?B?aDBWaXcyM09EV1I1dnVDQ2xPM3o4V1FmWm84NmJuMkNmaERmeUdkeXNpTzB6?=
 =?utf-8?B?QnFVSkhLbmpZOHlZYWI0QTZPWGtOOHNZTVpMRVRPVnF2aDc1OEpJNzE5cEp4?=
 =?utf-8?B?ZWJWdHEySG5HWEh2VjlocHJqUUhYSnVLVUpOOVl2SWxCbHlXdVZpRlRNL3JE?=
 =?utf-8?B?VDVOcnRCZWw1cDVzbVlzTzhORjFmbS96ZWRqZ2lXK2RSYW4xNlVReTZpOWMr?=
 =?utf-8?B?cjM5dmUxNStsQXBzS1ZRdWJwTWllYTU3bHhUbUI0NWlkR1hEc1V3UW5iKzUr?=
 =?utf-8?B?K2pycHpacjJtRjZKR25UVFlZR3VoSnEvbG9rRm1XOVhnZUNoZmpJQkJWTHdF?=
 =?utf-8?B?WHBhc0lhM3k1a1BhYlMycGgwK2dzdUQyZXpPeTdBRDNHOUFNZmFHblFkSHNw?=
 =?utf-8?B?TjF1QXMwYUkxTFdxWmI0OHNMampzN3dPbWE4NllTTXo1YzJlVzROelRjRUp0?=
 =?utf-8?B?bmRSQzlOMEVPM25qcXc0VVpMNHI2ZXVZWjJiOENhSTJqR3A5QytyRERZSTJ2?=
 =?utf-8?B?U0tML1YwRS96T0hoc3NJNVZCUzhJWmlBc3grb3F3dXRGblVwRXhTaWFMeGt2?=
 =?utf-8?B?cGpIb1ZadTljandtRXVpSmpMVGdPQ25iTlhmaGtVaDkzWGpueEl5b21zclNt?=
 =?utf-8?B?bUZwSDkrUUVHMzZ3MmxPaGQ3bW1IRzNhbkJ4c2xlRkp3STdxRGIrUW0wMG5Q?=
 =?utf-8?B?YnlLMXpKR3o3N1l5eGRmUTVPK1M4RTErQVZ0K2p3SnRmL3NtVE9neTVqNitk?=
 =?utf-8?B?L2FacFllVEVmb1djYjkwMW82SU1ZL2RVZzJTRzRyZjZDcnRxdWNvQk9VcEQv?=
 =?utf-8?B?dGVLK1RIb0lyV0xlRlRtYkxpYkYralhUdDVmWXRlQ0JvNDJDT2YzMlZwUmNK?=
 =?utf-8?B?MXJXeUpxSnpCQ2dwT2VpZGVFNlRYVGpPWkhaY3BHdVlQNDVBVTd2cCt2R1Vp?=
 =?utf-8?B?eXRJekprRWtUeGpZcEF3a2J6SDZYMEJseUtZbEQrMG5MNTZ6K2FEdGo5RWVR?=
 =?utf-8?B?SFc1bUh3aUttSVE3ZmY5Z2JXOFZKTjNNUXRNWlI3aDZtYUZHUFRFTThoamRr?=
 =?utf-8?B?dHdvVUJsclBwTWZFbG1JTlZxRUpDT0ZYV1BHT1hrQWFMcGZRME1yRWpDaTQ3?=
 =?utf-8?B?RGFldDljdXBHVDZXWW5CNm53OElta1QrdFlZV2tTcHVIb1ZmbVNkUEk4WXFM?=
 =?utf-8?B?V3dFNDBYTGVCbmFvcklMTDZ3NHV4MWZ6OFJFZzNGbFg2Zkk5dS9aREJjenYv?=
 =?utf-8?B?QmMwSDFLelpTdmxXY01iMWNLQmNxWmJod0hPTldnQ2VidW1hRENYOGZiTE1O?=
 =?utf-8?B?eTNIV01UNExOd1RVajNHZ0E1bVJHSkNRcTJXdElIcGJRMFc0YzZlSlp0L0Jv?=
 =?utf-8?B?R29uRHJMYkRWK0Zya2hnVThBTEJwQ0w3MmQwVTFOWGREZzNhZThmMHo4cTJY?=
 =?utf-8?B?NlU1WGFidTlZTzhjdXdGUXpTb3N2V3N3dTRMTEV6a0FWanlDZ3dNVm53UjFa?=
 =?utf-8?B?U21Ya0c1SjZyTVFwaENoYXlTUkRuUTNzQ3doMCt5c1NVZ215SkR0cDRGZFpZ?=
 =?utf-8?B?UFNCd053cnBGTkwxaDBYMUNBS3lNNHJFdmlONUtmVWxxQU9aeHhQdTRySlN6?=
 =?utf-8?B?NG16Q1lHMkJXQUh6S2ZoRngxSWVWL2N4ZkpLUWRLKzN1eWJQSGZkR3hpZEZW?=
 =?utf-8?B?enVXQTl6clFMYkNkWTNrNFJYaFFMcHNUa013Nm1yYmwremZnOWIzTm1sM2FX?=
 =?utf-8?B?Sjc4ZGd4bmZHT2RvRitIZllNV0o2RmlFaUFLZlRFSDB3dERPUVBkaERYQnNz?=
 =?utf-8?B?MDhFVHM3bFFIOCtFL1NtU0VBdVhBNzBuanhEZGNVN3M1NnhGSnA1TGlncndv?=
 =?utf-8?B?eG9BQUh5bTk0YUZlSzA4TTNqaHNMRVE5SkhTUjVpdjhxWjd6V2ZkS3lHTDlS?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8ECDE2FB0D6BB4499D85B5454E126210@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c321aa79-40dc-4246-3cad-08dc65d69a9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 09:52:37.0561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PGCIencUHgDNkqvyx62/eiLLNWFAK7GE12GLS0tcPK/8g7rYv0GNE5w9AOBWr/EhzJkJhCUGWqRF3oUV4Xy+Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8186

T24gVGh1LCAyMDI0LTA0LTI1IGF0IDEwOjA3IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIA0KPiA+ID4gPiAgc3RydWN0IHNrX2J1ZmYgKnRhaWwgPSBOVUxM
Ow0KPiA+ID4gPiAgc3RydWN0IHNrX2J1ZmYgKm5za2IsICp0bXA7DQo+ID4gPiA+ICBpbnQgbGVu
X2RpZmYsIGVycjsNCj4gPiA+ID4gQEAgLTQ1MDQsNiArNDUwNSw5IEBAIHN0cnVjdCBza19idWZm
ICpza2Jfc2VnbWVudF9saXN0KHN0cnVjdA0KPiA+ID4gc2tfYnVmZg0KPiA+ID4gPiAqc2tiLA0K
PiA+ID4gPiAgaWYgKGVycikNCj4gPiA+ID4gIGdvdG8gZXJyX2xpbmVhcml6ZTsNCj4gPiA+ID4g
IA0KPiA+ID4gPiAraWYgKG1zcyAhPSBHU09fQllfRlJBR1MgJiYgbXNzICE9IHNrYl9oZWFkbGVu
KHNrYikpDQo+ID4gPiA+ICtyZXR1cm4gRVJSX1BUUigtRUZBVUxUKTsNCj4gPiA+ID4gKw0KPiA+
ID4gDQo+ID4gPiBEbyB0aGlzIHByZWNvbmRpdGlvbiBpbnRlZ3JpdHkgY2hlY2sgYmVmb3JlIHRo
ZSBza2JfdW5jbG9uZSBwYXRoPw0KPiA+IA0KPiA+IEFmdGVyIHJldHVybiBlcnJvciwgdGhlIHNr
YiB3aWxsIGVudGVyIGludG8ga2ZyZWVfc2tiLCBub3QNCj4gY29uc3VtZV9za2IuDQo+ID4gSXQg
bWF5IG1lZXQgc2FtZSBjcmFzaCBwcm9ibGVtIHdoaWNoIGhhcyBiZWVuIHJlc29sdmVkIGJ5DQo+
IHNrYl91bmNsb25lLg0KPiA+IA0KPiA+IE9yIGtmcmVlX3NrYiBjb3VsZCB3ZWxsIGhhbmRsZSB0
aGUgY2xvbmVkIHNrYidzIHJlbGVhc2U/DQo+IA0KPiBTaW5jZSB0aGlzIGlzIGFuIGVycm9yIHBh
dGggaXQgc2hvdWxkIHJlYWNoIGtmcmVlX3NrYiByYXRoZXIgdGhhbg0KPiBjb25zdW1lX3NrYi4N
Cj4gDQpTbyB3ZSBjb3VsZCBrZWVwIHRoZSBjaGVjayBhZnRlciB0aGUgc2tiX3VuY2xvbmUgcGF0
aCwgcmlnaHQ/DQoNCj4gPiANCj4gPiBPdGhlciBjaGFuZ2VzIGFyZSB1cGRhdGVkIGFzIGJlbG93
Og0KPiA+IA0KPiA+IEZyb20gMzAxZGE1YzlkNjU2NTJiYWM2MDkxZDRjZDY0Yjc1MWIzMzM4Zjhi
YiBNb24gU2VwIDE3IDAwOjAwOjAwDQo+IDIwMDENCj4gPiBGcm9tOiBTaGltaW5nIENoZW5nIDxz
aGltaW5nLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBEYXRlOiBXZWQsIDI0IEFwciAyMDI0IDEz
OjQyOjM1ICswODAwDQo+ID4gU3ViamVjdDogW1BBVENIIG5ldF0gbmV0OiBwcmV2ZW50IEJQRiBw
dWxsaW5nIFNLQl9HU09fRlJBR0xJU1Qgc2tiDQo+ID4gDQo+ID4gQSBTS0JfR1NPX0ZSQUdMSVNU
IHNrYiBjYW4ndCBiZSBwdWxsZWQgZGF0YQ0KPiA+IGZyb20gaXRzIGZyYWdsaXN0IGFzIGl0IG1h
eSByZXN1bHQgYW4gaW52YWxpZA0KPiA+IHNlZ21lbnRhdGlvbiBvciBrZXJuZWwgZXhjZXB0aW9u
Lg0KPiA+IA0KPiA+IEZvciBzdWNoIHN0cnVjdHVyZWQgc2tiIHdlIGxpbWl0IHRoZSBCUEYgcHVs
bGluZw0KPiA+IGRhdGEgbGVuZ3RoIHNtYWxsZXIgdGhhbiBza2JfaGVhZGxlbigpIGFuZCByZXR1
cm4NCj4gPiBlcnJvciBpZiBleGNlZWRpbmcuDQo+ID4gDQo+ID4gRml4ZXM6IDNhMTI5NmEzOGQw
YyAoIm5ldDogU3VwcG9ydCBHUk8vR1NPIGZyYWdsaXN0IGNoYWluaW5nLiIpDQo+ID4gU2lnbmVk
LW9mZi1ieTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogTGVuYSBXYW5nIDxsZW5hLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+ICBuZXQvY29yZS9maWx0ZXIuYyB8IDUgKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9uZXQvY29yZS9maWx0ZXIu
YyBiL25ldC9jb3JlL2ZpbHRlci5jDQo+ID4gaW5kZXggOGFkZjk1NzY1Y2RkLi44ZWQ0ZDVkODcx
NjcgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2NvcmUvZmlsdGVyLmMNCj4gPiArKysgYi9uZXQvY29y
ZS9maWx0ZXIuYw0KPiA+IEBAIC0xNjYyLDYgKzE2NjIsMTEgQEAgc3RhdGljIERFRklORV9QRVJf
Q1BVKHN0cnVjdCBicGZfc2NyYXRjaHBhZCwNCj4gPiBicGZfc3ApOw0KPiA+ICBzdGF0aWMgaW5s
aW5lIGludCBfX2JwZl90cnlfbWFrZV93cml0YWJsZShzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiA+
ICAgIHVuc2lnbmVkIGludCB3cml0ZV9sZW4pDQo+ID4gIHsNCj4gPiAraWYgKHNrYl9pc19nc28o
c2tiKSAmJg0KPiA+ICsgICAgKHNrYl9zaGluZm8oc2tiKS0+Z3NvX3R5cGUgJiBTS0JfR1NPX0ZS
QUdMSVNUKSAmJg0KPiA+ICsgICAgIHdyaXRlX2xlbiA+IHNrYl9oZWFkbGVuKHNrYikpIHsNCj4g
PiArcmV0dXJuIC1FTk9NRU07DQo+ID4gK30NCj4gPiAgcmV0dXJuIHNrYl9lbnN1cmVfd3JpdGFi
bGUoc2tiLCB3cml0ZV9sZW4pOw0KPiA+ICB9DQo+ID4gIA0KPiA+IC0tIA0KPiA+IDIuMTguMA0K
PiA+IA0KPiA+IA0KPiA+IEZyb20gNjRkNTUzOTJkZWJiYzkwZWYyZTljMzM0NDEwMjRkNjEyMDc1
YmRkNyBNb24gU2VwIDE3IDAwOjAwOjAwDQo+IDIwMDENCj4gPiBGcm9tOiBTaGltaW5nIENoZW5n
IDxzaGltaW5nLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBEYXRlOiBXZWQsIDI0IEFwciAyMDI0
IDE0OjQzOjQ1ICswODAwDQo+ID4gU3ViamVjdDogW1BBVENIIG5ldF0gbmV0OiBkcm9wIHB1bGxl
ZCBTS0JfR1NPX0ZSQUdMSVNUIHNrYg0KPiA+IA0KPiA+IEEgU0tCX0dTT19GUkFHTElTVCBza2Ig
d2l0aG91dCBHU09fQllfRlJBR1MgaXMNCj4gPiBleHBlY3RlZCB0byBoYXZlIGFsbCBzZWdtZW50
cyBleGNlcHQgdGhlIGxhc3QNCj4gPiB0byBiZSBnc29fc2l6ZSBsb25nLiBJZiB0aGlzIGRvZXMg
bm90IGhvbGQsIHRoZQ0KPiA+IHNrYiBoYXMgYmVlbiBtb2RpZmllZCBhbmQgdGhlIGZyYWdsaXN0
IGdzbyBpbnRlZ3JpdHkNCj4gPiBpcyBsb3N0LiBEcm9wIHRoZSBwYWNrZXQsIGFzIGl0IGNhbm5v
dCBiZSBzZWdtZW50ZWQNCj4gPiBjb3JyZWN0bHkgYnkgc2tiX3NlZ21lbnRfbGlzdC4NCj4gPiAN
Cj4gPiBUaGUgc2tiIGNvdWxkIGJlIHNhbHZhZ2VkLCB0aG91Z2gsIHJpZ2h0Pw0KPiA+IEJ5IGxp
bmVhcml6aW5nLCBkcm9wcGluZyB0aGUgU0tCX0dTT19GUkFHTElTVCBiaXQNCj4gPiBhbmQgZW50
ZXJpbmcgdGhlIG5vcm1hbCBza2Jfc2VnbWVudCBwYXRoIHJhdGhlciB0aGFuDQo+ID4gdGhlIHNr
Yl9zZWdtZW50X2xpc3QgcGF0aC4NCj4gDQo+IERyb3AgdGhlICJ0aG91Z2gsIHJpZ2h0PyINCj4g
PiANCj4gPiBUaGF0IGNob2ljZSBpcyBjdXJyZW50bHkgbWFkZSBpbiB0aGUgcHJvdG9jb2wgY2Fs
bGVyLA0KPiA+IF9fdWRwX2dzb19zZWdtZW50LiBJdCdzIG5vdCB0cml2aWFsIHRvIGFkZCBzdWNo
IGENCj4gPiBiYWNrdXAgcGF0aCBoZXJlLiBTbyBsZXQncyBhZGQgdGhpcyBiYWNrc3RvcCBhZ2Fp
bnN0DQo+ID4ga2VybmVsIGNyYXNoZXMuDQo+ID4gDQo+ID4gSWYgdGhlIGdzb19zaXplIGRvZXMg
bm90IG1hdGNoIHNrYl9oZWFkbGVuKCksDQo+ID4gaXQgbWVhbnMgcGFydCBvZiBvciB0aGUgZW50
aXJlIGZyYWdsaXN0IGhhcyBiZWVuIHB1bGxlZC4NCj4gPiBJdCBoYXMgYmVlbiBtZXNzZWQgd2l0
aCBhbmQgd2Ugc2hvdWxkIHJldHVybiBlcnJvciB0bw0KPiA+IGZyZWUgdGhpcyBza2IuDQo+IA0K
PiBUaGlzIHBhcmFncmFwaCBpcyBub3cgZHVwbGljYXRpdmUuIERyb3AuDQoNCk9LLCB1cGRhdGVk
IGFzIGJlbG93Og0KDQpGcm9tIDU5ZDU2MWFkYzEzZDUyZTNjMjI1YzZiODI3NmY2YTUzMzI0Zjdk
NTYgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBTaGltaW5nIENoZW5nIDxzaGltaW5n
LmNoZW5nQG1lZGlhdGVrLmNvbT4NCkRhdGU6IFdlZCwgMjQgQXByIDIwMjQgMTQ6NDM6NDUgKzA4
MDANClN1YmplY3Q6IFtQQVRDSCBuZXRdIG5ldDogZHJvcCBwdWxsZWQgU0tCX0dTT19GUkFHTElT
VCBza2INCg0KQSBTS0JfR1NPX0ZSQUdMSVNUIHNrYiB3aXRob3V0IEdTT19CWV9GUkFHUyBpcw0K
ZXhwZWN0ZWQgdG8gaGF2ZSBhbGwgc2VnbWVudHMgZXhjZXB0IHRoZSBsYXN0DQp0byBiZSBnc29f
c2l6ZSBsb25nLiBJZiB0aGlzIGRvZXMgbm90IGhvbGQsIHRoZQ0Kc2tiIGhhcyBiZWVuIG1vZGlm
aWVkIGFuZCB0aGUgZnJhZ2xpc3QgZ3NvIGludGVncml0eQ0KaXMgbG9zdC4gRHJvcCB0aGUgcGFj
a2V0LCBhcyBpdCBjYW5ub3QgYmUgc2VnbWVudGVkDQpjb3JyZWN0bHkgYnkgc2tiX3NlZ21lbnRf
bGlzdC4NCg0KVGhlIHNrYiBjb3VsZCBiZSBzYWx2YWdlZC4gQnkgbGluZWFyaXppbmcsIGRyb3Bw
aW5nDQp0aGUgU0tCX0dTT19GUkFHTElTVCBiaXQgYW5kIGVudGVyaW5nIHRoZSBub3JtYWwNCnNr
Yl9zZWdtZW50IHBhdGggcmF0aGVyIHRoYW4gdGhlIHNrYl9zZWdtZW50X2xpc3QgcGF0aC4NCg0K
VGhhdCBjaG9pY2UgaXMgY3VycmVudGx5IG1hZGUgaW4gdGhlIHByb3RvY29sIGNhbGxlciwNCl9f
dWRwX2dzb19zZWdtZW50LiBJdCdzIG5vdCB0cml2aWFsIHRvIGFkZCBzdWNoIGENCmJhY2t1cCBw
YXRoIGhlcmUuIFNvIGxldCdzIGFkZCB0aGlzIGJhY2tzdG9wIGFnYWluc3QNCmtlcm5lbCBjcmFz
aGVzLg0KDQpGaXhlczogM2ExMjk2YTM4ZDBjICgibmV0OiBTdXBwb3J0IEdSTy9HU08gZnJhZ2xp
c3QgY2hhaW5pbmcuIikNClNpZ25lZC1vZmYtYnk6IFNoaW1pbmcgQ2hlbmcgPHNoaW1pbmcuY2hl
bmdAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogTGVuYSBXYW5nIDxsZW5hLndhbmdAbWVk
aWF0ZWsuY29tPg0KLS0tDQogbmV0L2NvcmUvc2tidWZmLmMgfCA0ICsrKysNCiAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9uZXQvY29yZS9za2J1ZmYuYyBi
L25ldC9jb3JlL3NrYnVmZi5jDQppbmRleCBiOTkxMjc3MTJlNjcuLjQ3NzdmNWZlYTZjMyAxMDA2
NDQNCi0tLSBhL25ldC9jb3JlL3NrYnVmZi5jDQorKysgYi9uZXQvY29yZS9za2J1ZmYuYw0KQEAg
LTQ0OTEsNiArNDQ5MSw3IEBAIHN0cnVjdCBza19idWZmICpza2Jfc2VnbWVudF9saXN0KHN0cnVj
dCBza19idWZmDQoqc2tiLA0KIHsNCiAJc3RydWN0IHNrX2J1ZmYgKmxpc3Rfc2tiID0gc2tiX3No
aW5mbyhza2IpLT5mcmFnX2xpc3Q7DQogCXVuc2lnbmVkIGludCB0bmxfaGxlbiA9IHNrYl90bmxf
aGVhZGVyX2xlbihza2IpOw0KKwl1bnNpZ25lZCBpbnQgbXNzID0gc2tiX3NoaW5mbyhza2IpLT5n
c29fc2l6ZTsNCiAJdW5zaWduZWQgaW50IGRlbHRhX3RydWVzaXplID0gMDsNCiAJdW5zaWduZWQg
aW50IGRlbHRhX2xlbiA9IDA7DQogCXN0cnVjdCBza19idWZmICp0YWlsID0gTlVMTDsNCkBAIC00
NTA0LDYgKzQ1MDUsOSBAQCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiX3NlZ21lbnRfbGlzdChzdHJ1Y3Qg
c2tfYnVmZg0KKnNrYiwNCiAJaWYgKGVycikNCiAJCWdvdG8gZXJyX2xpbmVhcml6ZTsNCiANCisJ
aWYgKG1zcyAhPSBHU09fQllfRlJBR1MgJiYgbXNzICE9IHNrYl9oZWFkbGVuKHNrYikpDQorCQly
ZXR1cm4gRVJSX1BUUigtRUZBVUxUKTsNCisNCiAJc2tiX3NoaW5mbyhza2IpLT5mcmFnX2xpc3Qg
PSBOVUxMOw0KIA0KIAl3aGlsZSAobGlzdF9za2IpIHsNCi0tIA0KMi4xOC4wDQoNCj4gPiANCj4g
PiBGaXhlczogM2ExMjk2YTM4ZDBjICgibmV0OiBTdXBwb3J0IEdSTy9HU08gZnJhZ2xpc3QgY2hh
aW5pbmcuIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGltaW5nIENoZW5nIDxzaGltaW5nLmNoZW5n
QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZW5hIFdhbmcgPGxlbmEud2FuZ0Bt
ZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIG5ldC9jb3JlL3NrYnVmZi5jIHwgNCArKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvbmV0L2NvcmUvc2tidWZmLmMgYi9uZXQvY29yZS9za2J1ZmYuYw0KPiA+IGluZGV4IGI5OTEy
NzcxMmU2Ny4uNDc3N2Y1ZmVhNmMzIDEwMDY0NA0KPiA+IC0tLSBhL25ldC9jb3JlL3NrYnVmZi5j
DQo+ID4gKysrIGIvbmV0L2NvcmUvc2tidWZmLmMNCj4gPiBAQCAtNDQ5MSw2ICs0NDkxLDcgQEAg
c3RydWN0IHNrX2J1ZmYgKnNrYl9zZWdtZW50X2xpc3Qoc3RydWN0DQo+IHNrX2J1ZmYNCj4gPiAq
c2tiLA0KPiA+ICB7DQo+ID4gIHN0cnVjdCBza19idWZmICpsaXN0X3NrYiA9IHNrYl9zaGluZm8o
c2tiKS0+ZnJhZ19saXN0Ow0KPiA+ICB1bnNpZ25lZCBpbnQgdG5sX2hsZW4gPSBza2JfdG5sX2hl
YWRlcl9sZW4oc2tiKTsNCj4gPiArdW5zaWduZWQgaW50IG1zcyA9IHNrYl9zaGluZm8oc2tiKS0+
Z3NvX3NpemU7DQo+ID4gIHVuc2lnbmVkIGludCBkZWx0YV90cnVlc2l6ZSA9IDA7DQo+ID4gIHVu
c2lnbmVkIGludCBkZWx0YV9sZW4gPSAwOw0KPiA+ICBzdHJ1Y3Qgc2tfYnVmZiAqdGFpbCA9IE5V
TEw7DQo+ID4gQEAgLTQ1MDQsNiArNDUwNSw5IEBAIHN0cnVjdCBza19idWZmICpza2Jfc2VnbWVu
dF9saXN0KHN0cnVjdA0KPiBza19idWZmDQo+ID4gKnNrYiwNCj4gPiAgaWYgKGVycikNCj4gPiAg
Z290byBlcnJfbGluZWFyaXplOw0KPiA+ICANCj4gPiAraWYgKG1zcyAhPSBHU09fQllfRlJBR1Mg
JiYgbXNzICE9IHNrYl9oZWFkbGVuKHNrYikpDQo+ID4gK3JldHVybiBFUlJfUFRSKC1FRkFVTFQp
Ow0KPiA+ICsNCj4gPiAgc2tiX3NoaW5mbyhza2IpLT5mcmFnX2xpc3QgPSBOVUxMOw0KPiA+ICAN
Cj4gPiAgd2hpbGUgKGxpc3Rfc2tiKSB7DQo+ID4gLS0gDQo+ID4gMi4xOC4wDQo+IA0KPiANCg==

