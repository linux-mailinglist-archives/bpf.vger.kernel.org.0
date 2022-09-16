Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C995BA757
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiIPHTX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 03:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIPHTW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 03:19:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAE5A405A
        for <bpf@vger.kernel.org>; Fri, 16 Sep 2022 00:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 282D46289A
        for <bpf@vger.kernel.org>; Fri, 16 Sep 2022 07:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644DCC433C1;
        Fri, 16 Sep 2022 07:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663312760;
        bh=VVgQ/yDYDXtN2TOOKqoH6VFVNuOC04R0IJTuou13n5M=;
        h=From:To:Cc:Subject:Date:From;
        b=pEHRWgvNDuCnPuBexy0IGFJ0HhjJUxrJnwMWwpwitl6M4q+4SRU3dBqiPC7pUddaM
         xwe+pHn64o8nNCL1cMLoRMY2eOsMLdWR1im5bG7Gk2uyiM1WDCQlYYI1Y0G3JYHxXH
         d8xk1aeihe/WBxdcouPfQ1Ygs7lVEnN26A/u7n3Chiv0ZM76svLM8Dw1hWWMj7SAUJ
         A28hAvFzL2s2tSQn2alVGDSi+F83b2tgs4Tmd0EzD25GkSyjxRUzqctqku3a3u9raa
         P2pdEcE37buAzz73uu4hEPrMViYcc5G61Y0ioysY/1cdmztDDtQnffGSY84We5hHBc
         ng0oOGOFzspZw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Stanislav Fomichev <sdf@google.com>,
        syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next] bpf: Prevent bpf program recursion for raw tracepoint probes
Date:   Fri, 16 Sep 2022 09:19:14 +0200
Message-Id: <20220916071914.7156-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We got report from sysbot [1] about warnings that were caused by
bpf program attached to contention_begin raw tracepoint triggering
the same tracepoint by using bpf_trace_printk helper that takes
trace_printk_lock lock.

 Call Trace:
  <TASK>
  ? trace_event_raw_event_bpf_trace_printk+0x5f/0x90
  bpf_trace_printk+0x2b/0xe0
  bpf_prog_a9aec6167c091eef_prog+0x1f/0x24
  bpf_trace_run2+0x26/0x90
  native_queued_spin_lock_slowpath+0x1c6/0x2b0
  _raw_spin_lock_irqsave+0x44/0x50
  bpf_trace_printk+0x3f/0xe0
  bpf_prog_a9aec6167c091eef_prog+0x1f/0x24
  bpf_trace_run2+0x26/0x90
  native_queued_spin_lock_slowpath+0x1c6/0x2b0
  _raw_spin_lock_irqsave+0x44/0x50
  bpf_trace_printk+0x3f/0xe0
  bpf_prog_a9aec6167c091eef_prog+0x1f/0x24
  bpf_trace_run2+0x26/0x90
  native_queued_spin_lock_slowpath+0x1c6/0x2b0
  _raw_spin_lock_irqsave+0x44/0x50
  bpf_trace_printk+0x3f/0xe0
  bpf_prog_a9aec6167c091eef_prog+0x1f/0x24
  bpf_trace_run2+0x26/0x90
  native_queued_spin_lock_slowpath+0x1c6/0x2b0
  _raw_spin_lock_irqsave+0x44/0x50
  __unfreeze_partials+0x5b/0x160
  ...

The can be reproduced by attaching bpf program as raw tracepoint on
contention_begin tracepoint. The bpf prog calls bpf_trace_printk
helper. Then by running perf bench the spin lock code is forced to
take slow path and call contention_begin tracepoint.

Fixing this by skipping execution of the bpf program if it's
already running, Using bpf prog 'active' field, which is being
currently used by trampoline programs for the same reason.

Moving bpf_prog_inc_misses_counter to syscall.c because
trampoline.c is compiled in just for CONFIG_BPF_JIT option.

Reviewed-by: Stanislav Fomichev <sdf@google.com>
Reported-by: syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com
[1] https://lore.kernel.org/bpf/YxhFe3EwqchC%2FfYf@krava/T/#t
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2 changes:
  - moved inc_misses_counter from trampoline to syscall object
    to fix compilation fails found by kernel test robot
  - added Stanislav's ack

 include/linux/bpf.h      |  6 ++++++
 kernel/bpf/syscall.c     | 11 +++++++++++
 kernel/bpf/trampoline.c  | 15 ++-------------
 kernel/trace/bpf_trace.c |  6 ++++++
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54178b9e9c3a..bf17f7883da7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2029,6 +2029,8 @@ static inline bool has_current_bpf_ctx(void)
 {
 	return !!current->bpf_ctx;
 }
+
+void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {
@@ -2251,6 +2253,10 @@ static inline bool has_current_bpf_ctx(void)
 {
 	return false;
 }
+
+static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
+{
+}
 #endif /* CONFIG_BPF_SYSCALL */
 
 void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 69be1c612daa..be7761414308 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2098,6 +2098,17 @@ struct bpf_prog_kstats {
 	u64 misses;
 };
 
+void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog)
+{
+	struct bpf_prog_stats *stats;
+	unsigned int flags;
+
+	stats = this_cpu_ptr(prog->stats);
+	flags = u64_stats_update_begin_irqsave(&stats->syncp);
+	u64_stats_inc(&stats->misses);
+	u64_stats_update_end_irqrestore(&stats->syncp, flags);
+}
+
 static void bpf_prog_get_stats(const struct bpf_prog *prog,
 			       struct bpf_prog_kstats *stats)
 {
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ad76940b02cc..41b67eb83ab3 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -863,17 +863,6 @@ static __always_inline u64 notrace bpf_prog_start_time(void)
 	return start;
 }
 
-static void notrace inc_misses_counter(struct bpf_prog *prog)
-{
-	struct bpf_prog_stats *stats;
-	unsigned int flags;
-
-	stats = this_cpu_ptr(prog->stats);
-	flags = u64_stats_update_begin_irqsave(&stats->syncp);
-	u64_stats_inc(&stats->misses);
-	u64_stats_update_end_irqrestore(&stats->syncp, flags);
-}
-
 /* The logic is similar to bpf_prog_run(), but with an explicit
  * rcu_read_lock() and migrate_disable() which are required
  * for the trampoline. The macro is split into
@@ -896,7 +885,7 @@ u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_tramp_run_ctx *ru
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
 	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
-		inc_misses_counter(prog);
+		bpf_prog_inc_misses_counter(prog);
 		return 0;
 	}
 	return bpf_prog_start_time();
@@ -967,7 +956,7 @@ u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_tramp_r
 	might_fault();
 
 	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
-		inc_misses_counter(prog);
+		bpf_prog_inc_misses_counter(prog);
 		return 0;
 	}
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 68e5cdd24cef..c8cd1aa7b112 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2042,9 +2042,15 @@ static __always_inline
 void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 {
 	cant_sleep();
+	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+		bpf_prog_inc_misses_counter(prog);
+		goto out;
+	}
 	rcu_read_lock();
 	(void) bpf_prog_run(prog, args);
 	rcu_read_unlock();
+out:
+	this_cpu_dec(*(prog->active));
 }
 
 #define UNPACK(...)			__VA_ARGS__
-- 
2.37.3

