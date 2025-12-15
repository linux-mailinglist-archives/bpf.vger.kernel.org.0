Return-Path: <bpf+bounces-76611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F45FCBED27
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 17:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD1AB3001831
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D3A334C04;
	Mon, 15 Dec 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lBLc3tgw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HSWJGi2B"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99533291F;
	Mon, 15 Dec 2025 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765814717; cv=fail; b=Iumijpjdswj4ytSULoDTxW6/yAyqqZf38J+t6Q5APtrbKJ0PFtjuBwzrISYVRpY6ifU/qEaSXNkdYCgh+HxlA24CaWMt2qJAIFtJXbchD0HyvKmcBI27Dkmf0IggBvZrduDtr3fa6oORC67pfjgVgx7/BIGwEBlO+2uUoz3nv8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765814717; c=relaxed/simple;
	bh=io7h29ZO8sqkWXv99msbK5gJLuAT5xvLt7c1VwvlB5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MIT/KUB5EC2g/tIdDYBLkFHy5nvO5CrPfj7ToVCdvix7/HtSR8g7W3/MQHI29xW7X07iBXByYC913DaDb3W/UAXNb3lBywk/c7xn/A1FhHUrkX/uUJ2wFwquSpyntRQL6gu/QyvHgBUAotT8Y+/lTc+fiCku+j2lq6eLd3ke/jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lBLc3tgw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HSWJGi2B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFFNNYQ2650129;
	Mon, 15 Dec 2025 16:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=df/qAjj55YC/jJRYxOWoG6ZEJd+jitvYRXhL0HX3CJE=; b=
	lBLc3tgwAP04vU1zGPeDN07z0uq/7r0xmiFJTHct0dwhQWllfxlced6zt4GXSdPK
	ik5r+xI94Hfoe4RMhGHBMhoawas9Mu5T3QrOJyDltcgYp1OwOwRJNhHHdp8Rco8h
	ea1l4AgZ4XqwlTUo1vQD7eUqQO3EMdQ1rz68RoogyRBcJLbF3bgfl+tVNkTKOA9U
	f8JpjncXhRoF5+xflIfXByG5/lSq/ucCwDhtucFC4ryotoM07Syu61lsUKHx6cIA
	1s3MyGPEI8j1fA0EU0w66EWm26i0ODuum4j0Cvg8VgzEx9ZjI1rAI78EfLehb06p
	olAoWzcy3bzFkmLL2GBJXw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b106ca8uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 16:03:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFFUEj3024747;
	Mon, 15 Dec 2025 16:03:14 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk93njw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 16:03:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7HKI1DVrEd8ltHLEiz5JYNnlNX/iynF9dO/1pIdPYB4/ELXXxWoetPsBKGrbPN1JZmmkZWD/uPOcrGgXceju5BtiOt/77NpBBhchrmqyjO88ryS3iHI1HTBfvvO0qEWwcNnw45//3yvuVgjcaoNXnMSrYECZlRZZe9CJx6zNdhw1Qok3GFQxxucJnaqf8bQohR7+OgXtEo+iwGOQzAnEdj4l2FXLh0wkdBJmejl4ffCJpzroquNz46Co51XDGJlHDp/Fur66ZFWPcubTEDDARI7QURy2lniBlK/0eJtg9imSSBmNT4LekHBvCKzmEDcrXBursHiS6ReGapoLaF1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=df/qAjj55YC/jJRYxOWoG6ZEJd+jitvYRXhL0HX3CJE=;
 b=vTia2YfYYSyFi2mNJ59/eIeu14Nq5WRJ59KOr9BGzTrrozoBY8C/xrwfyhkjDA0NlQOwlUP3Df3B9kS6vIi4XcEq0YG+NkmFU6twB86Ds/Rben67AEDUsDkiNcmPTf1wix/O7t0zLN8Hx7eWkeObaTUkgM08Q4gMoIYPzqn8a2J0mQ8PhwbsJKNAaMJgeBgobbL+4qh1NwU8wbwOF3K5h01AHzWNgkkqAUZoCcBDfop4ycVrax2SqaFq73gOZx02sAS3c9QDzxqqqUirzw0RU2JzmGYXyOnmDHAOV99TUTZd21MEDab2QzET2ZSZolUTVBJbumzTWdQ/9fSSVZUwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df/qAjj55YC/jJRYxOWoG6ZEJd+jitvYRXhL0HX3CJE=;
 b=HSWJGi2BsEGVfq6VflZZKTiBkS3AtVTnB1qlX2T3/ucTcRzRrcQoowgjexXewuipFdG90Dke7x5LAQ76uGhXCO9BK2P7raOjo6No7ZnGBWPwPouVLgBTSQqwHgxtDhAYfduLooRSarT7nTXrkmBq1J6s+oyZOy1YDvwILnBkriY=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA6PR10MB8134.namprd10.prod.outlook.com (2603:10b6:806:443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:03:12 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:03:11 +0000
Message-ID: <0d31010a-994f-444f-8c94-4316229db268@oracle.com>
Date: Mon, 15 Dec 2025 16:03:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
To: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        mykyta.yatsenko5@gmail.com, martin.lau@kernel.org, clm@meta.com
References: <20251215091730.1188790-3-alan.maguire@oracle.com>
 <d965ba27da4b59ef69f94b335575827debba459e27c86a10e63d5edeeb155e97@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <d965ba27da4b59ef69f94b335575827debba459e27c86a10e63d5edeeb155e97@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA6PR10MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a16af58-8f9c-4b86-4627-08de3bf3725d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SmhHWEViajYwYXdrK3FGa0d6WFNoVVNwbUd1NkNNKy9PVGpoZTlzZG1aS0lY?=
 =?utf-8?B?bUVHeldoWTluRUxQY25HTWpvZC9mejROcThuWEFjRG51VkpET3pwK1pqeFlh?=
 =?utf-8?B?eEQ4ZkNOQjc4ZFRnRXg4Z3J4TXVNZzNxSm5FRzA2dXdxeGZINmxaaTRFK1RG?=
 =?utf-8?B?dkdORExSd2szM0pYaFArT0RpZDBRWFNkbGpTN292ZHArdmkraXFTdmVITmNT?=
 =?utf-8?B?MlNEMCttT3ZYZUFFUHl0SER2bXJCVkxxUXgyZEJwa2VqanI4QlpXSXpMaFk0?=
 =?utf-8?B?Z2VyRDg0S3NRS3M1VTZPQm81ZWNlZkRnRE1yaGhGWXVrMytJVGR4MmZzTm5I?=
 =?utf-8?B?OEV0NlBSRGhhNXFMNjcvUDh4RlBUbHdWU0c2aDcwVlh2c21kRmhtNHlKUXZN?=
 =?utf-8?B?N0hEYmoxNmlsV2p0ejdZTUFJYmk4NFIyc1oyK3djMEwvbEVTTzVXRFlSL0JF?=
 =?utf-8?B?ZmRxdGdmK1pJK1o4dWVvaEtndzVRZ2p4dG5iSkdZVE1LcDRyc0ZIWlc1YzFa?=
 =?utf-8?B?MGlKMmNtSzY0b1BISGlzNzBFUXZYd1Z2cE1KNmY1Z2grV05VNFdpeFZ3dE9N?=
 =?utf-8?B?OWtESFlKVHlSdkZaQjZ2d2ZJcERnYTY1ZHgxUUZXVHJ1U2x3bWhHV2tiRUEz?=
 =?utf-8?B?ek9LK0x4SGRFdEFvdWV1NDNPck9jZXIzajNyOFlPZ2hsTEVaSjQ2UnRPdTU3?=
 =?utf-8?B?STc4Z21EZTRIckFIcEtyZFF6bm8za3ZwQWxsbUlERDBSUGJVUDUyaWlNQ1dQ?=
 =?utf-8?B?TmRGOTdpbjRTem1vMlF5Z3ZDOTdTbExpWnk2OHliK0NsdVJHZTFPUDYyYWYx?=
 =?utf-8?B?bVZyM2FqOW9HTmd5WWhCNVczWjcyK2FHZE9SZlEzb0I4Zm43UHpqR2lNMUlj?=
 =?utf-8?B?L1krWThqU0pVaHVqRWFkSnUyRDlsQXgzdnVwazBuTHdqSEtBREpkL21KQUMr?=
 =?utf-8?B?QXVmK05qdjFEZTAyNGFCUXZqaHpHWHVSVm1IaFNpM29HNTRNOXNSbGxTQXF4?=
 =?utf-8?B?YmJNcUZMYnl1V3VzdXNHdjZpcGIvQ09MM3JjN3F4eDJBMFRjeWc0L0ZxdTRR?=
 =?utf-8?B?d2tQWUV0Rno1QzlhdnRkdEhjcTJPWFRWRXIwaTdnVG45YnFxSkEvSlNTejJ4?=
 =?utf-8?B?dU54VTBES3dob3ErcmMxUmJ4SCtUb0FnV25taEhKa0VMZXMrZW1ERCsyQm5G?=
 =?utf-8?B?UGlJUXA5NFczQ3YrNkRXbzFCcUM2NmRBeUpUblNWMzRSdS91TVpUSTRTdStm?=
 =?utf-8?B?S0p4OUVJNlBNUUtEMmdseWpidDFsZjYrSDhUU1gzUXBXMmJxTFNvMXppNytL?=
 =?utf-8?B?Sjk0MmpNVWZqREhqU3A4eGNJRk5Fd3ZleXp1NVFUUzF0U3VNbTJHbEdScHNi?=
 =?utf-8?B?bTJ5bnUyK1A3UFhuZHZ2OHZDK3RodmdEQmZlU3o3WGQ5dXBDL0F1bzZzUWhI?=
 =?utf-8?B?Unl5VG40UUltZGhUOFBhcEsyRXZiMEdLYUV5Q25Bcm8xVkpjWk9tSU55eHdG?=
 =?utf-8?B?L3J4YzFCdU9Ga2tQTTZHU1BYcG1RMVVFeVZSUzZ3ZHBjM3BsRURhMG01Wnl4?=
 =?utf-8?B?Mk1tQmZUckpkMHN6ZURtVUszRlArTDVsYWgzNGxlV3FPRVkvdjkxNWM2dWxy?=
 =?utf-8?B?SGRKL2FtaDBEWGZWSncyTjhwY0Q5VzhrdzFzU2FYTTg4OU0vcU1MTGhEYURp?=
 =?utf-8?B?S3V4SzNTNE9OclQrN1h0QzRaMThOdk5OZ0E0amxrMUFTMC9LTk5SZXhVNzRa?=
 =?utf-8?B?U3Y0UkNTWUtwTkxjeGlzRk9FM0U5ektlMDd0Y2ZVMXFpaG1kQ2tVVUUxWU9O?=
 =?utf-8?B?MThvQmN3bVd4MnRIc29WOGNwN0tiTkhHcVZvSHlCODZFRWhUejY0WkNyMnFO?=
 =?utf-8?B?aGlmKzNqYkF0STZENnZxMXBHRjJFWjVJNVBGbU01dVhXZDZRZHIycExIV1NI?=
 =?utf-8?Q?KRhMnv/JXTft6emMIAhsdyAtnDR+PYW+?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?S3ZqWU5OYUpXU0ltTDEwOWQ5ZGNLNXloSUVmL1NrQlhnTnRycXQ2Vk1mYVBy?=
 =?utf-8?B?eEh0ODNUcEdUQjc5VnFZaHBweDRGYmI5ajRvaVpqWDRZYjZBNWhyWUdGT0Z0?=
 =?utf-8?B?NWZxelpmaXJVb1d2UFFOZi9zYWhjRU8rbUJiQ01aaUJtZmRJTHZ1UkJJME5M?=
 =?utf-8?B?V2tHQUFXVWdTVUx1WnBVMmNaOEdWSTVvSGdlSm5HWnkxZ2NFLzJTODZ2S2hD?=
 =?utf-8?B?WTVwSEdtWkhzLzhaMzA5SXZLdElXd241SFR3VS9sNVJFWTRLbDNWMWZuTnYy?=
 =?utf-8?B?bzc4YUVNVVA0VzFhL2VId1BsVTF5ZVoyVXZtOUkwM3NiWjdqQ2RIaEJyMFpo?=
 =?utf-8?B?YkdhOHhQbUhZV2R5eFNvMm1GeHFCK29idWxITlVYOUhuR3M0eDJWNWwzUFRm?=
 =?utf-8?B?djNRZVh3YWdIdEl2OFRDTU5HWEhkVVhNN0RtR1EvVDBHZDRrTTh1NlBrYldP?=
 =?utf-8?B?VGF2UUdVWVlSU2pzYzUybEVST2s1VGhQZ1FpbTB3T1VDUWU5aHE2dG1jZElk?=
 =?utf-8?B?S0NuVzRMU0o2TE12UVNNYU1KN2UyUWVuQi9PQ0V0YWVDUHFsTW5UOXdRc0dY?=
 =?utf-8?B?NVRsZ0pNTmJzOWFKREFxTjAyWk1NSm13R0VKUG94dm1iR08wcUEzL2J0SDUz?=
 =?utf-8?B?b2NLZGU3cktTVEFPTmFnOEx5Qmt2Z2lRbTZKRU9YdFh0SXVRTjhNNHo4VnJw?=
 =?utf-8?B?NGpMSUM2T3U4UWR3RG9JbXJXUm91UnNBTDF5VWJWaElTR1JhUkR3THZxNVdk?=
 =?utf-8?B?MnJRblc4QmFPM3RMakVSRUdSc2pxb01OdkR1dWFraWY5YnlIK21TMllxSGZy?=
 =?utf-8?B?NEplK0ROay9YMGFuSUJlMnBvV3ZOZnJiR2EreXhMNjN3bmdZcDdRekw5aUhX?=
 =?utf-8?B?cUNCaTg0dlp1Tm8rbk9Xc2RqektvdnAvZXk3S04wMjUvUEpKZzUveGZELzFy?=
 =?utf-8?B?MXBzYWtldzZHOElJZmZJcGdlUHFFUE5ONnE2M2w2SmM3OE8zZjZkdy9neTcx?=
 =?utf-8?B?aHgwZ1NvSGJ3RU5DalRhQW02cngyYjVXSjZpMDVPNzdKWkZDU1ZhbTI4V2FU?=
 =?utf-8?B?OFBRajRPM2lCRm9WYVZKdmJqak1XK05CTlkzM0ZBbCtUUzcxS3YwbGJjeHIv?=
 =?utf-8?B?NGJzZFJCSlA3NE5QZisxUmo1bGo4N3dQNU02SFZwdnhrMGFhSVV0a2dUU2pU?=
 =?utf-8?B?N3JhWU11L2E0amVoTWlUTm95MlZGSU9jd3YxSnRYUXZPOURHWWJWbTJGaEJx?=
 =?utf-8?B?dExwcUFUTmE5cnFyU0VYVCs1R2VCNDh6RUVIdkRHTzMwMHZ6YnExcndYMU9L?=
 =?utf-8?B?aFJ4RC9DaU4yUlE0RE9aaklibEVhY2pyQjlkc3lrcUNnbDVVcW5aczhmT3hR?=
 =?utf-8?B?aStOdjJZbHlRdjIyRkpTU2lmNS85RTJSdWwyc3VIVndRcWEzam45WDIrdzI0?=
 =?utf-8?B?ZDJ3ZlBHRlhiMW1IYnljTjNya2NmMGlUL3diUEhEZ3k1am43TU9zUTByRFpG?=
 =?utf-8?B?cmVXZkpveDhlNEI4QWRoamFuUk9wemN2R29pOTVGdzhwOWRQbXA4RDR6MEZE?=
 =?utf-8?B?TjNVNzUzbnhOMk9LNWx4N1ExdlNiUjFYSWNCTnVZL09hZGd2Q1lJdUVvdTl5?=
 =?utf-8?B?WmREZTZjM1VtTU9XN04rSjB3Snl3ZU9YelU4aGQ3aitkeCtVdzVEeEJ5b0Nk?=
 =?utf-8?B?c3VPYXFDU3lmWlJKRzNmUmZvNStDbXhNOHZRdGJmN2ViVGhDTVNQSU94anNv?=
 =?utf-8?B?OExCcCtZT05aQXNuakhHekIrTnliNkVsZHFYNnk3L0pZaGVjaHhDbUpaSnpO?=
 =?utf-8?B?SGxoa2Q4LzlmUklXQi9vZnRid2RFSU40NWZ2Y0luUXoyZU1qMFJHNjdDY0lh?=
 =?utf-8?B?VU5zaTRiNmZubEFWL3Nnc0h6dEpYb29sQlBoZ1ZuT3AzN05VRGxtOHJNS2lw?=
 =?utf-8?B?V3NiVVo4UEVWb3o0amJNUWVoSnQyalJLa0FnSjg3cjdneDZaYmtKU3R3emM1?=
 =?utf-8?B?QnVOQWl2d3JzTWw5WjhxZWpZVHQydUtmMWN1UExHUG8wUjM1L3Qwa3F5TStv?=
 =?utf-8?B?MEJMRlRSNUlwWm1taURmeExxV1d0dkk3dUpNcDBGcFRweTk1a3phcHF2Z3Ro?=
 =?utf-8?B?UCtGUGJ6QmN4V2crNFIvZldqYWFRQnhJRTcvazdUbzk1dWl3S00wUVQvbjVv?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vuxB3GCZtYae1ZDcPhVA2zMMxA7+Xxjb5DY5A1f1oShGN1vMLdKUgu3rCYmAgw4rJfh9R/TY9suNG2YuCZxinSp+8iqjXe26WXSIcvmyfB8KMhlAHFK7KvvMsQo8zBRJK0uoBKNxu0FRQeKs0Upkgsv+XAMYWYAVpB7r28sf0jraGCM0c1wkt2MfmHg6uFRBpdq9bgxWSzcTi4ZBnzDt733rCB3lZ7L6Te1vQ7qVacuqUXMcQYnwf9RV9T1ShyVIg1JJb47qRDPkLaDvXhZQICeWBGqcg1ybpqXLsJtSR52Xyrhlpa3S2Yzlgb6vaQ2xNDOadBs/bWS6Qci+aiY6/mb3TH7nve0Rg5bdiT1BVKF1PWPm3ipKMjC9MndAcOjvyDzz/cYFz36+J0Dx6eLUzv53Z9gXZszMCseVSSyNEsLCS+Vb00hhewb6I3QRiwWSqY3MJWvfGpSYElbRpgHMT88e4r41G5COnI+zzwtV9r6Jl31SnlK5xwCPrZ1sSFmgNgZHPUziahivzcKFu0M8Og8Gc6BLURQQ+20YkGyqE7dWflmUl7DwPHSMihilcqR8bC7komv38veQcffxYMjlo4nlwxS9isUSbxUPmOIB32A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a16af58-8f9c-4b86-4627-08de3bf3725d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:03:11.7539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dICM28LcgwgznnCuvxPLkgUdFGRxItUF2uf/lTJarumpdCfvzP/GFVZWNn/5/Xl8kh7zyevNNkgekxLlfsuXUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_03,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150139
X-Proofpoint-ORIG-GUID: 7PXF9rRbRB4z4zFKRx8j-VOLO6YrQkSw
X-Proofpoint-GUID: 7PXF9rRbRB4z4zFKRx8j-VOLO6YrQkSw
X-Authority-Analysis: v=2.4 cv=et/SD4pX c=1 sm=1 tr=0 ts=69403143 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=46_LeYnHjSuwuQiKq7EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDEzOSBTYWx0ZWRfXyxemREksMyjL
 g3eB0zt5rWclAROTH18OsZ1lFRIIxM3lntX9aRvRcaYn5kxFDHvPUDKqUStEMPu7IV3rUD0DpmC
 ZyJs08I7jpSJivqN4aWOEHKtqywWWgcWTJ9WDGvc7zyMfzT5M92yahlQf+Y/Cw8EGxIl2fnMjJI
 ECK7bN0OTdRfBqdwQq04FpxqLC8VIapHSJ8jXldJgvaUqbz3im8WLl5e+00I5XLWFCX+7KYYX/N
 O/knExzIMontPuH81SwD/cZtydEiErsR79mwqvo92UFhV3wVKLWK9TjTsR5ypYU68bRoCIBl2VJ
 La8A7px/Ej8foezg56xhBKugP1oR2xK5TGki2CdmVCqIaTMQyUMdlxgGT/IQBVDNMCrr8BPkLLS
 TZdG7BpR7I7/dPqCLtUnq+bjR5yHcg==

On 15/12/2025 09:38, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index b136572e889a..8835aee6ee84 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
> 
> [ ... ]
> 
>> @@ -214,7 +232,7 @@ static int btf_add_type_idx_entry(struct btf *btf, __u32 type_off)
>>  	return 0;
>>  }
>>
>> -static void btf_bswap_hdr(struct btf_header *h)
>> +static void btf_bswap_hdr(struct btf_header *h, __u32 hdr_len)
>>  {
>>  	h->magic = bswap_16(h->magic);
>>  	h->hdr_len = bswap_32(h->hdr_len);
>> @@ -222,54 +240,87 @@ static void btf_bswap_hdr(struct btf_header *h)
>>  	h->type_len = bswap_32(h->type_len);
>>  	h->str_off = bswap_32(h->str_off);
>>  	h->str_len = bswap_32(h->str_len);
>> +	/* May be operating on raw data with hdr_len that does not include below fields */
>> +	if (hdr_len >= sizeof(struct btf_header)) {
>> +		h->kind_layout_off = bswap_32(h->kind_layout_off);
>> +		h->kind_layout_len = bswap_32(h->kind_layout_len);
>> +	}
>>  }
>>
>>  static int btf_parse_hdr(struct btf *btf)
>>  {
>> -	struct btf_header *hdr = btf->hdr;
>> +	struct btf_header *hdr = btf->raw_data;
>> +	__u32 hdr_len = hdr->hdr_len;
>>  	__u32 meta_left;
>>
>> -	if (btf->raw_size < sizeof(struct btf_header)) {
>> +	if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
>>  		pr_debug("BTF header not found\n");
>>  		return -EINVAL;
>>  	}
>>
>>  	if (hdr->magic == bswap_16(BTF_MAGIC)) {
>>  		btf->swapped_endian = true;
>> -		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
>> +		hdr_len = bswap_32(hdr->hdr_len);
>> +		if (hdr_len < offsetofend(struct btf_header, str_len)) {
>>  			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
>> -				bswap_32(hdr->hdr_len));
>> +				hdr_len);
>>  			return -ENOTSUP;
>>  		}
>> -		btf_bswap_hdr(hdr);
>> +		btf_bswap_hdr(hdr, hdr_len);
>                        ^^^
> 
> Does this result in hdr->hdr_len being double-swapped? In the swapped
> endianness path, hdr_len is set to bswap_32(hdr->hdr_len) and then
> btf_bswap_hdr() is called, which does h->hdr_len = bswap_32(h->hdr_len)
> again. This means hdr->hdr_len in the structure ends up with its original
> (incorrect) endianness while the local hdr_len variable has the correct
> swapped value.
> 
> Later code then copies the incorrectly-swapped header into btf->hdr:
>

I don't think this is right. We do

	hdr_len = bswap_32(hdr->hdr_len);

and this will _return_ a bswapped value, but does not bswap hdr->hdr_len itself.
When we later bswap the header via btf_bswap_hdr(), we end up in a state where
both hdr_len and hdr->hdr_len will have the same (swapped once) value. If we
had 

	hdr->hdr_len = bswap_32(hdr->hdr_len);

...the concern would be valid. So AI wasn't far off here.
 
>>  	}
>>
>> -	if (btf->raw_size < hdr->hdr_len) {
>> +	if (btf->raw_size < hdr_len) {
>>  		pr_debug("BTF header len %u larger than data size %u\n",
>> -			 hdr->hdr_len, btf->raw_size);
>> +			 hdr_len, btf->raw_size);
>>  		return -EINVAL;
>>  	}
> 
> [ ... ]
> 
>> +	/* At this point, we have basic header information, so allocate btf->hdr */
>> +	btf->hdr = calloc(1, sizeof(struct btf_header));
>> +	if (!btf->hdr) {
>> +		pr_debug("BTF header allocation failed\n");
>> +		return -ENOMEM;
>> +	}
>> +	memcpy(btf->hdr, hdr, min((size_t)hdr_len, sizeof(struct btf_header)));
>                            ^^^
> 
> The memcpy copies from hdr, which contains the double-swapped (therefore
> incorrect) hdr_len field. So btf->hdr->hdr_len will have the wrong
> endianness when btf_parse_hdr() returns. This affects subsequent pointer
> arithmetic like:
> 
>     btf->types_data = btf->raw_data + btf->hdr->hdr_len + btf->hdr->type_off
> 
> causing types_data to point to the wrong location when loading BTF with
> non-native endianness.
>

AI has followed the chain of reasoning based on the non-existent byte-swap issue
above, so this isn't a concern either I believe.


