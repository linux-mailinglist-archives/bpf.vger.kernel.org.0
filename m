Return-Path: <bpf+bounces-28125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ECB8B5F6E
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3941F225BB
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BB086244;
	Mon, 29 Apr 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp07FNFo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408F33C7
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409843; cv=none; b=ldaI0jGeGwL91Xx+MntnCT3EnMYoDrqySk7T83/UQcWQGm1PbB8WkfMIOfJdkSOcayJv75GcIF0agndrwDzK42+D9OoEU+S2Wo9ZGcQsC5jWQ4wlRiL50beeLOzcjPcTONQ69hpbUgIQVlKPfVRmHxLEpOkv/GGGZxeVxiauGTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409843; c=relaxed/simple;
	bh=0W9/C1hPgxxlARFFETzIJ2476MZg+pUaNpx7i5oBKAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trQw7M/f9mo5VbxaU4t3CGSa9WNlbVbg8CL4C+s5cwe84iOQc4Cu6QyPLOwgQL5YR7G9/uoOY/cs4Gsh8hcyYRyHkvBvvd3jcRiqlecMlfsGLyh38hTeAI/QVQqrmlq/bxVRai9Qp4WVNeAR8oII5RVcjpQMWnyMgU/iL5Gi90U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp07FNFo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78f05afc8d6so368860185a.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714409841; x=1715014641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hf3sBEjssVoG0X9/iQmT36SkFRO7vV5Eo//ezrteqt4=;
        b=Yp07FNFoGmjUwfQWmeqe7XEYxW87Qzsg1FKr8b/P0xQ5SubbopGejc03rBeyaTxuN4
         CG/8STcTHX4BLGibWrb/4CddOfAVuyU2J1pt0W0ZzO51e1ZwzRtazcP+M0Xy6zPe/AtZ
         xr04fyTf4+80sCs2XRgkF90qygOjBQOX1O8KGmeUMlr4Wfw2G8o5USNOYGDh7ZlTQIoC
         AD1lTok9LPBsVCKj68lqUBeibSDeZC4DxfIOIgukdKqsal5Zbj4RsdOMtROs7PLT1OB9
         lc+z/hzkrfJwYHIam6pMx+KKxfqTXX7GIp9XyVsPSdiLlRocwJvWSul+Xg0QSsZkE/KN
         iEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714409841; x=1715014641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hf3sBEjssVoG0X9/iQmT36SkFRO7vV5Eo//ezrteqt4=;
        b=LwTF9hFp7dL7NQf50sSnPiN661H00z2uZl+eczSKuwjzoPcI3mrG/qD7X2S2WxzIV1
         vUVUAaMUP4cVOHaWvVqN5jLzxdY0RdN78MqfWemVC0RX0STIhXSwiRET7mtxBvs89Iio
         rnmh2u24NA3iBTOLmY3EUW8MjFV+VLTh5v5NlSI33QtTTi//5u8F7mELJIKKeNLm8fxj
         2yBbg4Fm1ZF8okBW4ZCGuQQXLr4GXqRhB77hU8vtOqTVCArRtgCPM3cfgeEUEFCxyA+s
         HJkiOdqGqzhTCIbrOZWtP4f1iivTZ1dDJReghQZCO0epOhSot6D6dEKkemJAmd3cn/Pq
         0Wqw==
X-Gm-Message-State: AOJu0YyFZEYVQb0Bjh6wLzq9uhBU8gzpmEFR3Wj2k5ZO0+VX0jyr+eeE
	J3Pw0bLDP2yy+JuBwE/5TUr+HEyfHpAtDlYloob2EklE5m7ubNs6130teg==
X-Google-Smtp-Source: AGHT+IE+3CAjFbhTBNCM8mB29I8h5oOi4hBoFCHRSb6c0QTIbL0TUiaqHNA9VqQBfHrEVJME0AENbg==
X-Received: by 2002:a05:6214:194c:b0:6a0:d29d:a416 with SMTP id q12-20020a056214194c00b006a0d29da416mr3008066qvk.47.1714409840718;
        Mon, 29 Apr 2024 09:57:20 -0700 (PDT)
Received: from fedora.. ([2607:b400:30:a100:6442:5b0e:54ab:110b])
        by smtp.gmail.com with ESMTPSA id k17-20020a0cc791000000b0069b5672bab8sm3031988qvj.134.2024.04.29.09.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:57:20 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	daniel@iogearbox.net,
	olsajiri@gmail.com,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	rjsu26@vt.edu,
	sairoop@vt.edu,
	Siddharth Chintamaneni <sidchintamaneni@vt.edu>
Subject: [PATCH bpf-next 2/2] Added selftests to check deadlocks in queue and stack map 
Date: Mon, 29 Apr 2024 12:56:58 -0400
Message-ID: <20240429165658.1305969-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429165658.1305969-1-sidchintamaneni@gmail.com>
References: <20240429165658.1305969-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siddharth Chintamaneni <sidchintamaneni@vt.edu>

 Added selftests to check for nested deadlocks in queue
 and stack maps.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
---
 .../prog_tests/test_queue_stack_nested_map.c  | 48 ++++++++++++++
 .../bpf/progs/test_queue_stack_nested_map.c   | 62 +++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c b/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
new file mode 100644
index 000000000000..731e958419eb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "test_queue_stack_nested_map.skel.h"
+
+
+static void test_map_queue_stack_nesting_success(bool is_map_queue)
+{
+	struct test_queue_stack_nested_map *skel;
+	int err;
+	int prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, ropts);
+
+	skel = test_queue_stack_nested_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_queue_stack_nested_map__open_and_load"))
+		goto out;
+
+	err = test_queue_stack_nested_map__attach(skel);
+	if (!ASSERT_OK(err, "test_queue_stack_nested_map__attach"))
+		goto out;
+
+	if (is_map_queue) {
+		prog_fd = bpf_program__fd(skel->progs.test_queue_nesting);
+		err = bpf_prog_test_run_opts(prog_fd, &ropts);
+		ASSERT_OK(err, "test_nested_queue_map_run");
+	} else {
+		prog_fd = bpf_program__fd(skel->progs.test_stack_nesting);
+		err = bpf_prog_test_run_opts(prog_fd, &ropts);
+		ASSERT_OK(err, "test_nested_stack_map_run");
+	}
+
+
+
+out:
+	test_queue_stack_nested_map__destroy(skel);
+}
+
+void test_test_queue_stack_nested_map(void)
+{
+	if (test__start_subtest("map_queue_nesting"))
+		test_map_queue_stack_nesting_success(true);
+	if (test__start_subtest("map_stack_nesting"))
+		test_map_queue_stack_nesting_success(false);
+
+}
+
diff --git a/tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c b/tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c
new file mode 100644
index 000000000000..6d22016b1709
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK);
+	__uint(max_entries, 32);
+	__uint(map_flags, 0);
+	__uint(key_size, 0);
+	__uint(value_size, sizeof(__u32));
+} map_stack SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 32);
+	__uint(map_flags, 0);
+	__uint(key_size, 0);
+	__uint(value_size, sizeof(__u32));
+} map_queue SEC(".maps");
+
+SEC("fentry/_raw_spin_unlock_irqrestore")
+int BPF_PROG(test_stack_nesting2, raw_spinlock_t *lock, unsigned long flags)
+{
+	__u32 value = 1;
+
+	bpf_map_push_elem(&map_stack, &value, 0);
+
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test_stack_nesting, int a)
+{
+	__u32 value = 1;
+
+	bpf_map_push_elem(&map_stack, &value, 0);
+
+	return 0;
+}
+
+SEC("fentry/_raw_spin_unlock_irqrestore")
+int BPF_PROG(test_queue_nesting2, raw_spinlock_t *lock, unsigned long flags)
+{
+	__u32 value = 1;
+
+	bpf_map_pop_elem(&map_queue, &value);
+
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test_queue_nesting, int a)
+{
+	__u32 value = 1;
+
+	bpf_map_push_elem(&map_queue, &value, 0);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.44.0


