Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E696596A2B
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 09:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiHQHRG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 03:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiHQHRC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 03:17:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43386BCD5
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 00:17:00 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H0NukD031115
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 00:17:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Hkzx1vB93qRPMpqIxhR0perjjQmQy778KyyYs5JcfuE=;
 b=aJJ+y67ZvtkPWAzYf+Ji+WmcRv+8+zp5gvDgDI0HcKEDbWCCG7gCJK66+e4q19B2K7Il
 xRwMmC7LDoL/o2j+omdFwheC03scd8pI0Mpp7K/g5GFj2VEceNzc8fVUPN3WE0Q3W5zK
 341hsms94rCBYOeIRj7DQ8FmjGyKd4KK2tU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0nrf9dxf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 00:17:00 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 17 Aug 2022 00:16:59 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id DF8BB825DE4D; Tue, 16 Aug 2022 23:18:47 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v4 bpf-next 15/15] selftests/bpf: bpf_setsockopt tests
Date:   Tue, 16 Aug 2022 23:18:47 -0700
Message-ID: <20220817061847.4182339-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817061704.4174272-1-kafai@fb.com>
References: <20220817061704.4174272-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tDEejSrLkL802bLkDDSguPQBZlN-8rLt
X-Proofpoint-GUID: tDEejSrLkL802bLkDDSguPQBZlN-8rLt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_04,2022-08-16_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds tests to exercise optnames that are allowed
in bpf_setsockopt().

Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 .../selftests/bpf/prog_tests/setget_sockopt.c | 125 +++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |  31 +-
 .../selftests/bpf/progs/setget_sockopt.c      | 451 ++++++++++++++++++
 3 files changed, 606 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/setget_sockopt=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/setget_sockopt.c

diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/to=
ols/testing/selftests/bpf/prog_tests/setget_sockopt.c
new file mode 100644
index 000000000000..018611e6b248
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <linux/socket.h>
+#include <net/if.h>
+
+#include "test_progs.h"
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+
+#include "setget_sockopt.skel.h"
+
+#define CG_NAME "/setget-sockopt-test"
+
+static const char addr4_str[] =3D "127.0.0.1";
+static const char addr6_str[] =3D "::1";
+static struct setget_sockopt *skel;
+static int cg_fd;
+
+static int create_netns(void)
+{
+	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
+		return -1;
+
+	if (!ASSERT_OK(system("ip link set dev lo up"), "set lo up"))
+		return -1;
+
+	if (!ASSERT_OK(system("ip link add dev binddevtest1 type veth peer name=
 binddevtest2"),
+		       "add veth"))
+		return -1;
+
+	if (!ASSERT_OK(system("ip link set dev binddevtest1 up"),
+		       "bring veth up"))
+		return -1;
+
+	return 0;
+}
+
+static void test_tcp(int family)
+{
+	struct setget_sockopt__bss *bss =3D skel->bss;
+	int sfd, cfd;
+
+	memset(bss, 0, sizeof(*bss));
+
+	sfd =3D start_server(family, SOCK_STREAM,
+			   family =3D=3D AF_INET6 ? addr6_str : addr4_str, 0, 0);
+	if (!ASSERT_GE(sfd, 0, "start_server"))
+		return;
+
+	cfd =3D connect_to_fd(sfd, 0);
+	if (!ASSERT_GE(cfd, 0, "connect_to_fd_server")) {
+		close(sfd);
+		return;
+	}
+	close(sfd);
+	close(cfd);
+
+	ASSERT_EQ(bss->nr_listen, 1, "nr_listen");
+	ASSERT_EQ(bss->nr_connect, 1, "nr_connect");
+	ASSERT_EQ(bss->nr_active, 1, "nr_active");
+	ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
+	ASSERT_EQ(bss->nr_socket_post_create, 2, "nr_socket_post_create");
+	ASSERT_EQ(bss->nr_binddev, 2, "nr_bind");
+}
+
+static void test_udp(int family)
+{
+	struct setget_sockopt__bss *bss =3D skel->bss;
+	int sfd;
+
+	memset(bss, 0, sizeof(*bss));
+
+	sfd =3D start_server(family, SOCK_DGRAM,
+			   family =3D=3D AF_INET6 ? addr6_str : addr4_str, 0, 0);
+	if (!ASSERT_GE(sfd, 0, "start_server"))
+		return;
+	close(sfd);
+
+	ASSERT_GE(bss->nr_socket_post_create, 1, "nr_socket_post_create");
+	ASSERT_EQ(bss->nr_binddev, 1, "nr_bind");
+}
+
+void test_setget_sockopt(void)
+{
+	cg_fd =3D test__join_cgroup(CG_NAME);
+	if (cg_fd < 0)
+		return;
+
+	if (create_netns())
+		goto done;
+
+	skel =3D setget_sockopt__open();
+	if (!ASSERT_OK_PTR(skel, "open skel"))
+		goto done;
+
+	strcpy(skel->rodata->veth, "binddevtest1");
+	skel->rodata->veth_ifindex =3D if_nametoindex("binddevtest1");
+	if (!ASSERT_GT(skel->rodata->veth_ifindex, 0, "if_nametoindex"))
+		goto done;
+
+	if (!ASSERT_OK(setget_sockopt__load(skel), "load skel"))
+		goto done;
+
+	skel->links.skops_sockopt =3D
+		bpf_program__attach_cgroup(skel->progs.skops_sockopt, cg_fd);
+	if (!ASSERT_OK_PTR(skel->links.skops_sockopt, "attach cgroup"))
+		goto done;
+
+	skel->links.socket_post_create =3D
+		bpf_program__attach_cgroup(skel->progs.socket_post_create, cg_fd);
+	if (!ASSERT_OK_PTR(skel->links.socket_post_create, "attach_cgroup"))
+		goto done;
+
+	test_tcp(AF_INET6);
+	test_tcp(AF_INET);
+	test_udp(AF_INET6);
+	test_udp(AF_INET);
+
+done:
+	setget_sockopt__destroy(skel);
+	close(cg_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/=
testing/selftests/bpf/progs/bpf_tracing_net.h
index 98dd2c4815f0..5ebc6dabef84 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -6,13 +6,40 @@
 #define AF_INET6		10
=20
 #define SOL_SOCKET		1
+#define SO_REUSEADDR		2
 #define SO_SNDBUF		7
-#define __SO_ACCEPTCON		(1 << 16)
+#define SO_RCVBUF		8
+#define SO_KEEPALIVE		9
 #define SO_PRIORITY		12
+#define SO_REUSEPORT		15
+#define SO_RCVLOWAT		18
+#define SO_BINDTODEVICE		25
+#define SO_MARK			36
+#define SO_MAX_PACING_RATE	47
+#define SO_BINDTOIFINDEX	62
+#define SO_TXREHASH		74
+#define __SO_ACCEPTCON		(1 << 16)
+
+#define IP_TOS			1
+
+#define IPV6_TCLASS		67
+#define IPV6_AUTOFLOWLABEL	70
=20
 #define SOL_TCP			6
+#define TCP_NODELAY		1
+#define TCP_MAXSEG		2
+#define TCP_KEEPIDLE		4
+#define TCP_KEEPINTVL		5
+#define TCP_KEEPCNT		6
+#define TCP_SYNCNT		7
+#define TCP_WINDOW_CLAMP	10
 #define TCP_CONGESTION		13
+#define TCP_THIN_LINEAR_TIMEOUTS	16
+#define TCP_USER_TIMEOUT	18
+#define TCP_NOTSENT_LOWAT	25
+#define TCP_SAVE_SYN		27
 #define TCP_CA_NAME_MAX		16
+#define TCP_NAGLE_OFF		1
=20
 #define ICSK_TIME_RETRANS	1
 #define ICSK_TIME_PROBE0	3
@@ -49,6 +76,8 @@
 #define sk_state		__sk_common.skc_state
 #define sk_v6_daddr		__sk_common.skc_v6_daddr
 #define sk_v6_rcv_saddr		__sk_common.skc_v6_rcv_saddr
+#define sk_flags		__sk_common.skc_flags
+#define sk_reuse		__sk_common.skc_reuse
=20
 #define s6_addr32		in6_u.u6_addr32
=20
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/t=
esting/selftests/bpf/progs/setget_sockopt.c
new file mode 100644
index 000000000000..4a4cb44a4a15
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
+extern unsigned long CONFIG_HZ __kconfig;
+
+const volatile char veth[IFNAMSIZ];
+const volatile int veth_ifindex;
+
+int nr_listen;
+int nr_passive;
+int nr_active;
+int nr_connect;
+int nr_binddev;
+int nr_socket_post_create;
+
+struct sockopt_test {
+	int opt;
+	int new;
+	int restore;
+	int expected;
+	int tcp_expected;
+	unsigned int flip:1;
+};
+
+static const char cubic_cc[] =3D "cubic";
+static const char reno_cc[] =3D "reno";
+
+static const struct sockopt_test sol_socket_tests[] =3D {
+	{ .opt =3D SO_REUSEADDR, .flip =3D 1, },
+	{ .opt =3D SO_SNDBUF, .new =3D 8123, .expected =3D 8123 * 2, },
+	{ .opt =3D SO_RCVBUF, .new =3D 8123, .expected =3D 8123 * 2, },
+	{ .opt =3D SO_KEEPALIVE, .flip =3D 1, },
+	{ .opt =3D SO_PRIORITY, .new =3D 0xeb9f, .expected =3D 0xeb9f, },
+	{ .opt =3D SO_REUSEPORT, .flip =3D 1, },
+	{ .opt =3D SO_RCVLOWAT, .new =3D 8123, .expected =3D 8123, },
+	{ .opt =3D SO_MARK, .new =3D 0xeb9f, .expected =3D 0xeb9f, },
+	{ .opt =3D SO_MAX_PACING_RATE, .new =3D 0xeb9f, .expected =3D 0xeb9f, }=
,
+	{ .opt =3D SO_TXREHASH, .flip =3D 1, },
+	{ .opt =3D 0, },
+};
+
+static const struct sockopt_test sol_tcp_tests[] =3D {
+	{ .opt =3D TCP_NODELAY, .flip =3D 1, },
+	{ .opt =3D TCP_MAXSEG, .new =3D 1314, .expected =3D 1314, },
+	{ .opt =3D TCP_KEEPIDLE, .new =3D 123, .expected =3D 123, .restore =3D =
321, },
+	{ .opt =3D TCP_KEEPINTVL, .new =3D 123, .expected =3D 123, .restore =3D=
 321, },
+	{ .opt =3D TCP_KEEPCNT, .new =3D 123, .expected =3D 123, .restore =3D 1=
24, },
+	{ .opt =3D TCP_SYNCNT, .new =3D 123, .expected =3D 123, .restore =3D 12=
4, },
+	{ .opt =3D TCP_WINDOW_CLAMP, .new =3D 8123, .expected =3D 8123, .restor=
e =3D 8124, },
+	{ .opt =3D TCP_CONGESTION, },
+	{ .opt =3D TCP_THIN_LINEAR_TIMEOUTS, .flip =3D 1, },
+	{ .opt =3D TCP_USER_TIMEOUT, .new =3D 123400, .expected =3D 123400, },
+	{ .opt =3D TCP_NOTSENT_LOWAT, .new =3D 1314, .expected =3D 1314, },
+	{ .opt =3D TCP_SAVE_SYN, .new =3D 1, .expected =3D 1, },
+	{ .opt =3D 0, },
+};
+
+static const struct sockopt_test sol_ip_tests[] =3D {
+	{ .opt =3D IP_TOS, .new =3D 0xe1, .expected =3D 0xe1, .tcp_expected =3D=
 0xe0, },
+	{ .opt =3D 0, },
+};
+
+static const struct sockopt_test sol_ipv6_tests[] =3D {
+	{ .opt =3D IPV6_TCLASS, .new =3D 0xe1, .expected =3D 0xe1, .tcp_expecte=
d =3D 0xe0, },
+	{ .opt =3D IPV6_AUTOFLOWLABEL, .flip =3D 1, },
+	{ .opt =3D 0, },
+};
+
+struct loop_ctx {
+	void *ctx;
+	struct sock *sk;
+};
+
+static int __bpf_getsockopt(void *ctx, struct sock *sk,
+			    int level, int opt, int *optval,
+			    int optlen)
+{
+	if (level =3D=3D SOL_SOCKET) {
+		switch (opt) {
+		case SO_REUSEADDR:
+			*optval =3D !!BPF_CORE_READ_BITFIELD(sk, sk_reuse);
+			break;
+		case SO_KEEPALIVE:
+			*optval =3D !!(sk->sk_flags & (1UL << 3));
+			break;
+		case SO_RCVLOWAT:
+			*optval =3D sk->sk_rcvlowat;
+			break;
+		case SO_MAX_PACING_RATE:
+			*optval =3D sk->sk_max_pacing_rate;
+			break;
+		default:
+			return bpf_getsockopt(ctx, level, opt, optval, optlen);
+		}
+		return 0;
+	}
+
+	if (level =3D=3D IPPROTO_TCP) {
+		struct tcp_sock *tp =3D bpf_skc_to_tcp_sock(sk);
+
+		if (!tp)
+			return -1;
+
+		switch (opt) {
+		case TCP_NODELAY:
+			*optval =3D !!(BPF_CORE_READ_BITFIELD(tp, nonagle) & TCP_NAGLE_OFF);
+			break;
+		case TCP_MAXSEG:
+			*optval =3D tp->rx_opt.user_mss;
+			break;
+		case TCP_KEEPIDLE:
+			*optval =3D tp->keepalive_time / CONFIG_HZ;
+			break;
+		case TCP_SYNCNT:
+			*optval =3D tp->inet_conn.icsk_syn_retries;
+			break;
+		case TCP_KEEPINTVL:
+			*optval =3D tp->keepalive_intvl / CONFIG_HZ;
+			break;
+		case TCP_KEEPCNT:
+			*optval =3D tp->keepalive_probes;
+			break;
+		case TCP_WINDOW_CLAMP:
+			*optval =3D tp->window_clamp;
+			break;
+		case TCP_THIN_LINEAR_TIMEOUTS:
+			*optval =3D !!BPF_CORE_READ_BITFIELD(tp, thin_lto);
+			break;
+		case TCP_USER_TIMEOUT:
+			*optval =3D tp->inet_conn.icsk_user_timeout;
+			break;
+		case TCP_NOTSENT_LOWAT:
+			*optval =3D tp->notsent_lowat;
+			break;
+		case TCP_SAVE_SYN:
+			*optval =3D BPF_CORE_READ_BITFIELD(tp, save_syn);
+			break;
+		default:
+			return bpf_getsockopt(ctx, level, opt, optval, optlen);
+		}
+		return 0;
+	}
+
+	if (level =3D=3D IPPROTO_IPV6) {
+		switch (opt) {
+		case IPV6_AUTOFLOWLABEL: {
+			__u16 proto =3D sk->sk_protocol;
+			struct inet_sock *inet_sk;
+
+			if (proto =3D=3D IPPROTO_TCP)
+				inet_sk =3D (struct inet_sock *)bpf_skc_to_tcp_sock(sk);
+			else
+				inet_sk =3D (struct inet_sock *)bpf_skc_to_udp6_sock(sk);
+
+			if (!inet_sk)
+				return -1;
+
+			*optval =3D !!inet_sk->pinet6->autoflowlabel;
+			break;
+		}
+		default:
+			return bpf_getsockopt(ctx, level, opt, optval, optlen);
+		}
+		return 0;
+	}
+
+	return bpf_getsockopt(ctx, level, opt, optval, optlen);
+}
+
+static int bpf_test_sockopt_flip(void *ctx, struct sock *sk,
+				 const struct sockopt_test *t,
+				 int level)
+{
+	int old, tmp, new, opt =3D t->opt;
+
+	opt =3D t->opt;
+
+	if (__bpf_getsockopt(ctx, sk, level, opt, &old, sizeof(old)))
+		return 1;
+	/* kernel initialized txrehash to 255 */
+	if (level =3D=3D SOL_SOCKET && opt =3D=3D SO_TXREHASH && old !=3D 0 && =
old !=3D 1)
+		old =3D 1;
+
+	new =3D !old;
+	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
+		return 1;
+	if (__bpf_getsockopt(ctx, sk, level, opt, &tmp, sizeof(tmp)) ||
+	    tmp !=3D new)
+		return 1;
+
+	if (bpf_setsockopt(ctx, level, opt, &old, sizeof(old)))
+		return 1;
+
+	return 0;
+}
+
+static int bpf_test_sockopt_int(void *ctx, struct sock *sk,
+				const struct sockopt_test *t,
+				int level)
+{
+	int old, tmp, new, expected, opt;
+
+	opt =3D t->opt;
+	new =3D t->new;
+	if (sk->sk_type =3D=3D SOCK_STREAM && t->tcp_expected)
+		expected =3D t->tcp_expected;
+	else
+		expected =3D t->expected;
+
+	if (__bpf_getsockopt(ctx, sk, level, opt, &old, sizeof(old)) ||
+	    old =3D=3D new)
+		return 1;
+
+	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
+		return 1;
+	if (__bpf_getsockopt(ctx, sk, level, opt, &tmp, sizeof(tmp)) ||
+	    tmp !=3D expected)
+		return 1;
+
+	if (t->restore)
+		old =3D t->restore;
+	if (bpf_setsockopt(ctx, level, opt, &old, sizeof(old)))
+		return 1;
+
+	return 0;
+}
+
+static int bpf_test_socket_sockopt(__u32 i, struct loop_ctx *lc)
+{
+	const struct sockopt_test *t;
+
+	if (i >=3D ARRAY_SIZE(sol_socket_tests))
+		return 1;
+
+	t =3D &sol_socket_tests[i];
+	if (!t->opt)
+		return 1;
+
+	if (t->flip)
+		return bpf_test_sockopt_flip(lc->ctx, lc->sk, t, SOL_SOCKET);
+
+	return bpf_test_sockopt_int(lc->ctx, lc->sk, t, SOL_SOCKET);
+}
+
+static int bpf_test_ip_sockopt(__u32 i, struct loop_ctx *lc)
+{
+	const struct sockopt_test *t;
+
+	if (i >=3D ARRAY_SIZE(sol_ip_tests))
+		return 1;
+
+	t =3D &sol_ip_tests[i];
+	if (!t->opt)
+		return 1;
+
+	if (t->flip)
+		return bpf_test_sockopt_flip(lc->ctx, lc->sk, t, IPPROTO_IP);
+
+	return bpf_test_sockopt_int(lc->ctx, lc->sk, t, IPPROTO_IP);
+}
+
+static int bpf_test_ipv6_sockopt(__u32 i, struct loop_ctx *lc)
+{
+	const struct sockopt_test *t;
+
+	if (i >=3D ARRAY_SIZE(sol_ipv6_tests))
+		return 1;
+
+	t =3D &sol_ipv6_tests[i];
+	if (!t->opt)
+		return 1;
+
+	if (t->flip)
+		return bpf_test_sockopt_flip(lc->ctx, lc->sk, t, IPPROTO_IPV6);
+
+	return bpf_test_sockopt_int(lc->ctx, lc->sk, t, IPPROTO_IPV6);
+}
+
+static int bpf_test_tcp_sockopt(__u32 i, struct loop_ctx *lc)
+{
+	const struct sockopt_test *t;
+	struct sock *sk;
+	void *ctx;
+
+	if (i >=3D ARRAY_SIZE(sol_tcp_tests))
+		return 1;
+
+	t =3D &sol_tcp_tests[i];
+	if (!t->opt)
+		return 1;
+
+	ctx =3D lc->ctx;
+	sk =3D lc->sk;
+
+	if (t->opt =3D=3D TCP_CONGESTION) {
+		char old_cc[16], tmp_cc[16];
+		const char *new_cc;
+
+		if (bpf_getsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, old_cc, sizeof(ol=
d_cc)))
+			return 1;
+		if (!bpf_strncmp(old_cc, sizeof(old_cc), cubic_cc))
+			new_cc =3D reno_cc;
+		else
+			new_cc =3D cubic_cc;
+		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, (void *)new_cc,
+				   sizeof(new_cc)))
+			return 1;
+		if (bpf_getsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, tmp_cc, sizeof(tm=
p_cc)))
+			return 1;
+		if (bpf_strncmp(tmp_cc, sizeof(tmp_cc), new_cc))
+			return 1;
+		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, old_cc, sizeof(ol=
d_cc)))
+			return 1;
+		return 0;
+	}
+
+	if (t->flip)
+		return bpf_test_sockopt_flip(ctx, sk, t, IPPROTO_TCP);
+
+	return bpf_test_sockopt_int(ctx, sk, t, IPPROTO_TCP);
+}
+
+static int bpf_test_sockopt(void *ctx, struct sock *sk)
+{
+	struct loop_ctx lc =3D { .ctx =3D ctx, .sk =3D sk, };
+	__u16 family, proto;
+	int n;
+
+	family =3D sk->sk_family;
+	proto =3D sk->sk_protocol;
+
+	n =3D bpf_loop(ARRAY_SIZE(sol_socket_tests), bpf_test_socket_sockopt, &=
lc, 0);
+	if (n !=3D ARRAY_SIZE(sol_socket_tests))
+		return -1;
+
+	if (proto =3D=3D IPPROTO_TCP) {
+		n =3D bpf_loop(ARRAY_SIZE(sol_tcp_tests), bpf_test_tcp_sockopt, &lc, 0=
);
+		if (n !=3D ARRAY_SIZE(sol_tcp_tests))
+			return -1;
+	}
+
+	if (family =3D=3D AF_INET) {
+		n =3D bpf_loop(ARRAY_SIZE(sol_ip_tests), bpf_test_ip_sockopt, &lc, 0);
+		if (n !=3D ARRAY_SIZE(sol_ip_tests))
+			return -1;
+	} else {
+		n =3D bpf_loop(ARRAY_SIZE(sol_ipv6_tests), bpf_test_ipv6_sockopt, &lc,=
 0);
+		if (n !=3D ARRAY_SIZE(sol_ipv6_tests))
+			return -1;
+	}
+
+	return 0;
+}
+
+static int binddev_test(void *ctx)
+{
+	const char empty_ifname[] =3D "";
+	int ifindex, zero =3D 0;
+
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_BINDTODEVICE,
+			   (void *)veth, sizeof(veth)))
+		return -1;
+	if (bpf_getsockopt(ctx, SOL_SOCKET, SO_BINDTOIFINDEX,
+			   &ifindex, sizeof(int)) ||
+	    ifindex !=3D veth_ifindex)
+		return -1;
+
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_BINDTODEVICE,
+			   (void *)empty_ifname, sizeof(empty_ifname)))
+		return -1;
+	if (bpf_getsockopt(ctx, SOL_SOCKET, SO_BINDTOIFINDEX,
+			   &ifindex, sizeof(int)) ||
+	    ifindex !=3D 0)
+		return -1;
+
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_BINDTOIFINDEX,
+			   (void *)&veth_ifindex, sizeof(int)))
+		return -1;
+	if (bpf_getsockopt(ctx, SOL_SOCKET, SO_BINDTOIFINDEX,
+			   &ifindex, sizeof(int)) ||
+	    ifindex !=3D veth_ifindex)
+		return -1;
+
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_BINDTOIFINDEX,
+			   &zero, sizeof(int)))
+		return -1;
+	if (bpf_getsockopt(ctx, SOL_SOCKET, SO_BINDTOIFINDEX,
+			   &ifindex, sizeof(int)) ||
+	    ifindex !=3D 0)
+		return -1;
+
+	return 0;
+}
+
+SEC("lsm_cgroup/socket_post_create")
+int BPF_PROG(socket_post_create, struct socket *sock, int family,
+	     int type, int protocol, int kern)
+{
+	struct sock *sk =3D sock->sk;
+
+	if (!sk)
+		return 1;
+
+	nr_socket_post_create +=3D !bpf_test_sockopt(sk, sk);
+	nr_binddev +=3D !binddev_test(sk);
+
+	return 1;
+}
+
+SEC("sockops")
+int skops_sockopt(struct bpf_sock_ops *skops)
+{
+	struct bpf_sock *bpf_sk =3D skops->sk;
+	struct sock *sk;
+
+	if (!bpf_sk)
+		return 1;
+
+	sk =3D (struct sock *)bpf_skc_to_tcp_sock(bpf_sk);
+	if (!sk)
+		return 1;
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_TCP_LISTEN_CB:
+		nr_listen +=3D !bpf_test_sockopt(skops, sk);
+		break;
+	case BPF_SOCK_OPS_TCP_CONNECT_CB:
+		nr_connect +=3D !bpf_test_sockopt(skops, sk);
+		break;
+	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
+		nr_active +=3D !bpf_test_sockopt(skops, sk);
+		break;
+	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
+		nr_passive +=3D !bpf_test_sockopt(skops, sk);
+		break;
+	}
+
+	return 1;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

