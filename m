Return-Path: <bpf+bounces-15237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D009A7EF4F8
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 16:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28D11C20AC1
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8140337163;
	Fri, 17 Nov 2023 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUo+GmQv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83618D56;
	Fri, 17 Nov 2023 07:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700234116; x=1731770116;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zKyD3WNQpgtzwOk2lgWVL/pQ3pRsUD4q06wGJkIUGG0=;
  b=hUo+GmQvC7sNppDlfkwqmj2BJrU0163C6eCoOoY7gfRRSfVCoL/zL5oJ
   DrWb9AHJoICIyMdMEtZln8R8dzyiLlknmg5Z1Jp/PxHaijfSU2TT3kdIU
   mmmojnw/LjdvN2sPV3scDP2617N31acpCvxL0JUdhl6y26Ss29Mg8QLxp
   9WJz13aJH1XT4zcbgfdkG9F7V7hqCNwYIU+FWgJfGvuNXE8+E/tcSkNaN
   gCbu3nA8WyuC5czGu88yBBWKD/ET+hlK5wkFOYzqCahYlVhGcxCZKwvXW
   WAU/F3f6WueYQBo305slLVa1X7hBFxDmDn41lSZgeGBkpTVqcUEDqeIFN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="388463198"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="388463198"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 07:15:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1012954550"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1012954550"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 07:15:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 07:15:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 07:15:14 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 07:15:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNWySYW7RMgOR5AZW799AW5YVlgw4a/LGZGO1HY0PwbvJE5Jd45j1aR/SEVz0BXZH3nSHl8HWcM0iFuNxZn9Kc1ELXZ+aUgqKrek7Mn+0SbygWwR7poYDy0xiurzEt4T5R4U4GPspkVGTdlCLmsLz8SxtHilxyVze78d7iFw/iQNb4jBB7q2XPrGAYJX2KU9c0cZBeurq+VB/gFL7kpic4k4BHqR/xJbVq5XW1QPblKeEUlPfT8jjEd7oi4aLxV9S0A7ChRVc/sgbrODseFQ7+/2IuGKJcAIdHJyXSR8/Ma5atW++J607TD0suIbqKdXxqL2AAKsXhuQRFE5BikxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fWOZG21in1ZF+RbzBLfnup4GB1nTVPbOTpn1ZKx0Cc=;
 b=B7OcVPvtPng3Fyk+e2opvQtfrmGqzt0BVoMwV6+LvJ3dX01+Cjuomxg2X3nWs6nYRBRPq4A0eQCSgEhhrP3aP60ApAKBb3YN7+OI/IvUcjgLId1EOnQDtA6kovdP4MSTh98x+MK11LKU55JZP+zlOuHmso2Lupmgkm9q573UqeP8twVHEO4MatZf3z/CKHfXkGx6O29SudvHreDvSL5SY6/w3PVozni78zgmRkkbE4R5AiGzry8RMEeo6mYu1KstgglOgtOoJNaViMp00XXMXAk1PBDgJvu4KJfDlSmbDLdjk3spOXlPmmMsQbCrMhyDRzQxebVVzB/QP8q/GsXcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO6PR11MB5619.namprd11.prod.outlook.com (2603:10b6:5:358::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.18; Fri, 17 Nov 2023 15:15:06 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 15:15:06 +0000
Date: Fri, 17 Nov 2023 16:14:57 +0100
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
Message-ID: <ZVeDcaZGyeyMrWlK@boxer>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-12-larysa.zaremba@intel.com>
 <ZVcgBGRwcyaOl+yl@boxer>
 <ZVdzqXDOnfXeBVLN@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZVdzqXDOnfXeBVLN@lzaremba-mobl.ger.corp.intel.com>
X-ClientProxiedBy: WA0P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::29) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO6PR11MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4bcf6a-8b9f-4f46-dd0b-08dbe77ffae6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ViwrjYfjC662BUqCmUxSPNdErlii5mPNj09l3XZiHxph4WlB8OK5nqt833TNvOlC4Bv0chNSqHd9Jf5eaGsbK0QYfJPgflezToAtwCFbah7BP0yNQIikXxvaf1cehy7WwjfhkAe+sOEAohW6NC8mW7U7EorHS59nJsme5OXZd86xcD2dQBMrrD1TxqjiIKP5EOPscQ66bAGjLPzjoX5oGZLz07FiNN9kuazq07s1wXPXLIoJN2nvR1vDdpfVnvTMhrpRLBg8ioOe0yFerCcH1CHVARLNpaM4oMGo0z8lF1TL5RH+wzD2tp5oq/GXjv+8wFcZd69X9v/jNCB3DpgAY27P8ngJYapHzdImwkM6Lbk8lhMVrNBFBjehG1MKI6dy9hrzOsTjkibHyK7yIctL+LnGaDFguYA0I7Ljb1HUpEuyx3p/OyEW4MiPxXPIIiDHCYEm5n6kOe+liazFhQnc65+AbfKEq+9lyNITnXkI/EVhAfU7u7CaYHOcLltDnithjyrz/yVI9AUs2hX90k7HUIU49+xM9UpfzBW34KOSgd3mLI1Yw7DtbPk4kEHkAl54
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(38100700002)(82960400001)(6506007)(6666004)(6512007)(33716001)(41300700001)(83380400001)(9686003)(26005)(2906002)(44832011)(7416002)(8936002)(8676002)(4326008)(6862004)(6636002)(86362001)(54906003)(5660300002)(66946007)(316002)(66556008)(66476007)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r9kIxeWf7aH/07Es4Co/4wO/yBt8uvX3d+WQMKBYVLwiCqPyyxOe+3Iidek+?=
 =?us-ascii?Q?smV5rA+Kp2AbTDlIUggWd8aT1ESLyaRTKdCqZwH1Jiurg/1ILHyLr/YwIxF/?=
 =?us-ascii?Q?+CVc/q4GBdMGeaZNCB02TgfbMEFsocsguaW22mmW0sgr4xD62+bhEuQkfW7c?=
 =?us-ascii?Q?/c6OAGJRXCY8lfBxg1OiDewsMuQ9ndt72SxLTDhGpG1UEru0Tzw2ChU0pksP?=
 =?us-ascii?Q?on/pDKaukWrbVQDGKdTVV++ZWaY0X1oCytXKfAN/F6v8V3WCvgg/XfXnR0yh?=
 =?us-ascii?Q?a45ePfRjVGbQ8iLNayPCbzLjh5uqdHY1QBJnZCeDdBJtxUBbQimP35kWz/sD?=
 =?us-ascii?Q?I2m52OFZwRRVyKfW/e9hYB3WgklVxYl3FwgmP5TMUeIlktgwPsJQZF6ogSbA?=
 =?us-ascii?Q?VxYXlgOglLTM/ZawsCqlWbJmYUqNIKhPSbffQkJsK2kcO7OCknaBhF0hJ/S8?=
 =?us-ascii?Q?vEjP0pQSB7cmHHPdogbvHvHnip6PTW3d/SU/QT3CYOMb2jrqY2RfkGMiCxpc?=
 =?us-ascii?Q?u45e5TU6vZrpUl5te04uU4h00mQAUo/jNo5Dq+7hi7H3Q6csfSMJfMkmnSXQ?=
 =?us-ascii?Q?twKRPQ999WpO8hw0MqVoI4n0EDg2MwVgs+i1wdz1B9lqLAT/MORwap4EVkdQ?=
 =?us-ascii?Q?FgEp8fKHW06LNU7tG3jeNVagPrFZrLC3WlZihy1h73a+YMbvsApumr5BCDVd?=
 =?us-ascii?Q?8p7Vq93269ZarLuAmSJ525O1nLovkds3e9w6wGNnM0Vr45hjdrGnidhkle/+?=
 =?us-ascii?Q?cCEAULpCNaR/ui6ITfDXA7guks+wDWpPehgRc7gUgGZg2oiY+uYqecVAHmci?=
 =?us-ascii?Q?HUTKta7JvLdIiVJD4X20mXdtRa7VSJfMogzqG6NZjXoQHrpuG3/daQ0UrmXG?=
 =?us-ascii?Q?XSfs1PM8pwrcrMaeQvFMAEhhtza09a1/u4Ygb0xbKS1B80ctMng75fBMY0Ye?=
 =?us-ascii?Q?JTaybIVN8eAF5wN/qT9TT5odXWjGUhTJMgktwSoIg33izcmQYHybpBZ7aw8p?=
 =?us-ascii?Q?dorfwyPgAM2f5SmhUkeJTwTqgAub3tHIWFJkZ0j/f8it/Lq+O3TMjH48x4BU?=
 =?us-ascii?Q?ocqR2bMTTWX6owXwpu8V3NASfAnsAR8L12rJO8+f0Ve6ePC/LVRFdv19raz0?=
 =?us-ascii?Q?Fki5xiY0T1Mk7ltmKlpL/wXj8uLtu5Gxzhz3ZRkLbaoqhamIKv2WPsn7vxc9?=
 =?us-ascii?Q?y1EArgyCJBKCNz3DD6PRmVFbPLIHj0mVgCYHZ15LKv6FT/0WhltlMUKMftCU?=
 =?us-ascii?Q?JxfNUqI3wSumSZeroL0ZJe2yFz1lJCC+WmKy2m7lEOhZSQDQp/0HoF2TV5Lt?=
 =?us-ascii?Q?RCOkJ0xyTt0zN3i3m/wLoo/8GkHkNLmQJau/DnC+JxJT/3WlTvthDyw6UdmS?=
 =?us-ascii?Q?tzxoqygSTzHHhnfLOk8XwCn+RUPYLUeMtMQpYKxKJ/NAVq+dMfcR8KdCe2RY?=
 =?us-ascii?Q?0/mK2PvjM4orlWXZle5FXLlRUL1WIBQRqtwzXiM2pkAY/2n/WMlcrQn/ECl7?=
 =?us-ascii?Q?6Lw0oMc8FR95pCIbpCa0oSLZT7k20CLF56N0wVixSavc3z48NRbJaQs9i961?=
 =?us-ascii?Q?jY2aw//7JAOqAqVUVm4efhzj1pXg9h1KvlO4pc5HAKHGRxD741yzFvq6v2F1?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4bcf6a-8b9f-4f46-dd0b-08dbe77ffae6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 15:15:06.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGTXnyU95d4Qxi1hAwjwtJOJ8iTL9MyvmZPTwuv7MSSwHbRkhUy4j8y1cnt5xy0gNiaimBsu4pP8Q1vhauwogbrWn5WpP7PeJ4EuaaG2hyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5619
X-OriginatorOrg: intel.com

On Fri, Nov 17, 2023 at 03:07:37PM +0100, Larysa Zaremba wrote:
> On Fri, Nov 17, 2023 at 09:10:44AM +0100, Maciej Fijalkowski wrote:
> > On Wed, Nov 15, 2023 at 06:52:53PM +0100, Larysa Zaremba wrote:
> > > VLAN proto, used in ice XDP hints implementation is stored in ring packet
> > > context. Utilize this value in skb VLAN processing too instead of checking
> > > netdev features.
> > > 
> > > At the same time, use vlan_tci instead of vlan_tag in touched code,
> > > because VLAN tag often refers to VLAN proto and VLAN TCI combined,
> > > while in the code we clearly store only VLAN TCI.
> > > 
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 14 +++++---------
> > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
> > >  2 files changed, 6 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > index 63bf9f882363..a1f5243299c5 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > @@ -246,21 +246,17 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> > >   * ice_receive_skb - Send a completed packet up the stack
> > >   * @rx_ring: Rx ring in play
> > >   * @skb: packet to send up
> > > - * @vlan_tag: VLAN tag for packet
> > > + * @vlan_tci: VLAN TCI for packet
> > >   *
> > >   * This function sends the completed packet (via. skb) up the stack using
> > >   * gro receive functions (with/without VLAN tag)
> > >   */
> > >  void
> > > -ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag)
> > > +ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci)
> > >  {
> > > -	netdev_features_t features = rx_ring->netdev->features;
> > > -	bool non_zero_vlan = !!(vlan_tag & VLAN_VID_MASK);
> > > -
> > > -	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && non_zero_vlan)
> > > -		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tag);
> > > -	else if ((features & NETIF_F_HW_VLAN_STAG_RX) && non_zero_vlan)
> > > -		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021AD), vlan_tag);
> > > +	if ((vlan_tci & VLAN_VID_MASK) && rx_ring->vlan_proto)
> > > +		__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto,
> > 
> > Umm... pkt_ctx.vlan_proto ?
> > 
> 
> This compiles both ways. I have put pkt_ctx into a union.

Right, missed that.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> 
> > > +				       vlan_tci);
> > >  
> > >  	napi_gro_receive(&rx_ring->q_vector->napi, skb);
> > >  }
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > > index 3893af1c11f3..762047508619 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > > @@ -150,7 +150,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> > >  		       union ice_32b_rx_flex_desc *rx_desc,
> > >  		       struct sk_buff *skb);
> > >  void
> > > -ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
> > > +ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci);
> > >  
> > >  static inline void
> > >  ice_xdp_meta_set_desc(struct xdp_buff *xdp,
> > > -- 
> > > 2.41.0
> > > 

