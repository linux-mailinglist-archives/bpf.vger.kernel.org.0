Return-Path: <bpf+bounces-3743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D8A742849
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 16:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2E61C209B5
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850D812B70;
	Thu, 29 Jun 2023 14:27:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FC125A9;
	Thu, 29 Jun 2023 14:27:37 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E531BCC;
	Thu, 29 Jun 2023 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688048856; x=1719584856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D6ge7cH/JNCMPjpulL8bZnQNGuW08bf1Kvh2z9yy22o=;
  b=NHHOKBH2t+yKfLEGIrJ4IADE/8tR2ytOQozV8pg0IYO0SeesODrRsCC1
   V/+A24ga8tXLJpfYO+l836APegLTt7DKyc1nT1BUpt9nRcOm7o7M5MD81
   xWbCT+hr+Qs01tSWoVF56/NGaMJtbSnyQXIQfy4Aa3P4Xkjf0PPwYC7JC
   lL5G8s/3f92s2UJXZ8IzJLckQQy3eJjnQDPZJlneL+Qn23xXftysqSaDU
   0/qR93KRYImXUQu71zyPhs8njI2xB5mqrx+kidAhrbnisPTiQ0TMKcygl
   spctfMPnn81LxQQI/ctv9RK1ZyZjmvU0G2VfhFBd0N9Lvy2m5h9WJageJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="360968133"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="360968133"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 07:27:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="807331001"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="807331001"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2023 07:27:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 07:27:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 07:27:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 07:27:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4yZSuJVELcbR2qtAemUtMkrS29Y0ORW5+g8TkMGSFGv2q461Y9i+vfBeGLC8X/5FFcN2FRpNzV+yFVqgr3s8FD26RrisDWbeqtFxlt5GRXvVlPX4mdCxcaNVvShZwhnN05nbHtf697zshR0tG2LmjOqFYADWjhwrowTrN4Xzi1WpaBsDPzHiBjOVdYW7LQb9h4KHY2s725K9T1WCggSQkBckHKTSjDpSv9NGGSNQCyMAAryDrFXNhROxchHGJt8x9LvFRP78oaYYHuOML7pJSmIZQM0fZRlQHhSd+RHgC066fSyeVYMTvego/xhCyFvGDPXmCZ2QvC2+JyDCuQkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thrvH97NWNIf3if5FPnQL6O7xJkSBIjOgpNX86xLP5c=;
 b=A1fqllFHeahqdT4Bfp/ypqmdZ4UmP91K/a2va7o+8L9Q+2QrrXK4LNoFg7pYK6vUr8cWMUKw6TcGCUNUD82ckGaiKCIzrHQzjmuiPHuIeBFL0BAsKf2BGoC82O1tkf8IXJL84hLPPkklqeAi7zoLw0PABWdmX/qXhymCFURMWNBAvcwJmRmPUteeM6XKNNZkceyngANB1QA7TvjPvp+stEPPQdg1tsO0Pp+dlZKpQTlAx+XcTN68ikhoFrtD7GnCgJNT3g6HFspierItRNw5iEfoJavwsZzQMfpJRIs0cHZd6QVK8t8NCkCAPLpUb6o/R0SCGD8YLkhDxY1wSVdY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH0PR11MB5265.namprd11.prod.outlook.com (2603:10b6:610:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 14:27:21 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 14:27:21 +0000
Message-ID: <32fa253c-b0ad-c988-5017-ecdcb9e1968c@intel.com>
Date: Thu, 29 Jun 2023 16:26:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 RFC 0/6] introduce page_pool_alloc() API
To: Yunsheng Lin <linyunsheng@huawei.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Matthias Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230629120226.14854-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::23) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH0PR11MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 726c56c4-6914-4267-37f8-08db78acf35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8AwXWUco40h4FKHw/rWFL6hBs4GIPtBOHBtLdW8Iumv2zSvDxCqfHiCEYaawuAIz58G3Kh6F+vPmRwFFW4qX9hVYBdsb2CckxkE/eBUE+ZWRLJSeHU5WjOe33GOodnARUwErgeu7FizJcgXMOLNA1HtW/C3oBjGmMAYdcnLVZxiLd6H6OWUGPQh96HMo36FN8Efq/MGlWxIqmRMz2ONsjSZDjvrsKca+wr1D7aCSAFR9nVBSOIX9exvs03oO3tdEj0SYne/ruuHqm/nCQgC+78bmZW65HABrDC9xq65WFvNUQ+50gOR5kwDxvcpT/j1pGe8PL20RqUBaLSSojho3ynl87jaK1JdLpBnJRAW09vDKRd7cUx6qTTOQYm0VpjFeLK8vGk0BASqSw+c5BmuCGPyj0de197fILSIGgtPsh4YlDvZAKJ4SddZTSEinyGzkN478v+y3AYDfUNclKfvlkWxwmm5JKPfB1//2XB4UKC2DY0DyYLmLW99Jr5lBVgBms6yOOMwu4YHY6PQLklXa7FVxfv3pcUoLIQ81aSRj5zJj/w6JgWFwoILDHISYVwkJ/gB/ZtNLWwcGX0YtunSa83ls1SRfrvWHTz6XTBAXkt5lcb/sJPsXJFcMfLjqJpickgVbU+N2WpWeNhatBD/CZqXj0WG9uatuBANS3DcsCZSAWuMsgzNt7j4vnhT92GY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(66476007)(66556008)(66946007)(316002)(31686004)(6916009)(6506007)(6486002)(26005)(7416002)(5660300002)(4326008)(186003)(8676002)(8936002)(2616005)(2906002)(966005)(6512007)(41300700001)(38100700002)(31696002)(86362001)(82960400001)(478600001)(54906003)(36756003)(83380400001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjJjeGlwZlZadTUrMGN5VGZkV0g3MStFcThIZlBTNktWbDFKY0cxZGtHOEpY?=
 =?utf-8?B?bkpIdzB1VUJRbEV2V0ZWWGlTRWRXVzd3dWFEV1F6SzBjQUNERkEwb3MzdmRR?=
 =?utf-8?B?MjZsUThudEtSRXA2TThQUG5VdHNDdzVUKy82eGNsUFVmWGJJb2d4L3VONE9i?=
 =?utf-8?B?dmFJNFdjZTRXam5RK0w1SG5RM256NVJ0MDRvdEt6bml0TmtidkZsbkIvelZk?=
 =?utf-8?B?Vm5rZ0k3M2FwQnkrZCtoaE1CZktkQXQrYXNJVDUza0FtRG8xcXdTS3Q0WVBn?=
 =?utf-8?B?T05wVnVHVWFMWC9XVVJrc01TYzVRc2QvRnN3eFZ3aTY3TWoyclE2Y3pveS9I?=
 =?utf-8?B?NU9BL2lKMmlQRUU4bTZkaHJFdUhkajd2bG9kaUNCSXJ0V3kybUxRR09jQUxp?=
 =?utf-8?B?N2hrVGpTTnlocm12bXpJOGJnOVZha2ZPWXpOcVpLVStlSFl5T2pxNmtIVXJ2?=
 =?utf-8?B?WWZoQ3lQN1ArcUpLQ0t5TFVpem9pQWJDV2s1UWp6Mk1oemRpdDJmbDhhQmwz?=
 =?utf-8?B?UnRsRVRCQ3NhU0oyVDRhS0pVclpDbitqZ1JNemk2ZStrR3JNTHFWM3puZkkv?=
 =?utf-8?B?SStxQzRxQzcraUF2QmNYZmFJSmx5NFBHcWhJYm1sWDQ2MklLMFUvOFI2VjRo?=
 =?utf-8?B?TGFpT0p4RVlmRlBkVVVuQ1ZrK0FOeVVxQ0RYYkY3YlBiWjB1ak1GYUU0VzBs?=
 =?utf-8?B?VEkxelN2WmUvZGpnRm9xUjVlQmoxNW9ieDNNb2NkckR0YWtLVURiL0tINncy?=
 =?utf-8?B?QlBxOU5kQjBGTHVoZUlsbHpXT1dlZTQ2NnNhVU5CTmxLZE9CTzhkbXFsbUVr?=
 =?utf-8?B?dlNtbWtTSmtiTzFoMEZ3ak9QQjU5N1QwSU41L2JvK0xIYUNqalhQM1hlaUs3?=
 =?utf-8?B?THJ0bG82VVR2VUVWcTh1SXgxUG8yR0pLOVRWT3VDOCtrc3lHdjlzc3hPL3hl?=
 =?utf-8?B?YWh2Vm5DTkJUaUdVNXVQOFNISy9xMzIyRVZSS3ZUeU1nMDB2ZVNMcDUzSW45?=
 =?utf-8?B?YjVkbFM1VmU0S0xOeXVWemFGSmhCSFN5eng1aUtya200M01sUGFmbXZiM0R4?=
 =?utf-8?B?YkZyMjI3UWFyVVN6bHJOTVZOY1dPOU15ODdza3ljZWVLNEJIWDQvQzFlVUpR?=
 =?utf-8?B?ZUtPSmZWYjlHWGNWMzB4UWhQTkdTRHFRYVBBZzh0RW9sTXdFRFRodGcyOVh2?=
 =?utf-8?B?aEhMTGNkUHR5eU1iU3ZTVlpWQ1FmKy9JQlJ0NERmdEhPUEZkWXV3amNzY1F5?=
 =?utf-8?B?ME9BcGVmdEdlelVvbTNYVnd3bmJ6a2hlekpMVE9BcGVXQk9PZlBuck5rcU9Z?=
 =?utf-8?B?N0hJemZJSjdvdmtFSVNzVDdzeEJsWlRzK1pQR2pzc2VMeThnNko1eUQ1cGJr?=
 =?utf-8?B?WkloN1JkaFprQzhjYVo0V21BWUxZVHhLZU5rV0Y2eURJQ3JSZkRFa0pRazQ5?=
 =?utf-8?B?MTVlKyt5dmpiRVMxQVVaZFJjKzMxQ3ZnejZYZUNPQ2J0b2QzV0ZFWHAyTE4z?=
 =?utf-8?B?VkNrYVNOejRmbjJpMFlQNGhlTFF6NFE3QUxtNWwvajlML2JlUzFNd0J1QndN?=
 =?utf-8?B?RDN2d1VHc1RxcG1yRzQxekpnZ3hkRjlYeWZlSjVkZHAxbldXZkhlUnhmL3kz?=
 =?utf-8?B?SU1TL1ZlMXFZMndYMlQ1ZXNQY1k3aXptR2xjSlNyWnQ4MzA2SXlrdEIrVmYx?=
 =?utf-8?B?TDhFc0RsYkhqb2NybERUQjFMTzJzSVdHb3VlM2QxTTdKdHBHTXFSYmZHTFg4?=
 =?utf-8?B?VFY0OW05NStnU0NWU2xoam5kVXl0ZGc2S2FPSmltZG9KRE1GbnVaK3Zqb24y?=
 =?utf-8?B?WGxCU1NNb3dkVE13TjYrTEJxWlM2N1FGbFdPU1A1dzE5NXFwcWVrZzRHZFdG?=
 =?utf-8?B?eVNQcEhTb0hYWGQyK21zSmYzdFBrbzR3c1BjQVdydDRuRnVCTkwzNGdRV0J5?=
 =?utf-8?B?cW94TGt6bHVBKy9KcDJNSlhuRkRLMFkzT1FRLzNiYUkzN2FWbVBFOHd5T1d0?=
 =?utf-8?B?SW1aMnBEVHFNbXhzd0pYaTZBOXFub3JKT3FITm1SOGNoNHZQbFNadUpPYksv?=
 =?utf-8?B?V05PWGNLUklYOEVDYXJ3TzYwdFB5SG5yOXU1MzNtVE5VakV4ZEVLcDIzRkRn?=
 =?utf-8?B?Q1R3RGpnOGdNM3pJbWJ1OHpNMExBQWZJK3AzTm85YXloNi9mY0l4TE1PMEhq?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 726c56c4-6914-4267-37f8-08db78acf35d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 14:27:21.8177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h40pY9k7j8xhV/h4OG6+caGTFU4PrrfFvWIB2snIQmmUdWhfP3ifMaEQQmKjiPyCS+U8NYkofDyb/BoUQ5F+21MarN4I0Duof2fE7giOrLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5265
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Thu, 29 Jun 2023 20:02:20 +0800

> In [1] & [2] & [3], there are usecases for veth and virtio_net
> to use frag support in page pool to reduce memory usage, and it
> may request different frag size depending on the head/tail
> room space for xdp_frame/shinfo and mtu/packet size. When the
> requested frag size is large enough that a single page can not
> be split into more than one frag, using frag support only have
> performance penalty because of the extra frag count handling
> for frag support.
> 
> So this patchset provides a page pool API for the driver to
> allocate memory with least memory utilization and performance
> penalty when it doesn't know the size of memory it need
> beforehand.
> 
> 1. https://patchwork.kernel.org/project/netdevbpf/patch/d3ae6bd3537fbce379382ac6a42f67e22f27ece2.1683896626.git.lorenzo@kernel.org/
> 2. https://patchwork.kernel.org/project/netdevbpf/patch/20230526054621.18371-3-liangchen.linux@gmail.com/
> 3. https://github.com/alobakin/linux/tree/iavf-pp-frag

Thanks for sharing the link :D

> 
> v5 RFC: add a new page_pool_cache_alloc() API, and other minor
>         change as discussed in v4. As there seems to be three
>         comsumers that might be made use of the new API, so
>         repost it as RFC and CC the relevant authors to see
>         if the new API fits their need.

Tested v5 against my latest tree, no regressions, perf is even a bit
better than it was. That also might've come from that net-next pulled
Linus' tree with a good bunch of PRs already merged, or from v4 -> v5
update.

Re consumers, I'm planning to send the RFC series with IAVF as a
consumer on Monday (and a couple generic Page Pool improvements today,
will see).

> 
> V4. Fix a typo and add a patch to update document about frag
>     API, PAGE_POOL_DMA_USE_PP_FRAG_COUNT is not renamed yet
>     as we may need a different thread to discuss that.
> 
> V3: Incorporate changes from the disscusion with Alexander,
>     mostly the inline wraper, PAGE_POOL_DMA_USE_PP_FRAG_COUNT
>     change split to separate patch and comment change.
> V2: Add patch to remove PP_FLAG_PAGE_FRAG flags and mention
>     virtio_net usecase in the cover letter.
> V1: Drop RFC tag and page_pool_frag patch.
Thanks,
Olek

