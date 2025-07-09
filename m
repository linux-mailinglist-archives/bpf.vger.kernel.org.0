Return-Path: <bpf+bounces-62859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1487AFF532
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4025450CA
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501D72566F5;
	Wed,  9 Jul 2025 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="gQhFUrEC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6492472BC
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102234; cv=none; b=hXPaMq02JOgsz35ao1EFjFwpqzFItBX6EGTKE2LcNqVUWy0aOiVcIjBjB18essFdqgyZuhf3hY/YcJSp4ooQ1xC+Dhaf85Piib/ovKNk7RxqWTWGmBXIy8TqHH0D2MGQ1s9SzDuChF3xFJ71YveBWnGxUyYZnCxuoKgXiZbbpOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102234; c=relaxed/simple;
	bh=NO2AEdfDrft3TBs7uZfz1u2aMDGke50WpT54xjzO3cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpzBTyL6STBZtNSRY93qulsgrRx12fqKboLDhvDgN6Tm5ELld7lga+tWtp4Yboa54D1dhIxNVRcbRiJuQFVNMvppaQh/wL3+5mIs7aBHwftF8mts/kbiAOfmbjqvc9m6IY9KxrlUjPrnfs0ypk9fjRAbVDwWEBPTTstSbIrPuI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=gQhFUrEC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234eaea2e4eso728865ad.0
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 16:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102232; x=1752707032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhIodY+h73YH/HcwG7KHMvnkgB704oqzMHqkGl2N/0Y=;
        b=gQhFUrECWr+q6FsSoSclQ+NG3FrqmELlScjfV8mtBYGP6Hn2xcqgy8BMNsZxoATeHv
         +Vs6sulYXkA9k4/FTZghw27AO1L7HTz1SmxqXtEGR5sDT5lUHucUvQZdgvoqMepN4r3n
         Tjpacvhpr5I/6I4/P1Y/7c2RFv7y0rDYCjy7jXbWCID61Y4t0sAPUWumYNS4YdnRLziL
         JQpGctvVa4BG0jaulLTfYJZV3ciFoXUkotENhF8Kc8gyuYvlHwz3zSb3wnRF1qrmh2+R
         F5plTDI/iE1gSch5AnQuaiFlJzUc/M8LxQgf00G/eslv48ZWpJTxalX0z0i/xojRMKQA
         Wawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102232; x=1752707032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhIodY+h73YH/HcwG7KHMvnkgB704oqzMHqkGl2N/0Y=;
        b=fCl7p1/xdyCUH5JReJGUm1EQUXbHl1j3ASAejW0p5s3k/ujP00uB3AOXAgVsMtuDVm
         BzqF+3nQxpVAlbsnHfB0v++jIaSgChA/qZ005Gfz9rtw45fF7Tt89Ik8jrcuCUp7x7jr
         e5sipVCjaub32KYuXjj1XTbtQAJgcXLqMvKNrfGJ++mliED0E2QTnOHVRvYggQvadciv
         NXBvCbIVcGs4L7jy7HRQgYbM9Vx5XQucYWvr793xTwMoBkWk5rGmxh5gGmic6zU7IUj8
         AGwSe8ErzZjlX5iOwcYfHnD4a/7FsPfNqEB41TU5tRaWPspMVZDnkNerK5H3htOsPCrG
         1jXA==
X-Forwarded-Encrypted: i=1; AJvYcCU4SXTta5Pl2gh6FC9O0HxI9PQ0qb08cEY4CpIgqizUPmMu3qnf19Z+E4wT4ovqXhuEYSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeyd5h7NVuzIzLZwUNB5lp5mjm+oJsJ/SiyCNXOW0QScjhJXRQ
	ETIi81pnT8JUiekOi7N+JUs7BMhaPyfSRR/6NjW6F6DNTM8EQ6CQv4Gq5VCz/rbfDro=
X-Gm-Gg: ASbGncsu1nvcIygdOnYkP6sHwvQOHO52Ah7YGTLNMxqf+mnSXEO99+O2MszeU/P+o13
	+29Z16yXr3lq2onvYASKcdoM3+GRLVJwWZTIzuQgagS+Vccn13XYa4JSDfjvNUSKJ3dYzny4daX
	3ojvLB8w8sJbODrPBnt+yP7ERNPhK6rWjXSGbXMkzqCMoy0/4X2De6k5ohSHmAy+ZXDw1fdRyQv
	kVmP9k2RpDHBHQKOJJiEn0NAHTU1v7KzpUZKKcTEdYpUgCtfyXd6xB4zw7ch04eBe+EHlC9uvH6
	oN/jzBg/cHM5L2m5B7cK2Q3SM6XF+aX43/qlmMkoFOm2ocZCF1E=
X-Google-Smtp-Source: AGHT+IHXhBlAPw6BmkzmbiYB6UyYpmbnO8UCaHU7yV3l2haBNDLAZGQTCc98arJ4F4jyi0j+qPSt+Q==
X-Received: by 2002:a17:902:ce82:b0:234:e170:88f3 with SMTP id d9443c01a7336-23ddb1df18cmr25297525ad.8.1752102232428;
        Wed, 09 Jul 2025 16:03:52 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:52 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 12/12] selftests/bpf: Add tests for bucket resume logic in established sockets
Date: Wed,  9 Jul 2025 16:03:32 -0700
Message-ID: <20250709230333.926222-13-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709230333.926222-1-jordan@jrife.io>
References: <20250709230333.926222-1-jordan@jrife.io>
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
 .../bpf/prog_tests/sock_iter_batch.c          | 293 ++++++++++++++++++
 1 file changed, 293 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index d21b7a918700..5125d5ea2f94 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -119,6 +119,45 @@ static int get_nth_socket(int *fds, int fds_len, struct bpf_link *link, int n)
 	return nth_sock_idx;
 }
 
+static void destroy(int fd)
+{
+	struct sock_iter_batch *skel = NULL;
+	__u64 cookie = socket_cookie(fd);
+	struct bpf_link *link = NULL;
+	int iter_fd = -1;
+	int nread;
+	__u64 out;
+
+	skel = sock_iter_batch__open();
+	if (!ASSERT_OK_PTR(skel, "sock_iter_batch__open"))
+		goto done;
+
+	skel->rodata->destroy_cookie = cookie;
+
+	if (!ASSERT_OK(sock_iter_batch__load(skel), "sock_iter_batch__load"))
+		goto done;
+
+	link = bpf_program__attach_iter(skel->progs.iter_tcp_destroy, NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
+		goto done;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_OK_FD(iter_fd, "bpf_iter_create"))
+		goto done;
+
+	/* Delete matching socket. */
+	nread = read(iter_fd, &out, sizeof(out));
+	ASSERT_GE(nread, 0, "nread");
+	if (nread)
+		ASSERT_EQ(out, cookie, "cookie matches");
+done:
+	if (iter_fd >= 0)
+		close(iter_fd);
+	bpf_link__destroy(link);
+	sock_iter_batch__destroy(skel);
+	close(fd);
+}
+
 static int get_seen_count(int fd, struct sock_count counts[], int n)
 {
 	__u64 cookie = socket_cookie(fd);
@@ -241,6 +280,43 @@ static void remove_seen(int family, int sock_type, const char *addr, __u16 port,
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
+	close_idx = get_nth_socket(established_socks, established_socks_len,
+				   link, listen_socks_len + 1);
+	if (!ASSERT_GE(close_idx, 0, "close_idx"))
+		return;
+	destroy(established_socks[close_idx]);
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
@@ -274,6 +350,51 @@ static void remove_unseen(int family, int sock_type, const char *addr,
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
+	destroy(established_socks[close_idx]);
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
@@ -303,6 +424,54 @@ static void remove_all(int family, int sock_type, const char *addr,
 	ASSERT_EQ(read_n(iter_fd, -1, counts, counts_len), 0, "read_n");
 }
 
+static void remove_all_established(int family, int sock_type, const char *addr,
+				   __u16 port, int *listen_socks,
+				   int listen_socks_len, int *established_socks,
+				   int established_socks_len,
+				   struct sock_count *counts, int counts_len,
+				   struct bpf_link *link, int iter_fd)
+{
+	int *close_idx = NULL;
+	int i;
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
+	close_idx = malloc(sizeof(int) * (established_socks_len - 1));
+	if (!ASSERT_OK_PTR(close_idx, "close_idx malloc"))
+		return;
+	for (i = 0; i < established_socks_len - 1; i++) {
+		close_idx[i] = get_nth_socket(established_socks,
+					      established_socks_len, link,
+					      listen_socks_len + i);
+		if (!ASSERT_GE(close_idx[i], 0, "close_idx"))
+			return;
+	}
+
+	for (i = 0; i < established_socks_len - 1; i++) {
+		destroy(established_socks[close_idx[i]]);
+		established_socks[close_idx[i]] = -1;
+	}
+
+	/* Make sure there are no more sockets returned */
+	ASSERT_EQ(read_n(iter_fd, -1, counts, counts_len), 0, "read_n");
+	free(close_idx);
+}
+
 static void add_some(int family, int sock_type, const char *addr, __u16 port,
 		     int *socks, int socks_len, int *established_socks,
 		     int established_socks_len, struct sock_count *counts,
@@ -333,6 +502,49 @@ static void add_some(int family, int sock_type, const char *addr, __u16 port,
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
@@ -362,6 +574,24 @@ static void force_realloc(int family, int sock_type, const char *addr,
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
@@ -471,6 +701,69 @@ static struct test_case resume_tests[] = {
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


