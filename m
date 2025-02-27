Return-Path: <bpf+bounces-52758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C11A481BC
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 15:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A07424D9B
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03508234989;
	Thu, 27 Feb 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nwmWaF96"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC92309A3
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666440; cv=none; b=bUBBNkuGT0GGjzHDfDm7krnDlEFGykUlnJHb0BlWJNd9iZ+f/Sya835bBrwfY6v8lxgFqYoXqaKdowQgBfYglQKhZN8UhGd3tUFnaRLtnLt67LMDA9ZhHnal5xWKWD/V53Oz6hbq1v6Z7aXCE2TPLX5PKIkhX0Vz4sr2/wEzfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666440; c=relaxed/simple;
	bh=9NJh4qWBaG6Re9XAkRIRu/sfCXk4U7OusKRVt14Xt5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awyCHsw/sNqxgHBkpspfCMq7GG7hYcqTUis56VF0Sn13PCENNmevAMeKREc8q/JR3/PDvFztS/nmK2srm9AoTrWAhfiw0iJi8vph1vcG5aqfJxQbyqnEiqJetDqnoMJtMbX9gV2M9IkeqAqV1taFUYLpiGnnohRtrDKKfgkg1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nwmWaF96; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740666436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7AvVgItQBcIy3/yElChkvzIw9QALk+tx+dIFetvRkg=;
	b=nwmWaF96KstZUIDUwvmXpOsGOBzSQAJeUTep86aEKE0QY40D4ZU8xwstYHcScmI/ZkCKud
	BZ2OaoQXOqd07v0dJJA5DKbILtc0UF32ch5v9wEG1G7rObojUixm0EvtJX4vMlCUZrENFQ
	lN8Ykv+OXzoFmEIvecUy6DvzYcOBviY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH bpf-next v1 1/3] selftests/bpf: Allow auto port binding for cgroup connect
Date: Thu, 27 Feb 2025 22:26:44 +0800
Message-ID: <20250227142646.59711-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250227142646.59711-1-jiayuan.chen@linux.dev>
References: <20250227142646.59711-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allow auto port binding for cgroup connect test to avoid binding conflict.

Result:
./test_progs -a cgroup_v1v2
59      cgroup_v1v2:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/cgroup_v1v2.c  | 13 +++++++++----
 .../testing/selftests/bpf/progs/connect4_dropper.c  |  4 +++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
index 64abba72ac10..37c1cc52ed98 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
@@ -10,12 +10,18 @@
 static int run_test(int cgroup_fd, int server_fd, bool classid)
 {
 	struct connect4_dropper *skel;
-	int fd, err = 0;
+	int fd, err = 0, port;
 
 	skel = connect4_dropper__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return -1;
 
+	port = get_socket_local_port(server_fd);
+	if (!ASSERT_GE(port, 0, "get_socket_local_port"))
+		return -1;
+
+	skel->bss->port = ntohs(port);
+
 	skel->links.connect_v4_dropper =
 		bpf_program__attach_cgroup(skel->progs.connect_v4_dropper,
 					   cgroup_fd);
@@ -48,10 +54,9 @@ void test_cgroup_v1v2(void)
 {
 	struct network_helper_opts opts = {};
 	int server_fd, client_fd, cgroup_fd;
-	static const int port = 60120;
 
 	/* Step 1: Check base connectivity works without any BPF. */
-	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_GE(server_fd, 0, "server_fd"))
 		return;
 	client_fd = connect_to_fd_opts(server_fd, &opts);
@@ -66,7 +71,7 @@ void test_cgroup_v1v2(void)
 	cgroup_fd = test__join_cgroup("/connect_dropper");
 	if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
 		return;
-	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_GE(server_fd, 0, "server_fd")) {
 		close(cgroup_fd);
 		return;
diff --git a/tools/testing/selftests/bpf/progs/connect4_dropper.c b/tools/testing/selftests/bpf/progs/connect4_dropper.c
index d3f4c5e4fb69..a3819a5d09c8 100644
--- a/tools/testing/selftests/bpf/progs/connect4_dropper.c
+++ b/tools/testing/selftests/bpf/progs/connect4_dropper.c
@@ -13,12 +13,14 @@
 #define VERDICT_REJECT	0
 #define VERDICT_PROCEED	1
 
+int port;
+
 SEC("cgroup/connect4")
 int connect_v4_dropper(struct bpf_sock_addr *ctx)
 {
 	if (ctx->type != SOCK_STREAM)
 		return VERDICT_PROCEED;
-	if (ctx->user_port == bpf_htons(60120))
+	if (ctx->user_port == bpf_htons(port))
 		return VERDICT_REJECT;
 	return VERDICT_PROCEED;
 }
-- 
2.47.1


