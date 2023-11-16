Return-Path: <bpf+bounces-15196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCF87EE419
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4C21F24DC6
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C666358B5;
	Thu, 16 Nov 2023 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WW50UbWC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CBE1AD;
	Thu, 16 Nov 2023 07:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700148086; x=1731684086;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zFk+F/T2I7NhpyUVICWjBYM11j9EYhq0X3tgetM31q0=;
  b=WW50UbWCObHsPfwvFAPsCUfeKDereeQWoL8Nce9uSfx3TM/9HQzbdy4M
   qzqH80L1ymgTUW55EYb17GGWjVLE8qI7TzB6Z8yA8SEefcqcmAthzVDDT
   N1jqCUdK4GdAOSjIQuFFxw3n+22EwrU3aWAOekBvpdepNzrqpjIdD3kL4
   tAjzqX/6YTx3Ojfb4iCVgfw8JmbQCJ/6Cu3zVYyyPV+W1qO0/U+iM42Vw
   PlL//Oum4yWZ4YmSs7xmPCMvyrMvseP8DGk6obYW8KBzibawZSnmWM34M
   1F5P59IcqLB2NLq7M1vmV2Fz/TBZgfGaYB4LCnfSB51QEJpkR2bFbB9Uo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="422199665"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="422199665"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 07:21:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="856037806"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="856037806"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 07:21:26 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 07:21:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 07:21:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 07:21:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 07:21:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkOpor61Gs8sTkwF9UMyc6awIDenyqtGYuJFBJttjnjmwKNJBy2V+Dd/EWDe/yjfjaxkvGrlhUTziqx+4/C1eQowRoTUKaqT6PqpvnKE6JmSYP/F3bG6fQ/W4r+KGlyAhm/lrBmE7zl3hiuaJS0u9c4rr3RcHNLajSC3/MU4xhUWM5g6Ir+6Ejc+oO7YzT4MnwwLai2yU79K08534PJjlWHPyZoEcfZp+RPurUgATuGV3vkPXC01uL8nUvoCpqXx10Kynvn8g6bWa4PfCS86zFIifM1NihsaPy5EineChnxrXt4K9cR6rzL0OUXhQG+jzn9ud8u6WCJU2/wxMkCWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRnsWvmuKi0q34qzWBOsD8t+nVQfWJnzar4P7oo/21o=;
 b=brpwaazD18DVuiOH0J2H1xn44oCDRmSnhDkRea5SwLR9P519va/AP54Wo3AYdLUToSLd1PR5cTmTOxALSa/8xuvC/el4NAAuCgoj2FaBBHnW4CTDV+lubhndeLeBVCOR+xprzILFYKBs7toNk50lQA6T1oFL3oWYrL38VHvE/xExt9mR/FgDCrErhJ/PnVmVRxY3qqkry2DM1ic775+XDh0o0gatyoEEp0ZZQijyShSV0lUjPnHcsKYMhcmdceC8zllaHOQAROOTtn4vak9dEdCi4AIb3WGm62uZCPTO+Z1djQJ5NBzSMsgiFh8P0tz+vmrh21LeLSDbz4ved+Y3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.18; Thu, 16 Nov 2023 15:21:21 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 15:21:21 +0000
Date: Thu, 16 Nov 2023 16:21:14 +0100
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
Subject: Re: [PATCH bpf-next v7 05/18] ice: Support HW timestamp hint
Message-ID: <ZVYzasQqh18fo8Kr@boxer>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-6-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231115175301.534113-6-larysa.zaremba@intel.com>
X-ClientProxiedBy: DB8P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::31) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 9310a308-f353-40b0-628e-08dbe6b7b048
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2GCy1oLohWmRnkkWPnUPQetTItJyfrFwjX7UhepV6YCmkiM8fEZ8w2CgGT7nID5AIBqZDTCh89KpDCtyYrKT1PZ3TxmLdhiWVPhEp494rzKjUYXNuz/pg1i3DqRrMD8ySXGloWqwp+ip5GzTniRIPEB9y8VHf1+1LBYvwx0t7carO9nJP/5t41No8f/StrxULOPxopJl+n5X6zhOkppCBqUtmRbqJoG79IgMJjRLi96hW/ULsWOI/GN0DslKsQllioLopWnqskJCnSC9X3ZZgf+9+VYkNGzKyu67a+31x6HWltAcRCZpqO/ovmN5bPI2OKkh+KbNWB7/ybLb124MCk6b2kBCLk41ddovBuRziH3WoAw2RSGnEmJzWaPGXib5N/W3H5fciWfTqqOmT3ZNtR/Pv25qZw6t86B1CEcZfip3icLsoMxTA5a4zurv00lWIu4aae/ThgxRZ3WIglzMENMTb1ik8IYP+QPm8H5805oGH4+pbte3iM0FDa5an8339PpdrlpjD2snSPiypsVE9jgCHoAyP8/VG4vU5upilnDgNN1lqABJW+PDpm2Lw2Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(8676002)(2906002)(8936002)(4326008)(6862004)(6506007)(26005)(83380400001)(41300700001)(82960400001)(9686003)(38100700002)(6512007)(6486002)(6666004)(66476007)(66556008)(66946007)(6636002)(54906003)(316002)(86362001)(7416002)(5660300002)(33716001)(478600001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fDwEf8cl6v/ce+wT4WLOjtH8066UqsNhFxBwO124inC9bBugL3i6uzjRwh/p?=
 =?us-ascii?Q?nFvAA5hW62D9f9DuK8MD7/u9XShwE0H1Pqv7rMHuE+BokjSX6HQUk3fZFkh/?=
 =?us-ascii?Q?7uVtMJBl6o24GsP6O6yHMptYdY4lyIDgtTdIQlTKOktKQJEBY0Oz5mbHmKh4?=
 =?us-ascii?Q?vtA0Y5LSekBBTOkbcwqfcz00NDFHi7ciSkV2auntPyBuJdI9ZPb4wCpL9Leh?=
 =?us-ascii?Q?x+rr3YhWdPaAVA6iUYYOaa8dznqzkhO7jYbuZ4Ab3qI4OZVSesEp2vmLogvt?=
 =?us-ascii?Q?kJqZAC17LpNy3MxyR5p6j30iRJqlk1wvvO3ak43keENk5AVXKH8GbuDd7QRB?=
 =?us-ascii?Q?E4a9JnG+qkXsYszBbd+CRVwda8+l/KAA26nUD8rX63k+6T6TIeCFM+Znp/M6?=
 =?us-ascii?Q?NbMxatimx9kUdOYVlueEwldhnH28Svz9D4HMByeG4L2gfPbEnr2BEtSox2MR?=
 =?us-ascii?Q?AR9ylrbXaUxtQZDRYMcgoHlpN47yLdWEMMUhbB/gmE5dnmvp3MBzOxLhUOTl?=
 =?us-ascii?Q?maGn13BbSvPSMryLieaKadJ7mMy0Lhww1/NsesUWJgrzcUDhSJQJl1OzgLgH?=
 =?us-ascii?Q?u+sUCQtvws0HKA5VC9JuRi7vRprnGm3OaovjPFSVL60iPQUJrxOkd9iDFo2w?=
 =?us-ascii?Q?lCLZ11kOTXLoYWT9OoG5Kn7FQteK3PQkRce1IMFUuNZQBHgJKILVEWIg597U?=
 =?us-ascii?Q?I0iSfDWiDKH1MuWnv8WgCAFyiyggNJCPY0YUKbXQqdbvLRLpj1Pfa5Nu1/k9?=
 =?us-ascii?Q?6/SVmOQBrts8cyi8d3PbA79FHyrOyzCVMEu7zH6QvGRiw6hbALUyXrPE82hG?=
 =?us-ascii?Q?ZCOJzwEO03YXJFomkLerA7gaPuQBzF/9e3n7MebTM7oOlqRQjIsXxJuXrnew?=
 =?us-ascii?Q?Ee7kM5OeGqJXF/wo8HR937xUg0g0jW9CPFTUc1z+mLMuajQKey3yQgWSJDX3?=
 =?us-ascii?Q?yDCaRjUYou828SBD2U/XTD7N91eVi7NLXgjXHYdhOnNMTiF7UGLuiPOZV6y/?=
 =?us-ascii?Q?n4HaS1ujfpQOzftZJoh2ylYcsaNY+r58RE8TzAxo3Pt+3lw+nSRFeN4B28VV?=
 =?us-ascii?Q?K74WIElP9HqXrlpd7KyHZ58nb1n8mijh6u4d6EQKDlXmepkZG3LmiSVB+Bt8?=
 =?us-ascii?Q?bhBxIqfb+lviFjni5HQcIUn+tzcEexlCbN2D/XxW/Uwo8OKkFfJPhv6TzwGa?=
 =?us-ascii?Q?26svOa+uFwVAw3nEuFs5ZjYc8uWLHoivkVKkwHdwnS/XLJYhPj1q5+tSrHv6?=
 =?us-ascii?Q?R2/JDshGuEX6OGtkyhqbkhyN0p+3OC0fCauI1H6gDbU12SnlF+HEDlP0FLwY?=
 =?us-ascii?Q?BIoDEiOSwhh3wVa2rQ+KOvsK0tiHGFldoaUhFuvE36e8omwdnYB4DTWe1NT+?=
 =?us-ascii?Q?hUQHqaUVQzRhrGFmNUHEgFR5jaqYSz58kMT8CEugKwc2GcbEhHwSsehWJqw8?=
 =?us-ascii?Q?FgXZ59Brxeya1ZHTjEx9w1+6ZauC3tigoai4ObV1zkbjkaLeKZ+VHnYAH/Mz?=
 =?us-ascii?Q?XAI8RB08t1yrbHekUst159vtXu8ZHIN6ZBQNnHVH++5nY2doI9kxtNX5tSf+?=
 =?us-ascii?Q?2z/4RdiRkJRG/JEYYXWKNijrKCZmjYBxsxT4UECHCz7CfxH2+yf7BuotkOBc?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9310a308-f353-40b0-628e-08dbe6b7b048
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 15:21:21.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2uReNKF6TCX7PEDrzJ2VN9gGE4vIFTMN1bIDiHIH8fRY0WM520IFJmxeyoGfZ+85No0TkSWk/35vb7ZlG1W8MdfuX2YMGTw+5HxFLbx/98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6238
X-OriginatorOrg: intel.com

On Wed, Nov 15, 2023 at 06:52:47PM +0100, Larysa Zaremba wrote:
> Use previously refactored code and create a function
> that allows XDP code to read HW timestamp.
> 
> Also, introduce packet context, where hints-related data will be stored.
> ice_xdp_buff contains only a pointer to this structure, to avoid copying it
> in ZC mode later in the series.
> 
> HW timestamp is the first supported hint in the driver,
> so also add xdp_metadata_ops.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  2 ++
>  drivers/net/ethernet/intel/ice/ice_base.c     |  1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  1 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c      |  6 ++---
>  drivers/net/ethernet/intel/ice/ice_ptp.h      |  4 +--
>  drivers/net/ethernet/intel/ice/ice_txrx.h     | 10 +++++++-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 25 ++++++++++++++++++-
>  7 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 351e0d36df44..366c82a87e56 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -989,4 +989,6 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
>  	set_bit(ICE_FLAG_UNPLUG_AUX_DEV, pf->flags);
>  	clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
>  }
> +
> +extern const struct xdp_metadata_ops ice_xdp_md_ops;
>  #endif /* _ICE_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index 7fa43827a3f0..2d83f3c029e7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -575,6 +575,7 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>  
>  	xdp_init_buff(&ring->xdp, ice_rx_pg_size(ring) / 2, &ring->xdp_rxq);
>  	ring->xdp.data = NULL;
> +	ring->xdp_ext.pkt_ctx = &ring->pkt_ctx;
>  	err = ice_setup_rx_ctx(ring);
>  	if (err) {
>  		dev_err(dev, "ice_setup_rx_ctx failed for RxQ %d, err %d\n",
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 6607fa6fe556..cfb6beadcc60 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3397,6 +3397,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
>  
>  	netdev->netdev_ops = &ice_netdev_ops;
>  	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
> +	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
>  	ice_set_ethtool_ops(netdev);
>  
>  	if (vsi->type != ICE_VSI_PF)
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index a435f89b262f..667264c8dc8b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2105,12 +2105,12 @@ int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
>  /**
>   * ice_ptp_get_rx_hwts - Get packet Rx timestamp in ns
>   * @rx_desc: Receive descriptor
> - * @rx_ring: Ring to get the cached time
> + * @pkt_ctx: Packet context to get the cached time
>   *
>   * The driver receives a notification in the receive descriptor with timestamp.
>   */
>  u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
> -			struct ice_rx_ring *rx_ring)
> +			const struct ice_pkt_ctx *pkt_ctx)
>  {
>  	u64 ts_ns, cached_time;
>  	u32 ts_high;
> @@ -2118,7 +2118,7 @@ u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
>  	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
>  		return 0;
>  
> -	cached_time = READ_ONCE(rx_ring->cached_phctime);
> +	cached_time = READ_ONCE(pkt_ctx->cached_phctime);
>  
>  	/* Do not report a timestamp if we don't have a cached PHC time */
>  	if (!cached_time)
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
> index 0274da964fe3..30b382ed204d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> @@ -299,7 +299,7 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
>  enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
>  
>  u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
> -			struct ice_rx_ring *rx_ring);
> +			const struct ice_pkt_ctx *pkt_ctx);
>  void ice_ptp_reset(struct ice_pf *pf);
>  void ice_ptp_prepare_for_reset(struct ice_pf *pf);
>  void ice_ptp_init(struct ice_pf *pf);
> @@ -332,7 +332,7 @@ static inline bool ice_ptp_process_ts(struct ice_pf *pf)
>  
>  static inline u64
>  ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
> -		    struct ice_rx_ring *rx_ring)
> +		    const struct ice_pkt_ctx *pkt_ctx)
>  {
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index 9efb42f99415..3d77c058c6de 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -257,9 +257,14 @@ enum ice_rx_dtype {
>  	ICE_RX_DTYPE_SPLIT_ALWAYS	= 2,
>  };
>  
> +struct ice_pkt_ctx {
> +	u64 cached_phctime;
> +};
> +
>  struct ice_xdp_buff {
>  	struct xdp_buff xdp_buff;
>  	const union ice_32b_rx_flex_desc *eop_desc;
> +	const struct ice_pkt_ctx *pkt_ctx;
>  };
>  
>  /* Required for compatibility with xdp_buffs from xsk_pool */
> @@ -328,6 +333,10 @@ struct ice_rx_ring {
>  		struct xdp_buff xdp;
>  	};
>  	/* CL3 - 3rd cacheline starts here */
> +	union {
> +		struct ice_pkt_ctx pkt_ctx;
> +		u64 cached_phctime;
> +	};
>  	struct bpf_prog *xdp_prog;
>  	u16 rx_offset;
>  
> @@ -346,7 +355,6 @@ struct ice_rx_ring {
>  	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
>  	struct xsk_buff_pool *xsk_pool;
>  	dma_addr_t dma;			/* physical address of ring */
> -	u64 cached_phctime;
>  	u16 rx_buf_len;
>  	u8 dcb_tc;			/* Traffic class of ring */
>  	u8 ptp_rx;
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 1fc1794b8e80..d57019b85641 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -197,7 +197,7 @@ ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
>  		       const union ice_32b_rx_flex_desc *rx_desc,
>  		       struct sk_buff *skb)
>  {
> -	u64 ts_ns = ice_ptp_get_rx_hwts(rx_desc, rx_ring);
> +	u64 ts_ns = ice_ptp_get_rx_hwts(rx_desc, &rx_ring->pkt_ctx);
>  
>  	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps){
>  		.hwtstamp	= ns_to_ktime(ts_ns),
> @@ -509,3 +509,26 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
>  			spin_unlock(&xdp_ring->tx_lock);
>  	}
>  }
> +
> +/**
> + * ice_xdp_rx_hw_ts - HW timestamp XDP hint handler
> + * @ctx: XDP buff pointer
> + * @ts_ns: destination address
> + *
> + * Copy HW timestamp (if available) to the destination address.
> + */
> +static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +
> +	*ts_ns = ice_ptp_get_rx_hwts(xdp_ext->eop_desc,
> +				     xdp_ext->pkt_ctx);
> +	if (!*ts_ns)
> +		return -ENODATA;
> +
> +	return 0;
> +}
> +
> +const struct xdp_metadata_ops ice_xdp_md_ops = {
> +	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
> +};
> -- 
> 2.41.0
> 

