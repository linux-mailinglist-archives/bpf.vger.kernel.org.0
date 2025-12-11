Return-Path: <bpf+bounces-76468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C30DCB5EDF
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 13:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDFAD305480E
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 12:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89248311C05;
	Thu, 11 Dec 2025 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="hWNbh3SQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8283009F4
	for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457224; cv=none; b=FCfaQ7UU2DLS/19LYrQPVw0SZrSgyCF1Rbcmi3OSIfBAY3UfXam3dKwWsH3bmK+z3XpD4gSBkkXX+sDc8J0rZqrlPu73ue1vDiENQLvqR0+0HVyKAZN7g3lyRVfIpqhDp6IzxoIFQ8GATGxADqKaPwACPXZ7yBW7nMn1a4a+wY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457224; c=relaxed/simple;
	bh=b+UeohnzvJw40pZRvhPeSZT8bb9n/7OIH7LnvbfILaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCYcBXtoGaGkiPmjtZ1raBLHkAr+BmbMjzoX/KAYwFdwF8Gmahc9zvFcLulv32OVikDfeS0pNdUFfhov64ASvCIpR54bmYnWdLBo7iZ0ZaQdXcBSk8C0Lk0ftA5j52nEf/OdYazhN/FZUnsgpX92LYxVCGDWNUZDJh9a/eZSCUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=hWNbh3SQ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D02143F859
	for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765457213;
	bh=V8hzy0OifNSQ9pCWZiF7fYz+AMk1VUw+02NG8nsswDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=hWNbh3SQLh32jYasjxZtX9nywLIZjIHKjan/koqwvU4dI1g+Gg9g8o4zBx5+tK0kN
	 C5es4HeoR4oQVOpdTOEH5P985HcKjcj0BPQ+A8xHt0GachXH7wt8TrjRVfw08UfIm3
	 FLx94tPlu0NnDsaxHg0oiNlILDJdecIFcH5+nO4CQg51PfTv7aq//HUHVF3UzaiF4l
	 m9Uj2xskXM57/8OOrzJdRuYCt0Q1amJ8EFI11qF/4nHDPrV45LK3Rmbjsw6Wn0SHS6
	 VAm/cFO5fKfoFXPxhZU+JrQM4cGfBjNwGGyW4lRelwvlJL1Si9LyQDWvCTdcjLGZvy
	 joQeTDeop0NW1FDEd+YLOBoRSNpwbHD2bGMAH/ygsQdlHpsGHBi8o1yRrLdTUXDypZ
	 kGS0C6fU957QF3SkBlRUjRfUtOSouJYSpoOU+qW2yLQy8FUOGrrcRYN9bGROx20DKy
	 Y/wMtC+NjSm7zsRh/2lgssXRMxfRuAMbAYBKr9/OjmZu+YYQA6Oix1kdmrH4Tj/ewf
	 uLJD1mv6KC1ok+C0UJto6DhYACH6h01QmsmHrCoOLREE+ITstm4aSGZya7dfiWyxfn
	 kE5datpBknwbQDVKds8ZgKPDd524+OR7iNxDPjY9LYXRYWNrtd0rePcY/p4zpFOO/+
	 mCUwehsxOFI4VjcCkoGuhPYo=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477c49f273fso405805e9.3
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 04:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765457203; x=1766062003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V8hzy0OifNSQ9pCWZiF7fYz+AMk1VUw+02NG8nsswDQ=;
        b=m0Ishsj3lLVUJ7BdFYTVf77GqHzS8iA5G9xkK1dSQucG8zZkp36cRaA8u+7FasbrH7
         VdJ5K7ODwFdMgJW9KovxIvbCvi5yRNrn4GmG9xG6q22YPh/4x9AKQwc7Fte3SlDK0cMo
         cV+xpAsSnHE4VptWw8UqKrQ00S7BSktdg5M887ULdZjYfYdb9Kr9NBg6C+EQOwtv+ixJ
         908Ka7dUp2eAvH6H4UrK+FBnj6akq7FkRdBv9nVo6FP5y9GDSgO2gCCCVbbxo5z4doQE
         Y6iAcZItxr7pRX6wivO+KnV2Lsjkmb27etrUEGRwB6ZiiRc6VNtbpjx6Lp8jJZangPeZ
         RbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlYBkZWbOGqqZ2X7hK89VJ55V041y3zoNtDR+6JZNzU+cRRxe4kk6PdEE/fMDF1bIeR8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpfVtXatmkj82hMEJYWaOA2ymj4w5wJnTBt7A1UiRL3MTwCndU
	D6NBFDvs2FdhtUU0RkRyB5FOBQwzWJ5m1jKC3TFYwh4DI1cQ4oAcggu1JtRuxSEX5wnWbVUDiF1
	4ApmxJaHxpbAMuvTz5rxxGSNFDvhOEFd1eSBKqzUMDay7lqREkXMigYJo8AXov/THP3WKrw==
X-Gm-Gg: AY/fxX4QPcruoP3DZbJ9XSuMDd9cCivRZ9Qs3EVlpBgXs1b4/MS0LVKRN4q1Q1ZeBAM
	YvAZFlughH4hwBWlK4PaHV0UWMK9sFwgQA6J9tm5IC3CXntJf8emNwhsS6I5ETXbsVDHBNuz9U6
	x8HG2cxFcoPkNiT1O3cfsn89Mte7pwPqJAqIg5FPXUh4ECRfN9NH6zpqv5KeU/D23/vw0tLjC/3
	IBKZU2jDVleh1jbALYupD7AYFT6lPPk668fMMPm8pm8J05gtls/P4ZfAz+EWI+jJsijsQ7pnOFD
	0MgkTvba8mwqmkfha/3GhE6I+6xdpOzKU8NfwhnLLlLc8bIoL/lt+l+nYFXGctg9XqCJrFksRjj
	ljUrQ3KPYJYGAobgDoQh4vqZqAorB3mxyuG5adyXaUspDmn6fHX0MBpjSGTKkhwJHleDxP7MQB4
	omxdrkc1/2sYfQTCqiYHPk45k=
X-Received: by 2002:a05:600c:3512:b0:471:21:554a with SMTP id 5b1f17b1804b1-47a83814519mr56357685e9.13.1765457203039;
        Thu, 11 Dec 2025 04:46:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+YNZ87WlXoAKJkxUjyMWYi8/OgaJF+UVLnKhVQzL+tkHO1XIRTcZi1teyC6sg/WSN/QxzHw==
X-Received: by 2002:a05:600c:3512:b0:471:21:554a with SMTP id 5b1f17b1804b1-47a83814519mr56357355e9.13.1765457202560;
        Thu, 11 Dec 2025 04:46:42 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf57022000e6219d5798620e30.dip0.t-ipconnect.de. [2003:cf:5702:2000:e621:9d57:9862:e30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89f0d6f2sm32075905e9.13.2025.12.11.04.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:46:42 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v3 7/7] tools/testing/selftests/seccomp: test nested listeners
Date: Thu, 11 Dec 2025 13:46:11 +0100
Message-ID: <20251211124614.161900-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com>
References: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add some basic tests for nested listeners.

Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stéphane Graber <stgraber@stgraber.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 303 ++++++++++++++++++
 1 file changed, 303 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..bbf3ef58ad07 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -301,6 +301,10 @@ struct seccomp_notif_addfd_big {
 #define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV (1UL << 5)
 #endif
 
+#ifndef SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS
+#define SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS (1UL << 6)
+#endif
+
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
@@ -4416,6 +4420,305 @@ TEST(user_notification_sync)
 	ASSERT_EQ(status, 0);
 }
 
+/*
+ * This test is here to ensure that seccomp() behavior before
+ * introducing nested listeners is preserved.
+ */
+TEST(user_notification_many_ret_notif_old_behavior)
+{
+	pid_t pid, ppid;
+	long ret;
+	int status, listener;
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/* Add some no-op filters for grins. */
+	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+
+	/* Install a filter that returns SECCOMP_RET_USER_NOTIF, but has no listener. */
+	ASSERT_GE(user_notif_syscall(__NR_getppid, 0), 0);
+
+	/* Install a filter that returns SECCOMP_RET_USER_NOTIF, and then close listener. */
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+	close(listener);
+
+	/*
+	 * Note, that we can install another listener now (without nesting enabled!),
+	 * because notify fd of the previous filter has been closed.
+	 */
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	/* Add some no-op filters for grins. */
+	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+
+	ppid = getpid();
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = syscall(__NR_getppid);
+		exit(ret != ppid);
+	}
+
+	memset(&req, 0, sizeof(req));
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	EXPECT_EQ(req.pid, pid);
+	EXPECT_EQ(req.data.nr,  __NR_getppid);
+
+	memset(&resp, 0, sizeof(resp));
+	resp.id = req.id;
+
+	/* tell kernel to continue syscall and expect that upper-level filters are ignored */
+	resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	close(listener);
+}
+
+TEST(user_notification_many_ret_notif_closed_listener_nested)
+{
+	pid_t pid;
+	long ret;
+	int status, listener, closed_listener;
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/* Add some no-op filters for grins. */
+	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+
+	closed_listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER |
+				      SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS);
+	ASSERT_GE(closed_listener, 0);
+
+	/*
+	 * Note, that we can install another listener now (without nesting enabled!),
+	 * because notify fd of the previous filter has been closed.
+	 */
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	/* Now, once we installed a nested listener, close the previous one. */
+	close(closed_listener);
+
+	/* Add some no-op filters for grins. */
+	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = syscall(__NR_getppid);
+		exit(ret >= 0 || errno != ENOSYS);
+	}
+
+	memset(&req, 0, sizeof(req));
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	EXPECT_EQ(req.pid, pid);
+	EXPECT_EQ(req.data.nr,  __NR_getppid);
+
+	memset(&resp, 0, sizeof(resp));
+	resp.id = req.id;
+
+	/*
+	 * Tell kernel to continue syscall and expect ENOSYS,
+	 * because upper filter's notify fd has been closed.
+	 */
+	resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	close(listener);
+}
+
+/*
+ * Ensure that EBUSY is returned on attempt to
+ * install a nested listener without nesting being allowed.
+ */
+TEST(user_notification_nested_limits)
+{
+	pid_t pid;
+	long ret;
+	int i, status, listeners[8];
+
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/* Install 6 levels of listeners and allow nesting. */
+	for (i = 0; i < 6; i++) {
+		listeners[i] = user_notif_syscall(__NR_getppid,
+						  SECCOMP_FILTER_FLAG_NEW_LISTENER |
+						  SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS);
+		ASSERT_GE(listeners[i], 0);
+
+		/* Add some no-op filters for grins. */
+		EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+	}
+
+	/* Check behavior when nesting is not allowed. */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		/* Install a next listener in the chain without nesting allowed. */
+		listeners[6] = user_notif_syscall(__NR_getppid,
+						 SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		if (listeners[6] < 0)
+			exit(1);
+
+		/* Add some no-op filters for grins. */
+		ret = seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog);
+		if (ret != 0)
+			exit(2);
+
+		ret = user_notif_syscall(__NR_getppid,
+					 SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		/* Installing a next listener in the chain should result in EBUSY. */
+		exit((ret >= 0 || errno != EBUSY) ? 3 : 0);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+TEST(user_notification_nested)
+{
+	pid_t pid;
+	long ret;
+	int i, status, listeners[6];
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/* Install 6 levels of listeners and allow nesting. */
+	for (i = 0; i < 6; i++) {
+		/*
+		 * Install a filter that returns SECCOMP_RET_USER_NOTIF, but has no listener.
+		 * We expect that these filters are not affecting the end result.
+		 */
+		ASSERT_GE(user_notif_syscall(__NR_getppid, 0), 0);
+
+		listeners[i] = user_notif_syscall(__NR_getppid,
+						  SECCOMP_FILTER_FLAG_NEW_LISTENER |
+						  SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS);
+		ASSERT_GE(listeners[i], 0);
+
+		/* Add some no-op filters for grins. */
+		EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+	}
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = syscall(__NR_getppid);
+		exit(ret != (USER_NOTIF_MAGIC-3));
+	}
+
+	/*
+	 * We want to have the following picture:
+	 *
+	 * | Listener level (i) | Listener decision |
+	 * |--------------------|-------------------|
+	 * |	     0		|      WHATEVER     |
+	 * |	     1		|      WHATEVER     |
+	 * |	     2		|      WHATEVER     |
+	 * |	     3		|       RETURN      | <-- stop here
+	 * |	     4		|  CONTINUE SYSCALL |
+	 * |	     5		|  CONTINUE SYSCALL | <- start here (current->seccomp.filter)
+	 *
+	 * First listener who receives a notification is level 5, then 4,
+	 * then we expect to stop on level 3 and return from syscall with
+	 * (USER_NOTIF_MAGIC - 3) return value.
+	 */
+	for (i = 6 - 1; i >= 3; i--) {
+		memset(&req, 0, sizeof(req));
+		EXPECT_EQ(ioctl(listeners[i], SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+		EXPECT_EQ(req.pid, pid);
+		EXPECT_EQ(req.data.nr,  __NR_getppid);
+
+		memset(&resp, 0, sizeof(resp));
+		resp.id = req.id;
+
+		if (i == 5 || i == 4) {
+			resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+		} else {
+			resp.error = 0;
+			resp.val = USER_NOTIF_MAGIC - i;
+		}
+
+		EXPECT_EQ(ioctl(listeners[i], SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	for (i = 0; i < 6; i++)
+		close(listeners[i]);
+}
 
 /* Make sure PTRACE_O_SUSPEND_SECCOMP requires CAP_SYS_ADMIN. */
 FIXTURE(O_SUSPEND_SECCOMP) {
-- 
2.43.0


