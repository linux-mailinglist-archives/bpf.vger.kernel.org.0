Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD1B5A8DE4
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 08:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiIAGBm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 02:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiIAGBj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 02:01:39 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8993E3433
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 23:01:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MJ9PL6MqLzlDy6
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 14:00:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHGXO5ShBjaMHaAA--.4132S6;
        Thu, 01 Sep 2022 14:01:33 +0800 (CST)
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
Subject: [PATCH bpf-next v2 2/4] bpf: Use this_cpu_{inc_return|dec} for prog->active
Date:   Thu,  1 Sep 2022 14:19:36 +0800
Message-Id: <20220901061938.3789460-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220901061938.3789460-1-houtao@huaweicloud.com>
References: <20220901061938.3789460-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHGXO5ShBjaMHaAA--.4132S6
X-Coremail-Antispam: 1UD129KBjvJXoW7CF45WryUZw18XF18Kw43trb_yoW8uryfpF
        W8trykCw48ta1DJa45Aw4UCry3AFZ5WryxWFW8G34Fv3WF9rZ5G3WxKFyIgryY9ryfuryf
        Zw4qvay2vFWxurDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
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

Both __this_cpu_inc_return() and __this_cpu_dec() are not preemption
safe and now migrate_disable() doesn't disable preemption, so the update
of prog-active is not atomic and in theory under fully preemptible kernel
recurisve prevention may do not work.

Fixing by using the preemption-safe and IRQ-safe variants.

Fixes: ca06f55b9002 ("bpf: Add per-program recursion prevention mechanism")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/trampoline.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ff87e38af8a7..ad76940b02cc 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -895,7 +895,7 @@ u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_tramp_run_ctx *ru
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
-	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {
+	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
 		inc_misses_counter(prog);
 		return 0;
 	}
@@ -930,7 +930,7 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bpf_tramp_
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
-	__this_cpu_dec(*(prog->active));
+	this_cpu_dec(*(prog->active));
 	migrate_enable();
 	rcu_read_unlock();
 }
@@ -966,7 +966,7 @@ u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_tramp_r
 	migrate_disable();
 	might_fault();
 
-	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {
+	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
 		inc_misses_counter(prog);
 		return 0;
 	}
@@ -982,7 +982,7 @@ void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
-	__this_cpu_dec(*(prog->active));
+	this_cpu_dec(*(prog->active));
 	migrate_enable();
 	rcu_read_unlock_trace();
 }
-- 
2.29.2

