Return-Path: <bpf+bounces-5101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE97567BF
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B812811D4
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 15:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98A2253DE;
	Mon, 17 Jul 2023 15:23:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988FEAD26;
	Mon, 17 Jul 2023 15:23:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::61a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1828810D;
	Mon, 17 Jul 2023 08:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwoKfsuH/8K70uH+X4hP6N8dNglP1XsWxJtow53PZvtF7jbZVoNOMA7JN7cVcAaZNG+AwJdikW8WqrN+HR47nAkekhtd74W1uoKIB46n9aay6N/2EMb/5JHUXbgBK81S2gte2POG7Fcn+t/FkIucTIhg/25izZB6GxPcJH1rEaRapqZtPibbOHR7DR+GlNUQH00i+vXXEaSmsO3S7qVYijrpy/YKsMNWmeqBTUfeFkIEZ1SlfmNABCcPD6VfsbdfmWmBYgAcPIzAZYSwBRpWWP+uRDxXaoWI7kwEUYiKQfnq4uZRl9OzHcfPp0Ea+cdOtoFjSfU2WVv+uBDf5R1XCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YffSdHPPtHX6fJft/wRe7+lnMsAexH2qhAj2RNtGaIM=;
 b=ZwlCUFw1daJmX70nhE4USabb5YiLxQCJBlzR9jSPJs9vw/sjk9VykYbotkudnplvuBcSwQAd65cCODXDTP4dmt2J/tA3oaL0NgsrY8giXttzs0FntFmMNJlPGSOwQuj0TlGvyvaV6tBlqfAakmbjz4wSQE/HxQN0O7P/0KwGe+WYDW/EWnuSuVXNHL/zykXLv/w3yfA11K7eaTlBLCVAhGAMnC3jwG74e71jSAdAZxComi9zgACVT1fqSha7yC6CekEPw6KSIpDeDZjtzkXtCBrztfFx3bMbe3eFDcTTjOkpRwWBbBqiZobkjqZWkcZwd3R76N+9uSC3AokBcDrIIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YffSdHPPtHX6fJft/wRe7+lnMsAexH2qhAj2RNtGaIM=;
 b=NI7SVulEyjTHCdhRMfT+GolEoixfK2bFZR1X79DjSbCpJwA2jvXJQz7VkL6YVs1WmwYgt5HkJbURXqrNkbboZSV14/V/MXDg5GMGq/7EKrdktYBNebUNCJ0U+7eK8hnK9uOyFig7RILLvbUOaU/S5sKOwjFJSCPckQ48J3yxQfLgrY8GRuCbgwM+UINkMCc2fi4/3M452H1YUwXmyno2bBk60GXfpI0rkn/LUWuuf4kqg9T8w7sRvHg+X3bjI2fT+zOKY/26fJCjgaKrwMR/S6UD+WsfIgzO/lsxU3HqKNCeafRBX+RL0h32NqpGAD31kDQx5+SDX/8lKLP4kc6ebg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Mon, 17 Jul
 2023 15:22:33 +0000
Received: from IA1PR12MB6019.namprd12.prod.outlook.com
 ([fe80::7185:fb6e:af4:4ecd]) by IA1PR12MB6019.namprd12.prod.outlook.com
 ([fe80::7185:fb6e:af4:4ecd%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:22:32 +0000
Message-ID: <7815848e-e524-dcbe-448b-d464353435f8@nvidia.com>
Date: Mon, 17 Jul 2023 23:22:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V2 3/4] virtio_net: support per queue interrupt
 coalesce command
From: Gavin Li <gavinl@nvidia.com>
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com
Cc: gavi@nvidia.com, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20230717143037.21858-1-gavinl@nvidia.com>
 <20230717143037.21858-4-gavinl@nvidia.com>
Content-Language: en-US
In-Reply-To: <20230717143037.21858-4-gavinl@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) To IA1PR12MB6019.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6019:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 9206df65-f219-452d-30c5-08db86d9a40a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U9ysDutT6rskFDkhv2uYbpznXOVfo1ltCuzWVbjMyyEkh4GIYKuSt080/MNPIwbV70L0pF6ArsHfSt9BeSF7/aHnSG3Dz0MBlIGHXAFlXBVPK482Zs2iT2M3m4ZluExCcCRdM+KcPU4AByVjmffFLv628ce1I4i7o8gc3GE1FOzQS7mV7KJfBAtrk+G/sC8ezt3F4MBtpKCAKVv/ENvHYrJ6gugGZbYK4GCbOceN/mc6W3oj5ICyivu3Qc7MUy4dOrKhTqyI1FjHnb8RrFDlHPXzBLNot8RqZkQ2lZeNmcDV0CWdPq0RrZu8q//2YHhZq69gqKsjDy7rt7dXtVRfCMErZY0J08292lQeKU/Mz2wO+ZFSVqeTRHF3s1wgCgP3uChnJUUWS6fxfLV5zWyRdiwfGnLHTMUa6e9qwM8ArY2Z9wt3JNE5fp9DygsPqUNrYXBeuPB0rx5E+1VbewTCj0M0MOUX15w2bWXe1/GFE/14uqFqqZicfMSAvcp6aHf4RouoPUq2DedtYGVfFhujLcMDy0dns8Vv+TKVpPkBbkNvGG8ZcrNzXYdlgjV7neYQUiri+Eum9qWI83YNcKSY8SIgj8iNNg3GaVeHelnl53+r1Pgj7DvVtCX0uudyRFbzYLwFvFIYPHH0QwZaY5x7Do8SUWwLl3vLe5CpyRhvswA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6019.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(921005)(36756003)(31696002)(83380400001)(38100700002)(86362001)(7416002)(8936002)(8676002)(5660300002)(2616005)(6666004)(6486002)(6512007)(6636002)(66946007)(316002)(4326008)(66476007)(66556008)(478600001)(41300700001)(26005)(186003)(31686004)(53546011)(2906002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnM1MlJJZk41Y1BiQUVzdlhaU01PQms1TktHTlhPOU90REtuVUtkZXEzYTFH?=
 =?utf-8?B?Qy9DWGtWN0Rxd3pLYVRVcGJVbHZCUWJnUGFKMm9LaDhPTVdhbEdVa1NZVENw?=
 =?utf-8?B?TnZZV3dqL2xObkIzMDkwNVQ1bjF6Sk44QUU0MEcrL2owS1dSM3AyVkpjcVdz?=
 =?utf-8?B?bUxRQUtyZUp1SUxaaXpQUS92WWV1cW4rblVIOGx5QTlDZ1dUbDhWdXRrMHpp?=
 =?utf-8?B?bHRQQ2VUWXpGSGJSdVBnVVdTcG1uTkdxUlBTUUptQWFrdHkySGMrMDBxSmNj?=
 =?utf-8?B?SEF4OXV6ZitsTjd0TnVEYWFNK2hyWWVGNnNHWUpwQnQySEdWN1dsTEliaThJ?=
 =?utf-8?B?aHpoNUtGTWo2RGw4bDEyUEErQkpuZWcxUm5MaXRWb2pIQy85czArZE5GTUFD?=
 =?utf-8?B?RjFBL2cwcmY1Skluc3dSTFQ0ZkM0cEhwQ1V1em8wWWVxY0RXY1NQYndNZFhQ?=
 =?utf-8?B?N2dQcXkwNjNjRG5YY0ZQcGszYkN6YlhycjA1bklNclkrYnJrU1puRkpwdlA5?=
 =?utf-8?B?Wk9QcVRjYVd0alMwc1dFcGNrSktkVkNxSXdjeDlMVGUzR0FPeXVRSndXRzUr?=
 =?utf-8?B?cWV5VmhreGhjM3RVbCtpOG1oUnJLeDMxYU5CbGVaTTBJdWhRbkJtZURBc2ZG?=
 =?utf-8?B?SkVkazJLa2wxR2RwVFNpREFLbStoT2dQb21XU0lXNjlyVzgxUUx5VHRwRkNs?=
 =?utf-8?B?WUhWbUxsREk4Z1QzSzMwU1dXMnlWL0o0Z0ZjUVNXRWswZ1ZVY3ZoMHFraFRO?=
 =?utf-8?B?dU1FUUN0UXU1MWs0RnpTSXhKSTZpWE1uZVgvdUZEUjJlbUFvVnM1elRESzFN?=
 =?utf-8?B?b21tOXdDK0ZHcFRXNTJmSnpRbVlQeVFJaENzckNPYzFTbktuMktHcWV2L09u?=
 =?utf-8?B?T0NvRVdhR0UvTlRoUkRqQis2ZzVFR2Y2V1FkR093SUNWUHZCVnhUcVluZXdP?=
 =?utf-8?B?S25LZE1UdldHdkdqQjdkUWFHNWJGZzBHaXYveWVsYmtmMU1zVXNlMm42R3By?=
 =?utf-8?B?MVJUbGdGaE1rcldHbWQ3NUlJcEliMVUzNGNtdGhnRVh6bm0xaVJwVzBQMXpv?=
 =?utf-8?B?VkpyM04xQTBpN21pRGxYVkZBUXMyY01jTUR3QnV6dDlFV3p6a0U2UFg4a1BM?=
 =?utf-8?B?RXcwZHVEbFIyRXJxRnNML3JKRFVhYldqMVNmUTJ6ZGpTeWtlVm9LdGs4Z2F2?=
 =?utf-8?B?ZEZRN0VRM3dZMzJzY00wU21mUXhOcjdzT0hDOGxjdFN1Y1ZRTDRWZGJjdXhh?=
 =?utf-8?B?cjdQb0NBSGwvWFQwTXh0S3NyRzNCQ2UzTk9iZUsxcFVFTFpneFRtTCtQMExJ?=
 =?utf-8?B?ZzFFcUNRTDAzYzFLcG4wV2VFc1FBTTM5djkxZG9YQ3ByVUVDaU1QTkEwK0dY?=
 =?utf-8?B?YlBUZGFBOVErY2pyeG9zc1JMNzRXY2JPanFQejBIY29WNVY0bWNVVTVwMWZx?=
 =?utf-8?B?cTFnOXltdnd6RUs1dC9kUEdMWDRLQ28wU3JMOEptOVJQR2xnVlptYmd2bDBJ?=
 =?utf-8?B?Z2JKTEkvQk1pQUF5V1dRU3VKenZ4SEw0VldYaitQYkJlelRodisyek5LL3Z2?=
 =?utf-8?B?d0JoODJWRGd2MllmZUlQRVNxYUI2Tkpkc2ZPV1NZWGlKZzFOMXRydFZsWStG?=
 =?utf-8?B?dTVwRlFFVlY1cnNMVDhUbmdac0IyRXZkOTZORmRIdndRd3U5M0ZKRlFiMDF6?=
 =?utf-8?B?QkVBeXpqVnRJMnhhZGZRODhsOXBJU0FiV0o3dmJWbG9kNldUcWkvNkN1RWF3?=
 =?utf-8?B?TUpIQXEvbFN0ZUtHVWUyYnl0SWxmSWVYSFNrMEcvRkt0djY1TmliWjZHYlJV?=
 =?utf-8?B?N2lTd0pCRVVXTWYyRWRwaU1ObDhaOXU3ZGdLdWxNeGZDT2hsblRQb1dRcmZp?=
 =?utf-8?B?TlVOTWNxTXJpZ042L0JHVmc3RlVGRFd1UWtMSkFRSnR2TFdsd1ZHV1VXd3Fx?=
 =?utf-8?B?SW8vUTNxNmI3b3hxdXBUVlRyZFM5WThKaHBjVWd3MTRoZG95ajJmV2tOQmkz?=
 =?utf-8?B?Nm9vSkF4MEpYaE8yQURXN3NXSjdHN1U3TEoxWUxySEdIZElKOFJSbW9UTkFw?=
 =?utf-8?B?d09OaU5KSEpvK2c3RWh2VDF1MzNjL05HellzT1FCY2QxeVhXUGw3VVpUODdr?=
 =?utf-8?Q?3+UnUq4IYckxjgrlL6qgpmi7L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9206df65-f219-452d-30c5-08db86d9a40a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6019.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:22:32.4586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2H7FQHd1FALM6FG7iBoAnYz4CGXVUl7+yfsgNzQv23GJjqUnFBUdX+CP2+soGqfcx/bhuul8LdGV/auYg6Lbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/17/2023 10:30 PM, Gavin Li wrote:
> Add interrupt_coalesce config in send_queue and receive_queue to cache user
> config.
> 
> Send per virtqueue interrupt moderation config to underline device in order
> to have more efficient interrupt moderation and cpu utilization of guest
> VM.
> 
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/net/virtio_net.c        | 123 ++++++++++++++++++++++++++++----
>   include/uapi/linux/virtio_net.h |  14 ++++
>   2 files changed, 125 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 802ed21453f5..1566c7de9436 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -144,6 +144,8 @@ struct send_queue {
>   
>   	struct virtnet_sq_stats stats;
>   
> +	struct virtnet_interrupt_coalesce intr_coal;
> +
>   	struct napi_struct napi;
>   
>   	/* Record whether sq is in reset state. */
> @@ -161,6 +163,8 @@ struct receive_queue {
>   
>   	struct virtnet_rq_stats stats;
>   
> +	struct virtnet_interrupt_coalesce intr_coal;
> +
>   	/* Chain pages by the private ptr. */
>   	struct page *pages;
>   
> @@ -3078,6 +3082,59 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
>   	return 0;
>   }
>   
> +static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> +					 u16 vqn, u32 max_usecs, u32 max_packets)
> +{
> +	struct virtio_net_ctrl_coal_vq *coal_vq;
> +	struct scatterlist sgs;
> +
> +	coal_vq = kzalloc(sizeof(*coal_vq), GFP_KERNEL);
> +	if (!coal_vq)
> +		return -ENOMEM;
> +	coal_vq->vqn = cpu_to_le16(vqn);
> +	coal_vq->coal.max_usecs = cpu_to_le32(max_usecs);
> +	coal_vq->coal.max_packets = cpu_to_le32(max_packets);
> +	sg_init_one(&sgs, coal_vq, sizeof(*coal_vq));
> +
> +	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> +				  VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
> +				  &sgs))
> +		return -EINVAL;
Sorry, introduced mem leak here, ie. coal_vq. May I re-send the patch 
series or fix it in V3?
> +
> +	return 0;
> +}
> +
> +static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
> +					  struct ethtool_coalesce *ec,
> +					  u16 queue)
> +{
> +	int err;
> +
> +	if (ec->rx_coalesce_usecs || ec->rx_max_coalesced_frames) {
> +		err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
> +						    ec->rx_coalesce_usecs,
> +						    ec->rx_max_coalesced_frames);
> +		if (err)
> +			return err;
> +		/* Save parameters */
> +		vi->rq[queue].intr_coal.max_usecs = ec->rx_coalesce_usecs;
> +		vi->rq[queue].intr_coal.max_packets = ec->rx_max_coalesced_frames;
> +	}
> +
> +	if (ec->tx_coalesce_usecs || ec->tx_max_coalesced_frames) {
> +		err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
> +						    ec->tx_coalesce_usecs,
> +						    ec->tx_max_coalesced_frames);
> +		if (err)
> +			return err;
> +		/* Save parameters */
> +		vi->sq[queue].intr_coal.max_usecs = ec->tx_coalesce_usecs;
> +		vi->sq[queue].intr_coal.max_packets = ec->tx_max_coalesced_frames;
> +	}
> +
> +	return 0;
> +}
> +
>   static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>   {
>   	/* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_COAL
> @@ -3094,23 +3151,39 @@ static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>   }
>   
>   static int virtnet_set_coalesce_one(struct net_device *dev,
> -				    struct ethtool_coalesce *ec)
> +				    struct ethtool_coalesce *ec,
> +				    bool per_queue,
> +				    u32 queue)
>   {
>   	struct virtnet_info *vi = netdev_priv(dev);
> -	int ret, i, napi_weight;
> +	int queue_count = per_queue ? 1 : vi->max_queue_pairs;
> +	int queue_number = per_queue ? queue : 0;
>   	bool update_napi = false;
> +	int ret, i, napi_weight;
> +
> +	if (queue >= vi->max_queue_pairs)
> +		return -EINVAL;
>   
>   	/* Can't change NAPI weight if the link is up */
>   	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> -	if (napi_weight ^ vi->sq[0].napi.weight) {
> -		if (dev->flags & IFF_UP)
> -			return -EBUSY;
> -		else
> +	for (i = queue_number; i < queue_count; i++) {
> +		if (napi_weight ^ vi->sq[i].napi.weight) {
> +			if (dev->flags & IFF_UP)
> +				return -EBUSY;
> +
>   			update_napi = true;
> +			/* All queues that belong to [queue_number, queue_count] will be
> +			 * updated for the sake of simplicity, which might not be necessary
> +			 */
> +			queue_number = i;
> +			break;
> +		}
>   	}
>   
> -	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
> +	if (!per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
>   		ret = virtnet_send_notf_coal_cmds(vi, ec);
> +	else if (per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> +		ret = virtnet_send_notf_coal_vq_cmds(vi, ec, queue);
>   	else
>   		ret = virtnet_coal_params_supported(ec);
>   
> @@ -3118,7 +3191,7 @@ static int virtnet_set_coalesce_one(struct net_device *dev,
>   		return ret;
>   
>   	if (update_napi) {
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +		for (i = queue_number; i < queue_count; i++)
>   			vi->sq[i].napi.weight = napi_weight;
>   	}
>   
> @@ -3130,19 +3203,29 @@ static int virtnet_set_coalesce(struct net_device *dev,
>   				struct kernel_ethtool_coalesce *kernel_coal,
>   				struct netlink_ext_ack *extack)
>   {
> -	return virtnet_set_coalesce_one(dev, ec);
> +	return virtnet_set_coalesce_one(dev, ec, false, 0);
>   }
>   
>   static int virtnet_get_coalesce_one(struct net_device *dev,
> -				    struct ethtool_coalesce *ec)
> +				    struct ethtool_coalesce *ec,
> +				    bool per_queue,
> +				    u32 queue)
>   {
>   	struct virtnet_info *vi = netdev_priv(dev);
>   
> -	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
> +	if (queue >= vi->max_queue_pairs)
> +		return -EINVAL;
> +
> +	if (!per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
>   		ec->rx_coalesce_usecs = vi->intr_coal_rx.max_usecs;
>   		ec->tx_coalesce_usecs = vi->intr_coal_tx.max_usecs;
>   		ec->tx_max_coalesced_frames = vi->intr_coal_tx.max_packets;
>   		ec->rx_max_coalesced_frames = vi->intr_coal_rx.max_packets;
> +	} else if (per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> +		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
> +		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
> +		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
> +		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
>   	} else {
>   		ec->rx_max_coalesced_frames = 1;
>   
> @@ -3158,7 +3241,21 @@ static int virtnet_get_coalesce(struct net_device *dev,
>   				struct kernel_ethtool_coalesce *kernel_coal,
>   				struct netlink_ext_ack *extack)
>   {
> -	return virtnet_get_coalesce_one(dev, ec);
> +	return virtnet_get_coalesce_one(dev, ec, false, 0);
> +}
> +
> +static int virtnet_set_per_queue_coalesce(struct net_device *dev,
> +					  u32 queue,
> +					  struct ethtool_coalesce *ec)
> +{
> +	return virtnet_set_coalesce_one(dev, ec, true, queue);
> +}
> +
> +static int virtnet_get_per_queue_coalesce(struct net_device *dev,
> +					  u32 queue,
> +					  struct ethtool_coalesce *ec)
> +{
> +	return virtnet_get_coalesce_one(dev, ec, true, queue);
>   }
>   
>   static void virtnet_init_settings(struct net_device *dev)
> @@ -3291,6 +3388,8 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>   	.set_link_ksettings = virtnet_set_link_ksettings,
>   	.set_coalesce = virtnet_set_coalesce,
>   	.get_coalesce = virtnet_get_coalesce,
> +	.set_per_queue_coalesce = virtnet_set_per_queue_coalesce,
> +	.get_per_queue_coalesce = virtnet_get_per_queue_coalesce,
>   	.get_rxfh_key_size = virtnet_get_rxfh_key_size,
>   	.get_rxfh_indir_size = virtnet_get_rxfh_indir_size,
>   	.get_rxfh = virtnet_get_rxfh,
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 12c1c9699935..cc65ef0f3c3e 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,7 @@
>   #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>   					 * Steering */
>   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
>   #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
>   #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
>   #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
> @@ -391,5 +392,18 @@ struct virtio_net_ctrl_coal_rx {
>   };
>   
>   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET		1
> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET		2
> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET		3
> +
> +struct virtio_net_ctrl_coal {
> +	__le32 max_packets;
> +	__le32 max_usecs;
> +};
> +
> +struct  virtio_net_ctrl_coal_vq {
> +	__le16 vqn;
> +	__le16 reserved;
> +	struct virtio_net_ctrl_coal coal;
> +};
>   
>   #endif /* _UAPI_LINUX_VIRTIO_NET_H */

