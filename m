Return-Path: <bpf+bounces-12540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A1F7CD97A
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 12:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5230EB211B3
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9D618C1E;
	Wed, 18 Oct 2023 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RimDYnxQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC463156CB;
	Wed, 18 Oct 2023 10:43:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ED9B0;
	Wed, 18 Oct 2023 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697625807; x=1729161807;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5UsExHHLsig+2oB6/rQ5+copokQFOrX69iXoGNDWYaw=;
  b=RimDYnxQYgTdU58wKO05q80gFXK5aspaziLSS1dp2FxccA4QHos4eLAA
   pdi+Mm+FoI6/R1utuHG3clxEgu7VdO0hm7+JyeUDf41HAiFhA4EcP7WTv
   LCrwCMqt7PCuA7J7RqpHrScWLa/XD09QqQUauicmN9wtauWj5ZxIoombv
   Uf35myLfkCNbRlv/hCFLrREb92c3yUxgIpfQPKsTUTlLCQd2ZVk52Tgtf
   P5G2uQMkRe1Kcns+Oig/1Ix0W2vDCAmyndVc8WPqCzb/Cb+HW4jJMoR6D
   GT+poDvCpRsNA6uI6pP0CWvcUCOO5PWfj3iuXGP68WCgJE5ka8IN1wda3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="383207447"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="383207447"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 03:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="760175812"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="760175812"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 03:43:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 03:43:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 03:43:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 03:43:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJNY7IWIGsg2jv2Nl4YdAnGdkJH5C7YIswqDUVpOHGbaF5/+mwEK4OF9gDaiVGDqdvjK+5lVxch0qN3Ncuz2rzkd/MQHA1CORFKlKLX5QRTeix2VodesaKOPFzmOKsEidfhLKnGrTBoy/O1FcbPh22rWICwTVOTzsF02Ur6CPTnsBnsAQIgl/tMIhDBDyt7peEeZxUAQvpbNd45YpFvmlf389IHOy09KUzh/4P8szrCDVvNzybBA12TaLB2X1w5EnAeSfkQla9vFvbXE4KcEQ8CBIXhG9u7/mZDqSTh3hharyTWWAlAxjuSlGXGIx9UeWbOWH1R+yK7cvDOLC0sZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcpNljNI0XrX0Qq4E7wAF4LOH40BBdPvzsutTY8ofHE=;
 b=eNRqnxM7NdtY4cI3J6i0PYIMr6uxl7jxScnklAC/21O5XZyNdNGzgodKUVulADo+s6eKHqS6QhHLvYFG6wXv6gIA3CiV543zCJqjBypNshQvtXGSdCNs5pNh+ZQa8Z67Kv8C4pk9ntSxjZ2LoWRvISrmjLsG8cZDO0zxAxzW3Wv7HBNtpRZCIlYOQau4kXHKnNN55Jo859duTmnfdKl0/1CEIL0/jJIUkpiQ/cm2qB11klj3PQM9qxKK9rtgxAij8sPmbka//Y293ql1EZfCWd6EGQ3rw3SDk8zqvpiqqPHkmZ45rXP8aOMtGs/9xsvQhPzcWsmUOZNh2P3vk3PPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB6795.namprd11.prod.outlook.com (2603:10b6:510:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 10:43:22 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 10:43:22 +0000
Date: Wed, 18 Oct 2023 12:43:06 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Maryam Tahhan <mtahhan@redhat.com>, <xdp-hints@xdp-project.net>,
	<netdev@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Simon Horman
	<simon.horman@corigine.com>, Tariq Toukan <tariqt@mellanox.com>, "Saeed
 Mahameed" <saeedm@mellanox.com>, <magnus.karlsson@intel.com>
Subject: Re: [PATCH bpf-next v6 07/18] ice: Support XDP hints in AF_XDP ZC
 mode
Message-ID: <ZS+2urlM5zqcJ6S5@boxer>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-8-larysa.zaremba@intel.com>
 <ZS6yqqMZD1mojQNr@boxer>
 <CAJ8uoz3Bqtb-F1bpKWKx8bhftJW7g1BEyjxnQZprRv4NxsXi9Q@mail.gmail.com>
 <ZS66DrMFeuerTI01@boxer>
 <ZS6+fcfjQgIdD+6G@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZS6+fcfjQgIdD+6G@lzaremba-mobl.ger.corp.intel.com>
X-ClientProxiedBy: FR0P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::11) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 64886dd9-5d36-40c4-a6cb-08dbcfc70c29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HwQZTRVPoQOCHTc3pwhICpdC13HBtbThoygaXBuJIddoZr1f2GarUDhTqgzT+6q5DFeC6C4O6gjtwZuOkdsWankPZ8HU45+MgG1Y6k/i3OrXS17lrOt4FFzjAUKVQA9KuuLKuah5tURFii4habXERu3zz4ko7PGr97WY7oQIFHd+loyNQaY5ddKBeyiHl4/IgMdhf26v24gte3mbrZN6tZq2ng8B3R7ryY3nHmyf5uuvsXCwc2Ais4WWlevTelRVE2akwgWjCPvvQepdyMpevAdOve1sQ3dAS+TjB8DPJMG6GIbloBujXZ8m+2yc43ws7NzBgV+nfLz3qf6SOs+7QkCO25nqQ9MgC6S1gSR/Y7XKAkjPgoukH0/mWNq1Y9kJcmUu3A9e0iFKXPNd2N/zvMCXACTAePxEKSY1rOEmTPYNu8tlgKUmYtUyl7xOa5O47Z+pdr9viHTxDfz3kLm3Zfp/Ty31HEk+/KizD2WkPS4xB3r0CURi117B3nstcMbURYz0d5s6URBOKMZGACu381qztbh3Q0jjttc/HR3F1aEEIQzL1OZ90lCHif9OUwBLauZOl1NHjdt2+Um/OhaFHaQvHPymn0wn/XnbGnJ5dQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66556008)(6636002)(83380400001)(26005)(66476007)(66946007)(54906003)(478600001)(6486002)(6666004)(6506007)(41300700001)(107886003)(9686003)(82960400001)(316002)(6512007)(5660300002)(44832011)(4326008)(2906002)(6862004)(8676002)(7416002)(8936002)(33716001)(38100700002)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4PXmr94iXvhpGGYY2Y0/R0MVzLHmzN/ncKVNI0yqzX0JoaxPN+hyKRhSfzgv?=
 =?us-ascii?Q?X/9vSwAQcOBqab9h/A1md52MQP2PtxHLPOKsAqwCiUiqjf5NQ/eHF1prESen?=
 =?us-ascii?Q?ANIzLqbmzHHme7c8eJbf/MF19OdtpScRw0VXceqjIT/6bVKa/Iu32/BTlGol?=
 =?us-ascii?Q?pZoofKrWS+8/NfOvjDq4hH1ZGaM1jc0EL9k+eQVreryXNf+pETP3o7cq0G83?=
 =?us-ascii?Q?KME4/P8XzLmXvWQA2eBNQ/NziuE3/NAkwa8sDNKqjEBYgO6OR+kD1/EID3pX?=
 =?us-ascii?Q?MsM2LGxkhCY+xyOpJDyGdkD3K5hO9rA4U1Qsz+Iz1rOCjg/NGYqZqJfT5rY7?=
 =?us-ascii?Q?dVA9m890c1vLKkbEqaFL8bDWSVPAzt9cfJ8OVKRzX6yDunqIgiGYlqkOAhoh?=
 =?us-ascii?Q?qmG4/K8KbJONwgbJApe0zp59hb+7T77nGvhQNE2bfu2Z5vgKY21wj/XkFl41?=
 =?us-ascii?Q?o5JirDzMmOF0aUoRIGfLc2I+i2B+p8nyZ1gE8zPdMLDBY56rJ3cmsrLo1PBz?=
 =?us-ascii?Q?BBF3efGpmW5DzUCf1yfEg8IqrSa9Xl/G/eoEJ1EFrQFwyRfBDjscrSffqF3A?=
 =?us-ascii?Q?rJGmMIa2pcmgB3MhYmqjixQdjpFSsbm+2Xk47gRgdEWKRvQenb1hACW6hPho?=
 =?us-ascii?Q?J64spm1fqp0RuOzkjbXuW21exPo7EMVbJPepYiELSOTJxZUqN0GdKB3z4YHf?=
 =?us-ascii?Q?tg9A0yDmOgj17thFk9kPiv7qyYNfRI9Tzlc4DEXrAkW0ojyA3UgKfaC3thj9?=
 =?us-ascii?Q?s/Yv3vzgsN4Yna/Pfd5lSr1AFwfNil4LE/28mmUzQLQV2RogfI7iDulx2cdi?=
 =?us-ascii?Q?6YVzEwUaVLm0d6FV7FbN00vExfRi3AMTZkj5F/tgO/5pPIbdgFGif5rS274B?=
 =?us-ascii?Q?cQa/gxY3mEl9hs6w645wupjR/IoVEo/FNIoLPAX8BiVhrUovOl906v/C53Du?=
 =?us-ascii?Q?ylaqMrHzz2u2H43cu/ciQ7oTxHZzdSUy3jppKP6gUOLJX+LHPPCh4WI38CqZ?=
 =?us-ascii?Q?bIwB38nev/UJw2VwlaMjkJNnPFOpHHu1y2N0MnQIZSAX3P5tcljpH3qKTU0P?=
 =?us-ascii?Q?zD1477lloZ5GnSWPMmbRwV3wxbLWaBy8txBOcQqwurYpw0uA+njgDCghKG4h?=
 =?us-ascii?Q?smxQwYG6qu9fmQJwPXhfkruW1a3Jaw44E5GzR2zXp/vEze5HFgRQDEcl58d0?=
 =?us-ascii?Q?mvizUF7j8fnujZbwoCutXQEKWVAQQ6n7v8i6AuMNuyLWjgw8rxxyhV6WNymX?=
 =?us-ascii?Q?eR769sVZXU0p9czQDmTiimD2bCgoCFfdkO/blcm9dM9hPv8ik4XzuNJDGfAF?=
 =?us-ascii?Q?xNvMkfmTvs7U/nwSM9uAP7GK+TrwkH/kQ1lRW4f/4/JLUj6ojJFpZGpRoyTQ?=
 =?us-ascii?Q?Pp9kQk2Uta/mu4YX+WVI4t1rGZOv718OVdz+oMT94TgZgO6jndm1nE3IlWsy?=
 =?us-ascii?Q?A6bim4dt1OmJ0OkOnloKGnHbc1FeyU6rC21+0Sh0vt3iNXaO1of1Hk2eIpMP?=
 =?us-ascii?Q?CnZz5lZQxwsQC/Ip/+CRt4TCQGBL6lIQp61yZPqF8EHv3Qw5c/+qeMBrQG82?=
 =?us-ascii?Q?DwjMDY4jY7sonGtPm5sh5tJ2bWkkt2BE0Be5OYK6PU7yfka5aMrcvnJz66UX?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64886dd9-5d36-40c4-a6cb-08dbcfc70c29
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 10:43:21.8589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Nui64Wg9Y5X3xf3wnON+JAYaIhgcmFECUY5N2jjSUYYRn1/qM9thcS6eqw57PZcdKeZ6pCTHbzLVjE2gf5OIzn6cpIuCUEz0Hbfn8Eux1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6795
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 07:03:57PM +0200, Larysa Zaremba wrote:
> On Tue, Oct 17, 2023 at 06:45:02PM +0200, Maciej Fijalkowski wrote:
> > On Tue, Oct 17, 2023 at 06:37:07PM +0200, Magnus Karlsson wrote:
> > > On Tue, 17 Oct 2023 at 18:13, Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Thu, Oct 12, 2023 at 07:05:13PM +0200, Larysa Zaremba wrote:
> > > > > In AF_XDP ZC, xdp_buff is not stored on ring,
> > > > > instead it is provided by xsk_buff_pool.
> > > > > Space for metadata sources right after such buffers was already reserved
> > > > > in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
> > > > > This makes the implementation rather straightforward.
> > > > >
> > > > > Update AF_XDP ZC packet processing to support XDP hints.
> > > > >
> > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > ---
> > > > >  drivers/net/ethernet/intel/ice/ice_xsk.c | 34 ++++++++++++++++++++++--
> > > > >  1 file changed, 32 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > > index ef778b8e6d1b..6ca620b2fbdd 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > > @@ -752,22 +752,51 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
> > > > >       return ICE_XDP_CONSUMED;
> > > > >  }
> > > > >
> > > > > +/**
> > > > > + * ice_prepare_pkt_ctx_zc - Prepare packet context for XDP hints
> > > > > + * @xdp: xdp_buff used as input to the XDP program
> > > > > + * @eop_desc: End of packet descriptor
> > > > > + * @rx_ring: Rx ring with packet context
> > > > > + *
> > > > > + * In regular XDP, xdp_buff is placed inside the ring structure,
> > > > > + * just before the packet context, so the latter can be accessed
> > > > > + * with xdp_buff address only at all times, but in ZC mode,
> > > > > + * xdp_buffs come from the pool, so we need to reinitialize
> > > > > + * context for every packet.
> > > > > + *
> > > > > + * We can safely convert xdp_buff_xsk to ice_xdp_buff,
> > > > > + * because there are XSK_PRIV_MAX bytes reserved in xdp_buff_xsk
> > > > > + * right after xdp_buff, for our private use.
> > > > > + * XSK_CHECK_PRIV_TYPE() ensures we do not go above the limit.
> > > > > + */
> > > > > +static void ice_prepare_pkt_ctx_zc(struct xdp_buff *xdp,
> > > > > +                                union ice_32b_rx_flex_desc *eop_desc,
> > > > > +                                struct ice_rx_ring *rx_ring)
> > > > > +{
> > > > > +     XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
> > > > > +     ((struct ice_xdp_buff *)xdp)->pkt_ctx = rx_ring->pkt_ctx;
> > > >
> > > > I will be loud thinking over here, but this could be set in
> > > > ice_fill_rx_descs(), while grabbing xdp_buffs from xsk_pool, should
> > > > minimize the performance overhead.
> 
> I am not sure about that. Packet context consists of:
> * VLAN protocol
> * cached time
> 
> Both of those can be updated without stopping traffic, so we cannot set this 
> at setup time.

I was referring to setting the pointer to pkt_ctx. Similarly mlx5 sets
setting pointer to rq during alloc but cqe ptr is set per packet.

Regardless, let us proceed with what you have and later on maybe address
what I was bringing up here.

> 
> > > >
> > > > But then again you address that with static branch in later patch.
> > > >
> > > > OTOH, I was thinking that we could come with xsk_buff_pool API that would
> > > > let drivers assign this at setup time. Similar what is being done with dma
> > > > mappings.
> > > >
> > > > Magnus, do you think it is worth the hassle? Thoughts?
> > > 
> > > I would measure the overhead of the current assignment and if it is
> > > significant (incurs a cache miss for example), then why not try out
> > > your idea. Usually good not to have to touch things when not needed.
> > 
> > Larysa measured that because I asked for that previously and impact was
> > around 6%. Then look at patch 11/18 how this was addressed.
> > 
> > Other ZC drivers didn't report the impact but i am rather sure they were also
> > affected. So i was thinking whether we should have some generic solution
> > within pool or every ZC driver handles that on its own.
> > 
> > > 
> > > > Or should we advise any other driver that support hints to mimic static
> > > > branch solution?
> > > >
> > > > > +     ice_xdp_meta_set_desc(xdp, eop_desc);
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * ice_run_xdp_zc - Executes an XDP program in zero-copy path
> > > > >   * @rx_ring: Rx ring
> > > > >   * @xdp: xdp_buff used as input to the XDP program
> > > > >   * @xdp_prog: XDP program to run
> > > > >   * @xdp_ring: ring to be used for XDP_TX action
> > > > > + * @rx_desc: packet descriptor
> > > > >   *
> > > > >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> > > > >   */
> > > > >  static int
> > > > >  ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > > > -            struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring)
> > > > > +            struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > > > > +            union ice_32b_rx_flex_desc *rx_desc)
> > > > >  {
> > > > >       int err, result = ICE_XDP_PASS;
> > > > >       u32 act;
> > > > >
> > > > > +     ice_prepare_pkt_ctx_zc(xdp, rx_desc, rx_ring);
> > > > >       act = bpf_prog_run_xdp(xdp_prog, xdp);
> > > > >
> > > > >       if (likely(act == XDP_REDIRECT)) {
> > > > > @@ -907,7 +936,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
> > > > >               if (ice_is_non_eop(rx_ring, rx_desc))
> > > > >                       continue;
> > > > >
> > > > > -             xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring);
> > > > > +             xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring,
> > > > > +                                      rx_desc);
> > > > >               if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
> > > > >                       xdp_xmit |= xdp_res;
> > > > >               } else if (xdp_res == ICE_XDP_EXIT) {
> > > > > --
> > > > > 2.41.0
> > > > >

