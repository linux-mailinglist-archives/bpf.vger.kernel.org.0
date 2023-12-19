Return-Path: <bpf+bounces-18312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CAE818CBC
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 17:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA6128CD69
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 16:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FD82D7A6;
	Tue, 19 Dec 2023 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gy8XFy97"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BE37864;
	Tue, 19 Dec 2023 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703004249; x=1734540249;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ykuAbkeaqE0D/b+JULX5LpT6xeBx6YW/ELeyzaQQQeA=;
  b=gy8XFy97LXkxxpNaM6sQaONyBvNurQkvr9BsPnS12yD4oIVabclmI9fn
   vm65i2Vs409iWCUkOCQrvXBhXDN3M8HTbygIPyNsXJ4nVNaHZtPFuNA99
   zU+iGZtjwjgaYcaWE6JEhtq59wDITUqDkVmfHDyZDFqZR0qXiNLfjJmnZ
   ZJSOy1QZ5avR2ZlObaQaDQ/tM6anDa4WrF+p6cYJ2rGvviHWTIppeVeYP
   TpNhoYQwfSe9I8jPIatoWBK3w55odVsDwICdpTxIKM6xIzHdcxafnTaV5
   n1I3HKIJbKUY4JvAb+Mnk67UgMLh8pWb4su0JMxnN/Jd7F14nPygwZ1xm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="426818361"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="426818361"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 08:44:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="24265786"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 08:44:08 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 08:44:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 08:44:07 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 08:44:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlCMyp5UXDBQ915L2xAaIq9BtbaMQbK03/SFFg0dgtiCpYv14o/z1UAk+p4KGE6X/6VhHJpyobZ9Q1MqCVSrRdNJpsrd5BHW9REQHw2CWD2NKOEPBEa5EyPbvDPCuyuKeZglaKaiQJSiV4aDejz2RJcYeTzvbCihSs3CtvDvi8Lzfs8jXPjBMW1B+KsTFVbY2N4BKuxlntF6HFwxZhvXtjUt2Vbr+QWEiOYdUy1VtB7ieaf6MoepUINYu6sLQuQFc97YFDGYtFYgLrMKitvnQgtR14fvZhNIXZvr+bIiWOvpvxOhTuiy37GltE+g9UP83uL7pxdzdoCndmi3vyLU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0UYXtG+4DaKamFVfpCRUy9JNoQA/g4cfEHEfs76r4U=;
 b=gBGjpJGru43IIwWYxLNgUBMbboVG2y0rZpqZNGZB3MRZDYPlY0bC5IcBX4ICUEjE3OhdTpCtIxdCtEny+zlSLXZszhrPm2vHbrO/8U0bhiVdFK2xXd8zaH7gnTEIdi64dlsvPDuJ6ohDgtitUeUr2flsilmTfyu6S9CY0TDNCjSMU51Ub6sFhC4KZukx849Oa6zjaCTnHqv73+8mrKTsmjCPQMTSYr5pmwPA6s1TVj6Tol+07P29khH32uhFKN/HOVceSNl78DxdgFX7o75lm4YAWfKcBCFtyQqV9Tf5bnX8Ut8KGptLosmRoTAYzyzm9674pBGFglWrCoQcg5UPbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV8PR11MB8462.namprd11.prod.outlook.com (2603:10b6:408:1e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 16:44:04 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 16:44:04 +0000
Date: Tue, 19 Dec 2023 17:43:50 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Larysa Zaremba
	<larysa.zaremba@intel.com>, <magnus.karlsson@intel.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<bpf@vger.kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Simon
 Horman" <horms@kernel.org>, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net 3/3] ice: Fix PF with enabled XDP going no-carrier
 after reset
Message-ID: <ZYHIRswwTIvmstSH@boxer>
References: <20231218192708.3397702-1-anthony.l.nguyen@intel.com>
 <20231218192708.3397702-4-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231218192708.3397702-4-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: FR3P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::6) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV8PR11MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 271a1d9a-fb31-4c71-c6f7-08dc00b1b5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DaNEbWVxbL62eg7AZXXOY4R7uaUl/E5LowzsT358VodXDwMDf6yPCZNu34mUMc784aZXouPCW7qaP+cFiYrWEOkoek0diE4iW53eOQuiGDF6vTv1tdc4A0PeDtCi+/zZH4MUa+/GvR1wRFlx6cC2BWjqxWuetCGvOeQkYgctFwKKqYoYNVW/ugWmzoRfaQdh5ERZ9JJaxanDwZWiczZ+AO68QsuxI6t3GGGUM1S81PYA8yz3HBYwjXmiBTvgqMJcdeQcA8ogde4MdaDLZMKRDoKWXc7Dlo5r2JH1zPkuHGfdabPxoaNVghqU1EDLm7TTglcNFNKTb2IT6FPU/UsmhuBYBDDwoMesQEo5eIepwjkEIiBVY6+sgsLl4HRbQk5ALEoYeUMgdXNsfqGhkS+YXQGAsJEDerOQCLL1KGYEI++q89olBrF7QVMryHbWDw27rKLoSie2IXUZzRxPzx3mOxZZ+9SFvcxxIXd8S2P1bFqGJnLHSI+m/rLYXgSFA4jrHgWDo4NQI7GDb6gAftjKPZ2MZ7ztDkNzIQcyxG6G0qAKTgUC5WQHa1vcytCNA6NI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(4326008)(6862004)(8676002)(8936002)(5660300002)(2906002)(7416002)(6506007)(6666004)(6512007)(478600001)(44832011)(66556008)(66476007)(54906003)(316002)(6636002)(66946007)(33716001)(6486002)(41300700001)(38100700002)(86362001)(9686003)(82960400001)(26005)(107886003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?24t2l9W6+HyvD02/MsFM6rQaBZTg4FRJsGv0AeSJryJacb6hREG5OJQNLBVD?=
 =?us-ascii?Q?O1ia4Sy0klN8ytrkyw+e256X8O67p3xUQ6j0Nd0WKVMjlAjz49uGj+E31oHv?=
 =?us-ascii?Q?2DNLfuoEIWgmRtKQi6MbrYf2bleXvkz/1EdU96CI0Nz9uErDNBTaCgoBC4nO?=
 =?us-ascii?Q?YzGA70V2BUkMAJYQVW9Ht1cpAqkFvdiLEEGyuYhipbWwKZSwBjJiANYP0Xs2?=
 =?us-ascii?Q?QKlHcjSzH2kFBQx0TiqnS6Ks+sB7PeLvlPg3fDRs4lawNtGKAEJxo9D3JU12?=
 =?us-ascii?Q?jcqjUbG/gwSXJ5WOWxPWVBdV8aD5BFrgJkqwrFqym5dy0e4+OhhrXCb2AJCr?=
 =?us-ascii?Q?dzfBTaKxpXNuigC/XJt/oMkdfeQEY1hO50L94CiSRmtXdz9gjwtaGEOWY+LV?=
 =?us-ascii?Q?PDhCr9hwNDjJnyDUIRNrDn1Yv1Y+++bzHmVJGLbeVumPD/g/z53UIOHh24Tb?=
 =?us-ascii?Q?SXkaMdE9KLxAGF8pC50wMvWvt3w9L3MVVGWyeb54DNj6o6NgQ0L/lxPneHww?=
 =?us-ascii?Q?j7WL97JdOFOTM5uTzmMSeHIPcInT8fB0geCSnxHCg3Wln7URdj65veAxcw01?=
 =?us-ascii?Q?nsHGnXhdhT0caURbItBV84aycoN6QeWZuJN6kLFIywqv5o86e/Iqv1gtaTim?=
 =?us-ascii?Q?sxL3g8aY4IvUWNSCx96AlLkV/yqP7Ya+U1GoE/PktGRQoR5TGNhLY/NkjtnM?=
 =?us-ascii?Q?6rfVjEOJH3+n3b7auzt1a5ifj6NuYtgtce/WtfYKUmMfdB4Rw3fMkjsbfy8h?=
 =?us-ascii?Q?vJxFAKj7TgKuRTTJfDd2Lq3zHUofzbhqLzTKpudugA5wuxfmzzEO9eM4rhdC?=
 =?us-ascii?Q?T89Cx4AbrJWwO1twnkpHHYILya1ICTQAM0CLIUr3wWj4BdXmr5MT/G8nU1KZ?=
 =?us-ascii?Q?xmVV4xhEePTNMi9fGu64ofFEqI9cVRJIuJ2KJ0iFkObWKUwnbaoIofRSTNrl?=
 =?us-ascii?Q?7zucQiESytYPstMOUL4z3F9atJfxif2f9sPxAJadZMtVkqcCTjyKyDHR51uB?=
 =?us-ascii?Q?JtE+IIqAdggR8F4eVHquH80QCUZIc7BYN7jx+NQiH25Rp4GVuDYgomvtcSp7?=
 =?us-ascii?Q?zgiMH59rCmZjP2gEZsACR7vgSJOeZM1FltGlMho5HtrVo9emAQxzCQVpA9Nx?=
 =?us-ascii?Q?47hybLc+LbvvL99aUCdwURC6sIX1sqb1JslKvx1ApB7QgjCZCUxcX4vPwsvr?=
 =?us-ascii?Q?wFwQfOxmF72Qv6mEwdXZ98mutIHMbgkRy85g0qTLitKHwkzCE5GLNJoFN2R/?=
 =?us-ascii?Q?KKQQCOvE/r+6UazyalOQWnc9eA9qLwIyfzpOEOoiPih/nkriVfEZ3GIRiXPr?=
 =?us-ascii?Q?3z0H4L4IsjHXyMpdCeawPv5fmWLVJ4J83HnZpFVXVezGQaD3w65F2pLUowXd?=
 =?us-ascii?Q?69UmBe/olvAaPMCDIbQHtOpvI891SBNuppr5Fd2o+j1Qy2SWmw8m84bzQAdS?=
 =?us-ascii?Q?BXOfsps53RUMZECQcpUymYY9J9iR6NJ+kBsf+ILqnP2iiP9X16/zORCdJH+w?=
 =?us-ascii?Q?MRHmQDQxhnp7aatZNWb8caQFZMjUryUrIfV0nXQn0NTP41r23sqx8bK6ZGPo?=
 =?us-ascii?Q?GBbJ8uembd3lmWTsB5xTxCGzB5sUZLrt0JEmxa2shsRhh3lboOuVJV/Lox/6?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 271a1d9a-fb31-4c71-c6f7-08dc00b1b5f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:44:04.3412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: In+PC/127FnSVz7LVcxCmtz34ur65o/pt7dzI39aGqWO2kDuJhQi36UUPvam/6EFOiFvSODRwoSnE4Bt4K1QTsrIyEzkmrrE+IsR4Vv1Tzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8462
X-OriginatorOrg: intel.com

On Mon, Dec 18, 2023 at 11:27:06AM -0800, Tony Nguyen wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> Commit 6624e780a577fc596788 ("ice: split ice_vsi_setup into smaller
> functions") has refactored a bunch of code involved in PFR. In this
> process, TC queue number adjustment for XDP was lost. Bring it back.
> 
> Lack of such adjustment causes interface to go into no-carrier after a
> reset, if XDP program is attached, with the following message:
> 
> ice 0000:b1:00.0: Failed to set LAN Tx queue context, error: -22
> ice 0000:b1:00.0 ens801f0np0: Failed to open VSI 0x0006 on switch 0x0001
> ice 0000:b1:00.0: enable VSI failed, err -22, VSI index 0, type ICE_VSI_PF
> ice 0000:b1:00.0: PF VSI rebuild failed: -22
> ice 0000:b1:00.0: Rebuild failed, unload and reload driver
> 
> Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index de7ba87af45d..1bad6e17f9be 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2371,6 +2371,9 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
>  		} else {
>  			max_txqs[i] = vsi->alloc_txq;
>  		}
> +
> +		if (vsi->type == ICE_VSI_PF)
> +			max_txqs[i] += vsi->num_xdp_txq;

Nit: typically we always preceded this with ice_is_xdp_ena_vsi() call.
However, in this case I suppose it doesn't matter much, as if XDP prog is
not present then this value will just be 0.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

>  	}
>  
>  	dev_dbg(dev, "vsi->tc_cfg.ena_tc = %d\n", vsi->tc_cfg.ena_tc);
> -- 
> 2.41.0
> 

