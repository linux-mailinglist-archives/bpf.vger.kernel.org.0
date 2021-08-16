Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81A3EE043
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 01:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhHPXSD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 19:18:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30670 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232660AbhHPXSC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Aug 2021 19:18:02 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GNBT58022106
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 16:17:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8cxkvKHWrxZDCsGfm6EptnCclGU4YX+pI/cc5tzAJNU=;
 b=IggeSpW0ltJ2vZXvagjS2ewLaQlLNzXBDP8vrUjA6uSbQULmh0HWLMUeioEfHHUDB1vQ
 hz793JLUawwIQnlzx/mq7xUgqmp2vo4mBRulHDEH9g8OT0zmBr7mDFU+arRumyU9aOT7
 BnaqslsZXMDk8nSdVoDXc0wel83tFZWMJhw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aftmjju09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 16:17:30 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 16:17:29 -0700
Received: by devbig577.ftw3.facebook.com (Postfix, from userid 201728)
        id 595246DC6182; Mon, 16 Aug 2021 16:17:18 -0700 (PDT)
From:   Prankur gupta <prankgup@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, <prankur.07@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for {set|get} socket option from setsockopt BPF program
Date:   Mon, 16 Aug 2021 16:17:16 -0700
Message-ID: <20210816231716.3824813-3-prankgup@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210816231716.3824813-1-prankgup@fb.com>
References: <20210816231716.3824813-1-prankgup@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: zhnv07hot2pbB9XuSXMhFeW7kQ24e-9Z
X-Proofpoint-GUID: zhnv07hot2pbB9XuSXMhFeW7kQ24e-9Z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_09:2021-08-16,2021-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108160144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding selftests for new added functionality to call bpf_setsockopt and
bpf_getsockopt from setsockopt BPF programs

Signed-off-by: Prankur gupta <prankgup@fb.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 18 +++++
 .../bpf/prog_tests/sockopt_qos_to_cc.c        | 70 +++++++++++++++++++
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   | 39 +++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockopt_qos_to=
_cc.c
 create mode 100644 tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_tcp_helpers.h
index 029589c008c9..c9f9bdad60c7 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -12,6 +12,10 @@
 SEC("struct_ops/"#name) \
 BPF_PROG(name, args)
=20
+#ifndef SOL_TCP
+#define SOL_TCP 6
+#endif
+
 #define tcp_jiffies32 ((__u32)bpf_jiffies64())
=20
 struct sock_common {
@@ -203,6 +207,20 @@ static __always_inline bool tcp_is_cwnd_limited(cons=
t struct sock *sk)
 	return !!BPF_CORE_READ_BITFIELD(tp, is_cwnd_limited);
 }
=20
+static __always_inline bool tcp_cc_eq(const char *a, const char *b)
+{
+	int i;
+
+	for (i =3D 0; i < TCP_CA_NAME_MAX; i++) {
+		if (a[i] !=3D b[i])
+			return false;
+		if (!a[i])
+			break;
+	}
+
+	return true;
+}
+
 extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked)=
 __ksym;
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_qos_to_cc.c b=
/tools/testing/selftests/bpf/prog_tests/sockopt_qos_to_cc.c
new file mode 100644
index 000000000000..6b53b3cb8dad
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_qos_to_cc.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <test_progs.h>
+#include <netinet/tcp.h>
+#include "sockopt_qos_to_cc.skel.h"
+
+static void run_setsockopt_test(int cg_fd, int sock_fd)
+{
+	socklen_t optlen;
+	char cc[16]; /* TCP_CA_NAME_MAX */
+	int buf;
+	int err =3D -1;
+
+	buf =3D 0x2D;
+	err =3D setsockopt(sock_fd, SOL_IPV6, IPV6_TCLASS, &buf, sizeof(buf));
+	if (!ASSERT_OK(err, "setsockopt(sock_fd, IPV6_TCLASS)"))
+		return;
+
+	/* Verify the setsockopt cc change */
+	optlen =3D sizeof(cc);
+	err =3D getsockopt(sock_fd, SOL_TCP, TCP_CONGESTION, cc, &optlen);
+	if (!ASSERT_OK(err, "getsockopt(sock_fd, TCP_CONGESTION)"))
+		return;
+
+	if (!ASSERT_STREQ(cc, "reno", "getsockopt(sock_fd, TCP_CONGESTION)"))
+		return;
+}
+
+void test_sockopt_qos_to_cc(void)
+{
+	struct sockopt_qos_to_cc *skel;
+	char cc_cubic[16] =3D "cubic"; /* TCP_CA_NAME_MAX */
+	int cg_fd =3D -1;
+	int sock_fd =3D -1;
+	int err;
+
+	cg_fd =3D test__join_cgroup("/sockopt_qos_to_cc");
+	if (!ASSERT_GE(cg_fd, 0, "cg-join(sockopt_qos_to_cc)"))
+		return;
+
+	skel =3D sockopt_qos_to_cc__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		goto done;
+
+	sock_fd =3D socket(AF_INET6, SOCK_STREAM, 0);
+	if (!ASSERT_GE(sock_fd, 0, "v6 socket open"))
+		goto done;
+
+	err =3D setsockopt(sock_fd, SOL_TCP, TCP_CONGESTION, &cc_cubic,
+			 sizeof(cc_cubic));
+	if (!ASSERT_OK(err, "setsockopt(sock_fd, TCP_CONGESTION)"))
+		goto done;
+
+	skel->links.sockopt_qos_to_cc =3D
+		bpf_program__attach_cgroup(skel->progs.sockopt_qos_to_cc,
+					   cg_fd);
+	if (!ASSERT_OK_PTR(skel->links.sockopt_qos_to_cc,
+			   "prog_attach(sockopt_qos_to_cc)"))
+		goto done;
+
+	run_setsockopt_test(cg_fd, sock_fd);
+
+done:
+	if (sock_fd !=3D -1)
+		close(sock_fd);
+	if (cg_fd !=3D -1)
+		close(cg_fd);
+	/* destroy can take null and error pointer */
+	sockopt_qos_to_cc__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c b/tool=
s/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
new file mode 100644
index 000000000000..1bce83b6e3a7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <string.h>
+#include <linux/tcp.h>
+#include <netinet/in.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("cgroup/setsockopt")
+int sockopt_qos_to_cc(struct bpf_sockopt *ctx)
+{
+	void *optval_end =3D ctx->optval_end;
+	int *optval =3D ctx->optval;
+	char buf[TCP_CA_NAME_MAX];
+	char cc_reno[TCP_CA_NAME_MAX] =3D "reno";
+	char cc_cubic[TCP_CA_NAME_MAX] =3D "cubic";
+
+	if (ctx->level !=3D SOL_IPV6 || ctx->optname !=3D IPV6_TCLASS)
+		return 1;
+
+	if (optval + 1 > optval_end)
+		return 0; /* EPERM, bounds check */
+
+	if (bpf_getsockopt(ctx->sk, SOL_TCP, TCP_CONGESTION, &buf, sizeof(buf))=
)
+		return 0;
+
+	if (!tcp_cc_eq(buf, cc_cubic))
+		return 0;
+
+	if (*optval =3D=3D 0x2d) {
+		if (bpf_setsockopt(ctx->sk, SOL_TCP, TCP_CONGESTION, &cc_reno,
+				sizeof(cc_reno)))
+			return 0;
+	}
+	return 1;
+}
--=20
2.30.2

