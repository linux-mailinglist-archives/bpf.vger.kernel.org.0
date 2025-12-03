Return-Path: <bpf+bounces-75980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A5CA0B05
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 18:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63BCF301C3F2
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93FC32D44E;
	Wed,  3 Dec 2025 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="EBd1biZc";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="KOh7x2j0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E9306D2A;
	Wed,  3 Dec 2025 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780537; cv=fail; b=qjENDC6gx1TvDWCqlxP0Ps09tJxHr+eaM8eVSNZGDP3BTIOI6WINBqQatOXSER931P6Ia+wRmNUXvYDfCI6UFzij7wnKYZZgKQ/GCkQaHXotDRePC45yguablGZHSbxjnHWN/LROjFdyVAEYlYUQxMvh07p9rmBEbImNMr/ho+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780537; c=relaxed/simple;
	bh=GTwvmhXLZ+bMx6e6rfJhMrxpwe1JojxZ+7LD6bX3XnY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XgLtDVrcW0gH7mu/tlkESjlGuJMQfrS8cskJk+78gXhQAvR95a53VILFN1hUfMBJEUH5E8ze4CYvfKWAp7oJavGeOFfMZhbR78duFun1B33etAQQ7SQzOAILJcOmPRhDapNQBBRkznaMo1dWAaWmMYtNtvsF0heV75I/xeMvOsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=EBd1biZc; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=KOh7x2j0; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B3AmHkQ2332163;
	Wed, 3 Dec 2025 08:48:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=GTwvmhXLZ+bMx6e6rfJhMrxpwe1JojxZ+7LD6bX3X
	nY=; b=EBd1biZcCD9zKpCbACZQmYf5vg78xLl2o4LfmHbOGdlzpXKZEdgyO38Z/
	FBrUQOMYpbb2nrUvKtlh23qn7nBJASMW1SGpTltTV/XrFusJmPn1djfe5AxFRQyn
	4eImIuNan1o95y/NlQbM2qWUh98thJSIHTM+ji2aVrju/WnJfZqIMnpWuhSPH8HH
	t7kItW3iVYpwfLaE3NQ2KeQuo1i4B4j1Gx+9q4aX4UVW7ns9+RIi3xr6aHT+lwja
	rk7dVwxm+BBrf0pDVd8uDLlRwkqUtyLqvXiJ8VwnvC+KLM+LAsXjDtG/YkVpOc58
	BEvwYLkH9GokT0IghZvpLjUfZ3jjQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023140.outbound.protection.outlook.com [40.93.201.140])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4atksb8r5w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 08:48:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOy8HilgG3sr+53VpO0PEN9lsQHeXOGZJYUq2XlR2i0aeOFYBhZiJYN4sRyPf3NRE6rrjHaecXIeJkmJ7uxScLD6GoX7YZzLCOj9Kr0QRcnAMKCWNOHV1rrwnb69jAyKgxwWFbuNUONKJrdJW+pfp4t16kENaSB2fGBb/Rg4fJ/q+NtraSfxY3EZnDPjHwnAdafnNsyWFjHnljksIhhisHfWHCFuiVnUZuMiJjTGhUqo2DfhIg4reWtc485Il06Lyf472WU+5zgNOagd/JoJ2bngrvifz355UuboAH8oBuNCuCD3IQM+3HAIzXgi5jR9Sv4ikoCJoQWQsQrh1tnmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTwvmhXLZ+bMx6e6rfJhMrxpwe1JojxZ+7LD6bX3XnY=;
 b=NQeNk/DXqvRgxRj69tUtg5f+gEzpXlos1i+vByB260CkL/Wma25pwcTNzWr5y6g+7Q2mkBd5pBnzIaHMCeP+Yr63lSQvxLPGHEEXmGBmNEiywNcpaSLiFrWNKi421eH0qaDHG3PFJ3nSM2uyn8nDDevJB6ZDVAeLsu7hkJDgowJLF6KROEk9gO/JGFKvNiAjDqG1VrttHhrCIXnxP3aclwpTKUJUvuNB0FhxptIwgPpzbfQML6K5tAgj3aBwaG3pXtU6t9Lp8YdvL6wCvr8HWetPsfUP8VKIhDqWQf/oRDa7jnvBoDaWBadEKXdxJsGgEU3h3zgBXR7acCYpvlmOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTwvmhXLZ+bMx6e6rfJhMrxpwe1JojxZ+7LD6bX3XnY=;
 b=KOh7x2j0bDBEpAPZjXFg+tM+qD+lV5vk2DzVEWaGqWyG77h41JMDf+cqWkk/VqgY7f46PqOyFN4a7XGG8V9eTDsmMaIpKQS5l0CY8nL4fkpx+RLgSsFbtr/xtXOb4g5rNicrVPnFFZFrKJd/r0L9w0yg/XC6JQ88sw9JtFXDybYeMeOfv0KH0AT0Nf8E0leFztTE6Gub+4Du0tr9yFVerCo8O8yUU4mctxItcf0kJMZoBd2+r7H1pH7FB2UYWkZIHGFmUkpZamhRt445iRVaeEnwYvrCC+zKGNbYV+QGmdyNoHFMDGCifhEdC0iBqHeEs0K9tZ2XWQTzigyO6nQnBQ==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by MN2PR02MB6846.namprd02.prod.outlook.com
 (2603:10b6:208:1d1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 16:48:28 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 16:48:28 +0000
From: Jon Kohler <jon@nutanix.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>,
        Tomas Glozar
	<tglozar@redhat.com>,
        "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] perf build: build BPF skeletons with fPIC
Thread-Topic: [PATCH] perf build: build BPF skeletons with fPIC
Thread-Index: AQHcZAK5geAQT2zeqk68v6nt5V4NBLUQH9SAgAABZYA=
Date: Wed, 3 Dec 2025 16:48:28 +0000
Message-ID: <43E321AF-981C-4D7B-9092-E54F6D10E941@nutanix.com>
References: <20251203035526.1237602-1-jon@nutanix.com> <aTBopdY6tmmxbDuu@x1>
In-Reply-To: <aTBopdY6tmmxbDuu@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|MN2PR02MB6846:EE_
x-ms-office365-filtering-correlation-id: ce344425-fe0c-49f3-9566-08de328bc8a3
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Sm9SM0RDbVUxalZ0NU9LelEzY0lpUTY1aFozaGZNS0h6bmt6TE1HMmt0cUlN?=
 =?utf-8?B?MGVPSnhLQUdib0RYL2o3YzJBYThxeGRZcVQ2Mk5HU0hEcmlnYWpMcEN1R053?=
 =?utf-8?B?Y00xSUthbUtqRlhvcXVSMTNwMVR0NnNpRVVNLzVjQXNGckdtcjYrb0RPdzRO?=
 =?utf-8?B?QnBqUkZqdDVqcXZvaCtTR0VlZ2dYT1JoeTdpYTk0T1JhSXBDSm1BclBuRmY3?=
 =?utf-8?B?K0tlaUlWeitXY3Z2aCtkc3U0YVJCcitVeVo5SVgwMkZRMnZEdW4xamlJdXVC?=
 =?utf-8?B?RCtaa2FJZ3FwRXI1ZDlsSFBZNVhpTlQzL1hReEE2RG0xb3hYRmRlYkZnSGNx?=
 =?utf-8?B?L1VWZTVBS1BmRHZRZzl5WmFOZkRFSE4rVUYyM29VN0huZFlOcUI5VkdaOTJ4?=
 =?utf-8?B?bytLYnNTS0thVXZINUtwdjhtV3FqbjltSFNrNmNlaTlmS01BMHNMaWhhREhv?=
 =?utf-8?B?WEcyTU51Zyt3ZUk3Nk5MRVNBbEYwVHloQm1XTnd0dlcxNWpnei96U0tzd1Bp?=
 =?utf-8?B?Y29QZHVnNFNMQnk0RkNONm1BREQ1Uk42Skg5TUN1VjMrOTkxY2t6ajU3c2FH?=
 =?utf-8?B?L3AwbHdXN2ZIbEZ1ZXYrWDFkV3FwZG9CQzRzZzNMMzVYV1lEbzVSR2pYbFdE?=
 =?utf-8?B?Y2RDL2lvTUtaNjA0ckFES2w0ZVB0TW5mM3BZVnFHUXFqb3FrN3Q2Znp1OGxE?=
 =?utf-8?B?RVprc1FpTFVPU2NDNHFDUUhKMlNwem9GenhSbHpRTUcrTEk2ZUV3RHZMWWh1?=
 =?utf-8?B?Nmg5R1RtMFVmVVhBMS9nT1lESGQ0SUtzWTNmTEI1UEI4b29MMy9Dbml5RDFN?=
 =?utf-8?B?MC9ieWsyY040Zkw3R0ZkRU41SlRORDQ5SzJZS3lXZUViTk1hanR5b1RxMzQ4?=
 =?utf-8?B?T2V2ZlFiMXhMSUNBY0xaVXAxUEhTWmpGcG9sN0xaN2hCWm0yREYyVzRsWkZj?=
 =?utf-8?B?M3F6K1dMQnBNcXB6Y0syZ3lNYk9aQnFXKytRTGlZdlZqbmhRUFJuUUNzSkNq?=
 =?utf-8?B?VkhyVXVmOFFDM3RFcmptN1FkMUtwc0IvTksxSmoxZXVlTzdaRUg2ZjNMTGsx?=
 =?utf-8?B?NEJMdE1JL2dMUmdRRWVLZkdQNEV4MytzVDYrZFdNWldEYlU3bGtYZGlWMzJv?=
 =?utf-8?B?WXdZMXBLWFA1VHZhWXMxekU1SWxSMVk0YTNid1liNG14eEltQkV1b2xiMWEz?=
 =?utf-8?B?N2I5a3NNc0ZMY0c1Rjh5NEViRnJvYlpabW0rSmJZYlRoK0hxTjNSdVkydTBo?=
 =?utf-8?B?YUR3b3hJMEk1cDdtQVQ1azN5UXNONFVPRzhXeHpOYURuYXExeUpBS2hiRUNy?=
 =?utf-8?B?SkxrSnZ6YnBCTUZLNU1MbEhsakNlbmVQY2kvRm42cGZpbXlMZGVjQXoyTUk3?=
 =?utf-8?B?a2FRWDNMSlRsWEJLdTNKcnhaWUQ4VkdJOEtCZU4yUEg2ZFczNWJOd2JlTjFu?=
 =?utf-8?B?b0JBUm9KTzBaYnVScWRnU3RHUmRsazJMbythaG11NTdmeEV4dGNjdGp2RU5X?=
 =?utf-8?B?OEVWVzQxdmxxK3dDQ28xY3dWT0xPS3JMVlQ2aVBSbGJ3dVlUNlh0RmFqYjNO?=
 =?utf-8?B?WTNGZ2hDSXkvcnloSm4reng3L0VtdmV2dFloWERyOHUydVVmSHFlL2ZKbGw4?=
 =?utf-8?B?aVlRMkp0eE1uczBWUFowZFVJdFdGOTVPR1RLb044MC9TSGVPVm9aQTkyVUZv?=
 =?utf-8?B?RzQwdDYyOEFsL3EralNReGRtUGZMdmJyZlhNNTk3anV0eHoxWEJoUXFYeWhG?=
 =?utf-8?B?R3hXUVRRTU5aWTlFTENUMENXem91K25pN2VLdVVZSFVpbXBCSE5TcGVYVnA5?=
 =?utf-8?B?cTF3NGdvUW9uZVVSNC9Ga0FxUWF2RzA1d25FTGRNdVdVODBZcExncDFIZFJs?=
 =?utf-8?B?NXkvVllabDViUU8vM08vc1duSXFhSTFwV3VveDl1cVc5MjFwam9QN0RLdHZa?=
 =?utf-8?B?NzYzY25mUlhxTTRWUHY3dlpxWUNOUG81RUVtUXhHaFFLY0laeXYzWkhjenF3?=
 =?utf-8?B?WEM0QTB1V2ZaZ1NaK3lWajNRMVVzUCtmNVpPRFZ5dk1JbXJEbEFjSFV5K2lE?=
 =?utf-8?Q?xA8X0H?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qk41c2tmNFNNM2E4elJDaTlMZC83dlZ3YjlMMzdwY3Ridm1hR3c2TTQ4aGhJ?=
 =?utf-8?B?VkZsMDVRam1sRUM5VlJNbGRUNmYvdmM0QjJHZURzMy9rNnVydDVJTTFjM01O?=
 =?utf-8?B?d0JqRHNxNURyODFxY2hVMGF2dmo2dkwrWUFqNG1UbFdYcEVEYldpM29XMDVo?=
 =?utf-8?B?OUlacCt0VmFXdGh1T0UwdTdGSkJZVmdwLzlwanNTT1prZjZwK2tLdHFxdVdw?=
 =?utf-8?B?UXk3OUJLekVlaDB4U3dxUUNwbUJoVUpEUnNOckVHUitMMlBRb2xGbjhiazhY?=
 =?utf-8?B?bjhwNXdGVkREYzg0cVhwMUUrWXF2NHBzb3dTNDM4ZU5ETyt0TmZJcE9nUHFk?=
 =?utf-8?B?c3ZtQzBzZ1lLM0JrNzFrQ3pZcW1PME85dmZxRXVtMjdpMkRoQmJuL0c4ZTFK?=
 =?utf-8?B?UWg3VzVlakhselJ2TEFYSjVVNkFrRDdCblp3RGxiZHc1VVlnTU1WeHdQYmk0?=
 =?utf-8?B?Z2VLY0pPMjlNYVNyY1d1RkI3QjlFS0NxNVJvamYvTWxKSGV0MW56S2hHTStu?=
 =?utf-8?B?S1RuSDlZdWorSEJRa0h1NzB2ZVF2RnVOVFBPelRObC8vbWNFTzlPczM3MW1q?=
 =?utf-8?B?UFFUbWFhNEtFd0JpaTdXYTd3ekFYazJtemNXME41bWY1TTRTdWVwRlVDZzRR?=
 =?utf-8?B?a1ZTN3JxMHo1UURKWXNFWVFESUVpZ3BFSmZQWGNYcUY5c2VyUitvRzdKS2xs?=
 =?utf-8?B?V0pxSXVRYTFSWENLb2MxQlBVaklrWmFvRDkrK3g0bkdtVHYyakdHcVN5YURw?=
 =?utf-8?B?SDRIK3lQNHUrdHludGJuT1NVbkE2Uk5IY1BXM0h4NEphbWl3V3pOMHNRcEYy?=
 =?utf-8?B?QmpjalZRWnd2WG04bDdtSzBaeEQ2ZExCS01KMjJNZ0k2L3JxWXZlNjRhMFc3?=
 =?utf-8?B?Z1pONDhZc2JKUTZCcGMvczlCVjBJTUlVbURFbmlOZ1dwUHZQK3VaZmcvcHlS?=
 =?utf-8?B?Ylo1NjNVUDBvQXJzanEzditPMmtMVmJucERCdDNpbStzTldGTVhSM1JUaUpZ?=
 =?utf-8?B?YXBuQ3dnYXMwNDc4UUFZNk1DVWo3S3BZODZoUG8zN3NaUHZnalRkUjFLUmxz?=
 =?utf-8?B?WTByWE96T0VhdmNWY0lRS2c1b3YwUWUyL3hGZ3l2MVZpWFpMRTZPYThld2ZS?=
 =?utf-8?B?enIzdGs0WE5HNjFFUHNaV3BCZEozblFnMXVOOXFEMEQxWWZoN3doV3F4R0Y0?=
 =?utf-8?B?V0dzS3pNRGIyK0JuWTFiZDhzUlk5ZmdXSFdIKzJub2VaSWVURW1QeXdSdWc2?=
 =?utf-8?B?WGI2MUthSlZVYytDWmtDREtUcnBRWGxpRGxhUDlMQ1lpV1dNU2REQ1h6anVs?=
 =?utf-8?B?c2VvT2JPZzkwNEtXVktLVEFLVjUrdW1QTlBjNTJ1bU84Y05SanZQRHZ1NTRY?=
 =?utf-8?B?V0NwbnZwZ1VCVDExSnROQ2xodFgxcThyNU1WVm5yOFVvb3RtdVBPTjVFSk5K?=
 =?utf-8?B?R3BsVWdrNUMxM2Zma0hlRHlhRG52d283YjlIM3Q1WEFDc0dkc2xFM0Z0RmJ1?=
 =?utf-8?B?djhlOHZxYmRJemNYN0dTZGxoQitMSHgrUEpLTEhXUktFc3A2a3JCQ011dHhh?=
 =?utf-8?B?cU9UWXBPZ1lXTXhEa0YzekF1WEllL1FNdEpSRVkwUUVSTjRXYldJV1o5MDFo?=
 =?utf-8?B?eHp4SlZuVGJKbHE0QTduaVZVVGUva2FFbm12dUlROW5BNmpaUGtSaUQ1TjBs?=
 =?utf-8?B?VnFkRy90ektaa1JIZkVYU1RGRHhwQkRLaUJHazVnTEhiYm1oN3VEcS9pMGky?=
 =?utf-8?B?ZUdkeUorcEk4bVJLZmx4RmR6a2ZTdUtFTlRTT3N3aGlPeXNrMER2VDVvVnlQ?=
 =?utf-8?B?UTdLL1lRdDBnNzhHeFdOR3YydnFBTmVuTVY5QkNFMkNJWDNaQnJXMHM0bWt4?=
 =?utf-8?B?TkxIQVl3N05Ha1ZYeW96b05WWWdJNy91NmJnT0tLTEQ0SmpBZ1RBVDczOU5o?=
 =?utf-8?B?WklZN29rbmM0dXNqRTRFdzU4Y3lTM2kxWnNmZjEzelRaeis4V3l5MFhHb0Zm?=
 =?utf-8?B?cHFGQ21vTTF5RlN4ZTFmL3FkNVdIaHVnS3JnZU1uUURVdmFXUzEwbHA5d1Mx?=
 =?utf-8?B?ekhTaUNCbTZCZklSNXhiWnNWWTZhT2lHM2g5cnprd0FpMWNXYVJ0SXhldklF?=
 =?utf-8?B?Z1RTYys1L1FVZnQvMzFOSmZadnl2REt1RzBXZWNnVGhveFp0c3V6ZGwrcUlY?=
 =?utf-8?B?QkhoNFQ4b3RpdENFYTdWOW9HaytNMXhpMmhWVWRqSFBlV21KMGhLMGFVam1M?=
 =?utf-8?B?aklIbmsxNHM2RjRUa2ZLKzRJS0pRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DB310D5C1A3A54C90C83AE30346E987@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce344425-fe0c-49f3-9566-08de328bc8a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 16:48:28.0161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVSCgPo7F5NMQiYMrP86WbnLW6ssiSYQfTWba6Y6EPXEuJZu3/OfQjorm+/mfB/aIsKWWYXZiJPF49N8NWYEzQ/74JJ6ndMsH9ZXkZYT6ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6846
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=693069dd cx=c_pps
 a=Yd/70bDpgrqg65f6KmCseQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=9HrORhGBoQdPmCJSFtwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDEzMyBTYWx0ZWRfX2Q0r4GkjM0VS
 r5LmtQtPRAywJAAPyEM32YHxU843zwoK5zgGJNtjdSD4qOsE236WPJ+JS/Lf3W0X/dwItOWL274
 d1/09SmAdGMMXI2Xna7Bi6p8caY5pb4F+k/Y/KDtsMmJK/KkaqRykZVjLjvI0MLWJYdFHHBVYAn
 Fv0jhSUMCD2xBsVbxa1S1tA2XYvnoOngGrHyVHSHZGbMOsSYNw3FQZJguSLR0SQ+RpsBoXT4Dx2
 WUAf3UjxWOCRkD0oL3wD73mnxxV91eHAXTubbasOs1eE6DH1Papk3iWEREfXuqq7U5OY+2eLbfa
 1OZsIfEtUeOqK0AFefgbfHd0xjYZ7KbXCbKNs/Z09C+Kvs0UazRm9ga7vnSgPgq4+beXTmDQUqB
 WfgboctQdi6fbwLEkvwyZZK1gdAUNg==
X-Proofpoint-ORIG-GUID: mTabmZk6aDfcDHvZyZMcBXY-NohmKNmA
X-Proofpoint-GUID: mTabmZk6aDfcDHvZyZMcBXY-NohmKNmA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gRGVjIDMsIDIwMjUsIGF0IDExOjQz4oCvQU0sIEFybmFsZG8gQ2FydmFsaG8gZGUg
TWVsbyA8YWNtZUBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgRGVjIDAyLCAyMDI1
IGF0IDA4OjU1OjI2UE0gLTA3MDAsIEpvbiBLb2hsZXIgd3JvdGU6DQo+PiBGaXggTWFrZWZpbGUu
cGVyZiB0byBlbnN1cmUgdGhhdCBicGYgc2tlbGV0b25zIGFyZSBidWlsdCB3aXRoIGZQSUMuDQo+
PiANCj4+IFdoZW4gYnVpbGRpbmcgd2l0aCBCVUlMRF9CUEZfU0tFTD0xLCBicGZfc2tlbCdzIHdh
cyBub3QgZ2V0dGluZyBidWlsdA0KPj4gd2l0aCBmUElDLCBzZWVpbmcgY29tcGlsYXRpb24gZmFp
bHVyZXMgbGlrZToNCj4+IA0KPj4gL3Vzci9iaW4vbGQ6IC9idWlsZGRpci8uLi4vdG9vbHMvcGVy
Zi91dGlsL2JwZl9za2VsLy50bXAvYm9vdHN0cmFwL21haW4ubzoNCj4+ICByZWxvY2F0aW9uIFJf
WDg2XzY0XzMyIGFnYWluc3QgYC5yb2RhdGEuc3RyMS44JyBjYW4gbm90IGJlIHVzZWQgd2hlbg0K
Pj4gIG1ha2luZyBhIFBJRSBvYmplY3Q7IHJlY29tcGlsZSB3aXRoIC1mUElFDQo+PiANCj4+IEJp
c2VjdGVkIGRvd24gdG8gNi4xOCBjb21taXQgYTM5NTE2ODA1OTkyICgidG9vbHMgYnVpbGQ6IERv
bid0IGFzc3VtZQ0KPj4gbGlidHJhY2Vmcy1kZXZlbCBpcyBhbHdheXMgYXZhaWxhYmxlIikuDQo+
PiANCj4+IEZpeGVzOiBhMzk1MTY4MDU5OTIgKCJ0b29scyBidWlsZDogRG9uJ3QgYXNzdW1lIGxp
YnRyYWNlZnMtZGV2ZWwgaXMgYWx3YXlzIGF2YWlsYWJsZSIpDQo+IA0KPiBIb3cgY29tZSwgdGhp
cyBwYXRjaCBpcyBqdXN0Og0KDQpJdCBkb2VzbuKAmXQgbWFrZSBzZW5zZSB0byBtZSwgYnV0IEkg
Y2hlY2tlZCB0aGUgcmVzdWx0cyBvZg0KdGhlIGJpc2VjdGlvbiBieSBoYW5kIGFuZCwgaGFuZC10
by1nb2QsIHJldmVydGluZyBjb21taXQNCmEzOTUxNjgwNTk5MiB1bmJyZWFrcyBvdXIgYnVpbGQg
ZXZlcnkgc2luZ2xlIHRpbWUuDQpQdXR0aW5nIGEzOTUxNjgwNTk5MiBiYWNrIGJyZWFrcyBvdXIg
YnVpbGQgMTAwJSBvZiB0aGUgdGltZS4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2J1aWxk
L01ha2VmaWxlLmZlYXR1cmUgYi90b29scy9idWlsZC9NYWtlZmlsZS5mZWF0dXJlDQo+IGluZGV4
IDljMWE2OWQyNmY1MTIxZmQuLjUzMWY4ZmM0ZjdkZjk5NDMgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xz
L2J1aWxkL01ha2VmaWxlLmZlYXR1cmUNCj4gKysrIGIvdG9vbHMvYnVpbGQvTWFrZWZpbGUuZmVh
dHVyZQ0KPiBAQCAtODMsNyArODMsNiBAQCBGRUFUVVJFX1RFU1RTX0JBU0lDIDo9ICAgICAgICAg
ICAgICAgICAgXA0KPiAgICAgICAgIGxpYnB5dGhvbiAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiAgICAgICAgIGxpYnNsYW5nICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgIGxp
YnRyYWNlZXZlbnQgICAgICAgICAgICAgICAgICAgXA0KPiAtICAgICAgICBsaWJ0cmFjZWZzICAg
ICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAgICBsaWJjcHVwb3dlciAgICAgICAgICAgICAg
ICAgICAgIFwNCj4gICAgICAgICBwdGhyZWFkLWF0dHItc2V0YWZmaW5pdHktbnAgICAgIFwNCj4g
ICAgICAgICBwdGhyZWFkLWJhcnJpZXIgICAgICAgICAgICAgICAgXA0KPiBkaWZmIC0tZ2l0IGEv
dG9vbHMvYnVpbGQvZmVhdHVyZS90ZXN0LWFsbC5jIGIvdG9vbHMvYnVpbGQvZmVhdHVyZS90ZXN0
LWFsbC5jDQo+IGluZGV4IGUxODQ3ZGI2ZjhlNjM3NTAuLjJkZjU5MzU5M2I2ZWMxNWUgMTAwNjQ0
DQo+IC0tLSBhL3Rvb2xzL2J1aWxkL2ZlYXR1cmUvdGVzdC1hbGwuYw0KPiArKysgYi90b29scy9i
dWlsZC9mZWF0dXJlL3Rlc3QtYWxsLmMNCj4gQEAgLTE1MCwxMCArMTUwLDYgQEANCj4gIyBpbmNs
dWRlICJ0ZXN0LWxpYnRyYWNlZXZlbnQuYyINCj4gI3VuZGVmIG1haW4NCj4gDQo+IC0jZGVmaW5l
IG1haW4gbWFpbl90ZXN0X2xpYnRyYWNlZnMNCj4gLSMgaW5jbHVkZSAidGVzdC1saWJ0cmFjZWZz
LmMiDQo+IC0jdW5kZWYgbWFpbg0KPiAtDQo+IGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2
W10pDQo+IHsNCj4gICAgICAgIG1haW5fdGVzdF9saWJweXRob24oKTsNCj4gQEAgLTE4Nyw3ICsx
ODMsNiBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPiAgICAgICAgbWFpbl90
ZXN0X3JlYWxsb2NhcnJheSgpOw0KPiAgICAgICAgbWFpbl90ZXN0X2xpYnpzdGQoKTsNCj4gICAg
ICAgIG1haW5fdGVzdF9saWJ0cmFjZWV2ZW50KCk7DQo+IC0gICAgICAgbWFpbl90ZXN0X2xpYnRy
YWNlZnMoKTsNCj4gDQo+ICAgICAgICByZXR1cm4gMDsNCj4gfQ0KPiANCj4gDQo+IC0tLS0NCj4g
DQo+IEFuZCB5b3VyIHBhdGNoIGlzIHRvdWNoaW5nIGJ1aWxkaW5nIGJwZnRvb2w/IFNlZW1zIHZl
cnkgdW5yZWxhdGVkIDotXA0KPiANCj4gLSBBcm5hbGRvDQo+IA0KPj4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4+IFNpZ25lZC1vZmYtYnk6IEpvbiBLb2hsZXIgPGpvbkBudXRhbml4LmNv
bT4NCj4+IC0tLQ0KPj4gdG9vbHMvcGVyZi9NYWtlZmlsZS5wZXJmIHwgMiArLQ0KPj4gMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+PiANCj4+IGRpZmYgLS1n
aXQgYS90b29scy9wZXJmL01ha2VmaWxlLnBlcmYgYi90b29scy9wZXJmL01ha2VmaWxlLnBlcmYN
Cj4+IGluZGV4IDAyZjg3YzQ5ODAxZi4uNDU1N2MyZTg5ZTg4IDEwMDY0NA0KPj4gLS0tIGEvdG9v
bHMvcGVyZi9NYWtlZmlsZS5wZXJmDQo+PiArKysgYi90b29scy9wZXJmL01ha2VmaWxlLnBlcmYN
Cj4+IEBAIC0xMjExLDcgKzEyMTEsNyBAQCBlbmRpZg0KPj4gDQo+PiAkKEJQRlRPT0wpOiB8ICQo
U0tFTF9UTVBfT1VUKQ0KPj4gJChRKUNGTEFHUz0gJChNQUtFKSAtQyAuLi9icGYvYnBmdG9vbCBc
DQo+PiAtIE9VVFBVVD0kKFNLRUxfVE1QX09VVCkvIGJvb3RzdHJhcA0KPj4gKyBFWFRSQV9DRkxB
R1M9Ii1mUElDIiBPVVRQVVQ9JChTS0VMX1RNUF9PVVQpLyBib290c3RyYXANCj4+IA0KPj4gIyBQ
YXRocyB0byBzZWFyY2ggZm9yIGEga2VybmVsIHRvIGdlbmVyYXRlIHZtbGludXguaCBmcm9tLg0K
Pj4gVk1MSU5VWF9CVEZfRUxGX1BBVEhTID89ICQoaWYgJChPKSwkKE8pL3ZtbGludXgpIFwNCj4+
IC0tIA0KPj4gMi40My4wDQoNCg==

