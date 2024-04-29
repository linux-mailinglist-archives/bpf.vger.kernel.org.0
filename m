Return-Path: <bpf+bounces-28182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6448B64B4
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3921C21907
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1350B18412D;
	Mon, 29 Apr 2024 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdkMAbnP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B885184124
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426581; cv=none; b=Z+cZuEY+V7iERSqmLMNK5796PuYUEi+3bUO+GsrCw9/rijQmoiFyljDGvemMDKLPlG6VFyuy77e1gbb1Q1JQLQJKlBnLSSxwgnBz/83THQS2eBY7TaL2X6SR9BmpciTBAzAQm/C8WacnF/yFN5H5vyn70vvPTEY30ll77/guqnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426581; c=relaxed/simple;
	bh=I/HQdIzxClxpiYMOP+mYxG3ROF0r7hwbDSt5dUNidLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ByeO4Rcv0M1HEGwOViK2wiy0RCY0kBbG+oJwC6g8k0IgasYTCULU34JGibL3wGttqOm7rFxTnObydjX75n3zVn6TsDwQNLIMJbqEDKbbrCBksZTwby4gx9wuzIiUCCPVBGWzKvsAHXXvmPTReInvN4G8o6rUxG4YnukJGEhs/Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdkMAbnP; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c844b6edbbso3018420b6e.1
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 14:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714426579; x=1715031379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQI0s/zOku12P4kv+jI56KO8d44pJV8Wjk4rHVkZmnw=;
        b=LdkMAbnPV8Eo7XQh9+TvAabeCeeMsCEroVVvGGIwjBD9ZbrRGPnWKcPdH5UMWtWSqD
         5n8zHl3XIkh16dhhp+LwxzQHYwrR8Ov8QU3RUe5hbkFarSiRJJ88tTttF9A68KKOtcga
         3CwUC0lcECNZHNrk87Wtes3KB5DYSMtzQrtZqN23SXZmaqzpLlq/cy2GBr6hSaOYwLEh
         sVwrDXrf33rj/C+yj9UzBUNlN2q2h5zHDD2bhV9zF4MLMPXNtBCeBAkb/WawBeoRoMwr
         eM+//yjRSWHLJwQ7SwAAu/0sBtktIkQA5FYrYbWgNBao+/bcQwfynJMjjgS//LIwGe6U
         crKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426579; x=1715031379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQI0s/zOku12P4kv+jI56KO8d44pJV8Wjk4rHVkZmnw=;
        b=DyacqcIii/GUFiZ41JZOF9iT7hAvLhCWgXBhA4V7KCZA4xihO6vSlSwjE7DADYCZRJ
         XdHf1HuKtC5M1cHcCHyXCnhnaai12Zxc9YHV3Zxqp5zO5YOtAz2z+Vqgk5cPVzd1a/AT
         7Pxz+cpknwj0W9ijns7Ijjggy5fnVIZ1Zh4TlD6/ixlH7LllKUhEcauIuxrzxmkLzWvP
         ZenxJOu9UPaYdLichD6tYoUHsg2bSFMjiZxvD5ImbxdBocmhQ/4OoAaDPo7cr0vgOa3t
         /SQ9mGieJFJ6mA67q6N+V8tDC/TR1H0/aTgpUTb5bbJN2co4Pugda3tJnaz0sjOE9UkX
         Ljiw==
X-Gm-Message-State: AOJu0YymVrhVm7erDz+4/45SJ4aIfK8BbG+59DirhwPe66dZZIqVdmdO
	7QazfuNDLkxcVLMqQo9g7DJ2pcgOrhC3D/AXqB2W/kZ1JiW2bTxpfpEXZA==
X-Google-Smtp-Source: AGHT+IFYonbBO6nCTjwLruMcb9WeXKTbPlfMQwIOOppMX1c+zlfzWKL9z1JA1P8m6D2LqPqEtUjV3Q==
X-Received: by 2002:a05:6808:211d:b0:3c8:5493:e25f with SMTP id r29-20020a056808211d00b003c85493e25fmr14579023oiw.12.1714426578955;
        Mon, 29 Apr 2024 14:36:18 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b805:4ca7:fd75:4bf])
        by smtp.gmail.com with ESMTPSA id x5-20020a05680801c500b003c8642321c9sm714034oic.50.2024.04.29.14.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:36:18 -0700 (PDT)
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
Subject: [PATCH bpf-next 6/6] selftests/bpf: test detaching struct_ops links.
Date: Mon, 29 Apr 2024 14:36:09 -0700
Message-Id: <20240429213609.487820-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429213609.487820-1-thinker.li@gmail.com>
References: <20240429213609.487820-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify whether a user space program is informed through epoll with EPOLLHUP
when a struct_ops object is detached or unregistered using the function
bpf_struct_ops_kvalue_unreg() or BPF_LINK_DETACH.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  18 ++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   1 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 104 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   |   7 ++
 4 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 39ad96a18123..e526ccfad8bf 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -539,16 +539,20 @@ static int bpf_testmod_ops_init_member(const struct btf_type *t,
 				       const struct btf_member *member,
 				       void *kdata, const void *udata)
 {
+	struct bpf_testmod_ops *ops = kdata;
+
 	if (member->offset == offsetof(struct bpf_testmod_ops, data) * 8) {
 		/* For data fields, this function has to copy it and return
 		 * 1 to indicate that the data has been handled by the
 		 * struct_ops type, or the verifier will reject the map if
 		 * the value of the data field is not zero.
 		 */
-		((struct bpf_testmod_ops *)kdata)->data = ((struct bpf_testmod_ops *)udata)->data;
-		return 1;
-	}
-	return 0;
+		ops->data = ((struct bpf_testmod_ops *)udata)->data;
+	} else if (member->offset == offsetof(struct bpf_testmod_ops, do_unreg) * 8) {
+		ops->do_unreg = ((struct bpf_testmod_ops *)udata)->do_unreg;
+	} else
+		return 0;
+	return 1;
 }
 
 static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
@@ -572,6 +576,12 @@ static int bpf_dummy_reg(void *kdata)
 	if (ops->test_2)
 		ops->test_2(4, ops->data);
 
+	if (ops->do_unreg) {
+		rcu_read_lock();
+		bpf_struct_ops_kvalue_unreg(kdata);
+		rcu_read_unlock();
+	}
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index 23fa1872ee67..ee8d4a2cd187 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -43,6 +43,7 @@ struct bpf_testmod_ops {
 		int b;
 	} unsupported;
 	int data;
+	bool do_unreg;
 
 	/* The following pointers are used to test the maps having multiple
 	 * pages of trampolines.
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 7cf2b9ddd3e1..b4d3b29114ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -3,6 +3,8 @@
 #include <test_progs.h>
 #include <time.h>
 
+#include <sys/epoll.h>
+
 #include "struct_ops_module.skel.h"
 
 static void check_map_info(struct bpf_map_info *info)
@@ -160,6 +162,104 @@ static void test_struct_ops_incompatible(void)
 	struct_ops_module__destroy(skel);
 }
 
+static void test_detach_link(void)
+{
+	struct epoll_event ev, events[2];
+	struct struct_ops_module *skel;
+	struct bpf_link *link = NULL;
+	int fd, epollfd = -1, nfds;
+	int err;
+
+	skel = struct_ops_module__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	fd = bpf_link__fd(link);
+	if (!ASSERT_GE(fd, 0, "link_fd"))
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
+	err = bpf_link__detach(link);
+	if (!ASSERT_OK(err, "detach_link"))
+		goto cleanup;
+
+	nfds = epoll_wait(epollfd, events, 2, 500);
+	if (!ASSERT_EQ(nfds, 1, "epoll_wait"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(events[0].data.fd, fd, "epoll_wait_fd"))
+		goto cleanup;
+	if (!ASSERT_TRUE(events[0].events & EPOLLHUP, "events[0].events"))
+		goto cleanup;
+
+cleanup:
+	close(epollfd);
+	bpf_link__destroy(link);
+	struct_ops_module__destroy(skel);
+}
+
+/* Test bpf_struct_ops_kvalue_unreg() */
+static void test_do_unreg(void)
+{
+	struct epoll_event ev, events[2];
+	struct struct_ops_module *skel;
+	struct bpf_link *link = NULL;
+	int fd, epollfd = -1, nfds;
+	int err;
+
+	skel = struct_ops_module__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	/* bpf_testmod will unregister this map immediately through the
+	 * function bpf_struct_ops_kvalue_unreg() since "do_unreg" is true.
+	 */
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_do_unreg);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	fd = bpf_link__fd(link);
+	if (!ASSERT_GE(fd, 0, "link_fd"))
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
+	nfds = epoll_wait(epollfd, events, 2, 500);
+	if (!ASSERT_EQ(nfds, 1, "epoll_wait"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(events[0].data.fd, fd, "epoll_wait_fd"))
+		goto cleanup;
+	if (!ASSERT_TRUE(events[0].events & EPOLLHUP, "events[0].events"))
+		goto cleanup;
+
+cleanup:
+	close(epollfd);
+	bpf_link__destroy(link);
+	struct_ops_module__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("test_struct_ops_load"))
@@ -168,5 +268,9 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_not_zeroed();
 	if (test__start_subtest("test_struct_ops_incompatible"))
 		test_struct_ops_incompatible();
+	if (test__start_subtest("test_detach_link"))
+		test_detach_link();
+	if (test__start_subtest("test_do_unreg"))
+		test_do_unreg();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 63b065dae002..7a697a7dd0ac 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -81,3 +81,10 @@ struct bpf_testmod_ops___incompatible testmod_incompatible = {
 	.test_2 = (void *)test_2,
 	.data = 3,
 };
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_do_unreg = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2,
+	.do_unreg = true,
+};
-- 
2.34.1


