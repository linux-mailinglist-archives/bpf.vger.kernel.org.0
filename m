Return-Path: <bpf+bounces-66443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F48B34B08
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F4717BD83
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC62882DB;
	Mon, 25 Aug 2025 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB1tIzUJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D22857C7;
	Mon, 25 Aug 2025 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150769; cv=none; b=BhygUs1wjEchlk4X59lXwfxWHUeeFgwEbNWeO7FNB0CFDWPDmya2IxGChi/yl1sG6B9szRKATe134Yi7MqYaYxvwfzmYb9bvUcu6/G3Sj2QSjiq9kIdDRFOb/0GH4dmRM9BuheofyeUR5L1XDtrggFS9sKyOIRx+/kO6qFZYLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150769; c=relaxed/simple;
	bh=l7njCxZ794uRHDedQj1rjSftn1flRBVKIqFnWt1dbyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcexKrokP9yUhdeV2/ccexUhKHzq9NFUBJGoGdqfjqwrdq8v8jQUYdGS45vE/iC3pfVWSkwD8E2CZtSXqY+z8jnsAmfRajWKYzSFgW3+HSq9C0xqT4rb6AJu24DacMKEKE7zs6gTKRTUc9xWQZ64qDdcZ6dBTH4N08peV3LhfqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB1tIzUJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b47174c3b3fso2871269a12.2;
        Mon, 25 Aug 2025 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756150767; x=1756755567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqQPrQxT6COeqBCMhnrvZjJV8ChtzM9wFU6243JMP3E=;
        b=MB1tIzUJtt0VXr3KX14f5gFOEHnVsmzZOuk28MckCWCsPY8xVA9qb+yiInnuMSuu2H
         XqGlsfiyS+80/t2ki095l0rDF8Jn5fnn19/cM1eosjORtnH72mw/Q79zjjAdTknIiPcl
         vyQM3pr9mlAGpnIVZ0C5U41sU9EzlsG8zZ3TnlO710BktVnIwZCibT34GCziNqQt7sQb
         2Qa1OTcvMir16uG3pnehUS/1Q6cHmhyFp2l5eIhHDuPK1CxoL1VpJrN5Ut+5qb15PsaD
         cJ7rLRus+HJKUi/y4C0bQMLgBdai/7INqx0I5bmdfEUZd7LV57txbnJ+fijvqGbH7RI9
         TpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150767; x=1756755567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqQPrQxT6COeqBCMhnrvZjJV8ChtzM9wFU6243JMP3E=;
        b=iKXqDmTm71ZbbepkCdf05Eu5h1u9V5yi8YDWQNZAuuJmYX6U3Ecuqn9NJk5xlYSViL
         jLbVMv2fg2evBBBv4kDFa7b4GN1UwIjno18NoNZJX3NoAtyHz9LGip3mW04yhWG8QDs0
         annFG5PVjYbdjnVLC0YRRFt4VEw/KfzpCEUf1dIp/+C9g/nlmgvSGGlumw+O/p/0CCpA
         Yc6U5qOlwlBh10KX4hsz5EWODAAA5Yw622UMC27RHhQRx9+wewxLss0U8sXT4h2KjX1Q
         22NLMhQt0RFULqwck1O3bYuSBau7UGpmCEAKUs0zJd1NCEnOD2BrZLPMNgudCxMWXH5g
         YObw==
X-Gm-Message-State: AOJu0YzvkT0ZO5FP6Sa51LNHtBik6ovdlVI2DcJiC8a8MP5t1aHhUV/W
	b3riDoqedl+cvCMflkq8k4eT/Lt1184AvuFWbu+Mo4ig8qenSBqGEcRu9F1L9A==
X-Gm-Gg: ASbGncvSSWs7C5yZkA6dVbrImXziuqMQthplWF7sXYO3OqKS7mFBV/RJUhS4cGjInCZ
	rW7Yuq3Huo2BV3EwfE4/3czUeAdbJuUU320z1/qcJ1gy2EQPPyiTicWz7OJVMmvT4X7Rm8T8KkC
	oQFDHoxeuHKqRXgjnFGYR1aIYbSifmD+LSpAypWJLZnTJoPltq3Risws6nVWZ0CxvS3BVE6mMev
	hca8IIOrIVpFYKuC1KZUObWtuoOmTvo39zmOdu6IvOFuh6/hTJJ+5beMzBvUT+uZl3qX+4ffYEd
	Oyky89qw4UaNqSYun6n8+T8QDFTp/9jkzGage+Zlo1nwWSG5Ou1nmrxrHz5DVsGl8m4RUkPPw3b
	SE5Kjcw9CFm92lg==
X-Google-Smtp-Source: AGHT+IGv/HJlVPMdu0trx1ENIH8qlEjPstxmcLMrdvqLoP40xX98AmVx18N/bAfq8x9MYc2gSNGaAg==
X-Received: by 2002:a17:90b:1d06:b0:324:e03a:662e with SMTP id 98e67ed59e1d1-32515eaeeecmr18011861a91.23.1756150767272;
        Mon, 25 Aug 2025 12:39:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254ae76be9sm7785229a91.3.2025.08.25.12.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:39:26 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [RFC bpf-next v1 6/7] selftests/bpf: Test bpf_xdp_pull_data
Date: Mon, 25 Aug 2025 12:39:17 -0700
Message-ID: <20250825193918.3445531-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825193918.3445531-1-ameryhung@gmail.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
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
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 96 +++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  | 36 +++++++
 2 files changed, 132 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
new file mode 100644
index 000000000000..2cd18e15d47e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "test_xdp_pull_data.skel.h"
+
+/* xdp_pull_data_prog will directly read a marker 0xbb stored at buf[1024]
+ * so caller expecting XDP_PASS should always pass pull_len no less than 1024
+ */
+void test_xdp_pull_data_common(struct test_xdp_pull_data *skel,
+			       int buf_len, int linear_len,
+			       int pull_len, int retval)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct xdp_md ctx = {};
+	int prog_fd, err;
+	__u8 *buf;
+
+	buf = calloc(buf_len, sizeof(__u8));
+	if (!ASSERT_OK_PTR(buf, "calloc buf"))
+		return;
+
+	buf[1023] = 0xaa;
+	buf[1024] = 0xbb;
+	buf[1025] = 0xcc;
+
+	topts.data_in = buf;
+	topts.data_out = buf;
+	topts.data_size_in = buf_len;
+	topts.data_size_out = buf_len;
+	ctx.data_end = linear_len;
+	topts.ctx_in = &ctx;
+	topts.ctx_out = &ctx;
+	topts.ctx_size_in = sizeof(ctx);
+	topts.ctx_size_out = sizeof(ctx);
+
+	skel->bss->linear_len = linear_len;
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
+	ASSERT_EQ(ctx.data_end, pull_len, "linear data size");
+	ASSERT_EQ(topts.data_size_out, buf_len, "linear + non-linear data size");
+	/* Make sure data around xdp->data_end was not messed up by
+	 * bpf_xdp_pull_data()
+	 */
+	ASSERT_EQ(buf[1023], 0xaa, "buf[1023]");
+	ASSERT_EQ(buf[1024], 0xbb, "buf[1024]");
+	ASSERT_EQ(buf[1025], 0xcc, "buf[1025]");
+out:
+	free(buf);
+}
+
+static void test_xdp_pull_data_basic(void)
+{
+	struct test_xdp_pull_data *skel;
+	u32 page_size;
+
+	skel = test_xdp_pull_data__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load"))
+		return;
+
+	page_size = sysconf(_SC_PAGE_SIZE);
+
+	/* linear xdp pkt, pull 0 byte */
+	test_xdp_pull_data_common(skel, 2048, 2048, 2048, XDP_PASS);
+	/* multi-buf pkt, pull results in linear xdp pkt */
+	test_xdp_pull_data_common(skel, 2048, 1024, 2048, XDP_PASS);
+	/* multi-buf pkt, pull 1 byte to linear data area */
+	test_xdp_pull_data_common(skel, 9000, 1024, 1025, XDP_PASS);
+	/* multi-buf pkt, pull 0 byte to linear data area */
+	test_xdp_pull_data_common(skel, 9000, 1025, 1025, XDP_PASS);
+
+	/* linear xdp pkt, pull more than total data len */
+	test_xdp_pull_data_common(skel, 2048, 2048, 2049, XDP_DROP);
+	/* multi-buf pkt with no space left in linear data area.
+	 * Since ctx.data_end (4096) > max_data_sz, bpf_prog_test_run_xdp()
+	 * will fill the whole linear data area and put the reset into a
+	 * fragment.
+	 */
+	test_xdp_pull_data_common(skel, page_size, page_size, page_size, XDP_DROP);
+
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
index 000000000000..f32e6b4a79f5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include  "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+int _version SEC("version") = 1;
+
+int linear_len;
+int pull_len;
+
+SEC("xdp.frags")
+int xdp_pull_data_prog(struct xdp_md *xdp)
+{
+	__u8 *data_end = (void *)(long)xdp->data_end;
+	__u8 *data = (void *)(long)xdp->data;
+	__u8 *val_p;
+	int err;
+
+	if (linear_len != data_end - data)
+		return XDP_DROP;
+
+	err = bpf_xdp_pull_data(xdp, pull_len, 0);
+	if (err)
+		return XDP_DROP;
+
+	val_p = (void *)(long)xdp->data + 1024;
+	if (val_p + 1 > (void *)(long)xdp->data_end)
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


