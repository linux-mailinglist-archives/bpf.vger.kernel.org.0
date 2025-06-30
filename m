Return-Path: <bpf+bounces-61868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4992FAEE589
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 19:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02353BF423
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E002029CB48;
	Mon, 30 Jun 2025 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="hAS3WAtw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087EA29A32A
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303858; cv=none; b=LX25MP7b42TeHVJ5tadZg1bmGIWJ1y25llNFjmhHfuwgxnSKuNdBELTN9EjKg9/G/Jt100an64wcLqwug0ClEQtrnLEtsjUIqzBQVkm0gsuciOjXTxt9WSxSe8c/D2xHQvllmT6BgxFCynchnc+2XQ82yoGeZaGoTQKrH3rLfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303858; c=relaxed/simple;
	bh=ii0lhnsuHEZZ21rnkBA0wx5pkbY0pk/4pyArG18nLsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/OXTDx4yInY5Tu2uoO+5OTnD6QC/CUdV0zVciFR+dQE2dfoWGTJ9u5FSTufYBaUjHUUGEoENMG7OrUjHqkc5Gi9LLjt4mgLh9tABXDSYH4RRKg+ehLa8WgjuOV13pkbQSPajwP2H7GsFpLakf7nKzqyOoxPMmVEVD7bxGkw9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=hAS3WAtw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74b013aefbdso237870b3a.3
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303855; x=1751908655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=hAS3WAtwf2zhzQZBEQPmdTsL6FDdhKmv4oE2GQiDxO61XSLdOOBJBO+PmCPU5dZNEA
         J7Ku3a9YdBtMwmejtTJQUhZPSLG+t0Q0fri+XYVgpbwP6pnBM4m+EjZqVmUUk/FN2AHN
         OcvlAJabtf+hfCDJmu9yTLVGHInlMhKbmavyE9n/VXCB1Vrr3ayGLuX29tVpXFLnOrvz
         Shqwp6loCgOniTarI1L5lTs8k4BmmyIkmU+OEUocTwZXK3dqCIWj1qlFTquX+1NRlVn0
         ceVtwQS6A766lqSBCta54Eaq5g+WDmA6MUS1qr9YBZ4rXuoIcY38FOgjnzP+d6hR0bCd
         1pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303855; x=1751908655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=WTs/QuZFb3hMqU3TG44qSLJHj8ltTwyWCh8TSf5/GeGFAwkKptfMK04GiAnRbVjvQY
         laL0FfiQMA6kfFmlSnVUGzpw6CuLZ1lNRwkFXXl99s4rlj9i4Msinz/gU1njTMDMUgOL
         OGv7Ooqj2RW+G8hD69y7a3N3ye6MppP6cuMfVnt8+vgkU+55VAKVkg1JmJ9LNX2mVHtH
         AnuGV3FiFOwQMeqEQoRYV/y4KpKyn3ReoxR8quKUl1c+eGnSU1BKwPEUW3eaV7aKK8GV
         VSXWKRRNeDjXAROGZuZwN35hMpIRGUsDNnYYhU7dg5bZzb+HwQ/NW5WE+XPHsTgOjZkI
         R9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2f0R8PpdnEs2nmwtOnDKBFPkp8M7QedEKK9Vt9S9Kw0NGPX8fq9EQxICbdlni6O/pYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDjCerl1oqylf8sJZU6s/wrL0mGLTYYOQf2sd65NyQenQSl2z7
	McjlXcPAX4JEnoR0STu7r2aqhMUrLYBltsvK/6bF+bLrFrnHXh6E8sN99H26rpw41BY=
X-Gm-Gg: ASbGnct3xVGmN163ge/3Av4Vm71txLxTwQl6/zHGJWdaFJaarrull9EC1XNqGg86aUA
	lSkR8btsEFXSvw6GA7iKWTF1rDJn0K8Ok/1WN0LH60uAJvSDl9Yk1iMRxBd7OXlAbU05c47YEDT
	XdGzSXzMNes4+e+2bQmdU9Mi8OXvRAe5miz9SmSB2fLq/smj5o0c5SRwyPROKZkuM841/BNuKQv
	DoKkygcmSTiaJbeyLyOBvHXy0QMfKdgR/ykfr3aGaEuhmzoAlcn3B3EOYhokEwVxEDcyCWCGJbZ
	fSRS9NdipFtQ8TmLQ0xfvMHWuN4JkS7CmIe+UHEgrCfQB3cS5w==
X-Google-Smtp-Source: AGHT+IEkYRs9Mil95rXqk8ouGDLwzPDeoXogbPbN35EoOeaj+KTPurJHSRcfKcD85qVJFy+i9waSsA==
X-Received: by 2002:a05:6a00:330b:b0:748:cee2:fa53 with SMTP id d2e1a72fcca58-74b0a39a331mr4692976b3a.0.1751303854780;
        Mon, 30 Jun 2025 10:17:34 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:34 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 07/12] selftests/bpf: Allow for iteration over multiple ports
Date: Mon, 30 Jun 2025 10:17:00 -0700
Message-ID: <20250630171709.113813-8-jordan@jrife.io>
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


