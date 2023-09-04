Return-Path: <bpf+bounces-9191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA97919C3
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 16:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5171F28101A
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E635BE4C;
	Mon,  4 Sep 2023 14:38:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E433D84;
	Mon,  4 Sep 2023 14:38:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12983CC8;
	Mon,  4 Sep 2023 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693838293; x=1725374293;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B7Ovf21Taa7r21Bo9cHRJuIL9ssMIdgf122W78HwibY=;
  b=G4eFVkOXJYKBdTMiKkmW3l5C46A90d2vmsNg4GMK6zlBVe/sXkgSTQv7
   GCk8fi11ekXAks0uaG/SGaxflckUUEOWcw9W+lffYB7PtCg+Z65kcWO12
   PMreUl2G0B8pVc485gU7X8hUHp6nIzt5+pXASb8PTdyDGREWXYhV1Rnu5
   ht6i07EPaPUXHZtbpNAivDJAvq1HCO5lU42lEg7mtfPC2I1MNy3au4bGw
   Wt5dh74d2Wen+WEFjkfQuoX2P+jYBEUdfViIKVWGpJxxCsxHfzdfVmRUm
   CJxS3NGgTHAwv7ZcrFRjg0IHlVC2uJBOhbaVnI6q30PsH+pECbqr9cjaA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="379321598"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="379321598"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 07:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="810922948"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="810922948"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 07:38:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 07:38:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 07:38:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 07:38:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 07:38:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwH7xsNmKt7RetoStAGwgP5dtdR0XKkdhzur84GmZaNKJJ0+tRHPjcZvuOwfRzW1xNVd2tlZZaPtRhEUTkWWsvMukBdNaVpuirSVvH8u5i23pEGd1wjlh0KUJicoc2MlbfqJFt4G77wf4Jp0G9vPlg5FpdGeQ/OSyiM2/ZoEgGGs0WEniR76VzXfW+VDaA2JcsJDkv4xiyeSQwDHYZ3cLp/5YVhLXZ0Tco0CwScTmH3LCfb1226WpncS/TUSyeCpINJAn6pTuUTs5wnRDUWAj9TflLvbGw6eFwER3lGA77ijVWeOVMUpEYXLxfRPS0beD0gUlenDETYywrYWDDFdiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZbYyKBAp93SXYMKpJhgCpzKGi9y5Rg2LECLzp/dH6Y=;
 b=NxFXAodLfHBwmywQSAYBc6lum3rQuVTr3RhITKvjFZs4/YUs8J7wuTlySsp70S63HlCIBcO5wtaCFCDV6ONQ3nXd2Rdh+DSTtGpTE0utw9GlwVpKJZWEjB3UUxXi0BBSETXd8hI4nzNk4i12tTt/xbXSMaycHYEVt2clXe4DCYCVgISJDZIM1Z5l6H9Imr1uvL7ruPDxa4IACUcEjjVw5+/Y3KoDKAR8W1xBhBVJU4xO41vNVoktdGevtB8cvygRuCifTHd7PoidXosKisJsTYaJH6Zn68f38XVXuxdQkHMALPHGZKoPa7Kfreyb35oifDhbrrB6lVokNgISq8MO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BY1PR11MB8125.namprd11.prod.outlook.com (2603:10b6:a03:528::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Mon, 4 Sep
 2023 14:37:59 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 14:37:59 +0000
Date: Mon, 4 Sep 2023 16:37:45 +0200
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
Subject: Re: [xdp-hints] [RFC bpf-next 01/23] ice: make RX hash reading code
 more reusable
Message-ID: <ZPXruYZtN6rA6MuS@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-2-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824192703.712881-2-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BY1PR11MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5bc748-9aaf-4396-379b-08dbad548907
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NbA4xielSCBiCwyMyh2lViM2NSNwSlNXo9e2qkqODHpCmUfYZK36y9VXgUVDrQKNBcZetiF514b+un7BaJAtYTxTOlCO9ZY9yEESmOWqVxrdCG52rAv5OaeX1suTGDXE0Wq+NCbb4DTswD2GyEC6NAiuZmufg0PriHNrhjFIltT0ZT6uz+4o/4Vflg5fhXbmYGohCNFs/ue+6vgsrzNIWGkF/uOvEzMPlO7eyZmztf7cOsMyd+Jny+qCSqTXKr5yomafeTwjiOtt8/pfLtevf8fXO0QpO3skGQ/nqpCnAgUYa1c2jwSxXEs0pn7p5/JxtiXQN+Km+vOmRsr8IAjoO9P2+tcI+vA83/AW4CfYx4pjsPfYl3AO0p8/ao4PZXKYAG3j3ADElPHuDJ59dsEk4oAsH6lXEMPFwAi/cMkRqWM1dgt8yWXOM+4XAVu09NRJZn6bl79WeoRfMaqCVyXjANCAwSOQSSIgQ3taPG96tDs8Y2gG3UOkdltz3CP0qpk914r2J8+qpdUv9qlarjAtN48I24157wR3L5sul0Qw6SVL6PMSzMtnuC/D9bWw1cuC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(8676002)(7416002)(33716001)(2906002)(44832011)(6636002)(316002)(41300700001)(5660300002)(4326008)(6862004)(8936002)(86362001)(6666004)(478600001)(83380400001)(6506007)(26005)(6512007)(9686003)(66946007)(82960400001)(6486002)(66556008)(38100700002)(66476007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ldx6BYH2RB6PnD9cghJ2c/wpCdg9b393ufHphAUoUAQMfX7vCOQD8IzSipKR?=
 =?us-ascii?Q?4SISsE21J17AdGkkEms6J9QM1NtTD1bWYbXBpreU1+iTz0XsxaiZYeESI9g6?=
 =?us-ascii?Q?ekPeOBmLeIMUt6TGNDy9bmYQNjsTth4Qx/n4ciS934G+PLaQKY8R41RToufo?=
 =?us-ascii?Q?5VMlng5nUTsR2AlgkoLjGNCo19K4VE78Sj3/cfeSmAiw6RPTU8CiWQyIg5Y4?=
 =?us-ascii?Q?6/ou1jhpNQvk+9bnKxirdsQFvb21CURZpyhSlHvGDT21vLiMZCMph2rDpPY2?=
 =?us-ascii?Q?l7loV6pqzbClqyNVgGCCYYmZPX5uqqrrUs+eo5Nj5852ADjTf574LOjTe5Kn?=
 =?us-ascii?Q?ej1jZ4I+Th818umpX+IhSV+vpywNNWDc8DTb1HRQM+wvly4/NWgMeQ7NRKXd?=
 =?us-ascii?Q?OlQ9U0c56qdqxMJHUTctehj9HpIqM4cov1SzlN1HdpRVQjFBVxP7id3mPaUR?=
 =?us-ascii?Q?oHjnE+QQHQ1n2VhOpVfLJEWpVi1QmCVMp4d9EKIip2pd1LuX4T8no1Ch38iw?=
 =?us-ascii?Q?v2W4+c9TH7wWvsv2m3FH66GCzpnNtExqT1mPakuOk4jmZOIUF9rFuLwhCH9k?=
 =?us-ascii?Q?ZBcgOilzZukveZuckoytNl4l+t8C+5qtY8Y8Kx6DSH+Z3vOL6mMM/lQLk7oS?=
 =?us-ascii?Q?4ljkqGLH/+eUusSJRShbvHggxDHOsyvFTgV5EMjScurHSAzPacw5iCZpEQpw?=
 =?us-ascii?Q?ruCVGiYWU+vws8yEJswmmybe2Yy9lXuxiynPeRMwUUPn/nYOVdqemsr293Lv?=
 =?us-ascii?Q?+rOatD3HESix4dcw008hD7nc1eLwF1651Zv0Uuz3bdLQh+xo22p0DwCc7OJo?=
 =?us-ascii?Q?gTyO/t9tPbJhaboR37OMbtyO0KMnZs2xMQ6r48ohyHXugIeJNR8NMn6lt4Bo?=
 =?us-ascii?Q?UPAkeB9EvbShy2Ucv2134D8UdU0s5AGvcvMl56D5du1n2iA76NKJLANlFPJy?=
 =?us-ascii?Q?Ggu+AhTDVNNkyFCp3m1KjwnUzjeTpAmwhXoSendBofk//vV2rBZXkgrbu+Ib?=
 =?us-ascii?Q?2SNNUIX/yLzAdI4hHBDZknGcP3F5yypzc8ie8wETcM3cSWQQ6y4PzPAcHlSB?=
 =?us-ascii?Q?/QDrdB126lDlsq9CGPcTYK7fHoM5/2nVEQCaufbtxPB4HNln0kBb16lcJuxY?=
 =?us-ascii?Q?aWnLjrxmjad3rH0QOmhJs38zIRHYl9LRyiKL0t05RE2mY4DWDnPaEF4f5GBp?=
 =?us-ascii?Q?9iGFValpN7TG5EuQYApPFnSkS9kQXk8HHmJLMSMMExdzLRbhe9B9ycN+WLxp?=
 =?us-ascii?Q?TW/tY/Qhv+SFn3oha6MQpO4e7wSHqpdTp9lTl0N0LBQfRVqUa8p8VcmLopic?=
 =?us-ascii?Q?SRkCPMpdYWAYHdMemxEAXOkhxpfLINgURI8EcjqIGRDqy46r2896wDMdcE3t?=
 =?us-ascii?Q?J0vSizuaK1mbogSsPo5hrMSqj2IGB3KNER3uTijZuairor5zmf/TZTlFlYUU?=
 =?us-ascii?Q?bt7YvFM+z+/BrsVwL1yzgVI1GtBaqtU/9aFd6zRM50950ChNkoEaSpLNynmi?=
 =?us-ascii?Q?1qUtgQO2BWRXSzCwyYPxve2OihYHBPxXcn/5bxw/HqTPuCQy2QWTb/bou8eh?=
 =?us-ascii?Q?V5SyP2cNk2gYvgA9wroYFRazx8XmeZemeenbVHudSfpiaVRkLdAeg0gffOJT?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5bc748-9aaf-4396-379b-08dbad548907
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 14:37:59.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHW/m4VmE4EdeZZfNEEPZk36scvYAm3tiHpy2j0Ey2e5ufmKUiRx1fN1ySvHpZummXzpZFR/od6uUHPxKhdvXpRIQJu8kMXvxRQ108LcE4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8125
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 09:26:40PM +0200, Larysa Zaremba wrote:
> Previously, we only needed RX hash in skb path,
> hence all related code was written with skb in mind.
> But with the addition of XDP hints via kfuncs to the ice driver,
> the same logic will be needed in .xmo_() callbacks.
> 
> Separate generic process of reading RX hash from a descriptor
> into a separate function.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 37 +++++++++++++------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index c8322fb6f2b3..8f7f6d78f7bf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -63,28 +63,43 @@ static enum pkt_hash_types ice_ptype_to_htype(u16 ptype)
>  }
>  
>  /**
> - * ice_rx_hash - set the hash value in the skb
> + * ice_get_rx_hash - get RX hash value from descriptor
> + * @rx_desc: specific descriptor
> + *
> + * Returns hash, if present, 0 otherwise.
> + */
> +static u32
> +ice_get_rx_hash(const union ice_32b_rx_flex_desc *rx_desc)
> +{
> +	const struct ice_32b_rx_flex_desc_nic *nic_mdid;
> +
> +	if (rx_desc->wb.rxdid != ICE_RXDID_FLEX_NIC)
> +		return 0;
> +
> +	nic_mdid = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
> +	return le32_to_cpu(nic_mdid->rss_hash);
> +}
> +
> +/**
> + * ice_rx_hash_to_skb - set the hash value in the skb
>   * @rx_ring: descriptor ring
>   * @rx_desc: specific descriptor
>   * @skb: pointer to current skb
>   * @rx_ptype: the ptype value from the descriptor
>   */
>  static void
> -ice_rx_hash(struct ice_rx_ring *rx_ring, union ice_32b_rx_flex_desc *rx_desc,
> -	    struct sk_buff *skb, u16 rx_ptype)
> +ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,

nit: maybe ice_rx_skb_hash, but i have not seen xdp side yet.

other idea would be to turn ice_get_rx_hash to __ice_rx_hash and keep the
ice_rx_hash name as-is. Usual way of naming internal funcs.

Take it or leave it:)

> +		   const union ice_32b_rx_flex_desc *rx_desc,
> +		   struct sk_buff *skb, u16 rx_ptype)
>  {
> -	struct ice_32b_rx_flex_desc_nic *nic_mdid;
>  	u32 hash;
>  
>  	if (!(rx_ring->netdev->features & NETIF_F_RXHASH))
>  		return;
>  
> -	if (rx_desc->wb.rxdid != ICE_RXDID_FLEX_NIC)
> -		return;
> -
> -	nic_mdid = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
> -	hash = le32_to_cpu(nic_mdid->rss_hash);
> -	skb_set_hash(skb, hash, ice_ptype_to_htype(rx_ptype));
> +	hash = ice_get_rx_hash(rx_desc);
> +	if (likely(hash))
> +		skb_set_hash(skb, hash, ice_ptype_to_htype(rx_ptype));

Looks like a behavior change as you wouldn't be setting l4_hash and
sw_hash from skb in case !hash ? When can we get hash == 0 ?

>  }
>  
>  /**
> @@ -186,7 +201,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>  		       union ice_32b_rx_flex_desc *rx_desc,
>  		       struct sk_buff *skb, u16 ptype)
>  {
> -	ice_rx_hash(rx_ring, rx_desc, skb, ptype);
> +	ice_rx_hash_to_skb(rx_ring, rx_desc, skb, ptype);
>  
>  	/* modifies the skb - consumes the enet header */
>  	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
> -- 
> 2.41.0
> 

