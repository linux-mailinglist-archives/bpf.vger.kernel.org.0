Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9E4740A77
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 10:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjF1IGW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 04:06:22 -0400
Received: from dggsgout11.his.huawei.com ([45.249.212.51]:12482 "EHLO
        dggsgout11.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjF1IBm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jun 2023 04:01:42 -0400
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QrX7b36Tmz4f3lW1;
        Wed, 28 Jun 2023 14:42:19 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgBnwRtI1ptky4UWMA--.28710S2;
        Wed, 28 Jun 2023 14:42:20 +0800 (CST)
Subject: Re: [PATCH v3 bpf-next 08/13] bpf: Add a hint to allocated objects.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com, daniel@iogearbox.net,
        andrii@kernel.org, void@manifault.com, paulmck@kernel.org
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
 <20230628015634.33193-9-alexei.starovoitov@gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <72f4117b-566b-8d0f-4570-b6d43e6a9ff9@huaweicloud.com>
Date:   Wed, 28 Jun 2023 14:42:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230628015634.33193-9-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgBnwRtI1ptky4UWMA--.28710S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1DJF18Zr4UAF18GrW8Crg_yoW8uryxpF
        WfCr9xJrn5ZFWavasIqw47C3s5ZwsYqry7K3y293sakr15Z34qqF47G34rXFy5CrWfZ343
        Ar1qkrn7Wa1UZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU1E1v3UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 6/28/2023 9:56 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> To address OOM issue when one cpu is allocating and another cpu is freeing add
> a target bpf_mem_cache hint to allocated objects and when local cpu free_llist
> overflows free to that bpf_mem_cache. The hint addresses the OOM while
> maintaing the same performance for common case when alloc/free are done on the
> same cpu.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>

But have a minor comment for do_call_rcu_ttrace() below.
> ---
>  kernel/bpf/memalloc.c | 46 ++++++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 18 deletions(-)
SNIP
>  static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
> @@ -295,7 +289,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>  		return;
>  
>  	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
> -	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu_ttrace))
> +	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
>  		/* There is no concurrent __llist_add(waiting_for_gp_ttrace) access.
>  		 * It doesn't race with llist_del_all either.
>  		 * But there could be two concurrent llist_del_all(waiting_for_gp_ttrace):
> @@ -312,16 +306,22 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>  	 * If RCU Tasks Trace grace period implies RCU grace period, free
>  	 * these elements directly, else use call_rcu() to wait for normal
>  	 * progs to finish and finally do free_one() on each element.
> +	 *
> +	 * call_rcu_tasks_trace() enqueues to a global queue, so it's ok
> +	 * that current cpu bpf_mem_cache != target bpf_mem_cache.
>  	 */
>  	call_rcu_tasks_trace(&c->rcu_ttrace, __free_rcu_tasks_trace);
"a global queue" in the comment is not accurate. call_rcu_tasks_trace()
will switch between to per-CPU queue when the global queue is too busy
and rcupdate.rcu_task_enqueue_lim in boot cmdline also can be used to
control whether or not a per-CPU queue is used.

