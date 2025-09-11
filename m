Return-Path: <bpf+bounces-68133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52669B534E5
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787427BCECA
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 14:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA60D3375DE;
	Thu, 11 Sep 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PYVkXfTI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oOKEpM1z"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702163376B9;
	Thu, 11 Sep 2025 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599704; cv=fail; b=uPRa1/gOiNzK9PUjpKVhJCr5jRZ7vaHSCgabHgSSA/MBu0YVksyzrKGxjpJYoK9vkCVAtGbPEWyF9Lxypop58/58LwhSRAaMTXZ/eQlNrq3bu/gAUsT/OoeCi25dhKgBvCtkwesY9gTYHZE8Xx1Y7gIA3McNCmYsWLUeOTgHa6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599704; c=relaxed/simple;
	bh=k7CHrjDQ2Ccr35o07qoSJvOgEssSctJuxZ1L5obbj/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hwu6jawNvxEwhmYtZF6grWkysBou3RT0s4LozaZx/YsEyi5t7mRyp9Q0FCB1HZ80POUGiL3s5LvUVeRZ3P0/tpAMF1hZs2AweoWoloypwTj3GIwM9hzAHzT8TMZ+fol9fQbewDcOIFotiP6BKzKioT6TE7bT0CYd2oSGCGJoKBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PYVkXfTI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oOKEpM1z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDtvU8026075;
	Thu, 11 Sep 2025 14:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dAJtgFtj47yqskkD+qdGSCSETKT3Eld0thC/dv5DL6M=; b=
	PYVkXfTIUybLExCxEGr7GRL9z/l2FtwOTUne8WforRPh0u0WByzWZzulZF+0H4Kp
	Fe7Udc1pY+Bq/RYK9alIfUXt1ZTcUyfiWbuhIdDwlEAr9Q1hzC9S0DgQiJiG33s6
	hy3yPdKex5RXt00j/Cyn9FjBsguU7tIYnwl4b7UhxWe9BNkYpRfYgFqAJ529Iw9j
	qLRUMp9IHJTiVfL0XW+HB2tbN/wHKZ6P8RjChb/nSCIJEEHswvgs3BY/EwXEJTnu
	fjb/t2FwXPU2/SAsMgSNTKj1/KukXYydzGwuMpkW0UJhwuBkIetpdxI/fafM4oBq
	Oz0+Ptmkkc6PmVG5CWCK4w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x969ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:02:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BCvteZ031156;
	Thu, 11 Sep 2025 14:02:29 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcexr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:02:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xe4QH7eOjrNvHvCFh6SZ8T9+0A76lK9YAzk0SYra6L1hgd/Ik1BKYXUbc53gwHwACiWjshwEMF3WavrEAA6MF0EaSvAnbtPTyYUkoYvVu1IanJwMywMf5WTzSgWYsr9RaSPF+ohJNigK6RWoL6+fxZ8uJfMhByztohiTp5UZ2XzArz3Bd1pUNc6fwr/L1FQsjDFAsCh2EGNYwHuXK4HMJ7tX8eLAbdU2hMRHwsQ785S14Jyjhe4hknsXA4j4BAwZZSdoMF+8GgEsYC99f4QBmec6M1zp+UXiABc0IxDcnXd37EYbhS1Nj1Qz+0rDv41SGChlFmjDPmenABctT/HxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAJtgFtj47yqskkD+qdGSCSETKT3Eld0thC/dv5DL6M=;
 b=kCvjxtfe4sGfpCHnWeo1e8bxtZMfzZ+ZB7ZoTYlygI12oKZTjmQOieNZ+DF0+NqlG9YYbYS8JYhINGjrAtM6vcIF6KxsAr3ES0uFObE+Q1nXb03nXpdvRepCbQLSnZ49k0N04d10MtalMdXdQkZdEMxeFqo5kqlbJKtLzhxv3h021zX43jMhmFcHHPirO4U6Xdh/55EeplBPZ9C+muZE93WRMMBWUbkCGaJ4FvmwscxHEUlF8BlH3co22FKdPypOVC7diGV7tuxWtB1xeR60j6yWEMLgX0uln9VwCOXfR/1t6SyjI9nufEUo2aKZ/X7SXOAgIqpZWHMLqtNsF7R2Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAJtgFtj47yqskkD+qdGSCSETKT3Eld0thC/dv5DL6M=;
 b=oOKEpM1z4q7SH1j1q+Q59ZcALOmG76Gs/zpe/WIVWigWaYuDsRptBXn0+oDF0PvDY4OMrxzwW6Fsh9tbzMQO9l4WlYclLGQYhBXd8mJArPJXYs+LD0X5v+ra1TfpcUQQvMifZEX92J2hDQXZHu8r5vn4oM2sArXfwKizDjLCPUE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5027.namprd10.prod.outlook.com (2603:10b6:208:333::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:02:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:02:26 +0000
Date: Thu, 11 Sep 2025 15:02:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <3b1c6388-812f-4702-bd71-33a6373a381a@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-3-laoar.shao@gmail.com>
 <CABzRoyZm32HT2fDpSy_PRDxeXZVJD35+9YqRpn9XWix8jG6w8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABzRoyZm32HT2fDpSy_PRDxeXZVJD35+9YqRpn9XWix8jG6w8g@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0410.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 060d335f-3c62-4f7f-84b4-08ddf13bd6c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVcyZUEzRjNVVzRsdXRicGlTR0ZBQW16WXNZL2tCSDlvb3FESUVjVWxoK3o3?=
 =?utf-8?B?Z09BRVgzNFhrSldjUVJFRUJtMThTaGM0WTFvM1NlcXlnQ20vMlAybkNranJu?=
 =?utf-8?B?czdJK1diUHpCUUgzSENLejV6RTl2QklyM2pxZTIwK0IxblR5NCtRUGhrUkxT?=
 =?utf-8?B?SVR2MjV5d0puUTduVDBDblRCZGJuKy9UNWpoUG0xWW50NTBObHRMV0p3RUVq?=
 =?utf-8?B?ODBFYk5HSDNnTEl0dkY3ZEU2TlNTWVprN2wzZzF0Q1docXY2d1J6MTcvVU9s?=
 =?utf-8?B?YmI3MkkwWlgyUmFFZnE4TlJaT0x6L0Fad2h5NkI1UHh6ZUx6SGNzRDA2VzN4?=
 =?utf-8?B?UFd1ZXVYbXpnK0ljVmMzS2wvVmpWaEFLditSa3lmRU4wVDkxSDlwZzBiUTdn?=
 =?utf-8?B?bXRERUxDMVJtZmtoSWd5K1dQNVp5ajViUTlhR3JpM1UzTmxVR3VPeWtjQ1VV?=
 =?utf-8?B?bmZpQVk1R25kU2VJbitvOWNYOWVBcDMvNnFLWWljTHIvL1M4QTl0UGlya0hG?=
 =?utf-8?B?Z1hOYms3OFRNalZST01KSmJoRFVPYXRDbHN5ZHNMQVkxbDVqN3ZmQVZuTXg0?=
 =?utf-8?B?Y25UYlhjQy9tNnkzblhxa0NrbmxjamFsckcxck83UjlJUlhranNrcVQ5bHNU?=
 =?utf-8?B?WG4vYStKRjQyLzFTbVp6bURPWlF5c0tGZXE1YmdRQjBVczZjbXJJVnA1a3RM?=
 =?utf-8?B?MEZrZEl3TXlMMnl6WWsxTlBpeEFKWlhXQ0FNTFZydzZBU0tNdDA4OUVoOXND?=
 =?utf-8?B?TzZuZDlkb2NUa3hkNnRFbS9PVDBKdHAyWVhuRkdKNFlWMlR5Ums1OC9WYWlY?=
 =?utf-8?B?d0RtamhhT0Nna21ESGFxZ1dUbW9hMlBudHJUNWdvV1VHYzA5MW83SEtOd1d5?=
 =?utf-8?B?eXFpMmU5bll2OFdINVBCMGpETVJ5clBwRDV4ZTRpRG1YOUpxbXF5RzczcS9P?=
 =?utf-8?B?SzBlb3AzcXFUYnpZZUd5b3RYQ1ZXVHhuL0lBazZsYU94b0ZQTzd4T3phY09h?=
 =?utf-8?B?eDdKZnZXQlNKZGlmSVNEdGFzbU5DV3ZpYzBhM2w2ODRjTUxKMXBia2dtb2o5?=
 =?utf-8?B?c0JtUUx2QllnQVQvYTB0c0VEM1hNV1NwRnJrTDVYSUZzWjg5TU9GQmFjVmNZ?=
 =?utf-8?B?RmZLUW1WcGRta2hTTGp6MldROGFUbmthMnpqdFpYajlTblQ4QWZSa1krZFUy?=
 =?utf-8?B?UzV0TXNVZjNjUU42Wk9aS3grNThaMmdIRHNtbjN0eCtORFFYeVh4S0NGT2NY?=
 =?utf-8?B?cHk5WFQvWUVDY01wNHlWek8zV0pDbFQ4UzNGbThDU1hyUXRwU1pldExXcHBL?=
 =?utf-8?B?UHN2QWtuay9KNTE5elZGVFNMYXZ3em92UVJIYXhaZnM3WmE4dGNZdUozMDJp?=
 =?utf-8?B?b2kwT29SakVxTnpxRlNUQU5pb0JGRVZWVXVvaTBEb3NGbmZudk5RR0cvL3pa?=
 =?utf-8?B?R1pJSXZXd0p6TVlCdGRkSERoRWVKV0xtWkxuV3B2UzZtcWNRZnd5TW1EZkpE?=
 =?utf-8?B?YkJNVFdYQVV5V3BGOERQQ0J3MndmV3ppQXk2dXNraTNENkwrOE5leTVOVnVB?=
 =?utf-8?B?RldSZjdBQzhYQmJNTE9ObmhDZCtIaFE0a1NvQ1U1emt5b05CRFppTUdUbFVZ?=
 =?utf-8?B?S3pvZmtTK0ZEVzJiRjJRUzZ4R3FEdmE2Njl4RFBtQWJIOEZMU0ZscXlYQ1Br?=
 =?utf-8?B?aW5ZbHBYaGFMY01FSUE4L1VRV2wzSnJtSlkwTm9FNURodEdpbkwzckJacllY?=
 =?utf-8?B?MGhDb1ozKzFiNm80ZzBTUjZ1MExXT0RjeDZiaGk2RVlVSlljd2F1eVlVbHlY?=
 =?utf-8?B?QUIybVNqQjQrR2hmcUdLbWJZZ2tEN1plK3dCWG9ZYTdiMnlsVTFlLzRHbkYr?=
 =?utf-8?B?Z3pCZEFHK1phaSt6c05ScW5ERjlvWWE2TkM1cVlmT2tqbmt3aVBSa2t6c3RT?=
 =?utf-8?Q?Z+nup0l++9o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDFZUlIzcGoyVU9VMnEzNTA2L3N4WFIzMnlNaDhIV1lzK2xLR1gzd09nY0s3?=
 =?utf-8?B?OGU3UHQwdStlUGplYVZVS0R3QlBmQzAxZTRGdW9vc0ZUcTRFY2h2SUo5TjVw?=
 =?utf-8?B?b1BVRWNKbHpuNG55Z3drNmFjcllDa3ZIWElZdWRnZlhScEpPaEN4WXlWV29G?=
 =?utf-8?B?UU0yU2Q4WEdsbmtPM3RWYnE4N0xEZVhCb1lRbFl5blBWai93aThnNjlVdm14?=
 =?utf-8?B?RFpLUUNJcHphQjlnVUkrdkx6TGNtVVdwOTN4SGVvWTBiKy90QU1kd0JjRnVX?=
 =?utf-8?B?ek9CUGRoOFZPdUFmTHR5LytOVGJDLyt1dzMvTjVkeklUNjB0amJpa0F4ZXN0?=
 =?utf-8?B?cVM5enZuZTlVOURiYUdLZTNrUlgvRWlDK0g4VTZOWjFwNmNVYjZDZ0FHUkNY?=
 =?utf-8?B?U2kzOGdyTUdYL2ZyWEJvMmdydy82cEd0SnltL2xYS1ZQNzlpTkxjbmZRWDdU?=
 =?utf-8?B?Sm8yZDdMT1VTc0RDcXgxVVhLNUZYUTU0QlA0YmxwRGxITWUzTm5FUUZKMUFM?=
 =?utf-8?B?d2w1bHQ0ejhVM2sxSFNMRjF2NTJlblQvdlk2L0tFTEh1U3RldHNHY0d4eU5B?=
 =?utf-8?B?UDhDencxd1N4RnhaMnhZSUNaa0dGV0R5VjFpVzY0eGozSUVYN1hkL3VWMy9E?=
 =?utf-8?B?b1ZWelFodE9iT1VuMS9rT2hSb05Rb2xxdlp3OEdmY0pRWlZlb0hWN0tEQ3NH?=
 =?utf-8?B?MGVXNmg0aFZpWjdDeTlGNHdjQzdURW5rYVB1b3ZTR3JTaU5ldktGa0x3Mklj?=
 =?utf-8?B?WU9yZ2ZRUk9xMGhJREp1YVh3TlFjNi9XR09UODRteGF6cmY0NkNkYnViZ2x2?=
 =?utf-8?B?M05HQ25oN0piZklTWVpOMFF4VjJEK2hacnd4bzFuYnFtZFdtbGd1dmtqRTNv?=
 =?utf-8?B?bVd4YTBuQ2U0dDg5Q3B4dWdNZlkvUzJ6MksyUFRCcVpVL2Y4Z2E1K0FEVEVj?=
 =?utf-8?B?U0pYS3pPNEFseURKWG9Iek5WTFJDNWVVR2VOQXkvYXF0Qm9XemVTTXRoQWNm?=
 =?utf-8?B?MllscG0zNFJzclBYajZTRlBrTmQ1NWp4U0RHRHI5QWVaUWRkdk81VVVWTlY2?=
 =?utf-8?B?blBVdUplWDg2VDFodGU1anRqT2lLOGlTTmp0YjZuVmRHUGk5bStPTmRpYmVu?=
 =?utf-8?B?YXpkOW9yaThwZzh2QnByMnllYW43SVRrcFh3TTArcjV2VXNockt6WHV0bjJS?=
 =?utf-8?B?TS9DVHZLRjZFeHJEeUR2dWFyd3UvSklQdER0Z2lTRm41RjBGSnVkWXM4K0g4?=
 =?utf-8?B?SHlXeUpqV3AvYldKKzFZZzAvcUxkQWVZZ2ZWMFFIZ1dvZkdLaURaYWU5Uk5v?=
 =?utf-8?B?V2tIdDdQV3ZSRWFVZ0pHVzdGdmNZK25TbUp6UlBWdVhpNGMwWHVranJ0THk4?=
 =?utf-8?B?VFpQZWRaQ2NwM2wrZ2k0ejhyR3p4OS94aHZ4TFVCek1nc254YTBxcTRkdG5n?=
 =?utf-8?B?NG9ZL1ZDaTR4WHZHNmUxd09UTEZiY0xkalZjSXpIRDVvNnJyK2xVTTByaEVH?=
 =?utf-8?B?WHprcTRVRGVPTHlOVkNwWTZNUUhCTWkxRXFUZ2lVeE1RaXkzNy9JbVAvYU93?=
 =?utf-8?B?czB5NGd5YUdwZlZWbFVobzFpVTgwdXlFUXA2WGZ3U05PZnFJaThMVHl2bFYx?=
 =?utf-8?B?Y3BwMDRJZkR5aksvc002c3lmM0Uwc3NHMEMrN2NUMGsyYlQrZG5nSGUzMko4?=
 =?utf-8?B?eXVTK3preDEwM0JCMG41WXZqa2dVazFMWWRoQlZXU25WcUh1bktydmw0aVoy?=
 =?utf-8?B?ZXJxSEsxYlRDMjB2dVduNEhQM1ZRR0l2YVA2OEl0VEJETEcwS240QUVZTlk5?=
 =?utf-8?B?RG9aSmV3d3c1WFUrREJCUlluWi9HZkZxWm81WFVmWnJzS2swMU9Fb1JhSnpE?=
 =?utf-8?B?ODUrYlQ5YU1MUFNHTTIrQVh1RXVJRDFhVlZVTDIyZWJZR0I1bVUyaWNrQVd0?=
 =?utf-8?B?K21FSzZvYkVXVlAwL29LdXFYSlhQemtUc2NrTCtNbFkyb0dBeDUxZDRBakR3?=
 =?utf-8?B?Q3JPOWQyMzRrWkVSL1ltdDBhWkJtMnFHZzV4R1lXWWk3eE1PamJ6WEFtZVA1?=
 =?utf-8?B?Y3pId2xKRm9qaXFFa2YxRElMSVVoQWxsK1ltU2V2QU82SG9hb1V6UDU5cnZZ?=
 =?utf-8?B?V25IcUZJaTN1RzNCYStUL2V5TWZodjBKL3VQc0s1clk5S2RTSnE2amE1Q29q?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p8JihoGbZ2rIAJ8A7+GYudQz5ZkJaH0jczxQ3oJd/OzrpOtFkh5+7sMtJv5UDDlxIpP4wTRFhq01izQ2kRdoPaaaoKQA6jcG0uJ6mklLNo2epLJiBxvYXZplVuBYzRGJ68z3U4nzN3mfwOZcDMThm0v8crnc7xuwY6XmwE+HKqw6M8AFB8TJjwhDNJuv97WFl7s/eSGqWe/0j7KP2p5dZt9Li1cnyFahgYXMQ5uverISpaatCoILb2FgWcNKTCrn/RvlXWrsEYwEwWGFp92/L3oFTVN84xuJqxLtQxWY/zvaj8dtIiYYzey4/pIbsjdVrwKNKWY7gXpOVuwoFUP1BIgXq1TmvT6EQmiim2O8CTiorA9kQXKiI2ZAEsbhKhu1D0B+RF/BIUq5+AjRRbH4y36Q0ZL2pl70dyPwv7iUQryKoTk1o/vljKRSv18zs9udWeGAh9p3cTK+IUPo8dEtTCx4Qv0HWBWqyCWeOxlYwwjMwDbP4EQbeJlJQNWn1H0FDtAOhxDQax6aQeuxxtwnoCOwsiGM6p16BMaCH3WuBGzwJuDJqiVG5lZZebdpjlhdNjzLrL5dHxYSLOsEV/pK+LbuY8laJes/pYtROR420D0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060d335f-3c62-4f7f-84b4-08ddf13bd6c3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:02:26.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCBspgJnh4mjCEcXs8qcm47r0IGYVKTIbfPgho1LBQedfltPRuPCte7Cb0ZCKmtMR6cRzjUgOpe3i+Pkbgi8uNKhY1xxKxP5eG+yDDtYUEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509110122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfX5WQ/aMNxPPA3
 D5yZDIIljbrNY3Lm+d3Mi8zFTFGL8W0BV7i9zoyD7s9Qol6hFjHHNrWh2IOgzfcC/uwglIaUtzd
 JL1D1sKuKtpc1vI6BPRSa07zUbYS7nI3mUD+d7SqHYT+QREIZ7grIGFpIaY+A+QdvHfNIwqSKCw
 DfoyVpvMaiKud+TTFttA4VOCj7FP6LLlrydegPGbsZMZ6YD/JD03w8Qs+tGQTVTvHccIkhPNYdn
 F6Zq0Bg+WsJ+fslGeH3Lm9tn5cLcNxtWHX2QEe3c+ua0UBegZz+h/AdH3p6B5QAQ/tdqqpfW+O1
 iW90ICdeG/KL8rClDcZXbWSgQZZzICvcQh+ttgmFnjCrK9l+kPHCTCiYG1/Q2mbo3eFwvUMzlx3
 aKbOmRfx
X-Proofpoint-GUID: Z2_8gEAUz22flrUh0RC1vkeJg-XaiF9e
X-Proofpoint-ORIG-GUID: Z2_8gEAUz22flrUh0RC1vkeJg-XaiF9e
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c2d676 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=QddfXU3uLV_SUP7Oz_wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On Wed, Sep 10, 2025 at 08:42:37PM +0800, Lance Yang wrote:
> Hey Yafang,
>
> On Wed, Sep 10, 2025 at 10:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
> > THP tuning. It includes a hook bpf_hook_thp_get_order(), allowing BPF
> > programs to influence THP order selection based on factors such as:
> > - Workload identity
> >   For example, workloads running in specific containers or cgroups.
> > - Allocation context
> >   Whether the allocation occurs during a page fault, khugepaged, swap or
> >   other paths.
> > - VMA's memory advice settings
> >   MADV_HUGEPAGE or MADV_NOHUGEPAGE
> > - Memory pressure
> >   PSI system data or associated cgroup PSI metrics
> >
> > The kernel API of this new BPF hook is as follows,
> >
> > /**
> >  * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
> >  * @vma: vm_area_struct associated with the THP allocation
> >  * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
> >  *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
> >  *            neither is set.
> >  * @tva_type: TVA type for current @vma
> >  * @orders: Bitmask of requested THP orders for this allocation
> >  *          - PMD-mapped allocation if PMD_ORDER is set
> >  *          - mTHP allocation otherwise
> >  *
> >  * Return: The suggested THP order from the BPF program for allocation. It will
> >  *         not exceed the highest requested order in @orders. Return -1 to
> >  *         indicate that the original requested @orders should remain unchanged.
> >  */
> > typedef int thp_order_fn_t(struct vm_area_struct *vma,
> >                            enum bpf_thp_vma_type vma_type,
> >                            enum tva_type tva_type,
> >                            unsigned long orders);
> >
> > Only a single BPF program can be attached at any given time, though it can
> > be dynamically updated to adjust the policy. The implementation supports
> > anonymous THP, shmem THP, and mTHP, with future extensions planned for
> > file-backed THP.
> >
> > This functionality is only active when system-wide THP is configured to
> > madvise or always mode. It remains disabled in never mode. Additionally,
> > if THP is explicitly disabled for a specific task via prctl(), this BPF
> > functionality will also be unavailable for that task.
> >
> > This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) to be
> > enabled. Note that this capability is currently unstable and may undergo
> > significant changes—including potential removal—in future kernel versions.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> [...]
> > diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> > new file mode 100644
> > index 000000000000..525ee22ab598
> > --- /dev/null
> > +++ b/mm/huge_memory_bpf.c
> > @@ -0,0 +1,243 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * BPF-based THP policy management
> > + *
> > + * Author: Yafang Shao <laoar.shao@gmail.com>
> > + */
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/btf.h>
> > +#include <linux/huge_mm.h>
> > +#include <linux/khugepaged.h>
> > +
> > +enum bpf_thp_vma_type {
> > +       BPF_THP_VM_NONE = 0,
> > +       BPF_THP_VM_HUGEPAGE,    /* VM_HUGEPAGE */
> > +       BPF_THP_VM_NOHUGEPAGE,  /* VM_NOHUGEPAGE */
> > +};
> > +
> > +/**
> > + * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
> > + * @vma: vm_area_struct associated with the THP allocation
> > + * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
> > + *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
> > + *            neither is set.
> > + * @tva_type: TVA type for current @vma
> > + * @orders: Bitmask of requested THP orders for this allocation
> > + *          - PMD-mapped allocation if PMD_ORDER is set
> > + *          - mTHP allocation otherwise
> > + *
> > + * Return: The suggested THP order from the BPF program for allocation. It will
> > + *         not exceed the highest requested order in @orders. Return -1 to
> > + *         indicate that the original requested @orders should remain unchanged.
>
> A minor documentation nit: the comment says "Return -1 to indicate that the
> original requested @orders should remain unchanged". It might be slightly
> clearer to say "Return a negative value to fall back to the original
> behavior". This would cover all error codes as well ;)
>
> > + */
> > +typedef int thp_order_fn_t(struct vm_area_struct *vma,
> > +                          enum bpf_thp_vma_type vma_type,
> > +                          enum tva_type tva_type,
> > +                          unsigned long orders);
>
> Sorry if I'm missing some context here since I haven't tracked the whole
> series closely.
>
> Regarding the return value for thp_order_fn_t: right now it returns a
> single int order. I was thinking, what if we let it return an unsigned
> long bitmask of orders instead? This seems like it would be more flexible
> down the road, especially if we get more mTHP sizes to choose from. It
> would also make the API more consistent, as bpf_hook_thp_get_orders()
> itself returns an unsigned long ;)

I think that adds confusion - as in how an order might be chosen from
those. Also we have _received_ a bitmap of available orders - and the intent
here is to select _which one we should use_.

And this is an experimental feature, behind a flag explicitly labelled as
experimental (and thus subject to change) so if we found we needed to change
things in the future we can.

>
> Also, for future extensions, it might be a good idea to add a reserved
> flags argument to the thp_order_fn_t signature.

We don't need to do anything like this, as we are behind an experimental flag
and in no way guarantee that this will be used this way going forwards.
>
> For example thp_order_fn_t(..., unsigned long flags).
>
> This would give us aforward-compatible way to add new semantics later
> without breaking the ABI and needing a v2. We could just require it to be
> 0 for now.

There is no ABI.

I mean again to emphasise, this is an _experimental_ feature not to be relied
upon in production.

>
> Thanks for the great work!
> Lance

Perhaps we need to put a 'EXPERIMENTAL_' prefix on the config flag too to really
bring this home, as it's perhaps not all that clear :)

Cheers, Lorenzo

