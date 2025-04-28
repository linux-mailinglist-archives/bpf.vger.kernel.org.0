Return-Path: <bpf+bounces-56860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C4CA9F7ED
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 20:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CD757AC147
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA3D2951C4;
	Mon, 28 Apr 2025 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="l3TX4guu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04161296D31
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863259; cv=none; b=lTFvHFxVCXohwy/OnGGepCvaIYhvmPygvXvKiuf8+QM6Q+bQPOn6S85ZVDVODAVgYG0EmeDusTChfoq+EqWK9F1Te1ZrGXfkXvkTxLGeqYJc4Kd0suLl7FBoa5Y/YNf46Xi9qHxMTlXCxeZJECpij5huIVhPVmNv0c8fBX1z+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863259; c=relaxed/simple;
	bh=cNXWBHt6J7e3H+76Mh3BMIenbMHu29MKu1h73tRrASw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQvvBLH69MZ9/2FOTrKBZSRygF7Z9DSkJurLAofz9nYo2WQTlIF1sBoLvMHDiyAvb8cq5xzVqT9m+w+VO3I5w6hEPiZcYOFOKiitLU3XyHJ0zQJDOpvyExPzAhWQ3IE40qlWuLeeL33D7Pw/LaJSQaL1c4/ZrSHEF1lBgTXi050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=l3TX4guu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22de5af5e14so441335ad.1
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745863257; x=1746468057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaKbW65uYaVDYGMsoIHJ/fjnTr1nbMz9f/dqAmx8e2I=;
        b=l3TX4guulRbjuYJdPi9rZwS7lVzsZjudoMKN+LtXdvyPjTkA7gNqLpmMnCDq2G/ECN
         FNyBLT7mzt9wQY9wC/EqvjLlunPXHIT5iLZMd+UaB+Oo/O3A3puNJQane7Xb7Gm+TAo4
         e9T12K8cigxQEFAI+cZeL0Tix0T9GtyZuIbJqvE+jz9h1AmWHlnKxHAeNWkiMIGZ1wp9
         r645Ke6uaSZ7/sptVBBMesXrpv3Vd0QjBgPnw5zEwrI1WKEnTD9FKKA4KNwBHp6lpq7V
         ORXqFY0sISBJVZRXuP1xSFXiv8JKXCGmch8sbwgJzWI6tCtQerxWyn5WYp13JzVJGf34
         zhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863257; x=1746468057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaKbW65uYaVDYGMsoIHJ/fjnTr1nbMz9f/dqAmx8e2I=;
        b=XOieNTsRA7KVvfZt7tO79VWIM2KyazKTxDgwBk3j8XfD73Y5if0gGqqk8QGZiE1TXT
         goMHq1GjMQm6JN+FGilpd6HCt/RqW3xZ/G+M4/2wwJ8UUs5LH2sV8OROke8G8CKZxr2W
         T4zP1FRfHFf0pNl0nyxyWoJAXDseBWsf4INQRdmicBvdG+Tl2ulFD5UB1T8VefC7zGhi
         G3yTCJR3vF4cZpSmBDkZbGAImx/rwYIHk31pK7E51bZq5my86DHu9iEtvH/tidZG/K/5
         iHUTP3TK3b+qXYRhD5F+pm5HizpXjd5CI7D9NjRYBIxJSn8XoulHuodKzVre2hH3NLJQ
         aQag==
X-Forwarded-Encrypted: i=1; AJvYcCXwG1BQVqKjlJVDbxnD9+9ZZ1R0QHt9teqlCSoOOTNo7Oi6HrhaeaEpnpJKieBtgKAHtEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHRz+79DmdbiqYzRChiBmOQVbo56FNxXfIK3j2FCG9U6DeAMT
	SXJEFDa6NSNALuBpSg4VylMv/3P48e6qP86wBdAgm4IzeRYhBAlNTv+OEgJAnvc=
X-Gm-Gg: ASbGncueOmvTYk2iJkilYrL6PhoV1qZW5dieGoq7LXbzEfFq3yBNbO5GJh5mLUu/fyD
	MuQeeQ7PT72GY3l1sNqc24Z7VIc6i0qDO5Gcs3tzAWhtVNgMQOIgZy3VXsOUhOLT4zvEj2RIOWV
	ct8b7m+IIgHzzfscrLI3+k3Zgz01dGSm82BlraXYm2AxVGvsSFv6eXDAJZRD9roHoHwcD0msAlu
	Z+2V0XDwPwbPmuXj42Zgmcae7OniD2pXPAVENbrm+RybntJU8aXXMrwV2rwuViRTml6YhewmbQI
	bzUmUNUtzjqZyRZrByfcpbjW3g==
X-Google-Smtp-Source: AGHT+IH4edu38H+gIHgivJGu/q5L3wx+HNGSX84tUbiK8HG9dcdFV0w5NozcC/eTgmCxtDGdXy8J8g==
X-Received: by 2002:a17:903:2a88:b0:223:28a8:610b with SMTP id d9443c01a7336-22dbf740e51mr70668285ad.14.1745863257084;
        Mon, 28 Apr 2025 11:00:57 -0700 (PDT)
Received: from t14.. ([104.133.9.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52214ebsm86204235ad.246.2025.04.28.11.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:00:56 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v6 bpf-next 7/7] selftests/bpf: Add tests for bucket resume logic in UDP socket iterators
Date: Mon, 28 Apr 2025 11:00:31 -0700
Message-ID: <20250428180036.369192-8-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428180036.369192-1-jordan@jrife.io>
References: <20250428180036.369192-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a set of tests that exercise various bucket resume scenarios:

* remove_seen resumes iteration after removing a socket from the bucket
  that we've already processed. Before, with the offset-based approach,
  this test would have skipped an unseen socket after resuming
  iteration. With the cookie-based approach, we now see all sockets
  exactly once.
* remove_unseen exercises the condition where the next socket that we
  would have seen is removed from the bucket before we resume iteration.
  This tests the scenario where we need to scan past the first cookie in
  our remembered cookies list to find the socket from which to resume
  iteration.
* remove_all exercises the condition where all sockets we remembered
  were removed from the bucket to make sure iteration terminates and
  returns no more results.
* add_some exercises the condition where a few, but not enough to
  trigger a realloc, sockets are added to the head of the current bucket
  between reads. Before, with the offset-based approach, this test would
  have repeated sockets we've already seen. With the cookie-based
  approach, we now see all sockets exactly once.
* force_realloc exercises the condition that we need to realloc the
  batch on a subsequent read, since more sockets than can be held in the
  current batch array were added to the current bucket. This exercies
  the logic inside bpf_iter_udp_realloc_batch that copies cookies into
  the new batch to make sure nothing is skipped or repeated.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 414 ++++++++++++++++++
 1 file changed, 414 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 74dbe91806a0..218c7258c0e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -7,6 +7,7 @@
 
 #define TEST_NS "sock_iter_batch_netns"
 
+static const int init_batch_size = 16;
 static const int nr_soreuse = 4;
 
 struct iter_out {
@@ -14,6 +15,418 @@ struct iter_out {
 	__u64 cookie;
 } __packed;
 
+struct sock_count {
+	__u64 cookie;
+	int count;
+};
+
+static int insert(__u64 cookie, struct sock_count counts[], int counts_len)
+{
+	int insert = -1;
+	int i = 0;
+
+	for (; i < counts_len; i++) {
+		if (!counts[i].cookie) {
+			insert = i;
+		} else if (counts[i].cookie == cookie) {
+			insert = i;
+			break;
+		}
+	}
+	if (insert < 0)
+		return insert;
+
+	counts[insert].cookie = cookie;
+	counts[insert].count++;
+
+	return counts[insert].count;
+}
+
+static int read_n(int iter_fd, int n, struct sock_count counts[],
+		  int counts_len)
+{
+	struct iter_out out;
+	int nread = 1;
+	int i = 0;
+
+	for (; nread > 0 && (n < 0 || i < n); i++) {
+		nread = read(iter_fd, &out, sizeof(out));
+		if (!nread || !ASSERT_EQ(nread, sizeof(out), "nread"))
+			break;
+		ASSERT_GE(insert(out.cookie, counts, counts_len), 0, "insert");
+	}
+
+	ASSERT_TRUE(n < 0 || i == n, "n < 0 || i == n");
+
+	return i;
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
+static bool was_seen(int fd, struct sock_count counts[], int counts_len)
+{
+	__u64 cookie = socket_cookie(fd);
+	int i = 0;
+
+	for (; cookie && i < counts_len; i++)
+		if (cookie == counts[i].cookie)
+			return true;
+
+	return false;
+}
+
+static int get_seen_socket(int *fds, struct sock_count counts[], int n)
+{
+	int i = 0;
+
+	for (; i < n; i++)
+		if (was_seen(fds[i], counts, n))
+			return i;
+	return -1;
+}
+
+static int get_nth_socket(int *fds, int fds_len, struct bpf_link *link, int n)
+{
+	int i, nread, iter_fd;
+	int nth_sock_idx = -1;
+	struct iter_out out;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_OK_FD(iter_fd, "bpf_iter_create"))
+		return -1;
+
+	for (; n >= 0; n--) {
+		nread = read(iter_fd, &out, sizeof(out));
+		if (!nread || !ASSERT_GE(nread, 1, "nread"))
+			goto done;
+	}
+
+	for (i = 0; i < fds_len && nth_sock_idx < 0; i++)
+		if (fds[i] >= 0 && socket_cookie(fds[i]) == out.cookie)
+			nth_sock_idx = i;
+done:
+	close(iter_fd);
+	return nth_sock_idx;
+}
+
+static int get_seen_count(int fd, struct sock_count counts[], int n)
+{
+	__u64 cookie = socket_cookie(fd);
+	int count = 0;
+	int i = 0;
+
+	for (; cookie && !count && i < n; i++)
+		if (cookie == counts[i].cookie)
+			count = counts[i].count;
+
+	return count;
+}
+
+static void check_n_were_seen_once(int *fds, int fds_len, int n,
+				   struct sock_count counts[], int counts_len)
+{
+	int seen_once = 0;
+	int seen_cnt;
+	int i = 0;
+
+	for (; i < fds_len; i++) {
+		/* Skip any sockets that were closed or that weren't seen
+		 * exactly once.
+		 */
+		if (fds[i] < 0)
+			continue;
+		seen_cnt = get_seen_count(fds[i], counts, counts_len);
+		if (seen_cnt && ASSERT_EQ(seen_cnt, 1, "seen_cnt"))
+			seen_once++;
+	}
+
+	ASSERT_EQ(seen_once, n, "seen_once");
+}
+
+static void remove_seen(int family, int sock_type, const char *addr, __u16 port,
+			int *socks, int socks_len, struct sock_count *counts,
+			int counts_len, struct bpf_link *link, int iter_fd)
+{
+	int close_idx;
+
+	/* Iterate through the first socks_len - 1 sockets. */
+	read_n(iter_fd, socks_len - 1, counts, counts_len);
+
+	/* Make sure we saw socks_len - 1 sockets exactly once. */
+	check_n_were_seen_once(socks, socks_len, socks_len - 1, counts,
+			       counts_len);
+
+	/* Close a socket we've already seen to remove it from the bucket. */
+	close_idx = get_seen_socket(socks, counts, counts_len);
+	if (!ASSERT_GE(close_idx, 0, "close_idx"))
+		return;
+	close(socks[close_idx]);
+	socks[close_idx] = -1;
+
+	/* Iterate through the rest of the sockets. */
+	read_n(iter_fd, -1, counts, counts_len);
+
+	/* Make sure the last socket wasn't skipped and that there were no
+	 * repeats.
+	 */
+	check_n_were_seen_once(socks, socks_len, socks_len - 1, counts,
+			       counts_len);
+}
+
+static void remove_unseen(int family, int sock_type, const char *addr,
+			  __u16 port, int *socks, int socks_len,
+			  struct sock_count *counts, int counts_len,
+			  struct bpf_link *link, int iter_fd)
+{
+	int close_idx;
+
+	/* Iterate through the first socket. */
+	read_n(iter_fd, 1, counts, counts_len);
+
+	/* Make sure we saw a socket from fds. */
+	check_n_were_seen_once(socks, socks_len, 1, counts, counts_len);
+
+	/* Close what would be the next socket in the bucket to exercise the
+	 * condition where we need to skip past the first cookie we remembered.
+	 */
+	close_idx = get_nth_socket(socks, socks_len, link, 1);
+	if (!ASSERT_GE(close_idx, 0, "close_idx"))
+		return;
+	close(socks[close_idx]);
+	socks[close_idx] = -1;
+
+	/* Iterate through the rest of the sockets. */
+	read_n(iter_fd, -1, counts, counts_len);
+
+	/* Make sure the remaining sockets were seen exactly once and that we
+	 * didn't repeat the socket that was already seen.
+	 */
+	check_n_were_seen_once(socks, socks_len, socks_len - 1, counts,
+			       counts_len);
+}
+
+static void remove_all(int family, int sock_type, const char *addr,
+		       __u16 port, int *socks, int socks_len,
+		       struct sock_count *counts, int counts_len,
+		       struct bpf_link *link, int iter_fd)
+{
+	int close_idx, i;
+
+	/* Iterate through the first socket. */
+	read_n(iter_fd, 1, counts, counts_len);
+
+	/* Make sure we saw a socket from fds. */
+	check_n_were_seen_once(socks, socks_len, 1, counts, counts_len);
+
+	/* Close all remaining sockets to exhaust the list of saved cookies and
+	 * exit without putting any sockets into the batch on the next read.
+	 */
+	for (i = 0; i < socks_len - 1; i++) {
+		close_idx = get_nth_socket(socks, socks_len, link, 1);
+		if (!ASSERT_GE(close_idx, 0, "close_idx"))
+			return;
+		close(socks[close_idx]);
+		socks[close_idx] = -1;
+	}
+
+	/* Make sure there are no more sockets returned */
+	ASSERT_EQ(read_n(iter_fd, -1, counts, counts_len), 0, "read_n");
+}
+
+static void add_some(int family, int sock_type, const char *addr, __u16 port,
+		     int *socks, int socks_len, struct sock_count *counts,
+		     int counts_len, struct bpf_link *link, int iter_fd)
+{
+	int *new_socks = NULL;
+
+	/* Iterate through the first socks_len - 1 sockets. */
+	read_n(iter_fd, socks_len - 1, counts, counts_len);
+
+	/* Make sure we saw socks_len - 1 sockets exactly once. */
+	check_n_were_seen_once(socks, socks_len, socks_len - 1, counts,
+			       counts_len);
+
+	/* Double the number of sockets in the bucket. */
+	new_socks = start_reuseport_server(family, sock_type, addr, port, 0,
+					   socks_len);
+	if (!ASSERT_OK_PTR(new_socks, "start_reuseport_server"))
+		goto done;
+
+	/* Iterate through the rest of the sockets. */
+	read_n(iter_fd, -1, counts, counts_len);
+
+	/* Make sure each of the original sockets was seen exactly once. */
+	check_n_were_seen_once(socks, socks_len, socks_len, counts,
+			       counts_len);
+done:
+	free_fds(new_socks, socks_len);
+}
+
+static void force_realloc(int family, int sock_type, const char *addr,
+			  __u16 port, int *socks, int socks_len,
+			  struct sock_count *counts, int counts_len,
+			  struct bpf_link *link, int iter_fd)
+{
+	int *new_socks = NULL;
+
+	/* Iterate through the first socket just to initialize the batch. */
+	read_n(iter_fd, 1, counts, counts_len);
+
+	/* Double the number of sockets in the bucket to force a realloc on the
+	 * next read.
+	 */
+	new_socks = start_reuseport_server(family, sock_type, addr, port, 0,
+					   socks_len);
+	if (!ASSERT_OK_PTR(new_socks, "start_reuseport_server"))
+		goto done;
+
+	/* Iterate through the rest of the sockets. */
+	read_n(iter_fd, -1, counts, counts_len);
+
+	/* Make sure each socket from the first set was seen exactly once. */
+	check_n_were_seen_once(socks, socks_len, socks_len, counts,
+			       counts_len);
+done:
+	free_fds(new_socks, socks_len);
+}
+
+struct test_case {
+	void (*test)(int family, int sock_type, const char *addr, __u16 port,
+		     int *socks, int socks_len, struct sock_count *counts,
+		     int counts_len, struct bpf_link *link, int iter_fd);
+	const char *description;
+	int init_socks;
+	int max_socks;
+	int sock_type;
+	int family;
+};
+
+static struct test_case resume_tests[] = {
+	{
+		.description = "udp: resume after removing a seen socket",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_DGRAM,
+		.family = AF_INET6,
+		.test = remove_seen,
+	},
+	{
+		.description = "udp: resume after removing one unseen socket",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_DGRAM,
+		.family = AF_INET6,
+		.test = remove_unseen,
+	},
+	{
+		.description = "udp: resume after removing all unseen sockets",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_DGRAM,
+		.family = AF_INET6,
+		.test = remove_all,
+	},
+	{
+		.description = "udp: resume after adding a few sockets",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_DGRAM,
+		/* Use AF_INET so that new sockets are added to the head of the
+		 * bucket's list.
+		 */
+		.family = AF_INET,
+		.test = add_some,
+	},
+	{
+		.description = "udp: force a realloc to occur",
+		.init_socks = init_batch_size,
+		.max_socks = init_batch_size * 2,
+		.sock_type = SOCK_DGRAM,
+		/* Use AF_INET6 so that new sockets are added to the tail of the
+		 * bucket's list, needing to be added to the next batch to force
+		 * a realloc.
+		 */
+		.family = AF_INET6,
+		.test = force_realloc,
+	},
+};
+
+static void do_resume_test(struct test_case *tc)
+{
+	static const __u16 port = 10001;
+	struct bpf_link *link = NULL;
+	struct sock_iter_batch *skel;
+	struct sock_count *counts;
+	int err, iter_fd = -1;
+	const char *addr;
+	int local_port;
+	int *fds;
+
+	counts = calloc(tc->max_socks, sizeof(*counts));
+	if (!counts)
+		return;
+	skel = sock_iter_batch__open();
+	if (!ASSERT_OK_PTR(skel, "sock_iter_batch__open"))
+		return;
+
+	/* Prepare a bucket of sockets in the kernel hashtable */
+	addr = tc->family == AF_INET6 ? "::1" : "127.0.0.1";
+	fds = start_reuseport_server(tc->family, tc->sock_type, addr, port, 0,
+				     tc->init_socks);
+	if (!ASSERT_OK_PTR(fds, "start_reuseport_server"))
+		goto done;
+	local_port = get_socket_local_port(*fds);
+	if (!ASSERT_GE(local_port, 0, "get_socket_local_port"))
+		goto done;
+	skel->rodata->ports[0] = ntohs(local_port);
+	skel->rodata->sf = tc->family;
+
+	err = sock_iter_batch__load(skel);
+	if (!ASSERT_OK(err, "sock_iter_batch__load"))
+		goto done;
+
+	link = bpf_program__attach_iter(tc->sock_type == SOCK_STREAM ?
+					skel->progs.iter_tcp_soreuse :
+					skel->progs.iter_udp_soreuse,
+					NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
+		goto done;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_OK_FD(iter_fd, "bpf_iter_create"))
+		goto done;
+
+	tc->test(tc->family, tc->sock_type, addr, port, fds, tc->init_socks,
+		 counts, tc->max_socks, link, iter_fd);
+done:
+	free(counts);
+	free_fds(fds, tc->init_socks);
+	if (iter_fd >= 0)
+		close(iter_fd);
+	bpf_link__destroy(link);
+	sock_iter_batch__destroy(skel);
+}
+
+static void do_resume_tests(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(resume_tests); i++) {
+		if (test__start_subtest(resume_tests[i].description)) {
+			do_resume_test(&resume_tests[i]);
+		}
+	}
+}
+
 static void do_test(int sock_type, bool onebyone)
 {
 	int err, i, nread, to_read, total_read, iter_fd = -1;
@@ -135,6 +548,7 @@ void test_sock_iter_batch(void)
 		do_test(SOCK_DGRAM, true);
 		do_test(SOCK_DGRAM, false);
 	}
+	do_resume_tests();
 	close_netns(nstoken);
 
 done:
-- 
2.43.0


