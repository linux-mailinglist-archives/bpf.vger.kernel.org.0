Return-Path: <bpf+bounces-29110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CABE8C03F1
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 19:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06C21C23889
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E87212BF25;
	Wed,  8 May 2024 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZaFwuvHZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF08BEE;
	Wed,  8 May 2024 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715191125; cv=fail; b=EZMyxAv/cB0+GAShI7z0D5pBbaWAP7eH6C6oe23KAb2ZuOQTP0qgo0SueVP0obHcDdFyJkiV+tgY/oUHs4lvKXETpMEcQ/sQp9+BQ0/zgI09rpGVYcIQov27h6oj+VHdbT1OW2JEAMH1Oa0O53IH11UVitjBzSuq0h1gqefLh8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715191125; c=relaxed/simple;
	bh=XNGsMjACWDbCZUYSTYjJb8wbjuNBXPjB/KFxJLdY/84=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S5Pn7n/Eyx+6RVvqJZRpBrdYgKDlQWYzjzCUyMEhfIiCXUANDWLWqVXXzoTJu2NWUqru04cafJl0H/xm+oQhB5vVBXeHoq0aMONLLua2OtsbZZN7OAJimbHDFwt6b790hvmWPxrMwS8DkXnyGZMRd/AaRmp8OZDjyTw1IMvNqKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZaFwuvHZ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715191124; x=1746727124;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XNGsMjACWDbCZUYSTYjJb8wbjuNBXPjB/KFxJLdY/84=;
  b=ZaFwuvHZc+mnH17zpJPDIUOeR8tTcRlbgPLqAnsiTMHzJwzKACHr+rQb
   ol7tICx6lhhU5PYfglP3/Kb/SCtutbi2j7FQaJqEViZeuIGTMTFhdtAw5
   pWVlBhy1iRxBTt2MDNvJGtSSQrgKOPM35Qs/oC8nEFqGZWztZh1wLRC2R
   uxAgpJP5lJ5tGozto7fMSN08d8KOCcB7G69k76EIFqcouxzWeVXyrOTfQ
   b44oWIZBl9zsjMI7P1J5KaOf4H7W7O9YFRp7BTF57JQlfOB3FLP+zuamj
   6Nhd163AVgSeqNLIGQAFlf17dF1nB+RUlfHqZvMiGtDOmnHCPsE8qEP44
   g==;
X-CSE-ConnectionGUID: a4bUtIcMSDaynHk4yQP3WA==
X-CSE-MsgGUID: tRgnNYhdSe+p+hPC5zXxOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14866671"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="14866671"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:58:43 -0700
X-CSE-ConnectionGUID: v6pz6kn9SYq1cO7Hz0gdVg==
X-CSE-MsgGUID: OaGPT8ynRYydhV1jvIk4Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29063728"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 10:58:42 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 10:58:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 10:58:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 10:58:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHvVa8LVk4ZZ07XQq9k9P9eJbuBhD/i/brN3K5CZVpjqnVTdYoVqPwW6hfbaZbCWdsgntPXBj81dE2WBwVgZTj1hQZygY2TaoR7Ot6jKr/AUuwycDMSx8g5Z8t8HoBKtLAyERY0sMrzIZwUtDDG4K+hI6DVSMMTqCgyNgtwPYJIzZoazOpffB92m3wHJef3rLoxECmt6OgZOl3Ner9ad6A4B50uw5ihbJkiHxgsr5i5Nd+I4YjXjklyUJ4op7IEhsQZLAU24/iBAIrXctAEoky6RgYANmjwlrpV+7qFUJdXElwI2axuY5Vvkpe9E6KshKWIjK2mlYBNV1wNiswZ+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/WUb5i84YS/97O2YCY6bOHu+wCLfbVGG335mdyYZRY=;
 b=Zam4E/n0cXDqv0C+wPCAWRlCn6TFdqxg6q2G/r5mhbAb4bw+WysyyH9Ou44IzEUNGVWZKaCqtWi8fxB3VojNcEdNhuhXS4vsRUvIAAyfOTDwYQewJq/arTSF+fYljWjN5wqSAQJS9//hAhrh1PhEd2JaQGTeJ59FWKO7qAdhsyV5caa669ujUliLwTIZL/i3AX9mhhtk2GRws6B4NGej2uzn8yKCbSNDqGWsWPvuEqgGCMtfml+axjZbpp02kj3d3CbGQIXGFfOMOgJLUj2q1KHK7yXK4mL5CeqmmGhCuPZGGLWxBUs8KoZzZY6ECLeLUWvm5GxQmQyZqNK/lvqE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB8504.namprd11.prod.outlook.com (2603:10b6:510:2fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 17:58:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 17:58:39 +0000
Message-ID: <18a6a31f-bccb-4d96-8503-1d80b5eb32e2@intel.com>
Date: Wed, 8 May 2024 10:58:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v1 1/1] net: intel: Use *-y
 instead of *-objs in Makefile
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: Alexei Starovoitov <ast@kernel.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, John Fastabend <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>
References: <20240508132315.1121086-1-andriy.shevchenko@linux.intel.com>
 <6ac025de-9264-4510-ba7f-f9a56c564a80@intel.com>
 <ZjuLW8jA3MuT0oih@smile.fi.intel.com>
 <5ab7ae5c-79d2-494e-8986-d18d4a8e74bb@intel.com>
 <4038b9d4-6618-46cc-bed8-a0ccd1c92cd2@intel.com>
 <SJ0PR11MB5866F14FA9B7D02BC97942F5E5E52@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <SJ0PR11MB5866F14FA9B7D02BC97942F5E5E52@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 71538b11-b920-4921-10b4-08dc6f887d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1M2QjBXc29STEFOOW1tRUhENmxwVm43QlRIdHpNVnNHcVVwd2ZJUTJlYjkv?=
 =?utf-8?B?Q1l3U2xGL1hyZEg5RHRUUk1IUUlTRDZGT3FBVDdZMTZmK1RKbzNoT0ZJRUtT?=
 =?utf-8?B?a3BXUW5nY2tkYzVrMFJtNCsvNGV0akxaTi94cnYzWnM2MytyNGNnOGk4SUc0?=
 =?utf-8?B?NTJMNmM1cjNXM2t6Vk96Q05qUmErcDVHc0Y5NndLSVVSTEIxREdpVU43OEJk?=
 =?utf-8?B?R0w4VVBXT2VUQ0RHbjFZejZkSHMxT2kzS2JKQTdHZWNkQVdEbDNvelNncS80?=
 =?utf-8?B?WEpuOXlKTjc4NlJRd0dUZDVtOGo2MjJRQkVvNm4vbDVyajJ4TzJXRXlGemZT?=
 =?utf-8?B?Y21VSjRLcGRMcEQ2a0EyOGdOMUpIMkV3MkQ2bjQwaUlBVnBoWGxxa2dZUUNE?=
 =?utf-8?B?TGhXcjVQSko2QlJIRzFzZGp6alk1Tzk4S20rTTJqckhsWFZsdHUvRWZMY0NR?=
 =?utf-8?B?clpOb0xCcStjRTlvZlZpMzBlSXo2UlJSQkk1Vjc0NDBGcGx1M3Y3TjNLZlRD?=
 =?utf-8?B?U3VFZTNsa3ExRUhVbng1bUJBVVNXYU41NDZmR25kdC9lbXdiTmVCSmhiRGpy?=
 =?utf-8?B?cEh5b1YxUWFjY0VFNTRGQ0JqQUdTNWUrU054eEhybVQxL3pwMGJmdW1EMUtx?=
 =?utf-8?B?STkvaGk2QmxYbS9HY3NIeGxHS3JtNEdzb0VLWmxvY2tmZERWVkRJdCtIUXUv?=
 =?utf-8?B?N3ZzZURya3dOVVBWSG9mUGlraWxxVlVuOHJSVWZuRWQrVFpyYTJhRVZFUklu?=
 =?utf-8?B?MHJtNUVxTkpPVTYrNEVBQUYvYTY3NEpDRXJTZGIvZTNLT2JwUjVjUkJQbllx?=
 =?utf-8?B?K0ZFK1FJMWFqMFpWQWs1UUZjWVFqcGdFT0JndVY4d08vKzYxV0QwMStIZFBm?=
 =?utf-8?B?dU9TMzV0YXZGZ2NrYWg3NnJWMzZKWlcrR0hXMTlLNnhhdVB1VEdnSjdvVWJk?=
 =?utf-8?B?UmtDSXNJNzJNS2pmamdDTWtPRHBXc1FrR3pSYXl1b3RROTNHYzRWQnF1eWRM?=
 =?utf-8?B?eEpTRFJDN05DQTNPbHhJNVN1aEpiVW91RjJVVDVGVTJoSDNLTmJHclRXZXNX?=
 =?utf-8?B?bVQ3UENhcDVmSFVZNjZBYXB4WFlXeVJsK1ZmK1VITjYxV095VDl4eDRZZ2JZ?=
 =?utf-8?B?anAyT2FFQmRzb2p6NGJYdTF0UjNjUUF3d1VXZVZkaHU1WFhmWlhFWHNCeTI0?=
 =?utf-8?B?SkVzclVKVG1LaW4zUUlBdmNEN1MxUE9jQ2hxeUdoZDBqczBLOTZaR3ZjYlBO?=
 =?utf-8?B?Yks2aHFOK2dyNWpDZWVDYVBFbnlxTzhyU2VqTUtOU2pNMWdZRGc1c3lzNnk3?=
 =?utf-8?B?azArdUxtdkt6SXV1SXNObW1mRXkzYVF6RkY4VnA0dzBOY1I1Sk1nUzNsTC9E?=
 =?utf-8?B?eHN3MW9zd3JodmxpVVJkNjVqOC8xQXZzb3RsalhJZG1Dak5QSmJaNGd0M28w?=
 =?utf-8?B?QjhabjU2WmxxQ2JUTlBSRHVRN3hTWFZhSm1ZNlE4NHlxZnhibE1PaVY2NjBW?=
 =?utf-8?B?aDVENFF6VndMbkg1aDQ3aktabkgwbTRobC9vbXVnY3g4MXJwbU9KWk9OdjZS?=
 =?utf-8?B?YmZsSi8rRlJGamZMODYwS3cvMmlCbkVaLzJpbzFQSXJTRHhpVUppM1hURjRI?=
 =?utf-8?B?c3F3VzNWakc3L2Vmcmtra0tzS1MwUXVvOWsrbUhwblJCeFlOb2syQ2Rpc2xL?=
 =?utf-8?B?UDBlWHQ2QjdKZzFWR0RuTS9BOXdqM1ZFNkxiSDcyYld5ZmhHbU1tYkp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW1IQXNVTjloMXQ0Rlk3UFNVRHZ0VHVmdVpGaTdQMFY5RE5FaUJQYlpIOFd6?=
 =?utf-8?B?SjhzYnU3TFBqTWczWEFPTnFEYzFXcWs1K0hHaXlkTmcrT0ZqcGI3YmhsdCtJ?=
 =?utf-8?B?WkRhRlNwS1VGNWRjekwvMEJIY09CeFdNUGJBaU5DMzdmQkYya2N5UVJYSkQ4?=
 =?utf-8?B?dlZVK05zaDNBdjBnOFpNcmc3TGxPdVE3VlVxeTN6Sk9uYUx4M0RHQ3N3c2U5?=
 =?utf-8?B?YnQ1UHFkVGdIS0FFRms4SWx0VW1DanNqNlo4K1hNM3NjMjZyaWJiOXo3bDF3?=
 =?utf-8?B?dDVub2M3Y3ltMkJWcnEyWCtIZ3pIL3dtMFVUVndQVXE3aE1pcVNFUXZFaEhY?=
 =?utf-8?B?S1RMZTE3UkxUcXZUcTBxcWoyTHJRcndHOVhBMzF3RVErWHpBWUdwNkdkYVJy?=
 =?utf-8?B?aVdOV3B6dnVVUjB0QUtrOHlpeVg4dDF6QVA2Q1VEYUdJYlE5eXdrRXY0ZzRF?=
 =?utf-8?B?c0p5dG90aVIxVDB3RjhReEkrQ2FmRnJzbEJnRlUydU1lYlM5MVhCQXlzYllt?=
 =?utf-8?B?SWJUSWh3SUkySTJmUm9vTHhVOEZid1JWM0htZW85VnRwM0hQeldaeHk1YUNK?=
 =?utf-8?B?L3luWGJ1K1ZmY2hkeU5pR1pMc3RMczhCME1ZbnBmcHlwVWdUSlhjZzlCK1l0?=
 =?utf-8?B?WitxUTNKMUI3TlRvMzk1SFF3TXZuS25NUjRZc3FEclpaZHpEdDAzSDlQS2ly?=
 =?utf-8?B?V3VVMHJKeVo4TVN4WVIranVzRFBHczd1OXJSVTY2Tk9JR1FCdnhXRTNWT3BU?=
 =?utf-8?B?THJaUllLMXkzaVR0aTJDekRJU2tqcW1yRWtCTjU4NmZ4WjJuSHl1Nkd4dldF?=
 =?utf-8?B?azhyRXlUOEowR0xNRCtuSDBGZytRRk1SdHBoSm5ZZXdkdGpENmQ3QWZCODNY?=
 =?utf-8?B?eTNYTFhqaGZMcUhhRnhkNWlwM0p5ZGNzdGlkK0NNYU1sMU8wQkNxdUg4UERo?=
 =?utf-8?B?bWJrVm1SM1N0am1uQTQxenMwcnB0cTBOV2xHTVUxQXZGWTZLRW5XdWJtK3Uw?=
 =?utf-8?B?ZzFsNnAxeFBBZ1drdVZIdEE4anZDQXQ1eXVuRUFmSU0rZ09zMHB0Y0tyYjJQ?=
 =?utf-8?B?d1dLWGRJOVlTeUtDR2lldk5GbkFDZkhPWEQ1ckRJZzNjVzJMUDJlTmdob3Zh?=
 =?utf-8?B?U0ZIV3o1VmE1VTB1TlNvUnFRSFBIaXlNMlFxaXRtT21JTUxncWZyMCtwQ1FW?=
 =?utf-8?B?ODNWYTI1YVhIRW9JRHZjaGFYR0tFVS9DVm9BSHF5UEY0Vys1WVljWlFMT1V5?=
 =?utf-8?B?NXVhRUFsMGRsa25XYnVhSEVuSzRRclVxb3lsZnRBLzJCZkhXVmV1VUZ5Nlo3?=
 =?utf-8?B?VGN0ZXNNNTBlNHpWWFF3WG1WZ0p1SU9IV25WN2U4RDc2aUppYWRXdDM5TTFU?=
 =?utf-8?B?cEpOYkI5U0FpWUJ1MXNZZE4vOGIrNlowVzF2WXY5VkYrVEhVS2JNdnNVOTl3?=
 =?utf-8?B?QWYrR3RxT3U1LysvY2lYdTdKTXdqQzc4S0R4cTVkRkN4NlprVkg3eUhSM3k5?=
 =?utf-8?B?VXlxU2VNWFIzWVlERzNXaERDbXR1VXVqZGYvbTMxcjNKYmFGek52eWxjZU02?=
 =?utf-8?B?b2hudnlCTDVQbVo0Y0Z5dTMrZ3hHSWdLUkU0ZTZpK2dmcmdFSlIrd1N4QzFN?=
 =?utf-8?B?Y3RJUkVzWkx0MmRVR0wvOGZ0VzN0M0ZsbGxvMVByNDU2VElvd0tJWDN4cVly?=
 =?utf-8?B?ZEZoQVM4V0Q2QmdPRitadnRCaFVRSkdWMDV4QWlkdVlRUHg3STZaMm1YcG9o?=
 =?utf-8?B?UFY3bGNyQk05TkdEb1FadkZqbnF5Qit0YUt1RHVKWGxFL2NXYmpOMHQrYmd5?=
 =?utf-8?B?NDU2NnlJNkNRZkF5T0lFT2dGWnlsaTNSSi9oTlp4dXhFZFh6MHBqTnFuWGlo?=
 =?utf-8?B?ZkFERVpiS01uZkZZSDVmYk90djY0M3ppR3B0L1ZzdThVRG5NZ0hIK2J6SUpO?=
 =?utf-8?B?cGhhLzh4cWZsVXFxekZURVVxNFg2UjJlNW5yZUx1OE1zUXdWWHhPc0gxUW9D?=
 =?utf-8?B?N2wzdVB5aGJOR1lNMFFOUkVKMEh0eFo5bnd6aElHQ2NjMldXOWV6ZWxmRzdW?=
 =?utf-8?B?NmlENjgxb0Y0ZzVOckc0UnE0M0lTSktsZ2hsbS9ZaDVYOXppbUFBcGxNYkZY?=
 =?utf-8?B?U2NUdndlekZOK0IxS3psY0V2SHM4QnRLaDlqb0lWUUJTaGRleEFCNmo5YlU3?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71538b11-b920-4921-10b4-08dc6f887d81
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:58:39.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ioVaU9nLNYpI2KjL+AGRuu9DwKvuir6pwiT7Wv2aqVXgLsKNZzg2ItS3pSWm4oRhDo0LpQZz6O4o631lMNnJX2Btsb7hWKqHwhnsSiSMo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8504
X-OriginatorOrg: intel.com



On 5/8/2024 7:42 AM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On
>> Behalf Of Alexander Lobakin
>> Sent: Wednesday, May 8, 2024 4:40 PM
>> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Alexei Starovoitov <ast@kernel.org>; Jesper Dangaard Brouer
>> <hawk@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>;
>> netdev@vger.kernel.org; Richard Cochran <richardcochran@gmail.com>;
>> John Fastabend <john.fastabend@gmail.com>; linux-
>> kernel@vger.kernel.org; Eric Dumazet <edumazet@google.com>; intel-
>> wired-lan@lists.osuosl.org; Jakub Kicinski <kuba@kernel.org>;
>> Keller, Jacob E <jacob.e.keller@intel.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; bpf@vger.kernel.org; Paolo Abeni
>> <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
>> Subject: Re: [Intel-wired-lan] [PATCH net-next v1 1/1] net: intel:
>> Use *-y instead of *-objs in Makefile
>>
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Date: Wed, 8 May 2024 16:39:21 +0200
>>
>>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Date: Wed, 8 May 2024 17:25:31 +0300
>>>
>>>> On Wed, May 08, 2024 at 03:35:26PM +0200, Alexander Lobakin
>> wrote:
>>>>>> *-objs suffix is reserved rather for (user-space) host
>> programs
>>>>>> while usually *-y suffix is used for kernel drivers (although
>>>>>> *-objs works for that purpose for now).
>>>>>>
>>>>>> Let's correct the old usages of *-objs in Makefiles.
>>>>>
>>>>> Wait, I was sure I've seen somewhere that -objs is more new and
>>>>> preferred over -y.
>>>>
>>>> Then you are mistaken.
>>>>
>>>>> See recent dimlib comment where Florian changed -y to -objs for
>>>>> example.
>>>>
>>>> So does he :-)
>>>>
>>>>> Any documentation reference that -objs is for userspace and we
>>>>> should clearly use -y?
>>>>
>>>> Sure. Luckily it's documented in
>> Documentation/kbuild/makefiles.rst
>>>> "Composite Host Programs" (mind the meaning of the word
>> "host"!).
>>>
>>> Oh okay, I see. `-objs` is indeed only mentioned in the host
>> chapter.
>>
>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>
>> Thanks,
>> Olek
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Yea, reading the makefiles.rst again, it does seem that -objs only is
intended for host programs. The fact that it works now is an accident.
Further use of -y is necessary as we also use module-$(CONFIG_SYMBOL) to
resolve cases where we only include the files if the configuration is set.

Makes sense to clean this up.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

