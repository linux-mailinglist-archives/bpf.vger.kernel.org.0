Return-Path: <bpf+bounces-15197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DFD7EE497
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D44281156
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE3C36B00;
	Thu, 16 Nov 2023 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbuRKSEM"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48810194;
	Thu, 16 Nov 2023 07:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700149686; x=1731685686;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x1E0Xw3GkS7dtepuC+60PreflwbAJ7u2Ht0VijXLRZI=;
  b=VbuRKSEMtNvXcwhgQ1CMmoOt/TQFNN2ugbzjFRyrqbpYFW3hKaz24yLH
   dWPPEGr8E93J3NRASDrWVBSqXjDFoWgtEKbuELktN7ZXlxxObVMZP1TF1
   0fY+mdH09usVge6K3cRnfAt+Va2GsHc7+a1CTKzkXXex/2lxCHr55zxyI
   7QKVuQyheHY5YqtL+DGLwvd1kQ3yWD4TmwljJOrGzXZ179KcrOr07iPNS
   KfFxiIcqjzQsnSZ1UYgY7u3nNB67ZnS3oF6Hubrpec/Zpsb4EJuoWnqtQ
   oHu2Fr1jjIJz4DD16f9mqTTub5v141/nqcxZoKGg90TMA8KcWzNKMUewg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="395030670"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="395030670"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 07:48:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="765335533"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="765335533"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 07:48:04 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 07:48:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 07:48:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 07:48:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 07:48:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n29oHO5DBCtiqEaz/FsojZjjKGVFzOWH8WMlz/GBLdAVh7hZCcO2fZV6mjqobzcAu+BQPdRBBuel+vG7rYT5OjZwU+JrB3xBrzqrOMuRF9twH5S6an1n8/yhBjdmtterVY2gAunFMfxFN7B6+Qvsj4LFY3pPjf1zSY1Lt9fRaOJoqRsJEPYgbsfkuXCoathCUMWy+5cnNb5XS5VijANpBiekOc7Rg4AVNSAstwVgO28jtPwFigF8dJsJLU5XS9ryTckRZs+ERebfBOJK+5LN8C9pBYy03BvvhU71z/OuJ2qbxwuJU4KbRQsQ/xnJCalC5w8yHYQ+dzfkQscqZSJhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90TrwEGyrqeFYCGGj6pshu7ogF5ow4FS9uNYNRdq89A=;
 b=aByYXC/H/C5CJ/K3S3xCq5VOWbxIgs7gUhHByG+rOvlCqL+DOymlMXvEd1xvOH+towYES4NardMZiH3HtDmPVBZHMtLdHDfekMOv8nawH5MGVXOae4OcDuMGQwma+bj5odlWFOt9TIpQGZ8ZlGwJ2xAU9jq+HxHf0/5G3Bg0YGWQ6o8kk8zQNrecQ1EifhnsrlkZw6n+nWzOiexP6V+CVvRzZlXeWlWYbqbb/ek/ewR168S8W3pfK+xJizCD9P1wo7K5DXLYR1Z29GGjm3kbhI1sTfaVSRevxaBWKSvg2ic7OA0H+HDBRC4FB8ggetznGujn6vz83BAMPQ3z6MxfEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB8327.namprd11.prod.outlook.com (2603:10b6:806:378::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 15:48:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 15:48:00 +0000
Date: Thu, 16 Nov 2023 16:47:46 +0100
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
Subject: Re: [PATCH bpf-next v7 10/18] ice: Implement VLAN tag hint
Message-ID: <ZVY5ohBkChMPJxGT@boxer>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-11-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231115175301.534113-11-larysa.zaremba@intel.com>
X-ClientProxiedBy: DU6P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::9) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7e9f92-8522-4138-1508-08dbe6bb68c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuXJ5ZIOuG1niiDYWX7/crCnnJW5CkwvbRqWLQr+Vb2NAWM5AQvUXOyQ6DtQbh5GpaJkmdpiF37jTRp9b33tN+1UkS0l00Cacw2z4muT3YsmcE8mXD/PY1xgoOF73ouqrX2yyOfREeOZUZNimxQa5wINAfJPuyO0UUNk6VsIaVNY2sovks+P/z+/oCh3YaaSO9wkAKA07qquHrODpNOxWPnxjCFeHekOqU5ZdxNcXK+EPVxExs3S/0zC44zIlMjiBfirOEmX6VebWUNcV+rN7R+J9FMec1npNneh3Q07NmLsVYC34HGKkXftRGq/XhJC0NCdimMVD2e6W/ZQw5cKFP14zZJoZVizIOl+2q37TV0kTP0WBc0XU3csyzMrlU8CDaftQ48WVP9pfGLsYwE2V8+ZdrIp09LDGP7r5Iy4AnvrAPF3MlXjKw9e842KiFABEGSTFoe8fk/CnHi3PF1E8/b0MouZSFBtMN/ZcHCIhM6qb/IxJl46VR6IF5ttuU6YNIp5bf1SeqxlVBDxcV5SpJBfGs6rYLhapSx4zlK2bzbDnDps/riW3Q7oJnbHaLcP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(86362001)(33716001)(316002)(54906003)(66556008)(66946007)(66476007)(6636002)(8676002)(83380400001)(6862004)(4326008)(8936002)(6666004)(2906002)(26005)(41300700001)(44832011)(6512007)(9686003)(6506007)(7416002)(5660300002)(82960400001)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0dw670O+Lxdx3Y9iUM0+DUPEgJEdZkr6zTWvWktZkOE+lFohdUxgkXvTjYv2?=
 =?us-ascii?Q?AOTk2Dm6T7iJlt6/yIkjVju2IpyDL1/dETgy1N0Z14N7cpE4jwEDCXbtU2dG?=
 =?us-ascii?Q?WNB6FbajrieEbMQdT9NZJQSnQFjw0VpCzpZbFYYCF6vOjdT9Tsvcfp2wzooj?=
 =?us-ascii?Q?iFxJm8qyGXBx3WIDhskMYok1eaFZ3WpmTdRh3/gj6M6ajX2pSqqku3jtMedt?=
 =?us-ascii?Q?GJeOtFcimwYMsi6bZE92Labcj8rxbw0XMY8r0pLDQ9o76LlnhqlDwz467+E7?=
 =?us-ascii?Q?zrxfTn/nIbHHYF8qV4N6YUpceZVVypo+tteizt+wal9cbuWHvc3lVNil3vmC?=
 =?us-ascii?Q?A2rzCQ6SwGIES6XjYazQ0at2+W+IF2SAkcW1anIJ4Yuj4fno8nXO9YNv9fOZ?=
 =?us-ascii?Q?X32lmpAPs42eviu9bVuMTMiCRuAnpIk9mp5z5QZ5S4z6eRIqqARy3JvAshtt?=
 =?us-ascii?Q?pEJlWvrUbyb9RVegqi6vzG2h342qtaxJ3LgVaHAPU1ZVEB7MUTQjNdQtgst/?=
 =?us-ascii?Q?DQNZYOblW7SJ/GmiOwKDMROjxKbJ3Jw+ULv2ZFJCjCdQzmML4KTnKUKHKp/R?=
 =?us-ascii?Q?O1NrbJLtR7bP21PsOQrJMFNJ0pWZk9bqhSAsUjX+5hImoq7uLI++kQursHXn?=
 =?us-ascii?Q?4TmXbaAHGRcUFiiqkUETLYn7jVgpye1tLe95sPg1SpWt6Cga+ylzPkckjo7S?=
 =?us-ascii?Q?uPXA0uV1APPlurSH0/eYj2VCzWgQvmkRdTkUCQDjyts+CiCYvfaUwtyRef64?=
 =?us-ascii?Q?3eeHnKOx1DFKxz0LFJTizzvqQyqCAScbv3YBsQEVsar1FY9dVyblQ5XqN5jq?=
 =?us-ascii?Q?P7hHpDDQFIJ9FLpUm3V64mxeWxOHkq9ByIS9EyciYCbKFEyIkPGXZIBFIMx4?=
 =?us-ascii?Q?T42BvT4lYjsURZXUZ214m7gDENnlRoHDTsxHtWL5EZSX9JonpfBapwCifeGx?=
 =?us-ascii?Q?xNZnygpVFQptFHkBT9iXCEJvpDTaJ+t4/4SO4ZoZzcsyMCbJaHw+3L3ZkOVE?=
 =?us-ascii?Q?o5uLcvrwDUshqYc0X3RP2wZxGM4H1NpER6jiE3KO9d/11xMfgCqjB9pGmKdM?=
 =?us-ascii?Q?CBFfnF/Xyrahdr6njFPolioPQPFyOndkw69BqurCspa1+fMfvqXV8pqL58/U?=
 =?us-ascii?Q?6B6qaXIwI/btFym9znDawtDBJKKaD/AE4a4C0W8SQwQb6bPUkcYn0tbKdUPg?=
 =?us-ascii?Q?0TJs1km1Y74uzIoZXKBaa4U/IQF2EQK6WbnTAaYgufTWtd4d9qwX1YAac1FR?=
 =?us-ascii?Q?aRRU7leeCOHGaHf2POjIMvwYXGoK6OzmH8cxpec416mR5GyDK2hTinERTAVV?=
 =?us-ascii?Q?OQ4iLCzzkngd0jri5wPJ+e+kdT5Y9hc7AYhabFVmnjyvpwm61GIhsodXPNYu?=
 =?us-ascii?Q?LhnCoYKdK0O3BtoVZbZeNIwFsAlVkJSiQqVU8cWRgIRq1mbLM+NZv1yaMQjF?=
 =?us-ascii?Q?UvSWz2whHV0YT3yym0mYqKWEAhugb6azY1GvOFux5Nme47PlvvzsDEhVHmcm?=
 =?us-ascii?Q?j13y+Y8X5yQBafnlb5WGK55dhIESc3DdjrZgt7xX6rP6CuFi0I8pVpVY64Kx?=
 =?us-ascii?Q?T92LeR+BiKSphfNeE5BVZDCwHdaUx0rJHG1iCIrB0XtV1NYiECngTCdEG2mP?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7e9f92-8522-4138-1508-08dbe6bb68c9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 15:48:00.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6BLoJGyg/C/r2eBEg6DshEcHmtO6ZK2kYG/S9J45dpZtuOidNkEnZ3kLCIx6DtLozRpET+uLft0YIXAAFFd5vKL2HA5EsHSnINQi7pEeb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8327
X-OriginatorOrg: intel.com

On Wed, Nov 15, 2023 at 06:52:52PM +0100, Larysa Zaremba wrote:
> Implement .xmo_rx_vlan_tag callback to allow XDP code to read
> packet's VLAN tag.
> 
> At the same time, use vlan_tci instead of vlan_tag in touched code,
> because VLAN tag often refers to VLAN proto and VLAN TCI combined,
> while in the code we clearly store only VLAN TCI.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_main.c     | 20 ++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  6 ++---
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  6 ++++-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  4 +--
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  6 ++---
>  6 files changed, 59 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index cfb6beadcc60..485c561c129c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6041,6 +6041,23 @@ ice_fix_features(struct net_device *netdev, netdev_features_t features)
>  	return features;
>  }
>  
> +/**
> + * ice_set_rx_rings_vlan_proto - update rings with new stripped VLAN proto
> + * @vsi: PF's VSI
> + * @vlan_ethertype: VLAN ethertype (802.1Q or 802.1ad) in network byte order
> + *
> + * Store current stripped VLAN proto in ring packet context,
> + * so it can be accessed more efficiently by packet processing code.
> + */
> +static void
> +ice_set_rx_rings_vlan_proto(struct ice_vsi *vsi, __be16 vlan_ethertype)
> +{
> +	u16 i;
> +
> +	ice_for_each_alloc_rxq(vsi, i)
> +		vsi->rx_rings[i]->pkt_ctx.vlan_proto = vlan_ethertype;
> +}
> +
>  /**
>   * ice_set_vlan_offload_features - set VLAN offload features for the PF VSI
>   * @vsi: PF's VSI
> @@ -6083,6 +6100,9 @@ ice_set_vlan_offload_features(struct ice_vsi *vsi, netdev_features_t features)
>  	if (strip_err || insert_err)
>  		return -EIO;
>  
> +	ice_set_rx_rings_vlan_proto(vsi, enable_stripping ?
> +				    htons(vlan_ethertype) : 0);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 4e6546d9cf85..4fd7614f243d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1183,7 +1183,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  		struct sk_buff *skb;
>  		unsigned int size;
>  		u16 stat_err_bits;
> -		u16 vlan_tag = 0;
> +		u16 vlan_tci;
>  
>  		/* get the Rx desc from Rx ring based on 'next_to_clean' */
>  		rx_desc = ICE_RX_DESC(rx_ring, ntc);
> @@ -1278,7 +1278,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  			continue;
>  		}
>  
> -		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
> +		vlan_tci = ice_get_vlan_tci(rx_desc);
>  
>  		/* pad the skb if needed, to make a valid ethernet frame */
>  		if (eth_skb_pad(skb))
> @@ -1292,7 +1292,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  
>  		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
>  		/* send completed skb up the stack */
> -		ice_receive_skb(rx_ring, skb, vlan_tag);
> +		ice_receive_skb(rx_ring, skb, vlan_tci);
>  
>  		/* update budget accounting */
>  		total_rx_pkts++;
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index 3d77c058c6de..886ac8450e78 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -259,6 +259,7 @@ enum ice_rx_dtype {
>  
>  struct ice_pkt_ctx {
>  	u64 cached_phctime;
> +	__be16 vlan_proto;
>  };
>  
>  struct ice_xdp_buff {
> @@ -335,7 +336,10 @@ struct ice_rx_ring {
>  	/* CL3 - 3rd cacheline starts here */
>  	union {
>  		struct ice_pkt_ctx pkt_ctx;
> -		u64 cached_phctime;
> +		struct {
> +			u64 cached_phctime;
> +			__be16 vlan_proto;
> +		};
>  	};
>  	struct bpf_prog *xdp_prog;
>  	u16 rx_offset;
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 26a2c218e96d..63bf9f882363 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -601,7 +601,33 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  	return 0;
>  }
>  
> +/**
> + * ice_xdp_rx_vlan_tag - VLAN tag XDP hint handler
> + * @ctx: XDP buff pointer
> + * @vlan_proto: destination address for VLAN protocol
> + * @vlan_tci: destination address for VLAN TCI
> + *
> + * Copy VLAN tag (if was stripped) and corresponding protocol
> + * to the destination address.
> + */
> +static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
> +			       u16 *vlan_tci)
> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +
> +	*vlan_proto = xdp_ext->pkt_ctx->vlan_proto;
> +	if (!*vlan_proto)
> +		return -ENODATA;
> +
> +	*vlan_tci = ice_get_vlan_tci(xdp_ext->eop_desc);
> +	if (!*vlan_tci)
> +		return -ENODATA;
> +
> +	return 0;
> +}
> +
>  const struct xdp_metadata_ops ice_xdp_md_ops = {
>  	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
>  	.xmo_rx_hash			= ice_xdp_rx_hash,
> +	.xmo_rx_vlan_tag		= ice_xdp_rx_vlan_tag,
>  };
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> index 81b8856d8e13..3893af1c11f3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> @@ -84,7 +84,7 @@ ice_build_ctob(u64 td_cmd, u64 td_offset, unsigned int size, u64 td_tag)
>  }
>  
>  /**
> - * ice_get_vlan_tag_from_rx_desc - get VLAN from Rx flex descriptor
> + * ice_get_vlan_tci - get VLAN TCI from Rx flex descriptor
>   * @rx_desc: Rx 32b flex descriptor with RXDID=2
>   *
>   * The OS and current PF implementation only support stripping a single VLAN tag
> @@ -92,7 +92,7 @@ ice_build_ctob(u64 td_cmd, u64 td_offset, unsigned int size, u64 td_tag)
>   * one is found return the tag, else return 0 to mean no VLAN tag was found.
>   */
>  static inline u16
> -ice_get_vlan_tag_from_rx_desc(union ice_32b_rx_flex_desc *rx_desc)
> +ice_get_vlan_tci(const union ice_32b_rx_flex_desc *rx_desc)
>  {
>  	u16 stat_err_bits;
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index a690e34ea8ae..aeaf6692696e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -868,7 +868,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
>  		struct xdp_buff *xdp;
>  		struct sk_buff *skb;
>  		u16 stat_err_bits;
> -		u16 vlan_tag = 0;
> +		u16 vlan_tci;
>  
>  		rx_desc = ICE_RX_DESC(rx_ring, ntc);
>  
> @@ -946,10 +946,10 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
>  		total_rx_bytes += skb->len;
>  		total_rx_packets++;
>  
> -		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
> +		vlan_tci = ice_get_vlan_tci(rx_desc);
>  
>  		ice_process_skb_fields(rx_ring, rx_desc, skb);
> -		ice_receive_skb(rx_ring, skb, vlan_tag);
> +		ice_receive_skb(rx_ring, skb, vlan_tci);
>  	}
>  
>  	rx_ring->next_to_clean = ntc;
> -- 
> 2.41.0
> 

