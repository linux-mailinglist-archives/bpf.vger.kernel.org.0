Return-Path: <bpf+bounces-29874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D74CB8C7DF8
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 23:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D73A282B61
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 21:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E61158200;
	Thu, 16 May 2024 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bjOTM0oP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F7157A76
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715894217; cv=fail; b=ERbIhRc2QloPtZsxQgS7uLIVJBQ16JImqbR8IF4TfOCu2RVTvO2/KdiPswLF3A1MgZ2fY42Ncg/79sq7ZS6IDQt/t2uTXoCvLIQp9m/wqrePAwYR8vuQc7gImtZiabcdwricZekW1xsvrrEPf74uTcGzhDQTE78t3jsW4HXukek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715894217; c=relaxed/simple;
	bh=LuauAXlLAqZ6Ag03lu98L7b3pVdINLfeC5/o3zZDuBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qUzDsv+BIJRV89fRMlkqj8oBeXuHkrB+Ww++GBm1FUowt2Sdz0INyF6I/nWl+TIIKGDaog9YcYIK0AW8qcmGrveFYO+FhWFATTjZnKHv6dcqJchWq8doAQdJs0Sa5y7FPePj/Sm52LCcb7n+6l9vTxZswQOImtDjAFl45dMj18g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bjOTM0oP; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GJQs86014388
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 14:16:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=LuauAXlLAqZ6Ag03lu98L7b3pVdINLfeC5/o3zZDuBY=;
 b=bjOTM0oPlFDm3YqxthBXOC75MSbeW4J21oUF9LZBggZqq/c2yaTR/dZjpjnG2bR6zDXh
 m/FEkRVH/vHaXW/wmrfmAOItni7gPGuOr5SB+xvVA3i4txnRQ2qEsr3SbQ88EQzmKxXp
 H8akOyxdrpyy/LXP05wxsomoNWOJqnxwdJp4qaJ5MIjkG2HFcK1M+otOcmbRefoTsVfS
 yt+Vzub+PSEj9oVEt7FKp5HaMi93XBFT6ZmGo0q2lHshKQKwZ6TxMxZy/BpGwSJIluZu
 c/Boq9pH5eAD37PZ1L3OXy8ILUFQFUnwq1RwQWlB+n+cR1ui4zvcV4DdzMk3nQcRciYE aw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y52f6fgeu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 14:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTElGWy2Q+1J4yr7GD1bwyZOoikaF1HpBenwQfmQqnHWMhbBjpniNZQPBpxl73o5o8Wh0v9JIrgVK3JBtityTOf8LVClM3pD1CWNoUHyHZWdMVg7mmhyT4532iHVTGYrh5YWN9lmlagOuKz25rYiU8/x1xdPSfXpgA1AiLTUIAz3yHO+YzBK468nBqqsDAvDAlUULepRHeK459dfml3Uv1fmL0aHWR4N8H/OpQyP/8H0Yf1p5IOtvZWzPnCb9AXoh0PrnruO70PB+numkk+tjI5gfD+/5ECdYFKGGxCyJxWGHvBMEX90SUlctDTEWHqVs8LInYlLKRelAyYlq6yBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuauAXlLAqZ6Ag03lu98L7b3pVdINLfeC5/o3zZDuBY=;
 b=RSduMUgOChTTZc26IKykI4AsnI0G4kQBN1y54BunM07PMBcMAq4fzVMf2NE8bIdXNQEZCWSz2HUKe7JAcaNIso0wwOhqkAYx5+N6GaxebJqXj7VrAempdBl24IOKGKVd9dGnSKkQd1OUaFAn9dEvDwz2YqfeK6X6apasHshvTP550IT85sLFl/9TBzcJQbUQPBrzvTvXo4Tjb0Bos3zuP0bpKWK2J3eDWrCQRUs6yCeJo7TDs9X/0ZgDdf5cxxIA6be20f8/8ikW6ti8G5QBSJgfYntoSuNQFiIjlVjtaFGGST3A3opwr2F3wus7ywTk4f/gRmIhI5FWm31tns0wGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM4PR15MB5354.namprd15.prod.outlook.com (2603:10b6:8:5d::18) by
 SJ0PR15MB4646.namprd15.prod.outlook.com (2603:10b6:a03:37b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.28; Thu, 16 May 2024 21:16:51 +0000
Received: from DM4PR15MB5354.namprd15.prod.outlook.com
 ([fe80::e84c:cac0:88e2:b0e6]) by DM4PR15MB5354.namprd15.prod.outlook.com
 ([fe80::e84c:cac0:88e2:b0e6%7]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 21:16:51 +0000
From: Raman Shukhau <ramasha@meta.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/1] Fix for bpf_sysctl_set_new_value
Thread-Topic: [PATCH bpf-next 1/1] Fix for bpf_sysctl_set_new_value
Thread-Index: AQHang1JrGMVVIiBWUepzuOwVHxc1LGMbjoAgA4CWwA=
Date: Thu, 16 May 2024 21:16:50 +0000
Message-ID: <0A9C587D-A524-4206-BDBB-C27515606DB4@fb.com>
References: <20240504102312.3137741-1-ramasha@fb.com>
 <20240504102312.3137741-2-ramasha@fb.com>
 <ca8136e0-5d2a-402b-ad03-cc8a218affd4@linux.dev>
In-Reply-To: <ca8136e0-5d2a-402b-ad03-cc8a218affd4@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR15MB5354:EE_|SJ0PR15MB4646:EE_
x-ms-office365-filtering-correlation-id: d5e46263-92be-4638-b145-08dc75ed80e2
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QTFYVk90R0c2a0Vmdlc5OVBUMG93NkxsTVQwZEp5cy9Fc0JpNDFUVFBBOGpj?=
 =?utf-8?B?WWtZODRnZE1FSGV1QmFEQ0hGQkZoR2gvYmJHSXpidDZmRnRGWGhZVm1qVVBo?=
 =?utf-8?B?NENwSWY3TXQzQmw1S2NmcUR3TUJsQ1Nqd1dSQmxsUzZ5RXV4QnNNVVRnR2w2?=
 =?utf-8?B?bU9VSGU1eVJPOS9RWnMvcVphem52K3gyV2hhNmNjbkJQZDFEWjZDNDBqNG9x?=
 =?utf-8?B?S2JTTGlaZDZFbGFZUHhCQ2tFcnRWYUVTaEUzRzl5VU5hMnloSzFhOGtKclc5?=
 =?utf-8?B?Sk5yZTZvangwMDFPZVkzOGNyQ0RmeWJadEowcnFvVlFodDFYNDVNU1dFRDN2?=
 =?utf-8?B?TzVXRkhOM1NvMGtzRHZzRWNsTGpMaHYwbXBkM0RvMUZVbkpLUEhxQmF5NzRD?=
 =?utf-8?B?YVV1K0tvb1A0Ni9LN2ZiWW1OWnJaRE5PK3hSSVhVK3dLNmlwRnF5UDRMeG8w?=
 =?utf-8?B?ai9mOS9lamcvbXdMSmJDQmtaY0ZESkNRMld1UUlEUVJxVi9YcnRULy9TOWF1?=
 =?utf-8?B?V0NLaHB2b1FWMTI2Nm9SRVI1QURROUFaM1dvL2V2b1NpK1VuY001Rm1XSVJZ?=
 =?utf-8?B?TTVxMnJWTzVUUUNHOENDRW1PUHJlL3V3WnJCWVEzNzh0WHpmbzJzZWwyWkdu?=
 =?utf-8?B?OGx3MXZrTWRJSHBFcGx5NmQ3Si9LT2dCOE50V0lHWVhlZThJcy9KY1dOcGxr?=
 =?utf-8?B?d3V1VUVGcWRoV3QzbEJteHRFZjdweUJyQTFuZC9OeW8rc0NNdW9YaTloTG5H?=
 =?utf-8?B?K1prbFdOOUVWbUxsZFlpK0dMcXJNNzh4TFFWTEZYWTJwWGhpU3lSNm5IaW80?=
 =?utf-8?B?b2dXZ1d4TVNkNzFkbWY1ZXNXYVI5aS9wV3BnTnNBRi83UFA1MmtyZEs5MzND?=
 =?utf-8?B?ZkViaDV6eUFFc0NUa3p3RnhPeURnR0dHZHEwVWlnMUNJNjJQQ0VhUDR4dHh5?=
 =?utf-8?B?OEVSWDlsSDJCOWpGS2U5ZDhBakVvTVdQeFNtNjVxeWdWN2J0dTZEU3ZuN1Zp?=
 =?utf-8?B?Smh3MW4zRHM4Mm5aY2VaSm5qSk5NZVZiSWNYNStXQ2xBSmk3WEQwMEtnWEs0?=
 =?utf-8?B?Y0NKNkZBTUljVmJ6R09saTVXQk0wc2NteDJ3Q2VyNExiZWJDRnlhQVljUXRt?=
 =?utf-8?B?SFQ2V3NuTXJkY1lKVDlPR3RQVjVnUVR4bHM5MlVCWnpNVlgwcnk5eVdmOHhR?=
 =?utf-8?B?ZndkTE9NYkI5YjZjYlRvaGtRMW5EMTd2cTFqaUNkTmtRMVFYNFV5blh5REZD?=
 =?utf-8?B?RU5kS3R3SlRrTHhrRGwwT0dQclRITUw3UW9panVUcjlhNVBkT0hMVzVxV04r?=
 =?utf-8?B?VmhFTGFMdXRZS21waE9LUWxLczYxUXlZZm95REU4NFFRdmpLT1kvSG1MYjVS?=
 =?utf-8?B?eVFjdWVtY1NlZjNvNTdvbGg2YzVHeWlTWktZNXZUUktzZW1XWGV1elc2OFNw?=
 =?utf-8?B?SHYzSW5aeGkzbVRUQUpxY2NKUGVyd005ZndDeHowUkd3QkhlY1hYQXRXcGRF?=
 =?utf-8?B?WHNab3hXV1RjYjh0ejBucUZoNDdnK2FodEdGU3QvVmRjVVplelQ5Snhmd0RN?=
 =?utf-8?B?K0c2blZJRG4zY1QvUTlNTUoybzVuU29OWmNNT1ZheDB2emNsN3pyaDdrZmx6?=
 =?utf-8?B?RitpOHVIdDhrakFqSUx4SmVSWXRPaW1iWDdCbVZpZVhjV1ZoUlhMclNiZmNP?=
 =?utf-8?B?OVo1ZHpRalM1ZkIvOHVlMEJScGU0R0JpT1pJSVNuS2VxWHBpdkJoTnJEK29V?=
 =?utf-8?B?YllySUFoVW45YVZ4ZXdaY0JxY09neVE4UU1FM0J3TEV1eURLbFRhZGZUbW5p?=
 =?utf-8?B?MGI3dU5IU0dCYVlyY2dhZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR15MB5354.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cnlabEpkUE1RU3JQQzFTdCtxbFhKTGRGamlsKzNBV3QwMWZTUDRsVHpza1Vm?=
 =?utf-8?B?bnNsN28vZEZYZmRwaDUxMWVOeDNJUStMdURZMmliNVRCN0NicjJ4VlJjUjBn?=
 =?utf-8?B?YmFBU3FydldJZTA5SEg2R1p3M21lN1pQbTR4OERyOGEzSTZmVElZeGxQRWNY?=
 =?utf-8?B?Y2x6a1RPa0lKOW9sNStoaEhIUG1RSElvT282U0YyNi9zSStSZVRpdlp0RENO?=
 =?utf-8?B?bkV3SFJHMC9OakJNY29TakgzNE9aTVhsYnNpWlFSaUgxSk0wTEg1V3V2UFRE?=
 =?utf-8?B?U09FSzVwVVl4aG5xOE5PV1BFMVN1ZFZuSVlJSkRXVDVkdnJ3bjVKdnh3Qll2?=
 =?utf-8?B?S0ZxSnA5eU9sV3l5SFRQa3duL2FPU1RDbCtCdWoyVlZjRzc2NWlIMlRETmVm?=
 =?utf-8?B?d2h3MXpSTnluRGhaU01Halprc3F1ZHBaRlF5Ni9wdzJVVk5yeUI3VWlRcTJs?=
 =?utf-8?B?dHIySGNzUlE2NTdDRXUxay9WNWlPVU9La0xScUV3QXRGRjFSdzBqVlBqbi9B?=
 =?utf-8?B?NHJkNi9aTU56US96M0orZnR3d29PNHVSK09JeXh5ankwa0dLc01jYWNPZDZC?=
 =?utf-8?B?TGtJZnVrTXAxNzhWdTRlUXB3TE9ybkpva0E5ZEM0V1Z1U1ZWVXB4ZTRCY2Ez?=
 =?utf-8?B?akFwS2E3a1I5VWlTeStGY2Jkcy94OFh1WFc5bEc3SkVCTjVjUlhRVHV0NFZn?=
 =?utf-8?B?M3ZoUzBCM2xnaGJDeEl0OW03Sm1yN1lIdDNYR2t6ekZJck95ZGFpQkdpQm5B?=
 =?utf-8?B?Z0FCMDlOTUY0Qmk3a3ozbmdSbE1wOGlaSy9UZXk1NmJvMjFnWkwxaG5BUEpv?=
 =?utf-8?B?azRnRWlLaXRxVVRUL3FicTdXNjVaditxT3JYNElIU1NySGZIempZWlB0amVC?=
 =?utf-8?B?TDdEa3lVdWE2dHlkQldXQS8xdDlEbE5nZnlPalVhaDRMMlQvZUJ2cndEeFRW?=
 =?utf-8?B?TVA4UkxVY0taZkhYbkIrQzdUVW1TeWhlMWJvSDkvK0lMQ3ppYkdiRWpzbE4y?=
 =?utf-8?B?eG9UVGJlWGU5ZzlmNWtkakd1RFBXVzRyTTBmV0Z4ekJPZ1VRdnFjczY3ZUd3?=
 =?utf-8?B?TlNPcE1kbzEvam5UaFM2NzdRc3Rwc3cyZllKblE2cUUxVVoxVTVab3FoMHlm?=
 =?utf-8?B?T0FEbzdHWnJvM2Zpa0lNMXJYR2tZWGlTUDJiTkZvVHVCZGRFcVJGenQzZHVi?=
 =?utf-8?B?SXVxVkEvQzJpWlBydWMxTnQvbXNzeGFxbFdzY2lnMU4zcGZ6S1pLM29RUGlh?=
 =?utf-8?B?NWxsaGtaR09GVTRJRnpyMGVKY2kvaW9uMmdTVERkZmp0S0d3RGoycDAxdUlL?=
 =?utf-8?B?M29XMnZWVmdLQTBLbXAyR3prWXNLdFhJME9rT3pHTDVoalhOelhpbkQ2MXZi?=
 =?utf-8?B?Wk5Gc0Vpa2Z4NmR4ZFdDbTdYQVRBZjFiV3ZERXRVZHpVZ2JrOXhJS3N4M2ov?=
 =?utf-8?B?Uk9jdU85MEdxSW1yRTdsdGdYcDdhYVpSb2JTYUZOQ01nbzJWbStOYityQWVR?=
 =?utf-8?B?bjJFMEExbXhMZDNjb21JbFQ0ZWRucHIrWktEMDZUdmVxWThaUkhUajYrZnlv?=
 =?utf-8?B?NTNCeG1LcDdJRWZDTk95NGJqUG5Nck9zZW8wWWdsNTdBaVBWME1hbWFKT2VT?=
 =?utf-8?B?Zy9ObDBtRXRqdHRMY0huUm00ZWZ3VVNuOExZdWIwejBVR3JQUGFOSklnRTdP?=
 =?utf-8?B?S0E0ZHZhQ2duRWhKY2ZYcUMyd2VQSi9VVlFML1pMV3JrR3VFVi96NHQwS0k3?=
 =?utf-8?B?RFB3Z3hkOTFCTDhnOThuQWVpT2QvODlqQ3ZwbWt5T09FZUhRTE5FVm11c09F?=
 =?utf-8?B?UW1CK1hWZG0vWE02K1pCVTd5STk4QzltbWJST1hHdzJVbkowVm1lclVsYUFZ?=
 =?utf-8?B?d0p5MmhxWGZ6UWVORy9VRmpoUENSM0FWTnJBMEVaMWNqeWdhYlpHRDFmeWtw?=
 =?utf-8?B?L1g1VnR0TnJCZS9IQmxzR0pyd0VQd0lRTkFJT1VJdW8yN3dBUThzOWhoOVh4?=
 =?utf-8?B?VENLV1ExSHBHZDVBMU5RWGc1a0lXZ1NQVmpCTWcyL0M1TmQxS25rcGpPaTBo?=
 =?utf-8?B?NUFiTmtFNWV5cnYvQnJpQnB3c3JvNDExUmdOOVA4Snl5bFNyTFZXclpZVEJr?=
 =?utf-8?B?UHgrVFd2VEo0VmlGaGx2YUE3WFI4S05DTGJJTktaTnBSUU0vOUlKUS9NTUxR?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F0CF4E0C5855B4AAD80852998D06F84@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR15MB5354.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e46263-92be-4638-b145-08dc75ed80e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 21:16:50.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdqC1UMDzI7ilLM4kkcOsHMgnJZzTM9whRFjYN0pV3vZaXtnrp7a142nQCfKTrxx8f+hCLsN4HhLptMNRXwthw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4646
X-Proofpoint-ORIG-GUID: kxrOzDywdp3bIr5ZypiAlQoOQ7_ziA_O
X-Proofpoint-GUID: kxrOzDywdp3bIr5ZypiAlQoOQ7_ziA_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02

PiBidHcsIEkgYW0gY3VyaW91cyB3aGF0IGlzIG1pc3NlZCBpbiB0aGUgdGVzdF9zeXNjdGwuYyB0
aGF0IGRpZG4ndCBjYXRjaCB0aGUgcmV0dXJuIHZhbHVlIGNhc2U/DQoNClRlc3QgZGlkbuKAmXQg
Y2hlY2sgbmV3IHN5c2N0bCB2YWx1ZSwgb25seSBpZiByZXR1cm4gY29kZSBpcyBzdWNjZXNzZnVs
LiBJbiB0aGlzIGNhc2UgaXQgc2lsZW50bHkgaWdub3JlcyBuZXcgdmFsdWUuDQoNCg0KPiBGcm9t
IGxvb2tpbmcgYXQgaG93IG5ld191cGRhdGVkIGlzIHNldCwgbXkgdW5kZXJzdGFuZGluZyBpcyBu
ZXdfbGVuIGNhbm5vdCBiZSAwIGhlcmUuIGp1c3Qgd2FudCB0byBkb3VibGUgY2hlY2suDQoNCmJw
Zl9zeXNjdGxfc2V0X25ld192YWx1ZSBjaGVja3MgdGhhdCBuZXdfbGVuIGlzIG5vdCAwLCBvdGhl
cndpc2UgcmV0dXJucyBFSU5WQUwNCg0KDQoNCj4gT24gTWF5IDcsIDIwMjQsIGF0IDQ6MjDigK9Q
TSwgTWFydGluIEthRmFpIExhdSA8bWFydGluLmxhdUBsaW51eC5kZXY+IHdyb3RlOg0KPiANCj4g
DQo+IE9uIDUvNC8yNCAzOjIzIEFNLCBSYW1hbiBTaHVraGF1IHdyb3RlOg0KPj4gTm90aWNlZCB0
aGF0IGNhbGwgdG8gYnBmX3N5c2N0bF9zZXRfbmV3X3ZhbHVlIGRvZXNuJ3QgY2hhbmdlIGZpbmFs
IHZhbHVlDQo+PiBvZiB0aGUgcGFyYW1ldGVyLCB3aGVuIGNhbGxlZCBmcm9tIGNncm91cC9zeXNj
YWxsIGJwZiBoYW5kbGVyLiBObyBlcnJvcg0KPj4gdGhyb3duIGluIHRoaXMgY2FzZSwgbmV3IHZh
bHVlIGlzIHNpbXBseSBpZ25vcmVkIGFuZCBvcmlnaW5hbCB2YWx1ZSwgc2VudA0KPj4gdG8gc3lz
Y3RsLCBpcyBzZXQuIEV4YW1wbGUgKHNlZSB0ZXN0IGFkZGVkIHRvIHRoaXMgY2hhbmdlIGZvciBC
UEYgaGFuZGxlcg0KPj4gbG9naWMpOg0KPj4gc3lzY3RsIC13IG5ldC5pcHY0LmlwX2xvY2FsX3Jl
c2VydmVkX3BvcnRzID0gMTExMTENCj4+IC4uLiBjZ3JvdXAvc3lzY2FsIGhhbmRsZXIgY2FsbCBi
cGZfc3lzY3RsX3NldF9uZXdfdmFsdWUJYW5kIHNldCAyMjIyMg0KPj4gc3lzY3RsIG5ldC5pcHY0
LmlwX2xvY2FsX3Jlc2VydmVkX3BvcnRzDQo+PiAuLi4gcmV0dXJucyAxMTExMQ0KPj4gT24gaW52
ZXN0aWdhdGlvbiBJIGZvdW5kIDIgdGhpbmdzIHRoYXQgbmVlZHMgdG8gYmUgY2hhbmdlZDoNCj4+
ICogcmV0dXJuIHZhbHVlIGNoZWNrDQo+PiAqIG5ld19sZW4gcHJvdmlkZWQgYnkgYnBmIGJhY2sg
dG8gc3lzY3RsLiBwcm9jX3N5c19jYWxsX2hhbmRsZXIJZXhwZWN0cw0KPj4gICB0aGlzIHZhbHVl
IE5PVCB0byBpbmNsdWRlIFwwIHN5bWJvbCwgZS5nLiBpZiB1c2VyIGRvDQo+IA0KPiBUaGFua3Mg
Zm9yIHRoZSByZXBvcnQgYW5kIHRoZSBwYXRjaC4NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgY2hhbmdp
bmcgYSBmZXcgdGhpbmdzICgxIGZpeCwgMSBpbXByb3ZlbWVudCwgMSB0ZXN0KS4NCj4gDQo+IFNl
cGFyYXRlIHRoZXNlIGluZGl2aWR1YWwgY2hhbmdlcyBpbnRvIGl0cyBvd24gcGF0Y2guIFBhdGNo
IDEgZml4ZXMgdGhlIHJldHVybiB2YWx1ZS4gUGF0Y2ggMiBpbXByb3ZlcyB0aGUgJ1wwJyBhbmQg
KnBjb3VudCBzaXR1YXRpb24uIFBhdGNoIDMgYWRkcyB0aGUgdGVzdC4NCj4gDQo+IGJ0dywgSSBh
bSBjdXJpb3VzIHdoYXQgaXMgbWlzc2VkIGluIHRoZSB0ZXN0X3N5c2N0bC5jIHRoYXQgZGlkbid0
IGNhdGNoIHRoZSByZXR1cm4gdmFsdWUgY2FzZT8NCj4gDQo+PiAJYGBgDQo+PiAgIG9wZW4oIi9w
cm9jL3N5cy9uZXQvaXB2NC9pcF9sb2NhbF9yZXNlcnZlZF9wb3J0cyIsIC4uLikNCj4+ICAgd3Jp
dGUoZmQsICIxMTExMSIsIHNpemVvZigiMjIyMjIiKSkNCj4+ICAgYGBgDQo+PiAgIG9yIGBlY2hv
IC1uICIxMTExMSIgPiAvcHJvYy9zeXMvbmV0L2lwdjQvaXBfbG9jYWxfcmVzZXJ2ZWRfcG9ydHNg
DQo+PiAgIG9yIGBzeXNjdGwgLXcJbmV0LmlwdjQuaXBfbG9jYWxfcmVzZXJ2ZWRfcG9ydHM9MTEx
MTENCj4+ICAgcHJvY19zeXNfY2FsbF9oYW5kbGVyIHJlY2VpdmVzIGNvdW50IGVxdWFsIHRvIGA1
YC4gVG8gbWFrZSBpdCBjb25zaXN0ZW50DQo+PiAgIHdpdGggYnBmX3N5c2N0bF9zZXRfbmV3X3Zh
bHVlLCB0aGlzIGNoYW5nZSBhbHNvIGFkanVzdCBgbmV3X2xlbmAgd2l0aA0KPj4gICBgLTFgLCBp
ZiBgXDBgIHBhc3NlZCBhcyBsYXN0IGNoYXJhY3Rlci4gQWx0ZXJuYXRpdmVseSwgdXNpbmcNCj4+
ICAgYHNpemVvZigiMTExMTEiKSAtIDFgIGluIEJQRiBoYW5kbGVyIHNob3VsZCB3b3JrLCBidXQg
aXQgbWlnaHQgbm90IGJlDQo+PiAgIG9idmlvdXMgYW5kIHNwYXJrIGNvbmZ1c2lvbi4gTm90ZTog
aWYgaW5jb3JyZWN0IGNvdW50IGlzIHVzZWQsIHN5c2N0bA0KPj4gICByZXR1cm5zIEVJTlZBTCB0
byB0aGUgdXNlci4NCj4+IFNpZ25lZC1vZmYtYnk6IFJhbWFuIFNodWtoYXUgPHJhbWFzaGFAZmIu
Y29tPg0KPj4gLS0tDQo+PiAga2VybmVsL2JwZi9jZ3JvdXAuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDcgKystDQo+PiAgLi4uL2JwZi9wcm9ncy90ZXN0X3N5c2N0bF9vdmVyd3JpdGUu
YyAgICAgICAgIHwgNDcgKysrKysrKysrKysrKysrKysrKw0KPj4gIHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi90ZXN0X3N5c2N0bC5jICAgICB8IDM1ICsrKysrKysrKysrKystDQo+PiAgMyBm
aWxlcyBjaGFuZ2VkLCA4NSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF9zeXNj
dGxfb3ZlcndyaXRlLmMNCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL2Nncm91cC5jIGIva2Vy
bmVsL2JwZi9jZ3JvdXAuYw0KPj4gaW5kZXggOGJhNzMwNDJhMjM5Li4yMzczNmFlZDFiNTMgMTAw
NjQ0DQo+PiAtLS0gYS9rZXJuZWwvYnBmL2Nncm91cC5jDQo+PiArKysgYi9rZXJuZWwvYnBmL2Nn
cm91cC5jDQo+PiBAQCAtMTczOSwxMCArMTczOSwxMyBAQCBpbnQgX19jZ3JvdXBfYnBmX3J1bl9m
aWx0ZXJfc3lzY3RsKHN0cnVjdCBjdGxfdGFibGVfaGVhZGVyICpoZWFkLA0KPj4gICAgCWtmcmVl
KGN0eC5jdXJfdmFsKTsNCj4+ICAtCWlmIChyZXQgPT0gMSAmJiBjdHgubmV3X3VwZGF0ZWQpIHsN
Cj4+ICsJaWYgKHJldCA9PSAwICYmIGN0eC5uZXdfdXBkYXRlZCkgew0KPj4gIAkJa2ZyZWUoKmJ1
Zik7DQo+PiAgCQkqYnVmID0gY3R4Lm5ld192YWw7DQo+PiAtCQkqcGNvdW50ID0gY3R4Lm5ld19s
ZW47DQo+PiArCQlpZiAoISgqYnVmKVtjdHgubmV3X2xlbl0pDQo+PiArCQkJKnBjb3VudCA9IGN0
eC5uZXdfbGVuIC0gMTsNCj4gDQo+IEZyb20gbG9va2luZyBhdCBob3cgbmV3X3VwZGF0ZWQgaXMg
c2V0LCBteSB1bmRlcnN0YW5kaW5nIGlzIG5ld19sZW4gY2Fubm90IGJlIDAgaGVyZS4ganVzdCB3
YW50IHRvIGRvdWJsZSBjaGVjay4NCj4gDQo+IA0KPj4gKwkJZWxzZQ0KPj4gKwkJCSpwY291bnQg
PSBjdHgubmV3X2xlbjsNCj4+ICAJfSBlbHNlIHsNCj4+ICAJCWtmcmVlKGN0eC5uZXdfdmFsKTsN
Cj4+ICAJfQ0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9n
cy90ZXN0X3N5c2N0bF9vdmVyd3JpdGUuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9w
cm9ncy90ZXN0X3N5c2N0bF9vdmVyd3JpdGUuYw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+
IGluZGV4IDAwMDAwMDAwMDAwMC4uZTQ0YjQyOWZjZmMxDQo+PiAtLS0gL2Rldi9udWxsDQo+PiAr
KysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF9zeXNjdGxfb3Zlcndy
aXRlLmMNCj4+IEBAIC0wLDAgKzEsNDcgQEANCj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMA0KPj4gKy8vIENvcHlyaWdodCAoYykgMjAxOSBGYWNlYm9vaw0KPj4gKw0KPj4g
KyNpbmNsdWRlIDxzdHJpbmcuaD4NCj4+ICsNCj4+ICsjaW5jbHVkZSA8bGludXgvYnBmLmg+DQo+
PiArDQo+PiArI2luY2x1ZGUgPGJwZi9icGZfaGVscGVycy5oPg0KPj4gKw0KPj4gKyNpbmNsdWRl
ICJicGZfY29tcGlsZXIuaCINCj4+ICsNCj4+ICtzdGF0aWMgY29uc3QgY2hhciBzeXNjdGxfdmFs
dWVbXSA9ICIzMTMzNyI7DQo+PiArc3RhdGljIGNvbnN0IGNoYXIgc3lzY3RsX25hbWVbXSA9ICJu
ZXQvaXB2NC9pcF9sb2NhbF9yZXNlcnZlZF9wb3J0cyI7DQo+PiArc3RhdGljIF9fYWx3YXlzX2lu
bGluZSBpbnQgaXNfZXhwZWN0ZWRfbmFtZShzdHJ1Y3QgYnBmX3N5c2N0bCAqY3R4KQ0KPj4gK3sN
Cj4+ICsJdW5zaWduZWQgY2hhciBpOw0KPj4gKwljaGFyIG5hbWVbc2l6ZW9mKHN5c2N0bF9uYW1l
KV07DQo+PiArCWludCByZXQ7DQo+PiArDQo+PiArCW1lbXNldChuYW1lLCAwLCBzaXplb2YobmFt
ZSkpOw0KPj4gKwlyZXQgPSBicGZfc3lzY3RsX2dldF9uYW1lKGN0eCwgbmFtZSwgc2l6ZW9mKG5h
bWUpLCAwKTsNCj4+ICsJaWYgKHJldCA8IDAgfHwgcmV0ICE9IHNpemVvZihzeXNjdGxfbmFtZSkg
LSAxKQ0KPj4gKwkJcmV0dXJuIDA7DQo+PiArDQo+PiArCV9fcHJhZ21hX2xvb3BfdW5yb2xsX2Z1
bGwNCj4+ICsJZm9yIChpID0gMDsgaSA8IHNpemVvZihzeXNjdGxfbmFtZSk7ICsraSkNCj4+ICsJ
CWlmIChuYW1lW2ldICE9IHN5c2N0bF9uYW1lW2ldKQ0KPiANCj4gYnBmX3N0cm5jbXAoKSBzaG91
bGQgYmUgdXNlZnVsIGhlcmUuDQo+IA0KPj4gKwkJCXJldHVybiAwOw0KPj4gKw0KPj4gKwlyZXR1
cm4gMTsNCj4+ICt9DQo+PiArDQo+PiArU0VDKCJjZ3JvdXAvc3lzY3RsIikNCj4+ICtpbnQgdGVz
dF92YWx1ZV9vdmVyd3JpdGUoc3RydWN0IGJwZl9zeXNjdGwgKmN0eCkNCj4+ICt7DQo+PiArCWlm
ICghY3R4LT53cml0ZSkNCj4+ICsJCXJldHVybiAxOw0KPj4gKw0KPj4gKwlpZiAoIWlzX2V4cGVj
dGVkX25hbWUoY3R4KSkNCj4+ICsJCXJldHVybiAwOw0KPj4gKw0KPj4gKwlpZiAoYnBmX3N5c2N0
bF9zZXRfbmV3X3ZhbHVlKGN0eCwgc3lzY3RsX3ZhbHVlLCBzaXplb2Yoc3lzY3RsX3ZhbHVlKSkg
PT0gMCkNCj4+ICsJCXJldHVybiAxOw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiAr
Y2hhciBfbGljZW5zZVtdIFNFQygibGljZW5zZSIpID0gIkdQTCI7DQo+PiBkaWZmIC0tZ2l0IGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3Rfc3lzY3RsLmMgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYvdGVzdF9zeXNjdGwuYw0KPj4gaW5kZXggYmNkYmQyN2YyMmYwLi5kZmE0
Nzk4NjFkM2EgMTAwNjQ0DQo+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVz
dF9zeXNjdGwuYw0KPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3Rfc3lz
Y3RsLmMNCj4+IEBAIC0zNSw2ICszNSw3IEBAIHN0cnVjdCBzeXNjdGxfdGVzdCB7DQo+PiAgCWlu
dCBzZWVrOw0KPj4gIAljb25zdCBjaGFyICpuZXd2YWw7DQo+PiAgCWNvbnN0IGNoYXIgKm9sZHZh
bDsNCj4+ICsJY29uc3QgY2hhciAqdXBkdmFsOw0KPj4gIAllbnVtIHsNCj4+ICAJCUxPQURfUkVK
RUNULA0KPj4gIAkJQVRUQUNIX1JFSkVDVCwNCj4+IEBAIC0xMzk1LDYgKzEzOTYsMTYgQEAgc3Rh
dGljIHN0cnVjdCBzeXNjdGxfdGVzdCB0ZXN0c1tdID0gew0KPj4gIAkJLm9wZW5fZmxhZ3MgPSBP
X1JET05MWSwNCj4+ICAJCS5yZXN1bHQgPSBTVUNDRVNTLA0KPj4gIAl9LA0KPj4gKwl7DQo+PiAr
CQkiQyBwcm9nOiBvdmVycmlkZSB3cml0ZSB0byBpcF9sb2NhbF9yZXNlcnZlZF9wb3J0cyIsDQo+
PiArCQkucHJvZ19maWxlID0gIi4vdGVzdF9zeXNjdGxfb3ZlcndyaXRlLmJwZi5vIiwNCj4gDQo+
IHRlc3Rfc3lzY3RsLmMgaXMgbm90IHJ1biBpbiBicGYgQ0kuIEl0IGlzIG5vdCB2ZXJ5IHVzZWZ1
bCB0byBleHRlbmQgdGhpcyB0ZXN0IGZ1cnRoZXIuIExldHMgdGFrZSB0aGlzIGNoYW5jZSB0byBj
cmVhdGUgYSBuZXcgcHJvZ3MvY2dycF9zeXNjdGwuYyB0ZXN0IHRoYXQgd2lsbCBiZSBleGVyY2lz
ZWQgYnkgLi90ZXN0X3Byb2dzIGluIGJwZiBDSS4gVGhlbiBpdCBjYW4gdXNlIHRoZSBuZXdlciBz
a2VsIG9wZW5fYW5kX2xvYWQgYWxzby4NCj4gDQo+IE5vdCBhc2tpbmcgdG8gdG8gbWlncmF0ZSB0
aGUgZXhpc3RpbmcgdGVzdHMgaW4gdGVzdF9zeXNjdGwuYyB0byB0aGUgbmV3IHByb2dzL2NncnBf
c3lzY3RsLmMgaW4gdGhpcyBwYXRjaCBzZXQuIFRoZSBuZXcgY2dycF9zeXNjdGwuYyBjYW4gb25s
eSBoYXZlIHRoZSB0ZXN0cyB0aGF0IGV4ZXJjaXNlIHRoZSBjaGFuZ2VzIGluIHRoaXMgcGF0Y2gg
c2V0LiBIb3dldmVyLCBpdCB3aWxsIGJlIHVzZWZ1bCBpZiBwcm9ncy9jZ3JwX3N5c2N0bC5jIGNh
biBiZSBib290c3RyYXBwZWQgaW4gYSB3YXkgdGhhdCB0aGUgZnV0dXJlIHRlc3Rfc3lzY3RsLmMg
bWlncmF0aW9uIHdpbGwgYmUgZWFzaWVyLiBJIGFsc28gd291bGRuJ3Qgd29ycnkgdG9vIG11Y2gg
b24gdGhlIGV4aXN0aW5nIHJhdyBpbnNucyB0ZXN0cyBpbiB0ZXN0X3N5c2N0bC5jIGZvciBub3cu
IFRoZXkgd2lsbCBuZWVkIHRvIGJlIG1vdmVkIHRvIGVpdGhlciBDIG9yIGJwZiBhc20gaW4gdGhl
IGZ1dHVyZS4NCj4gDQo+IHB3LWJvdDogY3INCj4gDQo+PiArCQkuYXR0YWNoX3R5cGUgPSBCUEZf
Q0dST1VQX1NZU0NUTCwNCj4+ICsJCS5zeXNjdGwgPSAibmV0L2lwdjQvaXBfbG9jYWxfcmVzZXJ2
ZWRfcG9ydHMiLA0KPj4gKwkJLm9wZW5fZmxhZ3MgPSBPX1JEV1IsDQo+PiArCQkubmV3dmFsID0g
IjExMTExIiwNCj4+ICsJCS51cGR2YWwgPSAiMzEzMzciLA0KPj4gKwkJLnJlc3VsdCA9IFNVQ0NF
U1MsDQo+PiArCX0sDQo+PiAgfTsNCj4+ICAgIHN0YXRpYyBzaXplX3QgcHJvYmVfcHJvZ19sZW5n
dGgoY29uc3Qgc3RydWN0IGJwZl9pbnNuICpmcCkNCj4+IEBAIC0xNTIwLDEzICsxNTMxLDMzIEBA
IHN0YXRpYyBpbnQgYWNjZXNzX3N5c2N0bChjb25zdCBjaGFyICpzeXNjdGxfcGF0aCwNCj4+ICAJ
CQlsb2dfZXJyKCJSZWFkIHZhbHVlICVzICE9ICVzIiwgYnVmLCB0ZXN0LT5vbGR2YWwpOw0KPj4g
IAkJCWdvdG8gZXJyOw0KPj4gIAkJfQ0KPj4gLQl9IGVsc2UgaWYgKHRlc3QtPm9wZW5fZmxhZ3Mg
PT0gT19XUk9OTFkpIHsNCj4+ICsJfSBlbHNlIGlmICh0ZXN0LT5vcGVuX2ZsYWdzID09IE9fV1JP
TkxZIHx8IHRlc3QtPm9wZW5fZmxhZ3MgPT0gT19SRFdSKSB7DQo+PiAgCQlpZiAoIXRlc3QtPm5l
d3ZhbCkgew0KPj4gIAkJCWxvZ19lcnIoIk5ldyB2YWx1ZSBmb3Igc3lzY3RsIGlzIG5vdCBzZXQi
KTsNCj4+ICAJCQlnb3RvIGVycjsNCj4+ICAJCX0NCj4+IC0JCWlmICh3cml0ZShmZCwgdGVzdC0+
bmV3dmFsLCBzdHJsZW4odGVzdC0+bmV3dmFsKSkgPT0gLTEpDQo+PiArCQlpZiAod3JpdGUoZmQs
IHRlc3QtPm5ld3ZhbCwgc3RybGVuKHRlc3QtPm5ld3ZhbCkpID09IC0xKSB7DQo+PiArCQkJbG9n
X2VycigiVW5hYmxlIHRvIHdyaXRlIHN5c2N0bCB2YWx1ZSIpOw0KPj4gIAkJCWdvdG8gZXJyOw0K
Pj4gKwkJfQ0KPj4gKwkJaWYgKHRlc3QtPm9wZW5fZmxhZ3MgPT0gT19SRFdSKSB7DQo+PiArCQkJ
Y2hhciBidWZbMTI4XTsNCj4+ICsNCj4+ICsJCQlpZiAoIXRlc3QtPnVwZHZhbCkgew0KPj4gKwkJ
CQlsb2dfZXJyKCJFeHBlY3RlZCB2YWx1ZSBmb3Igc3lzY3RsIGlzIG5vdCBzZXQiKTsNCj4+ICsJ
CQkJZ290byBlcnI7DQo+PiArCQkJfQ0KPj4gKw0KPj4gKwkJCWxzZWVrKGZkLCAwLCBTRUVLX1NF
VCk7DQo+PiArCQkJaWYgKHJlYWQoZmQsIGJ1Ziwgc2l6ZW9mKGJ1ZikpID09IC0xKSB7DQo+PiAr
CQkJCWxvZ19lcnIoIlVuYWJsZSB0byByZWFkIHVwZGF0ZWQgdmFsdWUiKTsNCj4+ICsJCQkJZ290
byBlcnI7DQo+PiArCQkJfQ0KPj4gKwkJCWlmIChzdHJuY21wKGJ1ZiwgdGVzdC0+dXBkdmFsLCBz
dHJsZW4odGVzdC0+dXBkdmFsKSkpIHsNCj4+ICsJCQkJbG9nX2VycigiT3ZlcndyaXR0ZW4gdmFs
dWUgJXMgIT0gJXMiLCBidWYsIHRlc3QtPnVwZHZhbCk7DQo+PiArCQkJCWdvdG8gZXJyOw0KPj4g
KwkJCX0NCj4+ICsJCX0NCj4+ICAJfSBlbHNlIHsNCj4+ICAJCWxvZ19lcnIoIlVuZXhwZWN0ZWQg
c3lzY3RsIGFjY2VzczogbmVpdGhlciByZWFkIG5vciB3cml0ZSIpOw0KPj4gIAkJZ290byBlcnI7
DQo+IA0KDQo=

