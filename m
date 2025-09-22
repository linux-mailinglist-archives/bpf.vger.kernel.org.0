Return-Path: <bpf+bounces-69175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 038FCB8F29A
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 08:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E51188922F
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 06:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2A82D6E53;
	Mon, 22 Sep 2025 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA5J72ji"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3462264B7;
	Mon, 22 Sep 2025 06:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522919; cv=none; b=eAPCHqYtxnytEUmiQ+xlSvmdGfQEPynlRk5ZoYmjWQYK4OmfMlfV9xfevXB8kJ9V5+CykkvGYYmaGs++gQ7cFaWrbyqUulq5Yyu6AGOMc0eKIrPfbma9qz6poP/lN8CswWn8RlHbdYWJoNAEhRCHRwTGmyK9fquhTSkrAjz/2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522919; c=relaxed/simple;
	bh=kLRuYvf4H++1ndDWeY8hcNRVnCSzRSNMXeygM2UcP9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dE62yp56FNkktC5CwlkEzVBu4Mcrs2xfxNTWdsnF8OURT/QwSe93mSXnaIjrT4nkHFECy4XU89zS40fegiZrjSyqT9M+7MHNBatLNouIjXK1Vjo6tahDzJcubbqYSGprfk1czcsb6ru8/gKuZxIizQuXkA9Uef6s1vPzfcASuCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VA5J72ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163A5C4CEF0;
	Mon, 22 Sep 2025 06:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758522917;
	bh=kLRuYvf4H++1ndDWeY8hcNRVnCSzRSNMXeygM2UcP9g=;
	h=From:To:Cc:Subject:Date:From;
	b=VA5J72jiVNDK3o8FyxgH1xmtK6pW6LBUhfX22zqzGUOBVcTHa9+UIaO8Kf3gNUa7Z
	 ywEJflBD/bzmjz9Gyd+k9kCRcni4p3tj78FKu51cJLixgsl7SjmCSI77JHJWSQW7SP
	 qrUX6+47qJxEICValQdlkGDYDk1qaAnUgYHlTOmtHkEnX4fAWukL46F2Iqa/ncDYBs
	 6IV9N5lMH09V7kpLhXuG9ZG5EnWkJf3obqPwW9SlRE7yrUUJRR/mw6yIU52UehvG4W
	 v3JbBmJ1P3hfwBrEnHwVSxxvCKFCfW3ukaQE8/LPUSLxZ+oYMW3zAYmC/nFaRIDuju
	 xOhoxYkcczgUg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>
Cc: jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kees@kernel.org,
	samitolvanen@google.com,
	rppt@kernel.org,
	luto@kernel.org,
	mhiramat@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 0/2] tracing: fprobe: Protect return handler from recursion loop
Date: Mon, 22 Sep 2025 15:35:11 +0900
Message-ID: <175852291163.307379.14414635977719513326.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The following series fixes a recursive loop issue on fprobe by adding
ftrace_test_recursion_trylock() in __ftrace_return_to_handler().
The previous version is here;

https://lore.kernel.org/all/175828305637.117978.4183947592750468265.stgit@devnote2/

This v2 removes WARN_ON from __ftrace_return_to_handler() and adds
kunit test cases for recursive call [2/2]. 

---

Masami Hiramatsu (Google) (2):
      tracing: fgraph: Protect return handler from recursion loop
      lib/test_fprobe: Add recursion check test cases


 kernel/trace/fgraph.c   |   12 ++++++
 lib/tests/test_fprobe.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 2 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

