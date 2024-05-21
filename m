Return-Path: <bpf+bounces-30177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F4C8CB631
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0241C21AF9
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBEB14A0AE;
	Tue, 21 May 2024 22:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsXLzZXQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ACD148FF1
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331991; cv=none; b=tX5qci4puxyQL2RjSTWxwZ5MFLZEc+4VhruSfRJGT9stX79xGYW0RybohZQ5oB+peNRN0CDWobH9pIKsrsDj6cYsDlO2N/1TxvkFtBw7cvMAmSk0bgDtX8Es4pDWsdzzxuKIqRcHxLaHmsD2Q9WPOmDRFX3UGbhaytmayXgYf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331991; c=relaxed/simple;
	bh=M/Uv8vWTI1pT9gejmLQvJRT763bIa7cjhVoGiJeMPyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wtzy33cxe+t+DVhPMx4p7waFUYUGCaWGDG8zZ9f6MsgnsDS7sm2sf28JVmPXlHSR0wFxgzJp+TN+W18CGvb/Me/cDBLHwoKU7ULS4a2dZURd7A26JTPtLKzrRnv9wV6NCkxIRhVqfvv6v3f/TKRqigfcY/pg3RitVpSzpvesK98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsXLzZXQ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61be4b9869dso44872897b3.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716331989; x=1716936789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUnPrrURnrhMYgU2LE3oHrFC+PkOKbHjxUopkZxUqDQ=;
        b=IsXLzZXQBo4qz7j6H4g8SMPqARJYTp9cBvb5t1v48ycaPMlJZzwCyUsCgsUXDaeMAi
         lZn+8GZrr/UOuv9SlQyuOKO88Mx4kPF1X2SPYWfYoyAb7vPIvQxWS6hmhH1aaaonuvsK
         QE5DUgEgzlU0H76x9sEzvyXwT9vKeS66PuJna/4RCkLWx6msjtu+yRLdusw6lJ0OslDQ
         /dXuEsIHAwvMOaxo+0V+ZJZH/PUI8lqB5lfSkYGhFqKbBIj41KMActtMEnqUkgEL7Poz
         2wcu5gAKUuQ/pDTubzB0TXmqwfh2y5VbXBp9FIbYTxMPLKxx1xdjOUr7pkTZ9qFhSCcM
         c+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716331989; x=1716936789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUnPrrURnrhMYgU2LE3oHrFC+PkOKbHjxUopkZxUqDQ=;
        b=IjvQTRKWH/l3LSi5Sgq0uPVYBNvkKYz8FGTtgu3jxZKiRfCeauFiMpsiGdNfVTn4XY
         p+SXbkm0Pu5vbXqA7k7nVLUm41eFHeaPWWZWboxd/h6S05pfutuUaHG/1Pjd8O0wW3Ym
         4VW9iaQhq/fusb4/q69k9u5LB6QVR2RG2S0KpYP5kdgzO6QLv1qpL92BiU9xb7+zv2m3
         kpX7t8oveB1QMEqWJC6SEVqywhxy44x6bjuL9bBw/7Mx5o284laX1Sga9XkpMwck1N6z
         xFUoPQTpjDWd3jJ6i0A9bZdDX8pnVaTDo8S8S7YUDkHZC+ZXDKGwQKxw2QAM4/GC/eml
         uc/w==
X-Gm-Message-State: AOJu0YyR1x9zo51EbLTeqoWg6MvNLxRL7L7LQ1EH4XIALwezy3WN115m
	7YKR4nykzbZPEOWvHdh13K6p93Du1zqAuui92S3SS8wAGEYE0rLy0O0Yag==
X-Google-Smtp-Source: AGHT+IEVZsg4WUyUaXN5LkTdDpTbicLEkrMvX7w6L+XxxnD8gi6Q1hG6oIgZ0F22vS8FtG1S4EadRA==
X-Received: by 2002:a25:b01:0:b0:deb:c936:abf6 with SMTP id 3f1490d57ef6-df4e0acf030mr498660276.24.1716331988679;
        Tue, 21 May 2024 15:53:08 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1437:59a6:29be:9221])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd385be51sm5584956276.54.2024.05.21.15.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:53:08 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 6/7] selftests/bpf: detach a struct_ops link from the subsystem managing it.
Date: Tue, 21 May 2024 15:51:20 -0700
Message-Id: <20240521225121.770930-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521225121.770930-1-thinker.li@gmail.com>
References: <20240521225121.770930-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not only a user space program can detach a struct_ops link, the subsystem
managing a link can also detach the link. This patch adds a kfunc to
simulate detaching a link by the subsystem managing it and makes sure user
space programs get notified through epoll.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 42 ++++++++++++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  1 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 67 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_detach.c   |  7 ++
 4 files changed, 117 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 0a09732cde4b..2b3a89609b7e 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -744,6 +744,38 @@ __bpf_kfunc int bpf_kfunc_call_kernel_getpeername(struct addr_args *args)
 	return err;
 }
 
+static DEFINE_SPINLOCK(detach_lock);
+static struct bpf_link *link_to_detach;
+
+__bpf_kfunc int bpf_dummy_do_link_detach(void)
+{
+	struct bpf_link *link;
+	int ret = -ENOENT;
+
+	/* A subsystem must ensure that a link is valid when detaching the
+	 * link. In order to achieve that, the subsystem may need to obtain
+	 * a lock to safeguard a table that holds the pointer to the link
+	 * being detached. However, the subsystem cannot invoke
+	 * link->ops->detach() while holding the lock because other tasks
+	 * may be in the process of unregistering, which could lead to
+	 * acquiring the same lock and causing a deadlock. This is why
+	 * bpf_link_inc_not_zero() is used to maintain the link's validity.
+	 */
+	spin_lock(&detach_lock);
+	link = link_to_detach;
+	/* Make sure the link is still valid by increasing its refcnt */
+	if (link && IS_ERR(bpf_link_inc_not_zero(link)))
+		link = NULL;
+	spin_unlock(&detach_lock);
+
+	if (link) {
+		ret = link->ops->detach(link);
+		bpf_link_put(link);
+	}
+
+	return ret;
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -780,6 +812,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_sendmsg, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_sock_sendmsg, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getsockname, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getpeername, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_dummy_do_link_detach)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -832,11 +865,20 @@ static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 	if (ops->test_2)
 		ops->test_2(4, ops->data);
 
+	spin_lock(&detach_lock);
+	if (!link_to_detach)
+		link_to_detach = link;
+	spin_unlock(&detach_lock);
+
 	return 0;
 }
 
 static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
 {
+	spin_lock(&detach_lock);
+	if (link == link_to_detach)
+		link_to_detach = NULL;
+	spin_unlock(&detach_lock);
 }
 
 static int bpf_testmod_test_1(void)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index b0d586a6751f..19131baf4a9e 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -121,6 +121,7 @@ void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p);
 void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p);
 void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p);
 void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len);
+int bpf_dummy_do_link_detach(void) __ksym;
 
 void bpf_kfunc_common_test(void) __ksym;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index bbcf12696a6b..f4000bf04752 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <test_progs.h>
 #include <time.h>
+#include <network_helpers.h>
 
 #include <sys/epoll.h>
 
@@ -297,6 +298,70 @@ static void test_detach_link(void)
 	struct_ops_detach__destroy(skel);
 }
 
+/* Detach a link from the subsystem that the link was registered to */
+static void test_subsystem_detach(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4));
+	struct epoll_event ev, events[2];
+	struct struct_ops_detach *skel;
+	struct bpf_link *link = NULL;
+	int fd, epollfd = -1, nfds;
+	int prog_fd;
+	int err;
+
+	skel = struct_ops_detach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_detach_open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_do_detach);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	fd = bpf_link__fd(link);
+	if (!ASSERT_GE(fd, 0, "link_fd"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.start_detach);
+	if (!ASSERT_GE(prog_fd, 0, "start_detach_fd"))
+		goto cleanup;
+
+	/* Do detachment from the registered subsystem */
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "start_detach_run"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(topts.retval, 0, "start_detach_run_retval"))
+		goto cleanup;
+
+	epollfd = epoll_create1(0);
+	if (!ASSERT_GE(epollfd, 0, "epoll_create1"))
+		goto cleanup;
+
+	ev.events = EPOLLHUP;
+	ev.data.fd = fd;
+	err = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);
+	if (!ASSERT_OK(err, "epoll_ctl"))
+		goto cleanup;
+
+	/* Wait for EPOLLHUP */
+	nfds = epoll_wait(epollfd, events, 2, 5000);
+	if (!ASSERT_EQ(nfds, 1, "epoll_wait"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(events[0].data.fd, fd, "epoll_wait_fd"))
+		goto cleanup;
+	if (!ASSERT_TRUE(events[0].events & EPOLLHUP, "events[0].events"))
+		goto cleanup;
+
+cleanup:
+	if (epollfd >= 0)
+		close(epollfd);
+	bpf_link__destroy(link);
+	struct_ops_detach__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("struct_ops_load"))
@@ -311,5 +376,7 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_forgotten_cb();
 	if (test__start_subtest("test_detach_link"))
 		test_detach_link();
+	if (test__start_subtest("test_subsystem_detach"))
+		test_subsystem_detach();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
index 45eacc2ca657..5c742b0df04d 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_detach.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
@@ -2,8 +2,15 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <vmlinux.h>
 #include "../bpf_testmod/bpf_testmod.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
 
 char _license[] SEC("license") = "GPL";
 
 SEC(".struct_ops.link")
 struct bpf_testmod_ops testmod_do_detach;
+
+SEC("tc")
+int start_detach(void *skb)
+{
+	return bpf_dummy_do_link_detach();
+}
-- 
2.34.1


