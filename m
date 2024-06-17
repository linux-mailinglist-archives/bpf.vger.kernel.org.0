Return-Path: <bpf+bounces-32301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA07190B410
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5B6B34AD1
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013601B1416;
	Mon, 17 Jun 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bw2ovgqf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7AC19B3D2
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631850; cv=none; b=EOUeL39nsvGTCSDKiFu4vSI6vYaKsiEmYXh+jEFjMWK4nbPf6FyyEiiXVBF6VnVUu/9vNR9H0NtUm5Z9LiG8gRnU13FYCOcNw9To/6HrjCqL0vyz9kWcXR/jkL1H7JrbsvfoEIk5ip7J/Znb5uG/pvxciQXBtKIKJaiwT/AAtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631850; c=relaxed/simple;
	bh=S9aAdWGkK5stsZGzE3qW81Yt9K0jt6T4mwVEGFh88xE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RZhdSzpT20rA9mOCLGBDDCHSk3nscSeUusjX5IL2UMKQWhCbemFzqY66TbZl5U2va1u7uyJE64EdESA0VjQqLVTuH29+9jBMrrgdCLXlr+DIEzE6Er55wsGsL4I36472pmC4o2AgO9Pk4759DDfJcO9lwphM6w9c3rvY5eIM8Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bw2ovgqf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso577103366b.2
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718631847; x=1719236647; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPWDzD7SNgti4JTnGwXpp+WhS5I/KCOk7GIzskiEpjU=;
        b=bw2ovgqfk0avtcum2PCVZkRgFj/Oz/03Uboy9XWnBCXy6xrZOsps2wtjovPgN9zgOv
         fKXnjbProlCv2ftNfsZdR19pA+SbfrYUx1VBbmRgLfAwmgx0NBu2dOsuuCg93uVMdna9
         MXTSpPRK08qDf2UAO5dtoHSedjtuNw72Bp8fuvy/NWCSHWM4FtDI3eswL5ZU2YRzPdO7
         qXFp2v6cOroJVZByEf4kUWwVI25ygZVr+i3azBYxmhQbdzrCWLbI+dobPiMtnFpZBDo+
         gHJtScwvPO2tUgm4piBbnZrPEszu2SFXY47AKSgH0elLIowV87YMu0YtK6UzX76uoaDo
         BGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631847; x=1719236647;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPWDzD7SNgti4JTnGwXpp+WhS5I/KCOk7GIzskiEpjU=;
        b=OcoEk2stjrMaCYA3PuQfyNPrsyaMtp446RT/MkKt3Y0f7t+0BBOpmq/k3CIUgi+Mpo
         ZDYBLJGZI8FercKJNfk/YL5irhLkFjI1/GSITWplWftyf7iWtyrYGU7UjX7HYt6EP+J3
         CQCQhTqf/spA7vl9lmw1GbXtRhieXjd3hl2QXLhe3GovGH4B9fUP/Kg6KBYm951ycG1D
         JtvrLErC6WRH3nRER1vq/9BfJ4Z8myjCAh5khKkrgqJZ1uwq37pma4V+v9PLfrl4Oupt
         1lL16cugjHWmTOWoXo9iEFUYSocI4QFpsVWtudqjreJRCl9ZtPwhSZF8Fo4Mj5sMcLDx
         xm4g==
X-Gm-Message-State: AOJu0Yz4uI6dfl3uaOE5NtSHBqrwItncHGB6vg5Ta0w77jqH+8beXBOv
	lapwf2WWnKEay6VUgyy2uixMQneZqD4cv+jA3Z7m3uiMhyIzwqBKziWGcCOJoX6Zj5cFG3UYS+5
	r5A==
X-Google-Smtp-Source: AGHT+IFSNnZDaEae+3YS+b0Q/A9lj/0HWWHf6AhTR/LBUEN9rl9HrmEFXKVi917HzovVFeoNX8+4pQ==
X-Received: by 2002:a17:907:c20a:b0:a6f:820a:45c7 with SMTP id a640c23a62f3a-a6f820a4dfcmr278480066b.27.1718631846506;
        Mon, 17 Jun 2024 06:44:06 -0700 (PDT)
Received: from google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da40acsm524178766b.15.2024.06.17.06.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:44:06 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:44:02 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	song@kernel.org, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, memxor@gmail.com, void@manifault.com,
	jolsa@kernel.org
Subject: [PATCH 2/2] selftests/bpf: add negative tests for relaxed fixed
 offset constraint on trusted pointer arguments
Message-ID: <ZnA9osZKFOPFwvxa@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Adding some new negative selftests which are responsible for asserting
that the new relaxed fixed offset constraints applicable to BPF
helpers and kfuncs taking trusted pointer arguments are enforced
correctly by the BPF verifier.

The BPF programs contained within the new negative selftests are
mainly responsible for triggering the various branches and checks
performed within the check_release_arg_reg_off() helper.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_arg_reg_off_reject.c   | 154 ++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arg_reg_off_reject.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 6816ff064516..e315bd0a1502 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -87,6 +87,7 @@
 #include "verifier_xdp.skel.h"
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
+#include "verifier_arg_reg_off_reject.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -204,6 +205,7 @@ void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
 void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
+void test_verifier_arg_reg_off_reject(void) { RUN(verifier_arg_reg_off_reject); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_arg_reg_off_reject.c b/tools/testing/selftests/bpf/progs/verifier_arg_reg_off_reject.c
new file mode 100644
index 000000000000..b46656f4cb62
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arg_reg_off_reject.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <linux/limits.h>
+
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+struct random_type {
+	u64 id;
+	u64 ref;
+};
+
+struct alloc_type {
+	u64 id;
+	struct nested_type {
+		u64 id;
+	} n;
+	struct random_type __kptr *r;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 256 * 1024);
+} ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct alloc_type);
+	__uint(max_entries, 1);
+} array_map SEC(".maps");
+
+SEC("tc")
+__failure
+__msg("R1 must have a fixed offset of 0 when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc which takes a void *")
+int alloc_obj_release(void *ctx)
+{
+	struct alloc_type *a;
+
+	a = bpf_obj_new(typeof(*a));
+	if (!a) {
+		return 0;
+	}
+	/* bpf_obj_drop_impl() takes a void *, so when we attempt to pass in
+	 * something with a reg->off, it should be rejected as we expect to have
+	 * the original pointer passed to the respective BPF helper unmodified.
+	 */
+	bpf_obj_drop(&a->n);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure
+__msg("R1 must have a fixed offset of 0 when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc which takes a void *")
+int BPF_PROG(mem_obj_release, struct file *file)
+{
+	int ret;
+	char *buf;
+
+	buf = bpf_ringbuf_reserve(&ringbuf, PATH_MAX, 0);
+	if (!buf)
+		return 0;
+
+	ret = bpf_d_path(&file->f_path, buf, PATH_MAX);
+	if (ret <= 0) {
+		bpf_ringbuf_discard(buf += 8, 0);
+		return 0;
+	}
+
+	bpf_ringbuf_submit(buf += 8, 0);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure
+__msg("dereference of modified ptr_ ptr R1 off=44 disallowed")
+__msg("R1 must have a fixed offset of 0 when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc which takes a void *")
+int BPF_PROG(type_match_mismatch, struct task_struct *task,
+	     u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	acquired = bpf_task_acquire(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+
+	bpf_task_release((struct task_struct *)&acquired->flags);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure
+__msg("kernel function bpf_task_acquire args#0 expected pointer to STRUCT task_struct")
+int BPF_PROG(trusted_type_match_mismatch, struct task_struct *task,
+	     u64 clone_flags)
+{
+	/* Passing a trusted pointer with incorrect offset will result in a type
+	 * mismatch.
+	 */
+	bpf_task_acquire((struct task_struct *)&bpf_get_current_task_btf()->flags);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure
+__msg("variable trusted_ptr_ access var_off=(0x0; 0xffffffff) disallowed")
+int BPF_PROG(trusted_type_match_mismatch_var_off, struct task_struct *task,
+	     u64 clone_flags)
+{
+	u32 var_off = bpf_get_prandom_u32();
+	task = bpf_get_current_task_btf();
+
+	task = (void *)task + var_off;
+	/* Passing a trusted pointer with an incorrect variable offset, type
+	 * match will succeed due to reg->off == 0, but the later call to
+	 * __check_ptr_off_reg should fail as it's responsible for checking
+	 * reg->var_off.
+	 */
+	bpf_task_acquire(task);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure
+__msg("variable trusted_ptr_ access var_off=(0x0; 0xffffffffffffffff) disallowed")
+int BPF_PROG(trusted_type_match_mismatch_neg_var_off, struct task_struct *task,
+	     u64 clone_flags)
+{
+	s64 var_off = task->start_time;
+	task = bpf_get_current_task_btf();
+
+	bpf_assert_range(var_off, -64, 64);
+	/* Need one bpf_throw() reference, otherwise BTF gen fails. */
+	if (!task)
+		bpf_throw(1);
+
+	task = (void *)task + var_off;
+	/* Passing a trusted pointer with an incorrect variable offset, type
+	 * match will succeed due to reg->off == 0, but the later call to
+	 * __check_ptr_off_reg should fail as it's responsible for checking
+	 * reg->var_off.
+	 */
+	task = bpf_task_acquire(task);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.45.2.627.g7a2c4fd464-goog

/M

