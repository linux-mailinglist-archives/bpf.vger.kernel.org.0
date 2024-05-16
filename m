Return-Path: <bpf+bounces-29852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6838C77C1
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 15:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E21284401
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 13:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D79147C75;
	Thu, 16 May 2024 13:33:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C881474B4;
	Thu, 16 May 2024 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866409; cv=none; b=MpDKiM5/6zu/1ilc7KuRvxDd756ding7mwE5tBfuNCpg63ZOnVUcLFC66jSXpj3P3Wv14r08RfBDtujGn2aORKVz0nEsdTt6ffRzVElGJovde3uj8dZJBIiVfpODGLlzz5yfsGwSGytA0QBxoI8s93qDj3gsfmuR2T5DEYuH0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866409; c=relaxed/simple;
	bh=8BQXl5Llq5/RafOEGGjh0HLM1rzvrKPS/SpsK3w02t0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KLa25x/9L8JSbnY7l7yVt8m2LXQSmBb5DVFYvJzF5BEPZt1n4CzNsBkJHtxZQFtwTNr0X762L+uL6SMfBwDF4aqhrwSZOc1tY2W+pC+BWk/ed2wmXrYzpg7h4aSHgpJT+Twtmfnpe6aHRy6/EIMnLYnW2VBLEgpEK4dO75k+AEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vg9yc6ybvz4f3n5q;
	Thu, 16 May 2024 21:33:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 34FDE1A07F4;
	Thu, 16 May 2024 21:33:23 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDH4gsfC0ZmsqNPMw--.20800S2;
	Thu, 16 May 2024 21:33:20 +0800 (CST)
Subject: Re: [PATCH] net/sched: unregister root_lock_key in the error path of
 qdisc_alloc()
To: Hou Tao <houtao@huaweicloud.com>, netdev@vger.kernel.org,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>
Cc: bpf@vger.kernel.org
References: <20240516133035.1050113-1-houtao@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <dbb75bc2-cb09-79e9-2227-16adf957ae05@huaweicloud.com>
Date: Thu, 16 May 2024 21:33:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240516133035.1050113-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDH4gsfC0ZmsqNPMw--.20800S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW7AF1rZw4kuw47tFykuFg_yoWrKF1kpF
	Z5KryxJr1UtryUZr47tF48GF4UXwsxJr18CF1Sgr4rA3Z8G34Igr4vgr98WFW5Cry8Ca4Y
	ywn8u39rWw1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Oops. Forgot to add the target git tree for the patch. It is targeted
for net- tree.

On 5/16/2024 9:30 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> The following slab-use-after-free problem was reported by syzbot:
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in lockdep_register_key+0x253/0x3f0 kernel/locking/lockdep.c:1225
> Read of size 8 at addr ffff88805fe2c298 by task syz-executor.1/5906
>
> CPU: 1 PID: 5906 Comm: syz-executor.1 Not tainted 6.9.0-rc5-syzkaller-01473-g2506f6229bd0 #0
> ......
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  lockdep_register_key+0x253/0x3f0 kernel/locking/lockdep.c:1225
>  htab_map_alloc+0x9b/0xe60 kernel/bpf/hashtab.c:506
>  map_create+0x90c/0x1200 kernel/bpf/syscall.c:1333
>  __sys_bpf+0x6d1/0x810 kernel/bpf/syscall.c:5659
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> ......
>  </TASK>
>
> Allocated by task 5593:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  __do_kmalloc_node mm/slub.c:3966 [inline]
>  __kmalloc_node_track_caller+0x24e/0x4e0 mm/slub.c:3986
>  kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:597
>  __alloc_skb+0x1f3/0x440 net/core/skbuff.c:666
>  alloc_skb include/linux/skbuff.h:1308 [inline]
>  alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6455
>  ......
>
> Freed by task 5593:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2106 [inline]
>  slab_free mm/slub.c:4280 [inline]
>  kfree+0x153/0x3a0 mm/slub.c:4390
>  skb_kfree_head net/core/skbuff.c:1033 [inline]
>  skb_free_head net/core/skbuff.c:1045 [inline]
>  ......
>
> The buggy address belongs to the object at ffff88805fe2c000
>  which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 664 bytes inside of
>  freed 2048-byte region [ffff88805fe2c000, ffff88805fe2c800)
>
> At first glance, it seems there is a problem with bpf hash-table,
> because the use-after-free problem is reported when invoking
> htab_map_alloc(). However, after checking the reported error more
> carefully, it appears that qdiscs_alloc() is the culprit. The most
> important clue regarding why qdisc_alloc() is involved is the following:
> "The buggy address is located 664 bytes inside of freed 2048-byte
> region". lockdep_register_key() has several callers, and only the
> offset of lock_class_key in Qdisc in 664. The problem occurs as follow:
>
> (1) call qdisc_alloc()
> After calling lockdep_register_key(), qdisc_alloc() jumps to errout1
> label because netdev_alloc_pcpu_stats() or alloc_percpu() fails (e.g.,
> due to mem-cg limitation or SIGKILL). However it doesn't call
> lockdep_unregister_key() to unregister root_lock_key, but it frees the
> allocated memory.
>
> (2) call htab_map_alloc
> During the calling of lockdep_register_key(), it finds the lockdep_key
> registered by free-ed Qdisc and triggers the use-after-free.
>
> Fix it by invoking lockdep_unregister_key() in the error path of
> qdisc_alloc().
>
> Reported-by: syzbot+061f58eec3bde7ee8ffa@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/d28e4f02-965d-96de-ee56-f7a001b67fe7@huaweicloud.com/T/#m47c0670021ada17869bf887c73438133d879d326
> Fixes: af0cb3fa3f9e ("net/sched: fix false lockdep warning on qdisc root lock")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  net/sched/sch_generic.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 31dfd6c7405b0..d3f6006b563cc 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -982,6 +982,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
>  
>  	return sch;
>  errout1:
> +	lockdep_unregister_key(&sch->root_lock_key);
>  	kfree(sch);
>  errout:
>  	return ERR_PTR(err);


