Return-Path: <bpf+bounces-15171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182317EE1A6
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 14:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389311C20940
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D39430F8B;
	Thu, 16 Nov 2023 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgIheVib"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5319C;
	Thu, 16 Nov 2023 05:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700141979; x=1731677979;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mboqLyz+lBLXQMQKeJ3r9GXOM/1mivampUmD9n4ZF8Q=;
  b=fgIheVibu9+Wggr3gAOX1qt7gzw1EECi7Nybc+qiA2WuHQtFgRs1bsq0
   HYS7TYlhE2aZOME66RwgkfJ/aB30FFnOCUFi9Igze9maHF1J+FDw1nvP6
   anCgskJtASNsCViR+/D9aezeYamxHHqv2x/RfaVzCcxhlB/v1XGqjEgV8
   OjGcMJ2nfeIhfNnI/YyXHYQH43eaBByQHTvmQN3MCi3C8gwaZBxlFwFVw
   NPxiscthdVa6VgFbFhVqgiEhWnbuyBE/WFE5jO0LXocY3/2QwDgakGNon
   tRJ8jWUZZczyDnMSWyEK/FsDlPLQkekJNQsbDCl0j/TkvljtrYBej3qsH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422180085"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="422180085"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 05:39:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1096785435"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="1096785435"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 05:39:38 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 05:39:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 05:39:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 05:39:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 05:39:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZNHV5gFTngH3Hno2SZZMk3bunIGtM3KgNj/5o9PfxRkd51fPZameqycZVBROWFFd8HEopGS+EwH5hTHqeSGzwWvShiVtNOxkkdcNMyPfoFQt0i2cZ+MqclWAXlCKGtdOwOXg0U1vSmx2gSfWW/qcJ8QVayUdVHB83kviTzs1OO/whgGEiaHkvus+im4Bo05BADxLIhNY6UsMyliAMZCfVXUjMCO0cC9Pxh5nHxA6waBkRWVKWW287kQT7bAB1SXtEaXA+Al21IkF6BBCS9QkjAxcUVWOysIVQirtoIWfW2wHEdLAll5wYCiIWPJq6gS/LdSedu8Ws0tAzV/e8cMPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLfUh6O0Fmua/Ok0rdA9P3PzfQPzb7h3Sfj9PP+VJck=;
 b=dHTddJ2pK9fb/jfriwt2sCoDYoeVdLI0eRWscJ3mCcFfopqSx5ZG0rBvGiaKwoTcDZbdp0EqzUwtk7EbIdZke2xaeB7JE7mqX9YS/j2dGx8MW8zUXir9TVA2MJT4YLNrRrDNkBWi8+OIgtd0OyXfFrxWRUR0xfoLvJ5u/B4wmBBlvQoZh1lpGptPX45g6XP/6f6DY1uQx2hwnICIWXZ4RabLXkMrDqglwX8ve3W6+ikjK2YhZO/TyQN0Hogi1BOunqfe0ZVI9D+5Zi3/7kN7h2JjZ3Frdvxijs94u/dsMDP36Rc6WB8/rskXRGhznLfBbJvT8ZWi5+egQ3x1haaxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA0PR11MB7910.namprd11.prod.outlook.com (2603:10b6:208:40d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 13:39:35 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%7]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 13:39:35 +0000
Date: Thu, 16 Nov 2023 03:55:19 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
Subject: Re: [PATCH bpf-next v7 04/18] ice: Introduce ice_xdp_buff
Message-ID: <ZVWEl+Nx36HklpEM@lzaremba-mobl.ger.corp.intel.com>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-5-larysa.zaremba@intel.com>
 <ZVYQiAhahijwfN+w@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZVYQiAhahijwfN+w@boxer>
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA0PR11MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbebbac-fd05-4bda-e2ff-08dbe6a97896
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8Qjcy48EpiIcnxq08o7gRMSxz19xRL8Pkxqte72lCNLZQN9A8etQaLwWeuIweuP94rTX2EmlbiXCfWWJOG+SXhmwnt6aV84NC30JWBXtIz4m74s5IYQ2dZYWmBRNyGXAIy3pr8+6ecuwYZFHudjkpf8rQGMB9GBFZWPfgmMiBw3EffEUOeHKuvndUhaDHEIGDThWkSNdjtPNr4dmFxwPzFw1mMUPGi5j/MmmSG5s4sE8xInjGGve7U+jFQk+qY2VcS+1bO9h+AxzIUtkiLN9GISMziVt/lGfUw4/igzHs1KY3K2MpYuJR6OPelUJzAct1ZME3U/6j+59Ihy2SxWMAUFC/GrxthpPiWbIZiEah06ziqni5ufDo54vV35A5X0Cf+k2m8UigoJb2K6e+Hu/Ixpp5Ho5tyflFO2I7FeCvI0LXnX9kOe2tNJZtyDreEfj796sA4Z4WlqgUaVe3DT4D1WVVROYdH+Z4lE7rgwDiN8q+OLeGb+irPpU0NwX/fEkTNQAY+yK44afrQhk6gj0J/r3leGRi+c5CDBDXT67YX62Z+LSV6jKsOIdDbPTtdZh+uerJiGkaAMqXjbSo4Yu5gW95r2t4TOv5F943d81gI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(6486002)(6512007)(6666004)(83380400001)(6862004)(7416002)(4326008)(44832011)(5660300002)(41300700001)(6636002)(2906002)(6506007)(8936002)(8676002)(316002)(66946007)(66556008)(38100700002)(66476007)(86362001)(54906003)(478600001)(82960400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J0m86ckFcDOTrN4f6oI1QizXR7MX4N3eYa8b/AEMy+l7QboKiBOK9WX1YCVs?=
 =?us-ascii?Q?7kcQ2JJYCNR6KfjLCQ5GSpe+VkTKZWT8pzski+pVAYnepr48T+UpVs68Rb/e?=
 =?us-ascii?Q?qD8UwGp9ECgNlYvuZAUJpg5tM8LD8O1CDkkU5Nn4uusHp4mpLyMF+YeXB2qM?=
 =?us-ascii?Q?hAN/zqeJIrGn+zyt2nSW3qpfafnVdDr3ssn1SR9MaYLiFkIdK2OvlMI0nsKw?=
 =?us-ascii?Q?duHycBh7bItv7G6F+UJr/d1qwqtC5oRRmWpDDBLKbXJIIgQ6oA0CH6mDH3qP?=
 =?us-ascii?Q?PUbHstm6j8LtV1DzlcNSZYuLMgVcGp9/Yw+4JCzLv8DjZUL6Tn6RuYcYnfyR?=
 =?us-ascii?Q?WuwCja6t/ceZ6SQKkGhTCq5saI6lqkSYuqUGPXH/SOsJWIsWh/VMhoBN7Ljh?=
 =?us-ascii?Q?EBnZiJ5IQanF9RAJt876VmaMlIFcrKry9ieCVExcV2kXnIFwC2ElYyvPQq8T?=
 =?us-ascii?Q?f8kJ4TowUIYO5aQnxuCKgLy34sfs+Dc+NHkins7tYbE+YA6OM3Zx5DpFlRdg?=
 =?us-ascii?Q?XMbz1/EGtXHANCA5ZoUfeYCAUL7zkSBFiao0DNzyc+xbtxHEVt4tR4WRPKD9?=
 =?us-ascii?Q?ghp3sHvYVLoKpkhHltZTxp2q3vn++9K0Vqa0AQIae5EHU+zbM3PLPlvY2vyZ?=
 =?us-ascii?Q?wwrlY6Qo4vnzEQb+sxKfwbggemBmUQU4xkIGtPfrOcVPB+KbGhz9h1SuZhEd?=
 =?us-ascii?Q?JkRGYZE+g3HOHdskiYf2wmBzJmoow4H+MxdFGpWnFrFMPVSaAB1BpVubwnYX?=
 =?us-ascii?Q?0mYQXIATjvyAlN7rvEffuZcEdRLVVTppBZ5Ejr9uRLuF5GtZikgTDYRZAt+R?=
 =?us-ascii?Q?48IQN/vPBF0HUcglbG1oTb5XJu1JjygDjEwgZUJuJe9JSiC/WJs8p6S7nVrJ?=
 =?us-ascii?Q?hw+he3ZcVIlZfs5ZOBc3Crednar+JynpLDYabw7uCbeXSyHNtjZCoEos33fG?=
 =?us-ascii?Q?O+h+3nkNPp0yUK1EscCFBqhAyTyNS4KAs3lj4sFrGZBk7H98t61yfKlcMpLn?=
 =?us-ascii?Q?hVmEsHHWHGXJ1hZCWrxDw9A8uZGQG58pOWLvRgyIz4jBlwrXw2AahGG+/LUo?=
 =?us-ascii?Q?s/8mLXHNo8qBtsigHnFCoPtwGQHvgxik6ymLR9gxGRysZPqW1YVazHYPK3ub?=
 =?us-ascii?Q?pQViBbHqCCuvKQcJntyzYAIf7cOgwBX1E5NLL3DrGZfzo0WLsV0+NttA5idj?=
 =?us-ascii?Q?PSmBH8aJgSQQDc64I7q9x210T7H95ymTW9SX5YmBNrKF5jkNSHTHN5YV3+HM?=
 =?us-ascii?Q?nxMP0z3dIn7qsVGYR9cpr++u8wDPKYloR79FI2iHm8usMYXQbpR0/fdTDRUp?=
 =?us-ascii?Q?1tsSiIPq1Ml/ou74yt2IMZvBw4XwNwdlHtt2siZLRjEdPAuFg6mWhtNdHXol?=
 =?us-ascii?Q?4UhP6zRqnhYSZYmbtNrwqUqcOGrkMIa3Jep3KKgd+5ryAYO4BzKliyfpiUbq?=
 =?us-ascii?Q?6vCbubNZQnj9IIIaxuBAFIiT2vFGNC+x+GZwJiOr24tWRnuZKlHHxuH1JJFL?=
 =?us-ascii?Q?+rLHCjUXamciJX7I7mfgi92SGQZ8yeeo03fCuovvapj/yWI5BInN0SqpMzU6?=
 =?us-ascii?Q?7saK4Vx4Brsl87upDN6dQVi6+A9LOqd34T7NrAl+MjsX38TGATwfkTv6i/yK?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbebbac-fd05-4bda-e2ff-08dbe6a97896
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:39:35.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpeabQ7TuG2bTWe2NQn4N8lyNNSAr2OdSmO8eElpVzQT8zO0cdpzSnc3J/1XYp+3UZWhmZ6gIzyh4wPC5rLGMz7Lxw/ihjGvIuKuGxn49Lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7910
X-OriginatorOrg: intel.com

On Thu, Nov 16, 2023 at 01:52:24PM +0100, Maciej Fijalkowski wrote:
> On Wed, Nov 15, 2023 at 06:52:46PM +0100, Larysa Zaremba wrote:
> > In order to use XDP hints via kfuncs we need to put
> > RX descriptor and miscellaneous data next to xdp_buff.
> > Same as in hints implementations in other drivers, we achieve
> > this through putting xdp_buff into a child structure.
> > 
> > Currently, xdp_buff is stored in the ring structure,
> > so replace it with union that includes child structure.
> > This way enough memory is available while existing XDP code
> > remains isolated from hints.
> > 
> > Minimum size of the new child structure (ice_xdp_buff) is exactly
> > 64 bytes (single cache line). To place it at the start of a cache line,
> > move 'next' field from CL1 to CL4, as it isn't used often. This still
> > leaves 192 bits available in CL3 for packet context extensions.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++++--
> >  drivers/net/ethernet/intel/ice/ice_txrx.h     | 18 +++++++++++++++---
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 ++++++++++
> >  3 files changed, 30 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > index 40f2f6dabb81..4e6546d9cf85 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
> >   * @xdp_prog: XDP program to run
> >   * @xdp_ring: ring to be used for XDP_TX action
> >   * @rx_buf: Rx buffer to store the XDP action
> > + * @eop_desc: Last descriptor in packet to read metadata from
> >   *
> >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> >   */
> >  static void
> >  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> >  	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > -	    struct ice_rx_buf *rx_buf)
> > +	    struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
> >  {
> >  	unsigned int ret = ICE_XDP_PASS;
> >  	u32 act;
> > @@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> >  	if (!xdp_prog)
> >  		goto exit;
> >  
> > +	ice_xdp_meta_set_desc(xdp, eop_desc);
> > +
> >  	act = bpf_prog_run_xdp(xdp_prog, xdp);
> >  	switch (act) {
> >  	case XDP_PASS:
> > @@ -1240,7 +1243,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> >  		if (ice_is_non_eop(rx_ring, rx_desc))
> >  			continue;
> >  
> > -		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf);
> > +		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf, rx_desc);
> >  		if (rx_buf->act == ICE_XDP_PASS)
> >  			goto construct_skb;
> >  		total_rx_bytes += xdp_get_buff_len(xdp);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > index 166413fc33f4..9efb42f99415 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > @@ -257,6 +257,14 @@ enum ice_rx_dtype {
> >  	ICE_RX_DTYPE_SPLIT_ALWAYS	= 2,
> >  };
> >  
> > +struct ice_xdp_buff {
> > +	struct xdp_buff xdp_buff;
> > +	const union ice_32b_rx_flex_desc *eop_desc;
> > +};
> > +
> > +/* Required for compatibility with xdp_buffs from xsk_pool */
> > +static_assert(offsetof(struct ice_xdp_buff, xdp_buff) == 0);
> 
> That should go to xsk core as a macro and should be used by ZC drivers
> that support hints. Useful stuff similar to XSK_CEHCK_PRIV_TYPE() but
> check is from the other end.

Seems like there will be a v8 anyway, so I might as well do this :)

> 
> > +
> >  /* indices into GLINT_ITR registers */
> >  #define ICE_RX_ITR	ICE_IDX_ITR0
> >  #define ICE_TX_ITR	ICE_IDX_ITR1
> > @@ -298,7 +306,6 @@ enum ice_dynamic_itr {
> >  /* descriptor ring, associated with a VSI */
> >  struct ice_rx_ring {
> >  	/* CL1 - 1st cacheline starts here */
> > -	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
> >  	void *desc;			/* Descriptor ring memory */
> >  	struct device *dev;		/* Used for DMA mapping */
> >  	struct net_device *netdev;	/* netdev ring maps to */
> > @@ -310,12 +317,16 @@ struct ice_rx_ring {
> >  	u16 count;			/* Number of descriptors */
> >  	u16 reg_idx;			/* HW register index of the ring */
> >  	u16 next_to_alloc;
> > -	/* CL2 - 2nd cacheline starts here */
> > +
> >  	union {
> >  		struct ice_rx_buf *rx_buf;
> >  		struct xdp_buff **xdp_buf;
> >  	};
> > -	struct xdp_buff xdp;
> > +	/* CL2 - 2nd cacheline starts here */
> > +	union {
> > +		struct ice_xdp_buff xdp_ext;
> > +		struct xdp_buff xdp;
> > +	};
> >  	/* CL3 - 3rd cacheline starts here */
> >  	struct bpf_prog *xdp_prog;
> >  	u16 rx_offset;
> > @@ -332,6 +343,7 @@ struct ice_rx_ring {
> >  	/* CL4 - 4th cacheline starts here */
> >  	struct ice_channel *ch;
> >  	struct ice_tx_ring *xdp_ring;
> > +	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
> >  	struct xsk_buff_pool *xsk_pool;
> >  	dma_addr_t dma;			/* physical address of ring */
> >  	u64 cached_phctime;
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > index e1d49e1235b3..81b8856d8e13 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > @@ -151,4 +151,14 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> >  		       struct sk_buff *skb);
> >  void
> >  ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
> > +
> > +static inline void
> > +ice_xdp_meta_set_desc(struct xdp_buff *xdp,
> > +		      union ice_32b_rx_flex_desc *eop_desc)
> > +{
> > +	struct ice_xdp_buff *xdp_ext = container_of(xdp, struct ice_xdp_buff,
> > +						    xdp_buff);
> > +
> > +	xdp_ext->eop_desc = eop_desc;
> > +}
> >  #endif /* !_ICE_TXRX_LIB_H_ */
> > -- 
> > 2.41.0
> > 

