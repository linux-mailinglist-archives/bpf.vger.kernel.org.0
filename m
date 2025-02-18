Return-Path: <bpf+bounces-51810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF22A3925C
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 06:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A406188388C
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F322D1B21AA;
	Tue, 18 Feb 2025 05:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCJqxxg9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2261AF0C2;
	Tue, 18 Feb 2025 05:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854999; cv=none; b=aOvUddYbx0ncJIP2UNu6GR9srYTEFHQGi43Uu5vCHtgKIuHSttz98XPivsOcyXlJOzgrcAtxRzLGk0OgHaWy1TdC7jskX+l4jSushEzBvdzcHpnwzZpxCo0DOsS+KewvFjo5ULDiimr0yfB+lkw4Koq6yZIAWd3lW5jakDLzjfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854999; c=relaxed/simple;
	bh=8wVc8kQACvuH7dpMqmuA9pYOlwEvpcbGJRrrHijufWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UIMp/i2DBV5PhonD19b0XpHEfDigmJ6tdV5OUX63OwFDERz8y3U6UoHrm2hU2Z9/81a9Xvx/5ctRz5oCp1yCUl9NHjVGSEWVSTFOeRP++kNg1/lSLP1Hq6XEzBYkZLzKBDKhqZwPaPvXDUd1SOAcA9y8/hifevK3gvH7+rF5KNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCJqxxg9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fc737aeeb1so2328570a91.3;
        Mon, 17 Feb 2025 21:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854997; x=1740459797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI4DNKaq4drIljj+cCqk5+/yFYwlzlF9id7t8XUb57Y=;
        b=UCJqxxg9w/DIyM3BMcoaGKKKzlg3Mb+E3d3MjDFCSm1/2fcOsiL67/uyeIahgAD9mf
         WqNiB+Ci31cm1BfKU3yCYphFkOKZ5BxM/6I5dyGuALUr/jX5uvImJZxm3z5x1En70xWG
         HXnEtCP8KJY3DJCQ7IJ4qjCnybrii4FqQf7R6fDK6ISJR7i/IOFNMPITxAfY3AHkgJEO
         yJeWIxAIsMAnE+z4EcOGi8vyxdvrEKm4AApVC2wznHwJCxK/89lXl34hynUnHK75DAyz
         2gFU2LHebLv8FNY2pytvxaZq+qZ30S0CU2SV7dlqr71xou+zi4MoUCS+1UtvfZvdDtOL
         +ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854997; x=1740459797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UI4DNKaq4drIljj+cCqk5+/yFYwlzlF9id7t8XUb57Y=;
        b=hmN4hGygEU7DM+RY354DDwo148KNGBdHZ09h2RztDiMWoFqCoqMTfrGFylA4TZUmGE
         SfQnDDUWv80pXU8GVkhHZNlixs8pDUJqp1btxRCujivBG9EIcb4jm+cs6TPOM1fil3+S
         yvsWgpp5hhJmojghbFkXF3qTnJvu2nvs/MhUsvfs9oB0blLM2vNeoAeaGIa7r2lUDHcB
         l+5QpuEO+1UQSuGkIEA0/bNjEzwrlP4STBF2tIV9mFAgzbWINOtum3+Ts5wOe0UksUYn
         d59MVqFHnmaqagSpAq5daVZaSO/xRpbfFsm4nbOwIP17Zno1KCjCM9QvLnyC9bRy8+T9
         Y5qA==
X-Forwarded-Encrypted: i=1; AJvYcCVrd+uDamuKO2KZbree85woP8pQ6MTGOQPKKa9flx91lWmZcEiz+xTGp5BFVqJlkVhQ7L+HykI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNbar6MC41h8M9pitAV8Q4YYd0bI6pUGhsY5E1a3VCx+D44Hba
	xYC0M7Mffj4C20GcOmi0oe+EjzWp0O4D1XTae0xz+0a3ysaFRMdY
X-Gm-Gg: ASbGncv4Qo1SR4YOw/r9SusT+FUKG1EkqeK1q0r8W/O/ElwB3ok1ikdDqg7Q7LPYvB0
	f7WLwtzlTV7zUa/JfXYTzbx6bf/pUz615MdWlZIwp7bW88N6u2Fps93Yt1pxnqWcEQAofclZ9it
	MopUqhUUULL5Vw3lDt/vkC+N5eNY7UPlAZ5FyJD9hpJm8PO/KijsEJFyUYmi5jMAZf9GetJdJNj
	ZMx5JxzP+hPmJ1wZvr1W3w6B2nrGVlmAWvHCWDgU2292IYc4VU9EfhKH28oWmYUcQs0wzE0DEQP
	fTaTXK6v54ywJ03sWWK+3SR1oVLEV6OmhyVe6gNUDtkNngvmYIDfjAxs6iI4W24=
X-Google-Smtp-Source: AGHT+IFQijm+bJDFzTHPBzTifygwiuLWhiOSSoUjoYJ8hcSJekfCaLXDwJ1aNM0/6ydzixMPCgNMWw==
X-Received: by 2002:a05:6a00:244e:b0:730:8d25:4c31 with SMTP id d2e1a72fcca58-7326179d09cmr23937779b3a.8.1739854996832;
        Mon, 17 Feb 2025 21:03:16 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adda5be52f1sm4337938a12.34.2025.02.17.21.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:03:16 -0800 (PST)
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
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v12 12/12] selftests/bpf: add simple bpf tests in the tx path for timestamping feature
Date: Tue, 18 Feb 2025 13:01:25 +0800
Message-Id: <20250218050125.73676-13-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250218050125.73676-1-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
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


