Return-Path: <bpf+bounces-52830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 628FFA48D73
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 01:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB7E3B7F7B
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 00:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE221119A;
	Fri, 28 Feb 2025 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="yOSagiNl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62C276D0E
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702828; cv=none; b=qWuAHyniJshLoKDEMq6GFZ/ro+FrC/wPgwyxpBLGs0RVLy2mOM+uNMAyeeBa+iEIa023xvCGo/oUKpKKIyZGTGwRn6S4cfwjMM8OTkNONaDegCInjdfOfmnElZSfpElMN5m+571idJX3U/zM5Arp+vpvvHnj96cqVhRIVFJlbcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702828; c=relaxed/simple;
	bh=+tAf7u/TOny6/E/kZLhCXOeYEH6uKeF3f+9OtyqAX6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzkjCqEAc7HpS3OzLCAeY1hE23cLf2lVzD9EERJp42xR4AyZXkf//RyVfjdecjfyjrbh/GIGvUYIvNfTqgJzJOkG2+DjTKSwXzDdnRR536WUt5UzXgmGkiSGFyw4Dqbv2qG/9Yx3G7eGvKR5OShLSIRgAfIMbbo0mSrqjgfUaj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=yOSagiNl; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd15d03eacso15707886d6.0
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 16:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1740702825; x=1741307625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIlQs9gMH3GKjLGlfRe+Sf9VX2opG0S7ZOahb6Lf2Ik=;
        b=yOSagiNlQWi6I8R4MTrs1TjDaUMPMRcdMaHssftglL3aoFjiXEFZkqrvcpsR6ypG6F
         /oqTnzCgu833k/2G7hfAUXcVZNnCSSKyC70SIS1T8hULMBBgr8ocRRWVzrki87E6SQS/
         4oIhvEWgOIFa72wUDyn4uKe4aX8JTFmUmaV7DukH2vRQASM2jygm+PEqXqpprTVTpE1s
         yS0VcFMOLuBYQ5FMEtHkq+x4kgdcyVFkrvg0rmCTqlooOP+vJaj8jpzw7QOpTPGk8/01
         BwYWSRowmBP3q5rANbJEbHnkVed/5sncn9DO0Fg5e2Kuy9FtsGecRk0mrZUSD59wvsHT
         YImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702825; x=1741307625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIlQs9gMH3GKjLGlfRe+Sf9VX2opG0S7ZOahb6Lf2Ik=;
        b=qh8EoU5QEYMCB3Zap4E5yAPsjp/BTZklHHid1WZH3dzDxV+IQGOrCfgPkXW8kOfhjl
         9iczKeFhzzylHhEWbJHyDcoTI21oFwqTM1zZ1uSaA4IjNkmRzbxu+s1fLji3JseSSlHW
         pCvs1PKY4jaNV5ZAAmJVfcx++B+lI6hZi6qzn/PndZu6/RvsZ6UmYs/Z4nRF6+BjFtc9
         AO1ij4qS2UhSaivniIVmEWFc5z1Uwf5qly80TYLd7Eko/++6mqFq6hJUAychKijfPogX
         T9oSsBTfuyF9e3tAaxb9C1AbyBo9wDyK8SeYGMBhK1iO4Uiz+8/Bnl6bYbyjuFuxfNDm
         4XNA==
X-Gm-Message-State: AOJu0YxgdO8UqjkapzXDrShtkLcDW08X+KfQDK8xMtoZ9lUi8Z9QknUV
	9NaW7MRxgPZTFYX8oGgyalWK6OHYyb1CFpOb8vfcxsK8Vh4x2oY5Sfl2TfwzTRAyq5kWiapObUQ
	ROILoxQ==
X-Gm-Gg: ASbGnctYqV0Uds6nLfRC9s4HJ2OQfXJeq4qMIb+wzXuRFqPFjs+VROwHkS58dOPDreL
	Q9LeqwnV/wFD07bziRbdes5vo5dfZSTO/PlSdbW6TN7/GhvugZVSHnB7qSac6q/YaKc2WJZ+5Ba
	sig8ADl+MxBzhMpIw9WjaYR6qChp4CiSRit5kKk+wUbLFwUlIIYO8lK/h7n4ighGrN7jd7JlA7O
	kjMauq9SC1OKKwHA2/YgJK6JuN09hXNKW+OJDJljGX8vDTwT0M4bUW/qnb7HoQxgTKJ+CIK/r67
	ZCdkdyvvmqTKst3+Dd3BnDY=
X-Google-Smtp-Source: AGHT+IHcBvsomVnHzNNdyYUP40PyzjKJhjmGzUKJe2PP+dg4JpanNYCoJ1UziQclKb+qvn2U1IQNXA==
X-Received: by 2002:a05:6214:508c:b0:6e4:5f2b:9f15 with SMTP id 6a1803df08f44-6e8959ea24emr72926276d6.14.1740702823412;
        Thu, 27 Feb 2025 16:33:43 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fef5beesm174769085a.32.2025.02.27.16.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:33:43 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.de,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 2/2] selftests: bpf: add bpf_cpumask_fill selftests
Date: Thu, 27 Feb 2025 19:33:21 -0500
Message-ID: <20250228003321.1409285-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228003321.1409285-1-emil@etsalapatis.com>
References: <20250228003321.1409285-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for the bpf_cpumask_fill helper that sets a bpf_cpumask to
a bit pattern provided by a BPF program.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/cpumask_success.c     | 23 ++++++
 .../selftests/bpf/progs/verifier_cpumask.c    | 77 +++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpumask.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8a0e1ff8a2dc..4dd95e93bd7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -23,6 +23,7 @@
 #include "verifier_cgroup_storage.skel.h"
 #include "verifier_const.skel.h"
 #include "verifier_const_or.skel.h"
+#include "verifier_cpumask.skel.h"
 #include "verifier_ctx.skel.h"
 #include "verifier_ctx_sk_msg.skel.h"
 #include "verifier_d_path.skel.h"
@@ -155,6 +156,7 @@ void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
 void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
 void test_verifier_const(void)                { RUN(verifier_const); }
 void test_verifier_const_or(void)             { RUN(verifier_const_or); }
+void test_verifier_cpumask(void)              { RUN(verifier_cpumask); }
 void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
 void test_verifier_d_path(void)               { RUN(verifier_d_path); }
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 80ee469b0b60..f252aa2f3090 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -770,3 +770,26 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
 		bpf_cpumask_release(mask2);
 	return 0;
 }
+
+SEC("syscall")
+__success
+int BPF_PROG(test_fill_reject_small_mask)
+{
+	struct bpf_cpumask *local;
+	u8 toofewbits;
+	int ret;
+
+	local = create_cpumask();
+	if (!local)
+		return 0;
+
+	/* The kfunc should prevent this operation */
+	ret = bpf_cpumask_fill((struct cpumask *)local, &toofewbits, sizeof(toofewbits));
+	if (ret != -EACCES)
+		err = 2;
+
+	bpf_cpumask_release(local);
+
+	return 0;
+}
+
diff --git a/tools/testing/selftests/bpf/progs/verifier_cpumask.c b/tools/testing/selftests/bpf/progs/verifier_cpumask.c
new file mode 100644
index 000000000000..bb84dd36beac
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_cpumask.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#include "cpumask_common.h"
+
+#define CPUMASK_TEST_MASKLEN (8 * sizeof(u64))
+
+u64 bits[CPUMASK_TEST_MASKLEN];
+
+SEC("syscall")
+__success
+int BPF_PROG(test_cpumask_fill)
+{
+	struct bpf_cpumask *mask;
+	int ret;
+
+	mask = bpf_cpumask_create();
+	if (!mask) {
+		err = 1;
+		return 0;
+	}
+
+	ret = bpf_cpumask_fill((struct cpumask *)mask, bits, CPUMASK_TEST_MASKLEN);
+	if (!ret)
+		err = 2;
+
+	if (mask)
+		bpf_cpumask_release(mask);
+
+	return 0;
+}
+
+SEC("syscall")
+__description("bpf_cpumask_fill: invalid cpumask target")
+__failure __msg("type=scalar expected=fp")
+int BPF_PROG(test_cpumask_fill_cpumask_invalid)
+{
+	struct bpf_cpumask *invalid = (struct bpf_cpumask *)0x123456;
+	int ret;
+
+	ret = bpf_cpumask_fill((struct cpumask *)invalid, bits, CPUMASK_TEST_MASKLEN);
+	if (!ret)
+		err = 2;
+
+	return 0;
+}
+
+SEC("syscall")
+__description("bpf_cpumask_fill: invalid cpumask source")
+__failure __msg("leads to invalid memory access")
+int BPF_PROG(test_cpumask_fill_bpf_invalid)
+{
+	void *garbage = (void *)0x123456;
+	struct bpf_cpumask *local;
+	int ret;
+
+	local = create_cpumask();
+	if (!local) {
+		err = 1;
+		return 0;
+	}
+
+	ret = bpf_cpumask_fill((struct cpumask *)local, garbage, CPUMASK_TEST_MASKLEN);
+	if (!ret)
+		err = 2;
+
+	bpf_cpumask_release(local);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


