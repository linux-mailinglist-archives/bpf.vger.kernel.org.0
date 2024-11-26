Return-Path: <bpf+bounces-45627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF959D9C19
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 18:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E50F4B22FCD
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE931D9320;
	Tue, 26 Nov 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBk8sMPG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646EB1D8E1E
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640786; cv=fail; b=BJpm8ALvd9zZloswiyty26lURAqgGvULHgbO22zbsnU9aJQESJopaILbRVqFd3ZOShf2IIxc/Gzhf0w8hbG3NNvxpUAI/OGx8cCmFlka649vfHK57YQfSuqwJyy29pyKh9mc04MaahdJo6tPB/P2XVVVNDQrmu806qcXoZ7MsUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640786; c=relaxed/simple;
	bh=vDPhUsxvfGBcAGCm2hLORXYSsDhXYv6lEYgIRUVa7ZI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=c1KWn3WgJrg3OtrBnkTQz0KwR+Np0guWdGWgd82m9trP71xF7AXy5OR872hh8MjzFuQ1o1AwPu/hSz64M8mLLiTvWYu3oZLiYyW69T7d+olLal9i5foOU1FycW9Y0Z/Zvoe4NPTXpYm1ZPiGuxNWW1PEoJLU/LBDkURkcUb61p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBk8sMPG; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732640785; x=1764176785;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vDPhUsxvfGBcAGCm2hLORXYSsDhXYv6lEYgIRUVa7ZI=;
  b=EBk8sMPG0VksWu/XgOtuJqkLRFClAFWazWWxfoa6JSfAKUqrjTy00h2E
   p+5/SKYFAgviz4KPwv/6wtLGDOYQMK+An1Xt4hMZvxZdT6bLK/50fbQGl
   t+V6+uaF2snRZggfRll2pSqMC8AoRtPGzKgH+gMpjh/hHex2bQIj4b+3h
   yNzKhuj6lBvBvSr42jWs/amrSSyX3M43kXtW2e/4OHF3pkSS+7+nt/r+Z
   o6LK9K4dukvioGkFCmbZZx9VgGNCflPpk9e67GWr0JSDpIux57CF57nHT
   RQoEC7zmM8W25KklikKIZST1YcVcdyiNi5TQLR7j7gbixL00aamFD/jHn
   w==;
X-CSE-ConnectionGUID: a0bO47fFST6xYmW7+YetZw==
X-CSE-MsgGUID: 8sfA6iN4Spyd/5gUPx8xYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32670540"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32670540"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 09:06:24 -0800
X-CSE-ConnectionGUID: KDFl2aacQy6SZpKskFULFw==
X-CSE-MsgGUID: 2sqWAS+MR6Sx3qlgaqs2PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91562609"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 09:06:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 09:06:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 09:06:23 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 09:06:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPpd9TkHUNd34+8JbUNyibPWlt1XBYcOlIuutlps47mzCb+JFbFeSf8E3G1v467xHAE1guWJUtl1WFuAPCxdyNWuTyCxL+3QHROkt4sPdp2CWvLQrldv1lucB/wYIF/cKwPgMlwHfoweeulE9JZGj6Ku6cQnRy1szt/rFsKcLPXpkRbdyujcATUg06fMbywltCzuHp2ZwztRCqOCQkSsD8pH8zEB974GKZJro2fLeCGAKKyf0k35vH4zp9DuHICsQC0Vl3t9bGW+8S3G6zrpsFrwM0SPDJicUgHaet8vqgc8qbAgt0H43fzi3FWJXxaxrsYegq9jDC0JPG9t05pwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFnVHurnjT5vYDANAOEiv9qm/zZ8yeGvT9bwrkoWMSw=;
 b=x+OLn6tb02qf0+6oCGZ6Q6MqFQqs4Nwq6oHlCMxmqF9K/UbgEIVRE8DvV75kuvrdJOOgcl/Uag4pWTNyH0Ul4+IsoldCHnj6vmcvnRS5JC2w0l07BirH8VOrV9x9rKZrSKkcxEul5KSZH3AJHQaT1VN76tD4qmetBt7bIzVt+7ZzjmU+mR/VhNAgQKofNmjvZNHnEHyxE8+nN+NdCEryO5s4viPZKD1U4qM/FRcWx6fee9WHCdJIh3/WPIXWdHB1+SX6TI45ToohMUMV92aqbwi+FNmVzOV5SIrIOiFxW9K8zCyGrOOotPdTtmKefbzQWBzP/pbZ2NIEz/InNm2nyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB6377.namprd11.prod.outlook.com (2603:10b6:510:1fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 17:06:15 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 17:06:12 +0000
Date: Tue, 26 Nov 2024 18:05:56 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <bpf@vger.kernel.org>
CC: <magnus.karlsson@intel.com>, <sreedevi.joshi@intel.com>,
	<amery.hung@bytedance.com>, <ast@kernel.org>
Subject: Storing sk_buffs as kptrs in map
Message-ID: <Z0X/9PhIhvQwsgfW@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: WA2P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f29a73-497e-4ac3-4b98-08dd0e3ca125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YlitO12Lmgv7A5wL+6jVBPa9h/mJotWzXCtQj3svvjjNs7qzkZNPdoGlYmuz?=
 =?us-ascii?Q?9To4IqpdunKk8t8P04t4Ytp1pxsmknqEOl30BFXvH0lzCF9aVcvbv8rkW+FE?=
 =?us-ascii?Q?hjsD7i8XYLCO//WWfZBhbhS672vLT/ZV7R5qVmhd57j074duJhlbMrL0Y0Vl?=
 =?us-ascii?Q?qfWgpq2YvBYIAFxsgdwVoQRs0gara2dGRpZnO8omHhip0bod2uf3wxKURLM7?=
 =?us-ascii?Q?hFocBP1nSvon7/0Ga2esFz4i9cc661BkG9EeG3mOfSVWvMOtbWb5qzo1ytxg?=
 =?us-ascii?Q?RqyNRe81DSOziyCN2RCIMzYVtboXJouRhWMbS70ZzQtm3XGTBfWo/P6yf4DX?=
 =?us-ascii?Q?tcxFICaN4nQ9wWYvD1qD7TO6dJCaf1HtSg93Fzb8kSIwdLEamYMDhOIgae1j?=
 =?us-ascii?Q?FrokoIhUjA2g06kb+GBJIw+r/oO5QjsPFCFdWw8EbqGqaBlX3jKXUOtnkEce?=
 =?us-ascii?Q?SKgh8144AHWMxWecMXn7WmFZoVe/MZqhjpxSbZDp8JwJFoM7wC4rZstnl8Jk?=
 =?us-ascii?Q?L7T7FgR1g+M4Zhr16tFVU+x6tmd0FQGoDIglZ8u/bY57IDwx+Gm7HgIUlMvt?=
 =?us-ascii?Q?XU9z2fcJUG9A8peWbz2H9hp/HNhjuzmCFLFMWjaerGE4HeTdZ0M8FDAFPlkG?=
 =?us-ascii?Q?MO/K/Uxyy1nH7zaHa18ueuJ/iktlGP4Fv9xdzJxm2anSYpm+DZEVZNn7hcLG?=
 =?us-ascii?Q?unQOZCVOvnjdE9SUp+gYLvHkkzfbs40M/D5zLK9qILNBPfsH82N0lWSCIlaH?=
 =?us-ascii?Q?cKmDVluycZpYPnh37L0hxf8V5Rh1TcVtnmCtojvlA0fT+eW9HPBoqgS0ZLwo?=
 =?us-ascii?Q?IWvxggZDe16o7P+mCMZdqyMjKRl7XeOaWpyIcmWx/2MEfkNa6YBDd7ITfkww?=
 =?us-ascii?Q?biT1R5S+JSxihWsRvmbkQfs1DDyjCtNv/FWli9iwPiL1sG94Wsbh816Z8Pij?=
 =?us-ascii?Q?Car+c46q3xDHzrQNNDmNzz2b3SKva872Yy+N8no4D1AjwGPlAZ3U5MqhCr9d?=
 =?us-ascii?Q?/yUqRAxpAlFpetUBA9dzQiVh4Y6DdWDJ2sAa8UGJ4KI/n8A5IDGTsAhn1+Vi?=
 =?us-ascii?Q?pjGM9rvhHLuznS94RPUdT9BAgHHKKFPFu6nbVefJuvOuz5FUgltHkZACSWv7?=
 =?us-ascii?Q?jngvSbKk58frx2RP8JJNNSAWdawYIIUIZpVnQEKCL0F0cCPBV9FybKi56j96?=
 =?us-ascii?Q?Csd0gQvOHi8nw5KI6jPGSvwOEpz+Fg0x6jruoSSNPDB4kP6ZQWW0r8vIE5jl?=
 =?us-ascii?Q?QVnQJ840xMkJ8uJCarKi6Hzx2C7UzidDX6yP6fetQTDFFI5fNXJVCd21hqF+?=
 =?us-ascii?Q?pwI/mpMkircXaWPg3yiyHSBEgBsiReay7QcNGG4fQ7rwbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5DPjFmNEvstw5aNsl3bQK6IVpDSLZH105L+UmtQXPpClkt+0+ankTzcn/CrR?=
 =?us-ascii?Q?T6IMNs7nEy2Ej4CxIOCLH2SMOKdsKL6U5c7yZFDPRODWjb25ehVIpOVeLfh6?=
 =?us-ascii?Q?Xlp9sE+MUJ18PrWuYsgUVVkcNoequOD4YYIcxzRjSUudKwlInAJhoQcdjeT7?=
 =?us-ascii?Q?gadcexFrIRZaoR4NA7ekUoqCCY6Kdy4ppMUge8jvqniCzn9qbL9xpF3HN62U?=
 =?us-ascii?Q?YLbdpRqzVcs3/roJaVDhC0aYmUyVRM+czv+piywzHPWIdrMljDwP1HeS1pM1?=
 =?us-ascii?Q?TV8gikfpRqQVn1Y5M3vTb7Z+ZItCg0TGW4G0h5VqSQZ1laYZCN5cdmLysCxf?=
 =?us-ascii?Q?5vnKcVNL8UgrQEdR2ujZS+LBLZh1HR98AB/g0ybh82mnQJgxd5RvLU5py136?=
 =?us-ascii?Q?IR/Ou8qVWGQLtHiZvlsp+VeyarSFQl/zSNNoAHiZh/L2Cp2hLVBX58y/nkyV?=
 =?us-ascii?Q?3sJpDQM0b8wCyJrWNwGakdgyVCrWjLyFxNx0X1TpucqfUS/A8FpivNqI7xqA?=
 =?us-ascii?Q?29QHJbXEaA3bNr8TOyrMmhFqa9RZSJYXJYgA+n/vIMC7AxiX8OnbiZvr8Oyg?=
 =?us-ascii?Q?M3WsceQ7f3IgPTpnWQPCEzAFgHPWWjsrcEyR1GD+EeDuTe+FtzfbjcSAP0mC?=
 =?us-ascii?Q?ZksJOIsatHPnPPxxCb69831hSqn2BtVDwk0zXRuYGIErGUKeAThQS+scBo1A?=
 =?us-ascii?Q?m6ZJtakKuyC2+x/aQPDFHMbJzByZSIRfcFZM26b+2VQitSqVr36tc0VwKC8q?=
 =?us-ascii?Q?YIobwc2PSLY3n6+36V1h+QBI0Kk+FGaVTjkUR8FsotBDkHQOjqMVL2dJA3eK?=
 =?us-ascii?Q?WTJF+t9HyONYX5u1PiQ3rZvpiKjuTSKrtoit0xlTYR123ZhUmCjE8MvraCPZ?=
 =?us-ascii?Q?CCg897jcuz28gBS+7RKtnHUax8n5P6OXuTjfCazGbUSFsZLcR2MsJa8BdiE7?=
 =?us-ascii?Q?/ZfJ3Olxrs2q2C2Dg1C9+8+JYfT1vp8rvz78fZVWDNNUMx+bfrHtB7dLF6OX?=
 =?us-ascii?Q?wlovFlC0ewy7MSRD2z9LqtNTzWqW5sGEr01REaCCV+qE6uSdUJkxSLchrC63?=
 =?us-ascii?Q?zgaG7nGDP7KRSZqmFOAes7zqtrS7VSAoTgF/iz1ejbWAGox43/hqB+kAsAoC?=
 =?us-ascii?Q?r8m+3NkqMv/jSntrB1YFwnxg0O4dgNZ7KqnNm9nPYN9fBqVj+yO4f2bT4ZA8?=
 =?us-ascii?Q?4jfHG/Ea/NW237mmBLfu9yiDAQGmSQZqT+otjhPgG4vGSkYNPyPlwcbrV/gi?=
 =?us-ascii?Q?nkRGi12VeFOUCla7fceeZ6OH//vgvrxo5uqbS4etNAwzuU1m7JQz49/xYLqj?=
 =?us-ascii?Q?LxxdrGHeYqioBbfxhpMjM7SrvOd4XISwKlwgUSOPwVktPDS/hbqHrhibCTPI?=
 =?us-ascii?Q?2g+ck9LrbSjj7oFDfMpfCaDFc2l3K5kyMuher+bRdpuKzxydVtTtfRiyQ3ju?=
 =?us-ascii?Q?6XcPHueBUp9XVX5SEFwOn9SRirAhv1AxgeWGLC4vwqrzW4Iph9wp+Sq79q2d?=
 =?us-ascii?Q?RjeOJLe9MHCHmiUiQphyowmQDLbkKjuNX2X53uulMBn60do3ihehb2qxjAeF?=
 =?us-ascii?Q?DcOKgcGFItySGKtuQ+X1wjd6Oaj4u0Y98AML2Bb2stRMyZk33ndZaMOGB1Xb?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f29a73-497e-4ac3-4b98-08dd0e3ca125
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 17:06:12.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uodgI+6DHVvSNOWRSsFvX8S1KIWOOLE/9o+FySW3cvwcTgCj7iG3Hm9zTHRlpgnG215w2U2sjZACryvBFIn8XSvKzHU6eNeqkjCTW+oNz4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6377
X-OriginatorOrg: intel.com

Hello eBPFers,

I have a use case where I would like to store sk_buff pointers as kptrs in
eBPF map. To do so, I am borrowing skb kfuncs for acquire/release/destroy
from Amery Hung's bpf qdisc set [0], but they are registered for
BPF_PROG_TYPE_SCHED_CLS programs.

TL;DR - due to following callstack:

do_check()
  check_kfunc_call()
    check_kfunc_args()
      get_kfunc_ptr_arg_type()
          btf_is_prog_ctx_type()
              btf_is_projection_of() -- return true

sk_buff argument is being interpreted as KF_ARG_PTR_TO_CTX, but what we
have there is KF_ARG_PTR_TO_BTF_ID. Verifier is unhappy about it. Should
this be workarounded via some typedef or adding mentioned kfuncs to
special_kfunc_list ? If the latter, then what else needs to be handled?

Commenting out sk_buff part from btf_is_projection_of() makes it work, but
that probably is not a solution:)

Another question is in case bpf qdisc set lands, could we have these
kfuncs not being limited to BPF_PROG_TYPE_STRUCT_OPS ?

I would be thankful for any pointers/stions regarding this issue.
Maciej

[0]: https://lore.kernel.org/bpf/20240714175130.4051012-7-amery.hung@bytedance.com/

