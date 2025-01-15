Return-Path: <bpf+bounces-48921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C360A11FCE
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 11:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335453ACBBF
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 10:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA681E7C15;
	Wed, 15 Jan 2025 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnOcuDjA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E07248BA3;
	Wed, 15 Jan 2025 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937423; cv=none; b=csMgp0NDb2eezN0lhM8fow1FKWD9AGhscMRgEGR2lwqZFAqNsyBguOeBbWkWbirhZD5XFK8zw7h1drT0GIS/xrU+W0Y9LmffSVvfSCwgGQ7JU7RASPzjc6ecnALgPQV4gaRnUwExK5HjX1RyPbrrfZYdo8juSPQG8FK4UfFgrrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937423; c=relaxed/simple;
	bh=ecI6JRfMgtjB+9R+s9qxQ0AtzIoWiQDKevSXUo39I+k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ArqwP3pXG3SzQ0D+7ChAu1jWhzIfH0h91cogH73J5Oa05C787oeGndiL6LBYQ5Yb2WFBhnpsWpYdiXob2h/GZQtFB4b0Ub0LIzejh8vt6OeV9m+RteEQhhZ+KPv81JiUjkEnTB6bmuMepsKc8Wr7WeD+jNnLJ+w2g/c7z1x6UnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnOcuDjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66ECFC4CEDF;
	Wed, 15 Jan 2025 10:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736937422;
	bh=ecI6JRfMgtjB+9R+s9qxQ0AtzIoWiQDKevSXUo39I+k=;
	h=From:To:Subject:Date:From;
	b=rnOcuDjA34iZZpr9x96OCIRAeAmdh3sl0cx2ucpIyIBi5nR+UxDv21j01BE6+wzC7
	 /iFveN4LPfmsD10/s3tmel4jPrMys09tCTy2O41A799dmVlC/7rE07+swwPLw53Z6v
	 3xiFbdBjTa91cdHbmFA6OWU/tpRXNlCQ/hTgMJdcMMupFcIj1Bsv5cJ7oK/pdf7mKR
	 TKrOz8vwUh50PQcA037zVitX4IcDMvxehF5LCJAnQGvshbmaRtxJ+tXtt9LQ0Zw4ID
	 PS75MciKLoCTL0gY4QlSReITyEtf87AOdUpKLAfc4VkAjLqW7PornHal5emTplaCox
	 yc9fEw7vKbfpQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	puranjay12@gmail.com
Subject: [PATCH bpf] bpf: trace: send signals asynchronously if !preemptible
Date: Wed, 15 Jan 2025 10:36:47 +0000
Message-Id: <20250115103647.38487-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF programs can execute in all kinds of contexts and when a program
running in a non-preemptible context uses the bpf_send_signal() kfunc,
it will cause issues because this kfunc can sleep.

So change `irqs_disabled()` to `!preemptible()` that covers all edge
cases: preempt_count() == 0 and irqs_disabled()

Reported-by: syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67486b09.050a0220.253251.0084.GAE@google.com/
Fixes: 1bc7896e9ef4 ("bpf: Fix deadlock with rq_lock in bpf_send_signal()")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1b8db5aee9d3..d162c87e09a8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -853,7 +853,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struc
 	if (unlikely(is_global_init(task)))
 		return -EPERM;
 
-	if (irqs_disabled()) {
+	if (!preemptible()) {
 		/* Do an early check on signal validity. Otherwise,
 		 * the error is lost in deferred irq_work.
 		 */
-- 
2.40.1


