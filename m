Return-Path: <bpf+bounces-9196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F543791A50
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 17:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430AD281005
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1406AC14D;
	Mon,  4 Sep 2023 15:10:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0B3C20;
	Mon,  4 Sep 2023 15:10:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478D01A5;
	Mon,  4 Sep 2023 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693840213; x=1725376213;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HdKwtc/IlUYd/lYBnJzHZ5d/0r/PuGW5UbCQ/8mqtsM=;
  b=IZ+lVTNspC6iYDfpIsgmIAb1wVKrE9NzShOxfSsOVxVKnTprpGCaeqEB
   odVcMpTl8guU4mrLGB0R6aMjypN2KJELzUCK9QCHAC+XoM6rjXXTPJH4J
   zbOetk6Z5Oh4AwZOZhQ7Kg51n4eUhVBTpcnJa9+8ymthBPpRPJqkVIDzc
   ThawV6AZXg+DR541v1OhKhXTiZzqJ3QHDpq37JFhUB1eN6XuWbX1WT6dt
   +PDk7iphuMaYpS8GNwI1hmOwbZloldR/sGj9WCN2m2zZj8tQKOfmPfpuf
   xyfgYqCpXiUQbCUz0kdjnWF0vbUvRscsXwYVnrUQr1xGJ0bPt4s3httSE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="361646034"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="361646034"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 08:04:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="740799012"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="740799012"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 08:04:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 08:04:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 08:04:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 08:04:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 08:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1tmVnv90h9MJsfRNROXL2mpXlu9h5xOVZG/zW3lk41T9p+KwF/q2+FFFEfpXUG9EQCDreI5cDMFxTbPzuUYAmU2PID8v0iiijI2rMSEe/QPrnpU8UB/aCvAYUZ6d4T55yT0N3m9naLT45NRm7BT2uddTD+QzErZgm3DzBkV2aUaIVr6kh70RJ0nCXP9ZTZ9KYGzjSBgIPGTqlxiLg+gMGeWWOuqdW72EaGzqUchB48/9ggTxbgrp135gB7Kr0JrdKzihwUw+3g3SMX+/rQfO3gDFZqG9/h8liPsp7SKEObjGoN2P/Q0iONPtFNaxlC5yeolNWHYyEKkx7C+b1+vfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukm+wunnp3Nne1gxIDLx2wN4gbUefxDGXHd63AfPVi0=;
 b=YyLQG41WB5fVICeIIH5ynqCNisDWlQHvsXNC5hnQuq9TYjMpbD5SrULemDnCGSmzzUm9Y7UbYFZO3ScR6xn6g4ZbKyuCwThU4+LW7wll5n3rnDaDQGYNHXr7FCDm4nL/g8WFuM24yiJccG0SELXpTrH/4FH8n4EC//EcJkZ+hd7FRRg67uSCZsjPsXoNeF0vioPv4F4sVxpcYxda0HX3BTyAOQ/kL088H9/nE3HmM+80uRBjJbtL3SO5eJa4em2K64gWGfcoTAur7zMUKdrTsatO7IJcMLqV6cb3JjZvhKGyh/8KMddYL2syteDliG1Y6rJUOnhAiuqz3IgFo/vfcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB5534.namprd11.prod.outlook.com (2603:10b6:5:391::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Mon, 4 Sep 2023 15:04:34 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 15:04:34 +0000
Date: Mon, 4 Sep 2023 17:04:23 +0200
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
Subject: Re: [RFC bpf-next 04/23] ice: Make ptype internal to descriptor info
 processing
Message-ID: <ZPXx950bIsoQ5fpB@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-5-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824192703.712881-5-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB5534:EE_
X-MS-Office365-Filtering-Correlation-Id: 27027e3b-7106-4e62-841a-08dbad583fd1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2nwbI+i+/lMFja358WRu6q6jhC75IQfnoTWGeOCAJHFAVLzrpsQI/9MJyEJnsKN3/WR0r+u5PcrTR47dNC0MwiJod2tc/dl5UGuEFMQAKIxm2ttWwKv+s2z1OxI7+5w/bsBvzGvf2lhSh5121Jaih6AKM6WYXz/lH+rVPzZkKC4W4Z2+KykrcxU+E8mzCqE9Uf3Ik6kJ9BpC0aFQ0yEp8inXhWY3l7/2i2uYVz+qPawUh/hYaU8q6MMY+SVwTYbSbqE7rgJnyJqxyJCCIKZ+tPyO3+qaExfv02mVIMUqUezkQMDAjWsx966du7XCEG0FnD2Yhbw89SxVRQoxwVKggYAYZm072f21PRP44QW1JwMRfzncJxAKOhzL7SoeyEMUKifL5bIWzk3vyFa9eiiJ081AON5zjKjF4n4gvT0PGWretXn2JeZcO0o+B5wyqfM9NTgNduDawsLZwATqSLhM2Kmd0D1+fQd36lfXPr5EwLZp1k0I7DAK0AWKK846keolVW25yn9vNOV7JSmjwBQb33IEX2TPskkHTfQzm/wToOzeJlaqLznUZPoxXDZ/3f5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(396003)(346002)(136003)(186009)(1800799009)(451199024)(86362001)(6666004)(5660300002)(6506007)(6486002)(44832011)(83380400001)(2906002)(26005)(7416002)(6512007)(9686003)(41300700001)(66476007)(54906003)(66556008)(66946007)(6636002)(316002)(38100700002)(82960400001)(8676002)(33716001)(8936002)(4326008)(6862004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?voU7Tpst/yVba98wEY/64kZ5naZEXoZQz4uYrqom6yWu3tIdjirB0Lf02kk2?=
 =?us-ascii?Q?IHJSf0agY0hV8qwbpw2Ps6Q4s1TLy1sCUuWsj3C8LgtQl+IZv7lnbq5+QeFo?=
 =?us-ascii?Q?Pwt+0aGleV7I/DqUs51X/q+qnK5foqP5untmKehxhaQnhg3EBJzi44xUBgcm?=
 =?us-ascii?Q?EhvERz08MS7mxCTK/9EOPjb/QZ3DNXV3Wa/zv+M0Rywbh2vsCqfDXNgOmQK1?=
 =?us-ascii?Q?Bt/uAjWDyNH4Zb30OTzUhJAzWNEqccmr9l/otuGFFKIsTB3HDNJbNf2re8t4?=
 =?us-ascii?Q?9/SxQULboXd11TnppeZXcRteTO1gHEV0ozw5BSKeukgYMsFY/T2rWrq4O30i?=
 =?us-ascii?Q?yZnZKaSYTWv7v9f15Z/JEAjAvCLMua/jPZMP98NSp5vUdOkxzZscKEQWRBnr?=
 =?us-ascii?Q?nEAfFzChR7QIt11jJvam31uFG0RBHLCRoS4bchETSYm+Kh5wI04tW0F9ipNe?=
 =?us-ascii?Q?z0yMO3KTU0s54C+b+GAVzqQE4H3SXidv7YHDLd99T7kPVJXEkI6WFe98wLJx?=
 =?us-ascii?Q?fd3waUrNdm5h2jfb3ZBtjxAkQ7t2yk1DfJU5vH6+Ucwtl73A7+h7tF+fc+QE?=
 =?us-ascii?Q?nhlS3vBQuirNbovwv0U3lMlMfWwXhXCTtyjboOYRkrrEbOqcVfQySuysinvs?=
 =?us-ascii?Q?Cig/B0gVH9Ow1XcDvuFPjO8Qs06QROZhBiHfH4DFtxLnNvFgf1lQFlWWEB27?=
 =?us-ascii?Q?yE6R4CqbziZXbMRXpIEkH+tE3sPnXrew3XysGC7DbYB1Azbmyihe6BHF3m8u?=
 =?us-ascii?Q?NdUncEXZC9qChNCSHPrCQPn8jDd5UJ8GGFMFx9QW6P8lH0dsPXFdXOTHwKq5?=
 =?us-ascii?Q?1vprqd0OJyvKaJw7J1IKKZQCm16X0e/zlcc3ZEpUWRncCN3OK5/+Mz88w9Sq?=
 =?us-ascii?Q?K2y0fnrtQJ0gsmoqOK9linQr0wMySmsKnECS8TXRrDRpzS7JlSudEOBfgueU?=
 =?us-ascii?Q?a8sPfgvh9+GUG7jjIM+hOfAErkcvfG5sXeJvTXAWnlO6i6D+NsYu9KJKJm50?=
 =?us-ascii?Q?+j1xfnGqRvehzzXknNiBWFszNBpzJg+nGCq7HAXyafTynvlXGHGdvbfHFIl1?=
 =?us-ascii?Q?mPGyIDFhfJx6d2IL8f28fdsXYtb07WA7YetrgT/Fe7MhFApj9qspO5GxlsO1?=
 =?us-ascii?Q?Jz2JQtmLtgrfNSH7zZLaD0Rj/0CiyRyLaRSKTVo5gEG38YEh2GyovmsiPOBK?=
 =?us-ascii?Q?xdgbn4WzrB+SsgqdxoFna6yFIfL/+yougiOdHKiM9TzT3jwMxodC/BacJ09+?=
 =?us-ascii?Q?krJuaCE9jL8FtlMHHqQhzciO5V+NLQnR/9w+HzkDrA3keBX57goJhL8keMrf?=
 =?us-ascii?Q?icHw5mjYETSDxcr2kN9q2yxXz3VifK/iN7WENb2FLDNw70Tr4j9AEapsQtF8?=
 =?us-ascii?Q?tERy2wpqU9x21YqGlPFMweoV3jYQGUDXXobChY4EkEK607Ufmnf69wqq70YH?=
 =?us-ascii?Q?goRaCNYlm0E+QapVEFoZGYatiERXItZt+WVeF6k7t+9LcoJI4lBVBBia7sOF?=
 =?us-ascii?Q?ovoqA6nFVJw08N0tTnsqNxCN8A7eJUXbCAmyW5juSVQATSJABoq6deCWL/ry?=
 =?us-ascii?Q?u5r7H//Zez+xBYkKXCkUih6yGFPWcQ8yCDhYywyy6zmt8rtzSz3/WxvFuP5A?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27027e3b-7106-4e62-841a-08dbad583fd1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 15:04:34.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3egtEPL50dpHE9+LbMQBTxXypOKX1JDtyOSjmCsunFUbztLsMM2EXoseQqHWOV/vdEToDrOOrVxM3xHJxd5wYJro2kjM1W9lPiUWVSjIB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5534
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 09:26:43PM +0200, Larysa Zaremba wrote:
> Currently, rx_ptype variable is used only as an argument
> to ice_process_skb_fields() and is computed
> just before the function call.
> 
> Therefore, there is no reason to pass this value as an argument.
> Instead, remove this argument and compute the value directly inside
> ice_process_skb_fields() function.
> 
> Also, separate its calculation into a short function, so the code
> can later be reused in .xmo_() callbacks.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  6 +-----
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 15 +++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  6 +-----
>  4 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 52d0a126eb61..40f2f6dabb81 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1181,7 +1181,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  		unsigned int size;
>  		u16 stat_err_bits;
>  		u16 vlan_tag = 0;
> -		u16 rx_ptype;
>  
>  		/* get the Rx desc from Rx ring based on 'next_to_clean' */
>  		rx_desc = ICE_RX_DESC(rx_ring, ntc);
> @@ -1286,10 +1285,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  		total_rx_bytes += skb->len;
>  
>  		/* populate checksum, VLAN, and protocol */
> -		rx_ptype = le16_to_cpu(rx_desc->wb.ptype_flex_flags0) &
> -			ICE_RX_FLEX_DESC_PTYPE_M;
> -
> -		ice_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
> +		ice_process_skb_fields(rx_ring, rx_desc, skb);
>  
>  		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
>  		/* send completed skb up the stack */
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 8b155a502b3b..07241f4229b7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -241,12 +241,21 @@ ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
>  	};
>  }
>  
> +/**
> + * ice_get_ptype - Read HW packet type from the descriptor
> + * @rx_desc: RX descriptor
> + */
> +static u16 ice_get_ptype(const union ice_32b_rx_flex_desc *rx_desc)
> +{
> +	return le16_to_cpu(rx_desc->wb.ptype_flex_flags0) &
> +	       ICE_RX_FLEX_DESC_PTYPE_M;
> +}
> +
>  /**
>   * ice_process_skb_fields - Populate skb header fields from Rx descriptor
>   * @rx_ring: Rx descriptor ring packet is being transacted on
>   * @rx_desc: pointer to the EOP Rx descriptor
>   * @skb: pointer to current skb being populated
> - * @ptype: the packet type decoded by hardware
>   *
>   * This function checks the ring, descriptor, and packet information in
>   * order to populate the hash, checksum, VLAN, protocol, and
> @@ -255,8 +264,10 @@ ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
>  void
>  ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>  		       union ice_32b_rx_flex_desc *rx_desc,
> -		       struct sk_buff *skb, u16 ptype)
> +		       struct sk_buff *skb)
>  {
> +	u16 ptype = ice_get_ptype(rx_desc);
> +
>  	ice_rx_hash_to_skb(rx_ring, rx_desc, skb, ptype);
>  
>  	/* modifies the skb - consumes the enet header */
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> index 115969ecdf7b..e1d49e1235b3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> @@ -148,7 +148,7 @@ void ice_release_rx_desc(struct ice_rx_ring *rx_ring, u16 val);
>  void
>  ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>  		       union ice_32b_rx_flex_desc *rx_desc,
> -		       struct sk_buff *skb, u16 ptype);
> +		       struct sk_buff *skb);
>  void
>  ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
>  #endif /* !_ICE_TXRX_LIB_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 2a3f0834e139..ef778b8e6d1b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -870,7 +870,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
>  		struct sk_buff *skb;
>  		u16 stat_err_bits;
>  		u16 vlan_tag = 0;
> -		u16 rx_ptype;
>  
>  		rx_desc = ICE_RX_DESC(rx_ring, ntc);
>  
> @@ -950,10 +949,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
>  
>  		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
>  
> -		rx_ptype = le16_to_cpu(rx_desc->wb.ptype_flex_flags0) &
> -				       ICE_RX_FLEX_DESC_PTYPE_M;
> -
> -		ice_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
> +		ice_process_skb_fields(rx_ring, rx_desc, skb);
>  		ice_receive_skb(rx_ring, skb, vlan_tag);
>  	}
>  
> -- 
> 2.41.0
> 
> 

