Return-Path: <bpf+bounces-37815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C02295ABC9
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 05:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFBA1F267C9
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 03:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BAE1CD2B;
	Thu, 22 Aug 2024 03:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WbAp0JgA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="k4ijec4r"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFF022F1C;
	Thu, 22 Aug 2024 03:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724296581; cv=fail; b=Mlc2U2Affz0mdFx0SxhRXfNfcSVsji/mWWVND1q6njq74aq5TD468Fv9tRBCx/oiueAytQeGQILi7q786zYdQER0UTqoMxpMJgiYkFfUVc32vIo4+SYq1gnAeud7w+EEJ4kXIW7eLTFN4WTj1U2rSomWC1um8xiEXfckOUZhNSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724296581; c=relaxed/simple;
	bh=kQBBTAf0+jgZ+AoTRTCOZeMGN9FqdY3+UhXPaks7p1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JXu1KwYWVhlOfDMgU3vpZ07aqB/kxherj+JHv5FSwlHZabi3VUH59jVmWUExCbYeMTQvtxaKt9qzGzlzfp+nElFxhiRANDNEvFwHZlIQobKvx/X7t4j9VVA+Ir/Hl0zEwcn7r0UV0or3VFBdAVZyo2j472f7qnc2iKwjSqJXKk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WbAp0JgA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=k4ijec4r; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: df7f2924603411ef8593d301e5c8a9c0-20240822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kQBBTAf0+jgZ+AoTRTCOZeMGN9FqdY3+UhXPaks7p1M=;
	b=WbAp0JgA/Pqun6eduNkGlZlsVXZgSSCLty6fDWMjgtTWkkFhH9TLD/oV3bauk/1hZjECGAhk7+M2qtRzkcsgqF6cRfAT85ip5zzgLs7iK7FmHG0FIDJA7EdMYs6POSromST6ivmXqtPKe+m0iTRE/X/z6BEYMbXMbHn8KMfO7MY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:222f26fb-ef74-41a7-a1f5-8ffb13d04ff1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:8e45fcce-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: df7f2924603411ef8593d301e5c8a9c0-20240822
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1581844094; Thu, 22 Aug 2024 11:16:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 22 Aug 2024 11:16:05 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 22 Aug 2024 11:16:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BM9eIVuI8SWdP5lPg1yruhObwQEVAiJiJUEwT+1NV+b5dZahccCLBJ0IjCLE9bQ+VVoY5GsS5usOzY3oXCqWBIG5BphxTfdXqa2KNQ1eLUEmN92sQR8gwRsTP3LvBQXaHDseu5dXSX52Cn6Ztsx6n/sYxzOFYf3pv+Xrv1xyfi8n0RIEGGu6EMjaRLq6pAnbf5cRPLw5WhhcTImPDbzXTPw5KKEuR5J787C5UobRAJnxm9YonhseiebwvPCDLaQ7Ye8GizWvFWa5hMhJZOoMj7QnEEXNsv6+ovwEuL1s6RjdAl25+KMID9VqHwN0+JNGKeyoTeC+KbXx1s+r3Hxdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQBBTAf0+jgZ+AoTRTCOZeMGN9FqdY3+UhXPaks7p1M=;
 b=YQlJUBzjnA/YF9jrsVbBi8nGJuc1pznrhZSDBbs+MRhAWoiEyIh/76m4EoFFhTYn3jWSaMyFQUKG/ij1APcvN5FWPeUxnvJVtZmz5dGsLnpCxkZU+4BgKZGVecEUOM2RdhX9C/RzM9U6JOkQrEZZnKss1avIGgohL0KiqXgVNVxuR5PIH4lr3VwldIF0CZr8L8CNUHr4D4gE+Wdbd6P/ftVdqk3+vlOnU9P8APRtN4pHjCvb9HrUp662tflIo0Ev/7meye8Lt5Ye3zL63m/yhkrKip2x7wpuZSMxBscDKGMBncUc4CIHHF8ix7GY3pdRQBuY1UlnBTH2v+n9dxlWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQBBTAf0+jgZ+AoTRTCOZeMGN9FqdY3+UhXPaks7p1M=;
 b=k4ijec4r96IOEWGfG7bSeEZEpiSe65ylhQnkFUPzMKvNGZ+yoKyzU5olRrKIN9TJQCXRACsCFhO1a/f6vR8P1f81Bg350T0BmbGRTuH+eLnWeL3AUtBHQlSWtNuzE498ilB9Dl1bXmHxnod52BQkBiWa+ATQqZedebxnq18PF80=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by TYZPR03MB6574.apcprd03.prod.outlook.com (2603:1096:400:1fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 03:16:03 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350%6]) with mapi id 15.20.7849.018; Thu, 22 Aug 2024
 03:16:02 +0000
From: =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>
To: "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"kuniyu@amazon.com" <kuniyu@amazon.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "ast@kernel.org" <ast@kernel.org>,
	=?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>, wsd_upstream <wsd_upstream@mediatek.com>,
	"andrii@kernel.org" <andrii@kernel.org>,
	=?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>, =?utf-8?B?WWFuZ2h1aSBMaSAo5p2O6Ziz6L6JKQ==?=
	<Yanghui.Li@mediatek.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "haoluo@google.com" <haoluo@google.com>
Subject: Re: [PATCH net v4] bpf, net: Check cgroup_bpf_enabled() only once in
 do_sock_getsockopt()
Thread-Topic: [PATCH net v4] bpf, net: Check cgroup_bpf_enabled() only once in
 do_sock_getsockopt()
Thread-Index: AQHa86zl7g+mrFIyrk6Wt5BoZjlturIyMyMAgABovYA=
Date: Thu, 22 Aug 2024 03:16:02 +0000
Message-ID: <3a7864f69b8c1d45a3fe8cda1b1e7a7c85ac9aee.camel@mediatek.com>
References: <20240821093016.2533-1-Tze-nan.Wu@mediatek.com>
	 <CAADnVQLLN9hbQ8FQnX_uWFAVBd7L9HhsQpQymLOmB-dHFR4VRw@mail.gmail.com>
In-Reply-To: <CAADnVQLLN9hbQ8FQnX_uWFAVBd7L9HhsQpQymLOmB-dHFR4VRw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|TYZPR03MB6574:EE_
x-ms-office365-filtering-correlation-id: 2c866057-eba1-45a1-1e3d-08dcc258c0d7
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q2FudzZxNU9nOERXbzg2OUtCK09sUVN6M1UzRVFCOEx6ZkRNdGh0Rm0rTWhx?=
 =?utf-8?B?NnYvaVFacG1ETmxUakFmRTBkdnJWVHZJZTk5YXlTb2hzdk1nRnlhRyt3My82?=
 =?utf-8?B?MFZ1bnhvT0d4L0RuUHQ1L1JGb0dZV1J3U1Q5cW1DL3AyMGFiZzNHL3lucVFl?=
 =?utf-8?B?b254VkQ5SWN3R0tBL2VSelBDYSsvRGl0UDNDT2tQeDFyWVliZ0c3ZGNGelZL?=
 =?utf-8?B?cEJkbzVaZkJjM2dvblc5d0FYM1ZWd28zWCs2Y3EzYXZ5ZTZNYmlRU2FtdGgv?=
 =?utf-8?B?bTI2OGFqcjh6KzJWUTVDL0ZZRTZHZzFwemVsZlc5akcyWFE2dGwvdkxxMUNu?=
 =?utf-8?B?SjlmZHFoQm1HcWlBcGdxNVVycmlCdmpsQk9qSk9pN1h5UFpzNDJXK1JxN0o4?=
 =?utf-8?B?ZnQvcjZ5MVhZNGI3ZHloeUcwZWlPTm5KaWl5SUNlcktTRko2emRVRkxkRjB4?=
 =?utf-8?B?ekNzYmtDMjFVSmFyUWNNZ2Y4c2pGaUhvdUpNS05NVGUxSTZQWHFNM2YwZFBV?=
 =?utf-8?B?cnJwRVJadEtYdWpoNTV1V2VxSVFFME9GWndudzVBZmw3REk2NkdVUkRxeGtT?=
 =?utf-8?B?WFh6YXllZ0graTcwUW4wL0pZQ0J0Q1IzWFR6NjhWZzhoOElOaVQydFhlcGtM?=
 =?utf-8?B?QmVSRzB5R1N4VEpoclVYUTlCVzdObWErVWxYeDBYd05iT0RJVWVnOUkxK1or?=
 =?utf-8?B?VXlmcEtpR3RPWDVIV1JZWDE4dEZKampnbmZDc3R4bTFGWGJaUFI5SkQ4M0Jt?=
 =?utf-8?B?TmNQcXVtOGxHaGlJRUNtNVhaQll4OFlLRWp2bEpCWWtkV3BlRkl0dERjaVhX?=
 =?utf-8?B?c0RRVUFCSDZVVVlVVkk2bjZDdWR2cWtYYmRvK3Z6eFRFbFY1OUVzWkhlVVlU?=
 =?utf-8?B?WjY3dlFEbzMvQ1JzWmFlenJJZVpNT2FPckw1MWNzSFBiR1lnVWI3clBnNFBj?=
 =?utf-8?B?bktaaHg4YnEvT201djdOL3pNR3dNaVZGalc1NVpISjYwN1NaL25RNjI1ZmlB?=
 =?utf-8?B?dGErMVV6SXlHNmNWMFRyTkpNTlZKTlEvU2ZHRnNFSEt1QkNsdmpCd295MFdU?=
 =?utf-8?B?R2hiUWJyT0gwQkQ4Q0ZDQk0rUnhXSkNKbXBHWjlWNkZPTzgxRXgzV20rTHN0?=
 =?utf-8?B?dFJ3RjBkYVBDcEhTRFloSzRtT1piaXdXZWo3RVBvWUYwVDgvVDNEMXhtcUV5?=
 =?utf-8?B?ZnFCNFJUOWlsNGRHK3BFUnE5clhFTDE4a1NtZDhMUHBXVHVqRWFSR0tjVG0w?=
 =?utf-8?B?S1dhWndnaDFtaUVQdk5LZkVtS1pNY3RXTGhVa0F5UldZMzFPYk5IM1ZuWGlI?=
 =?utf-8?B?dkhqclJuYVdKR2dEMUYrU3lCUzMvRktGdjhMcWJIakdjTkpCVGRrd1VWS0hM?=
 =?utf-8?B?eEs0MHhqbi9vRStidjZWUFhUSkNpRDlzVEhhK01HbkRMVTZhVkJtdTFVRFh0?=
 =?utf-8?B?eDJ6QldEUGp1QkJwUnJxQ1NCQk0relgwempKa0FtTXNpbzhHRnFwaGplbmRK?=
 =?utf-8?B?WVA2QzJ3NUl5bi9hTHMxR3E3bGs2cGNNZWlobWU2OStMR0pnSzRQbHJPVmND?=
 =?utf-8?B?TzB5ajlDQXY5a2hkRGFwaXZRaUoxejZLTEtGeXZyS1FNSnRXWkowQ3JKR05Z?=
 =?utf-8?B?c2F1Ymo3NEJBSDhUQ0taaGxHUUpkR1dvS1diL1RYRVBEQnNBc0d4QkhpcEF0?=
 =?utf-8?B?YXZ2b21TZWQ5YXlZK1JEUmNWTWFpZnMyNlIvelcyVFgxQ3AxQ2s3RlIrTjBM?=
 =?utf-8?B?YkxDd2h1WHo2N3NOdkFQRFFGSVg0TmFKZFN1MU1vMHl2REY5TWF0dFErdFk3?=
 =?utf-8?B?RWswOFZxVVpFSG5SbjFyeS92dHV0N1pPRkovVERyU3labVUwcE13T2ErVWlW?=
 =?utf-8?B?c1RLcE8rcnI4RTlvZjU3WE5nYXlBcnBCaWxBMWgyWWlMeWhHMytIeHZTdE5s?=
 =?utf-8?Q?pYDyGluuzMw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzJwZWc5dTFkSzJ4eCtWc1VvcXV6UzQzNVhpOHdleGRJdWowOVpkK3ZSaHRE?=
 =?utf-8?B?YmlLdSswbHFxRGRNWERrMk1ieW1aeHlUd1hPdTIvRXZYeW9hMCszSzZPand5?=
 =?utf-8?B?b2hBdGQ3MDVEcTMxYlNTTHZiMmZ3TnJObHlmWFluSGNzVzdwOElISjcxSzdm?=
 =?utf-8?B?Y1VjWGRmQitic3NKSmk0SXRsR3RLYWJuNWhCbEVmcEFMY0MwK3Bzck5OUUdh?=
 =?utf-8?B?QUZyZ3VaWVJ0VlcvZTl1a0RHRlJpTVdTdWs4SmczNFRlWUcvZ3ptbk0rZkZi?=
 =?utf-8?B?STVydmxFb1J5TUl3MmZhSUFkb3N2SUpqdFc4bWk3WFJ6UWx5MnhubWxHVDQ0?=
 =?utf-8?B?dnZHeTIyQzBZM2szakJCNFl2SEU0QlZnT2dkNTljTEFMbUtVM2xjRVNoeWsx?=
 =?utf-8?B?cGFWbjVlWnViWU54bW9IdHFsL25ZUXQzaGVKUTUwKzk4L1A4OXg1cXFrVFp1?=
 =?utf-8?B?K2YvZDVqRGFEREpPLzBpcHpiOGZZNS9BYVZnc0VJRStUWW5CMEw2SnZZU1hT?=
 =?utf-8?B?S29qRmphUzFRbWZSSXhlUlpJYVZ4em1PenJPSmFQcGg2ZjlCYnl3MTBCaDZa?=
 =?utf-8?B?SkhvT3RoOTVtZFNXUlZrRjZUWFVCUllJWVBERlY2dVlEUVdmOG9ZdG9SL3lK?=
 =?utf-8?B?dlpPZXZRQ1BDWmc1RXMza2p5UUVweWV1ekNNMCtieDNWRTVuYU1qYXlEUkt6?=
 =?utf-8?B?SkxFVGo2WlUwTFZGVTBIa1dUbG9pQmdrMHpneUN3VDNFWmVxMUkrSWt0d0Ri?=
 =?utf-8?B?Wk9YRFdlQXVGM3VlUFhZRWp6QUJYTWptS2VzbFZLdFc2NEpydzdVajNmeEth?=
 =?utf-8?B?clk3NzRCL0FwWEZjOWhxT2V2WGp5YVlMTTlYcEdvTFhGQVFoTENXSEIyQWRz?=
 =?utf-8?B?RWNMYkVEMnIxL0ZtM2JGQkFBVndmMklLT0hHa2hZUXBKa0NRSkg2NW5xVzFT?=
 =?utf-8?B?QlR2Yi9hdCtPUkZRTGFHS0hTc3Q0TVZOUGRRamh3WWxkUUF6WG1zd1FKNDlv?=
 =?utf-8?B?am1MR2VtbHJBeFNvRHR6VkhyUXFaaUFqOU1rcThNTnlZMUtjMk0zelZsZHVO?=
 =?utf-8?B?TXpHa3BHejFrZDZEblVmVEpOMDRFSFZXVlh6Z0Ruem9nZEszK216cDRjL09F?=
 =?utf-8?B?Unp6bFVIcG5EWHlYVHpxV2NHQTVRaDVaMWxmTmYyUnJKT2lyTmViREgyWFYx?=
 =?utf-8?B?eVVWSDhkZXkyZzZKTmY1YklVUGxUa0hEd3cwVTNSU3VpU2dldkVLd3VPekVr?=
 =?utf-8?B?QkJMbVRRNXZCK0tYMG9JeGt2NFVGaVVEMU14ZG0wa2JwTmRaTmIzSXZTNmJ6?=
 =?utf-8?B?NC9qcUNJVlJNQjVWa3Z4NENSR2NBY1hGWWlBUnV6MGpHQkRsRW1tZDY2ZmEw?=
 =?utf-8?B?L1dzUWtwNzBEaWVBdDVjS041V1JicDU0YXhPYUFEQ2NEK2ozeXBmZlJjbHdj?=
 =?utf-8?B?eDE4VWhhV08yQzJSR3V0Y05PYzZ2Y2JFdlVxcWhpV3dLVEZmZEEvSVN6bkdM?=
 =?utf-8?B?SW5JWWtIeVQwdEh6am05RzdWVHRqT2hYYnkrQXRucXZKODUyK2p5ZzB1TVJy?=
 =?utf-8?B?NXE5NDBxcTFzb0ttcmhBTnZOQkg0WGRPaktFUXorQU9LRkxCZGxJVjJ4VTln?=
 =?utf-8?B?U0cwbVJsR1daUWFwelZWa0hnZkkxUVNMTTNpMmZkWjQ1YVhUOS9wN3habDZh?=
 =?utf-8?B?VzhremVsbDhrRDNITHMxUFRyWFk3cHZydURiNzhVUWtUUGl5K0FwMDNkVFVR?=
 =?utf-8?B?a3NrTWwxR0FWczJiL1dIeGYxOXNickpwcUdIL0x4enVaM3VpS2xEYk9iS2ZJ?=
 =?utf-8?B?cEJWNHFuUTVoM3FvaEZYVWNZQTdUMWhBMkNjOWs4djFUNE9aazZYenJqb2tT?=
 =?utf-8?B?dnVhUHNvR24wanY2ckJkNDdFSWJRV1Ewem4wNnc5WnJiSFVCWWZqc0Qyc0ta?=
 =?utf-8?B?a3hIQXhycG4wdC9LS3VNcUF3NDhaT0lKbm5SdEh1alluMkF3Y21QYXNKbCtB?=
 =?utf-8?B?YkZpa25QbTQxMGV6a0M0L2JvTXc1cHhJTzBpWldPNnNYakhlYlh0RnpGaXhn?=
 =?utf-8?B?VCt0azZBWlY3T2JoTm5SU1FJSCtKQ3A0bGc4VEtmamMvSExzOE5FSitYNi93?=
 =?utf-8?B?VHZ1bFB5blhlelV1OElHejJNc3VMUmpoNTQwWDJHdTdTcEpzajVOMXhqcVVu?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF506AB375F9AF4B879BB200B3295180@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c866057-eba1-45a1-1e3d-08dcc258c0d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 03:16:02.7563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5BCk57/qg6MZdVDArBaqWfDZudZstkEzNnWmkY/T5Ne32TbQ36FPx1pLhGxzlgIxE/+ZALA+UR8TwwVALI+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6574
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.541800-8.000000
X-TMASE-MatchedRID: F3kdXSFZYkfUL3YCMmnG4omfV7NNMGm+jLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2mlaAItiONP0hotH7bEpEMrUV4VfJ6SB03k1
	HMnSDPke3ig9YKV6hI2nIi1piCpn3etI/1G0ZlijqsFlQXzLr6EY6jpCj5qWungkhfxvDbJge7J
	C0joaOJ/u5BkITWh5G232LjmYwhKob+BGg6rnrdjPDkSOzeDWW/AZW18vjv1r8rSaNLblw6tLuX
	2hj/M7UWJjiBPpIHST9AoOUQOta/M637+A5hpnFA9lly13c/gHt/okBLaEo+Mlgi/vLS272QbjL
	wHiYPeXbXKItRnj8n2WIzfqX4UJKR0cAoC1UfG0lqaDT/7H7lwrefVId6fzVWltirZ/iPP721IT
	7+uo2GCEn+59qml4SkZOl7WKIImrS77Co4bNJXcC4UUZr4lSF+gD2vYtOFhgqtq5d3cxkNQP90f
	JP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.541800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4E0D654177ABEEB665B88C8DC0EA6259A8520CA87B1D54E0764AF012A86D15792000:8

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDE0OjAxIC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVy
IG9yIHRoZSBjb250ZW50Lg0KPiAgT24gV2VkLCBBdWcgMjEsIDIwMjQgYXQgMjozMOKAr0FNIFR6
ZS1uYW4gV3UgPFR6ZS1uYW4uV3VAbWVkaWF0ZWsuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFRo
ZSByZXR1cm4gdmFsdWUgZnJvbSBgY2dyb3VwX2JwZl9lbmFibGVkKENHUk9VUF9HRVRTT0NLT1BU
KWAgY2FuDQo+IGNoYW5nZQ0KPiA+IGJldHdlZW4gdGhlIGludm9jYXRpb25zIG9mIGBCUEZfQ0dS
T1VQX0dFVFNPQ0tPUFRfTUFYX09QVExFTmAgYW5kDQo+ID4gYEJQRl9DR1JPVVBfUlVOX1BST0df
R0VUU09DS09QVGAuDQo+ID4NCj4gPiBJZiBgY2dyb3VwX2JwZl9lbmFibGVkKENHUk9VUF9HRVRT
T0NLT1BUKWAgY2hhbmdlcyBmcm9tICJmYWxzZSIgdG8NCj4gPiAidHJ1ZSIgYmV0d2VlbiB0aGUg
aW52b2NhdGlvbnMgb2YNCj4gYEJQRl9DR1JPVVBfR0VUU09DS09QVF9NQVhfT1BUTEVOYCBhbmQN
Cj4gPiBgQlBGX0NHUk9VUF9SVU5fUFJPR19HRVRTT0NLT1BUYCwgYEJQRl9DR1JPVVBfUlVOX1BS
T0dfR0VUU09DS09QVGANCj4gd2lsbA0KPiA+IHJlY2VpdmUgYW4gLUVGQVVMVCBmcm9tDQo+IGBf
X2Nncm91cF9icGZfcnVuX2ZpbHRlcl9nZXRzb2Nrb3B0KG1heF9vcHRsZW49MClgDQo+ID4gZHVl
IHRvIGBnZXRfdXNlcigpYCB3YXMgbm90IHJlYWNoZWQgaW4NCj4gYEJQRl9DR1JPVVBfR0VUU09D
S09QVF9NQVhfT1BUTEVOYC4NCj4gPg0KPiA+IFNjZW5hcmlvIHNob3duIGFzIGJlbG93Og0KPiA+
DQo+ID4gICAgICAgICAgICBgcHJvY2VzcyBBYCAgICAgICAgICAgICAgICAgICAgICBgcHJvY2Vz
cyBCYA0KPiA+ICAgICAgICAgICAgLS0tLS0tLS0tLS0gICAgICAgICAgICAgICAgICAgICAgLS0t
LS0tLS0tLS0tDQo+ID4gICBCUEZfQ0dST1VQX0dFVFNPQ0tPUFRfTUFYX09QVExFTg0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5hYmxlDQo+IENHUk9V
UF9HRVRTT0NLT1BUDQo+ID4gICBCUEZfQ0dST1VQX1JVTl9QUk9HX0dFVFNPQ0tPUFQgKC1FRkFV
TFQpDQo+ID4NCj4gPiBUbyBwcmV2ZW50IHRoaXMsIGludm9rZSBgY2dyb3VwX2JwZl9lbmFibGVk
KClgIG9ubHkgb25jZSBhbmQgY2FjaGUNCj4gdGhlDQo+ID4gcmVzdWx0IGluIGEgbmV3bHkgYWRk
ZWQgbG9jYWwgdmFyaWFibGUgYGVuYWJsZWRgLg0KPiA+IEJvdGggYEJQRl9DR1JPVVBfKmAgbWFj
cm9zIGluIGBkb19zb2NrX2dldHNvY2tvcHRgIHdpbGwgdGhlbiBjaGVjaw0KPiB0aGVpcg0KPiA+
IGNvbmRpdGlvbiB1c2luZyB0aGUgc2FtZSBgZW5hYmxlZGAgdmFyaWFibGUgYXMgdGhlIGNvbmRp
dGlvbg0KPiB2YXJpYWJsZSwNCj4gPiBpbnN0ZWFkIG9mIHVzaW5nIHRoZSByZXR1cm4gdmFsdWVz
IGZyb20gYGNncm91cF9icGZfZW5hYmxlZGAgY2FsbGVkDQo+IGJ5DQo+ID4gdGhlbXNlbHZlcyBh
cyB0aGUgY29uZGl0aW9uIHZhcmlhYmxlKHdoaWNoIGNvdWxkIHlpZWxkIGRpZmZlcmVudA0KPiBy
ZXN1bHRzKS4NCj4gPiBUaGlzIGVuc3VyZXMgdGhhdCBlaXRoZXIgYm90aCBgQlBGX0NHUk9VUF8q
YCBtYWNyb3MgcGFzcyB0aGUNCj4gY29uZGl0aW9uDQo+ID4gb3IgbmVpdGhlciBkb2VzLg0KPiA+
DQo+ID4gRml4ZXM6IDBkMDFkYTZhZmM1NCAoImJwZjogaW1wbGVtZW50IGdldHNvY2tvcHQgYW5k
IHNldHNvY2tvcHQNCj4gaG9va3MiKQ0KPiA+IENvLWRldmVsb3BlZC1ieTogWWFuZ2h1aSBMaSA8
eWFuZ2h1aS5saUBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWFuZ2h1aSBMaSA8
eWFuZ2h1aS5saUBtZWRpYXRlay5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBDaGVuZy1KdWkg
V2FuZyA8Y2hlbmctanVpLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENo
ZW5nLUp1aSBXYW5nIDxjaGVuZy1qdWkud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogVHplLW5hbiBXdSA8VHplLW5hbi5XdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4N
Cj4gPiBDaGFnbmVzIGZyb20gdjEgdG8gdjI6IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyNDA4MTkwODI1MTMuMjcxNzYtMS1UemUtbmFuLld1QG1lZGlhdGVrLmNvbS8NCj4gPiAg
IEluc3RlYWQgb2YgdXNpbmcgY2dyb3VwX2xvY2sgaW4gdGhlIGZhc3RwYXRoLCBpbnZva2UNCj4g
Y2dyb3VwX2JwZl9lbmFibGVkDQo+ID4gICBvbmx5IG9uY2UgYW5kIGNhY2hlIHRoZSB2YWx1ZSBp
biB0aGUgbmV3bHkgYWRkZWQgdmFyaWFibGUNCj4gYGVuYWJsZWRgLg0KPiA+ICAgYEJQRl9DR1JP
VVBfKmAgbWFjcm9zIGluIGRvX3NvY2tfZ2V0c29ja29wdCBjYW4gdGhlbiBib3RoIGNoZWNrDQo+
IHRoZWlyDQo+ID4gICBjb25kaXRpb24gd2l0aCB0aGUgbmV3IHZhcmlhYmxlIGBlbmFibGVgLCBl
bnN1cmluZyB0aGF0IGVpdGhlcg0KPiB0aGV5IGJvdGgNCj4gPiAgIHBhc3NpbmcgdGhlIGNvbmRp
dGlvbiBvciBib3RoIGRvIG5vdC4NCj4gPg0KPiA+IENoYWduZXMgZnJvbSB2MiB0byB2MzogDQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDgxOTE1NTYyNy4xMzY3LTEtVHplLW5h
bi5XdUBtZWRpYXRlay5jb20vDQo+ID4gICBIaWRlIGNncm91cF9icGZfZW5hYmxlZCBpbiB0aGUg
bWFjcm8sIGFuZCBzb21lIG1vZGlmaWNhdGlvbnMgdG8NCj4gYWRhcHQNCj4gPiAgIHRoZSBjb2Rp
bmcgc3R5bGUuDQo+ID4NCj4gPiBDaGFnbmVzIGZyb20gdjMgdG8gdjQ6IA0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyNDA4MjAwOTI5NDIuMTY2NTQtMS1UemUtbmFuLld1QG1lZGlh
dGVrLmNvbS8NCj4gPiAgIEFkZCBicGYgdGFnIHRvIHN1YmplY3QsIGFuZCBGaXhlcyB0YWcgaW4g
Ym9keS4NCj4gPg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2JwZi1jZ3JvdXAuaCB8IDE1
ICsrKysrKysrLS0tLS0tLQ0KPiA+ICBuZXQvc29ja2V0LmMgICAgICAgICAgICAgICB8ICA1ICsr
Ky0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2JwZi1jZ3JvdXAuaCBiL2lu
Y2x1ZGUvbGludXgvYnBmLQ0KPiBjZ3JvdXAuaA0KPiA+IGluZGV4IGZiM2MzZTcxODFlNi4uNWFm
YTJhYzc2YWFlIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvYnBmLWNncm91cC5oDQo+
ID4gKysrIGIvaW5jbHVkZS9saW51eC9icGYtY2dyb3VwLmgNCj4gPiBAQCAtMzkwLDIwICszOTAs
MjAgQEAgc3RhdGljIGlubGluZSBib29sDQo+IGNncm91cF9icGZfc29ja19lbmFibGVkKHN0cnVj
dCBzb2NrICpzaywNCj4gPiAgICAgICAgIF9fcmV0OyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+ICAgICAgICAgICAgIFwNCj4gPiAgfSkNCj4g
Pg0KPiA+IC0jZGVmaW5lDQo+IEJQRl9DR1JPVVBfR0VUU09DS09QVF9NQVhfT1BUTEVOKG9wdGxl
bikgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiAgXA0KPiA+ICsjZGVmaW5lIEJQRl9D
R1JPVVBfR0VUU09DS09QVF9NQVhfT1BUTEVOKG9wdGxlbiwNCj4gZW5hYmxlZCkgICAgICAgICAg
ICAgICAgICAgICBcDQo+ID4gICh7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiAgICAgICAgICAgICBcDQo+ID4gICAgICAg
ICBpbnQgX19yZXQgPQ0KPiAwOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwNCj4gPiAtICAgICAgIGlmDQo+IChjZ3JvdXBfYnBmX2VuYWJs
ZWQoQ0dST1VQX0dFVFNPQ0tPUFQpKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+
ICsgICAgICAgZW5hYmxlZCA9DQo+IGNncm91cF9icGZfZW5hYmxlZChDR1JPVVBfR0VUU09DS09Q
VCk7ICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4gKyAgICAgICBpZiAoZW5hYmxlZCkNCj4g
DQo+IA0KPiBJIHN1c3BlY3QgdGhlIGNvbXBpbGVyIGdlbmVyYXRlcyBzbG93IGNvZGUgYWZ0ZXIg
c3VjaCBhIHBhdGNoLg0KPiBwdy1ib3Q6IGNyDQo+IA0KPiBXaGF0IGlzIHRoZSBwcm9ibGVtIHdp
dGggZG91YmxlIGNncm91cF9icGZfZW5hYmxlZCgpIGNoZWNrPw0KPiB5ZXMgaXQgbWlnaHQgcmV0
dXJuIHR3byBkaWZmZXJlbnQgdmFsdWVzLCBzbz8NCg0KRGVwZW5kaW5nIG9uIHdoZXJlIHRoZSAt
RUZBVUxUIG9jY3VycywgdGhlIHByb2JsZW0gY291bGQgYmUgZGlmZmVyZW50Lg0KSW4gb3VyIGNh
c2UsIHRoZSAtRUZBVUxUIGlzIHJldHVybmVkIGZyb20gZ2V0c29ja29wdCgpIGR1cmluZyBhDQoi
Ym9vdHVwLWNyaXRpY2FsIHByb3BlcnR5IHNldHRpbmciIGZsb3cgaW4gQW5kcm9pZC4gQXMgYSBy
ZXN1bHQsIHRoZQ0KcHJvcGVydHkgc2V0dGluZyBmYWlscyBkdWUgaXQgZ2V0IC1FRkFVTFQgZnJv
bSBnZXRzb2Nrb3B0KCksIGNhdXNpbmcNCnRoZSBkZXZpY2UgdG8gZmFpbCB0aGUgYm9vdCBwcm9j
ZXNzLg0KDQpTaG91bGQgdGhlIHVzZXJzcGFjZSBjYWxsZXIgYWx3YXlzIGFudGljaXBhdGUgYW4g
LUVGQVVMVCBmcm9tDQpnZXRzb2Nrb3B0KCkgaWYgdGhlcmUncyBhbm90aGVyIHByb2Nlc3MgZW5h
YmxlcyBDR1JPVVBfR0VUU09DS09QVA0KKHBvc3NpYmx5IHRocm91Z2ggdGhlIGJwZigpIHN5c2Nh
bGwpIGF0IHRoZSBzYW1lIHRpbWU/DQpJZiB0aGF0J3MgdGhlIGNhc2UsIHRoZW4gSSB3aWxsIGhh
bmRsZSB0aGlzIGluIHVzZXJzcGFjZS4NCg0KVGhhbmtzLA0KLS10emUtbmFuDQo=

