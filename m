Return-Path: <bpf+bounces-3361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0AE73C7A1
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 09:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6761C21254
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 07:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42189EDF;
	Sat, 24 Jun 2023 07:53:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D810E8;
	Sat, 24 Jun 2023 07:53:54 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D193294B;
	Sat, 24 Jun 2023 00:53:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qp5vn1TBjz4f3m8V;
	Sat, 24 Jun 2023 15:53:41 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDHJyICoZZke6P2Lg--.39952S2;
	Sat, 24 Jun 2023 15:53:42 +0800 (CST)
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, daniel@iogearbox.net,
 andrii@kernel.org, void@manifault.com, paulmck@kernel.org
Cc: tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-13-alexei.starovoitov@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <019fe889-34c1-04eb-31a7-50b3cd40b83c@huaweicloud.com>
Date: Sat, 24 Jun 2023 15:53:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230624031333.96597-13-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDHJyICoZZke6P2Lg--.39952S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWUGF1rGw4fGr15trWxXrb_yoW8CF1rpF
	W5GryUGryrJF1fZ34kJanaywn7Zr4fXw1agayrur9Fkr43Xr4FqF9Fkr1Uur93Cw4xCw1S
	vr48Wr9rG3y0vFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
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

On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
> Unlike bpf_mem_[cache_]free() that links objects for immediate reuse into
> per-cpu free list the _rcu() flavor waits for RCU grace period and then moves
> objects into free_by_rcu_ttrace list where they are waiting for RCU
> task trace grace period to be freed into slab.
>
SNIP
> +static void check_free_by_rcu(struct bpf_mem_cache *c)
> +{
> +	struct llist_node *llnode, *t;
> +
> +	if (llist_empty(&c->free_by_rcu) && llist_empty(&c->free_llist_extra_rcu))
> +		return;
> +
> +	/* drain free_llist_extra_rcu */
> +	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra_rcu))
> +		if (__llist_add(llnode, &c->free_by_rcu))
> +			c->free_by_rcu_tail = llnode;

Just like add_obj_to_free_list(),  we should do conditional
local_irq_save(flags) and local_inc_return(&c->active) as well for
free_by_rcu, otherwise free_by_rcu may be corrupted by bpf program
running in a NMI context.
> +
> +	if (atomic_xchg(&c->call_rcu_in_progress, 1)) {
> +		/*
> +		 * Instead of kmalloc-ing new rcu_head and triggering 10k
> +		 * call_rcu() to hit rcutree.qhimark and force RCU to notice
> +		 * the overload just ask RCU to hurry up. There could be many
> +		 * objects in free_by_rcu list.
> +		 * This hint reduces memory consumption for an artifical
> +		 * benchmark from 2 Gbyte to 150 Mbyte.
> +		 */
> +		rcu_request_urgent_qs_task(current);
> +		return;
> +	}
> +
> +	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
> +
> +	WRITE_ONCE(c->waiting_for_gp.first, __llist_del_all(&c->free_by_rcu));
> +	c->waiting_for_gp_tail = c->free_by_rcu_tail;
> +	call_rcu_hurry(&c->rcu, __free_by_rcu);

The same protection is needed for c->free_by_rcu_tail as well.


