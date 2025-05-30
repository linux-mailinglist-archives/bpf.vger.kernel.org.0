Return-Path: <bpf+bounces-59389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D983AC9725
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1C11C21195
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 21:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EB22857DD;
	Fri, 30 May 2025 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="SC33JufI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B579D2
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640731; cv=none; b=W6RN+k69iuhmV3XJbKxUXzKRpILHaWPOBh2e7Xg7TnmHQK62+PTouRxwa1X7TKmYt7Yt/zArCY/Ou2wIf3z5eS2BG7WL4NbYOE4U7MYd66oyD4izcrNrxLvy5YW+HEaEY0jJPjUe3qoITWgEcDIClTFhqiHhW3yP2kvGlY1lHg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640731; c=relaxed/simple;
	bh=o9a+xNCjgudJ5tH89dUv/DqSsAKhhnP8ps7WmXupWJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDLCJYIsaye9DirJAbMXxee5zeBy67DYDD5FH81RD+rHxLvJ1sr1u7p7pGnZqZl5hX4E+uadEwkV7a/sTNRmYUCv/XvVVUTc7PGxhkRqhjIa8lYxWTfNLdgquuPR1qxOxrsAupg5WMu38CUgVbT77LG2ASg/dS4vCnZSsHsCuKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=SC33JufI; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b07698318ebso254029a12.2
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640729; x=1749245529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsg1Imq3Iaqqerb9v4F36jn+cpZ0N/qMBNajvolmUVA=;
        b=SC33JufIm42U5Jnwq2PY18GqZtBoycYV0A7Y6PZdBrkqxXVeHvz17b4h37h/TWF5xR
         ZMzMHItlW2xa+a4+lZAMEY0rLYoW3xAqI2C/LtPuZAssADOVzi7SNeeVLv/7ozA+jfg/
         uOfq1yGvJbNjLbYXAn0orIvTIlIL4JPApvGku3PJDJiGNJ6/e75jjNLoJ3f6PWuruDKu
         5SpJ2To3BiWcc//fKXjuv6zvIBBJEKSQGIv1nCLZw8A/y53psC/qUeZEzyn6ZMWFlvfF
         67doEBVWSo6k42lM7SWW6ltolDcL2o2vfNtAqV3U38o1j/cjM8WnVPcj2WnZqe706F6W
         5hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640729; x=1749245529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsg1Imq3Iaqqerb9v4F36jn+cpZ0N/qMBNajvolmUVA=;
        b=Lejpn/JY5lC0lT1UBzTcRBfXY9BI1lBPCe1Co16UoMIir0oMMltbHvw61UTejg+H+I
         xRMa8iKluYDu94g/6Dg9ZjxgTDbssjcuFEpq1X9CNiOgr6vYKjFGSAiSuTUfwYpsdqFB
         /BW5+0fVfAuDQgxchn9pSJuYgjNVTWi7oSMp6tHB5jeZ9iNJ38ktXWJwncvcj8n6IvMK
         gr7Toe0xOU44cbzzQVPRsNApDvNB6Z76mLkAHiUy3ikTYHB/RKHCqBpNwtKM3o6Y8vxX
         6QD964j0oOqbFg8Cd7vYTyktVsFWYoxlCisA0BABLt/EqeNtMrT5Q02IASdoynIHOsDu
         v+3A==
X-Forwarded-Encrypted: i=1; AJvYcCUM+4kdUoH3pg1IjR2IfugSNL5c9e6zGWshgVdq3gH8cqjNeg0yEHHqmcEi15vbCPwqoR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pnWDpJKZKind218tL2kD3Q5sIXR2ibHFeFjHvpSOdfKRD5xq
	yGhzAkKsnxltwCqH7xJkwatnBw8kiLC3yvFvy6v8UzMlVBzDhtBuJUGPo8w4gD9UFxA=
X-Gm-Gg: ASbGncsdv5kEqJ4xNqpLjxL6iQmXT8J/GQOOIwL0vDjEvSORb2iX0Thver1w2D8ba2w
	1w1cs2t5rKi+dafNOgIJuKp/zdRCG1futg3LVUHGHzTRIVfsNANCRgnFrzfm3+NWqLrUMjQisoj
	BPXgoP6HRVUWKcZyGNU3twE0n/7+yFURdxURGyFlgxSbtamgGmxGRLYV+zQDAtLjFn2zCg/rgrE
	85ZQ+tAsMGxOswWNbOwHYhTau0kREqiDOqzZ0negJZaqVkyILkT2ir8NdP/s5hShEbyHKXRF3vT
	FIg2z3kv1BKm/N1mRqJbm3+/YEo2HGgB3XCKm53I
X-Google-Smtp-Source: AGHT+IFA2JfZoC//C7qhevrM9EbhzF5EmCG2A7zuhT3O1iq4jpBXxysmanJCOku1AKmC/37DD/Qb8Q==
X-Received: by 2002:a05:6a00:464e:b0:736:6ecd:8e39 with SMTP id d2e1a72fcca58-747bd965a13mr2519893b3a.2.1748640729203;
        Fri, 30 May 2025 14:32:09 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:32:08 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 12/12] selftests/bpf: Add tests for bucket resume logic in established sockets
Date: Fri, 30 May 2025 14:30:54 -0700
Message-ID: <20250530213059.3156216-13-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530213059.3156216-1-jordan@jrife.io>
References: <20250530213059.3156216-1-jordan@jrife.io>
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
 .../bpf/prog_tests/sock_iter_batch.c          | 292 ++++++++++++++++++
 1 file changed, 292 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 2b0504cb127b..2cb1b1896332 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -119,6 +119,44 @@ static int get_nth_socket(int *fds, int fds_len, struct bpf_link *link, int n)
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
@@ -274,6 +349,51 @@ static void remove_unseen(int family, int sock_type, const char *addr,
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
@@ -303,6 +423,54 @@ static void remove_all(int family, int sock_type, const char *addr,
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
@@ -333,6 +501,49 @@ static void add_some(int family, int sock_type, const char *addr, __u16 port,
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
@@ -362,6 +573,24 @@ static void force_realloc(int family, int sock_type, const char *addr,
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
@@ -471,6 +700,69 @@ static struct test_case resume_tests[] = {
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


