Return-Path: <bpf+bounces-10046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576967A0AC2
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BD4282589
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296B241ED;
	Thu, 14 Sep 2023 16:26:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187DD210FE;
	Thu, 14 Sep 2023 16:26:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC171BE3;
	Thu, 14 Sep 2023 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694708788; x=1726244788;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LE+Gkx4kAGXTKUvrCKUNAvytJDrbncBkn/w3EZrbMWw=;
  b=e/Yp+sNSLZCpS7bm6OHeJDbAGtCWA0T5USdtKhIOe50+0gr0TTK789yO
   nqpWRhltkFoGAtUIW07X32B1ocsAEJ4cXlBngad8YrPNAwx5Ae6x9is09
   Y1QVgGBxrraZhotyPnjv0iSXOYXw9q+oKZmaGvhfAReyHF6k2xUurIlCX
   gD3ftJb6TB4qw4q4jj9AnOMvp50UjeSkm8OYdHpK6xzzLpzwKt7LBGbAV
   vpbDMNyWdaYiDEjw9R/zANnLwvZjqU0f7fABXBVkwWCliAbSUEV7aveEA
   QAIssHVs3XblV1icmMuvsAoM2tmBfLQ/c6pBz4ZERjQt8PRfycFGXPAJW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="443052134"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="443052134"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="694370917"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="694370917"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:26:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:26:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:26:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:26:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:26:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMX81q4pERT9JdIFNs9HlyiMTC9D9iPpwgXcI6AOtwsRl6uUcHSAibhUqAZfb9Icwb/A8jK1aXPa2Y7MKnfmfv2M1dSrtPMnMy5KdJ4Q/cuZMi/t1GSK6R7ViJxtptLCMPSvk9+nN0LgH2BAI42hGA1RcfvWNWrjEGNwxZYQwpi9AODjq5iGeG/Jk1zy6EIkoX0ZndgAPPIg02NC2QJs2Sd+Fo+1DsyG5qXolCJFvVLfOM0WuNRJVKfBXKjUx3xBCMCmKDLaxDBiUzee4s393fPR01hn6GJnrM5Vzbdxp3uEDDL7eNVyqhyyCQPEdPKv/MKqvu+f1tMXPVJv1KOCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqQ3sR3sc4nUHZueJSSWRODz8gi+Iia1Q52SY21I4q0=;
 b=AL+b8kYXfH/GUzbYu+S8j43I7eElWmxMkWr+Gzi6SRYJmpxs0H30o5GzDldG2/LJp3SQby8wHTLyS8wGioyLBb75bs48xSJTmQ3TiAi81g33BBPlyCEPXXostrsn/8P3SIlS0sdKuzHeZr1MCsLw6VqQeA4uW6rq4rvDZyDmvs73nSOKQGpzxGDSGjw73XeRz+s9mTl+BRQ9mvcWM+TSTS2QcgNIG6yHS/HtK0o8um+P8M7QLZ/l+zS3n5uTS9qMLhyVxvF5iErnRzueXGTlCRrHpt/CVov2MrEI4mzEADbz72069ARqltSjSERVWbUHcmd5ZtJZCOySBoYNS9WSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH3PR11MB7251.namprd11.prod.outlook.com (2603:10b6:610:147::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 16:25:58 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:25:58 +0000
Message-ID: <0abb29d7-fcad-c014-ea06-c7ec9460245e@intel.com>
Date: Thu, 14 Sep 2023 18:25:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [xdp-hints] [RFC bpf-next 10/23] ice: Implement VLAN tag hint
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
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
 <20230824192703.712881-11-larysa.zaremba@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230824192703.712881-11-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::7) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH3PR11MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 016d33e4-6707-40cf-c748-08dbb53f470e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCQjlqI41KeaPkcM/Cwji8DixE1x4s6bQQ8ChhRCjzDrngb/SNGMDQXMIFc9l7VWmM8Gg8IPtQ+vXGoXyZFMDLjdJPYs+SxxVceYl7mjHWE+gXTCj2mDhVfvPQXU/oQp4qEZEvmt3ADFbAOF82E435VIHkkjGYRV9P3kkhuBPUX2/bWWoV19f3xI7vQKSaYg+37KDoMy6aItis5c71Xx9+gZ5vALlGLbNDBKmcuEDLz6sefRjN7pMtHGF7ZoLTEO5Xmw5Upktmbwn6DywNwFzqXO1EmvMHTvwEQVfad52ac/a619gqjyP4+oegnmMDECVes7uRq7PVTsoZ6cV04osvAz28MnVET/PqHe/w/9lz1MjISd8rTMISz5oWVa3tEfGIBBNfHYQJiSpePuX3hdcn8SfWY8b4smY9Vv8Qie6wkANWl0ZUJFa9qqg8fExE4nWQbOIzZEzLGkzLEo+/U5PLhzpYpLMeLNGFlYsjM3wjRtzfOAJFznpahyHn2FOYbJrWG+BnpC+1h8vZVaOCj6JKMx/WTIf63KAN8LziEHnSSSjDtl+XIRXtGvoCsf8+HWet8UjNxz5tI4/GM6edJzF8aU4yK3gL+bJZyIGr0aLKSQDQMlXjffV8railYPJVpIS+XkVZXK8tbuGnNgAgnIkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(186009)(1800799009)(451199024)(41300700001)(66946007)(66556008)(54906003)(37006003)(66476007)(316002)(6636002)(478600001)(38100700002)(82960400001)(7416002)(2906002)(36756003)(31696002)(86362001)(5660300002)(8676002)(6862004)(8936002)(4326008)(26005)(83380400001)(2616005)(31686004)(6666004)(6486002)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGZ5MUpPZVJzb3JTdGU0S2M5USsvV01VMm5hU2lVcFZHdS9pZmFzZ0wveUh5?=
 =?utf-8?B?QUdoNkVLZTYyMXlYY0xYVnRhWncwY2V5aHBCc1ZZajBFKzFIUzloalNRNThB?=
 =?utf-8?B?dCtmdjl5eEpVbitzSEFiK0xQNnVBVFJFU01YbWhSQWIrYzVkc2RyVXkwZ1Fm?=
 =?utf-8?B?bGpueHhqUkovZm5Mb1JkdUtielA3YmdsOEY0WjJ0QkNtaHhoTTJoMWczTnFU?=
 =?utf-8?B?VHFmdjlZUlpiRjRKcXRqNG1IQ2ZoVG1SWG5aOW9CbmxneTE4b1Ava2Y4RkZK?=
 =?utf-8?B?c1F5YkF0OFF4OExJclAwbzN3cWk0aWVkRFVBdHA3cE16SUcvTzc0cXIrdHha?=
 =?utf-8?B?dkRZekJZUC9Bazd5TjE3enN6c3Rkbm1EVWhtMjZkaEdteEJtV3pEWDlRSStx?=
 =?utf-8?B?Y1UrQ2EzbE1PZldxU3BpWnAvdzZkRmpaVnFwVURWR2tQc3JydTJrcTJaWDJC?=
 =?utf-8?B?Y09hWkUzV3Bpdjh3OFRqb0dKRFVOQUFzTnBxd0ZxVUtPdUtXYjQyZ1pZV2Zl?=
 =?utf-8?B?REQ3NTY5N3o4eEtSYXlXbXFBazNsaW5DVkFHcnZ5K0xPeC94OUoyaXNYYndU?=
 =?utf-8?B?Y0ZCc1h5ZWV1aVh4akhDYjBCUnljOEdVSUR1ZEVvRWMwd2N1K25vRkdvSkZP?=
 =?utf-8?B?cnltNHBXc3NMdjNnTmJ6UXNLdkc4MkVNOS9DRUxmeXJNcm5BYmJPRWtlbjVi?=
 =?utf-8?B?TFhPWVBqRjJjVFhmbG16UkNSRDhKd3dlTzc1SHFST0pWVjlMekN2SlprSVVh?=
 =?utf-8?B?Mjl4RU52VWZFNWg3VmlQbE5XcVY0RFZnai9SVktoN3AvV0c2U3R2TnN6bldC?=
 =?utf-8?B?L0J4S1o3akg0emRCa2RjTElWSFFQUTVuOGdKV2lpMWM0OW5sakppdzNmUXFk?=
 =?utf-8?B?dFE2U3kwQ0hqdGdBZlR4UmN2WUFqampheEdVeTBpRStEYXQ1SWVienF1ejZ1?=
 =?utf-8?B?QUwxUmhhUlhsWlhWcWNVQ2J3cXUvbW9FbU41cEtQS0dPd3FWWnJreE9Xdk10?=
 =?utf-8?B?SEZHZU5EN1VhVkpmTVVNWDRnSHN4YVVPWkpScFFBZXZuUDdJMDJ5OHlZY25S?=
 =?utf-8?B?WDM4LzZ6NFhKcHJaTE5VWDJkZ1FiRHQ5dGZkRTFIQ2p6YkpjYWh3T2hNZFBa?=
 =?utf-8?B?aU85VDZrWGd2eCtIU1IyaStIR2tuc1k4N05HTzVzcFVwT0Rxa05PaXNCU2M3?=
 =?utf-8?B?QzRScVV6MVVnQk51VVgwK0xTaHRrMXFQajZmQktQSXQxK05oY3J3Wi9MS1pr?=
 =?utf-8?B?OTJHUVFBaS81T3ZOMmZYQ3MxOC9EQS9KOVc4OUlRQ2x3T3k4SWxXcHhjanho?=
 =?utf-8?B?ay9kaWNrYldNREdkV1E5TG1UUGgybkRyVm9DdjZuYVFZRWkwNjlsOEZYa1JO?=
 =?utf-8?B?RTZsOFd3S2ZtY3lwTEhxbnJ2WEFqVmhpcWsvZVNKaHVXajdPeG1ienh5SU9L?=
 =?utf-8?B?OFJDWGxSRjF5eDRtUDk3dGR5dGVsSk5lTjJ0SERmQTM4bWsyNUJxa1p4STNT?=
 =?utf-8?B?ZllEVnYzVHlYWlBFWlBTZEQxWXpwM205TkpxZTR2NEdBUVFZSzZUOGc0SVNk?=
 =?utf-8?B?RFNjc3B5UnQxdHZ0TDZjSnJoMGRmbGY5YVlrUWRQL0pJd21YZDZZL05QZ09Q?=
 =?utf-8?B?RDBqQW1CT0NENTYrSWNiYTZpbUY4aTNqNGVFV2Y0N2sxbitxSFEwRnMzKzM5?=
 =?utf-8?B?b05VQU1pbnoyL08vanlEam1vOTNKL0RxdU9qaVJxUlVYK0lqK29mb1grMVF5?=
 =?utf-8?B?azJMSHQ3eEMyZnVWT2NGUi9sMVA3SUJ2NDU4SG1XSllMSHJkME5iaW5WZTdK?=
 =?utf-8?B?ZytsZXBKU0ZBRXdFNkxKL3dBUmRHYWdrK05wWFdZYmxzQktLNzgwV0JvLzBl?=
 =?utf-8?B?TkRjTU5UNDg4dzRMblF2bEF2dUxtcjZLaHlKeFNtOEwwNCtVN3h6Qm53aTlO?=
 =?utf-8?B?RjZGN0Q5R2h5bGFQWE5wVEQ5WjE5VXJMZ3RGWEM3MkhUSGFSK1Y2NWYrZzlQ?=
 =?utf-8?B?VmwrT0ViMTR6N2lCelNvYmpILzNIb0tPdjgvTG1nZzNtN2R0U1Q5aFpEanF1?=
 =?utf-8?B?L0w3Z2pDUXNFUDEwNjFCcW1DNmtodkV5UUluU2ZSdXRvdCtEam5CdWRET2tY?=
 =?utf-8?B?Y2J2WlhhejBqUTY3SUpackpGV2pnSWpEa3VqZmtxcXpMbS80YVp3RjlHdFdx?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 016d33e4-6707-40cf-c748-08dbb53f470e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:25:58.5887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgH4E0C//raRC4bmQhrX3W9TU2aUPW8GykTFedHDqJKBlkQOK8syK1w/jJFxdgDvI2egcxTVab2jNtNseFdNapcIJeM+VEOrJjXPUpbGj1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7251
X-OriginatorOrg: intel.com

From: Larysa Zaremba <larysa.zaremba@intel.com>
Date: Thu, 24 Aug 2023 21:26:49 +0200

> Implement .xmo_rx_vlan_tag callback to allow XDP code to read
> packet's VLAN tag.
> 
> At the same time, use vlan_tci instead of vlan_tag in touched code,
> because vlan_tag is misleading.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c     | 22 ++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  6 ++---
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  4 +--
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  6 ++---
>  6 files changed, 57 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 557c6326ff87..aff4fa1a75f8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6007,6 +6007,23 @@ ice_fix_features(struct net_device *netdev, netdev_features_t features)
>  	return features;
>  }
>  
> +/**
> + * ice_set_rx_rings_vlan_proto - update rings with new stripped VLAN proto
> + * @vsi: PF's VSI
> + * @vlan_ethertype: VLAN ethertype (802.1Q or 802.1ad) in network byte order
> + *
> + * Store current stripped VLAN proto in ring packet context,
> + * so it can be accessed more efficiently by packet processing code.
> + */
> +static void
> +ice_set_rx_rings_vlan_proto(struct ice_vsi *vsi, __be16 vlan_ethertype)

@vsi can be const (I hope).
Line can be broken on arguments, not type (I hope).

> +{
> +	u16 i;
> +
> +	ice_for_each_alloc_rxq(vsi, i)
> +		vsi->rx_rings[i]->pkt_ctx.vlan_proto = vlan_ethertype;
> +}
> +
>  /**
>   * ice_set_vlan_offload_features - set VLAN offload features for the PF VSI
>   * @vsi: PF's VSI
> @@ -6049,6 +6066,11 @@ ice_set_vlan_offload_features(struct ice_vsi *vsi, netdev_features_t features)
>  	if (strip_err || insert_err)
>  		return -EIO;
>  
> +	if (enable_stripping)
> +		ice_set_rx_rings_vlan_proto(vsi, htons(vlan_ethertype));
> +	else
> +		ice_set_rx_rings_vlan_proto(vsi, 0);

Ternary?

> +
>  	return 0;
>  }
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 4e6546d9cf85..4fd7614f243d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1183,7 +1183,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  		struct sk_buff *skb;
>  		unsigned int size;
>  		u16 stat_err_bits;
> -		u16 vlan_tag = 0;
> +		u16 vlan_tci;
>  
>  		/* get the Rx desc from Rx ring based on 'next_to_clean' */
>  		rx_desc = ICE_RX_DESC(rx_ring, ntc);
> @@ -1278,7 +1278,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  			continue;
>  		}
>  
> -		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
> +		vlan_tci = ice_get_vlan_tci(rx_desc);

Unrelated: I never was a fan of scattering rx_desc parsing across
several files, I remember I moved it to process_skb_fields() in both ice
(Hints series) and iavf (libie), maybe do that here as well? Or way too
out of context?

>  
>  		/* pad the skb if needed, to make a valid ethernet frame */
>  		if (eth_skb_pad(skb))

[...]

Thanks,
Olek

