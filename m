Return-Path: <bpf+bounces-77188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B1CD15A8
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB31D304EF56
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED38389F74;
	Fri, 19 Dec 2025 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GadavdEV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MHcWPFXq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E812389F7B;
	Fri, 19 Dec 2025 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168424; cv=fail; b=M96j6QsTSyB3sJxdte1/zOBfPqn1kPUmCy6WPyqOTshebSjSRyVTjVRLOO5qwQoLrqul5mFwnDSq52PuB/T/SgmPSfnFnJvJVadTbxDiG0ICitvxBZEAv3yrXIcRZ5GrHcU+ivxB8AML78TfPlNmekzCd6aA6XWJz4L4k7IvWmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168424; c=relaxed/simple;
	bh=s8mXKbVKqMVIjRbf05qTD68gkJh01lIlPfk3bcORWIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IdNj6oP0+fOJvpB79ePRrDzj4I3+koAg2h4Gd6PjYrnsxTTGDLGhEXmiUI9hYMDlt8kJZJd9V5IojNqJGZlPJ3V/OkAgXhBGcGJjB7GbmN5AEHHaBrhyKliGYaDNBXUYsCzIOU17eBUNQ5LoF1T5bog+HKx2CIQHYPXPulMedng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GadavdEV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MHcWPFXq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJHvQLm167109;
	Fri, 19 Dec 2025 18:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1FX0Hxj5GjsEdQhC7yVGhz5nQ1xP2A753tzle+NEWjk=; b=
	GadavdEVcVI1m5PnQ4rEEE+PRoRJ1TH/chS7TklFkqPl+hB4QX3635LuLqoWtGIG
	p3Q5rBXmP0uYF9/Gi+Wjwdy3LSTlopA9HxfALd5BG4/hRZ9162GDvkZvKEHeWoRY
	cx8AeHQ0ed/2iG01EaCRqlEYfTBnougGNUsP/RKxsX14othRfvM7zR6QmDVKTY2d
	4lQNTmUEW5HTMhIHoaaBoghljrwbCL5ivZ+ghPCsPU3SzYidXaWW/D3qI94OaxJg
	TqJAj+KTm2AglJuURAcoPArQ7B+3JeAf6B0TaABxnImSO7ov8YpmqnM6CiIcU6+5
	Xd6L5BNagu5jcoJPBzVy8A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r2f1hh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 18:19:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJIAhWs037040;
	Fri, 19 Dec 2025 18:19:00 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtmtap8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 18:19:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMVEhmbwkcTKpLnR6Eewo50PIvH7dlO62ezvN7Dw7S9V0zzPSqHjs/BZG+MTzEA0GaVU9WRLWAyDgyVaVgEczOxuoGznDbLXUcJ5dA/HFR/B/VBe4fkUgQQa5G9/gCcYg7Z816bJm0qhyJ5DsxsvOdeD7Njd0apcFoK7XE2mCJeqjt1BzpiGafxUb6zDcy8/DJZSDAdutFke2fLeTpYt7zNK6ZV6XCGIWWgvGJd/fDtMdt38u+HXnlTP27JkW1Lr5/dRnzUaIoCQZcREv5QAoNI0BBJtMZhDSkuCPWMojCdhR3Yz3qTpXOPYOcN8xiqt7nd5KXJikT1dRQLpbFWb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FX0Hxj5GjsEdQhC7yVGhz5nQ1xP2A753tzle+NEWjk=;
 b=CcGLnQii97kX3Gp0yiiOk0UWYqxrC4I75srKI5SyTlUCb9kUujqWVjbR2AeM5gbLmsAxNMdwsv/A1F1j82sAQ4rOICDxxI0CBRQ46RU7ffwSueELu81mNupDv0HAXkNfAaVCTeVP1QPTJjake5CuQih187rDfuXz2myJM4ZMJw0DBDX6R/xYhNwDYX8G/KXnR6Lqo9Q15Eq5GPaeT2PILMhdejqniWDW/zHgJpxtzofsGF7zTY5Fxy4aFbCR2/eHoQVQrjICX7mrevDu8Np5ZGAkEHyKSEWhpb8GUzob4yHnGN4j+OmxdKWt9uKQSEqf6kvOzJqBTTIr+Oe1T0wYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FX0Hxj5GjsEdQhC7yVGhz5nQ1xP2A753tzle+NEWjk=;
 b=MHcWPFXql19323ZfdvFy3Mzbrxl1uENVQEU+b+0FA/AUUrm9K+7kvJ8yIyWqSMyGawbIgI/NQFlhrZfXKgxyt/ITp7izumBwjCA6zXmiSGRwjmn5/U5yZAit5S4egVacTkcPe0l3Rg2Lax6w9+M0JEnmv58LjeayjE+tTouCBL0=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Fri, 19 Dec 2025 18:18:56 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 18:18:56 +0000
Message-ID: <ccafde20-3ea5-458a-b2e7-219aaa9a7ff0@oracle.com>
Date: Fri, 19 Dec 2025 18:18:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, mykyta.yatsenko5@gmail.com
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-3-alan.maguire@oracle.com>
 <CAEf4Bza+C7nRxFDHS0dNDk5XF79nE6y4GqEu0bmtJPTMoFrNvQ@mail.gmail.com>
 <db38bb39-7d16-41b6-968d-61e3b7681440@oracle.com>
 <CAEf4Bzbn_eWC8W8+so-BgkzNOxx8jgEysU3kTzBCW1jwXPEfnQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzbn_eWC8W8+so-BgkzNOxx8jgEysU3kTzBCW1jwXPEfnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0581.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::11) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CO1PR10MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: be550253-e3a3-4bc6-47e6-08de3f2b12d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDRwdU5wdGtCOUFqcjFGeldYT3VDU2FEWGNHdmN4VXY4Mm9sR3dGelAzaFlh?=
 =?utf-8?B?Wlo3VjFwWEpBaXExeEZPOGRrZFNhVnQ2YVNFR3hqeWlyQ215enNDak5CV2Fy?=
 =?utf-8?B?SUFwdEJtNzNnSFNxd25KL1lTa1hoRzdKZ1cyN201Wk9ZcE0rNEdRZ01lRE5Z?=
 =?utf-8?B?a1pFeWZhT3hMd25Qb245eUhUOEV3M1RCSGpNQlJxeHBZSG5xdjhVSFhsQjA3?=
 =?utf-8?B?THd2M3Z5WW40K2MrYXpiRXF4S0ZDMmlVdDViRGUwMmhBZWtKUklBSmdmWUF2?=
 =?utf-8?B?bW1WdDh3U2dvUlJYL0tFRGZHclo1bVpORjJwWmhIYkthKzBTUnZxcm5XeG9H?=
 =?utf-8?B?RWZNNk1FNThmblB2TDl3Q1NxcytEUmdCOTNDM2h5NnBGQXRmaUVDVkJ3TThW?=
 =?utf-8?B?R2lQM0pHV0pXbXJOL0ErL2l6UFBsUWttVEhWQkxwcGhYS0xoT0hTcm9sQm9E?=
 =?utf-8?B?d3dFVWl3RFlodSs0UDdPZ3hNYm5FYkxLUUhFbHpSeHZyMWJlTDUrWVc0RVRv?=
 =?utf-8?B?T3BqTExIYm0zTTE0V21WLzFwMG1OZFpKUG4vcUcvVWZvTUt1cHB0b1BiZGxn?=
 =?utf-8?B?UEcwMzgyelU0WWxqRTA4dm5Bc2ZSa3pFb1YyUHhpY2RTNm8rN3laMWd6U01k?=
 =?utf-8?B?RUVieTdPSGxPcmN5N1Bmb2xzb1NOZ3pyU0ZmVjUzZUorNmZFYVFjV2daRkEw?=
 =?utf-8?B?M2d1ck1XejQyMTUwRWpOTW1MMnBUZHJrUS8xenhmakhwaXo5eHNGQURFV3Er?=
 =?utf-8?B?QWhKZDRuaHdwSWh4eFZGWExWTFhlaVJlUWJIV0V5bVkxdFlGR1J3MnFlNWlX?=
 =?utf-8?B?TittbHEySnVDYmVRYlFrRjNIVWZkMWJtUlR6M1YyOHNnQTFHOWp2OU5QNGpn?=
 =?utf-8?B?cFNxUzQwdVpadWlORlZKWkR5b3hZcTlMejlEK3d3R0M5RDE3ZXgvRWh0ZlBM?=
 =?utf-8?B?a1dVLzJkSERtQ1d3WGRJWG5vaDVkSXhZcENYSC9uVmhsYkFtY3pRMEFGdnFu?=
 =?utf-8?B?RDBsNm1TaURwQ0NoYm1aRmU4OERHYW9mNUJuTW1WTVZGTjBSdTJOdThIRnhT?=
 =?utf-8?B?Z3dxd2lCcnlmcmZ3RlFrTGNTdnZ6Um9uR2ZUUmpIOW5xYVlNa1g3M3BPUDRr?=
 =?utf-8?B?ZVRIeDdWK0o4NldOR0RscCsraEpoTFpVRE5WcUp5VDZBYVRCSVFnMlpQdjJT?=
 =?utf-8?B?UlkwVExoNXA4S2dtUENJeW1xNHJrcFZKNFBJOHZxcEFTUkJYbUpFMThjVzRh?=
 =?utf-8?B?VzZCVFhTNkJHaWpEMVNwdGUwS2VNSkRJbndhb1N5S09PRTc3V0hSdzdKV1I1?=
 =?utf-8?B?eCsvYlhuSWlKZ0phWVpJemJMQnphTEdkT01hbkZLWER5UVVjb0luMVA1L0xD?=
 =?utf-8?B?ZkFmNDkySnNIeDlJMnNLTjNCc2hDSjNVMjI1MldBT1RPU0hSR3hnOWNxK1JY?=
 =?utf-8?B?U0E0K21RVlJOYWlFL0R0d2VvZ0Y4c21HNlBla2ZycDE3NVhRdUdZWGlJYmQv?=
 =?utf-8?B?VENSQWtMU2NqOFh1d1lqK0piaEk3ZU9McC84SEtSK3R5ZU1hTFlhV1Q0Nkpa?=
 =?utf-8?B?Q3B5Y3hrcHhabkx6RHVRWk9KVzhES0Y3ZDBneE1McVhvcW44eG9xVUNqOXZE?=
 =?utf-8?B?N3VrNFFuRXVSZGQ3cVArRkhpTlY2c2crdUQ4a25xcUZ1bUUxNGJiZkNWdkV4?=
 =?utf-8?B?TERCNSswdGI0V1RJNC83ODBPcjBDZC9TdDkyZ1UrOHFwYk8wMndLVG1abktl?=
 =?utf-8?B?d3Q5a3d6OWJqN1VXc0t6VEtMb3R2c1BtRXN5b21OVk52Q3VkRFIwMzQxblFi?=
 =?utf-8?B?VFNwOGMycFRjdXY2dFJ0QkxkUERGUEpiVXhQdURtVEU5SlhPLzEyQWFrZUgz?=
 =?utf-8?B?RGIxQ09laFh6OG5PS1BqdTlCQW85MGVVQUxNZnlPV0xncmNleW9kb2lUVUZD?=
 =?utf-8?Q?uqmTkFVr8ALy0vs0M2UOFj0lkX+uL+Xe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWtoQXFvNzhvTXBDb3c1bDdadU8vSlRTcjdtZ0x6WFRSSEpkVXFHNEFsZXZW?=
 =?utf-8?B?S1huY0FxWDhDU1R2Ui9rQmVSL0JBRVhoYVhaRlJ1ZGVIbXE5WGh0UGtXejkv?=
 =?utf-8?B?SGNHMEh3dGIvRjBIYk9JV01heTZ2Y0FGVElTNHkvWWQyS3c4ajlUS3FWbUFZ?=
 =?utf-8?B?Y2pnRGFoRVdEalkwaGx5VWNkbnBsZUhCR2NXSTdvK2NIblFyWnhySGVoR1dv?=
 =?utf-8?B?aWJielNtK21kOVhEVDNsSFFCUnhvQ0dCMFMrWVc0NkZjcW5FcXFTUUw2REZF?=
 =?utf-8?B?S3hHeXpWeUp3Zi80OUY3aTl0RTFPWGlhdzhVOTR5N1R3OXVVUkg2L29rSzA5?=
 =?utf-8?B?TnlkS1R0RExpWWFpNFVRMHhtWWswRnFVNTRVemVWV3J3dlpnTmY5RHlCZnBp?=
 =?utf-8?B?ZmxEaTQ0elQvalBHcTNDNGR0T2xCYUV1dEJEdUYzTEZIaFd2REZCUERFT1ht?=
 =?utf-8?B?UVpscW1vakd4TVBtcTE2bVIybUlxTFZENEJaYU5vSzk3RGkxMVh0UFVMY2NG?=
 =?utf-8?B?NlQvV2o3akxJRFhWWlhDVXNVRm04N3N3WDlreHJhcVVYdlRZb3NpYWk0MEt5?=
 =?utf-8?B?RHNnL3I1RG9sM3pmQ3IvNlMyYWxxSW9ZUTlkSXBBbEtoM0ZXa0c3U1dMNElO?=
 =?utf-8?B?ZS9wTyswczMwYzArVlZCQkR1Y1BEaFNRN2ZVbUt3OXNEb0hZTC9idm9RVURo?=
 =?utf-8?B?dWVVSDRRYjRUNVA0ZDdiaC9hMU45VnhiSjlJbFlUVUtZWFM0ZXl1TG9zVXNj?=
 =?utf-8?B?bFZLdjN0NE0zWTZIay9VQUlmajZwVzhhQXZSWlExMHphdlFHWTJJdjZLWnBE?=
 =?utf-8?B?Ulhub3R3NTlSNC9vY0VoTnhTeHJQVTRnVEtYMG85N3F4SHJhY2xDd25MUURx?=
 =?utf-8?B?bzZqNGdXNThyRWMyeVlYM3EybFBzMHp5Q3JjaXNsVXl0NFZ3M0dtYThhK2dF?=
 =?utf-8?B?b2ZKYktxcWlybWdhUDRKbXBVWTd0NTRtMXZFMDk5QS8rbWNWUkdoVUVtdnJV?=
 =?utf-8?B?eFJaNE5hRDR1ZytiRHpYakVyM0lmT25OdytoWXJOb1RTNHA0MkxBeXgxcVdr?=
 =?utf-8?B?c3JGYjI0b0J6RElpVmZ0WGhiS3pueW9jZWZYZTRhSmFja3dSSVdoU0c5NnVJ?=
 =?utf-8?B?ZituQjZVRGtOTzBScWtGK1JWczh3T1pqa0FhWCtXTzI2Z1ZRMWllNDlzU0VL?=
 =?utf-8?B?MmVPWkFSMTBPVlVaTktTWktoQUY1WWFkSFZ4ZFg0TnFkOUlCd2lxakxqT2Rt?=
 =?utf-8?B?ZjBCWjVZNDRCTXlPejdDMWpzcGI5UllrZDkxVmRJMlZ1U2FLMHN6Q1RBNWw0?=
 =?utf-8?B?WnV5SnJmNER6dzVYcnVoRlZrdDlTTS9mWnlHS0tVQVZwb3RHaEcwRnl1Vytr?=
 =?utf-8?B?U0NZcEo2aUFMQWQ0SFFBeDVTOWdGRFZ3NGNmZzgvcVZnMmZ6OUpHRkoyakJp?=
 =?utf-8?B?dytsTUlHMnNXNW1tWHNTc29Sanl4QnFybWl1VlFIYVVxb0E0OTV3WnhEVFB5?=
 =?utf-8?B?amVpVzhxR3VlRVVTUlpxQytZMnZBYWF0R3NEZThOTEc4V3c0T0lQTHNNWDE3?=
 =?utf-8?B?OGQ4ZmhUS2ZhdWIzdXNNeVFOb3lGMTN3Ums1c1U2NDlEdXkva1AzQXROZzNF?=
 =?utf-8?B?MlNrOXFrZ1dzQnhneWRWbTJhK3IzNGFGVVdMb1lvVkFpNEw3bjZsczRHU1h3?=
 =?utf-8?B?c0ZBYVJPNUFoY1hJN0FlczN5dlRlNWg2Y0dKNW5ORm1QaFh4VG1MYm1wbElx?=
 =?utf-8?B?MmFpc1VOZXRXWmpWeWpUMXA2ZzRNMkVJUXJidWN6ZjF0UjRWbVZ4bXQxSVVH?=
 =?utf-8?B?Q3RSdm9tZXlQWmVnWnM0ejRvNTJHOGF1c05tMU02bVBjOU8yQm56L2pCY0x0?=
 =?utf-8?B?aktGcDk3c09sZDVsMHltcFkyMG5GYnBOT0ZydEZRSHp0a1RpMmJVOEIreXV5?=
 =?utf-8?B?UGxCbkhFdE1DSmd1Z3k3VnVQd3lKeERrRHhoR3VKV3JXQTI5Zm9CT2ZyVmpj?=
 =?utf-8?B?dG51MjRkMXpDWFg4V2ZSRk9PdE45Y3I5Q3ZHSkNXNm1zZWdyQk1sZkh0TkRa?=
 =?utf-8?B?RURQeVl6ZU81Y1hlQkFYdGNEUHlQM1BITnl5RDFoVmxkVTRCQ3N5NldrYkl1?=
 =?utf-8?B?Mkw4QnkxbUg1WGRDYWZvd1kwYU9nZUtvUmpTc3U4WElBOEdUSVVUeUR6czho?=
 =?utf-8?B?V2ZSbXNBQWliLytPUTkrVnpOSllzbERxcVFHRFRQRnF5Q1pDb2lWYWN0dWpv?=
 =?utf-8?B?WGdnMzl4NTA0RUZHSTkwWXhQbTZHcmtHcUtzTTkxSm83MWg4UGVDSlRtSXpw?=
 =?utf-8?B?VHJZRGNrVlo4MXpVTDVmL1FhSTVtUGFOTHZDVjh5cm15M0pXckxwdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mGNdZ2o2zNaY8aPkbedA8NKxCWR9QhqZU/G2kBmrStp5ocf0gAaTkUJV7WsCYvriwzMObrZdiJM4Y2Zgd+dSiiKf194Zk5/cdewn5kUNDQzbUE9tU4lTbQe9GqfR75uLoFb9l/C6NkFZhqBrT6G/DGQgSkoHyXYf3FKkNL5Xdd05b6sMc6r07TSTsJi8rUs/q8Zby1MV6h4V6KvbY3nqsArYFyVnND6GJv239T6BH5G0f4QDwjEdq/POhYSBSqDS6tE5DqUKRvXdiM9gGqeuTWL6Uyrdw90eqFYoEGUC5UPkr5ygRP9hKnXyS7DG0zctb8RUMi3630zn4I7hM1WEQsAdHjVl9mX+TyklAF/3CZlQDjjrlLWizys6GSVhj6LGGOzU1WmEcUDmsb4uVjxqBYcBzeUCDyl8S0jrgXlU4sexSSm/PW6N9dgRvpudTMwYzRue9zDHuj4It4liFkmt/t9yjkViM2axujdlGi4xjgqGAkmAqTj+3HvNdgBOW3fOIfmSHzX/s4uQBa6SDH/H1CUD8ouZPPF/fTPJAh2swKm58ziL2ASscElUr7Fz2rqmnbUXfjhxm5YKTB1TbgQEWQwsBwT/rztrDkXQcMnESj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be550253-e3a3-4bc6-47e6-08de3f2b12d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 18:18:56.7787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjytfwUYdyVMCNJWchdwImOXbYSpMC+v1KJJ9RwNXpy6VlTRH2UQ0G3R8YQV9ggszQgJgHosjeVQp2u3Agy2CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4563
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_06,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512190153
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDE1MyBTYWx0ZWRfX8D/ejpNJ+Mfq
 bWdP6vItD9ieymm9CRpvGLQx4Bd0AlEX8rcKZftQ3vVjtFqBLL/rnQtwQtzqB9K5IDadR8I54E8
 H9+nCgmymMX/+X+CAaec1ryXk5PUiCgecZQdAuPushFzx+WAd/fC5lxggTBhXS3MQMdlwEM5GQp
 B9wUsaMjE1zi8KfIr4PoA3iZSu3Y+MNM1Npj06bfw56qFtmc0xpt/q5P3BqwPe6o3pW0e/HgqiF
 TvpKoFkTxoZCyzh+YRqqgskR8w9Qeyrlt4Fiy1XTiw1TPWJIKCqzy8wCsbt43melsvxkBHnwXyk
 yC3j+OjZHNg9oSVJ0BILqHNq86R/9cVzMg0BGi0+oAYrhQYNCklhogfV11cEp+dgmgDE5qF0mQ6
 mWNJ8yRHg+2rkk6NA1pWzKIa3+03W4/qhzV4uvMBhw4aObqUs7BqObd8Co0nJa6yG8NXcgae3T6
 baY6ZPEHDtQmqQvdfqkE3Sm3fgYgjj9C3RDfM0WY=
X-Proofpoint-ORIG-GUID: c_w76fiquAKLji0h9M1roOjvB5n7Vb1f
X-Proofpoint-GUID: c_w76fiquAKLji0h9M1roOjvB5n7Vb1f
X-Authority-Analysis: v=2.4 cv=OZGVzxTY c=1 sm=1 tr=0 ts=69459714 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=97Noy7ONA5iqNTQ4jMEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13654

On 19/12/2025 17:58, Andrii Nakryiko wrote:
> On Fri, Dec 19, 2025 at 5:34 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 16/12/2025 19:34, Andrii Nakryiko wrote:
>>> On Mon, Dec 15, 2025 at 1:18 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> Support reading in kind layout fixing endian issues on reading;
>>>> also support writing kind layout section to raw BTF object.
>>>> There is not yet an API to populate the kind layout with meaningful
>>>> information.
>>>>
>>>> As part of this, we need to consider multiple valid BTF header
>>>> sizes; the original or the kind layout-extended headers.
>>>> So to support this, the "struct btf" representation is modified
>>>> to always allocate a "struct btf_header" and copy the valid
>>>> portion from the raw data to it; this means we can always safely
>>>> check fields like btf->hdr->kind_layout_len.
>>>>
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>> ---
>>>>  tools/lib/bpf/btf.c | 260 +++++++++++++++++++++++++++++++-------------
>>>>  1 file changed, 183 insertions(+), 77 deletions(-)
>>>>
>>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>>> index b136572e889a..8835aee6ee84 100644
>>>> --- a/tools/lib/bpf/btf.c
>>>> +++ b/tools/lib/bpf/btf.c
>>>> @@ -40,42 +40,53 @@ struct btf {
>>>>
>>>>         /*
>>>>          * When BTF is loaded from an ELF or raw memory it is stored
>>>> -        * in a contiguous memory block. The hdr, type_data, and, strs_data
>>>> +        * in a contiguous memory block. The  type_data, and, strs_data
>>>
>>> nit: two spaces, and so many commas around and ;) let's leave Oxford
>>> comma, but comma after and is weird
>>>
>>>>          * point inside that memory region to their respective parts of BTF
>>>>          * representation:
>>>>          *
>>>> -        * +--------------------------------+
>>>> -        * |  Header  |  Types  |  Strings  |
>>>> -        * +--------------------------------+
>>>> -        * ^          ^         ^
>>>> -        * |          |         |
>>>> -        * hdr        |         |
>>>> -        * types_data-+         |
>>>> -        * strs_data------------+
>>>> +        * +--------------------------------+---------------------+
>>>> +        * |  Header  |  Types  |  Strings  |Optional kind layout |
>>>
>>> Space missing, boo. Keep diagrams beautiful!..
>>>
>>>> +        * +--------------------------------+---------------------+
>>>> +        * ^          ^         ^           ^
>>>> +        * |          |         |           |
>>>> +        * raw_data   |         |           |
>>>> +        * types_data-+         |           |
>>>> +        * strs_data------------+           |
>>>> +        * kind_layout----------------------+
>>>> +        *
>>>> +        * A separate struct btf_header is allocated for btf->hdr,
>>>> +        * and header information is copied into it.  This allows us
>>>> +        * to handle header data for various header formats; the original,
>>>> +        * the extended header with kind layout, etc.
>>>>          *
>>>>          * If BTF data is later modified, e.g., due to types added or
>>>>          * removed, BTF deduplication performed, etc, this contiguous
>>>> -        * representation is broken up into three independently allocated
>>>> -        * memory regions to be able to modify them independently.
>>>> +        * representation is broken up into four independent memory
>>>> +        * regions.
>>>> +        *
>>>>          * raw_data is nulled out at that point, but can be later allocated
>>>>          * and cached again if user calls btf__raw_data(), at which point
>>>> -        * raw_data will contain a contiguous copy of header, types, and
>>>> -        * strings:
>>>> +        * raw_data will contain a contiguous copy of header, types, strings
>>>> +        * and optionally kind_layout.  kind_layout optionally points to a
>>>> +        * kind_layout array - this allows us to encode information about
>>>> +        * the kinds known at encoding time.  If kind_layout is NULL no
>>>> +        * kind information is encoded.
>>>>          *
>>>> -        * +----------+  +---------+  +-----------+
>>>> -        * |  Header  |  |  Types  |  |  Strings  |
>>>> -        * +----------+  +---------+  +-----------+
>>>> -        * ^             ^            ^
>>>> -        * |             |            |
>>>> -        * hdr           |            |
>>>> -        * types_data----+            |
>>>> -        * strset__data(strs_set)-----+
>>>> +        * +----------+  +---------+  +-----------+   +-----------+
>>>> +        * |  Header  |  |  Types  |  |  Strings  |   |kind_layout|
>>>> +        * +----------+  +---------+  +-----------+   +-----------+
>>>
>>> nit: spaces (and if we go with "layout" naming, this will be short and
>>> beautiful " Layout " ;)
>>>
>>>> +        * ^             ^            ^               ^
>>>> +        * |             |            |               |
>>>> +        * hdr           |            |               |
>>>> +        * types_data----+            |               |
>>>> +        * strset__data(strs_set)-----+               |
>>>> +        * kind_layout--------------------------------+
>>>
>>> [...]
>>>
>>>> @@ -3888,7 +3989,7 @@ static int btf_dedup_strings(struct btf_dedup *d)
>>>>
>>>>         /* replace BTF string data and hash with deduped ones */
>>>>         strset__free(d->btf->strs_set);
>>>> -       d->btf->hdr->str_len = strset__data_size(d->strs_set);
>>>> +       btf_hdr_update_str_len(d->btf, strset__data_size(d->strs_set));
>>>>         d->btf->strs_set = d->strs_set;
>>>>         d->strs_set = NULL;
>>>>         d->btf->strs_deduped = true;
>>>> @@ -5343,6 +5444,11 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
>>>>         d->btf->type_offs = new_offs;
>>>>         d->btf->hdr->str_off = d->btf->hdr->type_len;
>>>>         d->btf->raw_size = d->btf->hdr->hdr_len + d->btf->hdr->type_len + d->btf->hdr->str_len;
>>>> +       if (d->btf->kind_layout) {
>>>> +               d->btf->hdr->kind_layout_off = d->btf->hdr->str_off + roundup(d->btf->hdr->str_len,
>>>> +                                                                             4);
>>>> +               d->btf->raw_size = roundup(d->btf->raw_size, 4) + d->btf->hdr->kind_layout_len;
>>>
>>> maybe put layout data after type data, but before strings? rounding up
>>> string section which is byte-based feels weird. I think old libbpf
>>> implementations should handle all this well, because btf_header
>>> explicitly specifies string section offset, no?
>>>
>>
>> That sounds good, but I think there are some strictness issues with how we parse
>> BTF on the kernel side that we may need to think about, especially if we want to
>> make kind layout always available. In that case we'd need to think how old kernels
>> built with newer pahole might handle newer headers with layout info.
>>
>> First in btf_parse_hdr() the kernel rejects BTF with non-zero unsupported fields.
>> So trying to load vmlinux BTF generated by a pahole that adds layout info will
>> fail for such a kernel.
>>
>> Second when validating section info in btf_check_sec_info() we check for overlaps
>> between known sections, and we also check for gaps between known sections. Finally we
>> also check for any additional data other than the known section data.
> 
> I thought we don't validate gaps, I missed btf_check_sec_info()
> checks, though. Good for kernel, it should be strict.
> 
> But it's easy to drop this layout info in libbpf for BTF sanitization,
> this shouldn't be a problem. Just shift everything to the left and
> adjust strs_off.
> 
>>
>> For layout info stored between type+strings we'd wind up rejecting it for a few reasons:
>>
>> 1. we'd find non-zero data in the header (layout offset/len)
>> 2. we'd find a "gap" between types+strings (the layout data)
>>
>> Similarly with layout at the end
>>
>> 1. we'd find non-zero data in the header (kind layout offset/len)
>> 2. we'd find unaccounted-for data after the string data (the kind layout data)
>>
>> So either way we'd wind up with unsupported headers. One approach would be to
>> do stable backports relaxing these header tests; I think we could relax them to
>> simply ensure no overlap between sections and that sections don't overrun data
>> length without risking having unusable BTF. Then a newer BTF header with additional
>> layout info wouldn't get rejected. What do you think?
> 
> See above, I don't see why we can't just sanitize BTF and drop layout
> parts altogether. They are optional for kernel either way, no harm in
> dropping them.
>

The sanitization for user-space consumption is doable alright, I was thinking
of the case where the kernel itself reads in BTF for vmlinux/modules on boot,
and that BTF was generated by newer pahole so has unexpected layout info. 
If we just emitted layout info unconditionally that would mean newer pahole might
generate BTf for a kernel that it could not read. If however we relaxed the
constraints a bit I think we could get the validation to succeed for older
kernels while ignoring the bits of the BTF they don't care about. Fix that would
also potentially future-proof addition of other sections to the BTF header without
requiring options.

Alan

