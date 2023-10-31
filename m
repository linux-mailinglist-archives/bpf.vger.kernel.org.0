Return-Path: <bpf+bounces-13730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9257DD4B7
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D82C2818A5
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245A1208C7;
	Tue, 31 Oct 2023 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMm3bi9k"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF9D2ED;
	Tue, 31 Oct 2023 17:32:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD98F;
	Tue, 31 Oct 2023 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698773552; x=1730309552;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IUjM9Z3sYEZB2iOCI0qBLUz5wn2h2sWqQ4rVBZe6/uA=;
  b=eMm3bi9kSIg8eKncJz+NVoklQPjfUYFS+rxN4SHsGeNab5Kd2/TbeQlA
   yAiI02+g8wkrzZ1zoJalSItaSKNn0DGJcaldrHMfHXVc1sN+/MfutwBmz
   TblL2dXlcHNQJMfZzYebWI00I49WMURqTzkAVRnh2Z7wCgVveqFhGQQ13
   gNM2TIqLk7lwa0GSUldA6Do5rcAdvpYYLSf5qe+mhfsVbUyVJ8WN0VJls
   sRy6LojrROka/UirPD3r5FrHLenS9sYUNEjSURGwA92k76HEJEyZV9MxL
   i+jHj3OzDI54zm37utiYGEy+GyRgh6udPvHGJyaFDW/NmlyUHMkGFiEQx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="388158550"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="388158550"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 10:32:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="884283374"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="884283374"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 10:32:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 10:32:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 10:32:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 10:32:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 10:32:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihOYzUk+Bk6W9HIAEwHUPQt+5U6vwQ/2o3j2AO+Kvb5SbM480dFv3DKaK1r94gBVvZZAWQ2bGY/VQvUTXxruJQUDnyegTzumRQw3I9U7avwWZzKtXPrYLhhXMhc55NHGyvYO0iQ2Ef5o2ZIsrgjfq62W5VzFyHGKBnPyNWX2F2flCckEWrBNfC/onZvj5FIEUHE/xXYOm872+IFv91jgXr3Dxok+crqQWNBvTQ2MLbRJWbXaZZjJbtrlA1Z4wVfXWtmLdJgacr2Ok03EFrQDruGXI57O/KVTy85Tuq5V13f5Em7JnOctfLAmHeUKLecnzmcwn0QNJRBBf+44LWWXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTl1XSDEKMYs//hfqvPOxq4oUaSAzqwSsD76hX+GI2E=;
 b=U/mnC7EobOz632ZBZj/PxzAn6i9NJbjdW5LhgRwFt3wuygHkuNpEr7Za+L5AxGCMY5Fw9GrjOmemZaQWWef04nRduTBlEKUud+MXmC85acgWommEhfhpZHaHuteOOGWTVaFSVfxZtBUnFHBY7s3yEfOONbiHNka38g3lfnwqRVVmoNShxMvJNPwr3sERN/qtbxge4L6qhg8jZA6suoOQR1HxPP5tf7Z8KWrVQ0TZTwQfw7odLdt08u7yx5FRRKWxKTGg9HJ+RN+y0LKS39QkXHHyqoaj+dckGpB5MpHjmXESqkQ5VpNn+ruLUhUOPG9KVzuyvW97qiCHVyvo1RbfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 17:32:26 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%6]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 17:32:26 +0000
Date: Tue, 31 Oct 2023 18:32:16 +0100
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
 Mahameed" <saeedm@mellanox.com>, <toke@kernel.org>
Subject: Re: [PATCH bpf-next v6 11/18] ice: put XDP meta sources assignment
 under a static key condition
Message-ID: <ZUE6ICvITYgtlLEC@lzaremba-mobl.ger.corp.intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-12-larysa.zaremba@intel.com>
 <ZTKrjU0a0Q1vF1UU@boxer>
 <ZTY+chHJEgggHu5J@lzaremba-mobl.ger.corp.intel.com>
 <ZT1nSGYng8sUKQD7@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZT1nSGYng8sUKQD7@boxer>
X-ClientProxiedBy: FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::11) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|LV2PR11MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: a4674a64-fd66-4de1-6a8c-08dbda3758df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Or9CBdAwRYlbngvrrVrKAOAKfNfRblAZ09rCvffB7RYBBhFrHw5/E1rn72eEge7WU/sib1AGKWY5eqmIi4Y9+/zq212m5Xu/PXh7Wm3VYY3Igz5z6BBe0teJMAlrLK2a0ds2KTYncPjnUMfXB3bUtrdQcXoQjjkzPfx4wP7S9ClXoclgmPB8Dtqksl6PViSeltMqgGsJf4qgK3RD5gLDAK/tNVPetfnMG+Xv7l5t2LSrpQevSiO41g5gw1jeDUgrDqvmEBPZiwN0aULZM6e7ymJXDeZtQCRqkZK+JJ9MR4+ZMEOu2oQhuTcx2g34e7BZrOGWIQ9tT/5bP4exrCL380Hw8ZU7sUULP6SLWZoMrNpmAb0Vb5MIfZoe3Fi4Ox2B8ZotnunD6Gn7KZ6ATr0DUedEtm43c/fjlf3s/rWYk1/EjfGr98bL3N0ny2k6imFwJDbzU0nD6zRU4BeXKuB2lAtile6r4nrUiF23AWPGQomHuqbtCZiYUnoD59MUGYngXf6/kKNKqTOyPB506DYkv4/Ep8v3PKAQIbngs5pWBK4GmTDJmM8VeT//Mt03dRA2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(7416002)(66899024)(26005)(6512007)(6666004)(38100700002)(86362001)(82960400001)(2906002)(83380400001)(6862004)(6506007)(478600001)(8676002)(66476007)(6486002)(6636002)(316002)(54906003)(4326008)(5660300002)(8936002)(41300700001)(66556008)(44832011)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iEq7mc/u6ZMxs7pXOnm3nqconHYnkYHFuI2KF8psChYzDab3dtt2zTRuDjNO?=
 =?us-ascii?Q?p4BobyFBgNQfNiDFJichQ3XYq4LLBCYoNFBgxN79yWwC3wmegpqDA70Mskh2?=
 =?us-ascii?Q?wjLzexwMtpYOaTxsaZGeCGi3HY8ES2wiqHqvQot+JaCK8WymAMVbGMHNoh8n?=
 =?us-ascii?Q?EqPa2k66DbhE0O9YFg9/LQkA45OJog8mbEB4lyQnOoZCaRSip+Yd05rUi3ZX?=
 =?us-ascii?Q?j8i7AqJbTe6i3ZVGfYEEzY9waZ4bdYlwySyVBT5yGJeEXPoRxQ+lgZON0AyM?=
 =?us-ascii?Q?A4jfOZQ+YqJi8W6SY2GMArDfeEGNEXcwQtTWHiGwkT1qSdP9LbfSgeeMZzGp?=
 =?us-ascii?Q?MHCLoAlbyzUGLC0BYZoHuPbemIezLPkxjgQif3trIf1OKtMTsPwfBvAkh8SY?=
 =?us-ascii?Q?8bOaj76BXCXzS5zgD88TOzkL5Wm4FDhMOOF9T3wwzbCUo92ku+iRXVIJXWBL?=
 =?us-ascii?Q?qlh2crG36HSBvlW98p5C5kKrzxunCLw4POVyGEpsGGQTMTUlu9PNtZ8jstCX?=
 =?us-ascii?Q?JxRx0rnU64HDFgp1JwRNFcj7CDhLG7GfxoG1B6QY9SWI/S7eFShcHr6ng3y7?=
 =?us-ascii?Q?071QHuEOqnTKFg+E3PfK/GCyiLQ1u9vCA4B6qTqAna5s21jeoRyWDBYp7hcg?=
 =?us-ascii?Q?3uQ2trO5jrMjdQAAKYcaHB1yz1NiRgffHuN0l1oDKn4ghv10CHWV/IOHJ24d?=
 =?us-ascii?Q?ugHEpag5D9KbRyLAv+mMti0quFNFImeXsVbYnr9ad+cvof3f+a/9ZZrw7amz?=
 =?us-ascii?Q?tvdJPOOxNiv/vacLN/6CS7H7NVxyhqW+vqYLl0NzPPLgVPSrhcRxNaOkBgoF?=
 =?us-ascii?Q?ojkNfZLB54W7BzJq0OPfmBgJeT822ZxtKpCwdpEcKEJi/LIFQW3S5cv9nrWP?=
 =?us-ascii?Q?O2Yc7+M5E5aGWGaFeTCEzFzXnUYXckuLy5QoMlbsy02PO4Guxl2P2q/sySia?=
 =?us-ascii?Q?7p/1nclIWhuy14+QBO0rm6XL0Qk1PfwMdAf2OWmuRlLoGN25PZjluhyYDvBf?=
 =?us-ascii?Q?8ret/YhOaS3j05kSD3ilwOCIPTleU0htHSZ6m1fOVaMOtphNbD67fAE2sLw8?=
 =?us-ascii?Q?YB8fItA/98hVqoz018pNhyfeq8sVYiif7siR5vSquGByxKO8Mq9TTxeuoXjT?=
 =?us-ascii?Q?fwzAZHYqfJ2m90CsAsLbB5voMvgxzVXsJSAvQycHKAXmrq5zheFjC30DCYsY?=
 =?us-ascii?Q?H+XE5ZCF8ULZgUhM1hw7tdiKaBD+NNHQEMeWPROfQZ4LpnVPqL50vVeO+eTX?=
 =?us-ascii?Q?wNvuJfNkyhiaW/RMhb8PAKvq50nCqBlWEJBkakoEC2LsCL5zvo0SbaURxEuV?=
 =?us-ascii?Q?7MMPMj3yyLYLoAQ2QXe6NO345nyQ8xFDw5hn4SDrQchunuzQTT7wE/TLotF+?=
 =?us-ascii?Q?bmeAKNe17R3c7amQETBwXTb+vIg2Z97IPYnUZeL0f8O2YPtw+bgKogYEnDCR?=
 =?us-ascii?Q?IwiyM2MXUyssUoRZcT9Bival315zpgVwFCFjZ93lZuv4FaVv5vPBXhcYHi9g?=
 =?us-ascii?Q?n6DBrSq5zKbn0xzx45Jeb0HOBM5k90sG9EpGtGFuNJAN24RywPNsg2lOxOv7?=
 =?us-ascii?Q?HGivPykHn58cN5LuE2/lG9ky6x3/hvoORDc3cJkQ3JVRWOLOULLjBvO4xb8n?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4674a64-fd66-4de1-6a8c-08dbda3758df
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 17:32:25.9875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLcOw79hzhV3kdUKOAYQYvYm90W6rqe1dY+Iug5J9VzNmE1wR4nwMx8pBBpPEOh7s1eNzKtc+l0ltHn7WiztFWDasI7tjcsFtpQU+ZNzR10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6070
X-OriginatorOrg: intel.com

On Sat, Oct 28, 2023 at 09:55:52PM +0200, Maciej Fijalkowski wrote:
> On Mon, Oct 23, 2023 at 11:35:46AM +0200, Larysa Zaremba wrote:
> > On Fri, Oct 20, 2023 at 06:32:13PM +0200, Maciej Fijalkowski wrote:
> > > On Thu, Oct 12, 2023 at 07:05:17PM +0200, Larysa Zaremba wrote:
> > > > Usage of XDP hints requires putting additional information after the
> > > > xdp_buff. In basic case, only the descriptor has to be copied on a
> > > > per-packet basis, because xdp_buff permanently resides before per-ring
> > > > metadata (cached time and VLAN protocol ID).
> > > > 
> > > > However, in ZC mode, xdp_buffs come from a pool, so memory after such
> > > > buffer does not contain any reliable information, so everything has to be
> > > > copied, damaging the performance.
> > > > 
> > > > Introduce a static key to enable meta sources assignment only when attached
> > > > XDP program is device-bound.
> > > > 
> > > > This patch eliminates a 6% performance drop in ZC mode, which was a result
> > > > of addition of XDP hints to the driver.
> > > > 
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > ---
> > > >  drivers/net/ethernet/intel/ice/ice.h      |  1 +
> > > >  drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++++++++
> > > >  drivers/net/ethernet/intel/ice/ice_txrx.c |  3 ++-
> > > >  drivers/net/ethernet/intel/ice/ice_xsk.c  |  3 +++
> > > >  4 files changed, 20 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> > > > index 3d0f15f8b2b8..76d22be878a4 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice.h
> > > > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > > > @@ -210,6 +210,7 @@ enum ice_feature {
> > > >  };
> > > >  
> > > >  DECLARE_STATIC_KEY_FALSE(ice_xdp_locking_key);
> > > > +DECLARE_STATIC_KEY_FALSE(ice_xdp_meta_key);
> > > >  
> > > >  struct ice_channel {
> > > >  	struct list_head list;
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > > > index 47e8920e1727..ee0df86d34b7 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > > @@ -48,6 +48,9 @@ MODULE_PARM_DESC(debug, "netif level (0=none,...,16=all)");
> > > >  DEFINE_STATIC_KEY_FALSE(ice_xdp_locking_key);
> > > >  EXPORT_SYMBOL(ice_xdp_locking_key);
> > > >  
> > > > +DEFINE_STATIC_KEY_FALSE(ice_xdp_meta_key);
> > > > +EXPORT_SYMBOL(ice_xdp_meta_key);
> > > > +
> > > >  /**
> > > >   * ice_hw_to_dev - Get device pointer from the hardware structure
> > > >   * @hw: pointer to the device HW structure
> > > > @@ -2634,6 +2637,11 @@ static int ice_xdp_alloc_setup_rings(struct ice_vsi *vsi)
> > > >  	return -ENOMEM;
> > > >  }
> > > >  
> > > > +static bool ice_xdp_prog_has_meta(struct bpf_prog *prog)
> > > > +{
> > > > +	return prog && prog->aux->dev_bound;
> > > > +}
> > > > +
> > > >  /**
> > > >   * ice_vsi_assign_bpf_prog - set or clear bpf prog pointer on VSI
> > > >   * @vsi: VSI to set the bpf prog on
> > > > @@ -2644,10 +2652,16 @@ static void ice_vsi_assign_bpf_prog(struct ice_vsi *vsi, struct bpf_prog *prog)
> > > >  	struct bpf_prog *old_prog;
> > > >  	int i;
> > > >  
> > > > +	if (ice_xdp_prog_has_meta(prog))
> > > > +		static_branch_inc(&ice_xdp_meta_key);
> > > 
> > > i thought boolean key would be enough but inc/dec should serve properly
> > > for example prog hotswap cases.
> > >
> > 
> > My thought process on using counting instead of boolean was: there can be 
> > several PFs that use the same driver, so therefore we need to keep track of how 
> > many od them use hints. 
> 
> Very good point. This implies that if PF0 has hints-enabled prog loaded,
> PF1 with non-hints prog will "suffer" from it.
> 
> Sorry for such a long delays in responses but I was having a hard time
> making up my mind about it. In the end I have come up to some conclusions.
> I know the timing for sending this response is not ideal, but I need to
> get this off my chest and bring discussion back to life:)
> 
> IMHO having static keys to eliminate ZC overhead does not scale. I assume
> every other driver would have to follow that.
> 
> XSK pool allows us to avoid initializing various things per each packet.
> Instead, taking xdp_rxq_info as an example, each xdp_buff from pool has
> xdp_rxq_info assigned at init time. With this in mind, we should have some
> mechanism to set hints-specific things in xdp_buff_xsk::cb, at init time
> as well. Such mechanism should not require us to expose driver's private
> xdp_buff hints containers (such as ice_pkt_ctx) to XSK pool.
> 
> Right now you moved phctime down to ice_pkt_ctx and to me that's the main
> reason we have to copy ice_pkt_ctx to each xdp_buff on ZC. What if we keep
> the cached_phctime at original offset in ring but ice_pkt_ctx would get a
> pointer to that?
> 
> This would allow us to init the pointer in each xdp_buff from XSK pool at
> init time. I have come up with a way to program that via so called XSK
> meta descriptors. Each desc would have data to write onto cb, offset
> within cb and amount of bytes to write/copy.
> 
> I'll share the diff below but note that I didn't measure how much lower
> the performance is degraded. My icelake machine where I used to measure
> performance-sensitive code got broke. For now we can't escape initing
> eop_desc per each xdp_buff, but I moved it to alloc side, as we mangle
> descs there anyway.
> 
> I think mlx5 could benefit from that approach as well with initing the rq
> ptr at init time.
> 
> Diff does mostly these things:
> - move cached_phctime to old place in ice_rx_ring and add ptr to that in
>   ice_pkt_ctx
> - introduce xsk_pool_set_meta()
> - use it from ice side.
> 
> I consider this as a discussion trigger rather than ready code. Any
> feedback will be appreciated.
> 
> ---------------------------------8<---------------------------------
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index 7fa43827a3f0..c192e84bee55 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -519,6 +519,23 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
>  	return 0;
>  }
>  

[...]

> > > 
> > > My only concern is that we might be hurting in a minor way hints path now,
> > > no?
> > 
> > I have thought "unlikely" refers to the default state the code is compiled with 
> > and after static key incrementation this should be patched to "likely". Isn't 
> > this how static keys work?
> 
> I was only referring to that it ends with compiler hint:
> #define unlikely_notrace(x)	__builtin_expect(!!(x), 0)
> 
> see include/linux/jump_label.h
> 

You are right, I have misunderstood the concept a little bit.

> > 
> > > 
> > > > +		ice_xdp_meta_set_desc(xdp, eop_desc);
> > > >  
> > > >  	act = bpf_prog_run_xdp(xdp_prog, xdp);
> > > >  	switch (act) {
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > index 39775bb6cec1..f92d7d33fde6 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > @@ -773,6 +773,9 @@ static void ice_prepare_pkt_ctx_zc(struct xdp_buff *xdp,
> > > >  				   union ice_32b_rx_flex_desc *eop_desc,
> > > >  				   struct ice_rx_ring *rx_ring)
> > > >  {
> > > > +	if (!static_branch_unlikely(&ice_xdp_meta_key))
> > > > +		return;
> > > 
> > > wouldn't it be better to pull it out and avoid calling
> > > ice_prepare_pkt_ctx_zc() unnecessarily?
> > > 
> > > > +
> > > >  	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
> > > >  	((struct ice_xdp_buff *)xdp)->pkt_ctx = rx_ring->pkt_ctx;
> > > >  	ice_xdp_meta_set_desc(xdp, eop_desc);
> > > > -- 
> > > > 2.41.0
> > > > 

