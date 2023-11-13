Return-Path: <bpf+bounces-15004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28A97EA0D0
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 17:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB291F21AA5
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9322304;
	Mon, 13 Nov 2023 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sy62F3TH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14A021A1B;
	Mon, 13 Nov 2023 16:01:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D469910EA;
	Mon, 13 Nov 2023 08:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699891272; x=1731427272;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7lSi1GKCziFgwFI9O7qdwZdW+h4CapGlxCZ8QhC4REc=;
  b=Sy62F3THEdPyRCW1ziZgzeWtLYo1J1nTP6XEwzZ/QWKo93wP9xCYK13M
   hymHSCYUU8mD6dQ8vnhmK33hof/fgLhBbW+vMriY3lKrF7RF4gCUClmi4
   d89dofNpU7FPvmAwlko8nNZAp6B4gd9lPDBXu+x602Wh9jGlx+ynYgo/N
   Hpg3U+VOENqKKY4tKoQ8eVTHDbjELvcEhpDk5WtJF24NWlGAt5skOkyaM
   Y3SzrDP+ULvjn4Rkd7myA7BePu4l3ZgQiZPLcusJZPVtmjWfGhMgvFG+4
   kjp7RaBHKSS2fRhFSEYQZdFby3DPv/oTADQo7DiCzAjEzWNCQLNwqqbOa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="476677412"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="476677412"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:01:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="740807095"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="740807095"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 08:01:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 08:01:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 08:01:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 08:01:04 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 08:01:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJ8GwToxKMMkJSTrmMHHRJtsAfa/VyiikKaV/C9GtRbzoNvelpWC5rjTwb5R6XV9gyeVIz4z/k2H2JNaIEfwjQ8togvhw5/ZJVg9pu10bqgmOMWpAnI1VImL/l+A3e/P8AZ5l8bEdNWA4TTQKd/AvpJVmoeBcCipjwwy/iBrIRMr0CyoYR4OwYQjshLCBdvcufMLNZiATKP5YsspC3zBprtwuyr2xAV9M3lVfr+EaF9ZCUhiZ2FUgzdaxOeAOfGc9kiSYWtoZpuXM83bnfnJs8nKdbi21CT6p5FP2RYDcOi3w4bOGp2WDgSZ7gzcNWhTWLmjluK4iok33wWGj5Kbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmB6CRy72rQbyy6X+ihnERL8pzgYjCoOSsLvrZD0PbM=;
 b=LiCfGwcdOwn6Ji3XxbOqgBX+0INx5KulODVVP2bURp/5/WiWhnTxf8tWd0Gh6KEPYp7kNXNpQZIRihvwcYR8zEtNU7g2yCux7cSYbswqyEsyQwYqSPns+I7fIcmv9AJ7kWA3cERPtekLLXz7e/MnkA8a4RhyCYZsFJMlpd476W4/SBoVLai3HgVXqxgMYGFxyUgPyA+0pYxs+XCnFDcOMTq8cAcKQTRB/+Yrj7AEcZVXFYBfsK26PF3n0pVHV9xUR4P4cKKJ6wpYYL1c6gnCw3AUcovsOnSX1Jip+NmUAVJU9jSes/KrECngYUNUhrcP0H8Zd+VDAzDpY1OGZwcvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA0PR11MB4703.namprd11.prod.outlook.com (2603:10b6:806:9f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.29; Mon, 13 Nov 2023 16:01:02 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 16:01:02 +0000
Date: Mon, 13 Nov 2023 17:00:50 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <netdev@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Wang
	<jasowang@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>,
	<virtualization@lists.linux-foundation.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 16/21] virtio_net: xsk: rx: introduce
 add_recvbuf_xsk()
Message-ID: <ZVJIMgc+VnrDm0uj@boxer>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-17-xuanzhuo@linux.alibaba.com>
 <20231109031003-mutt-send-email-mst@kernel.org>
 <1699528306.7236402-5-xuanzhuo@linux.alibaba.com>
 <ZU0IOQQB5WJzJezw@boxer>
 <1699583884.626623-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1699583884.626623-1-xuanzhuo@linux.alibaba.com>
X-ClientProxiedBy: WA1P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA0PR11MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: c7dd1708-6caa-4a46-c147-08dbe461bbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhdzvAYduFKgc18YRqZPj3JkJJGnPDNEbzlM4hJC5gJU9VE2ogr+7pJv/WyOlsez8zow48twU8303gb7Mqh4iaLe1Jrxgd/fznnoffWxH7w/1dthwKZX+L6SbQ9nrJkG0PA56VKy9KBFRaexSfWKwHhnWpgYcLbTPdqVNAQ0c8QhqRtDiDBMvAMZWVqqLGPuKyfAr3cqiOKgjsCuW0SIQ5hZqvyx5G/rMvAV7CWA8g1v3CdGcJqzII++YNLnRUgGg7L5fImIPbjMIHyb55wkGVdXbyn0xTPw3KB6ekGWXDow1DuCC3Vx6XSiOdT1fsDkYFAcCvrqM49M+9h4Atad/JotEU3UfQmwnLcYW6fwt4hiPwcvLJ/TS9oAinTrORJhp8URO/eDCLrJu7N8cEhO4LxF+yHafbHh1hb9Yqxb7prSeKHNGMoLLhb0Yl4ONe8DepqMxRoj6YrQExRBuXxpCr755c/2B7o/Ld2BGSHTY3eNsvBbacAjG7HZNflSZX6SaviLHJVrg+u2CHuNMGXFmchFNwSuLMm4VQIOMbMcmkZ6fuC29llijGR8mFAcciYmxGXDVnC3UcxIYc4Nw12NtpiAkskBbVAx8qJzuPA6PUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(6666004)(6506007)(33716001)(9686003)(6512007)(83380400001)(44832011)(4326008)(5660300002)(7416002)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(54906003)(6916009)(66476007)(66556008)(66946007)(82960400001)(86362001)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?szGqya/46gl7OvOWggLmx1SNXuJcu4kMX+KbB+oJCaVRSFD5GFwjqs3cbn2K?=
 =?us-ascii?Q?eHqZl+j6PmwnkLh5wzP8Q6l1GhjLkO95a27ETzK299sbeWA+UUrzjH/2s89j?=
 =?us-ascii?Q?Tey6K7Ke6TKsapCAPKB75VC7EBSYFphSfcMldV7FDHeomrA2JOQv3/29HAgb?=
 =?us-ascii?Q?cZP7peEsPveNHbGNQjFG1LYlV/Q5LPDrAyPoosiI2i9W6foKt7l2uvXveJkV?=
 =?us-ascii?Q?y+IRc85hsuT0Oni4aglq0p/Wmq5dE0kTxuSBQSWc3ensX689cIIjyJzFTzPa?=
 =?us-ascii?Q?sOHoQOkI3l2wJi67ELJJM+h5jQy0nQFf9PdhEUXZ5pGqndM137KWp6A5dw/V?=
 =?us-ascii?Q?r2z2o9Ex64jLS71KxMgrenlKq5mSvgmXegRqzNO8Rc1a6A40MCFH2Mtg/GJi?=
 =?us-ascii?Q?xfOpI/fdyz8K9A0PddcCKx/q1+IUBiqDz92mJFRN2LJi23wf5Tg8EXwTKOPz?=
 =?us-ascii?Q?sdQZBT1thb0liGYBuNMQQkAgTWlSXc9mfPvsA7ALWVShOAcwzuXrGh3Mj/Ec?=
 =?us-ascii?Q?6eBXeNRR5aentcDjc0wufTJ6bzAjDg0Wbz0fZEwrrfvYBZDAYXpFDqLSzzpl?=
 =?us-ascii?Q?9cokqGAd9hYVQqXKOHI4A/Xd0fd6ux5mwQCSv9PMh8EivWxAAejHPRKN3BJF?=
 =?us-ascii?Q?KLe8+rCbXhHQW4IEJpgtaQ6r5z9J+cAZY0HkmShGuS3KqGTMjPgL0lGlymr7?=
 =?us-ascii?Q?KxZgjNO1AjB2Yk26o0VuuCZmkrbyz23RULZbbhTuMvSf5ohxZQ1ecVUgnUMh?=
 =?us-ascii?Q?l23KwGcTIGaQxaXejqD5IjSWZ3NzdNbhGju4PwnyIrfFtkwUTTCrgyUXgpRE?=
 =?us-ascii?Q?X200gOQyjcacvayRj0aVSFRH9/lO3R7Z8Fxv8AvXyrQnDhReGx3ALxn5nnoa?=
 =?us-ascii?Q?6ij7TLzujTMtzzS1QwW1zCHRhaLGX8qhZdxuU+AHjsbmOiXUlwZR68ETJelo?=
 =?us-ascii?Q?cYtwn2GsB4tXrfEVPzj0QE69T1hxeV5Wiq4OLJYKaGqlaaqgqo5D5EcsPJGg?=
 =?us-ascii?Q?RgIjb+ta8+jJJCQyyfhZJr8U/zWq2hGO19XPjBU3O+e/ISc8/S1+DtqnetZB?=
 =?us-ascii?Q?CrBz8CBzCWpZ0laKypH9OE/FRp9zBL8TZvKuCKNBhZswUI88GIm7P/2BmyUN?=
 =?us-ascii?Q?XJV1lT94HtbZgm0tyWAh9qqVznrPeBOT/sIbWcKcM1gGQvHHl5tlgQ8MiF72?=
 =?us-ascii?Q?/cGXvjplVIqNtF9CWpra7NDqy7raQsmPlMnp+WhyOUsc/RA9DIIapKsJVmSv?=
 =?us-ascii?Q?FQfg2O7MSQi2sYnxoZI8w6md61Di4wz5ZS9Z5UICPyqeFLpQOLbiWAXcZqvK?=
 =?us-ascii?Q?q3oI03qczQwKRVmZ9L9LWhaurWKccujnvZqazjBjucFexD9fbk4gu1u/TPpK?=
 =?us-ascii?Q?x4RnQzzmYE/BTWH8WdEF3xXKvHNg0+nM57AFcYTqhPtOQoEFQNLC1WHIgy7Z?=
 =?us-ascii?Q?HqWHumQqCC9hLCYL/umOqqWAmX+We9kjGdy4PLP5ZlgOpkRWqkB+XyFfdLWX?=
 =?us-ascii?Q?zbOXBy94SfBRu8f8MJW/F1czvvlhrr2vigc5pJdbt7pLU42CZa74MtEyd6eo?=
 =?us-ascii?Q?8DhcsgCipwbqtuier5kM3Yy2RxTuqojP3e1HXbzdqU+vgL4aMKgxJirAHWAY?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dd1708-6caa-4a46-c147-08dbe461bbef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 16:01:02.1963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2wqGRdx3kvagzwXlhzrPwk0yBCDdrt4Dg7qo32V3dQ6cfPaVxU1X1fByfF8aq8tJOosC9mZ35LISc34M8YZ1SSYlpRh8irdV6ckNQhJ9xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4703
X-OriginatorOrg: intel.com

On Fri, Nov 10, 2023 at 10:38:04AM +0800, Xuan Zhuo wrote:
> On Thu, 9 Nov 2023 17:26:33 +0100, Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> > On Thu, Nov 09, 2023 at 07:11:46PM +0800, Xuan Zhuo wrote:
> > > On Thu, 9 Nov 2023 03:12:27 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Tue, Nov 07, 2023 at 11:12:22AM +0800, Xuan Zhuo wrote:
> > > > > Implement the logic of filling rq with XSK buffers.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio/main.c       |  4 ++-
> > > > >  drivers/net/virtio/virtio_net.h |  5 ++++
> > > > >  drivers/net/virtio/xsk.c        | 49 ++++++++++++++++++++++++++++++++-
> > > > >  drivers/net/virtio/xsk.h        |  2 ++
> > > > >  4 files changed, 58 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > > > index 6210a6e37396..15943a22e17d 100644
> > > > > --- a/drivers/net/virtio/main.c
> > > > > +++ b/drivers/net/virtio/main.c
> > > > > @@ -1798,7 +1798,9 @@ static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq,
> > > > >  	bool oom;
> > > > >
> > > > >  	do {
> > > > > -		if (vi->mergeable_rx_bufs)
> > > > > +		if (rq->xsk.pool)
> > > > > +			err = virtnet_add_recvbuf_xsk(vi, rq, rq->xsk.pool, gfp);
> > > > > +		else if (vi->mergeable_rx_bufs)
> > > > >  			err = add_recvbuf_mergeable(vi, rq, gfp);
> > > > >  		else if (vi->big_packets)
> > > > >  			err = add_recvbuf_big(vi, rq, gfp);
> > > >
> > > > I'm not sure I understand. How does this handle mergeable flag still being set?
> > >
> > >
> > > You has the same question as Jason.
> > >
> > > So I think maybe I should put the handle into the
> > > add_recvbuf_mergeable and add_recvbuf_small.
> > >
> > > Let me think about this.
> > >
> > >
> > > >
> > > >
> > > > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > > > > index a13d6d301fdb..1242785e311e 100644
> > > > > --- a/drivers/net/virtio/virtio_net.h
> > > > > +++ b/drivers/net/virtio/virtio_net.h
> > > > > @@ -140,6 +140,11 @@ struct virtnet_rq {
> > > > >
> > > > >  		/* xdp rxq used by xsk */
> > > > >  		struct xdp_rxq_info xdp_rxq;
> > > > > +
> > > > > +		struct xdp_buff **xsk_buffs;
> > > > > +		u32 nxt_idx;
> > > > > +		u32 num;
> > > > > +		u32 size;
> > > > >  	} xsk;
> > > > >  };
> > > > >
> > > > > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > > > > index ea5804ddd44e..e737c3353212 100644
> > > > > --- a/drivers/net/virtio/xsk.c
> > > > > +++ b/drivers/net/virtio/xsk.c
> > > > > @@ -38,6 +38,41 @@ static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
> > > > >  		netif_stop_subqueue(dev, qnum);
> > > > >  }
> > > > >
> > > > > +int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
> > > > > +			    struct xsk_buff_pool *pool, gfp_t gfp)
> > > > > +{
> > > > > +	struct xdp_buff **xsk_buffs;
> > > > > +	dma_addr_t addr;
> > > > > +	u32 len, i;
> > > > > +	int err = 0;
> > > > > +
> > > > > +	xsk_buffs = rq->xsk.xsk_buffs;
> > > > > +
> > > > > +	if (rq->xsk.nxt_idx >= rq->xsk.num) {
> > > > > +		rq->xsk.num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->xsk.size);
> > > > > +		if (!rq->xsk.num)
> > > > > +			return -ENOMEM;
> > > > > +		rq->xsk.nxt_idx = 0;
> > > > > +	}
> > > >
> > > > Another manually rolled linked list implementation.
> > > > Please, don't.
> > >
> > >
> > > The array is for speedup.
> > >
> > > xsk_buff_alloc_batch will return many xsk_buff that will be more efficient than
> > > the xsk_buff_alloc.
> >
> > But your sg list just contains a single entry?
> > I think that you have to walk through the xsk_buffs array, retrieve dma
> > addrs from there and have sg list sized to the value
> > xsk_buff_alloc_batch() returned.
> >
> > I don't think your logic based on nxt_idx is needed. Please take a look
> > how other drivers use xsk_buff_alloc_batch().
> >
> > I don't see callsites of virtnet_add_recvbuf_xsk() though.
> 
> 
> virtnet_add_recvbuf_xsk is called by the above try_fill_recv()
> And the loop is in there.

Ah sorry I was looking for another patch to call it as it used to be in
v1.

> 
> Jason want to reuse the loop of the try_fill_recv().
> So in this function I just consume one item.
> 
> The nxt_idx is used to cross the try_fill_recv.
> 
> If we drop the nxt_idx. This patch will like this:
> 
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 6210a6e37396..88bff83ad0d8 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -1797,6 +1797,15 @@ static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq,
>  	int err;
>  	bool oom;
> 
> +	if (rq->xsk.pool) {
> +		err = virtnet_add_recvbuf_xsk(vi, rq, rq->xsk.pool, gfp);
> +		oom = err == -ENOMEM;
> +		if (err > 0)
> +			goto kick;
> +
> +		return err;
> +	}
> +
>  	do {
>  		if (vi->mergeable_rx_bufs)
>  			err = add_recvbuf_mergeable(vi, rq, gfp);
> @@ -1809,6 +1818,7 @@ static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq,
>  		if (err)
>  			break;
>  	} while (rq->vq->num_free);
> +kick:
>  	if (virtqueue_kick_prepare(rq->vq) && virtqueue_notify(rq->vq)) {
>  		unsigned long flags;
> 
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> index a13d6d301fdb..184866014a19 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -140,6 +140,8 @@ struct virtnet_rq {
> 
>  		/* xdp rxq used by xsk */
>  		struct xdp_rxq_info xdp_rxq;
> +
> +		struct xdp_buff **xsk_buffs;
>  	} xsk;
>  };
> 
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index ea5804ddd44e..73c9323bffd3 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -38,6 +38,46 @@ static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
>  		netif_stop_subqueue(dev, qnum);
>  }
> 
> +int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
> +			    struct xsk_buff_pool *pool, gfp_t gfp)
> +{
> +	struct xdp_buff **xsk_buffs;
> +	dma_addr_t addr;
> +	u32 len, i;
> +	int err = 0;
> +	int num;
> +
> +	xsk_buffs = rq->xsk.xsk_buffs;
> +
> +	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> +	if (!num)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num; ++i) {
> +		/* use the part of XDP_PACKET_HEADROOM as the virtnet hdr space */
> +		addr = xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len;
> +		len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;

len can be pulled out of loop...

> +
> +		sg_init_table(rq->sg, 1);
> +		sg_fill_dma(rq->sg, addr, len);

... but when I first commented I did not understand why you were not
passing dma from xsk_buff_pool like this:

	sg_init_table(rq->sg, num);
	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;

	for (i = 0; i < num; ++i) {
		/* use the part of XDP_PACKET_HEADROOM as the virtnet hdr space */
		addr = xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len;
		/* TODO: extend scatterlist size in receive_queue */
		sg_fill_dma(&rq->sg[i], addr, len);
	}

	err = virtqueue_add_inbuf(rq->vq, rq->sg, num, xsk_buffs, gfp);

and now I see that the problem is with 'data' argument above (or xsk_buffs
in this particular example).

Why do you need to pass xdp_buff to virtio_ring? You already have the
rq->xsk.xsk_buffs which you can use on rx side.

Can someone shed some light on it?

> +
> +		err = virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[i], gfp);
> +		if (err)
> +			goto err;
> +	}
> +
> +	return num;
> +
> +err:
> +	if (i)
> +		err = i;
> +
> +	for (; i < num; ++i)
> +		xsk_buff_free(xsk_buffs[i]);
> +
> +	return err;
> +}
> +
>  static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
>  				struct xsk_buff_pool *pool,
>  				struct xdp_desc *desc)
> @@ -213,7 +253,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>  	struct virtnet_sq *sq;
>  	struct device *dma_dev;
>  	dma_addr_t hdr_dma;
> -	int err;
> +	int err, size;
> 
>  	/* In big_packets mode, xdp cannot work, so there is no need to
>  	 * initialize xsk of rq.
> @@ -249,6 +289,12 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>  	if (!dma_dev)
>  		return -EPERM;
> 
> +	size = virtqueue_get_vring_size(rq->vq);
> +
> +	rq->xsk.xsk_buffs = kcalloc(size, sizeof(*rq->xsk.xsk_buffs), GFP_KERNEL);
> +	if (!rq->xsk.xsk_buffs)
> +		return -ENOMEM;
> +
>  	hdr_dma = dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO_DEVICE);
>  	if (dma_mapping_error(dma_dev, hdr_dma))
>  		return -ENOMEM;
> @@ -307,6 +353,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
> 
>  	dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, DMA_TO_DEVICE);
> 
> +	kfree(rq->xsk.xsk_buffs);
> +
>  	return err1 | err2;
>  }
> 
> diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> index 7ebc9bda7aee..bef41a3f954e 100644
> --- a/drivers/net/virtio/xsk.h
> +++ b/drivers/net/virtio/xsk.h
> @@ -23,4 +23,6 @@ int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
>  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
>  		      int budget);
>  int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
> +int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
> +			    struct xsk_buff_pool *pool, gfp_t gfp);
>  #endif
> 
> 

