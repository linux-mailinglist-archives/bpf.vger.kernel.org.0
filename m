Return-Path: <bpf+bounces-55253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B07CA7A8C5
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 19:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81C2175568
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 17:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BB22517AE;
	Thu,  3 Apr 2025 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLC3oJDD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4610B2512D7;
	Thu,  3 Apr 2025 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743702083; cv=none; b=OLUn6mw17OTAi2/qusASGb28Q8rYaVMC149XQ8ncbEhoLuEbs6gORfgKG5u/QXYmLpJCKVq7ATJy4LzoLp8I5JZCeX5QmP+QZjn2nqwNLFg1+B3yNdGS2JblUEtL+inaMLfm3zTf9HFxkA0AxRk4+TQEA/xNt5wJHmnj6jDZCrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743702083; c=relaxed/simple;
	bh=VqD/t5nfqw17dzit8tCO0MFU7uzAr2vAyVsp8uT21lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3RDPaoR2ztGy9mwiWNWZlTm6gRKKNxkWN//XqdbtFeNU4mJ5Yily+Flxr3ldmg2rRQPXKqQIdCrHQUabrbDLtbRRfbduA0bPh/0jzap/ZJ7oE/Wlrd/7eEt0V9i1VUZP1HY0JoA4RmFHYFS8DEqZliephWsPU0ClKEuRH28K1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLC3oJDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0FFC4CEE3;
	Thu,  3 Apr 2025 17:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743702082;
	bh=VqD/t5nfqw17dzit8tCO0MFU7uzAr2vAyVsp8uT21lA=;
	h=From:To:Cc:Subject:Date:From;
	b=mLC3oJDD2SB7qBcpiuio99hpZYTBZSj/QQWL0jrta/VMOKjfkBQ/c+w8u4cCxfRML
	 vkvbFT1+PBKvyWbcpBDCoqBWt8s++6GBimYGaXKoxUrPaM4YSJBd97j33Mh+2UMINl
	 ENyb+BTI9sexh3lZp47Yp3UoPo0RXviGNqYKbPCFR/gjiUloQg+ny21IGwtzYAj0oB
	 6M2MhIxpMk5/1nzgsuSBGx+Cd712KoKU2MpPjpgE8OTC5eZKVVBVf5qqdTm3R/5oKv
	 DPjj38qpFB5DQrwZ/lp/XnOXbdPz0Q+jz31yzAtZnThBEUcSQCbl2+mLi9IFNkutci
	 2D0OhinJ0oaxg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mhocko@kernel.org,
	rostedt@goodmis.org,
	oleg@redhat.com,
	brauner@kernel.org,
	glider@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH] exit: document sched_process_exit and sched_process_template relation
Date: Thu,  3 Apr 2025 10:41:20 -0700
Message-ID: <20250403174120.4087794-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explicit note pointing out that sched_process_exit tracepoint is,
conceptually, related to sched_process_template and should be kept in
sync (though, on the best effort basis).

This is a follow-up to [0], and can hopefully be just folded in when applying.

  [0] https://lore.kernel.org/linux-trace-kernel/20250402180925.90914-1-andrii@kernel.org/

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/trace/events/sched.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 05a14f2b35c3..3bec9fb73a36 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -326,7 +326,11 @@ DEFINE_EVENT(sched_process_template, sched_process_free,
 	     TP_ARGS(p));
 
 /*
- * Tracepoint for a task exiting:
+ * Tracepoint for a task exiting.
+ * Note, it's a superset of sched_process_template and should be kept
+ * compatible as much as possible. sched_process_exits has an extra
+ * `group_dead` argument, so sched_process_template can't be used,
+ * unfortunately, just like sched_migrate_task above.
  */
 TRACE_EVENT(sched_process_exit,
 
-- 
2.47.1


