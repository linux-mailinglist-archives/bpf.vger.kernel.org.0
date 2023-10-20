Return-Path: <bpf+bounces-12842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6044A7D12B5
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 17:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836D81C20F7F
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577A01DDD3;
	Fri, 20 Oct 2023 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USx9gu+r"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0DF1BDDA;
	Fri, 20 Oct 2023 15:29:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BC0AB;
	Fri, 20 Oct 2023 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697815796; x=1729351796;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U6rDBiRfnhI7c+vxqg3rG/B9EOhGtZFuSLpYPOVH/74=;
  b=USx9gu+r+UWOnCK+/sPgutGoHe8Z8y+yRvYcLR3HLTvNhI5uHEC4YqDg
   wYUnUqN/z6aHDybro3wrC71ofXy08iRRYb3ET42sp5ZdLrPquj19LMdbY
   FQUODNAifHSo2z468UYf1qBgr4xdvk2iQMr7FYh6Ty7mQYi9VfamRE2Km
   iDp6fHNdOjahAOzAeQ74DRWbohkQs6EIX7HDWZYD79H+KbH6TGyRDb3gO
   Pqlv8fZk1aJdYMBbSrnqugYbWs7Gw85AS7c3RBjVBC/jOKRlULfhNJ615
   bu2+z3BgdbNR9DDgTSflPvR8+J6lFOqLiAFUdYRPB9FvcYN1TAgDvLmDm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="385400772"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="385400772"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:29:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="757486799"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="757486799"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 08:29:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 08:29:53 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 08:29:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 08:29:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 08:29:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtbT4ilql3dmx7XqVL+h0RnhEncey9DLSnQxpd9HRfXzvgb7fBpraVmYEv5ybXSAdklwy1Lg2lRNbLa/oo8Rp/w0dMEO9qiJe2KtgUFD4oQXwVBzpUO4INdKnKhLbZU89p8G3qKcreaEqJuB0NzLn5Ck0QEfTb8tJGUwN5HmkrKK3NjDQ4272Wz2hcG9I3e0VR6CxMtRnfCxngBsJAisFVtBzg7dOby+FRP3Je4ZjSpvBwB0TepJ9BjTKHKwlPhlhwIYsJPifCCFGCM6g5ihr9/vNi2P2w4fG2oJfoKJ/7nPoS/JOenjO7ClULjuey4RZP176zDVOPdWFa5cheTUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLfXIjMUyHMHtVphP9q0cTfENawVGgmidKrv9fmccyo=;
 b=Quy0KlrMi7xWN8WtY5eLI6vCMy/qcXpcAHeQByXEBfv4RJxyfqvZZAURr90s/7Mn+wSjttHRxUhZo8rufO+FaG4O+22V2JT3ENFMEUfmNo4QgXSKTLNJKSaNB1R4ZYhdjqk06s45Hr8weF3tqR2i+eiskoCsHZB2IgK7XeGHim4tRdU7rE5msXcM2ikn2trPVKRz4XAp/FLpl5gh2uZ00eoOwMOEsrEcmRX52ooKZ8uxGRb65+DF4orqa+AGQWkI5svdAsv8GBJ8XQDJHriO7KjnuuOst6DFWjTIF8N3bs9OL5Kgxn01ymWJcZg4MpLJvXsHpmonQ6Y3YZoRTaNApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4742.namprd11.prod.outlook.com (2603:10b6:208:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 15:29:47 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 15:29:46 +0000
Date: Fri, 20 Oct 2023 17:29:38 +0200
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
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH bpf-next v6 07/18] ice: Support XDP hints in AF_XDP ZC
 mode
Message-ID: <ZTKc4sKVuhd2LsBv@boxer>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-8-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231012170524.21085-8-larysa.zaremba@intel.com>
X-ClientProxiedBy: DB9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6216d5-26c2-4fef-bc1f-08dbd1816457
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7m9NbbUHYwfr/YgHgX72eOEnOtCjDATVehMY5RDsmYmRZtlchvzrq940vkwLqjfG+fXZ7Z9N4tFXXHcnnkyXN76aKs49DY2BWxxfuEoLQBRYB5WtugP7gc9NIuTIHIbZSpXIyefumejgWLRoIzkvX0ypt8QiVs2A04O+JYF6FG4GNGc/qzhAnnsdukvltqbo2vZUUTxt++I0khNojcGSmU4a94+/m0Kf3YE6X9TUM/kKEG47/glj2kISJjd5gQjejjPDytRuO2l52246EQFf/9WGKEAmMgzJH7Nu35aHecRev8Jx7q2+dVE2p8Zo1vOyuVHlB9ljausynC8ZQgaxsXEvf+viy4+LmfykV58IhusNGpWVOFHXDIhO24Gj3VSsqD/k9+V0BMB5n0DKqUDYDkoDRQiEAVUepN2I9ro0+iCLCRFuXaQqGFMAUBMxBwCWKp3fQDzqQb4eYho854mCcP7Hvh3hIDo0Ip5MpK/VP6ojseXvrjF+saMwApII2XFKLN6l2uuo6hS5SjGiP6uVlxeYwkbgi07kD7KUK0NTxzw/JgGt0u1Xqwk6sTQaVGY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(9686003)(6512007)(6506007)(83380400001)(26005)(6862004)(6666004)(478600001)(6486002)(41300700001)(33716001)(38100700002)(44832011)(4326008)(8676002)(5660300002)(2906002)(86362001)(66476007)(7416002)(6636002)(8936002)(316002)(54906003)(66556008)(82960400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nly36RSJK4/cNaTNMUJydb4aYlBS3x5ndPNf6nm+tprKucTDlOwe3cv4NySJ?=
 =?us-ascii?Q?UNkL2IdrMijN/s2qntov818ugp3SntOKU8+ZecWJq8MOVQy8pS3CZqFM3NuG?=
 =?us-ascii?Q?07bkDMlp+CFywcGb7box5RxTgMKhlZUqpM+DTtBY470KdVdn6XgaogsyzRSy?=
 =?us-ascii?Q?8Fkw66mx7aHvcR7NYVmXpLm1Ze8HEfNtA7OJrs2VaJoZW6dJAPhH4RtWjMGz?=
 =?us-ascii?Q?oCRhTKQ50FBEwhPlgQyTOHbLbTpAwwfh1htjEhNaltt+fTkSJrWn8bJPKtpp?=
 =?us-ascii?Q?/0xZ90TlVdhox7itRBgLq0zg8IydqIkcYN9lE/zek+m4j6e/EcfXwv+L/haG?=
 =?us-ascii?Q?tfF2jg3AjaCjPNKSe5kbBUWd4WFz+GZumzFEiab055B7rrwDoZ61fv2cooyb?=
 =?us-ascii?Q?HvOSs6QlSMUF2MbVor0+ID5EsINH4QoqeNcNDPLKbb2HVfrX5WMZMMWc70Dk?=
 =?us-ascii?Q?SEwvZj7DW8YEfpTEEZUoUkXEwCOzW2D2c7XZYMdy0jzMucmaZv4re8jnh/jE?=
 =?us-ascii?Q?Ik6WOMTZrW+KXmKsusvsfvSDZJJk8G+4jLOo5vITcVYJ6Gk78c+ODVGlcOdF?=
 =?us-ascii?Q?AjU5SK9aKMj56JvuNkcKvZvTm7Gvlhud9lAh+sP8XeYrDRFue37erSkPLOFG?=
 =?us-ascii?Q?Hy8Ujq4cAZdw6VxMJ/mmD1bWTAKOdKr7WKgO/698EXEGwkqjH86sgnp9/lvX?=
 =?us-ascii?Q?/Br4kO31og5/UYKyL/YzpBXfyon0E1/KlwdikWHX9s9VoooEq5jbxKXHL5K8?=
 =?us-ascii?Q?90o3CXVOhYKIZzKQOoX+/iuKEaEgvwn0SwHiYj14gjMb6T0XP7xC1TAx1phw?=
 =?us-ascii?Q?0jQnShPUTNxAXU9fcQ1d9+TH0WcYofjwZFxpoij9urzpBdOFC7T/2d14X7BV?=
 =?us-ascii?Q?lO+tnZ7jZtsFVIK2QlVmle9r3EE66+bOu9yapJl5RoqnQbugernHMg3m9Cyt?=
 =?us-ascii?Q?iDXGuG7O0vm7WJ93/ZfJjuxoAraQqEiN91OxmLr19YnYNSrAEbnp5KQ87VS4?=
 =?us-ascii?Q?yrDTphoPQ6MVBRK5qaTrFlofVoX0SZP7TA37Dh79y+bFLo3KKN93To1pvkAL?=
 =?us-ascii?Q?6XT4IoslYUPSIQR1DW3lm5a8c+3dt2ZisHsNxCzpqqEwhI/JSigHChnKyvk6?=
 =?us-ascii?Q?ym34h0y1B5kVzFPhk/+REJq5HvPi/KL6A3DMYRR23jUGNLIajt1wwW67+p20?=
 =?us-ascii?Q?YZ76VN6HsIvDtcVgUK1QwzqxTzvvHQi7tJAd9GOz2+Re2Pgfw+Z9AaSXHL/x?=
 =?us-ascii?Q?z6diQ6J0sstNyNnpg9s6UVCxlw2zyXyJ6FLcnqmE6K0uqgMlqwJXB+FihWKT?=
 =?us-ascii?Q?pf2iiYb0dbmPqoAqsKNxt4qVyso5BtzSQYpVs/OVrSUyeT/neQpypdNKXd2e?=
 =?us-ascii?Q?SkKt53tuUgOZ1i1BF8HbFnkK7l7j99oMJp04knT+uAmf/iPtTRAELywLLbnB?=
 =?us-ascii?Q?9ox10Djr6mJYOXSoussBQM6DI7DGVbX/IOt5kJD1M0tgNoCroFJp5+fLGTdD?=
 =?us-ascii?Q?Zp2v36vAyZnQhw+/qi7NA3W/HT63LPUT8hbw8oFaqE/16piKT/OKznWFbPm+?=
 =?us-ascii?Q?mvCJeJps2j22TmvTsAXFODZl05RVOblA2IZ/cLRWECQh9moT7H5uEXqIyLkV?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6216d5-26c2-4fef-bc1f-08dbd1816457
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 15:29:46.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vde6slWPHICf9BG5xu/zaqfd/TZkErI1YuN9OOoRBXLfnX3SMve9a0kj7xPJQhaF+xqQ6MrWMyv5CDMLjJlARQCP7QPFR8yzMLf29FSA64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4742
X-OriginatorOrg: intel.com

On Thu, Oct 12, 2023 at 07:05:13PM +0200, Larysa Zaremba wrote:
> In AF_XDP ZC, xdp_buff is not stored on ring,
> instead it is provided by xsk_buff_pool.
> Space for metadata sources right after such buffers was already reserved
> in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
> This makes the implementation rather straightforward.
> 
> Update AF_XDP ZC packet processing to support XDP hints.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 34 ++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index ef778b8e6d1b..6ca620b2fbdd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -752,22 +752,51 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
>  	return ICE_XDP_CONSUMED;
>  }
>  
> +/**
> + * ice_prepare_pkt_ctx_zc - Prepare packet context for XDP hints
> + * @xdp: xdp_buff used as input to the XDP program
> + * @eop_desc: End of packet descriptor
> + * @rx_ring: Rx ring with packet context
> + *
> + * In regular XDP, xdp_buff is placed inside the ring structure,
> + * just before the packet context, so the latter can be accessed
> + * with xdp_buff address only at all times, but in ZC mode,

s/only// ?

> + * xdp_buffs come from the pool, so we need to reinitialize
> + * context for every packet.
> + *
> + * We can safely convert xdp_buff_xsk to ice_xdp_buff,
> + * because there are XSK_PRIV_MAX bytes reserved in xdp_buff_xsk
> + * right after xdp_buff, for our private use.
> + * XSK_CHECK_PRIV_TYPE() ensures we do not go above the limit.
> + */
> +static void ice_prepare_pkt_ctx_zc(struct xdp_buff *xdp,
> +				   union ice_32b_rx_flex_desc *eop_desc,
> +				   struct ice_rx_ring *rx_ring)
> +{
> +	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
> +	((struct ice_xdp_buff *)xdp)->pkt_ctx = rx_ring->pkt_ctx;
> +	ice_xdp_meta_set_desc(xdp, eop_desc);
> +}
> +
>  /**
>   * ice_run_xdp_zc - Executes an XDP program in zero-copy path
>   * @rx_ring: Rx ring
>   * @xdp: xdp_buff used as input to the XDP program
>   * @xdp_prog: XDP program to run
>   * @xdp_ring: ring to be used for XDP_TX action
> + * @rx_desc: packet descriptor
>   *
>   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
>   */
>  static int
>  ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> -	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring)
> +	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> +	       union ice_32b_rx_flex_desc *rx_desc)
>  {
>  	int err, result = ICE_XDP_PASS;
>  	u32 act;
>  
> +	ice_prepare_pkt_ctx_zc(xdp, rx_desc, rx_ring);
>  	act = bpf_prog_run_xdp(xdp_prog, xdp);
>  
>  	if (likely(act == XDP_REDIRECT)) {
> @@ -907,7 +936,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
>  		if (ice_is_non_eop(rx_ring, rx_desc))
>  			continue;
>  
> -		xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring);
> +		xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring,
> +					 rx_desc);
>  		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
>  			xdp_xmit |= xdp_res;
>  		} else if (xdp_res == ICE_XDP_EXIT) {
> -- 
> 2.41.0
> 

