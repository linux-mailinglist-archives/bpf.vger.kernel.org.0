Return-Path: <bpf+bounces-54324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A18A6766D
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743B342365B
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B0320D50C;
	Tue, 18 Mar 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="e/4Wr6FB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151020E00A
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308207; cv=none; b=FvpUTBGewSJ65nQuL1pPulfixhjGfmV4gAVpT61VV8GdbCsqDUELcCxxCvyGQ0y8ZvcAuXom+PXjwIeaMOIi6djJzYO22X1BtGuY8XFoq2JO5X8PJEjm3u7uyQSDLbd6eftjPoeCrfn723qRaMoD5AfKkQ1DJFA8Nttwl23EavM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308207; c=relaxed/simple;
	bh=HhnFCRvJd1R/ArCA8jejW8R6TOTaQM+a5n1G3HvVsPM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XM7GrZjSvwftX2x0Uo1F7c5qAG67m7mzKKj5pRaRbaCUl+b4NP6KHkJdf+TbRVIUfIoUJys14NLH0jBsQ9xeSpTBDae5KZ0FJXOqBu6CZiY7sUWqRWGSYtxH7nBDGPS26PjGkqGdNp0YaPQFqd1DmojBKKjRUH5yskThaineocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=e/4Wr6FB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso25240085e9.0
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308200; x=1742913000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UZzeYYkzQK7t58AqMuKshbn3e7tI+uy8ybJOS+AN14=;
        b=e/4Wr6FBOv8q612nw5t5Z/+JMXGqSeTY3Njx0lt9M0Nr8WNA6aYOec201alkU6gSPK
         1/t9g4S6j2IQFz9R5vqt/by2SS/warn+Ua7RGdqHIPE10OyUKAxQR6op260WbAIChu0f
         4Z+G1bpMsi4tz6Pz9KUSPTw68Il5dhq5NYCh6wiYeZXmKjdZL3ii0takHWaKXCaxqVzD
         aOMoX9/ayuif1faltjIJvo+pLNjpOz5+UjJxTzrAdWdpvyWgOIO0d8X9LDd6xUy4cAz6
         mUhXx/nvxJLwoZmPh4oI3KTzxm3uQRLkMRjYCyCoKGdglPP+IdD/iBESAofhr4ZwK77o
         JD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308200; x=1742913000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UZzeYYkzQK7t58AqMuKshbn3e7tI+uy8ybJOS+AN14=;
        b=FNgTEclldbM39sIHFopTfjkFjO+XpI1uD50rsisohHFofUm6bY+bs5QuGj60pNFsP6
         Hl6SH+aVs98T1/WOabusy8PY+R7xfXi8OJb9R4FdvXBZJwIGNSfPDgyeOaK+Ngwn9V+Q
         v5Q9qEVPIxqGQMBRX0YgJdHayjTwDMMkttsP5Ga2+GYpdLC/c8aXOgFLbpd8W34emWaB
         qCSTNnC2BOrnu51IKEIfvV9r45Ffkq1DT7JqbsIXXN4kQn+VfJzkkWBrpmzg/N/NO7i/
         X316cNeEVxxvVfTvvejvDRFpvgWEEgQG2A2voGd0fohCmabTeSH/37CyLsi1rx8L3Z4q
         +/VA==
X-Gm-Message-State: AOJu0YxL6MoLzR7lsUiqPZTEGCvVR+SprJJtft+wixr+t0Ug8F5s5xdU
	qLus5TlqHuzLUbwK5e4BSve2qwTlqPfLjqoyrjZiH6rGznuA1hpsy3CMDagwQ5ty1ufa4YD6RRt
	e
X-Gm-Gg: ASbGncuRuZIN2HKvJmDjOwMxbNptMk3RQiYmNv5kymIkyPA91iaXOvVEy+OQ51/sLxi
	NCGgIoyDFOOz17KnWPmNUnYYYNSckaBGh4Sy3IqSpBW+K+nzaA93Hka0k2EIlctS3wtrxUetmCn
	0Cp2Gy16eUX3K0velaW7sJiy08djCYSB/IUY11m9zgOlnNqMgd3Tp1E0KpL/9oRKHwuyYEl/2HZ
	xt1WYlwqWpiAxGxbBwVVU9amNMP1WE2TrkS0J4Z/x40i2McTcD1WRJLv+Brkn7R0WqPCzWNeuZ+
	k5hSBzgfpBIxpiI4VyGCXenLc2UOS8aM8OzIq6VXGAxQG8Ez8juwOQadaA==
X-Google-Smtp-Source: AGHT+IFt4xpzL2AYapNS7T8S3DB13XBZUl9DNgRa4dhnK2In5fb4T/gM5P503uruP0hR4VcLiPlt7Q==
X-Received: by 2002:a05:600c:470d:b0:43d:17f1:2640 with SMTP id 5b1f17b1804b1-43d3ba0753bmr20634595e9.26.1742308199724;
        Tue, 18 Mar 2025 07:29:59 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:59 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 14/14] selftests/bpf: Add tests for BPF static calls
Date: Tue, 18 Mar 2025 14:33:18 +0000
Message-Id: <20250318143318.656785-15-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add self-tests to test new BPF_STATIC_BRANCH_JA jump instructions
and the BPF_STATIC_KEY_UPDATE syscall.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 .../bpf/prog_tests/bpf_static_keys.c          | 359 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_static_keys.c     | 131 +++++++
 2 files changed, 490 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_static_keys.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c b/tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
new file mode 100644
index 000000000000..3f105d36743b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#include <sys/syscall.h>
+#include <bpf/bpf.h>
+
+#include "bpf_static_keys.skel.h"
+
+#define VAL_ON	7
+#define VAL_OFF	3
+
+enum {
+	OFF,
+	ON
+};
+
+static int _bpf_prog_load(struct bpf_insn *insns, __u32 insn_cnt)
+{
+	return bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, NULL);
+}
+
+static int _bpf_static_key_update(int map_fd, __u32 on)
+{
+	LIBBPF_OPTS(bpf_static_key_update_opts, opts);
+
+	opts.on = on;
+
+	return bpf_static_key_update(map_fd, &opts);
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
+/* Lower-level selftests for the gotol_or_nop/nop_or_gotol instructions */
+static void check_insn(void)
+{
+	struct bpf_insn insns[] = {
+		{}, /* we will substitute this by insn0[i], i=0,1,2,3 */
+		BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+		BPF_JMP_IMM(BPF_JA, 0, 0, -2),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
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
+		if (!ASSERT_EQ(prog_fd[i], -EINVAL, "incorrect src"))
+			return;
+	}
+
+	/* load should fail: incorrect DST */
+	for (i = 0; i < 4; i++) {
+		insns[0] = insns0[i];
+		insns[0].dst_reg = i + 1; /* non-zero */
+		prog_fd[i] = _bpf_prog_load(insns, ARRAY_SIZE(insns));
+		if (!ASSERT_EQ(prog_fd[i], -EINVAL, "incorrect dst"))
+			return;
+	}
+
+	/* load should fail: both off and imm are set */
+	for (i = 0; i < 4; i++) {
+		insns[0] = insns0[i];
+		insns[0].imm = insns[0].off = insns0[i].imm ?: insns0[i].off;
+		prog_fd[i] = _bpf_prog_load(insns, ARRAY_SIZE(insns));
+		if (!ASSERT_EQ(prog_fd[i], -EINVAL, "incorrect imm/off"))
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
+		if (!ASSERT_EQ(prog_fd[i], -EINVAL, "incorrect imm/off"))
+			return;
+
+		if (insns0[i].imm)
+			insns[0].imm = 42;
+		else
+			insns[0].off = 42;
+		prog_fd[i] = _bpf_prog_load(insns, ARRAY_SIZE(insns));
+		if (!ASSERT_EQ(prog_fd[i], -EINVAL, "incorrect imm/off"))
+			return;
+
+		/* 0 is not allowed */
+		insns[0].imm = insns[0].off = 0;
+		prog_fd[i] = _bpf_prog_load(insns, ARRAY_SIZE(insns));
+		if (!ASSERT_EQ(prog_fd[i], -EINVAL, "incorrect imm/off"))
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
+		if (!ASSERT_EQ(prog_fd[i], -EINVAL, "incorrect field"))
+			return;
+	}
+}
+
+static void trigger_prog(void)
+{
+	usleep(1);
+}
+
+static void __check_one_key(struct bpf_static_keys *skel,
+			    struct bpf_map *key,
+			    int val_off,
+			    int val_on)
+{
+	int map_fd;
+	int ret;
+
+	map_fd = bpf_map__fd(key);
+	if (!ASSERT_GT(map_fd, 0, "key"))
+		return;
+
+	ret = _bpf_static_key_update(map_fd, ON);
+	if (!ASSERT_EQ(ret, 0, "_bpf_static_key_update(ON)"))
+		return;
+	skel->bss->ret_user = 0;
+	trigger_prog();
+	if (!ASSERT_EQ(skel->bss->ret_user, val_on, "skel->bss->ret_user"))
+		return;
+
+	_bpf_static_key_update(map_fd, OFF);
+	skel->bss->ret_user = 0;
+	trigger_prog();
+	if (!ASSERT_EQ(skel->bss->ret_user, val_off, "skel->bss->ret_user"))
+		return;
+}
+
+static void check_one_key(struct bpf_static_keys *skel, struct bpf_program *prog, struct bpf_map *key)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	__check_one_key(skel, key, VAL_OFF, VAL_ON);
+
+	bpf_link__destroy(link);
+}
+
+static void check_one_key_multiple(struct bpf_static_keys *skel, struct bpf_map *key)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(skel->progs.check_one_key_multiple);
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	__check_one_key(skel, key, VAL_OFF * 3, VAL_ON * 3);
+
+	bpf_link__destroy(link);
+}
+
+static void check_one_key_long_jump(struct bpf_static_keys *skel, struct bpf_map *key)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(skel->progs.check_one_key_long_jump);
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	__check_one_key(skel, key, 1000, 2000);
+
+	bpf_link__destroy(link);
+}
+
+static void __check_multiple_keys(struct bpf_static_keys *skel,
+				  struct bpf_map *key1,
+				  struct bpf_map *key2,
+				  int val_off_off,
+				  int val_off_on,
+				  int val_on_off,
+				  int val_on_on)
+{
+	int map_fd1, map_fd2;
+	int ret;
+
+	map_fd1 = bpf_map__fd(key1);
+	if (!ASSERT_GT(map_fd1, 0, "key1"))
+		return;
+
+	map_fd2 = bpf_map__fd(key2);
+	if (!ASSERT_GT(map_fd2, 0, "key2"))
+		return;
+
+	ret = _bpf_static_key_update(map_fd1, OFF);
+	if (!ASSERT_EQ(ret, 0, "_bpf_static_key_update(key1, OFF)"))
+		return;
+	ret = _bpf_static_key_update(map_fd2, OFF);
+	if (!ASSERT_EQ(ret, 0, "_bpf_static_key_update(key2, OFF)"))
+		return;
+	skel->bss->ret_user = 0;
+	trigger_prog();
+	if (!ASSERT_EQ(skel->bss->ret_user, val_off_off, "skel->bss->ret_user"))
+		return;
+
+	ret = _bpf_static_key_update(map_fd1, ON);
+	if (!ASSERT_EQ(ret, 0, "_bpf_static_key_update(key1, ON)"))
+		return;
+	ret = _bpf_static_key_update(map_fd2, OFF);
+	if (!ASSERT_EQ(ret, 0, "_bpf_static_key_update(key2, OFF)"))
+		return;
+	skel->bss->ret_user = 0;
+	trigger_prog();
+	if (!ASSERT_EQ(skel->bss->ret_user, val_off_on, "skel->bss->ret_user"))
+		return;
+
+	ret = _bpf_static_key_update(map_fd1, OFF);
+	if (!ASSERT_EQ(ret, 0, "_bpf_static_key_update(key1, OFF)"))
+		return;
+	ret = _bpf_static_key_update(map_fd2, ON);
+	if (!ASSERT_EQ(ret, 0, "_bpf_static_key_update(key2, ON)"))
+		return;
+	skel->bss->ret_user = 0;
+	trigger_prog();
+	if (!ASSERT_EQ(skel->bss->ret_user, val_on_off, "skel->bss->ret_user"))
+		return;
+
+	ret = _bpf_static_key_update(map_fd1, ON);
+	if (!ASSERT_EQ(ret, 0, "_bpf_static_key_update(key1, ON)"))
+		return;
+	ret = _bpf_static_key_update(map_fd2, ON);
+	if (!ASSERT_EQ(ret, 0, "_bpf_static_key_update(key2, ON)"))
+		return;
+	skel->bss->ret_user = 0;
+	trigger_prog();
+	if (!ASSERT_EQ(skel->bss->ret_user, val_on_on, "skel->bss->ret_user"))
+		return;
+}
+
+static void check_multiple_keys(struct bpf_static_keys *skel,
+				struct bpf_map *key1,
+				struct bpf_map *key2)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(skel->progs.check_multiple_keys);
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	__check_multiple_keys(skel, key1, key2, 0, 3, 30, 33);
+
+	bpf_link__destroy(link);
+}
+
+static void check_bpf_to_bpf_call(struct bpf_static_keys *skel,
+				  struct bpf_map *key1,
+				  struct bpf_map *key2)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(skel->progs.check_bpf_to_bpf_call);
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	__check_multiple_keys(skel, key1, key2, 0, 303, 3030, 3333);
+
+	bpf_link__destroy(link);
+}
+
+static void check_syscall(void)
+{
+	struct bpf_static_keys *skel;
+
+	skel = bpf_static_keys__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_static_keys__open_and_load"))
+		return;
+
+	check_one_key(skel, skel->progs.check_one_key_likely, skel->maps.key1);
+	check_one_key(skel, skel->progs.check_one_key_unlikely, skel->maps.key2);
+	check_one_key_multiple(skel, skel->maps.key3);
+	check_one_key_long_jump(skel, skel->maps.key4);
+	check_multiple_keys(skel, skel->maps.key5, skel->maps.key6);
+
+	bpf_static_keys__destroy(skel);
+}
+
+void test_bpf_static_keys(void)
+{
+	if (test__start_subtest("check_insn"))
+		check_insn();
+
+	if (test__start_subtest("check_syscall"))
+		check_syscall();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_static_keys.c b/tools/testing/selftests/bpf/progs/bpf_static_keys.c
new file mode 100644
index 000000000000..79272de8e682
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_static_keys.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, u32);
+} just_map SEC(".maps");
+
+int ret_user;
+
+#define VAL_ON	7
+#define VAL_OFF	3
+
+DEFINE_STATIC_KEY(key1);
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_one_key_likely(void *ctx)
+{
+	if (bpf_static_branch_likely(&key1))
+		ret_user += VAL_ON;
+	else
+		ret_user += VAL_OFF;
+
+	return 0;
+}
+
+DEFINE_STATIC_KEY(key2);
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_one_key_unlikely(void *ctx)
+{
+	if (bpf_static_branch_unlikely(&key2))
+		ret_user += VAL_ON;
+	else
+		ret_user += VAL_OFF;
+
+	return 0;
+}
+
+DEFINE_STATIC_KEY(key3);
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_one_key_multiple(void *ctx)
+{
+	if (bpf_static_branch_likely(&key3))
+		ret_user += VAL_ON;
+	else
+		ret_user += VAL_OFF;
+
+	bpf_printk("%lu\n", bpf_jiffies64());
+
+	if (bpf_static_branch_unlikely(&key3))
+		ret_user += VAL_ON;
+	else
+		ret_user += VAL_OFF;
+
+	bpf_printk("%lu\n", bpf_jiffies64());
+
+	if (bpf_static_branch_likely(&key3))
+		ret_user += VAL_ON;
+	else
+		ret_user += VAL_OFF;
+
+	return 0;
+}
+
+static __always_inline int big_chunk_of_code(volatile int *x)
+{
+	#pragma clang loop unroll_count(256)
+	for (int i = 0; i < 256; i++)
+		*x += 1;
+
+	return *x;
+}
+
+DEFINE_STATIC_KEY(key4);
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_one_key_long_jump(void *ctx)
+{
+	int x;
+
+	if (bpf_static_branch_unlikely(&key4)) {
+		x = 1744;
+		big_chunk_of_code(&x);
+		ret_user = x;
+	} else {
+		x = 744;
+		big_chunk_of_code(&x);
+		ret_user = x;
+	}
+
+	return 0;
+}
+
+DEFINE_STATIC_KEY(key5);
+DEFINE_STATIC_KEY(key6);
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_multiple_keys(void *ctx)
+{
+	__u64 j = bpf_jiffies64();
+
+	if (bpf_static_branch_likely(&key5))
+		ret_user += 1;
+	if (bpf_static_branch_unlikely(&key6))
+		ret_user += 10;
+
+	bpf_printk("%lu\n", j);
+
+	if (bpf_static_branch_unlikely(&key5))
+		ret_user += 1;
+	if (bpf_static_branch_likely(&key6))
+		ret_user += 10;
+
+	bpf_printk("%lu\n", bpf_jiffies64());
+
+	if (bpf_static_branch_likely(&key5))
+		ret_user += 1;
+	if (bpf_static_branch_unlikely(&key6))
+		ret_user += 10;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


