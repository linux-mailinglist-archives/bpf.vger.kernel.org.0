Return-Path: <bpf+bounces-9202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75413791AC9
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 17:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B354280FD0
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458D8C2E7;
	Mon,  4 Sep 2023 15:43:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0498C138;
	Mon,  4 Sep 2023 15:43:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915CE83;
	Mon,  4 Sep 2023 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693842194; x=1725378194;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VEltp44niCbDBNdzfyuvYckcMM3FmHqRzPMHH/ufjSU=;
  b=eM5HZQ/yEGeBAHqHHXhyf88asFJeM+XdD2TiY0xWin4jyANL5HIjPln/
   nGEEytvu9Y4NilrfLKqdUD21VYMIETwWh0xP0zqFeDZCNhT4WGEb/HfJk
   SsOadno2bcBBVFJafCc/i7vQ6lDhdWVG7bJp9L8HxAMStD9UDlPjeWTDI
   ci5rWzNzMnV/j1xojV+fcnWXtqE6FyAoHch4idSKsRvigJSUnSxDgXcmy
   +oh6Hu/g+2NIX1cTJqzoQLExGuBULoB/tIOIx66QnX/3NOhegHGsamzOV
   XUfjpwaOxiNZUGmKMfjzPBVXX/eCCspJbxmIl59QeWaHQNhf6k0xLL5Rx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="356117475"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="356117475"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 08:43:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="855648248"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="855648248"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 08:43:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 08:43:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 08:43:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 08:43:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 08:43:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4SMJLsJa1x8/0gyifuO9CyRSd7rSyohxJNrFBk3JKvnTNdEaPX2Uy4WcMIFWsZGApGNxTi1Z8NC7VNgSJqK4ASaOKg2Ju+9Pv/5HyHxvql3d9exThuOZdS6TKnijCR2djUrav29jqi+aYgG4ZLtOYeozXHrJIOWSoK5NlKpUJxwIjnIUK4GCQYJ/CJzt9Af7tXBmTxI3p/ymcf8ioJHnweKqjlZ3AwlPR86w80f8UDRdr58qr8qvodkf7skkcsCasw85KQU1CJIaDCtE19IzDvrd3LmNjjGGClibS6I326fez2WbHBhq3FLuKaqJdWhPghd+VNO/4kSH9RvfrcLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cu9h0A5zzazWbbU9OWgGs1RfONNcjuWRL1/B30gThU=;
 b=Yo2odnEci2WjxO0zvA+AYRRfKZ3AhSdYjTAWpStVBxliJVwVBSNRlp/eDG8eBO+FmbAmLZlNSSC17IxY9yGdmg2fSMb3H6bTuahRUeG7Q7nOIaZNY6LYqLFLNUKRNcCmkRrpaW+gMCfVerBHzfcN0QtmxKW17gWKd80DVCBh1zk8M0WMjVgM8VY0zUw3SdZQFKSPoZ7+q5/fH/WeHp/fLFl1Zm0JLyNUD5s4DwUwe2hDFJZUjipCbMAkg9K7mest9GJB/NnasKh4YFWNabdkM09jGercWvg3DqOUCYlou2j8ZOzlcM4u1ArV7bUElvTeaEi4cSBxK498e6NN3jfFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.32; Mon, 4 Sep 2023 15:43:08 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 15:43:08 +0000
Date: Mon, 4 Sep 2023 17:42:59 +0200
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
Subject: Re: [xdp-hints] [RFC bpf-next 08/23] ice: Support XDP hints in
 AF_XDP ZC mode
Message-ID: <ZPX7A6Vp+Nxk54St@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-9-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824192703.712881-9-larysa.zaremba@intel.com>
X-ClientProxiedBy: BEXP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::13)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 6965522b-067b-466e-771b-08dbad5da2fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXaCnbXV3e5sIwkDEiNY1jtos/LYKFqBYp0924eTz5OMvekruss/STEqaIofTp0QiQ8wGTR86i5HV1fdR+QZVbF3XCQHYCRJouWHBs4efPENXYcZoM6vkXFhRHMQQ5+1yHW9u6WVEb7UIqoJkMrPT8rxyaEsn1YaONUY2BbYjPF/SwQ65t3T2kTkWUVwOxySFuYVH0Fm0fM6iaS1gNqCXpRKmme3Y+bH7uPON3OYuHNRS7snrUswtru74ZYybzKt/jRjYziebG+9WzeGsqYWCX4aKbL6QneSsH3ovdNbcrTJLkJMSp4GuT3cs4BIrZGQVufzUNmktGxzWPjfGg8k6rv/+PFIn90TLneaZXoqa2BChUy/ZW4uR8a1/1ISh+dYPfgPbuwF7Cr3Qi4X7wNLPs1AzRwPzQVYKknwE+itClP4UomuI89Cihm0kQSIWYtB9sgC6crZx10cxPDetocN7co+y1RNXeJpeKxpwXT72AejtI+iN0AiuEWCACCyC8yauIAsFJgCu89r3jn0y0cXMd0muGOopkMCz+x2e2nrrOtuCXWExUFwJG+7poFIxrTfgfaXkQStFxSEVsonxzcyAkewc1L25AqKtImC+MbuIiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(186009)(451199024)(5660300002)(41300700001)(26005)(2906002)(7416002)(82960400001)(86362001)(38100700002)(33716001)(44832011)(6862004)(4326008)(8936002)(8676002)(83380400001)(6666004)(6506007)(6512007)(9686003)(6486002)(478600001)(6636002)(316002)(66946007)(54906003)(66476007)(66556008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UvO+fX5aI3z5Y6P0GjoscLK+h0c4Txpr7QLyRh0ACeqTPVPGAEfT/F0JB7wK?=
 =?us-ascii?Q?p+1TA+ke6xDOMy4P3EsegomWUVK5D51RKvO5GS3P9gkOH8A3UbjGdxhzzEc7?=
 =?us-ascii?Q?RPmfoOcIWggQ44SNwNhpui+aebN5G3BZVtpSwJy68hp3dyuJejfTRQbyo9gL?=
 =?us-ascii?Q?eVColTP03bAhsGU8A59P8YyjLA5EY73XmucrpzD4/qTm3VrBcF2Bvw49YH/s?=
 =?us-ascii?Q?3GnCpq2PIdnVZ5id8TPIuZReTLd/TS2PyXrTqs/B3PmcIK3nF+gdr45B8iXQ?=
 =?us-ascii?Q?/AtTdPz1QbEIbBKWTpuwvhigkLbdn+MrSXSWXPnz+AJ62CGu9/IXwM54x7pg?=
 =?us-ascii?Q?WOPx5roQSOtTKnhfVEwH6gX44zRt8AO+wsdPiqTWNOO43cqNicBEzbSdCKJc?=
 =?us-ascii?Q?3uUuSVioHnuG13j6a34YiaSLarTTpychIb+T880Nho6sPJHH36oAe+YwBieD?=
 =?us-ascii?Q?uaG+b1kCuHhFiT0uu6O/cXGf3Bv6p7XUG2t/s4+Y0xtOXI93d5bj5SSmSsCo?=
 =?us-ascii?Q?iYumc+uokWdO1nrAY1Lx1vmPWF18f7kzG97AFmovN+1buFOLnh1Bg2TRJhKO?=
 =?us-ascii?Q?RY0wr7niaIGVPMTi6veTCXV+21+dadBgkRWi4CqN7L8sDvkrmUhOR+BYOX52?=
 =?us-ascii?Q?nNkMiE5f59EjPHIXeGfdMQ6ixHKkMamLZka3SzOpadBgWdGMFRS+rcdjxCqF?=
 =?us-ascii?Q?ByA9fCth5M3x0lc6UewYSr4VSf7qUgyxXfgiIjjve/dafSH1rFa+AQF2sf49?=
 =?us-ascii?Q?lRk7Wmm9lz5tflbMlQbegdyC6aSOyDvTIA/dvjZZGD6DRPyTP5gy4O6ZoyXR?=
 =?us-ascii?Q?Hz/OEcsZHHzL5v3MafnDP40L5Y/3VGQxD5GjN7mAcQsBwsMUfBqN4LvflWL4?=
 =?us-ascii?Q?0G3fXRuEziuVDWwtHNR9w37QNwgRuVZPWhCnPk9ETIJ6tv1B4L4U2CsQqhq6?=
 =?us-ascii?Q?FvJNb+pnNMUrOL1YJBU+E+HyJ06eiJnpYn/mLO/1YPzy2CN5gFivNM21oIN7?=
 =?us-ascii?Q?roW88ySG8fwYXgEGPEiHLx+Qzf2f4yo89Tna4ujyUC+wqNV0RF/4B8m087Cb?=
 =?us-ascii?Q?cfr74atdpBnWZMLauUQDTUtG2Roe49fatBoMbGewzRZFIO+CI3xXpDes/yUv?=
 =?us-ascii?Q?jW6gOMuikmqcaMErGDK+x+/X1QjbFxv2+fOBmy+0mzzZmEuM0Eilqkb1V1xs?=
 =?us-ascii?Q?UB6bZR/UeRYLr4GqbpnQ2fbm2FR0ephETuyxbBxqyyQRKh9X6RDruJNKJYWz?=
 =?us-ascii?Q?1QK6hFzbiKiPrehn2Wgao7VEOvsJyJju49C4uMRhQY+aKUp4PrpjFl6Uy5W5?=
 =?us-ascii?Q?Gczq6Zdj8OnTPUray3/Sh2onwHnbTGR0LBdiGjeg+Vn5CwWgOpn9ljVeDC6I?=
 =?us-ascii?Q?+AeuhxLdcG5bxNsTSl7hp+UdZPSKu6AYbpbL8Kb+RujQL4tFiSvLZxVy8mPD?=
 =?us-ascii?Q?McANSdu4ngjJDFqZiSnc79q0ugtchlUNMQccbrXWIJhvCWPozc27DFD5VKqK?=
 =?us-ascii?Q?m5IJn6jd+ur6o9o9BNCcvf6cSVJ8B38TwEv6Oz+8KfKW7VjRVzb5ZAY8Q6Ld?=
 =?us-ascii?Q?o7Q9G470jXPUoGK4Q4blwlT+g5zFWKQJMLmnC2SVJ++ewpC2gxg8a0LJsNVO?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6965522b-067b-466e-771b-08dbad5da2fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 15:43:08.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3N7g7ZKYxSA/4te5KtkmDtpKJIa1STakPR84SFgTnfvOAP9ylo/l0Z8C4vPwL7Z7gatEzyTo5fLBKb8WgUF+881isQOHlPZ2/hs+yuTXpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5626
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 09:26:47PM +0200, Larysa Zaremba wrote:
> In AF_XDP ZC, xdp_buff is not stored on ring,
> instead it is provided by xsk_pool.

xsk_buff_pool

> Space for metadata sources right after such buffers was already reserved
> in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
> This makes the implementation rather straightforward.
> 
> Update AF_XDP ZC packet processing to support XDP hints.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index ef778b8e6d1b..fdeddad9b639 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -758,16 +758,25 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
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
> +	/* We can safely convert xdp_buff_xsk to ice_xdp_buff,
> +	 * because there are XSK_PRIV_MAX bytes reserved in xdp_buff_xsk
> +	 * right after xdp_buff, for our private use.
> +	 * Macro insures we do not go above the limit.

ensures?

> +	 */
> +	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
> +	ice_xdp_meta_set_desc(xdp, rx_desc);
>  	act = bpf_prog_run_xdp(xdp_prog, xdp);
>  
>  	if (likely(act == XDP_REDIRECT)) {
> @@ -907,7 +916,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
>  		if (ice_is_non_eop(rx_ring, rx_desc))
>  			continue;
>  
> -		xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring);
> +		xdp_res = ice_run_xdp_zc(rx_ring, xdp, xdp_prog, xdp_ring,
> +					 rx_desc);
>  		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
>  			xdp_xmit |= xdp_res;
>  		} else if (xdp_res == ICE_XDP_EXIT) {
> -- 
> 2.41.0
> 

