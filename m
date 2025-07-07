Return-Path: <bpf+bounces-62530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCFAAFB7F7
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B629016F36C
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC50D2144CF;
	Mon,  7 Jul 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="FtTaYm5B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE35219311
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903481; cv=none; b=KqQCCjSfkYhnlLhDVPs4IZd3qWm8V7QGPbbGcSEFeYf7vY1DALJzkCYERbpVw0mxb4nIyi/pQJGt+vvAi5hSOxHIwaF1TZYHK9mfYOeAKTKTdJmEvWWrQOWZSCv+Je9fo1pfc752De3jPjjKVrU/oAy3RBrkCI1JXszMjBwgK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903481; c=relaxed/simple;
	bh=KpaAZSzE0Xh8q3DSD6/TEtreQDWx77BOjF6mVkC0wDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLOz8AqAedcLk5SlXjLOfH4d5NXH6Cb5GH7FNbqnZTKw31R9vCOW+FS7c4bUxC3xNmEt94jOE3PLfbhGyLxTnRUJ3uF49X2OWYhgvf/i8qQIQHwHsUA/T9AcIM3bC/+wtJgdLo7WfXJU2Z49fh9J3AdSczbFCgWX64lHPtwF1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=FtTaYm5B; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23c71b21f72so4261855ad.2
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903478; x=1752508278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZKdoOQwlfR0KROJ2v6wBzEhaRvcP0creswUNdSHqGE=;
        b=FtTaYm5BwqxXeJbgHGPza6dnM0T/4VUfy1l5kCqgEHaaqx5DjyJZjzJH7g+lc0gEcR
         ASf37H0VnfNd/BA8di3sz5wB2m/adZiv7uzHbvfUi4WGOQFoqskfol9nTjPQe+t8OICO
         0M49ek17y2NRBJ40dfCbcify1xbX9feUk0GAKPuGchzhaitgJy7xBSJTH3cuMJL+JQ42
         /MjRsYFyS6psCLtVdqpCUD+kBjq7hzE0FAs6LhN6terj3qoRx23xR1/1lZooZPohbIOU
         pVzJ9MKlszk+0vMjgjXa3nwTNwc6m/+q3X81bJGy4evOmrvn4TiZuJYSj5mxn1vwc9Xd
         Bcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903478; x=1752508278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZKdoOQwlfR0KROJ2v6wBzEhaRvcP0creswUNdSHqGE=;
        b=Y7itJNnMR6avwlKTDev3b5hOVcSgDZ0gkSFPpp0PDaRJdBcAYK9xEi2o6pcZ14XAcd
         MWIGTvJ+jN4sGMrXZxz727qYi4JY7Ux7TxUmXva8sBxSzKZe1MUxKwyM6xkYAsBxV3M3
         eevobAENkAaCFtVwLQ5fqQRjOYhgHAWIMRKrgU8MECBMhq7WggDl4vO38GTeLVXdDffy
         oprrfLZILtV1znN+Q/eWm3tQcmQ2rOBIeBdsqg3LJJDLoGj+1VVJ4ILdzay+J25k5gv+
         Z9R8c1hVdzG7NG63Pzb18ia6TpOWOwWT3gpziOeD4T0VHSwIsQacu2NIh/uAxjAZzBl5
         GjCw==
X-Forwarded-Encrypted: i=1; AJvYcCX/KfD7CsI0PObVyNkIQ42IvfAWqh0ion51+hzT6A9yOl1iwBglxWONdG6tVM2olx7yXwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPBJm/GzGmmb+wkw/KTu7yBGCEuf27KtW8U+4ycN6HvqHUd7PQ
	IZjw8U4xAYpecHv+GuIAvHzES6bZ0Tei/+ljIgLrARWCFvw4mO3zKYXwO/yt4O6outk=
X-Gm-Gg: ASbGncvP1Dd+KtEIH7ugoc0eTfWg5IN16r9g6ad1U/QVr1c2DW0V/4w2inPhx8GHV7b
	s3/mE45eRS1gqIEVfqiT3LWA3aRbt45gmBCXtRUwDdxzKSFS+NcS98mEiGpMOT4oIsifEcJz1xu
	JuuaUIXZhVemj7nurYC3LwqbmicjCyU8ijyVYzdJX7Q0K5iom0D7WlfsKUJKJP02MLGJ1h+qbEe
	R+5NyYG8ASahqquSN71BGxmAUqNOBDIf1F3KciUV2UvUzQi3eBXoZ+6PAU94vr1wFpwvwT8fJie
	6zDwnODX4++egz/MMrExb1cHwRLOkvg6C7jilZsAxStzo+Cxs7/1CRtKTKv8Bw==
X-Google-Smtp-Source: AGHT+IHDegWeoVvvnYF1+VY91CIvP0MnYjCAz9CfmcVHRSDkufOJTQ6qR8SWPysCKRsTyZs+y/Inkw==
X-Received: by 2002:a17:902:c408:b0:235:ee04:dd2e with SMTP id d9443c01a7336-23c873d1292mr76017495ad.10.1751903478034;
        Mon, 07 Jul 2025 08:51:18 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:17 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v4 bpf-next 08/12] selftests/bpf: Allow for iteration over multiple states
Date: Mon,  7 Jul 2025 08:50:56 -0700
Message-ID: <20250707155102.672692-9-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707155102.672692-1-jordan@jrife.io>
References: <20250707155102.672692-1-jordan@jrife.io>
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
 .../selftests/bpf/prog_tests/sock_iter_batch.c        |  3 +++
 tools/testing/selftests/bpf/progs/sock_iter_batch.c   | 11 ++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 0d0f1b4debff..4e15a0c2f237 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -433,6 +433,7 @@ static void do_resume_test(struct test_case *tc)
 	skel->rodata->ports[0] = 0;
 	skel->rodata->ports[1] = 0;
 	skel->rodata->sf = tc->family;
+	skel->rodata->ss = 0;
 
 	err = sock_iter_batch__load(skel);
 	if (!ASSERT_OK(err, "sock_iter_batch__load"))
@@ -498,6 +499,8 @@ static void do_test(int sock_type, bool onebyone)
 		skel->rodata->ports[i] = ntohs(local_port);
 	}
 	skel->rodata->sf = AF_INET6;
+	if (sock_type == SOCK_STREAM)
+		skel->rodata->ss = TCP_LISTEN;
 
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


