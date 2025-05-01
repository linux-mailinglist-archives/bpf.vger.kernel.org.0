Return-Path: <bpf+bounces-57165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C036AA663D
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 00:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0909C78CD
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 22:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1F12690EB;
	Thu,  1 May 2025 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrICaerz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C22673B6;
	Thu,  1 May 2025 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746138632; cv=none; b=lsvz138eWzNy//nm9J/r74lwgXwyv7d38FKdwbV39ql7ARSOovfIIvSGEQfTDRmbpvPB13+q1Tu9eWwVtLBf1acQIJE+L6kNXUZGBvuG4Hu8HhGALaDVfnIudDingiqaiPkUrDuMeoisbghcRmp2ZDxcJ4V+ADo2Wyldy3zaVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746138632; c=relaxed/simple;
	bh=g4LXMczGavU2hweQn3we9Ju8bJmMXMvhaOoX5fTTXfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYmFchDmiGT1qKEFkEPwRSCdf7PRVrz6erOCQZ9itFil4MmgUkf7tVEDqY9SGw30gRIUL+EJPC81M8ctvkU9a41QJfeKWA/qcpDwPgtVFBZTTRNFyDsJvq5lmlWK0CewAawR1bxnMOTeGB3vLLdTPSeIzqVzGp685vF3GWV6c3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrICaerz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so1305783b3a.3;
        Thu, 01 May 2025 15:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746138630; x=1746743430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0md8E6tX6p1x6WJGU9t652Yvm+atmzg6GR7Dv9dlvnU=;
        b=SrICaerz6bAmAwNAsvEHK83d+BokeREIDMYlTpswcEySZB/bgH0TTnEkRefKj41lg0
         Hms3xqJ5kIXkxELi//WY69kckoK2bKi9QB6g9zAJCxNnqCNJtdFdI0UDvSpVSd5BAeR+
         AL+vSv3DJqpV9+lVmvLWPDxLxbrZTrXapNRslbGoV/8AYrhf0t1WTQ3eFKAUra9FHSRc
         Bd74XyI1zRJ0RUWEHbJ3MkK9Id62zbDff31VxhGAGzxO7IHY+Q7gtmEFkQqY4OMIn5zg
         6oukgYpiJEQmdJEbvrrAEzv8vgI6jtveTmWjD7VTd/ggF5AfFrgSn/+x3h3zuK1SdB2U
         E+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746138630; x=1746743430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0md8E6tX6p1x6WJGU9t652Yvm+atmzg6GR7Dv9dlvnU=;
        b=pnSEaL+OfrKmDqhLNxl8Mkztj4lFJwx50LJVWhEP6KR54bZvxLLYIqtzPP30dTLFQe
         YgxuKjDanegoo5M5E+UUY8fxlNmAypYB3ztMG/vbhAZ5RMJu7kZlYdcTsLjzNErmOdW/
         ZIhDY2n506hVtmt0XUzpadAw1O0vt0RAOVktwykELrynoSH16mPhflbiWb9S692ho+av
         1yiI66ALQE128sBaIEKY2wANpEuy0PLHlIQMjmvNJAhx63HgfkkIoX13TlBK0DF/C+nf
         g1LHPR4DBZK8CaCz/UAuNr0HwvFgU90TexnWxuCNe5cWfGMNjLTSLlXuFahGSJnccBzK
         OFdg==
X-Gm-Message-State: AOJu0Yy4DNJGle6x2zF3iFivAqVCtm7NqrAA214w8byyuamyNMR/Yg+2
	X1+5GwVjdtoCHIUx+4yoiL0yrIq9CBcEyuWBqafQLhfDDS6LaQqDAQC+KA==
X-Gm-Gg: ASbGncsvqCCr/BEL8WVUMw2SyQO1Rwm+Yp2oJgv8xaA5DZ8ZeXneDXRwkVBkQXK9nWs
	/711QSnoHYbt63u9Ay0nxUWzkkPFP7mIoL4351CZn59r2I4LNVejHq3MyRm76kVfGTc+QyB7egY
	rd6ZzMEgzHne9LDGIZl67px7oWsu1ld+Gk6Jx9GvnQJNV1XPRh4DxjVJG8e+52M4tTniODvhdbv
	yHV+UqsX8pSZLXJfzEi1WIAV9ygItcGEBZf0nK6VNUEGTzGwjV1ydC2iW30LSWeDb5wR2mV//Nf
	X7oL9AWtLDAoOGZrM0jmHB7UyLQ+zzT5
X-Google-Smtp-Source: AGHT+IGLDzli6FiubiZj8qf5366ovbgWsqwHbh/T4o22lpXJhnnU98GBKJweqx6iOZCFLlCCjZ70Iw==
X-Received: by 2002:a05:6a00:3489:b0:730:7600:aeab with SMTP id d2e1a72fcca58-74058a4906dmr809794b3a.13.1746138629885;
        Thu, 01 May 2025 15:30:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7f424sm202072b3a.35.2025.05.01.15.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 15:30:29 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net v1 4/5] selftests/bpf: selftests/bpf: Test attaching a bpf qdisc with incomplete operators
Date: Thu,  1 May 2025 15:30:24 -0700
Message-ID: <20250501223025.569020-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501223025.569020-1-ameryhung@gmail.com>
References: <20250501223025.569020-1-ameryhung@gmail.com>
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
index c954cc2ae64f..8afaf71cfadd 100644
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
@@ -248,6 +265,8 @@ void test_bpf_qdisc(void)
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
index 0c7cfb82dae1..6628d2872820 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
@@ -106,12 +106,18 @@ void BPF_PROG(bpf_fifo_reset, struct Qdisc *sch)
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


