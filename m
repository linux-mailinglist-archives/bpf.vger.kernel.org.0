Return-Path: <bpf+bounces-58577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4E1ABDE76
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 17:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C011A4E637A
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D292522BC;
	Tue, 20 May 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="KVMSfZYm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0574252292
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752690; cv=none; b=P+jSdzJXQYakUra4ZghJ7eMmC6lEa/SIsBoQ8OJAkPNIP4HTAzAES0hOy/9VbN2lfacj1vncgTFblgMC5zzgysn5sNfBijTtFKTB3Bjjpwh1b6f6AKkSsmVxchTrq3WjbzKvdtd6mohWAIhrV29BMYojvYRqqIfXnYCJazSZieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752690; c=relaxed/simple;
	bh=2tkAMlhAZoaRx0TqrjPlNgg15lg5GmPYcMCc1bfgSwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r71m4cdCUBtj/TmbDh9yU88kY6rniMiHw5v1S6Sh2Nm5ZnglK/JdqTl/4gzkonHjmklIMb1/ltMdDAnXHPFKwCKSDUSwdkNqtX3GNX728BgtU3treK4B2Onfs0k2wgLo1eEi0O3/pqvz/nCGFJxNxy6dJ3ydpEDKlrz4bfn6Nb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=KVMSfZYm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742ad4a71a0so214800b3a.1
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752688; x=1748357488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4kf3ZieW9o/TFhugnSaDvAiwleQ1fSWe8YKYPJAUM0=;
        b=KVMSfZYm76bjdzLgFpMmViUF4r1IdJDOfwmROaPyxQcoVQSbNFVGOSf3oSCEEuH81B
         VWjqJSJLe7GBUbe/WEoeDLgxxgyARy4SICfJ9x132sYybeHFTxkAVsVntN8gElItbDAr
         wOfIRY8rAIsfF+jRaNZm65iY9lPp0QozyGsGM609HoWIQ0g86eq4aaFCRfxrepewfgBu
         dP0LufT5P+bJDLjlgyVBnOlqc04eLgAO2OCt0UWmUPKcS8WlfxF4ccgCPdnLiwxuikaK
         8yGgQkOQmVycFRAIEI1WpKoxzjCMmldEkB2b0fk7bssZN4rcGK0VJ1WCo0I768iR5GqG
         Lq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752688; x=1748357488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4kf3ZieW9o/TFhugnSaDvAiwleQ1fSWe8YKYPJAUM0=;
        b=Q5q+Qg/PcHcFvyQgzTgbw5RBxkfMURB6KhmIY2Hn+1jMn/+vESgEmPv7WMTtR7rA/X
         6UPvqrkufCIl2DpXCrZ9A9iW6YSgb2IFzsSkAoPAFSg4/zrvVcQHGT9ykjMnTzXP1Yzj
         C2Yc06bYoDnJqNfu0Dg+j8UVb1EhghD7dWd60sXcSVhAVOkkOplyu3WFv6BoL7wrvZS1
         dbWqzqTJFkVbhuBLo8glfOMfRvjr6sasuwVY7sh4JhHzlg/61IIfT1u4BZgeZleO07Fa
         dHhc5QcnTc4vOmP+lK9iOOR7o3Q0Ot+vvZdQJ0NEq/2ymWono0P2tMU5j8dAuc7EKGWW
         Q1zA==
X-Forwarded-Encrypted: i=1; AJvYcCW83PNbxaSaCBeQpB8AfsKhDHElb6rwRXYnut040o6Es/LKLaazzslqJk5T0oRCNUHUYRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydNQ1uQ3GOB+F7ci2SuiYDdLlowjto31D9kM/T0xsOQ0NOGwcq
	/le97cif67g09YM35euB/kePWJICWuKwQUfaf/OyvNJ2zQVg96X/K2dzgYkXTE5Bj4Y=
X-Gm-Gg: ASbGnctjm8Z2ueG9dSkom6dCRbmvDw0tIWqZ0Bs38f1kgTi6f2drxrTmlsY+7OKPRbO
	W9SYHtY27O6/zin6MG5swXngiAi0EsPoJVhc3j0xlPAHy/sZHxikZAlq+vWDWcOyxNHSPhS0afL
	oChp8+V4DqanCsnismN8q79pteRy+d/2KoPcwgvS62ACjDjrYkUpW9Hx471wQ2OyUvGdyKa28Dg
	SJUHxyB+cse8pY3PGNQyUL795qb8+Y1x+ujL6y8Sk+jDk6aWBEiePMrMwx9HnBsaZidSFZWED/U
	icG/2Kp3t0tL2SGT3d3jcMROuCYAQva3sxnf/a2C
X-Google-Smtp-Source: AGHT+IEXW7+AsDPqB0o2RuLGL90KhocP3vgD1k2sKWq0uqeTFftW6eP1ChVSOZgb9VkuPebXDgaC9A==
X-Received: by 2002:a05:6a00:aca:b0:742:938a:3eca with SMTP id d2e1a72fcca58-742a98f943dmr9816941b3a.3.1747752687937;
        Tue, 20 May 2025 07:51:27 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:27 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 09/10] selftests/bpf: Create established sockets in socket iterator tests
Date: Tue, 20 May 2025 07:50:56 -0700
Message-ID: <20250520145059.1773738-10-jordan@jrife.io>
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

Prepare for bucket resume tests for established TCP sockets by creating
established sockets. Collect socket fds from connect() and accept()
sides and pass them to test cases.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 83 ++++++++++++++++++-
 1 file changed, 79 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 847e4b87ab92..f14adda52f53 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -153,8 +153,66 @@ static void check_n_were_seen_once(int *fds, int fds_len, int n,
 	ASSERT_EQ(seen_once, n, "seen_once");
 }
 
+static int accept_from_one(int *server_fds, int server_fds_len)
+{
+	int i = 0;
+	int fd;
+
+	for (; i < server_fds_len; i++) {
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
@@ -464,13 +537,15 @@ static void do_resume_test(struct test_case *tc)
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


