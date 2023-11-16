Return-Path: <bpf+bounces-15194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AED7EE3D9
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF434281713
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC993454D;
	Thu, 16 Nov 2023 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duAAO7OO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E48193;
	Thu, 16 Nov 2023 07:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700147072; x=1731683072;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pFuo5Tn/Jj5SVCeF423vwqRoBadPeLc7R1ojkI/8Tsk=;
  b=duAAO7OO+w7w9f4wu+Bkdlno9yEnMC9q986TEUfpdOgHC0KbMCHv3mHf
   8VEVSCQD8lu2P9t72BLBnRayOT/S86gmmPY1d5Opf9h5tCTJwVGEVKd08
   6FtSwE5fnA+oXySekFyRluOCCHj96DOosEp7eHrwfm2ly5UXWfEDbu82V
   fRN8/t5uW0A04WacGHGS6EtZYEqZI4ASulKl8H/BoV1yFiIV24QY+jVbq
   d4CbXYzRapUxI3I2EInYG+V7Mt1UXHbPebKKCikbtCAEVkewDyA2RD9jR
   bIu+f7P2xP84igERUeyXoCGICwER7tRQsjq/N9SVU4KigUqAkXTQCm4WD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="455396997"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="455396997"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 07:04:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="794519397"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="794519397"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 07:04:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 07:04:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 07:04:24 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 07:04:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kP9mMzDk9xJgHkR0iq0UlboZug02ybExcHmoP8+z7r+NZQY8F8fHDArLo4J3nFBOsgL8n8lMaouyP1zMc81T+05ljPDOFzqFyNMrgOyejMKilaa1GdtAK+qeIvgpIKb/qd/FCulPFMh0wV4D4Mp+wkSqH0d3p2uyT6FRUh+IHZ6aB9/YlSkkKOg8XIojXQTf4dZxi4+3UGcwAA8sR9OX+MHgtRTQo93AwHd8Dt9IxkLF1VfUF9j3wmrWW6CNCJAjCW+wD6CTi2VgUY0eUcvBLwFkvmoWoVnPYEhokAqAB14sbNZYihhAjtFf76fXleNBs0qRj2VbClYT5yFVb7vi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkYzMjVRVGiFYSQSBcDZp1CcCsNa9BW7hc/DAXQDsnw=;
 b=SA1g8kwnjTe6IzPXhk/uY8QV/+3m7zVXNSuPoZe5M9GTR9aRRxCTTFBGhK9AgKTtW8x0m2Ih/XSkO5NoRIBgfIx5vGYlGMoPb/UyHfGabEm72GJ2HHlajOtzTLxM5Nq1Xz3ZBQx3R1GIWzi+5k5ygDWOrYygBuCwN0mX4GGKacREUQhxVNEEtnbacuR1P8VO/vme1NQLm2zwRY8pmrPwhilnedMxOfEHI3hWaV1fJDG+AagMWB0LF4KZqXpK5EU/tHqaPBauzAcDG7fluCVzTqu96xRUg4TetNU/1B8NzHm9w+UA6Tha0/R1o8QQdMr1twc3RPLqI3O3S13BzgvucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL1PR11MB5555.namprd11.prod.outlook.com (2603:10b6:208:317::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 15:04:21 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 15:04:21 +0000
Date: Thu, 16 Nov 2023 16:04:12 +0100
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
Subject: Re: [PATCH bpf-next v7 01/18] ice: make RX hash reading code more
 reusable
Message-ID: <ZVYvbB3DnKzAWtO1@boxer>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-2-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231115175301.534113-2-larysa.zaremba@intel.com>
X-ClientProxiedBy: DB9PR06CA0028.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::33) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL1PR11MB5555:EE_
X-MS-Office365-Filtering-Correlation-Id: 0793e249-e325-4fc4-6fd2-08dbe6b54fef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaP9ke2CVhd1m4gS4wum9P7kUCRkv1Lyl+HNWymXJBoJ7H++RHS38ei0BT9a+qEH1vIWKACm3NJg3lluj9u2ltfcJep822oRV65ll87PJbiP9DcYesujgiqlqGsRldEa7FYDj3mvsU5rIHHVv/vzfXdpfVYrsfFdUkh7EbsnzbFmUC6KqZIAQ26xfPrx15rObOenLLssF4LI++IxSGrbCCir5Hb/1qUC1jaYk/DMuYvpwIfIhG3hQcZMIJ7jpiiPDgb8lWSmk5TiqjDQyvxsFd0qqw/JewUPDgKQdA1FVZ9clEtQ3YWSW8AYlwyZo+zQhKVHMpWmWknVxAAyd/owsV6h+HbaBve0lDgbceimlKRKdROcqz30e9YPcaxCEnMzjzSb7F/6zbEQ2O18pzIaI0bV6VBPCzDeHSiqXhJYi7rhN4ZRvm0KT5f3Wcdx0WeMU+1C5tf+Q9rZTPEiCuZrffFOyUGBfUUfC3WRynhLF7mxmIvtGOG+ZG9jYVoa4fSSxX6+IKk3WtWryJyOjyj0T6RE7EjzCKuw6sT9DMDn+cBx7dX9a11cMltWwPH0+dzh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66946007)(66476007)(41300700001)(54906003)(316002)(66556008)(6636002)(86362001)(5660300002)(2906002)(4326008)(6862004)(8936002)(7416002)(44832011)(8676002)(82960400001)(83380400001)(38100700002)(6666004)(6486002)(478600001)(33716001)(9686003)(26005)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P5sbQqUaI0W9kSAVMgmzM8XphKsaW9AsOpuoLNQ8KaT3hCc/SnGgoWga8wuZ?=
 =?us-ascii?Q?3hUgyOiLQY8zKeZQrUzHWHgI646NWinfZOuipVMeFXdhFlYVJ3zIWHXnttKf?=
 =?us-ascii?Q?g/zNSpzxJAuIe3cszuoa5YXw1UD9qwthOqSq0lFbJmzymqYr6LmBSDIREeYy?=
 =?us-ascii?Q?UVPaWi434KFvcZLfvCj9Q27d0Xyhg0guhiqXZYC+H3fYqezpOFu04qMfWqwu?=
 =?us-ascii?Q?87UOMjyci8o6TFwFbeTs4QBcVbOXxNYpSu4S9b37gzKQ+fGV+QAvOESNFjAY?=
 =?us-ascii?Q?fm0jbZuAaw8/jS9V/yttFTfFtZYZgFZfeONn0rB65nDzYrlgx6RnDbEFqxck?=
 =?us-ascii?Q?zQPbBaVQIgQZeMR/vD5VpiadT4BTr/rsiuAnR5L7TReiQ91x53sQm4d198cD?=
 =?us-ascii?Q?PaiDvmhWHOBD2F9qCts5mXwiRHCk1ce/TKLicuc8KtJ2UEeWp1GkEFPTngNL?=
 =?us-ascii?Q?Fz5A03/9Y+rCXRQ2djqIrTlTiFkrGOcYHqhW79AZaBq0WMad98griI2DKCwv?=
 =?us-ascii?Q?ELqJii3OOfQFXGyp9FaW2ccsLwMlvXXtiUP6jMD41cAaPa33bA4V++sTbOZW?=
 =?us-ascii?Q?b8Kl4rOoOXpJrHblZaVe+QD2ZsUgQujPNh5wE0dQaJgWwzLYs+gjE+ZBW6VM?=
 =?us-ascii?Q?tcvLghscUVUIucFfTxrLc5D7qKFSqbi453mU5SAx1l82rGtRZZKiSB6Yz5F5?=
 =?us-ascii?Q?JhraKwH1SqrqZfgdVwoYnDdQNm6UYDMmwUizKXOhDmcoUyDe0g/ZM/hsR6+I?=
 =?us-ascii?Q?7J/LAoyd05x+u6iin+Fp5FoMyiMY3yc+Q30AELaF9v9nNGqrwYg6/6zI+She?=
 =?us-ascii?Q?MmrBDEqEBcBxC2WhzP20XNYsElfylWPK7bWuWmhRKfYAPOvfrTk5w1RR8uIo?=
 =?us-ascii?Q?MAuoULtWeRadL6rksxXwrBpYY5EEcOV0NjjIrXlMqoZgfImcWQRGH8I9524x?=
 =?us-ascii?Q?lLztdYIK25aCY57PfUh8db47qgjx1tzxBSUUHZllPqMK6DTKNpSU4fXwo7+i?=
 =?us-ascii?Q?ltlN03RZvG8wA8mYX6P/uMCAomizvFp8bN+AEgSAXnFWr2hbhuIktlsO6Qr8?=
 =?us-ascii?Q?0zJ+mP3AFmqhTOrAdVzxOvXfQDGXAEYy794wtvpaXVlZQNaTA7A6zC3HM5GH?=
 =?us-ascii?Q?LCJwZv49ggwWoodqBtHtufKVLk8iuusmU6lkFWrXNx3P4ZQLZWnZAm5gIbU+?=
 =?us-ascii?Q?GeJORzIxOAOeyUA9uOwMSAnurafsyFMqwO0e7d90lcKlPbdGwsj4Xheedtmo?=
 =?us-ascii?Q?wbwV3uwppDDF2JsynzfDrFkyJ4fiYgbUh33EHxEp/3E9h5s3zhOKD7xqyjW8?=
 =?us-ascii?Q?kA3D2gt2AKhPU/MVXlPFQPhiVeVvtMNNkScnWz98EE0ajim9zWU2ZvWCEAUG?=
 =?us-ascii?Q?H0GkrOOfgGrQ6PHmD98MA/NRqaJzA6Xcjy98k+kN8SA9blx+jtTdl1iW+Q83?=
 =?us-ascii?Q?0DvK0Nha9BB5mhBpZB9aFne9Gsr9Tzu/2Sx0qK/aQYzoZCeSTkHLCFC9r9Kw?=
 =?us-ascii?Q?1lbtpX+1RkwTWSvZGejJcajpZmka56cFo7v7kQ2tdMfM1gfBw+uHeVvn2y2E?=
 =?us-ascii?Q?B6NMx90N3Y5VH4z6eZo9TaV/qfRCgiC+36fmMf6G+aQbX3SD4BTk97lbbyw3?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0793e249-e325-4fc4-6fd2-08dbe6b54fef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 15:04:20.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TY8KOxashU2aC+7Mgt8nfpsvZ4lPVHMbLZIvf+74kksWSsVVtyvifSEQW3XGJIVDrGnHPRUMa98u195oFY9egRm3PnHBUf2wLEhvPCESomc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5555
X-OriginatorOrg: intel.com

On Wed, Nov 15, 2023 at 06:52:43PM +0100, Larysa Zaremba wrote:
> Previously, we only needed RX hash in skb path,
> hence all related code was written with skb in mind.
> But with the addition of XDP hints via kfuncs to the ice driver,
> the same logic will be needed in .xmo_() callbacks.
> 
> Separate generic process of reading RX hash from a descriptor
> into a separate function.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 36 +++++++++++++------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 7e06373e14d9..17530359aaf8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -63,28 +63,42 @@ static enum pkt_hash_types ice_ptype_to_htype(u16 ptype)
>  }
>  
>  /**
> - * ice_rx_hash - set the hash value in the skb
> + * ice_get_rx_hash - get RX hash value from descriptor
> + * @rx_desc: specific descriptor
> + *
> + * Returns hash, if present, 0 otherwise.
> + */
> +static u32 ice_get_rx_hash(const union ice_32b_rx_flex_desc *rx_desc)
> +{
> +	const struct ice_32b_rx_flex_desc_nic *nic_mdid;
> +
> +	if (unlikely(rx_desc->wb.rxdid != ICE_RXDID_FLEX_NIC))
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
>  }
>  
>  /**
> @@ -186,7 +200,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
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

