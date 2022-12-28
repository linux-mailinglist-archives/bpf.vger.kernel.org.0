Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0167E6573E0
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 09:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiL1IYu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 03:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiL1IYu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 03:24:50 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA36FDF07;
        Wed, 28 Dec 2022 00:24:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VYGfkNs_1672215885;
Received: from 30.15.240.205(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VYGfkNs_1672215885)
          by smtp.aliyun-inc.com;
          Wed, 28 Dec 2022 16:24:46 +0800
Message-ID: <fb7b9914-33fb-b752-b421-d30349b44dbc@linux.alibaba.com>
Date:   Wed, 28 Dec 2022 16:24:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:108.0)
 Gecko/20100101 Thunderbird/108.0
Subject: Re: [PATCH v2 1/9] virtio_net: disable the hole mechanism for xdp
To:     Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221220141449.115918-1-hengqi@linux.alibaba.com>
 <20221220141449.115918-2-hengqi@linux.alibaba.com>
 <8d81ab3b-c10b-1a46-3ae1-b87228dbeb4e@redhat.com>
 <318bcc35-9699-ba94-d470-e81d246831a5@linux.alibaba.com>
 <c1b27a21-833c-2f3d-1943-7ab68c73836b@redhat.com>
From:   Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <c1b27a21-833c-2f3d-1943-7ab68c73836b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



在 2022/12/28 下午2:28, Jason Wang 写道:
>
> 在 2022/12/27 15:32, Heng Qi 写道:
>>
>>
>> 在 2022/12/27 下午2:30, Jason Wang 写道:
>>>
>>> 在 2022/12/20 22:14, Heng Qi 写道:
>>>> XDP core assumes that the frame_size of xdp_buff and the length of
>>>> the frag are PAGE_SIZE. The hole may cause the processing of xdp to
>>>> fail, so we disable the hole mechanism when xdp is set.
>>>>
>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>> ---
>>>>   drivers/net/virtio_net.c | 5 ++++-
>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 9cce7dec7366..443aa7b8f0ad 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -1419,8 +1419,11 @@ static int add_recvbuf_mergeable(struct 
>>>> virtnet_info *vi,
>>>>           /* To avoid internal fragmentation, if there is very 
>>>> likely not
>>>>            * enough space for another buffer, add the remaining 
>>>> space to
>>>>            * the current buffer.
>>>> +         * XDP core assumes that frame_size of xdp_buff and the 
>>>> length
>>>> +         * of the frag are PAGE_SIZE, so we disable the hole 
>>>> mechanism.
>>>>            */
>>>> -        len += hole;
>>>> +        if (!headroom)
>>>> +            len += hole;
>>>
>>>
>>> Is this only a requirement of multi-buffer XDP? If not, it need to 
>>> be backported to stable.
>>
>> It applies to single buffer xdp and multi-buffer xdp, but even if 
>> single buffer xdp has a hole
>> mechanism, there will be no problem (limiting mtu and turning off 
>> GUEST GSO), so there is
>> no need to backport it.
>
>
> Let's add this in the changelog.

Ok, thanks for your energy.

>
> With that,
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
>
>>
>> Thanks.
>>
>>>
>>> Thanks
>>>
>>>
>>>>           alloc_frag->offset += hole;
>>>>       }
>>

