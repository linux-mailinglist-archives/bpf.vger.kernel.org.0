Return-Path: <bpf+bounces-14694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985E07E780D
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 04:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529AB2814BE
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDA415C5;
	Fri, 10 Nov 2023 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130F115B3
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 03:34:11 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A821449EB
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 19:34:10 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SRPZ44TKnz4f3kL1
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:34:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 05B551A0173
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:34:07 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAXbUurpE1lqwYhAg--.39772S2;
	Fri, 10 Nov 2023 11:34:06 +0800 (CST)
Subject: Re: [PATCH bpf 05/11] bpf: Add bpf_map_of_map_fd_{get,put}_ptr()
 helpers
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>,
 paulmck@kernel.org, Hou Tao <houtao1@huawei.com>
References: <20231107140702.1891778-1-houtao@huaweicloud.com>
 <20231107140702.1891778-6-houtao@huaweicloud.com>
 <6125c508-82fe-37a4-3aa2-a6c2727c071b@linux.dev>
 <460844a9-a2e6-8cca-dfa1-9073bfffbb76@huaweicloud.com>
 <CAADnVQJJhjWJRvgdi3hTaCn8s1X1CJ5z1bUoKFXw32LTOjBWCg@mail.gmail.com>
 <64581135-5b99-4da7-9e19-e41122393d89@paulmck-laptop>
 <5aeecb90-e4fd-1a3e-b8e5-426c67d12cc6@huaweicloud.com>
 <5a4cd7db-4ef8-4033-aa9e-bf50e3560e46@paulmck-laptop>
 <23b55935-0ad4-5a0a-f19a-ba718793902b@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <f8e1e390-2f12-33c0-cd4b-e59c8223711f@huaweicloud.com>
Date: Fri, 10 Nov 2023 11:34:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <23b55935-0ad4-5a0a-f19a-ba718793902b@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAXbUurpE1lqwYhAg--.39772S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWrWrW5tw1kJw15uw1UGFg_yoW8uFWfpF
	WrtFWUKr1UXrs5KrsFvw4UXayxt3ykJ3WUXr18JFyUAryqgr1fWry8KFZ09F15urs7Jw1j
	qr9Fq3sxW345Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Martin,

On 11/10/2023 10:48 AM, Martin KaFai Lau wrote:
> On 11/9/23 5:45 PM, Paul E. McKenney wrote:
>>>>>>>> +void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer)
>>>>>>>> +{
>>>>>>>> +    struct bpf_inner_map_element *element = ptr;
>>>>>>>> +
>>>>>>>> +    /* Do bpf_map_put() after a RCU grace period and a tasks
>>>>>>>> trace
>>>>>>>> +     * RCU grace period, so it is certain that the bpf program
>>>>>>>> which is
>>>>>>>> +     * manipulating the map now has exited when bpf_map_put() is
>>>>>>>> called.
>>>>>>>> +     */
>>>>>>>> +    if (need_defer)
>>>>>>> "need_defer" should only happen from the syscall cmd? Instead of
>>>>>>> adding rcu_head to each element, how about
>>>>>>> "synchronize_rcu_mult(call_rcu, call_rcu_tasks)" here?
>>>>>> No. I have tried the method before, but it didn't work due to
>>>>>> dead-lock
>>>>>> (will mention that in commit message in v2). The reason is that bpf
>>>>>> syscall program may also do map update through sys_bpf helper.
>>>>>> Because
>>>>>> bpf syscall program is running with sleep-able context and has
>>>>>> rcu_read_lock_trace being held, so call
>>>>>> synchronize_rcu_mult(call_rcu,
>>>>>> call_rcu_tasks) will lead to dead-lock.
>
> Need to think of a less intrusive solution instead of adding rcu_head
> to each element and lookup also needs an extra de-referencing.

I see.
>
> May be the bpf_map_{update,delete}_elem(&outer_map, ....) should not
> be done by the syscall program? Which selftest does it?

Now bpf_map_update_elem is allowed for bpf_sys_bpf helper. If I
remembered correctly it was map_ptr.
>
> Can the inner_map learn that it has been deleted from an outer map
> that is used in a sleepable prog->aux->used_maps? The
> bpf_map_free_deferred() will then wait for a task_trace gp?

Considering an inner_map may be used by multiple outer_map, the
following solution will be simpler: if the inner map has been deleted
from an outer map once, its free must be delayed after one RCU GP and
one tasks trace RCU GP. But I will check whether it is possible to only
wait for one RCU GP instead of two.


