Return-Path: <bpf+bounces-68237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2814FB54CE0
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 14:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F915A6943
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5AB3064AE;
	Fri, 12 Sep 2025 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R9/g0cgf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pyhv1VGG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BDF3064A5;
	Fri, 12 Sep 2025 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678560; cv=fail; b=W17+lk3jotBto3RFEuGCkK/FFETeUiv4+fHx446pzxAkpOPYQrSMEWgXsepKzugAa5hsFZkocRkq9eFvwFdF0OdP0c+Egzkq7ovg5nVm5Vqd4ACwn3UIeioyt5I/6gtWPEP13z6jmiXzArfiyeu6tZvDy/3CckxS8GIJQMO8AEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678560; c=relaxed/simple;
	bh=9vzKf0pybkMvzCUAiv//AQzhw7tT0RnK5i9tUvfcRIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fgcbh8GSfcjmKwIg6tFPtiZ+qMdbyY1WP10wPVjuLRiCFZW8my7HxYKZGc5DWkMaM1Cvw1IsjPCLmTNBWHL94PqAvabrVyS6jzVE72bsI+pEp2RNYIAh7+6VBOsf0zoApuUdmugjAPDXcOv+oPQ/waWtW1Q3QzFDjy/1+Z6Mvuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R9/g0cgf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pyhv1VGG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1uRo5009874;
	Fri, 12 Sep 2025 12:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PMXhNGCFqPuet+8EYtwfNwjm2HyA3ugy6+unZWK9Uek=; b=
	R9/g0cgfcOOOKl+ZJ0Qwke2SGYl5UO/fqtc88I6degfCpzjwcYbyw6cyzc9gt/jb
	uskvObkanpBGmw8/vDLn0IySnhMXREghljq0tewCIYxBsg52u1pf7vp5AXo/5+h5
	+xvutZ/V87gcfVf69wCMVThmIUklroLet3z8qYD1HRFkQyywEhRDFfes4aqeq00T
	kk591Yv6iijBiUfedqr5HTRLDWYdV+AIjoh0g8QLwBEHlyYyDx3cFRgu6tbL7BV2
	bi9YXljahDOYCPFcXc3fYUiLp0c9PCoQ+c7BtBrPhI3iDBXiUu5PaaCea85gzV41
	A9xWe+xue0i669m6n1bMYg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1r6wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 12:00:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CB4QII038916;
	Fri, 12 Sep 2025 12:00:40 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bddsjc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 12:00:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clQudjOYVMrHS/dQCjrYww7duCz+uXhVMYiwZ2Vgub+lQo+cTAr75MDEJOoE2ekvTp6Z+TvSpOpX5RoOdav8DV1VlLLI/GXJ+Cu+BByONY5JmsbiMzy1/7rR/AnjGktMCB8ZrOL0E083QrNEAIirtkFaMaQdsJg28lBTikYJA20Rhy5XO7C/EaaWcuVyVTihZxkVWy1TFD5J/v/Hu1Ku63fpqPfr/tKdzrC6k5N3q930Ku/zHZiqlohXAPq6GEjaYDNrLFrf1AHpUh+J1kPFC8iN6mkUdQXImyXOAlEXmmhmVN7pFU6bXWtYroWBzCXSJWt7rRimTazRXDLJeOwTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMXhNGCFqPuet+8EYtwfNwjm2HyA3ugy6+unZWK9Uek=;
 b=DtCYpCC49oqG5qw2fQDmZrTaS0ipxbcUdPgbI/72IqD70wmlJMvIK8UmosMFQqqs+UGAChZbzeuMU3S+8/Sh62Gs6aWODDpMu35juwXwGGfjm/3z73ueCBonh7cc9eJ1xmwBKNA8NFt6nNEyc382aszN10wWvLrGIHavgC1gbwFTbkR/nQ96ZuUpZrhi0D17ae5c2PtcYpUZ74EmfsTwBFaciMGM+WJ7mmhh/5D7fLdaAQngGVr31BUxY4cxSn8S0mneEyVzbeJ6bpUKDCG/s0+Zlq1JjpzNZ8S+7/J92w07yL/ZToTj5tpaIwbaDvkTKmHoVfAm9tgWIliTwP8RyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMXhNGCFqPuet+8EYtwfNwjm2HyA3ugy6+unZWK9Uek=;
 b=pyhv1VGGhqL/Rp0gbqUOaI0aboaJHDbvBVrIKZiwWRHOWue59n2BPBtOoByq5HE5PL1F5+LR6qAWd6paQ9n4AAaqhIEHlLipYhyi7aiKl+XWz4waXahcKWk6C8hSpK3mMfnrp/aZuXoVLPqSq0A3TPRgDvSj9JAXs/SCJNpM+Dg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 12:00:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 12:00:36 +0000
Date: Fri, 12 Sep 2025 13:00:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <aa6f9148-72ab-45e8-aa32-7ec8786510e2@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-3-laoar.shao@gmail.com>
 <c7cc3203-502e-4cdb-ade0-25fb9381d0f4@lucifer.local>
 <CALOAHbDYv5wCj=s3KPWa4DOPhhHLA7Mx8UiHUD3T_bfFQiWmhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDYv5wCj=s3KPWa4DOPhhHLA7Mx8UiHUD3T_bfFQiWmhw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0400.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW5PR10MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ddc35c-8e87-406f-d001-08ddf1f3fbbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K296Z3RBREtseHJKdHkzT25TZ2xxb1ZGWkpGWWJ6NjlZNjFJcEpYbjUyY3Bx?=
 =?utf-8?B?bHpBSWhkc1llWHRxWTE4a2RrM0RnV0hwNHhIdVRLM2VLMTVBUlZxQjF1NktN?=
 =?utf-8?B?ZnVFc1plU2RHNkhid3RWNlM0dEJRYTlLYkdGMXpTLzBnUEZwRlFHU0NuYUIv?=
 =?utf-8?B?Q0JFU2hLNFZNMWZwYVdjZWQ5Tmc1WUpPYXVYNTFSTVdxUlhPU3k0UzVYYjZy?=
 =?utf-8?B?ZG5LbzQwZDFZQ2tsV0dUTkV4WDNWTzd0ZVNiTzJPam53T2lNd2dFM01LZWd2?=
 =?utf-8?B?Z0NCNkhMcEpEQ2VqdVpBdTVNMGV4KzVJTUFYaEVwMVZleVFBTklZWDMyelQ2?=
 =?utf-8?B?VEQ0ZWZEckY5djZhQTFrS3Nqd1ZuZ2lSNm1VYkwxRXBZM2RjRG9sR1AwcDFl?=
 =?utf-8?B?V3ZEOHJzQWNCbS9maWpmMnM3bCtCOFlWT2F0M3ZuaFMyMlNuQ3hqbFhWcTlD?=
 =?utf-8?B?ejRlZWRiRW02WitCalV5Q1diaFRjSEswTDNkeUtSRGUxUGxYbXBYbHUxRE0r?=
 =?utf-8?B?dGZBZG1iRDduTUhsMVFuM05OSWdRV0lBNHQvT2l2c2ZKVzdqcEZxZDArUVdx?=
 =?utf-8?B?alBmVFZQU3dvaGswWnozZlp2VFpUVTFCclpmbHpRT0wwdUdncVFFYTBSM0xy?=
 =?utf-8?B?TnhPQXV1dUh2c01OTmtKaDNtUWEybG14bkJZeVFPdk41RTJ2QS9wb1ozak9X?=
 =?utf-8?B?R1BQRUZnek9qWHk5cW1kOHZVdC96NWJ5UmNoUHVpSU5VK1hYMW92S3ZXKzdD?=
 =?utf-8?B?SDBQQzdRa1dFSUFRcTJwVWpnYWd0UjBrMDNqdDdSL0EwaVVDaVVjcmlJdHVV?=
 =?utf-8?B?RXBqeVVQYm9iNWJhcktFakwxR00yTXZrTzdkelBVekI2VmViUkIwYmZTTE16?=
 =?utf-8?B?Qk9iMzlaL2RBcVY5YWovVlV5eEp3UkZ6aW1zMS9EYU0yVTlWY3NpcldJM1Vu?=
 =?utf-8?B?MGk3NXRKRTRCWE8wb21IVlBIZHJhZVpWTXB3R0hWWEhrUUNFUGNHcTA1anJv?=
 =?utf-8?B?cDBNVlovRk1ZZ2ZPckhaOFhzVE8zbzYvWG9CTlMzcVR3UmZpQ1lkc21nV2pn?=
 =?utf-8?B?aUMxQUFrMUpCNXV0WG1FOTRpellIZW14eHN6WUpkWk5FTE9ZaFFpbG1rTTl5?=
 =?utf-8?B?bWJJTFdYc1hOUVF1cmRvRkc4Wk5ITkZBMGJEVkZ0cEFZaXJnN2NPK2tZZkNE?=
 =?utf-8?B?cTVUWEVMbUtHMVNxL3RoMmlQWCtqU3V1Yy8zSzUwRW9OYkY1ekhETmh2a0VG?=
 =?utf-8?B?RXVOMzhTcU45Wkc3NTZJakIwUXhYdnpERWcrUjk5NUlqL3QxUmNwZGRuK2lo?=
 =?utf-8?B?Y2FhMDVWZjRwb0hZdk0zc2xrdEVMS3NieWo4OFRyb2N0WDFkTDdleTZGaWtp?=
 =?utf-8?B?Q0g2Q2hsaDZKTktkbXpSU0llMXAwUG1nUDJ2RGhkQmlxNk5TUzVkeGtYdmV1?=
 =?utf-8?B?V3Y5alZkbG1OUEJITlVKeThKN2pYbktuQ3JrVk1FbW1YNlc3SVJiN3hoaU5U?=
 =?utf-8?B?SHhSSVVvcWFMKzN4SVZtOXlGdDAwY0hSUjZLWHJ0TEsrN25xZ1RmUG1pdE9y?=
 =?utf-8?B?ZkFZN0VXVTFFbFRObTZmdmtwNkwrZVk4azFSY1BvdXNnUGV2elJ1bnNkVFo1?=
 =?utf-8?B?L2tNbUR4ZVByUXd0ZXE2YXRVMGxleUEvZFM2NFI3T1lpUTlPQlVHTHAwTHg5?=
 =?utf-8?B?b0hSRW1KT2ROWmwzdkp6bW44MlBZTUtBWEpZSFdWdVBTc0NCMjFvWkUyYXFW?=
 =?utf-8?B?d0pGYzJ0dlA1a3lDdC83TWRPMkJaZVkzWitSNW1GNEk1d20wQXdpb0FmaTN6?=
 =?utf-8?B?TzYwYngzUzh6ZmhxSW84VHQ4T3EzTitRY28wZUdpekVHYlFrTUx2Z3JibUxY?=
 =?utf-8?B?d3Bkak02MDNGQmJNQVc3M0FGa24weWtST1pPUFVYalBsYmhsMHVzZnhUQUUr?=
 =?utf-8?Q?Zs7K33YRwRc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2NUQTd3Zlk0Um5UTVUrb2trMzJQL29xNjJGZ3R6VHloLzdRL0lNUmViWVZS?=
 =?utf-8?B?RTJpRjlaTFQ5dW1tU2xBS3loVlNXN0hWdlVDQXhJMmJTRyt0TFB0TnUwaHdw?=
 =?utf-8?B?RU1DSXcwUzNRcklCRVdNWkgrVHIwVmZKVTN4cVFqREpHa2JmUEt1MUUrZlUz?=
 =?utf-8?B?R0luMW16R0E4U3lMa0pMV2w3bktmYVMwZGo4K1VsTzg5NS9XV0J1Qkd3Vk1y?=
 =?utf-8?B?MzlUUXhjbGgxalRQWHZiS0dyanlDdUU5K3ZvcHl4TWVRdFI1NllNNUR0Q2Iz?=
 =?utf-8?B?ZTFYVFhHL2Vud0YyWk9WUGw4aFRoY1V0Y2NRU2Raek1RdEFDM01mRHAvREZn?=
 =?utf-8?B?RWxmZ0MvMGxNSFV3SFZtd2NVMmk2VmJ4dFI2NXhqemxvRk5VelFJQ3ZIRC9q?=
 =?utf-8?B?WjFjcU8xWk9ScUdrY2x5UW5RQlhDVHJMK0hieW9VZ0l0c1k5NmhlR05iUU8v?=
 =?utf-8?B?RGphMGRmYm5Gei81WkpmY1M3cEhRWFhWRlRkUEd6RERGVzRmUFBjVy9zR3JY?=
 =?utf-8?B?M0pmZmFBK3VGVHVodTBoaURyY1czTy80dkJWQlFRdm9QbWsyUTBrbkU1MnNs?=
 =?utf-8?B?NVQxQWs5Y1FYbkxldFBEREJMQmNETGM1QXBGUkFUV3BleGIzRVZRb3BqS05y?=
 =?utf-8?B?TkMwTFF6RGsraHJBUGsyU2pia3lpTWFadEpaZURYN2VLK0JtWncwRUh1ZTZj?=
 =?utf-8?B?NDlwcTVNNTZJQjhMdGdjdjFpSjBpU3JTRUxiSzZNaVlWWStQYjJHUlZJMjRF?=
 =?utf-8?B?dCs4K25yaUVtSk11YmdwUGJPWmg1VWg2cGdMTW9vdmdMZnF0SUlhY0taVVRT?=
 =?utf-8?B?a3ErT1l3RWVHQk1FV2tsYWtQdTlyMVlldXRRM0lIU0VnT0o1cDd1UGJ0eDQ0?=
 =?utf-8?B?aUxKWExpZXVod2hKcitXTlE2TGQrRFlsejRJREpjTjlUTTZwQXlsZmdqUFI2?=
 =?utf-8?B?ZjNvWUhrU1NGeVF0SUYyRDFkNnJYWGRXWUxFM3V0ZENIU3VXUXluVUx1TWhj?=
 =?utf-8?B?UHNJWkx0ekdmM08vZTc0L1BTQzE3SXpnZzBnWjQ5TjlFRkllSUZqd3Y0Q1Uz?=
 =?utf-8?B?bjYxb2dxU0lGeVoyM3FWRGpYVlVDS1BOVkpBYVEyR0JsK0NEN1RzOFJLSTA2?=
 =?utf-8?B?RHV6aVNtZWt4Z2t5MU9lY2ptQ0VUUFl6aEVmQmZTamxyZjAyLzNjWlh0V2xR?=
 =?utf-8?B?UmxwdFZHd00zQXVnQlprWFp3ZW5DWjJMMWx2ZEk0a3EvaldDUDczUFltK0xy?=
 =?utf-8?B?eVNLS3pweElqYW9ZWmpmL01VZ1psOXp0L0diWE90RzNBN2xPaVZuakRKYW5M?=
 =?utf-8?B?eU9uRXYyWEVYeVBhU1lLRHNFK2twd1M1b1VFZ2JDSGRMQ2NtZmU1NE8vRk10?=
 =?utf-8?B?bEk0WFJ6YUcrNmhYb1hCbm9pSlJHRjExNHJEVmc0bEduUjduQXhJQXhFUTF3?=
 =?utf-8?B?MFZGc1lRc2VUQ1d0anF6TU9sQmY0S0UwMGN0aVNVSXJMUy8yV0hNdXlkclNq?=
 =?utf-8?B?T1RDTW9rZ3gwbDlXWkVGSjNCa3hCcytnTVVoOHlnMGFSREhsSzl2SnBSKzEv?=
 =?utf-8?B?M2xBQ1U1OWNGdnI3NTZ6eGdiT2NWTkExWU41R1lCd21aS1lsaUFmTzdvRzVU?=
 =?utf-8?B?d0FLVWVOQ3VRNDhmeDJzU0RpaTN4ZkpHVk1yTWZocmhJam5RNy9BVEpIYzhB?=
 =?utf-8?B?VXNaMnNhUmYyM0I5cmsyRUNxM1BwMzZ2aUN6aXAvVzZwNVZQRnFqbDdNMFRt?=
 =?utf-8?B?N0owaVhUcy9vQXhJZHVkWDBIdHo1STRiWkhwc01BU2tpaXF6U2JlVHlEZTRM?=
 =?utf-8?B?L21pZ2FhS1I1TWlKN1d3NC9GbURHM0hNQTZ6bk4wMmlmUzhmMUF2MFZRZGFT?=
 =?utf-8?B?LzJ2RkkrVmhCNFNFVGszbFlZc0VKTlFITlBGbDNxNWIvTGw1QUtkckdkMFFT?=
 =?utf-8?B?aHB0c0hSZTBaSk1ycEFHdzFUb2pBaVFOQjZhclRKNG5CR1MvVUlxSjBXdmx4?=
 =?utf-8?B?WWdqaE9oVUp2WW05TmpReXNSNitsbFZSNXI0VjdCcDVGWFFxK3d1L21ZenI0?=
 =?utf-8?B?WnpvNmRla0hhOU1hRnhOMC93UzZSVGJRK3BHa2kvYllRd0dmYXR3YkxudlYy?=
 =?utf-8?B?c1JUKzc1OGdyMTNaQkdlNHV2ZGNlaERxc0dTSjNSb0dhckZBMkpBeHdKVXNN?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2CUa3LB1FVOXpMRzq81X7oaNy9QesS+iXeC7cbopY+Cej5R+LNNVdh2BQRh+hHjB8zaU7ZarOGr6yXoibTo2/eznU8TwxQvLDCTb3OZrkkw+hgHWz8wXcImWJZzsfEM62dRP7blneFeMOjXrQolfLmva07B1PaDr4TToIcmrfAMGwP7WafaSnLLyvZ3Q688maZEPWALi8QhTNpJd21AK674HO4JGsC6xj865cyjx48disKaQyhzJpQsQQtdpk3O54Jwbl6y6VoQJbEf1cRRR4HsDTc92X3MHUwwNe8rh6Wa7YfQYar4hE80lfzei6QN2aHE0oUf2RdveLZJFjUy66JYHYLE0yLtr5HD6WKErrM2R+773z45g21hHqusV8b9e/s1Bhm3qvgwOV1vf65aONpKTuAO120JfzpbVIp5QvFwY0S3OXGZZ69u2le+nAnCeaM6XqLQrGZhKWnb/riTEz5Ilw+Vhplx2ovaEMIOrQAwCrTCkZgWYjjmVb10Glr16yWagnu+v+XpdwX80nauKnZx8a2NQ7maaLkc65PGD7KGxuOgfQl77V4SsTR6+O2yA2UM4R/oNo0eMGMeYUZsXzZA2n9RnPkFG+Qc8N9Psfds=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ddc35c-8e87-406f-d001-08ddf1f3fbbb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 12:00:35.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvVzxj3GWJsxrSnEjLn+dNT5AIpX+wPIPwo3jOVUBx5mdBB7y8h/4aPOfLVmYECD9ZjTQBu+cIgBvhBy/vxHUCVOPx3Yz/syrv6X2rHuR6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120113
X-Proofpoint-ORIG-GUID: CYPcUtABHCA0pHgkzcGDwhzwCZZE7Uh2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfXy3tHAhW4sq+L
 0SVm2rKIGuB4cp0+LzhhsbQ38CUn+fcKvT4BIDDhAspi+9Nxz2DKwRqL4T619TG0Yne1EN0KsJ2
 8GRyWgw0JlOSKOEWYs42Oqw7WTMws3qg1du/TT7GBUesE577DbnnskboPbkeLtdmwLYLskFj6nh
 Q7kLChn4TSS7oLt1e2yIJCjamOFeBsRkWf6TIo7PDmB3P5KERPCQX7pLTZF7YXmtpWR1lEahVz1
 KPe4QpmWUVvHfRrRmI5gfzTA87o3HEghj7UrUXCfs6P+wUJkT6vvcRfPK8QcNM2uGuG7lNs3AB4
 hbkxrQ6kw8Gz13yg+wOkLakylHQWTvlOc4eiMmkpOMbIDYi8JR1D5I3qWAdyOX5LtnyLiZ+yq7Z
 ZvvpkSu4I20QAMWPi3PTOHQolAKXnQ==
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c40b6a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=WU2qi9uTAlSmPLVz4oUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: CYPcUtABHCA0pHgkzcGDwhzwCZZE7Uh2

On Fri, Sep 12, 2025 at 04:03:32PM +0800, Yafang Shao wrote:
> On Thu, Sep 11, 2025 at 10:51 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Sep 10, 2025 at 10:44:39AM +0800, Yafang Shao wrote:
> > > diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> > > new file mode 100644
> > > index 000000000000..525ee22ab598
> > > --- /dev/null
> > > +++ b/mm/huge_memory_bpf.c
> >
> > [snip]
> >
> > > +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> > > +                                   vm_flags_t vma_flags,
> > > +                                   enum tva_type tva_type,
> > > +                                   unsigned long orders)
> > > +{
> > > +     thp_order_fn_t *bpf_hook_thp_get_order;
> > > +     unsigned long thp_orders = orders;
> > > +     enum bpf_thp_vma_type vma_type;
> > > +     int thp_order;
> > > +
> > > +     /* No BPF program is attached */
> > > +     if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > > +                   &transparent_hugepage_flags))
> > > +             return orders;
> > > +
> > > +     if (vma_flags & VM_HUGEPAGE)
> > > +             vma_type = BPF_THP_VM_HUGEPAGE;
> > > +     else if (vma_flags & VM_NOHUGEPAGE)
> > > +             vma_type = BPF_THP_VM_NOHUGEPAGE;
> > > +     else
> > > +             vma_type = BPF_THP_VM_NONE;
> > > +
> > > +     rcu_read_lock();
> > > +     bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
> > > +     if (!bpf_hook_thp_get_order)
> > > +             goto out;
> > > +
> > > +     thp_order = bpf_hook_thp_get_order(vma, vma_type, tva_type, orders);
> > > +     if (thp_order < 0)
> > > +             goto out;
> > > +     /*
> > > +      * The maximum requested order is determined by the callsite. E.g.:
> > > +      * - PMD-mapped THP uses PMD_ORDER
> > > +      * - mTHP uses (PMD_ORDER - 1)
> > > +      *
> > > +      * We must respect this upper bound to avoid undefined behavior. So the
> > > +      * highest suggested order can't exceed the highest requested order.
> > > +      */
> > > +     if (thp_order <= highest_order(orders))
> > > +             thp_orders = BIT(thp_order);
> >
> > OK so looking at Lance's reply re: setting 0 and what we're doing here in
> > general - this seems a bit weird to me.
> >
> > Shouldn't orders be specifying a _mask_ as to which orders are _available_,
> > rather than allowing a user to specify an arbitrary order?
> >
> > So if you're a position where the only possible order is PMD sized, now this
> > would let you arbitrarily select an mTHP right? That does no seem correct.
> >
> > And as per Lance, if we cannot satisfy the requested order, we shouldn't fall
> > back to available orders, we should take that as a signal that we cannot have
> > THP at all.
> >
> > So shouldn't this just be:
> >
> >         thp_orders = orders & BIT(thp_order);
>
> That's better.  I will change it.

Great I agree (obviously :P)

Thanks!

>
> --
> Regards
> Yafang

Cheers, Lorenzo

