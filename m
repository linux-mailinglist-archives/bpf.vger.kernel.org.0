Return-Path: <bpf+bounces-9255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BB5792409
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 17:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2972812D6
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DECD539;
	Tue,  5 Sep 2023 15:42:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD13D527;
	Tue,  5 Sep 2023 15:42:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC1BA8;
	Tue,  5 Sep 2023 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693928541; x=1725464541;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tEWofQbdlcJvXX7nhLlol0uA28QS5xwWAU19nF4a9WQ=;
  b=isHQiuwNpcNs1CO4XSNzJN26aGGpV5i8jZQ98OIoSzQ4uoW3LD5f57f0
   KHbKyzmPRlBhgWDroT8SnQK1PiW4b5G2HeRDflki/6ei/0jSZQVj23yN9
   +MC4B3xuwqFnGfzVO0SnWnGSdOCxV1kFEIWxiMkX0VPjijkRzZpF60rQr
   R0DSFXesk+Bxlr9DiuBSkcxsa59sqhyMPoHIFudaEmLfhOZN1ItDa1BaP
   tO406uukui8oZw3oInY7hizgiN8tU0y3jP0kkMxEzqJ+b6reA/TD2oBa2
   3nasmx2IkagS27LIpOF8b24O/gbkkYGGAiva4wU0DcgGGwdwWuEw2Vgkh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375717727"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="375717727"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 08:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="806654953"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="806654953"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 08:42:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 08:42:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 08:42:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 08:42:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGNkVWC4kLavQx93vJiZ1gG0fgeLb3INVixP18W6aMhih65cjrf2upS3LkZ+bmJ/D9oqebd569u/KDtW1jia4sg8fvkzTlHaKTtifzvW4/idGdwlmQNDgRi8c/83nHrsLKQ/GG/pAE+dlK5gCYkrwTSN+hxmK9S9u8B6Xh2ollByzps2rlIh3bcjAprLmRrfQjfRt9+caGN8b6NKCWAkeBKPDWjNKWYbAA6L6OqJJnNzfSU/UvofvY1RwBkUsksZSAzkluBqrMkVvIqPU0amtw42dTlo6/3MZfWhDbV0S6h9YJhGkxZgn7KrNCGZkeoE6gC4zO2CJGPhQVodTmm5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXKBV8k4fPOcrU7NrLkqt7JNnZMnpGrDC02e2aUS+r4=;
 b=l8beqYMx0RvEzAcZssri9i/RpZJc/bibGw/fXYmAf7c2v6/iM044ZEmP1DRFtV/3paYpj41C5r/7Ws2oy/iqhT4qGj554bx1DncdlBv4FsErJkP7g/M/kfl7Tx60ZemBq6BKpabFkl305OjTZ2tIo0uyBKsp2EcJc+JhV5CGLZNjBWMZmTsMGx0FakQtEJtSuPFdNhSjZZ28COg1efN3vShQMbVa9pioIWXJEJhPnBbIxDESZAfRPT0tsgnlWBA4VR6ZpR+w7mebks3E3O0WYG7ERyA7TmtwjUqpWC6tYfXqoGYJ7S03lBR8uhI554UzANnGzYzuDWbf7parTB889Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB7663.namprd11.prod.outlook.com (2603:10b6:510:27c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Tue, 5 Sep 2023 15:42:13 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 15:42:13 +0000
Date: Tue, 5 Sep 2023 17:42:04 +0200
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
Subject: Re: [xdp-hints] [RFC bpf-next 07/23] ice: Support RX hash XDP hint
Message-ID: <ZPdMTG6INvxUV0Jh@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-8-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824192703.712881-8-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR0P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: a587c718-c59a-42d5-a499-08dbae26acb0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4BfjU9+eDufj2Ido83QT3w6ldPL+wREjOcMvM2ZJC9RTGHNGsfZu5OMS5Ht5LIb45OUUBGclUal4OXHDVXE9CV96+O+0P+KiSTE8+wXMueTwBHHvSTXWn0Mz4qlfxFY0N+jJ8xLvq6MnaHhrmVzO2s0+kvL1RdT+iU6CNe0VEMvisAkQ+L3dZH4TKbepzfiVizZRCUMKlAuyrTexot4HwEGdmpxeZtv9Qcdm5lBIAiLWdoM2BftjkvHEOxvhLPvlpM25FGLRS5IOmEY/1KK5zar/3ho/+gxwfLpNBuCG46XESUdYm7fvaZGK6nCnlEpRa+KMM86CjJHb4KwZLIzRFum/VxvudEs/p0wsnt7LT/3RTJb6jEBkU9eXUZTeizCDxTHyIt7doV6U81rVvL5t3g4DLNjhf3M9yAmcxgolG07wllfpPl96AvT8hiGPIxHhnuxGpfmig4EL9RLkrat98KB0XUcyQQam7e66p8U39ucVapInGOahwxEQc2bBCWyiiUlNtTkoNhQD7m6j/Y7RrouDwziJgtPtf8fdlmiBt+mGatYXvMhH8Q6ZTLTrMwfZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199024)(1800799009)(186009)(26005)(6862004)(44832011)(6666004)(8936002)(4326008)(8676002)(83380400001)(5660300002)(6512007)(9686003)(7416002)(6506007)(6486002)(41300700001)(54906003)(66476007)(66946007)(66556008)(86362001)(38100700002)(6636002)(316002)(82960400001)(33716001)(478600001)(2906002)(30864003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3hCNSYZZcC95M2gWj7yrKpw4LopG0Yon08v3RyLDZYhGh38HxQr5z5MHhqxC?=
 =?us-ascii?Q?qjoFsC2k+8LR9GIPHMVLa2aLnaZ5CLuLTjUlzpppdr01pkY566f2ZEWxBBne?=
 =?us-ascii?Q?so8Y4D+ESAHJqx3ZTt4KOnsESKUD2LH2QFIoLQgAUx4qmJNJl5ihO/Ij34Bk?=
 =?us-ascii?Q?cOPGUBU/1RPoYm1C3yRJNulXAQNBPvT7JRx3XD8aeH9piH2RFb26FCgzNBbM?=
 =?us-ascii?Q?KIGfMg0g0HFWj22pNwDf9jv7StrvCJm1R+r+luquM6OPvGRKl9xf3YeSNzZC?=
 =?us-ascii?Q?yQyVGxIFOHtUG65j8sIG+t0w2e1E73ID7OiMFAhjmGikSMHkJEZ4FUlzYJFR?=
 =?us-ascii?Q?2KdjsR32qhItJIClJeOY+cZS8B7znZ12vYKrQOQP0uOFb0yR/wnGJm96EgIg?=
 =?us-ascii?Q?3W3X21TK3vLQ4N8I/K4E5Z6ekR1opuwrsaoiqu6tFwtOvOJWanXxMRw5+4bF?=
 =?us-ascii?Q?RBg330nRx7UlFmf6Ccq+84Os+/WbAf1Nx3jOdx//HW7EgzQ+TxKTno+xzbo1?=
 =?us-ascii?Q?lSR9nQxJDOmvd0KM/FFoD918Qt2XCRBZdpZ6bXOlwy49exo0mwRuoGERl7E0?=
 =?us-ascii?Q?ySmeAej2qApbMdmq+BIyUEFD/bLi0+Y5qNuI62PSKpgqgW1wezQO7ZdfIk05?=
 =?us-ascii?Q?FoW90LS8MQVoYIzjLDrUgENYyWPDkbflbEQxBPOeWECQDn/P5+H+IAtANhbF?=
 =?us-ascii?Q?Bviz+EeoDESQGRQjkDdbcC6urDCY0lJ91djglxKC8+YpJ0yei4O5kyKt1aI8?=
 =?us-ascii?Q?q2HN4Lh4UYQFPKq6/8YZc6m3joU0cOzdXBU6XGel3fCnf+Ih4/JYTvcomugs?=
 =?us-ascii?Q?x/AM0jZ6OCjWEKXnbPWyOP5s/r3uS61VRUdsaWMAoBG6DOH0KOGK0nI412PK?=
 =?us-ascii?Q?zvcQB+yT6SajPDQ16q1pOVksNZ8afME1mn5ZzwZdUCeIe+4NxSpVa6wgEvD6?=
 =?us-ascii?Q?i0JvCuhZiLMgfljz3k5EK8yQykMXOxujLe18VDTl4yNsWtBP8v2NXkF3yyPb?=
 =?us-ascii?Q?jk4yQOtCwAUqLE3HZ1ncg+88GLnrjZC7oLP8ihViwUlvbxb6ZC4y6hV7QllY?=
 =?us-ascii?Q?F4FwK6ZnmGDKGyUo+XBDxvWP9j5SE6hjvkKLK4OyWwjfpJBhG5IPb+uFlu4A?=
 =?us-ascii?Q?U6fa7Tmj8s+Y3/kUyXmiXZvzQa+DBLoVSp4pe1XzQnzuKLYB4rou1Ff+udI2?=
 =?us-ascii?Q?PVXBOuI6HVNfInxIPKhtqFmlx2Pg4ntccDEkueeV9/CW15QK8uCn129AjAWD?=
 =?us-ascii?Q?bD4A+WoSdZACMOXX+AS7XyjGbJb4ad4pgB6zQJTkamDfWWs5pblD/LkP5Qiu?=
 =?us-ascii?Q?2HD3UuWpqLZtK8WGFpM9d5qwCmxl0FMDahVRqhNKpHlnu1UqzM8pkz5Mn0YA?=
 =?us-ascii?Q?fPSmRnA1edqIRRqiNI0ITkQkkd9sXxosE8SAzyiRL9UsdIM+vZTHbR3zEJFO?=
 =?us-ascii?Q?oaTAEqnq1ltj2DWqp34wvaFa+swgYsc2XkXf2dK2MjKylwJsbllGv8BmDi5v?=
 =?us-ascii?Q?UnMaYnXQ0Q9ccEAfsf6wO9auCtXBeYn6nyx1nyfNlkZX88wOr7ObgJFHuG4Z?=
 =?us-ascii?Q?4mQAwecM23xHyRQ1Px3+80Q2CWJVcYrh6QJJKokPzlXKU37B3iGTgJcFpXCH?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a587c718-c59a-42d5-a499-08dbae26acb0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 15:42:13.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3UHv6tSyjntCKCfRYAhm/geJ0T0eNrskO78dfTOLnifjua3aCT/qRuxZcl7Th74YMAkc/8zLjQIfslruQh35VByDJcUHG/WZ25Xzjbgsp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 09:26:46PM +0200, Larysa Zaremba wrote:
> RX hash XDP hint requests both hash value and type.
> Type is XDP-specific, so we need a separate way to map
> these values to the hardware ptypes, so create a lookup table.
> 
> Instead of creating a new long list, reuse contents
> of ice_decode_rx_desc_ptype[] through preprocessor.
> 
> Current hash type enum does not contain ICMP packet type,
> but ice devices support it, so also add a new type into core code.
> 
> Then use previously refactored code and create a function
> that allows XDP code to read RX hash.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 412 +++++++++---------
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  73 ++++
>  include/net/xdp.h                             |   3 +
>  3 files changed, 284 insertions(+), 204 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> index 89f986a75cc8..d384ddfcb83e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> @@ -673,6 +673,212 @@ struct ice_tlan_ctx {
>   *      Use the enum ice_rx_l2_ptype to decode the packet type
>   * ENDIF
>   */
> +#define ICE_PTYPES								\

ERROR: Macros with complex values should be enclosed in parentheses
#34: FILE: drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h:676:
+#define ICE_PTYPES                                                             \

(...)

> +	/* L2 Packet types */							\
> +	ICE_PTT_UNUSED_ENTRY(0),						\
> +	ICE_PTT(1, L2, NONE, NOF, NONE, NONE, NOF, NONE, PAY2),			\
> +	ICE_PTT_UNUSED_ENTRY(2),						\
> +	ICE_PTT_UNUSED_ENTRY(3),						\
> +	ICE_PTT_UNUSED_ENTRY(4),						\
> +	ICE_PTT_UNUSED_ENTRY(5),						\
> +	ICE_PTT(6, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),			\
> +	ICE_PTT(7, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),			\
> +	ICE_PTT_UNUSED_ENTRY(8),						\
> +	ICE_PTT_UNUSED_ENTRY(9),						\
> +	ICE_PTT(10, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),		\
> +	ICE_PTT(11, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),		\
> +	ICE_PTT_UNUSED_ENTRY(12),						\
> +	ICE_PTT_UNUSED_ENTRY(13),						\
> +	ICE_PTT_UNUSED_ENTRY(14),						\
> +	ICE_PTT_UNUSED_ENTRY(15),						\
> +	ICE_PTT_UNUSED_ENTRY(16),						\
> +	ICE_PTT_UNUSED_ENTRY(17),						\
> +	ICE_PTT_UNUSED_ENTRY(18),						\
> +	ICE_PTT_UNUSED_ENTRY(19),						\
> +	ICE_PTT_UNUSED_ENTRY(20),						\
> +	ICE_PTT_UNUSED_ENTRY(21),						\
> +										\
> +	/* Non Tunneled IPv4 */							\
> +	ICE_PTT(22, IP, IPV4, FRG, NONE, NONE, NOF, NONE, PAY3),		\
> +	ICE_PTT(23, IP, IPV4, NOF, NONE, NONE, NOF, NONE, PAY3),		\
> +	ICE_PTT(24, IP, IPV4, NOF, NONE, NONE, NOF, UDP,  PAY4),		\
> +	ICE_PTT_UNUSED_ENTRY(25),						\
> +	ICE_PTT(26, IP, IPV4, NOF, NONE, NONE, NOF, TCP,  PAY4),		\
> +	ICE_PTT(27, IP, IPV4, NOF, NONE, NONE, NOF, SCTP, PAY4),		\
> +	ICE_PTT(28, IP, IPV4, NOF, NONE, NONE, NOF, ICMP, PAY4),		\
> +										\
> +	/* IPv4 --> IPv4 */							\
> +	ICE_PTT(29, IP, IPV4, NOF, IP_IP, IPV4, FRG, NONE, PAY3),		\
> +	ICE_PTT(30, IP, IPV4, NOF, IP_IP, IPV4, NOF, NONE, PAY3),		\
> +	ICE_PTT(31, IP, IPV4, NOF, IP_IP, IPV4, NOF, UDP,  PAY4),		\
> +	ICE_PTT_UNUSED_ENTRY(32),						\
> +	ICE_PTT(33, IP, IPV4, NOF, IP_IP, IPV4, NOF, TCP,  PAY4),		\
> +	ICE_PTT(34, IP, IPV4, NOF, IP_IP, IPV4, NOF, SCTP, PAY4),		\
> +	ICE_PTT(35, IP, IPV4, NOF, IP_IP, IPV4, NOF, ICMP, PAY4),		\
> +										\
> +	/* IPv4 --> IPv6 */							\
> +	ICE_PTT(36, IP, IPV4, NOF, IP_IP, IPV6, FRG, NONE, PAY3),		\
> +	ICE_PTT(37, IP, IPV4, NOF, IP_IP, IPV6, NOF, NONE, PAY3),		\
> +	ICE_PTT(38, IP, IPV4, NOF, IP_IP, IPV6, NOF, UDP,  PAY4),		\
> +	ICE_PTT_UNUSED_ENTRY(39),						\
> +	ICE_PTT(40, IP, IPV4, NOF, IP_IP, IPV6, NOF, TCP,  PAY4),		\
> +	ICE_PTT(41, IP, IPV4, NOF, IP_IP, IPV6, NOF, SCTP, PAY4),		\
> +	ICE_PTT(42, IP, IPV4, NOF, IP_IP, IPV6, NOF, ICMP, PAY4),		\
> +										\
> +	/* IPv4 --> GRE/NAT */							\
> +	ICE_PTT(43, IP, IPV4, NOF, IP_GRENAT, NONE, NOF, NONE, PAY3),		\
> +										\
> +	/* IPv4 --> GRE/NAT --> IPv4 */						\
> +	ICE_PTT(44, IP, IPV4, NOF, IP_GRENAT, IPV4, FRG, NONE, PAY3),		\
> +	ICE_PTT(45, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, NONE, PAY3),		\
> +	ICE_PTT(46, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, UDP,  PAY4),		\
> +	ICE_PTT_UNUSED_ENTRY(47),						\
> +	ICE_PTT(48, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, TCP,  PAY4),		\
> +	ICE_PTT(49, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, SCTP, PAY4),		\
> +	ICE_PTT(50, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, ICMP, PAY4),		\
> +										\
> +	/* IPv4 --> GRE/NAT --> IPv6 */						\
> +	ICE_PTT(51, IP, IPV4, NOF, IP_GRENAT, IPV6, FRG, NONE, PAY3),		\
> +	ICE_PTT(52, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, NONE, PAY3),		\
> +	ICE_PTT(53, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, UDP,  PAY4),		\
> +	ICE_PTT_UNUSED_ENTRY(54),						\
> +	ICE_PTT(55, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, TCP,  PAY4),		\
> +	ICE_PTT(56, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, SCTP, PAY4),		\
> +	ICE_PTT(57, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, ICMP, PAY4),		\
> +										\
> +	/* IPv4 --> GRE/NAT --> MAC */						\
> +	ICE_PTT(58, IP, IPV4, NOF, IP_GRENAT_MAC, NONE, NOF, NONE, PAY3),	\
> +										\
> +	/* IPv4 --> GRE/NAT --> MAC --> IPv4 */					\
> +	ICE_PTT(59, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, FRG, NONE, PAY3),	\
> +	ICE_PTT(60, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, NONE, PAY3),	\
> +	ICE_PTT(61, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, UDP,  PAY4),	\
> +	ICE_PTT_UNUSED_ENTRY(62),						\
> +	ICE_PTT(63, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, TCP,  PAY4),	\
> +	ICE_PTT(64, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, SCTP, PAY4),	\
> +	ICE_PTT(65, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, ICMP, PAY4),	\
> +										\
> +	/* IPv4 --> GRE/NAT -> MAC --> IPv6 */					\
> +	ICE_PTT(66, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, FRG, NONE, PAY3),	\
> +	ICE_PTT(67, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, NONE, PAY3),	\
> +	ICE_PTT(68, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, UDP,  PAY4),	\
> +	ICE_PTT_UNUSED_ENTRY(69),						\
> +	ICE_PTT(70, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, TCP,  PAY4),	\
> +	ICE_PTT(71, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, SCTP, PAY4),	\
> +	ICE_PTT(72, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, ICMP, PAY4),	\
> +										\
> +	/* IPv4 --> GRE/NAT --> MAC/VLAN */					\
> +	ICE_PTT(73, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, NONE, NOF, NONE, PAY3),	\
> +										\
> +	/* IPv4 ---> GRE/NAT -> MAC/VLAN --> IPv4 */				\
> +	ICE_PTT(74, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, FRG, NONE, PAY3),	\
> +	ICE_PTT(75, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, NONE, PAY3),	\
> +	ICE_PTT(76, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, UDP,  PAY4),	\
> +	ICE_PTT_UNUSED_ENTRY(77),						\
> +	ICE_PTT(78, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, TCP,  PAY4),	\
> +	ICE_PTT(79, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, SCTP, PAY4),	\
> +	ICE_PTT(80, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, ICMP, PAY4),	\
> +										\
> +	/* IPv4 -> GRE/NAT -> MAC/VLAN --> IPv6 */				\
> +	ICE_PTT(81, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, FRG, NONE, PAY3),	\
> +	ICE_PTT(82, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, NONE, PAY3),	\
> +	ICE_PTT(83, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, UDP,  PAY4),	\
> +	ICE_PTT_UNUSED_ENTRY(84),						\
> +	ICE_PTT(85, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, TCP,  PAY4),	\
> +	ICE_PTT(86, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, SCTP, PAY4),	\
> +	ICE_PTT(87, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, ICMP, PAY4),	\
> +										\
> +	/* Non Tunneled IPv6 */							\
> +	ICE_PTT(88, IP, IPV6, FRG, NONE, NONE, NOF, NONE, PAY3),		\
> +	ICE_PTT(89, IP, IPV6, NOF, NONE, NONE, NOF, NONE, PAY3),		\
> +	ICE_PTT(90, IP, IPV6, NOF, NONE, NONE, NOF, UDP,  PAY4),		\
> +	ICE_PTT_UNUSED_ENTRY(91),						\
> +	ICE_PTT(92, IP, IPV6, NOF, NONE, NONE, NOF, TCP,  PAY4),		\
> +	ICE_PTT(93, IP, IPV6, NOF, NONE, NONE, NOF, SCTP, PAY4),		\
> +	ICE_PTT(94, IP, IPV6, NOF, NONE, NONE, NOF, ICMP, PAY4),		\
> +										\
> +	/* IPv6 --> IPv4 */							\
> +	ICE_PTT(95, IP, IPV6, NOF, IP_IP, IPV4, FRG, NONE, PAY3),		\
> +	ICE_PTT(96, IP, IPV6, NOF, IP_IP, IPV4, NOF, NONE, PAY3),		\
> +	ICE_PTT(97, IP, IPV6, NOF, IP_IP, IPV4, NOF, UDP,  PAY4),		\
> +	ICE_PTT_UNUSED_ENTRY(98),						\
> +	ICE_PTT(99, IP, IPV6, NOF, IP_IP, IPV4, NOF, TCP,  PAY4),		\
> +	ICE_PTT(100, IP, IPV6, NOF, IP_IP, IPV4, NOF, SCTP, PAY4),		\
> +	ICE_PTT(101, IP, IPV6, NOF, IP_IP, IPV4, NOF, ICMP, PAY4),		\
> +										\
> +	/* IPv6 --> IPv6 */							\
> +	ICE_PTT(102, IP, IPV6, NOF, IP_IP, IPV6, FRG, NONE, PAY3),		\
> +	ICE_PTT(103, IP, IPV6, NOF, IP_IP, IPV6, NOF, NONE, PAY3),		\
> +	ICE_PTT(104, IP, IPV6, NOF, IP_IP, IPV6, NOF, UDP,  PAY4),		\
> +	ICE_PTT_UNUSED_ENTRY(105),						\
> +	ICE_PTT(106, IP, IPV6, NOF, IP_IP, IPV6, NOF, TCP,  PAY4),		\
> +	ICE_PTT(107, IP, IPV6, NOF, IP_IP, IPV6, NOF, SCTP, PAY4),		\
> +	ICE_PTT(108, IP, IPV6, NOF, IP_IP, IPV6, NOF, ICMP, PAY4),		\
> +										\
> +	/* IPv6 --> GRE/NAT */							\
> +	ICE_PTT(109, IP, IPV6, NOF, IP_GRENAT, NONE, NOF, NONE, PAY3),		\
> +										\
> +	/* IPv6 --> GRE/NAT -> IPv4 */						\
> +	ICE_PTT(110, IP, IPV6, NOF, IP_GRENAT, IPV4, FRG, NONE, PAY3),		\
> +	ICE_PTT(111, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, NONE, PAY3),		\
> +	ICE_PTT(112, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, UDP,  PAY4),		\
> +	ICE_PTT_UNUSED_ENTRY(113),						\
> +	ICE_PTT(114, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, TCP,  PAY4),		\
> +	ICE_PTT(115, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, SCTP, PAY4),		\
> +	ICE_PTT(116, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, ICMP, PAY4),		\
> +										\
> +	/* IPv6 --> GRE/NAT -> IPv6 */						\
> +	ICE_PTT(117, IP, IPV6, NOF, IP_GRENAT, IPV6, FRG, NONE, PAY3),		\
> +	ICE_PTT(118, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, NONE, PAY3),		\
> +	ICE_PTT(119, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, UDP,  PAY4),		\
> +	ICE_PTT_UNUSED_ENTRY(120),						\
> +	ICE_PTT(121, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, TCP,  PAY4),		\
> +	ICE_PTT(122, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, SCTP, PAY4),		\
> +	ICE_PTT(123, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, ICMP, PAY4),		\
> +										\
> +	/* IPv6 --> GRE/NAT -> MAC */						\
> +	ICE_PTT(124, IP, IPV6, NOF, IP_GRENAT_MAC, NONE, NOF, NONE, PAY3),	\
> +										\
> +	/* IPv6 --> GRE/NAT -> MAC -> IPv4 */					\
> +	ICE_PTT(125, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, FRG, NONE, PAY3),	\
> +	ICE_PTT(126, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, NONE, PAY3),	\
> +	ICE_PTT(127, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, UDP,  PAY4),	\
> +	ICE_PTT_UNUSED_ENTRY(128),						\
> +	ICE_PTT(129, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, TCP,  PAY4),	\
> +	ICE_PTT(130, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, SCTP, PAY4),	\
> +	ICE_PTT(131, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, ICMP, PAY4),	\
> +										\
> +	/* IPv6 --> GRE/NAT -> MAC -> IPv6 */					\
> +	ICE_PTT(132, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, FRG, NONE, PAY3),	\
> +	ICE_PTT(133, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, NONE, PAY3),	\
> +	ICE_PTT(134, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, UDP,  PAY4),	\
> +	ICE_PTT_UNUSED_ENTRY(135),						\
> +	ICE_PTT(136, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, TCP,  PAY4),	\
> +	ICE_PTT(137, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, SCTP, PAY4),	\
> +	ICE_PTT(138, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, ICMP, PAY4),	\
> +										\
> +	/* IPv6 --> GRE/NAT -> MAC/VLAN */					\
> +	ICE_PTT(139, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, NONE, NOF, NONE, PAY3),	\
> +										\
> +	/* IPv6 --> GRE/NAT -> MAC/VLAN --> IPv4 */				\
> +	ICE_PTT(140, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, FRG, NONE, PAY3),	\
> +	ICE_PTT(141, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, NONE, PAY3),	\
> +	ICE_PTT(142, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, UDP,  PAY4),	\
> +	ICE_PTT_UNUSED_ENTRY(143),						\
> +	ICE_PTT(144, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, TCP,  PAY4),	\
> +	ICE_PTT(145, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, SCTP, PAY4),	\
> +	ICE_PTT(146, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, ICMP, PAY4),	\
> +										\
> +	/* IPv6 --> GRE/NAT -> MAC/VLAN --> IPv6 */				\
> +	ICE_PTT(147, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, FRG, NONE, PAY3),	\
> +	ICE_PTT(148, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, NONE, PAY3),	\
> +	ICE_PTT(149, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, UDP,  PAY4),	\
> +	ICE_PTT_UNUSED_ENTRY(150),						\
> +	ICE_PTT(151, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, TCP,  PAY4),	\
> +	ICE_PTT(152, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, SCTP, PAY4),	\
> +	ICE_PTT(153, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, ICMP, PAY4),
> +
> +#define ICE_NUM_DEFINED_PTYPES	154
>  
>  /* macro to make the table lines short, use explicit indexing with [PTYPE] */
>  #define ICE_PTT(PTYPE, OUTER_IP, OUTER_IP_VER, OUTER_FRAG, T, TE, TEF, I, PL)\
> @@ -695,212 +901,10 @@ struct ice_tlan_ctx {
>  
>  /* Lookup table mapping in the 10-bit HW PTYPE to the bit field for decoding */
>  static const struct ice_rx_ptype_decoded ice_ptype_lkup[BIT(10)] = {
> -	/* L2 Packet types */
> -	ICE_PTT_UNUSED_ENTRY(0),
> -	ICE_PTT(1, L2, NONE, NOF, NONE, NONE, NOF, NONE, PAY2),
> -	ICE_PTT_UNUSED_ENTRY(2),
> -	ICE_PTT_UNUSED_ENTRY(3),
> -	ICE_PTT_UNUSED_ENTRY(4),
> -	ICE_PTT_UNUSED_ENTRY(5),
> -	ICE_PTT(6, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),
> -	ICE_PTT(7, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),
> -	ICE_PTT_UNUSED_ENTRY(8),
> -	ICE_PTT_UNUSED_ENTRY(9),
> -	ICE_PTT(10, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),
> -	ICE_PTT(11, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),
> -	ICE_PTT_UNUSED_ENTRY(12),
> -	ICE_PTT_UNUSED_ENTRY(13),
> -	ICE_PTT_UNUSED_ENTRY(14),
> -	ICE_PTT_UNUSED_ENTRY(15),
> -	ICE_PTT_UNUSED_ENTRY(16),
> -	ICE_PTT_UNUSED_ENTRY(17),
> -	ICE_PTT_UNUSED_ENTRY(18),
> -	ICE_PTT_UNUSED_ENTRY(19),
> -	ICE_PTT_UNUSED_ENTRY(20),
> -	ICE_PTT_UNUSED_ENTRY(21),
> -
> -	/* Non Tunneled IPv4 */
> -	ICE_PTT(22, IP, IPV4, FRG, NONE, NONE, NOF, NONE, PAY3),
> -	ICE_PTT(23, IP, IPV4, NOF, NONE, NONE, NOF, NONE, PAY3),
> -	ICE_PTT(24, IP, IPV4, NOF, NONE, NONE, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(25),
> -	ICE_PTT(26, IP, IPV4, NOF, NONE, NONE, NOF, TCP,  PAY4),
> -	ICE_PTT(27, IP, IPV4, NOF, NONE, NONE, NOF, SCTP, PAY4),
> -	ICE_PTT(28, IP, IPV4, NOF, NONE, NONE, NOF, ICMP, PAY4),
> -
> -	/* IPv4 --> IPv4 */
> -	ICE_PTT(29, IP, IPV4, NOF, IP_IP, IPV4, FRG, NONE, PAY3),
> -	ICE_PTT(30, IP, IPV4, NOF, IP_IP, IPV4, NOF, NONE, PAY3),
> -	ICE_PTT(31, IP, IPV4, NOF, IP_IP, IPV4, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(32),
> -	ICE_PTT(33, IP, IPV4, NOF, IP_IP, IPV4, NOF, TCP,  PAY4),
> -	ICE_PTT(34, IP, IPV4, NOF, IP_IP, IPV4, NOF, SCTP, PAY4),
> -	ICE_PTT(35, IP, IPV4, NOF, IP_IP, IPV4, NOF, ICMP, PAY4),
> -
> -	/* IPv4 --> IPv6 */
> -	ICE_PTT(36, IP, IPV4, NOF, IP_IP, IPV6, FRG, NONE, PAY3),
> -	ICE_PTT(37, IP, IPV4, NOF, IP_IP, IPV6, NOF, NONE, PAY3),
> -	ICE_PTT(38, IP, IPV4, NOF, IP_IP, IPV6, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(39),
> -	ICE_PTT(40, IP, IPV4, NOF, IP_IP, IPV6, NOF, TCP,  PAY4),
> -	ICE_PTT(41, IP, IPV4, NOF, IP_IP, IPV6, NOF, SCTP, PAY4),
> -	ICE_PTT(42, IP, IPV4, NOF, IP_IP, IPV6, NOF, ICMP, PAY4),
> -
> -	/* IPv4 --> GRE/NAT */
> -	ICE_PTT(43, IP, IPV4, NOF, IP_GRENAT, NONE, NOF, NONE, PAY3),
> -
> -	/* IPv4 --> GRE/NAT --> IPv4 */
> -	ICE_PTT(44, IP, IPV4, NOF, IP_GRENAT, IPV4, FRG, NONE, PAY3),
> -	ICE_PTT(45, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, NONE, PAY3),
> -	ICE_PTT(46, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(47),
> -	ICE_PTT(48, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, TCP,  PAY4),
> -	ICE_PTT(49, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, SCTP, PAY4),
> -	ICE_PTT(50, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, ICMP, PAY4),
> -
> -	/* IPv4 --> GRE/NAT --> IPv6 */
> -	ICE_PTT(51, IP, IPV4, NOF, IP_GRENAT, IPV6, FRG, NONE, PAY3),
> -	ICE_PTT(52, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, NONE, PAY3),
> -	ICE_PTT(53, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(54),
> -	ICE_PTT(55, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, TCP,  PAY4),
> -	ICE_PTT(56, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, SCTP, PAY4),
> -	ICE_PTT(57, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, ICMP, PAY4),
> -
> -	/* IPv4 --> GRE/NAT --> MAC */
> -	ICE_PTT(58, IP, IPV4, NOF, IP_GRENAT_MAC, NONE, NOF, NONE, PAY3),
> -
> -	/* IPv4 --> GRE/NAT --> MAC --> IPv4 */
> -	ICE_PTT(59, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, FRG, NONE, PAY3),
> -	ICE_PTT(60, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, NONE, PAY3),
> -	ICE_PTT(61, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(62),
> -	ICE_PTT(63, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, TCP,  PAY4),
> -	ICE_PTT(64, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, SCTP, PAY4),
> -	ICE_PTT(65, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, ICMP, PAY4),
> -
> -	/* IPv4 --> GRE/NAT -> MAC --> IPv6 */
> -	ICE_PTT(66, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, FRG, NONE, PAY3),
> -	ICE_PTT(67, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, NONE, PAY3),
> -	ICE_PTT(68, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(69),
> -	ICE_PTT(70, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, TCP,  PAY4),
> -	ICE_PTT(71, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, SCTP, PAY4),
> -	ICE_PTT(72, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, ICMP, PAY4),
> -
> -	/* IPv4 --> GRE/NAT --> MAC/VLAN */
> -	ICE_PTT(73, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, NONE, NOF, NONE, PAY3),
> -
> -	/* IPv4 ---> GRE/NAT -> MAC/VLAN --> IPv4 */
> -	ICE_PTT(74, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, FRG, NONE, PAY3),
> -	ICE_PTT(75, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, NONE, PAY3),
> -	ICE_PTT(76, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(77),
> -	ICE_PTT(78, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, TCP,  PAY4),
> -	ICE_PTT(79, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, SCTP, PAY4),
> -	ICE_PTT(80, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, ICMP, PAY4),
> -
> -	/* IPv4 -> GRE/NAT -> MAC/VLAN --> IPv6 */
> -	ICE_PTT(81, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, FRG, NONE, PAY3),
> -	ICE_PTT(82, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, NONE, PAY3),
> -	ICE_PTT(83, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(84),
> -	ICE_PTT(85, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, TCP,  PAY4),
> -	ICE_PTT(86, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, SCTP, PAY4),
> -	ICE_PTT(87, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, ICMP, PAY4),
> -
> -	/* Non Tunneled IPv6 */
> -	ICE_PTT(88, IP, IPV6, FRG, NONE, NONE, NOF, NONE, PAY3),
> -	ICE_PTT(89, IP, IPV6, NOF, NONE, NONE, NOF, NONE, PAY3),
> -	ICE_PTT(90, IP, IPV6, NOF, NONE, NONE, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(91),
> -	ICE_PTT(92, IP, IPV6, NOF, NONE, NONE, NOF, TCP,  PAY4),
> -	ICE_PTT(93, IP, IPV6, NOF, NONE, NONE, NOF, SCTP, PAY4),
> -	ICE_PTT(94, IP, IPV6, NOF, NONE, NONE, NOF, ICMP, PAY4),
> -
> -	/* IPv6 --> IPv4 */
> -	ICE_PTT(95, IP, IPV6, NOF, IP_IP, IPV4, FRG, NONE, PAY3),
> -	ICE_PTT(96, IP, IPV6, NOF, IP_IP, IPV4, NOF, NONE, PAY3),
> -	ICE_PTT(97, IP, IPV6, NOF, IP_IP, IPV4, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(98),
> -	ICE_PTT(99, IP, IPV6, NOF, IP_IP, IPV4, NOF, TCP,  PAY4),
> -	ICE_PTT(100, IP, IPV6, NOF, IP_IP, IPV4, NOF, SCTP, PAY4),
> -	ICE_PTT(101, IP, IPV6, NOF, IP_IP, IPV4, NOF, ICMP, PAY4),
> -
> -	/* IPv6 --> IPv6 */
> -	ICE_PTT(102, IP, IPV6, NOF, IP_IP, IPV6, FRG, NONE, PAY3),
> -	ICE_PTT(103, IP, IPV6, NOF, IP_IP, IPV6, NOF, NONE, PAY3),
> -	ICE_PTT(104, IP, IPV6, NOF, IP_IP, IPV6, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(105),
> -	ICE_PTT(106, IP, IPV6, NOF, IP_IP, IPV6, NOF, TCP,  PAY4),
> -	ICE_PTT(107, IP, IPV6, NOF, IP_IP, IPV6, NOF, SCTP, PAY4),
> -	ICE_PTT(108, IP, IPV6, NOF, IP_IP, IPV6, NOF, ICMP, PAY4),
> -
> -	/* IPv6 --> GRE/NAT */
> -	ICE_PTT(109, IP, IPV6, NOF, IP_GRENAT, NONE, NOF, NONE, PAY3),
> -
> -	/* IPv6 --> GRE/NAT -> IPv4 */
> -	ICE_PTT(110, IP, IPV6, NOF, IP_GRENAT, IPV4, FRG, NONE, PAY3),
> -	ICE_PTT(111, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, NONE, PAY3),
> -	ICE_PTT(112, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(113),
> -	ICE_PTT(114, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, TCP,  PAY4),
> -	ICE_PTT(115, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, SCTP, PAY4),
> -	ICE_PTT(116, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, ICMP, PAY4),
> -
> -	/* IPv6 --> GRE/NAT -> IPv6 */
> -	ICE_PTT(117, IP, IPV6, NOF, IP_GRENAT, IPV6, FRG, NONE, PAY3),
> -	ICE_PTT(118, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, NONE, PAY3),
> -	ICE_PTT(119, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(120),
> -	ICE_PTT(121, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, TCP,  PAY4),
> -	ICE_PTT(122, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, SCTP, PAY4),
> -	ICE_PTT(123, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, ICMP, PAY4),
> -
> -	/* IPv6 --> GRE/NAT -> MAC */
> -	ICE_PTT(124, IP, IPV6, NOF, IP_GRENAT_MAC, NONE, NOF, NONE, PAY3),
> -
> -	/* IPv6 --> GRE/NAT -> MAC -> IPv4 */
> -	ICE_PTT(125, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, FRG, NONE, PAY3),
> -	ICE_PTT(126, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, NONE, PAY3),
> -	ICE_PTT(127, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(128),
> -	ICE_PTT(129, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, TCP,  PAY4),
> -	ICE_PTT(130, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, SCTP, PAY4),
> -	ICE_PTT(131, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, ICMP, PAY4),
> -
> -	/* IPv6 --> GRE/NAT -> MAC -> IPv6 */
> -	ICE_PTT(132, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, FRG, NONE, PAY3),
> -	ICE_PTT(133, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, NONE, PAY3),
> -	ICE_PTT(134, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(135),
> -	ICE_PTT(136, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, TCP,  PAY4),
> -	ICE_PTT(137, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, SCTP, PAY4),
> -	ICE_PTT(138, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, ICMP, PAY4),
> -
> -	/* IPv6 --> GRE/NAT -> MAC/VLAN */
> -	ICE_PTT(139, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, NONE, NOF, NONE, PAY3),
> -
> -	/* IPv6 --> GRE/NAT -> MAC/VLAN --> IPv4 */
> -	ICE_PTT(140, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, FRG, NONE, PAY3),
> -	ICE_PTT(141, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, NONE, PAY3),
> -	ICE_PTT(142, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(143),
> -	ICE_PTT(144, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, TCP,  PAY4),
> -	ICE_PTT(145, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, SCTP, PAY4),
> -	ICE_PTT(146, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, ICMP, PAY4),
> -
> -	/* IPv6 --> GRE/NAT -> MAC/VLAN --> IPv6 */
> -	ICE_PTT(147, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, FRG, NONE, PAY3),
> -	ICE_PTT(148, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, NONE, PAY3),
> -	ICE_PTT(149, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, UDP,  PAY4),
> -	ICE_PTT_UNUSED_ENTRY(150),
> -	ICE_PTT(151, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, TCP,  PAY4),
> -	ICE_PTT(152, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, SCTP, PAY4),
> -	ICE_PTT(153, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, ICMP, PAY4),
> +	ICE_PTYPES
>  
>  	/* unused entries */
> -	[154 ... 1023] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
> +	[ICE_NUM_DEFINED_PTYPES ... 1023] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
>  };
>  
>  static inline struct ice_rx_ptype_decoded ice_decode_rx_desc_ptype(u16 ptype)
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 463d9e5cbe05..b11cfaedb81c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -567,6 +567,79 @@ static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
>  	return 0;
>  }
>  
> +/* Define a ptype index -> XDP hash type lookup table.
> + * It uses the same ptype definitions as ice_decode_rx_desc_ptype[],
> + * avoiding possible copy-paste errors.
> + */
> +#undef ICE_PTT
> +#undef ICE_PTT_UNUSED_ENTRY
> +
> +#define ICE_PTT(PTYPE, OUTER_IP, OUTER_IP_VER, OUTER_FRAG, T, TE, TEF, I, PL)\
> +	[PTYPE] = XDP_RSS_L3_##OUTER_IP_VER | XDP_RSS_L4_##I | XDP_RSS_TYPE_##PL
> +
> +#define ICE_PTT_UNUSED_ENTRY(PTYPE) [PTYPE] = 0

ERROR: space prohibited before open square bracket '['
#476: FILE: drivers/net/ethernet/intel/ice/ice_txrx_lib.c:580:
+#define ICE_PTT_UNUSED_ENTRY(PTYPE) [PTYPE] = 0

total: 2 errors, 0 warnings, 0 checks, 525 lines checked

> +
> +/* A few supplementary definitions for when XDP hash types do not coincide
> + * with what can be generated from ptype definitions
> + * by means of preprocessor concatenation.
> + */
> +#define XDP_RSS_L3_NONE		XDP_RSS_TYPE_NONE
> +#define XDP_RSS_L4_NONE		XDP_RSS_TYPE_NONE
> +#define XDP_RSS_TYPE_PAY2	XDP_RSS_TYPE_L2
> +#define XDP_RSS_TYPE_PAY3	XDP_RSS_TYPE_NONE
> +#define XDP_RSS_TYPE_PAY4	XDP_RSS_L4
> +
> +static const enum xdp_rss_hash_type
> +ice_ptype_to_xdp_hash[ICE_NUM_DEFINED_PTYPES] = {
> +	ICE_PTYPES
> +};
> +
> +#undef XDP_RSS_L3_NONE
> +#undef XDP_RSS_L4_NONE
> +#undef XDP_RSS_TYPE_PAY2
> +#undef XDP_RSS_TYPE_PAY3
> +#undef XDP_RSS_TYPE_PAY4
> +
> +#undef ICE_PTT
> +#undef ICE_PTT_UNUSED_ENTRY
> +
> +/**
> + * ice_xdp_rx_hash_type - Get XDP-specific hash type from the RX descriptor
> + * @eop_desc: End of Packet descriptor
> + */
> +static enum xdp_rss_hash_type
> +ice_xdp_rx_hash_type(const union ice_32b_rx_flex_desc *eop_desc)
> +{
> +	u16 ptype = ice_get_ptype(eop_desc);
> +
> +	if (unlikely(ptype >= ICE_NUM_DEFINED_PTYPES))
> +		return 0;
> +
> +	return ice_ptype_to_xdp_hash[ptype];
> +}
> +
> +/**
> + * ice_xdp_rx_hash - RX hash XDP hint handler
> + * @ctx: XDP buff pointer
> + * @hash: hash destination address
> + * @rss_type: XDP hash type destination address
> + *
> + * Copy RX hash (if available) and its type to the destination address.
> + */
> +static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
> +			   enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +
> +	*hash = ice_get_rx_hash(xdp_ext->pkt_ctx.eop_desc);
> +	*rss_type = ice_xdp_rx_hash_type(xdp_ext->pkt_ctx.eop_desc);
> +	if (!likely(*hash))
> +		return -ENODATA;
> +
> +	return 0;
> +}
> +
>  const struct xdp_metadata_ops ice_xdp_md_ops = {
>  	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
> +	.xmo_rx_hash			= ice_xdp_rx_hash,
>  };
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index de08c8e0d134..1e9870d5f025 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -416,6 +416,7 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_L4_UDP		= BIT(5),
>  	XDP_RSS_L4_SCTP		= BIT(6),
>  	XDP_RSS_L4_IPSEC	= BIT(7), /* L4 based hash include IPSEC SPI */
> +	XDP_RSS_L4_ICMP		= BIT(8),
>  
>  	/* Second part: RSS hash type combinations used for driver HW mapping */
>  	XDP_RSS_TYPE_NONE            = 0,
> @@ -431,11 +432,13 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_TYPE_L4_IPV4_UDP     = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_UDP,
>  	XDP_RSS_TYPE_L4_IPV4_SCTP    = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_SCTP,
>  	XDP_RSS_TYPE_L4_IPV4_IPSEC   = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_IPSEC,
> +	XDP_RSS_TYPE_L4_IPV4_ICMP    = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_ICMP,
>  
>  	XDP_RSS_TYPE_L4_IPV6_TCP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_TCP,
>  	XDP_RSS_TYPE_L4_IPV6_UDP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_UDP,
>  	XDP_RSS_TYPE_L4_IPV6_SCTP    = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_SCTP,
>  	XDP_RSS_TYPE_L4_IPV6_IPSEC   = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_IPSEC,
> +	XDP_RSS_TYPE_L4_IPV6_ICMP    = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_ICMP,
>  
>  	XDP_RSS_TYPE_L4_IPV6_TCP_EX  = XDP_RSS_TYPE_L4_IPV6_TCP  | XDP_RSS_L3_DYNHDR,
>  	XDP_RSS_TYPE_L4_IPV6_UDP_EX  = XDP_RSS_TYPE_L4_IPV6_UDP  | XDP_RSS_L3_DYNHDR,
> -- 
> 2.41.0
> 

