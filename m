Return-Path: <bpf+bounces-63232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAFDB04733
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 20:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B21165FD4
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBEB2701D6;
	Mon, 14 Jul 2025 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="oFdtf7cY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C026FA6C
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516580; cv=none; b=cZKUEH2NPLxxBhFRa0TVMQcJAKu7N6NI5MHKXJy9U+CJW6WI2omSCEzHemKgRFEiW4Fy6fEJ2zGFqqo8l9Mbo9CIo205cEvTaqtjDfhqU14nFFo0PwSY50Jh0bl6KV76s9mvvuQum47o4dS3qth4UytDTTpKhkOt1okM1bg0sTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516580; c=relaxed/simple;
	bh=fyehYhxa8G/73wUbDFErCIWrrsV+XEDbPV1wHnsjius=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RA4R6x/hyQKYTKJkHE79h5ykOKQqjLjk4gKkkAZE+jRGRer4y+rJ9jd+EnPVXcukGjFvlwEdCgbLGCf7k5O/XspBEIEdJBC3EWPMZVYTkGL+0vA+lQ3xZvqjxEL5L/ZePl9133vUmw0aILt9G7DRy2OG8gTNBYGJrmoVsL+p/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=oFdtf7cY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-312efc384fcso721410a91.3
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516578; x=1753121378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXWCQ6+3YVI5NTJDWePIBPW7AX78zEDasUFUwt2Y1Ps=;
        b=oFdtf7cYOca6OkNCRe8WNDlBF5EeswW0Y3hJIcmUxOJfDQSGM280KMSY9E6HZwCL1w
         DcvbHfyh8DAOemRAPPe4zgCniioXgEg/1RS5XhwradCsatYH2jBK2jK534UIPHDVRile
         vMf3lPO9znizUNht8Rfb+z0BJcljPKnaD2ytbVAfGSCUR69aYNbUqU/Q41zopYr8PhKN
         pR1s4AObGpePaEsbIC8zxMN/vIZ4Qwfzd99st4TEPv5qkXAmQXqjQicDd5qIvIZvQVif
         Q0HXGESFY6riPZn4vTNGpkY35vGZW8Pz5JE0LdxBNSUgESx4O5YpO78TQey7j+lC9ICK
         cz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516578; x=1753121378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXWCQ6+3YVI5NTJDWePIBPW7AX78zEDasUFUwt2Y1Ps=;
        b=i2NbJotVoCGsry0tZteqYU+FncEMeReicdIJ/RzO8UFODcthDmCtUm9EB67kzSzI3T
         wvEF3KiFT66lj98y3LeiOI+sUqKcujRM5l8tdUUktgFM3vgFqbjvNkI2FthEMyJxaydF
         QkhAPvXbGsZFup2DXRo5uJDFafBm7Q/cB05Eu9+8rnxn/lMEYBWWMLm7Se+owrBroo/v
         ZqZIghogNlSIePwdcA/AKKQ9Dvkf1tMTqTEdQeo1BhKe5q+AlMJdNCuHaRCGvkMKkCx/
         SK2POODyeSI5qfSz+pJx4iGNou5+mrUUFT7zfK6o7JwJX8Ybb4+Uw6EppUkU/Z1NNIvv
         iWiA==
X-Forwarded-Encrypted: i=1; AJvYcCWS6pkNdVyzo0DvbZVqCM+rE/RvOSjgKpRdf6YWGVWL0JzeIbgoeiY1okYAr2Wp7U9qeio=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywel3FoizD8Hu3ebsQf6UCxgezUbLlxzvUqqiNSeirGUIyErH0H
	BzoCL6rTGLfIeEwX53OYBuH5TGXhcMVGNYQ8KNz6j1CVW2bUe6EPi/o8za+0nUn7Xjo=
X-Gm-Gg: ASbGncsLK3NxrILqplViPbDXf4+YcWTO0p4XCX2P05lPm9kUp+RjtF4ax9jjpd1Mzub
	HnFFArnxYgWIeEHuuWY/fflILxp3+f+sb9lof0/VxkgbQl+6GQhTFMdc8bG7JM/pO/6HFRoc32D
	7Xa5gMpCzOBg6081J7/onmOfM1F6XcTXnKVN9rxMKW8DM5RsIlD+/IPvD1NkQscWzzr/S6oLz2Q
	2C8SEmnQ0giJwXFy0Sp17lyN8QxTWkI14oQmiTV2n8KaFTeLLvVOX0Gx87WsbTUxO98qPJvHEv1
	Nunq4WAQAXODubBn/yRwtbM7IN2T8STfp7muK05g5LEHWJra5BUfHhVs9tcYvXCBP0t2GrN9XSq
	bvLBaorsElw==
X-Google-Smtp-Source: AGHT+IGXnCXY0SJ8XtvGXcBE0dPm7Nnobzqumz9CcM9LYAnWX8nfskuvLXkD6BLfjhB9jzhyBkLPyQ==
X-Received: by 2002:a17:90b:3cc8:b0:30a:80bc:ad4 with SMTP id 98e67ed59e1d1-31c4f37b71cmr8007503a91.0.1752516577797;
        Mon, 14 Jul 2025 11:09:37 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:37 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 09/12] selftests/bpf: Make ehash buckets configurable in socket iterator tests
Date: Mon, 14 Jul 2025 11:09:13 -0700
Message-ID: <20250714180919.127192-10-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714180919.127192-1-jordan@jrife.io>
References: <20250714180919.127192-1-jordan@jrife.io>
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


