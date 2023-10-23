Return-Path: <bpf+bounces-12989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CCA7D2E97
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 11:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDEDB20CB5
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 09:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410AA13AC7;
	Mon, 23 Oct 2023 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/Oc8r8t"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13055134C4;
	Mon, 23 Oct 2023 09:37:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEF5B7;
	Mon, 23 Oct 2023 02:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698053864; x=1729589864;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CWhauBbA/jDEhBg/DDB/YacUFzRwkEhEHsjUTs34e2c=;
  b=G/Oc8r8ts6ZMip8EFdz4SDawFvVH0GpHSZIwTuFo6O8yEuQ05oxFpETz
   cUy+QwizT4w2kU3XWQlnKqkdwXj/qTITPKhL/rMJThhaL9LsjlJWDAgdv
   qM3kZ6rx1MWc0zwJy2N0t2VknxKyn+PJksF+mrvTYz2dHa6qpHT/uG5sU
   YHkURSlL0kayx7mYZb5L032JvgIbYeGGLZxS4gQaMlKT4/C013r4R7eI7
   /xOwuVNxAn0jwJvUWMKqzTi2/1WRlTbsCK75xwRZMP83aqmryi0D1p4P4
   Q7vpmSIrdcvOOMmk9UdC5StNdmS+7maTd8a2ZqzI9cHKYsfYAYXUtHH/S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="5426492"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5426492"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 02:37:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="787417809"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="787417809"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 02:37:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 02:37:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 02:37:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 02:37:42 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 02:37:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZvkEu8CCl45cu2Eb11MYceW/SmrLouK3G6iykhvukNO8skgZW5UE4Ruft9lCowM0yvmfu/tHdtiPOINeD2TfZnPdpK7mmzZKfw37ACRl+9D7GSn0KIFfhGdBHqqWEJvDtVPiTNv7MhYOCvp7CB6+SJ1REKK/hsFGJZGQD6YPEO9P10VvJpVHL46BCRBNBLJ+0r0EJ+naF3Kb1HT6BjUtpUTlzp2954oQu/QwcSh1fqVGjzwkINzmWKjS2j/n0hVlXfQI7xlJRtNsd5HYwDaW6edpwZKCBOPVNIh6H/RkFv92td+B4cEuOmrNT0Vjv/puelJ0uCr1p47wraFxTYVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFqEzO5+5vN8e7q/wYXmJ0OWfj5WiewBG1tfoD4NjQk=;
 b=cNxCtcgljxF1JOPRRHZZVpOtOy7Pxudd1uXVR8qvIlzmYy/PHGAni2TDNIe+aIC/ZxBsJNxBgzsdLmtlKw7VNCDbfwhGVqwEtBWrTU3Vcgoeo7iso3dOPLo2Spk81NxDTHdvEGrWLEw0qrjjmULj+dIdjWGKaOgTbbRsrybSVilBn9EBq2d3zmHEiQvp5exa7BPTc7HfkDtx50ATSBXg3nlUB5WyzWuejQaULHIWEHgqVa1sOiHez+koP4dyhVtv+anYn6WpnVwfORIacgltLGs9YT+H4PK+A59tN3PYkndFL6QVgR/GAOXQIlkxyhitF/go89oH9k8yAZkYtNkoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CYYPR11MB8330.namprd11.prod.outlook.com (2603:10b6:930:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 09:37:38 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 09:37:38 +0000
Date: Mon, 23 Oct 2023 11:37:29 +0200
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
Subject: Re: [PATCH bpf-next v6 07/18] ice: Support XDP hints in AF_XDP ZC
 mode
Message-ID: <ZTY+2T8mjQ637msq@lzaremba-mobl.ger.corp.intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-8-larysa.zaremba@intel.com>
 <ZTKc4sKVuhd2LsBv@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZTKc4sKVuhd2LsBv@boxer>
X-ClientProxiedBy: WA2P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CYYPR11MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 66475834-6f87-47c3-ea33-08dbd3abb220
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2YC1WnWhpdW9V9YWDSsvD+c+7Bva/qdBmnwAWLZFC5nZyCnoLYiJX2O6nm48LoYehii8nEh8g+vfgJcXuJ8GrBPgIczigEGGvMs7fgKzJ0NJrm7ENep6YXJMhCoX+JyPZ6Btwb/Gicywjjd0E6fnxbC7MEejqGR2NTn/aTGZEtIBvd0xGF/1k7mooXB18bElClba5P+s30/aUWvdBu/WKZhYmmsICk+c+dfv2BIVIL2AMbmWvMRlT/av+egFtTgUzH8rKwHQTFxRVNNvEqkDDQiTyNaNpVDhqFGcx5oeOLboO4AA3NQzVtliGFMjsaUHAodGqmZWNqfe1zrfNa764UjdavujPGpv1VwMAYOY1fvTWtucKvCVMBZH5zfWDNf+GrT4/1SFGy0YEcvq+t7EpmRL+uyBgJUQ8wj4A8BTdZpWMwOClxNLcoAflVX0P8P00w6zcTJ7JCdCF0ChOQYM99FiGiMMk3BrunGN2LTKKMMtyz8n/IVUJIaz6FaSoixw/UNuklbL2KjlD8WmbBFVq5h/w9csirCBx7cxAEk0mk4kx/tA/7Y8SziN6PrgNu5cvgFeRssYLF8tJesiQxThfqN9rpqIPTaHPBqGob4hx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(38100700002)(6636002)(316002)(66946007)(66556008)(82960400001)(6666004)(54906003)(66476007)(478600001)(6506007)(6486002)(6512007)(83380400001)(44832011)(41300700001)(7416002)(86362001)(5660300002)(4326008)(6862004)(8936002)(8676002)(26005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HGUWkSXMrLZwA+HUfHn999V7X+BV5Di/c8iswPumov0hnmsv5Lxg2Irgj7tH?=
 =?us-ascii?Q?SpTLEzLhKQOLoTYMHSodDWmDBevwJ/+1g7WJGYzzSj0LxRrBhQU+iQ2JgkVs?=
 =?us-ascii?Q?7w8LdfjV6UuexOTO9gENwDJuIz1Y6JD/tz4pMjnJE1JbozF9mrf733emVviJ?=
 =?us-ascii?Q?9aPux20ZLj36WLdIldQSA/3FibI4mc6WgbFS/WSgo45EnEK0rX/ybDV7Cz8T?=
 =?us-ascii?Q?BRUxPPd/OLbNU+ePKb69CLbN+a8CuflvtFpLVefm6iVA4XirCE3Y0XpFllC7?=
 =?us-ascii?Q?zkf9ZiHZwD/fi4h8BRP8dOFVp1Nd0cwnRFmRMMGA3wm+nx79TlRYtDCWJdm9?=
 =?us-ascii?Q?OCDdrhPR2WKAjVA77+6N1qlg56t+epzSiMJ6IaZKwSrzrYult5cnoMYgCuuE?=
 =?us-ascii?Q?GylIYMXgSduqDzeKBcgUy1pglyBoVTNEWAN77mDyEISce8QFlzU2BKRDhL6A?=
 =?us-ascii?Q?392yi/ZmZExynT2ZOwN0EANSb9FFnt3SLLnA7GOrKmLV1e63gIOBKLgqsx+H?=
 =?us-ascii?Q?QMZ07NO0LiBf4h9FlhitNPiObYm95C5mQUkzkrAx33R1pa9MHc9AB9FWeV5i?=
 =?us-ascii?Q?WqpmxJwj4NNGKQsYd3S8AWIAWXQdDJ+a26A2/oSFqQP7Ct5QiU8+4VXD1vsj?=
 =?us-ascii?Q?vI40Y4wM8yjXAz0wztUbUHIGSI2TrcOCmhyN5btDNg9bQazi6+RUk4a3vjT5?=
 =?us-ascii?Q?A5L/rZrY96M67I0+/5k21sJT2QIyymBzOK4hlaGM3mTNfROC9/wzqkQO1kwX?=
 =?us-ascii?Q?25r/ueYwZjsoMnr++4vWJmsR5Z4sgKXEZnKgM69CNn+L86nNvVyplNITifrf?=
 =?us-ascii?Q?GPW1O0BasLDgYlW8/xKKPvbfuzajyDMtghw43g8a1sKLKVqtjxcmF37xMe9p?=
 =?us-ascii?Q?eLRKZEE/i8dQlhv36tdhP/RJZfg0kUWDUY32BP9Lf6ykAnCkfQSHGo/gC/R4?=
 =?us-ascii?Q?12MAxtjdRvzqJ9L6yd12Z171xFUtFkkL9FI080gEzznWEOTJnDdf/pz7SJ5b?=
 =?us-ascii?Q?poTL3Lh4irJSPVJ+9vqSNsvdtoUeBeP0HkevKFC1hVNAxCtNEp6YoNFLwW5e?=
 =?us-ascii?Q?2SVcPvRfTCT13vVUubTnSKSoDZXQBc3neakr3v3hzmdg7098T6gpBNT2jZfo?=
 =?us-ascii?Q?x3YZ8AoPu/6Hni4n8+fWSeLlOCVIrCK6t9DH2l82mQq/AU4SCOSZlhQGy0Ql?=
 =?us-ascii?Q?e0XTBeWTy/nEsi1SiEBvjlriuHmXAFm1cgkDT/1o7onGhJGLwJkQsn/11pQQ?=
 =?us-ascii?Q?yTxfwAYYuBOhbZgYVaVjMPf5G/ih36lH+qJpQ6YD2mw7FRMch6/M1o0tIYP4?=
 =?us-ascii?Q?IbHjPt6z1YyU4Skd/Sgs96QWT2S3jCC224Ahz45xTcW/3P1uXtfxOBmiC87Z?=
 =?us-ascii?Q?ikA47RXJYnqW/5w1j2GFQmxvpWlCPhm8TH6HkjxHAZc0le/Ye0sexQZ6xfuR?=
 =?us-ascii?Q?7TPmeUw3Og7jeyNuOYrfYhP2fPRp9pQuFaBDphK1shRoNcHzyKXS7/OmNMdF?=
 =?us-ascii?Q?9eRbTnEJgaj4vDgEiR7m1ek0P9q0h7oCuCuRtpiDAGgZtXA+6vUujiXuOAob?=
 =?us-ascii?Q?odnW09zOLz8yM9h/dFIjNEPhXXEzTPb/TT4eDDgelPnC91Kj65Pe4R50bOby?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66475834-6f87-47c3-ea33-08dbd3abb220
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:37:38.5632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVBRFqL4Sx71GUNg35ACj9e+Vr/bzLfCbjkQcXTkciRUPhc9uXHQu1VRpYne7r0Ugd4n+L8KE/r2pbyutapWjkjrRh3rg3sOzU0a/JSiy28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8330
X-OriginatorOrg: intel.com

On Fri, Oct 20, 2023 at 05:29:38PM +0200, Maciej Fijalkowski wrote:
> On Thu, Oct 12, 2023 at 07:05:13PM +0200, Larysa Zaremba wrote:
> > In AF_XDP ZC, xdp_buff is not stored on ring,
> > instead it is provided by xsk_buff_pool.
> > Space for metadata sources right after such buffers was already reserved
> > in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
> > This makes the implementation rather straightforward.
> > 
> > Update AF_XDP ZC packet processing to support XDP hints.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_xsk.c | 34 ++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index ef778b8e6d1b..6ca620b2fbdd 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -752,22 +752,51 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
> >  	return ICE_XDP_CONSUMED;
> >  }
> >  
> > +/**
> > + * ice_prepare_pkt_ctx_zc - Prepare packet context for XDP hints
> > + * @xdp: xdp_buff used as input to the XDP program
> > + * @eop_desc: End of packet descriptor
> > + * @rx_ring: Rx ring with packet context
> > + *
> > + * In regular XDP, xdp_buff is placed inside the ring structure,
> > + * just before the packet context, so the latter can be accessed
> > + * with xdp_buff address only at all times, but in ZC mode,
> 
> s/only// ?
>

Yes :D
 
> > + * xdp_buffs come from the pool, so we need to reinitialize
> > + * context for every packet.
> > + *
> > + * We can safely convert xdp_buff_xsk to ice_xdp_buff,
> > + * because there are XSK_PRIV_MAX bytes reserved in xdp_buff_xsk
> > + * right after xdp_buff, for our private use.
> > + * XSK_CHECK_PRIV_TYPE() ensures we do not go above the limit.
> > + */
> > +static void ice_prepare_pkt_ctx_zc(struct xdp_buff *xdp,
> > +				   union ice_32b_rx_flex_desc *eop_desc,
> > +				   struct ice_rx_ring *rx_ring)
> > +{
> > +	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
> > +	((struct ice_xdp_buff *)xdp)->pkt_ctx = rx_ring->pkt_ctx;
> > +	ice_xdp_meta_set_desc(xdp, eop_desc);
> > +}
> > +
> >  /**
> >   * ice_run_xdp_zc - Executes an XDP program in zero-copy path
> >   * @rx_ring: Rx ring
> >   * @xdp: xdp_buff used as input to the XDP program
> >   * @xdp_prog: XDP program to run
> >   * @xdp_ring: ring to be used for XDP_TX action
> > + * @rx_desc: packet descriptor
> >   *
> >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> >   */
> >  static int
> >  ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > -	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring)
> > +	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > +	       union ice_32b_rx_flex_desc *rx_desc)
> >  {
> >  	int err, result = ICE_XDP_PASS;
> >  	u32 act;
> >  
> > +	ice_prepare_pkt_ctx_zc(xdp, rx_desc, rx_ring);
> >  	act = bpf_prog_run_xdp(xdp_prog, xdp);
> >  
> >  	if (likely(act == XDP_REDIRECT)) {
> > @@ -907,7 +936,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
> >  		if (ice_is_non_eop(rx_ring, rx_desc))
> >  			continue;
> >  
> > -		xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring);
> > +		xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring,
> > +					 rx_desc);
> >  		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
> >  			xdp_xmit |= xdp_res;
> >  		} else if (xdp_res == ICE_XDP_EXIT) {
> > -- 
> > 2.41.0
> > 

