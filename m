Return-Path: <bpf+bounces-56340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D5BA9584D
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E4B3AB40A
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F867221571;
	Mon, 21 Apr 2025 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFbitown"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA921ABDC;
	Mon, 21 Apr 2025 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272005; cv=none; b=jdvO8/guHXtR7Jwv9D1wIQT3bZJc2v1PJT4qDOeHahpBDCihOagHgdngY2gkjJvbXz4k1GSChCDegCWE4oVMihZXMN4huPIuPEbTlljQgRbsQBfASBCG11UWpB237ha+ULGQdEgos4jDkwEo1p93/4N8wooseVYmUPCvUCTIfIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272005; c=relaxed/simple;
	bh=ArFi6LYnws/zK5pbLN4Y6WDU1aVkoTA4UhqE31uFzpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFyATc3O9uIv+GSCOZ0c+fvpUi7a4WoGb/Zf9mZ7UjcFMiiNpD+D//DrDA7Mv81hN4XILDQy/Ac8NwlhwqYtrENGO28i0jiRl256Ipmwg9PvYQ1YfuT9yC155nitp75ya5GbWDZ/ebFBfryQK1o9e7BVLs8s4PciX+y22ATKnzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFbitown; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73373C4CEEA;
	Mon, 21 Apr 2025 21:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745272004;
	bh=ArFi6LYnws/zK5pbLN4Y6WDU1aVkoTA4UhqE31uFzpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XFbitownCgJkrcx4SgKZj55+9VkZsd8302JYCpb6h4fdy+5cl8LqwYAozlGxIB8kn
	 i8TyXOvEL4Zk5eqWbbEf4HPXqiv1l/uw+Xrxwve1UKDCyo3DVvhqRrzc0XXGzMtB6l
	 M3zIOhNOu8XAtaH5K9h1CTFIbhYst/OZ3UOn25PAM4asosE5/T2/jycBfnQkVwfwMl
	 h3ImtZuj31sGZqtxKUXHKvQfMlp6tlI2y7JMv+o2ZvfhzwaYxX2fqzDw1Wn6Kq8kfg
	 177Gp8T3X0XqfGnZWlVGtJ6jDzU2d25Ubt571iq5tzzIJmwVdZwfZFGhJYOXQFyG0I
	 FC+c4PrvOhnUQ==
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
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH perf/core 11/22] selftests/bpf: Use 5-byte nop for x86 usdt probes
Date: Mon, 21 Apr 2025 23:44:11 +0200
Message-ID: <20250421214423.393661-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421214423.393661-1-jolsa@kernel.org>
References: <20250421214423.393661-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using 5-byte nop for x86 usdt probes so we can switch
to optimized uprobe them.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/sdt.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/selftests/bpf/sdt.h
index 1fcfa5160231..1d62c06f5ddc 100644
--- a/tools/testing/selftests/bpf/sdt.h
+++ b/tools/testing/selftests/bpf/sdt.h
@@ -236,6 +236,13 @@ __extension__ extern unsigned long long __sdt_unsp;
 #define _SDT_NOP	nop
 #endif
 
+/* Use 5 byte nop for x86_64 to allow optimizing uprobes. */
+#if defined(__x86_64__)
+# define _SDT_DEF_NOP _SDT_ASM_5(990:	.byte 0x0f, 0x1f, 0x44, 0x00, 0x00)
+#else
+# define _SDT_DEF_NOP _SDT_ASM_1(990:	_SDT_NOP)
+#endif
+
 #define _SDT_NOTE_NAME	"stapsdt"
 #define _SDT_NOTE_TYPE	3
 
@@ -288,7 +295,7 @@ __extension__ extern unsigned long long __sdt_unsp;
 
 #define _SDT_ASM_BODY(provider, name, pack_args, args, ...)		      \
   _SDT_DEF_MACROS							      \
-  _SDT_ASM_1(990:	_SDT_NOP)					      \
+  _SDT_DEF_NOP								      \
   _SDT_ASM_3(		.pushsection .note.stapsdt,_SDT_ASM_AUTOGROUP,"note") \
   _SDT_ASM_1(		.balign 4)					      \
   _SDT_ASM_3(		.4byte 992f-991f, 994f-993f, _SDT_NOTE_TYPE)	      \
-- 
2.49.0


