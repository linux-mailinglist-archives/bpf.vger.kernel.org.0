Return-Path: <bpf+bounces-55770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F92A864DA
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F117AD549
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837E23A9B5;
	Fri, 11 Apr 2025 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="t0B0K04Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2252397BF
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392976; cv=none; b=MQxSJCsjDMgOExoKEHKsljQL+pHkmFVkO6dUPFH1dHiy0dgHeOsWGodi5goOSe4YQrx62QqY5s8EXORHAtQHYClAHNhTAs2eQchcQpLF6G4m2mIfY19VeSaZK9UXI8wssaaZjL/gcp3vw2CIN1b2xx7D+y8IhrggmTAzKiEqVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392976; c=relaxed/simple;
	bh=8D3K8jEJFy2ljx8/dNSQp4nr5+k3ju7eECDWQX6lssg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpnuT+0/Q6mJoI3wFzA86K0uvOWqfBVEmR7bg10OcvOq0vGmAlRbssdgeqOa9wEg1WxtvBWJZKmN4Hmpg8zI/4QIifVGcCZr8buqV0ifyiMZHmt6ezkuO5SmKlkqYJhPTwfiTVrSoGg0LqOsGitIA1VGfG8CVh2FwgIbX1l8kww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=t0B0K04Y; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224104a9230so3006935ad.1
        for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744392975; x=1744997775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4N8moraxYLNX0qhNglQq0LQLGcDgagzwGmqz/6Y4IFY=;
        b=t0B0K04YXdv80CpYa1thStQXlTukEPGNiAC43e7pqzN8P1xmdY4gyy1bu2/UlMxB3Q
         k400PEFPGcGKP7jVhpvBt8CUGtpd1xKfCayCrHOu/MlpF+VmLgcIC9WiMfe0iXTP3Tfm
         vDNVq715xf3K1aVRW8VZrs8jCuhZwVSsIDLPBr50Ucm0kGDHvhnOh3nyUbn9mbypbAs2
         3LvKTaJFcnwVCaxRG8DIWJV4tETL/PocC59ZROpyg6DPYieQohlPEMUwsIZFHQStwEFw
         XO2acxY4Ar2PpU+2GZ5Khn7Uu3AWm0sisMq3JCPPvqOk/m31GH+JP6Y8SGJ7sb66tI1u
         abIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744392975; x=1744997775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4N8moraxYLNX0qhNglQq0LQLGcDgagzwGmqz/6Y4IFY=;
        b=I5f0oDsl7OMVfsyM0uCm/qPL+TPM0UGGq6ihHBGvj4+GEcN+4N3x1GnLt+szO3eJWu
         SaDpiZxQZ+MdG2avIJpilL+69RevFl+LYxjAVztZwQDEyoSWxrB++FZ8nKJo7QYusnnL
         aNPYIZvDtY44G+XgsZUF3fAusIPHyQl25YJsBXBrw6Y2mSMx1CN4JIjBs+AVlxIMoCEe
         MXXEkRwvUoAulnjQBZRQLWMrw7JH+gB+qLDZ1U96cW8FC2J94IdNblWc4jHuxcDM0Foq
         PsC6FOLJXmYMy3GotggnSIHwa9SXPVFkYKf2UQ7whBF1wYRZbiaSSjCQKttEqwNYLX9q
         Xb+w==
X-Forwarded-Encrypted: i=1; AJvYcCVMuuPa6WnXH0wi2145prW1kiw4G8crHaEPumy2GDvVVhJe0SYshJQvaeL5I8u8pMORFw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJtF5dfIxNmZ+3CXbi/F/opdd1M+nSv2iUB8MryKX7VhJLlN2O
	X7s9F4rMnchQCLtDSY0vSmCPGEMkXOamPn0SK4lLluVpUleZOzp7AEWu0oDw8Y4=
X-Gm-Gg: ASbGncvVSlJ5u0FCl9n+Opu4KQ399i0tI5Pcub5h62VBTsZ/Bo5rTK6ONzAZ+sJv37l
	upwMcjxT0DTDtS45WsC2w3xalW+Lx29oXhh33SLVXhFJN5HaM2YBmwJUSxQK8s0wJnagjEE7yCz
	b0F46UexZOVILYLSkSm1H6xtERgLWbBL4c1HAsbrHhF30azGnvlrOTMeHoX8NUBHSnxfXL5+9pb
	7K3U1RVnlGhPFpEr+04SoPvRBdRlb/mjFEro8c9YRjeXpORUI3BbZcUgGEmlbsRDOX8e5oAbBwZ
	KLhM4uhpsD2yLphJbtM893PR5iU5+A==
X-Google-Smtp-Source: AGHT+IGTfvbJh4mL1TfcRT6lsOadzGeRC9u8bstEVO2wc9FoEYgFAvFKYz80/fQnPgjsXS8InI1mDA==
X-Received: by 2002:a17:902:f684:b0:220:e1e6:446e with SMTP id d9443c01a7336-22bea4a1d32mr19117225ad.1.1744392974615;
        Fri, 11 Apr 2025 10:36:14 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:fd98:4c7f:39fa:a5c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb6a50sm52317725ad.205.2025.04.11.10.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:36:14 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v2 bpf-next 4/5] selftests/bpf: Return socket cookies from sock_iter_batch progs
Date: Fri, 11 Apr 2025 10:35:44 -0700
Message-ID: <20250411173551.772577-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411173551.772577-1-jordan@jrife.io>
References: <20250411173551.772577-1-jordan@jrife.io>
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


