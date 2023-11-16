Return-Path: <bpf+bounces-15170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59EE7EE0E8
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 13:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E600280F52
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 12:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821552F535;
	Thu, 16 Nov 2023 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVeoENNt"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F80118B;
	Thu, 16 Nov 2023 04:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700139158; x=1731675158;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uEqo9LNzZa496ZJ4mi0UxqWPBWSWN5Iz//mrBMbapjw=;
  b=VVeoENNtEyi2u3MsIAY5hEyomCADSxSgxv2sCvjXk/RvuS/+lDYhNAW/
   oeu2GR2Doc2V35aUKppApYsjT7Ia0NHhyNeDV/eox+7hKm6Hh4rQFnofT
   QtkMJKrhKFNsRxS0eqa3PXLzVbBIrPsoXR+vGw6NFfh2aAqdO8Ln0dPtK
   IepZQu5jrdT+cwSLFUZRgVjovzP7Xv5Xj+yPEmyOFOTP56sZ4+RnbARWF
   fO8eQw4RV9MXOZ/Q+FhBDfVG+Uwtu9OFfiHNZ2NE8vl9KMUsshFN+cBoI
   Bx4MO4wte2y2sFF4QE/uFrgpCNes8Vz4B2Abw2QigzxjtcMQcleTjYJ/J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9722728"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="9722728"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:52:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="794488574"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="794488574"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 04:52:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 04:52:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 04:52:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 04:52:35 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 04:52:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwDB8IARTwkpA46ar+Fk6g26s4ewJBdcYvyU+JlQvkWwb0uq3bggZoJbhaqMZn0TYNZXB93jJdn2k3ASYIRZIwCFhZdDybbez6Rlbnc2yDHKsv7FGQv7PcbJsHRtjFEwN2sOZ192SsN9ZkyI0VIyNjJA66jZxiQNrquVODEq3fLnXvr6aeHRwbG3h29PjZ9/WNWvYrawT27qiy0osHX1o4R1zFk4cYtMsTtL7zKZ9BR20jcs3XRhIV9prdNz78m5a72IkgQNehhCWe0sjjFYs7Iv1BUWiLqa/gRC11CHTb37RvBqBGqXLkML2TGfHpdkULAKEmTobi208Wfup0s4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTDyuJeqXUOASUmTayMpW4W+ykvcggNipK4ceKGaxbc=;
 b=CysiysyYMIIOdYccvxQgOpBJqnYxMlG6BXbaMA9/3e4ibN6YGl9HwMamvi3G6kb89YykfgNC3/MhNI16IexY6iIEEpqlUikWUpgXE0d94RqfaKKKm53clGx25ChgZcqUsUXeJM5voASjuV7D8roAUtGorRMrbxc4YZF9LpOMxmlGktnx1hw8pNsGKHap0BQ3/BHPZdmuFUz/XTkeM9xxH6SyO/oFvUv8JUAVOCJREsKyq/idsbtXir3BDWkugEBE1b3faDlxYcsw6RnLxXzNpP6u99DQ0s8GBC3IUyRZ/EVLGp0BpydpN91zNVpFhlNRsEwNXsB8WAlhZny/li5mLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW4PR11MB7029.namprd11.prod.outlook.com (2603:10b6:303:22e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 12:52:31 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 12:52:31 +0000
Date: Thu, 16 Nov 2023 13:52:24 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Tariq Toukan <tariqt@mellanox.com>, "Saeed
 Mahameed" <saeedm@mellanox.com>
Subject: Re: [PATCH bpf-next v7 04/18] ice: Introduce ice_xdp_buff
Message-ID: <ZVYQiAhahijwfN+w@boxer>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-5-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231115175301.534113-5-larysa.zaremba@intel.com>
X-ClientProxiedBy: DUZP191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW4PR11MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bc2628-a9ba-4ec7-2a09-08dbe6a2e5bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCpLqAErzA7u4QhibKJpOi5UvBTajJrmmvNuTnBeqn3vbmD3pcsbbGdX/Q9gmFtBuPoU9aqFDvrrrvudXhIh9aqGo+B1/oaHjuBsW2ldGEopGVV8ehu70ynZqTSVT2AyYbkGweHCLLuSJAv2zCFDuHkY0Wk0CQc1dv9VCBPCMOsmlW4oeSXYFvLdEDlHj4/34D4fzEL5uVLH17m7szwl3r6iCzCT1KrjgZ5jo9M+ISV0iTA7A2i11iQbYURlmBIIzRCnrsWEBIvy94CSMqTe0qLoXkjq1ATb2dBfyAQmyl4watBPsl84AN1ikG+zDiKvcfDlMvwbAKxzXzo1iOz+V2EIW4hVmQWc7zXwNI7Tif1jV3eiemDCDVzPnzGQc4mL8N08VAvEJa02EgbRycMD3G+h4Wh5MBNvMoC7gZp6BV7TNDaZAcKG3ika7EW0iEAGRFYXztkiJXpVsOMlDrgSsoEUDTxP1lNZJID8Og16vUQ3CMLw8cKGIlMyLQXlvVdZCGS3j7oJvGeh84MfT8vPXpG9Vel7VSyS7ZecNy/o9DgMTnLMqE6HECJThzCWRbU8P9AgGz90NH7R5eLdNAFnYtWtpxcf4mo4u4eVfRJSUio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66946007)(66476007)(54906003)(66556008)(38100700002)(86362001)(82960400001)(83380400001)(26005)(6506007)(9686003)(6512007)(6666004)(2906002)(6636002)(316002)(33716001)(6486002)(5660300002)(6862004)(8676002)(4326008)(8936002)(478600001)(44832011)(41300700001)(7416002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uxnxC7hmca11UILHip8eDyoZGZd850wPKt9jGu0CcmqDAa6Ib8ygdEKmzwCp?=
 =?us-ascii?Q?D2QWoZTiqv/UUkInL+tlm1HINcjDom3vIH0eYUSkO9u/ad67wgfCZdRlLNAR?=
 =?us-ascii?Q?Kgxt+dKuazGBhkrfLYym+NfF0TXmml+/aSpYqx9vRtUAa4PfUHBa2hEjGd2j?=
 =?us-ascii?Q?2s/9E1tzjl/ONI0go3oaeewINH9g5IB/O4XQAeB+AlVTBgK0di8+nnTpG2v6?=
 =?us-ascii?Q?anO3noymmZnCvOiLE76ZBJtmkzXNHncYWVWaCncwtRBfLPoUQP+fO9ma/f7Y?=
 =?us-ascii?Q?n1CE7B8pqhSzyPKJ/IrbAXp+TS76D3j12zRkHEJJCrFnTJHi6ujUytwKUxvG?=
 =?us-ascii?Q?Ep6cejDfnZTXAxtgMzZ4cwlhZbvZm10mVBIJimS615GNtRroJ9sfv9wdZc6X?=
 =?us-ascii?Q?QfKL+OFxUWYHulY/cqxt2v07JI+oLdZlO7pCiub9KQ6Hq6KCByKTFx6GyY/y?=
 =?us-ascii?Q?gyF8NYAf9itkYFWKOermSNv/nVRTE0/OBq8ERhftdhizuwDXgqs2+Tt62CSS?=
 =?us-ascii?Q?Ttq01axWgzKJn+mGx9SK3tuci3W45kAM5uDZIIcz4PTAOHU8yNxsT+wDlex/?=
 =?us-ascii?Q?PiWn89Y85d7soU7xA89qmFaX3VWuwVJBfm5AzhgK3hILsCU1G7en72aW2xo/?=
 =?us-ascii?Q?Xx/p6OjPDXINlZneSEtralRR0R0eu5HycjtNB5CLYpC5RmJLxWP8iW4qFRYO?=
 =?us-ascii?Q?un2xkKVvHfhtvkjmg8GFbp++NUup9v+R89YrLUBFVl7ez8l2yqZ6Nfhcji8b?=
 =?us-ascii?Q?hRSndIuUk4SrChKKKbvbEAlvTMCFHnUldcpS63NR4nZFkwAC/CUEjo/YRn8+?=
 =?us-ascii?Q?uuh/SFjvG9ZrVlnDWb4itHOw2Km4iEuPzeF2nhairczL07sKqQ4WIBUWzGff?=
 =?us-ascii?Q?9hyu37M0gdUOjWkd832o67mIT/r8CcJUaLcgC6GYqGQWPSv9uoGdv12KHwFn?=
 =?us-ascii?Q?+o6vttCdv8c8uZQDAad1Eeyqrdtc8mPuu++TkzW0DNa9viXn4oA1zaiH/WDW?=
 =?us-ascii?Q?Q8iOz5E5mcWShtQtTZ+FtHIORcgCe020ZhjmNABEkb0Cotrnva9tYEFDvV4g?=
 =?us-ascii?Q?TUwXbnD0u4mAj3mdXqb2knJcjM8q1olw8RbwUeBCZSVX+E6wlT+46PckxT6O?=
 =?us-ascii?Q?ebSulayZlqfwMcSlqIrlDZD13sg6I0PrR0XYrFmo0y3GIu1hCNO5tBoeBXdh?=
 =?us-ascii?Q?DhSzasjRZ+oLyToSRFA7aR6etUQzVmRbG6FoBVMr/ryP5sNJF0J9X8wpC+AW?=
 =?us-ascii?Q?de9pK+QieYSwWg88x1++/AmN9/Wy6eh+U/vxucnWgyQ8IkIAwU8UR1LK9C3x?=
 =?us-ascii?Q?RZGpYWAQ+2W+XtXOWeoX40eqS9v8PpBaxCm5IzHlSCDZLPuZg8FyZF7RjPPc?=
 =?us-ascii?Q?gVYMrLgf7Fz+3RB2uQHTkDvdtokLphFhZo1wDQS//FpgUYxGz2TsZusTHGcE?=
 =?us-ascii?Q?4J76ZRd/yUf+J4FyHoZgGXYGeynXDgdbOnTlTyqGYuap8gPf7Fyy8b9Pe7IG?=
 =?us-ascii?Q?3EP7J4iEkWVNgFvhZGyaz/JNVyXiKwdnJHaVH6J/AVXriH9O/2oonbOJ9P9c?=
 =?us-ascii?Q?hBeRuoJUOfb3fmOZHDW8MGRQCrHbSm2p2wLPsJW8civ7jyvRIx4onHRU3+CY?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bc2628-a9ba-4ec7-2a09-08dbe6a2e5bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 12:52:31.7690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICGj74MolDKltyUpN5EaGW6CGddoNuEqp+emEjPOf7TX1JywjKzUi5mLOkobmD7ext1KZ9gyYYFgrwWBC2LBpz1Y1vKepcN+aDj0zQfnen8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7029
X-OriginatorOrg: intel.com

On Wed, Nov 15, 2023 at 06:52:46PM +0100, Larysa Zaremba wrote:
> In order to use XDP hints via kfuncs we need to put
> RX descriptor and miscellaneous data next to xdp_buff.
> Same as in hints implementations in other drivers, we achieve
> this through putting xdp_buff into a child structure.
> 
> Currently, xdp_buff is stored in the ring structure,
> so replace it with union that includes child structure.
> This way enough memory is available while existing XDP code
> remains isolated from hints.
> 
> Minimum size of the new child structure (ice_xdp_buff) is exactly
> 64 bytes (single cache line). To place it at the start of a cache line,
> move 'next' field from CL1 to CL4, as it isn't used often. This still
> leaves 192 bits available in CL3 for packet context extensions.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++++--
>  drivers/net/ethernet/intel/ice/ice_txrx.h     | 18 +++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 ++++++++++
>  3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 40f2f6dabb81..4e6546d9cf85 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
>   * @xdp_prog: XDP program to run
>   * @xdp_ring: ring to be used for XDP_TX action
>   * @rx_buf: Rx buffer to store the XDP action
> + * @eop_desc: Last descriptor in packet to read metadata from
>   *
>   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
>   */
>  static void
>  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>  	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> -	    struct ice_rx_buf *rx_buf)
> +	    struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
>  {
>  	unsigned int ret = ICE_XDP_PASS;
>  	u32 act;
> @@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>  	if (!xdp_prog)
>  		goto exit;
>  
> +	ice_xdp_meta_set_desc(xdp, eop_desc);
> +
>  	act = bpf_prog_run_xdp(xdp_prog, xdp);
>  	switch (act) {
>  	case XDP_PASS:
> @@ -1240,7 +1243,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  		if (ice_is_non_eop(rx_ring, rx_desc))
>  			continue;
>  
> -		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf);
> +		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf, rx_desc);
>  		if (rx_buf->act == ICE_XDP_PASS)
>  			goto construct_skb;
>  		total_rx_bytes += xdp_get_buff_len(xdp);
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index 166413fc33f4..9efb42f99415 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -257,6 +257,14 @@ enum ice_rx_dtype {
>  	ICE_RX_DTYPE_SPLIT_ALWAYS	= 2,
>  };
>  
> +struct ice_xdp_buff {
> +	struct xdp_buff xdp_buff;
> +	const union ice_32b_rx_flex_desc *eop_desc;
> +};
> +
> +/* Required for compatibility with xdp_buffs from xsk_pool */
> +static_assert(offsetof(struct ice_xdp_buff, xdp_buff) == 0);

That should go to xsk core as a macro and should be used by ZC drivers
that support hints. Useful stuff similar to XSK_CEHCK_PRIV_TYPE() but
check is from the other end.

> +
>  /* indices into GLINT_ITR registers */
>  #define ICE_RX_ITR	ICE_IDX_ITR0
>  #define ICE_TX_ITR	ICE_IDX_ITR1
> @@ -298,7 +306,6 @@ enum ice_dynamic_itr {
>  /* descriptor ring, associated with a VSI */
>  struct ice_rx_ring {
>  	/* CL1 - 1st cacheline starts here */
> -	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
>  	void *desc;			/* Descriptor ring memory */
>  	struct device *dev;		/* Used for DMA mapping */
>  	struct net_device *netdev;	/* netdev ring maps to */
> @@ -310,12 +317,16 @@ struct ice_rx_ring {
>  	u16 count;			/* Number of descriptors */
>  	u16 reg_idx;			/* HW register index of the ring */
>  	u16 next_to_alloc;
> -	/* CL2 - 2nd cacheline starts here */
> +
>  	union {
>  		struct ice_rx_buf *rx_buf;
>  		struct xdp_buff **xdp_buf;
>  	};
> -	struct xdp_buff xdp;
> +	/* CL2 - 2nd cacheline starts here */
> +	union {
> +		struct ice_xdp_buff xdp_ext;
> +		struct xdp_buff xdp;
> +	};
>  	/* CL3 - 3rd cacheline starts here */
>  	struct bpf_prog *xdp_prog;
>  	u16 rx_offset;
> @@ -332,6 +343,7 @@ struct ice_rx_ring {
>  	/* CL4 - 4th cacheline starts here */
>  	struct ice_channel *ch;
>  	struct ice_tx_ring *xdp_ring;
> +	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
>  	struct xsk_buff_pool *xsk_pool;
>  	dma_addr_t dma;			/* physical address of ring */
>  	u64 cached_phctime;
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> index e1d49e1235b3..81b8856d8e13 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> @@ -151,4 +151,14 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>  		       struct sk_buff *skb);
>  void
>  ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
> +
> +static inline void
> +ice_xdp_meta_set_desc(struct xdp_buff *xdp,
> +		      union ice_32b_rx_flex_desc *eop_desc)
> +{
> +	struct ice_xdp_buff *xdp_ext = container_of(xdp, struct ice_xdp_buff,
> +						    xdp_buff);
> +
> +	xdp_ext->eop_desc = eop_desc;
> +}
>  #endif /* !_ICE_TXRX_LIB_H_ */
> -- 
> 2.41.0
> 

