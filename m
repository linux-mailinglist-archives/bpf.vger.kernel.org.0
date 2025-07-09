Return-Path: <bpf+bounces-62856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED41AFF531
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DD85C1F5D
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BCB2505A9;
	Wed,  9 Jul 2025 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="jjO061Q+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659752512F1
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102230; cv=none; b=XEb9N3c3ygScMPsosdXqjlUnXQ0g+Nmx0dGYGwMp52hvP0oER4EZnCnX0if5lFEudzotZ6EO3Subem7gf7pK+RE3qSeby66ELl2cTHDzH8ZbhZLxywH27+jfY1jrSncs9oJKahQUT0171i+r4zt29ePE1+AIhWHjH57dFfK838Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102230; c=relaxed/simple;
	bh=fyehYhxa8G/73wUbDFErCIWrrsV+XEDbPV1wHnsjius=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDWcdTmXc3CcWZUu4pedPix01HTeUlrwCX2vumRJhOSS//liW+VaZWlSRy4YKfv/3ayrhH8gHYgtKqtl9xbZmom6pUyZli/VG48f8ICmoIldwrvY2E537gokuvjYxO7UsFJmur5mKTwaBUkylSkDw+VlUwEXaD29y2d940owpSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=jjO061Q+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3badf1afc0so35530a12.3
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102229; x=1752707029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXWCQ6+3YVI5NTJDWePIBPW7AX78zEDasUFUwt2Y1Ps=;
        b=jjO061Q+tf6Xc9xGhb/+2e9TTa2MsWoJs8jbjpcfEGn6Hi4DtdQMjRRiFiRnjNPXJa
         PX3JdMtONGQJ4tSq89JMrng+iLLToMKUtQpoDY055r/HL6zlV5YTulUOMCwz2iZZesA6
         WbMQqtH1HzbxvXZZiy5aQERnEojHPSBZcn8cKyRO4JXeiJuRZqj+JvT0/ddo2Dm0/kkB
         NAED8wgJR2TjKgQLHr74ULUJsKvz7yrrhm0YQ2UVFhaXGGdGnJ/W0HLqu8Y5g1YRiZu1
         /dgQdpDM4lqfOYfwXiZ6b7eS71KuS1j8qfz+t7z+AqajqGSsl7xw+/bfarSOirUWGPLh
         4XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102229; x=1752707029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXWCQ6+3YVI5NTJDWePIBPW7AX78zEDasUFUwt2Y1Ps=;
        b=ZWUcC5+oksdVtFbNkX3QGt2JxxISWDjuwNMiyskE0hvYhKaNupa0to8BnAF0DFT6Lm
         xJ+ofVYIINaPlUpXBRzNynfHiG4nKi0OLgesdg60jx3Wae0jpid1l8dUbYfmWl5H+a+z
         vY7Sqfy+MNjTZo+KyY1O1p0KcGaGTviB1eyI02SBKmMcOntydsnpYm2oIUQzMmFIpNLg
         77sH/YZQ5PxCT72bF4bJOgP0ZBA+H69o87V4DyFYVC2wwKk17QhM2sIIXEE7kaExNVii
         FNbm3U06aoYl3bVUHJohoyv7GxBh62ars5eAjqtM5J/2PlYYIl85Rx/LNNx7/1hAKVua
         KLQA==
X-Forwarded-Encrypted: i=1; AJvYcCUd5gZFaWzvma1p9Ink5UUUQKEzpTJ0DkoUNiUUc8T6wQUr0cUzQvOvjclWQtsjnjGr17E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZpfoEnQ5j15t0Iiage5WVk4aBS7En0K3zbwMKJMxheSjdE+t
	+bLR3z/3D7hfwPweW6z7AhEGGI8fND7BnauNUO1Cue1IoQV/CptJjMiZgmXsIx1eIGI=
X-Gm-Gg: ASbGnctsTTgCByS7dHyJ12zSVsoBVOF/YSIwFTAPxShQTrDjcY3KYvZH7/PKgTXedPK
	mfN8ftJrrQ4SKAO6rbsSoCMhxMipzNCP5X4KX4nE5AknGWlJC44ZPLyhZYcxGHyq4k7+tmxIFDa
	tWO6uzqxr6FaIoElr8TyaNFlk8RGX/E+ue3AfTyFaZEAyHKSgESNw+cJkUcea2rJTSIrp1psG6E
	0ZXP1E2jCEOa4Pe6CArmYlRMmsmHtEA3uBHv9y3s4XG3NECcOK+fgIHkNNOXyhLd4qvZ7568xsl
	DSRlyMA2mYg3tV3eQcHx4JanK73PiBpKMZTbFjIHZQT/gzezgShXXlEWzyaZVA==
X-Google-Smtp-Source: AGHT+IEWAdiUDs5g926cP8tWYJdNVbl5nnvra6DFvJDYdEf6w3yE+A/qoGBF4Y/4gU/LcnR2+MA05A==
X-Received: by 2002:a17:902:d2c2:b0:235:f1e4:3381 with SMTP id d9443c01a7336-23ddb1bafefmr25687215ad.8.1752102228737;
        Wed, 09 Jul 2025 16:03:48 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:48 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 09/12] selftests/bpf: Make ehash buckets configurable in socket iterator tests
Date: Wed,  9 Jul 2025 16:03:29 -0700
Message-ID: <20250709230333.926222-10-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709230333.926222-1-jordan@jrife.io>
References: <20250709230333.926222-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for bucket resume tests for established TCP sockets by making
the number of ehash buckets configurable. Subsequent patches force all
established sockets into the same bucket by setting ehash_buckets to
one.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 4e15a0c2f237..18da2d901af7 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -6,6 +6,7 @@
 #include "sock_iter_batch.skel.h"
 
 #define TEST_NS "sock_iter_batch_netns"
+#define TEST_CHILD_NS "sock_iter_batch_child_netns"
 
 static const int init_batch_size = 16;
 static const int nr_soreuse = 4;
@@ -304,6 +305,7 @@ struct test_case {
 		     int *socks, int socks_len, struct sock_count *counts,
 		     int counts_len, struct bpf_link *link, int iter_fd);
 	const char *description;
+	int ehash_buckets;
 	int init_socks;
 	int max_socks;
 	int sock_type;
@@ -410,13 +412,25 @@ static struct test_case resume_tests[] = {
 static void do_resume_test(struct test_case *tc)
 {
 	struct sock_iter_batch *skel = NULL;
+	struct sock_count *counts = NULL;
 	static const __u16 port = 10001;
+	struct nstoken *nstoken = NULL;
 	struct bpf_link *link = NULL;
-	struct sock_count *counts;
 	int err, iter_fd = -1;
 	const char *addr;
 	int *fds = NULL;
 
+	if (tc->ehash_buckets) {
+		SYS_NOFAIL("ip netns del " TEST_CHILD_NS);
+		SYS(done, "sysctl -w net.ipv4.tcp_child_ehash_entries=%d",
+		    tc->ehash_buckets);
+		SYS(done, "ip netns add %s", TEST_CHILD_NS);
+		SYS(done, "ip -net %s link set dev lo up", TEST_CHILD_NS);
+		nstoken = open_netns(TEST_CHILD_NS);
+		if (!ASSERT_OK_PTR(nstoken, "open_child_netns"))
+			goto done;
+	}
+
 	counts = calloc(tc->max_socks, sizeof(*counts));
 	if (!ASSERT_OK_PTR(counts, "counts"))
 		goto done;
@@ -453,6 +467,9 @@ static void do_resume_test(struct test_case *tc)
 	tc->test(tc->family, tc->sock_type, addr, port, fds, tc->init_socks,
 		 counts, tc->max_socks, link, iter_fd);
 done:
+	close_netns(nstoken);
+	SYS_NOFAIL("ip netns del " TEST_CHILD_NS);
+	SYS_NOFAIL("sysctl -w net.ipv4.tcp_child_ehash_entries=0");
 	free(counts);
 	free_fds(fds, tc->init_socks);
 	if (iter_fd >= 0)
-- 
2.43.0


