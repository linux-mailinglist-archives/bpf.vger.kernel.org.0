Return-Path: <bpf+bounces-3389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0195073CDFA
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 04:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2F0280FBE
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 02:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCB063F;
	Sun, 25 Jun 2023 02:17:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1937F;
	Sun, 25 Jun 2023 02:17:25 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C014DA;
	Sat, 24 Jun 2023 19:17:23 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VlqWelz_1687659438;
Received: from 30.221.145.117(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VlqWelz_1687659438)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 10:17:19 +0800
Message-ID: <45bda8e7-8d4a-c7c9-1fe2-af6926329ef7@linux.alibaba.com>
Date: Sun, 25 Jun 2023 10:17:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v2 1/3] virtio-net: reprobe csum related fields
 for skb passed by XDP
To: Simon Horman <simon.horman@corigine.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
References: <20230624122604.110958-1-hengqi@linux.alibaba.com>
 <20230624122604.110958-2-hengqi@linux.alibaba.com>
 <ZJdCW4pxTioTPKJn@corigine.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <ZJdCW4pxTioTPKJn@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/6/25 上午3:28, Simon Horman 写道:
> On Sat, Jun 24, 2023 at 08:26:02PM +0800, Heng Qi wrote:
>
> ...
>
>> +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
>> +				      struct sk_buff *skb,
>> +				      __u8 flags)
> Hi Heng Qi,
>
> Unfortunately this appears to break an x86_64 allmodconfig build
> with GCC 12.3.0:
>
> drivers/net/virtio_net.c:1671:12: error: 'virtnet_set_csum_after_xdp' defined but not used [-Werror=unused-function]

I admit that this is a patch set, you can cherry-pick patches [1/3] and 
[2/3] together
to make it compile without 'defined but not used' warning. If people 
don't want to
separate [1/3] and [2/3], I can squash them into one. :)

Thanks.

>   1671 | static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
>        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> --
> pw-bot: changes-requested


