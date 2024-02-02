Return-Path: <bpf+bounces-21067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B12318474DC
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53D51C22547
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946514830D;
	Fri,  2 Feb 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="d19JqL/y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF451487E8
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891663; cv=none; b=UqMaY9PW0zZpzVOnec5a4TCOGZdNrJVQJkf7O71W4RsHlXVaCn4OBaBgUMDk3z1FW9zDnM61eqs04MmD/IcizZLIVS0L7lnI/xucjYv2mnreQGlUbGYBqVzWGCbcfs863XbqWp9ZcHmTvk07iM9rTcFEPk5eX9nl0TpEMqapVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891663; c=relaxed/simple;
	bh=4CKXPN/OMsn2X7A9LSY1+30WXAoBGGBrtjADl9xmZDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vpjs+WpbmYh5yCBC+aDuSy6oJ/UiH+iQl0pwKehOsg3/sQ68fLt7PdOo6eq6gk5v+EqO4GQYf4hHjfoi7OT/llAJ41aOwLoUYkvTZ/Mp83xFV1vV4/Oa6xEFuFK3QDQD/YbVv/zLKjANKmoIzAm6+Ei0HTazZ6lOYCVdmIh7Auw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=d19JqL/y; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so3221507a12.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 08:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706891659; x=1707496459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcgWct5g6icTJo6bXdXUt1he4RpRZ3Wqq8A1ZwrEFbs=;
        b=d19JqL/yEHId0KpKeYtrf+dJB0WN6faSg7m3mHzjcaxnGl+pgFQjBnSv0ewWFGf4hz
         YWuJ3s0PnQJX10f4MIP3EWzxDR6ixL2IaPVxc2XrduC6/uxNiPBSzDdu5PVuA9Okjsd+
         jXmtLKwdsl2x+3JcJhfYmSt411uvZoj7dyyN23yI6vVFVZebfqewdfVxU4va+oCo9ZI0
         U8XErCOBqPCEXmXQqdDnwKdZPEm3RCDC9nDk9F4nb3bgLCLdvWv4POCdDNLGol98+7/p
         +18pjkwgBLxBx5ozrSXFfsAIilNlfijCdRZV+xZBTGrDQEvUJyVJUSjf4AY8lgMeZRPa
         83wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891659; x=1707496459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcgWct5g6icTJo6bXdXUt1he4RpRZ3Wqq8A1ZwrEFbs=;
        b=g75Z+LSLcpe1Q6hAlrem+OfbFzRHAxbaVMM87kys0dt9I8AsYpGuwXZXpiXdxWH/Sv
         IG3Nu7LWBWBQUnjh9OgkHOurhQ31EwWFgCxQsHTRTcyz4TLf+NCaFZ3WvcCsvn/NqwGw
         0l1ySKsQBpM8FefFnvGU5wNzNjt0Vtn0b/zwKsvXA3nxD0L3JkcS5vvnxUUV6mGu+zzk
         17+UUsoCuLd/2tLEKKskErgGuqFn3veae4wDg6y5hnCNxB4Om5v9GClrd9HIW79pqvnP
         ts4U8UVAWw5N2xwBmc+OZocuSf0PMo1DykEz2b5iNDxlJruDgj5Hx7FrwaCmajAlKfY4
         UbUw==
X-Gm-Message-State: AOJu0Ywjxe/UATmzkQFR74ajO7JD+KEILmH8N471R0ZvR8vc0O/ewL99
	xqJfVxiGgnkzwMaCXqRHI5zrPUDuC7iXNAxwKxFNTVyRBlu2Oqvvuh5wCwHjPdI=
X-Google-Smtp-Source: AGHT+IHF2ZbsROoFWIZ/jZwJznQH7F92GuJ2EbKe9NJQwSU2N/ks7eObi/7JyXHGa54kzkkBpM1Mzg==
X-Received: by 2002:a05:6402:60b:b0:55f:8054:93fb with SMTP id n11-20020a056402060b00b0055f805493fbmr129570edv.29.1706891659482;
        Fri, 02 Feb 2024 08:34:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWEhHTGLnpKemETPZwGKPzCAeLj2TisX7+NAMYRmPMzdb/S8XqZ3wTOv4E479ViAwK3koRCjHqFYFSIVqryvvQCOizX6767VqzCIYhsxGCFcFBeKBUKDhc4JXr03KpsOJ5lLKAwWaliRpgPrLoHizOiBFuCNCdzGeeulhz7WmRGFpAPaOegM1Cypf4PolzrQrfwlAEaQwUlUjmKYlGaQ2vR92JVnWDpyEHxJfWyRXVgPakKF3P8DkZMBrZsy9NScD0d2/q2ib8JOEhQncxf9fzkGtxjYnRrlFtyTiuARNzgUfXbMwcHEWo=
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id l19-20020aa7c313000000b0055edbe94b34sm952544edq.54.2024.02.02.08.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:18 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v1 bpf-next 4/9] selftests/bpf: Add tests for instructions mappings
Date: Fri,  2 Feb 2024 16:28:08 +0000
Message-Id: <20240202162813.4184616-5-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202162813.4184616-1-aspsk@isovalent.com>
References: <20240202162813.4184616-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several self-tests to test the instructions mappings from xlated
to original:

    * check that mappings work for a program without patches
    * same for a program with patches to insns
    * same for a program with patches to insns and bpf-to-bpf calls
    * same for a program with patches and deletions
    * same for a program with patches, deletions, and bpf-to-bpf calls

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 .../bpf/prog_tests/bpf_insns_mappings.c       | 156 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_insns_mappings.c  | 155 +++++++++++++++++
 2 files changed, 311 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insns_mappings.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_insns_mappings.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insns_mappings.c b/tools/testing/selftests/bpf/prog_tests/bpf_insns_mappings.c
new file mode 100644
index 000000000000..2a7b53231080
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insns_mappings.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Isovalent */
+
+#include <test_progs.h>
+#include "bpf_insns_mappings.skel.h"
+
+#define MAX_INSNS 4096
+
+static struct bpf_prog_info *prog_info_and_mappings(int prog_fd)
+{
+	static __thread struct bpf_prog_info prog_info;
+	static __thread char xlated_insns[MAX_INSNS];
+	static __thread __u32 orig_idx[MAX_INSNS];
+	__u32 prog_info_len;
+	__u32 orig_idx_len;
+	int err;
+
+	prog_info_len = sizeof(prog_info);
+
+	memset(&prog_info, 0, sizeof(prog_info));
+	err = bpf_prog_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
+	if (!ASSERT_GE(err, 0, "bpf_prog_get_info_by_fd"))
+		return NULL;
+
+	orig_idx_len = prog_info.orig_idx_len;
+	memset(&prog_info, 0, sizeof(prog_info));
+
+	if (orig_idx_len) {
+		prog_info.orig_idx_len = orig_idx_len;
+		prog_info.orig_idx = ptr_to_u64(orig_idx);
+	}
+
+	prog_info.xlated_prog_insns = ptr_to_u64(xlated_insns);
+	prog_info.xlated_prog_len = sizeof(xlated_insns);
+
+	err = bpf_prog_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
+	if (!ASSERT_GE(err, 0, "bpf_prog_get_info_by_fd"))
+		return NULL;
+
+	return &prog_info;
+}
+
+static int beef_search_original(const struct bpf_insn *insns, int n_insns, int *idx, int n_max)
+{
+	int i, n_found = 0;
+
+	for (i = 0; i < n_insns; i++) {
+		if (insns[i].imm == 0xbeef) {
+			if (!ASSERT_LT(n_found, n_max, "beef"))
+				return -1;
+			idx[n_found++] = i;
+		}
+	}
+
+	return n_found;
+}
+
+static int beef_search_xlated(struct bpf_prog_info *info, int *idx, int len)
+{
+	struct bpf_insn *insns = u64_to_ptr(info->xlated_prog_insns);
+	int tot = info->xlated_prog_len / 8;
+	int i, n = 0;
+
+	for (i = 0; i < tot; i++) {
+		if (insns[i].imm == 0xbeef) {
+			if (!ASSERT_LT(n, len, "beef"))
+				return -1;
+			idx[n++] = ((__u32 *)u64_to_ptr(info->orig_idx))[i];
+		}
+	}
+
+	return n;
+}
+
+static void beef_check(const struct bpf_program *prog, int n_expected)
+{
+	struct bpf_prog_info *prog_info;
+	int idx_expected[MAX_INSNS];
+	int idx[MAX_INSNS];
+	int prog_fd;
+	int n, i;
+
+	/*
+	 * Find all beef instructions in the original program
+	 */
+
+	n = beef_search_original(bpf_program__insns(prog),
+				 bpf_program__insn_cnt(prog),
+				 idx_expected, MAX_INSNS);
+	if (!ASSERT_EQ(n, n_expected, "search original insns"))
+		return;
+
+	/*
+	 * Now find all the beef instructions in the xlated program and extract
+	 * corresponding orig_idx mappings
+	 */
+	prog_fd = bpf_program__fd(prog);
+	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd"))
+		return;
+
+	prog_info = prog_info_and_mappings(prog_fd);
+	if (!ASSERT_OK_PTR(prog_info, "prog_info_and_mappings"))
+		return;
+
+	if (!ASSERT_EQ(beef_search_xlated(prog_info, idx, n), n, "total # of beef"))
+		return;
+
+	/*
+	 * Check that the orig_idx points to the correct original indexes
+	 */
+	for (i = 0; i < n; i++)
+		ASSERT_EQ(idx[i], idx_expected[i], "beef index");
+}
+
+static void check_prog(const struct bpf_program *prog, int n_expected)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	beef_check(prog, n_expected);
+
+	bpf_link__destroy(link);
+}
+
+void test_bpf_insns_mappings(void)
+{
+	struct bpf_insns_mappings *skel;
+
+	skel = bpf_insns_mappings__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_insns_mappings__open"))
+		return;
+
+	if (!ASSERT_OK(bpf_insns_mappings__load(skel),
+		  "bpf_insns_mappings__load"))
+		return;
+
+	if (test__start_subtest("check_trivial_prog"))
+		check_prog(skel->progs.check_trivial_prog, 3);
+
+	if (test__start_subtest("check_simple_prog"))
+		check_prog(skel->progs.check_simple_prog, 3);
+
+	if (test__start_subtest("check_bpf_to_bpf"))
+		check_prog(skel->progs.check_bpf_to_bpf, 6);
+
+	if (test__start_subtest("check_prog_dead_code"))
+		check_prog(skel->progs.check_prog_dead_code, 13);
+
+	if (test__start_subtest("check_prog_dead_code_bpf_to_bpf"))
+		check_prog(skel->progs.check_prog_dead_code_bpf_to_bpf, 26);
+
+	bpf_insns_mappings__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_insns_mappings.c b/tools/testing/selftests/bpf/progs/bpf_insns_mappings.c
new file mode 100644
index 000000000000..f6ff690801ea
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_insns_mappings.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, u64);
+} just_a_map SEC(".maps");
+
+static inline void beef(void)
+{
+	asm volatile("r8 = 0xbeef" ::: "r8");
+}
+
+static inline void cafe(void)
+{
+	asm volatile("r7 = 0xcafe" ::: "r7");
+}
+
+/*
+ * Trivial program: every insn maps to the original index
+ */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_trivial_prog(void *ctx)
+{
+	beef();
+	cafe();
+	beef();
+	cafe();
+	beef();
+
+	return 0;
+}
+
+/* Some random instructions which will be patched for sure */
+static inline void beefify(void)
+{
+	__u32 key = 0;
+	__u64 *x;
+
+	beef();
+	bpf_printk("%llx", bpf_jiffies64());
+	beef();
+
+	key = !!bpf_jiffies64();
+	x = bpf_map_lookup_elem(&just_a_map, &key);
+	if (!x)
+		return;
+
+	beef();
+}
+
+/*
+ * Simple program: one section, no bpf-to-bpf calls, some patches
+ */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_simple_prog(void *ctx)
+{
+	beefify();
+	return 0;
+}
+
+int __noinline foobar(int x)
+{
+	beefify();
+	return x;
+}
+
+/*
+ * Same simple program + a bpf-to-bpf call
+ */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_bpf_to_bpf(void *ctx)
+{
+	beefify();
+
+	return foobar(0);
+}
+
+static inline void dead_code1(void)
+{
+	asm volatile("goto +0");
+}
+
+static inline void dead_code100(void)
+{
+#	if defined(__clang__)
+#		pragma clang loop unroll_count(100)
+#	elif defined(__GNUC__)
+#		pragma GCC unroll 100
+#	else
+#		error "unroll this loop, please"
+#	endif
+	for (int i = 0; i < 100; i++)
+		asm volatile("goto +0");
+}
+
+/*
+ * Some beef instructions, patches, plus dead code
+ */
+static __always_inline void dead_beef(void)
+{
+	beef();		/* 1 beef */
+	dead_code1();
+	beef();		/* 1 beef */
+	dead_code1();
+	beef();		/* 1 beef */
+	dead_code100();
+	beef();		/* 1 beef */
+
+	dead_code100();
+	beefify();	/* 3 beef */
+	dead_code100();
+	beefify();	/* 3 beef */
+	dead_code1();
+	beefify();	/* 3 beef */
+
+	/* 13 beef insns total */
+}
+
+/*
+ * A program with some nops to be removed
+ */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_prog_dead_code(void *ctx)
+{
+	dead_beef();
+
+	return 0;
+}
+
+int __noinline foobar2(int x)
+{
+	dead_beef();
+
+	return x;
+}
+
+/*
+ * A program with some nops to be removed + a bpf-to-bpf call to a similar func
+ */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_prog_dead_code_bpf_to_bpf(void *ctx)
+{
+	dead_beef();
+
+	return foobar2(0);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


