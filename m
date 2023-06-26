Return-Path: <bpf+bounces-3487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5F873EC02
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 22:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CBE280CD2
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 20:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC913AE5;
	Mon, 26 Jun 2023 20:44:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A94125DA
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 20:44:29 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5FD1FD6;
	Mon, 26 Jun 2023 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687812238; x=1719348238;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fINTmjPnfofdpD4yxpkX04xhMstpIaVT5aJ4vODofL0=;
  b=IjbDe7YD0VSVDWIWpX8KPqROJewGndM2wvl1qylp9MBlL54nfFNk8rGr
   0SpO1K/yKT9hxk6n7NGKCoLJfCggSNyCxsJDgqzrVScPjOPkU+GmKemwo
   v/4durw0rQ4PlLYuRKPpi2z3Tdj0s2I3+8LhqaY7/j6hNmu6rJ1v2jRJm
   xIg7Xz4n5cZ+CTYudGUUBywSzVbU3/4uS7VKYfQ+sV1J3l5WqDVstNPGP
   iMrcjhfTq2IeiTvIa5UinpIphA5F1IuixNpgOtB11rRuXdOO7e+iUPmpR
   Hcijw/ZjuUw9JxT20fcd0NvgWG8H9S/DLcFlhtlhxSdkXqH9rB3jfnYQA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="364832239"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="364832239"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 13:43:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="666431990"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="666431990"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 26 Jun 2023 13:43:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 13:43:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 13:43:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 13:43:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2lUsyP86o+fe6HQQ1/YGcKi0rZWPF2qQ5dRAUxgpdjlVCLJmoLEaJ1OtGoUV6HoD9mnUEccwgeXUrtdafQY7i9jSrfYzpLAGyi1VxF8Oi3AMTdGj77WNFpoJ5MAe0GT8FEkahSdr5eByDC+CaFBDQecw+Jk+Zkjhw+CCo5xJgM083pq6vcKulI8FS/ovZG+7BdNa+2KJlUeClvLzWdfTybUBxhg0Lc3MQtDR+elJf+Oiv2SEG8kIJipTqJJkKkyEzmbdKgsDJEjMgV+skQtzRCxJ46AhXNsOyhvhx2YFD/CuZ54FQRSYSC6JXaQi8jwfvEhCq62N3xeFXvTaA93JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqwONMrcbt0c2EkZJO1K2YIg7PRDrfGozZLn3nwudHI=;
 b=L4rmrbqaUWzBvPfVE/01waY1IkSFnya8ENdrlG8ajDVNCb7Ob9bHO8lznsEzo9JLj0jyC3PJ1e7ZJI7Xqsme/WYP1781n0n4CGIcYODMEHzLLqmwkrqFsLuiEjtvc39NoEpFn3w/rKx5fZYsc4IrjmzMjabW+fPAFOCB3yexFoKxae7Kbovfhm1ZSZwSkxpsHvLHOgn9RV08wJv6w+jhXr9ne1Pva7MbC5UYfLsaUcluMP1ZeQMqGpZHeC/njxfQQnhTJkI3iwBPgMy56mo/j0nIKclOSiXu9vh6vSkcboloUI9QeGVDwgsBihGaRezS5OdeS1iDTwRYgDWo/XU3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 20:43:20 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 20:43:20 +0000
Date: Mon, 26 Jun 2023 13:43:13 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Sumitra Sharma <sumitraartsy@gmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>, "Deepak
 R Varma" <drv@mailo.com>, Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: [PATCH v4] lib/test_bpf: Call page_address() on page acquired
 with GFP_KERNEL flag
Message-ID: <6499f861360a1_7517929481@iweiny-mobl.notmuch>
References: <20230623151644.GA434468@sumitra.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230623151644.GA434468@sumitra.com>
X-ClientProxiedBy: SJ0PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:a03:338::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed4b3a8-aba7-4a5c-d86d-08db7685fa08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSHQCbGj4oRamXrwriT0EEN7jTAz/X1LTCkAxhoJt/Yml0SrSyLHn4whhG1ntFxgkWVnQfxxCkRm8wBtlvdWzL6zN5Hgvw6bquSc+1wLyUKvkQzZ5yqeDiMCj5+jbVD1ckwpgrj4M4cPZ5cu5mqdCDxbF633xo2EMtShal1B17Yss4PS2t+J1BsrDVKcW0fyb2y5duikHgLkcr/6zuPrISo4uartuSRggNQOyHD1aU4QF8reVpdatP7Ir9ScVBtwk9bzaqzBzSMV1zuegzfBJE645sh6uKrhTYKRvwmiV+wBjiAbUtHwGaFS6XQhMhhwxEs7XXjyJApEwLpKoYAzMT31Wqk4reBFwzMMBKsu/54IfPSaAagtwTESyggLVHBmctq+wHyjUdfxyv2wO2E1PvEWU6aWEHKmjAoN1wnEPEdQfcU0/aM3Dxkgl+EmBYx+c/2u9m8W5dEe1K5BDSZijC4WEQcPS3imdgk6cYNorHSydJ8XRz7kJ7oDBiYs8RIHNU1bmdFBUq6n8BJj2BREJn4gkdIUlHgR9OxHmR28hEqN9VYQLkt2x2/Rket/f6zrT9RPiotbvMNtwjCMypVJWWZ07InnfEuWQ5i1UPOoCxnTEuSyISmBEzpDwJKuip8q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(26005)(6486002)(966005)(478600001)(6666004)(54906003)(110136005)(83380400001)(6512007)(2906002)(6506007)(186003)(5660300002)(44832011)(921005)(7416002)(316002)(38100700002)(9686003)(82960400001)(66556008)(8676002)(66946007)(8936002)(4326008)(41300700001)(86362001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WZ7Nfr7sADaAdVCM9RSBwx1awbdqPCPX2Xn0NIdiDZW7HvEKqHoQbWtolccq?=
 =?us-ascii?Q?Rrtlik3vMb/D8m76QezQzMMG83JjqZPclf12dYKZlbOxqK7b2JWZNuqVfm/O?=
 =?us-ascii?Q?qZFccDWd/WQNWcHdpsHRjzleML/VFuRipzuIM7n+WxnaFHBsJbfiHGPnAwv1?=
 =?us-ascii?Q?rBdOvvabx/xnknUBO/EPZ3fzaYYmOPWnSlH2azuh6aYZpGS5PSFee2gy3mMi?=
 =?us-ascii?Q?8iV8z3JBnjZhc8DJYlmVNBA8jSP1rMSMkbyhIHHruwI1/9D5zR+aOBWcyEfE?=
 =?us-ascii?Q?sSUhCigTHm66TlXfOdLbEV78EbJ3tITEI+PlcI6CT6PcTyzsDA9cPd7Zn+6X?=
 =?us-ascii?Q?u3ujVF4K7R+z6qFZaaL90B/zi7IpvHd0ewKJGvarSqmLz0oN3lJ+kT6K6FUA?=
 =?us-ascii?Q?Ti08a3MDEWjs6YhCDMqcchkTieKbhCCsuJG6/fSilyBcu3W3Q58M/Sj/qKZo?=
 =?us-ascii?Q?mnMWqm+oMWuBBw7UjVyFcKo+yInOoKHQcLfgcubZm7jhyREQzu7qKqUv7drz?=
 =?us-ascii?Q?IphBkHZFNRyTR6Ti4yNUGaqIqaqMRM8KHvNgKW2hxAULIQ9JVKIP+8whxwLr?=
 =?us-ascii?Q?MqQY6wgpv6DMd3dfOZMMQixaP3T7wQNZ25LM6Qo2cbe4fQsRkC3qoOiiQXp1?=
 =?us-ascii?Q?8qmEcJZELHA1CqbFbcLP7BA46/uiNlumYr5sE1JtKSJctQEkOOlZtHB72coA?=
 =?us-ascii?Q?2LEoS06sFZhwnWTcnyTsq2KYd78V5iR8NCJ1Asmg7OYXteG34uPkb3/adIhJ?=
 =?us-ascii?Q?f+MmbxtnAgvGZVNSFlaIUJx5+FLmgZ+8n0GVX5I/5RoPub2rG+A/qKl9q4OL?=
 =?us-ascii?Q?A0JtumKLGEHNxEvS2XxojJHyTDfLpqZDdA3T7WlFus/5h63jwRkz2jIXEzFQ?=
 =?us-ascii?Q?0kWJOLjPrBKGQzn7nC5nHKIgYXHL2zojZtxczUPkbZkB0qJ5djlo+vAzw7Xm?=
 =?us-ascii?Q?IuBjjNy5oTBccVBVu5MAQ9IsXTqXlly7b/HCez+4UJWSfW5Hl87PFTAwI7Hk?=
 =?us-ascii?Q?gXCGEiAvgv/EXeglCUCG/pRjCDURD10RHkSx/NiGuQ3Hrcc7iuEMXPqT1l1L?=
 =?us-ascii?Q?asJ2GbgKopAzRK8JhopfCSdO12IVfQ+oGOzfGKgWiOaGyupMvxT50ZhzsnuZ?=
 =?us-ascii?Q?IDxYxdkfOqDFTZLYZgOyRPgWOtkiuXtygT3J2mWMRcbdvZ9ntS42jVoy+ZDK?=
 =?us-ascii?Q?kqytsZqYmExH/XFirpT1b5/n92oeiU1lccot4BVpnSAd3bm8xxONLtkMHuld?=
 =?us-ascii?Q?4OdkInDkCiCdlfqodviXLmXIySPVkgls4i5S3z5AJffffCX7GlqPwq+1YG63?=
 =?us-ascii?Q?jlSoOFA5bkTIxoZ92AI7LjGUWqED2ezroPA8Qs2KZwRwtHWmQdGVcrVqKjsn?=
 =?us-ascii?Q?mf1YGgfPSmc9h493gAHgqGCIqctCsI2LIzBypGK5rPmFUpOZsviMDnZJGF0n?=
 =?us-ascii?Q?jFgRcHonKqUJDxvVwBUpVa2Ewf0fnvUD6xPBO09imS9swTLYwizMA0C7N9RI?=
 =?us-ascii?Q?dcl7ueOAOFL+D3IXMW+oBqyRDmO3nhG646ohySK5U+47PfBUYYMAedoNvwNv?=
 =?us-ascii?Q?vMvZkhW37/vlGyTDtVjdT8UwOu0bhbT5bdqTDTo9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed4b3a8-aba7-4a5c-d86d-08db7685fa08
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 20:43:20.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgXxtS9z1wa4gwAazwAxA9F3HR1o1jZxp8TVSFap1dfea6i0LO/azVq/wzzWZGSew3oigzkOWvbOqAX8/HLyTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sumitra Sharma wrote:
> generate_test_data() acquires a page with alloc_page(GFP_KERNEL).
> The GFP_KERNEL is typical for kernel-internal allocations.
> The caller requires ZONE_NORMAL or a lower zone for direct access.
> 
> Therefore the page cannot come from ZONE_HIGHMEM. Thus there's
> no need to map it with kmap().
> 
> Also, the kmap() is being deprecated in favor of kmap_local_page() [1].
> 
> Hence, use a plain page_address() directly.
> 
> Since the page passed to the page_address() is not from the highmem
> zone, the page_address() function will always return a valid kernel
> virtual address and will not return NULL. Hence, remove the check
> 'if (!ptr)'.
> 
> Remove the unused variable 'ptr' and label 'err_free_page'.
> 
> [1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/
> 
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>

Just saw the report from kernel bot...

Better on this version than I saw before!  :-D

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> 
> - Link to v1: https://lore.kernel.org/bpf/20230613073020.GA359792@sumitra.com/T/
> - Link to v2: https://lore.kernel.org/all/20230613071756.GA359746@sumitra.com/
> - Link to v3: https://lore.kernel.org/all/20230622080729.GA426913@sumitra.com/
> 
> Changes in v4:
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306230559.hU5Aonpl-lkp@intel.com/
> 	- Remove unused label 'err_free_page'.
> 
> Changes in v3:
> Noted by: Fabio M. De Francesco<fmdefrancesco@gmail.com>
> 	- Remove the check 'if (!ptr)'.
> 	- Remove the unused variable 'ptr'.
> 	- Change the commit message.
> 
> Changes in v2:
> Noted by: Fabio M. De Francesco<fmdefrancesco@gmail.com>
> 	- Remove the kmap() call and call page_address() instead.
> 	- Change the commit subject and message.
> 
>  lib/test_bpf.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index ade9ac672adb..a5cc5f9fc4e8 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -14381,25 +14381,17 @@ static void *generate_test_data(struct bpf_test *test, int sub)
>  		 * single fragment to the skb, filled with
>  		 * test->frag_data.
>  		 */
> -		void *ptr;
> -
>  		page = alloc_page(GFP_KERNEL);
>  
>  		if (!page)
>  			goto err_kfree_skb;
>  
> -		ptr = kmap(page);
> -		if (!ptr)
> -			goto err_free_page;
> -		memcpy(ptr, test->frag_data, MAX_DATA);
> -		kunmap(page);
> +		memcpy(page_address(page), test->frag_data, MAX_DATA);
>  		skb_add_rx_frag(skb, 0, page, 0, MAX_DATA, MAX_DATA);
>  	}
>  
>  	return skb;
>  
> -err_free_page:
> -	__free_page(page);
>  err_kfree_skb:
>  	kfree_skb(skb);
>  	return NULL;
> -- 
> 2.25.1
> 



