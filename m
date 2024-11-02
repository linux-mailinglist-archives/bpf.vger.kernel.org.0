Return-Path: <bpf+bounces-43820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B119BA318
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 00:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590481C2102F
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 23:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69C1AC458;
	Sat,  2 Nov 2024 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKHeeMxH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B82380;
	Sat,  2 Nov 2024 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730590921; cv=fail; b=PqiDiB70m+LpO0NCAXRBX9kSVlf187eNWVApV//YjkDnot6c8iRKRdv3+q5/DL/60Zgd1tdWZEZ1cdN36w+iZMH1YvsLNoY2P0otcgvcJlDIFVbDskIeeSLdmEt229difVQjSJjNBCWZqx0NYKbAYmm9efrLV2Nnw06uO9Nl330=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730590921; c=relaxed/simple;
	bh=yrRCSoqctOgjNbj8ss2HsUnEIyzp528/mXvE44LOZ0I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EZAcRAu7NxuLKyIjO6h3wkYBpyLkwM9FOMFooI+/pV6XTI3l6LSJpFwiTOM2nogHtBewhucNA/mOyZ904yilWqqYZjXPUIgfQ56cTfgjpJIkT9AETCKI4KgBf+aWWW/WEFJJCOV7tW9hDnREQQm8WnF0wUGFUxCrQVSNLutJbto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKHeeMxH; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730590916; x=1762126916;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yrRCSoqctOgjNbj8ss2HsUnEIyzp528/mXvE44LOZ0I=;
  b=EKHeeMxHp84i3ZJznT+mpTU7369NgIiwwvG5NmrB1e7f2CsXRxWzgoOK
   Jkk36ZPZlLTMP7xq/hZi2hX62/fWWghZskNNX8C/DmP0+2G8ex2t9BIIv
   nzKujJM5wMT0ByuGe4G2fTvIepe+IH4zJDwQt3gUb8SV6fJ5BLxtMJtoW
   dPgRaXAIcErUa34+Ak7wxRhijKcJk3kXqMVFnui9xfBaG1Q6m45/P7H/J
   HWJ4N3MPhedtJfegC3ey9GW4kNpvZb9lbBNgfGVrQo1N8LsNZvSVfgNMp
   GVZhmavC++Z59Fy7d7w1ZcV91GFHgA6AFROwXDGymF8CtfYatTCv6kdVn
   w==;
X-CSE-ConnectionGUID: ZOx69t0dQn6hFoanMGTEsg==
X-CSE-MsgGUID: CgGIfxbcT8OaYotVVYDYLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47776210"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47776210"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 16:41:56 -0700
X-CSE-ConnectionGUID: ciJJ/2hlRC6h0eIlLhgLNw==
X-CSE-MsgGUID: faQejIxVQiaCuBNo0tPQpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="82820467"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2024 16:41:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 2 Nov 2024 16:41:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 2 Nov 2024 16:41:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 2 Nov 2024 16:41:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlYlGNWocz74oV0F2aDNQsojxV7NOuOVQ4dzql5q057Y6WdbB+hFaRgU/Tp2rI1KJRPQAs6yp1eV+CgKghrkOqVdMYnHcUaZ6xVPuD5EdcL0bmH8hJ3sJI1loFUiv5djoNfc3M0owOILhrJ8IE0DVKNHlCUM6xUq/1GgNA5/vEWWbhDQeBLcNHDvax1xz2/s3HCHw3Dtx4gMuADNyaecvgSHfAnhigkqv/SyCXPFNZERF8XbTzf7qnU8udqWfZPpQ3COK7bniZXoenxe4186XGvBy7N3/tS18VeiIYMUxayu0ZZBdOja/L4dZMg3wFeHjuXglpYg+4wP7Vsj4xcW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhkF5dNFzC76wzV7iC7RjJnakoylYpStu5uV6ZyWDRI=;
 b=Lt/jprWCGAa5dVEFwfvwUj9cFsFeOFFo3o5HB7h43br0VwHy7f/LJojk8cdnICqC+36kf4fFcGQNl0wg9hO/Dj3JpJu8bIgF9/AY3/BThDmrLCIKQks0v41emtOlvUPQxaBiMPyvBhho9xSC+o14nRAp4YL1vLKVYY1IwrA+JlxA4uLK6QuHknW72zZp8ggWjbTFweWeyuUNkkxPKv736zISPIjMCc6YHK7CPxWtOG1UHcubXEzV0tfTlYk/K1Aa1vfYJtDAwmIupqxvArfuAq9xPfGEm461IvS5/OrCPk8fB/p/WFCbYEG3ChIdw/s5Q+z2hetBQd6QMGu8pW2ouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by SJ0PR11MB6574.namprd11.prod.outlook.com (2603:10b6:a03:44e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Sat, 2 Nov
 2024 23:41:52 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%3]) with mapi id 15.20.8114.028; Sat, 2 Nov 2024
 23:41:52 +0000
Message-ID: <c0a5446e-7448-45ac-849a-f8a9d1daf5c9@intel.com>
Date: Sat, 2 Nov 2024 18:41:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 7/7] docs: networking: Describe irq suspension
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>
CC: <bagasdotme@gmail.com>, <pabeni@redhat.com>, <namangulati@google.com>,
	<edumazet@google.com>, <amritha.nambiar@intel.com>, <sdf@fomichev.me>,
	<peter@typeblog.net>, <m2shafiei@uwaterloo.ca>, <bjorn@rivosinc.com>,
	<hch@infradead.org>, <willy@infradead.org>,
	<willemdebruijn.kernel@gmail.com>, <skhawaja@google.com>, <kuba@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller"
	<davem@davemloft.net>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list" <linux-kernel@vger.kernel.org>, "open list:BPF [MISC]
 :Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
References: <20241102005214.32443-1-jdamato@fastly.com>
 <20241102005214.32443-8-jdamato@fastly.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20241102005214.32443-8-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::7) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|SJ0PR11MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 973ece47-67b4-4931-555c-08dcfb97ed33
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXVBS1RGVmE1T3VQSzdkRlhVWEVDRndNOVZGaGZZR3hteFFQZGI1eWJJNk5s?=
 =?utf-8?B?UWlkWXh4SHpjSzcwZ0NOMzA3a3FjcytTODBMTXRFdnJvUWN0QWVTd0NiNzRU?=
 =?utf-8?B?RWxmWGk1WEdRaUY1dEdyVWtLa2hDNG5ab2FGRndpa2V4ejMxTzNNYWhwWVFy?=
 =?utf-8?B?M3cvR2VWNWdLdWJxeUlLY0hxNTk3dE5NQytvV3g5TFFEUU5wSURrcVV5M3c4?=
 =?utf-8?B?VlJ4ckpQTUJQWEpEcFplQW9UT0s1eG1JNmZKb2F5cW1vWGdvKzFyVk5zUWw3?=
 =?utf-8?B?dGdjbnUwOXRBTTVPY3FLRklRQllRSmw5ZDVEZEhPdWV6OHZyM3R0cDlnS2Fw?=
 =?utf-8?B?RW01SFErZ3p0ejJPODlqYWVjOWhrQnVKRnpEMStsNDlJN2JJblNRYlpoQVl3?=
 =?utf-8?B?RGZBMXJ4SVVxNWY3T1piZVdyY0NFT2Yzdjl1Q3ZTdWFlMDBRN0RERFJySmJ4?=
 =?utf-8?B?UW5JaDdFZEYyNWZHbmJ2cTEvMmJqNmR0bVZPVjF1cWJMbFc3OHJYRWh0S2s3?=
 =?utf-8?B?WGVxa0FaU3hsYWNoQWNwdjZtV29OSytJbU9nRGp6Unh2YWRzaUc0Vk52eEd5?=
 =?utf-8?B?WGRldisrZFQyNEEySmdyRDg2amNGMlJFQWxYd0ZnWWg1dkxFUUNMdlM3YU1V?=
 =?utf-8?B?dTRPRGNkNERuUXQvYkE1cVMyTHZrZnk0N0U1SU0rbmVOenhoMUxUTThrSEor?=
 =?utf-8?B?aTgrWkxzRlBqNkZTK0p6UGRqNHpxRnJzeWtweWVib0xQaVlJT21pWjF5d2pQ?=
 =?utf-8?B?K3JyTElkNFc1dnY0SDd2aXI4bTBnRHlRdGxaVU8zZUlOU1R1dm0yVHVJOEZS?=
 =?utf-8?B?VG1yQ05QaFlrN3pTSVNONXlGc1FIdmIwVGxIRFVyV01nMW51azR0aW9RaC9I?=
 =?utf-8?B?L0tMNTVybUVLSERTNlNiWjk0UjcxeG1QMTZVNi9KS2dvdFNkSzFsQWgrKzdu?=
 =?utf-8?B?OGtPbWx1OC90RVZHbFFkUXVBNjBvSUFPai9lbTIyY0RNYy8ySlE0Q0E2Nklw?=
 =?utf-8?B?OWRDUlE4UlNNTGREYmUwc1RHaUZpR1FJc3ByN1BHTXFxUExCQzFjT21tM2hC?=
 =?utf-8?B?YklaY2ZRVkE1c3lvVy9leEl2OCtrVkpzRXovdzNydURKYk9LMmZLck03R3o1?=
 =?utf-8?B?bzZaelBIY21qeUsrS0o3ZmFMTnQweUVGcm9ZdHpTZzJzUmZxdUprb3NzMG1x?=
 =?utf-8?B?VmFGVFVseHZ0Zk16NEs0Y28zWUJtRGRQMUVuWDdFcitkZUo4S0RMZDRiOUJQ?=
 =?utf-8?B?TGZGUjJObnpKK2R4eDhpQW1TcUJTTkY5dlQ4R1JheVRsTDFwTFVuUGthVTFY?=
 =?utf-8?B?cTdDOVhqMUQ3YkdrdGZIKzYrMGl2YVJYeHRsWitHSGxUMUdMMVlGNW81NXcv?=
 =?utf-8?B?NXc1M3Z4MjZrSURFdW1XNHFVSUFrY3RoMDJLQ3RsRnd1YzRDazhsMTYvdG1P?=
 =?utf-8?B?MFJ1ZGcyR0YyOWNOUGw4Z25Na1JXalFsdXErMUw2MDdLKzhnOGNxRFV3TGZm?=
 =?utf-8?B?TEwyWTFZdk5qRDZHVktpL2tvakd4Mzc2QTY1UVFFY2ltZ1I3N0RvQ0dvc0p4?=
 =?utf-8?B?WHBadDl3Qlo1bVdxTTZDeDFkaGhDUXk2Wk1mWnhSeWtVcDZ5bE03ZmZSWnhm?=
 =?utf-8?B?NTg4Y3lPQXFxdS91eWx4akY2ZU9jVXA3VWJldk9kbWh5ZDBZRnVucUZBdzlo?=
 =?utf-8?B?cjhSQVlUaVlDcFRKRVZnZHQzOWVOb1BkNkVzYXluTjNOVmFBKzQ3c09mTGJv?=
 =?utf-8?Q?nSWvLFmnn4vNdjnCvEqh0zu9mVG6mx48BDJwRe2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUFiTUFjMHJFVTRJMHVHNlBpdmRzNFFLNlR1VmJUWERrTS9iaGJLLzBKYngx?=
 =?utf-8?B?RjN1T0JNWVk0cm5oUm5ZMHZBRjI1cUJTYXBuZ0hkTHBuSnpWbnppQ2QvWWVo?=
 =?utf-8?B?MW1MbFRuMTJhK2t1dDJqK2I0dUROVWY5R2QzU1FWZmswV1dEajRWbVE0enEv?=
 =?utf-8?B?cGpGdFJlNHpXQzkzMlp1TVo2U2lWWldhOFdXc2NlRUR5eXpHOTRtMGJ4dWUw?=
 =?utf-8?B?ZE9ES2t5TnFBdDZmcjB4SXhSN0wyT1EwMWFQaFNKYjViV0xESnZMWWZDYnlz?=
 =?utf-8?B?cWwxVzdIMDUwNXFqZzIzU0xhZnl4cGNhcndrSE9oN0hCYm5mSU84K3d2OVRz?=
 =?utf-8?B?SlYwdXJCN0ozQmUxVXZudytvdEJnODJtY2N3QXMxcXNjQWhjNFN4YnJTZ1Nj?=
 =?utf-8?B?SjMzckQyWXFJNCtDVklzZWRUZzBtT3ZOVWZ5cHVHbTM1YjRkYS84UWpjbDhh?=
 =?utf-8?B?RzlvSDdna3dCQ01TUCtTb2xudE9LUHZjQkh6NmI3dE9rdytIeWNLekZIS2tp?=
 =?utf-8?B?dzhPbWpGY25tZ24xT3JQajVQTnFtZzN0OUQ3QXRLYzJxYStGQ21JQ1k5NDly?=
 =?utf-8?B?cEpUdWdYc0pwbTFyYXJOcDgwaU1NT0hoTEhBa0Q1RG90R1lNV292Y2JZNm16?=
 =?utf-8?B?UHNCMmdJS3A1UC82cFNVWWJ6MDFVV01YNExTU0dlWXBaMjUvK0RiVjNqQW43?=
 =?utf-8?B?QnBnbU1pUEZxejdhVE9BRDkyakgzUExCcVYrM3JNQWhHNTNYbVREeG1xWU0x?=
 =?utf-8?B?YzA0VkMyMldveHpOTE9zNDBIeUtybHl1N1V2OVhtK1h3R2ZCNVJ5Q0pNZ1lS?=
 =?utf-8?B?UzVDSjY0ZFdXS0R0M1ZMQmtDaHRYWjdzMzJpUzNvVWhMTUMvbHlBNnNidzdW?=
 =?utf-8?B?TVVMY3h5dDFpMkpwV25wangzSVB1TVZ1WDJPeW5xTFlQcWhVNDhjaEdSWmJJ?=
 =?utf-8?B?ZUFLY1NDUXBYUWdYb1dRV2pETjd3Rzc2d1VzKzlBaFB1M3hVUVdkSVkrelIx?=
 =?utf-8?B?QjhoeVFZMTVZeVNXK3V1dkRrK3FTaHZ2WklEcnJFYVdqZXQ2NDRBUXc0NWtv?=
 =?utf-8?B?WXN5RzY2T1BDaG9DUXdzeUxTOVhtcUhIQ1E1a3VldWxFZ2JYdmhESWNxaS8v?=
 =?utf-8?B?STNxV3FWVUV0eE1YcmM0N0ZSWm10cW9DQXN4SzNDQnF1allLOHZMZG8zR3Nq?=
 =?utf-8?B?RFNqblE2bFIyL3JleEF4b1lKTHhHWmlzYW9JT1NSdWYrd3ZqS1NLSERhd1hT?=
 =?utf-8?B?Wm1tUlpIZFoxRkxwa3FZcW94RUM5MEtyVE5XWm9RdEE2clNsdUpuV3gwME9U?=
 =?utf-8?B?KzEzNmpzV0paQlRWd3MrQTR0dFRoTHZiZms5aDNrbWpNdDNidGRnc0RPaG1h?=
 =?utf-8?B?aWgyVUVYcCtGbDVETXFrSWwrOHhrNzczUU5oOU5uTlJTb0xkTW9kRkE4dHEw?=
 =?utf-8?B?SGhXSWttTnd1c1FBcXdqQ2h4amxZM3RGclBaZzBGL0t5VE1HNHJPRlRzZWtx?=
 =?utf-8?B?MTRxMVhLUkg4dnlxTWNOQU5NOGRkdUNsendEK3JKenM3dkxVNzh0SzVBRFA1?=
 =?utf-8?B?Y0hQelU4d3BrMllmTHk0MzJacVhsVGlLSENFS2hkTTlUK3JFY1lob3ZrR3RI?=
 =?utf-8?B?K3c3dU1vc3J5WHdnaVlvbU1xK21wYVBKekdWVUxsTTk3NW1jZEFvMkN1dHNs?=
 =?utf-8?B?TnBGUDR6NDNkZWN6M2orR3FuaEgwQ2hTMlBUN3ppQ2NTTGZDRjNoZWorZFla?=
 =?utf-8?B?VCtMVTczN2dwSzJKUTJ5d2RFalM4ZUFDMmkxOU5UejVMeDQ0UXdIZkVJbjFt?=
 =?utf-8?B?Z0NvcFErSXAwZ2I3KzZJeExFZEV6SnJZcm9xTDcvay8wY1ppYURxK2NEeDE0?=
 =?utf-8?B?Z09PVEd6NVZuY2RjclNJNnp4U0FRR1VkTVBjdzEvdzhQMitncFJmQWp2SUIw?=
 =?utf-8?B?RXNucjJrRC9IUEJ0a21rMDhFLzY3bE03WkQ5VThIVEFPbktOTEliUktJMzV3?=
 =?utf-8?B?S0xLK1dCVXhGbGs2NlVsUk50bnJtdHVUZnhWZDEwckorZkVWa3FtSmNFT3pv?=
 =?utf-8?B?bG9icDZKamRpanZUVHVIQ1I4QU54Sno4cGROSmNLWHQyMUVxbUV4Sis5RytF?=
 =?utf-8?B?Ny9XUGhuNnMxVkh1ZnpoNWw2ckV0cUpxRkRWeG1lUEx6anBvMkg1VUhYV3Zk?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 973ece47-67b4-4931-555c-08dcfb97ed33
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2024 23:41:51.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gB4TUIRC2p/dEndgrMXv9G8tQCC9iaGWU1hgWK2Y+uHT4HQcNz3Y3vyaoOoDxcuoZj5pXOMU4tyoGm7X+Fpx9Qrpt7ZCnRqXrHg6htS7t1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6574
X-OriginatorOrg: intel.com



On 11/1/2024 7:52 PM, Joe Damato wrote:
> Describe irq suspension, the epoll ioctls, and the tradeoffs of using
> different gro_flush_timeout values.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---

Thanks for the detailed documentation.
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>


