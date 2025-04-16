Return-Path: <bpf+bounces-56079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1186AA90FB4
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 01:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A93446C2C
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 23:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6466A24C669;
	Wed, 16 Apr 2025 23:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="YvyLQF9K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DDD24C071
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 23:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846602; cv=none; b=OwD5r1ZSQUtCe72jYPHrULExgBm6QaTBCytwQ3ggxURjfd0hUwdUMO42nr8kze4yHvMJE3wXk1NLClQu5cMP2f2MIkuVyFOd69LIbGV+bHKJY4+b/FwjzEML9rbcfJvbG96sctlCP/UbJMcLosm8R0MC+VocjCAVcTBCUh4sYdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846602; c=relaxed/simple;
	bh=8D3K8jEJFy2ljx8/dNSQp4nr5+k3ju7eECDWQX6lssg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ysqij0sGlYxCda7AeKTELO422ct7IwA1ajn9EDQHtFn1T0IrhQWhGsjLUe/fl97jfPYwYTbOtSndQr0+x3nOfT8+x1hhRP1DE9Lqlgh2qsdNPfJHH80wk9cBIevzBhHxjjGPnorOc2eigLHs6844Jr1GZ3bBMbHdN2KG1OEbvuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=YvyLQF9K; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240d930f13so342265ad.3
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 16:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744846601; x=1745451401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4N8moraxYLNX0qhNglQq0LQLGcDgagzwGmqz/6Y4IFY=;
        b=YvyLQF9KuIaNLu4y4gs9Hg4hhBypacJCUsl/EkTHuVbWy93EDEHQizTbvvZ3gz2zM/
         Pe7tCb3f0F0k8esr8aPzTHKXwdBWEvJfN2xBw+lSj1upoAYjdKFsu3o1sPsKFZnaMvJ3
         P4PfVb0AR+E4BFihkSE4/CmghDYjy97pCzCrdblqaMrthMPXhiy+RXrHn+R6I9ecMrpS
         rlpuR4U1ni73o4O6vCTKkR+tlEvbEa1VF+JYKPdBhJbddcUTvxSbZ14n8vnQ77f1E4je
         czCguAWi7S2miOd2Cs2HTSVdsb580+vvPxQbtqI3b9aAGYOOY5YjV2HRrQ65uvJ2nkx/
         Ho6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744846601; x=1745451401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4N8moraxYLNX0qhNglQq0LQLGcDgagzwGmqz/6Y4IFY=;
        b=d9oRon6YYBl/J8wZBkYNfTCrP+K8oYpPHi1dceaSDCdAQ+lPIA9qoxR07LCv1oX3oW
         /sl50OWpjkssaMQ4miDmebS10GZX2a0PCfalq/eelfABeGjKIKQIry/lVqXvfdWoXWzb
         TpZ2Gd6sxRYCJmXD42zVsQtAdRTMnmrOXs/udLM5rgN97dAwzNIGzYZauoA7ToV77zr4
         rs58zQZSzkat6xcYE43wRX0zRKMOhA+XC7o2MDIqJ9MXCVCpBpIbfACrAs/1Bfhee3rF
         9fdlVLypmTxQZcXsDXUnO/hWmv+x45cWsY9LXfJ1yDFilcF3P6eCwCtfxhk20c9qw/n5
         HBMA==
X-Forwarded-Encrypted: i=1; AJvYcCWBCrrjnhkyfPaZsE/gsOfW+jkMA5kUIAmZ6Wx9UyD9gjxzoyjAp/xf6kpz8+AMXfP0/r8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/x6uQaXv7sR7n9DUzvAzuJ4Ma4ove7Oa3n43IuBq5Xb2y55A
	r8Ic3OwCowGjcexSAVb7EurBTJkzLw4HPkUGKfsWPSgeyT7Fx7NRikGwF5w0/iQ=
X-Gm-Gg: ASbGncsMmSyO9lv2x86TdcIKrWI+RCCyG2qfB9+11maPboSTyiY7eC4ZDBIWERReHzZ
	O8R3Ku6/tea+0YJVAJCRogwUPKjSE3Mn8pBJKOegTbfBnFqzo/kNZFwE5/K8wJYyU3ZPXZJM3+x
	HVAppnMb237gbKBtHByZTozhg6KNSocLdRJgy05sBJrdGTeXDgh8OWIGAlYZrveRAFph3bi/AqG
	slX2gd1zl1jVtHLHxgguBGKUUfs6UyvgEbcCGxMFWuU7bcD61zsxPR6PJ9qC69QOxQuKuNceVOp
	IpNouGkj/VoYN7SQu3aLrOy1j59CjA==
X-Google-Smtp-Source: AGHT+IHnbXJbtwKFENrQsWyLDWP3UqogQb4d8by1Iu379OI/WxHwrWCHo0akplDYxtdNQx+gwYTHsg==
X-Received: by 2002:a17:90b:4b08:b0:305:5f20:b28c with SMTP id 98e67ed59e1d1-3086d444463mr966366a91.5.1744846600758;
        Wed, 16 Apr 2025 16:36:40 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:b7fc:bdc8:4289:858f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d6166sm2269251a91.7.2025.04.16.16.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 16:36:40 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v3 bpf-next 5/6] selftests/bpf: Return socket cookies from sock_iter_batch progs
Date: Wed, 16 Apr 2025 16:36:20 -0700
Message-ID: <20250416233622.1212256-6-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416233622.1212256-1-jordan@jrife.io>
References: <20250416233622.1212256-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the iter_udp_soreuse and iter_tcp_soreuse programs to write the
cookie of the current socket, so that we can track the identity of the
sockets that the iterator has seen so far. Update the existing do_test
function to account for this change to the iterator program output. At
the same time, teach both programs to work with AF_INET as well.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 33 +++++++++++--------
 .../selftests/bpf/progs/bpf_tracing_net.h     |  1 +
 .../selftests/bpf/progs/sock_iter_batch.c     | 24 +++++++++++---
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index d56e18b25528..74dbe91806a0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -9,12 +9,18 @@
 
 static const int nr_soreuse = 4;
 
+struct iter_out {
+	int idx;
+	__u64 cookie;
+} __packed;
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
@@ -34,6 +40,7 @@ static void do_test(int sock_type, bool onebyone)
 			goto done;
 		skel->rodata->ports[i] = ntohs(local_port);
 	}
+	skel->rodata->sf = AF_INET6;
 
 	err = sock_iter_batch__load(skel);
 	if (!ASSERT_OK(err, "sock_iter_batch__load"))
@@ -55,38 +62,38 @@ static void do_test(int sock_type, bool onebyone)
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


