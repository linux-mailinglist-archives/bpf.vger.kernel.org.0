Return-Path: <bpf+bounces-9254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE75B7923FB
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 17:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF33A1C208FB
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55436D538;
	Tue,  5 Sep 2023 15:37:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9242571;
	Tue,  5 Sep 2023 15:37:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D3197;
	Tue,  5 Sep 2023 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693928266; x=1725464266;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7Ock5uHxzRuA7Cr7lKKSh84Sq+U/ImLygtSJGn7c7hQ=;
  b=n8kXU6lNyJdVM1QfdVDDkbv0MgmzgpBJmB12ijzoOPTe4aGBE7wlTAkP
   IDhEnvRzQEQFDL4KyO/YOVnFTjy1noRE500PnQrCWyLyXFYzOB52mSn75
   z+hW780fL36XG39bk0u5aX5OaeFwHPZHYn5bu4AU0UdK52USc9TGIexeA
   wXRA227JvIgvL5AK0blAaS2CitTzDWIOSwwXQM7ZX74Vd6RI+M5sPkWyu
   BwBiY0Ni0jSiODeVd2PWlGlIjUr6D1vkbpdSVElh2vMUde1RcuYJOgR8T
   5okVFpvXC+D6HlAg217Izmu+O3sHAQ7/ipdHvDVSy6qKJOon/rYlkDvIA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="379546547"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="379546547"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 08:37:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="776232790"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="776232790"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 08:37:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 08:37:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 08:37:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 08:37:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV0tEDW83TZh2eY6eKxDRYof2cSijqG5iueuYpaoxs2zMlmKVqAgq9upVZczDLXOXAG8XyXVlqs6zzypk7QvdDAjsGcDk3ZzEYJ9fyEu2RwOapyOQVV9T9leZtfuMLV1qX23gt/NH55Qu3mD36atJMciq/nXiai275WT2thRlhgO/Zg1p54BzjSZIPdUU8vNV38WHqykr2gQNlqDNnBCwo7YdY96pa0ZTgGWxbm7mpQIY8lbNTX2j4At5ObphKyDtDbqFgqOHK/V4t56O5Q/jFs+tFWYB+9qCIkVLwR5qJael9+i60Q+uYSnvRKfiTF9PPXAe1WWddQiasJAnE+6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c+AKhh0ngOuEX6T8XIY8tbZje1zEtAxA8JxQQXswwk=;
 b=ZggGZz7Dl8maq4v/nSwX7FzUhNICZ8eZC3151LokYEOv4pexmYhDZcIqvd2/A9DNoIIGbDqiGLuUaZkKmXTWIFYQ/iGZu5zN9eL2jNmH2K56y7p4LIu6bN0hAuH9VjI/8ITGST7AywM+pvAYa1nWItouULMg1hPXhhlIJyTQKPOifnaKjhVQzLN3DrkA2FdmgalWaXsuX0yjkrIrFLIC3x5DyqSLRj895UfaDmhZGnMVs5EywW8m+t/9z79K5YhjgnR9oPrONrsdcBEyFVcI+wiYuYPXSfW2KIk9ajFMeV2WeQGOX8AhOi0JvI6dHMYnrmKtqUf/+xoO9kKss1tWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Tue, 5 Sep 2023 15:37:40 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 15:37:40 +0000
Date: Tue, 5 Sep 2023 17:37:27 +0200
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
Subject: Re: [xdp-hints] [RFC bpf-next 03/23] ice: make RX checksum checking
 code more reusable
Message-ID: <ZPdLN56BWQVQGKkA@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-4-larysa.zaremba@intel.com>
 <ZPXxkOCK5e4M/P5H@boxer>
 <ZPYbYqnStaChh8BY@lincoln>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPYbYqnStaChh8BY@lincoln>
X-ClientProxiedBy: FR2P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ca7a07-b8b3-49b8-4d5e-08dbae2609b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWW9Igwm9meGenmKdN/vco/SsXF7YrMGwOYRzE+6C2e2lutxJ0qvKCwNbNK3Xk2jA6jjKfeVFU+V+Je6ebfPqhqA++mvOFBO3iJiKeOPHTm7IDyrFdrPkRb0giUbkik1drXI+kWNMTN6BfY2ZXTKiRvAWEUwuiIpKmFMLwNyhkGZ6AYEBw/uM7QQUP5lE5it4jFj/L0MSyX0Iv4GyY+NFdgvlYMQDe6T726qc89qgoMuoEfEi/jN5nKGLMHoOKiIWh/98ukvW0/ueeYmY9BA8YaKx35BF8zwwfvOclRKPA48K0VeYgvKSYAj7+SUhWEpuDXzjULfWUXslKHsUlLWl+XSKL8BGLKAK9kD9IzxVUQnOhl1236wQPkSOMTAqA1+s0HaffZWa/NOowdPSFrheK+UeGCsuq/4kz+vixcS3muM/k48nlKW8lOz4Vw54zUKrJQO6cGRCNOdSzXUg6yq7O+I/Lj6zJNxENKGBbMpAIM0r5DgoAhnXFoHGkAA6JAWrV3kUwRBZOIT1exJZTIyDZzSvHSKDmqPkIqy6agJiIY5UvEK9YA0sG7qJ6uVIkN0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(366004)(396003)(346002)(186009)(1800799009)(451199024)(26005)(2906002)(83380400001)(8676002)(8936002)(33716001)(6512007)(9686003)(6486002)(6506007)(7416002)(86362001)(82960400001)(44832011)(38100700002)(5660300002)(478600001)(6666004)(4326008)(6862004)(6636002)(316002)(66556008)(66476007)(66946007)(54906003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kkTS6HXBcOSMlFugGY06JCYDl44vnVztVf9tEexG5xoiZOFtXqbDN66/b0Yn?=
 =?us-ascii?Q?J6t0gqHLxR6g68uO3SGye+KC+UIJ5jc85GMXNiaaD2hBk54poYDGqebjRP4Y?=
 =?us-ascii?Q?W+g91VcuLygNRI6zfdLIsL3C3uJIYU+MDS23F2hXTy08cUs7Fk9ndpvrBRQa?=
 =?us-ascii?Q?An39ycz/P5rFOmqqCY5L7lq65idbuQjqEdI56cA7yzgrKX280YS8SjRAPnod?=
 =?us-ascii?Q?TWkmg4OslTC9y0hI9iw9okTLKVNbSJYARM1QbUaXuSars1stY97yUdUsCf7r?=
 =?us-ascii?Q?0nUPdMNFAjP7/O+16bHDr1uQENJHaUlvJBQOsTa2dqE6StmwUn4Nfv9Ivf1r?=
 =?us-ascii?Q?6lMH6N65DRSIIfXDp2ypIBfYYdiEeQxpTEIag5G72rP8FT9CbWQHpQg56cXv?=
 =?us-ascii?Q?AsYnyfRgpa98z64EgH5SJ3KgMCmCfGx1gEaqSANv1NVXJYG/ULgHlyApNkU1?=
 =?us-ascii?Q?I+GNtFBrjiAYlQuJkYfFPLbE3X3CZHeS5vNXk7HVliiRxc5EC8Gmfi7s8vP+?=
 =?us-ascii?Q?/tpegP+y7kyzOkQDOFDl1KCxGArfPGc8GJRld6TQUflYQ6hGAjgnbDfgsZ7B?=
 =?us-ascii?Q?Y4bFkMc38m/V/8Tq0yQL8avgl0YM7auHdSX/CgtsYK4bfMEfqehqRa1dereV?=
 =?us-ascii?Q?jJrHkL7AC7GPpurGRVF0Fl4PJnuaxQNYfj1ERdL2WhsRLay1ChxIujsnkLgW?=
 =?us-ascii?Q?pUJdQMOYh2B8QhgRY7NTHxQkFDKHYinl/XHmH7FD/EYE+NISvNoLGYVeN2ZJ?=
 =?us-ascii?Q?r1Gg91SXeuEkwW0uUUa0zffh53ShJIkUPKZrGvFY2t77wKpQvCsmVGG1qvQL?=
 =?us-ascii?Q?cH6whoVUE9p1k4IXNDDGquB7z8nyBDENTnFOIOHgkJym+0GDWUm0l/cnPJYD?=
 =?us-ascii?Q?bAgvw9a4EcfFF8/qqrZtvuS2chRKxznBSvw9Pkz3E4ijl3pi8kPb4RbgtxAS?=
 =?us-ascii?Q?ggI+Q/16syCFABN7+tJZy2IHP60cH+wk+xvU0xN8YwhE3hMdwaY1uI5S4AK+?=
 =?us-ascii?Q?o9BpXOXfGpSvVUlpCsSii6SjSqN7HegBzi/HMGr5GPgeJJp6lJK4X71vBbDw?=
 =?us-ascii?Q?K/s1SObIzBf7QRFnQq7sTI26lqslcuTJHndwchfCo8Z+EbazNVUGTPigOt2G?=
 =?us-ascii?Q?grQ0E+SKhnP1d5g7YpbssNDlkTmbIJLU1/isSQ2fc/Mg4Djirv2cYnxsgexN?=
 =?us-ascii?Q?RBVCy0aLvkCCBzLuIfLxVa/Ib8PXXjXVy6ozjJVn6WbnlpPNx2Byt+2xs32c?=
 =?us-ascii?Q?yU8bDBbI4vJ46LLh+PnYysW8VtjH2Xg6PnAlSjwn+A02W4zq9Pe5xOU5jzTX?=
 =?us-ascii?Q?O3uLrPMQqzS9fIpnzbrfA8aT0Ycny9Ts1dAk79gMPcSkQWiEZa7/PjHu+WJ3?=
 =?us-ascii?Q?VWauOfEKJ72Hav4E4EWOMPXVUTtxLm2qfn96vJIGlqQiNYxkZxqeIqvMoOZa?=
 =?us-ascii?Q?4/+vpnhrFYnQjWcu7UTuXHrsH+GH4CVIoqflOUBUxZP797EYYnZABS8FiYFA?=
 =?us-ascii?Q?x3Tazro1wjb6wwtVkvNHAHAwgvfYa+cBkvyF1RSPTgJfOI1NSA9ik8y91ahW?=
 =?us-ascii?Q?JPu7pCuegabw9Kt2Ygn9vDNqL5xPondPv6qbJ3YqopEkvHj2pL/xDX5Ch5a7?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ca7a07-b8b3-49b8-4d5e-08dbae2609b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 15:37:40.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbU65JjVdsIs1cuhekeZGj79Xb68SjDH5n/STb7y4mb4l2gYjtzeQL2ITZHUzK21RduES0RP3l95cSEJSuE4OfciUtfJc+sB6k6FOEQCCXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 08:01:06PM +0200, Larysa Zaremba wrote:
> On Mon, Sep 04, 2023 at 05:02:40PM +0200, Maciej Fijalkowski wrote:
> > On Thu, Aug 24, 2023 at 09:26:42PM +0200, Larysa Zaremba wrote:
> > > Previously, we only needed RX checksum flags in skb path,
> > > hence all related code was written with skb in mind.
> > > But with the addition of XDP hints via kfuncs to the ice driver,
> > > the same logic will be needed in .xmo_() callbacks.
> > > 
> > > Put generic process of determining checksum status into
> > > a separate function.
> > > 
> > > Now we cannot operate directly on skb, when deducing
> > > checksum status, therefore introduce an intermediate enum for checksum
> > > status. Fortunately, in ice, we have only 4 possibilities: checksum
> > > validated at level 0, validated at level 1, no checksum, checksum error.
> > > Use 3 bits for more convenient conversion.
> > > 
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 105 ++++++++++++------
> > >  1 file changed, 69 insertions(+), 36 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > index b2f241b73934..8b155a502b3b 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > @@ -102,18 +102,41 @@ ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,
> > >  		skb_set_hash(skb, hash, ice_ptype_to_htype(rx_ptype));
> > >  }
> > >  
> > > +enum ice_rx_csum_status {
> > > +	ICE_RX_CSUM_LVL_0	= 0,
> > > +	ICE_RX_CSUM_LVL_1	= BIT(0),
> > > +	ICE_RX_CSUM_NONE	= BIT(1),
> > > +	ICE_RX_CSUM_ERROR	= BIT(2),
> > > +	ICE_RX_CSUM_FAIL	= ICE_RX_CSUM_NONE | ICE_RX_CSUM_ERROR,
> > > +};
> > > +
> > >  /**
> > > - * ice_rx_csum - Indicate in skb if checksum is good
> > > - * @ring: the ring we care about
> > > - * @skb: skb currently being received and modified
> > > + * ice_rx_csum_lvl - Get checksum level from status
> > > + * @status: driver-specific checksum status

nit: describe retval?

> > > + */
> > > +static u8 ice_rx_csum_lvl(enum ice_rx_csum_status status)
> > > +{
> > > +	return status & ICE_RX_CSUM_LVL_1;
> > > +}
> > > +
> > > +/**
> > > + * ice_rx_csum_ip_summed - Checksum status from driver-specific to generic
> > > + * @status: driver-specific checksum status

ditto

> > > + */
> > > +static u8 ice_rx_csum_ip_summed(enum ice_rx_csum_status status)
> > > +{
> > > +	return status & ICE_RX_CSUM_NONE ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
> > 
> > 	return !(status & ICE_RX_CSUM_NONE);
> > 
> > ?
> 
> status & ICE_RX_CSUM_NONE ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
> 
> is immediately understandable and results in 3 asm operations (I have checked):
> 
> result = status >> 1;
> result ^= 1;
> result &= 1;
> 
> I do not think "!(status & ICE_RX_CSUM_NONE);" could produce less.

oh, nice. Just the fact that branch being added caught my eye.

(...)

