Return-Path: <bpf+bounces-14667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9907E7666
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3AF1C20E2D
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492EE643;
	Fri, 10 Nov 2023 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC9DEA0
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 01:07:04 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10B1B5
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:07:03 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SRLJM0Hf8z4f3jYK
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 09:06:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2DE521A0173
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 09:07:00 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAXGxEwgk1lAHwFAg--.53598S2;
	Fri, 10 Nov 2023 09:07:00 +0800 (CST)
Subject: Re: [PATCH bpf 05/11] bpf: Add bpf_map_of_map_fd_{get,put}_ptr()
 helpers
To: paulmck@kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
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
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <5aeecb90-e4fd-1a3e-b8e5-426c67d12cc6@huaweicloud.com>
Date: Fri, 10 Nov 2023 09:06:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <64581135-5b99-4da7-9e19-e41122393d89@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAXGxEwgk1lAHwFAg--.53598S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4DGw4rJF4fGw4fXFyrWFg_yoW5Gr15pF
	WxtFyYkr4DZr42kw1Svw48Zw1aywn3W3y7Xr1xJryYyr90yr9xWryxKa13CF1rGrWxCa4j
	qr90v3sxWryUAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/10/2023 3:55 AM, Paul E. McKenney wrote:
> On Thu, Nov 09, 2023 at 07:55:50AM -0800, Alexei Starovoitov wrote:
>> On Wed, Nov 8, 2023 at 11:26 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>> Hi,
>>>
>>> On 11/9/2023 2:36 PM, Martin KaFai Lau wrote:
>>>> On 11/7/23 6:06 AM, Hou Tao wrote:
>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>
>>>>> bpf_map_of_map_fd_get_ptr() will convert the map fd to the pointer
>>>>> saved in map-in-map. bpf_map_of_map_fd_put_ptr() will release the
>>>>> pointer saved in map-in-map. These two helpers will be used by the
>>>>> following patches to fix the use-after-free problems for map-in-map.
>>>>>
>>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>>> ---
>>>>>   kernel/bpf/map_in_map.c | 51 +++++++++++++++++++++++++++++++++++++++++
>>>>>   kernel/bpf/map_in_map.h | 11 +++++++--
>>>>>   2 files changed, 60 insertions(+), 2 deletions(-)
>>>>>
>>>>>
>>> SNIP
>>>>> +void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer)
>>>>> +{
>>>>> +    struct bpf_inner_map_element *element = ptr;
>>>>> +
>>>>> +    /* Do bpf_map_put() after a RCU grace period and a tasks trace
>>>>> +     * RCU grace period, so it is certain that the bpf program which is
>>>>> +     * manipulating the map now has exited when bpf_map_put() is
>>>>> called.
>>>>> +     */
>>>>> +    if (need_defer)
>>>> "need_defer" should only happen from the syscall cmd? Instead of
>>>> adding rcu_head to each element, how about
>>>> "synchronize_rcu_mult(call_rcu, call_rcu_tasks)" here?
>>> No. I have tried the method before, but it didn't work due to dead-lock
>>> (will mention that in commit message in v2). The reason is that bpf
>>> syscall program may also do map update through sys_bpf helper. Because
>>> bpf syscall program is running with sleep-able context and has
>>> rcu_read_lock_trace being held, so call synchronize_rcu_mult(call_rcu,
>>> call_rcu_tasks) will lead to dead-lock.
>> Dead-lock? why?
>>
>> I think it's legal to do call_rcu_tasks_trace() while inside RCU CS
>> or RCU tasks trace CS.
> Just confirming that this is the case.  If invoking call_rcu_tasks_trace()
> within under either rcu_read_lock() or rcu_read_lock_trace() deadlocks,
> then there is a bug that needs fixing.  ;-)

The case for dead-lock is that calling synchronize_rcu_mult(call_rcu,
call_rcu_tasks_trace) within under rcu_read_lock_trace() and I think it
is expected. The case that calling call_rcu_tasks_trace() with
rcu_read_lock_trace() being held is OK.
>
> 							Thanx, Paul
>
> .


