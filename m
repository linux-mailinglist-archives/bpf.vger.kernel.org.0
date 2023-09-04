Return-Path: <bpf+bounces-9193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEA5791A24
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 16:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E9F1C208A7
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 14:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA7AC145;
	Mon,  4 Sep 2023 14:57:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B53D99;
	Mon,  4 Sep 2023 14:57:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8B2A9;
	Mon,  4 Sep 2023 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693839420; x=1725375420;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VR2cVmSHm9Q0uWvwwfe64J9x7fFOr3I57ZtP23tB5Rg=;
  b=JHeF0n0nPhR/OUym9HvW3mG2yPcu9QXUhzWkNd/I1RAZUUnvwb97awBZ
   bitGqeJp51dOw4UIGHWy5hHgYdBSd2irOw1N6Gi2HYg3bnV+UWNyEE7/T
   fo109uPcccNM9o7GhnBUiQiOvjR6eXQbJJJT8iqIYW7Y1hHXzsDmGXeEU
   ox3Rpw1pydriOotPRRgy5siqPGalQFbu/1N5PN5s8+kGjrIka8+H7Dr1K
   3xVvXi54E+1BpP+mIgoJTGjIPpImjRsaSQ7NB0AE5Tmr8xnf70UfPcdjd
   dO0BsC7nczTZNrG+lrL8mlnAfZSFVSuR8wq2vhX0WF6T5/TtcFHCFl1+e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="379324820"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="379324820"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 07:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="810926586"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="810926586"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 07:56:57 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 07:56:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 07:56:56 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 07:56:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjF0fbZ5R1yJYx1Gc2TbiIqOqBh+EtYRxL1hiKsUAt1BPxoCK1jm9xSpFR2QmdoXK7zSs2J8U4OLww1clYsGn4Ay6+mjqyGtJ1P1L4mnyys/hmw51Z5pjF6EBjZGR7ddVLIacfVwd12td9sddaNFfjS89GLdD8f1ZiZIhAvZUH++5olQN7/4cJhgXoMvnHTVAL10R58gtm87ebvFB/PYYFMRGLONxMmiiX8Ju61WkpA0V3sox8Z/l9u6jTAc6njoFo5lQrAI1gtvmpSyX+hHLuZ+1fteplahXJ0BTYlxX2EeihNlQ71PGI0AYOqP042YpVCre6jaeB3rBsfuPO0tow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaIxxQ/8sS02xTb/OOCVkk3/LVMY0gj7D05U99srzPc=;
 b=d1qeVVPVppFrZoNIuT37CTSx7oBgNJ+6vtYS1cYq9MGEvQTI2n6HASnyHjRx3zSYXbep5KPrekKvbggLzcZFNjRSxpyxeo034TVKdSF3jor7jnUXA+mZxJIuYTGli9q4YPlguaTsIGgkafg0Nejn4lcyHmYvQAlcqDxXxNHbNkJH0ELRoHo36JVbjo3yp6svg3hPfNKtBdmLi2uKo15YkwPZOABcw2OcAv+4naWl6ZIM8K9hmdBlw++ilyL4wJPFDBClvu1iKQNqHYZ/jdKxUEhQcj3cL/Kq9h7d0VUFmbPEk/DKSIASDdWG4GTGr2gwvr/pQhh8dTsk/Q8OLj0lYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.32; Mon, 4 Sep 2023 14:56:48 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 14:56:48 +0000
Date: Mon, 4 Sep 2023 16:56:32 +0200
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
Subject: Re: [RFC bpf-next 02/23] ice: make RX HW timestamp reading code more
 reusable
Message-ID: <ZPXwIOxfiNNZ55+W@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-3-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824192703.712881-3-larysa.zaremba@intel.com>
X-ClientProxiedBy: BE1P281CA0392.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::26) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CYYPR11MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: d451dbb8-b8b1-4395-6bca-08dbad5729ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lxaAzOqfFCB+g1a9HjhTs4/T6P0XNYBpaeCwgH7NHkc8PfF2eI1SSGVr4GjNc/cYY+Cbt6KP7Bx+06V14puQS7Dq9Vedi46Fb523HwB1DsixPB9doEz6DZDBf34fQ5/AKd9n9avd6iZQqmPvHaY7tZoXyPR397Wv126Y30EXhw9gt1HKjvVXDeGYieJWu959tKE/C5x7TgJr562sZf0ljONfuYDNOrP1jIIVkRTRhtT2gJzM6NU7MnuVDPqedGbU9tpVaCyWLAVYB0hquUDxZ2fp6UFCmAnviZdH7MaJfdyoc0hsKC8rLsZzyDtfSLd/Lc/stw/wWU1+Zxxj/WlnUzU5sQa7M70Zp6wV2AsRgzFIc/sbEQLre/Hi6Vq9jwCbb21q2IsS7v5JiOh4BEMc1DZosYSMNwqSJvZePaIyMCIq5usNdjuj4nvQOYM2w0CQo4kuzmlvrNEqzZLnXEEsa4O53LLuYUYjGcOoXqkCZOfJnNinsp0gBaXpueVCxlle+TXKIPuz8/aNLM+UPrKkiPtvxjH8LKcwxrXrATaAhuf39GZaWcxDRUYowHae7ImvxPdlJJ5OtkckF1w1CDzanpjlgrtxyTDZKHliqv1D0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199024)(186009)(1800799009)(66476007)(66556008)(2906002)(6636002)(86362001)(66946007)(316002)(54906003)(5660300002)(44832011)(8936002)(8676002)(4326008)(6862004)(41300700001)(9686003)(6512007)(83380400001)(26005)(38100700002)(7416002)(478600001)(6666004)(82960400001)(33716001)(6486002)(6506007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RM7r91oi8kmFkCuRqVeSpBfMc091tSdcRPYXnypElgNUM2yd9cYPgWfXyPpn?=
 =?us-ascii?Q?i68I6yR3Vn+7SgfSVXlrdWmBt/S3AGQCVDDfGkLtRNXW1C2OIYjcKLVXv5oU?=
 =?us-ascii?Q?jR86glq9hyzH8drjDXz/yOT3Qk1IiYh/m1z0mPz8Nxs/ypGgX5+fM5EhFZH+?=
 =?us-ascii?Q?UQK9LSHlPUj6140iQtL7eLleXgCZ5ai47qRfuWNs63DbzfJy+K3vOPvozwjc?=
 =?us-ascii?Q?YoNAe3e4PcSQ2XrRM8sYDQATPOrvbzc8sMKfpMDaIOfOEm5jU65c7leI9Y3T?=
 =?us-ascii?Q?hYT/V+YflWC9fMBQUTPjrmy7CdZD8rhKwh7+h3qxdlUKofI6SqSP0ZmYnOri?=
 =?us-ascii?Q?OjgLw3oOWuTYYc5f76TopJCBIJN36inFIpFapk9DLKLe1SaUwsP1NIJiwIHE?=
 =?us-ascii?Q?2DnXeed4rzIQnbdg8/3FrR4X+02pJBdPmkED7nFHlSgq/TZfNk17kQyjGYoU?=
 =?us-ascii?Q?U46dmJ97Y6CBC78Eb0gdZxMXLykaV9db7RnZZzDkAhEAiQZCxNxloltVAwbR?=
 =?us-ascii?Q?qIFwatuXEbT5M8yXRUN1zeuglxSQZN6z5jh1fLMEKkYdHo2XyQe5IfboT/FE?=
 =?us-ascii?Q?6K54RoPfBwu3tBM6cPd+LQyMspxsLgPW/TWx292TSl4seJ6T3liX0xWxZ/hT?=
 =?us-ascii?Q?wmddRCKfU24WwAY0mGwW8ioKZwhFxorhhDLSDHd/QEu9mvoQ+/++CYK1SuSd?=
 =?us-ascii?Q?TTpo1GGflZNusiVv3v4GPEM4rKLKpG6ub7uPEkOCja21EmHJqpN8+wyDYpgi?=
 =?us-ascii?Q?PnWfH4hzuhm2WBcC8MbYGTEBfrPRwF8INtw5+WwmY7a4PBGyyFcNkp/niAyN?=
 =?us-ascii?Q?wufwheQkNIEM5QwiocqpeFGIrNBTYZrR3S+DUyMSOlWEGAn1W/FWeloJjOfW?=
 =?us-ascii?Q?dzmicFKM1Ek3yisD7MsvPihAaK6xq1Dm/3v7Nej+0+XqDyJ5pS382wmkFmJY?=
 =?us-ascii?Q?uqPJfn/7eFwB4JAJctjBhmsa/KGlwQY+IMO4k24obiq7SFT+DV4tIP3K3ylm?=
 =?us-ascii?Q?MkH8pMIrnmmGc0pLd+cRlhgbgusg299k5a4JGNmAi3MLmp264CVEbyXXkgky?=
 =?us-ascii?Q?7Z1l4zYY0G3coXR7ZeNTg5lXXoD7AmACUVSPtXfWcbN4Ou1oRsi0Y+cQkwbG?=
 =?us-ascii?Q?YlALnIvbIZdK1IGGywIRp8KCisLSPz6ffbPHAFiMbLZJhQ992vQd4dOExahA?=
 =?us-ascii?Q?w7bQZGcsc4JtHfzfmSaQwXDRcQOLNqtZUHZDMZq+/DtP+LnFwgn4tP54qDCZ?=
 =?us-ascii?Q?n+CKm/EBjiksb8jez9Tul6zJZ72kXFbH9J7URS/5akrzZZkRy4Ry7xDHqWjO?=
 =?us-ascii?Q?6ndNb2Vu9gwNIKryrFr5hNVKy++k01iu60v+PDwcgShKUDAhZpWyHsEhY6xd?=
 =?us-ascii?Q?GVM2+O7oISr23n9SEgvCoD9wjrN5HdW4U3p1NBwAdHvv+Vdy0kwIS/CwVlwk?=
 =?us-ascii?Q?xve5jEXhPavgiehkPZcOCg+oTbCGJsyUo8Tx3uC7PE+1ZTx75EKqCd+OHvzu?=
 =?us-ascii?Q?T78dL+1h9XIvgjUjo70RE42YcBJxMbhDRgyDZ6bbT94I9pWVheycYyMzwi10?=
 =?us-ascii?Q?jMJ6kciQS6vk2P5gk3AiVvKhhIMrjemuoOILgs1igmJ7KkZ09rHiuaRT4Va9?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d451dbb8-b8b1-4395-6bca-08dbad5729ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 14:56:48.1544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9a2Wb2yAQyJuYe+BUU8GTv476TbQJNCojPFUAfzpLu7QnJ0HglVW/HrvBhH85HAd7+QNtYEuqhpDbW40e1W4UFGMl8fsq+jogK3sJ/VQ1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8386
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 09:26:41PM +0200, Larysa Zaremba wrote:
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
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c      | 24 ++++++------------
>  drivers/net/ethernet/intel/ice/ice_ptp.h      | 15 ++++++-----
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 25 ++++++++++++++++++-
>  3 files changed, 41 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 81d96a40d5a7..a31333972c68 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2147,30 +2147,24 @@ int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
>  }
>  
>  /**
> - * ice_ptp_rx_hwtstamp - Check for an Rx timestamp
> - * @rx_ring: Ring to get the VSI info
> + * ice_ptp_get_rx_hwts - Get packet Rx timestamp
>   * @rx_desc: Receive descriptor
> - * @skb: Particular skb to send timestamp with
> + * @cached_time: Cached PHC time
>   *
>   * The driver receives a notification in the receive descriptor with timestamp.
> - * The timestamp is in ns, so we must convert the result first.
>   */
> -void
> -ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
> -		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb)
> +u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
> +			u64 cached_time)
>  {
> -	struct skb_shared_hwtstamps *hwtstamps;
> -	u64 ts_ns, cached_time;
>  	u32 ts_high;
> +	u64 ts_ns;
>  
>  	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
> -		return;
> -
> -	cached_time = READ_ONCE(rx_ring->cached_phctime);
> +		return 0;
>  
>  	/* Do not report a timestamp if we don't have a cached PHC time */
>  	if (!cached_time)
> -		return;
> +		return 0;
>  
>  	/* Use ice_ptp_extend_32b_ts directly, using the ring-specific cached
>  	 * PHC value, rather than accessing the PF. This also allows us to
> @@ -2181,9 +2175,7 @@ ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
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
> index 995a57019ba7..523eefbfdf95 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> @@ -268,9 +268,8 @@ void ice_ptp_extts_event(struct ice_pf *pf);
>  s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
>  enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
>  
> -void
> -ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
> -		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb);
> +u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
> +			u64 cached_time);
>  void ice_ptp_reset(struct ice_pf *pf);
>  void ice_ptp_prepare_for_reset(struct ice_pf *pf);
>  void ice_ptp_init(struct ice_pf *pf);
> @@ -304,9 +303,13 @@ static inline bool ice_ptp_process_ts(struct ice_pf *pf)
>  {
>  	return true;
>  }
> -static inline void
> -ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
> -		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb) { }
> +
> +static inline u64
> +ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc, u64 cached_time)
> +{
> +	return 0;
> +}
> +
>  static inline void ice_ptp_reset(struct ice_pf *pf) { }
>  static inline void ice_ptp_prepare_for_reset(struct ice_pf *pf) { }
>  static inline void ice_ptp_init(struct ice_pf *pf) { }
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 8f7f6d78f7bf..b2f241b73934 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -185,6 +185,29 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
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
> +	u64 ts_ns, cached_time;
> +
> +	cached_time = READ_ONCE(rx_ring->cached_phctime);

any reason for not reading cached_phctime within ice_ptp_get_rx_hwts?

> +	ts_ns = ice_ptp_get_rx_hwts(rx_desc, cached_time);
> +
> +	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps){
> +		.hwtstamp	= ns_to_ktime(ts_ns),
> +	};
> +}
> +
>  /**
>   * ice_process_skb_fields - Populate skb header fields from Rx descriptor
>   * @rx_ring: Rx descriptor ring packet is being transacted on
> @@ -209,7 +232,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
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
> 

