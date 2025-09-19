Return-Path: <bpf+bounces-69014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAB2B8B9CA
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E688587176
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4394E2DA742;
	Fri, 19 Sep 2025 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuiiWzQE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294842D63E5
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323401; cv=none; b=KkYu1J+DOIOLK3syKYASr99OtVfqIuVBOlBkr37W8BVCgoEODJD3+HXsW16hkTxBhdeOkG6CQuKkntd4mja45UtBFBUASgPkYawN07qUhi/az2eIK6O894T45GHZVgT2LyykWjqEyAOK34fDJrEO5Q2zOIG2ZvDInm9kHlY0u+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323401; c=relaxed/simple;
	bh=kwAywgZZXlFEE6VLb53SbonSehmNLPExBPyymgSmF2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rU/W5l5evVFpzto5ktcQlkkTk5Ss4rsGqROmYkDxU49LiCRaP4C2R2q31zna9CcBBE0zUa2KTe3M4udEiaWgCLuByUkkcORMjr6wX0MzgLN18wa4rdEV/lhG1YrdnlxlkvvVxALeIL9LWJwfOnViWXvLjNv39duMwj/Uy5LTL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuiiWzQE; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso2467502a12.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323399; x=1758928199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0ChTZiNMIHSXN+Uuu12gg+HEluJOhI7OxRxzzdMs6o=;
        b=FuiiWzQEr4500SY/zFSyghej2nd3gLDvWA41FScT92uN7iWr8LdwcfEa2l32lHBP1p
         mRtyHTphp8OAsDQTIGqy9LJmvDcDYHvPVvonP+29jzot1MxNLYiMc4ThHO12rhBRE9t/
         OudGX5qetyLVPGeI8h7+E5sJNHwP5HM7vH+ixJBYnIESippml+FJh2QeXADgFIdJz5HU
         +l7M0AGNduKQjZuu8VSb6zPVgKIAqUVuPviz1Xawa3sd8UwwyNGQgvcto096W4QJXsFx
         11MX8woy+vKI0SXx6AeOh0ExBEsoiCFzVnv31pl1kpyx9iItKsFXHomHxi1sOLtn5iu1
         8goA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323399; x=1758928199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0ChTZiNMIHSXN+Uuu12gg+HEluJOhI7OxRxzzdMs6o=;
        b=T+pkB8tC01Tko/ylowbDbTsOEvzuyQb8XFCy2FLloGYhYOAYj6lGpsUN6J3QjPENUQ
         3tZ/6QJ0gkOSIHn/7sDXut1H/s0EBOkrTKDsDu5rmrk+P4Rh21dp3E09xouX098l/PGy
         thd0syBYitFcEOIlMb4B6D7cScFmH5YuJgNaj+CyaLwpokm7AcM1uAJUv04wxcT6s93R
         7nLDTyOM3Yewm5+XLmTPSVqKaDzObyJWvoRgGgfLVYxKk5/++Qdkbmlru8rcEqF6bWgZ
         WH749uVLYJWmYTdi+gaFKBv+/8rPcj+i6r/E05FP57Tjn067hsm73j/Rq03YjxIz6qP+
         Yedg==
X-Gm-Message-State: AOJu0YxGpZOQOQ3elv42Rmk11Z7OjypEeSfDEP9PMNpPYEgDYRBqlMi2
	IjZtT6zks89l2/8z1EHbhinYhWBYZmT5iVlIEWEeeSPfyGN9xOBa2docKfVTZw==
X-Gm-Gg: ASbGncuIenJySkDRWs9PaiI8eVQ1sSZEP8+3wZEu6xRUwj0fxkv+MIBGO6446Ge7USY
	ZLLEbiskDG8kdXSPRvSkzHlxmgudq784jniaUsc4KSWfrYdtFPLR1CUGHYarj3vsxmD5Y/iKKkH
	zAp22MOjcea+d3OvNYN8g1fjz96uv98hSzs5ZkRyBZobb/bKxU8Z4pcenwJZtnreXfkGhwkpacf
	DUxJ6/Xlk4LUHri22arW+FVO3itK/MTgQ5ofxum2Msgk3P6KxcrkGrfUgAt2XfXggmb87DQkkr7
	uhvP0KarRiV6N318g//DfUNt66pJlvnRgeBEKJCviuPTMD681rrrl5dBI81mw3lyJXvW0mBWhT9
	qUZlI68tTLOZROA==
X-Google-Smtp-Source: AGHT+IGs6UWPhG/7w/Kz1dzbdenSoDKoOeQ1xcXgYchw13hP246yrjEfIpkLjzVOQWGjrvvA6j/qMg==
X-Received: by 2002:a17:902:e850:b0:246:bce2:e837 with SMTP id d9443c01a7336-269ba535600mr78753155ad.49.1758323399194;
        Fri, 19 Sep 2025 16:09:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c530sm65447525ad.45.2025.09.19.16.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:09:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 6/7] selftests/bpf: Test bpf_xdp_pull_data
Date: Fri, 19 Sep 2025 16:09:51 -0700
Message-ID: <20250919230952.3628709-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919230952.3628709-1-ameryhung@gmail.com>
References: <20250919230952.3628709-1-ameryhung@gmail.com>
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
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 179 ++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
 2 files changed, 227 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
new file mode 100644
index 000000000000..efa350d04ec5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
@@ -0,0 +1,179 @@
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
+/* Find headroom and tailroom occupied by struct xdp_frame and struct
+ * skb_shared_info so that we can calculate the maximum pull lengths for
+ * test cases. They might not be the real size of the structures due to
+ * cache alignment.
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
+	 * xdp_find_sizes can infer the size of struct skb_shared_info
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
+	/* Test cases with invalid pull length */
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
index 000000000000..c41a21413eaa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
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


