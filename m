Return-Path: <bpf+bounces-53165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C62A4D3D3
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 07:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6BB3AE672
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 06:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769D51F543F;
	Tue,  4 Mar 2025 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmBl/Jah"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65681F5435;
	Tue,  4 Mar 2025 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069605; cv=fail; b=LYqsKOxjpzr8Tly6gHRZ1PFzaY9Pd+SSkrJLsCyZnzUPynck7rQBFiZJzREdAOCD80V3bSQGeavO+ESAIqjHv3gsfTuCL8vlTbQhUfS80iN76y5piPyo6gD59hcS0sPN8PAgyB5v9bQuDNV7OE1ibhCsrX5VXpEBTUGQrJDnyxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069605; c=relaxed/simple;
	bh=9P75E6B8W/OpcvWoyuDX8m0TIGRzUPKTC93aIXUOzJw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r1DdAuflMnZUj5Fq6r78ekpwnGKnq0weglz7p5C9IUciPbTWhN11dMtCatkgtBPmH/3B7xS5v8HorPbB80MXzyk2M5IXed3/xSPeJlnKnKF0IAoP3rX5/E1RncytoQICpxxc0rj/uQWTbR4it244kyCWDsJg8KUFbfG5dKLlH5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmBl/Jah; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741069603; x=1772605603;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=9P75E6B8W/OpcvWoyuDX8m0TIGRzUPKTC93aIXUOzJw=;
  b=TmBl/JaheXEB56zg7j+JMlx6DBQ2zwOYa3jpg9rFPiD9vE+5tZcPj/qh
   TOOOklcZxNPHNTTJ2NRl1PgbfZgyPRo5QeHvrqxZi7NaBmtxNPzqjVy8G
   gSqmJJt7W9s2AwhLnjeA1iNoaHKF/xKTGuUSHl9bsCvCck3KqGizcyUWQ
   dhyim8zlteuix6HGMceHWLzcLZFohTb2+LoSUv3QHliCAFCQlprY8nFAL
   HAF3xvdRNrFtWPpWosgRfCyIJgkbXfbyjpR+Pa34qooD6ueJJqTwYNd1P
   RoDpoT/wgu/Vy2jQeTha9DSps0bOQhu0S5yi6r7wkuciBQ2IvkCTjEHEu
   g==;
X-CSE-ConnectionGUID: RjhCDsaWQM6A7vogBJ2UxA==
X-CSE-MsgGUID: ExZrmEI7TQmm4/3Lzsi4Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="67342017"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="67342017"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 22:26:42 -0800
X-CSE-ConnectionGUID: Cx6K+9ZEQXy5SPjeg0M/hA==
X-CSE-MsgGUID: 2Q7L1ZZ7R3Gr/K/oDD9mqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149197061"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 22:26:41 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 22:26:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 22:26:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 22:26:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBa/pfNtUfQfD4/bi3fuV3WdJbtCLUUFOib6il9tHP+clpjMo4elRztQNeHYqFCeywTTIPhFzZo4vgL4bnrGo0UQC+dC4157LpifaGr9fDL/758ThhEBu0uHIHujwbJrvkX3rnQj8Hw+Z81e11i70YDnjcUUu8iLLxdYWv9/vICVBAeqB5GrKjvSnIV0MO9NQi3hKx+8kPM8BFHwXhSK/VyhMhhIIml2QZvUGn+Odai5x5pgwKz0DvdTLspO8t38bmkqPobscbkfkQgaq12pctvQpEeLy4fMH7Y+mGMcj3Ofh4E6TSfCvc12ffFrtSCTbFi2U9pr+EUHH9Jrs7vxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U95v7pyflIHoHTP+a6328IW8x6tXqCOKdSoA/W7QIl0=;
 b=PJ6B04ThiSv2mRK8K8vaEWsg79c9LfqtyWN0S7Aok5EEdlrSONJ6d9Wfi+0VFpPEa3tnqFEH+PYMsAlAGhviFWi9X0q9O4jWWyiFtFZRZX+iWTUGYvidT9KptRSc7eohOp/YAorEnveWt0MmxnyyYGlAb69rTrLZHqi2dXw3Ly3ANhVJN3Ce9c33NUclpPYVeQtLQeXKIiLLLsnSVBssXeeguI4mmMq8+zI6MON6tfjLRuuOq16qw2eA6aMMOC1MR760I/0Kq+ILuvkN47iIT8fPJ9hrB1yPM+NBmuxvjHQDBLBFtlkTcs4ZGRXN5YE3IztB8IX/yPLIwMuF6uLPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7963.namprd11.prod.outlook.com (2603:10b6:510:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 06:26:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 06:26:10 +0000
Date: Tue, 4 Mar 2025 14:25:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Menglong Dong
	<dongml2@chinatelecom.cn>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<rostedt@goodmis.org>, <mark.rutland@arm.com>,
	<alexei.starovoitov@gmail.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mhiramat@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <mathieu.desnoyers@efficios.com>, <nathan@kernel.org>,
	<ndesaulniers@google.com>, <morbo@google.com>, <justinstitt@google.com>,
	<akpm@linux-foundation.org>, <rppt@kernel.org>, <graf@amazon.com>,
	<dan.j.williams@intel.com>, <bpf@vger.kernel.org>, <llvm@lists.linux.dev>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH bpf-next v2] add function metadata support
Message-ID: <202503041412.5cf70b18-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226121537.752241-1-dongml2@chinatelecom.cn>
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ce6dac-f5bf-4f73-abb9-08dd5ae5747b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TtmoX5l8LH5+NqP8Sr4k/jPl5F3xh0vDWCQ9X4KwkNYJjbcNnI2Kh7BIbLQN?=
 =?us-ascii?Q?viPBHeCe7ydOKjLTNT+zUDZI+N70g0zty2/7z/uh5gKuOJxHiCX46INY9Zfv?=
 =?us-ascii?Q?S3ZGRMm5hUB5zOi8JTKkRpB43SsmXKITXkbih1HX+MyGraNPiFezwX3OG3vp?=
 =?us-ascii?Q?oqREKmj1CBabyJ/bQXMtfSRDr+TIz6+hBUAC21oVL2wIEwH9+HPIaP2HtZva?=
 =?us-ascii?Q?bwTqoIHrqbF26eTt6zVKjZBpmYZZWzv37rktHwFDO6fdtUdyXLc8/4kCzOD1?=
 =?us-ascii?Q?/9qnLjwBNoAVgQ9akvPaXj9mn9iL6RW/BwxUSuhgODRtQCqlZFHXIkXKGvnN?=
 =?us-ascii?Q?Y4B3OtpM/pKIPq80LAs3AbOxZt4J1lBWVGSHviBW1DaCTyUWWwOJ5WXPstEQ?=
 =?us-ascii?Q?Z40SkL/trp1Q3CgcpzeLDKdF8j2lZ511psMIUOJcLJsPopIDRPO67OsaK+7d?=
 =?us-ascii?Q?epqASP8yPShwYopMPFNJBL0LGaLstNLy7qd1AeMd2YA2y5GlIBPldfk3+jK+?=
 =?us-ascii?Q?Cg/n7LhRcSDBUQT0boYQAxA8Wked8CgnlF9/Tb+5mGALMKLXaXgDw7B7CCHr?=
 =?us-ascii?Q?bXZvSMAXwBMMNiZkNz5N5hiRY/o5C40qzAn9YYMD+fIxxnkC/BkBAtJtv0tU?=
 =?us-ascii?Q?OkKE75wG+zDyfSxgfP4TozznOjPCWxDuIs9tMhrF+YO2/ifi8yECncq2f1ph?=
 =?us-ascii?Q?lZow3mYIvEcETctleAR6eeCJdu01jFnM/NHtDXYHLWjrKoz0Rck16AEqQsSw?=
 =?us-ascii?Q?7p2mylRmVPYIKZf6IVhFOYYpupm0tjQsuNxlp4RKlIcIxADN2Y9tKKJrmMbl?=
 =?us-ascii?Q?FPY+yhQXa4xpIdvjRk3MgLtIpBbVsOn1H6LQXA+pNT4I2PmdN2K3uDc7O+dX?=
 =?us-ascii?Q?k9Q8QfXy++H4K1OSJRJdjmnlOteh/RnZ1QsT/g8qAZu9LrU35XATOYIvy7UJ?=
 =?us-ascii?Q?Y7PpOzwjoDOE/tXIYlZ/7M+VFTyFVqlvdaJRYZzQYo3u0IlN3WUiNg/+mzZA?=
 =?us-ascii?Q?YsaMnkYyCKrEhgGE1Km3xPtZUqDJPwtFGi0Fy73s1OmgvwkV5AspPMLhH/Mw?=
 =?us-ascii?Q?F486lav1s9cXPqj35roQSt2zj/hBIu7LCxhMILU696HkmLeDSDdjmR3IutYc?=
 =?us-ascii?Q?uuvsvAakf8n7u48iVlzOsJviJhuIooN3BNUq88qCvIi59lgMa5RkMZKWACVx?=
 =?us-ascii?Q?piMz2ElH+wkk2gXbBWXKOygywgy5AF5BDtsKWO1AAOCHIBTzrWQkOlzg4ilI?=
 =?us-ascii?Q?TLSiqEyARrd3XUiMkhI1zaIApVO+aSgOyzrHw8+IiGwowUachgSM/O7MbjDH?=
 =?us-ascii?Q?rxmv5/35WwWA7fl8dWBMDBbTePOy+DZJnTx7Kwvt9G0OHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IblEK3u/guGcfrThj7CcsMMLnaYDEe7ZwRrYnp+NYrqzBVU4fRsjLzRrE2Cx?=
 =?us-ascii?Q?gHImA+TbDY8PwONlA4KLmHm9ELQkluO1qHpm2f+rqhyvmk1jPzlszS3sSiRr?=
 =?us-ascii?Q?RwreePiVbUi9Zga9URC4Jx5zDHjgCqJ2AzgoDPeInXgaBnd4v9ql7bbSNLR7?=
 =?us-ascii?Q?wCVsKDrkmh+w5rS33jKpJnzOy07hPLXccymQcoZR7tJbpxUjcXng6Bc5KGTm?=
 =?us-ascii?Q?ujPjNFg4KYRU8uQmkvOsnBy6cTzTLD8nbV3sQUQy+ddejowiBYHynBPI2jDq?=
 =?us-ascii?Q?C9SQDg5a/k77jzYh4zsLraERaJ5kLz4miJ7nc66SZl3L/ub+d2HB4gP5Wf4Y?=
 =?us-ascii?Q?ZtFMIMC5vgUbIQephJbOSSncuVsYcp39X3hVkoh3QNdBoCd9VmkKB3YOAd3o?=
 =?us-ascii?Q?b+z/KLUPkDiNuxdxhCskVrgzLmw+SckmJuGxn4v/T19dmV3gXr3G3y7FkhPU?=
 =?us-ascii?Q?WIzCZKebUMA4NWC4GaUmxTuqzT7TvrTR34nU/TPktgUUm2UaRjXgKXwKlHbO?=
 =?us-ascii?Q?kWDBviK1oU6gvb5Kpr81L9tPJybCxeBlXcf4qey4kLuRrzOhZ2VhW6qyz5KP?=
 =?us-ascii?Q?BdPK0RPXve9isKCJP0kpCMRBkYTN8UbP2psYWT6rJER8KH7eP7Qi2TS1TBvv?=
 =?us-ascii?Q?vxXhpsBb0ohWZFwhHv+WBDPUPNtvRWAwigHdyuGvHirEeDSjxzZf+tvJe8Yd?=
 =?us-ascii?Q?/mMDNcXbvV8cPTTavdUVqLa2fYU8N3vUuP1C9+MEqnMsrWMfiCeHR4Y0Dgiw?=
 =?us-ascii?Q?0H6/KMIFHxp9/LIbS8bIQF8sKnjxBqwd5PhL9fK2/QA6l2H9gy+Klh7LCtf3?=
 =?us-ascii?Q?C59REURpiZ0wvOE8kvyMr4oP2Q/36VajqKRQSK728PpDxiezKyon3wQcUeHG?=
 =?us-ascii?Q?1U/LUDecURX+IuKqfpErNZHTsvOqRWbGv0JX2GPTMVUfP6bDxq5/dghNWUvH?=
 =?us-ascii?Q?eYL9/tWuhtGVSun8Ozq8xHTZtchEJ1cb2sa8pjlVdvGYzaRkc8iRNYa0NAr/?=
 =?us-ascii?Q?IcSxmjlQ0cw9vSXx6/R10vKV6CEJ/Go4nSfP/SyWziCLeV79umWIA0nqNHLT?=
 =?us-ascii?Q?FzV58nR3y/sLYc7vYzfjpEswvFT1xm7R+tVqeIvCCAYqHs6PwXGl/cpfP2zQ?=
 =?us-ascii?Q?/iO4Us4j9tMbciEHmLzluwnxj5JyMkEwdBaf+0Dpc0OTEPsE1rbTxjlx3bSG?=
 =?us-ascii?Q?ZSja81qw6IatFHICdR/c5mG4yC9JhWirGPFexv20hCLnD1CdIgYTrlYbtjVC?=
 =?us-ascii?Q?37m5GlX3+raI1Y8srxcHC6H2RtdgfCCJTFsKmnXtQDchS/035mZirHxaeuAf?=
 =?us-ascii?Q?jeIkvZVNDwMbwAvC0I0kzpUf+rbWnOtFuzp7AJevPImWW8BE04EnjuRBhnnW?=
 =?us-ascii?Q?NwOuaLMBqGpBkx/mbcVVnJNEcwzN4z+bM2XsEU/nnJmwyAusT9HA+52TMx1X?=
 =?us-ascii?Q?JJQcQLECYYLPdbe+IxykhoL9YOr3LzmKQcPJ8n/10aEb6fqVIk5WaqrzlFgF?=
 =?us-ascii?Q?5Gs2waSzfac8KBUTgcsGXvMho1P/PfsIHPzpm2Sf5nZb9+u947naOP+YPlL4?=
 =?us-ascii?Q?qHCptcNBqTZGtv7pWlM7po3QuGD1UBSaQ3XDdYmsRTrTYqmMdUvmWZ1eAp2M?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ce6dac-f5bf-4f73-abb9-08dd5ae5747b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 06:26:10.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+kDsasOhFKwaWjv9TZ86L0vXcvP88C3EatXiFUVvVuN9Yw7NSEng242xVLX0+jSyjFkHP1XXzIa4W2brTEsug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7963
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "CFI_failure_at__seccomp_filter" on:

commit: 449ee82c2013c0e0ccfe716bc3f8fff1a3651cb8 ("[PATCH bpf-next v2] add function metadata support")
url: https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/add-function-metadata-support/20250226-202312
base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf-next.git master
patch link: https://lore.kernel.org/all/20250226121537.752241-1-dongml2@chinatelecom.cn/
patch subject: [PATCH bpf-next v2] add function metadata support

in testcase: boot

config: x86_64-randconfig-077-20250228
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------+------------+------------+
|                                      | 4e4136c644 | 449ee82c20 |
+--------------------------------------+------------+------------+
| boot_successes                       | 12         | 0          |
| boot_failures                        | 0          | 12         |
| CFI_failure_at__seccomp_filter       | 0          | 12         |
| WARNING:CPU:#PID:#at__seccomp_filter | 0          | 12         |
| RIP:__seccomp_filter                 | 0          | 12         |
+--------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503041412.5cf70b18-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250304/202503041412.5cf70b18-lkp@intel.com


[   47.224161][   T71] CFI failure at __seccomp_filter+0x419/0x1505 (target: 0xffffffffa0000d78; expected type: 0xd9421881)
[   47.225919][   T71] WARNING: CPU: 0 PID: 71 at __seccomp_filter+0x419/0x1505
[   47.227037][   T71] Modules linked in: font drm_panel_orientation_quirks autofs4
[   47.228206][   T71] CPU: 0 UID: 0 PID: 71 Comm: systemd-journal Not tainted 6.14.0-rc3-00256-g449ee82c2013 #1
[   47.229699][   T71] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   47.231293][   T71] RIP: 0010:__seccomp_filter+0x419/0x1505
[   47.232177][   T71] Code: ff df 80 3c 08 00 74 08 48 89 df e8 06 a5 3d 00 49 83 c7 48 48 8b 7d b0 4c 89 fe 4c 8b 1b 41 ba 7f e7 bd 26 45 03 53 c1 74 02 <0f> 0b 41 ff d3 89 c3 89 d8 44 21 e8 44 89 e1 44 21 e9 39 c8 48 8b
[   47.234992][   T71] RSP: 0000:ffffc90000d4fd18 EFLAGS: 00010296
[   47.235895][   T71] RAX: 1ffff9200000ea06 RBX: ffffc90000075030 RCX: dffffc0000000000
[   47.237038][   T71] RDX: 0000000000000000 RSI: ffffc90000075048 RDI: ffffc90000d4fd18
[   47.238193][   T71] RBP: ffffc90000d4fe98 R08: 0000000000000000 R09: 0000000000000000
[   47.240441][   T71] R10: 00000000f38ab44b R11: ffffffffa0000d78 R12: 000000007fff0000
[   47.241594][   T71] R13: 00000000ffff0000 R14: ffff888195158e00 R15: ffffc90000075048
[   47.242791][   T71] FS:  0000000000000000(0000) GS:ffffffff84443000(0000) knlGS:0000000000000000
[   47.244083][   T71] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   47.245000][   T71] CR2: 00000000f7f6a01c CR3: 0000000195c01000 CR4: 00000000000406f0
[   47.246154][   T71] Call Trace:
[   47.246736][   T71]  <TASK>
[   47.247169][   T71]  ? show_regs+0x5c/0x80
[   47.247812][   T71]  ? __warn+0xf7/0x200
[   47.248427][   T71]  ? __seccomp_filter+0x419/0x1505
[   47.249202][   T71]  ? __seccomp_filter+0x419/0x1505
[   47.249964][   T71]  ? report_cfi_failure+0x7a/0xc0
[   47.250833][   T71]  ? handle_cfi_failure+0x1d5/0x27b
[   47.251619][   T71]  ? handle_bug+0x62/0xc5
[   47.252263][   T71]  ? exc_invalid_op+0x1f/0xbb
[   47.252966][   T71]  ? asm_exc_invalid_op+0x1f/0x40
[   47.253716][   T71]  ? __seccomp_filter+0x419/0x1505
[   47.254556][   T71]  ? __seccomp_filter+0x391/0x1505
[   47.255373][   T71]  ? putname+0xd5/0x140
[   47.256045][   T71]  ? __kasan_slab_free+0x46/0x80
[   47.256841][   T71]  ? kmem_cache_free+0x176/0x380
[   47.257629][   T71]  ? putname+0xd5/0x140
[   47.258338][   T71]  ? putname+0xd5/0x140
[   47.259100][   T71]  ? user_path_at+0x43/0x80
[   47.259875][   T71]  __secure_computing+0xdb/0x2fb
[   47.260669][   T71]  syscall_trace_enter+0xae/0x13b
[   47.261464][   T71]  do_int80_emulation+0x7d/0x140
[   47.262299][   T71]  asm_int80_emulation+0x1f/0x40
[   47.263153][   T71] RIP: 0023:0xf7f88cb0
[   47.263837][   T71] Code: 4c 24 34 89 44 24 0c 8b 44 24 44 8b 54 24 38 8b 74 24 3c 8b 7c 24 40 a9 ff 0f 00 00 75 1c c1 e8 0c 89 c5 b8 c0 00 00 00 cd 80 <3d> 00 f0 ff ff 77 21 83 c4 1c 5b 5e 5f 5d c3 90 83 c4 1c b8 ea ff
[   47.266925][   T71] RSP: 002b:00000000ffbbaac0 EFLAGS: 00000246 ORIG_RAX: 00000000000000c0
[   47.268242][   T71] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000002000
[   47.269513][   T71] RDX: 0000000000000003 RSI: 0000000000000022 RDI: 00000000ffffffff
[   47.270868][   T71] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   47.272143][   T71] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   47.273426][   T71] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   47.274794][   T71]  </TASK>
[   47.275309][   T71] irq event stamp: 6683
[   47.275991][   T71] hardirqs last  enabled at (6691): [<ffffffff814f0bb0>] __console_unlock+0x75/0xc5
[   47.277474][   T71] hardirqs last disabled at (6698): [<ffffffff814f0b95>] __console_unlock+0x5a/0xc5
[   47.279025][   T71] softirqs last  enabled at (5774): [<ffffffff81317b30>] fpu_flush_thread+0x1b0/0x340
[   47.280534][   T71] softirqs last disabled at (5772): [<ffffffff81317b30>] fpu_flush_thread+0x1b0/0x340
[   47.282053][   T71] ---[ end trace 0000000000000000 ]---
[   47.283041][   T71] CFI failure at __seccomp_filter+0x419/0x1505 (target: 0xffffffffa0000cec; expected type: 0xd9421881)
[   47.284738][   T71] WARNING: CPU: 0 PID: 71 at __seccomp_filter+0x419/0x1505
[   47.285815][   T71] Modules linked in: font drm_panel_orientation_quirks autofs4
[   47.287080][   T71] CPU: 0 UID: 0 PID: 71 Comm: systemd-journal Tainted: P                   6.14.0-rc3-00256-g449ee82c2013 #1
[   47.288846][   T71] Tainted: [P]=PROPRIETARY_MODULE
[   47.289635][   T71] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   47.291262][   T71] RIP: 0010:__seccomp_filter+0x419/0x1505
[   47.292164][   T71] Code: ff df 80 3c 08 00 74 08 48 89 df e8 06 a5 3d 00 49 83 c7 48 48 8b 7d b0 4c 89 fe 4c 8b 1b 41 ba 7f e7 bd 26 45 03 53 c1 74 02 <0f> 0b 41 ff d3 89 c3 89 d8 44 21 e8 44 89 e1 44 21 e9 39 c8 48 8b
[   47.294996][   T71] RSP: 0000:ffffc90000d4fd18 EFLAGS: 00010296
[   47.295952][   T71] RAX: 1ffff9200000e606 RBX: ffffc90000073030 RCX: dffffc0000000000
[   47.297166][   T71] RDX: 0000000000000000 RSI: ffffc90000073048 RDI: ffffc90000d4fd18
[   47.298403][   T71] RBP: ffffc90000d4fe98 R08: 0000000000000000 R09: 0000000000000000
[   47.299660][   T71] R10: 00000000f38ab44b R11: ffffffffa0000cec R12: 000000007fff0000
[   47.300851][   T71] R13: 00000000ffff0000 R14: ffff888195158200 R15: ffffc90000073048
[   47.302042][   T71] FS:  0000000000000000(0000) GS:ffffffff84443000(0000) knlGS:0000000000000000
[   47.303293][   T71] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   47.304156][   T71] CR2: 00000000f7f6a01c CR3: 0000000195c01000 CR4: 00000000000406f0
[   47.305149][   T71] Call Trace:
[   47.305594][   T71]  <TASK>
[   47.306045][   T71]  ? show_regs+0x5c/0x80
[   47.306778][   T71]  ? __warn+0xf7/0x200
[   47.307428][   T71]  ? __seccomp_filter+0x419/0x1505
[   47.308228][   T71]  ? __seccomp_filter+0x419/0x1505
[   47.309008][   T71]  ? report_cfi_failure+0x7a/0xc0
[   47.309781][   T71]  ? handle_cfi_failure+0x1d5/0x27b
[   47.310662][   T71]  ? handle_bug+0x62/0xc5
[   47.311249][   T71]  ? exc_invalid_op+0x1f/0xbb
[   47.311851][   T71]  ? asm_exc_invalid_op+0x1f/0x40
[   47.312604][   T71]  ? __seccomp_filter+0x419/0x1505
[   47.313383][   T71]  ? __seccomp_filter+0x41e/0x1505
[   47.314172][   T71]  ? putname+0xd5/0x140
[   47.314893][   T71]  ? __kasan_slab_free+0x46/0x80
[   47.315651][   T71]  ? kmem_cache_free+0x176/0x380
[   47.316399][   T71]  ? putname+0xd5/0x140
[   47.317031][   T71]  ? putname+0xd5/0x140
[   47.317650][   T71]  ? user_path_at+0x43/0x80
[   47.318340][   T71]  __secure_computing+0xdb/0x2fb
[   47.319073][   T71]  syscall_trace_enter+0xae/0x13b
[   47.319752][   T71]  do_int80_emulation+0x7d/0x140
[   47.320440][   T71]  asm_int80_emulation+0x1f/0x40
[   47.321158][   T71] RIP: 0023:0xf7f88cb0
[   47.321762][   T71] Code: 4c 24 34 89 44 24 0c 8b 44 24 44 8b 54 24 38 8b 74 24 3c 8b 7c 24 40 a9 ff 0f 00 00 75 1c c1 e8 0c 89 c5 b8 c0 00 00 00 cd 80 <3d> 00 f0 ff ff 77 21 83 c4 1c 5b 5e 5f 5d c3 90 83 c4 1c b8 ea ff
[   47.324586][   T71] RSP: 002b:00000000ffbbaac0 EFLAGS: 00000246 ORIG_RAX: 00000000000000c0
[   47.325827][   T71] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000002000
[   47.327053][   T71] RDX: 0000000000000003 RSI: 0000000000000022 RDI: 00000000ffffffff
[   47.328188][   T71] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   47.329334][   T71] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   47.330527][   T71] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   47.331478][   T71]  </TASK>
[   47.331880][   T71] irq event stamp: 7199
[   47.332440][   T71] hardirqs last  enabled at (7207): [<ffffffff814f0bb0>] __console_unlock+0x75/0xc5
[   47.333803][   T71] hardirqs last disabled at (7214): [<ffffffff814f0b95>] __console_unlock+0x5a/0xc5
[   47.335245][   T71] softirqs last  enabled at (7154): [<ffffffff813de303>] handle_softirqs+0x548/0x6c5
[   47.336680][   T71] softirqs last disabled at (7143): [<ffffffff813de763>] __irq_exit_rcu+0x68/0x145
[   47.337992][   T71] ---[ end trace 0000000000000000 ]---
[   47.338944][   T71] CFI failure at __seccomp_filter+0x419/0x1505 (target: 0xffffffffa0000c60; expected type: 0xd9421881)
[   47.340603][   T71] WARNING: CPU: 0 PID: 71 at __seccomp_filter+0x419/0x1505
[   47.341705][   T71] Modules linked in: font drm_panel_orientation_quirks autofs4
[   47.342944][   T71] CPU: 0 UID: 0 PID: 71 Comm: systemd-journal Tainted: P                   6.14.0-rc3-00256-g449ee82c2013 #1
[   47.344497][   T71] Tainted: [P]=PROPRIETARY_MODULE
[   47.345236][   T71] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   47.346778][   T71] RIP: 0010:__seccomp_filter+0x419/0x1505
[   47.347432][   T71] Code: ff df 80 3c 08 00 74 08 48 89 df e8 06 a5 3d 00 49 83 c7 48 48 8b 7d b0 4c 89 fe 4c 8b 1b 41 ba 7f e7 bd 26 45 03 53 c1 74 02 <0f> 0b 41 ff d3 89 c3 89 d8 44 21 e8 44 89 e1 44 21 e9 39 c8 48 8b
[   47.349980][   T71] RSP: 0000:ffffc90000d4fd18 EFLAGS: 00010292
[   47.350959][   T71] RAX: 1ffff9200000e206 RBX: ffffc90000071030 RCX: dffffc0000000000
[   47.352116][   T71] RDX: 0000000000000000 RSI: ffffc90000071048 RDI: ffffc90000d4fd18

...


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


