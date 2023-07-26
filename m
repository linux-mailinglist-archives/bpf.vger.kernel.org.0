Return-Path: <bpf+bounces-5929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD8763427
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 12:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93AB281D8B
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC819471;
	Wed, 26 Jul 2023 10:45:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A036CA47;
	Wed, 26 Jul 2023 10:45:18 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5502693;
	Wed, 26 Jul 2023 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690368316; x=1721904316;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5YzThYeHe9DB38hTCxbdPDl2W//94xz36VhgnOauHC4=;
  b=CrrlezkPZXYWMTiVIX6Xbvh2/Z5WuJ7XG4CXqZYiOp1KCR7TeMrEUf+s
   8yhrM9pBoY0aZS9fFRFwMpCbMz2UbsQMQjaKqSQUzwGikAZQ5FsguP47j
   ohjzZMIHWPof+ZXYDah52iV0TX9UMysmdIDsDfxibz1DmHOhdvkse0NYg
   nbC8L1eOZ+vuxxmv2HAvV0ePoA5QGQgjKKLbhRPVdEEEe1SsGu97uqBTe
   peDTnTBipsw5ucvJSLrFknLdofbrTi4jqiaIoHO3j8q0ljiJ9RgAlyH7g
   WBoIQQ9ANBIavzn6h5zTQWSFBTvFtlbiFERQuMFjySrKJ7H3KuluVnLOe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="370655585"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="370655585"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 03:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="726493137"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="726493137"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2023 03:45:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 03:45:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 03:45:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 03:45:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzObDizJjX9ega1CM6uQJl0uIG9goRF+jOIhXOX3Mh4vFLFuDzfLxVt4fVzyuT9GBXAJkxsunFoGAteU3sgMX9/kHVCuzu/QaX661n1VNmWp9/SDvTRHUa0gQuhPTj10z7HZi2TPjWm+xDoyUaNI17aaS5ur+Ob7Zr20gTQKfG/+srCKJCBh+g69Kh1Wz9ehnyUHBOOEYZLTwQw8btb8COBEFkqFWNTgNPA+h+1pwm5FuXyw3Sm/4OMZsNWzoH3YdmkdaY5hcN2EwmxXBnGjZMuSVupcg5VcTE+XlN+UEMgHWb+eIvOa6IYWKC1NftP1f6ZBvn2Fa127EFgErx9d6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swfsr3rt6PG5WlvltPUDPtb1+lm1SpG6GQiQtdMgjk4=;
 b=fdUam/Ha5shtdsKSW0dmO/9371bl6rSpcJzcfiUj5BlxfHMCw4ghU/LIGRsFWTht6K3QHqm4IXG0bSSdl+V4gI7pyr0b61CtVJsMtSVZ8faF7ce1f3ViUFLlXX5TzxocxxvvSnrWIoUxFzULOYSpOeiXSVU016eW/tozDrUT5bLhARwOVSTQ4nm57X0XwXqrkE87dHJfH7S2Z/ftqFaia1ypTelZeV49VAYYLZIMPfcY9RRv04O/M+OqUWsdG42jnirkZisw5CjwrZEPsKzwWEcUzg8hotq2HnzEBcrIHX3UFtdYKiiTHsPA9w3qdbuFtoAdfFLEDQff5LOmcaBYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SN7PR11MB6852.namprd11.prod.outlook.com (2603:10b6:806:2a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 10:44:58 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 10:44:57 +0000
Message-ID: <16b4ab57-dfb0-2c1d-9be1-57da30dff3c3@intel.com>
Date: Wed, 26 Jul 2023 12:43:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations from
 page_pool.h
Content-Language: en-US
To: Alexander H Duyck <alexander.duyck@gmail.com>
CC: Yunsheng Lin <linyunsheng@huawei.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20230725131258.31306-1-linyunsheng@huawei.com>
 <94272ffed7636c4c92fcc73ccfc15236dd8e47dc.camel@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <94272ffed7636c4c92fcc73ccfc15236dd8e47dc.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0453.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7f::26) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SN7PR11MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3b3055-9f09-4c6c-9885-08db8dc55aaf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iM3sYgJ74oQ9EPRHR+8f9Sj5ZLUoajpkqETXYm1gCu4vjwFfV9LgMnC4qE4Tuh29uOurHbIUq/YiNFdLJuUJ+4byu6EX+7BMQPUopKxe0z92zDWMlc2PAdUT3b8So+aFI7g+yazbs5bXPOJ8UM1kC/txveEn0TPu1X2EdnSFQJc5xxPmgV5IWu2+7c3m9TKriRt4BieHvxQEDWkDLQ/F4GmoCVTUPQw8un520pJQxunA7ZMAQ29Xo+o6DhszOFjZnMGqpuw/T3ZMsHFcEBIazUY59YAj6HDJXoJaUnDFogHJoY7OBbe5HjVX7oVXja4eKt3zJgKB+fnPb5CyEJTmfDP//esaRqtO8hFixWR+kRmT2s/vJioXJLZ9poY90KJyu1kqWIzZTyOXgGik59Y1FO9aV195kaZGs0VY/AFsOtEyXXGVfPG4v2toNkd7fncesWSuoIR+IkNcubHSId+yaMfZ7AuIu7pLgkPb3XE9HO6/h2ZdEx5X1dBnA9MCvmA4kYrfQbxxyYm6I/B2wFlJgsdzNutyxBFuADYVTJlWEQb4N9eyjhJw2P03eOq0MG3paESU9KI3eVFtxel4vs0rFcJHp9Ii/HOPf9uAYBT3SrnqmsWlfqwXprSnaQg+z0TqhQ/DogpiHv7s8i7qDOT2vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(26005)(2616005)(186003)(6506007)(83380400001)(4326008)(66556008)(316002)(66946007)(6916009)(8676002)(66476007)(8936002)(5660300002)(41300700001)(7416002)(6486002)(6666004)(7406005)(6512007)(2906002)(478600001)(54906003)(38100700002)(31696002)(86362001)(36756003)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGxpc0t6bG44UkFING9zQ3lRckZDcnB1Y0dmcG5kT0Vtb3VFR0U2TmZ6cWtG?=
 =?utf-8?B?dGtJYlJGRnRudHZEV01NSG0xb1VkV3VHdjA5ODZLM3NXUVIzUzM0MC9wcEsz?=
 =?utf-8?B?Ynp0bDBQY2kxZ2h5YitjL0RUUm1KdkpuZzZaeS9oSkp1VnRzY2Ywb0UyRjRT?=
 =?utf-8?B?Wi9JT0paNmxoTTUxdm0ya3g1WmgwRUgvV0pHL2J6OWd4MkdqQjVUUHNETU9X?=
 =?utf-8?B?T2I4MHJiVEFaWk1LZUFZeDhJMmFkWHlaYWtLdTNnWUtVQzlJVmZWU08vMVRm?=
 =?utf-8?B?bkpCZFhJWlBmdjZGcWtMdkpvVGluYzErbTZxWEpzMWRHanhESmdCTjhFaVU2?=
 =?utf-8?B?SEVBTTZDWU45YTUxbk1sUVkzWlBxVm02ZGZqM0w4VGdzeDJHczJZcjlQSkc4?=
 =?utf-8?B?V2pBRXgvcDNQTTh4b0pnUVpRSnlxMGlpTzRWMU9LMm1xeXhyMU5MYWphSENy?=
 =?utf-8?B?dHZPR2pBNHN2T01aYnI2Nll3TjNwa1h4RlNlZDlTVVVyaXoxK3N2eDA1V0po?=
 =?utf-8?B?cDhGYjR6L21vU0xVeDJLOWZFRG0wZzladFlNbDFLRTl4MlJwOFlTWnl6L0F0?=
 =?utf-8?B?Njl2UW9TWkdocU1FZ1dDWGYvdnFKc1I2ME9HbGIvMk9kVm1MbCtkbGxDYm16?=
 =?utf-8?B?TGdMa3NDMDZlTXIzMnc2UC9vOHlXWWNKbTQ2UGQvQ0VlUGhKQVJkT0YvT3Fl?=
 =?utf-8?B?aDFBU1RueDhVRlk2dHBIUmdYQmN0OXB6SXZXeVhyS1lXc2hTSmpMdFZ3MGta?=
 =?utf-8?B?d2xGNnpST2lRV1ZiUkNsYzREWGtHVkRHNmozQjU3OUx4d3Q2N29IZjRJN3pJ?=
 =?utf-8?B?VFRVaURpb2lhdDlpYmFIU1BXYkt3ZEFnTm1QdTVqQmQ1NHpiemM0ZjRpdHBX?=
 =?utf-8?B?TjM2NnkvcGFtYWhPVVp2citTQXJ0emdsblpnMVIraW9mRnFqYjFocGtqUm44?=
 =?utf-8?B?Tk9HUU9MN2ovMXh1MExQMURYT092Z3RmTnl4bHpDeXd0TENSL0Rnam4wUWhJ?=
 =?utf-8?B?RWh3c2w0YkVOUXc1dWlKVmJVN2ZFaUR1bHpIOFdaQnVJZHdkKzkwZG53aEtn?=
 =?utf-8?B?TXJHYk5WN1lwWVFydTFUTHgwYmpTMm13UXYzZFpkdFpXUGVyVXNYcXBDNDdT?=
 =?utf-8?B?YXFtcVBJV3JUTGZzcmdUaTZybHA1WUlRY2R1UXNnckJVOWVGUDYzMEJXWFFu?=
 =?utf-8?B?N04zcVZKaXp4SmRrTXlpSDgxbFA3Q0dLMkZuQjZHTDhLZU1zR0FYNTdpK1Ju?=
 =?utf-8?B?VllEQ2Vuc281d0pUMUJseURMb3lrK1krdFBpY2lkODIxVHJSQlRrbE1JZFFh?=
 =?utf-8?B?UmdJbGh4SnYyT3pXb1ZHYUZYNEl1aVEvQXE2NjRrS0hNRmJpYmZ2WWlWL1pY?=
 =?utf-8?B?MTN3ejdoNFpFajArem43RnFjanZZb1J4Z05ySXUvRVFQM3B6Tng4K0F5YVZw?=
 =?utf-8?B?Q2NTMkhtRXRpMUhXK1FjMUtqV0NVWGJuZEJ6clliR0pFMUVLQzRuVFRmVDRM?=
 =?utf-8?B?bXR3NnUvZC93YktMNmpwZEFJQUE2aVh2eUgwN1hVM2RnajBJRGpkRkNVV1Mr?=
 =?utf-8?B?eWVXUXg4OG1zSGJRM2lTa2RpcVlRWGp4TlFqc0orTlZ4Q3NVSERsbk1teUZx?=
 =?utf-8?B?NTVHRGRYdXJkWFdvSTlORXVMQ0g3Y2NCNmk3ZlVGbWdCdEdKaDhDMFhNT1pv?=
 =?utf-8?B?T1ZpM2FJUzFYYkEwLzdNV3IyQWFWUGMyWERrenloT0tES1lZQ1NlRldFTW51?=
 =?utf-8?B?RU0waE1QUTdGaU9RMCtqK29TL2RUdFRuQkRvY0VJdXBwNkdnQktYNzUxWjZ6?=
 =?utf-8?B?R3QvRDZrM3RrbDMxZm9pc2tXeFBsaU0wN1c5VzhWVHVZWnpLbVAzVUFoTm8x?=
 =?utf-8?B?TUhHVlJJQ2tRNDRsMVV4UHo1dWNqdFZwMjYya0FwamhrTUtmVktFcjdPOWFW?=
 =?utf-8?B?NnhFRXBQUVdZd3hnMHdpc1RGbVBuNlNjZ0tlR3BtalByakhTamRUQ0gyUFhp?=
 =?utf-8?B?eEc3UGFwS1BmNzF3blFHV1BDRGtTYzJGVlJVUmlnYVZTb0xNNGgwTUVZbWls?=
 =?utf-8?B?RkhOTGNWdTFzOUpzYnlXVHN0eWVzaUc0KzRyK2lhOXc2MTFXd0paTk54WGNC?=
 =?utf-8?B?Y1hYSldHK3FTUmhHVldYZXhvcUpmTXZRSUFxbnpEU0NMMlErSmo4ZGlyUUVi?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3b3055-9f09-4c6c-9885-08db8dc55aaf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 10:44:57.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cATLo912uCZa0Ogw9xRcIXkj6m01KbNJNmkWqVo7dLNzKwXW9zaCkt5eWbFo2o9TaTX+FGjEGR3RPQCnE3meSIal8/uXlQuiwZ3S0gb+ycE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6852
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexander H Duyck <alexander.duyck@gmail.com>
Date: Tue, 25 Jul 2023 08:47:46 -0700

> On Tue, 2023-07-25 at 21:12 +0800, Yunsheng Lin wrote:
>> Split types and pure function declarations from page_pool.h
>> and add them in page_pool/types.h, so that C sources can
>> include page_pool.h and headers should generally only include
>> page_pool/types.h as suggested by jakub.
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>> CC: Alexander Lobakin <aleksander.lobakin@intel.com>

[...]

>> +/* Caller must provide appropriate safe context, e.g. NAPI. */
>> +void page_pool_update_nid(struct page_pool *pool, int new_nid);
>> +
>> +#endif /* _NET_PAGE_POOL_H */
> 
> 
> This seems kind of overkill for what is needed. It seems like the
> general thought process with splitting this was so that you had just
> the minimum of what is needed to support skbuff.h and the functions
> declared there. The rest of this would then be added via the .h to the
> .c files that will actually be calling the functions.
> 
> By that logic I think the only thing we really need is the function
> declaration for page_pool_return_skb_page moved into skbuff.h. We could
> then just remove page_pool.h from skbuff.h couldn't we?

This patch is not to drop page_pool.h include from skbuff.h.
This is more future-proof (since I'm dropping this include anyway in my
series) to have includes organized and prevent cases like that one with
skbuff.h from happening. And to save some CPU cycles on preprocessing if
that makes sense.

> 
> Another thing we could consider doing is looking at splitting things up
> so that we had a include file in net/core/page_pool.h to handle some of
> the cases where we are just linking the page_pool bits to other core
> file bits such as xdp.c and skbuff.c.

Thanks,
Olek

