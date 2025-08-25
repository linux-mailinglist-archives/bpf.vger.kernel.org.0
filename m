Return-Path: <bpf+bounces-66464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4EEB34E39
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 23:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F171A82ADD
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A029B78E;
	Mon, 25 Aug 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+K70hwh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF9A1C6FF5;
	Mon, 25 Aug 2025 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158195; cv=fail; b=MvCUZUNnDFBQzzXge2AxpYjYJBQZc+XjEg8fTE/CnQ/cdWVJC4zwcM8biB+f1ngY9GSwaEsoFirhLlAr5Do6SdLlHMpr0JG2NewK3uwF/UntYL+Lfo62xXAWl/R0EMLxYLecRoXXOmMwWh+vB9j3tlD8t67G38UoVax5Uvjh37E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158195; c=relaxed/simple;
	bh=Sp/LLinI3HjMSGi78MkW3ITGtrgJO0oBtcUED2VlVc4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dXcpoIBUrxTBLtpjFrDBAgbZSemzDXXd3L74qFKNtaTni3tFo0Jvw3XLfcEI90X2YGfDyEmRgG3KtTOdT1QGtupj8fV8VdvwRduH/BlQ/Fa4NLlBMuApMRzq7gxnZJuqBJLWdSHCZCWPHicq1HY8Yk1FL2E+CtBBXsHDjkkkcIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+K70hwh; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756158193; x=1787694193;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Sp/LLinI3HjMSGi78MkW3ITGtrgJO0oBtcUED2VlVc4=;
  b=d+K70hwh3w6o+GIbGkCUa8Uj7u9rM81vADUEfTN5KFYrUjtVGwod+owX
   h6qBIMpIRF2pF0FQcEK88XYn/Df+BYQqOIccD/TtLBozoVHEkXqWAEIgN
   PlBWq+FHJ7IG+Xvan6T+MyrVRGCxeoh2llh4DqCvFyTzy2NMAhnLXhDB6
   O6lECOk2k3URdN6ztdd5uLnuH975dOYBHG6G6PtETdcKNjP/IXJD1vNyW
   eXJR5xBLMqRLehWQNEoEpBTNQl7UHHXVeO8b7fj5ZDm2mnZOV0Rmn7J/B
   NyA153o3Y/BAJDF51svcj1fO60TLTzjXr0vTQx1++6Qno0RqALc8DjQ3P
   A==;
X-CSE-ConnectionGUID: PaPUUApiSgCziqP8EPG0eQ==
X-CSE-MsgGUID: uxuYDPh7T6qJFv17Byr+DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="61017704"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="61017704"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:43:12 -0700
X-CSE-ConnectionGUID: 4Ax034eVRNemtubLgD7LuQ==
X-CSE-MsgGUID: E73Lm021ThCgaqpzGOQs1w==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:43:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 14:43:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 14:43:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.82)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 14:43:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyjfoC/rlfq+OW0kky+1hlFP7P7QEiwB92XDHedEEwEACNfl0GKW0U6C4bbF+lW8NJ9bHH0KR3UmeZnQ4EdhzLsrNg8bPxOr9eUjIIeLtlIr4lQ4GHJQVc4RFw1E3XwZARxBuaARkbUdD/jJxEz7RQdnaRROVdqo0CeqefjWAy/IFC4ffoeDpmmmYxydk/GPmP/UsVFmJZxbTgV9eyYuLEKuw3PbpfNrARFS1+gBOnm1pMYGpr5zzFNaqf0539dlDC08Hj+QwDO9pg4jDaetYgRMdqxP+5CJ/aZlnlZeJq5MssozmSPflefZq/hSbgKAm/MyqGKujNYzXVJQa/YgPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF06H/bAgbdR6NjQN9ekuIAarFmD8/pT0ZQ7PS3knjs=;
 b=N+vHL2xxuHpQPWEPRPjc5F41oLBNkfTuy1vSxWyK5fjIkLejNituvYZ4TuWvxnvPA7czVZVghUixMHbxOnf2yANUZi0Y0Ru4fvmmH6S1IIbfp8J3Luchqi9/gjPPo1NZAmTU9y4vt4BmyicSDqcTZEkI8GVD0Io5unj/y7Kthjq0bKnpGyOaQ5xgEgTscGuFH+EVcywMq7NZu0uJU7qexI3bNn/W+cJgz6IJF9voytGUVKxi7q6LxG7CBbvm2D4CMxluWj1iqUtARYzvQllaGnQV7nKBBR2eetDNsbAnRS3gZ3qP1g2A7tt1RLljQ3u8x0X6TJxbsv3EsVORdAoV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Mon, 25 Aug 2025 21:43:09 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 21:43:09 +0000
Date: Mon, 25 Aug 2025 23:42:56 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 3/9] xsk: introduce locked version of
 xskq_prod_write_addr_batch
Message-ID: <aKzY4Ke0EdohiQXj@boxer>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
 <20250825135342.53110-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250825135342.53110-4-kerneljasonxing@gmail.com>
X-ClientProxiedBy: DUZPR01CA0279.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::28) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: 7596e303-3503-4a77-8ef7-08dde4206249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QXH+EPAk/WVrwwOnKqlrr8T6hcBZbjsz0Cu1LH3ZEE6u4FbA+Fau3YVjgiUu?=
 =?us-ascii?Q?jgW3xNjYSiogH4TtKNJd3ZdkdSHChLVDEqXw5UhdSUZVzl6dxoqIAvCHj899?=
 =?us-ascii?Q?wViyj1lDsoew8e4GnZ0AFX0dhJFBK+nxosJWoFR29X8taMDLQTKd4Z2SctPH?=
 =?us-ascii?Q?br6zWCHnfNRXZP8OqkIFtIKEWon5cxgi9EmqB9C+Oe0KRLZq0IclZyL6W2+d?=
 =?us-ascii?Q?4tF7wCXKcrdGsFGrRsGilfgNZdmB3YzMClo8aYY+qChLIF/vmsxm7zyQjjLf?=
 =?us-ascii?Q?E94idImKVv4wvEJKJ9byeEWy1FgBGyPCOOSaeS5TmvSUia5t/xj+1bqoM3rX?=
 =?us-ascii?Q?o7OdshlX6jxGh2+dBUlRkO2JfC/IM9M89DH4nvGLKeS/sxREWPdxrzuMScep?=
 =?us-ascii?Q?z3HEWWjk4JXKIqHZJCJ8AcdwMrNeJD9BCVPUqWdfEEgHErZDyCT5kPbURt+1?=
 =?us-ascii?Q?a2M2Qb0Tvu2RjUa8qD8F7DAn3BWzXT4DEi6ycMFTvLNyNuwo+14LKV/ppiXQ?=
 =?us-ascii?Q?5MxemQ4AobUxqmrSLroegxu5HYFAoxGepdx2COp1IBdZZ0NpKimVjYLOk/0i?=
 =?us-ascii?Q?WsylvumUNVGULy+r9gAf2sMi2AShuf54ZaiVGARHxiTTCMTk43NNw9pnYtoU?=
 =?us-ascii?Q?HVDYEDuBa6m7tQxlRmMop195OuSjtwaXSChwdOnkUlDaTYCjgFtCJWQ3YWqK?=
 =?us-ascii?Q?EEim5Y2eD2gEJO6HgDcyyKc34c7SaX4qBzjqzIGPqsnglqxsij4E/zKqGMiU?=
 =?us-ascii?Q?V7viaHHdF9NL2KqEnb4eDKkbcSwHkY1a454CxsQcOuAJmF8jO26Too/5shwk?=
 =?us-ascii?Q?ct9Y95bQ/bjUrdJQW212PyIGLCv2vRaszH13nrt6i8uHYPSlLtK6JQsAYesz?=
 =?us-ascii?Q?jFSoeKGlL35i1XaWonXy7p26QFYAsOVKppQOQVFhDvX1PF7Ww4FYNcjJF/X3?=
 =?us-ascii?Q?pR/+6HapX+GnV/V5W2ktoi0EkJgC/79USVjgeEZpvpdCLxj0lpaEv4/p0CUR?=
 =?us-ascii?Q?RBAhbyFbAPB+6HuUJ/RBA191iUAFxURop3TYT2jwYXzroujgBvYV7KC/PdMW?=
 =?us-ascii?Q?kJxYarLsF2aS/hfOCyf40UratiVIxT2pkyYl4oR+MDPJQJp22LTIdoLXFVwf?=
 =?us-ascii?Q?XG0aPTP+uWimols1JCfxPwClb20rgu+ZWCf5i/iK9fnJFPmWU5Ww5w8MfEcT?=
 =?us-ascii?Q?w0mPV9RYHhoVpQSV6J6ftd4AIhi8XTnFwGKwgHDPcqL+OkvsBwviTWtG18V3?=
 =?us-ascii?Q?6Y5MLtloIwiIWrNFZp96nEeJla4l6zz8rjXc0dnhW5EFusvskfxba7iquFGV?=
 =?us-ascii?Q?ek4HlxT/wKoAqY02ADti6uwdpqgjc4D8fNRHusstc4cUzeuTN+Xg+xC9Pnei?=
 =?us-ascii?Q?O86JrMyIRD22R/HTk/dJlWfJaFij16SjCucGMv1fTphrHWjGC9ajFpUhnNCP?=
 =?us-ascii?Q?d4eprt0x54c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VB/R0f9sgx+aSqxtL5eBHAw91QH3jD4jalFD6Rs+ciwcq5r/dM5V+3A8vBNX?=
 =?us-ascii?Q?9ydp4db5ebE4VUyMH6k/PqJohzMdv729hRBb8HNlPyhAgxOczzsD+IHgWKo/?=
 =?us-ascii?Q?hOIQE1pyB/uDSRxBwglSR24E+2w61rXQ+v3m67QRp2SAkemFrZltjIWlcW5u?=
 =?us-ascii?Q?bHegU2cc2HzFuGUDZ+GH+DURf9u9SZRePAfL9S6OrdAKBdZr32FL8F1ND99b?=
 =?us-ascii?Q?awV6UrU+0fQp4fGLs+fauiSWtmmCjgQkXIM7s3ZqNGvIyr5MHLxXoshcQN+q?=
 =?us-ascii?Q?96QJR67adyRfR145iTBvGJvXQ/oEKQUIBxCCt9YaMYdZWeiRfhVi/SN8yITE?=
 =?us-ascii?Q?2h4upACZJyjizsaZF57dgxvbDcvLy2jR5vfw6iD6VI0qC0wimFIF7N8joNFx?=
 =?us-ascii?Q?9FQkQWZmZTowqVAV/YdOsrNcVA/xnFpRt8nF/MnLxuIw9wZLl4gONaB5MFP8?=
 =?us-ascii?Q?o8KbCxKRZoDR8R6Dhfi5NsgHqzIVCW3P+Lm1QLlMaoesIrss6ixr83srK34M?=
 =?us-ascii?Q?yH6MNkfU/Wa17rbq5YMe3PRw5fTDXO7S00tx9OZroxYKlslAoX+D1UkCVSfc?=
 =?us-ascii?Q?p6aF1dS+RefzJh1K2L6AutmM+pior7mgOjk3Fbq+88vADoR8ikln6ONXhq1t?=
 =?us-ascii?Q?Xdq/tKca29YmksP4V/uOAZBAwCM4S1dZLeJH+81YEACYe83L3h8jKdj1txsx?=
 =?us-ascii?Q?UCVB4zF6qXM/NKi2tbvfD37IGMkN0OMbuKD3SdsfeZZKpYYNhI3tPjANEq+Y?=
 =?us-ascii?Q?MtVtjyI2HQEXSt2wiUH8dJTN6xg3P00iZ7jHyGh4WxDe3lz/IM0OEfp25YwI?=
 =?us-ascii?Q?mzf8fsnc5Gw9osn0JHdfkinb+diDt13PdDJLVEpnPMIwvs7aIDJWNDvOEM3g?=
 =?us-ascii?Q?1OcfWQVVTZJ73ar+mHTVZ150cPW69j+dfPLboFZ90p8R7XNSvEecGIuPcSTv?=
 =?us-ascii?Q?nE/t2rZtOJaz+cFuHje2Vd3b/eC0300fBocxXEUlBeQxyRzJxGS6t8Q/W0rf?=
 =?us-ascii?Q?rxDUntQmpdmMISen7+n81B+A4liteHHeF/jFuL918VzBa8NTI5Dagen250cr?=
 =?us-ascii?Q?/mmFwM1dmPO9bon3lHWtLJj0wxceBbIFmloMumAM+tCQBZp4y2C3G/3yn0Jd?=
 =?us-ascii?Q?8DYtGDeHTAa14VMQaZ7HolQuBECzM1872x+vNUhDqpaEpH6mbaGuGyOaKwLm?=
 =?us-ascii?Q?tV08r4dYrLO9SUQaJPEXnArZNKgvWtnUC3xP6kXH3tSCja3/9eAKgTmTsyJQ?=
 =?us-ascii?Q?69ZFRB6lm+Z5JWDRXA2d9X3P4Dp/sPGct5yG0jFULbJuNIHzyZFwfSrPy1En?=
 =?us-ascii?Q?bQ+zrGdi1NEY+FQKPhccRMGuZgVPE7aCrKcecKD3RVJDMPS1Yxb5nYxyTk+0?=
 =?us-ascii?Q?Hdf+cVQE1FUD8/PJ8ZsURuPT/NJXMekNqswMhhz53Fm6z/rHdz1cr0k41Ge7?=
 =?us-ascii?Q?9Oo4fdUJfAM1vD8LvSE9cidnBKMgxGjA7J8BsahPl5qGtrzD6T320lE5SPdG?=
 =?us-ascii?Q?4zcGrnY1hW6CQno73CN1IMjCA6qU7/nITy+iytAg6nUOqX3v4fsFIQ0ZmRhx?=
 =?us-ascii?Q?mWBfIrJ40ijXOq077jiXjaW75bNpPWGDyQKv7VLXLB6K4IMTH49izd6cMoEu?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7596e303-3503-4a77-8ef7-08dde4206249
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 21:43:09.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiUe8B8EfELIBXYmRlgEVRh1IurgU1KahSFhHNd1p1kNwjHAApEVkBNjvQrrLCuKy9njmr9jRgFZmPeU1GTmPz6pBYuB8ZZgRa/cbzej6I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-OriginatorOrg: intel.com

On Mon, Aug 25, 2025 at 09:53:36PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Add xskq_prod_write_addr_batch_locked() helper for batch xmit.
> 
> xskq_prod_write_addr_batch() is used in the napi poll env which is
> already in the softirq so it doesn't need any lock protection. Later
> this function will be used in the generic xmit path that is non irq,
> so the locked version as this patch adds is needed.
> 
> Also add nb_pkts in xskq_prod_write_addr_batch() to count how many
> skbs instead of descs will be used in the batch xmit at one time, so
> that main batch xmit function can decide how many skbs will be
> allocated. Note that xskq_prod_write_addr_batch() was designed to
> help zerocopy mode because it only cares about descriptors/data itself.

I am not sure if this patch is valid after patch I cited in response to
your cover letter. in copy mode, skb destructor is responsible now for
producing cq entries.

> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk_queue.h | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 47741b4c285d..c444a1e29838 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -389,17 +389,37 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
>  	return 0;
>  }
>  
> -static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_desc *descs,
> -					      u32 nb_entries)
> +static inline u32 xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_desc *descs,
> +					     u32 nb_entries)
>  {
>  	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
>  	u32 i, cached_prod;
> +	u32 nb_pkts = 0;
>  
>  	/* A, matches D */
>  	cached_prod = q->cached_prod;
> -	for (i = 0; i < nb_entries; i++)
> +	for (i = 0; i < nb_entries; i++) {
>  		ring->desc[cached_prod++ & q->ring_mask] = descs[i].addr;
> +		if (!xp_mb_desc(&descs[i]))
> +			nb_pkts++;
> +	}
>  	q->cached_prod = cached_prod;
> +
> +	return nb_pkts;
> +}
> +
> +static inline u32
> +xskq_prod_write_addr_batch_locked(struct xsk_buff_pool *pool,
> +				  struct xdp_desc *descs, u32 nb_entries)
> +{
> +	unsigned long flags;
> +	u32 nb_pkts;
> +
> +	spin_lock_irqsave(&pool->cq_lock, flags);
> +	nb_pkts = xskq_prod_write_addr_batch(pool->cq, descs, nb_entries);
> +	spin_unlock_irqrestore(&pool->cq_lock, flags);
> +
> +	return nb_pkts;
>  }
>  
>  static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
> -- 
> 2.41.3
> 

