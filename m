Return-Path: <bpf+bounces-48871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5720CA114EF
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF4E7A370E
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCED21ADB4;
	Tue, 14 Jan 2025 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RXbspsVS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8520AF6D;
	Tue, 14 Jan 2025 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895809; cv=fail; b=Iv2jnLpCFQ9nNeXbgdoTMuAc1BlI8lF/wE6JY03DYJo37NM2w2hDUAihHZZeQVwa5kvuMH9VqeAvPI3CUwUXcnLjmVAlh1jsSn6Qj4Xy9+g61z7BoMAo2C2CMNTlvKQ04x9EwK1GgzpqUo2IBP4FYxAx6OlOoliOz2Stkx4vYbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895809; c=relaxed/simple;
	bh=Hzc5kxwyE5zQDhATFdXci34UO+8BO8RF6ZY1gF2O28E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DCVuva4+U6CLhSMbDUkJSA8MOvCp4PfI2FKIgjkbZ4SyF4ymnVBUIKiRsOkXb6RBq8mQsWYg556WkWghtUkTAuUBVZGoaKjjvO/Pctk+F/ru/n6XCk1DKmoltw0ChmnUeid7TjqiY7CzyfApVY82acd1jxlnBvMoIT+0VyBQl74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RXbspsVS; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 50EM7vkH012476;
	Tue, 14 Jan 2025 15:03:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=Hzc5kxwyE5zQDhATFdXci34UO+8BO8RF6ZY1gF2O28E=; b=
	RXbspsVStYDAR/lLhUdf7UqyzbJnL8ZxJyvwYN650Xn24ngCz62DsgvLVmD7kI8c
	Dkoj9Q2mGpLNGlhblsk8KUijg9u5jV3ytx+BVIFP/MTIsxRVou49MdQB09uzd8vG
	pCKczfkzAYJErJFx3wIAuZrCOQiw6TZ5IGAtb9qU9GZ1bmRapu7AmvtTIUUbJHkP
	EbuxUGWIzzPgUsLrqHD2oXNIRJW+aJzYxIgIGyliTnKDZA5HdRLzlzMlSjvBaYXv
	l8eQRTn1I4UvQ8dAqaeSuLIgPzOjAEi9XFa9hjk4YVyBzNRk8qRyrOj3Jy60v3qQ
	2ciQ7vhC2pyGO1545rYJWw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by m0089730.ppops.net (PPS) with ESMTPS id 445yu50px6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 15:03:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWs3TUP5Zg+9uYy1MO+0lSyDH0Ve5faQ1sCcmuyBykoeZtkDNuvxyYx/g7wuVxLsXZc0n/b0ZkbWFw+VZUMdiVDqgRfjuzeAzJMFaA15NYcbPU7MnaF1RFJoW2wsptbWBWnEzVpzvyvlLWVQFQL9BqshUvQr+ESNKnKTZVJEfFXEtIJo/kLaXbVFZtahI6HvMlgfrQI3mDL5kdn/FPDvOvvv3R3MNmbxTRBn6HMx4wkE6JoN83vDJWDKQTQLt0h521mLDKQOUDEru6WZ2SEEjnIAxntP37Mjdwww2aYFtoRE7nsr0M8Rn30fw4HbHlNBiI3CECaULxvKpHuqidorIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hzc5kxwyE5zQDhATFdXci34UO+8BO8RF6ZY1gF2O28E=;
 b=XjHJKEsLk2FjkNwARdp19KP/bPNeTZCeNyoxcEZ4P9r5pObI2UXIdXRCemNuvEfJHZb1YnN5MyLGmag4MqBgafQo9l/D+SjYxNirXPdRbCfPuVZ3tGcZDF1JiLn7+10jPwjmCAwP5y6+Rk8SpcFrr2NPSCc00TvdCjHCZ4s2kvoUq7kBSB5QUAhmt0Or2Q5cccJ0DGyP5c9sbEMT//vlTuEgIAc6BrgCcdQf0PB4Sm2nTQv6J9WroPpSGaiH7FwX9VnvCiunD46XcDjyn7AoNkwbDVwvSngCwJat6F/S6jcgxQJeo0s8KMqn4kqm7L0y0Ju0NNM74imsj+0EZZ8ibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH7PR15MB5740.namprd15.prod.outlook.com (2603:10b6:510:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 23:03:21 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 23:03:21 +0000
From: Song Liu <songliubraving@meta.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        "paul@paul-moore.com"
	<paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "memxor@gmail.com" <memxor@gmail.com>
Subject: Re: [PATCH v8 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic for
 bpf_dynptr_from_skb
Thread-Topic: [PATCH v8 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic
 for bpf_dynptr_from_skb
Thread-Index: AQHbYh/9SYEKxpzwlUqZrwjk3qWvb7MW5YwAgAAHKgA=
Date: Tue, 14 Jan 2025 23:03:21 +0000
Message-ID: <B7F9964F-63F0-4ED6-A798-37407855675F@fb.com>
References: <20250108225140.3467654-1-song@kernel.org>
 <20250108225140.3467654-6-song@kernel.org>
 <CAEf4BzapTMSfv4afg8QnV-mX2nL8cKboXCTBwp-_cRk8ybKnQQ@mail.gmail.com>
In-Reply-To:
 <CAEf4BzapTMSfv4afg8QnV-mX2nL8cKboXCTBwp-_cRk8ybKnQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH7PR15MB5740:EE_
x-ms-office365-filtering-correlation-id: 3bc5482d-09f6-4856-4bcc-08dd34efa45f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFNSTUdYY215N29ybHc2c3RrdnlUWVlzYjBlVTFiRlgyUVQ5SURmWk0wUXZx?=
 =?utf-8?B?anFBTmFDL2tLZDM1ZEdtQTl3WFE5dnZQWnVjeDBtM1F4NGpQVS9ja2hkVFhZ?=
 =?utf-8?B?S0pxQVhiWDZuTzlkUEdPMmF1ZExuRXROaWJSWUJMc1Z0Si83bFVsMmVzYm9a?=
 =?utf-8?B?Ti83MUxyeHVRbVpBYmY0ZkxuVGgydUhKNnkyaEdvT3Y4NFZuNmZrTlNRNWIw?=
 =?utf-8?B?cWVTVEl1OUlMK3Fmb09zb20wOUVBUjlVVE9XZ0R1azI0anBLVjAxOEZaYk9Z?=
 =?utf-8?B?SjFJTWRLdHYwZDNzSHIycWxiWW1rT1IxTS9uMU9WVXZYT0xZRjRhRklXR3I0?=
 =?utf-8?B?YThocFdUOTBwR2t6dWw3L0VzSG1wYzZKeDFmYnZKR1BIem1JYUljZENkUDZR?=
 =?utf-8?B?U0lOcW1kTFRiZnY5OTV1eWVRbldZdDdlSnBML1A0c3NtVmtVR3lEUHhFeFd3?=
 =?utf-8?B?KzhFaXpXdzgvWHlNaUtFUEJtbFg5OEJGWGVJWnNmWGoxb00rMlZlQnhVZkRH?=
 =?utf-8?B?RkRoRkNBRHBKOGZ3MXZ1QUUyRDFMNHN2dlE1QW44S043UUNSOC83QVBsN3dm?=
 =?utf-8?B?R3lvNTdJWHFzYW8ydytrLzl6OVMwM3FyUW01RmFIUWRzSXZQUnFLRTVkQlBQ?=
 =?utf-8?B?bmlvN1Y1MW1aVHVQY2NLMXNTL2RHNTd1S2xWQmhRQXVGanRtbnMwTW5DMk5l?=
 =?utf-8?B?MXNBTUhhMENxeDl6Qm9jSVFFWkRlVTNDRzVrRjlCeGRma3pPQ2RHMlV6YXNK?=
 =?utf-8?B?RnhwaSttNFFMUkQ0QjNxUFRnSG5Dd0dIeEpGWUdFdUs3cXhiU0RSYWFUUTZm?=
 =?utf-8?B?YUxzTXkrdU1jYjdXSmhpYVFQeDFDeDluQk04WUc5MWIySUk1SjNnK3dNbnVX?=
 =?utf-8?B?Z1dnQlV0dDJaeGFFdHB3dmxNa0ExNUYvOEJTWWgvMlNDem81SkdXRE5kaVox?=
 =?utf-8?B?RUdYY0x6NVA1VXlXRFVqRSt4NDhuN0NkOXFtTUxMVnJSNU5wQkVDai9oQlRj?=
 =?utf-8?B?RXRWZWpPR0VKV2I0Y1NNMGNkelJqU1oyc1V2cnB4WXZGRStxMGJ5ZEh1MDFW?=
 =?utf-8?B?aTAxMmI2VEtJSHlnbWNjWVR0MGZMY29odHlMWlp3OWxCd012dWtwVmloQ1lj?=
 =?utf-8?B?cWNmYnFsckpPSGxXR0UvQkcxVG9iY29BMzNTa2tyVjJjWjl5Qm9JdEh2RzJj?=
 =?utf-8?B?NklsNEFJbjhmWXNWNDZjam9LQnhxb2RXZ3R4SnNzUTVaeVR6RGdrU01vem9T?=
 =?utf-8?B?Rmw3UGNnKzhSeitpVHlTTHU3MS9UNE5XNVJZS3NaZlgvQ2c5cDM4dStFbHJr?=
 =?utf-8?B?cWY1b1owOWx6N2JiZzZjRFo1dUUzOFdLaHkyRlg4b3JZU2M2VFNiUFNmek1G?=
 =?utf-8?B?d1kydWppaUc2dTBDcGFBSzBQNmtWSi9aYmM3czZIQ0JaRkRZckc0RkJHc2FF?=
 =?utf-8?B?Um9wL3NWbFhGc2x1Wk9lVW5NN0JDY1ZDVjJrY3Y0ajVGK3MrN1JrNHFTQ01C?=
 =?utf-8?B?cnEyMDBFb0Q3OTI0dVlnS3hCOE90aG9ETjhEUStVYjJ3U2UvSXQ5aVhaM3R0?=
 =?utf-8?B?MUkyWkZteitmcXk5YkFtUUp0UUE0MGw1ZEo5cmplV3FMaGdWSm5JeUs0NCt1?=
 =?utf-8?B?UFZvempFLzNtYWVEUkhXMUsza2VwRThCODhvV0M2VVhEUSszVkFmbXErSE5Z?=
 =?utf-8?B?Mks3MjQ2eHNFRjBCbkNSTTk1U0xtRFpONnE1cHZrRmhianIyK3BMdXRpL0Fu?=
 =?utf-8?B?VXRIaEFSVjhHTnlyRFowTXhOblA2T0E0WG94Tkg2dzc2aUdhYzdndXNJRDJC?=
 =?utf-8?B?dFpPMFVWUU1MYzhTZzFqeFZYYUNjVm9LTUZKRW1NZ04rRDl6ZXZIL2h3N2Uz?=
 =?utf-8?B?YmNFcmM5Z1ZIQWZxY3hlaGxiQzFBODdLWHRjeERIczF2a1hYSk40a215VldF?=
 =?utf-8?Q?kZ1r62vLpqIBOOSMDM0jO/WfaF60n0PV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MElOK20zZFZzOFhwWnM0TGlCWVNPT2hVSXlBbEpjMzZzZXFuSGpkN2xKb2NH?=
 =?utf-8?B?QW1La0t6aWhEelVWOVR3VkRCT0dkSW9nbGtDY3BvSUcyMW1ycTZvWGdZSHZm?=
 =?utf-8?B?Vko0YlhMQ25yeGtGVFE0U2dpQkRYcGZVYmNxY2RidDJzUGlSRTNSdGZqUmxj?=
 =?utf-8?B?dHFienJJS1RRLzMveXhNRWpENk9BTEJPVmQ1blNuQm5ld1pHZmwrSENDWnpO?=
 =?utf-8?B?S29aYzVvcWtWOVcyd09rTHZxcG5XT3JBWHVOamVUNUV3NnIwamZUYTEwYmlI?=
 =?utf-8?B?MWtHVkFSOHBKVjJ2aVJOalZUWm1UV21XZVRWTVVuSUlPRzRseWlsTDUxVTZm?=
 =?utf-8?B?SkZTM3VDdmd3SXRUYTcxdktBRUVsK2IyV0NGSFJ6My9keERUbVF2bUgrOVMx?=
 =?utf-8?B?S0g2UjVPVHRlYmlyWms0bmJkWDQxR1ZLRWFnbmlOUy9jYWtxSmwrOUJsT0dH?=
 =?utf-8?B?eVlCaExDSFBUTjhGTmVwQVZKbkkwc3pwSnhtTXFBVzBiWkYweGo0MGxINzhx?=
 =?utf-8?B?WnVwaGVrSCtYZzhqZENlcVkyQW8vZUdYQTE3dmljY3FFUzhlVUVTNmI2aU9k?=
 =?utf-8?B?SDZwR3QvRmJ0QkhQUXBiNEc5MVNBK3ptY01pVzlEYUZNempJcGRObGlCR0E0?=
 =?utf-8?B?OWN5YW5Pd0ZZZzRncmJIR1dMSU4yeU91Q2pRNHN2a2hKdmhxdkJQMVViTHJo?=
 =?utf-8?B?M0YzR0JEQTBLOER6M0s4bXdqaDJmL3NIaWhSZkJkNlZLNmthRTNZSEhBYjZ6?=
 =?utf-8?B?dXdsZzY0Y3k4U3dzT1NiVjFJdm1vUWMxUjVOcGQxYll2eGw3bmFZUFpPZjVv?=
 =?utf-8?B?YzI3cWJramIwdWp6SldkNy9Rb1FmRVUrazRCL3phdmFGWU5CYVZVWk9XaStW?=
 =?utf-8?B?Rllhb3ZjVEluYnJySzdMd1Y2THdTek9HRGVLa1JlWFl6eGNMbTlTeC83aDla?=
 =?utf-8?B?VXRlUEFRazZiL1Q4dWtQWmpWNVJuYnhoWkhzbXBOdzk3NitQT1hiRDFJM2ho?=
 =?utf-8?B?VDNyMkZLMTBBT3R2Sk1xSk0vUVBjZ1BmdnBHSWRpZ0wrV29reXB4TVI2TTQr?=
 =?utf-8?B?UnBxVnY4eSs5SkkwVk5lUWp5V0dYMUszTUpEcm5qSXBTbUJxTlZrUWJRZ0xY?=
 =?utf-8?B?bkIvYUNkSHgvMytkYXlWRVh0S25lVG0yOEZyd3pwSzFqU1BBN25pMlRRQVdY?=
 =?utf-8?B?TXhlWGp6MUpkMnRGeTgrSU5JcjNValRETk9TZlRwa3ZWMTd4RzhZM0RSc2xD?=
 =?utf-8?B?RUZtckxkTTRBV0JvblBaZWRxemM1WU54N3cveWdveUh3a2VFYUc4YlhTSkpU?=
 =?utf-8?B?UVVwbk5xY25zM1pBZUlRYTN1bjcxUyt0dldBVUlNa1hXRHFQeFBGaDNZWlVG?=
 =?utf-8?B?T2tWSVFKaDNmY3hvaWhnTnNFMkI4c1gzS3c3ZytWV2lQa1JLWjAyOGgycGlz?=
 =?utf-8?B?U1Y2aFVTQ1RPVjUydlVPOTlFZFhWLzNZczRGMGRmdXl6QXlwVmFMdWc4Yk1h?=
 =?utf-8?B?QnVYY00ra1ZPUVpRYXB0QkZ2MmdOQ0RxRzJnVGJUUGxaMkd6VmI4WmhrN09q?=
 =?utf-8?B?TVRvMlVscXpLeTUxQzQyakt1M2J4S1ZxWW5XdnNkQ29yOXlWMGVaWCs5MjF0?=
 =?utf-8?B?aUJsMFhrWTVibHhoMW5USmh0dTFyZ2pSMDZJS1cwSWxYWEVBOEtoZ3ljNVFm?=
 =?utf-8?B?OCs3RlhJd2VIS2lHb0ZHSGZyVEtBVC9renNSUHp5NTFacUVEOGVYU1hNM0I5?=
 =?utf-8?B?b2E3T2dEdVNnWENoclR5c0Z2OVUwN3BISE9Da0hxRDlYRTB4eG5QOFQzdjdV?=
 =?utf-8?B?Sk14OXk1U1UyNFF3bEdhdjBjYW9tS1lTRXJucUl3YnByRDdKTGFPeFl5N0k2?=
 =?utf-8?B?Uk9EbW16NzE1ZXJyRTg1TkFOWnAxNWVCbnNBejdWajM4b21rSURoZVQwdFlo?=
 =?utf-8?B?TVJNN0crQWgrOVNHUmRhbkpyZGV4RzdKdDNoSmV2VExyVmtoY2luQmlPZ2JZ?=
 =?utf-8?B?NVpEMjcxZHh0aGxDaDZURGtEam5GMVJpY2dxTmxYaElFWTZRUXdDMFBKM0pz?=
 =?utf-8?B?eHFJQkc3WXk0N2ZUOGFXOU5TbnlyM0h3ZGw3UEVNU2huaHdWZFRpdHBweTc5?=
 =?utf-8?B?Rm5kaXloYWU1UzhESjBuSWxrMkhlZHcrRDZ0MXNYR3JTc0Jvcmszb1F5K2pj?=
 =?utf-8?Q?/ohUfMVg1ZKuL6/wG2sRrNU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F872DEC2DA68443A18FD84544C2DBF5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc5482d-09f6-4856-4bcc-08dd34efa45f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 23:03:21.5545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rEKgCobd1wbFPiKw5eK6Rj4L4YbgdWq2l4Qo410XhkCBPrIiUEOj5D1AWEBEc2j4R1tV9JZ/IovV1a1Nwk6DRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5740
X-Proofpoint-ORIG-GUID: bhI7eE_zB3wnh0CyFNu444_g81d3lE5z
X-Proofpoint-GUID: bhI7eE_zB3wnh0CyFNu444_g81d3lE5z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_08,2025-01-13_02,2024-11-22_01

DQoNCj4gT24gSmFuIDE0LCAyMDI1LCBhdCAyOjM34oCvUE0sIEFuZHJpaSBOYWtyeWlrbyA8YW5k
cmlpLm5ha3J5aWtvQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KDQpbLi4uXQ0KDQo+PiANCj4+ICAg
ICAgICBpZiAoYnBmX2Rldl9ib3VuZF9rZnVuY19pZChmdW5jX2lkKSkgew0KPj4gICAgICAgICAg
ICAgICAgeGRwX2tmdW5jID0gYnBmX2Rldl9ib3VuZF9yZXNvbHZlX2tmdW5jKHByb2csIGZ1bmNf
aWQpOw0KPj4gQEAgLTIwODMzLDIyICsyMDgzNiw2IEBAIHN0YXRpYyB2b2lkIHNwZWNpYWxpemVf
a2Z1bmMoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwNCj4+ICAgICAgICAgICAgICAgIH0N
Cj4+ICAgICAgICAgICAgICAgIC8qIGZhbGxiYWNrIHRvIGRlZmF1bHQga2Z1bmMgd2hlbiBub3Qg
c3VwcG9ydGVkIGJ5IG5ldGRldiAqLw0KPj4gICAgICAgIH0NCj4+IC0NCj4+IC0gICAgICAgaWYg
KG9mZnNldCkNCj4+IC0gICAgICAgICAgICAgICByZXR1cm47DQo+PiAtDQo+PiAtICAgICAgIGlm
IChmdW5jX2lkID09IHNwZWNpYWxfa2Z1bmNfbGlzdFtLRl9icGZfZHlucHRyX2Zyb21fc2tiXSkg
ew0KPj4gLSAgICAgICAgICAgICAgIHNlZW5fZGlyZWN0X3dyaXRlID0gZW52LT5zZWVuX2RpcmVj
dF93cml0ZTsNCj4+IC0gICAgICAgICAgICAgICBpc19yZG9ubHkgPSAhbWF5X2FjY2Vzc19kaXJl
Y3RfcGt0X2RhdGEoZW52LCBOVUxMLCBCUEZfV1JJVEUpOw0KPj4gLQ0KPj4gLSAgICAgICAgICAg
ICAgIGlmIChpc19yZG9ubHkpDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAqYWRkciA9ICh1
bnNpZ25lZCBsb25nKWJwZl9keW5wdHJfZnJvbV9za2JfcmRvbmx5Ow0KPj4gLQ0KPj4gLSAgICAg
ICAgICAgICAgIC8qIHJlc3RvcmUgZW52LT5zZWVuX2RpcmVjdF93cml0ZSB0byBpdHMgb3JpZ2lu
YWwgdmFsdWUsIHNpbmNlDQo+PiAtICAgICAgICAgICAgICAgICogbWF5X2FjY2Vzc19kaXJlY3Rf
cGt0X2RhdGEgbXV0YXRlcyBpdA0KPj4gLSAgICAgICAgICAgICAgICAqLw0KPj4gLSAgICAgICAg
ICAgICAgIGVudi0+c2Vlbl9kaXJlY3Rfd3JpdGUgPSBzZWVuX2RpcmVjdF93cml0ZTsNCj4gDQo+
IGlzIGl0IHNhZmUgdG8gcmVtb3ZlIHRoaXMgc3BlY2lhbCBzZWVuX2RpcmVjdF93cml0ZSBwYXJ0
IG9mIGxvZ2ljPw0KDQpXZSBuZWVkIHRvIHNhdmUgYW5kIHJlc3RvcmUgc2Vlbl9kaXJlY3Rfd3Jp
dGUgYmVjYXVzZSANCm1heV9hY2Nlc3NfZGlyZWN0X3BrdF9kYXRhKCkgbXV0YXRlcyBpdC4gSWYg
d2UgZG8gbm90IGNhbGwgDQptYXlfYWNjZXNzX2RpcmVjdF9wa3RfZGF0YSgpIGhlcmUsIGFzIGFm
dGVyIHRoaXMgcGF0Y2gsIHdlIGRvbid0IG5lZWQgdG8gDQpzYXZlIGFuZCByZXN0b3JlIHNlZW5f
ZGlyZWN0X3dyaXRlLiANCg0KPiANCj4+IC0gICAgICAgfQ0KPj4gfQ0KPj4gDQo+PiBzdGF0aWMg
dm9pZCBfX2ZpeHVwX2NvbGxlY3Rpb25faW5zZXJ0X2tmdW5jKHN0cnVjdCBicGZfaW5zbl9hdXhf
ZGF0YSAqaW5zbl9hdXgsDQo+PiBkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvZmlsdGVyLmMgYi9uZXQv
Y29yZS9maWx0ZXIuYw0KPj4gaW5kZXggMjExMzFlYzI1ZjI0Li5mMTJiY2MxYjIxZDEgMTAwNjQ0
DQo+PiAtLS0gYS9uZXQvY29yZS9maWx0ZXIuYw0KPj4gKysrIGIvbmV0L2NvcmUvZmlsdGVyLmMN
Cj4+IEBAIC0xMjA0NywxMCArMTIwNDcsOCBAQCBfX2JwZl9rZnVuYyBpbnQgYnBmX3NrX2Fzc2ln
bl90Y3BfcmVxc2soc3RydWN0IF9fc2tfYnVmZiAqcywgc3RydWN0IHNvY2sgKnNrLA0KPj4gI2Vu
ZGlmDQo+PiB9DQo+PiANCj4+IC1fX2JwZl9rZnVuY19lbmRfZGVmcygpOw0KPj4gLQ0KPj4gLWlu
dCBicGZfZHlucHRyX2Zyb21fc2tiX3Jkb25seShzdHJ1Y3QgX19za19idWZmICpza2IsIHU2NCBm
bGFncywNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYnBmX2R5bnB0
ciAqcHRyX191bmluaXQpDQo+PiArX19icGZfa2Z1bmMgaW50IGJwZl9keW5wdHJfZnJvbV9za2Jf
cmRvbmx5KHN0cnVjdCBfX3NrX2J1ZmYgKnNrYiwgdTY0IGZsYWdzLA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBicGZfZHlucHRyICpwdHJfX3Vu
aW5pdCkNCj4+IHsNCj4+ICAgICAgICBzdHJ1Y3QgYnBmX2R5bnB0cl9rZXJuICpwdHIgPSAoc3Ry
dWN0IGJwZl9keW5wdHJfa2VybiAqKXB0cl9fdW5pbml0Ow0KPj4gICAgICAgIGludCBlcnI7DQo+
PiBAQCAtMTIwNjQsMTAgKzEyMDYyLDE2IEBAIGludCBicGZfZHlucHRyX2Zyb21fc2tiX3Jkb25s
eShzdHJ1Y3QgX19za19idWZmICpza2IsIHU2NCBmbGFncywNCj4+ICAgICAgICByZXR1cm4gMDsN
Cj4+IH0NCg0KWy4uLl0NCg0KPj4gKw0KPj4gK3N0YXRpYyB1MzIgYnBmX2tmdW5jX3NldF9za2Jf
cmVtYXAoY29uc3Qgc3RydWN0IGJwZl9wcm9nICpwcm9nLCB1MzIga2Z1bmNfaWQpDQo+PiArew0K
Pj4gKyAgICAgICBpZiAoa2Z1bmNfaWQgIT0gYnBmX2R5bnB0cl9mcm9tX3NrYl9saXN0WzBdKQ0K
Pj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0KPj4gKw0KPj4gKyAgICAgICBzd2l0Y2ggKHJl
c29sdmVfcHJvZ190eXBlKHByb2cpKSB7DQo+PiArICAgICAgIC8qIFByb2dyYW0gdHlwZXMgb25s
eSB3aXRoIGRpcmVjdCByZWFkIGFjY2VzcyBnbyBoZXJlISAqLw0KPj4gKyAgICAgICBjYXNlIEJQ
Rl9QUk9HX1RZUEVfTFdUX0lOOg0KPj4gKyAgICAgICBjYXNlIEJQRl9QUk9HX1RZUEVfTFdUX09V
VDoNCj4+ICsgICAgICAgY2FzZSBCUEZfUFJPR19UWVBFX0xXVF9TRUc2TE9DQUw6DQo+PiArICAg
ICAgIGNhc2UgQlBGX1BST0dfVFlQRV9TS19SRVVTRVBPUlQ6DQo+PiArICAgICAgIGNhc2UgQlBG
X1BST0dfVFlQRV9GTE9XX0RJU1NFQ1RPUjoNCj4+ICsgICAgICAgY2FzZSBCUEZfUFJPR19UWVBF
X0NHUk9VUF9TS0I6DQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIGJwZl9keW5wdHJfZnJvbV9z
a2JfbGlzdFsxXTsNCj4+ICsNCj4+ICsgICAgICAgLyogUHJvZ3JhbSB0eXBlcyB3aXRoIGRpcmVj
dCByZWFkICsgd3JpdGUgYWNjZXNzIGdvIGhlcmUhICovDQo+PiArICAgICAgIGNhc2UgQlBGX1BS
T0dfVFlQRV9TQ0hFRF9DTFM6DQo+PiArICAgICAgIGNhc2UgQlBGX1BST0dfVFlQRV9TQ0hFRF9B
Q1Q6DQo+PiArICAgICAgIGNhc2UgQlBGX1BST0dfVFlQRV9YRFA6DQo+PiArICAgICAgIGNhc2Ug
QlBGX1BST0dfVFlQRV9MV1RfWE1JVDoNCj4+ICsgICAgICAgY2FzZSBCUEZfUFJPR19UWVBFX1NL
X1NLQjoNCj4+ICsgICAgICAgY2FzZSBCUEZfUFJPR19UWVBFX1NLX01TRzoNCj4+ICsgICAgICAg
Y2FzZSBCUEZfUFJPR19UWVBFX0NHUk9VUF9TT0NLT1BUOg0KPj4gKyAgICAgICAgICAgICAgIHJl
dHVybiBrZnVuY19pZDsNCj4+ICsNCj4+ICsgICAgICAgZGVmYXVsdDoNCj4+ICsgICAgICAgICAg
ICAgICBicmVhazsNCj4+ICsgICAgICAgfQ0KPj4gKyAgICAgICByZXR1cm4gYnBmX2R5bnB0cl9m
cm9tX3NrYl9saXN0WzFdOw0KPj4gK30NCj4gDQo+IEknZCBwZXJzb25hbGx5IHByZWZlciB0aGUg
YXBwcm9hY2ggd2UgaGF2ZSB3aXRoIEJQRiBoZWxwZXJzLCB3aGVyZQ0KPiBlYWNoIHByb2dyYW0g
dHlwZSBoYXMgYSBmdW5jdGlvbiB0aGF0IGhhbmRsZXMgYWxsIGhlbHBlcnMgKGlkZW50aWZpZWQN
Cj4gYnkgaXRzIElEKSwgYW5kIHRoZW4gd2UgY2FuIHVzZSBDIGNvZGUgc2hhcmluZyB0byBtaW5p
bWl6ZSBkdXBsaWNhdGlvbg0KPiBvZiBjb2RlLg0KDQpEaWZmZXJlbnQgaG9va3Mgb2YgdGhlIHNh
bWUgcHJvZ3JhbSB0eXBlLCBlc3BlY2lhbGx5IHN0cnVjdF9vcHMsIG1heSANCm5vdCBoYXZlIHNh
bWUgYWNjZXNzIHRvIGRpZmZlcmVudCBrZnVuY3MuIFRoZXJlZm9yZSwgSSBhbSBub3Qgc3VyZSAN
CndoZXRoZXIgdGhlIGFwcHJvYWNoIHdpdGggaGVscGVycyBjYW4gc2NhbGUgaW4gdGhlIGxvbmcg
dGVybS4gQXQgdGhlDQptb21lbnQsIHdlIHVzZSBzcGVjaWFsX2tmdW5jX1t0eXBlfHNldHxsaXN0
XSB0byBoYW5kbGUgc3BlY2lhbCBjYXNlcy4gDQpCdXQgSSBhbSBhZnJhaWQgdGhpcyBhcHByb2Fj
aCBjYW5ub3Qgd29yayB3ZWxsIHdpdGggbW9yZSBzdHJ1Y3Rfb3BzDQphbmQga2Z1bmNzLiANCg0K
PiANCj4gV2l0aCB0aGlzIGFwcHJvYWNoIGl0IHNlZW1zIGxpa2Ugd2UnbGwgaGF2ZSBtb3JlIGR1
cGxpY2F0aW9uIGFuZCB3ZSdsbA0KPiBuZWVkIHRvIHJlcGVhdCB0aGVzZSBwcm9ncmFtIHR5cGUt
YmFzZWQgbGFyZ2Ugc3dpdGNoZXMgZm9yIHZhcmlvdXMNCj4gc21hbGwgc2V0cyBvZiBrZnVuY3Ms
IG5vPw0KDQpUaGUgbW90aXZhdGlvbiBpcyB0byBtYWtlIHRoZSB2ZXJpZmljYXRpb24gb2Yga2Z1
bmNzIG1vcmUgbW9kdWxhciwgc28gDQp0aGF0IGVhY2ggc2V0IG9mIGtmdW5jcyBoYW5kbGUgdGhl
aXIgdmVyaWZpY2F0aW9uIGFzIG11Y2ggYXMgcG9zc2libGUuDQoNCkkgdGhpbmsgdGhlIGNvZGUg
ZHVwbGljYXRpb24gaGVyZSAoYnBmX2tmdW5jX3NldF9za2JfcmVtYXApIGlzIG5vdCBhDQpjb21t
b24gcHJvYmxlbS4gQW5kIHdlIGNhbiBhY3R1YWxseSByZWR1Y2UgZHVwbGljYXRpb24gd2l0aCBz
b21lIA0Kc2ltcGxlIGhlbHBlcnMuIA0KDQpEb2VzIHRoaXMgbWFrZSBzZW5zZT8NCg0KVGhhbmtz
LA0KU29uZw0KDQoNCg==

