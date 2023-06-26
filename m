Return-Path: <bpf+bounces-3451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB3473E288
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB081C209F5
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5079BA26;
	Mon, 26 Jun 2023 14:53:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7238D63C0;
	Mon, 26 Jun 2023 14:53:22 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BD8BB;
	Mon, 26 Jun 2023 07:53:20 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vm2FSIq_1687791191;
Received: from 30.212.190.93(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vm2FSIq_1687791191)
          by smtp.aliyun-inc.com;
          Mon, 26 Jun 2023 22:53:16 +0800
Message-ID: <4c652781-b188-121a-c5a9-75af8788194f@linux.alibaba.com>
Date: Mon, 26 Jun 2023 22:53:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v3 2/2] virtio-net: remove GUEST_CSUM check for
 XDP
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
References: <20230626120301.380-1-hengqi@linux.alibaba.com>
 <20230626120301.380-3-hengqi@linux.alibaba.com>
 <20230626081418-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230626081418-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/6/26 下午8:14, Michael S. Tsirkin 写道:
> On Mon, Jun 26, 2023 at 08:03:01PM +0800, Heng Qi wrote:
>> XDP and GUEST_CSUM no longer conflict now, so we removed the
> removed -> remove

Will modify.

Thanks.

>
>> check for GUEST_CSUM for XDP loading/unloading.
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>> v1->v2:
>>    - Rewrite the commit log.
>>
>>   drivers/net/virtio_net.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 0a715e0fbc97..2e4bd9a05c85 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -60,7 +60,6 @@ static const unsigned long guest_offloads[] = {
>>   	VIRTIO_NET_F_GUEST_TSO6,
>>   	VIRTIO_NET_F_GUEST_ECN,
>>   	VIRTIO_NET_F_GUEST_UFO,
>> -	VIRTIO_NET_F_GUEST_CSUM,
>>   	VIRTIO_NET_F_GUEST_USO4,
>>   	VIRTIO_NET_F_GUEST_USO6,
>>   	VIRTIO_NET_F_GUEST_HDRLEN
>> @@ -3437,10 +3436,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>>   	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>>   	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
>>   		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
>> -		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
>>   		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
>>   		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6))) {
>> -		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
>> +		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW, disable GRO_HW first");
>>   		return -EOPNOTSUPP;
>>   	}
>>   
>> -- 
>> 2.19.1.6.gb485710b


