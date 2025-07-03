Return-Path: <bpf+bounces-62296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57817AF7AD7
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 17:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAF46E2385
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 15:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CC82F199D;
	Thu,  3 Jul 2025 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNOQGSb2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1032EE97A;
	Thu,  3 Jul 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555499; cv=fail; b=ED8fG1AkRamPUSGlRLyG7ych22VquZ/NkSKMj2zsvCSNW2/05T80wFuDDL08FA0Yj5ZjFZYvDzp4pQl/j15GJmLyQQJsNWVx2XtFdYXqYJGH3+1KAVrbQKbGrqQQ3NGz8KTlgrbI0sU9nLjZLuBjy/Xg7sLDfCXNjYj+MIA3wgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555499; c=relaxed/simple;
	bh=HzDk/wF0JT/n7w5fGahuyJHZV+IJiZW8eGkMnXiqlyA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XW6opVPzwOqxKmrbJvptg/dk12YrA1Y4EetjZw5lGkW0+HnjvHX3mkXQa8PKe0YO8uiGRqrhwfNxjI5qbvhrlh+N4WHarY/RUoN6c2WY5JyQGJaLzevdTpzZN7mwj+Mw99rRGJbhAPM6saZIw3h/crcefgxxBDpNM2QXmHLW2wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNOQGSb2; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751555497; x=1783091497;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HzDk/wF0JT/n7w5fGahuyJHZV+IJiZW8eGkMnXiqlyA=;
  b=QNOQGSb2WQYzxAlkZTUP8c0eaZbJwp9XeMvS0sAirfCE0lv93gDayDxQ
   qjW75XwPTu6d8XIp8YrzsAI+dP1JRbs4wK6/V/1ulYL1YpdBXX6VMuhXT
   awaOkUUOy9GOPRiu4tSwbTqnEvLzYFCSL+hXI+N1uZbvP8Cu+Di8fjBXu
   WIMN3xWXBdnWVTvqnlQpwAKR0u21C3xGO/PhDNBL1ojPft40bI7Mp+h3e
   eKd4QYgkNgvbC4L5N1guUgnhxjkEoEIvGLADIA1dY6OEYoa+7rkOVqVNl
   pnzVGbO2jWtfI8pFZj6blW0x4Q6RUvdiLrmEEl6p0CaLc/cYq4YZqmBW9
   g==;
X-CSE-ConnectionGUID: 2pPoIgZ4R8KT8caMdGIs/Q==
X-CSE-MsgGUID: BbWSdUDzR6+/kPpIMRqRxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65232667"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="65232667"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 08:11:12 -0700
X-CSE-ConnectionGUID: HrmMkMTwTDO4rbaxikDU6A==
X-CSE-MsgGUID: j5tnMhQMQ8CdT0znLfn9fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="158436463"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 08:11:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 08:11:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 08:11:11 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 08:11:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbIq2lQQB3u1CoTeQZdYLfkoawHpSzcRKAke01H0o/4nk5whpVjct1UJNBt1mECVdBAH+FM0Bmg7jieAHdohFFcDN/p63Q6PGdCmO/v2c/15ga1LhD+47f60nYKlCTartNJ9O5yTmSn+/RxGHXPbUCHbs2yqMo26198sG4fjJ1FIOl+7EmYCGbl0wQGlKWsC0W0i8tIT3/oumS3j8MHXazLwu1IR6pb/HN60q4vHWTIG2KrfPOnLJdMgQkOqAFT5P7uVUt78mQMxHHbBjK/HJT4jxFZI+1jcLHr2uZLrkoAE2/OOfIVP9t9sbPywgnOQQqKB8V+ntGdJEyHTPheFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbH3vfISarKPo3h8H3kIMqrSizlPvPJ4HWy8GfINEoQ=;
 b=h29cHsn16p7F0f9+IGF5bAOxnKosggZEpyL8b/EElww6i5pFctVSvbQ5XlruUHRXn6rEPtI+u2vezXVi1kTHAgeDzUMIw4KdE6/26zsjD/uuU9KUre+WlZm5v9jX+AGLBn301wf77E/P52dk0DP/u/90IwXlgMEMEyzRHBYgGMpPkJYMuUEOC5dYT6/7HgjZ7CGHneyUFyTicBOBxG0/QcVtfJ2ZkMqqsN4Qp84twxkDaVLG3ovKfS0a8dI/vK0BlI288j0CwfepOFof1ku63C3lyJVnwICfLTYsmSOsQaPwCIvaRn3Vg5tUOQKHNJWgv2bWqB40Fh0mk1JEl20v8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BY1PR11MB7981.namprd11.prod.outlook.com (2603:10b6:a03:52f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 15:10:26 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 15:10:25 +0000
Date: Thu, 3 Jul 2025 17:10:00 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v6 2/2] selftests/bpf: add a new test to check
 the consumer update case
Message-ID: <aGadSGJcyL6Q3PP0@boxer>
References: <20250703141712.33190-1-kerneljasonxing@gmail.com>
 <20250703141712.33190-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250703141712.33190-3-kerneljasonxing@gmail.com>
X-ClientProxiedBy: DU2PR04CA0293.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::28) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|BY1PR11MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 25bfbb02-0723-47f3-a3c0-08ddba43b68e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s10C0aDASG5/reiUpieg733Z/5Fxna5yD+NufSAgQmRcVBk5qAX8f8tQMToU?=
 =?us-ascii?Q?Un/BBoJQZdY2NnTY7seMeB+Dm6HLw8XBiPKMsZd1/Nfy/d5eHUkC1KGDxpJC?=
 =?us-ascii?Q?bpAMZlBH7+oCxUsKuSpgqasiSJnCpXolqw44dRnBs5oTgXQxDgbF+1AnLU4H?=
 =?us-ascii?Q?8tztSmDvTAhezqLXbiOm0odMJwJYNOU7sz0ZKy/2veYdJrnXWq40qNrc0wCm?=
 =?us-ascii?Q?M8tkwZx8XACngIUbsupkV7emvwz+++xIGvGEzmyo0iKj3Fhnvt5zO3LK9eey?=
 =?us-ascii?Q?F3+HOgO1E0bQFMIpVMftaR9DDgHK4vsRx5eOs2PoMnLluHyyI6Vaalq3x8DL?=
 =?us-ascii?Q?dzIBwI4Vpy9c76nR181xKp2lbBGTiP/IvfuTTunCOEWLfQ3NElbychu6mbgO?=
 =?us-ascii?Q?ARUY32+Ce8dKoC8rjn9woUCQqYavyGmxL3a2t/LsUKLDmDCkiUOqoGDzI8cV?=
 =?us-ascii?Q?fz6nl1IPY7qM/SPCbr7y9kxaBnX/MAwi4JyfWF8hoHcDBiJBBnAMDuWIvZ2e?=
 =?us-ascii?Q?TMYOD/ypnv3oGo4GBw+LmW8Gd6GQvNaERVdH4ZbNnEoVOXxE7QILgIdAe1PR?=
 =?us-ascii?Q?4Ruzetc252MN4Xwfrk9+BaVDDs95QTbmKumIu6dXGoAtc0W/C3a5AwmhS5KH?=
 =?us-ascii?Q?30+fkwJvO0CJhKy1kBOvBIZQ2vDxe2mMTn9YfC4UIpN33KrH/F09ZOIpgTSm?=
 =?us-ascii?Q?vA53dLmtI8D6MeULPwRUb9k6b/sD7GN+qXOXxGJwEgxZmLJkj5aHxTL76z3p?=
 =?us-ascii?Q?/l6EbWsCJ9IQgVe8wLs5dWYh8W4sDD8Cl66yp+5TvQ3to3d74CLcTz4VPMOi?=
 =?us-ascii?Q?vv+qZ7TkP9bl5HfqgkMyENShgN+OoQ4zIaRmVSamGRpllVTDUzV+mScj9ifG?=
 =?us-ascii?Q?XBC0XloD2VImMOlB8gYrM9kCUhXL4qnaFU9wxQn8rlp9jgLlZh/jaT449XEw?=
 =?us-ascii?Q?FE6VO1meLeHGmuezjFTfCyrrULhSmtX98NaOYcTaODMd0eIiFj3FynvYnBEi?=
 =?us-ascii?Q?gOiQZSPXE1+R0bFT9eVDvzi02woJMdADrePzU1I39QiwI5OOUbrAs3QqiyiS?=
 =?us-ascii?Q?bsScMNXJICTz/kl4YjKn14XWgHuKKYrcTAuA+NME4yk2BsnwXfiWzeonxLib?=
 =?us-ascii?Q?QfhVIPAgJn/++NulM+3OR6AZbbybSNacEtd4aqE3LLibS2vS6TbJap0MG1tI?=
 =?us-ascii?Q?nG51zQpJ0tfkCTspNRof8qCOAUpH5Bo7pMB2DblkwS2I8RLFayg3jIWVmVmS?=
 =?us-ascii?Q?ZgOJzyXUf6Eu68YOKSn4Q7HO3aonJKUaHbGllf/11y0iKtplT8XWiNRaRqOf?=
 =?us-ascii?Q?5wnPXcpOJbajblqAqhGP1Alqi/hSOsxDQ/MsxTHKCqhv80Qfv+ATmU7NEjyf?=
 =?us-ascii?Q?qTszNWamIniqMfWSqp8gkD6U079ge7PukWRlxhyISX4ZbohDBSqDIoWtuhQn?=
 =?us-ascii?Q?gliKc1lepF4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ksL0D9SvAQxB+Y7moAAwJyDgY/n/Pef/ywfVp4Xw6WRY3yun0k2T7L4fZST9?=
 =?us-ascii?Q?p+GAxcxiX4i7vkFeSpsyvftR8dUtEuO1QSZZLfsWqa8HExXSqzgV24PrsVBK?=
 =?us-ascii?Q?gZPBhCAAu7EUpOe1ct8YoyiPupKSP0gi2p1ohQcgoRJtdXO6nufqH4Kxgo2I?=
 =?us-ascii?Q?4bY2HYcow3zgKSrppxqXVFiZiOnlgqJHmabwDims709veSSPI9ETKp8Ypdbh?=
 =?us-ascii?Q?vwau4i9FesTqc/WxLe1MybXecdrZaWSdjYv/Do7lk0BHUJ/Ik4SrzHUsnq1F?=
 =?us-ascii?Q?ZDNuQLe5uE7jXQs0evckXMmTdMSdNyedcLDuYnccPR86diWAiSC9Rgt/jodr?=
 =?us-ascii?Q?/cG4GjQQjqHewwhUu9guedC8tP9T9Az9VeY3TeL41QaEFo5fvuFL0ZOQuHAd?=
 =?us-ascii?Q?KozmC+rMS2Mc/K4ndYO6KeCpYO8l9uxlLd625OAPSZVbQOFMwM8Giebd3QcB?=
 =?us-ascii?Q?VQUxXTQELqwn6VA8yb51mX5KWhBRC27ODuNX3iFKf9enbl/+iDyPBdgt6nm+?=
 =?us-ascii?Q?7CIc5k6Efxt94yDaMskvJm+VoBc48FovnO+dplV/N1StCO19oac3ryz5B8Zv?=
 =?us-ascii?Q?Gqi7u964DBUkqLbVa94QKN+U9yalslPQN4MG2H54qQpG2JomAdQcfOhldQyO?=
 =?us-ascii?Q?hSRw7PCq8JQcUv6FER69+ezEIQwHu/cIfT02yJHDXf7B5tL+xoZ4s6TUZEZE?=
 =?us-ascii?Q?o93aZlzvKfKIUzLO1qQ8YQWTeTqn6Zhxa1EKlvQN3+JstttSUO8/juYjsmrh?=
 =?us-ascii?Q?kK4ItHqb8U7hUp20guEVyFFmFEu0Rna2hmtNuMCBQWap10FLvuFji7W1q9b8?=
 =?us-ascii?Q?AajQ/V/wkGD28EUx+BtXbVdmDLt1oQjA1ZJThFjivlb5EHP6IxmuUJeLwTba?=
 =?us-ascii?Q?0lHeY8e2ki8hIk4RpvQQ5jnqJHm6K2v+4Oqwet3Cg4Mzp4OKimjestuusUsf?=
 =?us-ascii?Q?nPDrL/OvR2Bj/zgsiWqdOu2YohdYhJJIIb4VCLxEgXXor8VsRdZXcHkYVkR6?=
 =?us-ascii?Q?6rC0pdc1MnNpDv7KmN2FQKp9UxN6XZ0Rrm4wj+3pgvdcGdQ7//TUeY8HwQ2s?=
 =?us-ascii?Q?Lg8+De/BOZFkh2tW9cMYXv9ifQ00KyHhMtP+/Ff71Jkpxobqsa+hvXuc2xyL?=
 =?us-ascii?Q?s1KB8SFZWBxKVt1P04X4oVN4rdu68McXNDNSsJw5LC02s0bnTUB928SRiggk?=
 =?us-ascii?Q?S+yleTMTGPf8ohRB5KyqTSEOJq7L7gHx2Pp2DJI8hz8FFC4xVS9Dn50JoqiI?=
 =?us-ascii?Q?XLKhntr99ciAG5vXLHWFiLCNDbDmZferpl5HCLPizKLY49bChw9rgftsz1sd?=
 =?us-ascii?Q?XZcUw+DujF/0UyvAiFfQuIzbaEG1TO8BXYMWAOavEk9GHv2JUt39CleQ7FSd?=
 =?us-ascii?Q?C6VpC+4pMoPXRtNic6gvR9WthsSGaUPNBpE7XFUz68UvphYUTqVyfHm3CEgH?=
 =?us-ascii?Q?GF5cw99SIxLuoSDRA/peRI6RkjDpuEb6BDOYJzc147mSuuqhiT6aWKrx8Vw2?=
 =?us-ascii?Q?AqOcw4C8EfSL9fJJDYZFUd5HHxWxMU/0vwwvKkfJD63dL5+D4dqibCfj6ElO?=
 =?us-ascii?Q?OcmOZ7hAq+M2btlCvTSubTnNkjPFWucxqTcRwHkWs425vUgorqu2JpeVNwrL?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bfbb02-0723-47f3-a3c0-08ddba43b68e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:10:25.6320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWQiZnvBYIiJC07ErI/WvxmzBlj1s6lXqOjRtjvgX9/FYAFk5z6GHNrIFdCWvymbtifzY9inXgOFKoMfVSsnROy1KHqQG/ZQVOEwQdRwjxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7981
X-OriginatorOrg: intel.com

On Thu, Jul 03, 2025 at 10:17:12PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The subtest sends 33 packets at one time on purpose to see if xsk
> exitting __xsk_generic_xmit() updates the global consumer of tx queue
> when reaching the max loop (max_tx_budget, 32 by default). The number 33
> can avoid xskq_cons_peek_desc() updates the consumer when it's about to
> quit sending, to accurately check if the issue that the first patch
> resolves remains. The new case will not check this issue in zero copy
> mode.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
> v6
> Link: https://lore.kernel.org/all/20250702112815.50746-1-kerneljasonxing@gmail.com/
> 1. filter out and skip TEST_MODE_ZC test.
> 
> v5
> Link: https://lore.kernel.org/all/20250627085745.53173-1-kerneljasonxing@gmail.com/
> 1. use the initial approach to add a new testcase
> 2. add a new flag 'check_consumer' to see if the check is needed
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 56 +++++++++++++++++++++++-
>  tools/testing/selftests/bpf/xskxceiver.h |  1 +
>  2 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 0ced4026ee44..a29de0713f19 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -109,6 +109,8 @@
>  
>  #include <network_helpers.h>
>  
> +#define MAX_TX_BUDGET_DEFAULT 32
> +
>  static bool opt_verbose;
>  static bool opt_print_tests;
>  static enum test_mode opt_mode = TEST_MODE_ALL;
> @@ -1091,11 +1093,45 @@ static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
>  	return true;
>  }
>  
> +static u32 load_value(u32 *counter)
> +{
> +	return __atomic_load_n(counter, __ATOMIC_ACQUIRE);
> +}
> +
> +static bool kick_tx_with_check(struct xsk_socket_info *xsk, int *ret)
> +{
> +	u32 max_budget = MAX_TX_BUDGET_DEFAULT;
> +	u32 cons, ready_to_send;
> +	int delta;
> +
> +	cons = load_value(xsk->tx.consumer);
> +	ready_to_send = load_value(xsk->tx.producer) - cons;
> +	*ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
> +
> +	delta = load_value(xsk->tx.consumer) - cons;
> +	/* By default, xsk should consume exact @max_budget descs at one
> +	 * send in this case where hitting the max budget limit in while
> +	 * loop is triggered in __xsk_generic_xmit(). Please make sure that
> +	 * the number of descs to be sent is larger than @max_budget, or
> +	 * else the tx.consumer will be updated in xskq_cons_peek_desc()
> +	 * in time which hides the issue we try to verify.
> +	 */
> +	if (ready_to_send > max_budget && delta != max_budget)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int kick_tx(struct xsk_socket_info *xsk)
>  {
>  	int ret;
>  
> -	ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
> +	if (xsk->check_consumer) {
> +		if (!kick_tx_with_check(xsk, &ret))
> +			return TEST_FAILURE;
> +	} else {
> +		ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
> +	}
>  	if (ret >= 0)
>  		return TEST_PASS;
>  	if (errno == ENOBUFS || errno == EAGAIN || errno == EBUSY || errno == ENETDOWN) {
> @@ -2613,6 +2649,23 @@ static int testapp_adjust_tail_grow_mb(struct test_spec *test)
>  				   XSK_UMEM__LARGE_FRAME_SIZE * 2);
>  }
>  
> +static int testapp_tx_queue_consumer(struct test_spec *test)
> +{
> +	int nr_packets;
> +
> +	if (test->mode == TEST_MODE_ZC) {
> +		ksft_test_result_skip("Can not run TX_QUEUE_CONSUMER test for ZC mode\n");
> +		return TEST_SKIP;
> +	}
> +
> +	nr_packets = MAX_TX_BUDGET_DEFAULT + 1;
> +	pkt_stream_replace(test, nr_packets, MIN_PKT_SIZE);
> +	test->ifobj_tx->xsk->batch_size = nr_packets;
> +	test->ifobj_tx->xsk->check_consumer = true;
> +
> +	return testapp_validate_traffic(test);
> +}
> +
>  static void run_pkt_test(struct test_spec *test)
>  {
>  	int ret;
> @@ -2723,6 +2776,7 @@ static const struct test_spec tests[] = {
>  	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
>  	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
>  	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
> +	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
>  	};
>  
>  static void print_tests(void)
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index 67fc44b2813b..4df3a5d329ac 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -95,6 +95,7 @@ struct xsk_socket_info {
>  	u32 batch_size;
>  	u8 dst_mac[ETH_ALEN];
>  	u8 src_mac[ETH_ALEN];
> +	bool check_consumer;
>  };
>  
>  struct pkt {
> -- 
> 2.41.3
> 

