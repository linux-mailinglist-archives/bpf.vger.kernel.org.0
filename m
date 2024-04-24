Return-Path: <bpf+bounces-27677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 582528B0941
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 14:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA42F1F22E84
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 12:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E856F15B155;
	Wed, 24 Apr 2024 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aMO+BWq+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZE0C2gAC"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620FE15ADA6;
	Wed, 24 Apr 2024 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961385; cv=fail; b=ERrsaEUJU0FNC83eIL9FiY9XNI/Ar/4O7/aX+zqtE64YnZBiILiQrODyT8K9hv78URPZi0Nr0Wuq5FtA5E/e3aJelDdW1plEg1VvED7qHVRJs94W5YMFJH6KWJvmDoOjxPcxD3wBM5DO3BtwZmZ5YqPfv+BTsT/fSl+xzi0dD/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961385; c=relaxed/simple;
	bh=X93vhrX7Z+BO11RG7fktG4kkQk09W25jU2z8n1TzOME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nuru4Cda85FIFOki+cCQWfwL/YrwE6BY8ZxDQkuztGf5nP98/y/NKT5IVI61riv7j6bN0wk/Ro5uJraLxSrdGSQJLwFru6JpFUh66rxgPlzLvgrr0/fchbx+v9U+7RvCLGcMU6exIZDtB6HF73T8r9wJIppn89LsOx4vFhlk92s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aMO+BWq+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ZE0C2gAC; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 61f3c94a023511ef935d6952f98a51a9-20240424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=X93vhrX7Z+BO11RG7fktG4kkQk09W25jU2z8n1TzOME=;
	b=aMO+BWq+CfsH2+8NJCUbKx+XwkzqJtRiF8WnfvtFuTPiAU+tiVp7IJ1gUBrtKzxEQi+IgZez4li402wrEXulRU6YOHMRhxjkw3/W7jkBYf0Rrr6hSPYCatMuXvhBvF2A0WKf96fTQMMZRePG8tdAQBjYuIJOGvBuYwKW/9IU5Rg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:b43889d3-8f73-4d6e-adde-3592b855e627,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:930af791-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 61f3c94a023511ef935d6952f98a51a9-20240424
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 191411508; Wed, 24 Apr 2024 20:22:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Apr 2024 20:22:55 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Apr 2024 20:22:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij6HY7ZwucQmjzOQo8Axeq7PWG76XQgNfukD9fDoVybMzBWbIVKcIKMEvnJUfqD+NG3ZJgCp/BptS5D5xsJxRHH9jDropPffMoCQSEci8ET7FnbaSY8BkmqMr/Oc97PqfbMf/wWDSQAZBMxkt/wxlwJ26Ozw9+Zxe/Paoa7ueX9vFWmJqgAS63XG6prQh06ub2Sv9Ln++RiVIkofSGe6lqOgEmCVm+9iuWK0Z5CmD+rAhncKfUXMPGgkl0l2ZcMCErTsHz/OUp6RwE5frp8ohhCmT3H4Wxl9vwjLG5hmkwAVoHAdERmv2M8bN5lR/CoB0jYt3t23pDRl0ulKlpfV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X93vhrX7Z+BO11RG7fktG4kkQk09W25jU2z8n1TzOME=;
 b=DVXDh7zJ0SGpz0dKGoY1cjZhmKiEsqKho8/1sX1o9S8v4TtxuyG70gki+b5R6BlsYwO4BqS0Q+u5XeJA7MnnDGZPpuBtw5YcdpNlgclcGP8hLiBGwlA5JDYzO2ujfU9hPrImTZfcbFPHkE0DO0bzpqVLVyEwNdQLzK2pSKGS4BxcWFyUG51cUx5vNpWuJ+22NljNujgYmIJlTI7gsYwKJneext1gy/t9NZkgjXSPF7jX17GETJsp/yHvaSRIeieIzt5m7NhHkBq7IWh3Dp+rhncuKZwcwo9tDY8DFR7fkWAqqdbaWET0vLBtpfUu2sW6iyblffoKIjDns6AoKibvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X93vhrX7Z+BO11RG7fktG4kkQk09W25jU2z8n1TzOME=;
 b=ZE0C2gAC1bmqtK54qPjE+CP3BQ2yX1wQSF+WrclBD210Md5yqBRYluOHcxSB4DojKwoPAB3hZqHY/s8ZDmdmOQM2X3+pn1gftAKEDnordBzUGhoOgxMn+5LmKYM9/nmNPZzTttFaV/QOJSyM5vI50uZ5onyyuTSaYl0Rsa+eFUc=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by OSQPR03MB8459.apcprd03.prod.outlook.com (2603:1096:604:271::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.53; Wed, 24 Apr
 2024 12:22:53 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 12:22:53 +0000
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
Thread-Index: AQHaj0XOIxnbbRpuOEqwUbC2K0Us3rFpz0sAgABZ6oCAAArbAIAA8PYAgAAJ3wCAAAGxgIAAWJUAgACHpICAANEgAIAAdp6AgAAXCgCAAdtPAIAAXxYAgAA10YCAAANdgIAGGNsAgAA/VACAASp9AA==
Date: Wed, 24 Apr 2024 12:22:53 +0000
Message-ID: <274c7e9837e5bbe468d19aba7718cc1cf0f9a6eb.camel@mediatek.com>
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
In-Reply-To: <6627ff5432c3a_1759e929467@willemb.c.googlers.com.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|OSQPR03MB8459:EE_
x-ms-office365-filtering-correlation-id: 20a4714b-7f25-4132-d880-08dc645943e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?UUUyaysrOWZ2OXJKb2xLbm1hRjF6YUZCeEdGcldaNTh2Nmd0OTVOR2Z4NkZx?=
 =?utf-8?B?b2VoQ1RuZ3p3UW93NkNseS9lQkFRWDA4MU9KNGx2SktseUV5Q29STVdJa3Nt?=
 =?utf-8?B?ZStya1dhMXVkN3BKNjlHK3dKZFNHSVJrQWMrejVzL08zNSt2aGZoVGphVXdk?=
 =?utf-8?B?Y0ZhWlE4bmRDVXBsR0o3TjhmRDJsbER6UXdGMUc4b09qMEs4U093NjhjTFl6?=
 =?utf-8?B?cVNHRGxGMlBvRHlFT1BYTklCWno5T1h4S2hsVDcwWlFqVjVoUGloVjFrVWF0?=
 =?utf-8?B?OWk1SjZxYkwvMGMyUzNteTJySnM2RzNudlc3SkdxYzg3dUQyd1FTWFhwL0VJ?=
 =?utf-8?B?VW94V2FwcDFndEJJUmZnSXlaVGpmOCttZGRnT1RvbjFSVWZ4alY4enU5ZjM4?=
 =?utf-8?B?ZU5CSU41VVBsaE1WR2F0c3hVVDVjalFMaEwxc3VYQXVsSnAySE11cThDVGd6?=
 =?utf-8?B?R2hyZHQ2RGN0VXQ3NkU0U0w2VVZ1elYyYm5IWEFKbzE2U1FYOENiNHczTlZk?=
 =?utf-8?B?RFBQTlZvTEdCUkhvRlF4U3ZlaXNYamt0MkVXTjFNTjRjcitvdXFaeU9KZ2hk?=
 =?utf-8?B?VW1ib1dUVEhZTHNIYUgyWEZRWkJwcWRtbmoxMFErdFBxaHJqeWQyY3JWZzJR?=
 =?utf-8?B?WnhWVVRhNWRvMkJtOHJKSEpEVzY3TlN4SURKWlJOOWpLSVdXeXlCZDJxRU5s?=
 =?utf-8?B?RzBzcUVLTDBQZ2x1dHgwNzFvZks1TlpMWWpOWGRMME16dmZxNHBOb3lId1VE?=
 =?utf-8?B?WXZHbWxiZUxHRi9oa3pyOFkwUmI5aEUrQXpOQWx3b3lyeElxUTRJWVJuSU1k?=
 =?utf-8?B?ZzVub0hhK3hzVVh1eVFqTmdsUG5rOXhXL3g2YmN1c3hod0FaQWJZSytXRSty?=
 =?utf-8?B?VFRPMWlWOWdrM3VkZEdGWncvU1lhUU9kOEJZbXYreS9KNDJlZzBSZXVaNVRT?=
 =?utf-8?B?QW5DcTZtczE1RTVEZW5kR0s4bWFtMklyZWlvWmR4Qmt6Z2NFT1d4QS9SVzdr?=
 =?utf-8?B?VnhjZkJnQmZOeTd1UXRnbjN1TFBtT2gxanNBTm9heFJGd0Fqazd6bVRLdmYx?=
 =?utf-8?B?VVk3dmdMN2dtOUIvUEl3NFh6ZWpIVEVXUE9rUFFMVEhMYXJ1dXlHTUJyakZS?=
 =?utf-8?B?bW5rR1RYS2ZsOFhNbHJVZlVoKzNHWW9qM2JSR2pvS3FTeDgxYVVsVlQ4NU4y?=
 =?utf-8?B?UGFleEZCMlJDRU1WcDI2WDM3bW1qa0xwSnZRWE9BbmhERUJFL0EvanpkMVhH?=
 =?utf-8?B?VEFQTEE3QnJybTlVN3oydWdKcEliejJkdFZ6SHFUd0JQTnVUekZEVm1XbjZF?=
 =?utf-8?B?Y3lHS2VMNjdvWUJuNFc0eWR6KzZWdzg2L0t5SEMxc2tHdmszYjl6emFKZUNh?=
 =?utf-8?B?OUlTSjlOSm1FY3lXNC91UVZlU2tJSXdCZWVvNTNMWlRieUhRYS9EcUczaVRF?=
 =?utf-8?B?dmlDLzJZOHVBaGdLbTVLRm9jdVRIL0piQmsrZDZxc29zVlg0SUwzVENjUHVz?=
 =?utf-8?B?T3o5WFdWSWdqWmNjN3VWZi9tWDhDVWJNV3k3NWl3WWUxTGZZSlg1OHd3WExN?=
 =?utf-8?B?RVFQY2pnalNVWTd3dS9xaEdwdjJjVmk5cEZDeGFrclRUNG45aWphNFJ4Y09K?=
 =?utf-8?B?SEt0a3ZHSlltSmVRRGFrTldPTGZLa2FjcjVUcWtTUjFteno3WnFiZzV5Wm1w?=
 =?utf-8?B?QVRWT1FXNmdOaU9TRlBSSFNRM2g4Z2w4MGt3MkMyM0hjZUYrR3NlSjdKVzJZ?=
 =?utf-8?B?a2hGTHp1QUNWRUtQS285LzVlMktuZUtUd0ZnZjRQRFcyWUNPaUkrMUhjVTF3?=
 =?utf-8?B?blNhdlRuQ25zd1ZrMEdPdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tk5EWFJyVytHTnN5ZWFVYXhrbGIxYkJiemZ1bWxUN3ZFZGhnanI3V0dCTVVU?=
 =?utf-8?B?S0xhTXp4VHZTaWhhQXIzUmxOMG5Fd3l1ZmZoU3h3MVcwMW1zV3l1MjNLcTlL?=
 =?utf-8?B?UmlhRlk2WHNZUkJiOTNKdFRjanJXYmdRRzVzbnB6ZVNiYmtNTVRhUTN0UlJP?=
 =?utf-8?B?MjZBSEV2cEVsUm8rYytiWkVPWWwyaWlicHFZa1RJV3ZweWw4WHlhVHBydjh3?=
 =?utf-8?B?dW1XbHNVeHluYUhHYjhHcFdlcWJSMk5NVGxESFFQTEdxSFhkSEZBUGVHUHFx?=
 =?utf-8?B?UGRKaUJSRlJ2WFlORDhMK2FmWUlwaWtQakJ5eTRKTVMralZaUU5YTFFFNGlq?=
 =?utf-8?B?NUNEb2lmS3pCbzU1eGp4RzZJTHlPT0hpWG8rWlFXeWFrMXZIUFBkaWM2OHJq?=
 =?utf-8?B?aHlHbVA5YVk4cTZhak9iL1lqY0pVTDRCT0N0T1hQWVhWK0F2OUdRQ0poZGlr?=
 =?utf-8?B?OW16ditKNzNyVU5YcWw3alNNZWtNODdOT1NlK0FWRXRvR1JVOFVlelJIbHRs?=
 =?utf-8?B?Y3BiZnRHMEtBWkJsSDlaVTdERmdhZGRmMC9keVN3UWI5UjBlbkhpa29wWjdC?=
 =?utf-8?B?NlFUZ2plSDd5Ni9DOGx1OXc5TmtpYWFMbXlhN3BpdXdUQ3czK20vOGdYRnpi?=
 =?utf-8?B?bm9IbDEzdjdFWTBVTFdVQWJVcjlRZktYUlRzMFo3a0NGQ0plS0RXUGk1ZVRl?=
 =?utf-8?B?SklaRGV0Q0NSTHFDSUlBeXU2ekZmR092Mm0weGxTZmlUL0VqcG9UUjdLNXR0?=
 =?utf-8?B?WVZwdGZmdm1BZHcrK0lSTGxaeTB0eEhIOG1lZG10Yk55WVJvMjJZR3YweXJ0?=
 =?utf-8?B?cjg4bTZDTTR0QVA3WExqOHhNQkxmdk5pOE9ISUZvTXZQaXJ5K29rclpMSSt0?=
 =?utf-8?B?YjZ0OGtLbm5wamhmakVRazRmWEs5S1RIWk9ubEl0SGN5Z0FvbitBNmYwV211?=
 =?utf-8?B?OTV3MC9NZDdIZVJydWV6a05TeUVnTXhlbXRScFB5RGwydGpyUW9BN0ZlRDMw?=
 =?utf-8?B?THY5b1p0UVNpTEU1WE1xd2RrWXIrL3FWNHVoSlV2VFdYZjNKQjI2aFFTaW5n?=
 =?utf-8?B?ckViNzVVRVdRQWJQUnAwY21PdWZxUnFzdEZicy9mMFRlZVZ1dnpqenIxaUZL?=
 =?utf-8?B?VTJlNzZYTGJZRlo5c0JENUh0SUdtaFVOak9JOTRKZEVmbEZnZ0ZNWWpFdWxM?=
 =?utf-8?B?QS8yS3JNckhBOWREd2tQMXZrWnpPcytoWDl2VThMYUxyN1lFSlJ5Z0tLcE1X?=
 =?utf-8?B?WkN0TVBpMFVLWld1b3pZSkZjQkMwK2tLeUNXS0ZvQ1BSMTZkWU1wS1ZraEwz?=
 =?utf-8?B?M1FVYmxCSUtJSS8yRjJTUXd2SzVMYldiOEhOclR2eERWdVNRR2ZTUkcyeDBv?=
 =?utf-8?B?aHRKRUtwMlZtVXl3MEtBbnZYclpEMkFVWXVDRmZ6cEN1bFovZm9GL1lIVTFs?=
 =?utf-8?B?UEZDaHU3c0V3c0lDdWFPNmlZZTlhS0ZKMkx3UklPSTlSTCszU0NNcG9DTXgv?=
 =?utf-8?B?c0FPblE0NlJuSVhPdy8zTy93SWpMaWE2a29vRmhPTlFVZjQ2bndNemlUbmJH?=
 =?utf-8?B?NXVRMWkvT0ZFUldRQm5Lek1KZndkZlBYMmlzdkdTOHlENWl6MnVJbVVQcmQv?=
 =?utf-8?B?UklsRjlhMkx4NXZjRnhEc05zeW1vOFZIUlhqcVdCbkUzaDJDa1dDN2FHenow?=
 =?utf-8?B?ejFQVWoybk9aZjd1cFdlWVBrTUFEOWpuNXBHUDU3bnlGdHFGVGx2U2tXUWth?=
 =?utf-8?B?OHZOc1hOZEpDMXd3UUNOQnB4WG9pNTJOYUhOWk1nM2pCZ3JIY2tUS2tvdDVC?=
 =?utf-8?B?VnZwbCt0MGhaUFAzSysxMkFPaHdBMVIzWDZ4MWpBaGp2aC9WUmUxOFhUeFEz?=
 =?utf-8?B?U3MyZzA2NE1HNzhxUmN0alRuc2FUa3dUNmdGNC9HWC93MmRkQ29xSmV3UDAw?=
 =?utf-8?B?SzdnQ20yUW9hdG9nWFlQQnl3NEd3Zmg4aUE5NitXdnpFdFJmYW5Rc0JCdzkr?=
 =?utf-8?B?ZGpUMmkrSStmS0VwVktSTzVkVmZGMGxUOC9DcmNhcnRFMmlPZlJGblBxM3Y5?=
 =?utf-8?B?enNnUlV1MmI4Qld2dTI3ditSbDFJeGFyVi9STlovb0tSak0rdXUyaC9PWG43?=
 =?utf-8?B?Rm1leVk0aE9laUhjOEZCVmVUNjU0MWFldS9lNmRvVms3VWJWdDRONFZBbURj?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <976C92BF79640B428B847572B05A9239@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a4714b-7f25-4132-d880-08dc645943e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 12:22:53.3802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqHdpKEuvuK8OikqthJL5vzH3yI8/3JkeArzleJSGaKylHZFhBmyjnounWgwQYIyWU/gqYBm8K1is9MXqpXSSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8459

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDE0OjM1IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gID4gSGkgV2lsbGVtLA0KPiA+IEFzIHRoZSBkaXNjdXNzaW9uLCBp
cyBpdCBPSyBmb3IgdGhlIHBhdGNoIGJlbG93Pw0KPiANCj4gVGhhbmtzIGZvciBpdGVyYXRpbmcg
b24gdGhpcy4NCj4gDQo+IEkgd291bGQgbGlrZSB0aGUgb3BpbmlvbiBhbHNvIG9mIHRoZSBmcmFn
bGlzdCBhbmQgVURQIEdSTyBleHBlcnRzLg0KPiAgDQo+IFllcywgSSB0aGluayBib3RoDQo+IA0K
PiAtIHByb3RlY3Rpbmcgc2tiX3NlZ21lbnRfbGlzdCBhZ2FpbnN0IGNsZWFybHkgaWxsZWdhbCBm
cmFnbGlzdA0KPiBwYWNrZXRzLCBhbmQNCj4gLSBibG9ja2luZyBCUEYgZnJvbSBjb25zdHJ1Y3Rp
bmcgc3VjaCBwYWNrZXRzDQo+IA0KPiBhcmUgd29ydGh3aGlsZSBzdGFibGUgZml4ZXMuIEkgYmVs
aWV2ZSB0aGV5IHNob3VsZCBiZSB0d28gc2VwYXJhdGUNCj4gcGF0Y2hlcy4gQm90aCBwcm9iYWJs
eSB3aXRoIHRoZSBzYW1lIEZpeGVzIHRhZzogM2ExMjk2YTM4ZDBjDQo+ICgibmV0OiBTdXBwb3J0
IEdSTy9HU08gZnJhZ2xpc3QgY2hhaW5pbmciKS4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL25ldC9j
b3JlL2ZpbHRlci5jIGIvbmV0L2NvcmUvZmlsdGVyLmMNCj4gPiBpbmRleCAzYTYxMTBlYTQwMDku
LmFiYzYwMjljOGVlZiAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvY29yZS9maWx0ZXIuYw0KPiA+ICsr
KyBiL25ldC9jb3JlL2ZpbHRlci5jDQo+ID4gQEAgLTE2NTUsNiArMTY1NSwxMSBAQCBzdGF0aWMg
REVGSU5FX1BFUl9DUFUoc3RydWN0IGJwZl9zY3JhdGNocGFkLA0KPiA+IGJwZl9zcCk7DQo+ID4g
IHN0YXRpYyBpbmxpbmUgaW50IF9fYnBmX3RyeV9tYWtlX3dyaXRhYmxlKHN0cnVjdCBza19idWZm
ICpza2IsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5z
aWduZWQgaW50IHdyaXRlX2xlbikNCj4gPiAgew0KPiA+ICsgICAgICAgaWYgKHNrYl9pc19nc28o
c2tiKSAmJiAoc2tiX3NoaW5mbyhza2IpLT5nc29fdHlwZSAmDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgU0tCX0dTT19GUkFHTElTVCkgJiYgKHdyaXRlX2xlbiA+DQo+ID4gc2tiX2hlYWRs
ZW4oc2tiKSkpIHsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gKyAg
ICAgICB9DQo+ID4gKw0KPiANCj4gSW5kZW50YXRpb24gbG9va3Mgb2ZmLCBidXQgSSBhZ3JlZSB3
aXRoIHRoZSBsb2dpYy4NCj4gDQo+ICAgICBpZiAoc2tiX2lzX2dzbyhza2IpICYmDQo+ICAgICAg
ICAgKHNrYl9zaGluZm8oc2tiKS0+Z3NvX3R5cGUgJiBTS0JfR1NPX0ZSQUdMSVNUKSAmJg0KPiAg
ICAgICAgICAod3JpdGVfbGVuID4gc2tiX2hlYWRsZW4oc2tiKSkpDQo+IA0KPiA+ICAgICAgICAg
cmV0dXJuIHNrYl9lbnN1cmVfd3JpdGFibGUoc2tiLCB3cml0ZV9sZW4pOw0KPiA+ICB9DQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL25ldC9jb3JlL3NrYnVmZi5jIGIvbmV0L2NvcmUvc2tidWZmLmMN
Cj4gPiBpbmRleCA3M2IxZTBlNTM1MzQuLjJlOTA1MzRjMWExZSAxMDA2NDQNCj4gPiAtLS0gYS9u
ZXQvY29yZS9za2J1ZmYuYw0KPiA+ICsrKyBiL25ldC9jb3JlL3NrYnVmZi5jDQo+ID4gQEAgLTQw
MzYsOSArNDAzNiwxMSBAQCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiX3NlZ21lbnRfbGlzdChzdHJ1Y3QN
Cj4gc2tfYnVmZg0KPiA+ICpza2IsDQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgdG5sX2hsZW4g
PSBza2JfdG5sX2hlYWRlcl9sZW4oc2tiKTsNCj4gPiAgICAgICAgIHVuc2lnbmVkIGludCBkZWx0
YV90cnVlc2l6ZSA9IDA7DQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgZGVsdGFfbGVuID0gMDsN
Cj4gPiArICAgICAgIHVuc2lnbmVkIGludCBtc3MgPSBza2Jfc2hpbmZvKHNrYiktPmdzb19zaXpl
Ow0KPiA+ICAgICAgICAgc3RydWN0IHNrX2J1ZmYgKnRhaWwgPSBOVUxMOw0KPiA+ICAgICAgICAg
c3RydWN0IHNrX2J1ZmYgKm5za2IsICp0bXA7DQo+ID4gICAgICAgICBpbnQgbGVuX2RpZmYsIGVy
cjsNCj4gPiArICAgICAgIGJvb2wgZXJyX2xlbiA9IGZhbHNlOw0KPiA+IA0KPiA+ICAgICAgICAg
c2tiX3B1c2goc2tiLCAtc2tiX25ldHdvcmtfb2Zmc2V0KHNrYikgKyBvZmZzZXQpOw0KPiA+IA0K
PiA+IEBAIC00MDQ3LDYgKzQwNDksMTQgQEAgc3RydWN0IHNrX2J1ZmYgKnNrYl9zZWdtZW50X2xp
c3Qoc3RydWN0DQo+IHNrX2J1ZmYNCj4gPiAqc2tiLA0KPiA+ICAgICAgICAgaWYgKGVycikNCj4g
PiAgICAgICAgICAgICAgICAgZ290byBlcnJfbGluZWFyaXplOw0KPiA+IA0KPiA+ICsgICAgICAg
aWYgKG1zcyAhPSBHU09fQllfRlJBR1MgJiYgbXNzICE9IHNrYl9oZWFkbGVuKHNrYikpIHsNCj4g
PiArICAgICAgICAgICAgICAgaWYgKCFsaXN0X3NrYikgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gZXJyX2xpbmVhcml6ZTsNCj4gDQo+IFRoZSBsYWJlbCBubyBsb25nZXIgdHJ1
bHkgY292ZXJzIHRoZSBtZWFuaW5nLg0KPiANCj4gQnV0IHRoYXQgaXMgYWxyZWFkeSB0cnVlIHNp
bmNlIHRoZSBhYm92ZSAoc2Vjb25kKSBqdW1wIHdhcyBhZGRlZCBpbg0KPiBjb21taXQgYzMyOWIy
NjFhZmU3ICgibmV0OiBwcmV2ZW50IHNrYiBjb3JydXB0aW9uIG9uIGZyYWcgbGlzdA0KPiBzZWdt
ZW50YXRpb24iKS4NCj4gDQo+IE5laXRoZXIgbmVlZHMgdGhlIGtmcmVlX3NrYl9saXN0LCBhcyBz
a2ItPm5leHQgaXMgbm90IGFzc2lnbmVkIHRvDQo+IHVudGlsIHRoZSBsb29wLiBDYW4ganVzdCBy
ZXR1cm4gRVJSX1BUUigtRUZBVUxUKT8NCj4gDQo+ID4gKyAgICAgICAgICAgICAgIH0gZWxzZSB7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZXJyX2xlbiA9IHRydWU7DQo+ID4gKyAgICAg
ICAgICAgICAgIH0NCj4gPiArICAgICAgIH0NCj4gPiArDQo+IA0KPiBXaHkgdGhlIGJyYW5jaD8g
TWlnaHQgYXMgd2VsbCBhbHdheXMgZmFpbCBpbW1lZGlhdGVseT8NCj4gDQpIaSBXaWxsZW0sDQpU
aGFua3MgZm9yIHlvdXIgZ3VpZGFuY2UuDQpZb3UgYXJlIHJpZ2h0LiBUaGVyZSBpcyBubyBuZWVk
IGZvciBhbm90aGVyIGJyYW5jaCBhcyBmcmFnbGlzdA0KY291bGQgYmUgZnJlZWVkIGluIGtmcmVl
X3NrYi4NCkNvdWxkIEkgZ2l0IHNlbmQgbWFpbCB3byBwYXRjaGVzIGFzIGJlbG93Pw0KDQpGcm9t
IDkzMzIzNzQwMGMwZTJmYTk5NzQ3MGI3MGZmMGU0MDc5OTZmYTIzOWMgTW9uIFNlcCAxNyAwMDow
MDowMCAyMDAxDQpGcm9tOiBTaGltaW5nIENoZW5nIDxzaGltaW5nLmNoZW5nQG1lZGlhdGVrLmNv
bT4NCkRhdGU6IFdlZCwgMjQgQXByIDIwMjQgMTM6NDI6MzUgKzA4MDANClN1YmplY3Q6IFtQQVRD
SCBuZXRdIG5ldDogcHJldmVudCBCUEYgcHVsbCBHUk9lZCBza2IncyBmcmFnbGlzdA0KDQpBIEdS
T2VkIHNrYiB3aXRoIGZyYWdsaXN0IGNhbid0IGJlIHB1bGxlZCBkYXRhDQpmcm9tIGl0cyBmcmFn
bGlzdCBhcyBpdCBtYXkgcmVzdWx0IGEgaW52YWxpZA0Kc2VnbWVudGF0aW9uIG9yIGtlcm5lbCBl
eGNlcHRpb24uDQoNCkZvciBzdWNoIHN0cnVjdHVyZWQgc2tiIHdlIGxpbWl0IHRoZSBCUEYgcHVs
bA0KZGF0YSBsZW5ndGggc21hbGxlciB0aGFuIHNrYl9oZWFkbGVuKCkgYW5kIHJldHVybg0KZXJy
b3IgaWYgZXhjZWVkaW5nLg0KDQpGaXhlczogM2ExMjk2YTM4ZDBjICgibmV0OiBTdXBwb3J0IEdS
Ty9HU08gZnJhZ2xpc3QgY2hhaW5pbmcuIikNClNpZ25lZC1vZmYtYnk6IFNoaW1pbmcgQ2hlbmcg
PHNoaW1pbmcuY2hlbmdAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogTGVuYSBXYW5nIDxs
ZW5hLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogbmV0L2NvcmUvZmlsdGVyLmMgfCA1ICsrKysr
DQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvbmV0L2Nv
cmUvZmlsdGVyLmMgYi9uZXQvY29yZS9maWx0ZXIuYw0KaW5kZXggOGFkZjk1NzY1Y2RkLi44ZWQ0
ZDVkODcxNjcgMTAwNjQ0DQotLS0gYS9uZXQvY29yZS9maWx0ZXIuYw0KKysrIGIvbmV0L2NvcmUv
ZmlsdGVyLmMNCkBAIC0xNjYyLDYgKzE2NjIsMTEgQEAgc3RhdGljIERFRklORV9QRVJfQ1BVKHN0
cnVjdCBicGZfc2NyYXRjaHBhZCwNCmJwZl9zcCk7DQogc3RhdGljIGlubGluZSBpbnQgX19icGZf
dHJ5X21ha2Vfd3JpdGFibGUoc3RydWN0IHNrX2J1ZmYgKnNrYiwNCiAJCQkJCSAgdW5zaWduZWQg
aW50IHdyaXRlX2xlbikNCiB7DQorCWlmIChza2JfaXNfZ3NvKHNrYikgJiYNCisJICAgIChza2Jf
c2hpbmZvKHNrYiktPmdzb190eXBlICYgU0tCX0dTT19GUkFHTElTVCkgJiYNCisJICAgICB3cml0
ZV9sZW4gPiBza2JfaGVhZGxlbihza2IpKSB7DQorCQlyZXR1cm4gLUVOT01FTTsNCisJfQ0KIAly
ZXR1cm4gc2tiX2Vuc3VyZV93cml0YWJsZShza2IsIHdyaXRlX2xlbik7DQogfQ0KIA0KLS0gDQoy
LjE4LjANCg0KDQpGcm9tIDJkMDcyOWIyMGNmODEwYmExYjMxZTA0Njk1MmMxY2Q3OGYyOTVjYTMg
TW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBTaGltaW5nIENoZW5nIDxzaGltaW5nLmNo
ZW5nQG1lZGlhdGVrLmNvbT4NCkRhdGU6IFdlZCwgMjQgQXByIDIwMjQgMTQ6NDM6NDUgKzA4MDAN
ClN1YmplY3Q6IFtQQVRDSCBuZXRdIG5ldDogZHJvcCBHUk9lZCBza2IgcHVsbGVkIGZyb20gZnJh
Z2xpc3QNCg0KQSBHUk9lZCBza2Igd2l0aCBmcmFnbGlzdCBtYXliZSBwdWxsZWQgYnkgQlBGDQpv
ciBvdGhlciB3YXlzLiBJdCBjYW4ndCBiZSB0cnVzdGVkIGF0IGFsbCBldmVuDQppZiBvbmUgYnl0
ZSBpcyBwdWxsZWQgYW5kIHNob3VsZCBiZSBkcm9wcGVkDQpvbiBzZWdtZW50YXRpb24uDQoNCklm
IHRoZSBnc29fc2l6ZSBkb2VzIG5vdCBtYXRjaCBza2JfaGVhZGxlbigpLA0KaXQgbWVhbnMgdG8g
YmUgcHVsbGVkIHBhcnQgb2Ygb3IgdGhlIGVudGlyZQ0KZnJhZ2xzaXQuIEl0IGhhcyBiZWVuIG1l
c3NlZCB3aXRoIGFuZCB3ZSByZXR1cm4NCmVycm9yIHRvIGZyZWUgdGhpcyBza2IuDQoNCkZpeGVz
OiAzYTEyOTZhMzhkMGMgKCJuZXQ6IFN1cHBvcnQgR1JPL0dTTyBmcmFnbGlzdCBjaGFpbmluZy4i
KQ0KU2lnbmVkLW9mZi1ieTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBMZW5hIFdhbmcgPGxlbmEud2FuZ0BtZWRpYXRlay5jb20+DQot
LS0NCiBuZXQvY29yZS9za2J1ZmYuYyB8IDQgKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL25ldC9jb3JlL3NrYnVmZi5jIGIvbmV0L2NvcmUvc2ti
dWZmLmMNCmluZGV4IGI5OTEyNzcxMmU2Ny4uNzUwZmJiNTFiOTlmIDEwMDY0NA0KLS0tIGEvbmV0
L2NvcmUvc2tidWZmLmMNCisrKyBiL25ldC9jb3JlL3NrYnVmZi5jDQpAQCAtNDQ5Myw2ICs0NDkz
LDcgQEAgc3RydWN0IHNrX2J1ZmYgKnNrYl9zZWdtZW50X2xpc3Qoc3RydWN0IHNrX2J1ZmYNCipz
a2IsDQogCXVuc2lnbmVkIGludCB0bmxfaGxlbiA9IHNrYl90bmxfaGVhZGVyX2xlbihza2IpOw0K
IAl1bnNpZ25lZCBpbnQgZGVsdGFfdHJ1ZXNpemUgPSAwOw0KIAl1bnNpZ25lZCBpbnQgZGVsdGFf
bGVuID0gMDsNCisJdW5zaWduZWQgaW50IG1zcyA9IHNrYl9zaGluZm8oc2tiKS0+Z3NvX3NpemU7
DQogCXN0cnVjdCBza19idWZmICp0YWlsID0gTlVMTDsNCiAJc3RydWN0IHNrX2J1ZmYgKm5za2Is
ICp0bXA7DQogCWludCBsZW5fZGlmZiwgZXJyOw0KQEAgLTQ1MDQsNiArNDUwNSw5IEBAIHN0cnVj
dCBza19idWZmICpza2Jfc2VnbWVudF9saXN0KHN0cnVjdCBza19idWZmDQoqc2tiLA0KIAlpZiAo
ZXJyKQ0KIAkJZ290byBlcnJfbGluZWFyaXplOw0KIA0KKwlpZiAobXNzICE9IEdTT19CWV9GUkFH
UyAmJiBtc3MgIT0gc2tiX2hlYWRsZW4oc2tiKSkNCisJCXJldHVybiBFUlJfUFRSKC1FRkFVTFQp
Ow0KKw0KIAlza2Jfc2hpbmZvKHNrYiktPmZyYWdfbGlzdCA9IE5VTEw7DQogDQogCXdoaWxlIChs
aXN0X3NrYikgew0KLS0gDQoyLjE4LjANCg0KPiA+ICAgICAgICAgc2tiX3NoaW5mbyhza2IpLT5m
cmFnX2xpc3QgPSBOVUxMOw0KPiA+IA0KPiA+ICAgICAgICAgd2hpbGUgKGxpc3Rfc2tiKSB7DQo+
ID4gQEAgLTQxMDksNiArNDExOSw5IEBAIHN0cnVjdCBza19idWZmICpza2Jfc2VnbWVudF9saXN0
KHN0cnVjdA0KPiBza19idWZmDQo+ID4gKnNrYiwNCj4gPiAgICAgICAgICAgICBfX3NrYl9saW5l
YXJpemUoc2tiKSkNCj4gPiAgICAgICAgICAgICAgICAgZ290byBlcnJfbGluZWFyaXplOw0KPiA+
IA0KPiA+ICsgICAgICAgaWYgKGVycl9sZW4pDQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJy
X2xpbmVhcml6ZTsNCj4gPiArDQo+ID4gICAgICAgICBza2JfZ2V0KHNrYik7DQo+ID4gDQo+ID4g
ICAgICAgICByZXR1cm4gc2tiOw0KPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiBCYWNrIHRvIHRo
ZSBvcmlnaW5hbCByZXBvcnQ6IHRoZSBpc3N1ZSBzaG91bGQgYWxyZWFkeSBoYXZlDQo+IGJlZW4N
Cj4gPiA+IGZpeGVkDQo+ID4gPiA+ID4gYnkgY29tbWl0IDg3NmU4Y2E4MzY2NyAoIm5ldDogZml4
IE5VTEwgcG9pbnRlciBpbg0KPiA+ID4gc2tiX3NlZ21lbnRfbGlzdCIpLg0KPiA+ID4gPiA+IEJ1
dCB0aGF0IGNvbW1pdCBpcyBpbiB0aGUga2VybmVsIGZvciB3aGljaCB5b3UgcmVwb3J0IHRoZQ0K
PiBlcnJvci4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFR1cm5zIG91dCB0aGF0IHRoZSBjcmFzaCBp
cyBub3QgaW4gc2tiX3NlZ21lbnRfbGlzdCwgYnV0DQo+IGxhdGVyIGluDQo+ID4gPiA+ID4gX191
ZHB2NF9nc29fc2VnbWVudF9saXN0X2NzdW0uIFdoaWNoIHVuY29uZGl0aW9uYWxseQ0KPiBkZXJl
ZmVyZW5jZXMNCj4gPiA+ID4gPiB1ZHBfaGRyKHNlZykuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBU
aGUgYWJvdmUgZml4IGFsc28gbWVudGlvbnMgc2tiIHB1bGwgYXMgdGhlIGN1bHByaXQsIGJ1dCBk
b2VzDQo+IG5vdA0KPiA+ID4gPiA+IGluY2x1ZGUgYSBCUEYgcHJvZ3JhbS4gSWYgdGhpcyBjYW4g
YmUgcmVhY2hlZCBpbiBvdGhlciB3YXlzLA0KPiB0aGVuDQo+ID4gPiB3ZQ0KPiA+ID4gPiA+IGRv
IG5lZWQgYSBzdHJvbmdlciB0ZXN0IGluIHNrYl9zZWdtZW50X2xpc3QsIGFzIHlvdSBwcm9wb3Nl
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBkb24ndCB3YW50IHRvIG5hcnJvd2x5IGNoZWNrIHdo
ZXRoZXIgdWRwX2hkciBpcyBzYWZlLg0KPiA+ID4gRXNzZW50aWFsbHksDQo+ID4gPiA+ID4gYW4g
U0tCX0dTT19GUkFHTElTVCBza2IgbGF5b3V0IGNhbm5vdCBiZSB0cnVzdGVkIGF0IGFsbCBpZg0K
PiBldmVuDQo+ID4gPiBvbmUNCj4gPiA+ID4gPiBieXRlIHdvdWxkIGdldCBwdWxsZWQuDQo+IA0K
PiANCg==

