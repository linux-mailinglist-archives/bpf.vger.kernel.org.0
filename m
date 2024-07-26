Return-Path: <bpf+bounces-35716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D2193CFFE
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 10:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87AC4B23568
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 08:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61193176FDF;
	Fri, 26 Jul 2024 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYO9yXYt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6413D255
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984180; cv=none; b=SWfiHow0oAgle+p2b/juq+IjosQ4V2A7aRxGuCyk81VbCt1qoAisZz3R2NOMqbw8nVKS+BF2uQFg6LnaApPCmaMI1agJ0VoGGk0KNb938yF1sJQlv13f8jmHwLLWAQlIwHOt1vcvR0BDieWtqnqutexNmZVCUGieMOgQ6xgXs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984180; c=relaxed/simple;
	bh=RVNBSjBqgj/6y6lyrajxl/PVAJAWndjeKfyDpCSBkrk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HDlHwqpR7ZRj4mmt+toGJ8WMC8XQSJW17Mx1VlhxeZtZlo4PRtrpMtJ2DXKKia9ADJxRqsiUpwFdVrVuvR8PNtW/vepfGK/q7SqRRylEWq/qy4IFYo7/Ngy0Oyrv6jWfhAdwviD0O/dILb7PhxnIx9pWQkm5WraM0lk1EvOSSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PYO9yXYt; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a7aa26f342cso128453166b.1
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 01:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721984178; x=1722588978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq0OZln+RUILnwIv9j4pYi6OZYhyhT/7v/9YG1LoiO8=;
        b=PYO9yXYtvskIhcyUwpnlWgjrjrUSWekVQ6k23tXexiNrhBprGkXyu8PeaWFc3pjeRz
         rTtuLCc4RPEWCUZl8/XunaHLgumraMTX7igdNrzSVKQIau47XzgZE5kxmF/8PfXFtE0S
         jaBMw8EI1lYQkTVx1C2tj3Ilg3HvYJtTFQqj51uYY9NxMvYzmNdY9srsomwX9ipRdp5f
         q5wlS2khEu78s1elgN1ybYVTbzHS9OZRdKlRWX2OqdYckj1h2usvUeQXT0HgkNY0GVek
         SPTuZYfK/WHmC06a77U8h9s+JvD8x4U/L0kwsXS8eOpAMd3txZ9QtBBZoxRYCXMp8p+h
         XpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721984178; x=1722588978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq0OZln+RUILnwIv9j4pYi6OZYhyhT/7v/9YG1LoiO8=;
        b=PZ9hL36ZoJTPQTd78nd3btEr77obuE5TsdkRUDsldlmIXnGAOmmxolQZ7lnMdVLLXl
         b3qOW0VGGnKy+ZznQBNwR1pe2JHqnxaxjOqATMpPOWYUSrByr8WPBNC/6FiZqYU0Mc6/
         hr9hQ65WrzO1husXOPb5Mi4ZDQ8NyUIGtIHOUpfPmF7Fex1jDBaK8IBRGPcm9JaiGUTR
         JCCOtfQqCvZhQki/n5p7devFBz7HF1Q7DCdOGKWUQ5kUwNq6ToQq+hB/LFFJeDtcorX0
         puijQOtVDJ5sLaubRkdG8ZGLxf1wNdR9gGuqUNYEWggC4Rm4CFSSlItK4T3tf58G7RGc
         szNw==
X-Gm-Message-State: AOJu0Yx5y7r4fwFqxfgFNe6f8E2e/hMc8p7cPqvVdHE4BiHq6BIdGEBc
	Tr1odZ2yyiPRalvRpW2IhUX67T/h8MO1BabMPcElGrrvnQjNAEjm11r/QDt6DOxI3vowhDtciB6
	tjRcMDUjxvL3BGIFRMqpvqgv/BOavKxjysKUy08zIlcp0tK0Ag12O0m9ZOyxD0fFYQug9fgj4wB
	V0ltVHSMycoju+L5yMlqa0jJFQ//Cwdqn8ILqI1zALx/wJ6/F+K2pZQPaNncSNJk3XWQ==
X-Google-Smtp-Source: AGHT+IHAPnfPb4bZn0X4tZTpS1hqhadVq0TkVqX4dUZ4IJNrsF6esqiID4ehBuzvYaUqjmC6OwhuMKTDj7nC6SF2K4pu
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a17:906:3c55:b0:a7a:8d9b:14e6 with
 SMTP id a640c23a62f3a-a7ac527d38emr328966b.9.1721984177226; Fri, 26 Jul 2024
 01:56:17 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:56:04 +0000
In-Reply-To: <20240726085604.2369469-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726085604.2369469-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726085604.2369469-4-mattbobrowski@google.com>
Subject: [PATCH v3 bpf-next 3/3] selftests/bpf: add positive tests for new VFS
 based BPF kfuncs
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, jannh@google.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, jolsa@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a bunch of positive selftests which extensively cover the various
contexts and parameters in which the new VFS based BPF kfuncs may be
used from.

Again, the following VFS based BPF kfuncs are thoroughly tested within
this new selftest:
* struct file *bpf_get_task_exe_file(struct task_struct *);
* void bpf_put_file(struct file *);
* int bpf_path_d_path(struct path *, char *, size_t);

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_vfs_accept.c | 71 +++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_accept.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 14d74ba2188e..f8f546eba488 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -85,6 +85,7 @@
 #include "verifier_value_or_null.skel.h"
 #include "verifier_value_ptr_arith.skel.h"
 #include "verifier_var_off.skel.h"
+#include "verifier_vfs_accept.skel.h"
 #include "verifier_vfs_reject.skel.h"
 #include "verifier_xadd.skel.h"
 #include "verifier_xdp.skel.h"
@@ -206,6 +207,7 @@ void test_verifier_value(void)                { RUN(verifier_value); }
 void test_verifier_value_illegal_alu(void)    { RUN(verifier_value_illegal_alu); }
 void test_verifier_value_or_null(void)        { RUN(verifier_value_or_null); }
 void test_verifier_var_off(void)              { RUN(verifier_var_off); }
+void test_verifier_vfs_accept(void)	      { RUN(verifier_vfs_accept); }
 void test_verifier_vfs_reject(void)	      { RUN(verifier_vfs_reject); }
 void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
new file mode 100644
index 000000000000..55deb96a4421
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+static char buf[64];
+
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(get_task_exe_file_and_put_kfunc_from_current)
+{
+	struct file *acquired;
+
+	acquired = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+
+	bpf_put_file(acquired);
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__success
+int BPF_PROG(get_task_exe_file_and_put_kfunc_from_argument,
+	     struct task_struct *task)
+{
+	struct file *acquired;
+
+	acquired = bpf_get_task_exe_file(task);
+	if (!acquired)
+		return 0;
+
+	bpf_put_file(acquired);
+	return 0;
+}
+
+SEC("lsm.s/inode_getattr")
+__success
+int BPF_PROG(path_d_path_from_path_argument, struct path *path)
+{
+	int ret;
+
+	ret = bpf_path_d_path(path, buf, sizeof(buf));
+	__sink(ret);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(path_d_path_from_file_argument, struct file *file)
+{
+	int ret;
+	struct path *path;
+
+	/* The f_path member is a path which is embedded directly within a
+	 * file. Therefore, a pointer to such embedded members are still
+	 * recognized by the BPF verifier as being PTR_TRUSTED as it's
+	 * essentially PTR_TRUSTED w/ a non-zero fixed offset.
+	 */
+	path = &file->f_path;
+	ret = bpf_path_d_path(path, buf, sizeof(buf));
+	__sink(ret);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.46.0.rc1.232.g9752f9e123-goog


