Return-Path: <bpf+bounces-76119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACA1CA877A
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66E03302174F
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1B2DC773;
	Fri,  5 Dec 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="q+lU2ltL";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="TlGqifAV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266FF3446D2;
	Fri,  5 Dec 2025 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953855; cv=fail; b=hgQuRPlOiGsdlPETCTscow8WK4/h+TCkaoNhag92JKCbohRfAAoDlyJytzYNp3e2V6+UQZxoaqFgp8pnzoZpLA5dGr6NlYJlt5XqiB7FfNzFAvK+w+dKPTIOlnyR0GDxzkXfd+Jl/RpE5aDehuvHL4JejjttWsEylkjyiP5rf6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953855; c=relaxed/simple;
	bh=NtoY+xZbas8j4xWaeddNHDJzFtadIwWwJ5WmvQbMGaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cXDVstihlEKN/mazrLK70HGmOMczjTYg83Nx/CinPUh9YzvA3GdH7Dn4Zxv9K2B4b56q5LJp8O84w5ht3f4LJipRvstPR0IIgZ7L1s28DHCXiMnZWF+9/pnCIggrb7ad6pzt91GKKN4SMNfzEg2g02DyMY3zB1NsaAv00rqxy44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=q+lU2ltL; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=TlGqifAV; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5F1Yv6409105;
	Fri, 5 Dec 2025 08:56:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=NtoY+xZbas8j4xWaeddNHDJzFtadIwWwJ5WmvQbMG
	aw=; b=q+lU2ltLhTcY5p7hOhBe25wNROqPB+ZO2LZOPjlc2n+k6NEwCK1E7AF1d
	bvdmEOpXz36NoGlg6JvRvekre9yU2dn8nzMhhwCDpWN7gS46snUGsydPmGyi9HAo
	XwW/mLg9VZzssZGJ/HPWQYNqf3v21nS4zlfn9e3nGpEx7cj1SW7cMU10D7mMRWUP
	DO7K5Teukd++OP73qxZlin8f7xRB0AmWs6X32G+ce5Wqa+Llq91pXnrcZ+TW+F6q
	QwmMv9AYLxU1pr1jruEwC4DWord6bDyu6vX8WlmcLZKhQs6PiH6KEYLUNT4CrFIa
	b3hLrUDjvI7T9ICI4YfnuFC4JeDpg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020143.outbound.protection.outlook.com [52.101.85.143])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4au66d3v6w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 08:56:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWY2zECF1k3hMTzuuCmF4YfJGzhm4VMV3Q/nzN4tJsxW8qN1rybF19eXDejTtIMkEiWdwWE9Kxb3FMTcga3oA7nT4QdmZRwUkLrJ8Zxmx9Yy8hCDU9RiF9l2UL32CRzGuzFJe8K7HXU39ROE+Pv5cjp1pQHqNevUZRxpPH6t4LyGUboVOyce2AiLpdgbE23krEnuVWf3kXmem0TTAG+Q9kCXXFOEBcI2HsVSPQ8npO1HI5uZnfFlCW30f+0WABoSfTrnUa3IR8TSRp7tq4jUBDKeRyrJc88weZuuFYyoX/MxMEXNngV+IOQqEKISRjcLYcuXrkcbirfBEE+fHXHDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtoY+xZbas8j4xWaeddNHDJzFtadIwWwJ5WmvQbMGaw=;
 b=BN8LbgAwN8k9JNR7wjHU3+0/AHR8ljuMqnAKbpdN3LDfh57ffBpnQz0HC3JEqvw+ZeZvXr3wIgwh2ee3hKuqodCozzZT1kAAsciCs5GR8mPT2ES1BFyZWYXpFc0UgPlB6MXoG9KjeBFmlX0woG+QLpeFeUzYd8/KKT1DON59WuRDYLdmu32DGCBz0b+KM4OyEC9CbGWW7kr2zYyqU1VkrIYdRltOJ5bKqHZMgdmFwa0s6xHPfCX9A8Z3cdKMbLpIa7vYcBXk0vIx8QkfQek4qSR0+a2TvD4Hx+vPAZ2XZn4M9bD4lfoY5LRdk2JVNcgh7SzqSPgDt/7H7esUkTft8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtoY+xZbas8j4xWaeddNHDJzFtadIwWwJ5WmvQbMGaw=;
 b=TlGqifAVrdmlKDj/ZtTRE9INQWw1bl2NQeLCYwSJIxxChkavmGcE0VCp89Bk9uFfUnkisqgZZcsb7UkhG8jaSpPB3n4qti93U003UOKfqzgO/Wa3JfDTpRlP1OBMOMHKuHt+Epn62t8bGMtGum0RS+INWIWXZ1VVK/cVQcMfSDRCAUx6q39rB98T45MG0JK5sOQPhJuOX8U5f73NEGmc5WqCGTTWMn4af5Hg0Wm6SkGSfmGg3sKsh1TVVNgUJ9Xr4+uKp+rrr2QcgGCJvmi3RYLy34TArRMZk5/ty8LXXLu/n+mGNS2MYFk6pCRYxY53k3wxMpcIXvFtUFWt0ZhqUw==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by DM4PR02MB8887.namprd02.prod.outlook.com
 (2603:10b6:8:b4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 16:56:24 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9366.012; Fri, 5 Dec 2025
 16:56:24 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jason Wang
	<jasowang@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav
 Fomichev <sdf@fomichev.me>,
        open list <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexander Lobakin
	<aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
Thread-Topic: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
Thread-Index:
 AQHcXkBJGnA/Z0TBbE2dy0yPlIYpvLUHaj+AgAcwkgCAAAvqgIAA/5QAgAByBgCAAqTwgIAAWnWAgAA75gA=
Date: Fri, 5 Dec 2025 16:56:24 +0000
Message-ID: <6F20808D-445D-48DA-8481-4466D9A77659@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-6-jon@nutanix.com>
 <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
 <CF8FF91A-2197-47F7-882B-33967C9C6089@nutanix.com>
 <c04b51c6-bc03-410e-af41-64f318b8960f@kernel.org>
 <20251203084708.FKvfWWxW@linutronix.de>
 <CA37D267-2A2F-47FD-8BAF-184891FE1B7E@nutanix.com>
 <20251205075805.vW4ShQvN@linutronix.de>
 <3c1dac33-424f-4eda-83a9-60fb7f4b6c52@kernel.org>
In-Reply-To: <3c1dac33-424f-4eda-83a9-60fb7f4b6c52@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|DM4PR02MB8887:EE_
x-ms-office365-filtering-correlation-id: 2a8158a5-c285-4648-63de-08de341f3964
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dmJiK01wQ1M1OXBVR3R4WnlnWCtDUEoyV2M3b3V1ZERuTTg3WFBiTndkdGFB?=
 =?utf-8?B?SUt5WHNuUE0zVER6bkV4a2dmWWZkOWE2bVUvQW5Gci83UW9jNmFuRFExYjly?=
 =?utf-8?B?QU4yK2pIOE01N053L1VuN1FxWElXR3JzTUlQYkVaY1VnZEgzTGpTQ3pwbzZv?=
 =?utf-8?B?R1F4OXNjVTJSelBZMFJRT2N3SnE5MGFjeDB3MTJSK0V2cXEyZTlLUnh6Z2J0?=
 =?utf-8?B?akNxL0w1VGhkeWVOTE5MV003eUlRTTFCbE4yc0JnNm96UVV5L0RZTmpXSDZR?=
 =?utf-8?B?ZjZoY1h3NmtBQkJXMFMyNzZBM2lYc0NkT1FEaEIxQXVrb2VERStVZ3VqTXR3?=
 =?utf-8?B?bllkOEdxS21JSGtCUTBRN3M4M1RzMHR5OWdwRjJ0NzdBQVplK3pYRVcxMEl3?=
 =?utf-8?B?VGJtVEd4SDVQSG43NmlxWjlHL1NtcEFFcnN0eTR1ejcrQ1BDazBXZDZKNlVz?=
 =?utf-8?B?QzFyU1NtNzhsUXpaUExJVE9tZHZnc2RjN20xRFlLa0hRTkhDV3R2UUJQRk9J?=
 =?utf-8?B?czZxc2JtZkx5WGxaSGFkWGw2Uk9SbzBoc2ZSS2E4d2E1c0Zlc0ZGY0xjMjBC?=
 =?utf-8?B?WTVGR2Fvck9QT2hsN0x3YXNVWXlhRWpYamhkNnhWV0x2bFBpejNnWXo3ZzFj?=
 =?utf-8?B?cGgybmdGRWpJaEh2ckVnTmdyMzdKeUsrQ3plN0xlbyt3b0JkWmlGazRwbE54?=
 =?utf-8?B?eFZabWNnejF3cGRrQ3ZpdmZKdUdKcWg5ejJwWmdycjNXdU12dVAxbUoxaW1F?=
 =?utf-8?B?VW9yM3ZVeDJlV3BIV1RiZjY4QUh3Wi92Q3pveGtBUXphSWJUWmZZY054MnNq?=
 =?utf-8?B?NWZJRnAySTF1Z2xQVDFqTGpvTms4UGcwR2J3c043a1J1c2U5SHkyRTFIa014?=
 =?utf-8?B?c2I4amtkS1Vxak9nRy9nM0tvYXNCK3hRdER4R211OFpqRmxmQ0R5SnBlMWtu?=
 =?utf-8?B?clRGWGFQK3g3VnAvMmNvb3dsNXFPVmdpQ1g4WVc5bVZkNjJsWlRHa3cvek5L?=
 =?utf-8?B?OFdYOElrTGpSYzEyTXZrVHA0Yi9ZYXQ5QkFYZ3I2OHNQVEtaUFpRbzJiam9I?=
 =?utf-8?B?Zm54bCtuN09LTUxCeXJkdSt6cnJQUnliUHBPVFE3bWx3S1NNbEVEU1JneHh0?=
 =?utf-8?B?S2oyclJCWHdlOVNnUHljdXUwWHo3enlJN00rdWhTVzJRRFJ5QkxsNzhvYUt6?=
 =?utf-8?B?S0plU2RGcUUyZkRCdDdOODdPRm43dzk3VzNoUkNvdFltem01ZjlDWTJGVzlW?=
 =?utf-8?B?bGFkV1dVdGpXSzJBRjZlbG90YVhBZUxsYjVFcUVMNnJyWmpBZTdGVXNCQU03?=
 =?utf-8?B?b3VBYkdzaVlHZ29FRFNiTDJiQ1pidWtxcEtwMVlvMVJSbHo4Qld6MlZxclVj?=
 =?utf-8?B?MmNCVlpualB1eSt4WmRzVm9DMnZjSlNNbUhFc3pOZkVlV1dKVjlVY2htYVpY?=
 =?utf-8?B?MFdxTVdHczE2OHZWVUdYODBvZ3JOQ045eWVERStDUVZXQnNnb1Y4Ulk3YkQr?=
 =?utf-8?B?emFoY2xVTEJrZk5iay9TQVFYc2FOSjUvRVlQTmN3ZUl0c3lyN2FOVFcxVHpT?=
 =?utf-8?B?cFk3Uk8xeERPZDM1ZUF2RFBIZ3JEM0FRY1Jlb29semFCazNnSGlQeE8wdjQ1?=
 =?utf-8?B?eXM4Y0lySkd6T2F6TkZNeGRUVzhHT2tYeUEyTjVJM0wrays3SGN5TEFTeEIw?=
 =?utf-8?B?ZWNXRGQyTDhhY0VtdysxdVIzYUpmMTN2Z2NHVis5eVJVYVlsWk5PNTJ5VVAz?=
 =?utf-8?B?VFV1UFB6WHJtVTBLVGs0bXlkMCtjcnRtbzFrWmhzT2d6VzlnSkpZZjhQb244?=
 =?utf-8?B?dTRuMmlYNU82VUdScklORWlhamx1Q0IyV1dtWEphZjVldFFXQUZrYUZuOHFB?=
 =?utf-8?B?OExmSFhmZ3o2Y3dVNGZvdGZqUzhrWkhHaHNuamdFVUFneFo5M2piRFI2elg0?=
 =?utf-8?B?NHNTRGVERGVFWmwyRncwQTNIWGNRS0RhS2ZQZTdDK0xxT043T1hTZldhc2N0?=
 =?utf-8?B?SlFRQzQ5aHpPbTlWWWpSWElpa0ttOWEwQXRnMmdPeVR4czNQelNoSEQ3VnpG?=
 =?utf-8?Q?v8PBLN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cC96Y1JTYVY2Rld5MnUwSWJGeE9kRHBNR2dBNEF6ejdTemo5eG9lRFJkYld2?=
 =?utf-8?B?clhBNThxNitTWVZhWEVXY1FobXhJZXlKWTgvbEdOZ0JuaWk5NlkveWMyakVG?=
 =?utf-8?B?STV0NlpBSjFUOUFnYzNiV3RlU2owTW1mbGkxZkR4ZnZmNnBxMEFKWWZhMElI?=
 =?utf-8?B?WWxicWtCdzJveHRmR3FnaVprNDJhbHNPa09HV3VEVGQwNjE4Z2s0TWl6MFV1?=
 =?utf-8?B?cVNXRzk2NEFpNEhGZFM2YjdjVU5obTg0Qy9ldU5PTjVwdGxVdW81VENETG0x?=
 =?utf-8?B?WkdIYnNuMzFHUEo3UjFGbnQ1TmdyMktGekl6eVdkejB4bzNwYUtlOVlJc3M2?=
 =?utf-8?B?YTZMdWdMdmNNK2JWVFkxODRVWmltMDF2T3N0b2FQcEdKZ005VUlpenVnTzJz?=
 =?utf-8?B?NFhOOHE0ckRxUTVnL0Z5RnhERm1BNmhlMVY2dk9hMUZFVWh4aCtWbTdNeEpl?=
 =?utf-8?B?aHpBd2lqQ3JsRHlmRTIrL2JyN2w0SStJbmlkZmE5eDdVVGMxcXF1c3FwNHNV?=
 =?utf-8?B?L2FqbFBiaFpoUjdSUEtkaXVzYUdIMGMwWmlYRW41eUgvWEN6THR1MEp6ZjFI?=
 =?utf-8?B?aDNwR1Y3ZURZTnB1OXA2Tnd4c3pTaHZmb1Z4TGFEaytKRGI5TTRtTmVLNnlx?=
 =?utf-8?B?MWl3b0NkMDNscnlaNkVpT09UNWpUdlJWc05UVTdQUGU5cWNIbUVrTGUvNk9L?=
 =?utf-8?B?aWFKRlh5cmlNUXRsZkt6S2VvSnhtR0dvUktLNnlMZU80YmxoWGVRSjcrN0Iw?=
 =?utf-8?B?SDlDM2NVVGNaam9qMldXV3BwaHhyZEJQOFkyUEhoM0Ira3dVRWVSdEQrc3JX?=
 =?utf-8?B?UjJibHR6U1pHaUpraXBIRlp2YnYyWXY2MHdUZkxHZnZRbW5CNFYrUDhzYzhR?=
 =?utf-8?B?aUhjM1gxM3FySGxvQ2VSL0t1TEhUVmRqSWlsSUNKRnppeVNHQmdENUN4RnE5?=
 =?utf-8?B?WXdQb2N6U1pMODk5Tld4VWJ4RU5aMXdBK3hxYkZBcmQyZnlUOW9BdWFTNURl?=
 =?utf-8?B?cTM3MmpmbEo3QVI1WEw4WHp4c3FUWW50MlBpc3kyWXVGeStNUjN4YTljUlMw?=
 =?utf-8?B?NVFGa3RKc3hhZU81UWdsak5tY2NaSDVRcTNKeG10QkdWZ0tkcGVrUE4zT1Bw?=
 =?utf-8?B?WFQ1T0V5emhxOUhQMUlNanJEQlIrZFZkNUcxTUNJckYycUJKUFFLdzJOTHJW?=
 =?utf-8?B?RWp6WTV0NmZTdlRBY1hLaFp3bGptTytqVHBSdVhDbFAzekxsYkRVdWJyYzFU?=
 =?utf-8?B?OFdqNlhXNld1ZXA3Nk1MdHNsckhQWExoN01FTmo4dzhoUHFONGxJSTEwU2dP?=
 =?utf-8?B?S1BXRDZmMStGaDdNdlFHSU9uUERybWx5bUlXbGgwNTE0NDIvY29XZ2g3dXdm?=
 =?utf-8?B?ZmxFSC81TUlvQ0pQSyt4RlBiRlZ1dzdmZkZPU3h2U2ZmUjFPNlZyNnBFTEYv?=
 =?utf-8?B?T1hsUXgraEVIaE13YVhFbmJ5cG53UkNCWklwTHdNUk5VbWI5WFdmN1Z2RE00?=
 =?utf-8?B?RVI1QXVDamJFWmNoN0FpY2hrUXdjU2FCSkk3eGg1N2dEa0ovbGVRM0dUWUhs?=
 =?utf-8?B?OGxzVVUxZS9lMHdpa2hTZDhjQlg3TTljRkp1VnZkZXlzQU9tMkxrNHVrd2Za?=
 =?utf-8?B?NmJwTkpVTHVGWGpCMEJMRXNOU0FuMCs2MkMyT1J6aXlIT2NOU1E2d0EvSzJt?=
 =?utf-8?B?aWdEeWdzNUN2YXhtd0w2ZHdJc3NDQ3JSMDZPbkdtSzlyUW15QjlYb0RIZ2xO?=
 =?utf-8?B?U2lZZ3B4d25xdmtVSnc4ZlpPRHRJSlBpbHAwMkdQVWhaZTJvaElKS0J3N1lE?=
 =?utf-8?B?MXNOVzFac2RvZ051ZlRwT09UL0U3TFNOQ2VJMXNITndGclJhdGZGdjh5VStG?=
 =?utf-8?B?MEFFbG1SRlZqRjlxbHEzVUx0bG85T0w2WHQramY0c1puSkU0K0FLeWZkVXpS?=
 =?utf-8?B?Y0s1ZFNHTEx2Y2RPYnVJTkZ3UFdtdUpYNW4vUmQ2WCtnS0FuK1k4MTFaQS9P?=
 =?utf-8?B?VFoyMXRVTEV4aXVNZCtwRkxSSkQ2T2NmM2dzNklOQ2x0YnByM0V4TjNwM2po?=
 =?utf-8?B?K0txUk9qbC9IcE9iWHpmaGZGV3JCNkhYdTNEY2E4MmZ5L0NnMHQrQTFOazFo?=
 =?utf-8?B?cWx1MHlCdjRYNVZ3NEsyZk1mVDBIbWNnaW5jeXlLZTA1NDdhdnBCNkdLU0Vj?=
 =?utf-8?B?MGZOYUJsSU5iaVpjOG41ZlpZS1JaKzVndTBmYkxZdEVJSEZVVVVnb2hXWUJz?=
 =?utf-8?B?d0VhOHAyRUoxRWlpWmVhTEFoVzdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <725805481B3FFB43946A10449359CB60@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8158a5-c285-4648-63de-08de341f3964
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 16:56:24.4380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPlpfabg7fGUQ/FIjWEsRuhNhC2ZVXUk0gSwoZsb3q4mWGRpZvpxIqiZWOx9JzXGyiKR9b/k30rg1PIm2JcJNeilVL6MY1mX5eGEGerGCH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8887
X-Proofpoint-ORIG-GUID: tIlwBFHEUzzL0NG9yF-e7X3Yka-aP73v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEyNCBTYWx0ZWRfX/6nzp30pGDbB
 NdHVOP/HvdkNOx/36qpBYXYGJVkU/nd+L47r0aWB54GDppjZG/DVpwOzrEkUNIHMIQYqtPD53UL
 iuLUj+RE5D4eY6Oo0h8rRwRkUUI8q2P20ipROA9kiPNr125yZZlO/xsnvQH4ImQPl45NTkukTei
 c43UTMeFuczeQcPHQXwUpYYUZGT+nW43/8m2C32th+o5GTHMsLra9ES8VrbD+prxuM8DFU3obLv
 XRCyNxo5AQzFmU/0xNSy/JYgX+W6+tYVDeF3LbjjlLBMsB0XCM1MWbLguxKgRKUm/kzFGfkCpaW
 xqi/ai6Icr/4abI9a3NI0udjpn3UrQfwAQivd9e7WSKezOzjhr4Sa8i9HDCt+lnCc6foHcc9Y2I
 6nnrpDL47JDHwQPcyZ06BxqcXZLVJw==
X-Proofpoint-GUID: tIlwBFHEUzzL0NG9yF-e7X3Yka-aP73v
X-Authority-Analysis: v=2.4 cv=Ve36/Vp9 c=1 sm=1 tr=0 ts=69330eba cx=c_pps
 a=VFd5apzHAUrRjeJ3DCr5RQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Kq-AwXYdcT5Q6QJyHEcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gRGVjIDUsIDIwMjUsIGF0IDg6MjHigK9BTSwgSmVzcGVyIERhbmdhYXJkIEJyb3Vl
ciA8aGF3a0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IA0KPiANCj4gT24gMDUvMTIvMjAyNSAw
OC41OCwgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciB3cm90ZToNCj4+IE9uIDIwMjUtMTItMDMg
MTU6MzU6MjQgWyswMDAwXSwgSm9uIEtvaGxlciB3cm90ZToNCj4+PiBUaGFua3MsIFNlYmFzdGlh
biAtIHNvIGlmIEnigJltIHJlYWRpbmcgdGhpcyBjb3JyZWN0LCBpdCAqaXMqIGZpbmUgdG8gZG8N
Cj4+PiB0aGUgdHdvIGZvbGxvd2luZyBwYXR0ZXJucywgb3V0c2lkZSBvZiBOQVBJOg0KPj4+IA0K
Pj4+ICAgIGxvY2FsX2JoX2Rpc2FibGUoKTsNCj4+PiAgICBza2IgPSBuYXBpX2J1aWxkX3NrYihi
dWYsIGxlbik7DQo+Pj4gICAgbG9jYWxfYmhfZW5hYmxlKCk7DQo+Pj4gDQo+Pj4gICAgbG9jYWxf
YmhfZGlzYWJsZSgpOw0KPj4+ICAgIG5hcGlfY29uc3VtZV9za2Ioc2tiLCAxKTsNCj4+PiAgICBs
b2NhbF9iaF9lbmFibGUoKTsNCj4+PiANCj4+PiBJZiBzbywgSSB3b25kZXIgaWYgaXQgd291bGQg
YmUgY2xlYW5lciB0byBoYXZlIHNvbWV0aGluZyBsaWtlDQo+Pj4gICAgYnVpbGRfc2tiX2JoKGJ1
ZiwgbGVuKTsNCj4+PiANCj4+PiAgICBjb25zdW1lX3NrYl9iaChza2IsIDEpOw0KPj4+IA0KPj4+
IFRoZW4gaGF2ZSB0aG9zZSBtZXRob2RzIGhhbmRsZSB0aGUgbG9jYWxfYmggZW5hYmxlL2Rpc2Fi
bGUsIHNvIHRoYXQNCj4+PiB0aGUgdG9nZ2xlIHdhcyBhIHByb3BlcnR5IG9mIGEgY2FsbCwgbm90
IGEgcmVxdWlyZW1lbnQgb2YgdGhlIGNhbGw/DQo+PiBIYXZpbmcgYnVkZ2V0ID0gMCB3b3VsZCBi
ZSBmb3Igbm9uLU5BUEkgdXNlcnMuIFNvIHBhc3NpbmcgdGhlIDEgaXMNCj4+IHN1cGVyZmx1b3Vz
LiBZb3UgZ29hbCBzZWVtcyB0byBiZSB0byByZS11c2UgbmFwaV9hbGxvY19jYWNoZS4gUmlnaHQ/
IEFuZA0KPj4gdGhpcyBpcyBiZXR0ZXIgdGhhbiBza2JfcG9vbD8NCg0KWWVzLCB0aGUgZ29hbCBp
cyB0byBhdm9pZCB0aGUgYWxsb2NhdGlvbiAvIGRlYWxsb2NhdGlvbiBvdmVyaGVhZCwgd2hpY2gg
aXMNCnZlcnkgdmlzaWJsZSBpbiBmbGFtZWdyYXBocywgYW5kIGRvaW5nIGl0IHRoZSB3YXkgSeKA
mXZlIGRvbmUgaXQgaGVyZSBkb2VzDQpiZW5lZml0IHRoZSBiZW5jaG1hcmsgSSB1c2VkOyBob3dl
dmVyLCBhcyBKYXNvbiBwb2ludGVkIG91dCwgSSBuZWVkIHRvDQpsb29rIG1vcmUgYnJvYWRseSwg
c28gSeKAmWxsIGRvIHRoYXQgZm9yIHRoZSBuZXh0IHRpbWUgYXJvdW5kLg0KDQo+PiBUaGVyZSBp
cyBhbHJlYWR5IG5hcGlfYWxsb2Nfc2tiKCkgd2hpY2ggZXhwZWN0cyBCSCB0byBiZSBkaXNhYmxl
ZCBhbmQNCj4+IG5ldGRldl9hbGxvY19za2IoKSAoYW5kIGZyaWVuZHMpIHdoaWNoIGRvIGRpc2Fi
bGUgQkggaWYgbmVlZGVkLiBJIGRvbid0DQo+PiBzZWUgYW4gZXF1aXZhbGVudCBmb3Igbm9uLU5B
UEkgdXNlcnMuIEhhdmVuJ3QgY2hlY2tlZCBpZiBhbnkgb2YgdGhlc2UNCj4+IGNvdWxkIHJlcGxh
Y2UgeW91ciBuYXBpX2J1aWxkX3NrYigpLg0KPj4gSGlzdG9yaWNhbGx5IG5vbi1OQVBJIHVzZXJz
IHdvdWxkIGJlIElSUSB1c2VycyBhbmQgdGhvc2UgY2FuJ3QgZG8NCj4+IGxvY2FsX2JoX2Rpc2Fi
bGUoKS4gVGhlcmVmb3JlIHRoZXJlIGlzIGRldl9rZnJlZV9za2JfaXJxX3JlYXNvbigpIGZvcg0K
Pj4gdGhlbS4gWW91IG5lZWQgdG8gZGVsYXkgdGhlIGZyZWUgZm9yIHR3byByZWFzb25zLg0KPj4g
SXQgc2VlbXMgcHVyZSBzb2Z0d2FyZSBpbXBsZW1lbnRhdGlvbnMgZGlkbid0IGJvdGhlciBzbyBm
YXIuDQo+PiBJdCBtaWdodCBtYWtlIHNlbnNlIHRvIGRvIG5hcGlfY29uc3VtZV9za2IoKSBzaW1p
bGFyIHRvDQo+PiBfX25ldGRldl9hbGxvY19za2IoKSBzbyB0aGF0IGFsc28gYnVkZ2V0PTAgdXNl
cnMgZmlsbCB0aGUgcG9vbCBpZiB0aGlzDQo+PiBpcyByZWFsbHkgYSBiZW5lZml0Lg0KPiANCj4g
SSdtIG5vdCBjb252aW5jZWQgdGhhdCB0aGlzICJvcHRpbWl6YXRpb24iIHdpbGwgYmUgYW4gYWN0
dWFsIGJlbmVmaXQgb24NCj4gYSBidXN5IHN5c3RlbS4gIExldCBtZSBleHBsYWluIHRoZSBzaWRl
LWVmZmVjdCBvZiBsb2NhbF9iaF9lbmFibGUoKS4NCj4gDQo+IENhbGxpbmcgbG9jYWxfYmhfZW5h
YmxlKCkgaXMgYWRkaW5nIGEgcmUtc2NoZWR1bGluZyBvcHBvcnR1bml0eSwgZS5nLg0KPiBmb3Ig
cHJvY2Vzc2luZyBzb2Z0aXJxLiAgRm9yIGEgYmVuY2htYXJrIHRoaXMgbWlnaHQgbm90IGJlIG5v
dGljZWFibGUgYXMNCj4gdGhpcyBpcyB0aGUgbWFpbiB3b3JrbG9hZC4gIElmIHRoZXJlIGlzbid0
IGFueSBwZW5kaW5nIHNvZnRpcnEgdGhpcyBpcw0KPiBhbHNvIG5vdCBub3RpY2VhYmxlLiAgSW4g
YSBtb3JlIG1peGVkIHdvcmtsb2FkIChvciBwYWNrZXQgc3Rvcm0pIHRoaXMNCj4gcmUtc2NoZWR1
bGluZyB3aWxsIGFsbG93IG90aGVycyB0byAic3RlYWwiIENQVSBjeWNsZXMgZnJvbSB5b3UuDQo+
IA0KPiBUaHVzLCB5b3UgbWlnaHQgbm90IGFjdHVhbGx5IHNhdmUgYW55IGN5Y2xlcyB2aWEgdGhp
cyBzaG9ydCBCSC1kaXNhYmxlDQo+IHNlY3Rpb24uICBJIHJlbWVtYmVyIHRoYXQgSSB3YXMgc2F2
aW5nIGFyb3VuZCAxOW5zIC8gNjhjeWNsZXMgb24gYQ0KPiAzLjZHSHogRTUtMTY1MCBDUFUsIGJ5
IHVzaW5nIHRoaXMgU0tCIHJlY3ljbGUgY2FjaGUuICBUaGUgY29zdCBvZiBhIHJlLQ0KPiBzY2hl
ZHVsaW5nIGV2ZW50IGlzIGxpa2UgbW9yZS4NCj4gDQo+IE15IGFkdmljZSBpcyB0byB1c2UgdGhl
IG5hcGlfKiBmdW5jdGlvbiB3aGVuIGFscmVhZHkgcnVubmluZyB3aXRoaW4gYQ0KPiBCSC1kaXNh
YmxlZCBzZWN0aW9uLCBhcyBpdCBtYWtlcyBzZW5zZSB0byBzYXZlIHRob3NlIGN5Y2xlcw0KPiAo
ZXNzZW50aWFsbHkgcmVkdWNpbmcgdGhlIHRpbWUgc3BlbmQgd2l0aCBCSC1kaXNhYmxlZCkuICBX
cmFwcGluZyB0aGVzZQ0KPiBuYXBpXyogZnVuY3Rpb24gd2l0aCBCSC1kaXNhYmxlZCBqdXN0IHRv
IHVzZSB0aGVtIG91dHNpZGUgTkFQSSBmZWVscw0KPiB3cm9uZyBpbiBzbyBtYW55IHdheXMuDQo+
IA0KPiBUaGUgYW5vdGhlciByZWFzb24gd2h5IHRoZXNlIG5hcGlfKiBmdW5jdGlvbnMgYmVsb25n
cyB3aXRoIE5BUEkgaXMgdGhhdA0KPiBuZXRzdGFjayBOSUMgZHJpdmVycyB3aWxsIChhbG1vc3Qp
IGFsd2F5cyBkbyBUWCBjb21wbGV0aW9uIGZpcnN0LCB0aGF0DQo+IHdpbGwgZnJlZS9jb25zdW1l
IHNvbWUgU0tCcywgYW5kIGFmdGVyd2FyZHMgZG8gUlggcHJvY2Vzc2luZyB0aGF0IG5lZWQNCj4g
dG8gYWxsb2NhdGUgU0tCcyBmb3IgdGhlIGluY29taW5nIGRhdGEgZnJhbWVzLiAgVGh1cywga2Vl
cGluZyBhIGNhY2hlIG9mDQo+IFNLQnMganVzdCByZWxlYXNlZC9jb25zdW1lZCBtYWtlcyBzZW5z
ZS4gIChwLnMuIGluIHRoZSBwYXN0IHdlIGFsd2F5cw0KPiBidWxrIGZyZWUnZWQgYWxsIFNLQnMg
aW4gdGhlIG5hcGkgY2FjaGUgd2hlbiBleGl0aW5nIE5BUEksIGFzIHRoZXkgd291bGQNCj4gbm90
IGJlIGNhY2hlIGhvdCBmb3IgbmV4dCByb3VuZCkuDQo+IA0KPiAtLUplc3Blcg0KDQpIZXkgSmVz
cGVyLCB0aGFua3MgZm9yIHRoZSBjb21tZW50YXJ5LCBJIGFwcHJlY2lhdGUgaXQuIEnigJlsbCBj
aGV3IG9uIHRoYXQNCmZvciB0aGUgbmV4dCByZXZpc2lvbiBvZiB0aGlzIHdvcmsgYW5kIHNlZSB3
aGVyZSBpdCBsYW5kcy4NCg0KVGhhbmtzIGFnYWluIC0gSm9uDQoNCg==

