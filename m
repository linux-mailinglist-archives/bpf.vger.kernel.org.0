Return-Path: <bpf+bounces-27160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F498AA288
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 21:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A345B1C20FE0
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 19:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020DA17AD95;
	Thu, 18 Apr 2024 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTTVatkm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46917A93E;
	Thu, 18 Apr 2024 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713467354; cv=none; b=FAhQtRrEHx7pCIRPASoCUmTyWYDSiniq/S10dX7QPundmiwwKS7vbADxtI2YgdNLbziIorYGaOGNuKcUHllcUs+U3URirfxhEaDHWccr3vKrgIknAVg9JKguKkynjkJY58t6NUl2oImUJJXW5P9F/skyC4zAtgxTvgXfb38Sd1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713467354; c=relaxed/simple;
	bh=o+p+igQ4FBx5KCCF7nvkKmVDm0IeVUjotiEU4ySmHYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xtcp05GxZwCk8hEHQIMcwVbJ6PxtT34fC63JvzubOVGxMdV617RQhfSQoVhNm8fZ/MCG3g0mRgddFNNLbbYo726eQuRkMkqQuKR57Z0i5G24izu5YQ/M6BtrNCcPLwJq9paR/qWyuLDbNuBExmlbad6rzOfvwQ43+wuudSGCSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTTVatkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7ACEC113CC;
	Thu, 18 Apr 2024 19:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713467354;
	bh=o+p+igQ4FBx5KCCF7nvkKmVDm0IeVUjotiEU4ySmHYw=;
	h=From:To:Cc:Subject:Date:From;
	b=QTTVatkmL5i3GCPN0BJ1MR+6XPFv7f7hE5mKDU0Gk9O16IXDL8/QZ1vHtQtvmG2Kf
	 jYIZcRpv8P9Nv5ELcIsdfnAPU+IVs/Ti4g7WsjWA5Qr3K7C6mrMuZMQTtozecRBqZI
	 jIQQbZNp2dJe/hezZJ2eeuK2e9Xh5dca5zVeJ3JSf54FeRVFfLLmns7v1LqYupRS4U
	 PtGAtZthaaJ17fdPKhrblEmSG5eP3y2B/6GOVGSuaWqE/NgQmJjRAznTS/Gf8GxjRu
	 +24y0eLIYHV77CextfNzqg9dX7BAYDljHO4AM6+4eUSV4w2gMg7du7tZ8rmdUdqtIh
	 DmLfazQANKukA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 1/2] ftrace: make extra rcu_is_watching() validation check optional
Date: Thu, 18 Apr 2024 12:09:08 -0700
Message-ID: <20240418190909.704286-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING config option to
control whether ftrace low-level code performs additional
rcu_is_watching()-based validation logic in an attempt to catch noinstr
violations.

This check is expected to never be true and is mostly useful for
low-level validation of ftrace subsystem invariants. For most users it
should probably be kept disabled to eliminate unnecessary runtime
overhead.

This improves BPF multi-kretprobe (relying on ftrace and rethook
infrastructure) runtime throughput by 2%, according to BPF benchmarks ([0]).

  [0] https://lore.kernel.org/bpf/CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aNDXQSHYia47pQ-w@mail.gmail.com/

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/trace_recursion.h |  2 +-
 kernel/trace/Kconfig            | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index d48cd92d2364..24ea8ac049b4 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -135,7 +135,7 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
 # define do_ftrace_record_recursion(ip, pip)	do { } while (0)
 #endif
 
-#ifdef CONFIG_ARCH_WANTS_NO_INSTR
+#ifdef CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
 # define trace_warn_on_no_rcu(ip)					\
 	({								\
 		bool __ret = !rcu_is_watching();			\
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..7aebd1b8f93e 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -974,6 +974,19 @@ config FTRACE_RECORD_RECURSION_SIZE
 	  This file can be reset, but the limit can not change in
 	  size at runtime.
 
+config FTRACE_VALIDATE_RCU_IS_WATCHING
+	bool "Validate RCU is on during ftrace execution"
+	depends on FUNCTION_TRACER
+	depends on ARCH_WANTS_NO_INSTR
+	help
+	  All callbacks that attach to the function tracing have some sort of
+	  protection against recursion. This option is only to verify that
+	  ftrace (and other users of ftrace_test_recursion_trylock()) are not
+	  called outside of RCU, as if they are, it can cause a race. But it
+	  also has a noticeable overhead when enabled.
+
+	  If unsure, say N
+
 config RING_BUFFER_RECORD_RECURSION
 	bool "Record functions that recurse in the ring buffer"
 	depends on FTRACE_RECORD_RECURSION
-- 
2.43.0


