Return-Path: <bpf+bounces-5155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE8D75742D
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 08:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290402812CE
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 06:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D083D68;
	Tue, 18 Jul 2023 06:29:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD215A9;
	Tue, 18 Jul 2023 06:29:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::611])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F36D18D;
	Mon, 17 Jul 2023 23:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOWXac+8r7UB46y7qzd8pWq9uUc9qtZKCGpP5pu5VgIp+kuEXSD+/ItXfjib3wbHewpYucDkdgwssHJxSCwPuSflsuvhPeXfRHrkU6HVWshiTFCfMPVZ4pkvfZ7zzA1uwtCxbWmzUIeQcRpAtpi/1BsQho2abpkDzFv5cYYWmSg2vSjxoe7dmGYdhEFfWbJ9pz/b7+oUbN969Owky438lY20cH3BsG1V97yJon9YKA5qY63G3Qhrs6I1ye6kDGoRF7RQcKDdHkjRlLERoUD2BmmypLBf9r8P4y8C+MIKn7BX3Fa44X88HpcfkZSygSgR7m0Om5N49m8lIT602DEofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T5l4KBLYJVPgVwfQUFOSMM8XGEmsxbqdpfUSk+dbRk=;
 b=EUhk5/mrMustvWt9GLsvjcL7tIEpTHLgIDhfZpDmwyfANenBDGSxUS5hSrKH856dgWu/KGi0hgP5df2oDleupP/exrH/kK58NXfw9pXtbRqaxzcgM+CPnlXX1auDRc40lw2q3mL3WBI3jAMUwLb3JjQmzMVTQqyZrkEhFllwpTl8GG4pGugodq7C8XRzFgUfH9qHn/GHZiwIAQR88FMQwKfP1Rn/X/A1UDcSDXJyGrKji3YO4NjOnRicYuKU43bpPnC8ioq15+Hjv1cxDEPOAyAyueTzqRcp7kAibnUBIL8qszEu9QTJvJXkWiRuFmC5lVKHL5ndjSie5oejkr54IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T5l4KBLYJVPgVwfQUFOSMM8XGEmsxbqdpfUSk+dbRk=;
 b=HKfm/P77rYWV2Jivnb8Z20EUSIq9C3V7d6mPXtFrHKEJTOeJ7109k2czfk+aKS8DU5P2kx6Tkzy05E74d8dIGoZhiO8BXDPGa7WFOkxerYYY1fHFoQiOysEflH7DwxSA3FZZ1bXTmaY3i0FdAfpEfk+TQsniON792q0nKyA6NelO6wHthpm9xXbqU/P+Ci/nuGVikAmVKHCkdv2fXLwOyvOt7BAX+U/91WCo/heibsN4nwifDJOO53XEaxdRuJ4TMxxhIWksiEDjNTy77pjwqdRF1JIc71tzcdhk4nsFXuUn96MBoLIAmi1X755HQrrYzv2V7E7vOXmbkR7VP8EfBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 06:29:13 +0000
Received: from IA1PR12MB6019.namprd12.prod.outlook.com
 ([fe80::7185:fb6e:af4:4ecd]) by IA1PR12MB6019.namprd12.prod.outlook.com
 ([fe80::7185:fb6e:af4:4ecd%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 06:29:13 +0000
Message-ID: <6d7901b3-4583-fed0-104c-0682d869e1c3@nvidia.com>
Date: Tue, 18 Jul 2023 14:28:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V2 3/4] virtio_net: support per queue interrupt
 coalesce command
Content-Language: en-US
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: gavi@nvidia.com, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, jiri@nvidia.com
References: <20230717143037.21858-1-gavinl@nvidia.com>
 <20230717143037.21858-4-gavinl@nvidia.com>
 <47e3e22b-73a6-e2e4-05da-1a1138042d73@linux.alibaba.com>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <47e3e22b-73a6-e2e4-05da-1a1138042d73@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:4:7c::35) To IA1PR12MB6019.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6019:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: a13b9b42-3209-4146-f9fd-08db87584d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PqVyQ9PHi1zf2F3BRzdnR7jcdQvennV2jeN+O3WeqLHE14NUtQx9l3V1VPROUETN3ABuuT8GaXgP9qifArgTN95A4tAjScUtm0HKwWukL8MqUaPdb5+YezBrnvUfTFq6FXW1GLioRwc5zcvW1NqWMqo9478nhh7jpEWZcblwv4ns7iy6Yx2xdNlsFH0P74Rzp3+9Xnu0P7L+rXRjYNzX6C+rWfXbRJp+++KHm1fsIbSG6p5DznhTuzmGLW7UvxOIexb2ekUatP3kIWswgK9Uz9cHh5Uw95oa+TWE9xJ/Ts08GA1O8l1QzP8E4Tp5SxSV43KYOsIIHGsdQXazNVK2YJp8F+ZOc4WnF/vlT1t8ZrY6kz7nV1eyLEUKVt/1WMoJL1QbCQB+Nr8KNFbzlnkDfvXsFL54+WaU2FjXZXoTVg0oVEAZQlj9+hJ8eNhQZoBXrmWWVHkuSSescwFGGdDd5ylsAy+vtMplKboAqEctn/D8cLjYIWlCueLq4TRjvjeEH1s4gZ2jdee1o9V/xSjqfe+LjWnzR/xCwG+VACXerqXFMEciGL64udaATZemGoUUCyhCELW6Ebgh0/ioPZmhU4VH4mPOG6o7hiA6Fvvf2ivObsMcf7vTQtDwnHu9EXfHCqnfPgOtfs4LIQqlp0S3zw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6019.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(478600001)(6486002)(6666004)(186003)(53546011)(6506007)(107886003)(6512007)(2906002)(26005)(4326008)(66476007)(41300700001)(66946007)(5660300002)(8676002)(7416002)(8936002)(6916009)(316002)(66556008)(38100700002)(86362001)(36756003)(31696002)(83380400001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmVOSWpQV1BVUEd5UmUwUGtYWjNzaXpJR3gwWWxjWlVsaFFrbm1SbGVub0FX?=
 =?utf-8?B?c2pYdzR6ZXRReWxNaU5jSFhCbURvU1pVZ0UzNXFjbURmdTVLYnNXM0F3bW05?=
 =?utf-8?B?dEJ1SkVqVkFoS3ZBU290ZUd4MFdKMDlOU1M1REdVT0lPS2xXRTc3dmoyQ1Zy?=
 =?utf-8?B?VmVYWTV2b2UrM2JEMVNxT1NSc1MwYWphV3RORHJvdVdLWVdHSGQ1UEpMU0Q1?=
 =?utf-8?B?ZWcwTG1IcFZmMmd2cTNJVUxOSGU0cXRhUlZoSlBDU0syckxQRk92WGRtYmEr?=
 =?utf-8?B?WWthTTVCazBiWlpSNGJ0cFN6UmUwWGJORXJTY0wzVmpRRjVvSVlqcmFaU3ZU?=
 =?utf-8?B?aU1oOUpVb2ozdFk2dm9iOHEyYkZBZDFPZGVyMWpUajlsVGRiLzJqVzZ5UGd5?=
 =?utf-8?B?a1czQUV4T3JDOHJqb3FGWTZYOE1tYWtZdEpMMFlKT1NscGRSVnU2czVpbnBP?=
 =?utf-8?B?enR6RnlFZUdsL1FCLzQvd3h6bkdkOC9QbFJHbWNxRHVIOXVkY0FjWlRPZGVL?=
 =?utf-8?B?OC96alJMdm9kMlZvWCs1OElrT2pYMFZxUnFYQm1ucERWMjFBUGU5S3Nwbkhw?=
 =?utf-8?B?bGpSSW1lVFdrZ0t4UTFweFF0NUdZUmhWZ3dQcG1yYm9CQ1NRcml3SVNiNjFo?=
 =?utf-8?B?QmJ5Rk81TlkvZkUwRzF4R3VCY29GbG1rQjZOV1dXR0RLTnd1OVJWUzBldHBQ?=
 =?utf-8?B?QjQvNGxYQ3k0R0hZdHlMWXZTZ1RPQWI2L3FPUmMrNkU2SEZuOFlhMDFnZFp0?=
 =?utf-8?B?SmxBRmU3ZXNmUXJ1M0ZJSERqS044UVJrSE1zYkY1NWE4TEk1eXRSZTUvT3FW?=
 =?utf-8?B?UEVLc3BvaDNvRW1UM3pobWlsUVZON29RNXJ4NG1iTzc3dDBYVTR1dmpITGox?=
 =?utf-8?B?OVgyeGw3TEdVTkJNM204SFpVY05oSmZ3TDc5Y0lBVVR0eURsNGdBTUFWMmZZ?=
 =?utf-8?B?dGRVU2NGY1NIOFlGY3Z5bkNRcVdJckNmNElzRmNuSytxUFh3bWxWZHZxaUFx?=
 =?utf-8?B?M09oZHhjd2h0d3BXWFdwVlQ2RDlhWkM5NGNtUzhTOVJtWDdkWHFEcTVEcE9U?=
 =?utf-8?B?N1BLOG1kU2NkTVVuTG1SM0JwQ0p4RHVPRE1KeTRybDhEQ1YyS1hhR0pGTS9H?=
 =?utf-8?B?RnJJcUVDUHp0bDg3UkdiUzhsOTJUWjZhUGwvaVZYT1pNV1Q1R2RZQjZUQklL?=
 =?utf-8?B?YXo2akdnNDd5K2Y0c3ZWYXJpTFdsaU9GUC9hRTVObHgyR0lycUNsa3FtK3BF?=
 =?utf-8?B?UEpDVTBuSzRyWngrd1gyTTJ6QlNnZUczTFJiT0NPNi9QeFlUR09xY0wzYWt1?=
 =?utf-8?B?dUQ4WU55WnlWQXQ1Y1M2SkVmOXE0WCtWazZ1eFBTcVlHYnFmV2cxdW5oYzBi?=
 =?utf-8?B?NElTVzh1SmNVeHd6SUE4MkxTZUdSdFhmZHRIdExtTFZpbnRJRXJScGVCVFhs?=
 =?utf-8?B?dEpZYXFwaEtzeldGVjhCYllZaEZGNlRLdTJ1VWxEOWVLanZ2cTc1NUliK2Vl?=
 =?utf-8?B?ZHEwQmt0eTRCQWcvYTF4YkNBM1VUdEtpR0VDeGRMRVREaWpBUVNtQTBmUnZq?=
 =?utf-8?B?OHNQZ09CQWYvRkZjektuaFk0c09aS0UzV2g3SVZzYStCTHViQkZleHdEZXUr?=
 =?utf-8?B?T3JQVmZ5bGVXWVV6OXZWSXg3bU8yeVRpbllQWGJrdlRPWEtGMzd4S3BzTWMv?=
 =?utf-8?B?MHFrV0hITlJMWGp2ZU9DdTZTTDRKWC9Nb3Y5c2ZSRHBTZlRtSThsMHhPV0hh?=
 =?utf-8?B?YXg0SW0wdEthSDhLMUgxeGFOeldpRlRXWWFvOUp4Ykc1UVFIeHJVR2E3Y0VM?=
 =?utf-8?B?cWRiRHdqSDArN2hrMmVnMkhScEZoVjczWnpITGN3dzdpNURpaWJ0OGpsMm5s?=
 =?utf-8?B?cGFzUzlQZGpBaVlWNDljbm5jQjFoRnJsM200ZzVJWXRxYVI3K1plUWhWYVhX?=
 =?utf-8?B?b3NIak9lRVBjYTBTaDlhbVdIVm5DUEZVc25SWjBSbXVZSXdiWW05MkZjL09F?=
 =?utf-8?B?cXJuRTNvT0svWGdiR0svYjAvK2pjcGRzVE04VkR4T2dCeHBUTnV5Q3ArS001?=
 =?utf-8?B?NkR6RHJXRldXT2o5ay9oN3Rkd3Q3S2kwTjBnd0dPdkJ2UXNEM3V6TUtkdkV6?=
 =?utf-8?Q?n69cwB5IGWKZgDs+kXIV/r4pp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13b9b42-3209-4146-f9fd-08db87584d8f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6019.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 06:29:13.2558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lG6MQ7N1H6CpjiejJaYZyljwBT/QBPM6IWGSJYqVhg+5axzSCWUo/4pLikpYv6C+l3qj1XVInc/hrlPEqNMNMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/18/2023 11:29 AM, Heng Qi wrote:
> 
> 
> 在 2023/7/17 下午10:30, Gavin Li 写道:
>> Add interrupt_coalesce config in send_queue and receive_queue to cache 
>> user
>> config.
>>
>> Send per virtqueue interrupt moderation config to underline device in 
>> order
>> to have more efficient interrupt moderation and cpu utilization of guest
>> VM.
>>
>> Signed-off-by: Gavin Li <gavinl@nvidia.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   drivers/net/virtio_net.c        | 123 ++++++++++++++++++++++++++++----
>>   include/uapi/linux/virtio_net.h |  14 ++++
>>   2 files changed, 125 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 802ed21453f5..1566c7de9436 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -144,6 +144,8 @@ struct send_queue {
>>       struct virtnet_sq_stats stats;
>> +    struct virtnet_interrupt_coalesce intr_coal;
>> +
>>       struct napi_struct napi;
>>       /* Record whether sq is in reset state. */
>> @@ -161,6 +163,8 @@ struct receive_queue {
>>       struct virtnet_rq_stats stats;
>> +    struct virtnet_interrupt_coalesce intr_coal;
>> +
>>       /* Chain pages by the private ptr. */
>>       struct page *pages;
>> @@ -3078,6 +3082,59 @@ static int virtnet_send_notf_coal_cmds(struct 
>> virtnet_info *vi,
>>       return 0;
>>   }
>> +static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
>> +                     u16 vqn, u32 max_usecs, u32 max_packets)
>> +{
>> +    struct virtio_net_ctrl_coal_vq *coal_vq;
>> +    struct scatterlist sgs;
>> +
>> +    coal_vq = kzalloc(sizeof(*coal_vq), GFP_KERNEL);
> 
> I think this should go in the structure control_buf, which serves two 
> purposes, and that's on the heap in init_vqs():
> 1. We can have the same form as other control types, such as 
> virtio_net_ctrl_coal_{tx, rx};
> 2. Avoid using heap memory here to cause the following memory leaks
ACK
> 
>> +    if (!coal_vq)
>> +        return -ENOMEM;
>> +    coal_vq->vqn = cpu_to_le16(vqn);
>> +    coal_vq->coal.max_usecs = cpu_to_le32(max_usecs);
>> +    coal_vq->coal.max_packets = cpu_to_le32(max_packets);
>> +    sg_init_one(&sgs, coal_vq, sizeof(*coal_vq));
>> +
>> +    if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>> +                  VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
>> +                  &sgs))
>> +        return -EINVAL;
> 
> If this fails, we should free coal_vq, so pls move coal_vq into 
> control_buf.
> 
> Thanks.
> ACK
>> +
>> +    return 0;
>> +}
>> +
>> +static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
>> +                      struct ethtool_coalesce *ec,
>> +                      u16 queue)
>> +{
>> +    int err;
>> +
>> +    if (ec->rx_coalesce_usecs || ec->rx_max_coalesced_frames) {
>> +        err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
>> +                            ec->rx_coalesce_usecs,
>> +                            ec->rx_max_coalesced_frames);
>> +        if (err)
>> +            return err;
>> +        /* Save parameters */
>> +        vi->rq[queue].intr_coal.max_usecs = ec->rx_coalesce_usecs;
>> +        vi->rq[queue].intr_coal.max_packets = 
>> ec->rx_max_coalesced_frames;
>> +    }
>> +
>> +    if (ec->tx_coalesce_usecs || ec->tx_max_coalesced_frames) {
>> +        err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
>> +                            ec->tx_coalesce_usecs,
>> +                            ec->tx_max_coalesced_frames);
>> +        if (err)
>> +            return err;
>> +        /* Save parameters */
>> +        vi->sq[queue].intr_coal.max_usecs = ec->tx_coalesce_usecs;
>> +        vi->sq[queue].intr_coal.max_packets = 
>> ec->tx_max_coalesced_frames;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>>   {
>>       /* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_COAL
>> @@ -3094,23 +3151,39 @@ static int 
>> virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>>   }
>>   static int virtnet_set_coalesce_one(struct net_device *dev,
>> -                    struct ethtool_coalesce *ec)
>> +                    struct ethtool_coalesce *ec,
>> +                    bool per_queue,
>> +                    u32 queue)
>>   {
>>       struct virtnet_info *vi = netdev_priv(dev);
>> -    int ret, i, napi_weight;
>> +    int queue_count = per_queue ? 1 : vi->max_queue_pairs;
>> +    int queue_number = per_queue ? queue : 0;
>>       bool update_napi = false;
>> +    int ret, i, napi_weight;
>> +
>> +    if (queue >= vi->max_queue_pairs)
>> +        return -EINVAL;
>>       /* Can't change NAPI weight if the link is up */
>>       napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
>> -    if (napi_weight ^ vi->sq[0].napi.weight) {
>> -        if (dev->flags & IFF_UP)
>> -            return -EBUSY;
>> -        else
>> +    for (i = queue_number; i < queue_count; i++) {
>> +        if (napi_weight ^ vi->sq[i].napi.weight) {
>> +            if (dev->flags & IFF_UP)
>> +                return -EBUSY;
>> +
>>               update_napi = true;
>> +            /* All queues that belong to [queue_number, queue_count] 
>> will be
>> +             * updated for the sake of simplicity, which might not be 
>> necessary
>> +             */
>> +            queue_number = i;
>> +            break;
>> +        }
>>       }
>> -    if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
>> +    if (!per_queue && virtio_has_feature(vi->vdev, 
>> VIRTIO_NET_F_NOTF_COAL))
>>           ret = virtnet_send_notf_coal_cmds(vi, ec);
>> +    else if (per_queue && virtio_has_feature(vi->vdev, 
>> VIRTIO_NET_F_VQ_NOTF_COAL))
>> +        ret = virtnet_send_notf_coal_vq_cmds(vi, ec, queue);
>>       else
>>           ret = virtnet_coal_params_supported(ec);
>> @@ -3118,7 +3191,7 @@ static int virtnet_set_coalesce_one(struct 
>> net_device *dev,
>>           return ret;
>>       if (update_napi) {
>> -        for (i = 0; i < vi->max_queue_pairs; i++)
>> +        for (i = queue_number; i < queue_count; i++)
>>               vi->sq[i].napi.weight = napi_weight;
>>       }
>> @@ -3130,19 +3203,29 @@ static int virtnet_set_coalesce(struct 
>> net_device *dev,
>>                   struct kernel_ethtool_coalesce *kernel_coal,
>>                   struct netlink_ext_ack *extack)
>>   {
>> -    return virtnet_set_coalesce_one(dev, ec);
>> +    return virtnet_set_coalesce_one(dev, ec, false, 0);
>>   }
>>   static int virtnet_get_coalesce_one(struct net_device *dev,
>> -                    struct ethtool_coalesce *ec)
>> +                    struct ethtool_coalesce *ec,
>> +                    bool per_queue,
>> +                    u32 queue)
>>   {
>>       struct virtnet_info *vi = netdev_priv(dev);
>> -    if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
>> +    if (queue >= vi->max_queue_pairs)
>> +        return -EINVAL;
>> +
>> +    if (!per_queue && virtio_has_feature(vi->vdev, 
>> VIRTIO_NET_F_NOTF_COAL)) {
>>           ec->rx_coalesce_usecs = vi->intr_coal_rx.max_usecs;
>>           ec->tx_coalesce_usecs = vi->intr_coal_tx.max_usecs;
>>           ec->tx_max_coalesced_frames = vi->intr_coal_tx.max_packets;
>>           ec->rx_max_coalesced_frames = vi->intr_coal_rx.max_packets;
>> +    } else if (per_queue && virtio_has_feature(vi->vdev, 
>> VIRTIO_NET_F_VQ_NOTF_COAL)) {
>> +        ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
>> +        ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
>> +        ec->tx_max_coalesced_frames = 
>> vi->sq[queue].intr_coal.max_packets;
>> +        ec->rx_max_coalesced_frames = 
>> vi->rq[queue].intr_coal.max_packets;
>>       } else {
>>           ec->rx_max_coalesced_frames = 1;
>> @@ -3158,7 +3241,21 @@ static int virtnet_get_coalesce(struct 
>> net_device *dev,
>>                   struct kernel_ethtool_coalesce *kernel_coal,
>>                   struct netlink_ext_ack *extack)
>>   {
>> -    return virtnet_get_coalesce_one(dev, ec);
>> +    return virtnet_get_coalesce_one(dev, ec, false, 0);
>> +}
>> +
>> +static int virtnet_set_per_queue_coalesce(struct net_device *dev,
>> +                      u32 queue,
>> +                      struct ethtool_coalesce *ec)
>> +{
>> +    return virtnet_set_coalesce_one(dev, ec, true, queue);
>> +}
>> +
>> +static int virtnet_get_per_queue_coalesce(struct net_device *dev,
>> +                      u32 queue,
>> +                      struct ethtool_coalesce *ec)
>> +{
>> +    return virtnet_get_coalesce_one(dev, ec, true, queue);
>>   }
>>   static void virtnet_init_settings(struct net_device *dev)
>> @@ -3291,6 +3388,8 @@ static const struct ethtool_ops 
>> virtnet_ethtool_ops = {
>>       .set_link_ksettings = virtnet_set_link_ksettings,
>>       .set_coalesce = virtnet_set_coalesce,
>>       .get_coalesce = virtnet_get_coalesce,
>> +    .set_per_queue_coalesce = virtnet_set_per_queue_coalesce,
>> +    .get_per_queue_coalesce = virtnet_get_per_queue_coalesce,
>>       .get_rxfh_key_size = virtnet_get_rxfh_key_size,
>>       .get_rxfh_indir_size = virtnet_get_rxfh_indir_size,
>>       .get_rxfh = virtnet_get_rxfh,
>> diff --git a/include/uapi/linux/virtio_net.h 
>> b/include/uapi/linux/virtio_net.h
>> index 12c1c9699935..cc65ef0f3c3e 100644
>> --- a/include/uapi/linux/virtio_net.h
>> +++ b/include/uapi/linux/virtio_net.h
>> @@ -56,6 +56,7 @@
>>   #define VIRTIO_NET_F_MQ    22    /* Device supports Receive Flow
>>                        * Steering */
>>   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23    /* Set MAC address */
>> +#define VIRTIO_NET_F_VQ_NOTF_COAL 52    /* Device supports virtqueue 
>> notification coalescing */
>>   #define VIRTIO_NET_F_NOTF_COAL    53    /* Device supports 
>> notifications coalescing */
>>   #define VIRTIO_NET_F_GUEST_USO4    54    /* Guest can handle USOv4 
>> in. */
>>   #define VIRTIO_NET_F_GUEST_USO6    55    /* Guest can handle USOv6 
>> in. */
>> @@ -391,5 +392,18 @@ struct virtio_net_ctrl_coal_rx {
>>   };
>>   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET        1
>> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET        2
>> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET        3
>> +
>> +struct virtio_net_ctrl_coal {
>> +    __le32 max_packets;
>> +    __le32 max_usecs;
>> +};
>> +
>> +struct  virtio_net_ctrl_coal_vq {
>> +    __le16 vqn;
>> +    __le16 reserved;
>> +    struct virtio_net_ctrl_coal coal;
>> +};
>>   #endif /* _UAPI_LINUX_VIRTIO_NET_H */
> 

