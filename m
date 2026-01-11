Return-Path: <bpf+bounces-78497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AB7D0F470
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 16:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64C5E301FD9E
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 15:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7036634BA3A;
	Sun, 11 Jan 2026 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiLmRuxW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5450094C
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768144993; cv=none; b=aKIB8TDcT5dqnz8qYH/0dSfzOQLyPbHHDuMtwiZwuF4GRonXu3DcsayQ8MZ9AptZJPAxiOSKT5TY34B7//LmZCf4J57Er+IOw+/AaUrV/ZDwpHc0WCV64ifElvodKYpkaKZP5EtWVbE5mEftfyUbvEd9H6XhYBEdn01W4xGBbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768144993; c=relaxed/simple;
	bh=d1ydm3gKxZdzyZB0ermFYELWfLV3UEhthu7rrhNueUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IivXa64OixqlOPKu2Cw4AvEk4Ypr5rsxwF0LYuP+TDtMf7+807zMd6QQGCWc0GEA8rAPiZ8jYLzC/oaCKYQUqD6MXCp6AKFsgDZ9aWwbj3Fpi/yaBTFah/03sPNnO+tQhXfqsJ3e4Agmew5ycg97he2O9wxdsXAfHXo2niA3FSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiLmRuxW; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6503b561daeso8889828a12.1
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 07:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768144989; x=1768749789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFNbx80lUnr19gIHqvaeAvYmpH54fJjhw+HUoiY0AAE=;
        b=UiLmRuxWjreWK663x2enpJMxM6mFUqPqdlS7+wpDwL9oyGYU3x4nzus5fQfVqgR7Ay
         TcZtJ3XdGA3Y74YN34mgqZ9LtXwPimGQH/87KWq6KgXDXebeaqxQR8lNZNNZXEIzhTXU
         oxbKue7T83jOiITEtJlMIpu2rdkeywmLmSxbR90o66AUemk6KQiWSqMBtMAGg9dLDE0G
         T3qCEOB0IhhID+l7NyGIquRz0MAb4x/ThhR3Hzx7NU5uHD7z4SZEuoq9HdUli+Kf5G7K
         sdlwnT3Q4pCC+iv7YyfzelLd56d9pqyOYhm+cl6SrQVng4lAcNf/3we044abAbNjv9/s
         Wr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768144989; x=1768749789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zFNbx80lUnr19gIHqvaeAvYmpH54fJjhw+HUoiY0AAE=;
        b=GE2EQPJ+4MAQUlwQjnGI4zpWtKi4tyV3DTL/wY+BtsZzWkVGn9QM4EAXeXmdFf6kYC
         ++TEt5tkTZXjJRKx5EGqufQqhTKl3quU86DV1f1KfD+Yc+VTUMXdp5niEcjmx9IsPgIo
         bvmYYjP5F5VB44Q3hrHDf9t6VABwWfJbccceV/dZynWGDuuGNz9A6BOTlzQkZdIhcHLf
         vdDKILF1eabpNUVGZDarRzk2C1gXU2l+UoIDuSK8VigUyUGBerNg7xMis8qo9RRHsjiL
         ZcqgzteBeWyR8zm4E4wwm6XC+jnftLLdUFHwLocgjyVCD4YtF6iymwhToFnc5HVY/hGR
         gWcw==
X-Gm-Message-State: AOJu0YyJf72h8xEeCcjfD8AJA4V3/XYWWUrf5MsZ7NKzNC4kjk+4SNew
	hTo+PvcTo9cFTSWAgW76oPt2evbSIK89lVqz/7Cjx+j6TK29Zw9EDKpyAmegcw==
X-Gm-Gg: AY/fxX44VWw4Rs9apGV94EQmJmLVem4etoWEWPYzk3j2jCU5fl6jegqLgPDXdb+PhVA
	0evcPD8poTeE46jgJMv1uuAMjevvbfcNX0OH9UVoGk0ZDA2J6gvVsoTVkmDGkuMlHGiSttiIIau
	1OgKZWeKEkcJFjexDbXEouEhmZGmQnNBcCre66r5xkljQlDWZEXOcosrfY00RTeUe52ATCffSMW
	RVmiA3pCtaHD0vFSZG9TDTYjvHOK1hSYqZ5NA7Pp+rEqTwYZLJ6Bs65OHJhnebBWecVq1EKJeUt
	6yJRqCiNR6SXWec28sNhmZS+YSvkEmIe3VGQTZvZEwS1MzhPoEsoGxAf4WVbTMhugwnEtY/okLw
	3d7+dfUJexaeqf4hCmhH2VVNOGSPUeD2X3xZ9dzMFJAhhGzR/U8xWZnGae3pc9Mt3NP9WLHAw1Z
	sIU1jYL/xh9kZBpzrVkRgnwZaS8BuKZw==
X-Google-Smtp-Source: AGHT+IEHis4eYwtJAj6H71BRsDffTwXoHdqi8pg4Sg3D/EbgGr+qS/DD/12M9NN7VHGJkMEINVF/4A==
X-Received: by 2002:a17:907:8dcd:b0:b87:12bc:24e7 with SMTP id a640c23a62f3a-b8712bc34acmr148552766b.62.1768144989236;
        Sun, 11 Jan 2026 07:23:09 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd08b2sm508698866b.25.2026.01.11.07.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 07:23:08 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: add tests for loading map values with offsets
Date: Sun, 11 Jan 2026 15:30:47 +0000
Message-Id: <20260111153047.8388-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111153047.8388-1-a.s.protopopov@gmail.com>
References: <20260111153047.8388-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ldimm64 instruction for map value supports an offset.
For insn array maps it wasn't tested before, as normally
such instructions aren't generated. However, this is still
possible to pass such instructions, so add a few tests to
check that correct offsets work properly and incorrect
offsets are rejected.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 208 ++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
index d138cc7b1bda..75b0cf2467ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
@@ -240,6 +240,208 @@ static void check_nonstatic_global_other_sec(struct bpf_gotox *skel)
 	bpf_link__destroy(link);
 }
 
+/*
+ * The following subtests do not use skeleton rather than to check
+ * if the test should be skipped.
+ */
+
+static int create_jt_map(__u32 max_entries)
+{
+	const char *map_name = "jt";
+	__u32 key_size = 4;
+	__u32 value_size = sizeof(struct bpf_insn_array_value);
+
+	return bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, map_name,
+			      key_size, value_size, max_entries, NULL);
+}
+
+static int prog_load(struct bpf_insn *insns, __u32 insn_cnt)
+{
+	return bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, NULL, "GPL", insns, insn_cnt, NULL);
+}
+
+static int __check_ldimm64_off_prog_load(__u32 max_entries, __u32 off)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW(BPF_REG_1, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int map_fd, ret;
+
+	map_fd = create_jt_map(max_entries);
+	if (!ASSERT_GE(map_fd, 0, "create_jt_map"))
+		return -1;
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze")) {
+		close(map_fd);
+		return -1;
+	}
+
+	insns[0].imm = map_fd;
+	insns[1].imm = off;
+
+	ret = prog_load(insns, ARRAY_SIZE(insns));
+	close(map_fd);
+	return ret;
+}
+
+/*
+ * Check that loads from an instruction array map are only allowed with offsets
+ * which are multiples of 8 and do not point to outside of the map.
+ */
+static void check_ldimm64_off_load(struct bpf_gotox *skel __always_unused)
+{
+	const __u32 max_entries = 10;
+	int prog_fd;
+	__u32 off;
+
+	for (off = 0; off < max_entries; off++) {
+		prog_fd = __check_ldimm64_off_prog_load(max_entries, off * 8);
+		if (!ASSERT_GE(prog_fd, 0, "__check_ldimm64_off_prog_load"))
+			return;
+		close(prog_fd);
+	}
+
+	prog_fd = __check_ldimm64_off_prog_load(max_entries, 7 /* not a multiple of 8 */);
+	if (!ASSERT_EQ(prog_fd, -EACCES, "__check_ldimm64_off_prog_load: should be -EACCES")) {
+		close(prog_fd);
+		return;
+	}
+
+	prog_fd = __check_ldimm64_off_prog_load(max_entries, max_entries * 8 /* too large */);
+	if (!ASSERT_EQ(prog_fd, -EACCES, "__check_ldimm64_off_prog_load: should be -EACCES")) {
+		close(prog_fd);
+		return;
+	}
+}
+
+static int __check_ldimm64_gotox_prog_load(struct bpf_insn *insns,
+					   __u32 insn_cnt,
+					   __u32 off1, __u32 off2)
+{
+	const __u32 values[] = {5, 7, 9, 11, 13, 15};
+	const __u32 max_entries = ARRAY_SIZE(values);
+	struct bpf_insn_array_value val = {};
+	int map_fd, ret, i;
+
+	map_fd = create_jt_map(max_entries);
+	if (!ASSERT_GE(map_fd, 0, "create_jt_map"))
+		return -1;
+
+	for (i = 0; i < max_entries; i++) {
+		val.orig_off = values[i];
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
+			       "bpf_map_update_elem")) {
+			close(map_fd);
+			return -1;
+		}
+	}
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze")) {
+		close(map_fd);
+		return -1;
+	}
+
+	/* r1 = &map + offset1 */
+	insns[0].imm = map_fd;
+	insns[1].imm = off1;
+
+	/* r1 += off2 */
+	insns[2].imm = off2;
+
+	ret = prog_load(insns, insn_cnt);
+	close(map_fd);
+	return ret;
+}
+
+static void reject_offsets(struct bpf_insn *insns, __u32 insn_cnt, __u32 off1, __u32 off2)
+{
+	int prog_fd;
+
+	prog_fd = __check_ldimm64_gotox_prog_load(insns, insn_cnt, off1, off2);
+	if (!ASSERT_EQ(prog_fd, -EACCES, "__check_ldimm64_gotox_prog_load"))
+		close(prog_fd);
+}
+
+/*
+ * Verify a bit more complex programs which include indirect jumps
+ * and with jump tables loaded with a non-zero offset
+ */
+static void check_ldimm64_off_gotox(struct bpf_gotox *skel __always_unused)
+{
+	struct bpf_insn insns[] = {
+		/*
+		 * The following instructions perform an indirect jump to
+		 * labels below. Thus valid offsets in the map are {0,...,5}.
+		 * The program rewrites the offsets in the instructions below:
+		 *     r1 = &map + offset1
+		 *     r1 += offset2
+		 *     r1 = *r1
+		 *     gotox r1
+		 */
+		BPF_LD_IMM64_RAW(BPF_REG_1, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0),
+
+		/* case 0: */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+		/* case 1: */
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+		/* case 2: */
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+		/* case 3: */
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_EXIT_INSN(),
+		/* case 4: */
+		BPF_MOV64_IMM(BPF_REG_0, 4),
+		BPF_EXIT_INSN(),
+		/* default: */
+		BPF_MOV64_IMM(BPF_REG_0, 5),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, err;
+	__u32 off1, off2;
+
+	/* allow all combinations off1 + off2 < 6 */
+	for (off1 = 0; off1 < 6; off1++) {
+		for (off2 = 0; off1 + off2 < 6; off2++) {
+			LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+			prog_fd = __check_ldimm64_gotox_prog_load(insns, ARRAY_SIZE(insns),
+								  off1 * 8, off2 * 8);
+			if (!ASSERT_GE(prog_fd, 0, "__check_ldimm64_gotox_prog_load"))
+				return;
+
+			err = bpf_prog_test_run_opts(prog_fd, &topts);
+			if (!ASSERT_OK(err, "test_run_opts err")) {
+				close(prog_fd);
+				return;
+			}
+
+			if (!ASSERT_EQ(topts.retval, off1 + off2, "test_run_opts retval")) {
+				close(prog_fd);
+				return;
+			}
+
+			close(prog_fd);
+		}
+	}
+
+	/* reject off1 + off2 >= 6 */
+	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 3, 8 * 3);
+	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 7, 8 * 0);
+	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 0, 8 * 7);
+
+	/* reject (off1 + off2) % 8 != 0 */
+	reject_offsets(insns, ARRAY_SIZE(insns), 3, 3);
+	reject_offsets(insns, ARRAY_SIZE(insns), 7, 0);
+	reject_offsets(insns, ARRAY_SIZE(insns), 0, 7);
+}
+
 void test_bpf_gotox(void)
 {
 	struct bpf_gotox *skel;
@@ -288,5 +490,11 @@ void test_bpf_gotox(void)
 	if (test__start_subtest("one-map-two-jumps"))
 		__subtest(skel, check_one_map_two_jumps);
 
+	if (test__start_subtest("check-ldimm64-off"))
+		__subtest(skel, check_ldimm64_off_load);
+
+	if (test__start_subtest("check-ldimm64-off-gotox"))
+		__subtest(skel, check_ldimm64_off_gotox);
+
 	bpf_gotox__destroy(skel);
 }
-- 
2.34.1


