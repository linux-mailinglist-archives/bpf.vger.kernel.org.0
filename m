Return-Path: <bpf+bounces-14685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF06D7E779A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E03281811
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33BD1399;
	Fri, 10 Nov 2023 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324A365
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 02:37:38 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B5F270E
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:37:37 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SRNJp60FVz4f3lWG
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 10:37:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AC6381A016D
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 10:37:34 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDn_btql01lExkDAg--.26849S2;
	Fri, 10 Nov 2023 10:37:34 +0800 (CST)
Subject: Re: [PATCH bpf 05/11] bpf: Add bpf_map_of_map_fd_{get,put}_ptr()
 helpers
To: paulmck@kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>,
 bpf <bpf@vger.kernel.org>
References: <20231107140702.1891778-1-houtao@huaweicloud.com>
 <20231107140702.1891778-6-houtao@huaweicloud.com>
 <6125c508-82fe-37a4-3aa2-a6c2727c071b@linux.dev>
 <460844a9-a2e6-8cca-dfa1-9073bfffbb76@huaweicloud.com>
 <CAADnVQJJhjWJRvgdi3hTaCn8s1X1CJ5z1bUoKFXw32LTOjBWCg@mail.gmail.com>
 <64581135-5b99-4da7-9e19-e41122393d89@paulmck-laptop>
 <5aeecb90-e4fd-1a3e-b8e5-426c67d12cc6@huaweicloud.com>
 <5a4cd7db-4ef8-4033-aa9e-bf50e3560e46@paulmck-laptop>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <32b5b4fa-2b9e-cf6d-f3f8-2c7fce5b0dc4@huaweicloud.com>
Date: Fri, 10 Nov 2023 10:37:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5a4cd7db-4ef8-4033-aa9e-bf50e3560e46@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDn_btql01lExkDAg--.26849S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryxJryrAFy3Wr1kKFy5XFb_yoW5KrW8pF
	W8JFyYkr4DZr42kw1Svw48Xw1Yyrn3Ww47Xw1xJr15Ar98tr9xWrWxKa98uF1rGr1xJ340
	qr4qv343Wr1UZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

Hi Paul,

On 11/10/2023 9:45 AM, Paul E. McKenney wrote:
> On Fri, Nov 10, 2023 at 09:06:56AM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 11/10/2023 3:55 AM, Paul E. McKenney wrote:
>>> On Thu, Nov 09, 2023 at 07:55:50AM -0800, Alexei Starovoitov wrote:
>>>> On Wed, Nov 8, 2023 at 11:26 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>>> Hi,
>>>>>
>>>>> On 11/9/2023 2:36 PM, Martin KaFai Lau wrote:
>>>>>> On 11/7/23 6:06 AM, Hou Tao wrote:
>>>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>>>
>>>>>>> bpf_map_of_map_fd_get_ptr() will convert the map fd to the pointer
>>>>>>> saved in map-in-map. bpf_map_of_map_fd_put_ptr() will release the
>>>>>>> pointer saved in map-in-map. These two helpers will be used by the
>>>>>>> following patches to fix the use-after-free problems for map-in-map.
>>>>>>>
>>>>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>>>>> ---
>>>>>>>   kernel/bpf/map_in_map.c | 51 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>   kernel/bpf/map_in_map.h | 11 +++++++--
>>>>>>>   2 files changed, 60 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>>
>>>>> SNIP
>>>>>>> +void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer)
>>>>>>> +{
>>>>>>> +    struct bpf_inner_map_element *element = ptr;
>>>>>>> +
>>>>>>> +    /* Do bpf_map_put() after a RCU grace period and a tasks trace
>>>>>>> +     * RCU grace period, so it is certain that the bpf program which is
>>>>>>> +     * manipulating the map now has exited when bpf_map_put() is
>>>>>>> called.
>>>>>>> +     */
>>>>>>> +    if (need_defer)
>>>>>> "need_defer" should only happen from the syscall cmd? Instead of
>>>>>> adding rcu_head to each element, how about
>>>>>> "synchronize_rcu_mult(call_rcu, call_rcu_tasks)" here?
>>>>> No. I have tried the method before, but it didn't work due to dead-lock
>>>>> (will mention that in commit message in v2). The reason is that bpf
>>>>> syscall program may also do map update through sys_bpf helper. Because
>>>>> bpf syscall program is running with sleep-able context and has
>>>>> rcu_read_lock_trace being held, so call synchronize_rcu_mult(call_rcu,
>>>>> call_rcu_tasks) will lead to dead-lock.
>>>> Dead-lock? why?
>>>>
>>>> I think it's legal to do call_rcu_tasks_trace() while inside RCU CS
>>>> or RCU tasks trace CS.
>>> Just confirming that this is the case.  If invoking call_rcu_tasks_trace()
>>> within under either rcu_read_lock() or rcu_read_lock_trace() deadlocks,
>>> then there is a bug that needs fixing.  ;-)
>> The case for dead-lock is that calling synchronize_rcu_mult(call_rcu,
>> call_rcu_tasks_trace) within under rcu_read_lock_trace() and I think it
>> is expected. The case that calling call_rcu_tasks_trace() with
>> rcu_read_lock_trace() being held is OK.
> Very good, you are quite right.  In this particular case, deadlock is
> expected behavior.
>
> The problem here is that synchronize_rcu_mult() doesn't just invoke its
> arguments, instead, it also waits for all of the corresponding grace
> periods to complete.  But if you call this while under the protection of
> rcu_read_lock_trace(), then synchronize_rcu_mult(call_rcu_tasks_trace)
> cannot return until the corresponding rcu_read_unlock_trace() is
> reached, but that rcu_read_unlock_trace() cannot be reached until after
> synchronize_rcu_mult(call_rcu_tasks_trace) returns.
>
> (I did leave out the call_rcu argument because it does not participate
> in this particular deadlock.)

Got it. Thanks for the detailed explanation.
>
> 							Thanx, Paul
>
> .


