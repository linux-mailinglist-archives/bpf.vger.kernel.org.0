Return-Path: <bpf+bounces-8822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31C278A6DD
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 09:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30A81C203B1
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CC110FE;
	Mon, 28 Aug 2023 07:56:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CAC10F4
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3269C433C7;
	Mon, 28 Aug 2023 07:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693209364;
	bh=pR5JS/inKARSe7OETDLzqfWsQ2FuBZO/YQxCwnmVc/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fDuf85GqGN0QQV0e7MHfYFhSDBEMHvfpepkWZ/58m6CgEoU8d1NWDwQjeDed2LSS9
	 Tx6BzlVx0jkWM3kWjKGvZc37izSsJRUZy0aIibsFr8N9r6Uc3bja4Ouj/DlN0I8jYX
	 Un8SFu9mecODrKZLedtpaaIGYPItjCKBBTTBgQ+sRXzE9Lj1y6WKh8UnL1utbNDygr
	 XzBNRbO02yjVZfddLc5Qh969QZhYkv7LlmgIgTBddh7OPpw+X5w5ztVrKoF80k16G+
	 JqMYfqpI9PxgVasDtnypPffln+W+CZn6HvSaACqUFXVV2FxSMDnXB/K+eaovWh/iBx
	 XifHQGA0wgyhg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCH bpf-next 02/12] bpf: Move bpf_prog_start_time to linux/filter.h
Date: Mon, 28 Aug 2023 09:55:27 +0200
Message-ID: <20230828075537.194192-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828075537.194192-1-jolsa@kernel.org>
References: <20230828075537.194192-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving bpf_prog_start_time to linux/filter.h and making it
globally available.

It will be used by other program types in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     | 20 ++++++++++++++++++++
 kernel/bpf/trampoline.c | 12 ------------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05eece17a989..23a73f52c7bc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -29,6 +29,9 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/static_call.h>
 #include <linux/memcontrol.h>
+#include <linux/sched/clock.h>
+
+DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -2460,6 +2463,18 @@ static inline bool has_current_bpf_ctx(void)
 void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
 void notrace bpf_prog_update_prog_stats(struct bpf_prog *prog, u64 start);
 
+static __always_inline u64 notrace bpf_prog_start_time(void)
+{
+	u64 start = BPF_PROG_NO_START_TIME;
+
+	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
+		start = sched_clock();
+		if (unlikely(!start))
+			start = BPF_PROG_NO_START_TIME;
+	}
+	return start;
+}
+
 void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
@@ -2702,6 +2717,11 @@ static void bpf_prog_update_prog_stats(struct bpf_prog *prog, u64 start)
 {
 }
 
+static inline u64 notrace bpf_prog_start_time(void)
+{
+	return 0;
+}
+
 static inline void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 }
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index a6528e847fae..ed5b014f9532 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -819,18 +819,6 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	mutex_unlock(&trampoline_mutex);
 }
 
-static __always_inline u64 notrace bpf_prog_start_time(void)
-{
-	u64 start = BPF_PROG_NO_START_TIME;
-
-	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
-		start = sched_clock();
-		if (unlikely(!start))
-			start = BPF_PROG_NO_START_TIME;
-	}
-	return start;
-}
-
 /* The logic is similar to bpf_prog_run(), but with an explicit
  * rcu_read_lock() and migrate_disable() which are required
  * for the trampoline. The macro is split into
-- 
2.41.0


