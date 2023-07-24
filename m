Return-Path: <bpf+bounces-5706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBA075EDC4
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 10:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302181C20A79
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B15A2108;
	Mon, 24 Jul 2023 08:36:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5E51102;
	Mon, 24 Jul 2023 08:36:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA74AD;
	Mon, 24 Jul 2023 01:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ8fn/Nq1jomf+Jn2KC48xrNiYsoRFyMp2hkZIbGH1x51hoh5MrP1/2SOmCz7Xn9tcELpJ1lmGTuYKtYMqSR0+fg1lJ2+1WBZlzrfAneb0gGDgJTzIyBYUXNJszPv0yVcQenvAGnaH+3I2Iu/LveRSh6ne5N32bd7Ft9gRXggRdBkflLbH7d1rko1Q9lFhEusQ5d4gzd3kp7q/eVjtHPw2Hobr/ba2GYq4hLUZU22TFI5mX5+YsflEMYhjPSZq88u59Gi3tWe0f2+CVAY2vbBCpc7RimssqZNNypD6lK54aaNcwalkHqL34M9QP2MEXtfHn7rQppi1+xdBxBac3LEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2lCD1ZgFIGOe416sCN3+UHWuZcUvGWXSq8qSYvvBWY=;
 b=i7qgQ3LyffcdPMVRA0Zjz7hhI0FiyZOfClu8HnKCm20dMsejJjBBzhnUjmC13zZViHY8h1uB9Em711eCEVwUTzixnH5JnXwIGu9YppCnR0n9iPFZvN9X865INrv8nyrGoK0ZBnvTbEKhEVYLzu5dMuIKR1I7cMkIOqfngvAEFv0Ps5Sn/PQOsHC7lzMRC8DAVIFq6t3jTdgMH6pF1rx/tcnA3CFJhWa6fVXqwJHvIa2NFigy/oJuS9zcyS9feYXju9nm0TebUilzdVgkYr3QbJ9WcEjq//CiizB0mKsw5CE5+VO4Yq5hT37o54HqsTKtAu/ceIF95CJXKxU8YMITcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2lCD1ZgFIGOe416sCN3+UHWuZcUvGWXSq8qSYvvBWY=;
 b=NqcMEPAS+IKyffM0HKgp13qbPA/UJCOUoaTa+VFFFCfGBGrRNTA+Lg1ar08b0URhwZZr6hhFMSjYeYYhgo749EPeHJikLWKLI44OT64MrfYLn2dr2VUxRIT0B25BGR8jWJXdRSKX3eyFMbJlgKPX+hvF0iFhPV/xKAc/lSODMftUb7DnNnoRIYulZWy9XJibMvADd2QRTdy5oTPBveISr70NusOiELuLOcdFLZXrPdItPIZksqIdVFgvaMnizHbFYhlMtOvSEX83Yz2EHsrwMtqBMDjaCzkqoYSvmb6XJvMwTx4HMVpmdrK3MJVOQgm+Ye/CCb+9IXqkPvDSSgklVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 08:36:16 +0000
Received: from IA1PR12MB6019.namprd12.prod.outlook.com
 ([fe80::2f7a:1cd9:92ca:2e66]) by IA1PR12MB6019.namprd12.prod.outlook.com
 ([fe80::2f7a:1cd9:92ca:2e66%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 08:36:16 +0000
Message-ID: <f7f4920d-7dee-1902-c76f-56ec6eeb5b99@nvidia.com>
Date: Mon, 24 Jul 2023 16:36:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V3 3/4] virtio_net: support per queue interrupt
 coalesce command
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 jiri@nvidia.com, dtatulea@nvidia.com, gavi@nvidia.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20230724034048.51482-1-gavinl@nvidia.com>
 <20230724034048.51482-4-gavinl@nvidia.com>
 <20230724032451-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <20230724032451-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To IA1PR12MB6019.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6019:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebfe956-61aa-4bf9-f6d8-08db8c210b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uMtqUXBdRFEFgEMuknp8w6aUhEzxu121nJJk/sScG/EQcjsxVC0NrNaxYOIN+n0CJnInqK6feTZLG2G3/3vx6BCdqrWvgoan9wu1bDVGxSZ8TNrjs5dGgETCguN2QaxS3kCNdWXfX4KCx5iPhdOhDV6yWbIsFmX7nTFFH24/Z1IXETkteL9Nr3fpI4QhAy36lzzQiBajrCmDRJuZ3xvz5V/s0THhcP+0IykobUTeAFiYCLXWEZORX2Rje28JzhtGVzdruMidd2jEyKpDD6JpLGh55c4tAHxWk0/pkX93gttzuH/D01ta3ib3vjHmspCYt1VzpjxwAGKvHDALJqTQAso+X6Ct48nsnEFQtqiEiotx7c1GqYNvUMY1OeYrxdCTddgEtnjpqfCLoF/QQGWoHCNO9kL8gpSY1vri5jUzSwoWouJD5qJ4BhdfM8eGdUtXV05U9mBMsMxbxJUynPt7XKsgycShI9G7/rkjPkvj67AZTvbcDQD5/9ctSvL/28lihN1EYTlPV5poxjqGz/P+Lnf807MmzkbxrLasp9bg6YvKWSrcBAj943EwPzTcINS5i+aqvJTlmGhOCn5hsY9BQDad9c6At0lW3OeZ4KD2z2RtSOAvvkwx/osDUpK/ScNdOl9ibEKCPel/mvPnSwR4oQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6019.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199021)(6486002)(6512007)(6666004)(36756003)(38100700002)(2616005)(26005)(6506007)(186003)(53546011)(83380400001)(316002)(4326008)(66556008)(66476007)(66946007)(6916009)(2906002)(31686004)(7416002)(8936002)(8676002)(41300700001)(31696002)(86362001)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXJWN1pGeEladmVNak1mNlZiTWhsYldMcEllS1VrdDgyUUNjWUo5aDUxZERH?=
 =?utf-8?B?ekdLb0NJeTJpb1N5TkpqMHBnd0dlOXFHN2VVWjZvbnQxNWQrTFBYUExyQkJk?=
 =?utf-8?B?MmovUThlQ2I3Q2VocjNUL0FudE9nOEZBNTc1MnQzR3J4cVZPTHI4bHUzUWhq?=
 =?utf-8?B?VUtMTERUekVkT0srNTV2QUREZnU5aXNtZ3Q0bXBiZlpGK01xY1RPL21WY2Ex?=
 =?utf-8?B?TWtodDF5bVZDb0hkQ3MwNnRvK0NyU012Q3plRjl1aUs2TEFieWJheitZYkFP?=
 =?utf-8?B?SHRwdGpXOFUrOHdoTFJWa0M1QlkxR3NTRklVL0JFeHhrVmk2eVJ0VkxWQk53?=
 =?utf-8?B?WEYxT2FDM1dvWW5sMnFEM1dUV28vUFdZaVZRcmh2clkrU2s1bnY4b09JaGRK?=
 =?utf-8?B?V3JlUWg1ZWVYZW80REtjd3Q1RzBMUi9uMWRyVzF2d2RSZS9Kc0pkQWhkVUha?=
 =?utf-8?B?QkJ4aDdEOFUyREluMnZzbmRnM1Vlbkk0NGN3cHFIRnFwYXBISU5NdjhvbTMz?=
 =?utf-8?B?WmpyRXJrVVFOcCtGOUMvTlQ4ekZ6enpuUmcvbmRKRzBNS3BJZi8wWmZlRnF0?=
 =?utf-8?B?U2wxQ0NqdzJ0UDBTRENuQnZxME9aTTd1L1pZeExlMlowUHN1a3pzM0xmSmxR?=
 =?utf-8?B?eWFndTg3bVZuL2c2VkNURVZrRXNOZjJCbEQrUmRIYWF2NmdkN2pvcFFGZE5L?=
 =?utf-8?B?OGVibzVZVmtiZXZIQ1N5SkdiMnlMais2QlpQSW9qbENsc09vN1RacGNReHJL?=
 =?utf-8?B?UnZyZkxybnF2ckVLMlYza0RFdVc2cHNUL09mSjZSVnFNb0dtN3k3VjBmcmwz?=
 =?utf-8?B?eHFIL0NyWjlhMzVCSlBESTdjcDJqNi8zTzlML1lDaHRqZ0dRZ3hlYUlZeXo5?=
 =?utf-8?B?ZGo4aUFxdnFBdWJRYmw2K0VvakQ3TzVzZjA2NTJYNzUxODFCdUdXSHV5MWlu?=
 =?utf-8?B?VjFSWG1TdE16Sys2ejd4ZzJoNWxHTW1iL3FuTit1ZlZkUWVtNmpoUWZFWjJ6?=
 =?utf-8?B?MXBycjV6eTdhS2NCSjNENkNxcGFJZVRZVkVKSi9TRXFUelI0L1p5KzlzSVJT?=
 =?utf-8?B?M1RoUkVkVXhXVzlEMTdnUk8xRGF2ZTN3VFRtWlY3Ym9kK3AvT25hRzlXRDdX?=
 =?utf-8?B?WmkzSUdYdGFFTWVwL3VVcnBmaEZUMGQxaU9URWM5eitrbHRUdEdISDhKSysw?=
 =?utf-8?B?MlRPOS9sRmRGSTZzdVExS056dGNqMitnSlZnWnVNZXNicndtR1dvdjBxUHlx?=
 =?utf-8?B?WUptOHBtbTE1REhiSWlhYmlzd25TL29zcUdwM2tnYytSZzRMR3FYZElFL3l3?=
 =?utf-8?B?cVppbVhDMXpQTnlSK3llZzZpVFk5ZGJRek92T2NDWGxmRFFBVkJOM09PcDk2?=
 =?utf-8?B?OGpSOGxaZ2ZRUnUzVG9ZeGxKMzdWdmpTZ1c5b1JSdmo4SzRnTFFxTldIVlFT?=
 =?utf-8?B?Q2RCVkJyZHR1V0V6UVFjdzViR0VuUTM1d0diRnhMUVNVcUtuK0kwQSsyNE9I?=
 =?utf-8?B?UVVIOXF5Q09laHJLUC94YUtrM1MrM2FoMGpCUUZHVmpldktPc29pRlB6SmYy?=
 =?utf-8?B?WGpBMzRzOHZVdVd1NWoxRlVHcXJSUURYZzZhU0tPaVR2dWJBMEFCSGJpaStH?=
 =?utf-8?B?ZDJGTjYycjAxQVViWWp0LzFRb2tXcUYzN1RZNStIY0oxL0FITE02N2p2eHRo?=
 =?utf-8?B?VnBBY1B6di8xbEtaN01WK3ljTk04ZWRrNVdZWDFacTdmMFdsc3ppVDRDbmht?=
 =?utf-8?B?QWdvWjFqWU9TM05yVmJCcVU5d3lrRHBZazlXakFEMHNrR3NWR3htazIxeGtL?=
 =?utf-8?B?aFc0dDBZa3JLZVJRZEdmdVZVWWdxdHlGUnYxMU9wTzhheHZPN3pBYjJ4TUdi?=
 =?utf-8?B?anhvNjJ3dnZKdGdUNEVoK3dhVkQwK0VRVWduZ1R6SDRuaVFES3BTODlwbTN1?=
 =?utf-8?B?K3lnR3JUTGVDTWFSSW5CQ2VvK3RhYUc4MjBaVHFLU25CT1kvT2QxaTA4YStz?=
 =?utf-8?B?T0RSSHZrcGdyN003ajRKSDIyeE5uRzFXUW9qMmdvRFhmcGFtZDIxK3dNZ2dW?=
 =?utf-8?B?VjNuZUo5NVlNNE5EdmkzWHcxc0xSOGZOR29HSkR3MVBSTXdoV0E1VVVBeGE3?=
 =?utf-8?Q?11Ne5753VYO7v1PfOXJp/N+GL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebfe956-61aa-4bf9-f6d8-08db8c210b9e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6019.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 08:36:16.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wl+XMiwinFJuqup0UZAXQD5xveowNSo7gOZpCaaH6ytGE5McelZJpwD3QQue3hyXaeuj9dbmtSSRY5QlSgZNDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/24/2023 3:32 PM, Michael S. Tsirkin wrote:
> On Mon, Jul 24, 2023 at 06:40:47AM +0300, Gavin Li wrote:
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
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   drivers/net/virtio_net.c        | 120 ++++++++++++++++++++++++++++----
>>   include/uapi/linux/virtio_net.h |  14 ++++
>>   2 files changed, 122 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 802ed21453f5..0c3ee1e26ece 100644
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
>> @@ -212,6 +216,7 @@ struct control_buf {
>>   	struct virtio_net_ctrl_rss rss;
>>   	struct virtio_net_ctrl_coal_tx coal_tx;
>>   	struct virtio_net_ctrl_coal_rx coal_rx;
>> +	struct virtio_net_ctrl_coal_vq coal_vq;
>>   };
>>   
>>   struct virtnet_info {
>> @@ -3078,6 +3083,55 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
>>   	return 0;
>>   }
>>   
>> +static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
>> +					 u16 vqn, u32 max_usecs, u32 max_packets)
>> +{
>> +	struct scatterlist sgs;
>> +
>> +	vi->ctrl->coal_vq.vqn = cpu_to_le16(vqn);
>> +	vi->ctrl->coal_vq.coal.max_usecs = cpu_to_le32(max_usecs);
>> +	vi->ctrl->coal_vq.coal.max_packets = cpu_to_le32(max_packets);
>> +	sg_init_one(&sgs, &vi->ctrl->coal_vq, sizeof(vi->ctrl->coal_vq));
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
>> @@ -3094,23 +3148,39 @@ static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
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
> 
> Actually can't we refactor this? This whole function is littered
> with if/else branches. just code it separately - the only
> common part is:
> 
>          napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
>          if (napi_weight ^ vi->sq[0].napi.weight) {
>                  if (dev->flags & IFF_UP)
>                          return -EBUSY;
>                  else
>                          update_napi = true;
>          }
> 
> so just move this to a helper and have two functions - global and
> per queue.
ACK
> 
> 
> 
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
>> +			/* All queues that belong to [queue_number, queue_count] will be
>> +			 * updated for the sake of simplicity, which might not be necessary
>> +			 */
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
>> @@ -3118,7 +3188,7 @@ static int virtnet_set_coalesce_one(struct net_device *dev,
>>   		return ret;
>>   
>>   	if (update_napi) {
>> -		for (i = 0; i < vi->max_queue_pairs; i++)
>> +		for (i = queue_number; i < queue_count; i++)
>>   			vi->sq[i].napi.weight = napi_weight;
>>   	}
>>   
>> @@ -3130,19 +3200,29 @@ static int virtnet_set_coalesce(struct net_device *dev,
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
>> @@ -3158,7 +3238,21 @@ static int virtnet_get_coalesce(struct net_device *dev,
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
>> @@ -3291,6 +3385,8 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
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
> 

