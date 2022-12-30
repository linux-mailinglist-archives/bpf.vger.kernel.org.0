Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA39659CDB
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 23:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbiL3Wb1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Dec 2022 17:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbiL3Wb1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Dec 2022 17:31:27 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FC31900C;
        Fri, 30 Dec 2022 14:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672439486; x=1703975486;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=mpGgs7fzMR99yndRsm69nhZtqX2QATLL6vt3quz+VVA=;
  b=J77NIR8AgLHcgM+sgpl6glGwIaDmYKgsPKn25ivGcSDnL061nnTvlJwB
   js3YBofanfjhVFcyDUoRpdV60VTqT2fl/qX2JJ8nrjoxPxOR57apCw8rt
   qmqEfH9UcrJts9xZsBgWa2YE2RpbYFAHTcMusgflStg0x5bWcN5yJ0Lpc
   IRFOwEIFuhj9ob1O7BYGvsu/8+cMYtrZBOaEQI5wSQ+UJ0nrvF9921L13
   3WppNIbBgCGvtKIfbswL+CdaSUHkPKbtGer72j+SQU626u3vVQ9keNfrP
   SI4mO+Vn57gi+xWKRlSNfDB9TkZfmU0Ef8yAcQa+EmGERXTe1ItRNTWZs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="383559512"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="383559512"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 14:31:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="686361169"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="686361169"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 30 Dec 2022 14:31:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 30 Dec 2022 14:31:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 30 Dec 2022 14:31:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 30 Dec 2022 14:31:24 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 30 Dec 2022 14:31:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixgGwFOu7iVnkg28Mb1ds8UTCAd7Ja3DSsAzr+iWbknikYLbp4i6R6Lx5c20VsSB9KWrdgjJz5QRdqPPeKJVMHEG2+20Iz+WpeD43lfR04BvPn7HPUs3ux+VPPF1OhLn2GtcRfkYSyDHB28MltPZlXFr9qUToovGzgtX65ZZnRRW5gmZTh1kIdtgRtkVVZeLyJAAAO/b6zLpzVrCe4VO5FVk3895u7YtA11m/cZtlC0EumcyzuoC0xElGoxLHbEUQh1jONfLhzcwbc5VCNMH9Xb0nIOXLWXjFh/gRz/50FsScQ+tjj4zQKdrS1Ymx5Jjoc+7qRTCBiNDP/yd5bf6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0H2TDQWKPHX1T6I18TBSE0tL5WfywlG+EkMskUdZA3Q=;
 b=SR3miOjGxUZVeRqtPzx8ayp912Ic1ErQ/qSsSiJxUAlpRIaKUKkGuW52AraAjTsY2knJdPISAxbn9T34c7UrJms6j9u9dZW7PFTUB113F1+xjUPYhZA9V97Mvda0YDpASFuOW0M3Ub2M1FXksxAffLvAKj5W8igL4FfzUjvMEd/XDDqb9kkxkE1fvXZedWaWbG/HdUTxQcYWyhkm4qwJAlLv3Uc9PGJNGMaMyn96VrEAMtqKCeq/0Cw0lIPbmToV3F71+sIkaa7iqygq/0gMcwSAARVA0Wl1VcoWOGF5+bXmDl8O1QTlggxH2hjCvEr290OU8XovNTZ/FAxLcaZH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 22:31:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%7]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 22:31:21 +0000
Date:   Fri, 30 Dec 2022 14:31:17 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Nicolas Pitre <nico@fluxnic.net>,
        Christian Brauner <brauner@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Subject: Re: [PATCH] fs/cramfs: Convert kmap() to kmap_local_data()
Message-ID: <Y69mtbmmbDcXhiln@iweiny-desk3>
References: <20221012091356.16632-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221012091356.16632-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BYAPR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:a03:114::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ1PR11MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 3147af90-fb0a-41ca-e12c-08daeab5939e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3y8ceXaoONKi6vzTyYVxAQbWODUAQ8DH90EsD6qWlsqPnMbWojoh/rEWo0StLX6OrjSv6A035vAtQ5JqBKau+HoPHXDtlnVhQsagToL8QKflCCWL4zaPUnos3MCVKDMATWGJQOazJkah9vcgGffuRaqvgArGYVUdfvtk5XjVevyBZWDxTMooi2j7smlcJRsb3xhISEAdXB/90G4kJH/rMXXq09mEhrf68OlVT799wtoe2QHRpixIN/0cLfKrXWCH3+i+jUq0itoihMdjEdqautfbmQtlD5qD/UJJe9mt2dHwtk6N9pl89I+8OwTbFxi8m02oxAZPTXdr7zzWoMxS1OSOjAGl3RB/beBZoZFRAZ1r5Vn2N1OC11Mb1pfEZ4mQHHBvR7jSPDzEjpX0ngUyOlsh7OCLFS9hpOh5yOETIaA4UGW8p+xJqtndZndo7ioKhqPzaJ9S8oqy5LJqTgO8m4BL5Zggkblbwmp1bAClnSaRedicxzkn7YM+6Jwy0+qNU9deA/pxCB9Vhn9Jcj+YHpxMLe5mpN1cKO1f25/L0KmAlt0KqlX9yEqH+cdwB1OCVpByQ80lCeumkcYZbm888GdLjgzpVKpOJdYBVJDntAezvyQpkQns3d5lxZujifAxsZ8GyOfIXe+VP+U7+2Zw+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(33716001)(6916009)(54906003)(38100700002)(8676002)(82960400001)(4326008)(5660300002)(66556008)(66476007)(2906002)(66946007)(316002)(8936002)(44832011)(86362001)(6506007)(26005)(186003)(6486002)(478600001)(6512007)(6666004)(107886003)(41300700001)(83380400001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnpLNDlYdXJoOEdaSHlreE1xZmhMcnZScGNkSkxldGJCc0lnT3Y0Nk9EWFFH?=
 =?utf-8?B?QjBNNHVHT1RzSGt3TGZEQXhKZXROWWY1Ny9QLzRXbXdtSnN3WmRnMkY3MWVi?=
 =?utf-8?B?L0RVczFwSW1VdmVNcUlOZTNpSnd3NWRmTmpvZk9NVnFDU1RrTVBocFVPdnZ0?=
 =?utf-8?B?Y3RzOFNhS0VWN3N4RW1vSy9DTjVRZHhNMS85U0dLRWxQUXVkZVg3YTIzYUJo?=
 =?utf-8?B?RVcraDhyb0FiNitUSkJpU0wwdU5yMUhDejE1N2E1UmkreDRtU1FBUHFpK0RT?=
 =?utf-8?B?TmtWTXBMWVZIdVVTMno3QldJMVhTaEx3QitaNjQrWVhrd0hYL1NDeWRBR1hu?=
 =?utf-8?B?aFEvd2V2WXFaWWJUTE05YnlwUmtMVk95V1c3MnlBZk1mTEFRSmRQYUI0aVdr?=
 =?utf-8?B?eU1Hd2R0S3NOQmtockJjRnBBOWhsMU54TEFtRlNWRDVod2lGcWIwY21DaXNN?=
 =?utf-8?B?cUNoUWIzVWhITGZPS0RrTWk1N2p6YVRFRGJVNko3QnlZTjRBZ3FkdWJmZVJE?=
 =?utf-8?B?cjJpa0UrQXIvUXExbjZHUXVoREF2dDRsS1J3Mk4xdmovZE9Ra0ZySXhwbUxT?=
 =?utf-8?B?TkQ3K0U4c0tuWk1WdmZlWFdHZU5weDNHUEpqc1pqTEhwNGpxMG92SU03b3N3?=
 =?utf-8?B?a2c4bThDQlFJWldhMEhEUlp5L0pHeUhpUFpYYlAybjk0YTUrak9uTmxSbnBj?=
 =?utf-8?B?SEh3MDFLbjhiV2xpbUgwMUJqczI2b0JRYnJVc0pjNFo1S0REZWYyRmNDa3Zq?=
 =?utf-8?B?aU1pSzM1a1ZobkQyS2pIa0lZTW9tQW4wVzdMOVd6YWQrUHhsdVNaamNHd1Fk?=
 =?utf-8?B?eDlqeE8rN3FQMDZhUVZwdkJVYnkydVhIdWEyYUFjdkFFZTNvdGN4NWl3UU9R?=
 =?utf-8?B?cER1VE5WdnFmRlE3RG5mYzExdDFlZzN6M3NNTWRSRWZrbnhTZW5NSWpySlRO?=
 =?utf-8?B?V0REVUVMYzN5OW5zUFBzN3FNNU0vOHBMSndXQzVVTkkzTWNWQWJacjdaeG1z?=
 =?utf-8?B?YnF1THRxUEo1amhqUE1mZ0Rsa1Ura0dJWERKY0htaWdHR2xXNDRqTkxUMXl5?=
 =?utf-8?B?WWVFa1FCa1daWWZiSU04OE5ZMDRTNnF2WXF1UWE5SFJiUzdkakFVdjliUDgr?=
 =?utf-8?B?V28waHNwSGxpQkFRNFBOVmFuS2NJNGxXZFNLdytiUmpMK3Boa0RkWWtQakR1?=
 =?utf-8?B?MllUNEMrK2lxS25SaG4rbGl1Zk91aTZOQUxIVTdDZ3pPMUxVcUxDQ0hBTDVL?=
 =?utf-8?B?Y1ZrKytQbW1GQUg1ejhxZlVpQyt4TDVMT3grejVZU2tBU3k2dzZmZGVoWlo5?=
 =?utf-8?B?bHU3MGRaT0JpS0tvMWlXOWtPSjFMTC94RkZkRVE1SlNVaVk5VnFWUWpERDVp?=
 =?utf-8?B?NG9URkkxalI1NXhUQm1wQzc1ZnVQa2sxem5kT1dKbDNDWjNEbUNzYzVseUxO?=
 =?utf-8?B?aitKZkZINGExanNtQVR3VDhPcmc1RlZ1VUpJTnVaZW5qdHJGekxudnZYLy9Q?=
 =?utf-8?B?WkxXbElrMjRJblRFcWFWTnpDeFMrUG9QM0Z6b0tPTllCWmNJMkdFNXBsYWxD?=
 =?utf-8?B?dmJFdGJYNW5JcHhySXJTNkJNemZ4NGFUMEtrMWdOYmhrTEZOYmtpMWRteVFY?=
 =?utf-8?B?SUh2ZlVuU0xseEtxZzNLSjNVdjRqeWFXNy9NRXZ0R0VYWVhVL3kvcEo5bktU?=
 =?utf-8?B?T1BidEkyWVR0aWNoRmdIcFdhS2tvaHZFTi9RbmNGS3pwTW1HaGkwem1ZaHhS?=
 =?utf-8?B?dkFUb3JsUnQ4SDNVNGc2U1lUcmtYU2p4cnhKbTdpbEY0UGlHWUhVTUtnVWZ4?=
 =?utf-8?B?QklUL1ZFMnJNQXI0Qlh5cExBMDN3d3U2dkFmOWJFMmg1eUpsUis3eTlBOUJY?=
 =?utf-8?B?TDVHK0ROcW1RSEVZLzFtaG1Sa21qYjc5ZXl2bC8vL2tTOGwyaGZoSW16VExq?=
 =?utf-8?B?UjR4amhwcVJkUkZBSDRoWTUxSTBTcW5WUWFEczRQYWRaZzJlY2xJN1lJUzQ4?=
 =?utf-8?B?TEJERVNZaVAvOUV2eWE2WmoxemN4aFNTVGpzckF5NXBxR0FKKzJsTE12NWtQ?=
 =?utf-8?B?U0JWSVRzNnRnbndRZXdrZ0RLVGNpa1N0RXNlbC9wVWsrR0J5L0k4anN4aU8z?=
 =?utf-8?Q?oxA2X8c301N8+UC7CGKqVCTUY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3147af90-fb0a-41ca-e12c-08daeab5939e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 22:31:21.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RzvdTM5qGhy7FHm84IlKS5bDWg+MPATzCgpbMHI0HUjq2WEkSy8fkQ+J0uKFdb7ph5NXcI0s6eHrFyTLjqgfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 12, 2022 at 11:13:56AM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
> 
> Since its use in fs/cramfs is safe everywhere, it should be preferred.
> 
> Therefore, replace kmap() with kmap_local_page() in fs/cramfs. Instead
> of open-coding kmap_local_page() + memcpy(), use memcpy_from_page().
> 
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Nicolas, I was auditing the kmap conversion status and I see you reviewed this
but did not merge it.  Are you still the maintainer for fs/cramfs?  Should
Fabio send this to someone else?

FWIW LGTM

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/cramfs/inode.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 61ccf7722fc3..c17cbba5d45e 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -238,8 +238,7 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>  		struct page *page = pages[i];
>  
>  		if (page) {
> -			memcpy(data, kmap(page), PAGE_SIZE);
> -			kunmap(page);
> +			memcpy_from_page(data, page, 0, PAGE_SIZE);
>  			put_page(page);
>  		} else
>  			memset(data, 0, PAGE_SIZE);
> @@ -815,7 +814,7 @@ static int cramfs_read_folio(struct file *file, struct folio *folio)
>  
>  	maxblock = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	bytes_filled = 0;
> -	pgdata = kmap(page);
> +	pgdata = kmap_local_page(page);
>  
>  	if (page->index < maxblock) {
>  		struct super_block *sb = inode->i_sb;
> @@ -903,13 +902,13 @@ static int cramfs_read_folio(struct file *file, struct folio *folio)
>  
>  	memset(pgdata + bytes_filled, 0, PAGE_SIZE - bytes_filled);
>  	flush_dcache_page(page);
> -	kunmap(page);
> +	kunmap_local(pgdata);
>  	SetPageUptodate(page);
>  	unlock_page(page);
>  	return 0;
>  
>  err:
> -	kunmap(page);
> +	kunmap_local(pgdata);
>  	ClearPageUptodate(page);
>  	SetPageError(page);
>  	unlock_page(page);
> -- 
> 2.37.3
> 
