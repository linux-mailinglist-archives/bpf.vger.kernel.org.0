Return-Path: <bpf+bounces-35697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706D793CCF4
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 05:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267542825B5
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 03:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6993E2262B;
	Fri, 26 Jul 2024 03:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYXjwuI9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E761210E4;
	Fri, 26 Jul 2024 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964047; cv=fail; b=ScaBGjuL9NphvSOe98VOrRu6+wVcJSOzlMnZZFu5opcPnc/qaBqZKR/oyt3Uwy1xBvctOx9iKCcODI+jekDQayIPertTUwA9UUwJe0C03ZPFPcYaf1cLj2wI2IodOFc6FJhkukBLr9pnIyJDCZMbt+upJL6v4SzdsZUx90KB8PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964047; c=relaxed/simple;
	bh=kjfoz+o9Rkj+CPfc4v5IwY2Nh9B20IKrGpyd5PnnR8g=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gNfFOHOCQj1kKGUe6CMtu45bXbrWf8zM7Xm7tu/HdjwQFqayJPBli12nUyN2U+72zfKmNEyInJYuAAyaaXohpXDqqqAoQDFFTOt+6T0HokNSLdEvvoEYo9w8oVCWCcgI72HIA1oySiHl6YgJOYBhttOdqX9h5VqIj0hT1rxZFmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYXjwuI9; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721964046; x=1753500046;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kjfoz+o9Rkj+CPfc4v5IwY2Nh9B20IKrGpyd5PnnR8g=;
  b=TYXjwuI9sAsre6BSOvvDDnJbHo81DPLi2HaG2oD+lMFAe9bfttZIJtv/
   cRkUdSW+8YtSHH5388Eof4Fchsl+2TPklg+0onuMB24qkXhHfCXZKrTCc
   /AW9nWht+y6YXoawuTF6c3isKbHxaampYxhM7K2Sd6K91DyLgDzD+ZR9C
   yd5Crj/6hlPiy4JuD/nCqjhEYlGVLomDbjEjWyGkaiADhc5+5EWdqBFmD
   b0zK6L9m1vXF7nBWj70AmCzZpBV/gwuQ3yM5KXHjU9MdImq8Ud7DqysZc
   JCrxRa0wpBogPQoaQCf1naJ3Mh9ehXJYd2zt6HW8dZYfMFjVNNqT/sX9l
   A==;
X-CSE-ConnectionGUID: cFABHF2RSH624mWYB24bQQ==
X-CSE-MsgGUID: /SOa6LW7T2yy36nQJYVAZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19867057"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="19867057"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 20:20:45 -0700
X-CSE-ConnectionGUID: ZRF3xud+T6+oJovAXXKWiQ==
X-CSE-MsgGUID: ZCA8qMeoSzSDiHaxpTN+Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="58249031"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 20:20:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 20:20:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 20:20:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 20:20:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynBsXdXHc/FUfGSGKouQCg4YdUlLRkmK6AFq/M8SKMdJCqcLgmOXeAVU3lOHwCWRy6xH4fDMYbnlmjpGKNNEczlNg5mzBqIxFLX5xD+tuf70fdi3OQQuYnHADaRwYdurXGXSFbW1kqCLx/XKmDReQMr2UIUDBwcePJr+nL6D9frPkPWdNQbiharBODaHbweLvt+KlxfuI6lT94hmPdFLN0n8IJJBn9Seb3AIO0Pu5/L9dwR76T4jZmO71V+gSO+UCz7x6XiQokq6b2aByrMytP3PMF9/FbsPSFQJDlU0eyksfp460hSBm7zlE9LLynYzky0KxVCqKxr3rHMZMKhz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gDelkpxZ2NIdHgUYKELD7Z9G/3kLXTapgjqffr4wPQ=;
 b=pe4oMaPepaqPdatGZv+gV5Nxsya4Tif2FtOHsc7DThIUWxwkdi0FlBPvA1yi9fYo0W6Mx+/wtmgNg2kMu+xkJ2ULOlIG9Vt8PSZbaz/+871eznzX9JPnKBX1ZrZ8ytoAqff8tOa2KE26OadAj2O6Z0BXDFkOL78+1ZiCv4SWM0/sDLYbI8oVrcl7AfSi+VRFjnQQ0EbAyO2db9PPo84y4YtIBXtcNnc8MjvpPVSMJTKTczp56SaMs7QpGy84CnB8CPoCK3wqwwE1XRsAduWxwLN7WUZ5jiOtcyfwqfJYIpdxD4it5K+lN7QTH7Xilm4DUbVKj1/QcCVunp5mtkKZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH7PR11MB5794.namprd11.prod.outlook.com (2603:10b6:510:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Fri, 26 Jul
 2024 03:20:36 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 03:20:36 +0000
Date: Fri, 26 Jul 2024 11:21:18 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <andrii@kernel.org>
CC: <ast@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>, <pengfei.xu@intel.com>
Subject: [Syzkaller & bisect] There is KASAN: slab-use-after-free Read in
 __nf_unregister_net_hook in v6.10
Message-ID: <ZqMWLlJZ/C/At0cA@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH7PR11MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 4594b8e6-f55e-416d-4688-08dcad21ea75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?msRzN3x5gR2EcmwVf10XMNzMqeQXnEXYEaG9Sg7wqRklHEXQlwlZ84xUE0mn?=
 =?us-ascii?Q?up67dYZ5dssoQ1tFnY9TZgN/HuUd4A+hblIuXxMrTTAcmf2M1bsL1TOS5Mge?=
 =?us-ascii?Q?JRoSlQjoxEJnB7h8Lhs+goaO4/x7KdCy+sGXcxikwZIshWyRYoH96kgpzLEW?=
 =?us-ascii?Q?dTIjGiVY3j32x3GARQW62eZ+lh4+HRHvKrAruZUUxGrq3frNW1Gtr03lBwkV?=
 =?us-ascii?Q?DYaZLPQ7SFSIwgs1Zxxqb5NUkxVWiCNEaeRJgmDwixUH40LC6Akg0eLQXrHg?=
 =?us-ascii?Q?ITKnP+so7VaEeAIpa5gdkmxbgN3Z5ZvtKfd1+DklyR7MtOdeO5wr++KXrWsV?=
 =?us-ascii?Q?GB/r+4Y9lG/2Z2wLpNdk/lroCIdVp+NMCZMc7qAJkgEKobXtOm1cxKccY+V4?=
 =?us-ascii?Q?arIJTu+3FZI+9XcZYqHRwu6Zcyq7NNitbjDubakvlDW6VXARSRML8T5QQPkM?=
 =?us-ascii?Q?sSKVBvz+8cqpLZw4YSfa6C8yYkU3gZAm6q7HbPooND1K4ffPlVESHbSneDlY?=
 =?us-ascii?Q?vF1gXFdtNTL0/iP9GelPMS6AJ0W6P343vI/yD3Qz+o+/du/6NeNPH1yg/WaQ?=
 =?us-ascii?Q?sy25EAqzpt0aH0S56wHYTv/88LU7/FV5RyphM0OZN+aaKqyH5SzKoUvAY0uq?=
 =?us-ascii?Q?eeuIpYlK492YDtvZVYaU5v90QT8myxPoFdbXtIisli9AGXBkB/Qyz8j4YGgU?=
 =?us-ascii?Q?o7zv6JFKiTpaATFn6aq0bMvWSc1B7nbeAlLqCg52OUgoRYxnMFVzeBreGca0?=
 =?us-ascii?Q?Wig4ZwJXC/bvb9it8JEQ3JRyE9cLebnwMwNBb25Z6+g12AobNOOVDIGENuO4?=
 =?us-ascii?Q?g5m5wDswPRvLkLqHgbwGqr/IpdNZrVA/IFs/IgL3WVNCowLLfuEZ7dfjD8g8?=
 =?us-ascii?Q?T65Pjiq4X0cg1nocMjbHzdvpt1O0so9bRXoaZFOcCptU30YdLmeoOqb02sd4?=
 =?us-ascii?Q?QW2WJvr/afIzXa4VQ8fNqSCXYq3+prrRm/MOtAXHXlG9TCwVjp/Chi9Xxp0V?=
 =?us-ascii?Q?GpsW+NIuowZcqDoM4LNJCL4mQSGMMPG+MUE8joZf4ejgssgwRYAVAgqdA1UW?=
 =?us-ascii?Q?JYemcpxvn9kcWNXIlQsnyVk/dUpWSFG0aWFfHzH8L/G850shkNi/Mtnk072b?=
 =?us-ascii?Q?Jy7yzTU/LDUnn5aYkoCpxrWDEkNnhooFmcZtxqywmIQFqNzxuyx1Hdy8J4uk?=
 =?us-ascii?Q?Nag0X1uCiryUDB1AWmU3qIHUZ0ETRcXhTA+nLVen268b5j6MXeSbnmtTKeip?=
 =?us-ascii?Q?zctNWVZpHfgZLAIpf5Ulw+WrPWroJQ38xv7+q+ZbQ2F9p/rE0Q/HGZt6W03B?=
 =?us-ascii?Q?c6g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zD61inAeDDMVwyNUemxOjr9WVL3jmQVT8zEfY8hrLzJE8qLU+Esra2sGERHq?=
 =?us-ascii?Q?Q0jXckLck8dHIBAdfZC/op+cQuUDjO1fxriwMf+qHM6UB4oE5M3PAXGSyugS?=
 =?us-ascii?Q?Z7+8MqbhCc/pZpyeh/R8UEZc6+yNGu6YS+7TlHPdnnvGNck+9b605orr6DCD?=
 =?us-ascii?Q?F3kx7sFFQYwOMDj9jcktzayrpyJHC4exF4h9Eco1xH/VIhUMeMBzKFPVXa/2?=
 =?us-ascii?Q?/jkWJR2L6/GW9pM61X/bIdppwtT+USUhPM8oen2k2ejPog6gu6DxKlbZeli4?=
 =?us-ascii?Q?4DdDo07e1/APMqW5ELkfJswF7fnIu0PhcVToe3Nz+t4WsGBr7pXxJuCSTZNo?=
 =?us-ascii?Q?uApdjuCcdF6j+XvM7a3KbdhXzR9CR0qJHnHXwuyuf9lL8yGZviyEOwrnbxF0?=
 =?us-ascii?Q?lXuHXhiRnFnVe6f423mze5Y5EwZeJ46T8d9Xapilox4W8fXbWPasyJ9YacI2?=
 =?us-ascii?Q?tGCLT2W4hEuUeenFOio7/gOwjh/xpCb8Yupw/kIyn3Mx71MVEM6gnEGOGTey?=
 =?us-ascii?Q?+Aq2G0gJkPVXg1EFZX//6TsaDxEtfATmtZeGBw7evzew0CV/HSVw7ICTJFk6?=
 =?us-ascii?Q?g+Fhe+XFAuCat91K1XiNsN5DdNBlvQVn9sdNvuskwsscgHxjZL9Paxnb8Gmj?=
 =?us-ascii?Q?pX1RYxG7BDi2ntSxQHi72k2PlP/GWR+WvOkWO+9JdctDYdw4TGgoIzc153D/?=
 =?us-ascii?Q?y98+oxCs+q2TaaGZHBV7BvJMd/HFM0N1UuIFpEhzJWyht2RVHmwaJbITUVH6?=
 =?us-ascii?Q?Fh3HUREZ9U9OieZcgYP5s0xN7ywcnCUUmfCtO7E2Shjm24vVHF360e8/++5J?=
 =?us-ascii?Q?TMOUNqZxHdAtTR3ZBo/CWzHnHeoEw8RaSvdc2kDnbEPVu+uMiv7Oxmfk8QL1?=
 =?us-ascii?Q?AQAjKaO0sPhwYdkg4GADMdESkxf8QV3csD0AWLLj5KE4phgo29voGQ8A/9uc?=
 =?us-ascii?Q?D/euCrOpo3ms7Onr+orURYLivAGvp5UtAkp+eCcwH6WEiG6zjTXD2pjuAjEc?=
 =?us-ascii?Q?1/8h3iTai4UpW5lobWC181pQfssvKHbW/raxX/Zcg7xLMgP5Gt9wGWFmTxka?=
 =?us-ascii?Q?6VrNnHnfgbHPla0xBwkqkYpM7TKVDkhPEWh9WLoq8rSwOH16R1LgcYDKRBA3?=
 =?us-ascii?Q?+XykH8FS56Rog58pLLHtrKzGuKiZrkMLxUoZLseXBzHRY5UDOJQhvwnVsj7b?=
 =?us-ascii?Q?3C8Im7yYXmlS1+K+qY389+YhRcgNpNb+ypZuT4ybtQaVR+49GCsfNpJL/T5x?=
 =?us-ascii?Q?LuxAFNl/QGqN/x/1lt4MHpyTqmtNcPil+qWLD0BbwbHXoEMBYo2+o2Z0gZbd?=
 =?us-ascii?Q?sIMQFZytPRXw2E7OtW7zUuWFibtZaYw4NsYPTVffIAVHIvPv1QZ2jsPFHFbq?=
 =?us-ascii?Q?HFA5h0ewAtYsycfTHpRpt0P5FLvOJPYqs1iwWf67CpO9qidSYyKEcVsqtf8I?=
 =?us-ascii?Q?GGrUN/pFRZOzxFLe+3SRESzomOKg2s9zFSVBYwBjJvsZdCyoy0DDOTMyyFd5?=
 =?us-ascii?Q?qEvfdrSpzwIS6wlbDmggfMrCnXnNtppBCT+lyeFad41nGR1SfkR8d4ReVMjF?=
 =?us-ascii?Q?dYXvxD3lsyqnqnsLOCIoAmly//uqqarGhileI9el?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4594b8e6-f55e-416d-4688-08dcad21ea75
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 03:20:36.0935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kZtuNGDZLIQ8UGw7HFMgAHyfQhAZAVSSxu9BglB/qF3I0Nvvu2BMl8RhQMZ0B/Y5zLuaG3b7G/KKL1PeB2gdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5794
X-OriginatorOrg: intel.com

Hi Andrii and bpf experts,

Greetings!

There is KASAN: slab-use-after-free Read in __nf_unregister_net_hook in v6.10:

Found the first bad commit:
"
f42bcd168d03 bpf: teach verifier actual bounds of bpf_get_smp_processor_id() result
"

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240725_142422___nf_unregister_net_hook
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240725_142422___nf_unregister_net_hook/repro.c
Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240725_142422___nf_unregister_net_hook/repro.prog
Syzkaller report analysis: https://github.com/xupengfe/syzkaller_logs/blob/main/240725_142422___nf_unregister_net_hook/repro.report
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240725_142422___nf_unregister_net_hook/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240725_142422___nf_unregister_net_hook/bisect_info.log
v6.10 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240725_142422___nf_unregister_net_hook/bzImage_0c3836482481200ead7b416ca80c68a29cfdaabd.tar.gz
Mount repro img: https://github.com/xupengfe/syzkaller_logs/raw/main/240725_142422___nf_unregister_net_hook/mount_4.gz
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240725_142422___nf_unregister_net_hook/0c3836482481200ead7b416ca80c68a29cfdaabd_dmesg.log

"
[   18.969108] ==================================================================
[   18.969429] BUG: KASAN: slab-use-after-free in __nf_unregister_net_hook+0x640/0x6b0
[   18.969781] Read of size 8 at addr ffff888014338f98 by task repro/730
[   18.970063] 
[   18.970140] CPU: 0 PID: 730 Comm: repro Not tainted 6.10.0-0c3836482481+ #1
[   18.970447] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   18.970932] Call Trace:
[   18.971047]  <TASK>
[   18.971147]  dump_stack_lvl+0xea/0x150
[   18.971328]  print_report+0xce/0x610
[   18.971507]  ? __nf_unregister_net_hook+0x640/0x6b0
[   18.971726]  ? kasan_complete_mode_report_info+0x80/0x200
[   18.971969]  ? __nf_unregister_net_hook+0x640/0x6b0
[   18.972191]  kasan_report+0xcc/0x110
[   18.972360]  ? __nf_unregister_net_hook+0x640/0x6b0
[   18.972591]  ? __pfx_bpf_link_release+0x10/0x10
[   18.972804]  __asan_report_load8_noabort+0x18/0x20
[   18.973026]  __nf_unregister_net_hook+0x640/0x6b0
[   18.973243]  ? __pfx_bpf_link_release+0x10/0x10
[   18.973516]  ? __pfx_bpf_link_release+0x10/0x10
[   18.973745]  nf_unregister_net_hook+0xea/0x140
[   18.973950]  bpf_nf_link_release+0xda/0x1e0
[   18.974145]  bpf_link_free+0x139/0x2d0
[   18.974320]  bpf_link_release+0x6e/0x90
[   18.974499]  __fput+0x426/0xbc0
[   18.974649]  ____fput+0x1f/0x30
[   18.974799]  task_work_run+0x19c/0x2b0
[   18.974970]  ? __pfx_task_work_run+0x10/0x10
[   18.975163]  ? free_nsproxy+0x3b2/0x4e0
[   18.975337]  ? switch_task_namespaces+0xf7/0x130
[   18.975550]  do_exit+0xaf2/0x29f0
[   18.975707]  ? __this_cpu_preempt_check+0x21/0x30
[   18.975927]  ? lock_release+0x418/0x840
[   18.976108]  ? __pfx_do_exit+0x10/0x10
[   18.976283]  do_group_exit+0xe4/0x2c0
[   18.976456]  get_signal+0x2387/0x2460
[   18.976632]  ? do_futex+0x14b/0x3a0
[   18.976798]  ? __pfx_get_signal+0x10/0x10
[   18.976985]  ? __pfx_do_futex+0x10/0x10
[   18.977168]  arch_do_signal_or_restart+0x8e/0x7d0
[   18.977385]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[   18.977627]  ? trace_hardirqs_on+0x51/0x60
[   18.977817]  ? __this_cpu_preempt_check+0x21/0x30
[   18.978030]  ? syscall_exit_to_user_mode+0x109/0x1f0
[   18.978253]  syscall_exit_to_user_mode+0x13e/0x1f0
[   18.978473]  do_syscall_64+0x79/0x140
[   18.978644]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   18.978870] RIP: 0033:0x7f464083ee5d
[   18.979036] Code: Unable to access opcode bytes at 0x7f464083ee33.
[   18.979303] RSP: 002b:00007f4640b15e08 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
[   18.979636] RAX: fffffffffffffe00 RBX: 00007f4640b16640 RCX: 00007f464083ee5d
[   18.979948] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000004101c8
[   18.980258] RBP: 00007f4640b15e20 R08: 0000000000000000 R09: 0000000000000000
[   18.980575] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4640b16640
[   18.980888] R13: 0000000000000013 R14: 00007f464089f560 R15: 0000000000000000
[   18.981210]  </TASK>
[   18.981314] 
[   18.981390] Allocated by task 730:
[   18.981547]  kasan_save_stack+0x2c/0x60
[   18.981724]  kasan_save_track+0x18/0x40
[   18.981898]  kasan_save_alloc_info+0x3c/0x50
[   18.982090]  __kasan_slab_alloc+0x62/0x80
[   18.982271]  kmem_cache_alloc_noprof+0x12b/0x380
[   18.982480]  copy_net_ns+0xf0/0x740
[   18.982644]  create_new_namespaces+0x403/0xb70
[   18.982842]  unshare_nsproxy_namespaces+0xca/0x200
[   18.983053]  ksys_unshare+0x424/0xa10
[   18.983218]  __x64_sys_unshare+0x3a/0x50
[   18.983393]  x64_sys_call+0x1b69/0x20d0
[   18.983571]  do_syscall_64+0x6d/0x140
[   18.983737]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   18.983956] 
[   18.984029] Freed by task 35:
[   18.984163]  kasan_save_stack+0x2c/0x60
[   18.984337]  kasan_save_track+0x18/0x40
[   18.984514]  kasan_save_free_info+0x3f/0x60
[   18.984703]  __kasan_slab_free+0x115/0x1a0
[   18.984890]  kmem_cache_free+0x174/0x430
[   18.985074]  cleanup_net+0x91d/0xb80
[   18.985244]  process_one_work+0x92e/0x1af0
[   18.985434]  worker_thread+0x68d/0xeb0
[   18.985606]  kthread+0x35a/0x470
[   18.985760]  ret_from_fork+0x56/0x90
[   18.985924]  ret_from_fork_asm+0x1a/0x30
[   18.986103] 
[   18.986177] The buggy address belongs to the object at ffff888014338000
[   18.986177]  which belongs to the cache net_namespace of size 6656
[   18.986729] The buggy address is located 3992 bytes inside of
[   18.986729]  freed 6656-byte region [ffff888014338000, ffff888014339a00)
[   18.987264] 
[   18.987341] The buggy address belongs to the physical page:
[   18.987594] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14338
[   18.987940] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   18.988271] memcg:ffff88800e70ba81
[   18.988427] flags: 0xfffffc0000040(head|node=0|zone=1|lastcpupid=0x1fffff)
[   18.988724] page_type: 0xffffefff(slab)
[   18.988903] raw: 000fffffc0000040 ffff88800d313140 dead000000000122 0000000000000000
[   18.989240] raw: 0000000000000000 0000000080040004 00000001ffffefff ffff88800e70ba81
[   18.989580] head: 000fffffc0000040 ffff88800d313140 dead000000000122 0000000000000000
[   18.989920] head: 0000000000000000 0000000080040004 00000001ffffefff ffff88800e70ba81
[   18.990258] head: 000fffffc0000003 ffffea000050ce01 ffffffffffffffff 0000000000000000
[   18.990600] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[   18.990931] page dumped because: kasan: bad access detected
[   18.991166] 
[   18.991239] Memory state around the buggy address:
[   18.991446]  ffff888014338e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   18.991758]  ffff888014338f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   18.992069] >ffff888014338f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   18.992378]                             ^
[   18.992560]  ffff888014339000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   18.992872]  ffff888014339080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   18.993184] ==================================================================
[   18.993552] Disabling lock debugging due to kernel taint
[   19.062957] loop0: detected capacity change from 0 to 32768
"

Hope it's helpful.

Thank you!

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!

