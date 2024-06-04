Return-Path: <bpf+bounces-31377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91C08FBCEE
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 22:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9B728558F
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2F914B091;
	Tue,  4 Jun 2024 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHXZ/hjq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE214149E08;
	Tue,  4 Jun 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531395; cv=none; b=bGAhEURi20ayJrNvOc6MsGDd3xg9DJOKfJA3HzKe2L9v/4Exsc0fxyLJbKhO8d4xn6cHhWq+zsBS+f7mQPIGpDloeeXTFL7PFUUmvVraniMbBGgsoUTUlkTKwIHw5V/BGi7ce1huu2Aq4vvDKpPgmHzW2h1gVUN83VRiKvbV+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531395; c=relaxed/simple;
	bh=E3gFFQnUuz21l8S5zyXAsshddo/NRWyVXSgE9gUIth0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyK0JVoldzMaKteVWJl0HGfPa67L9YVGKTvtLo59b3hLvyuiRIbjr2OtB/sWGco1y+b1YieS0aBvkXQ8ut0E14JXiof6X82RQsJdLrwBl+WA9EnEfnM6ArQYp/yYPMl+g6Q/yaluJ1ryj+3yMPFHXWM5W+G1E/CiYOro2MQq6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHXZ/hjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D40C2BBFC;
	Tue,  4 Jun 2024 20:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531394;
	bh=E3gFFQnUuz21l8S5zyXAsshddo/NRWyVXSgE9gUIth0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHXZ/hjqnq8YzJ7xKFngyTERrSzaC73vAZ2Oixb/Z88JRX7kzp6a6iNY2OQFPLjsV
	 QfoDjEd+XoBV78YiCxav4VMZ3OE2Vphx5jcm5OagIeNoJq1C+/tvLfslSWKtI5QCJo
	 Qc385ThLJ3muo77HFi2MoZ7qv6Ay9OuwmfX+GTUCL3RU1s7RFv0B9q/R8FoxekdwCf
	 aqbojtaKmMbs8Q26jT5UdnNzUo+1BZIUPhzu7ni0QID+27KwKzAE1N2kkmQ6f/Ea7Z
	 NlCOTOZQhjZbYDSSswHNe4KdYtiq3TTpFjUIKrgTFGVMbKki3wAYurAsOly+InONXQ
	 +z0CBa0dHYgiw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC bpf-next 03/10] bpf: Add support for uprobe multi session context
Date: Tue,  4 Jun 2024 22:02:14 +0200
Message-ID: <20240604200221.377848-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604200221.377848-1-jolsa@kernel.org>
References: <20240604200221.377848-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Placing bpf_session_run_ctx layer in between bpf_run_ctx and
bpf_uprobe_multi_run_ctx, so the session data can be retrieved
from uprobe_multi link.

Plus granting session kfuncs access to uprobe session programs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 53b111c8e887..4392807ee8d9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3181,7 +3181,7 @@ struct bpf_uprobe_multi_link {
 };
 
 struct bpf_uprobe_multi_run_ctx {
-	struct bpf_run_ctx run_ctx;
+	struct bpf_session_run_ctx session_ctx;
 	unsigned long entry_ip;
 	struct bpf_uprobe *uprobe;
 };
@@ -3294,10 +3294,15 @@ static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
 
 static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 			   unsigned long entry_ip,
-			   struct pt_regs *regs)
+			   struct pt_regs *regs,
+			   bool is_return, void *data)
 {
 	struct bpf_uprobe_multi_link *link = uprobe->link;
 	struct bpf_uprobe_multi_run_ctx run_ctx = {
+		.session_ctx = {
+			.is_return = is_return,
+			.data = data,
+		},
 		.entry_ip = entry_ip,
 		.uprobe = uprobe,
 	};
@@ -3316,7 +3321,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 
 	migrate_disable();
 
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 
@@ -3345,7 +3350,7 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
 	struct bpf_uprobe *uprobe;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	return uprobe_prog_run(uprobe, instruction_pointer(regs), regs, false, NULL);
 }
 
 static int
@@ -3354,7 +3359,7 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
 	struct bpf_uprobe *uprobe;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	return uprobe_prog_run(uprobe, func, regs);
+	return uprobe_prog_run(uprobe, func, regs, true, NULL);
 }
 
 static int
@@ -3364,7 +3369,7 @@ uprobe_multi_link_handler_session(struct uprobe_consumer *con, struct pt_regs *r
 	struct bpf_uprobe *uprobe;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	return uprobe_prog_run(uprobe, instruction_pointer(regs), regs, false, data);
 }
 
 static int
@@ -3374,14 +3379,14 @@ uprobe_multi_link_ret_handler_session(struct uprobe_consumer *con, unsigned long
 	struct bpf_uprobe *uprobe;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	return uprobe_prog_run(uprobe, func, regs);
+	return uprobe_prog_run(uprobe, func, regs, true, data);
 }
 
 static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 {
 	struct bpf_uprobe_multi_run_ctx *run_ctx;
 
-	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
+	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, session_ctx.run_ctx);
 	return run_ctx->entry_ip;
 }
 
@@ -3389,7 +3394,7 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
 {
 	struct bpf_uprobe_multi_run_ctx *run_ctx;
 
-	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
+	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, session_ctx.run_ctx);
 	return run_ctx->uprobe->cookie;
 }
 
@@ -3586,7 +3591,8 @@ static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
 		return 0;
 
-	if (!is_kprobe_session(prog))
+	if (!is_kprobe_session(prog) &&
+	    !is_uprobe_session(prog))
 		return -EACCES;
 
 	return 0;
-- 
2.45.1


