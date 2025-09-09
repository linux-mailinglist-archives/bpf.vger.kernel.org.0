Return-Path: <bpf+bounces-67859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248BAB4FB73
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 14:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259F34E820C
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4027C338F2E;
	Tue,  9 Sep 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTPKekDM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE533439A;
	Tue,  9 Sep 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421571; cv=none; b=O8DsAP87ilkbZyyM4A0QBL/RfkK74hCAEdpxF7YWiAAKlKk0kQs4dWYxTSnIGH0S7hieBK87cgJUitrxOI1WnbCU4sjqkATI0LvpcJxJO7QEKmIeYHpWRmuHUnTs7E9663gnWZWl//se3ZcdogJ5bhFNrB/BgKec5K+Dn9HJW/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421571; c=relaxed/simple;
	bh=TS50jOjzvt6IH8eaBLVaBZO88XVBkMIDXW/tc9a1LfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pH02QZL6iyJ0Ju2EPodkP2QnDBZE8z1L0rWVHh1QIzJGPNPOBBmPW067XIW0ZuU//4+b8JMMXsnojWM/CmiQ8fqSM3zt0B0uoEn2XwmALGeDi8pkkiitPw8IsKLWcL0Kx0GreFHqrEDrh+PKDEJdkv2EQJYmMHtqsVNzYLu9WRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTPKekDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DFDC4CEF4;
	Tue,  9 Sep 2025 12:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757421571;
	bh=TS50jOjzvt6IH8eaBLVaBZO88XVBkMIDXW/tc9a1LfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DTPKekDMA6rEHhwfa6DytnkJTyObiVmz72S+eJuJsN9fpe73rE+8+ibXPxXCYUKFr
	 cv/ORGCZFtyW1z9WFL7MIn5CnVblx0u4odGnf5lddpt/hWHCCe14bGmNbl6W1qehMA
	 4aB9E8Gh9FkKk0maGSr9lysAloWJ5tlDA0NenPWp8misvqjpgwUtIWOZyASekQZGEs
	 iuwd0wxlMhUjLBfKpM/10JpJQ1GbOovk8UUzVDWP2U42/tW8KR+TTnYyC2T7XfBR1K
	 8iP6vFC1JVcEVxrBjg/POKKCFn81m+H285d4GOioUqE8kfhk7RkDXefwFtNDhz9Mf7
	 1tAG3eAycUSaQ==
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
Subject: [PATCHv3 perf/core 2/6] uprobe: Do not emulate/sstep original instruction when ip is changed
Date: Tue,  9 Sep 2025 14:38:53 +0200
Message-ID: <20250909123857.315599-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909123857.315599-1-jolsa@kernel.org>
References: <20250909123857.315599-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If uprobe handler changes instruction pointer we still execute single
step) or emulate the original instruction and increment the (new) ip
with its length.

This makes the new instruction pointer bogus and application will
likely crash on illegal instruction execution.

If user decided to take execution elsewhere, it makes little sense
to execute the original instruction, so let's skip it.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 996a81080d56..4f46018e507e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2768,6 +2768,13 @@ static void handle_swbp(struct pt_regs *regs)
 	/* Try to optimize after first hit. */
 	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
 
+	/*
+	 * If user decided to take execution elsewhere, it makes little sense
+	 * to execute the original instruction, so let's skip it.
+	 */
+	if (instruction_pointer(regs) != bp_vaddr)
+		goto out;
+
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 
-- 
2.51.0


