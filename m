Return-Path: <bpf+bounces-57247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1053AAA76F9
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 18:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4F21C07729
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7363025D21E;
	Fri,  2 May 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="JNnhIGCw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1025E458
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202546; cv=none; b=FptSc8HHhz1jwZl8zshUfifw6YkWMGPgCdTOkj1dOpfM4QTrPpg6gcTS17qX9y1oNA0++RYDseEC4ZzSxg8+CS6Ydw8DsnHevAXYnxxfuw9+3XBTNIQC28GKFjXPQ9bpjtE5lBGLyfDmqe3MYT8l0n4+zEyS7MBTREQhCYOkBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202546; c=relaxed/simple;
	bh=8D3K8jEJFy2ljx8/dNSQp4nr5+k3ju7eECDWQX6lssg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bz60PefHxOt3QAUI8snxzkIim9oE0gmWBTiL6YySIvjH6AQljL0NOi2XNFkmiK/ZxWmBcuJdbv9yJhCHu4vdLd1lCO7JLN/FocSsDHoYefb2Eoo8Tu1Rl3YcZNvDUtvlo13r2hKM6zV38JzHt1qyteuSA8ySG1dcGpC4qIPu1EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=JNnhIGCw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223fd44daf8so4229355ad.2
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1746202543; x=1746807343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4N8moraxYLNX0qhNglQq0LQLGcDgagzwGmqz/6Y4IFY=;
        b=JNnhIGCw/X2Fm5MZbQusUaRj8Ql9dI3y3XBtQR7FrBLbnjziqRkr5Gdamhe2VVJBqz
         Hvo8mg4FQzPz6+uPTZB6mn2gFamJswp2OORDC41Auj/JzwPF2qoLWd3cSg0mIxPY32lx
         DQun/mBaqeH11eim50jr/Xb1LwAAXV8400fa1zxG4NsqAO/4d+S4ITQEUDSLFFLoMj0E
         IFnXelHIOFuyvjfsEE/BQN0Qv6HrS4Flew0aJ4ZA/L9z6MvZrP+PdzOGolZVO6yml6jO
         BMxbRMWNczFf9YghgMJ7KiDzCooyGez6G75ZtADoP8RDpJhzCNzyduObPJXT8J1sCF/h
         l4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202543; x=1746807343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4N8moraxYLNX0qhNglQq0LQLGcDgagzwGmqz/6Y4IFY=;
        b=FqlqxnWe0j2GTFYzTXFWSJMUEszlB64dco2zNogpcH0/+hd3qcCkYBx1PyA3Gki8sY
         DFqz1ZABCPWyxgrTWQRs0Bv5lNqkgWTJuK5vOhGClxxJxjqBYlennS6XM7FeFsD4qItl
         Z1HODWaVbjqC+XPmkf3Xh+6OwUnPUS01lRpLukk9o0B0kOyxgPdpuC2JSATP5ES96yJd
         bTDbhx07ONkY7NXOHeMJHgdBo2wHBTkEMn9OsqPllJv59YE7PEQesbAUNdjunyxcv5lr
         R8FhH+n0tOug8MiGgzq3zrUpIvCaVFpR1wrCVXda1bKAwoS81wD07FaDiiF1w5jnlQWf
         StSA==
X-Forwarded-Encrypted: i=1; AJvYcCX4PPWOfCywwY17tDXNLw1Bhn6Sp1uln7gvhMGgMQi2NWGWYhoiw+FdLTpTS8cYj5DWv5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5p2cutHqRMa7Zla1JqmGKCqAyeqjhd4OtDTIs4x9WjHK0jAR5
	kfNrtBAMt/V97hd5jw0UiAx5ZAUp1PyQPlvktrfNmce+ThvbFUG1nacmstLOo34=
X-Gm-Gg: ASbGnctQKH5re3yFATkvArWRKE31hthwvqR460ai7gNaHbrjxBt9bPQTzW6wKB9VX+v
	jkI7IWedkhdnxKoUCcAr1Z+iArDuN44euZbRQeBDPuA869MFhK36j+Ud13q7jrqMJiQKDdZqyE2
	elbCQ1jrCb7hTDHwK0wjfG3Jx4w7hjoYgbO2+CeBGNxB6BzsRQ6e3cbkEQYuOG7rTrOz3NBJcJl
	tMd7xTvtFVMVWuv0A1nar+SsrU/yPmKLVCWLfq9cCi5AGD6itUxAjpMCefK8kVwBDz7mXI+4uL3
	1WChy50H4WmtFTpusDo6LV0iBJx2sw==
X-Google-Smtp-Source: AGHT+IHaqELG8UqA/BmdmFJqmuzUtmBpf5hLzJKv8S6CxU3f4U7DqbZoBkAQRTHn29JD1m1x7GOZfQ==
X-Received: by 2002:a17:902:e747:b0:223:49ce:67a2 with SMTP id d9443c01a7336-22e1032c789mr18310555ad.9.1746202543330;
        Fri, 02 May 2025 09:15:43 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:7676:294c:90a5:2828])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e95c3sm9572135ad.68.2025.05.02.09.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:15:43 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 6/7] selftests/bpf: Return socket cookies from sock_iter_batch progs
Date: Fri,  2 May 2025 09:15:25 -0700
Message-ID: <20250502161528.264630-7-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502161528.264630-1-jordan@jrife.io>
References: <20250502161528.264630-1-jordan@jrife.io>
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


