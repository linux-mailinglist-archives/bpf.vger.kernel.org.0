Return-Path: <bpf+bounces-42779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F29AA28A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 14:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A94F2835C4
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B199619DF4F;
	Tue, 22 Oct 2024 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UAqIUHtX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EEA19C560;
	Tue, 22 Oct 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601734; cv=fail; b=cqERGX9zY4dfHI9fTFOL8o2SKfE+bCU7An8uE9aStYLYY+50DCKtFaca+DEyaYKy9SnqlZ4p9QA56i2a9+pJD7ftndKm3m5lLZBb0Fndm+CL/NjfGTajjQwJLhVVFA2vYWNyYEQG6rGFQ5XD1GEYkI8LTymTLyPfCJBqYK6Ckb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601734; c=relaxed/simple;
	bh=VdcqqsheEXAoQIIy+1ld3p6/VK3+4mSkxYMvxLc3g9w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r4o0vsXmdOn3TfXPhH4JpRnU8TXHywkIvvkCVejQXJ5FwJ3zdwWPbr/FhZiZJZIU1OVdC/oEEt7l/ytEUx7MUOzj9ugPY/pLDy/6iV0yBPdjZkzUUe4b/tRR+wZN+NlKTL8o88AXPq5oT7O3U8fxLxXBo0N0U+8BXWkWdiz/WcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UAqIUHtX; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729601732; x=1761137732;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VdcqqsheEXAoQIIy+1ld3p6/VK3+4mSkxYMvxLc3g9w=;
  b=UAqIUHtXkH1Xv17lKbGx0ikSuWV16vPixiDCmqL7TEX6na87wokJZnet
   +AN7M8jrIYjf7EOzG9qQkDzvw/xArDZGDzl1elhHhF7u4IQE4kQ0icjck
   fvNeJuRwhk+GGhT/6BHCNuwE5q7WLgjs29YDjuEmVwpgKVqGwbRcbxqPI
   +NdcB8q91YQH3KvHS+lnL5rzHzeL9SVOJiI6BpNRMYygmgEXLoC3HW3Lk
   ARxnERMgIKb7CzV7N/t+qmsaBRFToT8aTQX6MmDMCAKO0E4UvEIq6+rOY
   F/ENSjl4YtnyD2lyF2SRSjGiJyDAx3MVfRzAWeaCgq2d7YT8mFJyQXgHJ
   g==;
X-CSE-ConnectionGUID: ohjTOpkJQxGMaA5zVdOXrQ==
X-CSE-MsgGUID: Sb3XqNlERxKbZoMTU5yUkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="16761156"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="16761156"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 05:55:32 -0700
X-CSE-ConnectionGUID: 1pWtoXFCR02j6p2CwtAfzQ==
X-CSE-MsgGUID: TFVbzt3/STanFLTfsYV4MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84940693"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 05:55:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 05:55:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 05:55:31 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 05:55:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ky2Eba+ssKZKZK3GYoGFEBnyINCpL+LKJsefd+SP8ZKCeSGDpBy2haK3qpOz9KLcsTLfl7WkLbP+YoRaPLWJLWT+W4HvCRK+H3to7Jc4kz5M6rfRBjfDdF6eYVQ0eXlKZI8jLc7bnALFKY3kACtb26wWnwAd+guqVjE1jfWDxQunAx8Y2CbGgL8/WI9d0B8+09E6fuZH5ANXEqHjvLa533iPebfh8BbNEPbbA8ONTIvJYlrbT3s64dFqdoLeDe1I4F0njvi2BHkFBFwW+SO3zsSpnbRYLYRVEBc8zFZAzJ1/YDDuTbrEGYByUdQiyh0vL7zGtXs4+z2H9862JCUQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7ep4zd1LycaOghBTeSZH+IcHnMIFnsoHfOAW7JBEmk=;
 b=mLH4CBxiJAWnyhEU7iVVqEVlwinYBi3uo5f9+NM4JA1Lb2E7Spaxxuvf6F1ciOgaza0u4vq9c3oI5jhh7sdd86xS61KLK0VKtjhzy/ATG4+oWY1i9cjCfVEraGpy9utbr6w37kEKc7dlp6DN4bnjgDhuBeb2ptu2LBu8JjP/HkhT7aYyUqWmsxZ591MC7z1O49ZQdszPgLbGg9+/zF0MK6DBv3Ez41ep5p8sqnMEuMCVpdTzPR2jn4HVkTG3Jh+uu/cw3UngV8ROSgw42Uf9zYDJHn4geSXgAA2vFhipLjXNRa+HM4VtMZEEeqJXf2A9WxZmEgQqfeMFuTfof2ZAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB6446.namprd11.prod.outlook.com (2603:10b6:8:c5::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Tue, 22 Oct 2024 12:55:28 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 12:55:28 +0000
Date: Tue, 22 Oct 2024 14:55:20 +0200
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
Subject: Re: [PATCH net-next v2 04/18] bpf, xdp: constify some bpf_prog *
 function arguments
Message-ID: <ZxeguJL4xV84+I+/@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-5-aleksander.lobakin@intel.com>
 <ZxDxNisU45KrF80e@boxer>
 <8d1fe1cb-5f20-4a41-87b9-65adc6aa5414@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8d1fe1cb-5f20-4a41-87b9-65adc6aa5414@intel.com>
X-ClientProxiedBy: WA0P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::25) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e2248c-cc8d-4def-7ef1-08dcf298cdd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r7WR/0hXinc+r7yRdA5FPZMQNvI5bksFZ3gOD1EtE1zLbQDrIfBzRWYl8fLn?=
 =?us-ascii?Q?5hE/Z3fzBQlqzprwr/4g6M4fmwJXbuaXEAEDbi6VVKQPqWdwSyEvLsfizlLb?=
 =?us-ascii?Q?lvZwhH4JXGIm46JW6LVUDzEaltBCTerwXIqGOBrMO43dmX6mJepW2RAJeVDf?=
 =?us-ascii?Q?qx68rBQRsRJi0T+uhYnFJOHHtO06NbT6yGZIf1MlKsHwYivUl7fFe8dSzOnO?=
 =?us-ascii?Q?5Vut0bhTnws11aJqNXzs+JirWK308BOexAuYSetbGHrPQSOCgAs8yiet0qym?=
 =?us-ascii?Q?sIdB7qdgyAMLcTFg2yVhPpDZL2i0MwqSv8Q6jTVJqxnOd5Gl+IyiO25CeOXc?=
 =?us-ascii?Q?y9zY9N3e3KF1thviwI0YUz+MwIcrI/zHHHFXTn10qVP9jp/Zfe1BjloJHKIW?=
 =?us-ascii?Q?HIpgTbfnxRHmGO9lwkzpiPP3yWShIlCVwrrLKv3ktU1AEI5xi63XuQ/kisVD?=
 =?us-ascii?Q?frni4d810lOjAwhFo6ZgeT7c/65mi3BvJelgL0acnrMlCbNw3B0w9/dGQQey?=
 =?us-ascii?Q?5xj7wOGUYVIAvl4uqZQJwhr2WxgxZUzpMU1DfpmTmlDMfnE4LSRnxUmy90nc?=
 =?us-ascii?Q?s2eGMAmDnyvfzc45hDcu6XJaWTHMWEjC4Spkje6LXjzvM31MTpEQcWuuqQbY?=
 =?us-ascii?Q?eyte3/QLdPeam4kotmWNGpPyJyJNmgus+AoeXggeWki9wGTf6hjzmJ8lX+yn?=
 =?us-ascii?Q?0NfKXUrXhC+W8LKCjCMazfNIsPKkClSqtUOe9tFqqemmyZGQoymXah2Ic5rx?=
 =?us-ascii?Q?y/tJxDDXvlwmxVnlzeFxcF6i0DerVlSnrXu8rVTmpmUQtA//W3DQKA9A70wt?=
 =?us-ascii?Q?UwoDrqnZSUqdf7Hl+WUMFSXw+/PzTx5TJGHQD48pBQEb9TFAaTkSd0d666Kk?=
 =?us-ascii?Q?1WE7SgLvwKZpHVP8yDTgFYHWE9MbBPZeuJbbsaKnyCLG+NFfACgVMGiiyF6v?=
 =?us-ascii?Q?3ZNmz7agNDjEKbT1h4bDn+729drJgLaeFufX1CVrFIzD6tyK+JweA+vODD50?=
 =?us-ascii?Q?blLF4B4/fRmqe51GLEa6zKrHPe1bjlQbWsCpDsgXHz+X6PmomIQPDAmaRrsP?=
 =?us-ascii?Q?e3rLcN+LwgfUhpH85raAREIksG/ecNGjUA4vd0pp8Ttkhk+OYaqhrJk0wiZc?=
 =?us-ascii?Q?OAEox8zQECJ9zjHRH0wKMnnmsrAm3wU+l5OpMVMKe2rSWFv+eldehAxuyigi?=
 =?us-ascii?Q?XlWA0c4JibgjR6qkxfRaZL/j2tPg6D3Tokan0SypAoDmBhwJ/qbFQFdVO2aH?=
 =?us-ascii?Q?StubqbzrgZLEFWB75dch/VnULme/bR+jw7FlULodX+7THEtphU0THPihNriG?=
 =?us-ascii?Q?+UgNjWFr6dRo6WUlIywIR1OT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DArEV9aG3dxiT/Hqd11hMnwm+WEDqThPVh/6NKb1l6t9bke5bnPN8STUWM9C?=
 =?us-ascii?Q?bM5f8VsMqm9edt829mSy/5RB/XjWTNMFESsku1WUx4kT/SIIJ1PZ2gJOKBlg?=
 =?us-ascii?Q?PSL8ZceAQdmKhDjuNnijShnA0XxgNE6Rw5aX/dVzTWEFnCUC4CYQgG12jPd/?=
 =?us-ascii?Q?IUo+uZ50L1cgvvAx1xxg+m3NK1ZSyo5EDEB4/943weI4qA38GnIo73XmThWI?=
 =?us-ascii?Q?CfHKsGNG3epRzOl2zU8zar4blub7b7d+jiL+uftGhk30kJ1EpmtW6OIxIow6?=
 =?us-ascii?Q?bIZ4kOcG0YrfFTtxQYR1bpg09JOs8haov8dTg74fjNTC0uky6vmuZHNBap3m?=
 =?us-ascii?Q?ZAMuaTxEW6CvJpV3u02T3T97NB6BJYew/pdFVJsY6K+CpwaInM4ka5GV0+Kr?=
 =?us-ascii?Q?t3gNf8fAYRd05RdyUo6AA9bXT47sp2U1fhK4i/Mgy6DejqVGGkrAMzSQ6/0Y?=
 =?us-ascii?Q?PlLRLRL0qrbIsMs0cOM7XKv0TxLIdTpIj0cOJDYe1sKqNKMIst90kyJrDPBt?=
 =?us-ascii?Q?xbT3f04Wnu7fcj9mXIDf6CodtNtvb834rUaHJX5eOWQJHSieMi+/IgmCFVmF?=
 =?us-ascii?Q?fZrOksRhHn43WM3D9WBdfhsTTCgDqPjhIYmBqJxnKpAbvhXeXow95Y5VgIv/?=
 =?us-ascii?Q?ssrP3uccR9ytdicBLOcciYf7uC0JfMosmKzhbdPKntXogEisBHCyPaZWfs4t?=
 =?us-ascii?Q?3knHSwO99ElzC7mzbCLt9fUFy5ntfNtuniKH6Lwyg1ynz07xT5ybduefiUt+?=
 =?us-ascii?Q?MpTOLBE69bB26tU3kl/akUBAjG1FbpqoQHWDkNMFXa1I7Jo2eYleNLjstP06?=
 =?us-ascii?Q?PfbsQdX/uJRFpDT18qU5pebWVcg1zhvliydftcZLmRH8fott2hZbgbS9tQyc?=
 =?us-ascii?Q?xjlrkyPGXix2/8BCgiPzWMaf53jPHSi2YWhU12XJSJ2sjnKsYJx5LNAolZA7?=
 =?us-ascii?Q?eVXdctWcsciMNIrpaetyPx0oOzIUtqJtGm+S2/2AjGmG9SxqufZ8sCx044ZH?=
 =?us-ascii?Q?6zAQrvhol0Ekj+p/yGZI6B+LSWAJFp/f/X+uZc9Oax0XrA0WmzvVK592mNBM?=
 =?us-ascii?Q?rqI2YuGpKnQ2ZoumHSqa8g6NNJ2MQf6XtU7jvyBl2hWjQbf6Tf5LzSkM4BXB?=
 =?us-ascii?Q?HPYtt4XOROZrQqsTcYcSznJgVrCkaPNyWy5nEj7jtz3msYzaMJ/NexNhq9PZ?=
 =?us-ascii?Q?NwU+2QpcRvC+pzEhqP1iPjSIbyqUQeHnCst1Ceaq6425F2+sbs80nxas/Uw6?=
 =?us-ascii?Q?b9K5WKjn9eX84skAGvEUs2mWK8Je1EWp4+PSeKRokKVyi3liLDibLKML5wdV?=
 =?us-ascii?Q?mV+j0+IFMrA38UoHkDN2/dO+lanEiA6POOIIGIX2amvE7MT3hSsTVTKCyUfK?=
 =?us-ascii?Q?eP7mWIJQ/1ljtmc+DexldLhuh3ZAQEM+nIkKOzLzYwdsmfH6Gdm6RcQQ5ef9?=
 =?us-ascii?Q?SnRgoeNXPqrUXqpOF/YXaF+Vj6xhJ8Xbm982NEyJsEmRBxo7zQHU3beSNefp?=
 =?us-ascii?Q?AQmfYlk+a586AAUKF45ZV1i+SywpFVVm/TTeZy7qXAMbxiByYEnZp929Lk0o?=
 =?us-ascii?Q?9/1APR7BwHvkWJvCanISCuPNUPLD+pG5WUV5JUByo+tnYWyWdP+l8ARrMZ2g?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e2248c-cc8d-4def-7ef1-08dcf298cdd5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 12:55:28.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muqWPWXnCw1SEsxXbH2OzqKX38C1YCcQIuKIm+/I21c8SFWNyHH1/uUFnI7Wy5M5hy0JGH7KCcFe/EX4TTr4JL+bNf1omIFYxuPCM/r8iUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6446
X-OriginatorOrg: intel.com

On Mon, Oct 21, 2024 at 03:56:12PM +0200, Alexander Lobakin wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Thu, 17 Oct 2024 13:12:58 +0200
> 
> > On Tue, Oct 15, 2024 at 04:53:36PM +0200, Alexander Lobakin wrote:
> >> In lots of places, bpf_prog pointer is used only for tracing or other
> >> stuff that doesn't modify the structure itself. Same for net_device.
> >> Address at least some of them and add `const` attributes there. The
> >> object code didn't change, but that may prevent unwanted data
> >> modifications and also allow more helpers to have const arguments.
> > 
> > I believe that this patch is not related to idpf XDP support at all. This
> > could be pulled out and send separately and reduce the amount of code
> > jungle that one has to go through in this set ;)
> 
> First of all, this series is called "core code changes".
> 
> Second is that without this patch I simply can't introduce libeth_xdp in
> its current form, as in some functions I pass const pointers, but here
> they won't be const -> compile-time error.

Ok, but that is just related to your vision of libeth. From my POV it
would be more convenient to send such patches earlier which would reduce
the size of set. I suppose this patch has been rotting on your branch for
a while and you could just publish it earlier and keep on working on
libeth in the meantime.

> 
> Thanks,
> Olek

