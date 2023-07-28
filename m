Return-Path: <bpf+bounces-6197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47828766D5A
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 14:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BC52827BB
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659FC134A6;
	Fri, 28 Jul 2023 12:36:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B012B8E;
	Fri, 28 Jul 2023 12:36:56 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACB4187;
	Fri, 28 Jul 2023 05:36:53 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RC6Xx59DVzVjnR;
	Fri, 28 Jul 2023 20:35:13 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 20:36:50 +0800
Message-ID: <27306a24-02dd-f2f9-7d9d-982479498e8d@huawei.com>
Date: Fri, 28 Jul 2023 20:36:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH bpf 1/2] net: introduce __sk_rmem_schedule() helper
To: John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
	<edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jakub@cloudflare.com>, <dsahern@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230726142029.2867663-1-liujian56@huawei.com>
 <20230726142029.2867663-2-liujian56@huawei.com>
 <CANn89i+DuhGRXj9U-iXcEA__j6jvV5FC+tLNkGBCSqMCPpuFaA@mail.gmail.com>
 <64c2c272c111_831d20880@john.notmuch>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <64c2c272c111_831d20880@john.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/28 3:16, John Fastabend wrote:
> Eric Dumazet wrote:
>> On Wed, Jul 26, 2023 at 4:15 PM Liu Jian <liujian56@huawei.com> wrote:
>>>
>>> Compared with sk_wmem_schedule(), sk_rmem_schedule() not only performs
>>> rmem accounting, but also checks skb_pfmemalloc. The __sk_rmem_schedule()
>>> helper function is introduced here to perform only rmem accounting related
>>> activities.
>>>
>>
>> Why not care about pfmemalloc ? Why is it safe ?
>>
>> You need to give more details, or simply reuse the existing helper.
I didn't think so much. I extracted this helper just to do rmem 
accounting in bpf_tcp_ingress(), because I didn't see the pfmemalloc 
flag set when alloc sk_msg in sk_msg_alloc(). And thanks for your review.
> 
> I would just use the existing helper. Seems it should be fine.
ok, let's just leave it as it is. Thanks John.
> 
>>
>>> Signed-off-by: Liu Jian <liujian56@huawei.com>
>>> ---
>>>   include/net/sock.h | 12 ++++++++----
>>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/net/sock.h b/include/net/sock.h
>>> index 2eb916d1ff64..58bf26c5c041 100644
>>> --- a/include/net/sock.h
>>> +++ b/include/net/sock.h
>>> @@ -1617,16 +1617,20 @@ static inline bool sk_wmem_schedule(struct sock *sk, int size)
>>>          return delta <= 0 || __sk_mem_schedule(sk, delta, SK_MEM_SEND);
>>>   }
>>>
>>> -static inline bool
>>> -sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
>>> +static inline bool __sk_rmem_schedule(struct sock *sk, int size)
>>>   {
>>>          int delta;
>>>
>>>          if (!sk_has_account(sk))
>>>                  return true;
>>>          delta = size - sk->sk_forward_alloc;
>>> -       return delta <= 0 || __sk_mem_schedule(sk, delta, SK_MEM_RECV) ||
>>> -               skb_pfmemalloc(skb);
>>> +       return delta <= 0 || __sk_mem_schedule(sk, delta, SK_MEM_RECV);
>>> +}
>>> +
>>> +static inline bool
>>> +sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
>>> +{
>>> +       return __sk_rmem_schedule(sk, size) || skb_pfmemalloc(skb);
>>>   }
>>>
>>>   static inline int sk_unused_reserved_mem(const struct sock *sk)
>>> --
>>> 2.34.1
>>>
> 
> 

