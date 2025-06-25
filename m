Return-Path: <bpf+bounces-61527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C9DAE852D
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 15:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B917A56D0
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 13:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3549263C8C;
	Wed, 25 Jun 2025 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKq3+hfG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8545945;
	Wed, 25 Jun 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859406; cv=fail; b=omWfAy2kO6ezx9Qh51lVR4Q6d3JK+BM/gmktKgbKpKXPo50cDJp2yOF70aEiM58a/JQHXbZ+9Qv7Mvv+BYbDNACrhs7U4yKdwfJIwKJSBCG3byTDeeEm3FIKik5ETycGtGGrsjoG0qkaoIxxX3C6JOKIo+ABGfLoNrzVfToNNCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859406; c=relaxed/simple;
	bh=bx1qpFrOe2YsKqP5vq17IC/E6WJBd7MDtG5ryiDPXys=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XKH3NChfZdX6FxiGazUITcbN5oHIgaEz/Pf0uCScc8eN4ITP4qJ+R8NTbsQvqi8FjhRUBruaQd8c08U+tNJHRym2V+RJNN2nGt/506H1SUjhcXjbnKpPhCvaBxcUGBFi2v0EmCcbTrivolkfAn4PyHwrfh37bnwemYCktaafLgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKq3+hfG; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750859405; x=1782395405;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bx1qpFrOe2YsKqP5vq17IC/E6WJBd7MDtG5ryiDPXys=;
  b=fKq3+hfGrPZ2PInD3mu9bZAejbkVsbTxfqjwT+DS36/idETmkk4M49TC
   /YZZKDEELw3ZtDz4HFJh5p6RcqLm6FDA/nEAS++zN+0NdKdWRf7UIkKMl
   mRmZm4D5ZPeeLogyiPqwTOu15GdPADsGvCPW+EpihK7557Xe21COD96oV
   bIpYRWCrPPZOlSbbYtf14m8+1jjAXfosF8fwJ/mWYCW1DtL1h09qKH+Ha
   JN2zZHJuFe56NIqFWZCJAnXFywHzEYE9G/MU84ItOQLmZ+55yxEHbyMcI
   X1VN3H/I4QQdAQLGrIdIkP9HpmvZSy0P96xaAoMj0Ik2fiB5UiIfBtVCm
   Q==;
X-CSE-ConnectionGUID: Gu7gQoXZQYCc6cJV5xiJyQ==
X-CSE-MsgGUID: sHEQg1sqSxOXN8dXKLh7Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52994015"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="52994015"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 06:50:02 -0700
X-CSE-ConnectionGUID: PVzGqqEqRAuNy9Ve2+euTg==
X-CSE-MsgGUID: j196ubH4TvGK8PbYYaLHow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="151993575"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 06:50:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 06:50:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 06:50:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.80)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 06:50:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsFJOZIMeDh0Hs49AiOPg1x/E/K3zH4aw/bZy6IHbmKGE3tg1tTa50f1pNvPvWbkxcnEZxPEFSpnZPCa562VjApQToPio9+hulpV/wYEGlH8Cj62gUJgMWl0oF8uU75qUUaD3MVUoZIn7gte/IbkMBinl75zNQB9bxYWCAI9p7Y40UPMGf0qxTBMB9/SHN4Vi+SCR6nnS03ENEnuyeG/7sO9FA4AEuGTHQSN6+U77orADvIc/Am2oUjTbP19785uuV477vcsKBqfrbPJM5RrHQS73jccR5mT5M7jd/VxI1+YszvI7n6T4k1T/V0MjoBQZ9Z3sYfC9nF97nqQF7T09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xvjvt7vIX50Wwvfkkz49SMszPiBAUfBwXmzhipcBZCY=;
 b=OATwvUGxfgdL3rHzJxF2lRZjdmpTbsQV0zgHWRB9oZyx7fslxkbW2UY9Pjqg5echcbG847oXS8OZV9x4BCQs7TApQNGGBSrWsEbOZTYCG+gA2Nrtn32mi6eR8nrFNo6aBroc4N3n8av/Zke/HdVs1qgu5P5veFVQ1Wy5Cyjz0otn9I4vRK4qHpgWPTKULqHPhjEkyHCX90vQQ+4O9JFlkntYDHdGd63ug5LFUXZ4pj/u5NaZXpkWOkijM/08hwpjiBYiDJPaCsPehPp0bEcA54kG/1MZdaxkkJmXbKyaqCGUBu52dKEC7P7cZI5Vh+kIVX/HJRTQFmoIKAL+D8GzZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Wed, 25 Jun 2025 13:49:45 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 13:49:44 +0000
Date: Wed, 25 Jun 2025 15:49:28 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Jason Xing <kerneljasonxing@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<bjorn@kernel.org>, <magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <joe@dama.to>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH net-next v5] net: xsk: introduce XDP_MAX_TX_BUDGET
 setsockopt
Message-ID: <aFv+aJFkVt/ehouG@boxer>
References: <20250625123527.98209-1-kerneljasonxing@gmail.com>
 <685bfbe2b5f51_21d18929413@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <685bfbe2b5f51_21d18929413@willemb.c.googlers.com.notmuch>
X-ClientProxiedBy: VI1P189CA0011.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d7dbad-eee4-423a-9a53-08ddb3ef246a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3/Kv+tMHOyKAzE8mFeqQTRlvL3Hefjqlt+W7RW3inx9UylAcKWESzhhf3TG/?=
 =?us-ascii?Q?dlw09hAXXeot71gyZd+xOlpBh9679NnM/y/vmPYyzK2jSXRYSYRwPbHbM7fJ?=
 =?us-ascii?Q?g2oLun54ni5NC8TSNdzd6Qx4v3CXLytU5TEXKifXsnap7n+E3CfHfUbfrmgi?=
 =?us-ascii?Q?MfNLwO03zhRHw3Qyzqbju3OUHvmoOiEsotzq9xNmIslGXl+7RbkyEWIwoJ62?=
 =?us-ascii?Q?rmq1TNA6T15dGk7sryfd9Hgg8br6K0CG1sTAff0HVhGdlLBYqiFHdRHBAylr?=
 =?us-ascii?Q?KrDSzxb/Fiwt2vcECByQxs0HMTeRZHwT5N0ZrNF+DrmmPMWsEf3hYrd9i+CP?=
 =?us-ascii?Q?SghAA7bfJifyjV8V+xjnhuOC7GxpEG+Imchx+aeN+lMT7aVbvg11hWtm2V56?=
 =?us-ascii?Q?r3OlloDtL/cWsEWJEXNQRXI7qizxaV0mzaAXvhSDFNCd2/XYatefKKYndPgn?=
 =?us-ascii?Q?dtjJMDw83ua9oZtTj6GsPuAA1FqlEPQSSmae2s0TIM222GBoAKrFkdAzkoEE?=
 =?us-ascii?Q?wZN4QeULIV5xGD0d0L/4ifL+fX/0UiOWeyPAn4AFY4YoDEfSoCj7Sjz/GIJW?=
 =?us-ascii?Q?QO4H0NbTaNHjgMhgDv04+4ri0csXh78dsNd8sffm9aqLdkzghe9nQNAGrCqI?=
 =?us-ascii?Q?oqtfY+Ol73aGXeT7+QJ8i7twwpcichxI9hT1TYn4eNku1PAg5fZy3Pww+FuF?=
 =?us-ascii?Q?JM49pG3RDFV+wTSqMnRuaBdrJDcwW+4pszTmb+y8LXoaqvweoMcqF6eDt5Ry?=
 =?us-ascii?Q?O7IVi1RA0R25RN1jqwb1iuBPi7ou2hgmak7FQ5kbB5eDe+5V+zz1d0uzVGJq?=
 =?us-ascii?Q?a9F3mRt2pu3oFGgS5WCb7H9Pp6dDPyAZNOQJEIltQLL9+3Xdq3/NsBZanUoT?=
 =?us-ascii?Q?aZrnq22I0AyMWyN/E9VYuONv0i6NVDDDdeHeVdIuV2Ab0d9R68ecFWV6s/88?=
 =?us-ascii?Q?3+5oiRzNPAhyUO1awIRPCGRba/RffXtVd5oJJgwRghKFCPshabp/Sc6WIqRU?=
 =?us-ascii?Q?RH7KRNKwSDXc5HO64A2tAFEpcNa9MVj6ABCU18Zbo5P4h0aFsgHevRyHwgvQ?=
 =?us-ascii?Q?zd0k94Io34yQTbm1hqSK52BlvxtovFwPJR21xKGZdzB1PUJHrHyJ2GRNwZxM?=
 =?us-ascii?Q?M/kkwFfsu1ClU55BdaIsmOvjxZLcm6kxvF7qluzR9UaSuojaBoyLY0PJTLCZ?=
 =?us-ascii?Q?cIVrpp6vmEIP6+vOUrjZAnUvWXMSNJmQ4iI4OeJnTGPnB1d6Fa/VjFwCj2jE?=
 =?us-ascii?Q?p/Qg4weuQfOn01QNGbNjYKsjyl4owKls2opv/brm6g9ZaV4DxdirATJvFlBX?=
 =?us-ascii?Q?ogELsdKB6xWm/gdKcOKRvyDRS3qZTWh/EPA+4+soZIZ3GAwbu417Zm2XH0yj?=
 =?us-ascii?Q?ySEgttFKUBay9PTqiRLlODt6bRDLkXJtG7gs75FKwx/FONgTZYNT0fxpELTG?=
 =?us-ascii?Q?z5x2iIWo5Wk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q5xrhh3SUpW0Y3P8s4zB1OAQr3usr3UHt0/sQKr/pfZ0manzRUe+VX8s+K/s?=
 =?us-ascii?Q?sDxa0UGaNSTtB+FbiIH0k6xLM8bJvvGHwM6WCrZQs4v6U8zvlZbLJnWcjChL?=
 =?us-ascii?Q?aOZwFqTNROBIJ5YVjmY9P5f/0E9EOQ2AiA2KTdCthqta4q8fUUNejqI45jAy?=
 =?us-ascii?Q?kOeG5FnQKM7fhD4XrERD5ljxur/mb6EH+EHzdayHxZzA2A+SnK5hPmtQOfmU?=
 =?us-ascii?Q?NAaDv7aR5mX6/8ZdQwJm9imh0fliM+VwTROEt4ZrySQWgI6r8bo0c8z98ZSk?=
 =?us-ascii?Q?hH5Se3Z4tGWqGXcBu0cXDgwYaZKzEH4TxLFbPRNkB8gifb2UEr1RQbQc8iJV?=
 =?us-ascii?Q?4hcM4u6WjDB0EIPF/ELM25Z9/RGE4bUA+ThiZ4WQ2NNAQ6HL3x8f19crXCgw?=
 =?us-ascii?Q?dtB4PrWf+an+WO/9BzbszL6+239qx5UAi2dcRBIJkCO4Zd2B3wy7MXJ1FnrU?=
 =?us-ascii?Q?8IAuZTy0EWzVe12PzXmBeZZ7Iz3J4yRwU43cn7awWQsZqmpiVVXosJtV4lkC?=
 =?us-ascii?Q?S+W/jQSb9zAho8/Du4IJECQwoY4q++ppMgfgUeGZpF6KbqWWMOjxJumFGb4m?=
 =?us-ascii?Q?4V6iZn6ZapX+tyzIwo7ZZMfYYiFTsIT+9TtmAiI2XOEO0ZCK//1JeKa/qWm5?=
 =?us-ascii?Q?ih+N40TCV0k+D/L/9pbjRrlwWfYfuOw39pARlGDrznVhdqjJItUPb34DDZkf?=
 =?us-ascii?Q?W2UHyymdQVhRQPBlBDPFloEA6pZ7nP2QkSt3pWL/ekZVDPvtLdhHTQ2U6kZ1?=
 =?us-ascii?Q?YRWF19n4Jbp64snnfaBIN5QvB60odO81HbqCmdBBFjirAtDPPoQit7p+0tbX?=
 =?us-ascii?Q?3er01+8Yf8PdzJhvgL5Tj91pqbn0YdrSLZ4NSrv057Ji8KKIvBk0ggDZzSjD?=
 =?us-ascii?Q?Xf9h0uIUJDyO38HOJkB56Uy9uNNz180gWTEanuV0yu1xQNPr/E0e89TIPWwz?=
 =?us-ascii?Q?Rr8sO61N0rNwejLtBDlcQIcAhJGFTcY8+F5xkieIlj05DGJZNQ0u7mfeiP7n?=
 =?us-ascii?Q?pXe/N+rNwJe03AJtnVDreJsJaraGkDOzm3dKU0m+2sy0liARVXvkk3UKndZ3?=
 =?us-ascii?Q?YQTqQYeoEqgXgEv+WaWvOXnPfb46CLPNgBsdtKDBIKxF8YissF4jjogMpY3Q?=
 =?us-ascii?Q?38uYXuZEH23kjRmbp8IjC8hRRe/V6MYhpYcBVihVPIydPbw6tw3+6q4ZxAAY?=
 =?us-ascii?Q?sjjvv/Kajqjd+rwDEQSiwKbGzqzGV3x5fZ3/qf3JyrjqJpq1TqkXPIyBOSBu?=
 =?us-ascii?Q?HY7FVQxLOgNZp1kDwlr/Isp6FN/bivIR+84Uv3E6gTa2A4RE9Zpo9GA0hqPq?=
 =?us-ascii?Q?4tCwMcXUk8vhSNstW0h5CmpuRvCFemUVnxG850MyQEb7fEOYfAiZYDvY7Qu+?=
 =?us-ascii?Q?jYTXcXSSPYpqQZaNUOX8EQFulzlC5NejzJnSdoh+4/Pmzuip5DMeI1BriaUv?=
 =?us-ascii?Q?0wHgpBvbBSpvOb+eoBARrz16JO0XMqjKrzUGFx4FmPirQMjO1ZbvTMCPorXo?=
 =?us-ascii?Q?a99LSgCuenX0yIHymVGnVoXI7QYicNeSj0ZyzxlZZ8Hji4yYNWMw8Ge3cvwo?=
 =?us-ascii?Q?rT2F19/xV6cd1XwmifAUJizWpagAu/A/ponDZnueYFu/4p8Cz5ourYoQ0k84?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d7dbad-eee4-423a-9a53-08ddb3ef246a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 13:49:44.7206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gwwe37PgS9WiBKy7ggw6P5yVgcR7HVvb7YXP/PqEXyOO0bxyIPW0ZquhXQi5ZrPjxwGn0tmBS6GBdN2aFEin6dJXinMsN71tqUboqmans/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com

On Wed, Jun 25, 2025 at 09:38:42AM -0400, Willem de Bruijn wrote:
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> > 
> > This patch provides a setsockopt method to let applications leverage to
> > adjust how many descs to be handled at most in one send syscall. It
> > mitigates the situation where the default value (32) that is too small
> > leads to higher frequency of triggering send syscall.
> > 
> > Considering the prosperity/complexity the applications have, there is no
> > absolutely ideal suggestion fitting all cases. So keep 32 as its default
> > value like before.
> > 
> > The patch does the following things:
> > - Add XDP_MAX_TX_BUDGET socket option.
> > - Convert TX_BATCH_SIZE tx_budget_spent.
> > - Set tx_budget_spent to 32 by default in the initialization phase as a
> >   per-socket granular control.
> > 
> > The idea behind this comes out of real workloads in production. We use a
> > user-level stack with xsk support to accelerate sending packets and
> > minimize triggering syscalls. When the packets are aggregated, it's not
> > hard to hit the upper bound (namely, 32). The moment user-space stack
> > fetches the -EAGAIN error number passed from sendto(), it will loop to try
> > again until all the expected descs from tx ring are sent out to the driver.
> > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequency of
> > sendto() and higher throughput/PPS.
> > 
> > Here is what I did in production, along with some numbers as follows:
> > For one application I saw lately, I suggested using 128 as max_tx_budget
> > because I saw two limitations without changing any default configuration:
> > 1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> > net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> > this was I counted how many descs are transmitted to the driver at one
> > time of sendto() based on [1] patch and then I calculated the
> > possibility of hitting the upper bound. Finally I chose 128 as a
> > suitable value because 1) it covers most of the cases, 2) a higher
> > number would not bring evident results. After twisting the parameters,
> > a stable improvement of around 4% for both PPS and throughput and less
> > resources consumption were found to be observed by strace -c -p xxx:
> > 1) %time was decreased by 7.8%
> > 2) error counter was decreased from 18367 to 572
> > 
> > [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
> > 
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > v5
> > Link: https://lore.kernel.org/all/20250623021345.69211-1-kerneljasonxing@gmail.com/
> > 1. remove changes around zc mode
> > 
> > v4
> > Link: https://lore.kernel.org/all/20250619090440.65509-1-kerneljasonxing@gmail.com/
> > 1. remove getsockopt as it seems no real use case.
> > 2. adjust the position of max_tx_budget to make sure it stays with other
> > read-most fields in one cacheline.
> > 3. set one as the lower bound of max_tx_budget
> > 4. add more descriptions/performance data in Doucmentation and commit message.
> > 
> > V3
> > Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljasonxing@gmail.com/
> > 1. use a per-socket control (suggested by Stanislav)
> > 2. unify both definitions into one
> > 3. support setsockopt and getsockopt
> > 4. add more description in commit message
> > 
> > V2
> > Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonxing@gmail.com/
> > 1. use a per-netns sysctl knob
> > 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> > ---
> >  Documentation/networking/af_xdp.rst |  8 ++++++++
> >  include/net/xdp_sock.h              |  1 +
> >  include/uapi/linux/if_xdp.h         |  1 +
> >  net/xdp/xsk.c                       | 20 ++++++++++++++++----
> >  tools/include/uapi/linux/if_xdp.h   |  1 +
> >  5 files changed, 27 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> > index dceeb0d763aa..9eb6f7b630a5 100644
> > --- a/Documentation/networking/af_xdp.rst
> > +++ b/Documentation/networking/af_xdp.rst
> > @@ -442,6 +442,14 @@ is created by a privileged process and passed to a non-privileged one.
> >  Once the option is set, kernel will refuse attempts to bind that socket
> >  to a different interface.  Updating the value requires CAP_NET_RAW.
> >  
> > +XDP_MAX_TX_BUDGET setsockopt
> > +----------------------------
> > +
> > +This setsockopt sets the maximum number of descriptors that can be handled
> > +and passed to the driver at one send syscall. It is applied in the non-zero
> > +copy mode to allow application to tune the per-socket maximum iteration for
> > +better throughput and less frequency of send syscall. Default is 32.
> > +
> >  XDP_STATISTICS getsockopt
> >  -------------------------
> >  
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index e8bd6ddb7b12..ce587a225661 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -84,6 +84,7 @@ struct xdp_sock {
> >  	struct list_head map_list;
> >  	/* Protects map_list */
> >  	spinlock_t map_list_lock;
> > +	u32 max_tx_budget;
> >  	/* Protects multiple processes in the control path */
> >  	struct mutex mutex;
> >  	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
> > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> > index 44f2bb93e7e6..07c6d21c2f1c 100644
> > --- a/include/uapi/linux/if_xdp.h
> > +++ b/include/uapi/linux/if_xdp.h
> > @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
> >  #define XDP_UMEM_COMPLETION_RING	6
> >  #define XDP_STATISTICS			7
> >  #define XDP_OPTIONS			8
> > +#define XDP_MAX_TX_BUDGET		9
> >  
> >  struct xdp_umem_reg {
> >  	__u64 addr; /* Start of packet data area */
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 72c000c0ae5f..97aded3555c1 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -33,8 +33,7 @@
> >  #include "xdp_umem.h"
> >  #include "xsk.h"
> >  
> > -#define TX_BATCH_SIZE 32
> > -#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
> > +#define MAX_PER_SOCKET_BUDGET 32
> >  
> >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> >  {
> > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >  static int __xsk_generic_xmit(struct sock *sk)
> >  {
> >  	struct xdp_sock *xs = xdp_sk(sk);
> > -	u32 max_batch = TX_BATCH_SIZE;
> > +	u32 max_budget = READ_ONCE(xs->max_tx_budget);
> >  	bool sent_frame = false;
> >  	struct xdp_desc desc;
> >  	struct sk_buff *skb;
> > @@ -797,7 +796,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> >  		goto out;
> >  
> >  	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> > -		if (max_batch-- == 0) {
> > +		if (max_budget-- == 0) {
> >  			err = -EAGAIN;
> >  			goto out;
> >  		}
> > @@ -1437,6 +1436,18 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
> >  		mutex_unlock(&xs->mutex);
> >  		return err;
> >  	}
> > +	case XDP_MAX_TX_BUDGET:
> > +	{
> > +		unsigned int budget;
> > +
> > +		if (optlen != sizeof(budget))
> > +			return -EINVAL;
> > +		if (copy_from_sockptr(&budget, optval, sizeof(budget)))
> > +			return -EFAULT;
> > +
> > +		WRITE_ONCE(xs->max_tx_budget, max(budget, 1));
> 
> I still think that this needs a more sane upper bound than U32_MAX.
> 
> One limiting factor is the XSK TxQ length. At least it should be
> possible to fail if trying to set beyond that.

+1 and I don't really see a reason for something below 32. So how about
[32, xs->tx->nentries] range?

Also if there's no xsk tx ring present we could bail out.

> 
> > +		return 0;
> > +	}
> >  	default:
> >  		break;
> >  	}
> > @@ -1734,6 +1745,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
> >  
> >  	xs = xdp_sk(sk);
> >  	xs->state = XSK_READY;
> > +	xs->max_tx_budget = 32;
> >  	mutex_init(&xs->mutex);
> >  
> >  	INIT_LIST_HEAD(&xs->map_list);
> > diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
> > index 44f2bb93e7e6..07c6d21c2f1c 100644
> > --- a/tools/include/uapi/linux/if_xdp.h
> > +++ b/tools/include/uapi/linux/if_xdp.h
> > @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
> >  #define XDP_UMEM_COMPLETION_RING	6
> >  #define XDP_STATISTICS			7
> >  #define XDP_OPTIONS			8
> > +#define XDP_MAX_TX_BUDGET		9
> >  
> >  struct xdp_umem_reg {
> >  	__u64 addr; /* Start of packet data area */
> > -- 
> > 2.41.3
> > 
> 
> 

