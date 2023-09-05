Return-Path: <bpf+bounces-9253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4117923E4
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 17:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341102811F8
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAAAD535;
	Tue,  5 Sep 2023 15:22:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF663C7;
	Tue,  5 Sep 2023 15:22:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17975198;
	Tue,  5 Sep 2023 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693927345; x=1725463345;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bo5Bi6SR5TkvM5Nr9qrkJml8EJRxAO/ndo+G8HjQMOc=;
  b=SATiUm4nJ9M5WrVkqH/t5aImgBAMFMDR3fbBgs5p3yyFrctabDKN0m7J
   eGVXWl3zmJ3CwRILkG4aVpbGuD14Vg2P4pQs6eySSsYfnXHsiEJLH087w
   rzdiRIJPbBz4MwQy8P7WhDTfGqpkOqt7LwOrSALK8iqu4e39muX1LF4SR
   HkEESiZufZuzsWt+IZqjdy6kOP4yHu2PUIpwlWNe/EJ0oQpQHgJQive3N
   v/YoQeZQOzSz+WNkQasRIxGICEq3mEC4tUF6gyJ75KuALD5iOR+YdlG/C
   Q21C/6F5OSf7H7m6iByBBJsKtdypf8e5uSOVVfveSBpPPM6kEBUZVv5DA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="361848881"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="361848881"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 08:22:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="744297055"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="744297055"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 08:22:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 08:22:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 08:22:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 08:22:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 08:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwoyGmBQJ3MpFX/Iym8aSGVKAaH0I/4xFnZbchxnOi5Q0KLnVWEhQuhHhk05SblfFK1LEpefATKeeDBpj4+WpCGKfVd6sS3YtxxNuKgs4axwuuWhiRJbep1kuoIyDo/SAVwwH6un+65TRUvanHRp72PnLGofTOovqX3EpJbJqhg4vlOO+udU3i1iY+yrrfQAZeS7gFrdoZvwZqiScAKVQIBO/M3RgQK8H6vVGaJFzh8zH8R+nIiVgrRYp/bTOnvZFR2+pW7zhzCxlKiFq8sb6OA2/TfH8xskbLjnBud+ldcMDGK6A2JoJn1tJitXcI9WW7PPScL6DSGe0dhczc21LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUkF1S/bLYaEpX27U20bk+vShua2TVr/8tNy3ZbTV2E=;
 b=LwLsu6ZQuvKbH/ZnuRMTe5yPOShbpT7Y2PvH0/QgE0b3LJ/OWemTY9NanvQh8Bsz62I4i4aORv4t75/XefgntUJ8cADOCd8A1bKfaqRsf5JajRwLaK/3nllSq0BLmeGiIntKAnW4ZYEVUc9G5xUduIizOahwqzXQlYWsqAieu4kHDEVacDSDPM8ng3+5YVxnt+elEMOzgAFKr9RUGBmhjWwD9kqXHb2Y4zKoW5qbqlhXPobavji7N/pCpIpdQ8LDzttZPxyNd0VJcVLhYoSAg2pHb/C4I666TC7/fa0+h/Z6NVXkyAmR5Qtd8GTB3pP0bOSueIA3/8gz+UKDGtIBug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB6859.namprd11.prod.outlook.com (2603:10b6:510:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 5 Sep
 2023 15:22:20 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 15:22:20 +0000
Date: Tue, 5 Sep 2023 17:22:04 +0200
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
Subject: Re: [RFC bpf-next 02/23] ice: make RX HW timestamp reading code more
 reusable
Message-ID: <ZPdHnCTQgwce0Byh@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-3-larysa.zaremba@intel.com>
 <ZPXwIOxfiNNZ55+W@boxer>
 <ZPYFz2QTytn+wTmG@lincoln>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPYFz2QTytn+wTmG@lincoln>
X-ClientProxiedBy: BE1P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: ccec06b9-9c69-4b7e-72ba-08dbae23e5ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhsMigsWJXlfD40DeMysTVnwFipHii47XLfZJH6wy89l92K9QrPHl9gg8kPNF7CQOY4AEwP0WIaairNKI9AdfBqF6TQlksvaOY3SKm6o0eTWWZMNax5FwxYHfEZwo9+qc1V+ByZxN7RcdnIcUei9ds7baApUznlJ0ildqWyQ5+mLEKL7E9JUagYn/K3+2/nxxhDYPdC87Dc7741r3K+XDH0zzgws3EXdU8/ZEKa7SEY2HbZhUEYEIHhbOdwArHn6zaacaegyMGl38vZVXFezGtapiNX9MEc9dwY4uLPyoke6vF3a6cMRZCcXTqgNXEl/I4BJvtKanU4giIVEJr09xzSsTmbsVk8yOC8iK1FArfRWjB5Jop8stJ7WIKBscXxvLy2s0+S+0uGtginPF9WZLp9/+VpCCZkhP/vHKLRhJ1gEixoXjMGbYaZpeH1LM17vI0mUkZaax3GvPkOH6K6v0bwbstRqkLHar91yCZiTPYbZBAeRblBqrm0IqakU+GCa4HG/LtX2hK+8SKQEcoWFjwNsIV50JP2Iw0jUcnENy+AkIly9IUAyHCl2dIyCpq5A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199024)(186009)(1800799009)(38100700002)(41300700001)(316002)(6636002)(82960400001)(9686003)(6862004)(4326008)(7416002)(2906002)(33716001)(6512007)(83380400001)(5660300002)(44832011)(86362001)(26005)(8676002)(8936002)(6666004)(6486002)(66476007)(66556008)(6506007)(66946007)(54906003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nIn2KEDXvwWPnyAjmVKXYbUIhbKT4IrO8KsWdCLRRmWCxbd+SaKQ9WmXVybB?=
 =?us-ascii?Q?Kho2XLYSIQP/3WmWJHlBixSlklUWbB081cq4nNMuLRJT+808l+rWMFePs7qX?=
 =?us-ascii?Q?RrmWPM76KPBk1VWN7xkL881xvlbggeGpfUxdC266dJ3ASvFHHVhmoZxtA3E3?=
 =?us-ascii?Q?7KXskdRUwK9RN2u5ORp1Sw9hg4SpxS3IEfE3c0qROo3G/TARRdIVOwejHcYd?=
 =?us-ascii?Q?uEnwOsvcEhcCULocmV+B3UpW1iC7kavmVp4R6khDhNptxCQuYe9FGbWSZWWB?=
 =?us-ascii?Q?0bKHKit9pQGAM+ik27dMKSTEqTa+enXH8K5JODfARWkxLJaNJ2+qHMnKj65d?=
 =?us-ascii?Q?EUGjlF9xBM/hB8yzwi+Tec6ZmZjVcqsNaogCKVrne0yWgk08bTV0qFI2waOS?=
 =?us-ascii?Q?vSEWk7+523Jb+Sn6W2kHuWdd0CNVyq0AZGR0VAt1EW0ecs2qbz+vIsjXR7MY?=
 =?us-ascii?Q?41WaW1peD0XhckDhKkRawPVdleeBz48ll7v9LVD+tcXBRHJWffb1/6YTRLwY?=
 =?us-ascii?Q?Gx+1i51hruYyHkzHNk3ce0YvCKgnelIBfpnd71I2UEOlPrxZEAW4UJiKGD8E?=
 =?us-ascii?Q?z5cL0foqml4wezOFnLh5980jCEt6JOcRM0ptX1kk0U1RU6U9aNk0z4sqehfz?=
 =?us-ascii?Q?1Y+JwiViJqyZ+iHNV4JleL/YHnS4EjDsi5R5rqrpRjr4K+bcmLcOls2Eiff1?=
 =?us-ascii?Q?Ef8bUgBd50KHmn1LHkU48uNQIJnLk2d3+yCIs9ZnwWHwE66hZF/5C4+iDFKl?=
 =?us-ascii?Q?Uis6WkoZbgenF93hgwZmI7EYvHDWILKxJijvXtm39CghRqA4e05uk/lqI4gv?=
 =?us-ascii?Q?EgjId97UMi3tYhgKaSQI0XQYWj+MZmE/AVWLINX2sbnZ+XOOZ4bMokeIT0JJ?=
 =?us-ascii?Q?SPALKn1Aadm2rlcvoYL1JpE7MI853+gyBTOAKP8ozhMwYOpcRhpIwyLiBdhJ?=
 =?us-ascii?Q?7JJMiWcDhsJWWzrHMXeosLTwzuhs/Oq4Hayqs9vnVsu8ykulEXUw0B62tqiZ?=
 =?us-ascii?Q?pBNS08ITvX+9t7+9//4AY+mGSUIjawXCD4QinSiDsb7TVdNEiFOmuyqHR0OU?=
 =?us-ascii?Q?vT2F/09dVXdk/E8IGCi5IHigWYQr8rIhqH55z30nB5+JyiOsj+nINYuutYFv?=
 =?us-ascii?Q?SaVW8xbsZMiZhpu14HBxgJfdodcrFjxGns1EvVfMgSWJeh5jdM6lvbR/wxAm?=
 =?us-ascii?Q?HnMYj8CEyaAIagqas3c33WdBtBhqPXiLzpGpabHUnn+QbuT+zybVjFxJaKOd?=
 =?us-ascii?Q?iD6cMi0ACQIGIjCU0E8ZXyXgUMiCKk7AWj2axvHyLgjNfWhIT5kWP+A6oJQc?=
 =?us-ascii?Q?McFE1J17V+HXvqLb3eYIoR3kVXJpjTU1wqmftBrvFVSnDoA08knOizTHE8F3?=
 =?us-ascii?Q?iLIrGJurGijEmSZerlfYwu2gArZ6ySojHboXniFbzp0mE0hByi9FthY5u1jy?=
 =?us-ascii?Q?Zw6nDoYIRHfwkH7IH6ZZdlWREBojngbmxxOG3VJy0jk6ZmGShWS25my+SfYu?=
 =?us-ascii?Q?fRi1xp+ZoKtF8T4kb0jNRVjvoIYZqKmxg7qJ2YM9tbDbVgiE7okq7ZN+I4VA?=
 =?us-ascii?Q?rYBDQ9Ck9bxZr7A2ywOf4nB9qCb7fgxL2Gr3Th/twdCrFDTONZTn4l66Yxt1?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccec06b9-9c69-4b7e-72ba-08dbae23e5ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 15:22:20.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUNBkM+Tr4XVR/yqzM4cHbYnEwozWiHd4sZ+VLjfMZNWpl6Ahrpth6Wghj0bG2dmwEV2ubXdETBRopVPoytHjBhhG3PF+IqckL5ysAHHp2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6859
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 06:29:03PM +0200, Larysa Zaremba wrote:
> On Mon, Sep 04, 2023 at 04:56:32PM +0200, Maciej Fijalkowski wrote:
> > On Thu, Aug 24, 2023 at 09:26:41PM +0200, Larysa Zaremba wrote:
> > > Previously, we only needed RX HW timestamp in skb path,
> > > hence all related code was written with skb in mind.
> > > But with the addition of XDP hints via kfuncs to the ice driver,
> > > the same logic will be needed in .xmo_() callbacks.
> > > 
> > > Put generic process of reading RX HW timestamp from a descriptor
> > > into a separate function.
> > > Move skb-related code into another source file.
> > > 
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_ptp.c      | 24 ++++++------------
> > >  drivers/net/ethernet/intel/ice/ice_ptp.h      | 15 ++++++-----
> > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 25 ++++++++++++++++++-
> > >  3 files changed, 41 insertions(+), 23 deletions(-)
> > > 
> > >  

(...)

> > > +/**
> > > + * ice_ptp_rx_hwts_to_skb - Put RX timestamp into skb
> > > + * @rx_ring: Ring to get the VSI info
> > > + * @rx_desc: Receive descriptor
> > > + * @skb: Particular skb to send timestamp with
> > > + *
> > > + * The timestamp is in ns, so we must convert the result first.
> > > + */
> > > +static void
> > > +ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
> > > +		       const union ice_32b_rx_flex_desc *rx_desc,
> > > +		       struct sk_buff *skb)
> > > +{
> > > +	u64 ts_ns, cached_time;
> > > +
> > > +	cached_time = READ_ONCE(rx_ring->cached_phctime);
> > 
> > any reason for not reading cached_phctime within ice_ptp_get_rx_hwts?
> >
> 
> Not at this point, but later for hints, this is read from the xdp_buff tail 
> instead of ring.
> 
> But maybe it would be actually better to leave cached time where it used to be 
> for now and instead later in hint patch replace rx_ring with ice_pkt_ctx in 
> ice_ptp_get_rx_hwts(). I guess that would look better.

Yes, that's what I was trying to say mostly. Thanks.

>  
> > > +	ts_ns = ice_ptp_get_rx_hwts(rx_desc, cached_time);
> > > +
> > > +	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps){
> > > +		.hwtstamp	= ns_to_ktime(ts_ns),
> > > +	};
> > > +}
> > > +
> > >  /**
> > >   * ice_process_skb_fields - Populate skb header fields from Rx descriptor
> > >   * @rx_ring: Rx descriptor ring packet is being transacted on
> > > @@ -209,7 +232,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> > >  	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
> > >  
> > >  	if (rx_ring->ptp_rx)
> > > -		ice_ptp_rx_hwtstamp(rx_ring, rx_desc, skb);
> > > +		ice_ptp_rx_hwts_to_skb(rx_ring, rx_desc, skb);
> > >  }
> > >  
> > >  /**
> > > -- 
> > > 2.41.0
> > > 
> > > 

