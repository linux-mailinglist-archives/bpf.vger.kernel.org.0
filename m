Return-Path: <bpf+bounces-21072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C970C8474E4
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE72E1C22335
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 16:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8E3148FF8;
	Fri,  2 Feb 2024 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="GuKrmqWU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F332F148FEB
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891667; cv=none; b=VW+2VtYvaeeVUy+f8NOqKe5QtOGGapQ/yGbto1JiDJGNDH4xVG1Y3fAhgy/0K52r3U1qZcpbuP80AzmSUZNdpFVgUB1359Biw8rSvCeaZ/o0nSV4vhrPf3NFGAJTLeQ9jFRcUM88VB5nATvNcaRRSLMJdrEZdXnLiCiP/TCDNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891667; c=relaxed/simple;
	bh=UZhWlT5mcK3zCufZWDMll9/QiRC2NNAsSv3V3fN9KbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pitP8VNgODZ24aCzyanHj7OS9FclAPFgzZgx6Sru6ShCDdW0wBm5bw54cRc9Ly95CFExnc4L1XVIKUoEwD4lz6mr8A42g4aQR8SHgxZUA/Y67UHkWA/csgRCmxwuCMDPKn/31Z/iTx6NsCo7rCbwWrsBLpsa9KyA46ZX63mYARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=GuKrmqWU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55790581457so3388514a12.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 08:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706891664; x=1707496464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4lZr8ol6h5LmQWBe/QEm3mdW7gWf8SzZeol8g09eZM=;
        b=GuKrmqWUs2Lfqg76hB9HS+JsK7R4gnxyZEtSXckfdxJiVvNOV9nBYtw6jjfuVXmDQg
         JkqyjXO+TuNKDi9Qn5yiUspnlCfGhtrNMXQn4YnyNYZ3Oo1CfSPSbMlkqgzY/QcRXJCh
         Z6Z0GCNtXGDIU3ZYPhjpIGvsdDQ+MYtnTqOClzjvjILWJCXxpiMIMOPDDhTHs/RIq9BM
         nfWUKARIBpf53VXMh9q4lSzMmXWTS4DOVOQW46EZ+uYeVQx0NwXV3YggeWZF7D8MnJhG
         dt1doQoHA/8Wz2eOaMdAMM15FP2M/kKNoP90hBWxTIBFIUphuSpzxb7mJ/u2HdRvgJmO
         KSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891664; x=1707496464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4lZr8ol6h5LmQWBe/QEm3mdW7gWf8SzZeol8g09eZM=;
        b=Owhh1PtdmdrV1vNONlEfUuQeVdT1z8lTO75LNRuI3BW7jqCQwCfJTyiwQ7Hhkrm3Tb
         6og/V8znQMq33oRm4HJcCJXC7JtIecqRzv7LHQ2Bq9G059UWT6dX/EwRCROH8t7JzYfL
         qpIQImyUPIAixQtagLLwtLj5OolIf7yWNGDEpYJT6N1S8arePGyKKoEvYzCwwnPHvG8X
         mkiv9GwFMMUK90UcXpB4HYO81fS+mMftSV+BSTCF+WFXQbLnOeFqMK8aSPGRzrQaZGXf
         DGdv9KtblxTYlJQ/93p4lFORBbqRCMc1T0drWdHG8gaLaoTBO4WL8cou4M4lFwS5eqEX
         uLSw==
X-Gm-Message-State: AOJu0Yy04IvMLzO00Fca88MOxZWv7+P8rBKsj3UzMUKREXnVpH2Pu6ss
	5f548f1Yn84iVEc6+2ph5/MaVnQJlr2rXZLjKwsDmvByog1Vu+fJX0dVEflIUJg=
X-Google-Smtp-Source: AGHT+IHzN0RhAJg8oXbyRbO9nZuZd1EcDyiOQI9Vw/WzNQQ08pjNs4+vuc/6gI7NpXO68EmCZPE9WQ==
X-Received: by 2002:aa7:d58b:0:b0:55e:f52d:1825 with SMTP id r11-20020aa7d58b000000b0055ef52d1825mr121513edq.35.1706891664241;
        Fri, 02 Feb 2024 08:34:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX7k4zJbXNVAnB+f6mYz5GFJjM3lkV4CViVNTQaAq1Q5iTUrvd/k29GuWXWQI/jD8m6ewzJAckiGQlCfN+n999qtchTOExcMpFtF7kstmQGmUaLqX5dQ8PBNGtaV2mDmnp3MYZTM7ZD/M+Wtm+GXtY2L7yDyiOPAw3U7UgjI1A5R2M/fwlqLB82gvepsCxCDsSplLiYcsvIRAV2Ibk8Y4h8LH7+XvxPX+pbes5BQMYBcspNV5yeHrLQBZKdwEuv6dU5cbxB3RWe3AEmFVEjtvvAY+eBHD5UFORRS7qPd4g56I9jPGBRTko=
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id l19-20020aa7c313000000b0055edbe94b34sm952544edq.54.2024.02.02.08.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:23 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 9/9] selftests/bpf: Add tests for new ja* instructions
Date: Fri,  2 Feb 2024 16:28:13 +0000
Message-Id: <20240202162813.4184616-10-aspsk@isovalent.com>
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

Add several self-tests to test the new instructions and the new
BPF_STATIC_BRANCH_UPDATE syscall.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 .../bpf/prog_tests/bpf_static_branches.c      | 269 ++++++++++++++++++
 1 file changed, 269 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_static_branches.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_static_branches.c b/tools/testing/selftests/bpf/prog_tests/bpf_static_branches.c
new file mode 100644
index 000000000000..6f54002e6e15
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_static_branches.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Isovalent */
+
+#include <test_progs.h>
+
+#include <sys/syscall.h>
+#include <bpf/bpf.h>
+
+static inline int _bpf_prog_load(struct bpf_insn *insns, __u32 insn_cnt)
+{
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = insn_cnt,
+		.license   = ptr_to_u64("GPL"),
+	};
+
+	return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+}
+
+enum {
+	OFF,
+	ON
+};
+
+static inline int bpf_static_branch_update(int prog_fd, __u32 insn_off, __u32 on)
+{
+	union bpf_attr attr = {
+		.static_branch.prog_fd = (__u32)prog_fd,
+		.static_branch.insn_off = insn_off,
+		.static_branch.on = on,
+	};
+
+	return syscall(__NR_bpf, BPF_STATIC_BRANCH_UPDATE, &attr, sizeof(attr));
+}
+
+#define BPF_JMP32_OR_NOP(IMM, OFF)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_JMP32 | BPF_JA | BPF_K,		\
+		.dst_reg = 0,					\
+		.src_reg = BPF_STATIC_BRANCH_JA,		\
+		.off   = OFF,					\
+		.imm   = IMM })
+
+#define BPF_JMP_OR_NOP(IMM, OFF)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_JMP | BPF_JA | BPF_K,		\
+		.dst_reg = 0,					\
+		.src_reg = BPF_STATIC_BRANCH_JA,		\
+		.off   = OFF,					\
+		.imm   = IMM })
+
+#define BPF_NOP_OR_JMP32(IMM, OFF)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_JMP32 | BPF_JA | BPF_K,		\
+		.dst_reg = 0,					\
+		.src_reg = BPF_STATIC_BRANCH_JA |		\
+			   BPF_STATIC_BRANCH_NOP,		\
+		.off   = OFF,					\
+		.imm   = IMM })
+
+#define BPF_NOP_OR_JMP(IMM, OFF)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_JMP | BPF_JA | BPF_K,		\
+		.dst_reg = 0,					\
+		.src_reg = BPF_STATIC_BRANCH_JA |		\
+			   BPF_STATIC_BRANCH_NOP,		\
+		.off   = OFF,					\
+		.imm   = IMM })
+
+static const struct bpf_insn insns0[] = {
+	BPF_JMP_OR_NOP(0, 1),
+	BPF_NOP_OR_JMP(0, 1),
+	BPF_JMP32_OR_NOP(1, 0),
+	BPF_NOP_OR_JMP32(1, 0),
+};
+
+static void check_ops(void)
+{
+	struct bpf_insn insns[] = {
+		{}, /* we will substitute this by insn0[i], i=0,1,2,3 */
+		BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+		BPF_JMP_IMM(BPF_JA, 0, 0, -2),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP,
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+	};
+	bool stop = false;
+	int prog_fd[4];
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		insns[0] = insns0[i];
+		prog_fd[i] = _bpf_prog_load(insns, ARRAY_SIZE(insns));
+		if (!ASSERT_GE(prog_fd[i], 0, "correct program"))
+			stop = true;
+	}
+
+	for (i = 0; i < 4; i++)
+		close(prog_fd[i]);
+
+	if (stop)
+		return;
+
+	/* load should fail: incorrect SRC */
+	for (i = 0; i < 4; i++) {
+		insns[0] = insns0[i];
+		insns[0].src_reg |= 4;
+		prog_fd[i] = _bpf_prog_load(insns, ARRAY_SIZE(insns));
+		if (!ASSERT_EQ(prog_fd[i], -1, "incorrect src"))
+			return;
+	}
+
+	/* load should fail: incorrect DST */
+	for (i = 0; i < 4; i++) {
+		insns[0] = insns0[i];
+		insns[0].dst_reg = i + 1; /* non-zero */
+		prog_fd[i] = _bpf_prog_load(insns, ARRAY_SIZE(insns));
+		if (!ASSERT_EQ(prog_fd[i], -1, "incorrect dst"))
+			return;
+	}
+
+	/* load should fail: both off and imm are set */
+	for (i = 0; i < 4; i++) {
+		insns[0] = insns0[i];
+		insns[0].imm = insns[0].off = insns0[i].imm ?: insns0[i].off;
+		prog_fd[i] = _bpf_prog_load(insns, ARRAY_SIZE(insns));
+		if (!ASSERT_EQ(prog_fd[i], -1, "incorrect imm/off"))
+			return;
+	}
+
+	/* load should fail: offset is incorrect */
+	for (i = 0; i < 4; i++) {
+		insns[0] = insns0[i];
+
+		if (insns0[i].imm)
+			insns[0].imm = -2;
+		else
+			insns[0].off = -2;
+		prog_fd[i] = _bpf_prog_load(insns, ARRAY_SIZE(insns));
+		if (!ASSERT_EQ(prog_fd[i], -1, "incorrect imm/off"))
+			return;
+
+		if (insns0[i].imm)
+			insns[0].imm = 42;
+		else
+			insns[0].off = 42;
+		prog_fd[i] = _bpf_prog_load(insns, ARRAY_SIZE(insns));
+		if (!ASSERT_EQ(prog_fd[i], -1, "incorrect imm/off"))
+			return;
+
+		/* 0 is not allowed */
+		insns[0].imm = insns[0].off = 0;
+		prog_fd[i] = _bpf_prog_load(insns, ARRAY_SIZE(insns));
+		if (!ASSERT_EQ(prog_fd[i], -1, "incorrect imm/off"))
+			return;
+	}
+
+	/* incorrect field is used */
+	for (i = 0; i < 4; i++) {
+		int tmp;
+
+		insns[0] = insns0[i];
+
+		tmp = insns[0].imm;
+		insns[0].imm = insns[0].off;
+		insns[0].off = tmp;
+
+		prog_fd[i] = _bpf_prog_load(insns, ARRAY_SIZE(insns));
+		if (!ASSERT_EQ(prog_fd[i], -1, "incorrect field"))
+			return;
+	}
+}
+
+static void check_syscall(void)
+{
+	struct bpf_insn insns[] = {
+		{}, /* we will substitute this by insn0[i], i=0,1,2,3 */
+		BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+		BPF_JMP_IMM(BPF_JA, 0, 0, -2),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP,
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+	};
+	bool stop = false;
+	int prog_fd[4];
+	__u32 insn_off;
+	int ret;
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		insns[0] = insns0[i];
+		prog_fd[i] = _bpf_prog_load(insns, ARRAY_SIZE(insns));
+		if (!ASSERT_GE(prog_fd[i], 0, "correct program"))
+			stop = true;
+	}
+
+	if (stop)
+		goto end;
+
+	for (i = 0; i < 4; i++) {
+		/* we can set branch off */
+		ret = bpf_static_branch_update(prog_fd[i], 0, OFF);
+		if (!ASSERT_EQ(ret, 0, "correct update"))
+			goto end;
+
+		/* we can set branch on */
+		ret = bpf_static_branch_update(prog_fd[i], 0, ON);
+		if (!ASSERT_EQ(ret, 0, "correct update"))
+			goto end;
+
+		/* incorrect.static_branch.on: can only be 0|1 */
+		ret = bpf_static_branch_update(prog_fd[i], 0, 2);
+		if (!ASSERT_EQ(ret, -1, "incorrect static_branch.on value"))
+			goto end;
+
+		/* incorrect static_branch.insn_off: can only be 0 in this case */
+		for (insn_off = 1; insn_off < 5; insn_off++) {
+			ret = bpf_static_branch_update(prog_fd[i], insn_off, OFF);
+			if (!ASSERT_EQ(ret, -1, "incorrect insn_off: not a correct insns"))
+				goto end;
+			if (!ASSERT_EQ(errno, EINVAL, "incorrect insn_off: not a correct insns"))
+				goto end;
+		}
+		ret = bpf_static_branch_update(prog_fd[i], 666, OFF);
+		if (!ASSERT_EQ(ret, -1, "incorrect insn_off: out of range"))
+			goto end;
+		if (!ASSERT_EQ(errno, ERANGE, "incorrect insn_off: out puf range"))
+			goto end;
+
+		/* bad file descriptor: no open file */
+		ret = bpf_static_branch_update(-1, 0, OFF);
+		if (!ASSERT_EQ(ret, -1, "incorrect prog_fd: no file"))
+			goto end;
+		if (!ASSERT_EQ(errno, EBADF, "incorrect prog_fd: no file"))
+			goto end;
+
+		/* bad file descriptor: not a bpf prog */
+		ret = bpf_static_branch_update(0, 0, OFF);
+		if (!ASSERT_EQ(ret, -1, "incorrect prog_fd: not a bpf prog"))
+			goto end;
+		if (!ASSERT_EQ(errno, EINVAL, "incorrect prog_fd: not a bpf prog"))
+			goto end;
+	}
+
+end:
+	for (i = 0; i < 4; i++)
+		close(prog_fd[i]);
+
+}
+
+void test_bpf_static_branches(void)
+{
+	if (test__start_subtest("check_ops"))
+		check_ops();
+
+	if (test__start_subtest("check_syscall"))
+		check_syscall();
+}
-- 
2.34.1


