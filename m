Return-Path: <bpf+bounces-9129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B077903F2
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 01:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211C01C208E4
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 23:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE9316402;
	Fri,  1 Sep 2023 23:12:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277AD15AF0
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 23:12:03 +0000 (UTC)
Received: from out-239.mta0.migadu.com (out-239.mta0.migadu.com [91.218.175.239])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A187CE5B
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 16:12:02 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693609921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2NQrnRGGF3rRi02xY3sxQKg0eql+Fosaqzb/FW1YTA=;
	b=xYisj1NWtOkqQqtXKGBRNpfszrNo8bUGWQ5NKTWodikxHh1i+GnpwWxwTv8LgQWNoPF4zL
	0cgKiJIodNZhMd/qQO4GWGjqkaCU5B3RXRh7RNmXOdDDEsewdh8kMxLoUUMkQF+0kBkz/M
	NHOF1gxIgGQxwQlkMAkYLdRwXhcq4OU=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf 3/3] selftests/bpf: Check bpf_sk_storage has uncharged sk_omem_alloc
Date: Fri,  1 Sep 2023 16:11:29 -0700
Message-Id: <20230901231129.578493-4-martin.lau@linux.dev>
In-Reply-To: <20230901231129.578493-1-martin.lau@linux.dev>
References: <20230901231129.578493-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch checks the sk_omem_alloc has been uncharged by bpf_sk_storage
during the __sk_destruct.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../bpf/prog_tests/sk_storage_omem_uncharge.c | 56 +++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |  1 +
 .../bpf/progs/sk_storage_omem_uncharge.c      | 61 +++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_storage_omem_uncharge.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_storage_omem_uncharge.c b/tools/testing/selftests/bpf/prog_tests/sk_storage_omem_uncharge.c
new file mode 100644
index 000000000000..f35852d245e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sk_storage_omem_uncharge.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Facebook */
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include "sk_storage_omem_uncharge.skel.h"
+
+void test_sk_storage_omem_uncharge(void)
+{
+	struct sk_storage_omem_uncharge *skel;
+	int sk_fd = -1, map_fd, err, value;
+	socklen_t optlen;
+
+	skel = sk_storage_omem_uncharge__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		return;
+	map_fd = bpf_map__fd(skel->maps.sk_storage);
+
+	/* A standalone socket not binding to addr:port,
+	 * so nentns is not needed.
+	 */
+	sk_fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (!ASSERT_GE(sk_fd, 0, "socket"))
+		goto done;
+
+	optlen = sizeof(skel->bss->cookie);
+	err = getsockopt(sk_fd, SOL_SOCKET, SO_COOKIE, &skel->bss->cookie, &optlen);
+	if (!ASSERT_OK(err, "getsockopt(SO_COOKIE)"))
+		goto done;
+
+	value = 0;
+	err = bpf_map_update_elem(map_fd, &sk_fd, &value, 0);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(value=0)"))
+		goto done;
+
+	value = 0xdeadbeef;
+	err = bpf_map_update_elem(map_fd, &sk_fd, &value, 0);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(value=0xdeadbeef)"))
+		goto done;
+
+	err = sk_storage_omem_uncharge__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto done;
+
+	close(sk_fd);
+	sk_fd = -1;
+
+	ASSERT_EQ(skel->bss->cookie_found, 2, "cookie_found");
+	ASSERT_EQ(skel->bss->omem, 0, "omem");
+
+done:
+	sk_storage_omem_uncharge__destroy(skel);
+	if (sk_fd != -1)
+		close(sk_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index cfed4df490f3..0b793a102791 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -88,6 +88,7 @@
 #define sk_v6_rcv_saddr		__sk_common.skc_v6_rcv_saddr
 #define sk_flags		__sk_common.skc_flags
 #define sk_reuse		__sk_common.skc_reuse
+#define sk_cookie		__sk_common.skc_cookie
 
 #define s6_addr32		in6_u.u6_addr32
 
diff --git a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
new file mode 100644
index 000000000000..3e745793b27a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Facebook */
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+void *local_storage_ptr = NULL;
+void *sk_ptr = NULL;
+int cookie_found = 0;
+__u64 cookie = 0;
+__u32 omem = 0;
+
+void *bpf_rdonly_cast(void *, __u32) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, int);
+} sk_storage SEC(".maps");
+
+SEC("fexit/bpf_local_storage_destroy")
+int BPF_PROG(bpf_local_storage_destroy, struct bpf_local_storage *local_storage)
+{
+	struct sock *sk;
+
+	if (local_storage_ptr != local_storage)
+		return 0;
+
+	sk = bpf_rdonly_cast(sk_ptr, bpf_core_type_id_kernel(struct sock));
+	if (sk->sk_cookie.counter != cookie)
+		return 0;
+
+	cookie_found++;
+	omem = sk->sk_omem_alloc.counter;
+	local_storage_ptr = NULL;
+
+	return 0;
+}
+
+SEC("fentry/inet6_sock_destruct")
+int BPF_PROG(inet6_sock_destruct, struct sock *sk)
+{
+	int *value;
+
+	if (!cookie || sk->sk_cookie.counter != cookie)
+		return 0;
+
+	value = bpf_sk_storage_get(&sk_storage, sk, 0, 0);
+	if (value && *value == 0xdeadbeef) {
+		cookie_found++;
+		sk_ptr = sk;
+		local_storage_ptr = sk->sk_bpf_storage;
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


