Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2C138F55F
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 00:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhEXWIn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 18:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhEXWIm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 18:08:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32055C061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 15:07:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ot16so13734718pjb.3
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UibHIA6PtHUsJc/Axd9GpqQT8nt/JMe7JNTu9yj2c9M=;
        b=W+aIgMhGVDJjezRWypAhI9hMjaxyOO6rU6BwHqHgcvZRkUP/Czgwd6zA/LirbycANm
         4w2Apz2aKNJWVJXch2eJTGaoXRP7tmSayrHDwlTUA2L7CrXiN9DQwsPiLCiPgKqUsAJo
         wy1UXZuYCi4Rum6hIbV2CUPtHIbcByRJx4amM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UibHIA6PtHUsJc/Axd9GpqQT8nt/JMe7JNTu9yj2c9M=;
        b=cbqJEXgFhL6DDc0Fg8vg3/O6vKArbvdNzRAYwN1wpssyh0PFIjIJJs3QlmMMZp/Aji
         vEeFJLGyNQUKX+sxY9XqCe7X8pL1I7Mh7kqbZNbxCjyCPU+MhNBImXp7JYVG2BvavG39
         nySD5VmVVmDnb/6Hzv4uGgOHxamJ3GnlsW/+07U9+wX+zTbxPSRbUUpWQGwXM5kCPL4J
         r+g6QMcImC5dDqDxYvl9UqMEKYVsMrCdCu6FV1yxA6g/DvB49HGLFjhionMHWic9sQKG
         EWBzaG3fU4yBQSz4AfyBfiJXdYvHKrlTuj1F/JgFYTl6YUzOexsAZgiQQOfCedBYo8Q1
         x75w==
X-Gm-Message-State: AOAM530EEhDoENzSIjdaMKfiVAcg6BBKhgyZ7yjsD0f0evjCUcZSVi83
        IhYOfWaD0alpb9eSGm32FIjmhttoE4nv/3/n
X-Google-Smtp-Source: ABdhPJyyfIemJwATjv2FOGZy3Enqha6aiXZPThQ2pwfXBREPSIrE6IAZWLm2KxTKwJoNkFz9V/ysEg==
X-Received: by 2002:a17:90a:a481:: with SMTP id z1mr1294166pjp.97.1621894033368;
        Mon, 24 May 2021 15:07:13 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id k15sm12133338pfi.0.2021.05.24.15.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 15:07:12 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Zvi Effron <zeffron@riotgames.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add test for xdp_md context in BPF_PROG_TEST_RUN
Date:   Mon, 24 May 2021 22:05:55 +0000
Message-Id: <20210524220555.251473-4-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524220555.251473-1-zeffron@riotgames.com>
References: <20210524220555.251473-1-zeffron@riotgames.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test for using xdp_md as a context to BPF_PROG_TEST_RUN for XDP
programs.

The test uses a BPF program that takes in a return value from XDP
metadata, then reduces the size of the XDP metadata by 4 bytes.

Test cases validate the possible failure cases for passing in invalid
xdp_md contexts, that the return value is successfully passed
in, and that the adjusted metadata is successfully copied out.

Co-developed-by: Cody Haas <chaas@riotgames.com>
Signed-off-by: Cody Haas <chaas@riotgames.com>
Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Zvi Effron <zeffron@riotgames.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c     | 117 ++++++++++++++++++
 .../bpf/progs/test_xdp_context_test_run.c     |  22 ++++
 2 files changed, 139 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
new file mode 100644
index 000000000000..92ce2e4a5c30
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+
+void test_xdp_context_test_run(void)
+{
+	const char *file = "./test_xdp_context_test_run.o";
+	struct bpf_object *obj;
+	char data[sizeof(pkt_v4) + sizeof(__u32)];
+	char buf[128];
+	char bad_ctx[sizeof(struct xdp_md)];
+	struct xdp_md ctx_in, ctx_out;
+	struct bpf_test_run_opts tattr = {
+		.sz = sizeof(struct bpf_test_run_opts),
+		.data_in = &data,
+		.data_out = buf,
+		.data_size_in = sizeof(data),
+		.data_size_out = sizeof(buf),
+		.ctx_out = &ctx_out,
+		.ctx_size_out = sizeof(ctx_out),
+		.repeat = 1,
+	};
+	int err, prog_fd;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
+	if (CHECK_FAIL(err))
+		return;
+
+	*(__u32 *)data = XDP_PASS;
+	*(struct ipv4_packet *)(data + sizeof(__u32)) = pkt_v4;
+
+	memset(&ctx_in, 0, sizeof(ctx_in));
+	tattr.ctx_in = &ctx_in;
+	tattr.ctx_size_in = sizeof(ctx_in);
+
+	tattr.ctx_in = &ctx_in;
+	tattr.ctx_size_in = sizeof(ctx_in);
+	ctx_in.data_meta = 0;
+	ctx_in.data = sizeof(__u32);
+	ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	CHECK_ATTR(err || tattr.retval != XDP_PASS ||
+		   tattr.data_size_out != sizeof(pkt_v4) ||
+		   tattr.ctx_size_out != tattr.ctx_size_in ||
+		   ctx_out.data_meta != 0 ||
+		   ctx_out.data != ctx_out.data_meta ||
+		   ctx_out.data_end != sizeof(pkt_v4), "xdp_md context",
+		   "err %d errno %d retval %d data size out %d context size out %d data_meta %d data %d data_end %d\n",
+		   err, errno, tattr.retval, tattr.data_size_out,
+		   tattr.ctx_size_out, ctx_out.data_meta, ctx_out.data,
+		   ctx_out.data_end);
+
+	/* Data past the end of the kernel's struct xdp_md must be 0 */
+	bad_ctx[sizeof(bad_ctx) - 1] = 1;
+	tattr.ctx_in = bad_ctx;
+	tattr.ctx_size_in = sizeof(bad_ctx);
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	CHECK_ATTR(!err || errno != 22, "bad context", "err %d errno %d\n",
+		   err, errno);
+
+	/* The egress cannot be specified */
+	ctx_in.egress_ifindex = 1;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	CHECK_ATTR(!err || errno != 22,
+		   "nonzero egress index", "err %d errno %d\n", err, errno);
+
+	/* data_meta must reference the start of data */
+	ctx_in.data_meta = sizeof(__u32);
+	ctx_in.data = ctx_in.data_meta;
+	ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
+	ctx_in.egress_ifindex = 0;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	CHECK_ATTR(!err || errno != 22, "nonzero data_meta",
+		   "err %d errno %d\n", err, errno);
+
+	/* Metadata must be 32 bytes or smaller */
+	ctx_in.data_meta = 0;
+	ctx_in.data = sizeof(__u32)*9;
+	ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	CHECK_ATTR(!err || errno != 22, "metadata too long",
+		   "err %d errno %d\n", err, errno);
+
+	/* Metadata's size must be a multiple of 4 */
+	ctx_in.data = 3;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	CHECK_ATTR(!err || errno != 22, "multiple of 4",
+		   "err %d errno %d\n", err, errno);
+
+	/* Total size of data must match data_end - data_meta */
+	ctx_in.data = 0;
+	ctx_in.data_end = sizeof(pkt_v4) - 4;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	CHECK_ATTR(!err || errno != 22, "data too long", "err %d errno %d\n",
+		   err, errno);
+
+	ctx_in.data_end = sizeof(pkt_v4) + 4;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	CHECK_ATTR(!err || errno != 22, "data too short", "err %d errno %d\n",
+		   err, errno);
+
+	/* RX queue cannot be specified without specifying an ingress */
+	ctx_in.data_end = sizeof(pkt_v4);
+	ctx_in.ingress_ifindex = 0;
+	ctx_in.rx_queue_index = 1;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	CHECK_ATTR(!err || errno != 22, "no ingress if",
+		   "err %d, rx_queue_index %d\n", err, ctx_out.rx_queue_index);
+
+	ctx_in.ingress_ifindex = 1;
+	ctx_in.rx_queue_index = 1;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	CHECK_ATTR(!err || errno != 22, "invalid rx queue",
+		   "err %d, rx_queue_index %d\n", err, ctx_out.rx_queue_index);
+
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
new file mode 100644
index 000000000000..c66a756b238e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+int _version SEC("version") = 1;
+
+SEC("xdp_context")
+int _xdp_context(struct xdp_md *xdp)
+{
+	void *data = (void *)(unsigned long)xdp->data;
+	__u32 *metadata = (void *)(unsigned long)xdp->data_meta;
+	__u32 ret;
+
+	if (metadata + 1 > data)
+		return XDP_ABORTED;
+	ret = *metadata;
+	if (bpf_xdp_adjust_meta(xdp, 4))
+		return XDP_ABORTED;
+	return ret;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.31.1

