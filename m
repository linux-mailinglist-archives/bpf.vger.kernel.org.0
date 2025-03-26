Return-Path: <bpf+bounces-54770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489E7A71D71
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 18:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA02018888B5
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 17:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2CF23C8D3;
	Wed, 26 Mar 2025 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYBx8iZx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A4223BCE8;
	Wed, 26 Mar 2025 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010857; cv=fail; b=H1u+9dkI90ir/nQWba1/J5lP/ErBYYoqt1XbdiPMEv6cWTqsT/0wqXu3xfBbSiwSEY5EGREjUkKn6cWf2s+/VDmtZMqUVo3XPtPh3IFh3iezoz/WL54T0Ze9HEEBcw4/q924bFtFNVJOdIkh/PWCi7eFQSJNtflL/aMlW5Czxn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010857; c=relaxed/simple;
	bh=FuoV59nXy7IXjmhZ2qfuivSuwQqS1McBN02Nqi7F4w8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iofm+JPFmnQbj6pnvdIKiEibJMeDoO+AOj+GhOghe6Q/zcdcZe8wwoccroE3XQ7VaPABXjrjjwzqewydw4bkfrf4mY5d53Z6/q/I1D3Nw4gHeinbQnmUK5xtRIGRMz7zDr301qmt34xsB19OsimD0E3U+dP2Ltbmg9UApO5jpX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYBx8iZx; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743010856; x=1774546856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FuoV59nXy7IXjmhZ2qfuivSuwQqS1McBN02Nqi7F4w8=;
  b=RYBx8iZxcGYbrlD9x5LMOBHvct/TqY7LLyHUe4N1djt9O3jMwbGWON+f
   ocjX82aS6UsByNrIRls0uiYq+7d76oytnB0k5gCcty554JgIF2tiaUMst
   LAZImZGf4YNSNqTrEfqzux6aTg7tp2UzrW4dOfPbIGPYhX+JdGyX+u0Zr
   yQ9Ddfm8ERUnIgYAao1TzH8k7TZ2rM6n7b56CMazxT9JKKkahGXVH2Qvg
   BlXnBjcIb7SEQcH3ixHU9QgSi4nSWWiWz66NvCpUHlavRfhyXOzmVsxeF
   X62PepR/NZwQ0o3JF4tNceyFgo+/OOHHKQ8A996Py3qmUn6ZXRri3gcUB
   w==;
X-CSE-ConnectionGUID: GlRBwGhOSIm5E+7QD4/83A==
X-CSE-MsgGUID: cTT8TIhyROG7pmnGggikNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="47054947"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="47054947"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 10:40:54 -0700
X-CSE-ConnectionGUID: hU73KtbpR46eyG8iK/kjAw==
X-CSE-MsgGUID: HQpRumhURsqI7War+Hz3jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="125791262"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 10:40:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 10:40:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 10:40:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 10:40:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXF3hnS9i5WHYjK/je8lR9mN39wR+HGF5mRxoouqCM1TRUwdKXIUuaQQZ42eYGpzi65digP0vqO/9Xgyvutd3TwZikizWNH6WqouOcx3e/DxHwndQSgmnWFab9fmc3PmSd1Q8bvGJLrAsPYViiGtOZZuxNvqU3QUpbJ3U9KIN3HxztGkoMbtkR8PDsPx1+wFMtvaB3hEJEktkTc3TCZGk/VUy1J98eElhBgG9XCmcvCPkuyyRulCHIoOXo3T5o8KwSh57xPUVtz17XipE/2prDQg86j5DAgxYlkLAkfb9v/K5z4VA0KLA89+woeC+YX4tW+5tCZRSshjvVh7wBl+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4M5rJCbHpWOI3Pyhj5p6+Udcq+EsA5n2Cgqr9/1EhHw=;
 b=StIoc8C8VMXdmWyRj910U275QWeCZQLUO/FlWdo56VKLWf4gQ693L8JA+vb4R2FeFGCVmVtl5e+0Y7cc5DRw+8d9Jw/h8yqwVKE3ujOc//cWDJCE/xMUSPnGVYGJHZtJTTnna/XPowpcrutHkr57psTIKRUF+tNHypkn+q/CfY+wp9z4iRIzPi0oBqPesJ2qAkhLklKPjM7QR3CgkZzs/kT8vfJmSr7bCs39krWowOnRUQ5pUy/wZ3zcqDW37/mkQY88w1/DW9sfNmxIsiE8aZxL9p7jPtXRwDrWKEENKmRFAyRdn5uYJtwKJUED73AR9TqA9w++dBzLfA6fBCgroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by IA1PR11MB7822.namprd11.prod.outlook.com (2603:10b6:208:3f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 17:40:33 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 17:40:33 +0000
Message-ID: <b025e2b7-ff99-4659-811c-8071d4aa8031@intel.com>
Date: Wed, 26 Mar 2025 18:40:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] page_pool: Turn dma_sync into a
 full-width bool field
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"Simon Horman" <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Mina Almasry" <almasrymina@google.com>, Yonglong Liu
	<liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
 <20250326-page-pool-track-dma-v3-2-8e464016e0ac@redhat.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250326-page-pool-track-dma-v3-2-8e464016e0ac@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0902CA0054.eurprd09.prod.outlook.com
 (2603:10a6:802:1::43) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|IA1PR11MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 6060d9f8-ec95-480e-458a-08dd6c8d4f2b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3lsU243M1hQR1NFbWdXWld5RW1BdXNoY1diNlZtMDU3UW5zYklQK0lpbEMw?=
 =?utf-8?B?NHZ3YlJET0lKNUdvQjVqQ0Juc0JycFVlaTBTUjNtbUxCWG5YRmcxekFybVdI?=
 =?utf-8?B?Tlg1cEp4N3hub0VwclpGZ1crNEVnMGliUXJHMGYwdzMxRXJUVE9YQXVBcGRM?=
 =?utf-8?B?ZnZYajdhL2lHUWJmdloyaWdyUkRlTk8vWFJLV2h2aWJQQkhPa3BBVXRJaGZl?=
 =?utf-8?B?UVpzdUVmSUhDQ2lkeEtMOXE2K3JmUmoxWW41Y2l5SWZncjcrZkVCSXR0NHBw?=
 =?utf-8?B?V3RSMjlXZm5Ib0pqaFlRTGJxaHJGNklXQUg1aHpCWUdpRk01bmZMT2JaeExp?=
 =?utf-8?B?VzBnN1NDOUNlN1VmUFd0YXpJS2NmOWtmc2N2OVFGQStTMHpHVzU3bS83VzNR?=
 =?utf-8?B?V0ErQkxvRHhuaTQ5cHZWMmxDZ0xqNHd0V0hidEZQWjhhdEpuYVZuckF0TEN6?=
 =?utf-8?B?S1BWaHFGRlFONkV6WUZxNjhaY1kxNkxRWmpvMm11aWZVWWoyRkRpNmFiL3g0?=
 =?utf-8?B?VGVpZE93Q3RsK2ZvdS95YUNnaVk4c0RPNExYYkhTYy8rZmNMSklUa2pwdWV6?=
 =?utf-8?B?UDA0VVZXb1ZDVFNEMkorc20wRDl6blM2aXdWYXBTUkdNQTdkbHBDdkZWMGlO?=
 =?utf-8?B?cEw5MFBmRmRHb0FXWTlxTVBMVVE2dmVCdjdrSkc0YWpZcFNqclJNRzQ3dHNv?=
 =?utf-8?B?Q1U5SlV1WTJvVWUrVzJCSUliSURMRUMxL3AyR0ZqZWlvMTFjeGVtWUZUY3Ux?=
 =?utf-8?B?OWQ2YlZoejVCL3lXaEVIV2ljSVhlUkVTVlQ5QlJVOTZiQ0hFUUI0SCtXMVR1?=
 =?utf-8?B?WFVDZ3M4UUo0V2xidzkwdUwzeGN6NU5XNnF6a3U2Y00zbW1lUnRPQWN0OGQv?=
 =?utf-8?B?NnNsT2N0TENvVUFuc1dDZzliTkxySno5WTRMck1nckp2NHdVMmt2ZlpWa0JB?=
 =?utf-8?B?TWFMdEwyY0FxcTZCeWJWTnl5S21zdmFxMWwxUHNGYVh2andwTmVoQWlnNm02?=
 =?utf-8?B?WGYvRDRpMjY1L2JsMCsrQUFkZWJ1WWM5Z2NXT2h5Ry9yUmtSVkU0cENGVkpG?=
 =?utf-8?B?RC9rc0IxazRURzJaRklZOGRqZEZaNzhySEhUV014VFNsVVdPZXhCVFpvMTBy?=
 =?utf-8?B?T20yOHpCcmRtc3hXQk1acTYrTUNCTXhJS2dkTVByTTUwUEUycEYycUVweXNE?=
 =?utf-8?B?c0ZZVmJTU01FMDN2Ymgzd2xReG9IY0Ywa0VkakY1U2hTR3Y5KzhvczVxZHBx?=
 =?utf-8?B?UmlEbmZ6QldDbVgzb1hENURVaHlGUjhUS2RlMzkrMG9RcUl0SElhUnlOV21H?=
 =?utf-8?B?WFowakFxdWEyQzlhNG84RFZrUXFBRWRFK3lNSUUzV2xTMTIzT0xqZ1JyQU9i?=
 =?utf-8?B?Q1dZSVROMTU0UG5heEdyQVpKa0tFSGx2ck82aUJvT2hnUzh4TVgvNWZtWml1?=
 =?utf-8?B?Tm9qak5aVUNsSXlXRk9nRHcyeHI3cnRWMXJLWFpMd203akJObTkwVVpTS3Q2?=
 =?utf-8?B?aVZSNG84bUNlcWE4a3ZiUkhCQ1E0NjBVVzBXVWxZSjVyYnVmbTZJellhK1Nx?=
 =?utf-8?B?UjBsZFBEL3plUEVpSzJIaktzQmZSQzdpcXI1WDVFMXJ4YlNJTk01ZmpWNzEr?=
 =?utf-8?B?Snp4eDRxYjE2dlJNNW5aKzZJa2oreldYSXQwQXUzRzFqTm8xQjJSVGRFQ1hz?=
 =?utf-8?B?RG9rY0hKQ2czVi90Vm9BUEhiampsMWZGWnhYaE1XaVAzZ0dWMU9TNjhHaUdo?=
 =?utf-8?B?bVJ4WXZkdVUxbHBkVXhpRjJHRXBBVXJLb0xoWkNQdEZZTFBHRVBFaTRJTk9X?=
 =?utf-8?B?QUZzUHJpaWpvTWpYa01kTHd2Wk9Ra2NwODlCZkpIWEZYMDAveitMOEJKeHFS?=
 =?utf-8?Q?c3O117H2wnws0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azNpTTZLejNvOHlEOUlhVCt4NjFqOThGTnJMZnpBUUhTWUlrclVLb0lWNEJz?=
 =?utf-8?B?dWRiRjdKRnhJdEw5VVo5ck53cVM5ak50Y2hvSGhxUElBM3cvWGxWbjk0VzlM?=
 =?utf-8?B?NklzZXJiM3JJSzN0VVYvQlRwb0JnQW1uM2dqSFVXZE1odDRTb2cyVnMzNUNS?=
 =?utf-8?B?SkN2STN0Vnh2LzYvTEdOV1d0Y2svTmNyVVBSOWFZL3FUTzJHeUYwaHRuYXNj?=
 =?utf-8?B?RTlQZ09xaDlKcW5idFBnVlZiV04yRTAzWTlPVEtEOHVjcDc4ZkgxdGVQZWFR?=
 =?utf-8?B?aGRKTytCTW1waUNsNTBma2dmVEt2QWVlZnBGYjhCTzRGSHlUT1VnMk40b0JF?=
 =?utf-8?B?d3ZkRXVhM3NOa3h5OXdwc0xuaUlUOVdsRmUxc3plYlNqV3NKdEt1dEIwSkhZ?=
 =?utf-8?B?cG5KMS83UUxZMzJPWGpoQzJpWG5lY1pkb0F4aHBHMmRWVmlCaGJmSWtjVlBJ?=
 =?utf-8?B?amFNSGh3bGljOXBhSEVHQjhwV3ovSHBBd3F3QVVYWm5JRWlScW9pQzRMYkFJ?=
 =?utf-8?B?NFJuNVVLTU02MlVKSEtGYXFkOVE2a3hyd1ZINVI4MytxaVdseDJIL0l0MnFa?=
 =?utf-8?B?RFpaOU9xblpCdTQ1U2IrT0JJM3lGNWxOK3NSVDM5M2RBcmNaaE1jWkd3VURR?=
 =?utf-8?B?Z0c5SEx6Ulh2QUFKN1A1TVdLVS9rZzlaT1owaWRDZkQ5YTZrY2dFU05FY0o4?=
 =?utf-8?B?b1hZN2pFRVo5cmtSN0RjOHMwK3dTR0pGU01qTHFKaUZIUVV4SCtYZXZvdThs?=
 =?utf-8?B?WmRpbVlGOUFTSTBmc2NtRktudGR5bVJ2SDhsZkEwSFBQTmxtU2kxcndlNFlo?=
 =?utf-8?B?dktHalZ0QjJJcUF1WDhHREtpaXdOU0hqZ3hONXFJcXRqR09CZEhNU1VtOUMx?=
 =?utf-8?B?M3VxVEdSR05CZHM2RVlrZXhUbXUyTDdrV2MvN3VBeFFVcFFaajB3V1JoVlJE?=
 =?utf-8?B?UTdjd0pKOXdPR05NVEY4R1NJV2g2R1JlWjU4b0hCNzN3NFNCTzdsYnJrbEx3?=
 =?utf-8?B?YnNuV3IxNFBrUEZ2UWtvQ1RJNzZGbysrUnh3N3BDTFBFRXBVMTIvNzZNblhq?=
 =?utf-8?B?MlJiZkp5cXpGeWtpN0NGUmVnVGNiZzZWVmJDTVlWWVFodVFZNnJsZk4wQ2hk?=
 =?utf-8?B?YTdiYWVpTi9xTmhuYVN5Z1FabGdyK1BrNCswYW4xdmF2SkRhVW52NEQ0WUxq?=
 =?utf-8?B?OWhQak9lR3NnMXVWSWtXVjFYSTMxMlFIdnFOZ3FSRnFkNE1uNm56bmFDV0Vi?=
 =?utf-8?B?QkhmL2I0ZEdoSkJIQ1BKSlNiUEYrekhKREtlWUtZN3VoUkk4Tm5Qb0RaaWdM?=
 =?utf-8?B?OTZHMmhQVnVNQk5xelpXdFBQNUpqcEdrWUJGRGFuekJiQ24zcm56UWdaem1u?=
 =?utf-8?B?VDJ0UE9leWVORXhwNGUzSi95OXYzTlJDUm96M2pZMUcvcjBobWNFS2Z5bmpZ?=
 =?utf-8?B?STU3dElIOUw3RVE4Sm1XTFVjSEJiWXpPNzFKb2hWZWNlWVpHWlhrNDk5eCtz?=
 =?utf-8?B?V0hobDZuRUVNTUhiMkNnYS9EakZVcWtYWTJXUy9VcG5qeDRwQ2tTU3FkUElL?=
 =?utf-8?B?cUp5YnA2NXRpZUh2N1d4dyt6ZzY0QkFOenorZDBETU5lM2t4RUVoS3JtR0sw?=
 =?utf-8?B?NmltL1NNdDQ1R3RNL0hEYUkwRWhORk5FM3BjZVE0K3dLdWU5YjVHU212bWxh?=
 =?utf-8?B?RTJWMTV2VXBCTG9iSHV1Qi9GV3ZyTmhHV2JpUEdTQWxPV1BMaElKanFzQVFR?=
 =?utf-8?B?eVBKb3c0TFcxanNybkFrV2RXUmRnY0FzY1lZZ25YaWZia3N4WVhZWWFxMGJ0?=
 =?utf-8?B?ZjNXRVp2U3BxYUhsbUFONHl2aWFhU2dDUFIzeDY0Mm9HZkZaTmozekwraktz?=
 =?utf-8?B?NkUwYVRUdnJvMm9DaWc1THlRUk42SXlWeG9jWDlrTGdOVVkzdTdGY2x2bHVU?=
 =?utf-8?B?WXpXUTkxSGg2WEFrM3Znd0F3OHp4NkFXOWp0em8xZjRzU1ZrelpUZlVTOWJM?=
 =?utf-8?B?NWd2UjJud3dyV0xyaFRVRElHUTV5bnlrZkVuVFRuRXQ1UHhqTW9aV3BSVy80?=
 =?utf-8?B?MU40WEw1dFd0ejd5TXkvaEZsbkJycGdhNVpFeTFYRERsZDNaQUFNRnNKdXVC?=
 =?utf-8?B?WUF6T1ZtMlBoUVAyaWFPdnFZYzNGODl0VCtnaEJkWlNqWnRBMGNkVzBhZ2p4?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6060d9f8-ec95-480e-458a-08dd6c8d4f2b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 17:40:33.3549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIjm6Oeos+BNiOIOa68JthgQMDtU5ohC9UTd+fjr3fqchkac3XY4zPJdXnqVg/9IRsA7o8Iu6kSfR+Tfh8TAkpEoJTfvInjaqJFxPsa9HKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7822
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Wed, 26 Mar 2025 09:18:39 +0100

> Change the single-bit boolean for dma_sync into a full-width bool, so we
> can read it as volatile with READ_ONCE(). A subsequent patch will add
> writing with WRITE_ONCE() on teardown.

Don't we have something like READ_ONCE(), but for one bit? Like
atomic-load-blah?

> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>  include/net/page_pool/types.h | 6 +++---
>  net/core/page_pool.c          | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index df0d3c1608929605224feb26173135ff37951ef8..d6c93150384fbc4579bb0d0afb357ebb26c564a3 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -173,10 +173,10 @@ struct page_pool {
>  	int cpuid;
>  	u32 pages_state_hold_cnt;
>  
> -	bool has_init_callback:1;	/* slow::init_callback is set */
> +	bool dma_sync;				/* Perform DMA sync for device */
> +	bool dma_sync_for_cpu:1;		/* Perform DMA sync for cpu */
>  	bool dma_map:1;			/* Perform DMA mapping */
> -	bool dma_sync:1;		/* Perform DMA sync for device */
> -	bool dma_sync_for_cpu:1;	/* Perform DMA sync for cpu */
> +	bool has_init_callback:1;	/* slow::init_callback is set */
>  #ifdef CONFIG_PAGE_POOL_STATS
>  	bool system:1;			/* This is a global percpu pool */
>  #endif
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index acef1fcd8ddcfd1853a6f2055c1f1820ab248e8d..fb32768a97765aacc7f1103bfee38000c988b0de 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -466,7 +466,7 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
>  			      netmem_ref netmem,
>  			      u32 dma_sync_size)
>  {
> -	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
> +	if (READ_ONCE(pool->dma_sync) && dma_dev_need_sync(pool->p.dev))
>  		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
>  }

Thanks,
Olek

