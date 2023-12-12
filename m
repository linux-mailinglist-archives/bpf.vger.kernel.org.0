Return-Path: <bpf+bounces-17529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D6C80ED7B
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 14:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A52A281B26
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A46169F;
	Tue, 12 Dec 2023 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvVgPGp0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8900983;
	Tue, 12 Dec 2023 05:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702387602; x=1733923602;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PMjrwFhNpIEM/xZWHh15KLS0bCG7nsbx/8BcilhsfuM=;
  b=TvVgPGp0gCm4gf7UMd2xZBoDFg2+JCnzmGD5Q5ToIm+hk0BAUnDfnot3
   ePbQpnG5FLWSzuYhd7f8/Pzq5rk+3T1uGqulodu0wGG8JihY7s9IzKHQJ
   xsrzbj1++R9hsbFFjXgQcs/28diKwGlkazU8qLxgxrSOdGS9wu+NhtncR
   pQVo1mxxh9QDLGZDW49gMhchxarZVgI49gSmu/gBqZeN2XLrxSoNYGVa7
   2XDfyucu7bmV92CldcwQUSpc2vYWk0K/9MlgHVbV1QnRSsmPgSQDdS69O
   pe9V8yqjpLWG4gM1uzrM5Y1+6MI0Vjql+UASsCbKf31bsJRKKXzFVOvS4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1958119"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1958119"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 05:26:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="14993770"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 05:26:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 05:26:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 05:26:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 05:26:41 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 05:26:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVjfxB9lYAJroq4Asi5M7lRoCtARh2BbNMYSTHcSM19wQtonXeYW2mocBj3a3O4Cn0SLQquC3IirXpHPxhMB/XIqB9+0aKYX6DeKlSCiVkLriVnuosk/6COxAtKe7Zp7wp/Zl5HZikyZhiOynM3pa8RSsFeqiEiKZ+kuxgdhE2DJxeRnrvd3DyjAeHW+XgXxm+QhjP47NBRI3O18YGScaXK/xdDI9LKmoSEL7ludXau30oMGImR884U65YHjYIJeM1revrD0EVk2UZHjzBeKiuNBmCkGsGYokedu8H75dCvSVbL35aPMS6QuYTZ9ZZ95f5KOn3r2xY3W8ZBxqMHmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mx/sp6RDHYV/P9VLu25wEdGoWlFhyFPdDz6pAqCgFk=;
 b=LfSx90VJ5SkkMSHL8IYHjIWq9YmBJy2X18sJNUOblGLu3CTA9UwGfGF5h3SblOgRkPMUqlL6ydG56OEap1QsN5/1Pu2CUATYWZQcum/AZW8bS9pvV+viNOKudgyJBn5OKq7qS38sNqCadSQBBaB/OjQIyXDMliW6uSKY803h1cODF5uKjyPxpwloYMk4imGdWy3iI+Ml12cxziD4pCS1gyoJhIB3+IPFESiOKkJbIgMjeV6bnx15kYML983o/oQpDfcco5sDWFkHVrT3OyvJkOxluiVMRSXonWw4JhFd5/WNhYiY2dIc6p69cDGzTwWCfy2n3KNjOZQ93ctkOwlVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ2PR11MB8497.namprd11.prod.outlook.com (2603:10b6:a03:57b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 13:26:37 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 13:26:37 +0000
Date: Tue, 12 Dec 2023 14:26:28 +0100
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
Subject: Re: [PATCH bpf-next v8 11/18] ice: use VLAN proto from ring packet
 context in skb path
Message-ID: <ZXhff8PLKgem0njo@boxer>
References: <20231205210847.28460-1-larysa.zaremba@intel.com>
 <20231205210847.28460-12-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231205210847.28460-12-larysa.zaremba@intel.com>
X-ClientProxiedBy: WA1P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::23) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ2PR11MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: d613ed19-8f2a-4554-41ce-08dbfb15f781
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BDiRXUImZjSqMlg7DNzZjbN6g/NXhBLXaTDgRpu55Uiilcc0C5yBiztGjANA9eORkcDITgXYibwL77KmMvyZbSffSYdodln72gQRpU0Iyuxa5QBjE+Ox/wci5W4CZaSfNXwY/l1ghbaYhiVsuriFturf1YBY/DAU9TJ1i5PyHkEJF/J3WeaeksFyqF4eQinVNLn/vo0R7ToXaMdOK5lEPqk2Mw6wmT1+KhSC5JYKLNM5rEPuMZbdzsQ5ZsAop7kX/VvTxVQy+pmtQwYDOp9Y0RnF0Iwdtpz+OlmebXsva3pVBxhyWG35I/0E2JrlhkpdOcQ/u+5r5bHZJh3vTUop1cQ9hxPif1hhkoDHAHULrYPvk1gO7HZJIMbl6S4+fVJbkBVdgyORssKlCw79cccZsFL7Rs7r83LY+i1A2be96jYNkyI9gpJ8Ll4ZYyuWUDY7QYoIM7I/tlkIUOGx3KIbU8luizyT1Zg+/0eLe44Y1g7Bfqyrn77D21OZSzEvann85xWk9jipvXiiJ0Ba7OzaEp2ZqlJ0BnwK18vlWoVo3OPFFB2H4RU1xOesnIbNnoRr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(54906003)(66476007)(66556008)(66946007)(9686003)(41300700001)(6512007)(6666004)(6506007)(26005)(86362001)(38100700002)(82960400001)(33716001)(83380400001)(478600001)(6486002)(44832011)(6862004)(4326008)(8936002)(8676002)(2906002)(5660300002)(6636002)(316002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QlLrTizuaEm6cE/joPRHHWI2lK7/xp6keR41aUVrmvRwu4hw4pwFWE4t+36u?=
 =?us-ascii?Q?+n9S4jcuK4bjcaZKZGNCEtHX3+mcZNAXkJLx9pEwzkphDg0aojCoGMqWGidK?=
 =?us-ascii?Q?QY6658AMNkOpZLAVfTgMy8svOaED3B9VDxrMSTjDUf9ngnceMlGz1tVpwhZf?=
 =?us-ascii?Q?wIZMOmwqx437/wURl675pdHOg/g/CTLJV4tebYKXKPsvLxwGm967AqHeq4y+?=
 =?us-ascii?Q?J1UBLl8d89yafnkeB1vrazQA6qsFrbswm9BdEmLL1IBvi/Qu3V7/2nPIwm6N?=
 =?us-ascii?Q?R9bazc+oPqj4P5epUJ5KJIOErgRchiOPGlcf7hEY9k/7y//YXk5FSm5O++Jx?=
 =?us-ascii?Q?P9cQrikQTMTQ1m74gX+v43KZRPhrHCkUQT5DatvI4F0rN02Osh2ETR/aLCiJ?=
 =?us-ascii?Q?pch6teHcWYZUofWXErBlesG0eMoERaK5YiLGkaQU9WMKP9N6svg41ctpS4oF?=
 =?us-ascii?Q?UoU5Hu6iFEnlUzOY/IUX6uEL1hAeWIL51QUtHJNHXAqZjgfD39J/lhsvSOCL?=
 =?us-ascii?Q?cqh04BjTVNPfnwm3Wqq0FkECG3wo6wH//jrc+3NjXrfI9TPpX5Lf7xNy0s9e?=
 =?us-ascii?Q?7SbOMr55+r6rlYA3VgioZ/K07mUfXeZIxtfwc2Kz02jRj22OVv2n4nvmE1p+?=
 =?us-ascii?Q?n4+svKIDI+/ue/0SPVUnm7oSxKpUiFJhFLNHfToWHMDWtTb+PhHysiaK/7iE?=
 =?us-ascii?Q?/4R/jFBiQUJvUvmokZLlsFZ9q3vtY4GqKzMpOWdCHKxrqFxTt2spZ66tInc+?=
 =?us-ascii?Q?iW+TLmE2FUyMXKHom/ygE0SdBtWCiTX3GQ1yH1dl3lZ3GOP4K5SPubSCElan?=
 =?us-ascii?Q?Awc+unbAYPzqeeBkoBJ4PUUK6wGqHvfa0kpqs4cMWb1rLXQ9FjsQcC0loOiM?=
 =?us-ascii?Q?9342kIjj9iJPvJGjE+Ua+6pWVcpkuwZ9QkU3r4lOIUjhvwagMGOixrGIvHnH?=
 =?us-ascii?Q?Y9pwVu+jSiXSKAikYj6gw2CXcyLxKx2dlJsnhxQBlcUfBCeJ2XZYcFV8pQp/?=
 =?us-ascii?Q?itV/dwcUcSdW08qm4B6fqPA6l8OUTRn7LqUkL6FDO5U9FPWeY0cx2CdahIjX?=
 =?us-ascii?Q?hIsWnCq544O/lPxVhLUT2VfKCRvkFM+aw9zrPt4Bp6UBdbXiPIFoOl4WzuT+?=
 =?us-ascii?Q?nLIay7nLbmIMfPEu/CvAl/V9kQLR3EhLPhH8u4lutK3Bms6vN+YydNKJZuzJ?=
 =?us-ascii?Q?2U7YmxhSknpkyFORIvz+MCQ6V2v/+leYGW2vXygppwSCKG+wlEZNFZgYH3UU?=
 =?us-ascii?Q?XXynW9VWMgC+pe+6CA6wx1nRIDmtGrz9A90IBMwNv1L/pd0GNpHM9MvzcFzH?=
 =?us-ascii?Q?Iy6CYglUrfzBOKS8wKQ0Y3PuMdZ+NP61SDhdIWJlTHXXCYB/mBymUT1VlHZv?=
 =?us-ascii?Q?RkKh1CsdvgxlnYL3dC6tdFgtBV0JcYrniZ1/qWmDiGeD4sSALleTez2yWKJG?=
 =?us-ascii?Q?AHjoLKkldDNlFMGkPpnq5pzW6EQOI6McHVFf8ag1UUvgx7x70L9tMpkvzUTM?=
 =?us-ascii?Q?XfWZ2a6HU8pH2ZGcPKnHYZ4CZQkjyGzDad25CL5acX9PzUw+IQvEa+AqpZa5?=
 =?us-ascii?Q?Zt/6ZNJOPLfEh4hruRaE948Oku7k1IMdx74jvPJVlmviaKwHAdr9V/+b3IHU?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d613ed19-8f2a-4554-41ce-08dbfb15f781
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 13:26:36.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G825MBd2l3dJcgdmTCnvp7kJOlxpQCj/8aJ0GcuixelLGWKwpFA+rbPE8rZMBJSqRbKjaSTajplYlgKDtRmeAOY0Zeq33Kis5kiPp4x6q3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8497
X-OriginatorOrg: intel.com

On Tue, Dec 05, 2023 at 10:08:40PM +0100, Larysa Zaremba wrote:
> VLAN proto, used in ice XDP hints implementation is stored in ring packet
> context. Utilize this value in skb VLAN processing too instead of checking
> netdev features.
> 
> At the same time, use vlan_tci instead of vlan_tag in touched code,
> because VLAN tag often refers to VLAN proto and VLAN TCI combined,
> while in the code we clearly store only VLAN TCI.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

IMHO series is good to go, however I'd like Magnus to take a look at 07/18
(no pressure:))

> ---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 14 +++++---------
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 25ffb539b474..839e5da24ad5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -244,21 +244,17 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>   * ice_receive_skb - Send a completed packet up the stack
>   * @rx_ring: Rx ring in play
>   * @skb: packet to send up
> - * @vlan_tag: VLAN tag for packet
> + * @vlan_tci: VLAN TCI for packet
>   *
>   * This function sends the completed packet (via. skb) up the stack using
>   * gro receive functions (with/without VLAN tag)
>   */
>  void
> -ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag)
> +ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci)
>  {
> -	netdev_features_t features = rx_ring->netdev->features;
> -	bool non_zero_vlan = !!(vlan_tag & VLAN_VID_MASK);
> -
> -	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && non_zero_vlan)
> -		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tag);
> -	else if ((features & NETIF_F_HW_VLAN_STAG_RX) && non_zero_vlan)
> -		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021AD), vlan_tag);
> +	if ((vlan_tci & VLAN_VID_MASK) && rx_ring->vlan_proto)
> +		__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto,
> +				       vlan_tci);
>  
>  	napi_gro_receive(&rx_ring->q_vector->napi, skb);
>  }
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> index 3893af1c11f3..762047508619 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> @@ -150,7 +150,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>  		       union ice_32b_rx_flex_desc *rx_desc,
>  		       struct sk_buff *skb);
>  void
> -ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
> +ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci);
>  
>  static inline void
>  ice_xdp_meta_set_desc(struct xdp_buff *xdp,
> -- 
> 2.41.0
> 

