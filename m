Return-Path: <bpf+bounces-65483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 319E9B23DFA
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 03:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCF9189D862
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 01:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68761C5485;
	Wed, 13 Aug 2025 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Vipz1n76"
X-Original-To: bpf@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013009.outbound.protection.outlook.com [52.101.127.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5BBE65;
	Wed, 13 Aug 2025 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755050040; cv=fail; b=VVMMWnYUI+PK1g2S9jmDP27xrLuyaWONzT5zaYRJa0ZLlia/SKi1eBxqn2+RDOvzu1A6IN6Rnj6UJtCl155rDmP4rt3jkS0p3+wo90jx4tsxFb2PvBkIOGQ07I1EqN0054dEqhzpmkb3gfkY/gKtAxQTA4NNE7dYS08x5APjg84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755050040; c=relaxed/simple;
	bh=xK0ZSnv49BtpsZ63qPjXAWiBaV/bwY7PiqX3gjCxXzg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i7anGi6P4btTRd9o+2V+so0oy1hRHMSCFT0g7jwgAOrLaVYXNSJSXz3kQZdoI5afjuhM1Fc/I4eDnr5FzW4Rme5gJcr/KRBNmKFTfh2Mb3TvICa/jzlMfZDUFU2C2u5ok1YTqyI9BcIICI3HLN9ZF90a/F1lSHUVSEwZC5zczTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Vipz1n76; arc=fail smtp.client-ip=52.101.127.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tT141kjIIPRBZcfyfR0S6/ZSkj6RIXtG0AvSBzWAGPqWEu2GHGMEj/EmNHIy/vuekiQrsbRW+qxclOIcRhFOoAt3+KJDLYZyWnaabq/CTFef0RmACyStBUYmjy66BmJxCTaOPMTVRypzH0mxFFGs0s1OCUcsKHD49U8thultu/wkme9ZSLVpdexhkrR6sMNB/SZwzqQHsJBJk//w0XTDknTHZ7XmRXHV0RlRrlwyYSO9AvXRBhOKEf3DUJxCIvfAqu3/M8vSL53p9TGvtNx0tmGKXNQAfs044YE9KBUoDoXubm0acbZO5+zfZN8BcX1gmbxt79sLddiOF5h4wH1j6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xK0ZSnv49BtpsZ63qPjXAWiBaV/bwY7PiqX3gjCxXzg=;
 b=foofi5WnE7wNzFdMpFh3qcR3eDOkFA5mN18dDbks2n/giPEW6EZoZ6ITE4McKXUQX8s/MUfQqrtqtVtHEz5WUauDoe5EkdUp2I04PXLir86SD8vqdmxl61ZLKhxg068IjrXLXbT6wL/zmMLPP0zVea3oLvwzQvlevo+pqHc48oqu0zL6eaCWxk5/ZPh9rJdvE9mffwrDM3Pk15IX3CzbFtGUIrljd3V7vdFTm4XdbfjJS2w1YZnkvUrazNzbkzL1M+AVFwXCYJm54g9ilrQmrpQE+zz5uJRoHtRy8d4+QzocXX+cCClWcV9NDLfyvlrDQ5WpiFfl2/y2v25ZFb/oiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xK0ZSnv49BtpsZ63qPjXAWiBaV/bwY7PiqX3gjCxXzg=;
 b=Vipz1n762rJuViIOLPsg2bHl2B/XUM4RQG/AaQnDT1II8uBNhu5EtzBi4A/xUH0cloyVcGv4DVbWe8bOB0cJpEw2hnT/YdW4yeW7g0yuQGbHDifMrcm6VBa5SeCkV0Su/5u5C+evtoErnJB83t1Oxbyy4zpHV3BpEhgxpLgavjAupEBnuLZsP6mxVUZGG5oBAeZ+LAiCD0L7KGCLRROrWNF07RI44Xve4mNxV/IGC46d4KScpqwDVEpvlfGexJL//gmSBPI78mzDsc2Mv7enPNeYa7J6rW/5EijkUSQW9XlfJhCeiYn5z2MR6fa0F4JJ5gZ3ufFDNTeW329l9Xiuig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB6474.apcprd06.prod.outlook.com (2603:1096:820:f2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.22; Wed, 13 Aug 2025 01:53:55 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 01:53:55 +0000
Message-ID: <26cb16fd-26aa-473e-8894-f73929e79cf7@vivo.com>
Date: Wed, 13 Aug 2025 09:53:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: use vmalloc_array() to simplify code
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Nick Kossifidis <mickflemm@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Brian Norris
 <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Berg
 <johannes.berg@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Kalle Valo <kvalo@kernel.org>, Aditya Kumar Singh <quic_adisi@quicinc.com>,
 Roopni Devanathan <quic_rdevanat@quicinc.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
 "open list:ATHEROS ATH5K WIRELESS DRIVER" <linux-wireless@vger.kernel.org>,
 "open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812134812.298c7d97@kernel.org>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250812134812.298c7d97@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: c56bb9d1-266e-4d29-5e5f-08ddda0c42b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnowOXg2ZGpaUkNtK240bWZzUGhqOXVlTjhmZzIrVHBRQTJIOHh2cFdONXlL?=
 =?utf-8?B?THE1TnUrMlV3UnpDSWl4bWthdFhBbVNwenRaZU9vZUFQWktpYVlqNXVZYUUz?=
 =?utf-8?B?OThUQ05PYUlpQXlaZkhpZjkzdTB2cVVOVmwrbHZmWTk5ckZxNkdCQnpNZVR0?=
 =?utf-8?B?RldjdGk0Y2tpVGxNZnJRZktyanFYYk84RGV4TzBBTVo4azJQVzFjUTZwK3or?=
 =?utf-8?B?U2VWbDVwU1ZGMGtscUpNTEdlWCtRc0l4blBtMXRreW5vNzJnemM4TmMxN3dL?=
 =?utf-8?B?eGlPb2FTL0hGQ3FuOGVabWlIOFhmMXJ2K3lFSDhMdUNzS2w4Y2RZeWlHMkVo?=
 =?utf-8?B?Mkl6cGJab1FzbnhKdHYxS2VrUjlrSFJnakM2QzZiYWVIRUxFdk56YURRUWJq?=
 =?utf-8?B?ZDNuWWY5Nm8xenFFZHZwQzV2M1lOcTB3NHA0SlpTSU00ZVUraktjMHpVSm4x?=
 =?utf-8?B?V3plRitXZ3RVaHl0Y01qb3FzTmszSjRxWkNTbFlYRS9hMm9WL1lqaDVwQ29Q?=
 =?utf-8?B?WnFGZHlPR3FlZ3Y2ZnJvb0Q0a1huVGpTUnZwbGFQNlV5Tk5oOTJtdVlYN1pF?=
 =?utf-8?B?d2t5Z2FtL0MzOWpuK1BZTkFPajYxNDlPcU9ncGNtMU9HTzBScVRRcjliQzN0?=
 =?utf-8?B?RHNDUzltWnM4N042VmZrMCtvcEpiRmVWbnV5N29PMzNuMkU4T2x0STdKY3Fq?=
 =?utf-8?B?RUNGT2lYTCtOektiZ0YxYWh5S0VWZzd3QnJKNlBMaEpIbk0xdTdYUis5cDZk?=
 =?utf-8?B?TUNpMzVrZ0hUK0hRVnZoK01hZVdBcmJuSlk0MVQxdzFvWk1USWJLTWVvSWtU?=
 =?utf-8?B?VlJCRUtZdUZ3dDYvanU2KzVYVVBESHJPMjRPWXI5enRpRUdBbkVvS2RqaUhQ?=
 =?utf-8?B?ZFllRmh0MXErYzRFNHhVV0xjai82bndQMVNSTnFmNmZmUlUvaEcvVG1NZWtY?=
 =?utf-8?B?bVE1UjZiMGZBMnVia2Q2NStSbWY3RkxRendTZ3hqbjNNTXdPSHl2S2p3NFBl?=
 =?utf-8?B?cDFQUXpWbWRZalMwd29KdS9vT3QydDNBS0NCbDZuTmlBMVRjbk9VeHZNV2Ux?=
 =?utf-8?B?RzNUMlBKaHIxK1RMcXhabDcyZlUxYkFZMkI5SGVjN0pLODNteGg5aGpLekNx?=
 =?utf-8?B?WGxFR1Z1NWMyZ1JhWEh1UU50eTFSNmN5NTcwK3NuWDVnYW94NzVSM1lwYkhQ?=
 =?utf-8?B?VEwzSnBySGJjVXNrbnBwRlN4OFBvUUR4L1J6Q25iTzVEc0w3aDhGZGhhYUpE?=
 =?utf-8?B?RWgxT1B6Uy9ZWTI2bDJuUWMyS2NTZWFlVC81YUR0U1hvekVlcnVDelJ4YVhJ?=
 =?utf-8?B?ZkRJMENrZ01HTk9EN1VlR01aMlBuSDdHcFQwVU81eEgyK0hBYU5qZEhRQVQx?=
 =?utf-8?B?OEhZMHU1bWVMdnhxckZNbmVsTUZ3UU9nR0h6aEdQUHliSWo2SVFmQ0NXVzlu?=
 =?utf-8?B?Rm5GQm5ZRS9sdVJObGxJdWJuNDdQSWxmTlRjOGFEQ3RsWWxqNmpLL3pHU1pn?=
 =?utf-8?B?bnJYRUk5c3BiM1FVNmtXWXJJcnNadDdoZm5MSSt2MitGdmsrcThKVnFvb05E?=
 =?utf-8?B?QU1ZS2FOcmh0Q3JIOXdyeURnRVAwdDBSOXNOM3ZtQUQ3U1JxM2JyQkpDSnk5?=
 =?utf-8?B?alhkc0puYkt6NmJTdXFmaHVhQWN0cjh4NVRXY1owWkpFeFp0bWhpZVIxb2pi?=
 =?utf-8?B?NkswSG5nR0RnNTBjYVc2SnRZc3lVOTZUZTNXUktLbmQzZFZNVFhkSy8xci94?=
 =?utf-8?B?WjNxZUt6K21BbnNEQW12QkNMakJnWkxwZTFFd291UmhqZzBEYlg4R3FXc3Vk?=
 =?utf-8?B?VTlZUHpjRnNOSDRNTUtydGwzR2ZBT2F2RmR1TURFTUw2QThZZmQ1SWlpWEZM?=
 =?utf-8?B?WFNIc25GdWl4VmptL0xaTWFlN0cxRlBDQXovRUN1QjVhM3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjdaWXZGSE1FSmljMnRBVmxReS9uV3QxUHFWeDdBZy9DWDlrSEdSSDdPMmlx?=
 =?utf-8?B?czhkZXZBQTMrK2k1MGdPWXR5bDVHNlROVzh4dVc2U3BTamZvMzhZRU94dzE3?=
 =?utf-8?B?TTZ3Ynh2NHpXT05FQ3AwNStabVAxTmNRck84anRxc2MwWGFiWkx4cFBtTDl4?=
 =?utf-8?B?aDdxTkFvTitiMnEya3M2VTVtWGhFZG5RVHVCczJtRUIrWHlnK2tUQWI0QlQv?=
 =?utf-8?B?SGppWGd4aE5FWWJMVFVVcHJzc1dwWHBndDV6OFkzUVdFYk54SlM1NWUvcjBS?=
 =?utf-8?B?VW1pUTRxM0JtbHIyTC9MUno5allHSGtLaEZ0UlRJYTY2UU9yMDE5ZTVoOFBz?=
 =?utf-8?B?M1lnbWVVUS8xNU9LYnBqdzluR091eFhuMlNNRTJEZEpNZzc1U3lPTTVFODNh?=
 =?utf-8?B?S1NFdG5INDhlRWJyaURTb1dQZ0RZNkJkSnZabEZxbGZBRlp0WWpVWEZqSHY1?=
 =?utf-8?B?RVIwaVpFZEZPaVN6cU5uTDA3aUJ4TlJQaEJ4TXh2OGMyN0V6MTU1UUtIbFlY?=
 =?utf-8?B?NzVSU0l3cVhneWpYOTF0eUh5OWhiZ05zSWp0a2NSeWk2bkVLNUhpcWJ6Y1hB?=
 =?utf-8?B?SEV1MXpFOEpxSVhzeWpXcWUwWDdJN0pDRURoK3NtL3NpbnFNNkd5UnFRd1Vp?=
 =?utf-8?B?OTdzVUNRdzJMQkJYQm9idHVaQkFZUm5NbXJsa2h5ZE4xWTlzNTRSRng4YmND?=
 =?utf-8?B?RjJPUHE3SlU1U3M1TzN1QTRITUgvLzZPdng0UFRqK2RxcldQdjVScEFURHpY?=
 =?utf-8?B?MVMzcDFZcmVRUGtsMzlpcTNXclRjRWhsN0trVExBNVpadVZzbE9wdHYvcUdw?=
 =?utf-8?B?bGk5UEJXM3d6eHZSNTVWMjVYNTQ5TUMvYkR3Wk83UDJNdFFBRy91eTRWMWl5?=
 =?utf-8?B?R0NFRHkxendEYStuMjVTL3JmZlErcHd5TWVsZVR6RTRpcWd5QlJlV0JyaVdL?=
 =?utf-8?B?SVE1OXV1dW9DemtZemRNN3pZR1VUb084QjRtbWhCVjIweTVBWmZPTEgwOU1O?=
 =?utf-8?B?NXFRdWs1LytKNE11VFltR2RTeXU0dTFJWWdwOUorK28yN1RLM1RPT2JiUXlP?=
 =?utf-8?B?dGt3cW1kbHpzemZ5OWt6enZaTGZoQTJ5S1Rlc3ZJMFRUeUcvcVdQMkc0N3Nn?=
 =?utf-8?B?Q3J4akFVR1VScjZHQkNvdVZXdTYzaTgzNytPVUVFa0pDa3JNRG5JWEpDbFcv?=
 =?utf-8?B?RUhlV1E0VHh4ejZtemR4S3JkNTQ3WW1WQ3FFZFlqRXE1NXMzRjdraEw3dFM0?=
 =?utf-8?B?czBKcEd4eUUzRnJCb25ydkNYTENkVHlJWFBuVjE3ZTdZV3RaQ0sycGdwamNV?=
 =?utf-8?B?YVRuMnBsTjhTSWxQZzg3dDlrTGdybUpWZnUvTDhNQy9CYm1kTDJWYlFSNlhj?=
 =?utf-8?B?Y3NqRlNxQjFqWTRuREpsRmp0VVdFaGNiaGdUTDE2dWFUeTVnQTVGRkdZQWpY?=
 =?utf-8?B?dG9sbzlGcGVYY0h3M095TENKM2pkWldVQi9kRG81ZVFzUkdkZHp3ZVhmNHRz?=
 =?utf-8?B?QjRpSHJVMk0zdFFoK013RVlwYUlxVGNxbXhQNFlITzE3TWM2TkdvcDIrOUtN?=
 =?utf-8?B?Q2RoRUlXMThWWjUyT0trL2dkYXBaMnZnVXBtUnJZSXJIa2dKYVJ6OS9pWkJh?=
 =?utf-8?B?MmdnZ3YzQTA1dlIrSXZ2YW8zNEF0WkFKbTJQSC9FYndaRkYxZGU5bjBrWlhq?=
 =?utf-8?B?VDFHaWZqSmdUdUpFVFZjV0x1aVRpZk1JUVI3cExrTzc4LzRlNFlpaHYxVTBL?=
 =?utf-8?B?TnIrQ1BOd0RzMFhVcytaaEwwQmlNZTZ4SFZqYldaRlNtd3pYNjR1U0pKeDRu?=
 =?utf-8?B?RWlkK0ZTcFFZaDU4TXZCVUwyL1JKa0Jaa0JlcFd3WXFhQlV2eTBUSnJoTjlV?=
 =?utf-8?B?cE55MTh0R2lzTjlLcjZHVnhMazdDTDZJTERzbkRaL1JPdWltMk1HbS9nUWVP?=
 =?utf-8?B?Q0NmYmdhRjVsdk5yaDF1MzBpSHlxVWltZkdPa0NWR0NiUHk2RkplcTdyOFBJ?=
 =?utf-8?B?Mkc1Qk9IdUdrNTF4d3hmMVlySThJeFZHRS9ZWVFKbG9hU3h5aUN5OGdnWTE3?=
 =?utf-8?B?bnc4WVAwdXlaclRTRWdwZFByQ2dveXRMMmh3VFh2TWxsYkk3U0ZIRDhGYXpV?=
 =?utf-8?Q?iCtI5fwmWQgQ9YoFHf6pZPtl4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56bb9d1-266e-4d29-5e5f-08ddda0c42b5
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 01:53:55.3440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nB1etL9vLIdy59jElohTprevUyBB/gutiykbgOnAEXcGw3Uz45VZdmCIgrYRjZccRQaucO0YeqeIy7//g+Lw3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6474


在 2025/8/13 4:48, Jakub Kicinski 写道:
> On Tue, 12 Aug 2025 21:32:13 +0800 Qianfeng Rong wrote:
>> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
>> simplify the code and maintain consistency with existing kmalloc_array()
>> usage.
> You need to submit the first 3 as a separate series.
> They get applied to a different tree than wireless patches.
Ok, Will do in the next version.

