Return-Path: <bpf+bounces-10056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1507A0B11
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FA3282153
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320E2250F0;
	Thu, 14 Sep 2023 16:55:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE09D14F6B;
	Thu, 14 Sep 2023 16:55:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138BE8E;
	Thu, 14 Sep 2023 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694710533; x=1726246533;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U0r6R6eFYIw7e7AwDDAaaW3ZnKKluoNLZpNUaezB3ik=;
  b=OdZWL52f4mnP3glPCYGYMkhlROTB0FIpGWzeV3AO2KmWmPUYvmrrvL0u
   qJaF+v3FGqCG8lLqz0RXoOZiciPBiHXmD51d9MRIsXe6DdIEL/+dBAf+s
   3YrgKnQlArc0K9aKHQBa/ls/s21sxi5MJvgaeUSl6q71ay/N0XjIYcErl
   TdIkSl5RF6KV8NcjxUjg1BJuflV33PCWKzouiJSlO/M1uzFT18penQQTI
   uufNTFQklZJNrXG5K5wBgmFC/jWMgiTVQcrPpNKtpIYGb6Y7H7qSBy+Ar
   vhsVn/paWSHGpYpHcie2mvIfbOcrwoBLvNJ5asIuYrI/1lwBidrR3UbMe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="378931968"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="378931968"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="814772444"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="814772444"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:55:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:55:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:55:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:55:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:55:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdbuhYN3ZnE598e8RqXJVgFOglzC09P9vqabYcLOTbHfSIbG2ro18HsQ9+/oqXvjPw1qJJIij+jWPort9/K8bvnWcHjFdDC4UE1GDrK4/TFrQ9aOYORITaYqNPLPc1aXHgKSt6pPKdSaxT/hSTRKbRVD9PFkap3hEnV0yeQ2Gj4kjVtmbdV1dh41kISbWJjn8IHseKuwwYdPyAVECQPb2E/i/bRoB3w9s1wyRCHzAE2s03hmV4rpZ3pNglkLBqA4KOgPwcvxHFEWxJgoZU20kQ7d/YIKJsLyl6cOdSyiWHw81wu+CeK782LPyTIudTzS5fXH7oND8gUHQK8gpRql9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJyMFUymsKFawMj/BH/4ksobZXKO8DNlRJkPNFmaVZU=;
 b=fSx7NrOz2DpC66vrrsGBE9xq25H2IX8yT8OAQIGUkmVMTkpQ7aL+Q/6OlR6RRdGZQmdUNUme+4hhaMT7Gvyahc27Lq95/CbdOoXgjJ8bsXxuzMx6daWQQ41GQF61UjGf8pn2xCTHd+IRNdx7Z2NGnDeaEcAYD5Qq6dZWlou41E+R3nsckl4gq/mxTkgULPX0+jNg9vpjzoRli+o9JCdklFnwWXJN/Xfu0QsIyw1mhmXFl6zzgFagSE5K9VEkW0G58M6M7XjipC0hOZ8HVTdjmVNIC3GqOo3VTy01EzUZUkhNTI2WFajieRKjtsxHL+gcbYKjn1EQJTvPA4bWw+umFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 16:55:15 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:55:15 +0000
Message-ID: <6bee72b4-dbfd-b62b-932f-8ca0da705994@intel.com>
Date: Thu, 14 Sep 2023 18:54:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next 07/23] ice: Support RX hash XDP hint
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>, <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
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
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-8-larysa.zaremba@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230824192703.712881-8-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::9) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA1PR11MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 361b15ef-610c-4fdb-cc67-08dbb5435e00
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zq0VIg7um4V3XklJ+rAMZOdI5H+EhRK104agQYw5rFholgp+JPCHxDbKRmi4VjMYqL/eZxWlOq1NXvs1pOYbnWkooIM8Cv6OqLwHOvxV1ombXN2MKWRxuJQFxlaPWEBbb+PdzJHhwA1nQC6Dl1efOdZXiP1sBSrZTWC5h7Hxf2sPzExwRVvXuxJ9KrT/V3grRrhbQ8uvCjQ69VdriTqttX0go62/nnJxJxiv/QCXIzBHOAew7n+YgT8U7YC0HeqTFuT2A2NFqZGHnJzwAkk4JzfCOfMHTPWSZWenKPSQbELWMsgOMlrVzr/8XDL2/THtFvTdZsBSn2Shxl2P9+meJUCKnp2cHANgZO8XcDYOmGpeM7Txv/WNA85OtUY+HutOB/N1SKQ+6HC3uBewHcE/WAwAmfrDBqvMCXHrSANJKg/wGNcNMjtxKHJOiothlyYOGRrA+JQ0vzbIET0lNm4S0Y/0qd3FH53jXJLnsVIpno4VpWMbETZQcDZBu6tHBVXIZyAasmTOjMs6j0TeqD6dEcdEmQcE36ZM6YXNtDNmRjT2D3mKoiWfuCe5mxLYWLVP0qC2VO3CyTgLKioqCbQDgRPDeP15TYpNpojEUhG3kiy+GJSvx2wZP0e0c414TNIGhbIIDHy2eZuXCi2ybCQvWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199024)(186009)(1800799009)(31686004)(6506007)(6666004)(66476007)(6486002)(38100700002)(82960400001)(31696002)(86362001)(83380400001)(36756003)(2906002)(7416002)(478600001)(6512007)(26005)(8676002)(8936002)(2616005)(54906003)(4326008)(5660300002)(41300700001)(66946007)(66556008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDREbnEzaGlVajVUOWcyQjdIRU1yUGxPT2ZLakd4Ky9ocjdZWlA0QW5BUlho?=
 =?utf-8?B?TXI5aVZTRi9wYWU0OFRYSUVKbkg0NTlOYWRiclpOMTVXNWZ6NjB0UXpwaGw2?=
 =?utf-8?B?Z0RpTERjUmMvbGkxN3dvSnhISzVjS3ZVQ3J6Qi8rcy93MmUvNkYwbHZZTUJZ?=
 =?utf-8?B?VTY2NS9JTnVuQitFOE9mT2dwU1hEMjVOdEd6V0lTNE1ETkJlTTQzYjlqeU9K?=
 =?utf-8?B?cUhpZk1ER1hjQkVMVnppYkhTdzJEUEh0cVZDMkJlYnl4bzFpU05oOXRSSUh6?=
 =?utf-8?B?ajgweXhuaVlmNTBUMGZWcytHWnY3a3hQdFE0Vkw2SGJXSWFwVlJVZkJOTkUx?=
 =?utf-8?B?bVVuSGJjVEJLaU5vVFk3YXBCOGNBZVBYaXJRSEhQQWdndDZheEJOcExqalBl?=
 =?utf-8?B?b1N6TThOVXdVWC96U2FHL05rU3N6eC9aVm1QWUVQRHJTaHhTVGo0SlRVOEFZ?=
 =?utf-8?B?YWJlcFV0cktIYUlTSlFYV2F0L2liRjJuT0pBcXRMYis4VnJYZkFMdnRMdVJZ?=
 =?utf-8?B?eEg3UTlWUmx0bG5QaW1lSEo4MFFTNlRISk9qQ3NVSEhsOWROMmFRVXdFVEQ0?=
 =?utf-8?B?Vlp2dFBYVUFCUmJTck1xWVlSV1p5R25HZEFTL2Jtb0tJU2xXdStuRVFYbUFq?=
 =?utf-8?B?RDB5NnlScHhmc1ZaNlNzclpZVFBIZTQyYVlqQ1BubnF3OWx1bkx4ZG9seDZQ?=
 =?utf-8?B?RlB6NnpPOGJuNEpacGt3eU9Ia2h1WVFRVzB6aXV2azFFdG1hSjlqNFU4UFg4?=
 =?utf-8?B?dExpZWdDK3BVamYvbjdkRmZMWjZlaDd6MlJWc2g0ODhUdlNrSWorNU50Yml1?=
 =?utf-8?B?NVFhQzNsR1RwLys5Y0J0djc3OW5CSURHMVVsNWc2NlZiaUFxL2lZdStkbStR?=
 =?utf-8?B?R0tCbTV5VTdpSmJDMUZZSXNxU0hQZkVEV0pRREw0UVRGa21pY25RQzZkck1Q?=
 =?utf-8?B?YU5GTlJJdkVkcnZ1ek01NnV6aC82RlB6QnBLV1ZhU0JheVowR0ZYTHdCWFMw?=
 =?utf-8?B?dkNQU3VTWmIyWEVLTk5RQjlzRzhXanU0eTRoZ2hWd0VYQjRFMFVuL05XaExv?=
 =?utf-8?B?MTlKRFBxYVhzeUJhTmlrY1JOTHFRYjAwaFgycnpnaUJBTHE2R1lpS1VrU21j?=
 =?utf-8?B?OHY2dGhhYUFneDcycGxaZXA4VTBEdE5FYnZpeE0zZE9taVk3dHhyUlhKL2M5?=
 =?utf-8?B?MUZWcElJMStFQlh0NVBMekpRa1VHMXlTTEI5L1lNR1pselcvK1psMzVVNk5m?=
 =?utf-8?B?WlBhcFRsWk1pZW5TNWFNS2tNZGVSdTdPak1DYmFLOGtRc3pXRnc0Q3BEOWI0?=
 =?utf-8?B?NldmRGxTVVI1RXZpRXkva21KSWFSY1dqVGYwbHlOdG5KVGNFTWhxdlhYZ0NF?=
 =?utf-8?B?eG5HSXZLYUZ1T0IycGhIdzJWOWZZK04yNDBBemVUcDdMbWI3QUp1T25SK1VJ?=
 =?utf-8?B?aUF5S0pFZ2RrY2F5ckoramszZFB3b1MzM1NxelJsWE1KbFp3Yk55ZWhuODI1?=
 =?utf-8?B?VXREVXpsaFI2d0Z2eGNhdGI3UnpndWFtV1pIN3QzTVJpUEx3OUlZQnYzQ3ZC?=
 =?utf-8?B?bDJ2Mm9icFJpdStQRWNvejlITUxYSjl4M3hjSjgyL3pPS0l4QjJIbHhCSThr?=
 =?utf-8?B?RlUwK2taVG1LRitUenJ6N1VUeFZDeUYyMDdRT3RHd056WmdPZmhJNEVNeWpr?=
 =?utf-8?B?elhpQWg0UnRsNytQMm5LMkQyWFdxaFR4dVd4enZxRlpiVXRpb0o4UWxiVE5D?=
 =?utf-8?B?YU5hcWZhcnYwRnk1QzJOYmg0QktFWjk2eG5FR1VRVU5vM0xjRnVDdmQvVnU5?=
 =?utf-8?B?K1dPVTZWaE9yZFAvUnEydFhWU01rZCt2ODZYQnRlcTZvR3FaSUYvcU5HQy9F?=
 =?utf-8?B?YTVIWmhmVGxOTU9PdlFQUjdhdU9OUG0vSFdQQUZKTzJ2cUFHWENHZUtQQXFC?=
 =?utf-8?B?N0l4MTBFZlJQd0RzUFhBNEZDZjFNRmpybjMvdHRlb2Jmc0RaendOSndDdlZ3?=
 =?utf-8?B?blFENGhqT3JKMGdIWlNjLzRBbzlSQWNrc2pNL0ttZ21qK0tMdUU1WHpjL0Z0?=
 =?utf-8?B?b2p1YXhWc3ZuM0xDSVdYd1lFZkxmeVJGSTVHaWEzTWYvcEtQaTIrYTA2RjFu?=
 =?utf-8?B?U2hPWmU2bkl5VE1aYWZOWEpkOU1OL3FLWko1cCtGVDE1WHV1VG1QZXhEcnBu?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 361b15ef-610c-4fdb-cc67-08dbb5435e00
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:55:15.0519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Uj1kcJdKkZ0W3K2LV2npmb6RkVKWNV1oblwyQk3umt7qO/khG5CQ/sOuLvFxQKTZhJLZw+1qnECXL9CSwIasQo2sg6x6wHVzWBn7ZL7XnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
X-OriginatorOrg: intel.com

From: Larysa Zaremba <larysa.zaremba@intel.com>
Date: Thu, 24 Aug 2023 21:26:46 +0200

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

[...]

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

Is there a big win in performance with this 600-byte static table
comparing to having several instructions which would do
to_parsed_ptype() and then build a return enum according to its fields?
I believe that would cost only several instructions. Not that it's a
disaster to consume 600 more bytes of rodata, but still.

Alternatively, you can look at how parsed ptype is compressed to 16 bit
in libie and use those saved bits to encode complete XDP RSS hash enum
directly there, so that ice_ptype_lkup[] would have both parsed ptype
and XDP hash return value :D

> +
> +#undef XDP_RSS_L3_NONE
> +#undef XDP_RSS_L4_NONE
> +#undef XDP_RSS_TYPE_PAY2
> +#undef XDP_RSS_TYPE_PAY3
> +#undef XDP_RSS_TYPE_PAY4

[...]

Thanks,
Olek

