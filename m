Return-Path: <bpf+bounces-13588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7497DB368
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 07:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 308EAB20C26
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 06:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7D92116;
	Mon, 30 Oct 2023 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6411C11
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 06:35:15 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8F103
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 23:35:11 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SJk616qDLz4f3mVq
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:35:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0750F1A0171
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:35:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3jd2XTj9luKVdEQ--.16546S4;
	Mon, 30 Oct 2023 14:35:05 +0800 (CST)
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
Subject: [PATCH bpf-next v3] bpf: Check map->usercnt after timer->timer is assigned
Date: Mon, 30 Oct 2023 14:36:16 +0800
Message-Id: <20231030063616.1653024-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3jd2XTj9luKVdEQ--.16546S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWryUXFWxCry8XFyDtr1xGrg_yoWrZFyfpF
	sxJaySkr48Xrs8Zr4kJF1kWa4rA395Gw1UGr1kW34fuFsrWFsIyFy0qFy3WFZxJr1xWF4a
	yF4vvrZ8K34UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When there are concurrent uref release and bpf timer init operations,
the following sequence diagram is possible. It will break the guarantee
provided by bpf_timer: bpf_timer will still be alive after userspace
application releases or unpins the map. It also will lead to kmemleak
for old kernel version which doesn't release bpf_timer when map is
released.

bpf program X:

bpf_timer_init()
  lock timer->lock
    read timer->timer as NULL
    read map->usercnt != 0

                process Y:

                close(map_fd)
                  // put last uref
                  bpf_map_put_uref()
                    atomic_dec_and_test(map->usercnt)
                      array_map_free_timers()
                        bpf_timer_cancel_and_free()
                          // just return
                          read timer->timer is NULL

    t = bpf_map_kmalloc_node()
    timer->timer = t
  unlock timer->lock

Fix the problem by checking map->usercnt after timer->timer is assigned,
so when there are concurrent uref release and bpf timer init, either
bpf_timer_cancel_and_free() from uref release reads a no-NULL timer
or the newly-added atomic64_read() returns a zero usercnt.

Because atomic_dec_and_test(map->usercnt) and READ_ONCE(timer->timer)
in bpf_timer_cancel_and_free() are not protected by a lock, so add
a memory barrier to guarantee the order between map->usercnt and
timer->timer. Also use WRITE_ONCE(timer->timer, x) to match the lockless
read of timer->timer in bpf_timer_cancel_and_free().

Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
Closes: https://lore.kernel.org/bpf/CABcoxUaT2k9hWsS1tNgXyoU3E-=PuOgMn737qK984fbFmfYixQ@mail.gmail.com
Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
v3:
 * patch #1: only check map->usercnt once and call kfree() with
             spin-lock acquired in error handling path (Alexei)
             update the commit messsage to explain that the patch only
             fixes the broken-guarantee problem for bpf_timer. The
             kmemleak problem will be fixed by another patchset.
 * patch #2: remove the selftest patch because it demonstrates the
             use-after-free problem for map-in-map and the kmemleak
             problem is just the superficial phenomenon. It will be
             re-added and refined in another patchset.

v2: https://lore.kernel.org/bpf/20231020014214.2471419-1-houtao@huaweicloud.com
  * patch #1: use smp_mb() instead of smp_mb__before_atomic()
  * patch #2: use WRITE_ONCE(timer->timer, x) to match the lockless read
              of timer->timer

v1: https://lore.kernel.org/bpf/20231017125717.241101-1-houtao@huaweicloud.com

 kernel/bpf/helpers.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e46ac288a1080..aed93df5c8aa0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1177,13 +1177,6 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 		ret = -EBUSY;
 		goto out;
 	}
-	if (!atomic64_read(&map->usercnt)) {
-		/* maps with timers must be either held by user space
-		 * or pinned in bpffs.
-		 */
-		ret = -EPERM;
-		goto out;
-	}
 	/* allocate hrtimer via map_kmalloc to use memcg accounting */
 	t = bpf_map_kmalloc_node(map, sizeof(*t), GFP_ATOMIC, map->numa_node);
 	if (!t) {
@@ -1196,7 +1189,21 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 	rcu_assign_pointer(t->callback_fn, NULL);
 	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
 	t->timer.function = bpf_timer_cb;
-	timer->timer = t;
+	WRITE_ONCE(timer->timer, t);
+	/* Guarantee the order between timer->timer and map->usercnt. So
+	 * when there are concurrent uref release and bpf timer init, either
+	 * bpf_timer_cancel_and_free() called by uref release reads a no-NULL
+	 * timer or atomic64_read() below returns a zero usercnt.
+	 */
+	smp_mb();
+	if (!atomic64_read(&map->usercnt)) {
+		/* maps with timers must be either held by user space
+		 * or pinned in bpffs.
+		 */
+		WRITE_ONCE(timer->timer, NULL);
+		kfree(t);
+		ret = -EPERM;
+	}
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	return ret;
@@ -1374,7 +1381,7 @@ void bpf_timer_cancel_and_free(void *val)
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


