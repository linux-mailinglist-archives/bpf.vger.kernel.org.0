Return-Path: <bpf+bounces-4254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B9749EF4
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 16:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557651C20D71
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6319476;
	Thu,  6 Jul 2023 14:27:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AC48F74;
	Thu,  6 Jul 2023 14:27:12 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F6E1709;
	Thu,  6 Jul 2023 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688653631; x=1720189631;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0lsDIQCktPh9QA9/zZokGduT9I24OJd1INfrPVJo5mw=;
  b=GCWwum310pCk+FKATwD868wJyloFepBzIIJQWBGfksZS6c2hm/pq1DED
   sr2uZdj8e//wKJPB9jP4rSyLBKyTyDehidqJ3sbt3+JnOBT1f/2kYYJZK
   81JNLITTuD3mtoPKK7XPk+VPy3ELCqKKoWYSEgyNy73XCRr79EQ4You4n
   142aCzGepOO+TDuMpja2yIuyG0+sELZgin54cGPJqrV+QI+4b5H1PS+y7
   lm0+vhoxzVkn2ov/2KJJKp0ArkQVsrH0e1+0jBZpcdPBOZmu9TENo1L3M
   OHCOSqgDw5iuMq3xj2UnHgz6QtMLL2bQ4UuZySNJPytd617qu1bXj+FTz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="343945973"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="343945973"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 07:27:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="893563866"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="893563866"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2023 07:27:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 07:27:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 07:27:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 07:27:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sp1eX2Ws5mmySO4P2taEisdG6keExljT4fbrvWfuhL7Zl+iDag0xi0XJH3UtKd7RYFa0UHkv5DrafBkhqy/MBSa+wgnrjlL81utNGHbwOFpCPogVtODiuLIPmoyrqPCx7iIq7aAeP6kHrAykTnYcHr/9WMAIEkx2mpNychvawf65i3C1LnhAXzaa8hazM/tP1eOwWsE4YX4bKi8W4ZpyZ/8IQHvIbOFNwiW/D2UbhRfWWNq7RjN67XJmDf1FlP73OrBvnnXPVkjoa26BLK1ODn20VASv9pDDs7U4+2lrpcgAxUvDd7PovUMrGFkiu0dEHlpTvpRKobMPYKBASrRcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpz83TsRZCTUZ2KqDmozsziUfCAZJw60mb2aPFEep5I=;
 b=GDuJgJqrD7ozlrjDwACo8Xl+Qg7hczGannNWdusU7Br1Vy/3H5f/BqMrHwiduabSnPi5nK3wH3uOT2W4lM20/IEyFnYwoRRmgvKWRBKQX8P7Mc2c+J0553H/OnxanTnzEqOlbbHh0Hw+XujG4vErlpdGN3r2PeQjktxDR26RODgd16p2cxVH4Qbr7DEKVEmvjRmE/mW6paEx3EXJ2DrjaThyTRejYINaD6cJMzIpbNtBVGuj8fUDQ/4kFvEsn1DzQqlzOa5xP5RNpwl/9e+xILk3F0FhIObT/440IGsMtM0qNkKRBLXqxPlm91smCgU15TS0kmBRUjHyGY/dshTPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB7569.namprd11.prod.outlook.com (2603:10b6:510:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 14:26:59 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:26:59 +0000
Date: Thu, 6 Jul 2023 16:22:59 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Jesper Dangaard
 Brouer" <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 06/20] ice: Support HW timestamp hint
Message-ID: <ZKbOQzj1jtDeaaMp@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-7-larysa.zaremba@intel.com>
 <ZKWo0BbpLfkZHbyE@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZKWo0BbpLfkZHbyE@google.com>
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 67272971-a065-452a-8d24-08db7e2d0e85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pXhSJAzVyVWQ0FQ6Tv7JHCh2g+1uX0oUaL0oXPD8Jhxs7YGsdnCbLoCHzwAZa8EVFUoM2E7IndDibAH04wzEeci/oUzosPEbnNO9kxmlsZ/2hyVHIzNtv4ZP/ULyAppULvcKId6tdCwrgE7/A+WU/dQLvsy7Qs9S8HS7vlRmfpd5gAj8UyuvMr9ENIa/T4ZnogGNlnHabSTETCrASR2kPtxabOKzk1M/gnolm0tjpido7wqEwAtPMDfPosQSBiZ9A5TRcPNF8PgF1P/SBgYXEvpTqJr+qK8D6DxCM81k8d1mBPTjBwVtzLdWUp7WtXoYQvdGo+LNHs8TZGWjJmhdEXYcO/7teEHV+A786SiOUwnXomKDj6H/OeGtqa899jp7bfnBg/sL4f64KqgDXyqfsqrnrIUgQmiwuO2JVUPy+Njsmo3KF4+oDALnoCTtVVWdIhJAF8i7UVQ2wkwwgUK3vmkN5rFCN++OQxk0EscS2mF08fQxD3+8BIY1Z3mjeVHRGLojOOqmLD1b9agEWW+XYcIdQ2n8trUozU8VcnAKGdGebEK2nKGQ1ZDSYJoYWgz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199021)(4326008)(66556008)(82960400001)(54906003)(6486002)(41300700001)(8936002)(8676002)(66946007)(38100700002)(316002)(6916009)(66476007)(478600001)(83380400001)(186003)(9686003)(6512007)(6506007)(26005)(86362001)(33716001)(7416002)(5660300002)(44832011)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+2g0lNu/VxeRwEjXAs+DXVRNGskD94oaqc6dnVj6tXmlfcZ3gJZ78xvDAvat?=
 =?us-ascii?Q?9VjjCsBLGP3srCTzpQqAER48FtmntxK7PSPS35TA/Stv/qQknaAUZpeKMXDq?=
 =?us-ascii?Q?mG9RhVTdqgTD2g1DyMjIKlQZyaxGeLaJ9f3QBWkIs3xe+UV2zjS2yPSC7ZYN?=
 =?us-ascii?Q?qlczoHY4WAMQWa86qT/volxlmsJcT+9wd7UQ/BwFgPPuvHYml9qLxwDjJRHg?=
 =?us-ascii?Q?0XFrwNyFLMrnIWIAaTKQ/lN4bI/IrFjP6SSK+RQyXAUOf4rtT7Jfax/LTgZv?=
 =?us-ascii?Q?Apk+y5nXmcNESGJYpwRztPyHpsE3hRMe9pI0ZMA9xSQyi5bit/s6xxsyo0kf?=
 =?us-ascii?Q?NGjFOLJIQ38qDc2JeH/CRiZViL5jOpxLLZ8GHL2Jeou6aufKRFlV1nUBpYNk?=
 =?us-ascii?Q?zdH7/9Ydll9hA9Xv91gjXMhEs8U+DwtgFLTSXgKHmafXDz8Cy7i1EGbpE55K?=
 =?us-ascii?Q?BeQSvnn9g+q6fuqHeE0RhnXoxTApPZ3nqeHCyBbhGDyr37DZyNZaD94AGcuM?=
 =?us-ascii?Q?erGLBueHlDdb8Vnprx7O0dEJtTyZaFLnpCUD6V6SeZt0udJx0AJY/OWhaVIo?=
 =?us-ascii?Q?zmd/CjpIcksI0mizoatyCo+gAE1yS9pg46/bgPAGoMZvO8B/zHZxGDxQJWDS?=
 =?us-ascii?Q?uXjEhQ7gViogQMRYO4zNAhlfJWUIEW040HYraiFe8dKMZI9kiNsOVCHdZlOn?=
 =?us-ascii?Q?7RShSGPU8AWBaSCmK++3DPxbYJ9fuHWVui0NmUMp8kweC6DGuDjFovAZFQQy?=
 =?us-ascii?Q?YYEw5sVk3jGlyhk5GH58fmKm8qc1K1T+cDfe310c3CQgljhlS4Qc98btI2zk?=
 =?us-ascii?Q?Su0Eg8fgpk+m65bx4HHu7JFnei+92IHjpNMJkN9EB8a9U3EeHW73+j9Tr1Ce?=
 =?us-ascii?Q?8noK+vQ9ogKTEtxHDL3BjcZD8nsl7YxrKPk3HzNn1a0XqpwXtBpML2oygdur?=
 =?us-ascii?Q?s8tofAoAzGDZij/0wnMLLrDO7ApTV/ftHlrBsBgNE5OLvHcEHjYRgOLzO6NE?=
 =?us-ascii?Q?EOkbI0WAEMxkWyWOr9M6/3/s30LAYICa8eWC3JjTFUgepRjzXP9s48GfNhVT?=
 =?us-ascii?Q?2BWJHxcYwcrLmChailLHKd2RmwuwYxuGQ9HdpL5of1yCE0xBRcItmY7D09eq?=
 =?us-ascii?Q?xRGIEgK3iZNSGLhuh8kIVlYR/34tlvpTmWq57IZfr1q8xiw3CIk58xN5OK15?=
 =?us-ascii?Q?NXTKWL1mqxt+N3OybN7gqw5hdYP5IAAju9eVwWeyO89rs1wR4wAFASVa6CeU?=
 =?us-ascii?Q?4qGcG2XiN8G7kk5v9niYBwVVOMXuVKXehmIa9ffGum2C52joP0KcAy/J1wAT?=
 =?us-ascii?Q?Nv78vIso7OGRisoblhAFeX1OOq/JUIHVoEl4GbTLsiWUXEldvyB/UdgL+qGt?=
 =?us-ascii?Q?DnasTGUwTi7AFOyw409mE783rmJdobD4TLrJFoFI5Yc3Wrh+lvDFqhgIu52G?=
 =?us-ascii?Q?zoXZH2/JBrztAZcJaUKQI38AZtLJT8Dm1u0mR9Np6s3u0hnXOzx0h6oMHHi1?=
 =?us-ascii?Q?HsKaMX4sz488RqSIuFdqhhWK67wMd2Aw9oO8XgW2UC0mWYrnfaRExF5v1t7V?=
 =?us-ascii?Q?zQa3MBuGTmaN1dBiuatOk/Y7pU4HnTxUoSzTDGXyZl+y/DSl1A9EzkutD5xx?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67272971-a065-452a-8d24-08db7e2d0e85
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 14:26:59.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00nbVw/D4UQbIfd/esYnAxIbsjHXlpYjv2sxACHgAmB6SgK2Zg7JafV414Tyz0fneFBzj2Ej3GtD2ozNQIqOw+gd/wrypDz8TjsF4i8/sUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7569
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 10:30:56AM -0700, Stanislav Fomichev wrote:
> On 07/03, Larysa Zaremba wrote:
> > Use previously refactored code and create a function
> > that allows XDP code to read HW timestamp.
> > 
> > Also, move cached_phctime into packet context, this way this data still
> > stays in the ring structure, just at the different address.
> > 
> > HW timestamp is the first supported hint in the driver,
> > so also add xdp_metadata_ops.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice.h          |  2 ++
> >  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 +-
> >  drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
> >  drivers/net/ethernet/intel/ice/ice_main.c     |  1 +
> >  drivers/net/ethernet/intel/ice/ice_ptp.c      |  2 +-
> >  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 24 +++++++++++++++++++
> >  7 files changed, 31 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> > index 4ba3d99439a0..7a973a2229f1 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -943,4 +943,6 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
> >  	set_bit(ICE_FLAG_UNPLUG_AUX_DEV, pf->flags);
> >  	clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
> >  }
> > +
> > +extern const struct xdp_metadata_ops ice_xdp_md_ops;
> >  #endif /* _ICE_H_ */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > index 8d5cbbd0b3d5..3c3b9cbfbcd3 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > @@ -2837,7 +2837,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
> >  		/* clone ring and setup updated count */
> >  		rx_rings[i] = *vsi->rx_rings[i];
> >  		rx_rings[i].count = new_rx_cnt;
> > -		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
> > +		rx_rings[i].pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
> >  		rx_rings[i].desc = NULL;
> >  		rx_rings[i].rx_buf = NULL;
> >  		/* this is to allow wr32 to have something to write to
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index 00e3afd507a4..eb69b0ac7956 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -1445,7 +1445,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
> >  		ring->netdev = vsi->netdev;
> >  		ring->dev = dev;
> >  		ring->count = vsi->num_rx_desc;
> > -		ring->cached_phctime = pf->ptp.cached_phc_time;
> > +		ring->pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
> >  		WRITE_ONCE(vsi->rx_rings[i], ring);
> >  	}
> >  
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 93979ab18bc1..f21996b812ea 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -3384,6 +3384,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
> >  
> >  	netdev->netdev_ops = &ice_netdev_ops;
> >  	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
> > +	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
> >  	ice_set_ethtool_ops(netdev);
> >  
> >  	if (vsi->type != ICE_VSI_PF)
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > index a31333972c68..70697e4829dd 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > @@ -1038,7 +1038,7 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
> >  		ice_for_each_rxq(vsi, j) {
> >  			if (!vsi->rx_rings[j])
> >  				continue;
> > -			WRITE_ONCE(vsi->rx_rings[j]->cached_phctime, systime);
> > +			WRITE_ONCE(vsi->rx_rings[j]->pkt_ctx.cached_phctime, systime);
> >  		}
> >  	}
> >  	clear_bit(ICE_CFG_BUSY, pf->state);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > index d0ab2c4c0c91..4237702a58a9 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > @@ -259,6 +259,7 @@ enum ice_rx_dtype {
> >  
> >  struct ice_pkt_ctx {
> >  	const union ice_32b_rx_flex_desc *eop_desc;
> > +	u64 cached_phctime;
> >  };
> >  
> >  struct ice_xdp_buff {
> > @@ -354,7 +355,6 @@ struct ice_rx_ring {
> >  	struct ice_tx_ring *xdp_ring;
> >  	struct xsk_buff_pool *xsk_pool;
> >  	dma_addr_t dma;			/* physical address of ring */
> > -	u64 cached_phctime;
> >  	u16 rx_buf_len;
> >  	u8 dcb_tc;			/* Traffic class of ring */
> >  	u8 ptp_rx;
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > index beb1c5bb392a..463d9e5cbe05 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > @@ -546,3 +546,27 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
> >  			spin_unlock(&xdp_ring->tx_lock);
> >  	}
> >  }
> > +
> > +/**
> > + * ice_xdp_rx_hw_ts - HW timestamp XDP hint handler
> > + * @ctx: XDP buff pointer
> > + * @ts_ns: destination address
> > + *
> > + * Copy HW timestamp (if available) to the destination address.
> > + */
> > +static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
> > +{
> > +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> > +	u64 cached_time;
> > +
> > +	cached_time = READ_ONCE(xdp_ext->pkt_ctx.cached_phctime);
> 
> I believe we have to have something like the following here:
> 
> if (!ts_ns)
> 	return -EINVAL;
> 
> IOW, I don't think verifier guarantees that those pointer args are
> non-NULL.

Oh, that's a shame.

> Same for the other ice kfunc you're adding and veth changes.
> 
> Can you also fix it for the existing veth kfuncs? (or lmk if you prefer me
> to fix it).

I think I can send fixes for RX hash and timestamp in veth separately, before 
v3 of this patchset, code probably doesn't intersect.

But argument checks in kfuncs are a little bit a gray area for me, whether they 
should be sent to stable tree or not?

