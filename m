Return-Path: <bpf+bounces-47299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ECC9F73E4
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 06:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED5D1890705
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 05:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C58B2163B8;
	Thu, 19 Dec 2024 05:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fyqLfYJM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E92594
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734585827; cv=fail; b=uhdiHyljcL+Q8qdKdZQvAExec/MGXTVRR0lY6zzGJTpkFIIeyjtR9gtGtcQ2JEUantwnVUEMtgvqVxXqc0jNiUCOl6cJ4U7klPjKt6MaP38kTjLQtV5aHbgBaE04G+46u66YXDhAKQr3sNitWxvBVg/Up2fchEnB5lnyhB4Zmfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734585827; c=relaxed/simple;
	bh=F8bCX4zHVjM1NgeilojZDKidM4bFyMoc66GSApQxIdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdEaouiIB8zD4dxnsI2fbfpKx/QFa0q1HnhWb3mMK5F6YaFNfyTWdBxfMEpn+Eo8RIuxoSljuXjZEuC4J3EeociweVxxx990aDPsjdptjgUJdemC7a4nqacI8OOfK7me2q/EWIx/0qSP3Z29Wu8GEsq5angR1S8+fJlA68lj0lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fyqLfYJM; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ3eB6K005597
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 21:23:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=F8bCX4zHVjM1NgeilojZDKidM4bFyMoc66GSApQxIdg=; b=
	fyqLfYJM+z4Fp8B8KjvRqiFmNg7/Gab8RHH7pjBv/qCfVFk69U6ajxYjvfwbFtUX
	I0Ei2ZHnSc08vN9CreT/mRuW68DPR8z5h5a3o26ZNLK071r5SOXJblduiruBBENQ
	KSJn6QxtygNNEVllHMQaFC/3RXNCMTL1HOLKI5hxJufaJJ7wkQCpmMyncC/WHq4a
	IUfHizsMDb/9MidlLmT1ZPMkRN6uY4CjY/1Rsm9IeG3a/6ranwV6h7EivS6mRyIS
	Codkj9srcN5kfL8Xkiqqe4/HiBKHoftFR5Qu+L1mO9j/Y1I1fMFjvG361eiNlLGx
	VZiVi3AT9anHHvN/G/lPHA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43mbsg8g61-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 21:23:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3c2f5B/2qS4HR1W2stC5d7rvJzeBWYiY2kj/Ur0OAnfcUfNDfgRT6IyaXcZrirIkCyNk1qPHWgea56QXz+EOyFQffhiwZJud8/B8645d8v82DVen5RFcmZ6Yt3wtBpl9T3Jtai9TYAfmJgO43jRvY+ZKXJWp/goNB65MFE9TQtkezvr43XkZi6KeFM+0m3TLrEFQ15UFrO5iExBzeoPtOT6Nnno5Lv1qsODpR17lLf+gDRw4E1r/6WJr0HenwDenhxplmJ/TyGvTfbVKwIpAyx14Swg4j4VqBgpQcb1r2vLgGfOVS5YB924iXCxwiI5ceUK/ApZr4p4S/tfAG8TAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8bCX4zHVjM1NgeilojZDKidM4bFyMoc66GSApQxIdg=;
 b=kkMGvRsmYmKW432JeTCAJ5ppk6d1ZlnHS5BmMZDCxFkjJjeIAriYj+uqopm8k4KG/Fvb8zq86nnj5dmCgpHa3H7jqa8iDRD0BGNd9qvMipxnD9uHC1w1kpRE/uLcvSTTi8py3BMCsSekIj8S8MBl0DdfnV9npHLgg6Hnf6EalDh3iIfrohT475ZpS+Aqgq84SkvM6b24QGyTWXsrMeUzr78yKpUoG13yeiCYK/v77R4wE3hIx+JpJ3oc90L/z3Y9lnTei4JG7I4eb6sXjpoU2iw/yF8GdySoKJ9bJkm0gaE1sarOdfh0PX3QGzBqg6A2W2JnBxnKQC5GDYEJSv/bQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB4052.namprd15.prod.outlook.com (2603:10b6:208:276::22)
 by SA1PR15MB4321.namprd15.prod.outlook.com (2603:10b6:806:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 05:23:41 +0000
Received: from BLAPR15MB4052.namprd15.prod.outlook.com
 ([fe80::d42a:8422:b4de:55db]) by BLAPR15MB4052.namprd15.prod.outlook.com
 ([fe80::d42a:8422:b4de:55db%3]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 05:23:40 +0000
From: Daniel Xu <dlxu@meta.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Daniel Borkmann
	<daniel@iogearbox.net>
CC: "bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>,
        kernel-ci
	<kernel-ci@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/5] net/smc: Introduce smc_ops
Thread-Topic: [PATCH bpf-next v3 0/5] net/smc: Introduce smc_ops
Thread-Index: AQHbUPwoQt/WlsGc9kWxgcqmOvIoPrLrabuAgADOhACAALvkgIAAFjcA
Date: Thu, 19 Dec 2024 05:23:40 +0000
Message-ID: <0a75d230-9cd4-4f16-afc5-f33aef715808@meta.com>
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
 <bf1eef2ada1330c92b6326e90e23482e53a759fd40cd6c25832ae7f72207930a@mail.kernel.org>
 <20241218043231.GA9245@j66a10360.sqa.eu95>
 <1425b222-b5a5-4f18-a65b-af37226d099e@iogearbox.net>
 <20241219040409.GA107394@j66a10360.sqa.eu95>
In-Reply-To: <20241219040409.GA107394@j66a10360.sqa.eu95>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR15MB4052:EE_|SA1PR15MB4321:EE_
x-ms-office365-filtering-correlation-id: 0f672f70-05ff-4653-1537-08dd1fed4c73
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmRMRUlJTDRNampRSUo3Nkl2U1pqdldOQVVNaWZkeVBqc1FIMGdmcERleWJt?=
 =?utf-8?B?Y0VMK3ZER3J6TDJZcjh1ZVRMcTd3dTFsc3crR1I3SHFuM2w2ZW5OK0tFdFdq?=
 =?utf-8?B?eVBacWRmZ01jL3FZdERxRDAwbHpGbjZUeWNxR1hLTTUzK09aTjZIaE9YdlJL?=
 =?utf-8?B?MjVhZUJUTndvL1hnZ01VSTNLU1Y1RFVXbnNyUjBIcUhncXlhMGpmM2Z2dDZ4?=
 =?utf-8?B?dE9qYSs1ZnVVWUgrR3FtWWtGT2ZyNi9HK1VNUmJnMm1mY0liK0Y0Uk4rRCsr?=
 =?utf-8?B?NGRqY2NhaktzWjdQNDBGQ0dJNTRhTlF4eFVISG0yRHBseHFhRDZUakRqS0tt?=
 =?utf-8?B?aTBkNVQ1MEFaL3JwYStmRi9IcGxGOEtqOU9hdndmbVJ4ZndmdTlac3czQjNB?=
 =?utf-8?B?TFl2OUNkdE1GVW5kOVdpQUxCSWdVTDd5SW9yN2JoTjIyZzZrODNPWkNZK1Bu?=
 =?utf-8?B?Wm5KYUtOcklaNmR0aC8yTDA3TXhEaElhVlZTeTQvNVozNll2ZU5HbnpEb1BU?=
 =?utf-8?B?azlLQ1ZmRW1QWjZrY2Z3aTNLeWRPQnBUQTMvaDI2Tjc2WWFrTjRnQS8rMVpR?=
 =?utf-8?B?ZXRRUHlRRWxJREM4SFRINjZJRVJ2eXB5ZjF3WldNL2h2eXJsckVpd0F0WUVt?=
 =?utf-8?B?MUorK1d0SUpwaEdSemlzanRlVHlaNGptZTQvSjB0R3p5RmdTeFdVWUw2Q2tC?=
 =?utf-8?B?Yk9WOEtpa0JMK0cvMDVtMVYxZDVDYm9GdmNBK1RxUkRaTWk3QVE4bmVEcU9U?=
 =?utf-8?B?cEhzbUNTcVIvcEtqTjVua2tXM2p6TFVSaU0wenNpNXY5TlByU2NZWGFwbGhH?=
 =?utf-8?B?TityTWFKQWxTUUUyOEpFb1VDclg0aU1Fay9JZEhUVkk5cW5zMEtYbkRhWGlV?=
 =?utf-8?B?UnkyS0pLc3pFWUJRQVhOWWV3TlVtL2JqbkRBYS9ROWNTdzk1ZnJGS0RpZkYw?=
 =?utf-8?B?dEJ6RW1nb2ZZSWo4V2dSeXRSWVZGc0pFS1RmSU1jSVI2YjZsKzdwQVdZZHMv?=
 =?utf-8?B?dGxyeXZncTludTh4dlpmMExLSGowSDNjL2h3N01NY3Zna01kMG9YK3JQL2ZV?=
 =?utf-8?B?eHU4b3lYWTZla3FuQkdWVWRRMmh1OXhtUC81OVJhNzg4SEZQbmpqT20rSUUv?=
 =?utf-8?B?M25IMWpET3ZKbDQzQ0llOFVmV3hOSkVCQzVPbE1mbytOZTZXdUNhVzIweTdU?=
 =?utf-8?B?OXloTEt4WXRXU1JUQ3BremUwYUFBUGpRTnBNaThSVE9iZjR3QkFEbWR0SzRH?=
 =?utf-8?B?TlNxaVg1MDNMMUZlQ1FpajBkbXRyTnV0R25tK3I5bmRkaks2RHF6dEo0R01W?=
 =?utf-8?B?WjUwYzZ6Q3RObmlsVzY3VWxPZmkxN0NLV3UzM01RUHZtTU1NWDBvQ2w3YWZs?=
 =?utf-8?B?N2dQUFhnY2dnRlh3NlpIWFV5U3hZY3Z0UGkrL3h1MjhXVU9JVkl4MXljMys1?=
 =?utf-8?B?VHUwUldaUzl2QjUrM0tacHlxNERPbHNobnFrd3NSSm9IcUtHYlQyUysyZUE3?=
 =?utf-8?B?dVg1aitRaEtpMXFocFZvTVVKVEswSEc2cEZmVHozL0ZPdGtmL2lBYnJwVllj?=
 =?utf-8?B?SCtnemhGYmoraEwrWG5PMTUwd1h1QkZHK1FOZXdtK1B4Z0JHS05yNC9jaGlx?=
 =?utf-8?B?Z2tzVzhFQ0FDNlptSUZRRGdOUWNvU3BxTmxnU1pXY2dKSkpaZ3JOaHBnZ2xK?=
 =?utf-8?B?S3VLWjJ0MERNajJmVWJXaTZua2g3WHREbVJYWHVYWjlIWXBhUHNqNk5mckd6?=
 =?utf-8?B?NlJTU1VuZXphWGgwbThEcDhneDFERGI4cU02bkhXc0pudHdlcEt3SG9RUHRw?=
 =?utf-8?B?NWY3NUxwb3J3OEplYTQ2QlN1dTFQTjh0ZnVMWEgydDI4TlhyWXdaR09JN2NT?=
 =?utf-8?B?VDRITW1jdUlIa1JEZUpzdUJCd01wOE9RRWpvc2MyK2pqQ0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB4052.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWh1VitRTWNVRFdpRWZILzYrbkpydFNlYm5BQTVFbEVGbnFjcjNsVjZJMzJS?=
 =?utf-8?B?dC9vQVh2bXIyVVp1cHpMVkFaY0t5Q0RnRVFEM2E3TWs0aFpwSi84NmlhQWdq?=
 =?utf-8?B?RExpYkFoSnIvSnh3VkE5WFhCTTM5MmxpRU5ncmRudlQ5TDJoTVJNbVAvMHhj?=
 =?utf-8?B?QUdSNFl4SnUrOWZiWm9YSmkvTUtObjFGb094MWc1eGtvdzlSWTg0WHVrR2hJ?=
 =?utf-8?B?SXFNanpWdDRDcHhzb3RCdzhuQ0dHdnlUL00vOFlNbGJCeWg3Qk0xaHZpNVF5?=
 =?utf-8?B?L1B6L2RUakJoaHhTbys2SEw1d0RJZGkvd1d6TC8vdHBMM0h2aTljTzFHUVhW?=
 =?utf-8?B?cm9NM01tVjZkQThHSnlBVFMvZmRXcUJsWU91ZG5VNEY3bTdpNXRpTnNmdVIw?=
 =?utf-8?B?K2NQYWprWXVLOWIwQXhzc0c1eGw1S1ZzL0FINktMRU45QmkyOHp4L3BqTnRR?=
 =?utf-8?B?OEp0czlYSS9ySWYxTkhQNjYyMWlBYWFpMGlJUzkxWldwUFBwQWNTU3A5REpW?=
 =?utf-8?B?cWE2WnVwdE9OOTlqS3EwQnBMa0JKbE01a2owQmJ6dkN1R3JyZGEwSlpDMWdH?=
 =?utf-8?B?YlEwM3BWRzkvUjdNam9DSW9STnJ4ditUMWQwT0tnUFllSndSamt6dDJKV09m?=
 =?utf-8?B?V3NSRU5jSExEekdwdHhNWGRVbnA4UHJjQnJLbnRRMXdXbU5PTWJVelBTd0Zw?=
 =?utf-8?B?dld2ejhCY2YrUW8rdktWWVdjUEpLeElkZHc5bTQwdnpoV1dJdUVuSmVIeVZV?=
 =?utf-8?B?VzNCS2Q1ck5mU2lrVTZJRG9GSzhkeDBOWWtCRksyTWtwQUg0TjFmbFNBTzVO?=
 =?utf-8?B?ZC8zdzFzOTc0TWRlVWpkVGMvZ1hZUXgxdnBoSFNTaUducE1FdnJlc3dFenFj?=
 =?utf-8?B?RldrWkRpdThzc1RRTVdOK3VNMUlYK1MxbURQU1kzaCtuSUNLN0EvQWltamZC?=
 =?utf-8?B?VG5pUXBDTFZuWkNIa0tramp5THF1d3BIZlJycTQ0a1ZRQzRwbi8xRTEzVU9I?=
 =?utf-8?B?K21Md0tibXcrL1FPbGtiSnBkMVl1SWkrdlhJWHZTN0tBM1NBemZFVXhETnFV?=
 =?utf-8?B?NU1tTFVCS2FwVWZUMzhPMmhZSGFMbjNmanIrdEF0cDU5TVRoa3JUOVgyeWgr?=
 =?utf-8?B?bFFsOUxIZlJEWFczalQ0S1BwY2g4YUh6Vkg0a09WS0lQYUFFRytmUFhEWFpI?=
 =?utf-8?B?OTA4TzB6TU1QeVJwakRHODF4cS9vQkN2MWIxelg1QUtCQWpYOGJhblJsRzI3?=
 =?utf-8?B?bFRwMkFXVnNraUxtRjkxREZMRU16ZytYbmtnTEZSMldsL2JYV3hySFA2NVl6?=
 =?utf-8?B?U3gzWXRYZFNXS29JdUM4MTJRRE55TVVBR0VUWkVTNHVBcmtuUjZtQlNEcDVF?=
 =?utf-8?B?M0swcG1TQnEvQy9KV1VPZnB6ZUNoOXV2djNJeGtjZW9ucEhVTXBneHBvTUJu?=
 =?utf-8?B?WFBFbjMrN1VYSnNOVGtwSE9xaXAyMWNxRHVXNXhIamtIN1RCTGI3U3J1WURN?=
 =?utf-8?B?VFp6bCt1L2JJNjk4UnR4ZTE3VUFpYmtKUGdtdDRuSWpiTGVzQ1FHNkpCRHBB?=
 =?utf-8?B?TFpMaWpWaHRhYk9xSU8wZmI4VG1obUdaUFdTcG1XeUNkZ1hoamRIRS9IUHla?=
 =?utf-8?B?Y05ZTlAvWXlEN0JnVXB4YmU2bmEyeGZ0NzRmSEFNbWJraEtXL1JTdng0dXJa?=
 =?utf-8?B?eElDZWp6M0JtVGNocW80WGtMVEFJRjQxY0FkUUlKSzlvVGxDd2JJUndCNGQ1?=
 =?utf-8?B?eitLV0Y0VElDVC9YZVBXckpGRld5UlFiTndnakhWQlkxZm83MHBHWlFXRllI?=
 =?utf-8?B?NnlnV1NDUjFaeVNjWHVMTE1uSEFTU3RSdGRHeHoxd28zazlSZm4zMlh5U2Fh?=
 =?utf-8?B?VGhZWlRZYTNRRmpSK2dlcVlZWHFLNnRmazlJSC9Ua00xTWdBQTV5cDR1eGt3?=
 =?utf-8?B?bDJ0Ykw5QmlHV3ZMaDdvby9uVTFDTGZEcVM1eWZPN0t3YWhhaDVZVVJITmtK?=
 =?utf-8?B?RzFJRGF3Yi9pRXROTDRaRVZmaXIybWROS28yVk51ZDRtUkpacStTVkNVT3Jq?=
 =?utf-8?B?QUVOaWNDVDBsbWtoMHluZHdSVnlrZmxISy84cHRpL2Z3a1Q4T3VicmhObkJW?=
 =?utf-8?Q?/2P0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AECE869685892C4084B17FAF48EEA2E3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB4052.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f672f70-05ff-4653-1537-08dd1fed4c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 05:23:40.6367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KeXZqyogDRu+nJjxUcdYRO3xIQecTqzw1dtjao9UL460kBIYWC0vSLs7BtoNJqfw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4321
X-Proofpoint-ORIG-GUID: JNa1jMTk87s0Ty63ipxm9f6WelIYjlBH
X-Proofpoint-GUID: JNa1jMTk87s0Ty63ipxm9f6WelIYjlBH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

T24gMTIvMTgvMjQgMjI6MDQsIEQuIFd5dGhlIHdyb3RlOg0KPiBPbiBXZWQsIERlYyAxOCwgMjAy
NCBhdCAwNTo1MTo0MFBNICswMTAwLCBEYW5pZWwgQm9ya21hbm4gd3JvdGU6DQo+PiBPbiAxMi8x
OC8yNCA1OjMyIEFNLCBELiBXeXRoZSB3cm90ZToNCj4+PiBPbiBXZWQsIERlYyAxOCwgMjAyNCBh
dCAwMzoyMzowMUFNICswMDAwLCBib3QrYnBmLWNpQGtlcm5lbC5vcmcgd3JvdGU6DQo+Pj4+IERl
YXIgcGF0Y2ggc3VibWl0dGVyLA0KPj4+Pg0KPj4+PiBDSSBoYXMgdGVzdGVkIHRoZSBmb2xsb3dp
bmcgc3VibWlzc2lvbjoNCj4+Pj4gU3RhdHVzOiAgICAgRkFJTFVSRQ0KPj4+PiBOYW1lOiAgICAg
ICBbYnBmLW5leHQsdjMsMC81XSBuZXQvc21jOiBJbnRyb2R1Y2Ugc21jX29wcw0KPj4+PiBQYXRj
aHdvcms6ICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL2xp
c3QvP3Nlcmllcz05MTg5NDYmc3RhdGU9Kg0KPj4+PiBNYXRyaXg6ICAgICBodHRwczovL2dpdGh1
Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL2FjdGlvbnMvcnVucy8xMjM4NTU0NzY0NA0KPj4+Pg0K
Pj4+PiBGYWlsZWQgam9iczoNCj4+Pj4gdGVzdF9wcm9ncy1hYXJjaDY0LWdjYzogaHR0cHM6Ly9n
aXRodWIuY29tL2tlcm5lbC1wYXRjaGVzL2JwZi9hY3Rpb25zL3J1bnMvMTIzODU1NDc2NDQvam9i
LzM0NTcyMTM3Nzg5DQo+Pj4+IHRlc3RfcHJvZ3Nfbm9fYWx1MzItYWFyY2g2NC1nY2M6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5zLzEyMzg1NTQ3NjQ0
L2pvYi8zNDU3MjEzNzk4NQ0KPj4+PiB0ZXN0X3Byb2dzLXMzOTB4LWdjYzogaHR0cHM6Ly9naXRo
dWIuY29tL2tlcm5lbC1wYXRjaGVzL2JwZi9hY3Rpb25zL3J1bnMvMTIzODU1NDc2NDQvam9iLzM0
NTcyMTE2MzUxDQo+Pj4+IHRlc3RfcHJvZ3Nfbm9fYWx1MzItczM5MHgtZ2NjOiBodHRwczovL2dp
dGh1Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL2FjdGlvbnMvcnVucy8xMjM4NTU0NzY0NC9qb2Iv
MzQ1NzIxMTY2NzANCj4+Pj4gdGVzdF9wcm9ncy14ODZfNjQtZ2NjOiBodHRwczovL2dpdGh1Yi5j
b20va2VybmVsLXBhdGNoZXMvYnBmL2FjdGlvbnMvcnVucy8xMjM4NTU0NzY0NC9qb2IvMzQ1NzIx
NDcxMTQNCj4+Pj4gdGVzdF9wcm9nc19ub19hbHUzMi14ODZfNjQtZ2NjOiBodHRwczovL2dpdGh1
Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL2FjdGlvbnMvcnVucy8xMjM4NTU0NzY0NC9qb2IvMzQ1
NzIxNDc1NzkNCj4+Pj4gdGVzdF9wcm9ncy14ODZfNjQtbGx2bS0xNzogaHR0cHM6Ly9naXRodWIu
Y29tL2tlcm5lbC1wYXRjaGVzL2JwZi9hY3Rpb25zL3J1bnMvMTIzODU1NDc2NDQvam9iLzM0NTcy
MTUyNjI3DQo+Pj4+IHRlc3RfcHJvZ3Nfbm9fYWx1MzIteDg2XzY0LWxsdm0tMTc6IGh0dHBzOi8v
Z2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5zLzEyMzg1NTQ3NjQ0L2pv
Yi8zNDU3MjE1MjQwMA0KPj4+PiB0ZXN0X3Byb2dzLXg4Nl82NC1sbHZtLTE4OiBodHRwczovL2dp
dGh1Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL2FjdGlvbnMvcnVucy8xMjM4NTU0NzY0NC9qb2Iv
MzQ1NzIxMzQ1MTQNCj4+Pj4gdGVzdF9wcm9nc19jcHV2NC14ODZfNjQtbGx2bS0xODogaHR0cHM6
Ly9naXRodWIuY29tL2tlcm5lbC1wYXRjaGVzL2JwZi9hY3Rpb25zL3J1bnMvMTIzODU1NDc2NDQv
am9iLzM0NTcyMTM0Nzc5DQo+Pj4+IHRlc3RfcHJvZ3Nfbm9fYWx1MzIteDg2XzY0LWxsdm0tMTg6
IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5zLzEyMzg1
NTQ3NjQ0L2pvYi8zNDU3MjEzNTE3OQ0KPj4+Pg0KPj4+PiBGaXJzdCB0ZXN0X3Byb2dzIGZhaWx1
cmUgKHRlc3RfcHJvZ3MtYWFyY2g2NC1nY2MpOg0KPj4+PiAjMjcgYnBmX3NtYw0KPj4+PiBsb2Fk
X3NtY19tb2R1bGU6RkFJTDpjcmVhdGUgaXBwcm90b19zbWMgdW5leHBlY3RlZCBjcmVhdGUgaXBw
cm90b19zbWM6IGFjdHVhbCAtMSA8IGV4cGVjdGVkIDANCj4+Pj4gc2V0dXAgZm9yIHNtYyB0ZXN0
IGZhaWxlZCwgdGVzdCBTS0lQOg0KPj4+IEEgYml0IHdlaXJkLiBIb3cgY2FuIEkgcmVwcm9kdWNl
IHRoaXMgdGVzdCBvbiBteSBvd24/IEFsc28sIGl0IHNlZW1zDQo+Pj4gdGhhdCBJIHNob3VsZG4n
dCB1c2UgdGhlIEFTU0VSVF9YWCBtYWNyb3MgaW4gdGhlIHNldHVwIHBoYXNlLCBzbyB0aGF0IGl0
DQo+Pj4gY2FuIHByb3Blcmx5IHNraXAuDQo+PiBJbiB0aGUgQlBGIHNlbGZ0ZXN0IGRpciwgeW91
IGNvdWxkIHRyeSB0byByZXBybyB3aXRoIHZtdGVzdC5zaCBzY3JpcHQgOg0KPj4NCj4+ICAgIC4v
dm10ZXN0LnNoIC0tIC4vdGVzdF9wcm9ncyAtdCBzbWMNCj4+DQo+PiBQb3RlbnRpYWxseSB0b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvY29uZmlnKiBuZWVkcyB0byBiZSBleHRlbmRlZCBhcyBm
aXJzdCBzdGVwLg0KPiBIaSBEYW5pZWwsDQo+DQo+IFRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHlvdXIg
cHJvbXB0LiBJIHRoaW5rIEkgaGF2ZSBpZGVudGlmaWVkIHRoZSBpc3N1ZS4NCj4NCj4gSSByZXBy
b2R1Y2VkIHRoaXMgaXNzdWUgYnkgdm10ZXN0LCBhbmQgSSBzdXNwZWN0IGl0IG1heSBoYXZlIGJl
ZW4NCj4gY2F1c2VkIGJ5IG5vdCBleGVjdXRlICJtYWtlIG1vZHVsZXNfaW5zdGFsbCIgYmVmb3Jl
IGV4ZWN1dGluZyB2bXRlc3QNCj4gc2luY2UgQ09ORklHX1NNQz1tIGluIHRvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9jb25maWcqOw0KPg0KPiBbcm9vdEBsb2NhbGhvc3QgbGludXhdJCB2bXRl
c3QgLWsgYXJjaC94ODZfNjQvYm9vdC9iekltYWdlICJtb2Rwcm9iZSBzbWM7Ig0KPiA9PiBieklt
YWdlDQo+ID09PT4gQm9vdGluZw0KPiA9PT0+IFNldHRpbmcgdXAgVk0NCj4gPT09PiBSdW5uaW5n
IGNvbW1hbmQNCj4gbW9kcHJvYmU6IEZBVEFMOiBNb2R1bGUgc21jIG5vdCBmb3VuZCBpbiBkaXJl
Y3RvcnkNCj4gL2xpYi9tb2R1bGVzLzYuMTMuMC1yYzMtMDAxMTYtZ2FmZTQwMzg1ZjExNg0KPiBD
b21tYW5kIGZhaWxlZCB3aXRoIGV4aXQgY29kZTogMQ0KPg0KPiBXaGVuIEkgZmlyc3QgcnVuIG1h
a2UgbW9kdWxlc19pbnN0YWxsIGFuZCB0aGVuIHZtdGVzdCwgdGhlIGlzc3VlIGlzDQo+IHJlc29s
dmVkIQ0KPg0KPiBbcm9vdEBsb2NhbGhvc3QgbGludXhdJCB2bXRlc3QgLWsgYXJjaC94ODZfNjQv
Ym9vdC9iekltYWdlICJjZCAuL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi87IC4vdGVzdF9w
cm9ncyAtdCBzbWMiDQo+ID0+IGJ6SW1hZ2UNCj4gPT09PiBCb290aW5nDQo+ID09PT4gU2V0dGlu
ZyB1cCBWTQ0KPiA9PT0+IFJ1bm5pbmcgY29tbWFuZA0KPiBbICAgIDEuODI5MjY4XSBicGZfdGVz
dG1vZDogbG9hZGluZyBvdXQtb2YtdHJlZSBtb2R1bGUgdGFpbnRzIGtlcm5lbC4NCj4gWyAgICAx
LjkwNjI3NF0gTkVUOiBSZWdpc3RlcmVkIFBGX1NNQyBwcm90b2NvbCBmYW1pbHkNCj4gWyAgICAx
LjkwNjYwM10gc21jOiBhZGRpbmcgc21jZCBkZXZpY2UgbG9vcGJhY2staXNtDQo+IG5ldC5zbWMu
b3BzID0gbGlua2NoZWNrDQo+ICMyNy8xICAgIGJwZl9zbWMvdG9wbzpPSw0KPiAjMjcgICAgICBi
cGZfc21jOk9LDQo+IFN1bW1hcnk6IDEvMSBQQVNTRUQsIDAgU0tJUFBFRCwgMCBGQUlMRUQNCj4N
Cj4gT2YgY291cnNlLCBJIGRvbid0IHRoaW5rIGl0J3MgbmVjZXNzYXJpbHkgYXBwcm9wcmlhdGUg
dG8gaGF2ZSB0aGUgQ0kNCj4gbW9kaWZ5IHRoaXMsIHNvIEkgZGVjaWRlZCB0byBjaGFuZ2UgQ09O
RklHX1NNQz1tIHRvIENPTkZJR19TTUM9eSBpbiB0aGUNCj4gY29uZmlnLCB3aGljaCBhbHNvIHNv
bHZlcyB0aGUgcHJvYmxlbS4NCj4NCj4gV2hhdCBkbyB5b3UgdGhpbms/DQoNCltjYyBicGYgbGlz
dF0NCg0KQ09ORklHX1NNQz15IG1ha2VzIHNlbnNlIHRvIG1lLg0KDQpUaGFua3MsDQooT3RoZXIp
IERhbmllbA0KDQo=

