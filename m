Return-Path: <bpf+bounces-37171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 792EC9518A9
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 12:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D481F23DF2
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 10:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919D61AD9F1;
	Wed, 14 Aug 2024 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAGBiPWA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC9913C684;
	Wed, 14 Aug 2024 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631201; cv=fail; b=Wb3TDDaET02Wxqefdkx/pf4NeR7OoiJxqXcNHwF7OTvRqXqG25hC83xIEQw6imXm8o/svbK5+VEPBElb2ukFFDEWaE1ykPfbiE4hSQ4Odt3tYi6LyoZrzcJ5wVhxS3KGRis3TJ0awq7Exk+Uk/RCehHuQHu3Dwpk9fNkjxBBWAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631201; c=relaxed/simple;
	bh=r/OPvZ/WijGtTOYWA+pn+BC9INrYD1MGYWFeUXZYTFQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oPylWyyruSEoqm8iQpIe6AugeSOVsbaIttKp5uC7n176FLdyIjhs+30qpBqTz2G89J1VvmPHP3smTcMTZZqxHOwITDG+RpaIW7vAov1hifQxKFkKnSYjvAoes4s1pVAEiZ2DXpfcDLLrUiOhd6VmmnpYfU56oeOPSBb14mATV7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAGBiPWA; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723631198; x=1755167198;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=r/OPvZ/WijGtTOYWA+pn+BC9INrYD1MGYWFeUXZYTFQ=;
  b=MAGBiPWAP+vUeF+pKnq015Ghaz0yqpXzfc8+jl7Gj98oDf/u+hSIhDAv
   6U2Zur4wXsY68EaLY6n5C/g/pyLbTuYV48q37gLCg68L4D3Vkoy1ppM+S
   qkKK29AXOplNbjmYCAto9puo5ok3qH2S92pkPHiqMAwhnZEqBXTt8U7fL
   D8zuK5D7QJco8wHj44lQkY7jceu8sRHtMTJmpKh9LbiB2pF6B9F008Jhk
   YtRZtgomvLXWqeUMaD/4cPV6qgEY8wY5eu0OjuR3fiIdlDBJYVclEBE+3
   cJJSi5MZeXWCB9ZkOFQGnQZQsFVscKjmnTZXMocVyM2SU+i1u1y1zcrRf
   Q==;
X-CSE-ConnectionGUID: 3Adqe64SQz+iZR+9CL+dfg==
X-CSE-MsgGUID: nJvxtrCmSsCtTlY3BRBRxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21989786"
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="21989786"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 03:26:37 -0700
X-CSE-ConnectionGUID: 8oixF0DSTlyZJZWk2hfFLw==
X-CSE-MsgGUID: ecE3oiX2QveHw/YPO02ZnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="59256935"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 03:26:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 03:26:37 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 03:26:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 03:26:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 03:26:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2/K0wHfskLMpB2ogfyEItDT+OhXxsBGR7/atDM8JGFRTaE+8b2BFxP0fg4FAhzcOR5yixUxitJzlml6hP4iiVQbbBYafcfWITOEExNS3c4eAjbZvutWOnF5zX2y6gaDwqHOBSstnZ4joB6FAghH5JOM8Uybd9laAa6VDyxjgH4xlVDxXe1JfXxAwt+qq+3+wpo1MPCH0vDEZJ0c+nad4pXWVZpVDb4JwDANRzFs4gJrKcSu+qy0jBWc2t/8tiMUwUWcswJ78ZhIbp8za9esh73P/8z1kROS8/Qj56G+uu9ucgqOyxk+HgkvUniVIxevjJ6ho3jYpAUU7LFknJD8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuTjny6APdlIXD2IUXz2z9UblvVR1eRB+7I/0MCLk/U=;
 b=Wkm9zCwl07CkPZk0HMW2p4dzPfiArEPsIP9PCjpYpbCVgMi3/JXPyDG5BKmRv1Y2wgbN7vgWvvs5X3q3+OzAVr4571s+LHbNiL4p+461IgBW595+GyBzggfRmrzYt4CdAflD5OIbj+/TAvbm96xXT8nDmiewfaCB1EWbnflsLTO8VEPC6l8Xh+G5re0921PikxCrCz/v8tWAYv6aYlUbfqOKES0qHJ9w2e9JeIjEGYjO0Ahwfa1DKyM4xzd5/viu6d7DJycnkOsl4DYBkw6nHab6VBfGfdvCMkk5tTgCrIPBFe9Ih2KFtDo0FHocYD+S5BdA2JgsrnCy7kTo4TXTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB6494.namprd11.prod.outlook.com (2603:10b6:8:c2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.32; Wed, 14 Aug 2024 10:26:34 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 10:26:34 +0000
Date: Wed, 14 Aug 2024 12:26:26 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
	<magnus.karlsson@intel.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<sriram.yagnaraman@ericsson.com>, <richardcochran@gmail.com>,
	<benjamin.steinke@woks-audio.com>, <bigeasy@linutronix.de>, "Chandan Kumar
 Rout" <chandanx.rout@intel.com>
Subject: Re: [PATCH net-next 4/4] igb: add AF_XDP zero-copy Tx support
Message-ID: <ZryGUj7HBasW7aRI@boxer>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-5-anthony.l.nguyen@intel.com>
 <Zrd0vnsU2l0OTsvj@boxer>
 <874j7nzejz.fsf@kurt.kurt.home>
 <Zrxw+FI7rbYHXN2d@boxer>
 <871q2rzcw1.fsf@kurt.kurt.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <871q2rzcw1.fsf@kurt.kurt.home>
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ed144c-0dfd-46c8-c8c2-08dcbc4b9234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: gFiTBJW9vh0qu9QmJjPQXCDjbBzYNQoSUueU2Qco2cvHZSzfQdsxhif7wCB2CCy7xUkyqTV5bQKuuEjvMDNdf3GgzuA9FjANYA2WWere0drT1WL97AaNWzwdAgGeOweLMTxe69jyLaR/NEVwOwtwCXdwFVzDuWpCqelCa6FI9FYcMsXqhM4+AjcZEI6t+ZOpTwPcd+jW4mahI9YI5ovjzfevYJerNdUjXR3J0YAngJCCdaDVo/ybf6sJ0IJ4fDGwyOnHZQEpAdLu6kua6tUQ0eBXQav/wChUOvosSPGGXbyA0+V4kWCZP82BO2+7c6L+ITfjiDWWsBKfvYdhRPDB5qydQY8zJaNvfkh4BnlkUCLKO074m5iERQrWmiRPlyVHiziePs9db2FLxZLaDjKg7fRRASIEe6uzNygeu8VIwkbJofzWfMuUFjNXq1Zn2iaT8L4hscGigDwqKJkBeNY72GjnOBCGaRXPUWr/xjh0ppjq4YZcdudsPgODZ/GqqiG3vxDi9ISr/P5gaZUUNZS4JThfKGL20Jv/DaSSZqxgM4fjI3sS5k7XvHVG02Az+vmOGQrpfUWMXrtYHJ+s2s9YvuCy36Dhsmw0jqN3WtRfZCymBzDjQB6IY2qqE52n0WuvfgaVoIsvLPn7lGdNG3kC8ItQ7BiW5mWHQFYWADF2e6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PLnl474bZ/L9qs+toSS5xKPTTSy2mQe5L9+UX8jWX/lqmWkWwDO95TxFaap3?=
 =?us-ascii?Q?lQTISTMPXGT25RfEI11X6VZdoueLhhYJeXwZcz6bdksLubJ4fqX3w3Fi9PvD?=
 =?us-ascii?Q?P+WvLZcpi7/Qs7KInUUXJOmcR3/jK/s6WhEIQRLqEiCo5ySb/4tIS6NyWSNQ?=
 =?us-ascii?Q?e0ISXUFh9tklrUrucHkyVkvZVU9pyUufa6GmzXEj25WmMbEOUsuPUYlFlEPz?=
 =?us-ascii?Q?PaIfsBU2HgCtxSRxqSpvL3DRiI70Ps4GjjwGEMrWj4PTsIkhgItnpa7W3Ezj?=
 =?us-ascii?Q?PT23iIxfZGkMsdtW4muBPPwUJKc3qvXx/Xm1rrWhft+yHfAIyVJ3jZXc6GH9?=
 =?us-ascii?Q?gF2QmTA5el7yMMICzxyv3LonJgGDoq5Ic+RMP3sF3YwDzcddY4YyxAKiQV2C?=
 =?us-ascii?Q?Cq5X5DJPrzHwZFqkkLdaWloT4JgKel4Y9NSi0fm9leLKYNpZ3WrY0+vM4K4l?=
 =?us-ascii?Q?AodzVZJFYaX//u00ueifY2dJHACk9M1PO0Qvm7ajGJyL0AyZOqmOdFBCphJA?=
 =?us-ascii?Q?aoYd0s93OkoGoTLT7aG2EfSfuISdIz7eV7R8dMer4OntAzMV0sgy6ptGw2v0?=
 =?us-ascii?Q?nWyuQKUrBLTkFiMQT+NTZgsLQPxwmboM5GE9vQdfX2pDNaBvGkm3ylcyL6hv?=
 =?us-ascii?Q?hqKlZsP0p29NkDsdFR2TpXvcox9sDNL5qqCldiimCuofxiwdOovMWwqaKP7/?=
 =?us-ascii?Q?XO6zA7pdyQFpKEGJ4LMc5K8uHSir90kruAMcFIqBWri+sF2wUnE4b3i+51nX?=
 =?us-ascii?Q?BGq397tOiQcmjhUZTRqCOpgQhUDifXotKj7U9sM94eoe6p0AWxzSmydU701K?=
 =?us-ascii?Q?Tb8U+kv/4RvZch+gppGlPaRj6D7xgD+SvXgP1RStE8CKw72iw7ip7CUocdRV?=
 =?us-ascii?Q?5h1KhajHziVz28XKSti1gFbOeBHNkscc5TFz2q+U4cVCf/pPOfRwoQu0piMX?=
 =?us-ascii?Q?KBHR9gOHgOpwCyDgHfUyyR/QtRaPXrV5QSxJBbbnmbhl/YJQQxgatnFDvxG2?=
 =?us-ascii?Q?64wOVdJmZ6EyPWg2AcBYO2JfKC3Xo1Irv1KFpv8JncTEoHmd/FV5IpP8Hr/o?=
 =?us-ascii?Q?2bClZGMymN9m1gYmEfJgkh/76DPgz3LcT2pITwhnOeoZF1mn382X3Q7kXVoL?=
 =?us-ascii?Q?GVn8k+7vtmrA5FNrv6rHZhnyrHK8vhF7kqhfUo55CI1p5qgcU7aghFMBgYrX?=
 =?us-ascii?Q?DNsJYJFW6d1bzaG4D3gttDvcthndHPp699lbzgWZ1QHpCzRfgCHqRApiUhTw?=
 =?us-ascii?Q?IRWQuJZlDaMlrE+jASYExWE4sfWjf4Cs/f8yLr7EomYpEth32sqTr7Q8I/O5?=
 =?us-ascii?Q?GenInWwbmIHPGv6+QFO63gyIWxzpqmFc+n/kshil/3bayHjRIeTacN2Q75iK?=
 =?us-ascii?Q?kd4mQQHYRNPokJIp8qIXsGKqWqCFeRaa7Mp0Ow+/ydRU/lEsUNANTjX9Ff+/?=
 =?us-ascii?Q?RpDmjpPG8STZdDDsZbxDJvvWSLUBtJ/1n35QHU+lndW7K7jFTKzUS4BexWK1?=
 =?us-ascii?Q?RoQM9hryG/lNXWQfxPAb/c9loP0BOWM4+Hc61wmnQqmWkvyO6b3zKd3ZrQj6?=
 =?us-ascii?Q?Mq/Ln1QGNK7K8cwUxMDE877uEyknkCksDivCpULHn22ZOYeZ75sGFOGIQfEJ?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ed144c-0dfd-46c8-c8c2-08dcbc4b9234
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:26:34.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9qlIjiYEuagfoQVPXbIexAWvRF10BiHxItn3lqOxH00S95Sqn+b9yZ1QSy6eKMRGhwCOh3WE+1QA+SL9LCFQFwioj1odR4+dDrPqpCwuFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6494
X-OriginatorOrg: intel.com

On Wed, Aug 14, 2024 at 11:12:30AM +0200, Kurt Kanzenbach wrote:
> On Wed Aug 14 2024, Maciej Fijalkowski wrote:
> > On Wed, Aug 14, 2024 at 10:36:32AM +0200, Kurt Kanzenbach wrote:
> >> On Sat Aug 10 2024, Maciej Fijalkowski wrote:
> >> >> +	nb_pkts = xsk_tx_peek_release_desc_batch(pool, budget);
> >> >> +	if (!nb_pkts)
> >> >> +		return true;
> >> >> +
> >> >> +	while (nb_pkts-- > 0) {
> >> >> +		dma = xsk_buff_raw_get_dma(pool, descs[i].addr);
> >> >> +		xsk_buff_raw_dma_sync_for_device(pool, dma, descs[i].len);
> >> >> +
> >> >> +		tx_buffer_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> >> >> +		tx_buffer_info->bytecount = descs[i].len;
> >> >> +		tx_buffer_info->type = IGB_TYPE_XSK;
> >> >> +		tx_buffer_info->xdpf = NULL;
> >> >> +		tx_buffer_info->gso_segs = 1;
> >> >> +		tx_buffer_info->time_stamp = jiffies;
> >> >> +
> >> >> +		tx_desc = IGB_TX_DESC(tx_ring, tx_ring->next_to_use);
> >> >> +		tx_desc->read.buffer_addr = cpu_to_le64(dma);
> >> >> +
> >> >> +		/* put descriptor type bits */
> >> >> +		cmd_type = E1000_ADVTXD_DTYP_DATA | E1000_ADVTXD_DCMD_DEXT |
> >> >> +			   E1000_ADVTXD_DCMD_IFCS;
> >> >> +		olinfo_status = descs[i].len << E1000_ADVTXD_PAYLEN_SHIFT;
> >> >> +
> >> >> +		cmd_type |= descs[i].len | IGB_TXD_DCMD;
> >> >
> >> > This is also sub-optimal as you are setting RS bit on each Tx descriptor,
> >> > which will in turn raise a lot of irqs. See how ice sets RS bit only on
> >> > last desc from a batch and then, on cleaning side, how it finds a
> >> > descriptor that is supposed to have DD bit written by HW.
> >> 
> >> I see your point. That requires changes to the cleaning side. However,
> >> igb_clean_tx_irq() is shared between normal and zero-copy path.
> >
> > Ok if that's too much of a hassle then let's leave it as-is. I can address
> > that in some nearby future.
> 
> How would you do that, by adding a dedicated igb_clean_tx_irq_zc()
> function? Or is there a more simple way?

Yes that would be my first approach.

> 
> BTW: This needs to be addressed in igc too.

Argh!

> 
> >
> >> 
> >> The amount of irqs can be also controlled by irq coalescing or even
> >> using busy polling. So I'd rather keep this implementation as simple as
> >> it is now.
> >
> > That has nothing to do with what I was describing.
> 
> Ok, maybe I misunderstood your suggestion. It seemed to me that adding
> the RS bit to the last frame of the burst will reduce the amount of
> raised irqs.

You got it right, but I don't think it's related to any outer settings.
The main case here is that by doing what I proposed you get much less PCIe
traffic which in turn yields better performance.

> 
> Thanks,
> Kurt



