Return-Path: <bpf+bounces-60970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E972ADF2A3
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2D23A8E8F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8552F272D;
	Wed, 18 Jun 2025 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="vAPITIeP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F186E2F2375
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263960; cv=none; b=gJNyeTooLj/fuTiC/tNedETGGo1p6Q/GrHV16Kk2e1kkJOjJ0YbsZfkVbpa9Aa30WI9i1Bpl7WOb4vmEgrlhkXg5DTChVEXkTzlCmlNxY08TfGUwkes0n0VvTYSfCvfIEUnlHr4lB7/+rKpifYswMq0XNsD1+Oi9xI0BpV4kCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263960; c=relaxed/simple;
	bh=mTy8YzU7JSBd81KeNJlEDl5R/G2Y3E8g9DO2QVklRbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7LUZsASs8jEQQtsU2Tah79QGaNElsFfCI8JCM86F3qiGVE/rehiVL5Cv6t0wIubyl1SSJB1mloRx85+nzPwuxTfjcyfCw4qbsMdW//X/Xbpep28w2njbyJ7c3y4ZghQM8BYi9l0LCw3zEE37q7UPUnO4sHQzlrj0iaqZawe9VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=vAPITIeP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so1290250a91.1
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263958; x=1750868758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BAM5lg+blgxOtU+dzU4+JCJ8A4TZKJftE6piUkwsyE=;
        b=vAPITIePk/vJPt/S12mZWYVGzoB91uXm4WcR3J2SQnIlYC6EojBlUbHddDBZz2V5Bj
         H06qsNZZW2nwNEh/0CcWe32MhpPZgCyBprh205yd9EDcAZEhXBborMUE9MhS2pl4BuR0
         uJzGzfZ0TVGgQ4JzLoYnR0Fgc/2kCyLrS4F1UBNPo01t6TrFrnwDj7Dsd5DyaVG91p5H
         tRhiN9UNMTa4L4jfUAs2mvGoZ728Y9b4lej9zAL43VHjIv4tuZ/toKElSWTjsidZ3lEP
         mE8pUV1fAFAgflgaepi4wcbZgMt8Dfy/YrwHbWPNdLo6gIAUF3SkC4wlpJQYw/ZKFjQr
         B2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263958; x=1750868758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BAM5lg+blgxOtU+dzU4+JCJ8A4TZKJftE6piUkwsyE=;
        b=Sy0fLx7lg9ys+5mGqMgFuwjThqDDlnTSbZ3K4sblbMlPwU8moeFeOiHASuIsMT+kan
         UB9gkAK6tyCatfY8dVFOR2kqJueioFc+9P0MFNRcM9F1d/lDIC77aOaH2yxhbQT0y0lJ
         FPS3njGzXcjLiJgkJOWop5r9a+oQ2/4mLag8vuDkKA9YPygDwOCtBeM0C+1maRIPG5Xb
         RES/lLzt0DIJdNnj1p3z6bwVLfXIZj6NxWjhvvjC3wKJsgu5O63gEVxc9jwNQfWudGWb
         qLoJ9qfLCYk2PapN+iG2PDa5bEPxOOA2lndl/CkGlzFYpTN2uPmBHm7CtnesFbq+4ae9
         6/9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0775TI7EFb9GmvoSbsOpwr+4kyLn2Ta4OKAmGd3rxqVgRPbGD7oe+i1Pbph693TYNCHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3l2p39NW9O7nsXVKnySDGxCH2RkTPb2DUkLg/XvhnRQ+BFrrz
	bLKWHS150Cbvp3ukVoeMwh6lXbMqZoNXW7RLDFJCrN3feHiNAIH49MyF+C/kl6gSS4M=
X-Gm-Gg: ASbGnctPP1uwavM7JAb1ycd/uPix1bNh6rSnXD5IpzE4H1dulkrcs9pT77QSB4XIHvs
	1/lJnt7XbhUrsgbKJpM5w9Hg8I+r7d4Q+YhKT7lTDZM90d1gANgyawezQamqKzOXKpp1478ek0m
	MrcjXdK6p/DgvBLgphCgPgcj6lHgb0W6lK0g4lEJhimeDeSREcm64/pq1edAFpULx6ilIMnzeS8
	QJYv3zt9lG8XicX5JP9Ru47cryq0e8m1IsEJmAKyqjghTHwOWBR5qTr03NBHC1MhvBWazGLOQfW
	CQJ652wEulaRkYxRTL2wxKfeZXjH3o3HEOnoa6vhI88MeK5D3bI=
X-Google-Smtp-Source: AGHT+IFAC8gNIh2HvjD6OK1wT2J+23cXaHzcKrX/AQ5bDtzM0dcZYLMl1IHbJSX6DGpNIFns/P6ODA==
X-Received: by 2002:a17:90b:5825:b0:30a:80bc:ad4 with SMTP id 98e67ed59e1d1-31425261c29mr3883991a91.0.1750263957844;
        Wed, 18 Jun 2025 09:25:57 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:57 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 08/12] selftests/bpf: Allow for iteration over multiple states
Date: Wed, 18 Jun 2025 09:25:39 -0700
Message-ID: <20250618162545.15633-9-jordan@jrife.io>
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

Add parentheses around loopback address check to fix up logic and make
the socket state filter configurable for the TCP socket iterators.
Iterators can skip the socket state check by setting ss to 0.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../selftests/bpf/prog_tests/sock_iter_batch.c        |  2 ++
 tools/testing/selftests/bpf/progs/sock_iter_batch.c   | 11 ++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 0d0f1b4debff..afe0f55ead75 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -433,6 +433,7 @@ static void do_resume_test(struct test_case *tc)
 	skel->rodata->ports[0] = 0;
 	skel->rodata->ports[1] = 0;
 	skel->rodata->sf = tc->family;
+	skel->rodata->ss = 0;
 
 	err = sock_iter_batch__load(skel);
 	if (!ASSERT_OK(err, "sock_iter_batch__load"))
@@ -498,6 +499,7 @@ static void do_test(int sock_type, bool onebyone)
 		skel->rodata->ports[i] = ntohs(local_port);
 	}
 	skel->rodata->sf = AF_INET6;
+	skel->rodata->ss = TCP_LISTEN;
 
 	err = sock_iter_batch__load(skel);
 	if (!ASSERT_OK(err, "sock_iter_batch__load"))
diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index 40dce6a38c30..a36361e4a5de 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -23,6 +23,7 @@ static bool ipv4_addr_loopback(__be32 a)
 }
 
 volatile const unsigned int sf;
+volatile const unsigned int ss;
 volatile const __u16 ports[2];
 unsigned int bucket[2];
 
@@ -42,10 +43,10 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 	sock_cookie = bpf_get_socket_cookie(sk);
 	sk = bpf_core_cast(sk, struct sock);
 	if (sk->sk_family != sf ||
-	    sk->sk_state != TCP_LISTEN ||
-	    sk->sk_family == AF_INET6 ?
+	    (ss && sk->sk_state != ss) ||
+	    (sk->sk_family == AF_INET6 ?
 	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr) :
-	    !ipv4_addr_loopback(sk->sk_rcv_saddr))
+	    !ipv4_addr_loopback(sk->sk_rcv_saddr)))
 		return 0;
 
 	if (sk->sk_num == ports[0])
@@ -85,9 +86,9 @@ int iter_udp_soreuse(struct bpf_iter__udp *ctx)
 	sock_cookie = bpf_get_socket_cookie(sk);
 	sk = bpf_core_cast(sk, struct sock);
 	if (sk->sk_family != sf ||
-	    sk->sk_family == AF_INET6 ?
+	    (sk->sk_family == AF_INET6 ?
 	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr) :
-	    !ipv4_addr_loopback(sk->sk_rcv_saddr))
+	    !ipv4_addr_loopback(sk->sk_rcv_saddr)))
 		return 0;
 
 	if (sk->sk_num == ports[0])
-- 
2.43.0


