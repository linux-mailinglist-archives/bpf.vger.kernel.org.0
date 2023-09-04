Return-Path: <bpf+bounces-9200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65ED791ABA
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 17:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AED280F37
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51A4C2E0;
	Mon,  4 Sep 2023 15:39:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F393C138;
	Mon,  4 Sep 2023 15:39:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003821AD;
	Mon,  4 Sep 2023 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693841942; x=1725377942;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SUZTnBUDL2Zs1qZ6/z/dRSzpFpxO/R9YY/SJ+q76XZg=;
  b=Nw+4ZBB6Vtb9PISHEa5kaiGK4THgD25RaZBg5SBwvMzEPXp6/oZyhS7n
   jMA0z6KZqpwvoUVWHaysCPkCQNvx03OrPg0MRuHRpRuNcv+lDS+FzkoLv
   sVnlF6GgymtG8dhpcaafB7MnelzVNuJNtb9NCub3LHqNMpN8LhWAzHXm1
   zhyS8v50xF4JatK/WbNFEfhQwjQtZQ7NqyHO6LgTIjdiNRLHhsPYQ2C7/
   widkn+UUr6w9UKWWWHReA3AJZF+7jaW7WdVsZ1Kb3OvebYUcoFZN63Zah
   NozSRykgSIWaW9tNfUZDvvgQfMhI4IBEkMfrN8MFvILVTCFQFdGwYOBk0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="462997868"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="462997868"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 08:39:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="987512541"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="987512541"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 08:39:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 08:39:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 08:39:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 08:39:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L57NugJjn9ecGw6PHsJloVikESM2C0x+aAU0bsmynlAXBTNgdJ2zhsDD1DX9iyHXbN5aqQ75JNiWywP3MlCFGZlDwnyVBQWk9Wb8LR2igUHmLW2dJ40lqwYKBZlCOsOBOrfG7V+2l1Sve8eysrDTK7PahJjhNocU/eR1i+X5F4bujP7nFoTzlyAKGcQ5Xp2kKphrFJx+skWJ4m5/36251j9CFr8VL7jV0fSY9pwrgPiWca9xBHwbzb2PZWUkl201Ju7KJ+iZUVUZvTityDeO/bn4a51SbL7nCwTx+RUOw7wUnvdfmcuwZlViZHhPIlGwNTwSkjKGgTUZ2bajvBWxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFdzC1H8QdQo07rn6OaPvGfNqIFohyxe5K1zdSA/VkA=;
 b=kI3HJ5FD2MDpfHRdOuRYJsrMX9Q1/nZLW3bLXOB3N7zCDx8YLKbKk5UijNN+uuyqvjXh2BJcw/l6M1eaEoNVWmOfnSJ2T7vf//i58bpDWq7g4vBnApb0ParQbuHK8hgFflLUortNh8ePp9YG7Xv5QbSvBxYbVuC177HPLmJ3X8y3xhdb6p5NHvNcmf0KoNVQi+juy04eANYywN6zdhKB8/W5Jdmk3V/HLViKKLN8Fx9Ob/25djmvBZKFzLFN3oGqFq4WDgdEKVMj6FRmKJ7U7+rv56M2+kVXnmnFUCvSoLZhTXrls4UDbJGVsowjbWaRIX7Rz5sjX4/jWLWsZe3xRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.32; Mon, 4 Sep 2023 15:38:56 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 15:38:54 +0000
Date: Mon, 4 Sep 2023 17:38:45 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [RFC bpf-next 06/23] ice: Support HW timestamp hint
Message-ID: <ZPX6BXF9RIA0KxQk@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-7-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824192703.712881-7-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: e12a9e35-0cfb-45b2-48d0-08dbad5d0bf1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lqh1fl5mjk5Uzr5RHkFA3GHLVFdtlSKY9dPszfQ93Z1DkET3EsYz/YJSPKoQeU2m9kOCZrMLHfVud2LLKT9ciqM9HYa45ZA0Wy/IVP3Q2tiu/3d6h/Hxn7xppA4yHmO5bC6pnlK+CK05mmkDOJ2y85L+5NPLc35TV8JpS7X3RHFR7ThlazqGQvvEIG5rXhey0AP/77MiZSY4yZyjPR+6koEGT/FVpHfy74g7dZgTzVbbZhTSEwaUjSMviuFGDEUUzdIBBTzWPSqpUQqAfrmbf1lJzEBeTqXLSYfI8OsyK/xQI5/QINYxTmiZCGJwYXzep220o7byKCpUvIHYRfwv1VSA/vuvL38gRLqV+Yp4QDvQT9klXuGNDehhn/uTKqnQIS+1ufBUcgHwQfEHtlGfAGAV/kh+Kl2nOJ0KIlnFIHQQf+fb6ETueQpCS52reYvupGUFgxIJQrK3Z5gjqplAgHriWehyr2lxsMm/16su6br9bElL+KqEFckVlcWUB4Pw01omnNGn/c00CiDDt5jFOYbCKa6TCS96Ekp4WoFkJFMPT7y90hqoQ/VYrY/mcCqO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(186009)(451199024)(5660300002)(41300700001)(26005)(2906002)(7416002)(82960400001)(86362001)(38100700002)(33716001)(44832011)(6862004)(4326008)(8936002)(8676002)(83380400001)(6666004)(6506007)(6512007)(9686003)(6486002)(478600001)(6636002)(316002)(66946007)(54906003)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ql+68PEticAEBqX9/7RmVFgIR+H5ygDx/lDLoEXiWXe+53W4Z1rJtjgExaWX?=
 =?us-ascii?Q?4G5NoVkpgtqKqhKGcM47pCirgn2kVbe6sQQW+gjpW97w7GQv47q417nJLRfc?=
 =?us-ascii?Q?NMxYT7CG5/JG3wCcXhS/YJvEGShqNemOWXqFyJ0K7dDoW2ptM6DlzFsJSR7N?=
 =?us-ascii?Q?O7DNWFcmIpnc3qNFwh+H1ZAHwwkjaQJC2SVG1AFmXCLHTL8rka8WRoATAGkt?=
 =?us-ascii?Q?S/2J0cdb/xOHDIKHEyAyN5JH728c2WGBg8hQJ1SlNo+kXbkhd55bAcxC077m?=
 =?us-ascii?Q?M8hpohZLMlT6MUFXr/PNi/QBQVZUpkoSrd317eMvNYnKY8TQ1NE3xMUYkQwY?=
 =?us-ascii?Q?Dma6ZUC3L2PNwlDzLnrQECa7Nv5q8HcQP72c5zcrXpZ5KWzqvwZtyBDtioxt?=
 =?us-ascii?Q?xr2Tgj6kKt/Vp7xYmBYcIIRynmwe6ieA9JaHy49cYHjjGy9EmVOLNBcbWIFG?=
 =?us-ascii?Q?9T4jBA+31OLZ6FX0H9NHEGvliFvHXQjsjv+bzHQjcdKEFrSiDwRIXH2Qi51L?=
 =?us-ascii?Q?vL+jWVbFsrsoCAhV2fnL5jFIBCQYoNC63T6+dswhnGvX49T/IP5h2n2xvF6d?=
 =?us-ascii?Q?2YjWwUCf2GRYmsqQbb9ksHlBAvr1HPdkqPHS3wDJe0Ml5Pt/ssXSEKZwm5yz?=
 =?us-ascii?Q?MFnv5HOfwF54o7195twKn+jH6hbN8AsDbuYwmd/MMfxCTIze0NjmHKvfB0qR?=
 =?us-ascii?Q?2vOLu10WznbpYcwdjTltK9EQHkxwjfX87aaQt940Ir67RLUdMaJlxiTmKGDw?=
 =?us-ascii?Q?heitYr3UQtaGjhRQu0vbGVda4AVNTPX8iBBVYmMPvkc4ExPeXFP2SJHncqof?=
 =?us-ascii?Q?IjhVzXX3Wj/Z3MT1f+B8lFuP1NiZXvwhMYwxHrzCjLC/MT2/2PsGtlhiWThu?=
 =?us-ascii?Q?pnPy8uvHovb4q6Hg3coGW+YPokReKap9W0Y4Yeihym+B05pcPFjTTfIp4va5?=
 =?us-ascii?Q?+yIK+CSomRcO3+4m+AFuQh2WwJa/020q9lgsT+HTt5QRKYy60+WoohE/jKR/?=
 =?us-ascii?Q?u/UcoTb4BUtEPo7lqFVRVCmS+AR+5tePsO9CjJUJ65mjBFDuvOxIOi+dj+47?=
 =?us-ascii?Q?uAviWvh35esBjfe5LMp9SlSX/iTBrcuzz1PvoSj667nMiCrKGYPYOCjwkaos?=
 =?us-ascii?Q?fekIa4UjN8R63DiICsBw6vvpp6Yc+76k5EfBqYlY0oaeFWWBbtq+Bq39bTMY?=
 =?us-ascii?Q?Jn9nmke/b84LuZOmCQe9d2ygsfDEiVhw36GzsZ1QYefQLfiHid56KGFxBXHD?=
 =?us-ascii?Q?h5VUOhCp0/P51YXGIw7JaoHI3/4/Bnn0aPgNBZQbGbNNBOEDtkWhsF5+GvvR?=
 =?us-ascii?Q?9TZZuoSvOrEHRTCJxIQ5Dug3dh/dctyRRnKMzyRsvbATee6MQZdVxm31Hfaw?=
 =?us-ascii?Q?PIPfMQxJ7yABsz916YI8dZHnq8ixTW4D3VfiRufhCKP0w/UL12m1clVKH9mg?=
 =?us-ascii?Q?mi6eHuZ9FejIsmMv+xQ7EonvwEOeu3FOVPXw4QKPXL1HR9eBp5U7lXHYwVfm?=
 =?us-ascii?Q?XCtLhh52uE5trNtJ6ZJOtWfX9C914deEz2ZR0Kt5itCD1iO0kzInurOSy65z?=
 =?us-ascii?Q?ogdsKJF6Qtww1TBqOd6l0sp5IpVvlH0AbN61CJGxSd/Ez4DZcl0iYE0IimUJ?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e12a9e35-0cfb-45b2-48d0-08dbad5d0bf1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 15:38:54.8328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QQl4AIVu4V2nAvNXdfWRBaOsGeTzy+m8G2NXCHPNHRwuOJIp1wFz7LeI88lkpVYuuff8FUxLzYnfSowWrK2mKIlvERxx6SofCCRdUvAKDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5626
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 09:26:45PM +0200, Larysa Zaremba wrote:
> Use previously refactored code and create a function
> that allows XDP code to read HW timestamp.
> 
> Also, move cached_phctime into packet context, this way this data still
> stays in the ring structure, just at the different address.
> 
> HW timestamp is the first supported hint in the driver,
> so also add xdp_metadata_ops.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  2 ++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  1 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c      |  3 ++-
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 ++++++++++++++++++-
>  7 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 5ac0ad12f9f1..34e4731b5d5f 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -951,4 +951,6 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
>  	set_bit(ICE_FLAG_UNPLUG_AUX_DEV, pf->flags);
>  	clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
>  }
> +
> +extern const struct xdp_metadata_ops ice_xdp_md_ops;
>  #endif /* _ICE_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index ad4d4702129f..f740e0ad0e3c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -2846,7 +2846,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>  		/* clone ring and setup updated count */
>  		rx_rings[i] = *vsi->rx_rings[i];
>  		rx_rings[i].count = new_rx_cnt;
> -		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
> +		rx_rings[i].pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
>  		rx_rings[i].desc = NULL;
>  		rx_rings[i].rx_buf = NULL;
>  		/* this is to allow wr32 to have something to write to
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 927518fcad51..12290defb730 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1445,7 +1445,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
>  		ring->netdev = vsi->netdev;
>  		ring->dev = dev;
>  		ring->count = vsi->num_rx_desc;
> -		ring->cached_phctime = pf->ptp.cached_phc_time;
> +		ring->pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
>  		WRITE_ONCE(vsi->rx_rings[i], ring);
>  	}
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 0f04347eda39..557c6326ff87 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3395,6 +3395,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
>  
>  	netdev->netdev_ops = &ice_netdev_ops;
>  	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
> +	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
>  	ice_set_ethtool_ops(netdev);
>  
>  	if (vsi->type != ICE_VSI_PF)
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index a31333972c68..26fad7038996 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1038,7 +1038,8 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
>  		ice_for_each_rxq(vsi, j) {
>  			if (!vsi->rx_rings[j])
>  				continue;
> -			WRITE_ONCE(vsi->rx_rings[j]->cached_phctime, systime);
> +			WRITE_ONCE(vsi->rx_rings[j]->pkt_ctx.cached_phctime,
> +				   systime);
>  		}
>  	}
>  	clear_bit(ICE_CFG_BUSY, pf->state);
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index d0ab2c4c0c91..4237702a58a9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -259,6 +259,7 @@ enum ice_rx_dtype {
>  
>  struct ice_pkt_ctx {
>  	const union ice_32b_rx_flex_desc *eop_desc;
> +	u64 cached_phctime;
>  };
>  
>  struct ice_xdp_buff {
> @@ -354,7 +355,6 @@ struct ice_rx_ring {
>  	struct ice_tx_ring *xdp_ring;
>  	struct xsk_buff_pool *xsk_pool;
>  	dma_addr_t dma;			/* physical address of ring */
> -	u64 cached_phctime;
>  	u16 rx_buf_len;
>  	u8 dcb_tc;			/* Traffic class of ring */
>  	u8 ptp_rx;
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 07241f4229b7..463d9e5cbe05 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -233,7 +233,7 @@ ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
>  {
>  	u64 ts_ns, cached_time;
>  
> -	cached_time = READ_ONCE(rx_ring->cached_phctime);
> +	cached_time = READ_ONCE(rx_ring->pkt_ctx.cached_phctime);
>  	ts_ns = ice_ptp_get_rx_hwts(rx_desc, cached_time);
>  
>  	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps){
> @@ -546,3 +546,27 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
>  			spin_unlock(&xdp_ring->tx_lock);
>  	}
>  }
> +
> +/**
> + * ice_xdp_rx_hw_ts - HW timestamp XDP hint handler
> + * @ctx: XDP buff pointer
> + * @ts_ns: destination address
> + *
> + * Copy HW timestamp (if available) to the destination address.
> + */
> +static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +	u64 cached_time;
> +
> +	cached_time = READ_ONCE(xdp_ext->pkt_ctx.cached_phctime);
> +	*ts_ns = ice_ptp_get_rx_hwts(xdp_ext->pkt_ctx.eop_desc, cached_time);

having cached_phctime within pkt_ctx doesn't stop skb side from using it
right? so again, why note read it within ice_ptp_get_rx_hwts.

> +	if (!*ts_ns)
> +		return -ENODATA;
> +
> +	return 0;
> +}
> +
> +const struct xdp_metadata_ops ice_xdp_md_ops = {
> +	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
> +};
> -- 
> 2.41.0
> 
> 

