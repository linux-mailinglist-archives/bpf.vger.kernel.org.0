Return-Path: <bpf+bounces-12987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415AE7D2E87
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 11:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646461C2048A
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7498134D9;
	Mon, 23 Oct 2023 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVFKiq4k"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28226FD6;
	Mon, 23 Oct 2023 09:36:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E098FB7;
	Mon, 23 Oct 2023 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698053769; x=1729589769;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/Q7nlnZUmacqzhJROFqRNLR3gbQr/kEk+v7GY0tdmQw=;
  b=lVFKiq4kgQqgOLUuC4hlFJWQRlKBtaUENz10vXMzUq/N4ORjlDllO0un
   kpwaGgsUcptKZknXMxoG2PNsBcL4iPA/jYPGoUQhQw9zqU6Ej/Gzl4TCo
   DDx3rINiX4wZh+P2IqkSXMJGa+US8cCwC93Xb0mMllnPEHejST3ZKJmDw
   P370Gg4X7xZGgpi4r6R7cFJRBCQ3hvfra3fBM3ArWiIB2+98GdlV4KBML
   dneEr+EIeag80lIvRKuRh0vvm5afQSGjIJip+O4j5U3UGsaIe5sbwCaLK
   TTTN+JWgD8oGD9fKbIMu9aZ8lVuXjeSC3ADFcdzhKnwWVzsrpnmVf1Snq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="8359752"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8359752"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 02:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5746819"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 02:34:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 02:36:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 02:36:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 02:36:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 02:36:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIo2GwsRJDp6WwqMBryzFFhKml45Ypr7NoOKU8SPxK7PQDdhp1BHDg+EFO1h5iIb+KbyOUgJ13pnyVhldCIhg4Q9Tq4BuqB4c7Ufu7FZjuIZy6E9nW/IL0YaDI1uIJM9EIso69faqExR69xALPlMZUnPgTZGvkNC0wfSkm4vvcf4SoVIp1HtmnTYPj5n9h+YHdT+CPDChZvv5rBCfAh9iV1ppC/tfgyWsGj2/UN5SBStf17jYn5Z7p/pnwoKRP7Mb8ZU3pn34hOCxLRMi/qrKKQMKGuL0EH4ar55B8aYnnj04A3pGfKyX8PLCRfBBUtIERlA3dh5dZIyeEL6++nreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TazNlE1z6S9jkOSzFVrQVg27H1/XGah4hzZo0JwW2wg=;
 b=Sw0R84kec6aSh3J94A0L/C5DjdxIbrEGg/CZKYeUHWKfbKq6ZSkgeAK/1zTEasZObVcjL+LAypEToPoc/ycZ/zAhd1a2TkQnZPoC+RqgJizYvBvcL5V7E/WbO6/3pJHva4gYn7d3ftds7whTBj8Zei3sQccxhyzzBFB4Vi4FI7h16Apm9GE1lnuJmHQbUdcm/5M2HHhFzsjD/nmWJKz4m47TVBVd/iX4aXGf+EcPyrk0cZIieWWvKqAkkU+u5OXqiHTeMFub7ix7ozsSS7hLURDR/qEsYXWy4jJdftId1FQGM1hpGGHaViD0Rr5WKg+1+MHfI+EyAVBKTijE9Y6e9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7685.namprd11.prod.outlook.com (2603:10b6:930:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 09:35:57 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 09:35:57 +0000
Date: Mon, 23 Oct 2023 11:35:46 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
Subject: Re: [PATCH bpf-next v6 11/18] ice: put XDP meta sources assignment
 under a static key condition
Message-ID: <ZTY+chHJEgggHu5J@lzaremba-mobl.ger.corp.intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-12-larysa.zaremba@intel.com>
 <ZTKrjU0a0Q1vF1UU@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZTKrjU0a0Q1vF1UU@boxer>
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY8PR11MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce5b782-b75f-422f-e09f-08dbd3ab7586
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PlofB9EYmQ0ziDUv4U0BVSX7gBjJuERrblEeNUEJu/CDv7cZO3nwHeoy/M1UVnoJD+jCA16UYVuVqfOYsQVgKY0gl0l+bjY3+AVex8B2JsbFbvhNM/3c8kGkqFRLu6rK0Y1OOOKaBa9cpl9xqVk2GseIZpfqmt/Wt8yvFiElIojOBHyd6kXo0azz26VaRuuwc5iyvAWxYmHnfhNvy35Wjj4KmWLiLOjNchM9Sf1SpyI2k+/lNYZwABlNeHHb0nBmd4r7IMozJyUM/tKNb730d9EyYcVulKNfzbcOuQZFfx1xfEZOldm3DunwO/v7h6WLvyBFHE4sp8zkJFgaPmZ5YmGlSTz0O2JXNNoE8TsKRTwgffbnYYmfpjUv7I8vGoNI7W0r6pmt6Kserl4nN1vWo8ShYKSYmnrr3mBMCTuo/TIQs4eWK91UHQKg8m3bIuxHUy9DfIb7d8JANjhVtRefkWBjGtUDWeqBg4jA/CdSSD7FvZ16hXP6YB5sGIxEdmcH5YZcY6Aod2iMtCzq/Vj+EaCfhj3gRzkKgVLnwI1fw8lcUeiQimu7LzdeLprfcdZuewNdzqzUx0H0SUv2BkfMY2XGDtjtbH65AuxVuEp0Q30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(66556008)(66476007)(66946007)(26005)(83380400001)(6486002)(6506007)(6636002)(44832011)(41300700001)(54906003)(6666004)(316002)(8936002)(4326008)(6862004)(6512007)(8676002)(5660300002)(478600001)(86362001)(82960400001)(2906002)(7416002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EaAREKVL2vY9EV+UUGVBVcvhFpZFxVME+BzfagmAvR3TIQ9SUjiCbwyVwdAs?=
 =?us-ascii?Q?effV0zuosZZ1cEq/TjrDuGjgSnozs+5YzesAgFVRoYJZtfc9MBRkGe6suTFx?=
 =?us-ascii?Q?lxvoyZamWTEL2Lv1z4MiZ6+rU6kvHOi5B0Q1gZd3y9mArY7+dN2y+ugb3/tl?=
 =?us-ascii?Q?ATpvVffAGx/CwQ/289/k/1kZo8PkI3RqiiWpUcZL8ErYjWjSVrWireEUoxxt?=
 =?us-ascii?Q?t4Sg19cfkiOkCNxXn+M5dYSM0LRaKLOpUzkDx0z9EoSzAVsRxarttd7fMYQ5?=
 =?us-ascii?Q?Z7pgw5p4nRWmQb6bJpbRDP0PqZVMJwTISkvHV6d0lRodi2JX+6N1D/gLjHoJ?=
 =?us-ascii?Q?APmuAI5ALjlEHUqNwD0fnci1J+EmRfM+FTZyA1ck+frv1QG4PfiY0dChcQOW?=
 =?us-ascii?Q?uSNbQUDFOO1kTUsAdRnHsUE4xAO0lMxVZCVTr+o7TsTtxpjEGct+9wwzy/lH?=
 =?us-ascii?Q?Tt3PGFKil7mh+L9C8NVrKgmArPCQRjbaiVp5H4SASiPzq41xx4d5YCydtqer?=
 =?us-ascii?Q?+qostE2bw+6pzQCAsAR3zShFGwRIywoj5hoxzFBTleWTObULOy5FV/kbRqZR?=
 =?us-ascii?Q?EaMyyvBinCFZzEyNK86y44P/PiH3Ym0g7On1/DD+wH/VFZw2U063nwHpnmsW?=
 =?us-ascii?Q?BGJe2p8vAwXbfy+UdFDq0B8M8qPa6NDuZ3V+tkuFcHAIWSoM87SeiOgq9eeW?=
 =?us-ascii?Q?TFGgZF8PuwQ1qoRsZp/HrSpHNLdkR8+ZM6n/QihlBgq6O+QiE3UyRz7gFJpO?=
 =?us-ascii?Q?vmf9WynlW+S/6YyjmSO5V+BV6u2A0IpX6MobGOYEPEj1grDl/CRlskEvX2S3?=
 =?us-ascii?Q?Y3dOLn13xU/Z0pjSx3ZFi6Igu6RN2LKE3vy/szrdxHqB1loV0gWlUI4zIrBh?=
 =?us-ascii?Q?EzahUoB1MddoRbVPfbgAKK9+F7O1nY+SUxavtx4mBSy1c5WEVJBFtCNzE3ju?=
 =?us-ascii?Q?Fx8to4DxqpJUOuJAa0pIES1nD/lckI25oUW6O+YKxHsXBI6tHmpF35allr48?=
 =?us-ascii?Q?TVO7zBDgIV/QVxtShdycuT3w5RmUzBWBdnLrbpx2yy975S4oxbSB7AXkkxBm?=
 =?us-ascii?Q?EGQLKHuB2aSSKTDKdo395jmIQa/aJUl65jo7NzvGHiPo5yPHxP1eIzhf5kU/?=
 =?us-ascii?Q?KgN0uRWrrCE1+9aYcM2QQjVZvAzM6qGeGZKPtbNAmtZNM60yYg2KQA06vcvp?=
 =?us-ascii?Q?Vd8a+LUGsSecAFlD+/MFS7Du5lDXqEHZBpDAWMJBlkyZu507CB4eF9PPEAU+?=
 =?us-ascii?Q?HUMdn9chMMR/zhGP6j7S+RGYpABKTiM75PumypmtapoYVVSWAQud7rT5Fm4a?=
 =?us-ascii?Q?KskOKbJPYknrZ6MHD9BzNHFiQ/iIjYOx08TP4abCXWHaEFToBqXKd1EWnUcl?=
 =?us-ascii?Q?ojkeZ7j7hloMANKzTTXkMU4w44zzX72J/FbgB68k2BWzv7qEgKFcnkyBhfAN?=
 =?us-ascii?Q?hpVL4aL67dWLVRMN1pceILvduyatfcB56ZEnBCqC7Ca75SxYV72URYQTXj0c?=
 =?us-ascii?Q?Qc/WEEqxvKRS2NrAePsRUBgn9qZRradCmL8MJWyanUtgvnKvqwvaeZ/68t4c?=
 =?us-ascii?Q?CHaSsDuE4BOycx5dYpZx7uyNAfCElLzfLBnzFhDtdPGU+fyhmSccHTPdIiid?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce5b782-b75f-422f-e09f-08dbd3ab7586
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:35:57.0197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxFnFIr2NzH1/o1tcZX86djb9fuVJHlDQHauih1yuyaqDzaPdrZViQYJOD2Ti+j6lYPkXSZbY0/kqbumqSzTE+/kL/d65qlMXRIrCFPVgd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7685
X-OriginatorOrg: intel.com

On Fri, Oct 20, 2023 at 06:32:13PM +0200, Maciej Fijalkowski wrote:
> On Thu, Oct 12, 2023 at 07:05:17PM +0200, Larysa Zaremba wrote:
> > Usage of XDP hints requires putting additional information after the
> > xdp_buff. In basic case, only the descriptor has to be copied on a
> > per-packet basis, because xdp_buff permanently resides before per-ring
> > metadata (cached time and VLAN protocol ID).
> > 
> > However, in ZC mode, xdp_buffs come from a pool, so memory after such
> > buffer does not contain any reliable information, so everything has to be
> > copied, damaging the performance.
> > 
> > Introduce a static key to enable meta sources assignment only when attached
> > XDP program is device-bound.
> > 
> > This patch eliminates a 6% performance drop in ZC mode, which was a result
> > of addition of XDP hints to the driver.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice.h      |  1 +
> >  drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_txrx.c |  3 ++-
> >  drivers/net/ethernet/intel/ice/ice_xsk.c  |  3 +++
> >  4 files changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> > index 3d0f15f8b2b8..76d22be878a4 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -210,6 +210,7 @@ enum ice_feature {
> >  };
> >  
> >  DECLARE_STATIC_KEY_FALSE(ice_xdp_locking_key);
> > +DECLARE_STATIC_KEY_FALSE(ice_xdp_meta_key);
> >  
> >  struct ice_channel {
> >  	struct list_head list;
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 47e8920e1727..ee0df86d34b7 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -48,6 +48,9 @@ MODULE_PARM_DESC(debug, "netif level (0=none,...,16=all)");
> >  DEFINE_STATIC_KEY_FALSE(ice_xdp_locking_key);
> >  EXPORT_SYMBOL(ice_xdp_locking_key);
> >  
> > +DEFINE_STATIC_KEY_FALSE(ice_xdp_meta_key);
> > +EXPORT_SYMBOL(ice_xdp_meta_key);
> > +
> >  /**
> >   * ice_hw_to_dev - Get device pointer from the hardware structure
> >   * @hw: pointer to the device HW structure
> > @@ -2634,6 +2637,11 @@ static int ice_xdp_alloc_setup_rings(struct ice_vsi *vsi)
> >  	return -ENOMEM;
> >  }
> >  
> > +static bool ice_xdp_prog_has_meta(struct bpf_prog *prog)
> > +{
> > +	return prog && prog->aux->dev_bound;
> > +}
> > +
> >  /**
> >   * ice_vsi_assign_bpf_prog - set or clear bpf prog pointer on VSI
> >   * @vsi: VSI to set the bpf prog on
> > @@ -2644,10 +2652,16 @@ static void ice_vsi_assign_bpf_prog(struct ice_vsi *vsi, struct bpf_prog *prog)
> >  	struct bpf_prog *old_prog;
> >  	int i;
> >  
> > +	if (ice_xdp_prog_has_meta(prog))
> > +		static_branch_inc(&ice_xdp_meta_key);
> 
> i thought boolean key would be enough but inc/dec should serve properly
> for example prog hotswap cases.
>

My thought process on using counting instead of boolean was: there can be 
several PFs that use the same driver, so therefore we need to keep track of how 
many od them use hints. And yes, this also looks better for hot-swapping, 
because conditions become more straightforward (we do not need to compare old 
and new programs).

> > +
> >  	old_prog = xchg(&vsi->xdp_prog, prog);
> >  	ice_for_each_rxq(vsi, i)
> >  		WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);
> >  
> > +	if (ice_xdp_prog_has_meta(old_prog))
> > +		static_branch_dec(&ice_xdp_meta_key);
> > +
> >  	if (old_prog)
> >  		bpf_prog_put(old_prog);
> >  }
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > index 4fd7614f243d..19fc182d1f4c 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -572,7 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> >  	if (!xdp_prog)
> >  		goto exit;
> >  
> > -	ice_xdp_meta_set_desc(xdp, eop_desc);
> > +	if (static_branch_unlikely(&ice_xdp_meta_key))
> 
> My only concern is that we might be hurting in a minor way hints path now,
> no?

I have thought "unlikely" refers to the default state the code is compiled with 
and after static key incrementation this should be patched to "likely". Isn't 
this how static keys work?

> 
> > +		ice_xdp_meta_set_desc(xdp, eop_desc);
> >  
> >  	act = bpf_prog_run_xdp(xdp_prog, xdp);
> >  	switch (act) {
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index 39775bb6cec1..f92d7d33fde6 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -773,6 +773,9 @@ static void ice_prepare_pkt_ctx_zc(struct xdp_buff *xdp,
> >  				   union ice_32b_rx_flex_desc *eop_desc,
> >  				   struct ice_rx_ring *rx_ring)
> >  {
> > +	if (!static_branch_unlikely(&ice_xdp_meta_key))
> > +		return;
> 
> wouldn't it be better to pull it out and avoid calling
> ice_prepare_pkt_ctx_zc() unnecessarily?
> 
> > +
> >  	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
> >  	((struct ice_xdp_buff *)xdp)->pkt_ctx = rx_ring->pkt_ctx;
> >  	ice_xdp_meta_set_desc(xdp, eop_desc);
> > -- 
> > 2.41.0
> > 

