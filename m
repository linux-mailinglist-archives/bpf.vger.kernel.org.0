Return-Path: <bpf+bounces-46587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC49D9EC1E3
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 03:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E860B188B2CF
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 02:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468A41FBE8A;
	Wed, 11 Dec 2024 02:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEa1+Wqm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712DDF4FA
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 02:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882529; cv=none; b=tYRiUE2wlJ4bht4ZTJHsK6BUfg8tnePmRJH6WoMKcJ/1z6p0ZIl8w2tfGdixtAANFxyYgSYD9SvoDqJgeGOFHUWnPm9k+IKC9AtxsVYhZdr6Kp4xeLkcxCCIrl2OTUt1oWrdY/w02MdvKpUTLCln4hZfTTf/f7NjdCrFxegTXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882529; c=relaxed/simple;
	bh=owfMrzeTFEKt3Jw317Z+wSPwG3T5xhYc2c/t7VU/3ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbThMNZO5fLEvS/4chiCBVIol0Q0PNlleVH1AFMYXaeGmTHb4KlEAxcI0fUxrX9Wi6h6ABAE9WYzRvml6jHjY4OR8qwl8Qvu1ztFQmIvyf7W0enTwnqLti2AWx7zhlVCj39+c/zOfdrpew5ciZZiQS+RyRdD5Ctat3OUlcqR6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEa1+Wqm; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3863703258fso101049f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 18:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733882525; x=1734487325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igFABNjSKbV8j0wfEZN3yEanAzd04M5NQMR79pHoVEc=;
        b=iEa1+Wqmb/sMrqWkvw0eBU94wHmw2I1ZczAmh7oQooIDE54kSzlO2JVDl0QHa9gKLw
         +nFV2jr0clytjo1pUg2wrlrZcfBcZmJd9b4RtAJCSBCcOPSqYMj4+HLUww3wEMFtENqI
         ZASOl7qELqlT9160RRrAU8mYP54U2vyxX/EJuqihQ02VL6cq2CgYxyTQ/KyPaxALz/5G
         5bSKbKDIvf54L7MCTUwKMHKc/R1xYQTXtHBf3hq1/0eJIWnSxJqut3DraiQMsZU8tSVV
         JRYVs9O7gKZ5Et6ETvBhw+F0MRA2RgN2P+5UvMRGGNwFn0trHU9xCEmTSRQ8rJQ872v0
         uvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733882525; x=1734487325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igFABNjSKbV8j0wfEZN3yEanAzd04M5NQMR79pHoVEc=;
        b=fl2Uf6C9ZcAzOtfVmfbLGtDczFPt79o3PJFCa0B15Lo3aA2U4eS7ieFbFgcdQSFjRI
         oAPuw7KAHMLG/aWhZ7iCwo4SUPoQ5fC+4x6b5fQSKOaQwoeIeHFsN3jaJYxNcMGHGEWU
         xVNiVbmr1vcFUJjOcSMH8+XJtqgSC1H8sdc1cwJV5Nc8exjFjCOV6wB/Y4wmGsJPqpaT
         i0/IXfuJV0g+66INpZuOJmtA2IG2F2USFGXIADtJ2y8r/zDgCvRHCe34I6/TdalyWwpm
         9bs+ENdkwLvpIkt3us7dO6vMzBzl9qAmhXTysFWJGlFbaeLZVucaf9xG3WnrsnPR22/X
         fUkA==
X-Gm-Message-State: AOJu0Yxb8VvWp49bhlL2uaonpRWo7HIM3g7e5u9q+BlC+oEkoboMuuyc
	URlI5J2dOZP7HFw8Xkp8nC1oqoYTN6ENthXwbQN1nqx6mjA0OOM5o2QIAYi0FHg=
X-Gm-Gg: ASbGncsHdLrjxqYfMZtlDqDgwlqpCMOEp9OBOshMWUxoZEFGAQdmIe64rlMPd9X3z3v
	OXqs0NKuL8uPr2J3WQq1VKSy4Z07UUQI12XHFaigixopr/w6Q5V1NrHrPE3s3CY5vEOJES6btI4
	7TBNcYlJa2a3VnokdIEBUIbBs/PHfjJJfxpfSohafvWIuR3DwvBWHR8UDwTvD5NriWs3TaDr042
	q/cNQS+paa2B9e5Oh/8tVt6yhScPAwOEf92Jx4mT2Giff9wnNSHfYJSe2jnh36MoGiO+OaquuNZ
	3fyW
X-Google-Smtp-Source: AGHT+IEyyT7YP6Zkef+sqlHkR/RejjNLQRYug0brZuEscxrvSP+8KpLlpaJWXhBTzYucg87ZVTTE0g==
X-Received: by 2002:a05:6000:1788:b0:385:f349:ffe5 with SMTP id ffacd0b85a97d-3864df17281mr485966f8f.29.1733882525329;
        Tue, 10 Dec 2024 18:02:05 -0800 (PST)
Received: from localhost (fwdproxy-cln-006.fbsv.net. [2a03:2880:31ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251dc77sm74740f8f.100.2024.12.10.18.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 18:02:04 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Manu Bretelle <chantra@meta.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v1 4/4] selftests/bpf: Add autogenerated tests for raw_tp NULL args
Date: Tue, 10 Dec 2024 18:01:56 -0800
Message-ID: <20241211020156.18966-5-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211020156.18966-1-memxor@gmail.com>
References: <20241211020156.18966-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23479; h=from:subject; bh=owfMrzeTFEKt3Jw317Z+wSPwG3T5xhYc2c/t7VU/3ks=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnWPJWHoFb/2mqPYrw+fOVL4R8xdcsxj46zwsK4aFv 9sQoYYmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1jyVgAKCRBM4MiGSL8RyuDrD/ wLv6sEIMf10lvja4pyxNeEPXSweUU2lKOfxjYaEUJ7mqzhdk1YFmXd9VN7OxPc54eHHt0VxhXKA66b 8ESIiOu4ffpOS5DehpWzXWkYb2q6OH3QJTZn/tAl+EpZ+6ehsqX6K5sWHyS+VteZ+VRT9V9ABbuKWT S+EVPHPD4ulh4B/U5nxQSzRHqPiDnX47xmDU+Okq9eq9LWMO53lX4934FQ60ZBTuQPyveAlwy2FPbB hGvEJHQDW6cS4B951uw1z8V7TIcXF6PeFac+yv0P7DDN1/Ut5PVqznrtxWYLGlcDlr78JRD5Qmvujp k7X4J16nyWxbO+0Ooi78BunvoVck5X+UoH6IEWZYQHWvuPS47Owbr2aYSZYJMS9PLzZ7a4MQvC8+Kj 06URMZcdqE+1BXQfUWL5voNJxRb3prHixMvfDZU8Po5LOhdHC6aEU+gKPA6fK9kzd8/JOIuELmAWpr 2DIlnTUFfuQoHLqHbMSYT7cYxgDoWNi9EaAx4llyarNzM2tdNQ/uqo21vOrBYEQC6PCtHq48SC2yPy qsHQSXy37Y9AsYzSZjy8CU8DLa4PTecwsabvBND63FACRIOOPnH9Cq/ZIIMDOQZw+NsHphjesbgg1v qq2X4vEsMByRCnEagdIJ1jLLo3CF/BULXTJdyabekwlMVVJpGGf+ciVAe2RA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add bash and python scripts that process the RAW_TP_NULL_ARGS list in
kernel/bpf/btf.c and produce selftests automatically. This is not done
automatically on build as the file requires some human-guided post
processing (like disabling certain tests for which we don't enable
CONFIG options), and only needs to be run once when growing the list.

Once the list generation becomes automatic in kernel/bpf/btf.c, the
script can run on build, or be modified if we support __nullable BTF
type tags in the future to parse them and generate tests accordingly.

The tests basically ensure the pointer is marked or_null_, and likewise
for raw_tp_scalar.c case (where it needs to be marked scalar).

Enable enough config options to cover all but 4 without increasing build
time significantly. By enabling AFS, CACHEFILES, and INFINIBAND, we gain
enough coverage to cover distinct cases and positional arguments.

The config is modified to include some new options to test most options,
but driver tracepoints that include too much stuff are disabled manually
after the script produces it's output.

Whenever adding a new RAW_TP_NULL_ARGS specification or removing one,
the developer can run this script to update the selftest, reject hunks
removing the comments around disabled tracepoints, and accept other
hunks that are relevant for the newly added tracepoint.

There are some tracepoints manually hardcoded in btf_ctx_access that
have an IS_ERR argument type. For now, these are manually encoded in
raw_tp_scalar.c, but if the list grows, we can introduce a new mask
for IS_ERR args, an ERR_ARG() macro, and augment the script to generate
tests for these cases and ensure argument is marked scalar.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/config            |   5 +
 .../testing/selftests/bpf/gen_raw_tp_null.py  |  58 +++
 .../testing/selftests/bpf/gen_raw_tp_null.sh  |   3 +
 .../selftests/bpf/prog_tests/raw_tp_null.c    |  12 +
 .../testing/selftests/bpf/progs/raw_tp_null.c | 417 ++++++++++++++++++
 .../selftests/bpf/progs/raw_tp_scalar.c       |  24 +
 6 files changed, 519 insertions(+)
 create mode 100755 tools/testing/selftests/bpf/gen_raw_tp_null.py
 create mode 100755 tools/testing/selftests/bpf/gen_raw_tp_null.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_scalar.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 4ca84c8d9116..75d3416e2c11 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -112,3 +112,8 @@ CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
 CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TCP_CONG_BBR=y
+CONFIG_AFS_FS=y
+CONFIG_FSCACHE=y
+CONFIG_CACHEFILES=y
+CONFIG_CACHEFILES_ONDEMAND=y
+CONFIG_INFINIBAND=y
diff --git a/tools/testing/selftests/bpf/gen_raw_tp_null.py b/tools/testing/selftests/bpf/gen_raw_tp_null.py
new file mode 100755
index 000000000000..4d15a5b92012
--- /dev/null
+++ b/tools/testing/selftests/bpf/gen_raw_tp_null.py
@@ -0,0 +1,58 @@
+#!/usr/bin/python3
+import re
+import sys
+
+def parse_null_args(arg_str):
+    pattern = r'NULL_ARG\((\d+)\)'
+    numbers = []
+    for part in arg_str.split('|'):
+        part = part.strip()
+        match = re.match(pattern, part)
+        if match:
+            numbers.append(int(match.group(1)))
+    return numbers
+
+def parse_tracepoint_line(line):
+    line = line.strip().rstrip(',')
+    match = re.match(r'RAW_TP_NULL_ARGS\(([^,]+),\s*(.*)\)', line)
+
+    if match:
+        tp_name = match.group(1).strip()
+        arg_part = match.group(2).strip()
+        arg_nums = parse_null_args(arg_part)
+        if arg_nums:
+            return tp_name, arg_nums
+    return None, None
+
+def generate_tests(entries):
+    tests = []
+
+    for tp_name, arg_nums in entries:
+        for arg_num in arg_nums:
+            test = ['', 'SEC("tp_btf/' + tp_name + '")',
+                    '__failure __msg("R1 invalid mem access \'trusted_ptr_or_null_\'")',
+                    f'int test_raw_tp_null_{tp_name}_arg_{arg_num}(void *ctx) {{']
+            n = (arg_num - 1) * 8
+            test.append(f'    asm volatile("r1 = *(u64 *)(r1 +{n}); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);')
+            test.extend(['    return 0;', '}'])
+            tests.extend(test)
+    return '\n'.join(tests)
+
+# Read directly from stdin
+entries = []
+for line in sys.stdin:
+    tp_name, arg_num = parse_tracepoint_line(line)
+    if tp_name and arg_num is not None:
+        entries.append((tp_name, arg_num))
+print(
+'''// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+/* WARNING: This file is automatically generated, run gen_raw_tp_null.sh to update! */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";''')
+print(generate_tests(entries))
diff --git a/tools/testing/selftests/bpf/gen_raw_tp_null.sh b/tools/testing/selftests/bpf/gen_raw_tp_null.sh
new file mode 100755
index 000000000000..1c99757f7baf
--- /dev/null
+++ b/tools/testing/selftests/bpf/gen_raw_tp_null.sh
@@ -0,0 +1,3 @@
+#!/bin/bash
+
+cat ../../../../kernel/bpf/btf.c  | grep RAW_TP_NULL_ARGS | grep -v "define RAW_TP" | ./gen_raw_tp_null.py | tee progs/raw_tp_null.c
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
new file mode 100644
index 000000000000..bb5524eabde9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "raw_tp_null.skel.h"
+#include "raw_tp_scalar.skel.h"
+
+void test_raw_tp_null(void)
+{
+	RUN_TESTS(raw_tp_null);
+	RUN_TESTS(raw_tp_scalar);
+}
diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null.c b/tools/testing/selftests/bpf/progs/raw_tp_null.c
new file mode 100644
index 000000000000..fd4de11b587f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+/* WARNING: This file is automatically generated, run gen_raw_tp_null.sh to update! */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("tp_btf/sched_pi_setprio")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_sched_pi_setprio_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/sched_stick_numa")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_sched_stick_numa_arg_3(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +16); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/sched_swap_numa")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_sched_swap_numa_arg_3(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +16); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/afs_make_fs_call")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_afs_make_fs_call_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/afs_make_fs_calli")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_afs_make_fs_calli_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/afs_make_fs_call1")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_afs_make_fs_call1_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/afs_make_fs_call2")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_afs_make_fs_call2_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/afs_protocol_error")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_afs_protocol_error_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/afs_flock_ev")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_afs_flock_ev_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_lookup")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_lookup_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_unlink")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_unlink_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_rename")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_rename_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_prep_read")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_prep_read_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_mark_active")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_mark_active_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_mark_failed")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_mark_failed_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_mark_inactive")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_mark_inactive_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_vfs_error")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_vfs_error_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_io_error")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_io_error_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_ondemand_open")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_ondemand_open_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_ondemand_copen")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_ondemand_copen_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_ondemand_close")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_ondemand_close_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_ondemand_read")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_ondemand_read_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_ondemand_cread")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_ondemand_cread_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_ondemand_fd_write")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_ondemand_fd_write_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_ondemand_fd_release")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_cachefiles_ondemand_fd_release_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/ext4_mballoc_discard")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_ext4_mballoc_discard_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/ext4_mballoc_free")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_ext4_mballoc_free_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/fib_table_lookup")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_fib_table_lookup_arg_3(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +16); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/posix_lock_inode")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_posix_lock_inode_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/fcntl_setlk")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_fcntl_setlk_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/locks_remove_posix")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_locks_remove_posix_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/flock_lock_inode")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_flock_lock_inode_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/break_lease_noblock")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_break_lease_noblock_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/break_lease_block")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_break_lease_block_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/break_lease_unblock")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_break_lease_unblock_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/generic_delete_lease")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_generic_delete_lease_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/time_out_leases")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_time_out_leases_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+/* Disabled due to missing CONFIG
+SEC("tp_btf/host1x_cdma_push_gather")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_host1x_cdma_push_gather_arg_5(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +32); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+*/
+
+SEC("tp_btf/mm_khugepaged_scan_pmd")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_mm_khugepaged_scan_pmd_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/mm_collapse_huge_page_isolate")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_mm_collapse_huge_page_isolate_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/mm_khugepaged_scan_file")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_mm_khugepaged_scan_file_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/mm_khugepaged_collapse_file")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_mm_khugepaged_collapse_file_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/mm_page_alloc")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_mm_page_alloc_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/mm_page_pcpu_drain")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_mm_page_pcpu_drain_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/mm_page_alloc_zone_locked")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_mm_page_alloc_zone_locked_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/netfs_failure")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_netfs_failure_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+/* Disabled due to missing CONFIG
+SEC("tp_btf/device_pm_callback_start")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_device_pm_callback_start_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+*/
+
+SEC("tp_btf/qdisc_dequeue")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_qdisc_dequeue_arg_4(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +24); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/rxrpc_recvdata")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_rxrpc_recvdata_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/rxrpc_resend")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_rxrpc_resend_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+/* Disabled due to missing CONFIG
+SEC("tp_btf/xs_stream_read_data")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_xs_stream_read_data_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+*/
+
+SEC("tp_btf/tcp_send_reset")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_tcp_send_reset_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/tcp_send_reset")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_tcp_send_reset_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+/* Disabled due to missing CONFIG
+SEC("tp_btf/tegra_dma_tx_status")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_tegra_dma_tx_status_arg_3(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +16); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+*/
+
+SEC("tp_btf/tmigr_update_events")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_tmigr_update_events_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/writeback_dirty_folio")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_writeback_dirty_folio_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/folio_wait_writeback")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_folio_wait_writeback_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/raw_tp_scalar.c b/tools/testing/selftests/bpf/progs/raw_tp_scalar.c
new file mode 100644
index 000000000000..b44bb9a94305
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/raw_tp_scalar.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+/* Since we have a couple of cases, we just write this file by hand. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("tp_btf/mr_integ_alloc")
+__failure __msg("R1 invalid mem access 'scalar'")
+int test_raw_tp_scalar_mr_integ_alloc_arg_4(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +24); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+SEC("tp_btf/cachefiles_lookup")
+__failure __msg("R1 invalid mem access 'scalar'")
+int test_raw_tp_scalar_cachefiles_lookup_arg_3(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +16); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
-- 
2.43.5


