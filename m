Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048E53936E5
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 22:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhE0UPp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 16:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbhE0UPm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 16:15:42 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DD7C061574
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 13:14:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m8-20020a17090a4148b029015fc5d36343so1155372pjg.1
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xhh14+NC5dBagYqXQ5KzOQwL64MDTeDSeZOD4eZCp18=;
        b=BhWoGUcPbbkqPquxLZawTEvk7ysX6Vf0AOXleX8sDNNLB5lDsXHFBuLNsc7ydGlWDX
         486ouDWhKxnXjcH8tqQLD6at3CXpKeru1xNyqEEPkdMJ0CzsXuwuus3shwaLtfRAzoMQ
         xAsrNl8GSkSPUMc5D2X/PRmR5Yh7ATaBFBYD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xhh14+NC5dBagYqXQ5KzOQwL64MDTeDSeZOD4eZCp18=;
        b=e63MoPD0Hm8VzUVYm1Oaq1ZsECkH7wWHrhVeZiLmCRZ6b5nvnrC4sybEx8GXp9zWV8
         yD763BBuW/ysnLbg7vP0maokhQ1fhA0wL6CQb1jGJxIl8JKzmba1I3JmjyNR8pMyCyYc
         WoAsQmYO1k6ZO1EnhBkbsYMPEE6N9mK44CgDrgfdGnvkM6uu7jch6nvc/zq2MzeILVJs
         itLKQA98/jrZaM+0KVVotF664AANEY4d+SYQyV7W7vXhRkl1bCUrZeSUNthN+O8t3pUG
         3Hqh4mp22dA7/2gUo/XC1F8lrIIsrcPXTblNVTgke1hfDeMaFVHmUW+rpCb2BDANpZfJ
         OnSw==
X-Gm-Message-State: AOAM531eMfqKv0l2kHxk0PQ5tu1iNtyLiKpVhVb95YSJz9m60jHXipW0
        lUpithYufdMzjkspUm3YOV2yl+lvSNFq0Q==
X-Google-Smtp-Source: ABdhPJwwqsSjBJ7KD2AqUSbd/oMzGBejeXplg86FHm0PvhuQq7lMwcwqA44SzwUDrViz1WVUBAg3Ww==
X-Received: by 2002:a17:903:30c4:b029:f0:ad43:4ca with SMTP id s4-20020a17090330c4b02900f0ad4304camr4631415plc.70.1622146447244;
        Thu, 27 May 2021 13:14:07 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id 4sm2462456pgn.31.2021.05.27.13.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:14:06 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Zvi Effron <zeffron@riotgames.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add test for xdp_md context in BPF_PROG_TEST_RUN
Date:   Thu, 27 May 2021 20:13:41 +0000
Message-Id: <20210527201341.7128-4-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201341.7128-1-zeffron@riotgames.com>
References: <20210527201341.7128-1-zeffron@riotgames.com>
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
 .../bpf/prog_tests/xdp_context_test_run.c     | 116 ++++++++++++++++++
 .../bpf/progs/test_xdp_context_test_run.c     |  20 +++
 2 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
new file mode 100644
index 000000000000..f6d312005b7c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -0,0 +1,116 @@
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
+	tattr.ctx_in = &ctx_in;
+	tattr.ctx_size_in = sizeof(ctx_in);
+
+	tattr.ctx_in = &ctx_in;
+	tattr.ctx_size_in = sizeof(ctx_in);
+	ctx_in.data_meta = 0;
+	ctx_in.data = sizeof(__u32);
+	ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_OK(err, "bpf_prog_test_run(test1)");
+	ASSERT_EQ(tattr.retval, XDP_PASS, "test1-retval");
+	ASSERT_EQ(tattr.data_size_out, sizeof(pkt_v4), "test1-datasize");
+	ASSERT_EQ(tattr.ctx_size_out, tattr.ctx_size_in, "test1-ctxsize");
+	ASSERT_EQ(ctx_out.data_meta, 0, "test1-datameta");
+	ASSERT_EQ(ctx_out.data, ctx_out.data_meta, "test1-data");
+	ASSERT_EQ(ctx_out.data_end, sizeof(pkt_v4), "test1-dataend");
+
+	/* Data past the end of the kernel's struct xdp_md must be 0 */
+	bad_ctx[sizeof(bad_ctx) - 1] = 1;
+	tattr.ctx_in = bad_ctx;
+	tattr.ctx_size_in = sizeof(bad_ctx);
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_ERR(err, "bpf_prog_test_run(test2)");
+	ASSERT_EQ(errno, 22, "test2-errno");
+
+	/* The egress cannot be specified */
+	ctx_in.egress_ifindex = 1;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_ERR(err, "bpf_prog_test_run(test3)");
+	ASSERT_EQ(errno, 22, "test3-errno");
+
+	/* data_meta must reference the start of data */
+	ctx_in.data_meta = sizeof(__u32);
+	ctx_in.data = ctx_in.data_meta;
+	ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
+	ctx_in.egress_ifindex = 0;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_ERR(err, "bpf_prog_test_run(test4)");
+	ASSERT_EQ(errno, 22, "test4-errno");
+
+	/* Metadata must be 32 bytes or smaller */
+	ctx_in.data_meta = 0;
+	ctx_in.data = sizeof(__u32)*9;
+	ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_ERR(err, "bpf_prog_test_run(test5)");
+	ASSERT_EQ(errno, 22, "test5-errno");
+
+	/* Metadata's size must be a multiple of 4 */
+	ctx_in.data = 3;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_ERR(err, "bpf_prog_test_run(test6)");
+	ASSERT_EQ(errno, 22, "test6-errno");
+
+	/* Total size of data must match data_end - data_meta */
+	ctx_in.data = 0;
+	ctx_in.data_end = sizeof(pkt_v4) - 4;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_ERR(err, "bpf_prog_test_run(test7)");
+	ASSERT_EQ(errno, 22, "test7-errno");
+
+	ctx_in.data_end = sizeof(pkt_v4) + 4;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_ERR(err, "bpf_prog_test_run(test8)");
+	ASSERT_EQ(errno, 22, "test8-errno");
+
+	/* RX queue cannot be specified without specifying an ingress */
+	ctx_in.data_end = sizeof(pkt_v4);
+	ctx_in.ingress_ifindex = 0;
+	ctx_in.rx_queue_index = 1;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_ERR(err, "bpf_prog_test_run(test9)");
+	ASSERT_EQ(errno, 22, "test9-errno");
+
+	ctx_in.ingress_ifindex = 1;
+	ctx_in.rx_queue_index = 1;
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_ERR(err, "bpf_prog_test_run(test10)");
+	ASSERT_EQ(errno, 22, "test10-errno");
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

