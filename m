Return-Path: <bpf+bounces-57080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CCDAA5341
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 20:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237E71BA3C8B
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128692749FB;
	Wed, 30 Apr 2025 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SdsEJv/b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T7zw2Uqk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C82609C5;
	Wed, 30 Apr 2025 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035979; cv=fail; b=SePaW8hduhO93bfiBUbqzjklPE2FJ5Pysc31QT0pmwl94mmWr0cfqS5TryFuEG+dZqsTT6Tun4Xghtyb2RtnEAOL8cRRxkBon3jNJmNKspiFwiRsu1UqbR6I6wqb01cfe5xUiRzvk/qgCpdgrdKHNqbdOPWi8VI7KOIS+odLJuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035979; c=relaxed/simple;
	bh=8aqiGPxWt+hHkoe/cszrnkNTTY+56pq5ZdazQZxyST4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fde9RT+T6BfBRymdBKBjyOQugelkFDCN0WLTSzW+cTzSG6w3+eQS2adX3c/GlcqZTEIUYt59wv1ol+MscOvaGE04v2vm225oIg2RfHg4ETSpOwc710s2PA1Kd2pSUeVK2fUnC4KkcxRedCLHsedtc2ccPx0j6xkmmxPqJVblbo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SdsEJv/b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T7zw2Uqk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHtrMd010159;
	Wed, 30 Apr 2025 17:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n7I7ipq/5kMyzpeLIt6X8BCQb199TzdpM0FuRywoFRk=; b=
	SdsEJv/b+ZngDJGiTOTiey9NThEKdJJjCcchHOCnqizfTrZGVN9JUjy3Uoyn7Wpe
	J6nAPBezz1qKWlzzNYQyvnAtW/y18njB7j7xcfuP9Nejk/PIrYCX7064qb2Ys3br
	7ucB7QRu9UVRT5pxJ58oLZfudn0P0yObRZHFXeNmoY0b5vx9WBZqOeylDrx5nNUU
	KVKMAizxEUiFzZJxk4lyK3fTMHt8AZLrJkihInvTcgVTRzJF+DkcDTa+ChsrPQD8
	sN4w/qmbB9W2NxwoRaXrUse9NFvBT78E1y7NCKIR57x+KbufIIV9H0U0084WiI5Q
	vdJNWsTCwD3bOtCsNUkfZQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukhspk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 17:59:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHF7MK033501;
	Wed, 30 Apr 2025 17:59:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbnaw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 17:59:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk9a4xRn98fbpBzF+FZY4q06rK3Lp320xdlWl40R+ndgqFiooUyi6N1J/SR6QRko3/I7U9xLILMzXrq5DZe3T/5d4fRVrbOThHM5eRo0LSMiGEfagAySrROhLmLpEbxkZJiG1nC3hGpueAhUIYMjmTvG0fYoUiuHDgBSNrdIcEMF6u8f1Ccoukv5GzJ9qlvvG0xOfWZ6gAjHDYOfzcdjZVMEfIphSILfz0A4bgkbkB9uZkHcnZPCF6IJNFd5/6NQQwEI/lLvkIi/M2mGtZulXlzfMR3HowndH+4fCtz/8KvcQPnLb1cbbuA9a2iYSw3Y+fFRGqoHpU3e3ROcFJ/83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7I7ipq/5kMyzpeLIt6X8BCQb199TzdpM0FuRywoFRk=;
 b=kffLYH/P6sHdyuf+JjaFBuwZEwOpj8/us4jaOoHRxU5s+20laiU5/N3q8fAKSS0uZTXulE1kMCFtzgFGpQQnvQW0xrSj7h0Bnfv9L694W66XrcVPFYrn0NDnVamZ9lLHJRVoXQVA1MZNeTwQHwQYLpCKSEl7EI35UVXoMpwY/68hQqTlEidbziXuibRU9vwZfVLw7Dr61Zn0+CBvpD+9XGwtBcDdwcP2Qpp3VJWxNNwIAbEn9+OK/NetSNFbXHhNyy7pE0Kr4P6mUdrBZ/kPVhly2xloRpI1EYzOWfTCj+m7vxWLhgM3fZCqsc3dw3D2NZV6wGsZ4lZQVsPdYawAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7I7ipq/5kMyzpeLIt6X8BCQb199TzdpM0FuRywoFRk=;
 b=T7zw2UqkBMDabqA6TwWjuTc1Vqppd5MerdWS/dQ2vNAlgimPsaf4DCEFMQ52O33/dmzu3rcoULjvCxASUwbauleFsFCzEAKBYJJNWTsMp0bCXSp+yKrp5lZQECxPuJd5Tr4639APu08T/Pp8wlfz9uzRmyg1SdN5wfz+EhnmO5s=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA3PR10MB8613.namprd10.prod.outlook.com (2603:10b6:208:577::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 30 Apr
 2025 17:58:59 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 17:58:59 +0000
Message-ID: <a38362a2-a414-45f7-85d6-4be2df15807c@oracle.com>
Date: Wed, 30 Apr 2025 18:58:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 0/2] fentry supports function optimized by
 complier
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250430164608.3790552-1-chen.dylane@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250430164608.3790552-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA3PR10MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a10bfa-2977-471d-c8ed-08dd8810aef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3JyWmx4Q2JNRmd5SEVnQkJXeVNlZ0Vlai9rb242Smp4R3Q3c0JrcWd1WGhj?=
 =?utf-8?B?VFBQYVUxV2s4eXg5c3JkckN3SXp6VkpYeXREcThXL2ZUSW1RWXhESUtqMFZC?=
 =?utf-8?B?MUk1dzFhZGpadlRmYkppR0l3Y05NYmtYcmZsK3Z3aDc0a2E2TzhMK0ZzdXZI?=
 =?utf-8?B?Tjl0ZzlPbDIwMlJERVQzSU9LaUIrL2hIOU44RVlSRm5ZaDh5Tkw5bkFNWHdR?=
 =?utf-8?B?eW9mRC9nZGllTmFaWE93cHNhKzZnRW5Jd0hwK0J5OTk3NDdFdDhMbnJON0ZN?=
 =?utf-8?B?ajRiL2V6ajZ1WUEvZjE4eEFrRUhHeG1qVG4vRmlyS2tFZFgxRXdvQlZrbUMv?=
 =?utf-8?B?Y203ZXJMMTFKejdVZmszamt2b2orb0tuTDZqclluT3RQOUNpZlY3VVg4R0dr?=
 =?utf-8?B?anVReElzdC9BaVJoaTVqS1h2ZFJ1TzdvSGV1dEdWT2NzWDVDM0JYVlRoeVJq?=
 =?utf-8?B?eGYwN29TS0lhcEpHR3JUOU9TdEZ2NmZlejk5dmg3WDVTZExFdGI2VjZVYzVZ?=
 =?utf-8?B?YjM2V1JCYW1XWkZ6Szh4VUhIWWJ4RlBrdmxJWHpBQUxpSnY3RnBFTkJ3YVJ0?=
 =?utf-8?B?aVV5YWdCeHB6YUkrczJobWd6QXBza1hVbDg3NWQ5b0FPR3JnTkcwYWkxWTJm?=
 =?utf-8?B?NFVBTXFKeXB5Rlp5NDF0d2FsdXZ5NlF2dDhpMExtUUlxd3F4T3R0K2tZcWhw?=
 =?utf-8?B?aEF5ZnptaVNpV2U5QTNRSkpFa1l0VmxJeVkwbDRXMTE0VklaY3ZtSytiRHA4?=
 =?utf-8?B?U1YxY1BaRi9CMkFPUVFlVHgvQklnRnlOOTBtZTV2ZW1Qa1VmcmxmU0tvcVRZ?=
 =?utf-8?B?V0NscTc4ZlFraHZhNXM4WjZMRDc2c1UyM3NFQnFQWXFNR2prTjNCRTNNenZF?=
 =?utf-8?B?cERPZ3RRcjFBcGF2cFJ6Vk9TT3AvNXIzMzVUY3JVYVFBcmlscFNkVUJjcXhJ?=
 =?utf-8?B?TlMxN3NBMm1SeVZyQWQybnZUMndtYnN1SE5ySmMzNkFUMmIvRWJjSmNwc2xB?=
 =?utf-8?B?V2xRWnJ1TDg3UWV4dEJOOU01cTh3OXZnMXdONXRhNXVTYWhTNkswUWxydG0w?=
 =?utf-8?B?L2hhd0RzTjVkSHdDZE5qdXpxcjVlSGs1QmVVTy8yZXIzRDVzWTh5eHhxS29m?=
 =?utf-8?B?RFNTeVF1QlAzbXpsTkRjNmtRdjVmc0JBQzhHaWwyaDFSenBuL2JnRVFOdGdr?=
 =?utf-8?B?T1JRdjMvRGt1cGt5NDhQZThWSTNuVURndkYya1lWUktwc2RlRzB0dkdUNXRa?=
 =?utf-8?B?WXJIblFuYmhvZmNtUnduanlHcHF0MkxKL1Q0TGpQRGhaZXVrdE5EQmRYaFdH?=
 =?utf-8?B?S011N1ZFZmJHeHM4ZXNZWS8xWC90ak1iOGplaWxkZDcwdUxkRXN6U3FoMVdo?=
 =?utf-8?B?UnNIUzcxYWlCSmxPYUZzcG9GWTJ0c25ETGRtTDNiTjdlRFd1N25BQ3M2ZHVP?=
 =?utf-8?B?TzRydDlsWmdzc3FKNklwRnkzc20rU0VYWXY0anBkVlNoTTJGMTFkUlVudkor?=
 =?utf-8?B?SFc3Ty81TjZLZnRNeEFZMlFNWWYwWHV0Zm1uSmlhazlqWmI5ZlBRQU1oUzRJ?=
 =?utf-8?B?NG0wNGVhVXB4RFkrZVJjTFpTcjVudXhzWVNSWGFLUVV3YVBwSmRoc2xGRk0z?=
 =?utf-8?B?YmlhVE1sRkFxRE8rd0E4YWdkeE1tU255eXBNMUVtZXRuYkhlVjFHSS9DMWhp?=
 =?utf-8?B?Q3VjV2duOGUrdU1FRDk4UEQrYk5LZnpRS1h0VUNwM0RuVUZPbS8wWktYQjlk?=
 =?utf-8?B?UmloRXlNOC9nZ2lvS1ZWTUpoZ0F6bnd6Q08yMGJPYjFjMXNnMEZkdjZhcWc2?=
 =?utf-8?B?ZkVtWHZOQlhza2t6M28vSVlLcC9BT283M2hvSFFKcjNMSk5yQ1Y4Vm1IdVZ0?=
 =?utf-8?B?UVFZa0VzZHpCdGFoYlF5eHFGTER4K0lVL3BKODJjQi8xb01EZGRWV0VkMDVH?=
 =?utf-8?B?WDBQZUtmb0hUZ3JUN1pITytEY1BmMkRzeGJhdEQwMDVnTUtocWs0V3pkNkFP?=
 =?utf-8?Q?Z5qOCntZhGnbH4WB/yWEZK5TRT5w9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU44ZTcxeUtUcWQ1ek92bnBPTEo2clI3T2xGZWJ6Y2QwT3AwdFN3VHV2WDMv?=
 =?utf-8?B?MmZsc20xMStmWDlOWU44emF1ZGFzVVc1YnB1alZtYkJ4bzBUMEd5bEJNb0pO?=
 =?utf-8?B?RHV1SDA1U3E5djBKc3dueFhNTEp0amZqRFFBcDdETE1wZktHTWhDTHdCNzRY?=
 =?utf-8?B?V0p2RHFkVkVRUkhOS1Z5c0RIZXpOdmJMbW1Sc1BaS2Q4WkxGUGtLNlBoeWg2?=
 =?utf-8?B?MWQ1dXpVZGtLRFFheEhBVm93TllIUDNhUTFyZVhrWWhWa3FnUFFjMFh1Mytu?=
 =?utf-8?B?bzBBU0MxcGxibjMrZjkxMlEyTHUrekpJTUtXeE9rNm1pVms4ZHBOME42Zk5T?=
 =?utf-8?B?OTFlNmo2WWVSTDBDaEZ1WjNmMTJDQk9QTjE4V1pQc0JBSHVld05VQXVxQjRU?=
 =?utf-8?B?aWREV0RrVDZyNVkzR0d0V2V1empScGtSZHVPMTNJanJVb2RoOTNjRlBLL3py?=
 =?utf-8?B?bWlJSUc2VHhZUUx0MmhGcldLcW9PbVNScXZnWTZOcGd3ZkN5TjNsamZjSndY?=
 =?utf-8?B?RkJtRitBcFJEOEI3c2NNeVVGZDdmWmhuUkJOaUduRFd5ekFBMUcxZzh0YjJE?=
 =?utf-8?B?YVZNejFVZzY5VDZWMGUyM1BEZHprKzF2NC9wVkJiNzBzUjJEM1lveGRGSUho?=
 =?utf-8?B?S2UwZGlTRlVZYkhmVExHMFlDV1NQZDAwWDF1OU1DKzZOVG1KL25mcWU2NzRh?=
 =?utf-8?B?YzBxZGFKdW40elcvWGVqSkZKYk5VdkRkeWRKTHQ3eTcwSDhneEJQcURsa1Fi?=
 =?utf-8?B?elBNeFlwQWVNREFVY0hXTFRXRExwSjJWZWFRLzRHaXVEMmU1b1pJU0VFMnhG?=
 =?utf-8?B?bGtSTWhnYjRUMWMwUEtPTW93cTdjMlZMN2o5R3U0TnVGRjRza3dKbnhHN1JS?=
 =?utf-8?B?V2RzZWRqa3ZRVzNnMjBwYW9aQWdORzl3RzRQckhFUW81RlJ1QkV4a0k2R1BX?=
 =?utf-8?B?RUw2aEd3UFhmWjVQc0licG5LVVVrZks3eG9MK0Z0dEtlSDRpb0hIU2U2TlY0?=
 =?utf-8?B?emd2MUUzbjFUYkRRN2ZrRU5YUzhnenJjT004dXcwVUZBRm1FZWdScXZFeXFZ?=
 =?utf-8?B?akIyQkkvbDREeXNJRXNvcWtEZE52WElSS1BzQVY1U3VnM2d5VnpacldidCtv?=
 =?utf-8?B?SEYvTEJ2by8xRXV4OEx4NSsxeHFPaUpRVVVCZDZlNnhjL3g1N3JRWEZVRVpG?=
 =?utf-8?B?d1crancydnVSMzExaGd5bkdjN24rMVpSOG5yeklpcEhJR2paRGY2T2dpTHBQ?=
 =?utf-8?B?OFUzUCt5OURCUFdBUU0rRU1JY3NKMWhROFRWajJPdWM3blQ5T0Y0N0E0ZXBE?=
 =?utf-8?B?bGs4WHhhY3RHWmFlYzhzS0pRU3NSSXkrRTFnbjRFY3BnT3d6UDQ4cThrR1NI?=
 =?utf-8?B?TFdUV3VuakVja3o0VE5ja3BndmdYWHFpTVdHa2tXSWtaajJEdFFGWG4ra1A1?=
 =?utf-8?B?UkdhR1FHOG9EV1pEcklDOVZCS09DUmxFOHJFcEZqVm50VnRrOVlIMC8rVVc2?=
 =?utf-8?B?SS9xV3UwWUI3bjhUWkRGYlJQZVJacnJQRkhqR2JYek1oK2dwZFN4VEdWalY4?=
 =?utf-8?B?Z3VwTEJFcEMrNEJjc3hFSDNieFgzRlFteUJaOGhiOVNEcUs4ZmE0Mno2QWI4?=
 =?utf-8?B?WmxqUDBuZllPeXBuZ2dCMnZtaWxNME5pdWNTL1hKeHZjNHp3VVppZTlIeFdP?=
 =?utf-8?B?enplSGlkQXdJL0YrYjR2Sm5QaGJja3VERlFETW9UMTVmMElLMXA4OGhxTkNy?=
 =?utf-8?B?WmVWN1JvaTJWaDFpTGt5SDBaZFRCQVBySFZ5MGxLSDk3ZnR1anQrU1k4WmhZ?=
 =?utf-8?B?aGlEcjJ1R2x3dVgrRUtjS2dBUHhGWHRXdjNOU3ZoRVFsWFFvZXNXeVlRbUVM?=
 =?utf-8?B?eHpWdTRqNnRmOFpMQS81V3N6SzZ6SmtkVmYvTUhiTjBLWmVJTUpSdW9XeXJE?=
 =?utf-8?B?STIvdU1tVmV4VVNsODBSbzRmbDJmcU90YTZ6Tjk1RGJxTDMwdkR3dExKb0c5?=
 =?utf-8?B?Vlh0STBVYVZiRFdlVkpvT1lqdHJQeXpycUpXMzQyN3pFRWdkNU45L05Ya1Y0?=
 =?utf-8?B?YWtGWittazVpR1NvQzk4K0lJK0lqUHdVM2t4RXJXYmoxZFNHRW9FSVhaN0w4?=
 =?utf-8?B?NUR2WXpFUGdvODdBVVk4dFRtUTQ3UlcvWHNzaTNRa2l2eThrRW03OGtpK1Nn?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JNxhgm0xmOGqaDtt7ZP/A8pf8KC/BmmtSnm1CqQUOMnof4LvCYJqMqx9as8Let6yRwoFVeyqNZ/whbhHkIq2ZvGxE+F9/yfFYc9IpsZ246Y/WUO5+NpFMZCoT/OQ2SHorq8xJT51m89UPAHzEo1/ztgHI6nf/7YQQIOhVD/gY1sNicPCRBdwWa7Js43k/jX4GiZMQDos0GXvmQh7kTFC8b6eQjp2Q5uwJifeImzcnHpeFvLuRaEfs9hiAHnsp7TihvfCCyXVKLXjlIrgWqvX1Z41kyXG57zqHpGpmHXWx3z3+RXDewdt42XIJjoUoxLIkREDz+SI1pqZ5tXxS5QyAt5UC9g7hrfnFugUWjy82aWcU2/AxKFqMkUaJcgQxzqER3zcYclzWfVfmlnLQ/cKH0exm1dzB3c4VeIU8iinMHu06SUYhwT44tQaUUOVL6uf+q5Vh7jFSg+SU4UY03jXNmDInz4uCqpisg0+9cM6+XnxyADz6RlQey5JTHcW2wSCI2s8DJQ5y3H4tw6qO5vZc8AUE4oBhBk55HYUey2xnL0JIoPjHfp2L90xSfk67pP7iBpqaISwYuWzTxjJSkAPvyt8g8W7McwWPSb8VJVukUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a10bfa-2977-471d-c8ed-08dd8810aef4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 17:58:59.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z8OwmfQODcMH0WgTvLJayBT2xWKOF2+cnTj3SDCWJqw34SbUIhvsvv4frBUsof2jNQkDgvDwAoKq0BlgFdauQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300130
X-Authority-Analysis: v=2.4 cv=MIZgmNZl c=1 sm=1 tr=0 ts=681264e7 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=VabnemYjAAAA:8 a=f_QgwlRcz8U21Ho-RC0A:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: w0cIfpbZyYRHBqgsKpnxqYjXVzOmy4XI
X-Proofpoint-ORIG-GUID: w0cIfpbZyYRHBqgsKpnxqYjXVzOmy4XI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEzMCBTYWx0ZWRfX9wUN0L7WMvWT +GwPey1Qt0E52tCrYaO1yvSKIajV0875KigqB/UbZqy3gJ7zQnkQKDhtJTjd+uchLPHSG/J6H1G pQcKn02ZtzLuDfm4Ha897ZeDA2CEWu9E/gb/qAsS3Fja6DcrDZU/KOGlDI5CciXhms5k7OyIL41
 nMWMp/Hlij4XdnY/5+HK25tZRCxA3BaqWFx1KLlq7+Jh7vytN9SMA6n9gNSt7V+8R1MnRcOj4b+ 9U/gdd7zyv4IZlBPVyRLbP2uLArHJs9huRuxEHnMWS9Px1QBxyvPouQVmM3OkYyFc8Y4k97cKxh H8YtRvxPoKnGpvs3q+Jbw2cnh6hSnFPiHjLaEmPY4C9A/M8S+geU3ddGeFlSRr8TRDcZz5ZNLtt
 rHN9wI6rkjcKyAh70tLwAHF+t1P75CuV+DDwy26zuLJ4VLmK8A949MCa98FjMadTVytlsrBj

On 30/04/2025 17:46, Tao Chen wrote:
> The previous discussion about fentry invalid on function optimeized by complier
> is as follows:
> https://lore.kernel.org/bpf/3c6f539b-b498-4587-b0dc-5fdeba717600@oracle.com/
> 
> This seems to be something that pahole needs to resolve. However, Alan
> mentioned that there are many situations involved in this, and he proposed
> that the available_filter_functions_addr can be used to find the address of
> the real function. If we can get the real address from user, maybe this address
> can be used when the function obtained from the BTF is invalid.
> 
> The specific selftest has not been added yet. I just wrote a simple test
> program and ran it.
> 
> This is the initial RFC patch, feedback is welcome.
>

There's some discussion around this in the context of inlines and
optimized functions at [1] that might be of interest. Ultimately for
more complicated cases like this I'd really like to see us have a
name/address relationship encoded in BTF so that we can be clear about
relationships between a function site and its BTF.

The current state of affairs though is that a function will only make it
into BTF if its function signature is consistent with the prototype, so
unless I'm missing something the approach of passing an address to
clarify the relationship seems like a valid one.

It would be great to have a test, can we try adding a function to
bpf_testmod that a compiler will likely optimize to .isra.0 and trace
it? This won't work in all cases, but we could skip the test if the
function isn't optimized as wanted.

[1]
https://lore.kernel.org/dwarves/20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com/





> Tao Chen (2):
>   libbpf: Try get fentry func addr from available_filter_functions_addr
>   bpf: Get fentry func addr from user when BTF info invalid
> 
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           |  1 +
>  kernel/bpf/verifier.c          |  9 ++++++
>  tools/include/uapi/linux/bpf.h |  1 +
>  tools/lib/bpf/bpf.c            |  1 +
>  tools/lib/bpf/bpf.h            |  1 +
>  tools/lib/bpf/gen_loader.c     |  1 +
>  tools/lib/bpf/libbpf.c         | 53 ++++++++++++++++++++++++++++++++++
>  9 files changed, 69 insertions(+)
> 


