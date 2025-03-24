Return-Path: <bpf+bounces-54600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38069A6D5FA
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 09:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECCF18939D6
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 08:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97655214230;
	Mon, 24 Mar 2025 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KkbuRsKX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zcs2NZOC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6F1459F6;
	Mon, 24 Mar 2025 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804248; cv=fail; b=GiRrynZQUj7LctpIZSsgYTrXFbxQoTZxhBUpE6CSqAru/0WAxXfcQ+knZw6AQbdAS3FSiStgxTG19CF0RCEiKPthB8sQ2neds8Jp9jwAjiFU3eJpOvHnmviQ83fHJ/zxxPFe+c84++z+H7sIukxKl/H5qurhBC1HlojmtLJ9rAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804248; c=relaxed/simple;
	bh=0K24j9d7nBVO3/C2OgYerZ9wlsLKxsmKEyNyBv8BHqo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pHLin32qdF9Bs6Lf1fijRNFcAHI3ZHs9/CmSdLysRROGtIFZExFFSFHzy3IPE7TtS1OpK8GRcywtJgymbp7n5khVOBRso5EM06lyD1xd2gMR/TWxrK9QIzlu+N2KYex9+WBZuag8AtgeDiZcKcwMgkaTa3KbXZpBdXBwIK58QSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KkbuRsKX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zcs2NZOC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O7u1A0031052;
	Mon, 24 Mar 2025 08:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hgHxI5hTQr8rDSkFDeFAcT0DYZO8wIcs9JRQqApUoXw=; b=
	KkbuRsKXdKDT94kqyGDLc7WnwwWVGJUtQKyEtObJKOGaz059/Vc+Uf8HI8Wl0YUz
	Lgkr735JJAEqaxm3Yfke3ZYQiSt9IsdBzaGpWTURUUcqN4bo6ux8YgcBlWfo9Two
	tH2lmB/RieLjqLX//xwHvsctr0HJIpIWxT/AKCfxhJPKh6AOBpcT4exbyi37qcH8
	v8QkEobeuYvGQ9eM2+x/h5W58RmQuJTkh9xapydT/8+SVJsitwFJ6gpO9aQWfldY
	OqoMnI725I1e0EaYDhOQUr4x0hp0Et77MAFoS1wXQawPwnYHm+AxHsz4tgfUN1Lf
	sntgqVNFTVXpPdfvtfcqRw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn8b3fm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 08:16:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52O8Cs0E029886;
	Mon, 24 Mar 2025 08:16:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jjbxy35q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 08:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eObkZInAdCdWJ9SxcqLNDyE8Pc56JoiwcZGv4j9pdAkYwkVBXEmETm6Kz8mgTutrZJIxlzhEUlqoCMBmAEGD8+W3w6UqT3dt4CumrHB6yHR1XU9Wit1oA3tr1LAWglTRuIH9tyRL3q5WIwupVZ1qtCcrjReZiinYDkLQ39oAbfBzSnpXuEGwgIbl4Hacs1gJmx6jVe+9+b0St8BdOF6owSi9ILMos5CVVeK/vigvXeIKxHqWw4rS66Kw5zNuaCER6DL4YXfxLD3R2Xig/TFx2c0o6Q4W75xBmzNWjmBbhc4bGv+dSfKMGSOQOrCCj6jdDXrwzh0k1PSAYS/IopDG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgHxI5hTQr8rDSkFDeFAcT0DYZO8wIcs9JRQqApUoXw=;
 b=Xzxkcq3yt67FRkERby4boyQNqiiDQI6PD2r7KKYKBNs24iAcsqX3sZcsaWwNhSd26MZdp0zcoQXyn63xdizb5/Yc/wVZHaSXfpXv/3JCBZAOO9k4RiDD18+Twu4oVGOCH5uQYCXFjK/t0EQVEyPFvsUeWKIVm8F4s6AZnFDYN8VhAaLSvcJYvWvcCqz5OC3tl2F26UmJHNS54BM2wB/YuGNcdUUJ4Lz2PJ+qE6cpcJfcxXrISWG1UblOEGPnH9T1gMK8LIxDM5VB/WkUyKT+nX5T00aaTHRGnNbuGPfe0H/CDu6PdFDc+GTdOgYw5MdTlcQMlDXx7qj99giMMZ95hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgHxI5hTQr8rDSkFDeFAcT0DYZO8wIcs9JRQqApUoXw=;
 b=Zcs2NZOChm13utsuQlee18L0RtWMOqwlsSL3N0CQ3ckucnNRd2HwLWMkEJXwUCb3sX3EjEpLXDuk/Sgy5oKRDi2o46GDj+7OI3BHV+OYYJnFH/egUaYTWEBHh8RkEUAamN2ZHUWQy0Hj5uIscgqdrx4jYvARQEZwM/ha5vxx1lg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN0PR10MB4888.namprd10.prod.outlook.com (2603:10b6:408:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:16:17 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:16:17 +0000
Message-ID: <755ff740-43e2-4411-af95-88480c42aa64@oracle.com>
Date: Mon, 24 Mar 2025 08:16:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] btf_encoder: Filter out __gendwarfksyms_ptr_
To: Sami Tolvanen <samitolvanen@google.com>, dwarves@vger.kernel.org
Cc: acme@kernel.org, yonghong.song@linux.dev, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        song@kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        stephen.s.brennan@oracle.com, laura.nao@collabora.com,
        ubizjak@gmail.com, xiyou.wangcong@gmail.com
References: <20250317222424.3837495-1-samitolvanen@google.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250317222424.3837495-1-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0509.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BN0PR10MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: 9810e6e9-1dcc-4c96-a564-08dd6aac267d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3d2T3lsUU0zd1Y0L2JtRTdaNXlDZ0FTZDF4ai8xVWZoWG9hTklnYmhsd0hn?=
 =?utf-8?B?QnIrbzdzejlwcjBwM0Z0eVpvY043OElMMnFNSmJrczd0RWN2SlpRN2dNbmho?=
 =?utf-8?B?Ung0OVdHSm9PN1VTalBHeS95OTNXb1RjQlNpQ2hLMHMrRmdVZTVtTDFVYUJi?=
 =?utf-8?B?MEM2T3pvbi9JTlRxQWRidTRNTERwRzVBUXVOTk1aelQvVmM0MEdvUk5WSGtE?=
 =?utf-8?B?eEloYVJqdXRoWkg4THcvV3hFUG5hVEtSeHV6NlhFZzlZZmU5UXJEcXhFSEpn?=
 =?utf-8?B?QTljdlhGYk4vY3RMaUFLVnpURGJnUWgwN05SRDUyT2paOFN3YThxL3pJTTJW?=
 =?utf-8?B?TEw2bElSNGpsbnFsMERwQ0poV2FMWjZScXA0RW94bTlnN0xtUVRpcUd5cFdk?=
 =?utf-8?B?Z0Jra3p5Z3I1RmZQS1FWTWh5ME1qdGltUy80aGxxZ1V4d0pxMlkwekY1cWVN?=
 =?utf-8?B?Smh0MWthUGFDYkZxVTFMa1FhNkRkMFZyd3FMM3NDYlFBT0NmV2JSWW52MXA2?=
 =?utf-8?B?em9UbFBQcjZ2NUV2eXhuelJHSCszc043bFZ4MGwxTzhlSGw4WGMvcW5KS0Fr?=
 =?utf-8?B?TlBSajJJY082dko4NkVJZTNtQ2dkcnNWVzNyS1U5M2hRV0hJYUM2WGpaVVhV?=
 =?utf-8?B?M01zZ2dTZVZTVkF3SE5jQVpDRjk1SUZBRlRRUmJRV0JPMy85aDFWQWI0WStS?=
 =?utf-8?B?S1IzQWRQY1VmaWc1bjF6bCtoYlNlOGJlTmdBK3QxWjdXL1VacTNwNlZLLzFn?=
 =?utf-8?B?bGxsQ2VaOUdJOWhJaWUyMUZFRzd5MTl3cTU0YXhVQ0tRd2Nqc2l0ZHB3Q2k1?=
 =?utf-8?B?b29YQTZVQVA2aTdGWEdrbE5GOTJtRWhOSWt2MGpiRGoxekNrdWp2eTRwaFNt?=
 =?utf-8?B?WFR3VnE0OEdrV0Y4Rmc2S1k5YVR6UHY2TWpYSVNxUVRpNG5IcHNWbnBUeC96?=
 =?utf-8?B?Y1JmUCtEaTJ2ckFXNzZvRlZTSnVHdERHUVVOMFJEYzUrdnU2eFR1dUZQbDF3?=
 =?utf-8?B?UWJxSGtCYnB5bGd2d1JnS3U0MXU3c1VRRHRQUitWdnVDSjQwVFlScE5mYWp6?=
 =?utf-8?B?dnlGMFZiUEkwYjg5N1FYOEowd3pDeEhqcmROaWZWbkZOSUZNRmZ0enJCTURV?=
 =?utf-8?B?N2VmdGc3cmZxTDRmTkNrYTNPMjRRL1hmSWhxNEJoYjhEQXIyc1pWcHAwZWdo?=
 =?utf-8?B?Z2V6ZDJrUWdyL0ptUW11YVA1STZIQy9ETjBmYXVWNzl3OW93Yyt3YWpJSk9Z?=
 =?utf-8?B?T2I4YWs3ZW96TFNjRlF6eFdzaXJFWXptdjhXMjQzSHNkOU42MGRUMVlHTVZE?=
 =?utf-8?B?UWxLTy81UEJiZFFzbnlYNTNDWW8zVDc5b3BwdyswbGNqcWRkV3NueGV2TDJJ?=
 =?utf-8?B?S2lQU1hyMkhXQjZrYTlhMVFLVXY0MUFxNUYrRnZjMVJmRlUvSjVnbjVUcFVO?=
 =?utf-8?B?RzV3Zis5NDczbDdHOGNpSHIxNlBEYk9ZUnZHY25XMHpGN3VNZ3lRZU1pWUdB?=
 =?utf-8?B?RjRXM000SXdjQXlVL2toeWVNVGU0T0Q1ckVBNy90ZlVlVjBUdUpTSmxLY2dr?=
 =?utf-8?B?cmlGVEdIV0lyUUNFdjJVYVc3WTRzdGo1SGtsNENVWUR4enY1QkZ5eTFkc0lD?=
 =?utf-8?B?TzlKbWFuTTh5TWJ1b0V3RGVlMzNzMUoyZnROcUtmQU1LWDIzNWVhZXJVeGVL?=
 =?utf-8?B?VkRia1ZXVzAvTlBidmVkSEovUG5FY2JTUUl4K0JzSENVTGtlNW1waENVSGty?=
 =?utf-8?B?Ulh1SG9ZRTdvNjdZYkI0N1RvMnJPR2tEVldHVVlLbDY3TVU5dGE5YjdBRTFq?=
 =?utf-8?B?a3hWSUVSRUZoRGtQM2d6TzYyVVc1cGFxcEJia2VHOWRjYVMzNDRxUHM0SzBR?=
 =?utf-8?Q?XvNhqfJlSoIyL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnVSc2VnQzJ6U05EdWZpYnZMQy94ci9Oa1pZS0lyc1dabkEzY09RVWRWVDRK?=
 =?utf-8?B?ZVYzTElydmJKaG9lcUxzdE1TSUE0ckFkZzZEK2pacTlOeTFtbjQ3SGVOSWJn?=
 =?utf-8?B?NVY5bzFDcTRuVW1WeGd5T2IxcTE4aS8yWTdzbHBFN1NVZEJJMVk4YTNQYUwy?=
 =?utf-8?B?N3ZYRHlETmlZa1BYUHdpQlMwbDdlK2xYZXJyREp2TWJVU2NtMmdIVDB4VEw0?=
 =?utf-8?B?VVprUjl4Q25EY1lRb1Rady91TURxb0FySFovd0RJNFMxYXROY3laM3lsTGwz?=
 =?utf-8?B?dSt1OTlnQWljRnhTelhzMXBZUFlsc1dBS09vSlltMk9ia1Z4ZzdqQ0h2SndE?=
 =?utf-8?B?UEVUUk1rdzc5MWJEamFsWUU4M2dReE9CVklySmNQblpNRzJYbXFhZVN0YjN1?=
 =?utf-8?B?Qml2QWJkMGVJaGZqNGppcllFQy80Q0lOblhXYTBKc0l5aXhScDVJNDV5ckUv?=
 =?utf-8?B?L0lJbDJ5QVhJaE0xbzhSWThzOTdUSk1nN3hmZGNNeGlRNnROLzFVSlIxNllI?=
 =?utf-8?B?ZW0vYVh6Z1hqTmNvWWpXd0NBeDZkN1BiNG5TY3NxMW5UMGJFWWNpeFdZVFhL?=
 =?utf-8?B?OUZYQldWY0V0eFlPQ0V2aHRZRzVrdXIvMUE1TzBPaGQycTdMcHl0Y3RWM1dZ?=
 =?utf-8?B?Z2FuZmZVL28xV2t1WVl3cUFKcGYvemNtU0FHSjNsckE4OXVGQzVHSU05WS9Y?=
 =?utf-8?B?Q2pvT2pLOHEzVDFNZXRQenJ4dlB4OUd0UW9uazRMTmFNa1FWa29sS0ZoaFpu?=
 =?utf-8?B?VC9mTC9lOHp0ZFdvN3EyWkY2TE55d1VDVHhRUnEwcm81S3VOdnBveWFuWGIw?=
 =?utf-8?B?TEVnT0N5dHVHZ3lLV1FoRWN6allXT3dzNlBpSmdadFNJcFpVb1FzVi83WkhU?=
 =?utf-8?B?WVZOb0owRjRDemErU3ZiR0NpS2tzZmdXdGxCYlBmbGh3NTZPdHZQZ3g4enJZ?=
 =?utf-8?B?N3I2K2FDdlkzVEhERkRReWN2K1F0MDZqN1M0Zi9CcmZVcDEvK2ZqT1Y0b1Nk?=
 =?utf-8?B?dXRXVnBtN2xlUWRJWkFoNWQxZWFOTEMwbWRFWFFBUlZCS1lDUzBZWCtuNElI?=
 =?utf-8?B?Nk9xYkMxUmFQQ0pXcHgybFhSZk02czFIbEN2S0w4aUMrWGJUblBJMXZNdjQv?=
 =?utf-8?B?ZWlDc2pLbXpEUkFYSVRndkJiUDAyQWtjVXVxblF4Y2x6MEZnbXMwbUZZT3h2?=
 =?utf-8?B?VGpSS2tncU52MldNSGkvQnp1a2tmNGt0SERuaVVESEtGNEljTXk3RFBuMkhD?=
 =?utf-8?B?Y3g1RC9Td21kcGswcGFKR2FDbkQrZVIxZVF0cEk3Z0pnRlFaWG5GbHVYd0E0?=
 =?utf-8?B?MEVCTE5UejV5UUJtcGhkZ1R2ODd6N2NtMllaZ0RCdzJaWUJDQStlQ2ZBNEN0?=
 =?utf-8?B?QjFyR1FYSXFyakhOSFJkZ0lKeFpHQkhRSTVOdllKRTNHZjhqQUxBeXBEQ2Y3?=
 =?utf-8?B?S21JbHM1VDc3QjRGbnhqYXRJUytzSzlzejQ5cUdWTW9QR1ZmU1d5YnB6bWVV?=
 =?utf-8?B?RkRINHhUczlaOG10ekhycjd6NTloekFnWlgySnpyT1RCU0xTRzlNc2YrZXBQ?=
 =?utf-8?B?VmZoek1hTnAwR0dpNFIvVlJJZFAzcDhZTjcwdjlaY3lWSDVvbnZmYTUzK3Uy?=
 =?utf-8?B?NkxjVmdZSmp5aEVseCsvenB0Q3RpNUd2SlVqN2kwZTNCZURyVTZOTHNJTFY2?=
 =?utf-8?B?WENpNGNucVJiMjJXS0MxYzluUThudXpzbldoTnBtdlhWZUYxUVNqZ2RxQjQ0?=
 =?utf-8?B?YW5mSTl0elV0VVZXQzJDT29DQ0lsTGZrWThPYXJ5UFdZVFdHZnljM1E5Wk5F?=
 =?utf-8?B?b3FLRHVHS3BDSVdYTGZjTmlkRjZwVjZ5dTB0Ui9GRWF6TzR3VGYvTXFqdFZY?=
 =?utf-8?B?N2tiMnkzRXpCSE9DRUdoSzFQYjk1QzBWR1hnc2VvWXFFOFB2QXA0K0dxNjlw?=
 =?utf-8?B?S3hyUkZCQWc1dm1xVFhCSWR3YlhERll3OUVGc2FlOG43clowTDdjMmxCcVFX?=
 =?utf-8?B?bUp6WmtHR1ZpeFFydTQ4WjZpZytRdU5rVHlZSGp4dzZqVnV2QXY0L0YvQjln?=
 =?utf-8?B?OXRLcjMxTzdYOTFQY09leXdJL3RyMUdZYzBRbmNxQ1lLNkVWcy9pYXJiU1kw?=
 =?utf-8?B?UnFhc3pSTnRkekZSTVAyTzdiZ3IyWmZmQ3c4MkN5MkxEWWZUbTltM0p4VXdF?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D+oXDBhpd3t58rsD46xlmRbQw4+GK8OF08yqGyAaPAp6gftKuKqVM9Cv8dTljdd98qQrQdf5pEi/vBCvBNUBYJStOPiOpk3VGhlLuFzlXY0MI9Mg9NrAs0cTY/Wgv6pw9LgvhXxMta2FnvgPHchiPMFGV10M9bKAeoXngAl25Sd5cIE9G+jMPW8mhbGJD94q8gaaMhUB4vgPYavVHwHppTgN7KNx2MpJ5B8eWYEUpKHSG9ltab9nLy9O4D+0664mX99Lz23AKpUGttN2BP+yJSG4Y8STJo+cema71i68CYgDZAQTB+KKQUW9gFuArRudWcUYcP/V8Jb5pJHpuUaDXwwU4YbGe9zGCjEZgFpl+YsosE2b2cjYyq26J8DbvHKIo8K+XWzw5Penf2qvy7KIGr82PhKORGr/Wudvlrkht6a0CMxL+LrXPW0C/YCRP4lPJdbgBvlKnYzLOfUL0Y38wg08MO9A+JIyeLH23xIJw2uLwECB6d+RixtT/ER/flDcTLigLiQo7dEA1YjeC9vpTCXnlS0wmXFw8nZgLT5oWnBv64JEhYOOAuNeuo/TxTI2rwzJtxWSVvLsxOtpVvhv8eE4L7IDeASELC17Uy1tLAg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9810e6e9-1dcc-4c96-a564-08dd6aac267d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:16:17.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJ2jTMz0PzkKYrKZwQPU3/NPlYmxcA85ed+75MP5EZlXL0ip4R9ChvfwJVJbbVaYYmkfq29KxfRlOF4LLSHyGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503240059
X-Proofpoint-GUID: uABoZZdClAg5CfWotIxUR3Phkd-BIyvs
X-Proofpoint-ORIG-GUID: uABoZZdClAg5CfWotIxUR3Phkd-BIyvs

On 17/03/2025 22:24, Sami Tolvanen wrote:
> With CONFIG_GENDWARFKSYMS, __gendwarfksyms_ptr_<symbol>
> variables are added to the kernel in EXPORT_SYMBOL() to ensure
> DWARF type information is available for exported symbols in the
> TUs where they're actually exported. These symbols are dropped
> when linking vmlinux, but dangling references to them remain
> in DWARF, which results in thousands of 0 address variables
> that pahole needs to validate (since commit 9810758003ce
> ("btf_encoder: Verify 0 address DWARF variables are in ELF
> section")).
> 
> Filter out symbols with the __gendwarfksyms_ptr_ name prefix in
> filter_variable_name() instead of calling variable_in_sec()
> for all of them. This reduces the time it takes to process
> .tmp_vmlinux1 by ~77% on my test system:
> 
> Before: 35.775 +- 0.121  seconds time elapsed  ( +-  0.34% )
>  After: 8.3516 +- 0.0407 seconds time elapsed  ( +-  0.49% )
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>


applied to the next branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

thanks!

> ---
>  btf_encoder.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 1bde310..2bf7c59 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2239,6 +2239,7 @@ static bool filter_variable_name(const char *name)
>  		X("__UNIQUE_ID"),
>  		X("__tpstrtab_"),
>  		X("__exitcall_"),
> +		X("__gendwarfksyms_ptr_"),
>  		X("__func_stack_frame_non_standard_")
>  		#undef X
>  	};
> 
> base-commit: a0be596ae76c720d21eef257dec1cf2462130da1


