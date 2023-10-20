Return-Path: <bpf+bounces-12841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3F47D12A7
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 17:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554A8B21564
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12E1DDCE;
	Fri, 20 Oct 2023 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvFEUl4z"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D9B19BAD;
	Fri, 20 Oct 2023 15:27:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A1591;
	Fri, 20 Oct 2023 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697815674; x=1729351674;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B//XlOOI8/ZhjgixWGbdG9Oyz2fnQq231XFRBwJBP+g=;
  b=SvFEUl4zBqyszQwKYdazZmtMXnp70vcvf2h9jnFKic/HRMmJ+cz6WgUA
   OyMREuSAoo5BUXJmiIigFG1dzX+CUx0DXhOJxpDRVLWp8K5oEfUHPbkwI
   SKB0dU5nfM4rgOoWfckODg/sGDUxlCiqf3QVCInC55A/SFlcrGe2ml2Ot
   MQZmMwHeSu7DLM0cu5twS7WkHuccXWAdHEQpfgHSWgkUbh+sf+1yJkD7u
   WkQtV4qPvJ8pQn0qcUq1wPB6rPMNHedb16g0M2sSpAI4HnD+JWZEh8RQ3
   E6QD5TQEUs4i6odc6kZpw9zWf+NDZ8DRf9yzzf7QsxwmNk22uhlSz0ANG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="8080390"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="8080390"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="707255858"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="707255858"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 08:27:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 08:27:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 08:27:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 08:27:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 08:27:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOFuNxidv5Rrm9y1xFdgTfsOSUnxKe4N1I69iFegdBbP2e5uaE/zLtd+3BPcOaRERy0QUEDtwwP+GjFP0i97xVNOM/yxsxO2kziQYcmwPMycgEkgxInv5DhngmC5XmZguBb6O4Su+LUD2Cv2mLuLEtA9kioWXGc40cL+aehs1X6q8AbpIR8rH/6IXhNfEr8iI08SatUaBPa644XqR6Hsm7OM+70wOvgZc+khyK/eG05YTclubpqmmWX6W+vET0NQhLvZYmz1CTs3fBPzDogUopD2xgDt3u7ioMiwM+AMWHav9nmKLwCqGHlEo/v868b3kuBctTyN2zgA5XntCu1iEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOe5+/nzbYodSJoM9PH+okz2OUzJwopXxXC03MgDuEY=;
 b=iNOnmfGPwv5qij6aGV/WI2x6Y896rzPfJdBWMEyxyjOi6qGQl6CskmonZSIU/FoMTt0ySfWel8wq2Uov+NJSoJNsOLYxc+gdqU8d/Aq6e+rwIDY/oLbfc30lqvz23UkeuesjN5NnHAjiE4Xlcaz/hNIW+VSIV0uZdlGB49D+muXKx394qkUs23zVqUe9msWLy1WjtWzD8ueZ5hTQMuxkS4gQN3Vy9KAx7kbHr//NOzv24hezqFbkqa45bjasIAOjRalfiBObH6JaZBsYFY+iu4P4FkSMYyFEOHdq3xZckrHclzxYVXrzPbea4n+lHKYDTSxB4yj8NkbQ5vEe9v7HTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB6952.namprd11.prod.outlook.com (2603:10b6:510:224::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 15:27:49 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 15:27:48 +0000
Date: Fri, 20 Oct 2023 17:27:34 +0200
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
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH bpf-next v6 06/18] ice: Support RX hash XDP hint
Message-ID: <ZTKcZu2PVgVuFNNh@boxer>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-7-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231012170524.21085-7-larysa.zaremba@intel.com>
X-ClientProxiedBy: DUZPR01CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f687fc-2738-4125-48cd-08dbd1811dea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Vr+q5bwusNvP49Qp3ZvPAzCeSdPFguSh5jcC6U5KoHwUKenYa2znDSmd0evrFVC1mfOMP5YlqYAPEc8b9l0bt+/6zraEZ4C848jWGR9sD4DbTkGLbSfWkrBFnjqJFTQI6GRx6WYI+YOApAOQWTS+hkMnqK7nvDLyItCddfZm7sWNul578YG43y885NjKQJwcuoOxSpNf7N3OdErVkMH1YhViYY8r+DegX0OE7Osy0BMGHnrN2yRTXXmgOw8TIxrAnAS8yY4xIkRvIWC71smTKEb/Du/ZPX1igQf7O9BvtfVVm/IJObrBq2xAExY4xF2Kn0nedpvuHeyuMnHKb0LGN53AbfRE1TOqvCZSYrC9VA3GcZTwnrN2c/6+xetfpuryG2fCgK1XVVnDBCgrb56msPCLndv8kyCFnFPdlBhGn7eGA26hghhQoE4zZFRAHR6kc0eWT3sWAgMi9VmGMkvsmq4q7K+R5cl+nJaEUsmrour0YyU5tYthGdByDR3IZrYKuVCL05ymuVrHVF63ilI3SfVk2uQOyHpi9q0hjQ+SXA2ugoLPySyUU/EyUMPZ/Z8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(316002)(9686003)(6512007)(44832011)(26005)(6666004)(478600001)(6506007)(83380400001)(2906002)(6862004)(7416002)(8936002)(4326008)(8676002)(5660300002)(66476007)(41300700001)(66556008)(54906003)(6486002)(6636002)(38100700002)(66946007)(82960400001)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5+PPv7J4lhzRjHof7O+xkDzGQwy7hm+n3qMmn7tUMfCCpWCq+b23oV1XaSph?=
 =?us-ascii?Q?kMqpYdWNx6r7G7vhqXVjg3ZNTiKtNq/JQZC7sC2MEPGJSj+riytq1bRncwZV?=
 =?us-ascii?Q?4up8hByQo6YjYC45podzw5x08eJRwuxSKK+eDOtOh3BPtxZ4vCcw1eK5nlB9?=
 =?us-ascii?Q?Z72B43BxAXDVkHuxunQ7tdGBd4XZ5Pk700USHKQyeh2zVIm5falokHLIipMm?=
 =?us-ascii?Q?GF6+FcRmt8SuytZ5Qo0FW5JL+3trjFbMrsAEOuDVC1QfqnkHGqxZKIE30wjP?=
 =?us-ascii?Q?S5GDM2Bychvck77rQMUtLR4IwvJLTDvji+JeZ9ymexAnxvhlnBjtVM8ep9uq?=
 =?us-ascii?Q?GT54+Jp1o8JGKAuRBrGGlJ5XaetW9Ee4jRZqTmDLwmy+zUZTSOs4dlL2C+Sd?=
 =?us-ascii?Q?KyahPMTx3ZsLbLWo8N+ihVnsppkNWaPw79+ZIcP7tvVaquziJEmdA+wU5ROi?=
 =?us-ascii?Q?SAN6l1OQZttm5skH66iwFCpNLtQREIcTN89KZ4KIuQpiOoUJYnFJXOwMLHpn?=
 =?us-ascii?Q?LHeFhxB5r8GpzUb8IAL1+wFvlK4oIFDh6w+RI40RvUoV3zsgh5gskK+qWyR0?=
 =?us-ascii?Q?QxBv1uu+s/y6Icc1G1GPGLsdM+qOcek90mssz6jP2BeWekBYC3O1Lue1oiXx?=
 =?us-ascii?Q?WE3x/AwOZMW7zQh+BLUpe/B+lSPVbi9NPKYhV+mkdbod9KXtQSCmOU7qIa4I?=
 =?us-ascii?Q?PxTAsFe7reJZK1HQ8ujl3AmpmQhIUUBHgUepkazmm9WVUK6fK1cw4Zk6LwTA?=
 =?us-ascii?Q?uLdvD7XC5d85gd68u42VIDH4DrPsIMn9Q3rl0D/WSYllbfX06lTlR3Q6qIZU?=
 =?us-ascii?Q?y4s3Gh+inC6mRYHOf6rq7N+Ye0d9KQ2Fkx/XYa2ykfRyor/SWuMevwQ80KGC?=
 =?us-ascii?Q?0c3fOldV1VnqXRuYxFmr5O0nkVgIPaDCrA8bfbPtN3Z9ZxEkU2gNrqsMZR9G?=
 =?us-ascii?Q?TmOhI1eFvvL3wQ95xyM4ooN3hFzarTzoH91q3mE/9h7tyUhIAAyhr2bSgMe8?=
 =?us-ascii?Q?as8XDXhKe0DUREFkpFszg5NpRbK0fHGNTAzLIoZRAR1xQ7/A42EW/XMV706Y?=
 =?us-ascii?Q?MvrKprtQ3IPupNQ5Xuac6+R8YryLhOl0xDopuXYrrum7JDntGrtxQtCQ0lgi?=
 =?us-ascii?Q?iCbkladqOniRgXubZPl9H220JnyFnWvIbjGTbj1l7ZlKROKEbO0WwbzY1TmC?=
 =?us-ascii?Q?S1B5jRS/yhvYeGTXHBzgn+A+zBwTvdhdGWfOqQvl4bHvbVJ4EBr0QuOGdNdT?=
 =?us-ascii?Q?OYy7eAOiOjyqhlZSTMmAL8yaAo8LGL3afg5UIOgRfKu95PkP4+ZSXf5BGIcT?=
 =?us-ascii?Q?S5Ovh5GjzEnSayugL/Qmm+TJNXDo2KajqDfXFj7HSAgjO4DV7rkSrwJ28E47?=
 =?us-ascii?Q?R33D6RKH/1bpbjFZIXy680O5MjLkVgYPEaSqPvcbemJrfLPTfYdSEoOZbA9X?=
 =?us-ascii?Q?W2rJ6gFfTQUKvkf1VNpRnm3FQ/29MZPZ/F/vFW1deI+3cxz8KwQcE1jB3knS?=
 =?us-ascii?Q?n/ayE4pc01OX6rRJEkg0hFf17gOdBJWea9A2xlyjlhOImT0OmvhusQYWO5Vm?=
 =?us-ascii?Q?kBMIdrcGxyYREhFHyLRl+/m0ZDMvZsJgoQDMTcbI7IkkaSxDqbOJ2gnmwOYF?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f687fc-2738-4125-48cd-08dbd1811dea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 15:27:48.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vyXpzF8LwP9Kw6qFEKURVYlgMtnx9vcgQfbyM5BjKDI1kDHQocil80iUaMqJGHQCih4OSBhfrIOHmSEdZaoILIN+SpL9NCcFQg5rKFNRcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6952
X-OriginatorOrg: intel.com

On Thu, Oct 12, 2023 at 07:05:12PM +0200, Larysa Zaremba wrote:
> RX hash XDP hint requests both hash value and type.
> Type is XDP-specific, so we need a separate way to map
> these values to the hardware ptypes, so create a lookup table.
> 
> Instead of creating a new long list, reuse contents
> of ice_decode_rx_desc_ptype[] through preprocessor.
> 
> Current hash type enum does not contain ICMP packet type,
> but ice devices support it, so also add a new type into core code.
> 
> Then use previously refactored code and create a function
> that allows XDP code to read RX hash.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---

(...)

> +
> +/**
> + * ice_xdp_rx_hash_type - Get XDP-specific hash type from the RX descriptor
> + * @eop_desc: End of Packet descriptor
> + */
> +static enum xdp_rss_hash_type
> +ice_xdp_rx_hash_type(const union ice_32b_rx_flex_desc *eop_desc)
> +{
> +	u16 ptype = ice_get_ptype(eop_desc);
> +
> +	if (unlikely(ptype >= ICE_NUM_DEFINED_PTYPES))
> +		return 0;
> +
> +	return ice_ptype_to_xdp_hash[ptype];
> +}
> +
> +/**
> + * ice_xdp_rx_hash - RX hash XDP hint handler
> + * @ctx: XDP buff pointer
> + * @hash: hash destination address
> + * @rss_type: XDP hash type destination address
> + *
> + * Copy RX hash (if available) and its type to the destination address.
> + */
> +static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
> +			   enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +
> +	*hash = ice_get_rx_hash(xdp_ext->pkt_ctx.eop_desc);
> +	*rss_type = ice_xdp_rx_hash_type(xdp_ext->pkt_ctx.eop_desc);
> +	if (!likely(*hash))
> +		return -ENODATA;

maybe i have missed previous discussions, but why hash/rss_type are copied
regardless of them being available? if i am missing something can you
elaborate on that?

also, !likely() construct looks tricky to me, I am not sure what was the
intent behind it. other callbacks return -ENODATA in case NETIF_F_RXHASH
is missing from dev->features.

> +
> +	return 0;
> +}
> +
>  const struct xdp_metadata_ops ice_xdp_md_ops = {
>  	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
> +	.xmo_rx_hash			= ice_xdp_rx_hash,
>  };
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 349c36fb5fd8..eb77040b4825 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -427,6 +427,7 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_L4_UDP		= BIT(5),
>  	XDP_RSS_L4_SCTP		= BIT(6),
>  	XDP_RSS_L4_IPSEC	= BIT(7), /* L4 based hash include IPSEC SPI */
> +	XDP_RSS_L4_ICMP		= BIT(8),
>  
>  	/* Second part: RSS hash type combinations used for driver HW mapping */
>  	XDP_RSS_TYPE_NONE            = 0,
> @@ -442,11 +443,13 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_TYPE_L4_IPV4_UDP     = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_UDP,
>  	XDP_RSS_TYPE_L4_IPV4_SCTP    = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_SCTP,
>  	XDP_RSS_TYPE_L4_IPV4_IPSEC   = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_IPSEC,
> +	XDP_RSS_TYPE_L4_IPV4_ICMP    = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_ICMP,
>  
>  	XDP_RSS_TYPE_L4_IPV6_TCP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_TCP,
>  	XDP_RSS_TYPE_L4_IPV6_UDP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_UDP,
>  	XDP_RSS_TYPE_L4_IPV6_SCTP    = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_SCTP,
>  	XDP_RSS_TYPE_L4_IPV6_IPSEC   = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_IPSEC,
> +	XDP_RSS_TYPE_L4_IPV6_ICMP    = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_ICMP,
>  
>  	XDP_RSS_TYPE_L4_IPV6_TCP_EX  = XDP_RSS_TYPE_L4_IPV6_TCP  | XDP_RSS_L3_DYNHDR,
>  	XDP_RSS_TYPE_L4_IPV6_UDP_EX  = XDP_RSS_TYPE_L4_IPV6_UDP  | XDP_RSS_L3_DYNHDR,
> -- 
> 2.41.0
> 

