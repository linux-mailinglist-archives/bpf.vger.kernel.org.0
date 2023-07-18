Return-Path: <bpf+bounces-5156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B96A757498
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 08:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C17281284
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 06:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EC6442E;
	Tue, 18 Jul 2023 06:46:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0382B10EA;
	Tue, 18 Jul 2023 06:46:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024AD12D;
	Mon, 17 Jul 2023 23:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0Rsnaivfcvk6ZVO0CtctoYNb4fFhse1ZPe8yoKwA5X71Fy96GHiY0wbOQlAOTjE1C5vN5KchnrtVsMrjLcCPiObC6nQFYOCgTWG/fMnUUtZzg3b41TJEt+TDmlEvAMoMAPhj3fCnz4kBE4mg7DNMBU6V6S/GI/M2/yUKbb9gIVEr+DqSGpUUvmU6guHAxX4gSLwNkHGSOwOn+GCrlT48kjsmiuxfhDHlzwRXny/B0nayw1i2wRa+hkO1RB95aOARA//UHL7r2R09ObAVTKIBxrJN/htf24oC0CdtBjvdTubpJl6Xjt47AFGO9KkCQGbXBORxbRGm6RyXjvWBuK0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf6Pp24+gDrqTvF72NZxFowUb4S8TX0qVgd304zy+iY=;
 b=QuMnR3hKM4NTT6RCqnqc8lUZ0MnvajfldkmwJQv1WuA0M6TU2UtiBHJJYufENR3ymmDV0ARy+RNaXSghPuzBpG8UXI+irbcMCGBQ6S4lhNB0JYmdH+xazqSp9YVnYE0XzOH8cWB5Hc45F4Ch2C4iyNsynQqKx4MjzKEyeKJvLc7O6KzIdY6Ew/NqfYs5p0OZt1ubKm83k/PZgml1S5Y00gM/nkXzzrDmQZsDXvIV7MF/aAZG/Q+FQVPa6GFY1/NbkTNG6SY3zYabdy5y4zWLTRB0t5lVp0EDFCuC4PmKP+sulmd8e1Lz1pPCD7rFHiemVQuDVlo5MIZ6tBxUNWJf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf6Pp24+gDrqTvF72NZxFowUb4S8TX0qVgd304zy+iY=;
 b=lrfDZaKtEhwuaBzYraoYYhEfEdlrKE7G9bxGWj5NwG/luKBc1PhPOPA4l4QV8R4U8WqIjYp2KkXxlWQSQpfKJ72XTHRreVFXsN6fTrphQruRCrdEJiNRXUhno6NAEbrdFnRRCyFhlufPjZC3/HJWQLlwvXiZRiNpMNbEhnyIdrAVPSPabmxpNw+5j1CCuGKCdmH2se3gcx3/0rT2DaabjWsD6KKEym9dS8EbpF247G7ne1n6cnR2Z/BCVNLNv4+ARn2mOq+bhzsHqfyddlDGD9Y+i4YZYLUEbeB5Z4V4iqk7yxbmlv+l+2QG9PUH3J5XG70/pBaC556WQkCLgY2J+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 06:46:07 +0000
Received: from IA1PR12MB6019.namprd12.prod.outlook.com
 ([fe80::7185:fb6e:af4:4ecd]) by IA1PR12MB6019.namprd12.prod.outlook.com
 ([fe80::7185:fb6e:af4:4ecd%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 06:46:07 +0000
Message-ID: <a2cd512a-245e-4c8a-633d-126c6fc135ba@nvidia.com>
Date: Tue, 18 Jul 2023 14:45:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V2 3/4] virtio_net: support per queue interrupt
 coalesce command
Content-Language: en-US
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: gavi@nvidia.com, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com
References: <20230717143037.21858-1-gavinl@nvidia.com>
 <20230717143037.21858-4-gavinl@nvidia.com>
 <f88ad438-fb63-beeb-b999-94fb3a75d93d@linux.alibaba.com>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <f88ad438-fb63-beeb-b999-94fb3a75d93d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To IA1PR12MB6019.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6019:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 26093491-6511-4407-dfb7-08db875aa9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7/pVOc3A7dHXunDtpE5pfC1OjqemYEr4BxsoNqVT4fz1y9DQTE1HDpyGyf1v4P5KRYceHa82FKMRsmmZJauV+LKHYrCqZ0SjzHUkunZ2dahgZoFMol6woaEaWKwsGd5SC5xTHxqvkNa7MudZsNxC/Nh1B7dnErYb6LicqEzeQczT90h7xKZJdUwGGTS9yWNNP8Yr1j1pUSeNM9jMN8ujZNrDpOBRfsU4kObb/rRTM8CJk802/5RXCp36/S/BU652hz1BQKFTqjQFn0NSdWubTEG4YWJP5SSr8mO7dKY7TiLPoXeKCyHjxQZqd2A9zMkWZ8ZG8Z5GtttaxDmudIkqNoah5IFvVkUg4sNwgAjmu3MpxF9zjPfxEOZoSQmkX+AHMCYXQXSPVmqYeXeriPc09yBVAbod59caH/wdRMmiP53rm9K0C5KeaYQV1X+lgxEaKofa+XuLOpA+Fs7G3dGpcOqYjIWzwQbO3Py+/uRz4Ceg+c+HJ0zKJ5B5t2of4ab8TODsQh24LQPZHWrgr+XNS36+rw/rWn8/B3t21aRGwQuUohE0cgb5X0EmVL4YHzuiq1Mk33hgI5SIdQfJtffYhdKLKVv2X+BRthaE/yrs+KgZb0f4aDkNoUZST4kSyeZfkCloQc2CHr63Z1gU3+V94g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6019.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199021)(8676002)(41300700001)(7416002)(66476007)(6916009)(66946007)(2906002)(66556008)(8936002)(6486002)(6666004)(86362001)(31686004)(4326008)(316002)(2616005)(36756003)(5660300002)(6512007)(38100700002)(83380400001)(186003)(26005)(31696002)(6506007)(107886003)(53546011)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmNEY3g0Z1I3Tk9yUzNKWDlKQWhXekVFS2lDY2M5LzdxRlF6cXd2aFZEVkpL?=
 =?utf-8?B?emFrQjNZNmNDOGZCUXlVUTdNTEJqaU5ldkFEUFJrYkVSenpWZ1o5MktLVE1F?=
 =?utf-8?B?ZFZsWXhwakorbTJ4NDNXc2RHUXp1K2Z2eklUd2dQQzJobGpCQjIxN0RGeVg5?=
 =?utf-8?B?STdBM08za1R0UDZmdzU1UmJNNXl2Ykg4Wjl0cEtES3M3QStpbUxVNEMzOE11?=
 =?utf-8?B?ZHJXUnZhYk94M1QwVjYrbVMvRXcwRXQwZzF6aGFEZFN5YWdlZ1JBNUthRG9l?=
 =?utf-8?B?dHI3bGRpUldkYm9FTmRQVEtVTk50bGRVaFE3SVpBZjYrVVJ0OTdmUUhqQ3VP?=
 =?utf-8?B?eklsdGh0bE9GZEk0WUxaQ3k3STJwMkJkUzBpeEp4eVVtcTRweDlycWxXalNv?=
 =?utf-8?B?QlA4YXRob2JwcmhwQnVsSnA3Tjh2eitFVnpVcExrSi9IdXUzNFNkeThXUEIr?=
 =?utf-8?B?VGxUVXNKSW9qdnc2L1JNSERtbVNBd2RUb2lSTFVjMVlSZkxFNXlUWDdnd0RC?=
 =?utf-8?B?eU5oT21VemJjb1QwVlFtb0dwR2NWcjF3T0kxV3BuV1lQVDRjZ3lueTNLdEdk?=
 =?utf-8?B?ZCtiUEJMQVErWnh4TVkwUTVPK2U2ajBVR2RTSm9xbGorV2owRXdSUDFhb2x1?=
 =?utf-8?B?RXN1SEJBS3lkU3M4Tk5rbGFlTHQyYW83cjhJNldjT1VBME1oZVpEL21OcWJz?=
 =?utf-8?B?YndQVGlLdXM1N2J6N1dPRzl1VGlIRXhmWlRWdkpEWndvanB2Rk1odnZuSElW?=
 =?utf-8?B?V2VVVlZQZWFHSzF6VU84UmpJcHJNQ3R4eGpqTzFkcS9BeDJhRjNEWFNkcU4r?=
 =?utf-8?B?SFJiKzBmdlVrQXpYSXBFYXA1c0xpQzFydmFCT2dIZHM3YVVIeUFDVDg0dEFT?=
 =?utf-8?B?ZW9malYrcHdZT0w5TG9lWHpHVzcrK0t1MUM1TzgvaDVxai9URFZuTW1HTXVH?=
 =?utf-8?B?TFdzV01sWE9jazhTZGRGQW1BYnVOWHQzT2tCQmpzcWU1MnNiOFBjc0RzWUwx?=
 =?utf-8?B?bHc0MDZKMkRrOEhEdEd4STFlN2t0b2JuZ3BQTWZvY2dkWUtIVTNuaUJvZkhX?=
 =?utf-8?B?S29lYytaTDR0WExvd045M2N2T3RzTXhnQ2QvcHllWlhYQm9NVnZIbVhQTmJG?=
 =?utf-8?B?MEZiVUFOL2R0MEhScGV3NVFDNGFUVHRXbUlSbStYdVFzRmdrclJmckxwZ0VC?=
 =?utf-8?B?aVhlRUloNjVnZjBFbmlMK0lwQXFWaVJRNDBnSFoyM3d0TThKYXhnUXZkZWQ4?=
 =?utf-8?B?ZDd4VU1WbWo0ZENnK08yUnZTYnl0ZHZPc2wrRnExZ0swbUd4bUFCd09KVjcy?=
 =?utf-8?B?YTZ0ZW5sOTFYU1NkTGtTQzd1cUxiYjc0Zmc0ajFLaDI5V3FlejJ6MVFNQ1ZL?=
 =?utf-8?B?cTRDK3RmeEhFT0lYR2lFN3VXZ2FSYmJSNTBUYVVMMGVzVk9scU1UTGRvYk9W?=
 =?utf-8?B?VDRQVjZNRlJzY2JrWFVHdTJDeVBIWHpIVmErTjh0Uk00TWY2ZmU3azYxczRt?=
 =?utf-8?B?OExOWWdhc0l0TjlJSVVTSnZRdDlDMjRQVDF2T01LR3NmK2R6U1Rab3VVWjg1?=
 =?utf-8?B?cGhScU1Ed1RLOVNKeVJ4L2FQKzN5Uy9YNDd1Q3pwR1VIZitERGF0cE04cWZT?=
 =?utf-8?B?cE05MHJjZWdQSmJ1Y0NLVTVTbzVPWEt0eCtxakpBNDdxZFVpMlp4ZmR0NDlB?=
 =?utf-8?B?YzdnYkQ4ajkxNHUzNzVSUm82VkNqWU56dVdFK0UxZDVFWnNxaG1iQ2t0R2U3?=
 =?utf-8?B?emcrSXZRbkhVckRMSzU1dzJEa2FrWGtkQWNGTDUzSWM3cmRxNjY3VXZLaHdE?=
 =?utf-8?B?KyttYmc4bDBDcSszU1AyY2NpT1lNMEpLQStYTlFMeEtJd2MzUFVJYnBEMWFF?=
 =?utf-8?B?MVBTNUc5NHNlbUdOUVBQSjh2Mmg4SktFWDdkNVR0WUx3eStYSXFUWGVXeDBk?=
 =?utf-8?B?ZkR1VlF4SXVZWTJBQnJ2M014cFdaWGprNFkxaFJaRk5DMHU5eDBvUUI4SGs0?=
 =?utf-8?B?ckJINWZNS0dSSDJ3bFJPakg1c3R0dUdQeEVqeDNJN3RUMkJSWmoxS3dYWFA1?=
 =?utf-8?B?cVRZNVJ4b2JxSXpGUFFXTkNZbUZUeElQNnByTWdOajlndFpteVp1akxHVVJD?=
 =?utf-8?Q?k59A2jCG6OVL7Efpib702hG2d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26093491-6511-4407-dfb7-08db875aa9f9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6019.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 06:46:07.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd5sA7jbRJY7SsPb4WSJpe7EUKP2qudkfnklEgckrWSwOVDrcbzeBDjUO0VEUZy+mPtlkHuyNyBJZFPfMg3ZlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/18/2023 11:37 AM, Heng Qi wrote:
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
> 
> When \field{max_virtqueue_pairs} is the maximum value, and the user does 
> not carry the queue_mask for 'ethtool -Q',
> we will send same command for all vqs, and the device will receive a 
> large number of the same VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET commands at 
> this time.
> Do we want to alleviate this situation?
> 
> Thanks.
> 

May it be better to handle this senario in ethtool user space and call 
set_coalesce instead of set_per_queue_coalesce? I'm not sure.
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

