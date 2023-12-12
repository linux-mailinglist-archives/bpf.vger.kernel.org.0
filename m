Return-Path: <bpf+bounces-17528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B525280ED4B
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 14:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57970B20B52
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 13:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1056168C;
	Tue, 12 Dec 2023 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjR7sVCo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEA61A5;
	Tue, 12 Dec 2023 05:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702387270; x=1733923270;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rK05nHcymX/xX9cPf/Y7Lsu2ZGkSLuWIaa/Oa5MrTzc=;
  b=fjR7sVCoe+zsN7TEJ9FfpsqnFC0XGkPMA9F2/RCEG3j7KRm/odTkuMYC
   VVlDsZbXse54aiBBMgN+ARFssjFjOo487HUFgNUsAESWqEjU5D5Qm8CBC
   CyNGWMpT32xYLqAI1pn6kA8mWC9wH4Cy1O8C4YT+9aUsSMYqkuK0Dqo6D
   zKZYqHEH0iaYNqAHGRNrE8ot/L3uOsgo6uxyMb1a+F25+4fStWuPbGV7u
   3SL6km3pcjOPl2pjXqtutDVbyM2YksrTMPorTMgX2b0zNl2xQJlmhzcTa
   wLiy8LAt1sKR17h+MD11ygHzS7kyBllGQsWZC7DuKz6KMbnAY9j0/e6WK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="481002642"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="481002642"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 05:21:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="807767284"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="807767284"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 05:21:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 05:21:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 05:21:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 05:21:05 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 05:21:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K11xbLUzRFZ1QdHgh/Vu+Dr0HkomPNOTY092DyRL/X+TPBivu8yfKV8W20/lwoQ6obRe2RBynS9c22LI26z54kGz/obqXW4ODt23trpQePvG+tQ3ezHwvzmba7mFEAmIh5FGAkBu5NB6bnE/xKYzCR6ldoRgwTI22ssfvrhhmoUYkVFILfjxUKBdPuevT8ckQtzD+8IxD8qKLrx0U1p4wUJgDjY2ia0zJY8izOKYXzk0zuqRbPQbMsUYfqxSxaO+v48qsBPGkrHIauEJKj6uuKTkud08DNpAD6qJHpytbSeP8CgMyiP/fWJrpW44RDEzl6MXx8li80u2Ovs0EjHUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrW0HbIx9USnKUG4wAfSyhSV2mR62dr8xZH71f6RLIU=;
 b=JquHFFVxUwogutKz7s1x97t1KJLWNHdCer+zB730He0ZTT3DFMWdJIGWLfwqChe657VkgXZP2EtvVnB00duZAERMzQFJTb8rtrCsa33PMo/QeTGLhFdu0wl4QG6qE9FMKF9nBrS22OHmEZUkHS1TG874E2M69X3pq39bjcppKOO0t9xrSPBPEbVzpiqE/FZk+4K1iO/2v5kgpF3Uk6tpnTn8pp8KjUsPms1+86jKWLFpM5kmhtGV33BzagOXjqLzMW49S/3qNcPNsfXnZm8fO/p+uo/LbzobNoJiYkXYuSfJbcnFwvkENVeDP8O0SKbrKj0kCtj9yo6vmKSLNrdA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB8149.namprd11.prod.outlook.com (2603:10b6:208:447::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Tue, 12 Dec 2023 13:21:02 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 13:21:01 +0000
Date: Tue, 12 Dec 2023 14:20:48 +0100
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
Subject: Re: [PATCH bpf-next v8 08/18] ice: Support XDP hints in AF_XDP ZC
 mode
Message-ID: <ZXheMJYnuxG2ZZZ4@boxer>
References: <20231205210847.28460-1-larysa.zaremba@intel.com>
 <20231205210847.28460-9-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231205210847.28460-9-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 0312599c-aecf-4911-516e-08dbfb152fc7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OivjuIPlfg0cgVviooYyK3tzdA0HEoIUlQuCFvbKgUtXdq91omI65/84Lh97Crbxg5koOhAvply52XXQlY225I56QptyaLeTzWQCFKn2HGzoRP3bGXUeaDpBdT92qLXl9hdqeYQiLwCIJUWYne6GUhMvR1s4uAvfVDJL7qj6Uy13GsU0PCiKYRNGE4kEkIfSbIb/UdGzvKUwp/LvHo9rmohqO3yXKadSvPkLJ8JHMZjKGZeBWiTM7wsRaCT8OCQN4FbUqfW93+/rilLWDHtvJKa82m57+Ix+cJNwqyCII5rd4uibKzgrLoNhs/Oi/FGg798vCIh1tcJBKygrKbznz7eLySOtX5E+F1YqybEUuFqw3+Td6neTsC+R5mxq17lBMpk1cxv90Ix2EBcdNHMxsCZf+CbIxE6q6HWli6g/miNYBspqqQLHzis27N3wOzAtHwXlO8qYUm78CUcyKZqNVmys9jz+rLSlbG2XwRIk3OT0Iut8G6eyUGH3E7XkERt3XNrothwJYfsnVZjHDZxoPGvkPpQF0iw4YINl9w5MiuDAINjvxIpFINGgV96Nm1KP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(136003)(376002)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(82960400001)(66556008)(38100700002)(86362001)(83380400001)(44832011)(5660300002)(6506007)(41300700001)(6512007)(9686003)(7416002)(8676002)(8936002)(6862004)(6486002)(66946007)(66476007)(6636002)(316002)(6666004)(54906003)(4326008)(2906002)(33716001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q00Rfk3gKhTvsSsqedI+pU10z/mYZG0Z6/lZ/LMLIfW6Jd6jBGY4gjcnK9gH?=
 =?us-ascii?Q?HRLVnbSN16Gs9ljchRHSJYFMyOSWJ2qeJlPgqRZSHFB/nMEoM0IJw0femuwX?=
 =?us-ascii?Q?oppwy6c+O/DRwgpNoVtCq8LSpvKeyIVl3X98/9Mj08c2PNfTL/1TkcJ1tpkT?=
 =?us-ascii?Q?dXfT+5x0DzUOW998LC/l0B6Ipg1tIkiMPjDzt9aO+K2rvWSFOYFn4ZTZ6oN/?=
 =?us-ascii?Q?m6E40HPsR1HeA0aw0x+1ExN3OaY4Ts1SCJmW5kUcim+BLTiZNywMub1EhbNG?=
 =?us-ascii?Q?jtXF0snuWb8KStPRMDhvcMP8kGeSZdM36zoxsBv8L4J3kIt3luQWxWTcmGsc?=
 =?us-ascii?Q?8EQFD2CrD8phhZ91xiZZZ7BFIm5660LED4fc2txR0Jsh8MrywrDEiqm45NK+?=
 =?us-ascii?Q?dwBk23J1lMGjEgmivhBMT0aw5qUD6xgXqETe5ABYPddpB/N0F9M8AJGd3y4/?=
 =?us-ascii?Q?AVuBoaxkYl7KpKcxoSlecqPS15LKGFuy1xJs5AxvHfaLVSik2Et9VBeuM4po?=
 =?us-ascii?Q?PRxQDpGSwFmYH9cYHQj1A/EMqni4NwvHEOGcY77CvPFoVNTNCqsTub86PcLV?=
 =?us-ascii?Q?XCc5idGFtuz7Y8xTmVhLMkboIe+PV5u7YjyESJbmMG73u2dDHDOXAMauAl0N?=
 =?us-ascii?Q?KyM8KLguJBG4iNidkEmH1dixx8MhfgfTLXmNTfXEMOh/ZBPT8eHX80Wvms2H?=
 =?us-ascii?Q?U9blRFxnrxyWacpug42N95bwCWq5GJMqxFkAAuKNDW1L5liLIV5Atavhcg1o?=
 =?us-ascii?Q?ySCW0CYFOjUSqAx6uofDgfcZXxVirQiNy+yq9SEahaxsOnQwXWEOWXydcIlN?=
 =?us-ascii?Q?x0L392s6Hjosu1PJSH+18jgHAZOjkCcMVFT7D7vtIM7oCsjmRhm+MddT9XJ6?=
 =?us-ascii?Q?HfR5cqfxrMvf0P3zy7HxVSMdJfy0kq5nk2bUtDXiRjVsxWAeEWDCVwvD6l7p?=
 =?us-ascii?Q?A+g7xsI+2I1mqYkprGmRS0OWPqauH6Qa4c0Gm8XFqPi5HXR3zEQhFYNtAFWu?=
 =?us-ascii?Q?hS5Z3SiTq+4iHwu4N64s2EAbIKsE/eYDl5P5Oml1oWBqR0oWpllk33zpblSa?=
 =?us-ascii?Q?umG6kePVglNOARoMIXvXCXPvgYMUSPrmnryhX6G5RZmp/fp22bSHuHfxFIzF?=
 =?us-ascii?Q?VJzvYzFlaaXiYLR3wgiGAsx43lJntX/tqyP7lr16a64q1dSzeJrwbzP/eyV8?=
 =?us-ascii?Q?BGR13GjbqtMtwLwXOaBZD1+EXx7HsSjSbOQpuf5EegvJDf30zoEckYSYkHWt?=
 =?us-ascii?Q?2GHv/oXC0m89mbVGY38Sj7J7Ie1pXntRaqcYPqICsaqD1e4dJrqqXSP2ouCb?=
 =?us-ascii?Q?CqP4OwyF7LogHvUb677+yiXmRMDjq9RENhZWz9RAGm95Q2xJz2mz9R+A6mlS?=
 =?us-ascii?Q?VTVplck2nFqTlCTHNfnru8m1FV0aFOZv8vvWu3uJP772vgDSDnY5T555slqe?=
 =?us-ascii?Q?EIJYJcfMsVGzSwuaQcouwHt5rUGp8kUppfK2Z7zgfvxJK5aPnpYqH3Ls3ZNq?=
 =?us-ascii?Q?SH8ktdkXliOKjufOVKYMA/WAIhnn3aHQ/cucH57dgbewGLvij8BCPiugDSPh?=
 =?us-ascii?Q?hF0pR7bex/fb8hsDT8WXiF1jdHF08/hCvia4Tf529iLmKmN1ac744UUAT+/1?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0312599c-aecf-4911-516e-08dbfb152fc7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 13:21:01.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZSoiorU10u5tZwnvvU88bMyJWHCvZ1x70SUU6neU/TPdxV0rK0gjseNfS3M9CYM1HpdFQK95iWn8xQ8jBKkD/ax96KvTfGlrvoqdbcUBoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8149
X-OriginatorOrg: intel.com

On Tue, Dec 05, 2023 at 10:08:37PM +0100, Larysa Zaremba wrote:
> In AF_XDP ZC, xdp_buff is not stored on ring,
> instead it is provided by xsk_buff_pool.
> Space for metadata sources right after such buffers was already reserved
> in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
> 
> Some things (such as pointer to packet context) do not change on a
> per-packet basis, so they can be set at the same time as RX queue info.
> On the other hand, RX descriptor is unique for each packet, but is already
> known when setting DMA addresses. This minimizes performance impact of
> hints on regular packet processing.
> 
> Update AF_XDP ZC packet processing to support XDP hints.
> 
> Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Not sure if I am supposed/allowed to provide review here, but:

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

LGTM

> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 14 ++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_xsk.c  |  5 +++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index 2d83f3c029e7..a040f02a342e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -519,6 +519,19 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
>  	return 0;
>  }
>  
> +static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
> +{
> +	void *ctx_ptr = &ring->pkt_ctx;
> +	struct xsk_cb_desc desc = {};
> +
> +	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
> +	desc.src = &ctx_ptr;
> +	desc.off = offsetof(struct ice_xdp_buff, pkt_ctx) -
> +		   sizeof(struct xdp_buff);
> +	desc.bytes = sizeof(ctx_ptr);
> +	xsk_pool_fill_cb(ring->xsk_pool, &desc);
> +}
> +
>  /**
>   * ice_vsi_cfg_rxq - Configure an Rx queue
>   * @ring: the ring being configured
> @@ -553,6 +566,7 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>  			if (err)
>  				return err;
>  			xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
> +			ice_xsk_pool_fill_cb(ring);
>  
>  			dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
>  				 ring->q_index);
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 906e383e864a..11b6114ab83d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -458,6 +458,11 @@ static u16 ice_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
>  		rx_desc->read.pkt_addr = cpu_to_le64(dma);
>  		rx_desc->wb.status_error0 = 0;
>  
> +		/* Put private info that changes on a per-packet basis
> +		 * into xdp_buff_xsk->cb.
> +		 */
> +		ice_xdp_meta_set_desc(*xdp, rx_desc);
> +
>  		rx_desc++;
>  		xdp++;
>  	}
> -- 
> 2.41.0
> 

