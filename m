Return-Path: <bpf+bounces-76895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB348CC9497
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC7B33025703
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC5F316193;
	Wed, 17 Dec 2025 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="j8M+dOwO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="j8M+dOwO"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824C28D8D1;
	Wed, 17 Dec 2025 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765996002; cv=fail; b=Yaa0Btlm+TwQ9LRgxJnJLfIet6BA5BjVoMJPyc3keHnI6QE8tEnC5c4Ym7totxuXWJ4IBy+E6qUx2KslfMaatvdQR4foOBjtl+YSymC1jh09/8HbbFXsvRngyRd6AHy01U42PKRjbsWUYyXsVlxKhsnJ8VGNWOiZf/t89FU9aB4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765996002; c=relaxed/simple;
	bh=cx0S7AX8PULdij8AzAjEwaRPsKPoE5yJv/bOQjtB+jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VsKYHUIogdw/m0L2OHPYMPuUjKnhMTqwf7wXk8v61vbGDbWhXJlDbcnN34kXD5cFeceAq8EE74Z8l0raZmcfydJby7AjZjJbtCOS0s+LvUzgR5GZgn8jzegPcj2SReLwTScnSZ/hk1PHX4g+/O37tqHi7JYN5lifH4k222ZFiP8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=j8M+dOwO; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=j8M+dOwO; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Mgmi/iKrKp7B+fSdmZvQmT5y0zxcoT4ShiZGmyn2da98FUM6+MERjnbY1J894PXWbkjt6dyyN5w256UJosX+1uY0W2SgnWxBgu1zue8Pp616rWln7HigTeEmeA/NKixp+zAdF312qe1P68lh4Uleurjrx4ztTFeo/8c+7YWs9DyS9Z+E8CsNRvTjQ3MtyNSpg/JWwdor+UEaInjxGCK5r4TmSsFLXj3jbTlvqrZS5lLybmxqnNs93drhFnNVti6SXw9geX7IeK6zlPHmGvUpGFEdmjxJza7EtK09SRELNSpcz3CQWiLs3ABjQ/R6T4lR9IyBTSjg7I5vsBhcmwASJQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWrf2JbbUB+q7BaW/1/eqQQbG980fw1DmQ42lcnBCms=;
 b=dD5l9lHPCprLESCKuG6V83AcebasIzTodTzRb/ukjHllT3wu9dJUQKZbLbRtLPU34rjLUR6q93lxkqbECjeXPxQxC66rTQaubswyaukQL0SXUiobipm0s7Smq1gQxwAHbtjWQd8JbMYo05Ad2DScEDwFzECucShMdpiZ/kBE6y+BRXzyeAcbK7/7hZjPNPgJl7CRX04Ad865FUd0MSITJJkDR10ipoAbKaNCdCn4a4KH/22lEOi67rWLlsEV9L9Rn/YsR6aswtvq/DOCfKjAnygRjFGi1G4+sHWfcDKXVbPmC855tfCfXuW+jmEatXJMrOjTSQU4Mtlmzscz26QyFQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWrf2JbbUB+q7BaW/1/eqQQbG980fw1DmQ42lcnBCms=;
 b=j8M+dOwOHIEu8S2CD+c5EBPSWJTvv8Aqm03bQ4l/ZKavQ+PkYFxe+Pcbz33P7ARP/4g99j2wd0B7LmGdjN1xD70cm7nqK3i9inkORmUbSPAqNx1PAsWjFIXPYzOBHVLDBvbuR+M3efAAFmC44o8C4sTYfUn61GretsG1K0BRfik=
Received: from CWLP265CA0346.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::22)
 by GV1PR08MB10606.eurprd08.prod.outlook.com (2603:10a6:150:165::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 12:53:21 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:401:5a:cafe::a3) by CWLP265CA0346.outlook.office365.com
 (2603:10a6:401:5a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 12:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Wed, 17 Dec 2025 12:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ra3XL+a9ux3yuQ9qoXdv1jR6pe+sChgA665LtzScm90ZqCn8lRUtZnA3ryy8kQjJJn86tiowMNpuRVbwKyDb8JQhwkd348XTFyiUBKV5LJ/d283e+neKAXnXvY/YukARLkIjcGb89kXzMEDlBOYB2AgyjEUlEWGhwKHyPtmIY0GxGBMHPH6AI2zfDzVNSmEcxxOiSmEzHWPfg6tVTzYfTYi0KpdjynePlOH3RfeR+9GtgF0UgDgY/7vunQWunjUGNUmlTSElLZryIuoeJcqqKFZFs6i4dl3z3HVms6cAllvayj5YYfqznSfywmk+xV9G6OV8toSmeNKajuEW8Q5Krg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWrf2JbbUB+q7BaW/1/eqQQbG980fw1DmQ42lcnBCms=;
 b=mxcxDC4LPR7rTFtjb/uHOJo5Cs9qYVaLSCtBVNyoOB7SmEvGasMM74QKVYqfe/ofuwc3iAaUUU8vUbM15dgCDFhwDPH0dAAIGjtQ1mbi+R+Y5fXTAVY2mLtCw1ynM7/R3isNRBsgM5HH6Jid8rDtxjQraT2bZyvuormORoQfYhzrgSw7UwnHPOvGWpi4iANjB2XHGiPJzILI/VJSbG/NAR9Gp8nDwI155s7UmsbXH1t78I1RJkpZ59XPXnIZ54ATOfsYehy9Gtx3TTA5VTbuf1bGBB4n24ENlAK+FzM6beypoCnBhJxzzn/RhbxXUZJaOpSL+c+F5xX6hW0jlHNdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWrf2JbbUB+q7BaW/1/eqQQbG980fw1DmQ42lcnBCms=;
 b=j8M+dOwOHIEu8S2CD+c5EBPSWJTvv8Aqm03bQ4l/ZKavQ+PkYFxe+Pcbz33P7ARP/4g99j2wd0B7LmGdjN1xD70cm7nqK3i9inkORmUbSPAqNx1PAsWjFIXPYzOBHVLDBvbuR+M3efAAFmC44o8C4sTYfUn61GretsG1K0BRfik=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PA6PR08MB10441.eurprd08.prod.outlook.com
 (2603:10a6:102:3cb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 12:52:17 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 12:52:16 +0000
Date: Wed, 17 Dec 2025 12:52:13 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org, catalin.marinas@arm.com,
	will@kernel.org, kevin.brodsky@arm.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] introduce pagetable_alloc_nolock()
Message-ID: <aUKnfU/3FREY13g1@e129823.arm.com>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
 <aUGOPd7gNRf1xHEc@e129823.arm.com>
 <100cc8da-b826-4fc2-a624-746bf6fb049d@arm.com>
 <aUKKZR0u22KOPfd7@e129823.arm.com>
 <d96ac977-222e-4e8d-9487-da1306198419@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d96ac977-222e-4e8d-9487-da1306198419@arm.com>
X-ClientProxiedBy: LO4P123CA0240.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::11) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PA6PR08MB10441:EE_|AM4PEPF00027A69:EE_|GV1PR08MB10606:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa460f7-2298-4244-eba9-08de3d6b4178
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QkZjM3hTZUxCTEdWVWVXY1NFU204Yi9WMkE3d1R6NkFXMGdDdTgwWXR3Vk03?=
 =?utf-8?B?b0NETkg0MlRXbWFudVY5SXBqclR4SmdZZit6SUMwT3N2RjVGUXpQQ3BQbUhT?=
 =?utf-8?B?ODAzVk1XM1JOSGRBclZwQXNQNkc2bFVqWDAxMllrL01yeUxuS0RLMnJPMUJx?=
 =?utf-8?B?elNvdWVRclQ0djRZN2NQZmhXYWMra1RtUDBwNzBaemlMQ1VMKytZN0QwTkVn?=
 =?utf-8?B?cXh2NytYdUVrZ1ZZbEh0VXMvMkVSV0lLRWlnbkJrYVdmQmEyWDZPREpwbnlV?=
 =?utf-8?B?TTUxT1B2Vk13dEdZeDhVWVR1cVl3ekhuSmZjT05wSXI0ZC9RSEsreUlCZWhy?=
 =?utf-8?B?bFVlM2JMWi9ob25QZTRiODlIL1JlY3RLVzlXODl4Sy9LNzBxcUtaOVg3QStv?=
 =?utf-8?B?Mkh0c2loaUlTTXEwSXNvNXcxRWFvbXUwbDBIT29kZEpZOTRGaG9saWRSbFRY?=
 =?utf-8?B?ZUFxYVRSZ1R5TEhNUXUrNGZ2ZmVTMkUvWk82cHRGSGREWms2NXZyais2eTRJ?=
 =?utf-8?B?bzFacWFZbU42V0RQYks4U0lkZGN6T0dFZFFEM21YR051d3U3eGl3R0FwNHRx?=
 =?utf-8?B?RmNRTExOQVN2RS80bVdMeVp4WG4yT1B4Rk1rQzVuOHJoc29zSllyRzRuaFM0?=
 =?utf-8?B?T0c0TGR0VDNrT0VNRWZKd09ZV1NwVktpOFZJc21TdWM0RThUcCtSR0oxRzlT?=
 =?utf-8?B?VXk3Wk4wa1BRRC9VbFdoVGZtRkJrZFlVWkkxOUZwT1U2WWd3NnIyV01JYUFj?=
 =?utf-8?B?NGJoVUh5VmJlRVkrQkQyYTlvKzBQOEd0Q3RNdkJBS0U3MFlEVU1LcktIK2Zr?=
 =?utf-8?B?a2daOW92Yk9KUFJnRlZlZGRndXl0TkM3MGVzaFdEWTVHQmwvSnE2TkgrU0hk?=
 =?utf-8?B?SVE1aGhFbTYwNWtHRGQxZ1B6ZzZXNk9CMnpoZHJleHZaVlNFcmJMbldGYkli?=
 =?utf-8?B?UmZ4M09ybHFyMkRBNndRamNoYVc5RkduWmN1MlJPRjIvamdwT1pFOUNDcndn?=
 =?utf-8?B?RjJyVUNGclNqYk4rWWdPOXIzM1BlY1ViRFdLNlFLTEt2QTFZRkZpZ1FvREFO?=
 =?utf-8?B?RHJUemFIdmdxa2c3L095RkEydU8rUVBYQkNsTFdEQ2d1ZjJmM3pDS0dDRnpU?=
 =?utf-8?B?ZTV6Vy9jVU9ncVJJVmNvV2VxdFRCVVowNFF5TWZPVVRLcjF2U1lVbDBQc1Yx?=
 =?utf-8?B?cEpKdTAwMTcydk1XazU5QkJWMTlJVFgvYkN4UWdZZFN0ZndkMEZRd0NHbFhG?=
 =?utf-8?B?NEJYcG9OVVNCYlhpdEl1dnlOaWx2R2RDOGVaSFRyQ1A0YmU5bDVQWDd4czJO?=
 =?utf-8?B?dGFzRXlzdm1lU2diNFZtRmhOZlBJOWo3QjUva0JpZjNRWTlKR1BpYTZqL1Zp?=
 =?utf-8?B?d1pjU3RmVC9Td0FabEx6aytRMWZveUU0NlhoazVWVFRUcG55QVdrZGdLeXVs?=
 =?utf-8?B?aktmT1ZXUlJINTQwb09QYU9yQk9qVWxTbTNoTkNtYTRVNGdNaFFsL3VKdDZk?=
 =?utf-8?B?M1FZZjVuTVB3WW5xNGltei9iWUdOM3ZFR1p0Vkt3ZTBVK0NPY2JUVytRS0d1?=
 =?utf-8?B?OXJ5bjRtYk1tQlVDZGdiYUhYUDE2L3doTWpGTzVPT2VDN2M0TUFzSWNLM0xG?=
 =?utf-8?B?aEYvckRhVFY1VXdwZlhid0p3bHljN2FxcWNBWnBXNlRFNC9RV3lEbWhlMkU1?=
 =?utf-8?B?TXEwRUh3VVM5Q1paUEhqOURoTVY3R21lZVE2RFFlbHl4V0Z5VlBNNFFzaEJJ?=
 =?utf-8?B?cFlWVVlBNXZUeVBNY0VkcSsrY2FtalpEc3NkZms0bEw3MmUyeHUvYzdkM3Fa?=
 =?utf-8?B?dVBUbUxiTXR2NEZZTS9EeXR2WWxaa1lIaHZNK2N5QmpJV0p6aDBvUmFBWHc0?=
 =?utf-8?B?bWVQL09SVys1U0cydG1NN2FBTDVtMm1sWnRLUTVWRUxSOUs4NjF1TGM2QnBW?=
 =?utf-8?B?U2tFcm9jQ0wwcjFkUDFVRG5SYVdWTE1DNGRDZkVrc1o2c2lsemovOXpUc3Na?=
 =?utf-8?B?Z2dTR3I4dVlBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10441
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e6d28607-e089-46f3-a722-08de3d6b1b7b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|7416014|82310400026|1800799024|376014|36860700013|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGIzTWd0WnRCUHZRQURvemNDU1k3L3ArMkwrTVp0Z083ZG9QRVhjWUdlTUkr?=
 =?utf-8?B?WVIxOFkxWWlsdWxPQW5OcGdjUW8xb21oUjNHaENuYW4vNEJ1clViK3ViUnRH?=
 =?utf-8?B?bG9EbktybVB3STZFSWxGZTd2SXViaTVSdXBSODRWd25rYk00Y2dtTURmUDZH?=
 =?utf-8?B?WGkvL2pYbEgvVE9Dd2VUdmRHRGZhcTUvVDVTcTRiK25oanBJbDE0NkEra2FC?=
 =?utf-8?B?emxpc1ZQdnNaVFA4a25NNXZiZnhyWlVaMmQ4dVlUb0ZrQ1lCMlN2eFNZVExm?=
 =?utf-8?B?YjN0TUg1NE5UNG1yMGRucmVtanVPQ2cxREhFdEdWVW10TDJodXdhSlB4RTF1?=
 =?utf-8?B?OXlFcUYwMTRNWjFNaHQ3MCt0RU1LL0dYcGdYU0hOOGpJcFFYa2FFY29qTTNK?=
 =?utf-8?B?cUs2WTBVZTExN2NrUzJyVUZOT2w5UXZhOUtya0p5NWk5R1ZKaFhpMTlsSUhZ?=
 =?utf-8?B?THp6RzljaitCL3lJbE82WjJUTkFlSk5Sb0g4K1FBcDhtOXVuN0J1aFJYVkcr?=
 =?utf-8?B?V1VCOE9WR1Nyc1AxeU9lNytkdTFscU8xSWhKdW1vcW9wZDhtTXQxNjVRUTdp?=
 =?utf-8?B?d0V0emplTDZjT3BUamVGbjJVaVVtSFhQOVNDSW9nV2RsY3ltQTNlSDhVT3cw?=
 =?utf-8?B?K2pPcnloMmV6ZjJjam9abVl5aE42b1MxTXQ5Z0lBb2FMQXJva0VDbGdPdW5z?=
 =?utf-8?B?YVI2dFFPeWt6U05RakxoZEJjUlJLYkZXVklBYnVNRlBEU1R6ZjU1UmNvYUVO?=
 =?utf-8?B?NFl6M01EbmVpbFRFZ1plV21RaThNdlpuT05MRXJmUkt4VEpVMTcxRUVlNWds?=
 =?utf-8?B?ak9WeUZ1RHQvYW5oTnZBaEY0WUtwQnA1TWZUZ2RGcHlHZEREdkc0NjJrNWN2?=
 =?utf-8?B?cEo1MkhsTWt2aFFPOUFEYkx1Wk1scE5hdGkwSFptOUlaaWZUQzdrZWlZYjk5?=
 =?utf-8?B?aFdYUmg4ZjNBVTdnaXRNRThTZTU1c0REV2d3SDA0ejJTZzBhTnpKSjVmcjcy?=
 =?utf-8?B?TkduazFDemJyUk95VmdLSERraDlDZ3p1a2JkZkdtU0lYYURqZnZJdytqQVVE?=
 =?utf-8?B?YkNmYTVwcnNMcFlnUjB5Q2doKzhnTnB3c2g2eUxlOE05M2hYM2U1dml2WHp6?=
 =?utf-8?B?alhqNnNiZ2VxVWxIZThONHBHNWhhNGYzK0dtYjhzU04xRC9mZlVGSHh1bDA4?=
 =?utf-8?B?a0pjK2lBWkU1Wmtsb2RtTHYvRkFleE80ZlNKR25GZEttZTQxalNzd3czTEpR?=
 =?utf-8?B?Uk5lMldVbFNpYW56NkJKakZieWsyRFR5R1hXSG1iL0xZd0NSU3dOQ0U0TWdU?=
 =?utf-8?B?UHdWd2ZYTzRvRTdaaHdIM3ZSYkpjc004Qk1BcW9FTFRnM1puaVBZSDRGZXIr?=
 =?utf-8?B?U2tkVk1sZ0oyNDNKWEtGTmdYTjJCMXZOVnZyYXhsbzhYckRpbyszZ3hVRXJp?=
 =?utf-8?B?MFh3OEJ4T25jRmxwUlk5cmIwZzlYd29ZdVo3SHpDRWw3U0ZjaHY2WDVJMVh2?=
 =?utf-8?B?U0RBYXlSd0ovNG0zc3pidkd0ZGVjQW9mbms2NkQ1eUJHRVk0RnNhdGh1Y0ZH?=
 =?utf-8?B?WDgrbXd1VEl6RE1VcTZWUEVDUGh5bEh6aittbUo1MnFWdm9pbTgzNUI1V0Uy?=
 =?utf-8?B?SUJ2a2lONUJMSTdMbTVIaEVSbUFSUUM1Y1R4ZlhkTTFaeFY2eS9CbzlGU1ht?=
 =?utf-8?B?MEEyQm96cVJid25KNWE4L2dXcE83b0ZRVGpYTnA5NHBWZGlLaXd1UzRablV4?=
 =?utf-8?B?Z21nSkhFUFBoNkNqZUpOSWpxa0R0SWdLU2hITEdlZC91TDBKTWFsdy9pZElH?=
 =?utf-8?B?QllTdTd1THUvRXA3VU8zUzNVcm5vdGNHZlBEV2VEUDJwUlcvajZRK3pBeUYw?=
 =?utf-8?B?VlhzM056YWRSeGlxUFpsSnJKdzhONTEzVks2Q1JYM0g1YmJmRWk0NEQwQ255?=
 =?utf-8?B?UWJ3bnRLUFIzeGJYbGFvenA4cHM5VzBNMkJIK29yR2hGM09BdnJld3lBMTRh?=
 =?utf-8?B?QU1RVVloQTZWWG5zU09tNDlvMXVxakpEKzlwOXdTMGlWSi9WQUR1c2djbjcx?=
 =?utf-8?B?Mm5CYk44SWVnSzFDUTFaYjdGU1lIdUh4L3g4am9QVnEwL2ptQ0ZQOHJmb2cx?=
 =?utf-8?Q?t5T8gV6V+DR3ZzYSyw7L/p3N7?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(7416014)(82310400026)(1800799024)(376014)(36860700013)(35042699022)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 12:53:20.1738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa460f7-2298-4244-eba9-08de3d6b4178
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10606

> On 17/12/2025 10:48, Yeoreum Yun wrote:
> > Hi Ryan,
> >
> >> On 16/12/2025 16:52, Yeoreum Yun wrote:
> >>> Hi Ryan,
> >>>
> >>>> On 12/12/2025 16:18, Yeoreum Yun wrote:
> >>>>> Some architectures invoke pagetable_alloc() or __get_free_pages()
> >>>>> with preemption disabled.
> >>>>> For example, in arm64, linear_map_split_to_ptes() calls pagetable_alloc()
> >>>>> while spliting block entry to ptes and __kpti_install_ng_mappings()
> >>>>> calls __get_free_pages() to create kpti pagetable.
> >>>>>
> >>>>> Under PREEMPT_RT, calling pagetable_alloc() with
> >>>>> preemption disabled is not allowed, because it may acquire
> >>>>> a spin lock that becomes sleepable on RT, potentially
> >>>>> causing a sleep during page allocation.
> >>>>>
> >>>>> Since above two functions is called as callback of stop_machine()
> >>>>> where its callback is called in preemption disabled,
> >>>>> They could make a potential problem. (sleeping in preemption disabled).
> >>>>>
> >>>>> To address this, introduce pagetable_alloc_nolock() API.
> >>>>
> >>>> I don't really understand what the problem is that you're trying to fix. As I
> >>>> see it, there are 2 call sites in arm64 arch code that are calling into the page
> >>>> allocator from stop_machine() - one via via pagetable_alloc() and another via
> >>>> __get_free_pages(). But both of those calls are passing in GFP_ATOMIC. It was my
> >>>> understanding that the page allocator would ensure it never sleeps when
> >>>> GFP_ATOMIC is passed in, (even for PREEMPT_RT)?
> >>>
> >>> Although GFP_ATOMIC is specify, it only affects of "water mark" of the
> >>> page with __GFP_HIGH. and to get a page, it must grab the lock --
> >>> zone->lock or pcp_lock in the rmqueue().
> >>>
> >>> This zone->lock and pcp_lock is spin_lock and it's a sleepable in
> >>> PREEMPT_RT that's why the memory allocation/free using general API
> >>> except nolock() version couldn't be called since
> >>> if "contention" happens they'll sleep while waiting to get the lock.
> >>>
> >>> The reason why "nolock()" can use, it always uses "trylock" with
> >>> ALLOC_TRYLOCK flags. otherwise GFP_ATOMIC also can be sleepable in
> >>> PREEMPT_RT.
> >>>
> >>>>
> >>>> What is the actual symptom you are seeing?
> >>>
> >>> Since the place where called while smp_cpus_done() and there seems no
> >>> contention, there seems no problem. However as I mention in another
> >>> thread
> >>> (https://lore.kernel.org/all/aT%2FdrjN1BkvyAGoi@e129823.arm.com/),
> >>> This gives a the false impression --
> >>> GFP_ATOMIC are “safe to use in preemption disabled”
> >>> even though they are not in PREEMPT_RT case, I've changed it.
> >>>
> >>>>
> >>>> If the page allocator is somehow ignoring the GFP_ATOMIC request for PREEMPT_RT,
> >>>> then isn't that a bug in the page allocator? I'm not sure why you would change
> >>>> the callsites? Can't you just change the page allocator based on GFP_ATOMIC?
> >>>
> >>> It doesn't ignore the GFP_ATOMIC feature:
> >>>   - __GFP_HIGH: use water mark till min reserved
> >>>   - __GFP_KSWAPD_RECLAIM: wake up kswapd if reclaim required.
> >>>
> >>> But, it's a restriction -- "page allocation / free" API cannot be called
> >>> in preempt-disabled context at PREEMPT_RT.
> >>>
> >>> That's why I think it's wrong usage not a page allocator bug.
> >>
> >> I've taken a look at this and I agree with your analysis. Thanks for explaining.
> >>
> >> Looking at other stop_machine() callbacks, there are some that call printk() and
> >> I would assume that spinlocks could be taken there which may present the same
> >> kind of issue or PREEMPT_RT? (I'm guessing). I don't see any others that attempt
> >> to allocate memory though.
> >
> > IIRC, there was a problem related for printk while try to grab
> > pl011_console related lock (spin_lock) while holding
> > console_lock(raw_spin_lock) in v6.10.0-rc7 at rpi5:
> >
> >     [  230.381263] CPU: 2 PID: 5574 Comm: syz.4.1695 Not tainted 6.10.0-rc7-01903-g52828ea60dfd #3
> >     [  230.381479] Hardware name: linux,dummy-virt (DT)
> >     [  230.381565] Call trace:
> >     [  230.381607]  dump_backtrace+0x318/0x348
> >     [  230.381727]  show_stack+0x4c/0x80
> >     [  230.381875]  dump_stack_lvl+0x214/0x328
> >     [  230.382159]  dump_stack+0x3c/0x58
> >     [  230.382456]  __lock_acquire+0x4398/0x4720
> >     [  230.382683]  lock_acquire+0x648/0xb70
> >     [  230.382928]  _raw_spin_lock_irqsave+0x138/0x240
> >     [  230.383121]  pl011_console_write+0x240/0x8a0
> >     [  230.383356]  console_flush_all+0x708/0x1368
> >     [  230.383571]  console_unlock+0x180/0x440
> >     [  230.383742]  vprintk_emit+0x1f8/0x9d0
> >     [  230.383832]  vprintk_default+0x64/0x90
> >     [  230.383914]  vprintk+0x2d0/0x400
> >     [  230.383971]  _printk+0xdc/0x128
> >     [  230.384229]  hrtimer_interrupt+0x8f0/0x920
> >     [  230.384414]  arch_timer_handler_virt+0xc0/0x100
> >     [  230.384812]  handle_percpu_devid_irq+0x20c/0x4e0
> >     [  230.385053]  generic_handle_domain_irq+0xc0/0x120
> >     [  230.385367]  gic_handle_irq+0x88/0x360
> >     [  230.385559]  call_on_irq_stack+0x24/0x70
> >     [  230.385801]  do_interrupt_handler+0xf8/0x200
> >     [  230.386092]  el1_interrupt+0x68/0xc0
> >     [  230.386434]  el1h_64_irq_handler+0x18/0x28
> >     [  230.386716]  el1h_64_irq+0x64/0x68
> >     [  230.386853]  __sanitizer_cov_trace_const_cmp2+0x30/0x68
> >     [  230.387026]  alloc_pages_mpol_noprof+0x170/0x698
> >     [  230.387309]  vma_alloc_folio_noprof+0x128/0x2a8
> >     [  230.387610]  vma_alloc_zeroed_movable_folio+0xa0/0xe0
> >     [  230.387822]  folio_prealloc+0x5c/0x280
> >     [  230.388008]  do_wp_page+0xc30/0x3bc0
> >     [  230.388206]  __handle_mm_fault+0xdb8/0x2ba0
> >     [  230.388448]  handle_mm_fault+0x194/0x8a8
> >     [  230.388676]  do_page_fault+0x6bc/0x1030
> >     [  230.388924]  do_mem_abort+0x8c/0x240
> >     [  230.389056]  el0_da+0xf0/0x3f8
> >     [  230.389178]  el0t_64_sync_handler+0xb4/0x130
> >     [  230.389452]  el0t_64_sync+0x190/0x198
> >
> > But this problem is gone when I try with some of patches in rt-tree
> > related for printk which are merged in current tree
> > (https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/log/?h=linux-6.10.y-rt-rebase).
> >
> > So I think printk() wouldn't be a problem.
> >
> >>
> >> Anyway, to fix the 2 arm64 callsites, I see 2 possible approaches:
> >>
> >> - Call the nolock variant (as you are doing). But that would just convert a
> >> deadlock to a panic; if the lock is held when stop_machine() runs, without your
> >> change, we now have a deadlock due to waiting on the lock inside stop_machine().
> >> With your change, we notice the lock is already taken and panic. I guess it is
> >> marginally better, but not by much. Certainly I would just _always_ call the
> >> nolock variant regardless of PREEMPT_RT if we take this route; For !PREEMPT_RT,
> >> the lock is guarranteed to be free so nolock will always succeed.
> >>
> >> - Preallocate the memory before entering stop_machine(). I think this would be
> >> much more robust. For kpti_install_ng_mappings() I think you could hoist the
> >> allocation/free out of stop_machine() and pass the pointer in pretty easily. For
> >> linear_map_split_to_ptes() its a bit more complex; Perhaps, we need to walk the
> >> pgtable to figure out how much to preallocate, allocate it, then set it up as a
> >> special allocator, wrapped by an allocation function and modify the callchain to
> >> take a callback function instead of gfp flags.
> >>
> >> What do you think?
> >
> > Definitely, second suggestoin is much better.
> > My question is whether *memory contention* really happen in the point
> > both functions are called.
>
> My guess would be that it's unlikely, but not impossible. The secondary CPUs are
> up, and presumably running their idle thread. I think various power management
> things can be plugged into the idle thread; if so, then I guess it's possible
> that the CPU could be running some hook as part of a power state transition, and
> that could be dynamically allocating memory? That's all just a guess though; I
> don't know the details of that part of the system.
>
> >
> > Above two functions are called as last step of "smp_init()" -- smp_cpus_done().
> > If we can be sure, I think we don't need to go to complex way and
> > I believe the reason why we couldn't find out this problem,
> > even using GFP_ATOMIC in PREEMPT_RT since there was *no contection*
> > in this time of both functions are called.
> > > That's why I first try with the "simple way".
> >
> > What do you think?
>
> As far as linear_map_split_to_ptes() is concerned, it was implemented under the
> impression that doing allocation with GFP_ATOMIC was safe, even in
> stop_machine(). Given that's an incorrect assumption, I think we should fix it
> to pre-allocate outside of stop_machine() regardless of the likelihood of
> actually hitting the race.
>

Yeap. It’s better to be certain than uncertain. Thanks for checking.
I'll repsin with the preallocate way.

Thanks!

--
Sincerely,
Yeoreum Yun

