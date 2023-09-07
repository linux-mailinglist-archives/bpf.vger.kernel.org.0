Return-Path: <bpf+bounces-9414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987DD7975C6
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 17:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29909280DB5
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5935D12B9C;
	Thu,  7 Sep 2023 15:54:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F912B80;
	Thu,  7 Sep 2023 15:54:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F2976A8;
	Thu,  7 Sep 2023 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694102068; x=1725638068;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n+jy+giGEyjxIVs+YDHmZrBeTKvYfhkr9puwm9envbI=;
  b=BQWITxa9HkxGfj+XJIoJAriinyj7Q6KUwixEIbWCIrGOsrKkU084cuZl
   jWyzH42vkMTpqA99tVA3LS2LbaZtqwMLyHoLbSK8Tx2V2ivZucHiA5bb5
   wEvc3qiVH+KysCFhZ0tUZPCrPlrL7q6qfIy5Tu+tsYRNmZV4UoEaF/CpT
   xJLgTXhSHlpixdAkYP05DJyM64l6VUfjPA5ekhIXMIlWaR/RmcqXWwIzz
   6ELfOgFbvh4YWJtS1rpYR4IndfoFyYm/ujjmQvcMjJ6h9g8I1Rqur+BQw
   qvD/ompVD6qhoFyPZqW6tphKxDou53hUWvYdmlT84B4Os7KShvM9w9H1n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="356841562"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="356841562"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="718712030"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="718712030"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 07:27:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 07:27:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 07:27:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 07:27:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 07:27:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mskbN1QDEATwMYqj7Za09koYsGgeyj38Ll1cM2p1LVCC4XyC8EgAER6J6ZbA58TqnMEu3MCag05+eqKVUh16J2gY3z28XcRsP/Fn2k79wAc8oTZPuFYsMQbbqCezRCeJBMxCeIWbJcQfLKp6PPprPEbORSCF3hUqcSX/QEOMZGktzimFDrjgR80C9TBq/NSR50klEZ3XZaoxgIBBbXepTWuwe/gog8Du0XrW/IrkLTWxGgmzL28xJ7ybeVUoaPNQTQJCQH7OrphoIGjH99RObj3EB7boRqhhnSxKpF5xvhy41kXFdglP9lB8w+XJFv6m153ACV204LiIm/YXeNLgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyznePXyLKW5n1m7YOynXeXGgrgRIn9xamFLecqpvHk=;
 b=VlzYunDN7G0Mzz5ADmasEjM4JMq0GmvDkvwaEhrksoymtJc3sZG5oTr5CK3BVHCMSPVQnR8CB4Ul+2xPbhhcdZytUEAe50qRzWe7bYm/3kqKm3R7ZyDt9NgizpZQgUSwXSMHu2yGE6ySG+6n+hnhccJN9h/GNzYlKhI2wEMK9My4krPQ1/aKn50H1YYw7QFrSh54u9t8EEDA1V02/9zB7KZ8JDdkAIhptmTQCU/87kjCSi+XXdF7SmwYeoe3UBChG8NhhFc1nBzl9wDulYiceq+MmOUtZa+KeA/lID10iIcg2OwV7hugzCVt4eCYa3ezPFZd+2LOCWOsTc1zg6y/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MN2PR11MB4520.namprd11.prod.outlook.com (2603:10b6:208:265::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 14:27:14 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 14:27:14 +0000
Date: Thu, 7 Sep 2023 16:21:50 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
Message-ID: <ZPncfkACKhPFU0PU@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-6-larysa.zaremba@intel.com>
 <ZPX4ftTJiJ+Ibbdd@boxer>
 <ZPYdve6E467wewgP@lincoln>
 <ZPdq/7oDhwKu8KFF@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPdq/7oDhwKu8KFF@boxer>
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MN2PR11MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a71c26-66a1-420e-2c09-08dbafae8701
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVbmnkTsVWxjj9Qf4Zm5qQncW4UqROpwOVcbRi59tYfumIS62jX/Vxp4YodtqUSI5NW30knt96m0UFEwM5MF/V90uIEDRup2k92UtUWNUgdA+op3nwfq70bCAz7L7gcExCuDdtMrmwii279I3pGZfEd0jjJwVLjB5MP5s015bwDMtpbUt7OqI+wN/VHk0fSoWSBRVaf7cysR4qse2RtHZvJJs2JC78jSQ4Xlc65yJBYYUcx78ZbsJmzeVrLq4ycivV3Ynr78gJnD8tzi2gzDzs7/8m6pfu1XCA2IV7oYAGfCKjHrKRzGx0ieM2P8oMLJ89Eu2SVN9a7+HXPp/V58XblqBeKKzNkaoiTWTNy0Dbppi1Xgx/tdzW5k/y2jNwZeerjR1HMEIVv0+uOWo8N5k6Nshrachjy3rVHSBd5SUu0n8y4al2rKGLSMLui2CWZ/D/aARa9CSYP+T6JLh2ThoC2U5vcMxORCFupiRQovaOlkW2WgtCizblVVTlNEcErU9xvK/adAcu+LZUDRKWkwfEEL96eVPNySLAXaD+WYMHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199024)(186009)(1800799009)(5660300002)(44832011)(6486002)(4326008)(8676002)(8936002)(6862004)(6506007)(66946007)(316002)(6636002)(66556008)(54906003)(66476007)(41300700001)(478600001)(2906002)(966005)(6666004)(6512007)(9686003)(26005)(7416002)(83380400001)(82960400001)(38100700002)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PhWYLOHWPOx93Ao4f5L+gR+/3EyDiZ3Ebn9GtNLFT6R5SXTgEd2yIq6EUthq?=
 =?us-ascii?Q?/Tkje+5v0ksBnzPn+89QDPA8TE+1rA4m9zAMlYCpNApGHkwthawyJ9JDApI7?=
 =?us-ascii?Q?rQn28hqH0WnnlAgtkRa8AQdIWP/4NesyJjTu3AZkdl8tQnK7Ho8y2bQewTJd?=
 =?us-ascii?Q?1rNJlmUR6cMRaQs8si+1ftE0LmZJAfmPR8l0GQjZCYqklGgxy6NpTon/1Nx9?=
 =?us-ascii?Q?q5nG+XKNOFoOQ3PAptl7gT0pGvCnWR+AyZjcJbvLC096CWvtKBr57Hppojtp?=
 =?us-ascii?Q?eOapll3vAaDxHA30yU3II8sHnBjjtJKv6vDGLwQizwM8yEDgUoVddnKNi7DN?=
 =?us-ascii?Q?wlmdO7uFTujbq3CHIAfc2qXQbb6rcPKOyUWv04kxsfhC7EhT0yf6pQUmiQJ8?=
 =?us-ascii?Q?sM+6nfQ18lObMUTvKMB2yJGeGIGo0yrWgt3k6HbR9U2VW2PWY/0AWwsZ6BlM?=
 =?us-ascii?Q?OazZRkGEgy8tpXSd5dJwXA5c9rhwt2t96xPhlpjLeDLcwhf8hIGpHLoaQjdZ?=
 =?us-ascii?Q?st37uge1mfv74Cx6wgn7wCD5e4uW7ESrU1nmlDkQF7N2mbzhBR2E4FF9x+H1?=
 =?us-ascii?Q?t/KX6GTTDZqGSrPZIHAMUg6/pr3VE8ZL/rF6mcJtK63qptVzda8ZDpNMEHjO?=
 =?us-ascii?Q?li8VWxT8p+iWRyvk6Oc6oRRmhQnTfPwgjIbh0nCrnxA3vKPbES0ViRdZo008?=
 =?us-ascii?Q?fnL8m5eXXl00dd4Bgji8T+MqUUgHMdfKlcW/xGyGDRRweyM9UIBSfYyTteok?=
 =?us-ascii?Q?z3TGT7hStZaJ0RdqBaBafkjF2Hh0/OpYLKBcCxIw+m5Nwu5eE5OvXcp4Swdb?=
 =?us-ascii?Q?bWq6aDcC09+yRsrGO2m6y5txmRL+imI65HGrU5E6tMa7jETDQr1ti/zrwxBm?=
 =?us-ascii?Q?E/Q3Sw57Avc2imhv82ukjR62pGgz39pZHezV68UyvKXUDVipUsAtMLgtt5wR?=
 =?us-ascii?Q?8+6AgnHT7oYHeEw943buwSPqfbUUpW5svjmsrRT4VcBdmlE+86RNa8KE4opH?=
 =?us-ascii?Q?LRumrWKXx+vHKC/ywWFGi6bV88LiCbuoHc2f0kHalb6VF0JlpYQLs+GORsM8?=
 =?us-ascii?Q?dXLhsnI+WH0qOjnkVRJqzNrqZ9Itpw6NYe+H+c6ItoT5PhwLmngjq3aBPzwu?=
 =?us-ascii?Q?p95PLeq6RbuttTIHy9pvyI5x6/0e4e6HAyFWwwnIT6CqYx9gW6IRABifWbjT?=
 =?us-ascii?Q?jzVYkcUU1Kc1iMjsVKV/nHaOzJdgCTgwVtr5SCyrUMbqA7IXmcc7F4d/UTfK?=
 =?us-ascii?Q?cFwY8z9Ot+L+ECe4iMlJ3m4Q8ayVuZq5mK++ixNatm+5F5FANmk4h2wHlrKB?=
 =?us-ascii?Q?wVAUW7xEfN+S2SQCXcPS6YsDyOPTR3p93BzaJQiyJ2ZmL2VmdTrUye6saxZO?=
 =?us-ascii?Q?ndFafxYcuy4s2ZQmtIbT17HvN9bjD3Khvjr4Pt3wDp/qXD954xxcBEgkgQYk?=
 =?us-ascii?Q?47RNHmcM143uvluKJ9EgxC682rSfft8+JbBIQIY3uc2D/nYMR4LZqxOjr1Fw?=
 =?us-ascii?Q?zhmfJEnNZiXZX/Es/BAGgo9who10ptfSgRnb17kHT+7lRkn283C/kU1oGC+L?=
 =?us-ascii?Q?wg6XvglSoPhLSgeiBn5X84UpZ85YJHM85JXtrg71q7k/IKjYPCoCk6IGu14l?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a71c26-66a1-420e-2c09-08dbafae8701
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 14:27:13.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5COjnnhG47t5ZgAMSSuVM+caFifRIKVxbHZzpSkkLN5un9IdrxgWpkw+phGOOT3HHrw5E6w0VFybhLgUhJ7t13PK8t1GTv2wuSpN16OFrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 07:53:03PM +0200, Maciej Fijalkowski wrote:
> On Mon, Sep 04, 2023 at 08:11:09PM +0200, Larysa Zaremba wrote:
> > On Mon, Sep 04, 2023 at 05:32:14PM +0200, Maciej Fijalkowski wrote:
> > > On Thu, Aug 24, 2023 at 09:26:44PM +0200, Larysa Zaremba wrote:
> > > > In order to use XDP hints via kfuncs we need to put
> > > > RX descriptor and ring pointers just next to xdp_buff.
> > > > Same as in hints implementations in other drivers, we achieve
> > > > this through putting xdp_buff into a child structure.
> > > 
> > > Don't you mean a parent struct? xdp_buff will be 'child' of ice_xdp_buff
> > > if i'm reading this right.
> > >
> > 
> > ice_xdp_buff is a child in terms of inheritance (pointer to ice_xdp_buff could 
> > replace pointer to xdp_buff, but not in reverse).
> > 
> > > > 
> > > > Currently, xdp_buff is stored in the ring structure,
> > > > so replace it with union that includes child structure.
> > > > This way enough memory is available while existing XDP code
> > > > remains isolated from hints.
> > > > 
> > > > Minimum size of the new child structure (ice_xdp_buff) is exactly
> > > > 64 bytes (single cache line). To place it at the start of a cache line,
> > > > move 'next' field from CL1 to CL3, as it isn't used often. This still
> > > > leaves 128 bits available in CL3 for packet context extensions.
> > > 
> > > I believe ice_xdp_buff will be beefed up in later patches, so what is the
> > > point of moving 'next' ? We won't be able to keep ice_xdp_buff in a single
> > > CL anyway.
> > >
> > 
> > It is to at least keep xdp_buff and descriptor pointer (used for every hint) in 
> > a single CL, other fields are situational.
> 
> Right, something must be moved...still, would be good to see perf
> before/after :)
> 
> > 
> > > > 
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > ---
> > > >  drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++--
> > > >  drivers/net/ethernet/intel/ice/ice_txrx.h     | 26 ++++++++++++++++---
> > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 +++++++
> > > >  3 files changed, 38 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > index 40f2f6dabb81..4e6546d9cf85 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > @@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
> > > >   * @xdp_prog: XDP program to run
> > > >   * @xdp_ring: ring to be used for XDP_TX action
> > > >   * @rx_buf: Rx buffer to store the XDP action
> > > > + * @eop_desc: Last descriptor in packet to read metadata from
> > > >   *
> > > >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> > > >   */
> > > >  static void
> > > >  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > >  	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > > > -	    struct ice_rx_buf *rx_buf)
> > > > +	    struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
> > > >  {
> > > >  	unsigned int ret = ICE_XDP_PASS;
> > > >  	u32 act;
> > > > @@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > >  	if (!xdp_prog)
> > > >  		goto exit;
> > > >  
> > > > +	ice_xdp_meta_set_desc(xdp, eop_desc);
> > > 
> > > I am currently not sure if for multi-buffer case HW repeats all the
> > > necessary info within each descriptor for every frag? IOW shouldn't you be
> > > using the ice_rx_ring::first_desc?
> > > 
> > > Would be good to test hints for mbuf case for sure.
> > >
> > 
> > In the skb path, we take metadata from the last descriptor only, so this should 
> > be fine. Really worth testing with mbuf though.

I retract my promise to test this with mbuf, as for now hints and mbuf are not 
supposed to go together [0].

Making sure they can co-exist peacefully can be a topic for another series.
For now I just can just say with high confidence that in case of multi-buffer 
frames, we do have all the supported metadata in the EoP descriptor.

[0] https://elixir.bootlin.com/linux/v6.5.2/source/kernel/bpf/offload.c#L234

> 
> Ok, thanks!
> 

