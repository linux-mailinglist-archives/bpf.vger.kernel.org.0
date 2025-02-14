Return-Path: <bpf+bounces-51511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84022A35499
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 03:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD913AD2D2
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D401487DC;
	Fri, 14 Feb 2025 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiRXq67q"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9878013C67E;
	Fri, 14 Feb 2025 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499271; cv=fail; b=Zk4qbcy4U7FaFEKzRv0lSh0LXlZBahbINl3xP+HSjx2B5wLPN3OtOlOGvO4s7coertiEvb4Bmm9znFBnc0cnzA1jID2XR//BWNTjEf4y51SmQgqHZ//XsvML8Wx6eS26Ghpf+F1n+jCii2KhPvH2CH7UIdZzyhSDeYMOKirvow0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499271; c=relaxed/simple;
	bh=ZgiZwakUQuufpHJltYUDo6v1E29Wknq7xftfEIAr1BU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xs15sLgQTMInKDm8jKC5efGazmuhLMu9a8ZPqOU3yFyr1O1ZUx9SHm0onGp482o8IzloFPaGoBk2xKjX8fxKpbUZvEBtlw1lbJLKrJF0byXStIjzNe7Qje2CdLj3I/nTTB5pxEtlDlclt77ZF1TWTENYoKHbZ5/nMDm8lfOsL8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiRXq67q; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739499269; x=1771035269;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ZgiZwakUQuufpHJltYUDo6v1E29Wknq7xftfEIAr1BU=;
  b=RiRXq67qswJWVHGJzctuLXBN0c1Ng5z5zNqOSycnCJJakdHvR2UBnrcZ
   PX/9R8mB+hHZ45hF9jBlEiz0UwETUCqUI/OMaIeoLsV2SCamqEbpq7HyR
   /HHE+X3sFsy+B2RmsVnadalAJ4hoZw02Im7CbjFN8jEccjR3yDk7tNSDP
   61XwtCbjBRPsEZejJn7jqPB4AsO6FKW2Rh50bgA8eSe4KkcaQA9mip7Yt
   YOLmKwaMlWR4ukpOW/ZRC19GHmomgl9QaiNMOeezXyF+iS5PBjekYYGMc
   3X6a6E52YpUhPb5kZz8GCQ8UoSpNKr0ZBhocQ50iDWtOuaZfVCmchbroS
   A==;
X-CSE-ConnectionGUID: 0HKNna1HRg2UtsNVb8pDCw==
X-CSE-MsgGUID: jp2qU3XdSjCU3g+OIdk3lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40496834"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40496834"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:14:28 -0800
X-CSE-ConnectionGUID: 44AlKqwmSfuUTo8RhOWkxQ==
X-CSE-MsgGUID: l9fawTbXQF2wCGXLKFxngA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="118338351"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 18:14:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 18:14:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 18:14:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 18:14:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+qSWNVC3FiHaq+HAvz/dQXY2p5bKc4FLE7WzWecG8oH4r4Ydr5hET9T2ce9xxwNeiCMH2uAM9+ksg0dKYH/QiFLSlNf1B8hvF3u2ftNFgilaSysHaYK8kS3S84/oCZywcfTfnWyV815WbbcWrpK5WDyCW/aSVC56q5PJxmG+wsQP6nGXz1h0cqoQcoIpufTmQ06DPCdlP4UMElw6mJC9HB5l65SB+yJZlMkiwG57RbHcFz13WTU6rLTvge0JvqXLLIYsWE5GXBZTdqhM+0cnynZyLkfVLO/8stntI3poB7vPsfUUKaUgQ/T0j6cKO41JZ4C6MrxrDQ8ZttR/LH2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp3vxsiQuK0KTKhLu+wUI/yQNukY3dHJ3DN6sMRQwWM=;
 b=yFZlIuYzcXx92iFj7UCNhrNvAzd25hmnZwbPSgB3j1aSxBZH/6skawFEJ5LAX+C92VfixWJ4ujZ2WC5US4ZxHikUo46T4+j0lzfmGKJ3nfNpX0B50/MVGdqwE8Vwxe0TKh3/7z4YfqOiwdFn/i7VLMliU8DIjIQGLPKF5ksjU3Z8pPA3IDtVfTh87UH5XhTSuf/z/3eDdK8Fkkk6Mr7vMh0jLyQxM9Rt+XuGquG0GMJ3opNhXGJtsxy+XYOzLBLEBmqomBAF+psJkFJMnltCMPGNJqMF7JIxRTK1TAOw2O8Pd9faWynSxodUBuHxysUFIM8wI9E++5ue/IWdG1WBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8743.namprd11.prod.outlook.com (2603:10b6:408:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 02:13:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 02:13:42 +0000
Date: Fri, 14 Feb 2025 10:13:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: zhangmingyi <zhangmingyi5@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Xin Liu <liuxin350@huawei.com>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <linux-kernel@vger.kernel.org>,
	<yanan@huawei.com>, <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
	<liwei883@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/2] bpf-next: Introduced to support the ULP to get or
 set sockets
Message-ID: <202502140959.f66e2ba6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250210134550.3189616-2-zhangmingyi5@huawei.com>
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c9b14a-b078-4726-b768-08dd4c9d343b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hqkd38RKh4A6vMDsoG3hr6aezeFfzOnWCm6Tm6PCdPjn+DZb83L8kF0yMx62?=
 =?us-ascii?Q?tjhpCtXwKZETXP2qnJrTnUWoXGhPEu0bdghiCFPYaQ3ZR73pcE1Uu9IEzDAy?=
 =?us-ascii?Q?rpWLDYvbueotlMqLzLIOrVtVr7Cymw5CsWEPGzNBx+wZrRCj9dVNvMeMxtD2?=
 =?us-ascii?Q?iVOILFC0zrN+d79jIJ+KmEWhKuS9mVKN8x3DiqKlzFrHKn4S4K1jT/o/q7rU?=
 =?us-ascii?Q?rGuMJJZQDGexXRbn6oYyTdKQFlrw359/QQOgoXtuaiqQHt0uTdQ7rR9vEimy?=
 =?us-ascii?Q?cEmy+kaf2N73OSKheudjUEq7hsJAeLjBvvt74hYQXy4x9t1HF47pNjxKmqDS?=
 =?us-ascii?Q?zPZz5LFVMeADmfoIQ/SX7vfUCCV8fcwrl76KSwqkbiRU/phyo709CS4vGsec?=
 =?us-ascii?Q?i8YjGaFPQXygORaILfhC63cvAuN83MuYTlTvY1AVBfpkTiqzlyc57vrXbrCH?=
 =?us-ascii?Q?Trmnfe0QP9wnhbkEsE3JH6Xax5eSU5oark6zRYg+Wy0jpOaaTw6VH85gaP9Z?=
 =?us-ascii?Q?vx6XzYUMvkO1qUCnJ3lxfK84vsLSPDx8plf1Kyf7S46QYTenVrQdOCXqPdpC?=
 =?us-ascii?Q?dMy+Ttqlr/Gqjh3oWdrguPYUs3A4obIOa9UOYseRDI9qYmY7cKtOV6Z/sn+f?=
 =?us-ascii?Q?x76xNWGxejyEjLD6YJ2vP+7Sqlb03NaaGDzQ75+atQIvs7vEs31SDZeDZUrz?=
 =?us-ascii?Q?yPLd1rfYB3IJUTygNH8vxKEznX/GDYD6i4V4z5suTykMc0Pb/AkjhfNEtKG9?=
 =?us-ascii?Q?kFS0F6AzkM2PsnIKuampqhhPsjsH/wnydSOWtAoqA7/MnW5hjsujzUXiOb6m?=
 =?us-ascii?Q?jyRTb39Q1MZDVd6SmQKQ6fqHZIxruPWXqPMEWO+4V2+jwRJco7T6Yf04ReHc?=
 =?us-ascii?Q?mOo8r2tvHS1wwe+rPzBg3arEwd1ZRIMZRN2uKpqtmuc90O/3ssWNCXs87opW?=
 =?us-ascii?Q?ldqSF8TsrMlfxygSpoZ+CWkRdJzXtyzayL6eClcezAKPx3AlWZtDHrBfCxlF?=
 =?us-ascii?Q?u+JeiSu2aj0MHvGpM4UQTJauNWGkLThaiImACCN+m8SRQ2DRPsO01+RJASyT?=
 =?us-ascii?Q?IMg0xtnAzr58uHUNBcokj1BY7JA/Ko/EG6AZkqxdEMdVNhjOECTFmoWHcbKr?=
 =?us-ascii?Q?tZ5x4JmtV7FZvrdnUcgDtsOusM3JzgTPbmf5z55Qh7lRkJ5ZVyCOqSiAG93t?=
 =?us-ascii?Q?IXJYDK9uozSehv9SSjdC1M3rN6+TeSRdv9N3i7oET7JNefe3GwOyXsUebhCB?=
 =?us-ascii?Q?DobWv4wjDr4X64+H1gdASZEg+xJdZ+x3rZNClwBGYEw0EuUVaAW9KdKBjx8E?=
 =?us-ascii?Q?UH06FDLnRnB4L7kjA1kNdIfHK134z10uWd8fi9MIdfZVOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nzq4F3LrmFo5gRuykN2J6c1juedBaIWF7B+XibKQbi4S6f4ZoY2Vg43JSJI+?=
 =?us-ascii?Q?iCHq94cs2KK5RPrZe18yma03icNkK0grI1ePU2G6ddylotk9rA0c8/Vwh/oY?=
 =?us-ascii?Q?rNbQIXpNuygiVnaYtVFSEGWnk/O8UJPeZYhbT6pPJlNG1GkfmBztd6Xr1qAo?=
 =?us-ascii?Q?twQ4nhCK4lXzS8uRadAWU/mAqZRDCFhSZMeJVGPvSYDTa7Xg6DpUsnsOEsVl?=
 =?us-ascii?Q?yt8oCNE9ayqGvCSvA/+XSJ/pHsmqDcVtbAaiUykU+VVCX0/YjqF6rv124snf?=
 =?us-ascii?Q?PdhkmAPzGwyz0k8/ITWGaW9ybEC/FWMKjLcXPnuXjNf/uHRPDLjphxipC6qM?=
 =?us-ascii?Q?22uYc6yFOQ8SL+wra75SkxjbXGpbJTpQ6T+nrQSK1GZUJiTDJ9MVOQJPBnWI?=
 =?us-ascii?Q?6aOZ91lwu1BvzOm+gHMP8M228VZfFIRcFxA/bRZOiJ4VHFdVjsYPsIFl3/2J?=
 =?us-ascii?Q?G82GWjCVAQbHKDC2lmWP09b3rSaEhaPPlghoftxJG+Y7LsfKzjvwyvC/hBqG?=
 =?us-ascii?Q?K7RilGmuKsl4WoZHuULGgzGJvkWwEO98Y7nJTRwL9QQkPiFfHzX4vGo4F5kV?=
 =?us-ascii?Q?GsbClLpQAx3B80Y8bYOkqVPmre8nu7JQt3YQa0Y+GlHfgopMNFg+sagYn0Ph?=
 =?us-ascii?Q?rnYzL4dxGFvn2irVCFCvcCHEej6xjDltiBvC/NVhdIn5LAfdGrtyiQvRZeQn?=
 =?us-ascii?Q?QMv7pAInVd0hJOsts5FNio4Pun+XEej1E4CwGGtdP1Fl79nYMtLwMpEhDab3?=
 =?us-ascii?Q?puco6wJRQT1FYz11/+tGzYq+ByiJdHmEW0GHtqZ1KkIMYR4Vj4XrcN55jLIJ?=
 =?us-ascii?Q?5rvSA92mc6efOunWezoCqskwLeh50dtkfgbdTaFThhRkYp2MdyiGJY+wQ7IZ?=
 =?us-ascii?Q?Wm6wq0IjmHjYBfbu5smUNVeZGgSeWsBmSa4pUTLUeOsROO94SDNP1phYeHFz?=
 =?us-ascii?Q?PksOUQo/komrp8j9nzqb3HhGhfvUtfe1vM4AWKFDLUTyPFoTlSZQuORDsyWZ?=
 =?us-ascii?Q?k/QJMmyxrwf5odHr3jpMbkOkfuUcVEHdB/YS9e2A0VMrWmz/i3wePyu0rngq?=
 =?us-ascii?Q?zWIQWVmnectXAyNcv9GPsZXLhCpcJhq8SYApXGKTTQNHxE2RBnhk+7aNaLV/?=
 =?us-ascii?Q?2ucmYFqwbqo1YIIu2Gt7F3qqjLmwFWOkiR5ETOeZet4DgTIx1Cba7xWfVWc/?=
 =?us-ascii?Q?aC3zknkuxqUBFYO9JIojz/ivedYB+Hh4ldvDpZeSOF9E0dMXjpWWaq1yEwWh?=
 =?us-ascii?Q?I1YPr5ndtIkDq3gs1X3tukcPd/s1chc3k/mQ747dZxnuGvALtgG6nhvER7I7?=
 =?us-ascii?Q?8gUwDAA5ERcMYVG3DUDCJJZWZ3YrJl/e9/KAAeGTJIf2y/O09LwxZfO7Jogd?=
 =?us-ascii?Q?hYg6AoEqW4kHkq/6S9SwSTz82R/AOCUp7vM5sZptjkqe+pvH3Y4J44fj16rx?=
 =?us-ascii?Q?13L1y/+3+sxT/jV7sjM4y3eDUSotvJvGmsBwfadtkHnLCyHzYiz9P+krTjCc?=
 =?us-ascii?Q?LvPpPqkdCiUuXEFgbqEYdm+poCEYkEaGo7wYkqv229E9IFkgCJPE13QY011P?=
 =?us-ascii?Q?YJFe4M9mWTwuDrJTkTuuDBJe+O3wXc5+5HR+1UR/EYXdv7Wghul0U0x2TW4g?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c9b14a-b078-4726-b768-08dd4c9d343b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 02:13:42.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BXgMw1ZZ/IgNCOHQ8Cits7B+L6eLZPr/wROpyaXX3dcwTqOelSb87U+/B58dBnHjZMadOQZUOP7zxexEq/abA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8743
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c" on:

commit: 8f510de3f26b2fabaf47eacd59053469e9c32754 ("[PATCH v2 1/2] bpf-next: Introduced to support the ULP to get or set sockets")
url: https://github.com/intel-lab-lkp/linux/commits/zhangmingyi/bpf-next-Introduced-to-support-the-ULP-to-get-or-set-sockets/20250210-215203
base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf-next.git master
patch link: https://lore.kernel.org/all/20250210134550.3189616-2-zhangmingyi5@huawei.com/
patch subject: [PATCH v2 1/2] bpf-next: Introduced to support the ULP to get or set sockets

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



config: i386-randconfig-054-20250212
compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------------------+------------+------------+
|                                                                             | 9b6cdaf2ac | 8f510de3f2 |
+-----------------------------------------------------------------------------+------------+------------+
| BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c | 0          | 6          |
+-----------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502140959.f66e2ba6-lkp@intel.com


[   71.099773][ T3759] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:562
[   71.101798][ T3759] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 3759, name: trinity-c4
[   71.103659][ T3759] preempt_count: 0, expected: 0
[   71.104658][ T3759] RCU nest depth: 1, expected: 0
[   71.105669][ T3759] 2 locks held by trinity-c4/3759:
[ 71.106777][ T3759] #0: ecffcd80 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock (include/net/sock.h:1625) 
[ 71.108460][ T3759] #1: c3500498 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire (include/linux/rcupdate.h:336) 
[   71.110397][ T3759] CPU: 1 UID: 65534 PID: 3759 Comm: trinity-c4 Tainted: G                T  6.14.0-rc1-00030-g8f510de3f26b #1 8ad64aae41fa4cb8babad52c8f50e0a7d5e34569
[   71.110406][ T3759] Tainted: [T]=RANDSTRUCT
[   71.110407][ T3759] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   71.110410][ T3759] Call Trace:
[ 71.110416][ T3759] dump_stack_lvl (lib/dump_stack.c:123) 
[ 71.110423][ T3759] dump_stack (lib/dump_stack.c:130) 
[ 71.110428][ T3759] __might_resched (kernel/sched/core.c:8767) 
[ 71.110440][ T3759] __might_sleep (kernel/sched/core.c:8696 (discriminator 17)) 
[ 71.110446][ T3759] __mutex_lock (include/linux/kernel.h:73 kernel/locking/mutex.c:562 kernel/locking/mutex.c:730) 
[ 71.110452][ T3759] ? rcu_read_unlock (include/linux/rcupdate.h:335) 
[ 71.110462][ T3759] ? mark_held_locks (kernel/locking/lockdep.c:4323) 
[ 71.110470][ T3759] ? lock_sock_nested (net/core/sock.c:3653) 
[ 71.110481][ T3759] mutex_lock_nested (kernel/locking/mutex.c:783) 
[ 71.110486][ T3759] ? tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993) 
[ 71.110494][ T3759] tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993) 
[ 71.110505][ T3759] tcp_set_ulp (net/ipv4/tcp_ulp.c:140 net/ipv4/tcp_ulp.c:166) 
[ 71.110513][ T3759] do_tcp_setsockopt (net/ipv4/tcp.c:3747) 
[ 71.110534][ T3759] tcp_setsockopt (net/ipv4/tcp.c:4032) 
[ 71.110542][ T3759] ? sock_common_recvmsg (net/core/sock.c:3833) 
[ 71.110548][ T3759] sock_common_setsockopt (net/core/sock.c:3838) 
[ 71.110561][ T3759] do_sock_setsockopt (net/socket.c:2298) 
[ 71.110577][ T3759] __sys_setsockopt (net/socket.c:2323) 
[ 71.110592][ T3759] __ia32_sys_setsockopt (net/socket.c:2326) 
[ 71.110599][ T3759] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-054-20250212/./arch/x86/include/generated/asm/syscalls_32.h:367) 
[ 71.110607][ T3759] do_int80_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:339) 
[ 71.110616][ T3759] entry_INT80_32 (arch/x86/entry/entry_32.S:942) 
[   71.110621][ T3759] EIP: 0xb4014092
[ 71.110626][ T3759] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   71.110630][ T3759] EAX: ffffffda EBX: 00000134 ECX: 00000006 EDX: 0000001f
[   71.110634][ T3759] ESI: 08fee650 EDI: 00000004 EBP: 000012cf ESP: bfc1c538
[   71.110638][ T3759] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   71.182507][ T3759]
[   71.182999][ T3759] =============================
[   71.183907][ T3759] [ BUG: Invalid wait context ]
[   71.184819][ T3759] 6.14.0-rc1-00030-g8f510de3f26b #1 Tainted: G        W       T
[   71.186327][ T3759] -----------------------------
[   71.187265][ T3759] trinity-c4/3759 is trying to lock:
[ 71.188287][ T3759] c37b35e0 (tcpv4_prot_mutex){....}-{4:4}, at: tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993) 
[   71.189847][ T3759] other info that might help us debug this:
[   71.191018][ T3759] context-{5:5}
[   71.191678][ T3759] 2 locks held by trinity-c4/3759:
[ 71.192635][ T3759] #0: ecffcd80 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock (include/net/sock.h:1625) 
[ 71.194220][ T3759] #1: c3500498 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire (include/linux/rcupdate.h:336) 
[   71.196078][ T3759] stack backtrace:
[   71.196797][ T3759] CPU: 0 UID: 65534 PID: 3759 Comm: trinity-c4 Tainted: G        W       T  6.14.0-rc1-00030-g8f510de3f26b #1 8ad64aae41fa4cb8babad52c8f50e0a7d5e34569
[   71.196807][ T3759] Tainted: [W]=WARN, [T]=RANDSTRUCT
[   71.196809][ T3759] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   71.196812][ T3759] Call Trace:
[ 71.196818][ T3759] dump_stack_lvl (lib/dump_stack.c:123) 
[ 71.196825][ T3759] dump_stack (lib/dump_stack.c:130) 
[ 71.196830][ T3759] __lock_acquire (kernel/locking/lockdep.c:4830 kernel/locking/lockdep.c:4900 kernel/locking/lockdep.c:5178) 
[ 71.196840][ T3759] lock_acquire (kernel/locking/lockdep.c:469 kernel/locking/lockdep.c:5853) 
[ 71.196846][ T3759] ? tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993) 
[ 71.196856][ T3759] ? __schedule (kernel/sched/core.c:5380) 
[ 71.196866][ T3759] __mutex_lock (kernel/locking/mutex.c:587 kernel/locking/mutex.c:730) 
[ 71.196872][ T3759] ? tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993) 
[ 71.196878][ T3759] ? rcu_read_unlock (include/linux/rcupdate.h:335) 
[ 71.196885][ T3759] ? mark_held_locks (kernel/locking/lockdep.c:4323) 
[ 71.196889][ T3759] ? lock_sock_nested (net/core/sock.c:3653) 
[ 71.196898][ T3759] mutex_lock_nested (kernel/locking/mutex.c:783) 
[ 71.196904][ T3759] ? tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993) 
[ 71.196909][ T3759] tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993) 
[ 71.196916][ T3759] tcp_set_ulp (net/ipv4/tcp_ulp.c:140 net/ipv4/tcp_ulp.c:166) 
[ 71.196923][ T3759] do_tcp_setsockopt (net/ipv4/tcp.c:3747) 
[ 71.196934][ T3759] tcp_setsockopt (net/ipv4/tcp.c:4032) 
[ 71.196939][ T3759] ? sock_common_recvmsg (net/core/sock.c:3833) 
[ 71.196946][ T3759] sock_common_setsockopt (net/core/sock.c:3838) 
[ 71.196952][ T3759] do_sock_setsockopt (net/socket.c:2298) 
[ 71.196961][ T3759] __sys_setsockopt (net/socket.c:2323) 
[ 71.196967][ T3759] __ia32_sys_setsockopt (net/socket.c:2326) 
[ 71.196972][ T3759] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-054-20250212/./arch/x86/include/generated/asm/syscalls_32.h:367) 
[ 71.196979][ T3759] do_int80_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:339) 
[ 71.196985][ T3759] entry_INT80_32 (arch/x86/entry/entry_32.S:942) 
[   71.196990][ T3759] EIP: 0xb4014092
[ 71.196995][ T3759] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   71.196999][ T3759] EAX: ffffffda EBX: 00000134 ECX: 00000006 EDX: 0000001f
[   71.197004][ T3759] ESI: 08fee650 EDI: 00000004 EBP: 000012cf ESP: bfc1c538
[   71.197008][ T3759] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250214/202502140959.f66e2ba6-lkp@intel.com


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


