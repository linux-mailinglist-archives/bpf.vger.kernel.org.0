Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD65B1BCF
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 13:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiIHLrI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 07:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiIHLrH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 07:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3D911450
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 04:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D01C761BE6
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 11:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7D2C433D6;
        Thu,  8 Sep 2022 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662637625;
        bh=kIZpOa08ce1iTwgyNF9q+imeQ/b6NcGYnc4k+j+Jppo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZQvPIfIbUwYwyYrmMBMrEDDFjqudl1TUMxwNuzo7OFwGFF4NJ/rjGRsm65ha/Dsn3
         FJGWhMKwAbUYQD5my4nlQSwgXMhRGC8yRycLFlSTabRwe5szBY1zC4HcVXGJEDY+qE
         96MQRt0ekV2wzW6heBX7c1/X/PK4coQdud7S5nl3FSA/X9cfAJ6MtqHRde73sdZ3a3
         vHgdLMPCulMcTVSOE3vBSjsA2G9ejujqQEMVtI3Npgg5QGs0C7lgx85fR33G9eliuc
         rVo8OvQO+8miD94ztQzbXkAdXucpafuZte9o2qSinQSvUnIyqWLCW0O+ll2ggShuzP
         nTmH9jWsC5Pzg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next] bpf: Prevent bpf program recursion for raw tracepoint probes
Date:   Thu,  8 Sep 2022 13:46:59 +0200
Message-Id: <20220908114659.102775-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
take slowpath and call contention_begin tracepoint.

Fixing this by skipping execution of the bpf program if it's
already running, Using bpf prog 'active' field, which is being
currently used by trampoline programs for the same reason.

Reported-by: syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com
[1] https://lore.kernel.org/bpf/YxhFe3EwqchC%2FfYf@krava/T/#t
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      | 1 +
 kernel/bpf/trampoline.c  | 6 +++---
 kernel/trace/bpf_trace.c | 6 ++++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 48ae05099f36..4737bd0fcbb8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2640,4 +2640,5 @@ static inline void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype) {}
 static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
 #endif /* CONFIG_BPF_LSM */
 
+void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ad76940b02cc..a098bdc33209 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -863,7 +863,7 @@ static __always_inline u64 notrace bpf_prog_start_time(void)
 	return start;
 }
 
-static void notrace inc_misses_counter(struct bpf_prog *prog)
+void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog)
 {
 	struct bpf_prog_stats *stats;
 	unsigned int flags;
@@ -896,7 +896,7 @@ u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_tramp_run_ctx *ru
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
 	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
-		inc_misses_counter(prog);
+		bpf_prog_inc_misses_counter(prog);
 		return 0;
 	}
 	return bpf_prog_start_time();
@@ -967,7 +967,7 @@ u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_tramp_r
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

