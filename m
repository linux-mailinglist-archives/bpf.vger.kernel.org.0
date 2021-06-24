Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD42A3B3869
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 23:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhFXVPh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 17:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhFXVPf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 17:15:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B00AC061574
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 14:13:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bb20so4231431pjb.3
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7ulsYfJ0MfqaARRsxHfgDB76o1kt2u5dSehW+gl5BI=;
        b=VtjnMsQ71LxuoZPxD3GputJgRQ98WXD1fNDmw84h+FiEd1BmJIxco9ktC0P/4qzTLS
         S48SJ5sEqZ6ieV24wxq3NNO0Rzf+M0bB0YGv6EK0ILtcYdp628Ik8cs72iNF93pBYf1Z
         aZAXTBkfDrz6SdG2Z4vwS/hWqWxb86kFiWXGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7ulsYfJ0MfqaARRsxHfgDB76o1kt2u5dSehW+gl5BI=;
        b=YmOBcU+sIgxGQIVbeRKQQkrBkhE5JKerBhPAjITt8UYsYCiXOYyI3d+gqrnSTP9u6+
         xRwf+qZDrwiG6h6IIfwSx5nmgXN9f1whgvkWi1r8wOl4GBpSem2uWTpCvsrveT0X120o
         K9XUIBWF8oqu3jcs6vOllpXkAlpJV+nk/mC134ryktvUWtM237zGpnuMDr1yyl9JtYpX
         Ook6bhqrxxtuFx1mWBAbKiCNl2LitTEu6Qe+7WzsRD9m9aIeCO7/hEVQwiSFT98afb9r
         w2lw5PA41mp46Jviokk1KfSAcUD7W3O30YTi80Gia66BqUn3WDnUS3v5YNuoYz9dBChS
         GVYw==
X-Gm-Message-State: AOAM531uKRm8jtC/AibOEFYarmaUoqmxSRB23y3AYkm0dgGoZqA+qejY
        QYrtIG3FVHVMZTtbFg9XGvrE3V943oO8B7wf
X-Google-Smtp-Source: ABdhPJyRq6eTSZDhqnpTxqSQsE1DfMBEc3zEYua3qY4Vf0SiDobapZrD4ny/QyfQQPgg8UcP++WoTw==
X-Received: by 2002:a17:90a:c788:: with SMTP id gn8mr7494085pjb.207.1624569195481;
        Thu, 24 Jun 2021 14:13:15 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id d13sm3615394pfn.136.2021.06.24.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:13:14 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Zvi Effron <zeffron@riotgames.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: [PATCH bpf-next v7 4/4] selftests/bpf: Add test for xdp_md context in BPF_PROG_TEST_RUN
Date:   Thu, 24 Jun 2021 21:13:04 +0000
Message-Id: <20210624211304.90807-5-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210624211304.90807-1-zeffron@riotgames.com>
References: <20210624211304.90807-1-zeffron@riotgames.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test for using xdp_md as a context to BPF_PROG_TEST_RUN for XDP
programs.

The test uses a BPF program that takes in a return value from XDP
meta data, then reduces the size of the XDP meta data by 4 bytes.

Test cases validate the possible failure cases for passing in invalid
xdp_md contexts, that the return value is successfully passed
in, and that the adjusted meta data is successfully copied out.

Co-developed-by: Cody Haas <chaas@riotgames.com>
Signed-off-by: Cody Haas <chaas@riotgames.com>
Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Zvi Effron <zeffron@riotgames.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c     | 105 ++++++++++++++++++
 .../bpf/progs/test_xdp_context_test_run.c     |  20 ++++
 2 files changed, 125 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
new file mode 100644
index 000000000000..ab4952b9fb1d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "test_xdp_context_test_run.skel.h"
+
+void test_xdp_context_error(int prog_fd, struct bpf_test_run_opts opts,
+			    __u32 data_meta, __u32 data, __u32 data_end,
+			    __u32 ingress_ifindex, __u32 rx_queue_index,
+			    __u32 egress_ifindex)
+{
+	struct xdp_md ctx = {
+		.data = data,
+		.data_end = data_end,
+		.data_meta = data_meta,
+		.ingress_ifindex = ingress_ifindex,
+		.rx_queue_index = rx_queue_index,
+		.egress_ifindex = egress_ifindex,
+	};
+	int err;
+
+	opts.ctx_in = &ctx;
+	opts.ctx_size_in = sizeof(ctx);
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_EQ(errno, EINVAL, "errno-EINVAL");
+	ASSERT_ERR(err, "bpf_prog_test_run");
+}
+
+void test_xdp_context_test_run(void)
+{
+	struct test_xdp_context_test_run *skel = NULL;
+	char data[sizeof(pkt_v4) + sizeof(__u32)];
+	char bad_ctx[sizeof(struct xdp_md) + 1];
+	struct xdp_md ctx_in, ctx_out;
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &data,
+			    .data_size_in = sizeof(data),
+			    .ctx_out = &ctx_out,
+			    .ctx_size_out = sizeof(ctx_out),
+			    .repeat = 1,
+		);
+	int err, prog_fd;
+
+	skel = test_xdp_context_test_run__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		return;
+	prog_fd = bpf_program__fd(skel->progs.xdp_context);
+
+	/* Data past the end of the kernel's struct xdp_md must be 0 */
+	bad_ctx[sizeof(bad_ctx) - 1] = 1;
+	opts.ctx_in = bad_ctx;
+	opts.ctx_size_in = sizeof(bad_ctx);
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_EQ(errno, E2BIG, "extradata-errno");
+	ASSERT_ERR(err, "bpf_prog_test_run(extradata)");
+
+	*(__u32 *)data = XDP_PASS;
+	*(struct ipv4_packet *)(data + sizeof(__u32)) = pkt_v4;
+	opts.ctx_in = &ctx_in;
+	opts.ctx_size_in = sizeof(ctx_in);
+	memset(&ctx_in, 0, sizeof(ctx_in));
+	ctx_in.data_meta = 0;
+	ctx_in.data = sizeof(__u32);
+	ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_OK(err, "bpf_prog_test_run(valid)");
+	ASSERT_EQ(opts.retval, XDP_PASS, "valid-retval");
+	ASSERT_EQ(opts.data_size_out, sizeof(pkt_v4), "valid-datasize");
+	ASSERT_EQ(opts.ctx_size_out, opts.ctx_size_in, "valid-ctxsize");
+	ASSERT_EQ(ctx_out.data_meta, 0, "valid-datameta");
+	ASSERT_EQ(ctx_out.data, 0, "valid-data");
+	ASSERT_EQ(ctx_out.data_end, sizeof(pkt_v4), "valid-dataend");
+
+	/* Meta data's size must be a multiple of 4 */
+	test_xdp_context_error(prog_fd, opts, 0, 1, sizeof(data), 0, 0, 0);
+
+	/* data_meta must reference the start of data */
+	test_xdp_context_error(prog_fd, opts, 4, sizeof(__u32), sizeof(data),
+			       0, 0, 0);
+
+	/* Meta data must be 32 bytes or smaller */
+	test_xdp_context_error(prog_fd, opts, 0, 36, sizeof(data), 0, 0, 0);
+
+	/* Total size of data must match data_end - data_meta */
+	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
+			       sizeof(data) - 1, 0, 0, 0);
+	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
+			       sizeof(data) + 1, 0, 0, 0);
+
+	/* RX queue cannot be specified without specifying an ingress */
+	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32), sizeof(data),
+			       0, 1, 0);
+
+	/* Interface 1 is always the loopback interface which always has only
+	 * one RX queue (index 0). This makes index 1 an invalid rx queue index
+	 * for interface 1.
+	 */
+	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32), sizeof(data),
+			       1, 1, 0);
+
+	/* The egress cannot be specified */
+	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32), sizeof(data),
+			       0, 0, 1);
+
+	test_xdp_context_test_run__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
new file mode 100644
index 000000000000..d7b88cd05afd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("xdp")
+int xdp_context(struct xdp_md *xdp)
+{
+	void *data = (void *)(long)xdp->data;
+	__u32 *metadata = (void *)(long)xdp->data_meta;
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

