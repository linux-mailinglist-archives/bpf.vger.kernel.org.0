Return-Path: <bpf+bounces-58575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B814ABDDD3
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613DA8A0424
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFCD252283;
	Tue, 20 May 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="AplVIkNE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1935E2512D5
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752687; cv=none; b=tCvYOljO5J21GWoqLEoVvULv+S81eU5VFaZyxIeAG1IAau0VG+QD+onPeg/Aj2qSUmJwEFd8hh94zDZy7L76hzN/35SN7rAlJwSEbEfOX5IUl/oKLxXTXtVkBpTc08KwM02xQDa59GiGH4/gUwsxowLxCY7cB8mWW7cOj7bcHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752687; c=relaxed/simple;
	bh=ii0lhnsuHEZZ21rnkBA0wx5pkbY0pk/4pyArG18nLsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8XdI7++SOqfuKY2EPci+3nfpPhA4+D6tsYrYHd3Co2eaAZxwCBTTYbSqlZRhUfhYHPe9ZS5+QZyYK9QTxdfQtRcMQWmUZD5fZab4EmijC9aBFb2p3kuHi8pwIs0UEENqDYqV+rZIgB3lV9RFgzLNpYYIIm2t5Q6ZLJ1EpT//4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=AplVIkNE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-737685eda9aso646993b3a.3
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752685; x=1748357485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=AplVIkNEtVYVX5zIHS73bZQGykJNtQ7WRUszCgiyfYeyI+q4fst9tNKVLhtrJPkMtT
         lisTrYzEI5b97ef6WYgXO14bp6eaK30g5txc59elxIheMDWlsQ/g5QRMga6Kr+WVl6oG
         vIKNNajP3YjO3vdVk0Xu+6gE9n42ZVPjnbJvfVGSydOuE5x3grWIsrNR//l7SybN0oPu
         0ghhcdmn7bjFrXsYYJpd3m8YQjgcQ+Zef0TQoalOvVbtJtjar0KCYc9zBuk4wMnYA0Ey
         96YWYv9L4uzdO/9tFB0xgsCEbyfbtCDU681FiXyX/54Qxr594sugSdfaSdUlwnu5acfo
         Eq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752685; x=1748357485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=rE1KEJ12LIVCl2tAOJHfW5CxcCS2jbWJKg+g9IscrizHn9mkPsK5bfhTpbdkdS+HZM
         GnWVSY4xSbk/KPkKNyfhI3NBkleSCqyejFh3Nf0OXbkotMpih/YstWwSMHHBeB4cLOsb
         TShh+Qq0usvjt6zzQwbPZjMGHiT+5HNDI2HIZwClY6DT8AuWT62d2eRldgrHADTCWrMu
         hdxzQQiwkU0S7K9O3JTTeErrlE+FO244/WCUa2LeB3sqNnMkVakHEUcAV4g0tkvI1JFk
         9/jpebpI0vpKQ8V89Vrqx06zyhBTNYjd4gtf/i5blWNBwkd1uvfM5WqxKLHbCXi4t1pd
         iMmA==
X-Forwarded-Encrypted: i=1; AJvYcCVHXS2I/l4szo6lqrec8IroZr6vDaZw6aaI9ph2zuxA1fhie30OxmpbiYbAuRDVTolVnB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wvn+TU5MY1+/wYVSZm1Y7pEo54cBl7RvDuSk8vhAacpDFERp
	7zLlE0rKP65zXbKB2FOq65NtkdHUMYhfHnGdaWNhL/RdO02+f/OBxRudky1yeWyM3es=
X-Gm-Gg: ASbGncsLh/G6E7jVNptXD0GxlaqZjgwnOH9AykeSGDJPWPIAWuRYSZnxp8azeuFPwlK
	jXg25kbPTOTSXhtKfYZqHdEenGLyH88Z02uC+w9PaZE2S3EHTVpQXlsOK8GBLZvx6FQlATQx0bg
	CfASaKK7uTj6oygk8NFbxhCSodj+pgs4/FeLUv6qQPh1e/0jcou6GmDcbEbQBDOvkZQPtcOobFN
	lqYNrF9j5RYFo5B0KAp0peRGDxPOm0gugsMoBUQ0+8Kf9K2UbR7+HuNB5V13RwsexwOcUk6/uYV
	wC/XGT/d11wAsp9AjucXMToqPXK6dsFE/dK/GX/2
X-Google-Smtp-Source: AGHT+IHjyDiMGErPzOQChwShFJ310J043Ga2vrq37hb9MJB0RLO6I0HeKyUXsiTC1AFSxPfjAHb3pA==
X-Received: by 2002:a05:6a00:4614:b0:742:a02f:ad92 with SMTP id d2e1a72fcca58-742a9914f79mr8414519b3a.5.1747752685361;
        Tue, 20 May 2025 07:51:25 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:25 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 07/10] selftests/bpf: Allow for iteration over multiple ports
Date: Tue, 20 May 2025 07:50:54 -0700
Message-ID: <20250520145059.1773738-8-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520145059.1773738-1-jordan@jrife.io>
References: <20250520145059.1773738-1-jordan@jrife.io>
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


