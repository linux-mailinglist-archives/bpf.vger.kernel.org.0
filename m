Return-Path: <bpf+bounces-57283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A148AA7AC0
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 22:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE78D3BACE9
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 20:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED92E20B80E;
	Fri,  2 May 2025 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAjbmTay"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0532520296A;
	Fri,  2 May 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216991; cv=none; b=eV2fGyXnK41RphMGa6LlgllN0+2Pk9341UbYSKHZG888ESIdlD8CIGc98nnZWD88pIjkmZAudJ9axMTme7RngVIVZttP3mnrvaRjuI2ok7/6kjjmF3JUOg7gV+6J9isX6IHEojlsCCIZtug9J7ft6wZkax6f98ZiwfW+DZKoRZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216991; c=relaxed/simple;
	bh=5KnQXCT7ejePp4D/koH4CcHyOlt9TzJIHL6G8oWa7RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrH9cNXojDOU7NE3sFbbIMhMJUSTB85Fq21yCKb4cvC01B8OO8FD9YSMsRq0FSOs3A8tQOd45Ihwa1N9zOYA+/sKouyhz/os7jx9q/X0017ubfXOXJXoNPNJk9tX8e/7aJlQMmqsifr7gOmOUYTLZJDVxU4XgT0pl/XnxUcqzF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAjbmTay; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22928d629faso25668615ad.3;
        Fri, 02 May 2025 13:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746216989; x=1746821789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuHOzyNA2PQ350q2S15Rqa7sytaGDQgGFBAky3x5h30=;
        b=hAjbmTayXkDmc3E6iXH8DyMyFN2YJnXjw+TyQ7WMGJPyOdSs+LraYCN4Fl21driqPI
         iBdWxINPh+ezaGssBKazHbyWsoYOCIC0pg/6DvrZWPrU9TmcB7AKycE5Jd4iHN078Iyc
         8Fq4ZMpfpnHY2KcQzHfHOFEhZj0ijgU2QuAI4qBSOTlZyzCzgOZRHx8Sxjq28A+90Npr
         svqTgUTkElgx9QxMr8MYRp8/QEjwo/RnTnxzLc6ihPykVHV25KC9VoQ4VVF8ZSCFSB91
         lY+Qr9wF5baNh8npAq2XLENxX1lNbo5YE6GLMUT62nZDlsi5svdzyQvmqRFPkhVn4lSy
         x19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746216989; x=1746821789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuHOzyNA2PQ350q2S15Rqa7sytaGDQgGFBAky3x5h30=;
        b=FNnbVP12UgRP8duLFfA+wupxxUYsY0+plvmRh0WQQYVVFlZYdKDSzjM3TKXaEG3rkx
         sS6fG30QHHG1ViSbNTXGJaBe98Ax69z3F2No35lKpe32t0fpc0HH+i7usYj6cY5tPudE
         fckmq70L9GtHHrY8HSODun54dm7aLDoF2SyW+TbvYexKpKJtugLiAQ23aedZSojhQQPS
         /If+Tdm1dMzHKZboPEaJMlU9hcWdOw0fxFmw3O8IFZ4KEtOA04NbL/512UXKYnE0UeHE
         cueP9GDpp16BEvuMAmFsm2+4f5hUB2xr2uLC3MRo2SnN8YJKGLmqC8mRRD061qH4Iiya
         l4Rw==
X-Gm-Message-State: AOJu0YxJdk+qqLjc/NzpBldE0WNglmgabo85iX2vOSopIdfOXA2up3TI
	R9DCWZqKBnt4LlbUNSkIDREBr0xnGCWHKSaJB84AClRH5HtCkmxnwiAJcA==
X-Gm-Gg: ASbGncsTqYcBKu+zXPH2ns9Uk8KW5AmnjUVGHIxLV/Dt5ungsGiCMJABUIhTDrHKAUn
	PsBvH+wbOHqpQEa/KpoerPGFTIsly82YJscMNShifokNzkCEP98iH0NsgS9NKrwgWqRbOcYS/8j
	cbaL3OAo6anPs40SwD1VR7IBOey4rHrWio5TR8UR0Tgt6D6Hc1AnIF5fQMD+772zlo653t51QZQ
	tq+HCysGeYiYhpNJ6+7Uqjg42iA76zzHVbCjPgcCrEKpUp7ijNJ5jjzFuo0YThPzSu+i8zuZ03N
	EXNsTunRJv1Y7At6rvIVudgrB5H8dYg=
X-Google-Smtp-Source: AGHT+IFcHJn1guNW5j7eZevl595iYvgl4376sGpGqCqCF6FcLlVFuSpVE+MaO3snBfuij3QKpe3WpQ==
X-Received: by 2002:a17:902:e546:b0:224:26f2:97d7 with SMTP id d9443c01a7336-22e1030c94emr57582485ad.8.1746216989200;
        Fri, 02 May 2025 13:16:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3b7cfefsm1202288a12.36.2025.05.02.13.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 13:16:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net v2 4/5] selftests/bpf: Test attaching a bpf qdisc with incomplete operators
Date: Fri,  2 May 2025 13:16:23 -0700
Message-ID: <20250502201624.3663079-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502201624.3663079-1-ameryhung@gmail.com>
References: <20250502201624.3663079-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement .destroy in bpf_fq and bpf_fifo as it is now mandatory.

Test attaching a bpf qdisc with a missing operator .init. This is not
allowed as bpf qdisc qdisc_watchdog_cancel() could have been called with
an uninitialized timer.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 19 +++++++++
 .../bpf/progs/bpf_qdisc_fail__incompl_ops.c   | 41 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      |  6 +++
 .../selftests/bpf/progs/bpf_qdisc_fq.c        |  6 +++
 4 files changed, 72 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index a22008fd31d2..53154544b28c 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -7,6 +7,7 @@
 #include "network_helpers.h"
 #include "bpf_qdisc_fifo.skel.h"
 #include "bpf_qdisc_fq.skel.h"
+#include "bpf_qdisc_fail__incompl_ops.skel.h"
 
 #define LO_IFINDEX 1
 
@@ -159,6 +160,22 @@ static void test_qdisc_attach_to_non_root(void)
 	bpf_qdisc_fifo__destroy(fifo_skel);
 }
 
+static void test_incompl_ops(void)
+{
+	struct bpf_qdisc_fail__incompl_ops *skel;
+	struct bpf_link *link;
+
+	skel = bpf_qdisc_fail__incompl_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_qdisc_fifo__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.test);
+	if (!ASSERT_ERR_PTR(link, "bpf_map__attach_struct_ops"))
+		bpf_link__destroy(link);
+
+	bpf_qdisc_fail__incompl_ops__destroy(skel);
+}
+
 static int get_default_qdisc(char *qdisc_name)
 {
 	FILE *f;
@@ -231,6 +248,8 @@ void test_bpf_qdisc(void)
 		test_qdisc_attach_to_mq();
 	if (test__start_subtest("attach to non root"))
 		test_qdisc_attach_to_non_root();
+	if (test__start_subtest("incompl_ops"))
+		test_incompl_ops();
 
 	netns_free(netns);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c
new file mode 100644
index 000000000000..49d790d2ea03
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/bpf_qdisc_test_enqueue")
+int BPF_PROG(bpf_qdisc_test_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	bpf_qdisc_skb_drop(skb, to_free);
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops/bpf_qdisc_test_dequeue")
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops/bpf_qdisc_test_reset")
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops/bpf_qdisc_test_destroy")
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)bpf_qdisc_test_enqueue,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
+
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
index 571fa7233ec0..bb91b04113a6 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
@@ -109,12 +109,18 @@ void BPF_PROG(bpf_fifo_reset, struct Qdisc *sch)
 	sch->q.qlen = 0;
 }
 
+SEC("struct_ops/bpf_fifo_destroy")
+void BPF_PROG(bpf_fifo_destroy, struct Qdisc *sch)
+{
+}
+
 SEC(".struct_ops")
 struct Qdisc_ops fifo = {
 	.enqueue   = (void *)bpf_fifo_enqueue,
 	.dequeue   = (void *)bpf_fifo_dequeue,
 	.init      = (void *)bpf_fifo_init,
 	.reset     = (void *)bpf_fifo_reset,
+	.destroy   = (void *)bpf_fifo_destroy,
 	.id        = "bpf_fifo",
 };
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
index 7c110a156224..72c9f4aefbcf 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
@@ -740,11 +740,17 @@ int BPF_PROG(bpf_fq_init, struct Qdisc *sch, struct nlattr *opt,
 	return 0;
 }
 
+SEC("struct_ops/bpf_fq_destroy")
+void BPF_PROG(bpf_fq_destroy, struct Qdisc *sch)
+{
+}
+
 SEC(".struct_ops")
 struct Qdisc_ops fq = {
 	.enqueue   = (void *)bpf_fq_enqueue,
 	.dequeue   = (void *)bpf_fq_dequeue,
 	.reset     = (void *)bpf_fq_reset,
 	.init      = (void *)bpf_fq_init,
+	.destroy   = (void *)bpf_fq_destroy,
 	.id        = "bpf_fq",
 };
-- 
2.47.1


