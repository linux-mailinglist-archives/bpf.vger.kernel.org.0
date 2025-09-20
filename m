Return-Path: <bpf+bounces-69043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37185B8BBD5
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3347BEB93
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A282624C669;
	Sat, 20 Sep 2025 00:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieMb7Awi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20666246BD8;
	Sat, 20 Sep 2025 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329984; cv=none; b=FOox9i/5x3Zh327jLjZnlM88gYgAN10+ktq07qhmu48mD8T0M7KFlHFXYnqwtCG4dQAkCrc33XfVyz1fBc9yBbr+aEqQoN9fJXewDIWiYwIkcMdIjwFzdg3THN7XA90+3ZFkb2p8KepulLvnTC7NgxYTgl4zF/l9V10Muz0QrVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329984; c=relaxed/simple;
	bh=sKB4bCRqrQ6QNUoiR1E0P3ED5YCM9T/aWEA+L5rnn/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyfL576cshJM/XRniIOijxdjwLp8h9vDZeLclsKAt5N2+bMZfRBvg8VOHpZ6R2XC5GJlPSk9ET3TkpQ9/i08j/xdmvShXf3cYIuOn6Br8SeyNT17kM5rOxf5LFK9mh7p5JU/GhNTwU3Y3RyeWdQEFDPv8X3mKExJZYorhyp1by8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieMb7Awi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846CCC4CEF9;
	Sat, 20 Sep 2025 00:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329983;
	bh=sKB4bCRqrQ6QNUoiR1E0P3ED5YCM9T/aWEA+L5rnn/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ieMb7AwiGPv0qKet80KrwGYaLQZwFhkJc3uoGW3Hkrh3rmH9hfMvI0+B+znf9jksd
	 0Es4Bpa8IyEMaZYTdhtzZU5Uo5KBVaVNhcrjAoBrAVZmQHOLXVsQnGTb89xLvR/y/n
	 msi1aOFNYkjyrwrCb8pXjIiW9zG4uejl5mgBxlpKFHoKPH+0ZxY3zmpE5JtPXaLw1j
	 fsEtphtsnoNkrSPBOItcB/7JzKmofO2RbXXWadz/ozhaHDyAYC4WemMyGfM6uEsT82
	 9YNdsLQ6ssUyftW/bt+OFuxMyzS48ZUf10ry7G5wplGKtjDsNNogIsZpuJZ2YlT1jr
	 HKiRYrbgq+sGg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/46] sched_ext: Add the @sch parameter to __bstr_format()
Date: Fri, 19 Sep 2025 14:58:32 -1000
Message-ID: <20250920005931.2753828-10-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for multiple scheduler support, add the @sch parameter to
__bstr_format() and update the callers to read $scx_root, verify that it's
not NULL and pass it in. The passed in @sch parameter is not used yet.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 560ac5a575bd..373146154829 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6063,8 +6063,9 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
 
 __bpf_kfunc_end_defs();
 
-static s32 __bstr_format(u64 *data_buf, char *line_buf, size_t line_size,
-			 char *fmt, unsigned long long *data, u32 data__sz)
+static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
+			 size_t line_size, char *fmt, unsigned long long *data,
+			 u32 data__sz)
 {
 	struct bpf_bprintf_data bprintf_data = { .get_bin_args = true };
 	s32 ret;
@@ -6099,10 +6100,10 @@ static s32 __bstr_format(u64 *data_buf, char *line_buf, size_t line_size,
 	return ret;
 }
 
-static s32 bstr_format(struct scx_bstr_buf *buf,
+static s32 bstr_format(struct scx_sched *sch, struct scx_bstr_buf *buf,
 		       char *fmt, unsigned long long *data, u32 data__sz)
 {
-	return __bstr_format(buf->data, buf->line, sizeof(buf->line),
+	return __bstr_format(sch, buf->data, buf->line, sizeof(buf->line),
 			     fmt, data, data__sz);
 }
 
@@ -6121,10 +6122,13 @@ __bpf_kfunc_start_defs();
 __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
 				   unsigned long long *data, u32 data__sz)
 {
+	struct scx_sched *sch;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
-	if (bstr_format(&scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
+	sch = rcu_dereference_bh(scx_root);
+	if (likely(sch) &&
+	    bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
 		scx_kf_exit(SCX_EXIT_UNREG_BPF, exit_code, "%s", scx_exit_bstr_buf.line);
 	raw_spin_unlock_irqrestore(&scx_exit_bstr_buf_lock, flags);
 }
@@ -6141,10 +6145,13 @@ __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
 __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
 				    u32 data__sz)
 {
+	struct scx_sched *sch;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
-	if (bstr_format(&scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
+	sch = rcu_dereference_bh(scx_root);
+	if (likely(sch) &&
+	    bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
 		scx_kf_exit(SCX_EXIT_ERROR_BPF, 0, "%s", scx_exit_bstr_buf.line);
 	raw_spin_unlock_irqrestore(&scx_exit_bstr_buf_lock, flags);
 }
@@ -6164,17 +6171,24 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
 __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
 				   u32 data__sz)
 {
+	struct scx_sched *sch;
 	struct scx_dump_data *dd = &scx_dump_data;
 	struct scx_bstr_buf *buf = &dd->buf;
 	s32 ret;
 
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return;
+
 	if (raw_smp_processor_id() != dd->cpu) {
 		scx_kf_error("scx_bpf_dump() must only be called from ops.dump() and friends");
 		return;
 	}
 
 	/* append the formatted string to the line buf */
-	ret = __bstr_format(buf->data, buf->line + dd->cursor,
+	ret = __bstr_format(sch, buf->data, buf->line + dd->cursor,
 			    sizeof(buf->line) - dd->cursor, fmt, data, data__sz);
 	if (ret < 0) {
 		dump_line(dd->s, "%s[!] (\"%s\", %p, %u) failed to format (%d)",
-- 
2.51.0


