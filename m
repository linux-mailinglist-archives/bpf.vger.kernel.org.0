Return-Path: <bpf+bounces-3486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB12773EBE7
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 22:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EEB280EC0
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 20:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434D6125DA;
	Mon, 26 Jun 2023 20:36:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117EA13AC0
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 20:36:48 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26B0E4D;
	Mon, 26 Jun 2023 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687811807; x=1719347807;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EpXIVl/sMTGdWkvNqtqcriGI+S5B9klQttO6f03fg6I=;
  b=REXr3EU2xpQpREBK3mKF/bNca/6yJE8IMcPFdmgfVP2LkOBTzcSqwtrB
   O04GkyYoY7OZJBrjoth55WqUB2KqZ0jbAhn03loAL4nHtb3RhBZBhyjY6
   1PyoROZBwMmOO5y2FRedUbg07Ad//DKdTKZ/A0dpv/LIh8m6IiBqPUGY+
   UiaQb6ej39VpxRiMzw5iXeLKmCNRn6x3JHt8piWIY4muWjBItYAyy0YMW
   5j5UxuJy2IqvOhEw0CU06CX72XRRTIHMXTI6RIvMYMhcKfuXtVVpkcKYt
   SM16i9GwheyUt034Kq+b2abIqy4c+D8LMgfC+Bqez3gEZTODHzJDu7gkn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="363924884"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="363924884"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 13:36:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="1046642103"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="1046642103"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jun 2023 13:36:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 13:36:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 13:36:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 13:36:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 13:36:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSEgwj9ty5xVX5aevXmhp+wFps5S/LyXL+Kp4LAZJrMZR68TNHbrjA1pVZkLNh/ARfG9L3AqOmrNWk5QRcCX3zg1Zj9u/s5WvHq9F0ulHdFdwheembePwftWScptTDgdVMOwslEREEjRl3areHbT8Wv3gBpRRLzzG4KbkrfBqwARtZSx8Z8s5brBSIV/3Kd1zEDIQyd/xBA9v3KMN3rcfCL9SdJoS5zEmM/CP0Yb3+L/evNpVU7avFOhV/y9GB6okY/ckPBWmZ7SlRhEScXjsHR4xF6khyj8SWefrduW9wnjjzxMnf4hW1U6JQvTrmUN/KtpfIoWKfTQi4usvwfKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5zWWcBitxMAAsXg/oViT2XjxagoXKZcd8ra3h3lC2Y=;
 b=TJiNFK+/xpvQ7O38+9DLRPiMT4lGgi7zXpPhqvD2ZrIV+Bp7VAvPdcJNfH6F9IzvBwq08bZEV/mE6pvatdDH3vl8gD5mqq9GUPLSUPOI8P61kvaaafRDYd+2L26/36wjJtv5oB/Dsd78N8TWTg2qp8XqqCvqg8Sfufc9pQlTBTJYpVqRz3dwV0KgY7MgLg7d8un5Lhl76aHxPPYTHG3ry+GET38wG1TDZc+1HofJnbYM32Ke/BgNv1ELwjpEkJkzMS/suGniWrIVsKEqXof5qLJgC6fHR0D8zT8M9Ld3M2VAqKJyB0WofoFSKTqUNr6QH8SeIrFJh45aETjj/pnDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 20:36:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 20:36:37 +0000
Date: Mon, 26 Jun 2023 13:36:28 -0700
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
Subject: Re: [PATCH v3] lib/test_bpf: Call page_address() on page acquired
 with GFP_KERNEL flag
Message-ID: <6499f6cc97d6e_7517929478@iweiny-mobl.notmuch>
References: <20230622075244.GA426694@sumitra.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230622075244.GA426694@sumitra.com>
X-ClientProxiedBy: BYAPR01CA0042.prod.exchangelabs.com (2603:10b6:a03:94::19)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c96063-038c-43dd-e215-08db768509ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhnOK2M1g3t4HxPCKj3hnZALB0LbtBykr5Ix8xfGiQpLfDxqJZ5osDDyzMYboYAE31HKrDm+SUghhSZHPshmhBM9qvIwWkobIdxCp7iMQZOmqg+1V1cAnCF/Uu/KBkp358Ag1LDgmTj+5NRTergAxggVqahOCYF8Te17PP0KAdF2vP/7SdJ2CG0YglpNTGyhAyd9toh5uDGBagUj/NYfboYRBsI5H4SyqH9q9f80rCzVp9vTTTHDk8Q9+6vSmVm1/EY5l+kW1xFR0s5tMJ7X840Gu/+15uTIa92ZYHK4aFAs91nw+RLQgLeRsQaysD6jtUKDgXPPkq8+OHrCwah8ZBbnvzQHWGM32RNeFUJIbxI2pB9bj/BHbEy+V4H7+aqbTpw2SMR29cGeTCOGI/hOtXXbYKds3M5UUY979/wzvx7Ff5kJsBp9IVrmuek7+cPY+DufhrvAXw/qgJyBQ6LxFBPhsJEfwHo9qx+Y1JZskfoMpOg5Pg7jbKs0uO7SGlA4RfcD27oD5Kak/MHjPJoq2dQggNmmPDQQZH0uA1TKYefL5TjwRDb+5J3PpKEM4uA/grwsQwXlfkSc95DqM/9v1vFT3eanSYlBASOQQbbETRuYfyD88K4VSQ7nmUvIexbb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(6506007)(6486002)(966005)(478600001)(54906003)(6666004)(110136005)(83380400001)(2906002)(6512007)(26005)(186003)(9686003)(5660300002)(7416002)(44832011)(316002)(86362001)(921005)(38100700002)(82960400001)(66946007)(8936002)(8676002)(66476007)(4326008)(41300700001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?20SVV+eScw2b3+niupHrN58kKJbWelESEb9EHAIA5j+fe53+uexmiSJD30zo?=
 =?us-ascii?Q?iPLsFBsqDaTtj7T8PGOYvxdizsEREBEPmEHeoOZ+vvltKfC68NW5rsS4DnLQ?=
 =?us-ascii?Q?gnlUwIXmIvkyPA12dTkFQNtkuCrwtHROUUsIQiHsCaTpyTrJ1XF/9RGUQj6Z?=
 =?us-ascii?Q?0itKYUWYBUgSmwKGHy0UmHWIcoJp68ZOxubxyeGrRiODvkBMZ18fnaN4qK/4?=
 =?us-ascii?Q?FJ7xicSADBM2aYEWmIbL1Jr+O8UP3syXIHyX01aLKQyjQx14RAt85h8MQ9Ss?=
 =?us-ascii?Q?lxk7RFzY1GeDGULsZEazm3mvJ/x8FSIaU0ncar+EWup3kXX0RgjAtNhO2TEY?=
 =?us-ascii?Q?prhqOgyp1Pqsdt/fdAB5oQ6Tm/ewAo++rxyx+DjwCcVACNef3UCaf6XcVPpO?=
 =?us-ascii?Q?fWToYlZgFs5HK6JypYaHzSyR+WG2gazjcP9JvaAo3IIA8ZgCMmPXt5Zo8c4t?=
 =?us-ascii?Q?sOe+WlF8R3WbWK7fi4gdgWc256d+EMlaDpI6vIcjarLZ+itGGkyAfbR/6zkG?=
 =?us-ascii?Q?twRK+tOPYeXopU7/eYp7wAE6A7VQCFB42QP2DSgT0cEpm8bCHyFzMvfDxY4l?=
 =?us-ascii?Q?AxjQkS67dFAjXE5Amklc0dtf+LfjfbjHCjjmpdafsa0Z9iQkSMlhY2KG9kYI?=
 =?us-ascii?Q?1JcgUceqNaRTkaboXtyPcNIGo2+n5iiJfB6Ia58ZtDB10ExQyLZQJ5NJN4Nf?=
 =?us-ascii?Q?95kda2be8y9XVAqUf0SME4V2n0C4PEKpij7ha8J93v9vxXLXVIrKVdS8heti?=
 =?us-ascii?Q?yoLGSmqpHRHjyCfnUvc4m0pTZZfoaTf/+sO6qRTuP+K9IdpcN6ZijC9/y1+O?=
 =?us-ascii?Q?aVCHu3dWIaDr/cgmxJkDrQLc4gBeWqBJqv/7BwfRwGZDSSe63mcVi5nJVxA7?=
 =?us-ascii?Q?G6xSpFZIuHC8z9vEA3lW1zFYcVbt+VkeO37vJJ0Di12T2NGzN2hZ2MIWl5fQ?=
 =?us-ascii?Q?MwdKyZRnhYMIBlMYIxdiB7wpUD+xR5qo40Vhvl0p5a84iUR2fdmXHA8fFRQY?=
 =?us-ascii?Q?J9Fub+JfsktMDWTN9wNGkhTpvtF/Jm4c1tCVjVsnle8O+P7Ypzeu0rwYEV6I?=
 =?us-ascii?Q?gFuH/3UdIKrCG1gL2gTUtM/7ZhbHX8+F/xx6tEuwGQgDTIYFIB7qpKZjSC59?=
 =?us-ascii?Q?WKoVQO2keHZEDVerZdDRcgLT9MrlQPyhGZsFGYZvNFeiQl0r85V25S0m7PXa?=
 =?us-ascii?Q?nhQo/7GdW8eVFP1baAOMYfr/ii3j6YPwKz1JZYTTr7NGWod+GQlnE2+i0twm?=
 =?us-ascii?Q?hr4dpxojFTLzcdGEWXKVZT6tPMaVBnCFRa/Dy8WtS+Z7CJVFx/U4cW595VQ+?=
 =?us-ascii?Q?2J7aUr/fkMm9Yix10jUnobAAIXNl2o1SdGhO+b5gWK2YNVN/mc7IPXWCng30?=
 =?us-ascii?Q?4W8I46JoINy4UgUUWERAOpbfDJhfoSFG4G6Rzf7hFd6dcvsOEI557uwF+jeY?=
 =?us-ascii?Q?F4ezCmc0It9zWtjbzgjDCD/3LH7Pg2HtWVn6QYeR6Lmg5eN9gFPNVQD/5IsL?=
 =?us-ascii?Q?NKibrUB4DGp6cf0gsnOQOXQ3M7g9yi2lFc05ZC7akByQ2rRoQcEkp4Sl5sws?=
 =?us-ascii?Q?kHdY+tQY9SpL2dL4NgqZv+yD1NoFtNfnp3xPiw0n?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c96063-038c-43dd-e215-08db768509ea
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 20:36:37.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TzifbTWf4a0F1S3INoMeIbZGQ5OiuCCzmWlErLoyOIYnFJA+lp2q/dzltp4BfPbvOp0X3ZVXEETXaqZRlB8dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6804
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
> Also, the kmap() is being deprecated in favor of
> kmap_local_page() [1].
> 
> Hence, use a plain page_address() directly.
> 
> Since the page passed to the page_address() is not from the highmem
> zone, the page_address() function will always return a valid kernel
> virtual address and will not return NULL. Hence, remove the check
> 'if (!ptr)'.
> 
> Remove the unused variable 'ptr'.
> 
> [1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny
> @intel.com/

Odd line break here which makes looking at this reference harder.

> 
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>

The code looks good though.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> 
> - Link to v1: https://lore.kernel.org/bpf/20230613073020.GA359792@sumitra.com/T/
> - Link to v2: https://lore.kernel.org/lkml/3564297.R56niFO833@suse/T/
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
> 
>  lib/test_bpf.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index ade9ac672adb..448bc1b0b8b5 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -14381,18 +14381,12 @@ static void *generate_test_data(struct bpf_test *test, int sub)
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
> -- 
> 2.25.1
> 



