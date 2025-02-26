Return-Path: <bpf+bounces-52641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4107A460BD
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 14:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3964C7AA623
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 13:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2769223311;
	Wed, 26 Feb 2025 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cQZNmZ22"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A900022256D
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576216; cv=none; b=cS3PmvxOh20ej1TkeJt7X0F7I8GGOU1anhoBTxRKeFt9kjU+ZD1CIhTjdwRoITeWhVMgPCdLwQjJ0hdmns6k+f11ucqvS/dhozkLlHJ+exVH9+Xd77SOJ3BkxWUDXEzhdyLYmKqlOsd4A/CCOei83jmgbbBQ6sm+RH5pZM8tko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576216; c=relaxed/simple;
	bh=yAZjJLyw/IebtIgKWpxxhs5j/OrfIUla3tpApV7c8Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOSy+Bi380LNZtY2iwSBnp0OoMKnidmbo2lY+9ry7gR152DlSCWF9o3m7ScEM9+OmS1eO9z0Qs+u51gq2NOi6clpE9QeBpxoUWP3QbGRy03LpGca7/3T6X+phl+H4xL6EJn27GSojQE+jGGu46kxWG31YCxFgL79VI4hJZmSOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cQZNmZ22; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740576212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=um3l3VNEj+uJx+qVUO51g5IGTLRvS/+KRCLqs2rdvQc=;
	b=cQZNmZ22XPe0DWz5P6fT7i2mr0ueqZfyW3fr8Y23xHQhwH2Pj5psXHtwjNxf0Pgp7LAoMM
	BWM9PaHWlmwpDM3n3cQC2rwDWGUvvzrbbnnrJuk6n7fJ1ABb1UIAaQeIJRuJOYSldVOnUP
	fwhbdqXedGMHJyEJNmOwHRzme0QaJhM=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: cong.wang@bytedance.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
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
	mhal@rbox.co,
	jiayuan.chen@linux.dev,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mrpre@163.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Add edge case tests for sockmap
Date: Wed, 26 Feb 2025 21:22:42 +0800
Message-ID: <20250226132242.52663-4-jiayuan.chen@linux.dev>
In-Reply-To: <20250226132242.52663-1-jiayuan.chen@linux.dev>
References: <20250226132242.52663-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add edge case tests for sockmap.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1e3e4392dcca..e36b5c78fc98 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1042,6 +1042,61 @@ static void test_sockmap_vsock_unconnected(void)
 	xclose(map);
 }
 
+void *close_thread(void *arg)
+{
+	int fd = *(int *)arg;
+
+	sleep(1);
+	close(fd);
+	return NULL;
+}
+
+void test_sockmap_with_close_on_write(int family, int sotype)
+{
+	struct test_sockmap_pass_prog *skel;
+	int err, map, verdict, sent;
+	pthread_t tid;
+	int zero = 0;
+	int c = -1, p = -1;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (!ASSERT_OK(err, "create_pair"))
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &p, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	err = pthread_create(&tid, 0, close_thread, &p);
+	if (!ASSERT_OK(err, "pthread_create"))
+		goto out;
+
+	sent = xsend(c, "a", 1, 0);
+	if (!ASSERT_EQ(sent, 1, "xsend"))
+		goto out;
+
+	pthread_join(tid, NULL);
+	/* p was closed in thread */
+	p = -1;
+out:
+	if (c > 0)
+		close(c);
+	if (p > 0)
+		close(p);
+	test_sockmap_pass_prog__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -1108,4 +1163,6 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_vsock_poll();
 	if (test__start_subtest("sockmap vsock unconnected"))
 		test_sockmap_vsock_unconnected();
+	if (test__start_subtest("sockmap with unix and close"))
+		test_sockmap_with_close_on_write(AF_UNIX, SOCK_STREAM);
 }
-- 
2.47.1


