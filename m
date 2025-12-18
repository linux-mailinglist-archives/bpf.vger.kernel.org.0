Return-Path: <bpf+bounces-76968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C609CCB38C
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 10:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C503016DE4
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 09:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C643314B6;
	Thu, 18 Dec 2025 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bJs9AxP3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bJs9AxP3"
X-Original-To: bpf@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309353314A1;
	Thu, 18 Dec 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050645; cv=fail; b=ULv8qx7d0Oxz/VlDhVV0sZoNNz3hhL+FjXEeId0HuSw9ecq5OjL9by7OGuuCGVqC72zPdiLsdtMmrfyewbNrbTYy2vXL5iqKV5GfirrsWQs/rniTc74/xZBGco4mJ181b/Oh2dm0knCq3Z/lMfAFyzO4xBS9UTRVN1nmmbLaeKM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050645; c=relaxed/simple;
	bh=Rc9RsHmXLp7J2E9Jmd1OLs5+LUDFCtN3KxnidYNxNaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ALUdmMX/7zGe+X1nRsMEtNsrq8oBB6paMpuS9Ksg+GhSvfIcVJs26Pq6zpXlXAkcjUDwAuK/a6NQ7NYD5WabL1xv4sYutDcl/UzUklW74H9lS2AJtdQDBVFXRMSTkEAHDMq5MvSkUCxW+myo69/a4ZiumY29Zw2AjNapY2lo9Zk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bJs9AxP3; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bJs9AxP3; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=V7/xdQWJVhGESUFHCbauBa1myd72g5mhAi34Wid9MPnIfiTUGImn2dLFKQCtBQvi0rooxPIhWNuamWe5QJOkxo6+HJOdFO344oxOB0lT05zP7qNNNcm4u7wWBUtfXfF5/xiSl71MfypEgi9GyDxPM2MFTvKUMBvAIFEAOZD3z0H2aQW9fJfj0kMajLd0MOkznMPjKHJOOG7DRdwM47pEBsPh4Qsi+Yc2i/04zvX46QzCnvEseJy1tMS8ksf2lFefS1HD2quqMEM+jxwcJFv8gdRwlYiECUAoUfQvx5aAqoSEsHmo0Yt91CvYiHncfUK/US3fatvmAMiBky+7Y01cSQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rc9RsHmXLp7J2E9Jmd1OLs5+LUDFCtN3KxnidYNxNaM=;
 b=PBj7ailWGvaudbW5aBi7YecT0tbVm7palvdL0n3rOnZiZM6ZOpiE+m+ML3nf9csNLtXsIb2bXzj+yteesDdunZcyC6xMKYqZPpXGbDES4akEXxzBekBmnxMnFrTCwn75QVvwPn2VXaUPaJ9awvQzNb4nAukNVeRbp8GVTaiLoQo2clffKkWb+0nd19J21CR6MVPhg/v26srvMCdOuHnYCnvX9mpZ+H4y3rAe114svqQq6V76tAqSHQA3oywju0B09I4koQKLTRXxm8H/DAA6pvKyqju0mQcwbaD0nWkUo8XNX6iZAS3iWI9luh4OcKjCQleGT3epO3DQnNOnBQmnvw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=suse.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc9RsHmXLp7J2E9Jmd1OLs5+LUDFCtN3KxnidYNxNaM=;
 b=bJs9AxP33SqBNnHXVz33iDulibsfB3wzyKUndvWt6EHmnBnPd0D30UhDMxB8Fv3ufWMXm1VF8OrkcV6zoYzzQ7yq9qfVx/6pxy9j0F9QcsK5cKl9By/E1+H12OIbnPgQUJxm93jm8Fi+T4JcEpjVMYG6b6wLBi/tBYmgnEvt5Us=
Received: from AS4P195CA0039.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::15)
 by DU0PR08MB9510.eurprd08.prod.outlook.com (2603:10a6:10:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 09:37:16 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::e) by AS4P195CA0039.outlook.office365.com
 (2603:10a6:20b:65a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 09:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Thu, 18 Dec 2025 09:37:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEnIHDg/ApnTzByna+jEhGlmYdL5EGntl2BXA3n/MvjIjqMpysZauO3+hXEIyXL0m//P5vC+THWaE49lq1B9goZtg3MgdW0dd+nv+QuED4/1sUMDi0e+TKM1eg4M9n/6rbeIT2CcOaxl/KyaYO79CAPArLa9cXQj6OQyIEkX2d6zxK6Wg7cNR+++TT93kY0LFzLMXUIqNsyYu2uG+TdyEIIm7HSK8QOlOXOcC8CnNvzWHWmhxksBPzwh0zvRAF8yvh9SMX8Z2e+S/T3OVt9jX84c0WbMDdALsD8snL0VC6aTgD2Z6s1MbZ1zzxX8X1WbigV0GXMWs/HfxCrZP2q2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rc9RsHmXLp7J2E9Jmd1OLs5+LUDFCtN3KxnidYNxNaM=;
 b=Mus2mz0NEQQg1U+BIpRfFYXhCpSfyKtMSXRdI/+lufWCzLZim0nAx+IZYylJdQJThww/8xJOD9QN36UzBpGEbcS0KOjocUWRtU8QUU6Jr1T+PsEFQT9QlZFpL9cVDcSM9Jug77rXGTsuToObKwXug5Ede8vWBQV0RT04GwARguHu/Y7U0AlBnUzjVqTsjyyF5JopIgZl2oi9MgcNmE672zI4lNgOviaRHF0+9/ixfBmq4aczOqzD34P9k4+l6S0q7aEXIt0axhC0dcWWcO/N3hA2Vwb8C1XQD74PxbWup5BsIA57FyHkjoD/tjKLBzFTKw/w+kXL9X0a+Wo2C+GDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc9RsHmXLp7J2E9Jmd1OLs5+LUDFCtN3KxnidYNxNaM=;
 b=bJs9AxP33SqBNnHXVz33iDulibsfB3wzyKUndvWt6EHmnBnPd0D30UhDMxB8Fv3ufWMXm1VF8OrkcV6zoYzzQ7yq9qfVx/6pxy9j0F9QcsK5cKl9By/E1+H12OIbnPgQUJxm93jm8Fi+T4JcEpjVMYG6b6wLBi/tBYmgnEvt5Us=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM7PR08MB5319.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 09:36:12 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 09:36:11 +0000
Date: Thu, 18 Dec 2025 09:36:08 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org,
	ryan.roberts@arm.com, kevin.brodsky@arm.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while
 stop_machine()
Message-ID: <aUPLCPAyxkPeBaoD@e129823.arm.com>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <aUPJuZINNuNxddRX@tiehlicka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUPJuZINNuNxddRX@tiehlicka>
X-ClientProxiedBy: LO4P123CA0514.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::21) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM7PR08MB5319:EE_|AM3PEPF0000A796:EE_|DU0PR08MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0e470d-b78b-4116-ec62-08de3e190793
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?FD9c7HPXgTst84GI9s7Mxq+lRzgyGu1vkGn9t1EVKIvcfo4y7hkJnNvS0vnP?=
 =?us-ascii?Q?W3GpJf+oG28mez2QPyrrlBvVGEXRTaVHKq22YMujE7hCvvzbr+pah2lc/ypI?=
 =?us-ascii?Q?k9MoQ5T3ji8hGb1j62IPG7VHYcbTswJ7EDyuY9R76e/mwnYWqqaSdEE4jrcR?=
 =?us-ascii?Q?QUzy7W1Ek9LiZ55EI5v1M4gfXMlOgWKJdsCA22KheZxOpYDmVD9b4ZssA8Nx?=
 =?us-ascii?Q?zF5BAllIH+Apsq6KgwrYqExElm3xyi7laa+oeGDauMZ9aLYNnCZkzD4j+BtH?=
 =?us-ascii?Q?UTB634bfvkB37fHleRlDe+CqVd5ThhNozey7HvEhyvr3jXREgEmVGhqeGr63?=
 =?us-ascii?Q?qjPy2qw1YpScKDUDsaLwSS5pkla/Enq34qZMCOJ1EAVl+84OghfSsA44XiBW?=
 =?us-ascii?Q?w3ixiIIj1pxzvwVhRah82s3jRXyLZtl8eU8zIottuITm+ZiCx+yvPlIuk3Ss?=
 =?us-ascii?Q?GKKssjep/urieXMlkW144TkNNRfyvEjNnV6y+qey/tUUReIv8BMQtnXMbwIj?=
 =?us-ascii?Q?SzpV/gPV48XYduJ7EDWQ7WZGC+CS2pNuq5sYkgdchvNNSv1pgRQVkJ5r69J4?=
 =?us-ascii?Q?E6mq5QAbvINoKDdCQp8gWiIXW1gb9edG/SCvJGsZCKg7oxK96M5JSz64We88?=
 =?us-ascii?Q?DfruAyrw38ZyPsZTnWSHO99h5iHXSDw8huy7KYD8ZQrg/X8n7l0LBpbMzrru?=
 =?us-ascii?Q?VE7URuyafKv60qZXhyFfYbjSeyqFgar9r+h9W7abbSv1RF+uPDhdMpyk+cBk?=
 =?us-ascii?Q?62MOMp7o0ePljJYhv6VA7dvMY8Jb7LBihl/OVUMnTBVKbKoQeHqut/4qEj1Z?=
 =?us-ascii?Q?wF1Q4L2lyalO3choy04WvAK+uhxXaMRZVPhkMS6N4n3bknC+9nIeV0Izc563?=
 =?us-ascii?Q?asBwYQqjNp7dR83qnXIVlK0uBlm3IvzPuhdX1kJM1wWS7P3u7o/pJH6KwPGZ?=
 =?us-ascii?Q?fGszlC9P8HtRZW7yAbXcAzdGAmGPkcnLnyHhe5WGIfSf/WXWCEw9HVvhAS8I?=
 =?us-ascii?Q?UzYMQyiPqvNcBlhuG81is8s2naa5fq92S6SnGSS2QtF2IPg63/ALO9VQElL9?=
 =?us-ascii?Q?Pa6QCz5DrQpdsYzb6S/7QPHbw9TUj4pYPAVEW7ne/+uH2AyqSOCmzxMU1Y4i?=
 =?us-ascii?Q?ohdKG0LRo5gnt7jAPt8Ewz2XlutXCfJDyoM5R952gcUTpaqb7z4YuEhm3jbO?=
 =?us-ascii?Q?cd9Pd55DP5P5LHZv2Qyg6PwGV4xWArga7icH2gwQ+c3c+80/xEb1W2oDj4GM?=
 =?us-ascii?Q?S5Zw6fk5u9A4f3RBEJO/qvNthRyL8P6B4zg7h0IaHtPBueQzR8W9z48s+Adr?=
 =?us-ascii?Q?s4iaRAqz5rOTQE2FqPPzm5H06ADrdaa11PE/Jo5V8VKTVP5c8SeWT4xLyT2K?=
 =?us-ascii?Q?pSS8IHDT1KwgYUirhiTWo/4N4DGy1P5DAkf/RneS73K4AGzCC2LakAmgWMnr?=
 =?us-ascii?Q?EdvZRmBC5oFvhYgRuSVupll1muglTW/m?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5319
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f2e89b67-7475-4695-ab77-08de3e18e15b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|14060799003|82310400026|35042699022|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXQ6MwBlfPRQdqAhHbxvdXaaopDCe2/Hs+Dx6zQD9mZu/XKEGUctooLpL1Pt?=
 =?us-ascii?Q?IOfQVnWJiMo/xxApJ4OcSt9gW7yAAv5P9gJv8xgxzDm+j0QtYfuta8IKKabU?=
 =?us-ascii?Q?bZhWidlY7BLnHLNFeEKcqsw7Y44WRX5dkDcLggjAHtUFmvSliZ2mM0tU0h07?=
 =?us-ascii?Q?58y0ZzLL5zzW4h0tqcr4r4KPzSuXNS8wiW+2GYQeFNTCOMrM6/iWkWWMQDvS?=
 =?us-ascii?Q?de6AA0289s+BE2yVu7Wyt0yHCnqVsuDpmsdpfkyispM++iq4XWUFEeAhVdVS?=
 =?us-ascii?Q?AECC0eeDLlbCVN5EDNNywh2/kY91xvvMJvPg9sxDWHfq0nsAGr6F99AGfXrL?=
 =?us-ascii?Q?ltCzprXXpy9/yt3Xnn5MCzVkuPRuHUloVhNl/fgqq0Hwe3rOKkWNvu4sAhvV?=
 =?us-ascii?Q?JuyOeg1GlotR9GNQsPCi31J+XSIl/9XUwXq9C9ortYC81o0VhLGpStdeuebn?=
 =?us-ascii?Q?nq790kjQmqlEPXdc41LLw9nWiCDhrFnh7IBUxFJlT4DAKACvJLz9kWgE97pP?=
 =?us-ascii?Q?EdUT195R1WBEKpIyhpVD2Q51pmxbDLs0B++dBR/nppE2Iy0tNH14B0UbabNe?=
 =?us-ascii?Q?VvdA9Ndb6/AWikjMKXzx6ek+qI4OByqOMA17PGMUcdgxpx1J/1gRQnekZqay?=
 =?us-ascii?Q?6rQxA/3lJKSlWi2tF1t5c5/z3dsRQohDhDQ78vI/1k35Cw8vhWN1pFDs5Cwe?=
 =?us-ascii?Q?5QKqRm04MHkYGgCKOea4xEmzyBez9ae6LtBTkYocoGlW51tpQ8ADcmazsjc5?=
 =?us-ascii?Q?qBzVUOPTUFV5JH2mXrZ6+Nw7DlU44rb0300V4AUv66eKN6nFq2y3b2neMqM/?=
 =?us-ascii?Q?GdJcbDUlpZfGOXoADJQHmMbopi03DO+Yz4xK4Aczve8hjwAC+O5Xor2yEKPv?=
 =?us-ascii?Q?qKfSWwh7O5UIojitzXPXBQUczLvvPqSy3WTxv2zZd0RPOleoQtA8rFlzng1F?=
 =?us-ascii?Q?FT92MW4A3J+ylqq2F8v+jNjoRoUomy3EqLWRmyx2ASfgj8kenPVJGt/AuTkQ?=
 =?us-ascii?Q?+cGVrlK2wAN88G5pVVZzkmK2TYHRcKKetapOx/8Zt+2HHbYoShc1kKPZq/FP?=
 =?us-ascii?Q?38M+5xj9t/c7f/KPI6vk978zLjxvxgqm+IM+9a8qY2RHLj5iAHqB8TJufhb0?=
 =?us-ascii?Q?5DM8/uVdmJxbMHsWatg76jOTxSz0vSFr4Ce4ALTC6KXHdNluc/OPGWf281RY?=
 =?us-ascii?Q?UeZlfY9xTyGGc+LM1SHTvss+w0Pw1E1QL1bhpcSNSSysla0jxGEfCIFVlfTD?=
 =?us-ascii?Q?Sfk1Nicit+CFk6jdcQgs5RmmuD0mPgrLTuqgU8DjdXdEDcGY/xZlxjOM+Bim?=
 =?us-ascii?Q?h3/RV7di9FkC+4eiyNkrAqpMrdlFBICt96R/R5r5a4mbzO1QUOp8h0xT1Qwv?=
 =?us-ascii?Q?LMJ3LCVDhbVcNXscVKykm0aJOH2vNuiHtyLvsGuOmoGyFHJuTJfzSK7L2wWt?=
 =?us-ascii?Q?J3CTtIQcwdIE0BeyrBcA/v5GRVnVX7UyqCFzA1OCXUH/nuGsTh47W866jPD3?=
 =?us-ascii?Q?6okJQyQakFK19VnKmj++bWNXV8YIctP8QOEk71E/dblWcbgyOgfQMHi5g36n?=
 =?us-ascii?Q?GwUp/S4KY3Hluj/P3t4=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(14060799003)(82310400026)(35042699022)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 09:37:15.4836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0e470d-b78b-4116-ec62-08de3e190793
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9510

Hi,
> On Fri 12-12-25 16:18:32, Yeoreum Yun wrote:
> > linear_map_split_to_ptes() and __kpti_install_ng_mappings()
> > are called as callback of stop_machine().
> > That means these functions context are preemption disabled.
> >
> > Unfortunately, under PREEMPT_RT, the pagetable_alloc() or
> > __get_free_pages() couldn't be called in this context
> > since spin lock that becomes sleepable on RT,
> > potentially causing a sleep during page allocation.
> >
> > To address this, pagetable_alloc_nolock().
>
> As you cannot tolerate allocation failure and this is pretty much
> permanent allocation (AFAIU) why don't you use a static allocation?

Because of when bbl2_noabort is supported, that pages doesn't need to.
If static alloc, that would be a waste in the system where bbl2_noabort
is supported.

When I tested, these extra pages are more than 40 in my FVP.
So, it would be better dynamic allocation and I think since it's quite a
early time, it's probably not failed that's why former code runs as it
is.

--
Sincerely,
Yeoreum Yun

