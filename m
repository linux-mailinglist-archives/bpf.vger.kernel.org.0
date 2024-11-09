Return-Path: <bpf+bounces-44406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606F89C2927
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 02:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AAC4B23849
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 01:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A9B1CA94;
	Sat,  9 Nov 2024 01:29:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2631C6B8
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 01:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731115798; cv=none; b=n+cGtVUQ2oIQTRkdGsrOAzaitTipKsE4/cKZe+wIdE6czbZyqzJOoOR3BcW/6zaX5z0XH0KNGcxoH8VV0PdRGeUYPuQ5fUAIaCOso6G3FaOZrLPCc7QGKYskrm3E9MEk+8aKQu52E5QZnUETZttuH695z4mpiobaIvzHoIjUlHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731115798; c=relaxed/simple;
	bh=t/pQmQHraiQ3DH0gA10LmxWhum09tm48APYuDuEDcgs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=moTmKsnL+f7gcwXZoeCNRJgCg9tlIy6RxpZLmUO4rGyWmioru1pYwFzMU0T+HVoAcTGnFI2FzaAcQu6nSKImLm7c1e+t4MdlqYlCMesdTY8SLNRKKiMXvONfhjZBfKxR1mSXPjS0uHd1RLfWuIV9wf8FbdBuBW+MoWNIs/b9ZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XldWw1ZNnz4f3lVg
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 09:29:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2C3601A058E
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 09:29:51 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgC3GOULuy5no5j7BA--.8004S2;
	Sat, 09 Nov 2024 09:29:50 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/3] bpf: Call free_htab_elem() after
 htab_unlock_bucket()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Xu Kuohai <xukuohai@huawei.com>, "houtao1@huawei.com" <houtao1@huawei.com>
References: <20241106063542.357743-1-houtao@huaweicloud.com>
 <20241106063542.357743-2-houtao@huaweicloud.com>
 <102c9956-6e85-36c8-68f5-32115a2744a1@huaweicloud.com>
 <CAADnVQLrPRvPac-CaWScTfaswZtrpy5-C3_8OU1-=oBWj+tBDA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <9515d9d3-4f35-6119-8a35-57614f3cd457@huaweicloud.com>
Date: Sat, 9 Nov 2024 09:29:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLrPRvPac-CaWScTfaswZtrpy5-C3_8OU1-=oBWj+tBDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgC3GOULuy5no5j7BA--.8004S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFW8Xw43ArWDJF1kZrWxtFb_yoW5trWUpF
	Z3KFyIkw1kJryjvr4Yva12vF4jyr4xGw18Ar95Kry8ZFy5Zw1xGr1xGa1xCF98WrWkAFsx
	X3Zrt39a9w4UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/9/2024 3:55 AM, Alexei Starovoitov wrote:
> On Wed, Nov 6, 2024 at 1:53 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>
>>
>> On 11/6/2024 2:35 PM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> For htab of maps, when the map is removed from the htab, it may hold the
>>> last reference of the map. bpf_map_fd_put_ptr() will invoke
>>> bpf_map_free_id() to free the id of the removed map element. However,
>>> bpf_map_fd_put_ptr() is invoked while holding a bucket lock
>>> (raw_spin_lock_t), and bpf_map_free_id() attempts to acquire map_idr_lock
>>> (spinlock_t), triggering the following lockdep warning:
>>>
>>>   =============================
>>>   [ BUG: Invalid wait context ]
>>>   6.11.0-rc4+ #49 Not tainted
>>>   -----------------------------
>>>   test_maps/4881 is trying to lock:
>>>   ffffffff84884578 (map_idr_lock){+...}-{3:3}, at: bpf_map_free_id.part.0+0x21/0x70
>>>   other info that might help us debug this:
>>>   context-{5:5}
>>>   2 locks held by test_maps/4881:
>>>    #0: ffffffff846caf60 (rcu_read_lock){....}-{1:3}, at: bpf_fd_htab_map_update_elem+0xf9/0x270
>>>    #1: ffff888149ced148 (&htab->lockdep_key#2){....}-{2:2}, at: htab_map_update_elem+0x178/0xa80
>>>   stack backtrace:
>>>   CPU: 0 UID: 0 PID: 4881 Comm: test_maps Not tainted 6.11.0-rc4+ #49
>>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ...
>>>   Call Trace:
>>>    <TASK>
>>>    dump_stack_lvl+0x6e/0xb0
>>>    dump_stack+0x10/0x20
>>>    __lock_acquire+0x73e/0x36c0
>>>    lock_acquire+0x182/0x450
>>>    _raw_spin_lock_irqsave+0x43/0x70
>>>    bpf_map_free_id.part.0+0x21/0x70
>>>    bpf_map_put+0xcf/0x110
>>>    bpf_map_fd_put_ptr+0x9a/0xb0
>>>    free_htab_elem+0x69/0xe0
>>>    htab_map_update_elem+0x50f/0xa80
>>>    bpf_fd_htab_map_update_elem+0x131/0x270
>>>    htab_map_update_elem+0x50f/0xa80
>>>    bpf_fd_htab_map_update_elem+0x131/0x270
>>>    bpf_map_update_value+0x266/0x380
>>>    __sys_bpf+0x21bb/0x36b0
>>>    __x64_sys_bpf+0x45/0x60
>>>    x64_sys_call+0x1b2a/0x20d0
>>>    do_syscall_64+0x5d/0x100
>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> One way to fix the lockdep warning is using raw_spinlock_t for
>>> map_idr_lock as well. However, bpf_map_alloc_id() invokes
>>> idr_alloc_cyclic() after acquiring map_idr_lock, it will trigger a
>>> similar lockdep warning because the slab's lock (s->cpu_slab->lock) is
>>> still a spinlock.
>> Is it OK to move the calling of bpf_map_free_id() from bpf_map_put() to
>> bpf_map_free_deferred() ? It could fix the lockdep warning for htab of
>> maps. Its downside is that the free of map id will be delayed, but I
>> think it will not make a visible effect to the user, because the refcnt
>> is already 0, trying to get the map fd through map id will return -ENOENT.
> I've applied the current patch, since doing free outside of bucket lock
> is a good thing to do anyway.
> With that no need to move bpf_map_free_id(), right?
> At least offload case relies on id being removed immediately.
> I don't remember what else might care.
> .

Yes. There is no need to move bpf_map_free_id() after applying the
patch. Thanks for the information about offload map. According to the
implementation of _bpf_map_offload_destroy(), it seems that it may need
to call bpf_map_free_id() twice, so now bpf_map_free_id() frees the
immediately and sets map->id as 0.


