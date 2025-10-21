Return-Path: <bpf+bounces-71599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C99BF7E46
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC1819C6110
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3011F3557F5;
	Tue, 21 Oct 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IfOPt2cj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iPhzSr4M"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D433557EF;
	Tue, 21 Oct 2025 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067517; cv=fail; b=n8K0YtR9ctx+DPQbnC/qt4CL7sLVKbp3zPrTj6WMRVwpizA4jITKzmssC6pJHoBpaUeNV5K18yipAHi+C5eny0y9wX/UBAYM7cipEXWzjhtYeTAz2YxKxdsv2bjTKLyQFTJ6qaeq7y+iI6AvNSBH1YXJUKv7FeGYF832zPHHf8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067517; c=relaxed/simple;
	bh=2pdHDIJ1zcFhMaRx7Ilpl+LRbLfUbfvVGug3Hf/zVHo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JTs0dOHG761lRRNY5sCdbqtkkp1ia9SBTzNA3PMX4CdmH3Wb1RMPUd5JzvRCsbtq4QRiDSfvb15epnekhEyj9qzzcZYpp6fSvm+BajFyRmXNEXKmZ1FHr/MwgN3gfSdpgKDF6aSE+LN3tjlZR6HN38sCAYiBDmujkRGl5iW47Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IfOPt2cj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iPhzSr4M; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LHNrJ6031128;
	Tue, 21 Oct 2025 17:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HEgvjeHilucHqfXIuOISVWVnRLcnVqZmE7NurwPzO28=; b=
	IfOPt2cjDVfnR6Lf8nfk/P0pBQuL8ZzoYaKVtCU1HxM7PG/vrqmSqZqlWBzsMG/b
	we1mKXSf9kNpiOj2HddoVjpajfnHkfFkXmA03Ko0P4AgvoIN14w4NeXn+38mN82W
	9NG5Rv9RpZlN5BNzBAq3bxucGBc1/d52kPP3UffKhWrLMtJreKL6Jr7KJae5Ek/U
	bszvMjSf2UBKDGnxpcy6ps8ds7G1+MmU2nhLAbQOv8JAUeiC4cQyaFDCv3DVPqoQ
	SgcTTDdcFQAfyGxgyYHeZ1bF/8gpbCeHhkoZGfhF9tr+rr2Npjif3yW2+Z/drMsT
	zHDf1aUsQN/TUrXubOrYWg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2ypx7cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 17:25:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LGRSMt013933;
	Tue, 21 Oct 2025 17:25:08 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bc4715-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 17:25:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8Ma9duk0dYUOvejKZNl4h+qKkRY4Nxrbb3ETQBbBmCwyTjVKUdtMFUsaK/VkwSEN+v+zl801sTpOJWQ/9xu4eYZKj44KhKjjt8xDaPJxD9sv4QWDIpWoU0SD5dybaPoNOKkewluHCZj/uI5EH+30Od7+JHfnrpkAzlrp3zwEMKsVPYefM28AuQEm+rB3dgv22A2VkwFmfjtwpglHaQwYo2JfKEDribHdqPexAVh62njX0KMxegtI2j8MP12YmRjVyjsXJGxoXg8uetwKGG1vjSbClb7PSKljc66X9dz1gm9kEVwrRWvMFwHx0VZrlL0KghoDWT4m7iewmssfYcQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEgvjeHilucHqfXIuOISVWVnRLcnVqZmE7NurwPzO28=;
 b=IT67HbHbW+2Vdxly2hm5SrLp7mOcS4khzJzw50dTKJLFfBShthpclkoc3Tg3jNoNIQ+khr8doa1Z466oI4SzfMR79hKwupuuzyGu9Ab0cfvHXzWh5SBOLWfM8riGxA6Z4BFplk/ws2m0AY+XDjmnjupIcdnNvdCGbmRIlVP7vAayAitoEEfYtbs4LtlY60p0xd7VpYScq8wTAkSkRKMZUjSKev8RtB5WXmzot+ql56aIp/0MOjEwG2/3msDK5ejgdmKC4NGnhjVw+sA8g3RPM0zvT8blfAMKzWmm0VgLaH4qsqqGAjKD27J4DLO611iJC35GFBmLMxmoe0kuX9ThlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEgvjeHilucHqfXIuOISVWVnRLcnVqZmE7NurwPzO28=;
 b=iPhzSr4M4qncemciqFBTkvD9s+9J2VNBQzuepMVyPLJfWkEocxZ0IJv7i9odnrSv87GwJg7FatsvEoQLyoGvNqGLfQR+UGpBmkaibRSotmY9edG1KEu3RqjN9tLWtuVSoEDL4xyw8h0JIAjcoSe+8oq/l9sGHoibBpVK7VRqFfA=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BN0PR10MB5175.namprd10.prod.outlook.com (2603:10b6:408:115::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Tue, 21 Oct 2025 17:25:05 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 17:25:04 +0000
Message-ID: <34a168e2-204d-47e2-9923-82d8ad645273@oracle.com>
Date: Tue, 21 Oct 2025 18:24:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-3-dolinux.peng@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20251020093941.548058-3-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::7) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BN0PR10MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 59500d05-182b-4543-9323-08de10c6c582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk9ENEZhSHBjYklXeXZqaU1wbldSeWhudC9aZzE4UzlpZDVWYlFpelhWUWNZ?=
 =?utf-8?B?NkdEQmdHTHJFSThxeXR6M3pXNUFyRW8xaG5aVThIL2thL05jYmlOY3dHR1FD?=
 =?utf-8?B?clpZNkxhNFQzQU9nT1pQV29qVHBYWmhLT0crdEo5NitrV3Z4dkZGc2E5SGVX?=
 =?utf-8?B?VWVJbGZTajdraVh1S3ZyUFhUeStEYVdQd1NUbm5ZYmtPQXMwMTcyMUZ4SmhM?=
 =?utf-8?B?Q0lsT1U1cjZ5RzdRQkZHUVVPYzVNNjQrWXpPZUtPMjRFN2g3V01xckN3K1hF?=
 =?utf-8?B?N2xrNklXMUJFMGdaaC9GVW5GREt5Yk5KVmYxRS9mOXJjY3RncHJUWjhueEE3?=
 =?utf-8?B?UEtXNmpvUXF1QUlZcjZVenhWOFIvOWRvNVpPSEN2TjMrUlBzV1c2K2ZTSVYz?=
 =?utf-8?B?eHhxNVdPb0N2Rk8veW1ieXN5MWlNbzdKSGgwSmFzVTFkZFExQXc3RWJ0YjVh?=
 =?utf-8?B?Zy9QZTRBUlBQUHRZQmphM0RZd3FHL0VqcG4wUC9iQ0lVZjNQS051d3lGZnBD?=
 =?utf-8?B?a3NHeVhWeHdKMXJ0Vm8xcUtvK3ArSEp1aFJGRE9zQUI3TUowdUZZZzBKcUNx?=
 =?utf-8?B?NHM5UXZYUFFiV2lXSW1BanhxendQb3I4QzhOM0RIT1cvL2gwQUhCMDU5UFhS?=
 =?utf-8?B?ZnVTK2hON1hEQzNXMlJaZjR4bkRPR2tmRFhJQjZOTEdsWTFMZ3FFVkkzSFE3?=
 =?utf-8?B?dWZnRXFVdWc3ajNYVVhyN0YwblY1dWZSeXV6REp3eStFZURuUWpWVWZDTkVT?=
 =?utf-8?B?cVAvMU9GclErRU1VTC91enNkOWc4NzgxY1psMWtHeUZPRzdvdElaR2lobXN1?=
 =?utf-8?B?MHF6dnREd1UycDZ0V3cwQlQ4MFVteldEdG1VU1N1V0pZUHQrbmZnQ3F4NFdl?=
 =?utf-8?B?NnRlZmE5VG94ZDRERUNlZDFUQVZYd3ptMDU0aTBGWWVhaXB4MUl1cHN0Y0pr?=
 =?utf-8?B?THlXUjF5VFA2VDhOQkhyajArVDlxeHJLU3IxaXFXUTJDa0tHd3dOejNYVnZj?=
 =?utf-8?B?cFgrUWM3SlFyZkZOVGdldjZPNkFzOGhQODRvak5NbCtEY3VvdVN2WDZKV3NY?=
 =?utf-8?B?UFF1a0orMzlteFpxVkdhQTNJS2N2VVRiY3lielNKQUYwVm5yaFpzSktFYnl0?=
 =?utf-8?B?WHhWeGZVN0JKU091aWt4RVo3MkF6c0hRRThVZWNjMGViUEZSWVFDN3FXc1l4?=
 =?utf-8?B?ZzJRbjhsdzU2OFUzMmFleHc2Q2hmdWlCZnIxSnpnMjdrYWtnU2RRdzJyT2Z5?=
 =?utf-8?B?a3RnTXIyaUdha1REaURZODNTYmxmM2hVamFLbEVvaWYydGxwUWhoNWI1WlBT?=
 =?utf-8?B?VGdFWHYyTEwzZG9RMDlZcHZWQ1JBbG5ScnZuMUcrS1ZHc1JETm5JQVBwUjZz?=
 =?utf-8?B?N3pwVnFQc2ZJYi9hM1FWM3dJMnNNOThjRlF1SldmanJIVnZBU1FhcGRPZlh3?=
 =?utf-8?B?VHZ0aWwzVThxWk5XRnFqYk5EZXNHc1hyYnpLMVY0R3h2dTdmelExdllBQVNz?=
 =?utf-8?B?Vjg0OFBIT3ZadG5jUTkzUWdESkNyWmlOQlhicXJtSUlYamR1b0lETWRCcjM4?=
 =?utf-8?B?ZkczZFZKSENTWmsvZjVHSXZicGJNWk5ZVVhvUWpRRDlFeEdiME1Qdk1TajhI?=
 =?utf-8?B?emxsL3RBMExpcTlHM21RdDI1RzVDcy90cWc1dEFpaDdOR0tjT3VXNE4yNW5I?=
 =?utf-8?B?cDBacEN4SCtVZW9XcXUwR1V1UXlHYm0wQ044cHFFMXBpdC9IR1NkZHAvQU5h?=
 =?utf-8?B?RnVSQyt6Z2RZcUEydHdQemRKQ1hTaXpXMWZWT1JZWW5rdTZhbVlaVHlvWFVT?=
 =?utf-8?B?bXRHM2lNbng2eHNlUUhWWm1hSDZpcVRmc0s0SCtXVWRYWTVidSs0RnluWkdu?=
 =?utf-8?B?dXIvbTR5NklBcG9SQ3ZpenB4OXRyb00zb2xlbks3cmtwbHFzeU1FV0N4STJN?=
 =?utf-8?Q?nsHUTLruaJBBzRg0f859hnv2GNGw1hVh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVlYamh2d2h0VjlueHNBYldKV0U0OHVnSHZmUVZuSGx5WnM0OVhnZzFmSjRC?=
 =?utf-8?B?WlVFYXd3MFEyN0tjYnJnM0R1Tmx3MmRNeUNoK3pNL29CdFNnaFUxUE9Gb3BZ?=
 =?utf-8?B?Yy9YMFpJdHFqck54ZDRlSUdjbWtRR2l1eUo5M2FueU9kcFFmUjJmY2RnNUo3?=
 =?utf-8?B?MUJiZEFmNHV6ZVovYkpWd3hlSm8zZ3R3NzcvNVNyNG5yVjVlaXpzN3E3QkVH?=
 =?utf-8?B?aUJ5QTlqTTFPNmtrS094M3l4RGJPdndQa3ozb2o0NlJHNUJOSzhyMk8xZFd1?=
 =?utf-8?B?a3I1KzRGTjVYRHVhMUM0dEFNbS9KeWxoc3cxKzJLZXd1Qk5VU21vbkpoTWth?=
 =?utf-8?B?T2hsQnNrTW9zak52eXhNOE10OXFEMkltZ2xhSDR5bnp5TmpNd3hsZ2dlL2Ez?=
 =?utf-8?B?ckRqaDZxcXVYQkVFTEJkazd0eTlEdXZ0R2U3aDhUdXROdXcxclpCZjkvaWhw?=
 =?utf-8?B?dk1Hd3VRbHdQUEFTSUhqU3BPd3NuVWhzQUhVMHVZYzQ5U1ZDeFNwQjc4aU02?=
 =?utf-8?B?SHNESUFtZFZXcmpyZVVnVXErRk9EWU1rcUpnQ05lR3NyNGRrMEltclNBb0lI?=
 =?utf-8?B?TXZEMEhGN1VCZTh0VXFMT2JHQ1Z2eHluMmdMaFRhQzMxeE1LbHZGWEdTczdv?=
 =?utf-8?B?QlZmQWorSHU0RWk0Tk43aUF1Q2lwelNKRjk0Vi9pV1NpQ1NFaUQxZWNudWIz?=
 =?utf-8?B?dzVUQ0NmOTJjZk9tZWc3RXdLMXphdit5b3kvbzc5Zi9xaGZ0UFlBdjFNK0h0?=
 =?utf-8?B?WGNmclZ4QitCU1BGSVgyWTFKWEZpNDdGZHA0UXA2L08xenpIa2FyaU1MRC9y?=
 =?utf-8?B?OHU0UGw2OG02Ni8yRUowQTZldkYrVTFLRENkTWhablh1N0xTcnVRUjhYM0lF?=
 =?utf-8?B?VStGOG1CYTcrRWNrZHlnQVQzcklnaTlNVEovc1U1d0pQWE9leDlYdUFpQ3or?=
 =?utf-8?B?WTBQKytVQ1ZRK3BIN3Z0QnF2cmFPQjlLZjRmTXArZC9mTjZYMm1BUnJoMTZv?=
 =?utf-8?B?Q09TQUJkWGx5VlV5NWoySFFiWHlPRUt4amgyQ3VHMzBPaC95VzJSd0tKNnNh?=
 =?utf-8?B?MGNJK2pjNllWL3NQVFA1Q2wyUHZxaU5TcWRGQjlVdjloSHVpSHZQUlZqWlQ2?=
 =?utf-8?B?c3Y5em1OV1UwcDBWSkxxMDFuTU9SZHd5Z3VvazVpazg3ZG5CVWtzWExhVmg3?=
 =?utf-8?B?ZWsyNHJPOXBHRWRIQ3hrOE1nUnFzOHN4cEZ6SHBHMkdmNWNFT0VQZksrNndG?=
 =?utf-8?B?eUUxMU9VVW5KanptUE5RUVZEUXVPYzNXZjd2QnVzRXlZdGZseGV6eE0wMkZa?=
 =?utf-8?B?dmZTcnVCdXVjNHgwTTRNT2xlblQwaFg0azh6a0NPbHh2Z1M0OCtHNFVjSTdD?=
 =?utf-8?B?ck9HZzlkY2k4ZmxMVTZxcUJLT0VERDAraGFVTEs4MjUvR1psUlBqQ1ByY1Bl?=
 =?utf-8?B?a2N5UTNyd1JnSG0yR09MSVdvMXRiT3NVOEVyZllHdEl0MUdJZzlMbFpHY3I0?=
 =?utf-8?B?aThObjVZUURLSGRBdjE4MFFYK2lRRm5nSFdpbXl5bFljakJZdmo0dlB4bUJC?=
 =?utf-8?B?ZXgzeVd1bjlmWlgrbjdneFQvTVlDMVRxd1F1ZXlmL2p1TjQ0S0lqYWMrWjZ4?=
 =?utf-8?B?cnd0aVJteHRaRnBRRVdEeWRab1lIc3ZiSXZBTUg2K1NESzRKUUlxSzhURzcy?=
 =?utf-8?B?ei9rVGJlVG03dFhwbjZueGkvN3MzMkUvbXRBWTdsdFhmVTRWejV0dGJtQnlC?=
 =?utf-8?B?U2NBK0FJdm9JWTNWU1JIS2FBeU1lZnJVU2lycGZFaTZwR0RyeTc4R05YbHhv?=
 =?utf-8?B?a1ZaWldXcXNKbkh0emF0RmNZMTg1dXQvUmUrSXZJZllsTDVvRitrcE95QktT?=
 =?utf-8?B?Y2VHSytRcWNJYkdhd1IyOUdOdXJvQkc4Q3F1bFNYODJJM0ExNktNRE5vWjlJ?=
 =?utf-8?B?TEpPaWJRM0EvYlNpMk0rdk9PdlN2dU80Z2ZxbW9HVEJqeVZJZUc4eTh2TFI0?=
 =?utf-8?B?V25PcFpOZjB2OS9nTFBsVzR1R3dXWU1KZWdoUFRaVnBSYjRWS2dERU42SkVL?=
 =?utf-8?B?TUhhcHFXZmt4YlM0anBpQXFJVFFURHl4RmhGQ1lPb21FSmNtaEJGdGhlQmRR?=
 =?utf-8?B?SWNEZmFKWGhVNGN4eG5NeGt4QktsOHBGdXR3Y0pCZ2Jna0txNjQvOVA4d2FW?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	53HAyr1GYexwCdvdY/E02/JR5i+hY2cNjX27pFDUhZkkAJRd7Rf46IbrM3TRk4XcZzglQabRSfXEn4CFdU3CHotZCrJy1NCP69UbeiaeDfWWPU1iII9MOO0ePmQLZZHR0v5WkUHEjMZH102DVbY9N+sySI97hWu9738hc0abT+ab03gyX1MQrMDSTy+7rQ8BJJmVkbNdWpWdfCA362QiXnLO67gu3riU7k5cGByazRCXWjI0O7rxU0qREJg4b0twKgxQTda+G6AWvcUfbahVTm0Gw1/huqEvtRWsRgOsUBp70XNEKfVj0Ck5SuDZqa1Y75fLAUN7Kefu9Cn5xRwjESikmHT6pzszMfQNnKXjbgk3MoWSBMwCEuvm3LkzHkIujiDdOavj2hSB+LFUFnA3EbsJT1f2LL/ojmHr0qNL8UmCCS4pSS70IBkVric3jRVpzqA5KI77bq9UMom8doHfSlAL2Wov7OoZf77/8VIVM+dAMO+l1uxzjVNuiovExYAee/LwAZB7wIQjtjUJgRNrvcUD6uhXgdoWrRXmQ2KtlQh2zlJoJMYvshFgmN8BLothfMAmgsRNONYIDYcYCTbBnu6RwMBDVxb27eTx+laVLfA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59500d05-182b-4543-9323-08de10c6c582
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 17:25:03.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohbG5c5Q20uFEjsFMDXwvTT7lpJBiMmjhdAkHEZMqcny7HMH59LifK3PYTx5DZRDLGQRw2z2Ru2eQd4+MPuuQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210138
X-Proofpoint-GUID: T7V1A0tqOrN1p_tTuMqTpPi3DMGS6atI
X-Proofpoint-ORIG-GUID: T7V1A0tqOrN1p_tTuMqTpPi3DMGS6atI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXyC0p6KPvfc94
 5uhylCjeMybbjQ5fFfKRh182aPeFWveMdIq7q4m+N+vAwe9o26Yamk4FIri/WzzLOAc3B+4MMx6
 v4W3ZvmkQ4AZ6IxKFIUkSoFtL+Sr4vkbLKUf9A1s7pn/n/6xY87ZvJqkj4hcYDIsADYOh/3gT1A
 /Z+I0JSJpxib6n54tmMpV+0VRmj/hGz/tjRZ0Zgy/RU5vqmvC6SElu4pOAchL3TB+bmzS5GmYEA
 RqNFcFSdgTd3KdLXdq6Yo5bnQWs5OHu9A16RgGFd3v24q+rEYc4oKARx4uaKr1Nl/iPbkRJPxmU
 XVNS+i0nejfzADXOtFRGqC6RFb+D01zSrM00ZWjHBGZC9QICmZhvHSB7M/sDZTMsHVJJYLItZYa
 QoMWee06XYCfv+jlbdJY+Ag5GvdQRQ==
X-Authority-Analysis: v=2.4 cv=Nu7cssdJ c=1 sm=1 tr=0 ts=68f7c1f5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=IeNN-m2dAAAA:8
 a=gBK7DRcwFtJHOkTDbr4A:9 a=QEXdDO2ut3YA:10

On 20/10/2025 10:39, Donglin Peng wrote:
> This patch implements sorting of BTF types by their kind and name,
> enabling the use of binary search for type lookups.
> 
> To share logic between kernel and libbpf, a new btf_sort.c file is
> introduced containing common sorting functionality.
> 
> The sorting is performed during btf__dedup() when the new
> sort_by_kind_name option in btf_dedup_opts is enabled.
> 
> For vmlinux and kernel module BTF, btf_check_sorted() verifies
> whether the types are sorted and binary search can be used.
>

this looks great! one thing that might make libbpf integration easier
though (and Andrii can probably best answer if it's actually a problem)
- would it be possible to separate the libbpf and non-libbpf parts here;
i.e have a patch that adds the libbpf stuff first, then re-use it in a
separate patch for kernel sorting?

> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>  include/linux/btf.h             |  20 +++-
>  kernel/bpf/Makefile             |   1 +
>  kernel/bpf/btf.c                |  39 ++++----
>  kernel/bpf/btf_sort.c           |   2 +
>  tools/lib/bpf/Build             |   2 +-
>  tools/lib/bpf/btf.c             | 163 +++++++++++++++++++++++++++-----
>  tools/lib/bpf/btf.h             |   2 +
>  tools/lib/bpf/btf_sort.c        | 159 +++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf_internal.h |   6 ++
>  9 files changed, 347 insertions(+), 47 deletions(-)
>  create mode 100644 kernel/bpf/btf_sort.c
>  create mode 100644 tools/lib/bpf/btf_sort.c
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index ddc53a7ac7cd..c6fe5e689ab9 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -221,7 +221,10 @@ bool btf_is_vmlinux(const struct btf *btf);
>  struct module *btf_try_get_module(const struct btf *btf);
>  u32 btf_nr_types(const struct btf *btf);
>  u32 btf_type_cnt(const struct btf *btf);
> -struct btf *btf_base_btf(const struct btf *btf);
> +u32 btf_start_id(const struct btf *btf);
> +u32 btf_nr_sorted_types(const struct btf *btf);
> +void btf_set_nr_sorted_types(struct btf *btf, u32 nr);
> +struct btf* btf_base_btf(const struct btf *btf);
>  bool btf_type_is_i32(const struct btf_type *t);
>  bool btf_type_is_i64(const struct btf_type *t);
>  bool btf_type_is_primitive(const struct btf_type *t);
> @@ -595,6 +598,10 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
>  bool btf_types_are_same(const struct btf *btf1, u32 id1,
>  			const struct btf *btf2, u32 id2);
>  int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, int arg_idx);
> +int btf_compare_type_kinds_names(const void *a, const void *b, void *priv);
> +s32 find_btf_by_name_kind(const struct btf *btf, int start_id, const char *type_name,
> +			  u32 kind);
> +void btf_check_sorted(struct btf *btf, int start_id);
>  
>  static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
>  {
> @@ -683,5 +690,16 @@ static inline int btf_check_iter_arg(struct btf *btf, const struct btf_type *fun
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int btf_compare_type_kinds_names(const void *a, const void *b, void *priv)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline s32 find_btf_by_name_kind(const struct btf *btf, int start_id, const char *type_name,
> +			  u32 kind)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline void btf_check_sorted(struct btf *btf, int start_id);
> +{}
>  #endif
>  #endif
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 7fd0badfacb1..c9d8f986c7e1 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
>  ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
>  obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
>  endif
> +obj-$(CONFIG_BPF_SYSCALL) += btf_sort.o
>  
>  CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index c414cf37e1bd..11b05f4eb07d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -259,6 +259,7 @@ struct btf {
>  	void *nohdr_data;
>  	struct btf_header hdr;
>  	u32 nr_types; /* includes VOID for base BTF */
> +	u32 nr_sorted_types;
>  	u32 types_size;
>  	u32 data_size;
>  	refcount_t refcnt;
> @@ -544,33 +545,29 @@ u32 btf_nr_types(const struct btf *btf)
>  	return total;
>  }
>  
> -u32 btf_type_cnt(const struct btf *btf)
> +u32 btf_start_id(const struct btf *btf)
>  {
> -	return btf->start_id + btf->nr_types;
> +	return btf->start_id;
>  }
>  
> -s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
> +u32 btf_nr_sorted_types(const struct btf *btf)
>  {
> -	const struct btf_type *t;
> -	const char *tname;
> -	u32 i, total;
> -
> -	do {
> -		total = btf_type_cnt(btf);
> -		for (i = btf->start_id; i < total; i++) {
> -			t = btf_type_by_id(btf, i);
> -			if (BTF_INFO_KIND(t->info) != kind)
> -				continue;
> +	return btf->nr_sorted_types;
> +}
>  
> -			tname = btf_name_by_offset(btf, t->name_off);
> -			if (!strcmp(tname, name))
> -				return i;
> -		}
> +void btf_set_nr_sorted_types(struct btf *btf, u32 nr)
> +{
> +	btf->nr_sorted_types = nr;
> +}
>  
> -		btf = btf->base_btf;
> -	} while (btf);
> +u32 btf_type_cnt(const struct btf *btf)
> +{
> +	return btf->start_id + btf->nr_types;
> +}
>  
> -	return -ENOENT;
> +s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
> +{
> +	return find_btf_by_name_kind(btf, 1, name, kind);
>  }
>  
>  s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
> @@ -6239,6 +6236,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
>  	if (err)
>  		goto errout;
>  
> +	btf_check_sorted(btf, 1);
>  	refcount_set(&btf->refcnt, 1);
>  
>  	return btf;
> @@ -6371,6 +6369,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
>  		base_btf = vmlinux_btf;
>  	}
>  
> +	btf_check_sorted(btf, btf_nr_types(base_btf));
>  	btf_verifier_env_free(env);
>  	refcount_set(&btf->refcnt, 1);
>  	return btf;
> diff --git a/kernel/bpf/btf_sort.c b/kernel/bpf/btf_sort.c
> new file mode 100644
> index 000000000000..898f9189952c
> --- /dev/null
> +++ b/kernel/bpf/btf_sort.c
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +#include "../../tools/lib/bpf/btf_sort.c"
> diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
> index c80204bb72a2..ed7c2506e22d 100644
> --- a/tools/lib/bpf/Build
> +++ b/tools/lib/bpf/Build
> @@ -1,4 +1,4 @@
>  libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_utils.o \
>  	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
>  	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
> -	    usdt.o zip.o elf.o features.o btf_iter.o btf_relocate.o
> +	    usdt.o zip.o elf.o features.o btf_iter.o btf_relocate.o btf_sort.o
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 18907f0fcf9f..87e47f0b78ba 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1,6 +1,9 @@
>  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  /* Copyright (c) 2018 Facebook */
>  
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
>  #include <byteswap.h>
>  #include <endian.h>
>  #include <stdio.h>
> @@ -92,6 +95,9 @@ struct btf {
>  	 *   - for split BTF counts number of types added on top of base BTF.
>  	 */
>  	__u32 nr_types;
> +	/* number of named types in this BTF instance for binary search
> +	 */
> +	__u32 nr_sorted_types;
>  	/* if not NULL, points to the base BTF on top of which the current
>  	 * split BTF is based
>  	 */
> @@ -619,6 +625,21 @@ __u32 btf__type_cnt(const struct btf *btf)
>  	return btf->start_id + btf->nr_types;
>  }
>  
> +__u32 btf__start_id(const struct btf *btf)
> +{
> +	return btf->start_id;
> +}
> +
> +__u32 btf__nr_sorted_types(const struct btf *btf)
> +{
> +	return btf->nr_sorted_types;
> +}
> +
> +void btf__set_nr_sorted_types(struct btf *btf, __u32 nr)
> +{
> +	btf->nr_sorted_types = nr;
> +}
> +
>  const struct btf *btf__base_btf(const struct btf *btf)
>  {
>  	return btf->base_btf;
> @@ -915,38 +936,16 @@ __s32 btf__find_by_name(const struct btf *btf, const char *type_name)
>  	return libbpf_err(-ENOENT);
>  }
>  
> -static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
> -				   const char *type_name, __u32 kind)
> -{
> -	__u32 i, nr_types = btf__type_cnt(btf);
> -
> -	if (kind == BTF_KIND_UNKN || !strcmp(type_name, "void"))
> -		return 0;
> -
> -	for (i = start_id; i < nr_types; i++) {
> -		const struct btf_type *t = btf__type_by_id(btf, i);
> -		const char *name;
> -
> -		if (btf_kind(t) != kind)
> -			continue;
> -		name = btf__name_by_offset(btf, t->name_off);
> -		if (name && !strcmp(type_name, name))
> -			return i;
> -	}
> -
> -	return libbpf_err(-ENOENT);
> -}
> -
>  __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
>  				 __u32 kind)
>  {
> -	return btf_find_by_name_kind(btf, btf->start_id, type_name, kind);
> +	return find_btf_by_name_kind(btf, btf->start_id, type_name, kind);
>  }
>  
>  __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
>  			     __u32 kind)
>  {
> -	return btf_find_by_name_kind(btf, 1, type_name, kind);
> +	return find_btf_by_name_kind(btf, 1, type_name, kind);
>  }
>  
>  static bool btf_is_modifiable(const struct btf *btf)
> @@ -3411,6 +3410,7 @@ static int btf_dedup_struct_types(struct btf_dedup *d);
>  static int btf_dedup_ref_types(struct btf_dedup *d);
>  static int btf_dedup_resolve_fwds(struct btf_dedup *d);
>  static int btf_dedup_compact_types(struct btf_dedup *d);
> +static int btf_dedup_compact_and_sort_types(struct btf_dedup *d);
>  static int btf_dedup_remap_types(struct btf_dedup *d);
>  
>  /*
> @@ -3600,7 +3600,7 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
>  		pr_debug("btf_dedup_ref_types failed: %s\n", errstr(err));
>  		goto done;
>  	}
> -	err = btf_dedup_compact_types(d);
> +	err = btf_dedup_compact_and_sort_types(d);
>  	if (err < 0) {
>  		pr_debug("btf_dedup_compact_types failed: %s\n", errstr(err));
>  		goto done;
> @@ -3649,6 +3649,8 @@ struct btf_dedup {
>  	 * BTF is considered to be immutable.
>  	 */
>  	bool hypot_adjust_canon;
> +	/* Sort btf_types by kind and time */
> +	bool sort_by_kind_name;
>  	/* Various option modifying behavior of algorithm */
>  	struct btf_dedup_opts opts;
>  	/* temporary strings deduplication state */
> @@ -3741,6 +3743,7 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf_dedup_o
>  
>  	d->btf = btf;
>  	d->btf_ext = OPTS_GET(opts, btf_ext, NULL);
> +	d->sort_by_kind_name = OPTS_GET(opts, sort_by_kind_name, false);
>  
>  	d->dedup_table = hashmap__new(hash_fn, btf_dedup_equal_fn, NULL);
>  	if (IS_ERR(d->dedup_table)) {
> @@ -5288,6 +5291,116 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
>  	return 0;
>  }
>  
> +static __u32 *get_sorted_canon_types(struct btf_dedup *d, __u32 *cnt)
> +{
> +	int i, j, id, types_cnt = 0;
> +	__u32 *sorted_ids;
> +
> +	for (i = 0, id = d->btf->start_id; i < d->btf->nr_types; i++, id++)
> +		if (d->map[id] == id)
> +			++types_cnt;
> +
> +	sorted_ids = calloc(types_cnt, sizeof(*sorted_ids));
> +	if (!sorted_ids)
> +		return NULL;
> +
> +	for (j = 0, i = 0, id = d->btf->start_id; i < d->btf->nr_types; i++, id++)
> +		if (d->map[id] == id)
> +			sorted_ids[j++] = id;
> +
> +	qsort_r(sorted_ids, types_cnt, sizeof(*sorted_ids),
> +		btf_compare_type_kinds_names, d->btf);
> +
> +	*cnt = types_cnt;
> +
> +	return sorted_ids;
> +}
> +
> +/*
> + * Compact and sort BTF types.
> + *
> + * Similar to btf_dedup_compact_types, but additionally sorts the btf_types.
> + */
> +static int btf__dedup_compact_and_sort_types(struct btf_dedup *d)
> +{
> +	__u32 canon_types_cnt = 0, canon_types_len = 0;
> +	__u32 *new_offs = NULL, *canon_types = NULL;
> +	const struct btf_type *t;
> +	void *p, *new_types = NULL;
> +	int i, id, len, err;
> +
> +	/* we are going to reuse hypot_map to store compaction remapping */
> +	d->hypot_map[0] = 0;
> +	/* base BTF types are not renumbered */
> +	for (id = 1; id < d->btf->start_id; id++)
> +		d->hypot_map[id] = id;
> +	for (i = 0, id = d->btf->start_id; i < d->btf->nr_types; i++, id++)
> +		d->hypot_map[id] = BTF_UNPROCESSED_ID;
> +
> +	canon_types = get_sorted_canon_types(d, &canon_types_cnt);
> +	if (!canon_types) {
> +		err = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	for (i = 0; i < canon_types_cnt; i++) {
> +		id = canon_types[i];
> +		t = btf__type_by_id(d->btf, id);
> +		len = btf_type_size(t);
> +		if (len < 0) {
> +			err = len;
> +			goto out_err;
> +		}
> +		canon_types_len += len;
> +	}
> +
> +	new_offs = calloc(canon_types_cnt, sizeof(*new_offs));
> +	new_types = calloc(canon_types_len, 1);
> +	if (!new_types || !new_offs) {
> +		err = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	p = new_types;
> +
> +	for (i = 0; i < canon_types_cnt; i++) {
> +		id = canon_types[i];
> +		t = btf__type_by_id(d->btf, id);
> +		len = btf_type_size(t);
> +		memcpy(p, t, len);
> +		d->hypot_map[id] = d->btf->start_id + i;
> +		new_offs[i] = p - new_types;
> +		p += len;
> +	}
> +
> +	/* shrink struct btf's internal types index and update btf_header */
> +	free(d->btf->types_data);
> +	free(d->btf->type_offs);
> +	d->btf->types_data = new_types;
> +	d->btf->type_offs = new_offs;
> +	d->btf->types_data_cap = canon_types_len;
> +	d->btf->type_offs_cap = canon_types_cnt;
> +	d->btf->nr_types = canon_types_cnt;
> +	d->btf->hdr->type_len = canon_types_len;
> +	d->btf->hdr->str_off = d->btf->hdr->type_len;
> +	d->btf->raw_size = d->btf->hdr->hdr_len + d->btf->hdr->type_len + d->btf->hdr->str_len;
> +	free(canon_types);
> +	return 0;
> +
> +out_err:
> +	free(canon_types);
> +	free(new_types);
> +	free(new_offs);
> +	return err;
> +}
> +
> +static int btf_dedup_compact_and_sort_types(struct btf_dedup *d)
> +{
> +	if (d->sort_by_kind_name)
> +		return btf__dedup_compact_and_sort_types(d);
> +	return btf_dedup_compact_types(d);
> +}
> +
>  /*
>   * Figure out final (deduplicated and compacted) type ID for provided original
>   * `type_id` by first resolving it into corresponding canonical type ID and
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index ccfd905f03df..9a7cfe6b4bb3 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -251,6 +251,8 @@ struct btf_dedup_opts {
>  	size_t sz;
>  	/* optional .BTF.ext info to dedup along the main BTF info */
>  	struct btf_ext *btf_ext;
> +	/* Sort btf_types by kind and name */
> +	bool sort_by_kind_name;
>  	/* force hash collisions (used for testing) */
>  	bool force_collisions;
>  	size_t :0;
> diff --git a/tools/lib/bpf/btf_sort.c b/tools/lib/bpf/btf_sort.c
> new file mode 100644
> index 000000000000..2ad4a56f1c08
> --- /dev/null
> +++ b/tools/lib/bpf/btf_sort.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
> +#ifdef __KERNEL__
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/string.h>
> +
> +#define btf_type_by_id				(struct btf_type *)btf_type_by_id
> +#define btf__str_by_offset			btf_str_by_offset
> +#define btf__name_by_offset			btf_name_by_offset
> +#define btf__type_cnt				btf_nr_types
> +#define btf__start_id				btf_start_id
> +#define btf__nr_sorted_types			btf_nr_sorted_types
> +#define btf__set_nr_sorted_types		btf_set_nr_sorted_types
> +#define btf__base_btf				btf_base_btf
> +#define libbpf_err(x)				x
> +
> +#else
> +
> +#include "btf.h"
> +#include "bpf.h"
> +#include "libbpf.h"
> +#include "libbpf_internal.h"
> +
> +#endif /* __KERNEL__ */
> +
> +/* Skip the sorted check if number of btf_types is below threshold
> + */
> +#define BTF_CHECK_SORT_THRESHOLD  8
> +
> +struct btf;
> +
> +static int cmp_btf_kind_name(int ka, const char *na, int kb, const char *nb)
> +{
> +	return (ka - kb) ?: strcmp(na, nb);
> +}
> +
> +/*
> + * Sort BTF types by kind and name in ascending order, placing named types
> + * before anonymous ones.
> + */
> +int btf_compare_type_kinds_names(const void *a, const void *b, void *priv)
> +{
> +	struct btf *btf = (struct btf *)priv;
> +	struct btf_type *ta = btf_type_by_id(btf, *(__u32 *)a);
> +	struct btf_type *tb = btf_type_by_id(btf, *(__u32 *)b);
> +	const char *na, *nb;
> +	int ka, kb;
> +
> +	/* ta w/o name is greater than tb */
> +	if (!ta->name_off && tb->name_off)
> +		return 1;
> +	/* tb w/o name is smaller than ta */
> +	if (ta->name_off && !tb->name_off)
> +		return -1;
> +
> +	ka = btf_kind(ta);
> +	kb = btf_kind(tb);
> +	na = btf__str_by_offset(btf, ta->name_off);
> +	nb = btf__str_by_offset(btf, tb->name_off);
> +
> +	return cmp_btf_kind_name(ka, na, kb, nb);
> +}
> +
> +__s32 find_btf_by_name_kind(const struct btf *btf, int start_id,
> +				   const char *type_name, __u32 kind)
> +{
> +	const struct btf_type *t;
> +	const char *tname;
> +	__u32 i, total;
> +
> +	if (kind == BTF_KIND_UNKN || !strcmp(type_name, "void"))
> +		return 0;
> +
> +	do {
> +		if (btf__nr_sorted_types(btf)) {
> +			/* binary search */
> +			__s32 start, end, mid, found = -1;
> +			int ret;
> +
> +			start = btf__start_id(btf);
> +			end = start + btf__nr_sorted_types(btf) - 1;
> +			/* found the leftmost btf_type that matches */
> +			while(start <= end) {
> +				mid = start + (end - start) / 2;
> +				t = btf_type_by_id(btf, mid);
> +				tname = btf__name_by_offset(btf, t->name_off);
> +				ret = cmp_btf_kind_name(BTF_INFO_KIND(t->info), tname,
> +							kind, type_name);
> +				if (ret == 0)
> +					found = mid;
> +				if (ret < 0)
> +					start = mid + 1;
> +				else if (ret >= 0)
> +					end = mid - 1;
> +			}
> +
> +			if (found != -1)
> +				return found;
> +		} else {
> +			/* linear search */
> +			total = btf__type_cnt(btf);
> +			for (i = btf__start_id(btf); i < total; i++) {
> +				t = btf_type_by_id(btf, i);
> +				if (btf_kind(t) != kind)
> +					continue;
> +
> +				tname = btf__name_by_offset(btf, t->name_off);
> +				if (tname && !strcmp(tname, type_name))
> +					return i;
> +			}
> +		}
> +
> +		btf = btf__base_btf(btf);
> +	} while (btf && btf__start_id(btf) >= start_id);
> +
> +	return libbpf_err(-ENOENT);
> +}
> +
> +void btf_check_sorted(struct btf *btf, int start_id)
> +{
> +	const struct btf_type *t;
> +	int i, n, nr_sorted_types;
> +
> +	n = btf__type_cnt(btf);
> +	if ((n - start_id) < BTF_CHECK_SORT_THRESHOLD)
> +		return;
> +
> +	n--;
> +	nr_sorted_types = 0;
> +	for (i = start_id; i < n; i++) {
> +		int k = i + 1;
> +
> +		t = btf_type_by_id(btf, i);
> +		if (!btf__str_by_offset(btf, t->name_off))
> +			return;
> +
> +		t = btf_type_by_id(btf, k);
> +		if (!btf__str_by_offset(btf, t->name_off))
> +			return;
> +
> +		if (btf_compare_type_kinds_names(&i, &k, btf) > 0)
> +			return;
> +
> +		if (t->name_off)
> +			nr_sorted_types++;
> +	}
> +
> +	t = btf_type_by_id(btf, start_id);
> +	if (t->name_off)
> +		nr_sorted_types++;
> +	if (nr_sorted_types >= BTF_CHECK_SORT_THRESHOLD)
> +		btf__set_nr_sorted_types(btf, nr_sorted_types);
> +}
> +
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 35b2527bedec..f71f3e70c51c 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -248,6 +248,12 @@ const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, _
>  const struct btf_header *btf_header(const struct btf *btf);
>  void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
>  int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map);
> +int btf_compare_type_kinds_names(const void *a, const void *b, void *priv);
> +__s32 find_btf_by_name_kind(const struct btf *btf, int start_id, const char *type_name, __u32 kind);
> +void btf_check_sorted(struct btf *btf, int start_id);
> +__u32 btf__start_id(const struct btf *btf);
> +__u32 btf__nr_sorted_types(const struct btf *btf);
> +void btf__set_nr_sorted_types(struct btf *btf, __u32 nr);
>  
>  static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
>  {


