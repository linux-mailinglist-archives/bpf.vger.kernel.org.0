Return-Path: <bpf+bounces-27024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6388A7CF4
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 09:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504A31C20365
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 07:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BD26A8BE;
	Wed, 17 Apr 2024 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kUvcruNy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="eA3D2ff+"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E540850;
	Wed, 17 Apr 2024 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338406; cv=fail; b=FXEio5pIc+nKWDZu7gj7Pkmp6mIa3bv2Q69ZaFgPK6nARqimeIhRWEC3FppGJDvSuhzYhyg/M6GDyiPXn0H2l/9sbcj8rnem2dG7szKU7PHCSGK81eLSNTePYJeH+KxYuB4GmbNEyUg/bi5IJohjVQH0G2K4RbrCq9SdugCOqxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338406; c=relaxed/simple;
	bh=x5dwxgzNVeY9tdzP9dvhRu3eMxbj+wSoH50mO//uchE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B1/DaOrOs0+B85eggB2pIjl/t0jnRnjZGx31M2FkvJqdEJd9UI30YiUgA3N9C7IOZcBry60RXvPcmpbqML7QsS4SOLi/Lh85+oKbajOxUApIp5PvfSkoq+X9g9fAZHlHNsJPgojuJDBZJcGxCcfkhO8+gSpcEZdbKeFjinFsz7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kUvcruNy; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eA3D2ff+; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e596fe12fc8a11ee935d6952f98a51a9-20240417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=x5dwxgzNVeY9tdzP9dvhRu3eMxbj+wSoH50mO//uchE=;
	b=kUvcruNyfYO7KYYDn4IenWPPiz4DTc6XYQKspT0uUWmI1s9nkOv+Ztxm8j2lyeWt36VoCcS5fXAFEEUuH34xwBh9N10hKTUtMHG6Fklp+m8hQTgG9HGJXT7wdP8WdrbhI2vSNx1v7W7fofadGmjFsTUfJ7CqoWdHqCh4zfBADSU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:93f59cb0-465d-493b-baf5-d38ad79e3cc6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:38384786-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: e596fe12fc8a11ee935d6952f98a51a9-20240417
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1312547943; Wed, 17 Apr 2024 15:19:58 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Apr 2024 15:19:57 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Apr 2024 15:19:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEZtT+xBu/JH5k5jhnAIe0vm71uTRIe1/Jr6a3qWwz+Nm3xJ3jwnnr1EwFlbcy8NbKtKnu9ieSM+xF3sz/c3fJtFPHbkcasDsN31Cp/v1bniPzOZPCipqNvPNkTrtzsyYw4Ni4/oJOO6tFBEe4ETQD9IHPfd7bMSmF8SoUjn7bwpMRUBre+BGiBq56Gd7AXDhykC3SV5uKOeJECGHQXuGPOOR5i+SsGPGvza68ovNeC6T/eOKj80fgEg99F8cCqp96/fAm73QlcE9BbYxkT/D7LXNKPU9BcsLTPm5NYmcvfpu0F19t8HrlKUvinGFuCouv/lD0A0vr5tVMH8j/cLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5dwxgzNVeY9tdzP9dvhRu3eMxbj+wSoH50mO//uchE=;
 b=V6jS/7/V6sddEew5f/e9d4wRpXgXs++A7L/5yBC35D7RkTzO0vNWXzqA7tboM5jD1VjEvfO+kbo5Ll+RRL+nfKoHnkH1Ww0e0WO3WN/5U3nRsjhIhEC5CjAp668fa4AxjL8gMnTGA3SnqWEV7JxzNaiGUnbtaZt4rebDnISvI80RR+2QJWcMZSFNx8RoS0vdMPHxWyr9PNTo24I1xgOb3a+cwQCCsZhfPD6qcesoMta2rIiuuTgQ+ciupQjU08CHfiLLQxwqIyGr8ufze3sHHPh93HRv84ahQ8xEuOfpja5dJWH9T1lvzkXMtaVT3T0pZQ/4v/qC3fEfVQ0gflTQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5dwxgzNVeY9tdzP9dvhRu3eMxbj+wSoH50mO//uchE=;
 b=eA3D2ff+XWqYbJT84uZzsfbkO0dwI2BkMLvo/pXsQyhNUgvjFdEC5ePHRxx6MhaGAJwwyf0aSRiHOxaVR0pjvdZUrzvSCvVHiFAv2KY3766l1MPJ4WO2rOjfICV0esyBNA0qRLPRb2DiNIp9nLXqsu86LGhLWoaddtETIE5nZdk=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by SEZPR03MB6593.apcprd03.prod.outlook.com (2603:1096:101:75::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 07:19:53 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7%6]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 07:19:52 +0000
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
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Thread-Topic: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Thread-Index: AQHaj0XOIxnbbRpuOEqwUbC2K0Us3rFpz0sAgABZ6oCAAArbAIAA8PYAgAAJ3wCAAAGxgIAAWJUAgACHpIA=
Date: Wed, 17 Apr 2024 07:19:52 +0000
Message-ID: <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
	 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
	 <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
	 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
	 <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch>
	 <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
	 <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
	 <661f066060ab4_7a39f2945d@willemb.c.googlers.com.notmuch>
In-Reply-To: <661f066060ab4_7a39f2945d@willemb.c.googlers.com.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|SEZPR03MB6593:EE_
x-ms-office365-filtering-correlation-id: 0240a797-d15f-4b7b-d35d-08dc5eaec675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?QkFrUmg4N2tYcDVBbmlqbmxqajRHTE16OG9FUXRDb2hCbDhpeGlpbXRNaGda?=
 =?utf-8?B?YVl0WmFGSk5DYVFya2hYRDdadk5KUHQ4SXY4UUxmVk5xNU85L0ZndFAyM2NL?=
 =?utf-8?B?OEkvMW1JaFNNQ3E4cTAzQmVCMTJmdmVMcituYzBvVE44d2VBc21uckUxSlRx?=
 =?utf-8?B?dWJxOENzc3lTWEF0VFhnL3FlQ1NsWU8wcTViTTk5bVYwZy96VzV5VzFTVEoy?=
 =?utf-8?B?NHBQTVQ5UnlQVVhyMmc5QmVONGdNZVZmQlRKNjBwSGpiMUR5Q0tkdUxWS0NY?=
 =?utf-8?B?dEZ1ZWtPaVB6dFFieDNmRWhyZVZEOGh2ODAvbTk0ZXRvUzBZREttNGRGZXdQ?=
 =?utf-8?B?VEtOQkpYUlF6TEppZ3pvMSs3RWJZQWZrOHB0MDBnemZaM2lYYmJpTkZ2MnBl?=
 =?utf-8?B?cUpuTENrTzVuemY0NksrZ3pNaWdUV2VUUTA3aVdrOEozdFlMSG5UdXQvVUQy?=
 =?utf-8?B?QXRWcE9oeWJmSEp0dzBCQW93Y1Y1Sk8xc3pWYUpzZSt4aXRSYXZWbElEcHNu?=
 =?utf-8?B?VUcybzl1eS9rVmFnY3hHNnh5eHdpTWFmdWFTMDJmZVdBT3VCSVRDZmx2RTBw?=
 =?utf-8?B?Sk9wR21NdTJSSTBIdlZ2Sjl2QXRtL2ZIQXhxYTRFQzF4Yy9XNGVPRlpWNjdB?=
 =?utf-8?B?TkdhSVgvclpDbjNNME5ZUWVGYVd2UkdhTE1tVUF2VEJqVmpTdkZEUUk3Z05N?=
 =?utf-8?B?d2NXR0ladm5EN24zdHVQakJ1d0VsYnF4Y1lmUnBZdXhtOGp5MjNvY2NUQzNZ?=
 =?utf-8?B?VzRBSkoxbVJkVGNUdSszaXcxc29vVWtHd01jaWJVdmdYM2sveXdiU0orV3pY?=
 =?utf-8?B?WXNxZ3FHYU9acDkwT254Sm82TEw4VlgzZmJTdElsY2hHNUp0SDZlbzRtYW02?=
 =?utf-8?B?UUF4aDF4eENEeTRRNW9CY25mVzIxYmtZTXdQU01wMEdZc1Y1ZjRXY1JsRzBJ?=
 =?utf-8?B?amZvMTFmZ0pPOEl6MkRWeWg5Q093SzU1d1BaOW9ORjlKQW9pTzZTbktBbHVY?=
 =?utf-8?B?bHhGQjhOK1VMazdVUHEwVFk0WDg5ekszUzJjd3RraFFOZDRoN1lWL0ErWW9w?=
 =?utf-8?B?ZUt4bHBIRjhMcFQ5QzNxTEZzQlN6OG9MeGRoaytvRDVkODJMVk02Vy93Z0Mr?=
 =?utf-8?B?a2hxTnphUEhzSkpjK0h1OFNiTEhnUGJHM1BXV2xUOVJ4VHdyUkpLWlpZMFBH?=
 =?utf-8?B?cStWLzlpcDQ2RUVhblBOc1hMbXFBMWI3dEhVRUtJY0dkRDB5clFoVkRnV1ho?=
 =?utf-8?B?ZGtXdnNaWlZCNG5wVTJkOWxsUng0RzhNMmlMV3BOaEVPTEhkaEhpU0tvb2Y4?=
 =?utf-8?B?R0xjaHRTUlVDZDZPbENYNzVjTmpNbndhd2FKNWx2VXdveDI5RUljWVJIdnlh?=
 =?utf-8?B?anRuOHVlUVdXeTEveVlLTUd2dUtvaitVKzB4RmFQWmdodXdBMXZxeEZlVmFU?=
 =?utf-8?B?R0pJY0JxRHVaZnlSTEhPSWYvSk5Xb3pxaEduMzVFZnlSMEdXZWhFYjBQM2k0?=
 =?utf-8?B?M0svcFV5MVFaSVQ5R0ZjeTh6dDNFQjlaUUhOdWpNZy9BemphaVh0OFkzSnZY?=
 =?utf-8?B?b1A4NFpMU3VZdHBSRjBKa3ppYjA1THNMT25ybHFrS0s5NytJVjIrS1N6L2xR?=
 =?utf-8?B?Q1RZQ1haUnpIKzg1c3lHRk8rbHZEOXBydk1xM0VRRnVkWTBiSmVLMzJtM3Ur?=
 =?utf-8?B?TXp2WHJyYzJ0cTAzUnQwMGE4Tnp0ZS9TU0t1V1J0bjRWZ0FseU9pOHdFVDg0?=
 =?utf-8?B?UklibnZRalBRZS9nYUZieHh2S2ZaMVRYdU40WFdobnp0eTFtVzN5Smk2M2FN?=
 =?utf-8?B?U3g4TU93eGJZSHZqWE44QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWUrd1dqcDJkVkV4ak50MGNNbEpRclVodTFZSFlnQS9zWllGaUd6UDZ2bmw0?=
 =?utf-8?B?UHpjSHc4Um9mNkJHWGxIalA4d1pxRWMrL1BEenJOeEprQnNNei9SSUxXWGxM?=
 =?utf-8?B?OUcvcytSY1RQZVlNQkYrN2w3aVYzZldMamczZVJXYzRMODNkWTNvMGxPY1dY?=
 =?utf-8?B?UmtDb3lvTTVUOGxaSGdjTHdJRUVqYUxnTlNRUmNIbXVEZUNWOGgwcy9nYTI5?=
 =?utf-8?B?YnNoTGtBczM0RXFXM2U3akkwdmFLV3BpRE1ON21WUFlwdVR0ekxpdGQ4KzF0?=
 =?utf-8?B?QS9VSXY1SEgzVEI2S05ZbXRUUGdlYmU1TEt0VUdZMmM0MkdqQ2pnYk0wemtD?=
 =?utf-8?B?UDZGQkRPWER4SEhSeGcyeGpmYjA0WmFBNVVWSWxxV3Y2T3FKZEo3cW5kNHpk?=
 =?utf-8?B?dkZRZU00UDFRckZJd1ZOdEY4YTZzekxMeXQvb3BXdUp5Mk5ZRXl0YmUvbGxH?=
 =?utf-8?B?ZWVGSTQyaXM5YzRYS3R5Y3o1YWNMamc3OUlVZXlQYkJVcjV2YmZ1dXhWNmor?=
 =?utf-8?B?VGJqd0g2UHBLbDNub0JjZ0E5MFJGZ0tFZVJaUWZxcnR0Uk9iY2t0cHVsanBr?=
 =?utf-8?B?aTFvUTMzOUtHQTZEQkFHMVdFUktwTE80Vmt2S2dxL3k5SnA2UVdYdkNqYlp1?=
 =?utf-8?B?b2pwL0ZrRkxPTGVBRTNZOVpLR3JQbStSSWVrV3FURy8xdTNZR091a2FvdUlo?=
 =?utf-8?B?Tjd3QSt4SW5mM0ZOL3g4Zmh3V1BvdG80bFl2b3NGUjNIcit0VlNHRzF3WXdH?=
 =?utf-8?B?bW8wbmwxc0pzZ2s0K2dzZU1ONVpkRDhFZWZnRGV3Sm9uTytackdkYm9ZTldn?=
 =?utf-8?B?SlZqa0NOLytxOHJxN25zTFBLMTVocGlIQ1BTTWxuT1lJNzJOQUpiOGtqd0xk?=
 =?utf-8?B?djByMm1IOElWQWdWaUM5bTc4MGI2NTA0a2svVytzY1VhNFZoZnIyQjA0MS96?=
 =?utf-8?B?ZFA5Wk5rblBEVitGZDdNVVRMdEJsc2UvNmtaK1JLci9QUjkvMk9oMDFDZ2Qy?=
 =?utf-8?B?WmdFZGxpWGF5b2Z0UktONEFZSFFoVmRqRk5DWERhU21odkxQbThFaG1hSUkw?=
 =?utf-8?B?eCsxaG9pMzdQUkh0MWJ5dDJ2NmplRFZ2dkdWUjBiTFhrZzR2cXZKUzdlRHI3?=
 =?utf-8?B?SWo0NnJwaXp3enlmK3NsKzIxQThJK0FDOGwzVHFEYm5QTVlud1RWYnlmbDh1?=
 =?utf-8?B?clU1azR3WFFBaXlZQXdsOGZLZ0RpUWk0QUFuYzhJdjhvdmFRaXhMMi9wd1Ni?=
 =?utf-8?B?amY0aFFxb3hOYm01aHFNN1VuUjFtVmx3OWFjZGltQUpWeDRpUE1mWis3N0hK?=
 =?utf-8?B?S2pzcCttU2ZSajJrMFk1YlRKMzZLWDdITWMzbGxlWVQwdisxUm85MlprV3Z3?=
 =?utf-8?B?aXVuWWk0ME1qS2RMWkRhQWx6bCt6N1V5TFpCbHdmbEd0Q2FNN00xTlZtSG9N?=
 =?utf-8?B?d2l4bHdOTmlsbGNCMG5ibGVPcjhEMjhqWm4yZ09hUnFmZkFRTWRLRXNnNlBL?=
 =?utf-8?B?WmloSDVhWE1QN2Y5V3ZEUXBxN1NDQytBMUIvTnRCRTM3K0V5N1d1UTNzTHJW?=
 =?utf-8?B?bUI5S3dyYUF5c0x2UVFPYUhDSE5yb1VzQXlrQkI4bFhNWC9TU0lsZmgwRyt3?=
 =?utf-8?B?Vm1Wc0psQlh6Nm9EYm5sR3d1ekZBcVJNSkJtU1RrcHBBc1RBSU45VG1lbWpC?=
 =?utf-8?B?YkN1bjUzYUhMdVVGUEZBem1PV2J5d01rdHMxcDBaWjU5K2tDbitGVkhlVWg1?=
 =?utf-8?B?ODExbllRVEk0MTdsWVhPVFpieTR0ZkdVMitMeTR4RDhjMUVheGNRbTA0dUtW?=
 =?utf-8?B?ZmVuZDlyM2VJNXM1SzgvNGhIYmEwdlQwSmRrbjY5WWVZMXBSZ3lPK3NVNHZ2?=
 =?utf-8?B?ditWS3RMZzQxcmdxNk1aU1owRnhOdzdlVE9aNGRCTmlsbVY2bk0rSnNDU2Za?=
 =?utf-8?B?VEJHaWw1QzBwNVF0aG9JVjVqRmJWdEY1TWxWNlRtVitpWUJPb0R3VGtFd255?=
 =?utf-8?B?M2d6SzFUWFdKaWdDOFpzMC9wTm9aSzFQQUlXMnMxU2FlMEdwcnJ0amVFYjI0?=
 =?utf-8?B?YVdqUFdtRTd6WUtBSGZuZllTdzYrNGVNbzRZRGNZbW42NmJKTjRMVDFjWi9M?=
 =?utf-8?B?aEZETFpXZ0lxeXpSd2tKazJicEJGL1luZlNWYVdlU0tMUGZlUVdobWpuMzFQ?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCED7AF798D50B4CB8079F721A18A43A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0240a797-d15f-4b7b-d35d-08dc5eaec675
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 07:19:52.6365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AkvC001Ik1Rzy1gygIqqgOqUSm7DVN7i1AlvCCfptsQ/zJ3uNzya9x8Ju4XoMruJWBhRfRd2tlyeCGuQ+k22XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6593
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--38.161400-8.000000
X-TMASE-MatchedRID: oll/cJ/dUC4OwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0qTnaHZlUXDwbUReAJKY7+FmlaAItiONP0oUVkB7ifJnslgi/vLS272Cx5
	3vGB6GzSUvT09fsi7Foq9eBAnO/kIE6V/2dtg4KaVSBCoZUyqbNMNeBxSUI2jBwaftSlNt0H5pP
	85qu4YUe9F5QmIvVCnMTJV8WHPInC7JfBr9Xl5CjPDkSOzeDWWTJDl9FKHbrkxiSY0g7v6FtISY
	zBUt2RalGZHwSvXb0sXJ4haGfPhxzZfE5oMQs9Ix7fVVD7rJEYhHWssEmb8zlwpnAAvAwazPm4X
	xTeJls9ndCUvzOytwEI5FCc85WEfNKAolv8loSyLzZSKyQypzJCgGv5IWd4kCqIJhrrDy29RWYI
	8YuMtSkDst89QIXsr363fb6EBgcn1xX9eJNrFWfv+//lqU1h6QQoq/f63NfsNht78/JfyBODDOX
	/LKm2mAGjUK0D2mjBDDDL9x3SmGAl2fBUMKi6YF6z9HGHKwNuANGXBz7BHp3YB8PMAOxC82eiq5
	HAdjcFpFYZVoIlzc5XX+I+PsjLToRIL3xWcnX5sIyeExXlNbgXXmzqmsIi7lQ9XSACU14reTUcy
	dIM+R0eecoNEFPrpkhY7J/3t/UkPv5/+N9RjEnGBmLio+mJg0nXvwjW2mSWp5SELNf25Esoq2HB
	wZupz4vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbslCGssfkpInQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--38.161400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	25DC0DB0386A6C6ACF02773CBE9AB4AF3933968E337E0C4FC629D27E1033D2932000:8

T24gVHVlLCAyMDI0LTA0LTE2IGF0IDE5OjE0IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gID4gPiA+ID4gUGVyc29uYWxseSwgSSB0aGluayBicGZfc2tiX3B1
bGxfZGF0YSgpIHNob3VsZCBoYXZlDQo+IGF1dG9tYXRpY2FsbHkNCj4gPiA+ID4gPiAoaWUuIGlu
IGtlcm5lbCBjb2RlKSByZWR1Y2VkIGhvdyBtdWNoIGl0IHB1bGxzIHNvIHRoYXQgaXQNCj4gd291
bGQgcHVsbA0KPiA+ID4gPiA+IGhlYWRlcnMgb25seSwNCj4gPiA+ID4NCj4gPiA+ID4gVGhhdCB3
b3VsZCBiZSBhIGhlbHBlciB0aGF0IHBhcnNlcyBoZWFkZXJzIHRvIGRpc2NvdmVyIGhlYWRlcg0K
PiBsZW5ndGguDQo+ID4gPg0KPiA+ID4gRG9lcyBpdCBhY3R1YWxseSBuZWVkIHRvPyAgUHJlc3Vt
YWJseSB0aGUgYnBmIHB1bGwgZnVuY3Rpb24gY291bGQNCj4gPiA+IG5vdGljZSB0aGF0IGl0IGlz
DQo+ID4gPiBhIHBhY2tldCBmbGFnZ2VkIGFzIGJlaW5nIG9mIHR5cGUgWCAoVURQIEdTTyBGUkFH
TElTVCkgYW5kIHJlZHVjZQ0KPiB0aGUgcHVsbA0KPiA+ID4gYWNjb3JkaW5nbHkgc28gdGhhdCBp
dCBkb2Vzbid0IHB1bGwgYW55dGhpbmcgZnJvbSB0aGUgbm9uLWxpbmVhcg0KPiA+ID4gZnJhZ2xp
c3QgcG9ydGlvbj8/Pw0KPiA+ID4NCj4gPiA+IEkga25vdyBvbmx5IHRoZSBnZW5lcmljIG92ZXJ2
aWV3IG9mIHdoYXQgdWRwIGdzbyBpcywgbm90IGFueQ0KPiBkZXRhaWxzLCBzbyBJIGFtDQo+ID4g
PiBhc3N1bWluZyBoZXJlIHRoYXQgdGhlcmUncyBzb21lIHNvcnQgb2YgZ3VhcmFudGVlIHRvIGhv
dyB0aGVzZQ0KPiBwYWNrZXRzDQo+ID4gPiBhcmUgc3RydWN0dXJlZC4uLiAgQnV0IEkgaW1hZ2lu
ZSB0aGVyZSBtdXN0IGJlIG9yIHdlIHdvdWxkbid0IGJlDQo+IGhpdHRpbmcgdGhlc2UNCj4gPiA+
IGlzc3VlcyBkZWVwZXIgaW4gdGhlIHN0YWNrPw0KPiA+IA0KPiA+IFBlcmhhcHMgZm9yIGEgcGFj
a2V0IG9mIHRoaXMgdHlwZSB3ZSdyZSBhbHJlYWR5IGd1YXJhbnRlZWQgdGhlDQo+IGhlYWRlcnMN
Cj4gPiBhcmUgaW4gdGhlIGxpbmVhciBwb3J0aW9uLA0KPiA+IGFuZCB0aGUgcHVsbCBzaG91bGQg
c2ltcGx5IGJlIGlnbm9yZWQ/DQo+ID4gDQo+ID4gPg0KPiA+ID4gPiBQYXJzaW5nIGlzIGJldHRl
ciBsZWZ0IHRvIHRoZSBCUEYgcHJvZ3JhbS4NCj4gDQo+IEkgZG8gcHJlZmVyIGFkZGluZyBzYW5p
dHkgY2hlY2tzIHRvIHRoZSBCUEYgaGVscGVycywgb3ZlciBoYXZpbmcgdG8NCj4gYWRkIHRoZW4g
aW4gdGhlIG5ldCBob3QgcGF0aCBvbmx5IHRvIHByb3RlY3QgYWdhaW5zdCBkYW5nZXJvdXMgQlBG
DQo+IHByb2dyYW1zLg0KPiANCklzIGl0IE9LIHRvIGlnbm9yZSBvciBkZWNyZWFzZSBwdWxsIGxl
bmd0aCBmb3IgdWRwIGdybyBmcmFnbGlzdCBwYWNrZXQ/DQpJdCBjb3VsZCBzYXZlIHRoZSBub3Jt
YWwgcGFja2V0IGFuZCBzZW50IHRvIHVzZXIgY29ycmVjdGx5Lg0KDQpJbiBjb21tb24vbmV0L2Nv
cmUvZmlsdGVyLmMNCnN0YXRpYyBpbmxpbmUgaW50IF9fYnBmX3RyeV9tYWtlX3dyaXRhYmxlKHN0
cnVjdCBza19idWZmICpza2IsDQogICAgICAgICAgICAgIHVuc2lnbmVkIGludCB3cml0ZV9sZW4p
DQp7IA0KKwlpZiAoc2tiX2lzX2dzbyhza2IpICYmIChza2Jfc2hpbmZvKHNrYiktPmdzb190eXBl
ICYNCisJCShTS0JfR1NPX1VEUCAgfFNLQl9HU09fVURQX0w0KSkgew0KKwkJcmV0dXJuIDA7DQoN
CisJICAgICBvciBpZiAod3JpdGVfbGVuID4gc2tiX2hlYWRsZW4oc2tiKSkNCisJCQl3cml0ZV9s
ZW4gPSBza2JfaGVhZGxlbihza2IpOw0KKwl9DQoJcmV0dXJuIHNrYl9lbnN1cmVfd3JpdGFibGUo
c2tiLCB3cml0ZV9sZW4pOw0KfQ0KIA0KDQo+IEluIHRoaXMgY2FzZSwgaXQgd291bGQgYmUgZGV0
ZWN0aW5nIHRoaXMgR1NPIHR5cGUgYW5kIGZhaWxpbmcgdGhlDQo+IG9wZXJhdGlvbiBpZiBleGNl
ZWRpbmcgc2tiX2hlYWRsZW4oKS4NCj4gPiA+ID4NCj4gPiA+ID4gPiBhbmQgbm90IHBhY2tldCBj
b250ZW50Lg0KPiA+ID4gPiA+IChUaGlzIGlzIGFzc3VtaW5nIHRoZSByZXN0IG9mIHRoZSBjb2Rl
IGlzbid0IHJlYWR5IHRvIGRlYWwNCj4gd2l0aCBhIGxvbmdlciBwdWxsLA0KPiA+ID4gPiA+IHdo
aWNoIEkgdGhpbmsgaXMgdGhlIGNhc2UgYXRtLiAgUHVsbGluZyB0b28gbXVjaCwgYW5kIHRoZW4N
Cj4gY3Jhc2hpbmcgb3IgZm9yY2luZw0KPiA+ID4gPiA+IHRoZSBzdGFjayB0byBkcm9wIHBhY2tl
dHMgYmVjYXVzZSBvZiB0aGVtIGJlaW5nIG1hbGZvcm1lZA0KPiBzZWVtcyB3cm9uZy4uLikNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IEluIGdlbmVyYWwgaXQgd291bGQgYmUgbmljZSBpZiB0aGVyZSB3
YXMgYSB3YXkgdG8ganVzdCBzYXkNCj4gcHVsbCBhbGwgaGVhZGVycy4uLg0KPiA+ID4gPiA+IChv
ciBwb3NzaWJseSBhbGwgTDIvTDMvTDQgaGVhZGVycykNCj4gPiA+ID4gPiBZb3UgaW4gZ2VuZXJh
bCBuZWVkIHRvIHB1bGwgc3R1ZmYgKmJlZm9yZSogeW91J3ZlIGV2ZW4gbG9va2VkDQo+IGF0IHRo
ZSBwYWNrZXQsDQo+ID4gPiA+ID4gc28gdGhhdCB5b3UgY2FuIGxvb2sgYXQgdGhlIHBhY2tldCwN
Cj4gPiA+ID4gPiBzbyBpdCdzIHJlbGF0aXZlbHkgaGFyZC9hbm5veWluZyB0byBwdWxsIHRoZSBj
b3JyZWN0IGxlbmd0aA0KPiBmcm9tIGJwZg0KPiA+ID4gPiA+IGNvZGUgaXRzZWxmLg0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+ID4gQlBGIG5lZWRzIHRvIG1vZGlmeSBhIHByb3BlciBsZW5ndGgg
dG8gZG8gcHVsbCBkYXRhLg0KPiBIb3dldmVyIGtlcm5lbA0KPiA+ID4gPiA+ID4gPiA+IHNob3Vs
ZCBhbHNvIGltcHJvdmUgdGhlIGZsb3cgdG8gYXZvaWQgY3Jhc2ggZnJvbSBhIGJwZg0KPiBmdW5j
dGlvbg0KPiA+ID4gPiA+ID4gPiBjYWxsLg0KPiA+ID4gPiA+ID4gPiA+IEFzIHRoZXJlIGlzIG5v
IHNwbGl0IGZsb3cgYW5kIGFwcCBtYXkgbm90IGRlY29kZSB0aGUNCj4gbWVyZ2VkIFVEUA0KPiA+
ID4gPiA+ID4gPiBwYWNrZXQsDQo+ID4gPiA+ID4gPiA+ID4gd2Ugc2hvdWxkIGRyb3AgdGhlIHBh
Y2tldCB3aXRob3V0IGZyYWdsaXN0IGluDQo+IHNrYl9zZWdtZW50X2xpc3QNCj4gPiA+ID4gPiA+
ID4gaGVyZS4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEZpeGVzOiAzYTEyOTZh
MzhkMGMgKCJuZXQ6IFN1cHBvcnQgR1JPL0dTTyBmcmFnbGlzdA0KPiBjaGFpbmluZy4iKQ0KPiA+
ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNoaW1pbmcgQ2hlbmcgPA0KPiBzaGltaW5nLmNo
ZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMZW5hIFdh
bmcgPGxlbmEud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+
ID4gPiA+ID4gIG5ldC9jb3JlL3NrYnVmZi5jIHwgMyArKysNCj4gPiA+ID4gPiA+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+ID4gZGlmZiAtLWdpdCBhL25ldC9jb3JlL3NrYnVmZi5jIGIvbmV0L2NvcmUvc2tidWZmLmMN
Cj4gPiA+ID4gPiA+ID4gPiBpbmRleCBiOTkxMjc3MTJlNjcuLmY2OGYyNjc5YjA4NiAxMDA2NDQN
Cj4gPiA+ID4gPiA+ID4gPiAtLS0gYS9uZXQvY29yZS9za2J1ZmYuYw0KPiA+ID4gPiA+ID4gPiA+
ICsrKyBiL25ldC9jb3JlL3NrYnVmZi5jDQo+ID4gPiA+ID4gPiA+ID4gQEAgLTQ1MDQsNiArNDUw
NCw5IEBAIHN0cnVjdCBza19idWZmDQo+ICpza2Jfc2VnbWVudF9saXN0KHN0cnVjdA0KPiA+ID4g
PiA+ID4gPiBza19idWZmICpza2IsDQo+ID4gPiA+ID4gPiA+ID4gIGlmIChlcnIpDQo+ID4gPiA+
ID4gPiA+ID4gIGdvdG8gZXJyX2xpbmVhcml6ZTsNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiA+ICtpZiAoIWxpc3Rfc2tiKQ0KPiA+ID4gPiA+ID4gPiA+ICtnb3RvIGVycl9saW5lYXJp
emU7DQo+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHdvdWxkIGNhdGNo
IHRoZSBjYXNlIHdoZXJlIHRoZSBlbnRpcmUgZGF0YSBmcmFnX2xpc3QgaXMNCj4gPiA+ID4gbGlu
ZWFyaXplZCwgYnV0IG5vdCBhIHBza2JfbWF5X3B1bGwgdGhhdCBvbmx5IHB1bGxzIGluIHBhcnQg
b2YNCj4gdGhlDQo+ID4gPiA+IGxpc3QuDQo+ID4gPiA+DQo+ID4gPiA+IEV2ZW4gd2l0aCBCUEYg
YmVpbmcgcHJpdmlsZWdlZCwgdGhlIGtlcm5lbCBzaG91bGQgbm90IGNyYXNoIGlmDQo+IEJQRg0K
PiA+ID4gPiBwdWxscyBhIEZSQUdMSVNUIEdTTyBza2IuDQo+ID4gPiA+DQo+ID4gPiA+IEJ1dCB0
aGUgY2hlY2sgbmVlZHMgdG8gYmUgcmVmaW5lZCBhIGJpdC4gRm9yIGEgVURQIEdTTyBwYWNrZXQs
DQo+IEkNCj4gPiA+ID4gdGhpbmsgZ3NvX3NpemUgaXMgc3RpbGwgdmFsaWQsIHNvIGlmIHRoZSBo
ZWFkX3NrYiBsZW5ndGggZG9lcw0KPiBub3QNCj4gPiA+ID4gbWF0Y2ggZ3NvX3NpemUsIGl0IGhh
cyBiZWVuIG1lc3NlZCB3aXRoIGFuZCBzaG91bGQgYmUgZHJvcHBlZC4NCj4gPiA+ID4NCklzIGl0
IE9LIGFzIGJlbG93PyBJcyBpdCBPSyB0byBhZGQgbG9nIHRvIHJlY29yZCB0aGUgZXJyb3IgZm9y
IGVhc3kNCmNoZWNraW5nIGlzc3VlLg0KDQpJbiBuZXQvY29yZS9za2J1ZmYuYyBza2Jfc2VnbWVu
dF9saXN0DQordW5zaWduZWQgaW50IG1zcyA9IHNrYl9zaGluZm8oaGVhZF9za2IpLT5nc29fc2l6
ZTsNCitib29sIGVycl9sZW4gPSBmYWxzZTsNCg0KK2lmICggbXNzICE9IEdTT19CWV9GUkFHUyAm
JiBtc3MgIT0gc2tiX2hlYWRsZW4oaGVhZF9za2IpKSB7DQorCXByX2Vycigic2tiIGlzIGRyb3Bw
ZWQgZHVlIHRvIG1lc3NlZCBkYXRhLiBnc28gc2l6ZTolZCwNCisJCWhkcmxlbjolZCIsIG1zcywg
c2tiX2hlYWRsZW4oaGVhZF9za2IpDQorCWlmICghbGlzdF9za2IpDQorCQlnb3RvIGVycl9saW5l
YXJpemU7DQorCWVsc2UNCisJCWVycl9sZW4gPSB0cnVlOw0KK30NCg0KLi4uDQoraWYgKGVycl9s
ZW4pIHsNCisJZ290byBlcnJfbGluZWFyaXplOw0KK30NCg0Kc2tiX2dldChza2IpOw0KLi4uDQoN
Cj4gPiA+ID4gRm9yIGEgR1NPX0JZX0ZSQUdTIHNrYiwgdGhlcmUgaXMgbm8gc2luZ2xlIGdzb19z
aXplLCBhbmQgdGhpcw0KPiBwdWxsDQo+ID4gPiA+IG1heSBiZSBlbnRpcmVseSB1bmRldGVjdGFi
bGUgYXMgbG9uZyBhcyBmcmFnX2xpc3QgIT0gTlVMTD8NCj4gPiA+ID4NCj4gPiA+ID4NCkluIGZ1
bmN0aW9uIHNrYl9zZWdtZW50X2xpc3QoKSwgaXQganVzdCBoYW5kbGUgdWRwIGZyYWdsaXN0IGdy
byBwYWNrZXQuDQpucl9mcmFncyB3aWxsIGJlIDAgaGVyZS4gDQoNCkl0IHJlY29yZHMgYSBTS0Jf
R1NPX0RPREdZIGluIGdzb190eXBlIHdoZW4gZG9pbmcgcGFydGlhbGx5IGVhdGVuIGZvcg0KZnJh
Z2xpc3QgaW4gX19wc2tiX3B1bGxfdGFpbCBhbmQgaW4gc2tiX3NlZ21lbnQoKSBpdCB3aWxsIGNo
ZWNrIGFuZA0KZGlzYWJsZSBORVRJRl9GX1NHLiANCnNrYl9zZWdtZW50IGNvdWxkIHNlZ21lbnQg
ZGF0YSBhcyBnc29fc2l6ZSBldmVuIGlmIGl0IGlzIHB1bGxlZCBpbnRvDQpoZWFyZGVyIHNrYi4g
SSBhbSBub3Qgc3VyZSBpZiBpdCBjYW4gZGVjb2RlIHdoZW4gZnJhZ19saXN0IGlzIE5VTEwgb3IN
CnBhcnRpYWxseSBlYXRlbiBhcyBubyBCUEYgcHVsbHMgaWxsZWdhbCBsZW5ndGggZm9yIHRjcCBw
YWNrZXQuIE91cg0KcGxhdGZyb20gZG9lc24ndCBtZWV0IGlzc3VlcyBpbiBza2Jfc2VnbWVudCBm
b3IgdGNwIHBhY2tldCB0aWxsIG5vdy4NCg0KPiA+ID4gPiA+ID4gPiA+ICBza2Jfc2hpbmZvKHNr
YiktPmZyYWdfbGlzdCA9IE5VTEw7DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEluIGFi
c2Vuc2Ugb2YgcGx1Z2dpbmcgdGhlIGlzc3VlIGluIEJQRiwgZHJvcHBpbmcgaGVyZSBpcw0KPiB0
aGUgYmVzdA0KPiA+ID4gPiA+ID4gPiB3ZSBjYW4gZG8gaW5kZWVkLCBJIHRoaW5rLg0KPiA+IA0K
PiA+IC0tDQo+ID4gTWFjaWVqIMW7ZW5jenlrb3dza2ksIEtlcm5lbCBOZXR3b3JraW5nIERldmVs
b3BlciBAIEdvb2dsZQ0KPiANCj4gDQo=

