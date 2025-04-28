Return-Path: <bpf+bounces-56846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B38CA9F447
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 17:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B08166549
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 15:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107D26AAA5;
	Mon, 28 Apr 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VicF6Qlh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DtTazawf"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70296149C64;
	Mon, 28 Apr 2025 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853728; cv=fail; b=BUsCNrHOHNa3RdW2Verfwgi9E7bTmSTun0jKafXUBQkIosaTQAVZnvnHbglbd17zjkl9INwlU3fsUxhi1hji/xD9JVGONjzNK2p3vtrnNKroi9eqzwozPEb1SZiPMu/MFD1/Z9zbCS+fya0yVKdKvhIdW/AlYasSMKrSJ8jvUWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853728; c=relaxed/simple;
	bh=DBMi4A25jL3cVamylYHw/li0kTB9mcWahOXKeHR3n8E=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fm9nx3+dL9uqhGBXChC80QfWYJDFxa4e1d+np5BE2ICtoBR8cY8rfRn2loH4n2A2WQCVlluywmgduPwzFQ9aFkYZWnbCc8c5MEfOHwXk6xqDQmHIszOaqrOprsPgwrQw0dXwsgTq7ZX6c9+tuAg4I/rKhyyiy7Eio7jnTJxskho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VicF6Qlh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DtTazawf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SD4sUB013060;
	Mon, 28 Apr 2025 15:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UkRwng75Px0aVD8vDL0Gn50QnAs5GvasA1rWpxB2nQ4=; b=
	VicF6QlhTmGjiEYAsU8591YtaY80qeI887pfB4BYdyd2f2/a1L/RUa4tcdG9pKcZ
	+OsXB2PY18xZ3WnAxK3N8ICKocrJBIly8H+UZXP6c9jqTRmTZ3MJzqy3nNSlS03C
	xJnNxOaOq8/yMeRzOnSPUf/8MIbZwi2pn7wSCa3m5TIxqLmrh9akp+ZmA65o0CWe
	Mp0bhrclBwAehEzmJkg3W6ok5ywEtexW3vyF0qLoN3wb36YZyn/ukt4htz1kUUDl
	lINWEWNVFPmndbIQ/rJIZeapDDpxucu9i2AgTVxTZ33oikpkCAz9VEmXnqa6RQiU
	kyN6JHmLga5wz9sRngNMaw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46a9d28gu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:21:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SEcnJV028511;
	Mon, 28 Apr 2025 15:21:53 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010007.outbound.protection.outlook.com [40.93.1.7])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8jc3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:21:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XANL1UNF8XKKQx8fvbGM1izqcLlpUb5717+4D8a2xZfnMBtIx8RbZxH0yKpYzeFBGrJ2yDyKCFp9DTh5uUnVcy9Yr1yi6Zx3HStgcQ3t5Mj1Hnbwb7Di0Nvqee4WkfXwPCwTrkLVGUjZlEUbZvr+CQYxJyBaskqoKI1iIQL7oVTE+jx7NMDC37LCRdkzEVqsM9mhImPgAwPijdyAG6lktd7GueQ4dTNsRZA8Log8LCjfXERNmPmKcLtV2vmLfKYOQaCUkYKYg57A9BNPP+4OjV9qhUtTaZKknuuSIsmRKpgVJUw4uYAJbX7hvJw2Xtdte8qm4HbpYOzid0DYgfWahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkRwng75Px0aVD8vDL0Gn50QnAs5GvasA1rWpxB2nQ4=;
 b=lxiGdlrZv9m+8Wb6suyUhWiuGqB2ydaO5K9xZuftlbHZ3Sl+CkFC9Tds5DblplZmRozTy4zFFhTTXovW5eH84du14PrKDiodXv/XZDx204ofwJJ312n4lfBwzuXk4olBK7plYCw17HMLR5VtuGoUxRzQmeUlImJ1QsTD6w5F4AH6EOo6J5tPVSqYT6mc7WKoSz1fUVbCQECpCZHPI0d456XWMA97Mw0dcroHc8mERKZTg5OO+P3E8AoWsEcRPr59IJEwCP6pgQrGKc2NgTkbJNq2cXY6ohDhvt8Jpu8rZuAXm0RXjf9YnaCrorThjbhZOYSeHCc50IZQzq5q+Oxuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkRwng75Px0aVD8vDL0Gn50QnAs5GvasA1rWpxB2nQ4=;
 b=DtTazawfYzCDkDp/JLUZI/+Zh1qO3BAvEvqQ2uWZWcNek5vFcL0qGxFBWVc0ic2uFX83IQcEqUV6jp0EwH1Q9ubdRtKi7xn0iP9bujEY/0bmHrglxgFCdsfe/W758oItHZeqUYd6W8Hj07cxFzzmmKEYWY+lSAhL4RIVfI2COyI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ5PPF1425E126A.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::78c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 15:21:50 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 15:21:49 +0000
Message-ID: <e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>
Date: Mon, 28 Apr 2025 16:21:14 +0100
User-Agent: Mozilla Thunderbird
From: Alan Maguire <alan.maguire@oracle.com>
Subject: Re: pahole and gcc-14 issues
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com>
 <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
 <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com>
 <CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
 <c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com>
Content-Language: en-GB
In-Reply-To: <c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ5PPF1425E126A:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb6f0c4-0052-4f6b-aa3b-08dd8668579c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXQ4UEhnRExSZTNaOG9DUmw1TThOL01RbXlOVVpYbzJhRWJHekZFMVNMOFV3?=
 =?utf-8?B?c29Lb1NGcmtMYUNsM2gwb3doY2NtcXJ4NkdOOCs3OGIwempCL3psanZUVHdU?=
 =?utf-8?B?bzJzTE5MRkNueFhtNnlvQ3VQY2JFYWJ0R0tIalF0U3R0MzZ0ZjlxMUZsRWtl?=
 =?utf-8?B?NUgzaVFGN2dKNFNmQStkcGw3TWh4UktPY1p0Q1htRU5PQ1lmY2ZzRXpOR0pR?=
 =?utf-8?B?b0hqQ09zeFIzN0dUckdmcmNTVjZ6YTlIcjJ3cFo1cHNzNW9EWklEblNzM016?=
 =?utf-8?B?NmVldXhmd1Y1YXBIM0NnUU44TWh6aEYyODNtUDFURWFhVWhTTkx0aEhPaXlL?=
 =?utf-8?B?RkgvUnl2cDFQRW1rUXZ4TEJpRDJxZm5kOE10bzVYN09NS01FUXFiZEQ5S0c4?=
 =?utf-8?B?QUxZNjQ5Qm9HaWJ0b3pDWi9ZYXVTVVFzbitVNHl4QytPZy9yc28zUlFFS0tD?=
 =?utf-8?B?ZVNNN2pvK0MvY2dtVmVNY2k2S2NGSzhsVW9HR0MrYkdEeVNSUHFpSHNrZ1Qx?=
 =?utf-8?B?U3JTbzhRT2syZjVPZjNmdEJNNHVpN3p3ajZkdi90N0JmdzBwVkRpV3g3R2VX?=
 =?utf-8?B?Sm8waDdNKzFWZnVvbnBnRTk3RDI4OEhZbFlRdXdZMHdCRWJJUGNRRmRTdFp4?=
 =?utf-8?B?ZSsyWVFPaEhOMVhoUVBFL1JZK0xtaEZhUk5Da3Q3QW5zTEE5V201WUtyUC91?=
 =?utf-8?B?cU5HZXpwbjJSYnVYbk5DNmtwTHF4TG8zRHR4N25RdlhLd0hJelNMU0E1SkVO?=
 =?utf-8?B?TUgzV3llYmJnK0JTY3VDV2NBWm1PeEJQeXVrcnQrdWtQTlhtaFl6WHVOeXFT?=
 =?utf-8?B?SjRVN3dad0wvSHcxT01nblJHakV6Mm84dWpvS2hEelBrUVgwcGtaNGJLUjRu?=
 =?utf-8?B?WnhmejNIVXFaY2VjYzVTYWtYZENla0lCYVVUYWpLT1VFelFXMVFrMXZDSit1?=
 =?utf-8?B?VDlKT080Um1HbjcweTFHdjYwM05NNUtIL2xIZXhSKzRhSGw1cG1ic2o3cGZk?=
 =?utf-8?B?UU05b1plZ1N4YW1xUGl1cGw4NVFGZnA3Y20rMG80TkF1ZXIrRTBCbzc3S2px?=
 =?utf-8?B?bmI4cGJmMzE3b3RIeXBSRUxVUHVxY3hHSGxIb3NXbDdWUFJNaFp6Q3QvQkZv?=
 =?utf-8?B?cmpXMHBMNWFYd3gyQ2VyV1ROMnh5WnhrbXV6U1BtUFlQN0VpTTcvR0xnUFVo?=
 =?utf-8?B?djFTOTZmRmNtTSt2blMxcXFPNWtqbldrVGJtZ2sra0k5R3dEQXNWclVSUDd4?=
 =?utf-8?B?d2N4NEY2Wk1ZRk1pVDV4N1d4eGx3bkRYaSswOXNBVnpwMEFHMXBFUjE1M0JP?=
 =?utf-8?B?bmJQZXRWcTFnNmxHUzBLSHY1dzAxa0pjVStFMDRzMis3Q1lqME5CbW85TVRm?=
 =?utf-8?B?NmRLRFEvMTRyOC9QKzVNQmNTUVU2Y05DY280aFVtS0ZnbGpwMVpUWkQ0MjYw?=
 =?utf-8?B?NDdYYnZMVTUraVZPcWNJRXNQRmFud0l6Mzk0R2JrRXRJek1SODRBejg0ZGdY?=
 =?utf-8?B?R3Qyb0t6WlBUazVDTzVEYUNCOEtDa3JxU0QwUEtjTzBVK2ZHUys4RWw2ajBk?=
 =?utf-8?B?TUJEdlpOb0syNDQ1WHU4WkYyVjUvU3Z2Q0RIZWMvN2xlRGdUekdveWNaZTM2?=
 =?utf-8?B?TGE2Z1BjQ0g4RnRWTkUyMTBDL0pPSE84U0paTDJQUXRMNGt1MFNHQmNBWG9P?=
 =?utf-8?B?eklob0U3bkpYeHRKTUs4d1VpQnFOdUNWYXNFSnpqSFduaUdPY2xkM0ZOSU1Y?=
 =?utf-8?B?RGlaSmczdXEwWlVTdEt0STh2YmRKSGNTbWdCOFJHVGhVTlQxM0pkN215WEhY?=
 =?utf-8?B?aWlBbjV3T0xVVHRCeHIzSDNMcWpjK0FseXdnSEo4a2tpdklad0c1eUpERVBT?=
 =?utf-8?B?clpINVZhRFRyM3dVY2hlUjh6QnkwWnAxdTFwNjlvTWRYZVFlOEZUNVhxVmpC?=
 =?utf-8?Q?ROIy2yddlBs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0hISHd5eVROdkZXRlU2OHZqcUQ0WUxvTCtvWEdrWUkyZS9adzRnREg0eHd2?=
 =?utf-8?B?QkhkRUVxNE9SUkdZK0ZMWlVrTlNUdC9ZajRkTEJLZHZTdk5MQmVTYlFQVGgv?=
 =?utf-8?B?R2wyY3c4UXdiZWdKQmlNL3V1UnBBbkdIY0dFZDJQdVlDOUw1V0xUT1ZXclZT?=
 =?utf-8?B?M2xmMkE0UFBLRG5IMUh6c2hPOERvRHNlZFVFS1c4bUNpS2Z6U3dyYkx0Uk1P?=
 =?utf-8?B?bUZtN1dWRzFFM2p3VGgvRjRDRW5JQUZ2cXYvOTVpOEVnblovb3B1RHN0RXVh?=
 =?utf-8?B?dHBDRTBwVHpZRDR2ZTI4WU9IZ1Jxd09qQVBUUGJiVHZrdjJyZEZwS09tU2Rl?=
 =?utf-8?B?SUs0ZWtqMXBHc0ErVUxMYitoSy9Jb1grMG1IS0ZTZkMxNmVXWmY4Qk5iVzhV?=
 =?utf-8?B?ZFVvZ3UvU3VreTJnMFJLNkpRRnJkZlNFNmRTVVJrdm5tanFMeW5Gb2xxZk54?=
 =?utf-8?B?bDV6Q3ZWVmNDV05JeEppWEkzeE0wNWhRSzUrem5GTFV4NXFCMFhkcHpkYXVy?=
 =?utf-8?B?ajNsVk5TYzJRSnNsdENrMGJSWUNha3FsL3RZYVRETEp5S0VWSm9idmtXZnZB?=
 =?utf-8?B?WWttZVNhOTFRV1hJMkdJY3V3TTJWSEpDdmlZaFVUYTVwMmtoVmxRc2ltNjBa?=
 =?utf-8?B?cW9xMEtaaEFRdTgweG9aR2dRTWxqbUVIaDRZYUR5RWxHSS9LQ3FOaWw4dkpz?=
 =?utf-8?B?elNwcVNuY2pjTzUxUElobTJsOGtQMEY3aUcxR0tTNWQwdHRuL1QyMDFNbWdo?=
 =?utf-8?B?eTJlNmJHaUc0RGVscS9WaFlWbSswZjEzT0wrK1ZkOWRMa2c3UWRnYmt1Znht?=
 =?utf-8?B?Y1YzdW15TTZicjlndjV3M2NNL2FkZEVRalRoV3JuRCtiTVJmb1dPY3pjbkVu?=
 =?utf-8?B?NmNqZ3BuUzJPMi9ScW05MGxKdnVBSURRTUNEd3FCbVFzNFpUTVY3YzBGdU45?=
 =?utf-8?B?aU54KzBDL0MxYTBGT0orWStQUno1RThJQ0ZWSDR4Y1g4TFhxbWRBOFNrMTNy?=
 =?utf-8?B?Y1BsbHJwc3FPMzlKWklwUVRnNmxvNnZRYWNZWEpnbmU4ZFh6S1cyMUZTRVlF?=
 =?utf-8?B?dEZRaTNUaXk4VmlqV0w2RUV4THRNZkVIaE1RQjhoSGNJSFNVWXczcGtHQkVP?=
 =?utf-8?B?TTdOWDF4T01GZERleFZTUC9yRGh4cW5TNlNYV0JhWnNBQjVoSFV3a21VekhU?=
 =?utf-8?B?YS8yeHNWYlJaR1QzbVhBQzV3K2VvQW1VQys1ek1lQTloUHZkVnZjSjMzT0V4?=
 =?utf-8?B?WFNySjJ6RFArZlpQbTc2enhLaWlQU2c0d1hCTVkzOTIzRnBldFVFYXd2bHh0?=
 =?utf-8?B?YkhzYkN1bEdqbnJnVE5EVXlHWVVmQWx5NkFEUjc3dGxhQWV1ZSt6dlVGYlNJ?=
 =?utf-8?B?ak15TmNuK2hHM2YzbTYzckd0SnIzeGlFMllaT2lpL1FvbGtVV3lZYW5yQmlw?=
 =?utf-8?B?M2paeUZOMlZ3clJSZGZNUFFQb0toSlBxVzFiTHFnUlJ1aHhVcHF4bkoyY085?=
 =?utf-8?B?QW1UbDEvMVM4SEt6c3h2MFVOTFlzdndQZjhZT3RERjhFN042ckxsSTlwdTlp?=
 =?utf-8?B?VmY5emo1MkhPbXNMb0Z0eEppYU9udGVlMklVK3paUnd3SEZiNWVwOTdEQXlX?=
 =?utf-8?B?N2kyOVJqcFNsUUpjaUhpRHRyYWxONEZhWEFxMkgzNmk3SHgrR0p6T1pQekJV?=
 =?utf-8?B?bmVSVzVKRlhpUEJyUlpZTGVaYnZxZ2c3c3M1TXUrRVRIL3UyckNtQ3lBNko2?=
 =?utf-8?B?dWc3OFZrNTQyeFRvWmJzWlV2L3owN2JTeWFWR0hSU3Z2emM1bHpmd2VlanF2?=
 =?utf-8?B?UVgwMHg3UWpJMURvN25CanlHUnFSSnlyYnlCRU5zdDZ3T1lhSGZWM2lnNnR2?=
 =?utf-8?B?azh4ZHRtQVljbVhiY2orTGl6TnRBVk9NZTh3SUxTN3Z3NHR4YUo3Y0lkL0tV?=
 =?utf-8?B?VExNWFVQSG5sdlpXaUxPUFY4b0g3b2F0YXpXYnpvT2xYcmRRVjJNaGZsQTk4?=
 =?utf-8?B?ZjFYQjVpUTc2ZG5YUHhVYWJqN1FhWHlIL0VYRkc4bldRVkc5ZkFqZ1A1RUt3?=
 =?utf-8?B?QnV4NlZIbTQvTlkxd0ljNUVodVFMV1dQQkQreDlybFdLelRZbFRsa0hlaGF3?=
 =?utf-8?B?UTJZdnJuSkhjSktKM09NcitLZUg2bDRzNUpMOU52ejMydU9HZzU1OWt0cjBy?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WMdjkSDe6x0WUrAR84pYgQsn9UjkVmL+9vapYWbqbfjJL2Xsn+gvPeve6rAO/43xFdsjhroJV1FeUltPwsTg8drQq5zsHiyVYa2ymLHT+fTQBZI8GSxg5j7djL5CnsL83Nim8p16+2fQu39oo7dCgDWwdOr66UNBBBqeu9IYuNv196tMmOCM6cTlB2XY4D00pABqFjv8fLg7EYs7plzI7ut9ooKsea6KKFURJNQKhaOC7p+tJxHRAIwFaUG8YIxRZumlZfC0kovw+0r9ZoJ9Jziio98a2pmXM38A8xrz11HIH0lLOV6lC4Km9nxAnaY5cJHDVPDnvu19Qp3jg2L61NU9MbZ+K+WerwDbVe6bTTubcyAKvvHcY6jOsqCDwj5btlI2Gq8wZnZpDTcYhVP7CQjk9cyDjDoI+KnULd9vc9GS6PU1VOMYrGKnt2aFiM2DmoE9n7WtPy9YRcitq/hAQOCxsMaoHV06hMYm8YFGdYYu2KPZDsXtNG0lMzpESjjtmvIAtqOgHiLhQObuIZk6Z/whbFaoWXUjFh5aW6kbhB+FNwAABs0ArNPXbECwHZkSnzFKLh1LDZV/AnQSGrxhSbf+vXjm4Kbiphrk7yatJz8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb6f0c4-0052-4f6b-aa3b-08dd8668579c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:21:49.8034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYvacjvFvBHywxoCqTy0kPqLP5l+lIDLOM2YN7M/ziqX7GnDeQg0wmKdyTvsqZzwJAjaEAaVinEes9PwUUuGfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1425E126A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504280126
X-Proofpoint-GUID: hf81RGb3r1OBUG0uFxEJdRKAu0RgRoDW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyNiBTYWx0ZWRfXxJngVpT8MyEl AlA3ots1SLN0GT2congKGQ3xFVoIDAJhZsaaTayw06DtVv9u6z0NuJmyk+yqzP2QoUf4eyDw1j5 QXe42sC5r9Qam+VWG3yTNqL7NhVoXTpwYzLOwuibEwTZIUMnNPGvU7o6mpsxBcPvFQQmXOhLyaD
 IHUweZQc/tS5IKK1iLKDVYFpiy/98nCpRyXZLMZsMFlUZdE5q9GGAKmokyrUzrJSQhzjPW390It rG44FfNOPiEZkw434ACwZ3CbNB7ROVWSjQMFEN5fb6Rtff9RfmyCILkoLjt35hSpYv9DHytmyas KWc0d+1n+0/Bh0AHGukQRvgjVG/3sIovaiSRG3oVPihVXGOTkSNsEkjilTsYmDbdhL63S3dxCVL aYXQ4NlV
X-Proofpoint-ORIG-GUID: hf81RGb3r1OBUG0uFxEJdRKAu0RgRoDW

On 26/04/2025 18:28, Alan Maguire wrote:
> On 25/04/2025 21:41, Andrii Nakryiko wrote:
>> On Fri, Apr 25, 2025 at 1:36 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> On 25/04/2025 18:58, Andrii Nakryiko wrote:
>>>> On Fri, Apr 25, 2025 at 10:50 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>
>>>>> On 25/04/2025 15:50, Alexei Starovoitov wrote:
>>>>>> Hi All,
>>>>>>
>>>>>> Looks like pahole fails to deduplicate BTF when kernel and
>>>>>> kernel module are built with gcc-14.
>>>>>> I see this issue with various kernel .config-s on bpf and
>>>>>> bpf-next trees.
>>>>>> I tried pahole 1.28 and the latest master. Same issues.
>>>>>>
>>>>>> BTF in bpf_testmod.ko built with gcc-14 has 2849 types.
>>>>>> When built with gcc-13 it has 454 types.
>>>>>> So something is confusing dedup logic.
>>>>>> Would be great if dedup experts can take a look,
>>>>>> since this dedup issue is breaking a lot of selftests/bpf.
>>>>>>
>>>>>> Also vmlinux.h generated out of the kernel compiled with gcc-13
>>>>>> and out of the kernel compiled with gcc-14 shows these differences:
>>>>>>
>>>>>> --- vmlinux13.h    2025-04-24 21:33:50.556884372 -0700
>>>>>> +++ vmlinux14.h    2025-04-24 21:39:10.310488992 -0700
>>>>>> @@ -148815,7 +148815,6 @@
>>>>>>  extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum
>>>>>> hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
>>>>>>  extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __weak __ksym;
>>>>>>  extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx, enum
>>>>>> hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
>>>>>> -extern bool scx_bpf_consume(u64 dsq_id) __weak __ksym;
>>>>>>  extern int scx_bpf_cpu_node(s32 cpu) __weak __ksym;
>>>>>>  extern struct rq *scx_bpf_cpu_rq(s32 cpu) __weak __ksym;
>>>>>>  extern u32 scx_bpf_cpuperf_cap(s32 cpu) __weak __ksym;
>>>>>> @@ -148825,12 +148824,8 @@
>>>>>>  extern void scx_bpf_destroy_dsq(u64 dsq_id) __weak __ksym;
>>>>>>  extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64
>>>>>> slice, u64 enq_flags) __weak __ksym;
>>>>>>  extern void scx_bpf_dispatch_cancel(void) __weak __ksym;
>>>>>> -extern bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq
>>>>>> *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
>>>>>> __ksym;
>>>>>> -extern void scx_bpf_dispatch_from_dsq_set_slice(struct
>>>>>> bpf_iter_scx_dsq *it__iter, u64 slice) __weak __ksym;
>>>>>>  extern void scx_bpf_dispatch_from_dsq_set_vtime(struct
>>>>>> bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
>>>>>>  extern u32 scx_bpf_dispatch_nr_slots(void) __weak __ksym;
>>>>>> -extern void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id,
>>>>>> u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
>>>>>> -extern bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq
>>>>>> *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
>>>>>> __ksym;
>>>>>>  extern void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64
>>>>>> slice, u64 enq_flags) __weak __ksym;
>>>>>>  extern void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64
>>>>>> dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
>>>>>>  extern bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
>>>>>> struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>>>>>>
>>>>>> gcc-14's kernel is clearly wrong.
>>>>>> These 5 kfuncs still exist in the kernel.
>>>>>> I manually checked there is no if __GNUC__ > 13 in the code.
>>>>>> Also:
>>>>>> nm bld/vmlinux|grep -w scx_bpf_consume
>>>>>> ffffffff8159d4b0 T scx_bpf_consume
>>>>>> ffffffff8120ea81 t scx_bpf_consume.cold
>>>>>>
>>>>>> I suspect the second issue is not related to the dedup problem.
>>>>>> All 5 missing kfuncs have ".cold" optimized bodies.
>>>>>> But ".cold" maybe a red herring, since
>>>>>> nm bld/vmlinux|grep -w scx_bpf_dispatch
>>>>>> ffffffff8159d020 T scx_bpf_dispatch
>>>>>> ffffffff8120ea0f t scx_bpf_dispatch.cold
>>>>>> but this kfunc is present in vmlinux14.h
>>>>>>
>>>>>> If it makes a difference I have these configs:
>>>>>> # CONFIG_DEBUG_INFO_DWARF4 is not set
>>>>>> # CONFIG_DEBUG_INFO_DWARF5 is not set
>>>>>> # CONFIG_DEBUG_INFO_REDUCED is not set
>>>>>> CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
>>>>>> # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
>>>>>> # CONFIG_DEBUG_INFO_SPLIT is not set
>>>>>> CONFIG_DEBUG_INFO_BTF=y
>>>>>> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
>>>>>> CONFIG_DEBUG_INFO_BTF_MODULES=y
>>>>>
>>>>> thanks for the report! I've just reproduced this now with gcc 14; my
>>>>> initial theory was it might be DWARF5-related, but dedup issues occur
>>>>> for modules with CONFIG_DEBUG_INFO_DWARF4=y also. I'm seeing task_struct
>>>>> duplicates in module BTF among other things, so I will try and dig
>>>>> further and report back when I find something. Like you I suspect the
>>>>
>>>> This is a bizarre case. I have a custom small tool that recursively
>>>> traverses two parallel subgraphs of BTF types and prints anything that
>>>> differs between them ([0]). (I had to disable distilled BTF to make
>>>> use of this, the issue is present both with distilled BTF and
>>>> without).
>>>>
>>>> I see that struct sock both in vmlinux and bpf_testmod.ko are
>>>> *IDENTICAL*. There is no difference I could detect. So very weird. I'm
>>>> thinking of bisecting, as this didn't happen before with exactly the
>>>> same compiler and pahole, so this must be a kernel-side change.
>>>>
>>>>   [0] https://github.com/anakryiko/libbpf-bootstrap/tree/btfdiff-hack
>>>>
>>>
>>> thanks for the pointer to this! My initial suspicion was that we had
>>> some sort of dups of slightly-differently-defined primitive types that
>>> bubbled up through multiple structs in the module case since the level
>>> of duplication is so high; a colleague ran across something like this
>>> recently and indeed if I dump vmlinux BTF in C format I see:
>>>
>>> typedef unsigned char u8___2;
>>>
>>> ...along with the original u8 definition:
>>>
>>> typedef unsigned char __u8;
>>> typedef __u8 u8;
>>
>> Are you sure you are not dumping distilled BTF?
>>
> 
> nope, that's in vmlinux BTF, originating from crypto/jitterentropy.c
> 
>> This is the commit introducing a regression:
>>
>> eb0ece16027f ("Merge tag 'mm-stable-2025-03-30-16-52' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")
>>
>> Yes, it's a "merge commit", but there is a lot of code introduced in
>> it. Among it:
>>
>> + /*
>> +  * Use __typeof_unqual__() when available.
>> +  *
>> +  * XXX: Remove test for __CHECKER__ once
>> +  * sparse learns about __typeof_unqual__().
>> +  */
>> + #if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
>> + # define USE_TYPEOF_UNQUAL 1
>> + #endif
>> +
>> + /*
>> +  * Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof
>> +  * operator when available, to return an unqualified type of the exp.
>> +  */
>> + #if defined(USE_TYPEOF_UNQUAL)
>> + # define TYPEOF_UNQUAL(exp) __typeof_unqual__(exp)
>> + #else
>> + # define TYPEOF_UNQUAL(exp) __typeof__(exp)
>> + #endif
>> +
>>
>>
>> And that's exactly what causes this divergence. Commenting out that
>> USE_TYPEOF_UNQUAL #define fixes issues.
>>
>> As to why that causes a problem. I suspect __typeof_unqual__() changes
>> how GCC generates DWARF information within any given compilation unit
>> (CU). Libbpf's BTF dedup relies on a property that compiler won't have
>> duplicate definitions of exactly the same type (i.e., DWARF itself
>> can't have two `struct blah` definitions), without which it's not
>> possible to deduplicate entire clusters of self-referencing BTF types.
>> It seems like typeof_unqual breaks this somehow.
>>
>> We need to compare DWARF with and without TYPEOF_UNQUAL and see what
>> the differences are and how we can prevent or accommodate them.
> 
> Great find! As you suspect the handling in BTF btf_dedup_is_equiv()
> covers two cases handling multiple instances of objects in DWARF;
> duplicate arrays and duplicate structs. In this case however we are for
> some reason winding up with multiple copies of structures containing
> duplicate pointers in DWARF which have different type ids, which however
> both point at the same target type. Adding the following to BTF dedup
> accordingly solves the cascade of dedup issues for me:
> 
> diff --git a/src/btf.c b/src/btf.c
> index eea99c7..2155dd9 100644
> --- a/src/btf.c
> +++ b/src/btf.c
> @@ -4379,6 +4379,18 @@ static bool btf_dedup_identical_structs(struct
> btf_dedup *d, __u32 id1, __u32 id
>         return true;
>  }
> 
> +static bool btf_dedup_identical_ptrs(struct btf_dedup *d, __u32 id1,
> __u32 id2)
> +{
> +       struct btf_type *t1, *t2;
> +
> +       t1 = btf_type_by_id(d->btf, id1);
> +       t2 = btf_type_by_id(d->btf, id2);
> +
> +       if (btf_kind(t1) != BTF_KIND_PTR || btf_kind(t1) != btf_kind(t2))
> +               return false;
> +       return t1->type == t2->type;
> +}
> +
>  /*
>   * Check equivalence of BTF type graph formed by candidate struct/union
> (we'll
>   * call it "candidate graph" in this description for brevity) to a type
> graph
> @@ -4511,6 +4523,8 @@ static int btf_dedup_is_equiv(struct btf_dedup *d,
> __u32 cand_id,
>                  */
>                 if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
>                         return 1;
> +               if (btf_dedup_identical_ptrs(d, hypot_type_id, cand_id))
> +                       return 1;
>                 return 0;
>         }
> 
> 
> Now why this new behaviour results from the inclusion of typeof_unqual()
> is something I can't explain yet. Requires more digging to understand
> exactly what's going on..
>

The connection here seems to be around __percpu - annotations; so for
example bpf_prog has the "int __percpu *active" field, and with the
typeof_unqual() change, duplicate pointer declarations in BTF lead to
the dedup issues. As far as DWARF representations go, we can compare
good vs bad below.

In the good case (no dedup issues) the bpf_prog active member looks like
this:

 <2><155b7b>: Abbrev Number: 4 (DW_TAG_member)
    <155b7c>   DW_AT_name        : (indirect string, offset: 0xeaa2c):
active
    <155b80>   DW_AT_decl_file   : 137
    <155b81>   DW_AT_decl_line   : 1654
    <155b83>   DW_AT_decl_column : 17
    <155b84>   DW_AT_type        : <0x14decc>
    <155b88>   DW_AT_data_member_location: 40

...i.e. it is a pointer:

 <1><14decc>: Abbrev Number: 3 (DW_TAG_pointer_type)
    <14decd>   DW_AT_byte_size   : 8
    <14dece>   DW_AT_type        : <0x147ddd>

...which points at an int:

 <1><147ddd>: Abbrev Number: 216 (DW_TAG_base_type)
    <147ddf>   DW_AT_byte_size   : 4
    <147de0>   DW_AT_encoding    : 5    (signed)
    <147de1>   DW_AT_name        : int

In the bad case, the bpf_prog active member:

<2><3d594>: Abbrev Number: 4 (DW_TAG_member)
    <3d595>   DW_AT_name        : (indirect string, offset: 0x3b976): active
    <3d599>   DW_AT_decl_file   : 125
    <3d59a>   DW_AT_decl_line   : 1654
    <3d59c>   DW_AT_decl_column : 17
    <3d59d>   DW_AT_type        : <0x4bd05>

...is a pointer:


 <1><4bd05>: Abbrev Number: 58 (DW_TAG_pointer_type)
    <4bd06>   DW_AT_byte_size   : 8
    <4bd07>   DW_AT_address_class: 2
    <4bd08>   DW_AT_type        : <0x301cd>

...which points at an int

 <1><301cd>: Abbrev Number: 214 (DW_TAG_base_type)
    <301cf>   DW_AT_byte_size   : 4
    <301d0>   DW_AT_encoding    : 5     (signed)
    <301d1>   DW_AT_name        : int
    <301d5>   DW_AT_name        : int

...but note the the DW_AT_address_class attribute in the latter case and
the two DW_AT_name values. We don't use that address attribute in pahole
as far as I can see, but it might be enough to cause problems.

Alan

