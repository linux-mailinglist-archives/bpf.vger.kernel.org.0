Return-Path: <bpf+bounces-73359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83782C2CCD5
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 16:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051165620C2
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB4F313E29;
	Mon,  3 Nov 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Og9SLFO3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C7261B96;
	Mon,  3 Nov 2025 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182049; cv=fail; b=B7Kj2pLu5B2w267cGw22lm/DDeEM7lqO31idNtES88N3Gw7I0OWKcLan0h8iYkYZFEZ3LAFpsKD4Sxo9KJwb5HZHg7nSo5SzYOhviBAqen2NsfL7ifA1R8O56gqIdN0rvhGV9lc15KaqhhReln09lXs0FWOMLcwXR5X1HTeuPms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182049; c=relaxed/simple;
	bh=nwNmE3FUc1JjeePY1c9qK31aORXo3/bT7ljUYW5zjiA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vrqd/Ig6NnwqiIdxBAZDADSA4KCgJDjhMXC8H/2j1xnOUuORnfyLd62z3w9K0uAOmVDYXI8jC4w+knqIIe30SphyRg8NWm9KWCBtJUvdhURwx8mz40ltOmUN6ymFp5w9A6v0p85uh/cduMS0Jv+5lCdHQfrR60DpaYLlVxmAfcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Og9SLFO3; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762182048; x=1793718048;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nwNmE3FUc1JjeePY1c9qK31aORXo3/bT7ljUYW5zjiA=;
  b=Og9SLFO3GIony5537xxNiFz2yYImkf6SypgXK0M2AmOZbIXxbXeiqNDE
   r1BL8bB7XgTdr6ohaUy7mNb6rqN4niMRCtYkCz3eCHAqEcyHFarn/8zLL
   7jMhGhQmXhDymeoTEBJNeha4QKJbf4CSFVBw2VhbbL2G701qxZLvSVUcv
   8jjBMWOfplrDxrJ7GQgyntE6m+OWO1d/Y3z+X8hmkN3VXHCYxGC90isBp
   i9ex4CSMmoo4BEzZcSWSgbKq4UaczzCFjtTUm+06Rqsro/9xLoHqssiW/
   Kt6lGXI/ngO4rZkuythcRS11WlRvAIrPVsVEoUFajJryCOHYUtps5ZJ4d
   w==;
X-CSE-ConnectionGUID: PEH+tf08QzG7xehnL4hiWA==
X-CSE-MsgGUID: T8LLnV0EQRe5+6NmNNvjtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="74548786"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="74548786"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:00:47 -0800
X-CSE-ConnectionGUID: NpEtZ5iZTkmalP93TbMiwQ==
X-CSE-MsgGUID: pMZuarOtR1irwuxZOK0B9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="224134336"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:00:46 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:00:45 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 07:00:45 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:00:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Te16el0Z1TDI8FRuhydGSFnm9ZrUMTthPE6bHPXEgNx48eLaE/qj3T67vEcliOweeukGxiQ3W6JYchv+qSOJm7I8uwUs1gwtTwvoE8KNhEK4U0uptmxcOOATQgxCGXczAQgBg1+C8xk70KrcrkPmXOilTWan11SiHhj8d3DS8XNVLLiF+x3iPaZkS1WuZ4if+L93c6xfgc0Cq6ffT/PyafaxNpeia+G+9+MUFReE0lRI0gkcHRzbVz9AEvuEbSGoXtptKHuCU6TvpxkVwoyQtwa0rYz4NPjVlDidzmKce5CeFvDdFPU/v9z6qIJjcG7meiJ/lBwOA33sdS5BUxj3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrS6ky+WrSFPQ84WXQq1huvY2G4F0sM5I+rSoOsIJIc=;
 b=VLGef12ZPp2lFhnX7YA2K2Nr5e2ZuYvtpimBq4H0Sce8JUrXB8uuxeuKK/icLPe0CxRCineKxFsz4tZ5+FsN02mG+0TL8cwH/g6cxjzPnDBGkMqnlfQlS11wKtKfsO+czMsMgch6HKcTxrFqWqvUtRiGIgGudpXKYowTccB+ZUS9NUXc+eUZMW3psGyjUTvYfQb7IoKKdjrdRdIuCce4mMja21Qpi378gJtizj0krfM1WBRnhQGjscxmGpg+8NwX8QF+YXstMNSOe4IrIcS4ATZGRGmNyputgSzLA1vlU0Kk3KlYPynLlettQQNvBcsxZYAZwhazju8arorAAky8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CYXPR11MB8730.namprd11.prod.outlook.com (2603:10b6:930:e3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 15:00:38 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 15:00:37 +0000
Date: Mon, 3 Nov 2025 16:00:29 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <fmancera@suse.de>,
	<csmate@nop.hu>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
Message-ID: <aQjDjaQzv+Y4U6NL@boxer>
References: <20251031093230.82386-1-kerneljasonxing@gmail.com>
 <20251031093230.82386-3-kerneljasonxing@gmail.com>
 <aQTBajODN3Nnskta@boxer>
 <CAL+tcoDGiYogC=xiD7=K6HBk7UaOWKCFX8jGC=civLDjsBb3fA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDGiYogC=xiD7=K6HBk7UaOWKCFX8jGC=civLDjsBb3fA@mail.gmail.com>
X-ClientProxiedBy: VI1PR06CA0126.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CYXPR11MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 1acf36c1-d0da-4725-a6b2-08de1ae9bf95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWkvWXFpK2ZuUndiazRUVEtEYUpHN09jd1hBLy9NTHdBWVNEeUd6YmRDSExG?=
 =?utf-8?B?cmhIUzMzaTVHbU5CbnpFMVJDYUZ2R3VOTGV5cnVxN1hQa1RlUTZsL0dSODBK?=
 =?utf-8?B?VW0zMUNyYi80T3cvQm9RVTRzeFlxUFk4c1VXeTVxUWhENnNwVEIxTXJmZFBG?=
 =?utf-8?B?ZTRjS0oxZVVMZWNwcDZuUDVxRTU3R3A3ZzFpZ1Z6SWJueStrZlhWazdubGNK?=
 =?utf-8?B?Z1Z4RjRhazhrekxuZTF5L01ta0pQUGZZK01QbHhjQmczMUNuR0dDSFJ2a3FR?=
 =?utf-8?B?SnRDU2MzR2hnNzJHbVN2MlFITHZhTW9IL2FQWWp2RForWW5aUlFpR0ZZS1JL?=
 =?utf-8?B?ajhNUHJ1SnUwMWZYSWp6TUhBYXVVQjlNZGtmbXUvaUluWTRpQitpUWRKYUlr?=
 =?utf-8?B?eDMyYkwyY1hVZjM0VXVSejZ5RENXMXNkakkvSEpDRnhtdTRhQkhZdnZNZW1j?=
 =?utf-8?B?MVJNZjFUcWFaTzNpQ2JEa2NyRkV4QjdWOUZ5NDdmMGw5OCt4WmxEZkh1K213?=
 =?utf-8?B?ZVZzdkhPSEpaMUxiSXJDYy81VGxkZkZHcEs5aGhZV2RvUi9FY1AvTDlIZ2pU?=
 =?utf-8?B?c1VMYStEM3RSVUtwQUNBOGVRSTF2WFdkakQ2bkZLUVJoNWpGWmhDTW5zQW9j?=
 =?utf-8?B?cjdzTWdramVKZW4xZSthSXZyR3YwMXkxNE43dUh4YWYycVNwNVVwYmFoU0lW?=
 =?utf-8?B?YmhlUlFoMjloZ1ROd0hSdXJPN2k1clNUUU16TkNFRTdoajZ4WW05M0c2dW42?=
 =?utf-8?B?clZlVTE0MW9kWEhWRnBDWkdvMXdSZTZpUzZZdHQxMG1pTVIyVE04dHl5S01Y?=
 =?utf-8?B?TWlZbWlTeXpkYXhSMUV6Z1llbi9Va2w3RTd0SERGMDJBOUxlZWVVdjF6c1Z5?=
 =?utf-8?B?aG5ieFE0WXVPeHJsNWNlL0dZcW00VFJuLzFnT0U2TDhnZUU5SFExdGxyTXRx?=
 =?utf-8?B?WDVWZ242OXdsMm5JVFVuN2pxbmlxeVd1N21GWlVYS01CcWw3ZkExVnFnRmNU?=
 =?utf-8?B?UEh3T1ByVWlKYmdtYUh0VWsrcElWa1F1Q240dS9zUFY4bEkxamVSVU1qRERw?=
 =?utf-8?B?aGNLaExkeW1uT2xmNGZBZnZvWmpVQjRISDhreUNEN3ZkMkVLRW5MYTMxYVhx?=
 =?utf-8?B?bGtzOUsxZklucXgvb2JjOTFmRTh4THRmVWVhd01kMC9ya3EvMTNxQjBMZEZT?=
 =?utf-8?B?ZnVkYy9yUmZNZ0ZJZlU0TDYzbEM5ck1TV25XTFR1eFRhQWl2aDBTUmtrcWxS?=
 =?utf-8?B?RFczcFdVNVpUekRSeVJiWm9GTVV4OVgyU0Y0aWoybldONTZBaXcrUlY0VjMv?=
 =?utf-8?B?MldkZUgxZzhRRjMxanZiSHFZcnRuY21qNXNIZTB5RVhJMTE4amgva0dianVZ?=
 =?utf-8?B?OFZkekhGZ002bkNVL0xCaTdyUHEvMytQOWNRSTh1bHB0S3NGZElRS2Y2NnN5?=
 =?utf-8?B?SzFrRG5xa29KRXd1a0R0RUpKUjhMd3g4bk5EQkxLMlAzeFNEQWY1Y3JGN3Ry?=
 =?utf-8?B?U2ZwVUtwVnI0REJpYi9CdzhmZzJoUkpWU011QllkUzNoOU12SlNzUGszTjlq?=
 =?utf-8?B?QU90RkJwSm9IU1pnV1N2bEIrVjRta1V0cjdHYzYvZ0h3ZzNEcDYrTk9sdC9w?=
 =?utf-8?B?cUhDWTNhZ290T2dLVnE5ekgzbUkvT255bzJrYjV5VDV6Q1UzSUdOUWVRNkJM?=
 =?utf-8?B?QUFIdmhSWE9YOWJPZ2Y3U0xjM2UzMzdNOVI3MEZvWG9zejV4YXBLRTJ4UlB3?=
 =?utf-8?B?c3VhdE9wb3UrVTIzdDRuZHpzMllmUGw5UXJEUndIem5XcE9Xd2dUNHB1YVAx?=
 =?utf-8?B?dG90aFdKcjU2WFVHTjJoMDFaanBCTi9xYzljakNmS2ZOS1VTYS9lOEY3elRk?=
 =?utf-8?B?ZjlhcHp6K2dhOTlQdnNYcmlaT3djVFVNUGZlT0d1aFRUem81ODlid1BONEQ2?=
 =?utf-8?B?OTNkYXRzcHNZWVRVUG0vTnplMDZ2Nk9BVnIwWnlNbkh4WjNtbmZod2hESkZL?=
 =?utf-8?B?aS9EemJpbVpnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2QwZUpoSXZFQnZRbVg2c3BPYkR4UTU1VnlEQytBQVRLWENKWlNzbWxWTldI?=
 =?utf-8?B?MWYwcHZicGZLZkQ5SVJXWlU4Q1NLaEtGLzQzZDduaGZxUG9RTmVxN0dRRThq?=
 =?utf-8?B?bXhjRmZreTRzRXZmUjNKNEtXVUpaSmdQczE4dTl3cFJxZUszeFlwWTJnVmwy?=
 =?utf-8?B?eUpKRHVadHJxS0p2YUhEeTUramhPT21tVG94cnJDbHhPc0FtcThXdyt3a3F3?=
 =?utf-8?B?NUsvZXhCS0ZyVm1ZWDRsWWhrbGlFNXBjOVRINEdsdXhkTGtCZ29vNHU3cFk3?=
 =?utf-8?B?WnNJNWFuY3poUHgxNXdiK01pb1dYcWd5WXcrZXZwL3lDMTRFRzBOT3BubURk?=
 =?utf-8?B?N2dUek5Qa2xTb1daVzYvcDcycXVaOVlpSWlINHd1OVBZd1FHOHVxbW9KN2hZ?=
 =?utf-8?B?aTJEN0VSMWRJV3Bkak82VUkvcmc4NHVLUjQ4YmRraUdWU04zZ21BeFJaRmda?=
 =?utf-8?B?cWE1MzNhVkJIREFTZ1grZDQ4VUtHdVlBMTBKK0JXYkFsSm9LQWFEdWNBL1M2?=
 =?utf-8?B?SFFwRVFndnFnbHZITGwxTkhaVUNETVJpUDBUU1RsRkdYNGZrREJiWEVOSDQy?=
 =?utf-8?B?QzRjUjZKVE9CUW5RaUpwdkRVODBjY3JBUVdhRjNVUUVZYWJIdHdSV0FoamxB?=
 =?utf-8?B?YzFaM08vdCs3UDMxNDhEL3FDOC8wUFBRcGFqSU1JalpXZHg1OUVKenM3ekJ5?=
 =?utf-8?B?REhJTHdJYjU5aW9DTW14bnhnV2NPVUNvUlBJeEhFc0cvR3IxdFVZcVl6K2ZY?=
 =?utf-8?B?WGowU2w4ZjdDY1ZuamtoOVd3MXBvREx3NzlOc09SemVsMkxFK2lJKzJTWjhr?=
 =?utf-8?B?YnNrZCtTWW1ka0tlZ3BOb1kyWTJ1ODU2S1kxSy8zNm4wSDFEbFFNWjMrczV0?=
 =?utf-8?B?RnYxOTJDQkdrYm9ES0d2L1FaQW9aV2xHQ3l6MFhoRnNzaWczYjQybU1qNWdu?=
 =?utf-8?B?U1lSVjJnNkQwVFlzNHZHRWdvYW5MU3hFV244OGVVbWJUcVhEU0JkUkd3Z0ox?=
 =?utf-8?B?WkZ6d3paT1I5YWM0SDM4RFVOR2FBc2FqMmN5emFXV2J0eEpQdEZyem5TYlQ4?=
 =?utf-8?B?QmJITXorV2VnNC9EZk55Vkl6L2NiQWtqQk9tbHVCRGJXcWcrN251ZjVLRlpF?=
 =?utf-8?B?YnBGeUlyYnFRUkxpZ3d1R1FtcVBLNjl6RTNnWDdiRXpPd1pOajlPQVZOWHpx?=
 =?utf-8?B?YlY3aTlmdm0vU0M5N0NXb2Vkd1M3a3FPUVRPa0d6dEF2U0M5OFVjTE4ybnc1?=
 =?utf-8?B?eW5MTDl0cTR4djBDQjJUeCtLcC9sQmVkOXpOTVMzQTVYQThpbUlJeThlcjcy?=
 =?utf-8?B?cWV4ZFdXZDhlcmFYMFoxSkZ5eDA2blFPNU5IaXNsUjBYMFY1by9CQlpkclVS?=
 =?utf-8?B?NUVWQnpvaG5GRmJzbDkrOGtKVnI0UWVBL1FvT3NTRnpQRlVqcFJwWXhXYmlZ?=
 =?utf-8?B?NzEveDB5SE9ld3NIWlNBUENQVEhCODV4b09UdEtsUWJUNjRUOXhRQThmMENS?=
 =?utf-8?B?V2toQUxjMDVZaGtzcXB0U3o5RDBQZGQwRG5VUG1mMDVwN2Y5QmlyTnU5dUpz?=
 =?utf-8?B?RXltQ0tOSEgxSVhTeERyOGthRW1Rek1QY21HRzdqZ1ozS2xtWWxJYURxeGFO?=
 =?utf-8?B?QXZsQkRRRUJxRkJCKzcwZ2d5MFYvb0hIY1g3QjhRUmUrTkxGeFMxMnJWMlk4?=
 =?utf-8?B?RStFKzFwV2FrNnVEajAwTkZmNnQ0aWVWcVFCR2owc2xOMGN0SkVNWDREK01q?=
 =?utf-8?B?WmZZQ2kvM2lEYVFvbG5Hcy9GNCtjSmo4bTdYYVBDd3ZJalE3cVFBVWNwSStI?=
 =?utf-8?B?TWJnSVZBWENOZEJTY0YxVkZpZVlVZURoUHdqMWZlOWtleVdZWTZqenFheldz?=
 =?utf-8?B?RWRtYmpYOGlkbldBU2VaOHdVSFEzNjBDNmVyNHRKTmhZSGI3UWtIM2JzSWtV?=
 =?utf-8?B?ejh4cjJDcFQyNnNsMUU2anRaYUxRVWkyK3dIOEJXWUZ5YUt3M2VXK05Uclcx?=
 =?utf-8?B?UFlZbFRtVkYrWEZUa2dqV04vUE9XRXZydHhTRmp6dncvNG9FdnBxdmhIcVcy?=
 =?utf-8?B?M1pXeEwxS0RUZEs2bnJtNEJ4cWUwMWJBbkszMHlIMzZlM1c4MVY3TGF3ekpG?=
 =?utf-8?B?R3ljclN2cHBVL2pieFlXSi9mNEtaN3FKNFpqeWJITVNsWmsrU3BtRGM4V1hp?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acf36c1-d0da-4725-a6b2-08de1ae9bf95
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:00:37.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Oh+Kci8b4Og4vDVBoWGok+zoDe4tO9OrV6iZf2XG4ZXMhuCtb5xnZqFv5HvryJ5s3G5edKIVKiNXAyuKKFLLCjKqcaJfWbMD87Gnpgpk1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8730
X-OriginatorOrg: intel.com

On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xing wrote:
> On Fri, Oct 31, 2025 at 10:02 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Before the commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> > > production"), there is one issue[1] which causes the wrong publish
> > > of descriptors in race condidtion. The above commit fixes the issue
> > > but adds more memory operations in the xmit hot path and interrupt
> > > context, which can cause side effect in performance.
> > >
> > > This patch tries to propose a new solution to fix the problem
> > > without manipulating the allocation and deallocation of memory. One
> > > of the key points is that I borrowed the idea from the above commit
> > > that postpones updating the ring->descs in xsk_destruct_skb()
> > > instead of in __xsk_generic_xmit().
> > >
> > > The core logics are as show below:
> > > 1. allocate a new local queue. Only its cached_prod member is used.
> > > 2. write the descriptors into the local queue in the xmit path. And
> > >    record the cached_prod as @start_addr that reflects the
> > >    start position of this queue so that later the skb can easily
> > >    find where its addrs are written in the destruction phase.
> > > 3. initialize the upper 24 bits of destructor_arg to store @start_addr
> > >    in xsk_skb_init_misc().
> > > 4. Initialize the lower 8 bits of destructor_arg to store how many
> > >    descriptors the skb owns in xsk_update_num_desc().
> > > 5. write the desc addr(s) from the @start_addr from the cached cq
> > >    one by one into the real cq in xsk_destruct_skb(). In turn sync
> > >    the global state of the cq.
> > >
> > > The format of destructor_arg is designed as:
> > >  ------------------------ --------
> > > |       start_addr       |  num   |
> > >  ------------------------ --------
> > > Using upper 24 bits is enough to keep the temporary descriptors. And
> > > it's also enough to use lower 8 bits to show the number of descriptors
> > > that one skb owns.
> > >
> > > [1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kubanski@partner.samsung.com/
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > I posted the series as an RFC because I'd like to hear more opinions on
> > > the current rought approach so that the fix[2] can be avoided and
> > > mitigate the impact of performance. This patch might have bugs because
> > > I decided to spend more time on it after we come to an agreement. Please
> > > review the overall concepts. Thanks!
> > >
> > > Maciej, could you share with me the way you tested jumbo frame? I used
> > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock utilizes the
> > > nic more than 90%, which means I cannot see the performance impact.
> 
> Could you provide the command you used? Thanks :)
> 
> > >
> > > [2]:https://lore.kernel.org/all/20251030140355.4059-1-fmancera@suse.de/
> > > ---
> > >  include/net/xdp_sock.h      |   1 +
> > >  include/net/xsk_buff_pool.h |   1 +
> > >  net/xdp/xsk.c               | 104 ++++++++++++++++++++++++++++--------
> > >  net/xdp/xsk_buff_pool.c     |   1 +
> > >  4 files changed, 84 insertions(+), 23 deletions(-)
> >
> > (...)
> >
> > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > index aa9788f20d0d..6e170107dec7 100644
> > > --- a/net/xdp/xsk_buff_pool.c
> > > +++ b/net/xdp/xsk_buff_pool.c
> > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
> > >
> > >       pool->fq = xs->fq_tmp;
> > >       pool->cq = xs->cq_tmp;
> > > +     pool->cached_cq = xs->cached_cq;
> >
> > Jason,
> >
> > pool can be shared between multiple sockets that bind to same <netdev,qid>
> > tuple. I believe here you're opening up for the very same issue Eryk
> > initially reported.
> 
> Actually it shouldn't happen because the cached_cq is more of the
> temporary array that helps the skb store its start position. The
> cached_prod of cached_cq can only be increased, not decreased. In the
> skb destruction phase, only those skbs that go to the end of life need
> to sync its desc from cached_cq to cq. For some skbs that are released
> before the tx completion, we don't need to clear its record in
> cached_cq at all and cq remains untouched.
> 
> To put it in a simple way, the patch you proposed uses kmem_cached*
> helpers to store the addr and write the addr into cq at the end of
> lifecycle while the current patch uses a pre-allocated memory to
> store. So it avoids the allocation and deallocation.
> 
> Unless I'm missing something important. If so, I'm still convinced
> this temporary queue can solve the problem since essentially it's a
> better substitute for kmem cache to retain high performance.

I need a bit more time on this, probably I'll respond tomorrow.

> 
> Thanks,
> Jason

