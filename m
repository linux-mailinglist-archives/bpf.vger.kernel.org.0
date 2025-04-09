Return-Path: <bpf+bounces-55568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A32A82E8B
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 20:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9CC460D6C
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BAB278157;
	Wed,  9 Apr 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="zsa4sRbu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A619270EC0
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222969; cv=none; b=HWFGjW4+DIA2ESlmaLsTmQzhUzGHhVF7YU0Fd6JO98ECR8UcDKqkS+R/MxI5jdY/+l2UlMYEgv+8Px97mn6SzXb5a0khcpHRUEfaXAvLS5XZqO5d6FHgUMdq/OkYqhdcyN0K6v4K7vj3zIjXOQK32XpjGCS6KoAm0WEHsHflKnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222969; c=relaxed/simple;
	bh=8D3K8jEJFy2ljx8/dNSQp4nr5+k3ju7eECDWQX6lssg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCH1VfQN/c4cdN4ScKRSEzkFqv0Jwg3wBVIkVgkURu/N35/ud7XvKeU4gq/DP2LEAm3nKRBVw9jAlWnRLslVnM5e0Fi/gtUveQmX3Qn0CEW8JYKGGKRmrLxIHoPKgFRc6/CKDCsyjLVCtnjXLsCR1tivD/tTgsqCA2R/13HwC7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=zsa4sRbu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736b94d12b6so558186b3a.1
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744222966; x=1744827766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4N8moraxYLNX0qhNglQq0LQLGcDgagzwGmqz/6Y4IFY=;
        b=zsa4sRbuxLDqHJcPWwjOc0W8Vxv37fsYWyGDxnoTmUtQENaaArxVSzwyhGb/9HjRzK
         GNRV27qCj0fuc6uW9IhGcXZKsyG796rjqKbxpVbzE1o6+5aUpMwVjEMmzHJJnYtpapyc
         Zlrm2jxfIrdSWlxkDlfV9Fy4/hN0gLxfhwB1qJnEVv04Sy7WHycx25gJOgB2H8h6rUyC
         9wfIJ3LHEXkWhIDBbBtsKijaL1U2/ZftklKgR8zG2zqW7IDGcW4FrFGlsyp1kKJzyJDw
         4T4VsCCYHkcinaOZfj5o/McwzB0umrScmEiSXo0vfZCksY0zhVZmVTFSkuJ+Xl2XfHoH
         2wmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744222966; x=1744827766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4N8moraxYLNX0qhNglQq0LQLGcDgagzwGmqz/6Y4IFY=;
        b=lHEzCMBnYpDtotk3E6VdDkrRtPcTXhNV9H+AVcUWvb4/rVHmJBYxJc11n2IrL/BzWG
         hwWMUDXca4JwQ8yk1fzErzWVhDhXsorEyuss9y/qpp9kQkd4EZpm/s35ZnAOj5IVM2jh
         do0y1Crxs7k184R1JqHsM4cVmP27agYuIW4o7WvrkqVrXZjoHCPKa2Zeotxqu6bM6yXv
         212zuCbGfKKg796yx24fsbM2vHBPV0Kc/M9bp/P+/p+k/Sc/OTmR7jLawCOAjMa70JiH
         lkXo4A3URl2imt7K2w80VlqvbCX/SfEg8kNJIFSDLScYr2Fkbk+mjj3dM6c1h/AMTJRV
         wafA==
X-Forwarded-Encrypted: i=1; AJvYcCViYJkolkU4u/BOrNXzhlaw2VdJIavKs1vYKbAeTyhVppwpBl8NRS2VqXDCzmRdP8SmWeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Dj76RrBP6MWFy9drHewY/q2LhiwIegYfzjAcXzCERt6vUmIn
	U+kLSYmgr2aOjFnt0ZSGGSu5BUG5F85Vwr3QYjOKWuGbPGdIj1kC2K1ApDlZC5A=
X-Gm-Gg: ASbGncsb84wIOxh601g7fN55mNiMYRbL6uqOdfwCh0z7kgzb89VfaSsxgE+4Ial5m67
	q/CqDAHNs713Ih4Segy1nFB+rGUUII2j2EDBj6Q39KU1QiTVSrdYopLheWtNlDJ7syHSfkFdqOG
	uMT5ON6CxSEJgc3z3QUfpPftTIGcIQSCobJ1SnZthDD9TpKJFMZau5MoontiA3cRVqPpZlHyEUH
	ighay1jJfCmG4kAmBr2L+ehsR2X22ou0IIhjZZABdTbiYNk1qEEIPlNb7j/HSgZlVdUSzeegaxw
	+Q6subOXDHeGeXjTN39uE61t/XJ2hA==
X-Google-Smtp-Source: AGHT+IG92xtvcFxjgQsiw/Zqfnb60jq+T8hpez4KBBUwwGtCyFXnFshWfQHyEMlRsrBN3ExBYvtDFg==
X-Received: by 2002:a05:6a00:14c6:b0:726:380a:282f with SMTP id d2e1a72fcca58-73bae48bee8mr2064256b3a.2.1744222966483;
        Wed, 09 Apr 2025 11:22:46 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:2f6b:1a9a:d8b7:a414])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2ae5fsm1673021b3a.20.2025.04.09.11.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:22:46 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v1 bpf-next 4/5] selftests/bpf: Return socket cookies from sock_iter_batch progs
Date: Wed,  9 Apr 2025 11:22:33 -0700
Message-ID: <20250409182237.441532-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409182237.441532-1-jordan@jrife.io>
References: <20250409182237.441532-1-jordan@jrife.io>
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


