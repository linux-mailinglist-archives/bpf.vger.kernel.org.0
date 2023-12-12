Return-Path: <bpf+bounces-17522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AAA80ECCB
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 14:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551241F213FA
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ACE61662;
	Tue, 12 Dec 2023 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YNgJubft"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E14999;
	Tue, 12 Dec 2023 05:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702386435; x=1733922435;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=q5h5sPu8wwioPU4eq5uoZ089DBjirEnfK0KAmvPSlJ4=;
  b=YNgJubft5zJHaBWt2pOZqAMS8JaK+fVM15HbDtePEjWqImxFLcNwviwP
   9bY3dX+qUlBqZI1jTw3MVfJqMfsjpve4N5spVStoAIQC/t0fGeCUHPuUn
   GCjnJE0p+F2IWlKnfWbxYu9jqdYuZFfwaGlG94+/gQCY2JbWBJruGTath
   M06uwnT32e2ZdpH84p1WrQ2+TkrKJC/FMNvr2FnkXEj7TVg3gMhd9ke6X
   l3z08jEeajk+jj4f4tyBxYRdtM4Q3+/g3PibfcnAOyVmFijlRb93keNnH
   w3W0Nx+r+kj2U/WS9iKBy6cU0boc18MIaC64KJP8sZF/hyXqlNXXiGtbW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="394550305"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="394550305"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 05:07:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="896914765"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="896914765"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 05:07:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 05:07:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 05:07:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 05:07:13 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 05:07:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dct4TrisLywG/9fVl3Ga4EfashQp/HNxTd/d3QpWFAKq+uxnFF/rcz/L+O+26nVnS1sgb37FM1O9ZXlffQj/9WkKWeHOuLMdRp1AuqoiDYJWtCIspfnPveW2bshsM9fyjK5OuzL+kTPSGqS1+OiWCVFUk5eztnE/nVXztrOc2uiZMg1S5uydp/ZfTYDxkw4alTxpNPVHqeGT4lrZmi1Rg1Rysr4rqSU5088NpOflMD5K5Zk7MeMKH4T+XDYwhEeOUa6p7DKnaH31hIgt7uOJIBdkAh3zsNF+zrRPz/hzDA6JJJvGN7n1c88iPIeIraLy6Srx8aIgMhByq1dj6maGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT5BePF6Ye00n4Z9wFgf2EMtykgYE+A+Mmo24UGlJyA=;
 b=lY/JtMfWUF6/P2YY9Uoo4t1HAwVzMaKNwpAJoBCcA0cQLsh9a3HH4fBztbZoarkRUQJfV6lxYBXlcE2yja8iPOxkn/x24/uvyTkEgaki/AITi4HSCq7K9dNnJ152YS55/GeXPuPawHJTABWSo2YpKeb99w5NpCKiaUJqc61QieEVYv+Th0giBPi4SFMlRcuZDXL/1T/FSTaMT5pR3tNvZtj+DLmPowRhSNNRXkifntNx4MrMcdoca97KR5hKmVo6nzQGlTWGURIRig886lrRP7tCThsQXGzUKgWXXx1fjE9ogNpmlyEXX9R64GGpWFBmSLhEGUGrzHevfuP3kTxjBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6686.namprd11.prod.outlook.com (2603:10b6:806:259::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 13:07:09 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 13:07:09 +0000
Date: Tue, 12 Dec 2023 14:07:01 +0100
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
Subject: Re: [PATCH bpf-next v8 04/18] ice: Introduce ice_xdp_buff
Message-ID: <ZXha9U8+EHPYSscy@boxer>
References: <20231205210847.28460-1-larysa.zaremba@intel.com>
 <20231205210847.28460-5-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231205210847.28460-5-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR4P281CA0302.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f40273-2bcc-4863-0e6e-08dbfb133f61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9raj6ZcQFboLBabSciEMD3tcBznrZdPCI2tnyA0p6C0hNts+PkoTdMfPBQA1mfu+X86HvJ0AZfbIvFZ8z30c3eETOlod50pbPk24h0iZaJluM5wcrpiSsSqqaPsIC9DiZIFxazb0msHZkcLRQ+QbRT+UL1HaUFSu+2ug+7ypMAU3t3o+PnKhnSW3GdAQ+AIoVpBEkwLdPb2B2qZBDlcNbynS1bGbLIXxAS+mFGi7oDVc9pET9V+CqKGjgXlq4dj1QFGhnWyU8fD9R28F2pJ6G7WgJ+G+KGbBG2Wk5aZVHlZUKestwW6NyDu4Sdf2ye6QtKx8pv4NrqxqcJA+gT1OEQIjRixQDaZ3jc5R6/TsjQrCbe8mE3h49OlBS53Z7s+w1+drk1QCOe6s7M4WFHt/nocGKcUljrpvRjQ3gL9qorGPemU+9Z4ZRrVy764OABbTXTz/BjdXVXjxUkFiMcJaDoAM0ly0Mb9XxDzERxwn0lu3IJV3rzKZz9/EmsOraS457XPnRQYCaz6dka2sfGbiJAcIQmhYGUFEnYEsZH5J68zl62dD9jMYVw+deMap2H1u5h6ssV5KRJkEu/70DUSathoiW1zpGtJEv1KFvrMUckI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6512007)(9686003)(6506007)(33716001)(38100700002)(44832011)(5660300002)(4326008)(6862004)(8676002)(8936002)(41300700001)(7416002)(2906002)(6486002)(316002)(6666004)(478600001)(6636002)(54906003)(66946007)(66476007)(66556008)(86362001)(82960400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0y1p1CC+oVNMhrtwlJYYy5ggqVQMGMBxIBBvZcMwhSkKHMd71WKcmAemDmab?=
 =?us-ascii?Q?73aOJYIUTcxRu/kszWikkFfJcawuXDIhPAHoc8J5jBQ/p9kKQPQnGc/DRar/?=
 =?us-ascii?Q?Ohbie4NsnjdmtLaEJn0Agfxe6iWwqCIHT6Z4VO+6/puUyt1qNBF+WJZhfjmr?=
 =?us-ascii?Q?JxOHy27PN4xuWgh2xnvsI71/rq3oF0WTNnQP/gz3z4z4bmdUYlwcOe2eqchq?=
 =?us-ascii?Q?L4gXfj8xqzbJvp1qmwJn40H5QAJtjWfa+tifCTvR7TLDfgbKaOXCfTuziPVV?=
 =?us-ascii?Q?Tt7iUJ6ORpiCag2/OU2c827fe0bZC5hG6rRGd+/7qZ9p/2n8H/c7N3zlbbuA?=
 =?us-ascii?Q?6JftwwzP/NXeKiBexJUMGbxFrlfQ39q3fNjh34LDHAx9SILJbYUJdgEjEN5n?=
 =?us-ascii?Q?FpQRrkp9wnWZ0hFJ+won+plb4/dO+KIdyW/wbFMOXM2PT8HivhUB2VuiZdQY?=
 =?us-ascii?Q?p7qbEqOBYTcep4rPa+iB6oesWG/q74ikUdwWlHyqPZxaLyfCinTX0OYrJSst?=
 =?us-ascii?Q?JmPYHsm/RTxPIK6Sfb61cABXv2c/i3zdRlrEMdPoISJ2rF7TKJuxWBCxGF/c?=
 =?us-ascii?Q?U1wVwk9XHQvdEH4NT7aJVvMnlbyJdwpY/2E3jbWQr78EamPP15gWCFwXnZvY?=
 =?us-ascii?Q?Yr9ygnIUOT5hrcaNS056Nwjwe5R9uvDw0Xa5Mgqk9K6aJt09w1JTXZONNHN2?=
 =?us-ascii?Q?Q0xUJ8HUmhG+ZZouhgIO4A+b6m6+nwz3Yc89WiDpRHchM6wJTAngCqIzOdnD?=
 =?us-ascii?Q?ZvK+jwIaLK+6XSiv9KamgTFpLs/kVHH4Pk1QgoIIKPNCd2H01IXuly4PqoF4?=
 =?us-ascii?Q?eu/h9kB5pUD6I+LqUlOrdHe0hxeuLr0Lkh4MP54egLuZMInNiufWKYy92Dm4?=
 =?us-ascii?Q?n6LhVF8r0be0H3DjJhTh6uyIUBGk8cDneb+Dv2KVN0vEMI9MMCLzyBmlR63Q?=
 =?us-ascii?Q?YZjsQ51xO5/ZhHvfkJBGuJ6NH0JBtyNctJYAiKNED9bW+nLfV3AeDoXQX4t4?=
 =?us-ascii?Q?+olXDMVDCuJTDuJQtsnB4XdnItxGYndY3+79xjNU8qkKjwWKFTfhmr+kbMe7?=
 =?us-ascii?Q?zSWNBoW2ms/3VDOXu7/L3rxi5uhhjd05NmaUmfg0MSrccuMxK/Ss6zOqcmY4?=
 =?us-ascii?Q?qNPRs8+bVE6f0rcRjxw3LX9+nR/6zeQqo73dUGqjXgnPWYR1o51Z1ewA471H?=
 =?us-ascii?Q?tcS8uyEPe/X3pBOyuz3qSbf1tDWa9f/siZZtGSPxxqvjhnzXVJoaauj++7iu?=
 =?us-ascii?Q?/2hOgPAx8ycUetrX87Elqgyack2ze/DG7xKxjSZPUDI098ZrnGYkdqc9QVHi?=
 =?us-ascii?Q?ea52TavoT8LBE5Vx7XqnFC9ETbi6/LDrTYFmRDjvmt+VzuqRU/q44cr6L6iy?=
 =?us-ascii?Q?Io8tKn5eg9HCTzYyU+s6M4dJ1KDkmCskOUif2KAr5NJh8wOLKzIPbuqVreBs?=
 =?us-ascii?Q?R5xUmb9iICBB381dKod79U9ygwu1uDxbFcqpe1zplwJukPLJX0Ty/x/LN0xY?=
 =?us-ascii?Q?9hX5A7F8dAYuOhjlDjZWzcrJJOnmCVMcs9q1VUL5k6NjIUXlPKM+f+T4ux8q?=
 =?us-ascii?Q?Y/SUSnih/XLulyNfGMwqe54R67PUg4maCThal71cgdgMosnqP2eXx+NjRLvl?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f40273-2bcc-4863-0e6e-08dbfb133f61
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 13:07:09.1810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJLfHKiBVR0G5r4x0ldp7pbJoxqW2207f0tKNjXtbquuH6skT+xFZwVznVcrYRnHPVuO4OGgQKm3BZE111CwcHotXVU4AIkXfbx+itG+ljM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6686
X-OriginatorOrg: intel.com

On Tue, Dec 05, 2023 at 10:08:33PM +0100, Larysa Zaremba wrote:
> In order to use XDP hints via kfuncs we need to put
> RX descriptor and miscellaneous data next to xdp_buff.
> Same as in hints implementations in other drivers, we achieve
> this through putting xdp_buff into a child structure.
> 
> Currently, xdp_buff is stored in the ring structure,
> so replace it with union that includes child structure.
> This way enough memory is available while existing XDP code
> remains isolated from hints.
> 
> Minimum size of the new child structure (ice_xdp_buff) is exactly
> 64 bytes (single cache line). To place it at the start of a cache line,
> move 'next' field from CL1 to CL4, as it isn't used often. This still
> leaves 192 bits available in CL3 for packet context extensions.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++++--
>  drivers/net/ethernet/intel/ice/ice_txrx.h     | 18 +++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 ++++++++++
>  3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 6afe4cf1de8a..99ea47011fe0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
>   * @xdp_prog: XDP program to run
>   * @xdp_ring: ring to be used for XDP_TX action
>   * @rx_buf: Rx buffer to store the XDP action
> + * @eop_desc: Last descriptor in packet to read metadata from
>   *
>   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
>   */
>  static void
>  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>  	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> -	    struct ice_rx_buf *rx_buf)
> +	    struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
>  {
>  	unsigned int ret = ICE_XDP_PASS;
>  	u32 act;
> @@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>  	if (!xdp_prog)
>  		goto exit;
>  
> +	ice_xdp_meta_set_desc(xdp, eop_desc);
> +
>  	act = bpf_prog_run_xdp(xdp_prog, xdp);
>  	switch (act) {
>  	case XDP_PASS:
> @@ -1240,7 +1243,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  		if (ice_is_non_eop(rx_ring, rx_desc))
>  			continue;
>  
> -		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf);
> +		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf, rx_desc);
>  		if (rx_buf->act == ICE_XDP_PASS)
>  			goto construct_skb;
>  		total_rx_bytes += xdp_get_buff_len(xdp);
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index daf7b9dbb143..cd93394fab17 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -257,6 +257,14 @@ enum ice_rx_dtype {
>  	ICE_RX_DTYPE_SPLIT_ALWAYS	= 2,
>  };
>  
> +struct ice_xdp_buff {
> +	struct xdp_buff xdp_buff;
> +	const union ice_32b_rx_flex_desc *eop_desc;
> +};
> +
> +/* Required for compatibility with xdp_buffs from xsk_pool */
> +static_assert(offsetof(struct ice_xdp_buff, xdp_buff) == 0);
> +
>  /* indices into GLINT_ITR registers */
>  #define ICE_RX_ITR	ICE_IDX_ITR0
>  #define ICE_TX_ITR	ICE_IDX_ITR1
> @@ -298,7 +306,6 @@ enum ice_dynamic_itr {
>  /* descriptor ring, associated with a VSI */
>  struct ice_rx_ring {
>  	/* CL1 - 1st cacheline starts here */
> -	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
>  	void *desc;			/* Descriptor ring memory */
>  	struct device *dev;		/* Used for DMA mapping */
>  	struct net_device *netdev;	/* netdev ring maps to */
> @@ -310,12 +317,16 @@ struct ice_rx_ring {
>  	u16 count;			/* Number of descriptors */
>  	u16 reg_idx;			/* HW register index of the ring */
>  	u16 next_to_alloc;
> -	/* CL2 - 2nd cacheline starts here */
> +
>  	union {
>  		struct ice_rx_buf *rx_buf;
>  		struct xdp_buff **xdp_buf;
>  	};
> -	struct xdp_buff xdp;
> +	/* CL2 - 2nd cacheline starts here */
> +	union {
> +		struct ice_xdp_buff xdp_ext;
> +		struct xdp_buff xdp;
> +	};
>  	/* CL3 - 3rd cacheline starts here */
>  	struct bpf_prog *xdp_prog;
>  	u16 rx_offset;
> @@ -332,6 +343,7 @@ struct ice_rx_ring {
>  	/* CL4 - 4th cacheline starts here */
>  	struct ice_channel *ch;
>  	struct ice_tx_ring *xdp_ring;
> +	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
>  	struct xsk_buff_pool *xsk_pool;
>  	dma_addr_t dma;			/* physical address of ring */
>  	u64 cached_phctime;
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> index e1d49e1235b3..81b8856d8e13 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> @@ -151,4 +151,14 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>  		       struct sk_buff *skb);
>  void
>  ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
> +
> +static inline void
> +ice_xdp_meta_set_desc(struct xdp_buff *xdp,
> +		      union ice_32b_rx_flex_desc *eop_desc)
> +{
> +	struct ice_xdp_buff *xdp_ext = container_of(xdp, struct ice_xdp_buff,
> +						    xdp_buff);
> +
> +	xdp_ext->eop_desc = eop_desc;
> +}
>  #endif /* !_ICE_TXRX_LIB_H_ */
> -- 
> 2.41.0
> 

