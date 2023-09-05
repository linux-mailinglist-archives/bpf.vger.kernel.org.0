Return-Path: <bpf+bounces-9270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C00E792CE1
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 19:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC47E2812C3
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F43ADDBF;
	Tue,  5 Sep 2023 17:57:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14513DDA8;
	Tue,  5 Sep 2023 17:57:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5F826AF;
	Tue,  5 Sep 2023 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693936613; x=1725472613;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IBDN6P53rH7yu7YqRg60KHhNwlbbhULk2Q6UvkHywvk=;
  b=WWTv0SfhjXIvVmrpUbXdliD+8zbjaPEqPWFAwIQKFXmth2YqkBS7S3J8
   s4pxom5un+IgK11GFlUBkgsTJ+hwT9d6Jrq9XEPOo5J5fuCMpEcnsc8hi
   DoJQjZL0iK7uiP6ivdVgY39X4AhS1PfHVe4FeomcckK4yEomOeDV7yGvp
   bZUuFNaehumFdrpM7s5PGKjV+l/YlfVBtuuPoevRGzdv0Evpz+cSRLGD7
   x2rDprlAHbKLfUTbdi27c2nvv89t+axini02LnqIsPgizMS0ngmlWUo6h
   a/wW7tC9apwxy8q9P5IfisU0QhVCQLRz4OtbKlkiFwF1kHzSBvgUUpRYv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375763260"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="375763260"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 10:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="806702725"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="806702725"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 10:53:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 10:53:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 10:53:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 10:53:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 10:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW9bKVM4wfoYa2W6g/7kuLgvWEMIftWEEl0btU14xhEXj+RbxfHmz8u+8e1RA8lIlRpV2BDQvDZy4W7l/bpVonQIwWOpcUFYeHH3cm0jJ3kYLT7P2zUC3LrffcgmYZFi194WiaDQUMwj/Ljt44j5vVPfQWn9EUkx6ptSl3yrTUPr07qFfxg0O2LuBUn3NSG3GTcklNtWj+YlxI57EigAorRiBcySWSgANgcZ6rvfsPXLggyd30PkdWH0eQf7buimI7f/HtF9WC5U24i8URU+MfZfiB23k2q6gtujVWoInV+RwBDQAxQPqoNG8TOOddLtyzulD5jJLJ4hfD67JTM+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IHaRWbJeuDXOMDKfRyk4Fb8QcIkt7t4BLV7dZ9i2OI=;
 b=jkOupqfIVf3+qlvvnfYPcYEPElE6+LXoqFClOzMRlcjHSP3H+ymCRnGtsfPE2yWjeivUnbE3xwpdbAU4t9UjV7SKhbn/c4JbCmZwzeZFegz1UTLJ7OkMm14tDpqLpGZBRXMMMZIfGNtWToiZAtVVrN1VKkJI3G3SBJ85O9hZJ+MoFUkpRXMXz46uDevwOlQhho692Bdn1bTG5Lrf4SL4dUVwvLxj4K86nJGqLp+4Ldd2odFerrXgIhDHhY2zol1j+NEYAgKIq2l7B745GG0Of9B2H90Y1UoiRkHpG3E1Ho612IyBkwmUndZckhkB9PFN5JqD26cckk2PgiH1lUT3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4679.namprd11.prod.outlook.com (2603:10b6:208:26b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 17:53:13 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 17:53:13 +0000
Date: Tue, 5 Sep 2023 19:53:03 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
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
Subject: Re: [xdp-hints] [RFC bpf-next 05/23] ice: Introduce ice_xdp_buff
Message-ID: <ZPdq/7oDhwKu8KFF@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-6-larysa.zaremba@intel.com>
 <ZPX4ftTJiJ+Ibbdd@boxer>
 <ZPYdve6E467wewgP@lincoln>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPYdve6E467wewgP@lincoln>
X-ClientProxiedBy: BE1P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4679:EE_
X-MS-Office365-Filtering-Correlation-Id: 71fdd4c5-1c90-4532-61fd-08dbae38f975
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4R0CQcIVlae58OZkGG/O8YCBM0iy3VbGNw/HOL7qV3XgS8BcRthgLonJh2kLrkh7glecn9Fbmt7Mp5HutuTeGE64UtYcg2CcLO76ZwsEMz7bZ1kr9JgsoGc95Bbr3hO8f5CiY4OvCPR9PLpRtc5W0aF5UGtoMrFcdkf9RTUhUL7OpW5YJ0m1swybh+lgPtOaV5kJsKOivx6YR4T7TLEr7EN+sF8HmLhn7eiU9rnaV5KJkqrZtTvyHJKUUR7Bt7cfZaZ4VG2hkv1BFa5L25abTfjhiEy6Zkzp/e4ZH2R83C5XOs7oLkHvoBXrz42LlAQPy1rSgpk5wCdm5qMl5B7lTkbz7x5tZtgojaU6r6ejU/4X7CCPyWJRHE07b/9mCad+27v25HHT6ZLLZv592eZKL725XmXA09ER9LXcAQqBrJKqa9pgzDi1CnpujfgP3EKNwsokQNFYeLe8jstr1WkSp/tI/TfsfeF3+rlwDspijNPSLJwsd+nk597APHci1xU9dtlxm9u9oDCDUoLG6Es33fUDkWvPoKPxCwlXnuCCwruY+XofxAV0dbHb0LA9Cm0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(2906002)(83380400001)(7416002)(6666004)(66476007)(66556008)(54906003)(66946007)(6636002)(316002)(5660300002)(6506007)(26005)(44832011)(9686003)(41300700001)(6486002)(8936002)(4326008)(6862004)(8676002)(6512007)(478600001)(38100700002)(86362001)(33716001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fUEd9c1vCqJMA3KVMmOCC9HdXDbHUgJPQryXLbzsgRXWc4MGPkSFs0f0JIxk?=
 =?us-ascii?Q?46c4or2sBKNS0GzcTgcOt/t/hWn7Mwja5eUcgHJz16AY19e8vT2O5W5gNa1f?=
 =?us-ascii?Q?dpNU7IbP0peeRESFxAnylPwIHe/SPNHy4UEYypNCEy7opjIWQO5fURJY6rsH?=
 =?us-ascii?Q?QOAMePPUaUpl26TK3+bAd57BrP1Wa442bQiAOYWR3RzxlzgaFJZG59MD8ZXo?=
 =?us-ascii?Q?9N/ofoviy7gIy3NYdP13gw+jF85XFxKGi8E/GrgvM1xmW3CUg5iZkit/yy0d?=
 =?us-ascii?Q?1byEnQGxybnbOQRRc35cntE8v/QIs5Wi9/CyOtqNRKhFlhGDpse9e1NDvVYz?=
 =?us-ascii?Q?rVk0f8N1Pe/zpBwSoCJ6F5728JhBlZrHoeu+HLl+SJgV0E+ck2F74vjlVU/8?=
 =?us-ascii?Q?x6UIGgifpqUkwt5bJMkIjWJIAhqL8kW67xVQPCNsU04hbu1JZmETfoIDmqeA?=
 =?us-ascii?Q?dLewaqAjOIggH8hS68HwRYGrCKCV6PxYfQsR1fA1VJZ9qNYJbDPL6rCl92wF?=
 =?us-ascii?Q?G/YMhgPcUPjhoRa4KmkNd68mT3/4/wiDEUO0crKJt4WTBTqWr6aUSDJx1lDi?=
 =?us-ascii?Q?MxTVq25jR1oDL4fp89rhS0267mB9ZZgtouHoERDR20mMhJsNBXxWTHygLWWW?=
 =?us-ascii?Q?qvPX+7oh1Be1waWAdvAj+1i0Yt+stTZ3pD0BqwCkeZKaEndqNxm5x7v0CsEe?=
 =?us-ascii?Q?tUqybs1RzJHARc72NizppJtDsi4pw2nTGyCTZbzuAQQnagf/Ja6nutoBEAKG?=
 =?us-ascii?Q?PQIWMo0dG0Abf9nwImBXpKRAgAEonpNIOEV3FIh+zaWfr+LGekWFW4+gEpc1?=
 =?us-ascii?Q?vsbzHY34QbpXCvOF18P3JtJhRa+gJt5yOPW56pKU+v+G3bmSwhmAOUm4cOmr?=
 =?us-ascii?Q?/NNLgmrPfb0Q3bfRfkTceO/wU293txlyArPP6lQ/26Hp6p+Mw2/fFD62KPKA?=
 =?us-ascii?Q?938aGJQudF9PVnYrxsXurl/03BfEIZBDtt8rABbEtIcodIdQMzhAZNd70NwV?=
 =?us-ascii?Q?R7gO8hGFBik2EgPSVeG3g5YPjuSdBRhE+E7V8OWsv2pIwBAasKvT7pyUA4QR?=
 =?us-ascii?Q?YUGoo11xDQWhOzmEjl1hk40q2hjYwiUB5wbsJWMGg8mTDlrRn9KuCdIEqHts?=
 =?us-ascii?Q?Vlbl133icHKS56R8eX+Oq2m/Sab1S4VrLeSTsKUC5RHkwwqSIaE1iNIOA2ca?=
 =?us-ascii?Q?N6Ea8nhSQ4IVTVZo2dT5Rf3z3jsgtehoLOfhPxo7saM2aR8mUhZuNptq2d1C?=
 =?us-ascii?Q?oNScvgwj3gwCoQblETR3AzCm3oNTwFoL9fJDcK+gRIyVOFiOWrOfcmECFSFC?=
 =?us-ascii?Q?5waTf0FVlXNyXVAB3ll6FlC4h4IOoy75SLWdN1mf1h0Qb3AbC+p5GLOzglVr?=
 =?us-ascii?Q?JtIJBuYhh7r33YM2RdVhE2z7BqtNxVExNYgBpALpDCLoT7nTKNcTYDtFlUO4?=
 =?us-ascii?Q?zEhQUU5LW8jcKRYzDlpNVkS3vn9aPD1NBsni8VxnX/Hannskql7ChPTX5zuG?=
 =?us-ascii?Q?e90ABD1GQcuwuJr+Bm3G4XyOxlsRZ4TwV4HT9zx6tSlW3xlQKhZcRhaatIO9?=
 =?us-ascii?Q?5LQxxQm7C2okgp9sCkQcE5IfUmFf00eH62vwUVpbNf35k0nbR6jWnVtxCAVc?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fdd4c5-1c90-4532-61fd-08dbae38f975
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 17:53:13.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIRfxekGyX3l+ygppr6KsmA60mNON4YXdCmldBgNSQt0HbmYNTA/i2Uurpzi1e23h4lQW/TZQae2hW4pk+2+h6L+hvjUjJ4NWo4xsIncetk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4679
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 08:11:09PM +0200, Larysa Zaremba wrote:
> On Mon, Sep 04, 2023 at 05:32:14PM +0200, Maciej Fijalkowski wrote:
> > On Thu, Aug 24, 2023 at 09:26:44PM +0200, Larysa Zaremba wrote:
> > > In order to use XDP hints via kfuncs we need to put
> > > RX descriptor and ring pointers just next to xdp_buff.
> > > Same as in hints implementations in other drivers, we achieve
> > > this through putting xdp_buff into a child structure.
> > 
> > Don't you mean a parent struct? xdp_buff will be 'child' of ice_xdp_buff
> > if i'm reading this right.
> >
> 
> ice_xdp_buff is a child in terms of inheritance (pointer to ice_xdp_buff could 
> replace pointer to xdp_buff, but not in reverse).
> 
> > > 
> > > Currently, xdp_buff is stored in the ring structure,
> > > so replace it with union that includes child structure.
> > > This way enough memory is available while existing XDP code
> > > remains isolated from hints.
> > > 
> > > Minimum size of the new child structure (ice_xdp_buff) is exactly
> > > 64 bytes (single cache line). To place it at the start of a cache line,
> > > move 'next' field from CL1 to CL3, as it isn't used often. This still
> > > leaves 128 bits available in CL3 for packet context extensions.
> > 
> > I believe ice_xdp_buff will be beefed up in later patches, so what is the
> > point of moving 'next' ? We won't be able to keep ice_xdp_buff in a single
> > CL anyway.
> >
> 
> It is to at least keep xdp_buff and descriptor pointer (used for every hint) in 
> a single CL, other fields are situational.

Right, something must be moved...still, would be good to see perf
before/after :)

> 
> > > 
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++--
> > >  drivers/net/ethernet/intel/ice/ice_txrx.h     | 26 ++++++++++++++++---
> > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 +++++++
> > >  3 files changed, 38 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > index 40f2f6dabb81..4e6546d9cf85 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > @@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
> > >   * @xdp_prog: XDP program to run
> > >   * @xdp_ring: ring to be used for XDP_TX action
> > >   * @rx_buf: Rx buffer to store the XDP action
> > > + * @eop_desc: Last descriptor in packet to read metadata from
> > >   *
> > >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> > >   */
> > >  static void
> > >  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > >  	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > > -	    struct ice_rx_buf *rx_buf)
> > > +	    struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
> > >  {
> > >  	unsigned int ret = ICE_XDP_PASS;
> > >  	u32 act;
> > > @@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > >  	if (!xdp_prog)
> > >  		goto exit;
> > >  
> > > +	ice_xdp_meta_set_desc(xdp, eop_desc);
> > 
> > I am currently not sure if for multi-buffer case HW repeats all the
> > necessary info within each descriptor for every frag? IOW shouldn't you be
> > using the ice_rx_ring::first_desc?
> > 
> > Would be good to test hints for mbuf case for sure.
> >
> 
> In the skb path, we take metadata from the last descriptor only, so this should 
> be fine. Really worth testing with mbuf though.

Ok, thanks!


