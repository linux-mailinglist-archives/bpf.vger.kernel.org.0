Return-Path: <bpf+bounces-9324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A631679386B
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 11:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645DB2812BB
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA32F3FC7;
	Wed,  6 Sep 2023 09:37:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81524110D;
	Wed,  6 Sep 2023 09:37:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8E710D0;
	Wed,  6 Sep 2023 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693993039; x=1725529039;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vHUVjlRx3YSbUx1EigPmFPn/YRkq9aQr2+lDL9MJ2hA=;
  b=iP0/64ghdvoe0vBqfBwguDjvCmBza651Q9uWvtDGsOLq6nLS9y4xcQsv
   u1x0lxaBjdR/5+CFNXfn0ox1wsj6vkQ/7c2/GRS+YAuDjOQi2Cv5Cj+Ai
   oMB4Stj4HNGjAKIquGFJY94/8vHuQvUHB6ClgVkcmmCKro0KEDifUvobA
   q5JzQW4HBVlJdHNqJd9oXIQ77NO4AiFyPauJuTYJ/wp/2xLPz7v8VRqrc
   T3uj8fI1h6Dt4Cnx9DHMutksglnO81cE3dim9Axg6OC/IwwiAAZZ4XJL6
   /HtwyXbbyxZFuCaplCuymovOaMRxcyjHB4x4a59n3zEkYAFyAIMiEDy7I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375919818"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="375919818"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 02:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="884623589"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="884623589"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 02:37:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 02:37:16 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 6 Sep 2023 02:37:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 6 Sep 2023 02:37:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 02:37:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqtLOx448v6OcbsFIl85UTjwjmkZzs1Rn3YQ19THxgaMlovW27QTOZ6eBhSOLCb1YG6rxaU9sMTWWfQ9kvybAvlYaEjU0w69xuJ54tUh4p9vVWus+CR0GdZfY1LRxtd2pq8pNq1F26ItKxObqPDfRHfF9uZ/fK7xDibNPleLeuQIBEoIW083TQ4WUTRTXVBneWLWBAWOE38BhQDQgTyxJD2vNyR7Ym6zz7urJDr7O8CQYoYix0h2Jil0//wi1Ex114VLRec9tg2xH93G0NC1QVK8KYn3TvQyo1BVqS0+Jk46JWwjYx9XdB7/szoP6N+aKRreVTRa05qh6ZgjDrq7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLvr/LAHCjSwOuOp9v4iQA9b0ETvi9U7NOkjcPDMYNY=;
 b=MYSNZso8riQVHoY+vI9P1qglGKrAiqMf0EF6L58C/YKTcN6h0l/XuV+tGTNqx6YrevScj6eON6yMkMKcUr9aC4unYlhDYAM2wahLBS0BzdwEJFQEAHOcBn7nlfRbw9Wsx1/ekACw1S1yhEwLYmGkp3QPHK0G9U+qh33lVsX+WTdSRREptqmvuVxNYarTLIwmvvrYUF69KKHtBXTfbvHS8lFtLxppGk13+UFXzUL7tTZhSvjA1/J0SZOR85ePr/hu9cR3oYNeGYUBIvB0ygcmgQBp16bsAl8y2d3LTswnw3ekGoN06vcny50n/SwlPjx1UIfV6yn8MtcsUtDCleI4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB8572.namprd11.prod.outlook.com (2603:10b6:510:30a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 09:37:13 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 09:37:13 +0000
Date: Wed, 6 Sep 2023 11:28:39 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
Subject: Re: [xdp-hints] [RFC bpf-next 03/23] ice: make RX checksum checking
 code more reusable
Message-ID: <ZPhGRylHigicNNSv@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-4-larysa.zaremba@intel.com>
 <ZPXxkOCK5e4M/P5H@boxer>
 <ZPYbYqnStaChh8BY@lincoln>
 <ZPdLN56BWQVQGKkA@boxer>
 <ZPddEcHOeRrtRcmj@lincoln>
 <ZPdpALUo6CveX4Oc@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPdpALUo6CveX4Oc@boxer>
X-ClientProxiedBy: DB3PR06CA0025.eurprd06.prod.outlook.com (2603:10a6:8:1::38)
 To SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d0ee26-06a5-4668-d06d-08dbaebcd81e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhHoxHkG5BknmYfDmirSBgqu6h85Na14zk4ky+wkI4PcGOs9IB5z9nCk5/ZnfHuEpGJKcE2wqyg5pQrQ4TOHEGgjQVgEB1l22yqNKLnL/ez9XSNYeawWwF5m3qmV6QWa7zm9qa1/Cpok4d4ompfOw/Kya6S6I11WEEl7ghQ0RL/6JFvmx0+vloJfT3cTLz1Q64caORtOXNon2+oNXZVfyc6bbCgV/0z4yAXiepFC0VIcU7Fu+/UrBj1GMdiHryZ8xRNLeX3IvSvqLSYLfq8DIj11J3gH5Tj2l1qHIPM8Wj5x1+uyt0iSb0ylXZrOipH/kuMXwdL1z0XTKUjPIyE/ys5ez0p15vZu24xIJjugpeEsZNXgNWQYmpErRADepE7GaDEShOPFQ36frMWuKWKJROkJcig9nYgykiKDkAydzhgFsSDAf9Ok0+GypM83ytNXQ6zAjRYf+dLkxk1ZYxHuT/bY9EQQ/5/hUk5uusTJ3qFT0bcKYAGH1ohDfVHGk650IOGyw9eqVSbjUlGVrObaW7byLlmd522z2NDFUoUGI6sBr5cn2at0snP/JtTKFbgt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(376002)(366004)(136003)(396003)(1800799009)(186009)(451199024)(82960400001)(38100700002)(26005)(6486002)(6506007)(6512007)(9686003)(33716001)(83380400001)(7416002)(478600001)(4326008)(6862004)(8676002)(8936002)(66946007)(66556008)(5660300002)(44832011)(66476007)(54906003)(86362001)(6636002)(316002)(6666004)(2906002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?El/TljlXo0LjbIRbpin6pHMhGPSZZKlts3fUl0rPrj8xigfD0ljvxYmCxJbd?=
 =?us-ascii?Q?0IwCzDJ7iQA54npmfrJUt/M89fXr/Z+g35OzoGwquFTVCkPYfpvokdsf9JV/?=
 =?us-ascii?Q?XteQZUvs5mgtfN9wDeIHH6BwlMABvOY6Hav2Li8RF9gTdwxsnQIRkoESlOx7?=
 =?us-ascii?Q?VFIZ84Sh+WI5fEJW1sOvuNRBKaSWA3Prr8BLUt0syGIW212o9IKvhTFehBdy?=
 =?us-ascii?Q?4cg2IF3WYnIRdWoC4YjU2666Pq9H+Jz3YiwAZbC5D1jVO42ClGlYZKBeXHAs?=
 =?us-ascii?Q?OdZM/Ip+tMFTMBt3MlERbKwlXhRU7wEsRdPVcuRzoP5ONZuLib7wZdr01qtd?=
 =?us-ascii?Q?fG1sHHKCr9Id5Tw1GvxGrHUid1AAkRjz6+vMzvi1WbIqBlsluGEc7OyKnO7h?=
 =?us-ascii?Q?aTXsVHilgCK/XF9R2c5IAiV+lx9PGwyBFzrzL5BnZDvrq+WzrWHKBX3gtOuN?=
 =?us-ascii?Q?0G5oHxirWQGW+7RuPFmbS7Qf8YX4vzIt21sHdV9cq7UmXxMe0qBAY0LdrJvv?=
 =?us-ascii?Q?u4RTIyZTXuJkB4R3XbcLf/xzTA83P1cZgSkg/rTIqt+LoUiOG6x8ANt9WHu+?=
 =?us-ascii?Q?Y90J76GBDi1ylZp1xuw45YzxytO7kFbNcGtbmgUvPNBYCgF2YKiXKtMSn8qL?=
 =?us-ascii?Q?2VW0lXeXnRHNyxL+eAiKLcaVLkHzQfI58PtBKF3DY/8E0EavmZZ0EyLAHusg?=
 =?us-ascii?Q?Ouwl6f20FNzJOeGpZElc0/fz1H1M5AECO47KnhWAeEwxR7AHBB+OLJAI5TW0?=
 =?us-ascii?Q?1BpJxrZG1xibRYbr4WrywuKo6vGiN96dXGi1BCigoCcvHn5S+jNMziU5uRdC?=
 =?us-ascii?Q?ZVGND9fHTnGvdQyf14uDi2Yvbd/zqEE30rukMBBiLLHv2qh2o5psLM39kwLJ?=
 =?us-ascii?Q?2ZCPocM9ZdI+Loe30i03gPHZdjNytkEA+CpvjmxSc/Poj73paw++L7NVuoJ1?=
 =?us-ascii?Q?42ZXrSUwwZpaAZASqHAEfnKlWPsAMTMAJOrfbua1Dg8SfoIbn2M/fFkc4YvE?=
 =?us-ascii?Q?fZQ1DH9KAOHjYotN6bcb7nA+WIykrU3wy4opmZIPPJA+QpWYyFnakU4fpwid?=
 =?us-ascii?Q?uXdmjNrhb5X2nvrwaqnN2LMJ8D3hbSHZpRqpSmBZ+jTC68PHa8rh/nIgOtqH?=
 =?us-ascii?Q?GpSeDsmqiF6T3AJ96dAd4FDhK8+A1z0nJaKBWveWHN4E8idtVMiP2AtKGdP7?=
 =?us-ascii?Q?Oka0Sj2VJ0RNIEpU4TKmOwc4snTD279ggBN7hyayEzqK6EX4n/hA+bnuCbFE?=
 =?us-ascii?Q?/73gXXdvm2VQlaDNwZorRxOYi+EQhUCqMmnEdP7vHJIXm9ci41lB/RCISpTb?=
 =?us-ascii?Q?/rzmJOOruw7E3QqoUCly7m/+wOPIZbQiRRnDyytPikW//GK2Gl0F4Ix5pWCE?=
 =?us-ascii?Q?9cbZt7QGR7stqrYWJdDGtc5iDoER59flAryW5x8thJXNtk4EcEabd5T2yH2n?=
 =?us-ascii?Q?r1rdxGgXe8A02ixxcvEfgsFofGzA0hF4unqjVkqCeUlzqEBVzIh7gpo8HVu2?=
 =?us-ascii?Q?kOiPY+o9WN4jz8qZMhNbJmPpBZoJ+V8NONFJ+DoA6lInAV8MnFP6FqLojFFS?=
 =?us-ascii?Q?Gnt/YdGunyJAAalX7s0EWeoxnmImS03IndcbplK3TBtG4JS9LAvucWv1Nzbv?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d0ee26-06a5-4668-d06d-08dbaebcd81e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 09:37:13.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8E2fwoWtOxsUxeVbWS96pbz0SxxPmyK27PupPzMJNxeoUm7n4gihzktNNoPM0ADSUpB4OWKO95i8rqsglrQDbqj5jcaSABdTwNZjPCPOoYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8572
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 07:44:32PM +0200, Maciej Fijalkowski wrote:
> On Tue, Sep 05, 2023 at 06:53:37PM +0200, Larysa Zaremba wrote:
> > On Tue, Sep 05, 2023 at 05:37:27PM +0200, Maciej Fijalkowski wrote:
> > > On Mon, Sep 04, 2023 at 08:01:06PM +0200, Larysa Zaremba wrote:
> > > > On Mon, Sep 04, 2023 at 05:02:40PM +0200, Maciej Fijalkowski wrote:
> > > > > On Thu, Aug 24, 2023 at 09:26:42PM +0200, Larysa Zaremba wrote:
> > > > > > Previously, we only needed RX checksum flags in skb path,
> > > > > > hence all related code was written with skb in mind.
> > > > > > But with the addition of XDP hints via kfuncs to the ice driver,
> > > > > > the same logic will be needed in .xmo_() callbacks.
> > > > > > 
> > > > > > Put generic process of determining checksum status into
> > > > > > a separate function.
> > > > > > 
> > > > > > Now we cannot operate directly on skb, when deducing
> > > > > > checksum status, therefore introduce an intermediate enum for checksum
> > > > > > status. Fortunately, in ice, we have only 4 possibilities: checksum
> > > > > > validated at level 0, validated at level 1, no checksum, checksum error.
> > > > > > Use 3 bits for more convenient conversion.
> > > > > > 
> > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > ---
> > > > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 105 ++++++++++++------
> > > > > >  1 file changed, 69 insertions(+), 36 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > > index b2f241b73934..8b155a502b3b 100644
> > > > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > > @@ -102,18 +102,41 @@ ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,
> > > > > >  		skb_set_hash(skb, hash, ice_ptype_to_htype(rx_ptype));
> > > > > >  }
> > > > > >  
> > > > > > +enum ice_rx_csum_status {
> > > > > > +	ICE_RX_CSUM_LVL_0	= 0,
> > > > > > +	ICE_RX_CSUM_LVL_1	= BIT(0),
> > > > > > +	ICE_RX_CSUM_NONE	= BIT(1),
> > > > > > +	ICE_RX_CSUM_ERROR	= BIT(2),
> > > > > > +	ICE_RX_CSUM_FAIL	= ICE_RX_CSUM_NONE | ICE_RX_CSUM_ERROR,
> > > > > > +};
> > > > > > +
> > > > > >  /**
> > > > > > - * ice_rx_csum - Indicate in skb if checksum is good
> > > > > > - * @ring: the ring we care about
> > > > > > - * @skb: skb currently being received and modified
> > > > > > + * ice_rx_csum_lvl - Get checksum level from status
> > > > > > + * @status: driver-specific checksum status
> > > 
> > > nit: describe retval?
> > >
> > 
> > I think that kernel-doc is already too much for a one-liner.
> > Also, checksum level is fully explained in sk_buff documentation.
> > 
> > > > > > + */
> > > > > > +static u8 ice_rx_csum_lvl(enum ice_rx_csum_status status)
> > > > > > +{
> > > > > > +	return status & ICE_RX_CSUM_LVL_1;
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * ice_rx_csum_ip_summed - Checksum status from driver-specific to generic
> > > > > > + * @status: driver-specific checksum status
> > > 
> > > ditto
> > 
> > Same as above. Moreover, there are only 2 possible return values that anyone can 
> > easily look up. Describing them here would only balloon the file length.
> 
> You really think 5 additional lines would balloon the file length? :D
> 
> I am not sure what to say here. We have many pretty pointless kdoc retval
> descriptions like 'returns 0 on success, error otherwise' but to me this
> is following the guidelines from Documentation/doc-guide/kernel-doc.rst.
> If i generate kdoc I don't want to open up the source code to easily look
> up retvals.
> 
> Just my 0.02$, not a thing that I'd like to keep on arguing on :)
>

I have consulted with the team and we came to a conclusion that maybe removing 
kernel-doc for these functions would be the best solution. In ice, functions in 
source files are always documented, but I do not think this rule is set in 
stone.

Sorry, if I was being rude, I had been traumatized by documentaion requirements
at my previous job (automotive) :D

> > 
> > > 
> > > > > > + */
> > > > > > +static u8 ice_rx_csum_ip_summed(enum ice_rx_csum_status status)
> > > > > > +{
> > > > > > +	return status & ICE_RX_CSUM_NONE ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
> > > > > 
> > > > > 	return !(status & ICE_RX_CSUM_NONE);
> > > > > 
> > > > > ?
> > > > 
> > > > status & ICE_RX_CSUM_NONE ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
> > > > 
> > > > is immediately understandable and results in 3 asm operations (I have checked):
> > > > 
> > > > result = status >> 1;
> > > > result ^= 1;
> > > > result &= 1;
> > > > 
> > > > I do not think "!(status & ICE_RX_CSUM_NONE);" could produce less.
> > > 
> > > oh, nice. Just the fact that branch being added caught my eye.
> > > 
> > > (...)

