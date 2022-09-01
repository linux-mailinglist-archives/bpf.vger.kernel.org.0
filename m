Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539745A8DE3
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 08:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiIAGBm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 02:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiIAGBj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 02:01:39 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6B4E2C55
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 23:01:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MJ9P36hVLz6S9sZ
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 13:59:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHGXO5ShBjaMHaAA--.4132S5;
        Thu, 01 Sep 2022 14:01:32 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: [PATCH bpf-next v2 1/4] bpf: Use this_cpu_{inc|dec|inc_return} for bpf_task_storage_busy
Date:   Thu,  1 Sep 2022 14:19:35 +0800
Message-Id: <20220901061938.3789460-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220901061938.3789460-1-houtao@huaweicloud.com>
References: <20220901061938.3789460-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHGXO5ShBjaMHaAA--.4132S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1UWF47tw4DJFWfXF4DXFb_yoW5JF1xpr
        WxtF98Arn8K3Z5Za98Jw4xAryDJw1kWw47Ka98Cr93tan7tr98Wr1xtr1IvF9Ig34rXF13
        Zan0gFyY9r17XFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Now migrate_disable() does not disable preemption and under some
architectures (e.g. arm64) __this_cpu_{inc|dec|inc_return} are neither
preemption-safe nor IRQ-safe, so for fully preemptible kernel concurrent
lookups or updates on the same task local storage and on the same CPU
may make bpf_task_storage_busy be imbalanced, and
bpf_task_storage_trylock() on the specific cpu will always fail.

Fixing it by using this_cpu_{inc|dec|inc_return} when manipulating
bpf_task_storage_busy.

Fixes: bc235cdb423a ("bpf: Prevent deadlock from recursive bpf_task_storage_[get|delete]")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_local_storage.c | 4 ++--
 kernel/bpf/bpf_task_storage.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 4ee2e7286c23..802fc15b0d73 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -555,11 +555,11 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
 				struct bpf_local_storage_elem, map_node))) {
 			if (busy_counter) {
 				migrate_disable();
-				__this_cpu_inc(*busy_counter);
+				this_cpu_inc(*busy_counter);
 			}
 			bpf_selem_unlink(selem, false);
 			if (busy_counter) {
-				__this_cpu_dec(*busy_counter);
+				this_cpu_dec(*busy_counter);
 				migrate_enable();
 			}
 			cond_resched_rcu();
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index e9014dc62682..6f290623347e 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -26,20 +26,20 @@ static DEFINE_PER_CPU(int, bpf_task_storage_busy);
 static void bpf_task_storage_lock(void)
 {
 	migrate_disable();
-	__this_cpu_inc(bpf_task_storage_busy);
+	this_cpu_inc(bpf_task_storage_busy);
 }
 
 static void bpf_task_storage_unlock(void)
 {
-	__this_cpu_dec(bpf_task_storage_busy);
+	this_cpu_dec(bpf_task_storage_busy);
 	migrate_enable();
 }
 
 static bool bpf_task_storage_trylock(void)
 {
 	migrate_disable();
-	if (unlikely(__this_cpu_inc_return(bpf_task_storage_busy) != 1)) {
-		__this_cpu_dec(bpf_task_storage_busy);
+	if (unlikely(this_cpu_inc_return(bpf_task_storage_busy) != 1)) {
+		this_cpu_dec(bpf_task_storage_busy);
 		migrate_enable();
 		return false;
 	}
-- 
2.29.2

