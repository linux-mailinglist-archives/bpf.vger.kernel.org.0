Return-Path: <bpf+bounces-67184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25999B40712
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6897544806
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19982E040B;
	Tue,  2 Sep 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO+ypgHn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A242313538;
	Tue,  2 Sep 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823737; cv=none; b=qNtTLb9ywZjmw9YVPZFzUrsPT0cmiYWpc5WtgcnHrar3pjU+p3nU4KijnfxMa59B2GCNGv3fHG0HA+nsyu+Z9Yt2ulMmYdbXopUnvcpQzMMdV35tSBDc/8xlfPn3P1HVGk1RRlyH8vIBvGV4YaOCnTBRSZ56F34GbkSML5zONI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823737; c=relaxed/simple;
	bh=UXYiSTNdvGRRIKwbtj+YYd94kdNwShC5KeHjHnOGO/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fR5vxqXOVl+1wm8fW3wjB0ltQ11GBqfbYOV6j7j1UGialyDJCK3m3yDguEv2UuaX4+BpwJOnWxIGMcsOBv1AOkGL4IswIXBvkLnuaEtK3PUuVReKqyhLHGsoxY5Ssr5S2+7TQDFCYZJGMHZYQ5b7GFXFns6Tf8MKbQBT/qifLM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO+ypgHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83987C4CEED;
	Tue,  2 Sep 2025 14:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823737;
	bh=UXYiSTNdvGRRIKwbtj+YYd94kdNwShC5KeHjHnOGO/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QO+ypgHn86/YE53znM/cNDWDF7eXK0lZ/ce692MfM6qZADLXqnWh3b5vRXj6g3jTP
	 Wppu5qAtadCXEcBaTpE4VoRjEJCn6osOdn4GKoKYmnZ5d8V72HtRPrs8KZl3Spk6nf
	 uoxBqLuHeOdZIsJ/msv6eQT0MipuhX/93Btng2aD3x4+Pfp1uLhXeZ16ZVYAzkza1V
	 rdBctkL9i+PKTubz8ER4KrIa4mKPOpkZrnNU5uq23Z6K8q+KGUopaokiqyz4pGjivd
	 EqLl6d9zD8hXdCGRyXsjoYfO08rDkmFYtiIfoGPF0BZ6BNf8PGyjMVS/ujAidC8bbW
	 edMlz5Z01Q/Aw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH perf/core 02/11] uprobes: Skip emulate/sstep on unique uprobe when ip is changed
Date: Tue,  2 Sep 2025 16:34:55 +0200
Message-ID: <20250902143504.1224726-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902143504.1224726-1-jolsa@kernel.org>
References: <20250902143504.1224726-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If uprobe consumer changes instruction pointer we still execute
(single step or emulate) the original instruction and increment
the ip register with the size of the instruction.

In case the instruction is emulated, the new ip register value is
incremented with the instructions size and process is likely to
crash with illegal instruction.

In case the instruction is single-stepped, the ip register change
is lost and process continues with the original ip register value.

If user decided to take execution elsewhere, it makes little sense
to execute the original instruction, so let's skip it. Allowing this
behaviour only for uprobe with unique consumer attached.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index b9b088f7333a..da8291941c6b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2568,7 +2568,7 @@ static bool ignore_ret_handler(int rc)
 	return rc == UPROBE_HANDLER_REMOVE || rc == UPROBE_HANDLER_IGNORE;
 }
 
-static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
+static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs, bool *is_unique)
 {
 	struct uprobe_consumer *uc;
 	bool has_consumers = false, remove = true;
@@ -2582,6 +2582,9 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 		__u64 cookie = 0;
 		int rc = 0;
 
+		if (is_unique)
+			*is_unique |= uc->is_unique;
+
 		if (uc->handler) {
 			rc = uc->handler(uc, regs, &cookie);
 			WARN(rc < 0 || rc > 2,
@@ -2735,6 +2738,7 @@ static void handle_swbp(struct pt_regs *regs)
 {
 	struct uprobe *uprobe;
 	unsigned long bp_vaddr;
+	bool is_unique = false;
 	int is_swbp;
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
@@ -2789,7 +2793,10 @@ static void handle_swbp(struct pt_regs *regs)
 	if (arch_uprobe_ignore(&uprobe->arch, regs))
 		goto out;
 
-	handler_chain(uprobe, regs);
+	handler_chain(uprobe, regs, &is_unique);
+
+	if (is_unique && instruction_pointer(regs) != bp_vaddr)
+		goto out;
 
 	/* Try to optimize after first hit. */
 	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
@@ -2819,7 +2826,7 @@ void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr)
 		return;
 	if (arch_uprobe_ignore(&uprobe->arch, regs))
 		return;
-	handler_chain(uprobe, regs);
+	handler_chain(uprobe, regs, NULL);
 }
 
 /*
-- 
2.51.0


