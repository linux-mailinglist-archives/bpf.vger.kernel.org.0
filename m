Return-Path: <bpf+bounces-5338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC84759B31
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1573F1C210B9
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFAEC138;
	Wed, 19 Jul 2023 16:44:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA612800;
	Wed, 19 Jul 2023 16:44:18 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498F09E;
	Wed, 19 Jul 2023 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689785057; x=1721321057;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K14Tzqa6QG+QUYK7ZmTSKz9JPc+1Ve68Wu3bwNoHHBc=;
  b=ix+tH6krzAoQ3Fy9xjmzB/ApRIGNpJiYwqX7i32c4pRp2iDR1WpOBw06
   lJ9rc/cW9H4Htl/6rsXKxmDVXXEgGs5u7iM6MmgEfjKIoSh3y+0xTvqU0
   i3eYjljtRRDCJT2ivrxh/3FRi03kJhwFr91W7NYvJtJPoJqI3gvLCKQiI
   RR9/WLMj6gSoRiyr6S9lwsP1uHvjW6sac20O8tSB2LpA1THX0QvXptQHX
   D71SZm6DepUwVQQUnq0TKOgSPw5Noigv+vBNgekxjO+DyzZ1IOybvmtwm
   P6CQRYqB+2DPSYRT4xw59L/wlriw5TYKAWRF0TJJ2tLaoIEDyygz1spWY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="369167761"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="369167761"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 09:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="794111286"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="794111286"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2023 09:44:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 09:44:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 09:44:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 09:44:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 09:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE0Kn2DQ8HDT6f/JzgUeO//ssS+cm7HoEoWlLzevQfHSiBdCIsE4dAFdiK0gin3i3vK3TSDUlkwWx1GIcZQhO6UiaBIp8/wwd9+B/nhPOYRF/z0wuHdgP7LBuNlq5v6hjwYSkr/i62ucRW1o6GuJz+uMqA5wcUtiZTvluh9k4NLTxzuCj03BVYSf3FcuygOOc21oJvXkkuA2jhjIwljfNVslI7AC+sszEi9Wj8XCIlf2w/trhWip7QXnDtE4PVFQ4Zqto57SF8bS2LBkJ4iOYzy1CgB6Ow/EFFGlo/gUfbEJU5pxKzU8F7iCl6dX46W73tAnF3nQ/j5K5Em+okmcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iW6FARGBojdSHCQLnCjaIH9Mbn2kiggBuBg8oM3vkho=;
 b=PTZAU9TRq/PFUSdBLmaEdhdg80SenLdWi3c8cZpGs+SDgGNFXXmFK+yf3URmZ8TS47yEB1TrLiIdQ6FBluQgTlrMsKxln29vW+e/khzqmyHXoA7BWnCXwAV6cQlJ/jbfNHXUWwV0UZeMbxQBeSEYFiLu4pcZ+JlPNkgQDd5NR0fvayLNSUfOCm3v2PjgNnjvHo6cDt/RJDyj9xXLaFwzbmb54ViS5P5vXLZyrgo20ra0Y+SwVGh6OT4gX3KU1CakE+OsZ3d33yS+j5Wc6V7bUi8Uw2Mr2aOD7fIXkYjHE8h2fxDSdGhNhUGoZjklTnYHAWQH6WaJd/raLPfW5p+fQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM6PR11MB4561.namprd11.prod.outlook.com (2603:10b6:5:2ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 16:44:12 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 16:44:12 +0000
Message-ID: <0838ed9e-8b5c-cc93-0175-9d6cbf695dda@intel.com>
Date: Wed, 19 Jul 2023 18:42:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] page_pool: split types and declarations from
 page_pool.h
Content-Language: en-US
To: Yunsheng Lin <linyunsheng@huawei.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team
	<linux-imx@nxp.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad
	<hkelam@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Felix Fietkau <nbd@nbd.name>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, "Shayne
 Chen" <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, "Kalle
 Valo" <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20230719121339.63331-1-linyunsheng@huawei.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230719121339.63331-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::19) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM6PR11MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 700a6d9f-b9d9-4533-62da-08db88776116
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZj6opcXQXNqNnOTZwvShcz5vT/LLa0zPNgXpcxm1U8KLyZYXPFwO3Dn0D/LjymArsH6qnOGY6YFI34XUFvyiGIAZlbGgLcAUh5lKvE5SBs+qUsET7eIPUVFv3eZPIhBkxLPpqBsVhpBZM2aIJ8z+LcVArqnJ3Ekf2kLnNV2oTSvaSb8udS1o5oIluIP24CQKb8rcnf9TAyAHze5jfibO4/8MIOdeiVUxHhJH+oX+xJB/RXgTC5YVZoY/VClvm2WxhW/kJIYozACO762S0cK4ckBaPVoNF3LYj/yQqjVMUG6c5FhUe8Ag+g052JOM8bQDE0aCSGkjJHQokffbvPRB83QSa7SX8r2WDCVYbk12tIAoITJDdZSrAo4xxEqfllwh0kqrdi4NHGlMsCXNPrLZ0w7xt2Ojq8xl9tIP6yN8M+NlItyNmMBtq4ctwHepJyLz0l2nWH4aCMrJrqroJjw4QY9k/2ikBXUs0iGW1GZhU+7OqdGhLFYt8hPkB2FDbF8C1NqMyVNp02YJ1LQFR888dmoB9zv662dWYTNM5H1Pdm1lgMOyjwFGSmQIy5H/UY5rOwlVNr2M9SCywX/yeCcMNs9445zu2xrJJ4yDsqmLLzrYTH8xVTMvCbX3NOi+V9tlLBGk9zm32UWfZtkNZJfLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(31686004)(82960400001)(8676002)(7416002)(8936002)(5660300002)(316002)(66476007)(6916009)(4326008)(66556008)(7406005)(66946007)(41300700001)(38100700002)(4744005)(54906003)(478600001)(2616005)(2906002)(26005)(6512007)(6506007)(86362001)(6486002)(36756003)(31696002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2ZBV0Rod3dnMHhxVnJqTEp0MlBXOENpNWxSMlhoZkRRcnVtS2pNREE3Z2M1?=
 =?utf-8?B?SkF2NWUvOG9BNEJrNWxkTVNTcTNxLzIrMWVpTHJhN1JSbVZxUGJuMEIwTi9W?=
 =?utf-8?B?YVBCcUY1cUo3N0FueFNGRVFBdC9XWkViMUVMTGV3NU1UNWtQNDVFOVcwY3NH?=
 =?utf-8?B?T01ZbmEvNW1DY0cvZFFzWHFybTcza0FRc3FDVkJacXg0VWZlSUY4bVh5RkRY?=
 =?utf-8?B?NTMvTmRYUmNna1d4ejltd294aTJQQ1A4a0ZZQVA5d0FyN3NyeGh1SUxNdE1Z?=
 =?utf-8?B?SWs5TndwYW9ZT1ZLdHY3Q0lzZktuRHowUmMxZS95VDN1SVBwL1lGUy93MTJv?=
 =?utf-8?B?cTViUTBwZkszTGRDdnl4ekwwelc5eEZtR2loMlZBZ29GYW84VUpXYlZIcHEv?=
 =?utf-8?B?MVNSVWF4SkhLM3g5c3pxV1ZBY21HeCtkdmp4UEdMVWQ2SzhqcVhTS3Y2dklo?=
 =?utf-8?B?dy94bk9uS1ZKNWU2TSs0VTQ2MUROVm5KNGp5eXoza1NuQmE3T09WRTJyYTls?=
 =?utf-8?B?am9mbktSTmxNaHBmVnZ2ZE4zME94aVNPSDlMUzdNRGlYVVJISzZKaXEvZEc4?=
 =?utf-8?B?eXZ1cVJKbnhIb1BsbXBLUlkremtFakhOb1FNY0Q4Ly94dW9ZY1NCMjFvUlBG?=
 =?utf-8?B?R0Z0eWR5OHRTWitzMG5lblhKbzRoR2tPKzc0SnJOdnR1V0lsZXBSZjltS0xW?=
 =?utf-8?B?VUNPTXpvUmVNVEdWU0szRE9vbGMxWCtwaFFCRmdteGtZdnYzbjYyeWs5MC9s?=
 =?utf-8?B?WW5jaVI5aGZrS2NEbUExSmthZWd0NU5tWVlGMHhrVy9OUXJtbUR2dlFwZ2h2?=
 =?utf-8?B?RE5aK3IzMk1LRDdlc3lmdFdwRW8rSHJBbTc3elJ2YThmTW9HM0w2VzQzMFli?=
 =?utf-8?B?aWNlV0NIdDZ4ZENQUGVoREttUVBQYUJLbWZBWFY5M1hJNnRGNVZEUjBsWWt3?=
 =?utf-8?B?NUlMdmUyNCtTb2c0NFlpazZzazc5M0xJa0dmYTd3NitKalBSTXlXYVhMd3Fv?=
 =?utf-8?B?d2dXd0pGYS9rL0ZsYmxnZmdHM1FVbUhEWlN1UmJPTG9jR0hjdWpaUFpBR3hO?=
 =?utf-8?B?T0ZIbVIyZWhGUCs1ckpJcXhLMmxNZzV0TXZVeVdZMmdFTmZQaExxdmRlYXdK?=
 =?utf-8?B?a21ORytDRmhqSDRiY1dFR1ZJQ2VPd29lV0ZqZ09LYytSNmNCRytUckpBUzVp?=
 =?utf-8?B?djhvcVJReXJkZi9ISWZUWFV3d3ZsdlFqcHJqVi9FaHNFU0gxVy92d1dYN3dU?=
 =?utf-8?B?c3lFVWZiWE1GZE9ydkd4d3VVSC91VWRFa2ZnRmV2WlBLQ2UyZ0ducmt6TXds?=
 =?utf-8?B?R1llVnh1WTBSQ3laSVl0NHpONmUwaFcvT20rSkdGZDlabFFRQ2FNdWFOd2JS?=
 =?utf-8?B?OTczcHhEZ041dlRCcUpEM0lXTWkrSGh5SWdaaUhwLzFpRlpCTVhkcW5IcUJB?=
 =?utf-8?B?dVJSY3B5NDhNZ25BeXh5TVFKckh6M2hEaWxyRER0SVBFSGJlUnY1K1g4MXRj?=
 =?utf-8?B?eG9uVkFEU21RQ0NYbmVQYXNBaUdMTkkycjkxbEhGVmwwcWViNllENGFlWXU1?=
 =?utf-8?B?aTRxMnhHTWVMaWZUd3Q3VHY2Sm8rRVFPMmxyajQxOVpEYXF0RVN3N1F4eXpI?=
 =?utf-8?B?Vmk1SHBTMEgxa2VLR3JhVTVldG5mYlZOWGtRT2FMQVhmVXNqaUdVMlkrZXRS?=
 =?utf-8?B?bmI1WldKaDZubFEyRGJ0Y3hoY05mYUp0Z2M1dXVNYlVLQkQ1Q1pIOGYzUDFH?=
 =?utf-8?B?cmhQN0NCelNSd29GSnBGYitXbUZ5ZmdmTUwraU9iOCt0c2tyc2gvZkZyazFR?=
 =?utf-8?B?VWk1ME92ZDZwZXU4U2VLcG56T2plMDdnWTdDU1M4ckFGTXFsM2s1akF6ajM3?=
 =?utf-8?B?TWJWM2JLRkYxT291dFQrZ1VJMmxSVmlsZHg5aFc3clB0TFQ0NCs5cGdOeFc2?=
 =?utf-8?B?WVUxbXhZL0tlSDRBZWxOYk5tbDBLQTQ3alFjbnVMdmZPS0piMFpRZkE1KzRk?=
 =?utf-8?B?Q1IycWpQRnlqelB2R2VWUGhwcFJYbFNyUTNsM0c4eXI2QmUrUFFkR1M0KzlB?=
 =?utf-8?B?QTFJdHhIOVFMK1ByMnNSbFl6NWlBanl4UWdIaEpvR2t6bDVmMkR1N1p6RStk?=
 =?utf-8?B?N3VjdCttQks2OFFkSkpFWCt3SytjSDZSL2lZSEVmQmtmMVF5MG5zWGtGcEhR?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 700a6d9f-b9d9-4533-62da-08db88776116
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 16:44:12.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utzUQ3gRHeKqIpUwVtg2ACucnZOnc7c7ZGbEr5Cx2WPDw2WatVnCkPNSv8qZZNLWjdF3ni3xS7O4V2iMRJX3lADPfaiZrtgAdBCGk69NHNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4561
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Wed, 19 Jul 2023 20:13:37 +0800

> Split types and pure function declarations from page_pool.h
> and add them in page_page_types.h, so that C sources can
> include page_pool.h and headers should generally only include
> page_pool_types.h as suggested by jakub.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
Nice!

Let me take it into my tree, I assume it's safe to say it will be
accepted sooner than my patches :D

BTW, what do you think: is it better to have those two includes in the
root include/net/ folder or do something like

include/net/page_pool/
  * types.h
  * <some meaningful name>.h (let's say driver.h)

like it's done e.g. for GPIO (see include/linux/gpio/)?

Thanks,
Olek

