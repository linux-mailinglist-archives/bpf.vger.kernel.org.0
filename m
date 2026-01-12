Return-Path: <bpf+bounces-78626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6F8D157C0
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 22:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 384B63009D78
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 21:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150A53446A7;
	Mon, 12 Jan 2026 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm8NP9Ra"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DBA1C84D7;
	Mon, 12 Jan 2026 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768254625; cv=none; b=DNLyjKI+GXiNXt3Xteo+5RWydt/GrQuQHf40Wi1Ef1ECwCUZ8+Nxa2y9izzKBeyR4nJwiaQos5KM9KisPqgcv9SGimNjEmsW4rydAr9QI/ihJa5nWluwZdbHoPhC+ZooCcXsbpY5thOjXcjP90yIkJXlCZ81BxzxVCLAXvC0i1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768254625; c=relaxed/simple;
	bh=xhRljmXigdry4f9PbyrJi+AYA6WIKqd/bXcrjJ/9MtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKzpy2oJZedB66ykwb1GSC2Do+4hnQ/jm/8Z4JzY22ksDdau0lrbsixgoyJzCZtTvHj7XpXR6VoMnihfIx4pxTlJncCVMrcbRhOciNqGow1rRcyt+JArNbts+4XI5RDBFp6M4v7lGCyMyB/4KG5CfdBMNKaPMyaVUTDVkSlXyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm8NP9Ra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AE3C116D0;
	Mon, 12 Jan 2026 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768254625;
	bh=xhRljmXigdry4f9PbyrJi+AYA6WIKqd/bXcrjJ/9MtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fm8NP9Ra8K5sLEHcvUXo8FmzonROpH1MftpOyD5oqwNoJI+Qeir7IHkB6kooy1DWk
	 Ah1OyOcbUEaRi9vQ0ZpX4QlBHz/t6KLsTC5pIH7vkYXXKfrmMhConzsFb30SO0Esz4
	 0+u4fyS6b8+BuYzjiyU7ZMaC7ny6FApfVJufwgckPVPiUfCQB5YnMOdYe6WMQiCvwm
	 8WNvpzxCQ5AZtdmSXDcJ+p7eAYsaR7TdyMH8pGhDKdJo9lvDeLkCEfsG+jgkaAj/P9
	 PrjAZsPyqx8+Yq7PnTXPiLgHnTNXAhR0sJI+81n90c3o4cv6KXHkobEJwypqy6/Ftu
	 uLdmySDYcAWpQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 3/4] selftests/bpf: Fix kprobe multi stacktrace_ips test
Date: Mon, 12 Jan 2026 22:49:39 +0100
Message-ID: <20260112214940.1222115-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112214940.1222115-1-jolsa@kernel.org>
References: <20260112214940.1222115-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We now include the attached function in the stack trace,
fixing the test accordingly.

Fixes: c9e208fa93cd ("selftests/bpf: Add stacktrace ips test for kprobe_multi/kretprobe_multi")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
index c9efdd2a5b18..43781a67051b 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
@@ -74,7 +74,8 @@ static void test_stacktrace_ips_kprobe_multi(bool retprobe)
 
 	load_kallsyms();
 
-	check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 4,
+	check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 5,
+			     ksym_get_addr("bpf_testmod_stacktrace_test"),
 			     ksym_get_addr("bpf_testmod_stacktrace_test_3"),
 			     ksym_get_addr("bpf_testmod_stacktrace_test_2"),
 			     ksym_get_addr("bpf_testmod_stacktrace_test_1"),
-- 
2.52.0


