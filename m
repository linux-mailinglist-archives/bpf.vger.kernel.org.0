Return-Path: <bpf+bounces-63233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F57B04737
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 20:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE104E037B
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6CA271457;
	Mon, 14 Jul 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="mksxcI5z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB82B26F453
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516581; cv=none; b=trgkp4pCvd5xG7UuByN8LtcUgGot2xN+CSYyE8fIfAN0k/Hu55nf0phKlHvck2zdkqc7OPPsXGRkhU1Vgwz2JfJv9qTqba1QJdQYrOVr71eplDBodCSKlsLqnr+tyQpDUrp5wC5u5UAk+hS7M1jYu1cJbQtC1iqtgnQnT6ya4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516581; c=relaxed/simple;
	bh=ZrQoX9trtpMHS6GkCeWZvCYVSFvY33JSGGgIz9zVLyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVIyrxRabUhz3d/5HZDA7CdmrmfSGq66nM1C+baOKrlEqdNA+RhKl59n3rFDxncuQllLgm6rztmWrJTzQolMedHP+vm+0Yzl3L2PZ6E326c+7z4JbOfNNAwt0jZqrad9MV3ebjYULQ2L8sEt8dtjavZEWEO0Tfb7/DEIp0Z6NMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=mksxcI5z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235db423abdso2672075ad.1
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516579; x=1753121379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSMU4XIjfkLOO0Bu7VPk59BYTbjn6B5QwQtrU2dEnsE=;
        b=mksxcI5zWKeAWPwBqeG2D3L2DgvUginsuoUSJFFpKRmC0vOdpcatpX3m1bZvCh5CbU
         kNHNNxOe/qmGeS2HUfdY5rUEfgNt7M+HCdW6MqciOf9/XhG818p3znitBAQszL/pj4Q8
         bkdAuJtkB9FWRL3CGlBXC/lhiiVX91F7G8QlHcsG7jG7cOfRASTRTdimxlglOrJ5xoRW
         DnQzCQu2cdLWk8mukhH31LNb0hUOu8LXEJXeTksywVSyDWGTQVo4KHCc0tGftpkcf7wE
         7aYfzmojyTaFliF3ACqe276151gPa3lc9EakK42bOic1t2nocLzBDTGVtEfgp3BL7WRL
         tvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516579; x=1753121379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSMU4XIjfkLOO0Bu7VPk59BYTbjn6B5QwQtrU2dEnsE=;
        b=XP8bNmp3ETgyTew5e5y545AAKzZhsf8TmNCy5aassn2hwwSFHZFG8CiAerS+XR1Rd3
         ZSbAP83tZ/HlYrBLMx2maCktfpwUeeUZvSuWPgf3A2wdev3rk750NuECf2l4qw6mJQrX
         Zmxy8V3Ubt6Ig7iilFe06ghxuV2LjxrlM/k+Ph311Zk9a1eg1dHXuBhH0F5pFpUvL2kM
         pcojPbuImwxUBfFlsqQ4yKjC8of+x7DsQHylg2alfLIF6rBPmih2SBcjjz0p7ndmawX7
         oWcEWdFVlBaXhMjvATK9Ut+k5Sbuptj4YivvgLGrkwqKe/qQ8llbbRZCx9NqQZO+3Tiw
         KuGA==
X-Forwarded-Encrypted: i=1; AJvYcCUB4Fzxjv6M2nNk8KEI65KtJLhpjM/5G6sdzbroJ1OAojDGBLcLkApyLoxgeJD5Ru+IG14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI34g5IuzkuNLJqrrVrKiPOLpuORogSN4HRi3sJLEj96x5lqqa
	S4kmKIoBJ+xEQODTM4HpJ1urI2IKL3Nvr69vZxET7+PYwjUyxLay0UragAWLriQS2YI=
X-Gm-Gg: ASbGncse1l6xK/vPUZqkBzbujM/MPhNvoFaOU2TgW+7KhEHak67obDw/70i4RND0WG7
	Bbn4Ujjg1S3l3gt+zmLJ/5A3xou5jtJ/yt2YhfJ4fC/O1NJRIQXoKRMzeySsXWZA8k6h+2ubIy3
	BB1XJYiB0Kwhoi/4/EVNoUH/ew41LP0X/LlhimZiNImC6Dreh0x7lmhOrBv0sRbzYw9XsBqYfub
	23j2/MgNZJNjbxdeirSct2S44bTe+OgktVn0V4Ty4vtkeAyxpWIzsJmUYt0ClyCy+Jd4wS47laX
	U019TajhEIUA3Frn462FMmE8xP1qFuphxWpeLAfPaZnT1c95m3N+7J7RZccKiK/DWrrS9mO8+Sh
	hJCiWTUoKBQ==
X-Google-Smtp-Source: AGHT+IEL1EkU04ZfdXJFE/WeyZDZElxu38KsqI+5lDMPlrQtMXDwYW77U3LlVvw6lIJPwcNTAWOSYA==
X-Received: by 2002:a17:902:e80f:b0:22e:62c3:8c5d with SMTP id d9443c01a7336-23def904305mr70290995ad.8.1752516579036;
        Mon, 14 Jul 2025 11:09:39 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:38 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v6 bpf-next 10/12] selftests/bpf: Create established sockets in socket iterator tests
Date: Mon, 14 Jul 2025 11:09:14 -0700
Message-ID: <20250714180919.127192-11-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714180919.127192-1-jordan@jrife.io>
References: <20250714180919.127192-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for bucket resume tests for established TCP sockets by creating
established sockets. Collect socket fds from connect() and accept()
sides and pass them to test cases.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 92 ++++++++++++++++++-
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 18da2d901af7..c8d0e23dbe03 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2024 Meta
 
+#include <poll.h>
 #include <test_progs.h>
 #include "network_helpers.h"
 #include "sock_iter_batch.skel.h"
@@ -153,8 +154,74 @@ static void check_n_were_seen_once(int *fds, int fds_len, int n,
 	ASSERT_EQ(seen_once, n, "seen_once");
 }
 
+static int accept_from_one(struct pollfd *server_poll_fds,
+			   int server_poll_fds_len)
+{
+	static const int poll_timeout_ms = 5000; /* 5s */
+	int ret;
+	int i;
+
+	ret = poll(server_poll_fds, server_poll_fds_len, poll_timeout_ms);
+	if (!ASSERT_EQ(ret, 1, "poll"))
+		return -1;
+
+	for (i = 0; i < server_poll_fds_len; i++)
+		if (server_poll_fds[i].revents & POLLIN)
+			return accept(server_poll_fds[i].fd, NULL, NULL);
+
+	return -1;
+}
+
+static int *connect_to_server(int family, int sock_type, const char *addr,
+			      __u16 port, int nr_connects, int *server_fds,
+			      int server_fds_len)
+{
+	struct pollfd *server_poll_fds = NULL;
+	struct network_helper_opts opts = {
+		.timeout_ms = 0,
+	};
+	int *established_socks = NULL;
+	int i;
+
+	server_poll_fds = calloc(server_fds_len, sizeof(*server_poll_fds));
+	if (!ASSERT_OK_PTR(server_poll_fds, "server_poll_fds"))
+		return NULL;
+
+	for (i = 0; i < server_fds_len; i++) {
+		server_poll_fds[i].fd = server_fds[i];
+		server_poll_fds[i].events = POLLIN;
+	}
+
+	i = 0;
+
+	established_socks = malloc(sizeof(*established_socks) * nr_connects*2);
+	if (!ASSERT_OK_PTR(established_socks, "established_socks"))
+		goto error;
+
+	while (nr_connects--) {
+		established_socks[i] = connect_to_addr_str(family, sock_type,
+							   addr, port, &opts);
+		if (!ASSERT_OK_FD(established_socks[i], "connect_to_addr_str"))
+			goto error;
+		i++;
+		established_socks[i] = accept_from_one(server_poll_fds,
+						       server_fds_len);
+		if (!ASSERT_OK_FD(established_socks[i], "accept_from_one"))
+			goto error;
+		i++;
+	}
+
+	free(server_poll_fds);
+	return established_socks;
+error:
+	free_fds(established_socks, i);
+	free(server_poll_fds);
+	return NULL;
+}
+
 static void remove_seen(int family, int sock_type, const char *addr, __u16 port,
-			int *socks, int socks_len, struct sock_count *counts,
+			int *socks, int socks_len, int *established_socks,
+			int established_socks_len, struct sock_count *counts,
 			int counts_len, struct bpf_link *link, int iter_fd)
 {
 	int close_idx;
@@ -185,6 +252,7 @@ static void remove_seen(int family, int sock_type, const char *addr, __u16 port,
 
 static void remove_unseen(int family, int sock_type, const char *addr,
 			  __u16 port, int *socks, int socks_len,
+			  int *established_socks, int established_socks_len,
 			  struct sock_count *counts, int counts_len,
 			  struct bpf_link *link, int iter_fd)
 {
@@ -217,6 +285,7 @@ static void remove_unseen(int family, int sock_type, const char *addr,
 
 static void remove_all(int family, int sock_type, const char *addr,
 		       __u16 port, int *socks, int socks_len,
+		       int *established_socks, int established_socks_len,
 		       struct sock_count *counts, int counts_len,
 		       struct bpf_link *link, int iter_fd)
 {
@@ -244,7 +313,8 @@ static void remove_all(int family, int sock_type, const char *addr,
 }
 
 static void add_some(int family, int sock_type, const char *addr, __u16 port,
-		     int *socks, int socks_len, struct sock_count *counts,
+		     int *socks, int socks_len, int *established_socks,
+		     int established_socks_len, struct sock_count *counts,
 		     int counts_len, struct bpf_link *link, int iter_fd)
 {
 	int *new_socks = NULL;
@@ -274,6 +344,7 @@ static void add_some(int family, int sock_type, const char *addr, __u16 port,
 
 static void force_realloc(int family, int sock_type, const char *addr,
 			  __u16 port, int *socks, int socks_len,
+			  int *established_socks, int established_socks_len,
 			  struct sock_count *counts, int counts_len,
 			  struct bpf_link *link, int iter_fd)
 {
@@ -302,10 +373,12 @@ static void force_realloc(int family, int sock_type, const char *addr,
 
 struct test_case {
 	void (*test)(int family, int sock_type, const char *addr, __u16 port,
-		     int *socks, int socks_len, struct sock_count *counts,
+		     int *socks, int socks_len, int *established_socks,
+		     int established_socks_len, struct sock_count *counts,
 		     int counts_len, struct bpf_link *link, int iter_fd);
 	const char *description;
 	int ehash_buckets;
+	int connections;
 	int init_socks;
 	int max_socks;
 	int sock_type;
@@ -416,6 +489,7 @@ static void do_resume_test(struct test_case *tc)
 	static const __u16 port = 10001;
 	struct nstoken *nstoken = NULL;
 	struct bpf_link *link = NULL;
+	int *established_fds = NULL;
 	int err, iter_fd = -1;
 	const char *addr;
 	int *fds = NULL;
@@ -444,6 +518,14 @@ static void do_resume_test(struct test_case *tc)
 				     tc->init_socks);
 	if (!ASSERT_OK_PTR(fds, "start_reuseport_server"))
 		goto done;
+	if (tc->connections) {
+		established_fds = connect_to_server(tc->family, tc->sock_type,
+						    addr, port,
+						    tc->connections, fds,
+						    tc->init_socks);
+		if (!ASSERT_OK_PTR(established_fds, "connect_to_server"))
+			goto done;
+	}
 	skel->rodata->ports[0] = 0;
 	skel->rodata->ports[1] = 0;
 	skel->rodata->sf = tc->family;
@@ -465,13 +547,15 @@ static void do_resume_test(struct test_case *tc)
 		goto done;
 
 	tc->test(tc->family, tc->sock_type, addr, port, fds, tc->init_socks,
-		 counts, tc->max_socks, link, iter_fd);
+		 established_fds, tc->connections*2, counts, tc->max_socks,
+		 link, iter_fd);
 done:
 	close_netns(nstoken);
 	SYS_NOFAIL("ip netns del " TEST_CHILD_NS);
 	SYS_NOFAIL("sysctl -w net.ipv4.tcp_child_ehash_entries=0");
 	free(counts);
 	free_fds(fds, tc->init_socks);
+	free_fds(established_fds, tc->connections*2);
 	if (iter_fd >= 0)
 		close(iter_fd);
 	bpf_link__destroy(link);
-- 
2.43.0


