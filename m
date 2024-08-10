Return-Path: <bpf+bounces-36836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811F194DD29
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 15:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2031F21A88
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 13:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079AA15A85F;
	Sat, 10 Aug 2024 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7so8Ddb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6DE3A8D0;
	Sat, 10 Aug 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723298129; cv=fail; b=AalTRsLBSQGD/Lco7c9KwLHczvF3mPDrTSQ984m+wBjhruj/MMfaF0MdY3ble6tMiUR9BnyuPlaLfp+DVED66xi9WLww6/ewA+j0ROZvDTix9Icd4MJa1zYmeH2eAQOPfmlsTO1fs66bctQX1UK8MihY8kTA5hsG9IU1+3SkC2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723298129; c=relaxed/simple;
	bh=Ow+W7aU2T6pAPgpP5hHHwNLllo49tbor2VQGYjkuzGU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FD+yIO5t3HaxAuDGNT2XF07L1q6EfoDpagIcxeEkGqzYy4psXI5xUgI1fj3DfUsiNScdDkp7/+88tWWVeq63fZwZTZX1rUvKPJmIQbWJ8Z4b4bOhpxYmvvQDQWHUC5QuAreH+eBI6UmPbNUjPWswhqYzUDnDHo3Qu8I6IkC8pbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7so8Ddb; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723298127; x=1754834127;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ow+W7aU2T6pAPgpP5hHHwNLllo49tbor2VQGYjkuzGU=;
  b=j7so8DdbkhNG7Cd3kkHSutESF+zcuM+W5HARO9P8h3nGc9AuoQy6PT7H
   S4iLqbYJQIsB2rbE258ibI/oCHGksxLZN/GsAUyqQMxpWsz1VCV6wmSJu
   UULJzqrAWYtKBrJB+jCCHUTD+VO36hcGuIE2xGZbyd+6lMGhGb/R/qN2h
   9odEzvmJfuf3zKy347TOec+AFd77qDGPddwq7Ocon+teXhmwC0DVjKbaS
   u3FWTvET4Gerom1eucw+5i89z+m26yDqcsCq6bU5qC5t840RwZEW1GHLA
   4yVeRKJfYlhpbRRlza10I+yxT2XNjQom4ArRHHuJAnx/3WloKCj/i5uTf
   Q==;
X-CSE-ConnectionGUID: KqCoHGafS5O6TjMoWrn4xA==
X-CSE-MsgGUID: ceedX9LRRa6+XMX1lqE8lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="32609811"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="32609811"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 06:55:27 -0700
X-CSE-ConnectionGUID: i7x9JW0MTriLYnnNlmQmnw==
X-CSE-MsgGUID: ZpuewP9jRomn8UEBK89Vsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="57496529"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Aug 2024 06:55:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 10 Aug 2024 06:55:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 10 Aug 2024 06:55:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 10 Aug 2024 06:55:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWrXzUN5cX7G1xhj6YEgHW2P8vlsXrlqZV/XmoTIFaaGe7CUjntIZSolvtDUzfRyUzppdMW0sg8+SatOHoiyifvuTCLTPwwQVQB6cXXswX/rd9Zyj5fhxWWzksKvbcQ/VuCgw2frGXsq9GgN+Fu29QWKAtNxHo97GBWhiyS8zraZHG14B1pU7IX9rWtoYceh+RgkUEuvW8lL69UcYNy6PP82HuXdLJ7x/L3D3iKwl3+GiDhZZZK5WHdzwxy5JHoJ730y9E1o1s2sv8VmzQ0BG61YUrNwqzX2M+LuATBfKLGrVbgpxj42MH9hQ2pklfnLfNuhOK5couMAv6SYNQstWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmtfDNLg0rzatQfP8MjRrH5HOHM1XNwKY+3hm95z5PI=;
 b=EXpcFqCh3NAYHhjrOXSyC6PrGKtufSjz6WjzxWOyGoAYxltGkw3SuZrPK3cQCHosTFfhPGPCtbnQTR56jzKGHSNlegzSwMUWQ1E8rlbkmG4fYJ+pzQu7ifeEsbAF42tTR+k2sHkbmrrFCAJv9YdcGzLh5dEuLNUm7sNzz8OYnO+LzBs9LzQLRu7wsQWgAgmvDDKkPrH30Lc32VPTvef+Eo/XhjdMH03KAVQwt7Igwf9J0oD2BID+8wDaRpNFS5r7sPYjGCp2LlXkmYyD8MjpFjt1MTcDu3zjnibP48hwmmieity8qrb2e2NJt/2vp7xbVkzat/ZXNLz70kBCLo8fbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB7994.namprd11.prod.outlook.com (2603:10b6:806:2e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Sat, 10 Aug
 2024 13:55:22 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7828.023; Sat, 10 Aug 2024
 13:55:22 +0000
Date: Sat, 10 Aug 2024 15:55:10 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>, <magnus.karlsson@intel.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<bpf@vger.kernel.org>, <kurt@linutronix.de>,
	<sriram.yagnaraman@ericsson.com>, <richardcochran@gmail.com>,
	<benjamin.steinke@woks-audio.com>, <bigeasy@linutronix.de>, "Chandan Kumar
 Rout" <chandanx.rout@intel.com>
Subject: Re: [PATCH net-next 3/4] igb: add AF_XDP zero-copy Rx support
Message-ID: <ZrdxPgcqLdzCXCAS@boxer>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-4-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240808183556.386397-4-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ffb277-f74a-4bed-57ef-08dcb94413cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YlEweFqABL8d8ynU9hlAITl2bjm8wpkcSOxvo10TytNNyJKh9VJ48UaYevQu?=
 =?us-ascii?Q?ctmoQ/VTiBRt2mEg1LLkje1Q9lUqclFdBJOiB3VFXV/31y/p0ovef/nFosZA?=
 =?us-ascii?Q?c+MG74s0sr7YjM90kZ3+xytxRf2eEgdR5mzzBqjR3QFMn5uIZ7A5TOhCshcD?=
 =?us-ascii?Q?39lTHIMX0dfZCAiClX+XJlyWm1KqZByudfX+HGTFvzTgA1o/+FKSlr9YaP3A?=
 =?us-ascii?Q?2oTFITL8nOZJckPA9cwL1BKB/JQn3i88amVVt7nuhvu/fctSuZccZKes+l7D?=
 =?us-ascii?Q?0iE4Oc2nRzEp1ieCGeo+hKxJT2vzzBqYuY5enMAz4l9wO2fBASJHf01LfNSZ?=
 =?us-ascii?Q?wFSHpzXNjdirA7xrkVOybp7+In7OKvGMVz7OznveOlyIr7LCAR+1z6MDo7KM?=
 =?us-ascii?Q?Q5I/t0kowyjAipjTLu29J5DKTbO4F2ZNWHpxaeI4W0IGllAwsTQpizhmrdrQ?=
 =?us-ascii?Q?6M4NX9RbO8Trl/x2nwZSNcOgFe+keX5I8eNf66rGbFZrjsTeNort2jbeX3RP?=
 =?us-ascii?Q?dtfDx/Dpju7ym+dEH1LOMmCaO79PZl1GxH7iEy/DjWmCFM5l3ilydOJzhB4p?=
 =?us-ascii?Q?R8wiQx4wmtEEemWqWwHGT4Cxmt8qwWDYJw1IYxtbR1FQqdkvk3w9cF1YF1xL?=
 =?us-ascii?Q?S8BqJjaeEBB8inKGq14hEF/By6B4sqUmcpRrI/89+iqZ4JCMPrjvB7iI+uCw?=
 =?us-ascii?Q?AWo7VYOu0pJ0i4iSJqO2/5ataTIXLCO1mlF74CYoggd5oGts1lq0rsv1TcFA?=
 =?us-ascii?Q?O/DlcB1pGTfTC+wSqE2PYGmDfhFVEArgXJYvimbJHJ1f3XDRGDxc7VOb7XT/?=
 =?us-ascii?Q?5YtN1fg36DjJKEPh9DmzLzSNvYO9AXc6LkBuX+DeMvevBSYEeighm4js8aIo?=
 =?us-ascii?Q?0+n/H4pXhNekqEjqUMa5KSF7M0bdMtxWp1Aja/zGNjDJwiuQxH5jy+A5KYYL?=
 =?us-ascii?Q?Gl/MQZ906ZFCGTyXAl9pSE0FzHmJR2mesoiKP+6tI9fexcX6M1XYoGbvHM30?=
 =?us-ascii?Q?3dBbdfR+asYOPEyzoYQIi0tfjW56X0UtzHmJ5UnUIFdPviELQLhMRzve2pgC?=
 =?us-ascii?Q?TD6J4Lg9QDRTZtzl3RPLqRroO5nLwqSxQKLJozHgOHd8JnIJ2WbzRtXuQ6TW?=
 =?us-ascii?Q?5kc9H7nBArhKkCxmVARRAWaTe3eNf7VassY+WMLhHlwhNC0pXPqjrFhjBiPy?=
 =?us-ascii?Q?ns++YGpKrw6rPLwR7cPBkHN8IutCywkozvVnRap/qlYGx6qjdAvVyktVF5k3?=
 =?us-ascii?Q?fNJg1wwvjUT2c9d5uumC5JjQOXbqzo7xCpNcrEJIZvgXtOca8DTALcXRGlG+?=
 =?us-ascii?Q?ReyA+GIAFaVyh4S15RQiP1HB4pMOEQVQWA6tzMYug0anZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1HLxmxfZTGqbfbSXQYJKP0RpWTOjZkq3eXJajV4kG0hfTrfvOmfpYyXprDUg?=
 =?us-ascii?Q?Q07rqrtoG0QDKdWFUehaO14j6ii6N76px2i5tr/sDPvxm+zixJvUDJ1jllVn?=
 =?us-ascii?Q?zyHC3xNshGLyhgOOIEWy4Zq0jhEck3Qwtd/9ynBAlUR2bYtK1zh0FHw0aEI7?=
 =?us-ascii?Q?3uqoxJP04YG1fuBg0oCoQgm+9uX8+77AdTbD/gG11Zpaw3Bl8uTqps9cnVgW?=
 =?us-ascii?Q?7aaoRy5ik4EyKGizSeA1NLTzGyvu1vYOK5C4V5peMydmrJZSwV3q96DIhD3D?=
 =?us-ascii?Q?gCDP3LfKTRamLi7aCZEGcAxF9ZU06snAqF060IXaPYAwgJdWqI0/3AjiYIvy?=
 =?us-ascii?Q?cWYqCqCCUVu2nRjeoMj2nSZQWV6PDPg0Wf+AUw+NhXg3F/84wNxtYT2U1Leb?=
 =?us-ascii?Q?ee/RwyMSMqVhPkm6DS1pUyvDKDnB0obsyIsTDuEe1GsOigZ4aJ0dhR2iJ1KP?=
 =?us-ascii?Q?nIwHHssCIcsOr3dZS4JkmyeRtM6UYWXPpVXmxtANeZcdAAYYsCgLBMZp4oY/?=
 =?us-ascii?Q?QB+lekRcDELujUusGALlUfAbblQnVNojw87TxgHY5rfUGbx+BdFNSjW/9dw8?=
 =?us-ascii?Q?RefwpR4bD5ShofoIyIOpcU8xzLiNle0m+bVtNDGaIZ1R6c53eQi+Ns/Y5n8S?=
 =?us-ascii?Q?GaYE5JY4nFLYKinIB5gDG1gwBDCucGf2LMs8zbveXoQO9F3ZySMfe1p+G7Wa?=
 =?us-ascii?Q?pdsloUqxQ9HvGEoFd0ci6iAnND1k2ukNuKIDdXMsNj1+UkwhWyru9lO9F2QQ?=
 =?us-ascii?Q?G7QYq0dm85GwXRVQHlI7oZ7F3xSlX35UWxw4Dg2AMwKG59XrAy3FEqc8kEfN?=
 =?us-ascii?Q?hLb8rcqIQR6uRpf8Bm0ldqZxI0BClmd12UTaNMmRnGNIT9Z+FfORkx8GCHAH?=
 =?us-ascii?Q?XGr3mL+oQlZvyPNu5k5GYUT+B0j5WppEWUJczzTMkPfgvw9j63L1jp3s5ExX?=
 =?us-ascii?Q?yhepW0ZADRpxkR6/J12ZHfj85VgeoCgA7Cjr0tv5LhOXVJROy2cerze0o8gG?=
 =?us-ascii?Q?X4Taj6z/edgmdjSs1d+wiVD6oYavAQJ4dTVA3dRsoISoJTzHRlrdmvaI4l3F?=
 =?us-ascii?Q?3zHSEVZ1jt0idu96IV+5DjWPKSeOvzUgpzoAn/v9GBBKEWIDCAUz3BiUxa4x?=
 =?us-ascii?Q?1pcn0zRYj1RDZSnXOLqaDhZ5Nce7lVOu2BoJJRm8DedyJmddEJ4gf7NF65CR?=
 =?us-ascii?Q?f/Jt39Y4UgVfpOfuDkCxYf58M7sAd/CjfZB2k54QUnRcUScTAeW921Ej0Obm?=
 =?us-ascii?Q?lIXuHRfargDjNGkjWyHopxVXW0FW2ov5sVrz8sfgJhZ7RRbApTIw66oV/+il?=
 =?us-ascii?Q?AzV9RlNkS6K7pI24lkvFds8QENN3fpffTHiy/JNR9mbeo3w+Q0fSpnO2N9fy?=
 =?us-ascii?Q?NutwVXdaT3wAFD123Kw1bCnxj6hXbQmSCdLjWzoXuEeDh6luptv/h7nvkISi?=
 =?us-ascii?Q?IqwY3g+dnD91Jsl/O1+HiEVX5igae1WO4LSqeQEwsnjjzKzgTtO6SRo283gI?=
 =?us-ascii?Q?0wIua+DIhVy2QjJaAlkOjRsUepsRkY8rJWXizlOwLa2o8r1Q2kXJuDwiR/97?=
 =?us-ascii?Q?XPz4U8wYS6P62p6uoiHNB3GtAKpOH7CIK/fTtzMZrneuAHyAvnaOTWMYbuUg?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ffb277-f74a-4bed-57ef-08dcb94413cc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 13:55:22.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjQXdvtz5TmpiVxHSJSjNks4geVTUMYxnu+ZYeWYPL34xItp2yKHkTDMdjvaKUdNWEhmtZ8iBmq7hNTGryllrqgGB3xKTMXYprMJug+4c6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7994
X-OriginatorOrg: intel.com

On Thu, Aug 08, 2024 at 11:35:53AM -0700, Tony Nguyen wrote:
> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> 
> Add support for AF_XDP zero-copy receive path.
> 
> When AF_XDP zero-copy is enabled, the rx buffers are allocated from the
> xsk buff pool using igb_alloc_rx_buffers_zc.
> 
> Use xsk_pool_get_rx_frame_size to set SRRCTL rx buf size when zero-copy
> is enabled.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> [Kurt: Port to v6.10 and provide napi_id for xdp_rxq_info_reg()]
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |   4 +
>  drivers/net/ethernet/intel/igb/igb_main.c |  95 ++++++--
>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 261 +++++++++++++++++++++-
>  3 files changed, 337 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 053130c01480..4983a6ec718e 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -87,6 +87,7 @@ struct igb_adapter;
>  #define IGB_XDP_CONSUMED	BIT(0)
>  #define IGB_XDP_TX		BIT(1)
>  #define IGB_XDP_REDIR		BIT(2)
> +#define IGB_XDP_EXIT		BIT(3)
>  
>  struct vf_data_storage {
>  	unsigned char vf_mac_addresses[ETH_ALEN];
> @@ -832,6 +833,9 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
>  int igb_xsk_pool_setup(struct igb_adapter *adapter,
>  		       struct xsk_buff_pool *pool,
>  		       u16 qid);
> +bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count);
> +void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
> +int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector, const int budget);
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
>  
>  #endif /* _IGB_H_ */
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index b6f23bbeff71..0b779b2ca9ea 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -472,12 +472,17 @@ static void igb_dump(struct igb_adapter *adapter)
>  
>  		for (i = 0; i < rx_ring->count; i++) {
>  			const char *next_desc;
> -			struct igb_rx_buffer *buffer_info;
> -			buffer_info = &rx_ring->rx_buffer_info[i];
> +			dma_addr_t dma = (dma_addr_t)0;
> +			struct igb_rx_buffer *buffer_info = NULL;
>  			rx_desc = IGB_RX_DESC(rx_ring, i);
>  			u0 = (struct my_u0 *)rx_desc;
>  			staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
>  
> +			if (!rx_ring->xsk_pool) {
> +				buffer_info = &rx_ring->rx_buffer_info[i];
> +				dma = buffer_info->dma;
> +			}
> +
>  			if (i == rx_ring->next_to_use)
>  				next_desc = " NTU";
>  			else if (i == rx_ring->next_to_clean)
> @@ -497,11 +502,11 @@ static void igb_dump(struct igb_adapter *adapter)
>  					"R  ", i,
>  					le64_to_cpu(u0->a),
>  					le64_to_cpu(u0->b),
> -					(u64)buffer_info->dma,
> +					(u64)dma,
>  					next_desc);
>  
>  				if (netif_msg_pktdata(adapter) &&
> -				    buffer_info->dma && buffer_info->page) {
> +				    buffer_info && dma && buffer_info->page) {
>  					print_hex_dump(KERN_INFO, "",
>  					  DUMP_PREFIX_ADDRESS,
>  					  16, 1,
> @@ -1983,7 +1988,10 @@ static void igb_configure(struct igb_adapter *adapter)
>  	 */
>  	for (i = 0; i < adapter->num_rx_queues; i++) {
>  		struct igb_ring *ring = adapter->rx_ring[i];
> -		igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
> +		if (ring->xsk_pool)
> +			igb_alloc_rx_buffers_zc(ring, igb_desc_unused(ring));
> +		else
> +			igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
>  	}
>  }
>  
> @@ -3335,7 +3343,8 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	netdev->priv_flags |= IFF_SUPP_NOFCS;
>  
>  	netdev->priv_flags |= IFF_UNICAST_FLT;
> -	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
> +	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> +			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
>  
>  	/* MTU range: 68 - 9216 */
>  	netdev->min_mtu = ETH_MIN_MTU;
> @@ -4423,7 +4432,8 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
>  	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
>  		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
>  	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
> -			       rx_ring->queue_index, 0);
> +			       rx_ring->queue_index,
> +			       rx_ring->q_vector->napi.napi_id);
>  	if (res < 0) {
>  		dev_err(dev, "Failed to register xdp_rxq index %u\n",
>  			rx_ring->queue_index);
> @@ -4719,12 +4729,17 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
>  	struct e1000_hw *hw = &adapter->hw;
>  	int reg_idx = ring->reg_idx;
>  	u32 srrctl = 0;
> +	u32 buf_size;
>  
> -	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
> -	if (ring_uses_large_buffer(ring))
> -		srrctl |= IGB_RXBUFFER_3072 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
> +	if (ring->xsk_pool)
> +		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
> +	else if (ring_uses_large_buffer(ring))
> +		buf_size = IGB_RXBUFFER_3072;
>  	else
> -		srrctl |= IGB_RXBUFFER_2048 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
> +		buf_size = IGB_RXBUFFER_2048;
> +
> +	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
> +	srrctl |= buf_size >> E1000_SRRCTL_BSIZEPKT_SHIFT;
>  	srrctl |= E1000_SRRCTL_DESCTYPE_ADV_ONEBUF;
>  	if (hw->mac.type >= e1000_82580)
>  		srrctl |= E1000_SRRCTL_TIMESTAMP;
> @@ -4756,9 +4771,17 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
>  	u32 rxdctl = 0;
>  
>  	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
> -	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> -					   MEM_TYPE_PAGE_SHARED, NULL));
>  	ring->xsk_pool = igb_xsk_pool(adapter, ring);
> +	if (ring->xsk_pool) {
> +		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> +						   MEM_TYPE_XSK_BUFF_POOL,
> +						   NULL));
> +		xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
> +	} else {
> +		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> +						   MEM_TYPE_PAGE_SHARED,
> +						   NULL));
> +	}
>  
>  	/* disable the queue */
>  	wr32(E1000_RXDCTL(reg_idx), 0);
> @@ -4785,9 +4808,12 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
>  	rxdctl |= IGB_RX_HTHRESH << 8;
>  	rxdctl |= IGB_RX_WTHRESH << 16;
>  
> -	/* initialize rx_buffer_info */
> -	memset(ring->rx_buffer_info, 0,
> -	       sizeof(struct igb_rx_buffer) * ring->count);
> +	if (ring->xsk_pool)
> +		memset(ring->rx_buffer_info_zc, 0,
> +		       sizeof(*ring->rx_buffer_info_zc) * ring->count);
> +	else
> +		memset(ring->rx_buffer_info, 0,
> +		       sizeof(*ring->rx_buffer_info) * ring->count);

ah okay. comment from previous patch is addressed here, thanks.

>  
>  	/* initialize Rx descriptor 0 */
>  	rx_desc = IGB_RX_DESC(ring, 0);
> @@ -4974,8 +5000,13 @@ void igb_free_rx_resources(struct igb_ring *rx_ring)
>  
>  	rx_ring->xdp_prog = NULL;
>  	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
> -	vfree(rx_ring->rx_buffer_info);
> -	rx_ring->rx_buffer_info = NULL;
> +	if (rx_ring->xsk_pool) {
> +		vfree(rx_ring->rx_buffer_info_zc);
> +		rx_ring->rx_buffer_info_zc = NULL;
> +	} else {
> +		vfree(rx_ring->rx_buffer_info);
> +		rx_ring->rx_buffer_info = NULL;
> +	}
>  
>  	/* if not set, then don't free */
>  	if (!rx_ring->desc)
> @@ -5013,6 +5044,11 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
>  	dev_kfree_skb(rx_ring->skb);
>  	rx_ring->skb = NULL;
>  
> +	if (rx_ring->xsk_pool) {
> +		igb_clean_rx_ring_zc(rx_ring);
> +		goto skip_for_xsk;
> +	}
> +
>  	/* Free all the Rx ring sk_buffs */
>  	while (i != rx_ring->next_to_alloc) {
>  		struct igb_rx_buffer *buffer_info = &rx_ring->rx_buffer_info[i];
> @@ -5040,6 +5076,7 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
>  			i = 0;
>  	}
>  
> +skip_for_xsk:
>  	rx_ring->next_to_alloc = 0;
>  	rx_ring->next_to_clean = 0;
>  	rx_ring->next_to_use = 0;
> @@ -8195,7 +8232,9 @@ static int igb_poll(struct napi_struct *napi, int budget)
>  		clean_complete = igb_clean_tx_irq(q_vector, budget);
>  
>  	if (q_vector->rx.ring) {
> -		int cleaned = igb_clean_rx_irq(q_vector, budget);
> +		int cleaned = q_vector->rx.ring->xsk_pool ?

best if you would READ_ONCE() here pool and use it for the rest of napi
lifetime...

> +			igb_clean_rx_irq_zc(q_vector, budget) :
> +			igb_clean_rx_irq(q_vector, budget);
>  
>  		work_done += cleaned;
>  		if (cleaned >= budget)
> @@ -8603,8 +8642,15 @@ struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
>  		break;
>  	case XDP_REDIRECT:
>  		err = xdp_do_redirect(adapter->netdev, xdp, xdp_prog);

We were introducing a ZC variant of handling XDP verdict due to a fact
that mostly what happens is the redirect to user space. We observed a
reasonable perf improvement from likely()fying XDP_REDIRECT case.

> -		if (err)
> +		if (err) {
> +			if (rx_ring->xsk_pool &&
> +			    xsk_uses_need_wakeup(rx_ring->xsk_pool) &&
> +			    err == -ENOBUFS)
> +				result = IGB_XDP_EXIT;
> +			else
> +				result = IGB_XDP_CONSUMED;
>  			goto out_failure;
> +		}
>  		result = IGB_XDP_REDIR;
>  		break;
>  	default:
> @@ -8861,12 +8907,14 @@ static void igb_put_rx_buffer(struct igb_ring *rx_ring,
>  
>  static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  {
> +	unsigned int total_bytes = 0, total_packets = 0;
>  	struct igb_adapter *adapter = q_vector->adapter;
>  	struct igb_ring *rx_ring = q_vector->rx.ring;
> -	struct sk_buff *skb = rx_ring->skb;
> -	unsigned int total_bytes = 0, total_packets = 0;
>  	u16 cleaned_count = igb_desc_unused(rx_ring);
> +	struct sk_buff *skb = rx_ring->skb;
> +	int cpu = smp_processor_id();
>  	unsigned int xdp_xmit = 0;
> +	struct netdev_queue *nq;
>  	struct xdp_buff xdp;
>  	u32 frame_sz = 0;
>  	int rx_buf_pgcnt;
> @@ -8994,7 +9042,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  	if (xdp_xmit & IGB_XDP_TX) {
>  		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
>  
> +		nq = txring_txq(tx_ring);
> +		__netif_tx_lock(nq, cpu);

That belongs to a patch where you do:
"Always call igb_xdp_ring_update_tail under __netif_tx_lock"

>  		igb_xdp_ring_update_tail(tx_ring);
> +		__netif_tx_unlock(nq);
>  	}
>  
>  	u64_stats_update_begin(&rx_ring->rx_syncp);
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index 925bf97f7caa..66cdc30e9b6e 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -66,7 +66,10 @@ static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
>  	 * at least 1 descriptor unused to make sure
>  	 * next_to_use != next_to_clean
>  	 */
> -	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
> +	if (rx_ring->xsk_pool)
> +		igb_alloc_rx_buffers_zc(rx_ring, igb_desc_unused(rx_ring));
> +	else
> +		igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
>  
>  	/* Rx/Tx share the same napi context. */
>  	napi_enable(&rx_ring->q_vector->napi);
> @@ -172,6 +175,262 @@ int igb_xsk_pool_setup(struct igb_adapter *adapter,
>  		igb_xsk_pool_disable(adapter, qid);
>  }
>  
> +static u16 igb_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
> +			     union e1000_adv_rx_desc *rx_desc, u16 count)
> +{
> +	dma_addr_t dma;
> +	u16 buffs;
> +	int i;
> +
> +	/* nothing to do */
> +	if (!count)
> +		return 0;
> +
> +	buffs = xsk_buff_alloc_batch(pool, xdp, count);
> +	for (i = 0; i < buffs; i++) {
> +		dma = xsk_buff_xdp_get_dma(*xdp);
> +		rx_desc->read.pkt_addr = cpu_to_le64(dma);
> +		rx_desc->wb.upper.length = 0;
> +
> +		rx_desc++;
> +		xdp++;
> +	}
> +
> +	return buffs;
> +}
> +
> +bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count)
> +{
> +	u32 nb_buffs_extra = 0, nb_buffs = 0;
> +	union e1000_adv_rx_desc *rx_desc;
> +	u16 ntu = rx_ring->next_to_use;
> +	u16 total_count = count;
> +	struct xdp_buff **xdp;
> +
> +	rx_desc = IGB_RX_DESC(rx_ring, ntu);
> +	xdp = &rx_ring->rx_buffer_info_zc[ntu];
> +
> +	if (ntu + count >= rx_ring->count) {
> +		nb_buffs_extra = igb_fill_rx_descs(rx_ring->xsk_pool, xdp,
> +						   rx_desc,
> +						   rx_ring->count - ntu);
> +		if (nb_buffs_extra != rx_ring->count - ntu) {
> +			ntu += nb_buffs_extra;
> +			goto exit;
> +		}
> +		rx_desc = IGB_RX_DESC(rx_ring, 0);
> +		xdp = rx_ring->rx_buffer_info_zc;
> +		ntu = 0;
> +		count -= nb_buffs_extra;
> +	}
> +
> +	nb_buffs = igb_fill_rx_descs(rx_ring->xsk_pool, xdp, rx_desc, count);
> +	ntu += nb_buffs;
> +	if (ntu == rx_ring->count)
> +		ntu = 0;
> +
> +	/* clear the length for the next_to_use descriptor */
> +	rx_desc = IGB_RX_DESC(rx_ring, ntu);
> +	rx_desc->wb.upper.length = 0;
> +
> +exit:
> +	if (rx_ring->next_to_use != ntu) {
> +		rx_ring->next_to_use = ntu;
> +
> +		/* Force memory writes to complete before letting h/w
> +		 * know there are new descriptors to fetch.  (Only
> +		 * applicable for weak-ordered memory model archs,
> +		 * such as IA-64).
> +		 */
> +		wmb();
> +		writel(ntu, rx_ring->tail);
> +	}
> +
> +	return total_count == (nb_buffs + nb_buffs_extra);
> +}
> +
> +void igb_clean_rx_ring_zc(struct igb_ring *rx_ring)
> +{
> +	u16 ntc = rx_ring->next_to_clean;
> +	u16 ntu = rx_ring->next_to_use;
> +
> +	while (ntc != ntu) {
> +		struct xdp_buff *xdp = rx_ring->rx_buffer_info_zc[ntc];
> +
> +		xsk_buff_free(xdp);
> +		ntc++;
> +		if (ntc >= rx_ring->count)
> +			ntc = 0;
> +	}
> +}
> +
> +static struct sk_buff *igb_construct_skb_zc(struct igb_ring *rx_ring,
> +					    struct xdp_buff *xdp,
> +					    ktime_t timestamp)
> +{
> +	unsigned int totalsize = xdp->data_end - xdp->data_meta;
> +	unsigned int metasize = xdp->data - xdp->data_meta;
> +	struct sk_buff *skb;
> +
> +	net_prefetch(xdp->data_meta);
> +
> +	/* allocate a skb to store the frags */
> +	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	if (timestamp)
> +		skb_hwtstamps(skb)->hwtstamp = timestamp;
> +
> +	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
> +	       ALIGN(totalsize, sizeof(long)));
> +
> +	if (metasize) {
> +		skb_metadata_set(skb, metasize);
> +		__skb_pull(skb, metasize);
> +	}
> +
> +	return skb;
> +}
> +
> +static void igb_update_ntc(struct igb_ring *rx_ring)
> +{
> +	u32 ntc = rx_ring->next_to_clean + 1;
> +
> +	/* fetch, update, and store next to clean */
> +	ntc = (ntc < rx_ring->count) ? ntc : 0;
> +	rx_ring->next_to_clean = ntc;

That is suboptimal. You don't have update the ring's member per each
procesed descriptor. What you can do is to work on a local ntc and update
it to ring at the end of napi's Rx side.

Even if you would insist on doing the current way then I would expect that
you would use this helper in igb_is_non_eop() as this is duplicated code.

> +
> +	prefetch(IGB_RX_DESC(rx_ring, ntc));
> +}
> +
> +int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector, const int budget)
> +{
> +	struct igb_adapter *adapter = q_vector->adapter;
> +	unsigned int total_bytes = 0, total_packets = 0;
> +	struct igb_ring *rx_ring = q_vector->rx.ring;
> +	int cpu = smp_processor_id();
> +	unsigned int xdp_xmit = 0;
> +	struct netdev_queue *nq;
> +	bool failure = false;
> +	u16 entries_to_alloc;
> +	struct sk_buff *skb;
> +
> +	while (likely(total_packets < budget)) {
> +		union e1000_adv_rx_desc *rx_desc;
> +		struct xdp_buff *xdp;
> +		ktime_t timestamp = 0;

minor: RCT

> +		unsigned int size;
> +
> +		rx_desc = IGB_RX_DESC(rx_ring, rx_ring->next_to_clean);
> +		size = le16_to_cpu(rx_desc->wb.upper.length);
> +		if (!size)
> +			break;
> +
> +		/* This memory barrier is needed to keep us from reading
> +		 * any other fields out of the rx_desc until we know the
> +		 * descriptor has been written back
> +		 */
> +		dma_rmb();
> +
> +		xdp = rx_ring->rx_buffer_info_zc[rx_ring->next_to_clean];
> +		xsk_buff_set_size(xdp, size);
> +		xsk_buff_dma_sync_for_cpu(xdp);
> +
> +		/* pull rx packet timestamp if available and valid */
> +		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> +			int ts_hdr_len;
> +
> +			ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,
> +							 xdp->data,
> +							 &timestamp);
> +
> +			xdp->data += ts_hdr_len;
> +			xdp->data_meta += ts_hdr_len;
> +			size -= ts_hdr_len;
> +		}
> +
> +		skb = igb_run_xdp(adapter, rx_ring, xdp);
> +
> +		if (IS_ERR(skb)) {
> +			unsigned int xdp_res = -PTR_ERR(skb);
> +
> +			if (likely(xdp_res & (IGB_XDP_TX | IGB_XDP_REDIR))) {
> +				xdp_xmit |= xdp_res;
> +			} else if (xdp_res == IGB_XDP_EXIT) {
> +				failure = true;
> +				break;
> +			} else if (xdp_res == IGB_XDP_CONSUMED) {
> +				xsk_buff_free(xdp);
> +			}
> +
> +			total_packets++;
> +			total_bytes += size;
> +
> +			igb_update_ntc(rx_ring);
> +			continue;
> +		}
> +
> +		skb = igb_construct_skb_zc(rx_ring, xdp, timestamp);
> +
> +		/* exit if we failed to retrieve a buffer */
> +		if (!skb) {
> +			rx_ring->rx_stats.alloc_failed++;
> +			break;
> +		}
> +
> +		xsk_buff_free(xdp);
> +		igb_update_ntc(rx_ring);
> +
> +		if (eth_skb_pad(skb))
> +			continue;
> +
> +		/* probably a little skewed due to removing CRC */
> +		total_bytes += skb->len;
> +
> +		/* populate checksum, timestamp, VLAN, and protocol */
> +		igb_process_skb_fields(rx_ring, rx_desc, skb);
> +
> +		napi_gro_receive(&q_vector->napi, skb);
> +
> +		/* update budget accounting */
> +		total_packets++;
> +	}
> +
> +	if (xdp_xmit & IGB_XDP_REDIR)
> +		xdp_do_flush();
> +
> +	if (xdp_xmit & IGB_XDP_TX) {
> +		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);

pull this out to common function and use this in igb_clean_rx_irq() ?

> +
> +		nq = txring_txq(tx_ring);
> +		__netif_tx_lock(nq, cpu);
> +		igb_xdp_ring_update_tail(tx_ring);
> +		__netif_tx_unlock(nq);
> +	}
> +
> +	u64_stats_update_begin(&rx_ring->rx_syncp);
> +	rx_ring->rx_stats.packets += total_packets;
> +	rx_ring->rx_stats.bytes += total_bytes;
> +	u64_stats_update_end(&rx_ring->rx_syncp);
> +	q_vector->rx.total_packets += total_packets;
> +	q_vector->rx.total_bytes += total_bytes;

... same here :)

> +
> +	entries_to_alloc = igb_desc_unused(rx_ring);
> +	if (entries_to_alloc >= IGB_RX_BUFFER_WRITE)
> +		failure |= !igb_alloc_rx_buffers_zc(rx_ring, entries_to_alloc);
> +
> +	if (xsk_uses_need_wakeup(rx_ring->xsk_pool)) {
> +		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
> +			xsk_set_rx_need_wakeup(rx_ring->xsk_pool);
> +		else
> +			xsk_clear_rx_need_wakeup(rx_ring->xsk_pool);
> +
> +		return (int)total_packets;
> +	}
> +	return failure ? budget : (int)total_packets;
> +}
> +
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
>  {
>  	struct igb_adapter *adapter = netdev_priv(dev);
> -- 
> 2.42.0
> 

