Return-Path: <bpf+bounces-3419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A673D855
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 09:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429611C20749
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 07:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D801C35;
	Mon, 26 Jun 2023 07:17:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5A20E1;
	Mon, 26 Jun 2023 07:17:06 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CCAE7D;
	Mon, 26 Jun 2023 00:16:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QqK014gD0z4f3nyQ;
	Mon, 26 Jun 2023 15:16:33 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDXPypQO5lk8PWFLw--.36685S2;
	Mon, 26 Jun 2023 15:16:35 +0800 (CST)
Subject: Re: [PATCH v2 bpf-next 09/13] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
 rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-10-alexei.starovoitov@gmail.com>
 <9cc35513-5522-9229-469b-7d691c9790e1@huaweicloud.com>
 <CAADnVQJViJh47Cze186XCS0_jeQMb1wu6BfVZiQL6982a_hhfg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <417e4d9c-7b69-0b9a-07e3-9af4b3b3299f@huaweicloud.com>
Date: Mon, 26 Jun 2023 15:16:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJViJh47Cze186XCS0_jeQMb1wu6BfVZiQL6982a_hhfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDXPypQO5lk8PWFLw--.36685S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyfZFW8XF15tw1DGFW7Jwb_yoW5uw1rpr
	W8JFy5GFy8JrWIy3Wqqr48GFyqqr48JasrJayUXa4fKr15Xrn0qryfWry2grnxA3y8Cry7
	tw4kWr1Ivr45C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/26/2023 12:42 PM, Alexei Starovoitov wrote:
> On Sun, Jun 25, 2023 at 8:30 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
>>> From: Alexei Starovoitov <ast@kernel.org>
>>>
>>> alloc_bulk() can reuse elements from free_by_rcu_ttrace.
>>> Let it reuse from waiting_for_gp_ttrace as well to avoid unnecessary kmalloc().
>>>
>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>> ---
>>>  kernel/bpf/memalloc.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>> index 692a9a30c1dc..666917c16e87 100644
>>> --- a/kernel/bpf/memalloc.c
>>> +++ b/kernel/bpf/memalloc.c
>>> @@ -203,6 +203,15 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
>>>       if (i >= cnt)
>>>               return;
>>>
>>> +     for (; i < cnt; i++) {
>>> +             obj = llist_del_first(&c->waiting_for_gp_ttrace);
>> After allowing to reuse elements from waiting_for_gp_ttrace, there may
>> be concurrent llist_del_first() and llist_del_all() as shown below and
>> llist_del_first() is not safe because the elements freed from free_rcu()
>> could be reused immediately and head->first may be added back to
>> c0->waiting_for_gp_ttrace by other process.
>>
>> // c0
>> alloc_bulk()
>>     llist_del_first(&c->waiting_for_gp_ttrace)
>>
>> // c1->tgt = c0
>> free_rcu()
>>     llist_del_all(&c->waiting_for_gp_ttrace)
> I'm still thinking about how to fix the other issues you've reported,
> but this one, I believe, is fine.
> Are you basing 'not safe' on a comment?
> Why xchg(&head->first, NULL); on one cpu and
> try_cmpxchg(&head->first, &entry, next);
> is unsafe?
No, I didn't reason it only based on the comment in llist.h. The reason
I though it was not safe because llist_del_first() may have ABA problem
as pointed by you early, because after __free_rcu(), the elements on
waiting_for_gp_ttrace would be available immediately and
waiting_for_gp_ttrace->first may be reused and then added back to
waiting_for_gp_ttrace->first again as shown below.

// c0->waiting_for_gp_ttrace 
A -> B -> C -> nil 
 
P1: 
alloc_bulk(c0) 
    llist_del_first(&c0->waiting_for_gp_ttrace) 
        entry = A 
        next = B 
 
    P2: __free_rcu 
        // A/B/C is freed back to slab 
        // c0->waiting_for_gp_ttrace->first = NULL 
        free_all(llist_del_all(c0)) 
 
    P3: alloc_bulk(c1) 
        // got A 
        __kmalloc() 
 
    // free A (from c1), ..., last free X (allocated from c0) 
    P3: unit_free(c1)
        // the last freed element X is from c0
        c1->tgt = c0 
        c1->free_llist->first -> X -> Y -> ... -> A 
    P3: free_bulk(c1) 
        enque_to_free(c0) 
            c0->free_by_rcu_ttrace->first -> A -> ... -> Y -> X 
        __llist_add_batch(c0->waiting_for_gp_ttrace) 
            c0->waiting_for_gp_ttrace = A -> ... -> Y -> X 

P1: 
    // A is added back as first again
    // but llist_del_first() didn't know
    try_cmpxhg(&c0->waiting_for_gp_ttrace->first, A, B) 
    // c0->waiting_for_gp_trrace is corrupted 
    c0->waiting_for_gp_ttrace->first = B


