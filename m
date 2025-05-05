Return-Path: <bpf+bounces-57391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA85AA9EA6
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 00:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A515B1A81306
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 22:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6552274FF8;
	Mon,  5 May 2025 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ABdbB6Cs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3439F129A78;
	Mon,  5 May 2025 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482437; cv=none; b=IKkJi5p4807hHpHlLsXOh6axz/O427eYxT8YQitD0ZFyhKhwZEcyDWgBfqOtiafh3uaY1FhuJhS8Xj+grS87suNHrIHpFaCRFXV+8c9YTRusTaqofwburAZP38SynUCi3fs1CDH4IMlB7fIG3FtXaRVbidcsbDjbEMge1Q5dd7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482437; c=relaxed/simple;
	bh=ZtzVn3vhfHHrZyvMML07cCet17koomvjLqult12hZfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8qO8/6A6c1xKat2LpblLoBFr1AePHCQrbphASSCzwhXQg4j7vtd0mtNcP7OHqafkElnloSFM50ZgFDhZPS1p9JsaYMCIGcr8UsgFZ+iTwrJadWyH+O/x1l4z+keWzopL7CExng1FiOPw29IDRjGQ1I/Hrmg4YrA+0X+G6JzVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ABdbB6Cs; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746482435; x=1778018435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXF8Pa46OdfY42qSofeY7OfevWcwLJJFEHFJJRca7Jk=;
  b=ABdbB6Cs+6GXHbLPNCGqrqKRf4ceO3UjFKDpVYU83/3pcAISpqs3vTgN
   OCw665fyXlbm5hzLAzWwAZy5ReyrzAiptQvvn07EEjT5BWwg3ZxOSrDpG
   GUhZHb3SQyx7ZijAKly/7iBTwYc2YCgZR3LHKsZJUSmtNvkhCQU8iz7Mj
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="719980326"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:00:32 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:20457]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.92:2525] with esmtp (Farcaster)
 id cb57f3a2-fd3a-446b-92da-422b317c23d6; Mon, 5 May 2025 22:00:31 +0000 (UTC)
X-Farcaster-Flow-ID: cb57f3a2-fd3a-446b-92da-422b317c23d6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 22:00:29 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 22:00:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
	"Stanislav Fomichev" <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=
	<mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
	"Ondrej Mosnacek" <omosnace@redhat.com>, Casey Schaufler
	<casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>
Subject: [PATCH v1 bpf-next 5/5] selftest: bpf: Add test for bpf_unix_scrub_fds().
Date: Mon, 5 May 2025 14:56:50 -0700
Message-ID: <20250505215802.48449-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505215802.48449-1-kuniyu@amazon.com>
References: <20250505215802.48449-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This test performs the following for all AF_UNIX socket types

  1. Create a socket pair (sender and receiver)
  2. Send the receiver's fd from the sender to the receiver
  3. Receive the fd
  4. Attach a BPF LSM prog that scrubs SCM_RIGHTS fds
  5. Send the receiver's fd from the sender to the receiver
  6. Check if the fd was scrubbed
  7. Detach the LSM prog

How to run:

  # make -C tools/testing/selftests/bpf/
  # ./tools/testing/selftests/bpf/test_progs -t lsm_unix_may_send
  ...
  #175/1   lsm_unix_may_send/SOCK_STREAM:OK
  #175/2   lsm_unix_may_send/SOCK_DGRAM:OK
  #175/3   lsm_unix_may_send/SOCK_SEQPACKET:OK
  #175     lsm_unix_may_send:OK
  Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 .../bpf/prog_tests/lsm_unix_may_send.c        | 160 ++++++++++++++++++
 .../selftests/bpf/progs/lsm_unix_may_send.c   |  30 ++++
 2 files changed, 190 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_unix_may_send.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_unix_may_send.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_unix_may_send.c b/tools/testing/selftests/bpf/prog_tests/lsm_unix_may_send.c
new file mode 100644
index 000000000000..50b2547e63cf
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_unix_may_send.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates. */
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
+static int send_fd(int sender_fd, int receiver_fd)
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
+	ret = sendmsg(sender_fd, &msg, 0);
+	if (!ASSERT_EQ(ret, MSG_LEN, "sendmsg(Hello)"))
+		return -EINVAL;
+
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
+	ret = recvmsg(receiver_fd, &msg, 0);
+	if (!ASSERT_EQ(ret, MSG_LEN, "recvmsg(Hello) length") ||
+	    !ASSERT_STRNEQ(buf, MSG_HELLO, MSG_LEN, "recvmsg(Hello) data"))
+		return -EINVAL;
+
+	if (lsm_attached) {
+		if (!ASSERT_ERR_PTR(CMSG_FIRSTHDR(&msg), "cmsg filtered"))
+			return -EINVAL;
+	} else {
+		if (!ASSERT_OK_PTR(CMSG_FIRSTHDR(&msg), "cmsg sent") ||
+		    !ASSERT_EQ(cmsg.cmsghdr.cmsg_len, CMSG_LEN(sizeof(cmsg.fd)), "cmsg_len") ||
+		    !ASSERT_EQ(cmsg.cmsghdr.cmsg_level, SOL_SOCKET, "cmsg_level") ||
+		    !ASSERT_EQ(cmsg.cmsghdr.cmsg_type, SCM_RIGHTS, "cmsg_type"))
+			return -EINVAL;
+
+		receiver_fd = cmsg.fd;
+	}
+
+	memset(buf, 0, sizeof(buf));
+
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
+	err = send_fd(socket_fds[0], socket_fds[1]);
+	if (err)
+		goto close;
+
+	err = recv_fd(socket_fds[1], false);
+	if (err)
+		goto close;
+
+	link = bpf_program__attach_lsm(skel->progs.unix_scrub_scm_rights);
+	if (!ASSERT_OK_PTR(link, "attach lsm"))
+		goto close;
+
+	err = send_fd(socket_fds[0], socket_fds[1]);
+	if (err)
+		goto close;
+
+	err = recv_fd(socket_fds[1], true);
+	if (err)
+		goto close;
+
+	err = bpf_link__destroy(link);
+	ASSERT_EQ(err, 0, "destroy lsm");
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
index 000000000000..c2459ba2c33d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_unix_may_send.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+
+#ifndef EPERM
+#define EPERM 1
+#endif
+
+SEC("lsm/unix_may_send")
+int BPF_PROG(unix_scrub_scm_rights,
+	     struct socket *sock, struct socket *other, struct sk_buff *skb)
+{
+	struct unix_skb_parms *cb;
+
+	if (!skb)
+		return 0;
+
+	cb = (struct unix_skb_parms *)skb->cb;
+	if (!cb->fp)
+		return 0;
+
+	if (bpf_unix_scrub_fds(skb))
+		return -EPERM;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.49.0


