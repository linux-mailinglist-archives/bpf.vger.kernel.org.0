Return-Path: <bpf+bounces-4390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F0374A9A4
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7018D281637
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958BE1FB2;
	Fri,  7 Jul 2023 04:05:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BFA1876;
	Fri,  7 Jul 2023 04:05:26 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0DB1FD7;
	Thu,  6 Jul 2023 21:05:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qy0DJ5ssxz4f3pGC;
	Fri,  7 Jul 2023 12:05:20 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgB3CDP+jqdkAuKtMg--.32213S2;
	Fri, 07 Jul 2023 12:05:21 +0800 (CST)
Subject: Re: [PATCH v4 bpf-next 12/14] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
 <20230706033447.54696-13-alexei.starovoitov@gmail.com>
 <2c09b7d7-b91c-c561-3fd6-b8483aab01dc@huaweicloud.com>
 <CAADnVQKea47Q1WPtmVrHEZijb=Ms8QzufVj8eds5HmNXGxSRug@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <205ac9e9-ef8c-2b39-8d76-a937d6fc72d5@huaweicloud.com>
Date: Fri, 7 Jul 2023 12:05:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKea47Q1WPtmVrHEZijb=Ms8QzufVj8eds5HmNXGxSRug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgB3CDP+jqdkAuKtMg--.32213S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryUXr45Cr18uFyfCFykKrg_yoW8Ar1fpF
	WxtFyUua1kAr4ft3sFqw4xCFyvvrs2grnxWa90qrW7trsIvr90gF1Ikry5uF93Kwn29342
	qr4DXr9ayw1kZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/7/2023 10:10 AM, Alexei Starovoitov wrote:
> On Thu, Jul 6, 2023 at 6:45 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>
>>
>> On 7/6/2023 11:34 AM, Alexei Starovoitov wrote:
>>> From: Alexei Starovoitov <ast@kernel.org>
>>>
>>> Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
>>> Unlike bpf_mem_[cache_]free() that links objects for immediate reuse into
>>> per-cpu free list the _rcu() flavor waits for RCU grace period and then moves
>>> objects into free_by_rcu_ttrace list where they are waiting for RCU
>>> task trace grace period to be freed into slab.
>>>
>>> The life cycle of objects:
>>> alloc: dequeue free_llist
>>> free: enqeueu free_llist
>>> free_rcu: enqueue free_by_rcu -> waiting_for_gp
>>> free_llist above high watermark -> free_by_rcu_ttrace
>>> after RCU GP waiting_for_gp -> free_by_rcu_ttrace
>>> free_by_rcu_ttrace -> waiting_for_gp_ttrace -> slab
>>>
>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> Acked-by: Hou Tao <houtao1@huawei.com>
> Thank you very much for code reviews and feedback.

You are welcome. I also learn a lot from this great patch set.

>
> btw I still believe that ABA is a non issue and prefer to keep the code as-is,
> but for the sake of experiment I've converted it to spin_lock
> (see attached patch which I think uglifies the code)
> and performance across bench htab-mem and map_perf_test
> seems to be about the same.
> Which was a bit surprising to me.
> Could you please benchmark it on your system?

Will do that later. It seems if there is no cross-CPU allocation and
free, the only possible contention is between __free_rcu() on CPU x and
alloc_bulk()/free_bulk() on a different CPU.


