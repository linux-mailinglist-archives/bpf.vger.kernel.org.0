Return-Path: <bpf+bounces-60638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6520AD9831
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 00:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDCD3BEFDB
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DBE28F92E;
	Fri, 13 Jun 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtNRUVqz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C628D8C0;
	Fri, 13 Jun 2025 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749853464; cv=none; b=FFgCwJ6nyueEZJr6tf0tGuZVLMyTIqrH4zPBxa5a3UkOQgpiC8XNFrh0LlCMAD2YJU3UhcJI/sckGyvs4+T39V4aHbi1aM7ImjwgwLFYrUuo5aCVbGOziwgBJLPN7rl/X3zkg8K7T40PDVy+IYuCPAnt1UZzX+J5Zm58BGobCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749853464; c=relaxed/simple;
	bh=pJpq6WgJAI482SHpifEvr0r2FDOrpAjOI+DwqUg2LPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxnGXgmebmXiSt95xqzdkhRGy+1ctVmdir3fN26yH5/S+aAo5nOsEP9bM5B2Ba/txrrX+GIaZ1PrhVTT/JVqMxnqryZ+urylrW/dRrDxKse/aTNOriRzx2zmPakIAcfASRf8kcFCk16BwPfsgPrjVWwp8BTVrPwnjf4buNRxxvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtNRUVqz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23508d30142so29449985ad.0;
        Fri, 13 Jun 2025 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749853462; x=1750458262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lt3U6y/+JmxHzUN7uoxunMQEvFXVS9EFkG69c+eLzTQ=;
        b=ZtNRUVqzVRUR/koRe3xrTm36fQBAUAYWJ0mXKB6KNVsjmDO6iWpIRxW4/kHNZ65rut
         vDPUePvP8lDwjb0ZrT0TWNoPozrYyEffT1bYJX7D96KfkMk2MZeRh91zwiOeySBKXnaZ
         llIMv1bSMjKpd+Kke31oyrrDqYvTj6aRPrCwiYaYdY1RVIPHj5x9qJoMTMjkrPL0E32N
         aKsl0uOuYYPoNVJ+sHGAIFdGBoG2lmsPSBQdpO/7TkPBG7ZfZn++ZaxtqcVcLSQ9AyL5
         dnxJK9IHDTpeCQYqiBaTfXf/YP+0mhVeIR5soEr93pDocSikFyPYfxWp8EpAgGNC39bW
         dizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749853462; x=1750458262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lt3U6y/+JmxHzUN7uoxunMQEvFXVS9EFkG69c+eLzTQ=;
        b=kwFvh/Rnc4fhxL+T6IK6uQU51XGbdRg1Daq7Ugi7erCAO0JXUyyVXnG6RoU4eipYo7
         cRHaXuLFAUgmVoWlsiWtyl/MiECznC4lv5+zJGJxtmhycPEkjrUk7/axBLk3C+TZKwB5
         Q48wLoKDqooy6pS2ztNwPZpMuDtCdpZt6ju1TBY8rZFuhZSl/M8/417Lf+fcg6Pu6CYB
         8oYr14jHUqBrlmGpw3tmB3hjcmU4gJj8syKr5owyVXJUOcE6i5o/jpKa/fVAv7FC2K7L
         GIUaLY30gSXegDKlBi7YAkZnjPUu5cO2EuJ65YayoLZNG/qVQdn+cDSUNzCUdAH4SfNE
         A3iA==
X-Forwarded-Encrypted: i=1; AJvYcCU67q9yTZc8UbqnsbEifJynjmT3GFKQLdxJ6c2M25ASMuFFsIbOaUfRWJexkYOlSSyel+4=@vger.kernel.org, AJvYcCVH/BiUhe3+lJ26uv0QzT6D7O7CXsBmpRPrdRk/SqSQS/jud47abfqLbiWJdiksMxZ9I5nB1t4G@vger.kernel.org, AJvYcCX84vu9md6whvkPO9g2ubjRUf/m+UwK8ebjgw2XyQEfip2TrotGluKIl286tOqifGW6CDmh+t+vkaeRM69q6ggHXuGmfVF0@vger.kernel.org, AJvYcCXGbttlndG0rUulp3EvkLiddvW7LAXTan8JbCM8b/Mi33weWXzCI2xFzfNgW9i++xJFBBmabHTnqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylaPR2PV9LKpV74OB+NGQNZhHrooYZm3uXRCDom1jfmaCATSE5
	TVHce39HQKRLYjWovd1qkZ+ruqZhLy2eGznwwen+Yh9115CVfvPkNAo=
X-Gm-Gg: ASbGnctYaUyBxip9C9M9DF1HFv4i+Z75RfBhyBSqTZfHfw1meqB4R9pU9tYZu0VHIJ4
	6NpKjGF7OAb8kzA1zVorTxrbJVk20X1yR9gUHkdGVMCE5Q2PPn1Ct4C/riImG4nk36RrTR7dYl/
	hPo4v+Ps1xVAs5nC15ycYjfkrLAZylzA2Sq4dCXOOiqlr7BCrtwG28ipQ21ctj5nwGrCf4OeGxN
	OfST8kXS57FyJJxsJ8HBhc3CXsC+JM4qn+pFsKLYIa2767jyKRG7DDgaT2BYiCNuiarbqn9GshX
	vieQU85I7i0MONe75oFdPmYdXvt1iVfQ5euhULg6tjXTk8bY8g==
X-Google-Smtp-Source: AGHT+IHIhACHw0LhVygNM9iTKkSxUTpqQXQGvorcToKKulBQayFZgCYRh+4G3kEhRaIxFXUBokliXA==
X-Received: by 2002:a17:903:40cc:b0:235:ea29:28da with SMTP id d9443c01a7336-2366affb408mr13925635ad.17.1749853461858;
        Fri, 13 Jun 2025 15:24:21 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dfdb9a0sm19840615ad.239.2025.06.13.15.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 15:24:21 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 bpf-next 4/4] selftest: bpf: Add test for BPF LSM on unix_may_send().
Date: Fri, 13 Jun 2025 15:22:16 -0700
Message-ID: <20250613222411.1216170-5-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613222411.1216170-1-kuni1840@gmail.com>
References: <20250613222411.1216170-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

This test performs the following for all AF_UNIX socket types to
demonstrate how we can inspect each struct file passed via SCM_RIGHTS.

  1. Create a socket pair (sender and receiver)
  2. Send the receiver's fd from the sender to the receiver
  3. Receive the fd
  4. Attach a BPF LSM prog that forbids self-reference SCM_RIGHTS
  5. Send the receiver's fd from the sender to the receiver
  6. Check if sendmsg() fails with -EPERM
  7. Detach the LSM prog

How to run:

  # make -C tools/testing/selftests/bpf/
  # ./tools/testing/selftests/bpf/test_progs -t lsm_unix_may_send
  ...
  #182/1   lsm_unix_may_send/SOCK_STREAM:OK
  #182/2   lsm_unix_may_send/SOCK_DGRAM:OK
  #182/3   lsm_unix_may_send/SOCK_SEQPACKET:OK
  #182     lsm_unix_may_send:OK
  Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../bpf/prog_tests/lsm_unix_may_send.c        | 168 ++++++++++++++++++
 .../selftests/bpf/progs/lsm_unix_may_send.c   |  83 +++++++++
 2 files changed, 251 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_unix_may_send.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_unix_may_send.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_unix_may_send.c b/tools/testing/selftests/bpf/prog_tests/lsm_unix_may_send.c
new file mode 100644
index 000000000000..60217e5c4ed4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_unix_may_send.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 Google LLC */
+
+#include "test_progs.h"
+#include "lsm_unix_may_send.skel.h"
+
+#define MSG_HELLO "Hello"
+#define MSG_WORLD "World"
+#define MSG_LEN 5
+
+struct scm_rights {
+	struct cmsghdr cmsghdr;
+	int fd;
+};
+
+static int send_fd(int sender_fd, int receiver_fd, bool lsm_attached)
+{
+	struct scm_rights cmsg = {};
+	struct msghdr msg = {};
+	struct iovec iov = {};
+	int ret;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = &cmsg;
+	msg.msg_controllen = CMSG_SPACE(sizeof(cmsg.fd));
+
+	iov.iov_base = MSG_HELLO;
+	iov.iov_len = MSG_LEN;
+
+	cmsg.cmsghdr.cmsg_len = CMSG_LEN(sizeof(cmsg.fd));
+	cmsg.cmsghdr.cmsg_level = SOL_SOCKET;
+	cmsg.cmsghdr.cmsg_type = SCM_RIGHTS;
+	cmsg.fd = receiver_fd;
+
+	/* sending "Hello" with the receiver's fd. */
+	ret = sendmsg(sender_fd, &msg, 0);
+
+	if (lsm_attached) {
+		if (!ASSERT_EQ(ret, -1, "sendmsg(Hello)") ||
+		    !ASSERT_EQ(errno, EPERM, "sendmsg(Hello) errno"))
+			return -EINVAL;
+	} else {
+		if (!ASSERT_EQ(ret, MSG_LEN, "sendmsg(Hello)"))
+			return -EINVAL;
+	}
+
+	/* sending "World" without SCM_RIGHTS. */
+	ret = send(sender_fd, MSG_WORLD, MSG_LEN, 0);
+	if (!ASSERT_EQ(ret, MSG_LEN, "sendmsg(World)"))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int recv_fd(int receiver_fd, bool lsm_attached)
+{
+	struct scm_rights cmsg = {};
+	struct msghdr msg = {};
+	char buf[MSG_LEN] = {};
+	struct iovec iov = {};
+	int ret;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = &cmsg;
+	msg.msg_controllen = CMSG_SPACE(sizeof(cmsg.fd));
+
+	iov.iov_base = buf;
+	iov.iov_len = sizeof(buf);
+
+	/* LSM is expected to drop "Hello" with the receiver's fd */
+	if (lsm_attached)
+		goto no_hello;
+
+	ret = recvmsg(receiver_fd, &msg, 0);
+	if (!ASSERT_EQ(ret, MSG_LEN, "recvmsg(Hello) length") ||
+	    !ASSERT_STRNEQ(buf, MSG_HELLO, MSG_LEN, "recvmsg(Hello) data"))
+		return -EINVAL;
+
+	if (!ASSERT_OK_PTR(CMSG_FIRSTHDR(&msg), "cmsg sent") ||
+	    !ASSERT_EQ(cmsg.cmsghdr.cmsg_len, CMSG_LEN(sizeof(cmsg.fd)), "cmsg_len") ||
+	    !ASSERT_EQ(cmsg.cmsghdr.cmsg_level, SOL_SOCKET, "cmsg_level") ||
+	    !ASSERT_EQ(cmsg.cmsghdr.cmsg_type, SCM_RIGHTS, "cmsg_type"))
+		return -EINVAL;
+
+	/* Double-check if the fd is of the receiver itself. */
+	receiver_fd = cmsg.fd;
+
+	memset(buf, 0, sizeof(buf));
+
+no_hello:
+	ret = recv(receiver_fd, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(ret, MSG_LEN, "recvmsg(World) length") ||
+	    !ASSERT_STRNEQ(buf, MSG_WORLD, MSG_LEN, "recvmsg(World) data"))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void test_scm_rights(struct lsm_unix_may_send *skel, int type)
+{
+	struct bpf_link *link;
+	int socket_fds[2];
+	int err;
+
+	err = socketpair(AF_UNIX, type, 0, socket_fds);
+	if (!ASSERT_EQ(err, 0, "socketpair"))
+		return;
+
+	err = send_fd(socket_fds[0], socket_fds[1], false);
+	if (err)
+		goto close;
+
+	err = recv_fd(socket_fds[1], false);
+	if (err)
+		goto close;
+
+	link = bpf_program__attach_lsm(skel->progs.unix_may_send_filter);
+	if (!ASSERT_OK_PTR(link, "attach lsm"))
+		goto close;
+
+	err = send_fd(socket_fds[0], socket_fds[1], true);
+	if (err)
+		goto detach;
+
+	recv_fd(socket_fds[1], true);
+detach:
+	err = bpf_link__destroy(link);
+	ASSERT_EQ(err, 0, "detach lsm");
+close:
+	close(socket_fds[0]);
+	close(socket_fds[1]);
+}
+
+struct sk_type {
+	char name[16];
+	int type;
+} sk_types[] = {
+	{
+		.name = "SOCK_STREAM",
+		.type = SOCK_STREAM,
+	},
+	{
+		.name = "SOCK_DGRAM",
+		.type = SOCK_DGRAM,
+	},
+	{
+		.name = "SOCK_SEQPACKET",
+		.type = SOCK_SEQPACKET,
+	},
+};
+
+void test_lsm_unix_may_send(void)
+{
+	struct lsm_unix_may_send *skel;
+	int i;
+
+	skel = lsm_unix_may_send__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "load skel"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(sk_types); i++)
+		if (test__start_subtest(sk_types[i].name))
+			test_scm_rights(skel, sk_types[i].type);
+
+	lsm_unix_may_send__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_unix_may_send.c b/tools/testing/selftests/bpf/progs/lsm_unix_may_send.c
new file mode 100644
index 000000000000..8eb2c9532a7d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_unix_may_send.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 Google LLC */
+
+#include <vmlinux.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+#define EPERM 1
+
+#define FMODE_PATH	(1 << 14)
+#define S_IFMT		00170000
+#define S_IFSOCK	0140000
+#define S_ISSOCK(mode)	(((mode) & S_IFMT) == S_IFSOCK)
+
+#define AF_UNIX		1
+
+static struct inode *file_inode(struct file *filp)
+{
+	return bpf_core_cast(filp->f_inode, struct inode);
+}
+
+static struct socket *SOCKET_I(struct inode *inode)
+{
+	return bpf_core_cast(&container_of(inode, struct socket_alloc, vfs_inode)->socket,
+			     struct socket);
+}
+
+/* mostly same with unix_get_socket() in net/unix/garbage.c */
+static struct sock *unix_get_socket(struct file *filp)
+{
+	struct socket *sock;
+	struct inode *inode;
+
+	if (filp->f_mode & FMODE_PATH)
+		return NULL;
+
+	inode = file_inode(filp);
+	if (!inode)
+		return NULL;
+
+	if (!S_ISSOCK(inode->i_mode))
+		return NULL;
+
+	sock = SOCKET_I(inode);
+	if (!sock || !sock->ops || sock->ops->family != AF_UNIX)
+		return NULL;
+
+	return sock->sk;
+}
+
+SEC("lsm/unix_may_send")
+int BPF_PROG(unix_may_send_filter,
+	     struct sock *sk, struct sock *other, struct sk_buff *skb)
+{
+	struct unix_skb_parms *cb;
+	struct scm_fp_list *fpl;
+	int i;
+
+	if (!skb)
+		return 0;
+
+	cb = bpf_core_cast(skb->cb, struct unix_skb_parms);
+	if (!cb->fp)
+		return 0;
+
+	fpl = bpf_core_cast(cb->fp, struct scm_fp_list);
+
+	for (i = 0; i < fpl->count && i < ARRAY_SIZE(fpl->fp); i++) {
+		struct file *filp;
+
+		filp = bpf_core_cast(fpl->fp[i], struct file);
+
+		/* self-reference is the simplest case that requires GC */
+		if (unix_get_socket(filp) == other)
+			return -EPERM;
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.49.0


