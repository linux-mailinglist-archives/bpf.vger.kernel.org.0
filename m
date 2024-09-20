Return-Path: <bpf+bounces-40131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF0197D5CA
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 14:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01031C21D1F
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 12:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D646714EC42;
	Fri, 20 Sep 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLlemra/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91813B29B;
	Fri, 20 Sep 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836646; cv=fail; b=GrSVZX62Lbq/hKRsGJZJQ2D0ZdZx99s3O4ql7Z7xAUbQHCBJ0gEvn5uzxSGScE17B+JB0N8LQclshR5gpz346I11/JNhXz+aaCDozrBMJ7mmP/jAcKPrM/uVgbipm86Gb7nN98lWpUbW0QZ+s5ceMtVqbrD4wSBFflHoqoShNBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836646; c=relaxed/simple;
	bh=fSWNZHgYi7NXu6Bu3oyVjmNfXHIlW1v4lhZRZXW56/g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gPmnQZqZBehp0VmA9l4f13C3eLYM9PtaruDJu6y2ac7wzbrh9SbW7d4UQ1dCX0U6UPujqiSOgXg31k+pbDGFTF5EyeE9+5nJ16njvKoFIjmhDDkUaeFO4nFd0C8ZfHiC5+Vbm5H+BHC9tDBSgE8FUn+pGZf4Ar9gZl8AHuv4BmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLlemra/; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726836644; x=1758372644;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fSWNZHgYi7NXu6Bu3oyVjmNfXHIlW1v4lhZRZXW56/g=;
  b=fLlemra/KhsBbmAasBLgag8kF34AMIVScVLH/eMlPb93CBNeuBfht1Ab
   GPA2F440eAW/VWAm48tcP2anB+7LiC8gpWIsoBu11paxxVggLFpwQskOA
   kzNMymHn2JMepbLKtFVwXkznRcc+rwqvZWNSyA0VrwqdbtASVk7BbJphE
   iXVvdRf/8zMYCtLIOb10fC+hrX/yVRu4fUqDKirJAZPlIkXCaxK4mtLGo
   txkepDAxs6TtaaA/wUcMHMW0SbXQwM/lRJ3N3I44WvXPRRCzOo5WSgBIo
   ifkQYkrIDKFI6ou2n0BqhmGxZqJU4MT4zEcI8EaE5gjGqyCAmWtoLAQSB
   w==;
X-CSE-ConnectionGUID: 7t3dJUoETWyKNZI4A6RjJw==
X-CSE-MsgGUID: T0qbYDNcTzGicdz3X+GERA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36427406"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="36427406"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 05:50:33 -0700
X-CSE-ConnectionGUID: BFiGtAwjT4Kh2URysGtu/g==
X-CSE-MsgGUID: pA9HyDbVSJ2c8owRRmwSrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70532082"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2024 05:50:33 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 05:50:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 05:50:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 05:50:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZfIGjNuRmMnjPmHDG+rsThEO3mKInP/qf4EwAePdr3CdUpOHwEw+2mFs/m60Jh5QX4kOSs05tsmpIeFD39KektbezOEhNsTp0k42pZYYQhjbnVCM2cD50DI2lc7yTEab16GeG3AdVSwyIWM8Imnjc1tlOVgrS+sRYKIyQSB7T4OZUlH0jFc7JOydk/AgJmC5KGK1nYlnC905NMYe0uL08DH3w6ztc6OAqluFhkD2bd1w8r+v3MwSwhPgvi75Q2/huuDDwa8jN4Ilnzw2T0o84INDOtwfkwQR/JLOrcT9TeqUGqjnCQMXocEiRV9+x0A5vBkhUt4nBzu/IbQfE80Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRr5uBEXQ2ODjIlChhQZ4MG33nRhCA6K/m8RsykMODo=;
 b=pmUIFBCmiv6WuzGZ80ilZjcryp+3NjRji1iLYyzeUp86YgdJo/e88OITC8DD6e+OZE3Jt0F9j/323fcOh5TbMbxbKkucuSU06M9Jh6FgTeiV9iuNpvUkrBMbd3otIPMWvQwpMnxq7cSSLyuYwv5eft2J3VO/y042wz3nHXhSdGB6IKyiOKAZV0bW3P4ZwHJ0t57og07f2NHoAfaFRIkSLHP4/+SApMijHhYt4N5Ec/aRr83ev0qKtDvrjj7dRqXMl+5H1Xt7+N/Pd+yODvczU+UQyoe0Zs5LKdXpfeIZOgqV5C4BnTXGywdmbkUq+dBaSbe6ibfPXIxPjhkOYGsnJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW6PR11MB8411.namprd11.prod.outlook.com (2603:10b6:303:23c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 12:50:29 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 12:50:29 +0000
Date: Fri, 20 Sep 2024 14:50:17 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Wei Fang <wei.fang@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <stable@vger.kernel.org>,
	<imx@lists.linux.dev>
Subject: Re: [PATCH net 2/3] net: enetc: fix the issues of XDP_REDIRECT
 feature
Message-ID: <Zu1viee7KxkRlYWE@boxer>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-3-wei.fang@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240919084104.661180-3-wei.fang@nxp.com>
X-ClientProxiedBy: WA1P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::26) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW6PR11MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c36d91-23a9-40e5-8863-08dcd972ce8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?haCjnKr2QrvRv5uTjx5GBX9bB/LMuSmtWPEFASJw52m/I2P83LpgPhjbN3GV?=
 =?us-ascii?Q?2/lmT0T4ZQnHRitq/XoS/7S5SWVL1TlphT55v+TcUXe3rRl+DDXWEDGH2M86?=
 =?us-ascii?Q?sDemcyaszRFVnjiZOR2s9KAcYa6v9iEg5r+cYtL63j34mIfxCMLv0gNDwBTp?=
 =?us-ascii?Q?M3WWYtJMFNock3RNmAc9luc+3aKO5o3jGEQS5kPnRMgNNCgCON6Y/fyhn/oU?=
 =?us-ascii?Q?3ZEyG1My7n7sk96DAxqq54mVohwEZfKlKALnEoclyEAFgkb6gAUXK/Emff2h?=
 =?us-ascii?Q?ew5vg4GpaS6EO+lJgNgxKYnEjVyHSB7/7biN31ulCz0tUXhGgWqhH1WWvfXP?=
 =?us-ascii?Q?KVgfJWSPzRWLZbwRM+cwM//m6pH1hpWRjfy7Ju2Vwe0vsrJb18D2Hl1P87FO?=
 =?us-ascii?Q?q886A/AxMHhyzyYGZJYqnb9Pv6Oeut1OEGGogb2E5OI6/b/+eKWP0zL28AYg?=
 =?us-ascii?Q?w0rfmQjupIZJ9fv+QJ8atueIxJmP4BIH0v3KFviq+1VI3UM+887Vm4PBDVTB?=
 =?us-ascii?Q?nlkgYTsMyrZL0IsvQ/UR8EuqzCvo60p5/CetKSrX11zJo7MQ1QONt5aa9qfM?=
 =?us-ascii?Q?P0HcefFthJrQ5ppg/aELuWjaiziNXLZ0oX461s9U8rymLL+lcKqrOEZBO4Y5?=
 =?us-ascii?Q?w2sUtfMx/yrNJ9BhnwE7+WOjmcRfjLcYSfER5z5UV7Xd7y/ebk+JJ93S3Tmk?=
 =?us-ascii?Q?ho+1e0wCW94cdspTBVJQaZHNNM+QkIv0GolwMLcDdTBLcHrAK2xSLoVBUkSh?=
 =?us-ascii?Q?AFjlseLUrkBlNA7whfuKTq0tmV/PBQ67LG6Rcqhj2AY7GQloUX0qI4z33MMD?=
 =?us-ascii?Q?BscCehQEDhDkGe9v09AU0adhHo+sxyFJeHy5arkasThNRHTTwxNwt3fU7DCA?=
 =?us-ascii?Q?eTHLAw9ec1+iEQXsfsJMr7nVKajyXriOPWc+97UUfIsLN6AeL42h2TgyhHbe?=
 =?us-ascii?Q?h8ri1y8mjH2jqdXgicEnYhi/RuAyZY3OU9UOMGZCu0WEyb455bbitnw3b0es?=
 =?us-ascii?Q?gJZmcAWHXIDjf7gv+7AY9Vc04aPwSUiEjvR3/oQKkgsVa8m1sD5W5mGVr/Xb?=
 =?us-ascii?Q?ZGSLFSofCljsNS3NXKvmSEnSN2PxATwGi89nCNx3Aw7bhdXYEikLUNhTiCcj?=
 =?us-ascii?Q?GfBq6q6ZSyRY4zExB3wLL84yPXORDinnYk83gCZftbLv8m2tIts2lkZmzjJN?=
 =?us-ascii?Q?HmC7dzi+cVRUa2TC8LLR+xs/J1u7gGby/4+pQpA+pxgdSyGAJBv6mvIBG7VF?=
 =?us-ascii?Q?8bg6tDRP37m3Wu/3SFAZdG1uxwjcxslaVWIH4Ru20w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oS0uHOg3h91PnCGWNtwTMtb44tJmMG4ZzHcs6ngN0UVWEsVWmtROJEdSRDcG?=
 =?us-ascii?Q?ED8yITNdzNmhy87MUcjgJ7jUVQkldCuWYCIKdwv1vy4/lD6uGNYLBYFPLDSj?=
 =?us-ascii?Q?eceahqKPTuSIMw29el9pKaYgBV3TN72DoSydX9vgfYURvr/ZGDNM2IQJ92EZ?=
 =?us-ascii?Q?SHMWCaAQV9hoJMluB2CJP+Conw9nBC9z7gCzwY6b3+1DAScTx/FOtkF8SihV?=
 =?us-ascii?Q?y1K46Yqfk7067HdZdgeNh/D5upzXIqH/Gk7I0pzkS5tqyhYOedLf5Jgz9cto?=
 =?us-ascii?Q?4P14BrMCXhZ0T+fcoTl07DaAhQEUYn64KWYwRsIgnEPGv/Qg+yCigH1nRFDC?=
 =?us-ascii?Q?sTXBTzlk4NXX6UrCEr4qVjJ/xhY+B2S4z9UGHXAymULrcL9VNUgIom8JbN4p?=
 =?us-ascii?Q?WpiZt/6rqkNO6xTnRP7orDfEN3dC1gzLYOxC7YpTrDftfBByad6pHQdESi/V?=
 =?us-ascii?Q?RESc8akvbT/ouWLS8InxrI9qfovYVfHmq0/ChMFM2Bo/W8+8+NcUUPM+siHF?=
 =?us-ascii?Q?EbWbtbN0giVBhS2wPCaJl2ElyLINNaFK8f4tXIIRcbwuZjsLnyfePQW0fOcc?=
 =?us-ascii?Q?/6fbFZsRsV8ej0WbMNrh5OIRbprisP8S+5Kn5sJ+SU3wq/C5B6dr6d4tMw0S?=
 =?us-ascii?Q?18bd1qmFtm3S2rm6qDZ5+Pt4htiD3sf4/lSb0gOF6CO8yFx0HrtjYKWgvhe5?=
 =?us-ascii?Q?rpBBhZmUl8ixwhdyWN2MRa3ngHskK778E4ijM9PUhzgyY9LnTcoWD0qJsSJD?=
 =?us-ascii?Q?p0sxyPfS6TL2wGLOpjNbKKmYCwqDa5G2mxSWCn0XEq3LTAYXXx77Z8Vp+50j?=
 =?us-ascii?Q?SYCUq9l6WL1rFuomAJILRo2hr4M4sNU5nNm60QX7ItxE7iHgDxODm4tdhSmM?=
 =?us-ascii?Q?8nmBTJUV2/9EaxkXRRSgC0QqaVpTKDWvPOjCuHwm3dgkGAJBC7m2/LlnDz2u?=
 =?us-ascii?Q?KLWcdS9RvsKCiEcow7wHtJ9eZDRzU+mA7n7PUJqjEiYqhBIJo8yUplKXpnz/?=
 =?us-ascii?Q?DXw86Bwq7T04mtce96Og1w+/rjgh/rnLc+u3mxMZ/lNFn5fpEPdobBjWTdZ+?=
 =?us-ascii?Q?g6GI/u1GwLxxvBI3VQuAK+T54fHZHmkYALkvB7I15eP3mRXDwNoHIHu6fxEe?=
 =?us-ascii?Q?vLt2LGofhNSdOgw2XPWziVPTleKwlXifQFW4wp5s3uJwbbnHmOEFLvrps6rI?=
 =?us-ascii?Q?UsooxINmqzf+eZIBGRodQssCH3AYFhZIlW3R1evH/rqqI4/gc8/WM/xESwSY?=
 =?us-ascii?Q?lBwBZxPUviDgL2hxdB9rO35PkYZyVSUNfyNBRlsRzCScbECdHiBfqUFSZrgi?=
 =?us-ascii?Q?HNvkLwempCXoSQH9ZrhI5ZnLH0qCBVSSpVBe2qZJSyYTGe/C2ijbpZm/Ln0T?=
 =?us-ascii?Q?G8XZU6fVhqTMRGKevn22Qe4eseX3Acnpvtiv/qqgvfGFzsdKGShEnJEFpv0C?=
 =?us-ascii?Q?YYLUgRo4XkoUbynI4Nj/onnQ81R6YrhOsIfQff29ZDrzHufoFhKSvPsP76hf?=
 =?us-ascii?Q?Z8js7lxVqBUI3j71bOmwfGE+D75FV7YJAXN7rrxRVYmQmGwmvy5vOTL9aq7u?=
 =?us-ascii?Q?erJl5jmWt08cNVe6AiFJdFGnlvK1m8oebMEvYecQDM5VFeU5lN+104RFm70o?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c36d91-23a9-40e5-8863-08dcd972ce8b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 12:50:29.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzjA5qeWZpzhCQBZl7TT3UA1A2c8/QMbIiDenEvpdJ5P+z6rWoXN1Jd7QxhP7/dBCisi+iHa4v10w5Ko7daOIH/8nIv0IK9pB39Lxc9jVZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8411
X-OriginatorOrg: intel.com

On Thu, Sep 19, 2024 at 04:41:03PM +0800, Wei Fang wrote:
> When testing the XDP_REDIRECT function on the LS1028A platform, we
> found a very reproducible issue that the Tx frames can no longer be
> sent out even if XDP_REDIRECT is turned off. Specifically, if there
> is a lot of traffic on Rx direction, when XDP_REDIRECT is turned on,
> the console may display some warnings like "timeout for tx ring #6
> clear", and all redirected frames will be dropped, the detaild log
> is as follows.
> 
> root@ls1028ardb:~# ./xdp-bench redirect eno0 eno2
> Redirecting from eno0 (ifindex 3; driver fsl_enetc) to eno2 (ifindex 4; driver fsl_enetc)
> [203.849809] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #5 clear
> [204.006051] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #6 clear
> [204.161944] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #7 clear
> eno0->eno2     1420505 rx/s       1420590 err,drop/s      0 xmit/s
>   xmit eno0->eno2    0 xmit/s     1420590 drop/s     0 drv_err/s     15.71 bulk-avg
> eno0->eno2     1420484 rx/s       1420485 err,drop/s      0 xmit/s
>   xmit eno0->eno2    0 xmit/s     1420485 drop/s     0 drv_err/s     15.71 bulk-avg
> 
> By analyzing the XDP_REDIRECT implementation of enetc driver, we
> found two problems. First, enetc driver will reconfigure Tx and
> Rx BD rings when a bpf program is installed or uninstalled, but
> there is no mechanisms to block the redirected frames when enetc
> driver reconfigures BD rings. So introduce ENETC_TX_DOWN flag to
> prevent the redirected frames to be attached to Tx BD rings.
> 
> Second, Tx BD rings are disabled first in enetc_stop() and then
> wait for empty. This operation is not safe while the Tx BD ring
> is actively transmitting frames, and will cause the ring to not
> be empty and hardware exception. As described in the block guide
> of LS1028A NETC, software should only disable an active ring after
> all pending ring entries have been consumed (i.e. when PI = CI).
> Disabling a transmit ring that is actively processing BDs risks
> a HW-SW race hazard whereby a hardware resource becomes assigned
> to work on one or more ring entries only to have those entries be
> removed due to the ring becoming disabled. So the correct behavior
> is that the software stops putting frames on the Tx BD rings (this
> is what ENETC_TX_DOWN does), then waits for the Tx BD rings to be
> empty, and finally disables the Tx BD rings.
> 
> Fixes: c33bfaf91c4c ("net: enetc: set up XDP program under enetc_reconfigure()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 43 ++++++++++++++++----
>  drivers/net/ethernet/freescale/enetc/enetc.h |  1 +
>  2 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 56e59721ec7d..5830c046cb7d 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -902,6 +902,7 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
>  
>  	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
>  		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
> +		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
>  		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
>  		netif_wake_subqueue(ndev, tx_ring->index);
>  	}
> @@ -1377,6 +1378,9 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
>  	int xdp_tx_bd_cnt, i, k;
>  	int xdp_tx_frm_cnt = 0;
>  
> +	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags)))
> +		return -ENETDOWN;
> +
>  	enetc_lock_mdio();
>  
>  	tx_ring = priv->xdp_tx_ring[smp_processor_id()];
> @@ -2223,18 +2227,24 @@ static void enetc_enable_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
>  	enetc_rxbdr_wr(hw, idx, ENETC_RBMR, rbmr);
>  }
>  
> -static void enetc_enable_bdrs(struct enetc_ndev_priv *priv)
> +static void enetc_enable_rx_bdrs(struct enetc_ndev_priv *priv)
>  {
>  	struct enetc_hw *hw = &priv->si->hw;
>  	int i;
>  
> -	for (i = 0; i < priv->num_tx_rings; i++)
> -		enetc_enable_txbdr(hw, priv->tx_ring[i]);
> -
>  	for (i = 0; i < priv->num_rx_rings; i++)
>  		enetc_enable_rxbdr(hw, priv->rx_ring[i]);
>  }
>  
> +static void enetc_enable_tx_bdrs(struct enetc_ndev_priv *priv)
> +{
> +	struct enetc_hw *hw = &priv->si->hw;
> +	int i;
> +
> +	for (i = 0; i < priv->num_tx_rings; i++)
> +		enetc_enable_txbdr(hw, priv->tx_ring[i]);
> +}
> +
>  static void enetc_disable_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
>  {
>  	int idx = rx_ring->index;
> @@ -2251,7 +2261,16 @@ static void enetc_disable_txbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
>  	enetc_txbdr_wr(hw, idx, ENETC_TBMR, 0);
>  }
>  
> -static void enetc_disable_bdrs(struct enetc_ndev_priv *priv)
> +static void enetc_disable_rx_bdrs(struct enetc_ndev_priv *priv)
> +{
> +	struct enetc_hw *hw = &priv->si->hw;
> +	int i;
> +
> +	for (i = 0; i < priv->num_rx_rings; i++)
> +		enetc_disable_rxbdr(hw, priv->rx_ring[i]);
> +}
> +
> +static void enetc_disable_tx_bdrs(struct enetc_ndev_priv *priv)
>  {
>  	struct enetc_hw *hw = &priv->si->hw;
>  	int i;
> @@ -2259,8 +2278,6 @@ static void enetc_disable_bdrs(struct enetc_ndev_priv *priv)
>  	for (i = 0; i < priv->num_tx_rings; i++)
>  		enetc_disable_txbdr(hw, priv->tx_ring[i]);
>  
> -	for (i = 0; i < priv->num_rx_rings; i++)
> -		enetc_disable_rxbdr(hw, priv->rx_ring[i]);
>  }
>  
>  static void enetc_wait_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
> @@ -2452,6 +2469,8 @@ void enetc_start(struct net_device *ndev)
>  
>  	enetc_setup_interrupts(priv);
>  
> +	enetc_enable_tx_bdrs(priv);
> +
>  	for (i = 0; i < priv->bdr_int_num; i++) {
>  		int irq = pci_irq_vector(priv->si->pdev,
>  					 ENETC_BDR_INT_BASE_IDX + i);
> @@ -2460,9 +2479,11 @@ void enetc_start(struct net_device *ndev)
>  		enable_irq(irq);
>  	}
>  
> -	enetc_enable_bdrs(priv);
> +	enetc_enable_rx_bdrs(priv);
>  
>  	netif_tx_start_all_queues(ndev);
> +
> +	clear_bit(ENETC_TX_DOWN, &priv->flags);
>  }
>  EXPORT_SYMBOL_GPL(enetc_start);
>  
> @@ -2520,9 +2541,11 @@ void enetc_stop(struct net_device *ndev)
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>  	int i;
>  
> +	set_bit(ENETC_TX_DOWN, &priv->flags);
> +
>  	netif_tx_stop_all_queues(ndev);
>  
> -	enetc_disable_bdrs(priv);
> +	enetc_disable_rx_bdrs(priv);
>  
>  	for (i = 0; i < priv->bdr_int_num; i++) {
>  		int irq = pci_irq_vector(priv->si->pdev,
> @@ -2535,6 +2558,8 @@ void enetc_stop(struct net_device *ndev)
>  
>  	enetc_wait_bdrs(priv);
>  
> +	enetc_disable_tx_bdrs(priv);
> +
>  	enetc_clear_interrupts(priv);
>  }
>  EXPORT_SYMBOL_GPL(enetc_stop);
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 97524dfa234c..fb7d98d57783 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -325,6 +325,7 @@ enum enetc_active_offloads {
>  
>  enum enetc_flags_bit {
>  	ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS = 0,
> +	ENETC_TX_DOWN,
>  };
>  
>  /* interrupt coalescing modes */
> -- 
> 2.34.1
> 
> 

