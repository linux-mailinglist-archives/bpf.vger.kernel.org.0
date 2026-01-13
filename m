Return-Path: <bpf+bounces-78675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73645D17560
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 09:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB5E830057C2
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 08:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065E7192B75;
	Tue, 13 Jan 2026 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCcM7uEk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2AB37FF63
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293600; cv=none; b=qE9vciq1lgq9lprgmw5EiUqSDZk9BSVXPpYMRbkXzZx+10VRoz0m00MMitT4kS4PUIo6VO6JYenEfiGC71kHBzH1OG4ipETH6xNGqeAEwnHNHsMX6LsdnFdK8MQYANYYZq+WhP87oyTQ4rzmtH92EUJtOXaAHGaVVME9QF76f10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293600; c=relaxed/simple;
	bh=54x5qxknkKRWjF8yBJYDqz+F6N1dwoIG8kA2I/iYPTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IVvoV6iNXWfgG1DrGBoN0xvY3zvKXlQYyMQpr95DdLs+WVoBb2TEUvaxALghfknzJvVZPfG6zOTPpIzwelx5FexJY37KQcUkzkODXjxNcyVd7OhZSdwXzDMz2Ea6SuCrhoDzyldgeqZspuSrJm7nbsT+mMk/92cpWQsGyFHeStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qCcM7uEk; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-64d251b8c5dso8541615a12.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 00:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768293597; x=1768898397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YG7jNnTzb3q5h4Pi3zfwn239cyO9LAafT4UbNFwkehg=;
        b=qCcM7uEkuai9i+NDs67c1KQW18qEOQsd4QorSyNGyvgzxYpjVCtlRlj/Ff3gBqEepv
         6EXODMyfMAWjZKA9EUrQNk5N7+YNh5UatZ7G5hgunqJtlub6u0DqGNT3gj9di/f0PGp5
         n2q86kd8OiH++zZ9sPMTfhWPuYDU5ntQ3LJ3jO5CujsN0UCLFZ3h5zFk9EQRgDilCWiV
         qv/3T1qf9VH2LfdBp0e11GXy/HZdeo9ptwAEKQhfuQp8wik/adc9gNHAZ86YLyHxPe2J
         uohgyGyom4aiHEWLML62p/VinUWuAz1qcxOVMxM4DBlmTGx8orsJhsPLf57/am6LYuU7
         iWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768293597; x=1768898397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YG7jNnTzb3q5h4Pi3zfwn239cyO9LAafT4UbNFwkehg=;
        b=jJpPuvY5tnIdnd+biJwVJlBeVQi/LUc9N6TwWwiczc5GA8Cqv683RGkKNEA3+qTHSn
         f9Be9ABh+CYA6I2DxdlVijtfUZkYs5JbIalWr/bEupn7sFnzS3bL0frEIPXT1dgPjKjq
         oogfNg4YKGadgyR4cGqlCupffjVqBSmi54+yA63BUbH7QogR+iJ2hDVhKr8FpvjXCttZ
         7o6ggabitpgMKqliE07hPoAxrKtakpispA6q4h7P1y2vdK33GpINot2eZANuD+kVVJGY
         xbBvOwaAWJwHxONERwOW+s6xasA7m1tla5BknzEd5/JtCLoY5bfSZGXO+WpnLv41jZhk
         X81g==
X-Gm-Message-State: AOJu0Yzm5ft9A0XEdwZQEl48K6Sbmp73BVz3yLE+6tSBTvNb2eByXmI+
	Rce89iTCEueGdc8AOuC2NaM1pYTqqQPtYRk7OWYKcSQPNDnVA/MryU1S9t0yUytn+mpw5kDE5ci
	aqtL4gIxvu7mljkB4jcT2omTb+NVWTAHwyUmuVRfKfK74UPjlfH5NIpqVG2N5c8/mJFqigHz0zr
	7jadEtzW9T6SXhidmuQZ1tSAFVDyS/pjRBCRTtHXECTCHclPaqqHI5GaiUE+EtYzgowUavtg==
X-Google-Smtp-Source: AGHT+IE1Kzq+5MFMQVSNHKC0SqsWv2A84beqhP75oJbLlmFB++XUEMhTUGRj11QssGm41F5KXl8/bLz4NefzIYBwTCh6
X-Received: from edn14.prod.google.com ([2002:a05:6402:a0ce:b0:64b:5858:344f])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:268a:b0:645:1078:22aa with SMTP id 4fb4d7f45d1cf-65097e63ef4mr19398931a12.19.1768293597306;
 Tue, 13 Jan 2026 00:39:57 -0800 (PST)
Date: Tue, 13 Jan 2026 08:39:49 +0000
In-Reply-To: <20260113083949.2502978-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260113083949.2502978-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113083949.2502978-3-mattbobrowski@google.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: assert BPF kfunc default trusted
 pointer semantics
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

The BPF verifier was recently updated to treat pointers to struct types
returned from BPF kfuncs as implicitly trusted by default. Add a new
test case to exercise this new implicit trust semantic.

The KF_ACQUIRE flag was dropped from the bpf_get_root_mem_cgroup()
kfunc because it returns a global pointer to root_mem_cgroup without
performing any explicit reference counting. This makes it an ideal
candidate to verify the new implicit trusted pointer semantics.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_memcontrol.c | 32 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_memcontrol.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 5829ffd70f8f..38c5ba70100c 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -61,6 +61,7 @@
 #include "verifier_masking.skel.h"
 #include "verifier_may_goto_1.skel.h"
 #include "verifier_may_goto_2.skel.h"
+#include "verifier_memcontrol.skel.h"
 #include "verifier_meta_access.skel.h"
 #include "verifier_movsx.skel.h"
 #include "verifier_mtu.skel.h"
@@ -202,6 +203,7 @@ void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_may_goto_1(void)           { RUN(verifier_may_goto_1); }
 void test_verifier_may_goto_2(void)           { RUN(verifier_may_goto_2); }
+void test_verifier_memcontrol(void)	      { RUN(verifier_memcontrol); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
 void test_verifier_mul(void)                  { RUN(verifier_mul); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_memcontrol.c b/tools/testing/selftests/bpf/progs/verifier_memcontrol.c
new file mode 100644
index 000000000000..13564956f621
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_memcontrol.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2026 Google LLC.
+ */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+SEC("syscall")
+__success __retval(0)
+int root_mem_cgroup_default_trusted(void *ctx)
+{
+	unsigned long usage;
+	struct mem_cgroup *root_mem_cgroup;
+
+	root_mem_cgroup = bpf_get_root_mem_cgroup();
+	if (!root_mem_cgroup)
+		return 1;
+
+	/*
+	 * BPF kfunc bpf_get_root_mem_cgroup() returns a PTR_TO_BTF_ID |
+	 * PTR_TRUSTED | PTR_MAYBE_NULL, therefore it should be accepted when
+	 * passed to a BPF kfunc only accepting KF_TRUSTED_ARGS.
+	 */
+	usage = bpf_mem_cgroup_usage(root_mem_cgroup);
+	__sink(usage);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0.457.g6b5491de43-goog


