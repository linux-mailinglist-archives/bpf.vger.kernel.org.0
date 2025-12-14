Return-Path: <bpf+bounces-76562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8C9CBB8E8
	for <lists+bpf@lfdr.de>; Sun, 14 Dec 2025 10:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32E323007FDA
	for <lists+bpf@lfdr.de>; Sun, 14 Dec 2025 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE6E23B615;
	Sun, 14 Dec 2025 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K3L4gWxk";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K3L4gWxk"
X-Original-To: bpf@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013029.outbound.protection.outlook.com [52.101.83.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C774C92;
	Sun, 14 Dec 2025 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.29
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765703777; cv=fail; b=WHc3MYT9rrPdqO0sSziLcqHxfWuQLyH84j1TRNEZnGYhM0KKKan4f246YPfFR/nCz29yti4nhDE+7t5ja3D20v9hcl8PbzXrDEE6xEn80wrizxEPqGtUPYCMM5uxtgyqsxJgqKSM0DslH47c9QOZjVD5VziMtDnd+2mhLPorZxE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765703777; c=relaxed/simple;
	bh=tsGyQTEW466tDiM4FXoozWOC6CReqpxWdgxJ3qSBqnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r4l1FVcVoRJgeqV+dtMtys+GP86GFyWVUfGStnlx2n+kehkg4sZ5kNVWSfmDF/Hhq1tPdTsp3ie3sTSWoMkVVX6vGm+bIfLEs9xK/aztGF9BR7BJxQJ8ba7C/a5UUExFggDSJvI8JTVcdEKDOpREmKCVXDkOvWioQ1yr9tNJY5s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K3L4gWxk; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K3L4gWxk; arc=fail smtp.client-ip=52.101.83.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ksjbBLk4zfohpttL1kO8Ir+pyZxzo3or3jQKobam99C/1eDNtrM5bPD8uuP2U+mMlSZs9kT7k4KnK7CqDt/Xh0iUz0ZGMo5BWIzSv8lXKIamaU6sHF8wX/fmnZ6fZuc/U73PllbiMRh2t8NaMzCzL4ednhan5ZxGYSGpWzej8AfvPRlgPseudwBu+9n99ClCfCdfipxb6P1yUz6LvQDt1eyOcKrx8bD5u7j1aCHe5wv31hiF3MBw8Zs43zkzhVX768QHM8AUyIgMNbMtjmXug0cVGSlhWFTRfNYppoa4MRBdyjbiTA6zw+YRJ9Q4qL4Th4wWU2KqugE1UwrsDkC05w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b93ykCeHZBH8Z/XOC/fjFQlu4jKvjo1vZayjxzaZf+s=;
 b=tImhT97iT3oGnld63XPPM/KS5/W+LokkuDsGLE++gNhXLWf0pUzkMpQom5lXMUo5tbVcdgzjjdekWp/Wl7T150L/nmVD8+engOhcO9CtfeBliM2Nrgz/5axNLeZDv7e/Zp2Z6bbpCGT8bv1v8OrAn6cuu0Nl3oTX6tf1iupGnYdIc+osRDABSGA6ruxYjIPdxUmTka3EosAtblxuxOnz10HD+2Q77AzhSpTpgLoFk+MvXp9+Fbg7LRssZBwVBe7re9HKuQ8uZHXpwYT+WuUqzLw7tWBAJQjvQxdIs+O7egpR8JPvTT7osP40ZaJT3Hc30+43BTkGR8YUqfmGeXX5bQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b93ykCeHZBH8Z/XOC/fjFQlu4jKvjo1vZayjxzaZf+s=;
 b=K3L4gWxkyVM1I4GWKkc3MrGogpaTjmUdCUQs9CpV5e1zNounr3Rn+YmeTzTWLfky+G7h8rOE3zCTK7uklAn4aHH53HFPtrjmdedVWSfHY3xeRuahgZPHIkFk8Kau3SUBGVLvicuE+PP53zPQ5TuihdG5ilPZedi22nzGLXJpnBo=
Received: from DUZP191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::6) by
 GV1PR08MB10956.eurprd08.prod.outlook.com (2603:10a6:150:1f4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sun, 14 Dec
 2025 09:14:55 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::90) by DUZP191CA0012.outlook.office365.com
 (2603:10a6:10:4f9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Sun,
 14 Dec 2025 09:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Sun, 14 Dec 2025 09:14:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDGsWBeRKpLSF98ctjoRGkt/80O8zuIYPeWiOh28O2An8gdfYy1n3MGdCCn+KMz6YNSl6Jz0ignSlRwLbmPN+s/g0lYAKg+mEllbltP2VaZXxrFAA220hRvuqOo06tderuej5glgNA0xqhEcjSP2mbeRVlEJy0U9kw1Uq2DHp4atoZVZbPVgssvTCE0exNqZUSFCa0GyO13SmzhZT+o2jLAFElkMsraOeax4xp0h0GtDR0OfvIgkoVNX6+Qtk+7Mc+uTpIx29bKxZkpxxwFokMke7JubX/+k4QyNBItaUbknYEKKfqPv6gWcjvNyV+71RQaZSI/K11WD9psuWBbycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b93ykCeHZBH8Z/XOC/fjFQlu4jKvjo1vZayjxzaZf+s=;
 b=YVPriVUxgxCzm9irECmpuWyKDtzIvH3WXctg2BRjYQrLTj9N1vQ8R+e8rf0m3EcU3BAIBaWfOFX/ahXm+hU31SZ++tWurBb+19l6M9WBVT1iFfN9Rwm1LdRr8MSBavyEQb71ebzXj+Gn7Egxr6udwGpEBvw1asOHfMDpKskUvqY2NjHpvaerrJoRZOgpd548pf092a5ygAh4oTXliXx/ddAGYYq3WQpVDhy/lkIhila6Blvg0lcypcVHlz37ZTpuviGI/fGCt05/D4GttsVWgpeL5AW85hlR0TnbmplkMWHNgQ1H182mGXTIAPH3DkNj+nJO7ULvgXbQOt0aHeTsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b93ykCeHZBH8Z/XOC/fjFQlu4jKvjo1vZayjxzaZf+s=;
 b=K3L4gWxkyVM1I4GWKkc3MrGogpaTjmUdCUQs9CpV5e1zNounr3Rn+YmeTzTWLfky+G7h8rOE3zCTK7uklAn4aHH53HFPtrjmdedVWSfHY3xeRuahgZPHIkFk8Kau3SUBGVLvicuE+PP53zPQ5TuihdG5ilPZedi22nzGLXJpnBo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by VI0PR08MB11842.eurprd08.prod.outlook.com
 (2603:10a6:800:316::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sun, 14 Dec
 2025 09:13:52 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9412.011; Sun, 14 Dec 2025
 09:13:51 +0000
Date: Sun, 14 Dec 2025 09:13:47 +0000
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
Message-ID: <aT5/y3cSGIzi2K+m@e129823.arm.com>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
X-ClientProxiedBy: LO0P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|VI0PR08MB11842:EE_|DB1PEPF000509F0:EE_|GV1PR08MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4c0213-dd4e-4f79-f0eb-08de3af13ed5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?6IRJ6Gowh2yuRRbdYw6UInpm0WR9GO/o9QhY9rdy80nUP1/yS++pnWbLz3n8?=
 =?us-ascii?Q?YcLppcS/io2ln24R44P5c2ZLwiE2daOwHgHjDj/B49N+AVjwhps5nQzIPAHJ?=
 =?us-ascii?Q?f1DpP+LEqJJQkHZJRUL4JeuL0/I965seEwzaWMi4X6GT7ujzfP7AtPHJTBDU?=
 =?us-ascii?Q?OWdHHnRcU0zqMUQYYKbd4ySJGlLrs4n9pyuCrpbq/Z9a0wvuXf/isF+2LXnh?=
 =?us-ascii?Q?XhZp1I9Qg7SfkGkEMHIYTy1maVQfOxVb8/pHIqflhZ1a2+Ec3YhCVGHmAzEX?=
 =?us-ascii?Q?W4Vtwft/2HRsTRe0GmOMAdXH4JjCPJjBQ60u5kQKwf+EcgPETmOd3m4LekIm?=
 =?us-ascii?Q?uwTGfcDUoD/9VikR4dJ6v2MX66n2lNlaM35oLenPzHVN9neaTUyraFFzinxT?=
 =?us-ascii?Q?xQgkkNXeVK2Uv7V0pUy3YldVSsD4O/WHR6yVIJMazGTjBKsJb6APyo/fEJrQ?=
 =?us-ascii?Q?ztLUk7XaH20v8q4lCb4F8cPl2Gdr/RGaMABBQPL939KDVNbrOb4lXs4jDZKS?=
 =?us-ascii?Q?yBNHd6KKtKXXR7yqdkTgHmoL6gF/RSdffqgo7ICWFbuRb6P1p7E6MAosmL8N?=
 =?us-ascii?Q?w8USmQt4Ev++cp/9nCNMDdcATULo/XHOMxZLKUmeM/N7TFSjOS13Xb0D/Q1Q?=
 =?us-ascii?Q?79SEcD5ZTpHShumlrbUdRQxDW+k3p43uD8NJiWF5sWMeCcCHhYin8woevQPo?=
 =?us-ascii?Q?5fu0mKq00b6eVpDMJPxd2bRI8WeZbpD4F1hWiP9B2DCUfMmIWI/R4mSS0EPr?=
 =?us-ascii?Q?Lc+V6U6BsE0PWkgLVh2fk4uRqbOVpE7HmuZ8X/pB6+ybJugjUBlvbURZYnSU?=
 =?us-ascii?Q?19mkZ1DXULQsfLw/u9jKBMKFudZXp7AT7NRNBzYa4YaZ82SaVFpVAG6a4ebL?=
 =?us-ascii?Q?wlV5RQ1MU0VxLQVGIKI1FHHybpfWdeVkx8pDehX90LIzbqWKk1YbZw9kaZ0A?=
 =?us-ascii?Q?USgaqyvtA+RoX2cfiteUbwkFWKhie6MG2M7L59holwG3S1wCjqi/hf4t2JXU?=
 =?us-ascii?Q?FcTK4QYCCDeJaXSO/SeJQemKrLyjynIozV/rzSseMuK8MVW4ukgTfCVGCZSo?=
 =?us-ascii?Q?yTx8NQGdxxgtFKtDMreUN3HrGtumEKxIeO3kS55hZLPbNGIopjeUj85iBxWS?=
 =?us-ascii?Q?cC7LASAp1PLMPMN20exi1w3apiRS1etvehpOSJg9Y+bAWmhSBVq9JDCMmomw?=
 =?us-ascii?Q?WCSIwLrALlusxt7VyENKZDQQHa1uraUE8HHH+e+b2iqTzwWkL4kzy/Wojbgu?=
 =?us-ascii?Q?l1bwuAGak4LGCg8+6nb3++VSM4Hn8mesEpj+tgjRMu2fm57wThsSxVSHu9F0?=
 =?us-ascii?Q?1B8txukmiMAy1AA2GHzPV5za/C4cXvH8gYK37cUJ6e9ItaatbQ/tH5qBhaci?=
 =?us-ascii?Q?NPe0yLex0bwl+ZWaiYLxaBWjBH0o9XTLFXPHG4dhIaz43qVXsEwDmjP0s3EW?=
 =?us-ascii?Q?AIl6NStdrlEgi0pod9P1v8DQ05g7k8yN?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11842
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6f7b8df9-e191-4617-d229-08de3af118e0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|35042699022|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uc1hdp3LbG+EOk5U1URomkeCVRuqrjZp0TYYJNas5M67mXu4a1NbJ3wzfjNm?=
 =?us-ascii?Q?f6RtYJB3eV+BRQsFDKfoROahWyJT1lfRmx9ZS5IzwMDptnIhNw4QyYj8qmsI?=
 =?us-ascii?Q?FmllCq0hGCpgTH5qnQtcyv1QI0NEbFEYarL9bqFdIhsqBUQSCIJBu0O+hcCj?=
 =?us-ascii?Q?rtpGelYq05NPEekJa9jgU+NXrqUGSwolnjGX7c8pqVm6B/6MqP8bmHphn5zk?=
 =?us-ascii?Q?xbA+yTOUog66joxTG3mwlNeF+URLBRVUNMMkExNSNBX7EVx4MWb7Q2OJ3ARw?=
 =?us-ascii?Q?6EszGAinGP9++xMWDycgjpmrHRE9xlqbgsZPIRloUj2QeJcplYauc+ojqN63?=
 =?us-ascii?Q?s5YC/AhfkX/YmW+XyNyh1EEQsZRW5e6KCJIr6z6Tux38LmVF0EGWUO7dAUaS?=
 =?us-ascii?Q?gOyR/fZG0pFHSTBjq5uOhW1RybGyTiM5MgpR5BXny45umExe4GcYVYxcOMUf?=
 =?us-ascii?Q?P2FBhNTgjqAkVYUGUzpcaXEk4lJmLR1YxRqo8stbCzcf7jeKTNpkZKluyg7m?=
 =?us-ascii?Q?OxrzGkrILxoZtoKShePQ8hX9owUMZz+4+XE77DpXa+1m4zUHsmVr0xIP12Fv?=
 =?us-ascii?Q?dABCWSORW52e6bgoZ4JidFCPfXCqjiYdV+1ST6F1mR2+56spxvKZfdguceNl?=
 =?us-ascii?Q?PoDHCb6WbS14ede3CAM+cXFA7fNZzpUfkmvFBVMkd8H0ffCHnFr/UmMv32VO?=
 =?us-ascii?Q?5YXpBS2HUbKa+i/qRpUqu1bSv74/gCkE5LxlHrv5w8h0YbPtv2+mfoWTC6bd?=
 =?us-ascii?Q?GvjBDBZP1GlUPb6hg3o0URWsgBS+GQGTcUtOVcKzUxdKkEBDnsSNPiKaoOkn?=
 =?us-ascii?Q?sn4vwWvFcWQoJX64bDoBeTfyaCyAQuwb4ZxVR6poNot99WHcm6J0Pjtcw4xn?=
 =?us-ascii?Q?b4jGlG5P2skd4ZoKoS7V4MSyO2KEbeKR/DEHjAu0LI7DSCRUht9hv1+71n+h?=
 =?us-ascii?Q?Prb/nMIYdmJ7AExa+Tu/5VGYHnP/mek2aH10M530k/zg4zAv1oF19wMg+JdP?=
 =?us-ascii?Q?uCVj9HmnP/El9mYWbDBsZOUIc87oCZLIpphIFA3mllHLeK2GvLnuh4XV3fHP?=
 =?us-ascii?Q?M3ZZoGh00eRih9H479SniOZovvN0u9tg2eMgsLxrT/yY6j2BcBbbpbvF1Kgq?=
 =?us-ascii?Q?dOdVhcxcO/NRVzDZmFpjQuBOCnQMe0mNjDbv7YM9+qc+fMsO4Kda8Rs2tBJw?=
 =?us-ascii?Q?RiDG5v0zZkNzkCFb/gzU8j33myig3t8w7YpDJ46Fcs+jGC/yHIxQAXrrrUvl?=
 =?us-ascii?Q?BOMRF6nz1asOJrhdy3EsJlXoVwK82RjXpEhJrXgg3vYgnu71u65Y8csnGS/6?=
 =?us-ascii?Q?wbBsoNcbAQR1h6JQ54FhlU+P5r+x4aPDWN15vKKege9X2c/oqg2xUPWDzkqj?=
 =?us-ascii?Q?DdRHk7Up5FoM1VqMYK6FdZYz2UKEHYzKEYFCj7OsGnwtEJ9IrLstezpTRMtJ?=
 =?us-ascii?Q?w4T35oJTBDClFx0HDJKHgbxN168IPG6fxJ9GStgfLGKogkOGe59NQCyfpjIg?=
 =?us-ascii?Q?2byTLQjaIYbbjCD58bpDVK/zmYQQZIbkmTqZgkRCcopXaADet3GIE8N/oh4Q?=
 =?us-ascii?Q?LQaOj24gkDWGoMN7Bhg=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(35042699022)(82310400026)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2025 09:14:54.8307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4c0213-dd4e-4f79-f0eb-08de3af13ed5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10956

Hi Brendan,

> On Sat, 13 Dec 2025 at 01:18, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
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
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/mm/mmu.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 2ba01dc8ef82..0e98606d8c4c 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -475,10 +475,15 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> >  static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
> >                                        enum pgtable_type pgtable_type)
> >  {
> > -       /* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> > -       struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
> > +       struct ptdesc *ptdesc;
> >         phys_addr_t pa;
> >
> > +       /* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> > +       if (gfpflags_allow_spinning(gfp))
> > +               ptdesc  = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
> > +       else
> > +               ptdesc  = pagetable_alloc_nolock(gfp & ~__GFP_ZERO, 0);
> > +
> >         if (!ptdesc)
> >                 return INVALID_PHYS_ADDR;
> >
> > @@ -869,6 +874,7 @@ static int __init linear_map_split_to_ptes(void *__unused)
> >                 unsigned long kstart = (unsigned long)lm_alias(_stext);
> >                 unsigned long kend = (unsigned long)lm_alias(__init_begin);
> >                 int ret;
> > +               gfp_t gfp = IS_ENABLED(CONFIG_PREEMPT_RT) ? __GFP_HIGH : GFP_ATOMIC;
> >
> >                 /*
> >                  * Wait for all secondary CPUs to be put into the waiting area.
> > @@ -881,9 +887,9 @@ static int __init linear_map_split_to_ptes(void *__unused)
> >                  * PTE. The kernel alias remains static throughout runtime so
> >                  * can continue to be safely mapped with large mappings.
> >                  */
> > -               ret = range_split_to_ptes(lstart, kstart, GFP_ATOMIC);
> > +               ret = range_split_to_ptes(lstart, kstart, gfp);
> >                 if (!ret)
> > -                       ret = range_split_to_ptes(kend, lend, GFP_ATOMIC);
> > +                       ret = range_split_to_ptes(kend, lend, gfp);
> >                 if (ret)
> >                         panic("Failed to split linear map\n");
> >                 flush_tlb_kernel_range(lstart, lend);
> > @@ -1207,7 +1213,14 @@ static int __init __kpti_install_ng_mappings(void *__unused)
> >         remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
> >
> >         if (!cpu) {
> > -               alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> > +               if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +                       alloc = (u64) pagetable_alloc_nolock(__GFP_HIGH | __GFP_ZERO, order);
> > +               else
> > +                       alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> > +
> > +               if (!alloc)
> > +                       panic("Failed to alloc kpti_ng_pgd\n");
> > +
>
> I don't have the context on what this code is doing so take this with
> a grain of salt, but...
>
> The point of the _nolock alloc is to give the allocator an excuse to
> fail. Panicking on that failure doesn't seem like a great idea to me?

I thought first whether it changes to "static" memory area to handle
this in PREEMPT_RT.
But since this function is called while smp_cpus_done().
So, I think it's fine since there wouldn't be a contention for
memory allocation in this phase.

Thanks.

--
Sincerely,
Yeoreum Yun

