Return-Path: <bpf+bounces-10060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B19A7A0B41
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 19:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24411C20E17
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081202629B;
	Thu, 14 Sep 2023 17:05:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6FD21355;
	Thu, 14 Sep 2023 17:05:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B81FE5;
	Thu, 14 Sep 2023 10:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694711148; x=1726247148;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5eutTLCmiQgQyLeWwtAzmIbwJeeNxJ1+HAO3Jc5PuRg=;
  b=YablAqUkouC0+XV6jZ5DgbuXpfKD/nqFZAQCrcQJRWjITU9U7CADlVEF
   bfoi7BkxmpRA1xBAkoYhrF/LiP+ZTRxleRTPy7sbealyAKblPeYujn6gu
   sb8C9nfeQTy0otzNAuQnjRLo3KOxjDHB7B2oxHfEYWjD4VxsRAx+jAphV
   E1JmqdXRBNszemohF6MLlXYTcJVdk7WgTCwIpUHQyFiKYHCmcWqhAPEpg
   uvJbVW2wZIufdapiSvS+9X0EByPxL5YF/dFQyUvJUFK5Jxl2z5sG2h3uV
   rr/VPt+Sc3lkwKWrigOzfiCdJlbQV99SyRPluWeWBvRgQ1Mc8Sfy9amYh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="445455667"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="445455667"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:05:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="779730397"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="779730397"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 10:05:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 10:05:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 10:05:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 10:05:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnzuWBe2jc6TiB4Kdv5dNiz409HlHnF5kerO2Ozu0lWCwQttmEl7uOKwl+1dxkMLXP0K3xc9oBbbUcM4SbAD12cXpsJz676WWSoqsu73Rhiq7K2CG0MunaY1RaGW8pniydUNKSvL64LIiJWHd4IAOknibfWnD8jFu/igKyHxomhLY2Ok3Rqeht4J0AElpsFV5+mYBaVj8k0Depa/1MfLAk8U9VWqqcaMDY7xg14zRNCpQ7Fe/EWw0UctcmUyuhliKkkDti2MVA7ICKS+OB9VtnXiB0a4acX89W1n9C9XpiT2fWhir3cm9wr2ec3QwN28pGZRArtv1x3Wah41AsnbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tS1f4TvyV0xUKMh+L3+DdD9lin1R7ch6JA2gPICi06c=;
 b=ZPVI985p9+K8e8v9DEGx+GP6Hm0cCs74JNvonvvKgcYmyTzFhA3+Kb+F9WaztGMb/zcUl0v0U3QODFWCVQKElZW4eR6SCb2vqMugzjOS5a8U2b9KvhLBiqSet/7c9YlgBehOfTxBwDvGlVD2yd8Rrb5isW+Xg8wAm6Nmdf+diP/LXCyXf6fV+9EmTR8Q7SXfOSZ/Tdp4U016fq3soIyrnzldOrhOASH8jWAn/GA5817tRL2DHm/nsJXAne7Xv82oRmMUIEh53fewFAl1Yu2gVyvSR23WUslNyQLJDiHBTJ1MOeJkpgfzbVDW1fZTCENjPtYW5+S5DaTfYVCt6xSilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MN2PR11MB4664.namprd11.prod.outlook.com (2603:10b6:208:26e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 17:05:11 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 17:05:10 +0000
Date: Thu, 14 Sep 2023 18:59:27 +0200
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
Subject: Re: [RFC bpf-next 07/23] ice: Support RX hash XDP hint
Message-ID: <ZQM77955STTiYebm@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-8-larysa.zaremba@intel.com>
 <6bee72b4-dbfd-b62b-932f-8ca0da705994@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6bee72b4-dbfd-b62b-932f-8ca0da705994@intel.com>
X-ClientProxiedBy: FR3P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::18) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MN2PR11MB4664:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9a7246-47f7-4562-d6f4-08dbb544c0b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJuVXjiGzv5BRdfbVN671pJaYyClD45WJFP03wX38XmuPNn+ryM1Su95vdlzIyqzrCoM16wMLfMsqAml3wYyLjzBanpN66RaFxLeYbV5uARi/wUIk/teTVt70KNa2KH6WQisqEheT5f9Nh76OyalB9qJFWXBn3USyUn7hLrAYVxVmeHZxbjXTUN2pDOFUN9cM8+6IauCDEaqLqXNl6elskwZaFZtJTqYFOzNZHDBr71EJxi+RyKbghcMWvNl7lZXikRXgdfzX2sfxSilgWJovPTyGtQfLB1sDPzqm6stYejOWKNpjIuNoiAYbC5dAtFt8t6qurN895b2dQjSoHI5LPBkRcqWt+w6WYCU9u2ZKqqdnZs+nrqyOXjAGFzzec2AilC6SiN8OCjduKTZyY4kZMkzB2q+2P1W0JDD1OHE/INZpRIFLXqS57nwZd4hK+urjT/CyXXs8CvmcnVDq1+lpBFVyRdikDtxNUprSSWmlqrJHF7ONRDBTjDgfXUcR5bt50KX5cL/TVLu8blbTsU3YIjLm6jYS8Ss4grCAnFAORCxC1DImTGFZq2p7vdlS0Dh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(366004)(136003)(396003)(346002)(1800799009)(451199024)(186009)(6666004)(6486002)(6506007)(478600001)(86362001)(82960400001)(38100700002)(8936002)(7416002)(2906002)(6512007)(6636002)(9686003)(26005)(83380400001)(6862004)(5660300002)(44832011)(8676002)(41300700001)(4326008)(66556008)(33716001)(54906003)(66946007)(66476007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YAKI4JzRuULx9nu4pVTF6xRl8s3QencOoUkYUbRlfCKyyoMdv882T0o5rmtr?=
 =?us-ascii?Q?IhYDvgDKPojtB6AHhZ1lrCQs3HIqYnSiJn5B8oPiXkKmFA7F3k1HhHcrwMlE?=
 =?us-ascii?Q?gK4SdTS/CJEvBmg+Z7JE2XhgkrQhoVoNQ/R0xezmYB6/5OWA/HSD3J6ZGKOw?=
 =?us-ascii?Q?MkVt0L6KMboG4ET3fj48j2+aRYSFMoQoZU3VcJzYS6lJS5WHzTGc7Ycq6eFx?=
 =?us-ascii?Q?jBAvwQbKEOfdIpPn7TGsS7vB+FkTLo9JrujYiA8JJ4QKFLllZ+0VzwMFOUYM?=
 =?us-ascii?Q?QRPuX8J3M/eF8eMSFUkWbyFImCZ8DOJtakEghVFryTAYUPlLXbMnfC6tw3Ro?=
 =?us-ascii?Q?lQvsa6uuXqwzAN3Gs04gbA534Spu/dVhdbG/WIzscQoxzSKAEg/5O9uy45iK?=
 =?us-ascii?Q?Dy9Kl6v3rLI32EAsAxjNr1miR/BhNYG+4YKKbc57Y60hT/7PU4tfrEoAr1c/?=
 =?us-ascii?Q?sFsFk9htQDutv9Ws5BlLfz3rmcl/JszanDbLJhVhJfC5JNgP0ojGAsEG9Zph?=
 =?us-ascii?Q?YRD650vVW478oQ0Pl8km879P+FTOMBiSdxhwUFQQeheeu5clf0Ki8+PmVcYi?=
 =?us-ascii?Q?DG3WpVnjweW/MuVV099S7xgmYE9sgEOsyHwAEXwYTYs2rptFBnfxFUvP/FM/?=
 =?us-ascii?Q?c4AFwDGmQDhPw53aDbiS8IVg3NJ73WzBQXgeaB5/ajdB5aNxREl8+mKn32XK?=
 =?us-ascii?Q?GHlt+WdxFaODF0EfXFTV8+Stlk1JWU/Hty4hRt4QZC+mjU6I2nt5B94aE70K?=
 =?us-ascii?Q?TGP3jDxjDWxUQxpMnc3x12gmBR26oE0AcFiFmO2i1VtGpNrhGvLgTI5J19er?=
 =?us-ascii?Q?Um2oMdO0shcltu2rP/VkL1eAXzA8ywPLI9UFJw1G0elBoPCFbZSQleIB4+V9?=
 =?us-ascii?Q?iTBWuKWM6W5Kkm5k3q310J1HpVHhIyqav4jzdT5gb6NWSTA/znI9rEYfN3Am?=
 =?us-ascii?Q?4P4Ly9f/E0b2gDZj0PF2LI493QUTEE+XXyiwhrcDisybNMMU5jlqYEjzl3q9?=
 =?us-ascii?Q?+4Kizns5BNI3uLrtjRhbbtijmeWRE4VMOu1wyxF4RxBPKA+fL+aCg3ybmaXO?=
 =?us-ascii?Q?o2+awTjEtM9a1/Hg4Ec3EgN4epT9nLZkrNhAebkvgTN//xQ6D83YIosfG2iy?=
 =?us-ascii?Q?wffZNTKIwkZI21W4+AwP0Ru+iNlWDKHRd91viydriwYjv4GjD4mEHGwdVW46?=
 =?us-ascii?Q?2ng7eH7GtTVuugVDG1LTzffncgyxn2MK/Lqrb3jnJW974EGNJfR1/Ata7vAx?=
 =?us-ascii?Q?jCVqmFn1x1tpcdjNqKiz6bB4jGjFLTk1eEEDYMuUSxcL7ZKLihPvY1EFesqt?=
 =?us-ascii?Q?+lQicVIV1dzvBq6gpUnMRLEM9y2jSfgUgUCiq2euKU5s+/1XZjGbUCJbZ9iX?=
 =?us-ascii?Q?xcmdDw5waYurmcBVVVFRkwsSW7b2Krvd0EvrEN/xROlZWRYVrhQTIWDaarU3?=
 =?us-ascii?Q?BsVd+AmTIs5lg6Tj7jB1sMX1cqZfSSvFIK5z1lUk6zona7eQd1Dj7+SaTdFG?=
 =?us-ascii?Q?GUgTLudY4FFdu3qLwMPEK4UZP1SWSsq/q3DRy/fQ415bLSdnncWFSbERbcUw?=
 =?us-ascii?Q?DGRtf8Qy68ALvIj88C5loMCprMNrRmnlrhxBR+MLpPNeU+Qkrk6NlmPkfg/T?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9a7246-47f7-4562-d6f4-08dbb544c0b8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:05:10.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKJOOb3F0tkS1qhaQL+e7PaWRCdYA0ms69HE23xFHZ6eUiERiXZH7+kDBBJIB7Xe9URrnNzdOvaJYSbouCwUZby4I/hVXlEAAt0/yAArG3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4664
X-OriginatorOrg: intel.com

On Thu, Sep 14, 2023 at 06:54:21PM +0200, Alexander Lobakin wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> Date: Thu, 24 Aug 2023 21:26:46 +0200
> 
> > RX hash XDP hint requests both hash value and type.
> > Type is XDP-specific, so we need a separate way to map
> > these values to the hardware ptypes, so create a lookup table.
> > 
> > Instead of creating a new long list, reuse contents
> > of ice_decode_rx_desc_ptype[] through preprocessor.
> > 
> > Current hash type enum does not contain ICMP packet type,
> > but ice devices support it, so also add a new type into core code.
> > 
> > Then use previously refactored code and create a function
> > that allows XDP code to read RX hash.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> [...]
> 
> >  	/* unused entries */
> > -	[154 ... 1023] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
> > +	[ICE_NUM_DEFINED_PTYPES ... 1023] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
> >  };
> >  
> >  static inline struct ice_rx_ptype_decoded ice_decode_rx_desc_ptype(u16 ptype)
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > index 463d9e5cbe05..b11cfaedb81c 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > @@ -567,6 +567,79 @@ static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
> >  	return 0;
> >  }
> >  
> > +/* Define a ptype index -> XDP hash type lookup table.
> > + * It uses the same ptype definitions as ice_decode_rx_desc_ptype[],
> > + * avoiding possible copy-paste errors.
> > + */
> > +#undef ICE_PTT
> > +#undef ICE_PTT_UNUSED_ENTRY
> > +
> > +#define ICE_PTT(PTYPE, OUTER_IP, OUTER_IP_VER, OUTER_FRAG, T, TE, TEF, I, PL)\
> > +	[PTYPE] = XDP_RSS_L3_##OUTER_IP_VER | XDP_RSS_L4_##I | XDP_RSS_TYPE_##PL
> > +
> > +#define ICE_PTT_UNUSED_ENTRY(PTYPE) [PTYPE] = 0
> > +
> > +/* A few supplementary definitions for when XDP hash types do not coincide
> > + * with what can be generated from ptype definitions
> > + * by means of preprocessor concatenation.
> > + */
> > +#define XDP_RSS_L3_NONE		XDP_RSS_TYPE_NONE
> > +#define XDP_RSS_L4_NONE		XDP_RSS_TYPE_NONE
> > +#define XDP_RSS_TYPE_PAY2	XDP_RSS_TYPE_L2
> > +#define XDP_RSS_TYPE_PAY3	XDP_RSS_TYPE_NONE
> > +#define XDP_RSS_TYPE_PAY4	XDP_RSS_L4
> > +
> > +static const enum xdp_rss_hash_type
> > +ice_ptype_to_xdp_hash[ICE_NUM_DEFINED_PTYPES] = {
> > +	ICE_PTYPES
> > +};
> 
> Is there a big win in performance with this 600-byte static table
> comparing to having several instructions which would do
> to_parsed_ptype() and then build a return enum according to its fields?
> I believe that would cost only several instructions. Not that it's a
> disaster to consume 600 more bytes of rodata, but still.
>

It is not disasterous either way, I have added this table after a discussion 
with team members and would like not to throw this away now.

> Alternatively, you can look at how parsed ptype is compressed to 16 bit
> in libie and use those saved bits to encode complete XDP RSS hash enum
> directly there, so that ice_ptype_lkup[] would have both parsed ptype
> and XDP hash return value :D
> 
> > +
> > +#undef XDP_RSS_L3_NONE
> > +#undef XDP_RSS_L4_NONE
> > +#undef XDP_RSS_TYPE_PAY2
> > +#undef XDP_RSS_TYPE_PAY3
> > +#undef XDP_RSS_TYPE_PAY4
> 
> [...]
> 
> Thanks,
> Olek

