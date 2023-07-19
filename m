Return-Path: <bpf+bounces-5282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714A57595F6
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 14:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C863281810
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C881549A;
	Wed, 19 Jul 2023 12:53:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4E12B88;
	Wed, 19 Jul 2023 12:53:12 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A081719;
	Wed, 19 Jul 2023 05:53:11 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b89b75dc1cso5277015ad.1;
        Wed, 19 Jul 2023 05:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689771191; x=1690375991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZEc1m9bRrutzRiHcrkT5tCiyj18axUv2cav0ilgCkI=;
        b=ZHZfxTnnwbEaOht+uP3JCF6eIY1dxKPFo3Z/TDQauEJ8mO1lxhIa96nvA8OheLIB7E
         M2InhdGdkoZpQoh1GhL9+ca4ckILbyvfm+lyqLnuWCd1Dy5B+xd1hA/WSBFFPneLD76t
         vEAvOU79Ga3Ebh3bvZLHa3i3p9UvCU1Fke4q20zACt4GutsBFdYkmL8fbfegaAHFjDop
         wslebTR1J05b9kITr3nqkD44Qilzp9bBSmzQJaMsArImOarhGu7MTXNO1t/i+DEXn1U9
         2zyradUQUZawn2dNYYv7tIiBgxZU+OD4nfGLRflw8JovypIsWPsqE1juXi8bjW2ecTEj
         mmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689771191; x=1690375991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZEc1m9bRrutzRiHcrkT5tCiyj18axUv2cav0ilgCkI=;
        b=ZqMB1riqT5c/oxiEypQLwuaEsv0/snYB5jaXiNFsnTXQ3icy80+shlXDy9kIi3Aiti
         ddgngg9TKDaN+ztn41qJqLdIRN/pMJOIzsGe6TM0suF7VmrEPSx6l4dvWYWaKZXC4a2w
         U3AwlIRspBsNZraOkudf9BzEgsMt60KY8ozVNc7IHbkS69AsQJDMUzaGX3eEnmdABrhR
         mKkncTvVTXHIXMD1anNYEjSTNiHohZRIYNgFb6AnhKXOYL/kzR7vimmwqACxnSQ0qHiI
         JmcnmC5Ki+GZriHo4aW8GLDqARqbICCL2s14shrjylsUphKIAPoHOXiN7rPRI2D5lvC2
         smYw==
X-Gm-Message-State: ABy/qLaIT+XXPYQ3yA+cwJFimhsAOJfBbGfu/GZyD4TdIfNCEDljhB91
	IV6eaIiX5yIzmyJAWkIufq4=
X-Google-Smtp-Source: APBJJlHwLXwtaeOlnIc52QYsqsgbFEJYr6VcRF/nfeZ0tSFhcgqsVvDrh22xdSoZ12XNNcERxIbAMQ==
X-Received: by 2002:a17:90a:98c:b0:263:f674:490e with SMTP id 12-20020a17090a098c00b00263f674490emr2682197pjo.3.1689771190668;
        Wed, 19 Jul 2023 05:53:10 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id lc14-20020a17090b158e00b002612150d958sm1146191pjb.16.2023.07.19.05.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 05:53:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add testcase for xdp attaching failure tracepoint
Date: Wed, 19 Jul 2023 20:52:32 +0800
Message-ID: <20230719125232.92607-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719125232.92607-1-hffilwlqm@gmail.com>
References: <20230719125232.92607-1-hffilwlqm@gmail.com>
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
 .../selftests/bpf/prog_tests/xdp_attach.c     | 63 +++++++++++++++++++
 .../bpf/progs/test_xdp_attach_fail.c          | 51 +++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
index fa3cac5488f5d..265dba875f16b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "test_xdp_attach_fail.skel.h"
 
 #define IFINDEX_LO 1
 #define XDP_FLAGS_REPLACE		(1U << 4)
@@ -85,10 +87,74 @@ static void test_xdp_attach(const char *file)
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
index 0000000000000..ad8d536775d9d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c
@@ -0,0 +2,51 @@
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
+ * Catch the error message at the tracepoint.
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


