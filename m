Return-Path: <bpf+bounces-67595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4001CB46045
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7237AA7D0
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 17:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5F237C0FE;
	Fri,  5 Sep 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2wBaBgg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B137428F;
	Fri,  5 Sep 2025 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093641; cv=none; b=lBm2iQCx52YUZ1I25/LNQMWkDmySVNPrdcAg3KAVwm8EroxYC8RHe4y2YI+qGv+C0OlO7U3LgFn593/EgtOH8H0vns7ZRQ6x7ofFSBmBAHWj9tNcY+zSNR527WY+3E8x3yKUW1VBxtcOEhXUxl6DOL9pYRAOCI59Fa84ofkt4B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093641; c=relaxed/simple;
	bh=l7njCxZ794uRHDedQj1rjSftn1flRBVKIqFnWt1dbyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTV0dvTUGCX869B+Vak4HvZIVyMKdkF1qy8ahaAxqqW8UTQWEuxTFZsn7HMssQwmc2+Qlkhlt4cOuDQltYVIE+f4KSUvXjkPRxyp3VdKDBfM+UKkdCqLOkwlUSZcGzBQ83+f5Ii9xzh0C6VllkWrtZN1es8aySlU13nKp53IsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2wBaBgg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-244580523a0so24884625ad.1;
        Fri, 05 Sep 2025 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757093639; x=1757698439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqQPrQxT6COeqBCMhnrvZjJV8ChtzM9wFU6243JMP3E=;
        b=a2wBaBggtDtl2MmniZKoVLc+kXkJFSEMTBQGi5pKqS7vnTV07RYmgk6ejrtaPvudxW
         eSJvc1Dn4qk/hQfO2O+Wy1zYYFgkxOWQYeQU9WpR9Uxi3ziwGbQgntqOQSWqfJy4423A
         cz2HE7627alhGHe0yu3tmzUIXzzOVukU5GjOyOOoPW2buAgYECE5xf/dd8184+W0kuxk
         m3joLP26wO4nuqm5QVWYEaIbP/uB9JbmXKb9Y46UdjiygcfPaPmd4yQnNCIuTjCxWfKC
         dQQjQ/FdWC2TgCFSQd/ogrRfvf4yoO6Zn1bqw6nIeXaVH+/6EwE0C9/egGL4S8NSUhQo
         7nUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093639; x=1757698439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqQPrQxT6COeqBCMhnrvZjJV8ChtzM9wFU6243JMP3E=;
        b=wOd7Jjr57erKOqpHyc9PCPmPJ82nVAqCEXwcu4DvKlTZKy19dlFt52MwoWNAmcpC5C
         KEtmRqm8eFURVhs5N7ttBJDUm0E3av80REgCx3BZouGHzyBHe0IKyoedpPkr7+talYmk
         QLXQAGZx7zKsoNyXjzvnObmw3LeQl2hIokTPLWGpks/oYTXB6SS2dh04qnZTIj2bj7M8
         LXrX9CWSA8HFsjH063z/PjKOxTPOqvlNoMKHKII5vC1O3JjGdaecOlZfsgTCRa/mXhRW
         Syo/ERhYwFGqZgd1URP7Av/4anlJUcNQ5iOoccho33e5KV5bfQu8BXSElGeM/XADzKvD
         IFAg==
X-Gm-Message-State: AOJu0Yw8ftmHSvwmCOvZ5hSqm/vZFH97+Ebud3J5jhikWkA79WFkW0ME
	mlNdT54epF+0xSVXcwVyAHHOd9C5WrXFfKiFDGw21blrXUkl1no8VKzzTofbDQ==
X-Gm-Gg: ASbGnctq1DPvG0ZJ50xCCgAOBXR91BljU+RhYE3XeASg+JDjkZRVG/rgX0THKirZ5pw
	rHwYs2PXLB7FGtpWAEl45lviWeuP7D97ICZF0SQ0gd4rkFlpv4DqmJu90A9fckX8s2jjzToNqBR
	eA/6SysCdlCIYreMkum9q3CR0hhsokOuYOyxi9lLuONfOlPRzt6xxdaJmBJZXnUOPIIz24IYoDb
	ecer020YaGGqw2tc8NsbOvJqWj4J4vJ0egf9itSVMd5ATvTKWdZRjsAERWvlxcNxAxjiB+s324W
	DornOL28P6gNRtx94w7su7faOW7iFhDSjsPCsO+vV9QbY9RdLLfVgbTVCDsdfh0syhjmkxH4TE4
	HYUaVJaJp6GFuzuZKB/7AH2pU2xZP9lr1EX0=
X-Google-Smtp-Source: AGHT+IH5Xk9v2o7jxEwbZYBGE2c4l2oXrpG+PNEoRCmi/WS9WW6P/JLIRBFCuHQQq+VuKyOgNXj+fw==
X-Received: by 2002:a17:903:2ac4:b0:24a:d213:9e74 with SMTP id d9443c01a7336-24ad213a1aemr285354435ad.49.1757093639465;
        Fri, 05 Sep 2025 10:33:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4e7989b53dsm16510430a12.29.2025.09.05.10.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:33:59 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v2 6/7] selftests/bpf: Test bpf_xdp_pull_data
Date: Fri,  5 Sep 2025 10:33:50 -0700
Message-ID: <20250905173352.3759457-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905173352.3759457-1-ameryhung@gmail.com>
References: <20250905173352.3759457-1-ameryhung@gmail.com>
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


