Return-Path: <bpf+bounces-71899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 166ACC00F0A
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 14:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 640713589A0
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 12:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8FC30BB8F;
	Thu, 23 Oct 2025 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="izP2w9t3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AhVwfF59"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599B1306B10
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220857; cv=fail; b=p3QkT3YuMOtqoTl9gwLZuZ9WnQ3H0TuSiRuEPp5H5JJMLh3GDxJM+zna8ebtWygIuzZdgU2L9bS8BtiU/7WtkNfMAiPFkeeQOq0w+stHuGigZtKo1FkX1wIGPgEOd9l3d4+QLtRmVtGgjDfseu2Sy0dG/d0C8Cvglp0RTOAuxYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220857; c=relaxed/simple;
	bh=DI/sbVI4gyilSwrR33Z2IV7h6P0w6kkfoO0L92FK1gI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I9v8avKj1Hldu6uVVPHX0Q5IYUVqrP2GMY0FNMVxmSjW2xPhB8rc09Q1gvT/zdMIX6EB3YsUYH4ro2AZGMiQF5oT+Mh25ZydZS5gG5RMsnLLNrVsHAIXAL4OWd4+b4XEEN+/KcUWq12wzhtxKRDsy0efwWNZKKY3juXN6Erq4AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=izP2w9t3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AhVwfF59; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9k3UT011396;
	Thu, 23 Oct 2025 12:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Jshmz0FyhvxNKGk0gFP20JiKX4coAeYFsjxq8KiynMs=; b=
	izP2w9t3JoWbtFKn5FwgvRFyp5gMJ53IG3FNR1Tj7pbIk0JPM+QDswictKZc2goE
	9NqnE46Xqy53mL+9G3E6fmtEJi9u0nuXgLiYrJHuFoKmEILk+zaklePMKoAaTT8Q
	JfU0KQ/A5EMAzMVw7nyuZ+SUzFsyn91Foj1JyeVrhFkwp8dBB/YwJF4uyzrainFL
	fWSuTD3U0DgHHFl+MmHDPLEj+54nYnwgejKNPkPPUperbhASkv3tlem0n4cFRNy9
	pxRCv9fkTkDoeM/SH8K6Smf744f11MLRVBelf3mLIJpDDZ8IHKUuwGKNlM/W0Tif
	S/rsNAQZAGcHnemT8oLuag==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvcyabjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 12:00:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59NBoQ9m035896;
	Thu, 23 Oct 2025 12:00:24 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfh0ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 12:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onLHGTws3RCZspMm00Yr93dGouiIyKV5FZRO9iMotN4uVGePKmTr9KlK5NvGif5AF19gOFh71idtmteUCgoaEKazOwvtUaK7nDPDZIyvB2vyt8qRPJrPSWDqE0RRQzc/ypHQfYvLpo0IrWVgsxs7WWK5R2og6WcDEkMsMSfm0LvjfiZEMVjZ+3qRBEMIkIUml/DF0ZrX8a7q4qgXFA67bXWyMKh3VkyUqSK/IosiHNoqnTr7XXHClRfVdWdmVZKXG5s7661eiqO8fGaakTlgbVZBT29LMM1Ef6iZHBLffi4a1T9XNWn9wZ/o44rkfQEjyvOIncBuJIFWhb5OQX+Tiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jshmz0FyhvxNKGk0gFP20JiKX4coAeYFsjxq8KiynMs=;
 b=cduImRghfXtDG5rn0f9WYA2wXfm66G/pwOfDypH061NdseFVQmbiuD1COS03KgINszCzaenOFrXnhYGJLJGEVDzO1eLbvmXOSE51Xm3AevuPjxs4e8tHfq9CNWInoB8tfAhnS/4cZzhXH9OLb+/dKvoC9C5sXXSapADW+oXXaYNcKv7qBhP6TZFUzXNoTnQN3o3j/lEo4DKEnEVx3ZLIseh/oBZiQGn98U9a/Dop110C5TPa0KThS5IW6dQOMncFfdq9sScn24G/Dhcw9yfPQ3NBjMLmp2miDhF0K5btXDoXlKaDV84GE21xp3qNqtQRlXqpRUgdDpMhUtZmVSgvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jshmz0FyhvxNKGk0gFP20JiKX4coAeYFsjxq8KiynMs=;
 b=AhVwfF59fSOFgQDE8SQ54gO3+4YMkV83n/O6NLicOHfcneWIeeaTc3XV8Mr+wkO+EIHLZ1MIW4gzhpZTPB2YAvkQAF7GV/mViSti2boC5G0YuWDqrNzqJzN1ebV9b/FDP9OJSpJ2ZBkhyCpGBjB8FtaSFrXR2pmQeYvcuvnHfRY=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 LV3PR10MB7770.namprd10.prod.outlook.com (2603:10b6:408:1bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 12:00:19 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 12:00:19 +0000
Message-ID: <4bc2d0b1-8fc5-4a57-80ba-7e52daa43067@oracle.com>
Date: Thu, 23 Oct 2025 13:00:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 12/15] kbuild, module, bpf: Support
 CONFIG_DEBUG_INFO_BTF_EXTRA=m
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-13-alan.maguire@oracle.com>
 <f6b72d01a5de0e6cf651eb5fc0cabc9577de536e.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <f6b72d01a5de0e6cf651eb5fc0cabc9577de536e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0479.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::16) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|LV3PR10MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a41963b-84ed-44de-f53a-08de122bbc3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTRGY1BjcnQ4bTZGZDJ6UktHRnVEcjRZTVE3dW1ySWhKQiswMXhSckR5QWZL?=
 =?utf-8?B?dFV0bnVTTzB0bjR0bDJhL1l1TEhhTklHL1l5dzJ2K0dreExaK3E4eUFkemFM?=
 =?utf-8?B?djFFYVJBaC9nUjNocUp6WmtwTjZTdGwxbEdUTmVqZGdYWHpUazU2Tjg3bTZG?=
 =?utf-8?B?REJPRWc5U1h4SzBRTTlNK3Y0S0JhLzUxUndnd2s1OGNIeElFcCtET2ZGc0V1?=
 =?utf-8?B?RHV5N0pKN0d5SjRKeFZYaUp2b2RuM0s3MVhLK0h5MnlqVUpoVTAvbUZiZ0xQ?=
 =?utf-8?B?SlY3NXhiZnVCL2pZMW9lYUtNWTdpWlhJR3NBMmQ2eWplVGJNNTYxTERsVFdY?=
 =?utf-8?B?R2daSjlYVmdwK1o1NE14UFhFVDBCeFVxWnJZc3BqelBHVGFPSXdtWWtoYWlI?=
 =?utf-8?B?M2lQZEJkZE42TFFNajJ2WEZFS2x4TzVQM1hPL3g5eFFtNHZPRkpxd0RYKzVK?=
 =?utf-8?B?ZWtRYzBkKzBuNkg3UWV6RTlqNHljV3BBbmF5TjFnNkpHdk1paVdKWFI4NjdS?=
 =?utf-8?B?TytaZG5sWnpZMmlveWpaSlZUMzZKb3pSZ09zRCtDM1JIZ0ZTN0JBQTVYVExs?=
 =?utf-8?B?L1ZOMWVYZldSQXU4N3BCazVUSEVTUHNGdjg5am43S0E5OG9QRWZuM05lbTVp?=
 =?utf-8?B?SjNyNGd6QnRkTm5tbTVIWGRmZ1o3UWwvWkNEMnpIdmJvZi9aL2p1QTRTU0NX?=
 =?utf-8?B?S2JpRkQ5aFp2d2R6S09qNUN0SmMySFhpWnVydDNsbG5uYkxhWnN0MkZJSTdQ?=
 =?utf-8?B?SFdvbSt2Qlh0NzhFUVVxYzhpUGkwT21CUUdvWjBMQzgzQ2pWM21NbWlMWUty?=
 =?utf-8?B?dnRidk9CS2ZVQy95RnFaWkZhejVvSENoc3ZMVE9IYmFhN3RqVXp3Nk1HSmxk?=
 =?utf-8?B?VlhrOXFkNU9vRU0xZFNwdG10SHdXTEZEZkc3TVpiVHROemc3TDJxanNGMUp5?=
 =?utf-8?B?Q1ZIUTVJYVF5WjhLQjNRVUVHQ2ZDNiswSEJOVmVERXZuMk9RTXRaelBQQ1FX?=
 =?utf-8?B?Qk50ZC9zZCt0cUV3Y0RyNzZ6WW5kLzhJODdIOUJEYWZBekVOcEFOYS9tZy9w?=
 =?utf-8?B?T1JTTEc0cFdIRkx6SFk1TDdOeXZaQ2VGdGY1MmI5c3lIR1ZiOTJoaSsrZm1T?=
 =?utf-8?B?QWxySGt6T1pyMWM4c0d5eEJxVzF6VUNzVkpkRUs1RWlLUWRuTUM5eDNRUElE?=
 =?utf-8?B?Z20zQkZjSHlWRmFYeUs2RVZNQ0dscGozbURNV055YjN2Y3hmYkQxaXBUWDk3?=
 =?utf-8?B?cE52c1ZReDFuVVloVkpQUTdMcUtxWVlPYXVuc1UyZTBxY2hKKzl4aFJSWFp6?=
 =?utf-8?B?OEFONlBoMEVpekhzaDVwY1IrcWUzVHc5Mm02eFM3RlNzelU1S2xpL0g3VDNr?=
 =?utf-8?B?QWhwcWNuV0Fld2dMaVlRYTZ1cUVrSTNaNVI2YVlqYXR0V2JMN3V5d3FBSTMy?=
 =?utf-8?B?cWVJdlNibTFuRzQ2UFRTYmptL0JwWGJmd0Q5b1JIbVlTMThsVTFUQllHSzRJ?=
 =?utf-8?B?aExxUkJaU01lbm8vZld6Q3NiZzdIME5qOUMwd0luVG5jZlI4VkRPQU4zNzZO?=
 =?utf-8?B?ZVlOaWpnMnhXWGhEN0VYNGcydjlSRHorc1p1cVQyYzFGME1RR3Znem1BTXdq?=
 =?utf-8?B?N3F1QTZJQ0FkOEpKU3c2YjJwdlptMlphTWpkMnFUSzB6ZHFsSXVGZFZmdzdm?=
 =?utf-8?B?bzNkRWMxZUQyWnpkRCthU0ZmZlVUSStvMEFUcEFiRWdiTzNuVG5kUlhMQXIy?=
 =?utf-8?B?clNaa2xUaVQzaDljRGhrc1FHMmJOeU9iVjNuV21qTUJpeVltTTNUOVJXRW5r?=
 =?utf-8?B?b0dNZUd0bUpBeTZEcEltd3BycVN6c3N2YnBERFp0TzNkencrUzkvMUtPdWRw?=
 =?utf-8?B?d0VQY2dHR2x1SXR3SjhYQjJFbEpyVW9ZUmlhSTMvbTBmcGtxdW8yMjRXR25a?=
 =?utf-8?Q?Lemjj6wvAGKp0nPwJKC2M30ZW+MXMZPj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGkwRnpZUW1CcExFYkNZSW80VnA4dE5PSldOakYxRW1sSlpUei8rSlBwQzJP?=
 =?utf-8?B?RWpxVkZYM3RFejBGQkFYeDE4RW05K253WUIzcjZTOW5VZXJuOG1FRFZoRTZw?=
 =?utf-8?B?TEtnOExGUGZWT2g1dUw4U3AyNkpUc0krZkt2Q2VSN3U1WThZUUs5L2xORHI1?=
 =?utf-8?B?WStEcXNvTHdTYUtxNU81ZmRzK0NuMUVPbUhncnpTZkpqSWkxSUM0S0hMYzRx?=
 =?utf-8?B?Z0FyYWlBVUlBcVpOTFhqNDZYcldCWDhIdHdyWVR4aXBLOENZczBWNjRjREwz?=
 =?utf-8?B?WXN5WlhVOWRSVDJYOGRKUCtZQk5vRitKZWNUVjA3THY4RmNvc0pBcTE1UDU5?=
 =?utf-8?B?TFFLSDcwTmdLenJwSHp6TTcwOFAwYlNGSlduZHBQdHh3OUpuR2gvZVZGb3JV?=
 =?utf-8?B?dTluWE5JUDBZS29DNFhUcnJIaXI4YXhlMG1RT0QrSGUxb251U0tiSGpFL2Rm?=
 =?utf-8?B?Mlk4Q0J2TEpWN29HRTNscnpZMGluOENpWnA3clNBbEpXalBaNnZSUVJQYUx2?=
 =?utf-8?B?WU9MT2tCSWFXb1ZPSkRtdWsxT084MTB3WDFRUUIwS0FjM1Z4Y2U4VHpKVHIz?=
 =?utf-8?B?Ny9jMS95cWZpQzV0Zm9qMnVmK1pvSHJlcmlPSkVVd0JVeTZZQWlibWdLMWlk?=
 =?utf-8?B?ZXFVMzBURGtrd3ladlBvY0ZGZEduNndvS2hLKys1MmJOZzlFZG1CSktUNytk?=
 =?utf-8?B?Z3RBd3UxVzVQZC9haG9mempVYk40WnRvWHVqOWxFQjllN1dEei9CSEJVMlJY?=
 =?utf-8?B?VEEwdkNMMzRTb0JFMkxjVmowVzEyUnFLNFo3cVZ6OWZQZHlEMlZGZ1pZd0FT?=
 =?utf-8?B?MVBCNm9jN0Z0M082NzJLRHM3MTRVTVdEQnFvM0JxRmxhNElNQTNERnRXaGxT?=
 =?utf-8?B?bTVnSjJ1RGNOanF5OGN4SDFZQld0ZkoySFNLVFBvZkQ3NkI4MUd1cWZLUmZM?=
 =?utf-8?B?Y0dVbEZGcCs5dGh6UDF2M3lHT0N6NXRCMllxQWhSZHNoWVZhOXcweVkvMzlx?=
 =?utf-8?B?TUdWUUFXclNQS01FdFd0UGU4YkFxRHh0S3JhK25rNVZ1K0k2Q0c2VDA1eDRu?=
 =?utf-8?B?U0JiTXpjRFkvUnB4eTg5Zm1LajI2eVN4TmlmZUZyTXBvSG8zMG1adFlhZzVr?=
 =?utf-8?B?Rit3aG83Skx3RnkydjlmQVdUOUJSRG1lQmoyWUVYd0JBN21tWVZOTUtWbHVU?=
 =?utf-8?B?YVB3b0xnQnp1OGR5RVVwWHFDQTBCMGZTaE96ejhFTmJVd2czM0w5QVhtd2VM?=
 =?utf-8?B?ZVNHT0FNWFBTODFkMzIrc1NoQVE5SG55VWJuQWRwYVhrelV0bXFMWXZiQ2Vk?=
 =?utf-8?B?M3k5MFN1SE5OQTZ5YUVwamNWMDVodlRpM0QxUE15VTBOVit2OUtiU09LZ0Nm?=
 =?utf-8?B?UitXa2lNS1lLcjd1TUh2VEhWaHZxYXQ3WGtsakhkaFFiVmlYeFMxMFNwc0RN?=
 =?utf-8?B?K29tWUxiWXRTdDFhRit0dDA2a0ZseEIxdnh6b29wbzJWY2t5UTNwS3B2Sy8y?=
 =?utf-8?B?VTZiMEVoQWFWYmN3YllwMjhPOGo3c1JBWXh1YlV2UmpZSnlJUUdxYkZVWDhN?=
 =?utf-8?B?WGRBSkRsTkJVdkh4ZXNLUHFkN1NNdjNVSURBSTV3dVNtcktXd1lLdjJsK1BB?=
 =?utf-8?B?NHdkUXBsT2t5Q0RrNVBvRTlTK3ZiK2V5UXdsYkt0OVY0cU5BM2dTUWVabGNT?=
 =?utf-8?B?Y0lmc0JTdlRRQlc4MDhsa3RJOXpGUHRudW1OOStxMVN4Mi8venZad3lsY2Uz?=
 =?utf-8?B?UER3bnRta0pHMEV6WG1HZUhyMzZFMzNGUDZjWXFDOHk1dW5lc2xvMms3N1Yv?=
 =?utf-8?B?M0lmWEVyUExacjZ6S3pJMmNiRjZVQitUaHJKSmlwNCtQQ1cwNHpCOURBbjVD?=
 =?utf-8?B?cjZzTVY3RCtsbDB3NlkyeU1lTWZmVlIrTEliTUtoZHpPaDNQT3h1djlQNThu?=
 =?utf-8?B?cU5PZktpMHd4aUVJQ1FwR1djRDBnUXRxSDU2c2liUXFjYXllalk5dEVIWW5j?=
 =?utf-8?B?RjZkNGQyNjlkSG1QYUlFbzlMQ1Q1NWhZVnhvYXZ2eXZtbFhHNlJLR2xGQ1dT?=
 =?utf-8?B?dk13MXFZVjZCUFlmVkdDQUVic1hzMC9pV0grRHdXWWI3V3pTSGpoclo5QTAy?=
 =?utf-8?B?YmdNTU9iek14Q3M3dTN4THNkdllTR1MwN2JqOUwwY0pYT1dCZm1OVThwVmxX?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LPFE/F+uFQ9rnCMKOeUBSkXpbJX/P5+7B3sfqhiWKgs6oFMgP6IUXqXZ5H8shS54b6bUFpkmCiAXsa5pB7bwWK2d18eDpmQn72vUuQq6x6x+t8Od4X25wBkkzjlge9t/gtFX0oirFAiwBgO6Djh9IkW3aobWpB5nVckFoFCT0/ZCkJ5+m61+YK89JZfSjwNfR5lJVq4gKB/7E/pLIAmJ7Sdz9hpt0DaV/VU29B8w+3FJblGQCt1KR/PvimFffxSLecJF0SmcmqBa+hiD8a7LwmnYzGFMPbVo2XJR/Katm9MbUEeMqdtzXN3yEXCG+31yDL3NFsmCY6OHN3v8tr44mHHq0ivn+lEB0hr5t47+XACjyn5yMROeWjbUzYAhq33D2uLkDaOezEKc7dcdoObI6AtLIPTxQneOSvJPK8TTFVFUiKBAPFHBrZvDc8KpzDgKpLT6dUs3lqEEQXpYoEnr+iFGjnLMDuSUrfsnD+eJHVTUGipNlGBP52U0RYMbM0zjTAubdscHqqcVozW2WGSZuR67qONupNsKXGlcmlhVe6a0ARP2lrVzfT69cOn63XxtkvRihwGKspffQCvqQsk++gV9RN7tHWAWSd6JO5C9KCM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a41963b-84ed-44de-f53a-08de122bbc3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 12:00:18.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFG6mPl0ngFEGl7NFGaRLk1xxX/kLtyFPi5Skc6r0Y9YOKAQboiIo47tkDYVB0pzMKNGgHiW1ljTFSBIsoIIxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510230109
X-Authority-Analysis: v=2.4 cv=GqlPO01C c=1 sm=1 tr=0 ts=68fa18d9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Vcy679Fr2L1023BiWWoA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfXx7WAK9iwShtr
 dimn+fSZfUbB059mxYkJS6bTc1hNK/eqod/7jlxyaNZcnAi3Yyb2lNRoYY48p2/P0D4CXSgvig/
 LC9CHknd7yTKlELR6I3Aa6e2J3xrUEEKDipGmeMaFYKpDNwUh9gnP0yytbp3qNxfogWCNyvBrOt
 d0nwl9DCclls8pZnmF1B0NAf4zmyYzBybxcsKc0PPggkysdFkN/i7gE4S4nf1gO8mHD1etZXhrB
 iE8IOu9Dd+RJYYqVFwVk9bw2V2hcmq8a7iW+Z0upUB5vKLo9sSi4oC8v9O1ugu65bxjyCa+PDMY
 KcTiPxm59lH1z7L88Zx0WPO6AX/qhi9K78sHVzSlX/Pkp6NnBB67DUBVxvlzjH3ddpRPL/wriCn
 EnvQR4cUHu/qFz1LoATEVo48AYmtigR1TqL6ebF2L8IPNy53rpI=
X-Proofpoint-GUID: hEGo87bKVx6qjhnACNtVhS6M_CTxbT3M
X-Proofpoint-ORIG-GUID: hEGo87bKVx6qjhnACNtVhS6M_CTxbT3M

On 23/10/2025 01:58, Eduard Zingerman wrote:
> On Wed, 2025-10-08 at 18:35 +0100, Alan Maguire wrote:
> 
> [...]
> 
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index e135cc79acee..c2fceaf392c5 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
> 
> [...]
> 
>> @@ -8342,12 +8372,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>>  {
>>  	struct btf_module *btf_mod, *tmp;
>>  	struct module *mod = module;
>> -	struct btf *btf;
>> +	struct bin_attribute *attr;
>> +	struct btf *btf = NULL;
>>  	int err = 0;
>>  
>> -	if (mod->btf_data_size == 0 ||
>> -	    (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
>> -	     op != MODULE_STATE_GOING))
>> +	if (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
>> +	     op != MODULE_STATE_GOING)
>>  		goto out;
> 
> Removing this check leads to:
> 
>   case MODULE_STATE_COMING:
>     ...
>     btf_mod->btf = btf;
>     list_add(new: &btf_mod->list, head: &btf_modules);
> 
> Even when `btf` is NULL. Why is it necessary?
>

The reason here is we need a btf_mod list entry for the btf_extra.ko
module; unlike other cases it has a .BTF.extra section (objcopy'ed into
the module to save bloating vmlinux with the large .BTF.extra section)
but no .BTF section.

>>  
>>  	switch (op) {
>> @@ -8357,8 +8387,10 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>>  			err = -ENOMEM;
>>  			goto out;
>>  		}
>> -		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size,
>> -				       mod->btf_base_data, mod->btf_base_data_size);
>> +		if (mod->btf_data_size > 0) {
>> +			btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size,
>> +					       mod->btf_base_data, mod->btf_base_data_size);
>> +		}
>>  		if (IS_ERR(btf)) {
>>  			kfree(btf_mod);
>>  			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
>> @@ -8370,7 +8402,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>>  			}
>>  			goto out;
>>  		}
>> -		err = btf_alloc_id(btf);
>> +		if (btf)
>> +			err = btf_alloc_id(btf);
>>  		if (err) {
>>  			btf_free(btf);
>>  			kfree(btf_mod);
>> @@ -8384,32 +8417,45 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>>  		list_add(&btf_mod->list, &btf_modules);
>>  		mutex_unlock(&btf_module_mutex);
>>  
> 
> [...]
> 
> Apologies for delayed response, will read through the rest of the
> series and pahole changes tomorrow.
> 

No need to apologize, thanks for taking a look!

Alan

