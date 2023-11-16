Return-Path: <bpf+bounces-15195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8159B7EE40B
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9CD1F2121D
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46233CDD;
	Thu, 16 Nov 2023 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6bLVvm5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEAD18D;
	Thu, 16 Nov 2023 07:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700147997; x=1731683997;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xZiq0ZmmHJKCM6KzitQXLov9k1JXbUec4ZFcWzQvsEg=;
  b=Q6bLVvm5PxNq9PZY83ADturOTeS/HkTmzIJqstnO17POLz6uA9aoGtfy
   PzNtGr6e1Z2Zgl0C6eW2+1b/2YMB5eMUtMxH/6C8tyq6itQ1kDmO5tYiB
   qQG5jTycIaVh9iTnQbpT6ryfbhMvNi9SS1hzKP7WaJhLP2N6OKQg5LOJ7
   AfHS/57vFEYGaJo/Hb1kPIfq4FS0eYm40SOn9prh/ZlMlo7eKT/WLWHll
   88dlT35L6pNmiojx7l9iXXbQhya8dXYxNaCD7LUFJHKKFTuES7MdX477W
   kRHmzrMX5h3jOEfG7AVtnEsQsXB4bxVhMrOU5+wuXsrhvy9TLG2zd0sfi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="388271528"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="388271528"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 07:19:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="6560365"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 07:19:56 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 07:19:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 07:19:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 07:19:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcjwEt9Tc/Q2d9ekEmUtAxZA8Zp82NtfeL+P+XyKxUrmcxmK7EOMevave5DFlhAQyUnjZ9hT4YeBPJafLkbx6oc+vhmrZGTJOxtGCJPTX+Brju3//7mEHEY5L27lb8+nvWHAWX4Fb/tnTN7cpziYXiDOKtQA7NDmbzynSWr4HAYTDEwlZmxNIlmNKWlcbJgi10uIzAi3v3xHY5lYzxbvXvaQM3kVg3zFoUAArw2xyIGhB4hm4ZU/aws/Y1zd0VbK11kaPXLNTFodsSYYsaUeH2lnqDiUQ4sSfw78N2ZuRkdY+PG3AiurclsML3iEPBgNeOnwDlw4bIypxyLypu1vFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzA0fXeQgkg/QTwrBPq+Xv0TwJJtvUu5vcmw/7o2/sA=;
 b=OI78Wd9Q/0DQ61R/9dXKgO817CId2PfXyAOQi+NSSayWh5M8911J4SUCqnvW+Gxw9kf0/ZJrLimMMqPqhwRFVRArHU77sryxRrVa4ro/T+hTbfKCXwPu/3eWzKz9fqlP2lzQW0bzw2stBYXZ3ln2sTW7+1BMrfspQrY0M2kj8gqh8fOfbtJSSj71JZCxngMO4ubd4YzZU451dO65Q4sYmGkOSfddMenk2fxSxrSmymRqleTkmQ7bC8t+hqkEG0jH45IuOEpz9Q0EfoSiayEfHqJ41UdRl36ZGsI88ST3v5OwBqsihgm/AMnMBmVxN2xq2z+QU8r97l+tBjNP3MVT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN6PR11MB8242.namprd11.prod.outlook.com (2603:10b6:208:474::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 15:19:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 15:19:52 +0000
Date: Thu, 16 Nov 2023 16:19:37 +0100
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
Subject: Re: [PATCH bpf-next v7 02/18] ice: make RX HW timestamp reading code
 more reusable
Message-ID: <ZVYzCRFm6gc4x+VS@boxer>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-3-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231115175301.534113-3-larysa.zaremba@intel.com>
X-ClientProxiedBy: DU2PR04CA0158.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN6PR11MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ce7a4b-895a-4c3f-6589-08dbe6b77a1b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOKWOHjHR4GtBdh9KAq2Gnyu/V4aCoO3UpULHtvnhSeCVXx+VMnRfh0Jn9q2lJijVvCz/UNEhVGukYnfqbCglDiTlIO7SHuzG0mKCxWsk1ggm9a3wNoZYl5gC+uCu9bue9Q+OsuR/reWvPbLgtUCb871eC/OgQaVP/mVnqWnubHfOZ+0gijYZ2EFmFuCn79u0kXNCHO/8bLBoWFE19pBZ1VvR1Vud4/2LwVyFGv5pi/3q1X/i67Oy+gdCOSxjSUvf0qNUdV8Oi4ht5k/gIw7x12H+zxmy3PfuyKEkiWHoEnrMK3+eOcsOuSpJLVLLNeXEb2EP+dyJEi5eLcEs4XcwjXrbM5dPmxukWBx3TmTBARDeTzr6XLlydJVKqmblCnKJ6Ti3cRGRe/GZFaY8646JD8I4n6HdkLfFZKoO1u/AlfYZV6CTX5PvowLqCtioIe6WiGCR//wnbxU++PGlVXevVxzTzrkKpR35Vg5V5RXYYFSDfHs4x9QUD1sVFecCA9VMUZ9gODxLMQoRxPUBguyL21pHDfGpNdPpjp4CiwKTIHD5e3FsFqbRcGl4bv2ho8PGiZnFzJQgKVaGnqtGj2dkF8/D5mOyUB/uOgfNfIak8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(8936002)(8676002)(6862004)(9686003)(6512007)(26005)(2906002)(44832011)(6666004)(6506007)(83380400001)(4326008)(478600001)(41300700001)(38100700002)(6486002)(7416002)(82960400001)(316002)(5660300002)(33716001)(54906003)(66556008)(66476007)(86362001)(66946007)(6636002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0IanAISD5MatJbSmIvlFY5nyCtnlpiCZF3/ffw454zzmKxMnOQ3tT25ql4cK?=
 =?us-ascii?Q?gDHBrRvzHYyE/mEQmJ6TTg+sEpzPxXX2DvUQK0uGWvqnRZZ47TqQAfEuyQt8?=
 =?us-ascii?Q?yJ4gfLcHZlGrWZKRzuUnLo1p8ELn876QPQiEhkZWys29nJSznJgjz+Lul/zK?=
 =?us-ascii?Q?VS7938kOkjjTNDKqmQvnMpvECD8xngS4ZA1mX20HuwM2kQkgWC1q+gMjusa1?=
 =?us-ascii?Q?0qKNFy2vvUUhR9IJLuxFQ2QtamZPqAyMijHHzM3Ncn7adH6cJUyfX3jhIL3A?=
 =?us-ascii?Q?Gv92lRQNLSX3bAAPUNw0fTYRjtcC+MnzcmDTxSrh3+2rc2R//2rLeqoyvWO1?=
 =?us-ascii?Q?xkkZE7dpyz82lFnsfm6PJO20Z3P7UNRqOMYM8vOpP6gr8hC1gh6wbrrl4UW/?=
 =?us-ascii?Q?ZIm7wiEKscby3xrsl6GPCgyzqRhwHn5IzveMrBQtzEJZ0gF/gaVweeb6hxyp?=
 =?us-ascii?Q?COeoPnzTpMo01Vocy/8FUEVYBuoTDETaDk32MnmYhf32kdgr/NtiQ9Fb4QSX?=
 =?us-ascii?Q?5OKhpFL1JWKO1+GMfFusb9bE7gvRRDKLszshiqnDme/FXnGUH+JIRuB2RLpd?=
 =?us-ascii?Q?WoIgmhJxvtQkshv8VPD67rIzb1W9wdKeVKqXPI6RyzNHs9ptOqqNgYxAYyu9?=
 =?us-ascii?Q?UdlXxaAH0uF68wXPnEo4xnsapKQqpGLqxQFHc2UsYQrpZ9SeIuzdvqhp1kBQ?=
 =?us-ascii?Q?b5dF99RQle1QVmRfgf/oP8hyVDptcN73LjNsqfR/bI6MeonThLn1gIScl0wb?=
 =?us-ascii?Q?PrH3vef3e8zXO2M6ZK82aSrGqPPLMsiGx9T3Tr8We2hN5B+igILMwHTmYhV3?=
 =?us-ascii?Q?uNYiSLp5CrqQWPTL33FIhSP861JWfvZa5Jjq0mxoMT1wW/P+tXVSpq+U0kg+?=
 =?us-ascii?Q?eE4RMTouhUWA6CkOliEvgk63+/1a9wYJQ+Olo4JZIX4ol1F+lEsoWYInziE0?=
 =?us-ascii?Q?4EeEQf52X1ccs4DQHve7GSPgOEBxyzYd7H+vgkEhzg5TG/p4PDt5NXq/xXtb?=
 =?us-ascii?Q?P/e0B5dEt3zujfSPHetOKCJVc4YGhmGrfEy5Ig63ZjF0557ycfybMiDYfmLg?=
 =?us-ascii?Q?zuRbrPdnp3OU67TIgRF1V8LDGbZanP1Tt8dlwDhDsGANERerqX5hbeVxJ90q?=
 =?us-ascii?Q?TF0pq36tGKRDiAxwKsEb/GpLKIjQJnxp52pxXFq11E1lCBWmvZ7V5yW81gXf?=
 =?us-ascii?Q?uyaAUvu9GaLgHVJWjNxQPa8sF9GJ2ilox9GtEdUoL1HX/OM+HkUohEu8ElKv?=
 =?us-ascii?Q?QjoZDFTFdlvSoNrP72qAAKqql0/HJhdQJVjJ/+F94JMYWSek05WVKe+Zp7DX?=
 =?us-ascii?Q?4xkgChn8AGh0ZqqOkVMlaqa19fBUO3akAvj2P+nRtxuCPlIXXXtbe7M9ZH2F?=
 =?us-ascii?Q?CBmO/8feH+fjH3lzIIdRMwNcNHuFv2zmRV8TX78slt+Lwa0W7kIPl9xvLTHy?=
 =?us-ascii?Q?q4OQTxfLzS/OVGQ4efscvWu6gp/Rk8nlYB7csv+E1gXjLxxd1LNZh/PrTSa7?=
 =?us-ascii?Q?vg6f4mMxWLJqHlNfXLFSlE4GcSmWwy4ORNn49rK2KkuUrDDgIbcVmQ8zEvGh?=
 =?us-ascii?Q?TR5T+HygERgYwmqrG553QkOn37KrlPx6BGOsep/MD9JXLdio9CnR29J9JFzx?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ce7a4b-895a-4c3f-6589-08dbe6b77a1b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 15:19:50.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSSBsQjM52CH8wPOka/pTplvfSAdDdvgcndzYBd0k5OOABCg4gg/OIgPPudLsW9oYnDWcZ3/N2ilplp2m0d1PY8MmxgKreVbmzq+65z2M2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8242
X-OriginatorOrg: intel.com

On Wed, Nov 15, 2023 at 06:52:44PM +0100, Larysa Zaremba wrote:
> Previously, we only needed RX HW timestamp in skb path,
> hence all related code was written with skb in mind.
> But with the addition of XDP hints via kfuncs to the ice driver,
> the same logic will be needed in .xmo_() callbacks.
> 
> Put generic process of reading RX HW timestamp from a descriptor
> into a separate function.
> Move skb-related code into another source file.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c      | 20 ++++++-----------
>  drivers/net/ethernet/intel/ice/ice_ptp.h      | 16 +++++++++-----
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 22 ++++++++++++++++++-
>  3 files changed, 38 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 1eddcbe89b0c..a435f89b262f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2103,30 +2103,26 @@ int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
>  }
>  
>  /**
> - * ice_ptp_rx_hwtstamp - Check for an Rx timestamp
> - * @rx_ring: Ring to get the VSI info
> + * ice_ptp_get_rx_hwts - Get packet Rx timestamp in ns
>   * @rx_desc: Receive descriptor
> - * @skb: Particular skb to send timestamp with
> + * @rx_ring: Ring to get the cached time
>   *
>   * The driver receives a notification in the receive descriptor with timestamp.
> - * The timestamp is in ns, so we must convert the result first.
>   */
> -void
> -ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
> -		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb)
> +u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
> +			struct ice_rx_ring *rx_ring)
>  {
> -	struct skb_shared_hwtstamps *hwtstamps;
>  	u64 ts_ns, cached_time;
>  	u32 ts_high;
>  
>  	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
> -		return;
> +		return 0;
>  
>  	cached_time = READ_ONCE(rx_ring->cached_phctime);
>  
>  	/* Do not report a timestamp if we don't have a cached PHC time */
>  	if (!cached_time)
> -		return;
> +		return 0;
>  
>  	/* Use ice_ptp_extend_32b_ts directly, using the ring-specific cached
>  	 * PHC value, rather than accessing the PF. This also allows us to
> @@ -2137,9 +2133,7 @@ ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
>  	ts_high = le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
>  	ts_ns = ice_ptp_extend_32b_ts(cached_time, ts_high);
>  
> -	hwtstamps = skb_hwtstamps(skb);
> -	memset(hwtstamps, 0, sizeof(*hwtstamps));
> -	hwtstamps->hwtstamp = ns_to_ktime(ts_ns);
> +	return ts_ns;
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
> index 8f6f94392756..0274da964fe3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> @@ -298,9 +298,8 @@ void ice_ptp_extts_event(struct ice_pf *pf);
>  s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
>  enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
>  
> -void
> -ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
> -		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb);
> +u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
> +			struct ice_rx_ring *rx_ring);
>  void ice_ptp_reset(struct ice_pf *pf);
>  void ice_ptp_prepare_for_reset(struct ice_pf *pf);
>  void ice_ptp_init(struct ice_pf *pf);
> @@ -330,9 +329,14 @@ static inline bool ice_ptp_process_ts(struct ice_pf *pf)
>  {
>  	return true;
>  }
> -static inline void
> -ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
> -		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb) { }
> +
> +static inline u64
> +ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
> +		    struct ice_rx_ring *rx_ring)
> +{
> +	return 0;
> +}
> +
>  static inline void ice_ptp_reset(struct ice_pf *pf) { }
>  static inline void ice_ptp_prepare_for_reset(struct ice_pf *pf) { }
>  static inline void ice_ptp_init(struct ice_pf *pf) { }
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 17530359aaf8..c4dbbb246946 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -184,6 +184,26 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
>  	ring->vsi->back->hw_csum_rx_error++;
>  }
>  
> +/**
> + * ice_ptp_rx_hwts_to_skb - Put RX timestamp into skb
> + * @rx_ring: Ring to get the VSI info
> + * @rx_desc: Receive descriptor
> + * @skb: Particular skb to send timestamp with
> + *
> + * The timestamp is in ns, so we must convert the result first.
> + */
> +static void
> +ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
> +		       const union ice_32b_rx_flex_desc *rx_desc,
> +		       struct sk_buff *skb)
> +{
> +	u64 ts_ns = ice_ptp_get_rx_hwts(rx_desc, rx_ring);
> +
> +	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps){
> +		.hwtstamp	= ns_to_ktime(ts_ns),
> +	};

could this just be

	skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ts_ns);

?

> +}
> +
>  /**
>   * ice_process_skb_fields - Populate skb header fields from Rx descriptor
>   * @rx_ring: Rx descriptor ring packet is being transacted on
> @@ -208,7 +228,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>  	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
>  
>  	if (rx_ring->ptp_rx)
> -		ice_ptp_rx_hwtstamp(rx_ring, rx_desc, skb);
> +		ice_ptp_rx_hwts_to_skb(rx_ring, rx_desc, skb);
>  }
>  
>  /**
> -- 
> 2.41.0
> 

