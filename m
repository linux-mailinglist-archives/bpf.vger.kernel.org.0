Return-Path: <bpf+bounces-27209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEB38AAAA9
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 10:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D50282186
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7065189;
	Fri, 19 Apr 2024 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KfFPRmpo";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QGxok/ll"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645C75F569;
	Fri, 19 Apr 2024 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515806; cv=fail; b=k5E+DoMhT7SwPaWPjehkgHQaZKz+9/1hGpcz2CjeNMgQ9RF/qWHzaB/r6aedPyPTmLbTuH8eXfs5V14dk7nRn+vvphtiPiUMhSn0YHN6BRgtHwj/xFw5lW0mlBGamW3pGy8nO7q3CVsG6zogrg25D6RKHDIld6L6e8mKKSFSvlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515806; c=relaxed/simple;
	bh=sQTDkgP0POC3Fy1bVJNoUv4FYMNkEUDvFtIVRuLte/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ABW652FrlQeJ+uvHZnN4VprruWVGJ1SvKPOBqh7sjPgBhuCnQmpT4f2vc0GGC1hE/U75vlOVQ1MPd+2F3z55MP5STdhZVMMbsC42KI5d+3zZZxyXo2P/Cpn5yxiYET95KfkF64Qv3y39vmp+J+b79x/NSiX2PGfUSFj+ehBIFAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KfFPRmpo; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QGxok/ll; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ecf8fe96fe2711ee935d6952f98a51a9-20240419
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sQTDkgP0POC3Fy1bVJNoUv4FYMNkEUDvFtIVRuLte/I=;
	b=KfFPRmpoLtvABh8P/zuatfbDens78mvG0RsxWQ6UgmSTG6Q9aUzUeVnpH0JAgSry8Le2+4dwK7wKgEgVjPpFOl2Vw2nzQmnTyBgYN5LzrX0hHJSx/Aet8tfhABdlP/8DxSoeuFkUaCvGWNs75BnsOT4i7mtu6sbcgAfqGQFhI7g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:631b4ce9-1b31-4ff9-861e-5693bb9a6c1b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:e8e41bfb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ecf8fe96fe2711ee935d6952f98a51a9-20240419
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 648420650; Fri, 19 Apr 2024 16:36:32 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Apr 2024 16:36:31 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 Apr 2024 16:36:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9UGA06z7pUN9UnEmKqf8x8Iih6NYRcqD9cceqkCVIJZc/z75qDIGo5RR2yjQKwky+Yq3DLjyP/pJUW92P7PpE8cMVvvNuL/adgpq6eFzGtAZZjxxCqxrCZN/w9xKjBfkgaCIvPlytOkEqBL1x/jEk/miJ6OtUwTJSsDt+5fQ4oyyi5m48p8C0A1QBH3yLaMylCM31vVODIHfE0cBE4nXNVFdx2eLy03BUXbgX59GDIl7vhpA2rb7D+Lf3Ip068bKqdDoi8cWbXGVnE/WvPY2gbkv788PZkz48uQJckqSKn5+vrgb3ScFi8T25vVQuJ2vig5g3jiWJl7ubKhJOzNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQTDkgP0POC3Fy1bVJNoUv4FYMNkEUDvFtIVRuLte/I=;
 b=USmOLs/9sW4lJUYFpNhbOk9KJBOM5Ts7/6qBqJ6ojfJJIx1X+4ltSHzI/3LFTKTzpSKdTgvST6tTFDAGTDcafd8Lwexw0QsjC9HF3e/fOyHkmx1KU67kX33pUEKxdz7+LToSKPRGPJYQFrN3rlL+W4hzLbj1DQ7TCvLf8rQSGBTl1F4abYK1xwbmdR4R4FSBpM8EYio/Lul1yEvtJmzjBUdQ7bXlqXZ4xkjTKil/Hl1I5B2e9JOHv85XQ6pAFwAfAg37zwCzjtH+oD9W+wqpBI36AnYWpIll2FKYDIN9t1AQXLkcBvWkUtlQT05c3WowS8j/VXHwE0UscTAouadQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQTDkgP0POC3Fy1bVJNoUv4FYMNkEUDvFtIVRuLte/I=;
 b=QGxok/ll0pRwW/uOSYy7FufgA5I5ssmyI15JOgPG2XcKKc6WMhEgGmSmETt665rJTz5c+jo92KrE9b1jYzW0zjgKNWb8JTxLMr8yVn8cIGmXbYKHhBI69rWJHnaVu3XAUG+AkZ79aQa65Dmrh1bjrswCLeK7jeU+IQ7wBAwUZxY=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by SEYPR03MB7434.apcprd03.prod.outlook.com (2603:1096:101:13e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Fri, 19 Apr
 2024 08:36:29 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7%6]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 08:36:29 +0000
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
Thread-Index: AQHaj0XOIxnbbRpuOEqwUbC2K0Us3rFpz0sAgABZ6oCAAArbAIAA8PYAgAAJ3wCAAAGxgIAAWJUAgACHpICAANEgAIAAdp6AgAAXCgCAAdtPAA==
Date: Fri, 19 Apr 2024 08:36:29 +0000
Message-ID: <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com>
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
In-Reply-To: <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|SEYPR03MB7434:EE_
x-ms-office365-filtering-correlation-id: 5b62133b-a6c5-49b5-1e91-08dc604bcf04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?NldSNytOL0VMY21zZk9WcUFMVGd1alJiVnBPRU1MZjAybG9IUndYTENKWnkv?=
 =?utf-8?B?ejV4Y3QrUUVBazlQU3ZRNFZTOHV6VWs2bGJWWEdjNTZZNHFIbExoSG93TGVt?=
 =?utf-8?B?NWVjM2p6aFUrZHhWalNvZTJJVS9uTjVwcHZaZnJwOE4vbUhwRnVGYnMwV0g5?=
 =?utf-8?B?WUs2TkNOZVFiVElZNlNBL2t0UlI2WDhtVStoZ3pacThQWXlMRTNFaHlPMGlh?=
 =?utf-8?B?N1RuK0ZpdmZhbWRBb2huTTA4U0JZeFVmMHJXeGJ5VC9qRFZBTk9YVEE3TERU?=
 =?utf-8?B?K0l2OGxGSXh6YXVvekVmOTNtWnZjT0p6T1dERDNDTVplRnVSUHJ5TnVJcVNK?=
 =?utf-8?B?a1hqOFUwTGtJZGxUakNOUlRqbUpkNWRvL3g1ZnBRTWQ5ZWxaOWt4dTlYSURT?=
 =?utf-8?B?NmZUT2s5cFFSK0UyMU9EY1pFTThtOUxVN2poMUU2WkVpWklOeUg1cWZmK0pT?=
 =?utf-8?B?R2ZtTnQ5TnF5bWhOTVpKZ0tWTitJd0lmTjVEME56ZklPZHFwZ09ENVp2NHh5?=
 =?utf-8?B?QzhYMjJuR0FFanJvQW1wTGpROW9PNmsyS00xOUhHbnMzd0dNSmxEY3NPYXY3?=
 =?utf-8?B?aGQxUHg1blhaS3lWVit3bEYwQlQyaDVBMnBZWkhieVB3WlZDL3pnZGNvbVgr?=
 =?utf-8?B?QSt0OG9YcTB5Z0RmeW5Kclk4U0Z0a3dJa3lWbGN4b1lhSGRxQ0wvNWllVkJO?=
 =?utf-8?B?bDE0S3pENmlrNnVqaE5hVWFxYVB5M1pMSlNSSHhvc0Fjb3ZaN3d3TytsVFZn?=
 =?utf-8?B?ZExwUyttN0I4blhabkk3WEk5MVFjZTRPenVoTG1NQjAxTVRZMTdDcjlSTGVP?=
 =?utf-8?B?cUNqSWgvajV5NW43VjBJN3pSZHlNNVFpVkNnQ0FJM1JTeThFak9qVVFBR2RD?=
 =?utf-8?B?Yjh2SUVLVjMrT0lsVlpVWW5WaXlmcGRRdlhOVG5sb1p5ZjM0enMwTmVZQk5Q?=
 =?utf-8?B?Q1grZUIxV0hNQ1JLZGExa1JmMDk5LzVOVVJCbGlqUTJOUkdCN096a0lVRDdh?=
 =?utf-8?B?T25PNlo4R2hiSDVicDVCZGtPdWVmQ2pXSzgrdjlGZlRxNWt4b09XNDE1Z2FS?=
 =?utf-8?B?c3UxL2lpZEZxemdXaDBnNUJKU0cxNlNFamRKSUJxT0ZydXRTSWpMaDRhbGFk?=
 =?utf-8?B?QkthODM1OTQvUkJFQ0o2aUhCazQybVhMQ0dkdzJOSmRwZ2RnSkloeEpITkZQ?=
 =?utf-8?B?dUIyRE1RQldISUx4UWpqbmJXYUc3eVg5K0d1alZ0d0R2cnRVajJtTWIrajcz?=
 =?utf-8?B?WlFBVUFRSnhSOVVJQ3EzR2IwNkswY0J1MVRlQlRGbjJlbmVJaldGWThwVzhT?=
 =?utf-8?B?Qk9GQ1dyQ1IzZ1l3QU0vME9XU1RvTjhMN2syNXl2WDYweXZmcnlnVzRHVHkw?=
 =?utf-8?B?bkRqQmN5Q21HYjRhTHFVbzVTS0FLS2F2RHdReFluM05kUGN0dnEvM2d0T0ZV?=
 =?utf-8?B?b0svVFV4WlJRbUdOcnI3UGdjNXlWTlZ4YlUxY0U3V25kYklOZDZ1a2xIMVJI?=
 =?utf-8?B?RHFPNmVqLzk0QzFvQ2sra3l0cjdtQ1RrdGdWVVZmeXYxRnBWZzZLWjNDWEt4?=
 =?utf-8?B?NUVTU1E4d1l0WHB4TEhoOVQ3UlY4ckFpSzNLZHRSZHhFNCtPSWpxOG8rUFZp?=
 =?utf-8?B?eGZ5bEFTNGJ5VURPNmRwNlNDR1EyOVFDMFdTZjhvdWRadWR5SWR2ZFhnNXYx?=
 =?utf-8?B?d0Zwb0N6NS83YmNGeXoraEt6aWJwQTZ1L0lKS25NNFJhRDdoWWMwMWRUa1Bw?=
 =?utf-8?B?T2VQZ2owWDNXd3pWbGZReFZEanFyMTkrNEZjeDVBcHh2RW1XOU8yVVdUSEpX?=
 =?utf-8?B?VXNFa0gweWNhZThiWU5NQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjNrTXgxdWU2TDQ5bDhnN1czd3dEcWJOQzdSUkFrVzJaMkRWb3lGZWJxdnpm?=
 =?utf-8?B?TlpOeFM3LzIyYnhYNlNiRGZqSWpSVSt1am85ZlcxWWEwZnpiZ1NMSVRDMGxJ?=
 =?utf-8?B?cm9KMHZSbURBbzVMQWRjZzRaVWFIazhDSFlqRWI5cWd2Q1hvTnNNK3lXaFZT?=
 =?utf-8?B?OGRZZ0l4WDZRMnB2MDVHNTJRcG1nQWRVS2JmM0xZVXFlTXB2djVueU9jWVh3?=
 =?utf-8?B?UUF2V2ltWTZ6Y3g5TDI2Z2NpeEdwMHFSWmFkd1Y4MllhQjM4QWJxdW9VemNM?=
 =?utf-8?B?S3pXVEp5VlQ0dXNuaUR3RFdCdm9aWWhTL0tIcXhCdDJKWjJ2U0hTdEsyRkI0?=
 =?utf-8?B?QzRwWjR1UEhka0pkNTY5MnU4RkdoZmtYVjZtdm0va0Y5YkdmWDdHZUZOYjYr?=
 =?utf-8?B?bDErS2lIbWJNSjl0NTBXTWJVLzd5eUM0ZisyUVNmMGs3Mys1eHdOWjN3c21J?=
 =?utf-8?B?VWozRmp0OW0wbzdvOW9pKzA4S0dWMDQvQ0RmbXAybEUvWjl4enArQlVscUtx?=
 =?utf-8?B?dDZmeEtZSjBCYzZrL21KejcwUDhKRWN1SzBNVzBtVFdMaWtMaFBYY0tVNkpN?=
 =?utf-8?B?MHRUdmtYbjJpU21uK2lXQlJMZWQ0YUhzRnMwMFRxVVc3KzJUb0FoQUVmMHNB?=
 =?utf-8?B?a2RTTW45TE5uY3duUWxVOTR5R2d5UkxIT0M1bTFxV2JWMTJ6ZERTL1lrM2RX?=
 =?utf-8?B?QUlKTW9HKy9NS2NkU3Nwb3hWZGE1S1lLM2lLdEs5ZWt3ZXVZdkVMVHdaWTNQ?=
 =?utf-8?B?YldTeVk4NDYrYlgxK2xMdFZ6WVBhaXk0TGxwdXZQRklsbmlLZUhDaTlYWm1H?=
 =?utf-8?B?SC9qbHIxd1AwdjJwY0JBSEVTMTV3UU40alVuV1haWlhBeWk0OHRlZ1dhcHhU?=
 =?utf-8?B?R09nVzJyV1ViMExmUTl6Q2sybFhTajkyc2txOUE3ZWo5RnJtR0kxMnZsdVVs?=
 =?utf-8?B?akVOZ2JYdW05b3BOTEhLaitlK01abjNUQUllUGtBT3hOSDBQbTR1RHpGZTFj?=
 =?utf-8?B?SkNtUWxGbE1RdVZ3YUNBMmFmRytNcFVzYXdZc1F0a2krTGdOY0N5Nk40V0xo?=
 =?utf-8?B?VlQzbVpRWVBFdkZabHJJM2ZwYUNWaENpeUdKT2FvL0xBTkh0SStCZFA1bTAz?=
 =?utf-8?B?VXprcUFJUmRYbVRIT1NuV1M1QTZ5RkNNaWhCV2hsb0RnS1R2Q0l1RDJIV3Vj?=
 =?utf-8?B?bHJ1RkhnQVdHUDZIUjVRK0dTelNvb0s4MXBqTVduK3lSaVBoMk0xbHJnRkNs?=
 =?utf-8?B?OHM1SHNqRVNjd3NjNnZMaWNSaGFGa003OHpFa21CQmZpekJCUmdUMVVuRHBp?=
 =?utf-8?B?RW9IYlpVUnhKY3AxSGtXaGl4bWdLNE9EbkZvaG5nNGc2VTc3TUlzeDF1Q0FF?=
 =?utf-8?B?YWQxa0M4a0RtSkVXa1BRUGpZVFdHelRoQmUvaTRaSm5xd09CeFFnM0hubDFG?=
 =?utf-8?B?cmFaay9OdHdkUFRDYXFhZHlRT0grWG54WmRmOUlkVzdkbUZzNXJqeTY1NkZp?=
 =?utf-8?B?dytCMy95ejFBakhnVHk5OXNaQXlVd2VFempiM3lWVm42TjhqZk82SGRwYWdK?=
 =?utf-8?B?dkZCZksyRWZ1bXVLQWtkK1hkMlovcGF0V2N5UXRUc1dUN3dIZDRIOTczcnVl?=
 =?utf-8?B?dE1pK2cwY3V4cHdWWExlL3puMXV6VTNUbm5HT2FZYkl3aDhGZmVwN1JLbVZO?=
 =?utf-8?B?MHVvK0NXbzFLdFJvejU0MkQ1ZTRLS1RUT0Z2WXNReW9qMVhEWHZjVGZXejlt?=
 =?utf-8?B?MWttb1VEU2h2d1RvcU10Q2ZrdnN0YUFLek1QNjN1bEdrNGtvMFVHSitxL2xz?=
 =?utf-8?B?QWZQNlRMTjhQY3BWYm1pU0lXcnBkZ1Y5SDJuZElnM215Q0RJK0ZvV2wyWkMy?=
 =?utf-8?B?cXVuOTBvZGI2cTg3UVJXZXlJb0hwUlhlOHArUXhrTDJaaHJWN1luUHR0ZUU3?=
 =?utf-8?B?MWllUzlPNkcrdFc3RWRPb2tOb2d4NFNaVDgvSzFkK1I2UllseXZ1M0o5WmM4?=
 =?utf-8?B?SGd4QW42eUZYQW1NRk92S2QxOGVBYTV3UG8vTnozTXQ0Ly9idk9qV1MwNThY?=
 =?utf-8?B?TFBHTnFxYUxoN2VOUHVrMzI1VHc5T1BOK041ZXBTQTY3RmE1d1A3bk5BcS9S?=
 =?utf-8?B?QWF4bW9PK3llY2dXK2dSZWdaYStwNWVRTkg4dU5wT1V5UEJaVHV6SWRwdjNN?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2154AC19A4B09419179EB49E6D7686D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b62133b-a6c5-49b5-1e91-08dc604bcf04
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 08:36:29.1486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAXAq4kPdsDZsyUoy+yzx0Fn401zHboegblCfASV0ooMQsrSISE8NJHx+AMV/ReBOD+P4xBdsMEEATupWKKrlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7434

T24gV2VkLCAyMDI0LTA0LTE3IGF0IDIxOjE1IC0wNzAwLCBNYWNpZWogxbtlbmN6eWtvd3NraSB3
cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5k
ZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBPbiBXZWQsIEFwciAxNywgMjAyNCBhdCA3OjUz4oCvUE0g
TGVuYSBXYW5nICjnjovlqJwpIDwNCj4gTGVuYS5XYW5nQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBPbiBXZWQsIDIwMjQtMDQtMTcgYXQgMTU6NDggLTA0MDAsIFdpbGxlbSBkZSBCcnVp
am4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZl
cmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiAgTGVuYSBXYW5nICjnjovl
qJwpIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIDIwMjQtMDQtMTYgYXQgMTk6MTQgLTA0MDAsIFdp
bGxlbSBkZSBCcnVpam4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBFeHRlcm5hbCBlbWFp
bCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Blbg0KPiBhdHRhY2htZW50cw0KPiA+
ID4gdW50aWwNCj4gPiA+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiA+ID4gPiA+ICA+ID4gPiA+IFBlcnNvbmFsbHksIEkgdGhpbmsgYnBmX3NrYl9w
dWxsX2RhdGEoKSBzaG91bGQgaGF2ZQ0KPiA+ID4gPiA+IGF1dG9tYXRpY2FsbHkNCj4gPiA+ID4g
PiA+ID4gPiA+IChpZS4gaW4ga2VybmVsIGNvZGUpIHJlZHVjZWQgaG93IG11Y2ggaXQgcHVsbHMg
c28NCj4gdGhhdCBpdA0KPiA+ID4gPiA+IHdvdWxkIHB1bGwNCj4gPiA+ID4gPiA+ID4gPiA+IGhl
YWRlcnMgb25seSwNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFRoYXQgd291bGQg
YmUgYSBoZWxwZXIgdGhhdCBwYXJzZXMgaGVhZGVycyB0byBkaXNjb3Zlcg0KPiA+ID4gaGVhZGVy
DQo+ID4gPiA+ID4gbGVuZ3RoLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBEb2VzIGl0
IGFjdHVhbGx5IG5lZWQgdG8/ICBQcmVzdW1hYmx5IHRoZSBicGYgcHVsbA0KPiBmdW5jdGlvbg0K
PiA+ID4gY291bGQNCj4gPiA+ID4gPiA+ID4gbm90aWNlIHRoYXQgaXQgaXMNCj4gPiA+ID4gPiA+
ID4gYSBwYWNrZXQgZmxhZ2dlZCBhcyBiZWluZyBvZiB0eXBlIFggKFVEUCBHU08gRlJBR0xJU1Qp
DQo+IGFuZA0KPiA+ID4gcmVkdWNlDQo+ID4gPiA+ID4gdGhlIHB1bGwNCj4gPiA+ID4gPiA+ID4g
YWNjb3JkaW5nbHkgc28gdGhhdCBpdCBkb2Vzbid0IHB1bGwgYW55dGhpbmcgZnJvbSB0aGUNCj4g
bm9uLQ0KPiA+ID4gbGluZWFyDQo+ID4gPiA+ID4gPiA+IGZyYWdsaXN0IHBvcnRpb24/Pz8NCj4g
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gSSBrbm93IG9ubHkgdGhlIGdlbmVyaWMgb3ZlcnZp
ZXcgb2Ygd2hhdCB1ZHAgZ3NvIGlzLCBub3QNCj4gYW55DQo+ID4gPiA+ID4gZGV0YWlscywgc28g
SSBhbQ0KPiA+ID4gPiA+ID4gPiBhc3N1bWluZyBoZXJlIHRoYXQgdGhlcmUncyBzb21lIHNvcnQg
b2YgZ3VhcmFudGVlIHRvIGhvdw0KPiA+ID4gdGhlc2UNCj4gPiA+ID4gPiBwYWNrZXRzDQo+ID4g
PiA+ID4gPiA+IGFyZSBzdHJ1Y3R1cmVkLi4uICBCdXQgSSBpbWFnaW5lIHRoZXJlIG11c3QgYmUg
b3Igd2UNCj4gd291bGRuJ3QNCj4gPiA+IGJlDQo+ID4gPiA+ID4gaGl0dGluZyB0aGVzZQ0KPiA+
ID4gPiA+ID4gPiBpc3N1ZXMgZGVlcGVyIGluIHRoZSBzdGFjaz8NCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiBQZXJoYXBzIGZvciBhIHBhY2tldCBvZiB0aGlzIHR5cGUgd2UncmUgYWxyZWFkeSBn
dWFyYW50ZWVkDQo+IHRoZQ0KPiA+ID4gPiA+IGhlYWRlcnMNCj4gPiA+ID4gPiA+IGFyZSBpbiB0
aGUgbGluZWFyIHBvcnRpb24sDQo+ID4gPiA+ID4gPiBhbmQgdGhlIHB1bGwgc2hvdWxkIHNpbXBs
eSBiZSBpZ25vcmVkPw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4g
PiBQYXJzaW5nIGlzIGJldHRlciBsZWZ0IHRvIHRoZSBCUEYgcHJvZ3JhbS4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IEkgZG8gcHJlZmVyIGFkZGluZyBzYW5pdHkgY2hlY2tzIHRvIHRoZSBCUEYgaGVs
cGVycywgb3Zlcg0KPiBoYXZpbmcNCj4gPiA+IHRvDQo+ID4gPiA+ID4gYWRkIHRoZW4gaW4gdGhl
IG5ldCBob3QgcGF0aCBvbmx5IHRvIHByb3RlY3QgYWdhaW5zdA0KPiBkYW5nZXJvdXMNCj4gPiA+
IEJQRg0KPiA+ID4gPiA+IHByb2dyYW1zLg0KPiA+ID4gPiA+DQo+ID4gPiA+IElzIGl0IE9LIHRv
IGlnbm9yZSBvciBkZWNyZWFzZSBwdWxsIGxlbmd0aCBmb3IgdWRwIGdybyBmcmFnbGlzdA0KPiA+
ID4gcGFja2V0Pw0KPiA+ID4gPiBJdCBjb3VsZCBzYXZlIHRoZSBub3JtYWwgcGFja2V0IGFuZCBz
ZW50IHRvIHVzZXIgY29ycmVjdGx5Lg0KPiA+ID4gPg0KPiA+ID4gPiBJbiBjb21tb24vbmV0L2Nv
cmUvZmlsdGVyLmMNCj4gPiA+ID4gc3RhdGljIGlubGluZSBpbnQgX19icGZfdHJ5X21ha2Vfd3Jp
dGFibGUoc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4gPiA+ID4gICAgICAgICAgICAgICB1bnNpZ25l
ZCBpbnQgd3JpdGVfbGVuKQ0KPiA+ID4gPiB7DQo+ID4gPiA+ICtpZiAoc2tiX2lzX2dzbyhza2Ip
ICYmIChza2Jfc2hpbmZvKHNrYiktPmdzb190eXBlICYNCj4gPiA+ID4gKyhTS0JfR1NPX1VEUCAg
fFNLQl9HU09fVURQX0w0KSkgew0KPiA+ID4NCj4gPiA+IFRoZSBpc3N1ZSBpcyBub3Qgd2l0aCBT
S0JfR1NPX1VEUF9MNCwgYnV0IHdpdGggU0tCX0dTT19GUkFHTElTVC4NCj4gPiA+DQo+ID4gQ3Vy
cmVudCBpbiBrZXJuZWwganVzdCBVRFAgdXNlcyBTS0JfR1NPX0ZSQUdMSVNUIHRvIGRvIEdSTy4g
SW4NCj4gPiB1ZHBfb2ZmbG9hZC5jIHVkcDRfZ3JvX2NvbXBsZXRlIGdzb190eXBlIGFkZHMgIlNL
Ql9HU09fRlJBR0xJU1R8DQo+ID4gU0tCX0dTT19VRFBfTDQiLiBIZXJlIGNoZWNraW5nIHRoZXNl
IHR3byBmbGFncyBpcyB0byBsaW1pdCB0aGUNCj4gcGFja2V0DQo+ID4gYXMgIlVEUCArIG5lZWQg
R1NPICsgZnJhZ2xpc3QiLg0KPiA+DQo+ID4gV2UgY291bGQgcmVtb3ZlIFNLQl9HU09fVURQX0w0
IGNoZWNrIGZvciBtb3JlIHBhY2tldCB0aGF0IG1heQ0KPiBhZGRyaXZlDQo+ID4gc2tiX3NlZ21l
bnRfbGlzdC4NCj4gPg0KPiA+ID4gPiArcmV0dXJuIDA7DQo+ID4gPg0KPiA+ID4gRmFpbGluZyBm
b3IgYW55IHB1bGwgaXMgYSBiaXQgZXhjZXNzaXZlLiBBbmQgd291bGQga2lsbCBhIHNhbmUNCj4g
PiA+IHdvcmthcm91bmQgb2YgcHVsbGluZyBvbmx5IGFzIG1hbnkgYnl0ZXMgYXMgbmVlZGVkLg0K
PiA+ID4NCj4gPiA+ID4gKyAgICAgb3IgaWYgKHdyaXRlX2xlbiA+IHNrYl9oZWFkbGVuKHNrYikp
DQo+ID4gPiA+ICt3cml0ZV9sZW4gPSBza2JfaGVhZGxlbihza2IpOw0KPiA+ID4NCj4gPiA+IFRy
dW5jYXRpbmcgcmVxdWVzdHMgd291bGQgYmUgYSBzdXJwcmlzaW5nIGNoYW5nZSBvZiBiZWhhdmlv
cg0KPiA+ID4gZm9yIHRoaXMgZnVuY3Rpb24uDQo+ID4gPg0KPiA+ID4gRmFpbGluZyBmb3IgYSBw
dWxsID4gc2tiX2hlYWRsZW4gaXMgYXJndWFibHkgcmVhc29uYWJsZSwgYXMNCj4gPiA+IHRoZSBh
bHRlcm5hdGl2ZSBpcyB0aGF0IHdlIGxldCBpdCBnbyB0aHJvdWdoIGJ1dCBoYXZlIHRvIGRyb3AN
Cj4gPiA+IHRoZSBub3cgbWFsZm9ybWVkIHBhY2tldHMgb24gc2VnbWVudGF0aW9uLg0KPiA+ID4N
Cj4gPiA+DQo+ID4gSXMgaXQgT0sgYXMgYmVsb3c/DQo+ID4NCj4gPiBJbiBjb21tb24vbmV0L2Nv
cmUvZmlsdGVyLmMNCj4gPiBzdGF0aWMgaW5saW5lIGludCBfX2JwZl90cnlfbWFrZV93cml0YWJs
ZShzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiA+ICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHdy
aXRlX2xlbikNCj4gPiB7DQo+ID4gKyAgICAgICBpZiAoc2tiX2lzX2dzbyhza2IpICYmIChza2Jf
c2hpbmZvKHNrYiktPmdzb190eXBlICYNCj4gPiArICAgICAgICAgICAgICAgU0tCX0dTT19GUkFH
TElTVCkgJiYgKHdyaXRlX2xlbiA+DQo+IHNrYl9oZWFkbGVuKHNrYikpKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KPiANCj4gcGxlYXNlIGxpbWl0IHdyaXRlX2xlbiB0byBza2Jf
aGVhZGxlbigpIGluc3RlYWQgb2YganVzdCByZXR1cm5pbmcgMA0KPiANCg0KSGkgTWF6ZSAmIFdp
bGxlbSwNCk1hemUncyBhZHZpY2UgaXM6DQpJbiBjb21tb24vbmV0L2NvcmUvZmlsdGVyLmMNCnN0
YXRpYyBpbmxpbmUgaW50IF9fYnBmX3RyeV9tYWtlX3dyaXRhYmxlKHN0cnVjdCBza19idWZmICpz
a2IsDQogICAgICAgICAgICAgIHVuc2lnbmVkIGludCB3cml0ZV9sZW4pDQp7IA0KKyAgICAgICBp
ZiAoc2tiX2lzX2dzbyhza2IpICYmIChza2Jfc2hpbmZvKHNrYiktPmdzb190eXBlICYNCisgICAg
ICAgICAgICAgICBTS0JfR1NPX0ZSQUdMSVNUKSAmJiAod3JpdGVfbGVuID4gc2tiX2hlYWRsZW4o
c2tiKSkpIHsNCisgICAgICAgICAgICAgICB3cml0ZV9sZW4gPSBza2JfaGVhZGxlbihza2IpOw0K
KyAgICAgICB9DQogICAgICAgIHJldHVybiBza2JfZW5zdXJlX3dyaXRhYmxlKHNrYiwgd3JpdGVf
bGVuKTsNCn0NCg0KV2lsbGVtJ3MgYWR2aWNlIGlzIHRvICJGYWlsaW5nIGZvciBhIHB1bGwgPiBz
a2JfaGVhZGxlbiBpcyBhcmd1YWJseSANCnJlYXNvbmFibGUuLi4iLiBJdCBwcmVmZXJzIHRvIHJl
dHVybiAwIDoNCisgICAgICAgaWYgKHNrYl9pc19nc28oc2tiKSAmJiAoc2tiX3NoaW5mbyhza2Ip
LT5nc29fdHlwZSAmDQorICAgICAgICAgICAgICAgU0tCX0dTT19GUkFHTElTVCkgJiYgKHdyaXRl
X2xlbiA+IHNrYl9oZWFkbGVuKHNrYikpKSB7DQorICAgICAgICAgICAgICAgcmV0dXJuIDA7DQor
ICAgICAgIH0NCg0KSXQgc2VlbXMgYSBiaXQgY29uZmxpY3QuIEhvd2V2ZXIgSSBhbSBub3Qgc3Vy
ZSBpZiBteSB1bmRlcnN0YW5kaW5nIGlzDQpyaWdodCBhbmQgaG9wZSB0byBnZXQgeW91ciBmdXJ0
aGVyIGd1aWRlLg0KDQpUaGFua3MNCkxlbmENCg0KPiA+ICsgICAgICAgfQ0KPiA+ICAgICAgICAg
cmV0dXJuIHNrYl9lbnN1cmVfd3JpdGFibGUoc2tiLCB3cml0ZV9sZW4pOw0KPiA+IH0NCj4gPg0K
PiA+ID4gPiArfQ0KPiA+ID4gPiByZXR1cm4gc2tiX2Vuc3VyZV93cml0YWJsZShza2IsIHdyaXRl
X2xlbik7DQo+ID4gPiA+IH0NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiBJbiB0aGlzIGNh
c2UsIGl0IHdvdWxkIGJlIGRldGVjdGluZyB0aGlzIEdTTyB0eXBlIGFuZCBmYWlsaW5nDQo+IHRo
ZQ0KPiA+ID4gPiA+IG9wZXJhdGlvbiBpZiBleGNlZWRpbmcgc2tiX2hlYWRsZW4oKS4NCj4gPiA+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gYW5kIG5vdCBwYWNrZXQgY29udGVudC4NCj4g
PiA+ID4gPiA+ID4gPiA+IChUaGlzIGlzIGFzc3VtaW5nIHRoZSByZXN0IG9mIHRoZSBjb2RlIGlz
bid0IHJlYWR5IHRvDQo+ID4gPiBkZWFsDQo+ID4gPiA+ID4gd2l0aCBhIGxvbmdlciBwdWxsLA0K
PiA+ID4gPiA+ID4gPiA+ID4gd2hpY2ggSSB0aGluayBpcyB0aGUgY2FzZSBhdG0uICBQdWxsaW5n
IHRvbyBtdWNoLCBhbmQNCj4gPiA+IHRoZW4NCj4gPiA+ID4gPiBjcmFzaGluZyBvciBmb3JjaW5n
DQo+ID4gPiA+ID4gPiA+ID4gPiB0aGUgc3RhY2sgdG8gZHJvcCBwYWNrZXRzIGJlY2F1c2Ugb2Yg
dGhlbSBiZWluZw0KPiBtYWxmb3JtZWQNCj4gPiA+ID4gPiBzZWVtcyB3cm9uZy4uLikNCj4gPiA+
ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBJbiBnZW5lcmFsIGl0IHdvdWxkIGJlIG5p
Y2UgaWYgdGhlcmUgd2FzIGEgd2F5IHRvDQo+IGp1c3QNCj4gPiA+IHNheQ0KPiA+ID4gPiA+IHB1
bGwgYWxsIGhlYWRlcnMuLi4NCj4gPiA+ID4gPiA+ID4gPiA+IChvciBwb3NzaWJseSBhbGwgTDIv
TDMvTDQgaGVhZGVycykNCj4gPiA+ID4gPiA+ID4gPiA+IFlvdSBpbiBnZW5lcmFsIG5lZWQgdG8g
cHVsbCBzdHVmZiAqYmVmb3JlKiB5b3UndmUNCj4gZXZlbg0KPiA+ID4gbG9va2VkDQo+ID4gPiA+
ID4gYXQgdGhlIHBhY2tldCwNCj4gPiA+ID4gPiA+ID4gPiA+IHNvIHRoYXQgeW91IGNhbiBsb29r
IGF0IHRoZSBwYWNrZXQsDQo+ID4gPiA+ID4gPiA+ID4gPiBzbyBpdCdzIHJlbGF0aXZlbHkgaGFy
ZC9hbm5veWluZyB0byBwdWxsIHRoZSBjb3JyZWN0DQo+ID4gPiBsZW5ndGgNCj4gPiA+ID4gPiBm
cm9tIGJwZg0KPiA+ID4gPiA+ID4gPiA+ID4gY29kZSBpdHNlbGYuDQo+ID4gPiA+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQlBGIG5lZWRzIHRvIG1vZGlmeSBhIHByb3BlciBs
ZW5ndGggdG8gZG8gcHVsbA0KPiA+ID4gZGF0YS4NCj4gPiA+ID4gPiBIb3dldmVyIGtlcm5lbA0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gc2hvdWxkIGFsc28gaW1wcm92ZSB0aGUgZmxvdyB0byBh
dm9pZCBjcmFzaA0KPiBmcm9tIGENCj4gPiA+IGJwZg0KPiA+ID4gPiA+IGZ1bmN0aW9uDQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gY2FsbC4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEFzIHRoZXJl
IGlzIG5vIHNwbGl0IGZsb3cgYW5kIGFwcCBtYXkgbm90DQo+IGRlY29kZQ0KPiA+ID4gdGhlDQo+
ID4gPiA+ID4gbWVyZ2VkIFVEUA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHBhY2tldCwNCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IHdlIHNob3VsZCBkcm9wIHRoZSBwYWNrZXQgd2l0aG91dCBmcmFn
bGlzdCBpbg0KPiA+ID4gPiA+IHNrYl9zZWdtZW50X2xpc3QNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBoZXJlLg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IEZpeGVzOiAzYTEyOTZhMzhkMGMgKCJuZXQ6IFN1cHBvcnQgR1JPL0dTTw0KPiBmcmFnbGlzdA0K
PiA+ID4gPiA+IGNoYWluaW5nLiIpDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBTaGltaW5nIENoZW5nIDwNCj4gPiA+ID4gPiBzaGltaW5nLmNoZW5nQG1lZGlhdGVrLmNv
bT4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IExlbmEgV2FuZyA8DQo+
IGxlbmEud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtLS0NCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ICBuZXQvY29yZS9za2J1ZmYuYyB8IDMgKysrDQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9u
ZXQvY29yZS9za2J1ZmYuYw0KPiBiL25ldC9jb3JlL3NrYnVmZi5jDQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBpbmRleCBiOTkxMjc3MTJlNjcuLmY2OGYyNjc5YjA4NiAxMDA2NDQNCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IC0tLSBhL25ldC9jb3JlL3NrYnVmZi5jDQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiArKysgYi9uZXQvY29yZS9za2J1ZmYuYw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
QEAgLTQ1MDQsNiArNDUwNCw5IEBAIHN0cnVjdCBza19idWZmDQo+ID4gPiA+ID4gKnNrYl9zZWdt
ZW50X2xpc3Qoc3RydWN0DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gc2tfYnVmZiAqc2tiLA0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gIGlmIChlcnIpDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAg
Z290byBlcnJfbGluZWFyaXplOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ICtpZiAoIWxpc3Rfc2tiKQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK2dv
dG8gZXJyX2xpbmVhcml6ZTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFRoaXMgd291bGQgY2F0Y2ggdGhlIGNhc2Ugd2hlcmUgdGhl
IGVudGlyZSBkYXRhDQo+IGZyYWdfbGlzdA0KPiA+ID4gaXMNCj4gPiA+ID4gPiA+ID4gPiBsaW5l
YXJpemVkLCBidXQgbm90IGEgcHNrYl9tYXlfcHVsbCB0aGF0IG9ubHkgcHVsbHMgaW4NCj4gcGFy
dA0KPiA+ID4gb2YNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+ID4gPiBsaXN0Lg0KPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gRXZlbiB3aXRoIEJQRiBiZWluZyBwcml2aWxlZ2Vk
LCB0aGUga2VybmVsIHNob3VsZCBub3QNCj4gY3Jhc2gNCj4gPiA+IGlmDQo+ID4gPiA+ID4gQlBG
DQo+ID4gPiA+ID4gPiA+ID4gcHVsbHMgYSBGUkFHTElTVCBHU08gc2tiLg0KPiA+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+ID4gQnV0IHRoZSBjaGVjayBuZWVkcyB0byBiZSByZWZpbmVkIGEg
Yml0LiBGb3IgYSBVRFAgR1NPDQo+ID4gPiBwYWNrZXQsDQo+ID4gPiA+ID4gSQ0KPiA+ID4gPiA+
ID4gPiA+IHRoaW5rIGdzb19zaXplIGlzIHN0aWxsIHZhbGlkLCBzbyBpZiB0aGUgaGVhZF9za2IN
Cj4gbGVuZ3RoDQo+ID4gPiBkb2VzDQo+ID4gPiA+ID4gbm90DQo+ID4gPiA+ID4gPiA+ID4gbWF0
Y2ggZ3NvX3NpemUsIGl0IGhhcyBiZWVuIG1lc3NlZCB3aXRoIGFuZCBzaG91bGQgYmUNCj4gPiA+
IGRyb3BwZWQuDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gSXMgaXQgT0sgYXMgYmVsb3c/IElz
IGl0IE9LIHRvIGFkZCBsb2cgdG8gcmVjb3JkIHRoZSBlcnJvciBmb3INCj4gZWFzeQ0KPiA+ID4g
PiBjaGVja2luZyBpc3N1ZS4NCj4gPiA+ID4NCj4gPiA+ID4gSW4gbmV0L2NvcmUvc2tidWZmLmMg
c2tiX3NlZ21lbnRfbGlzdA0KPiA+ID4gPiArdW5zaWduZWQgaW50IG1zcyA9IHNrYl9zaGluZm8o
aGVhZF9za2IpLT5nc29fc2l6ZTsNCj4gPiA+ID4gK2Jvb2wgZXJyX2xlbiA9IGZhbHNlOw0KPiA+
ID4gPg0KPiA+ID4gPiAraWYgKCBtc3MgIT0gR1NPX0JZX0ZSQUdTICYmIG1zcyAhPSBza2JfaGVh
ZGxlbihoZWFkX3NrYikpIHsNCj4gPiA+ID4gK3ByX2Vycigic2tiIGlzIGRyb3BwZWQgZHVlIHRv
IG1lc3NlZCBkYXRhLiBnc28gc2l6ZTolZCwNCj4gPiA+ID4gK2hkcmxlbjolZCIsIG1zcywgc2ti
X2hlYWRsZW4oaGVhZF9za2IpDQo+ID4gPg0KPiA+ID4gU3VjaCBsb2dzIHNob3VsZCBhbHdheXMg
YmUgcmF0ZSBsaW1pdGVkLiBCdXQgbm8gbmVlZCB0byBsb2cgY2FzZXMNCj4gPiA+IHdoZXJlIHdl
IHdlbGwgdW5kZXJzdG9vZCBob3cgd2UgZ2V0IHRoZXJlLg0KPiA+ID4NCj4gPiA+IEkgd291bGQg
c3RpY2sgd2l0aCBvbmUgYXBwcm9hY2g6IGVpdGhlciBpbiB0aGUgQlBGIGZ1bmMgb3IgaW4NCj4g
PiA+IHNlZ21lbnRhdGlvbiwgbm90IGJvdGguIEFuZCB0aGVuIEkgZmluZCBCUEYgcHJlZmVyYWJs
ZSwgYXMNCj4gZXhwbGFpbmVkDQo+ID4gPiBiZWZvcmUuDQo+ID4gPg0KPiA+IE9LLCB3ZSB0cnkg
bWFrZSBhIHBhdGNoIGluIEJQRiBmdW5jLg0KPiA+DQo+ID4gPiA+ICtpZiAoIWxpc3Rfc2tiKQ0K
PiA+ID4gPiArZ290byBlcnJfbGluZWFyaXplOw0KPiA+ID4gPiArZWxzZQ0KPiA+ID4gPiArZXJy
X2xlbiA9IHRydWU7DQo+ID4gPiA+ICt9DQo+ID4gPiA+DQo+ID4gPiA+IC4uLg0KPiA+ID4gPiAr
aWYgKGVycl9sZW4pIHsNCj4gPiA+ID4gK2dvdG8gZXJyX2xpbmVhcml6ZTsNCj4gPiA+ID4gK30N
Cj4gPiA+ID4NCj4gPiA+ID4gc2tiX2dldChza2IpOw0KPiA+ID4gPiAuLi4NCj4gDQo+IC0tDQo+
IE1hY2llaiDFu2VuY3p5a293c2tpLCBLZXJuZWwgTmV0d29ya2luZyBEZXZlbG9wZXIgQCBHb29n
bGUNCg==

