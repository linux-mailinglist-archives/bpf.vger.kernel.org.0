Return-Path: <bpf+bounces-3615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F297407AE
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 03:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BCF28115D
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 01:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779EC15C2;
	Wed, 28 Jun 2023 01:36:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DBB1376;
	Wed, 28 Jun 2023 01:36:58 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD326E4C;
	Tue, 27 Jun 2023 18:36:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QrPM92B5Qz4f3l1q;
	Wed, 28 Jun 2023 09:36:53 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDXjLCyjptkFHnIMg--.23349S2;
	Wed, 28 Jun 2023 09:36:54 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To: Alexei Starovoitov <ast@meta.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@fb.com, daniel@iogearbox.net,
 void@manifault.com, andrii@kernel.org, paulmck@kernel.org
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-13-alexei.starovoitov@gmail.com>
 <8f2d98bb-51b8-b61f-1f6d-59410befc55e@huaweicloud.com>
 <d0e0c583-48a7-715c-8bdd-15e0d061f126@meta.com>
Message-ID: <39240737-6fd1-a37c-6dbd-6cdf65e2c329@huaweicloud.com>
Date: Wed, 28 Jun 2023 09:36:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d0e0c583-48a7-715c-8bdd-15e0d061f126@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDXjLCyjptkFHnIMg--.23349S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww43tryxuF4fuw45Xw43KFg_yoW8KFyDpF
	4kGFyUGryrAFs3Ar1jgr1UAFWxZr1Yqas8GrW8XF9Iyr15Zr1aqF4Uuryqgr93Aw4kC3y7
	Ar1UXr1fZr43ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/28/2023 8:52 AM, Alexei Starovoitov wrote:
> On 6/23/23 11:49 PM, Hou Tao wrote:
>> Hi,
>>
>> On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
>>> From: Alexei Starovoitov <ast@kernel.org>
>>>
>> SNIP
>>>   +static void __free_by_rcu(struct rcu_head *head)
>>> +{
>>> +    struct bpf_mem_cache *c = container_of(head, struct
>>> bpf_mem_cache, rcu);
>>> +    struct bpf_mem_cache *tgt = c->tgt;
>>> +    struct llist_node *llnode;
>>> +
>>> +    if (unlikely(READ_ONCE(c->draining)))
>>> +        goto out;
>>> +
>>> +    llnode = llist_del_all(&c->waiting_for_gp);
>>> +    if (!llnode)
>>> +        goto out;
>>> +
>>> +    if (llist_add_batch(llnode, c->waiting_for_gp_tail,
>>> &tgt->free_by_rcu_ttrace))
>>> +        tgt->free_by_rcu_ttrace_tail = c->waiting_for_gp_tail;
>> Got a null-ptr dereference oops when running multiple test_maps and
>> htab-mem benchmark after hacking htab to use bpf_mem_cache_free_rcu().
>> And I think it happened as follow:
>>
>> // c->tgt
>> P1: __free_by_rcu()
>>          // c->tgt is the same as P1
>>          P2: __free_by_rcu()
>>
>> // return true
>> P1: llist_add_batch(&tgt->free_by_rcu_ttrace)
>>          // return false
>>          P2: llist_add_batch(&tgt->free_by_rcu_ttrace)
>>          P2: do_call_rcu_ttrace
>>          // return false
>>          P2: xchg(tgt->call_rcu_ttrace_in_progress, 1)
>>          // llnode is not NULL
>>          P2: llnode = llist_del_all(&c->free_by_rcu_ttrace)
>>          // BAD: c->free_by_rcu_ttrace_tail is NULL, so oops
>>          P2: __llist_add_batch(llnode, c->free_by_rcu_ttrace_tail)
>>
>> P1: tgt->free_by_rcu_ttrace_tail = X
>>
>> I don't have a good fix for the problem except adding a spin-lock for
>> free_by_rcu_ttrace and free_by_rcu_ttrace_tail.
>
> null-ptr is probably something else, since the race window is
> extremely tiny.

The null-ptr dereference is indeed due to free_by_rcu_ttrace_tail is
NULL. The oops occurred multiple times and I have checked the vmcore to
confirm that.

> In my testing this optimization doesn't buy much.
> So I'll just drop _tail optimization and switch to for_each(del_all)
> to move elements. We can revisit later.

OK


