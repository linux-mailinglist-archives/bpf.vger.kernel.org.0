Return-Path: <bpf+bounces-37816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD8A95ABE1
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 05:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE47281A2B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 03:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354EE1CD3F;
	Thu, 22 Aug 2024 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GnBvtkr1";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="U72DhNmX"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2414A84;
	Thu, 22 Aug 2024 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297294; cv=fail; b=nvA88MXnJXwEeGqalHHzxmjl+ZVP0TTBzT6m6cChp+GZDmbZF7B3p/rNzgWCU5GgOKYD4xjh5+Bh4GT9ck+RskDfeBtmfLZPVA+mKgDc8zZM+KW0vRH0JHmWM/yBMajwDU/G3lSJaWkOzlER2fvPV6EB1P/+GZGC9FasefGaeAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297294; c=relaxed/simple;
	bh=12JrjutCDkQrkv0Kh4ybnhRymrMxjiRiTYb5biE5U54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hzKcQGEsrqPNXgTSaOohLLsOn/GuXmSqL3HfJVddeg56AqlNE29oek7DWxwuZLpa9j1iJkatQWtjR95JDy9M7ZtBjBXDaOV1oObFY5UjoXdZRUaO9YAPGHLC6lEMiaT0N7ODr9FGibArqA1DFONs8ZyYt4rdaAy0mUzbeG3VePo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GnBvtkr1; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=U72DhNmX; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 89fe7516603611ef8b96093e013ec31c-20240822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=12JrjutCDkQrkv0Kh4ybnhRymrMxjiRiTYb5biE5U54=;
	b=GnBvtkr1L3uf90HSszILAf4FmngY3w6A2PjfgqwSfiR0Xg0lUxv/zlqOsWeRfdo3+VrKTNgQN9imEOGufhopIT4Lpc5LPy3Oo7Iw7bzY6I2tZ28pPPK0TBtoxo1pcvTU4owfQDmou5v8aSOBRr+f8wNY5kqbe7HQApLrzV1sqIs=;
X-CID-CACHE: Type:Local,Time:202408221116+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:bf6960c5-2a04-4785-ba6c-eb20b3eb27d4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:7498bdbe-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 89fe7516603611ef8b96093e013ec31c-20240822
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 951734761; Thu, 22 Aug 2024 11:28:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 22 Aug 2024 11:28:03 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 22 Aug 2024 11:28:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhQmJDvsP9fk1mrSpV5SPjCLNC7zEeR8pZGO4edz/pCEnYn1QN/7qZWWGilnDp/G9QoqDiO4S6DEEOEOcnE8flCCI6mAezXQb4lRXJx+GbsNcfTvNTEWQF3yeVWAFBb4MXWfcr7rm4Kb7KJoCITZqUyZqOwcurk4b9JKWIc9XIWAwqz6bJkAwlf1U+dSA+D7YE+PDzezVODmmRq9l+V2zOhvNoQ4PenHJK+cDaioojKoIKLwNo6Lx9cwlL5uBvecsbykZW0XmiRhDN8wsl1hWBZc1gzj5EQGgWSLdFmLXs385go/+8OI3AzlYy1BIzbQrxY5nx+LZZD17dHS4hgrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12JrjutCDkQrkv0Kh4ybnhRymrMxjiRiTYb5biE5U54=;
 b=PZBD80u4XjTWD9OErby1siEiHCUR1uz0Qt3OFdtDGKi5SUYBrO0KcP5wMs0lOyTWBUoXrcQW/GI0A12Wp4Nyl/Yjd+CBSXLsIycs/Z3R0YLIj3DbooMvSaKBdwEnQENAd1WYx3Bc3GkUtmOMZxcmyjX9NajBp3zkR6zWjWCA1agSqzvaC7cfC2PTsghO/C3Bs8vLgJ4Dm7nSBUSlvy52S0/vtTWitSAXUiHzXqNNyJ0gjR4TnUbWEkGi01pzTrPcb3GKP6oN0tFNmEwFXTiEpXlktueFSm4JPfXqOMFm+0XFRFvgq3VHPYyiBy45N92uKvmSkRgPF+FcNHIUISrK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12JrjutCDkQrkv0Kh4ybnhRymrMxjiRiTYb5biE5U54=;
 b=U72DhNmX9tKT5vqmj48y+fCzCAu7jrOTjUnZc9LHaE4t1Xpm0A9MVi48nKwVzoX/h2ApVO+roY+NraMZ/dISlUAb52lOhnDKnfetBvDulR01aUJ+Dx/jxDsxPcwuqZ0KnACBA1FOLVCKrJEGZcwkSXp6wlVuiiEEZ5BIjo/r+vc=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by TYSPR03MB7643.apcprd03.prod.outlook.com (2603:1096:400:40e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 03:28:00 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350%6]) with mapi id 15.20.7849.018; Thu, 22 Aug 2024
 03:28:00 +0000
From: =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>
To: "yonghong.song@linux.dev" <yonghong.song@linux.dev>
CC: "sdf@fomichev.me" <sdf@fomichev.me>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, =?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>, wsd_upstream <wsd_upstream@mediatek.com>,
	"andrii@kernel.org" <andrii@kernel.org>,
	=?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	=?utf-8?B?WWFuZ2h1aSBMaSAo5p2O6Ziz6L6JKQ==?= <Yanghui.Li@mediatek.com>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "haoluo@google.com" <haoluo@google.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH net v4] bpf, net: Check cgroup_bpf_enabled() only once in
 do_sock_getsockopt()
Thread-Topic: [PATCH net v4] bpf, net: Check cgroup_bpf_enabled() only once in
 do_sock_getsockopt()
Thread-Index: AQHa86zl7g+mrFIyrk6Wt5BoZjlturIyDRAAgACSKIA=
Date: Thu, 22 Aug 2024 03:28:00 +0000
Message-ID: <b8348f42ef7e78e391619b198ee9a92eb74524e8.camel@mediatek.com>
References: <20240821093016.2533-1-Tze-nan.Wu@mediatek.com>
	 <b007ee0b-ff90-43ff-91a1-44882bf0e799@linux.dev>
In-Reply-To: <b007ee0b-ff90-43ff-91a1-44882bf0e799@linux.dev>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|TYSPR03MB7643:EE_
x-ms-office365-filtering-correlation-id: 584e4483-6ab4-4ef5-7e31-08dcc25a6c85
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q3V0OC8rZXd6cGZkWngyOVZjclg2MHA3MjNldkovVDNpU3ZZSlZRYktOSkRu?=
 =?utf-8?B?RVFycDJQU20ySEJTV3U4YkFKWmowd3ozZlpMRUZNUXo0RFNEYzBLWU00SGlp?=
 =?utf-8?B?RkN3dWpJajJaSzEzcnBTSU1Ra0tFLzE0ZlZRd1hBY0xRbGpJUHpxa0pBcmZy?=
 =?utf-8?B?RkpDWjNpWTZNKzJ3dFVvbjhHdURiM2FsUG5IdmpmTHdMSDl6VStvOFVXdm5i?=
 =?utf-8?B?VndZQ3lpUzMwL3Z1S2tuS0VRUHY2a3Y1cFpoVE1JcGJlKytvWmh0SU1PSnVh?=
 =?utf-8?B?NHJhcURWMDVERldCZEpKR0VsVFdCR01henZ2b0ptNnBDcUt1OUpoMnFxRDE2?=
 =?utf-8?B?NUdvU2JDZDVBNWk3Q0N6Nmo2TVVDVXF0NlRuS2pyU2NmbnZEQ1hvcWpSQ3Fn?=
 =?utf-8?B?RXVDMGtIUEhZK1liUDM1L3RhZUlYQ3dMdmw2NmZqMGJ3MXhvRjNnVTYvcFVL?=
 =?utf-8?B?bEtzV0d6ZHIvL2FvWWhMY20yaG51dTJkNGJOcFRSMG16dmE4cklUMXUzbk4x?=
 =?utf-8?B?TUxtbVdMT08xZjl0aTAxYXhMaU9SeXpHVlY3aUR1RTFaVnk3TXBGdVJwQW1E?=
 =?utf-8?B?YTFLMHI2RWFEUDllNloxUWtJaFJ6QWo5b2d1Y1BZMVJiaVJHK0E4dHpkcmlF?=
 =?utf-8?B?Q0FadUd0MWg2UWZlREVUUHdOL0VtTVN2cUZVOUFUcnFpNXVBV0tyWGJJMHAx?=
 =?utf-8?B?Z1BuaXluWExUSDVEcndVWFNyQlZ2ckJtTGNTSHpsQ0ZmQThRY3V1c2JxS0dT?=
 =?utf-8?B?YSsrS2duQ21RNjU4Q1VJT2FoVitQQ1B5RkNuSVltTU9WckVabEVVZWkvYVlr?=
 =?utf-8?B?dlYwTE16T05TaHZvRzR5ZzRGeWt3R1djYWV3aFZsZ3NsaU1mYnpBY0xtQmZR?=
 =?utf-8?B?c1JITFJjRDFIV2paWDBuUGtyb25vbS9TeEhETFZSelkyTU1vTmRaZ1ZHdkVI?=
 =?utf-8?B?TWhTeGxOekJtYzhUT0dNUjBqdjVaOHBncXg2T1FJVkVPUHU2ck53Q1BZd3px?=
 =?utf-8?B?ZmVVWkZlcWdPRmhCWXhrMDUwc1NpZEViSW5zRTluMHRVbXZSaFNZZDRuN1lS?=
 =?utf-8?B?UE00eFBjNFNtSTRMbkQ3aFppYzhtVHdoQzFLa0FnRHEwclYwSTI3ZGsrYXdw?=
 =?utf-8?B?Zlk2SDB6KzB3S0ludDJLMzhOWVlUSldTODZKNTNSczRaRER4Q3FNV2taVUFN?=
 =?utf-8?B?SW83eUUzMnlxazNwdklnZ3pyNWJTOUgybms3UUZMSWs5WXAyZzh0Q2UrQWR5?=
 =?utf-8?B?UmN5d2RQTVczam8zNGhEN20zenlCQjlTNHdVTzFLZHF2ZUdWYzVQZXJjUzFm?=
 =?utf-8?B?L2ZVRWlnaG5HQUFaMUw2UDlpRGxHVVJ4VTJ0S2xpNGZZNElUeTc3ZkJDYnJD?=
 =?utf-8?B?cE53dFpSSFFmZHhUSUh6SC9SRnVTOTlxU0J0cW5zOTczV09TWWZYU0tMSkRW?=
 =?utf-8?B?T0NVQW9mMWhUckNYRGtEQ0NCUTNBVW1nOUdNVlZJVjlQNStVVVF1MWVURndQ?=
 =?utf-8?B?RFVNSGpCSUJ0dG5VazJLVGU0T09PVzh6V2JqU3FIWTdLQjQxd0lzYjUwTS8r?=
 =?utf-8?B?R1hyenk4N1J1SlFKeXRUZXpJc0NFdW9zTUR1Sk41Q1cycVpLZS9FTVg4SU42?=
 =?utf-8?B?bXVZMVRRU2diOEROVXdZZ0gxRFZ5UFpFTVB6VmZIMmZmWWFROG4rOWpmQXUz?=
 =?utf-8?B?ZUVTT0hsclZXSjh3N3ZUeDVtQkZaTGlYc2tldVZ5d2NsL1VKU1dTRmU1U0oz?=
 =?utf-8?B?aG5vWFhycWwxa3FUUTZWYVRUbmdDSGxSZVVlZ3puY3FtTy92MXdKYmZ2eGtJ?=
 =?utf-8?B?c1hEWHJkUHdKbVc0Q0lmNWhiZTNqWlNQbFZ4K2hiUlJuTHRBbFJsSVlJSTZ3?=
 =?utf-8?B?NTRPVkJFOERwRnp3OWZVVmVlM1NmbDRIYy9qL3dXbkZ5ZHc2K0J1emZ6UThx?=
 =?utf-8?Q?sPLRcKZdtXU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azYrOU5VOERrNFk5aS9aYUN0ZUFGVTk1L3dIYmZRV09EaXR6a1ZkMzhjeTVO?=
 =?utf-8?B?SGFRNEFmTHZDc3NxMTJDNFVPSE9SZ21vZ2tCV05VSkxTMkNZNllMckJ5QmpX?=
 =?utf-8?B?OVJzS28xRVp5K01FUUQ3OWFGei9USTB5ZU9vbkZjWGIwME4vT3ZnQlhQQThL?=
 =?utf-8?B?eU9lakt3TlNiOCtJKzR2cDc4S2RXc0J4QzJFeW95ck5DMk9HUXg2MHczTHht?=
 =?utf-8?B?dG9wbU84MUhFM2t6YjJ6THI0aXdvNWJDNmpkcmpLdzNQcDcySDdMdUIvTXNO?=
 =?utf-8?B?dFprVlNlLzBBb0dSOUl2eC9SY3RldFdadGNscjZzdGFWUjVrVnRjMm5aQjdN?=
 =?utf-8?B?WGNETU5tQzloYTU4Qk5EbkJaSEhGQ01uNVlIa2JOMXpnT2J5NHZyTFVjZHJC?=
 =?utf-8?B?dVV2R2VxTnNsbGdUdDQ4Mnd4WUtKYlVTbjA0VjVWSTYxUVZ4KzZ1aTJTZFlp?=
 =?utf-8?B?UFlJK1oyRTlCWEEvclpIYVBidHQvUzBYZFlkc2RPR21Ba293U2dwcFE4L3h0?=
 =?utf-8?B?Sm5IVFpFNS92d3VLVC9NOXdncGUwaFNrQTZlVTI2Vzl4VWV0MHlhcEFxNlZU?=
 =?utf-8?B?ZExKQ3FTNURFckMyemtwaW1FWE02aTNtdk1lZkh0RVV0TVBqczkzVTIxWlpl?=
 =?utf-8?B?ZEFEZnVwcHg4OUp6cUZ0OFdJZUVWWFI2RnQvaHluWExJaTRwRlJwS0FCR1Mz?=
 =?utf-8?B?cW5mb1ZQTmZ4Yk5EZG5YcjE1UGJIVmdOcys5cVFtMTZNRmhkamZhK0tUUkFF?=
 =?utf-8?B?UTVJOXloWG5RNHRqRFA5RWFKZW1Gclg3SWcxbGdyWkRsQW80aGNKdFUwRkla?=
 =?utf-8?B?MWNwR1VpU3BBQW9CMjdBTVdGSG43RUE5YzVBSWZ5d3haTysweVdIVnRpUkUv?=
 =?utf-8?B?ck5FMzVMYlJ1QmIyY0dOQlAwenRha1VEYVhKaEtBcG50cjAvWFlSZGhCdzJw?=
 =?utf-8?B?bjNBY3FoNFlIVUc2elhYcHJLWjVDS3FzM2RJTndhcTdveEhzc1U2QVhPcnkw?=
 =?utf-8?B?cW1VV0dJVzhmYkJrd0t4Rk1FWTZWN0VIMlBsak9sc2JkRGVsYWtKTUVhV3VX?=
 =?utf-8?B?dnkzemUycGxveVNlYTZVTE43Z3NwMlF3ZFR0R1lvTkpJTWZiSHhOQXZETDJB?=
 =?utf-8?B?Y0UyeHJhL2JLZmczU0F5cEtoVHgwK0J3YmFpR3NsRUUyR2E4aVQvQkpJUUNt?=
 =?utf-8?B?L1RrcHlxbG1iSmtwa3ovaWlnOTY0UTUrQWdPcDVKS1VPZlduNU1UY3EzcVZO?=
 =?utf-8?B?VGxEZ2RRMVZ2Q1RaRlFXWnRZcWhkcmZ2SFgrTDd6TTdPQTZvMUE5TTg1anh0?=
 =?utf-8?B?YmZTamM0Nk10ZzJJS2tHWnJCVUVkbWxnMUxia0dVSDgzNWkrb2d6WG81V0hI?=
 =?utf-8?B?R0krUExjYnRqanJXd0JvL0ZTb3R1Tks5U3U1ZWg4QU91VDBYZEhjcnNDSUlX?=
 =?utf-8?B?Q2ZFOExqOFdWVWhZRVh5NnljbWtwYjIwck5vUFNBa0s5ZVhxZmQ5YU9ZYTM5?=
 =?utf-8?B?WkxJVHRIUkovRkozWVJ4ZnlLYWFhNXFoZUZxTjBmYjdPcndBNXdFOW9ZUUF1?=
 =?utf-8?B?UCtFNXNocXZBaDhiTU1sYTBrOTNXUzEzOVdiUHBML1BneHA4Z2k5eXhJYmxu?=
 =?utf-8?B?djRTWm04N3RZUUdzSGNHM29TVHR1WWdsSTRBZFdJckMvQzNRdDMxQlltNG1L?=
 =?utf-8?B?OXV6c29iVzh0N3JtcWgvNFQwQjEwWFNtQngrWHl3eEVhbzRrTkxzR0JYdFN1?=
 =?utf-8?B?aTlGTXJselBDdWdyZ2t1b2d6YlpLcytJZFUvUXlQNVhaeWNZRjV4Z04zWDAv?=
 =?utf-8?B?Q1hOYjlNYWVBWDFWSXFHK0h6WllxU3FTa3VXczl6SDBrY0lFSHN1OEJJcUZ5?=
 =?utf-8?B?VHhUNGc1a20vNWJKU01TYXE1Z0FFUFRNR2ZHdE93TlQzY3o0b2IxUFNldkJ1?=
 =?utf-8?B?QXNKc0JYN0Y3VGh6b2RWMmkxNVMrWllBQ2JlYngwVlh6OXVkSW1ncUtIQjZl?=
 =?utf-8?B?aVpPQklnNnRWem56YjZqNUZCNm9DSEl6czV2c3pRUHBWL0toTk5JYUVmYlN4?=
 =?utf-8?B?Z3AwaTFHYVVhdmlCOFJjYklsdXZoRzEzT0dyOGxmbVpIRVhxaEpuQ0VJZTkr?=
 =?utf-8?B?cnJJWGFJcU93N0plVXRaZVBGalZHSlZob1NJbWRMdDZPa3RXUy9iVjdMa2xk?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AF1111DEAC1DE48AB660E46D9D7086B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584e4483-6ab4-4ef5-7e31-08dcc25a6c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 03:28:00.2869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8VVdaCB564I7Yc3Z+mNvCjNWhtUOMZ1ga76ftFWnFD1QUhfxJknmPulf6U2ToLKgIzCf24vUv6E82GG9F303g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7643

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDExOjQ0IC0wNzAwLCBZb25naG9uZyBTb25nIHdyb3RlOg0K
PiAgCSANCj4gIA0KPiBPbiA4LzIxLzI0IDI6MzAgQU0sIFR6ZS1uYW4gV3Ugd3JvdGU6DQo+ID4g
VGhlIHJldHVybiB2YWx1ZSBmcm9tIGBjZ3JvdXBfYnBmX2VuYWJsZWQoQ0dST1VQX0dFVFNPQ0tP
UFQpYCBjYW4NCj4gY2hhbmdlDQo+ID4gYmV0d2VlbiB0aGUgaW52b2NhdGlvbnMgb2YgYEJQRl9D
R1JPVVBfR0VUU09DS09QVF9NQVhfT1BUTEVOYCBhbmQNCj4gPiBgQlBGX0NHUk9VUF9SVU5fUFJP
R19HRVRTT0NLT1BUYC4NCj4gPg0KPiA+IElmIGBjZ3JvdXBfYnBmX2VuYWJsZWQoQ0dST1VQX0dF
VFNPQ0tPUFQpYCBjaGFuZ2VzIGZyb20gImZhbHNlIiB0bw0KPiA+ICJ0cnVlIiBiZXR3ZWVuIHRo
ZSBpbnZvY2F0aW9ucyBvZg0KPiBgQlBGX0NHUk9VUF9HRVRTT0NLT1BUX01BWF9PUFRMRU5gIGFu
ZA0KPiA+IGBCUEZfQ0dST1VQX1JVTl9QUk9HX0dFVFNPQ0tPUFRgLCBgQlBGX0NHUk9VUF9SVU5f
UFJPR19HRVRTT0NLT1BUYA0KPiB3aWxsDQo+ID4gcmVjZWl2ZSBhbiAtRUZBVUxUIGZyb20NCj4g
YF9fY2dyb3VwX2JwZl9ydW5fZmlsdGVyX2dldHNvY2tvcHQobWF4X29wdGxlbj0wKWANCj4gPiBk
dWUgdG8gYGdldF91c2VyKClgIHdhcyBub3QgcmVhY2hlZCBpbg0KPiBgQlBGX0NHUk9VUF9HRVRT
T0NLT1BUX01BWF9PUFRMRU5gLg0KPiA+DQo+ID4gU2NlbmFyaW8gc2hvd24gYXMgYmVsb3c6DQo+
ID4NCj4gPiAgICAgICAgICAgICBgcHJvY2VzcyBBYCAgICAgICAgICAgICAgICAgICAgICBgcHJv
Y2VzcyBCYA0KPiA+ICAgICAgICAgICAgIC0tLS0tLS0tLS0tICAgICAgICAgICAgICAgICAgICAg
IC0tLS0tLS0tLS0tLQ0KPiA+ICAgIEJQRl9DR1JPVVBfR0VUU09DS09QVF9NQVhfT1BUTEVODQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5hYmxlDQo+
IENHUk9VUF9HRVRTT0NLT1BUDQo+ID4gICAgQlBGX0NHUk9VUF9SVU5fUFJPR19HRVRTT0NLT1BU
ICgtRUZBVUxUKQ0KPiA+DQo+ID4gVG8gcHJldmVudCB0aGlzLCBpbnZva2UgYGNncm91cF9icGZf
ZW5hYmxlZCgpYCBvbmx5IG9uY2UgYW5kIGNhY2hlDQo+IHRoZQ0KPiA+IHJlc3VsdCBpbiBhIG5l
d2x5IGFkZGVkIGxvY2FsIHZhcmlhYmxlIGBlbmFibGVkYC4NCj4gPiBCb3RoIGBCUEZfQ0dST1VQ
XypgIG1hY3JvcyBpbiBgZG9fc29ja19nZXRzb2Nrb3B0YCB3aWxsIHRoZW4gY2hlY2sNCj4gdGhl
aXINCj4gPiBjb25kaXRpb24gdXNpbmcgdGhlIHNhbWUgYGVuYWJsZWRgIHZhcmlhYmxlIGFzIHRo
ZSBjb25kaXRpb24NCj4gdmFyaWFibGUsDQo+ID4gaW5zdGVhZCBvZiB1c2luZyB0aGUgcmV0dXJu
IHZhbHVlcyBmcm9tIGBjZ3JvdXBfYnBmX2VuYWJsZWRgIGNhbGxlZA0KPiBieQ0KPiA+IHRoZW1z
ZWx2ZXMgYXMgdGhlIGNvbmRpdGlvbiB2YXJpYWJsZSh3aGljaCBjb3VsZCB5aWVsZCBkaWZmZXJl
bnQNCj4gcmVzdWx0cykuDQo+ID4gVGhpcyBlbnN1cmVzIHRoYXQgZWl0aGVyIGJvdGggYEJQRl9D
R1JPVVBfKmAgbWFjcm9zIHBhc3MgdGhlDQo+IGNvbmRpdGlvbg0KPiA+IG9yIG5laXRoZXIgZG9l
cy4NCj4gPg0KPiA+IEZpeGVzOiAwZDAxZGE2YWZjNTQgKCJicGY6IGltcGxlbWVudCBnZXRzb2Nr
b3B0IGFuZCBzZXRzb2Nrb3B0DQo+IGhvb2tzIikNCj4gPiBDby1kZXZlbG9wZWQtYnk6IFlhbmdo
dWkgTGkgPHlhbmdodWkubGlAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbmdo
dWkgTGkgPHlhbmdodWkubGlAbWVkaWF0ZWsuY29tPg0KPiA+IENvLWRldmVsb3BlZC1ieTogQ2hl
bmctSnVpIFdhbmcgPGNoZW5nLWp1aS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDaGVuZy1KdWkgV2FuZyA8Y2hlbmctanVpLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFR6ZS1uYW4gV3UgPFR6ZS1uYW4uV3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+DQo+ID4gQ2hhZ25lcyBmcm9tIHYxIHRvIHYyOiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjQwODE5MDgyNTEzLjI3MTc2LTEtVHplLW5hbi5XdUBtZWRpYXRlay5jb20v
DQo+ID4gICAgSW5zdGVhZCBvZiB1c2luZyBjZ3JvdXBfbG9jayBpbiB0aGUgZmFzdHBhdGgsIGlu
dm9rZQ0KPiBjZ3JvdXBfYnBmX2VuYWJsZWQNCj4gPiAgICBvbmx5IG9uY2UgYW5kIGNhY2hlIHRo
ZSB2YWx1ZSBpbiB0aGUgbmV3bHkgYWRkZWQgdmFyaWFibGUNCj4gYGVuYWJsZWRgLg0KPiA+ICAg
IGBCUEZfQ0dST1VQXypgIG1hY3JvcyBpbiBkb19zb2NrX2dldHNvY2tvcHQgY2FuIHRoZW4gYm90
aCBjaGVjaw0KPiB0aGVpcg0KPiA+ICAgIGNvbmRpdGlvbiB3aXRoIHRoZSBuZXcgdmFyaWFibGUg
YGVuYWJsZWAsIGVuc3VyaW5nIHRoYXQgZWl0aGVyDQo+IHRoZXkgYm90aA0KPiA+ICAgIHBhc3Np
bmcgdGhlIGNvbmRpdGlvbiBvciBib3RoIGRvIG5vdC4NCj4gPg0KPiA+IENoYWduZXMgZnJvbSB2
MiB0byB2MzogDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDgxOTE1NTYyNy4x
MzY3LTEtVHplLW5hbi5XdUBtZWRpYXRlay5jb20vDQo+ID4gICAgSGlkZSBjZ3JvdXBfYnBmX2Vu
YWJsZWQgaW4gdGhlIG1hY3JvLCBhbmQgc29tZSBtb2RpZmljYXRpb25zIHRvDQo+IGFkYXB0DQo+
ID4gICAgdGhlIGNvZGluZyBzdHlsZS4NCj4gPg0KPiA+IENoYWduZXMgZnJvbSB2MyB0byB2NDog
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDgyMDA5Mjk0Mi4xNjY1NC0xLVR6
ZS1uYW4uV3VAbWVkaWF0ZWsuY29tLw0KPiA+ICAgIEFkZCBicGYgdGFnIHRvIHN1YmplY3QsIGFu
ZCBGaXhlcyB0YWcgaW4gYm9keS4NCj4gPg0KPiA+IC0tLQ0KPiA+ICAgaW5jbHVkZS9saW51eC9i
cGYtY2dyb3VwLmggfCAxNSArKysrKysrKy0tLS0tLS0NCj4gPiAgIG5ldC9zb2NrZXQuYyAgICAg
ICAgICAgICAgIHwgIDUgKysrLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2JwZi1jZ3JvdXAuaCBiL2luY2x1ZGUvbGludXgvYnBmLQ0KPiBjZ3JvdXAuaA0KPiA+IGluZGV4
IGZiM2MzZTcxODFlNi4uNWFmYTJhYzc2YWFlIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvYnBmLWNncm91cC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9icGYtY2dyb3VwLmgNCj4g
PiBAQCAtMzkwLDIwICszOTAsMjAgQEAgc3RhdGljIGlubGluZSBib29sDQo+IGNncm91cF9icGZf
c29ja19lbmFibGVkKHN0cnVjdCBzb2NrICpzaywNCj4gPiAgIF9fcmV0OyAgICAgICBcDQo+ID4g
ICB9KQ0KPiA+ICAgDQo+ID4gLSNkZWZpbmUgQlBGX0NHUk9VUF9HRVRTT0NLT1BUX01BWF9PUFRM
RU4ob3B0bGVuKSAgICAgICBcDQo+ID4gKyNkZWZpbmUgQlBGX0NHUk9VUF9HRVRTT0NLT1BUX01B
WF9PUFRMRU4ob3B0bGVuLCBlbmFibGVkKSAgICAgICBcDQo+ID4gICAoeyAgICAgICBcDQo+ID4g
ICBpbnQgX19yZXQgPSAwOyAgICAgICBcDQo+ID4gLWlmIChjZ3JvdXBfYnBmX2VuYWJsZWQoQ0dS
T1VQX0dFVFNPQ0tPUFQpKSAgICAgICBcDQo+ID4gK2VuYWJsZWQgPSBjZ3JvdXBfYnBmX2VuYWJs
ZWQoQ0dST1VQX0dFVFNPQ0tPUFQpOyAgICAgICBcDQo+ID4gK2lmIChlbmFibGVkKSAgICAgICBc
DQo+ID4gICBjb3B5X2Zyb21fc29ja3B0cigmX19yZXQsIG9wdGxlbiwgc2l6ZW9mKGludCkpOyAg
ICAgICBcDQo+ID4gICBfX3JldDsgICAgICAgXA0KPiA+ICAgfSkNCj4gPiAgIA0KPiA+ICAgI2Rl
ZmluZSBCUEZfQ0dST1VQX1JVTl9QUk9HX0dFVFNPQ0tPUFQoc29jaywgbGV2ZWwsIG9wdG5hbWUs
DQo+IG9wdHZhbCwgb3B0bGVuLCAgIFwNCj4gPiAtICAgICAgIG1heF9vcHRsZW4sIHJldHZhbCkg
ICAgICAgXA0KPiA+ICsgICAgICAgbWF4X29wdGxlbiwgcmV0dmFsLCBlbmFibGVkKSAgICAgICBc
DQo+ID4gICAoeyAgICAgICBcDQo+ID4gICBpbnQgX19yZXQgPSByZXR2YWw7ICAgICAgIFwNCj4g
PiAtaWYgKGNncm91cF9icGZfZW5hYmxlZChDR1JPVVBfR0VUU09DS09QVCkgJiYgICAgICAgXA0K
PiA+IC0gICAgY2dyb3VwX2JwZl9zb2NrX2VuYWJsZWQoc29jaywgQ0dST1VQX0dFVFNPQ0tPUFQp
KSAgICAgICBcDQo+ID4gK2lmIChlbmFibGVkICYmIGNncm91cF9icGZfc29ja19lbmFibGVkKHNv
Y2ssDQo+IENHUk9VUF9HRVRTT0NLT1BUKSkgICAgICAgXA0KPiA+ICAgaWYgKCEoc29jayktPnNr
X3Byb3QtPmJwZl9ieXBhc3NfZ2V0c29ja29wdCB8fCAgICAgICBcDQo+ID4gICAgICAgIUlORElS
RUNUX0NBTExfSU5FVF8xKChzb2NrKS0+c2tfcHJvdC0+YnBmX2J5cGFzc19nZXRzb2Nrb3B0LCAN
Cj4gXA0KPiA+ICAgdGNwX2JwZl9ieXBhc3NfZ2V0c29ja29wdCwgICAgICAgXA0KPiA+IEBAIC01
MTgsOSArNTE4LDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50DQo+IGJwZl9wZXJjcHVfY2dyb3VwX3N0
b3JhZ2VfdXBkYXRlKHN0cnVjdCBicGZfbWFwICptYXAsDQo+ID4gICAjZGVmaW5lIEJQRl9DR1JP
VVBfUlVOX1BST0dfU09DS19PUFMoc29ja19vcHMpICh7IDA7IH0pDQo+ID4gICAjZGVmaW5lIEJQ
Rl9DR1JPVVBfUlVOX1BST0dfREVWSUNFX0NHUk9VUChhdHlwZSwgbWFqb3IsIG1pbm9yLA0KPiBh
Y2Nlc3MpICh7IDA7IH0pDQo+ID4gICAjZGVmaW5lDQo+IEJQRl9DR1JPVVBfUlVOX1BST0dfU1lT
Q1RMKGhlYWQsdGFibGUsd3JpdGUsYnVmLGNvdW50LHBvcykgKHsgMDsgfSkNCj4gPiAtI2RlZmlu
ZSBCUEZfQ0dST1VQX0dFVFNPQ0tPUFRfTUFYX09QVExFTihvcHRsZW4pICh7IDA7IH0pDQo+ID4g
KyNkZWZpbmUgQlBGX0NHUk9VUF9HRVRTT0NLT1BUX01BWF9PUFRMRU4ob3B0bGVuLCBlbmFibGVk
KSAoeyAwOyB9KQ0KPiA+ICAgI2RlZmluZSBCUEZfQ0dST1VQX1JVTl9QUk9HX0dFVFNPQ0tPUFQo
c29jaywgbGV2ZWwsIG9wdG5hbWUsDQo+IG9wdHZhbCwgXA0KPiA+IC0gICAgICAgb3B0bGVuLCBt
YXhfb3B0bGVuLCByZXR2YWwpICh7IHJldHZhbDsgfSkNCj4gPiArICAgICAgIG9wdGxlbiwgbWF4
X29wdGxlbiwgcmV0dmFsLCBcDQo+ID4gKyAgICAgICBlbmFibGVkKSAoeyByZXR2YWw7IH0pDQo+
ID4gICAjZGVmaW5lIEJQRl9DR1JPVVBfUlVOX1BST0dfR0VUU09DS09QVF9LRVJOKHNvY2ssIGxl
dmVsLCBvcHRuYW1lLA0KPiBvcHR2YWwsIFwNCj4gPiAgICAgICBvcHRsZW4sIHJldHZhbCkgKHsg
cmV0dmFsOyB9KQ0KPiA+ICAgI2RlZmluZSBCUEZfQ0dST1VQX1JVTl9QUk9HX1NFVFNPQ0tPUFQo
c29jaywgbGV2ZWwsIG9wdG5hbWUsDQo+IG9wdHZhbCwgb3B0bGVuLCBcDQo+ID4gZGlmZiAtLWdp
dCBhL25ldC9zb2NrZXQuYyBiL25ldC9zb2NrZXQuYw0KPiA+IGluZGV4IGZjYmRkNWJjNDdhYy4u
MGI0NjVkYzhhNzg5IDEwMDY0NA0KPiA+IC0tLSBhL25ldC9zb2NrZXQuYw0KPiA+ICsrKyBiL25l
dC9zb2NrZXQuYw0KPiA+IEBAIC0yMzYzLDYgKzIzNjMsNyBAQCBpbnQgZG9fc29ja19nZXRzb2Nr
b3B0KHN0cnVjdCBzb2NrZXQgKnNvY2ssDQo+IGJvb2wgY29tcGF0LCBpbnQgbGV2ZWwsDQo+ID4g
ICAgICAgICAgaW50IG9wdG5hbWUsIHNvY2twdHJfdCBvcHR2YWwsIHNvY2twdHJfdCBvcHRsZW4p
DQo+ID4gICB7DQo+ID4gICBpbnQgbWF4X29wdGxlbiBfX21heWJlX3VudXNlZDsNCj4gPiArYm9v
bCBlbmFibGVkIF9fbWF5YmVfdW51c2VkOw0KPiA+ICAgY29uc3Qgc3RydWN0IHByb3RvX29wcyAq
b3BzOw0KPiA+ICAgaW50IGVycjsNCj4gPiAgIA0KPiA+IEBAIC0yMzcxLDcgKzIzNzIsNyBAQCBp
bnQgZG9fc29ja19nZXRzb2Nrb3B0KHN0cnVjdCBzb2NrZXQgKnNvY2ssDQo+IGJvb2wgY29tcGF0
LCBpbnQgbGV2ZWwsDQo+ID4gICByZXR1cm4gZXJyOw0KPiA+ICAgDQo+ID4gICBpZiAoIWNvbXBh
dCkNCj4gPiAtbWF4X29wdGxlbiA9IEJQRl9DR1JPVVBfR0VUU09DS09QVF9NQVhfT1BUTEVOKG9w
dGxlbik7DQo+ID4gK21heF9vcHRsZW4gPSBCUEZfQ0dST1VQX0dFVFNPQ0tPUFRfTUFYX09QVExF
TihvcHRsZW4sIGVuYWJsZWQpOw0KPiANCj4gSGVyZSwgJ2VuYWJsZWQnIGlzIGFjdHVhbGx5IGFz
c2lnbmVkIHdpdGggYSB2YWx1ZSBpbiB0aGUgbWFjcm8uIEkgYW0NCj4gbm90IHN1cmUNCj4gd2hl
dGhlciB0aGlzIGlzIGEgY29tbW9uIHByYWN0aWNlIG9yIG5vdC4gQXQgbGVhc3QgZnJvbSBtYWNy
bywgaXQgaXMNCj4gbm90IGNsZWFyDQo+IGFib3V0IHRoaXMuDQo+IA0KPiBNYXliZSB3ZSBjYW4g
ZG8NCj4gbWF4X29wdGxlbiA9IEJQRl9DR1JPVVBfR0VUU09DS09QVF9NQVhfT1BUTEVOKG9wdGxl
biwgJmVuYWJsZWQpOw0KPiANCj4gVGhlICZlbmFibGVkIHNpZ25hbHMgdGhhdCBpdHMgdmFsdWUg
Y291bGQgY2hhbmdlLiBBbmQgaW5kZWVkDQo+IHRoZSBtYWNybyB3aWxsIHN0b3JlIHRoZSBwcm9w
ZXIgdmFsdWUgdG8gJmVuYWJsZWQgcHJvcGVybHkuDQo+IA0KPiBKdXN0IG15IDIgY2VudHMuDQo+
IA0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4NCldpbGwgdGFrZSB0aGUgc3VnZ2VzdGlvbiBp
biB2NSBpZiB0aGlzIHBhdGNoIGlzIHRydWVseSBuZWVkZWQsDQpsb29rcyBsaWtlIHRoaXMgcGF0
Y2ggY291bGQgcG9zc2libHkgbGVhZCB0byByZWdyZXNzaW9uIGlzc3VlLg0KDQoNCj4gPiAgIA0K
PiA+ICAgb3BzID0gUkVBRF9PTkNFKHNvY2stPm9wcyk7DQo+ID4gICBpZiAobGV2ZWwgPT0gU09M
X1NPQ0tFVCkgew0KPiA+IEBAIC0yMzkwLDcgKzIzOTEsNyBAQCBpbnQgZG9fc29ja19nZXRzb2Nr
b3B0KHN0cnVjdCBzb2NrZXQgKnNvY2ssDQo+IGJvb2wgY29tcGF0LCBpbnQgbGV2ZWwsDQo+ID4g
ICBpZiAoIWNvbXBhdCkNCj4gPiAgIGVyciA9IEJQRl9DR1JPVVBfUlVOX1BST0dfR0VUU09DS09Q
VChzb2NrLT5zaywgbGV2ZWwsIG9wdG5hbWUsDQo+ID4gICAgICAgIG9wdHZhbCwgb3B0bGVuLCBt
YXhfb3B0bGVuLA0KPiA+IC0gICAgIGVycik7DQo+ID4gKyAgICAgZXJyLCBlbmFibGVkKTsNCj4g
PiAgIA0KPiA+ICAgcmV0dXJuIGVycjsNCj4gPiAgIH0NCg==

