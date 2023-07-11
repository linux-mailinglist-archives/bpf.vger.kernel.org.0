Return-Path: <bpf+bounces-4702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3667374E44E
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 04:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73643281634
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 02:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9621843;
	Tue, 11 Jul 2023 02:34:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB017F;
	Tue, 11 Jul 2023 02:34:53 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::621])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AC7BE;
	Mon, 10 Jul 2023 19:34:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzjJc278DmVe7JIyQIHLxRrY0Vxla6xB9WXxBLDaiKeZ/N30EnSHjSYXxdylE5yzcbPGzKFT93xczESS1DFnvy3cqFkC4gu1VAgbMPY5IwW9NdAlz3O9Bm8wVTyl7ZNI8V0dyP1zk78zs2PNt4+z0enWmkUeUVLQTvr+R8Xl4EkVhl8ELJA/eypTUzA2W4Ey4ui233ybLydfymeXsT29robYvrBJuwkJcsKEP+iQCnzwMfOJzey1oY0y8DCbrIAvqelpOxXSbyp4Pi5IbBhllcXN25hISS8wKE9qcRcalMDRpY34N96ZskZ3kbsUeG2SrrhO0XsD+9B2mAdPzqKttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiwqzGjrYK1eVA/VdDiUIrh5CU2vd9hqAOrFiZQcElM=;
 b=FlT2YZ5n8+4iCfxl/VXZ9Z2oJpyvMrVsBvANF5PqA6kCOr3Ndp98ImHtg4QM6kjOYfBqM3zuI8HDF3z8LbsMx2XUXeJm1PVUYaZXSvqKNqhLacuDAdJJ3ZACLL43ncBblV9KL2S8MacPQlF4LIjuQ81ZvvB+FdH/C5WHUjZ/8AbhE69o8OLiTdMY3HU02WF+rPG4UeqoUxvjuBCv1La6u6LH4hgWK/EFcDOigIIpn58Y0JAxD+ZU5DGygBZpEDEECRZkVivXMS6ehgHn4ElWGsI6dKk7BBcUc9bixGE6gIFouzWzSKM8yvmpcjUZ5bBQBiU91dB/7ZtwlCBMcNy23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiwqzGjrYK1eVA/VdDiUIrh5CU2vd9hqAOrFiZQcElM=;
 b=jQFzMUSO3lFIBCAUaIVL8YGi0MIbd3bO+BrAMvM4PDLtGZaai4WRCvg5f7nDo7r1T7Uunf1esS/kDnh27omWWnXBIJvdtegTYZu2E8XHEDfZqFU50PZQv7ZREF5hZVnOJU2P+QZGr9j5fEiQbMXpXt5+opMu5XINqT9gP8qnp6Cz9nXwExsdHUHdBYlp8D0vmcLUmlSXesAVUz30NM+i3Uczt8Yr9+lyZ0ED5NW0MxVUbUjy0Xn/4HZyWvcUM990bBC8kFGqCR5EG6CMfBVxmp/e7El+1DNjttGCWdhXLVamNSZ7b0o9FuXGKEG1/52AspN72Vsk+Elz53RMwVjpNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 by SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 02:34:49 +0000
Received: from CY5PR12MB6036.namprd12.prod.outlook.com
 ([fe80::69ec:e7ff:85d:8121]) by CY5PR12MB6036.namprd12.prod.outlook.com
 ([fe80::69ec:e7ff:85d:8121%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 02:34:49 +0000
Message-ID: <ea32a1cf-3a77-d63b-034f-0f80d2dd80ea@nvidia.com>
Date: Tue, 11 Jul 2023 10:34:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt
 coalescing support
Content-Language: en-US
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, jiri@nvidia.com,
 dtatulea@nvidia.com, Heng Qi <hengqi@linux.alibaba.com>
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <1688981109.6377137-1-xuanzhuo@linux.alibaba.com>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <1688981109.6377137-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To CY5PR12MB6036.namprd12.prod.outlook.com
 (2603:10b6:930:2c::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6036:EE_|SN7PR12MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 191e98eb-f2d1-4955-5f85-08db81b7659d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8tH+ydAlC70gCCvy6Tm/lHaIPYnPaUf8pltNEvHrNjOKK6vSixSrN//aHJilOvfnbfEGyzj6wE0kGppsIPx8KD2NluQo9nMf7h+VqXPmve5dpqivvtDMQ5O5A6ShuVxVnp9unw6ZdVIC5V8nDiz4DO+RmdYxQnYbmbHH6G9tCjfIt8N+TcN339bdeayKK5P/bv1y4nzrcXrdJa9n80D9RVfxz1ocKpXoLgpfntIEvDAFB6eogwWBbi0mo0+5ZxX9IYWGL5Ajvr485o1ABzCeHKY2gIN0n9SzdZJNDhsj/8N8Wf8e2hE8Ck9NgA42tH9niF1O3m6PxjLurMoaw+HQdFBSVlhB+avtRsu5p6qzFqZuCADFpjr7+4DDY4o6pkKwdpfgKqS4X45hFUG8HSyW5IfQ1O4e4UsLFVeA74GrLPVM1diBrr5UM9b7fZIZhFYvPQdPCxJyC4AQPG5tIFsy/B0rwKiHcjIssBaL4NsXHccdAYbq0D+hJ3s0I4x3n5SyY6OIrLHqYbNKhMVXzGnYRm2UIU03RqM7fT/GrDM84yA2vCG07NbDIG10Le6V/ZGcNX6xW40+jA2liws/ptavG+bxiEkMYMT80kb7YxunOqEnQzkPxOSwlirTjR6guqsD1iBputpmP0X/g284yvooV+JXF+umi56nyKcrLG5Ja0ozhSG+V2OxgrcjsUpB9hy7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6036.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(7416002)(5660300002)(8676002)(8936002)(66556008)(66476007)(66946007)(2906002)(4326008)(6916009)(316002)(31686004)(41300700001)(6666004)(6486002)(6512007)(966005)(53546011)(6506007)(26005)(186003)(83380400001)(2616005)(38100700002)(478600001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmdXS3FiV3FXbk9JTW1TblUvYS9LZ1NoNWY1dE1meW9YOWFFbmlESy9kdkpL?=
 =?utf-8?B?SkNNbUU0bnhDTFlsSEZQLzJqMzVEci9CeFVIdjhVV3NBMUU4L2c4YUtBbTls?=
 =?utf-8?B?eXgyRU9PcXQrT0FCN3ZjSU5LZk85MzFZZVpnVTkvN1ZkdTZ3dFp6TTJOcUJ0?=
 =?utf-8?B?VzFyVTZ1bkNSTmdla1QrRkcxZEpFQmpiNG1VWk1RMEFXWWVFaXQvYkR3cTN0?=
 =?utf-8?B?TFhKWVp0OEYrVnVWdUpnU1V0YXg0K1B4NjNQVGlPUitkODIwYk92S0VETmpu?=
 =?utf-8?B?VllWcnNmVjYyZmFMZG1laXU1N2svUWhIOGFDVHJmZHIrRDdUK1hWMlA0RkIr?=
 =?utf-8?B?OUdDaDF0b2tuejNLOWNwbWtyeVByRUJ5VzBGenFxVVFlYXVIT3U5Y3VOUVFV?=
 =?utf-8?B?cFpaQ2g5S1NDclE4UjIrdmZrcTdYdDRsajFkSVBSYnNqUXhFbDU5QkN6Y205?=
 =?utf-8?B?RzBUaWpDK1dqZWMybE01OGN6L3VuNHhHckY2aXp1QkRkVG1OL2orbVNtK2Zr?=
 =?utf-8?B?bFdVQVBPcFBzek5FYzJpTm11bWcvWEJEUTV0UlNGay9CWVFKK01MQjE1ZWZm?=
 =?utf-8?B?WFo3d0p4SHF6WGJ0QmtHdGlhSDhVVFZ5cmJheGtYbThVeTV4clVUMVZuNWpl?=
 =?utf-8?B?My84SXFVWFV1c3VjaEVjV0lFTGhyZmJxZTNCRzRLS1VtNnpoOE9aMXZjRVVJ?=
 =?utf-8?B?R3ZOcGNWcDArai9ycTFYdTZ1a1BtNGlHbnM1NDRPa1d2dGlMM2t4K1d2akVU?=
 =?utf-8?B?eU9XcFQ2czRrOEs3dU9OVnRpeTJKL0ZUU2JJYy9vVm1oNzkrNkpFb0dTOVVq?=
 =?utf-8?B?enYyc1V2Y1VsUyswNWRhbUxlcVFPa1VaVHlEUWFhRjM4djlLcUk5bmJrNkRv?=
 =?utf-8?B?ZVcyaENWSTlERDV3TXZGTmJUWno0NzNIRSs4RTdzdXM4MEhZTzI4SzlNYXNP?=
 =?utf-8?B?eG93UzJRZit2d0xHODh4aTFDRjEyVmZBY0Q2U1pVSUt0MWIwWnFKTnM3bnJG?=
 =?utf-8?B?cmdzY09idTRNOG1NN2psV2dTMVBrMTBTemNFUDJnUFBzblN3MXBhdzl6dlRU?=
 =?utf-8?B?U3cwNnRzbHFPaU5SRmlkbGREMjI3WVRmU3d0Rno4ekpUdWU1VmkzVkZNSEVN?=
 =?utf-8?B?L3pubnhwM3FIeG9zUmJjODJHeC8xUVJ5Tm9UZlZ1ZUIxV2tqRlJpNUNqeFN1?=
 =?utf-8?B?N2k3Q244RDl1YVpTWWRzejE1Nk1MNkxtSjV1M2NQOUhZa2NZcjdkMTFVMWxz?=
 =?utf-8?B?NWpFWFhTU2NiUHRJT1JaQjhtbGoyZzBmZXl2Wk5vZjZUcm1zM1ZtaUpyNjdJ?=
 =?utf-8?B?MFJZV21NdWtyVnNOcGpBYzBxa3RGR0hxZElSTkJkZUpaTjY2NTg3M2MwTEJv?=
 =?utf-8?B?bm5aRytzZXdDTTNFZjJoZ2hZZ1BzMW9vNkc2QTVUdE9OazN0V1JuK0V4RkZ3?=
 =?utf-8?B?bWtGOUpHL2Rzc1hwZ3QwZVpMVEJjRHdRVmdvQ2h0M1hTc1djSWh6N0h6a2J6?=
 =?utf-8?B?eHdPakxJYlNEZDY4S1VpcjkvdHlTNDgvZjN6ei9HSzBWd0wraDVEQityeVVh?=
 =?utf-8?B?NlpVNTM2RzN2bk5vdkdVUG5BeWJhVjVua1hJb2dCZk9UaXBlSEtSZVNHd0Rl?=
 =?utf-8?B?UHlZcURLd3pLNXJvRUJubCtpUVRTYkFtRElZVFp1S2E1VHl5eGhJVW1MZ1JF?=
 =?utf-8?B?TWMzVHEya0xyZy9IVGRXQ3VBRW43S2VrYTBWeFhVUjBwSGFYMmNSZG9EWkFU?=
 =?utf-8?B?VFFDWnhCNHBoQ0xHS1JMQi8wUUJyZUk5YmFZOUkvajI1ZzkyZ3JlM1RiRlNk?=
 =?utf-8?B?N0E2STJ6aCtrV1Q3US9VWmFxQ2QyZWVzTHFvWXlmUFpDK0RZUFRFMWRWN1ll?=
 =?utf-8?B?R0NSUDhIdmxUaitrTEtCT3FlbHRBSWJPcklXUXI0cktUZmdoL0pHVUNMamNJ?=
 =?utf-8?B?MjdQWER3Y0ljZjJRcmZUQnlEKzdZZG5EdVhQeW9nN1oxQlMyTFlZQUFPeHE4?=
 =?utf-8?B?dUhmTUpUUkw2WklhNVFOeWpoMG1rd2g5SHllaEtTakxmcDJDTnd3OHkxVkor?=
 =?utf-8?B?UUw5a3FRUUw0UkxTRWRNOXpOWVpNNXJ1RlNqWlU3dzVrbWxjMlBSZE9VMWcy?=
 =?utf-8?Q?Yr71CGKjVbZVqDAwT9bCfVGe2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191e98eb-f2d1-4955-5f85-08db81b7659d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6036.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 02:34:49.4651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFabHfntQIg0uduGE3Wo1E0eE824E8RQH0dVmt+ZundliFGz+mtSXVFt+zgs9vY3vCe0xCV2qHhjLeEqtjT7Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 7/10/2023 5:25 PM, Xuan Zhuo wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, 10 Jul 2023 12:20:01 +0300, Gavin Li <gavinl@nvidia.com> wrote:
>
> As far as I know, Heng Qi does that. I'm not sure, it's the same piece.
>
> cc @Heng Qi
>
> Thanks.
Do you mean the one below?

https://lists.oasis-open.org/archives/virtio-dev/202303/msg00415.html

The code is to implement what it described and I don't have better 
words. So, I copied the text from Heng Qi's.

>
>
>> Currently, coalescing parameters are grouped for all transmit and receive
>> virtqueues. This patch series add support to set or get the parameters for
>> a specified virtqueue.
>>
>> When the traffic between virtqueues is unbalanced, for example, one virtqueue
>> is busy and another virtqueue is idle, then it will be very useful to
>> control coalescing parameters at the virtqueue granularity.
>>
>> Example command:
>> $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
>> Would set max_packets=10 to VQ 1.
>> $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
>> Would set max_packets=10 to VQ 0.
>> $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
>>   Queue: 0
>>   Adaptive RX: off  TX: off
>>   stats-block-usecs: 0
>>   sample-interval: 0
>>   pkt-rate-low: 0
>>   pkt-rate-high: 0
>>
>>   rx-usecs: 222
>>   rx-frames: 0
>>   rx-usecs-irq: 0
>>   rx-frames-irq: 256
>>
>>   tx-usecs: 222
>>   tx-frames: 0
>>   tx-usecs-irq: 0
>>   tx-frames-irq: 256
>>
>>   rx-usecs-low: 0
>>   rx-frame-low: 0
>>   tx-usecs-low: 0
>>   tx-frame-low: 0
>>
>>   rx-usecs-high: 0
>>   rx-frame-high: 0
>>   tx-usecs-high: 0
>>   tx-frame-high: 0
>>
>> In this patch series:
>> Patch-1: Extract interrupt coalescing settings to a structure.
>> Patch-2: Extract get/set interrupt coalesce to a function.
>> Patch-3: Support per queue interrupt coalesce command.
>> Patch-4: Enable per queue interrupt coalesce feature.
>>
>> Gavin Li (4):
>>    virtio_net: extract interrupt coalescing settings to a structure
>>    virtio_net: extract get/set interrupt coalesce to a function
>>    virtio_net: support per queue interrupt coalesce command
>>    virtio_net: enable per queue interrupt coalesce feature
>>
>>   drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
>>   include/uapi/linux/virtio_net.h |  14 +++
>>   2 files changed, 154 insertions(+), 29 deletions(-)
>>
>> --
>> 2.39.1
>>

