Return-Path: <bpf+bounces-5930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9492763441
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 12:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C440281D9C
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64928838;
	Wed, 26 Jul 2023 10:49:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3598CA47;
	Wed, 26 Jul 2023 10:49:38 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53C8E0;
	Wed, 26 Jul 2023 03:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690368577; x=1721904577;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LVCaPn46trZ5smgOFi2ZFCfQfW+48wfkfSYSun/wWHI=;
  b=KZIvzA7ym2S+768yVzP+H+Exhv8BE3aCwRTDHssC7thC4xcvzCNrZdd5
   i+z2MCMe3jcG2HioXkjmZWIUDveHpnWEOZ6z8+WVl5IY+VGxg/L1mjj0M
   LQ6N3GFiLtjmbk7zMHJxZLM0REtGD3VAc0TYA5QCX+aufJLUXByD2seAZ
   0l1F/pnFi1q+vxIqrYbFJaFsBozupkcxcKA93TR5Jx0al1dxR5rjMwEoM
   24ezsNRUCQYc+Yzou8dTJ84M4Uh4hIS4rivdYigNuOK7ja+IUiiBxFfej
   Jpet1dLXgdV3Y8+h3S6csLbb4qtZkpUxBVjvvYimL2V1m8r0bfeG+jBzR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="434243388"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="434243388"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 03:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="973068822"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="973068822"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jul 2023 03:49:35 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 03:49:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 03:49:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 03:49:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0ihCzSi2qhgxqgPexliSXNEJJLzn2RsPW+apMwpnFrA8KNfpW/UKYcwtL6QlCoe6NCUP6dtDH3L3I86tFH67cjWhXM7hjUQUjuNyFnd0Rg6AS8CFaQiOUNbi1eBJr2rxFQiNj1RyQ9Wi4liCwnlm8Dobta0cN/q+PF99aZRjaHRM0fpDod+6R8am3YLe8xhuEnTgRMq1BMF5O2SXi90lVoDOHPGqjJXTGUU1aCmlFyvDyoFGOn2zv4gVj+9/1rqEh3e7wRw08bVzXfZNqGPdHwHKJo+0hDxE1fgz06iT0pdGz3JDZ6pNfWlu8/BMCaZD6S9oZIbaVoiAXPfrShVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm053MUck6bI+p6MJj95vrui7Gjs/wWRS9K5tWXSFeU=;
 b=oGVXnWXDNySSub3gHYR/UsxqqnpvOCgEkPh8TcLOF9sFkE9UV9PAqXL01zGq8vjFrpWbHt8OgaM74sP836yYgDPQ/fSE3//PTG2m5biYFSkpKMz6VmD3VNFbaw7rjFDzoEOdAn4aIY+2AzHyq9M3NABm8Bl8b8guf3DLNqB6aUu112SHNdGNHA5oGFfDcPRUDDaXB9zoj+4tfG3WMIoXyBCFheOd6mI1VHKYoHpRTQdN47XvCUGf6+bUfwPLHb794VGZqiDcv+cLwUcYr7OKUYJQN6+mQ3q/7LohsosMgmHjB9YtMDp8/pdVyZtH71YHUkzPOFDtyjGrcv2xcTJpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SN7PR11MB6852.namprd11.prod.outlook.com (2603:10b6:806:2a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 10:49:32 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 10:49:32 +0000
Message-ID: <a5d91458-d494-6000-7607-0f17c4461b6e@intel.com>
Date: Wed, 26 Jul 2023 12:48:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations from
 page_pool.h
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Yunsheng Lin <linyunsheng@huawei.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Sunil Goutham
	<sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, "Subbaraya
 Sundeep" <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi
	<lorenzo@kernel.org>, "Ryder Lee" <ryder.lee@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, "Sean Wang" <sean.wang@mediatek.com>, Kalle Valo
	<kvalo@kernel.org>, "Matthias Brugger" <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
References: <20230725131258.31306-1-linyunsheng@huawei.com>
 <ZL/fVF7WetuLgB0l@hera> <20230725141223.19c1c34c@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230725141223.19c1c34c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::20) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SN7PR11MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: c92c5e4b-a2dc-4042-40a0-08db8dc5fe64
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jKof8dDhefTqltRJwFk3y/FDgwHsY+LtV1OngOYxoGIQDHo4TsVaQtRZfiKOamYyFKdW2e68OB9uyG0CUPF84wL4ObSZ7SACMa+7bEmdlRu6EILYo6/1LqMRLVorgF0l3AdtyQUjz3QXXDRDiQhr76KY8nvwiusbpfgKZ2/hOPnuuboaVV5Ar8Tet6OjAxqd4DMjqliyr28osDx3z70s4M8aBV4WQLKxJZGhsKAy3vMWZ056eg2HRbUnj/8T6nE50+9AdZ8alKT9k7wJkAoQ6LlmFHTkM+E0F8CGz59XohslXY7rPTOsiv6n4mtDcoVlj+XGda1d3Vtf4D0ot867X6yD7DHG0JwwnqRzLQBGJmP1cNAAvQctIZXExU/mjXvqXajGOH5NQJvsMiSPwLxWmSOBc6TbU19BMiz7nNaKjTa7fmVU8MDkQIkCX6OHy3JsVWLcicRODnC9LABvQ8gj3wR4KZ0v5WDrJn6amyT/9wk/q4LT0+mncdolLnng3WMMj12+nKA531hO6OoTzmwsHhi9V+X5D/kdtHFsFLpov9pV/PuHxKvoXRm6UonS7GDK5muDEgG0CiZnHcW0ucw/SEjFm582Fq+y1UQ5LiIlUOAcfZr8GdzZp9HTSyjg9GJcGHi25BchVcBs3HxHDe7QFIzlfOuOchp/wm53WAfEWd5jpJRuVRbdfJ/EbESl3Js3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(26005)(2616005)(186003)(6506007)(66574015)(83380400001)(4326008)(66556008)(316002)(66946007)(8676002)(66476007)(8936002)(5660300002)(41300700001)(7416002)(6486002)(6666004)(966005)(7406005)(6512007)(2906002)(478600001)(54906003)(110136005)(38100700002)(31696002)(86362001)(36756003)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2VLRHRGZnFlOStoUmFxL0JIbUs4MGttdnlyWVZHaXp4ZDh5UEgvWUJNZDln?=
 =?utf-8?B?WEc4cG5heFVzK21FYWhOUzJLY3NFeXhpU0ZEaXlza2xuNnUyZDk0RjFmMmxs?=
 =?utf-8?B?ZEw0Yk1MbURKUTU2VDRMZmZNTDR6emNDaUczY0s5U2NsTitDSzgrNDdZTktL?=
 =?utf-8?B?UjVLNU0rdUlYdUZjU1hZRWRrcFZKWXlUUXZvVDVsUjlmWHo1OWw1UGZJU3Nz?=
 =?utf-8?B?Y0YzczlUaEhRYTdpT3lnNzlKT1JTLzVmSFRqRzlZalQ0OTM5WVZBVmV5WFRj?=
 =?utf-8?B?aUQ5bVMwZm1ZVHFVRUpRT2hHQWRWdTBWTGlNYTZRK2ZIaTNUMEthUkRWV3JR?=
 =?utf-8?B?RUdFc2VRZ3Y0YkpzNlJtdHg3L0pUMDJnUDJmU2hhOU0vK3h3QVQ1SEVHcUtP?=
 =?utf-8?B?RVVhRERxZVFvYVhNVlVGSlNhYkVyTFlKNFQvQnh0OGl5YnZqS0VydEVFcGds?=
 =?utf-8?B?bkF6bHVSdm1icjdxQVNJTkZ3Y1lXTWE2eFhDenV1N2ppM3RvZU1GalhndVA4?=
 =?utf-8?B?L2Z1WXJOdU52M0JhUXVNYTJvVUJobEtGVStNa3RkZ2xMa1VxOEtCeDBlMGN0?=
 =?utf-8?B?UTErSVo2MDdzbHNoZTczcE11bHNKbFU5M2xjTDdQRDBBQkZ3NEQ4YzhXL2x0?=
 =?utf-8?B?alorL0cxaXFLaXVId2MzTDVadDhaZHVsSHlrckprejkvL3hJWjFQSWtMRUNx?=
 =?utf-8?B?KzJqaDJuMkNVNThHaitoUFJ2TGFEMHdTYm1HTDAyZTJtWDM5cUg5aUZPQWVt?=
 =?utf-8?B?UDdqRmd3elF6TG1KQnNXRTQzb3N5aWptc3FYMkFYckthaHArM3lYZjhJTG03?=
 =?utf-8?B?aW9tVXZ0cVZrNG5aeEVjeHVIUmFuUlNRQUwxRE1IenRnTWJCbEowVDhKNGd0?=
 =?utf-8?B?czROTWxsQ1hCaEl3MHNEZE5LUWZPRnZNbkNQS1M3SC85dEs5bjNGU1ZwNGNQ?=
 =?utf-8?B?VjgySWtudnk2c1AvYTQ3ekxjQkZYc05HOUJYQ1lldGZDOW03cmt5Y09NcEFR?=
 =?utf-8?B?bW9jM0xHRTd4RGFBVnFLNHV6ZDJNUDBQSys2SmRRL0lXV1FPM1JQVWt0VWtY?=
 =?utf-8?B?Nk1KQTBMdHFOSC9paFRUbnVQUzRqWjI0UDhHS0tUVUxUa0sxdFpFU0JoOTU1?=
 =?utf-8?B?N3dGbU1VenlFY09lRkVRNWw5UTJlTFVzRG1TOVlJSGx6VXE4RVpnMlVSMGVt?=
 =?utf-8?B?L0FHKzZuc1JmaE1UZzhpVlZheTRyejIxekdzT3VCNnlWbFIrcEhTdHR1Q00x?=
 =?utf-8?B?VDZKdTdZZ2hsWWl6RTR3Q1JOc0VCczU1QzJOamJRRWJ3VkxjdWpENXVNTlhk?=
 =?utf-8?B?NmR2T3EzSnNONWRORW9uR2JVZVNHclRJL1NuWlBrQlFscVhubHE2bXFQNXNm?=
 =?utf-8?B?ZEpwaGZRNm43bjlOcjZ6NmFhcEhPOE8zYXhkbWNYdWpsSTl2YlFjdFBJNWFV?=
 =?utf-8?B?RW40MWZlVEJPaXdDNllmN1BQbnZCZ29UR0dHZW90UmxyaTlsVGFzcERsY1FX?=
 =?utf-8?B?OVhPTFdoOEJOMzNtL3RhRGVjLzNpS3hMa2hSRm1pNzVpS3gwcDNLazFaNDB6?=
 =?utf-8?B?NTIrZmhjbUF3THlKVWdQb3VXdDBWNjNPckR3cTJJRjhaazFkdkdJd3pWM2NZ?=
 =?utf-8?B?QVpDNFhWUjhmSW9BeFZTamVkQUVkWUNRMVNMQ1FnRFFoOGVCK0hNbytzbVdU?=
 =?utf-8?B?SkphbkpXeXd6dTkwdTdKeUdoRkkrV1puUDUzc1VFTktnRFg0VnBzODlYRlI4?=
 =?utf-8?B?U2VZMkhaelRKK1o5SnFxQ2pSRUhWMUxJc2lKeWIxMHBxR2E5UmhiakM4K2t2?=
 =?utf-8?B?ZW9PaHRxMjRXWVczZUtzTFpIZGh5TTJzYnN0dldobThNbzdsYkh1MmNvTUZQ?=
 =?utf-8?B?dG10enJCNWlmNjUzcE0ybUozN3VIbmxFbnBYNjZ3TzZEMGM5c0hVdVU0WXMz?=
 =?utf-8?B?SWJZWWg3S05SUWpuTDgyYSsrYkhoTVRXM0o1MTFzME4zb2MxOGRqa1ArMjVI?=
 =?utf-8?B?R0JZVUkzQlROVi9BK1pzdWVTUXVwTFRJbUs2bnVmeUdNUGE0YW9rTncxV0x4?=
 =?utf-8?B?alp3Q0hPOW9mM0dneFRXRzN6eCs0SEFDUzlHcW04clRYUW0rbHFUZW9LeE1n?=
 =?utf-8?B?YTNUVDdjVHRiTWMwOXVOYk8yeURVTjNTd1R0OFlYWFFWVjA1elZRcmx5OStW?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c92c5e4b-a2dc-4042-40a0-08db8dc5fe64
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 10:49:32.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2LN6K5kJ/uEYX1Z7ZM3xOg0d7/dp1cqY3whD+1lVgWQa+pWYiBskn1i9yGDo8BNBBQ8wV21Tq5RGhZJ/EPBNTHhF/L4gj3B6hdZpUQZ4lM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6852
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 25 Jul 2023 14:12:23 -0700

> On Tue, 25 Jul 2023 17:42:28 +0300 Ilias Apalodimas wrote:
>> Apologies for the very late replies, I was on long vacation with limited
>> internet access.
>> Yunsheng, since there's been a few mails and I lost track, this is instead of
>> [0] right? If so, I prefer this approach.  It looks ok on a first quick pass,
>> I'll have a closer look later.
>>
>> [0] https://lore.kernel.org/netdev/20230714170853.866018-2-aleksander.lobakin@intel.com/
> 
> 
> I prefer the more systematic approach of creating a separate types.h
> file, so I don't have to keep chasing people or cleaning up the include
> hell myself. I think it should be adopted more widely going forward,
> it's not just about the page pool.

I have this patch reworked to introduce
include/net/page_pool/{types,helpers}.h in my tree, maybe someone could
take a quick look[0] and say if this works while I'm preparing the next
version for sending? Not the most MLish way, I know :s

[0]
https://github.com/alobakin/linux/commit/19741ee072c32eb1d30033cd4fcb236d1c00bfbf

Thanks,
Olek

