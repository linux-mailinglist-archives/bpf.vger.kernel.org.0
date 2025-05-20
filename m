Return-Path: <bpf+bounces-58576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3123CABDE40
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 17:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D714E5765
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2532512D9;
	Tue, 20 May 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="scn4PKKr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31124BD03
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752688; cv=none; b=toDd9kSPzWDugvc/1rjxayg44AfsCEg5a0AJb52RkikSpPUbBj8CRFA4WHo6pt/xwgZ3Je2KnIugvIdzoLdxzLb0q32i1eMbGtfQEXarsyHDjTcCU5WGW/x0BibweYmAuVbG4Bsw0VcieXo6FCo7udy5paelDWQ1kQMnWuf/2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752688; c=relaxed/simple;
	bh=rP1K+5z0WkyIl9Ea+9Y4nW7xP4x7P5Cd18KG21Jb6hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZOhQVhhGU71nJNBAwtDVWhVnlnjAUusCH8NxbN8AfWnG+MChEoJxxgJgo+0njzgommJZUAsBRuspRlmD6KROnKiB1VJJSDklhSIF/IcfNGP+7Q9zDMuqwUCeP4+7/UW3u4ohBShLHkeUNFP7Slx1szUbkYHP3qN7cdmZvw1Vkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=scn4PKKr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c1145a38so494538b3a.3
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752686; x=1748357486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRf1+zTuaTm7zQYa3U31C9Gp9YgahFqNmFp7ck+nv4A=;
        b=scn4PKKrFCk0SZskLp7K3ifi7Trn+9TOw/t8lMTh1e3W1GO4SN3tImiouGQvrdURXM
         gkcmh5dW6fsRnE3LmRS9rZlQCH89hspWnlEQKlxCdJd7uaSvDNi0GT3Yx3xeEQkKjvTD
         FXqIsDuGhZtrVs78zIaF8l0ZP4+ij4a/ev5IIUUDXyr6aMPbGkLUaQQs0hscmSl8rrbt
         NvgO42W4ShjBRqJtFUWf4OKEdVo92cLrXFk2yJYxk7yWIB+u7LvxlA9+/BgUAeeg5FXh
         DtXamuk7utvFVQLfJd2RaffYXyJGQNhzOh191eeivFNnQ209wBnYBDsj12+OJ0vZQxAQ
         cNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752686; x=1748357486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRf1+zTuaTm7zQYa3U31C9Gp9YgahFqNmFp7ck+nv4A=;
        b=TVfNmxLYUnldbkQXl7qmR2hKsSTq0AMmnJWHyrYp/p31FoGkDXlAGxl0Jbbr0Hd1up
         KKQaInYG0wkp4eAACYvAdr/MzRWS3EJaSzmclt750msJFELKfuJHh0IT5Zb0jCvMsopP
         WYK9FACSAZHteobg5KDDcgSE7/B9eSERNUZynQMPRnKb93o4yHr5q65NG2sM8rSwic67
         xR3HHhdyN3a/nARAWcnn+L5prmR2bUZovCUW0Gz6su/9Xm5EIas8rl5Z2AuBUZgVWXRr
         kJW15BHB+IMFtoYUX/GHBxgaRaStDZLuzP3EDDKhjmF1Kh/3o5GCpM0F8nMRfEONCgou
         MwLA==
X-Forwarded-Encrypted: i=1; AJvYcCUKoL4yMU+qc7iFMWERAl0HqfzaEpNGCvZErh6YK6hsqx9UcNxtV2oowGrlKBl0AKicOTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zaErAHuaLp369RSf6qWIhVSKJJfuxGsN8PLCP397V3IRgg0n
	PViIxTIoXYliS/FE6SUu/8SzkT50UQNbDnvTicYzTZQuINRtN/LDi3cO0X5VJOCSszQ=
X-Gm-Gg: ASbGncsbFenVozSG96pmgUbHmylzJ+TYZtUQA10HqQuuVK4VMdM3wSNxNzYpPFYFlSr
	zvOMjts26tGrFOfDRPLQj8QvAvHO6lzKQKhFaERQGFYAdUmUreiZJFrUUGIm0gc1VvDZW/xpMbQ
	2D6u1l05pXNQIUZk2I1pmlS0ZGiW/BFmc4hKVxL6ezc3XDWcQpNSUwaIZI8xIPRWDgS5KY5Sfqb
	lTEZ/GHqi0WVLI9DmAaVGTvPnlShuGVIvHwz/YOjTXaUEKMhS+dq5z+zVsz6TocjOSdCIHEMTgG
	X1g1+OI6AGfi+74lVQy+3nQDdSuA4NVbV4FlDvgB
X-Google-Smtp-Source: AGHT+IFdYoPD1Lm/9btF2ctXHiZev9mr0WdDH2zpF6+m5hhAKCkrLzdHSl4TLfoIS4zM9LupKDHV1g==
X-Received: by 2002:a05:6a00:4b10:b0:730:9989:d2d4 with SMTP id d2e1a72fcca58-742a987d7b0mr9607168b3a.3.1747752686609;
        Tue, 20 May 2025 07:51:26 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:26 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 08/10] selftests/bpf: Make ehash buckets configurable in socket iterator tests
Date: Tue, 20 May 2025 07:50:55 -0700
Message-ID: <20250520145059.1773738-9-jordan@jrife.io>
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

Prepare for bucket resume tests for established TCP sockets by making
the number of ehash buckets configurable. Subsequent patches force all
established sockets into the same bucket by setting ehash_buckets to
one.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 0d0f1b4debff..847e4b87ab92 100644
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
@@ -452,6 +466,9 @@ static void do_resume_test(struct test_case *tc)
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


