Return-Path: <bpf+bounces-9408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E00D79739F
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 17:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412001C20B61
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6CC125DD;
	Thu,  7 Sep 2023 15:28:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B923C3;
	Thu,  7 Sep 2023 15:28:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A38B1FC7;
	Thu,  7 Sep 2023 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694100505; x=1725636505;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JGtvlPAKTsKnVC2mOlQ8jMygOmxSHixqGnZj3cveiRA=;
  b=K2kq5I7ZhQNOcmimlpgBvXpeVRmPo9y9exrICdNGnB0eqnkAZrs3c7sl
   c3/9xqHQ19A/BD0KXCUeGYDZK/MNTERK3tmeJe3CHmgA4VCNOfFpRBkUK
   KiFgBMGzh8ObXKYTT5WRsstu1x3Z9QSdCwZYGdTTEGmkFGzGkcU+lK5Wf
   clw3AF/lGF66o9gBTlEVkmUcWYdVwLJ+UTcLmvSOrrfHfX4mrX79Rox1D
   AFzlof03KlKG0gceB5lb5hope4ZoWnsvl7HBXrmW/1Awc65Dnqxpsh9mt
   QWYMDdl2VEihtSKCWYQx3Wcz4hl/DX1Jz1ACHiR+Y5bCGqg8j3BEMYxxO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="357604646"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="357604646"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 01:12:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="885054334"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="885054334"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 01:12:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 01:12:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 01:12:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 01:12:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 01:12:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMiKnKg4Lu6tNiz/033eGXvWmL+iCVv7/X7G/5sioN4jwN24byOiMOG5QayIYpxyA/he/Om3xXB5i+GlbnGvseeQX8WSjUst9DfNEoA1PeywzCFTF2md8G8N1VeI034B6r4MoZfIER3AhJce5gb8nmMhVZM15LWG8b599w9otjxVV7YGPrwb9nJ/3nLzBxKMwJoSopgGFgQq+It0u7g8upeQhaABMYDq2pCLpBRs41w7O/DKeoGAfS/j78w2c/b1PTpcFfMsEkAE9W02BNhAFKsrE4vPYMCWrfPcoSZ7ot2uMfOwAitJ9Zsef4smxkPoEBG1zgm312CHtkPW2TZ4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlUMjaK/cBQaZG2Ss7j7sVUG2Cx4cNNRsvQCVnOQkLk=;
 b=nIeF9IsfzNLi0c1C8aYgziJEXMDikj05OBzhO6MBFUAE4FFaOMiijTlex8OVeETm9EyR1xL8yGVKtNt17VGfhhXxRISfa0KaJbDgNvO7SqskYvizbiGYIAvTUcEA/uVMN1de6wGzW/bEsCmw9lTu9KY2l39xgeAT9xH1LYfsMG+CYVW1XmNGLQfR47kE63lwrVHFblS2zQc2iK5M+HLML77F+HPDe7bWps7rQEcjVRzXIkXYcwrGUCd+FGX5NUVkz0ybJ0nn3snInrsjPX/OmBnlMMQQBDllRMiK2wL9u+zXRlRg283Zm4itx8dM2Fi5631lmm+4WJpBz9wakwcd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB7270.namprd11.prod.outlook.com (2603:10b6:208:42a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 08:12:55 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 08:12:54 +0000
Date: Thu, 7 Sep 2023 10:12:47 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next] xsk: add multi-buffer support for sockets
 sharing umem
Message-ID: <ZPmF/zJBI0IBkKtS@boxer>
References: <20230907035032.2627879-1-tirthendu.sarkar@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230907035032.2627879-1-tirthendu.sarkar@intel.com>
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa41fda-b790-41d2-92b8-08dbaf7a3d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dt0y3m0+tWF2XzwNieRztQ1MhNI9VimPMVZn3b/lvs3Bz+I/lyzQCfoxqqJ9wSgDCB1thI368FzCRtVimH5hGNQD7i1FuR6liba2ZNkJQcLSCmDEvU9GtTwPkY0ypl6+GD+fsrVU8oJuTC4Q+RtLlOKsGw0FLEgd+f9L+HNme2llZFkg5O6gTRPWAwiEGh1UHuXaWks7cpaitT3iKh8DZ1MJFlBLn87JQB8c40AeB92D/rBGnZMjuk11jfFCqwuRMAmuJTNU0OMeXSZ1e4Q09Uj7f3Gesg2JS+ymhZ65XUrBzqJByAlSI0VB+qKsk5RslcBZ2euHiRU2vCpkxFRx+mfHRHJUUyrHK90ntSyAR1eIHxlYCCyewVux0cRHrJNYNFD7EDlXBjy/y/uk9g9cry2aFyDsU90r2b/IENnLMdf1mNkRxB1BANyAjwv+uBMWP/uYB6RJPlni9EkxFu6G+vFdbZd3e750rVzivt30tqbacEJK8sZZ505EmMmdi78U3e0zvZpGifC1YE40FsL/cmZegelVnzDMgQqa/5+IuOIomyqXceSZfkjZ7YR3gA9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(186009)(451199024)(1800799009)(6666004)(6486002)(6506007)(6512007)(9686003)(478600001)(83380400001)(26005)(2906002)(33716001)(44832011)(66476007)(66556008)(66946007)(6636002)(316002)(41300700001)(6862004)(5660300002)(8676002)(8936002)(4326008)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OXt/4bAf3gFXzpEzQPWs1Ovhkh6eY5jM9I9aKy1giDLG33eFVVxnAqKB2xto?=
 =?us-ascii?Q?kCediSZTQJ7iRArXhYO765EWjW+dDXhCLJcJXUAx9Iwu4aVX9+q601dsIHqF?=
 =?us-ascii?Q?csZrWse3cC69EcMllc5OSK1hRdNl83GAmt5vcpnGj/655r2gRijnS8q486SA?=
 =?us-ascii?Q?4gpqOqg5ykJjrbxRS0Ku36C38whGCguH1LuQybzZKQ68+PByNJ03y77nYkcS?=
 =?us-ascii?Q?1lBIxrRL8wtRYZMoR/lfTHzji1O0w93aKRVvFpT6lez8mFSxxbZnOGQUytw6?=
 =?us-ascii?Q?EoKXyPo6BB74bkrQZx5KVlO2DQPhIWj3kiSW9CQttx6V52OClGWUw1Ddag7t?=
 =?us-ascii?Q?fMIi159edD1eLY6Dcek3DbHeHbiKiN+8ZUmy0IUtnUvK7+TwuBjhhrofODk7?=
 =?us-ascii?Q?wIOG2ZDEKG0leNY0/AqHQRBDBwKqw0T1X+W1MluJft7LZK9mDXM6MELINNLA?=
 =?us-ascii?Q?ItnUbpt9Zp//lTq0V6MSDHMS5qI2ob8Uazljig4qAoFfC6BOspBIymzsNaGJ?=
 =?us-ascii?Q?8+mBlu25/Gnshp0k7KOBIjKd5atLQuwpez3t7CcjNsOGh5ZZ+rp/KyMQqfJu?=
 =?us-ascii?Q?UkQTBik5OW3CnjHe05erQ7LVi9PjIjA8VMfeaBWkI5bFBQWkB/PqC4UDST7c?=
 =?us-ascii?Q?asUhEAy5FvS3jj+uPPjhCB42+FHmQYCyBk7yEfkKJWM/CDswdRbcf0x1NaZ7?=
 =?us-ascii?Q?zo/eIUhF0F5mM/ditYkq+qlFuW/cHDAPL2Ern5bKvcCyjYi8UjIJ21Ry+p+y?=
 =?us-ascii?Q?IfxTyeg3btIGaE9g95fSbYVlee0QvGgOQ7eeIZ+z8ag/vF7r+1EJ9lfcUh9K?=
 =?us-ascii?Q?hZ/kauJW7xpa0jg+s0zGVJzIb/fih5vfBozxu6i8ba9N5KJnMm0jByOR8S+A?=
 =?us-ascii?Q?Wae6y6wZY8VFrz6+IXnOAsvAxqLT08EZ6EMAWfT+dF/SqnpU2+B9Wgw1h7HO?=
 =?us-ascii?Q?O8pwXBcEW9mKymz1sTAYewyq+gqWOfmyAu26i+kjlmhq0LEjV11Wx+YFkDr/?=
 =?us-ascii?Q?tjCxSFOpHnVaKc4rE2oaC9CnTJZ2wOGm+jJwtotdlLlCda8rlyXAwko+0t+K?=
 =?us-ascii?Q?TAQ/GN2h4lao4h+qUdKZ0lZ2zM87MhW33+3JHY4n9xsEMqLYlPXTHQ97FdyB?=
 =?us-ascii?Q?XdGVcS3qgrBk6dQ+wPs0/oJ5VkxCHluL3/Lr8MsnZLla7pV/jXF3dGIwBx9J?=
 =?us-ascii?Q?CuvWLGmHX1uShpwB+T1TPFYAL7rX96pP0vbyrtz7actezXLznyqwSP5zMVOz?=
 =?us-ascii?Q?wYW20Rk3+IJb29y8Gr4rm68K48uOph8ObJNq5dYpx1Z45Vw3OD1/Ny4CK7cS?=
 =?us-ascii?Q?U4KroWngETfE4PohHxLDw0VJrnmm0LpEUCYx2x6VAy/lR6iLpn7PnF0lDI1L?=
 =?us-ascii?Q?Fi2Tr1WLhak15YMqEOsNc+bcWX+xZshMa9SwyfrF9SsZoLmq5odcRluwuqew?=
 =?us-ascii?Q?N1iA16A2mxLK/nwBrsXnztRLwXgwCQWMY+EogS+J/seOvLjDbIP2dhY5vrOa?=
 =?us-ascii?Q?erEA4EQ5k9847W8xx03Qd6kxnxdYryQJUNxe1Yp17Cx8z05XMoziv5of/d70?=
 =?us-ascii?Q?H04tlM3/6UcSwZgV5jpI3bqEdDnY7fX9GVk7B3/f8eSgAmVfzKFAtf71Z28N?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa41fda-b790-41d2-92b8-08dbaf7a3d03
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 08:12:54.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyCj/F5BtBr5eke/m7fUXXr/Lh+dm43qEWMfVoWz2zEml71cPbSKJXs4CmDo0KXeaeYGqmKrK45538QUqFpuI1aUV8tFXxl4QvraY8vKowI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7270
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 07, 2023 at 09:20:32AM +0530, Tirthendu Sarkar wrote:
> Userspace applications indicate their multi-buffer capability to xsk
> using XSK_USE_SG socket bind flag. For sockets using shared umem the
> bind flag may contain XSK_USE_SG only for the first socket. For any
> subsequent socket the only option supported is XDP_SHARED_UMEM.
> 
> Add option XDP_UMEM_SG_FLAG in umem config flags to store the
> multi-buffer handling capability when indicated by XSK_USE_SG option in
> bing flag by the first socket. Use this to derive multi-buffer capability
> for subsequent sockets in xsk core.
> 
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> Fixes: 81470b5c3c66 ("xsk: introduce XSK_USE_SG bind flag for xsk socket")

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  include/net/xdp_sock.h  | 2 ++
>  net/xdp/xsk.c           | 2 +-
>  net/xdp/xsk_buff_pool.c | 3 +++
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 1617af380162..69b472604b86 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -14,6 +14,8 @@
>  #include <linux/mm.h>
>  #include <net/sock.h>
>  
> +#define XDP_UMEM_SG_FLAG (1 << 1)
> +
>  struct net_device;
>  struct xsk_queue;
>  struct xdp_buff;
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 55f8b9b0e06d..7482d0aca504 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1228,7 +1228,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>  
>  	xs->dev = dev;
>  	xs->zc = xs->umem->zc;
> -	xs->sg = !!(flags & XDP_USE_SG);
> +	xs->sg = !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
>  	xs->queue_id = qid;
>  	xp_add_xsk(xs->pool, xs);
>  
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index b3f7b310811e..49cb9f9a09be 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -170,6 +170,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (err)
>  		return err;
>  
> +	if (flags & XDP_USE_SG)
> +		pool->umem->flags |= XDP_UMEM_SG_FLAG;
> +
>  	if (flags & XDP_USE_NEED_WAKEUP)
>  		pool->uses_need_wakeup = true;
>  	/* Tx needs to be explicitly woken up the first time.  Also
> -- 
> 2.34.1
> 

