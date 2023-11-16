Return-Path: <bpf+bounces-15193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661A77EE3D1
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AF91C209C7
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE2134576;
	Thu, 16 Nov 2023 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wfeu0bZR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1891AD;
	Thu, 16 Nov 2023 07:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700146946; x=1731682946;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=buMfo7bTMTduFmTHphZRYBjC7XpUnOaeu/4KIpehVBg=;
  b=Wfeu0bZRZmVmCigAWcbl5Ry7TwNlJtpVNBfLAricoD4NTeoCFW47OxIc
   zXtNQRYJvQ1gUYuwqbXWZREO/9L3L7+21Ej6hc5TtRPKXM3B3cnc7rPl+
   ZAEbm/074wABdijVq34fTZ5IhdYYzWpZdlgKOmUOJb60HIeYJQ+RpyaL8
   2YMSbF/7QATJ3pXbPKi5z6/PE/Yb4PeHkTszJGPTvT3r/8TIADVp4fwXw
   w1B26G+ff+UpSWg7kSqg4Zm7zD/zDGAmeVTWY8jlc30riuq/l1JIT+uC8
   r/YuEtfWg4pLyVw+ixkWKbmfR6b8dosL6mPvYRVbc0+Tg8eVKGZe/UUTw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="455396138"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="455396138"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 07:02:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="794518203"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="794518203"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 07:02:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 07:02:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 07:02:06 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 07:02:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqksqjigp0FfGlESSu38Gr42mk0EOjTQ5ekdefA3YVCZa1dih/nUEt1zHk8qkJiUjKk0bdFxpi6VW1tjw4GK3cKo4uJ8lAXGjJSRrEWu6Ry3g9AyTw26AZmC/tBvAWmaMaBl0TCt7w4JvZd4N4V0opyWC1f7DiYNP78w89x6LgkabHmYg5DSK0jRhnYAc4UJXt7T94cc3gacjDMW/a9eMhRWzhPcbfxRV26DkrMG0Dnis9GexNYrDbXcJDteZWRZpAD3+5bzvAA8zNqvN48607JmTbsM1sPEys+RAifC4J1iW+hpJhay64EY9KoTQHnp2hwtoVDAM31uszXHPA7QgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmw54TW1kx+AsEmhv6bcWCPKfWWYcKiWI1YBBLi3w9w=;
 b=CNvGZbEUF9AJPlf9AVEXxL7Y4uQpdgF18OQmYI8WFWynuZoOxF3FAc74AKMNYKFfoJNe7n6qY2K3UEnjwV3rDsOcYMaHrlKn5o94/ck0cIoXu5++MspYvCC2SngVhmAg9l4QRVFrRs3ito+24AsykJusvzeAGrrbs5Ntqb22PhQiVtmfTAHFMQkvPzf/ecmcnOpoeOGLMzGqPiTseKafWLqGyLSFSKys4EinMI+ct08R53KciaCFjqe41ZY3cUtDAYyUwL4K9t2ovq9gxwGFDITRiIO2iNLkruM9NAJeIh4MWYpd+92I0V5iDqrhFfQ1IOg/eOeQNAjdwRtuXOs0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL1PR11MB5555.namprd11.prod.outlook.com (2603:10b6:208:317::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 15:02:01 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 15:02:00 +0000
Date: Thu, 16 Nov 2023 16:01:53 +0100
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
Subject: Re: [PATCH bpf-next v7 08/18] ice: Support XDP hints in AF_XDP ZC
 mode
Message-ID: <ZVYu4eR+HmHBA76V@boxer>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-9-larysa.zaremba@intel.com>
 <ZVYP4M30jzb16RJl@boxer>
 <ZVWF7a1Z1s9HgTsF@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZVWF7a1Z1s9HgTsF@lzaremba-mobl.ger.corp.intel.com>
X-ClientProxiedBy: DB7PR05CA0023.eurprd05.prod.outlook.com
 (2603:10a6:10:36::36) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL1PR11MB5555:EE_
X-MS-Office365-Filtering-Correlation-Id: ae32f6e0-94b1-40f8-4132-08dbe6b4fc41
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PE1eBiCfBDWopfrLf/XJIUm0cz3IPGBSd171TqL3iLD6SiX4iiVuS5QDQ7oQyiIvEAmTQNGrv0tpW1cTLHH/oNEffyDIK0yj0qTLe0HlluMiFOSlVJkVkmAGAOzdITtMql7ZUZyipULqFJ5zEnuAaezimLF7bpg+l8/nFFDU77JtjdsxOgp+Ad0mfvMEJBekWngBSrHmZaL832P21+P5w7PN7nP81AthLnfKQpg2652kIkQxp/zKdRtqnfeQJqocOQ+iIdJwvdGL98aLT9iMnvkWeWpkKQknuJLhcpdf2FDfMxf5dKL98FXuNyaTEkaQWrYLivDzJePbywb0i5VGdd3Jz76NopFtFl0+caor5saTGIcIDiNTLeCcpR/uf7b4On4j1DnKDb9De6S4HiIwpn/vz42G6C1TNwNxTA1cEA2Slmx+n9UBpeJ8dRsGUSsSytfOdp8G5qOr4gAdOsY8zUGdXsqU3nWGmq+yLDuSriAh86sP5xyeq495U2PH2pk0sA3fjhaROL1NqH1t1dhW5N6Q/YQSNaD/Ef/9846fRxrilwBVx2HaVYEoMIP6gf+lYqVZlOGLD5vpP/76C4zhZSQk0teAj5I6rENIuoCs0Po=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66946007)(66476007)(41300700001)(54906003)(316002)(66556008)(6636002)(86362001)(5660300002)(2906002)(4326008)(6862004)(8936002)(7416002)(44832011)(8676002)(82960400001)(83380400001)(38100700002)(6666004)(6486002)(478600001)(33716001)(9686003)(26005)(6506007)(6512007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h5tulCtlSiw2TOZSUqQWap+58ddm4feBrY+hiPqsWWIzQYuRBL14gML9jT5N?=
 =?us-ascii?Q?whGR1RRcSQUln3eN2D+amhLfuclamLQrcqZP5mn8qxScSj1OxNcHFrsbdUgA?=
 =?us-ascii?Q?yNG7mhXwh3/jpU1LXNJhtjXXFpXE9VWTDeuox1Bvkt0XyiM25SQgjDgK5Ji/?=
 =?us-ascii?Q?+9d7l9jQa/S5+RUF93saBY1Xz9CvPtioKJpZHX5Ahfd40HLGQENtXsXm+tVY?=
 =?us-ascii?Q?E8D5Et+1C1SrHg2vuVvR3TwwKbdlEoK5IRfrO2TA3NXbLZdkGNheu9E5nfgx?=
 =?us-ascii?Q?p2QjNbnNPsHmQmHfTpwAa78/f7l+DvSH/qDXSS/yjpkL8HD4OOTGugkHRRjr?=
 =?us-ascii?Q?hyiyrrYGVkrN/Yg8copHvoKI5hi0EShHjqomQ0FMUMkGABmcnUP7yna6Mbg5?=
 =?us-ascii?Q?txPC/m0O6e5adyBOkvPm4qRGlGByvxaGrjxumWkRqCALTVNvTzZW8X6AmHh+?=
 =?us-ascii?Q?5F4uOLbkdkpd8N3i3sv+utFagZfhP9UTIhaxx4tBvxtJKEMsP4TUCxqN6D0+?=
 =?us-ascii?Q?7hxfSl2ZKiEgl0q38Cryd3GNnHKkGDr/MPkpGmsiWiebfwX2RX95nbIgHrvi?=
 =?us-ascii?Q?YDLwt5C94A7mG9JhPr8Ck0qdS9EawLvGIKXdnNL7TOQ/bjTVxN6It4BsdCXj?=
 =?us-ascii?Q?9MMC0RIXNlr29yrCZzJ5DcO0HAAyIzo2r5bWyl5TC104l3cfVpwTdJUlAOro?=
 =?us-ascii?Q?TH8/Sz6MOicTggBAGWyTb26I7a65aYeifHOa6G7tFGbSY8gdZG7vyEKApvpJ?=
 =?us-ascii?Q?ByakVTxqaABcZ60C2qb6Pcx66zeZ1h9Cy8yQFTtdAOEqk0bhrCoqNJXKYWv0?=
 =?us-ascii?Q?su8AfYPLrcmj3LQge3TQHz686vV1VW3z45WRgBpfr5tdcnL/NSaRA9Q5mQh7?=
 =?us-ascii?Q?s3FTK53xm//Y2hi/1gHKmyM98/LjnDHIEfvSnBdqrfKfM/MVr4/Oo84r3NHE?=
 =?us-ascii?Q?iJxS1BV30pMimKkfa+BhXXyFARJbpLtMyz9vYuL+jcerFDYtttSkPfeS3E//?=
 =?us-ascii?Q?M/M9m3IQmsea7ZfG8gNcWvllH9/2MES4UMsIrX80uad4rmX4BPlgBWE0C2wp?=
 =?us-ascii?Q?jd1GgtqjBTevuIp/Ye2CSvPCgajI8164cLeft1drZRoi1402j2cd1hBLtLPA?=
 =?us-ascii?Q?WWbjMSFPFu3c3fHUHFDBn5eJobhxYStW/CGW3HTToYJsgcD20KBRhCzYH2f+?=
 =?us-ascii?Q?AWDT1qKS5NmjD8IVl1cffic+dClIgZQ/jv6gZ71JnmL94ROEbNd9/wAyJshq?=
 =?us-ascii?Q?dKN7Ds+S+Do7kbevV9ZqDDqzqN3M03v/TcjWjO1i69l6kbn4052qpaPD1NOT?=
 =?us-ascii?Q?mbBtHKgp0YPupAHfKyrwe+9Xkcr4FHsWvjwFbffhEcYArPWWZxYhFrAG+/v/?=
 =?us-ascii?Q?1rc4BPvvQRSeqGIaQRF1q1ybzCiNSW2yZpN66Eot/r/vV3D0B2gHYCWDGM8J?=
 =?us-ascii?Q?C+OIay/D0wmtgke+CvGfCpnwHZrMVWZE17vAPRuGJDiYkvyzvC57P8Bw2SY3?=
 =?us-ascii?Q?0oZIhCmJrIpWabV4CeRpM+z5mjUQZixTHsSRjpVUndMxE8PlmHwWlOZwpx3M?=
 =?us-ascii?Q?Lxtj03NU9VnLgTQMLJvorjnsgt6gMu6tK1NFqDFziXQMaYodmjXvIcNregju?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae32f6e0-94b1-40f8-4132-08dbe6b4fc41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 15:02:00.5275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTttZVxmf26vafh1VDPlhS8l02cc8rm8+xnsolVNRhrMpAtePRl5KMQgZVl7r0RtbOo2tvNVfLFRxp/tik/2uz8pGnbsCifIW/VUE8IKkhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5555
X-OriginatorOrg: intel.com

On Thu, Nov 16, 2023 at 04:01:01AM +0100, Larysa Zaremba wrote:
> On Thu, Nov 16, 2023 at 01:49:36PM +0100, Maciej Fijalkowski wrote:
> > On Wed, Nov 15, 2023 at 06:52:50PM +0100, Larysa Zaremba wrote:
> > > In AF_XDP ZC, xdp_buff is not stored on ring,
> > > instead it is provided by xsk_buff_pool.
> > > Space for metadata sources right after such buffers was already reserved
> > > in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
> > > 
> > > Some things (such as pointer to packet context) do not change on a
> > > per-packet basis, so they can be set at the same time as RX queue info.
> > > On the other hand, RX descriptor is unique for each packet, but is already
> > > known when setting DMA addresses. This minimizes performance impact of
> > > hints on regular packet processing.
> > > 
> > > Update AF_XDP ZC packet processing to support XDP hints.
> > > 
> > > Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_base.c | 13 +++++++++++++
> > >  drivers/net/ethernet/intel/ice/ice_xsk.c  | 17 +++++++++++------
> > >  2 files changed, 24 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> > > index 2d83f3c029e7..d3396c1c87a9 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_base.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> > > @@ -519,6 +519,18 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
> > >  	return 0;
> > >  }
> > >  
> > > +static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
> > > +{
> > > +	void *ctx_ptr = &ring->pkt_ctx;
> > > +	struct xsk_cb_desc desc = {};
> > > +
> > > +	desc.src = &ctx_ptr;
> > > +	desc.off = offsetof(struct ice_xdp_buff, pkt_ctx) -
> > > +		   sizeof(struct xdp_buff);
> > 
> > Took me a while to figure out this offset calculation:D
> >
> 
> Do you have a suggestion, how to make it easier to understand?
>  

Not really, thought about moving the xdp_buff size subtraction to
xp_fill_cb but that would limit its usage. Let us keep it this way, I was
just probably being slow.

