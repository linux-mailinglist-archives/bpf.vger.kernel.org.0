Return-Path: <bpf+bounces-67920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B70BB503F4
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE87188BC80
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2BF3168F5;
	Tue,  9 Sep 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="CdYDpQl2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE0371EB1
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437243; cv=none; b=ZLsj2AVCFFkuPq6Qug6vJhZQx3zBu0H42K5ZM2qW1fgQn99XQQ4OeiJgmgikTQt3MgrRrXxDk2jRbwnG0sJRkDw/otWqfU41Z+0RsKJRsLHWJ6DaY2aG71d/GtuEmIIRW+/SEUGQip+Pttrma5Dfw3GR03CbXa3F8KTPzkxyt8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437243; c=relaxed/simple;
	bh=+h0USvHVSOjVlYs4CQ7D6pRgCwNmz3LEbxwllF2zr7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNjGX5LI42S9IFQ1U08LjkqdekdldIWPuMpzP/sLbaLGQSsu2PMVoLxLttRfba+molsQKmIB43jcEEo8J/NQK57Ay+FrP6CrAORubCL0uYOAhuch88R2Pa6aOl3EeSJf62xjXV3ciZYULftjD4Bv77CAzKLKjws3a0vWFNq7K+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=CdYDpQl2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24cb267c50eso8799785ad.0
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437240; x=1758042040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQ2N5xxnmus4ZpffddOCN7KvCKEZCAM6yJZL2PBeUoE=;
        b=CdYDpQl2tAmwxjN6snzWnOydKcWuUpN9ar/QM8ZyazyfFIVpyHsTsu0ldKHD/GEiAx
         nwWInIJoqFy0pDL3x9vWRffk6g4Vg21XmtIJ2W3rGdV1CM0Xn3MpwsCijuUdUbenvHpM
         777I2OWsqiHBgIu6kkAR0aIFgzQvj3ySfiDQeNRr59AXuMiqYvm/8YkTu8gS/m7zrkfh
         PB+XNM31luEXyTQg+rAx1OTe5n3y/JygigtwQiLwrXI7LnfaikkvJinC6M8tx0kPSaJh
         wbk8H78orKA5N/X6BD9XmNub0Sbr5xJZR2XfYw6vLUrCfSrB7Ih9GQqvg4sL3vQ0dj8x
         jyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437240; x=1758042040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQ2N5xxnmus4ZpffddOCN7KvCKEZCAM6yJZL2PBeUoE=;
        b=fcHHKdIsVoThIvo54lHanlG0FfSM0M+Sxuvxp6iezwj6a4pBVjfy2ooVCSgajeGka5
         JZjkn4PlSN2iHTFm9GsplRPXeo11zS2w94ZWLald711kYpVcrqzSoeW8j35rq7V5OOc6
         C+vmlOyZmWMXqWOWz6HSX4QPQT0PZC5L7V/3c+8E3tnZ8GA4gyrf5wXha8V4ajh8JpR5
         AY+0c0gxmbnmsCSsWkCyOyWt0HWCxTOpRYsXynK4CX5MEpWMHq1VAt9o/bGoglG3NDJ0
         fAtuc6ktyPs+B9j5TnoyETFkgX60GVlTDXPmFOPxMqXbEriyGQXHOE7xUJiMVOYw+04v
         ua0Q==
X-Gm-Message-State: AOJu0Yz0yfbCYxCKyMDOZMiv3dVWFIwPU+l69H3CFeaNXM1RaHSEA2KW
	LC3yu+Fsj3ohXohT3KujiVFKHTo59hNenNyw/bncCASr698ZeQ8pik5FImpMPMSYVDgK5wlDMk2
	ss2U5
X-Gm-Gg: ASbGncsgC2n0hKQ4BORyiLhWDcFO/p0D34uJg9clvMgfYPpOp9V3G/ahjAKgoY/QVlt
	ULHaQqu7WyMVV8+svXLyaOsPsqbFc9WjJ9e7P8Ic6CPC1gJbWFdjfABn/jZIjWRDgqYQIOBsdy1
	ZuohyZTSXsw/DA85iHR5EUTbKW+FwuQ8LK5spVlzoF13KY+JEId8SqKnnlGpEWCXwV0sApJaIPr
	kF6V8iMh6c8321DiDorFQ8VwXKNRTtYypSrXDbm+t4EEhv2q+GbRHaUQOoiZScC/+Gk1q1HEO+a
	8QU+apOjMYUZih+F/JPqHeuE/eEqESsDymQgkFQfcpWw9kXEFKMI2ULouXkeQTErb87u61fpRRW
	XFrPsYNFiQUTjjwgP4N3RpEl6
X-Google-Smtp-Source: AGHT+IE9OIP6hyYkXnoOOQf7QFy+S02KfxFAr3zaX7ZXSsugbY/CYTyitnChhkMQ1hniUlegxCeOpw==
X-Received: by 2002:a17:903:2442:b0:24e:4248:3d9b with SMTP id d9443c01a7336-2517121749dmr75274395ad.4.1757437238831;
        Tue, 09 Sep 2025 10:00:38 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:38 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 10/14] selftests/bpf: Socket map + sockops insert and destroy
Date: Tue,  9 Sep 2025 10:00:04 -0700
Message-ID: <20250909170011.239356-11-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a sockops program to automatically insert sockets into a socket map
and socket hash and use BPF iterators with key prefix bucketing and
filtering to destroy the set of sockets connected to the same remote
port regardless of protocol. This test wraps things up by demonstrating
the desired end to end flow and showing how all the pieces are meant to
fit together.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 277 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_sockmap.c    |  14 +
 .../selftests/bpf/progs/test_sockmap_update.c |  43 +++
 3 files changed, 334 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1e3e4392dcca..00afa377cf7d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -16,6 +16,7 @@
 #include "bpf_iter_sockmap.skel.h"
 
 #include "sockmap_helpers.h"
+#include "network_helpers.h"
 
 #define TCP_REPAIR		19	/* TCP sock is under repair right now */
 
@@ -364,6 +365,280 @@ static void test_sockmap_copy(enum bpf_map_type map_type)
 	bpf_iter_sockmap__destroy(skel);
 }
 
+#define TEST_NS "sockmap_basic"
+
+struct sock_hash_key {
+	__u32 bucket_key;
+	__u64 cookie;
+} __packed;
+
+static void close_fds(int fds[], int fds_len)
+{
+	int i;
+
+	for (i = 0; i < fds_len; i++)
+		if (fds[i] >= 0)
+			close(fds[i]);
+}
+
+static __u64 socket_cookie(int fd)
+{
+	__u64 cookie;
+	socklen_t cookie_len = sizeof(cookie);
+
+	if (!ASSERT_OK(getsockopt(fd, SOL_SOCKET, SO_COOKIE, &cookie,
+				  &cookie_len), "getsockopt(SO_COOKIE)"))
+		return 0;
+	return cookie;
+}
+
+static bool has_socket(struct bpf_map *map, __u64 sk_cookie, int key_size)
+{
+	void *prev_key = NULL, *key = NULL;
+	int map_fd = bpf_map__fd(map);
+	bool found = false;
+	__u64 cookie;
+	int err;
+
+	key = malloc(key_size);
+	if (!ASSERT_OK_PTR(key, "malloc(key_size)"))
+		goto cleanup;
+
+	prev_key = malloc(key_size);
+	if (!ASSERT_OK_PTR(key, "malloc(key_size)"))
+		goto cleanup;
+
+	err = bpf_map__get_next_key(map, NULL, key, key_size);
+	if (!ASSERT_OK(err, "get_next_key"))
+		goto cleanup;
+
+	do {
+		err = bpf_map_lookup_elem(map_fd, key, &cookie);
+		if (!err)
+			found = sk_cookie == cookie;
+		else if (!ASSERT_EQ(err, -ENOENT, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		memcpy(prev_key, key, key_size);
+	} while (!found &&
+		 bpf_map__get_next_key(map, prev_key, key, key_size) == 0);
+cleanup:
+	if (prev_key)
+		free(prev_key);
+	if (key)
+		free(key);
+	return found;
+}
+
+static void test_sockmap_insert_sockops_and_destroy(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct test_sockmap_update *update_skel = NULL;
+	static const int port0 = 10000, port1 = 10001;
+	int prog_fd = -1, cg_fd = -1, iter_fd = -1;
+	struct bpf_iter_sockmap *iter_skel = NULL;
+	__u32 key_prefix = htonl((__u32)port0);
+	int accept_serv[4] = {-1, -1, -1, -1};
+	int tcp_clien[4] = {-1, -1, -1, -1};
+	union bpf_iter_link_info linfo = {};
+	int tcp_serv[4] = {-1, -1, -1, -1};
+	struct nstoken *nstoken = NULL;
+	int tcp_clien_cookies[4] = {};
+	struct bpf_link *link = NULL;
+	char buf[64];
+	int len;
+	int i;
+
+	SYS_NOFAIL("ip netns del " TEST_NS);
+	SYS(cleanup, "ip netns add %s", TEST_NS);
+	SYS(cleanup, "ip -net %s link set dev lo up", TEST_NS);
+
+	nstoken = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto cleanup;
+
+	cg_fd = test__join_cgroup("/sockmap_basic");
+	if (!ASSERT_OK_FD(cg_fd, "join_cgroup"))
+		goto cleanup;
+
+	update_skel = test_sockmap_update__open_and_load();
+	if (!ASSERT_OK_PTR(update_skel, "test_sockmap_update__open_and_load"))
+		goto cleanup;
+
+	iter_skel = bpf_iter_sockmap__open_and_load();
+	if (!ASSERT_OK_PTR(iter_skel, "bpf_iter_sockmap__open_and_load"))
+		goto cleanup;
+
+	if (!ASSERT_OK(bpf_prog_attach(bpf_program__fd(update_skel->progs.insert_sock),
+				       cg_fd, BPF_CGROUP_SOCK_OPS,
+				       BPF_F_ALLOW_OVERRIDE),
+		       "bpf_prog_attach"))
+		goto cleanup;
+
+	/* Create two servers on each port, port0 and port1, and connect a
+	 * client to each.
+	 */
+	tcp_serv[0] = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", port0, 0);
+	if (!ASSERT_OK_FD(tcp_serv[0], "start_server"))
+		goto cleanup;
+
+	tcp_serv[1] = start_server(AF_INET6, SOCK_STREAM, "::1", port0, 0);
+	if (!ASSERT_OK_FD(tcp_serv[1], "start_server"))
+		goto cleanup;
+
+	tcp_serv[2] = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", port1, 0);
+	if (!ASSERT_OK_FD(tcp_serv[2], "start_server"))
+		goto cleanup;
+
+	tcp_serv[3] = start_server(AF_INET6, SOCK_STREAM, "::1", port1, 0);
+	if (!ASSERT_OK_FD(tcp_serv[3], "start_server"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(tcp_serv); i++) {
+		tcp_clien[i] = connect_to_fd(tcp_serv[i], 0);
+		if (!ASSERT_OK_FD(tcp_clien[i], "connect_to_fd"))
+			goto cleanup;
+
+		accept_serv[i] = accept(tcp_serv[i], NULL, NULL);
+		if (!ASSERT_OK_FD(accept_serv[i], "accept"))
+			goto cleanup;
+	}
+
+	/* Ensure that sockets are connected. */
+	for (i = 0; i < ARRAY_SIZE(tcp_clien); i++)
+		if (!ASSERT_EQ(send(tcp_clien[i], "a", 1, 0), 1, "send"))
+			goto cleanup;
+
+	/* Ensure that client sockets exist in the map and the hash. */
+	if (!ASSERT_EQ(update_skel->bss->count,
+		       ARRAY_SIZE(tcp_clien) + ARRAY_SIZE(udp_clien),
+		       "count"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(tcp_clien); i++)
+		tcp_clien_cookies[i] = socket_cookie(tcp_clien[i]);
+
+	for (i = 0; i < ARRAY_SIZE(tcp_clien); i++) {
+		if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_map,
+					    tcp_clien_cookies[i],
+					    sizeof(__u32)),
+				 "has_socket"))
+			goto cleanup;
+
+		if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_hash,
+					    tcp_clien_cookies[i],
+					    sizeof(struct sock_hash_key)),
+				 "has_socket"))
+			goto cleanup;
+	}
+
+	/* Destroy sockets connected to port0. */
+	linfo.map.map_fd = bpf_map__fd(update_skel->maps.sock_hash);
+	linfo.map.sock_hash.key_prefix = (__u64)(void *)&key_prefix;
+	linfo.map.sock_hash.key_prefix_len = sizeof(key_prefix);
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+	link = bpf_program__attach_iter(iter_skel->progs.destroy, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
+		goto cleanup;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_OK_FD(iter_fd, "bpf_iter_create"))
+		goto cleanup;
+
+	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
+		;
+	if (!ASSERT_GE(len, 0, "read"))
+		goto cleanup;
+
+	/* Ensure that sockets connected to port0 were destroyed. */
+	if (!ASSERT_LT(send(tcp_clien[0], "a", 1, 0), 0, "send"))
+		goto cleanup;
+	if (!ASSERT_EQ(errno, ECONNABORTED, "ECONNABORTED"))
+		goto cleanup;
+
+	if (!ASSERT_LT(send(tcp_clien[1], "a", 1, 0), 0, "send"))
+		goto cleanup;
+	if (!ASSERT_EQ(errno, ECONNABORTED, "ECONNABORTED"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(send(tcp_clien[2], "a", 1, 0), 1, "send"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(send(tcp_clien[3], "a", 1, 0), 1, "send"))
+		goto cleanup;
+
+	/* Close and ensure that sockets are removed from maps. */
+	close(tcp_clien[0]);
+	close(tcp_clien[1]);
+
+	/* Ensure that the sockets connected to port0 were removed from the
+	 * maps.
+	 */
+	if (!ASSERT_FALSE(has_socket(update_skel->maps.sock_map,
+				     tcp_clien_cookies[0],
+				     sizeof(__u32)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_FALSE(has_socket(update_skel->maps.sock_map,
+				     tcp_clien_cookies[1],
+				     sizeof(__u32)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_map,
+				    tcp_clien_cookies[2],
+				    sizeof(__u32)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_map,
+				    tcp_clien_cookies[3],
+				    sizeof(__u32)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_FALSE(has_socket(update_skel->maps.sock_hash,
+				     tcp_clien_cookies[0],
+				     sizeof(struct sock_hash_key)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_FALSE(has_socket(update_skel->maps.sock_hash,
+				     tcp_clien_cookies[1],
+				     sizeof(struct sock_hash_key)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_hash,
+				    tcp_clien_cookies[2],
+				    sizeof(struct sock_hash_key)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_hash,
+				    tcp_clien_cookies[3],
+				    sizeof(struct sock_hash_key)),
+			 "has_socket"))
+		goto cleanup;
+cleanup:
+	close_fds(accept_serv, ARRAY_SIZE(accept_serv));
+	close_fds(tcp_clien, ARRAY_SIZE(tcp_clien));
+	close_fds(tcp_serv, ARRAY_SIZE(tcp_serv));
+	if (prog_fd >= 0)
+		bpf_prog_detach(cg_fd, BPF_CGROUP_SOCK_OPS);
+	if (cg_fd >= 0)
+		close(cg_fd);
+	if (iter_fd >= 0)
+		close(iter_fd);
+	bpf_link__destroy(link);
+	test_sockmap_update__destroy(update_skel);
+	bpf_iter_sockmap__destroy(iter_skel);
+	close_netns(nstoken);
+	SYS_NOFAIL("ip netns del " TEST_NS);
+}
+
 static void test_sockmap_skb_verdict_attach(enum bpf_attach_type first,
 					    enum bpf_attach_type second)
 {
@@ -1064,6 +1339,8 @@ void test_sockmap_basic(void)
 		test_sockmap_copy(BPF_MAP_TYPE_SOCKMAP);
 	if (test__start_subtest("sockhash copy"))
 		test_sockmap_copy(BPF_MAP_TYPE_SOCKHASH);
+	if (test__start_subtest("sock(map|hash) sockops insert and destroy"))
+		test_sockmap_insert_sockops_and_destroy();
 	if (test__start_subtest("sockmap skb_verdict attach")) {
 		test_sockmap_skb_verdict_attach(BPF_SK_SKB_VERDICT,
 						BPF_SK_SKB_STREAM_VERDICT);
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
index 317fe49760cc..9eb2bee443c1 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
@@ -57,3 +57,17 @@ int copy(struct bpf_iter__sockmap *ctx)
 	ret = bpf_map_delete_elem(&dst, &tmp);
 	return ret && ret != -ENOENT;
 }
+
+SEC("iter/sockmap")
+int destroy(struct bpf_iter__sockmap *ctx)
+{
+	struct sock *sk = ctx->sk;
+	void *key = ctx->key;
+
+	if (!key || !sk)
+		return 0;
+
+	bpf_sock_destroy((struct sock_common *)sk);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_update.c b/tools/testing/selftests/bpf/progs/test_sockmap_update.c
index 6d64ea536e3d..eb84753c6a1a 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_update.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_update.c
@@ -45,4 +45,47 @@ int copy_sock_map(void *ctx)
 	return failed ? SK_DROP : SK_PASS;
 }
 
+__u32 count = 0;
+
+struct sock_hash_key {
+	__u32 bucket_key;
+	__u64 cookie;
+} __attribute__((__packed__));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 16);
+	__ulong(map_extra, offsetof(struct sock_hash_key, cookie));
+	__type(key, struct sock_hash_key);
+	__type(value, __u64);
+} sock_hash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 16);
+	__type(key, __u32);
+	__type(value, __u64);
+} sock_map SEC(".maps");
+
+SEC("sockops")
+int insert_sock(struct bpf_sock_ops *skops)
+{
+	struct sock_hash_key key = {
+		.bucket_key = skops->remote_port,
+		.cookie     = bpf_get_socket_cookie(skops),
+	};
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
+		bpf_sock_hash_update(skops, &sock_hash, &key, BPF_NOEXIST);
+		bpf_sock_map_update(skops, &sock_map, &count, BPF_NOEXIST);
+		count++;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


