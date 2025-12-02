Return-Path: <bpf+bounces-75877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DDAC9B62C
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 12:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 395764E3867
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 11:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC79318144;
	Tue,  2 Dec 2025 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="tDiGu0eS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7410316197
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676358; cv=none; b=lSYg8pghvJzM4xBtCsaw/TesR5yTK3zldeb4NSu96j0X0dCYVdbGv1FgqYylyM3fY6hykEavoNHZq9VzBba7ekP+b7lUsv/ke+PVpIkGr+RM3dcZlNE2beGamd4uXVe+XnT65CNcH6M4X1zrOa4I6rS5NXq3/lkQlePP0fKa0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676358; c=relaxed/simple;
	bh=8zxbYHTC/vFoDDVlLNN1L+clSwYxFA+WMrxYCr2Ewcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2W8Xmtbuwj/dqLu87fLl33gVGJE+2AIa4lXKaiF17IjoNCvTCdoneAnK5rHjWDY4QXhqSv/lL2u5F9qyBWoPQGwRK8SIAqjaNwSvQDbj/bn1r6QGinZ07yixVXvAZcvdJHUGnvh8029HJD3rrbJH0PNKvX4JScefgRnmVPNd90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=tDiGu0eS; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 968733FE2D
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764676348;
	bh=cwVszfkAi2lPLgwK1Qc8I2xQFtjDa28JTJArXKCEz6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=tDiGu0eSUO8wikrqh2uQRF60hBmXZZ+MSxYWs/dm7DsRrnuY9oAI2zvM8xtpmzkU/
	 G6RDB795kZAeeFuaYtuzYuQ9CwanMxvOYJkeXOpfkhY/eBSpL19mtDzdj4U9DGUfcF
	 qSbRopfvBBl+mXkkWlBMpVVj2XUsuPAdYvNu3gSAKm/mQz5dgO9+o8OO9fQrW81Fdf
	 uKdGAVozym6NEAYidni9es7dx7PwutrebXQYop5RUSJscTFyFRK2isol1ulCTexRqe
	 S0avC7hRFISsu9Sppv3dlY3AwpmRCUe7Z2DZvvqHxAC+mKqT0s93ftz10D3KyMP3e7
	 vaXZWQSNFpIsRjj3OTsTs85+YTNInF/Osq+a4EUGNHUrMqIY+97Q2A48O5Lmy7MX+o
	 I3DmIUSREkpY9naEbd6waFZVrJEJ7e+4e3hB9uUqRTxO+MKvmsg0CtQvGcBiBHiiNn
	 5Qz89nlW3lh7SjpUDqYFfDwPKWNC3+K31MIGZHQMRP6Qhnv+5ITqo86cLXhrYrnI5k
	 4igHIAqO86TY8pggEz6cckgcTpYJQtQQ0OiFBZj55ZP50sy0i6AUwFsOHIZ6nuG/06
	 ObHotsUvr/uKkS4EoZXqhVOa5Ge/mo7TlIpfGAwL/7uLLPKgOf75Y8zdQ6zeyKyCcZ
	 O0Gqv1qqeELwPU+gVdzji1dM=
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6409c803b1aso7902017a12.3
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 03:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764676341; x=1765281141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwVszfkAi2lPLgwK1Qc8I2xQFtjDa28JTJArXKCEz6A=;
        b=M9G3MAZR8dbAiBalEmmNZXK6vv6sQlL8qvnB5MsWODOjuZldvY07/nvEsHIpn4YjVR
         vFZsLVx9YApTnNrv9oVungljfW1EN6xAUL4SVpiG3eBbq+Um4UGhpcb4uwKm2/xE5v60
         q82gMKcPw1hefd0bcGuKnnYqJku/j2ChJtZN9YDPwSZELOd05PjmB0raZD2pYPQz57RO
         Fia1KCU5qbVi1SMZkX979pqyOFxFXsKT+y61TH8O7zs6WyJB+z/xbfMd33fAciS3Tt5q
         DLlJ/HHtLa2oS+44JPfA/p/qEAkWJDWHCgC/1lWwoaygeueFmTcEbfSbFDz7+TibAVqU
         6Gxg==
X-Forwarded-Encrypted: i=1; AJvYcCVu2pAUuQcPU1GPaImM/pAl8LQwBBzmn8YZW6EfyMB/qPsvODw0vDUUYBve+ccB1w/wpKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFNqTR9Jbr+n/CU+cWUZBPxpKloBYMGXcqSH0x8fHX+l7bnzt
	CByfuoSB3tt9VwvOPX/efhV7KqPLNGaVGjesjgeJ+o6T0sOuL9PYGYONy52va7ehBmBvV4WeVCR
	CK30kaVUn2IfNHFyp6Ii+bA4EtICHcB275qqOk2L2DZDpuAVGeat00aXn6EJYYPvnbLOG+A==
X-Gm-Gg: ASbGncsJ8xNMy4RTU+NBGn5QXACZjgbD7RfgUshAMOcHz4Ua3SMkAcvwM/HnRJ2Q3de
	ZiEbKmzjGv6pxQV0lxWLMrnGel+97SKIiEDhdujuhefFTwoaJbyrrP96Xaf73zrP3GEpBYRKO+M
	R5zobqiPPYaW2LwXijnVsCTbxSoETo122w3F1zcTMqGPIzZRnNmxIdIVgIDhd/Hpy1OCi4euvhf
	WBB2QXEFBZ4beIZuEDnjZ6eM0dUUgjemGYc6qhGf1b7XjylJ7cdCjjNbuxhn9/oBoh4/vRPL0X0
	pGdQE7eEHTlX9bslyVkWH+ipuPgLs1m5XJoZoqkxC12bRXgnjyY3mTUAFuxro7xdVj0qd+lCwt2
	cO+L+C9kuV7QaP/RgH3gma0s1rTyewBnxKEVDxP5BR50RqdVkWDa3hpgN5Yzn7R/GkmduPVtN9R
	wk2uMxLeVy8fK2bz+lvSACPfw=
X-Received: by 2002:a05:6402:358b:b0:643:ab7:2e7b with SMTP id 4fb4d7f45d1cf-645559f9dd0mr38694723a12.0.1764676341135;
        Tue, 02 Dec 2025 03:52:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNMdUcbKmi/gMtf98cLSdMWXvArBVuk0t5kodbo3nTcLBM5sFT8yTGpmgTFvPpZdtsAj5W6Q==
X-Received: by 2002:a05:6402:358b:b0:643:ab7:2e7b with SMTP id 4fb4d7f45d1cf-645559f9dd0mr38694702a12.0.1764676340740;
        Tue, 02 Dec 2025 03:52:20 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf5702200011ee99ed0f378a51.dip0.t-ipconnect.de. [2003:cf:5702:2000:11ee:99ed:f37:8a51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm15206765a12.29.2025.12.02.03.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 03:52:20 -0800 (PST)
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
Subject: [PATCH v2 6/6] tools/testing/selftests/seccomp: test nested listeners
Date: Tue,  2 Dec 2025 12:51:58 +0100
Message-ID: <20251202115200.110646-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com>
References: <20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com>
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


