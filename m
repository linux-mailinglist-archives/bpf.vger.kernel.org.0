Return-Path: <bpf+bounces-6778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FD376DD71
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 03:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63FA1C20DF2
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 01:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB0E23C9;
	Thu,  3 Aug 2023 01:44:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CB7F;
	Thu,  3 Aug 2023 01:44:19 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FA5115;
	Wed,  2 Aug 2023 18:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691027057; x=1722563057;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=49y0opWBAYqY/D90gek4GJL7tEOTHo65GDF+50oNtr4=;
  b=ZX5/UFqvJDigYkoHIQswbo/iSBjChK4kDjz+MmSWqK3cSwDE+oZH6ylP
   MCPOLsVChiZ7nuSQc4t2fvF6fUhu9cmaQZgrfdOyuvHu+mXDEhwLeAk5x
   1OuENpPkgy/PtXqsffd1meO0Dv9tY3ICxqsQrUCr5WctQ4ICp8s1odP7w
   t6g/J3bwuxN8DE/Z9a6Ot+xw74UmMtlbsZgKa6JK3oDpPpz/IJY5hfda+
   zzYK+jy3TE05GC4aytmgdTIqZQQtUtxpQk/zbwbRz6XJYZWtKCa5zAKlP
   /Ma/pAI2xdPbXWqHyUEw+OMWIqg9oKknI3QhRowewukqSfOF/68c1uxmp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368644522"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="368644522"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 18:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="853055857"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="853055857"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 02 Aug 2023 18:44:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:44:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:44:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 18:44:10 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 18:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ap06djpGxldIlbPzVavq/3uYyTSYrV+XT6/bjJ+x1Wg9uHb8fkH9ZX6Oaahvj0wnE8vS75cAnZDHdrSAz4Vxfk1jtW1gAjkFtGSklTNvBSBRCosdp9X8YORUdcdFiY11Oc6zkYyPvu5mR1Rxc30iPAbmyMYR5AZCP/rf5vQEPNfX+TmKPskVIxipmk3g5c/OBdq5f8q1bl2WURAeYzptrhpEzShOjTkhFRiWJv7lvJqEtJNHA5hpMYfaonzr56sMQAGyNYZEmJMUHgCRleT/mQzE4c/CSHT6mcS5yeAL05yuXC/pxoiuMkT8IVvLE/IXepQt1O6oqbb9LaMnSfcpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/aAZVW9ozMHewXpwrVwf0XWt0rG3qUS68QxuhEghKY=;
 b=kdyDU8fAfM7L6SBSplJS3zU6zhY8Jy8MsRIQi6lw45yL57fQ22gJtwnJ8f3h8gxPhugWWiK3wMnZZLM0RrWpeC6VcC/9crmC5zY0mWPiDvQL0s+6wIzOl2YOR4gYhfAgcNMdDjqriAVkb5n8B7P0ENRrF2IzaUnpW3tVVlKJyeMpyMLpxswHKnchaXyxR5J4xCQoUHwUTdFaofEPVUcIuBjXzeLP5gB8xXJ+8qQFYIQsaiRn9A3r7S8fKgbBFrYxBUyjgjwItOC2ZOFEDOT3gXQMoDbLD8M70tYti9rIVU2DoLOIliZhjVYADmJpCbo6hgXx2J7oC9bczx7ri6RqRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by SJ0PR11MB5895.namprd11.prod.outlook.com (2603:10b6:a03:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 01:44:07 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 01:44:07 +0000
Message-ID: <e1093991-6f54-2c8d-c713-babac0d216d4@intel.com>
Date: Wed, 2 Aug 2023 18:44:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH V5,net-next] net: mana: Add page pool for RX buffers
Content-Language: en-US
To: Haiyang Zhang <haiyangz@microsoft.com>, <linux-hyperv@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <decui@microsoft.com>, <kys@microsoft.com>, <paulros@microsoft.com>,
	<olaf@aepfle.de>, <vkuznets@redhat.com>, <davem@davemloft.net>,
	<wei.liu@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <leon@kernel.org>, <longli@microsoft.com>,
	<ssengar@linux.microsoft.com>, <linux-rdma@vger.kernel.org>,
	<daniel@iogearbox.net>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <sharmaajay@microsoft.com>, <hawk@kernel.org>,
	<tglx@linutronix.de>, <shradhagupta@linux.microsoft.com>,
	<linux-kernel@vger.kernel.org>
References: <1690999650-9557-1-git-send-email-haiyangz@microsoft.com>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <1690999650-9557-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0343.namprd04.prod.outlook.com
 (2603:10b6:303:8a::18) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|SJ0PR11MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: ec261556-1551-4c30-e62b-08db93c32029
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajl1ZhR7IkKj4JnGVjKaC9nH5BTjG8pbcrSdMNJ6lmTwya9OG12YJqPqYuFJJn3lV7y8jAOX8d0ROhM/fKmp+NYPpw8cRKKJVxUqs6cB0gXCKN8v+zRD/HHVByDZyKLmMkjXXJxezWszzD/LR9foOZ90NMWXNUMHBKx+uP+/+c5+m+sV6WDtr1J8s3E4LA+C09sPk7J6FPbZcsb/glLpOOH9FWYgMBN7+O2nL0HcW0e3VS3BCOcYTMNK5vgo6RBiiblCQ+m3J0zYPBYhEFsCZVA4zYttR/7baTY9H3B5B7edJ2DqkDJgLagtEGrw3s1twAI0oiRhKPmn7zHOE2lxmaB5y8MstMWEtjkKderbi/xjelJiRByFZr6vMpAxJ2eAUtN2c30BhCR/e/hmHR+7cxqQsx7gpCIjyovr2Q4eUC8Jty8Alu4eW5Q3LopjXhBsA12d/x+LHnoqviAeeaJMAVLB5NO3UBIc5xllmgfQGPohonv2IzaGk0Q5/nYtW7uoTb2U6khJbrIAMV7gw8cnAN6EszEEyVZNy55hhDf0+pzPat3xhcYc2SGzuxLd0+L2GlY5SlkR1hNWxB2KeIsWMDHwB1Srk/zqFixcn1nxA/rXpxUC1O6C98Eai1H0U1sXKSj9HqAp7p/3BpAg0cry0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(2616005)(53546011)(6506007)(83380400001)(26005)(186003)(316002)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(7416002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(45080400002)(478600001)(38100700002)(82960400001)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djNkYXpPWk95Y0ptWVVFWTdFRVZOOGQ3MXhKbHBxQlJrSWZqY0djQzkyeito?=
 =?utf-8?B?MDhXRDE3VXRHQXNlaGYwT2twTTNiVk1NVXdJTk5pbEVmQ1p2cWFZNVdTK0ln?=
 =?utf-8?B?UE8yVlVQYmpVcU9QWWZYd1lyS2o2b3ZlZnYxQUw0TjBLMTZ4OEs5ZDFzQkRD?=
 =?utf-8?B?VXcvQmFyYmRITlFqUmpYVjZ2TytXZGVHeFAxQkZCd2dpS0hZVHc3SGprMm9U?=
 =?utf-8?B?NmhXZzkwSG1UaHloVHFNMmU0T1huN29rYVZ5L3prcUJPNkcralgveS9wZzY3?=
 =?utf-8?B?MExwdTdxL0M5eExKVHBYOTc3bXpSTzRVUUwxQXptaXlyQjE0QXBBY2hjbHlq?=
 =?utf-8?B?cFBSSFZHOXVaYnBTZ2tLalpvMW5Yb2wwdXhOZjBXbGV1Wm9GVy8xQkI0bDZC?=
 =?utf-8?B?RDMxbS9Pc1hsQjJ4azZoWGNhYWVBdGkxWkxpd1BTTzRnZ2tHeFZIUmdFZEJP?=
 =?utf-8?B?S1dPbjhKUmo4bm9WUE1TK1hGWFZOTzhiREF4VHlJRlM1ZmY3YjNKbWxPL2dO?=
 =?utf-8?B?UkRlai8xUWdNQXdBTWdZNlRoYzNGV1lFbVZLWnZVZDFkU3NtUWU0TllEdXQw?=
 =?utf-8?B?c25WZ09GeDdNeDEyNUc4cnRNWHdmcWNMamtxbk0zNFdkUjVnb2FLV01BZ3B2?=
 =?utf-8?B?K1BjNU5WbWNDS1ZKOFZKUzRzRlFST3dTQ0docjZld1NBOS93QWQxV3dxYnVF?=
 =?utf-8?B?T1ZmN3hlanVEa2xRZDNsNkN1YjI5di94eXl6bXM2NkZwT1Bza2M2UFZINitk?=
 =?utf-8?B?TWs5WW5PMkJ6ejNzaUtTcUozdGU5ZktlTUpMclBxRjJMT20vbkhUMWhaeFFz?=
 =?utf-8?B?MCtiM2wvcGFUZTdERXpYbnZjYXBCNEYrRGJFbXRLQkRxV21FTzB4dHNQOEtC?=
 =?utf-8?B?M0RqTEs1SjJveCtBY1hTTEg4ZVR5eEdRckNTbkR1Yk1KK0dZYU1SMkx3cUZo?=
 =?utf-8?B?Tk1tVTd1R3EwcUV6MVRsUHhYYU5GdWsyZStncFBoVGZKWUVOaXFTaWhrNVdC?=
 =?utf-8?B?cVBwOFZ2ZmJ2Z2dEL3RmbHNzekxmVHI1aFkzR1pqdDAyY3hHSGJZK3J4REJv?=
 =?utf-8?B?TU5JdXoreW04S1ZqVkh0aGcxekl5TXU2ZFZEUnI0NU9HL3ZESks3MllrR1hB?=
 =?utf-8?B?QzRlZ1lBN3VvOVp2WFNLT3VyRHBiQXhZVWJZVXlIMkZtZWFsUlVuMW9rcFF6?=
 =?utf-8?B?WFpVRVc3dkY4Mk9ycnE4bmRwenVXU2thM2xFQ1hGdGNsRTNYNE00V2t5MHJL?=
 =?utf-8?B?YlozT2tLazdFRThXL2pNc3QyeXgycHdtUFZUUHJqRkdYZWJrNXhjbDN3YXFx?=
 =?utf-8?B?U0daRlRiNW9UbEM1N0RIdGNIWGRnOUNwRkVlbXVEZllZVDVBZVNwb1JqZHVs?=
 =?utf-8?B?bVJtbzlrdGs2OHBjOCtSOFYyazZJS2VPcWNmRHBYMVZWTm5idFlGS1E1Zy8y?=
 =?utf-8?B?TXN5cTg0K1p4bzlXWTA0dUJBL0FKM1NpbWZMNGl1M3YzUFJZSGwzcTZZdFR6?=
 =?utf-8?B?dHdQYnN0dFJWTHk1Q1RkNDQ4ZmU0Rmw0WDBKTzdEQkk3UElncUdHN09kV1p1?=
 =?utf-8?B?UllRdHlzQ1VpOThKSzZIUENqN2FUQWFrM3RzUjN1RzJwRFpBUThCWHp3Y25u?=
 =?utf-8?B?RUVhcnRpc0llNC9LV094SkxVTFlEbHNMcFpIMmNrc1Fnek1KZWtSRzBQRU9i?=
 =?utf-8?B?Y09CK3FaTG9UeTlHTTRtVkhWVHloSy9WRTRCVmRVa1R1RVJjSE1lWm1PbVVr?=
 =?utf-8?B?ZmtSb0FPbTM1NExHcUVQMk9hTDlTTDJMMTdrMy9JcEg2bDhUOHlYUHBzSERY?=
 =?utf-8?B?OHdCUjhuWTZBenVSeHE5T2RzUU1iWkJvSHpma282bUlXNm5ncU5uTWtVdnhm?=
 =?utf-8?B?SVMxa0YrbGRuMldRWFNGcjFlSDJ4M0llL3FLOWIrQTJKU3ZkSC9wR2ZFS2t0?=
 =?utf-8?B?aitUek1PMTB3NjRKUGFLRlBJV0hZMEdPZWYxQzVleXl5cFVmb3FSY3BCT2hz?=
 =?utf-8?B?RmxwZ041Q0dqSGJYMWVBZDRVQzdjVldjWXpndWNJOCtvTUU1bUJZdVBNblZW?=
 =?utf-8?B?a0srNzlBemRmNCttSXc5Q3RZUFRIMkZ2RVJ1SUQ3MXJBZlhIYTNGSDVRYkdD?=
 =?utf-8?B?K0l1ekJ2U2Y2eW9MTDNCNFE4WXNrMTRHZXUxRFNVS3g0SDk2L2xOZ0hGckNi?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec261556-1551-4c30-e62b-08db93c32029
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:44:07.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1xv9LzOax3f+iG/177Tos3Yo/2aOTGeJgyxa0CNsx9uscJ/yW7nKSdPOQr7zW8pZ9GXbgcVU14gMg/dAwC1fQh29zg0GQP8VgnFbOhIXMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5895
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/2023 11:07 AM, Haiyang Zhang wrote:
> Add page pool for RX buffers for faster buffer cycle and reduce CPU
> usage.
> 
> The standard page pool API is used.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> V5:
> In err path, set page_pool_put_full_page(..., false) as suggested by
> Jakub Kicinski
> V4:
> Add nid setting, remove page_pool_nid_changed(), as suggested by
> Jesper Dangaard Brouer
> V3:
> Update xdp mem model, pool param, alloc as suggested by Jakub Kicinski
> V2:
> Use the standard page pool API as suggested by Jesper Dangaard Brouer
> ---

> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 024ad8ddb27e..b12859511839 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -280,6 +280,7 @@ struct mana_recv_buf_oob {
>  	struct gdma_wqe_request wqe_req;
>  
>  	void *buf_va;
> +	bool from_pool; /* allocated from a page pool */

suggest you use flags and not bools, as bools waste 7 bits each, plus
your packing of this struct will be full of holes, made worse by this
patch. (see pahole tool)


>  
>  	/* SGL of the buffer going to be sent has part of the work request. */
>  	u32 num_sge;
> @@ -330,6 +331,8 @@ struct mana_rxq {
>  	bool xdp_flush;
>  	int xdp_rc; /* XDP redirect return code */
>  
> +	struct page_pool *page_pool;
> +
>  	/* MUST BE THE LAST MEMBER:
>  	 * Each receive buffer has an associated mana_recv_buf_oob.
>  	 */


The rest of the patch looks ok and is remarkably compact for a
conversion to page pool. I'd prefer someone with more page pool exposure
review this for correctness, but FWIW

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>



