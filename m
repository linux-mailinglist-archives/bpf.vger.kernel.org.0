Return-Path: <bpf+bounces-5496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC5575B387
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75451281E5C
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5A019BB6;
	Thu, 20 Jul 2023 15:52:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E0C18C15;
	Thu, 20 Jul 2023 15:52:58 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F8EE74;
	Thu, 20 Jul 2023 08:52:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-262c42d3fafso694915a91.0;
        Thu, 20 Jul 2023 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689868374; x=1690473174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpNCoc8Am7vKi0rz5OBYbPpr0uWW9chVHV3BrFnbwGc=;
        b=Sov0A4zd3+1/Pr7Qx/yW5IoQ5nBiLcpMbPB7E7zFOwe88mjHNNj+vPmk/2WEDoq8u2
         6qLmFh89UUIRr3L449uxxGOydd82Qtwwauqw5zz21bmDyWvjbZEKTCvArQjAwU3dTYjS
         1xgtUPEueO7rB42AM1iP9ImNyI8xLz0aukxhwM7WBC7V0gnmEjPWfa+DqxEYHt7Fld3I
         Zh/1ekJf6QxHwazyK/j49oYex24AdIvWyqJgJaDb1PxNqKO+AOooC8Ysuwsh9L8dcl3U
         ep6sqot15AokAUOf8clxQcRWeB1xKm+T9BauYovFb/jjTeixhQnXJJ9kXnf8PqVkZiQs
         z4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868374; x=1690473174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpNCoc8Am7vKi0rz5OBYbPpr0uWW9chVHV3BrFnbwGc=;
        b=kb6njWkKv0z4R00SuHN5ZqZaZ3bsbDL0wgeD5t/DEG41CbmdXAlso0OGXNOJPVSde8
         uaWynhglYqjkq9yuOHohGpehspiZkNMYN5dbktoR4bSeLHg5Mv95I+bBgrxvNHH5wSp7
         FMt9eXTw93Pt9Vp28OQbmLr79iU7iQ+3EtV/SATYmtIykeX0/Rb77relURMnm1L3HC4I
         9oITh+BTUzXtA+Z4GKMn7WHfkka1vn52N9+3xHxPBrlRbBfxYhYjNI7dAARa2TAr9/9/
         Y0hDsiNNtMDf8cZZUtPquKXOT/GzaH+k+AosjRf9xCEUfFWQjDWYiLZZPuSbt3ErEhrH
         RkMA==
X-Gm-Message-State: ABy/qLYuVfazF/VrKT7kVujgngNeCce2SThE2BUEFSNrXMPUrTGMUBZk
	PphtyEu9oeSL4Po1/HAOTeeVfjNqJ+rBoQyv
X-Google-Smtp-Source: APBJJlE1aBfjz/xSNLP8Jf+P7zQF/o74c3ze2XPqxl4eqbD51VhfkKLh4M+DRRADs3y1hjNagmGAnw==
X-Received: by 2002:a17:90b:38d1:b0:262:d1b8:5d43 with SMTP id nn17-20020a17090b38d100b00262d1b85d43mr7786698pjb.22.1689868371329;
        Thu, 20 Jul 2023 08:52:51 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001b8a00d4f7asm1569177plf.9.2023.07.20.08.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:52:50 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	hffilwlqm@gmail.com,
	tangyeechou@gmail.com,
	kernel-patches-bot@fb.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RESEND PATCH bpf-next v3 2/2] selftests/bpf: Add testcase for xdp attaching failure tracepoint
Date: Thu, 20 Jul 2023 23:52:28 +0800
Message-ID: <20230720155228.5708-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720155228.5708-1-hffilwlqm@gmail.com>
References: <20230720155228.5708-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a test case for the tracepoint of xdp attaching failure by bpf
tracepoint when attach XDP to a device with invalid flags option.

The bpf tracepoint retrieves error message from the tracepoint, and
then put the error message to a perf buffer. The testing code receives
error message from perf buffer, and then ASSERT "Invalid XDP flags for
BPF link attachment".

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 .../selftests/bpf/prog_tests/xdp_attach.c     | 65 +++++++++++++++++++
 .../bpf/progs/test_xdp_attach_fail.c          | 52 +++++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
index fa3cac5488f5d..99f8d03f3c8bd 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "test_xdp_attach_fail.skel.h"
 
 #define IFINDEX_LO 1
 #define XDP_FLAGS_REPLACE		(1U << 4)
@@ -85,10 +86,74 @@ static void test_xdp_attach(const char *file)
 	bpf_object__close(obj1);
 }
 
+struct xdp_errmsg {
+	char msg[64];
+};
+
+static void on_xdp_errmsg(void *ctx, int cpu, void *data, __u32 size)
+{
+	struct xdp_errmsg *ctx_errmg = ctx, *tp_errmsg = data;
+
+	memcpy(&ctx_errmg->msg, &tp_errmsg->msg, size);
+}
+
+static const char tgt_errmsg[] = "Invalid XDP flags for BPF link attachment";
+
+static void test_xdp_attach_fail(const char *file)
+{
+	__u32 duration = 0;
+	int err, fd_xdp, fd_link_xdp;
+	struct bpf_object *obj = NULL;
+	struct test_xdp_attach_fail *skel = NULL;
+	struct bpf_link *link = NULL;
+	struct perf_buffer *pb = NULL;
+	struct xdp_errmsg errmsg = {};
+
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+
+	skel = test_xdp_attach_fail__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_attach_fail_skel"))
+		goto out_close;
+
+	link = bpf_program__attach_tracepoint(skel->progs.tp__xdp__bpf_xdp_link_attach_failed,
+					      "xdp", "bpf_xdp_link_attach_failed");
+	if (!ASSERT_OK_PTR(link, "attach_tp"))
+		goto out_close;
+
+	/* set up perf buffer */
+	pb = perf_buffer__new(bpf_map__fd(skel->maps.xdp_errmsg_pb), 1,
+			      on_xdp_errmsg, NULL, &errmsg, NULL);
+
+	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &fd_xdp);
+	if (CHECK_FAIL(err))
+		goto out_close;
+
+	opts.flags = 0xFF; // invalid flags to fail to attach XDP prog
+	fd_link_xdp = bpf_link_create(fd_xdp, IFINDEX_LO, BPF_XDP, &opts);
+	if (CHECK(fd_link_xdp != -22, "bpf_link_create_failed",
+		  "created link fd: %d\n", fd_link_xdp))
+		goto out_close;
+
+	/* read perf buffer */
+	err = perf_buffer__poll(pb, 100);
+	if (CHECK(err < 0, "perf_buffer__poll", "err %d\n", err))
+		goto out_close;
+
+	ASSERT_STRNEQ((const char *) errmsg.msg, tgt_errmsg,
+		      42 /* strlen(tgt_errmsg) */, "check error message");
+
+out_close:
+	perf_buffer__free(pb);
+	bpf_object__close(obj);
+	test_xdp_attach_fail__destroy(skel);
+}
+
 void serial_test_xdp_attach(void)
 {
 	if (test__start_subtest("xdp_attach"))
 		test_xdp_attach("./test_xdp.bpf.o");
 	if (test__start_subtest("xdp_attach_dynptr"))
 		test_xdp_attach("./test_xdp_dynptr.bpf.o");
+	if (test__start_subtest("xdp_attach_failed"))
+		test_xdp_attach_fail("./xdp_dummy.bpf.o");
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c b/tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c
new file mode 100644
index 0000000000000..64baf73910a0e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Leon Hwang */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct xdp_errmsg {
+	char msg[64];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} xdp_errmsg_pb SEC(".maps");
+
+struct xdp_attach_error_ctx {
+	unsigned long unused;
+
+	/*
+	 * bpf does not support tracepoint __data_loc directly.
+	 *
+	 * Actually, this field is a 32 bit integer whose value encodes
+	 * information on where to find the actual data. The first 2 bytes is
+	 * the size of the data. The last 2 bytes is the offset from the start
+	 * of the tracepoint struct where the data begins.
+	 * -- https://github.com/iovisor/bpftrace/pull/1542
+	 */
+	__u32 msg; // __data_loc char[] msg;
+};
+
+/*
+ * Catch up the error message at the tracepoint.
+ */
+
+SEC("tp/xdp/bpf_xdp_link_attach_failed")
+int tp__xdp__bpf_xdp_link_attach_failed(struct xdp_attach_error_ctx *ctx)
+{
+	struct xdp_errmsg errmsg;
+	char *msg = (void *)(__u64) ((void *) ctx + (__u16) ctx->msg);
+
+	bpf_probe_read_kernel_str(&errmsg.msg, sizeof(errmsg.msg), msg);
+	bpf_perf_event_output(ctx, &xdp_errmsg_pb, BPF_F_CURRENT_CPU, &errmsg,
+			      sizeof(errmsg));
+	return 0;
+}
+
+/*
+ * Reuse the XDP program in xdp_dummy.c.
+ */
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.41.0


