Return-Path: <bpf+bounces-55365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 549AEA7C626
	for <lists+bpf@lfdr.de>; Sat,  5 Apr 2025 00:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2414189FCF1
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 22:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C0822154A;
	Fri,  4 Apr 2025 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="mDnE97Du"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E4B21D599
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743804197; cv=none; b=bdt4UOVGngFGXhwuGXPBb5DYc6f1rpudTRnxG+7UxA1Y4PBIKZEJIjv7xztFyRsaAkpCgS8I/PexfRbBEvoMDaV5otX3pBA6/tnclOQo+1/FLsiweiKrR4ojTjnQl9jTrKeh2KEchfurAGr4Tayh9MpU08d6v+eM1W8dcE4s8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743804197; c=relaxed/simple;
	bh=fysN7BOOimodnUE+D5Mvb38ma1hNEwUVmjUQW6P/QKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sL6lHEU7xNeBPp0eyv3AlxzGrsqQBR3r8wgUs5WlmfL8kR62VbUa6pTGGI1GT+P9gSrLQ7eJ78b7npv+Cl3plCnG4kF4/DRp2ebu6cyc9TGbPnNFgqhnFF8xeA2eTHfacx6skWVFBTrnpmSwgyfiVTjEFXFZ534ugDmfXOQXZyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=mDnE97Du; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7366d0f3231so392525b3a.1
        for <bpf@vger.kernel.org>; Fri, 04 Apr 2025 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1743804194; x=1744408994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPJ5/8rU3Fc/CeE93x1caPdyk9wqOorDNqVlsu9SRZw=;
        b=mDnE97Du8aLwfWZoGkDyrR9JxyG+U73tG924n3CkN9tySgyZegAQZPoPCcoBqYBC2F
         XanKnHtZxsoB85Y6gnWJ9uhHoJjPHXDE68CFwj2wOkYkUMMHhUthGgme+lyx19I9LFaU
         g7b8ZXVa2erFtXFIpt7pSyYkoD+54td8HbTHijhuJW5H+P1pYkVam3dVUtN5+J9G343F
         d7Ugde2cZJinUnW30i+aLbi1oxeKgJAkg+lyRHLw4igiySYdeTcSbdh8YfilzS23R7yO
         plbRq2vfwpyf4N+4ZFRxIHCQv4BD/qqFIASetgqN9RNqmlB+2i5M5kuzfxIDZqk52KWA
         JE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743804194; x=1744408994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPJ5/8rU3Fc/CeE93x1caPdyk9wqOorDNqVlsu9SRZw=;
        b=REh2Fg4hUddwfrE47/x9hJBsSWOp7U+COfmMMIDeTgHxlbt+/S4YH78gKz1bVbJGA7
         cREEcFi8dd+N/QxorZdlNGw14X0/5k6xJICrMWZUkIX3nNJSVAQj6J2Jau5vGzOIo3iM
         FLNhDZyvKT8Qg5M29ey+hmIU8/Lgb4cgWEZflnOlf3vlUVoFjXH9H6z4Y6GfhNeGw7Zx
         shtZqwQHZGhhiQ8ghaAgLN3f2EDo7NlV53Wq8VlbLrJvl9x+kMcppKyA2Vm3sQvaVitG
         yopsWrijx20ibIsdlD4KYhKLYMlkomAPgtl/DihIXp6P4G5FsS5KTScD6oXZe1JVARc6
         k8Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX6BFOgXOVAdV8DIFGs9nctwFNI6enjeGs4TCqwtU+TANeCpU2oNDrMwm8NlpXG+uS3m4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyawazki6i3dKPKYe93bDFnA6iwFYzUigDtkWqJpeX9PbhZ52DF
	Smq9lkAPYKMbG22+pcypUnkm14CsuXe9193IhG4nPecTxsX7XELDrRDRU1GGBys=
X-Gm-Gg: ASbGncvgp2mYrD7tslbUQCJCQ0HkohSoZWmFEWXhHSYtIl9paJmUIdZQIGuQaP/3mCE
	D8OVzK2UYFIPu4W2+tnwHcZU7EHZIlOG+5wdT1fP1W0xMTorjqUBsfSZ5/WMfcyu1dxzu0BJzoc
	hN2ss/urirWw/b4/Edq/ruN/9wZFCneIX5J9fVdjfef/tP+4BX615W/GjCv4Ghjlik62g3oBxso
	W+sP+eCYQt7nIhsknbh0lTgv3b+NIClfkwc5BuB+dw9XoVU3OZIFsAsoC4Br9IdHjGzUMOrNRKE
	JWyQGN/R8rSQCJg3dNfWppuHCsTYaobN3w==
X-Google-Smtp-Source: AGHT+IFE14GJT5K5BjFNizKAAoe+BXegKSeNPyojXV4l5hl04oOrSSrOtpHAYnouvxwsVjU/Qo5lsg==
X-Received: by 2002:a05:6a00:2394:b0:736:a9b0:6f0a with SMTP id d2e1a72fcca58-739e4c06483mr2355872b3a.4.1743804193670;
        Fri, 04 Apr 2025 15:03:13 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d158:c069:399b:1ed0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0deddfsm3953570b3a.162.2025.04.04.15.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 15:03:13 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [RFC PATCH bpf-next 3/3] selftests/bpf: Add tests for bucket resume logic in UDP socket iterators
Date: Fri,  4 Apr 2025 15:02:18 -0700
Message-ID: <20250404220221.1665428-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404220221.1665428-1-jordan@jrife.io>
References: <20250404220221.1665428-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First, extend the iter_udp_soreuse and iter_tcp_soreuse to write the
cookie of the current socket so that we can track the identity of the
sockets that the iterator has seen so far in the test code. Update the
existing do_test function to account for this change to the iterator
program output.

Next, introduce a set of tests that exercise various bucket resume
scenarios:

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
 .../bpf/prog_tests/sock_iter_batch.c          | 452 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  24 +-
 3 files changed, 460 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index d56e18b25528..dc44115bd078 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -1,20 +1,444 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2024 Meta
 
+#include "linux/bpf.h"
 #include <test_progs.h>
 #include "network_helpers.h"
 #include "sock_iter_batch.skel.h"
 
 #define TEST_NS "sock_iter_batch_netns"
 
+static const int init_batch_size = 16;
 static const int nr_soreuse = 4;
 
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
+static int get_nth_socket(int *fds, int fds_len, struct bpf_link *link, int n)
+{
+	int i, nread, iter_fd;
+	int nth_sock_idx = -1;
+	struct iter_out out;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "bpf_iter_create"))
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
+	if (iter_fd < 0)
+		close(iter_fd);
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
+	if (new_socks)
+		free_fds(new_socks, socks_len);
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
+	if (new_socks)
+		free_fds(new_socks, socks_len);
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
+	int local_port;
+
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
+	if (!ASSERT_GE(iter_fd, 0, "bpf_iter_create"))
+		goto done;
+
+	tc->test(tc->family, tc->sock_type, addr, port, fds, tc->init_socks,
+		 counts, tc->max_socks, link, iter_fd);
+done:
+	free_fds(fds, tc->init_socks);
+	if (iter_fd < 0)
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
-	int first_idx, second_idx, indices[nr_soreuse];
+	struct iter_out outputs[nr_soreuse];
 	struct bpf_link *link = NULL;
 	struct sock_iter_batch *skel;
+	int first_idx, second_idx;
 	int *fds[2] = {};
 
 	skel = sock_iter_batch__open();
@@ -34,6 +458,7 @@ static void do_test(int sock_type, bool onebyone)
 			goto done;
 		skel->rodata->ports[i] = ntohs(local_port);
 	}
+	skel->rodata->sf = AF_INET6;
 
 	err = sock_iter_batch__load(skel);
 	if (!ASSERT_OK(err, "sock_iter_batch__load"))
@@ -55,38 +480,38 @@ static void do_test(int sock_type, bool onebyone)
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
@@ -128,6 +553,7 @@ void test_sock_iter_batch(void)
 		do_test(SOCK_DGRAM, true);
 		do_test(SOCK_DGRAM, false);
 	}
+	do_resume_tests();
 	close_netns(nstoken);
 
 done:
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index 659694162739..17db400f0e0d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -128,6 +128,7 @@
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
2.43.0


