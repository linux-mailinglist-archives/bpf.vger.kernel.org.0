Return-Path: <bpf+bounces-62529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FD4AFB7FD
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89C21AA48F1
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E6E219A6B;
	Mon,  7 Jul 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="giUqaJDt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CBD2135CE
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903479; cv=none; b=o2QdVNE0T82wdDhgTRqttC7h+NFVQSvc1jKmWQnjvKQs8MhtQ/f0dQMIChiZUuaY1hciVkAnx+SL6/1oPjeE4DhW0IhvdYqzeR0cAZ7CSpoGxWoFcRk5wknhZkIoom8y+TME1eQSGOmhfK3nIDbACzeHvUft+pk6542mv8ExVh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903479; c=relaxed/simple;
	bh=ii0lhnsuHEZZ21rnkBA0wx5pkbY0pk/4pyArG18nLsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyO1nL1Lxv5KFc+Ry4UOQPUDH8G50aCPbAVekYKaTS1NoBBSkpcHgsI0zfpdcDqu5EIx1/6ZbYDHwJAgJOrRVB6gqSRBhsp5kooAqOKxSyKbQ0wlUwaHFWTnC13YraILbSNGXfCrsr7npF2qnRhrg87e4WBYO98Geu3/zOwdU2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=giUqaJDt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235db423abdso2537245ad.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903476; x=1752508276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=giUqaJDt+D6558aGL2nRTNr4tS3EKEcvnjMhWua3Erm24TAYAA/OBI/HEtsHD+E3No
         ClvegUGyB7rCeydyPXopSME6Q1NCZH4oj+S9J09kGOJXuvyqPBEbvxHBE34Yc362zQl0
         2X2EtiZtXVczSgFobwklq6RQg6S79NAgdYSqkQiT0KR6N0OKV6FY/MJcHax6DspPPu+P
         liOtVDs3ajry1/mgTCf3qa5pARUH3LlkioCaKcChcKk7UdAq1Kc9c+h/r0cZyuG0cj/3
         UJtsLqb6hgBi4GSejPjc9QtQzOVRXgocXH8I5DqRqVvPL+Y8n7zT2tE+Rizay5TIcLfb
         a8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903476; x=1752508276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=dKTjtlYTz660btxJg60JRYU3brYDnLDfgtCZ7iv6ZyOr1s3bH817m05stdcDVAGhZn
         8miTlm39omHaAONZS5/gajfePuf2ag/06MaI5oAP71vuO8/57hxy3yp5mYzGTMjv8Fwu
         NcnXEc51B9NtmsXwDh4DFz+wxiUt7FSzNvgZPCFdi7qbprFeEZu+01mhmFGevnOgl3il
         y6xWHDyrdKIsADI1dfu4rS3xd2hv8BuXoND0Nene9A0W4E5X0Y1VMZTeIFgwr6z74Pw4
         t8haLyDN0jWq2vhzYzhyt08Qt3hX3R8C5nIFsAYvwtihjPDtGwIwbBIZ5vY/83hlJgFW
         9wpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDUK4O+eQBFC8jBtJcQArSHSey6uES6MV//qWNMu98En9i2TBTFXkbLxm+FvW5E41IpUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YysvMG+YAtPtqjsq8UVW+FWkff4Ogj4llKYp6r3VnizzIPVBL53
	mEckDAMgWZYh+GK4BL+nxH96d2SgSljCWcOZii99q9PD4B4gI+04WlvRcOT7ItT9i4w=
X-Gm-Gg: ASbGnctyOhsDOmf+vR/7dopUijAN6SgrkXqDw5mFKkk2PFOMKtqzZRzeVQJztZXb1x1
	yZgq3vdJ1N+WkTFqwbzNf+/9u9jvtYdjNENYXbupyBw89o9cYXOtvYaV/zm38K8HIYjlmjT0krO
	nZoWcbndpPexxyfgLyhDjt5lOlYjqGDwv6njQeZ0pLkm83CMTtNcTIUzcVO+2Xtra3RRJcYSHF6
	F0I5wyQIlEqUSpcSNhfZUFWd9XiSuxDzkFEoQtU/gKYzzdTCmbYgGgv2X9zv58NtX6xFxdzFzzr
	JrEntBh/BQvL1I2YLKQyHxaeeWYXgTFNAJ2ixfmJbbwJhchnCbo=
X-Google-Smtp-Source: AGHT+IHw6vqyjMErnWgTqW8VuB0mANsxbhhqZLqj4ip88jNAthOzZgeqLmVWUDX6ixTcy4HMwZvDoA==
X-Received: by 2002:a17:903:2f8a:b0:236:71f1:d345 with SMTP id d9443c01a7336-23c85eb06femr73942495ad.1.1751903476665;
        Mon, 07 Jul 2025 08:51:16 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:16 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 07/12] selftests/bpf: Allow for iteration over multiple ports
Date: Mon,  7 Jul 2025 08:50:55 -0700
Message-ID: <20250707155102.672692-8-jordan@jrife.io>
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

Prepare to test TCP socket iteration over both listening and established
sockets by allowing the BPF iterator programs to skip the port check.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c | 7 ++-----
 tools/testing/selftests/bpf/progs/sock_iter_batch.c      | 4 ++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 2adacd91fdf8..0d0f1b4debff 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -416,7 +416,6 @@ static void do_resume_test(struct test_case *tc)
 	int err, iter_fd = -1;
 	const char *addr;
 	int *fds = NULL;
-	int local_port;
 
 	counts = calloc(tc->max_socks, sizeof(*counts));
 	if (!ASSERT_OK_PTR(counts, "counts"))
@@ -431,10 +430,8 @@ static void do_resume_test(struct test_case *tc)
 				     tc->init_socks);
 	if (!ASSERT_OK_PTR(fds, "start_reuseport_server"))
 		goto done;
-	local_port = get_socket_local_port(*fds);
-	if (!ASSERT_GE(local_port, 0, "get_socket_local_port"))
-		goto done;
-	skel->rodata->ports[0] = ntohs(local_port);
+	skel->rodata->ports[0] = 0;
+	skel->rodata->ports[1] = 0;
 	skel->rodata->sf = tc->family;
 
 	err = sock_iter_batch__load(skel);
diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index 8f483337e103..40dce6a38c30 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -52,6 +52,8 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 		idx = 0;
 	else if (sk->sk_num == ports[1])
 		idx = 1;
+	else if (!ports[0] && !ports[1])
+		idx = 0;
 	else
 		return 0;
 
@@ -92,6 +94,8 @@ int iter_udp_soreuse(struct bpf_iter__udp *ctx)
 		idx = 0;
 	else if (sk->sk_num == ports[1])
 		idx = 1;
+	else if (!ports[0] && !ports[1])
+		idx = 0;
 	else
 		return 0;
 
-- 
2.43.0


