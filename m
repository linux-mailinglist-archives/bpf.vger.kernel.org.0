Return-Path: <bpf+bounces-15005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0571F7EA101
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 17:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54005B20972
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631D722315;
	Mon, 13 Nov 2023 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6hxDDw9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286021A19;
	Mon, 13 Nov 2023 16:11:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666F8D44;
	Mon, 13 Nov 2023 08:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699891890; x=1731427890;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BFm9gqrakhLvwCz1pZaGvTby4JkNHL2nMlC7OdqC8do=;
  b=V6hxDDw9bFcOKi/XfoPD6iz4N0+t4dEQW2TFCldC3Md7nt4pokr0UElt
   HMASscjLXT5FpIykhlwD6GL4KtdySv+dW8tU0MhwBAydxk/07K6o5xT8A
   eIqupMWjozO8fDkME5dW9rrA58pg3ofxcjcJ5OyRZhhlI7OgXe2gmGN7A
   bpn+oM2IYi6/NR5TsEE9yPJhs6SmvwnxC4jKwOzEX1CESkVjo2iDFZEMl
   dRK1j++l4WLGi5Zinf0qXPScPISv4He9eKUxNez1FUodFemrJwcBweeM6
   JKmJIyO8d0P+NM46GUAEOCtIlkYqs31JDbSdkuRf1+CWIjZeU3sgbIbLH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="12013525"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="12013525"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:11:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="767964008"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="767964008"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 08:11:13 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 08:11:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 08:11:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 08:11:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 08:11:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKHxTP386hlBg3xeiIQNq+eeS9NKhMsEt8P+5WNUBKWBZeHHhq2OhZQ/VHRN9j2YnTRXka16kc4PhNt6mLSsC8DgH/5NtZWGPDwAT3kMhEjx1vZAJbWThZIvGXELr63eXbaSkI7v5HHWXTshqt1UPQNOSErcXtR/8TI9+/E7RBCZBlUyf2E46T2tZ5DDHrBqTWOviHatBu7BdVEBPuPwWsRWB37gGr6yKtV3YCglh1rO2P1TmUEjWN08VVxV8Ln2z1x/cuzFAWi/yOKwUKjJgRr5CGhAKWMdY2E1jWgy6rkZEqf14VNcjWe198Vgqz5k5nsuRwBy1EYkHsob550AkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfdjnMjbyAw2WR+Bs7AeuDUXN8nLd/lKSxvf1cnTc0E=;
 b=cA29C8CEgmg6GWKHny0dpJ0fMavW5T1Wo12U8qEo67UCkIQrdjnNDKjJCNifPxS4+FZOKA8XLuaUgx/9gzs+6l94Wgo3ktGiWv0XwfirDBWKHu5UfaW/aD3g3ogUbq+GlXQkeW4fosCcUJkRm6N2M2zujA78ReU8THbpCmMWShLpIEoNGv/qXkWM6YSnDp3QlcWgVdV5XNST2xGpLBNNBLpT867Gq/i6a8zV+0odfgXNUBylJV4lfKXdPeiWRD29sG5S0QtnEefu1uM53dGmK+A/fgN0WKBSzyVxMDjlhsaBtA+fMpWG7v79c3epDzBeiPs5RmADDWXfYmSIGl2PIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV2PR11MB6022.namprd11.prod.outlook.com (2603:10b6:408:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 16:11:10 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 16:11:09 +0000
Date: Mon, 13 Nov 2023 17:11:04 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>,
	<virtualization@lists.linux-foundation.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 18/21] virtio_net: xsk: rx: introduce
 receive_xsk() to recv xsk buffer
Message-ID: <ZVJKmGvQWhhwUvvP@boxer>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-19-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231107031227.100015-19-xuanzhuo@linux.alibaba.com>
X-ClientProxiedBy: FR4P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV2PR11MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: b9291e94-60b4-4133-5447-08dbe463262b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1/o8O7fcjgc6kd4HGH322DZ5PzaUO1qNHXXpP6vVCVzpkW7yZWpOJryGVzhtGOYRTWwrdzpyJUn/Kn3tXhuaBQCgtz1EQpO+IxZ+lq6F6vnJfbwMgQ2tJjrSp7L82za1L4i4TqkAkecgdc1VHs5kUoRCESAsRnPURBlUp0N47gzWAoVlCpEx1rBq8bc33b5YZW+frDJMW7qEftrZo+lzhdn54VJHqyRvakn/oPuF/SD2GwR3YOOA9kOgjBCsQZ4Tc75gqpvld/ymD7arMU6KTUrFOgU3Fqwnqtw/FIMHbqfNQ9n1Yn6V3nsmXFpsJv+m85w2jf12DGqQj5YLZtumTIWHF82W0tjxv/qENSbxQFU4ajrS8qBqNKg7o8b7PWJoldGv9pB+kil8ySgAmwRYwsfo946ag5szX6VyYZ2pgSFw/qflbpIP0UDc2W9S05toWRO0mqSAqdmvfLs68bylM5Tn8c6cxQPFD7IWJU42fEPuZo4JtmH2A4kpX3e+kqEtb+5YClE51mIob89Cg6OAs2onXyss+OdjJFQOSDviYDcziC7jjBp6TUhij+OMt06
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(6666004)(6506007)(33716001)(9686003)(6512007)(83380400001)(44832011)(5660300002)(7416002)(8676002)(8936002)(41300700001)(4326008)(2906002)(6486002)(478600001)(316002)(6916009)(54906003)(66476007)(66946007)(66556008)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8jO3RDf7iRHHuHlotU6h/j62SBvLLurAnASJwWs8WpRrK98jqZyLbWcaumdm?=
 =?us-ascii?Q?34/Tmog0k1FXTVkkrOob+RRUJ5EFBLoQJDRsuwPzEAYYM7u/G+vM9DQ1MWfK?=
 =?us-ascii?Q?MxQHjS9QbVfINnvRzh8CfZ5IBLGEuoH4iDPYTgV7qshCE+qvj5xP6txw9Dj2?=
 =?us-ascii?Q?uWDZhva6NLVAlG1yUIpIEk2oC3qKR994XddbrqIG+4MFXiwaAJfWwT9TZKTY?=
 =?us-ascii?Q?uEeqkb/OeVNtjEZtHnmXSbWbWCK5GnhnXTj/ckuAFlnlcr81VqyX5ii7fuIQ?=
 =?us-ascii?Q?w34ZfeUOe/6q3Fh9jNWp3lVkbYZxhtKG+mTAmEIJug9RBB7gUVzRILw0Qrpk?=
 =?us-ascii?Q?GxALVlN52MEMGGSIalroayoMutgkniolY8A9C2j7zcBcZtiL0fuBH/TxaI5U?=
 =?us-ascii?Q?uFfAu0V9vZ+OxaalnQuL+e684vb55GI+b/O/rb/46OXGSgr91v8/G++2WZcP?=
 =?us-ascii?Q?hzdWESWPEX8eiNiyyK8YmHdSaIuZi0E/bN7N7xQuiKb1SE80xbHz5izsf+J1?=
 =?us-ascii?Q?rlGmRYAUUrNJzHXGjrm69IB/hEs/FyKV05xFT9cyutp6Dt+e2ImTT/gElvGf?=
 =?us-ascii?Q?E76usXXZUzCC2Ns7QBOapsvggFz2QPhmynsh+6vMl6a3sfnZYISVqnkQnSTs?=
 =?us-ascii?Q?0i1A5cPUmTV7t7eY92y/mpgFu8mYF1YNbkulFSCULEpqw3i7S3hMSqTCuB5/?=
 =?us-ascii?Q?WPm+brufLeUdtExgVngwi7YR+V/HAUg3BaVcFBBONHipJw3FVzf3HeHL2JdQ?=
 =?us-ascii?Q?DrTFdL0uHjG3Q75qiQKqwBG0OH+1Ao36i5htngzSpD44AHoMgHO/eT9CITnk?=
 =?us-ascii?Q?SXuQBP4FM5aUhrlTkP5a2YWwg5+OKCHrj+uWrTLgmTswzLrJI6KZ5dAf37gO?=
 =?us-ascii?Q?IzgCrhUuRLbpNWPLniy6m9IK3Vd5hUgflE8rZBJUdtjiANfjL4BsOIcyLWRe?=
 =?us-ascii?Q?e9Rz54AecHjCQWap4mAa6VQMlA6zPNoptu07zDTqTrUkS5ciTKvtINRepg2w?=
 =?us-ascii?Q?EV4/VU2jKdg1vE/OykIW0FPVqaQd86pvM4doWpQ7XpQwbN8l137lJLVeI3q6?=
 =?us-ascii?Q?Pc/+wRvktNq7uEISDvLJqRxOVefWGearZ847oDaknKQ8WihhUAGoTOFGXXmQ?=
 =?us-ascii?Q?1y7mOPDVMUohlATmNvTJ337SeOKZBRMYrrBq4YhHGG7OScqEz2EpXUjUaPPv?=
 =?us-ascii?Q?1h0DzARtiYpJtTo+7NOo5I09hsrx4hWxG0H5YFftrIQc/rt/Ug+03Z9w3Dya?=
 =?us-ascii?Q?KudNgtxYKOM2lYP1ghgujJtvlpmRLoVb8u0eErHc3ynSUKkK922AXjhOOiE1?=
 =?us-ascii?Q?mxK2EYv2/kw3vQqvXp0o1uGKN498JN1vngqbFchSDV+K78FqrMxiD/Wk1cuT?=
 =?us-ascii?Q?O2D9V92i1AT4VpkqB5vOtxvo4dRfUZCEVOg9+CT1CF98E3BYS0z4fiy4AId1?=
 =?us-ascii?Q?KTeUWUCoIp3v1RbiFSdnYFz9IBAtzVFt5ugWKBXQnU5aSrHVe7HrWU5zrjaE?=
 =?us-ascii?Q?/t05YxAdX+olTpNoFrsVR6pTtF8+CT0fBYKRv2ulVkqAbd/5SeLxg6Nk4ctF?=
 =?us-ascii?Q?VKP52qa0MQeHAZdOK67Lwl+9LlU6ibLUCfSk5RuKDENjg+hbDA7qDYqSkSgw?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9291e94-60b4-4133-5447-08dbe463262b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 16:11:09.8766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VL60Wp12DCBqAdBLwccJCddPNzmd0/hRcO03O9D8eiOrhVPq2HFu9CP4EvJmHVC0e6ihgBkC/KRpAGAfFnHGKMXPU4JSajJKNacK6yFs8Ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6022
X-OriginatorOrg: intel.com

On Tue, Nov 07, 2023 at 11:12:24AM +0800, Xuan Zhuo wrote:
> The virtnet_xdp_handler() is re-used. But
> 
> 1. We need to copy data to create skb for XDP_PASS.
> 2. We need to call xsk_buff_free() to release the buffer.
> 3. The handle for xdp_buff is difference.
> 
> If we pushed this logic into existing receive handle(merge and small),
> we would have to maintain code scattered inside merge and small (and big).
> So I think it is a good choice for us to put the xsk code into an
> independent function.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       |  12 ++--
>  drivers/net/virtio/virtio_net.h |   4 ++
>  drivers/net/virtio/xsk.c        | 120 ++++++++++++++++++++++++++++++++
>  drivers/net/virtio/xsk.h        |   4 ++
>  4 files changed, 135 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index a318b2533b94..095f4acb0577 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -831,10 +831,10 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>  	}
>  }
>  
> -static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> -			       struct net_device *dev,
> -			       unsigned int *xdp_xmit,
> -			       struct virtnet_rq_stats *stats)
> +int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> +			struct net_device *dev,
> +			unsigned int *xdp_xmit,
> +			struct virtnet_rq_stats *stats)
>  {
>  	struct xdp_frame *xdpf;
>  	int err;
> @@ -1598,7 +1598,9 @@ static void receive_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
>  		return;
>  	}
>  
> -	if (vi->mergeable_rx_bufs)
> +	if (rq->xsk.pool)
> +		skb = virtnet_receive_xsk(dev, vi, rq, buf, len, xdp_xmit, stats);
> +	else if (vi->mergeable_rx_bufs)
>  		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>  					stats);
>  	else if (vi->big_packets)
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> index 2005d0cd22e2..f520fec06662 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -339,4 +339,8 @@ void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
>  void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq);
>  void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>  void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
> +int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> +			struct net_device *dev,
> +			unsigned int *xdp_xmit,
> +			struct virtnet_rq_stats *stats);
>  #endif
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index b09c473c29fb..5c7eb19ab04b 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -14,6 +14,18 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
>  	sg->length = len;
>  }
>  
> +static unsigned int virtnet_receive_buf_num(struct virtnet_info *vi, char *buf)
> +{
> +	struct virtio_net_hdr_mrg_rxbuf *hdr;
> +
> +	if (vi->mergeable_rx_bufs) {
> +		hdr = (struct virtio_net_hdr_mrg_rxbuf *)buf;
> +		return virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> +	}
> +
> +	return 1;
> +}
> +
>  static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
>  {
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
> @@ -38,6 +50,114 @@ static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
>  		netif_stop_subqueue(dev, qnum);
>  }
>  
> +static void merge_drop_follow_xdp(struct net_device *dev,
> +				  struct virtnet_rq *rq,
> +				  u32 num_buf,
> +				  struct virtnet_rq_stats *stats)
> +{
> +	struct xdp_buff *xdp;
> +	u32 len;
> +
> +	while (num_buf-- > 1) {
> +		xdp = virtqueue_get_buf(rq->vq, &len);
> +		if (unlikely(!xdp)) {
> +			pr_debug("%s: rx error: %d buffers missing\n",
> +				 dev->name, num_buf);
> +			dev->stats.rx_length_errors++;
> +			break;
> +		}
> +		u64_stats_add(&stats->bytes, len);
> +		xsk_buff_free(xdp);
> +	}
> +}
> +
> +static struct sk_buff *construct_skb(struct virtnet_rq *rq,

could you name this to virtnet_construct_skb_zc

> +				     struct xdp_buff *xdp)
> +{
> +	unsigned int metasize = xdp->data - xdp->data_meta;
> +	struct sk_buff *skb;
> +	unsigned int size;
> +
> +	size = xdp->data_end - xdp->data_hard_start;
> +	skb = napi_alloc_skb(&rq->napi, size);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> +
> +	size = xdp->data_end - xdp->data_meta;
> +	memcpy(__skb_put(skb, size), xdp->data_meta, size);
> +
> +	if (metasize) {
> +		__skb_pull(skb, metasize);
> +		skb_metadata_set(skb, metasize);
> +	}
> +
> +	return skb;
> +}
> +
> +struct sk_buff *virtnet_receive_xsk(struct net_device *dev, struct virtnet_info *vi,
> +				    struct virtnet_rq *rq, void *buf,
> +				    unsigned int len, unsigned int *xdp_xmit,
> +				    struct virtnet_rq_stats *stats)
> +{
> +	struct virtio_net_hdr_mrg_rxbuf *hdr;
> +	struct sk_buff *skb = NULL;
> +	u32 ret, headroom, num_buf;
> +	struct bpf_prog *prog;
> +	struct xdp_buff *xdp;
> +
> +	len -= vi->hdr_len;
> +
> +	xdp = (struct xdp_buff *)buf;
> +
> +	xsk_buff_set_size(xdp, len);
> +
> +	hdr = xdp->data - vi->hdr_len;
> +
> +	num_buf = virtnet_receive_buf_num(vi, (char *)hdr);
> +	if (num_buf > 1)
> +		goto drop;
> +
> +	headroom = xdp->data - xdp->data_hard_start;
> +
> +	xdp_prepare_buff(xdp, xdp->data_hard_start, headroom, len, true);

Please don't.

xsk_buff_pool has ::data_hard_start initialized and you already
initialized ::data and ::data_end within xsk_buff_set_size().

> +	xsk_buff_dma_sync_for_cpu(xdp, rq->xsk.pool);
> +
> +	ret = XDP_PASS;
> +	rcu_read_lock();

We don't need RCU sections for running XDP progs anymore.

> +	prog = rcu_dereference(rq->xdp_prog);
> +	if (prog)

Prog is always !NULL for ZC case. Just dereference it at the beginning of
rx processing instead of doing it for each buf.

> +		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
> +	rcu_read_unlock();
> +
> +	switch (ret) {
> +	case XDP_PASS:
> +		skb = construct_skb(rq, xdp);
> +		xsk_buff_free(xdp);
> +		break;
> +
> +	case XDP_TX:
> +	case XDP_REDIRECT:
> +		goto consumed;
> +
> +	default:
> +		goto drop;
> +	}
> +
> +	return skb;
> +
> +drop:
> +	u64_stats_inc(&stats->drops);
> +
> +	xsk_buff_free(xdp);
> +
> +	if (num_buf > 1)
> +		merge_drop_follow_xdp(dev, rq, num_buf, stats);
> +consumed:
> +	return NULL;
> +}
> +
>  int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
>  			    struct xsk_buff_pool *pool, gfp_t gfp)
>  {
> diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> index bef41a3f954e..dbd2839a5f61 100644
> --- a/drivers/net/virtio/xsk.h
> +++ b/drivers/net/virtio/xsk.h
> @@ -25,4 +25,8 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
>  int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
>  int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
>  			    struct xsk_buff_pool *pool, gfp_t gfp);
> +struct sk_buff *virtnet_receive_xsk(struct net_device *dev, struct virtnet_info *vi,
> +				    struct virtnet_rq *rq, void *buf,
> +				    unsigned int len, unsigned int *xdp_xmit,
> +				    struct virtnet_rq_stats *stats);
>  #endif
> -- 
> 2.32.0.3.g01195cf9f
> 
> 

