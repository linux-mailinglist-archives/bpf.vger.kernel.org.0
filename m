Return-Path: <bpf+bounces-20230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3583AB40
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 14:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F2A294102
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C067A700;
	Wed, 24 Jan 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+0VRpqe"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD6777F32;
	Wed, 24 Jan 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104704; cv=fail; b=JI/MvzpEVRTszgZwSUz+fMRuBAuDxNDj3igsIfAIsYPa56XtEnNxutAz/fGU2nLBzWvo+bNXRYY50rRH3rQ1aqO81ePAyRoS3HEN4ESOXQJeCmx8Y91R4JqTpGVQ9RQAGLNIqV4MBdd7JorkfTOx7aPEb8Po7NR6GBPmFb83ns8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104704; c=relaxed/simple;
	bh=4NJMQQwfaFM84Vgi/LyTtup52OgxCcN92P2FCxJrlaQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dLw8dcHstDhSjKVjIppeYHw91/8TFjffZ5RBhH2OCvgJYbhsZln/kc/s137zPHqrdmfnZ/N/9E44Y8166htfarB4kIzdVKe3hvJgElAUWMDPiRh6roEkRNxdGZIu1yylablz+bXIus7IPcDBnQDa+ktXPc/AFMdsqG3V5ljc6zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+0VRpqe; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706104703; x=1737640703;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4NJMQQwfaFM84Vgi/LyTtup52OgxCcN92P2FCxJrlaQ=;
  b=N+0VRpqeNH/S9yhn5InbIIlTQpHGZceM/+IQNswJ0/YY52K7FAo8A+hL
   D6R4+A2teL2tU32TmnQZbuzR+JAFYDUqfveLmjrucPPZ2mKURY0CDSY7f
   GHhCq4HXRy1/0GEgQrAnAPKC3cDth8mLrAeIYPhGOA4M5r2miDYERrCBb
   gHEWcbGwlfz/omumuHxlYBwmJ7nrSj6mzMGnfVUI1h1cS7cFw+j2NedRa
   UJIDy+AieoGsj2RnvJiCksyXFz9KW+Qz09eGrXnOPG9ep2qolc9iXXfCI
   nxo49q84BT4IdcVsdcAs5lCcqyDqMO8l+DInP+A4dQ7Q5ont/s8hYnd4H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1738940"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1738940"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 05:58:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="34786239"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 05:58:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 05:58:21 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 05:58:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 05:58:20 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 05:58:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I14L6rdE2NGEDDjHUUU+UhPl7FpMHS8tlDLe/4j8IA5DQqFsK1oZOPItUNvmvd0EOzRmKqfspRIRzZtYvP+YR+qtM5muJdoNFYocMc/JiYnetRDtVqU9sDupa4tLKHkCY1jFKCNSrVTnBv+ULgU9d/G2cLKofX5HQb6eYxAP94V8d5D7gfKA7DHkT5TCM2LjkQtnWu96uUGX8EaOkIPZg6OUgmY5ptiGOCrjT09/FsOEQXkVlDc8TO47PV7xwIi0G1OEBTwewHHfn2ZCUpWN53DRn5jElKV4zXGi9odjLfx0u6nZ+sKIJ+Eo//jeoACp7MCgSPeaapE4EqatH4Y/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXjZ3aGt0AEZR/VK4q/aVsUtmi49HItiMIGPt2JJHE0=;
 b=SP6dz19XeYM4tG4faZXIkIP0sO7TJfa/CrbKbK5/RbVgKId0uFfvxxqehO2ptj42Dl/s/Z1fChrDCGcwJOcu1sPNNoONz9JWi3fOhGFcaNz5OXqc2ny7suaxsuYtRvTYrofn//8m2+jJ3pdGTsldSTduWP5Z0QlWe7poOBjG7GNhwvI0SUkPkFdYpeXocc6pqD5aJaZCTUn51IQjoTO2lRCcEUl6ro6OQi+8aVyp/6pgT7bizkF6R7VD+PkQ+9ZNNBdeBZqfMS2olkuWR6clVs42iMGCpfAnKXCvnLvbc2lGkRBrKfGiZASlCAYkfTQD4l1im3ThwOcMwQi2WLHrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4565.namprd11.prod.outlook.com (2603:10b6:208:26a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.24; Wed, 24 Jan 2024 13:58:17 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 13:58:17 +0000
Date: Wed, 24 Jan 2024 14:58:11 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <echaudro@redhat.com>, <lorenzo@kernel.org>,
	<martin.lau@linux.dev>, <tirthendu.sarkar@intel.com>,
	<john.fastabend@gmail.com>, <horms@kernel.org>
Subject: Re: [PATCH v5 bpf 08/11] ice: update xdp_rxq_info::frag_size for ZC
 enabled Rx queue
Message-ID: <ZbEXcxs+SqetchZi@boxer>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
 <20240122221610.556746-9-maciej.fijalkowski@intel.com>
 <CAJ8uoz3jAtyDXr=WSXYXZeX0WfYuJK+WA0tTpYMscM=XRqisSQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJ8uoz3jAtyDXr=WSXYXZeX0WfYuJK+WA0tTpYMscM=XRqisSQ@mail.gmail.com>
X-ClientProxiedBy: VI1PR09CA0099.eurprd09.prod.outlook.com
 (2603:10a6:803:78::22) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e05dc09-9acf-4e9e-1a1b-08dc1ce4844e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQq9wQsVcfWWfFBGPu7U42eR5Qq1kQNVMS0yteJnqvM0RT+cQoRQsiwcHqlx/hq2cdbhpN97LnzdQl56yQ6y29/KA2pWzkIAAgQkNfbJYbwyOCLYVOQnOW+8j/MbNPBQBmc+nZZrUCaQs4SuhpKoh/CEp1cXbmTFa9tdbXy8zQVlJL0/YkoaHBd7EGNKL0Bz2KQUUdm+GiUiKFGG1+ecLHw2zehngDMj3t4QqfFLBP/8rxBqzZlOxs91o66O2iaB5x0wxkUrzW2U6o8FAyiA71hY1q5xNfFSU5ClzaL6XhpsZrcl4ku96j9NIRuTSTFP4I+/wFLSvgWWqOhl3kMB7XPX5Zs6iKWzZ3L7edlrc8dQ0DHLy9VeBJisgMwUOF3E2T7OT8zvFo+wCG2q+vtcN3GMXpsYLAFxXnEfolyjtl4l9d8spzq/CZVcR/PDe2vvMAB/5QDOjTkfBEAxdNCh/kt2ks9W4Pboc5r1WKfv5eisxaq8zc96netcY5dgAt5vWl5V2Pm5arGcc9YKE/vnU4pevXjyz/aL4h0CMlTPUx0b/xDa5xusvUx655pwOnvygTWo2c594vPe+lQ6/lOUzXBHiF6uAnDii8J027FccrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66946007)(66556008)(6916009)(66476007)(316002)(5660300002)(7416002)(6666004)(33716001)(26005)(8936002)(4326008)(8676002)(83380400001)(2906002)(6512007)(9686003)(44832011)(478600001)(6486002)(6506007)(41300700001)(86362001)(82960400001)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BU2o9MT2Sz/pDE3LxA3a9cVXFTtT6eOnn638r1ZgaVqFSgs0BeMa17saGKrq?=
 =?us-ascii?Q?ozueh6U6bL2yQ61i9UFXeTpV+7Fq5tGffsPC3DOsC2Jyb85GtR9ixm8VUqvy?=
 =?us-ascii?Q?Wi6EtzYGpMxnSYR3s4DVNcycZaf21jed5Zp5Sf+cecZIY3jN6sSAv9vqb3hJ?=
 =?us-ascii?Q?bbOWg9CgCkbeyMgfDNJNVdQIFpCAOy2TYNyFO124pdvkyOlU7jtxDgPIa1Cd?=
 =?us-ascii?Q?e5KNW4RgvkyInlP1MzXGnb0WkvIN4LmVaPH/bLnT9rv/zz0rOmWUDQmXfMzz?=
 =?us-ascii?Q?k0eoCR4gDXsrXXyU5YNXM2HjMsxSEYsDtoiXIktx9A8HyVzS/9WVmAOHonCl?=
 =?us-ascii?Q?s1TKHtJxYmns7hBM9jyeF56QQEkhS49Z9VWCF0+5XFUnOVGlSXV5MIdfV8M2?=
 =?us-ascii?Q?p5EiW9muqy5PThw6OTm6uwej+Ta1CRk4KW9sdH0sEG5f7VYkl5zZhCKGQpyd?=
 =?us-ascii?Q?HGMuLiU4aL44EJRxIM9VOqWuWfGvGhempr3Gk6aMDnBbJP+fymTVwaoZhFm+?=
 =?us-ascii?Q?Sxo9NaZXaWA7Un+7vHc7N09IGu7FY7FucFbdxRFlA7u1ZNE+8iN4UIwjFLov?=
 =?us-ascii?Q?zMZHX4JN38Pt5JgY59Yiz5c8BGJMtvRvwVVv/HXbJiRZCs9NydoqSEr1ur+p?=
 =?us-ascii?Q?J7a2r8IlBPEJR48kLoeMOYVBIDhf3CorRPH1bHdKZVnaf5hKyIjxHjueFhn/?=
 =?us-ascii?Q?IihD0rHIdrf2CEkzGIYA9pbQs+QjrsxzkXTRjAvxWqTcfu5KW8YmWJ1IIydn?=
 =?us-ascii?Q?vjhFIoGbPrwE6FCvloTO7hpN+8Jy6B91X4VH8I5vNQzOgRkbMl06loZJst5j?=
 =?us-ascii?Q?x2poxuNvtgbOZvk/qGJTJM/R4jAIAYUo4vG8LxlilBHG6/RVg0GuwJxDukWX?=
 =?us-ascii?Q?Rg678l0EOrNBRDWdahjaRKlG69Ce/Rt6jqi276zLxJ9JytrYdEngBnWjFQoC?=
 =?us-ascii?Q?WM8LKgwSYpDWt4BVRClqJX/Pk+glpbiEO2awRiy85KSGv0LB1qyMN1fJEedp?=
 =?us-ascii?Q?1X2q0OjPs2qlmRAVZ7p7h+PX3D3o41kagvYz+Mzl0MEXe/VZRSsESPrxW7Mx?=
 =?us-ascii?Q?vNkWRdFbkDJXLzWO7G293UWakA6B8+2g84ZLygKnlNZ+5NBmNVOhjqz4l2mH?=
 =?us-ascii?Q?qwo16VhQangfAYRszWXjMzmQbjFfd/ZxTR+ZSeW0a8ip5ltQomOaEtceJwBE?=
 =?us-ascii?Q?fmWTXuegOieKBoNe4WKBDTzVREBKK/3s6vdU4HSeiPEDFjTPlSxDUkldOwuT?=
 =?us-ascii?Q?WydJyNysUVhUGiGPW+OC5triI7K9nifM+GhykWy/ooP7baOyphAPf5uUxOuQ?=
 =?us-ascii?Q?0OG6P1ymbXGFFf2R6o6Ymk8zUZ/12G9zXUuvo4EAUqWXWQQn8ndpSlHjFMev?=
 =?us-ascii?Q?GcZiFNsLorTapby6WlhuhYP1VK0KykABVBM6lRd+btZHXQVufAxXc/pJ+ys+?=
 =?us-ascii?Q?SjahNCc+gB0eX3Qy2iVrh3j9uOFlyVF2FEdQnAgvlz8kF1AQ8c/vdIkfOR82?=
 =?us-ascii?Q?SZKHDnfySrU0WmH7GF3M04qVhaa/tfeiF4kG8Dxv5tDcLGAO7B/XX+XduL9b?=
 =?us-ascii?Q?dj7kpO+8JFV1C+Rdo3zyO2NeZ8lW0KIoTys9aIc3EcAwHSbWOZFvel1vT+Aa?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e05dc09-9acf-4e9e-1a1b-08dc1ce4844e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 13:58:17.8658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uWkfamWuV4xY8jK66WIxTvUpgIEUQxRbRtWzh6sq0prCq1u2qhOgvZr3Dqc1X+Dm6KF/C4fKOGDD2E7UBDsn70q9xj54yri+F+05A/heGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4565
X-OriginatorOrg: intel.com

On Wed, Jan 24, 2024 at 09:51:47AM +0100, Magnus Karlsson wrote:
> On Mon, 22 Jan 2024 at 23:17, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > Now that ice driver correctly sets up frag_size in xdp_rxq_info, let us
> > make it work for ZC multi-buffer as well. ice_rx_ring::rx_buf_len for ZC
> > is being set via xsk_pool_get_rx_frame_size() and this needs to be
> > propagated up to xdp_rxq_info.
> >
> > Use a bigger hammer and instead of unregistering only xdp_rxq_info's
> > memory model, unregister it altogether and register it again and have
> > xdp_rxq_info with correct frag_size value.
> >
> > Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_base.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> > index b25b7f415965..df174c1c3817 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_base.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> > @@ -564,10 +564,15 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
> >
> >                 ring->xsk_pool = ice_xsk_pool(ring);
> >                 if (ring->xsk_pool) {
> > -                       xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
> > +                       xdp_rxq_info_unreg(&ring->xdp_rxq);
> >
> >                         ring->rx_buf_len =
> >                                 xsk_pool_get_rx_frame_size(ring->xsk_pool);
> > +                       /* coverity[check_return] */
> 
> Why not check the return value here? I can see that the non xsk_pool
> path ignores the return value too, but do not understand why.

I can't remember now, so maybe let us check retval for both paths. That
won't hurt us.

> 
> > +                       __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
> > +                                          ring->q_index,
> > +                                          ring->q_vector->napi.napi_id,
> > +                                          ring->rx_buf_len);
> >                         err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> >                                                          MEM_TYPE_XSK_BUFF_POOL,
> >                                                          NULL);
> > --
> > 2.34.1
> >
> >

