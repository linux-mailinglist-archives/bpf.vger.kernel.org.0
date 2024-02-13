Return-Path: <bpf+bounces-21855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266F485357B
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 16:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF951F2264A
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE705F546;
	Tue, 13 Feb 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bygj/uLd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C6F5DF25
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839969; cv=fail; b=kTNYUB+QVvvodFiD89IHajDgoM9ayqaUEN55ePrwk28ycvKSk0osfZHNHxbrBEUysCeTkZVkgDcTRnnMeqDFZK4d2ZDwNaR7WvL9p8RbHPiWTEC+JM6mtSysVfTQXz9jl7Z9v3e2LTgrRAMsddx4oyKSeDMn5MuSJAyLksuDGOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839969; c=relaxed/simple;
	bh=Wq/L1fGpakBUv2Yi2EH4Iky00DjpK/VA/xLjaVzBTYM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PyVLWiT5a7YVt6hBrGm3+OZ2Yb7ndVyrI2yS5e+7rhUlp4QT8c6CIObbNBAcLgblDLdvVvIzbBFOSQBw90AqSlUeLDBjvr1d6Fq0APB4PiOTtlsCOi4uTlaBkUWgUixtha8zzcdRAiV8UFJRj7yVSs+/00cTv2Dutzi1lAxiu/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bygj/uLd; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707839967; x=1739375967;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wq/L1fGpakBUv2Yi2EH4Iky00DjpK/VA/xLjaVzBTYM=;
  b=bygj/uLdfYRMTCIQPO5YH8y783JDnZ65KZzTQ6H5de/gHCYBHrqIyXY9
   G568ctYqKBxBZfcUu/Lhzyf+K/OVCcwScNEbhjNUSLTtd5+gntvGcCRzV
   9KP7YrKPWpKpnDbuT/l5Z6a6bIgRhXf8UWP+v045cHc4zf8AmWSOHOft2
   NeS9M7bCpx5vd5zgs2+rAPcZLWQaAa2iNHyZvCLLfISehnSi1eobtR75x
   KP/llSehRHfh9p7S7ArIJz2/qKzoxGq9VHa/9MLw9zfHI6o4QNXVTDuwI
   +ePFloGyr8+xBCBIzbvTFo0/QNFQwQFBcHz17+fX2Dv2Kqt+nLP/yc1nI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2002747"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="2002747"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 07:59:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="2888693"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 07:59:21 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 07:59:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 07:59:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 07:59:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 07:59:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQJ0q0WTmIB3+d3t67FWkbaoAXyUqdKOINHMsBplNOCayPpfOSljI7hSeBbknC760ffgm1ku+Fs/1/cIxT3kz3lQATsjs63QYAE/2PC7fAkqsP2ODB00HB6kOZw+/QXQMsynk2oquBXCc35rWv2p8u4ITCTpQDDwFmjAF6upJgH/onSAlZEWWZi1shSCl3Rz/JpwGYnmfJaBDnKACo2iIvuRwxpD0tAixqbaGChwEIYN4s/S7bj+iuuy59KoldKLn5t0ul/pUfUl/X1HnE8XhvdzNAqasD7A31a9gC2geBWxC6f2oLM0BqThNf41kvYDQj0KRturMp0wyCGgmTS5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUggjIeGDOKY7g1hp75fPXl8SMRGMxLri+h5+LZ3iCA=;
 b=XOwzL4jrawgjrxKlaTchsHy9N7OdxjnvTdIdGV+hoALq2bpyKWSCF7NV2hhkuokdkqrJLxxP0D7djAYl2aPk3GSobQST7C1GRlRoPu+LqrR1mfJJOhESGOJG6lDG4KsXC/UY/02npfOGXUhZdduaziFegGdqaBfLqLYuXXDmuf2hweNYOJ6MsdY1Pv5nuaPHKzvD6CCLPdGJ/y33iDz+KSd/xjxMs+WIZlU7SOwmbE8vdThwDyaPq3onxdZOSFZoFRDEhwQPyNwdo2rbkz7Tb1mP0TgNUpPVshjxLbVDylyONxOD0uxzf3osmCp4oYdBQb48fbUMVrGuXBuIiHp5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 15:59:19 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 15:59:19 +0000
Date: Tue, 13 Feb 2024 16:59:13 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <bpf@vger.kernel.org>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, "Jonathan
 Lemon" <jonathan.lemon@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	<daniel@iogearbox.net>, <ast@kernel.org>, <andrii@kernel.org>
Subject: Re: [PATCH bpf] xsk: Add truesize to skb_add_rx_frag().
Message-ID: <ZcuR0bm73CNKpCLR@boxer>
References: <20240202163221.2488589-1-bigeasy@linutronix.de>
 <20240213153737.6ukdoJKc@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240213153737.6ukdoJKc@linutronix.de>
X-ClientProxiedBy: WA1P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::22) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA0PR11MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 88fbec78-8802-4160-38d5-08dc2cacbc9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syC7lR59vDcn5MuJ6IZSktdBPKPneZxH4TZlTRuNrMgNWaV3P1JRlyLYSyzeZT72WEAM7kgK3zxhSCqIKDf2RrR0j+6Oa3//pDg2VkWnv+CDv0neWXO/dreeobWjQbmKfA0zA83Cw/NxrWmyRqdXOVkKHGSXhNKYsLNU2IaNYgIeNKnnoDIdp3+ma4dBKz/LzIGLGTV2R//whp6DgJoE9NQEMpkX+mby42mrggokDvEImPUX1Lm+1DNKH4yQK47J8qIG767ox4M+UT5Pr7QRkZRvNtKmOHP7sv4MylQF873SCO8MkD+MbR8UaPtqXpYELONtuAHQi297+OPBXcU0/gRTHo7uik4dq0Vb+r/WhecGSOCs2anLAGSha5dJv+pngiC6s/x/YJtac6lyYg+qUBGbhMd11kc5/lpPPYMhOk+hJcbAaqe/Mcxl3/auxG9Jh161/aJWJRJ6wRHY1IP0PFHRNjdbJ/cizhG2LR/VuxATBOmq6JN6YP+D2U5pEYMgkdedrzr4nBC5lzRi/QMgI1lW0bnB1snb0eqq/jMMfnaf+nQkHQQtEGB6SfwM7dfm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(346002)(366004)(39860400002)(376002)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(478600001)(53546011)(6486002)(6506007)(44832011)(6512007)(26005)(9686003)(2906002)(4326008)(54906003)(66476007)(66946007)(5660300002)(66556008)(6916009)(8676002)(8936002)(316002)(86362001)(83380400001)(82960400001)(38100700002)(6666004)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?63XjFkX9pgQfAd8JTKuCBncQC7JprRVFPfsrgVKtHjanOwXIzLn0nVOejO16?=
 =?us-ascii?Q?yjo+IwZEUZJIZX3MHrV9xaOP0jNSczsGmCyTBw4n2ilyKS900Y3nAN3HHWUQ?=
 =?us-ascii?Q?KxryJPeOIw1cS6ooReL/XnjoaSTHUyAj1EkmvL1lebRntHQn/bKudU9RDBnj?=
 =?us-ascii?Q?HqFvjjXVyv0SR6KI6zk9OBSvYSW8sMzE9pIt8aP9CjeLK1oXTDIM25Q67Pxb?=
 =?us-ascii?Q?3nFUHd8XglWny2aEMyGqq1VERkRlrYX6fqIMgaIDZDvhwEziuVqGH+W0BVAB?=
 =?us-ascii?Q?3/G4q/WlEbZLbt0WxTSKkVWAfPHSnr1co3+y1FwTMD2k2LBDGAfRQ2yTgg7/?=
 =?us-ascii?Q?AY0lwhCNhBhZ3vyC43FVmKLi56HrjA9paupE8EEuEi0BaG65SWJtC85I6Mof?=
 =?us-ascii?Q?sj9E8ht0LS4bN0JgkrpUVJQ/dyiI8uWzZr//xy6TsbLR6rsVLypASiJUlJRu?=
 =?us-ascii?Q?2zvovulKDV5N/PEE17sfAXC4KRz4xSVE9DiMTdeLDja1KIvf1A/3JlNGG6NF?=
 =?us-ascii?Q?56x4rdS4ZccIAumnxChuPTcMWFjEYlhK+dFwaOf0o8448cischtTaVF24rkK?=
 =?us-ascii?Q?JbphTiIOMJu9vYA0evESNZ1O/cHndPJHJkCoHgKy3qusF3tpJFpIzRZON1UK?=
 =?us-ascii?Q?djq8s48zVvi7YZjFJuy07Ps9QWmeEgjaATLQoP4+StPnJFDFJs3UqEzGAykV?=
 =?us-ascii?Q?3UUkMFpFE+QhRrwRPFGCqqeqh0XLwAo0OiTBMaQxtquue600H06/ZZi0XC8v?=
 =?us-ascii?Q?s+cDGHHWHCA/LG8hbFfLWExzqgXt2SsnUJHQNLH3UokUHAf3w6P2Z8zhDW6c?=
 =?us-ascii?Q?cdZyDm+K4zxrIjAz1MeTDah3p/Fit0Ulpup4Yn5a+VrEtV5QCS8ja0Ppz1z8?=
 =?us-ascii?Q?WoRVTFIa7kPx/4ib0/hLyL0nlJ0UP5Bxu+KnQUqCPghwCG7A3qaeTDSgH4ai?=
 =?us-ascii?Q?f45dI2YXlh2rtL4F1CX01tC4Ol4uPyOLk2sBKx9jXDc24hDEhNrBxEGHBZNi?=
 =?us-ascii?Q?ESXn84PUsGVabpEtqdrNgyCdyM2KgGieCOvaD1g+PFCftqP0Y+vQJM3yfWvb?=
 =?us-ascii?Q?x507BGQZXewYPYQu1jj/z77j20ItsXlvN9tNvR5TqYO8QWxxoA9xIgPEB0bC?=
 =?us-ascii?Q?cTlVZIVTI7BcSyAcSYV1U0Cbt/mwCnAqzmQIniJWW2hQAK77gl+lNcUfr/6A?=
 =?us-ascii?Q?62koNa0zRpyzSsV97hI+8kr9dYYgkdrXnqJMVRCf0tD4BpsY/CkIAp75izzH?=
 =?us-ascii?Q?HwSseCavJXeRMvCi7Qyg53lPDsXFyPcMiB5dCYfTO2trU/Bmwxdmt1w/4mP+?=
 =?us-ascii?Q?3LKo2Lt/48pOrxXM/0d23MxCTTK4Rv0I1K7xUrn7jXKTyiRkgFTxNNO3OgoA?=
 =?us-ascii?Q?ALe36VPZjWjIL3862Ti523LYKGrAyClvW5t42tReRxor4LglucE2wsB1Gyxa?=
 =?us-ascii?Q?1qTAdOTVbvbFYRyv1hIfoSxyQQHK+iD6w/c/9MRKSMGWAdaBYidD0a6Ish0D?=
 =?us-ascii?Q?NP29tb55ovd8N6Y4uxtzs0JyN2jtTyVsYkmubD5Ai/bEwgdw1xQyzU9lwxuL?=
 =?us-ascii?Q?TpLoEWUJjI75IHAe3SRVsuG4YtlWrLtKj22bFWM0zY/ULVeV4OmeSXJrTkgG?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fbec78-8802-4160-38d5-08dc2cacbc9d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 15:59:19.1451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/5RTksuIt0VZJNNnZP3cm3lYlTDjcU8uS5Mp2PjOTtAtMXxd0V+74TLe+uRlhXnHfFf6AU3EhRaZmONXP4SCsAL9wzXPt243FoqrxjnCdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7752
X-OriginatorOrg: intel.com

On Tue, Feb 13, 2024 at 04:37:37PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-02-02 17:32:20 [+0100], To bpf@vger.kernel.org wrote:
> > xsk_build_skb() allocates a page and adds it to the skb via
> > skb_add_rx_frag() and specifies 0 for truesize. This leads to a warning
> > in skb_add_rx_frag() with CONFIG_DEBUG_NET enabled because size is
> > larger than truesize.
> > 
> > Increasing truesize requires to add the same amount to socket's
> > sk_wmem_alloc counter in order not to underflow the counter during
> > release in the destructor (sock_wfree()).
> > 
> > Pass the size of the allocated page as truesize to skb_add_rx_frag().
> > Add this mount to socket's sk_wmem_alloc counter.
> > 
> > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Is this stuck somewhere or just waiting for review/ etc?
> Patchwork says new and the ci failure on s390x seems unrelated.

I acked it week ago or so, maybe bpf maintainers missed it as I don't see
them being CCed? Adding in now.

> 
> Sebastian

