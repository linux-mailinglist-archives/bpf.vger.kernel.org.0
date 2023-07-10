Return-Path: <bpf+bounces-4612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D32C74DBCF
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 18:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5261C20B40
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 16:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EB413AF0;
	Mon, 10 Jul 2023 16:59:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9299134DD;
	Mon, 10 Jul 2023 16:59:27 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6CBF2;
	Mon, 10 Jul 2023 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689008366; x=1720544366;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KHy5aKolN4nYr0+aUZlkEwLp5IYIPqDWfI8ThkILgcs=;
  b=jqYZaj2/YVCMsrpYpCSRu5KcPvpry2l7WLktwiSmXzSoFC1NUuaTKo+g
   sYtbPyLmx/+yHCNtbFSBYb2z+hro5B03sQ/xWjmKIiKc7q67iUfOGmBxe
   wvwAKCEMDYJk4j3GcZvl35OwTeWrSGG543S8IQc68QQpvKels3O4Yx0e9
   ko31sGsC4SYK+PCpMGnUMBLZ8Gneyhbpg25AtTqlIB53AV8ay9ToXkwUN
   p4u8T24oEqRspGQCsY/IPO+51qSy0YDs8uZWSew97XREQbRVxtam1WsS9
   25oyqM5cn8YCcjc4eenvgV/e3hT1wNAHbvt4JhDBimBRydo/Owme6ZURb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="367892605"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="367892605"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:59:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="967488238"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="967488238"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jul 2023 09:59:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 09:59:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 09:59:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 09:59:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 09:59:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUGRPaYrjX+n4bIJYhXdltXy54R/LeGvSn+YGldFqtujC6oHbHjfIvA91xJJoDCnEM4GACRHnlJE5B4w1zzWFm0dzllqhNyFNJNMkb/43F73G7zxNy6PkZQgUD55eFLXWgWkn1HiJIYrjoWSaxsM793E0p8ZZ0ie0cA07vH9eXpPC9oMuy4JawAF/y27ryUwFlUfnWAySi0+JM70dMP8PWk9Ftz0/2Ji0t9gvZQEqw6jzYqG70UQgc301oCsdG+ApwqkXawJYc5RLZw9h8CNsR6MqqBIUxoOAaoqlSbAS6aAxg+HU1hCYfEx/C1RNvUKD0VZa3Jdqcy7NJx88oNClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEwc6ZrGa7LzbVFAjmR5SP8ozm2uxFxVcHp+LB4M8AY=;
 b=N+1pyekafFJ12wImFvSZN3qXGmfmixWgbV4QBp1atZsC2NnfXDFImjANvztLB8G11vDnbnYJjCNot2kn32zG/wWgeHBfLriN90sjhfkUXSyGmx82kNo0TNVJFnZSkAypVstQSQs6SOT+aLGJGI/24KHAv0GNWV8aEvox1QeEWqjPRWZHRXK9TFsu6DHx80uWQxFkbjn9f8wO4ULYh/Dqw23WK2TmpPU9MB+fvTTNmdzxtJUINzf/WSV27rRUqvgFMFNmfo8Bq4hrI8+lu+u43iFx7hIhzJQ+XA/Q40UueAn8nVK31jdLJ4xCHX2gFn5x6yDXxQQhQzdcMycJpAlEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CY5PR11MB6188.namprd11.prod.outlook.com (2603:10b6:930:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 16:59:19 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 16:59:19 +0000
Message-ID: <51bf0e2a-017b-f89b-e202-bc3978d60623@intel.com>
Date: Mon, 10 Jul 2023 18:58:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v2 12/20] xdp: Add checksum level
 hint
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>, Jesper Dangaard Brouer
	<jbrouer@redhat.com>, John Fastabend <john.fastabend@gmail.com>
CC: <brouer@redhat.com>, <bpf@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yhs@fb.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin
	<alexandr.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>, <xdp-hints@xdp-project.net>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Alexander
 Duyck" <alexander.duyck@gmail.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-13-larysa.zaremba@intel.com>
 <64a331c338a5a_628d3208cb@john.notmuch> <ZKPlZ6Z8ni5+ZJCK@lincoln>
 <9cd44759-416c-7274-f805-ee9d756f15b1@redhat.com> <ZKQAPBcIE/iCkiX2@lincoln>
 <64a656273ee15_b20ce2087a@john.notmuch>
 <3cc1d2ba-e084-8fc4-aa31-856bc532d1a7@redhat.com> <ZKa1ydBpmDCw4Ejp@lincoln>
 <ZKa4aCHDrG2ZVI8H@lincoln>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZKa4aCHDrG2ZVI8H@lincoln>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CY5PR11MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d9bfc4-5449-44b1-92c5-08db81670069
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0g/exMYV8cak0IP3mBtJDI8gTHyz7AAe+Tz7iKDpC1kyImP7N90PIIt4rAaLezpFRVgV856lvZLl2miOgqD74TZ+7vWxV8SaeaJDGwZ9O5tsPepYXowQnYc7fK32m6cM04gdOINIHtyWhzLQbaEXggHxVa21s2s91ZJ5dVaCQMcLkkX3+XPrLE7r2e6vzDq6UpHWKuvU3F9IJqzjpe6yPGfYNMd4Z2L2OW9TCRFX0Mkur0hL1jnfL9H0tcDT2AvE+3kJbTaxtShbYL1S2wQwQy8w3oN55Tvg9AsbhYoGrExjXW/P9ig0u40ygqgHh6NuzGfJchFz6dmBSUtk5qNJXticYykEv+6wAszyXpmJaMPV1tr5llZH4/Rv16pAhRJJaqs1fLlcChINR6qjB0V/tEpvcMv0NjB5kegqSF8DX/vchwPSdU29GN4DmWpU+7R6Un72f+UHg0N5bpH7o3Pv/lgPvRrLa9upD2ysUiK0v7VD/F3fcWzwmf2l814d2iEouOVCzTr7DNiLCmt9UAwdE7bp9RIcdHe4/CzAv7qyKUyfTFw/JET5gi9DBoqQHEhKuLvAp5Fra0GvPjBvbKOaYqnq76Kc+Vek+PMwVBc44+hAsB62FF9qVOqI2GufxShdc80TOacmW5QDRRQyj8FNyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(82960400001)(38100700002)(54906003)(110136005)(6486002)(966005)(31696002)(86362001)(6512007)(6666004)(36756003)(478600001)(26005)(186003)(6506007)(2906002)(41300700001)(83380400001)(316002)(7416002)(8676002)(8936002)(31686004)(5660300002)(66946007)(66556008)(66476007)(2616005)(66899021)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFJJTDBLMURHcnBaYTNiaU9pRDUxNW9ldXkzL2t4YytQRnRGTUNTWEtDc2po?=
 =?utf-8?B?OTRqVnQ3c0s4OFliWjF3VnRGaHFtOVk1U1pKYTVBTW8xNVhpdkNBRmtxalR5?=
 =?utf-8?B?THFmblVZRW51d0EraldRdzlja2dlMzdvT0VZOXhVWHNPc2tVOUpXNnVEYlJj?=
 =?utf-8?B?a25UTS9EM2l6cG8zRFAveDlNUUVaVklDTjRZdGdjVmtEclVnSjhBeCtwSU1T?=
 =?utf-8?B?SUpaeXZOUE1QZkF1VmRjejh5QXBXMnZsQy9RcDlsMXY5ZW1PRzRDc1hDb3Jp?=
 =?utf-8?B?V00zVzBKcE9zN3pyVHJjdjVTNXJicVU4eVpCQVFQQXQzTVVhcjRTQ2xrQVFW?=
 =?utf-8?B?N0xBQWRobHFORHVjL3A5NU5IaXAzaThaKzUrcDZLMTBra0ZjN1laWGlmQUdW?=
 =?utf-8?B?TmNZNklpWU45YXFSeG9xajIwSHhwQml1dG9uc2UxZ1ZnTThSeEc5Ri9CWU0w?=
 =?utf-8?B?aEdraDFMUGRpczdiQURSckRxZUJHanc2Mm1JSlhvRmNtR0ZCeGF4OGh0VzFT?=
 =?utf-8?B?VDFLOHprU2YrU1VsWE81RTJSY3JzVUExL0VUYm40UitPNllDcUk4ZVdaenZW?=
 =?utf-8?B?Y1JWMFIxSGl1OUV4aGtKTUlhUVpaVVZlQnlIeUN3MTFDQU1tYzRaQit6bjJX?=
 =?utf-8?B?K2VFOExhZTZKeVNjd2lENEVKajgxaGFzNEZHSjlkck9XM1pJM0ttM3JxaklH?=
 =?utf-8?B?MVVTejdYZkxxbERNY1NwNnVZSjJiYWVnV2ZFUGdpUm9nTnNJWVVCWXUwRS9i?=
 =?utf-8?B?TDBtYloyNXJRTTBWdzhlRUFldWtXdXh6VnpubTVIeE9xT1VzWXRwZjdEYllW?=
 =?utf-8?B?WTJjc2Exd3AvbExaUm56VlR4cUliSC9sKzY1ajRmR1FUT0l2K1RBb2dPeXFC?=
 =?utf-8?B?cVZIVWE4UERnZjBjRWhtMmVSdjRxR1pXY0drWGlnTTVSS2lES1pkQjRJbXMr?=
 =?utf-8?B?VUc1TFl6dCtGeGRaWllFSEZrNWtySzVaTyszNjMzL2ErOUE3cWREVEc3V2Ju?=
 =?utf-8?B?ZlNzMGEvMGY1MEU1NDh5dmNVejZMRTk2MW45WXpZVENKZ0tOQ0Z0REJUSE80?=
 =?utf-8?B?VUxvVGNqN3YrT2N1bENLeWY3ckplNnFoWjlEbnpBc2U2MHhOMmJCaGtlV25y?=
 =?utf-8?B?Y0Y4ZW55S2xkYVhjZVl4WXVIbmhqbDhDTHlIY0tyQ1d5NDdWNGlVZXZvNlNM?=
 =?utf-8?B?YnB6aTFiOUNVNXdFemRMcC9LaEtpemp4NHNiaWVud3pHZUtFcTcrMzBoTTI3?=
 =?utf-8?B?TXJ1SFVGQ1laT3hOVFJiNmNtMEtGWnRML2Zoc3NxUUt3Mk1lTG1sOUFjWVkw?=
 =?utf-8?B?eWpqY2l3blZ0dUxaczBvdlV1c0twNzhXclQ1UWJnT1M3UHNuSDFBOWhOekxw?=
 =?utf-8?B?NEZ4VVU3c042Wm43VWtyWG1QYTdzWkpFQ3ZBRU1qUGNsNGdKSzYwVHRCWFhY?=
 =?utf-8?B?YWJsNDlLU3krMDFiMXkrMjBnOFdRYWFOL1JjSVJWUHpmOXp2UFQzOTIvazNF?=
 =?utf-8?B?dFp3OG1DR3pZSFoxRlo2SkpBZVZlQmhMVWNVbXNFOExqcVFEQzBpZlZpZHhO?=
 =?utf-8?B?QWdXN2VGYitaOWZEZjVpMVRmTTRVVXBFU1BYTCtJU24vNzVKcnpWTDk4OWRj?=
 =?utf-8?B?SldRMElIZ2hBRGxBYUthcnBNTkQxLzFiMFVvci96Sk92UEJiWjd2TEdYMy9j?=
 =?utf-8?B?WjM2ZjNLMGxZZTBFVkpqSzV3WkVTM2lid0pGQ2p0M2plU204M3hHdlRFTVZs?=
 =?utf-8?B?TnhFS1p2WUZQL3dpb3M5RGtrUXZ5aVl0K3JNNURGY1kxSlE5eHVTc1BPZXF2?=
 =?utf-8?B?TWVpMzNya0dKMGNwN040M2M1NHl1ckFrVjJiUkJTZWxKdDhRNGN3dDZLM1RC?=
 =?utf-8?B?aU44S25pWmMvQlljK1ZsUk9Ob1NQRTdnMk9wbGRwR2xGWWdtNTVJMURRUnR3?=
 =?utf-8?B?YnhVY2MxeE9IbXB2NU56VjlaZUw1aXhIQTZzWVZFWjBvb2ZIc0Y2Vm9IaTRN?=
 =?utf-8?B?OXY2OFY3bHY2NEIxQmQ2Z1JKUE9zYzV6M2FqK0dEMmtic3MwalJiQkJvS1g2?=
 =?utf-8?B?a1UxQStnV1NBejh0N2VlNTM5N0QrbFdCbGZuK1U0VHljTGFoRDhodWhhaXda?=
 =?utf-8?B?b2tpMTllMVJEbUlQUkpnL3N3T3VWV295Zm55ZlpBc1kyMkNpQVdXY1V1K0Rk?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d9bfc4-5449-44b1-92c5-08db81670069
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 16:59:19.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKQjNkiscPD2GuPzrsDuU5ObAG6MRfpBMOrRhLIDE5ETTDDZuYDwT+ZZ2mnbnTXQJA7TqyYv97vmoIsF70kuZz0dNI8QdKET5R6GzHK3CgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6188
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Larysa Zaremba <larysa.zaremba@intel.com>
Date: Thu, 6 Jul 2023 14:49:44 +0200

> On Thu, Jul 06, 2023 at 02:38:33PM +0200, Larysa Zaremba wrote:
>> On Thu, Jul 06, 2023 at 11:04:49AM +0200, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 06/07/2023 07.50, John Fastabend wrote:
>>>> Larysa Zaremba wrote:
>>>>> On Tue, Jul 04, 2023 at 12:39:06PM +0200, Jesper Dangaard Brouer wrote:
>>>>>> Cc. DaveM+Alex Duyck, as I value your insights on checksums.

[...]

>>>>>>>>> + * Return:
>>>>>>>>> + * * Returns 0 on success or ``-errno`` on error.
>>>>>>>>> + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
>>>>>>>>> + * * ``-ENODATA``    : Checksum was not validated
>>>>>>>>> + */
>>>>>>>>> +__bpf_kfunc int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
>>>>>>>>
>>>>>>>> Istead of ENODATA should we return what would be put in the ip_summed field
>>>>>>>> CHECKSUM_{NONE, UNNECESSARY, COMPLETE, PARTIAL}? Then sig would be,
>>>>>>
>>>>>> I was thinking the same, what about checksum "type".
>>>>>>
>>>>>>>>
>>>>>>>>    bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *type, u8 *lvl);
>>>>>>>>
>>>>>>>> or something like that? Or is the thought that its not really necessary?
>>>>>>>> I don't have a strong preference but figured it was worth asking.
>>>>>>>>
>>>>>>>
>>>>>>> I see no value in returning CHECKSUM_COMPLETE without the actual checksum value.
>>>>>>> Same with CHECKSUM_PARTIAL and csum_start. Returning those values too would
>>>>>>> overcomplicate the function signature.
>>>>>>
>>>>>> So, this kfunc bpf_xdp_metadata_rx_csum_lvl() success is it equivilent to
>>>>>> CHECKSUM_UNNECESSARY?
>>>>>
>>>>> This is 100% true for physical NICs, it's more complicated for veth, bacause it
>>>>> often receives CHECKSUM_PARTIAL, which shouldn't normally apprear on RX, but is
>>>>> treated by the network stack as a validated checksum, because there is no way
>>>>> internally generated packet could be messed up. I would be grateful if you could
>>>>> look at the veth patch and share your opinion about this.
>>>>>
>>>>>>
>>>>>> Looking at documentation[1] (generated from skbuff.h):
>>>>>>   [1] https://kernel.org/doc/html/latest/networking/skbuff.html#checksumming-of-received-packets-by-device
>>>>>>
>>>>>> Is the idea that we can add another kfunc (new signature) than can deal
>>>>>> with the other types of checksums (in a later kernel release)?
>>>>>>
>>>>>
>>>>> Yes, that is the idea.
>>>>
>>>> If we think there is a chance we might need another kfunc we should add it
>>>> in the same kfunc. It would be unfortunate to have to do two kfuncs when
>>>> one would work. It shouldn't cost much/anything(?) to hardcode the type for
>>>> most cases? I think if we need it later I would advocate for updating this
>>>> kfunc to support it. Of course then userspace will have to swivel on the
>>>> kfunc signature.
>>>>
>>>
>>> I think it might make sense to have 3 kfuncs for checksumming.

Isn't that overcomplicating? 3 callbacks for just one damn thing. IOW I
agree with John.

PARTIAL and COMPLETE are mutually exclusive. Their "additional" output
can be unionized. Level is 2 bits, status is 2 bits. Level makes sense
only with UNNECESSARY (correct me if I'm wrong).
IOW the kfunc could return:

-errno - not implemented or something went wrong
0 - none
1 - complete
2 - partial
3 + lvl - unnecessary

(CHECKSUM_* defs could be shuffled accordingly)

Then `if (ret > 2)` would mean UNNECESSARY and most programs could stop
here already. Programs wanting to extract the level can do `ret - 3`.
One additional pointer to u32 (union) to fetch additional data. I would
even say "BPF prog can pass NULL if it doesn't care", but OTOH I dunno
how to validate PARTIAL then :D (COMPLETE usually assumes it's valid)

>>> As this would allow BPF-prog to focus on CHECKSUM_UNNECESSARY, and then
>>> only call additional kfunc for extracting e.g csum_start  + csum_offset
>>> when type is CHECKSUM_PARTIAL.
>>>
>>> We could extend bpf_xdp_metadata_rx_csum_lvl() to give the csum_type
>>> CHECKSUM_{NONE, UNNECESSARY, COMPLETE, PARTIAL}.
>>>
>>>  int bpf_xdp_metadata_rx_csum_lvl(*ctx, u8 *csum_level, u8 *csum_type)
>>>
>>> And then add two kfunc e.g.
>>>  (1) bpf_xdp_metadata_rx_csum_partial(ctx, start, offset)
>>>  (2) bpf_xdp_metadata_rx_csum_complete(ctx, csum)
>>>
>>> Pseudo BPF-prog code:
>>>
>>>  err = bpf_xdp_metadata_rx_csum_lvl(ctx, level, type);
>>>  if (!err && type != CHECKSUM_UNNECESSARY) {

And hurt cool HW which by default returns COMPLETE? }:>

>>>      if (type == CHECKSUM_PARTIAL)
>>>          err = bpf_xdp_metadata_rx_csum_partial(ctx, start, offset);
>>>      if (type == CHECKSUM_COMPLETE)
>>>          err = bpf_xdp_metadata_rx_csum_complete(ctx, csum);

I don't feel like 1 hotpath `if` is worth multiplying kfuncs.

[...]

Thanks,
Olek

