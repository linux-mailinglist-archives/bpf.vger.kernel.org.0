Return-Path: <bpf+bounces-15224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 348A37EED48
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 09:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD39DB20B52
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 08:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323C4FBFF;
	Fri, 17 Nov 2023 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGP2MVpi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48683D59;
	Fri, 17 Nov 2023 00:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700208657; x=1731744657;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WhnP0lJq58v8zQ5p/vd4vUkF9rRHeQbjOYQvVudcRaQ=;
  b=JGP2MVpiVFVRDAtfCib3+GU4lF41uqCMG5zIjscYHNU5hMzvWNKBM8b3
   3xrL8CZ15swCk3hbRgBfPLUkeVn0ubG/6y53Tpzbk4+IR7uIlb31pI3jo
   H1ki4rNkyO1VTj5D7sTK61jlLheINwoNW9GBoAytAwyZHuk41OflrhmwW
   +bLfmQ7xRPw2sHeAxpsH1jJMCOfXha0OLxEOJ48M0xu7zj2lir3NKZhpz
   Gk3Q+Sy+vZa/yrkDawcZ4ubERdMvgEsOEBeG4UjGKO9HZ0KeTkOcDyB2+
   iSJZ78fmI68nMiQIx5colZ6IvaOcPDvobTDbzzuCvz8AmeDfaiH3WfoDx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="391041748"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="391041748"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 00:10:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="6950809"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 00:10:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 00:10:55 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 00:10:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 00:10:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 00:10:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c//RrIWqcXpW67H16KZvnn4+r2an/YP9c+IbAFvuNiJdYnIrNu9XwdKUjN1CTmy1zeO198orhNSW8jrQ+thAHy9laxZOBJ2MzBzcFvmPW98sdYlCQStMoJGPv7KwlRTjUmQ325iNPjgQsVbFOUu8tpaVYD7+cUHrdLumbuAuASHtYsjZyq5ac5CtSvfEIJSpuVegwl9wVCq9UD6n2HT14Do2ow+AdMUC/ZsiPueZBqpnPQjpIiJSFXKDdN5vGvryj03MV1x6tYDVV0LlK2nwVEPnnF0FHi0x4FH1JwDHZWNSTURYVOi3+ak8YpVKX2w7C0xBQ1QmHhUEXDOVe5gQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtTm7doOnENjl3wod9+c2z/ADgYuRiIKSsPI2Jb1CPU=;
 b=CpkmuZC7FXRBfbjr+feb8JeXhebeNMf3a/cCp1+urDSWdAVP8mFg2XcJK/Um2agbIosCvTjsVyB0dXHVKWPvjQ2XQUanLbzTJf9yPnX2Dh026pXziqgboNZw68IyZjTiYHZKSSYj/GP5RURl7veHAQur0N0Ee+/z07josF7g5zg+IsEJoyLYTVkqbXmUx+9N6Wm1w3zZKhCgQbeHUE0ed1wL39OjqS1d+pcG/TIKBo1/jLhtmjPnFuMYRpB1eHvFZanzm4hG8RtAh1ZT1tFNCfANQSOvFfZF5bLqWkeaqwmjmFh1oDWGhZ/ei7bUyDq1PmGdmld1kB1Qcq7CLSWjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL1PR11MB5256.namprd11.prod.outlook.com (2603:10b6:208:30a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 08:10:53 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 08:10:52 +0000
Date: Fri, 17 Nov 2023 09:10:44 +0100
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
 Mahameed" <saeedm@mellanox.com>
Subject: Re: [PATCH bpf-next v7 11/18] ice: use VLAN proto from ring packet
 context in skb path
Message-ID: <ZVcgBGRwcyaOl+yl@boxer>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-12-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231115175301.534113-12-larysa.zaremba@intel.com>
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL1PR11MB5256:EE_
X-MS-Office365-Filtering-Correlation-Id: 401c6bdf-641a-446e-f065-08dbe744b744
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCPmhRcIVHI1rFYfWvKAo+bTjmb8YuTaHqrq4CB6JRTU1cdkJ7ccYCTmcbZBQi9K/n0RIU/L6M+64qw3GkamAzPlSbwrlcImleyqK0MKUxgiqaG1UmOWi+Wug9EiCUXFhR+QnlFkJc+d9lELvh5ZIhm+5gyCtbFM8PNCWx/ZdNCVWtXI6wb2Y+2LBkA1LrA/TNHZvMpHJYGpPInHkimA68OuIJok+stuPVu4d0T3olw9LiSJnVFD0jSDpWmUfRG04VSi3gGq67g3BK4CP9ADHLz3iCEWaBDrAZWBleGkVo8ER/djQzpYBVNQQ+BQDU8Fq5/KfBxMaArwKhhIH6Qar3H5yj29fo9xFlRTNWr7Iok09ubQvmBCWUhJ7xsIw1IPYUnt3igFRihG/0JTw5yCPPf2tu0Vcn7V+SCBioO0AVeQVDhYWpEt/bacAOXCkMYpGLyms4EFfz8I+QW9DIkiyvLooKHjNGXr1k/wj+PgfdqoOeZyulUjgEABblUtMf53MYTttsVRMj47sGywS5+KHiKb01yFjqcjPV2y/F6M20l1wtn3TW/4rhC8zVf0tj0dzBZqj05q1BBF3VX2kxoZ5X9SeRBFiYrqxpWqeuq2A4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(6506007)(82960400001)(4326008)(6862004)(8676002)(5660300002)(44832011)(8936002)(7416002)(2906002)(66476007)(54906003)(6666004)(86362001)(66556008)(66946007)(6636002)(38100700002)(33716001)(478600001)(316002)(6512007)(9686003)(6486002)(41300700001)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d29jrJm3+eThz5NmUHqs8VVNCP93+VZ0rifIqoCUKXEbrZxMLqFZSS3AMS+v?=
 =?us-ascii?Q?FZgga79Tsm4Fk2cbA44ASdSiZDxydtmaCK6MkVIKwCYjD5ShM+dVJkU9Ye8x?=
 =?us-ascii?Q?08RhuilEDGj9k/lbGcpRRb+lrMKVRUsgjBPBaj/msc1GnarlU+wAlguQBgFH?=
 =?us-ascii?Q?1VM3gQHiPMBOggVw/FKy3BhU5fbYHUrBT/Unsn2ya24wtHmwj+y5lMw5So31?=
 =?us-ascii?Q?twuA7OAeVbGL4+GSMbdKmvillcqPNDUYp/XIxSIXfcSPxb7E24zNbBfWKPEX?=
 =?us-ascii?Q?TgPtbGQbTqeX72Kdcvq0tgvDOvZoYXp17F1Vl+WwhUN6U6cJo6+mjdYfHUkf?=
 =?us-ascii?Q?r+TpK3vObEMMBLhv1qmmbL7QAqZLGDML/q/u04vh1ihSvB4VhZriHU0Qvlby?=
 =?us-ascii?Q?bEYzJGVcGzRJY3R7dtImkmtnN7iIdTbc25QN2FbdnjnfQjIQVDERDvhG23DR?=
 =?us-ascii?Q?H5NJwXXZL9/sPD7qNFacQ5az3VC306kMj6vA9tEl+XuwtOkzj6HTPpYAZ/qT?=
 =?us-ascii?Q?y3VbZvF7T3zK2GaI5gVvYXcCC9ydVjDS3PkRrpBG5hrhgwQIzL96F/qBdMVc?=
 =?us-ascii?Q?0btOAiuKm+/ez/i8DJcb3rOGp6yzzj3bC2B4Ks5UmAxbee08nhfCs7fpIXU+?=
 =?us-ascii?Q?pDs5mDSVUDPXWYfzdov8rTwSl/AF392i4YwTmoovfBeUjtaSRx0O7NMEbEUB?=
 =?us-ascii?Q?SE7Wfvysezu4DaKwk9WzlcfQvERM8+rmIrXoQzDGmBqPRq0So99B6qwBQOyE?=
 =?us-ascii?Q?t1Vz4bLm/zu3xrN/ocNRAGAlMR3ONbBB6dRT4DgRqLFIbJnMTxgvwv/RU03m?=
 =?us-ascii?Q?9yP8b+H6534VELt+MBQVT2cD+1g3JXtgeB2ZUv8gRqwQXZ3b9UAQBAnkkzs2?=
 =?us-ascii?Q?Tzv3BmT1O/xxC7wNFecxYL59SDKz1BI3ygVjbn5Qi1lZhXVbZtawTVOmwEOL?=
 =?us-ascii?Q?FNTCWmm4/xb9MGFBzdJKeAnGYhDwXQAxFUOdGYaC3JeVHL+HAC+sJFXScoWo?=
 =?us-ascii?Q?WLAkDq6R06D1wfOEknKMEVQcppSV0VdvEQCeS/I7V+lJTh6DCCVtAETtdN96?=
 =?us-ascii?Q?J1r8EslmKid30c8+XXgM+nn1K2bgibWaikBPSn5ZNlesgqdUiJsQdnqMQ0yt?=
 =?us-ascii?Q?S9XjejFjbt4IDi0inC3Pkv4gv5SJUcR9CnIRNtae3qwb4bljjeniBHFVmWgo?=
 =?us-ascii?Q?sxWkCCrdHH6kT71n59AyZbIQYVN8cEYFalQjvyLDl9kSNYJLEgTTZ1NxTZzE?=
 =?us-ascii?Q?ixiM93kZRSkMlshUcLp1SOLRDirPEe/cxTk+eXplf80/YjUEqlvP5DF8l4NF?=
 =?us-ascii?Q?KobXBx2R5OvVbeHhCaUNm83OLlCsVEO+7CgBgA/MXjhmz2YaArgvPNtAgSW/?=
 =?us-ascii?Q?HH9jJUUiPUkiruZwMvJfCQE8beVOWJ1twSV0eYfZDEIDq5i/K5twsVFdpeOV?=
 =?us-ascii?Q?g7yLcjngo81SX1vKcoT3GDeoy1LjDMMb95BSgEyv6NPtnmg9SsPeqoIojzhr?=
 =?us-ascii?Q?37F3HBDER0ZOomgXe2GDspnPUrY5l9SkFWCdAsmDdp+VGRhB+BRebQ5np4K/?=
 =?us-ascii?Q?Al+4v0suoDjb7nygCnN1FuD303ujbDr4h2PAPb6cRZWsuKX43WI5nqon6VBQ?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 401c6bdf-641a-446e-f065-08dbe744b744
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:10:52.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myx6DB+JjPhmltZtKfYlqSrxXewZuuwSM3Tew4ZZmLYvxfsyQvr32uCd6ONnP0ifeFaKeK2bXEtoA3Sj4CtWTKvpuiXAFdNVuZPsbk+MyXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5256
X-OriginatorOrg: intel.com

On Wed, Nov 15, 2023 at 06:52:53PM +0100, Larysa Zaremba wrote:
> VLAN proto, used in ice XDP hints implementation is stored in ring packet
> context. Utilize this value in skb VLAN processing too instead of checking
> netdev features.
> 
> At the same time, use vlan_tci instead of vlan_tag in touched code,
> because VLAN tag often refers to VLAN proto and VLAN TCI combined,
> while in the code we clearly store only VLAN TCI.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 14 +++++---------
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 63bf9f882363..a1f5243299c5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -246,21 +246,17 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>   * ice_receive_skb - Send a completed packet up the stack
>   * @rx_ring: Rx ring in play
>   * @skb: packet to send up
> - * @vlan_tag: VLAN tag for packet
> + * @vlan_tci: VLAN TCI for packet
>   *
>   * This function sends the completed packet (via. skb) up the stack using
>   * gro receive functions (with/without VLAN tag)
>   */
>  void
> -ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag)
> +ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci)
>  {
> -	netdev_features_t features = rx_ring->netdev->features;
> -	bool non_zero_vlan = !!(vlan_tag & VLAN_VID_MASK);
> -
> -	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && non_zero_vlan)
> -		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tag);
> -	else if ((features & NETIF_F_HW_VLAN_STAG_RX) && non_zero_vlan)
> -		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021AD), vlan_tag);
> +	if ((vlan_tci & VLAN_VID_MASK) && rx_ring->vlan_proto)
> +		__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto,

Umm... pkt_ctx.vlan_proto ?

> +				       vlan_tci);
>  
>  	napi_gro_receive(&rx_ring->q_vector->napi, skb);
>  }
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> index 3893af1c11f3..762047508619 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> @@ -150,7 +150,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>  		       union ice_32b_rx_flex_desc *rx_desc,
>  		       struct sk_buff *skb);
>  void
> -ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
> +ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci);
>  
>  static inline void
>  ice_xdp_meta_set_desc(struct xdp_buff *xdp,
> -- 
> 2.41.0
> 

