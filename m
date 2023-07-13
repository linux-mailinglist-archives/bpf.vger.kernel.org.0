Return-Path: <bpf+bounces-4894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B37751649
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF24281AD2
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AC8817;
	Thu, 13 Jul 2023 02:23:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD4D7C;
	Thu, 13 Jul 2023 02:23:15 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E3CE42;
	Wed, 12 Jul 2023 19:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJMlFKdBTVrwMP1kwN+9JIxxw85KTn+cXqhM15H2OxguNHdPbgL7xZMFdgeSOPSyRT4dbZaDS+ixShwQAQ6fpaEp31mRrZLKJxV15X7nm2YVmI2W5McWertsc1HFw0RPPJuGkHtOUW3W0vLZpEWV+H0RMKGmKMA3Z81Ti4KURjEBBEz1gOgCJkRliUXWNozYyMwUXxHdLUIsuQ1MoGLPMPFMmQwtq3gLSLMqH4Qn3HdpSTJm+CYGi5uj03EYbsPsXFA1CKEVnRKxT2AxS0CsoIsFIkCXMn9+O86KiADby7EgTgdX9kOPrujesYX+aGfLpNXeWri9kXgItcSz56r4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4Zp9meooRmxJwVte2Ty61V4pAsCu+q1lFDB+gmkQt4=;
 b=GHV4MMpRfYUrmQrHXTWgQOlczg0LoIgHErOzv5fQArDWOYJ49xr+hD4t2k0KCbJYhPt9gKUJ0hjGeaBhGwdEHyk/BhVCAvLUW7ff3uee25YTBepbPT26LRFpkmj2U2aH2D+g0tkbVIFU7miujIBXzR+mAw6sV50MKkBQT5jWK3+FU2ahxfh5EfDDVlOCNGwkPII8tb1tm1V/hzm5gMurKSc6PlbyOrFHIoka3Z2zTrwNqPO8uJsn4b20ltm2FHWEowzS5ISLWapy9vtEmYi8Wlrwr86qfSv99YXa1t/BOR4h4Wda+bcKPbJZcE9YZf5W54PB9/fpcXj+YP/U+bkQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4Zp9meooRmxJwVte2Ty61V4pAsCu+q1lFDB+gmkQt4=;
 b=HLBHpsAqaJumZGT3Uc4wt26IDf10nVlDox1FPgL95QN6B6GBYMSha7LypRDzIp/txliElSbYcLbdWS5Jhin8RabsVDMu48dM98XYlIYQbIzq0txEJNtKHD2V63+NNP2vmSfguHmWAWb6xGZ1QCV+Aj4/P69KsKvvppdIpwwKVIha8a8VP1K9g5FcfrpasfDTclCIobijmxwmsfwASUe8IgrVh3IDS86eVPyUH+7wUy/tAK9Bor3rDULc+hgtcvtqYDjTQ6Qut19tpQuhjgDQ/FXTJDH+3rS8mePt0pbHveMD2UHuxVfalJpQFXAVo9xnvtm1VAOdmFzIGE+mcWsbZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.33; Thu, 13 Jul
 2023 02:23:08 +0000
Received: from IA1PR12MB6019.namprd12.prod.outlook.com
 ([fe80::7185:fb6e:af4:4ecd]) by IA1PR12MB6019.namprd12.prod.outlook.com
 ([fe80::7185:fb6e:af4:4ecd%4]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 02:23:08 +0000
Message-ID: <31f9d78d-aec0-8e34-f499-ada44578657a@nvidia.com>
Date: Thu, 13 Jul 2023 10:22:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt
 coalescing support
Content-Language: en-US
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 jiri@nvidia.com, dtatulea@nvidia.com
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <e77232b9-a290-545b-cb02-ae1fbc2cd5cb@linux.alibaba.com>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <e77232b9-a290-545b-cb02-ae1fbc2cd5cb@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To IA1PR12MB6019.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6019:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: f0306b83-91e5-47b8-58c8-08db834818a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BDJt68Tz9jscTS5TCxakXtAuAZezSiekqDOoVVwbTeKMahbY4J+Jw0wI6Tu4DZyguSNllxyiTKmY2moSbBWAu8NGHSbHyty4ewjJMg246/3I/4V3ASmPXrZfb774EbMtjFlEGfhH0fityAOO5LmK63ezO0efxKfpjgdN5aX7Z4u7pazVwxmg7pMy0AaD8GjSczO2FI8sECscab4+DaHs5Ip7qq7mNCrrrQkVpx8oddS1GKxTB8oNFvAd6gAKDU2Yr8JDBYqxaEPNBF9ZibBOWm6dKzfOJRKltMO9bhb7DQHv7hMX+k67+MEzW0ANBNaylT/+RbMZ3LQIU6/qS8ap88p8BdE23mTKrPwEJhk8cnsReuAxencpowfXCgu7zEonbkwYVJGyk1KK6/lPilpokmRL2Lsj/gMbPW+1cpg3DbWnJXp0Av+c5Z5uxImBkbko/d3vgsCTuvfc52HmsQPPUXyoNJckcb6l/vHpbRrdQ/5eqQ3VdV7zLMFTTVy34E5lA2wWgil4kxMZ4dQK3MHXUrFHci0EbggHzapr0I7M6XxRPhgbWzHkrFc0a2zy+naQBk0byw1d0Pw3CgbBrlEuvQ2r5ZAyQlZzydaNw8zqPPCyorh7EUsmAjI23PIc0m69ckNFemK+jxarNW7+9wKirA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6019.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(31686004)(478600001)(6666004)(6486002)(2616005)(83380400001)(36756003)(86362001)(31696002)(2906002)(107886003)(186003)(26005)(6506007)(53546011)(6512007)(38100700002)(8676002)(66476007)(66556008)(6916009)(316002)(41300700001)(66946007)(5660300002)(8936002)(4326008)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2d4VjRsUXVQeHd5NDVUVWRrbUdvL3hGbnc1cW9RLzVBNTl6Z3NkRlRRWHFr?=
 =?utf-8?B?cTJqeEgxUWt5Q29VRkMvdzNGRXIyZXB5RHNzTEtjS0s5VlBJYk1xY3pWU3hz?=
 =?utf-8?B?WFVNeU1GenlnYVkrb0s5QW8rN0xJdm9jWTBXK2FjNFBwcElJL0JXRWhjS2w2?=
 =?utf-8?B?cHB6QzFpSTJDOWpsd3RuMnY1b0VCclRaZmNMbEVFUXN3TW1UeWMxdkgxdmtM?=
 =?utf-8?B?YWEwWGtqbEZCSS9NbFZUNS9Gdy9xMmVEdmNFZEtUN1ZMWlhOUXkyNHluY01Q?=
 =?utf-8?B?aXFwM25sZHJmZUFCQXJCTWxXU0RUbFU4TWhZNThzT0hORnBOemR2YTlVdmlX?=
 =?utf-8?B?RGVzQ29FSXlXYzdMenZiWDBJT0FBVDBUdlduaHRqZXVXdU5oVDVYL2JVTEpz?=
 =?utf-8?B?Rit5UXF5N3RNbHFtdUNqQlR0REpQOWpLSlZZbGRqSnFPTXZUTXJ0d0VDbG9X?=
 =?utf-8?B?U2VRVDQ1T2p6UEQvU3FKNnEzTUUvM2c2SHVDNXRvZWdIMGxIUy93ZDlqZDVG?=
 =?utf-8?B?NmdOcjcxaWgrMnkxc1dKTW02M0lwL3pjNEJwYy8xdldFb3c0NCtnaWsyLzNG?=
 =?utf-8?B?bFZ6UHdNSHhQcDZZL3ZtcVhLTWRzVzNVV291eEcrZFNacDY1YVhDcm1jd1I4?=
 =?utf-8?B?WmNEOWpOdndGQnRJcEo0U1lWTjRLelA5TFNnVTdXN0ZqRGI1UGM5OURldWhI?=
 =?utf-8?B?UnhaQUZERHNXQmVnNGUrNThhQ1J1bUhoWm9ZN1VCM1IxY0lld0RpV1hyb3ZI?=
 =?utf-8?B?ZHZVamNrREtrRHNRT0ZtQStnLzhBSFhNcC9TekpiN3ZPd3c2TVdJZ00rR2lx?=
 =?utf-8?B?WEpvUVRrYzJZRzllV0wwbjgzV1BNOVNPYmFUK0RRUlJMQjZ0eHF6R0xkZ28v?=
 =?utf-8?B?S3RhK3JjZkdDTjNsRnJQUmJIMFJIcVNMWXQ4M0VjNGh5YXhNcmhpbHZ0STIv?=
 =?utf-8?B?SDRuc1UyZ1RQMW96OHdYWUpHT2tHRWxBRWRORUhKZ255WXVmNnVPUTVhMStD?=
 =?utf-8?B?OWk0K0lPSHd0b3l1bWpETlp5MWcwR1lWaDNvN2ZpdE1kc3NlVzVPMjZzMnZl?=
 =?utf-8?B?dThGUjNvNmNwaFhOaGpzYmUrZFJGOGVTMmQzTmZTbGo3clMwemYyM2xJUUNi?=
 =?utf-8?B?R2kvRUxvWlhSd0ttM3BmRENGeUVEVGRJUzB0bm5ycW96WUljRGg1TU5kWmxY?=
 =?utf-8?B?NnlDZkhGUXQzaEgvQWpyaEJLNFYxdm5lNFl2STMvMWRLM056dWVEUjRIdkxR?=
 =?utf-8?B?N0ZBbVNJbU1KVDU0Nm1HSlpxRVZDdlRxc2RVa2tMYUc5WW9WZmE5dmgzcmZp?=
 =?utf-8?B?L0tiWDdqOGoxeXFwcFVEWnhncjFuK1hoY2lxYk5CZUZvK1RRakRKV242aEdr?=
 =?utf-8?B?ZjNuOE1VOWZKVFoyamRLSnVRZktsZlc4RS8zdWpDR2ZDSkpwMTVVbE0rMHdL?=
 =?utf-8?B?ZzRkalFVdXdMY2lOYzUzaCtJazY5cVdubXVoaWZuL1JkbzB2VDFXdFFoRHJs?=
 =?utf-8?B?Wk9zWEIvbEt0OGFRRnJCZEI0MnAzeVlacVVaNW9JeVRoN245YVllQ253NkZ2?=
 =?utf-8?B?T3lXdGZaWGNTYnNvanQvenBtMlR5Qk93R0k4VGU4NUptRVByeGpCS3hKOWV2?=
 =?utf-8?B?RzJiSkJBVTZEa1BMUGZBMU40QzVhVjhOZHpMZUh6RzZmby9JZUdXbDhobnln?=
 =?utf-8?B?MTQ3SFZkbjBBY1Z2WWJTaHlZcXhOYk9VNFlTWFJKVnpmV0dpbDFaUmJDNmZ5?=
 =?utf-8?B?MnRtbm9xRU9ZVTlRWFFnZG1lalZ3NTYwRzdyNUdKYVNTemRoOXNFY1BRNWc4?=
 =?utf-8?B?Slh4OE5tMTBIY0hwWG1uVXEweFpqaXpzeUhDMXVXL29kdG5rcEFoZnlIL3Bi?=
 =?utf-8?B?S2VOeXZSYlc4QkgrUXdESUVNTUFaeFMwaEFpcWdHdGMvT1MwUDBOTGVLelNK?=
 =?utf-8?B?STREcEl0RlI4MTkzcTBvNjdaOHlmMVpTYmFxTXlxSzEyWjY3SHhORDZod080?=
 =?utf-8?B?WkhyeUloaDAwZEk0N0QvMUh1VUxXZTVnZTA5RE05dTl6VmdVRVJzYXdrVGIw?=
 =?utf-8?B?a2oraGxlRXEzc3NxUEhZQnRZUkJoaFdpK296WHZhZW5yUG50RTRVTjMzdWcr?=
 =?utf-8?Q?MdDg84DW1EOSdS+IXsVZomkyX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0306b83-91e5-47b8-58c8-08db834818a8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6019.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 02:23:08.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCJakgMK/vro8jEXaWyz5ss1dXtxenJupvNvaBkGlDt/BdVanzkWrm1YSJ/APTI/AnISTq9svwCthHps86FnrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/12/2023 4:34 PM, Heng Qi wrote:
> 
> 
> 在 2023/7/10 下午5:20, Gavin Li 写道:
>> Currently, coalescing parameters are grouped for all transmit and receive
>> virtqueues. This patch series add support to set or get the parameters 
>> for
>> a specified virtqueue.
>>
>> When the traffic between virtqueues is unbalanced, for example, one 
>> virtqueue
>> is busy and another virtqueue is idle, then it will be very useful to
>> control coalescing parameters at the virtqueue granularity.
> 
> 
> We definitely did the same thing, and I'm waiting for our hardware 
> implementation to be ready to
> push the ethtool + netdim implementation.
> 
> Since this commit log is completely copied from the implementation of 
> the virtio spec, consulting
> each other's scheduling plan in advance can be friendly to avoid us 
> doing the same thing and consuming an extra effort.
> 
> Thanks.
> 
I didn't know about the effort you made and the progress of it.
Since the code has been done and tested, I'll continue submission.
>>
>> Example command:
>> $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
>> Would set max_packets=10 to VQ 1.
>> $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
>> Would set max_packets=10 to VQ 0.
>> $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
>>   Queue: 0
>>   Adaptive RX: off  TX: off
>>   stats-block-usecs: 0
>>   sample-interval: 0
>>   pkt-rate-low: 0
>>   pkt-rate-high: 0
>>
>>   rx-usecs: 222
>>   rx-frames: 0
>>   rx-usecs-irq: 0
>>   rx-frames-irq: 256
>>
>>   tx-usecs: 222
>>   tx-frames: 0
>>   tx-usecs-irq: 0
>>   tx-frames-irq: 256
>>
>>   rx-usecs-low: 0
>>   rx-frame-low: 0
>>   tx-usecs-low: 0
>>   tx-frame-low: 0
>>
>>   rx-usecs-high: 0
>>   rx-frame-high: 0
>>   tx-usecs-high: 0
>>   tx-frame-high: 0
>>
>> In this patch series:
>> Patch-1: Extract interrupt coalescing settings to a structure.
>> Patch-2: Extract get/set interrupt coalesce to a function.
>> Patch-3: Support per queue interrupt coalesce command.
>> Patch-4: Enable per queue interrupt coalesce feature.
>>
>> Gavin Li (4):
>>    virtio_net: extract interrupt coalescing settings to a structure
>>    virtio_net: extract get/set interrupt coalesce to a function
>>    virtio_net: support per queue interrupt coalesce command
>>    virtio_net: enable per queue interrupt coalesce feature
>>
>>   drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
>>   include/uapi/linux/virtio_net.h |  14 +++
>>   2 files changed, 154 insertions(+), 29 deletions(-)
>>
> 

