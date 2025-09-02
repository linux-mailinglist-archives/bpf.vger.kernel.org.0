Return-Path: <bpf+bounces-67150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA00B3F700
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 09:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7172057DD
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA502E719E;
	Tue,  2 Sep 2025 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CvfIyGim";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="slm6J4dK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94B2E62D4;
	Tue,  2 Sep 2025 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799503; cv=fail; b=RfcHwuYfxRZPnk2YOcpt2jj3Md8R7cYwEYslfV2tydQcGOM7/swZlvn0T7g1Xuzwi2weAwXaKLFzBg6o2NMkn7jb9zNgG9OCyx/s2EQYU1ZBTvwkHfH5IMiwjFN9hNL54sSm7YkSnIxIgYEN1ck8hMV2A+DsCy5NRHTWNxXqdp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799503; c=relaxed/simple;
	bh=5wOAh7FBa/dYu07jhVvNFBum9cvdiZaruMi/dEtIzyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jOdjzxDQxqJb2qDNHnW+wpA77OPU7bMr/1Q2ksC1xgDYdIgJl2d7MHsGX3Cpr0tOQer0SF+qVequ1YSfUNMXJsa4/itAEHWiaW6+CntgdWMUbuQlwh1+uFib1ksKpYEk0Qnaq19R8pwRXjr8ksemo3JsF43T+Oa9YNkQDhgMbhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CvfIyGim; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=slm6J4dK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5826gOST001335;
	Tue, 2 Sep 2025 07:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6iDR8SFfqWivGj/8tbiPhdbpUbF3xblj3ZvLYcQ+omY=; b=
	CvfIyGimelRTkZLB76P0KL7ZQuFBKL1o0UEt87bUen/TTrj5CUOyOVd/y+O3H663
	ZEY/MT48PxcwKGajjaNL+OgXp/0woRWQ1NgOmuPRJwYs5EwSFQMseMsVRxfERx8s
	ei7xsbH5v3G7ulfdRlrgeLCJCnyHR/uXVfhyaqPIXnFsIumRPv5KQZ539VeA3EVx
	QhnHlhQKtW5nq5iWlKiW82uniz9CBa/qowRHrMw9szGx9N7E3hvd0inpVjAPYoQc
	kSMBYGq4s2VTx2qreLGxwSI5E797WstjwSu2Ee4/oijkzmy+Nf75IJV9hrQZnuCM
	Y5kOLrf5+frXCu3gi/x37g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ussykcux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 07:50:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5827lQiT004131;
	Tue, 2 Sep 2025 07:50:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr8sk1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 07:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJUBbu6RScEJajc94smPwq1phquvVKfC7z5mKEkPa9NRVb898ojxj/8CjORnWsV+KgRmH9kpG7W2Ru9J3vU8nhreG/cMiOFXVhvYYQo8dUSVzQZl1jYr3DJd6QcbuH8605O/bdqVz81PaVCak31PmKCZ7XEQIQGNbxREwz7N+zCj4iT/+e7st2xl3jfRTKFhxHbNLQ2ea6IDM1N6GgPLKudOwPE93XqHOLVeJ9ffmXnIZiS3jzxpZGMB1dNafwymj0YCDa9/hlp3pWsy5KNzVQx8ljvWWCCa6RCTNwolF2x0k7r+fGo6A0YOdAfbSG4MJ7q6n7zVymGcA6affVN+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iDR8SFfqWivGj/8tbiPhdbpUbF3xblj3ZvLYcQ+omY=;
 b=UjRXTwIhkhaeO1guSp09N4kCNZIyRJj1XAI6+rl6Ab7JFoMqQ2BPQip/pwNT6+t1859gKtxRWmbv/8ZMd9XpQ/pnud/6LFjn75MgR+9M7FdhSdDZNv413YiILUICz5LUfj6sHuVC97cZmksX/ppjbUaK4IOdXew7xJSqfVoz5VHU29v7R910UB3jduSqJXWFtZmeB9uKVKvtqCP1dyZD6KuUeSYQaqPPn7SzW0LJLcIQe78erEnmq7agqCJdMm4/IsUqHrTVPjEav3H7R/jkjPpIm0WCqEZKzGeTLSe2g7PG6Lsx5LzXhXO3PYagC66ZzXLj/uOeco8enpOqTKSbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iDR8SFfqWivGj/8tbiPhdbpUbF3xblj3ZvLYcQ+omY=;
 b=slm6J4dKdEMh35LCexKoG5AeQRkWlrdiMovkxEzO0AjUOo2L/x0QYktLDe+Uid8GAIPj8IsspTpQerSrksFAXWttcA5GPRQzlAGqEPbXyuDroN7ydqzQfOgEblJWBQeZV9jd9oXm6bUaA0p6CB5NfjYb9wmvy5JKiY7UIJZfmsQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5974.namprd10.prod.outlook.com (2603:10b6:8:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 2 Sep
 2025 07:50:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 07:50:26 +0000
Date: Tue, 2 Sep 2025 08:50:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <21b73d0f-c322-490b-8fb9-ef9f67f7393f@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-2-laoar.shao@gmail.com>
 <f1bc20e0-9d39-4294-8f70-f51315a534d8@lucifer.local>
 <CALOAHbCd4vuZoot-Bt4y=4EMLB0UvX=5u8PjsW2Nz883sevT1g@mail.gmail.com>
 <80db932c-6d0d-43ef-9c80-386300cbeb64@lucifer.local>
 <CALOAHbCQucvD968pgmMzv0dcg1j5cJ+Nxz4FKaiGXajXXBcs0Q@mail.gmail.com>
 <95a32a87-5fa8-4919-8166-e9958d6d4e38@lucifer.local>
 <CALOAHbBRQf=QLqYgA9E8m6AKGmZxY6rFZsoXwTYCaiSqpTb=JQ@mail.gmail.com>
 <73ca819c-9a2b-4f12-853d-557a4e7399e9@lucifer.local>
 <CALOAHbDXBaumw0W=Ak=AQG+64jQb9Usy8_9m00vNaZ7SPKFayg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDXBaumw0W=Ak=AQG+64jQb9Usy8_9m00vNaZ7SPKFayg@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0197.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a7d5ab-9b83-400c-4b9f-08dde9f5610f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVRPOStmMExPUEQ0a0UvbjZjcWJIWUFqdzk3VGZGMS9BczNJWlpscndSS3Js?=
 =?utf-8?B?dGtHajJsRFAvZUM4VGZoWTA2Rkc5NjF2MmxYZTVHMU96MWw3OTFmRU1oRzEz?=
 =?utf-8?B?L2p1My9IeVg1L1p4Z2RNakdxdEpBemtYdmZwTW9KOFJYVWlQWWVoRFdJcjVI?=
 =?utf-8?B?Sm9QUFMxWk5xWkRVTWpiMWU2bm0xUC9VMzkvbktTc01ZczBROUx0UGxQbk90?=
 =?utf-8?B?SVBrZlhWQUt3R1V1UFhtL3dwYmZBZm1BMUpNZjg0NFgvY3BQcUVYblJtM2Ft?=
 =?utf-8?B?a3RrWVlOcGVOQm5ndmxUTjhqdGZaOHZKUEd4UTRud0VoeHAzZ1E0SCsxNkRP?=
 =?utf-8?B?Y3EyZ3diUmpJcmYrMDEySjBJalJhQmltZTl3QkF4V1NRa0txMWhpSHpzaGhF?=
 =?utf-8?B?MzB6SnJnVDJCZ1lxQ2dCYzYwaGg2L2I1K294aGNPd1dpYUMyaWd2czFkTysw?=
 =?utf-8?B?UGY1ZDg5R2tITVJhYVZhREx5dHhYM0V6ZXpkZUcwYVRTMHdtY2FtV1Rmd1k5?=
 =?utf-8?B?VHhPRWRTd3JWMm9RSm5OWGxEcC9tWjNuR3VVL0JRVG1zbWZPdVdKZ1FVeU5E?=
 =?utf-8?B?RTVaNUFMb0ZxNXJYaGtjWFU4c1V1YmxoV2toVXU1QlRaYlM2UlRTZkpXRTU2?=
 =?utf-8?B?RS9QcmVRcitIbkhKclJqb0ZhN1A2cTkyYU56M0ZGVjRaaENseVpvMk9taW9M?=
 =?utf-8?B?Q2IrdGdRdFBtMkw4TU5tWWF5TG8rRnNsZ09wMEJqUDFqV1ZrbEZjTXhZVDhE?=
 =?utf-8?B?ejRoOElxWCtPWkRqazhuTFM3a25PQ1lueDE2Ym9pVXlNQU9MZlFzVWF0WE9H?=
 =?utf-8?B?ZkQrc0hXNm5xN01pcWVKQ2lNcUVSQWdBSjU2Q2xYdzY3cFdzL2JCajJ4Uk1h?=
 =?utf-8?B?TGZvazBVMVlhcXAvVWN0YjQrT01JdEI0TWdBd0R6cWI1RGI1aGhhSldsSC9t?=
 =?utf-8?B?RmZVY08vUXRrcHNnOVg2RjNGcnB3dDFudTB1NHNydW8xa2tadTNuUkRYaElH?=
 =?utf-8?B?SEF2Z2lsRjZuN0hVM0loQ2ZYRWVHYi81NFZnbStwWnJiUHlPYllsR0dHZGwv?=
 =?utf-8?B?OFVYRWZtZjNXbmhQcjRzbXRaMnBqSkhpcFNhckJpemlkY3VVelc0TUdBQVA5?=
 =?utf-8?B?bFdZbXZnZmZ4TG9tVVhYd3RUM1hnbG4wMTRwNGg3dlFOTXVlRnkzREppdTJs?=
 =?utf-8?B?UkcyWGV3d253MGFQLzF3T3BhMHpBMU9YTTVyK3JjU1hURElKZXBodHF3ZEJx?=
 =?utf-8?B?Q3NrZ0F0SFhyQ0tpZk41bTZsdjVCRTF0QjhRR1puam5RUzI3QXpncmdMT1Z0?=
 =?utf-8?B?TGxJMlNwTWYzTmtIdEZab282em0vemE2NS96aVZjbDBkbTg2bUk1WHdRSldj?=
 =?utf-8?B?YUJQNXZpUU0vUUZ6aEJsZ1JreUlNVlRDRU5aa25lT2krMk1GTXR5dHA1UGtk?=
 =?utf-8?B?YTRSNUVJNDJ4bWdCck93bXh4YTUyRlZoNnlhcEtHUUhNdndLTnY5K3M3T3Ny?=
 =?utf-8?B?WGt6cEd6Rm8rRGtMbEdrZlFZaXliY3hWM2p1QjlCSXhYemd6OXFFN0Q5WjYv?=
 =?utf-8?B?WGFtbTVpT0lGQmdjdUFKVUdDNVlFd0F6Z3JXTlFIdzlaUTZrT2FicVMxcVZS?=
 =?utf-8?B?b3g5eTIzM3NZeW5JYXhoMTcwbWFTRE5rdW1pM296R2pkbk1TTjRpcERndGoy?=
 =?utf-8?B?VjFzZHlRVXoxd2N1SENKVTdTU1doL1dyc1R5NGtKQWIrZWxoMUtwWWVrM1N6?=
 =?utf-8?B?RUhnZWlpQmFBVlFEWnlMaGFCMEVZLzZIelBUQ2xEZTUzVDNhUm9YM0VKaFZX?=
 =?utf-8?B?STNBQk9UT003T1NDUGZ4dVNxMDAwU21aZ2tkOWwxRlI0MEFwOUVWdmQ5Zmdm?=
 =?utf-8?B?RzladURzRGFJZVBYQW1odWd1SHhwMkI2a1prVllSWS9DaktxSmFHMEQ2OURE?=
 =?utf-8?Q?XirxnM6A93s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzRwMWxHM2dGMVM5Y3BvTlVmNWwvZUI4ejk1UTRuTVAzTXgwdjZrYnpkRGFB?=
 =?utf-8?B?WDA4and4SGpxNlUxYVBTcTlyb3Z3a0JsL0RCTUU2K2dGKzFmR1VEVVA1b2pq?=
 =?utf-8?B?QlBEa3ByZUIzQlB4UTlyaVAyT0w4YkE0ajB4V1cvMFBZMmxVVDIxWTI1aTVw?=
 =?utf-8?B?b2hIQ1k4dyt3a1krOHRSK3IrMUZ4c1hvUi9sSVJlS3FXL0FFcXNUa244bDE0?=
 =?utf-8?B?OTBQSllBVURMSEp6ZGtNL0JkY2wxeFF6MTZJKzVNMEZRdzdlZGplajB6N0xK?=
 =?utf-8?B?RHUrOGIxeGR5T2MybzFId0hUOW8yZ2dOZjhtbldBSnNHUExCZUFKOVo2MFVL?=
 =?utf-8?B?TnBmU3cwOVd5cVIwV3c3U21mVDVta1FZMmNId2MvdXdrQUxGTW1OSUQreFc0?=
 =?utf-8?B?d2EwNlNTQzBCaUdORlptVHBBSDNJdlgralQzYnBvSGtOTERJQllNZm1KNHJN?=
 =?utf-8?B?U3JnZmlIQWFMdnZUSVk2OG01U09KbWc0THBibXU3bVBEaW5xZHJXMXNXQ1BJ?=
 =?utf-8?B?OEFPOHg4N1ZGT1lBcUJtN3ZzWVJlUDA5VUZ1VXg2S29lVWdBZGtUOUF3L3Nn?=
 =?utf-8?B?WE8wNTZ6S3AwcUh5VWtTM2cvOE5uTFNSTndSVVByZHh2K2ZpeVJDY3V5ZU50?=
 =?utf-8?B?ZzFPRkw1QTdWRGZXeGJKT0NjSmpRVjVFRlZYK0hUOFdKK1BoOVd0bUNHZTh5?=
 =?utf-8?B?eEtTZVZnZHFtL0FVNWxqMVpyTjZZSlBRQXVUVGI0M0NxZys5YjkzY3RzQStj?=
 =?utf-8?B?R3BRR1lDSDRXZUpMd0syNU5hSjA4c1NoMHhqVkovN1QzaTczODRnT2tKbTZk?=
 =?utf-8?B?ZU1zaDF3K1lQRDhpMHdCbTB1S2tLYzNIK21jNU5IdFJheEc3SGRRWUJFbEIy?=
 =?utf-8?B?empNTzByUmxEMHNaekRBVnVqRHlITDI0dXlQL2R5bnRUV1p1WVBvVzVLbHZi?=
 =?utf-8?B?STRXaDg1aWVoU0d2Z3c4bDZXY1pacEo4YVhpN2phVU00Rm5PL2I1UEJ5SkE3?=
 =?utf-8?B?U1JtTlc5YWFrT0lWamx1aUJYdy8zdDQ5TXVJMUV4U1FyaUI0a2g3ZGljMFR4?=
 =?utf-8?B?aEsxRndsU2VPUFF1ZFloQncwNW9pRkhNcTVSVlJQclR0WVhkT1pSZ0hMdlU2?=
 =?utf-8?B?ZGhVWmMxcXg4M1QvZ1Q4Z0pCdGFWcFdzemlEaFZFMGtQSjVxeTIrVEQxQVJ1?=
 =?utf-8?B?KzFVVXA3Unk1OVVaMVcxWTdXQmdxSlA3YUR6enkzMXZOaXE2MStlaU4yMFQ4?=
 =?utf-8?B?SGw2SGVpb3htL3U5OFgxd014SCtDcG9PcVZnOVUvcVJjRDlZWHNvZjRWUVZG?=
 =?utf-8?B?NVpYcUFtc1pnbnJlTmp3QzRlY0NLcWFmdUtzMHJQVmhPSVhHSzBPTmVYTTk0?=
 =?utf-8?B?MGtOcUx5dzNaNXQ2OFRGc0VyRkgxaWlzdmNCc1NWUDNTU3I4RlI2VnRoa1l6?=
 =?utf-8?B?RnJINUpjQWtieUExcG9DWHArRnlycWRRWkM5ZHBibGIyOXdaT1QyMUozYWpI?=
 =?utf-8?B?THpLUUN4c0RmTThPNjAxNzFmVWJsVm9LcTZkcGxsbzhkb2tDK3A4NXAvMVlD?=
 =?utf-8?B?Y2VxTHgveGw1R3RTR01DYk54dlhuejFuTUJWYXJvcVVKUWZTVWVOTkdKMEgw?=
 =?utf-8?B?Mm8vYUl4T0pJcE1sZklDVkExMTFiWkMra3UwWENRYW9RN2kzSTRBcnZzaGtt?=
 =?utf-8?B?ZlArTXVDZ1o0bVVCenBTVDM5a1EzbFFsTTJOT3dLZ0dCWnlsMmhTY0U2QlNY?=
 =?utf-8?B?WmFpbDFJZTdiL3M2bDlVNjBrWnZPVnpEa1RZcnBvOVBaU3pleGpIRlRkUHVU?=
 =?utf-8?B?SStmVGRYM2J5UFZSVVhnQUk3ZFR6VVMxQVQxeit0QmpwUU5IWmU5ZkhWTTRV?=
 =?utf-8?B?K3hQbFpWOEJnVXZPbjB4SDFJYTM1bkJKWGd4VVpsR05rUVBoR2cxd0Y2cTAy?=
 =?utf-8?B?b3RlTzlTeEl0YWpJaUVtUmlZM0wvcU1mU3MrUHl5L1VNU294aENMdkt6Y3l2?=
 =?utf-8?B?UHd6YitYMVd1MU5EUDVEcWF4N2xjc0VOT09wYUlVS2Z0MFhEMDZZNlFTOFFw?=
 =?utf-8?B?QlNBdEhhRC9WVHdpTlNSOXdHblBKb2J3Z05aV3N5TFVudStiTElNcCtidkhK?=
 =?utf-8?B?RUJiclhLLzFqbXhYSWppaXRWQ2J6WWJINmM3TTg2Mk5XNEp5d1FhUFdGbXls?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	itBgJFueaIrEqNn/K29/Yg4O+CB274idrFknOhl8qiQrIMDgxaIw2u+eNh7IfipQkbGgp+7iIOb2FVrFGVyz0BXQPaCRaVF2+CuzujooYv4/U9/xJ2jSCi2SOz16c1ER0ZXE81IdG/p4yLAQgipnXMaFMtGLOFJF47Quxiz4uRtD7aOTnZVqO2YQIHZXoYeKR9rSS+RuN1ZYvaP8OnmtrUS9ywmiH+yeImw+N5kAA4fept6spOdTlBMzsRId+A67D1xhlBaXh7fxY0DJWPWdYInoFFWfV9yDwLAyiJG+l/ALI2rcvMElyJYNCKYNBku6PPVrU3dooufHlnjl6IDTILIrwuAf3vfLwJtoVSykbUJ7Qsnz3Wmnk3u8gyVXlfxBLwKPVATjoqfSMJVhxKQ8MrrY6rZT0eUdCcXFw8X8SLThzV76996cP921FBiwro3kTh2bKCOQeeS1jus1F9/x3YoEngQTOlCwmXFa1I7Xb63mkSv8YbRGgPJKH8EC/6ovC7B7FQQ9T9I/E+tms8PiYFzlaND7WfzEdlHYA7izP4RzaQnpVJnRJlb18IfcCRSna9OLrc3tVF2y30k/qxtFZEst3NRxDAzeQChg1huWLN4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a7d5ab-9b83-400c-4b9f-08dde9f5610f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:50:26.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zb2gmIaUtKvA0NErAxQu7TPDLv+NDll/0j3u3wOukbjMcSmE2RlYJTSCEfDrDuedVyRHSs0qzupi1nDfVIdBg+lCHDh13cJbfEfqL2OVe7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=974 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX5XxmVAsdmsrS
 CH5/92BqYRhRBcravQc2PUL4tWTfMaqf3KYz6vDk2BaWQclsxMnymbtMk2YzXQdZ58jpeOaLsZc
 ms9Y3+h22PefCorgwDfG8WUT9fnGHSMW+y5kH+IYMC64bMsX9mv5qtuf/aSIqx7MlNNogu07rLb
 mXgeuHCAtGi77+hlsOefYQzQFZ2TD8YQXdsHLBdENcVl5Ob1Rqq553nK4ElAlGdbZ+dFmk1s1T2
 aCfVHXV/wKuR07FFANI+swuaONNhjpXIFyzofld9zgBEu+uIPUbwWOARnNmbw2VbASKCYTPyvMV
 nkzYuMEOPPF/ZpR2HrpVLKQFfcmSN2H5Dh3ok2WXjLkncyX1lKdUdVblY0T5UcxKJxH8Y2kMI9g
 dhT0uH6/
X-Authority-Analysis: v=2.4 cv=X/9SKHTe c=1 sm=1 tr=0 ts=68b6a1c6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=BgBc7FZrOC9OQ45AN9AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=MFLWxieuL2uzg9c1HGcs:22
X-Proofpoint-ORIG-GUID: fzDZrgxPrs-BaHd4LFU_BAqFpQzRX3VG
X-Proofpoint-GUID: fzDZrgxPrs-BaHd4LFU_BAqFpQzRX3VG

On Tue, Sep 02, 2025 at 10:48:47AM +0800, Yafang Shao wrote:
> > >
> > > >
> > > > >
> > > > > However, when you switch the THP mode to "never", tasks that still
> > > > > have MMF_VM_HUGEPAGE remain on the khugepaged scan list. This isn’t an
> > > > > issue under the current global mode because khugepaged doesn’t run
> > > > > when THP is set to "never".
> > > > >
> > > > > The problem arises when we move from a global mode to a per-task mode.
> > > > > In that case, khugepaged may end up doing unnecessary work. For
> > > > > example, if the THP mode is "always", but some tasks are not allowed
> > > > > to allocate THP while still having MMF_VM_HUGEPAGE set, khugepaged
> > > > > will continue scanning them unnecessarily.
> > > >
> > > > But this can change right?
> > > >
> > > > I really don't like the idea _at all_ of overriding this hook to do things
> > > > other than what it says it does.
> > > >
> > > > It's 'set which order to use' except when it's this case then it's 'will we
> > > > do any work'.
> > > >
> > > > This should be a separate callback or we should drop this and live with the
> > > > possible additional work.
> > >
> > > Perhaps we could reuse the MMF_DISABLE_THP flag by introducing a new
> > > BPF helper to set it when we want to disable THP for a specific task.
> >
> > Interesting, yeah perhaps that could work, as long as we're in a sensible
> > context to be able to toggle this bit.
>
> Right, we can't set the mm->flags arbitrarily.
> Perhaps we should add a generic BPF hook in dup_mmap().
>

Yeah perhaps that could be a way forward :)

> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7a057e0e8da9..1b60bdb08de1 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1843,6 +1843,8 @@ __latent_entropy int dup_mmap(struct mm_struct
> *mm, struct mm_struct *oldmm)
>  loop_out:
>         vma_iter_free(&vmi);
>         if (!retval) {
> +               /* Allow a BPF program to modify the new mm_struct in fork. */
> +               bpf_hook_mm_fork(mm, oldmm);
>                 mt_set_in_rcu(vmi.mas.tree);
>                 ksm_fork(mm, oldmm);
>                 khugepaged_fork(mm, oldmm);
>
> This provides a mechanism for BPF programs to configure the new
> mm_struct on demand, acting as a modern, flexible replacement for
> prctl() ;-)

Hahaha that's obviously very appealing to me :)))

>
> >
> > >
> > > Separately from this patchset, I realized we can optimize khugepaged
> > > handling for the MMF_DISABLE_THP case with the following changes:
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 15203ea7d007..e9964edcee29 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -402,6 +402,11 @@ void __init khugepaged_destroy(void)
> > >         kmem_cache_destroy(mm_slot_cache);
> > >  }
> > >
> > > +static inline int hpage_collapse_test_disable(struct mm_struct *mm)
> > > +{
> > > +       return test_bit(MMF_DISABLE_THP, &mm->flags);
> > > +}
> > > +
> > >  static inline int hpage_collapse_test_exit(struct mm_struct *mm)
> > >  {
> > >         return atomic_read(&mm->mm_users) == 0;
> > > @@ -1448,6 +1453,11 @@ static void collect_mm_slot(struct
> > > khugepaged_mm_slot *mm_slot)
> > >                 /* khugepaged_mm_lock actually not necessary for the below */
> > >                 mm_slot_free(mm_slot_cache, mm_slot);
> > >                 mmdrop(mm);
> > > +       } else if (hpage_collapse_test_disable(mm)) {
> > > +               hash_del(&slot->hash);
> > > +               list_del(&slot->mm_node);
> > > +               mm_flags_clear(MMF_VM_HUGEPAGE, mm);
> > > +               mm_slot_free(mm_slot_cache, mm_slot);
> > >         }
> > >  }
> > >
> > > Specifically, if MMF_DISABLE_THP is set, we should remove it from
> > > mm_slot to prevent unnecessary khugepaged processing.
> >
> > Ohhh interesting, perhaps send as separate patch?
>
> sure, I will send it separately.

Thanks!

>
> --
> Regards
> Yafang

And overall - cheers for being an ABSOLUTE DELIGHT on review :) it's much
appreciated. I shall buy you a beer (or whatever is your preferred
beverage) at the next conference we are both at :)

Cheers, Lorenzo

