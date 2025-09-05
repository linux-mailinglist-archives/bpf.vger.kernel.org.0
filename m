Return-Path: <bpf+bounces-67613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD40B46507
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 22:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C16C1CC3643
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 20:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0062E03EE;
	Fri,  5 Sep 2025 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL2T7HZ4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1DF278157;
	Fri,  5 Sep 2025 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105878; cv=none; b=fz32D1FNAmNNkv670whpuI28N6Z8u3+Yo0/5Xp0vVzsf4QZ3jvdUMm1iLl89gwTbe3lhZOGelLYJNHYsCnP8XfUtLDaHlNHiFgDxWBYSkVOkd7WvTx9GiNjIbFpAAz0zVk7vcNNP+xhgafB9+OdaLBQuCPGryJE1Q86C6/1iBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105878; c=relaxed/simple;
	bh=sz7WRdEvocERBLwqK8WQqHfQ9wbtzBvV0anL7xCXY7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2TrpNoG0UWsCNbm0+jP4f6L73YXHUIaVwXbfvL0nwp/ScnW8oKe2Ns5Cg6lSgBvGYcGsEVeNKDLu37Yg7OZWyNw+7M1qZOdRWThbATjoKxTUjWWLlJD84d+P5fYA2sa54us+1WNypEPazxSXtlAlQ4OFXcJgr2leVyaLIlbmE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL2T7HZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAF5C4CEF1;
	Fri,  5 Sep 2025 20:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757105877;
	bh=sz7WRdEvocERBLwqK8WQqHfQ9wbtzBvV0anL7xCXY7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QL2T7HZ4EDMng4gP/vJeuW1QppRFaRiAdsb3L/8bFMiB0tzTwYXZrtlGOCUxnbA/l
	 sQb2LYweU3Nja9+MQ/GMYf8UgPV2KjBLxDAWtdhqrR5bK/+711+yeqK/po7LEJXvyJ
	 YN6Z6ZnKUJChyT2NIKhgkJHCvOXjfQ7eRN5QBm7O9Nyqr931YTCtaFyOfqOw22Zue4
	 3n3ZHeQ8yS2JZAp38OwA4bRo4tqkczm7/OMLN+moqhCg5LMYGrrXegwkHBu19DHQ1s
	 vAzv5a43ffIaAFU3bYd5K9B3zx6LcrKm+S1KLNhsXsBIADeWZww1rOeBPZfk8aP4Oa
	 YsNQ0Lztr3uDg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jann Horn <jannh@google.com>,
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH perf/core 1/3] uprobes/x86: Return error from uprobe syscall when not called from trampoline
Date: Fri,  5 Sep 2025 22:57:29 +0200
Message-ID: <20250905205731.1961288-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905205731.1961288-1-jolsa@kernel.org>
References: <20250905205731.1961288-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently uprobe syscall handles all errors with forcing SIGILL to current
process. As suggested by Andrii it'd be helpful for uprobe syscall detection
to return error value for the !in_uprobe_trampoline check.

This way we could just call uprobe syscall and based on return value we will
find out if the kernel has it.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0a8c0a4a5423..845aeaf36b8d 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -810,7 +810,7 @@ SYSCALL_DEFINE0(uprobe)
 
 	/* Allow execution only from uprobe trampolines. */
 	if (!in_uprobe_trampoline(regs->ip))
-		goto sigill;
+		return -ENXIO;
 
 	err = copy_from_user(&args, (void __user *)regs->sp, sizeof(args));
 	if (err)
-- 
2.51.0


