Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4575239933F
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 21:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhFBTLy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 15:11:54 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:46816 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFBTLx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Jun 2021 15:11:53 -0400
Received: by mail-pl1-f182.google.com with SMTP id e1so1579982pld.13
        for <bpf@vger.kernel.org>; Wed, 02 Jun 2021 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gE6JKqyNdruBi/cWEwhmI0B7uKKCxYgcBMMsx5i3xIY=;
        b=bI3KUiypFNg9R4jSIaJ9FMd9cczbCRv++cglB3nTUHGO2eRk1sgt9nKORq26KL/KJh
         xkRX2zk7dRDPFFvZkhjN5teMhY7doxI6DGa5XuKgU0a3PfRMbYWar3AIwbbX2FOumNdn
         a55qJzZbXt4ni+0kaBBr5I3bCxkJNQFxcly94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gE6JKqyNdruBi/cWEwhmI0B7uKKCxYgcBMMsx5i3xIY=;
        b=DvpL4ljbGeluWPNg+/Yo4FOQydC2LR/GJFgPcZh9cyMp0GWbw3LDrrIB2Wi7/r0gyq
         GQ+2WiCthdjxpAMXZwH3hVGC+q269kc/f1CPtClv27eeKNWv1j3gErC8h+AUZJ2UGhrd
         KVhpMvtVNvhgyWeVSeuIeMD8eH5NzEeoHnojaHTA1GPEcbECoojCWficpogqmf6HQo5N
         MmnYQeLhkdElJaXpXj1c69r84KUZQrlY7mxD6xvGwUIan3aefy0FcVyoZuupEA9ytAeU
         gWUptxq7QvGjU184eq5XRfLzRXC+v0I+mOACIRKEQBhNqG34SU6qWdId7/oio/77IrZV
         MQaA==
X-Gm-Message-State: AOAM530MEPolkBhc50ugQpJJ0AUT0bL5gRfpAuYnXbEuZOIr7BDfRoI6
        VL8QnS/2O+6Jft/I3kCxAWW4eY5i960xXA==
X-Google-Smtp-Source: ABdhPJzw6pbg1LSs9UG71IQMze9IoMAcLaQjOzb3jEwQQOwLaFW2r+PSzch9M+zJGWsh79avlGacvw==
X-Received: by 2002:a17:90a:dac1:: with SMTP id g1mr6951482pjx.199.1622660950195;
        Wed, 02 Jun 2021 12:09:10 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id j12sm458036pgs.83.2021.06.02.12.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:09:09 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Zvi Effron <zeffron@riotgames.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add test for xdp_md context in BPF_PROG_TEST_RUN
Date:   Wed,  2 Jun 2021 19:08:15 +0000
Message-Id: <20210602190815.8096-4-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602190815.8096-1-zeffron@riotgames.com>
References: <20210602190815.8096-1-zeffron@riotgames.com>
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
 .../bpf/prog_tests/xdp_context_test_run.c     | 114 ++++++++++++++++++
 .../bpf/progs/test_xdp_context_test_run.c     |  20 +++
 2 files changed, 134 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
new file mode 100644
index 000000000000..0dbdebbc66ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "test_xdp_context_test_run.skel.h"
+
+void test_xdp_context_test_run(void)
+{
+	struct test_xdp_context_test_run *skel = NULL;
+	char data[sizeof(pkt_v4) + sizeof(__u32)];
+	char buf[128];
+	char bad_ctx[sizeof(struct xdp_md)];
+	struct xdp_md ctx_in, ctx_out;
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &data,
+			    .data_out = buf,
+				.data_size_in = sizeof(data),
+			    .data_size_out = sizeof(buf),
+			    .ctx_out = &ctx_out,
+			    .ctx_size_out = sizeof(ctx_out),
+			    .repeat = 1,
+		);
+	int err, prog_fd;
+
+	skel = test_xdp_context_test_run__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		return;
+	prog_fd = bpf_program__fd(skel->progs._xdp_context);
+
+	*(__u32 *)data = XDP_PASS;
+	*(struct ipv4_packet *)(data + sizeof(__u32)) = pkt_v4;
+
+	memset(&ctx_in, 0, sizeof(ctx_in));
+	opts.ctx_in = &ctx_in;
+	opts.ctx_size_in = sizeof(ctx_in);
+
+	opts.ctx_in = &ctx_in;
+	opts.ctx_size_in = sizeof(ctx_in);
+	ctx_in.data_meta = 0;
+	ctx_in.data = sizeof(__u32);
+	ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_OK(err, "bpf_prog_test_run(test1)");
+	ASSERT_EQ(opts.retval, XDP_PASS, "test1-retval");
+	ASSERT_EQ(opts.data_size_out, sizeof(pkt_v4), "test1-datasize");
+	ASSERT_EQ(opts.ctx_size_out, opts.ctx_size_in, "test1-ctxsize");
+	ASSERT_EQ(ctx_out.data_meta, 0, "test1-datameta");
+	ASSERT_EQ(ctx_out.data, ctx_out.data_meta, "test1-data");
+	ASSERT_EQ(ctx_out.data_end, sizeof(pkt_v4), "test1-dataend");
+
+	/* Data past the end of the kernel's struct xdp_md must be 0 */
+	bad_ctx[sizeof(bad_ctx) - 1] = 1;
+	opts.ctx_in = bad_ctx;
+	opts.ctx_size_in = sizeof(bad_ctx);
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_EQ(errno, 22, "test2-errno");
+	ASSERT_ERR(err, "bpf_prog_test_run(test2)");
+
+	/* The egress cannot be specified */
+	ctx_in.egress_ifindex = 1;
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_EQ(errno, 22, "test3-errno");
+	ASSERT_ERR(err, "bpf_prog_test_run(test3)");
+
+	/* data_meta must reference the start of data */
+	ctx_in.data_meta = sizeof(__u32);
+	ctx_in.data = ctx_in.data_meta;
+	ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
+	ctx_in.egress_ifindex = 0;
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_EQ(errno, 22, "test4-errno");
+	ASSERT_ERR(err, "bpf_prog_test_run(test4)");
+
+	/* Metadata must be 32 bytes or smaller */
+	ctx_in.data_meta = 0;
+	ctx_in.data = sizeof(__u32)*9;
+	ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_EQ(errno, 22, "test5-errno");
+	ASSERT_ERR(err, "bpf_prog_test_run(test5)");
+
+	/* Metadata's size must be a multiple of 4 */
+	ctx_in.data = 3;
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_EQ(errno, 22, "test6-errno");
+	ASSERT_ERR(err, "bpf_prog_test_run(test6)");
+
+	/* Total size of data must match data_end - data_meta */
+	ctx_in.data = 0;
+	ctx_in.data_end = sizeof(pkt_v4) - 4;
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_EQ(errno, 22, "test7-errno");
+	ASSERT_ERR(err, "bpf_prog_test_run(test7)");
+
+	ctx_in.data_end = sizeof(pkt_v4) + 4;
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_EQ(errno, 22, "test8-errno");
+	ASSERT_ERR(err, "bpf_prog_test_run(test8)");
+
+	/* RX queue cannot be specified without specifying an ingress */
+	ctx_in.data_end = sizeof(pkt_v4);
+	ctx_in.ingress_ifindex = 0;
+	ctx_in.rx_queue_index = 1;
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_EQ(errno, 22, "test9-errno");
+	ASSERT_ERR(err, "bpf_prog_test_run(test9)");
+
+	ctx_in.ingress_ifindex = 1;
+	ctx_in.rx_queue_index = 1;
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_EQ(errno, 22, "test10-errno");
+	ASSERT_ERR(err, "bpf_prog_test_run(test10)");
+
+	test_xdp_context_test_run__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
new file mode 100644
index 000000000000..56fd0995b67c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("xdp")
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

