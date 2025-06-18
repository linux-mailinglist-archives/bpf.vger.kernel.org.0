Return-Path: <bpf+bounces-60972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 712FFADF2A7
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003273B1EA0
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2103B2F2C62;
	Wed, 18 Jun 2025 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="G+fFPllC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4282F2730
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263962; cv=none; b=t+G2AOJ4FVjmLYfErdD7vyq9YGDcb3SHCwTCuj52GmNJurgE0f2We+2Eb36wICSMgV0XC3KKenpEf/Nh9C3gHlKBwnFGBoNJE2r2hhBPtIEcXZp+ykrAZ3VmDQozqvP0I50x+4oKHskI1l0nYBlFj3CyXVrYskmSTTt0KObIpMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263962; c=relaxed/simple;
	bh=zvL7otWia4aCQkmTWeYiWGA5c95LwW9WEAyFjDzkpIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrRhmZFAfjET2Gi9nYoEfMhPB+88X28LGZANtEyBAuadoSK7JWG6ECcCpZuVZMVCg9zE5tHvsQvWTCab0qg/5mlMolwZ4ZlKVuJSaCkHWdcLpK5cTtydzoHe7K+LJV3o0BMGBWxsOvtmK/jTcX1xF/lA6YWMKWSom5Ue4ixonEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=G+fFPllC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313bcf6e565so1200726a91.0
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263960; x=1750868760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Zcg8bD4DRfyLDHEcbStZky5pf6pw83OI9yD6JCFNPs=;
        b=G+fFPllCgRXggG0XWfR5DHEcp+PiPk3V3G6fVn7EYpnIKNBAoI/K/JR2rQ6AwbzO6M
         NkyWkX8YM7uPMAZOtsOsIaMV3HMfnE6iMJ3ijpGbcn7hULY98IyLhdeJT/k0MXJYeRYl
         ULYe5XqhUKQHShUmByFN8gQiyqoE1NShoqymhfSj72w3ncp2fdGQ6PgWdpjqqK90fBRJ
         ylIJzcwxqdt/r4sb1zMbOXT5Ve9sSHCXFSQ55uyVlTnrs1gG3HPs0MbWCD+mDXP+wlSe
         5gWPRkc+I63oELmoltDrdHpjXX3LHdtwohrOShRhCRthM/vHe4KU3GrT52SCv7mM8+iv
         ud3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263960; x=1750868760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Zcg8bD4DRfyLDHEcbStZky5pf6pw83OI9yD6JCFNPs=;
        b=tIrCIGiORqagEGMuzxtitQyVP8MmrnVsNXwZ7pT9NjOPMYM3fgEzJKjAn0rzYa7HKq
         DQMmBUDU7Ftu5Jf6w8NyiDK8I5s9n6kyhQiQPY5EVW4s7TYTcX0+r1x0eVm1IOk0QHzg
         +v0T4DkJYwPECU79guvrFW8LRI3fSs/MdzTzw44upDOZM1wF6PB9NTfULFEjLAPJFTJU
         SMKaUCPFeNjSZPvIHfFRnhSD/ro65J2szGDcA3QnjakSeViR9duPHYfGTDLc/nKO8mUQ
         S2FSkRozDSnryUTAUgUtDRaVZz2qhawwzmCiG6nz+c9Bqzhwhz+oVb/Tk5aW023hmb1+
         N7WA==
X-Forwarded-Encrypted: i=1; AJvYcCVe66p9Kbz3KTyAF5JM+9vJy7dl79EMdOX7Yl49JS2yLayk+gHekO+HBwQ91O+DqFtWGVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ayM0qCwYoxE7dw2dWQfQ5KTn0CdNGznvzHNR48mg1O6xZ9UL
	z5Y48QfsjsEOPYo1QyW2uNfAPWEN76wj2g7T4hfksFKUgYy85+PwsFzjSOFuLp1cK8c=
X-Gm-Gg: ASbGncvv199+aNrYvFxPLjXr3t7PtCc1KYRMA5Dl4+scULyvTGt0CWIekQpYLPpIApQ
	Fpuk1eg0wQ8ZELkwkpCG5jKdCsQbZOFGWZ2+fCLvYfROxHfDxaBec5KDzg+6sJJ/tnUFw71IFoA
	XqFKBLHhzFJ6xK/pE0lYjCMGAdsbrsvpYuBPQEqTDkpLhZ/RStOxAx285+AvSsVMDcrUPG0l16p
	KfJCyuOSPw0eDwshlKhrowbazM2/PcRnCuJrRmlWOJMeO3QwVS+Dg2nrq+1uFWtDCZK9LTj7rpL
	osS1ku/2y7DH2jvDFZmD1e0kP7s0gyRS8v8DhFfwKEMr7FG+iDyQSJE3YLdL+w==
X-Google-Smtp-Source: AGHT+IH7O+shX11hZ6eCVIHjDlpUJqIcDtI7F2eLg75fNlz2BtQfiB7sw/8KPUOKfPudYOtXBmCrTw==
X-Received: by 2002:a17:90b:3d8c:b0:312:e76f:520f with SMTP id 98e67ed59e1d1-31425b3690emr3900962a91.8.1750263960183;
        Wed, 18 Jun 2025 09:26:00 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:59 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 10/12] selftests/bpf: Create established sockets in socket iterator tests
Date: Wed, 18 Jun 2025 09:25:41 -0700
Message-ID: <20250618162545.15633-11-jordan@jrife.io>
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

Prepare for bucket resume tests for established TCP sockets by creating
established sockets. Collect socket fds from connect() and accept()
sides and pass them to test cases.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 83 ++++++++++++++++++-
 1 file changed, 79 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 4c145c5415f1..2b0504cb127b 100644
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


