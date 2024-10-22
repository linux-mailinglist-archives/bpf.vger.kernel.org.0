Return-Path: <bpf+bounces-42774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755E29AA11B
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 13:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB59A1F236BC
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 11:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B2719C547;
	Tue, 22 Oct 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUWhqXu4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32419140E38;
	Tue, 22 Oct 2024 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596365; cv=fail; b=i+N+x85Yr4AuSO+vWs0ADRmb5hDMubUY8BK0iYdmrI9lI2Z81sT18emvP9r6p7c12IWnqiYniSuBw12WwOm12ObUIWfRPH9BZkBPPeLQOtCPSeianzkr7UwBTwJRi2t+BTQXOroSf5w9cYrzwglJ4NqBxGhKi+0tZcYpq+n4bro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596365; c=relaxed/simple;
	bh=cHL00LIPaOZN4mGK6i1MJs9FBsCEzx35E24ONMihIzA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ne5hbAXD8anDK30VUQIt60CPyKvm1ttLke9/x7vfIIDGWyrxlqnwaGYwjK8BZ645EiZoT7dDeBijB0De7oOjPRbgcEvJL4MU37qTsYEfr9kMiXKrqh8EdAzyM0RKZzIP5TxuwcRPwDhbROSfYfRcjN0nqRtt/P8/xoTjAY8FqgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUWhqXu4; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729596363; x=1761132363;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cHL00LIPaOZN4mGK6i1MJs9FBsCEzx35E24ONMihIzA=;
  b=cUWhqXu4jqPfzZg1O4lOgO65Y7GZSNSPN9mbYobMM3PcSuSEMdYTvb93
   IokaECNeOOVpBlIIXnfczZs5up3VrA8ZMwU52SDWl+MRcf8yZY5Uc+GT3
   01wU97bRA6dqXmr3WZ1WXN6diTa96ctAKXIY8KPUxqPKOh97BjaR1NzGw
   y9g3FElX7husLrmQhxH2ISbmi17woXBVCB38M+f1mzRtGECSunZlvTX9g
   JefPPt99Kafy16CkYrxqGnvx861g0mbt3ZQdVIrptboe7uiK5TYLgebde
   g5VUkJwfyNq9RkQTus4ipFv01fe/U1WKpBbvDkkaPYu/q7is5iS7n3m9l
   A==;
X-CSE-ConnectionGUID: mEk8YIo5S7yZCA8NmTgK4A==
X-CSE-MsgGUID: +KPlzNxpTyim8SYH/EilkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32816738"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32816738"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 04:26:03 -0700
X-CSE-ConnectionGUID: 0VWY3TB3SLOy8PYFfBkSLw==
X-CSE-MsgGUID: TcrdkQtXRAycz/q5AyVTIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="117274453"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 04:26:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 04:26:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 04:26:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 04:26:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWesRFcFNJpWvvcDFlZjUfhs1fR1FRujb7BJQppQD14u8HP/IJnkOjXDcg0MJmcyj7UNld7jQihh148RygEf/18PMRU2SEHOGafokie+eOARUSOt5FIfPPeU9HWqG0gubrO44UCnKq2cTEQlAziCcMXsq8iovGQXK0Pt3Pb3JzGvpayvo+pvM4B68fFy/ohVYIQfC5I2Kaz0X/bNZ+k5XlbKqwZ11WurcFJiepoVfFJbId6Ee/YRxZhPGahwL8/eTy9/M/YZsbK3P42PQ2pakIX+xP+mtj4WFFL0rKXtN1nCFzSLskX8PTmoENjH33Vo00kMx6nI8ChtAk3TaH5TBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXvzwk8iYd2eKlcDxxTYK7FZnHqeqMwCMZT8tqnKxZg=;
 b=iAm2bRBRQMk1NxTwrjUrWXhqRmdkwC5plziI/ABRwCnPttOfvK/vXk0vDdAat+QTiN7yIZgKzW7q5O9zPk2UAZPuzjPah3LarCxt1u4btGhSheXkfbZMtDC1rYSGX3q8a2J2BGN7mVujMSi+Mam65CDZHAVH2EY4iA0ZMC0C2F0zYrh8sORYFDr+teNjq1sK7uK7X0mSnDgCrOD6gKuNrcWbrOQarhu5YcQbCjUGL1voC+PQnprep9Ka06JgQjAdrZbCQ2j/YHibhxFLFo25QCHBsdcFjEyavgHhawTknJpfYEERrBWSeNH/o03Axq0lUU0PNg3uidf/AycFMsO3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 11:25:58 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 11:25:58 +0000
Date: Tue, 22 Oct 2024 13:25:51 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Yue Haibing <yuehaibing@huawei.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
	<alexander.h.duyck@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH v3 net 3/4] ixgbe: Fix passing 0 to ERR_PTR in
 ixgbe_run_xdp()
Message-ID: <ZxeLv+DGjFt4bwS+@boxer>
References: <20241022065623.1282224-1-yuehaibing@huawei.com>
 <20241022065623.1282224-4-yuehaibing@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241022065623.1282224-4-yuehaibing@huawei.com>
X-ClientProxiedBy: WA2P291CA0040.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL1PR11MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: a48a9419-6a97-437b-f0c9-08dcf28c4d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xMGJwVGz8GKs9y+ex5tx0f0/TeSm9G8dMjJs0LZXiJ3dbAC/d+eYkIfjaC70?=
 =?us-ascii?Q?d3BcnDO6vM3geRTeMJyU4biYK0mhaohKPNl8IuyfTuyEpMbQCQGDNt+PWtvd?=
 =?us-ascii?Q?RsxGr+5v+AqWE/crUxp/PLktAiu+JvziP3/JvKMJCloQSGExHq7B/3lpeBJ+?=
 =?us-ascii?Q?rFt8DI3O88bDLIltWyJyheq2ulOQSJacoqx9Uf4nzH68/a4J7rMfE2gqRmNv?=
 =?us-ascii?Q?/8FhnJXnvt3RfbBu5gQVeExaTCDgIi1pKLi31t/qD75IyJMEke/8zG83kMXi?=
 =?us-ascii?Q?423SZMkA5P0mE7nnmnzC4hoI0yh8EUTBXgMCepD31+Bi2zHR+ye9tM+ekuXD?=
 =?us-ascii?Q?OCnQh1A1MwCytWQpEdUZ4vMBWmJ51LiEMeD85Hcc2gtOfO7NxZdxoQKdpFG0?=
 =?us-ascii?Q?gpUbHBU3TX5egjvBchEqb6XzJCscC+TdieM59vCZb9XzdZrAi8arx+jTSzL9?=
 =?us-ascii?Q?/oIGaKVeg0fGcZqvYlPZHuozJZM4ehzGFM12Bwn+sZk1Pg59WdTSUP9/PU9N?=
 =?us-ascii?Q?+S19R4j3IJ8wIRnQ68N6zbOQNlPxVVwnxiuXS4U4lEZpsRWejaHggGu6sr/x?=
 =?us-ascii?Q?gcwT8ov2Qiyem0VILj1Go4Tq9tD99Aj7V3eJm1LG3jXLzrWgKoDGtaFe7gyx?=
 =?us-ascii?Q?zoxeF3oRIGeCBDAknGt3H6OThHoC/NpAenVv4UaWZkOtwTOzHI5f6EoTiDfF?=
 =?us-ascii?Q?OzmFvwr0oCUq+P0YnhLZjv0m14EnVhqhhqthq4Lni+cVGUwTCnC8k7CoKa2P?=
 =?us-ascii?Q?M1l3eGJX83W095S6S4wBZyC2pI/SgEFLCN13P6P6h6ehpWsPhqf9RH4ZICnL?=
 =?us-ascii?Q?DzQO0qi4N/LVpbr1m9qqRKUs30hYkRVZ0laymp1qKo9TW1lGyNLiaDxaLsxQ?=
 =?us-ascii?Q?4taWoIE4Vg7esDO+9TgMqSEPqM0Ygg0uNzrkZoy6SVA3dN8JnZGwAU1BB0OT?=
 =?us-ascii?Q?kX5Nsh/QX6Rpy6xRKzdRX7cOc9QLt82hnkjK6cenf4Z2GlC8c/VYUZvo458J?=
 =?us-ascii?Q?HIy6YPkEjznK7F9S/Ntu9KIkdMycEFH8QnF+sZ4xbt2XKlPwZkyzH4ucQBiA?=
 =?us-ascii?Q?e3ZhvSs9fJsYXYCzJZ7FkpLNNzj6bYnrck5SlUuelSaOtkYBLwDf2rpb4dqE?=
 =?us-ascii?Q?PvmHtm+T/KxTk4lt25W6LZTwMNQyprosi7/69BPpykBRXPXaw4EdrRiHDrft?=
 =?us-ascii?Q?JhdJ7qNxkQUixLci28lRlSy8LhZ/lGlNBnHX4eE1gEO+cTixxk6198R6wqyO?=
 =?us-ascii?Q?JcEGwBZ2bg0Ai+DGE1PVuBztHsvIF6MMyF6zcjQYK8QGyNlmUEzZXKWtezOp?=
 =?us-ascii?Q?XV0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7KUrkuUlskEaXFHDcvL09eY8ZqDDLKMStLx5swQbw76xUi1+DhMvfxrIQ/l2?=
 =?us-ascii?Q?FTnl7F50tE0ZA9GfV4iN4n98PuqOzHePA4No+iyxtlbEmlYB/3QkiOkmjNdG?=
 =?us-ascii?Q?OPvZNsqgGH/vEN1vZKgNcPdRH83Muq4bTW5yAXz/iK2ZHsw6xHDHQSlW4PGk?=
 =?us-ascii?Q?IYSmVSpKQ7nTjmGExXSkBHp/6IUqVwPfXwuYu90xjcVEvhfTWFshKX0YyN91?=
 =?us-ascii?Q?kqTsuUbb7mp1/5UD+0LdqqAfIMHGL7ZhzPTa5d4TAFtrEt0JNqd66o5mkiN4?=
 =?us-ascii?Q?wv88H91xgjOkTLtyomz+eL5BVfP9XYLMqi70VCI56WxGenCBmizF6k7e2xvC?=
 =?us-ascii?Q?jPnwAvjgJpErUkF+ctbtqdoX7NWUttxroObbSQ4RBQSTczpRbSuKnzqYsdyv?=
 =?us-ascii?Q?lVc+IM4gr81PGNLjB4Bhfhg7an6jWwMMmc0wX/fQ8yFKRcJUPutuaFVXGz6b?=
 =?us-ascii?Q?aUKkN7uSNWeyIQog71H7Uv93YQVsT4x6Zcnv0Y3dwkysBFz4Cp347yoOpyZR?=
 =?us-ascii?Q?cZhd+UOZxaGoFJBdplkHPnVsUmQSfTVeuziyxFeG7BQNrW7rKwwl8VCC5g7+?=
 =?us-ascii?Q?cmm6oy0N+EuK8vc7gOwjOsgUbSSfQwBYpMdFOuTqcGrSyMp8PzQLxcsRvFmo?=
 =?us-ascii?Q?A3GZHZ8ZvhJPcp7NPCPjSW/iJLipftfP2flquUUAK1FE4SjmHX3xeyqcuV6C?=
 =?us-ascii?Q?e8fpFFtEnprxUIXaGXwiNrkqPAl02sbyTkRLTuq8JfCXgKsJ4bpLQoOSgk+F?=
 =?us-ascii?Q?T1BgMVKbYbQ2/m3hlNna7Qnu3WyrdIr6YaHFM1OLt1kD9eTa9Twp644lfC7h?=
 =?us-ascii?Q?8ubjRHlweA7n4RnPIk2DRvotdWuTw+DXDPlzYLHWJNfjOS5ruuoRYFz/k7C2?=
 =?us-ascii?Q?D53bqpAhNw0Pj2o2oKHD3N2NvlEP9Oy8ulksqbEHkxD5Up5lRrCgbNQ9icEq?=
 =?us-ascii?Q?lRK5HMHRm9DsQPSim6ck9f02brMzRdGxCV30MuW9W77wM9A4dYqAKsWJU18b?=
 =?us-ascii?Q?e/PHD1HLLHrHyDbYvMnv7v196NoSsBz7wsMTKZuSAoI+NsBEBSuiSh5nA9q7?=
 =?us-ascii?Q?tnLZ+IIB4R7YsszBDA29G5waF5Binfixv4fTwDzLwBlNzz/V7TDLdbFC7V42?=
 =?us-ascii?Q?ub9kSD9/EG5BLR0iKsNchFbcCDvKlk+m0cNX0HBeQLP49ZA0plsLZFcTV3Px?=
 =?us-ascii?Q?i8W3kjKb4Z4kmQLrJIFt+Nz4JqSIJvZ8FPgyEQMI5kGKJ8h8xM4AR+91Vq2u?=
 =?us-ascii?Q?esNM3Lk0WuBplgsupcxhuvqLnRaflM6Je7Nyi3HXzT+ffYt2W1tfUGcphy0F?=
 =?us-ascii?Q?xhAbpTBjA/XmoVJCL7fmgSLTGcP++hfsFpJvZ9ZRH0EsIlaABghLvLHgeOZc?=
 =?us-ascii?Q?pFt8wgjfVVNt5XPxNinQ38NNtPj5LnBcNbPp7okoYQ2C7xsCkMxZ1URV1Ds2?=
 =?us-ascii?Q?O4lPfCV7rE1731Kl64n91rr8r/K2Ngxo9l1C63Xlke5uMFgy2gTPTDevEjXu?=
 =?us-ascii?Q?ORZ9bK3K6Is/M7FJzgpHs8+ZVxV+mtcVP9sCOvCBbNKxXu8bMeohVGDyyQs2?=
 =?us-ascii?Q?r2T64DKNWtac3w4FR4roZG/UAuhoagZhm5RkgkxjNmt8KGzOUBDLjpsyoHEY?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a48a9419-6a97-437b-f0c9-08dcf28c4d4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 11:25:58.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGJgzxQxvOxw2TWMp/LkubtXMwHo4Oak9c5VC/6B0/D/cHzVryLDzcr2pwt6UbL19YWAh+KqTdlK8cko94xD/IFlFIKJ6qjQIWfjRVcmkIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com

On Tue, Oct 22, 2024 at 02:56:22PM +0800, Yue Haibing wrote:
> ixgbe_run_xdp() converts customed xdp action to a negative error code
> with the sk_buff pointer type which be checked with IS_ERR in
> ixgbe_clean_rx_irq(). Remove this error pointer handing instead use
> plain int return value.
> 
> Fixes: 924708081629 ("ixgbe: add XDP support for pass and drop actions")
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 23 ++++++++-----------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 8b8404d8c946..78bf97ab0524 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -1908,10 +1908,6 @@ bool ixgbe_cleanup_headers(struct ixgbe_ring *rx_ring,
>  {
>  	struct net_device *netdev = rx_ring->netdev;
>  
> -	/* XDP packets use error pointer so abort at this point */
> -	if (IS_ERR(skb))
> -		return true;
> -
>  	/* Verify netdev is present, and that packet does not have any
>  	 * errors that would be unacceptable to the netdev.
>  	 */
> @@ -2219,9 +2215,9 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
>  	return skb;
>  }
>  
> -static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
> -				     struct ixgbe_ring *rx_ring,
> -				     struct xdp_buff *xdp)
> +static int ixgbe_run_xdp(struct ixgbe_adapter *adapter,
> +			 struct ixgbe_ring *rx_ring,
> +			 struct xdp_buff *xdp)
>  {
>  	int err, result = IXGBE_XDP_PASS;
>  	struct bpf_prog *xdp_prog;
> @@ -2271,7 +2267,7 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
>  		break;
>  	}
>  xdp_out:
> -	return ERR_PTR(-result);
> +	return result;
>  }
>  
>  static unsigned int ixgbe_rx_frame_truesize(struct ixgbe_ring *rx_ring,
> @@ -2329,6 +2325,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>  	unsigned int offset = rx_ring->rx_offset;
>  	unsigned int xdp_xmit = 0;
>  	struct xdp_buff xdp;
> +	int xdp_res = 0;
>  
>  	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
>  #if (PAGE_SIZE < 8192)
> @@ -2374,12 +2371,10 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>  			/* At larger PAGE_SIZE, frame_sz depend on len size */
>  			xdp.frame_sz = ixgbe_rx_frame_truesize(rx_ring, size);
>  #endif
> -			skb = ixgbe_run_xdp(adapter, rx_ring, &xdp);
> +			xdp_res = ixgbe_run_xdp(adapter, rx_ring, &xdp);
>  		}
>  
> -		if (IS_ERR(skb)) {
> -			unsigned int xdp_res = -PTR_ERR(skb);
> -
> +		if (xdp_res) {
>  			if (xdp_res & (IXGBE_XDP_TX | IXGBE_XDP_REDIR)) {
>  				xdp_xmit |= xdp_res;
>  				ixgbe_rx_buffer_flip(rx_ring, rx_buffer, size);
> @@ -2399,7 +2394,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>  		}
>  
>  		/* exit if we failed to retrieve a buffer */
> -		if (!skb) {
> +		if (!xdp_res && !skb) {
>  			rx_ring->rx_stats.alloc_rx_buff_failed++;
>  			rx_buffer->pagecnt_bias++;
>  			break;
> @@ -2413,7 +2408,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>  			continue;
>  
>  		/* verify the packet layout is correct */
> -		if (ixgbe_cleanup_headers(rx_ring, rx_desc, skb))
> +		if (xdp_res || ixgbe_cleanup_headers(rx_ring, rx_desc, skb))
>  			continue;
>  
>  		/* probably a little skewed due to removing CRC */
> -- 
> 2.34.1
> 

