Return-Path: <bpf+bounces-44662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D60D9C6103
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 20:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0999B358B7
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 18:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE434217464;
	Tue, 12 Nov 2024 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="emoa4+KO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S+6nus4o"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4B2076A9;
	Tue, 12 Nov 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436453; cv=fail; b=W8mt1FRLTzQk/vPYzxXYl3XOs5rd+fLDZEdUzSBGDXnyYLM+s37cXFW26MQYfMm7hmm3GDmSarkrEvXsf0Mx7pWUKEfiyhhcsNF1KJR8MtG+qyVKaiKB0yig84Xhx0E44+Ym+P8HdQSRWWiCass3Cnhug4KtvLzowh//Qlf7iDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436453; c=relaxed/simple;
	bh=N1gloH4eJwElUaUSvoZPqAg9XB+wO3JZlIQWHxsvxo0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oybmeF8uS3qyytVRl6d1iMYJzek+4gL403hy5UNQB7JEDigGsuaWmXmHS0lGoSBXE0Aruvu2+vVp7IlBwz8CBrHDI/AQi6/lrPDB8d7XUls5ttjq4CQhhGM2lhn3KE0PsOsl+vKwMprNfRv5MvfeKmCfrSX2IMmQW04XAmC7990=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=emoa4+KO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S+6nus4o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACHtd1j027068;
	Tue, 12 Nov 2024 18:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=k5iClW6ZhxGWPKs8ZOzIV2RTB+FVNLKkyyVIfjEDGlE=; b=
	emoa4+KOzUvTIgHzP+GXAMUvQk9srKIQcM5v7YZ9dN/yrqFBCD0Z9U1IDlZT1bFN
	BxSt0Y4/AChTwh4JYH3mq/pZdetW8ceYO5kRmUIHywVSn1z9U/dsNxbPilxxtzXd
	weFvUK2tvyC6E1rzdrD+QiZuGirgNgFHl6DPS560UcEY7B4oLjqayYCTRCB0RpSE
	u9AaHRiqgRBmfSywv62L1cGdYvaB2tp3fpGVT9ZNOd7oc2HZ9RHkQTs2fUob5Y50
	DO9dz/+ZE4JKkuAvO+9A/wY/K4Oq7eXY4EuqfXQu6LEPl1qTIzc3QSEw4YCScxnV
	DmWbNo+vEM4xjD+/BrksrQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hnd5d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 18:33:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACHJCk8001182;
	Tue, 12 Nov 2024 18:33:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx68jhdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 18:33:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0SC+J/fGgMeAxdTD3/Bi3jmNWWf3IM0KDuPZYlrAojeP9wiKJ7Q2PWsW6Zg2HjIGJCQM5xxZKYWF3yhR/sRMzkydD0e7Xn7ozCklCxvC+yrOIN7wwa/ZuO5N61NMSVOkCZfyScL8/iAPGYKGVfe+Il4oELUSEY6brDQOGLkjXwNIBJlA47DRz7THBM7xJACMP5IacBBljDld8tVdxGhv7/oAUAuskaeJcGApKlVpJc9akSGMQVvQKqLYbCeyUsW6mEQQDFinU34X9n3pOH8g4M/wXoRJoxBReR0x2hsaG3a5EpmcwAU1zukest4N7ajhD4fWoBcxLPSEvMlujiXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5iClW6ZhxGWPKs8ZOzIV2RTB+FVNLKkyyVIfjEDGlE=;
 b=v9bFTs0K5XJ8JgEltC+Pt4OBDxIrz9Tsqcqz40RME8zlHPygCq0dWqQM6TdL0rTbuJiWLRWlDyW+69O9YGF3xJLMpz50pf/lHlK0vQ99krRfVaX76Y7wU2s9m/+Z0C7OMHcwNPuf3kHEJss6buzQXq2W4BY41mlD5uNnNvKw1kkJJqRr4wz/i+Mx991l8XUNWDip1LuPgLCkdAG0eCYMc/+UdmAANdWa7Gsa2hHhj7LxYpNYlch35W5c2HQOYshSkeONgueqm6/0YWTVUHdkCPl+oMAZnSjUCK/q158nseUOLkkctEUq/e8jB4e1WWClu+SdiaF9MLSKM0s3nl8ilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5iClW6ZhxGWPKs8ZOzIV2RTB+FVNLKkyyVIfjEDGlE=;
 b=S+6nus4oxte16uxj3r8MkJ2K+yRGO1ZwfuLztLNLjbmjk1BfAc+tayULaOTpo1vrmxKir5CI54Y5SlRuOVO7zG1tGc+S5es+lC2lc80Kobm79JqMY+mT7kA0POf3T1p58KN+OAzYq8yMqedEEy+aD+2YnTP1EKiIwVw2Z3vfFLI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB8152.namprd10.prod.outlook.com (2603:10b6:8:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 18:33:43 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 18:33:43 +0000
Message-ID: <5e640168-7753-413a-ab00-f297948e84ef@oracle.com>
Date: Tue, 12 Nov 2024 18:33:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@fb.com, Song Liu <song@kernel.org>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
 <20241108180524.1198900-1-yonghong.song@linux.dev>
 <b32b2892-31b1-4dc0-8398-d8fadfaafcc6@oracle.com>
 <5be88704-1bb0-4332-8626-26e7c908184c@linux.dev>
 <e311899e-5502-4d46-b9ee-edc0ee9dd023@oracle.com>
 <48a2d5a2-38e0-4c36-90cc-122602ff6386@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <48a2d5a2-38e0-4c36-90cc-122602ff6386@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0108.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdea8b9-81ff-4a7d-ad59-08dd03488938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDFIOERvMUhuMmdPK3JPdXlaTmsrTmFUdDNaWkYvVEdBa1NIRTllSm1nV0pB?=
 =?utf-8?B?VDdmSlZpcXgzeHdZV2c0RUQ3Q0dVaHhVZk9qVkRhaWhwT2RTUWFhTmcwMXN1?=
 =?utf-8?B?VklNR1FFbFNlOGE3bXJFKytMNHFlWkdCMk04ZGZCRE96bXltR2xKRFduQ2Nj?=
 =?utf-8?B?MEZ4dTFGci9rNC9iTTBvaTJVQzN2ODdsOGMwNnJqbU0venN5QlordUpKRXpw?=
 =?utf-8?B?U1NEVGVFVHdWTlRUU0tVTzlmY3NyWXdBMWprdjhPNlU2UGxJWkNvRG9IeW5W?=
 =?utf-8?B?MTdrTXZYVy9FaTVocVVhMEpBWHlNL016aXNUMXRkNExlbUdrNkhiWUlUUUQz?=
 =?utf-8?B?QjFvNUhZRWU5UVMwMzl2dDZYWDFPb0NjWks3MFNIQjVveDBDc1htQnlGTVhW?=
 =?utf-8?B?ZVhWUDlPeWo3Y3pGeUdmcDhTeVVpM0dyNVZkNjdRWDFjUmx4dHhuanRjZGVr?=
 =?utf-8?B?WVd0VDUvcTRYbmE1bkppOERDa1FONW5obyt5QXRJSm43MUpEN2lDWkhWUjB2?=
 =?utf-8?B?UHVJUitvT2pqQVZ4aXFYd2ZUOUNoWlNRWUlSNTV2N1ZZODJKV2F4OVFsQVQ5?=
 =?utf-8?B?YXZhVGJ2N3BnT2FNNStsblVXNVFFcVM2V0owY2xGOHdHRjFOUDRpUXArZDdi?=
 =?utf-8?B?NUNHUkZmSndXQTk2cWFQL3prSSs5RXpjNlYyV1R0T2V6eUdEUmVqL29QcVB0?=
 =?utf-8?B?bkdrdFZUTGROUVVra2NVSHlTM24xRWhIdDVLTkhneUw4ayttMDhGendzSWlC?=
 =?utf-8?B?NFJKUFZodzQvNlcvNS83N2s0TUp1ZEV1by93Y3dDTmZFbnU4aDVWcm93NXVP?=
 =?utf-8?B?dWxNYkR3Z2FhTU8xcnFGNmN0WWZnUHNaYUhhb1l5dGYrZnp0MXM0dXZLNVk3?=
 =?utf-8?B?Vzl2WHRWZGZNZmlQdUZvRXB2cnlsUmtrUjFHaGt6dXMxNmp2SWZZRlYxbzh3?=
 =?utf-8?B?N3ZncnYzZG5hM28xYW5MQmQvc25PYllEdVF5THozd3gvQlQ5bFlnVG4yZWVp?=
 =?utf-8?B?cGx5YVpBcVRuWjd2OWtaaUZjQjV4bVMrRVpVSUZ6T0F0NjJUb1ZoOHVmMERU?=
 =?utf-8?B?UzZUV2MvbTRCck5DelVrZXB1ZzliVDNoUlBkWTNOUW9lcTY4T0l3MlZWcTFF?=
 =?utf-8?B?UWdnU3FsbllHYWVLTVhsejkrdlFGNG1WdEVqYnFKUmFqVnhyYmYrak5Bb0Yx?=
 =?utf-8?B?Qk1LV1cxUDRiM2VTenB1VE5zcCtmdVFWMjFVNktBNXg0ZjBBWmpwb1VPRTVq?=
 =?utf-8?B?WTczUXhDQUpuYnR0cjBjb3ZVNTlxa2JPeVFnME9EcjRkYm9vL0NGRWhQRUcw?=
 =?utf-8?B?Z1FRWXowQW5zcVhBTDI3dHNKNUNzV2VXeTl6RkNxVFUvWG1rRC9QQmhDazZk?=
 =?utf-8?B?RzhxSHhQMzNuYzVPY1VNK3RWekZyRnBtb3B4d2dMdWI3em5Yd1lyZ2tqdFhp?=
 =?utf-8?B?N2hRbTQxeTIzak5yVGdVbnZMUUw3OXd0QkdDM3dSN1NIdVJZRlJjODIrTlg1?=
 =?utf-8?B?cVpSYnUxMmNNME01VHRWckE3Njd3azJodUxkeEhBSFBVb05vMU9UZm90dElW?=
 =?utf-8?B?QlArekdWWDRyR0IrVDB3Z1NRcExVMEVQVStNYTI1cVNDeXVtNFp2dHdmdnlO?=
 =?utf-8?B?NURXcHFOUWxndmF6NzBGZHlmOUozNTI4MEZGVDAzS0tTeGpXM1hGOTNYZlZw?=
 =?utf-8?B?QXA1c3ErRTBKUE5ucTZ4Y0Zlc25BaDU3UXphWEpweEgrTVVGUHhSVStXWUpT?=
 =?utf-8?Q?PokfBy8p8gRi/lRYWvkdJ4+kbUFu92h2rSd2J2J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzJzaXJlS1BSblUvbnNoRjUyQTNDcGRHNTR4M1p2RFFodmF0RjRGQ1VESjZi?=
 =?utf-8?B?TFFoUE91cEowNGVkc3psaEQ3V0ZmRjh5U0pIZmVlRUdEU3kzSS9WMG5WeUg0?=
 =?utf-8?B?Tkl3My9XRW9hYzVHT3loOW1kdkYyNjZFejlndFMrZVBTU3NoU2ZNbmhoVEda?=
 =?utf-8?B?QmIzcjA5QmFFcWw2NEh5bCt1TW1ONnhveDNwQmVkODN4WGlqY1pIeWJSY3RF?=
 =?utf-8?B?QTRVUUxreWQrZll0ZGF4VXk0QjZQaTlDbEYxWHhTUHhtNGluOHJzQ3ZaSGZw?=
 =?utf-8?B?ZHFzelorNDZ2bThUWXJrY3lEUVM1Qll2Qkk4ekdKaFd3ekVFSnc2dmZNUU42?=
 =?utf-8?B?NHk5SzVVQzFMZGdsM0ozL3Q3Tm1GU0t1NVhLMDRCOC8zZy84VW1wQWRsQ0Zn?=
 =?utf-8?B?dmZjZHpVaEZJMjlPUExMbXhMZXZ4SXZrSis1dU11czhVclZwSkMrc3BFSGxh?=
 =?utf-8?B?NWRrYi9LVnE1TCtGWElBOWZ5RFYzcDNEOWc1SVpTaUVlZVphUHFWS2lObSsz?=
 =?utf-8?B?RmJoaHNvNHU4dWRSdFBxeUd0Tjl2VG1qZS9KM1FDZUExN0lXSW41dHRjdkRk?=
 =?utf-8?B?NENLMWJ4aVVmR1FJSTZkWnl2WkJTQjc5bVJJb3BybzdyVDVLMHVpYVVWMXVH?=
 =?utf-8?B?Tng1aWNYaEJzczNxem0rL3dmb1VXNE45WXY2SUdyME5COGFTMzRURUM5TDVz?=
 =?utf-8?B?dml2NlgwMk16WSt0VFMrdUd6MmxxZ0tWVTcyKzlPSm9zN09wVENEOUtTbHo0?=
 =?utf-8?B?VkdPOTZxUFBmU1hCamhVVW1pTUZkVzJReEUxOTJJdUZiMU10T2dJeGpvRzBn?=
 =?utf-8?B?OG12eXBUZHlGQkdXQmMrL2xnM2RyMXVNcGgraFdrbGVUM0kvZVZCYS9xTDl6?=
 =?utf-8?B?WnBTc09PQ3Y3UzF5Z0FIcjRoZTd6VUtpMEhHaVI1WW9TSWJnMitGWGhQblFI?=
 =?utf-8?B?eWhpQzVQK2VXT3lUTitMM1FnV3lkaXlyUnIvbWJwdGtSTjVrQU4vYldyeHZ5?=
 =?utf-8?B?ekEwSkVueVhFczhQUXFwT1ZqckptcExMZmQxeDVDMGFBdytJeG1obkpoMFpx?=
 =?utf-8?B?dnlMc01VWHhpUG5JNFFUNC9uUXoyUklCOFdpOUJ0RTVlK2w4YXM5YWNUSjND?=
 =?utf-8?B?Sk5jYnFqSlNyQ0FKMDR3azVsVFNmSGxiN3JNbjJKc0IwQVIvMm50QS9SVW9r?=
 =?utf-8?B?SE0zQ0VqWndpVzQ5dmdPbVgzMHRkZlBFSytzaHRnZklvOXFiQkgxVGNkWVl1?=
 =?utf-8?B?YjBWc1FJV0VMVHNlbzZESVkzZ2Y3OHB2U3cvT2FYaTY3bU9McTBXTVRzODN2?=
 =?utf-8?B?WENDUFlveC84TDVlWk5hNVRDamJlWXl0YlRsT0JMaVMva25hcHpzUlZUVGs5?=
 =?utf-8?B?S2poamxDdmtIUXZCUjVOS1lHRUlnVm4wazcwT3ZNVUNJemNlTG5OTU1NZDF5?=
 =?utf-8?B?WlNMYWZ0QVN5MEFCYXdzb1pSMGdkK2tyOTRPT0dnOE9uZTkvUjVhOTUyWnRR?=
 =?utf-8?B?SWRjNHlMRXFtNjJyMnBMZGJjZDNmUFgwa092RnBqZi9aamthY1JiQkhlaC9r?=
 =?utf-8?B?RjhuTjZING1QTUliS2FMU1h0c0J5WHFQeFFheDlFRzVyU3pSM0xhci9MUUZ0?=
 =?utf-8?B?TUhLRWhkZ2ZZS0pvZEtuUzlqRFB6TU9rYUtXOVJhMXZlYWMvWXdYaEN6QnBv?=
 =?utf-8?B?S010aWM1dklCMWNSaFBySkZQenM0bXZ1WHNkem1jTEZEcGNMZDJPdTI1TENQ?=
 =?utf-8?B?THdEcTdlYXgyV1cvaXJGREUzYXFycXRUQ1dJcm9oNU82cnVjcFVuYjRzV00y?=
 =?utf-8?B?ckxVR254KzJPei9oVk1LdGtOQ1FDSlJVNC92b2dCdlQ1eVMxL1JDclE3OUlo?=
 =?utf-8?B?OVVNNlJ4QkhxV0NQN1ZzV3Ruc3pXK1FBYjQ5VFVhbC9ZcDF3aFhram1yRnRt?=
 =?utf-8?B?TXo3RXQwdG9JN1FkUGVkMXhVY01TdGF0WEFMRmNkTEtiZTN2ejk0MWFWM1U3?=
 =?utf-8?B?WHA5NVdDNUFnTU5OUFNVZ1J2R2s1QTBRVXBJdCtWazJscHJLZFJRaWphekpi?=
 =?utf-8?B?RFNlZ1B0dVlybDBJTDZidmRxSWkxeEVtVU55T3pnWjVGUWV0K3ZuSWRReHpn?=
 =?utf-8?B?eU0zRGl3aE1FVjh2bXJxUzBhUmdFV1ovWXdqNWlDY0lidTJPSTFoK2xoWWZl?=
 =?utf-8?Q?eoWNr8UCPumpZed3eztPQvE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PDTi8jsZX2Xe1Cc2uOXnxGTaJfQEf5gQzX2/ib2nnhfKHrcjFDR/+463LlpPSyOcpN4rZSmqBczKk2bLnH7CWDrLANaWBc/JI7prcqxOWUBG+EFebdjlhM/A40fgPddx7Q9fMsQ2xR7LS2q8pNvAyj/DAF5pXeuwUfs44Z+nMOJKVksm2FiDSLsBV5kucknhEQfvPZFQdW0fMisCRaHnHH3gi9bxiuErP25ULMfBX1+1/7h4LwKH2u30kBr5RCCN0BCbxqyRkb/OVYnoYkeejg6CT02HN+LTOsGbRwpcWhikdDOMF0umlpihm/OBQyyzJ3DbIQAE2iLiSSeh8790iCJkbZps7Y1bhyo5GgxDV8KO03HyxdGAFIwKIXOBgFmmi8nlmWJgx9xWPi0WSJ3iWr1RXnPNZ1FzSYw49vkZaSh7AK5SKQb43bgiTAxjcQqEX8liaBfEPajResGevow7385NuWZBBGOnP3k2+unJXjVvIoA6bQ8QwrGHNKafpkTUqjtpATBz6SI0+gCM8YIJan0t1ZukY5/MsBiuHfuD88kMBzjT96Y/CY25YY9GL4BRClBPHy7gP8X3/MN2J/r6ymMSFxRBKepw3KsI5O/qus8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdea8b9-81ff-4a7d-ad59-08dd03488938
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 18:33:43.3130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5z4Yhy4JbgOztYy8gbQEnQvnKfrxzOVMVsdzUAE3RFSnJ27WTS1/YcnsX93rrkMxjE7OAXxFxzLdn0racWVQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_08,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120148
X-Proofpoint-GUID: cPveq3Vna6pXh9wcziCVCrvUEerinLOp
X-Proofpoint-ORIG-GUID: cPveq3Vna6pXh9wcziCVCrvUEerinLOp

On 12/11/2024 17:07, Yonghong Song wrote:
> 
> 
> 
> On 11/12/24 8:56 AM, Alan Maguire wrote:
>> On 12/11/2024 01:51, Yonghong Song wrote:
>>>
>>>
>>> On 11/11/24 7:39 AM, Alan Maguire wrote:
>>>> On 08/11/2024 18:05, Yonghong Song wrote:
>>>>> Song Liu reported that a kernel func (perf_event_read()) cannot be
>>>>> traced
>>>>> in certain situations since the func is not in vmlinux bTF. This
>>>>> happens
>>>>> in kernels 6.4, 6.9 and 6.11 and the kernel is built with pahole 1.27.
>>>>>
>>>>> The perf_event_read() signature in kernel (kernel/events/core.c):
>>>>>      static int perf_event_read(struct perf_event *event, bool group)
>>>>>
>>>>> Adding '-V' to pahole command line, and the following error msg can
>>>>> be found:
>>>>>      skipping addition of 'perf_event_read'(perf_event_read) due to
>>>>> unexpected register used for parameter
>>>>>
>>>>> Eventually the error message is attributed to the setting
>>>>> (parm->unexpected_reg = 1) in parameter__new() function.
>>>>>
>>>>> The following is the dwarf representation for perf_event_read():
>>>>>       0x0334c034:   DW_TAG_subprogram
>>>>>                   DW_AT_low_pc    (0xffffffff812c6110)
>>>>>                   DW_AT_high_pc   (0xffffffff812c640a)
>>>>>                   DW_AT_frame_base        (DW_OP_reg7 RSP)
>>>>>                   DW_AT_GNU_all_call_sites        (true)
>>>>>                   DW_AT_name      ("perf_event_read")
>>>>>                   DW_AT_decl_file ("/rw/compile/kernel/events/core.c")
>>>>>                   DW_AT_decl_line (4641)
>>>>>                   DW_AT_prototyped        (true)
>>>>>                   DW_AT_type      (0x03324f6a "int")
>>>>>       0x0334c04e:     DW_TAG_formal_parameter
>>>>>                     DW_AT_location        (0x007de9fd:
>>>>>                        [0xffffffff812c6115, 0xffffffff812c6141):
>>>>> DW_OP_reg5 RDI
>>>>>                        [0xffffffff812c6141, 0xffffffff812c6323):
>>>>> DW_OP_reg14 R14
>>>>>                        [0xffffffff812c6323, 0xffffffff812c63fe):
>>>>> DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>>>                        [0xffffffff812c63fe, 0xffffffff812c6405):
>>>>> DW_OP_reg14 R14
>>>>>                        [0xffffffff812c6405, 0xffffffff812c640a):
>>>>> DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>>>>>                     DW_AT_name    ("event")
>>>>>                     DW_AT_decl_file       ("/rw/compile/kernel/events/
>>>>> core.c")
>>>>>                     DW_AT_decl_line       (4641)
>>>>>                     DW_AT_type    (0x0333aac2 "perf_event *")
>>>>>       0x0334c05e:     DW_TAG_formal_parameter
>>>>>                     DW_AT_location        (0x007dea82:
>>>>>                        [0xffffffff812c6137, 0xffffffff812c63f2):
>>>>> DW_OP_reg12 R12
>>>>>                        [0xffffffff812c63f2, 0xffffffff812c63fe):
>>>>> DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>>>                        [0xffffffff812c63fe, 0xffffffff812c640a):
>>>>> DW_OP_reg12 R12)
>>>>>                     DW_AT_name    ("group")
>>>>>                     DW_AT_decl_file       ("/rw/compile/kernel/events/
>>>>> core.c")
>>>>>                     DW_AT_decl_line       (4641)
>>>>>                     DW_AT_type    (0x03327059 "bool")
>>>>>
>>>>> By inspecting the binary, the second argument ("bool group") is used
>>>>> in the function. The following are the disasm code:
>>>>>       ffffffff812c6110 <perf_event_read>:
>>>>>       ffffffff812c6110: 0f 1f 44 00 00        nopl    (%rax,%rax)
>>>>>       ffffffff812c6115: 55                    pushq   %rbp
>>>>>       ffffffff812c6116: 41 57                 pushq   %r15
>>>>>       ffffffff812c6118: 41 56                 pushq   %r14
>>>>>       ffffffff812c611a: 41 55                 pushq   %r13
>>>>>       ffffffff812c611c: 41 54                 pushq   %r12
>>>>>       ffffffff812c611e: 53                    pushq   %rbx
>>>>>       ffffffff812c611f: 48 83 ec 18           subq    $24, %rsp
>>>>>       ffffffff812c6123: 41 89 f4              movl    %esi, %r12d
>>>>>       <=========== NOTE that here '%esi' is used and moved to '%r12d'.
>>>>>       ffffffff812c6126: 49 89 fe              movq    %rdi, %r14
>>>>>       ffffffff812c6129: 65 48 8b 04 25 28 00 00 00    movq    %gs:40,
>>>>> %rax
>>>>>       ffffffff812c6132: 48 89 44 24 10        movq    %rax, 16(%rsp)
>>>>>       ffffffff812c6137: 8b af a8 00 00 00     movl    168(%rdi), %ebp
>>>>>       ffffffff812c613d: 85 ed                 testl   %ebp, %ebp
>>>>>       ffffffff812c613f: 75 3f                 jne
>>>>> 0xffffffff812c6180 <perf_event_read+0x70>
>>>>>       ffffffff812c6141: 66 2e 0f 1f 84 00 00 00 00 00 nopw    %cs:
>>>>> (%rax,%rax)
>>>>>       ffffffff812c614b: 0f 1f 44 00 00        nopl    (%rax,%rax)
>>>>>       ffffffff812c6150: 49 8b 9e 28 02 00 00  movq    552(%r14), %rbx
>>>>>       ffffffff812c6157: 48 89 df              movq    %rbx, %rdi
>>>>>       ffffffff812c615a: e8 c1 a0 d7 00        callq
>>>>> 0xffffffff82040220 <_raw_spin_lock_irqsave>
>>>>>       ffffffff812c615f: 49 89 c7              movq    %rax, %r15
>>>>>       ffffffff812c6162: 41 8b ae a8 00 00 00  movl    168(%r14), %ebp
>>>>>       ffffffff812c6169: 85 ed                 testl   %ebp, %ebp
>>>>>       ffffffff812c616b: 0f 84 9a 00 00 00     je
>>>>> 0xffffffff812c620b <perf_event_read+0xfb>
>>>>>       ffffffff812c6171: 48 89 df              movq    %rbx, %rdi
>>>>>       ffffffff812c6174: 4c 89 fe              movq    %r15, %rsi
>>>>>       <=========== NOTE: %rsi is overwritten
>>>>>       ......
>>>>>       ffffffff812c63f0: 41 5c                 popq    %r12
>>>>>       <============ POP r12
>>>>>       ffffffff812c63f2: 41 5d                 popq    %r13
>>>>>       ffffffff812c63f4: 41 5e                 popq    %r14
>>>>>       ffffffff812c63f6: 41 5f                 popq    %r15
>>>>>       ffffffff812c63f8: 5d                    popq    %rbp
>>>>>       ffffffff812c63f9: e9 e2 a8 d7 00        jmp
>>>>> 0xffffffff82040ce0 <__x86_return_thunk>
>>>>>       ffffffff812c63fe: 31 c0                 xorl    %eax, %eax
>>>>>       ffffffff812c6400: e9 be fe ff ff        jmp
>>>>> 0xffffffff812c62c3 <perf_event_read+0x1b3>
>>>>>
>>>>> It is not clear why dwarf didn't encode %rsi in locations. But
>>>>> DW_OP_GNU_entry_value(DW_OP_reg4 RSI) tells us that RSI is live at
>>>>> the entry of perf_event_read(). So this patch tries to search
>>>>> DW_OP_GNU_entry_value/DW_OP_entry_value location/expression so if
>>>>> the expected parameter register matchs the register in
>>>>> DW_OP_GNU_entry_value/DW_OP_entry_value, then the original parameter
>>>>> is not optimized.
>>>>>
>>>>> For one of internal 6.11 kernel, there are 62498 functions in BTF and
>>>>> perf_event_read() is not there. With this patch, there are 61552
>>>>> functions
>>>>> in BTF and perf_event_read() is included.
>>>>>
>>>> hi Yonghong,
>>>>
>>>> I'm confused by these numbers. I would have thought your changes would
>>>> have led to a net increase of functions encoded in vmlinux BTF since we
>>>> are now likely catching more cases where registers are expected. 
>>>> When I
>>>> ran your patches against an LLVM-built kernel, that's what I saw; 70
>>>> additional functions were recognized as having expected parameters, and
>>>> thus were encoded in BTF. In your case it looks like we lost nearly
>>>> 1000
>>>> functions. Any idea what's going on there? If you can share your
>>>> config,
>>>> LLVM version I can dig into this from my side too. Thanks!
>>> Attached is my config (based on one of meta internal configs). I tried
>>> with master branch with head:
>>>
>>> 7b6e5bfa2541380b478ea1532880210ea3e39e11 (HEAD -> master, origin/master,
>>> origin/HEAD) Merge branch 'refactor-lock-management'
>>> ae6e3a273f590a2b64f14a9fab3546c3a8f44ed4 bpf: Drop special callback
>>> reference handling
>>> f6b9a69a9e56b2083aca8a925fc1a28eb698e3ed bpf: Refactor active lock
>>> management
>>>
>>> I am using pahole v1.27.
>>>
>>> I am using an llvm built from upstream. The following is llvm-project
>>> head:
>>> beb12f92c71981670e07e47275efc6b5647011c1 (HEAD -> main) [RISCV] Add
>>> +optimized-nfN-segment-load-store (#114414)
>>> 6bad4514c938b3b48c0c719b8dd98b3906f2c290 [AArch64] Extend vector mull
>>> test coverage. NFC
>>> 915b910d800d7fab6a692294ff1d7075d8cba824 [libc] Fix typos in proxy type
>>> headers (#114717)
>>> 98ea1a81a28a6dd36941456c8ab4ce46f665f57a [IPO] Remove unused includes
>>> (NFC) (#114716)
>>>
>>> With the above setup, when to do
>>>
>>> pahole -JV --
>>> btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs vmlinux >& log.pahole
>>>
>>> You will find the below info in the log:
>>>    skipping addition of 'perf_event_read'(perf_event_read) due to
>>> unexpected register used for paramet
>>>
>>> In the dwarf:
>>>
>>> 0x02122746:   DW_TAG_subprogram
>>>                  DW_AT_low_pc    (0xffffffff81299740)
>>>                  DW_AT_high_pc   (0xffffffff812999f7)
>>>                  DW_AT_frame_base        (DW_OP_reg7 RSP)
>>>                  DW_AT_GNU_all_call_sites        (true)
>>>                  DW_AT_name      ("perf_event_read")
>>>                  DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/
>>> events/
>>> core.c")
>>>                  DW_AT_decl_line (4746)
>>>                  DW_AT_prototyped        (true)
>>>                  DW_AT_type      (0x020f95f5 "int")
>>>
>>> 0x02122760:     DW_TAG_formal_parameter
>>>                    DW_AT_location        (0x00769b72:
>>>                       [0xffffffff81299745, 0xffffffff81299764):
>>> DW_OP_reg5 RDI
>>>                       [0xffffffff81299764, 0xffffffff81299937):
>>> DW_OP_reg3 RBX
>>>                       [0xffffffff81299937, 0xffffffff812999f0):
>>> DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>                       [0xffffffff812999f0, 0xffffffff812999f7):
>>> DW_OP_reg3 RBX)
>>>                    DW_AT_name    ("event")
>>>                    DW_AT_decl_file       ("/home/yhs/work/bpf-next/
>>> kernel/events/core.c")
>>>                    DW_AT_decl_line       (4746)
>>>                    DW_AT_type    (0x0210f654 "perf_event *")
>>>                      0x02122770:     DW_TAG_formal_parameter
>>>                    DW_AT_location        (0x00769c61:
>>>                       [0xffffffff81299758, 0xffffffff81299926):
>>> DW_OP_reg6 RBP
>>>                       [0xffffffff81299926, 0xffffffff812999f0):
>>> DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>                       [0xffffffff812999f0, 0xffffffff812999f7):
>>> DW_OP_reg6 RBP)
>>>                    DW_AT_name    ("group")
>>>                    DW_AT_decl_file       ("/home/yhs/work/bpf-next/
>>> kernel/events/core.c")
>>>
>>> The above is slightly different from our production kernel where Song
>>> reported. But essence is the same.
>>> The second parameter needs to check DW_OP_GNU_entry_value(DW_OP_reg4
>>> RSI) to ensure the second
>>> argument is available.
>>>
>>> My patch is supposed to only make improvement. I am curiously why you
>>> get less functions encoded in BTF.
>>>
>> Thanks for the config etc! When I build bpf-next using master branch
>> llvm and this config, I see
>>
>> with baseline (master branch pahole): 62371 functions, no perf_event_read
>> your series on top of master branch pahole: 62433 functions,
>> perf_event_read present
>>
>> So that's consistent with what I've seen with other configs; more
>> functions are present in vmlinux BTF since we are now seeing more cases
>> where parameters are in fact consistent.  The part that confuses me
>> though is the numbers you initially reported above
>>
>> "for one of internal 6.11 kernel, there are 62498 functions in BTF and
>> perf_event_read() is not there. With this patch, there are 61552
>> functions in BTF and perf_event_read() is included."
>>
>> These numbers suggest you lost nearly 1000 functions when building
>> vmlinux BTF with pahole using this series. That's the part I don't
>> understand - we should just see a gain in numbers of functions in
>> vmlinux BTF, right? Did you mean 62552 functions rather than 61552
>> perhaps?
> 
> Sorry, really embarrassing. it is typo. Indeed it should be 62552 functions
> in BTF instead.
>

No problem, makes perfect sense now, thanks! I'm trying to reproduce the
core dumps Eduard saw now with this setup; I'll report back if I manage
to do so and see if locks as Jiri and Arnaldo suggested help. If so a v2
along the lines of Eduard's suggested change plus locking might be the
best approach, what do you think? Thanks!

Alan

