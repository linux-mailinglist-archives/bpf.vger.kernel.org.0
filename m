Return-Path: <bpf+bounces-38398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0BA964552
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 14:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACC81C245AD
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A9D1B86D7;
	Thu, 29 Aug 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EAzZR9fY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MGsPq18K"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193E1B81DC;
	Thu, 29 Aug 2024 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935507; cv=fail; b=CdltOYf4vo3S4pjhS3F1HvNF0vqL629Ws/8CZnPgeBOA6Twj+TcYM/KERyUkhi/Lsae1MNtp4auDX7bNmlnszzLVORUryWTT5YhM17BuKgL0Rkqldj3EqS6nmY3tKDP/+BhXNFzY7qXkPP5sV0f6ZWwLMTYhJ83VAaKD9F0L+VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935507; c=relaxed/simple;
	bh=8XVFB3UlOiyYqWggJpnW5oaT/q3MPrtrKztdF+PffmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pZ7IcGYFlak9bnGFJbuba/gJblUVOd/1yMIgjyMVquv1TAlwAbd5cNQkVKJDghfm8Wu+/Wcuj0yWAvPLg5jb8mfqUafNy9vdGy9OLzAEj1aTzCTHrG9jftqLpYxGqByl92QbYtGEWXbVOwlrgdkkis56FD46Plk5h4LR3CPqN2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EAzZR9fY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MGsPq18K; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7ea04dba660411ef8b96093e013ec31c-20240829
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8XVFB3UlOiyYqWggJpnW5oaT/q3MPrtrKztdF+PffmM=;
	b=EAzZR9fYcgIMixzvKEJdiflT8xA/SQoFwo/eVdTkmjeu0h/07SvphGWwU3okMSXdem5CcGtcy3jKF56jT8W4xO21GJo6TWwXyjtgg+h3jpdQjVs0yLzO/e3B6HVhk8/xt/jpvrRixDh9tVkNLPsISQ2BWSqXHclvXIj77cZ5W2s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ff74698a-02cc-42f3-88dd-8710a1c6a58a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:f95660cf-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7ea04dba660411ef8b96093e013ec31c-20240829
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1496289943; Thu, 29 Aug 2024 20:44:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Aug 2024 20:44:55 +0800
Received: from outbound.mail.protection.outlook.com (172.21.101.237) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Aug 2024 20:44:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJJ/cFDrdE1u7e6KdyTk/LHIQltF6htTpwg6BO2+1p8teC3b+W4JLhEAbOzY6pHYyv8+N0Q1FIxBI6jf1+H5Z+T8kycTMJgRIW4ilrS5h4t6e/q5rz2fboJawSs/8XW2dc8EospvfogQdigUgJ5COviQ3RE2wJIIPCTeVgKCB/7IMBfuvccQ3s6dzINV4Swfwu4xwj/m2y8Ln3uelWcCEm2cuvkf/8S3m357UBKQNxypNPGRYd7Mly01U40fIdkzATAYxDiqVAc//Pan+5C+y5e/vOIJdTPZMwWViHGnLBDGPD25I2Eot9z4wL1roAF8YV9zddhs2Er3VijRXSeQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XVFB3UlOiyYqWggJpnW5oaT/q3MPrtrKztdF+PffmM=;
 b=MrXDhGTV+L2L1auzhHPuu+qX9hYKIcFtlccDee1nEqwqGkOoePQoBuKWLPEYzUUZ82xbS6s+yLMUUSOJiFZFT+m8M6DX1UeZLtxE599NWMGQt6z0qD5Azo+hOfXR4zktOnLdirmUOV/8CxOjb7qnYRdEU2Gpxek7fljJ8NWf66iipcV0BvQcpybxlpxn/QBYKvFvAf6/BWwxaIq/9NzW4JdyOfaJC/l27KjxzqN+KU90G90FPvNeK7fi5I3IQXuAG8B8gOVQLzT8/Y/rLxkwz0Jv9gEKceY33bOwxLEN5qFDD3c/W012Rd/2vFYQW5jd1jhKXPY3jF22UARMbGLgxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XVFB3UlOiyYqWggJpnW5oaT/q3MPrtrKztdF+PffmM=;
 b=MGsPq18KRoouz2s9LdcZIfxClwd9E40jnmts1dsZ1mUhCrMBQ6zuayZ8xkLMXfvzQOwHkAfoxFrqgsHwRu1iND6IDxS3ebCTsMBhh0F/1fdFv/nuIq7H45pFmwIO3FWM6sVF2DgWLJ/K7WFroq3dxRJqkHhtIlDCGDaB4MWFk/8=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by TYZPR03MB7710.apcprd03.prod.outlook.com (2603:1096:400:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 12:44:54 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350%6]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 12:44:53 +0000
From: =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>
To: "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuniyu@amazon.com" <kuniyu@amazon.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "ast@kernel.org" <ast@kernel.org>,
	=?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>,
	=?utf-8?B?Q2hlbi1ZYW8gQ2hhbmcgKOW8teemjuiAgCk=?=
	<Chen-Yao.Chang@mediatek.com>, wsd_upstream <wsd_upstream@mediatek.com>,
	"andrii@kernel.org" <andrii@kernel.org>,
	=?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?=
	<Tze-nan.Wu@mediatek.com>, "song@kernel.org" <song@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	=?utf-8?B?WWFuZ2h1aSBMaSAo5p2O6Ziz6L6JKQ==?= <Yanghui.Li@mediatek.com>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "haoluo@google.com" <haoluo@google.com>
Subject: Re: [PATCH net v4] bpf, net: Check cgroup_bpf_enabled() only once in
 do_sock_getsockopt()
Thread-Topic: [PATCH net v4] bpf, net: Check cgroup_bpf_enabled() only once in
 do_sock_getsockopt()
Thread-Index: AQHa86zl7g+mrFIyrk6Wt5BoZjlturIyMyMAgABovYCAAD8fAIAAln+AgAI68gCACI6xAA==
Date: Thu, 29 Aug 2024 12:44:53 +0000
Message-ID: <2efb1f4751fa47380d51ce538253983974a4947c.camel@mediatek.com>
References: <20240821093016.2533-1-Tze-nan.Wu@mediatek.com>
	 <CAADnVQLLN9hbQ8FQnX_uWFAVBd7L9HhsQpQymLOmB-dHFR4VRw@mail.gmail.com>
	 <3a7864f69b8c1d45a3fe8cda1b1e7a7c85ac9aee.camel@mediatek.com>
	 <49d74e2c74e0e1786b976c0b12cb1cdd680c5f58.camel@mediatek.com>
	 <CAADnVQLvbMRvCg2disV+_AR-154BwRpeB8Zg_8YpO=7gzL=Trg@mail.gmail.com>
	 <Zsk_lGsZBBqbesqS@mini-arch>
In-Reply-To: <Zsk_lGsZBBqbesqS@mini-arch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|TYZPR03MB7710:EE_
x-ms-office365-filtering-correlation-id: 12c277dd-44f7-4273-2b88-08dcc828613c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q00wa2Z6eUcrbFFpbUVVUkRvZnBMT0k3akxuRWZyNEp1WVZMTUJINENJUHhh?=
 =?utf-8?B?OElSSFBXL1ZwS1lkRUNnb1pNdHROYml1UDVNcU5qK05UMGJ1TEI5aHFvdUhQ?=
 =?utf-8?B?TlQzNWIwc3g3SjdWSk5CT25QeHIvTGtMdkpCZm9oa2U4ckZIeGUvaEhKQXpL?=
 =?utf-8?B?S0FDUXlHWWsvL2kveHhiNDNyYmVoYlVJSU81M1lIaFFhdEEvNmdVM3g1b0Nl?=
 =?utf-8?B?TzdOWThUakpHaVYzNHhOK21GODNIMEtGaFhuZkFzbzJYdDNlT0Yycy8rMk1k?=
 =?utf-8?B?c01EaU1Jak4xQ1U3bnB5bHNKdUVrK1hJellTVkNpODN4UlRBTW1kdFQ4Q3p2?=
 =?utf-8?B?OHdCZTV5azhVMHdSRFZjK2lsKzZpSkg0R29nMFN2RmlvR1pxVFBHdmJ3SzU5?=
 =?utf-8?B?a1VaNmdKbEd1SjRVZlB1eWo4K1prTlAwVGVmNDBEVmoveVA5Z2Y3TG5DVm1K?=
 =?utf-8?B?L0pENVVhRkpHYy94emc2czZ0akh4ZEVibFozbU1BZTdyU0FUU1IweUdySGVl?=
 =?utf-8?B?VVBQTnZwMHdRL3Q4WmpNSkcwTkJ6UFdHYUdycG5wZjhwdURCb1lRWEhSU0tv?=
 =?utf-8?B?MFRSM3hCQ0NGaFpkQWh2akpPSWs5WmJ1L2sxMmV6M2VGK1lxdVYyUWZHN2g0?=
 =?utf-8?B?SmRBdE9UWkp4REU3VmE2MFhuZFVHQnVJV2RjMzQ5UVNuNTRWdlNyYWhLZVAr?=
 =?utf-8?B?VExtMVA4c2NYMlVMZGFXbGhKWkhqMkpsM0N6dFl0b3AvaURlTVdReXRIM2lP?=
 =?utf-8?B?UlRqdERLMUk4QWtESWtPa2RrVGdVTGFCT29TbXRQQis3WXpWVndzZXpiTmRM?=
 =?utf-8?B?MlFTeGFpT1hHeXI3ZlM5ZGQweXIrQzBhK1ZrUDE1Ni85ZFArMlJ5VmFwZ01h?=
 =?utf-8?B?OGZ6Zi9wdEp6YitGbFRTTCt1YzdIVEtMV2Qrd25GOWRId3RldE5Cc1hTYXQz?=
 =?utf-8?B?Zk0wQS93cUpKd2taYkk4c3UreUQyZFlGSWJOMFc0cWZ4SFg2WktIV2U5S1kw?=
 =?utf-8?B?dFdmOGNvVm5nZERXUXJSVHRVZE9SSVdCaUx6NzhPcHBOcCtCVkpwU0RTRm1k?=
 =?utf-8?B?NHU0cmI4SG5QakJ1SytGN2FkeEtpU09QMXRicTBOUmRTc0xDQzJUeTFOK3Jh?=
 =?utf-8?B?dUdLaDhWd3RXYmZvMUNNU3IyM3I5L0RtV0tDbGVPWnpYT1NueEtNb0ZjM2JV?=
 =?utf-8?B?NE9jaC9nVFpqcFo1eGMrWFdWb2o0VHhkbEppNnBBM0ZrbE01R2RLS3NlMzl6?=
 =?utf-8?B?Yzk5Z1ZVcUdWK2hBQk41ZWhsMVVWU3pVeHJFN056Qzg5MXhobGlZczAzNTAx?=
 =?utf-8?B?ekJrbmFPUXU4WnFrd1dvcW5iZzhsWDJzbTIxcUFlR0xwMm92LzRodzl1UkpB?=
 =?utf-8?B?S1poUXJleVdvblhRNGFBS3FaT0ZBK1ZuSDBoMzN5Z1NNUU85WFVmV2ZDSlBh?=
 =?utf-8?B?dFZOTnJkbFErViszNWFubTB4WXdDOEtyYnVyajh4ejNxZnJkckdQdG9taVVq?=
 =?utf-8?B?TGk1U210bFA5eDZSMWZKLzA4bGNPZkwwV2JraHpHblhjdSsxVnhLVWlvUnNl?=
 =?utf-8?B?Y0U2b1dGb2NiWE52eDVjTy9WZjBaYkRyZDdVeTlzTXVreXhYRFhaVVdvdmdP?=
 =?utf-8?B?cDJpb3piTTZVd0YwM2xBQkxFM0VnNXdjWnd6OHBwNUEvdGx4cGd3Z3hlVC9X?=
 =?utf-8?B?OGQzVC9ldVFCSlFsbFlNNytLb3JkcU9ZN0thR2RFeEFRZnFGdTNkQmVIZFZL?=
 =?utf-8?B?b3RocTRsVmZTcEpTTGVtUUEwdHNOS3I0QmNMOEw1RWtobmkxNWJFY0ZlUG11?=
 =?utf-8?B?QWxpNVVOZ1JNaDVKMkx1VGFwZUJTemlHVWx3R2NHQ0JBSFl2VkpaNGUrVllt?=
 =?utf-8?B?eVdKTFpnbHNydGNIRTdjYWRBMS9pYjZwVjBNU2JzcGRDREE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUFiVTdpb0xRQlN1TmNDS1VpUXp2cmZScTV2YWNuSnVRcENZV1lhT0dkRUVX?=
 =?utf-8?B?SFJtN3ZROXN5WWFqVVk0bDNlalhScTJMNzVHT3Q4dFRsWm5Xb3M3RE5xeVJF?=
 =?utf-8?B?MEhvd1FWMnRUWWg1Z2tNbHh5ZjNnLzJXRUJ3YmRicy9JWDhKN1phc2ZwV0ZS?=
 =?utf-8?B?WTQ2bzlqWHZuYm5EdVZ2RXFIakZTYjc0WldXVUhQaCsxMEZ1VThuWlJxbkI2?=
 =?utf-8?B?cmJZQks0TEJ3TThqSFVZTGgvYkFWcmxwUW5XRWJRODBTeFRVWSs5ZWJiR2R5?=
 =?utf-8?B?QjVYbkhnRHRKN2VRM1F0djNzclBnQjR4c0pEUVhYVldqcFJvbHlXUVA0QU80?=
 =?utf-8?B?WWxpdU9sZ3ladFdPcGkrbFFlc1dISmtRemJ6NkpSaHJoZFFveElIaEVxYXdo?=
 =?utf-8?B?UjhoKzQyK0RjRXBCaUo3VjRaSWFKdy9kdGs3OGdYWG5MRDZ1eXZxMzBtYndK?=
 =?utf-8?B?RHhjeW4rVG43eGlyenZ5cElqcVh1YllWMWdDMmVNek5wYVowdzV4a3B6WnlZ?=
 =?utf-8?B?QmlYRERBQkwzRXhYNGE5d3hwMjRmdWZwM3RNMHBQSkwrVlo2Ylc1ZzVpSTlv?=
 =?utf-8?B?ZGdqeGtncU84dSthTWZrWmpSVG8yYzh6R0NNTXBGVkJZZVUvbDJDVDBiQ1FT?=
 =?utf-8?B?a3NnNXBrak90YUVaNkJ6dm5XSHI2Z01ON2wrNmR5enU5YjVPRVhXMTZLSkpG?=
 =?utf-8?B?Z2hNM1RhVmhOanh3M09QR05WSjgwaVdBd3NENUR4OVJRclRWZDZneFVpbXlv?=
 =?utf-8?B?bmFIdldsbHZlSFZlbU1uZWdwdE5LVHozQkJxM2VQVFZ4Sm1SM01aSG1ZZW96?=
 =?utf-8?B?dEpBL2RSNllmTXpvSFpycjhRSm1vbkJHdUFYSWtFckllWEwxWFlkdUhjS0tn?=
 =?utf-8?B?YTNOalBVS2daNWdjaHNKLzhpQlNzNThRMGM1c2lGUkhWVTZta3JvZE00L2Qw?=
 =?utf-8?B?UDNHVHo1bFBhcXovR01wK1NmazNScm9qUm9WZDhGSDlqSXJwcmxBNDRld1BM?=
 =?utf-8?B?VVdLUHBDeTlwQmoyNW1xeGhYSHFpU051Q0F0aUR1aElpYURrSFhTOHlNOXZJ?=
 =?utf-8?B?UFUzQnRTK3krb01kZm8yNmphOWg4U2NFTEVVWXhUYkRDNDdsa1BvZElHcHJJ?=
 =?utf-8?B?eFhjNW1BUERON2cwb1ZlUkZCYWl1aHhoYlYzWWR6YkV6K2lSQlBCeld1VHBn?=
 =?utf-8?B?Q3pzd3U5K05yQXFoK09ueEI0c3pJYjgzeG4zQ0Vlb2liQWZqNVdpWVlVTDlK?=
 =?utf-8?B?QzhLT2JlSFN2cmYvZk1yRGlBRVkyUDRLVCtML2VLQzhqdzgzUUhSeDFhUktI?=
 =?utf-8?B?V0I5U1J6QWphMFV6V2g2WlMxenJmbVVNZU9YUmd3QVBZVFBwcktGZE9OZTVm?=
 =?utf-8?B?SUR0VjNqc05NN0taNFRmckZsKzBkdm8rQnduSVNMeFZzaUFGTkNrbXNnSml1?=
 =?utf-8?B?RXJhNVBqRWV4OXEyTkdSOEJQVmVQNnkzQmpFRnhTY1ZGb204ak1JbngvOWxi?=
 =?utf-8?B?bFV3dWVRcEVzSEpadUtoM1ZFcnlxQVg4SDdRVW9JQTVsUGorTStrU2NORVpv?=
 =?utf-8?B?TE1XTjFrWHJ5b0VXUHdlRzFnK2tSNzdNT1NNRVhDZXoySjNGWXBZMTRXTk5Q?=
 =?utf-8?B?NnVMQUtjb1RlODcrVWFGWkdWbUtOK2thcjd1L1VwZ1pFZG90YkNPaE5LQmEv?=
 =?utf-8?B?bUlGT2MwRnR6Q0NUYWVkcFNNems3a0Qyd0JsSDcwaFd5ZkxNRElDaGU3WGUz?=
 =?utf-8?B?Q254UW9nclBKa3hQTmcxc2RTQmhmZkY3R1E2QUZWb01UWnNzNFdPK1BUcjlI?=
 =?utf-8?B?andZb0cvYW8wbmJZdHJYTWFsNHpNRlJSbGlBVk9lWFRET2JGZmY0MEhkRlVB?=
 =?utf-8?B?cVRwSXhxNVovY25PMk9WdmpQVG1wM1NZazJDZEFoYS93ZE5QSzFZc0g2bExQ?=
 =?utf-8?B?bXBRTU1uL3RNUnQzUjdSczEvV0tXNS9wMUxIN0NEc05SaDNMbkdMd1pDcDFt?=
 =?utf-8?B?WnZGVXEvQkpoU2JDRk0zajFqMjRmYk9SdDhSSFZXejBaYWo4TU1uTUUrU1FV?=
 =?utf-8?B?OWNsRTRZTk5TQUxUYVJNQmNZL0NWeTd4YkdyTnh6OVE0L3paeEtYM25vblBQ?=
 =?utf-8?B?TE9ETEVlWUUwRnVRRnZxcVYyYTVlelA3eU80OXpSWVpOdlFEY3oxVWFUdysy?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <990D119997F5484D983FBFAC87B0A58C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c277dd-44f7-4273-2b88-08dcc828613c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 12:44:53.4846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oFIKRfCW46jqoIKyrrDuZ0G1ujvlfvlZ2lBlBoP4iapVrQ469TQ7eIPQ9kF0T/5FrYd2fsRS5f7eWtI0SJv5DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7710
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--22.408700-8.000000
X-TMASE-MatchedRID: 2SDSohiwfqTUL3YCMmnG4omfV7NNMGm+jLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2mlaAItiONP0oUVkB7ifJnjRCaZSKE/OsnJl
	qVKcsJUi1TTIVILM8RChmYyu6geynNPuuZyc2/WwLPVZHwod7gEyQ5fRSh265XzOTBCnSSg/4eY
	E/JF5KDCo+fEJV5lZoXDpuICCRgHXAeiySQKxqSTOb4QjG+dWPmWGJLfJ2t7fqwJRCt4u1yK+O3
	p9xFzgD6I6PCD+I41xH210kirEiHqn4NN7RsxjJFDuTLTe6zcNyawdArtww51HpIy6wt5UwozbV
	LsJ08Hn9SAPTKpsFeHVYxiwxDQDxV6XnY1k71daeAiCmPx4NwMFrpUbb72MU1kTfEkyaZdz6C0e
	Ps7A07QKmARN5PTKc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.408700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F18362EB48C4EF85ACE0B43CD7EEC1E0CF199E869A7DFF09261C9CA7FABC66A92000:8

T24gRnJpLCAyMDI0LTA4LTIzIGF0IDE5OjA0IC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVy
IG9yIHRoZSBjb250ZW50Lg0KPiAgT24gMDgvMjIsIEFsZXhlaSBTdGFyb3ZvaXRvdiB3cm90ZToN
Cj4gPiBPbiBUaHUsIEF1ZyAyMiwgMjAyNCBhdCAxMjowMuKAr0FNIFR6ZS1uYW4gV3UgKOWQs+a+
pOWNlykNCj4gPiA8VHplLW5hbi5XdUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+
DQo+ID4gPiBCVFcsIElmIHRoaXMgc2hvdWxkIGJlIGhhbmRsZWQgaW4ga2VybmVsLCBtb2RpZmlj
YXRpb24gc2hvd24NCj4gYmVsb3cNCj4gPiA+IGNvdWxkIGZpeCB0aGUgaXNzdWUgd2l0aG91dCBi
cmVha2luZyB0aGUgInN0YXRpY19icmFuY2giIHVzYWdlIGluDQo+IGJvdGgNCj4gPiA+IG1hY3Jv
czoNCj4gPiA+DQo+ID4gPg0KPiA+ID4gKysrIC9pbmNsdWRlL2xpbnV4L2JwZi1jZ3JvdXAuaDoN
Cj4gPiA+ICAgICAtI2RlZmluZSBCUEZfQ0dST1VQX0dFVFNPQ0tPUFRfTUFYX09QVExFTihvcHRs
ZW4pDQo+ID4gPiAgICAgKyNkZWZpbmUgQlBGX0NHUk9VUF9HRVRTT0NLT1BUX01BWF9PUFRMRU4o
b3B0bGVuLCBjb21wYXQpDQo+ID4gPiAgICAgICh7DQo+ID4gPiAgICAgICAgICAgICBpbnQgX19y
ZXQgPSAwOw0KPiA+ID4gICAgICAgICAgICAgaWYgKGNncm91cF9icGZfZW5hYmxlZChDR1JPVVBf
R0VUU09DS09QVCkpDQo+ID4gPiAgICAgICAgICAgICAgICAgY29weV9mcm9tX3NvY2twdHIoJl9f
cmV0LCBvcHRsZW4sIHNpemVvZihpbnQpKTsNCj4gPiA+ICAgICAgKyAgICAgIGVsc2UNCj4gPiA+
ICAgICAgKyAgICAgICAgICAqY29tcGF0ID0gdHJ1ZTsNCj4gPiA+ICAgICAgICAgICAgIF9fcmV0
Ow0KPiA+ID4gICAgICB9KQ0KPiA+ID4NCj4gPiA+ICAgICAjZGVmaW5lIEJQRl9DR1JPVVBfUlVO
X1BST0dfR0VUU09DS09QVChzb2NrLCBsZXZlbCwgb3B0bmFtZSwNCj4gPiA+IG9wdHZhbCwgb3B0
bGVuLCBtYXhfb3B0bGVuLCByZXR2YWwpDQo+ID4gPiAgICAgICh7DQo+ID4gPiAgICAgICAgICBp
bnQgX19yZXQgPSByZXR2YWw7DQo+ID4gPiAgICAgLSAgICBpZiAoY2dyb3VwX2JwZl9lbmFibGVk
KENHUk9VUF9HRVRTT0NLT1BUKSAmJg0KPiA+ID4gICAgIC0gICAgICAgIGNncm91cF9icGZfc29j
a19lbmFibGVkKHNvY2ssIENHUk9VUF9HRVRTT0NLT1BUKSkNCj4gPiA+ICAgICArICAgIGlmIChj
Z3JvdXBfYnBmX3NvY2tfZW5hYmxlZChzb2NrLCBDR1JPVVBfR0VUU09DS09QVCkpDQo+ID4gPiAg
ICAgICAgICAgICAgaWYgKCEoc29jayktPnNrX3Byb3QtPmJwZl9ieXBhc3NfZ2V0c29ja29wdCB8
fA0KPiA+ID4gICAgICAgICAgICAgICAgLi4uDQo+ID4gPg0KPiA+ID4gICArKysgL25ldC9zb2Nr
ZXQuYzoNCj4gPiA+ICAgICBpbnQgZG9fc29ja19nZXRzb2Nrb3B0KHN0cnVjdCBzb2NrZXQgKnNv
Y2ssIGJvb2wgY29tcGF0LCBpbnQNCj4gbGV2ZWwsDQo+ID4gPiAgICAgIHsNCj4gPiA+ICAgICAg
ICAgLi4uDQo+ID4gPiAgICAgICAgIC4uLg0KPiA+ID4gICAgICsgICAgIC8qIFRoZSBtZWFuaW5n
IG9mIGBjb21wYXRgIHZhcmlhYmxlIGNvdWxkIGJlIGNoYW5nZWQNCj4gaGVyZQ0KPiA+ID4gICAg
ICsgICAgICAqIHRvIGluZGljYXRlIGlmIGNncm91cF9icGZfZW5hYmxlZChDR1JPVVBfU09DS19P
UFMpDQo+IGlzDQo+ID4gPiBmYWxzZS4NCj4gPiA+ICAgICArICAgICAgKi8NCj4gPiA+ICAgICAg
ICAgaWYgKCFjb21wYXQpDQo+ID4gPiAgICAgLSAgICAgICBtYXhfb3B0bGVuID0NCj4gQlBGX0NH
Uk9VUF9HRVRTT0NLT1BUX01BWF9PUFRMRU4ob3B0bGVuKTsNCj4gPiA+ICAgICArICAgICAgIG1h
eF9vcHRsZW4gPSBCUEZfQ0dST1VQX0dFVFNPQ0tPUFRfTUFYX09QVExFTihvcHRsZW4sDQo+ID4g
PiAmY29tcGF0KTsNCj4gPiANCj4gPiBUaGlzIGlzIGJldHRlciwgYnV0IGl0J3Mgc3RpbGwgcXVp
dGUgYSBoYWNrLiBMZXQncyBub3Qgb3ZlcnJpZGUgaXQuDQo+ID4gV2UgY2FuIGhhdmUgYW5vdGhl
ciBib29sLCBidXQgdGhlIHF1ZXN0aW9uOg0KPiA+IGRvIHdlIHJlYWxseSBuZWVkIEJQRl9DR1JP
VVBfR0VUU09DS09QVF9NQVhfT1BUTEVOICA/DQo+ID4gY29weV9mcm9tX3NvY2twdHIoJl9fcmV0
LCBvcHRsZW4sIHNpemVvZihpbnQpKTsNCj4gPiBzaG91bGQgYmUgZmFzdCBlbm91Z2ggdG8gZG8g
aXQgdW5jb25kaXRpb25hbGx5Lg0KPiA+IFdoYXQgYXJlIHdlIHNhdmluZyBoZXJlPw0KPiA+IA0K
PiA+IFN0YW4gPw0KPiANCj4gQWdyZWVkLCBtb3N0IGxpa2VseSBub2JvZHkgd291bGQgbm90aWNl
IDotKQ0KDQpTb3JyeSBmb3IgbXkgbGF0ZSByZXBseSwganVzdCBoYXZlIHRoZSBtYWlsZXIgZml4
ZWQuDQoNCklmIGl0IGlzIGZlYXNpYmxlIHRvIG1ha2UgdGhlIGBjb3B5X2Zyb21fc29ja3B0cmAg
dW5jb25kaXRpb25hbGx5LA0Kc2hvdWxkIEkgc3VibWl0IGEgbmV3IHBhdGNoIHRoYXQgcmVzb2x2
ZSB0aGUgaXNzdWUgYnkgcmVtb3ZpbmcNCmBCUEZfQ0dST1VQX0dFVFNPQ0tPUFRfTUFYX09QVExF
TmA/IFBhdGNoIEEgc2hvd24gYXMgYmVsb3cuDQoNCiAgKysrIC9uZXQvc29ja2V0LmM6DQogICBp
bnQgZG9fc29ja19nZXRzb2Nrb3B0KC4uLikNCiAgIHsNCiAgLSAgICAgaW50IG1heF9vcHRsZW4g
X19tYXliZV91bnVzZWQ7DQogICsgICAgIGludCBtYXhfb3B0bGVuIF9fbWF5YmVfdW51c2VkID0g
MDsNCiAgICAgICAgY29uc3Qgc3RydWN0IHByb3RvX29wcyAqb3BzOw0KICAgICAgICBpbnQgZXJy
Ow0KICAuLi4NCiAgLi4uDQogICAgICAgIGlmICghY29tcGF0KSA8PT0gd29uZGVyIGlmIHdlIHNo
b3VsZCBrZWVwIHRoZSBjb25kaXRpb24gaGVyZT8NCiAgLSAgICAgICAgIG1heF9vcHRsZW4gPSBC
UEZfQ0dST1VQX0dFVFNPQ0tPUFRfTUFYX09QVExFTihvcHRsZW4pOw0KICArICAgICAgICAgY29w
eV9mcm9tX3NvY2twdHIoJm1heF9vcHRsZW4sIG9wdGxlbiwgc2l6ZW9mKGludCkpOw0KDQogICAg
ICAgIG9wcyA9IFJFQURfT05DRShzb2NrLT5vcHMpOw0KICAgICAgICBpZiAobGV2ZWwgPT0gU09M
X1NPQ0tFVCkgew0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0K
T3IgcGVyaGFwcyBhZGRpbmcgYW5vdGhlciB2YXJpYWJsZSAiZW5hYmxlZCIgaXMgdGhlIHByZWZl
cmFibGUgd2F5Pw0KQXMgaXQga2VlcHMgdGhlIHN0YXRpY19icmFuY2ggYmVoYXZpb3IuDQpQYXRj
aCBCIHNob3duIGFzIGJlbG93Og0KDQogICsrKyAvaW5jbHVkZS9saW51eC9icGYtY2dyb3VwLmg6
DQogIC0jZGVmaW5lIEJQRl9DR1JPVVBfR0VUU09DS09QVF9NQVhfT1BUTEVOKG9wdGxlbikNCiAg
KyNkZWZpbmUgQlBGX0NHUk9VUF9HRVRTT0NLT1BUX01BWF9PUFRMRU4ob3B0bGVuLCBlbmFibGVk
KQ0KICAgKHsNCiAgICAgICAgaW50IF9fcmV0ID0gMDsNCiAgICAgICAgaWYgKGNncm91cF9icGZf
ZW5hYmxlZChDR1JPVVBfR0VUU09DS09QVCkpDQogICAgICAgICAgICBjb3B5X2Zyb21fc29ja3B0
cigmX19yZXQsIG9wdGxlbiwgc2l6ZW9mKGludCkpOw0KICArICAgICBlbHNlDQogICsgICAgICAg
ICAqZW5hYmxlZCA9IGZhbHNlOw0KICAgICAgICBfX3JldDsNCiAgIH0pDQoNCiAgKysrIC9uZXQv
c29ja2V0LmM6DQogICBpbnQgZG9fc29ja19nZXRzb2Nrb3B0KC4uLikNCiAgIHsNCiAgKyAgIGJv
b2wgZW5hYmxlZCBfX21heWJlX3VudXNlZCA9ICFjb21wYXQ7DQogICAgICBpbnQgbWF4X29wdGxl
biBfX21heWJlX3VudXNlZDsNCiAgICAgIGNvbnN0IHN0cnVjdCBwcm90b19vcHMgKm9wczsNCiAg
ICAgIGludCBlcnI7DQogICAgICBpZiAoIWNvbXBhdCkNCiAgLSAgICAgICBtYXhfb3B0bGVuID0g
QlBGX0NHUk9VUF9HRVRTT0NLT1BUX01BWF9PUFRMRU4ob3B0bGVuKTsNCiAgKyAgICAgICBtYXhf
b3B0bGVuID0gQlBGX0NHUk9VUF9HRVRTT0NLT1BUX01BWF9PUFRMRU4ob3B0bGVuLA0KJmVuYWJs
ZWQpOw0KDQogICAgICBvcHMgPSBSRUFEX09OQ0Uoc29jay0+b3BzKTsNCiAgICAgIC4uLg0KICAg
ICAgLi4uDQogIC0gICBpZiAoIWNvbXBhdCkNCiAgKyAgIGlmIChlbmFibGVkKQ0KICAgICAgICAg
IGVyciA9IEJQRl9DR1JPVVBfUlVOX1BST0dfR0VUU09DS09QVCguLi4pOw0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KQW55IGNvbW1lbnRzIHdvdWxkIGJlIGFw
cHJlY2lhdGVkLg0KLS1UemUtbmFuDQoNCg==

