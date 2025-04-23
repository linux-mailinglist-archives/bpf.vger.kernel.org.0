Return-Path: <bpf+bounces-56502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40E6A9948E
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895EA4A2DED
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B049280A5A;
	Wed, 23 Apr 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e255NxtJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF817B421
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745424106; cv=fail; b=UI49MVNdYJqBU3SiqJqebk3TJ0qJ2pTEgG8ZT26VVDe5SKX22g9X9iRnCGwjL/s/SbcXR6x/R1lAlI1hG9zlODJKUgQnjeW3gXplxp+fIU3X1xGSrTOswbM6GsNmsRED/pkzkW4gfivkvJmZuTFsGIi4VoyVXWrWxejJcnsLB8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745424106; c=relaxed/simple;
	bh=2TgWrnU+JUoyH2fNTbPnyELeY3PY8sGbnb2Ew1gAVIw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N0VL4jexB12FuH0Sa49r9zym/OWeA0Z1MtXuGOUnTlE6XTQd6Jz1kwCV2LXT+9I3C9/FS7Ffd//5iHVesLI9o6YTLeqYio3crx6CvUtKNiy5diggP7JiRkuRcpL4cNYVgUbUtWcj2Vyay2wDZD3gTI7WPZHm4Cb1vZ4RwCjleRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e255NxtJ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745424105; x=1776960105;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2TgWrnU+JUoyH2fNTbPnyELeY3PY8sGbnb2Ew1gAVIw=;
  b=e255NxtJdKv18Un4KAlIhpn6C8nWZ0YlBJt3Mnt9UJEBCiiovKaSSi6v
   myw3g8oMf3pbkLrEo/BEFRE8KsfK1SrRgx0Jf+PHys5wHXG8jZMmcHlgD
   p0rigEu3tX1lsqfUpbUxBRuRaxSuS7AS1t83MdFZFl8Q+y0nENXGZNm/D
   t0DumeBTcUxR6YYu5pFnT7ZaS+vlMz3boh213V8r1VwtNfIboAMtggnrq
   SbS7yjI0pcWYfeSUtHpug0EQhrn2HInYw9lQw6DddwlFjWtimchPDm26O
   Q/M57lZ0FU/YDwcDjQ4HGgrYSsNHG8ZDO5T8dVlkjMXjWouJkEtVyzkwO
   w==;
X-CSE-ConnectionGUID: 31UlKknbRoKP89np7lXKNg==
X-CSE-MsgGUID: MtWbayIYRMyH8nnImFFypQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46260292"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46260292"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:01:43 -0700
X-CSE-ConnectionGUID: GQ/mTN0ZTTuuKsOxaY2CPA==
X-CSE-MsgGUID: 6qX6nV3+QFedwerAUAykqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="169563542"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:01:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 09:01:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 09:01:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 09:01:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DW37Fzm2AD4RFKhd3gZHCTFmaqEUlu76qXCJasKkCCOp91Nj+Q3puS2vYKnGJ9aCmQlyAWYr2GuU4kStxayzeQjFGE5PFzAG03si5+VzqgNn9jHfk+ReQyKegkIF/R+WZkGuhSHM79GybnHFuGUMkbPOEzEwEtWzitr9kjeNpn2CLalVEh416z45PWCp2G4oYcwkS2du8GVX7/6RxiIFHLZiWLgSK76TU6FvgFJyblOzDnHrkfol9qFQSDzwu4I57afMM127JE8n42R1uuRLFcbu0eFY3fQ8AR3g1Gjin/LLe+iRGJBjia3kG87u90BI9KxtfBGavbcCpU2vWi62lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILiP7N0KruEP8RYSthF5nBsl+ZiuHJBLBZgGq2lKxd4=;
 b=rjulnC5B/F6JL6bjEdXnyCyBZKiSJa8L5VDVTJLrrGjaFA0i7e3enE3JuWZifLfplKHyUhjcKhQxn1I8J0vM7waP62luNdCy21w4/OWC3bSg0xJvhdbOW7jkDBDAeKswOcUnI9Zi4Equ1qUa0FmvKJAf6XodmDG4Eh767EkTfmpjEJS95XD2yv0Ywd3lgPrSyW/OnzxCO+SWDs1GLbR1YetKwk4k4o/kIlGMvU4NiGyNaPH4Xlw1Oh2iBIkGVMdyqbvG+nof59z154IB/QjfRmMew9j/yOmino9TKMa2ULl8Uqji8p2y2oyipYvmEbEygpXUH9e103/gW2XGiv4SJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by SA3PR11MB8120.namprd11.prod.outlook.com (2603:10b6:806:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 16:01:37 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 16:01:37 +0000
Date: Wed, 23 Apr 2025 12:01:24 -0400
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: <bpf@vger.kernel.org>
CC: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Subject: [PATCH bpf 1/2] bpf: fix possible endless loop in BPF map iteration
Message-ID: <20250423160116.120118-2-brandon.kammerdiener@intel.com>
X-Mailer: git-send-email 2.49.0
References: <20250423160116.120118-1-brandon.kammerdiener@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423160116.120118-1-brandon.kammerdiener@intel.com>
X-ClientProxiedBy: SJ0PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::21) To SN7PR11MB7043.namprd11.prod.outlook.com
 (2603:10b6:806:29a::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|SA3PR11MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c2e50b-ec48-4d98-412f-08dd82802044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tp3BOxJEm6mzAnh6sswPAPwDWGlt3VNKTHAo+weubbtHxxQdyl+88AuzQfMd?=
 =?us-ascii?Q?kj3rB8CF6Osaq5vLlvcBgK7JAuz8nOKz/F5LwohtqjwG8vZ6nlCiEObZfkOy?=
 =?us-ascii?Q?/KwEbwK3NLo+PwFlYYLnMXHtgQmZWRRmDDdq2kpbsr32jl0ER63TwNmAi8OW?=
 =?us-ascii?Q?DW4GKBgJTxcHKwiIt0SucSGlcxk/5JjZIQfG+ncrXkK0OiRDcqHHSvK/aItK?=
 =?us-ascii?Q?UrPjNvCoW7mgZmLAmV6t1/S6iH9HgYN16pM+ZH0TuiE8s03icF15PHMNrHEq?=
 =?us-ascii?Q?8HjgT04VymiUZDMeciSY+AzfQwwReax865O5HSriWyKwx6yBMhggpD30JbSS?=
 =?us-ascii?Q?BqM8HtHjEjnGioaMuZl9jyvwRhKRjeYf/EeqYEC+Ffd6O8bPEJtQOESDWD+h?=
 =?us-ascii?Q?SeQPnyL2v08no6B9kxg9onoV/Mc1zU/xBGIAAk8vr0ejqT2WJCa5resBFfdW?=
 =?us-ascii?Q?kYiHigC5cjVf5fQYwuNJwCTG69MZEeD3wvebjS30b5Og3BvmtYnG+LMiwc7I?=
 =?us-ascii?Q?QqEYyLzWjlh2lAPUQ/vcEZShUhT1KUkHPZ1NfT9HdheTaUaNf/NkpZBEcfQh?=
 =?us-ascii?Q?ToR0tQaE2xA/8WVS29KV2WhlUYYpnKkQaR5m8F6JGKsQP5VbgeJgKn1zxhO7?=
 =?us-ascii?Q?VgshgbAxL3l8CP6YdbZ30feuRjRip4jXsGquQoKEjt7kseReF34hgfdBP/c3?=
 =?us-ascii?Q?jSTLIkSz3FwhonzMD6WKpKlqaJGNeEGDG6lilI9Kpq6plysgF6k9D8FsuSv2?=
 =?us-ascii?Q?fR3gYokUQSJ76dur238W5VaXoivDLUJ2MOQeoZBJSR2F8CDU5q+xgo5GRYVJ?=
 =?us-ascii?Q?ZINPyBvCEMHZtAcFanbVzAXsc/y451OCqy4g1AisftvryNctMbCbXfu/6mGX?=
 =?us-ascii?Q?lxJk+ZRiw+//QSGL4dpLToUxvbDN8gfVg/6ZnskDBkUsBOM2nhijyUwHVGR+?=
 =?us-ascii?Q?93CdUINb3BPswpglH9+fVMBS7lUuuArNFvpLxIy7Dm6aA9jC9Xecuy98HSBm?=
 =?us-ascii?Q?DK2SViSD4pbUhXSy4as9EwBRNskSzvReLpkBj4nCmHZCotoJ0mZDEaE8v0BG?=
 =?us-ascii?Q?Hqcq5CjWgHaVNbn+chIGHpoJP/vk6uRdeD56arcd2VLL3qLQynQnxhF3OzMV?=
 =?us-ascii?Q?3/Ltm8vHU+ubxZZc8vHx8iDCK7n45+v0GaNcG1yf+qHCIblUN4uSAWDRi9zz?=
 =?us-ascii?Q?Wvxp+uHgrhgNnVLIncSTxSK8WzD0NPLXhOIxVAZ2drXof5+4kA0Cvtwj4psT?=
 =?us-ascii?Q?nD1sFUoqrd42LsAMNvTHdY6oNz0G/IJNokG8f/oMj6Dw8vIweQ3YRhs5rIks?=
 =?us-ascii?Q?FA+q1Mn9p9GcnXGDtj3UbOEB5kG8Oq0SwUVynyMIf4cq0ZrhajtCqwofYCQU?=
 =?us-ascii?Q?86MZPOkLbEcl+zbDNo062HKBHZlr/tV08plE0XUweyPBrAmwC0dQUieyldZo?=
 =?us-ascii?Q?Zuh2exvEn5E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oh9oXmZRz2WzUF2SbBYKWatalkq7ZTMvVuX6d1d8kqnQM8vbsFSZjgojZ4+A?=
 =?us-ascii?Q?Spz4HQpMoxFGIFc+JPoKOMSS7Q00/WSO3Yp0P3ab4q3Ms7mwc+bjtU+i4Gc3?=
 =?us-ascii?Q?9oKndH+op+ruPaVSVEtVJXs6iQgQDVhaxAipjdiBhDV7W1QFYA51sSEW0O5U?=
 =?us-ascii?Q?NGAE/OlnA8Fw4gHLNJWIui7aRUVC6sZ1veh7fp9LiC0UB9UWo8qyifoLLgwh?=
 =?us-ascii?Q?UJK4IZCXEDwVb4jNhzyvOO5S0cWb2VEA5rc5MacPMX6ynHKbkLRm1LzyntY2?=
 =?us-ascii?Q?/fUCaZa8q7BjOFJ0qG1nS5xB+q/BWSh0MOSOH4QgRP56kSFS/DvUH28/rLRG?=
 =?us-ascii?Q?SF6AHbN5E+e8bWztVQ+gekEAQgxxZH+jZZJzLHVywjL4ChmSxw/tFXVKvq0E?=
 =?us-ascii?Q?FQY6JyrYVHV8clcZROpG1VrWpgeycotFdmDMJWLE/GG5tcS+3uYGUTSCJJKA?=
 =?us-ascii?Q?ftiP9lTAsa0cF38NpdBVDHiyiGMAp1/VFsilR6o9lVBO1M2bkH2DLdaOawIQ?=
 =?us-ascii?Q?0gHUKXz8cLAwB6v4EzUZW+ERNSaNq4O3/7pwhtnBK/Gsq0fMZuhoeCh/XbDP?=
 =?us-ascii?Q?c1kdl6FesZ3Tescn6pCJopiAAvLX7JbYGRsXQ+tx7+7C9U6j8lg9dErvYV3H?=
 =?us-ascii?Q?poLndi0ctukQ01WG/62Xy7GLe/EUxwixrOF06K7mmCG1I926XBOvmrkPPYt6?=
 =?us-ascii?Q?iOoMUv7Zm67kTB4eWatEqzAOCnqucFL/bCLxEIeCvCr1uSV8l4M6uKC6NsPi?=
 =?us-ascii?Q?bcxnENnvQfZDcAKXnHHy911AwFdKwaiDAfKnDB56dlOBn4C+6ORuI4BiAMYJ?=
 =?us-ascii?Q?GY3Uu0Z+Qsf0Io9CjCxBnAXI0RJweFZ0Ttdonf/RRKrrh+gJVMytqtQAklQQ?=
 =?us-ascii?Q?fB8W+NhJc/lDTCPDXQWp5nnOBSUsQc8KSaB1VpgCjoHCju4ma4IXothSl42v?=
 =?us-ascii?Q?8VG6v0En/5E06FLk2KzYsNghxyP2gl+2MVAiHUfZjaPGqGMCH/EbbPd4tU61?=
 =?us-ascii?Q?dl/oN67hcc2c9Ahcf7fuxt8m8PZOOtOPBMgvzt6XC7wtkbh3r/VFeZwW5Ly9?=
 =?us-ascii?Q?WcASSZGkJITqFIVhoBQa84H9t8e/QiklLbzW7I8FkFfi5lj+wGMN2YRsDR8n?=
 =?us-ascii?Q?DdXrGSR727fE87LNljtHz5bNHtF3WHOvk1o0AaYNxjvGgprdJerrApml+Tb9?=
 =?us-ascii?Q?8QKYRHeh+Oq+8rNX3P1DaOdi8M0rhtzl0tE/wpxU49ve2XvnmFvQRF5hW/FK?=
 =?us-ascii?Q?W9Iujfy59zOp0ZGKmC96NQ0KX3OqmxLidonmeUXsMi+lhRPdiKP38xPPHwxL?=
 =?us-ascii?Q?y/lHpPpGg4qPzJ7FyyxWzPOUrLstyL/nZtXeZsypMQfb1vDngcarlZhWJGD7?=
 =?us-ascii?Q?LpU/WCpqb3L1H6h8OUf/tTSqmhhtZi9tSeIumV+BmsVAx0F1bTDYXhPLhnYt?=
 =?us-ascii?Q?BYscmKP7X/wrE79vCu3KqFq3MJADI0f8ek/HDXvCLdhcOVmb/t68KaMAKcI/?=
 =?us-ascii?Q?TRB9D7fN/EWM9lQXDHBTpncu+kzRYYl/EXAfZhhh/EYRFR8hnMqMSiHPpqSf?=
 =?us-ascii?Q?LkmCE2b9NisgmB+K7b9PS/p6ul2lfDyhgm3fWAZFMbxLTwmDhAJik1P690C/?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c2e50b-ec48-4d98-412f-08dd82802044
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7043.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 16:01:37.2579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mh6PgJpyOpVgtXlLVHt9j3supPLG6odGSfHPF+2hg9/Ap3PzeaLdGZ4r8m/PQQqT5Apxj/x4CyxbQ63/zKZUQL9RiGG01m+8sUPSKA3Tww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8120
X-OriginatorOrg: intel.com

The _safe variant used here gets the next element before running the callback,
avoiding the endless loop condition.

---
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5a5adc66b8e2..92b606d60020 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2189,7 +2189,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 		b = &htab->buckets[i];
 		rcu_read_lock();
 		head = &b->head;
-		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
+		hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
 			key = elem->key;
 			if (is_percpu) {
 				/* current cpu value for percpu map */
--
2.49.0

