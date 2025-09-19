Return-Path: <bpf+bounces-68962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2942B8AE6E
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D213E5622D9
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9554279918;
	Fri, 19 Sep 2025 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ+mG5oW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D82701D9
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306070; cv=none; b=BGO31Q45eY+mOAKbn1kPyyD75J8+eHbNd5nkvnAVsxSPHrKlMqWh5Usz6yS/Prm0rGBAmpqVtSQCWUIvbFsAJJw9KvySwmSDwlx/M9zHh8deaUCzkFiytSEZ0TdNhWha/Bk1amjfAffMbe1GburaBHEfw5Dg/aRSxLOoSVphvxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306070; c=relaxed/simple;
	bh=q0OkuA0NK7HLo5PXGKkp08gcjikyPtmDwGS1vllW7e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgpbt0itpGO9twhGR+1ufP/KZALqHlExrsHYklOtz1yrO5Vp1T+BD5jfWTR8oN3/0DeTDVzdrcb2dYMo4TFUvpQhAsbzQpKEW7fITwmNXkpQ4QYlDoAm81N76beXTr5JOzCt6qpcZWAb+joDinfxWP73jgOxHnCOpmJ4r80YT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ+mG5oW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445824dc27so26117895ad.3
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306068; x=1758910868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZQ5TAtVA2wqs2y4l5KGdKWRj04tq3DInsgDkddzZKc=;
        b=PZ+mG5oW6zb/wrkk74dSMci6TtSPnq7EmRU2gj92/pCszLn5/pDXw3sZEbHnxSiYnz
         hX286MlA0PeZWo2V/OabE+To4VgNKj/O8lONxxQ7Rx1yb8VwEhjMTcelZ2oM/AxvH0Y9
         Tb2pfoAyMwSE5BHmb5X3ssqGgw0YI5v5ZYxs+2fn9clLooRlFNOFLMuqaFC90rJXb5fQ
         2ZDaRcFQ+5F0IDY6Q+r6S8zRzdgM8NlAPME/3R4iIMjkh9pAF0BPxJuerHMZX2GF142o
         N2dIVtiFFOr+IYEXiCnS3KrGlKqFXgtUU+FGPtaHDVywN+Npj8+s+sCKhJg392eN9APm
         qxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306068; x=1758910868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZQ5TAtVA2wqs2y4l5KGdKWRj04tq3DInsgDkddzZKc=;
        b=MPB3gKfeu+DQs6hIqIm6xwAjm0A1KMJHBuw76kHou6N8h50bz2c6OBk9+j0izL5emD
         TJNNDLSBUEgIXroi6eBdoYa0j6lB+812fKKVJ18oHAo5L/Ex36kO/+lo1T8tcnwTw3Ek
         TTcP/dnqffQWgvTd6RQy92GPIMYwPdDFg+GbALmvWq8QdHmJgciZIhcNpeadiqDsIcox
         6UKiTuNpw0JZfAy/hksQD05o9+UVzF9V/EEJUyMBPpa3F/3YGsm9x6uIkYH7thOA6AXh
         CPMX4L+gt3ryCLW8J3NopvquqXiM/k1c6+f//+EE3k9MZxvC1W/1BlJewbl4pN0CWt76
         QbCg==
X-Gm-Message-State: AOJu0Ywk+F7rLrWIO8XADyLEp55eR9CWYdAPQ4B+k2B0GuWTImwSH+qC
	R+UtrLEfI8DM/Y+iJ7rOS0wKdcLRcGgWeoSNJQhXfN0QkcP1G5Hwnw1mvmtbYg==
X-Gm-Gg: ASbGncvzL2N1MXjWN/S8VC+AEal6rOSChsg/xeoUWsiuo6skJZmUoGmaWzHAVeRhfDE
	wfSSL7TBY5j+h40Y0YrNNkBV6zLNGtX+4pwYrtPs4wbvNZTKZIiKc5Y4BkSNvuksOfl9KBWmbNM
	nuQR/B172aYOnrfvuJWT7IxBTVhLsQ8RRAMuFIbf8k5TJDaaDcbozIHt6I/eMk5wYgr3UOcfoqB
	5rTGnIoMO/W4uVE1DfeDZR998Bvof/MAhPLSIX8GRvpq/zFBb2xkBY7YNOxt2ihNSqCY5ROibMf
	KEoqYTL+deg+9XrMatiI+wNX4E41Qq7i4hiTCvJsAL2QIB71RcSh2dOgfXW7Uh7cUfeG5f1n0Hb
	8UGmpxGyqeijrMA==
X-Google-Smtp-Source: AGHT+IE5k7pWtq0k1XttvbcOD90GYuN2kjs0Zdi3qjbwEVjI7JT9Ecdd9fpwJaJId5NIMsMQMdh5Jg==
X-Received: by 2002:a17:902:ea11:b0:260:3c5d:9c2 with SMTP id d9443c01a7336-269ba53e4d5mr58708725ad.48.1758306067698;
        Fri, 19 Sep 2025 11:21:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607eac4esm6063539a91.21.2025.09.19.11.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:21:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 6/7] selftests/bpf: Test bpf_xdp_pull_data
Date: Fri, 19 Sep 2025 11:20:59 -0700
Message-ID: <20250919182100.1925352-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919182100.1925352-1-ameryhung@gmail.com>
References: <20250919182100.1925352-1-ameryhung@gmail.com>
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
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 169 ++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |  36 ++++
 2 files changed, 205 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
new file mode 100644
index 000000000000..ca514fa3761c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <bpf/btf.h>
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "test_xdp_pull_data.skel.h"
+
+#define PULL_MAX	(1 << 31)
+#define PULL_PLUS_ONE	(1 << 30)
+
+#define XDP_PACKET_HEADROOM 256
+
+int xdpf_sz, sinfo_sz, page_sz;
+
+static bool find_xdp_sizes(void)
+{
+	struct btf *btf = NULL;
+	bool ret = false;
+	int id;
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return false;
+
+	id = btf__find_by_name_kind(btf, "xdp_frame", BTF_KIND_STRUCT);
+	if (!ASSERT_GT(id, 0, "btf__find_by_name_kind"))
+		goto out;
+
+	xdpf_sz = btf__resolve_size(btf, id);
+
+	id = btf__find_by_name_kind(btf, "skb_shared_info", BTF_KIND_STRUCT);
+	if (!ASSERT_GT(id, 0, "btf__find_by_name_kind"))
+		goto out;
+
+	sinfo_sz = btf__resolve_size(btf, id);
+	ret = true;
+out:
+	btf__free(btf);
+	return ret;
+}
+
+/* xdp_pull_data_prog will directly read a marker 0xbb stored at buf[1024]
+ * so caller expecting XDP_PASS should always pass pull_len no less than 1024
+ */
+static void run_test(struct test_xdp_pull_data *skel, int retval,
+		     int buff_len, int meta_len, int data_len, int pull_len)
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
+		int headroom = XDP_PACKET_HEADROOM - meta_len - xdpf_sz;
+		int tailroom = page_sz - XDP_PACKET_HEADROOM -
+			       data_len - sinfo_sz;
+
+		pull_len = !!(pull_len & PULL_PLUS_ONE);
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
+	struct test_xdp_pull_data *skel;
+	u32 max_meta_len, max_data_len;
+
+	skel = test_xdp_pull_data__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load"))
+		return;
+
+	page_sz = sysconf(_SC_PAGE_SIZE);
+
+	if (!find_xdp_sizes())
+		goto out;
+
+	max_meta_len = XDP_PACKET_HEADROOM - xdpf_sz;
+	max_data_len = page_sz - XDP_PACKET_HEADROOM - sinfo_sz;
+
+	/* linear xdp pkt, pull 0 byte */
+	run_test(skel, XDP_PASS, 2048, 0, 2048, 2048);
+
+	/* multi-buf pkt, pull results in linear xdp pkt */
+	run_test(skel, XDP_PASS, 2048, 0, 1024, 2048);
+
+	/* multi-buf pkt, pull 1 byte to linear data area */
+	run_test(skel, XDP_PASS, 9000, 0, 1024, 1025);
+
+	/* multi-buf pkt, pull 0 byte to linear data area */
+	run_test(skel, XDP_PASS, 9000, 0, 1025, 1025);
+
+	/* multi-buf pkt, empty linear data area, pull requires memmove */
+	run_test(skel, XDP_PASS, 9000, 0, 0, PULL_MAX);
+
+	/* multi-buf pkt, no headroom */
+	run_test(skel, XDP_PASS, 9000, max_meta_len, 1024, PULL_MAX);
+
+	/* multi-buf pkt, no tailroom, pull requires memmove */
+	run_test(skel, XDP_PASS, 9000, 0, max_data_len, PULL_MAX);
+
+	/* Test cases with invalid pull length */
+
+	/* linear xdp pkt, pull more than total data len */
+	run_test(skel, XDP_DROP, 2048, 0, 2048, 2049);
+
+	/* multi-buf pkt with no space left in linear data area */
+	run_test(skel, XDP_DROP, 9000, max_meta_len, max_data_len,
+		 PULL_MAX | PULL_PLUS_ONE);
+
+	/* multi-buf pkt, empty linear data area */
+	run_test(skel, XDP_DROP, 9000, 0, 0, PULL_MAX | PULL_PLUS_ONE);
+
+	/* multi-buf pkt, no headroom */
+	run_test(skel, XDP_DROP, 9000, max_meta_len, 1024,
+		 PULL_MAX | PULL_PLUS_ONE);
+
+	/* multi-buf pkt, no tailroom */
+	run_test(skel, XDP_DROP, 9000, 0, max_data_len,
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
index 000000000000..cffb1a342f6a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+int data_len;
+int pull_len;
+
+#define XDP_PACKET_HEADROOM 256
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


