Return-Path: <bpf+bounces-10050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2077A0AE3
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8128428268B
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E995F262AB;
	Thu, 14 Sep 2023 16:34:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2412629C;
	Thu, 14 Sep 2023 16:34:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106AB1FD7;
	Thu, 14 Sep 2023 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694709282; x=1726245282;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JGOHpRwkrT8pIk5S+M01dHgIPV6Xy0CkmpoTNXG98+Y=;
  b=IgjRRZjohZhgYPMIMWepCyF/CxlhLtPDT9muAiPY2gIrnG/zlb+pfInE
   WQ0849dzURoltKh3eb0HAN+0/SG3x8jsFcLdN6D3ESvp6VV757Kxyf9Ng
   7B8WP13YIdGz3uVtu6B+mxDsa1rpwhm5yT+oqIZtAqDCvPW0WaZXSE/nA
   t+I30gOIIIfsDmTQMajpwsUEFKqsDy8V4TwA48gbePBvEa3ti0kh0hxp8
   hNE5RU0JAV/2739zdxUraH695CqdcEmwPyiizjo09oG+bGvvOgkP/9BUT
   ud+dZSYs595ZiUoWm4a1g9OL/UTrGnbNjk5tFoOuE8OcXkXAKVl7JItlY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="378925024"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="378925024"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="859772371"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="859772371"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:33:54 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:33:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:33:53 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:33:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzMTkaxP9N91EXdqopN4F4TjOgKYd99TLR2jaLNXHtuZMLrsv4rYMfR3Idn4EW6fpRd9Ern3yO5eNqkU2HWAjBdEaPTNhHYjm/6ntl5/4GqRVJtgg/+gOb6K2DJVOJ+0c2Ycm4ql2CvmVVubqY3ViyWiSoHcrZkJPMxWO/Yac6lzjd7XjRb18lkGsNAX5LUC4L8kwpUbhGiIVQSmEqP3PkWWU+WbscQczxPVlYQrOpYE9OwqdJ77VcQnzPs7SMBO6oBrIi5MHfc/gSvitMPKEC++eKv6irQvatT3F9d4n/8k7yxAy8amAvylcMTNRSTPUghXpScCTWIl6xfOlJyv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XIhFS2O48VGE1tWit6sVfrXpN/KuThD0KX4kAzrDlA=;
 b=dqzMbVAH/1U83bYmR4k7x+fZjTjhmJ1VaBekiDHzClQgVds3CVlJHjjExxrNtq6VuXakEnJ8w9vAEUcwmersdmADHE6+79BfgaZejdyk1Sezl6Zg6RqZ67X7oq/hadLeQTiAchrOoBumj7i23DvMCx8Y9B9Ls4xgxUOIaRF8QEy3YaA9+YOOVvxpmqMOroMQgf2o3iX4VP7oShR8MdCO+jv2LbSWbNvZOqJ/XLlkU3T3lB8daqu0hCTY0VSTpLdSlemiPv0BoX9GC7o0A4Mul0O1H0zk4A0wI8kn7r/CrkVns+14aq57bmIBGinxEqSXxapDCHb9vOOD7BTQhTWEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by BN9PR11MB5451.namprd11.prod.outlook.com (2603:10b6:408:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 16:33:49 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:33:49 +0000
Date: Thu, 14 Sep 2023 18:28:07 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
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
Subject: Re: [xdp-hints] [RFC bpf-next 10/23] ice: Implement VLAN tag hint
Message-ID: <ZQM0lzXSsseZTmOy@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-11-larysa.zaremba@intel.com>
 <0abb29d7-fcad-c014-ea06-c7ec9460245e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0abb29d7-fcad-c014-ea06-c7ec9460245e@intel.com>
X-ClientProxiedBy: BE1P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::14) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|BN9PR11MB5451:EE_
X-MS-Office365-Filtering-Correlation-Id: 048eb252-2c0e-4f4c-6b01-08dbb5405fe7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pN3znGoSBSwyE9w/eZsPMamLcoDFVoPAmUcwKAO3WJ3Vodx1wBZnK9r4B2vXFSI7BjLpVPSICRPiJrKRD2L8eNubd2Hv/JhgE+Z6SiGlHzoxZblV9CJr4gm/Fd0SkV2X6kKYYZEY5tBy8rHGceCOsqoHSfgLf/P6o+3QFsDDWejKYuZBHq2bMJ3jUG2iBtUq0NY/QYdZbQVudf4/UrPF2EwCORN4izC28LnbyhXaQUUXXJdY3TNZqjpRgzNv4o2bRCcf8VWThYULdtgWd0j+3LX6c9P6IBGnas1Iz+P4u7z5O+K+71f19pQ2kVgWVtcHcXAW3uw9nX80qpdmcFPcWSj3+L+LRq4PatDpdS6lDFgbgiCcmGv5kUj+Tq6ucEQMUJhvW0M4N10PmpkTDLTOzYscU+tvSVWvx4zBJlhzK1zbPxjmKdvE2Zkok1Bf529fZbq3Z4yZhwGfYiZrjBujPaAS6r3eqk52EpwqT+/gMRNdGSOD8kbkFXzJLwfCgRJ1iuggfj79mZbo7RArE/dtunA1U3ZAmILQNHa7oT5RtH9mH3guc/GOhw/MuWEIkQlT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(366004)(136003)(396003)(346002)(1800799009)(451199024)(186009)(6666004)(6486002)(6506007)(478600001)(86362001)(82960400001)(38100700002)(8936002)(7416002)(2906002)(6512007)(6636002)(9686003)(26005)(83380400001)(6862004)(5660300002)(44832011)(8676002)(41300700001)(4326008)(66556008)(33716001)(54906003)(66946007)(66476007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fm47x+j4WJltydpAyy92KYEZXb4JRP4B4rQ3MDHUqYRUJRkMhLDhteAT13Na?=
 =?us-ascii?Q?sL4ucdoDvSegzqGaSXfKeljVNY4v2d6ruwNtOM/VVP68HQSdCLoZDaRLI35U?=
 =?us-ascii?Q?I+yvunDZv/C9ZouGMUOiOeA3ffaXChU0OkMudlMfxTjZ4SCHMr8eE0OZh6uo?=
 =?us-ascii?Q?NsnQzSqtZB67/lYAGUS6534ygJtVORZGLF8Wzq1neCnC4Kz3gHQ4kVatn1Kn?=
 =?us-ascii?Q?av1SYJR4c0uw/NRaPSB6G5RpBOd9Bu/foLMw51V3mGc08nnlrqWVyzlurHqe?=
 =?us-ascii?Q?KgMsOvxxDQm+hrYrDJEomZQZn1LfdmT9DXXkugatp90U/WApCAy2x+WZ1EJB?=
 =?us-ascii?Q?W745FsO3ltueDvlQ4MAvfErTLzOjDJFDlOc1ViqEqhSBV/LXd/p89jHoEGH2?=
 =?us-ascii?Q?MXyZYTFykLpkMQd0hQ25BB9YznnxFnUP4JMnLRMxlPtOIVB+IEh7NZ00jjP1?=
 =?us-ascii?Q?i3GoDBXWVHaVEejNzAp21/73qikPbnyjrmk1dubCNzjXseFJGOkyK/1rCsAq?=
 =?us-ascii?Q?zdtwugQkBPYecRaRH1RAwOLho0A9PgTp3qutaiqb3kJb3yUSPvTgPZTBuT+g?=
 =?us-ascii?Q?bjaNvY53ihs33OYpIJsN+DDrybfxVrTiN/R5xBXOjRIKEM5c+CnCQMOGV2qp?=
 =?us-ascii?Q?YE2FrqmFI4x3e6kG/OVncwS3OB16XMwOrIHTgBb8Uvwe1BWgUgP5sg7Gpgd9?=
 =?us-ascii?Q?xGM6DyWfRbFh3zaQ+idL8U7ecZk+eG79i+lTI2NUMhJASjg2ZNgWAQQeDZv1?=
 =?us-ascii?Q?gnvSH9lFRQhwOn+30MecsuVh+pcY6ApRQkuiF1YUTAXoeO1XF0M9Cv4w+XZ5?=
 =?us-ascii?Q?K6snAeKMM+AtngjLxmjT7L8aCYfPNCSPliSJvyAeewvtMaennDntWP1YH4ZK?=
 =?us-ascii?Q?5jx8lIKnxAPiwB5Vud2DNVgzxk9deg4Z+1+aYfZQ2jQ0xfU9JgT3BCq4doP+?=
 =?us-ascii?Q?tfHWVcvPE5zZ5j71bmfqFc6phtjdc8vazEHIOSb3MuzgXi3ySPomBnCNn7qe?=
 =?us-ascii?Q?SmBpqrPwxacVG60TZ2nGx/+SE8x56ArdrOYZUPCj+/n9zge6+31nR9rnfhGw?=
 =?us-ascii?Q?yj38VEk94soGxwWZiZj2qWBObUvzu8+nX7+hF630Sg170fAoP3L5FxXfeW/e?=
 =?us-ascii?Q?4HHiCChK/AI9wM9ZDOzVw4WMCNvIm3+dRfO5kV9CVvhjEMlpJT8tYVuzOIc7?=
 =?us-ascii?Q?8yUO/fBC336BChDVZx/rMfLsDBA/p5MxZPUs5uZhjuAKeOr20cn8K/jsj1bd?=
 =?us-ascii?Q?TSEnXqUpgJqaZEepHnwfx7oK3UdOTfId2Kcbx1IUa7bHeXiwLDx6GYgR7Y/y?=
 =?us-ascii?Q?keBvlY6hr37umyGwaq03QYEBSbDjPSmmXLOhFTer5t5T8E2zHLfHrXDXmTEL?=
 =?us-ascii?Q?C2S8903QqooA7UBS85V1YXisyT3PchxVojd2WGr1SkkaiK2nuQExduyCPFqL?=
 =?us-ascii?Q?MN7EDdqOUSJAaoi6931mUWgMH9ammV5ZC/usMkfp/nHIv/yLW3IiQS5ZzkgN?=
 =?us-ascii?Q?b4VHQQ840wr28uNCnmsT3Qw0+8NawxOMTpjjOshUqH4t3/d5kyVhw8RO5AWC?=
 =?us-ascii?Q?H44l3uF5RsAS70RwfHdAPVSUngDHbGDhJMbGe9LS2BV2Sx1+qJufMqnuU9AX?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 048eb252-2c0e-4f4c-6b01-08dbb5405fe7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:33:49.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RsxbPYhxLp6zCt+tr9yj8+hsIPd9vYRt60Jj7m77+OlSUbRgok9bnQkckQZWb7rG67naPz8HI8KAg7A8y6rH9BUSAIyc0FlCqTeWo9j0CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5451
X-OriginatorOrg: intel.com

On Thu, Sep 14, 2023 at 06:25:04PM +0200, Alexander Lobakin wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> Date: Thu, 24 Aug 2023 21:26:49 +0200
> 
> > Implement .xmo_rx_vlan_tag callback to allow XDP code to read
> > packet's VLAN tag.
> > 
> > At the same time, use vlan_tci instead of vlan_tag in touched code,
> > because vlan_tag is misleading.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_main.c     | 22 ++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_txrx.c     |  6 ++---
> >  drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  4 +--
> >  drivers/net/ethernet/intel/ice/ice_xsk.c      |  6 ++---
> >  6 files changed, 57 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 557c6326ff87..aff4fa1a75f8 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -6007,6 +6007,23 @@ ice_fix_features(struct net_device *netdev, netdev_features_t features)
> >  	return features;
> >  }
> >  
> > +/**
> > + * ice_set_rx_rings_vlan_proto - update rings with new stripped VLAN proto
> > + * @vsi: PF's VSI
> > + * @vlan_ethertype: VLAN ethertype (802.1Q or 802.1ad) in network byte order
> > + *
> > + * Store current stripped VLAN proto in ring packet context,
> > + * so it can be accessed more efficiently by packet processing code.
> > + */
> > +static void
> > +ice_set_rx_rings_vlan_proto(struct ice_vsi *vsi, __be16 vlan_ethertype)
> 
> @vsi can be const (I hope).

I will try to make it const.

> Line can be broken on arguments, not type (I hope).
> 

This is how we break the lines everywhere in this file though :/

> > +{
> > +	u16 i;
> > +
> > +	ice_for_each_alloc_rxq(vsi, i)
> > +		vsi->rx_rings[i]->pkt_ctx.vlan_proto = vlan_ethertype;
> > +}
> > +
> >  /**
> >   * ice_set_vlan_offload_features - set VLAN offload features for the PF VSI
> >   * @vsi: PF's VSI
> > @@ -6049,6 +6066,11 @@ ice_set_vlan_offload_features(struct ice_vsi *vsi, netdev_features_t features)
> >  	if (strip_err || insert_err)
> >  		return -EIO;
> >  
> > +	if (enable_stripping)
> > +		ice_set_rx_rings_vlan_proto(vsi, htons(vlan_ethertype));
> > +	else
> > +		ice_set_rx_rings_vlan_proto(vsi, 0);
> 
> Ternary?

Would look ugly in this particular case, I think, too long expressions and no 
return values.

> 
> > +
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > index 4e6546d9cf85..4fd7614f243d 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -1183,7 +1183,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> >  		struct sk_buff *skb;
> >  		unsigned int size;
> >  		u16 stat_err_bits;
> > -		u16 vlan_tag = 0;
> > +		u16 vlan_tci;
> >  
> >  		/* get the Rx desc from Rx ring based on 'next_to_clean' */
> >  		rx_desc = ICE_RX_DESC(rx_ring, ntc);
> > @@ -1278,7 +1278,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> >  			continue;
> >  		}
> >  
> > -		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
> > +		vlan_tci = ice_get_vlan_tci(rx_desc);
> 
> Unrelated: I never was a fan of scattering rx_desc parsing across
> several files, I remember I moved it to process_skb_fields() in both ice
> (Hints series) and iavf (libie), maybe do that here as well? Or way too
> out of context?

A little bit too unrelated to the purpose of the series, but a thing we must do 
in the future.

> 
> >  
> >  		/* pad the skb if needed, to make a valid ethernet frame */
> >  		if (eth_skb_pad(skb))
> 
> [...]
> 
> Thanks,
> Olek

