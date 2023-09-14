Return-Path: <bpf+bounces-10052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 038EA7A0AF6
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733AB1F24A7D
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539722E6B8;
	Thu, 14 Sep 2023 16:36:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B6D534;
	Thu, 14 Sep 2023 16:36:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C541FD7;
	Thu, 14 Sep 2023 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694709377; x=1726245377;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ifBaNdhdZ/+ruopcS6oWLUVJ07w+RSR8ZC5Lm3/Vb70=;
  b=fJzXbfrcdgbBKmFdN/mRDG3+iJNFbDNPY5vyleICD/t/6h35QOPpWbFT
   QyFFRrYdNWulf1gHyvrOZ2/dNYOiZYSEzX+ajVzeAamJImL0/SYEe1nLW
   GJTI6oFv2E3zK6GBROrPuAF4XZdgS25Y/8WGERemST19ELk7kBH7PyaGQ
   z7hBgjY+BfgCG85ycpGv3xE44rdU+tCpFlgWp7yMVesjLlXCP9/nBkonA
   sIIeSe9tp14qyb++lprbBMIjSXWgwKjFBet0HKjgUabkS8Tg4sm2Z83xe
   95rhCzwk3sRvOpb4VxJ3uQn9x7224EQb0BVjZGSWuSO4uf9lO2ZTvElFl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="445445970"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="445445970"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="779723232"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="779723232"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:36:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:36:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:36:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:36:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:36:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBIK+U7nH3rVvF2K5sciwAG+80oGqdCO67iw1rzft79ssxITwHcw53GaG1AEwxlnUFr1NGvdS1of1aIYy137xB9Z2hLmD9EiRdglHTC3q5lqCm08XxSViQer+vXlIvC6FEidXmXi6pI5OkxtcAAegK2r541lGHr13gdtwrJMr9yVtBZdNBWuL8NSTN5e6k6tj8nEG3GbTW640PaS1Md1n5tznIjMaSzvUTg5FY2ND7fF6yIw2QmK3soYaivJM1tGzLaQa8hZBi7YINxNK+2llQfRkHIgf/2xmVdW0M3rjP4Q2MkmNE8Xe2tBwpeIrUQ+hwUChB2siIxkwQzO6QfL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo8ZfmbQDlxS1TUVOY5t3+1jRpLCPx0gpGQprxrsww8=;
 b=R43XLBFIgEuNi8cxB+mgnDQ+9cn1SLxH/D9kecy5JKynjR4c6b0GY3BoLjbOGbiyR2AyTleBliIKjIjmSpL4sBvruJkjJ22T+9YQ1N+u73h4xCJA4iOXw8TC2tCAZAArn5aHehagr2KR5mr895ddc8xNaQuftcYjqdF0p4rkEsT/8N2l94omibVEqs1A4xkLNSe5ZSc52I3gh0urAotKeiL9uQgryk3wieaLwkqdxo9uGBdj/d8qF0K15/IjwAgIv1IS+ahpgyxVSQP3Rq3UwaOxGDImokzGKQ1jHddfPeAW6dRQDOJNcE0c1xJ8eA/+WSqZLRVxT8ZmeSrLcDxkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by LV8PR11MB8534.namprd11.prod.outlook.com (2603:10b6:408:1f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 16:36:05 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:36:05 +0000
Date: Thu, 14 Sep 2023 18:30:24 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
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
Subject: Re: [RFC bpf-next 11/23] ice: use VLAN proto from ring packet
 context in skb path
Message-ID: <ZQM1IP6kx1WnsUr8@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-12-larysa.zaremba@intel.com>
 <7bd185f5-13fb-692d-a0d0-95d77685e9f4@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7bd185f5-13fb-692d-a0d0-95d77685e9f4@intel.com>
X-ClientProxiedBy: FR2P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::16) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|LV8PR11MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 9452db3a-7ede-4c62-5e24-08dbb540b0d2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1qV6TEHls2js+/JyPymqz1N9x3Dn0ywZVeXLEsR7Nu9d43q7w1ypbySK07oP3L1YTPLN/3hQUtSZOSjQ9QgurxXHjYaY1qF46cGQB6sp/RPqPZ9HiqGWtQWnfIaVtK+4E8GEb7zvy1bdChhmugCgVauyMQ/lYjVisgG/F3QEIrord1dnhV10lInoOWZ7Sxj8Un+cQVCcAcBG/vsvanuytIg5ssZDcObgsvYhunA9EOmHidC5e0owc2u/44yaL79Kwl0mFAxmOOGrvp5VRTDKH5hUzv1fmt1q9lATLfh9fpHOEbQB4+FOxTsu00ki+v6PbxMX0XRVJM9yGtQpjdRbTO0T0DgSofnosuJbJtwk27jSXLWS+ukYtZUxT2jOe+MqctF5s7SG2znEgicP4E7h6/PoUd4qhGl0kywWv8iwKxgmVm/DNPactKGZYIxmKU1tPIkqEBkJW43EwNNOO3nRM6D1w67SWSDpgkKnGqtvxeMIa2b5UQ3F57wT5UAN0fIyaZZNaYAwO55t44hBo4mBUwoTUv4Osxw+AdCJ7y+GbfFag3KQKWV+44Z87NnLdN5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199024)(186009)(1800799009)(26005)(478600001)(6666004)(9686003)(6512007)(6486002)(6506007)(7416002)(82960400001)(2906002)(5660300002)(8936002)(33716001)(6862004)(4326008)(41300700001)(86362001)(66556008)(66946007)(66476007)(316002)(8676002)(54906003)(6636002)(44832011)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hUnhrPe6KPsX0Pete96b4Bhwcj5LH20cbhpr10bz12Tu2q55+2TjQA2FhItZ?=
 =?us-ascii?Q?6c3VTb9kqIZYIVa/IHAa9pSVzpEkNVujDlpa3JLJACBIfvdqGUlwSbyixek6?=
 =?us-ascii?Q?Tprminw9yHnvs19cmBivwWw/wAQKIbXcP8EO7zYcHCC7MA+GMuoK3xm752HA?=
 =?us-ascii?Q?Rg0ZuqK4DhEs1QNuybv1tLcFf8wrcy3G1+rjt11zS1P97LfTYROHQQk4XsFn?=
 =?us-ascii?Q?oZH6wK4zQoYPsrSfDNDQeNeiPDgbiGukBf46zxbjxb9KkB6SwwLHqWx15cgs?=
 =?us-ascii?Q?uBwq/EH1asdMiOKp+Hd0vX75vwt6RDnVno5Jwx9nM4yoRM2GgXUsTIr/Pp3h?=
 =?us-ascii?Q?g/RrxZFiR2vlCYgIbjiULSFWDIiV0rYuh2/5v3DSLnEuXVPMqPaH6U8rx9Gz?=
 =?us-ascii?Q?qIGV5uIFz2e/aeBrHcJScR1VkbHlpSn8NdfYW5MLkPjF+iUnxokriXzVnjeX?=
 =?us-ascii?Q?dRZl19zkSqRAP1EooTSRd9z2H85lmTxkVcIY1vDo033/jPYULEmpE2Hk9y4U?=
 =?us-ascii?Q?fZIH7oZJDBjNU9NTVBKnhisfv+suK2NaKy6RZyGhHI++b1GHFSj3FSPeRTyj?=
 =?us-ascii?Q?lzgZqfUnE14w0fwh8m6wVDNiB5ds6XOKuaqzHOa2CmYYLTPtrV8gnTkS6J7i?=
 =?us-ascii?Q?Ds9gNpHjh5bP9Q0dzBdjkZFPeWSiK4vaoj/mH7j/3lCri+hwK2ZTWAPTIZKJ?=
 =?us-ascii?Q?7uEaRim9jztZtqViVpQqpUj7QCwerPz76Gm6ITMweWptSnsdhWYinfFT2dGg?=
 =?us-ascii?Q?fY1+06PPKX3oLOwgHagZXJyBvSfTIPQ5Zty9P7YF+38ZWOxjfeIKiyVzpUMk?=
 =?us-ascii?Q?T6aHOHTvv1P8SPx3IwOahI+ohnlTDahKHzmMH4E1oLH/y1GKrqGd1fOmlIBX?=
 =?us-ascii?Q?wguWmz8OkxLWfEmj9YIdE8DZDQ+4uEmRgB4i/Fi5SzzFypIQPT0nONoDFB6f?=
 =?us-ascii?Q?F/iCbwBZSsWrtsN8ns5Q/5NYASskv96ZJT8SSAWxceBicVTH2gr2F5dtWQkJ?=
 =?us-ascii?Q?QVeVCmNBjr+4kSV9Q6jOfE5R/Dadmjt3iGuYl2NL14JHJ+XW4qFITnWTolI1?=
 =?us-ascii?Q?ENB3eqXAqx1gXlacICff0QZaO5nkomHkSJX6XBBgXvBPbgyokmqBvANiAv6A?=
 =?us-ascii?Q?0FzKmBwUnh9F5Tr2PR7w/cbJLi07LTUnpHTVdqWnhMPA2x8UZeDVX6W+AKqd?=
 =?us-ascii?Q?vlmxysmTeYna8ljzhJAHzD0ZXJq2F8LrOG2h6kwCBKwHV2oVNbqD4IMiatGl?=
 =?us-ascii?Q?eOkKGt1DRFLZWKBmfdPfom5p7gbeRm3MdWgKTtvgHtbO/KzXgBR8XRjjfTWF?=
 =?us-ascii?Q?wEicqPcMQ+stuEmOwXelKXwW7jggElSXdc0RnjYxWWYCFELfZf3yDh/dhJPq?=
 =?us-ascii?Q?yhc9RG2kKbJXKsSeGO0bpVH/+3eE2LmnqC5JGX6M9KTKF/EMQ8D94ORwT3ZX?=
 =?us-ascii?Q?o/I+2qyExCJrK2qbIgP/EPsa0+zE6uC0miBJ02wBiZgtTumG1qNmoaGFBzgD?=
 =?us-ascii?Q?8L+JoS+IWn8w4BTHWGoHpRciZmkss6shjr0kdrozPSx4PFJRslzBVgpyvPgy?=
 =?us-ascii?Q?p5q3ao6uWMBYHYbIlM/s0IlAnE9LjMP7kGYLQ1zUM+lKSEKbJhULtk7AzAAT?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9452db3a-7ede-4c62-5e24-08dbb540b0d2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:36:05.3657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjGYCN+bRSlAmCwMIigBCzTKHIDs5EfgBa2Z5tSk2QpshF+qNJBEXKeyl2vI9mVza5ZuKLSc5eUxWhYcRSABHgNWQrzUX5mCfLWCSZHXd8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8534
X-OriginatorOrg: intel.com

On Thu, Sep 14, 2023 at 06:30:32PM +0200, Alexander Lobakin wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> Date: Thu, 24 Aug 2023 21:26:50 +0200
> 
> > VLAN proto, used in ice XDP hints implementation is stored in ring packet
> > context. Utilize this value in skb VLAN processing too instead of checking
> > netdev features.
> > 
> > At the same time, use vlan_tci instead of vlan_tag in touched code,
> > because vlan_tag is misleading.
> 
> [...]
> 
> >  void
> > -ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag)
> > +ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci)
> >  {
> > -	netdev_features_t features = rx_ring->netdev->features;
> > -	bool non_zero_vlan = !!(vlan_tag & VLAN_VID_MASK);
> > -
> > -	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && non_zero_vlan)
> > -		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tag);
> > -	else if ((features & NETIF_F_HW_VLAN_STAG_RX) && non_zero_vlan)
> > -		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021AD), vlan_tag);
> > +	if (vlan_tci & VLAN_VID_MASK && rx_ring->pkt_ctx.vlan_proto)
> 
> I'd wrap the first expression into ()s to make it more readable (and no
> questions like "shouldn't these be three &&?").
>

OK
 
> > +		__vlan_hwaccel_put_tag(skb, rx_ring->pkt_ctx.vlan_proto,
> > +				       vlan_tci);
> >  
> >  	napi_gro_receive(&rx_ring->q_vector->napi, skb);
> >  }
> 
> [...]
> 
> Thanks,
> Olek

