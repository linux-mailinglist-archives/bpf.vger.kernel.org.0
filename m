Return-Path: <bpf+bounces-59385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE37AC9726
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6283AA808
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 21:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A073284B3F;
	Fri, 30 May 2025 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="yk4WtAqe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00A27C17F
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640713; cv=none; b=iqIcYs1qzBogtgZr+4vrGtFc3QHXXhM8F7s2LxXEOVFi5YkHOrR4itwMiyCgixkjupb7Nko75nlsnhcw/BzYqmEmxAwG/ZnzM7ULQNyQfgSO4MTo6q89ojcT4KPEsTlivcpH7bXWK+PBHqoF1W4mUGfB86j8xBb+UTOVnbq6Nhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640713; c=relaxed/simple;
	bh=mTy8YzU7JSBd81KeNJlEDl5R/G2Y3E8g9DO2QVklRbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nX3G4irXxYgLhQbks0hXXq5ST3x2gxkToA0ajh762V2lFl/vGqaTl+uGVEhVA+pi1bSvPjSOfwtMzo1GIhC0jBYuyqxbTHGTWOp4M1nl6rNr+9BcGBpm09p8mjaGJNoSnW6I6rUKBxOZmZzE9+z1m5KML87BMAonmnTWasm2oH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=yk4WtAqe; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7373aa99e2cso221340b3a.0
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 14:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640711; x=1749245511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BAM5lg+blgxOtU+dzU4+JCJ8A4TZKJftE6piUkwsyE=;
        b=yk4WtAqeQhuteU/NjIRLh5JYALJU8BNS5bqEynw152e/GNIBIew3RRWaABA76OLyPo
         3T+hSGQ4URV8jzvXt1FLBf+rbNizHlzb7dvBtdcFGReiWONPUlnPM68zVIegRcVwEyE1
         eE5VnIoFypeRnShveR/d/+cY1U59fCrNkvNajCilNRBHC5sWt4vvfe+ylw6EYajqjP5y
         KtpimulnFcFREiYehvpi2oSnlyYe8TIKGhUZpl/BgHoQrGniBeW4szBSQ2McUIUXERU0
         g3rFt6PCxS1VL+PGSm3LYW9Pe+8xpIFcsAZVGomy/kTLKVbN+aJsmmwcYlQXtVtZZvhU
         /6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640711; x=1749245511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BAM5lg+blgxOtU+dzU4+JCJ8A4TZKJftE6piUkwsyE=;
        b=Xcl8ri4CTExRsCNvZbOzFKI8shq0ufROKYaQUxuZHvIMonowYFNE4IUAdtwmMek4XI
         hsjimO2Hbj9vaHUtMODOCykgA6QtjJy9qzpl2h2KYaCKHD4xc3e3LrT8IxQVDUKg1SmV
         EQMsZoaVgO7Q18344CA+SP4X1jh+SEyX1T9iW/5CLIw9K3BkhPkzQyDlImYTEBOwxyhZ
         iQnwHiZhsO98f4YGEaXQBI3FRubVZdoFmy7jPt2XPXYXNYcErJKCj4fJ1k2flxPcicQz
         o0sgtf1Yr1c+IGfbqoJz2ucy6QRPnLZt8itM5t4koJ9gsSBBvpWaXkaN2sumYYTNwFYq
         zfTA==
X-Forwarded-Encrypted: i=1; AJvYcCVV5PA3npnArE5zcVZp+A30lSvjUcEih4+rOlc26cZw+HwuiLLmYv3PVcevFW3xkS3opIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi8uK8AKCpQMnZOe+xhD7EMOXPc3iLc4Y7OLE1oKVCbr2tNbXh
	ozqihJ0FOISIEzaKrOv4SGgXzK6O1OHTNGT8jBKdfhRWMuojmef/y1/AyscGjWLz72E=
X-Gm-Gg: ASbGncuGHH8nK5nFANpBLBchhRWC5+FVqh+pHjdpOPxD1T9Ww6916+pgei8KDFWL0o6
	9rnxpgRkMdQvTp6IvEVZlM6ZrY8Q5JsQ/ePDKGeO9ohTfYuDdBalZD4glVdU4xFiL6wbxU9UgFY
	sVhNjkqcxX3lyzaXgiAjvjttlTzYLVzHpaL2eYuT8nIrvgN6GpZcxLU6zxcRqcr5HxEy+t17Z8Y
	N9fNpIjuA8ja68LZ2uDn6CDcDPpZMZcIlsgAadXnzeBGryOWGX4EexHt8KG+HHbnG4RqKmm2YE0
	9l/esxYbidHrhjbWi6WrV+0E6WZA01fybYIYZDY8AKRROgyTtQ8=
X-Google-Smtp-Source: AGHT+IHBVW6zHZbXdRCeFDwfCeuujHxP3drQPytXjUJz9GbgksSkDt6U5SHF4qy5rXyF272ZCySMuA==
X-Received: by 2002:a05:6a00:2e04:b0:725:f1f2:43eb with SMTP id d2e1a72fcca58-747c0ef16e6mr1922667b3a.6.1748640711386;
        Fri, 30 May 2025 14:31:51 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:51 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 08/12] selftests/bpf: Allow for iteration over multiple states
Date: Fri, 30 May 2025 14:30:50 -0700
Message-ID: <20250530213059.3156216-9-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530213059.3156216-1-jordan@jrife.io>
References: <20250530213059.3156216-1-jordan@jrife.io>
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


