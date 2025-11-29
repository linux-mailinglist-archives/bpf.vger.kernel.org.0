Return-Path: <bpf+bounces-75770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85254C9493D
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 00:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F161C347301
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 23:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4916527280C;
	Sat, 29 Nov 2025 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HibJGYmn";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HibJGYmn"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E624EA90;
	Sat, 29 Nov 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764460232; cv=fail; b=rHxZQYGbVmbR+y0PdfGE4ZkAnALA6NGOqQxgXKWfQfvjn5VjjDRItq3HZN1I1z++xbAphLmxsnzG7THB3TYzjLDfzFO4lIxFwysh1RaSrhXEw/YZjVd8BEghOCd+Om9z3P+YT00JZ9EJlfncSRXFZIt0TnDa0jOIK3VJfUBj6uQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764460232; c=relaxed/simple;
	bh=7cN8RDeYNF4HKjluY+P2GBmTYdoLeYNLgKBhqQJYwH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gI2OP3PLNTTVl+Kkxr0ewk5wdBeZrGD3VQpXep3Dahqh02gt7oCfV4jvlwGeZaKSw/qKcDEtvOWPFkyjQUqrH8ylA25H+OEiAfREgmwHR4ng8bFNALKrr+Ue14UW1o6gquQvtf08EEnHN+szQCIF+tZQdFhqkgghCFiEZR0SqR4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HibJGYmn; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HibJGYmn; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=G3CePrCdPcFbgfcOO4MBQy04ePx4x2DhFI/YOLJRKVaQdT5d9+lX/Sn06SAOb+B1Wt3PTUq5I1NyoOldYk87b/zwWlQZDtXIV7T1r+Dm4NRnMYWSTPqtUDaOUz/q87dSboYZMi392xQfjoHOV79IN66j/QsiBAHRnfYSgeoGLE2GWHk6iDtNoWjFDLXz4smffjx5vVGfIoP/X9jbaUAan+cICBHg8TrlqlqHWOhwGzEAIEQ6lXDcu666SkcAIh3u55EiUVK/r/A+bF3dDYXIQVmOLhg3WXPPEwDaH692hZmZHY81991+KWkTWW/0h2NBlobXgqAl2GtdD5e7oobSGA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/AAG4J7hGv6Xqju4De+6WZ7MuhVaW5m5azDyDR/Gq0=;
 b=wKmiUkEJNPJvVpak8uCKu4CJxKVrzK5zJGGfJPRIgI67+UeoYGfI60wFfva3Ht6JEfTwcgXAraQ2/rNBeKBBC5KBNZfISVVNNBA1XUtYHAn2mpfLM/zJn7CFZR//qQ/zQ/XDExrXLssW1fBwEHn0gwBkwuF5F+KRH67hNJAy3wsPgoMQu6zfWMriB3VFc+IrKw23BZclXEDPNRCOvU92QIZQn+QrvI7AFsdjCDidMc8l/1oKey/XdPMAVgIV1W0jpQlIYJX4TXESej28nzryZpVC2Y13ll6Vw1cXs/ZLh0rf2qSmSb/QX+IVdyGWKsaDD22xp9jrEqugIvozvBaZlw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/AAG4J7hGv6Xqju4De+6WZ7MuhVaW5m5azDyDR/Gq0=;
 b=HibJGYmnBDNyGu1sKzpNXAAR0g1KCqyt8dXv3UJvCoATO7vb2EOZ+SRrVAh+53DK02OGhxxJFJnxNuJ91+8XT2290Om6rBMLlh+0yS0+cQ1eKhdL9o5O7HsEvB1uzQh6AhE6UrE1GkS7D4LZ0nW/ZV/aKGgKPjGb5IGYPzOqkTI=
Received: from DUZP191CA0069.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::22)
 by DB8PR08MB5418.eurprd08.prod.outlook.com (2603:10a6:10:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 23:50:24 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::76) by DUZP191CA0069.outlook.office365.com
 (2603:10a6:10:4fa::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sat,
 29 Nov 2025 23:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Sat, 29 Nov 2025 23:50:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RP8Rw27o+MN9VsOcvyQzBsiJ2wmvLapZ7qG33jY08UDzyWycjlyppRs+5ByXcicRLIh4sPx5eouWf2O0DtvxyNzzAIM2niGpiQcuO7Tr1pD4c3f8B3t3jRixlDIvfwW4od7JJEzS+YShqBX1rvlwVCvIUWlh4ct6zMpDInn1S2zcH4VB91XyOtnO+eljuQbgp8ePNkIFNifaHVL6tNjRp/WMRLBuagsFNmFpxdMq3hPN+WloiooxLGA1NLXcybl+vTyibEZcvYkWmrit3pbbwJ2GmsN88mlcTQczhsKnt+mwSWAeaFmEsdQBvkYlJpg6GkH+dc2rGzvlcaixfipwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/AAG4J7hGv6Xqju4De+6WZ7MuhVaW5m5azDyDR/Gq0=;
 b=LmPB7ShfXTGx33Z470taY96xLcS6QcOHO9EYqulFm+cMC/3wmpWOzxYihN7Ai3RtH7YxeAeYvqIv8jmIp5FBE8JCtjGRg9foffncXdITL/6kapAvpB4cZXp6qGl2k+OcVWb5Rm4JFM1Yyoz8vP115GX/agrviI5pnNoqHu35FpPUpnf8l2yhwNPTIuj6BWEy4hFnxOCHLgTajkqAQXI5NuYM2RIMOh/pBHgbO3S6Mli6S0nRDiFRln/dt+Ud9Ji+1YHbwL0UcX5C92bEfkc/9JUkn4ExNIraQMmqAvT6lacqgATx1Vjk7BVWnO5oWuAItvhd3GHvaMQRVrszZbpuEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/AAG4J7hGv6Xqju4De+6WZ7MuhVaW5m5azDyDR/Gq0=;
 b=HibJGYmnBDNyGu1sKzpNXAAR0g1KCqyt8dXv3UJvCoATO7vb2EOZ+SRrVAh+53DK02OGhxxJFJnxNuJ91+8XT2290Om6rBMLlh+0yS0+cQ1eKhdL9o5O7HsEvB1uzQh6AhE6UrE1GkS7D4LZ0nW/ZV/aKGgKPjGb5IGYPzOqkTI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV2PR08MB8342.eurprd08.prod.outlook.com
 (2603:10a6:150:bf::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 23:49:17 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 23:49:17 +0000
Date: Sat, 29 Nov 2025 23:49:14 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: catalin.marinas@arm.com, kevin.brodsky@arm.com, ryabinin.a.a@gmail.com,
	glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
	vincenzo.frascino@arm.com, urezki@gmail.com,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org, stable@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH] kasan: hw_tags: fix a false positive case of vrealloc in
 alloced size
Message-ID: <aSuGeoeLTPSK1L5l@e129823.arm.com>
References: <20251129123648.1785982-1-yeoreum.yun@arm.com>
 <20251129100658.6b25799da5ace00c3a6d0f42@linux-foundation.org>
 <aSuBHo7fpQxQYgef@e129823.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSuBHo7fpQxQYgef@e129823.arm.com>
X-ClientProxiedBy: LO6P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::8) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV2PR08MB8342:EE_|DB1PEPF00039232:EE_|DB8PR08MB5418:EE_
X-MS-Office365-Filtering-Correlation-Id: d6acc3a6-a16a-44fb-7f43-08de2fa2101d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MlRHS2JOYUR4MmdQT0YvdkhSR0hObEdFU2dmOHhYRFl1RUROT1pBdDYvTEdk?=
 =?utf-8?B?V0lGWnJBSXFCYUFaTDdJMjBqYlJOUFR3d2NwTkRUNXRnYkVlRUM5SnZzQ2tq?=
 =?utf-8?B?QnYxU0I2YXVPMFpmMkVvcHBnK0E3bFJCbG1jSXJyUmtRVFFUWFZweHVCNWNI?=
 =?utf-8?B?ZG1uWUtHeXBWamxQWExkem9mc2VaWWxFdG1YbGFGdmFnbVF6c2IzNzgwUm9F?=
 =?utf-8?B?UGY2RHdPb1BubHRqRGRjY0lpK0dnT1NHRGpQc3JwYm9HZFZNM1ExRTVUQXcz?=
 =?utf-8?B?a2thNHY4KzJNVFQ2S2lCNzVIUnh3MHBWNGQzY25tSUI2MytGMHhlZmxrS21m?=
 =?utf-8?B?T1ZneW5BaDEwdWZMVk1CQ2JCdnhwQ1dBdC9jT2NKaGhQN1RqVFpWeEZYWUM0?=
 =?utf-8?B?bzE5UkFlbnFqU2U3Uy9yb09Rd1BNVStwZ2VqUDRQQUo4dTVmSWlYR1lPS1ZF?=
 =?utf-8?B?ZXRSVnVrenVMcTBieWdXc3AwVElWWnNUS0FSSDI1bkhzWmlDRVlkbDhDWXVu?=
 =?utf-8?B?djBsa3N2WWw2UWVSaUtGL3VXZzBWMS9GaVhrNTQya2tNb2dJbTVBVW9zWFVT?=
 =?utf-8?B?eW0yM3hwRnljMnNXL2p1UnVXNkE2c3RVU3NVTDU3R1lyUUJIV3RzQS9Iayt3?=
 =?utf-8?B?R2tqSUhVMEVSdG8zNTg2a3lKODAwemNaWG8xa2dDMFVNbWUvQ09RYy9jS1B2?=
 =?utf-8?B?ZWN2alh0MU1nZ28reXV2a0VVc2VHcVdPK0ZDWHo5N0xCWHg0WUV0SlBZTERh?=
 =?utf-8?B?OWV3cEZ1OTI0QlNRelB6aU12ZUhBOVNzSjVaZmVNeS8rWjhEeXJiKzhaZEIx?=
 =?utf-8?B?T3VGZ0lxbUpDWXkxOUhyL3lzbElZRWc5MVRxN0U1amQ2WThkVHFyd3czc1hO?=
 =?utf-8?B?ckdUNlEwWDQxdmM3a1IxR3hURC9jZlNWTXUrYWdUREZJWUlRaFZ5NUhVK29S?=
 =?utf-8?B?enpCOU45bTdYZnozT0FnRGkweExPemswcFlacjRTa3lLWUxNaE9rcGdEalpU?=
 =?utf-8?B?OHo0Z29uV0djSlJZL2JEMXR5ZFVpbFJxaUtKbkk5N2R2M3RkZ2dSYi9PVkd0?=
 =?utf-8?B?anVrc2ExdFN6M3V4OXpEV3VMY3VxcC9GS0VwcWNRV3YzMEFjWkhxT1FVQ3FM?=
 =?utf-8?B?dnJFT1pHd0pyMVB0RUNOUGNrUVIwbG12VUJWYnpra251Z3BzeDAvei90SVBO?=
 =?utf-8?B?UFc2OE52S1dFMFBNWlU5Z1ltdjJwdFpNVWI1Y0Z1cDlpQUdtaU9VUVFudTRk?=
 =?utf-8?B?aFNFbnUySG1zU1grb1AzTmdWcC9zakpzSU81UDlId25MWHBFMHgyeWhFOU56?=
 =?utf-8?B?TmlaQWtoWnBDNTlHUTE5bVFNSFQvMTEvUEFyazVOd1UzeEp6NElNcW9jN2gy?=
 =?utf-8?B?TnJxVjU0bHF5b2R5RWd2ellpcDV1azg5eEVCY0RRV1NOZjNESFJWY3FYLzBz?=
 =?utf-8?B?VGhDNUcvR24zMlFmM2dnZHF0ZkFYZVNVY2R6WjlCQXA2SXlIcENFUGMrL2RR?=
 =?utf-8?B?c3FTaXk2bWlQTDNRVU9ISTVFeHR1YmQwclNpaXdBK29vQVYzSDFjS0pka1Y4?=
 =?utf-8?B?N1kxUWhSSHZZdmRHWmY1MWxnalQ1ZFZMV3VIR2h6RVZ3M3pZWXlhOE5wSDhD?=
 =?utf-8?B?dTdNbUVZZVM2N1A3NExOdzA2WTI2N0V4S3ROUW4yTS9yNjhzSFBjMXFrNEth?=
 =?utf-8?B?Y2ZZRVhJdDJTY1Y4Mlpncjh2cGJnNVFQSVA5cHhqa0pkVXBCUCtOS1U0R3hX?=
 =?utf-8?B?ZFBJajlLVjRSUVZoczJMdXRHNlR6ZytnbVFoT2l1MWt3Tmh0VUNXNFl3T2tP?=
 =?utf-8?B?Vk11bk8zTmowSW5uTHZ3YXgydk9LNEJMV24rbmdIZUg0UWloaXdiNmdHT0FJ?=
 =?utf-8?B?cHVNNUJKOHJxS3V5SzRoQkUvMmxJQWY2TmdFalJUQ3kyVmhKTmthUlR5eEQ2?=
 =?utf-8?B?eEVINXRzZ3Y0UWNOaWJldlZjUzQ4WHVFNlBXeTFLTkZ0Rkc1OUw4TEhWMHFO?=
 =?utf-8?B?Y0FEREdCWStRPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8342
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6179f722-8757-4981-9f41-08de2fa1e878
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|376014|1800799024|35042699022|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEhNczlRcmJBR1RHMncxem1xMHNGeXZFUUUvbnNpWEZEd0JveEt2WEFWU2wz?=
 =?utf-8?B?WG4wQ01rMHRBeU1oSDluZFY2U3dQOHE0SUtZSUtncTdMcFJLa0dXaURNcU0x?=
 =?utf-8?B?U0NDbkRhQkpJOXpkR3hIZXNqR2VLQUtFMWY1MmtwQ2RFUWJVSnh5aVQ2V0xJ?=
 =?utf-8?B?Y3Z1Mzg1bnpwdHdHWUw2MnFYOHRVZHRpMWgrMWxMSlRubVZ5YzJKdFI5eVdW?=
 =?utf-8?B?MDRTajkwVk5MTG9qWmJHai8xeVJyR2RGSlg5WVp6Z0VRSExFd0tIanhyU2ZB?=
 =?utf-8?B?VlU4Z2hTZDV4RDI2NHRrRTVpdzB4L2hTYXlPYW0wTzFsVUNWOGIwdjFaUXV5?=
 =?utf-8?B?VXhZblh1VUJzTzI4MDlwRFc0eEhubndValhGNk5jeGcyakNVT1A2bDJxV1Iw?=
 =?utf-8?B?eU9HZ0h0UmZSeHVDTlVPZkdEL3ZrNDRkZHpLeVlaV0phcDZKekoxSm9tSWNP?=
 =?utf-8?B?c1YveXdMMnZZd3dpbUZxMHNzRGk0b21aTGJQVEtOM0ZMTklZZ1N0WXFoK01F?=
 =?utf-8?B?cm1OVnhZcjFyN0wvd2RKUE9rRUZHcE5OdzArZjdCNWRlSTdqUHJJSm9ZaEJP?=
 =?utf-8?B?Nlo4R3JXZFFMM283bEkvdkJiOUx5QWhpejBSSDkzUE5TWmtvRVpERzdiZTBu?=
 =?utf-8?B?WTVSbENyZVRtemhqWjJrRlFlWkd6WkRxNGQxNjZKeWV2cUl6QUxBc3lhak5m?=
 =?utf-8?B?dUVtM00vZEo2RCtldys5Q2duK2pJenZ1SHRDU1kvV1FWSGdRc2NQR3dlaGxC?=
 =?utf-8?B?Tmg4K0xhOXh6dFhJTGZRcGtPS1RzaFl1OHU1RDV5WkQ1OXN5N1BGZzYxemJH?=
 =?utf-8?B?VEtIQnA5TjlKdE1KVUxLclFuWGVxSm80Ri91WTBxRSt0dTB6RlFJWFdXNEI2?=
 =?utf-8?B?WDg2UzZmbW41aWhEd08zdm1UTkVYQzZQNElwSVY5VHhhZnFaVy8zTDd5aVRr?=
 =?utf-8?B?dkpjTGliNjZ3bVYwMlFFci9uTFY0RlJrQlR6Sk0vdlNnZkMyWWtiYUNLcGpk?=
 =?utf-8?B?ZC9qQ1FjbU1aekxNZ2xjQ0hkeU4xZ1BhWllpMmlaVVA2VEZJTk1BOFYzRTFH?=
 =?utf-8?B?Q0VmbG9jQUlybWo1T3M0Y2hRcUFTVnVUdm5mUmpmZ0tNMDJzR0xWb2ZOQ083?=
 =?utf-8?B?WnVIY295SU52VHAwclVjVjhHQllPV3V0enBZOFhabVhlOW00SGpVa1pDRUtZ?=
 =?utf-8?B?OUhEOU5CTE1VTXU2bXVEMUY5QTVOajQxeGV3QVQzSnMrZFhXQ0FmSWg1RXcy?=
 =?utf-8?B?UXgxWGxuaEpZbFl3WjdSV25wcTk0N1lRWi9mamZ0eVJQbzZCVEI4SVZkZ2Zw?=
 =?utf-8?B?VUdWTkZUOTE2c2MwQlF0Z294aFlsbmpQL1JXZ0lNSGF3UUppZzJKZ3c4c0dZ?=
 =?utf-8?B?U05Wemh2b1dWUXc1RnlnMHRLckFCQnI2bEZRQzZFTzdrbkorZld6T0NpTXoz?=
 =?utf-8?B?MlNUNDFSc2N4OTV3ZjlNdVdCbUdybkZmT3ZEcGcwbmV5NVY1ZlQzT0tINmpY?=
 =?utf-8?B?RDZGWjR0MEFsNHdGSEtmK3YzSTBhcmFzbjhxVExFVksxRHhaOGxjaCtwb3B3?=
 =?utf-8?B?TXRtRlhmTDdyWEpvdEYyaE44bk1JcmkxTXFta0lqaGRXLzRKQ3EybTFmZm9k?=
 =?utf-8?B?YWorK3d5WWI3OTlNY2NqVGRTL1B5a3lCYmJCeUs4SEU3WEptQ0xRS24zUUZY?=
 =?utf-8?B?RzdZQXl3Y2lDSXFtbGFORlBydmpZdGpsZmdDTFR6QXN0cCtpU2R1YU5UVmVZ?=
 =?utf-8?B?a2R6SThoTEFvU2xHNTdVbzB3M2loeFhQaTlJTCs3cG5iUzJSOWw1L0w3SnUw?=
 =?utf-8?B?UTA2N0hLZDkxK0lRdElCc0FzUVRweHhvUVN1WXNPUjdZMW9yaG1NaE9Kelgr?=
 =?utf-8?B?UnBNbjc4ci91eC9NYnMxM3B6cXhtTWpIdS9FQWExS0taQ05PNlZWeVhPM255?=
 =?utf-8?B?UVFoZzdyQ2JObjl2UG5XTnd2NTdTT0g4VG4rbTErMzMrSW1vMnFqVDltczRE?=
 =?utf-8?B?WXdDdmZ3MjByZUQ0Z0ExRWN5bEw5VjVjSFZzYVNBUmtzRlg1a0g4NTdGa0Z1?=
 =?utf-8?B?WmF1RGdMUmpST2lmckpyU3Q5NE5rdGNINmNDRjJTV0FYVU1qVmhOaTBDRGpD?=
 =?utf-8?Q?yExM=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(376014)(1800799024)(35042699022)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 23:50:23.3690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6acc3a6-a16a-44fb-7f43-08de2fa2101d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5418

On Sat, Nov 29, 2025 at 11:26:25PM +0000, Yeoreum Yun wrote:
> Hi Andrew,
>
> > On Sat, 29 Nov 2025 12:36:47 +0000 Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > > When a memory region is allocated with vmalloc() and later expanded with
> > > vrealloc() — while still within the originally allocated size —
> > > KASAN may report a false positive because
> > > it does not update the tags for the newly expanded portion of the memory.
> > >
> > > A typical example of this pattern occurs in the BPF verifier,
> > > and the following is a related false positive report:
> > >
> > > [ 2206.486476] ==================================================================
> > > [ 2206.486509] BUG: KASAN: invalid-access in __memcpy+0xc/0x30
> > > [ 2206.486607] Write at addr f5ff800083765270 by task test_progs/205
> > > [ 2206.486664] Pointer tag: [f5], memory tag: [fe]
> > > [ 2206.486703]
> > > [ 2206.486745] CPU: 4 UID: 0 PID: 205 Comm: test_progs Tainted: G           OE       6.18.0-rc7+ #145 PREEMPT(full)
> > > [ 2206.486861] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> > > [ 2206.486897] Hardware name:  , BIOS
> > > [ 2206.486932] Call trace:
> > > [ 2206.486961]  show_stack+0x24/0x40 (C)
> > > [ 2206.487071]  __dump_stack+0x28/0x48
> > > [ 2206.487182]  dump_stack_lvl+0x7c/0xb0
> > > [ 2206.487293]  print_address_description+0x80/0x270
> > > [ 2206.487403]  print_report+0x94/0x100
> > > [ 2206.487505]  kasan_report+0xd8/0x150
> > > [ 2206.487606]  __do_kernel_fault+0x64/0x268
> > > [ 2206.487717]  do_bad_area+0x38/0x110
> > > [ 2206.487820]  do_tag_check_fault+0x38/0x60
> > > [ 2206.487936]  do_mem_abort+0x48/0xc8
> > > [ 2206.488042]  el1_abort+0x40/0x70
> > > [ 2206.488127]  el1h_64_sync_handler+0x50/0x118
> > > [ 2206.488217]  el1h_64_sync+0xa4/0xa8
> > > [ 2206.488303]  __memcpy+0xc/0x30 (P)
> > > [ 2206.488412]  do_misc_fixups+0x4f8/0x1950
> > > [ 2206.488528]  bpf_check+0x31c/0x840
> > > [ 2206.488638]  bpf_prog_load+0x58c/0x658
> > > [ 2206.488737]  __sys_bpf+0x364/0x488
> > > [ 2206.488833]  __arm64_sys_bpf+0x30/0x58
> > > [ 2206.488920]  invoke_syscall+0x68/0xe8
> > > [ 2206.489033]  el0_svc_common+0xb0/0xf8
> > > [ 2206.489143]  do_el0_svc+0x28/0x48
> > > [ 2206.489249]  el0_svc+0x40/0xe8
> > > [ 2206.489337]  el0t_64_sync_handler+0x84/0x140
> > > [ 2206.489427]  el0t_64_sync+0x1bc/0x1c0
> > >
> > > Here, 0xf5ff800083765000 is vmalloc()ed address for
> > > env->insn_aux_data with the size of 0x268.
> > > While this region is expanded size by 0x478 and initialise
> > > increased region to apply patched instructions,
> > > a false positive is triggered at the address 0xf5ff800083765270
> > > because __kasan_unpoison_vmalloc() with KASAN_VMALLOC_PROT_NORMAL flag only
> > > doesn't update the tag on increaed region.
> > >
> > > To address this, introduces KASAN_VMALLOC_EXPAND flag which
> > > is used to expand vmalloc()ed memory in range of real allocated size
> > > to update tag for increased region.
> >
> > Thanks.
> >
> > > Fixes: 23689e91fb22 ("kasan, vmalloc: add vmalloc tagging for HW_TAGS”)
> > > Cc: <stable@vger.kernel.org>
> >
> > Unfortunately this is changing the same code as "mm/kasan: fix
> > incorrect unpoisoning in vrealloc for KASAN",
> > (https://lkml.kernel.org/r/20251128111516.244497-1-jiayuan.chen@linux.dev)
> > which is also cc:stable.
> >
> > So could you please take a look at the code in mm.git's
> > mm-hotfixes-unstable branch
> > (git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm) and base the
> > fix upon that?  This way everything should merge and backport nicely.
>
> Thanks for sharing this :)
> But I think the patch from Jiayuan still has a problem
> since vrealloc() can pass the "unaligned address" with KASAN_GRANULE_SIZE
> and this will trigger WARN_ON() in kasan_unpoison().

Ah, I missed his patch change the pointer from p + old_size to p
for the kasan_unpoison_vrealloc().
Then the patch seems almost identical to fix the same problem.
So, you can drop my patch.

Sorry to make noise :\

[...]


--
Sincerely,
Yeoreum Yun

