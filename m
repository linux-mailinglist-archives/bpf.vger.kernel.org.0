Return-Path: <bpf+bounces-34648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A538E92FBD8
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 15:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C2CB22766
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680AF171641;
	Fri, 12 Jul 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1u5kVD9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9026AFF;
	Fri, 12 Jul 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792367; cv=none; b=LmIr7mznD0l8NVpEYYMUMlOdOiYz3faqYo7W3EJpQeW+7FUJohp6LoOsRPVCXheJ5NNDSs/Gc2LCWr6yZpGzX3LTubKp1Uh49tCU4XSNJmjm45co1UTtLwK0RMFf+zAgFmDd8CrUbPEnag06bzFAYU7B3uMNh/9W0T3JrRPkXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792367; c=relaxed/simple;
	bh=1cII6ySGlnmVXZAUPI/X1maOWXfNSd9jw8IGVPQERh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B01CS0x2Z1Zmctg9vkHb7jie2ly9IW3ytTRdIgN7rqTfttFiDJPKGFBXIeyKPOZ3XC17uVX+899bext1ZSPVNXA3TIAPY58wCjO7ZbJKfpz5OVtFv5A2sQ1Y7x5rHpfrwQao3sxByl/kU0YbVtdrkTHKhNpzwCFwRHrogU5XGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1u5kVD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A259C32782;
	Fri, 12 Jul 2024 13:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792366;
	bh=1cII6ySGlnmVXZAUPI/X1maOWXfNSd9jw8IGVPQERh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E1u5kVD9o6HQmKdlpkMrvmbvXY47MZjiYCucG9zMpLJYIsrrZPl9TCubkwI9F+CTV
	 JCroOX7rjXMH0OZ6s/eSAT39S1H8nePp8ZtiLmrFQcEQ186qRUsQcVoYvFdcgbbb2e
	 8e/oY0J6kNkHTA23xHiKLWGKl2G3dR67dBwk0WFLt0OI9UGTEW2pZvYXUW0mBqN2iP
	 GLDq6t46iE52z3DvCeKFgRFsPLbRJAKB93CWQHxQLAchlypy0nuGoiaSTjGJGU8wCG
	 Ge80h3UayiXAop3rFZO0UGwzvXGXKnX5XbeRKwn8Agf+efpF5i92vfkTLQxrwtXSFN
	 XNAr0KNM+IUwg==
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
Subject: [PATCH 1/2] uprobe: Change uretprobe syscall scope and number
Date: Fri, 12 Jul 2024 15:52:27 +0200
Message-ID: <20240712135228.1619332-2-jolsa@kernel.org>
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

After discussing with Arnd [1] it's preferable to change uretprobe
syscall number to 467 to omit the merge conflict with xattrat syscalls.

Also changing the ABI to 'common' which will ease up the global
scripts/syscall.tbl management. One consequence is we generate uretprobe
syscall numbers for ABIs that do not support uretprobe syscall, but the
syscall still returns -ENOSYS when called in that ABI.

[1] https://lore.kernel.org/lkml/784a34e5-4654-44c9-9c07-f9f4ffd952a0@app.fastmail.com/

Fixes: 190fec72df4a ("uprobe: Wire up uretprobe system call")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 6452c2ec469a..dabf1982de6d 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -384,7 +384,7 @@
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
 462 	common  mseal			sys_mseal
-463	64	uretprobe		sys_uretprobe
+467	common	uretprobe		sys_uretprobe
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.45.2


