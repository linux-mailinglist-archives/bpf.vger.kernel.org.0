Return-Path: <bpf+bounces-69656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3BCB9D188
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 04:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3E53B35E6
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 02:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA082E1758;
	Thu, 25 Sep 2025 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WjzIx70L"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB725487A;
	Thu, 25 Sep 2025 02:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766150; cv=none; b=WEgBCKDsh1+N1rJV/JHpMLHlubYNypwSZldhtQis0M4O1t2UUszccT32e/RhKDtz/vtMUzek6Y8zT9oIn6mA1dy0vp9hkgFCo4YZeDOdSQIzluNcEdr6RjxVgQmOeJFkJVTE0PIbHYXeNcvpCy+SFkBx76MVClgmNIwmATAJMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766150; c=relaxed/simple;
	bh=dvEeJZpALUXHQn8Map8RbBvlT9jD/7M8DMbRjpo3D4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nE26DM0Uqumfpr7C61Kg5il8ItwPnfS9L/YGHWzvgAQLDHoBjauk7yMgnO9qV/Ia7x2JKJdegv2Irv2L75dz4ulIQ6iWrAF87rgShy2/utEDk8kNIQq6aax02gEoJaXBR0gBuFfEWQ6moH9B/QzPF6vfO+3YMIX70ZRIVkhVl5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WjzIx70L; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ad
	iBphAPScR6QQjh2KwjN5aarvz+PskpFpyHr3Y87gs=; b=WjzIx70LpoyMNUwCIh
	ePB4aB07F7rsQrRR/e9WPkjqZgFTnVXn+ilrjtG3btzPXzxyt4Bw3Bch3tRw3RgX
	G8/lxsmodMkMGGdq8UqCKLDF6EtEsIXwhwzs2JtslgNJ4+d7EEX5x48n62Gq/osK
	wYuql/ibaoeh7FrMobRX80/gI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnEQkXpNRowQcHEQ--.9650S2;
	Thu, 25 Sep 2025 10:08:24 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	revest@chromium.org,
	alexei.starovoitov@gmail.com,
	olsajiri@gmail.com,
	andrii@kernel.org,
	ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH] tracing: Fix the bug where bpf_get_stackid returns -EFAULT on the ARM64
Date: Thu, 25 Sep 2025 10:08:22 +0800
Message-Id: <20250925020822.119302-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnEQkXpNRowQcHEQ--.9650S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyxur1kWF4xJrW8tr4xZwb_yoW8XFWkp3
	9F9rykGFWDWFs0kw47WrsxXr15Cws3ArWrCry8Cw1akF4DZFyUCr9FkFWjkF1xA34Du3yx
	uF1avry5Cws8ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjuWLUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiVhrSeGjUYEjeAQABss

From: Feng Yang <yangfeng@kylinos.cn>

When using bpf_program__attach_kprobe_multi_opts on ARM64 to hook a BPF program
that contains the bpf_get_stackid function, the BPF program fails
to obtain the stack trace and returns -EFAULT.

This is because ftrace_partial_regs omits the configuration of the pstate register,
leaving pstate at the default value of 0. When get_perf_callchain executes,
it uses user_mode(regs) to determine whether it is in kernel mode.
This leads to a misjudgment that the code is in user mode,
so perf_callchain_kernel is not executed and the function returns directly.
As a result, trace->nr becomes 0, and finally -EFAULT is returned.

Therefore, the assignment of the pstate register is added here.

Fixes: b9b55c8912ce ("tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs")
Closes: https://lore.kernel.org/bpf/20250919071902.554223-1-yangfeng59949@163.com/
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 arch/arm64/include/asm/ftrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index bfe3ce9df197..ba7cf7fec5e9 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -153,6 +153,7 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 	regs->pc = afregs->pc;
 	regs->regs[29] = afregs->fp;
 	regs->regs[30] = afregs->lr;
+	regs->pstate = PSR_MODE_EL1h;
 	return regs;
 }
 
-- 
2.25.1


