Return-Path: <bpf+bounces-54012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA7CA60610
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 00:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32F43AEF44
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 23:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BAE21421E;
	Thu, 13 Mar 2025 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iY9/LVgo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9A9213E85
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908985; cv=none; b=GSl8gqbceqeuRKJY1SjXRr8Sfe4A5/S/rTprg+W/pdA02Mfd6saGrsSeX2JheKSzN9rhZz1+3HMipv22IujYsARKSreInzxtcdCBDWE1T9nwEhwiu/ncEaie9a+b6wbGYzWzEKEl8FizTyzivZEVfLUnv30x8umUVtHnjXJeo/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908985; c=relaxed/simple;
	bh=zlaF7V/D4LUYbSkKU1UbelZoLgHYBpEtCUZNB2BjYAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PucZzk26y/F0gk53tCV5pySt/1PIHjTralW7a02VgfDAigZvqKoWBTDD7sNP/x+jIwutvymocJhR9VyisBUjtFp5UU5xlrJM42TCoLBaDEk8RPvGKe+6H1lq/huu94zpjMCnZHNtIdy4vYgAjktB7+160460X4Od+0Ckc2a8TKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iY9/LVgo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff69646218so4021959a91.3
        for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 16:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741908983; x=1742513783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d18/d09Dz9ktq8VmcM8vb1l6yxRF8rMrPqQQdqFZ7tk=;
        b=iY9/LVgoiA9PVr/T0rIDrUv13rR+Ej4cwxxv++G2q1JDI+Hw75fXVKOP2Dezcamit5
         KbLPc+oKciiZtuAQs0WZrwooUpb9jHdWuM6TDWTv/tW5xlheL3809EF0+zTqVKQyD6se
         Ew4CkgtlPJJO9E4IA+S7s8GrG91//zDkNYBN6L6uMF7GaTEDCr85pvJNo0GpSr+Z/u1I
         BFo70l6hak/752xrvGuXE2dQxHNuNX1ZJp7sQ+HtXcD+XeLfFSghW/oCSwo6AUFVtTNR
         64sfd9vwypyfrEOh+cZvOBOFbh3NSziwIhx8r9YclRObbv8Op7k6kEkG1NDvu6vIgQhZ
         rr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741908983; x=1742513783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d18/d09Dz9ktq8VmcM8vb1l6yxRF8rMrPqQQdqFZ7tk=;
        b=uNuJXwjfF2B7S9b2bE+BoQ9nvaylpzv6tNZzftT43p+qofyqNNYn8qP1p74Z9TmVXO
         kS26but7fJGPBoCWN8PrpGtUCMdOVpV/q22getgxMc5l5ARqMOO8upqjDSvta4PbK7AJ
         /CgLybAZqTpbuAwaic3z0zkczCXT9cEBblftrbCm8In/+WSf/KrxYJ0gJG/EKBgyqO35
         GGk7/g5zk719ffPqtYlxj89ylCTr3czJTqG6O+2r++Iw+UebPYBK6+O3WXHK44dElki0
         DXWflk2KEEdI2NvjyXeZxV9vFngWw5LbDzoc642teVpmIc1sbyIBGlbxcGzRemG7dRvh
         dU6w==
X-Forwarded-Encrypted: i=1; AJvYcCXxAo1QrL0aL3y+Q5b6LEIiiRSSuzupQyEdyzf7ZIRRxVKzEHVFBn2sq21CYWDEK2Jomb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE/AepVC2+gKrXqNvYtFxciaWAAsKDkZmOA916rXK4UM8k9fcq
	nTVlzJinK4rejJJ7YvJ45dxDN1R3fgwivcXJdahw3xLFMOfIKxa7RMKd9XBLUepPs6VZaVRkfw=
	=
X-Google-Smtp-Source: AGHT+IHDa1188aeb9ZwFHUKfNFL/nXAhQihB0hUq6dTHWYIpkjnb+e2O3fD/UoPdHvEeQG70WhPFU6YTxg==
X-Received: from pjbkl7.prod.google.com ([2002:a17:90b:4987:b0:2ff:5344:b54])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc4f:b0:2f2:a664:df20
 with SMTP id 98e67ed59e1d1-30151c5f303mr511803a91.7.1741908982757; Thu, 13
 Mar 2025 16:36:22 -0700 (PDT)
Date: Thu, 13 Mar 2025 23:35:27 +0000
In-Reply-To: <20250313233615.2329869-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313233615.2329869-1-jrife@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250313233615.2329869-4-jrife@google.com>
Subject: [RFC PATCH bpf-next 3/3] selftests/bpf: Add tests for socket skips
 and repeats
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

Add do_skip_test() and do_repeat_test() subtests to the sock_iter_batch
prog_test to check for socket skips and repeats, respectively. Extend
the sock_iter_batch BPF program to output the socket cookie as well, so
that we can check for uniqueness. The skip test works by partially
iterating through a bucket, then closing one of the sockets that have
already been seen to remove it from the bucket. Before, this would have
resulted in skipping the fourth socket. Now, the fourth socket is seen.
The repeat test works by partially iterating through a bucket, then
adding four more sockets to the head of the bucket. Before, this would
have resulted in repeating several of the sockets from the first batch,
but now we see sockets exactly once.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 293 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  24 +-
 3 files changed, 300 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index d56e18b25528..cf554e8fdf79 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -6,15 +6,275 @@
 #include "sock_iter_batch.skel.h"
 
 #define TEST_NS "sock_iter_batch_netns"
+#define nr_soreuse 4
 
-static const int nr_soreuse = 4;
+static const __u16 reuse_port = 10001;
+
+struct iter_out {
+	int idx;
+	__u64 cookie;
+} __packed;
+
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
+		if (!nread || !ASSERT_GE(nread, 1, "nread"))
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
+	static __u32 duration;	/* for CHECK macro */
+
+	if (CHECK(getsockopt(fd, SOL_SOCKET, SO_COOKIE, &cookie, &cookie_len) < 0,
+		  "getsockopt(SO_COOKIE)", "%s\n", strerror(errno)))
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
+static void do_skip_test(int sock_type)
+{
+	struct sock_count counts[nr_soreuse] = {};
+	struct bpf_link *link = NULL;
+	struct sock_iter_batch *skel;
+	int err, iter_fd = -1;
+	int close_idx;
+	int *fds;
+
+	skel = sock_iter_batch__open();
+	if (!ASSERT_OK_PTR(skel, "sock_iter_batch__open"))
+		return;
+
+	/* Prepare a bucket of sockets in the kernel hashtable */
+	int local_port;
+
+	fds = start_reuseport_server(AF_INET, sock_type, "127.0.0.1", 0, 0,
+				     nr_soreuse);
+	if (!ASSERT_OK_PTR(fds, "start_reuseport_server"))
+		goto done;
+	local_port = get_socket_local_port(*fds);
+	if (!ASSERT_GE(local_port, 0, "get_socket_local_port"))
+		goto done;
+	skel->rodata->ports[0] = ntohs(local_port);
+	skel->rodata->sf = AF_INET;
+
+	err = sock_iter_batch__load(skel);
+	if (!ASSERT_OK(err, "sock_iter_batch__load"))
+		goto done;
+
+	link = bpf_program__attach_iter(sock_type == SOCK_STREAM ?
+					skel->progs.iter_tcp_soreuse :
+					skel->progs.iter_udp_soreuse,
+					NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
+		goto done;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "bpf_iter_create"))
+		goto done;
+
+	/* Iterate through the first three sockets. */
+	read_n(iter_fd, nr_soreuse - 1, counts, nr_soreuse);
+
+	/* Make sure we saw three sockets from fds exactly once. */
+	check_n_were_seen_once(fds, nr_soreuse, nr_soreuse - 1, counts,
+			       nr_soreuse);
+
+	/* Close a socket we've already seen to remove it from the bucket. */
+	close_idx = get_seen_socket(fds, counts, nr_soreuse);
+	if (!ASSERT_GE(close_idx, 0, "close_idx"))
+		goto done;
+	close(fds[close_idx]);
+	fds[close_idx] = -1;
+
+	/* Iterate through the rest of the sockets. */
+	read_n(iter_fd, -1, counts, nr_soreuse);
+
+	/* Make sure the last socket wasn't skipped and that there were no
+	 * repeats.
+	 */
+	check_n_were_seen_once(fds, nr_soreuse, nr_soreuse - 1, counts,
+			       nr_soreuse);
+done:
+	free_fds(fds, nr_soreuse);
+	if (iter_fd < 0)
+		close(iter_fd);
+	bpf_link__destroy(link);
+	sock_iter_batch__destroy(skel);
+}
+
+static void do_repeat_test(int sock_type)
+{
+	struct sock_count counts[nr_soreuse] = {};
+	struct bpf_link *link = NULL;
+	struct sock_iter_batch *skel;
+	int err, i, iter_fd = -1;
+	int *fds[2] = {};
+
+	skel = sock_iter_batch__open();
+	if (!ASSERT_OK_PTR(skel, "sock_iter_batch__open"))
+		return;
+
+	/* Prepare a bucket of sockets in the kernel hashtable */
+	int local_port;
+
+	fds[0] = start_reuseport_server(AF_INET, sock_type, "127.0.0.1",
+					reuse_port, 0, nr_soreuse);
+	if (!ASSERT_OK_PTR(fds[0], "start_reuseport_server"))
+		goto done;
+	local_port = get_socket_local_port(*fds[0]);
+	if (!ASSERT_GE(local_port, 0, "get_socket_local_port"))
+		goto done;
+	skel->rodata->ports[0] = ntohs(local_port);
+	skel->rodata->sf = AF_INET;
+
+	err = sock_iter_batch__load(skel);
+	if (!ASSERT_OK(err, "sock_iter_batch__load"))
+		goto done;
+
+	link = bpf_program__attach_iter(sock_type == SOCK_STREAM ?
+					skel->progs.iter_tcp_soreuse :
+					skel->progs.iter_udp_soreuse,
+					NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
+		goto done;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "bpf_iter_create"))
+		goto done;
+
+	/* Iterate through the first three sockets */
+	read_n(iter_fd, nr_soreuse - 1, counts, nr_soreuse);
+
+	/* Make sure we saw three sockets from fds exactly once. */
+	check_n_were_seen_once(fds[0], nr_soreuse, nr_soreuse - 1, counts,
+			       nr_soreuse);
+
+	/* Add nr_soreuse more sockets to the bucket. */
+	fds[1] = start_reuseport_server(AF_INET, sock_type, "127.0.0.1",
+					reuse_port, 0, nr_soreuse);
+	if (!ASSERT_OK_PTR(fds[1], "start_reuseport_server"))
+		goto done;
+
+	/* Iterate through the rest of the sockets. */
+	read_n(iter_fd, -1, counts, nr_soreuse);
+
+	/* Make sure each socket from the first set was seen exactly once. */
+	check_n_were_seen_once(fds[0], nr_soreuse, nr_soreuse, counts,
+			       nr_soreuse);
+done:
+	for (i = 0; i < ARRAY_SIZE(fds); i++)
+		free_fds(fds[i], nr_soreuse);
+	if (iter_fd < 0)
+		close(iter_fd);
+	bpf_link__destroy(link);
+	sock_iter_batch__destroy(skel);
+}
 
 static void do_test(int sock_type, bool onebyone)
 {
 	int err, i, nread, to_read, total_read, iter_fd = -1;
-	int first_idx, second_idx, indices[nr_soreuse];
+	struct iter_out outputs[nr_soreuse];
 	struct bpf_link *link = NULL;
 	struct sock_iter_batch *skel;
+	int first_idx, second_idx;
 	int *fds[2] = {};
 
 	skel = sock_iter_batch__open();
@@ -34,6 +294,7 @@ static void do_test(int sock_type, bool onebyone)
 			goto done;
 		skel->rodata->ports[i] = ntohs(local_port);
 	}
+	skel->rodata->sf = AF_INET6;
 
 	err = sock_iter_batch__load(skel);
 	if (!ASSERT_OK(err, "sock_iter_batch__load"))
@@ -55,38 +316,38 @@ static void do_test(int sock_type, bool onebyone)
 	 * from a bucket and leave one socket out from
 	 * that bucket on purpose.
 	 */
-	to_read = (nr_soreuse - 1) * sizeof(*indices);
+	to_read = (nr_soreuse - 1) * sizeof(*outputs);
 	total_read = 0;
 	first_idx = -1;
 	do {
-		nread = read(iter_fd, indices, onebyone ? sizeof(*indices) : to_read);
-		if (nread <= 0 || nread % sizeof(*indices))
+		nread = read(iter_fd, outputs, onebyone ? sizeof(*outputs) : to_read);
+		if (nread <= 0 || nread % sizeof(*outputs))
 			break;
 		total_read += nread;
 
 		if (first_idx == -1)
-			first_idx = indices[0];
-		for (i = 0; i < nread / sizeof(*indices); i++)
-			ASSERT_EQ(indices[i], first_idx, "first_idx");
+			first_idx = outputs[0].idx;
+		for (i = 0; i < nread / sizeof(*outputs); i++)
+			ASSERT_EQ(outputs[i].idx, first_idx, "first_idx");
 	} while (total_read < to_read);
-	ASSERT_EQ(nread, onebyone ? sizeof(*indices) : to_read, "nread");
+	ASSERT_EQ(nread, onebyone ? sizeof(*outputs) : to_read, "nread");
 	ASSERT_EQ(total_read, to_read, "total_read");
 
 	free_fds(fds[first_idx], nr_soreuse);
 	fds[first_idx] = NULL;
 
 	/* Read the "whole" second bucket */
-	to_read = nr_soreuse * sizeof(*indices);
+	to_read = nr_soreuse * sizeof(*outputs);
 	total_read = 0;
 	second_idx = !first_idx;
 	do {
-		nread = read(iter_fd, indices, onebyone ? sizeof(*indices) : to_read);
-		if (nread <= 0 || nread % sizeof(*indices))
+		nread = read(iter_fd, outputs, onebyone ? sizeof(*outputs) : to_read);
+		if (nread <= 0 || nread % sizeof(*outputs))
 			break;
 		total_read += nread;
 
-		for (i = 0; i < nread / sizeof(*indices); i++)
-			ASSERT_EQ(indices[i], second_idx, "second_idx");
+		for (i = 0; i < nread / sizeof(*outputs); i++)
+			ASSERT_EQ(outputs[i].idx, second_idx, "second_idx");
 	} while (total_read <= to_read);
 	ASSERT_EQ(nread, 0, "nread");
 	/* Both so_reuseport ports should be in different buckets, so
@@ -123,10 +384,14 @@ void test_sock_iter_batch(void)
 	if (test__start_subtest("tcp")) {
 		do_test(SOCK_STREAM, true);
 		do_test(SOCK_STREAM, false);
+		do_skip_test(SOCK_STREAM);
+		do_repeat_test(SOCK_STREAM);
 	}
 	if (test__start_subtest("udp")) {
 		do_test(SOCK_DGRAM, true);
 		do_test(SOCK_DGRAM, false);
+		do_skip_test(SOCK_DGRAM);
+		do_repeat_test(SOCK_DGRAM);
 	}
 	close_netns(nstoken);
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index 59843b430f76..82928cc5d87b 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -123,6 +123,7 @@
 #define sk_refcnt		__sk_common.skc_refcnt
 #define sk_state		__sk_common.skc_state
 #define sk_net			__sk_common.skc_net
+#define sk_rcv_saddr		__sk_common.skc_rcv_saddr
 #define sk_v6_daddr		__sk_common.skc_v6_daddr
 #define sk_v6_rcv_saddr		__sk_common.skc_v6_rcv_saddr
 #define sk_flags		__sk_common.skc_flags
diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index 96531b0d9d55..8f483337e103 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -17,6 +17,12 @@ static bool ipv6_addr_loopback(const struct in6_addr *a)
 		a->s6_addr32[2] | (a->s6_addr32[3] ^ bpf_htonl(1))) == 0;
 }
 
+static bool ipv4_addr_loopback(__be32 a)
+{
+	return a == bpf_ntohl(0x7f000001);
+}
+
+volatile const unsigned int sf;
 volatile const __u16 ports[2];
 unsigned int bucket[2];
 
@@ -26,16 +32,20 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 	struct sock *sk = (struct sock *)ctx->sk_common;
 	struct inet_hashinfo *hinfo;
 	unsigned int hash;
+	__u64 sock_cookie;
 	struct net *net;
 	int idx;
 
 	if (!sk)
 		return 0;
 
+	sock_cookie = bpf_get_socket_cookie(sk);
 	sk = bpf_core_cast(sk, struct sock);
-	if (sk->sk_family != AF_INET6 ||
+	if (sk->sk_family != sf ||
 	    sk->sk_state != TCP_LISTEN ||
-	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr))
+	    sk->sk_family == AF_INET6 ?
+	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr) :
+	    !ipv4_addr_loopback(sk->sk_rcv_saddr))
 		return 0;
 
 	if (sk->sk_num == ports[0])
@@ -52,6 +62,7 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 	hinfo = net->ipv4.tcp_death_row.hashinfo;
 	bucket[idx] = hash & hinfo->lhash2_mask;
 	bpf_seq_write(ctx->meta->seq, &idx, sizeof(idx));
+	bpf_seq_write(ctx->meta->seq, &sock_cookie, sizeof(sock_cookie));
 
 	return 0;
 }
@@ -63,14 +74,18 @@ int iter_udp_soreuse(struct bpf_iter__udp *ctx)
 {
 	struct sock *sk = (struct sock *)ctx->udp_sk;
 	struct udp_table *udptable;
+	__u64 sock_cookie;
 	int idx;
 
 	if (!sk)
 		return 0;
 
+	sock_cookie = bpf_get_socket_cookie(sk);
 	sk = bpf_core_cast(sk, struct sock);
-	if (sk->sk_family != AF_INET6 ||
-	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr))
+	if (sk->sk_family != sf ||
+	    sk->sk_family == AF_INET6 ?
+	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr) :
+	    !ipv4_addr_loopback(sk->sk_rcv_saddr))
 		return 0;
 
 	if (sk->sk_num == ports[0])
@@ -84,6 +99,7 @@ int iter_udp_soreuse(struct bpf_iter__udp *ctx)
 	udptable = sk->sk_net.net->ipv4.udp_table;
 	bucket[idx] = udp_sk(sk)->udp_portaddr_hash & udptable->mask;
 	bpf_seq_write(ctx->meta->seq, &idx, sizeof(idx));
+	bpf_seq_write(ctx->meta->seq, &sock_cookie, sizeof(sock_cookie));
 
 	return 0;
 }
-- 
2.49.0.rc1.451.g8f38331e32-goog


