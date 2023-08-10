Return-Path: <bpf+bounces-7443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB97777F7
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 14:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B131C21550
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AC11FB34;
	Thu, 10 Aug 2023 12:14:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA61ED4E;
	Thu, 10 Aug 2023 12:14:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F280A110;
	Thu, 10 Aug 2023 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691669693; x=1723205693;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=YM/D4bwlTWDf+XXwc0rkgRlZKb/pwpsKPBhffPOK0oE=;
  b=R1yVCHorXSV8kFbkEPkIJB3znSadWNegutNlumC1QElLT2H/OPifmpU6
   QKwwooy4sigRU3Zczhlr7lduPTpD6frJXTb1nvSgEWuVvfnJQx2STcmMR
   6Gn5q+KwH1JWiCRaNvtxvBa0L7GKdgTj2InBy0q3JGsFNFSDpmH+mrSdV
   CL/JtF3vWXMwBU81aBbhwFHoWkCMqbCJ+iArZOYWQ2dUIenB6ONAJQgI6
   K8fgzOiR/8XRN/+cp1c/U2I6wO49VeIpeHfiCjQcnuEirYVsnI3ZlBcTH
   7ycKiC3bf7Cju5alJb7OkrAmEYJNkynh4qvrqEx2Fl8CLSZKCnY+zI1py
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370277729"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="370277729"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 05:14:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="682080605"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="682080605"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2023 05:14:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 05:14:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 05:14:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 05:14:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 05:14:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dv3BTe5uW9ybHIrEGNGhdbAU0UHOSzTzvu4WZi1qEUQf8kHdVqyhNZ8d7fUV4YD7nNIeBT5m0uUEpsO9QbdGSvG7DM+paBi9F4oGZznDb5USQ7hUultIc4YZhi6u/g/Ia+uWTAPjqAO3D8nqaOFeY34nanKBrdIdWMGEGC/a20dxEJrj6T5oqxIQOJ79dWoBU8gcwVTBc16VLtunnZHN/nnqjJPsKzHOsy4oWPMvMRnW7+NZVo5X6BmIoknuy0aCEmOif6844hl2kTgqFm+d+aXqsNFFRxcsxm6r04OByxRIwHh0G7Q7fp7Vms/jgPM1baBAunnVIpVk9cBiMV2DOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPWaTCDWc+Bfge72tImTq/RYyTm7xg8/V3QoqdSE93E=;
 b=PzVFKUV3a83YuGq1IRd0RLW+ziqfzktgBtPEOD4BgZuVsQPJgTxNzrdmqCkkn/VMuHBipxJXe/ChWHByrH1oKSaJPA615kFvf3JOAvK0H5uCqUswQPf7VefLHMvUPdl9ISBK/41PVpIvtUF+ubqv+LjKalbQi+hJkndvdu/LLMai7s3e8erknA86Wpl8yBaNwPyCnk8n6RVJ3JQ5NbUgBC8iFwM8GY4v4oXS+N6E+IzVgWGr8FbkHChdzHGYLkLneSss/tnEaUGTsnvgp30r9drwkrj8KCD63ea6Jk7GozRw+sYD7Yxq217xv02Vw5nEAqG6SJTewt5nlh0qY9QdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CYXPR11MB8710.namprd11.prod.outlook.com (2603:10b6:930:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 12:14:50 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::aa6e:f274:83d0:a0d2]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::aa6e:f274:83d0:a0d2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 12:14:50 +0000
Message-ID: <be1643cc-dbfd-5e62-4750-54b41658f82f@intel.com>
Date: Thu, 10 Aug 2023 14:14:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH bpf-next 03/10] selftests/xsk: add option to only run
 tests in a single mode
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
 <20230809124343.12957-4-magnus.karlsson@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230809124343.12957-4-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CYXPR11MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fcd000-e0b7-47ec-b265-08db999b6543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSLpfWoANpq6/4TvLbdO3DYJnhjZArcOfpZkepVpy8k+lEaGUoAidE7JEuzMwnPVY2FUrs8UZtSNnvFtlw4XTMJvakCWdRXsOhm1J4VxZ3ACi3CQgXZjFH1LXC6yLnaeUOappps1Qh698a8hgDnvspmW+iQIGHcYqpRxhBhlqwRpb/7TfYVR7sJPqiBj3ShnMEQy4mF7JMT4/WfBZzvJRNI+/rrZZK/VpxVQqQMvkWBG0nHx7OYxvhzan949zp5zl1ZNp1N2YLiRHAcrgsBQ/R3CJrR53zUwe607pTFA000mctKWU6ivJjCWd2CLabllheBbvGGwaFpuiwjYyTm70G9gS4wR6sULXqXYy5aLu/VsOIXbdPPYq8y1YsyEtOa+Hm7mhPhM60Sm34nRvoC30u7l0emvh+AQ/X1g44Ey03mmbCZVKsgFk3yGqaDklhurGeDy7iKzqAv6jpaTXVjuhd+SJ9t9eEtCqN6h3whmC2lZErpHBfD/30Y9kCBkNMyVNuBglNjkzLeDgM18xDRr0OeXIvZ7w9Osc430hWG8F153Zi1e3Urv0K4klDAxRiHBvzz6kqXJbLZ8yaGDNMNtRRJ//GrwEn0XkGMyOdCr+UIZGbK9Jw/tgmrxQoj6sp3UOHXUFm7zZDxhXPw+LnQZOXjhqZqa+Qcv3evWzFqJ0XY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(366004)(39860400002)(186006)(1800799006)(451199021)(7416002)(66476007)(66946007)(41300700001)(6512007)(6486002)(6666004)(36756003)(66556008)(5660300002)(8676002)(8936002)(316002)(31686004)(110136005)(478600001)(2906002)(921005)(82960400001)(38100700002)(83380400001)(6506007)(26005)(2616005)(86362001)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHhJRm9qVTFMamRINkJyYmVRazI0bFMrS2NXemRkYTA4Z09rd2V4MGwxZUl0?=
 =?utf-8?B?OUNKOFZoNnhkQzBRYlRmTGU0WXNORTdCRGJaRmhXODV6K1R2emFCMkRNdXdh?=
 =?utf-8?B?ZTF2aW9pS01qZUVRSDI2WWdJQVFVUkE3YXc1aEdNK09XdlJ0dUFQRVF0Si9P?=
 =?utf-8?B?NHlWb0tQOVVzYjR1eWJQemxxY2p6em9ic1c3aE53RnpLY3pwNnhMcTkvY2dt?=
 =?utf-8?B?SldRaXlkZjFWQk5FQnE1ZXM2N05OUDVDUkRkbWc4YVVOYUtrbHRkT1lhd0FP?=
 =?utf-8?B?N2FNbURTNVpVS3N0YnVVTjBOczMrK1V1OVlsZk00a2V5Z3dKZkVCTTBQUVd5?=
 =?utf-8?B?RG5QRzEveHRMbml3ZUpFT0ZvU2s1ZDUrYjZPOWJIVXE3UnNvWEUyRENjVitQ?=
 =?utf-8?B?T2VmVlRXbE85RE41N09xUlF3Y3JHMU5rczF5WDNWSXdJMkllVkc3bmJMUkxI?=
 =?utf-8?B?em1HNGhXSVgvdUlvZkRCcHl3a2N1Y0F5QjgvSDNOWmN3a1YvM2IrbFAweThk?=
 =?utf-8?B?ZEMzRUtXVHZob2dIdVhFdEtxU3pGUGQvRHhrNWF1Y0IxeUlYR1lWRzVyeXY5?=
 =?utf-8?B?MGJzeWlaTW13d2dDdDVzOVI5TWtxT3hTOWw5anlQakM2YTBEQmxFQThleC9a?=
 =?utf-8?B?b0psSmFJdFZWK2VZamJXZzA4OC9kZW44NTA3S3BYU21jeHJVQUxMZDIweWVX?=
 =?utf-8?B?RDhlWjRHRWJKNXFsdEtwdC80NUhLZFBaMHJPRElzeHZZSXZtbVQxZTVEalJn?=
 =?utf-8?B?VFdmYkJuN2NiSUdqcE1vK3ZkMkI1SGIxbVZvVTlOVVE0NEVTRU9zOFBMWUtY?=
 =?utf-8?B?R1BUSE1CNjFnVk91YmYyRkNJQ0FxOW8rVmlSTkppd0VqMUR6MEhVQlV5TVc5?=
 =?utf-8?B?U2lkSzlKTjZNL2dRb0JuQy9jRVR6OUpLYjRqODVKdU9oZkZDNXIvM2FMSlRk?=
 =?utf-8?B?V3MyUnNMcGdvSk5rVlJJUXZJc2ZrN3RpY0lnSCtiaWNZc0NnZ3ZGUnJwaXZF?=
 =?utf-8?B?U0Q4cDllK2tqMFBjOG9lTkhscUNFclRiN3pWS0IwdkZ1OUJBN2s4UUdWTHhz?=
 =?utf-8?B?S1NXSnBsU1hyOGZMdERBYVYvUVFlY0ZZZy9qdGFDRWxVQmtYM2JYVzZtcmNC?=
 =?utf-8?B?bDJ5N0xZc3AvYjVjd0JaVys5SlQ1UnkvN3JnUkU2MnF5eXl0cDM1UG5FVjE4?=
 =?utf-8?B?WlR4NWQ1OERnelRHQ1hlaFgyeU1hOHFSSkxZTFErQSsxb0xLb25jTStHY0Ry?=
 =?utf-8?B?SXhvQzlNUm01UUlUMlViSVE2cDRBWEgvNnllckZFaHlaOUs1WXZVajYvc3lE?=
 =?utf-8?B?S2RiN0NsSGRGVzRVaXBMUnpHZ1N6RVd1THk3L3lRdFk1dUxWY3ZuS2lZZWlB?=
 =?utf-8?B?YTlTRzVrTm03VjRMYm9tbHF1VFY4QjBnK056VmQ2K1BMWjJHTmtGMnpOc1hJ?=
 =?utf-8?B?QnZoazNxUTE5d0hMSVRMWUV2TndZSHkwdnF0cVhNZ1gxMHhoNVN1b3EyZ1g3?=
 =?utf-8?B?elNxcWplRy9HMGRFdkhPMlRQSFBFQWVJNWI3TXdIOGxtT3h4UjRUL0IyRnZP?=
 =?utf-8?B?MFcvbnhyZUhZbjNaY0UrUzJKZmJLQ3BqLzJPR3Ivd1EwdlltbmRYSkRBcW5v?=
 =?utf-8?B?ZGI0WUhxNlU1R05sN3dWTDFiR01pbGFVTTFuUjNOWVVzS1ZlZUxiYS95dHVE?=
 =?utf-8?B?aE1TdUU5aW9oRDhZa3BUZ2xPRTh2ZVZ5SXAvelIzelh1bGlGR0VnM2RtWGRH?=
 =?utf-8?B?ZUUrcnRWRmRIam9sa05aRldxcTNJeitPOVdteEFCSDdXeEdOS1JRZytsTHV1?=
 =?utf-8?B?WXFpaFhRYlBXWk1WVVNsS2VvaFYwSTBRckltemk2QlZIcGk5VGIrcmpXMjhH?=
 =?utf-8?B?ZnRHd0JoVDFTb1BJd2tCUGUvWS9ZR3NvS1Y0SWdzSEo0cldoU2lLY2N6dnlY?=
 =?utf-8?B?VHdrVStQTUlTQ0ZQQTRWTEZiZ1ZqYlR5Zlh6VUFxbk9VRWhCQjk1bGRNM3Vh?=
 =?utf-8?B?dDNmTVpmNGZkS2xmZnVscHdCc3hqZEJYSVU0S0l4UWhLZkt1OWtEM3lkcDhZ?=
 =?utf-8?B?RnU0YTlkRG8wYm5aTk1uRXRmbFZPNzhhZThiYXh1V1lyVks3Ym5zRGlmUGNt?=
 =?utf-8?B?OHpBS3NBS2M4SnQvb1RqNkViZEt1WFQzc3NQNlZGUGN6K2d4bGQ5NnluWTZZ?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fcd000-e0b7-47ec-b265-08db999b6543
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 12:14:50.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNYvWvUscPDMd4xCRSjkMRl3PArLD9cmu0EJPCc58MtEqyFAE2VnvHnFw5ij5MIwqsiX3v6dLNo1yX2O18wwjcMylEVcd3+Tb7KyCDsmVXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8710
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/9/23 14:43, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Add an option -m on the command line that allows the user to run the
> tests in a single mode instead of all of them. Valid modes are skb,
> drv, and zc (zero-copy). An example:
> 
> To run test suite in drv mode only:
> 
> ./test_xsk.sh -m drv
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>   tools/testing/selftests/bpf/test_xsk.sh  | 10 ++++++-
>   tools/testing/selftests/bpf/xskxceiver.c | 34 +++++++++++++++++++++---
>   tools/testing/selftests/bpf/xskxceiver.h |  4 +--
>   3 files changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> index 2aa5a3445056..4ec621f4d3db 100755
> --- a/tools/testing/selftests/bpf/test_xsk.sh
> +++ b/tools/testing/selftests/bpf/test_xsk.sh
> @@ -73,17 +73,21 @@
>   #
>   # Run test suite for physical device in loopback mode
>   #   sudo ./test_xsk.sh -i IFACE
> +#
> +# Run test suite in a specific mode only [skb,drv,zc]
> +#   sudo ./test_xsk.sh -m MODE
>   
>   . xsk_prereqs.sh
>   
>   ETH=""
>   
> -while getopts "vi:d" flag
> +while getopts "vi:dm:" flag
>   do
>   	case "${flag}" in
>   		v) verbose=1;;
>   		d) debug=1;;
>   		i) ETH=${OPTARG};;
> +		m) MODE=${OPTARG};;
>   	esac
>   done
>   
> @@ -153,6 +157,10 @@ if [[ $verbose -eq 1 ]]; then
>   	ARGS+="-v "
>   fi
>   
> +if [ ! -z $MODE ]; then

better: `if [ -n "$MODE" ]`

note that quotes are really good invention for such cases, especially 
that default value of MODE is "take such named variable from user env".

> +	ARGS+="-m ${MODE} "
> +fi
> +
>   retval=$?
>   test_status $retval "${TEST_NAME}"
>   
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 514fe994e02b..9f79c2b6aa97 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -107,6 +107,9 @@
>   static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
>   static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
>   
> +static bool opt_verbose;
> +static enum test_mode opt_mode = TEST_MODE_ALL;
> +
>   static void __exit_with_error(int error, const char *file, const char *func, int line)
>   {
>   	ksft_test_result_fail("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line, error,
> @@ -310,17 +313,19 @@ static struct option long_options[] = {
>   	{"interface", required_argument, 0, 'i'},
>   	{"busy-poll", no_argument, 0, 'b'},
>   	{"verbose", no_argument, 0, 'v'},
> +	{"mode", required_argument, 0, 'm'},
>   	{0, 0, 0, 0}
>   };
>   
>   static void usage(const char *prog)
>   {
>   	const char *str =
> -		"  Usage: %s [OPTIONS]\n"
> +		"  Usage: xskxceiver [OPTIONS]\n"
>   		"  Options:\n"
>   		"  -i, --interface      Use interface\n"
>   		"  -v, --verbose        Verbose output\n"
> -		"  -b, --busy-poll      Enable busy poll\n";
> +		"  -b, --busy-poll      Enable busy poll\n"
> +		"  -m, --mode           Run only mode skb, drv, or zc\n";
>   
>   	ksft_print_msg(str, prog);
>   }
> @@ -342,7 +347,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>   	opterr = 0;
>   
>   	for (;;) {
> -		c = getopt_long(argc, argv, "i:vb", long_options, &option_index);
> +		c = getopt_long(argc, argv, "i:vbm:", long_options, &option_index);
>   		if (c == -1)
>   			break;
>   
> @@ -371,6 +376,21 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>   			ifobj_tx->busy_poll = true;
>   			ifobj_rx->busy_poll = true;
>   			break;
> +		case 'm':
> +			if (!strncmp("skb", optarg, min_t(size_t, strlen(optarg),
> +							  strlen("skb")))) {
> +				opt_mode = TEST_MODE_SKB;
> +			} else if (!strncmp("drv", optarg, min_t(size_t, strlen(optarg),
> +								 strlen("drv")))) {
> +				opt_mode = TEST_MODE_DRV;
> +			} else if (!strncmp("zc", optarg, min_t(size_t, strlen(optarg),
> +								strlen("zc")))) {
> +				opt_mode = TEST_MODE_ZC;
> +			} else {
> +				usage(basename(argv[0]));
> +				ksft_exit_xfail();
> +			}
> +			break;
>   		default:
>   			usage(basename(argv[0]));
>   			ksft_exit_xfail();
> @@ -2365,9 +2385,15 @@ int main(int argc, char **argv)
>   	test.tx_pkt_stream_default = tx_pkt_stream_default;
>   	test.rx_pkt_stream_default = rx_pkt_stream_default;
>   
> -	ksft_set_plan(modes * TEST_TYPE_MAX);
> +	if (opt_mode == TEST_MODE_ALL)
> +		ksft_set_plan(modes * TEST_TYPE_MAX);
> +	else
> +		ksft_set_plan(TEST_TYPE_MAX);
>   
>   	for (i = 0; i < modes; i++) {
> +		if (opt_mode != TEST_MODE_ALL && i != opt_mode)
> +			continue;
> +
>   		for (j = 0; j < TEST_TYPE_MAX; j++) {
>   			test_spec_init(&test, ifobj_tx, ifobj_rx, i);
>   			run_pkt_test(&test, i, j);
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index 233b66cef64a..1412492e9618 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -63,7 +63,7 @@ enum test_mode {
>   	TEST_MODE_SKB,
>   	TEST_MODE_DRV,
>   	TEST_MODE_ZC,
> -	TEST_MODE_MAX
> +	TEST_MODE_ALL
>   };
>   
>   enum test_type {
> @@ -98,8 +98,6 @@ enum test_type {
>   	TEST_TYPE_MAX
>   };
>   
> -static bool opt_verbose;
> -
>   struct xsk_umem_info {
>   	struct xsk_ring_prod fq;
>   	struct xsk_ring_cons cq;


