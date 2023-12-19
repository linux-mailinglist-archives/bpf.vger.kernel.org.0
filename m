Return-Path: <bpf+bounces-18314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D60818CDE
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 17:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17F928824C
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C00D3528F;
	Tue, 19 Dec 2023 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Azl9s/nF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CEF364A8;
	Tue, 19 Dec 2023 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703004481; x=1734540481;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oetnxeft6YahVtinLZb4u6Ax4AjXbd59FAXz7ye9yvc=;
  b=Azl9s/nF4UwE1/v8FoqXnWyGvQbmrCPmlRCcy/MWsNkRiyAHyAnLIOgE
   MjKr5ceKQguGLZah6V2ljCIdWBZIV83YRFfF3aAhimoYUlicHs76Vgbj2
   7mUj/TY2cFW907PSk87kzFvMZA7DM8o3Q4bbVpAMt32rqZt57tf5wWBtM
   3sZzmdZ/7CS4ndIO6EJMiUAu19LeqMyEyLx2PD0NOgHbgjPDCDIeBJ2Ef
   D8D8tJZUS/oPG1xXGeGl2y6xasm3yI55JesBF+IetTlIpItDQQSj2H/JN
   V1W0F3l0UKQX/D4daZcxbxNUkaNyOs/jhI8Y8Q7H/xQOYTNz8y3wDYoIc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="462138764"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="462138764"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 08:48:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="752216268"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="752216268"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 08:47:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 08:47:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 08:47:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 08:47:54 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 08:47:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOji6RN4tIQ3eRUc0E0DHEupp/Wh6AIi4ioTyMqEluCrELhlKOunONWE+g6RAxOw1lP9Hm5sN24LqhgxWWCR/6VXZsZ4zmsGx1Yy1pQis1G5oD6qH5//ZPDutYndkVvzv4M2LwNwbCM+Wn85iBUoYItFw6wRh8WiaNNQAm1Zh3VVarEJYtx/Fw7stYdvnljtZCmYAnxl0VVduyNnCG4BEJD0Xw/01iuW7SLMNZeUCmpQDwxYw5VWo6AMXcTsO8vutKjGuBYy5FjSoJO9MfDMAzJ9FPMco873OzI+liJNt4vvyypK+u1KBjvEsek+x4RDDN8w92Ne1TfS0scYdh9NPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZgA2WL3lvuDCtENH1znb2BvRD0rbzrhehfwd55Atb0=;
 b=e/hrCqBdnsiv8wcx2ZbCcdElGR3qIi1F5S0qM7YnquwTUOdrYrB3+bSZyxm0+VrVVg3PLNpbFU3RO544os5qL6ss1PTmIeUbYPnIpXfLr7FfUHYzHuXzRmQ5fazHQHQgssk38fWZKP4YQQNgh1iqR5oGyHW6O7NniJ0b3cYxh7luP9gjV+wcTslBI1z4iuq+ksVLAoYzo/YBRL+0WVOPWQLYbix3JBg41kjzpnQCRXVXqOQCZmC5GwEFPHf3NWre34egjto5ZW/Byr+Okk3oRt1DKuc0cDuTWUanmhJU3c201svmJx3hLeUTOoIydhavnCPlp1DRM5QG9TCq7jMjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV3PR11MB8556.namprd11.prod.outlook.com (2603:10b6:408:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 16:47:50 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 16:47:50 +0000
Date: Tue, 19 Dec 2023 17:47:44 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, "Jonathan
 Lemon" <jonathan.lemon@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Larysa Zaremba
	<larysa.zaremba@intel.com>
Subject: Re: [PATCH net-next] xsk: make struct xsk_cb_desc available outside
 CONFIG_XDP_SOCKETS
Message-ID: <ZYHJMM6pjwD0UbqW@boxer>
References: <20231219110205.1289506-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219110205.1289506-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: FR0P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV3PR11MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ecb61c-548b-45e5-4dc5-08dc00b23caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSwHS+R6wX9NVjh/bZAIPFJAH0tFFT0UmuJNevtbWQPEgr7cFbdbyatSaruC6dPp183Bfe57FEftG3vybf2VxBUJi2UOwgw2shXglhRTuVBBq/KhhHQHVxOA7/RBjNTlgtEw8B5h0ZNxzvRJqEUN51uKsFbbwAOd3KEON8XtXz14gpCSebhANN0+x/wgNSMGANHgTFOiEXJ2vAvR0cCZdMsC4B7T28Cn3orr+BwClDKNUQPX2QzapCVogHBNYj3SHsgKGP8uhVWdWmgQDmOoK5KMdjEyA46q/GlVWRxt2b5v69nYKPeJZioev+RJw7hmnfL+DmycFdMTpKJuQVg5yW0pH2bP+ccX4cDCYbI0sw0y9BI5y65CYQs4ZGoD2cpas+iAANauGr53wJMB7cKWaJRxKG40B/lVr67g9bxbgDAFM1wIMZQpxp5cBezW8zbzLyRWWt0bUILYVJqhQQtLOXkBLnwM1T6oAhdSRQT8zEin31Js8qmPN3AjjN4poSNuCcdxso8sp1o0dDBWRAkcefN3AO4JRerQ+gzeTOmQlh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(107886003)(6512007)(9686003)(6506007)(4326008)(44832011)(5660300002)(41300700001)(966005)(7416002)(2906002)(316002)(6666004)(33716001)(478600001)(8676002)(54906003)(6486002)(8936002)(66556008)(6916009)(86362001)(66946007)(66476007)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Exq5+Ri8OOoAixdyKDFW1jYx0ouXWqqCxJ+tvyaHOMfbqNb49ygsLdeb7Gw?=
 =?us-ascii?Q?hc0B1p32L/y46SW4Fv3mq4mEf2D9q9sofbU8heRnAL6OCpq+Zlr69jVSqEJM?=
 =?us-ascii?Q?E0233nB5YlxyzhssSvfGlhJBvbD85H8xpQ2KJmidWJVxtUWfvL6ki3HCczWA?=
 =?us-ascii?Q?xHFG0Us/oBHpDPeQjOf05y+C6Rr7qIFGViBXQ61TVik8u6l9ooTQl++tbhF1?=
 =?us-ascii?Q?EI2bKpO3zMZLcRl7JfPUPR/bR1gpRzzSlnXWPYwTxMHROhRG0qWjNnvcuHIH?=
 =?us-ascii?Q?O7gYb0iAdGyi3aU5tfVc5TKbp3UlsIrZUFC3hOmWXr4VVHNylhSpS1QZobjD?=
 =?us-ascii?Q?g3g+1EtU2cc+hp8s/57nkE+sWKLkbqbag3r6x9zO4GKqHutaR0+G9JFPo/C7?=
 =?us-ascii?Q?MiWb4EKTbkqdLvSbZEnNUYBHwQgcVLYS+FoU5Oh0KiG3oE1CRsj3VC+8k8jo?=
 =?us-ascii?Q?ulRyoWoDXfaVLqR7H+NnQKD1XyRSxdtG4C7q8xT8WBf8BZH1VPUSRW9CZJE1?=
 =?us-ascii?Q?Y+fdowWzqiXM5by4gn8MkNcFSrYZUe5Fg/oFzmkrxnezlwQX7Joqx1wm5Was?=
 =?us-ascii?Q?fBdNcRz8aXHCwOOwIa083o3XFBwJlXbebA5FWeouqwT5ljurdYfQewqGbxnB?=
 =?us-ascii?Q?+3OMTqCiR19V0UU9IBa6iAJC9g9AsTlZqaDItsELqIzEk/at34RwoOwuMkaO?=
 =?us-ascii?Q?ETNctuKH0EMm6LRn4S4Tz/j/JLOievVxqZlUAqBB7cYugktSMWR1PK9tA+eC?=
 =?us-ascii?Q?yBD5D5/D3q1GHuBm2FzWugugxEixCZj+HeokOFUH52MP79nt+20Gp67IG/cP?=
 =?us-ascii?Q?YjIzDtZxOv7PCYTaQrn2zA33c5/6Yqb1/b5JZVhEGg0XtKfxdKZxfyjZtc9L?=
 =?us-ascii?Q?U2ekt++qw/JnkoI8cgK1xuhqX9I3Y3aOyAXkZplXARqjZ7KgdXUvWZwjGgvq?=
 =?us-ascii?Q?mcEoMgtRZFz2fzKRQhj5JsttaXiCOTMI/sZdPkUQgkA0y1ooZaXSDiEBEuKI?=
 =?us-ascii?Q?LGc3J6kacfIs7Ugb+1yrkWGyMn3KtfGN2F7xKyT87U3papoUUYiGCxOQX6tI?=
 =?us-ascii?Q?BAAx5yVnUb2MBagPKNSoSY+WaighDprymSEti1zozjuZZDfXKHYdhRCIj5U0?=
 =?us-ascii?Q?f6QUACkeP8kwNPLe8AIYq/hRvU06ovnruYYTFfwhxqTpVJ7fs7Uve208RW/+?=
 =?us-ascii?Q?/9SnCJvs6A/VmM9pZAHUG4eAxu8LigUrQeJ9aQPGg0H25qEekYENL+h0g2x5?=
 =?us-ascii?Q?C/PKZ13iWMienmH+eoMr7iLveli/834eYLTh/7pueLLXsJ9e232KSfWR2F+Z?=
 =?us-ascii?Q?v3qGjvrcTq0Z2eK0yd3O4tZgs/hQKIwTYp7xHWRopmm5AsbuXK+jswuIIz8g?=
 =?us-ascii?Q?BuxzUo9Lk5797q2DTpzTr/U7dJ7DvX5YZczYeaodbxdvBSIny3mvLZ+lJaRc?=
 =?us-ascii?Q?ZFo3zpaYt4oeztIaA1tG6gmXGRCEENcq+hqJfmBFbpwHHBOcSzj5ExIK9NPC?=
 =?us-ascii?Q?COj0VpTUXSXSuDUADKbv8Fgd+YeK/L7XJZATgGDfMumDWflOmN3sVHP0XQpL?=
 =?us-ascii?Q?vV3Kpuhc1KVUIhATI1AvFTCaZyQVZMLe990nsTGXUB4sv+yZlF2ziBzNaxUS?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ecb61c-548b-45e5-4dc5-08dc00b23caa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:47:50.2818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrfPNmGbqqeu8CnT5yQ5AGMXo+d7/c3ViMBudqf5uSE1USZw8orSgFyyCNthztUBPaTDfo0k0bM2lETZbNPeWPaqxg7ZEFuz4uAtdexwtOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8556
X-OriginatorOrg: intel.com

On Tue, Dec 19, 2023 at 01:02:05PM +0200, Vladimir Oltean wrote:
> The ice driver fails to build when CONFIG_XDP_SOCKETS is disabled.
> 
> drivers/net/ethernet/intel/ice/ice_base.c:533:21: error:
> variable has incomplete type 'struct xsk_cb_desc'
>         struct xsk_cb_desc desc = {};
>                            ^
> include/net/xsk_buff_pool.h:15:8: note:
> forward declaration of 'struct xsk_cb_desc'
> struct xsk_cb_desc;
>        ^
> 
> Fixes: d68d707dcbbf ("ice: Support XDP hints in AF_XDP ZC mode")
> Closes: https://lore.kernel.org/netdev/8b76dad3-8847-475b-aa17-613c9c978f7a@infradead.org/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Thanks Vladimir for acting upon this. Later on let us think about moving
this definition to xdp_sock.h maybe.

> ---
> Posting to net-next since this tree is broken at this stage, not only
> bpf-next.
> 
>  include/net/xdp_sock_drv.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index b62bb8525a5f..526c1e7f505e 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -12,14 +12,14 @@
>  #define XDP_UMEM_MIN_CHUNK_SHIFT 11
>  #define XDP_UMEM_MIN_CHUNK_SIZE (1 << XDP_UMEM_MIN_CHUNK_SHIFT)
>  
> -#ifdef CONFIG_XDP_SOCKETS
> -
>  struct xsk_cb_desc {
>  	void *src;
>  	u8 off;
>  	u8 bytes;
>  };
>  
> +#ifdef CONFIG_XDP_SOCKETS
> +
>  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
> -- 
> 2.34.1
> 

