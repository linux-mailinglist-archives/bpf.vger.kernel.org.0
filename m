Return-Path: <bpf+bounces-68724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A005B8235B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 00:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2F07BA782
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 22:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB74313D43;
	Wed, 17 Sep 2025 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ8DnD7E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5E313271
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149724; cv=none; b=j/uMGb546ljN5UPjVxjO0kCtNpcx7ByEqAHCRTL35NJoOASRH9uw+kNFYeqUs+leWDzK8D4SIOo6N1UFBCoidTFvsAAFOojhR22ax/khJi1gK/TET/AEQXeFvkR49oreo0oAJPrw5kVpQfm4psuOzSxNitChWQA8xxPqzidpieQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149724; c=relaxed/simple;
	bh=ebEe9IkyQgkamx37VBlEmeJSVSG9SRHubSWbTb9SAwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VT6tVx4om1Q1q8X6G0lIFZi6mIiOHn5ZlFVDjA/mVTtbxn3v2ohsldYvKc3zPvMtn2AP+MlRfd0cs/zRWNqXX9p0TZffRjrhFE47pa16FIwdNmTvWLWvgVQsscuNTkNF1uK/tzO12WA6rk8M0cBBWFuYWVh1iDAm9EpvdGa6kK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ8DnD7E; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77251d7cca6so388604b3a.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758149720; x=1758754520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAxzi5B6cBNAyJn1tXCxSzkoEcVVhnXO76uSYmveprE=;
        b=HZ8DnD7EVc45xC7ATf1FosBBcHlSrFTeFVSY/MuhCFlGh/+RADU4C5wNGUAQroQ6DC
         LIF+2xpH30LPA/HiW5XjP2YEPdZxuXELhVCAL26wTtyq5diZJgpWzdwvMWM/bNr38ans
         p3Buw5zgXjnPyoXYhTms9CNQuqwKXfcvY1Vr/5d4XWSYns4LS6oVNZyHPUe2iMFxzs3t
         3Wt5KbNjiXG+MT1MaT91RR/5ray41c95X3jFjT9IH73hna3bzjeAEvNiq92AHiR1T5b5
         z6oW5lN/5NfMYZHxMx60tRLo87TWj1OovcdEJIlRny7ofKUYuW1OCOp0HvsUHc1OFgV/
         sqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758149720; x=1758754520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAxzi5B6cBNAyJn1tXCxSzkoEcVVhnXO76uSYmveprE=;
        b=auLaIaQpBBoA7x5RSVwLkheUKIe4zbzT0WniXAqCvelSRThPOXkLJb/ikqKugNdJ+U
         7D3onXNPFFb0GE0OpobpB27bXA1vYXzrRO7BXp5wD5hdIo+aFdaHzWD1aQoozHFXJfGh
         nXpKnrcOwmY3Ymh90nDdhHuK2PykFAFs1WbbqH/7xcnkp6EMQyx2RnwYurJ4bbblj+g7
         GbPYgxoP1unRMGBgi2oNF5iGniPOhEMpv+o30S3EDJVB6/S6ZlUFFmRdy6MdmWQRFsbc
         oBRLl668Os1EWIFTuHfit62i5oGwxE2WMkAL9V84zo6xZwXL0lHtL7gkEcyFWJHzzTyD
         najw==
X-Gm-Message-State: AOJu0YyDVrNiKXXYiVU+9mkD2muXIyJc38st2v2P/RVegdm72h//pJx2
	ER6KF2ZdBM3nXT6/AZTW+Nc/KGmV3nOGOdGpPcUO1ZmGrBCpIq+zIh2KojKC1g==
X-Gm-Gg: ASbGncsKghItLuejOCYHNpBxWl3M6ibmRRXEnuYHHcSyEyZGjz77E4rhzsDcA/76Bt3
	fhIFrt/ySbXneepjbvYRgcyaUojlPkzKP3N1XfO2OvEGuOT1nc+EXak1HvF2MpJNBdbvpJJK66/
	y3vQRihvT+zS4CKKSezUiOLShJfX+yVmhE/53e7gOQJXWn+Ty0sHzK+5DI3tO5YsXTcfZiNnGBQ
	vonvtqw0BE+Ur1fb81US+YnEw9jWnBfHmARollg1qve6iphm9lUWPrRujkAKybVFoS3kcFWLSrA
	DPIDfp3JDkJdQIazdhnrr2BuCDWcabVVkqEcXaAYGXzoQNuuyFDHVgqQejw/z/ej0dCsloxj9uX
	PGi515G7kTRSFFcPGRGSZcvgXgo8d60vZ
X-Google-Smtp-Source: AGHT+IFhAX57mtlI6Qb0COvLGqAT7KFCCcaEWfPcYP/pCDZm8t40kZlXcygtHOJGBxlQh8BKjQc6tw==
X-Received: by 2002:a05:6a00:3d0f:b0:776:277f:f687 with SMTP id d2e1a72fcca58-77bf8c76f22mr5072938b3a.15.1758149719611;
        Wed, 17 Sep 2025 15:55:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb7c127sm458672b3a.21.2025.09.17.15.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:55:19 -0700 (PDT)
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
Date: Wed, 17 Sep 2025 15:55:12 -0700
Message-ID: <20250917225513.3388199-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917225513.3388199-1-ameryhung@gmail.com>
References: <20250917225513.3388199-1-ameryhung@gmail.com>
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


