Return-Path: <bpf+bounces-7445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3A4777813
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 14:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2470281E6A
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA92D1FB38;
	Thu, 10 Aug 2023 12:19:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC401E508;
	Thu, 10 Aug 2023 12:19:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC662112;
	Thu, 10 Aug 2023 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691669973; x=1723205973;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=B6IEokDDRNyTEqBzEtWeY1FQovq1OtMGptwJnqd5COk=;
  b=g0i0TJKoKDDq9PeEZ17FQPD0Q6vkUKliCWrL2h04DSOEIaLHlGUXKWSm
   s9/ysjBkKVegjacaXGetGPh+3scP51DGpOWHXW7zZy4FHy8lzdGv8mFjD
   h7hTzCyzUplUwzeHkKnarUXPHLRArY//+QD3W4f86JODE08Wu/3PNUr4U
   QabNzfie7DNV85jRZewV+SOK+fiS2euHERueXIB7fKjQUJOoePDivF0gZ
   PHwa+UUzTtTnN6/fPQD3UgP693KC7o/Ahnd9jKg276xDfoDo9D9fMXyvI
   BLwao3ZH1lzFPKnLJuLmTZZeJc8phQ+sQaAofvcBex6zZVlBw/a63AKfT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="402346925"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="402346925"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 05:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="761772188"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="761772188"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2023 05:19:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 05:19:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 05:19:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 05:19:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGpI+/XaTnl2jm6xf39G5WefFPHr5AFsac37BVE7whg1TtxndhQ76DxGfegQABnL4dQVvRmsGNhhbw7mLfSsJ7AT/PYqbFhXMW1LvocdGZOL1n2uCNaCrVaBTH2r2AlykO0f21hWL32SCXRb5dOy+OBLomn3+2hU9yoCY85+OUjRJxS0snaNS2jaFIAl5kZ6DRW/qxN/Kp37u4XIin/vcDqCnblVPMyPzZjErHJPu/qUPz3fNvbLh3rPSdCH2okYYdQgj5vDKwBBD9v5pq9dFN2dICROWeiiNORTlDeBVT3NsHBkfs5wPlm63SRWKkpjFcW7dR79U56HWJPqKvQu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ML/45mzUZz4pYZhrzs2YLs2XCW77/H4RhGgK6njlkc=;
 b=lbd6rGOmTRxSzOjLIRLLjatR0S0fIkItRlwHrBhgXyauaZhfAXT3UiWiG8+aGWxX4aU3kQ6QbabB7wFca9Qyp8scDJgJOYcwtKd7U1Gl1CZgGXssWUCkQrRss+0QUGHzlN8WLhCiyoQRLk+OvLUu489ctOgeijz3kJ4zPSfLxUMdqIgiuWjv5YL4YXr6+B5iawvDqStDexdSt/jZW0UROhzvtWenMHGJzQKetywST963arTMfPNQczrVPTkB3lAcT9FclO5oPNY3T06YseQ80PjH8rdztR0R5zW4n6R3xeOMfM5oZGmXEoGXfIJLGJUF+B+OPiGFCsAx09k6vkqZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 12:19:25 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::aa6e:f274:83d0:a0d2]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::aa6e:f274:83d0:a0d2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 12:19:24 +0000
Message-ID: <8cb436d2-0f7f-6c78-c4bd-08a2d4caa584@intel.com>
Date: Thu, 10 Aug 2023 14:19:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH bpf-next 10/10] selftests/xsk: display command line
 options with -h
Content-Language: en-US
To: Magnus Karlsson <magnus.karlsson@gmail.com>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "bjorn@kernel.org" <bjorn@kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "yhs@fb.com" <yhs@fb.com>, "andrii@kernel.org"
	<andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"song@kernel.org" <song@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@google.com" <sdf@google.com>, "haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
 <20230809124343.12957-11-magnus.karlsson@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230809124343.12957-11-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::6) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SN7PR11MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 5965a345-4110-4835-dea7-08db999c0906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXhQQ/utMnyi8lzhgbZyljO+r7uO5bKRTC+fFOBGxKTYAtIgq9h9eDZuclLNnJUkt9f5efli/YLRFBiPPhPh4783YUl8ErTzoAAGC10P/zwSfm1zwZ5UoE+dc8K0mb05V0afPK6GE6HjKkDb6xCx1ejmr1ewCoXN3BRg/q8uPqlyw/C/eyPGFEX200XA8B2wcBnidh8WDc96IgDUGb0UUwI4p5HfMuUkg2IDVDXJfAYceljTFYo6/sKgecxzouF5LahSFItUvlSPRyQhinNUP/2Hq3BlmH2127/SGcK/XNioMHvcWyxKTUW9CVxg06++5qS//ymVWO+PuCCRNpPHsGQw0HlHe6JlROmtuK6oLQbrudXvCDlAd9u82BPgffpvFQfO5x/mY6IbwjUtvq1TAJyu6fjtNCLiKx45qzu2UiBymB+kLFZU+bKGUcqQjbn/v1LNNnGeVqeIQcwbJM51avhGUyBQkLM8/y6afdablACgucnMnyBYiqqz9hFYlxIPMddStDgGS1p2vmTtiz04GiK6RSKuK1GfK5eoglItex/zd3nHFMlu88g8s7r8BQpqsJvYkXgnhw9rySCcOt0sFK0y2n39mJ3nHxMuWpOkOMtBEPFpa0LumDzqB/veufhm78Km9WAWFTSU0RAE6mKLXVT6Olf6B4D3XirE9cg0z34=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199021)(1800799006)(186006)(6512007)(31686004)(110136005)(478600001)(7416002)(66476007)(66946007)(66556008)(316002)(6486002)(6666004)(41300700001)(53546011)(6506007)(26005)(8936002)(38100700002)(921005)(8676002)(83380400001)(2906002)(36756003)(86362001)(31696002)(82960400001)(5660300002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHpyS29MbnQwMmhsdE54SGNwazl1TjhyMUtuOEhydFgwYWFVQ2ZoWmE3R2NG?=
 =?utf-8?B?RmFxZjNXQ0FIQ1dYRENua3FlbXBLS1MzZmhhT29NKzNURmFWU3M0amw2UW56?=
 =?utf-8?B?UFpFQ2dpMzhsa0xUa09vcFE5cWR5aUdHb1FwS0laM3ZOMDhERGdPRnZTUzJ5?=
 =?utf-8?B?T1U1TjJyUmFhcXg2YVgxd1MxVG9Ga20yMHRnRytWYlJyam03ellFS1MrUCta?=
 =?utf-8?B?bGVVY3R0M0ozbjMweWpaZnFqY2RzK0pSa0JIMzRLUlIwRENmSnJOQVhwYkQ2?=
 =?utf-8?B?NUJkS3ZUaElNUy9wQjlNc3RTZGdTVmlNQUphTVhxemtoZGxaNEthOGIwSDFQ?=
 =?utf-8?B?TWM0dWtpdVJQbG5HY3hWNmM3QnN6blhCRHZlSlc5YXFqdnBkSUFXWnJITDNK?=
 =?utf-8?B?dU9TeGU0dnlDNlYvcXpocnZUSy9jUS9lWTZvejNvVStxSFZ2VnZvVWdTT29u?=
 =?utf-8?B?RlY0N2xha282bnJCZHlwZzFuRExvcjRQenYwbms2MzJkRGg0N0VqeU1QM21N?=
 =?utf-8?B?WVBCS3drYTl0NTFkTWtLUkVkTEVJSS93QXc0bkppeUdLS0tMQVdCU2ROWXV3?=
 =?utf-8?B?L3RJdHdHVEdWejVGSDNJZzgxc243QTBXemZJTUU1VWxzVEpjVml5MU1RZlAv?=
 =?utf-8?B?clhYSHZ0V291c0RoUVFRZ1hCSkpDUzZGZnRNS04xSnk2VkRyYXR0VlV0b3o2?=
 =?utf-8?B?S1IzQzh3UnBwWjQ3b25iUndiaEc4R2F1UHVZZkZnRTZzWG1MZThVWFd2ajhL?=
 =?utf-8?B?MVNjZkk4bVl5WWpZbWRjMXptSTdvdG5YZlNGVXM2QjJnbGpGaHZDeG4yd1lw?=
 =?utf-8?B?cm5DRnRYb0Y4WVVQM1VKTG0zQmxmdm0zSE9DYnFRNE9QY01ucVNSSXV0NmFs?=
 =?utf-8?B?RmtiYzhVWTFEaTZ0NjFEejRBY2txQ3Ric3ZkYnAvQXNEWXRreTVyRXNNcWV4?=
 =?utf-8?B?YzQvUmdPNHpzcE1EeGJHdlhWOUpyTEhERzcvTlZLRFl0K3pyWTRmSS9ycFNr?=
 =?utf-8?B?M0FNcVZEL01VSmlhcnR0cVdMeStML0Rwdzh1MTBFQ0ZhN29uZE1PdElNUE9Q?=
 =?utf-8?B?Z0hPMzY4NkxCTXVwTUFhM3JPZ0w0dlM4MUJVeVV3YWhZR1ZoL2QwYlBtOG9Y?=
 =?utf-8?B?MGsyenhObEpQNSszZWlFUEdoQTVsakh6U1VvcFY5aGJvbWtRc01kdUJLeVA4?=
 =?utf-8?B?eVMzLy9qR28rcXhUWGcxbmFaaHk4WG1sdUJobXZwcGdLYWtBYmxCODdlQmJ1?=
 =?utf-8?B?YmcyOTZ1bU80ZXpEVVBXUmZVWStOSkRob1JIczV6aHVINkRSNW8zai9ubXcr?=
 =?utf-8?B?K0F2RVNoQTRkUVlxK05XcWlZTHd4b3hrSzRqR0lZMy9jcjdNdWZrYnlMc0wz?=
 =?utf-8?B?MDFqY3lMK2xuWjR0WDkzN1VKdC9BaktKMmlVL2tUdmZ6TXJZR2l0dkpPU0RT?=
 =?utf-8?B?b1FhOTBOMnBnS293bDZoWUdvT2ZyS2tvRlJKTzNnejBVSWhxT1NZQmxHNk9x?=
 =?utf-8?B?TVgvQkN1aDVUSmxlOHUvOFYvT1RGQkxKQ0xOS0dIVnpwZnpRV2dlMjJBRFNn?=
 =?utf-8?B?QzB2Y1JtWklRbXdhT0Z3TGFlSUVHUE9CVXdGdCttdHJ0NmlZVHgxcXNqU3E0?=
 =?utf-8?B?ZUZpcXJXSnd1QzFxMW0vSHFyMHVVYlJPS3U1ZldhRDVML3R4cW1Sako3NUpX?=
 =?utf-8?B?QUlLT2VWRjNSTEtlMVFscWR0NzJYWjMxRWM3aUI3U2xEamhNR0pycnBoaldK?=
 =?utf-8?B?RVpXaHBIZjZmQWFZOWFXNWtvQWREN2NsU1BSTU43Wm5RQ2VSUUZQSHVmQVZs?=
 =?utf-8?B?cys4bXN2R21Xdlk5WlBvUHRlQ3FiWWY2WG1DU1Vnem56WHVOWVlmdXJsc1NO?=
 =?utf-8?B?MkNaVHp3UjQ5Tjg0aHRBaGU1azRMZkJ0Tk5oK1Q4djl0SmFvRkxmZHFHNG9z?=
 =?utf-8?B?aTdCWmdqSDJjd0pBMlRoZ3l2MnJadHA0VGlNUlBvVHA4QzZvcGltbG9IY0hs?=
 =?utf-8?B?ZmZKd1NZRW9SWFFVMXc4cVJuRWZ2VE1Vb2JOb0VwNVpMSis1WFYrek5Obi93?=
 =?utf-8?B?bUVmRjRaaDRuRHdQdmszSU5kS1ZONnBZSVVQdjdqbk1HNmFHTlN2cjZyN2ZH?=
 =?utf-8?B?VGEzNW95bGRXWnRKeXVXckdpNjFXRnMxKzhqRC91SG80TFdvcXFSODhVQy9m?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5965a345-4110-4835-dea7-08db999c0906
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 12:19:24.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPoLTTnkvi1Td83JQMNZjpoYYNdYY7b8jeOltPDlOyxriv0IQRAy6KAYoQRFu1XwmCQxZNFgs+g9EdPYCgej/1rSJcgMGJJ87HE82z+9zLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/9/23 14:43, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Add the -h option to display all available command line options
> available for test_xsk.sh and xskxceiver.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>   tools/testing/selftests/bpf/test_xsk.sh | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> index 94b4b86d5239..baaeb016d699 100755
> --- a/tools/testing/selftests/bpf/test_xsk.sh
> +++ b/tools/testing/selftests/bpf/test_xsk.sh
> @@ -79,12 +79,15 @@
>   #
>   # Run a specific test from the test suite
>   #   sudo ./test_xsk.sh -t TEST_NAME
> +#
> +# Display the available command line options
> +#   sudo ./test_xsk.sh -h

any "help" / "list" commands (that do nothing but print) should be (able 
ot) execute/d without `sudo`.
Removing `sudo` part from the doc here would make it clear to reader too.

>   
>   . xsk_prereqs.sh
>   
>   ETH=""
>   
> -while getopts "vi:dm:lt:" flag
> +while getopts "vi:dm:lt:h" flag
>   do
>   	case "${flag}" in
>   		v) verbose=1;;
> @@ -93,6 +96,7 @@ do
>   		m) MODE=${OPTARG};;
>   		l) list=1;;
>   		t) TEST=${OPTARG};;
> +		h) help=1;;
>   	esac
>   done
>   
> @@ -140,6 +144,11 @@ setup_vethPairs() {
>   	ip link set ${VETH0} up
>   }
>   
> +if [[ $help -eq 1 ]]; then
> +	./${XSKOBJ}
> +        exit
> +fi
> +
>   if [ ! -z $ETH ]; then
>   	VETH0=${ETH}
>   	VETH1=${ETH}


