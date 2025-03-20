Return-Path: <bpf+bounces-54485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6048DA6AC74
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 18:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2262486183
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 17:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B784228CB0;
	Thu, 20 Mar 2025 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQHHiw98"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348A1953A1;
	Thu, 20 Mar 2025 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492976; cv=none; b=cKrJd/K14yJrB1M9y5HyUb7TDQ+/9eZgRTcBpVZGzAJxvGQXFfza/NI2iz41dvPSdgOP10ySSPktqKJKbN5tJB9HS7G8D9NB8CmlCRlNTU/FSxb0+WXiJGYozDh1bKOBZw2Ak+QE6Kp4ZqNPsELFSlgo4BmFS1dtnr/s1GAfonA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492976; c=relaxed/simple;
	bh=zzDsDzDFbHXX8gkdvJ0GTkU+kjZtv39rHYFmsbgNYQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LyzV7y80chmKCPHC9z+P8iuvsnB1KxsGO+T51W0whiXBLXxjPhzCtLt0bZiCkdDnX0eERyGOjfoJDWaITg4ci9ZDxM3Cx9qeP2rr803MqTVPoWzyHOdzRwPDX7HrqggT2S3VvWsnDX/kPnMLZCyT2HlOeyNtCDtDrMysXZCoBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQHHiw98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D037C4CEDD;
	Thu, 20 Mar 2025 17:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742492975;
	bh=zzDsDzDFbHXX8gkdvJ0GTkU+kjZtv39rHYFmsbgNYQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iQHHiw98eMyif3kHCj3cyDWM520HO99t0KJfYe7J0MtvVO4j8QIgnktKHzHLfg9Mc
	 mfBxww2/Sc4O/oR7kvO5Lch2k940v2J7m6vquQt+jkHMN0mmjCznq3w7kxRvfbF8dI
	 /T9/5o6wx8EebO5HPi58aMFKo1sRkv8hNtUG0/mq0H2qsFHdCfuQsGBH+Nae8u03Gb
	 64gdAXjijU6FuAAONKBxrk7Wp0rien3Kdz1y93Gw6G/LGg72OgT+2POCMkjdi8av2k
	 q9Rm5Co+4Ej069Cn6flD+mId7YG1UbTbE0LCsyAmn9M4AnmnwTh0GpvpyzeExyf4jn
	 Rv816yvHv0kZg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 20 Mar 2025 18:48:43 +0100
Subject: [PATCH bpf-next/net v3 4/5] selftests/bpf: Add mptcp_subflow
 bpf_iter subtest
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-4-9abd22c2a7fd@kernel.org>
References: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-0-9abd22c2a7fd@kernel.org>
In-Reply-To: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-0-9abd22c2a7fd@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9166; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UZ1zChy37mG8P/voa7OUD4CIzTYqLcEPVR7oZ5AyhbU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn3FURyeWcJzC4mCbdtPLKx5eR8yHspdMJ6ofdk
 rOMSx44LL2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9xVEQAKCRD2t4JPQmmg
 c2eoD/94QzfAAzLoqMejDNaVFj7uunLQQ8JW84h/C7H9CxDfpgSyClJo5kV7zPRIzPz4OUhaM83
 rY7oJGiQfq8fwxngIQLkZZmDs9+oMeAZbDquACLTH3kgRie0EmALbELfJzHsnbkeX50JwS5DJ6X
 cQYlMof2yp/YQxybpZSBxVXl4x+1/3F+86npsEQNDRMSeGZITlR5czfqJrarh6Jhu2Ac5VlTCK0
 B3HrbdHQww5qZBIGdffoTxcPOoySsDBr9/kVlykghA1IpaMW0z2lHsPsAoh7dvlXlQ5OBIwulnL
 tcyHPngCopm9GEOb9AkEDgWVn8/9iZOdxouHd3rdjOmnLIPsCTKKxq9eTD6FGk6k7HO05sqMiaC
 cgOQQBQ8ppaG3mE+Rmpy/vMbcxapcoX5aU18OJniLKH0NWBobeMbujQPqbi+mrA5dICQGrUaaN/
 oKttX2u/8UR2tqbFZgupYNkPWCYT5RaI0LeeJyJZUDxvKNt0wPjJx6J5Vavtw/SYbeRfLBi4/OW
 hMWE+xNjL/dLk/cqWmMpKPMHjcBeiD+C42HenexyMB7+fkYSRRmSu2gqWhz9HxUUmtbYjacZ025
 26MOxjFOnPfS4yiQxq33ukyy3zSTvxKDDgDFpjQUVCcGJWfgNc5uzQnl/7eFI3Px9v3KkfVs49/
 vrtT0njsIryZXBQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a "cgroup/getsockopt" program "iters_subflow" to test the
newly added mptcp_subflow bpf_iter.

Export mptcp_subflow helpers bpf_iter_mptcp_subflow_new/_next/_destroy
and other helpers into bpf_experimental.h.

Use bpf_for_each() to walk the subflow list of an msk. From there,
future MPTCP-specific kfunc can be called in the loop. Because they are
not there yet, this test doesn't do anything very "useful" for the
moment, but it focuses on validating the 'bpf_iter' part and the basic
MPTCP kfunc. That's why it simply adds all subflow ids to local variable
local_ids to make sure all subflows have been seen, then invoke
mptcp_subflow_tcp_sock() in the loop to pick the subflow context.

Out of the loop, use bpf_mptcp_subflow_ctx() to get the subflow context
of the picked subflow context and do some verifications. Finally, assign
local_ids to global variable ids so that the application can obtain this
value.

A related subtest called test_iters_subflow is added to load and verify
the newly added mptcp_subflow type bpf_iter example in test_mptcp. The
endpoint_init() helper is used to add 3 new subflow endpoints. Then one
byte of message is sent to trigger the creation of new subflows.
getsockopt() is invoked once the subflows have been created to trigger
the "cgroup/getsockopt" test program "iters_subflow". skel->bss->ids is
then checked to make sure it equals 10, the sum of each subflow ID: we
should have 4 subflows: 1 + 2 + 3 + 4 = 10. If that's the case, the
bpf_iter loop did the job as expected.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2:
   - explicit sk protocol checks are no longer needed, implicitly done
     in bpf_skc_to_mptcp_sock().
   - use bpf_skc_to_mptcp_sock() instead of bpf_mptcp_sk(), and
     mptcp_subflow_tcp_sock() instead of bpf_mptcp_subflow_tcp_sock().
   - bpf_mptcp_subflow_ctx() can now return NULL.
 - v3:
   - Use bpf_core_cast to get the msk instead of bpf_skc_to_mptcp_sock.
   - Drop bpf_mptcp_sock_acquire and bpf_mptcp_sock_release (Martin).
   - Adapt the commit message accordingly.
   - Remove no longer needed export to the mptcp_bpf.h file and adapt
     bpf_iter_mptcp_subflow_new parameter in bpf_experimental.h.
---
 tools/testing/selftests/bpf/bpf_experimental.h     |  8 +++
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 73 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h      |  4 ++
 .../testing/selftests/bpf/progs/mptcp_bpf_iters.c  | 59 +++++++++++++++++
 4 files changed, 144 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index cd8ecd39c3f3c68d40c6e3e1465b42ed66537027..6a96c56f0725a86ab6e83675ca0e474c3d668b10 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -575,6 +575,14 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
 extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
 extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
+struct bpf_iter_mptcp_subflow;
+extern int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+				      struct sock *sk) __weak __ksym;
+extern struct mptcp_subflow_context *
+bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
+extern void
+bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
+
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 85f3d4119802a85c86cde7b74a0b857252bad8b8..f37574b5ef68d8f32f8002df317869dfdf1d4b2d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,6 +11,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
+#include "mptcp_bpf_iters.skel.h"
 
 #define NS_TEST "mptcp_ns"
 #define ADDR_1	"10.0.1.1"
@@ -33,6 +34,9 @@
 #ifndef MPTCP_INFO
 #define MPTCP_INFO		1
 #endif
+#ifndef TCP_IS_MPTCP
+#define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
+#endif
 #ifndef MPTCP_INFO_FLAG_FALLBACK
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #endif
@@ -480,6 +484,73 @@ static void test_subflow(void)
 	close(cgroup_fd);
 }
 
+static void run_iters_subflow(void)
+{
+	int server_fd, client_fd;
+	int is_mptcp, err;
+	socklen_t len;
+
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
+		goto close_server;
+
+	send_byte(client_fd);
+	wait_for_new_subflows(client_fd);
+
+	len = sizeof(is_mptcp);
+	/* mainly to trigger the BPF program */
+	err = getsockopt(client_fd, SOL_TCP, TCP_IS_MPTCP, &is_mptcp, &len);
+	if (ASSERT_OK(err, "getsockopt(client_fd, TCP_IS_MPTCP)"))
+		ASSERT_EQ(is_mptcp, 1, "is_mptcp");
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
+
+static void test_iters_subflow(void)
+{
+	struct mptcp_bpf_iters *skel;
+	struct netns_obj *netns;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/iters_subflow");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: iters_subflow"))
+		return;
+
+	skel = mptcp_bpf_iters__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: iters_subflow"))
+		goto close_cgroup;
+
+	skel->links.iters_subflow = bpf_program__attach_cgroup(skel->progs.iters_subflow,
+							       cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.iters_subflow, "attach getsockopt"))
+		goto skel_destroy;
+
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new: iters_subflow"))
+		goto skel_destroy;
+
+	if (endpoint_init("subflow", 4) < 0)
+		goto close_netns;
+
+	run_iters_subflow();
+
+	/* 1 + 2 + 3 + 4 = 10 */
+	ASSERT_EQ(skel->bss->ids, 10, "subflow ids");
+
+close_netns:
+	netns_free(netns);
+skel_destroy:
+	mptcp_bpf_iters__destroy(skel);
+close_cgroup:
+	close(cgroup_fd);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -488,4 +559,6 @@ void test_mptcp(void)
 		test_mptcpify();
 	if (test__start_subtest("subflow"))
 		test_subflow();
+	if (test__start_subtest("iters_subflow"))
+		test_iters_subflow();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 3b188ccdcc4041acb4f7ed38ae8ddf5a7305466a..aa897074de6f377e8cddc859c3b2dc3751f14381 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -39,4 +39,8 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 	return subflow->tcp_sock;
 }
 
+/* ksym */
+extern struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
new file mode 100644
index 0000000000000000000000000000000000000000..a1d8f9b20259a9cbdc46d58e0d18157564fa5acd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Kylin Software */
+
+/* vmlinux.h, bpf_helpers.h and other 'define' */
+#include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
+
+char _license[] SEC("license") = "GPL";
+int ids;
+
+#ifndef TCP_IS_MPTCP
+#define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
+#endif
+
+SEC("cgroup/getsockopt")
+int iters_subflow(struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+	struct bpf_sock *sk = ctx->sk;
+	struct sock *ssk = NULL;
+	struct mptcp_sock *msk;
+	int local_ids = 0;
+
+	if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
+		return 1;
+
+	msk = bpf_core_cast(sk, struct mptcp_sock);
+	if (!msk || msk->pm.server_side || !msk->pm.subflows)
+		return 1;
+
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)sk) {
+		/* Here MPTCP-specific packet scheduler kfunc can be called:
+		 * this test is not doing anything really useful, only to
+		 * verify the iteration works.
+		 */
+
+		local_ids += subflow->subflow_id;
+
+		/* only to check the following helper works */
+		ssk = mptcp_subflow_tcp_sock(subflow);
+	}
+
+	if (!ssk)
+		goto out;
+
+	/* assert: if not OK, something wrong on the kernel side */
+	if (ssk->sk_dport != ((struct sock *)msk)->sk_dport)
+		goto out;
+
+	/* only to check the following kfunc works */
+	subflow = bpf_mptcp_subflow_ctx(ssk);
+	if (!subflow || subflow->token != msk->token)
+		goto out;
+
+	ids = local_ids;
+
+out:
+	return 1;
+}

-- 
2.48.1


