Return-Path: <bpf+bounces-61870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD15AEE58E
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 19:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC7617CE3F
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2462BDC17;
	Mon, 30 Jun 2025 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="sGN8rCf2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F7292B58
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303859; cv=none; b=azMGBUzLtaghYWgyGYinMKumWQtNF4lmKeMxs+S9QwEzmxLh4IpEgme1WlEMh9DpvlAF1DQ1PMaf6k5VDNxwI3dhPOLVkWG3Z0d9yY7w/X/lHq2piyf78NoxNp2HHoduwKjLB/Zv06biUD2Wn/xAS9fp3ZjuEPUqcSwqZNGvhNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303859; c=relaxed/simple;
	bh=eyGkyJV0MLgoYsd401OIgWgj+kW9ZAGeWCSGK+iDlrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K402sHzZLXmmSW4zNBfEPzic6WX7RtEdR+qANpCm58YkfqMGsAVrCNE4jNM1OPehSfAl8awo3Qxe7vGyCc0+eOyJIBta1j0CwDGni0fCseDCl/vWcNRCYHqwSflioUwxBcwtsX4fw4igv/Gyu3Rk6HAf+h7e8E91gvRhQwTeVcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=sGN8rCf2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748e60725fcso410393b3a.3
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 10:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303857; x=1751908657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5NXLyDoYKSOyB9Apg886vIxC4LlUqj7hrcCCh5BYpo=;
        b=sGN8rCf2JtBhsw22Qmi89fWDNunoIP5UmtQTz8k89GWNASKjrRcYfMCba91Q5uoZaT
         xBzETRlzRc4F1ln/5cKDou7/d70sP64w5ZU31ysHB/J0gPyfSLj9AP5/LWqLFyXJo/NY
         5C2OEt2iqkRZ8fkhHMfjttfPuuDQPllg05QCBtNrA1g04ZeobswGeevm5p1kSCK8T9J1
         iAcsHBRKmvBxgn42AHsWYqftStTgLqvEGCBujZ0tDpCuiH/ZL12M6X1jKT8oMsejuvz+
         hUomZ4C1V9iJwaebMZTGCCOh7zadYO3iQycFoxMsoZzHBYUamPVKLNI8oWabL7CCEuWX
         sePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303857; x=1751908657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5NXLyDoYKSOyB9Apg886vIxC4LlUqj7hrcCCh5BYpo=;
        b=WG+L6XzeHu3KXCmGTz0078HBFx/p6sX1c70xA7tGRSrrgL5x0qpn3kuUC8Lll2vqIT
         1VrCV7ojg9BrkNRYFX2wYBxEJjMnp7WNtpzt5uaA5jnuEG+83pir4SHnYR3aKhRUMuJr
         gUitxy7dqZjF8x2jk6bjLn7Mefm/5HbuXK/WDLbqK0f1Oi/f50LP0yzct/rCvO9oFLGS
         4MZFLokq71njC8gVQ4bexS1qzM3Q2VucmrbnMXtoC1yxoX+2LuVR1lRVpNwAp2oYaUex
         fM5XLREZje9/UBgeSFz9UBRPdPJw0EWJ6wkUPdjIYv9O5Lb8CPdxf/YGWIYao+xASL9m
         L2+g==
X-Forwarded-Encrypted: i=1; AJvYcCUed599pff8Y2tnK/Eo5n399XUvjyZZRtXKECRh1B7lFYjqvlPByKKn10/qYfMmYW7pSLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGJ4Z3MyLuJ9LTHHs32DO2KQGc67TFBln+Jz3WsSwtOuMXyuN
	B0FcYnh+/6a7kN2NLE53Wnt6TkCgw7FZqUrixYKs7IDYH5+m0FAHbzowglAfN8sDpco=
X-Gm-Gg: ASbGncuQE2Dsh3dy76ez5NWjvQ0bEtCdO27XBPQLlJj1zrQw8Pzm/WFbK+uSxQniXhb
	XtFqO2gpVmJHBRaJJZe2CUWWCI6lTUhPrSClcIp8Xu+fiCvjuN1OSJioWjPb0r7c/MSe+GeHsmt
	m0afATYS/5RYJM2Uwi+U4k7BJg/wduq6t0txocfrVTbaNshnEvbcr5sb24Xjy6K0tKQ3PJhx+Wy
	JSEXE6YOIvKGYQqXJXoQmmr0DFNIxWs5XDHKMT1IIZ5t/6YVYoTUSurFan8Icq1gD950KucNys5
	hkxK/Z17tHXF8Kn9IA2LiYT6mHH/RSGT0ZuXA8Xhyqts4T+s4A==
X-Google-Smtp-Source: AGHT+IGxIpEBvEshtPIxEArDVOeVWTThj6jF7arS6WPZX4r9eSzcrsoa+UXujbSFQ65T11zHqvQ8RQ==
X-Received: by 2002:a05:6a00:b21:b0:742:938a:3ece with SMTP id d2e1a72fcca58-74b0a68ab95mr4050094b3a.6.1751303856879;
        Mon, 30 Jun 2025 10:17:36 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:36 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 09/12] selftests/bpf: Make ehash buckets configurable in socket iterator tests
Date: Mon, 30 Jun 2025 10:17:02 -0700
Message-ID: <20250630171709.113813-10-jordan@jrife.io>
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


