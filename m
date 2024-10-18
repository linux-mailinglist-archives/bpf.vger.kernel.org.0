Return-Path: <bpf+bounces-42415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7804A9A3E34
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 14:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEAA7B223B8
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 12:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7638015B12F;
	Fri, 18 Oct 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ji1Tsb2t"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0E42ABD;
	Fri, 18 Oct 2024 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254027; cv=fail; b=nujsIVaiK6li/C1UjjSiaZikG51dl6AzPXG2s/tm4qHskBs6+3VjzqR334sdQHSeHVEzF1TTfevqOFHE/8+5zBJG+nLpxeF+FMuRlZdEHKJ8SUMkW3aXYFyQXph7uZCQK+JB3xzlc+9fluRseN3XU8fmLqhYPoa2Zp09tvCGoi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254027; c=relaxed/simple;
	bh=szCwkBI8Sg0nEaSljL6aYB8o6dq7AkLkrLQgnHtN8SM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IB0gMJt6PR8+2es2rlVPY4wXHmBnTIHQEpxiWcpXUbhli0jJhudl3cEEgW638QPJggPCgZ1kuJYniPUknIknBdxQk+w5cZVbkc/RzLJtJqGsGiBfEHtfATihCwUfAnvhGxNt9s4cAlTetBIRvHmRNqwOKYwnLIQE2UHcEy4Boz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ji1Tsb2t; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729254025; x=1760790025;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=szCwkBI8Sg0nEaSljL6aYB8o6dq7AkLkrLQgnHtN8SM=;
  b=ji1Tsb2tBbLyUnyeYw/H/xh7ixtYqylpyXUoxXKl+Ax4oQGm4Up799E/
   KLax4yn0GoNikfKBXlW6cVTgbz1IcNAxTXPaAy2IUENVjulrpcKtDsp4m
   6xeM3qKkLzQb15r8b/owymSKGjYSQ/UEdX8AWGCw/x4Zi6CmyEQFu39pI
   vuLVNjV55VuBg2DqXwu4AyR4RcfRhazXsI8QOqhZtYK20OJs9wchNJxN7
   89Jo2GDbEvVnqER0WjocD9te5pUGAy532maOpk4sXNr+aaKKJijFaML4G
   QvRsYj6emk1tRu35jxc+QATwQckFozRliUHUI6j99JBFAfpsRDsjJqj6B
   g==;
X-CSE-ConnectionGUID: R5lJM8hVQfmTWPAcqIJfCA==
X-CSE-MsgGUID: GQeUnEL/RGKtR9mZdtlRPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39325270"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39325270"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:20:25 -0700
X-CSE-ConnectionGUID: kk0/CQ/8ReKJ6CWKNe57Fg==
X-CSE-MsgGUID: dsaub9s9RyqsYGc02OqZcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="79275503"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 05:20:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 05:20:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 05:20:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 05:20:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aleOH2dF/yYxa1HmSNRBimDyLg2m7c4wwYh/X488UlpV1DlTVw3xg/jySkvJ1OepIxR3ZxZzY4eZXpdKzs4kQd/f3nYmgK0UlVFOR/ZwkPRGWd0PM4w8kg0K8ScMnZ+oLaM4Ngn9M70NGRaTYnkCUB/XBUuAfwNV/qIZzmGgEdXTnRQf86UsoESoDQbyxjGl1q7TDeSKvrlEWLkjnqfL/eZABV4NhqH3zM3OuSZjvTaNh/yfkrg0S6fF3T88KOiIdQfOd5Rhs+mKKFJVDCvpTNbFXn0N0WrHxDqFSgOG3fde/tFzt/WXIT/OHxz8C3cUFUqBqlFfwiuZ1TKxhRmFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKdmUGqeloo1gr8ghNzqVEddPVemo7WaI+Bk/+9Kxl8=;
 b=RCCDg7rHMU79K3g4y04rPIP/NoXG1c5gxqKUSNKgGrF8l5PdqtwfiqOfWF+3NrKqqEKZrdH145wRIKNdWL4oFWLD1n5FAwbXxYRaV77zIpMHZE3+MlnAezJ49llt/pEyU5HK2R0qlTMFK4KEbHH6GK9mvEIEwZLQTQr9oDQ2Zo0Oh8TezRzUCRM+BahGDqWrF5ZrLw7FlyJ//3ZVGE4d1dOgBFpGFJqf67cLRnBtmId7YovdpBx86J54N1/3fJUDa1JA1hH55AJnkZIWbXq41iStDN4yutHYUocxY51Gis12nRQfaoOn1hzZVgdn/KbAT2MlbXN6polE7TLalMTkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM6PR11MB4737.namprd11.prod.outlook.com (2603:10b6:5:2a2::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.23; Fri, 18 Oct 2024 12:20:20 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 12:20:20 +0000
Date: Fri, 18 Oct 2024 14:20:07 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Yue Haibing <yuehaibing@huawei.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
	<alexander.h.duyck@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH v2 net 1/4] igc: Fix passing 0 to ERR_PTR in
 igc_xdp_run_prog()
Message-ID: <ZxJSd4Hj5+TW01cc@boxer>
References: <20241018023734.1912166-1-yuehaibing@huawei.com>
 <20241018023734.1912166-2-yuehaibing@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018023734.1912166-2-yuehaibing@huawei.com>
X-ClientProxiedBy: WA0P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM6PR11MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: da0d02c8-d5e9-4037-9b69-08dcef6f3bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iPre3tFXt2lwMM0OpkOg9ueY6dB5lxW15jKenk0ReiwjIqXZE7UXshR+vyO0?=
 =?us-ascii?Q?r6DbWyYCY2wzb1V+PX0QF4fKQHcE7dxXSFz719XgYV4oHpNJYQe8n8frpm6C?=
 =?us-ascii?Q?3hh5iqoSjpKVN8LoB/KAJrEd7O20cINnyOeR6jo2gH8SKn2F0pf+wHR6SHTb?=
 =?us-ascii?Q?phWYug9N/APsN+oCHjNN/Hs4yGRf5dWUfG6Kq4BwxyH1vBZqbNI/+gMxp5xB?=
 =?us-ascii?Q?z5t1qFQidnp6TpyMSGmlTIQp9f9oHTI2fmryNAGoqcDS765D03xZ62eSTBu9?=
 =?us-ascii?Q?qbRdOUGFMNF04Ml4EZddWiTMDYXMhxHYxWxULWgUDbA7BQHHDUIuHLwuvRW3?=
 =?us-ascii?Q?wJmEpkoeQ0qJ7FqUUQEj62kMO+v26pug7IFbg9EfTCivA/O+uQ2vSiFp/IaV?=
 =?us-ascii?Q?yCecS2hcFblOXyjmErMLfIDhUuzHqVLXUUlmhtYoTKcw1ZtMyVx/fkR6krZq?=
 =?us-ascii?Q?moKT1OeJdVZsR6NgRgghy7jvPRuXl0qKXZeTQbSsEmXH+qEIJgSI8JgGXNAZ?=
 =?us-ascii?Q?dZRHY0+PKv4TU9whr/MZRKfRFUEpQoHZG+e0HoElB6ZJA6j5847wBFJ4peQp?=
 =?us-ascii?Q?5BuyikQjFzutFqZAX4pB77sCulUSGmXqvuRC42rJJPcERp3uFBMsmIhnzt2D?=
 =?us-ascii?Q?GUaLKG11DrUlYt5Z3R9nSlO2KTDNwBqTvc8v0+2K7k1BFIGIm6PpqbMkM0J3?=
 =?us-ascii?Q?kPqh2M6bdxhXUzqYwk8IWHQZNmblFsjyG6bkTEis0YjeEzjR45iOL04r8Z/H?=
 =?us-ascii?Q?XwKEN/7wIgjiBCd/u4yAcqLwGj8QfiMso3JJKDsBMv8ZgqjIjxGfdX6A03fI?=
 =?us-ascii?Q?VQNwFg03PnSvlJb9D4b7F0OY+nu+Bj35INN+AjBLI4dkuleXrZRdOPai0qW6?=
 =?us-ascii?Q?qmZmnScCeOU/GWwAUpGFc+umSsuY7RJTWioIJp6rA8dPb3gy0qXAhZ4ngTCl?=
 =?us-ascii?Q?lT6LKD8P+TOU+S1oUrdm+FXQcQEZ35/aEvHZHXv0r63CvcDNcwROmmjqx+s8?=
 =?us-ascii?Q?xjWxGhxyGfPR9Fv9QXTAqDeV9tOGGEMD8+dg9XI590RVf6fqnFzj3ZDpB1e1?=
 =?us-ascii?Q?cHiN1nmgqhep6D6H6LoWIWHQLThENmUkBdyQ7k9KmTzQZZY4CQ62hHT3jZDJ?=
 =?us-ascii?Q?rrZGLBzk4mhFLZDc4fAerzut06h3RiSr/RhJAbD/w7p6F+boPHRfqVal4BYJ?=
 =?us-ascii?Q?ShnVvz7ZufWwaM0NNA6wcvoCiOAP3nmR2ZTHp9mXt+GafrAoTOcsruPILzyr?=
 =?us-ascii?Q?CWytS1wTElPPZ9UYTnH56KcZziGBKW7FdeQa0Ftpase611319ifhuGaJzLnu?=
 =?us-ascii?Q?qTjIqGhJiNjWzOZahpdOdUp5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5eQjgVyQEKprrTHoluodYq3D3xYH1KC42i8zgmcsif3PQaFysfCUUtaVf7As?=
 =?us-ascii?Q?tzB0DPgugKJV6zWVl2vRUVWcCU/Yi9rzIlUTU6chQ/PEnotyl3NpqAYHO+sw?=
 =?us-ascii?Q?Vp7mp19i5vYx9ZVRUyFYLxlyR8VENJ9CibP/HJjKG9ZvaG0D1IrXEEMKkNqg?=
 =?us-ascii?Q?ByA+eLQ1rBQVu8PamaBT1rtLP0fQnEuwmloh0KRRLsuxLulF3r6uFJwhIKEz?=
 =?us-ascii?Q?EHhERISmYCyQJ8EPqowCddEw/YJydYoKxKv0KYt8L9XjKhMwjiREidU5dJll?=
 =?us-ascii?Q?GK1GCMj/Q4uEqTd/m6X9TIlWXx4ka9ZyNNR3s7LAT6N52jW0E+wQKfeCimgc?=
 =?us-ascii?Q?1Z1jT+i+dKHiu5I9d8TPSedhxApnvI7Yrc9w5D4mmcEl57JEGfHbx1UtsyFp?=
 =?us-ascii?Q?j2ndb6kUH5HKog9C57wd1hp7xmOBLTxjZMtGbW9nmTLdsQBaJDuxF2oDj3kY?=
 =?us-ascii?Q?JW4DOWYEU1ritOm8BsbUNuKAtN16jtcBVFnNRJjmZk8/ccKnOFj8JJOAQMDF?=
 =?us-ascii?Q?Rg8o5/GXSfCtxlO6v0EeCb/dHpDFIijeQrY1e+wb6ruDEkOPOlj2zWbUaAlG?=
 =?us-ascii?Q?m7+I2kDslZLSr9OW/agpcUCex0BG3UWmjYpE0+Ka+/B0i/sRxXELTkn80V1D?=
 =?us-ascii?Q?lolsnk8JUzWGmYFzOSJV9+xYldtY0AYJjKnfzjF+e2mXseP1y7GpahxxWd0U?=
 =?us-ascii?Q?wuKSJGSWqm8SKipf4k9o4cBksGHccEzLkE3ujlMP2FxQ7Oq8g72XghYmAuLJ?=
 =?us-ascii?Q?3g8gJmPUdcorva4TIh9bStRtdoBlkvFWKc5L1Au01L36pgJ3Ob2eRLp/KnpQ?=
 =?us-ascii?Q?OHDx4Fud8vrniJPNCTQfoNNK9XIFsLcwa5hxujAWDKYIvoxo7mPmBXz8Kyef?=
 =?us-ascii?Q?U9xT+bunHjZ1CCxKCKgkFuTmUvbG5KrTP0P+ttRIYrWCyzGvtULsn2+xFiGY?=
 =?us-ascii?Q?a4tr48P9PzX04dUyuhmQxuLNvrtf5vCdu2dA5ekV+psc6ZlBpiqVqgBtcK++?=
 =?us-ascii?Q?Eb4GMDVx6xQfZkPhX7lNZtPBbd4gZ8MxyY8nXedzywCUftZvHGrAPhc/ewRU?=
 =?us-ascii?Q?EPrH5ENxw9u9mLijCn/3Jy9D0b5sI5YJqeqxGoDne2nMWmKIaTpZCqLdbNSc?=
 =?us-ascii?Q?MIZT7l2g5FYZrcaf0Fl1lR0YbrujjT4gOIvRZ2ftC1NG1F5JFMOpBa1I5WDx?=
 =?us-ascii?Q?dETHGlnPgd1vNj+xki1OaVnK+1MzFZCGyoq30cGig5awmUwB0KE/xaJERaL/?=
 =?us-ascii?Q?iAHVmoh/oB/gwQp7/AEKfKehgNRtrCpGAt5cOQUol6lEpmTqHK6Wi9PZl9pr?=
 =?us-ascii?Q?rN74G9VPjszIgKwOUB3sQUgw0VLiclTCb0//rNHN2ejYQM6U9RpukHrM5l4d?=
 =?us-ascii?Q?JYqISAOQdxk0mmvclVp2ZxYIZq+63baRh1bZF81nFOPT5XtD2rYw8I/BdRO8?=
 =?us-ascii?Q?4Fuc7u1e0vHWLCVqG0IFMBb2NtWmACjD3X9zkixRd0SqdibUDaH/qcYQIlas?=
 =?us-ascii?Q?ti3Y/F0c/5Hn+rrl0MrWE4HfloCiJ+WRdwaNh/wjX2ViOVymWATACfCRaNJt?=
 =?us-ascii?Q?nzWy6alETyRPvrXk/hUI85txbRZN3B4rHbKTcmtfFpKW5jhqHDSyQvjw+/Rc?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da0d02c8-d5e9-4037-9b69-08dcef6f3bd5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 12:20:20.5690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k94c+yVZYhYh+pqWy2+bd40sVYDm2zzFPxRKQ7MltqchZU+WMFaKCa4gThq0NAlMoLXR8a018yyroy/7GDdl0Au1byqKuzxfGcN1LQwhuaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4737
X-OriginatorOrg: intel.com

On Fri, Oct 18, 2024 at 10:37:31AM +0800, Yue Haibing wrote:
> igc_xdp_run_prog() converts customed xdp action to a negative error code
> with the sk_buff pointer type which be checked with IS_ERR in
> igc_clean_rx_irq(). Remove this error pointer handing instead use plain
> int return value to fix this smatch warnings:
> 
> drivers/net/ethernet/intel/igc/igc_main.c:2533
>  igc_xdp_run_prog() warn: passing zero to 'ERR_PTR'
> 
> Fixes: 26575105d6ed ("igc: Add initial XDP support")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 6e70bca15db1..5e44c2546a12 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2123,10 +2123,6 @@ static bool igc_cleanup_headers(struct igc_ring *rx_ring,
>  				union igc_adv_rx_desc *rx_desc,
>  				struct sk_buff *skb)
>  {
> -	/* XDP packets use error pointer so abort at this point */
> -	if (IS_ERR(skb))
> -		return true;
> -
>  	if (unlikely(igc_test_staterr(rx_desc, IGC_RXDEXT_STATERR_RXE))) {
>  		struct net_device *netdev = rx_ring->netdev;
>  
> @@ -2515,8 +2511,7 @@ static int __igc_xdp_run_prog(struct igc_adapter *adapter,
>  	}
>  }
>  
> -static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
> -					struct xdp_buff *xdp)
> +static int igc_xdp_run_prog(struct igc_adapter *adapter, struct xdp_buff *xdp)
>  {
>  	struct bpf_prog *prog;
>  	int res;
> @@ -2530,7 +2525,7 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
>  	res = __igc_xdp_run_prog(adapter, prog, xdp);
>  
>  out:
> -	return ERR_PTR(-res);
> +	return res;
>  }
>  
>  /* This function assumes __netif_tx_lock is held by the caller. */
> @@ -2585,6 +2580,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  	struct sk_buff *skb = rx_ring->skb;
>  	u16 cleaned_count = igc_desc_unused(rx_ring);
>  	int xdp_status = 0, rx_buffer_pgcnt;
> +	int xdp_res = 0;
>  
>  	while (likely(total_packets < budget)) {
>  		struct igc_xdp_buff ctx = { .rx_ts = NULL };
> @@ -2630,12 +2626,10 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  			xdp_buff_clear_frags_flag(&ctx.xdp);
>  			ctx.rx_desc = rx_desc;
>  
> -			skb = igc_xdp_run_prog(adapter, &ctx.xdp);
> +			xdp_res = igc_xdp_run_prog(adapter, &ctx.xdp);
>  		}
>  
> -		if (IS_ERR(skb)) {
> -			unsigned int xdp_res = -PTR_ERR(skb);
> -
> +		if (xdp_res) {
>  			switch (xdp_res) {
>  			case IGC_XDP_CONSUMED:
>  				rx_buffer->pagecnt_bias++;
> @@ -2657,7 +2651,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  			skb = igc_construct_skb(rx_ring, rx_buffer, &ctx);
>  
>  		/* exit if we failed to retrieve a buffer */
> -		if (!skb) {
> +		if (!xdp_res && !skb) {
>  			rx_ring->rx_stats.alloc_failed++;
>  			rx_buffer->pagecnt_bias++;
>  			set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
> @@ -2672,7 +2666,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  			continue;
>  
>  		/* verify the packet layout is correct */
> -		if (igc_cleanup_headers(rx_ring, rx_desc, skb)) {
> +		if (xdp_res || igc_cleanup_headers(rx_ring, rx_desc, skb)) {
>  			skb = NULL;
>  			continue;
>  		}
> -- 
> 2.34.1
> 

