Return-Path: <bpf+bounces-3960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD96746E43
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 12:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E7E1C20446
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242C05662;
	Tue,  4 Jul 2023 10:08:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2053A5;
	Tue,  4 Jul 2023 10:08:24 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5790FE9;
	Tue,  4 Jul 2023 03:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688465302; x=1720001302;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ARfz7h7CWYpuw4O/m+uipmxFRdHOX/GoAR3IkMoVUo4=;
  b=Vb6af1nd1Tbu+wXV6fL6AU6F4IfakjHX4uyoUM8Pgej0+5n6K5djVLma
   9DeZgekMpKGnbpUUvwwn31fchke0kpxUXj2THQhpUQoqP2Y6cA+vUcuR/
   IiRNrO/RYQonaw3qrIQdAqdsNcEfyc3SdY+ldnht0FbeBkv442X7lFvLH
   LvdN6DQtzspPPad04oTXSjGkiFG/JdSASSaVB+QHFUSt2LAWka4xZtvFu
   J7X7/Mi8O7zhY6Hvv8Reo1XWU2GNf/JxVYDak/RC/BJ0KEZrYk7rGMYsu
   XZj56Y1qpSVBOAjdBecLWNVHsNJHzWvK585jW7r96aD2UAiA2HQYlXw1A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="429126041"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="429126041"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 03:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="748376503"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="748376503"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 04 Jul 2023 03:08:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 03:08:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 03:08:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 03:08:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 03:08:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpmjR2hbste7IPGqfeiKWrWjrpvxJunhmbdW31pcajm1Xdgbznym3TBRc55Pc2qOcC65CjmTS2m8sXcqWdhKnklncQItbt3AJjyLVEre6hJJVBuxm6UtekgW3DI5goKB6rzig9U/ed0JwJPE+10u0UPba+qQovUx+qPaWdLPaEiCiRIxceSRaSQrb1utLDF3Ni/GY9hbZ+GCk29j4LgkRLTm+W8oIxA0YnhJyfGAvgCTrf5ZCbBYpEsq2zhYwmVlXeIV8RyHMRUIUiBVBP3TFtRhDN7blMwSjiIq/2Oc1hNw9D3mchxjM8lQ65HlXwFeKo9VRrlbU4Aj6hA7+e22GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5rXi8FCepJHP1E0nxsdAhSDJCB7zaKW9fxkWn3BiTA=;
 b=Ng0rLcQArnmnMWSEMSUMTe8HjvlcQEUV2YaAfpyU7EN0lI+X3hH6dk9j0vYjDjFYrTWnvko8E5s9pjSNg6xgmX7ry8JHreLw1KN3Kw0sNnWhyFAzQgQejjiqsDG127Zc/g/HvsRgLc0pP5mR60rYEzLZsbolHmLXU0NTk5a/e+nCTelZR29mxLEcbCDQ+pYVsA8l67BHj+/HKDX06FgNWx8PIJUy4MipWtPyBUGawl1MWr++jMtX3J4xISVNXRDcatl+3mPR7lAOvsR5f7hx9W/B5MPf6rWtasmqBV6iLMVVORW+0N+caUTuvEdhTB3r1DMpGJPEKXXIjQKIrsudsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MN2PR11MB4711.namprd11.prod.outlook.com (2603:10b6:208:24e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:08:18 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:08:17 +0000
Date: Tue, 4 Jul 2023 12:04:33 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 02/20] ice: make RX HW timestamp reading code
 more reusable
Message-ID: <ZKPusRXixdVEe1gb@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-3-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230703181226.19380-3-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR3P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::15) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MN2PR11MB4711:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e865502-8cc7-4cd2-83e5-08db7c7693ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcr3mM5OQeWWQOLG8UARzjs5olnyJV7/t21saBRSFeUz2qV8Q4RD/eyw0ZYR5Y3cv3VROq50+X8dqauC6dKv2GtqGlCt1ssnt/E1M51zPqCAGLKQrNEoLMURVSUcwCQAW92EY0sOV8RvCFMXa/Maahqkon0ibWkQQcnKkmNs+LKJBKTgZ13GbD1PwWU7tywrh4O3CKXCx20iteHa4/n0FIKVUN4PLWfGCV9AhMw432OXbu6IWqrrulIhfOKEWZOLMowiQOy3Ey0uCVp2rY6ZVIHStcTRaZchlzxJ2DWWcD57uZans8GJwSvOthlz5ezxVR4rpJR+TbS6p1sl68Gs3fRtca+U3iJThfjTZp+xcoDQv4JBqB3lo3LpBAS4GiVywm8+MJJbhaXba6+NS7739u5ZVkB9d8PdAoE+7AfRDfa7taBVjOfWfvnhusQBw5brXCRETn0nP1Wl0pFxi7R8ooE+LWlI2hN3jxnJ/e+pr4mBu8lv/eZPAK4WrS/HuhlQ8uKd4g3n9cAnD2Wzlj9Mfzf9H6itBgXfpf+VIo2tg8AYnyL4UlUfMVp6cjQXlNWn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(41300700001)(26005)(7416002)(5660300002)(478600001)(66476007)(4326008)(86362001)(6916009)(66556008)(66946007)(82960400001)(6512007)(186003)(44832011)(9686003)(6486002)(6666004)(2906002)(6506007)(33716001)(8676002)(316002)(8936002)(83380400001)(38100700002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gP8lOBqBv33zI03qGMKSAzvLztqHBYA+TakA/VfCjwjVb+9xG0tKjQdVcM5D?=
 =?us-ascii?Q?VptK5MXhU/o11pK5l3cc4CcvGIDFm408J5IPSWKIDHdhrKTJbjW4w80dJc/P?=
 =?us-ascii?Q?qQts/+9kHnihM97dTKggcju7oktbPr7t5KQP04h3L3JF5YaIr8rnDYv/wTIX?=
 =?us-ascii?Q?Q0VErgQtwpUGBYsHP7kq5bBje7HyaTlCtbSmkGQhzvWw8QwNR8vISjuoLigY?=
 =?us-ascii?Q?+tpD0FtKGUTEXs1HRmpYiP7pKCyc1xTDetPN4IeJmaIu2XSBE1eGGURoMhhY?=
 =?us-ascii?Q?bJsDdIo3vVfCmEFgYbUOHy59ki25S9YBQ3nvdHkidrYUc+A7xqRKmU9j7LsO?=
 =?us-ascii?Q?T5RdCqWPPdVxaZiZ7iDH7NwD2xrzUvRBAUALEVDrj17C39JSqoEPsGuUdkC6?=
 =?us-ascii?Q?AiKFSnFDgXll/ewGBVtHIpJ2vh5uKy6eMUH0Apv8lZEAQouITIsHkX9Jjxnx?=
 =?us-ascii?Q?nNznS83LMkeoPnL2Px37rQdktHjaixrMvU6Gv/PQjPcycT4gm8s2HAxtF+2r?=
 =?us-ascii?Q?+Vx1QMK4Z3iuhMgEmqzIQfpbckhO/zEIZIq1D6kQDoxXjG/SpjGcJO7HZTHm?=
 =?us-ascii?Q?jhJHKIH2E0HHCS4LkB4+Yt0wNBlgdWM7QoALD7AUIE/6irRKOU6MHsFLufWB?=
 =?us-ascii?Q?FuWr8FOYGvP8EYnyiZwL7D3WpV1qUb+0M2Odrft4g4l0fPWACv+3isp98dZ5?=
 =?us-ascii?Q?OXva3jUUKgu99T4VF7/eFL5BJ3FWTC6MPI7hZJscttuUIn5lSTQ2+je0BzQN?=
 =?us-ascii?Q?k0XLR6sZuw2ggtCpRw8dR3LVzP1SZQgxfuC2c/xxnRy7lQJwoY4LRicWA9Hr?=
 =?us-ascii?Q?Wbn7yFw+QNf2vvgFmeJ3nbuz+WeATPFZze/SDlIz63+OjZxI8SmBnvCgKKQZ?=
 =?us-ascii?Q?E5qVMmYnYusNP3JlBOCN5xwM6ORip8J5wbFvPF4/CE0w02ZX9RjjyVGgYgBl?=
 =?us-ascii?Q?EL95Q6XLjaJ1wKbxGK/9j/EmlmNxecH8N+WnxbnZwFPAT2nhvlplyLp7G2C3?=
 =?us-ascii?Q?ceGxZ8nuctrYswbYyZNG9eBeyXBtDDMfl/yxHbWpxOALJTpZ7kpcFvbGGpfP?=
 =?us-ascii?Q?h3HYK99Eijb7ikBwFvAUaPSjTtYZ273n5RuS3o0N4NYLP/RyzY8QWd0EUxDb?=
 =?us-ascii?Q?WBXr5zS9JYkH3CQ2eTEbgeMb3oH61dj+ogqD8Yupt4kuzwAlW5SHF5IoNExo?=
 =?us-ascii?Q?E7BwHn6iYeDENd68aZdoHVcVDZj/cODHXRtCDFDvZnEuU8b1ePLWUyDrXAuv?=
 =?us-ascii?Q?R/OkX9dncazRygy7pjS2VL+gyfdAyqMzQh4Dab204uwO44w9P3xHUZfTxEhw?=
 =?us-ascii?Q?PzxuUKhPLbhIEaUk1Ngcsn5IkUKhZjtRs/68/+uytTF67dHNC7ojtOFzOp4m?=
 =?us-ascii?Q?JDFINQZU4QfpXtXejSMGGtLA5+wsgMjdfRWP+hJW+KYk6r7D4pi0znCRRPGf?=
 =?us-ascii?Q?J9LcyoWWbB+1yc/WYwQkbTJhjCZlvzcbObMtDAnNe1NofmfFLk6v0pgQ+6u9?=
 =?us-ascii?Q?0G9k6RvC1jdMtueZLLklGblMS+zkH34mQEzKSpgt2wNOofD+KX9+S8nPIAgb?=
 =?us-ascii?Q?EoD64KLPYTwH7ZyKMoRBsEbhxYqIQWdTMH1R8bPfRn7pIe/RxWS83KzkxfFR?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e865502-8cc7-4cd2-83e5-08db7c7693ba
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:08:13.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uoIxGnM+wtCt68zy2TB/hDkquM+cRb37+P6UjN1ULay5kn97DZf3C4jHNbf+8qGER7K1iQEYgM+duDFRKJ1LpMqrDvSIxsreha6VnqlA2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4711
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 08:12:08PM +0200, Larysa Zaremba wrote:
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
> index 8f7f6d78f7bf..d4d27057d17b 100644
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
> +	cached_time = READ_ONCE(rx_ring->pkt_ctx.cached_phctime);

CI has pointed out this line is messed up and this is correct, a mistake while 
separating patches, should be 'READ_ONCE(rx_ring->cached_phctime)' in this 
patch, will fix in v3.

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

