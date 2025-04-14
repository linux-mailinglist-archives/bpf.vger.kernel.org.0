Return-Path: <bpf+bounces-55874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 539CCA88845
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C231916BEC0
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A953E27FD70;
	Mon, 14 Apr 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW63/ybr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A127F75D
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647294; cv=none; b=H9wFzxYTc3iV6AaUzGkdWlUcTZJ7yMWSFngAWoA2PmV3bx8DtzbvGNFPuFPJzm8g08l2W2EOmFgKvGuBPw7htY8QV7ruYhpK1CKdoxbqm4CU5EgYU675ek6sp8kFMRpCAuyIO5VmwaQNg/d/oXkEDljlhahYlfCcX5NY1pC4Re8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647294; c=relaxed/simple;
	bh=bZ/F2vPWahW2tlCL16E98ST6zgQ25t9ea24S3qS0f3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZSAXLX79SqK0sZ/SvW3qSBGvCCcobQ9Rke7tib+u2b7M7YPYS8f3cwH8IO/vcFTch/0IJlw4/VRWW1Kh644OvMHvFcbS0kJ3G8lbPxVjBqQaGjCKtQtlFOxbkgD8dUmNTxobB11i2cLOzd56y1wUnuqZUHjgVWF985utxaiq3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW63/ybr; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-39d83782ef6so3606906f8f.0
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647290; x=1745252090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtrTmZc6I7BwJiJqXCY5PqcG1j6z5ajbV41kwljLJ8s=;
        b=kW63/ybrpclpnk/J9jRTXwXK++xsxEls+vU2QiywT49eoQ7Zj1M8JrMrTSYq8DQrZo
         fuwfyYqVOM8y/x01kqpQCS199f1IM6mnJdZpWqYFz6O5fQwz/AAXQF0kPPqDQo3PKcf7
         7OsiZS4PhM5lwS4YK8CLDjpxh4Z6tzevCDmzgTy6wdSmyag3vHXQZB4o8jzF0C9RA/w0
         Dd1oZpakJTLme4B3XTyk5uxqIRy9VR1+eFDYA/tUbsgWnWCNYnl5DaSXUny3X2mhNRsx
         Z9caVta1LCacALgZY1A+OZ3kd5ZQepnWHB6M2YEcAROUcltsjgnk66RVPHfK0VmoAPHx
         MrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647290; x=1745252090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtrTmZc6I7BwJiJqXCY5PqcG1j6z5ajbV41kwljLJ8s=;
        b=TsdPDs3bFvlJtKGEcGFkuLKMQiFarOS7+sTgP4y7Lzo2vhM2pOatTGl6gL2cwJ0xzm
         WwMFfEnFlS+gTrInjfq38CoZuIRbdIKHGIvXgTC1vX1ZSoZHMHkwJFlWaEvN+VPZl3vG
         wMWN3/Gj4Sd2jzhWoaFORtftKshlz2y7nRXl+TJvGLdbmcAg1fBVK2PYJDQHQvwENR4D
         HPcLPvLhlbwUCvOLFosfxbIGcNtxxzJicjZJM+Vblu90YYHf7xTGxJBC4dB+9H9FPtFb
         2JrDZrK3O3l9wyxALnAbI54ILl1lImH+LppERIEiOcmLk82XuC1zHMmZdg2aXjVl9Mts
         0cfA==
X-Gm-Message-State: AOJu0YysSHzGCswGQafg4XDNIrRDg4fU1lm6RQ7IKnRgz5RxzObc3sjh
	qEeT0SoRN3XGcUuQgbn6LhDW1DIjulCNLE38Xq3CqiGYhbMchfjoCbqt5ax2CSc=
X-Gm-Gg: ASbGncsxyhURCyKxAKI91tf1Ybq1w7kaMM5jCwWZgpNR9/KHmK8pwF/Oak8eLC7okPx
	W+RnSmj/uXApTP7Yc4g4MWyBpq5IdtNKhAqwbcDuN+x3JjGE1WQmkmkPlNOlfxAxVMOmHdiExvg
	PUBIhPJ39S+wwwf8QpwVUg8F04ERay56OfbZ5n4GZ4ZA9Ybva1ICxkqpF87XsWftJpdYvc07b6r
	0uLrO7gI5lU4iM3YZhOL105F0yYwzRDZXp2TCeQkHWr6/U/KFujNvwLH50RtuhCyIdm8Zf+OMBV
	eO0rirREZmq+gXWWCB0rEc8b6Yg+ew==
X-Google-Smtp-Source: AGHT+IFRIMguu0kHLOCZNOQlYA2o3I4nNCtSITNOTCphKNm8thh5TwcJYcwYnRpRKnIeysChoVfGNQ==
X-Received: by 2002:a5d:64ee:0:b0:39a:c6c4:f87b with SMTP id ffacd0b85a97d-39d8f267768mr13742278f8f.5.1744647290105;
        Mon, 14 Apr 2025 09:14:50 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:9::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c49f7sm178682055e9.17.2025.04.14.09.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:14:49 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next/net v1 04/13] selftests/bpf: Add tests for dynptr source object interaction
Date: Mon, 14 Apr 2025 09:14:34 -0700
Message-ID: <20250414161443.1146103-5-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414161443.1146103-1-memxor@gmail.com>
References: <20250414161443.1146103-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3007; h=from:subject; bh=bZ/F2vPWahW2tlCL16E98ST6zgQ25t9ea24S3qS0f3U=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn/TOJkz9Ckh8CX27n5HZUE4YM+SEOBRMvHAz0qySn BCZ7pWuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/0ziQAKCRBM4MiGSL8RynCSD/ sHPleFeg9Na9dbCXEA0XU//8g7wTRvF7k6PM6onORfWCc2YGsiLHiJa3IUu07HlYxciM3mxEI8XTkR NPQR4YANb/ZdG4GfjYoC0/DbeVEn7yE94kZ6ZTRlR48ol3vWd0odQdR0GRrSoaH5UTbLSTEQImmOYm ZuYXOQr7X3SaA2Cv15XkdNjXgLiXgc+NA47hmd6+tC5XAJ+IAy1fdxJPdRo1sylDSwnDf4eMx+u3Pj suJoYI8oaT+obXKIW44RChXMKtTSxeT5ZgM8KEaDx+8n+5JqU9FUOva86tYlBCnvx4MTw76wwy8mqc vnaN03G4gdxswwbz/INlMeRvwxl1+oJInDvtBIqp4UxlDjsxjAzTea2HsB64MvqP0a6VZO5/w8bRHl bhVrOojy+aV8UKQ3iNOGZzRE5N4XgbpbMi1c2kToTGQMaCEf/jg6XxhFCT1bQzcWtEteg3d4lbRlfm GdEfp4EHmS+uJiL2d+OMDh9hVoBlO4ozpXR9TSFnXhjwErIzmMntSlgKwWmXW4cjnHdIuwpfAiAG3B L+dGoCZCGxxYM47ilAtObVbra7H87WhVPWhD5Lh9E+xJQHWPROiXjmbRvCnK9CcnYIAznygVDO7+iN 59xO69kFJq5EtoCD5UmQaKYWV3VDkryT3dixpf5YHZKsDqRtcACpyqkrAVIg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a few tests to capture source object relationship with dynptr and
their slices and ensure invalidation of everything works correctly.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  2 +
 .../testing/selftests/bpf/progs/dynptr_fail.c |  1 +
 .../selftests/bpf/progs/dynptr_fail_qdisc.c   | 38 +++++++++++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail_qdisc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index e29cc16124c2..929355de1002 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 #include "dynptr_fail.skel.h"
+#include "dynptr_fail_qdisc.skel.h"
 #include "dynptr_success.skel.h"
 
 enum test_setup_type {
@@ -161,4 +162,5 @@ void test_dynptr(void)
 	}
 
 	RUN_TESTS(dynptr_fail);
+	RUN_TESTS(dynptr_fail_qdisc);
 }
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 345e704e5346..7c67797a5aac 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -8,6 +8,7 @@
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 #include "bpf_kfuncs.h"
+#include "bpf_experimental.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail_qdisc.c b/tools/testing/selftests/bpf/progs/dynptr_fail_qdisc.c
new file mode 100644
index 000000000000..fc222213f572
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail_qdisc.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+/*
+ * Putting these tests in dynptr_fail.c causes other random tests to fail,
+ * keep them in their isolated CU.
+ */
+
+SEC("?struct_ops")
+__failure __msg("invalid mem access 'scalar'")
+int BPF_PROG(test_dynptr_source_release, struct sk_buff *skb,
+	     struct Qdisc *sch, struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr dptr, dptr2;
+	char buf[8], *data;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &dptr);
+	bpf_dynptr_read(buf, sizeof(buf), &dptr, 0, 0);
+	bpf_dynptr_clone(&dptr, &dptr2);
+	data = bpf_dynptr_slice(&dptr2, 0, buf, sizeof(buf));
+	bpf_qdisc_skb_drop(skb, to_free);
+	/* These reads/writes now succeed since dynptr is destroyed. */
+	*(char *)&dptr = *(char *)&dptr2;
+	return *data;
+}
+
+SEC("?.struct_ops")
+struct Qdisc_ops test_dynptr_qdisc = {
+	.enqueue   = (void *)test_dynptr_source_release,
+	.id        = "bpf_fq",
+};
-- 
2.47.1


