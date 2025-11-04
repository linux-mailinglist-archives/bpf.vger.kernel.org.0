Return-Path: <bpf+bounces-73500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C93C32FD9
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 22:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF35A18C3C0E
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 21:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BDB2F066D;
	Tue,  4 Nov 2025 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D30IqQ7E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qm+WTy9s"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3B2F7475;
	Tue,  4 Nov 2025 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762290008; cv=fail; b=tUHVw8PtYIbP/vymRjZLu/H/C/Zo/ZLUh07Lv7lMWtoNWcN25IE6xyrAKe2gf24DnTp0BJT0+NHdbjjcpyGs9Fpty9PUsZ+Z6LEp/VHSlCyN5W/DZiqpoF7YbxhHWJRnKdpOv99VUOGzjSIyhbsn8fv7yeXH+T8ZrHfrX4tRK0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762290008; c=relaxed/simple;
	bh=ysszQSHNYs567gZ66PeDHcHU0hiqFxOIGtGWT9PvFrk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPMl7Yv3qVXUAJTq21Qlwe81AhVejyLCDneOuWl4GDfS8px4O+pywh4scOWP3qANbKtJ0kxey3s8JF8U4+l5ZdrP6bgaMTjHNt859mcgmP900aF+i/xMmF0wxO8eQ7Uy2NCfDcX547+n6dquwA2pykxDPxMH11YUETHGv3k2hkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D30IqQ7E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qm+WTy9s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4KsdTj013121;
	Tue, 4 Nov 2025 21:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fIm5906G3gxJ9Mp7oVObc5BPahhVO7azKQZJyD9E2Ks=; b=
	D30IqQ7EbXuQ3bVsT5B+NnB/ds/hbCgHkxOBQwIc0dvJbHfgndlgZEPAvoZdmDL0
	yQYMrY8xtM7/Km/WXgAOgOUfBxs7gswErzP33WX4fvelnuJzwvfxuYBOe6fvc0QW
	8s6XtOMmbCIMNnWiDo3RJ5Baxkm3tSUREOCU/YzzX0BpWf4PtBuehdYqhudIlPX1
	C9w4OUzRA/FI9TGZ3r5WV0EaBIot5qpVhOPVGNxHSXwS+Q2RJrw9jhKWZG2j4POT
	63QsMqXHgPwQgpISDUztquwha2vfHapJ5/eeVwbsSzfUUvYwivUZ3egetUeY9h48
	QOPfpehglLbeHOId0RJIEg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7rxe80nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 20:59:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4KH1bB024876;
	Tue, 4 Nov 2025 20:59:56 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ndp9sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 20:59:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=id/xkNqqLuC+PN8vGVNqNVuIE99vs9f3Kqxlx5+K0PfUZXcrevrZsaZJ2+XVHZDtUTFpd5Y3wznH0qyTV3jq7jXdrOApgPhyjVFQ7z8nE6BAGd5qWPNcDow679Q8RRX3+qrqxMreThh8tnySPTfeIvmLS8fq18kCa4mpoHK5c+Uc46RDRduQfZubre1GWvUTbDbyqlc58QBvKRL5G/PmrwQJlTS06eP6tBHIOOQdhM+KcO915eLICZkM9NCd/+PrjVOmq9P0MdpMmpElALuH58emeOlFWWz1sBWF1akT69NfPJ+dkeIwCwe+Kvti4r+s+ogTjZ/kOLPIVIkL9kaN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIm5906G3gxJ9Mp7oVObc5BPahhVO7azKQZJyD9E2Ks=;
 b=f6/NTVyww4iUxUyDwwYJAGwmqeICycC2VD6usn10td/xdXRDkmLm6o20rxGo4dmo++87ATIJB0ehUmYCuyRR/vJAyFSnB/0U7aN+huzQjktBF4L8/7Wa+4aTclcB+aOZ4rT0SWm9LbqWhb9cJ+Cei6anDMr+iBecoTKHhRQa8EYwU4k94ScR+pQ+qStCpkmd/7o8cobTNFPzoVTVUGWQJseMUjSdXad4m/GgHpXzOiBFehpXr9MZIvKrssCyFpFmJhnHUwWTUZ4TleEW0SRz4+9TH9PbmDQcs9hhf6umDjjT4I37rnauxcWCRY63BAQYzDvBoK7cRhIMDCGm+UaGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIm5906G3gxJ9Mp7oVObc5BPahhVO7azKQZJyD9E2Ks=;
 b=Qm+WTy9sFKyf/pO8dUEsNInFKiMC8do2I/xrtA4ih4RJeyWfKEEwhcI9tlStXr84POhMh3ZgTJK6nXLSW6Q1uzC+SmMl3wflYoGlu5k/ckShV+IWgBGsNaIXDyxCMwSXEtPXxSSOLJCSb7K3wIB12DaDlibfrCDEjZ3oj72YnPI=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SN4PR10MB5655.namprd10.prod.outlook.com (2603:10b6:806:20e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Tue, 4 Nov 2025 20:59:53 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 20:59:52 +0000
Message-ID: <517837f0-127e-42bc-83f4-2c85203ef468@oracle.com>
Date: Tue, 4 Nov 2025 20:59:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v1 0/3] btf_encoder: support for BPF magic kernel
 functions
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        acme@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com,
        tj@kernel.org, kernel-team@meta.com
References: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0324.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::14) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SN4PR10MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f831f5-2537-40a0-63cc-08de1be5195d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THZSc0RsN0Y4NkxESEEzTDhrN2I5U1Z0ZFZTWndoY3lxelRsMlc5SW5HMGNL?=
 =?utf-8?B?cHdUWGNFcEpLMmV0L053emgxdGttV29BbjVPT3JsMC9uaDdvaTY0ZC92TEhj?=
 =?utf-8?B?ck0vYTlIR0NDQnlLK25UbnZjK1dmL25PRU96VzA0NVZUREEvTkx6dXpKUllI?=
 =?utf-8?B?WkhhejNIRDBRQ0JmVEdHV3BPVlNLdlREalYyeGNjMGgzc3Fabjk1cmZVTGg0?=
 =?utf-8?B?T0ppeHc4a2gwOCt4Z2xaQSsrKzBEY210bUlselRNNUI3NHBMR0NXQzBYS3V4?=
 =?utf-8?B?Z1A0SEJra25EdHN5M2dpYnhibVBQZ2xhY0VnbkNBVkJlYTRRUWRsWkZmU0RN?=
 =?utf-8?B?U2hkR2FBb0REOVVtVENTN3ZNS081SktnbysvR00zS1p4SGx5MUN3MmNCdTky?=
 =?utf-8?B?cGdlR2k4Ni9UR3dhQThSeDFNbHJ6YVVSZk5PWkRTbEt2UXJWZTFzNkxYTG93?=
 =?utf-8?B?RnpHNHlCcGNnTDMwRmNJN1ZJMmY4d0JXaW8zQitIaUdtaGRxcUZsNkJ0MVc3?=
 =?utf-8?B?R2FUTlpwYXVtLzhvNXZzaENPVlo4L0FqblB3UzZEekF1aWVKOU9KZkpqZWRu?=
 =?utf-8?B?UkN6WjlwbTBCcENJTXl3MUJ3MXVMSkxhS0JsZW5TTUt2VGFYYTQrN2JGa2Zy?=
 =?utf-8?B?L2dzM250VGE3SWZiNjZkc3hJdkdML0xCVUQvaGx0azB3UlVPb3lLZ1VXL3dH?=
 =?utf-8?B?VHAzenNUbDV6SnRqeWJCMzUrQVhqTHlQTTBhTlViZHZWNHlCNjMvYVdEZFMy?=
 =?utf-8?B?T3lhTE9LUHEybGtQdGRmZDY4blE3R3hTMlptdGxTVXVMOHQ4Zk8vUGwxMm5j?=
 =?utf-8?B?WHpqNENkb0lyVHZISG5QVytyOEdwbDVldTl5Q1VyRUZHYTQ2b1c2dW1UanlG?=
 =?utf-8?B?MVdoWVRsNWtZdzV5bERqMGYyTFgwdFpqdWpuQWYrT254ZVJYcUVEd1pjRURN?=
 =?utf-8?B?b2lrL3o0M3Q1aHBqOEVHK0ovTDYxRjlsc1luN3VGZHpmYkNVQXVBSksweHVH?=
 =?utf-8?B?K3VYZEd2NVFSbno5Vk82L3lGTDRkaVoyYWN4WWpIZTY3eSs3cE1MV0NFbFZB?=
 =?utf-8?B?RnJnNHBjelpUaXFqNVhWdkRaZldMY2hDREhsa2JIM1UwditPWDNaS3RoRUlk?=
 =?utf-8?B?MmFtek5lTzNEQ2NZakhWZHBlWHhYN0RaMStEM2ZWU1VEN0owM0xUVFlHd2V1?=
 =?utf-8?B?NS9FeW5GM3NJTkxHU3hoSlRVbkI0R25rd1p2bkdISmNjVTFGSHJXcjU4STJF?=
 =?utf-8?B?cE5jZUlLd28wcVMyenJ1Yy9qU2RiUkNDRXdhWWZYdUx6RHFsWUVzM2lOK0sx?=
 =?utf-8?B?ZGZJVXd1WnNPcHRSNW0xYXZiZmplc1d1ZFF2WW5pYWQ2OEU3SW5LVzVzRFVa?=
 =?utf-8?B?Y3FiVHF4U2tXQ0JPUEp0c0FpcVVFRmlValkwbEFsZkhFeDRiYXR0YVRDL1VI?=
 =?utf-8?B?RGp1anhRT1V5WjBmT3pjZm9XWFpuV1hJT3ZsYlRSeWdWOHhnbEcrdTZuOVFj?=
 =?utf-8?B?cE44NUZoc0RuYi9Bc3JrR25yQ1IzV25tOFJwOGRWbXZUMmcybWRHTEhHa0hP?=
 =?utf-8?B?UHRLTE5GenIvV2YycDAwcFNYQ1pjRFpNNXhqOWNTckpOa29ZT2k2Qm1iK1NJ?=
 =?utf-8?B?NjhXS0xBVmhrd0tncEdIVVVodjZLRHJBanRibUNFOHR1QXJBSlJWTjM4ZDZ6?=
 =?utf-8?B?Rlc0ZVNOaWFFTHlyQkcvTG9MOFZpd1pIa1dKUDBFRVBUT09Za1J6dW9KQnpY?=
 =?utf-8?B?ejN5VGFvR3F1bGQ0RElYSHFBSnVTUm05ZXNlV3VYWk5iTElrL3U2OXJ2ZEpn?=
 =?utf-8?B?NTJ5T0tFdkc4eG5KMlVyUytrRlpsNis1YUJta29rY0FncHUxMFh1aDdteWVP?=
 =?utf-8?B?V1Yyb0tNd09aMVFwK1NlRmZTTlBIY3ZSTHJEc1JKVGxXUFhWTy9OOFUzWjB3?=
 =?utf-8?B?S2dZQ0l2RVlwdm1rcXJ1OTJUeitRQW5CdnBtUmxNUjBjUVlvMXgyQlBtWW8z?=
 =?utf-8?B?MzFNdjRNaWF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkdqdTdsa2hjaUlzQmtrVitEeEhkR2JxdjlkUHhiMC9yREV1bXRGT0RubWdt?=
 =?utf-8?B?OEg4MUx6ay96eklYdklQOXY4bVRKNDRxbEZDdHVBWjdWMHZyajE4SExnN1NC?=
 =?utf-8?B?Q1MxYXM4SEtYSjQ1Nk1Fdk1xTFprb3B4Z1hhaVFKNWd5aERFNzlPdlFJS0tB?=
 =?utf-8?B?akpMdXFuZFI3OGpkTnZ4SnAveVhVWHM2MkRoYmc0cjZWeGliRUpDc00yTkpa?=
 =?utf-8?B?Uk1VZ0lJcWJxbUxxREVuMVl1R3I3eVI3b3FPeXhHaWJiNEZkR0ZKbDQ1Z2h1?=
 =?utf-8?B?RnpmRG1MRS9XenJWS3NxMlVXQ3Y0ZjZLUjJ5RkkrbndHbit0aGNqMHRuU2Nx?=
 =?utf-8?B?dlNheVErVnZ0SXpxNS9iMkx5bHZYeTJRSzZyaHFIbFlOcXhhcnhIbU0xOXpm?=
 =?utf-8?B?N3BNQTB2eFlRN2lCbEtWb0lmNHFLVzJ6UkdhYmx3cHpKTzBVTW1qRUVIc3NP?=
 =?utf-8?B?VXRHY2NySGtLdkNkS0hqOHM3Y3ErL0FtWDRiUm5OaUJiWmk4UkJnSmUyNFVW?=
 =?utf-8?B?bWJYQTllWTFvZk9zd0U5cnJpb1FaRzZXeklqYjdKeENyY2lqQ2ZudXA1N2Fr?=
 =?utf-8?B?dEZlejZ0ZDhWWWdGWDY1dW5TaUVvT0FmWExZQzdhdENxOFo1djdKTjIwN3Ew?=
 =?utf-8?B?cUl6ZDdPbWlYaXNhZDZOb3F5SG1SQlJmeGRxczhFVDRZZ05NbUwxSnpYMjh0?=
 =?utf-8?B?VFpwNk12MC9DY2NlZzZOSEpEVXpsZVZHLzhZQ3ZuRmhleVBBc05SZXFUY3Ny?=
 =?utf-8?B?dDhNVXdKY2pTNlJVZERtVU9OcTBEMDBjeXE5cVg5bjEwRVMxN0djZWhuUSt6?=
 =?utf-8?B?Z0ZHeHd0SEhvaXpwRDZuakF2RFVCL25pRDhXN2dXTDJwRm9OZEFlZ1BieVM2?=
 =?utf-8?B?VFZ0aXF6YTg3anRNdUNYMWlvSE1pUEpYSFVsK3JaV2w2TDRFMjNoSGc3T0N4?=
 =?utf-8?B?Tk9jUmNpTkJZb01yOUt2WWU4MzFGcG5RZVdKellkWGhSNkIxSFljYjh6Zitj?=
 =?utf-8?B?N0Fhd1R1b2kwMVNBclBuWVZVSG5PQlVTSjRBLy94OWw2djFPVlE2YXA3cnF1?=
 =?utf-8?B?OHhGUGJ1b3Q3azNWUVU4QmM2ei9Lc2huNmNQdWV3Mjg4RmdEVXU2Y0FCd2Nn?=
 =?utf-8?B?eGhCb01zUlhnbGVBdFc0ZlU2QTRKUEpzZWkrUldvaXVKYlk4SVBsaElqamEy?=
 =?utf-8?B?ZUQ3RldDcDcxV2owRTNuM3ZPbHNKVHhjdnkzS1RDSkJZaEtvZmVxbnI3SDJn?=
 =?utf-8?B?SVhEUFlDTWdzTTRITHU1akVYUXIyTHFnYmZmMUNzOFVkMUtqb1NaZWVCalgy?=
 =?utf-8?B?d2xlb1RlK2FJSW80bDczQmpBaVdZZWJEMFh2RTBoQnEvT1p4Y1gxY2pnL3BC?=
 =?utf-8?B?MmFuakd3NnRITUQwc0t4MXQ3VUxpUkV2aG9TTkkrOGhFYnI0aHc4ekRMcHYw?=
 =?utf-8?B?UnVFNExmMnJ0UUxjMC9aN25yZFd4WlE3dWl6V1pLOUtzQ0tGelBDcGtuNGJl?=
 =?utf-8?B?ckljRDBvbytEbUcwTTZDVHZuUUJYR2VyUEdjSlZnV25Tb0YwcFBXdVRTNWhE?=
 =?utf-8?B?MEFwQVpML29GWnlCYlpQVkdLTTU3bVJjRFVYZVlSMDViaTFXZjdFNDhwb1NX?=
 =?utf-8?B?dEpzZmxmOXdBc1MrVUJ0cTRKbzFLQU96QVdGazRzczBKMVhlclFuU1pFNXF0?=
 =?utf-8?B?SnNWY3VwMytWNkpVQm9LVTM2OUVSck1RT0dxNm5IWlV5ZU5yeEhWR3RuNDBw?=
 =?utf-8?B?OUhaY09aaUJwV2tVMXRuMkhpUXhyekhsMmRMQzNMK1k3b1d6dEs2bTYvYUdG?=
 =?utf-8?B?UGoxbyttejkzeHVkdC9OZ2JMTU83T1p0Y2VySXVGZE53ZDE1YzBIUVhsMk5s?=
 =?utf-8?B?ZjFOeFhCN1pLcHVNSEQ3UDI2YitDSmE4MldMTTVlTytPRGFmRlBESHcwS3h0?=
 =?utf-8?B?eXBjWFJqUWxmTitSKzNTSFpGLzVjMWxkUWVnTnRRUGIyTkl5dkYxdWl3c1Fo?=
 =?utf-8?B?cDZnRmtRVVFtRS9uQmhmZFd4T0NOR2ttZFFyYk53VWlxRFJ5WHRyVFQwT1Rz?=
 =?utf-8?B?NXU0aXZGZFhRZ1ZOV2ZEWW1VbzFFQWZ5NWhuS0sxTXVjQ2pUaWhuOG1UdHB4?=
 =?utf-8?B?L3RhNzB0ckVrbVIya2hyVUhCNnNRMGE1RzRNRXVEZDNwYXJ3SUk3MlFZcUFl?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZCFSstL4o9GPqLe1HRo8wYK294YJ924+IUbbHnann6jL+mQdGoi70fb1ih3r201eSa8GxN8w1I8PGyen+5OAQgWtah0LvrwqiLRWzphUdpFspG5uldq4XEgDPP7/LVBhOJdbU+ymG2+cPvq/Rw05Vt3rl92MR9dP/mGBgK8kS5K2vD2WpdWEyki61Cq6YK8KiDpjGvQnPW9ie5t5/op16s+3jh7F5O6aSf2+ENL9zOP5kp5F6v56RUVfq/nPcKd2lmzKUxpoH4Y6WGwfH4sKPFQtvSGFMdz/YIADIzBc30uLXXmcZlRJOV60KapFAW5OfZaH72ptu5RG9mNLCcSY9um2bG3C/UIYua6uLqsdAjQk9haqRsKUaZHIK9tX6Lo3Q6poj8/d6MeprSt9Alm3rJ4hEGP2IpMlxuft4ux6cM0d336UMVxjhSZVaFbGS/KRnw9kWUbF7dr+JRTeP6LEimVi5q6jG38zzPn1PCrB4mV+kJUP5qXpExOfwPQuPRVNlW6IRzZdUYKteaN7huT1SuwMvVjASPF1bJ2E4QXnCueZkxSxQvU91xG6qqk4Vl9GxSOZKcfC82JNDAuEbqyyrZxBrWUybzEyW9wqpLMswsU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f831f5-2537-40a0-63cc-08de1be5195d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 20:59:52.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BngU6jj2pJmNi7c2rhjkZgFdCJBF/zolNH+hPHm/dR9zd6aFAvNNyKulcdymdlSZ4HAkC4CHE6MDVKCiV+84VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040176
X-Proofpoint-ORIG-GUID: a3OWFDo_rG8VOziBKq6KANY2zdgDbsI9
X-Proofpoint-GUID: a3OWFDo_rG8VOziBKq6KANY2zdgDbsI9
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=690a694f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=561dzMQWqIwYm4v6GN4A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13657
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE3NiBTYWx0ZWRfX2fCJ5aqKDOjR
 dwBgCwTSVMQiINb+AZmLxVO5FI4H/iPC10Qq2hvlm6D8h5my6ZQ9sZKTn45H6Lq60XDO1WFDyLW
 UoE5NnQikLtM5dlzQ1yneD6LRIN98tm/Vxq7N+08XG0k+ZdLgCM9whgaa0LGXmawkkNyPNyMC80
 T5ZjWACX+684fbEovxr27rPOA+nIwRHnxlTrYHpcQRLcxPcaUnETz3F42cwX1FTJnGA4AKi80zx
 PUSWSsiUl24UYy7jyUzpA4fIoe3QtwHs+i4N0TMZPI5FPmeLLc7D7QnugvgXAVJbsaWrW9PDldZ
 7F+Xd6HWeTXoGDqkLRutnYFguL2bPv7qLTbResiBMk0dzXXCBJPkA6Ik5WFPNdv3WdZTX1Oo93k
 WJbPET7Z3L2pEACRzdMjHCQLczuOO4w2AzB4coCWvcpieGTBZJs=

On 29/10/2025 19:02, Ihor Solodrai wrote:
> This series implements BTF encoding of BPF kernel functions marked
> with KF_MAGIC_ARGS flag in pahole.
> 
> The kfunc flag indicates that the arguments of a kfunc with __magic
> suffix are implicitly set by the verifier, and so pahole must emit two
> functions to BTF:
>   * kfunc_impl() with the arguments matching kernel declaration
>   * kfunc() with __magic arguments omitted
> 
> For more details see relevant patch series for BPF:
> "bpf: magic kernel functions"
> 
> This series is built upon KF_IMPLICIT_PROG_AUX_ARG support [1],
> although the approach changed signifcantly to call it a v2.
> 
> [1] https://lore.kernel.org/dwarves/20250924211512.1287298-1-ihor.solodrai@linux.dev/
> 
> Ihor Solodrai (3):
>   btf_encoder: refactor btf_encoder__add_func_proto
>   btf_encoder: factor out btf_encoder__add_bpf_kfunc()
>   btf_encoder: support kfuncs with KF_MAGIC_ARGS flag
> 
>  btf_encoder.c | 292 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 222 insertions(+), 70 deletions(-)
> 

seems like we could potentially pull in patches 1 and 2 as cleanups
prior to handling the KF_MAGIC/IMPLICIT change; would that be worthwhile?

Thanks!

Alan

