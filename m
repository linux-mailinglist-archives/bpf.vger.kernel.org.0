Return-Path: <bpf+bounces-76601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 221BDCBD2F7
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD17D3011180
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9502DA757;
	Mon, 15 Dec 2025 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="I9RE8Eck";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="I9RE8Eck"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD0224234;
	Mon, 15 Dec 2025 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791371; cv=fail; b=SmJXM2cd5bVsQd+SpMaRUQMBH98IvCfP4aorvWZusWFSPZX0Iw81Uc/NrM0XuVXosq6p4MEQvmbCelfvuApWIzJmNCzknyT8YGo5TPrSeT5QCKTsbBDq/wE3DBeHQZlWONqOfInoru7Zx9dgOk9bf8wKkln9ASoqEfosauShT8M=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791371; c=relaxed/simple;
	bh=QSHQxAhMADQ8Lcq/XqZsEh1meodoSWqgjCwK8QyNgLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SNTYPyM3voXqhbsQjRd91kGryQfqJIb5vHvOYgcjgmzmuursmfF2FypZW7PbYsXccEK2Mmog5fVyga84rQW9a216k4qhR65Pn3XRue8Ds8B5rOJEA8FWViEBiOYyd1zScPqDpjjJsyo4phIh0WutywvbneCAgxyK6CIeUxmFePM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=I9RE8Eck; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=I9RE8Eck; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oKJga5MZNPj4jnH58sWpBaI2bxMfZbL0Qc5uatDNfWBP5Zsas8FOhKHtEwSdchdM1dEH42q3diepBhe1Bj6W8Lmy3DXqboInl+mAHmKePyMHeBzTZHRrC1p9ggMZD9AOXVbc9lHOQtO3j2AnMHjWh0vtrhRvIkI5hRKstp+FMSnAB6gcUPBCUHBQtE5YQj+MVsZks1rmEEOCu8o7j33XV1lO2Ha8vpy9+nQg9pgZNFCCKzhejBCOXNFQPrRY6NQi7MhJKxzwYc7bwYir/+1wfZxeiD3Ff9DsAIp7B+KmErmRZnUppQI7FclufazhQyGY8wGk/7PlG7Zmve7ntxkm+w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSHQxAhMADQ8Lcq/XqZsEh1meodoSWqgjCwK8QyNgLQ=;
 b=Rbq0PQGAxLsriyM/J/UwrBM3XRzc702Wh30rlUQHKczeffCT7gMPSkPtgMCmQIRmezaARcH2dzdYhSQq5hmdqmOaTx2RAAZlGn3KK9vEbwPWWNBnCRtRS/s8miuqIt+hXrUCAyv2Hr+Zwvg8mYhsypSEhrrHoPgqIo9bTvSDKbEil0hTFKDWeyeRY+qraA8SCSA7eMsos50v2ozlI8OUwKypgUUWI7QecTdsCBWqkleV8OJ8C6uzLJSVQ458/PvQ3L+H+qkrmsxU6n3RIGTF8KwlGJO5+Mgz6nn5KrfHbLViV1NeIeEEWzmrOiLl0Ce9lsJg4pe0hwZ0W5ZT7esPSw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSHQxAhMADQ8Lcq/XqZsEh1meodoSWqgjCwK8QyNgLQ=;
 b=I9RE8EckoBMABu+4APmggTrK0ARBL7d4bVKVk4B/rsLk7Z3a9YzOge7CRPo+bZ66x9ActtNXVVL4T/R8oda0+goodqtSMe3V7qiLTQrGvcRyUKot0SFrAqD2s5PiZ3JBWiDWLE4k+TBSxZ4NXM4H8Q+O+7IGSR+mIOEuQ6OaidY=
Received: from AM9P250CA0004.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::9)
 by DBAPR08MB5718.eurprd08.prod.outlook.com (2603:10a6:10:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 09:36:01 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:20b:21c:cafe::d3) by AM9P250CA0004.outlook.office365.com
 (2603:10a6:20b:21c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.12 via Frontend Transport; Mon,
 15 Dec 2025 09:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Mon, 15 Dec 2025 09:35:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wb/rDqC9iv5HmsiNKfKTbvPhj5rMOLue2kIOO6XXfyZ5hAvUfwRoc/rq7W6Bi05FZfuh6rYWbKMBCp+cdlxTRZJp7C5BsyP/I+yAoWkyl+0avPrFtPaewnMYywwqVrmEFrlBnZuSPzfZ0VdivTvXfkAoSIxA8eBcdrasF/7dKNDkAsg430L3YjPvhtT77/c4mfU+095LcWXdFyTwAsj7z5qnUUVFgjpSHtBFHQePMBgDrbkay9gawFjDradIDkEQvgCT5Hv6jTfNGtvZ8SjUSf7aTX0Ty0S6a21XLSOBnsJwUQF6xSMzwOB5tGwpunfo3CmNAMDJ4QofUGJ57FzgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSHQxAhMADQ8Lcq/XqZsEh1meodoSWqgjCwK8QyNgLQ=;
 b=yUIIEWCUdR9Fyw1bth9JxB4UKhbD/EILFfCLByQ4AiXrsATzzfp5k0eg8y7n9N4km6LruQGCXUWSuRsX3CASptPkZYzV9rB9Fxk8AQ+mvcz8sBtmJakwN+twvEapVpBnP3bOns/iCB6nTvRucHVy2HWlWL8mxTyWeE1pto+brT+ByttE5rP9IImxw1Rx5qfE421bCCHtfjjZlc2BsqDPp+n7DntGdW6C876OjI6MwftpWUh8siz0tM5YNYWPfltzv4Yb7TVtyzkTKQIm2Q+eL146+fl3T/RuZ53o+WZIx3g4Ja52w6QbrPxNu2fHhA243Eu+F9gnrimZTa6IiNsGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSHQxAhMADQ8Lcq/XqZsEh1meodoSWqgjCwK8QyNgLQ=;
 b=I9RE8EckoBMABu+4APmggTrK0ARBL7d4bVKVk4B/rsLk7Z3a9YzOge7CRPo+bZ66x9ActtNXVVL4T/R8oda0+goodqtSMe3V7qiLTQrGvcRyUKot0SFrAqD2s5PiZ3JBWiDWLE4k+TBSxZ4NXM4H8Q+O+7IGSR+mIOEuQ6OaidY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB9119.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 09:34:52 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 09:34:52 +0000
Date: Mon, 15 Dec 2025 09:34:48 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
	ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org,
	ryan.roberts@arm.com, kevin.brodsky@arm.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while
 stop_machine()
Message-ID: <aT/WOAr4osoJWaMS@e129823.arm.com>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
 <aT5/y3cSGIzi2K+m@e129823.arm.com>
 <DEYOI8H2OESD.1H56D3H8HKILB@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEYOI8H2OESD.1H56D3H8HKILB@google.com>
X-ClientProxiedBy: LO2P265CA0377.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::29) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB9119:EE_|AMS1EPF00000042:EE_|DBAPR08MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 304dc94c-d16d-4c1a-55dd-08de3bbd5ae7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?EmNu7+hUczxXwwrjvLpoNAe+rmCS7GVf/UN+4/iI2efTYeHshVNY0M+GGmat?=
 =?us-ascii?Q?bl53Qdk9NHgV7dmczUMS/UtIDsuziGfsNPY6uN0irniK0zESpFuTTQIRTp1L?=
 =?us-ascii?Q?u3H6RyizstId3bU2zNE562zQfurS7UxosDQ8PktUrvk+oJjOnnh5RBeI+OZ9?=
 =?us-ascii?Q?8sKh0WSFNWEjz6lRwpdySeMIIpVcdvRs5KbnvBDn9r82px8k1832gtOXOTWr?=
 =?us-ascii?Q?Pk+JT33E3yOIWTLeu8tHMgLTDP9n+lffG/NdwwdqZ+xzpfDX+DyV1yAYSR60?=
 =?us-ascii?Q?72Lyjl2Q/o4fVJJW0w3ldnRmCr1+q7vCqYOLA5aR8Sl+PYyHJQEz96imkWgE?=
 =?us-ascii?Q?pW9CaOy40RtmciPJTxVLKRMqVMtrn7FoJHi75H8gfdleRIxdI71iCnpku8O4?=
 =?us-ascii?Q?dZB7dr7f3tHCfETDGiLWrF+3Dtx5bT2DU1zPH5wJYbembG0NGq/jDacbs1Wv?=
 =?us-ascii?Q?NBW82Id8dJ4IfO5CBNuHyT95uco3POFoA5DVKjunO/xP00MaHlLhR1mupGp0?=
 =?us-ascii?Q?0BuBdrkpFzdgN6b7iftJ3GQuymkaJQyuJxk1WnKCkQNx+d3f7lHdtyVzVw3T?=
 =?us-ascii?Q?i77AtwplhdhaLbVJIEx2MZXn6ZS2WOt7RpePKQrLJa45piPa1QFediXylmLT?=
 =?us-ascii?Q?Sz2uRZaDQYct4bg/1wuYzILjnLR83B1xuy12pkkczBgFYRFLa83hz4zdCQAZ?=
 =?us-ascii?Q?Yze/FzTuPfd3j3IH2vWO05oLWsilTSJhNF2PrY+Ay2Rq6Bvr/nNLStY424Wt?=
 =?us-ascii?Q?yiTW0L27ZAPOXss/TEDwFB2DeonGfjc+VqfQddYmJ5Qq4jdn2Zz0br5bRAnm?=
 =?us-ascii?Q?XoOYNGg/4lIWykVyBXLvAPbYCaQATRpd3j0cU2AOgNC2B7ItuYPACwihOAfG?=
 =?us-ascii?Q?cN0UCeyLHrGFidlDhulO2NWK+5ZbN9Id2m/t8BRpXdikCDNv1JJMaxmlBl1C?=
 =?us-ascii?Q?63j8VyH4Y1rCVBzr563ZU8tOFNZaagHBoNX5OAK3/pYhJNHKvhCHI3T8O5m7?=
 =?us-ascii?Q?JAHTQO8Z5WcYa/BdR038/8sZVzc/lz8hJxJBO/mtmJgEmajdxIxinocWt4v6?=
 =?us-ascii?Q?HnX+URh9CA/AnDbjqrxc5Sx+thX3Cd3ZuS6vcbb2nZLf6zpOy6I07bkl61eL?=
 =?us-ascii?Q?N95BhKwAhnnxXvClklYr0YyJRcCenk6N6oW8TW6kNYrVTQdh2Pui2ws7NpDl?=
 =?us-ascii?Q?vaVXstiFZ9b/4T3ee6T5bStxTrJinBoSxUellGkpbOx97apiFxfzD5xMFjRa?=
 =?us-ascii?Q?rJEIoYzuW7Mj4KBjTCgLFNBtzytQpuNdTCTiOZln6irO+smsk4Be7faB6QC+?=
 =?us-ascii?Q?xf5B3fdXE4LpUmGpFZCYd9SKBy4IWd/2PKMUBevpZ4Mqyl8Tt20X1QEdP2gr?=
 =?us-ascii?Q?0KTOV7g2VgHinkLBfkwMhckZt7X8kYSAbZvLiAT1u7TMMYmUgoluN/+lL9dp?=
 =?us-ascii?Q?WJpizH+bfmMh/2syyWBTTk659KwP3c4k?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9119
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1b175031-454c-4a71-6edf-08de3bbd32db
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|14060799003|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DTkJWjX26pfvZ7IEcY/INXF+U/zw0FqzuRs4gUnshaxIUiPDb417PCd5KJNK?=
 =?us-ascii?Q?jSzKWEJxZ+MBWTbhq9A/RUcu4i/MOYYGRrdFihEKvMGSsf3XgmzkLsiHIjq+?=
 =?us-ascii?Q?LjsXnq8wAhTc00qTvPZuVuFCvNeHV+thaMawB5JCXjpfpU7t4RvpMKyfwY75?=
 =?us-ascii?Q?DXYs5Cr0VeRaCjtIE9Q+jEYDNHaHNqObCfGEpV7A8Bs68JUmUHkBjaaQ5jKa?=
 =?us-ascii?Q?GPGtm8oC78F2ntGhSZQyDRN+40tdBuCNEM/9pplqjWlE96w6PSFTJAwnNSwE?=
 =?us-ascii?Q?+Lhpzu2hNeqUm6ui2rKl9hvQFassABTb+Enu4CN7pAiSvAX29B+rtQidZtz4?=
 =?us-ascii?Q?osFirGaVP83r8EP2I40Tmpsp9OZD8OVwK2Jy9dvDDD4j+nzYuBzPc6MB/768?=
 =?us-ascii?Q?XLBTiemyNz6xemrXrKjWfaoDfnVBKOW1ZADcZgoN6kC2QIPp/xatrvG0lqrc?=
 =?us-ascii?Q?z9rn2ovI7Uc3ZtvstQCj3hxpXfOg5Cah0/AR/mQ98ua0RKT/48sRu+puDhDg?=
 =?us-ascii?Q?SUptk0HklZb8vP1rURRJvEgF2S4/3QxN1bWDHTT3vuCLRF7JqoMlgwUEY7ai?=
 =?us-ascii?Q?YA+LC64K3lSqEfI0W3BM/ji+DIW4Nyzc52kn3TWl51FO5WaqjrWSgkkwE9XK?=
 =?us-ascii?Q?sONdE8W9F3je+hbwaR8ueQJlP212GWjwvGuXaytoOFXASUxV30OW7AO3qobm?=
 =?us-ascii?Q?4/RzrYuSRn6NFoLHoEfbCZl2FlxPgQOhGoNCLsfR3R0Yld89MOVBRDOjIpMu?=
 =?us-ascii?Q?sZRHQefoRSnRBv5/MV3bhlRKyrfZVjWKnu6VP/xuSQRMicxW1rcoG8y/3vAR?=
 =?us-ascii?Q?bWjrrL78eMD7vde0HyFbrvp7yHqEiUz4UjdnxILTO0VkG1M4CrQi7mosF+KG?=
 =?us-ascii?Q?d6mtK8HqQtjY3O2IY2IZwIaPuuQ4JQRtzbHuRSK33gSRONk2bK1Ukl8SAEDO?=
 =?us-ascii?Q?qFywsp7TxcTU5jH0Ebe94Tts2YsSZVsESutRO1L6FxOZB/w8Tx+NBcG3b+Dx?=
 =?us-ascii?Q?V8F6fqq+DNKIz5cf+W0hL4EpJA7MJoWe3RwgUGOx6Yumf8gBDHsjpz2tpie8?=
 =?us-ascii?Q?lhTKx/7zje3pJx3YDgxfotBoQBV0dBT2dhBFfODpk2oRiIpcQlerjwsuvyl4?=
 =?us-ascii?Q?SUbYuT3xIlRAc63eOxT+iBfTwnUTgcZeX/Aps2ns7WM5wY71SfCLom96V8fw?=
 =?us-ascii?Q?gcTMWwCH0dxiDub5vklBY2xeDWD1x8jUYFfcNajxOScOMXp8gQSfTse3gar4?=
 =?us-ascii?Q?BYi4GJjqor2gvYOK9vCcE4CbdknfSOmBWnCZWdegrAofUCU3tZbqiGLUzgUw?=
 =?us-ascii?Q?98Rm9bIC/SNEt0LhR1DpfZXoM1X8wEvFgikpjylI5wPgPLHOSTBwrifO0jaC?=
 =?us-ascii?Q?0bzRn30S/lx94xUtobOTsKZ57/Arbs4PXzQHJHAXmdBQ7bfr4VAJ8XFApk6d?=
 =?us-ascii?Q?WzAqmfMyYlEGEMlBAYBBTWAPSGuop7JqvpR1LvNBLI/OP9sqHyedFitjKaPM?=
 =?us-ascii?Q?JrD0hRVnt5cWdEnvF9C66m7GMuN99LHSUKRUQIgIdH4RTCRrC2OPRsjS1dl3?=
 =?us-ascii?Q?2qWfn+YkpJ05YsuqiO0=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(14060799003)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 09:35:59.2683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 304dc94c-d16d-4c1a-55dd-08de3bbd5ae7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5718

Hi Brendan,
> On Sun Dec 14, 2025 at 9:13 AM UTC, Yeoreum Yun wrote:
> >> I don't have the context on what this code is doing so take this with
> >> a grain of salt, but...
> >>
> >> The point of the _nolock alloc is to give the allocator an excuse to
> >> fail. Panicking on that failure doesn't seem like a great idea to me?
> >
> > I thought first whether it changes to "static" memory area to handle
> > this in PREEMPT_RT.
> > But since this function is called while smp_cpus_done().
> > So, I think it's fine since there wouldn't be a contention for
> > memory allocation in this phase.
>
> Then shouldn't it use _nolock unconditionally?

As you pointed out, I think it should be fine even in the !PREEMPT_RT case.
However, in case I missed something or if my understanding is incorrect,
I applied it only to the PREEMPT_RT case for now.

--
Sincerely,
Yeoreum Yun

