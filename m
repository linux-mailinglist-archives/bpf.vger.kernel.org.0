Return-Path: <bpf+bounces-75804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F143C973D1
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 13:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC2EE4E1912
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890A430C34A;
	Mon,  1 Dec 2025 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="C22aNbqm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2FE30BF78
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591876; cv=none; b=XkwKoWS3vInModb+HIevf+yFX3B1JWbBivOaZBaTCq7++2wxljvBTs4MFM8RXt83UAfdK0juWyDRp+AneHOdtiIyco+iBRWyRnmpDcz0r6hpFM+j8/1lV0lqyxZCpR6hXhit1Tx9pxpAqdgoYDVhnYrrl5jOO6Nwh50F/hX6blk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591876; c=relaxed/simple;
	bh=Egmsxd6WhuG+1aHGJA9zA7ap31AaU5FP48jyqfW36E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBNZX05S8KXK6ITPB9ZN0+75wJO8bA+ZirtUE74DNwVs+oO0PP37IY12SgiTv0p1DZ8f3YV+mWGVMXuUDJy4fr9K8K7jcU1gGEdPrjV57ZfpKKyowcWI+8xcb1O+OIwUuu8lO/OJ4r60XKfy6Q4U8wPEFfakwekN5q+NgspeFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=C22aNbqm; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 834853F2B3
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 12:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764591871;
	bh=jXkgsidXiBaEN+Xes2JcR3minQELMlukrfJCybCFbvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=C22aNbqmrZAQi3nNclCHGoOtncQzHwXp2t2otkJpZ7TdrUGiBIXjfcIiRmiQid6IT
	 1mu1iyzWVwcxIwiGkKg7AnkMzFm5H1Cu5xJGT4MPhtXG+gHFn+YZdgaZ5L3rQ2r2hP
	 FqGjK064hVz6MEo0e7KvowJhjCPctgti6KbPs9l7PkxbuTHMvD0f1reoH7u1GctsIU
	 zZAipXtoqzQQGYP3XxcY1yp4A3eHHnk2Ndd0U9dml4UaB07LWrjM3fx/6lqOMGGPqC
	 lYCJ9F/YHUtHkiHoJdtxJd3WSlSa6NPcsg+7zpvomWodGuvZIFWhlGkFzkV1mYI8J1
	 jxGBrSwA4xGgwf5eMbbGe/36WvZaG5NvLT1K2oNaigjmgP/v67vhB/F9V2NwHjE4qn
	 dwHL/uQQyTfKaB6X1flWOdQNoC/SDGtt9LBHnANv5dHMa6QycIZPxnAvAKWEGok2GH
	 ekK+GTB72WmszfMrOBHjKK0rc5jvrMMvEGUvtb3Ora+41SS1r6AQoUjepuheCGAmQO
	 ygufQti/EW+LZMoacJbj9gj5u4xGVvo7a3xpLl7Dsto8MkS07rEusHOcE/K+b4KPNt
	 6ZDRNbxAEAE6q6lvmUXh5FNtI96Oh7d7L68NL/e/fex0zqkK5E+tv97olwpNkoustV
	 bZphRPqCIThFJnI88yq2bNgE=
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6409849320cso9220355a12.0
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 04:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764591868; x=1765196668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jXkgsidXiBaEN+Xes2JcR3minQELMlukrfJCybCFbvk=;
        b=ajziMZDDX6/LvusBW3Yg497tp6bpDBxeuXH/LmGie2ZX4KrsvrVfSFC0R1J3XUqR+R
         mUGzQgEfamkJkvrMcvxciDZWR1T2TyGB5DrQ1JS7K3bsltL+C7D3ZoYzbQ8jQuFH9TJw
         e0WzLLiZFzVlPF8A83oQYPdC0cm53E6qx9eqvHzKxgOrG4eOemvg9iF+comjOsWntwY1
         k7jnNgacxeBFtJZHZr3GXR3dtl08yCxdn7FfBkM7WB0XOo6CYRFgXfBZ4XKGKtPjlG+s
         d6OQ+duQN2y1ljNmYboeG87ZuETAqqQ4yeRIWB1Y2cGhurdzfe5NQFIazqJnJH3MFfFD
         hsAA==
X-Forwarded-Encrypted: i=1; AJvYcCUvF9JxpjcnazV7oMWKVQxv/rRAwFWYIJLb5OOloO5VgPNSiMSWqXTgUkkkIDrw6WvlAVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfSwjSSazX8s1Gp9Zfwoy+EsKF+aymVEXtMWXPIVfyMvVrh5Kb
	04Icd22vrJpQJunIBhwE9N1nNWICrZHCQIqS6ZwEGtIfaZrvY6sRpXm0gCAj0bpI2bQmVNiSJ5Y
	O3p4MlQX7JFs8uboqmPOqVJF8L4c/BOq9D3KGkkeKT0AFvcaeaDuZm1LB3pVUtVtEmUs1+Q==
X-Gm-Gg: ASbGncukBDEzeR1M47faLrn1yBOaPCXJvZShysmx/q1atXHg1RsC7n1+rG1VI/3tI8n
	e/85gDA4F/MsiX2qI1LIV4zpDIU3Xq9tVDKZd8Kbj8tIqPPRB2Fp3Rot2KHJ4a3EuOF2YyY32vX
	mu3Y0NMWNlwpIhrg8B1A0zXExmd//E0IGnuH3fOuL+8n1j6V8KAfQWsXTITSEAPvMviSVK7GkcU
	RxPYK6FSyH2MNjlUJJL5xfc6J5dCtsTdaHkg/HgTW/qhH/J5mUalkZ4BXp+KH50i3n+ynJgo6Jy
	9O421QasYoUi2sIMywY0YekF8svqgf0C+ZobuColaxyPl8mNoJOjrum5O+2zOl/3OPJUR/KrZba
	bSVI/ya3NIcQT9sYTJ4OWgBwiAPRt1Ip4so0SlLLoGsm2uROEdRE5TQDfyrgxHuhP2twncrjjLm
	vOUzNMcWCnHfNeYpFA5fS2Wmms
X-Received: by 2002:a05:6402:1d99:b0:641:9fdf:db43 with SMTP id 4fb4d7f45d1cf-6453962404bmr25196731a12.1.1764591868645;
        Mon, 01 Dec 2025 04:24:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdhwkAnp1agnhNL0XBFl1gCYXlLEElnXUghnsShlPPM9wQcvadSq0QTq7MjxtDqhOFO0U7dQ==
X-Received: by 2002:a05:6402:1d99:b0:641:9fdf:db43 with SMTP id 4fb4d7f45d1cf-6453962404bmr25196706a12.1.1764591868199;
        Mon, 01 Dec 2025 04:24:28 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf5749de007c66abd95f8bdeba.dip0.t-ipconnect.de. [2003:cf:5749:de00:7c66:abd9:5f8b:deba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a6ea36sm12307884a12.2.2025.12.01.04.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 04:24:27 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v1 6/6] tools/testing/selftests/seccomp: test nested listeners
Date: Mon,  1 Dec 2025 13:24:03 +0100
Message-ID: <20251201122406.105045-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com>
References: <20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com>
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
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stéphane Graber <stgraber@stgraber.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index fc4910d35342..0bf02d04fe15 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -293,6 +293,10 @@ struct seccomp_notif_addfd_big {
 #define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV (1UL << 5)
 #endif
 
+#ifndef SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS
+#define SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS (1UL << 6)
+#endif
+
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
@@ -4408,6 +4412,164 @@ TEST(user_notification_sync)
 	ASSERT_EQ(status, 0);
 }
 
+/* from kernel/seccomp.c */
+#define MAX_LISTENERS_PER_PATH 8
+
+TEST(user_notification_nested_limits)
+{
+	pid_t pid;
+	long ret;
+	int i, status, listeners[MAX_LISTENERS_PER_PATH];
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
+
+	/* Install more filters with listeners to reach nesting levels limit. */
+	for (; i < MAX_LISTENERS_PER_PATH; i++) {
+		listeners[i] = user_notif_syscall(__NR_getppid,
+						  SECCOMP_FILTER_FLAG_NEW_LISTENER |
+						  SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS);
+		ASSERT_GE(listeners[i], 0);
+
+		/* Add some no-op filters for grins. */
+		EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+	}
+
+	/* Installing a next listener in the chain should result in ELOOP. */
+	EXPECT_EQ(user_notif_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER),
+		  -1);
+	EXPECT_EQ(errno, ELOOP);
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


