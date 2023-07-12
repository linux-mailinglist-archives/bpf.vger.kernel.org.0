Return-Path: <bpf+bounces-4848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D4D75037E
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 11:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45271C20EF7
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982451F95D;
	Wed, 12 Jul 2023 09:45:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A760100AA;
	Wed, 12 Jul 2023 09:45:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC99B0;
	Wed, 12 Jul 2023 02:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ep0b+hRvezH8IbqJkmDCh9Gi0e1p76fcW1y/XvrhBdP1s66G1GKsEApUS0XUbCo47ForfHxBYPY+EeVjNX8ivLYVri2a09TOuZV0t2oEWUN81Fe8Gx68nJm40R7hIndS8GsyTaHiHgWsjwUR+XjNn1DLeI17f2IDogTqV/LNSH1cvCcJdmHrEsPM0MWmA1GmRu2H4MI5lWouQn7IyOO9PmVSqU9MiezlYj5DzBj7pEeBBaQjK803SRSZYD7Rj/ECStLMPciyJwjFMZk+7k4dugfS9YsSwjNzCI07B8GDGbNX+1TmK8kqM2uG3IYxulV3+l4gXJCeuidqtPj1hBLvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxpsXSlol4mfVn70m+Ig0b7vMUm/wwBIjH4XdbIlpIc=;
 b=NR0N6cZF+hnECoblgobSXE1FDTyck/6CMSkQaR2WUiLzPh4ra+LaWcRAC/p0PteH9BFDscg54TjGksqxgrVnxptJAp10z+sqcf9Fni/HGzVQ0cQW4aduB345LzZES7/4B3TFcH2lllqhJ71X7YfpVgPITFXcHFqsUDR6TCDZ8ic+2+yxlkY9wi9nYyeeruDjH0CZtihTFRUwgWCXd6vPsQSPZewyVL0+PXY8f7uHxMuWgpZd5ZrC9Eb86zegbG+HI8VXVNkBj+5tssZBeBdADS5op0TwCYB3wk5qa2QJbFft/81duCXRSQmUj+DMVExfQrICT/+NuTYKhvMVn5vBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxpsXSlol4mfVn70m+Ig0b7vMUm/wwBIjH4XdbIlpIc=;
 b=RQL1qxP2Nw4g1R/J12OLkivp/Yi4vARli8OK5fVSA4DB17mjgfNxWHUSM72NB2CSc6kTL30g6vGDlK8W9BuRDjcvTjbsz9PYL6kBEkmwKOI4WYqn9zsroC/DK7TOZYbcyxGpAzkmffz1S3a3gqGXaOzPHoiCQ98+CICIrPDqRFXrv7CEHQZLHWC2HJIhl4rOear4VyAwRRhHnFgHelOXMKLrfaJuznUkyztRboS9NUmgK1SwL1hLfMXLXGn674ii/JnlAGtOYFtkpUcueYKIaoC0WKC/n/w8vkPef0okQKnVBFxT3fMohmOTzzPnoNE0IhozQeev7nc3/Esd0kgd8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16)
 by BN9PR12MB5290.namprd12.prod.outlook.com (2603:10b6:408:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 09:44:59 +0000
Received: from IA1PR12MB6019.namprd12.prod.outlook.com
 ([fe80::7185:fb6e:af4:4ecd]) by IA1PR12MB6019.namprd12.prod.outlook.com
 ([fe80::7185:fb6e:af4:4ecd%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:44:59 +0000
Message-ID: <aaa2419b-de1a-0231-ee06-2303596425b1@nvidia.com>
Date: Wed, 12 Jul 2023 17:44:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V1 3/4] virtio_net: support per queue interrupt
 coalesce command
Content-Language: en-US
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, jiri@nvidia.com,
 dtatulea@nvidia.com
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <20230710092005.5062-4-gavinl@nvidia.com>
 <1689154785.322522-2-xuanzhuo@linux.alibaba.com>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <1689154785.322522-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0181.apcprd04.prod.outlook.com
 (2603:1096:4:14::19) To IA1PR12MB6019.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6019:EE_|BN9PR12MB5290:EE_
X-MS-Office365-Filtering-Correlation-Id: bae9fed1-ce27-4fda-9bc9-08db82bca85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZB7NN0SC3VuM0RETO348ly4tGrASdiBBhfnaGYRUhzRK2eNfwYE4dV9n+PNyB6BPsCi/yKtYxm9ZYp2W/E8z2PrMDd5xREIt+MJSFI1jAxTwE2xYH1KB5S6vILcso2Hjyz47oZZ75CLBWW9mWkAZBh6irox+sq6cdm/+DwetbTgxIHLbbsIFlEHtaX72vCXTf1bhvwC58iEhGZ83UkTbw2TE2yaq9tTXaT6PjiK/MQdtq7QiJno/HuIQwke6B+XBkBRu/iPafc4/7AMFVVI2uLgbModfse1Zc3oMzcl+p+Bc3SZfFrqRBDkO+70uwO7RvJx6ox6bK89BNDqLNVapZRmzEFLjIZ0mBH28MkMPNm5nE2rjVcJLjBOUhib0qKmLvQML6GInJZU/9kA9Q8jhyPwlnqOW7ijZgeIdUj+Ke+0o7f4sXCtsBDbouaE0g9a6lFNVKr4Gt/peSMHoyoF2s4AROSeF/ecCXw1rPw54ZE0MVYMk8oSDM8g1X5bIjwdXMTRdHk/T1nvZzEZnZ9WyEuLRGFkxB9fObucvANaJNOyThatsjYNB89IAYAHURPR+xtGli2mOpGM6xf3RMT9zNQYt49N8e/rF/Qd8Yox2scLQ8A3LdC0Dv5/5eZGcRWVxETX2X1dRI+ARf9A59g+R1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6019.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(6916009)(4326008)(66556008)(66946007)(66476007)(38100700002)(31696002)(107886003)(86362001)(186003)(53546011)(6506007)(2616005)(26005)(83380400001)(478600001)(36756003)(6512007)(6666004)(6486002)(41300700001)(5660300002)(31686004)(8676002)(8936002)(316002)(2906002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2pnOHpSNitiRXR5ZlJHK1I2ajhYMHRYSDJzU25CZGJqWGdsQWZGdTlhME9y?=
 =?utf-8?B?ZWsvR3F1blk1d3M2V3d2OEFsV25VR2FySVZYKytpMXNxMGdmNTZrT0NIUmVx?=
 =?utf-8?B?NFdSdTI4TkZoOW1DUGNudGJPdjY3Mmh5aVpFQXB1NzVzS05Cc1JCL3FJSk5s?=
 =?utf-8?B?WWszRnNZKzJrcFBKY2tTcXNkWDBrS1MvZ0ttcERTUHRVRHlIcmEwdncrSzFL?=
 =?utf-8?B?bHRJcHB4VW5kdm8zbG1MaDZoOTkvaXFTOUhHaXZOUStFY0RqQ0doMGVsYjJt?=
 =?utf-8?B?TUFDZDBuWk5WVkNmNjBtT1RXOFd4TzFleW5kdXFtVlNSZFg0T3hLUHhQOUV1?=
 =?utf-8?B?cFF1N3Fsb3ppZEZEZWhFZm9pQkVjUktMaGE0QmMwNDZwNjBodkUyaTNSNmFK?=
 =?utf-8?B?TUpwNkhyeWZkZ3doUTBlbnhMeGtUZ3BaWlBXWDdSTVVsZTRlWm1RZktFcjN2?=
 =?utf-8?B?OERPaFlNTFpFVEc2bEZGMFROMVJXVDVoMVBEM25TTEZhYXZyd2x1K0JyQTI5?=
 =?utf-8?B?ZXBDV0FkVVFVeVNWRit6RVZTVFBCbGtJYnNPT2NYUlRjQTlHSndDcjI1dDhl?=
 =?utf-8?B?bmY4azk2QklxdkpQTHkyclQzWFNjTDgxcDRrWHo0MVk1QzhMZjdJMXlKVkR1?=
 =?utf-8?B?VXVtQkVOWng0TWd6bk9KQlg2dXFXTmZ6K0E4U2JJYnhZNEhlUVZqSUpGRUlB?=
 =?utf-8?B?TndIbElaaVU0TkluU01iQ1BHaEpySkZGL2hYb3ZMdnYwdTZpcjNBL1pEL1ZY?=
 =?utf-8?B?M1ZzQTJyb0h5MXNSQUppZXhpN1hRVktpVjZpb2IzaUJXTFVxdWVIM2wrTHZB?=
 =?utf-8?B?VkxuQklyS21JV2VYUnlwYlNLYkpEZDgvTkVyczdQcFNMdUdubTQ2YW1Xd3Mv?=
 =?utf-8?B?TDVUVWU1SVA0aVB3a1N5cHNtMzZLUzN5VGJBdFlLWlNLMkVNbmRZaUp6NXdG?=
 =?utf-8?B?MXpIT0cyTlhkbDdLeGg5L0ZJU0lQL0huN3NwK1JVS3VCNUt0UStoQnFWNXRE?=
 =?utf-8?B?Q1BLZHY0bVVBVGNYRTArVTYyQmlWcTNUZGlBSHFVL003VGx2WDFpSStMa2Qz?=
 =?utf-8?B?ZFUwMTBYTzdZdTUwbmhadndTcy83U3Nhb3l4OWV6VUFHUlR0NEdOc29CNFE0?=
 =?utf-8?B?ZVB0SWpONGpGRFNJSFcyenRmUmNwd1NYSjhLcFpPcVNpZGNyMlhESEF2WjV2?=
 =?utf-8?B?d2NtRlBIQWptTkFaYkxzZlpMcnBKMmJWOWtVZm5JakErVnlHbFcwaS8xOHRt?=
 =?utf-8?B?TXNMbTh1by9helVMWi9yYjBqelR1MS9CeXVITzhCUkFOMmpTdTdhTVVXL0dT?=
 =?utf-8?B?WnVLQXlVMDZBeENMaUZtN29NT2Raa1ZrWTZFNVppQStYckp6QzMwbU1saGxT?=
 =?utf-8?B?TnVIQzhRS0lmSEQ4aksvNXlLYi9vaEthSGtMaUZGSGIyMDVTUlo4aXF3ODBj?=
 =?utf-8?B?cXZoRXlIUGErL1J1bTdhblJLZlZwNnRFcnMxV3lMbWlKd3hUTGRoc0xmbm1x?=
 =?utf-8?B?NGZGek5KU2hDZ3I4THhvdnZpeDBkS1FPR2xJZGx0bTJuWXFqNlk5L0lsdGhP?=
 =?utf-8?B?ZmZqZGlHcEtEeVBhTy9VWkJ4SjRqdFN4Tm8rc29GVkkzak5lcSs0OXRiYS9j?=
 =?utf-8?B?NUJuYm1RYlRGS0V5RmtJaWY0NUhWbWZzY0tRUmpYWHRiNzk2TEdsTEZsRVRL?=
 =?utf-8?B?ZFNtOWp2bUYvR1ZXUlFnU1JPZ2F6SzB5a0wzL3l1SFVtSEpJSitqbVM1Z2k3?=
 =?utf-8?B?SFdPR3BEZzVqNktXYy84Nm5vOTNJSXFlaXp3QU9CTzBOQ0NlN2NyT1IyT3VP?=
 =?utf-8?B?OHMwOHlSZHNGREhHNHlvemxOUndKRzhwemNHT3VtRkZaOWdYZHg5SVdrQ3Js?=
 =?utf-8?B?NjlpdGZNd292Rk10S1E0UVNhQTBCT0tqVzRhMEZ6VUNGOWxaZ3NUdWVVckg4?=
 =?utf-8?B?L2R6bDk4N3FXMFRHeGZNNWtjZVl1Q2VyUnRIUHZjcDk0UWhsbzRhV0FXNzAw?=
 =?utf-8?B?MkdtbVZFbFV0K3RFUkNaOE1UMk50QjNONEtwVFJKOVc4Rk01d0g2bHFyREE0?=
 =?utf-8?B?VkhxQjJOQW5BOEM3WEpxeHUwTWJmRE1LOVErTmdWQnVhazFyQTBDVzdvak1N?=
 =?utf-8?Q?gS48M2moJ+e0FT4uswBK6vDPt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae9fed1-ce27-4fda-9bc9-08db82bca85b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6019.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:44:59.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84jpTFG6BsNnXXwTK3gDq9rYpCEypIB/NPhOWOtVV2xsm6HYntT4Bt3P52iQfC9B1+z1M5VRiUmwIJn9ETpp6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5290
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 7/12/2023 5:39 PM, Xuan Zhuo wrote:
> On Mon, 10 Jul 2023 12:20:04 +0300, Gavin Li <gavinl@nvidia.com> wrote:
>> Add interrupt_coalesce config in send_queue and receive_queue to cache user
>> config.
>>
>> Send per virtqueue interrupt moderation config to underline device in order
>> to have more efficient interrupt moderation and cpu utilization of guest
>> VM.
>>
>> Signed-off-by: Gavin Li <gavinl@nvidia.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>   drivers/net/virtio_net.c        | 117 ++++++++++++++++++++++++++++----
>>   include/uapi/linux/virtio_net.h |  14 ++++
>>   2 files changed, 119 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 802ed21453f5..333a38e1941f 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -144,6 +144,8 @@ struct send_queue {
>>
>>   	struct virtnet_sq_stats stats;
>>
>> +	struct virtnet_interrupt_coalesce intr_coal;
>> +
>>   	struct napi_struct napi;
>>
>>   	/* Record whether sq is in reset state. */
>> @@ -161,6 +163,8 @@ struct receive_queue {
>>
>>   	struct virtnet_rq_stats stats;
>>
>> +	struct virtnet_interrupt_coalesce intr_coal;
>> +
>>   	/* Chain pages by the private ptr. */
>>   	struct page *pages;
>>
>> @@ -3078,6 +3082,56 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
>>   	return 0;
>>   }
>>
>> +static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
>> +					 u16 vqn, u32 max_usecs, u32 max_packets)
>> +{
>> +	struct virtio_net_ctrl_coal_vq coal_vq = {};
> We should alloc this on the heap.
>
> Thanks.
ACK
>
>
>> +	struct scatterlist sgs;
>> +
>> +	coal_vq.vqn = cpu_to_le16(vqn);
>> +	coal_vq.coal.max_usecs = cpu_to_le32(max_usecs);
>> +	coal_vq.coal.max_packets = cpu_to_le32(max_packets);
>> +	sg_init_one(&sgs, &coal_vq, sizeof(coal_vq));
>> +
>> +	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>> +				  VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
>> +				  &sgs))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
>> +					  struct ethtool_coalesce *ec,
>> +					  u16 queue)
>> +{
>> +	int err;
>> +
>> +	if (ec->rx_coalesce_usecs || ec->rx_max_coalesced_frames) {
>> +		err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
>> +						    ec->rx_coalesce_usecs,
>> +						    ec->rx_max_coalesced_frames);
>> +		if (err)
>> +			return err;
>> +		/* Save parameters */
>> +		vi->rq[queue].intr_coal.max_usecs = ec->rx_coalesce_usecs;
>> +		vi->rq[queue].intr_coal.max_packets = ec->rx_max_coalesced_frames;
>> +	}
>> +
>> +	if (ec->tx_coalesce_usecs || ec->tx_max_coalesced_frames) {
>> +		err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
>> +						    ec->tx_coalesce_usecs,
>> +						    ec->tx_max_coalesced_frames);
>> +		if (err)
>> +			return err;
>> +		/* Save parameters */
>> +		vi->sq[queue].intr_coal.max_usecs = ec->tx_coalesce_usecs;
>> +		vi->sq[queue].intr_coal.max_packets = ec->tx_max_coalesced_frames;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>>   {
>>   	/* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_COAL
>> @@ -3094,23 +3148,36 @@ static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>>   }
>>
>>   static int virtnet_set_coalesce_one(struct net_device *dev,
>> -				    struct ethtool_coalesce *ec)
>> +				    struct ethtool_coalesce *ec,
>> +				    bool per_queue,
>> +				    u32 queue)
>>   {
>>   	struct virtnet_info *vi = netdev_priv(dev);
>> -	int ret, i, napi_weight;
>> +	int queue_count = per_queue ? 1 : vi->max_queue_pairs;
>> +	int queue_number = per_queue ? queue : 0;
>>   	bool update_napi = false;
>> +	int ret, i, napi_weight;
>> +
>> +	if (queue >= vi->max_queue_pairs)
>> +		return -EINVAL;
>>
>>   	/* Can't change NAPI weight if the link is up */
>>   	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
>> -	if (napi_weight ^ vi->sq[0].napi.weight) {
>> -		if (dev->flags & IFF_UP)
>> -			return -EBUSY;
>> -		else
>> +	for (i = queue_number; i < queue_count; i++) {
>> +		if (napi_weight ^ vi->sq[i].napi.weight) {
>> +			if (dev->flags & IFF_UP)
>> +				return -EBUSY;
>> +
>>   			update_napi = true;
>> +			queue_number = i;
>> +			break;
>> +		}
>>   	}
>>
>> -	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
>> +	if (!per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
>>   		ret = virtnet_send_notf_coal_cmds(vi, ec);
>> +	else if (per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
>> +		ret = virtnet_send_notf_coal_vq_cmds(vi, ec, queue);
>>   	else
>>   		ret = virtnet_coal_params_supported(ec);
>>
>> @@ -3118,7 +3185,7 @@ static int virtnet_set_coalesce_one(struct net_device *dev,
>>   		return ret;
>>
>>   	if (update_napi) {
>> -		for (i = 0; i < vi->max_queue_pairs; i++)
>> +		for (i = queue_number; i < queue_count; i++)
>>   			vi->sq[i].napi.weight = napi_weight;
>>   	}
>>
>> @@ -3130,19 +3197,29 @@ static int virtnet_set_coalesce(struct net_device *dev,
>>   				struct kernel_ethtool_coalesce *kernel_coal,
>>   				struct netlink_ext_ack *extack)
>>   {
>> -	return virtnet_set_coalesce_one(dev, ec);
>> +	return virtnet_set_coalesce_one(dev, ec, false, 0);
>>   }
>>
>>   static int virtnet_get_coalesce_one(struct net_device *dev,
>> -				    struct ethtool_coalesce *ec)
>> +				    struct ethtool_coalesce *ec,
>> +				    bool per_queue,
>> +				    u32 queue)
>>   {
>>   	struct virtnet_info *vi = netdev_priv(dev);
>>
>> -	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
>> +	if (queue >= vi->max_queue_pairs)
>> +		return -EINVAL;
>> +
>> +	if (!per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
>>   		ec->rx_coalesce_usecs = vi->intr_coal_rx.max_usecs;
>>   		ec->tx_coalesce_usecs = vi->intr_coal_tx.max_usecs;
>>   		ec->tx_max_coalesced_frames = vi->intr_coal_tx.max_packets;
>>   		ec->rx_max_coalesced_frames = vi->intr_coal_rx.max_packets;
>> +	} else if (per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
>> +		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
>> +		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
>> +		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
>> +		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
>>   	} else {
>>   		ec->rx_max_coalesced_frames = 1;
>>
>> @@ -3158,7 +3235,21 @@ static int virtnet_get_coalesce(struct net_device *dev,
>>   				struct kernel_ethtool_coalesce *kernel_coal,
>>   				struct netlink_ext_ack *extack)
>>   {
>> -	return virtnet_get_coalesce_one(dev, ec);
>> +	return virtnet_get_coalesce_one(dev, ec, false, 0);
>> +}
>> +
>> +static int virtnet_set_per_queue_coalesce(struct net_device *dev,
>> +					  u32 queue,
>> +					  struct ethtool_coalesce *ec)
>> +{
>> +	return virtnet_set_coalesce_one(dev, ec, true, queue);
>> +}
>> +
>> +static int virtnet_get_per_queue_coalesce(struct net_device *dev,
>> +					  u32 queue,
>> +					  struct ethtool_coalesce *ec)
>> +{
>> +	return virtnet_get_coalesce_one(dev, ec, true, queue);
>>   }
>>
>>   static void virtnet_init_settings(struct net_device *dev)
>> @@ -3291,6 +3382,8 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>>   	.set_link_ksettings = virtnet_set_link_ksettings,
>>   	.set_coalesce = virtnet_set_coalesce,
>>   	.get_coalesce = virtnet_get_coalesce,
>> +	.set_per_queue_coalesce = virtnet_set_per_queue_coalesce,
>> +	.get_per_queue_coalesce = virtnet_get_per_queue_coalesce,
>>   	.get_rxfh_key_size = virtnet_get_rxfh_key_size,
>>   	.get_rxfh_indir_size = virtnet_get_rxfh_indir_size,
>>   	.get_rxfh = virtnet_get_rxfh,
>> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
>> index 12c1c9699935..cc65ef0f3c3e 100644
>> --- a/include/uapi/linux/virtio_net.h
>> +++ b/include/uapi/linux/virtio_net.h
>> @@ -56,6 +56,7 @@
>>   #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>>   					 * Steering */
>>   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>> +#define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
>>   #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
>>   #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
>>   #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
>> @@ -391,5 +392,18 @@ struct virtio_net_ctrl_coal_rx {
>>   };
>>
>>   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET		1
>> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET		2
>> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET		3
>> +
>> +struct virtio_net_ctrl_coal {
>> +	__le32 max_packets;
>> +	__le32 max_usecs;
>> +};
>> +
>> +struct  virtio_net_ctrl_coal_vq {
>> +	__le16 vqn;
>> +	__le16 reserved;
>> +	struct virtio_net_ctrl_coal coal;
>> +};
>>
>>   #endif /* _UAPI_LINUX_VIRTIO_NET_H */
>> --
>> 2.39.1
>>

