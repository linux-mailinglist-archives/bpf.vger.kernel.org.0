Return-Path: <bpf+bounces-68953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BACB1B8ADF6
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22FE169C85
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1342256C6F;
	Fri, 19 Sep 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtfjOuJt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9108D26CE10
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305375; cv=none; b=TC+pUJ03VVXImw8GLv5I8TiweTdWH3br9FL20jna9GKbXzolyFyOz9Ji6uJ8KnwOM9QEUYBxIxOvrsx+NwfWk3RXHzkHK0bxCJlLBDQPQR63xx3+D0ro+ptV9PdyhgHkezBWK5wv8vYm5N6QfppRLuxbB4vN97sScvC1bbyPU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305375; c=relaxed/simple;
	bh=ebEe9IkyQgkamx37VBlEmeJSVSG9SRHubSWbTb9SAwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ0t1Z6lNJDTfRTXkEKYa17YlyoWKHFGpsxYBf8Cg+0YzQ0tsPDsJXypSbz40tqE+5VAcP54Xt6m2lyVztzoSImJhrtZ36Buh8s7HWULp7P3Rhh8DxK0KX7Ci68YoF5erbfcqVJ1nOrkOymdBo+/y7Y6xsrBi1y9r+eGTnNPSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtfjOuJt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77251d7cca6so2510496b3a.3
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305373; x=1758910173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAxzi5B6cBNAyJn1tXCxSzkoEcVVhnXO76uSYmveprE=;
        b=mtfjOuJtE+JHiH7TGEUujA0JVKvnFAgJN6GCgI9IV9iXEHDDIX4nh+9p8vzqTkZQ67
         yjwWEJkMrrgSjXe81O1gm0Ty+CxADe3Ox65JXZDeP2Y3XLCRAFuCg5T4DOD5E5jNbW1y
         eYOVDRS8BRdsp6EJg88P5GCc7awRHLmUVkXP239zQHJr3QkfipKVIhS31JYwqnJYp5z0
         8FACCt7qmJNv4SP5l4uM0tNuPXMN2yVIlxc24Jk6P6298wydt+8iG+wOojwS2nEJHbcv
         5Ff1uySesMFv9WpARr8l4UbtNNVnOx82659zkrn6CGOc36ULPyzNjHsJPaD9qqA85IDr
         9yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305373; x=1758910173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAxzi5B6cBNAyJn1tXCxSzkoEcVVhnXO76uSYmveprE=;
        b=VqwssdF+SyqheiJjxKP3C8TIG28nzSTDiqX46CThmz1BpKrCtOLyd2aL5uwaoYpKOt
         AA+5XQRvKvrAxJqiI2JGFTxM/NsBeSvqN23Un0WLPzjpaesO7EXvjONzV1pBjMDxFxcA
         yWT2UR6uEbWJ/OlpNCI973hMpyZcKNvQtqTXcWhxdBGP/0DGe7wQQYoFu1J3Vma8YC8Y
         Dnz+vx3iFc2PsMjrWZmOKPLKyge6M83mwRdjPqhd/69HTJHQmxiTCJXrfkXBn18ABsVA
         ZIWPoKz7QbkFaoyFExF4hSVDCP7mY4x40MQSb7LdqDu78Iy1sGNfZTLtxJVlEoroWDgA
         Nn1Q==
X-Gm-Message-State: AOJu0YzJK+VLqGxFTzT+Sx49yEUdmqbxEfOMRMH+usrV4dG+Y0DAq5Xf
	D/m4OC4ycLg0XRKjRpt4KHUBjUgqfw6J54vSnDI9y6VB71DiH6uNOH/eWmnWmA==
X-Gm-Gg: ASbGncuVKdWuPkk8qDeas1sf0DmQ9LIE84MQZvX+wBwEujlsnl0z3fjpiTnhINdlftm
	3Pu2Zt9b83pfxzOWzs2j/3OG5u5rICcXobmyb6zSc3rf6cQUBumbodlUGid7H/l0+kQiIpy1lGg
	k78OYOuuRD63y6wabxbGE8Fys0TN/lzfDckTh+8WJh184RUxGQkdZ95MQu+q1KncvJrL5jOh3EW
	4ZM7sbv8xHmtfQfp1n0/azpN0ZhFYzMCRyl5Rs9H4IEdPC+OJ582yxjMwpG9M/8+bcdWVjkRYsb
	4nFjfrfRtVjp7R1Z/HA4wZ9Z3gaeho9k3HKKI80uPm7bIavmeMJN1Cx2WWAcQtzlxJOzXW72oM8
	D7nOQbUsW9BBHftzi8IcjmiNB
X-Google-Smtp-Source: AGHT+IFpKy03VVXHRFUWA0zTaJ1kiPigY2ZLcQIqACK/zncO6Og/fwFBmlQscPr9TTj099hsmIYa0Q==
X-Received: by 2002:a05:6a00:a1c:b0:77c:8354:4e37 with SMTP id d2e1a72fcca58-77e4eeb2d0emr4845587b3a.27.1758305372650;
        Fri, 19 Sep 2025 11:09:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e20bf07c4sm3417706b3a.70.2025.09.19.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:09:32 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 5/6] selftests/bpf: Test bpf_xdp_pull_data
Date: Fri, 19 Sep 2025 11:09:25 -0700
Message-ID: <20250919180926.1760403-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919180926.1760403-1-ameryhung@gmail.com>
References: <20250919180926.1760403-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test bpf_xdp_pull_data() with xdp packets with different layouts. The
xdp bpf program first checks if the layout is as expected. Then, it
calls bpf_xdp_pull_data(). Finally, it checks the 0xbb marker at offset
1024 using directly packet access.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 176 ++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
 2 files changed, 224 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
new file mode 100644
index 000000000000..c16801b73fed
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "test_xdp_pull_data.skel.h"
+
+#define PULL_MAX	(1 << 31)
+#define PULL_PLUS_ONE	(1 << 30)
+
+#define XDP_PACKET_HEADROOM 256
+
+/* Find sizes of struct skb_shared_info and struct xdp_frame so that
+ * we can calculate the maximum pull lengths for test cases
+ */
+static int find_xdp_sizes(struct test_xdp_pull_data *skel, int frame_sz)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct xdp_md ctx = {};
+	int prog_fd, err;
+	__u8 *buf;
+
+	buf = calloc(frame_sz, sizeof(__u8));
+	if (!ASSERT_OK_PTR(buf, "calloc buf"))
+		return -ENOMEM;
+
+	topts.data_in = buf;
+	topts.data_out = buf;
+	topts.data_size_in = frame_sz;
+	topts.data_size_out = frame_sz;
+	/* Pass a data_end larger than the linear space available to make sure
+	 * bpf_prog_test_run_xdp() will fill the linear data area so that
+	 * xdp_find_data_hard_end can infer the size of struct skb_shared_info
+	 */
+	ctx.data_end = frame_sz;
+	topts.ctx_in = &ctx;
+	topts.ctx_out = &ctx;
+	topts.ctx_size_in = sizeof(ctx);
+	topts.ctx_size_out = sizeof(ctx);
+
+	prog_fd = bpf_program__fd(skel->progs.xdp_find_sizes);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	free(buf);
+
+	return err;
+}
+
+/* xdp_pull_data_prog will directly read a marker 0xbb stored at buf[1024]
+ * so caller expecting XDP_PASS should always pass pull_len no less than 1024
+ */
+static void run_test(struct test_xdp_pull_data *skel, int retval,
+		     int frame_sz, int buff_len, int meta_len, int data_len,
+		     int pull_len)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct xdp_md ctx = {};
+	int prog_fd, err;
+	__u8 *buf;
+
+	buf = calloc(buff_len, sizeof(__u8));
+	if (!ASSERT_OK_PTR(buf, "calloc buf"))
+		return;
+
+	buf[meta_len + 1023] = 0xaa;
+	buf[meta_len + 1024] = 0xbb;
+	buf[meta_len + 1025] = 0xcc;
+
+	topts.data_in = buf;
+	topts.data_out = buf;
+	topts.data_size_in = buff_len;
+	topts.data_size_out = buff_len;
+	ctx.data = meta_len;
+	ctx.data_end = meta_len + data_len;
+	topts.ctx_in = &ctx;
+	topts.ctx_out = &ctx;
+	topts.ctx_size_in = sizeof(ctx);
+	topts.ctx_size_out = sizeof(ctx);
+
+	skel->bss->data_len = data_len;
+	if (pull_len & PULL_MAX) {
+		int headroom = XDP_PACKET_HEADROOM - meta_len - skel->bss->xdpf_sz;
+		int tailroom = frame_sz - XDP_PACKET_HEADROOM -
+			       data_len - skel->bss->sinfo_sz;
+
+		pull_len = pull_len & PULL_PLUS_ONE ? 1 : 0;
+		pull_len += headroom + tailroom + data_len;
+	}
+	skel->bss->pull_len = pull_len;
+
+	prog_fd = bpf_program__fd(skel->progs.xdp_pull_data_prog);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	ASSERT_EQ(topts.retval, retval, "xdp_pull_data_prog retval");
+
+	if (retval == XDP_DROP)
+		goto out;
+
+	ASSERT_EQ(ctx.data_end, meta_len + pull_len, "linear data size");
+	ASSERT_EQ(topts.data_size_out, buff_len, "linear + non-linear data size");
+	/* Make sure data around xdp->data_end was not messed up by
+	 * bpf_xdp_pull_data()
+	 */
+	ASSERT_EQ(buf[meta_len + 1023], 0xaa, "data[1023]");
+	ASSERT_EQ(buf[meta_len + 1024], 0xbb, "data[1024]");
+	ASSERT_EQ(buf[meta_len + 1025], 0xcc, "data[1025]");
+out:
+	free(buf);
+}
+
+static void test_xdp_pull_data_basic(void)
+{
+	u32 pg_sz, max_meta_len, max_data_len;
+	struct test_xdp_pull_data *skel;
+
+	skel = test_xdp_pull_data__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load"))
+		return;
+
+	pg_sz = sysconf(_SC_PAGE_SIZE);
+
+	if (find_xdp_sizes(skel, pg_sz))
+		goto out;
+
+	max_meta_len = XDP_PACKET_HEADROOM - skel->bss->xdpf_sz;
+	max_data_len = pg_sz - XDP_PACKET_HEADROOM - skel->bss->sinfo_sz;
+
+	/* linear xdp pkt, pull 0 byte */
+	run_test(skel, XDP_PASS, pg_sz, 2048, 0, 2048, 2048);
+
+	/* multi-buf pkt, pull results in linear xdp pkt */
+	run_test(skel, XDP_PASS, pg_sz, 2048, 0, 1024, 2048);
+
+	/* multi-buf pkt, pull 1 byte to linear data area */
+	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1024, 1025);
+
+	/* multi-buf pkt, pull 0 byte to linear data area */
+	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1025, 1025);
+
+	/* multi-buf pkt, empty linear data area, pull requires memmove */
+	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 0, PULL_MAX);
+
+	/* multi-buf pkt, no headroom */
+	run_test(skel, XDP_PASS, pg_sz, 9000, max_meta_len, 1024, PULL_MAX);
+
+	/* multi-buf pkt, no tailroom, pull requires memmove */
+	run_test(skel, XDP_PASS, pg_sz, 9000, 0, max_data_len, PULL_MAX);
+
+
+	/* linear xdp pkt, pull more than total data len */
+	run_test(skel, XDP_DROP, pg_sz, 2048, 0, 2048, 2049);
+
+	/* multi-buf pkt with no space left in linear data area */
+	run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, max_data_len,
+		 PULL_MAX | PULL_PLUS_ONE);
+
+	/* multi-buf pkt, empty linear data area */
+	run_test(skel, XDP_DROP, pg_sz, 9000, 0, 0, PULL_MAX | PULL_PLUS_ONE);
+
+	/* multi-buf pkt, no headroom */
+	run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, 1024,
+		 PULL_MAX | PULL_PLUS_ONE);
+
+	/* multi-buf pkt, no tailroom */
+	run_test(skel, XDP_DROP, pg_sz, 9000, 0, max_data_len,
+		 PULL_MAX | PULL_PLUS_ONE);
+
+out:
+	test_xdp_pull_data__destroy(skel);
+}
+
+void test_xdp_pull_data(void)
+{
+	if (test__start_subtest("xdp_pull_data"))
+		test_xdp_pull_data_basic();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c b/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
new file mode 100644
index 000000000000..dd901bb109b6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include  "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+int xdpf_sz;
+int sinfo_sz;
+int data_len;
+int pull_len;
+
+#define XDP_PACKET_HEADROOM 256
+
+SEC("xdp.frags")
+int xdp_find_sizes(struct xdp_md *ctx)
+{
+	xdpf_sz = sizeof(struct xdp_frame);
+	sinfo_sz = __PAGE_SIZE - XDP_PACKET_HEADROOM -
+		   (ctx->data_end - ctx->data);
+
+	return XDP_PASS;
+}
+
+SEC("xdp.frags")
+int xdp_pull_data_prog(struct xdp_md *ctx)
+{
+	__u8 *data_end = (void *)(long)ctx->data_end;
+	__u8 *data = (void *)(long)ctx->data;
+	__u8 *val_p;
+	int err;
+
+	if (data_len != data_end - data)
+		return XDP_DROP;
+
+	err = bpf_xdp_pull_data(ctx, pull_len);
+	if (err)
+		return XDP_DROP;
+
+	val_p = (void *)(long)ctx->data + 1024;
+	if (val_p + 1 > (void *)(long)ctx->data_end)
+		return XDP_DROP;
+
+	if (*val_p != 0xbb)
+		return XDP_DROP;
+
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3


