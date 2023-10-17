Return-Path: <bpf+bounces-12442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AB07CC880
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFA9281B31
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29B245F75;
	Tue, 17 Oct 2023 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcmyBj01"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B067245F65;
	Tue, 17 Oct 2023 16:13:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D720107;
	Tue, 17 Oct 2023 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697559232; x=1729095232;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QzeH4b7Rg9lDeMUmK4zWOn8d8SiQjYZYRiGYVbeHDhk=;
  b=OcmyBj01AVnNkQyzqWVby9cNFPzLv8N+s1sKQ4U96RYwuXJV29Cho0jx
   GsSpUpesD+Zm9ga5DnkTE7NaFRdAfJl18knwqbODbTfv9AFW1j+y620dE
   vnSVYQM/D3H9aSbXBUaA7cD8ZGmRZl6ktOhFmpdq26GgvHZwtnU9C1Jx+
   IWnN1PRtFCDnkhO+gbjspZ5KFYByMUDQfIGPYUOBiDb5wXUFRivc4lGrY
   zggy0uPU6XJJIZmWo1M4U0T2HDZ4vpa5DAucvSS+r5UmL4KMbJ9Idwk0V
   zkPKrExF2YZtwYesAJZvLNX3QK1rWndyobg1qe9HuYg2yVABH9SPjaNvZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="472042621"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="472042621"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:13:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="899961234"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="899961234"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 09:11:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 09:13:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 09:13:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 09:13:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 09:13:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuyBib+wXzddzyS1fZUsFWZanO3FAmVmfBgBRaHwmbrl7+hRtc2e3H3EU0Z/ei5haz7rbaZpOfXIMfjUj/91EPw9mQ02URA3WCqvEfAq7giIEFsdsZZ5NPz0zdtLSJIlZHUBNS2pinekI6s7zrZ0FqfJ5SVooCoEU2wwbh3julUNLBhTKkSdw6yma/nAC2s0VCGU39b3QsntOhvLCkpl3QfIZxfiKIiGFAYhm8TZjhnrNHSRU+3NFaiMSLW1H/ecOo23x+9pk4F0JGCyBP14ajz+AJ+HdU6QhBGfVJb7XRZfk7FLai3eK0uqWe4qdRxA9eRVBgfhi30Dp4oB8pAbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4qI4WzmiBXk18YhZLT+JX+q/CQoPq1Nyj75D4++kSs=;
 b=X124m57XQOZJEP1DLD7JV51Zg74u3AsKI0WgK+1qLyqvtlvKUe9PN4U2q90Hz9D9LeDYEc9jL8/lMtvK0lpg2G9OqwVZAtvkY+Q9R5PwHfHaSR6umbv7QIZh+mvixtwpSgrVnWwvCvEKzvEGjBjFlgSXtMNj7hotJnJZGjT53BExKXL85li0qUH3IZy9bOBR/3k0iPv0qiQ63YsVcuknRtLAemc8ppBlgPBImoQ0l8thd+i0EK+6S/sAcq7HdhjzolPIA8S6x2HnjEaZuuBhvec8nmmFRcmu6gU6TtiiDs25FvuSfAy/3AbZ840btJWqD3SJaigkVLt1gqtn4056LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB5043.namprd11.prod.outlook.com (2603:10b6:303:96::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Tue, 17 Oct 2023 16:13:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 16:13:46 +0000
Date: Tue, 17 Oct 2023 18:13:30 +0200
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
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
	<magnus.karlsson@intel.com>
Subject: Re: [PATCH bpf-next v6 07/18] ice: Support XDP hints in AF_XDP ZC
 mode
Message-ID: <ZS6yqqMZD1mojQNr@boxer>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-8-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231012170524.21085-8-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR3P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO1PR11MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a036b9d-3a69-468f-67bf-08dbcf2c0a1e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLwaVLQg9H6XYOtT4chsTsZzHsXHpeDya775cQ5jI32K4jLrNCH/rTVntJ2PAaOp91h2cUL7wTNiNMUb6vDf48XZEwDgoLcBdMSyjLYTIIMKM/0dxXhTkz27hvo7a5hAeFv4QmLRzJSbkuG0fwhE2++ffWWBZwOLikBnBvFpOMCFUYfThgSL5846cMKPOwdGsfyHYa+VjEVrty40OWvaBZrs8SBXCsulYR944uxOnt4AzKpmmELmtMz5zQRXcEp+oAxmaffr5M1m7gxNWHZ8aX+TgopHMS6P7Tds4Wv/CB3bi3Y0Bv7Av8c5CwoQENJh5S86xglZIIfKTJlt3F68DQ0qG1zgDsegbQUqSRfrpYHmmbhAkf+5tYsqPYVLUhiamd+KO2HK7iYpauEYlOFxfWWroE2trU0TtE1+QTo2Xmj2X8ntEVERgAwNWiplbjZS3yxuxx9/vOQZIObyUnNwi77mgJidG3JCaFGiDN4X9nG59ZFc2TUuTlJTNXLerfovR35RQqNEi5S+uWdaqAoiEzmarpremGXhtqKlVt0MEzXsqhBSunJWmwA76f+UFbH/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(38100700002)(6666004)(6506007)(9686003)(6512007)(26005)(107886003)(82960400001)(478600001)(8936002)(66556008)(66476007)(54906003)(316002)(6636002)(41300700001)(66946007)(6862004)(4326008)(8676002)(7416002)(6486002)(86362001)(2906002)(33716001)(44832011)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uYX4P9/SI5/ygEjcMCCiQGXScUYdretYMRV2bOEdLe4tzC/piP83wtS9aU5n?=
 =?us-ascii?Q?T9B0PdZ8cNudGyhkymCLssi31CFH56LtEwYIQGpBt8VvWCTh1Mlpp4KuMzSu?=
 =?us-ascii?Q?H6TGGSaxNewD1JchUtFxnwRN3mP1nyGyzAQFyQ42tVbQZu7LfhkUekuu4Pgd?=
 =?us-ascii?Q?3uaSa6gHZcvjm/KglN9rmHgbmiuHtTof/jrNA+fCaCqotrJrEdFQuc9Hoqc9?=
 =?us-ascii?Q?t34VDtN1CFwUbIvEbKe3nbA6DN2Y1vrdYxn0sAZjlaCOfaWFAm/KphC2XrGr?=
 =?us-ascii?Q?1cEV34G5TlHJXFIitpg7EaKHZdySrDIPXBm3RasVXnq6/Fdsn7K0gmM5N7m2?=
 =?us-ascii?Q?VWIxciEVzJcxEHPjBlnfSu3jYBY0x9yxlUEjMCNUQ3GIYRpZmhtzIA8dO2Mu?=
 =?us-ascii?Q?lWtFsA8TJelzh7NarAJgN96rzyDsH9st/m1kou1K4SF9LBXuyn74LdE0AOon?=
 =?us-ascii?Q?if06slSZ8Wx9I/YTWmlqmBdEbxl98vfaSvXim9w861g2bIVaYp5O3BA2pYjU?=
 =?us-ascii?Q?SA1RN3AIeXmth/XJSwJsOw2ASYTumWI1sp0fajPKR+McujITPiPmvRkHTLGo?=
 =?us-ascii?Q?XweVIcHYaZNghNjP6wNpqM6xVabAx8aARkrC/5NgaFLnydLbi8RD/mGFGMN1?=
 =?us-ascii?Q?Q6ZR5acNSqNd+V0bkUNjJdXFBdpXcnPC8HeaJCJ2sda2N6eYVCloQpoDSlmf?=
 =?us-ascii?Q?gkFXOmnordYuUg7eFpQv8u8Sva1mxOoN6WwnFnT2UNzfJrd+2Y3gZgcsoSni?=
 =?us-ascii?Q?rBQlyW6tanVsKKK5OKwfbsmAFZ4XIVQjriFYMzRiEyAoDav9XhDkX0XSfVH4?=
 =?us-ascii?Q?fsy+FOlqq/WmTbID3YTmbGSWSCJg7WQ7VS8FjrZJyOD4F98pPZoxcZknRZYT?=
 =?us-ascii?Q?Q6+wtc6kmDqgpevAgAjGjxQxu0hicI9gT9ts69+if0t/F0SEMv/IdvjYG1tO?=
 =?us-ascii?Q?csmI68Y2Q2UtjxpXysXEpNe0HqrfhMcdTq1YlPAvUJjbaQjB/ptbfkT2aaSL?=
 =?us-ascii?Q?Fedvr3hmsMkFAyez+wcQQVIMDo+Ri3kaDQ19i4vsLxHbpPzIgr4iU5SRkPLb?=
 =?us-ascii?Q?E8KKc/omFNMKGlba4FGSG1GiJC0wL+iFw4b9ji6G6S/0UZ6k+NfJHEvC7hz6?=
 =?us-ascii?Q?jbvqERwFhA1l6W9IJoAez/eASbXF4mNevMdMdr8I+wLDwEgW2chYQQ6bV9JY?=
 =?us-ascii?Q?BNGpvrySCT/IdbDTOadOsQ9nbByEOjJcLwH/nqcgS4jXmvrkGYp7EEhSWO+M?=
 =?us-ascii?Q?xLqEdeTiDukLZymqZ+zn3q4lfOcUDfvmcS88MkySrEzW1yjpCH0l/RUQJkf0?=
 =?us-ascii?Q?CD43ntDMmTjpE2tf8Qu6OypFvJ9cfGc1c2fugIYIADqy1uwnwnZJ6nLPOqdP?=
 =?us-ascii?Q?30Hquu7Q4f5+EVGzI25ueHsrLhX5SKPiLjXxMznAAoh+QpdfVKEkcgvyRnkn?=
 =?us-ascii?Q?ArPYvjJLNlhmy6Z9xisRi2tabBsJZ4AoJLavH1S3JelOey/F+lBqvg8bN1Bl?=
 =?us-ascii?Q?dsGO8I10mlizpZiAg6/3DQ9kaH9Xrkce/u2Ew8TXfYFiF1nAiPaz0w7m/bCY?=
 =?us-ascii?Q?pQYB4311g3F38OwlDoDhaGlcCxpgKqLpin20ntuYkw5a4e9VS+q4lQ+j+spM?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a036b9d-3a69-468f-67bf-08dbcf2c0a1e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:13:46.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpr2m68y6doAKmXGzEIkYyjVLlaVP4A6gtIH14Pk3PHm/n6yT7IfoLFBRZy2xuNgrwzqo6iSsgX6O8qB7jZe73IR4oVbvHURaiN3G+eGQaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5043
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

I will be loud thinking over here, but this could be set in
ice_fill_rx_descs(), while grabbing xdp_buffs from xsk_pool, should
minimize the performance overhead.

But then again you address that with static branch in later patch.

OTOH, I was thinking that we could come with xsk_buff_pool API that would
let drivers assign this at setup time. Similar what is being done with dma
mappings.

Magnus, do you think it is worth the hassle? Thoughts?

Or should we advise any other driver that support hints to mimic static
branch solution?

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

