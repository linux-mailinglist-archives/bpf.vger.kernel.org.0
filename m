Return-Path: <bpf+bounces-60677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72968ADA161
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 10:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BE6170FFF
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6719263C75;
	Sun, 15 Jun 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noS+25Nz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667E264614
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749977734; cv=none; b=Gks1QIda7xixtBFSA2d/RD4TydB+HRgdonvcQAvBhvvJkXkQPe8cUdjHoo8Iv4kuXlmrHofjKj9NiVcAmJahQFGIYTLMZU3jQzn9uc0CjX9gBoiEqSogwNZoTSWUyGh7H22efodMDjpGX4GpHsJL37y98v9rUnbXvNGbKEc9K3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749977734; c=relaxed/simple;
	bh=g3xZqoLE6vO073eUjl0utUrEY2j9rRfeFuSub7povXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Su9NgHShTDGcwxAp8oTzZkfsFBmofZILrYRD+b9MyMW5pIp5nsRxSXvkNomWvKcQGZRCe/miUEeT21D8QzNqWtPfoZ/LkASVrTg3L/OTmbIyaKNfm8BH6L5ieRLSQdqp26tme+dBDx8Wy0C5isnsUJ923PKjIFh4Aacc5XFdGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noS+25Nz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso2305850f8f.2
        for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749977728; x=1750582528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4k6RIbq98CAs8zHBK0/ubL/d7GpmUv/29Z+fnMwiQw=;
        b=noS+25NzH4BWZ7xa7PHwC/3fvH4/1vCpsnNa/GZvzpNBtKZqMSKYe4kL2HGbLf3gAk
         Dp+d7HsJ4gOmiPEuxtj55ds/dAlDbLGH2sRt+6FBRpKhl6b25eiQLQlhvPEHdY4ZnUCo
         DymEN8Zj1cZ2iDWPFkcqJ0pDkeXlxoTzOuwK8ioXC8boZA/h1/got1CQdkI5l+0R21LS
         aTFWKp+afKDvo740BzxqoX4aTGNfs4s/SnlwzIvvcLxq80v04A9ZDq945jeh7X0DNcOc
         jjd+N9kieoB3zNnZqIE4tw+EpLHLk/UlchJe0kKXiqrb3YpdhMx6MvSy5a4rN9g3NA9M
         l8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749977728; x=1750582528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4k6RIbq98CAs8zHBK0/ubL/d7GpmUv/29Z+fnMwiQw=;
        b=Bl6MpmsA+IIWlCLIejyr8W5a0sYUqySvxG2hsMOZu2pa61ONOIEPtFzk+0FE2KCQRK
         +YDPHEYRoPO/TijgC0z/M79gWbIULEU52lDKGeH1JsiCRWe3C2liPHyEZqiPVQPz6XFg
         t6ZV5oOoI0pzEMoTxOqdtR5/52SmjBwdV1pOuxtO2lIuyrQVt10Ct+gSHJIkYvX44fjr
         yvsherRvThammEgZ1wm3Xviuauoe3StR+iZ6gKXRje54klxGvG1ABWb3JsjGrl5ix61R
         LBkR/8pFx1d0ChqX8PB0eluodNZWb14SMeDVqyqdaP87fXwetBmK7zu99oHrAC3yneQC
         478Q==
X-Gm-Message-State: AOJu0Yydwd4QyvRz9lsYip/kpNl4PzqMn7JrXlv5AMhwVsvlJ+4NbsUG
	FbllNEQGABIW/7q0xFFROmTX6GttJPwq5BuK8cgkTCYWkIh42Q6GI2NH2y1MFw==
X-Gm-Gg: ASbGnctzQxHs+QAJ2wtdl5dCBEtDNk+7tJhsb67IE7rwRk3PBMekXM34DKZynd932lx
	Gw2jSqH0Pa+vI7reuJXImnB+0FbPeLRA0r1aA87x8n9107T93lH92e468MvATtySj49IaygYDVd
	UH6JFs4YaMgk+1ibz3PziHSC4JASeRkv/upyggVM3LD5uDnoxJybwgLV6dpTzRMexUXmM9Fh0ko
	AEoCzFIN5WtC9X6jKAB3hjGj5aXBSSIE2VGn5jFguC1T7RkklOwva5/6aLhujOQD3hErizP4Nox
	2HVV54Mrz20Iy5vu6+ZqV/1BGFOz9YK8gdJTr9tQM062ZQZIAlyloriHT6+F4seutwFsq1Wmeus
	MlxOO0A==
X-Google-Smtp-Source: AGHT+IFRXwCTILssgB71M4cY+Nsq5FRlk5165qMPCYWIf6ZPWDHPtflhoV1fatkeC6g0u7s4M81W+A==
X-Received: by 2002:a05:6000:40db:b0:3a4:ea40:4d3f with SMTP id ffacd0b85a97d-3a572e5d78emr4542661f8f.53.1749977728403;
        Sun, 15 Jun 2025 01:55:28 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm7196105f8f.26.2025.06.15.01.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 01:55:27 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [RFC bpf-next 3/9] selftests/bpf: add selftests for new insn_set map
Date: Sun, 15 Jun 2025 08:59:37 +0000
Message-Id: <20250615085943.3871208-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests are split in two parts.

The `bpf_insn_set_ops` test checks that the map is managed properly:

  * Incorrect instruction indexes are rejected
  * Non-sorted and non-unique indexes are rejected
  * Unfrozen maps are not accepted
  * Two programs can't use the same map
  * BPF progs can't operate the map

The `bpf_insn_set_reloc` part validates, as best as it can do it from user
space, that instructions are relocated properly:

  * no relocations => map is the same
  * expected relocations when instructions are added
  * expected relocations when instructions are deleted
  * expected relocations when multiple functions are present

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_insn_set.c   | 481 ++++++++++++++++++
 1 file changed, 481 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
new file mode 100644
index 000000000000..5138e54d522a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <bpf/bpf.h>
+#include <test_progs.h>
+
+static int map_create(__u32 map_type, __u32 max_entries)
+{
+	const char *map_name = "insn_set";
+	__u32 key_size = 4;
+	__u32 value_size = sizeof(struct bpf_insn_set_value);
+
+	return bpf_map_create(map_type, map_name, key_size, value_size, max_entries, NULL);
+}
+
+static int prog_load(struct bpf_insn *insns, __u32 insn_cnt, int *fd_array, __u32 fd_array_cnt)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+
+	opts.fd_array = fd_array;
+	opts.fd_array_cnt = fd_array_cnt;
+
+	return bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, &opts);
+}
+
+/*
+ * Load a program, which will not be anyhow mangled by the verifier.  Add an
+ * insn_set map pointing to every instruction. Check that it hasn't changed
+ * after the program load.
+ */
+static void check_one_to_one_mapping(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 4),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd;
+	struct bpf_insn_set_value val = {};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val.xlated_off = i;
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val.xlated_off, i, "val should be equal i");
+	}
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+/*
+ * Try to load a program with a map which points to outside of the program
+ */
+static void check_out_of_bounds_index(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 4),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, map_fd;
+	struct bpf_insn_set_value val = {};
+	int key;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, 1);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	key = 0;
+	val.xlated_off = ARRAY_SIZE(insns); /* too big */
+	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_update_elem"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	errno = 0;
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected (prog_fd != -EINVAL)")) {
+		close(prog_fd);
+		goto cleanup;
+	}
+
+cleanup:
+	close(map_fd);
+}
+
+/*
+ * Try to load a program with a map which points to the middle of 16-bit insn
+ */
+static void check_mid_insn_index(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64(BPF_REG_0, 0), /* 2 x 8 */
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, map_fd;
+	struct bpf_insn_set_value val = {};
+	int key;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, 1);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	key = 0;
+	val.xlated_off = 1; /* middle of 16-byte instruction */
+	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_update_elem"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	errno = 0;
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected (prog_fd != -EINVAL)")) {
+		close(prog_fd);
+		goto cleanup;
+	}
+
+cleanup:
+	close(map_fd);
+}
+
+static void check_incorrect_index(void)
+{
+	check_out_of_bounds_index();
+	check_mid_insn_index();
+}
+
+/*
+ * Load a program with two patches (get jiffies, for simplicity). Add an
+ * insn_set map pointing to every instruction. Check how it was relocated
+ * after the program load.
+ */
+static void check_relocate_simple(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd;
+	__u32 map_in[] = {0, 1, 2, 3, 4, 5};
+	__u32 map_out[] = {0, 1, 4, 5, 8, 9};
+	struct bpf_insn_set_value val = {};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val.xlated_off = map_in[i];
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
+			       "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val.xlated_off, map_out[i], "val should be equal map_out[i]");
+	}
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+/*
+ * Verifier can delete code in two cases: nops & dead code. From the relocation
+ * point of view, the two cases look the same, so test using the simplest
+ * method: by loading some nops
+ */
+static void check_relocate_deletions(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd;
+	__u32 map_in[] = {0, 1, 2, 3, 4, 5};
+	__u32 map_out[] = {0, -1, 1, -1, 2, 3};
+	struct bpf_insn_set_value val = {};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val.xlated_off = map_in[i];
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
+			       "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val.xlated_off, map_out[i], "val should be equal map_out[i]");
+	}
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+static void check_relocate_with_functions(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd;
+	__u32 map_in[] =  { 0, 1,  2, 3, 4, 5, /* func */  6, 7,  8, 9, 10};
+	__u32 map_out[] = {-1, 0, -1, 3, 4, 5, /* func */ -1, 6, -1, 9, 10};
+	struct bpf_insn_set_value val = {};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val.xlated_off = map_in[i];
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
+			       "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val.xlated_off, map_out[i], "val should be equal map_out[i]");
+	}
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+/* Once map was initialized, it should be frozen */
+static void check_load_unfrozen_map(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd;
+	struct bpf_insn_set_value val = {};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val.xlated_off = i;
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	errno = 0;
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected (prog_fd != -EINVAL)"))
+		goto cleanup;
+
+	/* correctness: now freeze the map, the program should load fine */
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val.xlated_off, i, "val should be equal i");
+	}
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+/* Map can be used only by one BPF program */
+static void check_no_map_reuse(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd, extra_fd = -1;
+	struct bpf_insn_set_value val = {};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val.xlated_off = i;
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val.xlated_off, i, "val should be equal i");
+	}
+
+	errno = 0;
+	extra_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_EQ(extra_fd, -EBUSY, "program should have been rejected (extra_fd != -EBUSY)"))
+		goto cleanup;
+
+	/* correctness: check that prog is still loadable without fd_array */
+	extra_fd = prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD): expected no error"))
+		goto cleanup;
+
+cleanup:
+	close(extra_fd);
+	close(prog_fd);
+	close(map_fd);
+}
+
+static void check_bpf_no_lookup(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_FD(BPF_REG_1, 0),
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, 1);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	/* otherwise will be rejected as unfrozen */
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	insns[0].imm = map_fd;
+
+	errno = 0;
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
+	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected (prog_fd != -EINVAL)"))
+		goto cleanup;
+
+	/* correctness: check that prog is still loadable with normal map */
+	close(map_fd);
+	map_fd = map_create(BPF_MAP_TYPE_ARRAY, 1);
+	insns[0].imm = map_fd;
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+static void check_bpf_side(void)
+{
+	check_bpf_no_lookup();
+}
+
+/* Test how relocations work */
+void test_bpf_insn_set_reloc(void)
+{
+	if (test__start_subtest("one2one"))
+		check_one_to_one_mapping();
+
+	if (test__start_subtest("relocate-simple"))
+		check_relocate_simple();
+
+	if (test__start_subtest("relocate-deletions"))
+		check_relocate_deletions();
+
+	if (test__start_subtest("relocate-multiple-functions"))
+		check_relocate_with_functions();
+}
+
+/* Check all kinds of operations and related restrictions */
+void test_bpf_insn_set_ops(void)
+{
+	if (test__start_subtest("incorrect-index"))
+		check_incorrect_index();
+
+	if (test__start_subtest("load-unfrozen-map"))
+		check_load_unfrozen_map();
+
+	if (test__start_subtest("no-map-reuse"))
+		check_no_map_reuse();
+
+	if (test__start_subtest("bpf-side-ops"))
+		check_bpf_side();
+}
-- 
2.34.1


