Return-Path: <bpf+bounces-45743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EEA9DAD92
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 20:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4DEBB24A79
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88273200BB5;
	Wed, 27 Nov 2024 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmrer8jO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E12200119
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734488; cv=fail; b=nY5oY6mB4a/AwvtI6MtrYsEQqSLdZhe6Mij14rwOcAoMUC6/WD5Vw1HTIAvZ/5nUul7OJ8AIX9zIU0aB6GAl/63F7OfwoJ6x4CoSGQqqp2VGo7w+PWCKolj6D/LqcxmLsJo4MPD/n3Bv73IZhEAoiWbpS8hNWGrGcVpza/vm8LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734488; c=relaxed/simple;
	bh=8ijTfDwLj4H1asWc7v/R9JqwlAsfa4gjbWjkjoyWWVY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UO0uipKXsTHIsGZHHb8him6WZuBM37bNstuojEjDGUMiM0H5Hucr5xGohbcEVzatiw5sFTD0H7rghhTM/1a9wgPZobuDrvTtvIPZ/1OWjyRswMiJ0BzPJfvJSMdjIAahgMjbbJ5OlNm3yZRrOUTRtD8Hn99h+xDj5LrA9y7KXYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmrer8jO; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732734485; x=1764270485;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8ijTfDwLj4H1asWc7v/R9JqwlAsfa4gjbWjkjoyWWVY=;
  b=bmrer8jOeZHl3gzPAN0Uyid6PmJAGQ4BzL0iwVIcMM7gIt22OwG/BBZ+
   X27Ts+HRMyaYk7RA57d0Cvrmyl+R1b6pwsdDff6rS35uGsPg1cK6sIGDQ
   3ZQJbY/dByMELxxnnyyzYPxS0t1dM5kKA/RgNywdqSv4DT7pAOaOBButy
   JODyo1PrJe8/y1/xn7shIEPT8Qna1IlBwIigntG1rcnGp2FphE0eOz8CP
   vp9NdKrLscFhPujnOwh8hQKRT77KvYKHwhBfFPEEwITDMt0gGdhV0cGjo
   qwdhxL6lGMIxsp0NiW8C6bTRsdyyQ7TCY2+lT2EhKOik5dAe3Lfzb0o1M
   w==;
X-CSE-ConnectionGUID: 9XK46kX4RmqmlWDaiKL2qA==
X-CSE-MsgGUID: t4SEPRu7R/il4aMRrz72RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="44332536"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="44332536"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 11:08:04 -0800
X-CSE-ConnectionGUID: Plx9856HQ/aeoYF7e8JJBQ==
X-CSE-MsgGUID: lpAdQCCGQTqtkZg8UNBusg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="91955051"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2024 11:08:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 27 Nov 2024 11:08:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 27 Nov 2024 11:08:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 11:08:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxrUE9QI+fGTklW/Kau25vbwN0nnJRGVEUHX0memR3HJvnIAuxz1Z9PYToAqHvG5fDfWwNChkNxdo12U1Lv0LpIjjIouJAOlGL/eKMqyWoUfNJ6/1d1mMiGTogKk/1xNQP8emBjeBlNNEXDsFqyi4qrJzMyWiM/hTszVBeZT7TiEJkAi6ru0aMolwu0TrvHog2L/585ElxoGA/VwkIqVwZmAte4AhAmKmSs8P8ccrAKiLDFuqF9s6Wm1V4O0/WJ4ZFTdXhIJ34LLz8GLIovVZwWK9ov+aR98aTC9BdAteGOa2R4wE38dgsggJ5lTB2289YQF/a2RnJaUa4Cttli6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76d4vxJMRZhl+KE97JRoIK76j/mxTFMQ0kQO+DvD6y8=;
 b=WY+d0qfwG5Ipm65p8c3/c2XM6RJpttrxZ6+hZewK1dI4YxpH2l5DkwFhJOkdNcSXgmfpibT/QAkNgpHDwIHe+UChDhJNEUF6CF3bJW4wFVg5HrJ8YE2EbkwkIZy4oG12wOlp3BkK0oA97esuts0sspkI8Om3DO2Nk3L2ps0vGWUVW19Xi7CoOIG/l0fsuixLuhkBkxy2ozXGoqVqO95G5KsOkJSqS7dZzw750iFSuOVuhdWEeV1+j6lqRzm0f9tJ2vOkRQGFYz5SjpJH96MkcfWbxKKC0Ntjcx7wthMct14frIfG5unHZ3ZIDVIsPDCiVAqGAJKRkhLGNg6/TrZ+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB7761.namprd11.prod.outlook.com (2603:10b6:610:148::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.18; Wed, 27 Nov 2024 19:08:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 19:08:00 +0000
Date: Wed, 27 Nov 2024 20:07:47 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: Amery Hung <amery.hung@bytedance.com>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <sreedevi.joshi@intel.com>, <ast@kernel.org>
Subject: Re: [External] Storing sk_buffs as kptrs in map
Message-ID: <Z0dt/wZZhigcgGPI@boxer>
References: <Z0X/9PhIhvQwsgfW@boxer>
 <CAONe225n=HosL1vBOOkzaOnG9jTYpQwDH6hwyQRAu0Cb=NBymA@mail.gmail.com>
 <d854688a-9d2d-4fed-9cb8-3e5c4498f165@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d854688a-9d2d-4fed-9cb8-3e5c4498f165@linux.dev>
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH3PR11MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: ff125e38-1781-4c4d-dadc-08dd0f16cf99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AkhuSXzAsknYM8Tfnr5Q4BRxP1wIYD7jzE0ViogyDYH3uZCxw7r3sURtNUng?=
 =?us-ascii?Q?arfAsO17AYYw+S4rNeYjWqNEi1aGI5G31lkcMGOqlVGEy4merXGyz89a31fs?=
 =?us-ascii?Q?9lmaVyS304ewDB0KPfaFcQwKBnXB8egxCVRod9lzIQCxRWVdHlCcJHGr+EVa?=
 =?us-ascii?Q?3k4O6fMTBllFKgNoIze08tOMrq8WDtqyT/RcyyAdFDC/mYmYUcIqGp/9PGJW?=
 =?us-ascii?Q?j2YP9tVUKPJeTcIKjQcO3L/EZZXkzMgcvbG7po+a2oLgUJaYZ9kE6wUsgFAm?=
 =?us-ascii?Q?a+bZD8n95QHH/wbZtzSWQaA60xEggGrS92cH5Pisx8uUD1JMx2zAD4Azgfwo?=
 =?us-ascii?Q?96gv7SUnBPUjKgeOExVFkQ4Lp08NI7IhvAOp9KuzjqXvJ8mu/Z9weUMFA3ou?=
 =?us-ascii?Q?b8VV42hpd2H+bgW4AuVXkfs5FqZx+Q/s/nOXcoLCLDiWG2YSvWUQCirGho0r?=
 =?us-ascii?Q?wZFnWMYPLn6y2DtEVlhlWFgYx9nLun6dR/5InbByJIb3iRcb+n5iaxaApgqX?=
 =?us-ascii?Q?H72jTfWaYngqHlGqE4IaNniXn+H+o+1eaZ+66tSJ/YdP1QpAxSOS5PLeV+d2?=
 =?us-ascii?Q?AycIFuu/c8zWQZ0mJiZqKec1RkiZ0iT9FdrQ+iERSkEYA8qx/AdKaZxICWk2?=
 =?us-ascii?Q?Ff+ttCNR44OBw34y2pNt2Wyukxwp6xX5hiBOZ+v0yyNur1LYjmmaPEZHxh/C?=
 =?us-ascii?Q?hTWqJ8yzxwfWiVhOKGD8Q06NDwdjqEnHjDgIooezVoH40mQWuozj74ulp8dU?=
 =?us-ascii?Q?yp10poFe+QiQA+cW72ofCuFbiNiaUMTJH4J3EFLKGBh581aEqlsMpEaLonQ3?=
 =?us-ascii?Q?z+4I7oxXrJVPeeJBYV2xbkTdkz44iVNveVwcYxw9o2TuLk0fkZsPzmIaHKQp?=
 =?us-ascii?Q?p5QGnFlVxGjyQ+ztCDkV4wbU7drckA6q2YPOm+LsdsHJtkKbOD/nkmdc/yN1?=
 =?us-ascii?Q?18fqs5zFrfcqUyNDS8tc1eEp8HiFu8uu/CaUrRkGGP4bW3GyO7ysW5T8eioH?=
 =?us-ascii?Q?AsgnL5sfex7pIRKfOfEZ8rJxoocA686Jods5l4023plRHVGyD+kxjRpYpR3r?=
 =?us-ascii?Q?5O3btoQd3QWnSu8jeNyf72Q+9rt3sdF2dkEUlSDRVzVez/8Ne5Cp/M67k55X?=
 =?us-ascii?Q?M+BoBY38N0Bbi9hsWu2oJqmSohGCuKFLHw/gM/eZE/jBonz/rECTWOOhCK6O?=
 =?us-ascii?Q?9aw/VeeZxDqxI201WA4AedHeo3OuuhsrKEL8loceXU46OVb5+gww8zHX9N/w?=
 =?us-ascii?Q?R+ZfNWIJhW9cdUNj4bF9owHaPU0CQIuXIsA5qh2a8HLkuRKQDmwZCxs95jcH?=
 =?us-ascii?Q?XVcBjtULklHmIkIwqPS1Sgqy5HGp73EQlky4fpFFtKMGnw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xjr3z/8ef8FCByK1bhVB/BIT25dYaowYYreWPnE3OEiV4lnNAZL2+yZxMkrN?=
 =?us-ascii?Q?a7kzgTChR8b/2Vw3R9gfglunneL7zAqI2ZSMwmqA6VgiJCCyqRQFLMXYfvkE?=
 =?us-ascii?Q?l8pelwi0R/mViBef2ddyhl2jW/kiqI0eB1KHOazHsAePH88zEKhrV4X7GKqe?=
 =?us-ascii?Q?ysyrZHvPphSdGHBWqmh5E5Fl2ATDeLuurV832iyzQFunsfjhIuuHBahUMf1F?=
 =?us-ascii?Q?JRsQagCyWTW6YgmMqPsTj0TVd7d5cVheRUmpYYlGu7nVvjGh/hLp+Qjs1G2L?=
 =?us-ascii?Q?AUI3oEU1G98A77S2I1oxD0yVXXlgVjIdNK4dR4ZIm+3heJqMVCASlmvVEPXn?=
 =?us-ascii?Q?Jo/b9SO7Dvrb5PXbjvUrCn32hpKnHfrVp5rW0qUQVztJwW+AajCk9zFxecwb?=
 =?us-ascii?Q?qWTri0kF5Ko8oIwo0/gcGjmdh5xEPmti24bXMpRd/jgDZjNgqHD6rByACqPe?=
 =?us-ascii?Q?I7N0UxBYeANFq4xsHNL+VkA8litMq33GH42Ry6O+YqxDsKBQ1aXnxKzKudzU?=
 =?us-ascii?Q?9RSi6QK2pq/j6M1jC2ALN5GqamHVi9DdDRqP0TOSv8zZzJEutGXs/4L8Nnwu?=
 =?us-ascii?Q?YTaXlY7OfI9v7ejUOCiSkur2FAzektEY5nPVcigv3LKhlhuPQ4rsthqB51dk?=
 =?us-ascii?Q?XlF6Z7b8Uc5bl4QD8IR/mUXrHB+W6ZjUIg5vVeJsf7/igLTK/UU27048BPTP?=
 =?us-ascii?Q?ydu9NMZZbGjmyL4bDRddNpferVboH1Rc3hi0+9rxQRSO4CmhVhOWMICJ36O+?=
 =?us-ascii?Q?sOz3l/UdtACA1sNoJGiAKIPSaPG8a5Nvo+i+6nuXsRvDBF0M//8W2Hinakbe?=
 =?us-ascii?Q?pfmlfKHkJVXRtd/8Oa3zGM+yTdLZQymXR+rwuFSYOYuvdrcVyaC1stv/ITAK?=
 =?us-ascii?Q?5Xx0et+WyOQyGxa4ZpLShkC7xgCMjfJlgoZkFYamChy+SuMsyEJBNG6qfd1X?=
 =?us-ascii?Q?yRxj0UhjO0Irs35qJlPn2i1WpgmvHiEDeUiRVZKM4bJtOxqlBB7+gdJ7j8SH?=
 =?us-ascii?Q?tGMmnrMEPdko3m6wc2emqSyIpL/eAnw7pmw8A/mIBIXRhCXaRSF6PGe2M9bs?=
 =?us-ascii?Q?QKxeOucQRV+CFk4IrYDhdF6dPAemWHNM61rLB3VxarzskR+RoBeqRbMve6Gd?=
 =?us-ascii?Q?opPM0o3J2nA76V+maIQaY0WmTf0c+Sju/h91HJMiSKFcYmmiVYHYaZhXJ8Xp?=
 =?us-ascii?Q?7lTB5XBmJDAbmc0n7NDTmoJJ4gV5sqpIDb9MJWSDXAFUZih8liV4Vz7GUS+J?=
 =?us-ascii?Q?QcrCSRvinU1tGBFx/GnD+xvCJkk0ttpIPSB3/M4BEgLkE5/wnRnvgv0rS4kK?=
 =?us-ascii?Q?7UN9cUWrIQg3BIkYMWivE2nZ3KOo+rliV78zrnA/JiFslsI1X+lZeOz8aNq2?=
 =?us-ascii?Q?4Yp1N7FNkGSv22aYqZ3DyJ6RyIUbeyI0D7Te4KTYQ6IiDgbylaYTOnDDnOgm?=
 =?us-ascii?Q?ssVmxq/MPq5dOUBAu0rXBzAnZS3u8jMHoMmYzT9sMMtU7woRMyb7cVqOSbD4?=
 =?us-ascii?Q?JbyeJ12xYHRBHZoVHlSRrL6eOGLIx2ltHbVStRNg/rkUY+V1/7ZusydN1XDc?=
 =?us-ascii?Q?XMRFwIPZX9AO/DCXDpcV7FyykC0AjEgUZ9Us3l4hwZEKvto9IO/hbQC1/OqA?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff125e38-1781-4c4d-dadc-08dd0f16cf99
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 19:08:00.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YK4HAfVrQXmVTJsgtbVdlAMoHW3PKczEzbEn3F+dQuQpM/0JYnOnIWEQ4Funxz5W1kWJUHEgpDUpsy25UngE0IsI1FkXxxF44JXi5ZpOKPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7761
X-OriginatorOrg: intel.com

On Tue, Nov 26, 2024 at 12:47:09PM -0800, Martin KaFai Lau wrote:
> On 11/26/24 11:56 AM, Amery Hung wrote:
> > > I have a use case where I would like to store sk_buff pointers as kptrs in
> > > eBPF map. To do so, I am borrowing skb kfuncs for acquire/release/destroy
> > > from Amery Hung's bpf qdisc set [0], but they are registered for
> > > BPF_PROG_TYPE_SCHED_CLS programs.
> > > 
> > > TL;DR - due to following callstack:
> > > 
> > > do_check()
> > >    check_kfunc_call()
> > >      check_kfunc_args()
> > >        get_kfunc_ptr_arg_type()
> > >            btf_is_prog_ctx_type()
> > >                btf_is_projection_of() -- return true
> > > 
> > > sk_buff argument is being interpreted as KF_ARG_PTR_TO_CTX, but what we
> > > have there is KF_ARG_PTR_TO_BTF_ID. Verifier is unhappy about it. Should
> 
> I don't think I fully understand "what we have there is
> KF_ARG_PTR_TO_BTF_ID". I am trying to guess you meant what we have there in
> the reg->type is in (PTR_TO_BTF_ID | PTR_TRUSTED).

Yes, sorry for taking the shortcuts here.

> 
> It makes sense to have "struct sk_buff __kptr *" instead of "struct
> __sk_buff __kptr *". However, the get_kfunc_ptr_arg_type() is expecting
> KF_ARG_PTR_TO_CTX because the prog type is BPF_PROG_TYPE_SCHED_CLS.

Yes I have sk_buff as an kfunc's arg, I am using bpf_cast_to_kern_ctx() to
get __sk_buff->sk_buff conversion.

> 
> From a very quick look, under the "case KF_ARG_PTR_TO_CTX:" in
> check_kfunc_args(), I think it needs to teach the verifier that the
> reg->type with a trusted PTR_TO_BTF_ID ("struct sk_buff *") can be used as
> the PTR_TO_CTX.

But kfunc does not work on PTR_TO_CTX - it takes in directly sk_buff, not
__sk_buff. As I mention above we use bpf_cast_to_kern_ctx() and per my
current limited understanding it overwrites the reg->type to
PTR_TO_BTF_ID | PTR_TRUSTED.

However, as you said, due to prog type used and sk_buff as an arg,
get_kfunc_ptr_arg_type() interprets the kfunc's arg as KF_ARG_PTR_TO_CTX.

> 
> > > this be workarounded via some typedef or adding mentioned kfuncs to
> > > special_kfunc_list ? If the latter, then what else needs to be handled?
> > > 
> > > Commenting out sk_buff part from btf_is_projection_of() makes it work, but
> > > that probably is not a solution:)
> > > 
> > > Another question is in case bpf qdisc set lands, could we have these
> > > kfuncs not being limited to BPF_PROG_TYPE_STRUCT_OPS ?
> 
> Similar to Amery's comment. Please share the patch and user case. It will be
> easier to discuss.

I tried to simplify the use case that customer has, but I am a bit worried
that it might only confuse people more :/ however, here it is:

On TC egress hook skb is stored in a map - reason for picking it over the
linked list or rbtree is that we want to be able to access skbs via some index,
say a hash. This is where we bump the skb's refcount via acquire kfunc.

During TC ingress hook on the same interface, the skb that was previously
stored in map is retrieved, current skb that resides in the context of
hook carries the timestamp via metadata. We then use the retrieved skb and
tstamp from metadata on skb_tstamp_tx() (another kfunc) and finally
decrement skb's refcount via release kfunc.


Anyways, since we are able to do similar operations on task_struct
(holding it in map via kptr), I don't see a reason why wouldn't we allow
ourselves to do it on sk_buffs, no?

> 
> > In bpf qdisc case, we are still working on
> > releasing skb kptrs in maps or graphs automatically when .reset is
> > called so that we don't hold the resources forever.
> 
> Regarding specifically the bpf qdisc case, the .reset should do the right
> thing to release the queued skb. imo, after sleeping on it, if the bpf prog
> missed releasing the skb, it is fine to depend on the map destruction to
> finally release them. It is the same as other kptrs type stored in the map
> which will also be finally released during map_free.
> 
> In the future, for the struct_ops case, it can be improved by allowing to
> define the sch->privdata. May be allow to define the layout of this
> privdata, e.g. the whole privdata is a one element map backed by a btf id.
> The implementation will need to be generic enough for any bpf_struct_ops
> instead of something specific to the bpf-qdisc. This can be a follow up
> improvement as a more seamless per sch instance cleanup after the core
> bpf-qdisc pieces landed.
> 

