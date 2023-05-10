Return-Path: <bpf+bounces-279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A51576FD9B0
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 10:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53DA1C20D02
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DD465C;
	Wed, 10 May 2023 08:41:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32652364
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 08:41:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2103.outbound.protection.outlook.com [40.107.220.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6C6E64
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 01:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErrZlZ3GMu2iK5f2azixALweCgJABlOvUF51Kr2+1+Xo+M274YAHW8by40CcHuago2H+8JUFjm+9jaLRJ6q2T+oLuBOyOPd0F6FlKmHN1O8o8emla9ePcCD46NJ0AQ8FhYkEEhFJjPlx+rl48PHKpQDROpjz0ljWU19XQwnVpvML6jBldaCts5fWfYVhJh/qVhhiWIe7SbVZkieOdXscYEYevHTbPbKGrGtQVWgT97B21GkbBZeMAx16epLwtdc6/aMfdTcnQxc7RAt7KRbjNnywdqqYFUR1+P7yz1LOJMgGqx/Hq/LYgKpsP6diapCaeAci+9sl1twQLLrudFujSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUD+Nvra1qQEAYxEK1ZVbNDxJ+DswsbrlU5wDVlF3pg=;
 b=Xaadu9idbwti0L2sR5+TAoJ487lRW5EmHJVAB6Nv7XlwK7AxRNm30e6sQn0PjoBulcD7Aky+qARrI2CtfHpYyCgHn9oxYjL4eMKAPBoPSaZ4ZkfKwZLG1GHn+ipbUyy1jVCcYbfJNBjTaI9SzbGHU5DT1NxuEN6JzkCfkFZDOlIoIMYgTiYvlNh1/JWvG9pNCgwuZJin0G6j2o/UWxuYrUB3Nx4Xdfcd/1q8vNPxKNUlSs3GdX/7c5h/Ye3eH0RdaSWjLMc1XzNYgZANfs128Xd5ojAkRbGIgdPrl+9Jyu5RsAVcq0iGwdsMlaueF64HbDAXGLlSEJCdz5c/0Fdd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUD+Nvra1qQEAYxEK1ZVbNDxJ+DswsbrlU5wDVlF3pg=;
 b=CYu4MfzALm32Ay2eK5x3ylSe0InOgYOMZshOkAfUKZQYeyu20jM4+spMwGUZ2zGS7WQ4b0MKn5ROQKK6VV4Woy5bI2JVTdwAHUEz6+lPRXmetwdSz1Y1iTfSlU7rtpdS+fBAUR7uVJTsr/iwZvyn/8qh7ZsvQESxgisVAfshBSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA3PR13MB6323.namprd13.prod.outlook.com (2603:10b6:806:39f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 08:40:58 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 08:40:58 +0000
Date: Wed, 10 May 2023 10:40:50 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/2] net: introduce and use
 skb_frag_fill_page_desc()
Message-ID: <ZFtYkmvQ01YxHf9s@corigine.com>
References: <20230509114146.20962-1-linyunsheng@huawei.com>
 <20230509114146.20962-2-linyunsheng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509114146.20962-2-linyunsheng@huawei.com>
X-ClientProxiedBy: AM0PR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::24) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA3PR13MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 570b389a-1886-4e2e-e2dc-08db51324691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iEOEsTA428PVlMVDjlY6IckDUS7Dx+teG7Q1YlwyYs3VILbE5ARtDQAutcxtoKCB7fRnCq9OAy88kuuj4M32C14DT0ZozPyjdf1oMe5xhOxoh9U7skA4NRKhreU/bNsqC+Uir7omcWL9oO70Bn5Kt3cC+OzXzgi7oW3+c+pbcE25a4AH2tKJ5bhF1fCJW2SmOo9yqsDgqxm2MEWUWkcIGdQB1yFpGGFER13aIkLHRH2mMz27J7RLlGYVncXzAn1RQCX303MHvQdaIjtabGmpC4HEo5FQao+xoUYgk+B3WLl9Zv/Yy1kQK/0gMDsSwf4Ev8IhXQdGthlaKO2e/oVdd3NQqhEfCwaQFxXlcq3Ac1a83ikwbmv+wCbw6gHvaeDnJzYWp1FCfuRiFJjtiyBkkMl0VqNXoQMwWVcmzIJsA+GnDd0L0n+Sm9rC4d2gxXD2F2geo+hLil/LZBmglJ2Rar10f7bITrv+9s6voXB9Oexb0P2ZLsc648pbULhsOZKJ8tMH78+ZToMxavzU1P7bJJvKZ+C/k2sWEvNLCfA1P23me6+B/UinDG5QbAQRJHx9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39840400004)(346002)(136003)(451199021)(54906003)(478600001)(83380400001)(86362001)(6666004)(6486002)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(6512007)(186003)(6506007)(2616005)(41300700001)(38100700002)(7416002)(8676002)(8936002)(44832011)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R9iE7M9ODcxd6P8pG2Rcwns0mfcTAYLF8967BVGKmQgHZASuqpR41JjaZM9E?=
 =?us-ascii?Q?M6mnvG40strO3Sf4mpxp62NjAYYy1T4G6z1x1WUNc9R+VwPGSBPZ/z72TZLy?=
 =?us-ascii?Q?ZY8QxnMo22/w8uTxF/NDoXASvrsBYUm5ZD006Wbd2MmreLx6srls/nLJrdIc?=
 =?us-ascii?Q?GvP2OTuMgx/pdm1ZjZmuSNS2fkOGNaXmy2CsJNcVfiauHZSTv6+LwiaXZ3uR?=
 =?us-ascii?Q?MKFJp5rUtbninEcUZVTbgCxwPNVJ23A/+oQtI1qer4SNZMZMYzNuCW3kK89g?=
 =?us-ascii?Q?DeC9byhWiWaZmNk/bR4czDEEGewiLkkC+TLGAzn7EVyQXwBm+nRWfBJmFEIx?=
 =?us-ascii?Q?lqSUsFRzpzH3Rf7M2H8R6LvGFCJs/y/gBXBvUmQ3Vqh9AiSEjNj/khnWWP5q?=
 =?us-ascii?Q?R/Gj0Cjr1KjcypfXrmmhC66V2EEMpHbOjhYxVbnZC58ZAyxdXGY3nPXkqOGd?=
 =?us-ascii?Q?QdrSIAKBuP6IzLB73W6JwSvrg0/SrD04/aMYqL2TRUbiXf6+UlSGxuOQBRD/?=
 =?us-ascii?Q?8BHIRIljdbuvLR/k7LV+TXLY4sT/efDx1Znrf4ojtps1PggPCdhnV1ylhD0g?=
 =?us-ascii?Q?33t/yZxLaIldqHV0kj4JPdy7nZeuYC4S6sA4SuzFTJ1yQkIOnyxnEFN/hx25?=
 =?us-ascii?Q?IwMQ8ya/ecWDCmIGR2YT09VcZDc/BMN6+4wAnk0IDuxPWLd68K9rnb7fw7c7?=
 =?us-ascii?Q?Ez4JnToyIh7tlYLw8nGe5ELA/iBh15pH7gLFBLgiddLxTJSkH2+hIk+kFw2y?=
 =?us-ascii?Q?+QAQnvPPl+36gTuJsJ2rTS/HZVkdMC24Gn50zUiSH+JHtRke3f5BsH1jJzPv?=
 =?us-ascii?Q?mCEiRjfbfZP2zaQya8ECA9UUUc0SxjB3Ahx45SEf13k8BThapJd1cnaIi4vo?=
 =?us-ascii?Q?nRDKaMz8J34fo29mxJiy6zEQHGtndzc7c0Y2u9AiK1XY142tvacSb4X6Yy8O?=
 =?us-ascii?Q?1ukXUnbQIhKmHrZQ3XNEKgZYIAtT8pMqfYnouZTTvCsnXC4l0mPtEg/kLHmX?=
 =?us-ascii?Q?bX5BUmPAdjrpoC9Bwa6A54dI7bDY0tog0KPQZzg+oSLd1nfih5dOmVZyA3zz?=
 =?us-ascii?Q?hdC66WJNEPNrpsR8BfqpzgEeDsEU0mbRwfHtgu0FLyBqS85wUrOhTUS8PN2Z?=
 =?us-ascii?Q?nULeC3BHBXMZV48j/MzX2jm4zpK96f4HxS1yoPoGI+AI0ajKwWxVlWSiKsqq?=
 =?us-ascii?Q?lN7V1r98j5TCZ+zlRGyTZCr3DlLbnN+byeGyRKqcHcdmBktoR8k0X8K2M1RY?=
 =?us-ascii?Q?mZjLw97LTVrW8pHc93wpE9gEP9XYumQslmnpm5rBv7XmqQ/s3BvW+7wYiHc+?=
 =?us-ascii?Q?YZp25DZgOR6pZw11QY/MybgI7wHdbXxWFFvHvpu+dPKN+aJpHP0ZtF7Jj+rd?=
 =?us-ascii?Q?hEptb5u25QGhILjipi0+UEn6Fx+zBGnO/g+Aqf+oeV26SYAlJ5ZWuw9nocLX?=
 =?us-ascii?Q?28krmDY45BPoiISRz9llZSJprEnmxpJGeNq2ahwKedp2NvrPVh3ZLzXl3/CL?=
 =?us-ascii?Q?9941xUtLP2Q4l1FV+RuFymS9mNNXKd8lDIQEkYWosvZFyUdsfkqOd5MXtAk+?=
 =?us-ascii?Q?x2eECfEPC3P4QZp+5HKFioMPY8k0ywm1ckmMjBtH+kqIti+2ONJOJKkr+lub?=
 =?us-ascii?Q?0eChZnoM8TnkbZFyeztkzFcCeVvsWMSQYqwkdsvPtYoe0Vx8tZ19MyIMxT3b?=
 =?us-ascii?Q?+TIMaw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570b389a-1886-4e2e-e2dc-08db51324691
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:40:57.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvXQZ8NZnO/apmNFYCsadA6LuIzoE4gNXwJ9NwxWk8Py1KL5Il3+ZtBM2bJE0YrFTYAq6/kSrITzSjX42+R6YkB4nphDA2AtzhVL7ZlsM4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+ XDP people and ML

On Tue, May 09, 2023 at 07:41:45PM +0800, Yunsheng Lin wrote:
> Most users use __skb_frag_set_page()/skb_frag_off_set()/
> skb_frag_size_set() to fill the page desc for a skb frag.
> 
> Introduce skb_frag_fill_page_desc() to do that.
> 
> net/bpf/test_run.c does not call skb_frag_off_set() to
> set the offset, "copy_from_user(page_address(page), ...)"
> suggest that it is assuming offset to be initialized as
> zero, so call skb_frag_fill_page_desc() with offset being
> zero for this case.

I think the question is, what is the value of bv_offset before this patch.

Lorenzo and Stanislav, do you have any insight here?

> 
> Also, skb_frag_set_page() is not used anymore, so remove
> it.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

...

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 738776ab8838..30be21c7d05f 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2411,6 +2411,15 @@ static inline unsigned int skb_pagelen(const struct sk_buff *skb)
>  	return skb_headlen(skb) + __skb_pagelen(skb);
>  }
>  
> +static inline void skb_frag_fill_page_desc(skb_frag_t *frag,
> +					   struct page *page,
> +					   int off, int size)
> +{
> +	frag->bv_page = page;
> +	frag->bv_offset = off;

Maybe it is slightly nicer to use skb_frag_off_set() here.

> +	skb_frag_size_set(frag, size);
> +}
> +
>  static inline void __skb_fill_page_desc_noacc(struct skb_shared_info *shinfo,
>  					      int i, struct page *page,
>  					      int off, int size)
> @@ -2422,9 +2431,7 @@ static inline void __skb_fill_page_desc_noacc(struct skb_shared_info *shinfo,
>  	 * that not all callers have unique ownership of the page but rely
>  	 * on page_is_pfmemalloc doing the right thing(tm).
>  	 */
> -	frag->bv_page		  = page;
> -	frag->bv_offset		  = off;
> -	skb_frag_size_set(frag, size);
> +	skb_frag_fill_page_desc(frag, page, off, size);
>  }
>  
>  /**
> @@ -3496,20 +3503,6 @@ static inline void __skb_frag_set_page(skb_frag_t *frag, struct page *page)
>  	frag->bv_page = page;
>  }
>  
> -/**
> - * skb_frag_set_page - sets the page contained in a paged fragment of an skb
> - * @skb: the buffer
> - * @f: the fragment offset
> - * @page: the page to set
> - *
> - * Sets the @f'th fragment of @skb to contain @page.
> - */
> -static inline void skb_frag_set_page(struct sk_buff *skb, int f,
> -				     struct page *page)
> -{
> -	__skb_frag_set_page(&skb_shinfo(skb)->frags[f], page);
> -}
> -
>  bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
>  
>  /**
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index e79e3a415ca9..98143b86a9dd 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1415,11 +1415,10 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  			}
>  
>  			frag = &sinfo->frags[sinfo->nr_frags++];
> -			__skb_frag_set_page(frag, page);
>  
>  			data_len = min_t(u32, kattr->test.data_size_in - size,
>  					 PAGE_SIZE);
> -			skb_frag_size_set(frag, data_len);
> +			skb_frag_fill_page_desc(frag, page, 0, data_len);
>  
>  			if (copy_from_user(page_address(page), data_in + size,
>  					   data_len)) {

