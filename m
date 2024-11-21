Return-Path: <bpf+bounces-45418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A573A9D552C
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BB61F23793
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 22:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606E11DC198;
	Thu, 21 Nov 2024 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLycAlZe"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA41C57AA;
	Thu, 21 Nov 2024 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226906; cv=fail; b=pGGMZ3lSwXGNqvhNW4vlebRkC/kAvF/tabzQ3eawX72ZOby+DqoitToaCr6gw9j/fbbxtpf16LSNJRiadFFLP1+79HrkOl4FCLgQyCil7ujV/0Ja6quTbb0rEUSdlQ+KhfF9K2AwGrkLRtM7YiNg1AKbIvk04cwUv+bHd72ydbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226906; c=relaxed/simple;
	bh=HCuWBiBp1MEW1hPpyBRrP2D+dBTrodDr3epzWvtlxtk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=P05rLzxa7SfUDwzU9ocmweV/WEOPdN78SeItgNwKjn9mRTbeSjNFj0RCwF8OAgsbuKoOTkyKNVIFvkmJNeAtsg8T7J+Ldf+f5HHTAI8mmWObDSELd9Z+F0ektzc6FSOdoXJjyGn+yrwyacYq4Ho+hYl4SHdUdl7AMGSZJ9JsSd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLycAlZe; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732226905; x=1763762905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HCuWBiBp1MEW1hPpyBRrP2D+dBTrodDr3epzWvtlxtk=;
  b=OLycAlZeDokvdiqCi2IkqKM8FmGEHy7CgAhEdXHpds3rOfFlJZEkvbnL
   sELOpphmb8CFUSfATl1LOGC40wnt+/1ypz+w/gwfIKo5ekHP3ebwsOD+d
   nBB/rn44iNfW7+ZzkQ+uQj74fjnFrqyhG5PCAHAilZfqNiQ9lZGQOuD65
   Ut8/1+LoUDrgF2NEH3c1hn9X9iWPA/Ngd+tNlDM5UsMVtA5EmXvXEav8m
   Q/lzKng+VGhPWOYA4vCNuCzRQW9WotmJKExBzNg0eM9v6emUbAgK49DFi
   17yC2V+1h71mGxgPSwQRUNUsJtgYy2UurQYtsod9/hQUVf7G7mqAcMvUT
   g==;
X-CSE-ConnectionGUID: s+/gKPeVS5CxpWGzq1HfZA==
X-CSE-MsgGUID: 7yOM6zlcRNOHm2bUXlWBgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="57768861"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="57768861"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 14:08:24 -0800
X-CSE-ConnectionGUID: a2/BFBaGSU+TSEO0uUCwKw==
X-CSE-MsgGUID: aJCrND5lQVCM5Uv41WLVkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="113671194"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 14:08:23 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 14:08:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 14:08:22 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 14:08:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9n7ChSNz6xdf8eeJ9ofgOG7v7ecOI2JO9hdoDGWtOK7c8zOthVTzIwmU5TX9rHPEZ/jc2vQgGH9nt6D7vBZFN28KMszmqlJOf2TCQmRNSR6Vl+7bLKN1NaE/OxTOfCaodJ1vfeaj9mVRpLwbWjuV6faxYQtF/rTDOcv4M3uFFHRUe9wcaLWkwKHqmlRedDS/tXXpu7CDvDSF0uDKiMPwy3bgGUCptTuXEYuh3YfrbI5M7ilFSQO1g3r3lOvUFRO3gVZFW3nxlBK/4WSk3wKS33c5sav2GNcC968f8AOAMhV2ua2+qQcmKH8TKVKvw8Z72P5YuA1Dg0v+QCSjpt9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QobvNdeEra68aZ8/g8hmDQ2cDB6qjpu+gybZH6HwqGg=;
 b=mobo2Kdg96jthTNpd02oGqBMHwHgSWTjC81m0VYg8seKeWQu+F0KABHlbT93sArW5Hh4DHMRtnxo9U6rJRTeRi13SdZR6EnVgrfaYamuUn+zvYwogdCSGZO7rlTuTEafnb+hVIt+cdxoLPQ7T3mOuqwAXZMUB1hV9/TZFP0lY3EvhFLfnUcl/K3tOAwOF7MQNp/k7zhVlQcdrlW2VTu+K3b8PTFbcBPoNNoNBcGbdgKNyLk8otPUfE02HUdCk23jKWqGpRfUs7J+6+B3aOVMBYv1LiV6bTV+0i1dUwbfcCQuLPr7ll38r1CG/Hcw+Jd4BjoJj8jc5bK6tM2rkr6uHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 22:08:19 +0000
Received: from DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3]) by DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3%5]) with mapi id 15.20.8158.021; Thu, 21 Nov 2024
 22:08:19 +0000
Date: Thu, 21 Nov 2024 16:03:07 -0600
From: Ben Olson <matthew.olson@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	<bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH bpf-next] libbpf: Improve debug message when the base BTF
 cannot be found
Message-ID: <Zz-uG3hligqOqAMe@bolson-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SN4PR0501CA0116.namprd05.prod.outlook.com
 (2603:10b6:803:42::33) To DS0PR11MB7444.namprd11.prod.outlook.com
 (2603:10b6:8:146::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7444:EE_|MW3PR11MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4efdf8-775b-4f0d-bfe9-08dd0a7901d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Zb9EZ+Gl+x0a/qXW6TmQmNUxfb+eQ/gvkxZzHy9V2kgJFw/1wI3DdjAea25?=
 =?us-ascii?Q?BFJKZoT5gn5A+8GuhBPqjzED07+J80ueCQPvU1PR3mW2z2ZjwRvG9xEMlHf6?=
 =?us-ascii?Q?j+J1UGX/1Q9V909bNgDn8h1MbCKaIQIFLuHVjAYO3Yo/PddxurNr/67Smy60?=
 =?us-ascii?Q?Oyly/QbUr6sO4x/Q+nCfOXDSh6OTOzesPpV6RJh06JaaXiOJPdO0dlXeNDOY?=
 =?us-ascii?Q?t7C63nRvPTofycyQTH0CvZ4vH9cNqGsfZh95occdRvieMC2eXtO52OOed8+8?=
 =?us-ascii?Q?rqtHuPyjcTuEasRlGC18HPd/CjQJ7htaeRYga1pOlgSZOqf2Yia9h6qZPIL/?=
 =?us-ascii?Q?/uu7hdkOcACb8mI+SHue9iwVzPu+v21YaqI9fTF6hlpPYRX9HQKh9PpczvIR?=
 =?us-ascii?Q?rE0ygdm5St0JxyGFMb866iXUPWMuv8s3Q0nP5GQhncE/0j8AV/gfgp4bFGD2?=
 =?us-ascii?Q?N7EJRdaBnrJN9X76Ij08WGY4qxAtPMMG4+uWCGrxHVDAKlydgtn/AEI2BxAv?=
 =?us-ascii?Q?N2ETC5zq9jl3lyoiCrMGBAob60kRyv23mG0S8Lj+WvWcRELZaowpfY4QFh9l?=
 =?us-ascii?Q?QqHJVYAbn5GvpmCyYF7u24CVIi0oc4OgO6nsufftv6PXwYSiVPNqBBqG6oZo?=
 =?us-ascii?Q?+xrMaiC7j0z6TDbgMTMfexB5MmQlBdh032MB/V+kZU/oMBFo0TKHybwrczBf?=
 =?us-ascii?Q?40kLvQiPEqDd7LMB2p2cXmROuptmZ3CZ5G3sLqtI5ObcG0dn8VSmrHy4Ps+Q?=
 =?us-ascii?Q?+Qa8hASzuCnb+zrhHLefr0VCOObqBZIIcm/Pe3FFyj1+3D/2EVepKtzURoL8?=
 =?us-ascii?Q?22CRMwl1F34ESEGlt+9DJ0MOiG5tNIJy25+/guaiBu1OCTRDYu4faO4xJStU?=
 =?us-ascii?Q?h3FSq+1ebrhFARMXFdT3i65AiHIvlsL7wVIjciYgRD/sYPbi4G6Yj1WToZPD?=
 =?us-ascii?Q?V+ZMj01wiSeTZRoHUNac+pxo8W/NR2NUuEcS3ySLdJgSHZ93YFPRWcTlOqvC?=
 =?us-ascii?Q?65sE3/lhRj3ZYx/cub9F/h2CgDADcvkvIi8IymYNf68owuyGVr3hXo6r7KXR?=
 =?us-ascii?Q?9gW8uCEdZFYGuVN/q6BKwScg7CE2/W85NU3v3cbKTOrwrukI64grI6EKVu1c?=
 =?us-ascii?Q?NpeK5JnDJz+teo0x1awpzf0SYe8UxKToRuau9igUUUkRrykQbRXcjGUcwmZU?=
 =?us-ascii?Q?TtnZf49FkYD2sb2z3ZlXTSrAmCfC3EFznECMar6khHlbaW79U3m3ZTaOVezY?=
 =?us-ascii?Q?ez+CkojN9vpthtACWVlQZ7sTJMt06gUJFBTY3mDv0v0sh2YU6A5SragnZipC?=
 =?us-ascii?Q?4WBG6wm3pEGdp5DTb7KcVaZ+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kIkvweTPFtP/qv4N5lvoecrkEtuCQnIROigHMRRIudSxQEoiZnhSTmB1MhUT?=
 =?us-ascii?Q?vpcNQ1rqdaYgqTy3/sVfPz0YgJZnSwXVGOHuIpL0VjQstKp9m0ie7S1mbP16?=
 =?us-ascii?Q?i2LkeJLmXTz3ugVyy3Hhs8XioLe0FZ+GTTEfscxt5Qbo9jzbXINUaMnBrwdK?=
 =?us-ascii?Q?UcfKUuUD6+VUjOYm8rymGXYK1hGZueaPPTyoJYeHoiY1lgVZhaJryGCgLSJ+?=
 =?us-ascii?Q?NYDCnJHkqFN8/7D/TvGx/LZXP0Xcr+NjYW7ciWr+ctZTkdTo/xY1RITp8ouz?=
 =?us-ascii?Q?CfFPyrF10Q7YlH+6urdT1G6oUS731dTgscNmo+BnMfPHSeR4h/EzO1j7f4x0?=
 =?us-ascii?Q?tEn2/DhdoOtB1b+sQzTLzz6HmyNbUKl1syq3pq9z2qQP7/Q65tXt0/4uQfAB?=
 =?us-ascii?Q?kT+lTOaJHJlbW+RJS+AqozKPqiWDBB0qaZwCmjYNEVcNiQtQ04PjYd9iCjx+?=
 =?us-ascii?Q?InPBMThiG55p6RvfYxE/5FINg5PFyjWYgJHUXO5St6w8VrTjdWDOFYiRcDvW?=
 =?us-ascii?Q?amX0JoV+dIP/AL8T+PT1rgKIW9mzkWtfH9XSYvVRq+sljScPkZul+H5R5XiZ?=
 =?us-ascii?Q?Q+CKuOKlD6YuhKRLiE1xtppsFKT/KN2KBNcgeQMPEZVbLVjWtIkDh5x9lLtl?=
 =?us-ascii?Q?BQgDcKiilnqKaQnKzMdYsyzMOM72J8LgojeLFPs3m+jQqEMW94urec3Fnjbs?=
 =?us-ascii?Q?v4NxjmiUpiYLBjDdgHLC54cQu9HAovpYXai/pwetv1IeIGNhcotlJucQ3Vig?=
 =?us-ascii?Q?wkCdxW6L4X3Dy395l/CBlvKzBWZbUWddAaMLRrTn+GFplo8vVKaWvJBfskUu?=
 =?us-ascii?Q?Bb6tUSK6LSsr04VR+X+txHLkUtHyzTVgk4THl/U3vaQFzziNtbD8ThykdII6?=
 =?us-ascii?Q?3ubLKIX7oC7DrVsMSe4Onblz7cUtb0VbrvDcY30X7Yg1r5aU2ZJVJGYRZk3Z?=
 =?us-ascii?Q?o1yNJbV096fz4IO2VK8+vh4eVzraF3PYTChfMFpNkPJAfDMeRJQgly0F/4P2?=
 =?us-ascii?Q?KAAdXeOzBdGWNwf4Axf4MzcmV7mJv2olhQNu7vIPOCIdLfjMBji9Qv7K95c7?=
 =?us-ascii?Q?7yyb5XaI41gQoI/VJBC23/jz3Psd4lP9AJYQJsl2i4WTKfQr5h9Mt732lSOv?=
 =?us-ascii?Q?bLNnkDVsN0WkKkiS3Oy+8bmtzENjbeLSvAMSd/MtzqA1fTChD6Il0qDNY8DE?=
 =?us-ascii?Q?DbrWBATJHGWnRpLJd8Oqp03uR0YwM9tM6IqdP+rhRjfUsgSVjTNq5610YLwI?=
 =?us-ascii?Q?z2jsAZZiqR8Mb3EqhOMGg1YvA5xqTZJamhpWW8x1YBv8mBqbgaaAv9Tdj/CL?=
 =?us-ascii?Q?dA5kPVal3MDTZ9ds0pRIJf8sSG4JYw9mCzScnsaEs4dUckzT9OI5v3tshzgD?=
 =?us-ascii?Q?huEUXw5QBs6D8agKMRj9JvkZMyp/Y5RWlCSQEDvbQHIfdeOQHuwsnUTBVYQ1?=
 =?us-ascii?Q?xboq+s4XE4PXxELSk1MD+2MxmBaIxAwTINAOFQeHNmj0JmpXTdKUPavmweoq?=
 =?us-ascii?Q?9zRBI0/VrWvqeXuRmV7fW3xVZItUQtuuMrrwi1hSF9giBEBn52gh91HZi5zs?=
 =?us-ascii?Q?0wAoe2rf15IPmof3OeuhbzFUGBIwylGekELrAnALLLJimREHSNMGTV7HW+M8?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4efdf8-775b-4f0d-bfe9-08dd0a7901d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 22:08:19.6250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fj7xYxYGvhlXsbrAxEC3h8whLPT+U3o/ssAc2gxNYSH4ijWsT+M/UHd8Mxhdwi/ymBz2JukZlitwekM49Y78HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
X-OriginatorOrg: intel.com

When running `bpftool` on a kernel module installed in `/lib/modules...`,
this error is encountered if the user does not specify `--base-btf` to
point to a valid base BTF (e.g. usually in `/sys/kernel/btf/vmlinux`).
However, looking at the debug output to determine the cause of the error
simply says `Invalid BTF string section`, which does not point to the
actual source of the error. This just improves that debug message to tell
users what happened.

Signed-off-by: Ben Olson <matthew.olson@intel.com>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 12468ae0d573..1a17de9d99e6 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -283,7 +283,7 @@ static int btf_parse_str_sec(struct btf *btf)
 		return -EINVAL;
 	}
 	if (!btf->base_btf && start[0]) {
-		pr_debug("Invalid BTF string section\n");
+		pr_debug("Cannot find base BTF\n");
 		return -EINVAL;
 	}
 	return 0;
-- 
2.47.0

