Return-Path: <bpf+bounces-37826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852B595AE5B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 09:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBF22869D9
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 07:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E757B149012;
	Thu, 22 Aug 2024 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MjPK2ZUe";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AWqnVgUr"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E72313B2B0;
	Thu, 22 Aug 2024 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310129; cv=fail; b=pzGiYhY8DeGdqsPbITyz3RWQEtKd3hocIw1RMRsm+vyQSPmFxISmZPuPPMKVrvKIZIs6+5NXPZlHwgpGmmVcx11TTDD9jQ9W9GBnpU1DG6hD2B7Yj0K2qEECrxZ7jDsh9okrr+zwOh+IZ9slOfsMCrNmv8fOw0LmglmFnv5+acc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310129; c=relaxed/simple;
	bh=Hvb6Ha5azQVJcTD5m5LoqAvJWtE0I7kIufyY6ZNpYCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KRmkNHLAm9vJRzxzP4afZhoxGoKFWA8vDYp/QzCnHNoEvB7EhyUfNs2hu0vs+p03dybqYuoU0qTH4r+oYtkPaL9T/UG7nt/vFTAXUDrmEXi4ZD6dJnwse+3pwlESyUY2PyMedv8QPlPiwNGGMlwq2+lMwpR5mfbvBO5LHZxrgf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MjPK2ZUe; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=AWqnVgUr; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6de6f376605411ef8b96093e013ec31c-20240822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Hvb6Ha5azQVJcTD5m5LoqAvJWtE0I7kIufyY6ZNpYCA=;
	b=MjPK2ZUei8Ymr8KOO1pMjb6fy+5aVtIbhYzBddIt3TGir1iTNFm2pSZX0tD5/L0lj/MkrZ+yQ40U0B/gElPWBI4q9vYwXZSvHGJsxDRzQPqcsyajQdxPOICi1MzNc9c2ReYXJPgTX/44negRy5MSCntKkTwzy6Vakg+F6TaM9iQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:4dcc0da8-c9be-475a-bab0-6625e85c9dcc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:2f79ffce-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6de6f376605411ef8b96093e013ec31c-20240822
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 180058339; Thu, 22 Aug 2024 15:02:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 22 Aug 2024 15:02:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 22 Aug 2024 15:02:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWyDW+98oCX5uZdErf7U+sadtTUeoqlvmxRHd9IO2bJwTjeI4dv6ZIekEyiv3N4z6OlQjHl5t8NERUOjBDya+iXsFYIwgghKIsgkEs7+LPp/vl66/w6jYX3zSnEzF65LKGXV+L5tVCjYIKNkit4HUi2+i1BNmKkxhfmoO4JbyoG9iybtPiTMjF2g4I2hh9BkjRvB931eYjx4Lnq6HLHBOJVRi7KMoGgd6KS9Mhd25C+6vIqW9RVZ8+CIe6V3WQGbqj8+UJC5vS6U6Oet+i0c6b2QpLtKWjBMOf0K83vpfSe/2WKqa1Z6BzzC8hxDWNvJXC/T+47oBRZlu3NtMJ41Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hvb6Ha5azQVJcTD5m5LoqAvJWtE0I7kIufyY6ZNpYCA=;
 b=pGJ8IoqrCyJ674lxbbYS6pB91xPh9FBIEavUvL85Dp1Ev+n7g2qSA46/H427VYHAyKrhuWHtXcXO8RSN0Pn/eUhjt6OZzN+ZOyaMKwBZfGFyXQox5Ij7n2eyxOPhSbLiHzL/P1keG8yLm+Ise2ZkV+LT31oaSFHoDZN9T7+5Ne0bf4S+tno4MK//ugJWDefT9ugoPrnrBTQasDHf2Q/lJCAxtE6DSkggGhBcFwcZGO0p85iOfhzuxdj632uiLbBsEyQVnHSiogex47695Hzx3V3l/dZ1kzOQcLFsESyc89J7w1F19HnTpay+xftK1/nWg9zIvIjRZsBBZ1/EUBOHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvb6Ha5azQVJcTD5m5LoqAvJWtE0I7kIufyY6ZNpYCA=;
 b=AWqnVgUr1WTTva3IyY5J0YqhpTwyuAiqSewbpwSj81wNShB5au01BQaQixOkjSqDBuaYPAGnIDTp15PlwObqSWy07DvJL/p55ClQqoXOd4GFoqTzvc2NIwshnN5cAOSlwCwIK9wDFqWIZNGnOkh7Se625ak1VVAyCef7JjfzlyI=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by SEYPR03MB7294.apcprd03.prod.outlook.com (2603:1096:101:13d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 07:01:58 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350%6]) with mapi id 15.20.7849.018; Thu, 22 Aug 2024
 07:01:58 +0000
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
Thread-Index: AQHa86zl7g+mrFIyrk6Wt5BoZjlturIyMyMAgABovYCAAD8fAA==
Date: Thu, 22 Aug 2024 07:01:57 +0000
Message-ID: <49d74e2c74e0e1786b976c0b12cb1cdd680c5f58.camel@mediatek.com>
References: <20240821093016.2533-1-Tze-nan.Wu@mediatek.com>
	 <CAADnVQLLN9hbQ8FQnX_uWFAVBd7L9HhsQpQymLOmB-dHFR4VRw@mail.gmail.com>
	 <3a7864f69b8c1d45a3fe8cda1b1e7a7c85ac9aee.camel@mediatek.com>
In-Reply-To: <3a7864f69b8c1d45a3fe8cda1b1e7a7c85ac9aee.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|SEYPR03MB7294:EE_
x-ms-office365-filtering-correlation-id: 8adc20a6-f0f3-41ce-d7ad-08dcc278505c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d2ROcjNhblhDVDFJVVVvSFZvcXVMUEdSOGpzd3UyaDB5RW1kUTMyVUpsSUc2?=
 =?utf-8?B?SEJ0M1dIWk5BMXJGQUFqbEQrcXdCQ2ZtdERHUElzUjlRaE82RmV0UVZ4NFVz?=
 =?utf-8?B?TjU1ZHNIRXlGWDZnbitlNC9rbGFEZkRaVDY4WElGbm12cE5ESWl2RUIySzB0?=
 =?utf-8?B?eFh2NUxZSUV4WkJ2eEhwUCtXc0Q0STVDRTNJYWpIQWpubDhsdEtuaFNsaWN1?=
 =?utf-8?B?cmhkZjJBeHVlZERLZG5icWptVHlLT09BUkh2N1JnR1BGai9YQTUvcVc1RUNq?=
 =?utf-8?B?NFI5WWloM3NIanpoR0MyL1NvbU1zNy9jMDFDcml2aVpqbDIrdVpQd0hGM2Ja?=
 =?utf-8?B?TmhpM0drNVEyVE5hRjZ2NTY0U25nTURVeUJNUER5M1FacGpQRkY5S3NYTGRz?=
 =?utf-8?B?UHV6MFNLT0dnRVlDSTVWWjkxYVR6dDRuMU5pd0lvbmNaQ0lISUxWUFR4SFll?=
 =?utf-8?B?a2RldSthS0NFMTFFWCttR0t6a1FUc2ppRXB6Z1FycE8yaTN6dHJEcFgxT2JN?=
 =?utf-8?B?Rk0relpWdHpCRkFOOWdiZllDTHh4TEpUeTFsL2xmSWV1cGoySFJCa0RYMm8y?=
 =?utf-8?B?ZXBtSWpXaVQ0a3B4ZDJWT2R2eEdvUStCcEFmRFJsVDFQMWRUS3F2cFkrTmVB?=
 =?utf-8?B?cTRORytBZFRzNEhnM0pHeXV1MHBnRUFlaGlwbHJ5bk1BdVUwa2FYb1ljUzFJ?=
 =?utf-8?B?RGtORWVyR1hhSnVoSnZ2Z05JWHIzSzE1WGJTN0dHU01rK0ZHdWVRcFNUTjgz?=
 =?utf-8?B?VVZwYy9UN2plVkdJVmhuV0ZKUnp4UWV5dk9PalhvOU11MjMyRmJCZkJ6THFq?=
 =?utf-8?B?ZmFDK1BhN0E2bXQybGplT0dJdS93eFh5QlFQVTEzblBiT1RvNmtHWURZNTZZ?=
 =?utf-8?B?Q0xqMWhyaE85MktSaTIyV1JNeGxQSk5BbHFzT0NPZFduMzFOMi9GNVkrNE51?=
 =?utf-8?B?anIydVpsKytBRmpxc1EzMS9DajFRWFdWU3JVblFqTENhUjB5NjhBelpFOWtn?=
 =?utf-8?B?d216bFhBN21zT3BJWmdLRjN1MCs3VFBac2hIenNTV1VjZ3JwdlgxVy8yWHVS?=
 =?utf-8?B?MW00T0pzblBwTlpOK0NyRG4yVW5zM2s5MmQwc01zT1hHZldieDNSMlh4eWZT?=
 =?utf-8?B?UTV3TFhNcmEyQ3diNTRZU3FzNzNYSFlNWXZja2VhQ3BUNEFkaDhpa1l6aHVk?=
 =?utf-8?B?SHV5K3hVRW51ZXBMZG00LzhJdDF2R1B3VXNUNWtScXJiRHJLZzl3UmhIbzlQ?=
 =?utf-8?B?MFJLOUFhbzZnN3BoWDdHZUxQSG9udHNRUWpuVE1YSGNCWTAyUE5qMjZ3dGti?=
 =?utf-8?B?UzBVS0gvVmMwcDd3cXFmVis3QXNJd2Q2N3dzd0phOUxpUDRkbm1UcDdNSjIy?=
 =?utf-8?B?MFMrcm9wZ3dkODlzZEM2cXNvNXFCOFRkeTJ4WW5pS25GZ3dKTTNpM213VG95?=
 =?utf-8?B?Rm9ZVFpXMm16RVF2Z0p5aHFFWkVuYmRZaVVmUEhpVkdLVFdmSGhFbUlXTDk5?=
 =?utf-8?B?MkRHemVncmhoaTBQL3pSeDlWSEVESXpqcUVWVnExZExrcmxMK29KaHJNK0F4?=
 =?utf-8?B?R25ta3dzQk1MVkhPSXhaOEZNRG5HR1NKUUtVd2RBRWZ2NXNMKzRPaGlySTBL?=
 =?utf-8?B?VEV2dVdubGN0YkhZR090cjNyQzhUdVprVG0yMVlGQkM1eGxYZlllS21FUUJv?=
 =?utf-8?B?UTVIRzJyVjBTd0d5bDZGUGRhbnZYd2R1bm5iOVhaOFB4MU9WcDQyby9qaGZ1?=
 =?utf-8?B?a1pGNmhJQ21zd1BiaFpPSjQxS2Jua29nMVY3amlUZmgwdXFudDM5a3BGWXdk?=
 =?utf-8?B?RUUvMTlHdFA0T0ozR0g2Y1U4ekpMY2J1cFg0QkpYYWVZcXhWTWlFRVc4ZmU0?=
 =?utf-8?B?WFZGOXkvMCtVNDUzNEQ5Zno3aTJGcGxCME9QeXBPUnR2aXVhTXVreThJQ2hD?=
 =?utf-8?Q?9hrzXezysz0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2lia2Nwd21HbFRvbmY2ZkF6Y21XVHdUUHhkaHdnN0p6eE5naW1NNXY1THZX?=
 =?utf-8?B?RkVGdDZSVnIvMTJFN2Vsb0RoMWdrbGRUZXg2YXd2MkZURkFKMmRHdzYwK2x2?=
 =?utf-8?B?MTB1SFFOUTNYRWYrME5NN2VvU1YrempEb2FIK3NGdGRBaDNzdDM3WHZYNE4z?=
 =?utf-8?B?YThPSFFhVVNjdldlVFEyN1k4UHhhckMrcnFvN1BjWTFxYTFiZ0RUV2hMTEV5?=
 =?utf-8?B?UVVTTnpxVjhGRVkxMjkvY3luSmZPVXdRWjcxSGZCaEE4eDBVREhiN0JBMVdE?=
 =?utf-8?B?TTFCUjZHdWkzZU00Z0dNdmVmaGFvWDFmSnhVbDhGU01Oby9tbDVNa2VlRElm?=
 =?utf-8?B?enNoYnBYR3ZJYURscVpZUk8xaVZuL1RwSVJBVHc1TWJTOVMrLzZzbnAxaWVK?=
 =?utf-8?B?RlFJSHdJMXZLWUlBTVZEYTdnYUdNK28ydFpMUDdXWWNQa0hlWmMybWwxNXlq?=
 =?utf-8?B?WkQ1QUQwaDV2QTR2MlJKdWgxbGRMaHFXbm1GakNXbU1zQnRpUVJ4MlBPT3ZR?=
 =?utf-8?B?TkZXMzYvbWpYVTN1dGErZkFvRmwyaTVhL3I3RXNPNlJNRGNlYy8zaE1vb3V5?=
 =?utf-8?B?S1BmOU5uTjNJL3RyeEVTNFlZS05ZaStuRE9XanYrSlVyTjZYYlpEV2hhYnM4?=
 =?utf-8?B?Q3hZdHdMWVJ0UEt3clYxK0hkaDBmWnRhMkpyYmJxbll1NnE2S0tiTEFURGZs?=
 =?utf-8?B?R2pmZkNZdXFaV3N1VDg1eDJuTmN5aWE2ejVocDE5UzkrSndTVVpGSHBsb2l0?=
 =?utf-8?B?aGx3cXd6b0ZPNWU5cmlQVlV3bUVXWHVzR1RQaTBzM1hHS3hwMXNZM3RlWE83?=
 =?utf-8?B?MGNtcVRvVVNCZ3NXVWpOU3hGOFE2bTVMR1JPUjZkMklHZTRXRUl1RXl0K0J2?=
 =?utf-8?B?cGVnZXYyd3NGdUFSS3c5WGZTaVhRbXAvL0JCS1dZNnhvdHB6YU94d01vY3E1?=
 =?utf-8?B?MGJLNmNoWktxNlRTWVZNcTMyK3FRU0JZNmVmOXFwSW5rejRpMkloY0xzak80?=
 =?utf-8?B?SjB6VTBqVkNEREJzblZzSUcrWi9tNzRucnd1NmNrWmxuaVQ2WFoxYkd0WG1J?=
 =?utf-8?B?Vm1tV3IwenR3a3EvaHZKTndkTW51OFNHTjZGL3NzZHBqOExLTzFhL2h3dlNs?=
 =?utf-8?B?bWFzT09WZXUrUEZGWFRLSm5ldjIxNUMxU0ZLT2VxRVR3QmpIRDh1dWZ2enN3?=
 =?utf-8?B?dmhkTEZocXppc3hJTWZuU0NBTzliaTdOczdnTmVrdStkWTQ5V3Y5Yzl1QlZ6?=
 =?utf-8?B?MUc1TytHV0k0VlBDeWEzQ2tLNkZ0cWJFYXJVSVpwWFA4YzdnRGhwQlVHdk04?=
 =?utf-8?B?cU55dEJzWGZQMUFkT1l3YWxsaU5ZVkpTWjFLNnJhbXVIaFJGMDdSUElkemVU?=
 =?utf-8?B?K2lTeUcxYnp5Q0R1ZkxsdFQwL3U1QjdSSVppWUpScnR3bFV0Uks1MGpFc3da?=
 =?utf-8?B?eFI1OUJDRk1rTjhVZnNTMjVXTzd0aUpxa2hHbU5IMTlRdlpkZXhXQTlKeCta?=
 =?utf-8?B?RHc5WDdmRmhzWlpOVk8wSnlLTFJMdE9kbXZGSlBHRVUvaEF5V2R6MnpUNzZy?=
 =?utf-8?B?dk4yQnF0N1hjdng3SUZyKzArRExXLzZvTEJXbjQ5VTZCMEpDL2xOZ3czU3Rk?=
 =?utf-8?B?Rm16NE5vVHRqM2EzeXVHRzZubG8rWlphM2VJKzg0NXUvZHN6N2x6aExyczFR?=
 =?utf-8?B?d2hDbUUvejh0cjBiZUV4dnRKY2ZER2RaTU5nSVNOQ0RISUU4cE1XamIzeXJX?=
 =?utf-8?B?TzJWSk9XV3RoaGxaNW03cXduVFRJYm1vQkEvdGZ3ZFpwajBCNWhTUHh1VUt3?=
 =?utf-8?B?bVRHbEtZck1KejlIVWVMb0JFeXRuRFhJdmRMYkQyQW44aE1pRStGNkpqdDZv?=
 =?utf-8?B?R0hjblFMckNyRXQ1V1lyODlhanBuV0VNS1MveFlFS3dDZ2I5Ty9oUFJPODZH?=
 =?utf-8?B?RnFnZ3F0clJETWdOWkp0eTdFdVN3a0ROVGQxNm1oTEJGYkZLb3hVclpFOHdQ?=
 =?utf-8?B?b0hwNVJyNWcyY2VhQWJkUlJvRnlySFA1L2RLRXk5RVZVUTFnbEhvZWh5WUpB?=
 =?utf-8?B?bTFnbVZOSm5MbjJWV1ZLcG45RlRHandtSXlQbzM4VEpySDRXamJJbVF5MGxR?=
 =?utf-8?B?WFRrSVN2bmdJajMvbUhrMnM4MzhLeHdoQXlJUllIaEM1b1VWZnNBNTBvckV2?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <938734F83E07A048B65D95BC3D5BE5FA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adc20a6-f0f3-41ce-d7ad-08dcc278505c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 07:01:57.9759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tljk9ZJ+LGsljD2N+GPwN2OKdMFdAW3v/r8gBjGypLKq37imQ/NRLImyD/Fnic7B0nN07pvSWyB90ya8apTbwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7294

T24gVGh1LCAyMDI0LTA4LTIyIGF0IDExOjE2ICswODAwLCBUemUtbmFuIFd1IHdyb3RlOg0KPiBP
biBXZWQsIDIwMjQtMDgtMjEgYXQgMTQ6MDEgLTA3MDAsIEFsZXhlaSBTdGFyb3ZvaXRvdiB3cm90
ZToNCj4gPiAgCSANCj4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+IHVudGlsDQo+ID4geW91IGhhdmUgdmVyaWZpZWQg
dGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiAgT24gV2VkLCBBdWcgMjEsIDIwMjQgYXQg
MjozMOKAr0FNIFR6ZS1uYW4gV3UgPA0KPiA+IFR6ZS1uYW4uV3VAbWVkaWF0ZWsuY29tPg0KPiA+
IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBUaGUgcmV0dXJuIHZhbHVlIGZyb20gYGNncm91cF9icGZf
ZW5hYmxlZChDR1JPVVBfR0VUU09DS09QVClgIGNhbg0KPiA+IA0KPiA+IGNoYW5nZQ0KPiA+ID4g
YmV0d2VlbiB0aGUgaW52b2NhdGlvbnMgb2YgYEJQRl9DR1JPVVBfR0VUU09DS09QVF9NQVhfT1BU
TEVOYCBhbmQNCj4gPiA+IGBCUEZfQ0dST1VQX1JVTl9QUk9HX0dFVFNPQ0tPUFRgLg0KPiA+ID4g
DQo+ID4gPiBJZiBgY2dyb3VwX2JwZl9lbmFibGVkKENHUk9VUF9HRVRTT0NLT1BUKWAgY2hhbmdl
cyBmcm9tICJmYWxzZSINCj4gPiA+IHRvDQo+ID4gPiAidHJ1ZSIgYmV0d2VlbiB0aGUgaW52b2Nh
dGlvbnMgb2YNCj4gPiANCj4gPiBgQlBGX0NHUk9VUF9HRVRTT0NLT1BUX01BWF9PUFRMRU5gIGFu
ZA0KPiA+ID4gYEJQRl9DR1JPVVBfUlVOX1BST0dfR0VUU09DS09QVGAsDQo+ID4gPiBgQlBGX0NH
Uk9VUF9SVU5fUFJPR19HRVRTT0NLT1BUYA0KPiA+IA0KPiA+IHdpbGwNCj4gPiA+IHJlY2VpdmUg
YW4gLUVGQVVMVCBmcm9tDQo+ID4gDQo+ID4gYF9fY2dyb3VwX2JwZl9ydW5fZmlsdGVyX2dldHNv
Y2tvcHQobWF4X29wdGxlbj0wKWANCj4gPiA+IGR1ZSB0byBgZ2V0X3VzZXIoKWAgd2FzIG5vdCBy
ZWFjaGVkIGluDQo+ID4gDQo+ID4gYEJQRl9DR1JPVVBfR0VUU09DS09QVF9NQVhfT1BUTEVOYC4N
Cj4gPiA+IA0KPiA+ID4gU2NlbmFyaW8gc2hvd24gYXMgYmVsb3c6DQo+ID4gPiANCj4gPiA+ICAg
ICAgICAgICAgYHByb2Nlc3MgQWAgICAgICAgICAgICAgICAgICAgICAgYHByb2Nlc3MgQmANCj4g
PiA+ICAgICAgICAgICAgLS0tLS0tLS0tLS0gICAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0t
LS0tDQo+ID4gPiAgIEJQRl9DR1JPVVBfR0VUU09DS09QVF9NQVhfT1BUTEVODQo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVuYWJsZQ0KPiA+IA0KPiA+
IENHUk9VUF9HRVRTT0NLT1BUDQo+ID4gPiAgIEJQRl9DR1JPVVBfUlVOX1BST0dfR0VUU09DS09Q
VCAoLUVGQVVMVCkNCj4gPiA+IA0KPiA+ID4gVG8gcHJldmVudCB0aGlzLCBpbnZva2UgYGNncm91
cF9icGZfZW5hYmxlZCgpYCBvbmx5IG9uY2UgYW5kDQo+ID4gPiBjYWNoZQ0KPiA+IA0KPiA+IHRo
ZQ0KPiA+ID4gcmVzdWx0IGluIGEgbmV3bHkgYWRkZWQgbG9jYWwgdmFyaWFibGUgYGVuYWJsZWRg
Lg0KPiA+ID4gQm90aCBgQlBGX0NHUk9VUF8qYCBtYWNyb3MgaW4gYGRvX3NvY2tfZ2V0c29ja29w
dGAgd2lsbCB0aGVuDQo+ID4gPiBjaGVjaw0KPiA+IA0KPiA+IHRoZWlyDQo+ID4gPiBjb25kaXRp
b24gdXNpbmcgdGhlIHNhbWUgYGVuYWJsZWRgIHZhcmlhYmxlIGFzIHRoZSBjb25kaXRpb24NCj4g
PiANCj4gPiB2YXJpYWJsZSwNCj4gPiA+IGluc3RlYWQgb2YgdXNpbmcgdGhlIHJldHVybiB2YWx1
ZXMgZnJvbSBgY2dyb3VwX2JwZl9lbmFibGVkYA0KPiA+ID4gY2FsbGVkDQo+ID4gDQo+ID4gYnkN
Cj4gPiA+IHRoZW1zZWx2ZXMgYXMgdGhlIGNvbmRpdGlvbiB2YXJpYWJsZSh3aGljaCBjb3VsZCB5
aWVsZCBkaWZmZXJlbnQNCj4gPiANCj4gPiByZXN1bHRzKS4NCj4gPiA+IFRoaXMgZW5zdXJlcyB0
aGF0IGVpdGhlciBib3RoIGBCUEZfQ0dST1VQXypgIG1hY3JvcyBwYXNzIHRoZQ0KPiA+IA0KPiA+
IGNvbmRpdGlvbg0KPiA+ID4gb3IgbmVpdGhlciBkb2VzLg0KPiA+ID4gDQo+ID4gPiBGaXhlczog
MGQwMWRhNmFmYzU0ICgiYnBmOiBpbXBsZW1lbnQgZ2V0c29ja29wdCBhbmQgc2V0c29ja29wdA0K
PiA+IA0KPiA+IGhvb2tzIikNCj4gPiA+IENvLWRldmVsb3BlZC1ieTogWWFuZ2h1aSBMaSA8eWFu
Z2h1aS5saUBtZWRpYXRlay5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5naHVpIExpIDx5
YW5naHVpLmxpQG1lZGlhdGVrLmNvbT4NCj4gPiA+IENvLWRldmVsb3BlZC1ieTogQ2hlbmctSnVp
IFdhbmcgPGNoZW5nLWp1aS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IENoZW5nLUp1aSBXYW5nIDxjaGVuZy1qdWkud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBUemUtbmFuIFd1IDxUemUtbmFuLld1QG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0t
LQ0KPiA+ID4gDQo+ID4gPiBDaGFnbmVzIGZyb20gdjEgdG8gdjI6IA0KPiA+IA0KPiA+IA0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwODE5MDgyNTEzLjI3MTc2LTEtVHplLW5hbi5X
dUBtZWRpYXRlay5jb20vDQo+ID4gPiAgIEluc3RlYWQgb2YgdXNpbmcgY2dyb3VwX2xvY2sgaW4g
dGhlIGZhc3RwYXRoLCBpbnZva2UNCj4gPiANCj4gPiBjZ3JvdXBfYnBmX2VuYWJsZWQNCj4gPiA+
ICAgb25seSBvbmNlIGFuZCBjYWNoZSB0aGUgdmFsdWUgaW4gdGhlIG5ld2x5IGFkZGVkIHZhcmlh
YmxlDQo+ID4gDQo+ID4gYGVuYWJsZWRgLg0KPiA+ID4gICBgQlBGX0NHUk9VUF8qYCBtYWNyb3Mg
aW4gZG9fc29ja19nZXRzb2Nrb3B0IGNhbiB0aGVuIGJvdGggY2hlY2sNCj4gPiANCj4gPiB0aGVp
cg0KPiA+ID4gICBjb25kaXRpb24gd2l0aCB0aGUgbmV3IHZhcmlhYmxlIGBlbmFibGVgLCBlbnN1
cmluZyB0aGF0IGVpdGhlcg0KPiA+IA0KPiA+IHRoZXkgYm90aA0KPiA+ID4gICBwYXNzaW5nIHRo
ZSBjb25kaXRpb24gb3IgYm90aCBkbyBub3QuDQo+ID4gPiANCj4gPiA+IENoYWduZXMgZnJvbSB2
MiB0byB2MzogDQo+ID4gDQo+ID4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA4
MTkxNTU2MjcuMTM2Ny0xLVR6ZS1uYW4uV3VAbWVkaWF0ZWsuY29tLw0KPiA+ID4gICBIaWRlIGNn
cm91cF9icGZfZW5hYmxlZCBpbiB0aGUgbWFjcm8sIGFuZCBzb21lIG1vZGlmaWNhdGlvbnMgdG8N
Cj4gPiANCj4gPiBhZGFwdA0KPiA+ID4gICB0aGUgY29kaW5nIHN0eWxlLg0KPiA+ID4gDQo+ID4g
PiBDaGFnbmVzIGZyb20gdjMgdG8gdjQ6IA0KPiA+IA0KPiA+IA0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjQwODIwMDkyOTQyLjE2NjU0LTEtVHplLW5hbi5XdUBtZWRpYXRlay5jb20v
DQo+ID4gPiAgIEFkZCBicGYgdGFnIHRvIHN1YmplY3QsIGFuZCBGaXhlcyB0YWcgaW4gYm9keS4N
Cj4gPiA+IA0KPiA+ID4gLS0tDQo+ID4gPiAgaW5jbHVkZS9saW51eC9icGYtY2dyb3VwLmggfCAx
NSArKysrKysrKy0tLS0tLS0NCj4gPiA+ICBuZXQvc29ja2V0LmMgICAgICAgICAgICAgICB8ICA1
ICsrKy0tDQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0
aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9icGYtY2dy
b3VwLmggYi9pbmNsdWRlL2xpbnV4L2JwZi0NCj4gPiANCj4gPiBjZ3JvdXAuaA0KPiA+ID4gaW5k
ZXggZmIzYzNlNzE4MWU2Li41YWZhMmFjNzZhYWUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L2JwZi1jZ3JvdXAuaA0KPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC9icGYtY2dyb3Vw
LmgNCj4gPiA+IEBAIC0zOTAsMjAgKzM5MCwyMCBAQCBzdGF0aWMgaW5saW5lIGJvb2wNCj4gPiAN
Cj4gPiBjZ3JvdXBfYnBmX3NvY2tfZW5hYmxlZChzdHJ1Y3Qgc29jayAqc2ssDQo+ID4gPiAgICAg
ICAgIF9fcmV0OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIA0KPiA+ID4gICANCj4gPiANCj4gPiAgICAgICAgICAgICBcDQo+ID4gPiAgfSkNCj4gPiA+
IA0KPiA+ID4gLSNkZWZpbmUNCj4gPiANCj4gPiBCUEZfQ0dST1VQX0dFVFNPQ0tPUFRfTUFYX09Q
VExFTihvcHRsZW4pICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+ID4gICANCj4gPiAgXA0K
PiA+ID4gKyNkZWZpbmUgQlBGX0NHUk9VUF9HRVRTT0NLT1BUX01BWF9PUFRMRU4ob3B0bGVuLA0K
PiA+IA0KPiA+IGVuYWJsZWQpICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4gICh7ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAN
Cj4gPiA+ICAgDQo+ID4gDQo+ID4gICAgICAgICAgICAgXA0KPiA+ID4gICAgICAgICBpbnQgX19y
ZXQgPQ0KPiA+IA0KPiA+IDA7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXA0KPiA+ID4gLSAgICAgICBpZg0KPiA+IA0KPiA+IChjZ3JvdXBf
YnBmX2VuYWJsZWQoQ0dST1VQX0dFVFNPQ0tPUFQpKSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICANCj4gPiAgXA0KPiA+ID4gKyAgICAgICBlbmFibGVkID0NCj4gPiANCj4gPiBjZ3JvdXBfYnBm
X2VuYWJsZWQoQ0dST1VQX0dFVFNPQ0tPUFQpOyAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+
ID4gKyAgICAgICBpZiAoZW5hYmxlZCkNCj4gPiANCj4gPiANCj4gPiBJIHN1c3BlY3QgdGhlIGNv
bXBpbGVyIGdlbmVyYXRlcyBzbG93IGNvZGUgYWZ0ZXIgc3VjaCBhIHBhdGNoLg0KPiA+IHB3LWJv
dDogY3INCj4gPiANCj4gPiBXaGF0IGlzIHRoZSBwcm9ibGVtIHdpdGggZG91YmxlIGNncm91cF9i
cGZfZW5hYmxlZCgpIGNoZWNrPw0KPiA+IHllcyBpdCBtaWdodCByZXR1cm4gdHdvIGRpZmZlcmVu
dCB2YWx1ZXMsIHNvPw0KDQo+IERlcGVuZGluZyBvbiB3aGVyZSB0aGUgLUVGQVVMVCBvY2N1cnMs
IHRoZSBwcm9ibGVtIGNvdWxkIGJlDQo+IGRpZmZlcmVudC4NCj4gSW4gb3VyIGNhc2UsIHRoZSAt
RUZBVUxUIGlzIHJldHVybmVkIGZyb20gZ2V0c29ja29wdCgpIGR1cmluZyBhDQo+ICJib290dXAt
Y3JpdGljYWwgcHJvcGVydHkgc2V0dGluZyIgZmxvdyBpbiBBbmRyb2lkLiBBcyBhIHJlc3VsdCwg
dGhlDQo+IHByb3BlcnR5IHNldHRpbmcgZmFpbHMgZHVlIGl0IGdldCAtRUZBVUxUIGZyb20gZ2V0
c29ja29wdCgpLCBjYXVzaW5nDQo+IHRoZSBkZXZpY2UgdG8gZmFpbCB0aGUgYm9vdCBwcm9jZXNz
Lg0KPiANCj4gU2hvdWxkIHRoZSB1c2Vyc3BhY2UgY2FsbGVyIGFsd2F5cyBhbnRpY2lwYXRlIGFu
IC1FRkFVTFQgZnJvbQ0KPiBnZXRzb2Nrb3B0KCkgaWYgdGhlcmUncyBhbm90aGVyIHByb2Nlc3Mg
ZW5hYmxlcyBDR1JPVVBfR0VUU09DS09QVA0KPiAocG9zc2libHkgdGhyb3VnaCB0aGUgYnBmKCkg
c3lzY2FsbCkgYXQgdGhlIHNhbWUgdGltZT8NCj4gSWYgdGhhdCdzIHRoZSBjYXNlLCB0aGVuIEkg
d2lsbCBoYW5kbGUgdGhpcyBpbiB1c2Vyc3BhY2UuDQo+IA0KDQpCVFcsIElmIHRoaXMgc2hvdWxk
IGJlIGhhbmRsZWQgaW4ga2VybmVsLCBtb2RpZmljYXRpb24gc2hvd24gYmVsb3cNCmNvdWxkIGZp
eCB0aGUgaXNzdWUgd2l0aG91dCBicmVha2luZyB0aGUgInN0YXRpY19icmFuY2giIHVzYWdlIGlu
IGJvdGgNCm1hY3JvczoNCg0KDQorKysgL2luY2x1ZGUvbGludXgvYnBmLWNncm91cC5oOg0KICAg
IC0jZGVmaW5lIEJQRl9DR1JPVVBfR0VUU09DS09QVF9NQVhfT1BUTEVOKG9wdGxlbikNCiAgICAr
I2RlZmluZSBCUEZfQ0dST1VQX0dFVFNPQ0tPUFRfTUFYX09QVExFTihvcHRsZW4sIGNvbXBhdCkN
CiAgICAgKHsNCiAgICAgICAgICAgIGludCBfX3JldCA9IDA7DQogICAgICAgICAgICBpZiAoY2dy
b3VwX2JwZl9lbmFibGVkKENHUk9VUF9HRVRTT0NLT1BUKSkNCiAgICAgICAgICAgICAgICBjb3B5
X2Zyb21fc29ja3B0cigmX19yZXQsIG9wdGxlbiwgc2l6ZW9mKGludCkpOw0KICAgICArICAgICAg
ZWxzZQ0KICAgICArICAgICAgICAgICpjb21wYXQgPSB0cnVlOw0KICAgICAgICAgICAgX19yZXQ7
DQogICAgIH0pDQoNCiAgICAjZGVmaW5lIEJQRl9DR1JPVVBfUlVOX1BST0dfR0VUU09DS09QVChz
b2NrLCBsZXZlbCwgb3B0bmFtZSwNCm9wdHZhbCwgb3B0bGVuLCBtYXhfb3B0bGVuLCByZXR2YWwp
DQogICAgICh7DQogICAgICAgICBpbnQgX19yZXQgPSByZXR2YWw7DQogICAgLSAgICBpZiAoY2dy
b3VwX2JwZl9lbmFibGVkKENHUk9VUF9HRVRTT0NLT1BUKSAmJg0KICAgIC0gICAgICAgIGNncm91
cF9icGZfc29ja19lbmFibGVkKHNvY2ssIENHUk9VUF9HRVRTT0NLT1BUKSkNCiAgICArICAgIGlm
IChjZ3JvdXBfYnBmX3NvY2tfZW5hYmxlZChzb2NrLCBDR1JPVVBfR0VUU09DS09QVCkpDQogICAg
ICAgICAgICAgaWYgKCEoc29jayktPnNrX3Byb3QtPmJwZl9ieXBhc3NfZ2V0c29ja29wdCB8fA0K
ICAgICAgICAgICAgICAgLi4uDQoNCiAgKysrIC9uZXQvc29ja2V0LmM6DQogICAgaW50IGRvX3Nv
Y2tfZ2V0c29ja29wdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBib29sIGNvbXBhdCwgaW50IGxldmVs
LA0KICAgICB7DQogICAgICAgIC4uLg0KICAgICAgICAuLi4NCiAgICArICAgICAvKiBUaGUgbWVh
bmluZyBvZiBgY29tcGF0YCB2YXJpYWJsZSBjb3VsZCBiZSBjaGFuZ2VkIGhlcmUNCiAgICArICAg
ICAgKiB0byBpbmRpY2F0ZSBpZiBjZ3JvdXBfYnBmX2VuYWJsZWQoQ0dST1VQX1NPQ0tfT1BTKSBp
cw0KZmFsc2UuDQogICAgKyAgICAgICovDQogICAgICAgIGlmICghY29tcGF0KQ0KICAgIC0gICAg
ICAgbWF4X29wdGxlbiA9IEJQRl9DR1JPVVBfR0VUU09DS09QVF9NQVhfT1BUTEVOKG9wdGxlbik7
DQogICAgKyAgICAgICBtYXhfb3B0bGVuID0gQlBGX0NHUk9VUF9HRVRTT0NLT1BUX01BWF9PUFRM
RU4ob3B0bGVuLA0KJmNvbXBhdCk7DQoNCj4gVGhhbmtzLA0KPiAtLXR6ZS1uYW4NCg==

