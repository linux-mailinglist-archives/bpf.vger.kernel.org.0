Return-Path: <bpf+bounces-73157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F3CC25167
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 13:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E24464F6566
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 12:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16056348472;
	Fri, 31 Oct 2025 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3e88lM+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08561A23B6;
	Fri, 31 Oct 2025 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914822; cv=fail; b=HxhQOybhBL+SbmVEGrqOQ94/cAtmrwqpbA5FZ/tNe4DVmQt1vpms2LaU+tT1zHA/8QUmMM0sjWaf774LjF1XeWfa7UHrzswg+SINtClou1XrM6va05ctqwvPODJjOmExB42K0/PQBopWeWxSsxWZLCkIKdF0vnrfN7Dgo9ETs6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914822; c=relaxed/simple;
	bh=xZBCA31qHw7hdy/B7ES+kdCGCPrIdXVJk+8xcKQjjjs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pT+G1aTakxutoXjnhwDNTOM+hcTi/s4myTsZ/FX5oNmsAIdxzT+M9OTSPNtRKkxhX/gAkLHVuFP0E66uzpYVu2yRUS2AuJ4wIOraNTcJc10nRvEWMb4YcQAjAJB0EYRA5bIZC0uW22Gg7d1oQ77/n5d9g86yD/gGZVvsERcazGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3e88lM+; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761914821; x=1793450821;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xZBCA31qHw7hdy/B7ES+kdCGCPrIdXVJk+8xcKQjjjs=;
  b=c3e88lM+eW1oMpNCh+6lqrXqI3Nm3AO+7oAzCOir5HZ5LUd05JXiioqP
   RYhbm2nPHDPPHA4tVqP315AGbsWtEEXdgQ4+7lRrcqHDrF2BxVTcHa5lT
   ZvaOl0LeLfFusi06bLOF4MKNjOa3dM+KwZSiVXsuuRA2Cwyeb0rQmvd+y
   sMI2mF7lmjBYv7tARcR4rRqveAFL0QbWTAjKQn3FuymMm8UC+hXoYvk/C
   CC/qIY1YIDIwteQl/IjjRMDoaoEknuDGKOzIKNSis/IUvWafuVpziR/Uc
   BIwGwWjindsbOhoKCetzDNpl4d/7Xwx6Q8L/PJ2sDB8Y7+MQuYNgbSg0h
   Q==;
X-CSE-ConnectionGUID: e6cZDPHlTnejKMlYPuiBzA==
X-CSE-MsgGUID: o/Drms1zTUqFGK49DGVA5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63979257"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63979257"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:46:59 -0700
X-CSE-ConnectionGUID: HAUDA7+qTt6Ynes87Kh5dg==
X-CSE-MsgGUID: iDEfLGY9QJijcg+IjdEtYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185443151"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:47:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 05:46:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 05:46:58 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 05:46:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srNgA5nlxax7VPqUDiSEKt8PmHo54MUapUDD4qbEQcy/v5NVD4tUxcVgjb/CkcXS0R25tpwq4JK+ffC0Nhjq13eHacbN2d4X096fOrIwmGzIStaZJiNArDdxbtdRlpH8GhvQEDUJ8gRGA24fIMf0oqYc6yRim3RoxzoT7ZHJwpO9RK6qkO0mj5le82/7OOhBtHjeMD5TzgHdNta193fYfTfzd/XRGXKCyos8ns5Spo67RKHaayPX4mrmeSTMhloRhn5CllFmBn7Z5SnIz43XeX+Mst6HkZTZ4B9E5WPa2VJnnoYhUM+bOKcev5cqPcmytRjhfRUyOyrCtWKxx2kl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzPk1Q7Rp15MDK+UuJWmGGWzJ8xyyAguvo29m+Hu0S4=;
 b=luXvzXzVGn+JR9uIhQDqgocM3A+6IzL4HtLThlZzFeyCnjKYzfMHukFiwlSI7MDgppuuvhBmIV7Za+Zlz84N/3v8UQBwSmoc4h0PsGQ5cvGV4sO62DVYV+4P+LRorFeHAX191+QvWw3JkiAhao8qtlZP+vpJnAGmBe6F3zzJi9XwFpmlfeAlSK2ktBZjeW5R2j5yav03BQnDa7yaYSNOoi/nB5HslmN600GF1BJul1ZM4c6BHk/yS1H598BnP50eYvdu28k7PX9CmtGeFZIGLsZta4R57qKcvLGQt94TOojPtZA8o9bND+u6oubMtQLXtLd/Tirfh4xTlSyr3eHN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS7PR11MB7858.namprd11.prod.outlook.com (2603:10b6:8:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 12:46:56 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 12:46:56 +0000
Date: Fri, 31 Oct 2025 13:46:48 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <bot+bpf-ci@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<aleksander.lobakin@intel.com>, <ilias.apalodimas@linaro.org>,
	<toke@redhat.com>, <lorenzo@kernel.org>, <kuba@kernel.org>,
	<andrii@kernel.org>, <martin.lau@kernel.org>, <eddyz87@gmail.com>,
	<yonghong.song@linux.dev>, <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH v5 bpf 2/2] veth: update mem type in xdp_buff
Message-ID: <aQSvuMWDMyMYRI+W@boxer>
References: <20251029221315.2694841-3-maciej.fijalkowski@intel.com>
 <e9f13992d679d08d193cb40c15c70fbf4adfe9d94a6235b20858fbe161be58a1@mail.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e9f13992d679d08d193cb40c15c70fbf4adfe9d94a6235b20858fbe161be58a1@mail.kernel.org>
X-ClientProxiedBy: BE1P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DS7PR11MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: 7226236a-e599-42fa-8456-08de187b92d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bujz2AshGERnmRzz90s5tIWQvHi7SotU4lLVwOgzBWdN9zk8cyeLPr+kbnQH?=
 =?us-ascii?Q?5CQcbaNC3Q2qwGs4LIdDnkK9vxQD2jTb7AIT+g36ZqTUsBvs7YH9mPpte4AA?=
 =?us-ascii?Q?RT7LkYFKfNjABjP8ymaqiR+YkaNoeK+Oy3O0J2aFlmwoRXVdMZkJ2tclVHWY?=
 =?us-ascii?Q?nlAmgPO+7d3hpscEDCJ6Pl9GGE79entqHdW8zi616KxHLYu83MJILqiGqnnf?=
 =?us-ascii?Q?6WPjZ1H2iB0erlmj8pn36icO2piD46vUGnwb6xvNW6XE0mBaBhLS3DgBgPKG?=
 =?us-ascii?Q?lfFjqgXPn8aYrsGKMcD+qUphAk/7qGonTRmAhhx4uu4rZmBSeJFRLKhgBzlT?=
 =?us-ascii?Q?M5v7rAtvrHoXFq+4KPnbkDfHD3tJ1ramMSXjiX9/OZVJvYNxP1o6mcRP0bms?=
 =?us-ascii?Q?W+pZVy4RFFozZGLUCLo5Pd0RY3IcZdbbw93PAXXTyOwevqFrs5/Lv3QbN4sq?=
 =?us-ascii?Q?gAu33eaQb5l7rRY1ik4QcwzIjQh3oYCEah8ZUWtfpVSrvXPR18fpQoTN3h+V?=
 =?us-ascii?Q?+ap44mdGuocUV4Wv5ZHdk/qlIOSf0/iBfOqKI2gs6Ys0XQLdV7nZpkuntRvJ?=
 =?us-ascii?Q?d+ir7adYpGH8n7Av+RGE5F5KVAGCGLp7xg87wOFLpCxpYOphs9YqK16JxuX5?=
 =?us-ascii?Q?d2PAuJQx/laDXyyURprlJWkOvhjeV4cE2voMugahQxAhB9ji8ZPG71vkPcsT?=
 =?us-ascii?Q?TqKZjp5WnyqpkPMzgOA4NUgnMuz8+eZ+x8VQQ7Hw4/22KIu7V3QVDBc/yTGY?=
 =?us-ascii?Q?oUM+9JfCEQXxvY+YL3BifBUblLujfD0FiS2AJxEeq06eiCWn50JQjrGoFdyo?=
 =?us-ascii?Q?zyc6YDJ5I56pD8tZ8VHubf/2xY2QyZ9dpZuykED1n5uMwJyk/So+tdVruJvZ?=
 =?us-ascii?Q?426dbBgpGWbShU7YKW179SEuangD6MCVZtbISYFIeTUlUFZfgcRmqW7QH2UG?=
 =?us-ascii?Q?V51gQyUDVhBzYboUg0n2a5oh52V4DUqqvTusmzCE9EqaNj0EWUrNyTpcY+aR?=
 =?us-ascii?Q?Do7Q4AgjCJHBSLg/XPOtPC/l6UZkIQ6xOcMgLKyxfZg/rxiBVJ8+r8cWQfY/?=
 =?us-ascii?Q?nO6eIEsh78qZFuM62RcrQO7EmvHRwPBIZfSduCymgPzsJ5mwbiiTfgc59FB7?=
 =?us-ascii?Q?S3Jj8jMfvYS3Zl8tYPrYRePvM6zIVtzqT9KV6Mk/RvEEDyNN07jA4FstLZin?=
 =?us-ascii?Q?5aFJaOROzqIXF0dNcl8R1ltTwpxzupz4LsYGd3swHX62MoCZa8u1Z3XEUO75?=
 =?us-ascii?Q?JYRjrlo3K0XTNg0q7YJDpfYxwGgHTZFRC7akeBLp6IJNjgheiNuQmb7rjt+P?=
 =?us-ascii?Q?BKV7uVDzjZlJT+I8yZPu1c+SBofrbGYOBnEAarUakwJlZiRDZWjrsPq/yRLL?=
 =?us-ascii?Q?EMB1evFiAg1Kjo6ZElP+N80VGFLZBWbNUw6sNdaur6GFqptgwA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/799X8eiISoE5xLnVifu7au2Dzd1MdfVXe3cZMjnMrfhbeYoal+X6XckkFIM?=
 =?us-ascii?Q?8j4bOmx/HxRu8a+JcHKJAImu0Mk1T1+MRdcD22KQzn7SGFbgKG7+YI6Yn3ab?=
 =?us-ascii?Q?piynKSFp6vljPLl5ODCbNcN0oiVBGQmUYKAYFqz+oEO0GAUX2TqikkP6DLvL?=
 =?us-ascii?Q?hB8IdKm9D50wDjRVKkYdFym8XlVCS50PiHibMbug+jsqcU2Zw177c8vkWhQy?=
 =?us-ascii?Q?Zo5bj9laUnk+8CEKuKSOmicWveEEFy0hQmIb6sGnUKFTj2qW4q27nXASTtdA?=
 =?us-ascii?Q?GQjy+pzeqaCr+0YFgSy2psGdJYEmVEHTADW6PUD/EvYjTZst2UfkmlLD0UkQ?=
 =?us-ascii?Q?2tgIbA1TQW1LiDIc52QE6kJzel9RLUPedGQ5LCNYSb+d4yPramK6xyLOjlO1?=
 =?us-ascii?Q?L5NFjlfJATUNtdR3LGL1JNc3W3fTnCcUBpUvD451hKBnZIds9u8H9lTzFFvz?=
 =?us-ascii?Q?nrDkiTFy4M4AVBKfEROZ0lvN98Z1ArQ4GokJc9NUcvJD3sd/JI+GhVFkvyjH?=
 =?us-ascii?Q?NGKtlheAeMhcgx9ugtp/EguacrxfYR3u5zg8zY3zcxWXWgNU2hLjV+meFgiq?=
 =?us-ascii?Q?Jzz7Y8AZEJDKchl9TkLubFWHAMZrLBHPLtr0bZ6MjQJaKqlInRl1NJUw0nLZ?=
 =?us-ascii?Q?KTI/bvV7yAfbB5QJ2q+6J26WKJ9+sJF/QR2wUmMKx0M3jJQL8VKUMW5G5P+b?=
 =?us-ascii?Q?nziUJJXlL4dERpR+bx+PFZ7jfaV9amfcjOUdIrv3VNSO1y3rMOGPSco8YFyt?=
 =?us-ascii?Q?EJRrCXul6GaHgAxmM8+hqlg1DNoAf9K9oN7CAwHHbIZScqr8gWvK1A3zld12?=
 =?us-ascii?Q?edx2blPOYdut+kgHvlVxkjppfZfAS6S56k+q9iAYpwUVWCcyt209j9uKfhoa?=
 =?us-ascii?Q?2qyLLnr0tTMRntgUrsKtT7kN6uJcrivOStNykWS2MvRqfE+s/J8hWeKNoCU5?=
 =?us-ascii?Q?hXacfJG1j7pWG2XfuXIgA6P6/x509YWDbc7VeIOqxP57xOr1h42wIFchQy4h?=
 =?us-ascii?Q?UymLNApK+lAAk1wnqWgZAyuahEK89TBJRAFAyfEAkjoo8gJ6dU7iZ53J4kkn?=
 =?us-ascii?Q?48/T/pF2qiz1asoP6eKMQhCInpTVa6kcaErC2OFyigQ4ADJIrye/PcYr6I3u?=
 =?us-ascii?Q?RR3ogN/LHb1XiCEZmdji4cHwbHl5Mb1cfqDsyswaNBWz3ZhTxNg5WwW/sA7I?=
 =?us-ascii?Q?g44u+E5j4sjbmkIPomoFYDDc3L9XX5BpF3BtI+eM0+upx69YCumZdDbCQrAo?=
 =?us-ascii?Q?H9Xej270Lz1vGeqSPvzur4VejlJAcsr8B1Btwf3JTV8QgPG17SOlYAqJ2J1A?=
 =?us-ascii?Q?Mr1s1dICBdUK83o1g3xYdrSpUUBabMnhQh1A0YXvtJyvyayRHS4y3hZyHqmF?=
 =?us-ascii?Q?r6yVP2Vt7FIqUXwKgN4buFevTBE5iCr+APmy0ZkXoRaSt6919P9w0/YaQNN+?=
 =?us-ascii?Q?5qEcx7ItmKvbAZf3blZzZCAFzXvnZISRdxwWJZQRykulnCawOFuiPs/x7Xdo?=
 =?us-ascii?Q?Wn81TBKmOcN31xPLMW1eGScWnuAB1lXPLDMBCJG48YA3xkv4uAZT1U3Qmrs2?=
 =?us-ascii?Q?XJXoQxi8GXcQwtAGmmGbaSb869TCOi7RhYVeaTQeN3yDf0NhVmWETrmf+AoB?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7226236a-e599-42fa-8456-08de187b92d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 12:46:56.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zERsPumi5dbV/uTZel+Oq8kCjBD0B9ryrWPvWYlqjCyEK9BxNRONj5TMvDlj3RRkksMddnEt/Bl2jNzKEU/UJvaF/nQxI/1jnJJGY6NnJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7858
X-OriginatorOrg: intel.com

On Wed, Oct 29, 2025 at 10:59:36PM +0000, bot+bpf-ci@kernel.org wrote:
> 
> ```
> commit 96d6e22337a81e8606de33d22173ff80ab961bc8
> Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> veth: update mem type in xdp_buff
> 
> The commit fixes a page_pool leak by properly detecting page_pool memory
> and using appropriate reference counting APIs. The xdp_buff mem type is
> now dynamically set based on skb->pp_recycle instead of always using
> MEM_TYPE_PAGE_SHARED.
> 
> Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com/
> 
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index a3046142c..187f30e2c 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> 
> [ ... ]
> 
> > @@ -733,7 +733,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
> >  	}
> >  }
> >
> > -static void veth_xdp_get(struct xdp_buff *xdp)
> > +static void veth_xdp_get_shared(struct xdp_buff *xdp)
> >  {
> >  	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> >  	int i;
> > @@ -746,12 +746,33 @@ static void veth_xdp_get(struct xdp_buff *xdp)
> >  		__skb_frag_ref(&sinfo->frags[i]);
> >  }
> >
> > +static void veth_xdp_get_pp(struct xdp_buff *xdp)
> > +{
> > +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> > +	int i;
> > +
> > +	page_pool_ref_page(virt_to_page(xdp->data));
> > +	if (likely(!xdp_buff_has_frags(xdp)))
> > +		return;
> > +
> > +	for (i = 0; i < sinfo->nr_frags; i++) {
> > +		skb_frag_t *frag = &sinfo->frags[i];
> > +
> > +		page_pool_ref_page(netmem_to_page(frag->netmem));
> > +	}
> > +}
> > +
> > +static void veth_xdp_get(struct xdp_buff *xdp)
> > +{
> > +	xdp->rxq->mem.type == MEM_TYPE_PAGE_POOL ?
> > +		veth_xdp_get_pp(xdp) : veth_xdp_get_shared(xdp);
> > +}
> > +
> 
> [ ... ]
> 
> > @@ -822,24 +831,24 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
> >  	case XDP_TX:
> >  		veth_xdp_get(xdp);
> >  		consume_skb(skb);
> > -		xdp->rxq->mem = rq->xdp_mem;
> >  		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
> >  			trace_xdp_exception(rq->dev, xdp_prog, act);
> >  			stats->rx_drops++;
> >  			goto err_xdp;
> >  		}
> 
> Can veth_xdp_rcv_skb() leak page references in the XDP_TX error path?
> When veth_xdp_tx() fails, the code jumps to err_xdp without releasing
> the page references acquired by veth_xdp_get(). The skb was already
> consumed, so the pages still have the extra references from either
> veth_xdp_get_pp() or veth_xdp_get_shared().

You're missing xdp_return_buff() on err_xdp path.

> 
> veth_xdp_tx() can return -EOVERFLOW when xdp_convert_buff_to_frame()
> returns NULL, which is a reachable error path.
> 
> >  		stats->xdp_tx++;
> > +		rq->xdp_rxq.mem = rq->xdp_mem;
> >  		rcu_read_unlock();
> >  		goto xdp_xmit;
> >  	case XDP_REDIRECT:
> >  		veth_xdp_get(xdp);
> >  		consume_skb(skb);
> > -		xdp->rxq->mem = rq->xdp_mem;
> >  		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
> >  			stats->rx_drops++;
> >  			goto err_xdp;
> >  		}
> 
> Similar question for the XDP_REDIRECT case - when xdp_do_redirect()
> fails, does this also leak the page references taken by veth_xdp_get()?
> 
> >  		stats->xdp_redirect++;
> > +		rq->xdp_rxq.mem = rq->xdp_mem;
> >  		rcu_read_unlock();
> >  		goto xdp_xmit;
> >  	default:
> 
> 
> ```
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> In-Reply-To-Subject: `veth: update mem type in xdp_buff`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18923812102


