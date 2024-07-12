Return-Path: <bpf+bounces-34649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C06292FBDB
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 15:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB57B2153C
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7CB17165A;
	Fri, 12 Jul 2024 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7/JyyFG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795226AFF;
	Fri, 12 Jul 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792378; cv=none; b=uoz0BIccXECNQ+LKwx5BBBA6MdVUYjSd6ESOiVCwXj7iwl6+VNmFZeHWBLlwpawvAb/0pWErNsMLjGdO2BIl0AEEnqGBn1ovtWWXKrpsIDRzyFS7owxK/llET4Rs8eox0+I/Uh09VwQAkwbktvA9MNEGo36I692WdXtoUG1hbsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792378; c=relaxed/simple;
	bh=R9G9wwPftutPeaaExTJ6lpEMwJ9MWKMZZnuGnq3/zxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcgRcZCTK2C7r+7phf1YHv0FJFYQJg1oI/H8ANS6KJqrhNsTQHGCBvbfzSqh7Ix3gQdUJ2LX/9gMUfA3tQ7SGn36Fw5OmMpKjWn5T8Ngu+P83YGzv0Lp/cwhLgszefLLSIOiv+8b9eJHJ1DQH9KKDyzIOwi+23LNO5VVWxMLXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7/JyyFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAF3C32782;
	Fri, 12 Jul 2024 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792378;
	bh=R9G9wwPftutPeaaExTJ6lpEMwJ9MWKMZZnuGnq3/zxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7/JyyFGRzRJk6RiHso3Yw8FRyAiuQtYOWdEVk4e0EblvsrsT7DNWkQ0yQR1sW4wm
	 7vlJZmN6CWDXj0hA5w7X25WMWt/p2AWUChOtYW9tJfGNROFTRTor1uudfwCzLBgeLp
	 +JIPsataZdsdeeArLNAQS2OASb6d/j7oLd4ogtYWhXj0gmUZv6dyYiy8FPbc6AoX1K
	 VsdId2oll5FXCvi2rw9DT+px/Ad38i/0nnURMjepA35/sqxmotAdu4TqxnmqLlG94l
	 r95UgJoHaMSMt667314RhybeZ71BbMy94UEhVLOMOnad+V8STICWHaOSQXDMmcywUx
	 kB1GCbtTa58FQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/2] selftests/bpf: Change uretprobe syscall number in uprobe_syscall test
Date: Fri, 12 Jul 2024 15:52:28 +0200
Message-ID: <20240712135228.1619332-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712135228.1619332-1-jolsa@kernel.org>
References: <20240712135228.1619332-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixing the syscall number value.

Fixes: 9e7f74e64ae5 ("selftests/bpf: Add uretprobe syscall call from user space test")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index c8517c8f5313..bd8c75b620c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -216,7 +216,7 @@ static void test_uretprobe_regs_change(void)
 }
 
 #ifndef __NR_uretprobe
-#define __NR_uretprobe 463
+#define __NR_uretprobe 467
 #endif
 
 __naked unsigned long uretprobe_syscall_call_1(void)
-- 
2.45.2


