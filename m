Return-Path: <bpf+bounces-14597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F607E6EAB
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C27DB20D87
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C6522329;
	Thu,  9 Nov 2023 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgYz8WZ2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5222308;
	Thu,  9 Nov 2023 16:26:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6B5D58;
	Thu,  9 Nov 2023 08:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699547212; x=1731083212;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tuP9rl+W/gx5dXqxVNRU3JymRjbHm8IZ0I0R9d3gvDE=;
  b=UgYz8WZ2m/YvE040DDYChbt0PK0OAnVORLsIUaBLBoqK+CjyxhJTJS9Q
   kmUffeYMjGPDQN4pHCv98StcP2ATwafeltsps0OjlLpmtw0xEFJMZNcOH
   KsWpclyCzuqO7xcZx0EGx4gseg2Tg1WaJZgcSDiYuluKiEWXby2Q8Oo/A
   FDEl4hQvfDzREcwcmsTk8ZFllDKBllg290R4WAgkE+PECvgiEb+pNAqVm
   NeSzFcsdKcOaSuo7Ip3UsZxI6vIY21rHX3AuurVckwIj7hIHObiWmXdUX
   7c9Eb4k/RqoEw8LQhNjL7pAC7GNWkE6y9x/9zZEEz68TrAFW/bEcPOQ7u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="393927535"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="393927535"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 08:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="833876026"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="833876026"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 08:26:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 08:26:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 08:26:50 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 08:26:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atkeasZU2Ivi+uBDPX+nggCeqF0i0lC9pkIRvg9bRySJr5P13ygfbuZusd/aY5Hy703AXo9TpEBUaK324JjRM0JTYVBQwiGuNwQxXRrg+FrWPCmLKJCi2iFQOrK4Etz1dy7Q8HevJgrkXCETdBbRx/ttc0oCQ389QJIPYEkfcVym/fPtfStwPG/LDQxjlVnS+gWWsbmEGKrezu0V9OuJofQhpIRjEg+2ZIbukG3XlbgJuFUHGNKHvwpmh3VYDxp93QLcE70kjAVBNwc6wmkoRpDFacnhbr0jH+W49ZklgYzuUK+gS7VzjA6H7K8uRNWas58VqiyS6bobnYHN3wJ0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elx32CEazyKoFBfvS0DIKnsSsfgAaiD9N1RvgeKt200=;
 b=Etn5sBlGY0srM/UVyPq7ku+ORjm4SQAX9BcIxz1KyCg1akFDIPAlk6L5vWWeLiBTaoK9spNxc1dNWarMVRx9d/9EN2bg7zKx1XBpM6Zwu9D/SCY4G7ONF3fmQlgpGaWHAzXMy3qByH3mxz04v7I9LTWce0j2H4Jp/JiZMOZ70gNyUYFDsM4ecSilHmJ7TybXfieYp+lSicO9toPg+QDjxB7DF/vXZBX+WebjJNtDfh0mU/oXh1qz7q6Fin/DaMu4LnV4W/ZZFrVyPkP2G1RT9baVqTxWmAZhRVsjRnqKJiEFcqa9vpvtwdQ5F1yFoDXVqSSdtzgapV3YGJVrbLWX8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB4966.namprd11.prod.outlook.com (2603:10b6:510:42::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.29; Thu, 9 Nov 2023 16:26:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%6]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 16:26:46 +0000
Date: Thu, 9 Nov 2023 17:26:33 +0100
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
Message-ID: <ZU0IOQQB5WJzJezw@boxer>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-17-xuanzhuo@linux.alibaba.com>
 <20231109031003-mutt-send-email-mst@kernel.org>
 <1699528306.7236402-5-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1699528306.7236402-5-xuanzhuo@linux.alibaba.com>
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB4966:EE_
X-MS-Office365-Filtering-Correlation-Id: db97cdca-477d-4641-5b5a-08dbe140aacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqPA9/FtWsaEUl7FNCoqMaRSK4JhoKJ9GM4W6bO11fhO86ZZOCtjRQ7Qz0EgepAQlHuUU5KqPKbU6ocwOKN5uqD328X1TOnNMVrU6KXSALg2eUOFIEsOTZabO7DoUpQ9GWO38ZOoi5YQFBhqNU1e7BewzgiZP1QLzznxWXG1cl+acXrSsS5YFvsbCgbYwQGvUAoe2Ump37r/noyYrj3KRwc6cPBG6Fb2Dan2F2fEyA360oUO+zaY9hDk0ruAYxOp0Gmxe/6p1mI7xCQC9CxA9ZsIuRUm4oh0Km+ivyqlvcFh+QE4/q4vq3YwEqFvJDuqAMfhzu7Uf1vhb7l9YQm6MtMK8XbIFkcAK1OwlyzuMUh3/xS173YAGFE+sHyJUkRyV3GrdsZVRUrmzBULkP73Hu8nluF+zylXyQHQgL5AUR3Tv7S4V6qdE4sd7A4uKwQ3lWSKLyhGyMzKoGjjX1BbaA4R89J3Y6Mq8WDBf5K1Q99dwYJHNjCT8cP6vqEAhwZHPmDYfW6EOq+JAEJLXyx8DYKaU2Yo+LNlB4TJcV3Qj5Le1tI9GT5petKhdTiHIVOD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(44832011)(6512007)(9686003)(82960400001)(6916009)(26005)(478600001)(6486002)(66476007)(66556008)(33716001)(54906003)(66946007)(316002)(6506007)(6666004)(4326008)(8676002)(41300700001)(8936002)(2906002)(38100700002)(7416002)(86362001)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r5z+ZsPs7pV2oYGqBrJhGTkPAWJjMM09S8atz+FentbHkbLg7EkJjmS2/K3A?=
 =?us-ascii?Q?KsNXLi6Kvwx3+e0DDtgIsZTPfjmfVViWSJy462bfjWqxjVWewirZoo1pNUoJ?=
 =?us-ascii?Q?gChdfTNN/oJ7BgLV29OL7FSxCAqXBptmwMqbKUlFlTNYUIMZRpo1SXzWaelr?=
 =?us-ascii?Q?mkG8PJ5V2qphrhO/YoOuKvOJkqu1l1WxRx1gT04UEtJ/Dz/xQh5/+u6yBIfd?=
 =?us-ascii?Q?DcAPh/tFcOUusC2FjIpdM7k4Kl6b6bY5A8NMgvmYpgUkjtcir4G6jO4irqIN?=
 =?us-ascii?Q?7No3l+9/upfksTf5EBAt7Af8znTGVNA1Y3iAN+DlwHCDXB7TjMNJig2rWJJq?=
 =?us-ascii?Q?r3ZIP92mqC2lnTRAntgDS1kKTXK94H4oCIXY2jOxjJO3MmAAZ3RHScL3LkPf?=
 =?us-ascii?Q?kP5jElKjabGY/jVQxlo3H3Kn6wNkExCt98xIaklD+001NvFqN/qCI01TOKRL?=
 =?us-ascii?Q?jzqpU16SnW0hS5L9T34NIujEfxO4hAEYD/1xgCcReEROYXymmQ680IFejGvv?=
 =?us-ascii?Q?wfD16mwbiGQzQNUuDvBqU01pHhzpM5ZHjJg4ez5WzjO9mYrSZi6U0+xIxqPp?=
 =?us-ascii?Q?QljU3iXggQCQKDoRcIaIEa239Xs0aA1mPekSR/L9CDK759trwsCH1216lNSN?=
 =?us-ascii?Q?PwmcQ/u6YwTF84hvFphiWbu0Tr4KR6Fq7dx4EFS7SxoobCibmX58wsr+TS5p?=
 =?us-ascii?Q?zMDUSxxmCBwwp/7Wpq1QuHyOlam0Q83RhTwPTDZWrZFnMh6criT7X1PwOdhc?=
 =?us-ascii?Q?ZAl9kIQI/gOTDlUDVBPCucPk3nrNs5aBkv/XXHYuHUPz0SEOBZzOPuYXRXT/?=
 =?us-ascii?Q?4PRJnyBMKZ2fOqr1PiJqr4yznlpWC6BQNWeuLz7IMwQ84L5BM9qTyvX8Lgxf?=
 =?us-ascii?Q?3OEZ6j9md7esI5niczo9kS8uh+D8+KhWquNtp7z3y6MqLCWqAW0MaiFq9pEP?=
 =?us-ascii?Q?dUKzoELSq1T2fxduv1QPU7im3Prg0nGMugmEXyowMV6e9CCA/BUgCPe/yQKo?=
 =?us-ascii?Q?DsJcAP3I2tDvRJUJ/+ZGUrgOGkkhPvehTUWttwlHIZa4PC7H9iYwOyzf1SVI?=
 =?us-ascii?Q?SkQ7cvsQWskVOTwy8oRgpgw1hD4nm8MS1HiXhIJfsLWYaZEcJ6mfWsv30N+N?=
 =?us-ascii?Q?3JXZicedZZwgR/ZFRtP4GtHMYT9xFwwJ4eps/nrrJpcVB9diXlk9I8C6nyWr?=
 =?us-ascii?Q?ujH8JrF1EIjHrjFglt6FS1nD5lDWZoYWt/TA5nbqeQplqzspsAIBV9BzLAFa?=
 =?us-ascii?Q?/SkpF70OPGUE9FSYI/aMmtBND54lr2ggKkxQVJUb+G6Fat8cSkIQLjy/D2Vj?=
 =?us-ascii?Q?+4MqTfSOsAP/IVe+wlpL4dcpceKMrevqweiQu0hHdzp2doDyOzuZ2JXYQHIB?=
 =?us-ascii?Q?CA8uN2/86voRXtibU+BP7sQ8UodKDbxl4tc5JW3hfIRiOgverPlzmz3igDMz?=
 =?us-ascii?Q?dVWQ2+dSee0sXEAv0nOGpebekBC2s4BBEdDnUzdg59sV1dz+6oEIxlDQf9/j?=
 =?us-ascii?Q?mtCmY3N147Hse1ahpA8lA25oRkIUJK5jF9mONL/MRXQ7JEgn7CUAhTNsUeKp?=
 =?us-ascii?Q?qMUG1lw2TkFmH/HESv1dSk8cSLjOGl2OvXwB5n4BiYMURNX4DzckVnVE6sPa?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db97cdca-477d-4641-5b5a-08dbe140aacc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 16:26:46.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQdvU15PHPD5fFWfD0xTPG+cZoiK1f8Op1kBP6kDcTIMGuK9qr7rdluI+BfrmHvFfi9pYvgWh2SZnDal7WtYrDcDx5qxLaPqGU+Qqd6IYpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4966
X-OriginatorOrg: intel.com

On Thu, Nov 09, 2023 at 07:11:46PM +0800, Xuan Zhuo wrote:
> On Thu, 9 Nov 2023 03:12:27 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Nov 07, 2023 at 11:12:22AM +0800, Xuan Zhuo wrote:
> > > Implement the logic of filling rq with XSK buffers.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio/main.c       |  4 ++-
> > >  drivers/net/virtio/virtio_net.h |  5 ++++
> > >  drivers/net/virtio/xsk.c        | 49 ++++++++++++++++++++++++++++++++-
> > >  drivers/net/virtio/xsk.h        |  2 ++
> > >  4 files changed, 58 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > index 6210a6e37396..15943a22e17d 100644
> > > --- a/drivers/net/virtio/main.c
> > > +++ b/drivers/net/virtio/main.c
> > > @@ -1798,7 +1798,9 @@ static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq,
> > >  	bool oom;
> > >
> > >  	do {
> > > -		if (vi->mergeable_rx_bufs)
> > > +		if (rq->xsk.pool)
> > > +			err = virtnet_add_recvbuf_xsk(vi, rq, rq->xsk.pool, gfp);
> > > +		else if (vi->mergeable_rx_bufs)
> > >  			err = add_recvbuf_mergeable(vi, rq, gfp);
> > >  		else if (vi->big_packets)
> > >  			err = add_recvbuf_big(vi, rq, gfp);
> >
> > I'm not sure I understand. How does this handle mergeable flag still being set?
> 
> 
> You has the same question as Jason.
> 
> So I think maybe I should put the handle into the
> add_recvbuf_mergeable and add_recvbuf_small.
> 
> Let me think about this.
> 
> 
> >
> >
> > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > > index a13d6d301fdb..1242785e311e 100644
> > > --- a/drivers/net/virtio/virtio_net.h
> > > +++ b/drivers/net/virtio/virtio_net.h
> > > @@ -140,6 +140,11 @@ struct virtnet_rq {
> > >
> > >  		/* xdp rxq used by xsk */
> > >  		struct xdp_rxq_info xdp_rxq;
> > > +
> > > +		struct xdp_buff **xsk_buffs;
> > > +		u32 nxt_idx;
> > > +		u32 num;
> > > +		u32 size;
> > >  	} xsk;
> > >  };
> > >
> > > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > > index ea5804ddd44e..e737c3353212 100644
> > > --- a/drivers/net/virtio/xsk.c
> > > +++ b/drivers/net/virtio/xsk.c
> > > @@ -38,6 +38,41 @@ static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
> > >  		netif_stop_subqueue(dev, qnum);
> > >  }
> > >
> > > +int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
> > > +			    struct xsk_buff_pool *pool, gfp_t gfp)
> > > +{
> > > +	struct xdp_buff **xsk_buffs;
> > > +	dma_addr_t addr;
> > > +	u32 len, i;
> > > +	int err = 0;
> > > +
> > > +	xsk_buffs = rq->xsk.xsk_buffs;
> > > +
> > > +	if (rq->xsk.nxt_idx >= rq->xsk.num) {
> > > +		rq->xsk.num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->xsk.size);
> > > +		if (!rq->xsk.num)
> > > +			return -ENOMEM;
> > > +		rq->xsk.nxt_idx = 0;
> > > +	}
> >
> > Another manually rolled linked list implementation.
> > Please, don't.
> 
> 
> The array is for speedup.
> 
> xsk_buff_alloc_batch will return many xsk_buff that will be more efficient than
> the xsk_buff_alloc.

But your sg list just contains a single entry?
I think that you have to walk through the xsk_buffs array, retrieve dma
addrs from there and have sg list sized to the value
xsk_buff_alloc_batch() returned.

I don't think your logic based on nxt_idx is needed. Please take a look
how other drivers use xsk_buff_alloc_batch().

I don't see callsites of virtnet_add_recvbuf_xsk() though.

> 
> Thanks.
> 
> >
> >
> > > +
> > > +	i = rq->xsk.nxt_idx;
> > > +
> > > +	/* use the part of XDP_PACKET_HEADROOM as the virtnet hdr space */
> > > +	addr = xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len;
> > > +	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> > > +
> > > +	sg_init_table(rq->sg, 1);
> > > +	sg_fill_dma(rq->sg, addr, len);
> > > +
> > > +	err = virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[i], gfp);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	rq->xsk.nxt_idx++;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
> > >  				struct xsk_buff_pool *pool,
> > >  				struct xdp_desc *desc)
> > > @@ -213,7 +248,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
> > >  	struct virtnet_sq *sq;
> > >  	struct device *dma_dev;
> > >  	dma_addr_t hdr_dma;
> > > -	int err;
> > > +	int err, size;
> > >
> > >  	/* In big_packets mode, xdp cannot work, so there is no need to
> > >  	 * initialize xsk of rq.
> > > @@ -249,6 +284,16 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
> > >  	if (!dma_dev)
> > >  		return -EPERM;
> > >
> > > +	size = virtqueue_get_vring_size(rq->vq);
> > > +
> > > +	rq->xsk.xsk_buffs = kcalloc(size, sizeof(*rq->xsk.xsk_buffs), GFP_KERNEL);
> > > +	if (!rq->xsk.xsk_buffs)
> > > +		return -ENOMEM;
> > > +
> > > +	rq->xsk.size = size;
> > > +	rq->xsk.nxt_idx = 0;
> > > +	rq->xsk.num = 0;
> > > +
> > >  	hdr_dma = dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO_DEVICE);
> > >  	if (dma_mapping_error(dma_dev, hdr_dma))
> > >  		return -ENOMEM;
> > > @@ -307,6 +352,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
> > >
> > >  	dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, DMA_TO_DEVICE);
> > >
> > > +	kfree(rq->xsk.xsk_buffs);
> > > +
> > >  	return err1 | err2;
> > >  }
> > >
> > > diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> > > index 7ebc9bda7aee..bef41a3f954e 100644
> > > --- a/drivers/net/virtio/xsk.h
> > > +++ b/drivers/net/virtio/xsk.h
> > > @@ -23,4 +23,6 @@ int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
> > >  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> > >  		      int budget);
> > >  int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
> > > +int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
> > > +			    struct xsk_buff_pool *pool, gfp_t gfp);
> > >  #endif
> > > --
> > > 2.32.0.3.g01195cf9f
> >
> >
> 

