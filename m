Return-Path: <bpf+bounces-64813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587E9B17308
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 16:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0471C3BDD5B
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B886338;
	Thu, 31 Jul 2025 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i8w+rCPo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DMHsZcIK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241C49625;
	Thu, 31 Jul 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971433; cv=fail; b=X599YYqxQLFI/nm8v89od33vxQ9UjDVVjkau6xWAEx1jZzLIOiIKcC1W/OJhCY4qGpW/+oGZwJYtOxJ/nkHAuN77m9CSrC/wXVCnOtpHzvgMTOs9VG2APp9Wr94m9l1sxx/oSCc3MY34V1wK+5sSNGieU5cn+xvpWmOqpWSIIU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971433; c=relaxed/simple;
	bh=Jv4GKGVC7RocZq6dsPWFCeVNAStzeCgM9quYxcH1y48=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rB7We2m9DWWkSIH3wBQOGVO9QiRxL1fSmRae/2nEKW+VFG11f+tm2qK/TAkuq9XIKlcqB7RaDqzIRPtRZBkO4VXorUbV3PRYwd9HBO6shJrFYaurbcOnpdEMwjSlvOtISfeiH6lrclJ8UbOf4Sc0Rv6IAF3TgrwDWpqewGvaBUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i8w+rCPo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DMHsZcIK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VDj3Qg025498;
	Thu, 31 Jul 2025 14:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rR/r+Je1rndwuFOAr/A2yiYkKH74flZ4LnxxXPcLPYM=; b=
	i8w+rCPoh01i7CJd6wVBRV7ewm1/MA43ow4kW7uvUY9hY9L9mbAIuto5pc/L555Z
	T5Y0x3actukVjJF2DpuxtiYDjmdtqDpQFeWYl4Ov3jREzumst5KskMIC8mtJX+ih
	aMzn/9PiU2Yk8FEzDj28yoDGH4NAVePmMDdaQSnTBCUyQuY/vLx3emzPSmon0Vks
	VjrQ5IhgX2Q9N1Erah3TCRd3G6nZVAHP4f0/dQba0AUGQ1ZMTqwHSD96CO/OH7u6
	txAQswhMNPORPGm6a0QutpwpVEE/DGsJsC5D6PTy/y9g7v016YZuyexra+jmhFbZ
	pDrBlWqv2NNj6yA10Z17aA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q29vauf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 14:16:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VCf7Nm010380;
	Thu, 31 Jul 2025 14:16:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfcd5dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 14:16:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKV4tsgBwefD1nOStZly5SqhzWz1oa3F/e139/KOJtvHtR5eDRrbYIoy0fkmoRDrkikFxHWGlRx9USOMW+Yoza1Etlh434baiv3k449tz4klQdKa8255V8LvxuYNAJcKKNTHotw6EpYY1c2FwdO+2DjGJkwM3ztWIayVStGraQawsHY8tHApu+YdOvlYvEZJYcMYyZyqGMHeo+tr1bBZV29jBpTP5sCZOJfMsIqoFLPLRXroYxd6vM+IkuwIRQlCKjjCUkNgzp1qFc4+N3YbQ6Lo+iq3fL96vXrQIzmS2QkgkGY04o37XCn9Ys9jNVbQLj92Zkh41O+u4vNkT/K7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR/r+Je1rndwuFOAr/A2yiYkKH74flZ4LnxxXPcLPYM=;
 b=eIyM5bVyfx3xGJFH8NYw51zTlmDTHhzZnvqTT+GocsXPkP8u+n095A/VMicEvqyoT0kkctANAm7CNBVON9XzSoQcj7d05kPbICVG/lMGeP+Bd1MR/HxX54/vkN7WWHBb75VFyFoSMsj2smaNbRFKu1GZRVWG0cbooxZjf4rQMn5NdMAKirA4DYQiqFn0MsZIIgnareR8HY4ov0GevcTRi2GuorRdleXXtY4rJ918mcDvPxpO14ULTGztsc0kagsKlx+zOlTfRM2ANf1YVk8l9EJP8LimDt8nkOxGY9kW9phV8LS/8ZuHR9FV0esSlvcCSrMB2eIEfUrfreFqU9STUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR/r+Je1rndwuFOAr/A2yiYkKH74flZ4LnxxXPcLPYM=;
 b=DMHsZcIK8a+rhIwEyzdVu3nip1iYvvZwkIfWHoJ7RFs5iureQzQ00jhSBjn+6HNUuAe+ni2Yhanel8hopvoHrBM9V0R5VrPbAVDZpZdbs4koRqjthlTAepIsNJGu5yvFjgFCilMVpydIBwZYh6jDv+BGQxVWQBWewIEiT55aJoY=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BN0PR10MB5144.namprd10.prod.outlook.com (2603:10b6:408:127::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Thu, 31 Jul
 2025 14:16:53 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 14:16:53 +0000
Message-ID: <79a329ef-9bb3-454e-9135-731f2fd51951@oracle.com>
Date: Thu, 31 Jul 2025 15:16:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2] btf_encoder: group all function ELF syms by
 function name
To: ihor.solodrai@linux.dev, olsajiri@gmail.com, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        eddyz87@gmail.com, menglong8.dong@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, kernel-team@meta.com
References: <20250729020308.103139-1-isolodrai@meta.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250729020308.103139-1-isolodrai@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BN0PR10MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 581e7962-1742-4dbf-35cd-08ddd03ce59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0NZY2tXU2tiay9sMkp6N1VyMTNqY1dobHJocDIrS3VmbjRxZS9jQlRCa21C?=
 =?utf-8?B?RFNoZkJwRVY1NHJmcUFDYUVhemg2cXlUa2lYTTlQY1BUajJ4OE80WW14eHZB?=
 =?utf-8?B?bUFLQ2dTNE9QMmRVcjVYZkdkY1p5aG40OWZ5QVR4bktTQ1ZVNlQwaXZaVVQ0?=
 =?utf-8?B?YzZQNkFwUFBSSElKdFRlM1VadnVnS2NERFpqelhDVzh0ZTFNN1JEN3ZoYUcr?=
 =?utf-8?B?cmY3eGdlbGdkVkpuZkxJSE9XazY0N2pOMnMySkd4VE8yeUQ2THJjZkRkY1BM?=
 =?utf-8?B?NTlHQys3eElBaTdyeklITTE4WXFvVkZYSEF5VjZtNXR0MTVUY1Zhcml1Wk5n?=
 =?utf-8?B?OGY3RVBxUVVaOTNFM3VsekJLMk5YUm9Rdy83bWN4QUdSZzdlL21XaDZ3SjQ4?=
 =?utf-8?B?R2FYaFo0VmdmbG1uenp6RjEyamErSU5MSjVzRm1adWY0TFNYZGFJUkh0NW9Q?=
 =?utf-8?B?Q1JOS2puaW9kS1I0VEhHN3VYQlNzM1BvK3h5WXFxckFGaHFKcllMYjFEb2p0?=
 =?utf-8?B?cDNRdnptT1hrMVJUUFd4ZFc5a1hUdUtWNGw4OWZRQ2tRU1RXbmd3ZUpDTmVr?=
 =?utf-8?B?YmplZWFIUFRvTDB5NURwdTBDNzlCQloveU1PTFY3U1o2UzduTTFoc0IwOUhK?=
 =?utf-8?B?UjdRck9DTGROR2JXZ0NEZ2ZsZS92MFpkMWpzTGtBT0hEZGYwV0lrOTlGVzNM?=
 =?utf-8?B?cmF3SWsvTFhEUXgzY1d4STZxc2pYTkRSOGdSc2dNZis5Tk1IWXZhSi9zc0ZR?=
 =?utf-8?B?aFk1WXBWcVFEL0dtcGdXU3RPQTlDcDNtT1Jab1dGR2M2OE0vR0VvYTkvSjls?=
 =?utf-8?B?Y3ZOUHdMdXdheExPSFd2bjFHa2ZlcWJMaVVCMGFXb2tiQ0VUdXo4aEpnTEtX?=
 =?utf-8?B?Y1dzZzl2T1NDczRYUTVGVnZ3aHlidHRRcTdsUzZzdTVISldiZUlMRlQrV2o4?=
 =?utf-8?B?Yk5OQWlFbEo1R2h1L2t0bU5pTlI3OFNER2N3czhYcjBjZWZ2L0hxMlJsZmpj?=
 =?utf-8?B?ZTl2NkgvelYrUlU4Z01DeU4wUmMxVm05WVVsaVJTQVpXaEJuZVpLK2JVN3dx?=
 =?utf-8?B?K25FSEhnWmk2aWhwT2dTRUZsN1ZiTWdHckg2bWhoQ3FxVUNMNW1WSHIvN09n?=
 =?utf-8?B?RHRtVFY1Ukpta05UVDBLK1BJK1B6d1V2UXpDbTVDUDJqMXI0RjN4b0d6WVY5?=
 =?utf-8?B?QkdaWTJ5aEZmZEFSSmNxMTdPMWhKWFpoZE5Bc2x1ajNoT2xBd2tENjVDcHIr?=
 =?utf-8?B?cjZ1VTNyOUN3L3NOSS9tdW1NdlVKQ1YrdCtGYWdxZ0EvaEJ1dnhWUGJjalZ6?=
 =?utf-8?B?ak9DQUJ3Wm84Mk5qd0hBN2lkenErWXdvTlQyK2dmVGZLOXptUUlpRjJLWUY3?=
 =?utf-8?B?WkxXMlhNbzVNdTErUE5ISFJYcVIxQ3E4Mzl5dkUzZHhseUlzMEpsUmhSRDBS?=
 =?utf-8?B?ckdNMDAwZTJ1cmFmYm1UTC9wY0RqRTN2QzROS0tPR0oxcjZoRndXK2dHSlNa?=
 =?utf-8?B?ZzI1WVA3YXY5RjhrRG9JWUhoNFZqZ0o4ZkQrT1cwS1R0Qy9sNFBwdTRRZDUy?=
 =?utf-8?B?d0FncjU2bVhvbE94a29Xblp6M24waHFQWERJVXJ2MEc2cUZVcU9OOVNRMlUx?=
 =?utf-8?B?SFBNNXhlMXBMRTNCVWVHOGJFbUM1OCtaUDNvcWxTKy9sT0YrR3ZwV0VRdElL?=
 =?utf-8?B?YVROdjg2VUtpTjBOdzFiWXN1NEppWUlCbDdmbmlxY0l6em9rYjJ3L1BCQ3Nj?=
 =?utf-8?B?Z2VNOWloMitlWVN5cithdTU2MDkxVnZmSHZGdjh0czh4M3FhOEJjNHlCSDZS?=
 =?utf-8?B?YW9vdWhiSEV1SS8zZ2F4RzBRazhVMEdGQSs5ZDJ6VzZvMmhxYWxkczV5ZStk?=
 =?utf-8?B?M1lHMjN1RlZhYTNsODhnK0hnZjJ1YkhaNDhtZmxEc3pLRGVoWFpzWmY3dHlh?=
 =?utf-8?Q?/Uh9MX0jWFE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1Z0QzdhN3d4YTBxbWxoQ3EyTDJZQnVkam9iejhNaCtFak8wU3NYSGpZYld0?=
 =?utf-8?B?ZEVkT3pyTUJHK0hhR25SNTNQZnNvZ1VpRjE2M1lnU2tGWGhqWk1QYS9leWJH?=
 =?utf-8?B?LzhJelBLUFpKUVB4aW51SVZGYlZPbjc5eGJvZTJVUENDMDRrMUZQN0pqYk5N?=
 =?utf-8?B?cWlrbll5c1FvWERLdG5QUTRrQ0xjMjN0cXJ1Z2Q1YUNiaEQ5WU1IOGIyNEZR?=
 =?utf-8?B?S2lEUkdkc0p2TlViL21UaURPMmtCbno0YzdXT2tKSHNmTEZwY2d0Mms2eG9C?=
 =?utf-8?B?bzhLYWZ2dnFPMlZrT2FRU1Y2KzZPOUs3MHRvTEs5S2xhMEhVTGhKZGpsc2Fz?=
 =?utf-8?B?WW1IeEJ1VzJyZXJZdlBwZ0VHK0xZdW9xTGpTNU5iVzdtdmNXanIxa0IrWGp2?=
 =?utf-8?B?SHRZcldiQVY0ZDhCWHVJaUtrTHlPWlJINFZHTW0yQ0VCTzNYVFBjcTYyR1Qv?=
 =?utf-8?B?ak15T0E0UHExVDNuV2dkeXEwb1B4eFlya2tienpGMTBTKzJEcDZpb3I2M1FU?=
 =?utf-8?B?ZXVzV3Q0UitqYUt5ZWhzVnNVdjZJYm91US93S2tDMytrNkpjTERBQ1pKREhW?=
 =?utf-8?B?YVFZYmhVNG53YVZ1VUZ6b1hyZTlmUitVZUkyZExZcE5UbmZPbkR1bWdKTFFF?=
 =?utf-8?B?MHNFOXJwRjlGRFBJSCtHRjNZcndid0I4VWdEK0tzbDlSWWxqL1UrRXdkSVpD?=
 =?utf-8?B?M0M0OXF3Z3VCU3RxazZyVWVPUFcwajNNTEhucEZ1LytEWi92SzB2TGROV0xH?=
 =?utf-8?B?OFkwTXUxaEhRNkY4emFBby8xazFJUDUyZ0RxbE9KVTBuUjRldWw4RWwrVENl?=
 =?utf-8?B?dkVmaFZJeVRZUzBMN3dPcGRMUVYrRkFOTjZxZ3BtRU1PK3FRTStsbHQ0WUMy?=
 =?utf-8?B?NDM4WmpWbmlCTlNKeWtzdWM2Um9zTHh1Mm8ybUVzRWo1T2V1QWxDWlU4ekhs?=
 =?utf-8?B?cCszQlVTVHFJOVVFak1hUDUrSDNXWkZ1SFQxNXdLRDFCVmZNcDJlSjQ0azd3?=
 =?utf-8?B?U1RVSGZTaXA5WDJJa205OWFIMmFBNXYxd2dKelRjK1B3WUtaT3VjcE5sajl1?=
 =?utf-8?B?Z1Vrejh5K0Q2aFZxNE5oTk5JUXM2UllGUnd2MWZHbi80TWNSM0pxWnBVQUZv?=
 =?utf-8?B?TFFQSnNFNWljT1RNSk93YzFIYzFlTDNrQ3NBS1REYnBDZDhjNGhaQlJ0cWV5?=
 =?utf-8?B?c25MRUtQK0VUamhxdWJMSHB6Vlg3RlNZUnkyRnUwNXJtdHFrRHdMRmZ6cE02?=
 =?utf-8?B?TUp4Sm5kU1lHYTJ4NDJuYnVRV25NcEs3V0Uzdm14bFNTbzRZdEYvVVVJNmJi?=
 =?utf-8?B?Y3puc1NNdmh6UHliQXJ4VDU3RjEzN01LRFVQRVYyWkprSHY3ZFFTSjU0SThK?=
 =?utf-8?B?c1ExdEVTWDFLSFBPanJMVllwMzJQQnpJNUg3TmNETXlUcXVaS2VEb3NrSXl0?=
 =?utf-8?B?T2F6THdwb082bFY0bEo2UklSSStTZmVDRDI3V290SGdzTlpZNXpmbVRDdEFv?=
 =?utf-8?B?NlN2eG0zejlzbkJqaGxGbXBtbno5RGlCU2V5Ny82bjY3dzZ6Q1puQ0lNeXVH?=
 =?utf-8?B?M3hjQTZRRUM4cjUrVDQ4eU16bjQreDN1UDZZNXVwSStJRlFtdFcvTGxBOVlS?=
 =?utf-8?B?cmhMS2xXUkFlbm9sNmpJVkZqWU9JU2h1NnJKTy9LdFQ5R1Q1TUNkR0lTOC92?=
 =?utf-8?B?Mk5ra1BGSWdrUnpzeVdQRlNrZ3QzcjBhU0swMzNpVS82S295L2hMTFMvSEox?=
 =?utf-8?B?UlNndngxRHFlRmc0eHpBMmttRkp2TkVMSDA4YjF5dlY2STk5aTBSTzI2dzY5?=
 =?utf-8?B?YkhITmxqNXV2UVp4UWJUU29FK01ZWEdmVXpJZTFYYUdpMTB4MmttSjJzSGRr?=
 =?utf-8?B?UFcrclFTQzNHNHJjamR3azN1VkhDVVV6SGR0N0lQb1dYSGZRMlJld1JRaW9z?=
 =?utf-8?B?cEpBUDZwQi9kRFdSMGo5VGZZWm81RnEzU3hkOGJSamtvSjJ6dStmWm04d1JZ?=
 =?utf-8?B?cmNKRjdiWFdFWjRBK0dXbU5ZRWhyVC8wMWNHLy8rekJ1SUtoR1RXamxyZnRj?=
 =?utf-8?B?S0c4VmFrd096V0dGOUlkTm1SUmR1VW5tZFVzeE11Y2ltbjRKZkpUbEo2bnBk?=
 =?utf-8?B?UThWWlllbVdiTXNJWlN1R1BtQnRjdDdYOERlMVV1L2JUbkVDbkxMa3VucThi?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	joHE+uIYvgBd2gWKsWViOWT4SadcYEx5qAoeZRI1/GyaJk2dhG9qpWZRmBOfOg/BamMRmTGQw7+uB90uPvZQssw1B8eQLdP4kH4MqPC6Bp0mbC6ofy4d30Xg7asoHO9IH8qPcjtWbBbZd6TKeN7BbX4NmuqL1WwKLoQMuqo4XSpMWDb+R91XUyEOEfQXtipeAc07wIT11IqnOkWIBeg6qsKS/GY/A6YFqZxZVF9U4MVvC6e6Sq1pIjqksRU+8IFGLw3qdWE7o95dWbjD+AMifauwS/Y17KyZlbcVTghxOU3RYufobxJMjzs7P278yWz/oQB1cMUdbQW6AlrgB5xJ4CvWmXuj2FvQg64t9O+ciwfxXoR/l/GcufGeoX+Xu3BjKhXelrhDmVC8F8QZp3t5moZWQubLJLNUOUrS514AYDXxdvUJJFBJr6TibhMRy9N+qoVdE9Z/oOTNCLfQaZx6EbsvgD6ufkqTxkeGipd4pVhED4pZKUZs3eg+MT3k1zooPty6xoNz0pn93sGC4a6VwlKMxYaOPBOT3Q+gV/Nvd6XjYKdNe2oi+ah2drFfvptqEg6FeyJxtYtMkOyTWlhB2pbQ9mcrbYWs0Hw+GHqDjHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581e7962-1742-4dbf-35cd-08ddd03ce59e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 14:16:52.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJLM2gmj+7aUFk5GYff79cLBpzX7B+e8RZFelfta0UreSlLgLA6owV7ym6mh6BnYDICymORAC0/Vsf695eYqgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310097
X-Proofpoint-ORIG-GUID: xMVWvcIXt-mOaxRp4yr-MVRFWw2GivU0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA5NyBTYWx0ZWRfXyigQSnt6l6IA
 YAOyB4+zhzrcqS27kCydb++n/OBRMFT/ltNgKUnTbKA0sQAfSvDOP03hDwEHk4fgd4QVGl7VGjl
 SSS9Zr2AtINWOwN+lgd57csjbAg6W+3GIBywy8ZTSgvQ8uBi2/9A40HzHR8VJO0/1mrEPaJ2fyi
 9bbzj+B9BERy+HtpclIC3TkkyYAlhNJDVmGh28QvCqQcvd/qpsUDadC+fJWSHNlXipY2P2qgWlN
 d4rIU8XKv21YyttYwyyQFFZth9l8otq1DgdqF5MkNc2lBarWVswBJn6JPxwIua6Ju1sT8Dhf+Kw
 bl5i402Xmgyo596B7O4fQTuxvdyQARPoBsSxrXoyCG+W3rDuISvBh4CoGAJRm50WIpeXywCeuSQ
 fn0x6VgykStR1gLVwwiI/BjlCOIfUS5QGicOeY7dr2HsJdNOuJ77JnkA5TufBoAcHDT31Gf4
X-Authority-Analysis: v=2.4 cv=FvIF/3rq c=1 sm=1 tr=0 ts=688b7ad9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=RxI0gpGpNFAN5DKertIA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf awl=host:13604
X-Proofpoint-GUID: xMVWvcIXt-mOaxRp4yr-MVRFWw2GivU0

On 29/07/2025 03:03, Ihor Solodrai wrote:
> btf_encoder collects function ELF symbols into a table, which is later
> used for processing DWARF data and determining whether a function can
> be added to BTF.
> 
> So far the ELF symbol name was used as a key for search in this table,
> and a search by prefix match was attempted in cases when ELF symbol
> name has a compiler-generated suffix.
> 
> This implementation has bugs [1][2], causing some functions to be
> inappropriately excluded from (or included into) BTF.
> 
> Rework the implementation of the ELF functions table. Use a name of a
> function without any suffix - symbol name before the first occurrence
> of '.' - as a key. This way btf_encoder__find_function() always
> returns a valid elf_function object (or NULL).
> 
> Collect an array of symbol name + address pairs from GElf_Sym for each
> elf_function when building the elf_functions table.
> 
> Introduce ambiguous_addr flag to the btf_encoder_func_state. It is set
> when the function is saved by examining the array of ELF symbols in
> elf_function__has_ambiguous_address(). It tests whether there is only
> one unique address for this function name, taking into account that
> some addresses associated with it are not relevant:
>   * ".cold" suffix indicates a piece of hot/cold split
>   * ".part" suffix indicates a piece of partial inline
> 
> When inspecting symbol name we have to search for any occurrence of
> the target suffix, as opposed to testing the entire suffix, or the end
> of a string. This is because suffixes may be combined by the compiler,
> for example producing ".isra0.cold", and the conclusion will be
> incorrect.
> 
> In saved_functions_combine() check ambiguous_addr when deciding
> whether a function should be included in BTF.
> 
> Successful CI run: https://github.com/acmel/dwarves/pull/68/checks
> 
> I manually spot checked some of the ~200 functions from vmlinux (BPF
> CI-like kconfig) that are now excluded: all of those that I checked
> had multiple addresses, and some where static functions from different
> files with the same name.
> 
> [1] https://lore.kernel.org/bpf/2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev/
> [2] https://lore.kernel.org/dwarves/6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev/
> 
> v1: https://lore.kernel.org/dwarves/98f41eaf6dd364745013650d58c5f254a592221c@linux.dev/
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>

Thanks for doing this Ihor! Apologies for just thinking of this now, but
why don't we filter out the .cold and .part functions earlier, not even
adding them to the ELF functions list? Something like this on top of
your patch:

$ git diff
diff --git a/btf_encoder.c b/btf_encoder.c
index 0aa94ae..f61db0f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1188,27 +1188,6 @@ static struct btf_encoder_func_state
*btf_encoder__alloc_func_state(struct btf_e
        return state;
 }

-/* some "." suffixes do not correspond to real functions;
- * - .part for partial inline
- * - .cold for rarely-used codepath extracted for better code locality
- */
-static bool str_contains_non_fn_suffix(const char *str) {
-       static const char *skip[] = {
-               ".cold",
-               ".part"
-       };
-       char *suffix = strchr(str, '.');
-       int i;
-
-       if (!suffix)
-               return false;
-       for (i = 0; i < ARRAY_SIZE(skip); i++) {
-               if (strstr(suffix, skip[i]))
-                       return true;
-       }
-       return false;
-}
-
 static bool elf_function__has_ambiguous_address(struct elf_function
*func) {
        struct elf_function_sym *sym;
        uint64_t addr;
@@ -1219,12 +1198,10 @@ static bool
elf_function__has_ambiguous_address(struct elf_function *func) {
        addr = 0;
        for (int i = 0; i < func->sym_cnt; i++) {
                sym = &func->syms[i];
-               if (!str_contains_non_fn_suffix(sym->name)) {
-                       if (addr && addr != sym->addr)
-                               return true;
-                       else
+               if (addr && addr != sym->addr)
+                       return true;
+               else
                                addr = sym->addr;
-               }
        }


        return false;
@@ -2208,9 +2185,12 @@ static int elf_functions__collect(struct
elf_functions *functions)
                func = &functions->entries[functions->cnt];

                suffix = strchr(sym_name, '.');
-               if (suffix)
+               if (suffix) {
+                       if (strstr(suffix, ".part") ||
+                           strstr(suffix, ".cold"))
+                               continue;
                        func->name = strndup(sym_name, suffix - sym_name);
-               else
+               } else
                        func->name = strdup(sym_name);

                if (!func->name) {

I think that would work and saves later string comparisons, what do you
think?

> ---
>  btf_encoder.c | 250 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 162 insertions(+), 88 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 0bc2334..0aa94ae 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -87,16 +87,22 @@ struct btf_encoder_func_state {
>  	uint8_t optimized_parms:1;
>  	uint8_t unexpected_reg:1;
>  	uint8_t inconsistent_proto:1;
> +	uint8_t ambiguous_addr:1;
>  	int ret_type_id;
>  	struct btf_encoder_func_parm *parms;
>  	struct btf_encoder_func_annot *annots;
>  };
>  
> +struct elf_function_sym {
> +	const char *name;
> +	uint64_t addr;
> +};
> +
>  struct elf_function {
> -	const char	*name;
> -	char		*alias;
> -	size_t		prefixlen;
> -	bool		kfunc;
> +	char		*name;
> +	struct elf_function_sym *syms;
> +	uint8_t 	sym_cnt;
> +	uint8_t		kfunc:1;
>  	uint32_t	kfunc_flags;
>  };
>  
> @@ -115,7 +121,6 @@ struct elf_functions {
>  	struct elf_symtab *symtab;
>  	struct elf_function *entries;
>  	int cnt;
> -	int suffix_cnt; /* number of .isra, .part etc */
>  };
>  
>  /*
> @@ -161,10 +166,18 @@ struct btf_kfunc_set_range {
>  	uint64_t end;
>  };
>  
> +static inline void elf_function__free_content(struct elf_function *func) {
> +	free(func->name);
> +	if (func->sym_cnt)
> +		free(func->syms);
> +	memset(func, 0, sizeof(*func));
> +}
> +
>  static inline void elf_functions__delete(struct elf_functions *funcs)
>  {
> -	for (int i = 0; i < funcs->cnt; i++)
> -		free(funcs->entries[i].alias);
> +	for (int i = 0; i < funcs->cnt; i++) {
> +		elf_function__free_content(&funcs->entries[i]);
> +	}
>  	free(funcs->entries);
>  	elf_symtab__delete(funcs->symtab);
>  	list_del(&funcs->node);
> @@ -981,8 +994,7 @@ static void btf_encoder__log_func_skip(struct btf_encoder *encoder, struct elf_f
>  
>  	if (!encoder->verbose)
>  		return;
> -	printf("%s (%s): skipping BTF encoding of function due to ",
> -	       func->alias ?: func->name, func->name);
> +	printf("%s : skipping BTF encoding of function due to ", func->name);
>  	va_start(ap, fmt);
>  	vprintf(fmt, ap);
>  	va_end(ap);
> @@ -1176,6 +1188,48 @@ static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_e
>  	return state;
>  }
>  
> +/* some "." suffixes do not correspond to real functions;
> + * - .part for partial inline
> + * - .cold for rarely-used codepath extracted for better code locality
> + */
> +static bool str_contains_non_fn_suffix(const char *str) {
> +	static const char *skip[] = {
> +		".cold",
> +		".part"
> +	};
> +	char *suffix = strchr(str, '.');
> +	int i;
> +
> +	if (!suffix)
> +		return false;
> +	for (i = 0; i < ARRAY_SIZE(skip); i++) {
> +		if (strstr(suffix, skip[i]))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool elf_function__has_ambiguous_address(struct elf_function *func) {
> +	struct elf_function_sym *sym;
> +	uint64_t addr;
> +
> +	if (func->sym_cnt <= 1)
> +		return false;
> +
> +	addr = 0;
> +	for (int i = 0; i < func->sym_cnt; i++) {
> +		sym = &func->syms[i];
> +		if (!str_contains_non_fn_suffix(sym->name)) {
> +			if (addr && addr != sym->addr)
> +				return true;
> +			else
> +			 	addr = sym->addr;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
>  {
>  	struct btf_encoder_func_state *state = btf_encoder__alloc_func_state(encoder);
> @@ -1191,6 +1245,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>  
>  	state->encoder = encoder;
>  	state->elf = func;
> +	state->ambiguous_addr = elf_function__has_ambiguous_address(func);
>  	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>  	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
>  	if (state->nr_parms > 0) {
> @@ -1294,7 +1349,7 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>  	int err;
>  
>  	btf_fnproto_id = btf_encoder__add_func_proto(encoder, NULL, state);
> -	name = func->alias ?: func->name;
> +	name = func->name;
>  	if (btf_fnproto_id >= 0)
>  		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
>  						      name, false);
> @@ -1338,48 +1393,39 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>  	return 0;
>  }
>  
> -static int functions_cmp(const void *_a, const void *_b)
> +static int elf_function__name_cmp(const void *_a, const void *_b)
>  {
>  	const struct elf_function *a = _a;
>  	const struct elf_function *b = _b;
>  
> -	/* if search key allows prefix match, verify target has matching
> -	 * prefix len and prefix matches.
> -	 */
> -	if (a->prefixlen && a->prefixlen == b->prefixlen)
> -		return strncmp(a->name, b->name, b->prefixlen);
>  	return strcmp(a->name, b->name);
>  }
>  
> -#ifndef max
> -#define max(x, y) ((x) < (y) ? (y) : (x))
> -#endif
> -
>  static int saved_functions_cmp(const void *_a, const void *_b)
>  {
>  	const struct btf_encoder_func_state *a = _a;
>  	const struct btf_encoder_func_state *b = _b;
>  
> -	return functions_cmp(a->elf, b->elf);
> +	return elf_function__name_cmp(a->elf, b->elf);
>  }
>  
>  static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_encoder_func_state *b)
>  {
> -	uint8_t optimized, unexpected, inconsistent;
> -	int ret;
> +	uint8_t optimized, unexpected, inconsistent, ambiguous_addr;
> +
> +	if (a->elf != b->elf)
> +		return 1;
>  
> -	ret = strncmp(a->elf->name, b->elf->name,
> -		      max(a->elf->prefixlen, b->elf->prefixlen));
> -	if (ret != 0)
> -		return ret;
>  	optimized = a->optimized_parms | b->optimized_parms;
>  	unexpected = a->unexpected_reg | b->unexpected_reg;
>  	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
> -	if (!unexpected && !inconsistent && !funcs__match(a, b))
> +	ambiguous_addr = a->ambiguous_addr | b->ambiguous_addr;
> +	if (!unexpected && !inconsistent && !ambiguous_addr && !funcs__match(a, b))
>  		inconsistent = 1;
>  	a->optimized_parms = b->optimized_parms = optimized;
>  	a->unexpected_reg = b->unexpected_reg = unexpected;
>  	a->inconsistent_proto = b->inconsistent_proto = inconsistent;
> +	a->ambiguous_addr = b->ambiguous_addr = ambiguous_addr;
>  
>  	return 0;
>  }
> @@ -1432,7 +1478,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>  		 * just do not _use_ them.  Only exclude functions with
>  		 * unexpected register use or multiple inconsistent prototypes.
>  		 */
> -		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto;
> +		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->ambiguous_addr;
>  
>  		if (add_to_btf) {
>  			err = btf_encoder__add_func(state->encoder, state);
> @@ -1447,32 +1493,6 @@ out:
>  	return err;
>  }
>  
> -static void elf_functions__collect_function(struct elf_functions *functions, GElf_Sym *sym)
> -{
> -	struct elf_function *func;
> -	const char *name;
> -
> -	if (elf_sym__type(sym) != STT_FUNC)
> -		return;
> -
> -	name = elf_sym__name(sym, functions->symtab);
> -	if (!name)
> -		return;
> -
> -	func = &functions->entries[functions->cnt];
> -	func->name = name;
> -	if (strchr(name, '.')) {
> -		const char *suffix = strchr(name, '.');
> -
> -		functions->suffix_cnt++;
> -		func->prefixlen = suffix - name;
> -	} else {
> -		func->prefixlen = strlen(name);
> -	}
> -
> -	functions->cnt++;
> -}
> -
>  static struct elf_functions *btf_encoder__elf_functions(struct btf_encoder *encoder)
>  {
>  	struct elf_functions *funcs = NULL;
> @@ -1490,13 +1510,12 @@ static struct elf_functions *btf_encoder__elf_functions(struct btf_encoder *enco
>  	return funcs;
>  }
>  
> -static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
> -						       const char *name, size_t prefixlen)
> +static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder, const char *name)
>  {
>  	struct elf_functions *funcs = elf_functions__find(encoder->cu->elf, &encoder->elf_functions_list);
> -	struct elf_function key = { .name = name, .prefixlen = prefixlen };
> +	struct elf_function key = { .name = (char*)name };
>  
> -	return bsearch(&key, funcs->entries, funcs->cnt, sizeof(key), functions_cmp);
> +	return bsearch(&key, funcs->entries, funcs->cnt, sizeof(key), elf_function__name_cmp);
>  }
>  
>  static bool btf_name_char_ok(char c, bool first)
> @@ -2060,7 +2079,7 @@ static int btf_encoder__collect_kfuncs(struct btf_encoder *encoder)
>  			continue;
>  		}
>  
> -		elf_fn = btf_encoder__find_function(encoder, func, 0);
> +		elf_fn = btf_encoder__find_function(encoder, func);
>  		if (elf_fn) {
>  			elf_fn->kfunc = true;
>  			elf_fn->kfunc_flags = pair->flags;
> @@ -2135,14 +2154,34 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
>  	return err;
>  }
>  
> +static inline int elf_function__push_sym(struct elf_function *func, struct elf_function_sym *sym) {
> +	struct elf_function_sym *tmp;
> +
> +	if (func->sym_cnt)
> +		tmp = realloc(func->syms, (func->sym_cnt + 1) * sizeof(func->syms[0]));
> +	else
> +		tmp = calloc(sizeof(func->syms[0]), 1);
> +
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	func->syms = tmp;
> +	func->syms[func->sym_cnt] = *sym;
> +	func->sym_cnt++;
> +
> +	return 0;
> +}
> +
>  static int elf_functions__collect(struct elf_functions *functions)
>  {
>  	uint32_t nr_symbols = elf_symtab__nr_symbols(functions->symtab);
> -	struct elf_function *tmp;
> +	struct elf_function_sym func_sym;
> +	struct elf_function *func, *tmp;
> +	const char *sym_name, *suffix;
>  	Elf32_Word sym_sec_idx;
> +	int err = 0, i, j;
>  	uint32_t core_id;
>  	GElf_Sym sym;
> -	int err = 0;
>  
>  	/* We know that number of functions is less than number of symbols,
>  	 * so we can overallocate temporarily.
> @@ -2153,18 +2192,72 @@ static int elf_functions__collect(struct elf_functions *functions)
>  		goto out_free;
>  	}
>  
> +	/* First, collect an elf_function for each GElf_Sym
> +	 * Where func->name is without a suffix
> +	 */
>  	functions->cnt = 0;
>  	elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_sec_idx) {
> -		elf_functions__collect_function(functions, &sym);
> +
> +		if (elf_sym__type(&sym) != STT_FUNC)
> +			continue;
> +
> +		sym_name = elf_sym__name(&sym, functions->symtab);
> +		if (!sym_name)
> +			continue;
> +
> +		func = &functions->entries[functions->cnt];
> +
> +		suffix = strchr(sym_name, '.');
> +		if (suffix)
> +			func->name = strndup(sym_name, suffix - sym_name);
> +		else
> +			func->name = strdup(sym_name);
> +
> +		if (!func->name) {
> +			err = -ENOMEM;
> +			goto out_free;
> +		}
> +
> +		func_sym.name = sym_name;
> +		func_sym.addr = sym.st_value;
> +
> +		err = elf_function__push_sym(func, &func_sym);
> +		if (err)
> +			goto out_free;
> +
> +		functions->cnt++;
>  	}
>  
> +	/* At this point functions->entries is an unordered array of elf_function
> +	 * each having a name (without a suffix) and a single elf_function_sym (maybe with suffix)
> +	 * Now let's sort this table by name.
> +	 */
>  	if (functions->cnt) {
> -		qsort(functions->entries, functions->cnt, sizeof(*functions->entries), functions_cmp);
> +		qsort(functions->entries, functions->cnt, sizeof(*functions->entries), elf_function__name_cmp);
>  	} else {
>  		err = 0;
>  		goto out_free;
>  	}
>  
> +	/* Finally dedup by name, transforming { name -> syms[1] } entries into { name -> syms[n] } */
> +	i = 0;
> +	j = 1;
> +	for (j = 1; j < functions->cnt; j++) {
> +		struct elf_function *a = &functions->entries[i];
> +		struct elf_function *b = &functions->entries[j];
> +
> +		if (!strcmp(a->name, b->name)) {
> +			elf_function__push_sym(a, &b->syms[0]);
> +			elf_function__free_content(b);
> +		} else {
> +			i++;
> +			if (i != j)
> +				functions->entries[i] = functions->entries[j];
> +		}
> +	}
> +
> +	functions->cnt = i + 1;
> +
>  	/* Reallocate to the exact size */
>  	tmp = realloc(functions->entries, functions->cnt * sizeof(struct elf_function));
>  	if (tmp) {
> @@ -2661,30 +2754,11 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  			if (!name)
>  				continue;
>  
> -			/* prefer exact function name match... */
> -			func = btf_encoder__find_function(encoder, name, 0);
> -			if (!func && funcs->suffix_cnt &&
> -			    conf_load->btf_gen_optimized) {
> -				/* falling back to name.isra.0 match if no exact
> -				 * match is found; only bother if we found any
> -				 * .suffix function names.  The function
> -				 * will be saved and added once we ensure
> -				 * it does not have optimized-out parameters
> -				 * in any cu.
> -				 */
> -				func = btf_encoder__find_function(encoder, name,
> -								  strlen(name));
> -				if (func) {
> -					if (encoder->verbose)
> -						printf("matched function '%s' with '%s'%s\n",
> -						       name, func->name,
> -						       fn->proto.optimized_parms ?
> -						       ", has optimized-out parameters" :
> -						       fn->proto.unexpected_reg ? ", has unexpected register use by params" :
> -						       "");
> -					if (!func->alias)
> -						func->alias = strdup(name);
> -				}
> +			func = btf_encoder__find_function(encoder, name);
> +			if (!func) {
> +				if (encoder->verbose)
> +					printf("could not find function '%s' in the ELF functions table\n", name);
> +				continue;
>  			}
>  		} else {
>  			if (!fn->external)


