Return-Path: <bpf+bounces-60971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326E4ADF29E
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464804A34DB
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E550B2F0C57;
	Wed, 18 Jun 2025 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="jmINyN0I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067B2F270F
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263961; cv=none; b=DNF5kvdR/kPZZSzwnvbMlHM1DO7vx1pOJDV+TcI9mVedtQQ5mdyUn7X59tYJk9hgOcnDpJTuN74XSlHwsToBcVBPOW5H7QyHzOV19yPLcYxkv2+ESeIrzUyjeVXgtGG23vtDr/cWR/9F9I3mlqSYHv2dkD/ThIQdZdUyGB0zPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263961; c=relaxed/simple;
	bh=eyGkyJV0MLgoYsd401OIgWgj+kW9ZAGeWCSGK+iDlrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K59VmuLA30xNV0psiuOqmdZYgVqFaIowoaVeyKUOhDUroPpHFeX0HaVhsYwb80N+fUlQQ8YJkuYNTl2juFIP5fDIWOsuRFp2aAf2alpnYjdXcsMfHX9A6PWtjE4o1giYZB+3tDdwn7yNM9h4wJAlLkjNjqhWCUFzZMU+At7Mw2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=jmINyN0I; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so907725a91.1
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263959; x=1750868759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5NXLyDoYKSOyB9Apg886vIxC4LlUqj7hrcCCh5BYpo=;
        b=jmINyN0IBriFaLMicJSPCltR3ZmQ6eWE1WB0lRjJbZSOlcvSYXnuuFcFmA5D4HFL9b
         wEzq1ppMezEoYl0oxRzkBKjuXVXO/q4HQSwdIn/G16gPcjBvDoFPgQAmdCrNU97/kuJE
         2kNOQqqTlqYDNNEy+Al0LXhu3gyzI7jJrn3/I9D0PzwKgRnTkvcypiUkSkSOIdCohRnm
         SvCsFoI9PxYonfPEJXFQ5L8YfrgRjS2pYS4R9XCWa1jJ2wI6fJfsPBxDjhbQ7jKpO2EL
         xhfSIjbjrYcX1jJgBLBHXti04xkly9PrJXQGvyZC2S/jpZJ7nubTxNnZEksuYVxKPHht
         fBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263959; x=1750868759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5NXLyDoYKSOyB9Apg886vIxC4LlUqj7hrcCCh5BYpo=;
        b=WS8WV4yyRJJEJylzG8gn1vwZoi+Z0kJ1UjjSt4eC6/XRiDiaedOeCVHbXw0ur28bfG
         nPF49NlA76MUcfGxboN5kbG9IUOeXBiBSHSs3lYLyniat1EomaKMhgv1Pacm7oCk2OUD
         Ire9JUjjWkssO89wjs8BUyeNdoJd2wfy6r94OSscssUf7MxRmmLiu8Y2Y7vkimwzFXYH
         gAEL/tmifcaPzlhc1lJCdOsi4Hkn+k+qcpjO15nHsKT+WLPwb5z4p2uxxfnjh85906wo
         yz6c2hdrcZlL8+SOcyKh2RmAPcZop2cd2KIMz59ZgDT8IoOy6FQF2x7fYC7gW2NgbF0g
         0Sqw==
X-Forwarded-Encrypted: i=1; AJvYcCXwOydIMUenqiYnAjPlf2F0QYhXgUXg2nU5g0bXtyvK1V+Y8fdLfLh5XuKdbIgfWjtqoq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgNo5Nz1ZUv2DxQsldJO9nebT8ubbgZl7/Xas2+Jgil9lJMUt
	+pwiXxhgaSXHlDLU8dS8a1LmhY9I3miUG5qyQ4RNNRkNQsaK/wN85+ZSP6M5yKhxlj0=
X-Gm-Gg: ASbGncszCMGWzRxBvH7wioTV1xuyYtfhg1zwGvA5AKGuQmtuCf1n3gHp07Q2iQjIgxv
	twGK6fRxRUobnYwf/ON3GQpp6/NW3kJtDxQ5p/HCaGAyGIDuH/GquSYUXN4VJZS+y2dXAZpEoKy
	39W8jh9ACW5uJx6sU7VjvxPThTr4pfR+olaCKOISys6Bv+qxnRAiNeChbzvWzsCchh//M12dP/q
	ejzGXRiLz6QFgY1/IZVCadboh860JpQCg9RCaCqmVnXYmi2pPaax0+mPac/+E17dQbEPba0+HkQ
	PT+0J/X4uOI6QyVaAyI2suvas37Bc+IZafueBfMnReDlQp8dcrw=
X-Google-Smtp-Source: AGHT+IFpWn75JZLUIfrHn5UwL/3F+ufyZEBWFUTC/43PQ58I9QlE0n+YWK31cdXSgb8CFrHPYEKugw==
X-Received: by 2002:a17:90a:e7c3:b0:311:b0ec:135e with SMTP id 98e67ed59e1d1-313f1befc7dmr10086577a91.2.1750263959107;
        Wed, 18 Jun 2025 09:25:59 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:58 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 09/12] selftests/bpf: Make ehash buckets configurable in socket iterator tests
Date: Wed, 18 Jun 2025 09:25:40 -0700
Message-ID: <20250618162545.15633-10-jordan@jrife.io>
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

Prepare for bucket resume tests for established TCP sockets by making
the number of ehash buckets configurable. Subsequent patches force all
established sockets into the same bucket by setting ehash_buckets to
one.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index afe0f55ead75..4c145c5415f1 100644
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


