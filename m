Return-Path: <bpf+bounces-61180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CAEAE1ECE
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 17:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F5B169B4D
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 15:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653032D29CF;
	Fri, 20 Jun 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6FOetZa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E68B185920;
	Fri, 20 Jun 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433756; cv=fail; b=pcywNywkfedWjvDmjY0RB0Jden0wXxeW8O0p4KnwRFrNJK0iQ+KA6bcnjc7FjptN7krt6zaOjHPprY11K6i+rO+TojKmae6PZnVl++3qucRGktRpmbTy5EiW1JqktajtAsIEUckeAbIqZiS6MZ7IrH2RNpj0fNnJRj8KnPu7aXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433756; c=relaxed/simple;
	bh=twAUdFCdCEdffl9tJzjPOd2ArhDcK2m5/32Dzu5lQ2U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aY6OxXowS0+zDQtmAmA8Pm9OzoNNHlJGA+NdipBJfKOCjUtgWmt8BcfrNku9jSr9qajD+UcNLZL1Ka7sdSmuuc8MYx8jcwOYao9/LqXsDGyxz8lm/FrNRT5HsNyVK0Ek8o0XaFbXuOZitLzouRlN4JxfirSzJAYy6YexE3jv4H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6FOetZa; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750433755; x=1781969755;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=twAUdFCdCEdffl9tJzjPOd2ArhDcK2m5/32Dzu5lQ2U=;
  b=l6FOetZaDoG109XSr8MMg/YQU7JQD8iTAEgpaXH5KH6oGp3idnm6t+1m
   FAdip0iBOAENu6mBP/aXfUNkmXG2s6kIRrOpP5PJEGO5CKzxLrrrnAJ+e
   AtmkLmDyIODj7yr0b4zKPjhY2V0xvOz+sNgGsEV6mjx/FZpPLk40Kxvmg
   VQplJYTPhNEI7w8OiHqL364H3AJGW1KvhJ6bo2f2uWpbJTqsYkF3f9lRm
   uz3+f7qipii9Y+/j+wu8mW1Tu3q7DcVfLZribcK9al4AICFhHhpFrV+Ar
   1G2KvasNuhTij43VNAxBn+zirFr4Sv5J0FhjgH46PcDRc+SI6Bh2+Jdgg
   Q==;
X-CSE-ConnectionGUID: MwKzTVN5TbCiPdXtKu2DKg==
X-CSE-MsgGUID: fGr8wTTYS9ih5WpTDa+TMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52779884"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="52779884"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 08:35:53 -0700
X-CSE-ConnectionGUID: LaaU8/b2Q/aoVR25oQLxqQ==
X-CSE-MsgGUID: cJaeteaKTROS7bdkLEPcJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="156435579"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 08:35:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 08:35:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 08:35:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.43)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 08:35:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7DlaJxecTlzQMxnrzq5wDPUjlfvFRRMfkXqwwrGft7EJfEjBGajekBnfSgqZHNAS6XZtKTWkoNs/Kz7+Hxh0WuoN/Tg1m3ELSw2oSlCbdfUuI2ZLzKo6I8EjiTdaj6kAixcMdTpv899h9cpx/yrHLWMCribPbbpHedHtstF01ljFP7I7pDxGYFLAZE7mzWJIqX5JBtHJzSHUHrJHm5IHC8Jwy5v1tPqdar/K4Fr3R1P2812KYQ1UcqPk//q3lEWlVffyDz+8NO3LGOm2S8XjfQG1tqiU/HNKruz4MX9YieBUBMUfMZijNFjlVRlparB7FzCD3p2cEoMHCZzpSHAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2CWS98ltk08Nwergg/oil04CKaY6AKmI2EFI4Ui99g=;
 b=KZb6DtLOzIo9QjeiSIGg2MFzfhPOBovazcKI2NuD8Sc3YILEi8xNxwYfYaG2QBUrgUf0V/CACrR/4Xm2Ydo8t+QwrPid8PdJ/s+964Nu+CICAOzDWgWTHV/X5l1pq/zAVfOQkXx+CSx4N/ZVaQo4O7+pWjVHOOBpnh+5ElYgrZ5LHnKeCvjBBftvwSiymdXs9uIKLAlU55Hb4ieSYvkwUAVCei6wYAdB6bCttNZm6EyEzvx8SU3iBKlwkoOO9dZI/8MSxg8eF5VNmQHZqrK9PLxrRxGAVbmaC57AYsuOS3pYzog9NJH3hLgi5AMjBT8oV2PrYxMlcIgX+7sGGhM1EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB7062.namprd11.prod.outlook.com (2603:10b6:806:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Fri, 20 Jun
 2025 15:35:49 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 15:35:49 +0000
Date: Fri, 20 Jun 2025 17:35:36 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: Jason Xing <kerneljasonxing@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<bjorn@kernel.org>, <magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <joe@dama.to>,
	<willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] net: xsk: update tx queue consumer immdiately
 after transmission
Message-ID: <aFV/yG6pFEPwrwDz@boxer>
References: <20250619093641.70700-1-kerneljasonxing@gmail.com>
 <aFVr60tw3QJopcOo@mini-arch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aFVr60tw3QJopcOo@mini-arch>
X-ClientProxiedBy: DUZP191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: a61e584b-d292-4c14-78e2-08ddb0102230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wQGM3iqBK1bQv+wZFCF8iGZ8q8etbpHue0uMJ+RYR5t6YVXu3uqSRO2vJ0HN?=
 =?us-ascii?Q?FmDKL8fNnZKFl5JOsFxrhaYXJK2F0nRJ9Y2f3/BJSjqFzXqEGOd8mF506djI?=
 =?us-ascii?Q?WgUoV2EIhhWw4jiNbNmE3LghzyPVbgWjkqa7An0OaESD+gXcxdAAov61OkCH?=
 =?us-ascii?Q?BS6mka91kdaAyh03BsUjw/NtHE7aCSmYodh8lSaCjQdLvvHKmHJ7VZ8jOm7j?=
 =?us-ascii?Q?VA/rl3TedNWHsFx1P9q3VIW9ch8dJ2jsYDzknVuzZytSmJMKjSEM4ta1Zhqv?=
 =?us-ascii?Q?eJS32wcpkw5G+4O+XS2auyVQtQ/Pg4Nbok1bn3JC8GTnnuF0rpjHOwC+Q1EO?=
 =?us-ascii?Q?omxfwNswTFBdDFE5Ww36K99U4qXi6zkvVnqYKJn9loqOUjSWta4ELj5nM8MI?=
 =?us-ascii?Q?yV3+6D0iIhnWuLrQA/+H74Ky999GSL6PG/kvnPotTcXEHDYv1jmr0o3vVLhF?=
 =?us-ascii?Q?lIOTHPiYe+FyRGMypuOCiYdY/5abVqMoPHA+ggKiAz0FLKRdLrj3hTnzBy13?=
 =?us-ascii?Q?LpBxuMTM4yL2+7ke6Z9dDdhYV6or1T2KOVpS3gkjp+nLeNA9SljSRJpgBclo?=
 =?us-ascii?Q?C8mDJG8cOSYD1xdj/wMLe8rkE3mVObonGs30RYXwnvXVzVUSqbH8180+m3yt?=
 =?us-ascii?Q?gNK8/URLE9NqxwxC6jrQ3UGLlTuJvmGEpW1bU47Uz9rGD8FTL2louG7q3vRS?=
 =?us-ascii?Q?6uZnH9zIOC4jBFGju5Z/kspLttU/4kaH1MxsMSrsGyhgSWxxwYg7YRQEyQDO?=
 =?us-ascii?Q?f+GFvCpA5QuXDkEt0kKp8s7Me3HjPbk4HRP6ZG+pUMFbN9lKkpkgPfHv3/29?=
 =?us-ascii?Q?VljG1cHm+GtLecuWst4ZKJDa2ySmxrCFYzcp/e5IS51kuSWAu989Tpyj92OW?=
 =?us-ascii?Q?kSmWI249k4ys4QEWbJH4i1OBaZYT3KDO0YlUbyAPABDgUg9Gm6SmaMDlGvWh?=
 =?us-ascii?Q?R1yBW/KBUweQjbm3cXGi/d3C0wNveffUYZzrpKTvZrPTfdBtD8JkDWHx2Hjo?=
 =?us-ascii?Q?tAYvIO8BRdTNk9XWHXF7KBkM12RFGxknijDa+EyzgU4KRqjA/OLAAGIQXoFY?=
 =?us-ascii?Q?OOZ4ARtp3JlvxlsXLmxaD6xOigXhmcCIfRnAK56grYw+MA6kGByNmFBydGy/?=
 =?us-ascii?Q?4gvEYcLo6wiMUee7X6KmktKdhv9MXRrq0xhwA0QGm4MZQN4pzZR4DdhYN8i+?=
 =?us-ascii?Q?hRcd5/QMCu1MypKR35s6P7srdybTBoSGBvlFYeWh1qM0Sbl6X31lHPORwLhr?=
 =?us-ascii?Q?TWnzgV66dllxXO4nmDEH1/zjIu2tXbyLbRtg2yxEd0QEsK/+3ataQ58YrwSv?=
 =?us-ascii?Q?Cic/KhSenQRT5k9xM7kyc5DO1OHv97bBg0AMVHHJU0bC6xYQ5izfd69VsqP8?=
 =?us-ascii?Q?FVVaEJDp1pZaoByvZea4pNg9zcrZGoqkyrzgB0rAPHSnjOLZcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XJLm1pDnLo6YiTDG2RH6CGcQR4KSC+ljFfWGmP3lQujBSJ1SQZRGJSmx31ue?=
 =?us-ascii?Q?teJpiWk+E+sanAAqbOE3mgEeeUPxIdCYyyZgf0DORnjQ/vLcsHN7HOtzGuc8?=
 =?us-ascii?Q?sBD41g9p+QWN7VVUTIuCLXrzFE+O7eJz7xesrxj0VZK62LSSdjOS39xTtj05?=
 =?us-ascii?Q?+ugYW4yDHhARj4iVhDMlw20luWks6EkiJqEwyPmBQG433hiNtah9wjhPzqNV?=
 =?us-ascii?Q?s26ASub1qp3vfY91byg/hYvZyhqIXPypSTs/OUx04CgVg0kHUjJjsFMkIr6j?=
 =?us-ascii?Q?fSXkn/X8ehR/2WMuuYRmIbdsrE0hoVsTIA9R0T3k2pTcxRAz0n8P55wkrWP6?=
 =?us-ascii?Q?V8eMBW2AaF66CrbZXlDy+bVVBghJNjJzCYT92CHaUWXTtTCYrtfeCR1BdQvS?=
 =?us-ascii?Q?cWCpfd6+GqDSEo4JCVg3SOGFjBBP1wB0McbnjpiRRwtTBKGsNkYdNi2nYJuN?=
 =?us-ascii?Q?3QJrD1AWN1qx10U4Cof3skxOyuG5IJcDHNWJryQYKnFfvdfaidusPqzG1UAn?=
 =?us-ascii?Q?7uZ2XkIDMzQy6OXwUtbJ0hZRIKKE6WUS3Nr/5QGPJbA+tghMiPgT6vUyQogc?=
 =?us-ascii?Q?3epdk24Mgahm2yakzxDow53nKmFCr/IevT5K7q5c/FqLYVcQ/su2Ft+wu0J4?=
 =?us-ascii?Q?4r0ORQOhRPtwN/+qPeCoO+JPLdnLUUbbfl6loBfbLlUoVkhdrznvhsziDbNT?=
 =?us-ascii?Q?Ql7AfeIWTQbIjVYIq8kbBmKOtFlBIBIlyWPaZ7wuFELu4R2KHi50GJDKDvz+?=
 =?us-ascii?Q?ft7DxMcxR1KLUfDdY3sb7UJN59NojG0uBHlAfkfeAsApXMCjOWa6k34rl2Ss?=
 =?us-ascii?Q?xmQ99SJKn2UVnXsNaJ15JlPnhxVM2KGnVNYnM/F1z6btH5ptw3ICFSfhj2sY?=
 =?us-ascii?Q?LMTudiiIhhltFuS0WKfR/wTnqEmqaMo2MMJ2VosgsWRlur7KLgZ4+iUCs7jn?=
 =?us-ascii?Q?TeHz97sN7vJ64D7YfJCbF8h/BqYco22YY36rR8lBow94zoV0K/UeF2/5n6Vs?=
 =?us-ascii?Q?la/+XUoNRcSC+KHFjMVykceK3qoG60PdjvrQJbGGCyR+K992vivvrtm4rzr3?=
 =?us-ascii?Q?0m2A+29M2aKVG7inVhswiyUZD96AZatenCyQCEf3WbdAALkr5STvBQqa5OVN?=
 =?us-ascii?Q?n5BnCpLne9Cg7J+XpIgCQsyCT3vfcLmrDuRnj8lj3eUVf/z/KPviKBydfVZ3?=
 =?us-ascii?Q?Q60aMfxhlNPQuTWudiMPl1JCDjUhkmLIYMMgVyHbCrc2c/7J+shPxB5cR/8y?=
 =?us-ascii?Q?nCAZHNKqzkLN1G3fxMgLsb66iF4tSldw0JJSsDVgpB2FflPEgW2CKSw6+E7d?=
 =?us-ascii?Q?5wJE6S4DWv4CVWLiJNJrUzBqpn3XCRd+T4KXCkS/Zc8u6dCTpDNhCAbXWjDp?=
 =?us-ascii?Q?k4vz8fKEwOB3YNaLEWBcIBjDoR5ZPIit4mmEzBtdO9vLwA9XWrpt6dx1MeQ4?=
 =?us-ascii?Q?+2thopWTlOHOs/AnTeLnf2NN85jMe/JZvwuOLRmvW9YF25xHOKOeawCzJQyv?=
 =?us-ascii?Q?Zk6gYH/lP8MM8qt5gFkkzDJptDvv7Uwno8WRwOxPN++m8Cpx5YfjJhvBMQzj?=
 =?us-ascii?Q?rKbpQ0Ob/tZ3vet3ncHDMh9pCiNEHLWMRreh8FzZzKpI2PAgcsNUKY8hiCQb?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a61e584b-d292-4c14-78e2-08ddb0102230
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 15:35:49.7603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hm8+ToS98smJwmJVU7y5YLU6T8Ok6jFtEz3xDxVTWIJ86VBYy0cAJ8E8XcicMY+yQJj7B7cDccGzg1SSLkn9z468vx/v0sFkbb0qw/iPymM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7062
X-OriginatorOrg: intel.com

On Fri, Jun 20, 2025 at 07:10:51AM -0700, Stanislav Fomichev wrote:
> On 06/19, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> > 
> > For afxdp, the return value of sendto() syscall doesn't reflect how many
> > descs handled in the kernel. One of use cases is that when user-space
> > application tries to know the number of transmitted skbs and then decides
> > if it continues to send, say, is it stopped due to max tx budget?
> > 
> > The following formular can be used after sending to learn how many
> > skbs/descs the kernel takes care of:
> > 
> >   tx_queue.consumers_before - tx_queue.consumers_after
> > 
> > Prior to the current patch, the consumer of tx queue is not immdiately
> > updated at the end of each sendto syscall, which leads the consumer
> > value out-of-dated from the perspective of user space. So this patch
> > requires store operation to pass the cached value to the shared value
> > to handle the problem.
> > 
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 7c47f665e9d1..3288ab2d67b4 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -856,6 +856,8 @@ static int __xsk_generic_xmit(struct sock *sk)
> >  	}
> >  
> >  out:
> > +	__xskq_cons_release(xs->tx);
> > +
> >  	if (sent_frame)
> >  		if (xsk_tx_writeable(xs))
> >  			sk->sk_write_space(sk);
> 
> So for the "good" case we are going to write the cons twice? From
> xskq_cons_peek_desc and from here? Maybe make this __xskq_cons_release
> conditional ('if (err)')?

this patch updates a global state of producer whereas generic xmit loop
updates local value. this global state is also updated within peeking
function.

from quick look patch seems to be correct however my mind is in vacation
mode so i'll take a second look on monday.

> 
> I also wonder whether we should add a test for that? Should be easy to
> verify by sending more than 32 packets. Is there a place in
> tools/testing/selftests/bpf/xskxceiver.c to add that?

