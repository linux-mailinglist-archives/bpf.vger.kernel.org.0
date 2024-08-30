Return-Path: <bpf+bounces-38587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE594966870
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 19:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EE51C23B40
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39330192D77;
	Fri, 30 Aug 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cusHbbUU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w4cfJVrX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582AD15098E
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040452; cv=fail; b=DdRBCi2Vvc2KQKPBctN0QKVTWoPbK5R5OTrQGgr6Wiez/C90tZ7z8Hm67CaCTOT1NA6tKSYUegaP3+/lvznJqJKVcjifMfUkaMTmo2nuwR0C4FXfMJmGsv3XQ/oezHbMTjwM4lxQriHNnJuX/w1xbof5l5s+CSwFSRVJvPq89Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040452; c=relaxed/simple;
	bh=uqqqNhcQ0PUQVKqyzAFohgnGFp3qLa23uaOg+fJn9RM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wixnw9f8toHsH/DIGwq9i/jRLieTKBYacyy0aBDhHT3MHy6FjOnA1TCur29m5Cseggc9u7YdC+qxk5FD/6dZYPcz2nd2xqQ+Xh9+fKxm0KyhEUd8Bn6k7LnOyqMrYYXchKXgnf96Lz0ERyQDkRv9E+AHUYkA/KGaNsKk5zE7lW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cusHbbUU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w4cfJVrX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UHfYGO011009;
	Fri, 30 Aug 2024 17:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=lfO7tjv/AGgKz8UTQA8mbqeqqveZpx1S17nhLeVcOLY=; b=
	cusHbbUUuMSa9hPbcv7zL89b/K997jaFVMxNP2e1uWcYovnaCenENxPWY/fRsr+6
	7d7MdfRSIvOb2YN6tUJwrXenz7JFEYKy+rMw36pnaRvpiw0Hd8a5PgKsvckyF7f2
	sED9FJ3VjrkXvgcD4OyWEvfBTOIhgnmAZgsjXx9ACSsifRul5jvMeBRDTXA/Lv6/
	16R/27OkukWh6XI1tyKKucGJnlXqCC+JZuQdosrULZYlSYIn/s8B5mxOqXvRl0Qi
	fY3Wk/cKHfPjt4lBq0jhRniKCfzlpAgm37LFp1JkYHrxhVaR5+chfeVPeIfUD8nx
	V4bpzHdDoeKQ4vO0GAR6eQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bh8t84v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 17:52:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UHe8hU031774;
	Fri, 30 Aug 2024 17:52:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0ybsgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 17:52:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AklW60PPcOHQtylf8tMVO/sqKBm5Gffn4S/5cInpfsdIj1mSuGrCd14P14PDIzOTISKy5UIN6kkODeTECmo2xfXcvH7+EgJv0LQB2vcVCWUqeRqWI9C/ZFYjYTOH0HC0VSiDwHczKRPXHjJuMcY1Gt9PjLjPNqhPVXSHoBf+hoQC0e7/asj6gFVMaOdV17kzVNAVqXskbuqPJGXDMN4KAiMpAHCEayMEkkJtXW1M7XSW1wwxPR4qnC5y3bbDPcU7oOuciKZQ+2uIfV5YVG8iRR06LCVHW9Pgg3zEbIU/50fQz3LyWoV0SATbQ9bmQeGPxkuUjPiD7yUju6Tbsz3PNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfO7tjv/AGgKz8UTQA8mbqeqqveZpx1S17nhLeVcOLY=;
 b=dutybv0ZkAp1f1rUQum3oJwjHKrjIPY3cox3CxYawXHZonJ1SSO93NAMhzPWKLr3wlUeO3f+daqW4sg2PsDRBCVNOlwq1yidlzqHjCjtFNSr2TBjWzc8HnoaB1JGDn04y1cENxoUrPs424GGAOSnHmZKew0bs52Mc0TfkWV2+T0ufhjNAXQiYK1JNOEmVi4bRnBLIMD07TphS1UWyZY4NzJdnjg5bdQnmv3oxeJVVuiYMRZYGkt+u611oy3hHhQuNNPsZAATvTRY6xmrKXNXLK9NcEb78mWbyRPR1Q6ROAzqoQsZe8WqQhWDhHy+p1EwryNaRo5rle8fiB5syKVpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfO7tjv/AGgKz8UTQA8mbqeqqveZpx1S17nhLeVcOLY=;
 b=w4cfJVrXDmWuLhuGt8Dwh37PQs4ZOJ9hjDh5LsYVrU2mW4LwXyKch42dGZb4uyQ1mZjtzKmH4QPpQrMgr/zJv31jCwQmDXiyDhDvHxKirV+BWRNCLA6scoOZ6YvIKQoS2qlgsijNBezS1rdA7kZA7z3HRzEvPstukLOVKSzKCSQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB6605.namprd10.prod.outlook.com (2603:10b6:303:229::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 17:52:31 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 17:52:31 +0000
Message-ID: <e3cd9ac9-2c19-454e-833c-08c4ad450b77@oracle.com>
Date: Fri, 30 Aug 2024 18:52:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: check if distilled base inherits
 source endianness
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yonghong.song@linux.dev, tony.ambardar@gmail.com
References: <20240830173406.1581007-1-eddyz87@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240830173406.1581007-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b994ce0-1f98-4866-3770-08dcc91c852c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1huSWhiUHdiNnBOd2RiVHpGdXNabWZpRXk4WE1MbjA0VmdBcm4yUGdNc25D?=
 =?utf-8?B?eWRSZXVITE5wVmtNNXVjZFhqNDZiQkd3eFJkbncxQTZZc3ZOeFk3cUtHYTZI?=
 =?utf-8?B?WXFFRHVweE54T014cUVuUVNaUDJ5QWlIbEdXNHJlQ2tiMEUybUZkYTZNSmZq?=
 =?utf-8?B?UzRVUkhuYmtOMjBiUUVwWHgzSTllbUhNQ1lkQ1lnUm9xeEFjL2hBSEFVMHZC?=
 =?utf-8?B?M3ZITnZhY2NpM2Jyc3U0aEZuekZtdCtUU29VZ2xBRUp1dXhJUGQ3ajhOMEx1?=
 =?utf-8?B?NWs4NEVMRlAzQ3k2R1M4OUN0WkhtdHZYcjl5QWh3SFRjeGZrZDhsM3ZYVnRG?=
 =?utf-8?B?bXFDOUdsN1hzSSt1TDdndjlWNjZwb20xYSsrTWtNM3Q5bnk3U0FLd2hqYmUx?=
 =?utf-8?B?Z05nemNURUZxZXVkYkhtT1lScXZGVTNUa3hSdXoxL20rdkxVQUM4SEx5Mjdq?=
 =?utf-8?B?MU1yY2ZwVTBxOVZsYmRqRWNzVVNKMC9iU3hPNExhMEd1cWQxY3VaZHMxZGp4?=
 =?utf-8?B?VGlZMGNLRTBxcDh2STI3Z01UL05jRzZVQU1RL2pPbEh0UkxsSFFUL3BkZzhG?=
 =?utf-8?B?cktxcG83R2FhSVFMb0pDM0gvNE1xS3Y3L2lXRGNvZDBnY1FHZ1lSK2dtWElu?=
 =?utf-8?B?dW5hTWpXdUdaVlNEVW1kMi9xMm4xRFRwSzJGK1Z0SXloMUNYUzNObi84eEEw?=
 =?utf-8?B?Rk5MZTNpcXB6dHRDTXQrNmlqWGpNQmhmQmVVNStGVUV4N3hOL3lwTDNvN25t?=
 =?utf-8?B?YXZtcC9SallaVGh6NldvTUt6STU4L3RmZ2UzRk1UVDhsT3FMZy9ZRms2WmN6?=
 =?utf-8?B?N1VBRHRmdXI2RTVrTGpmRlF1LzF4R1k3eDEzenRrVGczZm5OcjR5VGVySXgv?=
 =?utf-8?B?T2hVZmU3UVhsS1FYRFVISXVFSjZLckNudWl4TXR0S1pqeUtIRGRvUDVmMzAr?=
 =?utf-8?B?Sks2UDNneUxNRXNjbyttckJ6OHhORXp5NHVSM3gyWnZhekJJZ1JBUUw1Z01o?=
 =?utf-8?B?T2prMWpFY08xNGNEZ3R3ZDRsdVpFT29pRlk5amdiRU1hK1AvMXh1VjdoMDk1?=
 =?utf-8?B?Q1RXbjlnd1pHNmEwbmFRUVFYVWlWbEVqczRjVDMwVDBJbVJDZ3pQMER1OGdy?=
 =?utf-8?B?dDF0VXBTeFBSc2FhN092Q04wd2JqUTgzck1IaDZ6NUx4S0ladGs0NlliblFK?=
 =?utf-8?B?MUFHdzhxTGZsSjduUGVqbm5BZ1NzcEk3cENndXZCbXRMcExBUkdUU1EzV2RB?=
 =?utf-8?B?V2lOYVFWVGtXVzVrVSt0ak8xSFJhNnFVb2Z0cS9adjVuOGJJbS9GZ3luVW02?=
 =?utf-8?B?VEExeHFtN2ZKaUFUbmEzdXU5YTNGYWFIeEhRSSswejE2SUhjckNKQXk3aUNZ?=
 =?utf-8?B?WWx1ZFB1TUVLN1NjMExHcVVscG9BOGc2MDVLbzJnd3VYNTVpd0l0TUVHZmwr?=
 =?utf-8?B?TXZqa0txakd1VnlQc1p5dFhLOXE2UjNWeVRkTG0rM3dEdk16WXFvbjVyK1Jy?=
 =?utf-8?B?VGVqeWNDaysrbkdTOXg5VzRMRFAxQytQbDJmdk93ZlF1SE15aHZIN1ZQVHdU?=
 =?utf-8?B?Nm5nYUVXcVV4b3o2alQwNWJhcGJvQVlsUTZkV2dXZ3J5T1FGdDhZNWQyWkhn?=
 =?utf-8?B?TmN2SEkvdVpIaEJ3K2poVnoxalkvdzNwSUJCNUg1WlhNaWhvUHJGTVY0SVBu?=
 =?utf-8?B?NjNTSmtaTTg2d21BZWo1TkRTemJyZDkwWGxHVzNxRyswR1FFcml6ajQxZ1Bo?=
 =?utf-8?B?RExZU0l5NnJkN09uVGFKRWlva1hlT082ZjRvM1F3YjFOWFpReTdZelF0N3RN?=
 =?utf-8?B?bDRjd1lVOGdHbjlXR0tRUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTdaYmFRdlJ5a2NibGFldUhYMzRiZzZ4SnIrNGhWdUsxeGJYUmttTzlaZlA2?=
 =?utf-8?B?bVkxSUpJQlhvUjVMMklMckVaNko3Z09pOWRTMGt6WGhTelBHRTJ0eTNoTVNY?=
 =?utf-8?B?RnVIVFp4aGxlM3N1RlpJdW5wdHRMaWFvcFdwcERFcnRnZ1JEaHJaS3UwWG5J?=
 =?utf-8?B?UXVPS2Y5TEJKbzkzYzAyUmhKZUFhdXNtRU4vSEhjYkc1OE5yWU0wMDFEaWVE?=
 =?utf-8?B?dnh3VldwVVk0NVhvdjFEazVTdzdnbC9vMGpjVjlyaFhwSVFNOXBKMVk2Njdv?=
 =?utf-8?B?UjRwcHFja2Y3anZhMUx1K3RPVjMxaXhOTVE4NWFaeG9Vc1FCVS9ISEdzWU05?=
 =?utf-8?B?RCs1SEZ0anRxTEJlb29MUE15NHZiMnRDU2laZUNPak9QVnROVGhGbGplS3VP?=
 =?utf-8?B?QjhlWU0rMnVFUkhhMkJQSDJYck1FbVF2V3c4Z1FJYWVvanpueW4vZG54dUIy?=
 =?utf-8?B?bjdjU1RoejBycnRNdlJnQXFZSzF6dUJrd3IybzFQU2xvV29kTlhNK1Jpd2Mx?=
 =?utf-8?B?NCsrWU9lTm5LTmZSZ3Z2ZzEvWHUxWmNyKzVsWWJ0YjI1UllZZHBFNXdZRnhh?=
 =?utf-8?B?OHhGUTNaN3lSekFHQTl6WlZudXZVOE5jKzJESUNzU3dKQzFhQlUzQzU0Ymdm?=
 =?utf-8?B?d2FXMkc0c2lpNU9WS3FPYm9kd0tnWWsyRFVsMk5RQ2JTSjJDY1EvNi9IWnlx?=
 =?utf-8?B?Q3BtWkhIenIrUWNNSzB1SUJMZG1GajFCaEMrWjIrUk9OVkRaaWp4QzFYTWlq?=
 =?utf-8?B?MmdBTXNlOVRNUjdoQmlJaDBiQS9ZcDkzd3ZxQnlpV1hablJ1S01iODUwWlQ0?=
 =?utf-8?B?QlY4MCszS3k3TENTNkkwZHZkUHdSV3lXWGVLRnY3UjNsSU5ONDNsRlRtY2Q5?=
 =?utf-8?B?SFB0UzBqY3luQ2RmemxVMzNjMCtwclptY0VaSlczcmY5RXZjSTdZUjlqVVdE?=
 =?utf-8?B?QkJ1WWZ4Wm5lZndtbHdEb3pXY24wWENiWUNtTHA3M0JOb0RSWGRUTDhIR21h?=
 =?utf-8?B?SXQ2ZVowQ0w0Y2p6cGIzd25nejBqaUNoZHdPQVJtd2t3NjdMb0k3TWpZTThp?=
 =?utf-8?B?TW1iYldPRW1LWmxncVRISTM1TFJhck1oTHJMcVhUd1ZKRWxOM2ZWQjFUV3Ro?=
 =?utf-8?B?alpscHNWTjU3UkZYaDcvUFNBWnNFdFNzYWwrdjRpdnFqZVhCWHY4c1kzL0th?=
 =?utf-8?B?YUFJSkwwaVNtVjF1VnY3UWxuK2JUc1d2SWhVeVp5L1FNYmpyMEdvNXdCQWdp?=
 =?utf-8?B?V3lVaXN4dXVUTzdYZStyYnNqTlZ1dDZsczVzOTlZWmZGTittTTVLWFBXdnhi?=
 =?utf-8?B?WUFGa29XOHJRNUlEWXFDRElrck9qUTdJMTdZSENHbGprbEZoL3UzS0s0bC9E?=
 =?utf-8?B?bG85Z3BLQUtybTI3Qlk1bnZKRW14QmxubFNrUXIvUzB1ZnJnUFMrUWF0dlpn?=
 =?utf-8?B?WXFiVHNnSWpxM1ZYZXk4dzFlb29nMm1PMTd0dWtNUVZ6MDBWZGNGODFzSSs0?=
 =?utf-8?B?eCtraDZsb3hNcXVlY1dOVmEzR1FFbm1BRVd0QVB2L3VrMklDQUJZSlRWa3hQ?=
 =?utf-8?B?T0RJbW5lVWg1MElzTnBkUXJEZytFdDBPSjFLSVhJR2hySFVSTm1MZWtzYzBC?=
 =?utf-8?B?SEIwOGFQWjdMUjRKUUxrV3RpdGJjMWNyenZ2QzhsUkhQYXhPcS9HVUtIRTJM?=
 =?utf-8?B?UkFiOWpQdDZOWmVYQU1PNkp4dE1yYjBiUkNWQi9SVkUvVWVnNm03Vk5KT3RT?=
 =?utf-8?B?aDZWaHlORVozdm9CYVYxS0hIbUJGeXJFMDdrMWgwdi9tVDJiSHVwaUVqZHEr?=
 =?utf-8?B?QmhmWDhzcUJ1ZnhQVDRSUzFlRll6ejJxSms0TjhYaVZZQ3F2MUVJZStmWU8z?=
 =?utf-8?B?K2tGWTBmZmowWXlZWUNUZFN1R2g0WVpNSFFlTlFUeVVMbll5ZVdCMW9BK1Jv?=
 =?utf-8?B?cmFDR3U3elVDM1BpT0pZNmFsaGh5R0t2Y3YxZGF2YmFuazU2TDduN0YxUmkr?=
 =?utf-8?B?TWMwRmdRVUwxT0JyUTdsMlBzY1BMbXd4bnhYVWhvanpTaDVQYzB1NThoZzIr?=
 =?utf-8?B?ejV5L1I5RS93SGFJMStOQTBjQXl3YjM4U3JJTU9GR1kyVCtLTzFvU2tTSjRD?=
 =?utf-8?B?TmRNV1ltc2NEa2Y0ekV1V2JleDBTeUJ1cFc4eXZXMFdnTHVNRGo5Wm5Tbjdz?=
 =?utf-8?Q?ytNs/Nf190XJa2fPr306zfQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yNX6uI0hwnUYtSwUJon4+IanyAgt4iZSD3suUoiX8fzAizRmdEMh7VrAbhVfSazWzVHi0eGdQVKjT2cvnwvAUVJq8rqws5ByzMj4KED0zE3aoKhq2Bx2Q13GQ8adcsiyz/cOYjCZyTpWNhtA0yff3mf1wcpFVe2c+39UHYigDujTs1qXe+LjAvFFcKyWZdUvd+TRD1dtbWqIQhiMDUyqXEFTkBINCnIFBGMKfdJhiHbH7Cx5n4NEDjj5UllpLttnLX09TjnuZaXCe/rbEzjiB+/L5s9RPqb7kqrnK0ZHziPdkShT9TVRK4ixrS4t+tqj+hk/Z1wPkEeZ1jg4sz5p989Bw003vu+amjaUtt0iRTKGGD0ho9FmxRq7SIvDR7QW3ZE2RnAibLS1ohlUFR0G3dIyRiwdZlUVp/C4T9DBJw/b6EMvwbA1Zi41pMJnScSpFsauEJxdku/ywwJU0JCyTmu5nGdlLRM0T9PyAYIZGJu+gBsX3zLt6i+wCpnpMUJIXE9V0ucuBQH4S0QuuKzS/KJL3Dyjf3cKN+iUEypJ3knjXKI3LYikOXQdvKuhU3se8iy/aCQgT31cxFr7oozljSbC1xysXb3dO3+8HbZsaOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b994ce0-1f98-4866-3770-08dcc91c852c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 17:52:31.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUwjbyc4xWLs6CW3HAyrMNcE3bzyKtHGCIKlXJQOOmLovoGkV162QFyU1JlO9rba9M/BnKWkrLQxjfXE675Ckw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300135
X-Proofpoint-GUID: xfJQERJxMghfOm3-HhRlBy-s_qu4wJqJ
X-Proofpoint-ORIG-GUID: xfJQERJxMghfOm3-HhRlBy-s_qu4wJqJ

On 30/08/2024 18:34, Eduard Zingerman wrote:
> Create a BTF with endianness different from host, make a distilled
> base/split BTF pair from it, dump as raw bytes, import again and
> verify that endianness is preserved.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

One small thing below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

Thanks!

> ---
>  .../selftests/bpf/prog_tests/btf_distill.c    | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> index bfbe795823a2..810b2e434562 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> @@ -535,6 +535,77 @@ static void test_distilled_base_vmlinux(void)
>  	btf__free(vmlinux_btf);
>  }
>  
> +static bool is_host_big_endian(void)
> +{
> +	return htons(0x1234) == 0x1234;
> +}
> +
> +/* Split and new base BTFs should inherit endianness from source BTF. */
> +static void test_distilled_endianness(void)
> +{
> +	struct btf *base = NULL, *split = NULL, *new_base = NULL, *new_split = NULL;
> +	struct btf *new_base1 = NULL, *new_split1 = NULL;
> +	enum btf_endianness inverse_endianness;
> +	const void *raw_data;
> +	__u32 size;
> +
> +	printf("is_host_big_endian? %d\n", is_host_big_endian());
> +	inverse_endianness = is_host_big_endian() ? BTF_LITTLE_ENDIAN : BTF_BIG_ENDIAN;
> +	base = btf__new_empty();


nit: I think you could avoid the need for is_host_big_endian() by doing
this:

inverse_endianness = btf__endianness(base) == BTF_LITTLE_ENDIAN ?
		     BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;


> +	btf__set_endianness(base, inverse_endianness);
> +	if (!ASSERT_OK_PTR(base, "empty_main_btf"))
> +		return;
> +	btf__add_int(base, "int", 4, BTF_INT_SIGNED);   /* [1] int */
> +	VALIDATE_RAW_BTF(
> +		base,
> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
> +	split = btf__new_empty_split(base);
> +	if (!ASSERT_OK_PTR(split, "empty_split_btf"))
> +		goto cleanup;
> +	btf__add_ptr(split, 1);
> +	VALIDATE_RAW_BTF(
> +		split,
> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
> +		"[2] PTR '(anon)' type_id=1");
> +	if (!ASSERT_EQ(0, btf__distill_base(split, &new_base, &new_split),
> +		       "distilled_base") ||
> +	    !ASSERT_OK_PTR(new_base, "distilled_base") ||
> +	    !ASSERT_OK_PTR(new_split, "distilled_split") ||
> +	    !ASSERT_EQ(2, btf__type_cnt(new_base), "distilled_base_type_cnt"))
> +		goto cleanup;
> +	VALIDATE_RAW_BTF(
> +		new_split,
> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
> +		"[2] PTR '(anon)' type_id=1");
> +
> +	raw_data = btf__raw_data(new_base, &size);
> +	if (!ASSERT_OK_PTR(raw_data, "btf__raw_data #1"))
> +		goto cleanup;
> +	new_base1 = btf__new(raw_data, size);
> +	if (!ASSERT_OK_PTR(new_base1, "new_base1 = btf__new()"))
> +		goto cleanup;
> +	raw_data = btf__raw_data(new_split, &size);
> +	if (!ASSERT_OK_PTR(raw_data, "btf__raw_data #2"))
> +		goto cleanup;
> +	new_split1 = btf__new_split(raw_data, size, new_base1);
> +	if (!ASSERT_OK_PTR(new_split1, "new_split1 = btf__new()"))
> +		goto cleanup;
> +
> +	ASSERT_EQ(btf__endianness(new_base1), inverse_endianness, "new_base1 endianness");
> +	ASSERT_EQ(btf__endianness(new_split1), inverse_endianness, "new_split1 endianness");
> +	VALIDATE_RAW_BTF(
> +		new_split1,
> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
> +		"[2] PTR '(anon)' type_id=1");
> +cleanup:
> +	btf__free(new_split1);
> +	btf__free(new_base1);
> +	btf__free(new_split);
> +	btf__free(new_base);
> +	btf__free(split);
> +	btf__free(base);
> +}
> +
>  void test_btf_distill(void)
>  {
>  	if (test__start_subtest("distilled_base"))
> @@ -549,4 +620,6 @@ void test_btf_distill(void)
>  		test_distilled_base_multi_err2();
>  	if (test__start_subtest("distilled_base_vmlinux"))
>  		test_distilled_base_vmlinux();
> +	if (test__start_subtest("distilled_endianness"))
> +		test_distilled_endianness();
>  }

