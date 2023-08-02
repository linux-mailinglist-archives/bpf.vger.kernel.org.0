Return-Path: <bpf+bounces-6727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA3E76D338
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426F61C21326
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E70D312;
	Wed,  2 Aug 2023 16:03:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607A79FF;
	Wed,  2 Aug 2023 16:03:17 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C76A1706;
	Wed,  2 Aug 2023 09:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690992196; x=1722528196;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HfmMRCGt4HSZ6u1rvb5AHgtMoCafgbFSc+O9xhKrh8M=;
  b=c0UUS2B7rzXvkIF35XxeKcqmlMnqfjsNJrOa/jCOh/B9EpD2EG3GYE5U
   /SUBbnwKCvnkV3ZYUBreBNBlYDelKKTWFwx33rNjFJw2hni2vVlQH+cIe
   adcJT6Y5Z1v1ihRYfPpBQSYUNyRMqMmSTrXCyTWBJT5sEq82UJ3a98N+2
   eAincoBZNUjqfbizk1uCVMzolphxE2GYFr4G38XwSNuxbtKb3TnaW3YDj
   FB+gyghaduG0hEtMUhsgaW9OSPHg3YdOCwizi25v3zFxBEMpz3jnShfwc
   ZchcnWuJqV1yTgRgoXo1ZXgARaaFc6w91/IfT5eEB4jDcZigO5e1MGvtc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="435947998"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="435947998"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 09:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729183010"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="729183010"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2023 09:02:23 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 09:02:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 09:02:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 09:02:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiqhJvVD7JNDD3rU+2ks4nb8NoWby6DjUGNdNNpKZShYRAWaJ39YNoGLsc3ik92JUK0F4+QXnQgccriG5Nts0S6F6nZSXHmL1IFEgAnJ4+74gWSXgnp3Iphv9iPCDugygLnuTU+kDNP7vtRbIkrY0oodxr2D0KrKMZmQJ6nUN3l97M8ndUJj9xT76v5RjFR8Y3rW/erdpqxnpGw5C+lqzpBD7sgdxLHl1eu+JYTNfZ5VS5i5IKNsZIyL6aj3P6owYLqS1UZWN31fpMh8rNxDZ7TzdJJqU3wIm6AF0yW/YxY//imZSPlVN+pjNmJ3EBQjzSo1CMLSdi87q38LMF69Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TB+mTwaf27sXL0/uy2yyvoFNpsQvXjTrrOZInJSz5c=;
 b=Y8ICxVeRRHoQCAFZ6kS0BEfc0rqPCflMiaq5jLLYndHH9BQs2Bk3+AJ5pBg0PqP4sg5lFM2YLagNNT0PitHD60Nu0cTMWzCxNe/T6IgKe7AumDgGBjCBixCw5t8XBmFeP6P5aoQD/ElHQSxuxjiSR1RPADktm5yok+VOzqHCVHuhknY5haFxVY1pXl9ktxlmQ8fFjT0V29O5nWJ6UdDj6hbncAlA9coGeR2cbhyj5h2y+YwrAy4YdvHkNfFT+WkkI5BOdr0FgNM1m+BGAxfN2GWlluV92aDD1gWAuutbGQXEuLzoqcfSxPEhCUv5lp7gkrtP6ggo3+RKI4RpZL8c/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CY5PR11MB6389.namprd11.prod.outlook.com (2603:10b6:930:3a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 16:02:20 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 16:02:20 +0000
Message-ID: <c9df397a-41c4-02f6-c3b1-1a7c2cf4ad6d@intel.com>
Date: Wed, 2 Aug 2023 18:00:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next 1/3] eth: add missing xdp.h includes in drivers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <ast@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<hawk@kernel.org>, <amritha.nambiar@intel.com>, <j.vosburgh@gmail.com>,
	<andy@greyhouse.net>, <shayagr@amazon.com>, <akiyano@amazon.com>,
	<ioana.ciornei@nxp.com>, <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<wei.fang@nxp.com>, <shenwei.wang@nxp.com>, <xiaoning.wang@nxp.com>,
	<linux-imx@nxp.com>, <dmichail@fungible.com>, <jeroendb@google.com>,
	<pkaligineedi@google.com>, <shailend@google.com>,
	<jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu@kernel.org>,
	<decui@microsoft.com>, <peppe.cavallaro@st.com>,
	<alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
	<mcoquelin.stm32@gmail.com>, <grygorii.strashko@ti.com>,
	<longli@microsoft.com>, <sharmaajay@microsoft.com>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <gerhard@engleder-embedded.com>,
	<simon.horman@corigine.com>, <leon@kernel.org>,
	<linux-hyperv@vger.kernel.org>
References: <20230802003246.2153774-1-kuba@kernel.org>
 <20230802003246.2153774-2-kuba@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230802003246.2153774-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CY5PR11MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 4345a3a3-6c6d-4c5e-6881-08db9371d997
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrzZS8YMFHVtwmrbV54qh0pDppg7ihTavb69mezCif/0AvvhtO7At4PVpau7vMfdvGqeZu8W2LlrSl4QXJvnBPMHDq1M7Afe/VSI79T3qAYcqSTkm0mXQkMXyq0g/Lx79dMp6XVPyODPP5tDqfi/2SmOPMBoTWgy9/5UHMZ5xi7rPS//svUdsWvNxIW7PiNFd9Qv+24lwpQshIv1/9JXkWOamjyLxyo9aaTT2zbCDm6x8JKKhWn6AhnFGZfuEYSe8IJg8nM6be5D4VNW67XC09T3GIQFYlb5tr7s1icqiHBerHy/0TaWO+cDYffdMEiogfn+d7eLKV7nbOZEpTyl0s1HU7dnmousbTjHC8wuEVLdcpEkeif1igCjEGw9kLCKiNv1aISv7uAVGqEH+qBZTx6XQQ+zn1y7tVCcQIicWDlrk7PJD7pET25zLo9dwWLMwGAb4cvS7DfoIBHgEzQ/WEuqQBvquVk6HO/lYkLk21uWzOA8iNft3lOv4P0HTYHA+xVsfbZtjqM6iPEOHDgCf2yq0C5VwtoSY7u/xDMGmP7AIoa6Or3AUzXEMs4xBcm3+8TWvb1zJUTXoqdhdnMKem4TqATyK6aXN9ogEePHre9yg/GaSVrVyWIqoQw4ICBYOxE1d/SBeHacqtparWZibA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8676002)(8936002)(5660300002)(26005)(41300700001)(2906002)(31686004)(7416002)(7406005)(186003)(2616005)(478600001)(38100700002)(316002)(86362001)(6506007)(6486002)(66946007)(66556008)(66476007)(45080400002)(82960400001)(31696002)(6916009)(4326008)(6512007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1pkZUpoOUVqdEhTUGVGdHpIRUtTdFlYaEM1Vk9CWTJ5am11ckUxOHMydkZr?=
 =?utf-8?B?eElpcnBrWnp3VDZFTEs0cXRlMWFxc1pQd3pENUdiOVMrd2xXaVR6bE1jRXFD?=
 =?utf-8?B?UHkvVEo2VTB5emh1OGpCWE5mUUVJdVdmVDBQRlVhMW9mNXg0cHo2VGFqcklV?=
 =?utf-8?B?UUZOU0RWdm41YVR5bWVuNHY4alNVbldlUGFNc1h6RXBqd1lhcTY0R3lFOUJP?=
 =?utf-8?B?SHJIWTJsSWd6d2MvNVRMK1pmb21nODc1NkRLYjN2RkdPOUNIaXE4UTNGaUNQ?=
 =?utf-8?B?cUZaZ3RTNnZDOWtqdzdwNXYwL1lyNDFlbVFVekV2SzVjQWJhOVZpOFVDQUt1?=
 =?utf-8?B?c1p3UVN3KzFRM3FrRkFBcDdCRVhOalhjcklwMElRQ1JEWUJtWFUrZU84OU9U?=
 =?utf-8?B?cWZvbVNaaFQ4OTdCYUhHd2ZLWHFJMVdDdWJrTjA2RDh0a2JQMFF6VnZ2aDZu?=
 =?utf-8?B?eXhIWi83WlRjMWdvSTJaQ3g0MDZoSmE0WEZiRTZidElwcHI0aS9sZi83aG5o?=
 =?utf-8?B?YlcweGl6Q29XYTRSUWhBeG1jV0NaQ2VJYjUvQVVIdzNLaVhWQlhGNFRBQ2N4?=
 =?utf-8?B?OXVaQTJJMGJhSFd3eXkyc2RsZlFSZlJiOXJNdko4ZWtiQnlELzFFTkRJRWpL?=
 =?utf-8?B?ODRFY1k1MUpDeHk0SmVHT3BPSGhwa1ZuanJTVDNnekExbW9NUmg1bUZyRzVQ?=
 =?utf-8?B?S2FTV2ExVkR6Q2daMUpUU24xbEF3QjV5OHVlcFp1NVZIcVJqU1hCdVA4NVlD?=
 =?utf-8?B?bjEwR3lpQXRRTjJ0V21FTC9QVk9lbjYzcTNPTlBEZ1BOMllqQlRyNU9TS2Jz?=
 =?utf-8?B?QjJMQ1NhMlc4ZXlnNnk2clFvNWErZGEyd05RRTF5U1ZsckRoajkzcERNc2gv?=
 =?utf-8?B?ZzNsVzRISkJzRlR1RFlzVnBmUW44MTV2cm1aK1E2dktiSE9FNFZXeGJKREpw?=
 =?utf-8?B?ZmpnMDFPQWlaenF0VEZtbUx0cS90b3lYTUtQVFpiVnVuN0V5RnpaRmNQTHhM?=
 =?utf-8?B?MERyR3UzQUNFbEdvcEhIdkZyNC9tKytyTTlBTUV2L2F6Um43S2YvVDgvME9Q?=
 =?utf-8?B?RnZ6alkrOGpiRVlFWTkyUmNoQXJyeVN5RUtqd3NHRllWeG9WYWE0bElmd0p4?=
 =?utf-8?B?c3hMaEJWUlgrbmNYRmJVV1VzVDFrdDdGKzBjTHY5ZlBiN0VoWXRzL2pRN0I0?=
 =?utf-8?B?dzE2bEpsNFJlL0J0R1ZOc2duQnM0UTZhVHVMMGxkdTVoNEtNQ1VVSm9LM2Np?=
 =?utf-8?B?dVRaSk5VVVdUQ0lNOExUYTRTTHMwUit5bzBuYUR5K3psc2F4emE4dS8yVlFV?=
 =?utf-8?B?bkxtOStCMWVkc3F6aGgvenpUMUxQZUxhZ04zaWVqQjEzZ3lnT3ZERnh0OUx0?=
 =?utf-8?B?NFhpOEdQTC9VOWpyMHN1NktjNS8reVYvR25oTTloK1RjM2lReWJHM2FPYWVW?=
 =?utf-8?B?VzBJOWFVaGpYdmFZUlNPZTBMWXBYdXhiZGx4UEpsQm4vZnRaS1pJR04vY0lR?=
 =?utf-8?B?QjdQK29EL2ROTVlmSjBGaEowMXdNeDlNSlJGbXBaY3MzOG8wZTZxQUlaUDdm?=
 =?utf-8?B?bVp3Q2E0dmJwZDFvSXB4S3gyS0JXUFFKRnhKa3h1djh0cHRBbW4raCtZZ2o3?=
 =?utf-8?B?NXFxREZGeHdTdXdFRTJRamtMTDYwdG9pVjRxTDlDQ2FXOUJXRmJoU21QTzhL?=
 =?utf-8?B?ck83bjlWNVZKK1c4aDJLc1ZPTzl2UDZPcXNKYlAveG9LeXNyeWFnTXovdkVU?=
 =?utf-8?B?aTdTOW5GeGlSMTdJcEl0MTN1aXBsYTBkZUNFc0RoN2JXKytCTWtjaDdBUTdx?=
 =?utf-8?B?S24zNjd1Y212OSsxV0wwTHJBOEg4OUZySkgyTXo3YkNUdjMvalhDbDRNOW44?=
 =?utf-8?B?WEZOVjBPMGxSamVmZDFhOWlxb2l3NGsyejVuR3RQdzRYRGpmUnlRUVY0NEdh?=
 =?utf-8?B?OENFUW9LeFNMdnN1bUh3MDFVUjNycjRsbnpxTGpsUGRHTFFoeXNNenk4N0w3?=
 =?utf-8?B?azFtazMybTJTUEs1ckNILyttclRRVW1VclpPS3k2cGZOYnR2Q2hJRDNoWTQ4?=
 =?utf-8?B?bWh2VHJ1V2RuemNrUk50Rll3MlhTM2w4MDRpT1QzUVZmMzMrZjhDeU5HNnRL?=
 =?utf-8?B?MnFJWnRNNExQQUhWdHpSOWt0Y2FMNUFnOUxCMFhic0QvY0x6TTVncDE5S2Zi?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4345a3a3-6c6d-4c5e-6881-08db9371d997
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 16:02:19.7531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWJ1MTiXJKhfx54a5arlcrz2J7ICXNLJHa91wlyqtgQD9kAna2S/efLAefzZD+W9YzkdRx4kQVYL83LX15UQuOCrQYVpy8OwdfOGCDSjuI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6389
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue,  1 Aug 2023 17:32:44 -0700

> Handful of drivers currently expect to get xdp.h by virtue
> of including netdevice.h. This will soon no longer be the case
> so add explicit includes.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: j.vosburgh@gmail.com
> CC: andy@greyhouse.net
> CC: shayagr@amazon.com
> CC: akiyano@amazon.com
> CC: ioana.ciornei@nxp.com
> CC: claudiu.manoil@nxp.com
> CC: vladimir.oltean@nxp.com
> CC: wei.fang@nxp.com
> CC: shenwei.wang@nxp.com
> CC: xiaoning.wang@nxp.com
> CC: linux-imx@nxp.com
> CC: dmichail@fungible.com
> CC: jeroendb@google.com
> CC: pkaligineedi@google.com
> CC: shailend@google.com
> CC: jesse.brandeburg@intel.com
> CC: anthony.l.nguyen@intel.com
> CC: horatiu.vultur@microchip.com
> CC: UNGLinuxDriver@microchip.com
> CC: kys@microsoft.com
> CC: haiyangz@microsoft.com
> CC: wei.liu@kernel.org
> CC: decui@microsoft.com
> CC: peppe.cavallaro@st.com
> CC: alexandre.torgue@foss.st.com
> CC: joabreu@synopsys.com
> CC: mcoquelin.stm32@gmail.com
> CC: grygorii.strashko@ti.com
> CC: longli@microsoft.com
> CC: sharmaajay@microsoft.com
> CC: daniel@iogearbox.net
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: gerhard@engleder-embedded.com
> CC: simon.horman@corigine.com
> CC: leon@kernel.org
> CC: linux-hyperv@vger.kernel.org
> CC: bpf@vger.kernel.org
> ---
>  drivers/net/bonding/bond_main.c                       | 1 +
>  drivers/net/ethernet/amazon/ena/ena_netdev.h          | 1 +
>  drivers/net/ethernet/engleder/tsnep.h                 | 1 +
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h      | 1 +
>  drivers/net/ethernet/freescale/enetc/enetc.h          | 1 +
>  drivers/net/ethernet/freescale/fec.h                  | 1 +
>  drivers/net/ethernet/fungible/funeth/funeth_txrx.h    | 1 +
>  drivers/net/ethernet/google/gve/gve.h                 | 1 +
>  drivers/net/ethernet/intel/igc/igc.h                  | 1 +
>  drivers/net/ethernet/microchip/lan966x/lan966x_main.h | 1 +
>  drivers/net/ethernet/microsoft/mana/mana_en.c         | 1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h          | 1 +
>  drivers/net/ethernet/ti/cpsw_priv.h                   | 1 +
>  drivers/net/hyperv/hyperv_net.h                       | 1 +
>  drivers/net/tap.c                                     | 1 +
>  include/net/mana/mana.h                               | 2 ++
>  16 files changed, 17 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7a0f25301f7e..2f21cca4fdaf 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -90,6 +90,7 @@
>  #include <net/tls.h>
>  #endif
>  #include <net/ip6_route.h>
> +#include <net/xdp.h>
>  
>  #include "bonding_priv.h"
>  
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
> index 248b715b4d68..a1134152ecce 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
> @@ -15,6 +15,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/skbuff.h>
>  #include <uapi/linux/bpf.h>
> +#include <net/xdp.h>

Alphabetical sorting? :>
(for the entire patch)

>  
>  #include "ena_com.h"
>  #include "ena_eth_com.h"

[...]

Thanks,
Olek

