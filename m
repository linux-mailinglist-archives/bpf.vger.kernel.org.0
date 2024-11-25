Return-Path: <bpf+bounces-45577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8DD9D8942
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 16:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122A42897D4
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1321B3934;
	Mon, 25 Nov 2024 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsxq9QFE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815312C181
	for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548389; cv=none; b=WN4CMXg5P+unBBJ84daQ6Wu2aEAoTsgpa4APy0/fM0Ay8Do468yCgNdRBOiJMUGPI234z8nMifL4+x1WtV3C1r87VC4oUYB3fxgPfQooc0LNanqpwsUTSXvGsGG//vz0wo+u6uw7Z/CUz+Z1bvnoksd35V0k0BniigpZWKWuFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548389; c=relaxed/simple;
	bh=3sH+3ptQHoXjGk1keUOvvaY7MkN6lVoC+JU6/fR8J6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KszLExao1NJW1q3M9l2se3BnQTxmKZmR8RUKiuSfk+XtU7nI7pcHPshTwqOLddOyhaZ+Rmk051Ju9cOlS2z9fosuNlTpn226zf43D2JzliCJwyONdOFNOAf8MX2JTjZLu3v/kwkhTMwd5AdVCT1LgAgOvP6GAJhCQoYiZFS9P0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wsxq9QFE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a099ba95so7364005e9.0
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 07:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732548386; x=1733153186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbN3KskAwtvqVJsecgNtoKg0lykGif0Gt79JX9EOBJI=;
        b=Wsxq9QFEdJpFmxSWjd7N1B91qITHBzrYyOZcud+s2cuzYuwmq3L4wf4T5ou2R887aW
         cwg3fEpIrwqscP4B9cGPPPIRioSs9lN7m//JsKzyQ+OPGtbXR5GVK7cLx5St50Bvx71K
         t7LAxTu5W+jSNgHt8ZZ5bsO+YznmKNTF++2DwCEeGSABcVIGl2mqZS9fLTmyXFZupzwg
         fhyn6bRjUTf8Nj3Is6tFd9jFtyTgKQAoJb/ryez3tVRA/fdVjcfSxfegc8PUqnyaXnqc
         q3Z01GlsOL7UPZZAZjnqd7FGFXY+/UCnencRNg/583n+1yKV+PzjjFj1VMiIjSPp2Fp8
         AUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732548386; x=1733153186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbN3KskAwtvqVJsecgNtoKg0lykGif0Gt79JX9EOBJI=;
        b=t90DCMTeBKv4J72gZIGOJ4d2XQNNXwMCMoiAQczPzaLhAifgh1zSiT66LbWcs3/icI
         u06J/eMM1cV7Xz954AFtKshpsn1emsvsPGITIn9eF7vysRsp4ea8VqBB4foqoXPH+6RN
         nYD/Uibx8rj57GHBYnfCAxnHEizGqfB/0bcec2lTotAOWwHyrFolEU12Wr55uKuJfklB
         mWj9Z468QEmr87ieDMVcbz2LCN76qZ7t/Ft5f7zt/Bd2kexB7vosmSd5k3pXiDkOFkA2
         Wrfz/kEQAVMR+x6T3xgbIGwCqCSWzRuDFX+IKhXR/d3vo3dONcI617It1byYRPVdrvEV
         QO2w==
X-Gm-Message-State: AOJu0YybqAzgeZE2qzq+bySdacn5P5my0vf6MM09YnJpwcU+p41LEXk7
	TZfgB+IcUCB2sxs1xK/kYp4egTg+woHaP2nBTqaQbbfC++/POxNhtVIR/qmKmlZIbTAe
X-Gm-Gg: ASbGnctljS3cTM6cKbfu4Q9ppGcWOqv/wF02WTJDHFlqx3LItI4Lly8IjrJP1GfAQul
	erBhfvJwhsgfBVLt8k8bP2rsZbvo/Umsf61KmyaoQKyJDbEJWD7+61GZgDTHwhme1GMiS9np2Ot
	qOosIlS79+OH0pF1VyE7DHKc8gtNRcLvgr1US5RXF+i0IZ/me1fxdfbcx60cf7bVpVG/vIuCcRz
	zsW0FJIAd+hjNF0T0fdYcHwjPreGExq+t1SbNDrRUqipejrmpw4gzkYMl8j++TyhyMF2cE6lWqv
	C1PY4stXE7eNAskFCZGTVcTMrlhLV0FJyLUEVoNEOG7ZTsSkfWFEPRe80GgrMA==
X-Google-Smtp-Source: AGHT+IHAQIObVvJ7wySizeTh1KM53wCcCXil8XAqLhsBzkByItuj7DS+UVbUwT7qUHD+K5WvsP4nVg==
X-Received: by 2002:a05:600c:1d28:b0:431:5df7:b337 with SMTP id 5b1f17b1804b1-433ce41c804mr112500865e9.8.1732548385629;
        Mon, 25 Nov 2024 07:26:25 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal (36.24.240.35.bc.googleusercontent.com. [35.240.24.36])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-433b45d4dd6sm202793815e9.24.2024.11.25.07.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:26:25 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	song@kernel.org,
	ast@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add cgroup skb direct packet access test
Date: Mon, 25 Nov 2024 15:26:03 +0000
Message-Id: <20241125152603.375898-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125152603.375898-1-mahe.tardy@gmail.com>
References: <20241125152603.375898-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This verifies that programs of BPF_PROG_TYPE_CGROUP_SKB can access
skb->data_end with direct packet access when being run with
BPF_PROG_TEST_RUN.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../cgroup_skb_direct_packet_access.c         | 28 +++++++++++++++++++
 .../progs/cgroup_skb_direct_packet_access.c   | 15 ++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_skb_direct_packet_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_skb_direct_packet_access.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_skb_direct_packet_access.c b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_direct_packet_access.c
new file mode 100644
index 000000000000..e1a90c10db8c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_direct_packet_access.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "cgroup_skb_direct_packet_access.skel.h"
+
+void test_cgroup_skb_prog_run_direct_packet_access(void)
+{
+	int err;
+	struct cgroup_skb_direct_packet_access *skel;
+	char test_skb[64] = {};
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = test_skb,
+		.data_size_in = sizeof(test_skb),
+	);
+
+	skel = cgroup_skb_direct_packet_access__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "cgroup_skb_direct_packet_access__open_and_load"))
+		return;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.direct_packet_access), &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts err");
+	ASSERT_EQ(topts.retval, 1, "retval");
+
+	ASSERT_NEQ(skel->bss->data_end, 0, "data_end");
+
+	cgroup_skb_direct_packet_access__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_skb_direct_packet_access.c b/tools/testing/selftests/bpf/progs/cgroup_skb_direct_packet_access.c
new file mode 100644
index 000000000000..e32b07d802bb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_skb_direct_packet_access.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+__u32 data_end;
+
+SEC("cgroup_skb/ingress")
+int direct_packet_access(struct __sk_buff *skb)
+{
+	data_end = skb->data_end;
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
--
2.34.1


