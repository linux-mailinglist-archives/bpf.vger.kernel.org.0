Return-Path: <bpf+bounces-42795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA74E9AB2CE
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7DEE1C217B9
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C4E1BD50C;
	Tue, 22 Oct 2024 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6Nh4V1Z"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A36C1BD039;
	Tue, 22 Oct 2024 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612337; cv=fail; b=nYHme8nM9gJqZ259TYyDX+ZgXdbMkPwB8kNsrFQIzyCpFpY3AzHTiw0D3FpcxMlJs6gLCk+Yqepyezasco0+0PadIMuANBgvqZbnW2iRgIiF7bLnkkKNL8haU05LhywV27vRk1euOKpSUs3fTvTdux0KBvNo4g3iArEW+kGgkHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612337; c=relaxed/simple;
	bh=UumOPAxKyDjWj83HASaMOP3EQHFalal4IzLap2ntAps=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mI1wftpSpAxWu8OplPYU/TbJZ1xXPxh7yQGlt1UeB7Z+TirNQhtC1xEjPX/DtvFHnPTPcBD+ofuoc4Iz9uGB1WBSyED26uKnSYbZv4ajBRH78+5s3YUYlkRsYSxZbkXY4o1oLZPCIcBhT45nMEQ+uPl60lIFEyQvLk6vMOF+iZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6Nh4V1Z; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729612336; x=1761148336;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UumOPAxKyDjWj83HASaMOP3EQHFalal4IzLap2ntAps=;
  b=Y6Nh4V1Z5TWYln8S4YovI1+WpDcfverMbXbK1GpdzQ80ZqTChQZoWWwd
   qhtjq5zi7VssM5l8wF+Vmag+0wkMWcbqiMfC8DUJ4n5EXk5Nf5GeWCx2Y
   ItLM+1+LjTrCOruB3qBUyCnoC3FHM19uJD0oisZcdQvb/BTqmQRHfd07N
   k9T2XCCLRPagflqM5C722olfpXw6eHpcCI9ej0LeLNkP7y1D3nPYnZQBT
   E9N1GHZHJ3k7hSsQoHRQIU9NN2JNtS6jI00Tk9f71O2Bh2/u7BKIunXuz
   CK3ZRjJw3YwQrB/8oz6V5LO7GusTfTvinSUqwUUxqclbXUi3cNPwzm917
   A==;
X-CSE-ConnectionGUID: CYeRfkgwRsSbmnNmtpuZXg==
X-CSE-MsgGUID: A9E2ZNp8RAqJmCj3RO3HhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29035054"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29035054"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 08:52:14 -0700
X-CSE-ConnectionGUID: gCJRYYXTSwqvGlENIVCQeQ==
X-CSE-MsgGUID: Fg5yHJzXR/2bWddGZfRo1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79485793"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 08:52:13 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 08:52:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 08:52:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 08:52:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1/jrCAaKoQPNzt5W4z0VpP2JW6XG5mvLMFG88SMgurc5Rsdzagwj/YkRDL9scoaVkrFMheDkiW20K83eipJ5EsVMM6vMpgltNasyWVpkww6ntOljVOdtE9nV4eXU6UhqmbC7fnjxnBr7iFE5YxA1zH9dOTc7Jo3SKzj/EEoeG10SRjvK6zgCMKymoYRFM57kKoQ5QlIQgo6iuBKjN3gyoaQuYipoIwaSuUmMuk6/0TXRxrLoFozRWouLCBAwuyc6mQB8iVfni+HAItbEJIVab44nzsSwBAB8txb9W94ZaXLfBPXqfld50OZcGLGqBbBUbtpkVAqovRgz0cmLCD23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j104zYiQ6ix77elpKKhepwAHlSbNZRkn3ZdFAaFkBfw=;
 b=IioORdGlNxKGDfODoZQ2v55PK0NUaOvY8G2LQ1xwms4bj3wV+U06Ld0mPGAzsRd//ix7i47v1nvMpZzpN9KESljayw/j7MT/0fr/+ELa/Cq2pOQndgX5u1MoKhZv4BqmDVc7Jad4sSsCO1XxDpgi+wRJaI2vR8wdvbW98bAvES1Ya80P7PZGo4WzmqAYVpkuCb4ui+k8B6MlUFSyNzi2hbtbq06W8i92hIQBUJ61fS4hCR6TTXxhTnRi0Fjj5UufzSb1vFMlSXEIgsYo98r4K9xqb5deKAkpf+sg+0Jj5fGIZxoJp/IFq5s5R4Pz1ZQOgmkGRpGwPDE9hqbqlBeC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB7866.namprd11.prod.outlook.com (2603:10b6:610:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 15:52:05 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 15:52:04 +0000
Message-ID: <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
Date: Tue, 22 Oct 2024 17:51:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Daniel Xu <dxu@dxuuu.xyz>, <bpf@vger.kernel.org>, <kuba@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<john.fastabend@gmail.com>, <hawk@kernel.org>, <martin.lau@linux.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <lorenzo.bianconi@redhat.com>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk> <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk> <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
Content-Language: en-US
In-Reply-To: <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::26) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a2d33c-eda9-4907-e13f-08dcf2b179b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWN6SUlUM2RiVDk0bmpHVXhSRm9RZk5wOU1TM3JBZmRQMWdLems5aW9lalhL?=
 =?utf-8?B?Q093SU1KbUJNVzhsYXZDem5ROFQ5ZXhSdWdvcGlHeU0xRlZsTldxbERNMnRE?=
 =?utf-8?B?UFBDcnBRMDc1aWJQdG91WWY0NTRIK1JZSm1HS0pKNVdQSmE4RExNUzZ1b1lQ?=
 =?utf-8?B?L0ZVU09hMzloaVBKcjN4RjVGVHJJZTgrVHF6NjU0ODR2WkVzY2RtUjBHZjFm?=
 =?utf-8?B?WHJ5aENSbjBDU0oyMU9KS21MTmljWkNFSHY0dVVpNHoyZnl3R09pTjR1TC83?=
 =?utf-8?B?U0txMSthbHFaRmM0bnU3OFlXdWV4YWhCWm5zVVJvdkxDNno4QlZvRG5JbHBW?=
 =?utf-8?B?cXc2Nmljd3ZkL1QrWGdmQzFMSnRiZnlkNlZpU21YalN5a1cvbjdsSEF6WHk1?=
 =?utf-8?B?aGVoc0pCaGFueU1vK0tHQUJYbG55YXhxNStTT1lQZGRYelF3RHUyUzd1VE05?=
 =?utf-8?B?ZjU2c2g3TndPNHFVVnJ5UFY2VkJDc3ZwNTRpNXJWTGZueFZWaDF4WWJZU2VC?=
 =?utf-8?B?a0xHOVBaMHVnSE9PNkVhckNhN09udkVYWTkxeFg5WFlGZisvTVRIQVdjeGRD?=
 =?utf-8?B?ay80SXhNMm83dnJ5R3pGM0t1QjMvN2pENDBmUUpyWCs4Wll2cGUzTnJNZDBn?=
 =?utf-8?B?V2V4MUhhNlIwMG5hb3B4T3QzMm5KNlJuaUROZ0hsNWljeE1DZWQrS0VQRFJl?=
 =?utf-8?B?WUZ3akxEZEFqVXd0L2dURGFIbHVCeENGd203enE2QnFCcDlkelFTMzBTVm5q?=
 =?utf-8?B?SmF4UUJtRmQxS2M1WUZnRWJKTGQ3RmJuaUVpM2xFbFRnVzVuQjYrWlVkNG9D?=
 =?utf-8?B?bjhGeHVNNXlJSG96YzRQemdpLzlFQTNsSG1NR09QUy9OcUtBcVh1Q0gzK1FZ?=
 =?utf-8?B?WnR1Vk9mWXZlWFpxalNmZ3hLQTV0MmZnYVRJVEI3VGUzZlNzdHBVRVRaQ0tU?=
 =?utf-8?B?VmlhenppMjFGakpOaW40M1ZuZ2tQU0ZnVkxkTFArSXFKeWlEUldQSXQ4cHJ1?=
 =?utf-8?B?WHVKOFNwSExIeEk1S1NROXo0ZXlRY2Rxb0M5U3Q1UVNUclR1ZCtzTkVqNlFl?=
 =?utf-8?B?TUFaajM0eXhPV2NZNTh0MmxNRmVNbGJwbUROclJPcndYREFhbDk3OExrTDhu?=
 =?utf-8?B?Qk9ubTJCRUNmOWd1cUR2Wjc1ZTBYa2N0aytUQ1RRMmxsQzJjU0swYlV1MVVP?=
 =?utf-8?B?RXo1N2RxWllzNXhRODhwU3kxZTgxUEg1WEROOE80Qzl3WDRoUGpDNnJFNjdL?=
 =?utf-8?B?NlJncmZFSVRLaklFNHA2MFZDT1F1WDNHRWcwZERDTjZ6aEkwY2t3OXZ1MUts?=
 =?utf-8?B?VEtzQUZ5ek9BWGF0OURUM3g0QUJLTmt3c0JzVWpNcmNUN1ZEQlZUU1FMSjFW?=
 =?utf-8?B?Y1JucGZGem45MnNkaTZ1R2I3RDZNT2tBZ01OZ3I2R0F4VCt0RTNLWmJhdS9n?=
 =?utf-8?B?dnZ1bVk4UXlSQU8ycDJHREdLRGpJTlB5cnEyczRBeTRZbVFlQnFUSWsxVm5z?=
 =?utf-8?B?RUx5YzlNaEc5M0N3bWNoYVY3b2JUTFdySzFHRWYwNzVNc2REeEhzMTdrcGhH?=
 =?utf-8?B?WGRWcTM3ZnpOQlRpSW1FZG9OWkZPSmxpQkxlSEpFRnRVelBxZkQ3d0NRMUxH?=
 =?utf-8?B?ZXIrYWw3aUlpSjBJdEJTTkZpS2xUN0p4aFNHa2FyQmNJclZhS1Y0OEN6QS9K?=
 =?utf-8?B?aUdYa0lNRFRRbnI2Z3NvWFp5VTBReGhzS3IzSUZhRncvWUtacGJ3Ylh6cWJF?=
 =?utf-8?Q?l0DwrVjd+qhV9h9zaSVyzPlgyBbTQVEyEw3RYkK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkwwdWtaVWVBT3ZkYVYwdU41L0UyNnVVcHdCbFFybnRzVExqQlZUNEtUcytU?=
 =?utf-8?B?TXV3eElvUHBrcW1hVjhWaitmTmpqcFdidU9pNjZDRStjVFFKV2JWQ0trZEtD?=
 =?utf-8?B?K0RkNmFISEV1Rk1ucVZMMXFvUnAvYW9VaGxiNjJXUXdqTUhZc2JyNDNJOTdY?=
 =?utf-8?B?MlRBc3h5Q1NoeTY0ZXROQWhaSTNIakpMZUEvK0hxN1RHOWZOQXA3dktsUHIx?=
 =?utf-8?B?cXhUYzZFS3VqM3JKU2xXYzREaFIzNyszSnZaZEdpSUZwaXVJeS9McS9hVXVr?=
 =?utf-8?B?WVpzTFc0clBhaXZDdnYrdHJLd1R5dVBUS0ZVd0pmd3BlRXNLcldQcm9PaVdi?=
 =?utf-8?B?bjAwbUNobkNhY0gyMUxIY0tmeGdPMzgxSkZmZVJPQjhqUGtxOHU3cXBZcDZQ?=
 =?utf-8?B?UmV1K2J6Y3hMOXhJMG9qQ0QxNTBLVzdsaCtsSjM5L1I2YXhxUkJwR2hCTEhk?=
 =?utf-8?B?dzdheDdSZ1VudWZuSTQ4eUsvRkRieTJsV1JQRHFwYXQ4TTQ3emlFcWs2UnUv?=
 =?utf-8?B?N2ZMbFFNeGpIODNkLzVZNk85SjBNYmNLRU1tVHQxQTVPRGRURHRxSlpGN1dR?=
 =?utf-8?B?Y05lRFBHZG00Qk11cDQxeEF1dWovdXBBWHpna0JRM1hUUEF0WU9LVnNxbHF5?=
 =?utf-8?B?eUVNZXpHMVY5MHRYM2o4aEc0UWFuSFZCVkVpKys1ajl1WUJyVStURXFiK3pp?=
 =?utf-8?B?Mnh6cHlnMjhwUDM2eStEQ0xXdDk2WW9zTXBXSUtIa0JvVStJMHQzMTdFbTdt?=
 =?utf-8?B?VFI3eGVpb1ZzbDFvRkFWUWZHVFYyQTZSNis1K0VjNFpnMndMbnQwWkQ0cTI4?=
 =?utf-8?B?V0o0SVpoUW45Y3lFSzFCVnZtK0tZdmhldG5aa2N0NzNOeXp1TGV2QzNxTjlO?=
 =?utf-8?B?TmRVV1RJSmFOMllQMGxPdWpiOU5BSk15d2YyNVAyVS8wYlNvOW8vZzZBWUpp?=
 =?utf-8?B?bHdKb0tBREdPbEkyRDI5bXRpL3J2K0FhVUNCQmlTMTIycUdRR0RiakRoZjBP?=
 =?utf-8?B?V1FibmZzTXhmM2dmNDJBclk3SnNWWWxON0xjN0xLTWEyT3RuQ011Rm5xOGJu?=
 =?utf-8?B?QTgxWFd0TWRNc2ZPYmJvRjRKVXNTR1VYMnN1ZTJvSVd4am1LSjJTSk9MRlUz?=
 =?utf-8?B?NzYraW9wTVZpVmhmYkRLOTdDL0VqbmQ0TXFsVVFMSVZMdndoSlNCNWNXS1o1?=
 =?utf-8?B?VWdvQ0NuZFJRNDcySW01aXY3TGlzdHpBeFBDSlpxalU1UzJwVHlUOWRuay9V?=
 =?utf-8?B?a0JGb0p2TGFYUWwyZ3JoZ0xrYjZtMzlid3diNXNlTndPY2t1WXhxQTd0U2t6?=
 =?utf-8?B?Z0xXc3ZScVlVVlNzaU5NbDcwU3FianRRZjlrSElIVlM5aWs4N3NwWnA1T1Ur?=
 =?utf-8?B?clNuc09wcGR3N3dTQjJLUko3aStNakdqaXM4ZGp4ZkVNb2dSS3d2bnRCQ01l?=
 =?utf-8?B?QkR4SzRueHI3bmc0bCtBTWlMNkt0Ukx5aG8xWjVHd3ZHQXJjUW9tb3NFNGV2?=
 =?utf-8?B?NXRVdll4UWhGSEREL20rVk9oUGg4S2o4b2sreHlCTCtKTjEyR0lnSVdrS2xo?=
 =?utf-8?B?V20wdU11YXpaOFhrUHh4U1JEK0RWcWRBOUJVSmZybG1BbXc5YVo0UUlnK0ZU?=
 =?utf-8?B?NzBONXhlQnVTVmFRR2tabnd2OGQ3NVBpOHhXeVZzVWhEbzZKQlF0WitLL3dk?=
 =?utf-8?B?M09DelZtMElBYVdoT3o1QWNRQklzNmJCelZLTi9EWHNtLzhOVytCSVBWZU9x?=
 =?utf-8?B?cG9OUDl6cDNnaW5ETHFxVW15SGhsaTQ1eWxwak1MYXpqTDU5eDZaczRlbkIy?=
 =?utf-8?B?eWRKempVS1M5bm9SUmxrRVhMVkREZmxkdXY0a2R2R3FxME5SeVJnbUFOUFg5?=
 =?utf-8?B?anlpc0FYWlRlQzFoYWVsOXZJVFg3dGtZaDdLZDNIQ2NoSUFtMWJuWlplbHlI?=
 =?utf-8?B?UkVjcXlGS0Y2K2VUSk1jU014NDBUaldZdGMrbzJvZDAyZkY3NHVpdUpvSiti?=
 =?utf-8?B?d1JlaUtRMXcwQmhwdnNBQlQrbkhIOGRiZWJsVU9nWVUwd2FQRmhDcCtvS003?=
 =?utf-8?B?OEVOcjA2a1E0MWNjb3BORFRHQWtOQ3NsNFVNR2IyR3AxUVpJcmlIWmNtbHIy?=
 =?utf-8?B?TG5FaXVMMEVwK3kxeXJQb29KTjhTZzJPVzI5WFk1MWw5VnRYdSs3K1FSamJs?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a2d33c-eda9-4907-e13f-08dcf2b179b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 15:52:04.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpBFzUdz+dDu0o2/0iwW2DHLUynYkb0VGPUqTNaTRUgdReaUPMwKdmTKEF6AtSLnHdaC3pxAmwsvtYkmR8znrSdJA/El1NGjyeFig+Nbc7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7866
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Wed, 9 Oct 2024 14:50:42 +0200

> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Wed, 9 Oct 2024 14:47:58 +0200
> 
>>> From: Lorenzo Bianconi <lorenzo@kernel.org>
>>> Date: Wed, 9 Oct 2024 12:46:00 +0200
>>>
>>>>> Hi Lorenzo,
>>>>>
>>>>> On Mon, Sep 16, 2024 at 12:13:42PM GMT, Lorenzo Bianconi wrote:
>>>>>> Add GRO support to cpumap codebase moving the cpu_map_entry kthread to a
>>>>>> NAPI-kthread pinned on the selected cpu.
>>>>>>
>>>>>> Changes in rfc v2:
>>>>>> - get rid of dummy netdev dependency
>>>>>>
>>>>>> Lorenzo Bianconi (3):
>>>>>>   net: Add napi_init_for_gro routine
>>>>>>   net: add napi_threaded_poll to netdevice.h
>>>>>>   bpf: cpumap: Add gro support
>>>>>>
>>>>>>  include/linux/netdevice.h |   3 +
>>>>>>  kernel/bpf/cpumap.c       | 123 ++++++++++++++++----------------------
>>>>>>  net/core/dev.c            |  27 ++++++---
>>>>>>  3 files changed, 73 insertions(+), 80 deletions(-)
>>>>>>
>>>>>> -- 
>>>>>> 2.46.0
>>>>>>
>>>>>
>>>>> Sorry about the long delay - finally caught up to everything after
>>>>> conferences.
>>>>>
>>>>> I re-ran my synthetic tests (including baseline). v2 is somehow showing
>>>>> 2x bigger gains than v1 (~30% vs ~14%) for tcp_stream. Again, the only
>>>>> variable I changed is kernel version - steering prog is active for both.
>>>>>
>>>>>
>>>>> Baseline (again)							
>>>>>
>>>>> ./tcp_rr -c -H $TASK_IP -p 50,90,99 -T4 -F8 -l30			        ./tcp_stream -c -H $TASK_IP -T8 -F16 -l30
>>>>> 							
>>>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>>>>> Run 1	2560252	        0.00009087	0.00010495	0.00011647		Run 1	15479.31
>>>>> Run 2	2665517	        0.00008575	0.00010239	0.00013311		Run 2	15162.48
>>>>> Run 3	2755939	        0.00008191	0.00010367	0.00012287		Run 3	14709.04
>>>>> Run 4	2595680	        0.00008575	0.00011263	0.00012671		Run 4	15373.06
>>>>> Run 5	2841865	        0.00007999	0.00009471	0.00012799		Run 5	15234.91
>>>>> Average	2683850.6	0.000084854	0.00010367	0.00012543		Average	15191.76
>>>>> 							
>>>>> cpumap NAPI patches v2							
>>>>> 							
>>>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>>>>> Run 1	2577838	        0.00008575	0.00012031	0.00013695		Run 1	19914.56
>>>>> Run 2	2729237	        0.00007551	0.00013311	0.00017663		Run 2	20140.92
>>>>> Run 3	2689442	        0.00008319	0.00010495	0.00013311		Run 3	19887.48
>>>>> Run 4	2862366	        0.00008127	0.00009471	0.00010623		Run 4	19374.49
>>>>> Run 5	2700538	        0.00008319	0.00010367	0.00012799		Run 5	19784.49
>>>>> Average	2711884.2	0.000081782	0.00011135	0.000136182		Average	19820.388
>>>>> Delta	1.04%	        -3.62%	        7.41%	        8.57%			        30.47%
>>>>>
>>>>> Thanks,
>>>>> Daniel
>>>>
>>>> Hi Daniel,
>>>>
>>>> cool, thx for testing it.
>>>>
>>>> @Olek: how do we want to proceed on it? Are you still working on it or do you want me
>>>> to send a regular patch for it?
>>>
>>> Hi,
>>>
>>> I had a small vacation, sorry. I'm starting working on it again today.
>>
>> ack, no worries. Are you going to rebase the other patches on top of it
>> or are you going to try a different approach?
> 
> I'll try the approach without NAPI as Kuba asks and let Daniel test it,
> then we'll see.

For now, I have the same results without NAPI as with your series, so
I'll push it soon and let Daniel test.

(I simply decoupled GRO and NAPI and used the former in cpumap, but the
 kthread logic didn't change)

> 
> BTW I'm curious how he got this boost on v2, from what I see you didn't
> change the implementation that much?

Thanks,
Olek

