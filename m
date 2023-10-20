Return-Path: <bpf+bounces-12778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 407007D0635
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 03:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E715B214F5
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 01:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B490F811;
	Fri, 20 Oct 2023 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DA764D
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 01:41:23 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7DCD66
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 18:41:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SBS3K5ww9z4f3kkg
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 09:41:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAnt9ar2jFlqF+2DQ--.48939S5;
	Fri, 20 Oct 2023 09:41:03 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hsin-Wei Hung <hsinweih@uci.edu>,
	houtao1@huawei.com
Subject: [PATCH bpf v2 1/2] bpf: Check map->usercnt again after timer->timer is assigned
Date: Fri, 20 Oct 2023 09:42:13 +0800
Message-Id: <20231020014214.2471419-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231020014214.2471419-1-houtao@huaweicloud.com>
References: <20231020014214.2471419-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnt9ar2jFlqF+2DQ--.48939S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1DKF4UtFyDtF45XrWkWFg_yoW5Cw47pF
	s3JayIkr18XwsxAr4DJF1kua4rA395Gwn8GF1ku343uFs3WrsIyFyUtF1agFW3Jr4xtFWa
	vF409rs0gryDJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

From: Hou Tao <houtao1@huawei.com>

When there are concurrent uref release and bpf timer init operations,
the following sequence diagram is possible and it will lead to memory
leak:

bpf program X

bpf_timer_init()
  lock timer->lock
    read timer->timer as NULL
    read map->usercnt != 0

                process Y

                close(map_fd)
                  // put last uref
                  bpf_map_put_uref()
                    atomic_dec_and_test(map->usercnt)
                      array_map_free_timers()
                        bpf_timer_cancel_and_free()
                          // just return and lead to memory leak
                          read timer->timer is NULL

    t = bpf_map_kmalloc_node()
    timer->timer = t
  unlock timer->lock

Fix the problem by checking map->usercnt again after timer->timer is
assigned, so when there are concurrent uref release and bpf timer init,
either bpf_timer_cancel_and_free() from uref release reads a no-NULL
timer and the newly-added check of map->usercnt reads a zero usercnt.

Because atomic_dec_and_test(map->usercnt) and READ_ONCE(timer->timer)
in bpf_timer_cancel_and_free() are not protected by a lock, so add
a memory barrier to guarantee the order between map->usercnt and
timer->timer. Also use WRITE_ONCE(timer->timer, x) to match the lockless
read of timer->timer.

Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
Closes: https://lore.kernel.org/bpf/CABcoxUaT2k9hWsS1tNgXyoU3E-=PuOgMn737qK984fbFmfYixQ@mail.gmail.com
Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/helpers.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 757b99c1e613f..a7d92c3ddc3dd 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1156,7 +1156,7 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 	   u64, flags)
 {
 	clockid_t clockid = flags & (MAX_CLOCKS - 1);
-	struct bpf_hrtimer *t;
+	struct bpf_hrtimer *t, *to_free = NULL;
 	int ret = 0;
 
 	BUILD_BUG_ON(MAX_CLOCKS != 16);
@@ -1197,9 +1197,21 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 	rcu_assign_pointer(t->callback_fn, NULL);
 	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
 	t->timer.function = bpf_timer_cb;
-	timer->timer = t;
+	WRITE_ONCE(timer->timer, t);
+	/* Guarantee order between timer->timer and map->usercnt. So when
+	 * there are concurrent uref release and bpf timer init, either
+	 * bpf_timer_cancel_and_free() called by uref release reads a no-NULL
+	 * timer or atomic64_read() below reads a zero usercnt.
+	 */
+	smp_mb();
+	if (!atomic64_read(&map->usercnt)) {
+		WRITE_ONCE(timer->timer, NULL);
+		to_free = t;
+		ret = -EPERM;
+	}
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
+	kfree(to_free);
 	return ret;
 }
 
@@ -1372,7 +1384,7 @@ void bpf_timer_cancel_and_free(void *val)
 	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
 	 * this timer, since it won't be initialized.
 	 */
-	timer->timer = NULL;
+	WRITE_ONCE(timer->timer, NULL);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	if (!t)
-- 
2.29.2


