Return-Path: <bpf+bounces-77401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F724CDB8DF
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 08:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87651301A195
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 07:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE932AAA3;
	Wed, 24 Dec 2025 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JOBPy/dh";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JOBPy/dh"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D862F90C4;
	Wed, 24 Dec 2025 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766559722; cv=fail; b=AmJ+GxZbpvMZW/dr+7981YYLP1k0ZZvNDJtMfAiAYd8JTloM2j/bV4XB5uwEXUGFxO8Im4HI4FtC8gy9MrjJkLqi456VAFLvKYZuJ1HWZOoz6d/FVTTZbWZyHt0nEs15m/vdYAj6A1Jyphcbalxcf5T4l93cVFX85H2FuT06fT4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766559722; c=relaxed/simple;
	bh=7NpJdp3pnumefTMAOVtMp7X6VAVyVlyVMoeoJ9E0XPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NKMZw+XUDeiLCUa0exMIykixtHSFMkT2up9AHUIH8fnciB5/jHsq9tIsNb3GE0j9H72DoowQ6hzcXpvRLF4BCfApXUi/5elhcIXUGXu+sJizbDA7MvtdGp8sH/5k9wRfZIq5h04tVTC1TpoNjWsWE8rCmmvA/XpJPr/o+wsKK/c=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JOBPy/dh; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JOBPy/dh; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ne9LdqX/Qy4K9qvmPCCiiePGMXadFeKZx0nzCaY2r4r0cbjphT4ir83FKFBlFEN+b2r5dr8YAoixRKj5h8L9gyO+yTrThQVKRp8f8P3LpI1U7D2h6brPAY9YMETGvo8UmYxaj9ELpzwv3GUvtI2Q1rxTR/5cGvXGiai4FFP29rduoLahiEuvGaOgd6GNJddJG/I4bVVN5Qdf//buU3a6FfNid9aTO42hDP3GiAfCr6gK7kYKu0e4HMjjZiWd9rbdZ9oW6IlGfjkCJmLsN9mNNoC07HqRCU/GKlhBK+Zr4wHGsrNG/cYvk/3oMe6mjlUbZUPiA50C1aOIWNVG2CF8zg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdtOcLy53MUa4hx6b45uQGhnvH7xPvCX0Qhx+RtD9Yk=;
 b=ZcPuILBTP/nUel8W8IBHwGvPzXcwo2hrCV205avUQfNYN98u5P38xBv8EHgLeYZly7WcK0jiBy8/23IgnY42Bm8BbR7jU58ItpFUurPzsIgrjM4DymHdtrpm2zutoRC0mHS5YHp6w+VjDgw++8ywiDvxCQuv4qWz4mG+NQN7qTQOOEXeWhbAh0iK9YTuJl86lE77lB/ORwwjmd9CSshaBnR1eUSkzn/MSWk0SIdHd8SB5R++5t5sJuR7PnQwWGI/KukuLZe5crL5aYphkRkmBBP9iz3lI9zrM1u1snBgh3ngSra/LB5DziojdN3Vy/xeOd/eQ3URTKXQPkgGEPSSIg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=os.amperecomputing.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdtOcLy53MUa4hx6b45uQGhnvH7xPvCX0Qhx+RtD9Yk=;
 b=JOBPy/dh+W4JdXkZYVP1P3M/wk59BePcMPcTBQ8wcmDShhsxTQ/d0BRx2EkOVWFp33oXXCq+CaRA/p55iP6fI/8Vq1A6FM5yUyxQ1OfLdo+ihTOyK+MtL9XxsR/JKth2L1t41IEFiixvmlxf8cqKMCiPRqKlkt9CROeB9GKJCYQ=
Received: from DU2PR04CA0275.eurprd04.prod.outlook.com (2603:10a6:10:28c::10)
 by MRWPR08MB11236.eurprd08.prod.outlook.com (2603:10a6:501:74::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Wed, 24 Dec
 2025 07:01:44 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::9) by DU2PR04CA0275.outlook.office365.com
 (2603:10a6:10:28c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Wed,
 24 Dec 2025 07:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.9 via
 Frontend Transport; Wed, 24 Dec 2025 07:01:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6Z9ASQLJDp2P6J8aOwEt65wpf3g3ZgfA1RX2lKLmL8ZFsbCadnKm7r2YKCK4o3tCPQ/jelDxxfzgrBdwCTcfo+D14PHo0hx0hdhFiH9Di5yukCMIHRiD9OjC9hFV/ANGGZPYzO1dSoBHPI+yoA6CbNYB+XzMPHmLIfJcNTS2mB73j2nYZX+Y4gqvtXWAc8xyTXgeZk4THhKIunchEkhSMAmIwxbz6HW7bYAvrb/SUWQqodJeQnVFX9cg9FSOgdqePZwQyRfiR6U4FJP1KWfk4aAd3OYJMKa8USjyjUtyhlF/72t1A8boMprnbcAqt5tqo1TUe3kPhCqd/bDrlMn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdtOcLy53MUa4hx6b45uQGhnvH7xPvCX0Qhx+RtD9Yk=;
 b=i4SmoOTkOYSr8r0PUDdXEBlpRTRY81i84MPY2CCMgPvFVsXjXF5eWXVP7aVD7mD3GbBWIzOBqcO/bN9UQjCdqeU4S6J8Cs3hOfUVpnMVqtjc0FT0zUGrdXaDJTjo+Rp8uKfMFvTZ/Pm/ZXkIu92I30P1ObKOK7w6yZKeL/78W+vnrg9ug7wz5d0IJosH5kqf4fIlB5Md3i2bDYVbeeq0LnAeHSSSfG5DtiN1YN/gP+qnzp0rNZIzPbzgkhbudfJyk5MYpFWgVeScedG02Z3ObpbwROR6wCEG5wwbQ/XIgQ8DMFP9WF54rOakIECyrWdv5q+eWAs+fwclAdq1BlTffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdtOcLy53MUa4hx6b45uQGhnvH7xPvCX0Qhx+RtD9Yk=;
 b=JOBPy/dh+W4JdXkZYVP1P3M/wk59BePcMPcTBQ8wcmDShhsxTQ/d0BRx2EkOVWFp33oXXCq+CaRA/p55iP6fI/8Vq1A6FM5yUyxQ1OfLdo+ihTOyK+MtL9XxsR/JKth2L1t41IEFiixvmlxf8cqKMCiPRqKlkt9CROeB9GKJCYQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB9PR08MB6555.eurprd08.prod.outlook.com
 (2603:10a6:10:257::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 07:00:39 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 07:00:39 +0000
Date: Wed, 24 Dec 2025 07:00:35 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org, catalin.marinas@arm.com,
	will@kernel.org, kevin.brodsky@arm.com, dev.jain@arm.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] introduce pagetable_alloc_nolock()
Message-ID: <aUuPk6fj1wUPfypI@e129823.arm.com>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
 <aUGOPd7gNRf1xHEc@e129823.arm.com>
 <100cc8da-b826-4fc2-a624-746bf6fb049d@arm.com>
 <aUKKZR0u22KOPfd7@e129823.arm.com>
 <d96ac977-222e-4e8d-9487-da1306198419@arm.com>
 <93327680-7d7d-415e-958b-0d2a667dbb52@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93327680-7d7d-415e-958b-0d2a667dbb52@os.amperecomputing.com>
X-ClientProxiedBy: LO4P123CA0269.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::22) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB9PR08MB6555:EE_|DU6PEPF00009528:EE_|MRWPR08MB11236:EE_
X-MS-Office365-Filtering-Correlation-Id: 849fa4fe-87c4-4a31-4449-08de42ba4b7b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?OFA0bSt5U29JOWFNZXl3MC96WXVWRHJ5bjQ2TTBWMTdQU2dpSVZTQmhTY3F1?=
 =?utf-8?B?MS9TTW5rRVBndEdvWW93K3FaMHNRU3BOQkd6THBIZFNJemVwS2N2cTB0dHVZ?=
 =?utf-8?B?RFRkZ01yUjVRUTJGOGRzMzdOWXlacWhGSlozbEJacDhaSUZ4QWY0UDFWa25R?=
 =?utf-8?B?RGcrL0NRUHRtdlRjNHJwWWRBY2RiN0xITU9NK3BRZzVvVFUzdTBjZTAxbnl5?=
 =?utf-8?B?ZDlOSU9IbEFXM3VRb3VNeHdEV1JlT2YrUnRLMDlaWm40L3E0aTY3VG0xR1Ez?=
 =?utf-8?B?akJxRnhWRk83T3hQRzltcDhqamgxZVZNN0JpL3hmVmtIRmRuTkpIQVRPZzlS?=
 =?utf-8?B?Z1pncWFjYllJN21XMWZKOW4zR3M2NUU5SFZKV0dXZHVKMzVQZmJKdFBLOWd1?=
 =?utf-8?B?T0NBWjAvK3ZSWUF1NmJEMjNqMEhrMVk5VmtuVTgzRTBCclFOS1prN2VWc285?=
 =?utf-8?B?emZqN1RKOTM3U25uOHdtNDRrNDVJWVBmcm10VXZMMzdrZmVCem1FZThMMEVH?=
 =?utf-8?B?NGhObm94WmZKVDl2UXMyS204YWppbWkvTmJSZUhESnIxeGlBL3pJdlcwak5J?=
 =?utf-8?B?cWRuUUtoUjRWcEJmMG91ZFJreXhLVFpndWErYVlDQjV6TlYyYm1pL2IrNjFR?=
 =?utf-8?B?RWdTWW8zVWxucTgzd3BMd1hXa0JKb1VnVVh6ekYyOURDZ0lsOE5LVVhhRWZT?=
 =?utf-8?B?VHZFbDVDbWhNRVpyN0RpaWRSNzJYRUZHbnpEUWFDWWk1VzdlQ3ZWY0ZMSjM5?=
 =?utf-8?B?WFhCM3VNNnV3SEVZYm00aE5vWlFzei9oTTgvMVRlODBwcFgwV2pxaENQYjR3?=
 =?utf-8?B?S1NRNjcxUkhUZHRYQzBCNzlLNGtIRSt6bXd4QldyQlVuOTZhRVdaZFNPOC91?=
 =?utf-8?B?Y21oc1JWUFdMRjZydWttN1R6anV5d0FDRlY3Z3AzZDgvQlB2Z1lLaCtWeWI0?=
 =?utf-8?B?MktFZlBKQWZrVXB2WVFpSFlxSjBRWlVLWVlqWTYvejBDeWpTS3lWZGU4Mkxq?=
 =?utf-8?B?dXRpdjdLVzJaZjliQW13anBHTWQ1aUlNVTMxTW1vc0Q3SUFnbmF6MXJzTGE4?=
 =?utf-8?B?d0lRMjVTVngzSG91Wm14MGR3akdsMjFaNW1laW5JNTVwZHJDMWtaMnMwcXJT?=
 =?utf-8?B?NjF6VW91clQ1aGxHSHBhamlWR29ESytQUm5STUZHTnkvWXk1Y0VrdGFwWkgw?=
 =?utf-8?B?cDBLcGtkUjdPVEI5RUtwbldmNzRZSTIrUE5KdjB2KzYzUk1kbnlTWWdzOElQ?=
 =?utf-8?B?cmh1TldrMm91K1VEZVNyTExBeFpmUkpDaXVhcHJUbjAzejMvV01NQmYvdTRj?=
 =?utf-8?B?V1FXL3FrNFlWNysxOEdKMnd4VDlhSmxsMXpsM09ENWVWcVMvaXBKZFRLNXFz?=
 =?utf-8?B?eHZXV1ZYdXV1aGE2Z3NtR1N4YjA2a3dDMkdjVlBXVnJ0SjVWSEVlSkVCUUk5?=
 =?utf-8?B?VmR2Tmp5SkJOVkF2MXBuZU83VFNrWE9KeGtadVJIZmxZcUlPSnpGTmxYSGJZ?=
 =?utf-8?B?amtqWWxQYldWWjdnMUZxMWtsYmlKVDVNQ3Vmb2tLeGxaelRDNXZOeEZ1RzZl?=
 =?utf-8?B?UzRhallRMXNoQnRTVi84OG9LZDlVSjV2N0NOczNBMFZBM0MzRlVxQ3M3ajdN?=
 =?utf-8?B?WWsxR3p3dzZkZjhHU1ErVXlHbWZlS0xDenFDdnRHY3dkbGZQUjhZRklFMmtZ?=
 =?utf-8?B?VWZTblJ2dWZadi9wYkt4STBLRm9wRDRBNjRlRXFQbmJsRDlyZXFqTHRwQ0NO?=
 =?utf-8?B?SnZZT0d4dGhKVW5CRzRxZytoWFFYRXdpd2VLRTlUam5iSXJhL09jK1VqRVNo?=
 =?utf-8?B?V050YWN4MUdvRy9LT1R3NlFSbW82WTR1cFEzeHRRRFZZa0UvQVpjT242ZlVE?=
 =?utf-8?B?NWhRZTl2b3RxT0dNKzluMXArb0ZvdjBOeU94REp1alJ4T1hFMzFFeFN1OHBG?=
 =?utf-8?B?WVk2L3FjeFg2SEc3RkhxWWY5ZHJvY2dhc25aNlJUYml1Tjk0L2FWY2VCdCs3?=
 =?utf-8?B?WXhMRW5YbFVBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6555
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8b60c035-0d21-48a6-b2b7-08de42ba2558
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|14060799003|1800799024|35042699022|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckE2YWRDbW1OMnNCQnVzNldkb3VucHZGTjZZTjkxbE1xZi94RTA0NktOTHAv?=
 =?utf-8?B?OUtVZGZDdmd2bjhLV0xuUnkzZW01NlM5MTlPb09rT1V6RElQa0NsNHd6UU9E?=
 =?utf-8?B?bTdpeVJjYmtwSi9zMzhaRXdOaEtJVEtNVDNFOHhUZ0dSRi9uTktaZ0FhQjU2?=
 =?utf-8?B?em1TazZSbWJwWEZPcFhoQ29tbS8waVUxYTk0VVlEZ1dIUUFpbThwdkJKYnR2?=
 =?utf-8?B?bmVwY0VSMlhDRjAvOGIwaTBlN3hlSDdtSUhDcWZuR3FBK3gvU1dKSm5HZTVZ?=
 =?utf-8?B?S1BnU3luckFwWnV0VXRQTjFtTVNsUlBGbGNZSHVDV0VnOGN5cG82UGMzT1NM?=
 =?utf-8?B?UGJ4dVp5RS9IVzk3VjVYeERRQmx3eCtwYXpPUnEyTkNBVkhSVkw4Q1NDTmlt?=
 =?utf-8?B?SE9HQkxNKys1QWJsMlpqUlVXVG1wQkJMR21EdG5BOVcyWTJIYitRZGVFSWRW?=
 =?utf-8?B?aHdKeDVRM2hhQXluVnI5eitGWUUzUUtzTEpEMTh1Vm1jV0k3RlIrUEphWVlX?=
 =?utf-8?B?Y3N6ZTFGTnRMQ1VyMWEvMkNyTFh6VGhobS83LzZMOWQvNEUyLzhPU0hEQW5W?=
 =?utf-8?B?amx1b09LNHk5V1IyQWMyWUh6Q3crbS9WQ0JUZGJJUVNoaEsvV252OEpCM2NE?=
 =?utf-8?B?MDVyOE5RN0s5M1huYm5CY281VkZvTnppQmcwNi85ZVNXTlQ0WWlpN3NMcmJW?=
 =?utf-8?B?akJWMEoxS3gxSFBVQnQ5cDNLK205SXNodE11aEtzek53eWd2aDdvK2ZJM2Na?=
 =?utf-8?B?VWJjTXdiaFp4dzAzR2pjUURtNGdwZCtlczRGYlRoVHJ4R0R2cHdrZldheWZq?=
 =?utf-8?B?SUR1NFV3V3dxMUIwYlYwdUNwODZ1Yk9uRFRjcEw1VnUwYnEzRzZEUHpScnBG?=
 =?utf-8?B?L0pnQ2dGZjN6dUYxQXVWMWFGMEFRVDhOZXo4N0ZmUE92T2FTbDQ2MXZmenFv?=
 =?utf-8?B?emhaLzZOVFlxb25nRFJzQWZOd2I5Y0p1SXRUV3lkTGFnVEhVUHpsdEU1Z2t4?=
 =?utf-8?B?STVGcnJJUWVPdy83VFc1ZStIdzVNNlIvaVpIMERSQVpNWGpFOWx1eEJyNzA1?=
 =?utf-8?B?THdCdHA1QjdLaS9jREczNGNiM0dvZ3ZVK2tKeFIzNE5kazQzMkpWNVo1SjBP?=
 =?utf-8?B?UmdXdXlLZThxM3FvSDBSZVgrVVRFOCswaVpucVBUck1sbENCV0hvVmtSR1Jk?=
 =?utf-8?B?bnNlSVFndng0WmlqVm5ZeXJQMFV3VWhSeWl4NVZ5OGYvcEJRc0FJSEZWNXhW?=
 =?utf-8?B?M2hncVhXNnJCT0x6TmdjUjJnZW1oRDRBQnVpcFlEQ24yQUcrWGs0QXlJb1do?=
 =?utf-8?B?OTVIRStWc21oUFVGRnBWVWdsbHYzWHRhczlIaFl4dFFqa2M5d2YxeFRzUTlH?=
 =?utf-8?B?R2hKcmlsYlhlUDhFWVVHVkhaaytrMWNMTCtORXdPeTJ5eTMvNm1OYWRKTnRm?=
 =?utf-8?B?YlZXaGp6dWhUcHJBTzFtY09ueWpqY2ZlZkdMRFQxc1p1Z1dJL3pMRkJlRkZO?=
 =?utf-8?B?eDl6TzNweGZ2c2ZMTFZhMitjMG0zWGp0RGVEZEhpZWFNUGwyaGJyL2RucHc0?=
 =?utf-8?B?RXhUTkxXNXJOcER6b1J4N2RkSTVrVkpQTml2QTZJOUJ5bFFDQWlzOG1mLzF1?=
 =?utf-8?B?K2ZWa25KQ0hyYWIya2xBTVJuTTdCS2N2eUFiVlFQRXdIOTlZMTJmbjFCemQr?=
 =?utf-8?B?OHZYRWJzRDVCOFFwc3p0a3Q4VEZkUDdFeW5vOHM5TDdLSkdWNWNta0JXMXBB?=
 =?utf-8?B?SlQyTU1RcFErUDlNT0ZVWkEyZFpsOExPKy9wZ0VJeTBydlBmTWxmQzBLZkdl?=
 =?utf-8?B?NjBXTHYvR2hXalhsTFBIVllXR2FIVXo0cENCdVJndWxQYk45Tk9JeUIvZVov?=
 =?utf-8?B?UFFLUDdFTnc1b0tSaWhvYXpBQzJ3Zk1JMHVtWTZmSWduaVpGVy9Mb3lya3pC?=
 =?utf-8?B?VktGSXZjZ1pqK0g4ZnZ2OWxBb3RaTXNFVHpESGRBdmk3aUxZM0Y0aEhkME80?=
 =?utf-8?B?U25NbVdEZ1JEVDZBUVdaalNEYlFCQndzQ1dhSHNBZFBIWFBCUG04aEdFWTRy?=
 =?utf-8?B?dlovMXhkV3h0WXo5a0FJeWVGRitmN0xpL21FZmRhK2ZHdkhrbTE2TG9hcENF?=
 =?utf-8?Q?IyFsSBR2BfKtFMab2ep7A69Je?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(14060799003)(1800799024)(35042699022)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 07:01:43.0181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 849fa4fe-87c4-4a31-4449-08de42ba4b7b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11236

Hi Yang,

> On 12/17/25 9:04 PM, Ryan Roberts wrote:
> > On 17/12/2025 10:48, Yeoreum Yun wrote:
> > > Hi Ryan,
> > >
> > > > On 16/12/2025 16:52, Yeoreum Yun wrote:
> > > > > Hi Ryan,
> > > > >
> > > > > > On 12/12/2025 16:18, Yeoreum Yun wrote:
> > > > > > > Some architectures invoke pagetable_alloc() or __get_free_pages()
> > > > > > > with preemption disabled.
> > > > > > > For example, in arm64, linear_map_split_to_ptes() calls pagetable_alloc()
> > > > > > > while spliting block entry to ptes and __kpti_install_ng_mappings()
> > > > > > > calls __get_free_pages() to create kpti pagetable.
> > > > > > >
> > > > > > > Under PREEMPT_RT, calling pagetable_alloc() with
> > > > > > > preemption disabled is not allowed, because it may acquire
> > > > > > > a spin lock that becomes sleepable on RT, potentially
> > > > > > > causing a sleep during page allocation.
> > > > > > >
> > > > > > > Since above two functions is called as callback of stop_machine()
> > > > > > > where its callback is called in preemption disabled,
> > > > > > > They could make a potential problem. (sleeping in preemption disabled).
> > > > > > >
> > > > > > > To address this, introduce pagetable_alloc_nolock() API.
> > > > > > I don't really understand what the problem is that you're trying to fix. As I
> > > > > > see it, there are 2 call sites in arm64 arch code that are calling into the page
> > > > > > allocator from stop_machine() - one via via pagetable_alloc() and another via
> > > > > > __get_free_pages(). But both of those calls are passing in GFP_ATOMIC. It was my
> > > > > > understanding that the page allocator would ensure it never sleeps when
> > > > > > GFP_ATOMIC is passed in, (even for PREEMPT_RT)?
> > > > > Although GFP_ATOMIC is specify, it only affects of "water mark" of the
> > > > > page with __GFP_HIGH. and to get a page, it must grab the lock --
> > > > > zone->lock or pcp_lock in the rmqueue().
> > > > >
> > > > > This zone->lock and pcp_lock is spin_lock and it's a sleepable in
> > > > > PREEMPT_RT that's why the memory allocation/free using general API
> > > > > except nolock() version couldn't be called since
> > > > > if "contention" happens they'll sleep while waiting to get the lock.
> > > > >
> > > > > The reason why "nolock()" can use, it always uses "trylock" with
> > > > > ALLOC_TRYLOCK flags. otherwise GFP_ATOMIC also can be sleepable in
> > > > > PREEMPT_RT.
> > > > >
> > > > > > What is the actual symptom you are seeing?
> > > > > Since the place where called while smp_cpus_done() and there seems no
> > > > > contention, there seems no problem. However as I mention in another
> > > > > thread
> > > > > (https://lore.kernel.org/all/aT%2FdrjN1BkvyAGoi@e129823.arm.com/),
> > > > > This gives a the false impression --
> > > > > GFP_ATOMIC are “safe to use in preemption disabled”
> > > > > even though they are not in PREEMPT_RT case, I've changed it.
> > > > >
> > > > > > If the page allocator is somehow ignoring the GFP_ATOMIC request for PREEMPT_RT,
> > > > > > then isn't that a bug in the page allocator? I'm not sure why you would change
> > > > > > the callsites? Can't you just change the page allocator based on GFP_ATOMIC?
> > > > > It doesn't ignore the GFP_ATOMIC feature:
> > > > >    - __GFP_HIGH: use water mark till min reserved
> > > > >    - __GFP_KSWAPD_RECLAIM: wake up kswapd if reclaim required.
> > > > >
> > > > > But, it's a restriction -- "page allocation / free" API cannot be called
> > > > > in preempt-disabled context at PREEMPT_RT.
> > > > >
> > > > > That's why I think it's wrong usage not a page allocator bug.
> > > > I've taken a look at this and I agree with your analysis. Thanks for explaining.
> > > >
> > > > Looking at other stop_machine() callbacks, there are some that call printk() and
> > > > I would assume that spinlocks could be taken there which may present the same
> > > > kind of issue or PREEMPT_RT? (I'm guessing). I don't see any others that attempt
> > > > to allocate memory though.
> > > IIRC, there was a problem related for printk while try to grab
> > > pl011_console related lock (spin_lock) while holding
> > > console_lock(raw_spin_lock) in v6.10.0-rc7 at rpi5:
> > >
> > >      [  230.381263] CPU: 2 PID: 5574 Comm: syz.4.1695 Not tainted 6.10.0-rc7-01903-g52828ea60dfd #3
> > >      [  230.381479] Hardware name: linux,dummy-virt (DT)
> > >      [  230.381565] Call trace:
> > >      [  230.381607]  dump_backtrace+0x318/0x348
> > >      [  230.381727]  show_stack+0x4c/0x80
> > >      [  230.381875]  dump_stack_lvl+0x214/0x328
> > >      [  230.382159]  dump_stack+0x3c/0x58
> > >      [  230.382456]  __lock_acquire+0x4398/0x4720
> > >      [  230.382683]  lock_acquire+0x648/0xb70
> > >      [  230.382928]  _raw_spin_lock_irqsave+0x138/0x240
> > >      [  230.383121]  pl011_console_write+0x240/0x8a0
> > >      [  230.383356]  console_flush_all+0x708/0x1368
> > >      [  230.383571]  console_unlock+0x180/0x440
> > >      [  230.383742]  vprintk_emit+0x1f8/0x9d0
> > >      [  230.383832]  vprintk_default+0x64/0x90
> > >      [  230.383914]  vprintk+0x2d0/0x400
> > >      [  230.383971]  _printk+0xdc/0x128
> > >      [  230.384229]  hrtimer_interrupt+0x8f0/0x920
> > >      [  230.384414]  arch_timer_handler_virt+0xc0/0x100
> > >      [  230.384812]  handle_percpu_devid_irq+0x20c/0x4e0
> > >      [  230.385053]  generic_handle_domain_irq+0xc0/0x120
> > >      [  230.385367]  gic_handle_irq+0x88/0x360
> > >      [  230.385559]  call_on_irq_stack+0x24/0x70
> > >      [  230.385801]  do_interrupt_handler+0xf8/0x200
> > >      [  230.386092]  el1_interrupt+0x68/0xc0
> > >      [  230.386434]  el1h_64_irq_handler+0x18/0x28
> > >      [  230.386716]  el1h_64_irq+0x64/0x68
> > >      [  230.386853]  __sanitizer_cov_trace_const_cmp2+0x30/0x68
> > >      [  230.387026]  alloc_pages_mpol_noprof+0x170/0x698
> > >      [  230.387309]  vma_alloc_folio_noprof+0x128/0x2a8
> > >      [  230.387610]  vma_alloc_zeroed_movable_folio+0xa0/0xe0
> > >      [  230.387822]  folio_prealloc+0x5c/0x280
> > >      [  230.388008]  do_wp_page+0xc30/0x3bc0
> > >      [  230.388206]  __handle_mm_fault+0xdb8/0x2ba0
> > >      [  230.388448]  handle_mm_fault+0x194/0x8a8
> > >      [  230.388676]  do_page_fault+0x6bc/0x1030
> > >      [  230.388924]  do_mem_abort+0x8c/0x240
> > >      [  230.389056]  el0_da+0xf0/0x3f8
> > >      [  230.389178]  el0t_64_sync_handler+0xb4/0x130
> > >      [  230.389452]  el0t_64_sync+0x190/0x198
> > >
> > > But this problem is gone when I try with some of patches in rt-tree
> > > related for printk which are merged in current tree
> > > (https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/log/?h=linux-6.10.y-rt-rebase).
> > >
> > > So I think printk() wouldn't be a problem.
> > >
> > > > Anyway, to fix the 2 arm64 callsites, I see 2 possible approaches:
> > > >
> > > > - Call the nolock variant (as you are doing). But that would just convert a
> > > > deadlock to a panic; if the lock is held when stop_machine() runs, without your
> > > > change, we now have a deadlock due to waiting on the lock inside stop_machine().
> > > > With your change, we notice the lock is already taken and panic. I guess it is
> > > > marginally better, but not by much. Certainly I would just _always_ call the
> > > > nolock variant regardless of PREEMPT_RT if we take this route; For !PREEMPT_RT,
> > > > the lock is guarranteed to be free so nolock will always succeed.
> > > >
> > > > - Preallocate the memory before entering stop_machine(). I think this would be
> > > > much more robust. For kpti_install_ng_mappings() I think you could hoist the
> > > > allocation/free out of stop_machine() and pass the pointer in pretty easily. For
> > > > linear_map_split_to_ptes() its a bit more complex; Perhaps, we need to walk the
> > > > pgtable to figure out how much to preallocate, allocate it, then set it up as a
> > > > special allocator, wrapped by an allocation function and modify the callchain to
> > > > take a callback function instead of gfp flags.
> > > >
> > > > What do you think?
> > > Definitely, second suggestoin is much better.
> > > My question is whether *memory contention* really happen in the point
> > > both functions are called.
> > My guess would be that it's unlikely, but not impossible. The secondary CPUs are
> > up, and presumably running their idle thread. I think various power management
> > things can be plugged into the idle thread; if so, then I guess it's possible
> > that the CPU could be running some hook as part of a power state transition, and
> > that could be dynamically allocating memory? That's all just a guess though; I
> > don't know the details of that part of the system.
>
> Sorry for chiming in late. I was just done my travel, but still suffered
> from jet lag. I may be out of my mind...

No worries. and I hope you feel better soon :).

>
> I agree the sleeping lock is a problem for -rt kernel. But it is hard for me
> to understand how come the lock contention could happen. When the boot CPU
> is repainting the linear map, the secondary CPUs are running in a busy loop
> to wait for idmap_kpti_bbml2_flag is cleared by the boot CPU instead of idle
> thread. And the secondary CPUs running with idmap active and init_mm
> inactive. So the nolock variant seems good enough to me if I don't miss
> anything.

As Ryan said, “It’s unlikely, but not impossible.”

For example, suppose someone creates a kthread bound to a CPU
other than the kernel_init() task during early_initcall,
and that thread performs memory allocation.
(Of course, I don’t expect anyone to actually do this;
it’s just to illustrate that it’s not impossible.)

When that CPU comes online, the kthread will be scheduled and will attempt to allocate memory.

Meanwhile, another CPU executing smp_init() calls smp_cpus_done() and
then invokes linear_map_split_to_ptes().

If the kthread performing memory allocation is preempted
by the stopper thread at that point, linear_map_split_to_ptes() could fail,
because the memory-allocation-related lock is already held by the kthread.

So, I've sent a new version of this:
  - https://lore.kernel.org/all/20251218194750.395301-1-yeoreum.yun@arm.com/


Thanks!

--
Sincerely,
Yeoreum Yun

