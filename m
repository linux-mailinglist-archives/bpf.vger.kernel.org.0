Return-Path: <bpf+bounces-16381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 132BC800C97
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 14:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3E81C2104F
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E8E3B7A9;
	Fri,  1 Dec 2023 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIONVmiJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551D51700;
	Fri,  1 Dec 2023 05:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701438721; x=1732974721;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=URuhDZCjuzA01+d+qZ5meHL+Rj0GsJSp/jIpWQwxswc=;
  b=aIONVmiJ2pH1BfF1p5oqXTJVzjqzmvR3G6d2DVkfBjDVHRUSLpwhNho7
   Qe88HDllKVVFBm4QOsmWW4HBGC97gVRmilLvr0xrJC2CBBcYfTVeHR63q
   EIfRYXLFeu+6B/fubBoily2HhYeOX7oxalBjNci51YE1PUx0d7PuFtUUT
   gKvmeGozlFHzW0RsZZ2LqwseNx8Upa4p7arKyP9mXGZRYxlQqd0uIxunJ
   3PkkW/9tbDGx/na6cwcVVotyYYA5kLrLX3SRFqMWw/rdLBtUGf2BGO98i
   aFyBVVOlVrc27zCCCBxlIkMH+c5MaSVvai/ry965zmIZ67GHO1Mv+pK4o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="509884"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="509884"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 05:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="719531986"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="719531986"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 05:52:00 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 05:51:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 05:51:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 05:51:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/IgEYLqCxXJaKCoZR43Age+PzLtIEhVZ/YWKEX//VU3uKMfovbLEcGZQWGkqAg6o3HteLDj24W5206aPBaPIYhmwkWz49QwCq+M6EW53/ifzTPHm6caNHBXzYyroXD3mbUYucp/MQiogCasPr7jYwM2emRSoYC6JOy3T4r6Us98YI6Kha8IWwM/iPq0wpBjM/MyG2zNBVSkmc8/Fh3L6DwNl8+Li4pDt4bycwZoUwQXbmwHyfgzXEkZhA++WHPe0TST55labOXRevD9uo8rSWW9maEnXO2o3xS4aSR5FFlGts1ABOqh9iZQCK5wwoTSnDE9CzW56JDZtdqK/YfO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x8GdbX1CLFOlZMTl17a21W1Ypiz5NQ+d2lyTyLjJ40=;
 b=oAkrlBKDZ6G7ErI72PSZEzSIjlJf5el5kgDxah/cyAIWdZ0btL0YumeYebRKLU7LDefjadpg7JB+mx+K2q302YiqXXtX9xMUEEfB+XOc2Eh4Ztx0/UNby6F6lD0Syr3Lul8A1EQ/9aTnqCoq08UaZwt4LcKXIqhzIMWDpP4q6BN+Cl9NPFrKotbGNYzdSudPWgSCnCyl4wD5V+L/MEG42nQ7OJU8nFv0lq2pPuMGHwfV54DfydpTvzozAoIqudR/g6wA2T4SO3fi/eKi06/pdLC0G1163uqNw0nz+1/Colfc6KGG12dq7GouSZGRFlSQp7hzWXT0vn38ynoHMwoN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:51:56 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::4b41:979d:5c37:aab9]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::4b41:979d:5c37:aab9%3]) with mapi id 15.20.7046.023; Fri, 1 Dec 2023
 13:51:56 +0000
Date: Fri, 1 Dec 2023 14:51:44 +0100
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
Message-ID: <ZWnk8BVkkbdiEthm@lzaremba-mobl.ger.corp.intel.com>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-5-larysa.zaremba@intel.com>
 <ZVYQiAhahijwfN+w@boxer>
 <ZVWEl+Nx36HklpEM@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZVWEl+Nx36HklpEM@lzaremba-mobl.ger.corp.intel.com>
X-ClientProxiedBy: FR4P281CA0338.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::11) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: a50b5033-128b-4fdc-14fd-08dbf274ae50
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qXlc+LNjO5zxfA08r+Bh7i6/k2Q4e/KmPV+BHPmWr6MyyJv9MpG5m/32P5kusQxzwkavTnTQ11Eggdm7mPJkIXK2vx65L4U7Hk0jl2wwCHbNBtPFnUDTp9z9wm/60lNJ8hjlPkXP5pLc9r6p2CBIKpWFiDTbvLCGBqMclO/Whj20K9N0yMgMpIsJQs5munekZ6IVTbbrWz3N7shFNFoi/tmhsIjGl1lOT6P2/UjRp7YC+RoUHNEjsTN1rNKq1eZ7Ur02TMPKqFdJhJSBQJyYPkXS5u3XQLvm3fxgrFwNVb8O1ZfMbpgwZXGB55chp20zruOfa9G3Ejt5n3DBmWBDcO3unLKcZ+ffb5OUolZNKYYARfAI193aQAhXec+8NXpGF0RU6bVltNGeHDVc1X6ofZG+yEsP5WEJXD7TYvags1SKH7PpLM8oQpt2Q3b9mEjv1I50Gt/R6H5mVQRLSvhNHzUsRtTzOXI933L6VSH+6i61X7lBFN1mCDH9xJD17f173271QJa+6oKEYkN0CKjHx/Lc2YWLMte4cPozJTpM8IqXBowTC6AEQkhis9VIbOh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66556008)(66476007)(54906003)(6636002)(316002)(86362001)(66946007)(8936002)(8676002)(6862004)(4326008)(478600001)(6486002)(44832011)(7416002)(5660300002)(2906002)(41300700001)(38100700002)(26005)(6506007)(6666004)(6512007)(83380400001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RTk+p9gfgOMAEvA1OeeTaEC8cwZI206i3GAhZTPnptiAUakUxExMvaq2iHX6?=
 =?us-ascii?Q?ferl3RPHmDnvg88oYLafnhrC6kGpleSpaM80+xXtNv0nN5JOxiKqnuPcmaqJ?=
 =?us-ascii?Q?eJAIrqGaRTFYtJgTxLGGSI5SFavKwjFJW76ZcpnXXVv/XKyty51JBq5vE4Rw?=
 =?us-ascii?Q?g6uA04jKf/rSBW++5EdQ98rh3Vzhl5e/1IR93mLXeRim30lY7KqBMLdWIsx/?=
 =?us-ascii?Q?GVFJJwmJgo76PkAkiPTZ5p1n9EHG6ZUKUqgO4kJdz37M4Res2Rp0mdsjZICn?=
 =?us-ascii?Q?tI9R0BiNPa9hyk8E7EDzuqYB5erWkZSWm3315otIjSRWfLe5GsHZ5oDNFoEM?=
 =?us-ascii?Q?rpe22OxQ8WaofskDY/9cMeCBt3Xhk/DMfsm49cDE92+UipZiUO8ukSvGnDs/?=
 =?us-ascii?Q?J3K7dARiEJvWG+G6H+ta1HJ6YnUg2Ihg5IYkInVrlKXjb0+XK0IuIuaBKLVE?=
 =?us-ascii?Q?3nM4EtbvdKtHv2J+btoq7FOx/Hxz0QB5pb/K1n0sazfBU7HOn3g3DY8NJZNU?=
 =?us-ascii?Q?uZrsj1wUuyo46aPMeX6IFU/JlE6AN0HJh0c+U9KKpKHZ8+QCpJGzjBzPlk3Y?=
 =?us-ascii?Q?vqXegniT+gHbspjfT1q8qz36WpYWhpRfBw0rsxg3vwk5sF0jSZVJdY29nWII?=
 =?us-ascii?Q?OL3PjMhA+OhDapf/bJcUPCFt/+2/duxEUxXI0IS9/Q+RQkDy7VFUYybz3ELi?=
 =?us-ascii?Q?KhusYNcGodKRK+BmRDPkup2B/R0v8Y7qr/mBISYKszc1oj2s8N+SY3jxuwOJ?=
 =?us-ascii?Q?tERAeaqHMsCPU1WqxkHbLIxnk9JV7zV+tIpbgKfp6vUZT/ask3bWw69raLUK?=
 =?us-ascii?Q?M1uTQ8R1A7gcBFo0+6te5JxQSJuwB325NsMkwJWzJLOSlUPLenp1T2o8jbdp?=
 =?us-ascii?Q?Va7OQAK3OiQbeR6rUQyoGQyyhsDKwFZ0gP6l1YTTy9zW5bQzQ4kNrjiVB32v?=
 =?us-ascii?Q?ASlPyQpvtHRbgjzBylbi+JR3X+RxiPQuvnH+mpvFWSEPzlzldt5o2/XGEltG?=
 =?us-ascii?Q?JSHb5xfOWpQQcBOgL0w9h4LcZz/Wq1jdrAzMQ7YH6QWX/LpcRMtMcGqQ+k2l?=
 =?us-ascii?Q?/zv0+ES53CWP9pw8Aqaq+xF0aS5tO4Ywq29khT17ADgL6rC0vmAK6CwQ9cZD?=
 =?us-ascii?Q?D+ZyEoeBKcqihQQHy6pSZyK9zTYOg0zltiqiu+XlLsqHCOzhHjdmb9DJ8nMn?=
 =?us-ascii?Q?SZojmi6g4K29GbHrhCD3F+/ckk0jb6tfUdWUwwMDDs4fxENVa8DaDmhnL2+5?=
 =?us-ascii?Q?J3f9jMiyzIony4cqSgVGPTvSrqmkWNQ/hMFzIDB+vpmwuK7ay6WDxhfq5uFK?=
 =?us-ascii?Q?spTHea8nlW5zqoE7lSSLmKnYhDGMYh5qU4po5BTXpk2TOyI/5MI28WmHOIJC?=
 =?us-ascii?Q?KCSZD+huWEnGccKlL7Fb/EkhMUpbt4Jk845uoILdqZDph4v137H4lMq1tJc7?=
 =?us-ascii?Q?q5lbGrFERUK/lwNW7rW0BA0Pm/TVkPPB3EDSeasYV1RW7oVSIq0v7wDLE06w?=
 =?us-ascii?Q?N4P1NaWUnbNZyChN+zk0Ov96mRqEsiEi8aB5yjNHI2c734vQSkSc4EjGLkW2?=
 =?us-ascii?Q?uNQDTu3PJaui/zyT34y/452pgdygMyBKKqW+9G+SqfSqFmrytrNAFYHf38yK?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a50b5033-128b-4fdc-14fd-08dbf274ae50
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:51:56.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ws8seGKOdyYgki+XU/vnMifb7us9Eo20aWwO49Ednemzx7wyxEH5ZZ1bFw6FcUb8ahrDI+MlK6CNgXVE6iXZ3pJpN0afEVb/E/rysQQW7Ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8134
X-OriginatorOrg: intel.com

On Thu, Nov 16, 2023 at 03:55:19AM +0100, Larysa Zaremba wrote:
> On Thu, Nov 16, 2023 at 01:52:24PM +0100, Maciej Fijalkowski wrote:
> > On Wed, Nov 15, 2023 at 06:52:46PM +0100, Larysa Zaremba wrote:
> > > In order to use XDP hints via kfuncs we need to put
> > > RX descriptor and miscellaneous data next to xdp_buff.
> > > Same as in hints implementations in other drivers, we achieve
> > > this through putting xdp_buff into a child structure.
> > > 
> > > Currently, xdp_buff is stored in the ring structure,
> > > so replace it with union that includes child structure.
> > > This way enough memory is available while existing XDP code
> > > remains isolated from hints.
> > > 
> > > Minimum size of the new child structure (ice_xdp_buff) is exactly
> > > 64 bytes (single cache line). To place it at the start of a cache line,
> > > move 'next' field from CL1 to CL4, as it isn't used often. This still
> > > leaves 192 bits available in CL3 for packet context extensions.
> > > 
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++++--
> > >  drivers/net/ethernet/intel/ice/ice_txrx.h     | 18 +++++++++++++++---
> > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 ++++++++++
> > >  3 files changed, 30 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > index 40f2f6dabb81..4e6546d9cf85 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > @@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
> > >   * @xdp_prog: XDP program to run
> > >   * @xdp_ring: ring to be used for XDP_TX action
> > >   * @rx_buf: Rx buffer to store the XDP action
> > > + * @eop_desc: Last descriptor in packet to read metadata from
> > >   *
> > >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> > >   */
> > >  static void
> > >  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > >  	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > > -	    struct ice_rx_buf *rx_buf)
> > > +	    struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
> > >  {
> > >  	unsigned int ret = ICE_XDP_PASS;
> > >  	u32 act;
> > > @@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > >  	if (!xdp_prog)
> > >  		goto exit;
> > >  
> > > +	ice_xdp_meta_set_desc(xdp, eop_desc);
> > > +
> > >  	act = bpf_prog_run_xdp(xdp_prog, xdp);
> > >  	switch (act) {
> > >  	case XDP_PASS:
> > > @@ -1240,7 +1243,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> > >  		if (ice_is_non_eop(rx_ring, rx_desc))
> > >  			continue;
> > >  
> > > -		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf);
> > > +		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf, rx_desc);
> > >  		if (rx_buf->act == ICE_XDP_PASS)
> > >  			goto construct_skb;
> > >  		total_rx_bytes += xdp_get_buff_len(xdp);
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > > index 166413fc33f4..9efb42f99415 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > > @@ -257,6 +257,14 @@ enum ice_rx_dtype {
> > >  	ICE_RX_DTYPE_SPLIT_ALWAYS	= 2,
> > >  };
> > >  
> > > +struct ice_xdp_buff {
> > > +	struct xdp_buff xdp_buff;
> > > +	const union ice_32b_rx_flex_desc *eop_desc;
> > > +};
> > > +
> > > +/* Required for compatibility with xdp_buffs from xsk_pool */
> > > +static_assert(offsetof(struct ice_xdp_buff, xdp_buff) == 0);
> > 
> > That should go to xsk core as a macro and should be used by ZC drivers
> > that support hints. Useful stuff similar to XSK_CEHCK_PRIV_TYPE() but
> > check is from the other end.
> 
> Seems like there will be a v8 anyway, so I might as well do this :)
>

After going back and forth about this for a few days, I think this is not a good 
idea to include such change into the series.

But I do have to change the comment, this assert is mostly needed, 
because my code converts ice_xdp_buff <-> xdp_buff on multiple occasions (and 
this flooding code with container_of is not a solution).

Currently, XSK_CHECK_PRIV_TYPE() performs the most important task of ensuring 
nothing outside cb[] is overwritten, just fine. Offset check macro could be 
added in a separate patch to the xdp header (instead of xsk_buff_pool.h),  ice 
isn't the only driver relying on xdp_buff inheritance. This will happen only if
I (or someone else) can make such generic macro not look ugly, though.

> > 
> > > +
> > >  /* indices into GLINT_ITR registers */
> > >  #define ICE_RX_ITR	ICE_IDX_ITR0
> > >  #define ICE_TX_ITR	ICE_IDX_ITR1
> > > @@ -298,7 +306,6 @@ enum ice_dynamic_itr {
> > >  /* descriptor ring, associated with a VSI */
> > >  struct ice_rx_ring {
> > >  	/* CL1 - 1st cacheline starts here */
> > > -	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
> > >  	void *desc;			/* Descriptor ring memory */
> > >  	struct device *dev;		/* Used for DMA mapping */
> > >  	struct net_device *netdev;	/* netdev ring maps to */
> > > @@ -310,12 +317,16 @@ struct ice_rx_ring {
> > >  	u16 count;			/* Number of descriptors */
> > >  	u16 reg_idx;			/* HW register index of the ring */
> > >  	u16 next_to_alloc;
> > > -	/* CL2 - 2nd cacheline starts here */
> > > +
> > >  	union {
> > >  		struct ice_rx_buf *rx_buf;
> > >  		struct xdp_buff **xdp_buf;
> > >  	};
> > > -	struct xdp_buff xdp;
> > > +	/* CL2 - 2nd cacheline starts here */
> > > +	union {
> > > +		struct ice_xdp_buff xdp_ext;
> > > +		struct xdp_buff xdp;
> > > +	};
> > >  	/* CL3 - 3rd cacheline starts here */
> > >  	struct bpf_prog *xdp_prog;
> > >  	u16 rx_offset;
> > > @@ -332,6 +343,7 @@ struct ice_rx_ring {
> > >  	/* CL4 - 4th cacheline starts here */
> > >  	struct ice_channel *ch;
> > >  	struct ice_tx_ring *xdp_ring;
> > > +	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
> > >  	struct xsk_buff_pool *xsk_pool;
> > >  	dma_addr_t dma;			/* physical address of ring */
> > >  	u64 cached_phctime;
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > > index e1d49e1235b3..81b8856d8e13 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > > @@ -151,4 +151,14 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> > >  		       struct sk_buff *skb);
> > >  void
> > >  ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
> > > +
> > > +static inline void
> > > +ice_xdp_meta_set_desc(struct xdp_buff *xdp,
> > > +		      union ice_32b_rx_flex_desc *eop_desc)
> > > +{
> > > +	struct ice_xdp_buff *xdp_ext = container_of(xdp, struct ice_xdp_buff,
> > > +						    xdp_buff);
> > > +
> > > +	xdp_ext->eop_desc = eop_desc;
> > > +}
> > >  #endif /* !_ICE_TXRX_LIB_H_ */
> > > -- 
> > > 2.41.0
> > > 
> 

