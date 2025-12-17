Return-Path: <bpf+bounces-76873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F7BCC8BD3
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CBC2305088D
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295B732C955;
	Wed, 17 Dec 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lQmXu1f9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HpxmUJc3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749233E371
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987612; cv=fail; b=nlXVOy1Or9Ro6zXtunOk30ZOsbgKiHFsywerdLszdJEwY+F62AFkSKSVa5bE0uYxsKcaVZ5w79nok4z8f5axST3sM04PDPynqkhTmEWnAlVjrEeWembL98MH6VTyfkDV54WNWa2szrpLQI2bOiIXtrjp/fHmR1wWoIvy8fXJdwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987612; c=relaxed/simple;
	bh=MyyJ5mOheciP3GfU03MEgSqr5YTMAB3JxpWod+VRQBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JMDAuQdNL0zCMXHU2/MBtj8OGbDk5RasJUy89/Xia0rwReGF1FM0CwL2XmOodDiLlpUMG3oOfIoRbjIJPe8Yn0KML+QZ1qe40zuHigyX4fYWJzkBvcJHa3yGf3x0Ft0Z03OidVcxP3wzDRrGBrik17SSGZio4XK7h+ssECVhft0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lQmXu1f9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HpxmUJc3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHFEEjR3066560;
	Wed, 17 Dec 2025 16:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Tgy4STLuAxIfk5sMPnwrPEzCJTDB26H7OGDqgb88wUs=; b=
	lQmXu1f9JpmnU1h5I2S3XBRfl8pJofEzErwCdph/4Zd7bstcVlB04LcUzFfk5lm5
	Yq0yEq0HPlsrTvdck6pODYBGGEE/0Vo/Ee0MfPsm2Y+3y0Z0TEUQ2k63aSdRN/vF
	ukeuArkRuURR1GpB2kw/Rr5pFxqCc3EYBf0Ah2xz9YZNMkJ0nLpYABIdIOvLNocz
	W7Ge1eDBdGxapAWWsCIrLLDQy7T6xa3LHveCUMMVGjh3tEDBxzeSgz1vcKVOjBAn
	Zhy84rR9zt5SwZvaVbVKOc0SFMLJ232fWZSwlPup0u7eMvSstkrVDyhZuhW8U98H
	oweWNE5L+783SRQJAeooFQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015x4ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 16:06:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHFb1Ux005925;
	Wed, 17 Dec 2025 16:06:20 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xker06k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 16:06:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaBMQ26AiMeJ37RTi8q7+nU9YIBFUkS+XEMRb9TtWItQgciLEL8erXbmyDQREW4NCae1fa4qZOyuMoH9pjMZ01fNX6vwA1K+q0kPaaRRY74G3rA34ItsC+ev9JyHmADiwAU5siJcRoY+watze0G3nsmi+8JLFJ/c/v1EDB8k605isnaRfbo0Ss4kelqr931FFHM1lIWSPT2j28F94zOcSu6MNx6xPsf0qb0ZuNgR6rs312licjpr4rXfbEYmuH3uKliVQCPPx8qgYaKeIQ+/AkUd8TzVe7ep8FJxQYD93DuU5byZyr2EXnho6/3wDlJX6NfJ/20fOfle2wHSb1yVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tgy4STLuAxIfk5sMPnwrPEzCJTDB26H7OGDqgb88wUs=;
 b=xjVEi4SXdeYT6Ep6lmupRKsvX41hUbErl1Uv5in+yba54L8q6CO0yv80x0Sue9s2SHqDyHUoiXBNWFg6C67D3SP3+3AjKtOu/j+EG7bD3ogVVQseYaFghMsZswTCGwKAha64lOiX3kBZLmg3eKpr2Hz1Q6c+QFZzrZkqtWi2rhIlTCz8lxy6ZtIj57HycRdSesDma5A5R7yEK/P71rXryCsQHUfJZxk2eVEO3hwZZPhhg5vf53bw0N1/oS/BCOVGJD0tPQQOcVdpBNouCg6juAAqwB4IwWueUziujYqmzoih/vp4ngsr4DRX+S0CnQLdlIAUUAohsiKtxq2k9qZfZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tgy4STLuAxIfk5sMPnwrPEzCJTDB26H7OGDqgb88wUs=;
 b=HpxmUJc35VYYty33mY43STkYHdsVMJpTt05nPTcNKZFurP4cK4+fmCauk3gws9NmQY0MaQchUZkPRlwRlvOnDGDM/sFUh07bAC+Ie/zDN2IvxUwCBrAmrdFOlhDeTXLKaKL2HntbCsqirbze51g5744E1ukTZHeh6jbDakazkPI=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BLAPR10MB5074.namprd10.prod.outlook.com (2603:10b6:208:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 16:06:15 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:06:15 +0000
Message-ID: <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com>
Date: Wed, 17 Dec 2025 16:06:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested
 structs for BTF dump
To: Eduard Zingerman <eddyz87@gmail.com>, qmo@kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
 <20251216171854.2291424-2-alan.maguire@oracle.com>
 <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0108.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::23) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BLAPR10MB5074:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9461e8-2ac5-44e2-e278-08de3d86348c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTN2UEswRVVaQzh5WmVZbEFRR3RGNm9BOEJYc3JucWs2dllydG5UVHdrakdT?=
 =?utf-8?B?YU8wVkNMZllrNVpVOGNrSlRYTHloRGVhcm4zSlV5UFlTdk92dm1kZHkrMGd3?=
 =?utf-8?B?UXdmZTkyekJJby9NbWFPajZYQ0VGdUxTZkUybWdqNHBVL2hwYjM3N2FwUUpp?=
 =?utf-8?B?Q3ZDYnZyZllYYzFhSFRpb1N1cDVkOUhMbXdmVVQ1YzlwU2VPdmkxSlRGUjd4?=
 =?utf-8?B?WUh2eUpuRmxIeHdoV1BCb2MwY3NlWGluR2hhQXRzU0hUdk5aNFlxTERnM3RH?=
 =?utf-8?B?RnZIbTBvcUttL0E2N1FtSi8xR3IzZVRibGR5dmY3YS91UGRFK29QQkdTUkp0?=
 =?utf-8?B?SytWU3g5T2JXVnJsNGNCejZoSU9tblRyMjZNenp2WWVpR1M5WkIwayt2Rndw?=
 =?utf-8?B?QlIzb2kvd1hpYjAwTzJZT3lIUVpFRkpOWmRkazJIdHNVZ0ZOTkxTMGZhK1lx?=
 =?utf-8?B?U0JKKzY4TnNRR0VXS2V3Z00zajZFaTl2Y21DNTkzNnhzVEN2UHRqV3lyMVhk?=
 =?utf-8?B?cWR0MmloMHNLcHZnRjl6OGNkRTdlNXhGRHFMWURSUHFNSEpIZEY3eDIwY3J1?=
 =?utf-8?B?KzdtdVdVbUlPWWRLV3NxUm54bVN5TUJMSWptUmdsSXRDNVRlM1l3YlRrQTdj?=
 =?utf-8?B?d09LWEozaitWVzBYdHI3QjZBNU1Zc0NTWlZma2t4ZC9CaXhGRFErQy9yTnhQ?=
 =?utf-8?B?QmFiOEgzNjRJOUM2NWRNVTZVV1pZMkJjNEk2am9KR3AwTjVPeVF6bnBhZGMw?=
 =?utf-8?B?Y3BURk5UN0NNMUZ1UjBpU2ZUajBvRlJzRzdIbzhWeTFOZ1U4YzNOdEhxR3FN?=
 =?utf-8?B?VXQyOWdsMzFQY2crOHlLVHBSY1d1QlR3ZVg3aEJZZWdrZlFQQTRtQ2w3V2V0?=
 =?utf-8?B?VHhUWkdCalpPWWE0dDRQTkh5b00zWUNwQlFHMS9OTXpvOHRrOTlTUEdZdllp?=
 =?utf-8?B?c2RuTnBLbjVKeVgzTmIwWDVOUzZ0RGp3SC9IMTdDbUthc0dtVzhaQ2lrT2dt?=
 =?utf-8?B?clprUHFQcVlTdGNJRmJ4SXNHSkNJV3pjQVl6a3pZQmxPSWhHc0ZabXZoM25u?=
 =?utf-8?B?anR6bnVIRy9neDViL1EvRUVzQ3J6YjU5d2p3QnFTQ3lZemoyeDkzbmQvbWpx?=
 =?utf-8?B?RXhKa2hjOU5ubC9xT1BId29uMW9nb0swTGJ5WUNuUUJYNHZjZjFLV2MrT2M3?=
 =?utf-8?B?Q3NIN1VNM1ZLaTZySTBHampySEhvUGxndTBRUlBDQkE2Sk0yNU01THFtdmJJ?=
 =?utf-8?B?dzJrN3ZoREc3amNtZk5ESzhXUnpaMGtjYTVNcUpNUzB0aGhqSjljNzA0Unla?=
 =?utf-8?B?NDZvNmZCbVVRSHBPUDYxdFNiU0VubWJaWkEzcEVTOFF5WDBFQ1piTWd1YlBP?=
 =?utf-8?B?RnlRL0N1eVIwbmJxTUk3WnRPMVlDa2N6bXpSVytoSlFpdDhrSjVUSElER0VR?=
 =?utf-8?B?OFJWL1FqQ0NpK25xVmlucnF4WThrQm9DUlNIUi9YY3Jwd3BqYXlTdEpKY044?=
 =?utf-8?B?d0QyWU1VcllCN045RWR3S1o2Vmpqcy92ZHZZcDJZd1hzTnZEc3huelhUMkQw?=
 =?utf-8?B?ZkwvZG4wUHYxRjhTMUNBbktYWXNKQk01UTUwbkhqTXpjY1lBTGxKSmd6VXZ3?=
 =?utf-8?B?WHR2UmplU1RZVzh1STByRW1DRTljNitYYUFoYXlvWG95UWlmd2I3QU9DKzdQ?=
 =?utf-8?B?NmZFbWVySHh5YTY0QUFacVltbVArWHN3Z20rZzBMb2JRMVB2NVM0dUNwU3Y5?=
 =?utf-8?B?blFUcmdHcDByT1hCQnVNSktSZ25yWEMxZm1uRDYxb2hrN0p1MWRkSXhnZUxW?=
 =?utf-8?B?bmcwSllaNVRyWmlGRVJEemV5N25MRThhTjB2eXh0cUJ0blM1WlI0eWo0UVly?=
 =?utf-8?B?dHFZVi8rRGpXSFNNRDRreUFTWUY4dWhUOVlFMzJwcEJHbThqOWg2bEMzUjI3?=
 =?utf-8?Q?Em4SUJIa51B0VsGoz3tdNqKR9oIvHWGp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUZBY2s2S2JWQkg1b0ozYm12NU1EY2RZR1JPTEVRVlFXTnpoMEFTMW1yUW9T?=
 =?utf-8?B?a1loa3dQcTV0SENqd2hRQ2ROZHhMWVR0R2UrM2tvaWNiYWduaHhrZ0VGcitD?=
 =?utf-8?B?VDA4eE9uQ04yOUxZOXJTR3c3bUdwclFNbGFCcXJBZzlUeTlOYkpaNXltTUEz?=
 =?utf-8?B?ZUhIUXJ5MURPWjJ6c2ttd1dqQktDWjdUdXNnYWNncHVnNldGZHFmOEtYektU?=
 =?utf-8?B?MkVjdFJjbDFaWVBHMk1Bblk2ekVWRlJ6aEFlWGNsZHJlNzl1ZGdiclAwQzNr?=
 =?utf-8?B?Mm4yV2VPbyt4amR4RzY4QmQ0bkJXRUczSTZKeTJzb2o5WGxpeUNWWmRmUFBN?=
 =?utf-8?B?dDc1Rk12bjJoWllGRTVBSGk5UnN0cGI3Z05RSHIwQzRkQlZ3a1BKK3FZN3F0?=
 =?utf-8?B?Tmc3b3F6YmVBNlhmTTVWc2srVW9la3BFQ3dHVTFVKzNmN3Z5TWoxTlNtQmYy?=
 =?utf-8?B?NmQ0d3BOOVhYUFlsamRoajRvbEZNTmVLT1ZRRmdqS0ZFNHZtUFRuSEJiNUp0?=
 =?utf-8?B?RmFSMFpiMTAyblNyZkJsQW53ZVpuUjE4MzZQbTZYZWFFUTVUNUkxeXNocTc4?=
 =?utf-8?B?OHBUU2p3YWpZbWpuTlZISkdyc0FxUExyanBBV3czb3oxT2NhNjZwUWFNV3lY?=
 =?utf-8?B?czRwdlBBdFhGbWpxOWZJWlV1VEFRTzg5Z3VDaUFoVndkS1hmaXFOSGtWelZm?=
 =?utf-8?B?Z0dVRm5wVkVpNysxaytuTUIzY0REMU1qVTl5aXplVFM2ZFF5M0V6OCtqOTlB?=
 =?utf-8?B?c1g4Z25zaS9DeTFvVGlQR2p0UTZ1Q0x6RFNOWWJGaEh2Z0lhU3dLSS9ZSVNI?=
 =?utf-8?B?ck13WlorRnBqTCtTL1B6dElsSmxHWGNDM0lmWElzQ2FseTh0cUR0ZTNEWmww?=
 =?utf-8?B?MjRPakhEbUVDNDJDcXMyZHpIWi95SUdQWkl1Lzh5WmJIQXNILzM1YW5iMGpZ?=
 =?utf-8?B?VXZnWmZzRHQrMHl2TzZFNnRLWTRuR1FpTkN2WmFJanpaRXA4Y05qbUo2VnBp?=
 =?utf-8?B?TkRnU2loaGNqNDcrS2ZhYXBIcDZ0V1dtdUExVmN2NkNsT1ZPZVlmOWdiV08v?=
 =?utf-8?B?ckdRQkZ5bGJvQ2RKN1A4QlhYeFpESXJvV3ByRkJGaDBpT3VKcWR2U3BRNkdL?=
 =?utf-8?B?azZydngwNlpTNVdGZk9PMW9UeXhJSjAwM2UvRFNiQnZORnZ1UXpiMEduK1U5?=
 =?utf-8?B?QXBkbzFBbjdlcE0wRE1kRjNvd1BlV29VWm4ySU8xS2U4T08yY0NDWkxKNTJs?=
 =?utf-8?B?VXFyaHFrdUFZNGhEeVhJT29hQVVodmVJNEg3Q2Q0LzRBSGtxRllEa0txeThT?=
 =?utf-8?B?WngvQUYvZUVNWGZkdVg2clh5bVVjZ056UzRwU0I0MElwdkJwYjBwNHk5ZVhD?=
 =?utf-8?B?eDlwcG0yaFpPRHdzaVZVSmV2aWFCWW9ORWxKckNGNFo5d2FaTGtIbmJHVFlH?=
 =?utf-8?B?c29OdEF1dVlqbkE1SGdtTHdlUW1DNnlvbDN6bHplKzcwS1cxdE1CSmc1alJY?=
 =?utf-8?B?T2w4dUdERldqNk1iN3NCdGl3dEduZ0lDeHFGcGtNejIzQmluaENsYlB5VTJP?=
 =?utf-8?B?NVNmZGQrMEIza1hpNWtSQ1doZVhxZERzaVpSVVJ1TW9rYmJic2FLc0JQRHpm?=
 =?utf-8?B?Qk9rYkNZTFBlQXMzY0Y5SEpkMWRPbXVZd1kyVDVsaEZ1U1hwV3N4THFSZi95?=
 =?utf-8?B?MmFrM2V6WVZuQmVjTlkvZUtwbU5MWW54Z3ZaQnRFN0pTMG5PbXRTazk5MmI3?=
 =?utf-8?B?SFZlK2xHeXpoTC9YWVVVV0wzaWhkMGZiczRSRnE2cCtHTUhRWG10MkNtMDBN?=
 =?utf-8?B?SXFZdHRISjlkOVNhWTBtU0RteER6a2grSkVkV3pFa1lBeE9nSmQ1U3g5WEpB?=
 =?utf-8?B?dDlYaVQ0V1A0NEUxSkZuYW1TQXhzbDdSdEYrVmJrVEw5eFkzZDQwZ2dpN2Nz?=
 =?utf-8?B?cFJqK09EV1UrdDk4NENhQW44Z1p3M3U1cGNUNnFtQzZKODVwWGp4Z1UwUEVX?=
 =?utf-8?B?RjgxbHF0RVhvdzdCcHgwaEdDa2hOWGVLR1ZaN0V6dE51TFpDS0ZBRTJwZUZl?=
 =?utf-8?B?V1VXcjA4WWZKdUZObmh2NHJyRFFVWFpvU1Iwd1FjYVVNNFErd281UVdDL3Z3?=
 =?utf-8?B?N3FLVjM3VFJWOVMyOUZmenVMMW1PdEdxdFIzbjZucUs3WGtOL0FXQVZzeThC?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BQD6u4+uQwZmjC4Y+zbT/qaWzGUf+nf2o8muvsy8HzNsdxLPmrdu8dBNPvFPE5ItIrJUhmDw2rbgMAC+ogXfmnivWxHaKK6oQMChakkhBjwrYtyPXh2olC5nkCpqPKdjMjXrKILIbFu3BsdNEUVneeVFJDiF4BaXMYtKIw25nCXgfFAXnhyzbgH7fQoxUqLGlD1IuBQREbGkjt8nTg1+lPS7tvIlwIqTyPe40jQf7Ckq+rgcM2B41NsalMfHexJjZZHhSLjvjLdWwBObkXv2jdPXCIItTKd+7Wn+99lCyRNnnX2+gDFpcxH+xJjDNL6ADrjEf4S5+voBJmdZhtoHx2bmMJE5IwciKQnG15OcAkiKBYr2k+cX3BNvn9g0w+hkqwpynQsY9E+A8ChELiTidbB3xyCKuo51KLEQXNIH6+zhrjHPxjnkSGc+H1+ahMupV63/qvxt/+YfkFfcadTvy1LoYmiJynGgyktEV5fRsGD5geq7rzEgJIpriRqE3f+Z7xHAjiJnbVQStLWUgjklzlQjzzZ07xjIdZgqRXLpep+r9Y5rvRTQ9thkT1TmagEzheLwkRAIfGis0hpZoSOZ+IgC0M4teORExEiohe1/iEo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9461e8-2ac5-44e2-e278-08de3d86348c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:06:15.2262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rm9oT+DiV/tWgpQL7SZHOI+QQDRv7rxqC691z7cT8NHk1O1aZAlrjFzTdvflmQNebfZkSexJspKQBI+C5lV8HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170127
X-Proofpoint-GUID: hZkBxeuHLN4bt7bMNpGEz4nQxqDBqaLZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyNyBTYWx0ZWRfX2HIDT3PYEVSo
 m0uF48CoSxdkCMTr0DJNbXxmLTmvgu358MYZ3kpauSbnOMsT16juGQn6oVfbSFQpw39YqEGLkzK
 VIJdQuLKYDaaiYbFpn0WcX+q7vR1qowgxXXRL0x+SzmMnJatvK/b6kVDlQTAILCA+MP3qKxcdgb
 SKWLuHlVicHI4vxiGj8kSjvd6T3TAbZP4uCQvTzqdPg3uAVuOT9eSJ55yJ8XETSp8DhCjaXLfbK
 nRWxcMHGrxKuXw5zIYogIJx92oEmTt2f0ngBkvq0Y0HtzO9VclbydVq+DcAe3/O7flh5jFrTHRH
 ZnshprR+RyiZv9/rCCHk/h2gQpLz9091i3F0qgDjbmq7GpyVSN3SqhwzZojYrP5tggwptQVWolu
 7Neswso4UI6GHmbeXy+sz8CIYfvhCIfXwkALsaB8DD75jT8OG6Q=
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=6942d4fd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l8Ku8qELuHu5LGIEG-wA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: hZkBxeuHLN4bt7bMNpGEz4nQxqDBqaLZ

On 16/12/2025 19:46, Eduard Zingerman wrote:
> On Tue, 2025-12-16 at 11:00 -0800, Eduard Zingerman wrote:
>> On Tue, 2025-12-16 at 17:18 +0000, Alan Maguire wrote:
>>
>> [...]
>>
>>> @@ -1460,10 +1466,16 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
>>>  		case BTF_KIND_UNION:
>>>  			btf_dump_emit_mods(d, decls);
>>>  			/* inline anonymous struct/union */
>>> -			if (t->name_off == 0 && !d->skip_anon_defs)
>>> +			if (t->name_off == 0 && !d->skip_anon_defs) {
>>>  				btf_dump_emit_struct_def(d, id, t, lvl);
>>> -			else
>>> +			} else if (decls->cnt == 0 && !fname[0] && d->force_anon_struct_members) {
>>> +				/* anonymize nested struct and emit it */
>>> +				btf_dump_set_anon_type(d, id, true);
>>> +				btf_dump_emit_struct_def(d, id, t, lvl);
>>> +				btf_dump_set_anon_type(d, id, false);
>>
>>
>> Hi Alan,
>>
>> I think this is a solid idea.
>>
>> It seems to me that with current implementation there would be a
>> trouble in the following scenario:
>>
>>   struct foo { struct foo *ptr; };
>>   struct bar {
>>     struct foo;
>>   }
>>
>> Because state for 'foo' will be anonymize == true at the moment when
>> 'ptr' field is printed.
>>
>> Maybe pass a direct parameter to btf_dump_emit_struct_def()?
> 
> Digging a bit more into this, here are a couple of weird examples:
> 
>   $ cat ~/tmp/ms-ext-test.c
>   struct foo {
>     struct foo *ptr;
>   };
> 
>   struct bar {
>     struct foo;
>   };
> 
>   struct bar root;
>   $ gcc -g -c -o ~/tmp/ms-ext-test.o ~/tmp/ms-ext-test.c
>   $ pahole -J ~/tmp/ms-ext-test.o
>   $ bpftool btf dump file ~/tmp/ms-ext-test.o format c
>   #ifndef __VMLINUX_H__
>   #define __VMLINUX_H__
> 
>   #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
>   #pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
>   #endif
> 
>   #ifndef __ksym
>   #define __ksym __attribute__((section(".ksyms")))
>   #endif
> 
>   #ifndef __weak
>   #define __weak __attribute__((weak))
>   #endif
> 
>   #ifndef __bpf_fastcall
>   #if __has_attribute(bpf_fastcall)
>   #define __bpf_fastcall __attribute__((bpf_fastcall))
>   #else
>   #define __bpf_fastcall
>   #endif
>   #endif
> 
>   struct foo {
>   	struct foo *ptr;
>   };
> 
> 
>   /* BPF kfuncs */
>   #ifndef BPF_NO_KFUNC_PROTOTYPES
>   #endif
> 
>   #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
>   #pragma clang attribute pop
>   #endif
> 
>   #endif /* __VMLINUX_H__ */
> 
> 
>   $ cat ~/tmp/ms-ext-test.c
>   struct foo {
>     struct foo *ptr;
>   };
> 
>   struct bar {
>     struct foo;
>     int a;
>   };
> 
>   struct bar root;
>   $ cgcc -fms-extensions -g -c -o ~/tmp/ms-ext-test.o ~/tmp/ms-ext-test.c
>   $ pahole -J ~/tmp/ms-ext-test.o
>   $ tools/bpf/bpftool/bpftool btf dump file ~/tmp/ms-ext-test.o format c
>   #ifndef __VMLINUX_H__
>   #define __VMLINUX_H__
> 
>   #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
>   #pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
>   #endif
> 
>   #ifndef __ksym
>   #define __ksym __attribute__((section(".ksyms")))
>   #endif
> 
>   #ifndef __weak
>   #define __weak __attribute__((weak))
>   #endif
> 
>   #ifndef __bpf_fastcall
>   #if __has_attribute(bpf_fastcall)
>   #define __bpf_fastcall __attribute__((bpf_fastcall))
>   #else
>   #define __bpf_fastcall
>   #endif
>   #endif
> 
>   struct foo {
>   	struct foo *ptr;
>   };
> 
>   struct bar {
>   	struct  {
>   		struct  *ptr;
>   	};
>   	int a;
>   };
> 
> 
>   /* BPF kfuncs */
>   #ifndef BPF_NO_KFUNC_PROTOTYPES
>   #endif
> 
>   #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
>   #pragma clang attribute pop
>   #endif
> 
>   #endif /* __VMLINUX_H__ */
> 

Ack to all suggestions; in particular handling both cases with #ifdef is really nice since
it does away with the need for libbpf/bpftool options. With that in place - along with passing 
parameters rather than setting field values, and being more selective to ensure we only emit
the #ifdef/#else/#endif for a composite type nested in a composite type - the above
gives us the following:

struct foo {
	struct foo *ptr;
};

struct bar {
	
#ifdef __MS_EXTENSIONS__
	struct foo;
#else
	struct {
		struct foo *ptr;
	};
#endif

	int a;
};

I think that's the format we want. 

With respect to the padding behaviour, I may be missing something but I'm not sure these changes
will impact that. We pad in two cases:

1. between struct fields, where the current offset is less than the member offset or we have
alignment requirements to be met.
2. at the end of the struct, to pad it out the the size/alignment requirements.

I don't see anything different here for the case where we force-anonymize-inline the struct; 
it still does 1 and 2 identical with the out-of-line declaration. To test this I augmented
Eduard's example to add internal and whole struct alignment requirements: 

struct foo {
    struct foo *ptr;
    char __attribute__((__aligned__(16))) s;
    int t;
} __attribute__((__aligned__(64)));

struct bar {
    struct foo;
    int a;
};

struct bar root;

int main(int argc, char *argv[])
{
        struct bar *r = (struct bar *)argv[0];
}

$ gcc -fms-extensions -g -c -o /tmp/ms-ext-test.o /tmp/ms-ext-test.c 
$ pahole -J /tmp/ms-ext-test.o
$ bpftool btf dump file /tmp/ms-ext-test.o format c

struct foo {
	struct foo *ptr;
	long: 64;
	char s;
	int t;
	long: 64;
	long: 64;
	long: 64;
	long: 64;
	long: 64;
};

struct bar {
	
#ifdef __MS_EXTENSIONS__
	struct foo;
#else
	struct {
		struct foo *ptr;
		long: 64;
		char s;
		int t;
		long: 64;
		long: 64;
		long: 64;
		long: 64;
		long: 64;
	};
#endif

	int a;
	long: 64;
	long: 64;
	long: 64;
	long: 64;
	long: 64;
	long: 64;
	long: 64;
};

This looks equivalent to me, but there may some other condition you're thinking
of here?

Thanks!

Alan

