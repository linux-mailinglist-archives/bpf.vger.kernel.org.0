Return-Path: <bpf+bounces-76876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1094CCC8CF0
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 17:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DE0A301CE31
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BA4350D76;
	Wed, 17 Dec 2025 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rzwkCgaJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rzwkCgaJ"
X-Original-To: bpf@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A3134B678;
	Wed, 17 Dec 2025 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988737; cv=fail; b=borahMP/NmM0qAfHIqZB9yV239jKuCvAU93B1ujt/5VNMb9XmWoennBFiuHWBXGXSWiNgcP+0H/8K4XRSy7czXGlVozQbnwsgwkEV3GUzIpYsE8oO3ghujtGUMBf5AxDToXFUl0jSsU563Ovs4QGTo28ovp5le5O4782nV485l0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988737; c=relaxed/simple;
	bh=1nevvPJtEZnJ+zcXU1oLAAe3f/UeM5eaBnnhv9SwT3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TZYqFKLVBksXjaD0QhFWNfhkI2RIMaiW9FNvOSWcBfBGcoMQLqKDkUWmNzRbQ+fAdAOoq1e+zmuQpXpZUlReVzB98quUs1xQuWp66Z7KqdoOrJySXl+CBaf5jz5enEfw39HewhTcujbeJlT9l0vEak/R1ZE7aP8mefnknyNKkHM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rzwkCgaJ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rzwkCgaJ; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Aql/5yXnDGLjuM3TOReo3zYhphdSNn+QstaV/NuQA6W9NJZXpAJC8vhGhYgK/kn4phmfeJ2VESLh4stFJWol44wo8lcEeCn0gVSwWN1V05LmqWMI+kYjVgcE+6BZcZrcK1yofN977tQ7sI9oCSmCEo89JabXPvIftL4Q3ZLyI9cTvHlEY1IZqDQ6nnXYkLqk6rr6QFZAfB67D2lw1tctgQ0hWe7vJ8c40uZMKr/t4bZ5JX7l89G+DFuoAHLGkNzosEl21T5fBvGDvBvRuLAQ4tj4CRuGl/9rEN3Ng2X4Bue20Y/gkBkPoA5+mkbD4Dfc0dSDqVbGZPV3hkrojpa7iw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiAVq3i0CN3U4Qjh1S+72e0nCi4KjBzi22trSQgZ/gw=;
 b=FojEOmzwrmD0nnmbeTeSp8HJU1CEnqjOkYU18kkmib1riqJZytZoF5Q4+Cgx9keGHlJcqx3bdgBBDaoOayR8fs4Mkh20PkgdITTzF8azewstUmq39X8gepxVV5RIpYzko5omDy6WqrJr5/W7EyjXecbbbEKMQ2GXabfXFzK69fA0V0QsXasxYLbvsqNEfXe8sXettUXayN45Ubxly9l3Cwf1WOMBM+QqixMLqcBHB79TS9N8h2to9MVaun5z1S4TWMOat0+U/V30evjHQFiDxTttkb7oLxG5Mdev7/yBJtksP4WBTofkDGkZGbReA/T7OieYkwH+2X1GFGICuWIiZA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiAVq3i0CN3U4Qjh1S+72e0nCi4KjBzi22trSQgZ/gw=;
 b=rzwkCgaJq+h/BHZ6TFUlDNadsS0CHkxbTivKyfO4spJDxVLP8xXUjnG/BhKg/WpV4TfSAShfTDEus7bqKBXY/nbLvp1EmsLCB/Of7Padc5uisb5U59ko6eLzFNBq/mpv9W/Fy4VBl331dQffRaMlTDet4f+vFlr4xd6pPhAfnSA=
Received: from DUZPR01CA0278.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::23) by DU0PR08MB7464.eurprd08.prod.outlook.com
 (2603:10a6:10:357::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 10:49:19 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::b9) by DUZPR01CA0278.outlook.office365.com
 (2603:10a6:10:4b9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 10:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4
 via Frontend Transport; Wed, 17 Dec 2025 10:49:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUjOAbZ01F+9Pl1IKRcaH2neHV8+pEtaMN7BW7eDIPqsRjj2n+yuu2uC6Yg127o1XrLLI9dsz4+ysCtFnJto7rH1LDGJR2/NyxX1rA1TJMV0nx4SdaWbicQgOkfYkVQ5sNU0E5zPRpF+/t8K2YlD/3T5ycTUw7r5PaTiRB2eNtH9IzsbHuQopQlCn/tSKgaZWYKk9Y9zSP93uQ9fn+DL4uTSefJ808Fx9uRAM86O7gP/sgYVCt17VfHZifum6lvpp94FAvHOhBw9uE41hdZ+zKMqKh/lrwIRy0A+D/S2oq7NuxyQFHWx6tn/zBheSEkdvrfE8JlVCgmn5wELZ1nUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiAVq3i0CN3U4Qjh1S+72e0nCi4KjBzi22trSQgZ/gw=;
 b=tIRec/GVUqVlVp6PLJb0bt625erzYFA80Axkl0YGgm3Sf8FeJUQkvquSewIaI36ezAfmFVlA3f6SQ6tsC0GsYShEVutjRxiowDPR4wCfzqZBoIbA4SiNFObbLdgbNtdlchXABYBiz28jaO84jK9dsNes4s4DpxZQFgV+Py80P1/g03/GC1GX+qmo7SzCf/gXk/yysN4B4mDxs43qiNgVf0LKD8HQeyFSCl7IZxCnyO5uEH9DJxihGJLN0X/NB/L/R/kr/+wd1d4iZNO2Xp2MkIIpH0faYJjpV8A5P/FE0ja1gfZ2mZBq/lK5tdBzyzZ8HQy02UJQzjFbeeSt84Ncjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiAVq3i0CN3U4Qjh1S+72e0nCi4KjBzi22trSQgZ/gw=;
 b=rzwkCgaJq+h/BHZ6TFUlDNadsS0CHkxbTivKyfO4spJDxVLP8xXUjnG/BhKg/WpV4TfSAShfTDEus7bqKBXY/nbLvp1EmsLCB/Of7Padc5uisb5U59ko6eLzFNBq/mpv9W/Fy4VBl331dQffRaMlTDet4f+vFlr4xd6pPhAfnSA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB10749.eurprd08.prod.outlook.com
 (2603:10a6:150:16b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 10:48:10 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 10:48:09 +0000
Date: Wed, 17 Dec 2025 10:48:05 +0000
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
Message-ID: <aUKKZR0u22KOPfd7@e129823.arm.com>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
 <aUGOPd7gNRf1xHEc@e129823.arm.com>
 <100cc8da-b826-4fc2-a624-746bf6fb049d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <100cc8da-b826-4fc2-a624-746bf6fb049d@arm.com>
X-ClientProxiedBy: LO2P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::15) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
 GV1PR08MB10521:EE_|GV1PR08MB10749:EE_|DB1PEPF0003922F:EE_|DU0PR08MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebaa8b8-0c86-43dd-758e-08de3d59edf6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TWh0a3QwNFNnNU1vci83K25QZzhERDNXWnYxS2RRV1VLQVFRSXh5UmxCT2FT?=
 =?utf-8?B?Y3VaWHVuSHZQbnZ3UWlHYy9URWZkcFpYYjdyU2oveW1QWDJGdGFTa0x3d0pI?=
 =?utf-8?B?eDJGM1pMMWs2aUZHd2t3WXdjcmhMY0RqM2lBcmRIbXQ5VGpXdkMzT1Ivc3Vj?=
 =?utf-8?B?OFAraXVDWVZrR0xCVGF5WnZVdVlCbG5zUHZQZ1YzcndESlJqc3k2K3hJbXR1?=
 =?utf-8?B?RDEybEpYTDhSMVlHZnR3cFVuM05LUFNJUnhCRUllb052aytwcHlMQUN5WDho?=
 =?utf-8?B?ZnVJWlZZOHJZak13bjE2Yko5RmR2dzlWUURCWldlS3IvckFNUlIvd2JENUE5?=
 =?utf-8?B?RzFRRC9aZExmV2VXNkM2a2gzWlBLWm4wajN0NW16SFFhWGx5VUgzcENkM2JQ?=
 =?utf-8?B?YTYzMTIzS2JDRWhUMTloMmJaOUtQRmVJY2RUQU9LV2dtZHI5VjU4N2NuOEFi?=
 =?utf-8?B?czMwSjRXTFRyOS8zaE9MNWxSUmpRMXd1aWZIdFcvV0VEbEZnd2NsVUgyR3Bp?=
 =?utf-8?B?Rk1mOGZiQmFpeFc3Y3I1R0VVRVFuc2NBL01hTEZScEdvY2xrVGF6MTBCaW4z?=
 =?utf-8?B?RW5mUVFscXRuTnY2eWYwanlnVmI1V2E5SDVyVThzNjh3NUVES1lrSlVWQnJR?=
 =?utf-8?B?dzQ5Ykg5OERkSklhZVFhVTk1SWRCNUxMRkUvVVA3Q3ozM3NObmswUWo3OTBt?=
 =?utf-8?B?Sk96QzUwTmVwV2d2TmJod1Q4aERML0lzR2UyZGVVcWRlL0U5Q01CbnJ0KzRt?=
 =?utf-8?B?SDZMWTVmVC9SSVZ0Y0RCUm1Cb05NVmo1TTVTRUFJb0NRYkVvRDNHTXZBZVF1?=
 =?utf-8?B?T0E5dExmc0hYamxTYzg2RW5vVEY5QlpoT2wvRTdZRWYzU0F4REtnWG94ZXB6?=
 =?utf-8?B?Y3ZSZndWUEFzSHBRUlJESUJ6OVBzOFZONFV4TVJqbDVFeVBCZkpvSExzNlRE?=
 =?utf-8?B?aDF3NkVBYjgwL0xjbEd5V2V6KzV1Z1VmZ0ordmIyOGNxcUR3bnpBcXlBNFFJ?=
 =?utf-8?B?blJXbW5TUjdxQ1Z6UkZlbHJZeGZDUnU5WlRILzZlZmxXNE4zZmorSjBHWjFq?=
 =?utf-8?B?a0wwdFdpQTBoV0N5cldHNU9GcW9xWGpmNzQ5bGhkdm9UOW92UHdBMWRucGJU?=
 =?utf-8?B?WjJSck5sY1hPMmx2clpkSXBaUldRN2lPMmQwaEhyYkNtWUwvMTNreXdBMkJR?=
 =?utf-8?B?NFk1ZE5BNndGMDhiL2t1R0pPZjhMT2xIOVNkazJTZks5dCtkb1I4ZFoxUjBT?=
 =?utf-8?B?UExoMCtkc205S1phT3FQU20yamxpNldtOGxxYXFzd3pTSkg3K3JCSzdNVzZu?=
 =?utf-8?B?aldEWGxpbXA2ZEF3Q0c3ZFZkazdKek1RWGhSb202dlNidnk1dzR4ZGhVdUxW?=
 =?utf-8?B?NjM4ckNlTlFqNTBkRis3VHZrVENudW1BTDRwZldJQkU2TmFmb080eFFxdm1Y?=
 =?utf-8?B?RjNySThlOHV6Z0FUVDlBeGVMVDlVTnppRS82K0tpaGgxcFk0aEZEb0JodmF5?=
 =?utf-8?B?RW42eFozcis1WnUvbUI3MXQvUCtVTlF1Smp2MnNhQXJueWJzT2VuMUh5Qytu?=
 =?utf-8?B?Wi8vK3cxVzJuQldKeHpYU2ZxRUxSMk42M2lNbkJIOEk2NVRia1djcUxHWkJI?=
 =?utf-8?B?RW1QYWttTkRCb3R5MXBWOSsvbUZrUjM5VW5DdEpXTHhoZkR5NDdxYkhGQ0gx?=
 =?utf-8?B?TUhMS0ZKZW1RWXNZekEvT3l6a0FFK0JKc0NmS2xQTXZpK0hWbXpNVWlMK1A4?=
 =?utf-8?B?dmxFaDVHaVdwbmFHVEcyR2x2cUxERTlPdjFqVmF2RG9lMEZNSDh4U1c1bzhF?=
 =?utf-8?B?WVY3NGEyYzFJYmdmOS9VM0R3TVVET2tzcHJHWGluVUxuenhidlZWRUJwdVM2?=
 =?utf-8?B?bUVvdTY3aXpxL25qcVJ6bjhQTEh0SGhzeUN1YU9TWjFzdUxQYUk4V2FIWnVC?=
 =?utf-8?B?MGVLaHBpMXJQL1E2S1l6dEZWaXM0VnAyajBPQmFadTRFc2FHWXNCNUEyVHB3?=
 =?utf-8?B?OVZxQm4ra3BBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10749
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 b7c8f0c3-cbb1-492f-43fb-08de3d59c475
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|35042699022|36860700013|14060799003|7416014|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?S3RqdTFPU1ZpbGF6N3VzT3dBSUdSM0lJMFkvaVd2RFdZNEJMSkxHblJGOVVi?=
 =?utf-8?B?TU0zc0ZjaDhqeU8vL3hoL2RtaWNaamhOZjBwa2JhMWlHODZaQUFtalhZT0xN?=
 =?utf-8?B?c3VLUW1MOFRmRDgxYWwzYTlGK0phcVIxWE1oeEZna29BZkhEOGR6TEtnd3o1?=
 =?utf-8?B?UEtRM0w1YkorQ0JYN1RlRkJzRUVZc2FvQmpmeWpURmpiUHlUcFlKY045c2Qw?=
 =?utf-8?B?YUpJTHFzd3FCVFBsNXEydEk1dklrcEs1VGRXQ1Z5ZEE2UXNoU1pucmtaR1Yx?=
 =?utf-8?B?bEhUcmVGWk1ubnpmbnc5ZHU0bG96SnFsM2hjYVBuNS9XZEpmYlI2YjkzZWQ2?=
 =?utf-8?B?ZTdCQW5veWJBaXozVVFNTXVVaHltaXZ4Yzg5TWRobUNBMXhhWmZ0REl1VUh6?=
 =?utf-8?B?Y0JUazJMUkQ5Wld3cFVQK3FhczEvMkFMak9nc1MwcHFyNm02RHpjNTNKem84?=
 =?utf-8?B?WUMzYXlZOURlQlNzS1owUDl5bnFhN1hlL0dCSVhHV1diYjRiRTh4blB6MTNo?=
 =?utf-8?B?dGMwRWI0Q3JjSUVDWVd4VFN0RFMxdUdwMUtWcm1RODF6YUdNWGJkVitSVjlT?=
 =?utf-8?B?VnJkcUZPSlY5dUlrR0JKN1l5TjJZc2RJRlk3bG9PK2RpYjdzTDZrQURqZGwy?=
 =?utf-8?B?b1pER2JxUVg4cTJYWVNpemdPbGZNdXliRXdQVFRGVElKV2tzMFFhbWlDeTJi?=
 =?utf-8?B?NmhKcUV1aXlmUzM3S2xFMW04Wi9qZVhKOFFkaGdsS3NvMDR6U21KUEVoNGx6?=
 =?utf-8?B?aEJBWXkwUTZpQ2pGcFErWkpIUDFFQkloV1FieU9BZTNLVWEwTkNDL0FFSURY?=
 =?utf-8?B?QVUwZTZFemhyekMvZWJJQTdjd1N0UWpFVTBpQzJsWHYwOTVyMnFDWVRuSFFs?=
 =?utf-8?B?dWh1ay9OODErQTh6a1ZpSmtCR21mUlV4UTNOSkZuR1BGL3grdy81aVpoWDJi?=
 =?utf-8?B?am1DNm40L2h6WDJQSUg2TVBnTE9MaGhtUmtYa3NqMEJ0QW5kWjkwVUltS1BC?=
 =?utf-8?B?Mng3UWhuZmRZSi9CTnhub05XWnlmYy9BN1ViTktrS21FY3ZaaVV2NlN6VmFa?=
 =?utf-8?B?bnJiUFBld28xcENGWXdYRFMwdHM0cnIyM2R4eG4wYjVZVXEvMThRQmtFQjJo?=
 =?utf-8?B?WjdodG9VN2VXOWVqNElub0NjeWVQZkEzOGZSRlE4NWp2bStlUVhuRENEa01O?=
 =?utf-8?B?cThGU2Vjd3FFcWtzRW45OFBNRE5UU0pMdnl4ZVBSRHBEbTZmOFRUSFE0NGJv?=
 =?utf-8?B?NnhidXplemt3cTl6TTU3TEdKbXhtVmNOMDJSbU4vNkNBaVRTS3JiS0FsVWlF?=
 =?utf-8?B?RUNrS0RlSzBqcVRoU3F1dWt2SmNmQ2FET2RGL2dPOU5PVnhkS3ZMVEhBTmVG?=
 =?utf-8?B?aEY2SWwwWGJCR3QwQlNvU1NqQzh3SktPMWU4T0ZMdUVJVGJBdXMyV09wN0VU?=
 =?utf-8?B?LzhUQ2dzc0lyK3VrdXVMSE5CemRUVGhtenYxZHN3WjVPKzJ1aFBZR2NKRit2?=
 =?utf-8?B?eE1XV3FjWWdVdjhZS0hDUjBvUDIzU3BJVk13U0FITnJ2aHRtRTZMeXp3YjBI?=
 =?utf-8?B?bTZKUitORzBuUmZ5MWFvSDJPK2hnbjdrYTBuTU1xdHNQblJyeWtROWpRSnZK?=
 =?utf-8?B?U05EdFVlcENWdVVQWTg5bFdXUnNlMWhzamVkNWhwNlpKN1VYVFRyZ0U4KzFs?=
 =?utf-8?B?dFlVeDBFSW9tQTV1enlXVEIzeUJOTisxTC9EaFh3ZVU2c255SmZ5ckJ0cGQ0?=
 =?utf-8?B?VDdsODd2WEtzTGE2UGZNV2wwSkdpcFJaT0ZOdlNaVjc0QlNWc2VvTHNVRzQz?=
 =?utf-8?B?K0tsa3ZQb1JzV2lqZVdKYkwrK2NKUWNvTGN5Q0l0YUxCTnppTzZWN3VHdCtM?=
 =?utf-8?B?WEgxTkQzWFNYa0hrMXY4WHNwRGE5d0c3dGJ5KzdXQmNoM3JqRTJRYkNvZlp6?=
 =?utf-8?B?NjlFWlo5RXE4SUJIVzFmcnQwSGZCdmJrNy9FeGtvVUFPYWRYT3IzWTNFWlhI?=
 =?utf-8?B?Y2NSMGZUV3NiQlJzOHpRTFl0K0QvTWN3ZTZ2cEFBYWVWR0NOTHgzNVQ5Y3VC?=
 =?utf-8?B?ZXlNeVgrSThsZVE5eXV3ZlZqU3J1RTdsSEVGSy9jdk13RGFqUHpQNVV1aVl0?=
 =?utf-8?Q?uDLthRw+UeoSzxSb1nkx+A5Nc?=
X-Forefront-Antispam-Report:
 CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(14060799003)(7416014)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 10:49:18.6208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebaa8b8-0c86-43dd-758e-08de3d59edf6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
 DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7464

Hi Ryan,

> On 16/12/2025 16:52, Yeoreum Yun wrote:
> > Hi Ryan,
> >
> >> On 12/12/2025 16:18, Yeoreum Yun wrote:
> >>> Some architectures invoke pagetable_alloc() or __get_free_pages()
> >>> with preemption disabled.
> >>> For example, in arm64, linear_map_split_to_ptes() calls pagetable_alloc()
> >>> while spliting block entry to ptes and __kpti_install_ng_mappings()
> >>> calls __get_free_pages() to create kpti pagetable.
> >>>
> >>> Under PREEMPT_RT, calling pagetable_alloc() with
> >>> preemption disabled is not allowed, because it may acquire
> >>> a spin lock that becomes sleepable on RT, potentially
> >>> causing a sleep during page allocation.
> >>>
> >>> Since above two functions is called as callback of stop_machine()
> >>> where its callback is called in preemption disabled,
> >>> They could make a potential problem. (sleeping in preemption disabled).
> >>>
> >>> To address this, introduce pagetable_alloc_nolock() API.
> >>
> >> I don't really understand what the problem is that you're trying to fix. As I
> >> see it, there are 2 call sites in arm64 arch code that are calling into the page
> >> allocator from stop_machine() - one via via pagetable_alloc() and another via
> >> __get_free_pages(). But both of those calls are passing in GFP_ATOMIC. It was my
> >> understanding that the page allocator would ensure it never sleeps when
> >> GFP_ATOMIC is passed in, (even for PREEMPT_RT)?
> >
> > Although GFP_ATOMIC is specify, it only affects of "water mark" of the
> > page with __GFP_HIGH. and to get a page, it must grab the lock --
> > zone->lock or pcp_lock in the rmqueue().
> >
> > This zone->lock and pcp_lock is spin_lock and it's a sleepable in
> > PREEMPT_RT that's why the memory allocation/free using general API
> > except nolock() version couldn't be called since
> > if "contention" happens they'll sleep while waiting to get the lock.
> >
> > The reason why "nolock()" can use, it always uses "trylock" with
> > ALLOC_TRYLOCK flags. otherwise GFP_ATOMIC also can be sleepable in
> > PREEMPT_RT.
> >
> >>
> >> What is the actual symptom you are seeing?
> >
> > Since the place where called while smp_cpus_done() and there seems no
> > contention, there seems no problem. However as I mention in another
> > thread
> > (https://lore.kernel.org/all/aT%2FdrjN1BkvyAGoi@e129823.arm.com/),
> > This gives a the false impression --
> > GFP_ATOMIC are “safe to use in preemption disabled”
> > even though they are not in PREEMPT_RT case, I've changed it.
> >
> >>
> >> If the page allocator is somehow ignoring the GFP_ATOMIC request for PREEMPT_RT,
> >> then isn't that a bug in the page allocator? I'm not sure why you would change
> >> the callsites? Can't you just change the page allocator based on GFP_ATOMIC?
> >
> > It doesn't ignore the GFP_ATOMIC feature:
> >   - __GFP_HIGH: use water mark till min reserved
> >   - __GFP_KSWAPD_RECLAIM: wake up kswapd if reclaim required.
> >
> > But, it's a restriction -- "page allocation / free" API cannot be called
> > in preempt-disabled context at PREEMPT_RT.
> >
> > That's why I think it's wrong usage not a page allocator bug.
>
> I've taken a look at this and I agree with your analysis. Thanks for explaining.
>
> Looking at other stop_machine() callbacks, there are some that call printk() and
> I would assume that spinlocks could be taken there which may present the same
> kind of issue or PREEMPT_RT? (I'm guessing). I don't see any others that attempt
> to allocate memory though.

IIRC, there was a problem related for printk while try to grab
pl011_console related lock (spin_lock) while holding
console_lock(raw_spin_lock) in v6.10.0-rc7 at rpi5:

    [  230.381263] CPU: 2 PID: 5574 Comm: syz.4.1695 Not tainted 6.10.0-rc7-01903-g52828ea60dfd #3
    [  230.381479] Hardware name: linux,dummy-virt (DT)
    [  230.381565] Call trace:
    [  230.381607]  dump_backtrace+0x318/0x348
    [  230.381727]  show_stack+0x4c/0x80
    [  230.381875]  dump_stack_lvl+0x214/0x328
    [  230.382159]  dump_stack+0x3c/0x58
    [  230.382456]  __lock_acquire+0x4398/0x4720
    [  230.382683]  lock_acquire+0x648/0xb70
    [  230.382928]  _raw_spin_lock_irqsave+0x138/0x240
    [  230.383121]  pl011_console_write+0x240/0x8a0
    [  230.383356]  console_flush_all+0x708/0x1368
    [  230.383571]  console_unlock+0x180/0x440
    [  230.383742]  vprintk_emit+0x1f8/0x9d0
    [  230.383832]  vprintk_default+0x64/0x90
    [  230.383914]  vprintk+0x2d0/0x400
    [  230.383971]  _printk+0xdc/0x128
    [  230.384229]  hrtimer_interrupt+0x8f0/0x920
    [  230.384414]  arch_timer_handler_virt+0xc0/0x100
    [  230.384812]  handle_percpu_devid_irq+0x20c/0x4e0
    [  230.385053]  generic_handle_domain_irq+0xc0/0x120
    [  230.385367]  gic_handle_irq+0x88/0x360
    [  230.385559]  call_on_irq_stack+0x24/0x70
    [  230.385801]  do_interrupt_handler+0xf8/0x200
    [  230.386092]  el1_interrupt+0x68/0xc0
    [  230.386434]  el1h_64_irq_handler+0x18/0x28
    [  230.386716]  el1h_64_irq+0x64/0x68
    [  230.386853]  __sanitizer_cov_trace_const_cmp2+0x30/0x68
    [  230.387026]  alloc_pages_mpol_noprof+0x170/0x698
    [  230.387309]  vma_alloc_folio_noprof+0x128/0x2a8
    [  230.387610]  vma_alloc_zeroed_movable_folio+0xa0/0xe0
    [  230.387822]  folio_prealloc+0x5c/0x280
    [  230.388008]  do_wp_page+0xc30/0x3bc0
    [  230.388206]  __handle_mm_fault+0xdb8/0x2ba0
    [  230.388448]  handle_mm_fault+0x194/0x8a8
    [  230.388676]  do_page_fault+0x6bc/0x1030
    [  230.388924]  do_mem_abort+0x8c/0x240
    [  230.389056]  el0_da+0xf0/0x3f8
    [  230.389178]  el0t_64_sync_handler+0xb4/0x130
    [  230.389452]  el0t_64_sync+0x190/0x198

But this problem is gone when I try with some of patches in rt-tree
related for printk which are merged in current tree
(https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/log/?h=linux-6.10.y-rt-rebase).

So I think printk() wouldn't be a problem.

>
> Anyway, to fix the 2 arm64 callsites, I see 2 possible approaches:
>
> - Call the nolock variant (as you are doing). But that would just convert a
> deadlock to a panic; if the lock is held when stop_machine() runs, without your
> change, we now have a deadlock due to waiting on the lock inside stop_machine().
> With your change, we notice the lock is already taken and panic. I guess it is
> marginally better, but not by much. Certainly I would just _always_ call the
> nolock variant regardless of PREEMPT_RT if we take this route; For !PREEMPT_RT,
> the lock is guarranteed to be free so nolock will always succeed.
>
> - Preallocate the memory before entering stop_machine(). I think this would be
> much more robust. For kpti_install_ng_mappings() I think you could hoist the
> allocation/free out of stop_machine() and pass the pointer in pretty easily. For
> linear_map_split_to_ptes() its a bit more complex; Perhaps, we need to walk the
> pgtable to figure out how much to preallocate, allocate it, then set it up as a
> special allocator, wrapped by an allocation function and modify the callchain to
> take a callback function instead of gfp flags.
>
> What do you think?

Definitely, second suggestoin is much better.
My question is whether *memory contention* really happen in the point
both functions are called.

Above two functions are called as last step of "smp_init()" -- smp_cpus_done().
If we can be sure, I think we don't need to go to complex way and
I believe the reason why we couldn't find out this problem,
even using GFP_ATOMIC in PREEMPT_RT since there was *no contection*
in this time of both functions are called.

That's why I first try with the "simple way".

What do you think?

--
Sincerely,
Yeoreum Yun

