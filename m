Return-Path: <bpf+bounces-42300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006549A224F
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 14:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2486E1C225E4
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37C01D31A8;
	Thu, 17 Oct 2024 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xsvo5cV9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185C1DCB2C;
	Thu, 17 Oct 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168494; cv=fail; b=K2GQXgnFOJ5gC5wxvBkfLa418UrzLTNJqK01pbbXOiyS7dqrXwRHHbWK8izak/2a4ubzrbvzagAhgUQPdfD87KE5C6Fre4UzU8HqgX6SN4tYYgrj3vX0w0w/iyxgBZqZqkA/hqGL8Mwz9n9DXzviyYbd+6kS/Z4fmox5cwnUEig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168494; c=relaxed/simple;
	bh=7eULstNVt1FZNu69AehHoFk5AO1T6i1gHsD8gKetXBc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H+I9/duwO2n6Ql8iOEaNbyMD98CwMr+kDsYW3CKeUJStZGXPSxNqJvWTJ5OgLypbegGuDB5uo/YWC78Y5ptJ1PvzexI/i6BZhOYcpvpk/1OdpOwu14X5AJLinp0uSCeHqm3FaTWri5RwPvk/7jLoTzbJYaLXw193tCofyVqmTD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xsvo5cV9; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729168491; x=1760704491;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7eULstNVt1FZNu69AehHoFk5AO1T6i1gHsD8gKetXBc=;
  b=Xsvo5cV9eCqU3ZBw0OosctXZdtvhTApo+jISmBUe0oMF9RDRcwCiDmU5
   C6XX0fQHxTfeU32ecBQN8YS1c1oRZeKq+5fvMXQIZ7aZHh5CSMaCyqT2s
   LPMC3Ci/M8O0+4BWfZFSpBv8pjK7plnVjuchce3km1UWH92sCUGpbZGbv
   6hMjR8+181KQldyLckmlqWe5OXI4mWHyipx/GZLhNA5iSV+0K75KDrc/m
   xmY9dXYsT5+CVUXkrkoutWiAqNPYrhSeP7j4GQNSjhNGoq/HNahIK+mH9
   OKkuePF1/4s6R/xh21mpxHYFeX6Q52xoOtjfgY8GwDzVnq2mUm+yea8sn
   g==;
X-CSE-ConnectionGUID: 1UTHK2L9T82dCZalgjB0nQ==
X-CSE-MsgGUID: AwNTXYTLRGuuKGBmK60ckg==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="28856917"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="28856917"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 05:34:50 -0700
X-CSE-ConnectionGUID: 3B4ZbYcZRCubV7aXdMND6w==
X-CSE-MsgGUID: pCkcfNJqTiSrhL4qd3BvVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="82500295"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 05:34:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 05:34:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 05:34:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 05:34:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 05:34:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/Ex9BPTqE1LBogtqiAjl35DEoRZkZBQZBKzztF19AbGQI4HkFn1HPBBf4OfLebH625VwtL1/TD0AQDCV4hLeVJwvBq6LLPo4fsZyrMYccQcYfhEZfW106yqCcndIVpZEZPAJCr6vc9qhBbAoJ3Cgn/6OUkyIG4YKB6dVqI0HljwTm46raUq2b6obV7NixeIATpZ7xYq+AIoY233DMg8SRFzlYzuyyLGR86VS31F9ifDF+6Sa2+xUqZv7ViV3Dus4MkwA0qJM9JKPvY1efzY5gfZ3DeYXPq5QLgCVJlsuN2xyXX2naxa2pNhCVg3N/DjUDab8asxTwsCnWCU6IDw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp+nOou+A6p426GWQ1Y6RLDZj7xbySJ2cL7sKJeRhBI=;
 b=R9eyQ8Vzw7UjjjalxGI2hJ3/pWsFq9UthS6NcgfqGiN4Ru1XFpviq6HhGVr/8H83RHDwnJNTHeRnKvSNQQhu1er+D+XH6IBCe55036aNVXcb6NvxT+0Aa0ML0kq9T0p9HgS24Sn2m9kTOHALLZ18sMM/itTihpsd0N2zmgX17lqk4rtCb9vq7vsbcVBVNFEeVP+y4w1lZ3bYZYNbZyNv9kd1NxOIXGXBa/EDNUCjvHHBXYsaaXBl+WUEzBWgpm5MDcuF/IyZXcgeFVCLTN6IDPFxIkSzRzbh0kno8POE+i/GXr5TXJzqva8jUwib9Rz/qp0PPYCuKRdbEEEbxdGN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB7594.namprd11.prod.outlook.com (2603:10b6:510:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 12:34:40 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 12:34:40 +0000
Date: Thu, 17 Oct 2024 14:34:33 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 12/18] xdp: add generic
 xdp_build_skb_from_buff()
Message-ID: <ZxEEWYWrUxFh33xD@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-13-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015145350.4077765-13-aleksander.lobakin@intel.com>
X-ClientProxiedBy: WA1P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fd625e-4e3c-4732-7f23-08dceea81208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nmgIkubvLL/tEloUKQlbynu+tXYndTWAJpanzQtdvcI2o60DgwLIUzeBga8P?=
 =?us-ascii?Q?zWqQWBt5qwPM0xCZ11UUMZb8UBERXlnF+NScb0cZFQab6IrJ5UgGG20WxAqT?=
 =?us-ascii?Q?ssRZIKS/jQa+z9eye2ZAudITeDhyZGafIAdRhmCOijnaS1tMfI+0oDh11tw9?=
 =?us-ascii?Q?a/5Zy+ZT64KAjX+lV20BdNvEHePTOJNj25Sf5h6vfRb82I5/2IYQ1Tl8LlAL?=
 =?us-ascii?Q?QK0LXxdnlYzHM11KTeCW1Ppre5P/7geQtrUV8CAylozbTI/wsxo58Htufcj6?=
 =?us-ascii?Q?GrYATqfscQq6zq4/fbl5jPu1ZEYjhiyTrhuqpeWqjsNRYwOwqNHI3PkFZqbr?=
 =?us-ascii?Q?9u2WFta+E0XVegFEBmI6y6QQICXqf8wOhrIx4Ez4vUSw7pfw4aqr/9BVykrv?=
 =?us-ascii?Q?2EQD3KBkLrtxU5wIVwo3yVEs1cUSHlIOID+73gFm25G5Gb23MkpcWYc6SGPv?=
 =?us-ascii?Q?SQ5eSjlncOiA1I0A3dDl99CLeVH4LT9/SswhAPglrU/HaNfr3tolnYI40BbV?=
 =?us-ascii?Q?aAu2sUx77QKrbg9uYwY1qOHaj9pYXf4wVtlnpECHRb2CmCx4uh6yg+ughp2N?=
 =?us-ascii?Q?hFmwTCh2qT822j9WRkg1eeKMF3XoCHyn3dDLQxpgN/0gApDzBgwfxfcE2uV6?=
 =?us-ascii?Q?gAn4wU0m4khbEVfKzVpdfPf45bIIbriBpghvqkK3/Hy35fPD94fiq/cN2WLm?=
 =?us-ascii?Q?DrVjQmUnPmCh0MO85N38GLxwTBlHj5HFcEgJkjyXDoJNMCQ26O2l+LUo8SkK?=
 =?us-ascii?Q?yOzzpfEa2eKmMjmXCMCkuyvE7knzTWt7V8+njtWkuIPKSj4H6sCkELFaY75a?=
 =?us-ascii?Q?Dymn4po+51oetCBPEHj7tBafRPQ2G8Fd1A2/3BVx4J5ytHhDiS3RSdz/leGk?=
 =?us-ascii?Q?n5kfLbGeErrryq0VC2FAgzXfvNxsPRfVCRiELxTRJdmefJThY2v722AONV3Q?=
 =?us-ascii?Q?OIuWbscq08UPITen5bExMUbAZOel8w7egrVLl7bJyhGXhP7/55G26w8hJuGO?=
 =?us-ascii?Q?eLBm1jOPEi18n+4bccBX9PC1DLeAze+uIoOcUc6RblU/76WPg//lBw6Dv1Rn?=
 =?us-ascii?Q?6KvKoPxI5m5aK52h5IOch8TfxoWEMXR9f7ZVFWjmiZtmJeRduaBapG5LzQi6?=
 =?us-ascii?Q?68IrAf+JuSAumLZWmdPWSR/mh1QF5WHkIiJlTR6LAwo68JDvJiPsncJCCfQ9?=
 =?us-ascii?Q?g2YSa4NIF4Ir8Eh97Mnj47sdIuv5DMP3g6Tdrjc/IQjsKY7hqtlMTpOpeoIb?=
 =?us-ascii?Q?erDIFGiBmErchYLglJJdEjaU/trPWgenv+KDn4Jh9qxyIdHJIaZpcIYo5PE8?=
 =?us-ascii?Q?O58=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sSDLmrONaLFwsxzdb9c2jxqpGUQAzb9FO9vPN5ConoDavEJEYhSuLwGajDb+?=
 =?us-ascii?Q?bkcAiRFG9NlwWlwr6oX0E7/dJS/QYoB2/DJREjf0go1OddGblGSmr7gu0NSa?=
 =?us-ascii?Q?u74v7EC8/3qlFfchxLKEqwgemvyLSrLfsrEj/JHLclhuie2qPNu17/kC3A/h?=
 =?us-ascii?Q?L9wn31t4s4H3yY47/4nP9Ff7Y1r0ulXltavIgOKFNCKaPUiGbAozs2K6n3O0?=
 =?us-ascii?Q?NoKWt/hbyq4Ari1rxercEvmb+6xN5I9mY6a/HkBztje/iZC575TgU/rI2M1D?=
 =?us-ascii?Q?MORxY3snvqkcJK+gcIv9kjSX31m/iJyFi+W3Daumorp3VWsKzyeIf6KznOZF?=
 =?us-ascii?Q?j/YFFqjTlJK5yMbs7l0o4+Kgo6xFe2dalRu8A0cvW9FdwA85iSy4Y2MzDzGH?=
 =?us-ascii?Q?va7rZgEhBIHJSORGQjajZD6JE4kFipm9MhV8jqOc1O+mG4tK+CngJgxDx33D?=
 =?us-ascii?Q?n7bVn8aNBMJNiyBqgqvDOxg3tPgM/NLbpi10jeGsOCfasI71DWRWqkZvYGUq?=
 =?us-ascii?Q?ZgqUvALJRVHp73lwznKA99B+uPvO0t+pIapC8mLciu/xLVFqw+irRu1Q599m?=
 =?us-ascii?Q?b2SqrYC8GL9/duam4ACipq+CSf3pVowhow5giFB0ZvZ16BODIhtrb3g74YeB?=
 =?us-ascii?Q?31izUYc3n+zSH7fjS7mkT31yK0LT6vX4Osp9DGc5Av+t7wnKBR597uwwrwnE?=
 =?us-ascii?Q?bDJsyz69/KRmDFWJEe12NS4WB1BhDrG93RCBDV6NayMc2LGhjDeJD3nnWQWh?=
 =?us-ascii?Q?M1o932BJn8IjEX1Z0A53v3blxW1sXw6MZPkl36yzDrDeKbhEe6FFGdWglB+o?=
 =?us-ascii?Q?e+HBU7QvvFYAun8ziXFWyF4PvCwVOiviOgy30llVFA22bQ1efcTsNxYvG1zn?=
 =?us-ascii?Q?CggGepQZMOXpDL6MDhVCIw53/S0GE9CsshmmxGuUnCnycNqoQ96p+oSpy+C6?=
 =?us-ascii?Q?Z3HLIcAfnWk3isvDc+7fYKepEulc/Jb6Y+4LwuocDIMivK43Yqu+3I0JGzpj?=
 =?us-ascii?Q?fAlo+ucd+TOlHmfbs0nNoSWDahah9F6djoXsktfFVouA0alAXiB+AslGdJUn?=
 =?us-ascii?Q?l53MK/kLHXJesRbcFa8LFV853eWGpqA91VO6Nj+cdHzKCiuXidlDdcZV5F6l?=
 =?us-ascii?Q?gEghyoOnmHVxkUTU4GZAVVJX4gn+fUY2or1yvkLoKnZD0P7WStIurejy/CWk?=
 =?us-ascii?Q?Su9Qa7hWHhpXi6h+rd3Vge2/4B0f/mqdTkC9SExtMpefTyi45PH68qelCa9g?=
 =?us-ascii?Q?+GWtiZ0b8dbJpvCpkBaGp5G5958XQCNcw9JsMV2p6UP5PUnEYp3SsiZN8T0j?=
 =?us-ascii?Q?N8AzqrKCsw94YUORfDe4/5n8iRfcUg47RdtSoC26/83VTxS+7ge2KCEKXuyN?=
 =?us-ascii?Q?7HJZXCP1///CxpIBGTSIpjqiBLmpreFQsdqUOsTprP2pxtGpXPvsj4ZZWzk9?=
 =?us-ascii?Q?QL0t0JEMLC59U+GYkEVWLnliP6oaunrds3FmdYX1oW6Z4N4Xbtmw0TDIuoKU?=
 =?us-ascii?Q?bnF4kxm7qiJ0YLyP9mRU2Mw1GH/fJ/HkLZjA9mk8ERPbLBAUfPk8+0qLuJrZ?=
 =?us-ascii?Q?avGR6FS9cxaiRQF8X2k8ciPOQGwFmmoRU+udHu3wBcCbKjWIUpqif9jx/gzV?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fd625e-4e3c-4732-7f23-08dceea81208
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 12:34:40.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFP3JIGYMo1VawB/Xo6NZYLu+EL2dk2BiJBzVjoa+FArOGCv2bn6CHGgtgYQOrcmFFW7XAm0TG0pBA1uDLy+KCmzVtedvsjJBX/yt/fdiZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7594
X-OriginatorOrg: intel.com

On Tue, Oct 15, 2024 at 04:53:44PM +0200, Alexander Lobakin wrote:
> The code which builds an skb from an &xdp_buff keeps multiplying itself
> around the drivers with almost no changes. Let's try to stop that by
> adding a generic function.
> There's __xdp_build_skb_from_frame() already, so just convert it to take
> &xdp_buff instead, while making the original one a wrapper. The original
> one always took an already allocated skb, allow both variants here -- if
> no skb passed, which is expected when calling from a driver, pick one via
> napi_build_skb().
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/xdp.h |  1 +
>  net/core/xdp.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 19d2b283b845..83e3f4648caa 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -330,6 +330,7 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
>  void xdp_warn(const char *msg, const char *func, const int line);
>  #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
>  
> +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
>  struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
>  struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>  					   struct sk_buff *skb,
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index b1b426a9b146..9dc103a09b5c 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -624,6 +624,61 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp)
>  }
>  EXPORT_SYMBOL_GPL(xdp_alloc_skb_bulk);
>  
> +/**
> + * xdp_build_skb_from_buff - create an skb from an &xdp_buff
> + * @xdp: &xdp_buff to convert to an skb
> + *
> + * Perform common operations to create a new skb to pass up the stack from
> + * an &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
> + * skb data pointers and offsets, set the recycle bit if the buff is PP-backed,
> + * Rx queue index, protocol and update frags info.
> + *
> + * Return: new &sk_buff on success, %NULL on error.
> + */
> +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
> +{
> +	const struct xdp_rxq_info *rxq = xdp->rxq;
> +	const struct skb_shared_info *sinfo;
> +	struct sk_buff *skb;
> +	u32 nr_frags = 0;
> +	int metalen;
> +
> +	if (unlikely(xdp_buff_has_frags(xdp))) {
> +		sinfo = xdp_get_shared_info_from_buff(xdp);
> +		nr_frags = sinfo->nr_frags;
> +	}
> +
> +	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> +	__skb_put(skb, xdp->data_end - xdp->data);
> +
> +	metalen = xdp->data - xdp->data_meta;
> +	if (metalen > 0)
> +		skb_metadata_set(skb, metalen);
> +
> +	if (is_page_pool_compiled_in() && rxq->mem.type == MEM_TYPE_PAGE_POOL)
> +		skb_mark_for_recycle(skb);
> +
> +	skb_record_rx_queue(skb, rxq->queue_index);
> +
> +	if (unlikely(nr_frags)) {
> +		u32 ts;

nit: spell out truesize? ts confuse my brain with timestamp TBH

> +
> +		ts = sinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
> +		xdp_update_skb_shared_info(skb, nr_frags,
> +					   sinfo->xdp_frags_size, ts,
> +					   xdp_buff_is_frag_pfmemalloc(xdp));
> +	}
> +
> +	skb->protocol = eth_type_trans(skb, rxq->dev);

could we leave this out to be set by drivers? i see in ice for example
netdev ptr is retrieved in different ways here.

> +
> +	return skb;
> +}
> +EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
> +
>  struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>  					   struct sk_buff *skb,
>  					   struct net_device *dev)
> -- 
> 2.46.2
> 

