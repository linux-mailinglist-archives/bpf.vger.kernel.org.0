Return-Path: <bpf+bounces-9194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA68791A38
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED6C280FFF
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA18C146;
	Mon,  4 Sep 2023 15:02:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B23D84;
	Mon,  4 Sep 2023 15:02:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5461A5;
	Mon,  4 Sep 2023 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693839775; x=1725375775;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XapmlrfnLX5LDrZZaSe/VUi/Nk3AYAt9THjCZb4VLsA=;
  b=Ee9xHHth1JKp/fTmYem88BCmg0fXIFakvgahhhdO2tj1juU528YNmYEs
   5Zllty/6aDvcr8nD1vggPU3BTOPKeF/CtkHem+m/XErR+8oj4gbY591Nl
   C0LdrZim+5uLNNHZjxeXPImXrJn/lxRGKNlaWbX9+Gqg2AKbjwmplHJlH
   O/H66R+lcVwyIifiikkUZdsSNrmvEGg4ommobiCI2zbcJ7TKz8AvkoQTh
   nv4+h/g9zd8ICH6g8hEmroFbSK/jqvM10HQ+ED/dKsyJaBwSMw/1/xyZo
   4cwRZ7UMimeFjk1nSmf6NqxQpJcRUmkz9c39yqLsN2uoRBivZpSEYrZzL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="374008537"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="374008537"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 08:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="1071648710"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="1071648710"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 08:02:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 08:02:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 08:02:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 08:02:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 08:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKfg+a4XGphHk81g2jg/JHpmnhbecaWPIcHtPwFn3N9a5OU7ezvAt+gh94+aT150D78aeWOnvIyNlSPNgGK0mIhe60mg2qzHdZt2MPMdOpB7nFyI5bLGhmpPwZXW2Y/KtwplP8NPj0J0SIbyzuPWlfejly23Q52YZQyDgZHs02SkvNPMcoUTcrgyNi9hHzevCvqS2/oznX1sLoth34jX3DO7erDZgnO1NdVWplbIZC57TuGCwsps16mNJaA6K0kSdQ4mWaqR63zVwAR7FAN/vsOywAHrOVfsysQqx3pavsX8SpeQzZ+aPSlAjtuU0hWfMHc4x8AYZCs8Rd4s8ZGLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIGHN9KzlIi1eNQ7/rL0v3Fvp0gfD/1TfQd2/7xq4DY=;
 b=b10Pmb3Ff+wR/w+5VV5PkUCVkDuIxrQMh38LWJwLV24bcml1cwkhwzaPgXMC3yFyuSAdjyUbR0OO8QMRfNYqlXDDzVSpRbGzTAoxcE/bifpyxCpYgMSfinYrz05KlMFRMbPkcKINTtS23FV550gnUkiSOXlRiU3DCY22HpxMQ0ltE6d+QlgPTqtTWNJHUf9m1D24OwwSwNPYPFgAQs/ChdJ8eMpF+kDdUshanW/aHKbwTfJMVW/AC3xR3ThD63EQfDfcldUK8RLf7FdfpPrKg1AvZifVkxcvMoULscymX0pcz5tni2WIxjt9Mk0Z9WI8eHb5n+KaebZjMnzt07AoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB5534.namprd11.prod.outlook.com (2603:10b6:5:391::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Mon, 4 Sep 2023 15:02:50 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 15:02:50 +0000
Date: Mon, 4 Sep 2023 17:02:40 +0200
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
Subject: Re: [xdp-hints] [RFC bpf-next 03/23] ice: make RX checksum checking
 code more reusable
Message-ID: <ZPXxkOCK5e4M/P5H@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-4-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824192703.712881-4-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB5534:EE_
X-MS-Office365-Filtering-Correlation-Id: c2969ea6-5513-4307-649c-08dbad5801de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PL1Brs+8o6RB4y/vJB5k0uzCqP8gXVA1BTjMaXi9BWx5/keZdwsSsVFY1GDFD/+JFw8sx6lwUqDkvReS3uxUbI+gOrqJ00JdO5t1pNfNKHo5aNLOy3Z3Zfc6vHRmbH3BGAlaNFaUhiWckCJGJtOCXHYts6OnBA6oVeYXepb2tv8VP0w0KUkEVK6ruvAQszzGqCV5OngHAbX2aBQnz048BCRN9erwaEMNgtdeTNLUo6yj4s2GppapYdV2LkC8xzRNBHbZN5UZ8MtxM3sjvds1Ws//AZI0ko7gHym/ipN3wt62XfLP6oO6wijgWhQMu0adTM+8GwemAoC9wpTMG+CFTbqKktMuJD+x+wZu1pVwG8KJFtu5tjIYr70ELiu+QuPPWAnnnNA/Su/QjIbxbe9V6a7OdGZQ5fue+yuUqGjVCAl3uvIPbio6s+uLNhUy2zILeq+cSYJb/U3Cn7DXkEEHn4C5LRYyNeCf4qMc+8q95Qmg6ToOKD1LTC/XYpAqOM4EGn5VMsiLWKWma6L1+wuf/OQZ+AiQxbPsypJADfLYlCLlufHj4z9d4CcLcY4fbHq4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(396003)(346002)(136003)(186009)(1800799009)(451199024)(86362001)(6666004)(5660300002)(6506007)(6486002)(44832011)(83380400001)(2906002)(26005)(7416002)(6512007)(9686003)(41300700001)(66476007)(54906003)(66556008)(66946007)(6636002)(316002)(38100700002)(82960400001)(8676002)(33716001)(8936002)(4326008)(6862004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBYnsXwGPkaQF69hJaFMC8zF+JbKOl2tNHmfHC582VZZzv2doLhUGDAC1zzW?=
 =?us-ascii?Q?BM9tyP7PtN14n93TwxqBeMbFgliu5zHq3TB5WRfthl/RCJDuxkSv3Elt1Z08?=
 =?us-ascii?Q?HLm3B46hw7U7omhe8g0Sa0QO/qUOhM6nrgNiVBoajikgbEqaWB+FqmItE/FN?=
 =?us-ascii?Q?Oc6BtuUjTgtidLJ4rZvi7qvLKJjudZSNMd0YjHZZ6nWlrWNWco/eQ0ac0OR6?=
 =?us-ascii?Q?gZmJRpBut3JGTXZbvl0EHq9h5t7rfvKxKlVc4hNQ+WDG0G6z2EjxwOEDgz2K?=
 =?us-ascii?Q?PpBoyrEoY5YBXXa6oeKWDHsd3sPReXRA+AJUBwNVlwrb0JUUO8TH/Z5+dC6o?=
 =?us-ascii?Q?XrexQ+MBq47WuQcp/Rj3uk+w2oo6Uvn24WU1shlZuiBr3vaJr0K/Bki98gLw?=
 =?us-ascii?Q?QeBxeUO+Rk7ZiyBrDvpDJsBoH6u2IdQx5eAdP2PQZHTEjlck3pkyfRM+pcxd?=
 =?us-ascii?Q?mv3wBD1uJArkq0XJ9wNZDXLu3up6pBzGhW2+d3oCnvCUJXBip/KCsrAOkRgi?=
 =?us-ascii?Q?mO97jIWwmnkiE9UYjyGol6+f3TBqMlfEJi8ODmPebN44hbD80DDcj5/CrYD8?=
 =?us-ascii?Q?CiZ8GhUbHYQib00OQZQAhvkMg6fJCIgf9xB4+aqIJ9XhblZx4pBc2wQ32v2M?=
 =?us-ascii?Q?fXlCQqQBAbMcr1niEhfTE9gR2aZK2zfWBW8Hb6QzYqxUSwyduAJHKn+YPka7?=
 =?us-ascii?Q?rq1qp60ppc88/SHK/wQhPG5at6dMYA1BzSsPYrTcnKUBb7fMPpnUK46ul9tc?=
 =?us-ascii?Q?VxKwKSkAcwrOYeWiuv1kDY9Q16R3OMH25P7Zaar9HIm0IjRDDBZNZ3Pg7yq4?=
 =?us-ascii?Q?i3i0WExK8WsD3jDuNz7iQbz5/LbosZ2iOE7HhrUUJIL9AHb2b7NRYs9q2E95?=
 =?us-ascii?Q?GDMjeEqqmgRMb6MdxudEE9GXFZdbax/aPoFLlF6bs01Gcsrzh/fNhf9ZwAPi?=
 =?us-ascii?Q?+Cw9VzwZE2TI30tDAsqS7bduU3RRlNTR4Voblarbj5XE1ZNZ8pDNVC6Gobi+?=
 =?us-ascii?Q?WWjIoyuOFR/CSifZhb/R0B3RmFW3Qj/phAQo72xBscjxZSQsL+JCeWmwBtwm?=
 =?us-ascii?Q?YF8Ri7tlsn3v4HNSlB49ch1H4jLyQ5JJDfG0zunj0XF4FXuzA1Uw9zLp0XD4?=
 =?us-ascii?Q?Mu6FTnkmbVdeLEe2G5IGrRAnO0u+IKptLnXkBQ8FvAQLc39wKZJQAwSH0RhD?=
 =?us-ascii?Q?QKgfP/Au7MOIHfinBab9ZFJ76S9ewAQfw9YI3IaFXZsRHQTuGWI2Evz2NnRp?=
 =?us-ascii?Q?7oUbfHoHjQbm7Xc8oDQrX48ezzfVnZCsWKkeYBNF/CfKOXN93uE6D8KAD62e?=
 =?us-ascii?Q?oUw+8bmTNBBSHHHkZP/RNItTKJd4kVPo0tHx/X4MENuc/ZANLPZf9ZOdZVtV?=
 =?us-ascii?Q?nyzGen7IGWkW3WRsJpJpxCMqxtlyysu/t35mSv9ioAQAq1jjcNVscWcult78?=
 =?us-ascii?Q?mQsDUxdKKoo8eLNYje1Hf2RiOsPRKMhhoBgVBj9zhj1ZXDq+CI8hBUxbETdv?=
 =?us-ascii?Q?igw0wvQ2fsCCADcH99DL1iYt62P8ky05o4Hets7km2/6KiBW+uac/N5VfOC9?=
 =?us-ascii?Q?/I54A4JyNDvkLttKjIF+b6/Mti8jI0pwG0nohGdp3FRTryr7sRt1t9xu4/2r?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2969ea6-5513-4307-649c-08dbad5801de
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 15:02:50.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hH0xWQxuaAxjTyGWCQjUbq1+cDyuhoVvdC0/5LoPONN5LqAKj7Dxd3PQNmGO1uIiI8nDhoefAeB1f1SPOQj9n9pbdxxPitQTXmnEYVpSXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5534
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 09:26:42PM +0200, Larysa Zaremba wrote:
> Previously, we only needed RX checksum flags in skb path,
> hence all related code was written with skb in mind.
> But with the addition of XDP hints via kfuncs to the ice driver,
> the same logic will be needed in .xmo_() callbacks.
> 
> Put generic process of determining checksum status into
> a separate function.
> 
> Now we cannot operate directly on skb, when deducing
> checksum status, therefore introduce an intermediate enum for checksum
> status. Fortunately, in ice, we have only 4 possibilities: checksum
> validated at level 0, validated at level 1, no checksum, checksum error.
> Use 3 bits for more convenient conversion.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 105 ++++++++++++------
>  1 file changed, 69 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index b2f241b73934..8b155a502b3b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -102,18 +102,41 @@ ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,
>  		skb_set_hash(skb, hash, ice_ptype_to_htype(rx_ptype));
>  }
>  
> +enum ice_rx_csum_status {
> +	ICE_RX_CSUM_LVL_0	= 0,
> +	ICE_RX_CSUM_LVL_1	= BIT(0),
> +	ICE_RX_CSUM_NONE	= BIT(1),
> +	ICE_RX_CSUM_ERROR	= BIT(2),
> +	ICE_RX_CSUM_FAIL	= ICE_RX_CSUM_NONE | ICE_RX_CSUM_ERROR,
> +};
> +
>  /**
> - * ice_rx_csum - Indicate in skb if checksum is good
> - * @ring: the ring we care about
> - * @skb: skb currently being received and modified
> + * ice_rx_csum_lvl - Get checksum level from status
> + * @status: driver-specific checksum status
> + */
> +static u8 ice_rx_csum_lvl(enum ice_rx_csum_status status)
> +{
> +	return status & ICE_RX_CSUM_LVL_1;
> +}
> +
> +/**
> + * ice_rx_csum_ip_summed - Checksum status from driver-specific to generic
> + * @status: driver-specific checksum status
> + */
> +static u8 ice_rx_csum_ip_summed(enum ice_rx_csum_status status)
> +{
> +	return status & ICE_RX_CSUM_NONE ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;

	return !(status & ICE_RX_CSUM_NONE);

?

> +}
> +
> +/**
> + * ice_get_rx_csum_status - Deduce checksum status from descriptor
>   * @rx_desc: the receive descriptor
>   * @ptype: the packet type decoded by hardware
>   *
> - * skb->protocol must be set before this function is called
> + * Returns driver-specific checksum status
>   */
> -static void
> -ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
> -	    union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
> +static enum ice_rx_csum_status
> +ice_get_rx_csum_status(const union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
>  {
>  	struct ice_rx_ptype_decoded decoded;
>  	u16 rx_status0, rx_status1;
> @@ -124,20 +147,12 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
>  
>  	decoded = ice_decode_rx_desc_ptype(ptype);
>  
> -	/* Start with CHECKSUM_NONE and by default csum_level = 0 */
> -	skb->ip_summed = CHECKSUM_NONE;
> -	skb_checksum_none_assert(skb);
> -
> -	/* check if Rx checksum is enabled */
> -	if (!(ring->netdev->features & NETIF_F_RXCSUM))
> -		return;
> -
>  	/* check if HW has decoded the packet and checksum */
>  	if (!(rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_L3L4P_S)))
> -		return;
> +		return ICE_RX_CSUM_NONE;
>  
>  	if (!(decoded.known && decoded.outer_ip))
> -		return;
> +		return ICE_RX_CSUM_NONE;
>  
>  	ipv4 = (decoded.outer_ip == ICE_RX_PTYPE_OUTER_IP) &&
>  	       (decoded.outer_ip_ver == ICE_RX_PTYPE_OUTER_IPV4);
> @@ -146,43 +161,61 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
>  
>  	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_IPE_S) |
>  				   BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EIPE_S))))
> -		goto checksum_fail;
> +		return ICE_RX_CSUM_FAIL;
>  
>  	if (ipv6 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_IPV6EXADD_S))))
> -		goto checksum_fail;
> +		return ICE_RX_CSUM_FAIL;
>  
>  	/* check for L4 errors and handle packets that were not able to be
>  	 * checksummed due to arrival speed
>  	 */
>  	if (rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_L4E_S))
> -		goto checksum_fail;
> +		return ICE_RX_CSUM_FAIL;
>  
>  	/* check for outer UDP checksum error in tunneled packets */
>  	if ((rx_status1 & BIT(ICE_RX_FLEX_DESC_STATUS1_NAT_S)) &&
>  	    (rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EUDPE_S)))
> -		goto checksum_fail;
> -
> -	/* If there is an outer header present that might contain a checksum
> -	 * we need to bump the checksum level by 1 to reflect the fact that
> -	 * we are indicating we validated the inner checksum.
> -	 */
> -	if (decoded.tunnel_type >= ICE_RX_PTYPE_TUNNEL_IP_GRENAT)
> -		skb->csum_level = 1;
> +		return ICE_RX_CSUM_FAIL;
>  
>  	/* Only report checksum unnecessary for TCP, UDP, or SCTP */
>  	switch (decoded.inner_prot) {
>  	case ICE_RX_PTYPE_INNER_PROT_TCP:
>  	case ICE_RX_PTYPE_INNER_PROT_UDP:
>  	case ICE_RX_PTYPE_INNER_PROT_SCTP:
> -		skb->ip_summed = CHECKSUM_UNNECESSARY;
> -		break;
> -	default:
> -		break;
> +		/* If there is an outer header present that might contain
> +		 * a checksum we need to bump the checksum level by 1 to reflect
> +		 * the fact that we have validated the inner checksum.
> +		 */
> +		return decoded.tunnel_type >= ICE_RX_PTYPE_TUNNEL_IP_GRENAT ?
> +		       ICE_RX_CSUM_LVL_1 : ICE_RX_CSUM_LVL_0;
>  	}
> -	return;
>  
> -checksum_fail:
> -	ring->vsi->back->hw_csum_rx_error++;
> +	return ICE_RX_CSUM_NONE;
> +}
> +
> +/**
> + * ice_rx_csum_into_skb - Indicate in skb if checksum is good
> + * @ring: the ring we care about
> + * @skb: skb currently being received and modified
> + * @rx_desc: the receive descriptor
> + * @ptype: the packet type decoded by hardware
> + */
> +static void
> +ice_rx_csum_into_skb(struct ice_rx_ring *ring, struct sk_buff *skb,
> +		     const union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
> +{
> +	enum ice_rx_csum_status csum_status;
> +
> +	/* check if Rx checksum is enabled */
> +	if (!(ring->netdev->features & NETIF_F_RXCSUM))
> +		return;
> +
> +	csum_status = ice_get_rx_csum_status(rx_desc, ptype);
> +	if (csum_status & ICE_RX_CSUM_ERROR)
> +		ring->vsi->back->hw_csum_rx_error++;
> +
> +	skb->ip_summed = ice_rx_csum_ip_summed(csum_status);
> +	skb->csum_level = ice_rx_csum_lvl(csum_status);
>  }
>  
>  /**
> @@ -229,7 +262,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>  	/* modifies the skb - consumes the enet header */
>  	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
>  
> -	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
> +	ice_rx_csum_into_skb(rx_ring, skb, rx_desc, ptype);
>  
>  	if (rx_ring->ptp_rx)
>  		ice_ptp_rx_hwts_to_skb(rx_ring, rx_desc, skb);
> -- 
> 2.41.0
> 

