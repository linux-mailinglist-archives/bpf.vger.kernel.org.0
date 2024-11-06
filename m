Return-Path: <bpf+bounces-44127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B74C9BEEF1
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 14:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D049C1F25CEC
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 13:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F4B1E0084;
	Wed,  6 Nov 2024 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="je+W0iyN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D791CCB5F;
	Wed,  6 Nov 2024 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899346; cv=fail; b=pwxC1n7wLuJ6fwyncMtFBQ4QNEKUGDQ8XS7rGyy4eP7iOqfQ2s9rhBH/fqQr2YDTGARiodBbWfcJrPL1QoCa/3VOIgrApNXqneTEPZG/k3s2v04fLkVbVfzR8cNTXrR6EziLjXCce77uiIqCtPRyQnJvM12oCV4MCvefV++i8uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899346; c=relaxed/simple;
	bh=ONsyEEdHNryYd8MO2+8s7WIU/hlOKt6LoEv7IlCf7Z0=;
	h=Subject:To:CC:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=EckUgFPLA4kISag4LPmLdPweqk47PAX7BNY/Tj2Lzu+JwC+1WuMj2wy7mwAN4lG2XaLLLqMCbyQDB4m6zX+u97bOuUnU92FVQNah9AkSQ+9Tf/T71+PWl8TsCccMygg1/Lg9QFrILO0XXttabI4L0NsYV3ZsY1mK74NG4z5bLxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=je+W0iyN; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730899345; x=1762435345;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ONsyEEdHNryYd8MO2+8s7WIU/hlOKt6LoEv7IlCf7Z0=;
  b=je+W0iyNkkFc/sM8AuLjSXUVFKfyscpqF12aqcKC0SdrW7V6+M3CCu+b
   TS0zEvQSQWaG9oUQ07EV0XlpedzY8iOU1Pt35xSNowAr9fNsvnO2WHNOv
   WVRFa4uPhUxwYbKG9PcXB8IJYDXqRa31P+qqoLHhfMB1pNMGouK64NzbS
   QKQeuCcHC9wlh0FfOgDvj9YKvFDLTHcd9G7ACuUDnzc7Kx2cqJmlVD+KG
   10y0bpjSH5oZaTemplSYvY3jVrAXixrdGBeK4Yb7ZU4rwpJ5FK/vnSVB2
   u75EtczCwpmN9dLGKPC6AfpPdG/+/8ejRr8teYuMTBdXEe4LaBR8YXNm5
   Q==;
X-CSE-ConnectionGUID: my/FB0h+RiGizsPu2i70vg==
X-CSE-MsgGUID: Ji6A0EtiR8K8K21YnlqUZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30465940"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30465940"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 05:22:24 -0800
X-CSE-ConnectionGUID: x4815wZfQ96ZUF2QCvobUA==
X-CSE-MsgGUID: /9oqWVUrRwSQ6oMhjxPDrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="85373231"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2024 05:22:23 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Nov 2024 05:22:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 6 Nov 2024 05:22:22 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 05:22:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2WHwmN8maG29rdhu7x9sHX3wTFgCa1bdizkXlPojvwXT1B++Yy4nDDs+sBdMO3qw4b+Kh0cmqWvCLD8+TuOj7yidMMRs5GmAOiLnBHYDiR3fOUQebuhw2MSMOuQY5kWrPzOe2n3jWac/A60jEdClddH1zO94rTtRlqhgGE3mc0sfDOB0FUzlePeRXAnp0TwU66z9G7ixLVen3ErHBgkC1x7ruHbGozCbGLs4jWjx6nqT59pQD5B0CxQkLpf6aO/OBs/YQg24/De0yyjL7QLUS+VWlaZHdKv4Ojpwv+fCGolXEE4u8j26QVolGXAdxHWP1m2ZVYvH96Xv3Xl4dMlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIYS6I+WWM1vVh1Tu4irMCfKv+43wJmJRstyWMlIryY=;
 b=jXHb/8GliRT+do1TKuwqSbMJ9nA4B4uIdySRlkjxk4ZoxI9a7oO8NVi2aOwnmTHgMSOI1NnlPooAm6DkhEOqzDsggvQfJ+X1pq7kymjZCaQu7gzyuOalVbgjdTzI8LOlI5cAUv+AQ/KDRdbLAqDUyZfkBfoWD+h3/vlaYMlBbjAfNnla1tPNYSh2X/FgQ8nRuhSpM7Bm+BQDh1QLmArhF2OOFifV2cEpFttXqWk9vtWWUO5WLkIxQ4nzspb+fkuxn2/I48epUG0K4onil3JLOhZB8GLXV5gQFd7pjESOiTO/2T1vpaipoIEmCHV0Vz9wkSWW/pjei98wRqoYYZquXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4194.namprd11.prod.outlook.com (2603:10b6:a03:1c0::13)
 by CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 13:22:20 +0000
Received: from BY5PR11MB4194.namprd11.prod.outlook.com
 ([fe80::9d17:67a6:4f83:ef61]) by BY5PR11MB4194.namprd11.prod.outlook.com
 ([fe80::9d17:67a6:4f83:ef61%6]) with mapi id 15.20.8114.015; Wed, 6 Nov 2024
 13:22:19 +0000
Subject: Re: [Intel-wired-lan] [PATCH v4 net-next 1/4] igc: Fix passing 0 to
 ERR_PTR in igc_xdp_run_prog()
To: Yue Haibing <yuehaibing@huawei.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<maciej.fijalkowski@intel.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
	<alexander.h.duyck@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20241026041249.1267664-1-yuehaibing@huawei.com>
 <20241026041249.1267664-2-yuehaibing@huawei.com>
From: Avigail Dahan <Avigailx.dahan@intel.com>
Message-ID: <bc46b503-df05-6c33-9246-870cff7ad233@intel.com>
Date: Wed, 6 Nov 2024 15:22:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20241026041249.1267664-2-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To BY5PR11MB4194.namprd11.prod.outlook.com (2603:10b6:a03:1c0::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4194:EE_|CY5PR11MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a42f31-449f-4270-882f-08dcfe660a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUlZTHpUOEVZU29BSUt1VnBOZXlnM3lKVjA5SWZ2UUljTFJyVVBLTUlFeklm?=
 =?utf-8?B?cFZISHBaZThTbVBHMWZ5NFExdk54NnBsTHNMUG5DWWVORWRMWHMxdUtYditO?=
 =?utf-8?B?S0tjd2VRUHlwY1NIaithS0FnTUkyQXhMa3RRSTNXOFdIbnpIZGJkRXlLRjI3?=
 =?utf-8?B?a0VYM254S0U0ekRxOGIzRDI1MXlnZGhiY2ZvZzdqMm5QbTY4RkhwNGErU2Na?=
 =?utf-8?B?SWZVYVo1SHR0NUtQNUZRcTFoNmV1MkZSRnRwU3B1azRsdlFSR0FtOWU4UlNa?=
 =?utf-8?B?Tm01QUt1YlBVV25BZm1LYkRBbmIxcit2Yzl3cEt5Vjd3MjRDUDIzcVArSkc4?=
 =?utf-8?B?SW5uU2xuUTUwbGRFcmlpb25ONjFPMHQ0Tm1MOCt5U1cxZ1hWemVxMkxabWor?=
 =?utf-8?B?Mmx5YjdEVWVJVExJVGJHbW1YUTFSQlFOdFl2M0FpM1VmMEwvRTZ1QXhCbnVL?=
 =?utf-8?B?bzNzazBjbHJaRjIrbUdPdmNJdDdxVkd2SXJobS9xb1VQeSs5Vjl3d25FWWZZ?=
 =?utf-8?B?SWRMVW1SWWlQdGU2M3JMRjd0MUNKQXA2RlJEeHhaNXhEQnlhVmVJakM3WEVm?=
 =?utf-8?B?Ylhxd2hmRjhrU2dZMEtpT090Q1VXSXE1M1hzWWg1WkpPVFlBSXlsSmJZZzdi?=
 =?utf-8?B?VmJWeC9xYnN6b21OMHdHRFJSbGpRNUd6R2RxUVlZWmFHMXY4SE1Pb3lYVHZw?=
 =?utf-8?B?V2hwMVcvMWx4eGFFQWJCMjB3M3NsTjZrd1FlalFlWklHdGFodXUrS0VMZlho?=
 =?utf-8?B?alZPSTRrK1BORlo2OWhJcXVTOVhKNytLM0hkaUdXV1VKZ3JsMFZwSDlVSHFy?=
 =?utf-8?B?YnNYQWxNMk13YkhoTWVUMmxkTSswUFE4YnZERXdwWVdxSytJcFArcC9yeEFG?=
 =?utf-8?B?OUlMNjZFZGZFNlVhQmRCZGVVbzhQL3M4QnlteWJ3Zk5BK2JJUW4xWHl1Wk56?=
 =?utf-8?B?N1RFQ0gwMG5sMy9GMS9BaHl3Qk1mNUNVU0JsL3NaS3RxU3JBWktZcFlHZDVX?=
 =?utf-8?B?MElzQTVxZGZMcDZVakJaRmZxYmNpNC9kSFVlby8wejNJOWsrZ0ZKSWxETFVP?=
 =?utf-8?B?b2U2YjNmWXRneThHbi81YVVsa2MwYUhqUkROTHdVVW5RWmNZV3lyUEg5N09a?=
 =?utf-8?B?YXpxK09UbGVXdkFUR0MwdkgrZTJTWTZmUTR3eVdiQWpOYXAvMDlLbmdkMUxQ?=
 =?utf-8?B?WEZiMmRjcGdmalU3TU9xS2l3ZEdMK3czb2RVeXBrODlUaUtZYW1UV0RSOHJk?=
 =?utf-8?B?am91eDJSVGQ1UWt2VUh2NnJBazhoZkVmZGRaM1hvVWo3d1d5L1kxQXZaWDgv?=
 =?utf-8?B?ZnJZUHo5VzY3RFZEWnlzakRqMWZyYlo3Q0J5RXBiQVhPODRxZkExdjVHMTJI?=
 =?utf-8?B?enhRU0N1UDdZT3BtMzhUSm1rRFh6M1IzSW85SW1ZVDBvOC9XRFpLSUIvMGwr?=
 =?utf-8?B?c3hISDZSTjNaZTExeDZPb0RBTDFaK29pQzR5TE1mVU5oN21xMWFCLzVKZGR2?=
 =?utf-8?B?U0JLUW5oQnRGaTBkWVdDYlpqQ3BhWEtGRFpwSTROU21RZ3ZjQjEyVU9aaWpk?=
 =?utf-8?B?YXRxaTBlbzlaTDdTNFlIZSthTWxqcXA1SFFhZzVVSU51ckwyZU51R2J6VU9K?=
 =?utf-8?B?MzJpc0hYNXY0VUwrSk9pa1VaS1dhYjhFaXlXZytGWTJBV2ttdkUyTVF6amxC?=
 =?utf-8?B?UUFjcVVVZTNVQXh3VG9ibGo2VkpSNjY2dDEvY0FqaUViMHE3dVlLUkU2bk15?=
 =?utf-8?B?UjRXS2txM1QzNm9BYXpsR2ljbnB1ZG4yYk94b0o5UzhxVk9rOEtmSGZQZmVm?=
 =?utf-8?Q?GnNw4kEW7YcEqfQ7sgP7hXEe1IDn7HiNUn5iA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4194.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFI1R2tOWXQ2VnJ5ZDlvb3A4aU0vWk1RNG9Yb0w5NStrU01FMkFEMEtEM0FC?=
 =?utf-8?B?TDVCcjh3UTVpVXV3bW1BSi9QYUtxK25mdnR4aXBUYldac2VKWlVGS1p4Uzhq?=
 =?utf-8?B?cDR0VmVrcFVNa3JZM2tlZ3FkZWdOUmZIL0JSWjRwSDJ6eDhnMGZQRkU4SWxr?=
 =?utf-8?B?ZGkwWjBET3RpVUVxNmlCdGF5RXdiYVRIbDdHTXVJQzZKTURlcHFZSnp1cnp4?=
 =?utf-8?B?MkJPbGttWmhJY3l0N1ErTTBvU0tDNW5KY3VBWlNCVExuaUVwZEhzL3VVS2xn?=
 =?utf-8?B?WkJuOFVJWnNBdXhBZnNiTVNSYlZza1J4UEYrMU5YYzdUaVpiaExzM3FHSDFu?=
 =?utf-8?B?TWt1emJkYXJrTklNSlpxSVd1eWo5cWYrZ2wrNXRjSXFkQWU2Sit1bktDdnVh?=
 =?utf-8?B?ZEd6ZlVFd2F4NlFMSlpXTGdRSnEra1ZNVzM2Q3RoRFhoemhtSC81SDgzcGhI?=
 =?utf-8?B?ZmFKNXphMnFDOTF4ZDhxQU9ERENRcThhaEVXU3FsTXNHdTJjbkltOVlZN1lU?=
 =?utf-8?B?ckxMbXZFdlBYTFU5VHI2eEtlZnRIbENFMys1ekd0TkNrZzAwMWNNc0lXT2Ew?=
 =?utf-8?B?cW1uUElhUHBYbndmNkg1YS91VFB1VExxUzdObEEzL2dyTnYyVmorOXpJY0N2?=
 =?utf-8?B?aEdtUFlTdSs4WU03MTFhWXRzMWQ5akJNMHZ6UXIvb1g5SUMxRWFIRVlLOHRa?=
 =?utf-8?B?R0RDQytQazQxMEJHVmJ0bzAwY1YvVUFobWFtbXRXdXB0RVlENVZjSFlDUHdk?=
 =?utf-8?B?K1pxSHFjSXBCU1lveHRnMEVDVDY1ZjhVYlhhbWhYc2xOU0E4ZGpHeUJ6RWZ4?=
 =?utf-8?B?Q04vTEN4bTlRdkluV1JxeDF1bWh3bDljazgwb1Zyb0pLOTdqNFZPQU9NckVX?=
 =?utf-8?B?STVldTF3MEx5ZVpLNkpRZTRKUFFtVXlTT3puSVp6NTk5a2Z5cmlQOUVyUGFE?=
 =?utf-8?B?V2d3L2FENS9hcVhuRE5uQ0RHdGVEdU1vVDJhbFZJOW81Z2NPZk9oa1BMa1c2?=
 =?utf-8?B?MndUSEFBbGo4dVAvcEV1U2s1MFRmVWtmdnF4dFdVb3NGTGw1bzZpS2tWSHV0?=
 =?utf-8?B?ZWpJRWpMMWYxY3FIRXlvQWZyUG4ycXBidmF1ZUtNa0tkQzBvTkRoTFdzTGF2?=
 =?utf-8?B?aEhFbnJpcUtSdjZtbVJKc3RYc0JxeGdpdWNSVktJelZZMGlxMzhiRlNUQXIv?=
 =?utf-8?B?b3lNcHFmSG00VzJLdFdQcTR5QlhReFRiWHFFWkpibEpGd1I1QlZSaW1XUWJu?=
 =?utf-8?B?M0pSamJPZnlmOEtZRTZaalloVlZHKzU1TDN2WStDamhkYXo5QnNvTzRnRkIz?=
 =?utf-8?B?OVdTNXp4cE0zQXdzSFkzNFhwaVpBUWpFMkZueGRIR2xVYURnVlloZnU3VGtH?=
 =?utf-8?B?ZCtDMVpZZ3FPTHRXV3ZoRFBkRlozV1pseFExS3RVVmNETWJwOGlKL3E0Y1dT?=
 =?utf-8?B?R3N4RkJxclNLMFd5Yms1b0hPZTZJWi92NWFUVGNUNTl6ODZZNE13Y20xSzIx?=
 =?utf-8?B?cmROM2c5Y2UyQk1WUk1CamdIMjZncENTZ2E4M1BReXpCSVFQV2VFOTVhOTM2?=
 =?utf-8?B?c0cyNG1wcUQxTWk5dElpdkdHV3RJNG8renNGbVZYYjJ1L1NrS05FK3M1MURS?=
 =?utf-8?B?MzNOQWhJd21JUTYvbXplY2tuVkUyVitRZVFvWWg5Nm13TjFqWU4zTk0yZ0Vx?=
 =?utf-8?B?Qy9aNkRGTTZUbEVRRndQVldGN3lZSFJLSGtNb0wzRDdOWUpXbUpZYUc3K1BR?=
 =?utf-8?B?eWQ1VGFrMVpQd1ZVeWhwN2xJWGplUjZHaExHMGlZMXBqRmZVTkZpcFlqSGxO?=
 =?utf-8?B?d21Qa0Z2aW55UVZpYmpwRlBQL1R6NUtyai9Dd3dtMVVtbVdPV0cxTmZEZHFI?=
 =?utf-8?B?alJoWjBNcDdrcFJac0pGcWQzSnhBOHpEVVl3ZTgzbU9lMm9FRkViR3FhNDgv?=
 =?utf-8?B?a3RBMFRiZ2VBZ2FFQTJrWXNiR0N6bTVVOWhBb2pISGZUNzIraUZab2Q1VWxQ?=
 =?utf-8?B?YU8yVXorUTQ0OTZzcHRZaFBjem9ReUppQXk5b0hEZzQwaEszUWFxZE1zRENT?=
 =?utf-8?B?WXZJbnppVnluaXE4K1hnSERNTnh2NjBSTXpIRFB5VmhWa1p6cFpQRGdRZ3hk?=
 =?utf-8?B?WnJQalR5NWhGc0R0cU5md3A1K09BREdPblg5TTVzZVhWc21ibUJOd2F1ZUYw?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a42f31-449f-4270-882f-08dcfe660a80
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4194.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 13:22:19.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SethL3s5wxT197o4exOfBvK/lDeWw6A3iDxXC3sNJhqd+zx6EJug/2WMNgxorogkVhi9kCt4KJO2XjlSiXNsyccgDTSoa6kC81SOC+sCFkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6139
X-OriginatorOrg: intel.com



On 26/10/2024 7:12, Yue Haibing wrote:
> igc_xdp_run_prog() converts customed xdp action to a negative error code
> with the sk_buff pointer type which be checked with IS_ERR in
> igc_clean_rx_irq(). Remove this error pointer handing instead use plain
> int return value to fix this smatch warnings:
> 
> drivers/net/ethernet/intel/igc/igc_main.c:2533
>   igc_xdp_run_prog() warn: passing zero to 'ERR_PTR'
> 
> Fixes: 26575105d6ed ("igc: Add initial XDP support")
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)
> 
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

