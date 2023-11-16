Return-Path: <bpf+bounces-15172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433687EE1C4
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 14:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651C91C20A3B
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 13:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9FD30FAC;
	Thu, 16 Nov 2023 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FeP5gqo4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434FAD5E;
	Thu, 16 Nov 2023 05:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700142324; x=1731678324;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UYAMSQ29yGaiDc2IUsFPKQp/A2TVZ0YOvG94KSS4AUI=;
  b=FeP5gqo4FFikMuY0hB7lv0b9IekmW3XPWqozjNxncUyW5vk4DzlL2RZr
   +1gXTEoMzADgQBPX3PzE2lPNIS8NOXHtxnmfj5CkDc+eCyPSlujO/lGNf
   UaLrvj9ywNMNCZ+Z6lN0XtUtiiiszKRFaWfiDVsWu4Op/VeqdBbRexemH
   NjcEksV7+voaOkmXViKieWsrABxAixpM637jcBZFHZGR6+EcLbOu8Cqhp
   QlldNQBp+hi7mctbUDUNJA8lm/K5uZ6Uy4U4ULWMZ0zY+lHLTnIqGpChX
   rtwNjARtn86n15n5eQ3YoF85NhlPKNXRczDbr3QxvL9wPg+PuMfJf90xz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393940504"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="393940504"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 05:45:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="741769532"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="741769532"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 05:45:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 05:45:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 05:45:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 05:45:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3yOtwSusrRNdgsY3qkNm9Nnt6cQ83eKsZxPNFbwCuoLEBqwWZmoGS3sCFLUuPYjj0EsWAPcfMFLpwa4qE0C/RRs0pANvHV+LXF+CYJBvKr8rx3dWYnCp9aSNU3pLdqrpVgYfiKyuRvzFhUx5rpmWEblLQCxxEj+THCso/QH6jojrARNrAcAlI4Cj8kIkyzsLbZJb6/3KcD17TyBa5XFc+FzcAtQfVUXmJ+DP/pZcJqs/E9I13nezwL4Fvb0dnBhPgPggYDwZUElhMyAVWPJ/oEB5zQVN1cDbXyr7sMksUpT4Xx+MyocCoVvlnxkaQYoOJBLH6UoSmB+ZewsqYuXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxErEKQzFjEIay8RZHH6FecR335kpOd7F83e5Tkawjw=;
 b=BsuiojKcJhsRUPi5TWxf0uOfzcs3Gj5Yyo4naPRKoeDRULG4F1k/Cah1kKTbd6iy4fow8sXgpXVknsVtnsxdQ2LZcrFLXH+Fs1Nk6ULJg1Ex6++MDNy3NyhV7Oo9Py28g9ic7GPPBrgn7Og5Kv3QqnYtycX+d/Pip+PGtIj10fYmUwJqt+XUWYx4zaVUcPG7fua7qyYdKjhfIHBuDr00GhATh+xmjjAsoIZipg9cXrKTsuAUTEWy3syLG65D8UyaNgRRT+TQvnPJLQrhIR1LEsh/bA0cFmkytt+Tm6DtKOL1rKVSZ8r52OkCAbKOcGuEoLw8E4pgyRxBT8TIRnKIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CH3PR11MB7915.namprd11.prod.outlook.com (2603:10b6:610:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 13:45:18 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%7]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 13:45:18 +0000
Date: Thu, 16 Nov 2023 04:01:01 +0100
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
	<alexei.starovoitov@gmail.com>, Tariq Toukan <tariqt@mellanox.com>, "Saeed
 Mahameed" <saeedm@mellanox.com>
Subject: Re: [PATCH bpf-next v7 08/18] ice: Support XDP hints in AF_XDP ZC
 mode
Message-ID: <ZVWF7a1Z1s9HgTsF@lzaremba-mobl.ger.corp.intel.com>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-9-larysa.zaremba@intel.com>
 <ZVYP4M30jzb16RJl@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZVYP4M30jzb16RJl@boxer>
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CH3PR11MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: cc70463d-2f79-47de-3921-08dbe6aa450e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9irmBSB47EjPy6QnVNhUH57NS6aM9Cb/euPJlTj/YI2AHI5Wo/i/ec3GKa0/g0py3nsNrYzGuXBKQjFQezXXiVbS4pBoSmoNe0hzzP116s/MCg8tkSr7CjK14hbjjg5kTc8tiMIR/v2lr97RZzh2gBjy3WP7RxiiDwx6XJ1tBtaaViwiMfVlh8zQ1fC6A6ta7velfssKVjZuT5pQfn1d+Rk2GGCgqAeCiLWkLRxF0HR11OdBYKoAylMJvuSne7RZEwkSVT98TvVlVeatfEGg20LLUxmfiZXDcNIETCkZz3T1042heonMCog7149J2X9qUu311F9XWRXfY9fLi+9R8cieyu7j3llRdkInvqeH2CxF03PT7fOUX7Yes0k/6MyW32PI0wkJAW3737gRMOBrmyj83X1//LsH4YrwBgg3ykYKSadcC7fPx4ZsJDq3qn1kHe9g1AOAZy+hIrG+MzV2Ly6yX669NcgEqv62VSRmN88/bqIt+6BoqjeRR/VtDDeS6HbHj5bTrl0rFo1DlsKNflKCAFa2NDxpYGQO5Ce4qbOG1SbgrtxKiYj+ty581qlp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(5660300002)(7416002)(86362001)(44832011)(6512007)(6486002)(66476007)(4326008)(6636002)(316002)(8936002)(66946007)(8676002)(66556008)(6862004)(54906003)(41300700001)(2906002)(38100700002)(83380400001)(26005)(82960400001)(6666004)(6506007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8G47TDTYyNUTiIper9CFzZ8ZNNqp6/6XxtWSuYQtaizQ7A6muQFijLLdcde?=
 =?us-ascii?Q?XnmOLUn6zbkbM8KZ32o5gnpKs22ryGkV3CDnAhqiuipNOPbEbq7m7cILcaT0?=
 =?us-ascii?Q?ZcB1+ZO3p6SlgONLKIFbW7gAuNPo1vWmyja2ZX9WtriVho1py4eUBN3+wbJb?=
 =?us-ascii?Q?pjUko7tHjOMXrDax+AUtXZ8JurDqjt8pdDA0ola8TzAGgsBWpbMlFkwZz4JZ?=
 =?us-ascii?Q?ws2Nkszqi0xY5tdSDjD/mCfGIwBO0iV/E83okVZYnzST6atMLP4Fisnnt2Qo?=
 =?us-ascii?Q?5CKper+82T1L9bPKaXMtRCIbKPtbk4kN2w7LqFGsZlsGJbdZtDCMEJG3QFpS?=
 =?us-ascii?Q?bwiLi1CtC0hdh93+KVjEHIHPDPzNW7lA5YnIAx9CYMJRbLnCrk7/6A7Vjnq7?=
 =?us-ascii?Q?S/UxW3V3XOFmixzE2eNwaiMgOdaYXp+8t8odJ3ucHsIhY1Es2r6Hlp1DSiPe?=
 =?us-ascii?Q?aCxnf8wRaOuwkJDFQxs3lpHsFLq9ayTWIjwOcvLbTiAnblVVuwKLM5ziHaia?=
 =?us-ascii?Q?CdDSHIfxqfuXCXT2UqtsdOLL7JIOcNAJo7JwMOwG2CNil/cv0FyGgZiJnFnY?=
 =?us-ascii?Q?a+qItqh26BbH96yHN4yWigtpeCWe6PjYPEqCahhZrZ+HagpfXGoi3MwmUJJb?=
 =?us-ascii?Q?rkLO2/ISucW/yjB1PnkXzu3c40XaSXkfsDKRq8fNi9aHWsEzyCSJlIhZ2Jma?=
 =?us-ascii?Q?LTZZ6ekXHVS3xMC5pyLa4HGjJ14n6ehIO5k1IirAVRQYAxCEjVwDiTUcIoib?=
 =?us-ascii?Q?hcYldWax/2IQdF9ddrGmaGcWsxzThfeAb/ykZxL5q+I7Ozk5DoCotsW2tDuW?=
 =?us-ascii?Q?yGsRcueeezGyOXUTCcCHR/y/HqX9a20JHC/rebwD7tFr4as1dpMRr80TGbfy?=
 =?us-ascii?Q?0vpGFbsYwt/EVNObwSDjd7eiIy0N1fn9iyRsNGW9YHhc2W/EAqdEHLZ8J2DT?=
 =?us-ascii?Q?7ljxqeJDg5SNc/NZzPEyXzIc00f+Hwv8ghqcSVQonWNTAYde4S2rXjpecCuy?=
 =?us-ascii?Q?QH/pa13jhlxi1EkcuzkmKlGtK/mDVIoWbCR2/7WtPtEhDSG27stF+9jYk6O6?=
 =?us-ascii?Q?KjgQ2dD/VIIlXSGxdivTr8Yk5kEYIy+JHP5/QEPA3rs3QqFSshCI3RCwJBhp?=
 =?us-ascii?Q?Wn3+2UtCxjmwUJT+Wq0pTusvN6hvdsKUEvl6BXBEjlA7wEzy68HbDrSirj/J?=
 =?us-ascii?Q?BroQtYt3QcqOjlO8QamvO4M80zpM6+lToPBn19kwMqxzLoJ2uAeg4MPTdVRq?=
 =?us-ascii?Q?wJILX4hmmcrvv4LbiHl4X80GFBEiYfCPec98Gj2inAqdOPFuukuHfjdP0Z02?=
 =?us-ascii?Q?kaXCMd9fCG8tdBSVgXtMc7s/ou5+N7q0YLiRrfs7BbKkX95KMrkmKPazBMq+?=
 =?us-ascii?Q?LU1fq+f4rSdcfV4ULW1O3gNhLd7Q80/QyFfgIspwY8lm988tbSbLcw6YMSi/?=
 =?us-ascii?Q?8NHnKA1CLp4zehZagjH/3wvZBKiVVWCJx0hNSfWlveQM+JMj5/vedA53nQHj?=
 =?us-ascii?Q?KPJ/qiI7wqsIiC+PAgqmtE2jn2tE88jw6L8CZv95wXPlLRXzlYJHlT2rb6Cb?=
 =?us-ascii?Q?rKcKkh4uHn9o/s8SbnyalJhY1ygcC9Ivbcats7wfFKMsEwLGl3gtI2TYeuUX?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc70463d-2f79-47de-3921-08dbe6aa450e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:45:18.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpUfeNuut3llg7MFh1T+5NEwaLGhlDDuGY+eiM9dPPelTsg1yD9jg+V6VDJB63N0G1V54CFEK4TGzpMkCihlE0lAPuhjgVR3kdaIK8vJWuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7915
X-OriginatorOrg: intel.com

On Thu, Nov 16, 2023 at 01:49:36PM +0100, Maciej Fijalkowski wrote:
> On Wed, Nov 15, 2023 at 06:52:50PM +0100, Larysa Zaremba wrote:
> > In AF_XDP ZC, xdp_buff is not stored on ring,
> > instead it is provided by xsk_buff_pool.
> > Space for metadata sources right after such buffers was already reserved
> > in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
> > 
> > Some things (such as pointer to packet context) do not change on a
> > per-packet basis, so they can be set at the same time as RX queue info.
> > On the other hand, RX descriptor is unique for each packet, but is already
> > known when setting DMA addresses. This minimizes performance impact of
> > hints on regular packet processing.
> > 
> > Update AF_XDP ZC packet processing to support XDP hints.
> > 
> > Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_base.c | 13 +++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_xsk.c  | 17 +++++++++++------
> >  2 files changed, 24 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> > index 2d83f3c029e7..d3396c1c87a9 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_base.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> > @@ -519,6 +519,18 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
> >  	return 0;
> >  }
> >  
> > +static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
> > +{
> > +	void *ctx_ptr = &ring->pkt_ctx;
> > +	struct xsk_cb_desc desc = {};
> > +
> > +	desc.src = &ctx_ptr;
> > +	desc.off = offsetof(struct ice_xdp_buff, pkt_ctx) -
> > +		   sizeof(struct xdp_buff);
> 
> Took me a while to figure out this offset calculation:D
>

Do you have a suggestion, how to make it easier to understand?
 
> > +	desc.bytes = sizeof(ctx_ptr);
> > +	xsk_pool_fill_cb(ring->xsk_pool, &desc);
> > +}
> > +
> >  /**
> >   * ice_vsi_cfg_rxq - Configure an Rx queue
> >   * @ring: the ring being configured
> > @@ -553,6 +565,7 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
> >  			if (err)
> >  				return err;
> >  			xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
> 
> A good place for XSK_CHECK_PRIV_TYPE() ?

Seems so, have not noticed that it was missing :(

> 
> > +			ice_xsk_pool_fill_cb(ring);
> >  
> >  			dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
> >  				 ring->q_index);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index 906e383e864a..a690e34ea8ae 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -433,7 +433,7 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
> >  
> >  /**
> >   * ice_fill_rx_descs - pick buffers from XSK buffer pool and use it
> > - * @pool: XSK Buffer pool to pull the buffers from
> > + * @rx_ring: rx ring
> >   * @xdp: SW ring of xdp_buff that will hold the buffers
> >   * @rx_desc: Pointer to Rx descriptors that will be filled
> >   * @count: The number of buffers to allocate
> > @@ -445,19 +445,24 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
> >   *
> >   * Returns the amount of allocated Rx descriptors
> >   */
> > -static u16 ice_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
> > +static u16 ice_fill_rx_descs(struct ice_rx_ring *rx_ring, struct xdp_buff **xdp,
> 
> Might be lack of caffeine on my side, but I don't see a reason for passing
> rx_ring down to ice_fill_rx_descs() ?
> 
> I see I introduced this in the code example previously but it must have
> been some leftover from previous hacking...
> 
> Help!

It is lack of caffeine on both sides. I have missed the fact that indeed, we do 
not need rx_ring here.

> 
> >  			     union ice_32b_rx_flex_desc *rx_desc, u16 count)
> >  {
> >  	dma_addr_t dma;
> >  	u16 buffs;
> >  	int i;
> >  
> > -	buffs = xsk_buff_alloc_batch(pool, xdp, count);
> > +	buffs = xsk_buff_alloc_batch(rx_ring->xsk_pool, xdp, count);
> >  	for (i = 0; i < buffs; i++) {
> >  		dma = xsk_buff_xdp_get_dma(*xdp);
> >  		rx_desc->read.pkt_addr = cpu_to_le64(dma);
> >  		rx_desc->wb.status_error0 = 0;
> >  
> > +		/* Put private info that changes on a per-packet basis
> > +		 * into xdp_buff_xsk->cb.
> > +		 */
> > +		ice_xdp_meta_set_desc(*xdp, rx_desc);
> > +
> >  		rx_desc++;
> >  		xdp++;
> >  	}
> > @@ -488,8 +493,7 @@ static bool __ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring, u16 count)
> >  	xdp = ice_xdp_buf(rx_ring, ntu);
> >  
> >  	if (ntu + count >= rx_ring->count) {
> > -		nb_buffs_extra = ice_fill_rx_descs(rx_ring->xsk_pool, xdp,
> > -						   rx_desc,
> > +		nb_buffs_extra = ice_fill_rx_descs(rx_ring, xdp, rx_desc,
> >  						   rx_ring->count - ntu);
> >  		if (nb_buffs_extra != rx_ring->count - ntu) {
> >  			ntu += nb_buffs_extra;
> > @@ -502,7 +506,7 @@ static bool __ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring, u16 count)
> >  		ice_release_rx_desc(rx_ring, 0);
> >  	}
> >  
> > -	nb_buffs = ice_fill_rx_descs(rx_ring->xsk_pool, xdp, rx_desc, count);
> > +	nb_buffs = ice_fill_rx_descs(rx_ring, xdp, rx_desc, count);
> >  
> >  	ntu += nb_buffs;
> >  	if (ntu == rx_ring->count)
> > @@ -752,6 +756,7 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
> >   * @xdp: xdp_buff used as input to the XDP program
> >   * @xdp_prog: XDP program to run
> >   * @xdp_ring: ring to be used for XDP_TX action
> > + * @rx_desc: packet descriptor
> 
> leftover comment from previous approach
> 

Will fix.

> >   *
> >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> >   */
> > -- 
> > 2.41.0
> > 

