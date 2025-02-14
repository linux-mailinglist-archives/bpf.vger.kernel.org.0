Return-Path: <bpf+bounces-51504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20063A3536D
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C059816DF74
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666786330;
	Fri, 14 Feb 2025 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGT1kpi/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A603596D;
	Fri, 14 Feb 2025 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494915; cv=none; b=f1rX2OGeslNvNOGGjLVUAi1S9zHyb/XUETl2uXbJBAc3lRMddh/72uZrRzADv9l5kIfDGEfGyp8knQ8l1FlwIiDFNtS5awTI47fU0hbogd9Snj1by9RqE00lXTzmAvWrDZFgeVfQ5CG8CNmUsBq7wf0Bprlp8Kqi5EEa1JylOls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494915; c=relaxed/simple;
	bh=8wVc8kQACvuH7dpMqmuA9pYOlwEvpcbGJRrrHijufWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L1+KQgpRHBpG8DKG6Nqi/ueqZSNnQ1otGMYVMuFclJZ6MA6DLuSA/dX5YRj12pMDSJIll6uQmTYSPjFd+SKlWUURWfgyPKly6AJpD8ClVe7VrDkXK7Jb0cd0iqndigwoq52bS89gjfvI3pr9b1xvzTmJaFVMTSfbRvO/1jW2Qy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGT1kpi/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220e6028214so16620075ad.0;
        Thu, 13 Feb 2025 17:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494913; x=1740099713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI4DNKaq4drIljj+cCqk5+/yFYwlzlF9id7t8XUb57Y=;
        b=FGT1kpi/7B694/kL7XJrpIfDZvvx8tHsaihDVFz0v6LnaGFa3Zdv1CfoFDkDy08G47
         KSBmu67LVQsIKLzpGZthmIYuXhC6Chaxxc6Ngw6kAyT+CxoMrJ/ORvodLgcVBNJ0x0UG
         1gqEvSlRjzwdfkmpKrIkLiebkmidcNByQQC9lVhTANqOVq5//B0vrqpWH4rSwiCKXQFt
         cI++HILY2hGZGIuaZGeWNZ993gDTShm75ZjFbWLCaTpNXGLGBYI65xotuc4sUVmowBlj
         B27AoFEaXmvPBnVkBXxs7BfmBe5kpDk8D9k/tzgC/T/FAW87rSF+aOsrbJ961BVgbsiV
         I3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494913; x=1740099713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UI4DNKaq4drIljj+cCqk5+/yFYwlzlF9id7t8XUb57Y=;
        b=RV6sZ1pLTzFae707o6J4gihqI23dRy9kR5CRR/BeRkrzOOkZouaIeE5C7Sb58PE1IR
         6X6Bc6kX4EkKfopNEtMNjvQUZavZY0EBoq17e+0RYUWVB8QuIat6dlkjYma4OvHSh8uC
         xh1VKhzciJYRVnd/V6pL7+Gcm4c7mV2Ckca1HM1ig1QS4eH9Pb7x/1bcDBoGQeIe1K/3
         ChvwdkJ+xl87tF+PskSRHEDZk6Wrn8TXAd3eHpvieOj557b6lHIsd+uLhOOdsMWadZWx
         qRIR4GTHKypCrBnFIzH4X0p3W2Q6ADBMnNfY+x5TsYzGU40bkyAe7cxfe2IeT5M1mnP0
         9CtA==
X-Forwarded-Encrypted: i=1; AJvYcCWLxvMYAoEW2SN7suJQa1UDcmVE4L0ox9a9gj55LsXufNprBxpYn6/4BkXCASEJwq/BBDDhTjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfgn2T6HKHB5evTKg1YB8OxZDB89QeSE4TiIV/DDdqXI7mXR/Y
	NCcBHoMyG63sNuf2yfWU+CvCeVNC+QJxUs1OfGqGWPeAendb6P0i
X-Gm-Gg: ASbGncvVynmvzFmVqQ9++FrtcsYeHRGsEOS2H6nUf16JrS0T6CVfdsDvxk0G/VPS4He
	Z5m2/3io//4IkJ+0wloISjRhtCHkBnAyotVYHIulwS4bDfr4QXH+7DoXWyGb5YbZJiTN2TzjH7k
	TfSb1LjqYuqB096Ve0kJrrSIY8zhdv3qRyALSgTCjioFiHvT8jTazNYPGq786KicrWAFAQQcLoj
	cHbIUmkQFxFRHnKnn08lLF5hiWaMtT6K0XHbRTlwWo16y2Udhuo6QFfOtDrrQR8ONUtkOjdKa8d
	q4zIrQyvZbnzCRz5k6aONQyRGqlvoIFcSnNuLToBPx8z+J3ws184/g==
X-Google-Smtp-Source: AGHT+IF/Q8gX13l5rclhEopD7zyCpCPmWIBISJk81/YhcZwiFLQGQo0j6p5gSOUBjWfY7VIA7Q34ow==
X-Received: by 2002:a17:902:ef09:b0:215:a028:4ed with SMTP id d9443c01a7336-220bdf13ba4mr135620255ad.20.1739494912701;
        Thu, 13 Feb 2025 17:01:52 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm18629565ad.39.2025.02.13.17.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:01:52 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v11 12/12] selftests/bpf: add simple bpf tests in the tx path for timestamping feature
Date: Fri, 14 Feb 2025 09:00:38 +0800
Message-Id: <20250214010038.54131-13-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250214010038.54131-1-kerneljasonxing@gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF program calculates a couple of latency deltas between each tx
timestamping callbacks. It can be used in the real world to diagnose
the kernel behaviour in the tx path.

Check the safety issues by accessing a few bpf calls in
bpf_test_access_bpf_calls() which are implemented in the patch 3 and 4.

Check if the bpf timestamping can co-exist with socket timestamping.

There remains a few realistic things[1][2] to highlight:
1. in general a packet may pass through multiple qdiscs. For instance
with bonding or tunnel virtual devices in the egress path.
2. packets may be resent, in which case an ACK might precede a repeat
SCHED and SND.
3. erroneous or malicious peers may also just never send an ACK.

[1]: https://lore.kernel.org/all/67a389af981b0_14e0832949d@willemb.c.googlers.com.notmuch/
[2]: https://lore.kernel.org/all/c329a0c1-239b-4ca1-91f2-cb30b8dd2f6a@linux.dev/

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 .../bpf/prog_tests/net_timestamping.c         | 239 +++++++++++++++++
 .../selftests/bpf/progs/net_timestamping.c    | 248 ++++++++++++++++++
 2 files changed, 487 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/net_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/net_timestamping.c

diff --git a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
new file mode 100644
index 000000000000..dbfd87499b6b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
@@ -0,0 +1,239 @@
+#include <linux/net_tstamp.h>
+#include <sys/time.h>
+#include <linux/errqueue.h>
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "net_timestamping.skel.h"
+
+#define CG_NAME "/net-timestamping-test"
+#define NSEC_PER_SEC    1000000000LL
+
+static const char addr4_str[] = "127.0.0.1";
+static const char addr6_str[] = "::1";
+static struct net_timestamping *skel;
+static const int cfg_payload_len = 30;
+static struct timespec usr_ts;
+static u64 delay_tolerance_nsec = 10000000000; /* 10 seconds */
+int SK_TS_SCHED;
+int SK_TS_TXSW;
+int SK_TS_ACK;
+
+static int64_t timespec_to_ns64(struct timespec *ts)
+{
+	return ts->tv_sec * NSEC_PER_SEC + ts->tv_nsec;
+}
+
+static void validate_key(int tskey, int tstype)
+{
+	static int expected_tskey = -1;
+
+	if (tstype == SCM_TSTAMP_SCHED)
+		expected_tskey = cfg_payload_len - 1;
+
+	ASSERT_EQ(expected_tskey, tskey, "tskey mismatch");
+
+	expected_tskey = tskey;
+}
+
+static void validate_timestamp(struct timespec *cur, struct timespec *prev)
+{
+	int64_t cur_ns, prev_ns;
+
+	cur_ns = timespec_to_ns64(cur);
+	prev_ns = timespec_to_ns64(prev);
+
+	ASSERT_LT(cur_ns - prev_ns, delay_tolerance_nsec, "latency");
+}
+
+static void test_socket_timestamp(struct scm_timestamping *tss, int tstype,
+				  int tskey)
+{
+	static struct timespec prev_ts;
+
+	validate_key(tskey, tstype);
+
+	switch (tstype) {
+	case SCM_TSTAMP_SCHED:
+		validate_timestamp(&tss->ts[0], &usr_ts);
+		SK_TS_SCHED += 1;
+		break;
+	case SCM_TSTAMP_SND:
+		validate_timestamp(&tss->ts[0], &prev_ts);
+		SK_TS_TXSW += 1;
+		break;
+	case SCM_TSTAMP_ACK:
+		validate_timestamp(&tss->ts[0], &prev_ts);
+		SK_TS_ACK += 1;
+		break;
+	}
+
+	prev_ts = tss->ts[0];
+}
+
+static void test_recv_errmsg_cmsg(struct msghdr *msg)
+{
+	struct sock_extended_err *serr = NULL;
+	struct scm_timestamping *tss = NULL;
+	struct cmsghdr *cm;
+
+	for (cm = CMSG_FIRSTHDR(msg);
+	     cm && cm->cmsg_len;
+	     cm = CMSG_NXTHDR(msg, cm)) {
+		if (cm->cmsg_level == SOL_SOCKET &&
+		    cm->cmsg_type == SCM_TIMESTAMPING) {
+			tss = (void *)CMSG_DATA(cm);
+		} else if ((cm->cmsg_level == SOL_IP &&
+			    cm->cmsg_type == IP_RECVERR) ||
+			   (cm->cmsg_level == SOL_IPV6 &&
+			    cm->cmsg_type == IPV6_RECVERR) ||
+			   (cm->cmsg_level == SOL_PACKET &&
+			    cm->cmsg_type == PACKET_TX_TIMESTAMP)) {
+			serr = (void *)CMSG_DATA(cm);
+			ASSERT_EQ(serr->ee_origin, SO_EE_ORIGIN_TIMESTAMPING,
+				  "cmsg type");
+		}
+
+		if (serr && tss)
+			test_socket_timestamp(tss, serr->ee_info,
+					      serr->ee_data);
+	}
+}
+
+static bool socket_recv_errmsg(int fd)
+{
+	static char ctrl[1024 /* overprovision*/];
+	char data[cfg_payload_len];
+	static struct msghdr msg;
+	struct iovec entry;
+	int n = 0;
+
+	memset(&msg, 0, sizeof(msg));
+	memset(&entry, 0, sizeof(entry));
+	memset(ctrl, 0, sizeof(ctrl));
+
+	entry.iov_base = data;
+	entry.iov_len = cfg_payload_len;
+	msg.msg_iov = &entry;
+	msg.msg_iovlen = 1;
+	msg.msg_name = NULL;
+	msg.msg_namelen = 0;
+	msg.msg_control = ctrl;
+	msg.msg_controllen = sizeof(ctrl);
+
+	n = recvmsg(fd, &msg, MSG_ERRQUEUE);
+	if (n == -1)
+		ASSERT_EQ(errno, EAGAIN, "recvmsg MSG_ERRQUEUE");
+
+	if (n >= 0)
+		test_recv_errmsg_cmsg(&msg);
+
+	return n == -1;
+}
+
+static void test_socket_timestamping(int fd)
+{
+	while (!socket_recv_errmsg(fd));
+
+	ASSERT_EQ(SK_TS_SCHED, 1, "SCM_TSTAMP_SCHED");
+	ASSERT_EQ(SK_TS_TXSW, 1, "SCM_TSTAMP_SND");
+	ASSERT_EQ(SK_TS_ACK, 1, "SCM_TSTAMP_ACK");
+
+	SK_TS_SCHED = 0;
+	SK_TS_TXSW = 0;
+	SK_TS_ACK = 0;
+}
+
+static void test_tcp(int family, bool enable_socket_timestamping)
+{
+	struct net_timestamping__bss *bss;
+	char buf[cfg_payload_len];
+	int sfd = -1, cfd = -1;
+	unsigned int sock_opt;
+	struct netns_obj *ns;
+	int cg_fd;
+	int ret;
+
+	cg_fd = test__join_cgroup(CG_NAME);
+	if (!ASSERT_OK_FD(cg_fd, "join cgroup"))
+		return;
+
+	ns = netns_new("net_timestamping_ns", true);
+	if (!ASSERT_OK_PTR(ns, "create ns"))
+		goto out;
+
+	skel = net_timestamping__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skel"))
+		goto out;
+
+	if (!ASSERT_OK(net_timestamping__attach(skel), "attach skel"))
+		goto out;
+
+	skel->links.skops_sockopt =
+		bpf_program__attach_cgroup(skel->progs.skops_sockopt, cg_fd);
+	if (!ASSERT_OK_PTR(skel->links.skops_sockopt, "attach cgroup"))
+		goto out;
+
+	bss = skel->bss;
+	memset(bss, 0, sizeof(*bss));
+
+	skel->bss->monitored_pid = getpid();
+
+	sfd = start_server(family, SOCK_STREAM,
+			   family == AF_INET6 ? addr6_str : addr4_str, 0, 0);
+	if (!ASSERT_OK_FD(sfd, "start_server"))
+		goto out;
+
+	cfd = connect_to_fd(sfd, 0);
+	if (!ASSERT_OK_FD(cfd, "connect_to_fd_server"))
+		goto out;
+
+	if (enable_socket_timestamping) {
+		sock_opt = SOF_TIMESTAMPING_SOFTWARE |
+			   SOF_TIMESTAMPING_OPT_ID |
+			   SOF_TIMESTAMPING_TX_SCHED |
+			   SOF_TIMESTAMPING_TX_SOFTWARE |
+			   SOF_TIMESTAMPING_TX_ACK;
+		ret = setsockopt(cfd, SOL_SOCKET, SO_TIMESTAMPING,
+				 (char *) &sock_opt, sizeof(sock_opt));
+		if (!ASSERT_OK(ret, "setsockopt SO_TIMESTAMPING"))
+			goto out;
+
+		ret = clock_gettime(CLOCK_REALTIME, &usr_ts);
+		if (!ASSERT_OK(ret, "get user time"))
+			goto out;
+	}
+
+	ret = write(cfd, buf, sizeof(buf));
+	if (!ASSERT_EQ(ret, sizeof(buf), "send to server"))
+		goto out;
+
+	if (enable_socket_timestamping)
+		test_socket_timestamping(cfd);
+
+	ASSERT_EQ(bss->nr_active, 1, "nr_active");
+	ASSERT_EQ(bss->nr_snd, 2, "nr_snd");
+	ASSERT_EQ(bss->nr_sched, 1, "nr_sched");
+	ASSERT_EQ(bss->nr_txsw, 1, "nr_txsw");
+	ASSERT_EQ(bss->nr_ack, 1, "nr_ack");
+
+out:
+	if (sfd >= 0)
+		close(sfd);
+	if (cfd >= 0)
+		close(cfd);
+	net_timestamping__destroy(skel);
+	netns_free(ns);
+	close(cg_fd);
+}
+
+void test_net_timestamping(void)
+{
+	if (test__start_subtest("INET4: bpf timestamping"))
+		test_tcp(AF_INET, false);
+	if (test__start_subtest("INET4: bpf and socket timestamping"))
+		test_tcp(AF_INET, true);
+	if (test__start_subtest("INET6: bpf timestamping"))
+		test_tcp(AF_INET6, false);
+	if (test__start_subtest("INET6: bpf and socket timestamping"))
+		test_tcp(AF_INET6, true);
+}
diff --git a/tools/testing/selftests/bpf/progs/net_timestamping.c b/tools/testing/selftests/bpf/progs/net_timestamping.c
new file mode 100644
index 000000000000..ab2ed2ea5822
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/net_timestamping.c
@@ -0,0 +1,248 @@
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+#include <errno.h>
+
+__u32 monitored_pid = 0;
+
+int nr_active;
+int nr_snd;
+int nr_passive;
+int nr_sched;
+int nr_txsw;
+int nr_ack;
+
+struct sk_stg {
+	__u64 sendmsg_ns;	/* record ts when sendmsg is called */
+};
+
+struct sk_tskey {
+	u64 cookie;
+	u32 tskey;
+};
+
+struct delay_info {
+	u64 sendmsg_ns;		/* record ts when sendmsg is called */
+	u32 sched_delay;	/* SCHED_OPT_CB - sendmsg_ns */
+	u32 sw_snd_delay;	/* SW_OPT_CB - SCHED_OPT_CB */
+	u32 ack_delay;		/* ACK_OPT_CB - SW_OPT_CB */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct sk_stg);
+} sk_stg_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, struct sk_tskey);
+	__type(value, struct delay_info);
+	__uint(max_entries, 1024);
+} time_map SEC(".maps");
+
+static u64 delay_tolerance_nsec = 10000000000; /* 10 second as an example */
+
+extern int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops, u64 flags) __ksym;
+
+static int bpf_test_sockopt(void *ctx, const struct sock *sk, int expected)
+{
+	int tmp, new = SK_BPF_CB_TX_TIMESTAMPING;
+	int opt = SK_BPF_CB_FLAGS;
+	int level = SOL_SOCKET;
+
+	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)) != expected)
+		return 1;
+
+	if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) != expected ||
+	    (!expected && tmp != new))
+		return 1;
+
+	return 0;
+}
+
+static bool bpf_test_access_sockopt(void *ctx, const struct sock *sk)
+{
+	if (bpf_test_sockopt(ctx, sk, -EOPNOTSUPP))
+		return true;
+	return false;
+}
+
+static bool bpf_test_access_load_hdr_opt(struct bpf_sock_ops *skops)
+{
+	u8 opt[3] = {0};
+	int load_flags = 0;
+	int ret;
+
+	ret = bpf_load_hdr_opt(skops, opt, sizeof(opt), load_flags);
+	if (ret != -EOPNOTSUPP)
+		return true;
+
+	return false;
+}
+
+static bool bpf_test_access_cb_flags_set(struct bpf_sock_ops *skops)
+{
+	int ret;
+
+	ret = bpf_sock_ops_cb_flags_set(skops, 0);
+	if (ret != -EOPNOTSUPP)
+		return true;
+
+	return false;
+}
+
+/* In the timestamping callbacks, we're not allowed to call the following
+ * BPF CALLs for the safety concern. Return false if expected.
+ */
+static bool bpf_test_access_bpf_calls(struct bpf_sock_ops *skops,
+				      const struct sock *sk)
+{
+	if (bpf_test_access_sockopt(skops, sk))
+		return true;
+
+	if (bpf_test_access_load_hdr_opt(skops))
+		return true;
+
+	if (bpf_test_access_cb_flags_set(skops))
+		return true;
+
+	return false;
+}
+
+static bool bpf_test_delay(struct bpf_sock_ops *skops, const struct sock *sk)
+{
+	struct bpf_sock_ops_kern *skops_kern;
+	u64 timestamp = bpf_ktime_get_ns();
+	struct skb_shared_info *shinfo;
+	struct delay_info dinfo = {0};
+	struct sk_tskey key = {0};
+	struct delay_info *val;
+	struct sk_buff *skb;
+	struct sk_stg *stg;
+	u64 prior_ts, delay;
+
+	if (bpf_test_access_bpf_calls(skops, sk))
+		return false;
+
+	skops_kern = bpf_cast_to_kern_ctx(skops);
+	skb = skops_kern->skb;
+	shinfo = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);
+
+	key.cookie = bpf_get_socket_cookie(skops);
+	if (!key.cookie)
+		return false;
+
+	if (skops->op == BPF_SOCK_OPS_TS_SND_CB) {
+		stg = bpf_sk_storage_get(&sk_stg_map, (void *)sk, 0, 0);
+		if (!stg)
+			return false;
+		dinfo.sendmsg_ns = stg->sendmsg_ns;
+		bpf_sock_ops_enable_tx_tstamp(skops_kern, 0);
+		key.tskey = shinfo->tskey;
+		if (!key.tskey)
+			return false;
+		bpf_map_update_elem(&time_map, &key, &dinfo, BPF_ANY);
+		return true;
+	}
+
+	key.tskey = shinfo->tskey;
+	if (!key.tskey)
+		return false;
+
+	val = bpf_map_lookup_elem(&time_map, &key);
+	if (!val)
+		return false;
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
+		val->sched_delay = timestamp - val->sendmsg_ns;
+		delay = val->sched_delay;
+		break;
+	case BPF_SOCK_OPS_TS_SW_OPT_CB:
+		prior_ts = val->sched_delay + val->sendmsg_ns;
+		val->sw_snd_delay = timestamp - prior_ts;
+		delay = val->sw_snd_delay;
+		break;
+	case BPF_SOCK_OPS_TS_ACK_OPT_CB:
+		prior_ts = val->sw_snd_delay + val->sched_delay + val->sendmsg_ns;
+		val->ack_delay = timestamp - prior_ts;
+		delay = val->ack_delay;
+		break;
+	}
+
+	if (delay >= delay_tolerance_nsec)
+		return false;
+
+	/* Since it's the last one, remove from the map after latency check */
+	if (skops->op == BPF_SOCK_OPS_TS_ACK_OPT_CB)
+		bpf_map_delete_elem(&time_map, &key);
+
+	return true;
+}
+
+SEC("fentry/tcp_sendmsg_locked")
+int BPF_PROG(trace_tcp_sendmsg_locked, struct sock *sk, struct msghdr *msg,
+	     size_t size)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	u64 timestamp = bpf_ktime_get_ns();
+	u32 flag = sk->sk_bpf_cb_flags;
+	struct sk_stg *stg;
+
+	if (pid != monitored_pid || !flag)
+		return 0;
+
+	stg = bpf_sk_storage_get(&sk_stg_map, sk, 0,
+				 BPF_SK_STORAGE_GET_F_CREATE);
+	if (!stg)
+		return 0;
+
+	stg->sendmsg_ns = timestamp;
+	nr_snd += 1;
+	return 0;
+}
+
+SEC("sockops")
+int skops_sockopt(struct bpf_sock_ops *skops)
+{
+	struct bpf_sock *bpf_sk = skops->sk;
+	const struct sock *sk;
+
+	if (!bpf_sk)
+		return 1;
+
+	sk = (struct sock *)bpf_skc_to_tcp_sock(bpf_sk);
+	if (!sk)
+		return 1;
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
+		nr_active += !bpf_test_sockopt(skops, sk, 0);
+		break;
+	case BPF_SOCK_OPS_TS_SND_CB:
+		if (bpf_test_delay(skops, sk))
+			nr_snd += 1;
+		break;
+	case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
+		if (bpf_test_delay(skops, sk))
+			nr_sched += 1;
+		break;
+	case BPF_SOCK_OPS_TS_SW_OPT_CB:
+		if (bpf_test_delay(skops, sk))
+			nr_txsw += 1;
+		break;
+	case BPF_SOCK_OPS_TS_ACK_OPT_CB:
+		if (bpf_test_delay(skops, sk))
+			nr_ack += 1;
+		break;
+	}
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


