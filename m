Return-Path: <bpf+bounces-28389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8608B8F29
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6646283880
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F733130487;
	Wed,  1 May 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WGOtIE7M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XtIbGqac"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458912FF75
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585458; cv=fail; b=iILwuspMSFHbRQGPMQ//YHGRaiy/LAoFcEzR708AXzjW2tBicLIpbHAkgGVPqHR9DKdHnbjnR057CGwvHY7zoPgrPVTO9d35Ix8O2YajjlnaSsGBZghqb+uuQW0lCaFOmsXn9U4kSZfo8OAEp2e4/+7YlECBdGlD/pq5yVrtl4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585458; c=relaxed/simple;
	bh=24x4sOkm3YlspLQ1IWkaoFUrUQobJdOERBu7HEPm74k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LZMrV1XboDQhwLgd7nKL5fStQgTJ07U1zDNJrb3yNYDlhUyAPXmI4eGAUXOSii3z4fwfASuDQNYSXsasXvFxyFI7aaUu+29pqTb2+pq7oonDoxQXuEmt47g+OTDv9VHF2K9tg0TFW0q7PrQrqLitmYVawo6ZHlaPakC5emb+v4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WGOtIE7M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XtIbGqac; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441AS0d1001725;
	Wed, 1 May 2024 17:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zZZ/h7EjXnHH0P9OMotjuqvsa59QHFlg0ExCvXmL7Wc=;
 b=WGOtIE7M2ERrqeNMeprF5KOobi8lxw0D83DXVKHN6C6PH89aVLFhHUwy43q2Za0EngHs
 Xyx2tsTs1eYi7qma7lzagBDOZ3nwSQhXTMe9RtMr4lUHYJYVYH/s0RlS18rdlPRJkEXs
 2Khs++KLNl9yCREMMMZYyEGmNEi7vWEgA7+Xnsj6AowQMeqn0h45QwIrS3U5LyUAKGEf
 c65V1N+gQI/6PO7kLJOx0Fdx6IAoMlqa2ekRFyGhrJ32AFj/jLI0Fhb1T3+1TUruvifT
 he6Wl79anRVOHdhLdzCSOm6VVSHjpAeqHHTBqEzMchLKXrDhpr4S5qsxueSr0s4tp7Ks sQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9cqt32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 17:43:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441Fnjqr011468;
	Wed, 1 May 2024 17:43:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt9k5st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 17:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3/UJ4eTTDjD/IMRDLKO+Eb+GoWY/zdR0mha/ZXsDEDUcx6UugINunZOm0ZU2v51GHqOaqitADpFIuSIpQwR/Ti20+vJDjBnXEGL+h0KG1YW75cFaOpb8ZfSTNeUlnjEe+VqaL3evKXnUAWHatGmNZzTeW6aXGEqf7iwHFZMRY9hIXVPG8jKesQ/xlXetEX5B8JBhKZjOGQri01d+6uSehkwvcg7tgq9jXbdJiRB2+G10iQBjhEtINPs4m+RXcnRoKUs+16ke65O8aUUuWM+6ADJmrnSBiEhG+l4iu4oX7sfXKHY/bJ5i/KmJONXkpWmyKIq70cQXNZgH5lDxSQMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZZ/h7EjXnHH0P9OMotjuqvsa59QHFlg0ExCvXmL7Wc=;
 b=JQr9VkGJH7QZAfOfJjAiKmVK/EuNf2IW+x7KMqiZEpsEfklwWx6uefh7o6YimbKcZdszWy7hpB9VkoaMy9DEcBlJ3ydjTz9bVrMiY6si83tHJPCWrdm4RQ0do7uGEUs7khEOrH+q9JzMYFx6Ovun28oO9MDdfvw4EZDwy81PLuCkKhQTSUfvJYpSQbI8RaKu1trtJLA/RWnr74znd4lc29ji2gQ+zcl7E5PzqM+Y/rH28RSGA3QzgAZe5hdR4ta4r6DqcV5b10c8QP8+sj+QTIfQomWaJyYuSJZ2zHezV03ATAcxICBoUW+LLAKAfTZAQfL8mvLiMOOFjYxnTNiVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZZ/h7EjXnHH0P9OMotjuqvsa59QHFlg0ExCvXmL7Wc=;
 b=XtIbGqacevUnKI7wmZ7xUqTWTwrPwLE018Su1+5CthddUV4hPQdwQSW/5htCsLjtjyhJLwiIJPWInm44YsJdi5ocLEAACdcj07QH6J9gMK3hCLzvYT/4ZQA1TkdrsXtTbIwMuvVIEZTDYJHSaV1lwN0FnG92riCx/q9ttMC3d/Y=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB5970.namprd10.prod.outlook.com (2603:10b6:208:3ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 17:42:59 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 17:42:59 +0000
Message-ID: <6831c4a0-9653-459a-a227-62daecc5c55f@oracle.com>
Date: Wed, 1 May 2024 18:42:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 04/13] libbpf: add btf__parse_opts() API for
 flexible BTF parsing
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, houtao1@huawei.com,
        bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
        nathan@kernel.org
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
 <20240424154806.3417662-5-alan.maguire@oracle.com>
 <CAEf4Bzau4J3UHKzz2QJgZsSSqCx=BxkG=Zf+SZXm5ESgzpcrHw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzau4J3UHKzz2QJgZsSSqCx=BxkG=Zf+SZXm5ESgzpcrHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 523fbc9f-a6ec-46d4-b247-08dc6a062478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SnBpQUpIWDVmLzFmQm1wYUhtVUN5eU5VVkFkYzVKNitIMHYwZWRiNVk1QjdG?=
 =?utf-8?B?RWdrYWorZG9qRjYrZjVvUENFT0pPMkQ5UFJwSXVzd3hHQUpJSGJadUdCMmh2?=
 =?utf-8?B?UjBBRTRINjZKcWpaelo0QWRUYnE2N3h0OUd4cUh4bDZxbEV4V1pOTnRTQUdN?=
 =?utf-8?B?em01R1lqUnFVOHJEalVVOFh2cUxtT2dGVHBUam14MG9lYTZ4TXBwdmc2QUJi?=
 =?utf-8?B?RHdEL0NBZEZubDIzN0c3RVUvQmtKNzlUY0Y1Y1NjcjMwdVRRYkZqNG90Q0ps?=
 =?utf-8?B?eXg0OHFpSHBXSFFBbnJDaStZbkxwVUs4MXZQMVhaVTdYNVdDN0ZlZzFIVnhF?=
 =?utf-8?B?RVhDSEljei9oZ0Q3My9JNWJ6WjdhUjF0anlzWFl4Y2htWDd0UEVIZ0N2d1p6?=
 =?utf-8?B?YzVnV2JmcGZoTHdHTDVoNEdLRXNSZ2FVK3g1KzVqdHVxUGJzTWVrNlVrOThZ?=
 =?utf-8?B?cnJXZXJWZW5ka0taK3hhcS84RlNnL0c3UXYwTkRLK2tGblU3Tm1MSjQzRUli?=
 =?utf-8?B?WlFianR2RnpoamllVER3Nk1nRTlUWjNzdmZiMitrYnk4T2pSN3NZdWZvYTlP?=
 =?utf-8?B?Slg4WjQwamoxRjRNUytwSjlCQTBQczl3QlpBdXo5Zklpd2xYK3U5dUZRc2VL?=
 =?utf-8?B?OVJDUGNQaVVXKzRsd2tkTmFpandYZmFyYUJGOWpub2RHQ3JlUVk3eUFKbXhH?=
 =?utf-8?B?ZVVoMGxmbXVpc21LemdrT3BjYjdrcE5naDdTZTVUMHZOYitlOXhhWUlWV2xa?=
 =?utf-8?B?L1FqLzlvejV4QzV3by81Z3hjVGY1SE8vQXBTOHAwbzlMdzN1RTJybVpKQUJH?=
 =?utf-8?B?MmhodHhyeWVkeVBXbWFQdlJ1T2h5S2tmcnQxZGV6LzVwOEtyOUo2VGJMczlj?=
 =?utf-8?B?akREMFUvUVd6Q0RIczc3dHF5N3pDdWptMjZ6RFBQc21kRzc1TDZBSTd5RlNX?=
 =?utf-8?B?VHlNdFBzVldHZ1Ftb3Q4M1dhWFJGSks1ZUp1WkNuQ3BPM2lIZnNLZW41eWIz?=
 =?utf-8?B?eDk1bld5N3dZbXAySStqYWZrK3JtakZvNFBqNXJ1WTBMdVdIODN3QzFrbkdD?=
 =?utf-8?B?cFFmTkhEVEJ4ZDZ3NG44ZE1iQ2J5RFV0RmpHUDByTVk3MVdVSk8zRGU1bWZx?=
 =?utf-8?B?T00zcVF2L0NiZmV6SFpRcmhNMVIxRTVMbjl6RlRidXhEUGMrbmlkLy9DUXNn?=
 =?utf-8?B?c3UwdFp6SDBoV2VTU1RsbGZnQzk0VkJmNFpWc1dkWW5SR0E4YUhISCtwQlc5?=
 =?utf-8?B?TXpLRFZTNmlRbG5WeGRCLzZPWUdFQzVmUzU0RHRrSWtsUHc0Ukx5WXJLVWJy?=
 =?utf-8?B?QkY1dGRBQVhmemtXdzVhZlk4SFRieVU1QkU5UGwxbG9rbm1SMEIyNFBhRVZQ?=
 =?utf-8?B?YkJkbXptSnIwcjYzT3JEazFnOW1ibnNUU01XU3k5QitBT3lLYTh6SXlFSFZz?=
 =?utf-8?B?bFpzb1ZpOHlMZUdQV2tsV1JwSHdSakdKODRvc05COXdKZERPR3NVbkJpWjVh?=
 =?utf-8?B?cllUNlhvb20yaC9rbVNhbElzTE9UbzR0dEJtOHNsS3NiYVNvOGxlNjdpUXVy?=
 =?utf-8?B?czJPUFVET0trN3ZrVXZtUGtuYkV0ODV3SkI2MHRGMkprcWpzWnNyMk51eUFO?=
 =?utf-8?B?ZFZWVmhWR3h5b09MUXkxZGJDVXZNQzAwMXlYSlJvaGQ3Y1hPc1JBaHBTQ0ZZ?=
 =?utf-8?B?S3JOc1VLd2ZtOXRQRnI2S0lvbEJNVEZyNHlTN0RIK1JCREl5dVovbGp3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U2t6WkR1SWxoRWpMMmoySUlPbDVNcEt1U1kySDIzK3JSZkRJNG9iUDJHejk3?=
 =?utf-8?B?UEJ2LzMyQjUwVEViSmlsOWFOejZGa2JUc2Z6MUtxRkF0bGhNampQQXNiVFBy?=
 =?utf-8?B?ZUI2UEhkNDZUVEdFQWhEVDh4S05JRG0ySlJqL3BzT0pxUWl3dkdCT3R6VHlk?=
 =?utf-8?B?RWx6VlJWTGRLWGVyQkhFOUtuQkU5S1E1ZmdRVktNbDhIbzE0RXhDTEkyWDZN?=
 =?utf-8?B?azM5aURReDlRZDdPSVlXcmQwZGUyVWoxWjkyL0sxV3ZPWEhndWFwN0pFUG1n?=
 =?utf-8?B?RWtqME1RM1BSNE81dUdwYzVOdGFDVGhORTZDK2VUNkV6d09wUER5S3lCVnAr?=
 =?utf-8?B?eUhLc3krTWpBL1lqRTFxRmtrcDdFU1lXbUp3SWJQNTVNSWN1ME1iblVuTEY0?=
 =?utf-8?B?SVo1ejNRR0liZ21TRWIzSTZaZlVYWU1YVFBsMHc4K1grNTNrdGdmdkVQb1pu?=
 =?utf-8?B?OURPYXJBRGFXNkdBOHFNZnhwcjFUZWpUMC9pci83US91ZGVZSk1xZXFLQkdF?=
 =?utf-8?B?Mi95SjhnMU9HNWMyTmZ4dlE5RzlZWno0cmdVRUhYOVF0N28xeFY5dENvSGRz?=
 =?utf-8?B?Z2RhRXA2UDRUVzJPWk5WcnlKWmROb3gvYzhkaWMvVEppTGdoYy9NRjVxbkdM?=
 =?utf-8?B?blhDUE9xY0s3Sm8rSUJyZjZudTBWRVQ4N3UzeGhJRXgwSndhYWxLMlRITXh2?=
 =?utf-8?B?ZzROYzRCMVZjK1Bza1VqU3pHSDk3OXVqNjQvZ3orMGh6SGlGelE2OHBKUENn?=
 =?utf-8?B?S1didXVZQThlZGhLakZkSTFkYkF4TWRxS3I5NVE2cG1vQTM4YlMvTGVaeXht?=
 =?utf-8?B?TVZNcGs5dHlvakVGemNtcWtDaW9pV0RQcEdlZE1KL0NkSmdOcURVSWhVb2xq?=
 =?utf-8?B?VVBYdXZaL1Z5dHM4dDc1MmJuVUV1WlBzRFk4ZUlseGFoMTdYUXBKR0pkM3VL?=
 =?utf-8?B?SGVWdGRZeFh3cnRBRnpyTmkrMW0wMUY4N09FQmsvRHpPZFRQOUVLRVFoNVNl?=
 =?utf-8?B?YUQrendQMlBVOFVFS0tMUDBNMTk3TVJTd1JhK3lIQ2dPOWkreWVaUlpGaTZ2?=
 =?utf-8?B?YWptQUI1N1RGK2RXRHdlZVZ1S2VsQlRXT3hiODVrZW9hVE5rZk0rNU82TGZL?=
 =?utf-8?B?elcxN0h2TkNjZnFRS2xFREdILytmUW5rWm1aMkJCK3hJV0pGWU5iYzZ4dVU1?=
 =?utf-8?B?dkhrcWZ5NklZNisxakVqT1YzbWtEUUhocDkwQWV0aFdFUHM3SXdjZ25LZHE5?=
 =?utf-8?B?TmkydFJaOEoycDdENFljK0VIQzJNUzZtQnpzSi8yVVM2b0F1M2xObXRyYkVk?=
 =?utf-8?B?cVZJZ2pxdEJabTlCZkc5QWpiTnF3QlJTcUttSjIyK0k4WUtiUzlrT2ZUNW5q?=
 =?utf-8?B?c1lFOWh1RFV0K0Q4dzdzWnVBL2NpOEdiWWZ5cTlsbytXd05QSm0razF0TGh4?=
 =?utf-8?B?dWFtcmdrUjJtVVc5c2xOQ2o0QnRUdUsrM095SHhpa2p5WWVqcjFwTU9MZnlU?=
 =?utf-8?B?cUdiMS9qd3pYb3FVenhrZEs0UzhTaGRvMWhWVGdaMzk5bXZtSHRZZEYrTHdn?=
 =?utf-8?B?blZHanh0K1pRYm91YzBHbFRPSVBpenJNWm43YkpRRTd1OXUzTGhhZ3UySVRP?=
 =?utf-8?B?WTZyQ3hwVzNYOHc3Q3A3Z2JCOC9oQnRpTFZBNWNFZXpnSks4M3FoemJNVlA3?=
 =?utf-8?B?TTN0c1pXRDVQRE82STcySVFDN3gySDkzWWFZVHp0c0J3ZDVJbk8wRWYyQ2xO?=
 =?utf-8?B?MU9mWm1VeGJwL05nTE1KdjBOUS9KMy9PNXV3MDF2M1lZVnZGelpNdVlaRDRi?=
 =?utf-8?B?RlFTVmloMHFkZU50c1NtN0VxYU9QYmw1NGZiUDduWVg1REh2TWhGZjZ4Um9a?=
 =?utf-8?B?MkVPZytDN2J6L3R0SFpEMi81YmZkbWl6WWJlRkttWFBmUkFqOGpsTmZRN3JI?=
 =?utf-8?B?cVgvNklTUzZSSWptVTR2QXZkTzR0b2xCbzIrenlITGxaN1RaaFFpdDh2ZGkx?=
 =?utf-8?B?NVFDeDdwWTRBQmgzUEhSTTRKcENVUXhyaUg4dFJFTkgwS040eHhHa1pDbk41?=
 =?utf-8?B?dHpxN2QzUk1ER1NiTkFhMzVBb291WWc4c3Y3OUM0YVdzY2FSRW4xYzlmVlFv?=
 =?utf-8?B?amtoWHRYRFRSOWVscW9OZ3lrak03Mmx5QkI3dEFDaGNKNmlieWgrcnpoTkhM?=
 =?utf-8?Q?3f9FwrrEetT3fs8TYYMpm10=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qbzD3eaDKjyAGMKCd8Us+o029//T58zax3m3yU8HL+k709k+M+Mjw+WJGts9+ZkWnn3DVIqSh4+CcGPMbImdMFk7J3sCHHcpM9gKfp8571uaCj7E2jdIKan8Gp3j6xU1PucHaidAs8L2qdavLw4XcljQ1OGSOdUCnkxGUG5XHbOjR3LKf4Xi/yH9q3xoOSJW2gr8qB7AcmtgsO3FGxc/yoboHF8G4bHm0mv0ed44QRd9aNIuBci6tQQdO/r5BUKqYuh3aQRWtyTidcPAnMqEg7AKZoP3LfpHCIIea4QpudXqaPbub1O3s7Atnmha7GhateNcY7eoSqN4utHw4UP0HfIGgpcdvw+u2d6wm1Da+59vCHeUt8ADpVbDDOX04nQ1Y4QhDPV6ZRzrV1iIg6ACOybsMaJmzbbt/ajpXNsM1Sh/yQ5p+HxGyweUk2Of7uwyG3a4FZoP1s2C/d8KbEieYiY1cJX0Ow27Brn5JCdB7XxRQIo6ai/6lXr+DbRu7xjm822EopPS7ymvgkNE+23Y14tRttAWTJ5Om0KkZumlAA/LNiEyYOGiU6MOoYl2ivI7XdbYG+3udfRGbUWvX224Q6Dmy1J3HTSDDDGJyOyc2fE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523fbc9f-a6ec-46d4-b247-08dc6a062478
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 17:42:59.4798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WExaNC7DVx4KRbu7Ow2aW+WBcIISpkrp32wUbt/e4LdMBLttCLCeMdhTsoNLhtfDI4Eur6yDnUfJJsAGSDxKnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010124
X-Proofpoint-GUID: B4nsrdHLGkVkaFoXRR079hVYZ5Mj5i7h
X-Proofpoint-ORIG-GUID: B4nsrdHLGkVkaFoXRR079hVYZ5Mj5i7h

On 30/04/2024 00:40, Andrii Nakryiko wrote:
> On Wed, Apr 24, 2024 at 8:48 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Options cover existing parsing scenarios (ELF, raw, retrieving
>> .BTF.ext) and also allow specification of the ELF section name
>> containing BTF.  This will allow consumers to retrieve BTF from
>> .BTF.base sections (BTF_BASE_ELF_SEC) also.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c      | 50 ++++++++++++++++++++++++++++------------
>>  tools/lib/bpf/btf.h      | 32 +++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.map |  1 +
>>  3 files changed, 68 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 419cc4fa2e86..9036c1dc45d0 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -1084,7 +1084,7 @@ struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf)
>>         return libbpf_ptr(btf_new(data, size, base_btf));
>>  }
>>
>> -static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>> +static struct btf *btf_parse_elf(const char *path, const char *btf_sec, struct btf *base_btf,
>>                                  struct btf_ext **btf_ext)
>>  {
>>         Elf_Data *btf_data = NULL, *btf_ext_data = NULL;
>> @@ -1146,7 +1146,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>>                                 idx, path);
>>                         goto done;
>>                 }
>> -               if (strcmp(name, BTF_ELF_SEC) == 0) {
>> +               if (strcmp(name, btf_sec) == 0) {
>>                         btf_data = elf_getdata(scn, 0);
>>                         if (!btf_data) {
>>                                 pr_warn("failed to get section(%d, %s) data from %s\n",
>> @@ -1166,7 +1166,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>>         }
>>
>>         if (!btf_data) {
>> -               pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
>> +               pr_warn("failed to find '%s' ELF section in %s\n", btf_sec, path);
>>                 err = -ENODATA;
>>                 goto done;
>>         }
>> @@ -1212,12 +1212,12 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>>
>>  struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext)
>>  {
>> -       return libbpf_ptr(btf_parse_elf(path, NULL, btf_ext));
>> +       return libbpf_ptr(btf_parse_elf(path, BTF_ELF_SEC, NULL, btf_ext));
>>  }
>>
>>  struct btf *btf__parse_elf_split(const char *path, struct btf *base_btf)
>>  {
>> -       return libbpf_ptr(btf_parse_elf(path, base_btf, NULL));
>> +       return libbpf_ptr(btf_parse_elf(path, BTF_ELF_SEC, base_btf, NULL));
>>  }
>>
>>  static struct btf *btf_parse_raw(const char *path, struct btf *base_btf)
>> @@ -1293,7 +1293,8 @@ struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf)
>>         return libbpf_ptr(btf_parse_raw(path, base_btf));
>>  }
>>
>> -static struct btf *btf_parse(const char *path, struct btf *base_btf, struct btf_ext **btf_ext)
>> +static struct btf *btf_parse(const char *path, const char *btf_elf_sec, struct btf *base_btf,
>> +                            struct btf_ext **btf_ext)
>>  {
>>         struct btf *btf;
>>         int err;
>> @@ -1301,23 +1302,42 @@ static struct btf *btf_parse(const char *path, struct btf *base_btf, struct btf_
>>         if (btf_ext)
>>                 *btf_ext = NULL;
>>
>> -       btf = btf_parse_raw(path, base_btf);
>> -       err = libbpf_get_error(btf);
>> -       if (!err)
>> -               return btf;
>> -       if (err != -EPROTO)
>> -               return ERR_PTR(err);
>> -       return btf_parse_elf(path, base_btf, btf_ext);
>> +       if (!btf_elf_sec) {
>> +               btf = btf_parse_raw(path, base_btf);
>> +               err = libbpf_get_error(btf);
>> +               if (!err)
>> +                       return btf;
>> +               if (err != -EPROTO)
>> +                       return ERR_PTR(err);
>> +       }
>> +       if (!btf_elf_sec)
>> +               btf_elf_sec = BTF_ELF_SEC;
>> +
>> +       return btf_parse_elf(path, btf_elf_sec, base_btf, btf_ext);
> 
> nit: btf_elf_sec ?: BTF_ELF_SEC
>

sure, will fix.

> 
>> +}
>> +
>> +struct btf *btf__parse_opts(const char *path, struct btf_parse_opts *opts)
>> +{
>> +       struct btf *base_btf;
>> +       const char *btf_sec;
>> +       struct btf_ext **btf_ext;
>> +
>> +       if (!OPTS_VALID(opts, btf_parse_opts))
>> +               return libbpf_err_ptr(-EINVAL);
>> +       base_btf = OPTS_GET(opts, base_btf, NULL);
>> +       btf_sec = OPTS_GET(opts, btf_sec, NULL);
>> +       btf_ext = OPTS_GET(opts, btf_ext, NULL);
>> +       return libbpf_ptr(btf_parse(path, btf_sec, base_btf, btf_ext));
>>  }
>>
>>  struct btf *btf__parse(const char *path, struct btf_ext **btf_ext)
>>  {
>> -       return libbpf_ptr(btf_parse(path, NULL, btf_ext));
>> +       return libbpf_ptr(btf_parse(path, NULL, NULL, btf_ext));
>>  }
>>
>>  struct btf *btf__parse_split(const char *path, struct btf *base_btf)
>>  {
>> -       return libbpf_ptr(btf_parse(path, base_btf, NULL));
>> +       return libbpf_ptr(btf_parse(path, NULL, base_btf, NULL));
>>  }
>>
>>  static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endian);
>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>> index 025ed28b7fe8..94dfdfdef617 100644
>> --- a/tools/lib/bpf/btf.h
>> +++ b/tools/lib/bpf/btf.h
>> @@ -18,6 +18,7 @@ extern "C" {
>>
>>  #define BTF_ELF_SEC ".BTF"
>>  #define BTF_EXT_ELF_SEC ".BTF.ext"
>> +#define BTF_BASE_ELF_SEC ".BTF.base"
> 
> Does libbpf code itself use this? If not, let's get rid of it.
> 

We could, but I wonder would there be value to keeping it around as
multiple consumers need to agree on this name (pahole, resolve_btfids,
bpftool)?

>>  #define MAPS_ELF_SEC ".maps"
>>
>>  struct btf;
>> @@ -134,6 +135,37 @@ LIBBPF_API struct btf *btf__parse_elf_split(const char *path, struct btf *base_b
>>  LIBBPF_API struct btf *btf__parse_raw(const char *path);
>>  LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf);
>>
>> +struct btf_parse_opts {
>> +       size_t sz;
>> +       /* use base BTF to parse split BTF */
>> +       struct btf *base_btf;
>> +       /* retrieve optional .BTF.ext info */
>> +       struct btf_ext **btf_ext;
>> +       /* BTF section name */
> 
> let's mention that if not set, libbpf will default to trying to parse
> data as raw BTF, and then will fallback to .BTF in ELF. If it is set
> to non-NULL, we'll assume ELF and use that section to fetch BTF data.
>

sure, will do.

>> +       const char *btf_sec;
>> +       size_t:0;
> 
> nit: size_t :0; (consistency)
> 
>> +};
>> +
>> +#define btf_parse_opts__last_field btf_sec
>> +
>> +/* @brief **btf__parse_opts()** parses BTF information from either a
>> + * raw BTF file (*btf_sec* is NULL) or from the specified BTF section,
>> + * also retrieving  .BTF.ext info if *btf_ext* is non-NULL.  If
>> + * *base_btf* is specified, use it to parse split BTF from the
>> + * specified location.
>> + *
>> + * @return new BTF object instance which has to be eventually freed with
>> + * **btf__free()**
>> + *
>> + * On error, error-code-encoded-as-pointer is returned, not a NULL. To extract
> 
> this is false, we don't encode error as pointer anymore. starting from
> v1.0 it's always NULL + errno.
> 

ah good catch, I must have cut-and-pasted this..

Thanks again for all the review help!

Alan

>> + * error code from such a pointer `libbpf_get_error()` should be used. If
>> + * `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is enabled, NULL is
>> + * returned on error instead. In both cases thread-local `errno` variable is
>> + * always set to error code as well.
>> + */
>> +
>> +LIBBPF_API struct btf *btf__parse_opts(const char *path, struct btf_parse_opts *opts);
>> +
>>  LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
>>  LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_btf);
>>
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index c4d9bd7d3220..a9151e31dfa9 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -421,6 +421,7 @@ LIBBPF_1.5.0 {
>>         global:
>>                 bpf_program__attach_sockmap;
>>                 btf__distill_base;
>> +               btf__parse_opts;
>>                 ring__consume_n;
>>                 ring_buffer__consume_n;
>>  } LIBBPF_1.4.0;
>> --
>> 2.31.1
>>

