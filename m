Return-Path: <bpf+bounces-60974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EB8ADF2AB
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D183BE6FE
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD462F362F;
	Wed, 18 Jun 2025 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="QUKT/fih"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B082F363B
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263967; cv=none; b=Bg9Z/sKdmFddmsy05bJ49lzqHzflN4wQQkTstvcD1aklkDEvhYSgMzLlfp9YMNk4E5PnPIYVHqMjNYHKmHPjRwe/T1bl21r+bdoyyCkbo1EaVAvNRCMwYViI5hbspdns4knUtoSgeilmhTOw9k3AOwV3NwfAIFRDoO1agqgPKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263967; c=relaxed/simple;
	bh=o9a+xNCjgudJ5tH89dUv/DqSsAKhhnP8ps7WmXupWJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJfF+5QW1rUGlTQVYyOXc9kJ1urgXaOR5TU5pfRDVOaX9eiXlhnhKLK/rkCahogR1mKhqmv/tLvxvX2pDsLyVFfvxiSitLwFvnQcyGjj02fMuBO2k7/u4ygF0/6GcTwNfBz0c4U96728B9qqa68l6qJ3vOGpx37xYtFm2tIXYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=QUKT/fih; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2369da67bacso1795235ad.3
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263965; x=1750868765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsg1Imq3Iaqqerb9v4F36jn+cpZ0N/qMBNajvolmUVA=;
        b=QUKT/fihL2+qqMEZooULR1OcN47nzWXyu92n7dco1jsFKrsa10SIOWomlOe1uRoBYa
         lzjn3OL0T6cY+MGhNuyk/Jsg8OVgH/n5dTJRf2agLTerIVQKxvEo1ucmrETpPuLR7wsJ
         y0dvTdkfa0tYtmZj+IzejvfjmwIQlET5Vy4DKWYbAVSOwrzPTSCL1vCetC9stMrnpH4h
         Sij5zQyemFkFR1joNo196GZbSvNwHJ0QYysDgc9aVXAin0VOG6DqF9E5vMrw57AsbTvu
         7Zya4kbGqYZJtw36dxniVX2xC6J5BsmdI+dgUkkytkzP7w0quOq5j3jhAKenZKFlTWTd
         YBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263965; x=1750868765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsg1Imq3Iaqqerb9v4F36jn+cpZ0N/qMBNajvolmUVA=;
        b=Is7r8pRa2WUjSbxfYc/ZWwZgoMoe6S8nCnNMWtD6qxdvOv3UemjcY6y66eAnmdnshH
         zSOAM/wVY4DR72+JGGBIF0H281aJfux2vNEGuJJPHwwRslDB5jfoY0PYHWiYgQdUSUZG
         hCMOd2sD3mVaoSNUG66beblddxf43tWJ9f7IMJDoDTleXHtVWEoBf8oW7AGCPk4Nir6u
         UWQdhq8pvAKaJ/BKwb0HqV67kDTcBC1wZmBOIyIDyyXHyl/ROwAOcA8JhAqGCc5EAvP7
         aDlB8DpzPoB9tMZh+JhJpP1hD7o4+unm721rrPZ+eqQlqHxfbYxwt7Gx57kpmMiTv+q9
         rlHg==
X-Forwarded-Encrypted: i=1; AJvYcCVUTe/vFud+LPPuU1f8o5bPsA3GJEPK4l/iIizsGfL8aH5eCMdHuujR/BtMpmQBckx+BJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ42qqLBFbFfj0ujQf1YMqRaPVHfqt/7mqyBjMNwBKoX8sDctE
	xKYNHXU0nUWpYvAXHbYRR5tJOJQICiLtZ9JGa4nuaLERTciZLsessZW3WTPwIOMzSYd1gzQEBW4
	7qTPlg7M=
X-Gm-Gg: ASbGncviCyi0pG2k8SJ+A7Toq6+CnaCISD1n2MopU5pBWc+yqMXu76WGNC56JJQkEoO
	xEW4ylDTvf4bcWVYiE4AS3Nf60xi1RjpM65YW9+1cglhynCO27bO8KrCo/iTrxoISXE0/CUHN3O
	/kzsrwg8vVfjR2DwD9kMK/BvESEl88N6S1k9gNt92lAWcfR6yS1jqi/imAZ6mxJgZpSNVru04IQ
	DUdnDTzEXmZg3tKL67PUtGDnUiRpcvwq8OpPmQHDH/5GVmUjadbb5ZRAino6Z2lO+EAtwbc6pP1
	2NZgNj+OcpO+i+ko15yiH29wxcMNN9ID0oFvRJjTXK/FwtW2/VmR9fgaNGiPFw==
X-Google-Smtp-Source: AGHT+IGbIT656Wf9do0hgMcrPV4fs5gy6mNGKbAgSksqYTyMdP7IPkqqBfcB/paQ+CLM4UQLB89nNw==
X-Received: by 2002:a17:90b:5242:b0:312:ec:411a with SMTP id 98e67ed59e1d1-313f1d54e39mr11780782a91.3.1750263962353;
        Wed, 18 Jun 2025 09:26:02 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:26:02 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 12/12] selftests/bpf: Add tests for bucket resume logic in established sockets
Date: Wed, 18 Jun 2025 09:25:43 -0700
Message-ID: <20250618162545.15633-13-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618162545.15633-1-jordan@jrife.io>
References: <20250618162545.15633-1-jordan@jrife.io>
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


