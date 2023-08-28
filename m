Return-Path: <bpf+bounces-8827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951EA78A6E3
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60E51C20431
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 07:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA7710FE;
	Mon, 28 Aug 2023 07:56:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0471A10F4
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C823FC433C7;
	Mon, 28 Aug 2023 07:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693209416;
	bh=e200aKIOGeF9W3rX+rXHrcrEZBMT1n+LMXyPUGtYAsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tBsm6mWWa0rFFxZ7wgTlqmSQCqUFHYu6CdrTcitxywKL5RixgZLdhNqo9Fm5VItE8
	 jOsI0NYWj6pVTlSrhnqLWxLtR634DMY4+ZGBLGggJvD0lu0t1AIkrMmvoYHOePwGsm
	 UQENFCy6Rt2OBmPVQL0o2OA0f3QPrPL3C4yGdvsrzBWb8HqwFYvpgAkNzG1dUJCo7o
	 yIzQaZFempi+gOpBQbkxLQe07wlw8DCpnfsP9gvgvR3tIzFpBYi4NDtgquysSnPWGC
	 wXilM04gEniVLlmPE6vB7A3KlLdiM0cdU1+iwJ6SSm1NvNSn4v+wtbnDvsLptInRXS
	 I+1OrbC/KEScw==
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
Subject: [PATCH bpf-next 07/12] bpf: Move bpf_prog_run_array down in the header file
Date: Mon, 28 Aug 2023 09:55:32 +0200
Message-ID: <20230828075537.194192-8-jolsa@kernel.org>
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

Moving bpf_prog_run_array down in the header file so we can
easily use bpf_prog_start_time and bpf_prog_update_prog_stats
functions in bpf_prog_run_array in following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h | 60 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 71154e991730..478fdc4794c9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1904,36 +1904,6 @@ static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
 
 typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
 
-static __always_inline u32
-bpf_prog_run_array(const struct bpf_prog_array *array,
-		   const void *ctx, bpf_prog_run_fn run_prog)
-{
-	const struct bpf_prog_array_item *item;
-	const struct bpf_prog *prog;
-	struct bpf_run_ctx *old_run_ctx;
-	struct bpf_trace_run_ctx run_ctx;
-	u32 ret = 1;
-
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
-
-	if (unlikely(!array))
-		return ret;
-
-	run_ctx.is_uprobe = false;
-
-	migrate_disable();
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
-	item = &array->items[0];
-	while ((prog = READ_ONCE(item->prog))) {
-		run_ctx.bpf_cookie = item->bpf_cookie;
-		ret &= run_prog(prog, ctx);
-		item++;
-	}
-	bpf_reset_run_ctx(old_run_ctx);
-	migrate_enable();
-	return ret;
-}
-
 /* Notes on RCU design for bpf_prog_arrays containing sleepable programs:
  *
  * We use the tasks_trace rcu flavor read section to protect the bpf_prog_array
@@ -2740,6 +2710,36 @@ static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
+static __always_inline u32
+bpf_prog_run_array(const struct bpf_prog_array *array,
+		   const void *ctx, bpf_prog_run_fn run_prog)
+{
+	const struct bpf_prog_array_item *item;
+	const struct bpf_prog *prog;
+	struct bpf_run_ctx *old_run_ctx;
+	struct bpf_trace_run_ctx run_ctx;
+	u32 ret = 1;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
+
+	if (unlikely(!array))
+		return ret;
+
+	run_ctx.is_uprobe = false;
+
+	migrate_disable();
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	item = &array->items[0];
+	while ((prog = READ_ONCE(item->prog))) {
+		run_ctx.bpf_cookie = item->bpf_cookie;
+		ret &= run_prog(prog, ctx);
+		item++;
+	}
+	bpf_reset_run_ctx(old_run_ctx);
+	migrate_enable();
+	return ret;
+}
+
 static __always_inline int
 bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
 {
-- 
2.41.0


