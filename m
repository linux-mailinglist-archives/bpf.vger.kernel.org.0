Return-Path: <bpf+bounces-3632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A46740813
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 04:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D8A2811FA
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 02:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0E1C37;
	Wed, 28 Jun 2023 02:03:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA115A0;
	Wed, 28 Jun 2023 02:03:43 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C65297C;
	Tue, 27 Jun 2023 19:03:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QrPy32VgZz4f3pFp;
	Wed, 28 Jun 2023 10:03:39 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgD31dP4lJtktNZ5Mg--.2504S2;
	Wed, 28 Jun 2023 10:03:40 +0800 (CST)
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@meta.com>, Tejun Heo <tj@kernel.org>,
 rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, David Vernet <void@manifault.com>,
 Andrii Nakryiko <andrii@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-13-alexei.starovoitov@gmail.com>
 <bfb3cbff-2837-156c-c240-5cf0a046ed38@huaweicloud.com>
 <3410a621-afc7-ba7b-47b8-b64e35f5a8fa@meta.com>
 <9e714217-e054-635d-a580-b677992385e5@huaweicloud.com>
 <CAADnVQJEzv-9ovAOJzaoN0+52iPTbce8QWHcpGmmMm3_93kw-w@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <63b6c8e9-e9fd-df77-c652-5508be367416@huaweicloud.com>
Date: Wed, 28 Jun 2023 10:03:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJEzv-9ovAOJzaoN0+52iPTbce8QWHcpGmmMm3_93kw-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgD31dP4lJtktNZ5Mg--.2504S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy8XF47KF4kCr4UKry5XFb_yoW8trW7pF
	y8Jry8JrWUJF1xJr17Jr18ZFy3Jw1UJa4UJa48AFy2yw13trn0qFWkWr1S9ry5Ar4kGw15
	JFW5XF1UZr4UXr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/28/2023 9:51 AM, Alexei Starovoitov wrote:
> On Tue, Jun 27, 2023 at 6:43 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>
SNIP
>>> re: draining.
>>> I'll switch to do if (draing) free_all; else call_rcu; scheme
>>> to address potential memory leak though I wasn't able to repro it.
>> For v2, it was also hard for me to reproduce the leak problem. But after
>> I injected some delay by using udelay() in __free_by_rcu/__free_rcu()
>> after reading c->draining, it was relatively easy to reproduce the problems.
> 1. Please respin htab bench.
> We're still discussing patching without having the same base line.
Almost done. Need to do benchmark again to update the numbers in commit
message.
>
> 2. 'adding udelay()' is too vague. Pls post a diff hunk of what exactly
> you mean.

--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -4,6 +4,7 @@
 #include <linux/llist.h>
 #include <linux/bpf.h>
 #include <linux/irq_work.h>
+#include <linux/delay.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
 #include <asm/local.h>
@@ -261,12 +262,17 @@ static int free_all(struct llist_node *llnode,
bool percpu)
        return cnt;
 }

+static unsigned int delay;
+module_param(delay, uint, 0644);
+
 static void __free_rcu(struct rcu_head *head)
 {
        struct bpf_mem_cache *c = container_of(head, struct
bpf_mem_cache, rcu_ttrace);

        if (unlikely(READ_ONCE(c->draining)))
                goto out;
+       if (delay)
+               udelay(delay);
        free_all(llist_del_all(&c->waiting_for_gp_ttrace),
!!c->percpu_size);
 out:
        atomic_set(&c->call_rcu_ttrace_in_progress, 0);
@@ -361,6 +367,8 @@ static void __free_by_rcu(struct rcu_head *head)

        if (unlikely(READ_ONCE(c->draining)))
                goto out;
+       if (delay)
+               udelay(delay);

        llnode = llist_del_all(&c->waiting_for_gp);
        if (!llnode)

>
> 3. I'll send v3 shortly. Let's move discussion there.
Sure.


