Return-Path: <bpf+bounces-13946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C607DF39B
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 14:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868C6281B2D
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3391548B;
	Thu,  2 Nov 2023 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXcQcCo4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691F12B87;
	Thu,  2 Nov 2023 13:23:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E86BD7;
	Thu,  2 Nov 2023 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698931402; x=1730467402;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YME8mTxgKI0MeNPDdD9F4L3kc3xLR2qJTzzQVP8gcUo=;
  b=eXcQcCo4u9itwwizgGsgHVh6a4hkncqHFo2VxPvoFJJMQHw3twcMTRpO
   8vWwrTU1lxpe3QFW/imNIEESA3drP1iQxd96YHFd26rtFeNX1JB0loUg8
   UA/+h7PS7a/40MqoslKEirrg4CM5jNpMx1LxqwpWniogs+isIqjcijQN4
   XIFTew0bniMkXTTKvpgLu73ZRtYqvJOZgrQffZH52ZLpR7QLBQStwn2pe
   sXWiI1bNrh3AXM0dXtgwgG7bnApQN++u+VjFWEnhsny+F3pbotWCMEwgX
   NJEexv6hwKzF66ZxvEkA0BjwBZtO3sQbR3sp1gH7SS4TlzQrLKGQlp1Lx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="385885030"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="385885030"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:23:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="831688703"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="831688703"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 06:23:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 06:23:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 06:23:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 06:23:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 06:23:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYZSMnMEFYWN8N8Z08Sp5QMijkoCaGQgB2GFdPQCtKQ7r+T9V0SFtfXnL7JK+be4eDw1QXTFrqhPsRuocgZsm7ISWvUHhczf4OsdIBV8vExSyJPUxtYMZjCMXyao/tdsMcIFm3YDZwG96TuHOuAQakBx+Nd+Ii9nbjATVUzpkQLtZDlqemU4W1sfN4sJ+A5qW2zQC6Y4sspmp3XtstY1CI6BSVqHEsG39VieY0SIB+i5vwa5k83V6xjO8jmrviO/ICeq3G0t29Am/bGP3LqNWUpHK4V/qVw19dxtjzIwZs+okLmjBwCOX8G0FlJpf/+6+utysGA+iDKZ1kvUhgSt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TObOITG2HMBNZJMMqkp5mIXYB2DlEWX7+r7F1Qvh4gE=;
 b=C30ZajUR1HT3eminilffbUuSaixmwD0I8I4fwlBth61+GxsMw/ZZWqU0q2r8roDNewweLiZbAH0pKPpJMSBr8Igjn91WivRoA4PSUwunUJYQDQegJpUM2BNgofY0FOZjLFsMGPaic3ceV1daWyWJ7HFES1Yg55ook6av3OLBD9mfM7AyBjp4EjlfPFwVZ6kxnAuoBybmR57TleHfsYpx2aRAM6rmt3iMZxaHidLYIemkq0VvXGgpJUYvLa24QbfE2iiQSqrrjtd+vmZ5IS2Qwnw+fK5I/XqWvaBQ8Zye24+SYGTB4pConYhXh3ujB769o8xGTv4XqL3H9BWFp2pDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB6240.namprd11.prod.outlook.com (2603:10b6:8:a6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Thu, 2 Nov 2023 13:23:16 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 13:23:15 +0000
Date: Thu, 2 Nov 2023 14:23:02 +0100
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
 Mahameed" <saeedm@mellanox.com>, <toke@kernel.org>
Subject: Re: [PATCH bpf-next v6 11/18] ice: put XDP meta sources assignment
 under a static key condition
Message-ID: <ZUOitlGHC0Kgrh5i@boxer>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-12-larysa.zaremba@intel.com>
 <ZTKrjU0a0Q1vF1UU@boxer>
 <ZTY+chHJEgggHu5J@lzaremba-mobl.ger.corp.intel.com>
 <ZT1nSGYng8sUKQD7@boxer>
 <ZUENpw5GVqcL0GJc@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZUENpw5GVqcL0GJc@lzaremba-mobl.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::11) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: b972ffce-2f60-46c5-9d18-08dbdba6df03
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHM5fUE3eX67uGpSvby6hN55YI3We4aHgUHMe5cALwdTMIhhDYCWw+xjUybd9gQFoIYgBdKUZ8rysKJ/CfCYgz0hPOMS5J6W3rCIsS5eb/ubdg7BDBckASBYW179Ao41a0atBzN8n4SssbO8XyBsMvSswowqRMOQtrqoeCkx5qPTALq0JXpW3BER4dKfCuJNRZx7VCG3IJjWpFAmFt9iAFZgjr57n21r+RRbzHVm4ddz6469WwvkDh2GtCTdGZ5RidIUFT0ed7/WOK4jIYatNu9rAqBxjCKCtSuG7fCLipo0Lv/4VsoYnc4xYqSR7nPz2lRTs6ZffzX05mVb3+6HQO3S/77Tj9VY4BxfC2TbynSF9034OEUo8XPVSW2D0OEmgXb0R4dzON1W1BsQDbl7HqzXfsA6+Y6DcB2RF6FHbqyNOXdFzo7BgeafjfNHbcCvgkdOZDJmNTq2JGQkdssRKryb6ta32U7hnuyEQI53kA1g/GGnzn+oaYE0KpO5wPwT6uyJkUNqTY6ShD88F3lN/O8swSyAY54RcMSh8a5CCaUnfrRKgE6G6CpaD05WHaCZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(376002)(39860400002)(366004)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(9686003)(26005)(6512007)(478600001)(44832011)(6666004)(6862004)(8676002)(5660300002)(2906002)(7416002)(41300700001)(33716001)(6506007)(54906003)(4326008)(66556008)(8936002)(66946007)(6486002)(6636002)(316002)(66476007)(38100700002)(83380400001)(86362001)(82960400001)(66899024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8iWtMStMzF+EL61CgsQ9g3GQMjaNHvayhchC/gD3+Pu2r1ifA4ngnBJUWFhX?=
 =?us-ascii?Q?76kugccDuDib8MSlmVisVLvvypT7HJWzvPuGw8WqQ1Gk8J1roADRtUgBOudc?=
 =?us-ascii?Q?9EYycFVYPJuidvnEcFwX/aMSvnvkimZU218AOwB9cv5/p4e2IouWcMXhiP6X?=
 =?us-ascii?Q?amZLRtaoQHupcZSjskg3TGEybyPC9VuEEXjQy4gfZfu/70lFSMLMJx9vWxMS?=
 =?us-ascii?Q?pFaUWDCibbasWXPIHEK3rlKCHXrTUJRIeywtCw0G14AaRju3lsR4U9K/u/of?=
 =?us-ascii?Q?DlLSQCDuTRTpZt7hfYS/SIv9dM5T0QRCDdRBwXJe/JevsFbZ8pfyGtMJH3Fn?=
 =?us-ascii?Q?y8JI6OokBnK2TNk3+DaUzdrKxZNMcXDSPCc2YaE1A8QO9XqUg8iXC8FcRynP?=
 =?us-ascii?Q?ZgO0wNJOxUtx5hy9kZydRIUOIaSps4uM3dVgDCGABtuHglPL8nfSGcc3oSzL?=
 =?us-ascii?Q?ocCAT4s2lgnvyWIMXGe6ib2ExyT2mH5D3vgItrpL4OpwEQeEOd2E8zT+fK4u?=
 =?us-ascii?Q?YYzO2OciLs4/bybgsGdkI6idGs1V8zLSnIRlrNAavuls7Auv8YHAFr2UcL/T?=
 =?us-ascii?Q?FOBNEHaJsi9VpCsIfUanKAKcE9tQZgy7VFBsvbVvi1DlzTI+pBn6QSEs+xbq?=
 =?us-ascii?Q?SOijFp+s7KNA8mMbIQyZbPKYXBcrr+MUYxNc8AAZ+9vEmLDPriYysgWiL1mz?=
 =?us-ascii?Q?EY/f9TGdjwWQicjbeFFAtMnKLuTFarNfl4+3RsXL1Q15Kv3fhnJCn0EGwJB2?=
 =?us-ascii?Q?JB45SbSWDAzjO0c7Ea3EIB4+rif969MY3yxFjT6Yg6fBMlxRYkrg9kT7shvi?=
 =?us-ascii?Q?HyQjOGsGo02OoRDnSnbv0ZrCoCyGSQdbzc1KBR0pHMjnZVitaEtB0zzEjTp8?=
 =?us-ascii?Q?i7dfEJC5cnhEypQRfJr1tYEdUoXHj4D5gwMP++93tXUDh7XZTZSnAV6zO5v8?=
 =?us-ascii?Q?fsMzjkOX1lWiLDdJabqKAkGDNAw90fYa7G3JahY1bmapkI1dEKduxeeps5+W?=
 =?us-ascii?Q?NeCklIYqj7za3MthiUGDIRb9klr+x3pidmedkGUCyyJQetY3PayDJD2mJbeQ?=
 =?us-ascii?Q?0V3TDMq0ZISNbM3NSV02VNsONmuu1nv7jp2QKyp/1CS5iUFyP9bJClYdEd3K?=
 =?us-ascii?Q?ymLRln5++bofXz3T7MC+uossFJ+7nMbwju38c9rVZ2zLoU1y8+eZonGB077j?=
 =?us-ascii?Q?gJ3S/nV7pZ90RwOMRGCQ57kQo0qbA0kqTBbFtPHoNeILk+AVwNlYnT5+IB8C?=
 =?us-ascii?Q?u5VXZjabFub2kJd4tY00vF0Ip+q6JA78Buv+/zAgm5WZsLHRweP63Oms9vGj?=
 =?us-ascii?Q?ZSHAws+cIn3ZwMEix/BxwRdmZ2Lq1jwPk5XT0t2VXu2x82b6ouqYdm3Tad01?=
 =?us-ascii?Q?a42pfQJbkRgRLDh4r+UlX6T92br8XuQsaik1JrAjBwak8ODwP34V9UIjaAhi?=
 =?us-ascii?Q?O6PYr9L1MC2gVXrspxQdee4ho+YP51Km6NMJfrOEv0hPBwFrX7SH22HixcwP?=
 =?us-ascii?Q?XGiZxoh3RqQ0r7vNCV+TO+hKI14vtoL6LVdTPCkBnGF+sVifES3nPG+6Wty5?=
 =?us-ascii?Q?SwmKw9MZCmTiay4m8ZIue0defF1u2XjiupACgrFB8mO9lxYVQUh14kJBP9z9?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b972ffce-2f60-46c5-9d18-08dbdba6df03
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 13:23:15.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1kS649uVC0gRrXLvy1f/hxJmPGJmZNRD1k0RY5PRFrmE3MfM0WbxNuWaW7GkXe8FLWQrWfXvTm0dKuxOvoUopTkxv0SY2JMIaRfwKjHoWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6240
X-OriginatorOrg: intel.com

On Tue, Oct 31, 2023 at 03:22:31PM +0100, Larysa Zaremba wrote:
> On Sat, Oct 28, 2023 at 09:55:52PM +0200, Maciej Fijalkowski wrote:
> > On Mon, Oct 23, 2023 at 11:35:46AM +0200, Larysa Zaremba wrote:
> > > On Fri, Oct 20, 2023 at 06:32:13PM +0200, Maciej Fijalkowski wrote:
> > > > On Thu, Oct 12, 2023 at 07:05:17PM +0200, Larysa Zaremba wrote:
> > > > > Usage of XDP hints requires putting additional information after the
> > > > > xdp_buff. In basic case, only the descriptor has to be copied on a
> > > > > per-packet basis, because xdp_buff permanently resides before per-ring
> > > > > metadata (cached time and VLAN protocol ID).
> > > > > 
> > > > > However, in ZC mode, xdp_buffs come from a pool, so memory after such
> > > > > buffer does not contain any reliable information, so everything has to be
> > > > > copied, damaging the performance.
> > > > > 
> > > > > Introduce a static key to enable meta sources assignment only when attached
> > > > > XDP program is device-bound.
> > > > > 
> > > > > This patch eliminates a 6% performance drop in ZC mode, which was a result
> > > > > of addition of XDP hints to the driver.
> > > > > 
> > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > ---
> > > > >  drivers/net/ethernet/intel/ice/ice.h      |  1 +
> > > > >  drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++++++++
> > > > >  drivers/net/ethernet/intel/ice/ice_txrx.c |  3 ++-
> > > > >  drivers/net/ethernet/intel/ice/ice_xsk.c  |  3 +++
> > > > >  4 files changed, 20 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> > > > > index 3d0f15f8b2b8..76d22be878a4 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice.h
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > > > > @@ -210,6 +210,7 @@ enum ice_feature {
> > > > >  };
> > > > >  
> > > > >  DECLARE_STATIC_KEY_FALSE(ice_xdp_locking_key);
> > > > > +DECLARE_STATIC_KEY_FALSE(ice_xdp_meta_key);
> > > > >  
> > > > >  struct ice_channel {
> > > > >  	struct list_head list;
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > > > > index 47e8920e1727..ee0df86d34b7 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > > > @@ -48,6 +48,9 @@ MODULE_PARM_DESC(debug, "netif level (0=none,...,16=all)");
> > > > >  DEFINE_STATIC_KEY_FALSE(ice_xdp_locking_key);
> > > > >  EXPORT_SYMBOL(ice_xdp_locking_key);
> > > > >  
> > > > > +DEFINE_STATIC_KEY_FALSE(ice_xdp_meta_key);
> > > > > +EXPORT_SYMBOL(ice_xdp_meta_key);
> > > > > +
> > > > >  /**
> > > > >   * ice_hw_to_dev - Get device pointer from the hardware structure
> > > > >   * @hw: pointer to the device HW structure
> > > > > @@ -2634,6 +2637,11 @@ static int ice_xdp_alloc_setup_rings(struct ice_vsi *vsi)
> > > > >  	return -ENOMEM;
> > > > >  }
> > > > >  
> > > > > +static bool ice_xdp_prog_has_meta(struct bpf_prog *prog)
> > > > > +{
> > > > > +	return prog && prog->aux->dev_bound;
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * ice_vsi_assign_bpf_prog - set or clear bpf prog pointer on VSI
> > > > >   * @vsi: VSI to set the bpf prog on
> > > > > @@ -2644,10 +2652,16 @@ static void ice_vsi_assign_bpf_prog(struct ice_vsi *vsi, struct bpf_prog *prog)
> > > > >  	struct bpf_prog *old_prog;
> > > > >  	int i;
> > > > >  
> > > > > +	if (ice_xdp_prog_has_meta(prog))
> > > > > +		static_branch_inc(&ice_xdp_meta_key);
> > > > 
> > > > i thought boolean key would be enough but inc/dec should serve properly
> > > > for example prog hotswap cases.
> > > >
> > > 
> > > My thought process on using counting instead of boolean was: there can be 
> > > several PFs that use the same driver, so therefore we need to keep track of how 
> > > many od them use hints. 
> > 
> > Very good point. This implies that if PF0 has hints-enabled prog loaded,
> > PF1 with non-hints prog will "suffer" from it.
> > 
> > Sorry for such a long delays in responses but I was having a hard time
> > making up my mind about it. In the end I have come up to some conclusions.
> > I know the timing for sending this response is not ideal, but I need to
> > get this off my chest and bring discussion back to life:)
> > 
> > IMHO having static keys to eliminate ZC overhead does not scale. I assume
> > every other driver would have to follow that.
> > 
> > XSK pool allows us to avoid initializing various things per each packet.
> > Instead, taking xdp_rxq_info as an example, each xdp_buff from pool has
> > xdp_rxq_info assigned at init time. With this in mind, we should have some
> > mechanism to set hints-specific things in xdp_buff_xsk::cb, at init time
> > as well. Such mechanism should not require us to expose driver's private
> > xdp_buff hints containers (such as ice_pkt_ctx) to XSK pool.
> > 
> > Right now you moved phctime down to ice_pkt_ctx and to me that's the main
> > reason we have to copy ice_pkt_ctx to each xdp_buff on ZC. What if we keep
> > the cached_phctime at original offset in ring but ice_pkt_ctx would get a
> > pointer to that?
> > 
> > This would allow us to init the pointer in each xdp_buff from XSK pool at
> > init time. I have come up with a way to program that via so called XSK
> > meta descriptors. Each desc would have data to write onto cb, offset
> > within cb and amount of bytes to write/copy.
> > 
> > I'll share the diff below but note that I didn't measure how much lower
> > the performance is degraded. My icelake machine where I used to measure
> > performance-sensitive code got broke. For now we can't escape initing
> > eop_desc per each xdp_buff, but I moved it to alloc side, as we mangle
> > descs there anyway.
> > 
> > I think mlx5 could benefit from that approach as well with initing the rq
> > ptr at init time.
> > 
> > Diff does mostly these things:
> > - move cached_phctime to old place in ice_rx_ring and add ptr to that in
> >   ice_pkt_ctx
> > - introduce xsk_pool_set_meta()
> > - use it from ice side.
> > 
> 
> Thank you for the code! I will probably send v7 with such changes. Are you OK, 
> if patch with core changes would go with you as an author?

Yes or I can produce a patch and share, up to you.

> 
> But also, I see a minor problem with that switching VLAN protocol does not 
> trigger buffer allocation, so we have to point to that too, this probably means 
> moving cached time back and finding 16 extra bits in CL3. Single pointer to 
> {cached time, vlan_proto} would be copied to be after xdp_buff.

It's not that it has to trigger buffer allocation, we could stop the
interface if pool is present and update vlan proto on pool's xdp_buffs
(from quick glance i don't see that we're stopping iface for setting vlan
features) but that sounds like more of a hassle to do...

So yeah maybe let's just have a ptr in ice_pkt_ctx as well.

[...]

