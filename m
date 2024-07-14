Return-Path: <bpf+bounces-34777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2234930A8A
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 17:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44E81C20BE9
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5B513958F;
	Sun, 14 Jul 2024 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeYTUtW4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0479EF
	for <bpf@vger.kernel.org>; Sun, 14 Jul 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720970883; cv=fail; b=shdn7YcE/LI9jUyjltThJyD5fFNDT8ChYJ2m/RdmxHk/jaAelVVU+gDgZNST4KZ8KHivfjkSaYkeTnT+8K/ZhbQw7Zfa0/e2JbzadSDO95zrfX1itZZ5mU2MbYi/snKs0OoUZR4TrSnw9lGDoiriRRlYa+0gfrGDRBHSu3DJ1Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720970883; c=relaxed/simple;
	bh=7h+Il/ZErQ+IH/R6Jv2ARvbUBlfwCrP6NclM2Du0EGQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bY6OEJiyrcu6X1O1YOJIZwGUT93jYsdVxzxOjAYVl8GGrFAjC+pk/OALF/4vJdPLiO738JErMaV0lwcJL+C29XxdDNFb2OuH23OsTSWc/mByvfcfehGEyS/nKMzDlrx3khwa6qkDdJof4xqIChCf0pligeIfQWb8DtwUsdw19qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeYTUtW4; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720970882; x=1752506882;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=7h+Il/ZErQ+IH/R6Jv2ARvbUBlfwCrP6NclM2Du0EGQ=;
  b=JeYTUtW49Ui6/J+Vy2RTOlR5I2JZMJjgTzZoRbaylKomjeL7DkFHRVmt
   aoWfJEwmjj3O/0lMH4n8XPtIqVrO4mVOdKPsJqhbWp8YULTk1Lkk6MruE
   dr4aVHNYpAmMOhULldSSk4pg/TLxwbvPqkQln1sgHkr5DkO26v/jv5WZJ
   vF9WwRyO2F35RL0WlC80YLrxahUU2Ph+/fFkwORQDwjAYOSFZCZlOKdLC
   tiYE0soj+zWtk1CdsGipjs4DzmfCvCQHLrSJLTdadiYRjN3YAMmJW++jP
   gc8IVybYY7lSzecYvgOdNMBbKhnaRjGVPogjntCLDhIrffEYbFs+XsNMF
   w==;
X-CSE-ConnectionGUID: dMScT7lxR22QHPGkNSnY0A==
X-CSE-MsgGUID: nwvS0FKOSr+4PklBbUsypA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="22222480"
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="22222480"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 08:28:01 -0700
X-CSE-ConnectionGUID: rjnmaWE4Q5CMP/2s3AHrUw==
X-CSE-MsgGUID: MGd5qPXIQuyhSAKSC4uEWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="54309115"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jul 2024 08:28:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 14 Jul 2024 08:28:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 14 Jul 2024 08:28:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 14 Jul 2024 08:28:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 14 Jul 2024 08:28:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXht6VdwST1Xh2+cf68HYOu0tRQDeGLuUUlqVSeYVjW0n2n6xdVGjIHjNjNloYaTca2NjpEgATyl54alMh+DUh+6eA+gdZJ039C7awPeBgR63r/iyh6vvVG2BmM9UX7fcSWkohfotL2aNXbGtmWBbZ53/2P6zFJ6Xkv0K2npx1LU59lYk/MUvzoY591EBg9fOQeuQ+6jyousAj6o/UJLcyZu3dICgIt1C/5NZLo0TZyraXlkEWWsmCcZTAj2y2//x+6UHCvBNodbcYav5MhsviycpcjC8DHEcSO4oaJMUbR6GLPbRZ0VXgPNIJdqwGNe9Ucm5fbcP89CYN+2R/yC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sKYEY4Yvm8cgVqWzxA4VOyKyIr0nJE1GnyoHe8h4JU=;
 b=ZSb3jxdzE+FqXKWdkFY/Dt423pvKUh0JnTlymQj48dRMbx7vcOqoL6sgTCmKvnb03mKl6YkDFDie3Dp49iVhVnfU1KnTXCBTTYEs1ZQ7DuG/8stLGLbV5gy0Iv014m83BYGam1jEM6YPXQYsuXWi4U3RfE/9Ts8Y6N07+JkTRsIVc/BH1IxQJlLB2SssZ9VpYwlYTpQs5m8Ge/fKgfhWsimKSCywYJCL2nEDAQp99in+5uhKqAD3xFxhs1LiL48HW0wJMI3SRV0Z6znJtYii56lEtvykeJITce+VUX/jcZDlhv/x9OCcJM8upLrYMlTFXEwSxtyP3oy/Kqe3I03OtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 SJ0PR11MB5151.namprd11.prod.outlook.com (2603:10b6:a03:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Sun, 14 Jul
 2024 15:27:58 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7762.027; Sun, 14 Jul 2024
 15:27:58 +0000
Date: Sun, 14 Jul 2024 23:27:46 +0800
From: kernel test robot <lkp@intel.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<kernel-team@meta.com>, <andrii@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <sinquersw@gmail.com>,
	<kuifeng@meta.com>, Kui-Feng Lee <thinker.li@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Add traffic monitor
 functions.
Message-ID: <ZpPucjqnHxcYCgv0@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240713055552.2482367-2-thinker.li@gmail.com>
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|SJ0PR11MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 513ec665-7907-44bd-a2ca-08dca4198a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cgAj5ABD23q5DwQFsyKtpHe62czGtQqPQ0tHktFVhzVIvJeuEP7Pu9t05LNg?=
 =?us-ascii?Q?JZEo6lcn9Ee5ax+UPEb2usOFzOi0F7k6bFyJpwJx/ZUUhStxcPUzMxqLLbvD?=
 =?us-ascii?Q?wr9fGVISBE4n3u6CdJ01v7lKd7LGWTRmA93e674fzMsNLyshTNwTQno+YhSs?=
 =?us-ascii?Q?XDGFKRFPThs6jrP57WrdUMlFTl2+QyPNx6iXZvvAJxtH6VLO4UKOEQ6gONvm?=
 =?us-ascii?Q?YgsghMDNtfhKsbqR9iFB/oDSMeTjTFm0soFjVL2u6W/85dTyeHA8f2HPwoeS?=
 =?us-ascii?Q?Y3Kj30e0HmzDI0zwhtBFrDD535NyC+E5kvwd4R842T3FM1Gps+qPFj2HPj0D?=
 =?us-ascii?Q?2CKrp602oMOgJ8b7lXonPOqPdr+yzdT6NkYH2Nvmde5jWhb7Ib9bEuFwKX+w?=
 =?us-ascii?Q?d8P9L99NUg6lbbwWeA9ArpxWi9XJzGI3mEYzwoMzevwxGsLAnBpBdPKctDdY?=
 =?us-ascii?Q?AZVRDAEqLrH0AJ/m3UGU/az4NyTv72RkPrs8MSThOYesH1sg5/HEgfpo9VWk?=
 =?us-ascii?Q?4Cg7ZHz1t1pDNMNhiRbg3rzGTQtZ7CEOJT99/t77UwzsmG4oKsuhwivrq/Jh?=
 =?us-ascii?Q?SU26fQZa9YZ9IpeMBGiQmGUeFJyMwhAvGmx0q4W7PoolWOAw+3nZ+6UQuwCV?=
 =?us-ascii?Q?MKQmWkLEmsT8YUeh/DOxIha5Op+doFpR0ozWoFHBVAcHO0Vc9tVUmRBqRCz1?=
 =?us-ascii?Q?F4G7+gWdb51+hjJPvzbqPDfESiZVHEFdDnKXQh8MrGopiPHAFi07T3lOMeEe?=
 =?us-ascii?Q?6aQmfTYMZkz2alEsMHX49bU8nhKMgiyXnciHw6kKjOjpV8t7oW9ysV7Qmaz1?=
 =?us-ascii?Q?Iz6a30mw66exsdp94t3hMS/KLDuP1uM1JWN4gQEztt46v/QknY+H9xYt3yTR?=
 =?us-ascii?Q?gm0mT0pirBe1+To1Ix2rqn2x6p8SwerA3D1H182vyR6VRAL1TZbwA35nYmCP?=
 =?us-ascii?Q?DpUYTbYIt5BAgcyUSkZIm6/XJ7+6zSxymSLu2WsPFtJHx/Lftbcef+XqzO9a?=
 =?us-ascii?Q?jlhNgWOZX37eE8qMHcE/87zDFX+bjgS9xRPdpf2pXR6Q9vLOOUkSFDcnR3xe?=
 =?us-ascii?Q?tYeuoSs/FdXSglVOchPjZ60CDru/nwy2YnMY5TzHpdn2hKGP+QjCGGevrGJc?=
 =?us-ascii?Q?ZVGZ1IPIBgJVDnzSUjPeImpyO5ZzIeGevqv932waaiC/6BXWOAeHvEUbt9zP?=
 =?us-ascii?Q?fqDwkATaAVfiW8JtQSzDQplriHoXsse5R30cGIN8uG4gejeaI2Uot2FKBsnZ?=
 =?us-ascii?Q?bK4HtRVcRlHp8Ssitm3ePfhMniDYz+NtuDi1NYipUK3EWN4XzdHFQyHCgzJu?=
 =?us-ascii?Q?iBw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+U8Iaw0FWM4XonAkZ0NcQCNBavHlOaSPzDpNE9xa1l8mB7k2Sw7OX2wOmLK/?=
 =?us-ascii?Q?6jvP0hYt1hx//tPDUXu/H4X20ymUrkc9fq0KyGNdFF5nbqaCGd2jqQZhNe0v?=
 =?us-ascii?Q?Wun9TxCwUA8ufsg01NbEfTcskEhgrwPWc6sPLf0KXVXdpzex7sWu74wLzgkd?=
 =?us-ascii?Q?n45sO1tXBtgmGvhjKUjd0PZKZ9YUsWTMRavT0hgBnt72u+4Xx662rj+qyfT1?=
 =?us-ascii?Q?+SawKqlba23bpmfXGYhc45d/j05L1qrb602Zx6ZTiLxFyyCZUfkdwj4BEsDQ?=
 =?us-ascii?Q?yV/x7ERfYdibAK802wKKd58dZbNjmC+KoYshn7TKeTazfYjxq8KBWuR6M2sN?=
 =?us-ascii?Q?AlX/UkOuTRHSp/suSb6sUiiRfFlcrsqCjTP/3PXk+SFYL4pKG9LMyRhxbRzB?=
 =?us-ascii?Q?5t5Z1yjmP2+9Zcgmv7bdrZdSSWdPSGmhSF3PbN1I/nZZOX0PdYnjyvqspMrQ?=
 =?us-ascii?Q?EZli4NpV4BGWf4r73TJBQ8/bQPvFgtvleJpxESvkfcWDbpAP7mrUn5y0htqr?=
 =?us-ascii?Q?LTBtojPsMSIZvRLK1ciZjl7B2FnBuShOVB3gp/WGfiAPcvtBq5JPR7nP/VBP?=
 =?us-ascii?Q?jX5APFE+9vxJivPnnTArvrm7u78pA/rI2L3U/6TPVKlA2QbGQi5UfUHu8BLO?=
 =?us-ascii?Q?fPm8PzXe/bHnEEj9WhhGknOmVjfHqZFq6k07F0jd/HK/aOfKKrzACw30fDMt?=
 =?us-ascii?Q?xC8njrrhmhqkt7bVQyHuCXHbj4Sofhx9LkmHUMOvFqWsPFiHyvl4BbA2rQkJ?=
 =?us-ascii?Q?LBao0HIyIGpHtJV/smdecvKn6x2xXO/TRMGMHTRWb5MXGcANDutGz703ujqs?=
 =?us-ascii?Q?kK7oN8l6adUT+38SuRGodqdgwFRF1emnKuR8bNFsiRVPyrqbm7Cprq8vfDx0?=
 =?us-ascii?Q?KdFlvWd4dLs2FaEwLoJ9ceDv+vNX0uJT4PguKFW5kPWt6MFjrkYNtF3eFdPL?=
 =?us-ascii?Q?UGjisFOvVfTPI2ejIqZicJzjMjbWzyq0Sj0ROps0D9YtM7aQPzxb8zOP60sm?=
 =?us-ascii?Q?8alXbJgFe692yh1xf+hDkRYgYx1BlG33t6VK4yaptM0ioO1Xd7oDWyn2Iai1?=
 =?us-ascii?Q?Mk8/CnERSAhTS6GHIIlLIU8iZvmO1hVfKmMXxtSUmNRCajKmsAbbi7O2qQGF?=
 =?us-ascii?Q?TqPSwzbHl2jnKfEx85aal6hsSruzp6+GUOCAkNt7aWnoy75b1vpsPcbIBx7B?=
 =?us-ascii?Q?y0SPpHowQN69T5A2KbXdqOZb3O2bXAP3BzJepDnBwqOHgvd2+/lRinDf951L?=
 =?us-ascii?Q?3zUUUcbxPi9MxC0nM9OBVFlnUMp5cxUShHxT5+W/kvouLYzLXl+E0OgwXaaM?=
 =?us-ascii?Q?++7JVEY+oIdzGrP9bVOcAx/Mt/sVGmsjutPZNUKA/b4Y50twn4kZmZH4/CYr?=
 =?us-ascii?Q?8Mw2Qg2bTk2O18ioFbL143zqw3ZsCVj3zxxuTS8TZgShst7PX0rzOh7zvm3P?=
 =?us-ascii?Q?Zr4NjAMbFmGfRVVGOWKMBOEVyUw0SLgcFPkE4yNxlkrPKJwBM0EXlzxprw60?=
 =?us-ascii?Q?470a+TecLMJ/iVA7S2uq0xrWi+AeTxvkoSEMLKuF7l2ACIcVyOVAjCMGns3u?=
 =?us-ascii?Q?/9ClWfbE0YTAnWQUpm0TNI4QRQCuO2YShYSP8UAo8MXpCgmsOOGVlJpuwydM?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 513ec665-7907-44bd-a2ca-08dca4198a0f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 15:27:57.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxHwuq5662QyBbZl6KZ8fZODiJbfhGRvWshONe79XVNHmFTXwVeU8onqQzqIHCrBncQ0C8afyYt9YeqVGTZTSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5151
X-OriginatorOrg: intel.com

Hi Kui-Feng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kui-Feng-Lee/selftests-bpf-Add-traffic-monitor-functions/20240713-140129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240713055552.2482367-2-thinker.li%40gmail.com
patch subject: [PATCH bpf-next 1/4] selftests/bpf: Add traffic monitor functions.
:::::: branch date: 9 hours ago
:::::: commit date: 9 hours ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202407132213.2rer2R4r-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> tools/testing/selftests/bpf/network_helpers.c: sys/stat.h is included more than once.

vim +13 tools/testing/selftests/bpf/network_helpers.c

    10	
    11	#include <arpa/inet.h>
    12	#include <sys/mount.h>
  > 13	#include <sys/stat.h>
    14	#include <sys/un.h>
    15	#include <sys/types.h>
  > 16	#include <sys/stat.h>
    17	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


