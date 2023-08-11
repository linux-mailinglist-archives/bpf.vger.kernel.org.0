Return-Path: <bpf+bounces-7531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A3D7789CE
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 11:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69558282114
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E3F6FC6;
	Fri, 11 Aug 2023 09:28:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A36FC0;
	Fri, 11 Aug 2023 09:28:17 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710B426B2;
	Fri, 11 Aug 2023 02:28:16 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RMdgQ0433zqSfq;
	Fri, 11 Aug 2023 17:25:22 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 17:28:13 +0800
From: Liu Jian <liujian56@huawei.com>
To: <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <liujian56@huawei.com>
Subject: [PATCH bpf-next v2 4/7] selftests/bpf: add skmsg verdict tests
Date: Fri, 11 Aug 2023 17:32:34 +0800
Message-ID: <20230811093237.3024459-5-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811093237.3024459-1-liujian56@huawei.com>
References: <20230811093237.3024459-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add two normal skmsg verdict tests in sockmap_basic.c

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 71 +++++++++++++++++++
 .../bpf/progs/test_sockmap_msg_verdict.c      | 25 +++++++
 2 files changed, 96 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_verdict.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 064cc5e8d9ad..93bf1907abd9 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -12,6 +12,7 @@
 #include "test_sockmap_progs_query.skel.h"
 #include "test_sockmap_pass_prog.skel.h"
 #include "test_sockmap_drop_prog.skel.h"
+#include "test_sockmap_msg_verdict.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
 #include "sockmap_helpers.h"
@@ -475,6 +476,72 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 		test_sockmap_drop_prog__destroy(drop);
 }
 
+static void test_sockmap_msg_verdict(bool is_ingress)
+{
+	int key, sent, recvd, recv_fd;
+	int err, map, verdict, s, c0, c1, p0, p1;
+	struct test_sockmap_msg_verdict *skel;
+	char buf[256] = "0123456789";
+
+	skel = test_sockmap_msg_verdict__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	verdict = bpf_program__fd(skel->progs.prog_skmsg_verdict);
+	map = bpf_map__fd(skel->maps.sock_map);
+
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	s = socket_loopback(AF_INET, SOCK_STREAM);
+	if (!ASSERT_GT(s, -1, "socket_loopback(s)"))
+		goto out;
+	err = create_socket_pairs(s, AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1);
+	if (!ASSERT_OK(err, "create_socket_pairs(s)"))
+		goto out;
+
+	key = 0;
+	err = bpf_map_update_elem(map, &key, &p1, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(key0)"))
+		goto out_close;
+	key = 1;
+	err = bpf_map_update_elem(map, &key, &c1, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(key1)"))
+		goto out_close;
+	key = 2;
+	err = bpf_map_update_elem(map, &key, &p0, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(key2)"))
+		goto out_close;
+	key = 3;
+	err = bpf_map_update_elem(map, &key, &c0, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(key3)"))
+		goto out_close;
+
+	if (is_ingress) {
+		recv_fd = c1;
+		skel->bss->skmsg_redir_flags = BPF_F_INGRESS;
+		skel->bss->skmsg_redir_key = 1;
+	} else {
+		recv_fd = c0;
+		skel->bss->skmsg_redir_flags = 0;
+		skel->bss->skmsg_redir_key = 2;
+	}
+
+	sent = xsend(p1, &buf, sizeof(buf), 0);
+	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
+	recvd = recv_timeout(recv_fd, &buf, sizeof(buf), SOCK_NONBLOCK, IO_TIMEOUT_SEC);
+	ASSERT_EQ(recvd, sizeof(buf), "recv_timeout(recv_fd)");
+
+out_close:
+	close(c0);
+	close(p0);
+	close(c1);
+	close(p1);
+out:
+	test_sockmap_msg_verdict__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -515,4 +582,8 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_fionread(true);
 	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
 		test_sockmap_skb_verdict_fionread(false);
+	if (test__start_subtest("sockmap msg_verdict"))
+		test_sockmap_msg_verdict(false);
+	if (test__start_subtest("sockmap msg_verdict ingress"))
+		test_sockmap_msg_verdict(true);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_msg_verdict.c b/tools/testing/selftests/bpf/progs/test_sockmap_msg_verdict.c
new file mode 100644
index 000000000000..002b76a1ae35
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_msg_verdict.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 4);
+	__type(key, int);
+	__type(value, int);
+} sock_map SEC(".maps");
+
+u64 skmsg_redir_flags = 0;
+u32 skmsg_redir_key = 0;
+
+SEC("sk_msg")
+int prog_skmsg_verdict(struct sk_msg_md *msg)
+{
+	u64 flags = skmsg_redir_flags;
+	int key = skmsg_redir_key;
+
+	bpf_msg_redirect_map(msg, &sock_map, key, flags);
+	return SK_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


