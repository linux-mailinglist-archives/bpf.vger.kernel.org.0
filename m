Return-Path: <bpf+bounces-37795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E746695A8B0
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 02:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E42B21F9A
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 00:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1B05661;
	Thu, 22 Aug 2024 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5ioOInX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8346AB8
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724285936; cv=none; b=dE9P8PloXIrUSya2okABowWX+PNNK1eqyEwY5uh0LPzQpKjyL43uoI/JHBzdzP2NdVn6PkZjeo7kPUaLt/HtReN9GJbCFZJfOaHusHaJ8ksxN7koNskutzCr4TLYooJ1Snspgr3mMV2sq+/ZVAKrxScDvfZ+vr9Cc44AwLMPVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724285936; c=relaxed/simple;
	bh=cHK+9/wvpByFTRvdShRT8fJVnSFCZa5JGPjRnVcL0R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAAdP+pr7wSvwnPnDTbBtPqMaVRhhJxzIixnK2X/GXvQxRg/4tHQ9NA9//XC989ak0OKsosBMhKK2wbYiVPfS7Yrsu/ofnRS8Bst9C8nbCSI8cR82ku9jBrqB7Gp4ezFr3tXuG8cynbbYHC0hcTb2P4e/SbYkUu8dsp3bT0fWek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5ioOInX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7143185edf2so208847b3a.0
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 17:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724285934; x=1724890734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnashHRk3WeZ4D/Nqt7Pwc65eerYvFTriiZUrfoprmQ=;
        b=F5ioOInX5p2j2VQaUO5R/6neYCfmteA/Q5dsX8Ns2HLNTdrJUUwPKCxfS0gyidmL69
         AGVs8kFqgqU2zKw8YKLHsMVXCvslvzAj/FpnzfOyEt8MnL+m3MEwe45g1Z13U+JoKbIn
         KdT0v0DUT5EubDsdp/r0GszscZoLMt/ldGyYN1UtmiOhKSQCCq4aB7iLx4WFIJv3OZzL
         7QRR2MtStOJ9B9caUvTNkVWIgjk/E74kU/ksTXxsQcMcq5tmFxM0l7+T+8SrLafZSvY1
         kJZtEOo9+lO0jPVKFjPJNvSKFblG7IrMQRf0S+bKlCX17YYp2GvyCU1/X1WYO36cJUZk
         n+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724285934; x=1724890734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnashHRk3WeZ4D/Nqt7Pwc65eerYvFTriiZUrfoprmQ=;
        b=G8wQFAYOZx2o0cUqpbWUS+Zzxh+aZ5wrMq4NPP4uHfIlgTrdOSL5xkDRD8MquyC0FL
         8/fKr8bzZnyUOT4/ORP9AdwD6dDZiMF7frCvqac7800KqqbbAN2eoDBE9OnkPPLp9hCp
         PGCzsBok52ulvM8HGWdBJRNDiO0GCEUo0DgGwpen0J5QN6sY60o5fzXlq0vNIrUkbKIP
         z9reW09uS9FwXRRGwcEWcx3SVj2hBPO2/h15cdGiu6grCbsj3SPUS7sYiVeV1z1Bo5lf
         1toWNXpuFG1QQdOlXPZDXcZ+vvOmgJ6QOeUGCjSfsBXemJou1iVigEw6PzZxC+D71+wJ
         4DJg==
X-Gm-Message-State: AOJu0Yz4VJVDlWKRoUhYkEOehndy28epi8TNjktK/e6TPYKzcUGqqhXz
	cslUF4TS2vfhXv1WsNbXw+AlH+sajWJY1UdhqW/EbMVs6v9KOdWyJebZGy7l
X-Google-Smtp-Source: AGHT+IFjxQ2wE/89IquWEDqm8jXzSlbaJdIx5zMd1Ln9Of69ebfKPR53LaRUCQVRL3cegNyMg5+BYQ==
X-Received: by 2002:a05:6a00:228f:b0:714:37e6:3857 with SMTP id d2e1a72fcca58-71437e63b15mr111887b3a.18.1724285933857;
        Wed, 21 Aug 2024 17:18:53 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143424e145sm231448b3a.55.2024.08.21.17.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:18:52 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	cnitlrt@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: test for malformed BPF_CORE_TYPE_ID_LOCAL relocation
Date: Wed, 21 Aug 2024 17:18:37 -0700
Message-ID: <20240822001837.2715909-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822001837.2715909-1-eddyz87@gmail.com>
References: <20240822001837.2715909-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that verifier rejects BPF program containing relocation
pointing to non-existent BTF type.

To force relocation resolution on kernel side test case uses
bpf_attr->core_relos field. This field is not exposed by libbpf,
so directly do BPF system call in the test.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
new file mode 100644
index 000000000000..1ab3ab305d3b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Test cases that can't load programs using libbpf and need direct
+ * BPF syscall access
+ */
+
+#include <sys/syscall.h>
+#include <bpf/libbpf.h>
+#include <bpf/btf.h>
+
+#include "test_progs.h"
+#include "test_btf.h"
+#include "bpf/libbpf_internal.h"
+
+static char log[16 * 1024];
+
+/* Check that verifier rejects BPF program containing relocation
+ * pointing to non-existent BTF type.
+ */
+static void test_bad_local_id(void)
+{
+	struct test_btf {
+		struct btf_header hdr;
+		__u32 types[15];
+		char strings[128];
+	} raw_btf = {
+		.hdr = {
+			.magic = BTF_MAGIC,
+			.version = BTF_VERSION,
+			.hdr_len = sizeof(struct btf_header),
+			.type_off = 0,
+			.type_len = sizeof(raw_btf.types),
+			.str_off = offsetof(struct test_btf, strings) -
+				   offsetof(struct test_btf, types),
+			.str_len = sizeof(raw_btf.strings),
+		},
+		.types = {
+			BTF_PTR_ENC(0),					/* [1] void*  */
+			BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),	/* [2] int    */
+			BTF_FUNC_PROTO_ENC(2, 1),			/* [3] int (*)(void*) */
+			BTF_FUNC_PROTO_ARG_ENC(8, 1),
+			BTF_FUNC_ENC(8, 3)			/* [4] FUNC 'foo' type_id=2   */
+		},
+		.strings = "\0int\0 0\0foo\0"
+	};
+	__u32 log_level = 1 | 2 | 4;
+	LIBBPF_OPTS(bpf_btf_load_opts, opts,
+		    .log_buf = log,
+		    .log_size = sizeof(log),
+		    .log_level = log_level,
+	);
+	struct bpf_insn insns[] = {
+		BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_func_info funcs[] = {
+		{
+			.insn_off = 0,
+			.type_id = 4,
+		}
+	};
+	struct bpf_core_relo relos[] = {
+		{
+			.insn_off = 0,		/* patch first instruction (r0 = 0) */
+			.type_id = 100500,	/* !!! this type id does not exist */
+			.access_str_off = 6,	/* offset of "0" */
+			.kind = BPF_CORE_TYPE_ID_LOCAL,
+		}
+	};
+	union bpf_attr attr = {};
+	int saved_errno;
+	int prog_fd = -1;
+	int btf_fd = -1;
+
+	btf_fd = bpf_btf_load(&raw_btf, sizeof(raw_btf), &opts);
+	saved_errno = errno;
+	if (btf_fd < 0 || env.verbosity > VERBOSE_NORMAL) {
+		printf("-------- BTF load log start --------\n");
+		printf("%s", log);
+		printf("-------- BTF load log end ----------\n");
+	}
+	if (btf_fd < 0) {
+		PRINT_FAIL("bpf_btf_load() failed, errno=%d\n", saved_errno);
+		return;
+	}
+
+	memset(log, 0, sizeof(log));
+	attr.prog_btf_fd = btf_fd;
+	attr.prog_type = BPF_TRACE_RAW_TP;
+	attr.license = (__u64)"GPL";
+	attr.insns = (__u64)&insns;
+	attr.insn_cnt = sizeof(insns) / sizeof(*insns);
+	attr.log_buf = (__u64)log;
+	attr.log_size = sizeof(log);
+	attr.log_level = log_level;
+	attr.func_info = (__u64)funcs;
+	attr.func_info_cnt = sizeof(funcs) / sizeof(*funcs);
+	attr.func_info_rec_size = sizeof(*funcs);
+	attr.core_relos = (__u64)relos;
+	attr.core_relo_cnt = sizeof(relos) / sizeof(*relos);
+	attr.core_relo_rec_size = sizeof(*relos);
+	prog_fd = sys_bpf_prog_load(&attr, sizeof(attr), 1);
+	saved_errno = errno;
+	if (prog_fd < 0 || env.verbosity > VERBOSE_NORMAL) {
+		printf("-------- program load log start --------\n");
+		printf("%s", log);
+		printf("-------- program load log end ----------\n");
+	}
+	if (prog_fd >= 0) {
+		PRINT_FAIL("sys_bpf_prog_load() expected to fail\n");
+		goto out;
+	}
+	ASSERT_HAS_SUBSTR(log, "relo #0: bad type id 100500", "program load log");
+
+out:
+	close(prog_fd);
+	close(btf_fd);
+}
+
+void test_core_reloc_raw(void)
+{
+	if (test__start_subtest("bad_local_id"))
+		test_bad_local_id();
+}
-- 
2.45.2


