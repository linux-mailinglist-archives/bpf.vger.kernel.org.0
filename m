Return-Path: <bpf+bounces-16886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5548071FE
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 15:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3342816CF
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609673E489;
	Wed,  6 Dec 2023 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="YsV7ns1X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A84B1A2
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 06:13:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c0e7b8a9bso38812955e9.3
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 06:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1701872032; x=1702476832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/mil66XVycPGDyt1s26xPsBfGVLnvx73zPTwd81ej8=;
        b=YsV7ns1X4v2IKhSRToEwRAhf/y1SDtr1SZw5DubOCnueM8Ca9lznyi8Ih/dy1lzNjE
         dRuLke5/2cfpEJiITbbnZvD7/K6/uigOEytY9zaU5GDbShwQHRzz/1FKw1LZ03d6wgMD
         KpczoT7ptTO4kiasYdLd47aMcDO59K2UlHWoetHZkbkVrT9EuACu+K2oWtzbf1/HF/m6
         rS0aJnPK8D1D3dS5HdrC9ojhlZKPQnEI889Gzn43nJO7OdurvO6Di/uUfY6N8rxEcc5w
         EKRb+tUqRX5okZz+g2bU9iWGijRUDiAa/Y/vra4HHd7FGn5Czbo3MOQE6MBtOXkAoDFB
         1zOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872032; x=1702476832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/mil66XVycPGDyt1s26xPsBfGVLnvx73zPTwd81ej8=;
        b=Ir5m0zdXPT5Prdbm+4flJYvYT6CH/dZlYfSIBUjxoJIAdB7j5jMQJmZiN3hKYO8xks
         lHdPMRSllfafT8utYVMrEMlLp34mC6CltOiYGozB+i3OBwZ61SXXuIDlCSD/HmamPzeu
         dJUQjCFUTvdqX7oYg9+4KEkZt7v6lk1Btzjgjre6XGHQD8JeAFIjPPtx3QV+gBm+sEng
         nRrYxe0eR1pMJxWjqJupPJh37+zXPx/KOyFSZaoBWFnAZWSe2fhhmrq2DHjypVef66Zq
         MXCLigqQMzGxku/c1uI790rLBR43O+1djOtSLKB1umVvMVKMCCZjIDsmFDXbjbV+XIlG
         VRIQ==
X-Gm-Message-State: AOJu0YxwtQZBVMKZvB1okLrcSz1WiyI9iyQP3IooHbMlQ2pBOmLcsNPi
	RtjQ0bvdCZfCopBkrYHs17WcdQ==
X-Google-Smtp-Source: AGHT+IGGgzhxTp5n/3v+rAeYU7skWgWjS5zMTHjt+sFv+USt0/X5XY34li4ssrJNbWaWKrdESQ4F/Q==
X-Received: by 2002:a05:600c:16d3:b0:40b:5e59:ccbd with SMTP id l19-20020a05600c16d300b0040b5e59ccbdmr639416wmn.158.1701872032656;
        Wed, 06 Dec 2023 06:13:52 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c311200b0040b42df75fcsm22140330wmo.39.2023.12.06.06.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:13:52 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 7/7] selftests/bpf: Add tests for BPF Static Keys
Date: Wed,  6 Dec 2023 14:10:30 +0000
Message-Id: <20231206141030.1478753-8-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206141030.1478753-1-aspsk@isovalent.com>
References: <20231206141030.1478753-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several self-tests to test the new BPF Static Key feature. Selftests
include the following tests:

  * check that one key works for one program
  * check that one key works for multiple programs
  * check that static keys work with 2 and 5 bytes jumps
  * check that multiple keys works for one program
  * check that static keys work for base program and a BPF-to-BPF call
  * check that static keys can't be used as normal maps
  * check that passing incorrect parameters on map creation fails
  * check that passing incorrect parameters on program load fails

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 MAINTAINERS                                   |   1 +
 .../bpf/prog_tests/bpf_static_keys.c          | 436 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_static_keys.c     | 120 +++++
 3 files changed, 557 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_static_keys.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e2f655980c6c..81a040d66af6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3892,6 +3892,7 @@ M:	Anton Protopopov <aspsk@isovalent.com>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	kernel/bpf/skey.c
+F:	tools/testing/selftests/bpf/*/*bpf_static_key*
 
 BROADCOM ASP 2.0 ETHERNET DRIVER
 M:	Justin Chen <justin.chen@broadcom.com>
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c b/tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
new file mode 100644
index 000000000000..37b2da247869
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
@@ -0,0 +1,436 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Isovalent */
+
+#include <test_progs.h>
+#include "bpf_static_keys.skel.h"
+
+#define set_static_key(map_fd, val)						\
+	do {									\
+		__u32 map_value = (val);					\
+		__u32 zero_key = 0;						\
+		int ret;							\
+										\
+		ret = bpf_map_update_elem(map_fd, &zero_key, &map_value, 0);	\
+		ASSERT_EQ(ret, 0, "bpf_map_update_elem");			\
+	} while (0)
+
+static void check_one_key(struct bpf_static_keys *skel)
+{
+	struct bpf_link *link;
+	int map_fd;
+
+	link = bpf_program__attach(skel->progs.check_one_key);
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	map_fd = bpf_map__fd(skel->maps.key1);
+	ASSERT_GT(map_fd, 0, "skel->maps.key1");
+
+	set_static_key(map_fd, 0);
+	skel->bss->ret_user = 0;
+	usleep(1);
+	ASSERT_EQ(skel->bss->ret_user, 4, "skel->bss->ret_user");
+
+	set_static_key(map_fd, 1);
+	skel->bss->ret_user = 0;
+	usleep(1);
+	ASSERT_EQ(skel->bss->ret_user, 3, "skel->bss->ret_user");
+
+	bpf_link__destroy(link);
+}
+
+static void check_multiple_progs(struct bpf_static_keys *skel)
+{
+	struct bpf_link *link1;
+	struct bpf_link *link2;
+	struct bpf_link *link3;
+	int map_fd;
+
+	link1 = bpf_program__attach(skel->progs.check_one_key);
+	if (!ASSERT_OK_PTR(link1, "link1"))
+		return;
+
+	link2 = bpf_program__attach(skel->progs.check_one_key_another_prog);
+	if (!ASSERT_OK_PTR(link2, "link2"))
+		return;
+
+	link3 = bpf_program__attach(skel->progs.check_one_key_yet_another_prog);
+	if (!ASSERT_OK_PTR(link3, "link3"))
+		return;
+
+	map_fd = bpf_map__fd(skel->maps.key1);
+	ASSERT_GT(map_fd, 0, "skel->maps.key1");
+
+	set_static_key(map_fd, 0);
+	skel->bss->ret_user = 0;
+	usleep(1);
+	ASSERT_EQ(skel->bss->ret_user, 444, "skel->bss->ret_user");
+	usleep(1);
+	ASSERT_EQ(skel->bss->ret_user, 888, "skel->bss->ret_user");
+
+	set_static_key(map_fd, 1);
+	skel->bss->ret_user = 0;
+	usleep(1);
+	ASSERT_EQ(skel->bss->ret_user, 333, "skel->bss->ret_user");
+	usleep(1);
+	ASSERT_EQ(skel->bss->ret_user, 666, "skel->bss->ret_user");
+
+	bpf_link__destroy(link3);
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link1);
+}
+
+static void check_multiple_keys(struct bpf_static_keys *skel)
+{
+	struct bpf_link *link;
+	int map_fd1;
+	int map_fd2;
+	int map_fd3;
+	int i;
+
+	link = bpf_program__attach(skel->progs.check_multiple_keys_unlikely);
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	map_fd1 = bpf_map__fd(skel->maps.key1);
+	ASSERT_GT(map_fd1, 0, "skel->maps.key1");
+
+	map_fd2 = bpf_map__fd(skel->maps.key2);
+	ASSERT_GT(map_fd2, 0, "skel->maps.key2");
+
+	map_fd3 = bpf_map__fd(skel->maps.key3);
+	ASSERT_GT(map_fd3, 0, "skel->maps.key3");
+
+	for (i = 0; i < 8; i++) {
+		set_static_key(map_fd1, i & 1);
+		set_static_key(map_fd2, i & 2);
+		set_static_key(map_fd3, i & 4);
+
+		usleep(1);
+		ASSERT_EQ(skel->bss->ret_user, i, "skel->bss->ret_user");
+	}
+
+	bpf_link__destroy(link);
+}
+
+static void check_one_key_long_jump(struct bpf_static_keys *skel)
+{
+	struct bpf_link *link;
+	int map_fd;
+
+	link = bpf_program__attach(skel->progs.check_one_key_long_jump);
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	map_fd = bpf_map__fd(skel->maps.key1);
+	ASSERT_GT(map_fd, 0, "skel->maps.key1");
+
+	set_static_key(map_fd, 0);
+	skel->bss->ret_user = 0;
+	usleep(1);
+	ASSERT_EQ(skel->bss->ret_user, 2256, "skel->bss->ret_user");
+
+	set_static_key(map_fd, 1);
+	skel->bss->ret_user = 0;
+	usleep(1);
+	ASSERT_EQ(skel->bss->ret_user, 1256, "skel->bss->ret_user");
+
+	bpf_link__destroy(link);
+}
+
+static void check_bpf_to_bpf_call(struct bpf_static_keys *skel)
+{
+	struct bpf_link *link;
+	int map_fd1;
+	int map_fd2;
+
+	link = bpf_program__attach(skel->progs.check_bpf_to_bpf_call);
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	map_fd1 = bpf_map__fd(skel->maps.key1);
+	ASSERT_GT(map_fd1, 0, "skel->maps.key1");
+
+	map_fd2 = bpf_map__fd(skel->maps.key2);
+	ASSERT_GT(map_fd2, 0, "skel->maps.key2");
+
+	set_static_key(map_fd1, 0);
+	set_static_key(map_fd2, 0);
+	skel->bss->ret_user = 0;
+	usleep(1);
+	ASSERT_EQ(skel->bss->ret_user, 0, "skel->bss->ret_user");
+
+	set_static_key(map_fd1, 1);
+	set_static_key(map_fd2, 0);
+	skel->bss->ret_user = 0;
+	usleep(1);
+	ASSERT_EQ(skel->bss->ret_user, 101, "skel->bss->ret_user");
+
+	set_static_key(map_fd1, 0);
+	set_static_key(map_fd2, 1);
+	skel->bss->ret_user = 0;
+	usleep(1);
+	ASSERT_EQ(skel->bss->ret_user, 1010, "skel->bss->ret_user");
+
+	set_static_key(map_fd1, 1);
+	set_static_key(map_fd2, 1);
+	skel->bss->ret_user = 0;
+	usleep(1);
+	ASSERT_EQ(skel->bss->ret_user, 1111, "skel->bss->ret_user");
+
+
+	bpf_link__destroy(link);
+}
+
+#define FIXED_MAP_FD 666
+
+static void check_use_key_as_map(struct bpf_static_keys *skel)
+{
+	struct bpf_insn insns[] = {
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+		BPF_LD_MAP_FD(BPF_REG_1, FIXED_MAP_FD),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP,
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+	};
+	int map_fd;
+	int ret;
+
+	/* first check that prog loads ok */
+
+	map_fd = bpf_map__fd(skel->maps.just_map);
+	ASSERT_GT(map_fd, 0, "skel->maps.just_map");
+
+	ret = dup2(map_fd, FIXED_MAP_FD);
+	ASSERT_EQ(ret, FIXED_MAP_FD, "dup2");
+
+	strncpy(attr.prog_name, "prog", sizeof(attr.prog_name));
+	ret = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_GT(ret, 0, "BPF_PROG_LOAD");
+	close(ret);
+	close(FIXED_MAP_FD);
+
+	/* now the incorrect map (static key as normal map) */
+
+	map_fd = bpf_map__fd(skel->maps.key1);
+	ASSERT_GT(map_fd, 0, "skel->maps.key1");
+
+	ret = dup2(map_fd, FIXED_MAP_FD);
+	ASSERT_EQ(ret, FIXED_MAP_FD, "dup2");
+
+	ret = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_EQ(ret, -1, "BPF_PROG_LOAD");
+	ASSERT_EQ(errno, EINVAL, "BPF_PROG_LOAD");
+	close(ret);
+	close(FIXED_MAP_FD);
+}
+
+static void map_create_incorrect(void)
+{
+	union bpf_attr attr = {
+		.map_type = BPF_MAP_TYPE_ARRAY,
+		.key_size = 4,
+		.value_size = 4,
+		.max_entries = 1,
+		.map_flags = BPF_F_STATIC_KEY,
+	};
+	int map_fd;
+
+	/* The first call should be ok */
+
+	map_fd = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
+	ASSERT_GT(map_fd, 0, "BPF_MAP_CREATE");
+	close(map_fd);
+
+	/* All the rest calls should fail */
+
+	attr.map_type = BPF_MAP_TYPE_HASH;
+	map_fd = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
+	ASSERT_EQ(map_fd, -1, "BPF_MAP_CREATE");
+	attr.map_type = BPF_MAP_TYPE_ARRAY;
+
+	attr.key_size = 8;
+	map_fd = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
+	ASSERT_EQ(map_fd, -1, "BPF_MAP_CREATE");
+	attr.key_size = 4;
+
+	attr.value_size = 8;
+	map_fd = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
+	ASSERT_EQ(map_fd, -1, "BPF_MAP_CREATE");
+	attr.value_size = 4;
+
+	attr.max_entries = 2;
+	map_fd = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
+	ASSERT_EQ(map_fd, -1, "BPF_MAP_CREATE");
+	attr.max_entries = 1;
+}
+
+static void prog_load_incorrect_branches(struct bpf_static_keys *skel)
+{
+	int key_fd, map_fd, prog_fd;
+
+	/*
+	 *                 KEY=OFF               KEY=ON
+	 * <prog>:
+	 *        0:       r0 = 0x0              r0 = 0x0
+	 *        1:       goto +0x0 <1>         goto +0x1 <2>
+	 * <1>:
+	 *        2:       exit                  exit
+	 * <2>:
+	 *        3:       r0 = 0x1              r0 = 0x1
+	 *        4:       goto -0x3 <1>         goto -0x3 <1>
+	 */
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+		BPF_EXIT_INSN(),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_JMP_IMM(BPF_JA, 0, 0, -3),
+	};
+	struct bpf_static_branch_info static_branches_info[] = {
+		{
+			.map_fd = -1,
+			.insn_offset = 8,
+			.jump_target = 24,
+			.flags = 0,
+		},
+	};
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP,
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+		.static_branches_info = ptr_to_u64(static_branches_info),
+		.static_branches_info_size = sizeof(static_branches_info),
+	};
+
+	key_fd = bpf_map__fd(skel->maps.key1);
+	ASSERT_GT(key_fd, 0, "skel->maps.key1");
+
+	map_fd = bpf_map__fd(skel->maps.just_map);
+	ASSERT_GT(map_fd, 0, "skel->maps.just_map");
+
+	strncpy(attr.prog_name, "prog", sizeof(attr.prog_name));
+
+	/* The first two loads should be ok, correct parameters */
+
+	static_branches_info[0].map_fd = key_fd;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_GT(prog_fd, 0, "BPF_PROG_LOAD");
+	close(prog_fd);
+
+	static_branches_info[0].flags = BPF_F_INVERSE_BRANCH;
+	insns[1] = BPF_JMP_IMM(BPF_JA, 0, 0, 1); /* inverse branch expects non-zero offset */
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_GT(prog_fd, 0, "BPF_PROG_LOAD");
+	close(prog_fd);
+	static_branches_info[0].flags = 0;
+	insns[1] = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+
+	/* All other loads should fail with -EINVAL */
+
+	static_branches_info[0].map_fd = map_fd;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_EQ(prog_fd, -1, "BPF_PROG_LOAD: incorrect map fd");
+	ASSERT_EQ(errno, EINVAL, "BPF_PROG_LOAD: incorrect map fd");
+	static_branches_info[0].map_fd = key_fd;
+
+	attr.static_branches_info = 0;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_EQ(prog_fd, -1, "BPF_PROG_LOAD: info is NULL, but size is not zero");
+	ASSERT_EQ(errno, EINVAL, "BPF_PROG_LOAD: info is NULL, but size is not zero");
+	attr.static_branches_info = ptr_to_u64(static_branches_info);
+
+	attr.static_branches_info_size = 0;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_EQ(prog_fd, -1, "BPF_PROG_LOAD: info is not NULL, but size is zero");
+	ASSERT_EQ(errno, EINVAL, "BPF_PROG_LOAD: info is not NULL, but size is zero");
+	attr.static_branches_info_size = sizeof(static_branches_info);
+
+	attr.static_branches_info_size = 1;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_EQ(prog_fd, -1, "BPF_PROG_LOAD: size not divisible by item size");
+	ASSERT_EQ(errno, EINVAL, "BPF_PROG_LOAD: size not divisible by item size");
+	attr.static_branches_info_size = sizeof(static_branches_info);
+
+	static_branches_info[0].flags = 0xbeef;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_EQ(prog_fd, -1, "BPF_PROG_LOAD: incorrect flags");
+	ASSERT_EQ(errno, EINVAL, "BPF_PROG_LOAD: incorrect flags");
+	static_branches_info[0].flags = 0;
+
+	static_branches_info[0].insn_offset = 1;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_EQ(prog_fd, -1, "BPF_PROG_LOAD: incorrect insn_offset");
+	ASSERT_EQ(errno, EINVAL, "BPF_PROG_LOAD: incorrect insn_offset");
+	static_branches_info[0].insn_offset = 8;
+
+	static_branches_info[0].insn_offset = 64;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_EQ(prog_fd, -1, "BPF_PROG_LOAD: insn_offset outside of prgoram");
+	ASSERT_EQ(errno, EINVAL, "BPF_PROG_LOAD: insn_offset outside of prgoram");
+	static_branches_info[0].insn_offset = 8;
+
+	static_branches_info[0].jump_target = 1;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_EQ(prog_fd, -1, "BPF_PROG_LOAD: incorrect jump_target");
+	ASSERT_EQ(errno, EINVAL, "BPF_PROG_LOAD: incorrect jump_target");
+	static_branches_info[0].jump_target = 8;
+
+	static_branches_info[0].jump_target = 64;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_EQ(prog_fd, -1, "BPF_PROG_LOAD: jump_target outside of prgoram");
+	ASSERT_EQ(errno, EINVAL, "BPF_PROG_LOAD: jump_target outside of prgoram");
+	static_branches_info[0].jump_target = 8;
+
+	static_branches_info[0].insn_offset = 0;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	ASSERT_EQ(prog_fd, -1, "BPF_PROG_LOAD: patching not a JA");
+	ASSERT_EQ(errno, EINVAL, "BPF_PROG_LOAD: patching not a JA");
+	static_branches_info[0].insn_offset = 8;
+}
+
+void test_bpf_static_keys(void)
+{
+	struct bpf_static_keys *skel;
+
+	skel = bpf_static_keys__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_static_keys__open_and_load"))
+		return;
+
+	if (test__start_subtest("check_one_key"))
+		check_one_key(skel);
+
+	if (test__start_subtest("check_multiple_keys"))
+		check_multiple_keys(skel);
+
+	if (test__start_subtest("check_multiple_progs"))
+		check_multiple_progs(skel);
+
+	if (test__start_subtest("check_one_key_long_jump"))
+		check_one_key_long_jump(skel);
+
+	if (test__start_subtest("check_bpf_to_bpf_call"))
+		check_bpf_to_bpf_call(skel);
+
+	/* Negative tests */
+
+	if (test__start_subtest("check_use_key_as_map"))
+		check_use_key_as_map(skel);
+
+	if (test__start_subtest("map_create_incorrect"))
+		map_create_incorrect();
+
+	if (test__start_subtest("prog_load_incorrect_branches"))
+		prog_load_incorrect_branches(skel);
+
+	bpf_static_keys__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_static_keys.c b/tools/testing/selftests/bpf/progs/bpf_static_keys.c
new file mode 100644
index 000000000000..e47a34df469b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_static_keys.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+DEFINE_STATIC_KEY(key1);
+DEFINE_STATIC_KEY(key2);
+DEFINE_STATIC_KEY(key3);
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
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_one_key(void *ctx)
+{
+	if (bpf_static_branch_likely(&key1))
+		ret_user += 3;
+	else
+		ret_user += 4;
+
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_one_key_another_prog(void *ctx)
+{
+	if (bpf_static_branch_unlikely(&key1))
+		ret_user += 30;
+	else
+		ret_user += 40;
+
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_one_key_yet_another_prog(void *ctx)
+{
+	if (bpf_static_branch_unlikely(&key1))
+		ret_user += 300;
+	else
+		ret_user += 400;
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
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_one_key_long_jump(void *ctx)
+{
+	int x;
+
+	if (bpf_static_branch_likely(&key1)) {
+		x = 1000;
+		big_chunk_of_code(&x);
+		ret_user = x;
+	} else {
+		x = 2000;
+		big_chunk_of_code(&x);
+		ret_user = x;
+	}
+
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_multiple_keys_unlikely(void *ctx)
+{
+	ret_user = (bpf_static_branch_unlikely(&key1) << 0) |
+		   (bpf_static_branch_unlikely(&key2) << 1) |
+		   (bpf_static_branch_unlikely(&key3) << 2);
+
+	return 0;
+}
+
+int __noinline patch(int x)
+{
+	if (bpf_static_branch_likely(&key1))
+		x += 100;
+	if (bpf_static_branch_unlikely(&key2))
+		x += 1000;
+
+	return x;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int check_bpf_to_bpf_call(void *ctx)
+{
+	__u64 j = bpf_jiffies64();
+
+	bpf_printk("%lu\n", j);
+
+	ret_user = 0;
+
+	if (bpf_static_branch_likely(&key1))
+		ret_user += 1;
+	if (bpf_static_branch_unlikely(&key2))
+		ret_user += 10;
+
+	ret_user = patch(ret_user);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


