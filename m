Return-Path: <bpf+bounces-7703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E085E77B73C
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 13:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96930281116
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68999BA33;
	Mon, 14 Aug 2023 11:02:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB2E9476;
	Mon, 14 Aug 2023 11:02:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C40F4;
	Mon, 14 Aug 2023 04:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692010964; x=1723546964;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GYUazRQ0X6IIJ3CAWGSqEudJdZEPwc5E8jxIoIm9thA=;
  b=FCoDs7OVs51S1PpyAdJrE/fKelTu8zpygCki7CaVPyHf07PxSBoMeIyd
   yTK0z57wHr1YzbTlndNNrsCdDbfgcjHhU/Cd75bcr2lkbkzogjA82RUMG
   ElJ0SCKmv47/gKNDwFHsszeMjc0eotV5JiiRA6FMjgMBA8GTdNQGwOXpT
   qyAdSx98M/Mcw0DCc0IpEBO1OYvLg6gvvDOcjbg0uVhB74sM9GbxH7f/N
   fk0rQV8tagXSJC0LHAKqf65Zpe4u2uGJOZiPWWGuuGquGN4JTBoC2+tJu
   +KyXMk9M9Q35SMZ/1Q9yz6I34iMp4Zbk/yRig6OpFrvWmH7zGc2JUnUdy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="362165301"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="362165301"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 04:02:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="798785186"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="798785186"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2023 04:02:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 04:02:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 04:02:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 04:02:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMAS/sURFXkz6vaxxlk4ZF5/g6qROOYqoW4uc7O2BGiD33govkHL1uVLr3+84sDJFwlFO0GAr8hnQEP4TPw9kjCMMri88YpNW8kTyHnFJg+x/EA43D44d/EVVpA5Y6Ov88jDoXneQy3MZajQitEcfmQsI51kTQVi1QX4VyWK7aad1i541eLZhFJneQHDrPJMlLrvM17TC02nfz8QD5Wb77g+AMquRa1A0zDyuPXox0QT6PVAwco0iy5j6rkQgmXgjp1tc5VCmRPFRPL9SmjaB2fvy62jB5IA8rlr3e3Eq1ixffLoTT1aJq/mXfQQv/ubsHdK36/f8kbOVdB2qO0x1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkuLZ2qji2hk4N25F55mJuSF6Q9RgkOVdNC4fRIIoU4=;
 b=EeErqenSe+hAPcfikmm1DtjfdeEkNuHhB7udoXZv6mPsSs+eAJ4pIsJnie72Awlf618/MisFJivSd/a9itWAPx1DOzv5X5AQABUDQNRwrnsiWed71hXbgZEBTivloDoEJMPkFw9ECrLvimGzcW56VSfIIwY8ecDS4qci0Y1IZRy/VQKsTVGc5TaM5DlmHXvWMjmmoxcLgrs9u3V7JCFw12LPJxu4ORfXkdj9GydaLr3Husa++sTXIFgMgUrOPeaKXrcH1LhwftWVRFbP/dfEOAIhHdjHClyAT3gl532r4Q9y1him3Ub/RJY020s0GPpK7oSkvozj7zXkFr5EFQTM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY5PR11MB6319.namprd11.prod.outlook.com (2603:10b6:930:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.24; Mon, 14 Aug 2023 11:02:37 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 11:02:37 +0000
Date: Mon, 14 Aug 2023 13:02:28 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, <kuba@kernel.org>, <toke@kernel.org>,
	<willemb@google.com>, <dsahern@kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <hawk@kernel.org>, <netdev@vger.kernel.org>,
	<xdp-hints@xdp-project.net>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH bpf-next 4/9] net/mlx5e: Implement AF_XDP TX timestamp
 and checksum offload
Message-ID: <ZNoJxCgGrftwt+4x@boxer>
References: <20230809165418.2831456-1-sdf@google.com>
 <20230809165418.2831456-5-sdf@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809165418.2831456-5-sdf@google.com>
X-ClientProxiedBy: FR0P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY5PR11MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f1dbe5-e55c-422b-7220-08db9cb5f82c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NySW7dmIRIzRErTtmuIGFA1qhs/mGQfHDFBAdfltabN8MV6S9tKxIxnrYYxucgzuGQBKfTdukfnpKKYeAcQZV2XOStOSn87MeNcMWK8bHE3H1fLHbRuIm0TWiBJoq4v6scI7vRrp0XgJzbf2TE7E4Dl2vDmELZSOd5CvKE3wplWaXtvIWtr0O8TeCsecfw61SOgvTC6ZKat8oUmDsvUX3C+3zej/6IHKAQiFtS5gK69BMalwr8q+ARGNuyIEFGn2Xy2Qt5SeFgYXolFEyJWsw8FbX1AKtcEsQocd0/28SoLl8LEMEgLuruvV11qM2HqK5Y68bk+Cwu5fjHQY7qKbYHNiB65Fr2WwZ4kS33w4bSvD5ixnUyBER/GfN8EVoUbZR215N7QHuNzXhPxNkpq11Pxq/nWAexV2mzJ1DTNvlKfy1xzOevbfLtgGzhJAYKURRtG1/ebDxTXZ87Cmk2wfIhm7+MDVwQyp9O0dYr+tn5ThpkAblMC/3s9+GC4STRtiQ/Cr5WxPl6JatLfwB3/cWGaxh/50ueIqjR4BTa7yg/PfIm7D6mXQNHKsvOmD56Y7D7wZd1bLeSTMok/V4voz0iimWFl4Gy/7Jz79U05+YMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(376002)(396003)(366004)(136003)(1800799006)(186006)(451199021)(26005)(6506007)(41300700001)(8936002)(66476007)(66556008)(66946007)(316002)(8676002)(9686003)(6512007)(83380400001)(6666004)(6486002)(478600001)(38100700002)(44832011)(33716001)(30864003)(86362001)(6916009)(4326008)(82960400001)(5660300002)(2906002)(7416002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bWIsdG12fNQJHnAGYfU7KdQtYKOKopKtGQchdZNu+1tgk397jBuTiIjf4z81?=
 =?us-ascii?Q?RP1ebknUvbpER4qTONUyHOCHgHytu5cwvIaztznUH8T5Gc2NytjZRPxc9vB/?=
 =?us-ascii?Q?Xmg7syV/F5a7RaDUNxTaUnpyICa8yNo0cpygTxSzZaGqtBKtPiPzYSVsH4O+?=
 =?us-ascii?Q?+oqUlUihZtTMT9kf1XmCCGd79dwqx8TmhBsnVwGx7nyXs/FwTciBhNW4LHWa?=
 =?us-ascii?Q?Q+8i+YdZaVf4Vyqp4R67UB6BeEHwIQhlEp/OchLxmqhPpDGXZu1vjgYwczlO?=
 =?us-ascii?Q?ykoJRSP6y5OaKdxJ4jOcQ1f2oxnZ9/G7eto2zHDMf9t0Q3KHzfHiodLJdsUT?=
 =?us-ascii?Q?S36/MQZIHF1yAFcRKgkeUMpdCpJOlMGMWx2LvE4hkh34V/59vjyDftDjdyw3?=
 =?us-ascii?Q?63wFa6lK3meowdZ6AZ5FskFALF0MPU65IRHXlw/XsXYLNhvgG5a6gu7CFaTD?=
 =?us-ascii?Q?+ovgq2hiB3sUyGzu70Zw5lIT/1vu0AAXELbfV8Ttret2/nS478dtKoqpx1dS?=
 =?us-ascii?Q?sWcr0mCxWVaLbAldDyQFIqZeaNsPcEJLIGJny4wXgJ9+D7If9QHHxs1Lzr0m?=
 =?us-ascii?Q?Mj5Gp2Sjo19wSEUOoHiIpknjKEF77BL7oMEMnH4DA2Gj9YGX5ZZXUV89329w?=
 =?us-ascii?Q?rmxhRySu/8/RfraVqwO88PmfBAeaaMtrDd9cxX63wAhjAm/B2LDG/kIbaJ0f?=
 =?us-ascii?Q?4uNKRZ3bOkCJYWbiadJBZ8Uilg6NiqVfFsm8BHzcO6e+PtXKo94m8UL+2v+W?=
 =?us-ascii?Q?nLk6/7oxWG6mObzPlODJUPSKqQRt57EYPvln7yQo+RFvrXsmggXFTXns4WlW?=
 =?us-ascii?Q?0ZUTzYb7TvGkm+OcpR5HseSoJ9kAi8oHheeTdbok5mNNdMZOydUQI5mqVyMZ?=
 =?us-ascii?Q?FmzRWZ8uYYRPV1PN/0MsOBK3FfWX2Nqx/VKAkjvNgsYEBBwj8+tou24NZMAe?=
 =?us-ascii?Q?n6OECMOxd7zRBRL0SbZgYv5Fs+Vu9M/JUFySFmO20XT9h+W/4FHGRGKiu34m?=
 =?us-ascii?Q?fUlpdMZ5+BT0w8LHH/ccd3WXiaLxoBQVkdBOj0VkzRY33vOqkz2N4EvAcpGB?=
 =?us-ascii?Q?7hqFaCbfrlV1hciIP1PGr09ZT1Sf6rwsHT+UQ1WJ8pDTf8S1jflzYOdh8tuv?=
 =?us-ascii?Q?vYv2KYWRuVGvb2jZ8c1Sxq88+qzNlrXEUqIIm6OaSWdLZnLQpTa8zUW/qMos?=
 =?us-ascii?Q?nW0wQBVuPVkNZOsHC0vfDZTN7MCGox9Do7RJnf3Kwq6JaXm6EU8csVEXP3x/?=
 =?us-ascii?Q?HLKN97Ia6trdcFJbS9764lrVjAPA3YVH4nPeKXB4FuKicCgNdAvACTMFVu9i?=
 =?us-ascii?Q?I8PmDjHiX7yjBm/sj+dHFtSvw+X2JSB2bNY5UDbJhwc4r9GfviTPBBvkKLKS?=
 =?us-ascii?Q?E/zp9J0uxfjSlylLxCYYL8bRt/onuWnwOXMtrndph19gLVyem3F6cHgGOMYa?=
 =?us-ascii?Q?TiMOlZOc8QlBE02COf62RNWzh0wSgwT0ReXRbKwe7u8LKx/17o1HAraFggQg?=
 =?us-ascii?Q?K+dM0ybEulxU8bGl2E2BGabOEwJLS/jJ17i9iOu/2fTrUR7rrPumPfuVjBqu?=
 =?us-ascii?Q?ZsC7kvIMnp78YIXLE0Xtzz99QpIwhLVE2bb75UcLk/OsECmEPdc8y85EfSlq?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f1dbe5-e55c-422b-7220-08db9cb5f82c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 11:02:37.2570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1mppYQbgifLuk6GghQSHdAksHshPqfx72Lqtu+cG85M8Zv5NOOYU7bFWFYrtek+Qe5qNqgarZd+o9VKLK4NMbnEDhCE0hKMFzsqQyiyk5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6319
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 09:54:13AM -0700, Stanislav Fomichev wrote:
> TX timestamp:
> - requires passing clock, not sure I'm passing the correct one (from
>   cq->mdev), but the timestamp value looks convincing
> 
> TX checksum:
> - looks like device does packet parsing (and doesn't accept custom
>   start/offset), so I'm ignoring user offsets
> 
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 +-
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 72 ++++++++++++++++---
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.h  | 10 ++-
>  .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   | 11 ++-
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |  1 +
>  5 files changed, 82 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 0f8f70b91485..6f38627ae7f8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -476,10 +476,12 @@ struct mlx5e_xdp_info_fifo {
>  
>  struct mlx5e_xdpsq;
>  struct mlx5e_xmit_data;
> +struct xsk_tx_metadata;
>  typedef int (*mlx5e_fp_xmit_xdp_frame_check)(struct mlx5e_xdpsq *);
>  typedef bool (*mlx5e_fp_xmit_xdp_frame)(struct mlx5e_xdpsq *,
>  					struct mlx5e_xmit_data *,
> -					int);
> +					int,
> +					struct xsk_tx_metadata *);
>  
>  struct mlx5e_xdpsq {
>  	/* data path */
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 40589cebb773..197d372048ec 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -102,7 +102,7 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
>  		xdptxd->dma_addr = dma_addr;
>  
>  		if (unlikely(!INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
> -					      mlx5e_xmit_xdp_frame, sq, xdptxd, 0)))
> +					      mlx5e_xmit_xdp_frame, sq, xdptxd, 0, NULL)))
>  			return false;
>  
>  		/* xmit_mode == MLX5E_XDP_XMIT_MODE_FRAME */
> @@ -144,7 +144,7 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
>  	xdptxd->dma_addr = dma_addr;
>  
>  	if (unlikely(!INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
> -				      mlx5e_xmit_xdp_frame, sq, xdptxd, 0)))
> +				      mlx5e_xmit_xdp_frame, sq, xdptxd, 0, NULL)))
>  		return false;
>  
>  	/* xmit_mode == MLX5E_XDP_XMIT_MODE_PAGE */
> @@ -260,6 +260,37 @@ const struct xdp_metadata_ops mlx5e_xdp_metadata_ops = {
>  	.xmo_rx_hash			= mlx5e_xdp_rx_hash,
>  };
>  
> +struct mlx5e_xsk_tx_complete {
> +	struct mlx5_cqe64 *cqe;
> +	struct mlx5e_cq *cq;
> +};
> +
> +static u64 mlx5e_xsk_fill_timestamp(void *_priv)
> +{
> +	struct mlx5e_xsk_tx_complete *priv = _priv;
> +	u64 ts;
> +
> +	ts = get_cqe_ts(priv->cqe);
> +
> +	if (mlx5_is_real_time_rq(priv->cq->mdev) || mlx5_is_real_time_sq(priv->cq->mdev))
> +		return mlx5_real_time_cyc2time(&priv->cq->mdev->clock, ts);
> +
> +	return  mlx5_timecounter_cyc2time(&priv->cq->mdev->clock, ts);
> +}
> +
> +static void mlx5e_xsk_request_checksum(u16 csum_start, u16 csum_offset, void *priv)
> +{
> +	struct mlx5_wqe_eth_seg *eseg = priv;
> +
> +	/* HW/FW is doing parsing, so offsets are largely ignored. */
> +	eseg->cs_flags |= MLX5_ETH_WQE_L3_CSUM | MLX5_ETH_WQE_L4_CSUM;
> +}
> +
> +const struct xsk_tx_metadata_ops mlx5e_xsk_tx_metadata_ops = {
> +	.tmo_fill_timestamp		= mlx5e_xsk_fill_timestamp,
> +	.tmo_request_checksum		= mlx5e_xsk_request_checksum,

Can you explain to us why mlx5 doesn't need to implement the request
timestamp op?

> +};
> +
>  /* returns true if packet was consumed by xdp */
>  bool mlx5e_xdp_handle(struct mlx5e_rq *rq,
>  		      struct bpf_prog *prog, struct mlx5e_xdp_buff *mxbuf)
> @@ -397,11 +428,11 @@ INDIRECT_CALLABLE_SCOPE int mlx5e_xmit_xdp_frame_check_mpwqe(struct mlx5e_xdpsq
>  
>  INDIRECT_CALLABLE_SCOPE bool
>  mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
> -		     int check_result);
> +		     int check_result, struct xsk_tx_metadata *meta);
>  
>  INDIRECT_CALLABLE_SCOPE bool
>  mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
> -			   int check_result)
> +			   int check_result, struct xsk_tx_metadata *meta)
>  {
>  	struct mlx5e_tx_mpwqe *session = &sq->mpwqe;
>  	struct mlx5e_xdpsq_stats *stats = sq->stats;
> @@ -419,7 +450,7 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
>  			 */
>  			if (unlikely(sq->mpwqe.wqe))
>  				mlx5e_xdp_mpwqe_complete(sq);
> -			return mlx5e_xmit_xdp_frame(sq, xdptxd, 0);
> +			return mlx5e_xmit_xdp_frame(sq, xdptxd, 0, meta);
>  		}
>  		if (!xdptxd->len) {
>  			skb_frag_t *frag = &xdptxdf->sinfo->frags[0];
> @@ -449,6 +480,7 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
>  		 * and it's safe to complete it at any time.
>  		 */
>  		mlx5e_xdp_mpwqe_session_start(sq);
> +		xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, &session->wqe->eth);
>  	}
>  
>  	mlx5e_xdp_mpwqe_add_dseg(sq, p, stats);
> @@ -479,7 +511,7 @@ INDIRECT_CALLABLE_SCOPE int mlx5e_xmit_xdp_frame_check(struct mlx5e_xdpsq *sq)
>  
>  INDIRECT_CALLABLE_SCOPE bool
>  mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
> -		     int check_result)
> +		     int check_result, struct xsk_tx_metadata *meta)
>  {
>  	struct mlx5e_xmit_data_frags *xdptxdf =
>  		container_of(xdptxd, struct mlx5e_xmit_data_frags, xd);
> @@ -598,6 +630,8 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
>  		sq->pc++;
>  	}
>  
> +	xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, eseg);
> +
>  	sq->doorbell_cseg = cseg;
>  
>  	stats->xmit++;
> @@ -607,7 +641,9 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
>  static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
>  				  struct mlx5e_xdp_wqe_info *wi,
>  				  u32 *xsk_frames,
> -				  struct xdp_frame_bulk *bq)
> +				  struct xdp_frame_bulk *bq,
> +				  struct mlx5e_cq *cq,
> +				  struct mlx5_cqe64 *cqe)
>  {
>  	struct mlx5e_xdp_info_fifo *xdpi_fifo = &sq->db.xdpi_fifo;
>  	u16 i;
> @@ -667,10 +703,24 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
>  
>  			break;
>  		}
> -		case MLX5E_XDP_XMIT_MODE_XSK:
> +		case MLX5E_XDP_XMIT_MODE_XSK: {
>  			/* AF_XDP send */
> +			struct mlx5e_xsk_tx_complete priv = {
> +				.cqe = cqe,
> +				.cq = cq,
> +			};
> +			struct xsk_tx_metadata *meta = NULL;
> +
> +			if (xp_tx_metadata_enabled(sq->xsk_pool)) {
> +				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
> +				meta = (void *)xdpi.frame.xsk_meta;
> +
> +				xsk_tx_metadata_complete(meta, &mlx5e_xsk_tx_metadata_ops, &priv);
> +			}
> +
>  			(*xsk_frames)++;
>  			break;
> +		}
>  		default:
>  			WARN_ON_ONCE(true);
>  		}
> @@ -719,7 +769,7 @@ bool mlx5e_poll_xdpsq_cq(struct mlx5e_cq *cq)
>  
>  			sqcc += wi->num_wqebbs;
>  
> -			mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq);
> +			mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq, cq, cqe);
>  		} while (!last_wqe);
>  
>  		if (unlikely(get_cqe_opcode(cqe) != MLX5_CQE_REQ)) {
> @@ -766,7 +816,7 @@ void mlx5e_free_xdpsq_descs(struct mlx5e_xdpsq *sq)
>  
>  		sq->cc += wi->num_wqebbs;
>  
> -		mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq);
> +		mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq, NULL, NULL);
>  	}
>  
>  	xdp_flush_frame_bulk(&bq);
> @@ -839,7 +889,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>  		}
>  
>  		ret = INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
> -				      mlx5e_xmit_xdp_frame, sq, xdptxd, 0);
> +				      mlx5e_xmit_xdp_frame, sq, xdptxd, 0, NULL);
>  		if (unlikely(!ret)) {
>  			int j;
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
> index 9e8e6184f9e4..2fcd19c16103 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
> @@ -82,13 +82,14 @@ enum mlx5e_xdp_xmit_mode {
>   *    num, page_1, page_2, ... , page_num.
>   *
>   * MLX5E_XDP_XMIT_MODE_XSK:
> - *    none.
> + *    frame.xsk_meta.
>   */
>  union mlx5e_xdp_info {
>  	enum mlx5e_xdp_xmit_mode mode;
>  	union {
>  		struct xdp_frame *xdpf;
>  		dma_addr_t dma_addr;
> +		void *xsk_meta;
>  	} frame;
>  	union {
>  		struct mlx5e_rq *rq;
> @@ -110,13 +111,16 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>  		   u32 flags);
>  
>  extern const struct xdp_metadata_ops mlx5e_xdp_metadata_ops;
> +extern const struct xsk_tx_metadata_ops mlx5e_xsk_tx_metadata_ops;
>  
>  INDIRECT_CALLABLE_DECLARE(bool mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq,
>  							  struct mlx5e_xmit_data *xdptxd,
> -							  int check_result));
> +							  int check_result,
> +							  struct xsk_tx_metadata *meta));
>  INDIRECT_CALLABLE_DECLARE(bool mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq,
>  						    struct mlx5e_xmit_data *xdptxd,
> -						    int check_result));
> +						    int check_result,
> +						    struct xsk_tx_metadata *meta));
>  INDIRECT_CALLABLE_DECLARE(int mlx5e_xmit_xdp_frame_check_mpwqe(struct mlx5e_xdpsq *sq));
>  INDIRECT_CALLABLE_DECLARE(int mlx5e_xmit_xdp_frame_check(struct mlx5e_xdpsq *sq));
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> index 597f319d4770..2f69c7912490 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> @@ -55,12 +55,16 @@ static void mlx5e_xsk_tx_post_err(struct mlx5e_xdpsq *sq,
>  
>  	nopwqe = mlx5e_post_nop(&sq->wq, sq->sqn, &sq->pc);
>  	mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo, *xdpi);
> +	if (xp_tx_metadata_enabled(sq->xsk_pool))
> +		mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
> +				     (union mlx5e_xdp_info) { .frame.xsk_meta = NULL });
>  	sq->doorbell_cseg = &nopwqe->ctrl;
>  }
>  
>  bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
>  {
>  	struct xsk_buff_pool *pool = sq->xsk_pool;
> +	struct xsk_tx_metadata *meta = NULL;
>  	union mlx5e_xdp_info xdpi;
>  	bool work_done = true;
>  	bool flush = false;
> @@ -93,12 +97,13 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
>  		xdptxd.dma_addr = xsk_buff_raw_get_dma(pool, desc.addr);
>  		xdptxd.data = xsk_buff_raw_get_data(pool, desc.addr);
>  		xdptxd.len = desc.len;
> +		meta = xsk_buff_get_metadata(pool, desc.addr);
>  
>  		xsk_buff_raw_dma_sync_for_device(pool, xdptxd.dma_addr, xdptxd.len);
>  
>  		ret = INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
>  				      mlx5e_xmit_xdp_frame, sq, &xdptxd,
> -				      check_result);
> +				      check_result, meta);
>  		if (unlikely(!ret)) {
>  			if (sq->mpwqe.wqe)
>  				mlx5e_xdp_mpwqe_complete(sq);
> @@ -106,6 +111,10 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
>  			mlx5e_xsk_tx_post_err(sq, &xdpi);
>  		} else {
>  			mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo, xdpi);
> +			if (xp_tx_metadata_enabled(sq->xsk_pool))
> +				mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
> +						     (union mlx5e_xdp_info)
> +						     { .frame.xsk_meta = (void *)meta });
>  		}
>  
>  		flush = true;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 1c820119e438..99c2a6babaea 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5097,6 +5097,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
>  
>  	netdev->netdev_ops = &mlx5e_netdev_ops;
>  	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
> +	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
>  
>  	mlx5e_dcbnl_build_netdev(netdev);
>  
> -- 
> 2.41.0.640.ga95def55d0-goog
> 

