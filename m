Return-Path: <bpf+bounces-74543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A66C5EE6D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19D1534832B
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EC72DA762;
	Fri, 14 Nov 2025 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lq1XN7Jz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eUG3zscS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C12C21D3;
	Fri, 14 Nov 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145224; cv=fail; b=iqArsL0uU4IaXD/NXWZxzpjexkpnjPf/5glEmXXGmqRii3RXiLHhqu+LNIaDswcsTv0EaYKx3ANLdzPuebbzZ5HstCi+w9mlqpcp2bg+AupN63fEy1GaAOGZdvM+KtseIMjqzmp7ewbu00esNzKQvdZyNoKCiyIZhoA/T/8SbWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145224; c=relaxed/simple;
	bh=9eqAMnOUvl1nXw3s42CV8J6Bb7ca9E0QHkGtFPHdHOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TnUAR+t8jPTX8G88BxM1NwyV3Ihagw1stsOwfHYpwOPiUjJ2G7LrnzIIVsUxEU1l/DWD6gqEJp92PE5TOirN/w2loXsWDH/TmG+XeKBhznVK/HRWWthcyoe0Nqez3InB9fRDfgDLt9b1I11SOhMaelhvVr0oaZh3VEw/TNGaHCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lq1XN7Jz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eUG3zscS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEGupGj029599;
	Fri, 14 Nov 2025 18:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jHDNvqjY93T+/I3NTfRSwqjzOvnANlJ5UjjUnox8CG0=; b=
	Lq1XN7JzrqesJb8ZhiZFO0NVbT/itt9wY8anPnl349DfasTP7IUtGcE+ivh1/Pva
	0r/KhWXLjQzyrFEa8R1mudyp1jCWT1Y7EHm/SR85ybe58/zvEqJ2v2ehVwxFRIjz
	hJsYewSdhTD08plozZXps4HnFmEu8Jn8NKUw6thPgpk67tuqxFrV4/WvyNFtZTKX
	leUD0vsbIZusgZQEyp69SYId9ZNYslg95ZMmwFgGqwxCbMWe0rC1md/UYHJSipSZ
	BtgnZ4BOJtVFQM4zQ6ay19UrKrUao9bAyZ42IcLwcmcdVmBVKN/vFJ20fJ5+aD5S
	cE8s1Ju6jFq6b5Ob7G1P+Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8v1sas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 18:33:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEGeXXK038612;
	Fri, 14 Nov 2025 18:33:32 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vadutud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 18:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TM84nSEau62TA5F9y+aFgqRS1ehvfhqAsPhEFcq1Qmq5dDAioRSJeYgBu0Dbvm/fT+w1Ukr0zdeWq5LTB9Yh9pxQxUOT6XkrdF7KsZMG1IaRly+i8EnSvaCayofRwAvqyEHfgCQzqtR55MK+IXltw9jTyHwHNi9Lzxr6F8a93EF5zcct45rhR0hDI5eZDhA/8YKgPqusvYWndad5tSiORZ6A+AQTrQLxZmBSdUXQIVnnYEjuCknyIpTm2kPCmn2uIgN7/YJyZzroEc4fDohDb92B1m4VL0zW4vx8ILJtVSQOA/+008OaePU+YKDU8QjeTIx9nVOR63aJDwdeuzWIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHDNvqjY93T+/I3NTfRSwqjzOvnANlJ5UjjUnox8CG0=;
 b=K5wd1Ju3Yv4FOtgjVMc3jm0cMNGe8KXxnVcocbCCBG5YYYqkZ5WBCEFShw62Pqkjsf1CH3v3EKhLneTzoXljbA/pOiBJJMKiF8zzNKyp+Xjl3uTsk3oAig60XWYjtnvFqbvYXVRvHcxPgHlK7MKoldmJYmeD2OuLDw5gRAnBLB89FCs4nz4yFmYane0l89vYzwVVtFF2NvWHJwILODyX+4ddnn+U31FkY3/Sff8aNqJiRfDTqdzPCqInfYmd/bhEdvZK5kyQs0i8Otfx1dzO+skFJLebQlQ46iQUvlJ7aqDrxbQdmYahDvUfnK5aId1WJRSwY1zrYkAZ6Ct18Zc7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHDNvqjY93T+/I3NTfRSwqjzOvnANlJ5UjjUnox8CG0=;
 b=eUG3zscSKeIT2q4hxpmL2SPDKVB0SawtWFZFRTXvEwypsZNiksxx1NVfTlGnLuklqo46feX0iGTFApGXRqfMWwsE+ipCgihQaXhf74nDMDNhGWlJBwNPZhjQJld8WHrDoP7bTSbH080lU2seYZ0JBwVzbfViVkKeIwGGdkFUj04=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by CH3PR10MB7612.namprd10.prod.outlook.com (2603:10b6:610:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 18:33:28 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%2]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 18:33:28 +0000
Message-ID: <f607ed31-3b7f-44a2-8953-d3b817232f1d@oracle.com>
Date: Fri, 14 Nov 2025 18:33:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v1 0/3] btf_encoder: support for BPF magic kernel
 functions
To: Ihor Solodrai <ihor.solodrai@linux.dev>, andrii@kernel.org,
        dwarves@vger.kernel.org, acme@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, eddyz87@gmail.com, tj@kernel.org,
        kernel-team@meta.com
References: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
 <517837f0-127e-42bc-83f4-2c85203ef468@oracle.com>
 <ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|CH3PR10MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7031a2-f4b7-41c3-04e6-08de23ac4da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3R1VEp3WFBrRGQyUW05SGR1c21mZGZWZEVvNEFaQ2t6ZXRkVFFwbE45NldT?=
 =?utf-8?B?Ni9kOXRKaTIrd01zNlNNTWR2UWIvSkpEYzliMFlNeWY5UXBxQ1ZnRzEvSUJY?=
 =?utf-8?B?T3hzYjk4YXp6MUVDY3FPRlkxcEI2K1hobmNmdUtLRjhUREsxY1Q3bytzZElM?=
 =?utf-8?B?bTc1R3F1M2hTUVpBTmphd2NKclEwd2xuWmtVaGVxTGQ3MVNTVFViczhBdHRp?=
 =?utf-8?B?NVZrZDRhV1J6TENSendVczdKblJSYUhwbnBpVkdmaHNCTUpjakU2N0RmWjZG?=
 =?utf-8?B?NTJvOWN1bFMvUVA1dTlEeTlOWE80M0podE4rRzdxc1VSRVdUcTByV3hGUjFN?=
 =?utf-8?B?bmlGNXZ0NlRmSmlMSjlSckJObGpMMjRQSFcxM3N4TGhXQXNMejVCRlRUbUZt?=
 =?utf-8?B?ZkVWbVh6dmg4d1BIcThCb1BKckxIT1hVRVJIQTdJbTRvYldwZWRzYndyRzl4?=
 =?utf-8?B?dmJ5d1hOcHVCdlAvSzlMbjRlVkFtTkk2ZEtiWVdyeFlrdDJTVHRvTVNXVjlP?=
 =?utf-8?B?OWh6WTh3czFIYldwK0Z5RGZFZmk3dmpNYTNOMFdaMDVCVTNLMHFmNVdISXAx?=
 =?utf-8?B?UHl4Y054RDM2SFpMNExOaS9POGVGd1ltSUk0R3E4T25MMnd1NS9Ld0ZvNUJ3?=
 =?utf-8?B?RDNsRFdxV2huWGhLa2Y1bTQrQm9sNjFuSVBDdzVQN3h1UWE1MElCOVNyeko0?=
 =?utf-8?B?RlF4YWNmaE1WN1NqaFVkTnJXdVU0OGZtMytqakRFYXlncDQzTmlod0RFZmhs?=
 =?utf-8?B?UkFsWmxWT09OS0V4OW05Tk1QVlpMR3M0dTRDT3dmYnczNXV4N0JvOWd3OTFN?=
 =?utf-8?B?SmFZOVR3dDNkRGJjeko1ZnBOREFveWg4aHdsa05TMDNhdkFqc1BJbG56Si83?=
 =?utf-8?B?UnN1UGNnazd2TkNITkpnakFpNjE2c2Rxc3FQM1NiNmtvem9VcTRSUEszMlUy?=
 =?utf-8?B?N1RwYS9YdFdVeDNzbkdHdFZZYlAveWRUS3c3NHV5alpPckMrOUZQTEZKYkRh?=
 =?utf-8?B?WEJtZFk0bkFoWU52M3lqZzNhMk41Y0hjb0s0L3ZIQk96dUJET0hlR2hCUVlE?=
 =?utf-8?B?MHJjMEFHVTlxSlZRRm0vS2Z3MGhQMURsOUQ5eC9CWWZ6L1M1dUNaOWw1b0ZM?=
 =?utf-8?B?TGtlQ3hQdnpqVnZ5VzJMcmVEd3ZPQTFqS1ZXUjFuQ1VLWHU4dUpFRysyUXZZ?=
 =?utf-8?B?YzBxZXhXUlJLckN2d2trcTdMN09DTERxVEFWRzI0bEdtc1BWQzFwZG56ZnVU?=
 =?utf-8?B?VzkwaU9kYmJJZDFRenZsVElOelFnQnpaS0lZSC9NZTVoU3hkbkNLMEtSSTVx?=
 =?utf-8?B?TWwwbTJ0b1Q3MlcrOHRjemcxTWl5ZmJKTHJrMzY0dE5PNWQyaHFYRlVvRzdG?=
 =?utf-8?B?TThLRlZ5c3pySWhkSGF5NTJ1amt2TFpXelJsTnlWb0ZxS29rQzVJSHhYRzgx?=
 =?utf-8?B?QW4xcTBKTWRaY21DY3Ezc1J1RmdRcnd5U2lYNXV5Mkpxa3c3UDRPVXl5V0R5?=
 =?utf-8?B?VzVCZW4zN0dMb1ZtYTdtS010T2pLOVRMVmdWVGlLQ3NMQXBNbE4wbjl0ODVj?=
 =?utf-8?B?RWdreXB5L29iR0h0UHV4VWZublYzK3Z0N1ErTlBvMXZ6empEZ0R6R3R4U1I2?=
 =?utf-8?B?RkdiVDlKVkRyUlhzVHhnTG42VzFGa096bUh1R1NkeldoS09jOElsRTdqZkxD?=
 =?utf-8?B?anVhTTlaVDUyYnUxaHNnMWVvb0kxVDRtT1JlQ21lTzhQRXVwU0JzQ2EzVzNk?=
 =?utf-8?B?RlNod2tnNU5oWUpPSUFLVXJqQk55R0pMem1jeHc4T3AvTjNMZm1XcU1qWUJU?=
 =?utf-8?B?cGhHNjU4eXlOMnYxQ2xBSGVDSGVrVDd6TXduTEVmV2FnbEw3WndJY2thQUFt?=
 =?utf-8?B?T2tWWkxoUkdhNDA0RnZSWmIzUEpYN1A3RlB0Y0o3Y2Y4bVNNY0VwQkF2YkJP?=
 =?utf-8?B?b3NTSW81WXJEejFwdnZPV21mWFlKYVNoSDhvUTNGTU5oZVdoclF0enJSMGJa?=
 =?utf-8?B?ZlhRN2VYQVhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXBUVkZHRVBaRTJNNjFjYjZPRThQU25VRzhXbWVVYWt5SzBZMGUxRTFZUXNx?=
 =?utf-8?B?Q3FlVnVuRVJnY2JwV01weVRndkhCVmswNHF3LzZkWjllMHMzTysrWUNMaXQ3?=
 =?utf-8?B?Tm5pZTVSQW5CRUp3V2MwdGIwazdnd0JGS3VrOHhtVTVhck1VYitJTjdzbVNT?=
 =?utf-8?B?WC9YMzEwOERvNEQxdjBCT3lUVjJ0bE9FN09lVjBhdjVzQTNucDZjaXd3N0ts?=
 =?utf-8?B?U1NZREszczl0VW5IWDd2dDRXTG5hRXhQWktUdlhLTlZaTDdDODBOelZLcjdP?=
 =?utf-8?B?RmRaVERaa0ZnTGJybHpIY1N1b00yT0s3cWJVRldHN09XTUxNMFZyWHVCbndi?=
 =?utf-8?B?R3diQnhtTUh2bFBSdzZjQVhXeTZCL3czY1dhU21ZRDFhMlhNMnJxbUltNTE0?=
 =?utf-8?B?RFdZUkQ0alRVZzQyQnRjbnFjRkl2TDBmMDRVdy8rMHlNWW9BYjRacmh6eUNm?=
 =?utf-8?B?MkRFckdOQ1pIeEg0cGFjcHpNY01VR3NxcTdDc3Q2RjhzeWEwQkxidUluVU10?=
 =?utf-8?B?d1cyaVdZL3BKcm1VcVFIVTVWZmJWNVo1VlllWVB5S2tEa1BZWndmb2toeEV3?=
 =?utf-8?B?WlZPQWltOS9Lb0ZnaElwZmZvdjFGcm9wK0dCcHF0TXdlNmRpckViR0RHWkYy?=
 =?utf-8?B?N1ZTTm9sd20wZTQ2N2QyUmxYQmJyNk1lNEx6aDR2YkRFeGQ0eUJyRzB6QW5D?=
 =?utf-8?B?Y0drTXpNRlM4WFA4bE1FbUtadS9QUVQzL08vNkdnT0h2dVhOV2FjWGw0T1NG?=
 =?utf-8?B?K3NGU3R0b21CekpYcEhlK2ZBVUFtU05RSEFSaUFVcGdhUTF1WDVQUGhxUzJ3?=
 =?utf-8?B?K2ltei83WmR3RUZnYzdFYTNHRlE2M3Rwc3V6d0lXdWxFS3ZiUlo1Mml3T0x2?=
 =?utf-8?B?SS9JMEV0TnJncU5IRENyL3RiTC9zU2FxbzRLZnBTSWd5bmxscjNMOVAwUXhm?=
 =?utf-8?B?b1FVb1JWdGdWdjQzd3dTYWxnYTNnb21maGRTM3R2VkdmNEc0cUt0QXE2YU1k?=
 =?utf-8?B?aEZ0alFuSzltRnFMWjZ4dStQVysyZDhQV2xRcjVZNzNFT3FrbDlpTkhlSzJn?=
 =?utf-8?B?ODdMN0NtME41dk9kNktvTGYyVWwwN2Jyc3FUL0w4RGZybS9XNnFDVktGVk1H?=
 =?utf-8?B?Vk1nS3ZNVkhxSVV3dzZKQmdIVkVjSm1YSFNJMEIxVXZnQ1hNdHg1YlZyTnM3?=
 =?utf-8?B?eXFTMTNBeE9aK3JVMStjSjJaNFFGa1lWREN4VnRPWDA4b3Vpd0F6Tmx5c2FE?=
 =?utf-8?B?ZDRFbHNRLzJlU1RxQ1pGUUhsMFZBN1hiNXAyN2RSc01mTGJMMTg1RVJtUlBI?=
 =?utf-8?B?NCsxVWVFblBDbDcwRmhYbUlCZThrcmhwY1IrNTVXRzgzRFlhVk9mL1VDbHBH?=
 =?utf-8?B?N3dRbDExZXJ6ZnQyYjNZeTdnREozeWdqSUR6Ty8yZ09LMUlqZUc5dU1TUzgv?=
 =?utf-8?B?YVlqRG5wU2tySzgyNVFvU1RXb3dYNmx6aEVHa0l6SEtZRHpqeTExdi9hOUJC?=
 =?utf-8?B?d2lKZFRXNGZKSEVSMEg1OG5GR1pXUFJmWnRjZkVMenpKL3RBcGpuaXJ1enVP?=
 =?utf-8?B?eUNsSWJxWk4vZFVvWXhWSjRYM2pqK1BiNXpoeWo0dWJ6cnBRVzluWFcrZTAv?=
 =?utf-8?B?SFhVWjRXWFdva3VPTGE0MDhmcDJHRmg3L3oraVNXb2ZKWml3N2xpR2lNZzB5?=
 =?utf-8?B?TXMrbGZLdEx6Vm5wNDg4RFZhQkszNzJ3bXAxNHk0bzk1VEFDajFZaDVJOGlT?=
 =?utf-8?B?MVFYM0NXdXQyR1plMmZCTDFXS3JDV2Q1azhSYkdjTEpQaSt3UTU5N09tOXhG?=
 =?utf-8?B?TWthbXptRU1ka3U3Yk1yMENIanlaQVVqdkFINzI1M2gyeHFxR05zc0VOQUs3?=
 =?utf-8?B?MFJ6RUtBajRqaS83RWhGOUtiSVFXc01hTjhVOW1yODAvYXNOTzM1MHh1RHhW?=
 =?utf-8?B?Ynp1ZlNERkZMWW5LaEJQME9tN3lINnBYS0ZlQXlZYWxEMmswSEtUN0FhdzRQ?=
 =?utf-8?B?Qnh4U2pIUXBoK1E5Z1ZPaHliRW9BNW5YTUR4MlA5T0lzSytIeEtSTFNCYWtB?=
 =?utf-8?B?eGtwY3R2d0p6OUdQMnB5TmYrME8wQXRRMGhQL2RpRnR2OVRUNkxYMUU3K1Bt?=
 =?utf-8?B?WDE1MVRzOFIvWkxWU0FWZlZYY01rVmVyTWxwMjN4MjFFRTRCTkNGRUpnNkdq?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HUC7v/pKc2z7vg/3zDhg+i90pL7NMaEnQdOKg/sdFguAqmMoDqL1R7La3rkotais4YzUR1I3sGg8X2//mfWQDKc4NhUlVLlkgTOf5OP7zz7oCa7kA80BRY/hsKtZ0Gv8KQT1DEvADbiEzrHu6jGETyZUxOzaf160B3I/3UKdp/qtKYVPPaPoPKK5YiXLkDOStY3omI6Q4OIosZjf3fZ4v4plxaKfxMgHUvc5GydiH2lSUk5jviX8k8ye+MZCJD4PZ5haImSJO2p/sUvpj92CpTYOWIEEOVZjL+dnf31Z5CfsWtWYxUPFpov8pSc3hNzlILorfhxWfXcEAsijryiybvZqa3w1lTnmKKMCoR7Dg5eJV40qoBei5/WMVbQD23YHhUCgRxhnWXydR9ollTjz8s+uKHA1TwYR9SQ1WAUL70nauum/PrSVptVj8y3rKpk/JYMi+d+IbjmHirYsrL2zp9dIchBP0n1aHy+SS1aDk6pUMc5irMjyu+dh/8wvzK0n7eIIY54ZsW8vMEjsBGLnXYPrDzB+G9BCPkAZTqiw25okxvJemKAf3x2Ar3Bj08DD1FkpJX3x0CiKSOXL3fEJUiI/h98Co9v29SwZwVAd6do=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7031a2-f4b7-41c3-04e6-08de23ac4da5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 18:33:28.2112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1zPmLFzwEschS9Qi7cKaucE2n762gJSw5NDrC+aZC9YZ2DvPRdKhQRpafjyDvMiVvsd2Lj41Xs5XaOzLx3N4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511140150
X-Authority-Analysis: v=2.4 cv=YP6SCBGx c=1 sm=1 tr=0 ts=691775fd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=29DEdmLs_BIyC_6AW5kA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: BByiB2C3WS9kF4fS3NrwC90HeyTiOQKt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX0kh52yKtEhJb
 U/sU2BPO2tkTHjQb9Ww8wOdPlKS8So+CDmzu3Q1lRhhPv1jLaCNYbLbr3ZjiuicvPjD4H26aahj
 r9aoOIXx4RTjYkiibIFF9IeZn2Hq0hBy59w7ElKRAoMo0mHU90E8Dfr6aeZ7ZCRHE2uyqL7xtQV
 6jMOwWcrx6z7qKkClU2Wpzk39lRCbB8I+5Hyp1bBUIbCMl73nSIIIbrMb2xaN2zwPlMTtcFi1lX
 QLnlPVlDlXF7lVQZx4j9XHd9rhiA1sPiBeT/VWFFOAmch3jpbG4/BZlZ2+0oXiskEziDEidmE8M
 7Y8ekeLJl7PqLoB6DOPXJUQ7edqqzGYkvfcR18T/xJh7Z8ysBH6p9evEgQToeekYHov91mwWv/p
 NYUnc5EN1z6xxP360ZZcXqrROKmUag==
X-Proofpoint-GUID: BByiB2C3WS9kF4fS3NrwC90HeyTiOQKt

On 04/11/2025 22:25, Ihor Solodrai wrote:
> On 11/4/25 12:59 PM, Alan Maguire wrote:
>> On 29/10/2025 19:02, Ihor Solodrai wrote:
>>> This series implements BTF encoding of BPF kernel functions marked
>>> with KF_MAGIC_ARGS flag in pahole.
>>>
>>> The kfunc flag indicates that the arguments of a kfunc with __magic
>>> suffix are implicitly set by the verifier, and so pahole must emit two
>>> functions to BTF:
>>>   * kfunc_impl() with the arguments matching kernel declaration
>>>   * kfunc() with __magic arguments omitted
>>>
>>> For more details see relevant patch series for BPF:
>>> "bpf: magic kernel functions"
>>>
>>> This series is built upon KF_IMPLICIT_PROG_AUX_ARG support [1],
>>> although the approach changed signifcantly to call it a v2.
>>>
>>> [1] https://lore.kernel.org/dwarves/20250924211512.1287298-1-ihor.solodrai@linux.dev/
>>>
>>> Ihor Solodrai (3):
>>>   btf_encoder: refactor btf_encoder__add_func_proto
>>>   btf_encoder: factor out btf_encoder__add_bpf_kfunc()
>>>   btf_encoder: support kfuncs with KF_MAGIC_ARGS flag
>>>
>>>  btf_encoder.c | 292 ++++++++++++++++++++++++++++++++++++++------------
>>>  1 file changed, 222 insertions(+), 70 deletions(-)
>>>
>>
>> seems like we could potentially pull in patches 1 and 2 as cleanups
>> prior to handling the KF_MAGIC/IMPLICIT change; would that be worthwhile?
>>
> 
> Hi Alan.
> 
> Feel free to merge in the refactoring patches if you think they are
> useful. No objections.
> 
> I've had another off-list discussion with Andrii, and I am going to
> try implementing the next iteration of KF_IMPLICIT_ARGS (no magic,
> sorry) feature via resolve_btfids in the kernel tree.
> 
> As you of course well know, maintaining backwards compatibility by
> tracking pahole version and ensuring correct feature flags in the
> Linux kernel build has been tiresome.
> 
> We are thinking to address this by separating BTF generation for the
> kernel into two independent stages:
>   * generate BTF from DWARF with pahole
>   * then modify BTF with kernel-specific transformations (with
>     resolve_btfids, or however we rename it)
> 
> This will reduce the burden from pahole to know the kernel-specific
> tweaks of the BTF: adding kfunc decl tags, handling kernel function
> flags, etc. pahole will only be concerned with "generic" BTF
> generation from DWARF.
> 
> This will also free us from the need to control exactly what pahole
> features are available (maybe except specifying minimum version) in
> the kernel build, because btf2btf transformations will live in the
> Linux tree.
> 
> KF_IMPLICIT_ARGS will be the proof-of-concept for the approach. If it
> works well, then eventually we can migrate existing kernel-specific
> BTF generation out from pahole.
> 
> Let me know what you think about all this.
> 

This sounds great to me; separating the basic BTF generation from the
handling of kernel-specific transformations makes a lot of sense. In a
way we've been conflating core BTF types (enum64, float) and BTF
kernel-specific features up until now. These evolve at different speeds
and the latter is naturally more kernel-tied, so I think the separation
makes a lot of sense. It'd be nice to give resolve_btfids a more
descriptive name if its role changes in this way, but let's not open
another naming can of worms now ;-)

Alan



> Thank you.
> 
> 
>> Thanks!
>>
>> Alan
> 


