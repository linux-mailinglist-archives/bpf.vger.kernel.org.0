Return-Path: <bpf+bounces-21077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D38DA8478F5
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 20:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4854F1F267EB
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CED15E5CD;
	Fri,  2 Feb 2024 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8b19Aoh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1315E5C3;
	Fri,  2 Feb 2024 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899415; cv=fail; b=t0xbaT+i73HE7fPeujMCy/YBE95wLHfw2LcrFeeoyoPAKRG0+rbj9rWNRLX86CiG+C+nH+h65DX9tVYCMJYE1/3q3lPypcsiBdjV0DFdbMrcnRIdl9NXo5/as8dUDTpEQN0JftzRNONYBUT9VWGH7KDkHE0ZNUjrQMSmi0m15Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899415; c=relaxed/simple;
	bh=WKqum7Lweeyj7csPkN/hDiXrBoUcBi1Gj6T3jvhZsj8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGi17hJSuQi1/vqUzBHUWTXtjxPECHW1ibFdGGzKcHLzyZbv4Roo7St1IwLxyRUqe/0SXQstSli2dGP8esNRKfj6/zt175VJnMHBX7uMqP7rVTd7rQq4JQXhCgWhlH/s5wrffbBB0qDw9k3cwb5tnIfC9FlogLm0xkj4I9PaDKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8b19Aoh; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706899413; x=1738435413;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WKqum7Lweeyj7csPkN/hDiXrBoUcBi1Gj6T3jvhZsj8=;
  b=F8b19AohW/bSA2lsh0f8qoEYfgmqcX3YRei8+hDaf5OIsdtQNS7h4cul
   itQ1/1q+bWRktryn05wfYPGazFaAtWpCYXyRGZNGCtMHSj4ipBDbtJ+Yx
   7ZFnmYW1kk6x3WlVjfWezShd4Ez6lh3jUj1QFrjlrGLE05D5N0iP9VhhG
   g49zkBpIQ5XdpgN/q/PWph+AccwQABV85wxd7Ku8rb+k8VezIHxXU2MFS
   Atfa6ipBg9CCeBtadq7RCXnBSJZvibonLBv6jGQMPJa9dFeKpiM5L0j2c
   1GPQitG0wjeA4QKFUHqs1/du9mypiahPzsRFl8RCxKwrCIY2vUGeWjXvv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17629057"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="17629057"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 10:43:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="139382"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 10:43:33 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 10:43:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 10:43:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 10:43:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 10:43:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ89kc5avOqFI0pZXYiUI9W8CxdVo2kByIP9leDQJbv6R+Rqu6gFxHqnTQWR+aVlI/APbxiPwidDasFnhvfHp40PUCnGgYHJAvJdeOu3zlh7K536mFTVyIizsWAOPN/lVPhtkbPgzx106rfGytvnH9HwbeYx6/n0FvapS89MMnlOTsF354W+TYdy/mykF1KnjEVsao1oVZHaSzeJO2OTGs293T5fMHy5v0pIkyIbyUsdri66NFZc1m2vkV27RkhyZU9hqdZqSbFz6otAxWWhpP2uzE/8noDi4W623RmR2J8V1qF4KR+XOLx1GF7GosWgBAl8XzNia78rpZoTqDrIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gquSM6IBnB7/IH4y+VUoobqEGFzvy3FfL8P/bD2shVI=;
 b=JTb4hgaCq8NLc46NtrnqJJ5iUWd9QEw74qbH4Hr6WnlrZHLMTSYXeVuuNYdsxzOIMzhNTnhWfNUbWWJ/SBiqlbiIDkY5zZOXSJ8P1jUvkXPmIXqCMp6EBPyPFuW2B3Q4QPQXXFhjcz34TJGsfi8tXBkDhb9UTd1ZVfg+TI9qzGg6YSMKUuSYgIInADl9HWKe1GVTF1CUSNYLmTfwT7DdGuZEUeZ2fNE96AavK8WJOdxNVKp0v56g9jtEP0jERcALYyMayNf1iayBTQXWoha7FDl7DvWV09dT92r1JcFmYL7ipEODPtN2Eslp3EEED6BpIj2BqS15nIpbG8iJy56eOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA1PR11MB7824.namprd11.prod.outlook.com (2603:10b6:208:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Fri, 2 Feb
 2024 18:43:28 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 18:43:28 +0000
Message-ID: <eacdea9b-4d4c-4833-b7a4-ac0b042c9efa@intel.com>
Date: Fri, 2 Feb 2024 10:43:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/3] x86/mm: Disallow vsyscall page read for
 copy_from_kernel_nofault()
To: Hou Tao <houtao@huaweicloud.com>, <x86@kernel.org>, <bpf@vger.kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, xingwei lee <xrivendell7@gmail.com>, "Jann
 Horn" <jannh@google.com>, Yonghong Song <yonghong.song@linux.dev>,
	<houtao1@huawei.com>
References: <20240202103935.3154011-1-houtao@huaweicloud.com>
 <20240202103935.3154011-3-houtao@huaweicloud.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240202103935.3154011-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA1PR11MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c30c96-c230-459c-3dbe-08dc241ed8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvM4boNGxILdbV8yG5trDk4esgSWZ9lH22fNMNws8W7OML/Xs+VTtyk6/qLF9i5jUlrqW4Fm6H4+00mnzUGRSIm/ujY9fZQELI092B4ZBFpuBiDrU/Lu+HZjYHqU8aoYU/tbfUjCf68nI5b8Cmaf8TdxrocWKqNHvVl+SmE/0m/f1FZ5R1dqiGLOp1qDhlUMicc9sM/1nTdiTp7uDtNwKf9v6UXQSWnouK7dgiyyjgSJhooQRHkb3n0o7De0c/XkNuYh2GLhHb2LAKWwNY26geciZ+9UgtBrromo/Zh1X1VxYlt7MtWFoZgxhBp5hxJwep1DvN9K79EcAYziOPxL1+iAmOTKa7oZeSdWM/yGumOGl4iIP7DWGAC8202OKhSbKdSOI2oq+gMUVtv6ikeo4O9Hi5eOOyFOoZBC90r5j//JT1P9o/BXNaRMUBCDPaw346nMB6O08LtKyS1NbTcc6KPMKhLodObAVdxb4iGHE9J4GrPY0HHhPVAMJBdvwUuQiC6NPh1NuJ3HnZHsQVJ4aHvD2elqYXJ4ikXd/13HLuq07s6DCC0v6QPNHkgjnU8mvUdM8At81oZiJV9VHsNIoGVW+3l5FQC6oC1euBoaiaA4Lm6AvZMG4wdrXHZ+vAB5KZRhY8wrJrWPAg7ZJ0+0s4td8dRAqeWHgAGmTuWwVUexrifi0mIHJQdxfkp+fxLT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2616005)(26005)(31686004)(41300700001)(36756003)(66556008)(54906003)(66476007)(316002)(6512007)(478600001)(53546011)(83380400001)(6486002)(966005)(6506007)(82960400001)(38100700002)(66946007)(31696002)(7416002)(2906002)(86362001)(5660300002)(44832011)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNpNVAxZllFditqRnlqQ1BMVWwxZ3BOeWs0eVFUbUFYTG9RT0FFZm4wclh4?=
 =?utf-8?B?dExMajh6SGpBdks0Q2FxcFRRNmdqenEzU1ZoOVJ0N0Q1YkdLN1VSODVhTHFM?=
 =?utf-8?B?NXVaa2VQWTFYYUhCVk5kOFVhdEpwYklKSGRoNzdYYTVhd1duYlI4VVh2L3Ns?=
 =?utf-8?B?cWZCY1dDSThXOCthSU1hOGpTTVAxQ1llVXBINVZGUE83V09UUXdMcllqWW9v?=
 =?utf-8?B?TzAxTWlPcHgxTG1aS2RzblNGZ3orQVplRjU4Y05jcnNqM2d3cDdoVDBXdVFL?=
 =?utf-8?B?YVlBZVpKektWVzI3dDB2QWxKcnFuak5XSkcwZFRWa0w3SGdWam5JcUREbzZh?=
 =?utf-8?B?YlhZSmZtemUwbHBWaHRQOWd1djZGa1VhK2JobG52RllIMVU3eXRXSnZnQTVR?=
 =?utf-8?B?QUNicktTY3dLMVFKUnJNQ010L0lMYUQ2ekZuMVpubE1NYkVWeFJra2JzVlpM?=
 =?utf-8?B?Z0NyYWNJZ0ZocVM4bm9vUnAzSzFJZExWcmFWeWtYaGNQUGJVazVTK3Boc0tB?=
 =?utf-8?B?Ty85L0dJb3JLMXpCVWJtZ1hJbUdkYWhhWlBXdVg5WUFZWjB5amMxeU1KR1dS?=
 =?utf-8?B?UXJpc0xNRk9GTGdLZVV4ckpqYUlzdjVLWVhWek13dkt0aHFKTTg5V243WUVj?=
 =?utf-8?B?VFBiTG4rTk1QTWRiU3B6bHQrMHBFbnZuMERTYXA0TyswbkQrNmU3THA0eWly?=
 =?utf-8?B?ZFpVRng0NXVSeldORTJ1b294ejZLVURvSGRZMmhTV1k4M3lMaE9KOFFNN2wy?=
 =?utf-8?B?M2JBZXdId1RiUnJGVzlxbnYrLy9oOEJwREVEVWRSMTE2Z1NvMzNpOGhXOVVP?=
 =?utf-8?B?Uk9MZEU1OHNEMW5oa3hPaHd5UlRmMTdrNCtTazhVNnUwVlhlWmwzRUdzYjZp?=
 =?utf-8?B?bFBnT0liWXFKY3NjamFKdXY1WEgrVzdNcVFsOGE0SW1tdEwrWUUxc2ZIUmk2?=
 =?utf-8?B?U0pEdzB0a1ZrWGhGeTBFTzY4NUFyTlRYeUdOV2NZUmN6N0lNSHNmRWN6RVg2?=
 =?utf-8?B?RDEwMUV5bS92MHo2ZzFzRG1UUUhEYXRGdktJRnpiZ050NmptNjlvZDE0RCto?=
 =?utf-8?B?QjJLOGVVSXRFYTNnODNMYzg3UWNBQjhCTXEzaXZXNTloK2FuYmliUTZyeTRW?=
 =?utf-8?B?Z3dSekVmdUtiYmVFUkxBd2NscDM5VzJBWlZ5NjNjRmNnSmZWRFZ5UE1yMjJ2?=
 =?utf-8?B?TEpnV3hTd1Znb1BCWXpudllKLy9wTm0rUjc0TzJZdkw4UU84UHUrY2NHTFQ1?=
 =?utf-8?B?ajNGc1k1OUtzSlh6bW5WYmtraEZ6eWloTjJySEZyMlhLN1ZIbjErbGhudzZt?=
 =?utf-8?B?WllqMVR2K3hOYWdiUjY1d2NqcDlvZ3Zna1RxRG1EQzNPRzV3LzJLYkJSRzhY?=
 =?utf-8?B?SGdQWHh3N1BRK1Q0U1pZcnkzVHdrTVpXTExnRXo0K1pPRUdyVmE0M3RxVnhH?=
 =?utf-8?B?NHpqKzhIcEE1TGZETFVJKzJrT2FxT3ZLZWNCdUNpZERXMWdFVVBLMk5tamtG?=
 =?utf-8?B?TUw5NGhRQTQ5WGtrZ0N2YUpHU3lWVldWODkwSWFCOXVJc1lKSFVCaEZGNmdj?=
 =?utf-8?B?UnBiTy9ERW5RTXBxQVhFajIybWJHd00ycldua2VzYUN5ek1IN0VNb2lhSTR4?=
 =?utf-8?B?QVNyeXFhQ21NMFpLb1lKbGkrK2M5RVlMTVZyNGI0Vk1mYkFtdGxuanFLUkQw?=
 =?utf-8?B?RmFEL3VkZDljUm1wVVFDWXowMkpMNmFkUENxSGFGSDUxZVZpdHZoajlPcG9x?=
 =?utf-8?B?VldYaVRvNFAwUG92NHhXZDBLV2c4UFN1bVJJQTdjVmtubmd6dEpFRS82SkN2?=
 =?utf-8?B?dlI4dVJTSHQ4VGxtNkxvZkpLV1ZJWjczakl2NnB0dWZTNG1sQmJmNC9hdkRX?=
 =?utf-8?B?eEFtU3pmYlpkeGpCQzduYUx5M0xjbXdwMjd5Y3AvVkYrSVJNbE4zOWltKy8x?=
 =?utf-8?B?eW1WL01VV3oybFFxYWVZMC9Pa1N3ZnFscE1XRTIvU0xRR3ZXcU1vMncrd0dE?=
 =?utf-8?B?WU9RVVYvTDZTS0FvL2pVTXdYQnUzV05WMEk4WC9ZclRQeDJLZnhKM3BKMXcw?=
 =?utf-8?B?MzZpZWJScWVsQUNXVlhzaHZ5eTlFbFY3NXJzamhzT3pRbFE4cm5TNEhaaVpU?=
 =?utf-8?Q?veVkx3ZLjVUK8z+tKAS75EqU1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c30c96-c230-459c-3dbe-08dc241ed8ac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 18:43:28.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4/6EAGO357O+r+shdpjTmLk7eb67ekGqAoaGqRt2DMv8F47BYGzw/LJfDktxd6cfGi8zoMZV3uJVkqkqOiTPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7824
X-OriginatorOrg: intel.com

On 2/2/2024 2:39 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When trying to use copy_from_kernel_nofault() to read vsyscall page
> through a bpf program, the following oops was reported:
> 
>   BUG: unable to handle page fault for address: ffffffffff600000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 3231067 P4D 3231067 PUD 3233067 PMD 3235067 PTE 0
>   Oops: 0000 [#1] PREEMPT SMP PTI
>   CPU: 1 PID: 20390 Comm: test_progs ...... 6.7.0+ #58
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
>   RIP: 0010:copy_from_kernel_nofault+0x6f/0x110
>   ......
>   Call Trace:
>    <TASK>
>    ? copy_from_kernel_nofault+0x6f/0x110
>    bpf_probe_read_kernel+0x1d/0x50
>    bpf_prog_2061065e56845f08_do_probe_read+0x51/0x8d
>    trace_call_bpf+0xc5/0x1c0
>    perf_call_bpf_enter.isra.0+0x69/0xb0
>    perf_syscall_enter+0x13e/0x200
>    syscall_trace_enter+0x188/0x1c0
>    do_syscall_64+0xb5/0xe0
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
>    </TASK>
>   ......
>   ---[ end trace 0000000000000000 ]---
> 
> The oops is triggered when:
> 
> 1) A bpf program uses bpf_probe_read_kernel() to read from the vsyscall
> page and invokes copy_from_kernel_nofault() which in turn calls
> __get_user_asm().
> 
> 2) Because the vsyscall page address is not readable from kernel space,
> a page fault exception is triggered accordingly.
> 
> 3) handle_page_fault() considers the vsyscall page address as a user
> space address instead of a kernel space address. This results in the
> fix-up setup by bpf not being applied and a page_fault_oops() is invoked
> due to SMAP.
> 
> Considering handle_page_fault() has already considered the vsyscall page
> address as a userspace address, fix the problem by disallowing vsyscall
> page read for copy_from_kernel_nofault().
> 
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/CAG48ez06TZft=ATH1qh2c5mpS5BT8UakwNkzi6nvK5_djC-4Nw@mail.gmail.com
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Closes: https://lore.kernel.org/bpf/CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsjiW+UWLoB=w33LvScw@mail.gmail.com
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  arch/x86/mm/maccess.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

