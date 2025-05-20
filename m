Return-Path: <bpf+bounces-58578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802BFABDDDA
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C228A20CD
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323312528F9;
	Tue, 20 May 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="VBfTH0tB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1855124C06A
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752691; cv=none; b=t2fiUL69me4YCWiYVCGvx04M7GWOKZnkJooKgJroYSPv3Yvvbw35yrMceeXcX6PotS/j0UoF2VOoBDFsH5ePPkGOt1dqih1jWvF3i1qP1s/StYnPnsL0icN64AyTa54yH2+MmRDOthXoz5q0lmPlI1Ins1fgoKCAs/NLCXUvb7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752691; c=relaxed/simple;
	bh=uSr4x49PDr9ZXwI2vF7mnRwL2E6/FOtgzemo2B45RS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVt0Yp7pbLYj82aMomXbNbq4Hy2J2nCh2R562RQM9pe/0GPmyR23+X8n4qm45sm67QnvJsXlYY9JYnrB1rViXRsvytbEWdWIbbA7FpkGbu9Iv8h1EDVrvc1jW069HiBkJt9KJno2d7UWi1N5Qp0xaxJFTUut3e0H+xvKRWZ8G/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=VBfTH0tB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c1145a38so494547b3a.3
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752689; x=1748357489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2i/y9zOLCNlUgSgHvl580ugReZupnq3VMN/q9SzffM=;
        b=VBfTH0tBnEg73dzPfDT3N7QxPp6PPotAIgQlbeNeBcZvCdcRGE+1NUS0AOZ2apKpzD
         niAEkvDNjQjngTcQWgr6YWmi+PCkaOWNiu7dBcGFkU7EdHqM6qmqiXxVGVTjpJ733WEo
         vQVrIFJgo1sA9tDpj4o0Kh2lz4tmkhkO9m2+5fxI+Mg35GhzAnVA9uF0WvpOQGbuRNoP
         th7zu+yloQCfoAtvlDpZnWhHRP3m4QW262TwImp/35WHF2rBnsVIT6UrCMcQAh4sc2ha
         6kVVJIvUi9WuIPeITOm7yJ33n+/ughV19CCAP2pyBCu408o2Gt1oULhNeUap196PrKV7
         c2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752689; x=1748357489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2i/y9zOLCNlUgSgHvl580ugReZupnq3VMN/q9SzffM=;
        b=ais4ssSCG2NUFEc1sMHupgTY66CyICIfVp/RsBcC/HSXw93OeAOlMKaf/0H60JaFDK
         BqDLjsVa7NRBdK+9nPqDeuu7DTDftPoO7QKEpSbgAO3VKhNYVt09p7HufMXVlOHbgLI4
         uGZL0JK9qYjtwibIGDu3ZmCZKHFgnNKWqguQt5TvI67wR2ZeWxZiJ1flw+D5Fh5nDcDT
         ytNdBHX9U8HoYiuG6CUtZuhTHk912nOpzJq0iKum3hCU03MB6JPvoADw/6461ieecTVY
         50Z/XWACQ+ngRIctdhFqjAM9u1a2QxWBPVbtcOor+DSZiLCbwso0fbS89mveMeUNIV+/
         +eEA==
X-Forwarded-Encrypted: i=1; AJvYcCXNYxz0xhNXe0Qc09vyMMnZFC7BaOVyLySNvDavNAh5LzXjdkVIrqfx+MN7vQ2JdrtS41A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXKz/5Q/Pg6RZfn87SL6Jp5AgAlzm42E0ytkWmreaapmwkXdMn
	Uzes0+3Fnt+RpozrDkikbB3rrzpjyyxYxtkSZsNIcMmU6cxNAwoX0OvhLBDQQmqVWLpK3GU2htB
	ftkHAYvc=
X-Gm-Gg: ASbGnctC1uqAdbWXC66XZ7Sp0edvLTErmpBWNjujU3bU9aUsnTTTha3TRrfR81maAyW
	Kd6yknFdKRO8YPtuDYlX67uMfI5Uudk8rbtg2O41pxh0RQh/7YovZoe29t0RAAwfoZy87uioLCS
	dxj+Spjzm9BqbrP/ZGbRfbqCJ1cQIJiAOQK3vX5WTmIC9F4I2Z//VhO4unMPrQ7xSLDykmrjIgD
	hORrrfBYgc8HIm9zs0flqqi53GOzjF260fWCiScRk6A8hKjmSJmOgP9A+QTftgCv01y8L2PDjXq
	CLhymACUrJaIyO+nfXVQ5p3XjKon2NoTxZS2pv/I5t+kbZYWX2g=
X-Google-Smtp-Source: AGHT+IG3vEO8Ztm2SNFvNLFj+7X83Esu1zmICZeqh7qZKgyI+uz0bSXBQLVrrIAlkrVtBNNWjVm0gQ==
X-Received: by 2002:a05:6a00:ab87:b0:726:380a:282f with SMTP id d2e1a72fcca58-742a9780577mr9048855b3a.2.1747752689340;
        Tue, 20 May 2025 07:51:29 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:29 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 10/10] selftests/bpf: Add tests for bucket resume logic in established sockets
Date: Tue, 20 May 2025 07:50:57 -0700
Message-ID: <20250520145059.1773738-11-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520145059.1773738-1-jordan@jrife.io>
References: <20250520145059.1773738-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replicate the set of test cases used for UDP socket iterators to test
similar scenarios for TCP established sockets.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 286 ++++++++++++++++++
 1 file changed, 286 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index f14adda52f53..44fbb527594d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -119,6 +119,44 @@ static int get_nth_socket(int *fds, int fds_len, struct bpf_link *link, int n)
 	return nth_sock_idx;
 }
 
+static bool close_and_wait(int fd, struct bpf_link *link)
+{
+	static const int us_per_ms = 1000;
+	__u64 cookie = socket_cookie(fd);
+	struct iter_out out;
+	bool exists = true;
+	int iter_fd, nread;
+	int waits = 20; /* 2 seconds */
+
+	close(fd);
+
+	/* Wait for socket to disappear from the ehash table. */
+	while (waits--) {
+		iter_fd = bpf_iter_create(bpf_link__fd(link));
+		if (!ASSERT_OK_FD(iter_fd, "bpf_iter_create"))
+			return false;
+
+		/* Is it still there? */
+		do {
+			nread = read(iter_fd, &out, sizeof(out));
+			if (!ASSERT_GE(nread, 0, "nread")) {
+				close(iter_fd);
+				return false;
+			}
+			exists = nread && cookie == out.cookie;
+		} while (!exists && nread);
+
+		close(iter_fd);
+
+		if (!exists)
+			break;
+
+		usleep(100 * us_per_ms);
+	}
+
+	return !exists;
+}
+
 static int get_seen_count(int fd, struct sock_count counts[], int n)
 {
 	__u64 cookie = socket_cookie(fd);
@@ -241,6 +279,43 @@ static void remove_seen(int family, int sock_type, const char *addr, __u16 port,
 			       counts_len);
 }
 
+static void remove_seen_established(int family, int sock_type, const char *addr,
+				    __u16 port, int *listen_socks,
+				    int listen_socks_len, int *established_socks,
+				    int established_socks_len,
+				    struct sock_count *counts, int counts_len,
+				    struct bpf_link *link, int iter_fd)
+{
+	int close_idx;
+
+	/* Iterate through all listening sockets. */
+	read_n(iter_fd, listen_socks_len, counts, counts_len);
+
+	/* Make sure we saw all listening sockets exactly once. */
+	check_n_were_seen_once(listen_socks, listen_socks_len, listen_socks_len,
+			       counts, counts_len);
+
+	/* Leave one established socket. */
+	read_n(iter_fd, established_socks_len - 1, counts, counts_len);
+
+	/* Close a socket we've already seen to remove it from the bucket. */
+	close_idx = get_seen_socket(established_socks, counts, counts_len);
+	if (!ASSERT_GE(close_idx, 0, "close_idx"))
+		return;
+	ASSERT_TRUE(close_and_wait(established_socks[close_idx], link),
+		    "close_and_wait");
+	established_socks[close_idx] = -1;
+
+	/* Iterate through the rest of the sockets. */
+	read_n(iter_fd, -1, counts, counts_len);
+
+	/* Make sure the last socket wasn't skipped and that there were no
+	 * repeats.
+	 */
+	check_n_were_seen_once(established_socks, established_socks_len,
+			       established_socks_len - 1, counts, counts_len);
+}
+
 static void remove_unseen(int family, int sock_type, const char *addr,
 			  __u16 port, int *socks, int socks_len,
 			  int *established_socks, int established_socks_len,
@@ -274,6 +349,52 @@ static void remove_unseen(int family, int sock_type, const char *addr,
 			       counts_len);
 }
 
+static void remove_unseen_established(int family, int sock_type,
+				      const char *addr, __u16 port,
+				      int *listen_socks, int listen_socks_len,
+				      int *established_socks,
+				      int established_socks_len,
+				      struct sock_count *counts, int counts_len,
+				      struct bpf_link *link, int iter_fd)
+{
+	int close_idx;
+
+	/* Iterate through all listening sockets. */
+	read_n(iter_fd, listen_socks_len, counts, counts_len);
+
+	/* Make sure we saw all listening sockets exactly once. */
+	check_n_were_seen_once(listen_socks, listen_socks_len, listen_socks_len,
+			       counts, counts_len);
+
+	/* Iterate through the first established socket. */
+	read_n(iter_fd, 1, counts, counts_len);
+
+	/* Make sure we saw one established socks. */
+	check_n_were_seen_once(established_socks, established_socks_len, 1,
+			       counts, counts_len);
+
+	/* Close what would be the next socket in the bucket to exercise the
+	 * condition where we need to skip past the first cookie we remembered.
+	 */
+	close_idx = get_nth_socket(established_socks, established_socks_len,
+				   link, listen_socks_len + 1);
+	if (!ASSERT_GE(close_idx, 0, "close_idx"))
+		return;
+
+	ASSERT_TRUE(close_and_wait(established_socks[close_idx], link),
+		    "close_and_wait");
+	established_socks[close_idx] = -1;
+
+	/* Iterate through the rest of the sockets. */
+	read_n(iter_fd, -1, counts, counts_len);
+
+	/* Make sure the remaining sockets were seen exactly once and that we
+	 * didn't repeat the socket that was already seen.
+	 */
+	check_n_were_seen_once(established_socks, established_socks_len,
+			       established_socks_len - 1, counts, counts_len);
+}
+
 static void remove_all(int family, int sock_type, const char *addr,
 		       __u16 port, int *socks, int socks_len,
 		       int *established_socks, int established_socks_len,
@@ -303,6 +424,47 @@ static void remove_all(int family, int sock_type, const char *addr,
 	ASSERT_EQ(read_n(iter_fd, -1, counts, counts_len), 0, "read_n");
 }
 
+static void remove_all_established(int family, int sock_type, const char *addr,
+				   __u16 port, int *listen_socks,
+				   int listen_socks_len, int *established_socks,
+				   int established_socks_len,
+				   struct sock_count *counts, int counts_len,
+				   struct bpf_link *link, int iter_fd)
+{
+	int close_idx, i;
+
+	/* Iterate through all listening sockets. */
+	read_n(iter_fd, listen_socks_len, counts, counts_len);
+
+	/* Make sure we saw all listening sockets exactly once. */
+	check_n_were_seen_once(listen_socks, listen_socks_len, listen_socks_len,
+			       counts, counts_len);
+
+	/* Iterate through the first established socket. */
+	read_n(iter_fd, 1, counts, counts_len);
+
+	/* Make sure we saw one established socks. */
+	check_n_were_seen_once(established_socks, established_socks_len, 1,
+			       counts, counts_len);
+
+	/* Close all remaining sockets to exhaust the list of saved cookies and
+	 * exit without putting any sockets into the batch on the next read.
+	 */
+	for (i = 0; i < established_socks_len - 1; i++) {
+		close_idx = get_nth_socket(established_socks,
+					   established_socks_len, link,
+					   listen_socks_len + 1);
+		if (!ASSERT_GE(close_idx, 0, "close_idx"))
+			return;
+		ASSERT_TRUE(close_and_wait(established_socks[close_idx], link),
+			    "close_and_wait");
+		established_socks[close_idx] = -1;
+	}
+
+	/* Make sure there are no more sockets returned */
+	ASSERT_EQ(read_n(iter_fd, -1, counts, counts_len), 0, "read_n");
+}
+
 static void add_some(int family, int sock_type, const char *addr, __u16 port,
 		     int *socks, int socks_len, int *established_socks,
 		     int established_socks_len, struct sock_count *counts,
@@ -333,6 +495,49 @@ static void add_some(int family, int sock_type, const char *addr, __u16 port,
 	free_fds(new_socks, socks_len);
 }
 
+static void add_some_established(int family, int sock_type, const char *addr,
+				 __u16 port, int *listen_socks,
+				 int listen_socks_len, int *established_socks,
+				 int established_socks_len,
+				 struct sock_count *counts,
+				 int counts_len, struct bpf_link *link,
+				 int iter_fd)
+{
+	int *new_socks = NULL;
+
+	/* Iterate through all listening sockets. */
+	read_n(iter_fd, listen_socks_len, counts, counts_len);
+
+	/* Make sure we saw all listening sockets exactly once. */
+	check_n_were_seen_once(listen_socks, listen_socks_len, listen_socks_len,
+			       counts, counts_len);
+
+	/* Iterate through the first established_socks_len - 1 sockets. */
+	read_n(iter_fd, established_socks_len - 1, counts, counts_len);
+
+	/* Make sure we saw established_socks_len - 1 sockets exactly once. */
+	check_n_were_seen_once(established_socks, established_socks_len,
+			       established_socks_len - 1, counts, counts_len);
+
+	/* Double the number of established sockets in the bucket. */
+	new_socks = connect_to_server(family, sock_type, addr, port,
+				      established_socks_len / 2, listen_socks,
+				      listen_socks_len);
+	if (!ASSERT_OK_PTR(new_socks, "connect_to_server"))
+		goto done;
+
+	/* Iterate through the rest of the sockets. */
+	read_n(iter_fd, -1, counts, counts_len);
+
+	/* Make sure each of the original sockets was seen exactly once. */
+	check_n_were_seen_once(listen_socks, listen_socks_len, listen_socks_len,
+			       counts, counts_len);
+	check_n_were_seen_once(established_socks, established_socks_len,
+			       established_socks_len, counts, counts_len);
+done:
+	free_fds(new_socks, established_socks_len);
+}
+
 static void force_realloc(int family, int sock_type, const char *addr,
 			  __u16 port, int *socks, int socks_len,
 			  int *established_socks, int established_socks_len,
@@ -362,6 +567,24 @@ static void force_realloc(int family, int sock_type, const char *addr,
 	free_fds(new_socks, socks_len);
 }
 
+static void force_realloc_established(int family, int sock_type,
+				      const char *addr, __u16 port,
+				      int *listen_socks, int listen_socks_len,
+				      int *established_socks,
+				      int established_socks_len,
+				      struct sock_count *counts, int counts_len,
+				      struct bpf_link *link, int iter_fd)
+{
+	/* Iterate through all sockets to trigger a realloc. */
+	read_n(iter_fd, -1, counts, counts_len);
+
+	/* Make sure each socket was seen exactly once. */
+	check_n_were_seen_once(listen_socks, listen_socks_len, listen_socks_len,
+			       counts, counts_len);
+	check_n_were_seen_once(established_socks, established_socks_len,
+			       established_socks_len, counts, counts_len);
+}
+
 struct test_case {
 	void (*test)(int family, int sock_type, const char *addr, __u16 port,
 		     int *socks, int socks_len, int *established_socks,
@@ -471,6 +694,69 @@ static struct test_case resume_tests[] = {
 		.family = AF_INET6,
 		.test = force_realloc,
 	},
+	{
+		.description = "tcp: resume after removing a seen socket (established)",
+		/* Force all established sockets into one bucket */
+		.ehash_buckets = 1,
+		.connections = nr_soreuse,
+		.init_socks = nr_soreuse,
+		/* Room for connect()ed and accept()ed sockets */
+		.max_socks = nr_soreuse * 3,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_seen_established,
+	},
+	{
+		.description = "tcp: resume after removing one unseen socket (established)",
+		/* Force all established sockets into one bucket */
+		.ehash_buckets = 1,
+		.connections = nr_soreuse,
+		.init_socks = nr_soreuse,
+		/* Room for connect()ed and accept()ed sockets */
+		.max_socks = nr_soreuse * 3,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_unseen_established,
+	},
+	{
+		.description = "tcp: resume after removing all unseen sockets (established)",
+		/* Force all established sockets into one bucket */
+		.ehash_buckets = 1,
+		.connections = nr_soreuse,
+		.init_socks = nr_soreuse,
+		/* Room for connect()ed and accept()ed sockets */
+		.max_socks = nr_soreuse * 3,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_all_established,
+	},
+	{
+		.description = "tcp: resume after adding a few sockets (established)",
+		/* Force all established sockets into one bucket */
+		.ehash_buckets = 1,
+		.connections = nr_soreuse,
+		.init_socks = nr_soreuse,
+		/* Room for connect()ed and accept()ed sockets */
+		.max_socks = nr_soreuse * 3,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = add_some_established,
+	},
+	{
+		.description = "tcp: force a realloc to occur (established)",
+		/* Force all established sockets into one bucket */
+		.ehash_buckets = 1,
+		/* Bucket size will need to double when going from listening to
+		 * established sockets.
+		 */
+		.connections = init_batch_size,
+		.init_socks = nr_soreuse,
+		/* Room for connect()ed and accept()ed sockets */
+		.max_socks = nr_soreuse + (init_batch_size * 2),
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = force_realloc_established,
+	},
 };
 
 static void do_resume_test(struct test_case *tc)
-- 
2.43.0


