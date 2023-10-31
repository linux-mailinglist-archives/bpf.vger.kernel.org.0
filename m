Return-Path: <bpf+bounces-13708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE44A7DCEEE
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 15:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8107F281163
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FBE1DFC8;
	Tue, 31 Oct 2023 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0Sk5Gk6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DDB1DFC0;
	Tue, 31 Oct 2023 14:22:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9F2F7;
	Tue, 31 Oct 2023 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698762171; x=1730298171;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s4h3gGzdfKdwpuvlhJeyvJvThZBGsRVTLzc6rIUeVnI=;
  b=X0Sk5Gk64HX1ZQw8jiTNdXCnLJT1BPskVKin4c/yjPFIlKJ8bD9+St0T
   o+thCVLQHPG6jyoEqXhY1s4B2WZhcv5WZR5vcxmhrTpma87co5FT8JKwD
   jcKKzJ0Tio46tH6EZeht0uqiT6pQUgpEYr+0uFYXXS4JyLgDTLe+wYMT9
   8678+gMBc1G10tAmt+opfpq+LFTJu3pbzd7/bnITE4y23xLmQfjGOUYNA
   NydIQTICbM2y1nDIXxc+Y4B995+bAqCrEzKHK6M834qJeH4dAXegVYFt2
   FgAxMVv0wX1q/m+sl3aaYMyOb8DofSAwv4WGy1FJfcwKF54m4JrifnCBo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="387183350"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="387183350"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 07:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="884221180"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="884221180"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 07:22:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 07:22:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 07:22:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 07:22:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 07:22:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvBgsHK8bKux5zyQEvmjBr5n/+iNjrx3b4yvtozgQITUJAXAfb39L+baNAsCM7Yp7E1OkhlPQTTBSvnCUjR+QcRPU2S4MhG7I5d9uus9LwHDsGa2OKThR/xPSGoz70qevVc6ZO4buJS4HIOwiQSeHIPK2CLvDQLVplqEdiD2uHVV1aeMvVaOLjkbUWynSuVFhhDu+4FS2b8BVwf9+q5cjPRN4e5Y7ORcRPrByN+nNfJnXjNMu5qsWrAgQTwrFaNpdbey5MRl6mDX5ATmSXmh9axl7Iv8yrBTp9R6CnyE+9lwwGVsnVKOVS1m9mYNQubbMctoLdFhOTRJj53f2EF6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3obp/0rlJtmkE8+ArHWZk/mSTS0IgZHb4kDdjk2uYmA=;
 b=X1ChKc7cPSxdHmTfNdj2zIlJVRkbS+JpnWBOKFXypvfHqvNeQvOJIlNu3ECNTdhNYW0v62vsMSFR6MfyUI9X/AhTp9ucAaYevmEbnqPuzFnlyaJ8AO5Hcu5fGp0kkfz/F/QWX9CbM9x3u4RUqQj2TrokmNp187AOPV5sY4cwGC3E+TvoYe8rrsjYi4nf38pK7bKJYjbd7Qa4wvl67Oti65ry1HhAVq6HFOX0INWGFYPeJr1lqAWGUsvD1Qk1jYlKqmca2Uo4IApy0jhSifPf4074to56l0W+C+uGmyMNK01fsMXGOh5N3cIhU88Ejn5Eow89/FhwYe7GKiDpHdBqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CH0PR11MB8235.namprd11.prod.outlook.com (2603:10b6:610:187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Tue, 31 Oct
 2023 14:22:43 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%6]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 14:22:43 +0000
Date: Tue, 31 Oct 2023 15:22:31 +0100
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
Message-ID: <ZUENpw5GVqcL0GJc@lzaremba-mobl.ger.corp.intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-12-larysa.zaremba@intel.com>
 <ZTKrjU0a0Q1vF1UU@boxer>
 <ZTY+chHJEgggHu5J@lzaremba-mobl.ger.corp.intel.com>
 <ZT1nSGYng8sUKQD7@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZT1nSGYng8sUKQD7@boxer>
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CH0PR11MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bb3299-991c-4162-e0f4-08dbda1cd7fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yW1nnQ1JJDWaUyqj8VqfA9T+HpM0btq24kpiZMz9juSEXIt07LarcF5wsymWqTurT0KyexkFPlwhZA4IsAWVslc+guSHGh7Jfj9EERBQsQZYMpbsntJBnf3PDur1XFX2cMCrZ6LNUhRA86ASmhq2fbNPTzFcyejz2ARUOVLmn8jeBQqNgAw2Z29KlomjryY5ljL6TBXv5k2VLwovYKY7Ig4EBvJbYZ+DhWn+DK0rZa4jUbCRdZRZI5JvB9+vrLjLNm/KO/Y33QDvy0Qm4GAdbXhNxEnD9BkgGvGgTFeh03DjlLj+LSRBNYpNwOghGJewj3letG8HKP1SZiNKC5+YYcF6s/Yzx6DCWgMHFbFapOaNqy4mhyX4QFDutikuEU94cD/O0KFcPHzK1kmMLWfyK8aE3p02T9p+Dg/Dq6EcnASX70J8pOIwiuxZdKsmIdSyW4Ag5hjEy7sVGx9JBKeWzAO/lTixjoCArgIL86RivTtk6fnhVD+Pwm6KZQco7wU5mKKhlQvAC1CE+8ZGqF1maRQHopOsajoHdPpYJL/KlH+AsxFgWt7AuFturFGulPbT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(8936002)(6512007)(6506007)(66899024)(6666004)(86362001)(83380400001)(38100700002)(82960400001)(26005)(41300700001)(44832011)(66476007)(66946007)(66556008)(6636002)(54906003)(7416002)(316002)(5660300002)(478600001)(8676002)(6862004)(4326008)(30864003)(6486002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?slY5tUn60RgMUl41yBtxkhgCCQv8kICbGPhfcCIFqzjA+qgwSiIl94syKesV?=
 =?us-ascii?Q?ZCVyCphSGcUEwJOsG340FfIueWmwdyeZorTUh8wAnEaxCT5EOOwvwnVwiwEV?=
 =?us-ascii?Q?tblToCxW9JS1ldd1S0MZAS5sBe/cu1t8OS4LMagu6hfOZwDbOP8oGoRI+AyF?=
 =?us-ascii?Q?d1mvL5Ah7RgrOS8be6zcQtX+Mp5OkfmHYf9ElFdPj4Ijuj1u2d9wRdv+0vEe?=
 =?us-ascii?Q?se7HNWI2KnR0YCWQ31Qzfv1/Ul1GKD8KDKUNQgcnd6/G+TrnO7/+kZXUWHnc?=
 =?us-ascii?Q?mx3r1hlG/LC+/6QlXO/3G8YuRT6/8nXlkZHhnpj2c3dKrbpkIQ/DBvFqYpoH?=
 =?us-ascii?Q?tlMdizCxr7Lx2zySyA18IbxsdLZprL2fl00OyhBpB1rlKPVLPhRqnlUDYL9E?=
 =?us-ascii?Q?7KQppNNM4DRAyHuY2O7SkvR5ibQisMLAxLrwyFDAcxo6NZaPmsfjIzQDY1AU?=
 =?us-ascii?Q?F9WGCMN1ZcHorIwoyK/3d3xGkA1o3b7BJQelWY/Y3tUH17MRC7BDj5qdcB7P?=
 =?us-ascii?Q?kfzPCLMfacVmJdug6Bq9T8Kv9qjGTCUO+ontST8HlHuVj2tHAf65DsFP2slR?=
 =?us-ascii?Q?sXt+FwSx9Zs4hqQXJJ1V4e9YegD88XmnbjvxDOk6SJzhMYgLwH/TpYoNu2fk?=
 =?us-ascii?Q?rep9dl3c3kgSZtsK7P9h6yYFBniBFp8zQ8BgTVWIXXoKz9bXAc/SKUzs8yO/?=
 =?us-ascii?Q?RFW+oWaWPiIyQCYZKYqZXirJMKSL474Kjt9XKa8MbW3gQkVfrMDzfbKYjG6h?=
 =?us-ascii?Q?G0vI0/X9oFQ5ZerVUZ0vKEgLecBv16pbW+1aXGvVsCj36RsFmHeD5tXhQu6E?=
 =?us-ascii?Q?ENbcG5Cpr0FpQTNEFFe/iQ0OBhSJvlV6Pt9LSzAPm95EivROjrBQe/cnsLvp?=
 =?us-ascii?Q?V6K0UXWmBSAgWkR6fY96nNEbF8w+b0aIdFWgiuvlejPp7+wQmusUC0r0WI6x?=
 =?us-ascii?Q?beOevvEYGgaSUd3ECNOG4zt7cYjSPPG9EqEz8WDXh0L1hUMq/dED1w3sgjYE?=
 =?us-ascii?Q?G2v53LNxUQXY0Ptkrq2rr2tihtHhvlVBFTbQpYXI/PxxRnPLADEMuMdUe78n?=
 =?us-ascii?Q?Pq/v2oeAF/o9g+mIUlJQH7MP3vf8fY+TMpdp4Mz7wtvLVz1rbYFtXicyH5Md?=
 =?us-ascii?Q?thVDinwCSR7uwM4cuCyHgy8ZhSLT1do+nqpd+C/dADVRKRQWvmuicK31uCnJ?=
 =?us-ascii?Q?g9lvSmNj5gnaTx5/MfbBwVmDP6oE7nWH5u8i3kNBfamucmwgIBX2Tgb4Thls?=
 =?us-ascii?Q?KfA4NLjKzn79EB/6hM+kQ1Dbvc1x31Jc8STEbcamrihs5w/WOEuMe5wn/O/y?=
 =?us-ascii?Q?5QLPg1cMsoUnXWKjiOkk4L1DnPBvqCrGIrLxw2UXZcJBwQh70qU8ozcEWZc+?=
 =?us-ascii?Q?xXbfw2kQWqulc8G4oSEj2/zEdT89lcCXpfKQHOt0/OIwiHd2tQL+TX+px3me?=
 =?us-ascii?Q?VL/1qIQbhTj8EXzjxpnrscj/IdgUruBMgshblfQT2e0grnVI6knMWOH72L+Z?=
 =?us-ascii?Q?uoIxRuz4w5wHflu9FaRyvi+r7ts2MkV7AlcxwW+g87ymwT/YkkYUzho2mRvX?=
 =?us-ascii?Q?2p2bejpfWvXFnE9q9xzhlljYkKc+1HGTJmG0czOXg3UtojqnZnR5ddrXNtgG?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bb3299-991c-4162-e0f4-08dbda1cd7fc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 14:22:42.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jb9sHhw3oX78tAx4Ib02NLxGQXckon5MyECs2AmECeqheVB4vHay/4kfmQkkiO5FocFsrl1n/gqAVWmpOepNXqrXbAR13XDy2FIkq4h8SRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8235
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

Thank you for the code! I will probably send v7 with such changes. Are you OK, 
if patch with core changes would go with you as an author?

But also, I see a minor problem with that switching VLAN protocol does not 
trigger buffer allocation, so we have to point to that too, this probably means 
moving cached time back and finding 16 extra bits in CL3. Single pointer to 
{cached time, vlan_proto} would be copied to be after xdp_buff.

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
> +static void ice_xsk_pool_set_meta(struct ice_rx_ring *ring)
> +{
> +	struct xsk_meta_desc desc = {};
> +
> +	desc.val = (uintptr_t)&ring->cached_phctime;
> +	desc.off = offsetof(struct ice_pkt_ctx, cached_phctime);
> +	desc.bytes = sizeof_field(struct ice_pkt_ctx, cached_phctime);
> +	xsk_pool_set_meta(ring->xsk_pool, &desc);
> +
> +	memset(&desc, 0, sizeof(struct xsk_meta_desc));
> +
> +	desc.val = ring->pkt_ctx.vlan_proto;
> +	desc.off = offsetof(struct ice_pkt_ctx, vlan_proto);
> +	desc.bytes = sizeof_field(struct ice_pkt_ctx, vlan_proto);
> +	xsk_pool_set_meta(ring->xsk_pool, &desc);
> +}
> +
>  /**
>   * ice_vsi_cfg_rxq - Configure an Rx queue
>   * @ring: the ring being configured
> @@ -553,6 +570,7 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>  			if (err)
>  				return err;
>  			xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
> +			ice_xsk_pool_set_meta(ring);
>  
>  			dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
>  				 ring->q_index);
> @@ -575,6 +593,7 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>  
>  	xdp_init_buff(&ring->xdp, ice_rx_pg_size(ring) / 2, &ring->xdp_rxq);
>  	ring->xdp.data = NULL;
> +	ring->pkt_ctx.cached_phctime = &ring->cached_phctime;
>  	err = ice_setup_rx_ctx(ring);
>  	if (err) {
>  		dev_err(dev, "ice_setup_rx_ctx failed for RxQ %d, err %d\n",
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index cf5c91ada94c..d3cb08e66dcb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -2846,7 +2846,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>  		/* clone ring and setup updated count */
>  		rx_rings[i] = *vsi->rx_rings[i];
>  		rx_rings[i].count = new_rx_cnt;
> -		rx_rings[i].pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
> +		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
>  		rx_rings[i].desc = NULL;
>  		rx_rings[i].rx_buf = NULL;
>  		/* this is to allow wr32 to have something to write to
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 2fc97eafd1f6..1f45f0c3963d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1456,7 +1456,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
>  		ring->netdev = vsi->netdev;
>  		ring->dev = dev;
>  		ring->count = vsi->num_rx_desc;
> -		ring->pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
> +		ring->cached_phctime = pf->ptp.cached_phc_time;
>  		WRITE_ONCE(vsi->rx_rings[i], ring);
>  	}
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index f6444890f0ef..e2fa979830cd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -955,8 +955,7 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
>  		ice_for_each_rxq(vsi, j) {
>  			if (!vsi->rx_rings[j])
>  				continue;
> -			WRITE_ONCE(vsi->rx_rings[j]->pkt_ctx.cached_phctime,
> -				   systime);
> +			WRITE_ONCE(vsi->rx_rings[j]->cached_phctime, systime);
>  		}
>  	}
>  	clear_bit(ICE_CFG_BUSY, pf->state);
> @@ -2119,7 +2118,7 @@ u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
>  	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
>  		return 0;
>  
> -	cached_time = READ_ONCE(pkt_ctx->cached_phctime);
> +	cached_time = READ_ONCE(*pkt_ctx->cached_phctime);
>  
>  	/* Do not report a timestamp if we don't have a cached PHC time */
>  	if (!cached_time)
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index 41e0b14e6643..94594cc0d3ee 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -259,7 +259,7 @@ enum ice_rx_dtype {
>  
>  struct ice_pkt_ctx {
>  	const union ice_32b_rx_flex_desc *eop_desc;
> -	u64 cached_phctime;
> +	u64 *cached_phctime;
>  	__be16 vlan_proto;
>  };
>  
> @@ -356,6 +356,7 @@ struct ice_rx_ring {
>  	struct ice_tx_ring *xdp_ring;
>  	struct xsk_buff_pool *xsk_pool;
>  	dma_addr_t dma;			/* physical address of ring */
> +	u64 cached_phctime;
>  	u16 rx_buf_len;
>  	u8 dcb_tc;			/* Traffic class of ring */
>  	u8 ptp_rx;
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 49a64bfdd1f6..6fa7a86152d0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -431,9 +431,18 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
>  	return ret;
>  }
>  
> +static struct ice_xdp_buff *xsk_buff_to_ice_ctx(struct xdp_buff *xdp)
> +{
> +	/* xdp_buff pointer used by ZC code path is alloc as xdp_buff_xsk. The
> +	 * ice_xdp_buff shares its layout with xdp_buff_xsk and private
> +	 * ice_xdp_buff fields fall into xdp_buff_xsk->cb
> +	 */
> +       return (struct ice_xdp_buff *)xdp;
> +}
> +
>  /**
>   * ice_fill_rx_descs - pick buffers from XSK buffer pool and use it
> - * @pool: XSK Buffer pool to pull the buffers from
> + * @rx_ring: rx ring
>   * @xdp: SW ring of xdp_buff that will hold the buffers
>   * @rx_desc: Pointer to Rx descriptors that will be filled
>   * @count: The number of buffers to allocate
> @@ -445,18 +454,21 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
>   *
>   * Returns the amount of allocated Rx descriptors
>   */
> -static u16 ice_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
> +static u16 ice_fill_rx_descs(struct ice_rx_ring *rx_ring, struct xdp_buff **xdp,
>  			     union ice_32b_rx_flex_desc *rx_desc, u16 count)
>  {
> +	struct ice_xdp_buff *ctx;
>  	dma_addr_t dma;
>  	u16 buffs;
>  	int i;
>  
> -	buffs = xsk_buff_alloc_batch(pool, xdp, count);
> +	buffs = xsk_buff_alloc_batch(rx_ring->xsk_pool, xdp, count);
>  	for (i = 0; i < buffs; i++) {
>  		dma = xsk_buff_xdp_get_dma(*xdp);
>  		rx_desc->read.pkt_addr = cpu_to_le64(dma);
>  		rx_desc->wb.status_error0 = 0;
> +		ctx = xsk_buff_to_ice_ctx(*xdp);
> +		ctx->pkt_ctx.eop_desc = rx_desc;
>  
>  		rx_desc++;
>  		xdp++;
> @@ -488,8 +500,7 @@ static bool __ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring, u16 count)
>  	xdp = ice_xdp_buf(rx_ring, ntu);
>  
>  	if (ntu + count >= rx_ring->count) {
> -		nb_buffs_extra = ice_fill_rx_descs(rx_ring->xsk_pool, xdp,
> -						   rx_desc,
> +		nb_buffs_extra = ice_fill_rx_descs(rx_ring, xdp, rx_desc,
>  						   rx_ring->count - ntu);
>  		if (nb_buffs_extra != rx_ring->count - ntu) {
>  			ntu += nb_buffs_extra;
> @@ -502,7 +513,7 @@ static bool __ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring, u16 count)
>  		ice_release_rx_desc(rx_ring, 0);
>  	}
>  
> -	nb_buffs = ice_fill_rx_descs(rx_ring->xsk_pool, xdp, rx_desc, count);
> +	nb_buffs = ice_fill_rx_descs(rx_ring, xdp, rx_desc, count);
>  
>  	ntu += nb_buffs;
>  	if (ntu == rx_ring->count)
> @@ -746,32 +757,6 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
>  	return ICE_XDP_CONSUMED;
>  }
>  
> -/**
> - * ice_prepare_pkt_ctx_zc - Prepare packet context for XDP hints
> - * @xdp: xdp_buff used as input to the XDP program
> - * @eop_desc: End of packet descriptor
> - * @rx_ring: Rx ring with packet context
> - *
> - * In regular XDP, xdp_buff is placed inside the ring structure,
> - * just before the packet context, so the latter can be accessed
> - * with xdp_buff address only at all times, but in ZC mode,
> - * xdp_buffs come from the pool, so we need to reinitialize
> - * context for every packet.
> - *
> - * We can safely convert xdp_buff_xsk to ice_xdp_buff,
> - * because there are XSK_PRIV_MAX bytes reserved in xdp_buff_xsk
> - * right after xdp_buff, for our private use.
> - * XSK_CHECK_PRIV_TYPE() ensures we do not go above the limit.
> - */
> -static void ice_prepare_pkt_ctx_zc(struct xdp_buff *xdp,
> -				   union ice_32b_rx_flex_desc *eop_desc,
> -				   struct ice_rx_ring *rx_ring)
> -{
> -	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
> -	((struct ice_xdp_buff *)xdp)->pkt_ctx = rx_ring->pkt_ctx;
> -	ice_xdp_meta_set_desc(xdp, eop_desc);
> -}
> -
>  /**
>   * ice_run_xdp_zc - Executes an XDP program in zero-copy path
>   * @rx_ring: Rx ring
> @@ -784,13 +769,11 @@ static void ice_prepare_pkt_ctx_zc(struct xdp_buff *xdp,
>   */
>  static int
>  ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> -	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> -	       union ice_32b_rx_flex_desc *rx_desc)
> +	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring)
>  {
>  	int err, result = ICE_XDP_PASS;
>  	u32 act;
>  
> -	ice_prepare_pkt_ctx_zc(xdp, rx_desc, rx_ring);
>  	act = bpf_prog_run_xdp(xdp_prog, xdp);
>  
>  	if (likely(act == XDP_REDIRECT)) {
> @@ -930,8 +913,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
>  		if (ice_is_non_eop(rx_ring, rx_desc))
>  			continue;
>  
> -		xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring,
> -					 rx_desc);
> +		xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring);
>  		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
>  			xdp_xmit |= xdp_res;
>  		} else if (xdp_res == ICE_XDP_EXIT) {
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 1f6fc8c7a84c..91fa74a14841 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -14,6 +14,13 @@
>  
>  #ifdef CONFIG_XDP_SOCKETS
>  
> +struct xsk_meta_desc {
> +	u64 val;
> +	u8 off;
> +	u8 bytes;
> +};
> +
> +
>  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
> @@ -47,6 +54,12 @@ static inline void xsk_pool_set_rxq_info(struct xsk_buff_pool *pool,
>  	xp_set_rxq_info(pool, rxq);
>  }
>  
> +static inline void xsk_pool_set_meta(struct xsk_buff_pool *pool,
> +				     struct xsk_meta_desc *desc)
> +{
> +	xp_set_meta(pool, desc);
> +}
> +
>  static inline unsigned int xsk_pool_get_napi_id(struct xsk_buff_pool *pool)
>  {
>  #ifdef CONFIG_NET_RX_BUSY_POLL
> @@ -250,6 +263,11 @@ static inline void xsk_pool_set_rxq_info(struct xsk_buff_pool *pool,
>  {
>  }
>  
> +static inline void xsk_pool_set_meta(struct xsk_buff_pool *pool,
> +				     struct xsk_meta_desc *desc)
> +{
> +}
> +
>  static inline unsigned int xsk_pool_get_napi_id(struct xsk_buff_pool *pool)
>  {
>  	return 0;
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index b0bdff26fc88..354b1c702a82 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -12,6 +12,7 @@
>  
>  struct xsk_buff_pool;
>  struct xdp_rxq_info;
> +struct xsk_meta_desc;
>  struct xsk_queue;
>  struct xdp_desc;
>  struct xdp_umem;
> @@ -132,6 +133,7 @@ static inline void xp_init_xskb_dma(struct xdp_buff_xsk *xskb, struct xsk_buff_p
>  
>  /* AF_XDP ZC drivers, via xdp_sock_buff.h */
>  void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq);
> +void xp_set_meta(struct xsk_buff_pool *pool, struct xsk_meta_desc *desc);
>  int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
>  	       unsigned long attrs, struct page **pages, u32 nr_pages);
>  void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs);
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 49cb9f9a09be..632fdc247862 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -123,6 +123,18 @@ void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq)
>  }
>  EXPORT_SYMBOL(xp_set_rxq_info);
>  
> +void xp_set_meta(struct xsk_buff_pool *pool, struct xsk_meta_desc *desc)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < pool->heads_cnt; i++) {
> +		struct xdp_buff_xsk *xskb = &pool->heads[i];
> +
> +		memcpy(xskb->cb + desc->off, desc->buf, desc->bytes);
> +	}
> +}
> +EXPORT_SYMBOL(xp_set_meta);
> +
>  static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
>  {
>  	struct netdev_bpf bpf;
> 
> --------------------------------->8---------------------------------
> 
> > And yes, this also looks better for hot-swapping, 
> > because conditions become more straightforward (we do not need to compare old 
> > and new programs).
> > 
> > > > +
> > > >  	old_prog = xchg(&vsi->xdp_prog, prog);
> > > >  	ice_for_each_rxq(vsi, i)
> > > >  		WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);
> > > >  
> > > > +	if (ice_xdp_prog_has_meta(old_prog))
> > > > +		static_branch_dec(&ice_xdp_meta_key);
> > > > +
> > > >  	if (old_prog)
> > > >  		bpf_prog_put(old_prog);
> > > >  }
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > index 4fd7614f243d..19fc182d1f4c 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > @@ -572,7 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > >  	if (!xdp_prog)
> > > >  		goto exit;
> > > >  
> > > > -	ice_xdp_meta_set_desc(xdp, eop_desc);
> > > > +	if (static_branch_unlikely(&ice_xdp_meta_key))
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

