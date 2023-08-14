Return-Path: <bpf+bounces-7702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3E177B739
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 13:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2988C28111F
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 11:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA9BA32;
	Mon, 14 Aug 2023 11:01:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39438F77;
	Mon, 14 Aug 2023 11:01:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE875F4;
	Mon, 14 Aug 2023 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692010897; x=1723546897;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2QbLcDXu7K+WByEczd1naBvnwSK36sDb/lI4iLNmGs0=;
  b=SWRbD1EnXT6fVfEnheOkMlexCuN9Wp22DIJ039S5dJ1JyHkGtJCqHeA5
   bYuDEGAOykSwbG7au5VhPxLMLOI0T6apcsF+/IfxARDdfxjNi0jueCqFh
   dlAPX09cWzMYrkr8rro4keoL+YM4oLoQy8VjiwUKxedpNdoHQ+8zXWCPl
   AbiZ1QMnhq4LOAH4Z9/rSMw+IZWDF2jWSkv5lZPrTm6In44h1rcdmVvpY
   OEY9LUv93nrv6XKCIe8I8biI318yr4rCqxn+Hep3w2hFaGw+8kdcqrSyf
   huX2E4WTlBA4TjrP399U4uQnJfjRIRqjULFjFED2J0LUT+iOftRjq/7jV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="362164791"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="362164791"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 04:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="798784871"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="798784871"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2023 04:01:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 04:01:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 04:01:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 04:01:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 04:01:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f76+Grtszl4gVn2291nZcU826aIP1kWqBn0Q8uL8JusIY8oxpg8T1QxBbnh2nne5MIMn/h4bhzyrtGbzsf9VbqrlVXenUqleuI31eE0WkUJHixnwwNa/gTN3RudYl9um0gCL7i5ICIydEBgqjkgi381lB55vNAIkO1wG9TucmxhVfX07B8qrIwWfNPMxwVmLhxJ9aPq2ky3Cmgp20/ioIgOre5b0sfKso6nBMqU7tjy2lXZYyiUx0SSN4F26aEBakRpZpGF7dtirEj+6DvSFsmZDWvHDzZ1uSJA+lUKjvT4SUQhm3BNJTvNYGU+hAO8Zgtr/OF1zYfvgV+kY1tY4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpBywxaDbdyX3iOX7cID2MiijnMvKjicAzTDlaNaWIQ=;
 b=L4fE5Yqyhg2Zgb8E8k5OFcKdG5x5Vpp2/+LKd34vToqYgl3dcE7xAoNb3/AvtemnEK6b90k6L05XC4AxDlp68WTYN0tcGnqpsLRbtke6AQV2smrGhJfKqKUXfHtQ4v9ymN4rn3f7ktLCWTPRHsjqGAkuSYG3jIuUothZphZekPX/RItWIaO2dM5QvZJCjH9Vg+Zh57Y3lELDOztwq0yrE2X7reb2EDnKZsqQLyAkhPatzKgJZ44Hs2ORSJ7gC+wsK7dYFYnzxQb5Y2uBGnvH1+FtIgkWLgr+f/K2mWg3zgYwIvW1qfH/Wh1ciIMlgRDL8BdRYkv475nuZdFgIpdIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY5PR11MB6319.namprd11.prod.outlook.com (2603:10b6:930:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.24; Mon, 14 Aug 2023 11:01:24 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 11:01:24 +0000
Date: Mon, 14 Aug 2023 13:01:14 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, <kuba@kernel.org>, <toke@kernel.org>,
	<willemb@google.com>, <dsahern@kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <hawk@kernel.org>, <netdev@vger.kernel.org>,
	<xdp-hints@xdp-project.net>
Subject: Re: [PATCH bpf-next 2/9] xsk: add TX timestamp and TX checksum
 offload support
Message-ID: <ZNoJenzKXW5QSR3E@boxer>
References: <20230809165418.2831456-1-sdf@google.com>
 <20230809165418.2831456-3-sdf@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809165418.2831456-3-sdf@google.com>
X-ClientProxiedBy: FR0P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY5PR11MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b38f61b-8da6-46d3-b7a5-08db9cb5ccd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NG65PIzfr1F+iTEFp5+NIIVPCp5P6TmJMn2VhcJjk0ajecGaJWZGw5rLOx9yi2GF3V4BQhFC640qoWF4odkpGbmTIE0sG/+NOPJl3p4pW4IYsdg4rQqnJ7HywjK0GKtibPzAOH4gHfw6Exs23H1yM1vxqtDDszvnnRWUojDm3wJI6CaBfP82NW/ZDTkKrTe/T4slSDGuRTA00FZ/LUzT4PbC4yDRWcfTF72L0RLe99++WOeyrQbHRrxVR1SceRzNE3IYb8F704n+avI04CQ2K8qwG2zGxzXA1pWP5tOoHDWSfxczHOO0k1k81uxtH7osO7uhp9rg6VNn2/xHwWqqgquxGy3TKvgfF/rNYaLiBKZydQKwRh59aKSKG+cFWDRAu9EmF/scWwd49zZRi1sK1tfiub8C27CZMpep6kl1HAnwQXApljkKfkB9JPkTX/3+PbSAW86qz9QeKMKC8hGPiUNrLZrgwfLf7D2vm8aSJ/XfmZro4DtpkfMTPIxc7Px3Yv6PrdYmmLL7BrmC2QNoTDIbB//YKlSXITl5mYe+jF6k9LJMmV/biW8XJcujU9i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(376002)(396003)(366004)(136003)(1800799006)(186006)(451199021)(26005)(6506007)(41300700001)(8936002)(66476007)(66556008)(66946007)(316002)(8676002)(9686003)(6512007)(83380400001)(6666004)(6486002)(478600001)(38100700002)(44832011)(33716001)(86362001)(6916009)(4326008)(82960400001)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cijIZ5OPdyuTcjgu9KLs/4TODovpujkPEoZ9bCK5I+/kZqtAC7WdqYrSitAj?=
 =?us-ascii?Q?FNUYqVTntfQ0x2iR3MTiboi3p+gmvcYSd+794gMdqTA4fAYIz3Gp/BcKYGuH?=
 =?us-ascii?Q?/sI2KmaEg01H2GJUN3l4GypTzO4rrrxq2/hTTjn/xu1vw3rMhghnCKEOexpF?=
 =?us-ascii?Q?gOSYmngRaYMR0eEd9e3GE0cddJpxVnzUF1IZA8N4lrG7D8FpgT9WdbTDq4np?=
 =?us-ascii?Q?2Ec+BnH8ra09o1+oNxMscHd6DJ+dzNspMxPnX2porp9knTI+RJT7hX7JRY6p?=
 =?us-ascii?Q?lQFDXcKDQgNni0FXpBeTVgds9QQmkhOLPKG7s4nwx6q3SglkHRtiw6YKvvv9?=
 =?us-ascii?Q?ijN0fvfrpIs76FBWZGQsXFK4eyaJAPH0oXK6rWZhAePHn9Beio/79/xXDyB8?=
 =?us-ascii?Q?yxjOyaDo6SprRWb58vvGa4Ny4wQsxch/BioEzuB8fZaOUhFb3/ExjdsDaQ70?=
 =?us-ascii?Q?OESUrRDQJQ5jyJ/JHueBsxWB6Yyj8NG6LLsBRIJ7D3/1MPcanNNWX0BZxJGZ?=
 =?us-ascii?Q?9q0nmR0CdP8UopZmDkZlvxLLaWHDlE3YA7rwGWyEPnr+EPr3EgKoDTONXhlq?=
 =?us-ascii?Q?kN7lXQaqdRJfPOfkY1VOgG4vLRA37KycMEY3PtICn2Pufm7PBSMGJ9F2qGbS?=
 =?us-ascii?Q?gx0Ei/Lku3vwzImYjUJXMerhsBH2YOqudokat82hoBVIBX9QPJbGLPqec0RI?=
 =?us-ascii?Q?TrAiTTW7B5eXMGiIHA8Fg/0WqMPXyGtYamP4CQHE006zeM14L/RyYddEN+RG?=
 =?us-ascii?Q?UCs/j2jb64Rfoup483FJ/eDVHYsbOlHB1oCHjVNh+BLpdpC6tNR6BiSVrUI2?=
 =?us-ascii?Q?CQyvl5M3BI2ULUDcNXpaYyVFzV+fOI/iJbvG72Em6HTfhdUWnegTG8Vf3VpM?=
 =?us-ascii?Q?cXAeu5ouEhqKnD6HNWekMM1jWhNpEaQP9O0OgGCEWXo7eTU0Pkhk8Hd0vlIC?=
 =?us-ascii?Q?3zxKt3iV4fRZW2S2t/cKBD8V6J+7jgZ8CyLDcGWkupkOrjxNHYOkHFEvarIQ?=
 =?us-ascii?Q?NfEPM1aMO8akESREyCj8oB7pzG0Aa75SSzWlNZnXaVF0bMIcl9s6JSndVMf0?=
 =?us-ascii?Q?T9PYdYuPHZVRcT9GSJ93buJtm41n08V2JGIEMBeeb5vrJSEx9DclK/tyJUUi?=
 =?us-ascii?Q?qynpr/Y9c3nnyARTab9joiE+eF67Pp/AMMgKDjjCgV5Z/4gYGELPHXWzZM0k?=
 =?us-ascii?Q?6zUXjfGdjh3OYq1SKbQ0J9kjTeZ8Ftw25MdBLsEpGsk7qzkd8IpJxKek+FWx?=
 =?us-ascii?Q?2PX9bHd269DGPNk9Y2CxiVFVJUj2e7F9fEUm6/g7WdGehSDiEvrLxOdmpIkv?=
 =?us-ascii?Q?Jch+NZy90NGdZ3Lh1GIKUK3GKoMr6KpaOEET/GpIXWmw886fS/gtFoMTv7i6?=
 =?us-ascii?Q?5RXC1evZHG4kE1qIjVhZoH4Ks/Xk42Mf5Q8QkGhT76DjEUachRWOenFnpZjx?=
 =?us-ascii?Q?qbcmg2k6/ibLQtW+BMMF6woP6E/BHXb9V81C350ZM5BZTywZRNzoEF4zM5fY?=
 =?us-ascii?Q?kKl9hISagitLEbrLJpYhJ7AbK4vBdpa3kH8JipE8BScpICFM8rZe6cwSfYfn?=
 =?us-ascii?Q?6WKTx0sfGquCj/+a3rxgp1QcO4gDmf95hfgdwM2+cagS9JHT6xfmswko4Qau?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b38f61b-8da6-46d3-b7a5-08db9cb5ccd1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 11:01:24.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7dkJ697sLDXn26MM4ngszRsr0kAHic7vhMI0zSeYO1kdRk0ecd9Y1rIrnTUm64XaXaHK0PkF/UoDi13ci2G+pHLbrZ+85TuRM77neGVMmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6319
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 09:54:11AM -0700, Stanislav Fomichev wrote:
> This change actually defines the (initial) metadata layout
> that should be used by AF_XDP userspace (xsk_tx_metadata).
> The first field is flags which requests appropriate offloads,
> followed by the offload-specific fields. The supported per-device
> offloads are exported via netlink (new xsk-flags).
> 
> The offloads themselves are still implemented in a bit of a
> framework-y fashion that's left from my initial kfunc attempt.
> I'm introducing new xsk_tx_metadata_ops which drivers are
> supposed to implement. The drivers are also supposed
> to call xsk_tx_metadata_request/xsk_tx_metadata_complete in
> the right places. Since xsk_tx_metadata_{request,_complete}
> are static inline, we don't incur any extra overhead doing
> indirect calls.
> 
> The benefit of this scheme is as follows:
> - keeps all metadata layout parsing away from driver code
> - makes it easy to grep and see which drivers implement what
> - don't need any extra flags to maintain to keep track of what
>   offloads are implemented; if the callback is implemented - the offload
>   is supported (used by netlink reporting code)
> 
> Two offloads are defined right now:
> 1. XDP_TX_METADATA_CHECKSUM: skb-style csum_start+csum_offset
> 2. XDP_TX_METADATA_TIMESTAMP: writes TX timestamp back into metadata
>    area upon completion (tx_timestamp field)
> 
> The offloads are also implemented for copy mode:
> 1. Extra XDP_TX_METADATA_CHECKSUM_SW to trigger skb_checksum_help; this
>    might be useful as a reference implementation and for testing
> 2. XDP_TX_METADATA_TIMESTAMP writes SW timestamp from the skb
>    destructor (note I'm reusing hwtstamps to pass metadata pointer)
> 
> The struct is forward-compatible and can be extended in the future
> by appending more fields.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 20 +++++++++
>  include/linux/netdevice.h               | 27 +++++++++++
>  include/linux/skbuff.h                  |  5 ++-
>  include/net/xdp_sock.h                  | 60 +++++++++++++++++++++++++
>  include/net/xdp_sock_drv.h              | 13 ++++++
>  include/net/xsk_buff_pool.h             |  5 +++
>  include/uapi/linux/if_xdp.h             | 35 +++++++++++++++
>  include/uapi/linux/netdev.h             | 16 +++++++
>  net/core/netdev-genl.c                  | 12 ++++-
>  net/xdp/xsk.c                           | 41 +++++++++++++++++
>  net/xdp/xsk_queue.h                     |  2 +-
>  tools/include/uapi/linux/if_xdp.h       | 50 ++++++++++++++++++---
>  tools/include/uapi/linux/netdev.h       | 15 +++++++
>  13 files changed, 293 insertions(+), 8 deletions(-)
> 

[...]

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0896aaa91dd7..3f02aaa30590 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1647,6 +1647,31 @@ struct net_device_ops {
>  						    struct netlink_ext_ack *extack);
>  };
>  
> +/*
> + * This structure defines the AF_XDP TX metadata hooks for network devices.
> + * The following hooks can be defined; unless noted otherwise, they are
> + * optional and can be filled with a null pointer.
> + *
> + * int (*tmo_request_timestamp)(void *priv)
> + *     This function is called when AF_XDP frame requested egress timestamp.
> + *
> + * int (*tmo_fill_timestamp)(void *priv)
> + *     This function is called when AF_XDP frame, that had requested
> + *     egress timestamp, received a completion. The hook needs to return
> + *     the actual HW timestamp.
> + *
> + * int (*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv)
> + *     This function is called when AF_XDP frame requested HW checksum
> + *     offload. csum_start indicates position where checksumming should start.
> + *     csum_offset indicates position where checksum should be stored.
> + *
> + */
> +struct xsk_tx_metadata_ops {
> +	void	(*tmo_request_timestamp)(void *priv);
> +	u64	(*tmo_fill_timestamp)(void *priv);
> +	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
> +};
> +
>  /**
>   * enum netdev_priv_flags - &struct net_device priv_flags
>   *
> @@ -1835,6 +1860,7 @@ enum netdev_ml_priv_type {
>   *	@netdev_ops:	Includes several pointers to callbacks,
>   *			if one wants to override the ndo_*() functions
>   *	@xdp_metadata_ops:	Includes pointers to XDP metadata callbacks.
> + *	@xsk_tx_metadata_ops:	Includes pointers to AF_XDP TX metadata callbacks.
>   *	@ethtool_ops:	Management operations
>   *	@l3mdev_ops:	Layer 3 master device operations
>   *	@ndisc_ops:	Includes callbacks for different IPv6 neighbour
> @@ -2091,6 +2117,7 @@ struct net_device {
>  	unsigned long long	priv_flags;
>  	const struct net_device_ops *netdev_ops;
>  	const struct xdp_metadata_ops *xdp_metadata_ops;
> +	const struct xsk_tx_metadata_ops *xsk_tx_metadata_ops;
>  	int			ifindex;
>  	unsigned short		gflags;
>  	unsigned short		hard_header_len;
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 16a49ba534e4..5d73d5df67fb 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -579,7 +579,10 @@ struct skb_shared_info {
>  	/* Warning: this field is not always filled in (UFO)! */
>  	unsigned short	gso_segs;
>  	struct sk_buff	*frag_list;
> -	struct skb_shared_hwtstamps hwtstamps;
> +	union {
> +		struct skb_shared_hwtstamps hwtstamps;
> +		struct xsk_tx_metadata *xsk_meta;
> +	};
>  	unsigned int	gso_type;
>  	u32		tskey;
>  
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 467b9fb56827..288fa58c4665 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -90,6 +90,54 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
>  int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
>  void __xsk_map_flush(void);
>  
> +/**
> + *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
> + *  and call appropriate xsk_tx_metadata_ops operation.
> + *  @meta: pointer to AF_XDP metadata area
> + *  @ops: pointer to struct xsk_tx_metadata_ops
> + *  @priv: pointer to driver-private aread
> + *
> + *  This function should be called by the networking device when
> + *  it prepares AF_XDP egress packet.
> + */
> +static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
> +					   const struct xsk_tx_metadata_ops *ops,
> +					   void *priv)
> +{
> +	if (!meta)
> +		return;
> +
> +	if (ops->tmo_request_timestamp)
> +		if (meta->flags & XDP_TX_METADATA_TIMESTAMP)

We should have a copy of flags or any other things that we read multiple
times from metadata in order to avoid potential attacks from user space.
An example of that is the fact that timestamp metadata handling is two
step process, meaning to fill the timestamp you have to request it in the
first place. If user space would set XDP_TX_METADATA_TIMESTAMP after
sending but before completing we would crash the kernel potentially.

We could also move the responsibility of handling that issue to driver
programmers but IMHO that would be harder to implement, hence we think
handling it in core would be better.


> +			ops->tmo_request_timestamp(priv);
> +
> +	if (ops->tmo_request_checksum)
> +		if (meta->flags & XDP_TX_METADATA_CHECKSUM)
> +			ops->tmo_request_checksum(meta->csum_start, meta->csum_offset, priv);
> +}
> +
> +/**
> + *  xsk_tx_metadata_complete - Evaluate AF_XDP TX metadata at completion
> + *  and call appropriate xsk_tx_metadata_ops operation.
> + *  @meta: pointer to AF_XDP metadata area
> + *  @ops: pointer to struct xsk_tx_metadata_ops
> + *  @priv: pointer to driver-private aread
> + *
> + *  This function should be called by the networking device upon
> + *  AF_XDP egress completion.
> + */
> +static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata *meta,
> +					    const struct xsk_tx_metadata_ops *ops,
> +					    void *priv)
> +{
> +	if (!meta)
> +		return;
> +
> +	if (ops->tmo_fill_timestamp)
> +		if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
> +			meta->tx_timestamp = ops->tmo_fill_timestamp(priv);
> +}
> +
>  #else
>  
>  static inline int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
> @@ -106,6 +154,18 @@ static inline void __xsk_map_flush(void)
>  {
>  }
>  
> +static inline void xsk_tx_metadata_request(struct xsk_tx_metadata *meta,
> +					   const struct xsk_tx_metadata_ops *ops,
> +					   void *priv)
> +{
> +}
> +
> +static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata *meta,
> +					    const struct xsk_tx_metadata_ops *ops,
> +					    void *priv)
> +{
> +}
> +
>  #endif /* CONFIG_XDP_SOCKETS */
>  
>  #endif /* _LINUX_XDP_SOCK_H */

[...]

