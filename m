Return-Path: <bpf+bounces-62531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ED0AFB803
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BC31898E06
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CBB21ABB7;
	Mon,  7 Jul 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="awwbb23U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B7219A8A
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903482; cv=none; b=FrYi3gJZAfNGjnpIukkbLPAUDy2m8knZakub4NxDBtj+YlB1+yGzpnqrIF7J01PJ7M9raLPh/jP8OhUsCJD+92GSlbHWxNjsmzfl237XEwIsxm3+I2lXQMIGOSVNwfmzoZSuSDNJnyFg9tZX4evR4ozJ6/CgDNtqNTKqU4GpqwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903482; c=relaxed/simple;
	bh=Qfz5W+kBzk0ALQvaktO0O8WJb1rvJHyV51fTo3LPPXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9QYwJNTW5Q84HM3/69ENmuNyGpCTqIIUMUhijM+6aDmLnCuDH39Ut/5nwZRgogQbv5PFzk4OQG5vidy8RyLDVImVKY8zjGvtkMcnsdZuSf5EXjePmV5Pq5QCDFff9rUb7Jxpw33JWi3IabjMzxW0W354LCWXeMyd7IoFavck60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=awwbb23U; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2369dd5839dso4792565ad.3
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903480; x=1752508280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05ov+T5n9BEKTxmfOYn08NF2ipokkSRnsb3r66QuKro=;
        b=awwbb23U5PAa9T1DwhIgF46AA5r2OmoE05QnVr1sAvYPve6GIaXHabgm1s9Y3Ey24g
         AgrbrjCCAe80SeHENgLxUMb8mCS69Pq4iVlWc1y+qXR5Lq+zLv75Hk8NUErIIMQk0ev0
         EO7bTFsJAcUypCTx6nHU8IDLxcuy80oD/3yIh8lt0U6pIu6OtAF8Rkv6ljDozcOFTWVZ
         v3ANiJ5/53isSC1v8S4u4hhrsFd8BeoidSqf/HsFCZnU6mHgTbiezXxzvdkXyfqAwp92
         pWyfMfwSjB4yxToHgRE0nozjmOyFzvmWtLXDrrUqIjfqzCmSHzSWEeMYngcjNoPbDcsT
         QT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903480; x=1752508280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05ov+T5n9BEKTxmfOYn08NF2ipokkSRnsb3r66QuKro=;
        b=AvRvA1+IN7XYb6ZPecZZ5kqZPxpau6aLvEm9lW9uj8TCCBSL+b6X8f2Ey7aldhzT3d
         vFfQFwa5Bu+YnFK3FEUlYZiyTAUOXXygCdcUke7VUBr7e+yB1iTBdGPSNGx5pxObAsye
         Ss+l9V1hBC/V8eiPoLN+p4nVw8WYZ7qxuUPnObZazjrAHqhmNsA7CtztjZbk7mCER3i7
         HH7YzCnvrNuGF4tzSGlBy/rlmWwgYqyXG4sVTiGocwwPgTJzMj/slwq/iZBpdi2OVbI1
         0I7qV9okOT5H7LX8e+Dxoe5GaPoBlhg9A4iDiTsrmk2VcotaRQI4hLKmdMTzP3ZnO+2B
         MKsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9pP62ZrHstuN0X/VO1ldJNeI5/jfOSoCfiddCgkNu6uRj67qCnUL21gCa3OEagqDYV88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQN3o0gJOKeP5gyUjZIapdKyocrwTI7O0r7Fic2Xso6xLpS2nx
	QG57wWNneRr5DKwueoDgrbnUIgiTDDJmxVUN9MA/SRSAzCFh6k877KpiwS6JP/si+Oc=
X-Gm-Gg: ASbGncuRPoYsIRY9169eA8rByruNFQn6gdPUxsPOUaZdA0k4F/HzpKTY+LJDS7N+F6s
	PMF2DEoWUtean0gPItKzWGLOMZdHbajJ4fGF/8zfCuo0Vyoi3X237GVbZjFmWo5/9VhQSCEgIlz
	fXeUP84Vb6qQIQ0ypiHs1Z0YXtqGelV9GI2/a9zBZ2AuxydSBOkM6dvH/0xuHqkFF/TB03X9PDi
	OVKooTU4RZTTZzCRSHmUpvNiuA1s9kEDTQZ1GB7c27DjULhuL1fDthufasHJGylRTyIa12JSxLY
	b27+ORAw8QB6qQJUbNhochNfNgCB0KFLi6O+TXaZJ8TGRYv9Nzw=
X-Google-Smtp-Source: AGHT+IHodps7KpTSt4J9Lz39GpbHngR2t6R449GtoUg+sCohN4ZNm5er2ZZ/iwn0Ah7IF8qwnvhf4g==
X-Received: by 2002:a17:903:41c6:b0:236:9302:bf11 with SMTP id d9443c01a7336-23c873f3b9fmr69788985ad.13.1751903480475;
        Mon, 07 Jul 2025 08:51:20 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:20 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 10/12] selftests/bpf: Create established sockets in socket iterator tests
Date: Mon,  7 Jul 2025 08:50:58 -0700
Message-ID: <20250707155102.672692-11-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707155102.672692-1-jordan@jrife.io>
References: <20250707155102.672692-1-jordan@jrife.io>
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
 .../bpf/prog_tests/sock_iter_batch.c          | 83 ++++++++++++++++++-
 1 file changed, 79 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 18da2d901af7..d21b7a918700 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -153,8 +153,66 @@ static void check_n_were_seen_once(int *fds, int fds_len, int n,
 	ASSERT_EQ(seen_once, n, "seen_once");
 }
 
+static int accept_from_one(int *server_fds, int server_fds_len)
+{
+	int fd;
+	int i;
+
+	for (i = 0; i < server_fds_len; i++) {
+		fd = accept(server_fds[i], NULL, NULL);
+		if (fd >= 0)
+			return fd;
+		if (!ASSERT_EQ(errno, EWOULDBLOCK, "EWOULDBLOCK"))
+			return -1;
+	}
+
+	return -1;
+}
+
+static int *connect_to_server(int family, int sock_type, const char *addr,
+			      __u16 port, int nr_connects, int *server_fds,
+			      int server_fds_len)
+{
+	struct network_helper_opts opts = {
+		.timeout_ms = 0,
+	};
+	int *established_socks;
+	int i;
+
+	/* Make sure accept() doesn't block. */
+	for (i = 0; i < server_fds_len; i++)
+		if (!ASSERT_OK(fcntl(server_fds[i], F_SETFL, O_NONBLOCK),
+			       "fcntl(O_NONBLOCK)"))
+			return NULL;
+
+	established_socks = malloc(sizeof(int) * nr_connects*2);
+	if (!ASSERT_OK_PTR(established_socks, "established_socks"))
+		return NULL;
+
+	i = 0;
+
+	while (nr_connects--) {
+		established_socks[i] = connect_to_addr_str(family, sock_type,
+							   addr, port, &opts);
+		if (!ASSERT_OK_FD(established_socks[i], "connect_to_addr_str"))
+			goto error;
+		i++;
+		established_socks[i] = accept_from_one(server_fds,
+						       server_fds_len);
+		if (!ASSERT_OK_FD(established_socks[i], "accept_from_one"))
+			goto error;
+		i++;
+	}
+
+	return established_socks;
+error:
+	free_fds(established_socks, i);
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
@@ -185,6 +243,7 @@ static void remove_seen(int family, int sock_type, const char *addr, __u16 port,
 
 static void remove_unseen(int family, int sock_type, const char *addr,
 			  __u16 port, int *socks, int socks_len,
+			  int *established_socks, int established_socks_len,
 			  struct sock_count *counts, int counts_len,
 			  struct bpf_link *link, int iter_fd)
 {
@@ -217,6 +276,7 @@ static void remove_unseen(int family, int sock_type, const char *addr,
 
 static void remove_all(int family, int sock_type, const char *addr,
 		       __u16 port, int *socks, int socks_len,
+		       int *established_socks, int established_socks_len,
 		       struct sock_count *counts, int counts_len,
 		       struct bpf_link *link, int iter_fd)
 {
@@ -244,7 +304,8 @@ static void remove_all(int family, int sock_type, const char *addr,
 }
 
 static void add_some(int family, int sock_type, const char *addr, __u16 port,
-		     int *socks, int socks_len, struct sock_count *counts,
+		     int *socks, int socks_len, int *established_socks,
+		     int established_socks_len, struct sock_count *counts,
 		     int counts_len, struct bpf_link *link, int iter_fd)
 {
 	int *new_socks = NULL;
@@ -274,6 +335,7 @@ static void add_some(int family, int sock_type, const char *addr, __u16 port,
 
 static void force_realloc(int family, int sock_type, const char *addr,
 			  __u16 port, int *socks, int socks_len,
+			  int *established_socks, int established_socks_len,
 			  struct sock_count *counts, int counts_len,
 			  struct bpf_link *link, int iter_fd)
 {
@@ -302,10 +364,12 @@ static void force_realloc(int family, int sock_type, const char *addr,
 
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
@@ -416,6 +480,7 @@ static void do_resume_test(struct test_case *tc)
 	static const __u16 port = 10001;
 	struct nstoken *nstoken = NULL;
 	struct bpf_link *link = NULL;
+	int *established_fds = NULL;
 	int err, iter_fd = -1;
 	const char *addr;
 	int *fds = NULL;
@@ -444,6 +509,14 @@ static void do_resume_test(struct test_case *tc)
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
@@ -465,13 +538,15 @@ static void do_resume_test(struct test_case *tc)
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


