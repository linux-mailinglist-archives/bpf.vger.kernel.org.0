Return-Path: <bpf+bounces-66465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E78B6B34E5F
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 23:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D5D167182
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36631298CA7;
	Mon, 25 Aug 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFJAr3tg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF8E23A9AE;
	Mon, 25 Aug 2025 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158561; cv=fail; b=oTv3ua4ZjW23mSwafLsrO2+q1Xp2Axm5eIWWq1047WmW/TchO45WjzihWzu2mZIItJdNw+4aAjJgZEkxyK9gA16sA71HonnEcj/CJ1KsM+dwgmEaXaIp/lhjsSKWzuvMPAvs+rMVAvj3lukvZy4wRTwUejw4QYHwTSr5nZMyE1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158561; c=relaxed/simple;
	bh=8dt2lHxpkpHVjh4oP/EqZb6Wfz46PI6YaXaE/rscQoo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rReFVN5BAQ8/eexVnVrki8AFqm03JF+Mrfm9ArEbYD4+FqS0ZygKkUASHJPeUOs1viiQ7cSz+SAIT4+BhB27P1fBiR7lDDr+f++cgICmiPX5Xmie8JziQH9ahT13L/yXGaFx1jKfaWiJuuzJQsanpRLSn9P2EIi/xxf7GDHdWlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFJAr3tg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756158560; x=1787694560;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8dt2lHxpkpHVjh4oP/EqZb6Wfz46PI6YaXaE/rscQoo=;
  b=KFJAr3tgVtMNNI/iullVByvM7WqwKYG/WBxA9ZsZVaRYkbLjQzTg325j
   66i46UqO4mWBgCrDKdjgR/S2VUYPtDuHpl4+D06h/wvO2Md2XjFjGkkkc
   EefH2kfRghbqzKj40Wjop2OoBAXgQ5rOXfbuor0NyQwo1zZ1zDRNTAmM/
   xZh6IBUaKn05TJMlVWB8fpB7pa0CzOd6QxW91NH+G8AwKZ4ia9lGXEfcp
   4m313+vI+Hb1ljabochVaN/keRsqfn7u3z6sWDaKmRAaXWrkKHpvsXr6q
   6NE2JxCN+UdO454rYLYEp7uRAHDQ9ZMGFIWkhIdybp+VyJ+FO+MLdpM4Y
   g==;
X-CSE-ConnectionGUID: h1s238g1Qb2p/gWXV46LWg==
X-CSE-MsgGUID: T/AfDbR+TrK7NnozhzUdDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58484185"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58484185"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:49:19 -0700
X-CSE-ConnectionGUID: M4pB50teSh6fgLi/TTUo2w==
X-CSE-MsgGUID: e5B1YHgnQq+93I+drixPHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="193069870"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:49:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 14:49:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 14:49:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 14:49:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNgy+Lm7Dtaa96cqEWQffnlaOqxJDx2mjcFehs+AigTXO+cTGrv1wIFyQxzguhDH588Y8X7DqHm+L5L68j5pWS+BgsAOiaIDG0l2AwzCg2SDtyXupHVGbNDj3eadXOakPX9HxOJVdkm2mSwVcVf02lOFbPxP4YAnF1i9tHLiruMOqkmF3ppYJUwbl0X7SPTGgoaobxhtio5cH9BX18OuqgL+a/2ynFoHVWduuoSid3MluwOzlhkek3+l0VujythT+0BxsFVM4tTdnwhCeWNjITOXlDLnU+5DIHL9dShUoWewwl9m2TvKwI41qAjRnWjcpYBsM2HPwXc8xt+ttuO8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+sgTf9I95mqJVepNoO1q0FKkreeBiDwLm6B0dHAyx8=;
 b=JyuD1RhvYGc9WjNI/Gc3KGMJwuQ7qCJwcl7+jWDtUDCgOfQLUMRs/FZvCRLYb+4J6BI3DStF9UlE3QIjFfwNQrebIxR/5AGYeDhex6IH8JJdqx9LAH3YQmIxOiviEch/UZ5X2fK+QxX3NP0Um0V/9dCrd/GQue/bqAu5kIRM6y41oTM4mdue/KW5y/VSH5HnFYH9RcOPIxH87tNgvVIuGIPObIWZnk9asm3vmPwBFkytZqPk07oGNAHQat6rlpDLf/2h9+/7Zn8L122Fyadu51wILH4QhTWHsVzm7L0iK6cK7FknFsdjlF8AEk8eWUTCoT9+sGcchjeTNBCKLD+tqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6870.namprd11.prod.outlook.com (2603:10b6:806:2b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Mon, 25 Aug
 2025 21:49:16 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 21:49:16 +0000
Date: Mon, 25 Aug 2025 23:49:09 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 4/9] xsk: extend xsk_build_skb() to support
 passing an already allocated skb
Message-ID: <aKzaVRQeeSuH155P@boxer>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
 <20250825135342.53110-5-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250825135342.53110-5-kerneljasonxing@gmail.com>
X-ClientProxiedBy: DUZP191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2f6561-4a55-4e9b-4a39-08dde4213ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h33K7XGc4PLRpOKaq2uJVQ84/tz7CxI8Ydl1gIZt+0HPuyaOYiSBSZdiH2bF?=
 =?us-ascii?Q?1Fl+KoE7e3oU3vqUovOJl56aNPdsqa3JN2pNM1Gs+5x1hy22ihNtK46ZxRl0?=
 =?us-ascii?Q?HYTWV84qKJqGc4s73kyQW6zaHbDzlQaFoeOke9+QHCBasUMzAVr7WcImovUW?=
 =?us-ascii?Q?8AxX/UKNLIqj4UWkgEnIrnKGdETCZfxLVXhJ/Zp9kKnMuTyMIXNJwtMVhOvu?=
 =?us-ascii?Q?2ruX+KKqNhykSmhLCm9mqsjXFiPAZ5eaaAQDnzyS74sYrIVCLxjJD1c+pRmH?=
 =?us-ascii?Q?LpqLWteweMh/5shlN9QtfCkLP17rgYlMKccJTNtRgYUXgB+WgutQMZnW/Vfx?=
 =?us-ascii?Q?jB/haFRkwOBJevUIW67sL+tk9t890uFAaxG+4wMUtJvRbAAdCib6tadUzl7w?=
 =?us-ascii?Q?Ia9zgzdD05iv+rdelJ9hCtUpfPbssznd9sbwMrX2rAKR0MdbBVGC2Hh9u0lG?=
 =?us-ascii?Q?vaBU9K1Fj9tlJbn7YTTZeVKLZME0/lgY2NwZVuyKj/RWU//oqdHvrgAIY9Dk?=
 =?us-ascii?Q?jt0xGTf0W7G0ZPB9IjjqHXPwEtH7IZgtjSVj1NFU/4RFoA6BURrzIBp+J1Gq?=
 =?us-ascii?Q?acivWpY5wyvhAkUf84sYGxacV2ll7o7uBE+nzmPHmrWQEaG7K/PghGV9mg5S?=
 =?us-ascii?Q?gd09OX12ibciu9vxCxb36jRlFBYgwO3imEHnKxhrnFT7VwoM/aNCavykzohp?=
 =?us-ascii?Q?PqK84HZ8Ohc+ckVQRWSlDlRHh3p8F/zE+I6rX62+3yuYlDPVkp9lwrZQ9g6c?=
 =?us-ascii?Q?Z9bQ1dES8165exTCLPMjbuTcMPE2B5fY4iYcP1QfUsY+wl570aeEoCBK7VmA?=
 =?us-ascii?Q?T62xyI/Z4y+CPc6LUQM7QseGhHJaeSuDEZU9mbY3QlDtUdbMHG9qDnpxsWRX?=
 =?us-ascii?Q?8KN0yVq48Eq8SI8WoGD6jn7WqsePjm9OSlF5vADP9wIxuJ0PI/CXH3odLj9I?=
 =?us-ascii?Q?DgOOZp/84gS7WZ3rqK2HAmsxRhxw4rqRZCE6aeY7ExaLeiQKP5lh9T3NQafn?=
 =?us-ascii?Q?S7BEzhH9fRnQH1SJGJ0tEzKrg2qCdFxId/ACDWu9wLrrKTQMWSkITxCHQuF6?=
 =?us-ascii?Q?W82V49NHpnVQhiMeu243PT0UERxg2m9J4TTEFpRZj4QfjLSAo3jsaHi8SiBz?=
 =?us-ascii?Q?+AXXYT4Myx5ecLogOw+rLlNz7aJe2uqFe9ZQkfUmU+RURta+f8soerCfxBAH?=
 =?us-ascii?Q?1XxXf+CFgB6PXpk1UyJf6t7MohNiHPR6/wkdw3VsYS2zSG2xXSBrclxpuW7+?=
 =?us-ascii?Q?H8YnaijqSZxEOTZ/hWilA/EZCPDtVB2GVnvbwGEB1H/alecxsMK9C3vJFgLU?=
 =?us-ascii?Q?N42R0Ro76oORfh5ie3Z2R7tQuEnhfujrqJlvetBaFV3QFVPVLACsCUoD5psK?=
 =?us-ascii?Q?+snICRPQNLHXju5ltdC5yp0Eg/CzIE1nfhxsRzB62Uahxm10ufVIbmrbVNde?=
 =?us-ascii?Q?jNOprjI20vU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qlhwX5TfYNElzDuD4M8WUjn8XSbjVPtSiq/025us+JyWe21ei7gjuahviXBJ?=
 =?us-ascii?Q?M9MGCOoUOYsijRWqQP4VQc9DFEq39dXBhUDrcxO5hqxsORq9w6AD6u33WR/B?=
 =?us-ascii?Q?bxAnJB951lVg8sw6x3HOP2PCUGmZ8t1nfFOgp8xsa9f4FpoJVt15BoLHG9cD?=
 =?us-ascii?Q?8cnb7swHfSJYrUhCpUHOSrfDGJ+WQXtOdxi4URaiTOjx53FkijdF9XxcUUuN?=
 =?us-ascii?Q?5wAQ+Jk3vau41hgFHbL7TPuABBAM6XxXsEzqutKMMmLurc2c57uObehHojKm?=
 =?us-ascii?Q?VWFIxJamI3SPgDRESNxG95cT2arYqBovuQ2ni8FlK8RWqv+KKRuGkZVprbpn?=
 =?us-ascii?Q?Z2mEbQl3PABpRhAHfiK0cR9R2/E3OTSHZfffwueX0vJrR7kBNsN0+aotU+IN?=
 =?us-ascii?Q?gBydj312eAhPU8Ombm8F7t/lTku/u3A0G3LpSe0YYzkM47SaBH2L/0LXeN6m?=
 =?us-ascii?Q?vwPlUy8SGu9qXvdaOQ6QvRXMohl/mynE/NLy10si5LdbBO9zv5ehds/Qvev1?=
 =?us-ascii?Q?YpV08q8wwIvf6GX7BE2ZNmjz+Rgek38jzILpr+UiaD9HgUxAZZhkeiqE+ALi?=
 =?us-ascii?Q?ujHxI4ZsC3N2UUaR5EKsWBlwsx1cPX82DmPjVfypsnBfpEWMee1V72pM5Sc2?=
 =?us-ascii?Q?yGpt4iIgePFAVZJnBSQDLg4GmT8V/7MRkMzZ2DTPlMQphYyUO7vGdd0LbzeU?=
 =?us-ascii?Q?85kDrzovxFu/7/z0tLA9QwfPn7+9V7ohoab+Fu+9MnDEcJXMIRBgl5yNTWYi?=
 =?us-ascii?Q?w1QCxpqGi6YK9+u0QEznwOy6pEW4B429Xcsr+VupjCQ0RzqKi/JR+ogu50b8?=
 =?us-ascii?Q?KPg/k3yIpj3RK4IMybyJqQavCKR41XcwqBpP7CAKMP4eAqCGTUPmKFcM2Ve7?=
 =?us-ascii?Q?tp/O7m3hwCZMPK4XRpiFhyArWZ71LpQ20hjlYgZ9VMBAKya3RWAmwgICth77?=
 =?us-ascii?Q?YBUnDUAVQOAKRiL17QZ7tFpfyeArpxe5y4ixxQKh4SUylbEth3vDqoQN4oKM?=
 =?us-ascii?Q?Qis5bdbVt53k31bVCRwxMJvNXR9IY4XCTVP/MewDzXfurqXxHteClYHe3bWX?=
 =?us-ascii?Q?HzDX0rMkAM9/DXdHgqCOkx9xgFcCc4N6LAGV7A45GRhD9VIh+OCqfi6WKbgb?=
 =?us-ascii?Q?rIpA+z6VadoxgrchJd+jDEU1sX2XMJGQuiQctgUnaBSz0JBwxbfmJcJoGGb4?=
 =?us-ascii?Q?dxZLRvVzcvJuZwlvdS68bnIVW06E+KJS/BiULdJfo/2XMRhEm7sPjdyHx522?=
 =?us-ascii?Q?sY0JvtSUvBOYBaiLQ5tpXlTMznXygPbDqPGHfpR2aBRY09rX0W7Pd5l3BN8V?=
 =?us-ascii?Q?/FpZhg0EMioSz164Tu4+dExL7vA2HnUVLokRAd2q7fHIDKFlEe+axSl+dTmU?=
 =?us-ascii?Q?6EeaEFbS3oY1EBZVQakbN1JC54uJBYSE/O4JSkpV95e5+LGYB2FkKmsotWAd?=
 =?us-ascii?Q?mIeajITEOX373HQX3zz31pLgsGPTxaIttfCTzx71hEgXsBaiBBy0ZMK8uY1R?=
 =?us-ascii?Q?MZFsirwOV46LFqOV6BswL5ejnhvoHme/DmADuV/wbtwRyukJNlCFP2MakaGY?=
 =?us-ascii?Q?QK5U+A2Dh6yT5if4hjSd4J6HIm2XqksLGTXY7uMbDexASmpq8YDfnQcPO/4J?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2f6561-4a55-4e9b-4a39-08dde4213ca9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 21:49:16.0376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIjPDCECpI5tEb/q+Ji7NH7ViOz76iEYGQaKKCJ6iGv2dZ1Iv765jGiys1tSwy3vNUm43oPEqqOOMveBDXbA3A2xtp1BIzNwG+LRzSaeI2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6870
X-OriginatorOrg: intel.com

On Mon, Aug 25, 2025 at 09:53:37PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Batch xmit mode needs to allocate and build skbs at one time. To avoid
> reinvent the wheel, use xsk_build_skb() as the second half process of
> the whole initialization of each skb.
> 
> The original xsk_build_skb() itself allocates a new skb by calling
> sock_alloc_send_skb whether in copy mode or zerocopy mode. Add a new
> parameter allocated skb to let other callers to pass an already
> allocated skb to support later xmit batch feature. At that time,
> another building skb function will generate a new skb and pass it to
> xsk_build_skb() to finish the rest of building process, like
> initializing structures and copying data.

are you saying you were able to avoid sock_alloc_send_skb() calls for
batching approach and your socket memory accounting problems disappeared?

> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/xdp_sock.h |  4 ++++
>  net/xdp/xsk.c          | 23 ++++++++++++++++-------
>  2 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index c2b05268b8ad..cbba880c27c3 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -123,6 +123,10 @@ struct xsk_tx_metadata_ops {
>  	void	(*tmo_request_launch_time)(u64 launch_time, void *priv);
>  };
>  
> +
> +struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> +			      struct sk_buff *allocated_skb,
> +			      struct xdp_desc *desc);

why do you export this?

>  #ifdef CONFIG_XDP_SOCKETS
>  
>  int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 173ad49379c3..213d6100e405 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -605,6 +605,7 @@ static void xsk_drop_skb(struct sk_buff *skb)
>  }
>  
>  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> +					      struct sk_buff *allocated_skb,
>  					      struct xdp_desc *desc)
>  {
>  	struct xsk_buff_pool *pool = xs->pool;
> @@ -618,7 +619,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  	if (!skb) {
>  		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
>  
> -		skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
> +		if (!allocated_skb)
> +			skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
> +		else
> +			skb = allocated_skb;
>  		if (unlikely(!skb))
>  			return ERR_PTR(err);
>  
> @@ -657,8 +661,9 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  	return skb;
>  }
>  
> -static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> -				     struct xdp_desc *desc)
> +struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> +			      struct sk_buff *allocated_skb,
> +			      struct xdp_desc *desc)
>  {
>  	struct xsk_tx_metadata *meta = NULL;
>  	struct net_device *dev = xs->dev;
> @@ -667,7 +672,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  	int err;
>  
>  	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> -		skb = xsk_build_skb_zerocopy(xs, desc);
> +		skb = xsk_build_skb_zerocopy(xs, allocated_skb, desc);
>  		if (IS_ERR(skb)) {
>  			err = PTR_ERR(skb);
>  			goto free_err;
> @@ -683,8 +688,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			first_frag = true;
>  
>  			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
> -			tr = dev->needed_tailroom;
> -			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
> +			if (!allocated_skb) {
> +				tr = dev->needed_tailroom;
> +				skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
> +			} else {
> +				skb = allocated_skb;
> +			}
>  			if (unlikely(!skb))
>  				goto free_err;
>  
> @@ -818,7 +827,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>  			goto out;
>  		}
>  
> -		skb = xsk_build_skb(xs, &desc);
> +		skb = xsk_build_skb(xs, NULL, &desc);
>  		if (IS_ERR(skb)) {
>  			err = PTR_ERR(skb);
>  			if (err != -EOVERFLOW)
> -- 
> 2.41.3
> 

