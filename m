Return-Path: <bpf+bounces-7701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5951277B725
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 12:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B9B1C20931
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 10:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60094BA2E;
	Mon, 14 Aug 2023 10:57:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2FA9476;
	Mon, 14 Aug 2023 10:57:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F870195;
	Mon, 14 Aug 2023 03:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692010627; x=1723546627;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AWnQCakNxgTq4VluXWJsSBFzw+sK5lj8TUVyEasVdXI=;
  b=ZIsi4SYMox1IG1H2EzZM/MAuILJzOZM+acWPesEnyd9UcGdKywjSYyCA
   NpcPSSPOsUgGiNT3xA9cNStc6jU9HHxGgemh0X+pIdeeWEeg7XHBzpBFQ
   FCHF+y3s5C/UUKrHmvCMqgv0oPRS8h6vCNPJMlSBTV0OBBSq5pdiy9llL
   7DhSh2vCSeiGrp0kEhSFTrfs+l+vmNLjJTCJyW9TtXv+EC1Nmwyx4dJMh
   BY7oRD8GEfC6EXvmmzS0wBd0mZ5iopwuOMsdVwcqsFSPyhmMPUrjWwYb6
   OdbGdPpNSDLUzJx2U7F8azbJ5a+Tc1nS/9zZSxH8SAl16FPcezx9gwByx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="362163877"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="362163877"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 03:57:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="798783858"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="798783858"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2023 03:57:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 03:57:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 03:57:06 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 03:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqT0EOdN0ZufTulqAr/aD8ohhT6aszPQF9TXQcoqS6HPOCjCn8wxK85/T4rM+w+Afsx/ekQuZuvCjY9iqHCz/HflC9lat9v73nxenTiVQvFBd4ToAOFFXNkDDJdHiWmHcAK5qHn4JJB2QbjI0rusTj/uTVUBYOieNyaeweA8wW5RCUVCbck7DFb24Z9OFN/yDafSdqTl+XCbDdwgkkw8ZbRUjo0vOPTpBuBN1407SGCs2ODWPG0s3kUBPKiz0p63/nlj2jGHJInDyWrqIJypQcZm3ntx0j8+QWTSzyQa9jkJdmnev+UxaBuJS17mZE2IhiG8RsaHOp1LwE5vxOnB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQhOv5zEwPx5+VkL2Lcg3TX+rrGZxdSgA8+gBFRaB4Q=;
 b=igpNuKl2137dzOd2F94KV+khtGAv44gII3qDh+hBgB/3uvTbbwGcgI8FYW5PoxQntrcZLdZhfKqgS1HlPhXp+szZCZnboC2A4EfdaKalefNSZzz9R7+9MutLDZG+XE2OOlXFGjjg46XA51OIiBg32vnrIDc22GV5YTcQxLkwRQ5UoBGbxxcXEoWNlq1E+a6h6dPT7db/IZjIs1wus3hMi3rl5dwfNhPGwJehswh5io7VbvqTVkm+OLiM+hgnkvml1ErtmQK9mctmuvmutKWbYDpPLT8PCt5WOeIiRYqwwvdig4MNtEu8mGT/T90cdU1rxkQZO5NBPba5ZQ/NCJJg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA0PR11MB8377.namprd11.prod.outlook.com (2603:10b6:208:487::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.24; Mon, 14 Aug 2023 10:57:04 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 10:57:03 +0000
Date: Mon, 14 Aug 2023 12:56:55 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, <kuba@kernel.org>, <toke@kernel.org>,
	<willemb@google.com>, <dsahern@kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <hawk@kernel.org>, <netdev@vger.kernel.org>,
	<xdp-hints@xdp-project.net>
Subject: Re: [PATCH bpf-next 1/9] xsk: Support XDP_TX_METADATA_LEN
Message-ID: <ZNoIdzdHQV6OUecF@boxer>
References: <20230809165418.2831456-1-sdf@google.com>
 <20230809165418.2831456-2-sdf@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809165418.2831456-2-sdf@google.com>
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA0PR11MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: b158b5b6-a29e-479d-e55c-08db9cb53193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgBJG++AO6bEosEameVM/ga6mr8lho3MgLjNv+EdTtkhOuBjH7SzuWK3bgYNzet6JNKBIHRI6y6mKl41hHoOMYJ+ex06zNWlS7adKc0pzUeqCLF3F/682IdhX352Z9t5QTvWI7vq+9qVCvVwOelygpZgiph+T9wQcPBg13R9FSsqYDK0q56+fas5fPAseb+mofxAdQHdnRAaL95N4kWVnLIvp/kIZ+G6adhzUKKYOviOWrYByIJDpp/7kmD/cxQ/z2FawTo1Kjgu5CkXA5Lo5M3T0XOIuZ/9EPOZKbXfk7FpToYgGf8CFHeneIJZyL3EcTQ4eQu6xHolf75+5kLD7tPY/BJ6e8zjBc0VgwomgaCLE5SJzretZPLbXuPXOs0RlR254nPNS8Pw26gSjMHni7wsUercPqOEzSY89CZw/pVwsxFmUgTT2qr6n8lJ1CWo+S+8b1jeLLq9MsoC2g8rPjwvpQVOHdZv96g7t1G46lyvY+1z+sSE0nFTK2LMEf+ceyUoXkznQXBDUHigLT/c6ygWYw4YfVL+RgOYcq9t5LsvXiYWxvSnQn9YIo3esjen
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(39860400002)(136003)(396003)(366004)(186006)(1800799006)(451199021)(83380400001)(33716001)(86362001)(38100700002)(41300700001)(478600001)(66946007)(6512007)(316002)(66476007)(66556008)(6916009)(8676002)(8936002)(9686003)(5660300002)(4326008)(44832011)(82960400001)(26005)(6506007)(7416002)(6486002)(2906002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?th22BpFEqTCx/fIHaNqjyL2fKSeDw9RBmwpgFNcferzpDDxk7zxnmR4a6E5T?=
 =?us-ascii?Q?nmILpUoRox6f7d58saxVPZ6iFZA0qmscGC4PRxS+TGNWfPTDxfDWRsPMCIMo?=
 =?us-ascii?Q?h8yGIQSLg6IdbWEE/gitHO0I71bDk/hdLbxbFfb9gLimtBP6auA0Gjdl4Bw/?=
 =?us-ascii?Q?9KLSm+fMIBzIOssUhLjpxd0KDOIj3k3rZi6rVu2a0ln47OwsKSqCAygwi5jy?=
 =?us-ascii?Q?0LOfAognHU7a98osKxWBk2RNp5chkrYm+7enXVmdZo91bzzkU+sdbGQ9QX2C?=
 =?us-ascii?Q?aQ1/32C9zmRK6c9X6SYx7LjxXM8buUDYfC4TQTZ1fBdGsGrE+6XJ1Uz/BgwG?=
 =?us-ascii?Q?205wP2FmVuGahM8296rTws5VlxZz6zuvCgBXgPzddAeK6/cxNcS1CCt2LSiN?=
 =?us-ascii?Q?+KjUZbg3OFtply+Z+D1xv0PJRMUxOKIPVOlqxl6yQcNSk9jXnWrFvGk4mYNW?=
 =?us-ascii?Q?aFqv5d0PP6+jVMthBJ89wCWmw7R8SpssIFOMbErXPEKxr67MSfXzfW5yfq8y?=
 =?us-ascii?Q?iSUJBY9jZV7p38A5L/HOzCeQTjlRfcV2mqagq8Af+eKMIkHtu9zV07GlwN00?=
 =?us-ascii?Q?IBHYogCHIPljaMbKt2dd6WGJ3E3cBj6ia+y+PifIN16pwRuIQY74Mu3euxcX?=
 =?us-ascii?Q?fJaiaInk/GxDuhLEvJagkyvd89P+3NJTarB/5e8B5thkm4vevCIW/+cqiESq?=
 =?us-ascii?Q?7bQMjD17ZaFvKG8WifZh8vF6ys7x0wPJ53BV/Cs65aYqfm7Ydl0m4IJSYT3u?=
 =?us-ascii?Q?G91DyTWK7wwNlrYv9n45bEcBs0/WdMX2FIkc/8Kk2HkkPQVPiUv/wB+zNpIO?=
 =?us-ascii?Q?3l4QpkzvppWafNFzW5CdmgzvV8MSZLvnAWkk8DkA2f58APJKNqb2UutLtUpK?=
 =?us-ascii?Q?kMddD8q4J/aAorNCarPxnJxnG25/xybx6Kr53tNAQKn7FatgsEZQLc+OThsI?=
 =?us-ascii?Q?XJygqCIDXY3PAvzmY3+vObvTmBs7EBkeGs1ISfLEyPlkdnlLzpuGOWzblZZS?=
 =?us-ascii?Q?/+5VRA1DU4QT+0JegH7SOMIzZMpe4Tqjpbi82FSomWKC+nZyH3pyF0DTIFm/?=
 =?us-ascii?Q?ZCSp9YS+axRIO6rl2zzd9nkAgcuX5c+1oeCrqSerHppsvF06FCSFy1b2YzpV?=
 =?us-ascii?Q?aebJDuxqzmE/DKl9Ng526ZTpRStE134jJ0rYYSHPp0YdUhkPZZ5nplpB75AY?=
 =?us-ascii?Q?YS8Q7CM3WROTtWbiMHx0CbSfk+xB2Kzgf+CAVpwaUx/gXqGS8rYdH5N5B+AJ?=
 =?us-ascii?Q?hrORupsdgAVKZKl8xggEjSMa9zq6w2zLaEjx5o1Y+khjWKyrj0WLQe92zTCb?=
 =?us-ascii?Q?lQMTj7Pv9oc9aypNjw7j9cnS0STPerrH0vovA5q6lAYwGwSR2kErfC8l78vc?=
 =?us-ascii?Q?tygWBsl/NOCTvXeCacvppJmvp93qEq0PYM2+ZymKdRAQjChivcdW8MlQ5pt4?=
 =?us-ascii?Q?HuvN1p5C00NLricWGG6xL3KrdNBe9ce+jKLt6srkrojGO1oT2JihJP95nBBq?=
 =?us-ascii?Q?MMTykreTJPrx31bK2HH0f7OxrspGFjeJ1/ONmZ0lIIdcYS3hBNaWxM9Uw6u4?=
 =?us-ascii?Q?Nl7d//0pvfdYwLqEFCbaa292KGO+eT1b6SqisVWyR8C9f1FqiNE7DeTTrR/D?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b158b5b6-a29e-479d-e55c-08db9cb53193
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:57:03.9298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCgrUzMnBKjIRs447YjA1efeCU67A11VxwykM23ZPu5Qtr9Sr/bvzB5S4iGumk9QhGB/hC6P7Y9uwldxl1qxSUx3AEbIlBFR/iRbwGPz6Xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8377
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 09:54:10AM -0700, Stanislav Fomichev wrote:
> For zerocopy mode, tx_desc->addr can point to the arbitrary offset
> and carry some TX metadata in the headroom. For copy mode, there
> is no way currently to populate skb metadata.
> 
> Introduce new XDP_TX_METADATA_LEN that indicates how many bytes
> to treat as metadata. Metadata bytes come prior to tx_desc address
> (same as in RX case).
> 
> The size of the metadata has the same constraints as XDP:
> - less than 256 bytes
> - 4-byte aligned
> - non-zero
> 
> This data is not interpreted in any way right now.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/net/xdp_sock.h      |  1 +
>  include/net/xsk_buff_pool.h |  1 +
>  include/uapi/linux/if_xdp.h |  1 +
>  net/xdp/xsk.c               | 20 ++++++++++++++++++++
>  net/xdp/xsk_buff_pool.c     |  1 +
>  net/xdp/xsk_queue.h         | 17 ++++++++++-------
>  6 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 1617af380162..467b9fb56827 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -51,6 +51,7 @@ struct xdp_sock {
>  	struct list_head flush_node;
>  	struct xsk_buff_pool *pool;
>  	u16 queue_id;
> +	u8 tx_metadata_len;
>  	bool zc;
>  	bool sg;
>  	enum {
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index b0bdff26fc88..9c31e8d1e198 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -77,6 +77,7 @@ struct xsk_buff_pool {
>  	u32 chunk_size;
>  	u32 chunk_shift;
>  	u32 frame_len;
> +	u8 tx_metadata_len; /* inherited from xsk_sock */
>  	u8 cached_need_wakeup;
>  	bool uses_need_wakeup;
>  	bool dma_need_sync;
> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> index 8d48863472b9..b37b50102e1c 100644
> --- a/include/uapi/linux/if_xdp.h
> +++ b/include/uapi/linux/if_xdp.h
> @@ -69,6 +69,7 @@ struct xdp_mmap_offsets {
>  #define XDP_UMEM_COMPLETION_RING	6
>  #define XDP_STATISTICS			7
>  #define XDP_OPTIONS			8
> +#define XDP_TX_METADATA_LEN		9
>  
>  struct xdp_umem_reg {
>  	__u64 addr; /* Start of packet data area */
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 47796a5a79b3..28df3280501d 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1338,6 +1338,26 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
>  		mutex_unlock(&xs->mutex);
>  		return err;
>  	}
> +	case XDP_TX_METADATA_LEN:
> +	{
> +		int val;
> +
> +		if (optlen < sizeof(val))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&val, optval, sizeof(val)))
> +			return -EFAULT;
> +		if (!val || val > 256 || val % 4)
> +			return -EINVAL;
> +
> +		mutex_lock(&xs->mutex);
> +		if (xs->state != XSK_READY) {
> +			mutex_unlock(&xs->mutex);
> +			return -EBUSY;
> +		}
> +		xs->tx_metadata_len = val;
> +		mutex_unlock(&xs->mutex);
> +		return 0;
> +	}
>  	default:
>  		break;
>  	}
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index b3f7b310811e..b351732f1032 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -85,6 +85,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>  		XDP_PACKET_HEADROOM;
>  	pool->umem = umem;
>  	pool->addrs = umem->addrs;
> +	pool->tx_metadata_len = xs->tx_metadata_len;

Hey Stan,

what would happen in case when one socket sets pool->tx_metadata_len say
to 16 and the other one that is sharing the pool to 24? If sockets should
and can have different padding, then this will not work unless the
metadata_len is on a per socket level.

>  	INIT_LIST_HEAD(&pool->free_list);
>  	INIT_LIST_HEAD(&pool->xskb_list);
>  	INIT_LIST_HEAD(&pool->xsk_tx_list);
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 13354a1e4280..c74a1372bcb9 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -143,15 +143,17 @@ static inline bool xp_unused_options_set(u32 options)
>  static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>  					    struct xdp_desc *desc)
>  {
> -	u64 offset = desc->addr & (pool->chunk_size - 1);
> +	u64 addr = desc->addr - pool->tx_metadata_len;
> +	u64 len = desc->len + pool->tx_metadata_len;
> +	u64 offset = addr & (pool->chunk_size - 1);
>  
>  	if (!desc->len)
>  		return false;
>  
> -	if (offset + desc->len > pool->chunk_size)
> +	if (offset + len > pool->chunk_size)
>  		return false;
>  
> -	if (desc->addr >= pool->addrs_cnt)
> +	if (addr >= pool->addrs_cnt)
>  		return false;
>  
>  	if (xp_unused_options_set(desc->options))
> @@ -162,16 +164,17 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>  static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
>  					      struct xdp_desc *desc)
>  {
> -	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr);
> +	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr) - pool->tx_metadata_len;
> +	u64 len = desc->len + pool->tx_metadata_len;
>  
>  	if (!desc->len)
>  		return false;
>  
> -	if (desc->len > pool->chunk_size)
> +	if (len > pool->chunk_size)
>  		return false;
>  
> -	if (addr >= pool->addrs_cnt || addr + desc->len > pool->addrs_cnt ||
> -	    xp_desc_crosses_non_contig_pg(pool, addr, desc->len))
> +	if (addr >= pool->addrs_cnt || addr + len > pool->addrs_cnt ||
> +	    xp_desc_crosses_non_contig_pg(pool, addr, len))
>  		return false;
>  
>  	if (xp_unused_options_set(desc->options))
> -- 
> 2.41.0.640.ga95def55d0-goog
> 

