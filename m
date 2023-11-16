Return-Path: <bpf+bounces-15169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB087EE0DC
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 13:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DA6B20B6E
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DB52CCB0;
	Thu, 16 Nov 2023 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBroogll"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A0185;
	Thu, 16 Nov 2023 04:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700138998; x=1731674998;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tm9AXyZZfXlnxwo/yjz392WVQbT5vqyhpJIsrcTdWZA=;
  b=OBroogllx4BjRdb5LyNZkfATbWq2CBuMRVhAkc9FZCwxPjdFVfIHpm0b
   EFv2+61NejBlj3CjvDMd1QsOK96fu/plsaBV9ZGFi5sJYVuVhNCPn7b/F
   P5qGUGmOlhXfbfHKtpOB0FJPcC77XVeWh/XehUB1Z7AVju5wp4E5p5xpl
   CifLbUaE1jCy12O7Cc1aGEvU6UnNseY6aXwYTTiW0vLYRHY+JLLAENoXD
   AB0LzjLalyW12agdFAdr4DW5DdjPF2ualOGzK5elP3UYweZPBWabvrsrV
   G8USPPecolO4LL8D33UChtxjf1hF9F5iw2x/Y+tPiYVY8KH3+4G4Ar7Jf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393933316"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="393933316"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:49:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="6716289"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 04:49:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 04:49:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 04:49:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 04:49:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 04:49:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAzMujgi3fXZDfmrvYNz/2FKPSr++Z5Qt/rtWTWlDKnIiBji+cdiJcHfzfTpIqCl7fjE1TYM8yERtNXjWosIcUVGoDgt63tj78J+rjbzqy6duKHfjHPUaof0qQqkdIP5NeNDfedHo0uah9ueLOf3uOgLPb0ByDbbTQPBUBju8PJLSSm2MkMqSxNbNCRSRm1crHRFHye2B5axin2jmUiB2UzMWeUOFkDmqWPip32lKkRg3vtwn3miqbZcLBXHwLjnFGvNYPqWliIhO/pUMGbsFXnDSgvQ/sdQbhAzbNCkQQHcgyE4A1VH1GMqUCLcwLY9ZAGuE9Aw8hYbY2AGpR/zow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYFo/uwhVQeYFn6/kTY5ad8iE214z5N8UwipHJXl5v0=;
 b=Dh+iyWHX1tG/Y9oUR5xCbL1OR7+tnKdICrrfaV0rY56QjZnpfmLwX+jdyFV+3gtwyKPuwrGntECD5c8XV05zbO7BXYccKq1N7lmowggscM2zEAZK2qViEu/+39E7EPXAmhSQaHdl8ZpIbvPXwsU0LhRdvQsVcsuuB5PBMjO3bD15NJvCn/3r01WVDZb3bg+x2yi3avVsTZOWEMpLcPEluRFD/1l1N5++GiI75/i8yqZKtfslQEr6jQAmqMlm93MZCyj1PTFTWl0Uh637xms1rhLrku2JB4YsJFdpsDxk+5/sYxGAdQo/UiZW6angXvv4T4Xku4fSiQ/3dbYTWGRA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW4PR11MB7029.namprd11.prod.outlook.com (2603:10b6:303:22e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 12:49:51 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 12:49:51 +0000
Date: Thu, 16 Nov 2023 13:49:36 +0100
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
Subject: Re: [PATCH bpf-next v7 08/18] ice: Support XDP hints in AF_XDP ZC
 mode
Message-ID: <ZVYP4M30jzb16RJl@boxer>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-9-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231115175301.534113-9-larysa.zaremba@intel.com>
X-ClientProxiedBy: DB9PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW4PR11MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd7fb10-ad0d-49fa-48ba-08dbe6a285ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMk3okP3LM0p73MEx0XDe8BS1aw+ToBX5njqBBdD5JlpnOZqljJnkQhazK2ohJdFn1EmInAVRo+rafBOYBc3ZycPLlMb8QHfAQBmRQFEKtrTS9ZwW6l6oB1E3cOoXIKKNxOjFt/S7cGsMjk+ScLrJddM1tV3KDCXE4+PCPER2ZXGEv2cNquGhWv1WMPA+y30QoED/xrHU/rfRSDRTMFIJY3KQhPBXsy6tsh7+7IZ4+BzwvzDE8ofooOGVP7yr4NXSknFoahGVHHzpfJWnSkxXbwVGwpQtYMssX+1sjXNiRAMQ1lYhhJRsNOGgZnpK6kjcNJlDI0iiBLn7xTjGg3Xhp2o3koJlz/AbtoMTMk1+JFSfoYcsfp9feZHBqTx/DvuyAXn6bIQ0SEx3wvKtRsvN9fTX1kikogQeevXwakFCmjEP+MMYvXvAzu80wngI/r0kCeLalF5OeoKnV060+nwT95K4xb5kAwTLnU0yBDOT0A98sjNxG9MWnTlPI6Fe/KlQX8m1SYOWNQk6rAmOSI/7jByWBOEfFN2wH8huWG4vYSsJRHpmgdH8miQvrTTtnRx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66946007)(66476007)(54906003)(66556008)(38100700002)(86362001)(82960400001)(83380400001)(26005)(6506007)(9686003)(6512007)(6666004)(2906002)(6636002)(316002)(33716001)(6486002)(5660300002)(6862004)(8676002)(4326008)(8936002)(478600001)(44832011)(41300700001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4x6y5kubpdX2HFyrnG4rp142SE75PcN2vXceti4EzyghXl5UOH/7WAP6hwS/?=
 =?us-ascii?Q?Ff6GarwkmjM+O1UqaC7ze/GjjbCEjLEDfABK2sFqkS+r608nV9OEe4/fhWvK?=
 =?us-ascii?Q?CdoyFgR7U897PkQqHQ8zHvXEsYdCCBqNnQXmIDiEVfYNM7DRjcKRKNDfYiCz?=
 =?us-ascii?Q?IJTJFUo/XTRaK193smHqP9YOVmXH+hVT+a3E3m/kiiOlvONr4NiR5vI5m88e?=
 =?us-ascii?Q?J10Bh8nmrPZIWMNyJHEiPt8j68GLJIAzjIU3nWDOzJCGMmtxa5eRyPXr91PR?=
 =?us-ascii?Q?nTUL/kqM3qTcVtQNbzlb47IgLcuxbcXcnCJhOvHJUIT1T/sBf9hWzyuCxgI8?=
 =?us-ascii?Q?2WclX3zVvc4NySQNyCJoFu1oxo5dyqb4Nu2WyXpd7o1udqqp9pm6Z9BRsNbE?=
 =?us-ascii?Q?FBxWTXB1nmeXdlPrMSm8/4c0WsuisNQNJ17lWN0wROZXPkfBdcTTYyO8x6Dy?=
 =?us-ascii?Q?uhhFIuXtDvRetOgeNdDRue9CwKAyRIibJ3gfo2sTP046fUvKe2hgJWDH4l/P?=
 =?us-ascii?Q?FOxjA41O5suj9nU5Nmvg1r5wUAaAvtvJ6jEIHVQhcPB1DoDpAAFOM2DUUuZR?=
 =?us-ascii?Q?uObSVvZ8ndaNUtqAGNhyqZuJliSV06RdRC2uXa4VqtV/RmiY+P2oQfqVeRrH?=
 =?us-ascii?Q?940ffgsjBz9VbBG1YWarTgFvPs4tfRosiTFgtr9WIi6230Nj3ZHQ6KSOSGwU?=
 =?us-ascii?Q?Cc/jJTbT9ZdhRA75qxwWvRFsfmVgdXKSDAqP3xo7e/Xa7ee6iDrWu/jKWUEc?=
 =?us-ascii?Q?ItkMk+Z5yvYoPW5cH3p3kSRsFSyYSHyUZg9DPoNy+Yp9spRBuw39hGDOjqxd?=
 =?us-ascii?Q?31OFTWHUU/17KyuF8psgz/RNsaWs6NO5YiO+RZeWu2vfjwcLFz7De7wkuAql?=
 =?us-ascii?Q?7rUz310aHVcpTQcin1VY0Y6WujhkB3Kj19n19GWhpVgj++TwFgXPqR9MvBh3?=
 =?us-ascii?Q?MYbsA073r9IH+Ig1Oj1mhwd819Fw8Jyncwnb6hZDszNj1fXOVPs+fmOUiE5j?=
 =?us-ascii?Q?KRkrI5BnnxdXRZtXDwpzN8h8DXI1C1FGrujZQXQcC8cfrjqf0l7veSGrMqPc?=
 =?us-ascii?Q?1gzWSDmhXpEKHf/fIz40GxBp2QFJh6KDpWoMscJVAr7ZQHyeBlLeJf1Gi6cY?=
 =?us-ascii?Q?fRyuNHOVMmORl92OhIWxT1two4NGbjhVWoGMEXOHL1gKtg9n0kU0u+Qcspr+?=
 =?us-ascii?Q?cxJGhdylsHAigIop9dP8Z31zyf7ZUo2xX+6YDTnTO9Fp6+gpUmxCOXr2LCyI?=
 =?us-ascii?Q?lzurgQZftlvt1/NYk4brk+SIwB+VNJIoqYv+o13ZJ42RUaYUs2YfrNOydUfP?=
 =?us-ascii?Q?N6qdCHvJZbwjKSlUzLEgKDoTJi5s/DWF7Me2cWh5/XDmWesm4isMYxCy4CAX?=
 =?us-ascii?Q?jSKVVeeeKlbTc/pJ+bFSQ0yasP1/0NdLdObNP6bO/m+dbkeb1mw2ZGqNpoEu?=
 =?us-ascii?Q?BqX0NR0VT0MmkYZRy3LQwQQI3deYol3QcS3sXkj793TumkeF/8gOd7eJ7Dm2?=
 =?us-ascii?Q?kVMXN+tUNQjhRNr+BjnoJTvqddG/4hqhFQrR25Li1RlFNESrDARQMIEP+JeO?=
 =?us-ascii?Q?wx8K8oShYHrRE5gI97OgR3d/ajAFuftixQrmIIZ0KfK46txZcrIM26zTDBnD?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd7fb10-ad0d-49fa-48ba-08dbe6a285ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 12:49:51.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIIX4nuE/P+EhjgStvxRnyiHqjlr5XfjPabZDb2jcBNvOvZln2VO+dTG5zq05FmZBfOIV02ADSaj9MaUdx1pixGBl+qLhozH+KWA5lO9WhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7029
X-OriginatorOrg: intel.com

On Wed, Nov 15, 2023 at 06:52:50PM +0100, Larysa Zaremba wrote:
> In AF_XDP ZC, xdp_buff is not stored on ring,
> instead it is provided by xsk_buff_pool.
> Space for metadata sources right after such buffers was already reserved
> in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
> 
> Some things (such as pointer to packet context) do not change on a
> per-packet basis, so they can be set at the same time as RX queue info.
> On the other hand, RX descriptor is unique for each packet, but is already
> known when setting DMA addresses. This minimizes performance impact of
> hints on regular packet processing.
> 
> Update AF_XDP ZC packet processing to support XDP hints.
> 
> Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 13 +++++++++++++
>  drivers/net/ethernet/intel/ice/ice_xsk.c  | 17 +++++++++++------
>  2 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index 2d83f3c029e7..d3396c1c87a9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -519,6 +519,18 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
>  	return 0;
>  }
>  
> +static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
> +{
> +	void *ctx_ptr = &ring->pkt_ctx;
> +	struct xsk_cb_desc desc = {};
> +
> +	desc.src = &ctx_ptr;
> +	desc.off = offsetof(struct ice_xdp_buff, pkt_ctx) -
> +		   sizeof(struct xdp_buff);

Took me a while to figure out this offset calculation:D

> +	desc.bytes = sizeof(ctx_ptr);
> +	xsk_pool_fill_cb(ring->xsk_pool, &desc);
> +}
> +
>  /**
>   * ice_vsi_cfg_rxq - Configure an Rx queue
>   * @ring: the ring being configured
> @@ -553,6 +565,7 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>  			if (err)
>  				return err;
>  			xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);

A good place for XSK_CHECK_PRIV_TYPE() ?

> +			ice_xsk_pool_fill_cb(ring);
>  
>  			dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
>  				 ring->q_index);
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 906e383e864a..a690e34ea8ae 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -433,7 +433,7 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
>  
>  /**
>   * ice_fill_rx_descs - pick buffers from XSK buffer pool and use it
> - * @pool: XSK Buffer pool to pull the buffers from
> + * @rx_ring: rx ring
>   * @xdp: SW ring of xdp_buff that will hold the buffers
>   * @rx_desc: Pointer to Rx descriptors that will be filled
>   * @count: The number of buffers to allocate
> @@ -445,19 +445,24 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
>   *
>   * Returns the amount of allocated Rx descriptors
>   */
> -static u16 ice_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
> +static u16 ice_fill_rx_descs(struct ice_rx_ring *rx_ring, struct xdp_buff **xdp,

Might be lack of caffeine on my side, but I don't see a reason for passing
rx_ring down to ice_fill_rx_descs() ?

I see I introduced this in the code example previously but it must have
been some leftover from previous hacking...

Help!

>  			     union ice_32b_rx_flex_desc *rx_desc, u16 count)
>  {
>  	dma_addr_t dma;
>  	u16 buffs;
>  	int i;
>  
> -	buffs = xsk_buff_alloc_batch(pool, xdp, count);
> +	buffs = xsk_buff_alloc_batch(rx_ring->xsk_pool, xdp, count);
>  	for (i = 0; i < buffs; i++) {
>  		dma = xsk_buff_xdp_get_dma(*xdp);
>  		rx_desc->read.pkt_addr = cpu_to_le64(dma);
>  		rx_desc->wb.status_error0 = 0;
>  
> +		/* Put private info that changes on a per-packet basis
> +		 * into xdp_buff_xsk->cb.
> +		 */
> +		ice_xdp_meta_set_desc(*xdp, rx_desc);
> +
>  		rx_desc++;
>  		xdp++;
>  	}
> @@ -488,8 +493,7 @@ static bool __ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring, u16 count)
>  	xdp = ice_xdp_buf(rx_ring, ntu);
>  
>  	if (ntu + count >= rx_ring->count) {
> -		nb_buffs_extra = ice_fill_rx_descs(rx_ring->xsk_pool, xdp,
> -						   rx_desc,
> +		nb_buffs_extra = ice_fill_rx_descs(rx_ring, xdp, rx_desc,
>  						   rx_ring->count - ntu);
>  		if (nb_buffs_extra != rx_ring->count - ntu) {
>  			ntu += nb_buffs_extra;
> @@ -502,7 +506,7 @@ static bool __ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring, u16 count)
>  		ice_release_rx_desc(rx_ring, 0);
>  	}
>  
> -	nb_buffs = ice_fill_rx_descs(rx_ring->xsk_pool, xdp, rx_desc, count);
> +	nb_buffs = ice_fill_rx_descs(rx_ring, xdp, rx_desc, count);
>  
>  	ntu += nb_buffs;
>  	if (ntu == rx_ring->count)
> @@ -752,6 +756,7 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
>   * @xdp: xdp_buff used as input to the XDP program
>   * @xdp_prog: XDP program to run
>   * @xdp_ring: ring to be used for XDP_TX action
> + * @rx_desc: packet descriptor

leftover comment from previous approach

>   *
>   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
>   */
> -- 
> 2.41.0
> 

