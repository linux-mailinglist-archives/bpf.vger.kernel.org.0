Return-Path: <bpf+bounces-75401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B842BC82C36
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 00:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD13437CA
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 23:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A315A2F7AA4;
	Mon, 24 Nov 2025 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXT3fc5X"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BF92F5492;
	Mon, 24 Nov 2025 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764025421; cv=fail; b=U1i09iqd6Hen4D6J8n/Lv7kSeboFmlE2otpSMxJKOL8XnnpWg5UKj7BArvFwtsYomR0pKBdjlI1p+2ORtOr+rmiQMrh4B0P9CYy8zzZlfPeYydlxRMXOhIYfw0OmfYkuXpOjaDuaiVL/pzywLoFbce5aIQX6U46EUGQDh6SM09s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764025421; c=relaxed/simple;
	bh=DUGAM3CoDzk0w+DFqaUnv7hfNl4L/IHV0xvdjgnOS20=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oOTLLiXbC6CReHBN6jYr9LBz0rhE/VD4e66gAoxk+6+9Tv/HCzvR/8y+jWn94JpkwxLPO2azY/6UL3pAJq4GbOaL9xZbLTJJo3O+o/Arsn8WY965BXinMAGgZQpv2EVTNGaUFP8fdQ0Ex/Hc5k6dmhyM/U49uH49n5+uygsHycw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXT3fc5X; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764025420; x=1795561420;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DUGAM3CoDzk0w+DFqaUnv7hfNl4L/IHV0xvdjgnOS20=;
  b=aXT3fc5Xba/swzTKUHkouTTwd8y1troyoELbRmmgpI26krE9U5bidmVf
   ylSkwP1lhJgM8045NcsRR8M8zoCtjCnfUeNeVQsA/KT4oJmYvETSPrwAR
   wZl2Imwv15eKXoExSR6WvX7DTxfb4/YQtU5nyb2aHIpTHzGuU9UMmYa98
   LN0R3/LUb1zJQ2H5QLVk3GakuVpry7OAtSpMhxB7XB2NF2ryY+bLJMUGj
   52S+PGi9U91/dRGZdzZ8380cEGY2JioNRejzLr+PdqOv7MMvGpGVnN0Wj
   I/LuXjQ1MO0DSyOfjrcJLG5xizEfscMKgx7Jz3NCfyxPP830hxjtkaBfL
   A==;
X-CSE-ConnectionGUID: 7kt3/eqEQRWbS5IoIMIp8Q==
X-CSE-MsgGUID: qGPIhYIEQwOJnLl5OurWgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65922737"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="65922737"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 15:03:39 -0800
X-CSE-ConnectionGUID: LlCUTUzeSTyrCd4nvhhyMA==
X-CSE-MsgGUID: u0+Np76vSiG5iZBY2Gj7JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="229736935"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 15:03:38 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 15:03:37 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 15:03:37 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 24 Nov 2025 15:03:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vo6ABMMT7f1QSAbU4q9KQCThaD3MKDzb5/2U4vc6iBpAEnH5UQ+JZlaCUmcLklyuG/ZaZWY1SKSSfGcvFSHq+dT7Jvx85mY8LjJ8Zs7Hi4aKoszPrwW1Jdt7fbPFXRdWWNSTD2/N6yXglemqkH+0Fkd3iDcTuz1ntWWdjqGVa2fS+MjThPevIAHJi9tOcaHEthCiZ8BBlAFo3gI70uOq1KsRaAN3OZDw6afhHV5dWzYzHN7eN9YM4UvALCzhDEQukzXerZYGIQVhIjUapDzDf0Opsz7pFiF+gqGrb+0cioPsBJ0W/6SEdVSsWvX9HOuh5sjxRRL16/X0ivAeHNkjbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pICF8dNvVC/l0TH53XFrjZMJbYDm01cRjOUZKTSWKkc=;
 b=sYlFhkaX5LV5ApXEKYufHvxwWCsCzp19gLPIlWI1lKUYKgTb7YAYYyXGY18dgR7xCXaq7IX36sodZ3SCE28KIQ76yV9JFPvAOMnSYF41ZokMEIDMFfAbjB9jeX9FjSAJPcgpAkQUWb6POknOM49tojXVvLkTNqfdS+62X9AzAiaP0X2ENjk8rlCx8ZfqLpkLwD1aHJ/uvlOa6B1EIW5GYCJ/4bhvokO/KVN0PEqvabAxyrri4hJ4VKXtJkx/fR2qGg1rnjuSNnSzxylubdQGtRsiXLeB3WhxPogi3FmLrTiHByxb4HKAMIjtK5p87rSqdkfTnzapW0G7R/TFi1KL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB5994.namprd11.prod.outlook.com (2603:10b6:8:5d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Mon, 24 Nov 2025 23:03:34 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9343.011; Mon, 24 Nov 2025
 23:03:32 +0000
Date: Tue, 25 Nov 2025 00:03:26 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
CC: <netdev@vger.kernel.org>, <csmate@nop.hu>, <kerneljasonxing@gmail.com>,
	<bpf@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<sdf@fomichev.me>, <hawk@kernel.org>, <daniel@iogearbox.net>,
	<ast@kernel.org>, <john.fastabend@gmail.com>, <magnus.karlsson@intel.com>
Subject: Re: [PATCH net v6] xsk: avoid data corruption on cq descriptor number
Message-ID: <aSTkPgG5CPWRKUFS@boxer>
References: <20251124171409.3845-1-fmancera@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251124171409.3845-1-fmancera@suse.de>
X-ClientProxiedBy: WA2P291CA0037.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: 8063d907-8096-4865-2593-08de2badb08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zBN5AnAAU5veCo7iSXtLLflDQcXmyS+JudlbJTBOoCgg0caIvNGQMNHdFFHR?=
 =?us-ascii?Q?fIxk241vB/sUFte8O4SQJU7rO2rN2IIvC8Ht1AtJE601HBAAxUY+AeZKH3/d?=
 =?us-ascii?Q?BmKiJ7SNF5eCtlDtwLspgq1ZyYCbV5enJvpPVIWcz0HgY6NHkJdJj5rGgBa/?=
 =?us-ascii?Q?KjkRR4DSbQnvFjowChpprX9C5RJZCtHJ4dogBXtsxOdFO6KSKZMbx4eE8PT8?=
 =?us-ascii?Q?Ti/zh0FamOw9drpTXu6Il7iLRRWJeWa9uxInRAjEPnec6JA84ltsCFc1a7wh?=
 =?us-ascii?Q?IiVAMa/uZxKHKRcgzn/UCXZT8LYooeTg+uQIujlsUgHv7NoT3QerTrrf62Rj?=
 =?us-ascii?Q?QTnH++wkejOKbgbf55wVOJ1A+Lna717+gsNyF/NF82wg7CD5IxkntFNRuHvB?=
 =?us-ascii?Q?y6+d+Xt+6vaxn23QTydhTYiQt/tmgXmGbxSvxPGNXWzX4BJWDCUy4hH/+OL0?=
 =?us-ascii?Q?hAbBrcx2VG3TGjT1pkqUu8jxCgWeMkCRrf0PZAFbMWttfD1ZmFcZzK2O6tuz?=
 =?us-ascii?Q?lYQa8BFe/oO+27owdq4rJIeh79Z0a75RuRQ/VPafpfrRmjruJ/B/YVw8DUlK?=
 =?us-ascii?Q?M7d8bhTjgoUzJpbaxf+zGU8v/M/ZLWQW5D/LwPyvnTTrDRVhsw+CPg/00kYK?=
 =?us-ascii?Q?UBViwdpOZ4DcYmRStFobP9KL/4aFHumywBo3NAevie+x+zv96xptH/N44Hqt?=
 =?us-ascii?Q?nov6s6sWUvGhVbEuMVX1zQke1e+OpmLnhfm3P5SuDy4Txhawdt5qg15V/C3X?=
 =?us-ascii?Q?XV24wwWmvQwXu+CU5JhGAETMrjIi76m+A8ET1i6M0F16rj0rVkc1FyJGVTXC?=
 =?us-ascii?Q?Xdf+I5njVnpRTpZdadd80dVVruC/HpHIDi9X6DoaUI/Xm7iWAhnEMEuxoHZL?=
 =?us-ascii?Q?uzKY/AwqWnzVOXgiuUaEaVK58lcWw0Ed14DAlnbBq5qqlZyyGbsnyDCCJIit?=
 =?us-ascii?Q?zmYtox+LtVHVGvIDLC1cabWUcals/jzBlJs8vBL3vyUuQTqnGrJMmptKkjqI?=
 =?us-ascii?Q?eGSkmxk5cDY8Izgvo0/9FX9IAYa8+4ubuOK5dGhnOO7O48qIFZ+kpLX9fkvv?=
 =?us-ascii?Q?pA7xcx/pBkXKEf7jg0v9zgsGk9C65+bXl31jMYst0D6s2XB+/utrixYSKgPE?=
 =?us-ascii?Q?S6QfiexVHiB7tcIQ+LTsaKES4webDZ384G70UH6SGVAVqe5N4J+fyM4z66pV?=
 =?us-ascii?Q?5EoJTzuhZ8qY9U36NH4BS9jLEJdCYhugaHc4gEUfYnE1env8ueu0tHYdEub9?=
 =?us-ascii?Q?9+zPqI8WvbEjklLy6JJO3E9+dIoQWVtZ8H0KlCf81IZgAV53DRW6Lzhh7CX6?=
 =?us-ascii?Q?kJseqSOmO63xdNzyHvGljSGDvpOOhyCwyZjThpuYfrAm2cDCsS6I9TtrZVfD?=
 =?us-ascii?Q?3slPGjptNP6MMTk4T6WtchJvDMc4JWSQzugR+EcU7/ii2uMP8SD/elcJ/2yy?=
 =?us-ascii?Q?tjqkP8itP7oL5L8PW6ri9S+vQUdFy6fl9abt+OF5emNzklskPqwbxQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aEWNeHoNicvNNJp/F762M4zlKMb/fcQNr/TTdgkPdqXP91FR4yuaqABNDDv0?=
 =?us-ascii?Q?SFoOc+3pV0r6xetH106o/H+z2VWDRoLa0IOOAl6G33Fue/er4RRScKmRqeLd?=
 =?us-ascii?Q?G0um78f5IkDjaZq9Uh9QuSQHVW+J83Dk6jaePGRlXVupZ8qdxjvwHW/vVdKj?=
 =?us-ascii?Q?RcVjIO0eSo+N21T0uOAZXO9Ddsa+Hncf0Tn3ZKOMhzbf1iUM/Dimn43WPDd8?=
 =?us-ascii?Q?Yyx9hg4PkebcRhqhV/0lKVZ8Un1FHUmbpwnC8IHK3uZzb3nQeQWBSihbCRiZ?=
 =?us-ascii?Q?xjb7NY+HtAjUuqTbkZ3pG5aVJbzk+C3DJwE7dw+w0M4LTOUpGWe1VIFme/+B?=
 =?us-ascii?Q?GjSeXPoY5afQhivooZshgLY8SFNH3Ve9jx+ELB08M9JkFlSBe7KWMwL0oQ66?=
 =?us-ascii?Q?w4q6hcn/3TlChPvL0TnLKxOgRx/hwxPMUsDGXJxFUEQ6b0A+JTjJZmh0eN49?=
 =?us-ascii?Q?TTtxR9NgGGMEk4Nf95aiSC34jisc5DmTtGcmgZoteJqyixD7jSwnob5My11X?=
 =?us-ascii?Q?VnzFCQZsXOOEHHZeBWEgNXnl+y/LrtsNNXEIiJA97YdwY/px5LZ9M8wycb2Q?=
 =?us-ascii?Q?korkzBDzI9GE4rb+DiiX6J1A435cywlMT1hQIlftBeMY3U6zZAFJTxkSKeXj?=
 =?us-ascii?Q?61c3Fm56DL5PC5pl82L8G0wh4fhmukUw17nnFehxIThhybYxqb+TtMzKWWDu?=
 =?us-ascii?Q?E0oMq+TStqyfKjoW7J8wmAeqt5+qvroUnPngLNlYu0Tw9LuqoNjh+5WDlaxY?=
 =?us-ascii?Q?qhiSsIwpYP9dQEECBWpdC8ZX2gvc/VeOGIB7xM0+KHTKwufPR9rJg34hfKda?=
 =?us-ascii?Q?2ExvXwWgxfe6Ssrp/yvoyDjG24G6678KOsUuebFXJL4d8cBEJFOg3borcrEJ?=
 =?us-ascii?Q?AlneoGMMBCKbSPSC1N5oy+jdPOSyToKv1utKnncJ268/ttbaeWpVagfA1fmK?=
 =?us-ascii?Q?eA4k3wLOPNwXgTdx2A0Fr0EwLrRyP6S+z6dz2HTFtljlQPekBiJp3A18kHuV?=
 =?us-ascii?Q?kUIV1uf+L5bcj4r3eziklxi9pXo2sgWyOxJSbr8ZtmBQfjIwcTTeF2snSowt?=
 =?us-ascii?Q?WOc+L4fNoPWy8byzrdUo0dV5oHrctbu7Ye8DQbfzW1ipGukVKs4sWNQ4NfuQ?=
 =?us-ascii?Q?8f7PxnV4kvOtL+N3CxXKbvt7QQJlExVuwkjbzGP9r3exSuXDesys+9pE6b88?=
 =?us-ascii?Q?CjoqAyrdHWQIdMekdAnbOqFl4Or7M4Nelm7MO4+gngF3nY+X1lEvY0Z7c6CE?=
 =?us-ascii?Q?9gkSiemjLQBjuySArgZZXxTThMiAz0zT+wUHftSmwFQjfZU4jeVG7J5Sr9/L?=
 =?us-ascii?Q?jyro5S8rYsqosCPWH4X/DRBa3xMS0A4oG+euYDWTSuY3c+Q9sraezBE7bTDw?=
 =?us-ascii?Q?rRc91jOTFXkQ70NtCwDxZAU1F+z4VlnTe6fVI27dXGbXVgl8Oa5AZvtzNQBE?=
 =?us-ascii?Q?m8Bf9OpEJDt4UmgcImyDrUp2yuXSJ4QlAC4q/+GiEFRflDIEXlPmOxPo5arA?=
 =?us-ascii?Q?tmX8mCJDo60TPlQkpcjyA04iDQM6xRS6o89kXNHvzgc1auy84ULmjtA0+l5j?=
 =?us-ascii?Q?Ulm1X1dFj9YyfE/8zgvbHUkamdbbZeIp3PuvxXcHVtps7sfDtA7a8aWbhXkH?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8063d907-8096-4865-2593-08de2badb08c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 23:03:32.6040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WN52NXrsJOpIaaXKlCU0Cwsn+JrBz1zqkvTGyxAlHIKkqQoQbIpN6kdfrvjg6D8tn/nccytU0xJl7DWMvh2X46bR3QXiQH4slAehb+cv4hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5994
X-OriginatorOrg: intel.com

On Mon, Nov 24, 2025 at 06:14:09PM +0100, Fernando Fernandez Mancera wrote:
> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), the descriptor number is stored in skb control block and
> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> pool's completion queue.
> 
> skb control block shouldn't be used for this purpose as after transmit
> xsk doesn't have control over it and other subsystems could use it. This
> leads to the following kernel panic due to a NULL pointer dereference.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>  RIP: 0010:xsk_destruct_skb+0xd0/0x180
>  [...]
>  Call Trace:
>   <IRQ>
>   ? napi_complete_done+0x7a/0x1a0
>   ip_rcv_core+0x1bb/0x340
>   ip_rcv+0x30/0x1f0
>   __netif_receive_skb_one_core+0x85/0xa0
>   process_backlog+0x87/0x130
>   __napi_poll+0x28/0x180
>   net_rx_action+0x339/0x420
>   handle_softirqs+0xdc/0x320
>   ? handle_edge_irq+0x90/0x1e0
>   do_softirq.part.0+0x3b/0x60
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x60/0x70
>   __dev_direct_xmit+0x14e/0x1f0
>   __xsk_generic_xmit+0x482/0xb70
>   ? __remove_hrtimer+0x41/0xa0
>   ? __xsk_generic_xmit+0x51/0xb70
>   ? _raw_spin_unlock_irqrestore+0xe/0x40
>   xsk_sendmsg+0xda/0x1c0
>   __sys_sendto+0x1ee/0x200
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0x84/0x2f0
>   ? __pfx_pollwake+0x10/0x10
>   ? __rseq_handle_notify_resume+0xad/0x4c0
>   ? restore_fpregs_from_fpstate+0x3c/0x90
>   ? switch_fpu_return+0x5b/0xe0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
>  [...]
>  Kernel panic - not syncing: Fatal exception in interrupt
>  Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Instead use the skb destructor_arg pointer along with pointer tagging.
> As pointers are always aligned to 8B, use the bottom bit to indicate
> whether this a single address or an allocated struct containing several
> addresses.
> 
> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
> v2: remove some leftovers on skb_build and simplify fragmented traffic
> logic
> 
> v3: drop skb extension approach, instead use pointer tagging in
> destructor_arg to know whether we have a single address or an allocated
> struct with multiple ones. Also, move from bpf to net as requested
> 
> v4: repost after rebasing
> 
> v5: fixed increase logic so -EOVERFLOW is handled correctly as
> suggested by Jason. Also dropped the acks/reviewed tags as code changed.
> 
> v6: added helper xsk_skb_destructor_set_addr() and remove unnecessary
> if statement checking if destructor is addr before increasing as it is
> already at the helper.
> ---
>  net/xdp/xsk.c | 143 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 88 insertions(+), 55 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7b0c68a70888..69bbcca8ac75 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -36,20 +36,13 @@
>  #define TX_BATCH_SIZE 32
>  #define MAX_PER_SOCKET_BUDGET 32
>  
> -struct xsk_addr_node {
> -	u64 addr;
> -	struct list_head addr_node;
> -};
> -
> -struct xsk_addr_head {
> +struct xsk_addrs {
>  	u32 num_descs;
> -	struct list_head addrs_list;
> +	u64 addrs[MAX_SKB_FRAGS + 1];
>  };
>  
>  static struct kmem_cache *xsk_tx_generic_cache;
>  
> -#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
> -
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>  {
>  	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> @@ -558,29 +551,68 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
>  	return ret;
>  }
>  
> +static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
> +{
> +	return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> +}
> +
> +static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> +{
> +	return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
> +}
> +
> +static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
> +{
> +	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> +}
> +
> +static void xsk_inc_num_desc(struct sk_buff *skb)
> +{
> +	struct xsk_addrs *xsk_addr;
> +
> +	if (!xsk_skb_destructor_is_addr(skb)) {
> +		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +		xsk_addr->num_descs++;
> +	}
> +}
> +
> +static u32 xsk_get_num_desc(struct sk_buff *skb)
> +{
> +	struct xsk_addrs *xsk_addr;
> +
> +	if (xsk_skb_destructor_is_addr(skb))
> +		return 1;
> +
> +	xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +
> +	return xsk_addr->num_descs;
> +}
> +
>  static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>  				      struct sk_buff *skb)
>  {
> -	struct xsk_addr_node *pos, *tmp;
> +	u32 num_descs = xsk_get_num_desc(skb);
> +	struct xsk_addrs *xsk_addr;
>  	u32 descs_processed = 0;
>  	unsigned long flags;
> -	u32 idx;
> +	u32 idx, i;
>  
>  	spin_lock_irqsave(&pool->cq_lock, flags);
>  	idx = xskq_get_prod(pool->cq);
>  
> -	xskq_prod_write_addr(pool->cq, idx,
> -			     (u64)(uintptr_t)skb_shinfo(skb)->destructor_arg);
> -	descs_processed++;
> +	if (unlikely(num_descs > 1)) {
> +		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>  
> -	if (unlikely(XSKCB(skb)->num_descs > 1)) {
> -		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> +		for (i = 0; i < num_descs; i++) {
>  			xskq_prod_write_addr(pool->cq, idx + descs_processed,
> -					     pos->addr);
> +					     xsk_addr->addrs[i]);
>  			descs_processed++;
> -			list_del(&pos->addr_node);
> -			kmem_cache_free(xsk_tx_generic_cache, pos);
>  		}
> +		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
> +	} else {
> +		xskq_prod_write_addr(pool->cq, idx,
> +				     xsk_skb_destructor_get_addr(skb));
> +		descs_processed++;
>  	}
>  	xskq_prod_submit_n(pool->cq, descs_processed);
>  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> @@ -595,16 +627,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
>  	spin_unlock_irqrestore(&pool->cq_lock, flags);
>  }
>  
> -static void xsk_inc_num_desc(struct sk_buff *skb)
> -{
> -	XSKCB(skb)->num_descs++;
> -}
> -
> -static u32 xsk_get_num_desc(struct sk_buff *skb)
> -{
> -	return XSKCB(skb)->num_descs;
> -}
> -
>  static void xsk_destruct_skb(struct sk_buff *skb)
>  {
>  	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
> @@ -621,27 +643,22 @@ static void xsk_destruct_skb(struct sk_buff *skb)
>  static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
>  			      u64 addr)
>  {
> -	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> -	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
>  	skb->dev = xs->dev;
>  	skb->priority = READ_ONCE(xs->sk.sk_priority);
>  	skb->mark = READ_ONCE(xs->sk.sk_mark);
> -	XSKCB(skb)->num_descs = 0;
>  	skb->destructor = xsk_destruct_skb;
> -	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
> +	xsk_skb_destructor_set_addr(skb, addr);
>  }
>  
>  static void xsk_consume_skb(struct sk_buff *skb)
>  {
>  	struct xdp_sock *xs = xdp_sk(skb->sk);
>  	u32 num_descs = xsk_get_num_desc(skb);
> -	struct xsk_addr_node *pos, *tmp;
> +	struct xsk_addrs *xsk_addr;
>  
>  	if (unlikely(num_descs > 1)) {
> -		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> -			list_del(&pos->addr_node);
> -			kmem_cache_free(xsk_tx_generic_cache, pos);
> -		}
> +		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
>  	}
>  
>  	skb->destructor = sock_wfree;
> @@ -701,7 +718,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  {
>  	struct xsk_buff_pool *pool = xs->pool;
>  	u32 hr, len, ts, offset, copy, copied;
> -	struct xsk_addr_node *xsk_addr;
>  	struct sk_buff *skb = xs->skb;
>  	struct page *page;
>  	void *buffer;
> @@ -727,16 +743,26 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  				return ERR_PTR(err);
>  		}
>  	} else {
> -		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> -		if (!xsk_addr)
> -			return ERR_PTR(-ENOMEM);
> +		struct xsk_addrs *xsk_addr;
> +
> +		if (xsk_skb_destructor_is_addr(skb)) {
> +			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
> +						     GFP_KERNEL);
> +			if (!xsk_addr)
> +				return ERR_PTR(-ENOMEM);
> +
> +			xsk_addr->num_descs = 1;
> +			xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
> +			skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
> +		} else {
> +			xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +		}
>  
>  		/* in case of -EOVERFLOW that could happen below,
>  		 * xsk_consume_skb() will release this node as whole skb
>  		 * would be dropped, which implies freeing all list elements
>  		 */
> -		xsk_addr->addr = desc->addr;
> -		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> +		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
>  	}
>  
>  	len = desc->len;
> @@ -813,10 +839,25 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			}
>  		} else {
>  			int nr_frags = skb_shinfo(skb)->nr_frags;
> -			struct xsk_addr_node *xsk_addr;
> +			struct xsk_addrs *xsk_addr;
>  			struct page *page;
>  			u8 *vaddr;
>  
> +			if (xsk_skb_destructor_is_addr(skb)) {
> +				xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
> +							     GFP_KERNEL);
> +				if (!xsk_addr) {
> +					err = -ENOMEM;
> +					goto free_err;
> +				}
> +
> +				xsk_addr->num_descs = 1;
> +				xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
> +				skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
> +			} else {
> +				xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +			}
> +
>  			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
>  				err = -EOVERFLOW;
>  				goto free_err;
> @@ -828,13 +869,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  				goto free_err;
>  			}
>  
> -			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> -			if (!xsk_addr) {
> -				__free_page(page);
> -				err = -ENOMEM;
> -				goto free_err;
> -			}
> -
>  			vaddr = kmap_local_page(page);
>  			memcpy(vaddr, buffer, len);
>  			kunmap_local(vaddr);
> @@ -842,8 +876,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
>  			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
>  
> -			xsk_addr->addr = desc->addr;
> -			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> +			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
>  		}
>  	}
>  
> @@ -1904,7 +1937,7 @@ static int __init xsk_init(void)
>  		goto out_pernet;
>  
>  	xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
> -						 sizeof(struct xsk_addr_node),
> +						 sizeof(struct xsk_addrs),
>  						 0, SLAB_HWCACHE_ALIGN, NULL);
>  	if (!xsk_tx_generic_cache) {
>  		err = -ENOMEM;
> -- 
> 2.51.1
> 

