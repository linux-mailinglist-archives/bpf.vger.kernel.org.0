Return-Path: <bpf+bounces-30543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8908CEC6D
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 00:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666AA282703
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B612BF3F;
	Fri, 24 May 2024 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmmnnmF3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2F128808
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716589849; cv=none; b=MxQ7u9xycQEkzs9fFRR0/yAHaH3+/RSounGxI7IxyvI5D3N4mvvW01MmaH+rcQFMT2ljDc0iKjuOgGPWPzJk5Z7QYdTWM/zk761Qu8+I4FRjm2hOhBcGbBjoZnnciqdIfz4D4BjGkA/Gub5aSE1LZawpuWfunpx8JhGEmKWgYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716589849; c=relaxed/simple;
	bh=M/Uv8vWTI1pT9gejmLQvJRT763bIa7cjhVoGiJeMPyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X3iEbE4rjJ3puJ9Uj1//gh6ejrAhOR4iMk4GgdF7wUbz4Va1P0g0L2FV2+jEHl2wrHxlhFi9PvkSThlnkmSca40HGWC3Gad264paMBMfPIqyXVBcbNBm60e2FPk3q9elfn33MXFVBW1ooWp1UsM5cbunt+i9+dfWHOaQlwCGYGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmmnnmF3; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62a088f80f6so10217097b3.0
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716589847; x=1717194647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUnPrrURnrhMYgU2LE3oHrFC+PkOKbHjxUopkZxUqDQ=;
        b=lmmnnmF3i/stPRMK6AJarU/lvy76IPWmkUKVirvA6PmY0aUnOmtmt+mDDkkx0x9A+j
         86IyFUBClPvPH98myjLo8ARNWxSTawKr6zA7gDpK7IfkWoV/B/X2GMs1X4I/Q1ckgXFK
         7bSky5XZ4xf8vLPmKk6JwFHVS1pqfyXgmzsRY86wYGx7xgxbiBRyhLvKOrvdhat+rod5
         O2Yu/Wk4HWJhzeyuVwb03xZEgCci698UtyCFdI8ldeIFl2IVc1oSLpqtLtBrssRjk5iV
         q9VctBGs3pq42jYhcIyvZ2uJze1zCokVraaNZoQYtk5cUP0sMcBgFT2LL7DK3OwcVoIX
         mF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716589847; x=1717194647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUnPrrURnrhMYgU2LE3oHrFC+PkOKbHjxUopkZxUqDQ=;
        b=V3np7AU7PrihmnEFWcdkqHCLtFfkz9P5KhMGFUpgQvf1Raw0TCjHyfWKt6cA5Bhj1u
         M/HMIWRp7CQRH8wDLnhoOCmdsBUfY0TEDzIO4k4lRcU1idNwUCmMHNa7uNJWVIfoJJCu
         irqpYDrZ0lJKQ9Rn7JILL/NYf4MJYW/wh++yfTAldu8MJp2bARhE4B3jzeaNjf1kVDZ8
         3ikaBcsWWgwu7JwMaFFBjGp4Mdl3iwuwnnW/OaNy+yh2Niu1On2LRXRasTg9i+lkgXAN
         HDeiPID1c+uDksApsVXQOAy58r2JxKTN7dGsdsPnDa64dJBs2VIu1oMxKqM98jeJ8uOJ
         5JqA==
X-Gm-Message-State: AOJu0YzzN+Oc3tVG8VptVUXnu4vASFJX84Zanb1m0jBIPls5PmsBZr1I
	tqEFt+oCFGmXc1tiLwyLxlJUyBLjSkeYOZE1gC6UOo9Mk/mUZ+14n2txfg==
X-Google-Smtp-Source: AGHT+IGWWqHT9VLqKqeVu2+8K6WbYyEmsj62O5Vue2zVBuNuZwchYYBYv1cPXm0vBCZLLZbmRE3A3w==
X-Received: by 2002:a0d:ea0a:0:b0:627:e3ba:2ad7 with SMTP id 00721157ae682-62a0732cef8mr28619727b3.9.1716589846647;
        Fri, 24 May 2024 15:30:46 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6aeb:e91b:f49d:e77d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a3bfa19sm4169987b3.44.2024.05.24.15.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 15:30:46 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 6/8] selftests/bpf: detach a struct_ops link from the subsystem managing it.
Date: Fri, 24 May 2024 15:30:34 -0700
Message-Id: <20240524223036.318800-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524223036.318800-1-thinker.li@gmail.com>
References: <20240524223036.318800-1-thinker.li@gmail.com>
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


