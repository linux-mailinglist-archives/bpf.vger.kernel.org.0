Return-Path: <bpf+bounces-27556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4F58AE9D6
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFB81C219C3
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9DA13B58D;
	Tue, 23 Apr 2024 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZQXy2JZV";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AP5GITNj"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68384E02;
	Tue, 23 Apr 2024 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883688; cv=fail; b=UXS1rhBcm0IYwvX5relK8kX4EWnjdJmnBiWZOdNT7mhUdddjT2ysd2gut3fzGSJnDm4W1GvyFyimBI2E5m5aNR6XmL4W896J54PXpZmSkuRpMTUEs4dW7Y7RfqC87eTMtRHuU5LO62vVNXc6Adv+yOZJjPBtmA3j9DhlwuQmA64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883688; c=relaxed/simple;
	bh=uZC2rfVRve/uj0DF7eI6ZTRcYVBZCqBIFSRvR+qWuZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c6nIkzc97B+7vdvzYr6DgHjpMF4orqcUztDxBHUn4IzGc8/CtMxiHG5tjRLBNwaf9SyE1eCTpBwyRcRMosWqRrjKUz5+m/hpTst+5J7bh+1s21SmICgWpgICw78agojtDE9uJKBLiuJGDsxVxUq+EI1NFl8PXWCRQlpJ8nlRtMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZQXy2JZV; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=AP5GITNj; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 79f1b8f0018011ef935d6952f98a51a9-20240423
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uZC2rfVRve/uj0DF7eI6ZTRcYVBZCqBIFSRvR+qWuZk=;
	b=ZQXy2JZVNu30I3eBXvmsVJOFC3Fc6AyURvCN3eEUxvq5yRmg1VSw4cm8WaouAugi+zsNDvWdgNzG7gzlbje5FYNK27BXtdl9usa4kh13kNCyzld33vZFWLeNxPNW/Qc+KlWd8g2Zk/CFtCE7aUNkYd64DWabXRsxO5aMcIWbqX4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:f8e0c046-a193-47b8-82ee-cf0d057935f5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:979a8586-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 79f1b8f0018011ef935d6952f98a51a9-20240423
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1972575403; Tue, 23 Apr 2024 22:47:58 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 23 Apr 2024 22:47:57 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 23 Apr 2024 22:47:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EU+oSJq83xxFUAZQrUbsRuPEFKLZEGaHb6Trxkr39GYOzguFZ2Z8ICJ/INX4Fws5kSjJn45FZS7xzliwPJUMYQzdg2wV8GM/gAZ4+khJ9nX8v/B0lQdK1oD4yPqm9TRMfU4mhR6px/l145ynV8IQfss/ZKYgMHDF6GuYKs6TpbLTMhHHMwCEbcJXCiAr+7RL2jLBTqj/83Orq1C23j9UOl7ke3ADH++ukSHu3hDHBhc8cjY/8Kc60a9+yAHY8rUfV4K1dZ6D/q+9SUeWmbzmKZX8OyJtkFfU81pUplXXzpVnfQhR17dEQo72GVQzrXPTBl20FPRdLPwMql/Mm8T+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZC2rfVRve/uj0DF7eI6ZTRcYVBZCqBIFSRvR+qWuZk=;
 b=IrEwcZeh/GqYb/PHRq0B9osiMcksLGJJxcL1Vq9azsM4ovTEv66ZiemxXWJCGkyXx1mzaoQXS5fAgM2VJiJcszs7bWYVziC3DAs/Pl1SFYJ1TKwoESXD7nl5fHJ3qfQcEIoInw+bu0UtEv2GJE1B++p45MYHAsd5/bsLR5dsFHJpgRVWe9f2O02KAgs2qHFz9Ln92Y702Lh0TxAsDtyl3MLub3uH0CHCv9gtFwMzjBQhjTwFd/rOEHwPPHvWFv/CLx2I+FkOoQHsqd+gCjNynrdI7HLIzkCZg2QjPFOsR0W0+AE6klThT1Yq6PGT9s0FYEpJ6efidl3RUbERspa2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZC2rfVRve/uj0DF7eI6ZTRcYVBZCqBIFSRvR+qWuZk=;
 b=AP5GITNjbfa//ROHAuftrvfRAk8z22mg8nQLu15Ny6/3+Ya/kwaMaRDiCchfE7OSRl3hGzUYFSaEXy6zI7YFvzWlVVH5vZbrsZ66vWnrIaarH/OuKPoU/S5LMsFEv++dBuVT6fYQkTXyZnQIUWOJc9Vb5iycBO9rGZSFYx4gwjg=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by TY0PR03MB8299.apcprd03.prod.outlook.com (2603:1096:405:13::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 23 Apr
 2024 14:47:54 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 14:47:54 +0000
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
Thread-Index: AQHaj0XOIxnbbRpuOEqwUbC2K0Us3rFpz0sAgABZ6oCAAArbAIAA8PYAgAAJ3wCAAAGxgIAAWJUAgACHpICAANEgAIAAdp6AgAAXCgCAAdtPAIAAXxYAgAA10YCAAANdgIAGGNsA
Date: Tue, 23 Apr 2024 14:47:53 +0000
Message-ID: <9f097bcafc5bacead23c769df4c3f63a80dcbad5.camel@mediatek.com>
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
In-Reply-To: <6622acdd22168_122c5b2945@willemb.c.googlers.com.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|TY0PR03MB8299:EE_
x-ms-office365-filtering-correlation-id: d794bd91-432f-4966-f1da-08dc63a45b73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?RENqcW5SQTdMNkJITVdmZnNNMG03ZmllZUpwa2ttZjhpeEFKMWZTWXdvdUtP?=
 =?utf-8?B?VjdWamkrWTVtcW5RWTRhc3hBWVNPOTNjd3ZTL0ltWXNmM0l3L1RXMUJnbWti?=
 =?utf-8?B?YkJsZS9oZ0lWMHo4QXIzRGpFSUhMTG5HaVJnRDh2V3VMa3ozeGJMUUdEREp0?=
 =?utf-8?B?TGdhdEEyVjFta05DM0Rjb1BmWEdCNmIxS2VYRno2bWI1MXJ3K3F1OGF3RGVz?=
 =?utf-8?B?Z1VUL1NkRDZuR0o5d082ZjRQR1V1eDAwZEVyR2YwTWFQMWM5cTV5bnNpVm9v?=
 =?utf-8?B?S3ZBS284RURYeTJDVWJjb0VZME8ydW1CclhtWk9NNTUxSTVjTlN4cHZsaEJy?=
 =?utf-8?B?QklUakVzWnNibG5SVnRZZkc4c2dYU2oxWTF2bWxGYjJkdUVOWC9TNERnOXFK?=
 =?utf-8?B?cWFKYjQvT082Zzh3ZFNlcHF5dHAvVWRmM2RWdFN0ZGR0VEZoaHovdzVpMS9H?=
 =?utf-8?B?K011RFE4M1JNMjl0amM4UkhvRDQwVElTNTBsbmh0cHFYL20vT1V4UXdDT1NH?=
 =?utf-8?B?NU9NQjYrZVJjNjNZVlVFTlEvSWdNY3pzaS9OQ1R0VUZxVTk4eCtSUllaV3BJ?=
 =?utf-8?B?dnBHKytwNzdMTXo0TTJaT3FYdUEwdXRQeWdKcDE1ZTBBVXc5bFEvZnBRcnhU?=
 =?utf-8?B?OGQ1K1RVbTFhZFBGUWJ2QThDcmlYMXBwZzlzUmM1Qk1kQjlldy9aUlFqVzNo?=
 =?utf-8?B?dkV4WlpNK05aQ010RWl2bko4Y3Z3NG5sTVozVThubUpBYnJPdmNRR09Va0U1?=
 =?utf-8?B?NDRFQVZ4Q05yVUN1WFNkeVdlWXVRTkxFSW03cW1TR3VNdEVVMzZmRUpKRnNC?=
 =?utf-8?B?aDA0Y3h1ekhxbWc4aUNyS1RPQStzcE5nMGowTk41TnRISkJMaHdVNUhQWVdC?=
 =?utf-8?B?N1lYa1V2SWpPWk9ER3NVWGkxL3o0eWx1bmRHMnNUc0RLcmxWRC9JRmlXMGFV?=
 =?utf-8?B?YTJYdjVFSVI3SHNldnJ5OVVtRThkZmE4bHlIaytzUGdPakZWSnFKc05uclBP?=
 =?utf-8?B?aElKRkdrZFRVeXhORS9tQlRPUUxLcThZdEVSSXRMMHM2OFBFV1lsVEM5aTlS?=
 =?utf-8?B?RzhyV1U4dG9xUUZER0dudCtTaVJNSFhnRHpxRHR0OUJrL0RMaTRZYTUwL0ZF?=
 =?utf-8?B?UnZuTjZtbmJ3YXl0UER6NUlXc3B4VXdUWU11L3E5NjB0bVM1WHlvS09BMkEr?=
 =?utf-8?B?cGZLMDBwNkdzWFNwTlZMeW11bTJxTFh2NzMwNHNTb2RwNFpjcGdDa2lIWVVn?=
 =?utf-8?B?RHJxeGo1YjhGZzdmS2hnTDZadmJGM1hNeGlrc0xYUDFBUE5xRllpWFZWQXBi?=
 =?utf-8?B?K3M3UFpqZTRHWGtUWi9NRjNsZ1l4U2NJdXZSaC81Z2JiMkFXS2JOT3RCeGJ3?=
 =?utf-8?B?a2dLSG1NbUJHVnlURzRlaWxsaVN3WmdyU2gza25LaldEeXRGZW0vN1JyNGh6?=
 =?utf-8?B?czA1TUhCOWphYVcwZHhoUEtpTWN4MURkZXFDN09hSmF0MXJWVjd6clYzM0ls?=
 =?utf-8?B?enVtOFlTNzEwVitiOVF0WFdLNlA2dU50Qy9wcDk2NmZPb3FTSG1iQm05TFla?=
 =?utf-8?B?YnZ6a2k1RHRPRVNsMHRjYUw0anBHdyt0eFNFZ1Q5WDJabzdlQVdETzJzdDdH?=
 =?utf-8?B?MGJVMHlSOUVLVE9udGY2VHgyL0ZILzByMzhqRHgyUzVCMTVsaHlyZXVOSWJx?=
 =?utf-8?B?a0ZLN2NDZFlNdnpWRkthZVJ5ZDhCL3NYRE5sN04rejU1UEtUdFhrZVpsaE52?=
 =?utf-8?B?RndCQXpXSjBVZ3JjUUxuNFhWSWNSTUhsRlZ1SjZaRVNNTVh4YlpTV2l6ME94?=
 =?utf-8?B?MnRLTjl2czY5VjNvRURwdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azBKdHQ4ell5NVk4VjBZNkxEOWpGcWU1K3NibGthdDMrTHNkZ0tJRWF1SjQ2?=
 =?utf-8?B?YXo3NHhGcHIvZUwzallyR3dZSHhVMHFwbUZOSlo5N2FXQjM0Z3R1RzhZZHpN?=
 =?utf-8?B?L0twQVpjam45bjdFbnViL2YvdDZ1MXFqN1pacWJiUGxiazA3UnFhamhtWldK?=
 =?utf-8?B?em12OElrb2s2cGU5R3ZIMGpPYUVaVE5SZ0xwRmJLUGNvRTFMYjZQbXd4R1cy?=
 =?utf-8?B?NitoTmZET25qb3h1TktuK2M1YjVROUp5aUNmblFOY3dqTFVJanlHTUp1d2xj?=
 =?utf-8?B?M3U3Nmc1aERETHhXMWYzQkpUbytWTWFFa3pRRFZwd0QyQUdZSm9nRjVIdE5Y?=
 =?utf-8?B?cmljbFYwamlPYUduR0tDSWRVNzVLTDNrMWNIQWppUS9EbksvbUNzdStkdHIx?=
 =?utf-8?B?dVBKQ0tPK0FiZkFMR21RanlSQ0ROK1JNdytnZWlMbTVIcDM4TDhIRnAzTU02?=
 =?utf-8?B?cmczVkZSUXhyUnEydE8vRUwxNEZPQmlmTVE2K1J1UEIwWGxBZnF4TmJ5QXJw?=
 =?utf-8?B?MTh2b0JERFo4RitOUHdzb002VDl6NllVRGI3RjhnOWxxQmZxSnA1b0xsMERS?=
 =?utf-8?B?NjFyK29WUVFSL1ZHWU5rNFhVN21USVViM0VkaEJWaTNFcTd1UW1SeklsTng2?=
 =?utf-8?B?cHlCZkZjS1hOOVNZR2IvWTBCM3BwMlhOTnArVFV5NFZXN3o5cEorQVNURCta?=
 =?utf-8?B?bVV3U2dLYjI4Y0YyS2F1eUpWU1NUcExHSk1CcjE5N3BJOEg2NERlUkdEclYx?=
 =?utf-8?B?QndjZ0lCWEROSkRhRTlFTmxseVBqRTdlcHJ4MXd1L3FiS21PYlRaMit3N21l?=
 =?utf-8?B?S21QUlp6aFQ0dCsrNlU4S0d0VitWVDZkS2w2M1ViZmRrUHk0S1FNL2d4L2hs?=
 =?utf-8?B?OE1PREprblJHTW56Q2J5Vm9tMTdPbmtKd1ZiWGFhUnpwRWM1cjFhSlFQRkwx?=
 =?utf-8?B?K1NsenIrTG1xKzVaOE5XK1A2VHBISUpicm9vaTdMV0daRTdvNngzSkdER3pT?=
 =?utf-8?B?djN3a3BZSHducksvNnA4bloxRkkwZXFpNHdlcWZuZmJKbGVsTG5DTnNka2ZG?=
 =?utf-8?B?cHFDNDdRSWVYNVl3aGgwb2lST0t2NUNNbEdzdXVsMDVjRllNOVM0bm1mU3Qv?=
 =?utf-8?B?T2QxeEdrd2JKQWtGb3RnazY2RzNKa0N2V0VmOEs1YnJlN3dCRTJ1YjJjbXN1?=
 =?utf-8?B?d1E2a0w5OVRTUlhuZDh4ZmE2MnQwYVFSYzJjR2k3WTkvM0Evdy9DTkxnbzlF?=
 =?utf-8?B?VytXcS9xeHVLaC9NdUFqekxoZS9hMzlnSFBTbjVORkdNeEZzOE5iV0RwZlNK?=
 =?utf-8?B?cUJPK25nQlZHRjMwQ3ZsbGZGcWw3cVpCTHg1N2NxTUhUbGNRcmlIR2lQeWxq?=
 =?utf-8?B?d1FPV3lmM1B5R2tMSjhzRHJ0SEd5bXE0S0VsdE9JeHZ2cjZLVGFwWlVqV0ds?=
 =?utf-8?B?S0tRQ0dwVERkeEp4WTVaN3hnWHA1OTcrajA2SVRmekJndTlTMlRNUTVwNS9i?=
 =?utf-8?B?OWxtNXphZnVKZnFJb2JydnR0NmJqVnF0aGhDYkwyS0h0QlhUQThNbFdYaUNk?=
 =?utf-8?B?ZllNcG1lWWo4cHQ2YlNjd0NsZzk1VkJFanpFbVhvOVU5b3BFRXkrdmZNdEIw?=
 =?utf-8?B?RmM5Sm93SEk5Wk1WckRKOEVqY2dmVzRTdmM4WUdiQ1ZENjl0T3hUQTY3ZitE?=
 =?utf-8?B?bFRnY0FIR0o5ZTR1Y0lpSS80OEo4ZnNmZGtrbUdWV1FtZkhlN3hZRXU0QXUx?=
 =?utf-8?B?VkZwdmpscjArV0lEVkppenV6MzFLaC9lNnJQOWJoMEkzSG9zT2JUQkpPUXdk?=
 =?utf-8?B?UlhQeFhvL2tFWExhRzlLSjJyaUdtYzl3U0QxVmxXNWgvWHdDQVhQdHZvcWxu?=
 =?utf-8?B?SFpQV0w4eFNCeTZlZWFtaTFxUkNab2NleEJtcmJidzhYS3AvREpKb28zU3dO?=
 =?utf-8?B?TUxyTGg3SnZ6T3FmNTZvMW90UHkwUGRmUk5xQmQ4L0ZFQ0c3RGFYaXRmTFdW?=
 =?utf-8?B?bEhEWElZM2RUS1l3N2dFeHNBVUZsak1kRStPdG9PQ3A4R1FVOHNuRmcxckNy?=
 =?utf-8?B?NkZieU02RHJ1ejRzYjJlN1hlbW84THZQSFdEOFV0cnkzdm9TZjRsampnSVVK?=
 =?utf-8?B?dWo0dmpmRkdpcGJuUWhEblM5SmRFYVloV1JqM001WXc5UmtjY3lmMmxKby8v?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1532D3F128F4A4887CF6EEE66DC1C97@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d794bd91-432f-4966-f1da-08dc63a45b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 14:47:53.9264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3FnWulOATD/33yjlk2mFA9oRVVAhqGYHO7WwbVZXZYhsmA+re8SeT9p/Z4Hq6p+zIj3tbdDCbq7ERNyKHqz5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8299

T24gRnJpLCAyMDI0LTA0LTE5IGF0IDEzOjQxIC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIE1hY2llaiDFu2VuY3p5a293c2tpIHdyb3RlOg0KPiA+IE9uIEZy
aSwgQXByIDE5LCAyMDI0IGF0IDc6MTfigK9BTSBXaWxsZW0gZGUgQnJ1aWpuDQo+ID4gPHdpbGxl
bWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IExlbmEgV2Fu
ZyAo546L5aicKSB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCAyMDI0LTA0LTE3IGF0IDIxOjE1IC0w
NzAwLCBNYWNpZWogxbtlbmN6eWtvd3NraSB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEV4
dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuDQo+IGF0dGFj
aG1lbnRzIHVudGlsDQo+ID4gPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gPiA+ID4gPiAgT24gV2VkLCBBcHIgMTcsIDIwMjQgYXQgNzo1M+KAr1BN
IExlbmEgV2FuZyAo546L5aicKSA8DQo+ID4gPiA+ID4gTGVuYS5XYW5nQG1lZGlhdGVrLmNvbT4g
d3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gT24gV2VkLCAyMDI0LTA0LTE3IGF0IDE1
OjQ4IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
bg0KPiBhdHRhY2htZW50cw0KPiA+ID4gPiA+IHVudGlsDQo+ID4gPiA+ID4gPiA+IHlvdSBoYXZl
IHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiA+ID4gPiA+ICBMZW5h
IFdhbmcgKOeOi+WonCkgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCAyMDI0LTA0LTE2
IGF0IDE5OjE0IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuDQo+IHdyb3RlOg0KPiA+ID4gPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuDQo+ID4gPiA+ID4gYXR0YWNobWVudHMNCj4gPiA+ID4gPiA+ID4g
dW50aWwNCj4gPiA+ID4gPiA+ID4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ID4gPiA+ID4gPiA+ID4gPiAgPiA+ID4gPiBQZXJzb25hbGx5LCBJIHRo
aW5rIGJwZl9za2JfcHVsbF9kYXRhKCkNCj4gc2hvdWxkIGhhdmUNCj4gPiA+ID4gPiA+ID4gPiA+
IGF1dG9tYXRpY2FsbHkNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKGllLiBpbiBrZXJuZWwg
Y29kZSkgcmVkdWNlZCBob3cgbXVjaCBpdA0KPiBwdWxscyBzbw0KPiA+ID4gPiA+IHRoYXQgaXQN
Cj4gPiA+ID4gPiA+ID4gPiA+IHdvdWxkIHB1bGwNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
aGVhZGVycyBvbmx5LA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IFRoYXQgd291bGQgYmUgYSBoZWxwZXIgdGhhdCBwYXJzZXMgaGVhZGVycyB0bw0KPiBk
aXNjb3Zlcg0KPiA+ID4gPiA+ID4gPiBoZWFkZXINCj4gPiA+ID4gPiA+ID4gPiA+IGxlbmd0aC4N
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IERvZXMgaXQgYWN0
dWFsbHkgbmVlZCB0bz8gIFByZXN1bWFibHkgdGhlIGJwZg0KPiBwdWxsDQo+ID4gPiA+ID4gZnVu
Y3Rpb24NCj4gPiA+ID4gPiA+ID4gY291bGQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBub3RpY2Ug
dGhhdCBpdCBpcw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGEgcGFja2V0IGZsYWdnZWQgYXMgYmVp
bmcgb2YgdHlwZSBYIChVRFAgR1NPDQo+IEZSQUdMSVNUKQ0KPiA+ID4gPiA+IGFuZA0KPiA+ID4g
PiA+ID4gPiByZWR1Y2UNCj4gPiA+ID4gPiA+ID4gPiA+IHRoZSBwdWxsDQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gYWNjb3JkaW5nbHkgc28gdGhhdCBpdCBkb2Vzbid0IHB1bGwgYW55dGhpbmcgZnJv
bQ0KPiB0aGUNCj4gPiA+ID4gPiBub24tDQo+ID4gPiA+ID4gPiA+IGxpbmVhcg0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IGZyYWdsaXN0IHBvcnRpb24/Pz8NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkga25vdyBvbmx5IHRoZSBnZW5lcmljIG92ZXJ2aWV3IG9m
IHdoYXQgdWRwIGdzbw0KPiBpcywgbm90DQo+ID4gPiA+ID4gYW55DQo+ID4gPiA+ID4gPiA+ID4g
PiBkZXRhaWxzLCBzbyBJIGFtDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYXNzdW1pbmcgaGVyZSB0
aGF0IHRoZXJlJ3Mgc29tZSBzb3J0IG9mIGd1YXJhbnRlZQ0KPiB0byBob3cNCj4gPiA+ID4gPiA+
ID4gdGhlc2UNCj4gPiA+ID4gPiA+ID4gPiA+IHBhY2tldHMNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBhcmUgc3RydWN0dXJlZC4uLiAgQnV0IEkgaW1hZ2luZSB0aGVyZSBtdXN0IGJlIG9yDQo+IHdl
DQo+ID4gPiA+ID4gd291bGRuJ3QNCj4gPiA+ID4gPiA+ID4gYmUNCj4gPiA+ID4gPiA+ID4gPiA+
IGhpdHRpbmcgdGhlc2UNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBpc3N1ZXMgZGVlcGVyIGluIHRo
ZSBzdGFjaz8NCj4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gUGVyaGFw
cyBmb3IgYSBwYWNrZXQgb2YgdGhpcyB0eXBlIHdlJ3JlIGFscmVhZHkNCj4gZ3VhcmFudGVlZA0K
PiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gaGVhZGVycw0KPiA+ID4gPiA+ID4gPiA+
ID4gPiBhcmUgaW4gdGhlIGxpbmVhciBwb3J0aW9uLA0KPiA+ID4gPiA+ID4gPiA+ID4gPiBhbmQg
dGhlIHB1bGwgc2hvdWxkIHNpbXBseSBiZSBpZ25vcmVkPw0KPiA+ID4gPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBQYXJzaW5nIGlz
IGJldHRlciBsZWZ0IHRvIHRoZSBCUEYgcHJvZ3JhbS4NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+ID4gPiBJIGRvIHByZWZlciBhZGRpbmcgc2FuaXR5IGNoZWNrcyB0byB0aGUgQlBG
IGhlbHBlcnMsDQo+IG92ZXINCj4gPiA+ID4gPiBoYXZpbmcNCj4gPiA+ID4gPiA+ID4gdG8NCj4g
PiA+ID4gPiA+ID4gPiA+IGFkZCB0aGVuIGluIHRoZSBuZXQgaG90IHBhdGggb25seSB0byBwcm90
ZWN0IGFnYWluc3QNCj4gPiA+ID4gPiBkYW5nZXJvdXMNCj4gPiA+ID4gPiA+ID4gQlBGDQo+ID4g
PiA+ID4gPiA+ID4gPiBwcm9ncmFtcy4NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
ID4gSXMgaXQgT0sgdG8gaWdub3JlIG9yIGRlY3JlYXNlIHB1bGwgbGVuZ3RoIGZvciB1ZHAgZ3Jv
DQo+IGZyYWdsaXN0DQo+ID4gPiA+ID4gPiA+IHBhY2tldD8NCj4gPiA+ID4gPiA+ID4gPiBJdCBj
b3VsZCBzYXZlIHRoZSBub3JtYWwgcGFja2V0IGFuZCBzZW50IHRvIHVzZXINCj4gY29ycmVjdGx5
Lg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gSW4gY29tbW9uL25ldC9jb3JlL2Zp
bHRlci5jDQo+ID4gPiA+ID4gPiA+ID4gc3RhdGljIGlubGluZSBpbnQgX19icGZfdHJ5X21ha2Vf
d3JpdGFibGUoc3RydWN0DQo+IHNrX2J1ZmYgKnNrYiwNCj4gPiA+ID4gPiA+ID4gPiAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGludCB3cml0ZV9sZW4pDQo+ID4gPiA+ID4gPiA+ID4gew0KPiA+ID4g
PiA+ID4gPiA+ICtpZiAoc2tiX2lzX2dzbyhza2IpICYmIChza2Jfc2hpbmZvKHNrYiktPmdzb190
eXBlICYNCj4gPiA+ID4gPiA+ID4gPiArKFNLQl9HU09fVURQICB8U0tCX0dTT19VRFBfTDQpKSB7
DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFRoZSBpc3N1ZSBpcyBub3Qgd2l0aCBTS0Jf
R1NPX1VEUF9MNCwgYnV0IHdpdGgNCj4gU0tCX0dTT19GUkFHTElTVC4NCj4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IEN1cnJlbnQgaW4ga2VybmVsIGp1c3QgVURQIHVzZXMgU0tCX0dTT19GUkFH
TElTVCB0byBkbyBHUk8uDQo+IEluDQo+ID4gPiA+ID4gPiB1ZHBfb2ZmbG9hZC5jIHVkcDRfZ3Jv
X2NvbXBsZXRlIGdzb190eXBlIGFkZHMNCj4gIlNLQl9HU09fRlJBR0xJU1R8DQo+ID4gPiA+ID4g
PiBTS0JfR1NPX1VEUF9MNCIuIEhlcmUgY2hlY2tpbmcgdGhlc2UgdHdvIGZsYWdzIGlzIHRvIGxp
bWl0DQo+IHRoZQ0KPiA+ID4gPiA+IHBhY2tldA0KPiA+ID4gPiA+ID4gYXMgIlVEUCArIG5lZWQg
R1NPICsgZnJhZ2xpc3QiLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFdlIGNvdWxkIHJlbW92
ZSBTS0JfR1NPX1VEUF9MNCBjaGVjayBmb3IgbW9yZSBwYWNrZXQgdGhhdA0KPiBtYXkNCj4gPiA+
ID4gPiBhZGRyaXZlDQo+ID4gPiA+ID4gPiBza2Jfc2VnbWVudF9saXN0Lg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gPiArcmV0dXJuIDA7DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
IEZhaWxpbmcgZm9yIGFueSBwdWxsIGlzIGEgYml0IGV4Y2Vzc2l2ZS4gQW5kIHdvdWxkIGtpbGwg
YQ0KPiBzYW5lDQo+ID4gPiA+ID4gPiA+IHdvcmthcm91bmQgb2YgcHVsbGluZyBvbmx5IGFzIG1h
bnkgYnl0ZXMgYXMgbmVlZGVkLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ICsgICAg
IG9yIGlmICh3cml0ZV9sZW4gPiBza2JfaGVhZGxlbihza2IpKQ0KPiA+ID4gPiA+ID4gPiA+ICt3
cml0ZV9sZW4gPSBza2JfaGVhZGxlbihza2IpOw0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiBUcnVuY2F0aW5nIHJlcXVlc3RzIHdvdWxkIGJlIGEgc3VycHJpc2luZyBjaGFuZ2Ugb2YNCj4g
YmVoYXZpb3INCj4gPiA+ID4gPiA+ID4gZm9yIHRoaXMgZnVuY3Rpb24uDQo+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+IEZhaWxpbmcgZm9yIGEgcHVsbCA+IHNrYl9oZWFkbGVuIGlzIGFyZ3Vh
Ymx5IHJlYXNvbmFibGUsDQo+IGFzDQo+ID4gPiA+ID4gPiA+IHRoZSBhbHRlcm5hdGl2ZSBpcyB0
aGF0IHdlIGxldCBpdCBnbyB0aHJvdWdoIGJ1dCBoYXZlIHRvDQo+IGRyb3ANCj4gPiA+ID4gPiA+
ID4gdGhlIG5vdyBtYWxmb3JtZWQgcGFja2V0cyBvbiBzZWdtZW50YXRpb24uDQo+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJcyBpdCBPSyBhcyBiZWxvdz8NCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBJbiBjb21tb24vbmV0L2NvcmUvZmlsdGVyLmMNCj4gPiA+ID4g
PiA+IHN0YXRpYyBpbmxpbmUgaW50IF9fYnBmX3RyeV9tYWtlX3dyaXRhYmxlKHN0cnVjdCBza19i
dWZmDQo+ICpza2IsDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCB3cml0
ZV9sZW4pDQo+ID4gPiA+ID4gPiB7DQo+ID4gPiA+ID4gPiArICAgICAgIGlmIChza2JfaXNfZ3Nv
KHNrYikgJiYgKHNrYl9zaGluZm8oc2tiKS0+Z3NvX3R5cGUgJg0KPiA+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgIFNLQl9HU09fRlJBR0xJU1QpICYmICh3cml0ZV9sZW4gPg0KPiA+ID4gPiA+IHNr
Yl9oZWFkbGVuKHNrYikpKSB7DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBwbGVhc2UgbGltaXQgd3JpdGVfbGVuIHRvIHNrYl9oZWFk
bGVuKCkgaW5zdGVhZCBvZiBqdXN0DQo+IHJldHVybmluZyAwDQo+ID4gPiA+ID4NCj4gPiA+ID4N
Cj4gPiA+ID4gSGkgTWF6ZSAmIFdpbGxlbSwNCj4gPiA+ID4gTWF6ZSdzIGFkdmljZSBpczoNCj4g
PiA+ID4gSW4gY29tbW9uL25ldC9jb3JlL2ZpbHRlci5jDQo+ID4gPiA+IHN0YXRpYyBpbmxpbmUg
aW50IF9fYnBmX3RyeV9tYWtlX3dyaXRhYmxlKHN0cnVjdCBza19idWZmICpza2IsDQo+ID4gPiA+
ICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHdyaXRlX2xlbikNCj4gPiA+ID4gew0KPiA+ID4g
PiArICAgICAgIGlmIChza2JfaXNfZ3NvKHNrYikgJiYgKHNrYl9zaGluZm8oc2tiKS0+Z3NvX3R5
cGUgJg0KPiA+ID4gPiArICAgICAgICAgICAgICAgU0tCX0dTT19GUkFHTElTVCkgJiYgKHdyaXRl
X2xlbiA+DQo+IHNrYl9oZWFkbGVuKHNrYikpKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICB3
cml0ZV9sZW4gPSBza2JfaGVhZGxlbihza2IpOw0KPiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4g
ICAgICAgICByZXR1cm4gc2tiX2Vuc3VyZV93cml0YWJsZShza2IsIHdyaXRlX2xlbik7DQo+ID4g
PiA+IH0NCj4gPiA+ID4NCj4gPiA+ID4gV2lsbGVtJ3MgYWR2aWNlIGlzIHRvICJGYWlsaW5nIGZv
ciBhIHB1bGwgPiBza2JfaGVhZGxlbiBpcw0KPiBhcmd1YWJseQ0KPiA+ID4gPiByZWFzb25hYmxl
Li4uIi4gSXQgcHJlZmVycyB0byByZXR1cm4gMCA6DQo+ID4gPiA+ICsgICAgICAgaWYgKHNrYl9p
c19nc28oc2tiKSAmJiAoc2tiX3NoaW5mbyhza2IpLT5nc29fdHlwZSAmDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICBTS0JfR1NPX0ZSQUdMSVNUKSAmJiAod3JpdGVfbGVuID4NCj4gc2tiX2hlYWRs
ZW4oc2tiKSkpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiAr
ICAgICAgIH0NCj4gPiA+ID4NCj4gPiA+ID4gSXQgc2VlbXMgYSBiaXQgY29uZmxpY3QuIEhvd2V2
ZXIgSSBhbSBub3Qgc3VyZSBpZiBteQ0KPiB1bmRlcnN0YW5kaW5nIGlzDQo+ID4gPiA+IHJpZ2h0
IGFuZCBob3BlIHRvIGdldCB5b3VyIGZ1cnRoZXIgZ3VpZGUuDQo+ID4gPg0KPiA+ID4gSSBkaWQg
bm90IG1lYW4gdG8gcmV0dXJuIDAuIEJ1dCB0byBmYWlsIGEgcmVxdWVzdCB0aGF0IHdvdWxkIHB1
bGwNCj4gYW4NCj4gPiA+IHVuc2FmZSBhbW91bnQuIFRoZSBjYWxsZXIgbXVzdCBnZXQgYSBjbGVh
ciBlcnJvciBzaWduYWwuDQo+ID4gDQo+ID4gVGhhdCdzIGhvc3RpbGUgb24gdXNlcnNwYWNlLg0K
PiA+IEN1cnJlbnRseSB0aGUgY2FsbGVyIGRvZXNuJ3QgZXZlbiBjaGVjayB0aGUgZXJyb3IgcmV0
dXJuLi4uDQo+IA0KPiBJdCBjYW4sIGFuZCBwcm9iYWJseSBzaG91bGQuDQo+IA0KPiBicGZfc2ti
X3B1bGwgZGF0YSByZXR1cm5zIHRoZSBlcnJvciBjb2RlIGZyb20gYnBmX3RyeV9tYWtlX3dyaXRh
YmxlOg0KPiANCj4gICAgcmV0dXJuIGJwZl90cnlfbWFrZV93cml0YWJsZShza2IsIGxlbiA/IDog
c2tiX2hlYWRsZW4oc2tiKSk7DQo+IA0KPiA+IFdoeSB3b3VsZCB3ZT8gIFdlIGFscmVhZHkgaGF2
ZSB0byByZWxvYWQgYWxsIHBvaW50ZXJzLCBhbmQgaGF2ZSB0bw0KPiBkbw0KPiA+IGFuZCB3aWxs
IHRodXMgcmVkbyBjaGVja2luZyBvbiB0aG9zZS4NCj4gPiANCj4gPiBXaGF0IGRvIHlvdSBleHBl
Y3QgdGhlIGNhbGxlciB0byBkbz8gU3VidHJhY3QgLTEgYW5kIHRyeSBhZ2Fpbj8NCj4gPiBUaGF0
J3MgaGFyZCB0byBkbyBmcm9tIEJQRiBhcyBpdCBpbnZvbHZlcyBsb29waW5nLi4uIGFuZCBpcyBz
bG93Lg0KPiA+IA0KPiA+IFdlIGFscmVhZHkgdHJ5IHRvIG5vdCBwdWxsIHRvbyBtdWNoOg0KPiA+
IA0KPiA+IHZvaWQgdHJ5X21ha2Vfd3JpdGFibGUoc3RydWN0IF9fc2tfYnVmZiogc2tiLCBpbnQg
bGVuKSB7DQo+ID4gICBpZiAobGVuID4gc2tiLT5sZW4pIGxlbiA9IHNrYi0+bGVuOw0KPiA+ICAg
aWYgKHNrYi0+ZGF0YV9lbmQgLSBza2ItPmRhdGEgPCBsZW4pIGJwZl9za2JfcHVsbF9kYXRhKHNr
YiwgbGVuKTsNCj4gPiB9DQo+ID4gDQo+ID4gSXMgdGhlcmUgYXQgbGVhc3Qgc29tZXRoaW5nIGxp
a2Ugc2tiLT5sZW4gdGhhdCBoYXMgdGhlIGFjdHVhbGx5DQo+ID4gcHVsbGFibGUgbGVuZ3RoIGlu
IGl0Pw0KPiANCj4gVGhlIGFib3ZlIHNuaXBwZXQgc2hvd3MgdGhhdCBpdCBwYXNzZXMgc2tiX2hl
YWRsZW4gaWYgdGhlIGNhbGxlcg0KPiBwYXNzZXMgMC4NCj4gDQo+IEJ1dCB5b3VyIEJQRiBwcm9n
cmFtIGRvZXMgbm90IGV2ZW4gbmVlZCB0aGUgZGF0YSB3cml0YWJsZSwgc28gdGhlbg0KPiBpdCBp
cyBvZiBsaXR0bGUgaGVscCBvZiBjb3Vyc2UuDQo+ICANCj4gPiBPciBhcmUgdGhlc2Ugc2tiJ3Mg
c3RydWN0dXJlZCBpbiBzdWNoIGEgd2F5IHRoYXQgdGhlcmUgaXMgbmV2ZXIgYQ0KPiBuZWVkDQo+
ID4gdG8gcHVsbCBhbnl0aGluZywNCj4gPiBiZWNhdXNlIHRoZSBoZWFkZXJzIGFyZSBhbHJlYWR5
IGFsd2F5cyBpbiB0aGUgbGluZWFyIHBvcnRpb24/DQo+IA0KPiBUaGF0IGlzIGluZGVlZCB0aGUg
Y2FzZS4NCj4gDQo+IFNvIGFzIGZhciBhcyBJIGNhbiBzZWU6DQo+IA0KPiBBIEJQRiBwcm9ncmFt
IHRoYXQganVzdCB3YW50cyB0byBwdWxsIHRoZSBuZXR3b3JrIGFuZCB0cmFuc3BvcnQNCj4gaGVh
ZGVycyBjYW4gZGlsaWdlbnRseSBwdWxsIGV4YWN0bHkgd2hhdCBpcyBuZWVkZWQuIEFuZCB3aWxs
IG5vdA0KPiBldmVuIG9ic2VydmUgYW55IGRhdGEgcHVsbGVkIGludG8gbGluZWFyIGluIHByYWN0
aWNlLiBUaGlzIGlzIHN0aWxsDQo+IGFkdmlzYWJsZSByYXRoZXIgdGhhbiB0cnVzdGluZyB0aGF0
IHRoZSBoZWFkZXJzIGFyZSBsaW5lYXIuIEl0IG1heQ0KPiBhbHNvIGJlIHJlcXVpcmVkIGJ5IHRo
ZSB2YWxpZGF0b3I/IERvbid0IGtub3cuIEJ1dCBjaGVjayB0aGUgcmV0dXJuDQo+IHZhbHVlLg0K
PiANCkhpIFdpbGxlbSwNCkFzIHRoZSBkaXNjdXNzaW9uLCBpcyBpdCBPSyBmb3IgdGhlIHBhdGNo
IGJlbG93Pw0KDQpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvZmlsdGVyLmMgYi9uZXQvY29yZS9maWx0
ZXIuYw0KaW5kZXggM2E2MTEwZWE0MDA5Li5hYmM2MDI5YzhlZWYgMTAwNjQ0DQotLS0gYS9uZXQv
Y29yZS9maWx0ZXIuYw0KKysrIGIvbmV0L2NvcmUvZmlsdGVyLmMNCkBAIC0xNjU1LDYgKzE2NTUs
MTEgQEAgc3RhdGljIERFRklORV9QRVJfQ1BVKHN0cnVjdCBicGZfc2NyYXRjaHBhZCwNCmJwZl9z
cCk7DQogc3RhdGljIGlubGluZSBpbnQgX19icGZfdHJ5X21ha2Vfd3JpdGFibGUoc3RydWN0IHNr
X2J1ZmYgKnNrYiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVu
c2lnbmVkIGludCB3cml0ZV9sZW4pDQogew0KKyAgICAgICBpZiAoc2tiX2lzX2dzbyhza2IpICYm
IChza2Jfc2hpbmZvKHNrYiktPmdzb190eXBlICYNCisgICAgICAgICAgICAgICAgICAgICAgIFNL
Ql9HU09fRlJBR0xJU1QpICYmICh3cml0ZV9sZW4gPg0Kc2tiX2hlYWRsZW4oc2tiKSkpIHsNCisg
ICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCisgICAgICAgfQ0KKw0KICAgICAgICByZXR1
cm4gc2tiX2Vuc3VyZV93cml0YWJsZShza2IsIHdyaXRlX2xlbik7DQogfQ0KDQpkaWZmIC0tZ2l0
IGEvbmV0L2NvcmUvc2tidWZmLmMgYi9uZXQvY29yZS9za2J1ZmYuYw0KaW5kZXggNzNiMWUwZTUz
NTM0Li4yZTkwNTM0YzFhMWUgMTAwNjQ0DQotLS0gYS9uZXQvY29yZS9za2J1ZmYuYw0KKysrIGIv
bmV0L2NvcmUvc2tidWZmLmMNCkBAIC00MDM2LDkgKzQwMzYsMTEgQEAgc3RydWN0IHNrX2J1ZmYg
KnNrYl9zZWdtZW50X2xpc3Qoc3RydWN0IHNrX2J1ZmYNCipza2IsDQogICAgICAgIHVuc2lnbmVk
IGludCB0bmxfaGxlbiA9IHNrYl90bmxfaGVhZGVyX2xlbihza2IpOw0KICAgICAgICB1bnNpZ25l
ZCBpbnQgZGVsdGFfdHJ1ZXNpemUgPSAwOw0KICAgICAgICB1bnNpZ25lZCBpbnQgZGVsdGFfbGVu
ID0gMDsNCisgICAgICAgdW5zaWduZWQgaW50IG1zcyA9IHNrYl9zaGluZm8oc2tiKS0+Z3NvX3Np
emU7DQogICAgICAgIHN0cnVjdCBza19idWZmICp0YWlsID0gTlVMTDsNCiAgICAgICAgc3RydWN0
IHNrX2J1ZmYgKm5za2IsICp0bXA7DQogICAgICAgIGludCBsZW5fZGlmZiwgZXJyOw0KKyAgICAg
ICBib29sIGVycl9sZW4gPSBmYWxzZTsNCg0KICAgICAgICBza2JfcHVzaChza2IsIC1za2JfbmV0
d29ya19vZmZzZXQoc2tiKSArIG9mZnNldCk7DQoNCkBAIC00MDQ3LDYgKzQwNDksMTQgQEAgc3Ry
dWN0IHNrX2J1ZmYgKnNrYl9zZWdtZW50X2xpc3Qoc3RydWN0IHNrX2J1ZmYNCipza2IsDQogICAg
ICAgIGlmIChlcnIpDQogICAgICAgICAgICAgICAgZ290byBlcnJfbGluZWFyaXplOw0KDQorICAg
ICAgIGlmIChtc3MgIT0gR1NPX0JZX0ZSQUdTICYmIG1zcyAhPSBza2JfaGVhZGxlbihza2IpKSB7
DQorICAgICAgICAgICAgICAgaWYgKCFsaXN0X3NrYikgew0KKyAgICAgICAgICAgICAgICAgICAg
ICAgZ290byBlcnJfbGluZWFyaXplOw0KKyAgICAgICAgICAgICAgIH0gZWxzZSB7DQorICAgICAg
ICAgICAgICAgICAgICAgICBlcnJfbGVuID0gdHJ1ZTsNCisgICAgICAgICAgICAgICB9DQorICAg
ICAgIH0NCisNCiAgICAgICAgc2tiX3NoaW5mbyhza2IpLT5mcmFnX2xpc3QgPSBOVUxMOw0KDQog
ICAgICAgIHdoaWxlIChsaXN0X3NrYikgew0KQEAgLTQxMDksNiArNDExOSw5IEBAIHN0cnVjdCBz
a19idWZmICpza2Jfc2VnbWVudF9saXN0KHN0cnVjdCBza19idWZmDQoqc2tiLA0KICAgICAgICAg
ICAgX19za2JfbGluZWFyaXplKHNrYikpDQogICAgICAgICAgICAgICAgZ290byBlcnJfbGluZWFy
aXplOw0KDQorICAgICAgIGlmIChlcnJfbGVuKQ0KKyAgICAgICAgICAgICAgIGdvdG8gZXJyX2xp
bmVhcml6ZTsNCisNCiAgICAgICAgc2tiX2dldChza2IpOw0KDQogICAgICAgIHJldHVybiBza2I7
DQoNCj4gPiANCj4gPiA+IEJhY2sgdG8gdGhlIG9yaWdpbmFsIHJlcG9ydDogdGhlIGlzc3VlIHNo
b3VsZCBhbHJlYWR5IGhhdmUgYmVlbg0KPiBmaXhlZA0KPiA+ID4gYnkgY29tbWl0IDg3NmU4Y2E4
MzY2NyAoIm5ldDogZml4IE5VTEwgcG9pbnRlciBpbg0KPiBza2Jfc2VnbWVudF9saXN0IikuDQo+
ID4gPiBCdXQgdGhhdCBjb21taXQgaXMgaW4gdGhlIGtlcm5lbCBmb3Igd2hpY2ggeW91IHJlcG9y
dCB0aGUgZXJyb3IuDQo+ID4gPg0KPiA+ID4gVHVybnMgb3V0IHRoYXQgdGhlIGNyYXNoIGlzIG5v
dCBpbiBza2Jfc2VnbWVudF9saXN0LCBidXQgbGF0ZXIgaW4NCj4gPiA+IF9fdWRwdjRfZ3NvX3Nl
Z21lbnRfbGlzdF9jc3VtLiBXaGljaCB1bmNvbmRpdGlvbmFsbHkgZGVyZWZlcmVuY2VzDQo+ID4g
PiB1ZHBfaGRyKHNlZykuDQo+ID4gPg0KPiA+ID4gVGhlIGFib3ZlIGZpeCBhbHNvIG1lbnRpb25z
IHNrYiBwdWxsIGFzIHRoZSBjdWxwcml0LCBidXQgZG9lcyBub3QNCj4gPiA+IGluY2x1ZGUgYSBC
UEYgcHJvZ3JhbS4gSWYgdGhpcyBjYW4gYmUgcmVhY2hlZCBpbiBvdGhlciB3YXlzLCB0aGVuDQo+
IHdlDQo+ID4gPiBkbyBuZWVkIGEgc3Ryb25nZXIgdGVzdCBpbiBza2Jfc2VnbWVudF9saXN0LCBh
cyB5b3UgcHJvcG9zZS4NCj4gPiA+DQo+ID4gPiBJIGRvbid0IHdhbnQgdG8gbmFycm93bHkgY2hl
Y2sgd2hldGhlciB1ZHBfaGRyIGlzIHNhZmUuDQo+IEVzc2VudGlhbGx5LA0KPiA+ID4gYW4gU0tC
X0dTT19GUkFHTElTVCBza2IgbGF5b3V0IGNhbm5vdCBiZSB0cnVzdGVkIGF0IGFsbCBpZiBldmVu
DQo+IG9uZQ0KPiA+ID4gYnl0ZSB3b3VsZCBnZXQgcHVsbGVkLg0KPiA+IA0KPiA+IC0tDQo+ID4g
TWFjaWVqIMW7ZW5jenlrb3dza2ksIEtlcm5lbCBOZXR3b3JraW5nIERldmVsb3BlciBAIEdvb2ds
ZQ0KPiANCj4gDQo=

