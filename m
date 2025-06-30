Return-Path: <bpf+bounces-61869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C817EAEE58C
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 19:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B84B3BF7C2
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17DA2BD5BF;
	Mon, 30 Jun 2025 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="fe+oylpc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBBF2989B7
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303859; cv=none; b=KcNoRzigf1q2mC/YAUmPS1Cu7JgyVUn4qUze64CUH8qbReXbAofjdt0m6DsvGOi9LgEPNQzWHr1EAntmL7uVofv3dxQFqHqFgWMkx1ei6d6X4LoijrAu9EvJRyG+PIsiF37GPhBhtEx2iPlFRXsnDe/tJtR77nc/vNnCSLY+SNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303859; c=relaxed/simple;
	bh=mTy8YzU7JSBd81KeNJlEDl5R/G2Y3E8g9DO2QVklRbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQt96yuVRMlfYNHcOyd/YjjI70VO4je0o18qpB5CrCVY9QbEq2caEaLULEQ64SBstX92PSeXWyWyPfEntMymKl0mjLPw+3aVcsDZYQ5+SSNU3mMw1eUY3Gk1M8azqu/2g3sVy3Q0OkN9MMFCAcRUJ8rku40yuBK6HKqEdaBuPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=fe+oylpc; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34b770868dso610318a12.2
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303856; x=1751908656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BAM5lg+blgxOtU+dzU4+JCJ8A4TZKJftE6piUkwsyE=;
        b=fe+oylpczcQ8ubhv7uZuSl5CClPYwuZCkC9zr5frJ6/KZRsqh9JUmwmw5ZT3wNt6si
         83ELTYjN5m7bCUBQLDImsN8Poef9QwrPWZcllVgWSKVUwvx2z2WUEZMFn7joG94nw0wW
         1HkkzW0bn+yPb/KrqD7qkP+j03nBI1micYGz2+fmjMZO1Rz9X7YAcBYn5peHo/gSOLZ0
         hPal80GhTLMtgfGLhKXU3AxCI0PdexwJh7zxJXXuZj79qg/SiPUi/6KsLs0Mp9AVqch0
         WnvVlma76zqf0OBx+KpjxdIOTMyo0/g1RGwH4shdCO0G+5StqFQgjDuxvCnzWIeaKnBO
         3Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303856; x=1751908656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BAM5lg+blgxOtU+dzU4+JCJ8A4TZKJftE6piUkwsyE=;
        b=r/UI9S0YSsOPq9gTKT6gjbYXMil1git9M02ehWvW8VUO28viPMGBJBDWl9QClgDZZu
         kUJbKV5M4WfCvHwDcb8fqneqWq8Q0vS69PTqr8N1YzrQSeuS9zi6G6QPpq01q8cBrREV
         Evt4BqbwDlfPKrf272aTThLYcN8yhmGphKELT2IGSKUYl+wE0a8TRFdkzmAXMNIqb1fR
         5UtxPfChc86LO3I3j3DmINOTIgQowSsPs8LBauspKIirSzi6JjGU96NHcDI56Aj19imP
         dIX1MHX6e0/TfGRiY963JpqwzE6LNeW0flvGbKvZA7rv3RFKNOcvZZVZdfZWZ7Dd9gMh
         e7iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbPCb47rxz1j1+FKSBMLdQNnrz3PNRFVPFgWsjV9jwmnK2x+lbvJXr9F09sP8Kl3RZFdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgfyGR5pthXLEDn9piy9CIwq/Jy6ssh5c2BiKX0LIoEgaOSv0b
	qq1/YHoi3LIveDE2NvMT4rdywYZYT3KtJMCbRRM+RIhrlF4QxrFvl9g0yctaEaPEBIU=
X-Gm-Gg: ASbGncuhvMB50uOKIATcgejG0VoVJrt6vsAErNh8w+7P8UYbj20EVvZk83caKzxs81o
	qohSC4QkwatSgPF5uVYzcdF63ZysAum2SERjOTDxD7NU9Bg91qBlCHSyZM0Zv0RmprNkGA6ahcC
	cpIsXr6oYBIoEElUpPzNd0qyFm75EWBfIxd2EhEr2Sdyn7EQdf+xUK9ESjDa3oPInbB768kdMtc
	sYpsAmtTyAGODa/jgmUn9QStLVJ7qb0yEDZ9vMZmBpiExPm/jTREJvynqt6FdkEwodBHjtYJmEx
	24hJwh7VvrZ9TY2MZJEYkuqM8NFOKD76Xcr8kBFzY7GGJqveTQ==
X-Google-Smtp-Source: AGHT+IFMwcwK1t7p5/FFT6mRdMGxPGWi/UTWEiQonq4y7rWSO3Ri97pYEKqlNRnDgrjiWw31MKPBag==
X-Received: by 2002:a05:6a20:3ca6:b0:203:cb2e:7a08 with SMTP id adf61e73a8af0-220b0544fe8mr6940212637.5.1751303855877;
        Mon, 30 Jun 2025 10:17:35 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:35 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 08/12] selftests/bpf: Allow for iteration over multiple states
Date: Mon, 30 Jun 2025 10:17:01 -0700
Message-ID: <20250630171709.113813-9-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630171709.113813-1-jordan@jrife.io>
References: <20250630171709.113813-1-jordan@jrife.io>
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


