Return-Path: <bpf+bounces-6782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048E076DE80
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 04:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275FD1C213F4
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 02:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25D47469;
	Thu,  3 Aug 2023 02:47:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425046A7;
	Thu,  3 Aug 2023 02:47:47 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C398187;
	Wed,  2 Aug 2023 19:47:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGYD46Pz2z4f3v5D;
	Thu,  3 Aug 2023 10:47:32 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgCH8ixEFctkR0CNOg--.10118S2;
	Thu, 03 Aug 2023 10:47:33 +0800 (CST)
Message-ID: <0cc7eb75-f339-3aeb-016f-dc4094bdf600@huaweicloud.com>
Date: Thu, 3 Aug 2023 10:47:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix map type error in sock_map_del_link
Content-Language: en-US
To: John Fastabend <john.fastabend@gmail.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20230728105649.3978774-1-xukuohai@huaweicloud.com>
 <e2d06c78-1434-8322-1089-ba6355bb4c83@linux.dev>
 <6965ceb9-0b96-ce21-cc72-7d29b42544bd@huaweicloud.com>
 <64c8806537c3a_a427920846@john.notmuch>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <64c8806537c3a_a427920846@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCH8ixEFctkR0CNOg--.10118S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw48ArWkXF4rKrW5GFWUXFb_yoW5urW7pa
	4kuayS9F17AFW0gw4Yqr48Xw15Kw1rX3WjkF4Y934fKw4qkr1rAFy5KFWjkrn3KFWkWr47
	Xryj9r92qw47XaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/1/2023 11:47 AM, John Fastabend wrote:
> Xu Kuohai wrote:
>> On 8/1/2023 9:19 AM, Martin KaFai Lau wrote:
>>> On 7/28/23 3:56 AM, Xu Kuohai wrote:
>>>> sock_map_del_link() operates on both SOCKMAP and SOCKHASH, although
>>>> both types have member named "progs", the offset of "progs" member in
>>>> these two types is different, so "progs" should be accessed with the
>>>> real map type.
>>>
>>> The patch makes sense to me. Can a test be written to trigger it?
>>>
>>
>> Thank you for the review. I have a messy prog that triggers memleak
>> caused by this issue. I'll try to simplify it to a test.
>>
>>> John, please review.
>>>
>>>
>>> .
>>
>>
> 
> Thanks good catch. One thing I don't see any tests for is deleting a
> socket from a sockmap and then trying to use it? My guess is almost
> no one deletes sockets from a map except on sock close. Maybe to
> reproduce,
> 
>   1. connect a bunch of sockets to sockhash with verdict prog
>   2. remove the sockets
>   3. remove the sockhash
>   4. that should leak the bpf ref cnt so we could check for the
>      prog still existing?
> 

I tried this and found no bpf prog leaks. The debugging shows that
the stream_parser and stream_verdict progs are released as follows:

sock_map_unref

   sock_map_del_link

     struct bpf_stab *stab = container_of(map, struct bpf_stab, map);

     if (psock->saved_data_ready && stab->progs.stream_parser)
       strp_stop = true; // (1) not executed, since stab->progs.stream_parser
                         //     is actually shtab->progs.msg_parser, which is
                         //     NULL, so the if condition is false.

     if (psock->saved_data_ready && stab->progs.stream_verdict)
       verdict_stop = true;  // (2) executed, so verdict_stop is set to true

     if (strp_stop) // (3) condition is false since strp_stop is false
       sk_psock_stop_strp(sk, psock)

     if (verdict_stop) // (4) condition pass, so stream_verdict prog refcnt
                       //     is released by sk_psock_stop_verdict
       sk_psock_stop_verdict(sk, psock)
         psock_set_prog(&pock->progs.stream_verdict, NULL)
           bpf_prog_put // (5) release refcnt of stream_verdict prog


   sk_psock_put
       sk_psock_drop(sk, psock)
         sk_psock_stop_strp(sk, psock)
           sk_psock_stop_strp(&psock->progs.stream_parser, NULL)
             bpf_prog_put // (6) release refcnt of stream_parser prog



However, this issue triggers a WARNING in strp_done:

sock_map_unref
   sock_map_del_link

     struct bpf_stab *stab = container_of(map, struct bpf_stab, map);

     if (psock->saved_data_ready && stab->progs.stream_verdict)
       verdict_stop = true;  // (1) verdict_stop is set to true


     if (verdict_stop) // (2) condition pass
       sk_psock_stop_verdict(sk, psock)
         psock_set_prog(&pock->progs.stream_verdict, NULL)
           bpf_prog_put
         psock->saved_data_ready = NULL;  // (3) psock->saved_data_ready is
                                          //     set to NULL

   sk_psock_put
       sk_psock_drop(sk, psock)

         sk_psock_stop_strp(sk, psock)

           if (!psock->saved_data_ready) return; // (4) sk_psock_stop_strp returns

           strp_stop(&psock->strp) // (5) so strp_stop can not be called
             strp->stopped = 1; // (6) so strp->stopped is **NOT** set to 1

         sk_psock_destroy
           sk_psock_done_strp
             strp_done
               WARN_ON(!strp->stopped); // (7) WARNING triggered


Now I'm convinced the memleak I observed was caused by strp_done not
being called, I'll send a test for it.


> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> 
> 
> .


